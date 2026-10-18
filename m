Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 433B2606A319
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 07:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ahmuc32B
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B38A010F2F1;
	Tue, 20 Oct 2026 07:36:31 +0000 (UTC)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3079E10E083
 for <dri-devel@lists.freedesktop.org>; Sun, 18 Oct 2026 15:54:26 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-4980fe6b3beso14840015e9.0
 for <dri-devel@lists.freedesktop.org>; Sun, 18 Oct 2026 08:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792338864; x=1792943664; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=W6lmJQMv+mPBi4ABudf7h40tJlxRiHiqMX1K/I29AXw=;
 b=ahmuc32Bf77I1VwTybndiHuwQAi6h2l4ETxbQyvYLPeWT7famoyVMHS8IIg/ayEFOB
 d3MoT3JjDi6yfL/WWZ0E22gwgWiQpqxYieawTke78m5AD5IdqnrM3E1yVemZBcuVf3uG
 gRPZ//ru9NvZR1U01Z17SUtoW8hep6NfGco8IAaT1RiaF0ZBvr+elGYxvW8Si4006NNC
 L2ULzw6v9/F+SvpLt/USMiycQcmoqYl1RWkOBFaUDiod3ZES7G5l0Sr0m+QKRVCLoSVI
 Asql9I1GeYvwvsbYH4yKtZeMNbr7htQRvYWfU1QwZeTQdvcnS/CX/IDiyNny3Uu8k7F3
 e7IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792338864; x=1792943664;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=W6lmJQMv+mPBi4ABudf7h40tJlxRiHiqMX1K/I29AXw=;
 b=parTA3BVkRvGBAeFhjVHhumzG/NERJkwuLpyHODHMvGYRPPLilABwNxISC/qwRzr/6
 CA99mGKTXBfMoBajJCYEhwMDhiErVPB/0qKc3lFGUesdgs1TcR79Ad+/yfsv6SbOMoLF
 dq3dXfQ7REQ6d+vRwbgO7wfBJ36FA029skMcGvMEf3DmChLkEAFBKVxPhKJpanRsyQKX
 lChx/U17V8m8tHZKYqH7V1dsCz6GyyirtuHp/tehq5YkgVy9TwzpIkKgEfzMIDmce99C
 a/2fDX2YKtjOAXmBQ3wULg7NrqLHNeA5hCy8RWS06Yb3lOJFdwTNtqlEzfLV5EXncSNm
 +ZUw==
X-Forwarded-Encrypted: i=1;
 AKwUvByHTve7Q8Fh/WsZeeos6pjLTnwSP1XcyB5zLKxoqEVAzI/AsN/eO12tzZZGoCyCEXeLkb1CdUBsyeg=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJP8IZs0GqtosqJ9WAvSPp9sx+4u2nUKomz8BixuKWUpAWLC3ZX
 t8amN/0AZOlkRzh14+aHOQkpb9peAoJUodk5sWjeghe267HZhensNPvu
X-Gm-Gg: AYBFou29+tAe5W6bKi3IgkFj7sQU1uWcfbVbokKbqdQIE1PQ1popKWaQa3w/zUpWxZE
 V+fT+Jtzse7PrlxqAGfEe9R+KR6pWc6xfbRZIdF5GOw7ewQUj9r89vNgNerN+7aXy8kpL2SCFoV
 vSi5/+rVpcAgjsAdCUpumMkcH26TLnyJyiHG297aGTKNAVBIJpSVcFOmxWVfD/xOHeekYb3Vte/
 d3Kk7qj1PhDsQdKpzk9jIvHtbLOYNLC26e89yAqcieBD6oynml3gFnrtN8Bpb6WhPpkT5pMJY+G
 njNzgDKiX92G01Lq+A7v2VpLCsJdCxyfZMmGN5ATHpOwir4N92xcoQeBz6rYgxsGDwg4XCppMwZ
 HbQrUjWWFBAIjYVCKzksrjJa5Y3IZCXbaEynxScifMHF2dmTiv/99G9iGxuXt3fxghCJjHGnLxl
 g/gzqoKbeFYWXSttnH83TnSfI69MzaQgNVtb8FNCh3E57948gSKkoKFh3j9YgBx1AdE8VcsTo3R
 bs6SYLw3lxtDi3vMqAU017FsqhOzO0CyQ0Iz9NN1DfyAgOR8BPRGJyQJd09vOXx6Abdx+RGq3qm
 FAPwLz7cNl1C+gM94HBJpg==
X-Received: by 2002:a05:600d:6413:20b0:4a1:d899:b62f with SMTP id
 5b1f17b1804b1-4a1d899b7f0mr67874735e9.0.1792338864358; 
 Sun, 18 Oct 2026 08:54:24 -0700 (PDT)
Received: from hermes-agent.lan (228.red-80-29-82.staticip.rima-tde.net.
 [80.29.82.228]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1dc8ee409sm183420235e9.13.2026.10.18.08.54.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Oct 2026 08:54:24 -0700 (PDT)
From: =?UTF-8?q?Ram=C3=B3n=20Jes=C3=BAs=20Miranda?=
 <ramonjesusmiranda@gmail.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/msm/dpu: keep vblank enabled when entering self refresh
Date: Sun, 18 Oct 2026 15:54:23 +0000
Message-ID: <20261018155423.1299629-1-ramonjesusmiranda@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 20 Oct 2026 07:36:08 +0000
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
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

When the CRTC is disabled to enter self refresh, dpu_crtc_disable() only
checks old_crtc_state->self_refresh_active, which covers leaving self
refresh, and calls drm_crtc_vblank_off() otherwise. The atomic helper
then expects vblank to remain enabled for a self refresh "disable" and
warns:

  driver disabled vblank in self-refresh
  WARNING: drivers/gpu/drm/drm_atomic_helper.c:1296 at
  drm_atomic_helper_commit_crtc_disable+0x1c0/0x1f8 [drm_kms_helper]

Skip drm_crtc_vblank_off() when the new state enters self refresh, as
other drivers supporting self refresh do. drm_crtc_vblank_on() in the
enable path is safe either way, it only drops the reference taken by
drm_crtc_vblank_off().

Seen at every boot on a Microsoft Surface Pro 11 (X1E80100, Samsung OLED
eDP panel) with eDP PSR enabled; with this change the warning is gone and
self refresh keeps working.

Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Ramón Jesús Miranda <ramonjesusmiranda@gmail.com>
---
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
@@ -1212,8 +1212,13 @@
 		return;
 	}
 
-	/* Disable/save vblank irq handling */
-	drm_crtc_vblank_off(crtc);
+	/*
+	 * Disable/save vblank irq handling, unless we are entering self
+	 * refresh: the DRM core expects vblank to stay enabled then and
+	 * warns ("driver disabled vblank in self-refresh") otherwise.
+	 */
+	if (!crtc->state->self_refresh_active)
+		drm_crtc_vblank_off(crtc);
 
 	drm_for_each_encoder_mask(encoder, crtc->dev,
 				  old_crtc_state->encoder_mask) {
