Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2FC9606A332
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 07:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OYDwUbn2
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2225D10EE32;
	Tue, 10 Nov 2026 07:19:08 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2074210E92D
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 07:18:52 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D17C543835;
 Tue, 10 Nov 2026 07:18:51 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1794295131;
 b=D2MbeHoA3l9YEyTFjG6JSCv2nSTvTCXoo7XxfkG4KBsC50tna4C+lb48ZaXxr6+zi1uf
 32GHvwr3w7TLl8PcFRDdrUGDcZ8Q0ingE8Xg7z4c5XnLU7h+YJEbqgMUzbNawTV3xjD3+
 SR5bdr4RoulvvvqAIV0VwoG7T6ZWMEJw4fniXCrwvj0wBRlgcFJfFrB5+/DA2nhgRpMkM
 p/L4xMmJ7O8wKM3VvA0ODALLfQ49Wl5vElplbZdJiFBpkWIRjx77ffC9EncoPwCAhPBOF
 NvMgUDI+X5a3bUCvkp36AWo3lWZ6VjIRKn6xSFWcRl2ThcozP27QCVB9BcqauIlxw9w==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1794295131;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=htUIZOmME/MasIKcXZAexGRPo4KujE2PBLv1BZKe0IE=;
 b=29vGMnje0V87AaKBpdMLeSxCNGBkmTyjrA1KxjGeJdND58jqt18uY6a/KpPqIKZYKyp6
 NtILRDdKiE3mzYj9Zo2sxNjIRg9rNabowTH05lTllGGBWmQ7RhSC8lEHBu0gazepyY5vr
 rnIJMXJId5Pgrm7GrpYLQoirF8GghNds5N+Qd6fplvfkC0bm9XlAadEk2q9m5e+jSHXnT
 TUIyTDyDKT9oLRt1h7RJZd87etouFrRE6ITZ2jWiqCxetKQv6SHSX9RiFYxRSqQ60WpNv
 AqyNLwiD3JDKWBT4w+JlrXmcCyJMoS0Yclc6O/GCxokH6iHSZK2p+QZX24TTEIEXxUg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 4F6E51F008BE;
 Tue, 10 Nov 2026 07:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794295131;
 bh=htUIZOmME/MasIKcXZAexGRPo4KujE2PBLv1BZKe0IE=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=OYDwUbn2gEwRXz2qB2TZ+eeMrRS5Xx6tMq4D3s6TIcah937bd57UtdMbB/xMPd/Ql
 VUMzsyZkVsUEBMIH3KxZjs/7OjiBcwiqF0yDOIkjRVUG+1pez3I78nsyHXCxpdaVts
 qugXzw2ZCl0NSk+VHbUQas2zXI7ZaiuR9sDuXNyLzzLEodcOIeimn7NcIWfNVM/Pcp
 bgYVWk1cXhe2GwBAQU49youTQWpppsErJHl5J7vTAoybYa7dods0FmOxviNnjap8LO
 pcfL4JL7IFcf+WrVix7cfWT8Ch4AZmKEivctch8+thyLL3m2s21OwPzgE55LP4xihd
 YrWmPUv6L+REg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id D834F489BD;
 Tue, 10 Nov 2026 07:18:49 +0000 (UTC)
From: Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org>
Date: Tue, 10 Nov 2026 07:18:51 +0000
Subject: [PATCH 3/8] drm/rockchip: vop2: Don't accept AFBC YTR for RGB565
 on RK3588
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261110-vop2-fixes-v1-3-d336e9dd90d3@gmail.com>
References: <20261110-vop2-fixes-v1-0-d336e9dd90d3@gmail.com>
In-Reply-To: <20261110-vop2-fixes-v1-0-d336e9dd90d3@gmail.com>
To: Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andyshrk@163.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Sascha Hauer <s.hauer@pengutronix.de>
Cc: dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794295129; l=2483;
 i=aiyengar1990@gmail.com; s=20261110; h=from:subject:message-id;
 bh=dSPTheuoeEWtYE05OjR52Fc58lXeV69Gfn0Qylp8Rv0=;
 b=s4HVCmDwgYdPn6T1iLJbkUsMIfeJ+cpWRdDnv8reZ6dalUFrLsggZfWE8XBkuxhFbsVyfPrTF
 HxKH211/MEGDHFmDV3N05Sk2K5j1912ImX9Eti7sR9lTWRyJEJmQfnB
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
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
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
index 76d151b8bc52..629ea7f11250 100644
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


