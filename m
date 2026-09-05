Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA659C79F82
	for <dri-devel@archiver.kernel.org>; Sat,  5 Sep 2026 00:53:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA28A10E578;
	Sat,  5 Sep 2026 00:53:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Aw9SRPo1";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 53D3B10E578
 for <dri-devel@lists.freedesktop.org>; Sat,  5 Sep 2026 00:53:36 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id EB0BF43AB2
 for <dri-devel@lists.freedesktop.org>; Sat,  5 Sep 2026 00:53:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0EAA1F00A3D;
 Sat,  5 Sep 2026 00:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788569615;
 bh=flDQ5lam1Z06pbBtvoYapPv3MR9W6q8z5nJCFOQraOY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Aw9SRPo10mRABwwCgmoYKeeGYP4MfND68jLhpXuSNt15ftUtq6Jxr4N7PZcMrsGpr
 FWg1JvnwzsAWtOYhrugOUsGqxEN8TKumJcaYgiyDqRXfPf53Aqkjx2T1/GioDJwGse
 sW6etCDmFnJvX8DVYaIMhtCIsac212ktMIJa7vZnFm7XqW0KFnsx8kVPOkG2JE02P+
 sVorXboaARfCsOPyrs3jAXDmuYGbNtl1rkgjMhvcGuT8pOAg7X0FIxyfRWUJCPpPwp
 aeOivG4T8DWTTXWe3VzPCPAAwMR0gvwYdpZclC+UYSOfBwTSdO13Abf0vGt68lW8cN
 O+Y6vQPJo58vw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 12/19] accel: ethosu: Validate convolution parameter
To: =?utf-8?b?Um9iIEhlcnJpbmcgKEFybSk=?= <robh@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260904-ethosu-fixes-v2-12-3767738756a4@kernel.org>
References: <20260904-ethosu-fixes-v2-0-3767738756a4@kernel.org>
 <20260904-ethosu-fixes-v2-12-3767738756a4@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 05 Sep 2026 00:53:35 +0000
Message-Id: <20260905005335.A0EAA1F00A3D@smtp.kernel.org>
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

Pre-existing issues:
- [High] The command validator fails to validate the `scale` buffer bounds =
for `NPU_OP_ELEMENTWISE` operations, potentially allowing out-of-bounds NPU=
 memory reads.
--

commit ce7a8243218e8f4759fe093516845ea9fe6bb544
Author: Rob Herring (Arm) <robh@kernel.org>

accel: ethosu: Validate convolution parameter

The commit fixes a validation issue with the U65 NPU_OP_CONV command where a
crafted stream could skip the weight buffer validation. It requires a zero
parameter on U65 and rejects reserved U85 parameter bits.

> diff --git a/drivers/accel/ethosu/ethosu_gem.c b/drivers/accel/ethosu/eth=
osu_gem.c
> index bca68fab05275..d60a2a453302b 100644
> --- a/drivers/accel/ethosu/ethosu_gem.c
> +++ b/drivers/accel/ethosu/ethosu_gem.c
> @@ -733,7 +733,10 @@ static int ethosu_gem_cmdstream_copy_and_validate(st=
ruct drm_device *ddev,
>  				st.dma.dst.region, st.dma.dst.offset, dstlen);
>  			break;
>  		case NPU_OP_CONV:
> -			use_ifm2 =3D param & 0x1;  // weights_ifm2
> +			if ((ethosu_is_u65(edev) && param) || (param & ~NPU_OP_CONV_WEIGHTS_I=
FM2))
> +				return -EINVAL;
> +
> +			use_ifm2 =3D param & NPU_OP_CONV_WEIGHTS_IFM2;
>  			if (!cmd_state_reg_is_set(&st, NPU_SET_OFM_PRECISION))
>  				return -EINVAL;
>  			use_scale =3D !(st.ofm.precision & 0x100);

[ ... ]

>  		case NPU_OP_ELEMENTWISE:
>  			if (!ethosu_is_u65(edev) &&
>  			    !cmd_state_reg_is_set(&st, NPU_SET_IFM_BROADCAST))
>  				return -EINVAL;
>  			use_ifm2 =3D (param !=3D 5) && (param !=3D 6) &&
>  				(param !=3D 7) && (param !=3D 0x24);
>  			if (use_ifm2 &&
>  			    !cmd_state_reg_is_set(&st, NPU_SET_IFM2_BROADCAST))
>  				return -EINVAL;
>  			use_scale =3D use_ifm2 && (ethosu_is_u65(edev) ?
>  				    (st.ifm2.broadcast & 0x80) :
>  				    (st.ifm2.broadcast =3D=3D 8));
>  			use_ifm2 =3D use_ifm2 && !use_scale;
>  			use_ifm =3D st.ifm.broadcast !=3D 8;
>  			ret =3D calc_sizes_elemwise(ddev, info, cmd, &st, use_ifm, use_ifm2);
                        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^=
^^^^^^^^^^^^^^^^

[Severity: High]
This isn't a bug introduced by this patch, but while reviewing the changes =
to
the validation in ethosu_gem_cmdstream_copy_and_validate(), I noticed that
the scale buffer bounds don't seem to be validated for NPU_OP_ELEMENTWISE
operations.

For NPU_OP_ELEMENTWISE commands, the driver parses the broadcast
configuration and sets use_scale =3D true. However, use_scale is never
passed to calc_sizes_elemwise() and the scale buffer bounds are never
validated.

Could this allow an out-of-bounds NPU memory read if a userspace application
submits a crafted command stream containing an NPU_OP_ELEMENTWISE command
with a broadcast configuration that uses the scale buffer?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904-ethosu-fix=
es-v2-0-3767738756a4@kernel.org?part=3D12
