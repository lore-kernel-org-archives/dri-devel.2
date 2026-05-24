Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43F90CD5BB1
	for <dri-devel@archiver.kernel.org>; Sun, 24 May 2026 16:27:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 48E5610E25F;
	Sun, 24 May 2026 16:27:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="oesAuBRh";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC64810E25F
 for <dri-devel@lists.freedesktop.org>; Sun, 24 May 2026 16:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1779640063;
 bh=3XI839pwxOLRxjr8d7Rv3qpB1MWRN40cGsaWsPNwOV0=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=oesAuBRhT6O91wQCN1909BKv8YMxG/S/GIg6BmO0P9hhH96OJD0upGonxP0I5V20F
 21JIiuqU5/1QOB6/5qQR3Yz/CA8napkQRkz6evHu7AMVSbSD93Z/4jM74goayNAFVz
 5b/MVk1VsFSTenSNHtWYtmew/Hl2V/eZx1XdeE61db2sR8a6X6capn52Pq5O+rJ/Ow
 9p6l2iHiBApDYJ0BGN580fl2Jqf51OugWc4KCrc8QgnA7ou2A5xqL1VjwMPZX5K18W
 6G/8VuXxl4SmWDfOZXRcL5qrcUtRnvpDYdbNAOtGQwyEPq0y+zrvFPhx0qUazVCqvD
 NkVEfUI+yvLnw==
Received: from localhost (unknown [100.64.0.241])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: cristicc)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id DF54317E0977;
 Sun, 24 May 2026 18:27:42 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Sun, 24 May 2026 19:27:28 +0300
Subject: [PATCH 1/2] drm/rockchip: vop2: Rename CSC_BT2020 to CSC_BT2020L
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260524-vop2-bg-yuv-v1-1-dcb6a52923f5@collabora.com>
References: <20260524-vop2-bg-yuv-v1-0-dcb6a52923f5@collabora.com>
In-Reply-To: <20260524-vop2-bg-yuv-v1-0-dcb6a52923f5@collabora.com>
To: Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: kernel@collabora.com, dri-devel@lists.freedesktop.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Rename CSC_BT2020 to CSC_BT2020L for consistency with the other
limited-range enum members (CSC_BT601L, CSC_BT709L) and to distinguish
it from a potential future full-range BT.2020 variant.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/gpu/drm/rockchip/rockchip_drm_vop2.c | 2 +-
 drivers/gpu/drm/rockchip/rockchip_drm_vop2.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
index a160077a507f..64ac07cb1b0d 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
@@ -658,7 +658,7 @@ static int vop2_convert_csc_mode(int csc_mode)
 	case V4L2_COLORSPACE_JPEG:
 		return CSC_BT601F;
 	case V4L2_COLORSPACE_BT2020:
-		return CSC_BT2020;
+		return CSC_BT2020L;
 	default:
 		return CSC_BT709L;
 	}
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.h b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.h
index 37722652844a..ffcb39c130aa 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.h
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.h
@@ -373,7 +373,7 @@ enum vop_csc_format {
 	CSC_BT601L,
 	CSC_BT709L,
 	CSC_BT601F,
-	CSC_BT2020,
+	CSC_BT2020L,
 };
 
 enum src_factor_mode {

-- 
2.54.0

