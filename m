Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15A10C44507
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 11:01:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 36C9010F455;
	Fri, 17 Jul 2026 11:01:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="LENUAe9m";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0149F10F455
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 11:01:09 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3A06260A69;
 Fri, 17 Jul 2026 11:01:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6F881F00A3E;
 Fri, 17 Jul 2026 11:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784286068;
 bh=JLHRlVzmvlLRyYTQT+JZ8ndqefv8hSoQwp02vebbZHE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=LENUAe9miE0JsZQbyGfFS/xrwUKXdPlqOX5n8EDNFlucA24dE64pOdJZHddUsr6gS
 48oH4iH5HBtcUePpICBHj5ke6/g9Mywb46BiSVvnb8xgMWAefmc7piWMnoWDR/UHR6
 VXzGLr/IhdOqtDnhC/m/CQpF4K/p90teGjfS+CcvC7VC9FaJ9opnxaHSJDleM1tWuX
 q7Q47jgRDsqAhF+5yrTBjZEYnm1P9mXtsRVDSVXNBRsmBjyBapYDbA0+Sp7X3NMNev
 3IwQVFGWI5yC1OpCFLppth9soP70w1xDc8CXdsw8kDqbLN3RlNk8FA06yn1QoSpdUa
 wIr6dy2KhJZkQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v1 2/8] misc/arm-cla: Add launch operation helpers
To: "Ryan Roberts" <ryan.roberts@arm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260717104759.123203-3-ryan.roberts@arm.com>
References: <20260717104759.123203-1-ryan.roberts@arm.com>
 <20260717104759.123203-3-ryan.roberts@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jul 2026 11:01:07 +0000
Message-Id: <20260717110108.B6F881F00A3E@smtp.kernel.org>
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
- [High] A 32-bit integer overflow when calculating `reg_group + 8` causes =
out-of-bounds memory access on the `regs` buffer and an infinite loop for h=
igh register indices.
- [High] The safety bounds check `regidx + nregs > max_regidx` is vulnerabl=
e to a 64-bit integer overflow, allowing massive `nregs` values to bypass t=
he limit check.
--

--- Patch [2]: [RFC PATCH v1 2/8] misc/arm-cla: Add launch operation helper=
s ---
commit dc6365dd6ad591fc5563520a7266898c01430558
Author: Jean-Philippe Brucker <jpb@kernel.org>

misc/arm-cla: Add launch operation helpers

CLA commands are issued by programming the LAUNCH register and polling LRES=
P.
This patch adds a common launch helper to perform this sequence and transla=
tes
response codes into Linux errors, along with register read and write suppor=
t.

> diff --git a/drivers/misc/arm-cla/cla-ops.c b/drivers/misc/arm-cla/cla-op=
s.c
> new file mode 100644
> index 0000000000000..d594344a2eb45
> --- /dev/null
> +++ b/drivers/misc/arm-cla/cla-ops.c
[ ... ]
> +static int cla_op_access_reg(struct cla_dev *dev, u8 op,
> +			     enum cla_launch_data_mode data_mode,
> +			     unsigned int accid, unsigned int regidx,
> +			     size_t nregs, u64 *regs)
> +{
> +	int ret =3D -EINVAL;
> +	unsigned long max_regidx;
> +	struct cla_launch launch =3D {
> +		.op =3D op,
> +		.accid =3D accid,
> +		.data_mode =3D data_mode,
> +	};
> +
> +	switch (op) {
> +	case CLA_LAUNCH_OP_REGREAD:
> +	case CLA_LAUNCH_OP_REGWRITE:
> +		max_regidx =3D 0x100000000;
> +		break;
> +	default:
> +		WARN_ON(1);
> +		return -EINVAL;
> +	}
> +
> +	if (WARN_ON(regidx + nregs > max_regidx))

[Severity: High]
Does this check adequately protect against integer overflow? If nregs is ve=
ry
large (for example, (size_t)-1), the addition of regidx and nregs can overf=
low
size_t. This would result in a small positive value that bypasses the
max_regidx limit.

Could this be rewritten to avoid wrap-around, perhaps by checking if nregs
is greater than max_regidx - regidx?

> +		return -EINVAL;
> +
> +	/* 1 to 8 registers accessed at a time, within the same 8-reg group */
> +	while (nregs > 0) {
> +		unsigned int reg_group =3D ALIGN_DOWN(regidx, 8);
> +		unsigned int max_reg =3D min(regidx + nregs, reg_group + 8);

[Severity: High]
Can reg_group + 8 overflow? Since regidx and reg_group are 32-bit unsigned
integers, if a caller passes a register index near the 32-bit maximum
(for example, 0xFFFFFFF8) and a small nregs value, reg_group + 8 will wrap
around to 0.

If max_reg evaluates to 0, ndata becomes 0 - regidx, which can yield a value
larger than the original nregs. Will this cause out-of-bounds memory access=
es
on the regs buffer when passed to cla_op_launch(), and an infinite loop due=
 to
underflowing nregs?

> +		unsigned int ndata =3D max_reg - regidx;
> +
> +		launch.ndata_m1 =3D ndata - 1;
> +		launch.regidx =3D regidx;
> +		launch.data =3D regs;
> +
> +		ret =3D cla_op_launch(dev, &launch);
> +		if (ret)
> +			break;
> +
> +		regidx +=3D ndata;
> +		regs +=3D ndata;
> +		nregs -=3D ndata;
> +	}
> +
> +	return ret;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260717104759.1232=
03-1-ryan.roberts@arm.com?part=3D2
