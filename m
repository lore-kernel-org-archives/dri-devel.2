Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C3D60A260D
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 12:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YaXaC3Wx
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF7FC10FDE2;
	Thu, 19 Nov 2026 12:56:09 +0000 (UTC)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com
 [209.85.221.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3674C10FDE2
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 12:56:03 +0000 (UTC)
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-4a358881793so1159267f8f.0
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 04:56:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795092961; x=1795697761; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DBKtZ8f4rQ06PM27Ke8dD/8/HlYVMBZ4lK4BrID9KOk=;
 b=YaXaC3WxubuK7eUhmUvntwWv5Oi1z4sA74/cfRsohMytglQbzcsIJ/EDVji1sG/eNw
 prtrve4TfpB8Bpo02G81QxkLLjVFK1tZWvt3XTQa//oyiGhyPA8m3zOplUBEYimIGgbW
 IzeDfTSdAdO6qBcCp6bwUQt5R6pmXNtkCG1wnrVzKEhzEcyI2eNKQm7sZwVE7bSqEoC0
 EAvioXpvm3g3T3SHTnlAk0NJB7S0cjg9n8hTfWKVjQJHrqVrbkgW76NjlMmWKNe7FxHu
 ZL3IlCLGV693CI52RLlm+ZErl8LzPZN6LRiSOtcPtb/tvYdAOJJBxrDF5xvrUrjMNL+T
 XR0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795092961; x=1795697761;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=DBKtZ8f4rQ06PM27Ke8dD/8/HlYVMBZ4lK4BrID9KOk=;
 b=Rryx5/kmyb3V65Vvt58eziKcEtAb4m5edbL1WjgBV0YRcH6+v69Y3TzkLxHYCYgmPZ
 299uFDRdvf8BdA0ONks3ootfwhEGENI4fQXN3EO8plVrM2JUomCufTLxhZF07cMtHGXM
 eAfgB9TDnfpU8KKckxFPmZR7GY97CKeHnZp7syey0Xe4ahNg65f7erz8WD/uLOx2zvvc
 jo1c63g44/XPq1FPIY9cPh9HJwBpmmlfjpzlOk4eFzgHA2uOLqupE5YUmJZVo+BQMP2D
 XrGjjDoPrd+T43e53vOCP97DxpIY2i140Fcq39erZ+KOHfIZTeHp/xxuht43Edlh5VNU
 ry/g==
X-Gm-Message-State: APuU4Z9g5Agl1UQCRJT4IYc1cYxrtpSeHxC1JfHNHZGwVkM6lR5DQV81
 JSdWgZ57LdMyHChGbsgNHWIWRIRhW/KybZvCJ77X4SOYLyeRuLjVwONZ
X-Gm-Gg: AZFdTZcd9XTomsgYg3CcfTajWt8KTd5/my/hPzWdSPcnZYihvLjXrwgex9lS4QWDXhF
 zJO0U9EeLMoYmKiEop/vTfBPqCuokpxqtanrjhKEqu6mdLtDj29NZYL3HYSLSXG3EKVSXHb/0YU
 wdcxy/AYUImvlAerzeinJUoPeAuIl7ifhN5vjlQHoRG0kI/p4jB0ktlLCJFN47ErQ+PycmHlDzy
 bo683h47nTs/N1lLW0x0q7cNqwo+DEqehWe74VOO1IuklnGgPhbxKv7sF40u9s+NsQMdUuE8280
 +run6EJKhG2i8CMqCqjvhycifd9Atny9megiTZQdKsaFs3Co08cmcc1q0/8TxQ6szHjKzmRH9oy
 1T+qIAj+ZnSE4weAYf0KalXSypkvtDmTLFMboa5XMhdVCPBc43MqBCnXLRijgl9/UGqWuR3+X8E
 +zPWQbZpMFtkuIryO2tbNXnYgecVhPKa+gDIQEiNPxWu9WP3B85uciwIetjZI0Giezx+p4jdJdw
 +WUg4dv9H7+hXg7MYa2WKzFQjp9i/isuMHECIlEcUvS9biizZCO49CLTrWFJQKsIfV5JMC9FHho
 aasJJ5vdzQfF8n7+3O/eTBCTuWFiYzQYi/qfUgLlt/IK67Pc7dq/dZAuJwIFy/0=
X-Received: by 2002:a05:6000:200c:b0:490:411a:1eed with SMTP id
 ffacd0b85a97d-4a63d2cf93emr12483342f8f.39.1795092961524; 
 Thu, 19 Nov 2026 04:56:01 -0800 (PST)
Received: from [10.111.176.198] ([2001:19f0:6c01:2c43:5400:5ff:fef6:1b30])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4a650d2e26csm10198193f8f.4.2026.11.19.04.55.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 04:56:01 -0800 (PST)
From: Oarora Etimis <oaroraetimis@gmail.com>
Date: Thu, 19 Nov 2026 13:55:27 +0100
Subject: [PATCH v2 2/2] drm/vkms: queue the composer work under the output lock
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261119-composer-v2-2-a935e9bae6be@gmail.com>
References: <20261119-composer-v2-0-a935e9bae6be@gmail.com>
In-Reply-To: <20261119-composer-v2-0-a935e9bae6be@gmail.com>
To: Louis Chauvet <louis.chauvet@bootlin.com>, 
 Haneen Mohammed <hamohammed.sa@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Melissa Wen <melissa.srw@gmail.com>, Oarora Etimis <oaroraetimis@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, Liviu Dudau <liviu.dudau@arm.com>, 
 Rodrigo Siqueira <siqueira@igalia.com>
Cc: dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

vkms_crtc_handle_vblank_timeout() reads output->composer_state under
output->lock, then drops the lock and queues a work item that lives inside
that state.  The commit that retires the state frees it after flush_work(),
which does not wait for a work item that has not been queued yet, so the
queue can land on freed memory.

Hold the lock across the bookkeeping and the queue, so the state that was
read is still the state that gets queued.

Fixes: 88ad7f3a5660 ("drm/vkms: Reduce critical section in vblank_simulate")
Signed-off-by: Oarora Etimis <oaroraetimis@gmail.com>
---
 drivers/gpu/drm/vkms/vkms_crtc.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_crtc.c b/drivers/gpu/drm/vkms/vkms_crtc.c
index 4e15abfd92a0..d2c6ffbad07c 100644
--- a/drivers/gpu/drm/vkms/vkms_crtc.c
+++ b/drivers/gpu/drm/vkms/vkms_crtc.c
@@ -27,9 +27,7 @@ static bool vkms_crtc_handle_vblank_timeout(struct drm_crtc *crtc)
 		DRM_ERROR("vkms failure on handling vblank");
 
 	state = output->composer_state;
-	spin_unlock(&output->lock);
-
-	if (state && READ_ONCE(output->composer_users)) {
+	if (state && output->composer_users) {
 		u64 frame = drm_crtc_accurate_vblank_count(crtc);
 
 		/* update frame_start only if a queued vkms_composer_worker()
@@ -49,6 +47,7 @@ static bool vkms_crtc_handle_vblank_timeout(struct drm_crtc *crtc)
 		if (!ret)
 			DRM_DEBUG_DRIVER("Composer worker already queued\n");
 	}
+	spin_unlock(&output->lock);
 
 	dma_fence_end_signalling(fence_cookie);
 

-- 
2.56.1

