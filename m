Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EC6AC44507
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 11:02:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8056610F4EF;
	Fri, 17 Jul 2026 11:02:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="LgqragRg";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 62D5810F4EF
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 11:02:15 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C3B6560A63;
 Fri, 17 Jul 2026 11:02:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64D881F000E9;
 Fri, 17 Jul 2026 11:02:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784286134;
 bh=/dqpuupIxMquDEtXwR+6JXZoGgNtqqrCVKZifmg7vRQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=LgqragRggnz1VJ6iBSQchmDj7clfUM3wqJv+8U49aO408b3tse3QeXbrJBOA2hMb8
 VE5ksaVzfDvahevTgecU07qaoANytrxXmoEeKyVUrAqRWNWSlpkTDbIT5CKJ8/wowg
 VU+TqnPgKVeRx3PXM/8T45JvQqppWBPX6Tm+WOEM/FL+Dc8914d/fbFOhLwJcS9r+J
 QQUm0wTsdZYDIgUEkP/kTjpFkmNm6sw6JOf6LRzJDBZVJRQDbZPy6C/xMp2t+k/nd7
 TA04EuFG79RAbmzfd2B1w+eOQcUpe3l0vKZs7PtDxMdOS+kaojOxm/aZWaobNXnAdx
 IgXvoMkoU2Zxg==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v1 6/8] misc/arm-cla: Set up memory translation context
To: "Ryan Roberts" <ryan.roberts@arm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260717104759.123203-7-ryan.roberts@arm.com>
References: <20260717104759.123203-1-ryan.roberts@arm.com>
 <20260717104759.123203-7-ryan.roberts@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jul 2026 11:02:14 +0000
Message-Id: <20260717110214.64D881F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Type mismatch in the `min()` macro arguments will trigger strict ty=
pe-checking compiler errors.
--

--- Patch [6]: [RFC PATCH v1 6/8] misc/arm-cla: Set up memory translation c=
ontext ---
commit 5af1b39fed17c5b5bbf7cdc121a0531df0a24e2d
Author: Ryan Roberts <ryan.roberts@arm.com>

misc/arm-cla: Set up memory translation context

This commit sets up a Memory Translation Context (MTC) during CLA bringup f=
or
CPU MMU DMA configurations. It populates the MTC from EL1 configuration,
configuring the accelerator to run as EL0 and installing user translation
contexts via TTBR0.

> diff --git a/drivers/misc/arm-cla/cla-ops.c b/drivers/misc/arm-cla/cla-op=
s.c
> index 7ddb973927e99..4d3f4f453e0b4 100644
> --- a/drivers/misc/arm-cla/cla-ops.c
> +++ b/drivers/misc/arm-cla/cla-ops.c
> @@ -180,6 +180,10 @@ static int cla_op_access_reg(struct cla_dev *dev, u8=
 op,
>  	case CLA_LAUNCH_OP_REGWRITE:
>  		max_regidx =3D 0x100000000;
>  		break;
> +	case CLA_LAUNCH_OP_SETCTX:
> +	case CLA_LAUNCH_OP_GETCTX:
> +		max_regidx =3D 0x80;
> +		break;
>  	default:
>  		WARN_ON(1);
>  		return -EINVAL;

[Severity: Low]
Will this result in a build failure due to strict type checking in the min()
macro?

Further down in cla_op_access_reg(), the code calculates the max register
using min():

    while (nregs > 0) {
        unsigned int reg_group =3D ALIGN_DOWN(regidx, 8);
        unsigned int max_reg =3D min(regidx + nregs, reg_group + 8);

Since nregs is a size_t (64-bit on ARM64) and reg_group is an unsigned int
(32-bit), the min() macro will catch the type mismatch between its argument=
s.
Could this be resolved by using min_t() or casting the arguments to matching
types?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260717104759.1232=
03-1-ryan.roberts@arm.com?part=3D6
