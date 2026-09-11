Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEF29C88E5C
	for <dri-devel@archiver.kernel.org>; Sun, 13 Sep 2026 20:53:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A2F1510E165;
	Sun, 13 Sep 2026 20:53:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ba5fqL8a";
	dkim-atps=neutral
Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com
 [74.125.225.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D75010E363
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 19:58:48 +0000 (UTC)
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49cd6185db7so1406105e9.1
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 12:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789156727; x=1789761527; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=tQc/+XJKcMZ4EW0CsqUV1SQXS+g/1U/+e+C+i+eqIyg=;
 b=ba5fqL8awHrIGx6owCSINuMFJ4gAa7WpY8hblmBLn8a2ky+KTwfk5pbHNu2TH24auE
 OSZHrEQqEwJ5SPi/AFei4NNWBgCN1G4VKnN3686L5aVHM5AL2+0vyzfQqs8LYhyGKmTS
 COXKJDfS/dsy/zPvqMJoEscHEtEJPB9c53QtcUkyBtAUZB5o70lW699FemRex+QtO7Qs
 6UFHfiy/fmSWAg00/f8kwfvSNkS1LYLbxDvfp3gCbOOKi5e7vlnxvI4dbWZ0Ql+d/5WV
 5NTkhPC5sW1hz5M4jD1WznZyfdAQWh1xRpC8dDBcRV0ThQtYUBG8J9Je6FRYRtZpCbAX
 0QOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789156727; x=1789761527;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tQc/+XJKcMZ4EW0CsqUV1SQXS+g/1U/+e+C+i+eqIyg=;
 b=iiOimUeOfLQdXbhWTF71CevViCJ9d31pw+UDKCCavlu7/CtIG9YHR5iASNnFOmS75L
 dH3qeDtNwjmxtey4iPbQjChbvpAOCwnsZu8LGSRbCGny/9nGz9vTuLGmd4WJjsVMRMwn
 tZFyVT6WnntugxBuHMxf8TMWud4qyq1bTQnb8mfZzN29SZEo9cfz4inFMNN4qIfyTI0a
 sV0A3GY+gxd6QpKDIwtPDtptIQQGZgbltqqrLNRY821cclED4q2EWmHxRYcV27fp+3kx
 8onmBJzPa8RfvXMwo15uVyTSRojbrSdHTsgW3oxvnzIsSHlJrRjUE9j9FjEEPWFKYJRN
 LWhw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzckWxCQHrcIqGtS15PP/fg+vIlHsylv82OAvbve3MBNStydm6CKJJc7n5H8fKH/vPk8q6s+HlmctY=@lists.freedesktop.org
X-Gm-Message-State: AFuF++ng8ASeMBMGY+t9gv+Ax7oz2QBaU7zf5S2YZNv+Vqw6F5iG1PGo
 68Sn0dRcFtaf1xOZO/ocQDtJXJUKKI8OXhvO7inTNgeZ/MCQrv8NIUSvWCjXxlXq
X-Gm-Gg: AYBFou2ma8b17TU1L2ruRgbluXEOHIPHW4rl9m9ZIB6rDCipsQkIIVO8LHpj7z1zBAQ
 nre70nFRTN0+XkTmNsqVuT49DcuZtl9IJD9B9YDSWMbzzQaZubHz1SOywAaPHyVA9pgwbJdU3y3
 4zqxRVrFQncvU9PtMVWoCyNAZpz8325409OoVaPerW0/ymEbGFXLvUOy+Tfs5G+0gVrpntNvkHE
 Apd9W54cPH35HCmULmQsok+7tIFd/5EbkxEGDbDQsr0R7yJSPcdhhVtvxkHX3+Yad8ZRb6RjZDu
 XdPwk5Hy9AmsJHEwzbfsiHZz5FBYQ3Bi8c0gyl808K89SeNQOMWuhFuBVR0DK+D1rnnKr5B5mqk
 GUfuUL8KfGGmoOeh1xnaqt6tBnyIEVBDAf+lHYnxkfsr+6cRzq+4/ga0dsJjvAFveqpOoUv8K2u
 gJCVYO57CKxeURh+8Of66CE782K9fX7whpcPp3q8KWyLVQYCdZL6qrKREqW28ETi3xZ4079UgAW
 Tp/ZLjLmEdoX7BKlRNrjbciakePzm7t0Cyp4xjIdP6a5Bx2p+Euod9JYz4EPpAHQEKlW1Xp3GIM
 4vxHnzPFKRliawFq9EkTzKfOs4Th9paMaG+CxZwXl0I9Fl4=
X-Received: by 2002:a05:600c:3f08:b0:49c:f13e:e50 with SMTP id
 5b1f17b1804b1-49e6108c75dmr69869655e9.13.1789156726619; 
 Fri, 11 Sep 2026 12:58:46 -0700 (PDT)
Received: from localhost.localdomain
 (dynamic-095-114-033-154.95.114.pool.telefonica.de. [95.114.33.154])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e63c9a7c9sm121892875e9.13.2026.09.11.12.58.45
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 11 Sep 2026 12:58:46 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Louis Chauvet <louis.chauvet@bootlin.com>,
 Javier Martinez Canillas <javierm@redhat.com>
Cc: Karl Mehltretter <kmehltretter@gmail.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] drm/vblank: Fix a name that does not exist in kernel-doc
Date: Fri, 11 Sep 2026 21:57:29 +0200
Message-Id: <20260911195729.78610-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 13 Sep 2026 20:53:15 +0000
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

The kernel-doc comment of
drm_crtc_vblank_helper_get_vblank_timestamp_from_timer() refers to
drm_crtc_helper_get_vblank_timestamp_from_timer, which does not exist.
The name is drm_crtc_vblank_helper_get_vblank_timestamp_from_timer. Say
drm_crtc_vblank_helper_get_vblank_timestamp_from_timer.

Fixes: 74afeb812850 ("drm/vblank: Add vblank timer")
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 drivers/gpu/drm/drm_vblank_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_vblank_helper.c b/drivers/gpu/drm/drm_vblank_helper.c
index d3f8147ecdc126e02010da2b9a7435e0a8708ba1..02d5c4b1e33d50cee3ca1a10c449f3ce00125999 100644
--- a/drivers/gpu/drm/drm_vblank_helper.c
+++ b/drivers/gpu/drm/drm_vblank_helper.c
@@ -154,7 +154,7 @@ EXPORT_SYMBOL(drm_crtc_vblank_helper_disable_vblank_timer);
  * @vblank_time: Returns the next vblank timestamp
  * @in_vblank_irq: True is called from drm_crtc_handle_vblank()
  *
- * The helper drm_crtc_helper_get_vblank_timestamp_from_timer() implements
+ * The helper drm_crtc_vblank_helper_get_vblank_timestamp_from_timer() implements
  * get_vblank_timestamp of struct drm_crtc_funcs for CRTCs that require a
  * VBLANK timer. It returns the timestamp according to the timer's expiry
  * time.
