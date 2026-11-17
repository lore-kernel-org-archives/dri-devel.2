Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB4B9606A32F
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 01:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=SWEUROTc
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 138C310EAC9;
	Tue, 17 Nov 2026 01:01:20 +0000 (UTC)
Received: from mail-pg1-f226.google.com (mail-pg1-f226.google.com
 [209.85.215.226])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2468410EAC9
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 01:01:14 +0000 (UTC)
Received: by mail-pg1-f226.google.com with SMTP id
 41be03b00d2f7-cc758830601so3793529a12.2
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 17:01:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794877273; x=1795482073;
 h=content-transfer-encoding:mime-version:reply-to:message-id:date
 :subject:cc:to:from:dkim-signature:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=CZVthfNBde5H7x9qVsFoduK9N4Ncht4h6sscBCrv0NM=;
 b=AX1jtPfFq3Ayl9Jekqyt2uwy9Yy+PuXqNsvTZ8AqvzFad4CB5ou2oUKcKCpd0dnvTJ
 regDK4+9UIRcqk5FsPvhZzlFsKvjTOtBxC4TcskFZeItCKS/0R4a235JUhpBsRI5Xw+H
 1/fUAIQ9IiSpZiy9n/HHnwpKTZIJX23AwosCGf/KUEe125hhswa9KE2aFXhggZLJNW5U
 Be+XEX/tqJRhM2yPFWRrMXOzp0SpUUMGYOa7iLDcbYTfHex6fDXTrccgkxSva6eefsSk
 BNg9lXxMEBoihzMTLGWHCvA6dGNyQkJ4YQDfvFy6w9yNdlEzCgclAslo8Lgs+uN9o46Y
 x0Og==
X-Gm-Message-State: APuU4Z+fCvO9tPRuIyZ5WS6yer2n/Yby+N6wTvUlfNfhrKDBeeZhhgre
 +62Q0wLcyUto8UWd2JB3j8c5rao3clF/2m9LJRjaieYHWT4ZHZX0AcA2pl6ECXkyojcggflCZCu
 rx3iarwRo0FxAz7tPuTlKnmJIblZktT8x8Q8vlktShGV2GiDmhjGD3dWcMFJNeP+gNZEEpyjHu+
 GvZIgwWd8kEvxBxNF71mgbSQUkXJX4mUSm2Nn36N7CyL7P25vOHBGwhMbTca8Mdop0+W2YUYMFp
 PyAem+yR+5OcRXsyHo5WUEp3EjP
X-Gm-Gg: AZFdTZfsOCz48V61lxGo4Thpa5Ug17V1bsj2IifggzHRTdjedU9xotmkZgHpkhjeTdK
 FfthlrPNKZSp3S3w0+OvApDKWpgVNiCUbLi1XB3twm9r5Ssd+8ncNtUcqfj4i7+X/08/kO18EZ+
 dw0gOEte9peG9QhTytlJNyJZxRyUwedPVhKtAgy7JtdF80JmBuMNgcPSr1w3epE1LG8u5iOfENA
 zrGiJadixLuIgKxOH7UJZbnfoejKK5FMPCMLNrGgPQRs1jDCOGsHVNzRfR1xt265Acct51ejP0r
 g9Ip+fSb+scefPKq2p9AIbSLtoYXoCXUX/ULl9E2tgruGgUA0ItF5/buucYwqM4gsT8ycOvaJle
 RedPY/PF0uB8/zhxHK0xqGGRJ4/t1fhtvd32zwEIwinhvciDvwZmp4ubO/7BKBM0Ojs0e/j6oR/
 FNAtZ1XqwLh6bApWakYhtt85XonYTJUTX3zqkVWPRn
X-Received: by 2002:a17:90a:ec86:b0:3ac:7377:fd48 with SMTP id
 98e67ed59e1d1-3b1b0d228a2mr12010975a91.56.1794877273501; 
 Mon, 16 Nov 2026 17:01:13 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-28.dlp.protect.broadcom.com. [144.49.247.28])
 by smtp-relay.gmail.com with ESMTPS id
 98e67ed59e1d1-3b3ab9f98bdsm771520a91.0.2026.11.16.17.01.13
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 16 Nov 2026 17:01:13 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-370230d93efso4492210eec.1
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 17:01:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1794877272; x=1795482072;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:reply-to:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=CZVthfNBde5H7x9qVsFoduK9N4Ncht4h6sscBCrv0NM=;
 b=SWEUROTc/1RWkMpACHG3g4CrCyIeTdbYeGJZHEwUSfetLCHMxtZzj4NLVG7rdWMNGT
 mA4C2VA1YA1DFQhF8FdaDXYm7CdAYE+a59QpBRXfaSCgowRU48n5ysCQQEoUsDvBabgB
 jvPPk++ishM00uKD94TwMdaO3iDY3QMVfCbrk=
