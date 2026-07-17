Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E560C44507
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 10:58:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6CA6010F50B;
	Fri, 17 Jul 2026 10:58:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="J8mW7SXT";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5475B10F530
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 10:58:12 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B5B9560204;
 Fri, 17 Jul 2026 10:58:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B1F71F000E9;
 Fri, 17 Jul 2026 10:58:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784285891;
 bh=c5cdSPUwBUN1XT+MhtslSAwnw0YVT4o5P8GH42rUT5Y=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=J8mW7SXTbRBmTIs3G5trCj3PJJu8J7jhdB2A+QNULAqhldOsG+I2TQMEhSqHNkXA5
 eJBTJBwfzo+ELPsKD5uw+dO10TpOS450H6D/QQIoqsVIqwvBPoPEAmlSgW5gOolwik
 7YkJ9bloR5H4zLNd/4WExiZt1OHcR7nV8YVgEF2uehihgDS+RBAVKcjuPNMxUVzjEC
 0Iu0+tg6Kr7O3RH9X3fn2KYYQeC7vmDYdP/se0ftOMzrDYat8ETmULl0Wpssis78aU
 PjXJoJ0+v72ZfXfkuY4zBXlX3brf3yutbVHJCe6N0TfTOwO1Zr5NO5Acjm60ETGn5r
 jQfCdZDgjHQ4A==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v1 5/8] misc/arm-cla: Accelerator context save and
 restore
To: "Ryan Roberts" <ryan.roberts@arm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260717104759.123203-6-ryan.roberts@arm.com>
References: <20260717104759.123203-1-ryan.roberts@arm.com>
 <20260717104759.123203-6-ryan.roberts@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jul 2026 10:58:10 +0000
Message-Id: <20260717105811.4B1F71F000E9@smtp.kernel.org>
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Heap buffer overflow due to unit mismatch in internal accelerator =
state (IAS) memory allocation and bounds checking.
- [Medium] Incomplete context save leaves `regs->accel_valid` as true, lead=
ing to corrupted hardware state on subsequent restore.
--

--- Patch [5]: [RFC PATCH v1 5/8] misc/arm-cla: Accelerator context save an=
d restore ---
commit 96459db186d7c9fdaf43a3521dada1e5846d6b74
Author: Jean-Philippe Brucker <jpb@kernel.org>

misc/arm-cla: Accelerator context save and restore

This commit adds helpers to save and restore CLA context for later domain
switching. The saved state includes DATA registers, LRESP, per-accelerator
SRSTATE, and internal accelerator state exposed through the IAS register
window.

> diff --git a/drivers/misc/arm-cla/cla-regs.c b/drivers/misc/arm-cla/cla-r=
egs.c
> new file mode 100644
> index 0000000000000..7507796cd551f
> --- /dev/null
> +++ b/drivers/misc/arm-cla/cla-regs.c
> @@ -0,0 +1,263 @@
[ ... ]
> +static int cla_regs_save_accel(struct cla_dev *dev, unsigned int accid,
> +			       struct cla_regs *regs, off_t *regstate_off)
> +{
[ ... ]
> +	regstate_size =3D FIELD_GET(CLA_SRSTATE_0_REGSTATE, srstate[0]);
> +	if (WARN_ON(*regstate_off + regstate_size * 8 > dev->iassizes))
> +		return -ENOSPC;

[Severity: High]
Does this bounds check correctly handle the units for *regstate_off?

*regstate_off is incremented by regstate_size (which is a register count),
so it is also a register count.

If dev->iassizes is in bytes, this check improperly adds a register count
(*regstate_off) to a byte count (regstate_size * 8) and compares it against
a byte count.

Because regs->regstate + *regstate_off scales the offset by 8 during the
memory access, this check can pass even when the access goes out of bounds.

For example, if dev->iassizes =3D 160 bytes, *regstate_off =3D 20, and
regstate_size =3D 10, the check evaluates to 20 + 80 <=3D 160 (passes). How=
ever,
the accessed memory is at byte offset (20 + 10) * 8 =3D 240, overflowing the
buffer.

> +
> +	if (regstate_size) {
> +		ret =3D cla_op_regread(dev, accid, CLA_REG_IASn, regstate_size,
> +				     regs->regstate + *regstate_off);
[ ... ]
> +static int cla_regs_restore_accel(struct cla_dev *dev, unsigned int acci=
d,
> +				  struct cla_regs *regs, off_t *regstate_off)
> +{
[ ... ]
> +	regstate_size =3D FIELD_GET(CLA_SRSTATE_0_REGSTATE, srstate[0]);
> +	if (WARN_ON(*regstate_off + regstate_size * 8 > dev->iassizes))
> +		return -ENOSPC;

[Severity: High]
This appears to have the exact same unit mismatch issue as
cla_regs_save_accel(), which could lead to out-of-bounds memory reads when
restoring accelerator state.

> +
> +	if (regstate_size) {
> +		ret =3D cla_op_regwrite(dev, accid, CLA_REG_IASn, regstate_size,
> +				      regs->regstate + *regstate_off);
[ ... ]
> +int cla_regs_switch_out(struct cla_dev *dev, struct cla_regs *regs,
> +			bool save_regs)
> +{
[ ... ]
> +	if (save_regs) {
> +		for (i =3D 0; i < CLA_NUM_DATA_REGS; i++)
> +			regs->data[i] =3D cla_reg_read(dev, CLA_REG_DATA(i));
> +
> +		cla_for_each_accid(dev, accid) {
> +			ret =3D cla_regs_save_accel(dev, accid, regs, &regstate_off);
> +			if (ret)
> +				return ret;

[Severity: Medium]
If cla_regs_save_accel() fails here, the function returns without clearing
regs->accel_valid.

Since regs is allocated once per domain and reused, accel_valid might
already be true from a previous successful save. Returning an error here
leaves the structure partially overwritten (a mix of old and new accelerator
states) but still marked as valid.

If the caller handles this switch-out failure non-fatally and retries the
context later, will cla_regs_switch_in() restore this corrupted state to
the hardware?

> +		}
> +
> +		regs->accel_valid =3D true;
> +	}
[ ... ]
> +struct cla_regs **cla_regs_alloc_domain(struct cla_domain *domain)
> +{
[ ... ]
> +	for (i =3D 0; i < domain->nr_devs; i++) {
> +		struct cla_regs *regs;
> +		struct cla_dev *dev =3D domain->devs[i];
> +
> +		/*
> +		 * The regs structures are only ever accessed from the CLA
> +		 * device's CPU, so try to allocate them on the right NUMA node
> +		 */
> +		size =3D sizeof(*regs) + dev->iassizes;

[Severity: High]
If dev->iassizes represents a register count rather than a byte count,
should it be scaled by sizeof(u64) here?

If it is unscaled, the allocation for the flexible array regs->regstate
will be 8 times too small, leading to heap buffer overflows during save and
restore operations.

> +		regs =3D kvzalloc_node(size, GFP_KERNEL_ACCOUNT,
> +				     cpu_to_node(dev->cpu));

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260717104759.1232=
03-1-ryan.roberts@arm.com?part=3D5
