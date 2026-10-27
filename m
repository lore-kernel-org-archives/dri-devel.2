Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 323A6606A31D
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 21:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=Wb9ekfs7
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7610810F82E;
	Tue, 27 Oct 2026 21:18:01 +0000 (UTC)
Received: from mail-pg1-f228.google.com (mail-pg1-f228.google.com
 [209.85.215.228])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 72D7810E4A7
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 21:17:48 +0000 (UTC)
Received: by mail-pg1-f228.google.com with SMTP id
 41be03b00d2f7-cd6acc50b8dso202547a12.3
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 14:17:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793135868; x=1793740668;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Z15Mxl6D/RVXRz+kYS1G8evAgIyEZyDMFRgpwmQMOpU=;
 b=YPpqKF49Riq6NkSWWK1S3nW9OqMcHRELRROi07BsKlzsRlssV4ThohVCg/LKLaDuJO
 zzsdq1scKHvuxLE31utrgAi94xA2uDLaYVneiZLkWhP8q2D46IgMaRopmK2HfsA1+a/9
 qxwDRznWVo5IAd693OFNWbyvSpY2mQIjlDUMyELvy/P6cS/aL37iUB5RnAvVTQwHVJpr
 4X4WMkSRU1fT/pC8ZK4WYdTXhL9JloKEZpbJaq7lp8cRkM0NszLm3v/yTpaQ65AyD4C2
 mwhaTKhqoZla4RsNBRuNR4r6vVcCh3c26ldE+s3pFehd315MwhSB06Yrk3hnHrpXG4vE
 Vsgw==
X-Gm-Message-State: AFq9FYIRwvHt7/2Mwrdu/kEJlUr8RFkyH3+GmAxa0/IqIwtmY6zXfZKj
 gc0itL34nBvBILiQ8z6Meg2MHnHM8Q+NgAYKm/IYCONjoRklESWCOoJjX/iDg59c1o4jo2gm0yG
 Iimn+XFtoAbrJ3p3bP6JtFNbGf430iyEp+rTz/ywNlsH5SiEhd0bImkPvh83olRNn9KvLuCHJBx
 QFmnbZCy8qNPPcOpsJDrKV3CIoLIKVRKVvLv6diIaTQEdbWebgCMSo22hFc2JtbyweC/X2P9n8v
 xXoNMeYQTowV/EPKI80
X-Gm-Gg: AYBFou2wZfO4MSSnZhxK7+iXBNOjse33lOJtfmu6hkvcTFiA+CIu/afyAo8YHa8Iw5x
 JXextz3TnvcwlY2YlzEx69u9F47lTBEx2p1i70jlZuR/zlMt7TllrUs8NHQ0T3eAmAaSZtNwl6n
 ys+lUTw748FYWwzhzfuE5B8oIkESD+5b/F62Ei2Hpu03Xf+xVliB9Bi/F4DbE0BYa/fnMDDdoCW
 rRWwH/tJzTCYszwe8BayDNTgtdcYPpcX84uOeBXpOFAYh6p4Uvlpqn/zuXJt7AxdBtrioOuO8BZ
 iWhIYPyoQDQMBFG1CvWPD7Y3V7XKc0MnqLuEqi+WxC1u5A1geYDnucSx9zHW5n55f84GbP1I3Ru
 RiZ+GeiqTAm42PxKlUpSZvQnQWxUnkYBXaIffFtEXs9uR+sB4x69TOEZ0hK0oZFn6u8wM5M5oE0
 zffbo8dR8MyprCh8IISq/jDERj84qMLB3NrSk=
X-Received: by 2002:a17:90b:5143:b0:3a7:8350:3f7e with SMTP id
 98e67ed59e1d1-3ae580e0f72mr201168a91.44.1793135867474; 
 Tue, 27 Oct 2026 14:17:47 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-120.dlp.protect.broadcom.com. [144.49.247.120])
 by smtp-relay.gmail.com with ESMTPS id
 98e67ed59e1d1-3ae5a2d736bsm10171a91.3.2026.10.27.14.17.47
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 27 Oct 2026 14:17:47 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-3548cdfd2fbso354211eec.1
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 14:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1793135866; x=1793740666;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Z15Mxl6D/RVXRz+kYS1G8evAgIyEZyDMFRgpwmQMOpU=;
 b=Wb9ekfs7yy4qLKybp/rQQ25uMBzwt4ROvDHNTW/QtX7p1W7TLeG49FpjOUsu8kkqtt
 CQnhcd1CLEQiyp4+3/gCCHZTcQpLthruJKl107z0wBfv90MPY6ELSW5eOey2GGmL5Wk4
 ZkfXeMmWwZwfRH11O0R+PZ7alyn3zrY+yQr5k=
