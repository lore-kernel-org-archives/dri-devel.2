Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9814BCDB47F
	for <dri-devel@archiver.kernel.org>; Wed, 24 Jun 2026 08:53:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B9F410EE1B;
	Wed, 24 Jun 2026 08:53:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="LPapHAMP";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 373BA10EE1B
 for <dri-devel@lists.freedesktop.org>; Wed, 24 Jun 2026 08:53:34 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0843A402EC;
 Wed, 24 Jun 2026 08:53:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB0FC1F00A3A;
 Wed, 24 Jun 2026 08:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782291213;
 bh=46QUJ9fsaJKHNRIpJ3NlGPMVZCwhhA8dRxYQ0KERPuY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=LPapHAMP6oc5RJDhbXEGCqIuKn0r3PzW0TyzzTZ2sUJK5WmKTIePYkVXX5bXqeSOq
 VBPfg+tw7sYYI8vlkmb5SDIAl5OkuvJA9HPoW34wgAdgL8n1DgmB+xyNz00Oy/3qB7
 VNvVTS2ApoV3Z+wOtAmCMuNJOJAxhVCmWVLizFrpdflLJvY+I1ZxmRv8BxCH86K/yv
 7cJMkMYPiF1xNnfn7W0ITpufUjwsWrWgKWMuhowzvzw69ANp4eH5HxXbjQZdg8gExs
 kIBYQBLTC1YFpqx7eQo7mlATaH5NgJE7hN0L7d8gPsCPQS9s9CK0nSK51DKhWkkmsG
 bbEi4r7MSLBRg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] drm/bridge: lt9611uxc: support displays with up to 4
 EDID blocks
To: vishnu.saini@oss.qualcomm.com
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260624-lt9611usc_edid34_misc_next-v2-1-24ce3f5770b8@oss.qualcomm.com>
References: <20260624-lt9611usc_edid34_misc_next-v2-1-24ce3f5770b8@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 24 Jun 2026 08:53:33 +0000
Message-Id: <20260624085333.BB0FC1F00A3A@smtp.kernel.org>
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
- [High] Clearing the 0xb028 EDID bank register to 0x00 after reading block=
s 1 or 3 prevents DRM core retries from succeeding.
- [High] Race condition between lt9611uxc_hpd_work and the IRQ handler can =
corrupt the edid_read state, leading to permanent EDID read timeouts.
- [Medium] lt9611uxc_get_edid_block() silently returns success (0) when the=
 EDID polling loop times out, feeding incorrect data to the DRM core and am=
plifying retry delays.
- [Medium] Polling the EDID data buffer directly for a header match races w=
ith the MCU's internal memory writes, risking torn reads.
- [Low] Unconditional memcmp of 8 bytes may read past the end of buf if a c=
aller provides a short buffer.
--

commit f8ef2cd8a0639401cecc3757e315eeb45035f222
Author: Ravi Agola <raviagol@qti.qualcomm.com>

drm/bridge: lt9611uxc: support displays with up to 4 EDID blocks

The LT9611UXC bridge can fetch only 2 EDID blocks at a time, which
previously limited EDID reading to 2 blocks and prevented support
for displays exposing more than 2 EDID blocks. Add driver support to fetch
up to 4 EDID blocks by re-triggering EDID access.

> diff --git a/drivers/gpu/drm/bridge/lontium-lt9611uxc.c b/drivers/gpu/drm=
/bridge/lontium-lt9611uxc.c
> --- a/drivers/gpu/drm/bridge/lontium-lt9611uxc.c
> +++ b/drivers/gpu/drm/bridge/lontium-lt9611uxc.c

[ ... ]

> @@ -170,6 +170,9 @@ static void lt9611uxc_hpd_work(struct work_struct *wo=
rk)
>  	connected =3D lt9611uxc->hdmi_connected;
>  	mutex_unlock(&lt9611uxc->ocm_lock);
> =20
> +	if (!connected)
> +		lt9611uxc->edid_read =3D false;
> +
>  	drm_bridge_hpd_notify(&lt9611uxc->bridge,
>  			      connected ?

[Severity: High]
Could this create a race condition with the IRQ handler?

If an HPD connect interrupt fires right after ocm_lock is dropped, the IRQ
handler could set both hdmi_connected and edid_read to true and queue a new
work.

When this thread resumes, it will evaluate the stale connected variable
(false) and overwrite edid_read back to false.

When the new work thread runs, it sees connected =3D=3D true and skips upda=
ting
edid_read, potentially causing lt9611uxc_wait_for_edid() to permanently
time out.

[ ... ]

> @@ -395,20 +423,44 @@ static int lt9611uxc_get_edid_block(void *data, u8 =
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

[Severity: Low]
Is it possible for len to be less than 8 here? If a caller provides a short
buffer, this memcmp could read past the end of buf.

[Severity: Medium]
Does polling the I2C SRAM buffer directly for a header match risk a torn
read?

Since the MCU writes to this SRAM sequentially from the slow DDC bus, the C=
PU
might see the first 8 bytes match and immediately break the loop, while the
MCU is still writing the remaining 120 bytes.

Could this cause a mix of old and new data to be read, leading to EDID
checksum failures?

> +			if ((block =3D=3D 0 && header_matched) ||
> +			    (block =3D=3D 2 && !header_matched))
> +				break;
> +
> +		} while (retry_cnt-- > 0);

[Severity: Medium]
If this retry loop times out (retry_cnt drops below 0), will it incorrectly
return success?

Since lt9611uxc_read_edid_block() sets ret to 0 upon completing the I2C
read (even if it's the wrong block), ret remains 0.

This could cause the DRM core to process garbage data, fail validation, and
repeatedly retry, multiplying the delay. Should this return an error code l=
ike
-ETIMEDOUT when exhausted?

> +	} else {
> +		ret =3D lt9611uxc_read_edid_block(lt9611uxc, block, buf, len);
> +
> +		lt9611uxc_lock(lt9611uxc);
> +		regmap_write(lt9611uxc->regmap, 0xb028, 0x00);
> +		lt9611uxc_unlock(lt9611uxc);
> +	}

[Severity: High]
Will clearing the 0xb028 register to 0x00 break DRM core retries for blocks=
 1
and 3?

If the DRM core encounters a checksum error and retries the read, it will
enter this else branch again.

But since the register was already cleared to 0x00, won't the retry
consistently read invalid data and fail?

> +
> +	return ret;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260624-lt9611usc_=
edid34_misc_next-v2-1-24ce3f5770b8@oss.qualcomm.com?part=3D1