X-Received: by 2002:a05:693c:8105:b0:36a:1d6f:917c with SMTP id
 5a478bee46e88-3796731337bmr13130695eec.22.1794877271299; 
 Mon, 16 Nov 2026 17:01:11 -0800 (PST)
X-Received: by 2002:a05:693c:8105:b0:36a:1d6f:917c with SMTP id
 5a478bee46e88-3796731337bmr13130623eec.22.1794877269849; 
 Mon, 16 Nov 2026 17:01:09 -0800 (PST)
Received: from mombasawalam-Precision-5820-Tower.cap.broadcom.net
 ([192.19.50.250]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-379508762a5sm37576219eec.0.2026.11.16.17.01.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 17:01:09 -0800 (PST)
From: Maaz Mombasawala <maaz.mombasawala@broadcom.com>
To: dri-devel@lists.freedesktop.org
Cc: bcm-kernel-feedback-list@broadcom.com, ian.forbes@broadcom.com,
 zack.rusin@broadcom.com, Maaz Mombasawala <maaz.mombasawala@broadcom.com>
Subject: [PATCH v7] drm/vmwgfx: Add some checks to
 vmw_cursor_plane_atomic_update
Date: Mon, 16 Nov 2026 17:02:45 -0800
Message-ID: <20261117010244.807279-2-maaz.mombasawala@broadcom.com>
X-Mailer: git-send-email 2.56.1
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
Reply-To: Maaz Mombasawala <maaz.mombasawala@broadcom.com>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

In cases where old_state may not be present we hit a null dereference.
Get display unit from cursor plane instead to fix this and also do an
early return if there is no new_state since there is nothing to do in
that case.
This fixes igt test kms_cursor_legacy@torture-bo.

Fixes: 965544150d1c ("drm/vmwgfx: Refactor cursor handling")
Cc: Zack Rusin <zack.rusin@broadcom.com>
Cc: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Maaz Mombasawala <maaz.mombasawala@broadcom.com>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c b/drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c
index b678e5b68db7..16e6635ef4ce 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c
@@ -22,6 +22,9 @@
 #define VMW_CURSOR_SNOOP_WIDTH 64
 #define VMW_CURSOR_SNOOP_HEIGHT 64
 
+#define vmw_cursor_to_du(cursor_plane) \
+	container_of(cursor_plane, struct vmw_display_unit, cursor.base)
+
 struct vmw_svga_fifo_cmd_define_cursor {
 	u32 cmd;
 	SVGAFifoCmdDefineAlphaCursor cursor;
@@ -866,16 +869,17 @@ void
 vmw_cursor_plane_atomic_update(struct drm_plane *plane,
 			       struct drm_atomic_commit *state)
 {
-	struct drm_plane_state *new_state =
-		drm_atomic_get_new_plane_state(state, plane);
-	struct drm_plane_state *old_state =
-		drm_atomic_get_old_plane_state(state, plane);
-	struct drm_crtc *crtc = new_state->crtc ?: old_state->crtc;
+	struct drm_plane_state *new_state;
 	struct vmw_private *dev_priv = vmw_priv(plane->dev);
-	struct vmw_display_unit *du = vmw_crtc_to_du(crtc);
-	struct vmw_plane_state *vps = vmw_plane_state_to_vps(new_state);
+	struct vmw_display_unit *du = vmw_cursor_to_du(plane);
+	struct vmw_plane_state *vps;
 	s32 hotspot_x, hotspot_y, cursor_x, cursor_y;
 
+	new_state = drm_atomic_get_new_plane_state(state, plane);
+	if (!new_state)
+		return;
+	vps = vmw_plane_state_to_vps(new_state);
+
 	/*
 	 * Hide the cursor if the new bo is null
 	 */
-- 
2.56.1

