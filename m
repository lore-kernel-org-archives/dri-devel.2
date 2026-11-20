Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DCD0606A325
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 15:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eq8CoJqV
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A8B5B10E1B9;
	Fri, 20 Nov 2026 15:07:12 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E224510E1B9
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 15:07:05 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1203262F74
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 15:07:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34D701F000CA;
 Fri, 20 Nov 2026 15:07:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795187224;
 bh=k7q3s4B4fEbuehQBUxbximi0TbOKHRZtLmxkqwqO7lw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=eq8CoJqVh0JMiYk4iCUKZhG0ECv6F5RavBXV2NZYRmoUSuj3qTtKrQ8AFcqvnwaro
 WYd2NfRzxFATkK7yobMATgQh1Ryz2FVlHaAwgWPm9mRBtTGFUlVEBP19yF0GUcsXz0
 9QUVjiboMAH4aAZJtecZt7wDVYHsfZwo7RGLCzRb9W6i2ZHE60nBVzunz4kmndDVQP
 7nUfLoiRov4n+6tLKgW4Sy1ShdOsJRctz3c1dBFNrvvyz2MT04eNsgwSDGMXIIDAUD
 mAXagVQaOfXKraXgT8OIuixia63ZCRLJK9A/OuFx/0KD5mYx2T0QWApBxeuFrix7gy
 5N1QiCZrRf87Q==
Message-ID: <sashiko-outbox-225427@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 14/19] accel: ethosu: Validate OFM transpose
To: =?utf-8?b?Um9iIEhlcnJpbmcgKEFybSk=?= <robh@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261120-ethosu-fixes-v5-14-52d459acdb84@kernel.org>
References: <20261120-ethosu-fixes-v5-0-52d459acdb84@kernel.org>
 <20261120-ethosu-fixes-v5-14-52d459acdb84@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 15:07:03 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Critical] accel: ethosu: missing NHCWB16 format check when OFM
  transpose is set
--

commit 819bad25b9dbcbe54db35bf0c5afd5f5f47c3c99
Author: Rob Herring (Arm) <robh@kernel.org>

accel: ethosu: Validate OFM transpose

This commit adds validation for Ethos-U85 output feature map (OFM)
transpose encodings and permutes the OFM dimensions before validating
tile and stride accesses.

> diff --git a/drivers/accel/ethosu/ethosu_gem.c b/drivers/accel/ethosu/eth=
osu_gem.c
> index 0ab73b99c458c..b8f840ab1ceed 100644
> --- a/drivers/accel/ethosu/ethosu_gem.c
> +++ b/drivers/accel/ethosu/ethosu_gem.c

[ ... ]

> @@ -1029,8 +1083,19 @@ static int ethosu_gem_cmdstream_copy_and_validate(=
struct drm_device *ddev,
>  		case NPU_SET_OFM_PRECISION:
>  			if (((param >> 6) & 0x3) > 1)
>  				return -EINVAL;
> -			if (!ethosu_is_u65(edev) && (param & GENMASK(13, 11)))
> -				return -EINVAL;
> +			if (!ethosu_is_u65(edev)) {
> +				u32 transpose =3D FIELD_GET(NPU_OFM_TRANSPOSE_MASK, param);
> +
> +				switch (transpose) {
> +				case 4:
> +				case 5:
> +					return -EINVAL;
> +				}
> +				if (transpose && ((param >> 1) & 0x3) =3D=3D 3)
> +					return -EINVAL;
> +				if ((param >> 14) =3D=3D 2 && transpose)
> +					return -EINVAL;
> +			}
>  			st.ofm.precision =3D param;
>  			break;
>  		case NPU_SET_OFM_REGION:

[Severity: Critical]
Should NPU_SET_OFM_PRECISION also reject a non-zero transpose when the
activation format is NHCWB16 (((param >> 6) & 0x3) =3D=3D 1)?

OFM transposition on U85 is only valid with the linear NHWC format.  If
NHCWB16 is combined with a non-zero transpose, feat_matrix_validate() only
requires NPU_SET_OFM_STRIDE_C to be set, and feat_matrix_length() computes
the NHCWB16 brick offset on the coordinates already permuted by
feat_matrix_permute() while ignoring fm->stride_x.  That can underestimate
info->region_size[fm->region] and allow out-of-bounds NPU DMA writes past
the end of the GEM buffer.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120-ethosu-fix=
es-v5-0-52d459acdb84@kernel.org?part=3D14
