Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F0F2F9D0F2
	for <dri-devel@archiver.kernel.org>; Tue, 14 Apr 2026 20:08:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1282D10E11F;
	Tue, 14 Apr 2026 20:08:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=broadcom.com header.i=@broadcom.com header.b="XEqMHA/5";
	dkim-atps=neutral
Received: from mail-pj1-f97.google.com (mail-pj1-f97.google.com
 [209.85.216.97])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 292D410E11F
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Apr 2026 20:08:33 +0000 (UTC)
Received: by mail-pj1-f97.google.com with SMTP id
 98e67ed59e1d1-35d95017a68so3756435a91.3
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Apr 2026 13:08:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776197313; x=1776802113;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Sux7YH2BNSA0pOS1LVtGWgmetjd2E/yzZ7Zm/DhfKLE=;
 b=HLCyaI2Eztoi8FVOipG6CJRqb1kAsh3Wvxv6fd4NG7y0MhVbWu/3Tnp8jZGP54qqrn
 4Zn3pKBTithzNFYqQINM/98oEahOunWPV8myXdeJYsO50nBzexuB9gtb+asZb5eGWJjt
 0xCw3wciWD4agKc0MOFGv6QXMGA08MmlRgCqW9TdaCRt4IM9xhjVg3R/r3GEudvYm/VH
 O8Inm65vrTc/zAhQD5ivUbGss6Nu2njlCkyjV60g5QytWbcrOAgQNCeU1/hG53aYdVSG
 v8gcQFncpPe0lgc/n2RlwbOrCTsFDjFRdfn0tvALNtkikKUtbmOKIgL7jVQtXjnKXV8J
 vuMw==
X-Gm-Message-State: AOJu0YzVBpuQomC9iCWEntdDOmnkg0KkTo+WIRj8knOav4y8sEpF9c2u
 QpeqQtA/5tAuYD4n5hz+fXyQpPsXzdMaAJ+mGHinRgxj4nwwUfGPXQLwUvea5i2ACm8wurndItB
 iXUr4yIHC3mEtzNs70tautAzGfVOiQjVpkaCriDr6CYvCi+he+tWQHvsmNdTnnAeWDTEImLS1uz
 QvBAfCR81jybTviGZvUM9LktLsUU1yM27U27NZCLyXMWElPI5OSq2xT8F/JeuSigqYCox56DJmZ
 yzb16k7DVadpTb1uFir
X-Gm-Gg: AeBDietaImkuh4iVfLmFJOToD4IstaEARVPxK//mKHggT9Wj3rTaDvCT9LlW236JYvX
 Sundv/sfmCrwxC58M8jNnBHlGRIWBTOKV/V43ja9FMATu3dZiyvvKEXTNhIbChjGVSVqQTdRYhZ
 Iv5IKYCUPBiGugIUrE/ffEkC2cftoToNzp9TlomxJlAdMuWo0UIZpPhTz4l7aYzwTAAJzPo20vl
 6NPsAkpuYoiPjKCyzlSPqAyQYWMKKNIXlv6SdqQlNSaM9o9e2LmMtKLxUc/C9k1erS27K/Z380L
 e1WAyJ32HlF3wqo8EWxtxnbMoW72q2cLjcAPyMNuIYNbwdWtTXrQme/txJJvB0Sew+smn45vtHg
 RgW1h01yusSsB+91kXGAxmCpjUhmsHiSR4R8SLZKPr2DqIjfrnoLQxcVVABpbJELc+DDZ2p0R6V
 aDU9zN3uRqLlFb+2tkds/hFSuJwBRUD5IdqVy7P3/VTCWtDChdPQzjFH2drXQgwX+o
