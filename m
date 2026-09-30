Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B220CA5FB1
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 12:13:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB2F210F366;
	Wed, 30 Sep 2026 12:13:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lydz0Jqm";
	dkim-atps=neutral
Received: from mail-pj2-f39.google.com (mail-pj2-f39.google.com
 [74.125.227.167])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E80B110F1DE
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 06:59:20 +0000 (UTC)
Received: by mail-pj2-f39.google.com with SMTP id
 98e67ed59e1d1-3a49896dd9dso495030a91.0
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 23:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790751560; x=1791356360; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hU+zIGAKl5WRrGNtWt1WIuTTmXd64fU+CsTBXH1LZFQ=;
 b=lydz0JqmUNaAnX+cjhIJ/7XgwpSmcM3QSOHSvbyi57supJuo7c+jDaI1TsJsl3V+n5
 VAIKLyvo5sOp/vqY/mUWMG9n13QjNbxyv42wGW9YfIwPLvr0NqjeR6eOy3yVCfmaMg6y
 oPF5GF/ZoNxPgleHfLtopSt5T3ZqsLiIe9YnZFXimDyOOSIFIqEsDx5IawGDu54NPPUm
 SQOzfZiHaPmBAt5IUAr9ZecEFT+xmDYqza+Ou/E4ZkVf8kt40+vewn6m6Z1Wlm+ywYUj
 +SdlKSEj6uqM2U5wdPmuCGpqjNTFsbPmq25hgV73IryA4jQwkxOrkCn98+pPrbrSv/nJ
 fbgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790751560; x=1791356360;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=hU+zIGAKl5WRrGNtWt1WIuTTmXd64fU+CsTBXH1LZFQ=;
 b=IwgRHLiM8sJ/rfWh1rKJBjruYD2LObQGX6EKF/AW/5vLES0ZxA+dzEj2Kbh2kQZgNI
 4o6FZp8HGsr0/87cKqFQJWMTs9FZjL2ADtjuspZUnm79Qpf/hqH/xw84zby4kJ+mb/z3
 RU4kYFWbZdh9nwi2ME0uZNcfXpGM8UFsayDxCB8t/SVwfDeM13mnbE+spdN8x6UCwBf/
 aROrTkoRJt+nvYoODOBOnaEVV5i30NDYya/otIU42rq8dgpWecK6CUQ436j2/5S95Aiy
 0NgUUWnTrxJty11CfIBRT/tZ6uGRTLVVwgZPk0wFydiUTWvKyzhrt//g8U9Gc8aFqcEV
 GbYQ==
X-Gm-Message-State: AFq9FYI5geug8/RCQp0YK/vRkPeYdhdJ2u3YDEpEQsqcOLzcj6RNPWHV
 0zS22iskagU6py8cf06mivWhyKQW7YsDgrYpMnJsv31xXB7PdeubEodB
X-Gm-Gg: AYBFou3e/EQU7P4o59EwjykxwCHY/1KV1Un6vb4gvWcOv+iVltN55OH6Nwa/gg5Lfte
 yaEKkFEhbXdCA/1mWel0aCH3XSSbXwt/gPPb6zINLmcgZUTUhRpWLbZKHpT1mtlJVPwwoIz5sBN
 GnSsDxhVijwEtslfRYyAll/GKY3Q6hvdjnGiKnkKuxJrltQpv1oW1jMO0/P7YsQalHW3tyCVecX
 HOctD4W5N3I1zTZO4CsmKK2QzJD5U+OT3ThW4KQZC1wN2RazHMFDAEhKEnjhKlAZ80a7o3CZUcd
 xBjTs4nPJ/Vd7x1NtZ+h8kEWvAcmLyBvn/0pxWRgdI/wbmoV8WghVYxCZOPpU+9NuLiJwHkP2Ia
 PfCJMvtBH+dPZ2Yl9K6azVNn8BxsjPwYro6WllbF4pusZtUwmZ3dmHZVJzvf8vcSPkV3vUBmt5z
 8DKvXcGHK3Ue6p+OJcpLXGGqU6Puu0GndsZYYnMkR0qeHvYQeWCuWVNlePJBh1wP5GLfZXTEMX5
 8YWAP3mt92AMgU1l0FqIoboXQcnKtnv/k+nNZZENBH7sc7NjlyJY3qmBMCM3HFLLP6dPPDIVRnX
 BxS6HNWMCQ==
X-Received: by 2002:a17:90b:5281:b0:3a0:cca0:4a8c with SMTP id
 98e67ed59e1d1-3a4d276f94bmr256792a91.7.1790751560438; 
 Tue, 29 Sep 2026 23:59:20 -0700 (PDT)
Received: from phui-2.c.googlers.com.com
 (25.187.82.34.bc.googleusercontent.com. [34.82.187.25])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a4cae9ffaesm2010442a91.16.2026.09.29.23.59.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 23:59:19 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Hui Peng <benquike@gmail.com>
Subject: [PATCH v2 5/5] drm/gud: Reset damage state on vcalloc ENOMEM failure
Date: Wed, 30 Sep 2026 06:59:14 +0000
Message-ID: <20260930065914.393939-6-benquike@gmail.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
In-Reply-To: <20260930065914.393939-1-benquike@gmail.com>
References: <20260930065914.393939-1-benquike@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 30 Sep 2026 12:12:40 +0000
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

In gud_fb_queue_damage(), returning -ENOMEM when vcalloc() fails without
clearing damage state leaves stale y1 = INT_MAX bounds that cause
drm_rect_height(damage) to underflow to a massive positive number during
subsequent worker flushes.

Call gud_clear_damage(gdrm) before returning -ENOMEM when vcalloc()
fails.

Tested in QEMU against Linux 7.3.0-rc3 by simulating vcalloc() failure in
gud_fb_queue_damage(): on the unfixed kernel the un-cleared damage bounds
(y1 = INT_MAX, y2 = 0) caused height underflow during worker execution;
whereas with this fix applied, gud_clear_damage() resets damage bounds
before returning -ENOMEM.

Fixes: 40e1a70b4aed ("drm: Add GUD USB Display driver")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>
---
 drivers/gpu/drm/gud/gud_pipe.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/gud/gud_pipe.c b/drivers/gpu/drm/gud/gud_pipe.c
index aa7792966287..fb726e3d849f 100644
--- a/drivers/gpu/drm/gud/gud_pipe.c
+++ b/drivers/gpu/drm/gud/gud_pipe.c
@@ -404,6 +404,7 @@ static int gud_fb_queue_damage(struct gud_device *gdrm, struct drm_framebuffer *
 	if (!gdrm->shadow_buf) {
 		gdrm->shadow_buf = vcalloc(fb->pitches[0], fb->height);
 		if (!gdrm->shadow_buf) {
+			gud_clear_damage(gdrm);
 			mutex_unlock(&gdrm->damage_lock);
 			return -ENOMEM;
 		}
