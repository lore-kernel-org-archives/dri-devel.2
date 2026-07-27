Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC6CFC531D0
	for <dri-devel@archiver.kernel.org>; Mon, 27 Jul 2026 18:21:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3002910E124;
	Mon, 27 Jul 2026 18:21:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=broadcom.com header.i=@broadcom.com header.b="AtlcJW1a";
	dkim-atps=neutral
Received: from mail-yx1-f98.google.com (mail-yx1-f98.google.com
 [74.125.224.98])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C6C9910E124
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Jul 2026 18:21:54 +0000 (UTC)
Received: by mail-yx1-f98.google.com with SMTP id
 956f58d0204a3-6681e7911b0so4097726d50.0
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Jul 2026 11:21:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785176513; x=1785781313;
 h=content-transfer-encoding:mime-version:reply-to:references
 :in-reply-to:message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=EhH+MqcwbN22J9I+qOwSEx25qMnne6EHpjiOSvHSUJQ=;
 b=gJdA+VVxP3o6LQZBhNzVmZpsv9lnlquVleQT1XFIfotGrl5/UFQ/nMgnqKC52JDebY
 NUKVdjNMhxm7/tB6UETV42lzmwQilgRiS82Qy1LihiMdP3Ajyj0n3Vm3d+p75AfuSRjL
 ij4CGY3hZozSBLHmNuCo/tgtakI8Sg7ZArmFxyp1ovs4FO/MZmV0C3woKEmUS3myQyBm
 VCjU/lL4qcIb54vje3dtLv9ZxtWHNBVRPyw+a6DzidIUWIKj+EKWHRZkdsHWH4Cn+wp4
 UYPQLFhYtfpbLx/+verV+aJSBv7j3pRST9NSTM9TtpwKq6Ib1PkWXcEf66PYkuj07AQ5
 RtVA==
X-Gm-Message-State: AOJu0YwLK9xCrza/ddcyL4LMvxsjDdvcja80MSvCbsNq9T0QdZGwMuIX
 3ZAqpYwO/PS3bN5QQIiDRPINzMjLT2mutpYs+NuFBI8LkFxT54ugun3ZOyc4WWGEyRW5KqPPCXj
 2V7EFjBn+XgQvCNcohF4NRMD/THXB8TeCRmMZHasRsMfcozjihkHP0iEwdSLkW+XfWZQbnCPW+I
 Ytq2RHoqMUxK8I2Zv9MF/3XxDvJIEZ8NJltg7IGoDR+fbgyLp69C400R3ncOLhQVTax6jLQhUac
 13ECSXgueFskaI/42rY5yzxQ/ot
X-Gm-Gg: AR+sD10vFELHr5x6vILKISXltjkbQDu2g0ns5q8HJKZ0leQzYc4Dzt+UW7WmGb1VePN
 v0vTeaJqcQ7wt+3QzzAn+JYNESoQPdHnVxvl0IADNDMeTWIozVHIBGtcozStt1Il7Zyw3buQB0Q
 dIkVe8bx4eZJoEsNf8VyIUIzu7l3l7hSV3W357zxDEKJdm/6yRM8cnW1ufCiEUAqVKhiQIMk2q7
 NwTghwJm401FLgrN9ULrc9ZnEpJI1Tywl2R3oUnHaQkJ8WG4IZ3UK5Jr/02O11gHtIyv64NdbUU
 tdyB9Q5yYAxUsXGvrw7NwAqXy1pPb/badJpuKaiif6CCLLTLg+mU9A3Fbrayp3VByWP9vPyULV8
 I3JWgRSTegoLmZ3vMUwpp9mQUv3AT1SHQwqks3tx9dj0bZVWbFw6HJSDR0sBTZ5ngPEqXoxBTtC
 RRHfPivNpo5URbVRS54eCd283S8TbgTIoL+dMVnUuK
