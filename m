Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B055C606A337
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 08:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KU4CjDbm
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 71AA810EB68;
	Thu, 12 Nov 2026 08:33:18 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB3CB10FC75
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 08:33:10 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D086263C76;
 Thu, 12 Nov 2026 08:33:09 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1794472389;
 b=TDgSSp03Vw+MHAAHjDuDpb449VHbGx69pcejaUYh6JAjeacVxr8R5W0cSM0kiEQSHoMF
 s/5Qh6hblntRIXFxT4QJ5Filv2pC87XoycaRQerqjm6ulqYemFIESVIBpV+7EPVm8AL5H
 2Ad+53SFPGXiYyEdqBoXrlgQdgFbp4Z0P9k7H3NEmiSq9QaNK+eqARXxgIuos5IxBPcd0
 6T+YO1irNZsrUH7bAlIgSHjlFWbjT48nKYaePn71Mh9Y//O3FpTCw2anhwoEfXrULVTt7
 9yrPBsLUhC4WkfAFno0gsrnCSDmSfWoMG4Jy4Y/8sPCSPE/y0ssW1yDm2x003Bbw2jg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1794472389;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=f2V/YaFbmkNwpcwUOxGNm0rVRQvd359hw4q7Khz/JZg=;
 b=Ev6RLCPg+B5/rKuq1Dyf+anWw/ORmLz5T+e1ZNMkEtQR+BugnmopZuNeTRPVR59K+Sn3
 xtvyZmvuiyfs3Hd6KmTxIDmFVasy8WvdwDD6L8sCxbNuhmRFMZ8E2tVwP39Aek5cFVrzX
 UXpFM54f7qqewhm0UfYxteP1KYxclnmQtSvSk7S+FC6vBEuoNXNoEq0jJKmjnCR6X9GuZ
 dVeg2I0iLkN15M/qeye+10gVU9wzvxh+YG3vLS/2tIxWrunIWmP2hPOxPpRP3/1EsnF41
 LcBp+XddfLXq28k761mUk32qJLkw4SeTbe4CVL6XxtMncwDeGIBDWWd1cR7Ge8gx1zQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 0E3151F00A05;
 Thu, 12 Nov 2026 08:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794472389;
 bh=f2V/YaFbmkNwpcwUOxGNm0rVRQvd359hw4q7Khz/JZg=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=KU4CjDbmJUB3mI56R7N5o4Px/zgpiiT69Daq8hxNj4ZHFScYP6yxmRNdayml9V7Ft
 OEygsxNiOyDquNoXwz8a+ZcQufMhmFPWr5wzG2DJmyBdhsulWEPke2JPACcKihimkN
 5/lubmzaksxt4FJa6V/r73IezEvq8rBFKQRJ10ZOrN7iMSDkY/NoQX0IVIK06gaXN5
 MUkf5YeDMVuHNK1p+puDDGaF2afwb7IQiyRuj5qDTpmsG513XcIffRg43gEczFgHGh
 yYz6V9oesg3Wiri+hDlIz4aNY1V7amjmib85Ue2uZcmoiW9xsLRz0NntfUtWAyopMN
 pe9mrBvswpu5g==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 8B1C4493B2;
 Thu, 12 Nov 2026 08:33:06 +0000 (UTC)
