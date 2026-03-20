Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 673ED1093168
	for <dri-devel@archiver.kernel.org>; Fri, 20 Mar 2026 01:50:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B816810E887;
	Fri, 20 Mar 2026 01:50:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=broadcom.com header.i=@broadcom.com header.b="ZOVjFNBv";
	dkim-atps=neutral
Received: from mail-ot1-f100.google.com (mail-ot1-f100.google.com
 [209.85.210.100])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4CBD210E887
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Mar 2026 01:50:22 +0000 (UTC)
Received: by mail-ot1-f100.google.com with SMTP id
 46e09a7af769-7d7d50516e9so980940a34.1
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 18:50:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773971421; x=1774576221;
 h=content-transfer-encoding:mime-version:reply-to:message-id:date
 :subject:cc:to:from:dkim-signature:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=81MhLBUnoudyWirjQIMqY3n4RbWW57AxWTY912ofJPM=;
 b=GnAQL0g5W+5UP2RGF3bn078P7JAYXS3Z65awnCAXpwjXI4nggOOM2F1d4cWQ/FZjvY
 iK+c7rOWsxhi2/wOGz8LEXf2jv5V7V2A2vuhSnVWfQIOfPHv9Qb/QkZ9mIqiFcBNo2EO
 8h0+ws0KNHjmDpUwKWw/Po0tGQ0JBmPZgYveB219T8ynZVtGa/DLvZlFx7ZCyRRqXSyw
 NOg1xAfVK+bzfdxXqPIojS/uJ4+wKCYXz2BsKNTfVhUQZhQ5GehjjaUqx+/ZeohRWwpq
 BypTYwozxVK31tqEEisVeQGOM7KREiwzsiOmfg2eNcNFTZvrsenuA1q1HofA1J9VvD+Q
 3cgQ==
X-Gm-Message-State: AOJu0YxwidEWmyz7aesu8ShYQS584DXSYTWVKsFLvaPqMARJvVY4kDQ8
 zi9gDNTYk2tXnhlvhPtwtvXI2DC9Tc4MPXYkOgcDs3+jxXgCpYrUiCjiOmOF21TTXZjOIAez058
 A0vFOyXpFrPSNa9/oQ4+/UokuAnOaxTt6Ykuuf2n2QbnDZi85yPtakb9pHQXEcDw/kp/l8ke6GB
 RD6kiSdp4uE4VK/GO79lBT1X9cZor2ydbAMiHXoiC+qY4yWuOEhINryydHFVIxH+G2WNEahKrNP
 +KJdhrhhg84Op+oqB+Fb+azOUFRreM=
X-Gm-Gg: ATEYQzz/D1HvGL3gGOpzReXMEB+HbeNYaFpEhfeIueNS+jH7XuavpSXjNWONGRWMqig
 GkvaeWJZpSF4UsMWfRhBd5h1MeqBLyWK19OMqk5ffioB5EPxnKhNZ2Kg1pAJHDMds8KKgaC6/Im
 bJDYfex9yWax+vHcnsSVyKJ6mpExaJVd22+hI9noFICvTB6GrwCL78w4ARyxrHwCPDTIMDA2/aK
 uEtD6s+/zNqNmGXeotWXsfEv9lQWyKo94114dPP6alSfb7S097eQsky8nalyMgS3xfYVr5qo2br
 bTla/1rnXm8oqOZW/6uV1ScMPdNKIjoEAgTMl5Wq1OeCTuL6b3/owd26Q9XBjQKHj5EUIt3T3w7
 MTUtrTtwO0TfqC4sO+wOMzVNL94QjeTKbB/rXomsfIX8idYWKUieyLcIG6KBrzMYsy+ygWgj1TR
 IxmAU6l+BvJTONQF7ut2MjlcTV9KNOZWSj/oLVAsG4O5RaMUausRslFGoa3Tf2XhmQ
X-Received: by 2002:a05:6830:67c5:b0:7d7:d15a:ce8e with SMTP id
 46e09a7af769-7d7eb04feffmr956152a34.32.1773971421198; 
 Thu, 19 Mar 2026 18:50:21 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-102.dlp.protect.broadcom.com. [144.49.247.102])
 by smtp-relay.gmail.com with ESMTPS id
 46e09a7af769-7d7ead11eb3sm107672a34.5.2026.03.19.18.50.19
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 19 Mar 2026 18:50:21 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-5093025ffecso60486111cf.0
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 18:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1773971419; x=1774576219;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:reply-to:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=81MhLBUnoudyWirjQIMqY3n4RbWW57AxWTY912ofJPM=;
 b=ZOVjFNBvHsuvkX3eKBm74HOmmdgKRCC/SzAgRKwrnyRq5rqyrjTKR+ClKbM0emRtv/
 idFw71ACTrl5WuANFUqdNmmYwJmBV/4NbHUaFcLXwq6d3WeHlOTb6rk+hvy8SgH57Gwm
 RnqDa50phI3eXOYzJsJaGzAMzUyKbNjr3qF2E=
X-Received: by 2002:ac8:57cf:0:b0:50b:37a1:a012 with SMTP id
 d75a77b69052e-50b37a1b512mr20506291cf.41.1773971418751; 
 Thu, 19 Mar 2026 18:50:18 -0700 (PDT)
X-Received: by 2002:ac8:57cf:0:b0:50b:37a1:a012 with SMTP id
 d75a77b69052e-50b37a1b512mr20505691cf.41.1773971417633; 
 Thu, 19 Mar 2026 18:50:17 -0700 (PDT)
Received: from mombasawalam-Precision-5820-Tower.cap.broadcom.net
 ([192.19.50.250]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-50b36d04889sm9854691cf.9.2026.03.19.18.50.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Mar 2026 18:50:16 -0700 (PDT)
From: Maaz Mombasawala <maaz.mombasawala@broadcom.com>
To: dri-devel@lists.freedesktop.org
Cc: bcm-kernel-feedback-list@broadcom.com, ian.forbes@broadcom.com,
 zack.rusin@broadcom.com, Maaz Mombasawala <maaz.mombasawala@broadcom.com>
Subject: [PATCH] drm/vmwgfx: Add some checks to vmw_cursor_plane_atomic_update
Date: Thu, 19 Mar 2026 18:49:09 -0700
Message-ID: <20260320014909.3247540-1-maaz.mombasawala@broadcom.com>
X-Mailer: git-send-email 2.53.0
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
Add a check to fix this and also do an early return if there is no
new_state or crtc since there is nothing to do in that case.
This fixes igt test kms_cursor_legacy@torture-bo.

Signed-off-by: Maaz Mombasawala <maaz.mombasawala@broadcom.com>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c b/drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c
index c46f17ba7236..88b7185a8371 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c
@@ -744,9 +744,14 @@ vmw_cursor_plane_atomic_update(struct drm_plane *plane,
 	struct vmw_bo *bo;
 	struct drm_plane_state *new_state =
 		drm_atomic_get_new_plane_state(state, plane);
+	if (!new_state)
+		return;
 	struct drm_plane_state *old_state =
 		drm_atomic_get_old_plane_state(state, plane);
-	struct drm_crtc *crtc = new_state->crtc ?: old_state->crtc;
+	struct drm_crtc *crtc = new_state->crtc ? new_state->crtc :
+		(old_state ? old_state->crtc : NULL);
+	if (!crtc)
+		return;
 	struct vmw_private *dev_priv = vmw_priv(plane->dev);
 	struct vmw_display_unit *du = vmw_crtc_to_du(crtc);
 	struct vmw_plane_state *vps = vmw_plane_state_to_vps(new_state);
-- 
2.53.0

