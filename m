Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D831CCF2C9
	for <dri-devel@archiver.kernel.org>; Sun, 18 Oct 2026 22:17:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 38B1210E0AD;
	Sun, 18 Oct 2026 22:17:40 +0000 (UTC)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BAB7110E733
 for <dri-devel@lists.freedesktop.org>; Sun, 18 Oct 2026 22:17:33 +0000 (UTC)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-4a1dede3c2cso14169495e9.2
 for <dri-devel@lists.freedesktop.org>; Sun, 18 Oct 2026 15:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792361852; x=1792966652; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=nAF9oPetXs/1/u0SmZXy5Zxa0XcvT5gTByOb4pwMeyU=;
 b=smOCMKQDuT9GcEFxymY7CScgRobn9xjBp5CO4u5+LedLxqe7F30zB0t2E3p0nwtg6T
 VZUxFb+30ERgvtz33XMt2S1tD8PGR0KtBccDZ0ELDpIqWrDfnf1DfnYNGlDy8aWaNI2j
 uLtmwuV7Si8l9k8giC6I5smJqTnUlxgCSlWO5g3b9k99wjVx/JiNrFavlI4QTqtPCCqr
 HbOMAOq5t9Cde7HCOnNumU86Q2Fr0W/8sZ1elMJnB/M60Qepi0iIrnyuN6WEETqMAiOu
 qyy5nEh07/uwWKn0dwSp7qIbBVd4zO0mm0yz6xg7XCcycjYNJXDrHTK2aATPd3zKoKK0
 YrPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792361852; x=1792966652;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=nAF9oPetXs/1/u0SmZXy5Zxa0XcvT5gTByOb4pwMeyU=;
 b=JnvqYp7wTkFGzH8pWMTpES3ozqIQ7zRB1A4vOJbJZCh6Houh9n4HgUsUIwOM0cRJo9
 fxBrvBTZFOhKhTdWlmSMdeB+NJLUvtb2qWZZjRMCxNmFx/jzxs4oyrFRnQQqQlThs+gd
 m2iRSrKJQsl7wLJgLpJ7gC/TAau+c4kBldKhfJUf/eNaXhF7zUGL0uyI7ehbL1z2Q1uO
 Mevgu2FZYJ/b27LOs8tJ8zRlbyAFkwMl0Cy0KFJPmYNtAgdp1VmEdUlYfY8VWZkHp8Uu
 zxocVNlTQUMPe9n3DqqfGvz85eYaYqS+kw2gMl4f4F6pAaJWvqD/fiOek4shzEYQBSIa
 h7UQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByNUV+dHIb6UMnZE8Cp/RyAAEKoapgwBO97UEBrlwuFzSveh8MVlnWYNucHvT+1ha6D7CtjahKT6Ec=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLeoNZlhVLM4CggjmzM4+Sd6r/6/vOYhEZXIOl9BznEz2DtqVov
 qQRG1dNzSA69QUpM9p31k/KksDoJ0RjOJRj/ThobnS04nzOEjuMBc4li
X-Gm-Gg: AYBFou1sVuDcZSKNg4NL+WBsI/3PYiEdY1KbslODDP2xGJ0lrQqxMcqQPQz44QAGLLd
 VVFT7Ox4jtsSzRSIIY2C/5NQwpaUIbrk7oIweI3lyflAekYfedm2/SGN5itv7oKxlOpbXWY7L++
 OyffkI7uZ0577CpJ9RmKOAoEXI2AsGCn0hmBFqRbPix3nzOCuTFYcsx8pJs1Z9npRB51Fu4JLau
 ReH0c0M3wMyvzTWq72jBaMCAVRTXdsDngiuuTXck+MdItpqzxgmKz9Y3Ja1BdksfWA6/8QP2vt1
 WZEL8nQzweYCyoIMCC3FIOXe8UaTVBW1Dw0hDHuTfCjI2GnUK1dKzU+lBnHxkmchBetI1kRkyhv
 kvw9lkmvdbZKchWY4a0gFZfG1z9DS5+Q92VbIl75vQ5ug/tflSGeQyND2r7R6la6qsbErOF5DRH
 gD/dFNgLBTLSafb+BvB7Yv/3vb6utL6rWIZNLMwjqf6OtkjSnosJIajN+4fC3YxNEqaz7bQ17Hw
 4e+kFlOaU/lRHMV8/+vpOITehpTPiifiW9VDUyvZB1pScUXQauxX2Dc8ztLlzWU5W9xnA==