X-Received: by 2002:a05:7300:d088:b0:36a:238:1485 with SMTP id
 5a478bee46e88-36a2016f3d3mr897566eec.37.1793135865719; 
 Tue, 27 Oct 2026 14:17:45 -0700 (PDT)
X-Received: by 2002:a05:7300:d088:b0:36a:238:1485 with SMTP id
 5a478bee46e88-36a2016f3d3mr897525eec.37.1793135864781; 
 Tue, 27 Oct 2026 14:17:44 -0700 (PDT)
Received: from vertex.localdomain
 (pool-173-49-113-140.phlapa.fios.verizon.net. [173.49.113.140])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-369e8c576ebsm35760859eec.3.2026.10.27.14.17.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 14:17:43 -0700 (PDT)
From: Zack Rusin <zack.rusin@broadcom.com>
To: dri-devel@lists.freedesktop.org
Cc: bcm-kernel-feedback-list@broadcom.com, ian.forbes@broadcom.com,
 maaz.mombasawala@broadcom.com, yunfeng.li.nb@gmail.com, tomas@slax.org,
 stable@vger.kernel.org, Zack Rusin <zack.rusin@broadcom.com>
Subject: [PATCH 3/6] drm/vmwgfx: include legacy hotspots in GB-only cursor
 images
Date: Tue, 27 Oct 2026 17:17:26 -0400
Message-ID: <20261027211729.646988-4-zack.rusin@broadcom.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261027211729.646988-1-zack.rusin@broadcom.com>
References: <20261027211729.646988-1-zack.rusin@broadcom.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
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
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Tomas M <tomas@slax.org>

The guest-backed cursor path without cursor MOB support defines the image
using only the hotspot from the plane state. Its position calculation
also includes the legacy hotspot supplied through DRM_VMW_CURSOR_BYPASS.

Xorg's xf86-video-vmware driver supplies its hotspot through that ioctl
and loads the image with drmModeSetCursor(), which does not set a plane
hotspot. The mismatched image and position hotspots displace the visible
cursor by the legacy offset.

Use the combined hotspot for both the GB-only image command and cursor
position, matching the legacy and MOB image paths.

Fixes: eef295a85082 ("drm/vmwgfx: Restore Guest-Backed only cursor plane support")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Tomas M <tomas@slax.org>
Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c b/drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c
index 14490ead99cd..f0661e5effeb 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c
@@ -852,6 +852,10 @@ vmw_cursor_plane_atomic_update(struct drm_plane *plane,
 		return;
 	}
 
+	/* Include legacy Xorg cursor-bypass offsets in the image and position. */
+	hotspot_x = vps->cursor.legacy.hotspot_x + new_state->hotspot_x;
+	hotspot_y = vps->cursor.legacy.hotspot_y + new_state->hotspot_y;
+
 	switch (vps->cursor.update_type) {
 	case VMW_CURSOR_UPDATE_LEGACY:
 		vmw_cursor_plane_update_legacy(dev_priv, vps);
@@ -864,8 +868,7 @@ vmw_cursor_plane_atomic_update(struct drm_plane *plane,
 			vmw_send_define_cursor_cmd(dev_priv, vps->cursor.map.virtual,
 						   vps->base.crtc_w,
 						   vps->base.crtc_h,
-						   vps->base.hotspot_x,
-						   vps->base.hotspot_y);
+						   hotspot_x, hotspot_y);
 		break;
 	case VMW_CURSOR_UPDATE_NONE:
 		/* do nothing */
@@ -878,9 +881,6 @@ vmw_cursor_plane_atomic_update(struct drm_plane *plane,
 	cursor_x = new_state->crtc_x + du->set_gui_x;
 	cursor_y = new_state->crtc_y + du->set_gui_y;
 
-	hotspot_x = vps->cursor.legacy.hotspot_x + new_state->hotspot_x;
-	hotspot_y = vps->cursor.legacy.hotspot_y + new_state->hotspot_y;
-
 	vmw_cursor_update_position(dev_priv, true, cursor_x + hotspot_x,
 				   cursor_y + hotspot_y);
 }
-- 
2.53.0

