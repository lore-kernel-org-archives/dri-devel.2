Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03A9606A324
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 13:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DRzI/187
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E3861123EB;
	Thu, 19 Nov 2026 13:36:50 +0000 (UTC)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com
 [209.85.221.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 958591123EB
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 13:36:43 +0000 (UTC)
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-48e20ed3b9dso2055141f8f.2
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 05:36:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795095402; x=1795700202; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DBKtZ8f4rQ06PM27Ke8dD/8/HlYVMBZ4lK4BrID9KOk=;
 b=DRzI/187ul7wltUOeAsF1+OvA1jA6TudipLH6do9Km0Kk/wGxmPSwkLw9wRqQLEtt4
 /kZMvz10LfVezyh4N163+JkQq9FdHA6ZF9wa0Jv0HLDkR6VzyZJOc1Dr6WwJ/voSzmN7
 RwzcTt3Xp+LjAWz4TAoVsf3tPFOWmia2W+z7aTpGYtY98Id3zogMCEQdNMfmVqZpvwhg
 dO6bsgsHv+g+2q2JxGURc/s530XLZQtGxhf40Nmu80Xpu3rIHCTpOIMMCvpGzlqwVraZ
 WOMupoUHQlesOXz2vULSXYoWyNAA/CpqT9FAX8lh3qcSNuTcFhdqkNMQ5/JPV3ndH21l
 gjSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795095402; x=1795700202;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=DBKtZ8f4rQ06PM27Ke8dD/8/HlYVMBZ4lK4BrID9KOk=;
 b=NbahPrY0im8YyrOrQyGzWVk53ktfEDTVw/hHUoMJOks/TmqJlYTMrXcO0np2sRyg7W
 M3CBAzHBJRYeeAMVs9AFge1AApZa9iyVCl3Hqkw4MM6gTBz/xKOCUg1l+RYGfTIpXFzy
 R7xWx4rqHCs2P3hH+sN3So7tYQV4YryeujLEIRQCPGG5B2/MgriJwPUVhWE096WmJHJX
 T4knKeNMAkUhNVogPTDNnnFI39A39/y5k/bw18yuzK8haC7V4XA3PTty/M20a2SVhvkp
 D1JzHYssOUzt7c1H7hjRt3vcHTz/DBbJq2af4+DvM5Spgpo/Zjsm83kk0u7h2PonXpFI
 1bCg==
X-Gm-Message-State: APuU4Z91mRbmHQ2oNHzj7c0+B1Jig5Sa9koiq6rgRkOd/yDMNtZFfcEI
 pggzZJdisv6X/PmnfZpg7jK6CsrL/FILuDhoJcSbrh2BNMQbP7LLkPk3
X-Gm-Gg: AZFdTZdqukUaxLCYlwKFezwdcKV2i2vSk6it3ylbJYHBq5J/zG2UklbbUYCv/2HtPVH
 Rz2szTh/OiuoAjhGO6rY1v5wWlr54AOf6Dyd7JMuigsAx66PLr0fDIm4c75cvRxFxo+rpxeKtI9
 6SJL34HmQHke6iZRMgK5nR4bSnUG7jdwKE/lEDaWKJZqEkG6YIzokZJEVxFAIB5HdHBev5obQuS
 5nOy40hvzHesEaR1GN7HbuVu6m9LdRD7tFQduL728zxP+ZHe/Av8Kj1ON4zWEeisuCmpL9g2qGU
 WfmczjET/BdnSzspPrcAjVfo6Oi9Pv6vfu51iBPii8mRcKI3AVgKMMj4qVdxsXeN8TYyjno2AHa
 e+qcWmEeU/7sGSYo16taHvM2W+SmN4Qwd2+Bg1zKVp4EULFk2WfuvRj4R1xhpVNb0x5Kcz1RAYU
 dxR1e2dapjXbiZK/N0cSXe6KL+jg3PtkbQwBtgK15HdSaV2J9n9VNohWFxz6IuOMfCd+67atniT
 M5XBFpQlCVo5aNLntzuX2is+Jia2tn5zjYYfZkza3P5Y4Y8aSE+pYefp3zWcXpMjqCPjePohFtI
 NjaX21braxIDNc6S9wLExgDFhyIgGTEwUfS7XUfHJg==
X-Received: by 2002:a05:6000:299c:20b0:49c:9e8a:31ad with SMTP id
 ffacd0b85a97d-4a63ab743f8mr8922005f8f.42.1795095401941; 
 Thu, 19 Nov 2026 05:36:41 -0800 (PST)
Received: from [10.111.176.198] ([2001:19f0:6c01:2c43:5400:5ff:fef6:1b30])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4a6573ba95csm11547911f8f.56.2026.11.19.05.36.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 05:36:41 -0800 (PST)
From: Oarora Etimis <oaroraetimis@gmail.com>
Date: Thu, 19 Nov 2026 14:36:04 +0100
Subject: [PATCH v3 2/2] drm/vkms: queue the composer work under the output lock
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261119-composer-v3-2-dd470a820303@gmail.com>
References: <20261119-composer-v3-0-dd470a820303@gmail.com>
In-Reply-To: <20261119-composer-v3-0-dd470a820303@gmail.com>
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

