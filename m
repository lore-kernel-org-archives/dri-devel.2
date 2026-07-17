Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6B06C44514
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 10:58:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E283510F50A;
	Fri, 17 Jul 2026 10:58:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="VURfqRi8";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 056F610F50A
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 10:58:48 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id DAC7B41202;
 Fri, 17 Jul 2026 10:58:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93A7E1F000E9;
 Fri, 17 Jul 2026 10:58:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784285927;
 bh=MKABku1f0dh9Pj9SmQJy2UaCucJRjrhtiFRewHHWm6Q=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=VURfqRi8NrdMsTcHJfBdqZ+/AdlTwXoZ5kF+CCT4a0zHwXzkqosHmFSBG88YkrJcx
 PO8uAMMd+UjJ/bLpTFFgaf93w0rIblBAk0hp1FisJ5rZ/M59Qr/bkz11Sli6TdYQ8C
 2VV3srWXWeEAVCq+Yyj4083fpwR8CYN5PDD1tyDbP7KwFos5nDJs2018J/ZRRxAkzy
 0cUmPLhtQtm0whJtrUhRSADYdhR9raOnoB8/wS0AvZLNLZIMxlpADz6xfu7oLSooVo
 ayaI6LYcDfwF2uLvu+yYWb5sLz+lkh4GO+xGfcv45BSUcl/HudBJzoxTEfdeZsnlkU
 FwA3oEhJgTeBg==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v1 4/8] misc/arm-cla: Initialize devices on CPU bringup
To: "Ryan Roberts" <ryan.roberts@arm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260717104759.123203-5-ryan.roberts@arm.com>
References: <20260717104759.123203-1-ryan.roberts@arm.com>
 <20260717104759.123203-5-ryan.roberts@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jul 2026 10:58:47 +0000
Message-Id: <20260717105847.93A7E1F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

New issues:
- [High] Incomplete hardware reset in cla_op_reset_all() aborts on the firs=
t failure, leaving remaining accelerators running during teardown.
- [Medium] cla_reset_ts() incorrectly uses cla_op_regread() to configure th=
e TSOFFOWNER register, clobbering the setup value.
- [Medium] dev->accelerators mask accumulates stale state across CPU hotplu=
g events, causing false device failures.
- [Medium] Missing explicit clearing of the LRESP register in cla_dev_setup=
() despite the code comment.

Pre-existing issues:
- [High] Integer overflow in cla_op_access_reg() near the 32-bit boundary c=
auses catastrophic underflow of nregs and out-of-bounds memory access.
--

--- Patch [4]: [RFC PATCH v1 4/8] misc/arm-cla: Initialize devices on CPU b=
ringup ---
commit 9a23e1cd42d86f5042ad1e97cc30851dba6b1e3e
Author: Jean-Philippe Brucker <jpb@kernel.org>

misc/arm-cla: Initialize devices on CPU bringup

CLA registers are only accessible from the CPU local to the CLA, so perform
device initialization from the CPU hotplug online callback. Clear the DATA
registers, reset each attached accelerator and verify that it returns to the
expected idle state.