X-Received: by 2002:a05:690e:490:b0:664:ed6f:4eb1 with SMTP id
 956f58d0204a3-668ffc362bamr116118d50.16.1785176513105; 
 Mon, 27 Jul 2026 11:21:53 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-26.dlp.protect.broadcom.com. [144.49.247.26])
 by smtp-relay.gmail.com with ESMTPS id
 956f58d0204a3-668c6ad70d9sm700542d50.0.2026.07.27.11.21.52
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 27 Jul 2026 11:21:52 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-c1c4715cf0eso308999166b.2
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Jul 2026 11:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1785176511; x=1785781311;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:reply-to:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=EhH+MqcwbN22J9I+qOwSEx25qMnne6EHpjiOSvHSUJQ=;
 b=AtlcJW1aybRKIUDQ1iJo37rKMSjOxkE3NPmjexu8aZ3uE0br0w2XWNekc34u3rovSn
 J9QWNn0jFD3Y6mp8z8B2qm/W2O7VSvB8jQr3iJNno+iAw8JDeCRXRGR5HtKyGI2B+0/x
 IFihFdM3L0yt0z3sXBd1rHwvOtDPgfo+SEPuY=
X-Received: by 2002:a17:907:c081:b0:c12:8fe9:3a42 with SMTP id
 a640c23a62f3a-c1f1f09fc91mr370671166b.35.1785176510847; 
 Mon, 27 Jul 2026 11:21:50 -0700 (PDT)
X-Received: by 2002:a17:907:c081:b0:c12:8fe9:3a42 with SMTP id
 a640c23a62f3a-c1f1f09fc91mr370670166b.35.1785176510372; 
 Mon, 27 Jul 2026 11:21:50 -0700 (PDT)
Received: from mombasawalam-Precision-5820-Tower.cap.broadcom.net
 ([192.19.50.250]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c1f5e717da4sm82222366b.4.2026.07.27.11.21.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 11:21:49 -0700 (PDT)
From: Maaz Mombasawala <maaz.mombasawala@broadcom.com>
To: dri-devel@lists.freedesktop.org
Cc: bcm-kernel-feedback-list@broadcom.com, ian.forbes@broadcom.com,
 zack.rusin@broadcom.com, Maaz Mombasawala <maaz.mombasawala@broadcom.com>
Subject: [PATCH v6 1/4] drm/vmwgfx: Add some checks to
 vmw_cursor_plane_atomic_update
Date: Mon, 27 Jul 2026 11:26:19 -0700
Message-ID: <20260727182622.236086-2-maaz.mombasawala@broadcom.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260727182622.236086-1-maaz.mombasawala@broadcom.com>
References: <20260727182622.236086-1-maaz.mombasawala@broadcom.com>
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
Reply-To: Maaz Mombasawala <maaz.mombasawala@broadcom.com>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

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
 drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c b/drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c
index d1e7df500190..563812f1e23e 100644
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
@@ -781,13 +784,14 @@ vmw_cursor_plane_atomic_update(struct drm_plane *plane,
 			       struct drm_atomic_commit *state)
 {
 	struct vmw_bo *bo;
-	struct drm_plane_state *new_state =
-		drm_atomic_get_new_plane_state(state, plane);
-	struct drm_plane_state *old_state =
-		drm_atomic_get_old_plane_state(state, plane);
-	struct drm_crtc *crtc = new_state->crtc ?: old_state->crtc;
+	struct drm_plane_state *new_state;
+
+	new_state = drm_atomic_get_new_plane_state(state, plane);
+	if (!new_state)
+		return;
+
 	struct vmw_private *dev_priv = vmw_priv(plane->dev);
-	struct vmw_display_unit *du = vmw_crtc_to_du(crtc);
+	struct vmw_display_unit *du = vmw_cursor_to_du(plane);
 	struct vmw_plane_state *vps = vmw_plane_state_to_vps(new_state);
 	s32 hotspot_x, hotspot_y, cursor_x, cursor_y;
 
-- 
2.54.0

