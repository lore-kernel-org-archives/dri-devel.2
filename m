Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7230C982DE
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 07:00:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E665310E42A;
	Mon, 21 Sep 2026 07:00:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="l13oKn9f";
	dkim-atps=neutral
Received: from mail-pz2-f42.google.com (mail-pz2-f42.google.com
 [74.125.228.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8611210E5B4
 for <dri-devel@lists.freedesktop.org>; Sat, 19 Sep 2026 22:35:17 +0000 (UTC)
Received: by mail-pz2-f42.google.com with SMTP id
 41be03b00d2f7-cc1cea34f01so1581676a12.1
 for <dri-devel@lists.freedesktop.org>; Sat, 19 Sep 2026 15:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789857317; x=1790462117; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=sWVtXHvtsUvayjaRC+3RJzYPnLIstthkOPPeTp9RMJw=;
 b=l13oKn9fMAeP+6SgtzLtVjw3opTsd0Gl9Ead6h6Nx0sAfKpzzuf1YV+qKeTJXZCoFM
 NUiPmIZbSHTjJgh0Zk1TGRcZJSHcx8nBdzXe5poOFMtlrTE6cbtCQ56BnNqg6Vw6hZ+A
 bL95smrDkkY4jsBVp5MZAvTltq+HQIZ5QgEJdq8mTT5dcvJ8NvPpahgZluSwHduWQe8E
 qqVxMEGvPGvcIOb/2q2i6n0iAFjdIfUHB8YSjPNTPYjI8AY7Z5hO/7WgsbY7eu6MnmZx
 4wNAMC9FskGSt7+gklaswHi4ScwwKgS7RWBb5rOwAuWW8MY8psVpKsaC2CH7FCnxb1Wi
 aqbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789857317; x=1790462117;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sWVtXHvtsUvayjaRC+3RJzYPnLIstthkOPPeTp9RMJw=;
 b=tUDS5iFZqz0r8CHDlpuwN9vpgoIAI2VZbh/bBa/b115m4089xPHJxqR0Kb2vpFb4MR
 3bbKfDxEDn/8/tZTeif1y8SPb1RNtJHXWHeRdOzVMyvWK+b+3GIE2hXHSCN+i3KrjFqs
 PSWwPy83BGuSKJ/cKDl+X1bGUJha1r8ttUn9ANd5qnftF5LSKNh2bri9uz7hmi2Y3F0f
 umK1vR5D4z8C34WBm4m1YGaBIQ/tEpPqUsmMkvZWCCVINwatyvtaabOeAN4HrsHXrv//
 eFT1QIuBEmQZhIk0/uFhgEQE1fjP2PDq1lvuL+U0M9YKdiVU/FDvwiC2DU/uZjFsMDY5
 0ozw==
X-Gm-Message-State: AFuF++nXz1kcgqdq4YgYG7F9Ow9t2rvvp/XgFTLmEhmWSasct92BJJai
 cNd8GgY2rhKm1pnMTbEQPFn9rPighw8DX9kcIbHjQLjBQl73qC2XFpiA
X-Gm-Gg: AYBFou3y5qZwOwm6LFVqyCWU21erfRHdAzRqNiMtJm7Kd+ObALLZCzP7780uuF5Cesb
 vxHmVKKEXyfzr9mo0HBk/AosXxtvXDlsgl/kn4Qb/cNxLtLjfy+jc19DinFDtREv6T5y7y4vKRk
 APNdIA6VRAMJeqTDFoM3aGRTRpcuJJhNMhdGccjXvS5sKpXHSWBo8EaHXsOVld1UJAXpzq5xw18
 7ifDsjC1THgP2Eozf0/REEka1sWPYWdyyEEOCCKOG0zGf08T+N8NkXH9YCfT+DEK7XpRy5dcI+d
 nT+pCT/OfP02dc9mHFhWNy28nwq2tH+REzVwQCBzVn91V4axixAykrEPnBSr+8AvOXmDY2FNmUU
 c51tKQltWG2ou9QUSgC69UpMuKEobkNOhXm+UpQqUcGv3XsX+TskdHlxEwK4tUjFVeqSN58q1nw
 FHx9IFNaGOXFp+0X8Nuu79JpuYFV3wIHLVzrhEjPxHBnlVkBlHB0cVivsiSfw38LLDs3KdrigEm
 LVe2j7DMdlRkHJDf5MZP94hz/c9yPYslWTyBVX+KIxZVdVTgOkfGpRsy+TSMVLBn9IAAyPM7E5G
 rD7bl3Leog==
X-Received: by 2002:a17:90a:c88d:b0:39e:4c81:6c94 with SMTP id
 98e67ed59e1d1-39e54f24890mr11527341a91.26.1789857317078; 
 Sat, 19 Sep 2026 15:35:17 -0700 (PDT)
Received: from phui-2.c.googlers.com.com
 (78.123.83.34.bc.googleusercontent.com. [34.83.123.78])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39e6cb400c3sm6307621a91.17.2026.09.19.15.35.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Sep 2026 15:35:16 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: tzimmermann@suse.de, jfalempe@redhat.com, simona@ffwll.ch,
 airlied@redhat.com
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drm/ast: validate framebuffer VRAM size in ast_mode.c and
 DP501 firmware bounds
Date: Sat, 19 Sep 2026 22:35:16 +0000
Message-ID: <20260919223516.3889946-1-benquike@gmail.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 21 Sep 2026 07:00:14 +0000
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

In drivers/gpu/drm/ast/ (ast_mode.c, ast_dp501.c), verify that the
primary plane framebuffer fits within ast->vram_size and bounds-check
DP501 firmware headers.

Fixes: 312fec1405dd ("drm: Initial KMS driver for AST (ASpeed Technologies) 2000 series (v2)")
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>
---
diff --git a/drivers/gpu/drm/ast/ast_dp501.c b/drivers/gpu/drm/ast/ast_dp501.c
index 6d6ccfad1415..d9ca8760e5b5 100644
--- a/drivers/gpu/drm/ast/ast_dp501.c
+++ b/drivers/gpu/drm/ast/ast_dp501.c
@@ -250,7 +250,8 @@ static bool ast_launch_m68k(struct ast_device *ast)
 
 		/* copy image to buffer */
 		for (i = 0; i < len; i += 4) {
-			data = *(u32 *)(fw_addr + i);
+			data = 0;
+			memcpy(&data, fw_addr + i, min_t(u32, len - i, 4));
 			ast_moutdwm(ast, boot_address + i, data);
 		}
 
diff --git a/drivers/gpu/drm/ast/ast_mode.c b/drivers/gpu/drm/ast/ast_mode.c
index d5ed8c5c7925..bde9dcbbc32b 100644
--- a/drivers/gpu/drm/ast/ast_mode.c
+++ b/drivers/gpu/drm/ast/ast_mode.c
@@ -510,6 +510,7 @@ static int ast_primary_plane_helper_atomic_check(struct drm_plane *plane,
 						 struct drm_atomic_commit *state)
 {
 	struct drm_device *dev = plane->dev;
+	struct ast_plane *ast_plane = to_ast_plane(plane);
 	struct drm_plane_state *new_plane_state = drm_atomic_get_new_plane_state(state, plane);
 	struct drm_crtc_state *new_crtc_state = NULL;
 	struct ast_crtc_state *new_ast_crtc_state;
@@ -531,6 +532,11 @@ static int ast_primary_plane_helper_atomic_check(struct drm_plane *plane,
 			return 0;
 	}
 
+	if (new_plane_state->fb->pitches[0] > AST_PRIMARY_PLANE_MAX_OFFSET)
+		return -EINVAL;
+	if ((u64)new_plane_state->fb->pitches[0] * new_plane_state->fb->height > ast_plane->size)
+		return -ENOSPC;
+
 	new_ast_crtc_state = to_ast_crtc_state(new_crtc_state);
 
 	new_ast_crtc_state->format = new_plane_state->fb->format;
