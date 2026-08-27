Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA886C61DC4
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 20:48:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0906510F1C5;
	Thu, 27 Aug 2026 20:48:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="mZ/nVeKs";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF57C10F1C5
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 20:48:39 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A733E40496
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 20:48:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 601D11F000E9;
 Thu, 27 Aug 2026 20:48:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787863719;
 bh=v4WMpOU2VByTyHSvRCrv6rSS5/vFCWJqgM1DI/5qwi0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=mZ/nVeKsXZJAGAl1LIHKyqynXShc/X3ZJCp0vMSosrvETSV+KNzaPK8x2RpZKN75A
 3Z69wyJf8Z7JWrPULckplz48TzRB8iOcwKe3U9cRnIdRaYgzqX5t4tUNwTcHvBodx/
 m9akcNw6e0KqJRu7tsocJVqTI6KopUeKvfB+iTn1fvfn4/rK9RocmJ7PuR92k1W8Bf
 zBHJDNQ1OrRjaI+H4SU9ldrlAmB1syG9lKVY2IJSi1X6eFOW1lr6byR7MFr8Tf3bdd
 H5xdYEIAAQOvZypPF80AHsIQLQrmGuCl+XdIT/TTaXunxXjujYmj8zVcTIcEodLERD
 fv6qsCO4JbPFA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 07/11] accel: ethosu: Factor buffer bounds checks
To: =?utf-8?b?Um9iIEhlcnJpbmcgKEFybSk=?= <robh@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260827-ethosu-fixes-v1-7-346f9ea8791c@kernel.org>
References: <20260827-ethosu-fixes-v1-0-346f9ea8791c@kernel.org>
 <20260827-ethosu-fixes-v1-7-346f9ea8791c@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 20:48:38 +0000
Message-Id: <20260827204839.601D11F000E9@smtp.kernel.org>
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
- [High] Missing buffer range validation for scale buffers in elementwise o=
perations.
--

commit 316c3aea268f80d537aa6815e4f6d7b0890d7634
Author: Rob Herring (Arm) <robh@kernel.org>

accel: ethosu: Factor buffer bounds checks

Move the repeated command-stream buffer range validation into a helper
in preparation for validating all weight and scale streams.

> diff --git a/drivers/accel/ethosu/ethosu_gem.c b/drivers/accel/ethosu/eth=
osu_gem.c
> index eda9f42239beb..9fce7caeeb9af 100644
> --- a/drivers/accel/ethosu/ethosu_gem.c
> +++ b/drivers/accel/ethosu/ethosu_gem.c
[ ... ]
> @@ -303,24 +319,16 @@ static int calc_sizes(struct drm_device *ddev,
[ ... ]
>  	if (scale) {
>  		dev_dbg(ddev->dev, "op %d: S:%d:0x%llx-0x%llx\n",
>  			op, st->scale[0].region, st->scale[0].base,
>  			st->scale[0].base + st->scale[0].length - 1);
> -		if (st->scale[0].region < 0 || st->scale[0].base =3D=3D U64_MAX ||
> -		    st->scale[0].length =3D=3D U32_MAX)
> +		if (buffer_size(info, &st->scale[0], st->scale[0].region))
>  			return -EINVAL;
> -		info->region_size[st->scale[0].region] =3D
> -			max(info->region_size[st->scale[0].region],
> -			    st->scale[0].base + st->scale[0].length);
>  	}

[Severity: High]
This isn't a bug introduced by this patch, but while calc_sizes() validates
the scale buffer, does calc_sizes_elemwise() miss this validation for
elementwise operations?

In ethosu_gem_cmdstream_copy_and_validate(), NPU_OP_ELEMENTWISE calculates
use_scale, but it never passes it to calc_sizes_elemwise():

drivers/accel/ethosu/ethosu_gem.c:ethosu_gem_cmdstream_copy_and_validate() {
		...
		case NPU_OP_ELEMENTWISE:
			use_scale =3D ethosu_is_u65(edev) ?
				    (st.ifm2.broadcast & 0x80) :
				    (st.ifm2.broadcast =3D=3D 8);
			use_ifm2 =3D !(use_scale || (param =3D=3D 5) ||
				(param =3D=3D 6) || (param =3D=3D 7) || (param =3D=3D 0x24));
			use_ifm =3D st.ifm.broadcast !=3D 8;
			ret =3D calc_sizes_elemwise(ddev, info, cmd, &st, use_ifm, use_ifm2);
			if (ret)
				return ret;
		...
}

Because calc_sizes_elemwise() only checks ifm, ifm2, and ofm, could a
malicious command stream with an undersized scale buffer bypass validation
here?

This would allow an out-of-bounds memory read by the NPU when the
elementwise operation uses a scale stream.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260827-ethosu-fix=
es-v1-0-346f9ea8791c@kernel.org?part=3D7
