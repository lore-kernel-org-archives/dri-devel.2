Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 218C4606B05F
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 14:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rRNjhkDx
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A60281124E2;
	Thu, 19 Nov 2026 14:49:55 +0000 (UTC)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E15461124E2
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 14:49:49 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-4a35d5d4a20so24812675e9.2
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 06:49:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795099788; x=1795704588; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hgLxpH3LEm6Qly6PZhos0Gifa/hrNOwM+ajMDoFp79c=;
 b=rRNjhkDxfC+a0jbSCoanmuWFTMOxF58G+T73iMccJi61dCO5dATFy4rAwytQhot5/e
 HUM9YAwhMard3Qcs07YbmmM3lvtLZrzm7sSuTZxF8X4SE2w2Pb/Jlyxz5pYaiMY9bUVF
 3CYSZs9df7lcV6i7GfSWOprtNFpKXcU/ZqXa0PlqDNFEycl/jrYgx/pLQ7iEFVfjm6ky
 1RpwYuTmMKPNF4O5lqn+2ChRwBhKJFVWltr6EEGAz8eL18B7xIELbj7ZzuKFeI0NHRgX
 bTO4v3KyZlVPZYkbNeaG9d2h5W50YUmkJdjTTqzRX8IhmgnafAkAoMilO5bxINnUo470
 AksA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795099788; x=1795704588;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=hgLxpH3LEm6Qly6PZhos0Gifa/hrNOwM+ajMDoFp79c=;
 b=ATj7W9gBnMo3u1zCY14qxVdWW+Q5msktAQRwafdVZGeShmB0zr9fYBsx4QreP9sx0D
 JovPvVuyj4L0+hGIdkBtQL17HhNTRfC5zX6XnAa2pd/8KA++9sw2cS2pbBNYhx0snHn0
 /YKxcu+GdCLEzi8YEv4TCY6HdPqlP41LOA0XFugbdscK3ybewGIKnBYlw+zLaSi96aZk
 3ZBJXswYnd6qnKxq3UBpnKb+aWkVkYH1KVZQZQSoGeexmQTH9UGuZOH5GwVt0NdpnyDU
 E0T34FNk9l3ncEy/BmK8wHWVArII/xI/2ZFLQA0GLqdaoZR2h6TwQuouitZS1zIG/+nb
 Vuow==
X-Gm-Message-State: APuU4Z8MtkMWA1UpALhZFeQPr+DuAY3kMVyJ64n/JdJY7w1K29gFvcs1
 tB0REIyknIiNxoHEVvm03kOD1/JSJkUlq0FgH+f2i4rDzEq73xFM3xVz
X-Gm-Gg: AYBFou3eIVyaoYNh5OoHtScNs5CdoGQrUjyqxg8xKlMOB6nDYnQ5MEhCRSAjgiLRCth
 6kdOyKYV1F4u/69iJ/k3wNLVZ7y5j22xS7YQBy10ws1uk9HiFm6Yi6DZq0N8aBIJVdebXPqU+fK
 B4jAqTH1lqVNp4H5MN/BfKeFOOS1PpddzfJvPgtpDWVICjFWYZe9pPY7XS4rKcQ8bhIyD36uz3b
 O9zqEm3BOH0XjS345fSTH9v1RXG92LiMX9NV32cRZdaxWN0ypeGFUAHUuz1WRpz4/ono8es69mo
 hv/eLLLXDQMBnDHC+aIjyhVqHbBeMSkGU0zOcvAkinDsBWlAnHYgod/VAedAuXfK1czY/CpcmCs
 Gkm31Lof1c5Or7xgYBun5XFCPBqt1tLPCpL0/D30eVu8DWpSg0t8e7njwqou4E6THB5I5y/KNIz
 J/dV5DJeddDpSoeuT2Px8kyYW3AYRUFVkeOeXU9EoJrpn4E6PMONNp9YexVlQgq46TyRmA+rVt7
 33m05p7/s1DuP2gWbXvrHoMQG1ImmA2Ygro4MKQx37IRJoPhA6bdj/HeKD9E/KdNxgzSM+1gd+g
 xXRBPrUvSxHKgZ9alEY0J5jatnBX7zifrjgVxaNl0A==
X-Received: by 2002:a05:600c:3b91:b0:49f:e772:6ddf with SMTP id
 5b1f17b1804b1-4bb7da4647dmr143326545e9.32.1795099788158; 
 Thu, 19 Nov 2026 06:49:48 -0800 (PST)
Received: from [10.111.176.198] ([2001:19f0:6c01:2c43:5400:5ff:fef6:1b30])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb84e4df2bsm38881785e9.3.2026.11.19.06.49.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 06:49:47 -0800 (PST)
From: Oarora Etimis <oaroraetimis@gmail.com>
Date: Thu, 19 Nov 2026 15:49:08 +0100
Subject: [PATCH v4 2/2] drm/vkms: queue the composer work under the output lock
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261119-composer-v4-2-5973fc9296ee@gmail.com>
References: <20261119-composer-v4-0-5973fc9296ee@gmail.com>
In-Reply-To: <20261119-composer-v4-0-5973fc9296ee@gmail.com>
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
queue can land on freed memory.  A legacy cursor update and a CRTC disable
both complete flip_done without waiting for a vblank, which is what makes
the window reachable.

Hold the lock across the frame accounting - including
drm_crtc_accurate_vblank_count() - and the queue, so the state that was
read is still the state that gets queued.

Fixes: 88ad7f3a5660 ("drm/vkms: Reduce critical section in vblank_simulate")
Signed-off-by: Oarora Etimis <oaroraetimis@gmail.com>
---
 drivers/gpu/drm/vkms/vkms_crtc.c | 5 ++---
 drivers/gpu/drm/vkms/vkms_drv.h  | 3 +--
 2 files changed, 3 insertions(+), 5 deletions(-)

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
 
diff --git a/drivers/gpu/drm/vkms/vkms_drv.h b/drivers/gpu/drm/vkms/vkms_drv.h
index 4f9f1614281a..290eeb988498 100644
--- a/drivers/gpu/drm/vkms/vkms_drv.h
+++ b/drivers/gpu/drm/vkms/vkms_drv.h
@@ -213,8 +213,7 @@ struct vkms_crtc_state {
  * @composer_workq: Ordered workqueue for @composer_state.composer_work.
  * @lock: Lock used to protect concurrent access to the composer
  * @composer_users: Number of users that currently hold a composer reference; the composer
- *		    is active only while it is non-zero. Updated under @lock and read with
- *		    READ_ONCE() from the vblank timeout.
+ *		    is active only while it is non-zero.  Updated and read under @lock.
  * @composer_state: Protected by @lock, current state of this VKMS output
  * @composer_lock: Lock used internally to protect @composer_state members
  */

-- 
2.56.1

