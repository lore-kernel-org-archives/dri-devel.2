Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A11FFC44539
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 12:53:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E417E10E0E6;
	Wed, 22 Jul 2026 12:53:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="bsC4Ckyp";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 07C1810E0E6
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 12:53:39 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7589841199;
 Wed, 22 Jul 2026 12:53:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 383481F00A3A;
 Wed, 22 Jul 2026 12:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784724818;
 bh=T3zDisXzTIukFFvCumrarOkPgcjWUaPHRvNRvu1gkUg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=bsC4CkypqcxfH+XmzUoMyLRsZWCGLWgqIdv5Jr9K4nZM0NsNIX/jyD9w1BrkdlJO7
 cjO7yW+r+d1S3B4BK7MBv2rxpRTotJSkI2m6DY1wfbz8n+/mIQ9osAB5OdZc8lq07B
 KLUAu526rP+pmu++H97DqpiCeXDAYTuR6wno2Z1LMEQlFiJ2FcvqpEMM6OBRxom7kx
 ancywUbG0noPjQT2BvarM7XrEmAStiqwq1t3SlY31DxSp/CxrxEn9eV1kvq2HwEDZd
 l1Idr8zh2Y8yP9E1ymPtsTMKnPfwJeKAAw8M5TAwsMp9PhLSnsaR/TrSGdWXq1Omat
 ZoNoZT2TBdflQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] drm/bridge: lt9611uxc: support displays with up to 4
 EDID blocks
To: vishnu.saini@oss.qualcomm.com
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260722-lt9611usc_edid34_misc_next-v3-1-7ec2bba6ff8e@oss.qualcomm.com>
References: <20260722-lt9611usc_edid34_misc_next-v3-1-7ec2bba6ff8e@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Jul 2026 12:53:37 +0000
Message-Id: <20260722125338.383481F00A3A@smtp.kernel.org>
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
- [High] Race condition in EDID polling loop causes torn reads for EDID blo=
ck 2.
- [Medium] Strict EDID header matching prevents DRM core from repairing sli=
ghtly corrupted headers.
--

--- Patch [1]: [PATCH v3] drm/bridge: lt9611uxc: support displays with up t=
o 4 EDID blocks ---
commit 63cb19491161c2c777e55262d8c46894374344b6
Author: Ravi Agola <raviagol@qti.qualcomm.com>

drm/bridge: lt9611uxc: support displays with up to 4 EDID blocks

This commit extends the driver to support reading up to 4 EDID blocks by
re-triggering the EDID access. It adds a retry mechanism that polls the data
buffer and compares it against the standard EDID header to confirm success.

Link: https://lore.kernel.org/r/20260624-lt9611usc_edid34_misc_next-v2-1-24=
ce3f5770b8@oss.qualcomm.com

> diff --git a/drivers/gpu/drm/bridge/lontium-lt9611uxc.c b/drivers/gpu/drm=
/bridge/lontium-lt9611uxc.c
> index 11aab07d88df6..20e3383a510a0 100644
> --- a/drivers/gpu/drm/bridge/lontium-lt9611uxc.c
> +++ b/drivers/gpu/drm/bridge/lontium-lt9611uxc.c
[ ... ]
> @@ -395,20 +423,48 @@ static int lt9611uxc_get_edid_block(void *data, u8 =
*buf, unsigned int block, siz
>  	if (block >=3D EDID_NUM_BLOCKS)
>  		return -EINVAL;
> =20
> -	lt9611uxc_lock(lt9611uxc);
> +	if (block =3D=3D 0 || block =3D=3D 2) {
> =20
> -	regmap_write(lt9611uxc->regmap, 0xb00b, 0x10);
> +		lt9611uxc_lock(lt9611uxc);
> =20
> -	regmap_write(lt9611uxc->regmap, 0xb00a, block * EDID_BLOCK_SIZE);
> +		edid_ready_flag =3D (block =3D=3D 0) ? BIT(0) : BIT(1);
> =20
> -	ret =3D regmap_noinc_read(lt9611uxc->regmap, 0xb0b0, buf, len);
> -	if (ret)
> -		dev_err(lt9611uxc->dev, "edid read failed: %d\n", ret);
> +		/*
> +		 * Set the EDID ready flag so that lt9611uxc can fetch correct EDID bl=
ock
> +		 */
> +		regmap_write(lt9611uxc->regmap, 0xb028, edid_ready_flag);
> =20
> -	lt9611uxc_unlock(lt9611uxc);
> +		lt9611uxc_unlock(lt9611uxc);
> =20
> -	return 0;
> -};
> +		do {
> +			msleep(100);
> +			ret =3D lt9611uxc_read_edid_block(lt9611uxc, block, buf, len);
> +			if (ret)
> +				break;
> +			/*
> +			 * Compare first 8 bytes of EDID header for block 0 and block 2
> +			 * to confirm EDID read successfully
> +			 */
> +			header_matched =3D (memcmp(edid_header, buf, 8) =3D=3D 0);

[Severity: Medium]
Does this strict EDID header matching prevent the DRM core from repairing
slightly corrupted headers?

If the EDID read from the display has a slightly corrupted header (e.g., a
flipped bit due to I2C noise), this memcmp forces the function to eventually
return -ETIMEDOUT.=20

This bypasses the DRM core's robust header repair logic
(drm_edid_header_is_valid), causing displays that would have been repaired
and worked properly to fail initialization completely.

> +			edid_valid =3D (block =3D=3D 0 && header_matched) ||
> +				     (block =3D=3D 2 && !header_matched);
> +			if (edid_valid)
> +				break;

[Severity: High]
Can this exit condition cause a torn read for EDID block 2?

When the MCU begins overwriting the buffer with block 2, the first byte
written (e.g., the CEA extension tag) will immediately cause header_matched
to evaluate to false.

Because the MCU does not write the 128-byte block atomically with respect to
I2C register access, the polling loop will terminate prematurely. This retu=
rns
a torn buffer containing a mix of new block 2 data and old block 0 data,
leading to corrupted EDID parsing on displays with 3 or more EDID blocks.

> +
> +		} while (retry_cnt-- > 0);
> +
> +		if (!ret && !edid_valid)
> +			ret =3D -ETIMEDOUT;
> +	} else {
> +		ret =3D lt9611uxc_read_edid_block(lt9611uxc, block, buf, len);
> +
> +		lt9611uxc_lock(lt9611uxc);
> +		regmap_write(lt9611uxc->regmap, 0xb028, 0x00);
> +		lt9611uxc_unlock(lt9611uxc);
> +	}
> +
> +	return ret;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260722-lt9611usc_=
edid34_misc_next-v3-1-7ec2bba6ff8e@oss.qualcomm.com?part=3D1
