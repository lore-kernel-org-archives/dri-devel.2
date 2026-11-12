Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5FFE606C821
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 08:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dvRoKTUe
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C82A10FC6B;
	Thu, 12 Nov 2026 08:33:18 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC0F910EB68
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 08:33:12 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C7AA447914;
 Thu, 12 Nov 2026 08:33:10 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1794472390;
 b=waCX05Diok23MLZF/zLOIQ52uvRtHzsQjFes/WBkDtDfzNuh+TriRJIZo17CePoZGK6v
 ZLmRDFrTyINR4LW8/G/cgtImmex3RtV5RLhGLoaHsvQgIYjIKB9OLmRhE5248LLV9oShz
 u7xDPVIxtLpxqyMKNfXZpSb74KOEwlHO66vLuxdgOiThXjHnWN7HJ/GMrjD9UsqH9vYgX
 oOO2qcyfjZQToXDI2Qz2Dlwt9X0itedi5UM5UG5AKb7ERrcJvakcki6xgn39mKWWwCXad
 frm29jH1JAVBGutPxLOK8VyZZ7IV3XdAePzpAlGN/RaOC2Qphvj3VWy4IOoY0XqaGkQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1794472390;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=1XKbNH2/KH99YbWTOs529XIXwoRw5zG3NS6qzqt74p8=;
 b=osh3AJtbSd2jdnf/krpwJM4JHOsxKWklkahrXlmHPipWMoTWt49h6H5ns+3uQyJIah0v
 7gpS1TcVseQCmD8l9aeJLbvzGTVDxhXp/MKD3TMW1FjRSr6UkPC5li27mCbO4HSW5zUeb
 R2rANnaz5K3RRfev9f8Dp4IqWlq2SiPMGD30o0uejBtcBTif3ANcyvYjZWwXc5uXkeMT/
 fEhDeXIBWMGL+yYgfD+IAetTLAoAwUtvI6D6D3F5trcBnpvDLNUs9d47qC5o8dDx8ZCOr
 jP76Go4U/fE5qRc+oH8cng0ffqsAEA8aRKxzYJo8A4yphjv7BBs7Ne/omFGNDUpJVsg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id F2C7D1F00A0E;
 Thu, 12 Nov 2026 08:33:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794472390;
 bh=1XKbNH2/KH99YbWTOs529XIXwoRw5zG3NS6qzqt74p8=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=dvRoKTUe5c0tIh5y3rUyPYZVEdpcAMzud+1SnMbRvG2AAmBeDsf5rTMCi8jwkiNHW
 9/LzT0jwXry8lokd0uxJo7vtApVzw/c/CF9IhN5ddPqU12W2VuuwrpDGHSy/feS9pQ
 mR11l2iStfaRaqgbyB0NxEgnu9M672jK7dDEW7RKqm/uP4ynznRhHNVELvAUok9EoD
 7d92mxN4bkfooFrzYJ2Eq+KeklZK94PWlW3XM20pDUGAIkROI/r9pEaT09ie5f2BOJ
 O4lnJJn6spd6h42qQCjVvCV9O2bEJvS/wNCDBjb2vcDGGoRYumEp31mJTAD09OpXWS
 OAqBQ6dd35Q8A==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id D9CC9493C2;
 Thu, 12 Nov 2026 08:33:06 +0000 (UTC)
From: Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org>
Date: Thu, 12 Nov 2026 08:33:12 +0000
Subject: [PATCH v2 8/9] drm/rockchip: vop2: Keep the other LUT_PORT_SEL
 fields on gamma LUT updates
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261112-vop2-fixes-v2-8-8218c1cf8ac8@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794472385; l=1484;
 i=aiyengar1990@gmail.com; s=20261110; h=from:subject:message-id;
 bh=WoObJhqQCguUZVQZS4V4CMddVbsfxO9PvoIdXFATrrs=;
 b=v7uDMm0D5IZjEF8Q5Kr1g/6NEsROZFDbJNyG8T4DzjiDBiH8wCp30u+EhYBiyuDF763+7vlzQ
 bJgLrzzMHGNCZcwDdpAx1LSPmEsbt8swnR9cpsqp3RGWTLsr2tvXF0n
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

On RK3588 the gamma LUT of a video port is written through a window that
GAMMA_AHB_WRITE_SEL in SYS_CTRL_LUT_PORT_SEL selects. The register also
holds the dclk source selection of video ports 0 and 2 and the enable of
the video port 0/1 merge for modes wider than 4096 pixels, which writing
the whole register clears.

Only update the write select field.

Fixes: 4f537776340d ("rockchip/drm: vop2: add support for gamma LUT")
Reviewed-by: Chaoyi Chen <chaoyi.chen@rock-chips.com>
Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
---
 drivers/gpu/drm/rockchip/rockchip_drm_vop2.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
index c59e270739b6..259e30ebb9cb 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
@@ -2015,8 +2015,9 @@ static void vop2_crtc_atomic_set_gamma_seamless(struct vop2 *vop2,
 						struct vop2_video_port *vp,
 						struct drm_crtc *crtc)
 {
-	vop2_writel(vop2, RK3568_LUT_PORT_SEL,
-		    FIELD_PREP(RK3588_LUT_PORT_SEL__GAMMA_AHB_WRITE_SEL, vp->id));
+	regmap_update_bits(vop2->map, RK3568_LUT_PORT_SEL,
+			   RK3588_LUT_PORT_SEL__GAMMA_AHB_WRITE_SEL,
+			   FIELD_PREP(RK3588_LUT_PORT_SEL__GAMMA_AHB_WRITE_SEL, vp->id));
 	vop2_vp_dsp_lut_enable(vp);
 	vop2_crtc_write_gamma_lut(vop2, crtc);
 	vop2_vp_dsp_lut_update_enable(vp);

-- 
2.55.0


