Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81E03CA5FE3
	for <dri-devel@archiver.kernel.org>; Sat,  3 Oct 2026 01:34:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DCD6110E70E;
	Sat,  3 Oct 2026 01:34:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="UFsVCNgB";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6218010E70E
 for <dri-devel@lists.freedesktop.org>; Sat,  3 Oct 2026 01:34:01 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2B37940108;
 Sat,  3 Oct 2026 01:34:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE2A91F00893;
 Sat,  3 Oct 2026 01:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790991241;
 bh=sGDH335QcaRLqAJ/OklwALfDIQHzoib1B2aIh5c2qO8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=UFsVCNgBcCeDHkxayCg1rVOHycC1m/NUV//Wh1dQIAc7jnG6lN7DOv3/vHefHNXM+
 qcwC46quTvIcU7rF/hS2rvmowaI3JJngGq8iENV+fOgx5v1y8r+AzRGAqoPMmCCU96
 7naGG04Kv/yV7dRHvD+0a9G+Bqln19hPFZ+jDvzV6sAPpreLocQBMLqOqVYiHlgdQm
 LyfHchv5yZjyXCHhzchQqhf8Ye0J0zJ7Rimw7jfP92iAcgMYALyekxFniAetecMPDs
 xPhBsjUGmR2WkMFLuCnbyxXFYLehuIaiuWBrQyFTKrKQGylvDUjaPt1Dn8HKKmB43e
 kwFol2MIb+2cQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/dp: keep MOT set between messages when
 no_zero_sized is set
To: "Finn Zeruhn" <fzeruhn@icloud.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261002212833.9674-1-fzeruhn@icloud.com>
References: <20261002212833.9674-1-fzeruhn@icloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 03 Oct 2026 01:34:00 +0000
Message-Id: <20261003013400.DE2A91F00893@smtp.kernel.org>
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
- [Medium] drm/dp: 0-length final I2C message leaves MOT bit set hanging th=
e bus
--

commit 1eb9f4115ff3f3b4a53072c0af9a5f8cf025a748
Author: Finn Zeruhn <fzeruhn@icloud.com>

drm/dp: keep MOT set between messages when no_zero_sized is set

This commit modifies drm_dp_i2c_xfer() to clear the Middle-Of-Transaction
(MOT) bit only on the last packet of the last message when aux->no_zero_siz=
ed
is set. This addresses an issue where EDID blocks 2 and up reads break
because the stop after the first message resets the segment pointer.

Link: https://lore.kernel.org/all/20260827015758.0B4FB1F000E9@smtp.kernel.o=
rg/

> diff --git a/drivers/gpu/drm/display/drm_dp_helper.c b/drivers/gpu/drm/di=
splay/drm_dp_helper.c
> index 488fd123a01ad..7676285c19f87 100644
> --- a/drivers/gpu/drm/display/drm_dp_helper.c
> +++ b/drivers/gpu/drm/display/drm_dp_helper.c
> @@ -2192,7 +2192,8 @@ static int drm_dp_i2c_xfer(struct i2c_adapter *adap=
ter, struct i2c_msg *msgs,
>  			msg.buffer =3D msgs[i].buf + j;
>  			msg.size =3D min(transfer_size, msgs[i].len - j);
> =20
> -			if (j + msg.size =3D=3D msgs[i].len && aux->no_zero_sized)
> +			if (aux->no_zero_sized && i =3D=3D num - 1 &&
> +			    j + msg.size =3D=3D msgs[i].len)
>  				msg.request &=3D ~DP_AUX_I2C_MOT;

[Severity: Medium]
Will this leave the MOT bit set and hang the bus if the final message has a
length of 0?

If a caller issues a multi-message transfer where the final message
(msgs[num-1]) has a length of 0, the inner loop:

    for (j =3D 0; j < msgs[i].len; j +=3D msg.size) {

is bypassed entirely for that message.

Because the clearing of the DP_AUX_I2C_MOT bit is now restricted to
i =3D=3D num - 1 inside this loop, the MOT flag would never be cleared for
the preceding messages.

Furthermore, because aux->no_zero_sized prevents the driver from sending
the fallback bare address packet at the end of the function, the hardware
is never signaled to terminate the transaction.

>  			err =3D drm_dp_i2c_drain_msg(aux, &msg);
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261002212833.9674=
-1-fzeruhn@icloud.com?part=3D1