> diff --git a/drivers/misc/arm-cla/cla-init.c b/drivers/misc/arm-cla/cla-i=
nit.c
> --- a/drivers/misc/arm-cla/cla-init.c
> +++ b/drivers/misc/arm-cla/cla-init.c
[ ... ]
> +static int cla_reset_ts(struct cla_dev *dev, unsigned int accid)
> +{
[ ... ]
> +	reg =3D FIELD_PREP(CLA_TSOFFOWNER_PL, cla_kernel_pl);
> +	ret =3D cla_op_regread(dev, accid, CLA_REG_TSOFFOWNER, 1, &reg);

[Severity: Medium]
Does this code mistakenly call cla_op_regread() instead of cla_op_regwrite()
here in cla_reset_ts()? Doing so will clobber the newly prepared configurat=
ion
value with the current hardware state, meaning the kernel fails to claim
ownership of the TSOFFOWNER register. This could cause the subsequent writes
to CLA_REG_TSVOFF and CLA_REG_TSPOFF to be ignored.

> +	if (!ret) {
> +		reg =3D 0;
> +		ret =3D cla_op_regwrite(dev, accid, CLA_REG_TSVOFF, 1, &reg);
[ ... ]
> +static int cla_dev_setup(unsigned int cpu)
> +{
[ ... ]
> +	/* Clear DATA and LRESP_DATANZ */
> +	for (i =3D 0; i < CLA_NUM_DATA_REGS; i++)
> +		cla_reg_write(dev, CLA_REG_DATA(i), 0);

[Severity: Medium]
The comment above indicates this should clear DATA and LRESP_DATANZ, but is
there a missing cla_reg_write() for CLA_REG_LRESP here in cla_dev_setup()? =
If
left uncleared, stale response data from before the CPU was offlined might
remain and confuse userspace or the driver later.

> +
> +	/*
> +	 * Reset all accelerators. We restrict PLxCTRL to the accelerators that
> +	 * are attached and well behaved.
> +	 */
> +	for (accid =3D 0; accid < CLA_NUM_ACC; accid++) {
> +		ret =3D cla_dev_setup_accel(dev, accid);
> +		if (ret > 0)
> +			continue;
> +		else if (ret < 0)
> +			goto err;
> +
> +		dev->accelerators |=3D (1 << accid);

[Severity: Medium]
Could this accumulate stale state across CPU hotplug events?

Because dev->accelerators is never explicitly cleared to 0 at the start of
cla_dev_setup() or during teardown, if a CPU is offlined and an accelerator
subsequently fails to probe on the next online event, it will incorrectly
remain in the dev->accelerators mask.

During teardown, cla_op_reset_all() might then attempt to reset a non-exist=
ent
accelerator, fail, and mark the entire device as broken.

> +		plxctrl_val |=3D CLA_PLxCTRL_PREP(accid,
> +						FIELD_PREP(CLA_PLxCTRL_AVAIL, 1));
> +	}
[ ... ]
> diff --git a/drivers/misc/arm-cla/cla-ops.c b/drivers/misc/arm-cla/cla-op=
s.c
> --- a/drivers/misc/arm-cla/cla-ops.c
> +++ b/drivers/misc/arm-cla/cla-ops.c
[ ... ]
> +int cla_op_reset_all(struct cla_dev *dev)
> +{
> +	int ret;
> +	unsigned int accid;
> +
> +	cla_for_each_accid(dev, accid) {
> +		ret =3D cla_op_reset(dev, accid);
> +		if (ret)
> +			return ret < 0 ? ret : -ENODEV;

[Severity: High]
Does returning immediately on the first error leave the remaining attached
accelerators running?

When cla_op_reset_all() is called during CPU teardown, an early abort means
subsequent accelerators are never quiesced. As the CPU goes offline, these
active hardware accelerators could continue issuing DMA transactions or rai=
sing
interrupts, posing a risk of memory corruption.

> +	}
> +	return 0;
> +}
[ ... ]
>  static int cla_op_access_reg(struct cla_dev *dev, u8 op,
>  			     enum cla_launch_data_mode data_mode,
>  			     unsigned int accid, unsigned int regidx,
>  			     size_t nregs, u64 *regs)
>  {
[ ... ]
>  	/* 1 to 8 registers accessed at a time, within the same 8-reg group */
>  	while (nregs > 0) {
>  		unsigned int reg_group =3D ALIGN_DOWN(regidx, 8);
>  		unsigned int max_reg =3D min(regidx + nregs, reg_group + 8);
>  		unsigned int ndata =3D max_reg - regidx;

[Severity: High]
This isn't a bug introduced by this patch, but can the 32-bit addition of
reg_group + 8 wrap around to 0 in cla_op_access_reg()?

If a read is requested near the 32-bit boundary (e.g., regidx =3D 0xFFFFFFFC
and nregs =3D 2), reg_group becomes 0xFFFFFFF8. The calculation reg_group +=
 8
then wraps around to 0 due to 32-bit unsigned arithmetic.

The call to min(regidx + nregs, reg_group + 8) would evaluate to
min(0xFFFFFFFE, 0), returning 0. This causes ndata to become 0 - 0xFFFFFFFC,
which is 4. Subtracting this from the 64-bit size_t nregs causes it to
underflow to a huge value, leading to a massive out-of-bounds loop and kern=
el
memory corruption.

> =20
>  		launch.ndata_m1 =3D ndata - 1;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260717104759.1232=
03-1-ryan.roberts@arm.com?part=3D4