X-Received: by 2002:a05:600c:8219:b0:4a1:85d9:13be with SMTP id
 5b1f17b1804b1-4a1d76031bfmr129943605e9.20.1792361851851; 
 Sun, 18 Oct 2026 15:17:31 -0700 (PDT)
Received: from localhost ([178.214.243.78]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1d85f92d9sm155398425e9.4.2026.10.18.15.17.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Oct 2026 15:17:31 -0700 (PDT)
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: Alex Hung <alex.hung@amd.com>, Alvin Lee <Alvin.Lee2@amd.com>,
 Jun Lei <Jun.Lei@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>,
 Fangzhi Zuo <jerry.zuo@amd.com>, Rodrigo Siqueira <siqueira@igalia.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org,
 Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Subject: [PATCH] drm/amd/display: set allow_freesync before validating a new
 stream
Date: Mon, 19 Oct 2026 03:17:26 +0500
Message-ID: <20261018221726.27259-1-mikhail.v.gavrilov@gmail.com>
X-Mailer: git-send-email 2.56.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

After resume from S3, DC enables SubVP on a single FreeSync display at
a high refresh rate, although dcn32_allow_subvp_high_refresh_rate() is
meant to keep SubVP off that configuration ("For single display cases,
freesync must be disabled").  On an RX 7900 XTX driving a FreeSync TV
at 3840x2160@120, amdgpu_dm_capabilities reports sub-viewport disabled
after boot and enabled after "rtcwake -m mem", and the memory clock
starts switching.  It stays that way until a later commit re-validates
the state; a CRTC gamma change (toggling Night Light) turns SubVP off
again.

The policy reads dc_stream_state::allow_freesync while the new state
is validated, but amdgpu_dm sets that field only in
amdgpu_dm_update_freesync_state_on_stream(), on the first flip after
the commit.  A stream created by a modeset is therefore validated as
if FreeSync were off.  On resume, dm_destroy_cached_state() drops the
streams and forces a modeset, so the resumed state is validated
without FreeSync.

Set allow_freesync in amdgpu_dm_get_freesync_config_for_crtc(), which
atomic check calls for every active CRTC and which already writes
ignore_msa_timing_param to the stream.  It uses vrr_supported, the
condition the flip-time value is derived from.  With this change the
same TV keeps SubVP disabled across "rtcwake -m mem".

On this machine SubVP is also what exposes the single-frame scanout
corruption reported in the thread linked below, so the FreeSync
setting stopped working as a workaround after every suspend.

Fixes: 87f0c16e0eeb ("drm/amd/display: Enable SubVP for high refresh rate displays")
Link: https://lore.kernel.org/all/20260829010525.29935-1-mikhail.v.gavrilov@gmail.com/
Signed-off-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.c    | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.c
index 7e484adb4120..f26dd206dffa 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.c
@@ -128,6 +128,14 @@ void amdgpu_dm_get_freesync_config_for_crtc(
 					vrefresh >= aconnector->min_vfreq &&
 					vrefresh <= aconnector->max_vfreq;
 
+	/*
+	 * DC reads allow_freesync while validating the new state, for example
+	 * to keep SubVP off a single FreeSync display, but it is otherwise set
+	 * only on the first flip after the commit.  Set it here, so that a
+	 * stream created by this commit is not validated without it.
+	 */
+	new_crtc_state->stream->allow_freesync = new_crtc_state->vrr_supported;
+
 	if (new_crtc_state->vrr_supported) {
 		new_crtc_state->stream->ignore_msa_timing_param = true;
 		fs_vid_mode = new_crtc_state->freesync_config.state == VRR_STATE_ACTIVE_FIXED;
-- 
2.56.0