From: Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org>
Date: Thu, 12 Nov 2026 08:33:08 +0000
Subject: [PATCH v2 4/9] drm/rockchip: vop2: Don't accept AFBC YTR for
 RGB565 on RK3588
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261112-vop2-fixes-v2-4-8218c1cf8ac8@gmail.com>
References: <20261112-vop2-fixes-v2-0-8218c1cf8ac8@gmail.com>
In-Reply-To: <20261112-vop2-fixes-v2-0-8218c1cf8ac8@gmail.com>
To: Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andyshrk@163.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Sascha Hauer <s.hauer@pengutronix.de>
Cc: Piotr Zalewski <pZ010001011111@proton.me>, 
 Chaoyi Chen <chaoyi.chen@rock-chips.com>, dri-devel@lists.freedesktop.org, 
 linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Arun Iyengar <aiyengar1990@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794472385; l=2483;
 i=aiyengar1990@gmail.com; s=20261110; h=from:subject:message-id;
 bh=zicfHKCrh3J+5OT0rCZ7q0n6EKLWMG1tKi6OQBCiWfY=;
 b=WYEFxJMDJiLWg8xWiv3UDH56/i2sRedWXBuz4XokRtrBXGWTUy7vDT5RAZu23v2lLctLqpZT2
 Sp8l3DeR9+hDU8Qu9hwaLTm4ZPcDp+0iYirywVG67WahjiuBqWa973r
X-Developer-Key: i=aiyengar1990@gmail.com; a=ed25519;
 pk=zXpRgUTrhaFe6jLyPqbBy3ccfkj04w0g2690Wv3mg+0=
X-Endpoint-Received: by B4 Relay for aiyengar1990@gmail.com/20261110 with
 auth_id=1480
X-Original-From: Arun Iyengar <aiyengar1990@gmail.com>
Content-Transfer-Encoding: 7bit
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
Reply-To: aiyengar1990@gmail.com
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_REPLYTO_END_DIGIT,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Arun Iyengar <aiyengar1990@gmail.com>

The Cluster windows of the RK3588 VOP2 advertise every AFBC modifier
of format_modifiers_afbc for RGB565 and BGR565, including the ones
with the lossless colour transform (YTR). Scanning out an RGB565
buffer rendered by the Mali-G610 (panfrost) with
AFBC(16x16 | SPARSE | YTR) gives a black picture and POST_BUF_EMPTY
on the video port, on every Cluster window, while the same buffer
rendered with AFBC(16x16 | SPARSE) displays correctly, as do 32 bpp
formats with YTR.

YTR on RGB565 is also a questionable pairing to start with:
Documentation/gpu/afbc.rst requires the R, G, B component order when
YTR is used, with component 0 in the least significant bits, which
DRM_FORMAT_RGB565 (B in the low bits) doesn't have, and the Arm
Mali-D71 (komeda) only accepts AFBC for BGR565.

Stop advertising and accepting YTR for the two 16 bpp RGB formats on
RK3588, so that userspace picks a modifier the decoder handles. The
BGR565 case could not be tested (Mesa can't import BGR565 dma-bufs),
it's rejected as well because the decoder is configured identically
for both formats, apart from the R/B swap after decoding.

Fixes: 5a028e8f062f ("drm/rockchip: vop2: Add support for rk3588")
Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
---
 drivers/gpu/drm/rockchip/rockchip_drm_vop2.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
index ea8d837d661f..7c157f5c1734 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
@@ -404,6 +404,18 @@ static bool rockchip_vop2_mod_supported(struct drm_plane *plane, u32 format,
 	if (vop2_convert_afbc_format(format) == VOP2_AFBC_FMT_INVALID)
 		return false;
 
+	/*
+	 * The AFBC decoder of the RK3588 Cluster windows can't decode 16 bpp
+	 * RGB that uses the lossless colour transform: the picture stays
+	 * black and the video port reports POST_BUF_EMPTY, while the same
+	 * buffers without YTR display fine.
+	 */
+	if (vop2->version == VOP_VERSION_RK3588 && (modifier & AFBC_FORMAT_MOD_YTR) &&
+	    (format == DRM_FORMAT_RGB565 || format == DRM_FORMAT_BGR565)) {
+		drm_dbg_kms(vop2->drm, "No AFBC YTR support for 16 bpp RGB\n");
+		return false;
+	}
+
 	/* Different windows have different format/modifier support */
 	for (i = 0; i < plane->modifier_count; i++) {
 		if (plane->modifiers[i] == modifier)

-- 
2.55.0


