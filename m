Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29887C982F1
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 04:02:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5FF9D10E0BA;
	Tue, 22 Sep 2026 04:02:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="GokrtNwE";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C309910E0BA
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 04:02:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 03E7E600CB;
 Tue, 22 Sep 2026 04:02:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D2011F000FF;
 Tue, 22 Sep 2026 04:02:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790049732;
 bh=AniFYXrut/f2hHwIwqyPuKPv1yaKtSeU7VtItiuewSA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=GokrtNwEq+RNbPlaI+/dn3c7LhyNkDVvT1/wwQMi76nqI/TbWeAlip06GBJNoLQQt
 7117nCymnb+1cIUk9dSH29/2i50FdEAUJxm6dkDxopMGaiVEjKdF3w9ckJvAWUppok
 UoahQwArnTs+aufWnSTB+XS4BUIRnc6v7bfDuRbqCSnWyfy2vGfcEndeognGpKiA5z
 IiMJh0Tsii3Fsylbnl4LwrP9BLPVSwlSP8mRgY6Z80QC8jAQqeJjNQs5LVSNH17QHI
 AaPyUtYPaBIXpnPamitdq3TMPpNl5233ZBryQ9mGCAO6s+qE57uhjvM46rkwdccR7W
 9hMkpq+iwaNzg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4] drm/bridge: lt9611uxc: support displays with up to 4
 EDID blocks
To: vishnu.saini@oss.qualcomm.com
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260922-lt9611usc_edid34_misc_next-v4-1-47d5315821fe@oss.qualcomm.com>
References: <20260922-lt9611usc_edid34_misc_next-v4-1-47d5315821fe@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 04:02:12 +0000
Message-Id: <20260922040212.8D2011F000FF@smtp.kernel.org>
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
- [High] drm/bridge: lt9611uxc: race condition in EDID SRAM polling causes =
torn reads
- [Medium] drm/bridge: lt9611uxc: strict EDID header check breaks repairabl=
e displays
--

commit 6559cd85aa7ae1a652dd056a93747b35998d927d
Author: Ravi Agola <raviagol@qti.qualcomm.com>

drm/bridge: lt9611uxc: support displays with up to 4 EDID blocks

This commit adds support for fetching up to 4 EDID blocks in the LT9611UXC
bridge driver by re-triggering access for blocks beyond the first two. It
introduces a polling mechanism for blocks 0 and 2, checking for a valid EDID
header match to verify read success. It also increases the EDID wait time to
handle slower platform interrupts.

> diff --git a/drivers/gpu/drm/bridge/lontium-lt9611uxc.c b/drivers/gpu/drm=
/bridge/lontium-lt9611uxc.c
> index b3bb7f2cebb3b..a74077a65f62b 100644
> --- a/drivers/gpu/drm/bridge/lontium-lt9611uxc.c
> +++ b/drivers/gpu/drm/bridge/lontium-lt9611uxc.c
[ ... ]
> @@ -394,20 +422,48 @@ static int lt9611uxc_get_edid_block(void *data, u8 =
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
                        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

[Severity: Medium]
Will this strict exact match check inadvertently drop blocks with repairable
header corruptions?

If the display provides a corrupted header that the DRM core is natively
designed to fix via edid_header_fix(), it seems this strict memcmp will nev=
er
match and the polling loop will exhaust its retries, returning -ETIMEDOUT.
Does this break initialization for displays with non-compliant but repairab=
le
EDID headers?

> +			edid_valid =3D (block =3D=3D 0 && header_matched) ||
> +				     (block =3D=3D 2 && !header_matched);
> +			if (edid_valid)
> +				break;
                                ^^^^^

[Severity: High]
Does this condition break the wait loop too early, ignoring that the rest of
the block is still being written by the MCU?

When the DRM core requests block 2, the bridge driver writes to 0xb028 to
trigger the MCU fetch, and then polls the SRAM. The SRAM initially contains
block 0 (which has a valid header). As soon as the MCU overwrites the first
byte of SRAM with block 2 data, the !header_matched condition evaluates to
true.

Could this cause the driver to immediately stop polling and read the rest of
the block, which might still contain stale data from block 0?

> +
> +		} while (retry_cnt-- > 0);
> +
> +		if (!ret && !edid_valid)
> +			ret =3D -ETIMEDOUT;
> +	} else {
> +		ret =3D lt9611uxc_read_edid_block(lt9611uxc, block, buf, len);
                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

[Severity: High]
Blocks 1 and 3 are read immediately here without any synchronization. Does
this guarantee reading torn data if the firmware is still fetching them over
I2C?

> +
> +		lt9611uxc_lock(lt9611uxc);
> +		regmap_write(lt9611uxc->regmap, 0xb028, 0x00);
> +		lt9611uxc_unlock(lt9611uxc);
> +	}
> +
> +	return ret;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922-lt9611usc_=
edid34_misc_next-v4-1-47d5315821fe@oss.qualcomm.com?part=3D1