X-Received: by 2002:a17:90b:33ca:b0:35f:b4c7:b626 with SMTP id
 98e67ed59e1d1-35fb4c7bb12mr9631328a91.18.1776197312567; 
 Tue, 14 Apr 2026 13:08:32 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-29.dlp.protect.broadcom.com. [144.49.247.29])
 by smtp-relay.gmail.com with ESMTPS id
 98e67ed59e1d1-35fd0f4d141sm2937a91.1.2026.04.14.13.08.32
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 14 Apr 2026 13:08:32 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-12711ec96fbso25112644c88.0
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Apr 2026 13:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1776197310; x=1776802110;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Sux7YH2BNSA0pOS1LVtGWgmetjd2E/yzZ7Zm/DhfKLE=;
 b=XEqMHA/5hn7CRxUBsJ1sxvDsbGyrHlq5Ehjd2HikoV7e8SCa/MJ97o6t3xoHQ7xcJw
 9LWHbpgJdhMU3RZ0K27dBO0J1429xe+OPoR3or0M4JT7vmNnceRLhCD5etpk36KvBy+d
 x8UzhwMlB27xKAlXqzHKk9EYJx1fTVb1oNx3E=
X-Received: by 2002:a05:7022:6187:b0:11d:e40f:ee69 with SMTP id
 a92af1059eb24-12c34f273b7mr10883157c88.36.1776197310297; 
 Tue, 14 Apr 2026 13:08:30 -0700 (PDT)
X-Received: by 2002:a05:7022:6187:b0:11d:e40f:ee69 with SMTP id
 a92af1059eb24-12c34f273b7mr10883120c88.36.1776197309622; 
 Tue, 14 Apr 2026 13:08:29 -0700 (PDT)
Received: from plasma.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12c346fb141sm19408032c88.12.2026.04.14.13.08.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Apr 2026 13:08:29 -0700 (PDT)
From: Ian Forbes <ian.forbes@broadcom.com>
To: dri-devel@lists.freedesktop.org
Cc: bcm-kernel-feedback-list@broadcom.com, zack.rusin@broadcom.com,
 maaz.mombasawala@broadcom.com, Ian Forbes <ian.forbes@broadcom.com>
Subject: [PATCH 2/3] drm/vmwgfx: Check for cursor plane changes earlier in
 prepare_fb
Date: Tue, 14 Apr 2026 15:08:18 -0500
Message-ID: <20260414200819.88506-2-ian.forbes@broadcom.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260414200819.88506-1-ian.forbes@broadcom.com>
References: <20260414200819.88506-1-ian.forbes@broadcom.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
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

We can avoid extra work if we check for changes earlier in prepare_fb.
This avoids mapping a number of BOs.

Signed-off-by: Ian Forbes <ian.forbes@broadcom.com>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c | 21 ++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c b/drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c
index 125080c2a018..4f009aa586ac 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c
@@ -588,6 +588,17 @@ int vmw_cursor_plane_prepare_fb(struct drm_plane *plane,
 		break;
 	case VMW_CURSOR_UPDATE_GB_ONLY:
 	case VMW_CURSOR_UPDATE_MOB: {
+		if (!vmw_user_object_is_null(&vps->uo)) {
+			if (!vmw_cursor_plane_changed(vps, old_vps) &&
+			    !vmw_cursor_buffer_changed(vps, old_vps)) {
+				vps->cursor.update_type = VMW_CURSOR_UPDATE_NONE;
+				return 0;
+			}
+			if (vps->cursor.update_type == VMW_CURSOR_UPDATE_MOB) {
+				vmw_cursor_mob_get(vcp, vps);
+				vmw_cursor_mob_map(vps);
+			}
+		}
 		bo = vmw_user_object_buffer(&vps->uo);
 		if (bo) {
 			u32 size;
@@ -617,16 +628,6 @@ int vmw_cursor_plane_prepare_fb(struct drm_plane *plane,
 			ttm_bo_kmap(&bo->tbo, 0, PFN_UP(size), &vps->cursor.src_map);
 			ttm_bo_unreserve(&bo->tbo);
 		}
-		if (!vmw_user_object_is_null(&vps->uo)) {
-			if (!vmw_cursor_plane_changed(vps, old_vps) &&
-			    !vmw_cursor_buffer_changed(vps, old_vps)) {
-				vps->cursor.update_type =
-					VMW_CURSOR_UPDATE_NONE;
-			} else {
-				vmw_cursor_mob_get(vcp, vps);
-				vmw_cursor_mob_map(vps);
-			}
-		}
 	}
 		break;
 	case VMW_CURSOR_UPDATE_NONE:
-- 
2.53.0

