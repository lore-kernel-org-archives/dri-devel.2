Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FAEBC4451C
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 08:21:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7268210E729;
	Tue, 21 Jul 2026 08:21:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="VZ/C94Um";
	dkim-atps=neutral
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com
 [209.85.208.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 20EA010E2F6
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 08:21:33 +0000 (UTC)
Received: by mail-ed1-f44.google.com with SMTP id
 4fb4d7f45d1cf-69a5ecbbfb2so12551095a12.2
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 01:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784622091; x=1785226891; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WvkB7fQj9FMYGIgyusU+WdEm+X4LQCuorVOln1T7cnc=;
 b=VZ/C94Umum9A7P3XPiQ7UH2SniT5B9a4sAyCaoiQ/0/XeeXwHRLF4nu0BLivzmmZlY
 Kbc1HpG6BDYGREbu+TiZxk2tvBHVTlwBCj/gcjA664oHWd5t3s1mdt8g6mbnPPzPR12w
 1HyfpwSLcLODvoJKiUMSVB4A+TmwVwqHJXwlNgimyvEWoxRgcgr/Nr8s64vxcEj6cgHq
 biS0vMZ6axx2N18P39LsV03ep82qPlQvs6WIVHXR6nXdbpoc9cuGys2YFkm2q0G842wE
 PmdU0w5UjAU+pvY9bLoHi7kMZvqeW5rjQrfa5AJjxCY0jUUsL144AoUIoyTDU1zHAy/F
 q4uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784622091; x=1785226891;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=WvkB7fQj9FMYGIgyusU+WdEm+X4LQCuorVOln1T7cnc=;
 b=i2Odaz49tWz0ecYzjRomwuzYUdk/S8D607OFMHHc6GS2xYjzrVZeKwZmwfS/phucFR
 Wd9E1rX2JKqW3E3AwYeNNLfD5zSlALmad021iVb/AUAiujSvzsoyAa9PhgyjDwx5EiAN
 baEy38vNnuPj1YlTJ4NJZgvXiy62xYPbDt3B1dAiGOoHLMiUVfirnBeHaM1EBN56VV9i
 orTqIQLylACyvTc4kNMkSvq1ycaLxeAL1WTpuLSLQFQ+cAbGovjIWZpxX/9Kj+5VeUXq
 +DMbq/iRue9eRz4IxIzAGyLJAuEBpms//csh0J+RM4foIs9Hq0EHI25vtnvWHEd668fo
 25qQ==
X-Gm-Message-State: AOJu0YyK2W8ZzaeDq8y6dvK2e1BKGMC6fFnQvsibFbolaleQvUtO6pP8
 JbJcIzzWK4csIS+MLOAwf/15q9FY6HUSIx3NdlEQz4f2FHhrZpWoaUjcwarnASobUP8=
X-Gm-Gg: AfdE7ckZ/C6P3elcTU2glrN9LYSdUgOqG4N6iLsY3V6OqorxccxVjj6tgwN6pyiAov0
 yxH9M9ff0eXwSH6WZcS1vCSkRVWKw6wF5B9tf1TkPsgtKuWnl8edNPKFWWbizsBct4DZUT9DTZs
 2TeKUBxqKC4wtN/h1Nl4Qso3dVIibeSTEYIHeMgKKjQ9zfCUh6wCy/Expcm+DdQqnv/Tix7qjLQ
 hUzx9Mwuk+vGZ//DIcDhVl1RWIUJ58IpKa4No4hQkTUykj5+0ECnpsifeTemJkTSOLCM9po6+pH
 MYWFoyArIlCqiDVl8wgmhAX226+jAJG11yNAKr+TW952RkLyDKpfkST+ZzaU6ZCcSQ0MmgZZk4a
 lSDPIau2SBTpd32aUqBLu7EtWwJpykCjOMK54s5z0jvVStO902L0ibwfmkQMMWmjlpC8+yYuQ6U
 yyMhb2ol4Qfog6PdJaXgPZFWs7fn1h3l5UFmKauv2KSaQgfM+Lae+Y3Z6bwL7FaAMCzw==
X-Received: by 2002:a17:906:ef08:b0:c16:7414:4c29 with SMTP id
 a640c23a62f3a-c16b473acc7mr947501366b.25.1784622091388; 
 Tue, 21 Jul 2026 01:21:31 -0700 (PDT)
Received: from puffmais2.c.googlers.com
 (185.155.90.34.bc.googleusercontent.com. [34.90.155.185])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c1724f50b72sm564725066b.48.2026.07.21.01.21.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 01:21:30 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Tue, 21 Jul 2026 09:21:26 +0100
Subject: [PATCH v3 1/2] drm/drm_crtc: ensure dma_fence_ops remain valid
 during device unbind
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260721-linux-drm_crtc_fix2-v3-1-afa8c71506e6@linaro.org>
References: <20260721-linux-drm_crtc_fix2-v3-0-afa8c71506e6@linaro.org>
In-Reply-To: <20260721-linux-drm_crtc_fix2-v3-0-afa8c71506e6@linaro.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Sumit Semwal <sumit.semwal@linaro.org>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, 
 Boris Brezillon <boris.brezillon@collabora.com>, 
 Philipp Stanner <phasta@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 Sean Paul <seanpaul@chromium.org>, 
 Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org, 
 Peter Griffin <peter.griffin@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, Juan Yescas <jyescas@google.com>, 
 kernel-team@android.com, Simona Vetter <simona.vetter@ffwll.ch>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.3
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

In [1], sashiko reported the following issue:

=== snip ===
Looking at how these fences are managed, drm_crtc_create_fence()
creates a dma_fence without taking a reference to the drm_device or
drm_crtc. Because the sync_file framework exposes this fence to
userspace, the fence can outlive the CRTC.

The dma_fence contract requires that data accessed by dma_fence_ops
(like get_driver_name) must remain valid for an RCU grace period after
the fence is signaled. However, drm_crtc_cleanup() and the subsequent
freeing of the device do not wait for an RCU grace period via
synchronize_rcu().

If userspace calls ioctl(SYNC_IOC_FILE_INFO) concurrently with a device
hot-unplug:

CPU1 (Userspace)
sync_file_get_name()
  ops = rcu_dereference(fence->ops);
  if (!dma_fence_test_signaled_flag())
    // Preempted or delayed here

CPU2 (Driver Teardown)
Signals the fence (setting fence->ops = NULL)
Destroys and frees the CRTC without waiting for an RCU grace period

CPU1 (Resumes)
  ops->get_driver_name(fence) -> drm_crtc_fence_get_driver_name()
  crtc = fence_to_crtc(fence); // Casts to the freed CRTC
  return crtc->dev->driver->name; // Use-after-free

...

Does the CRTC or DRM device need to be kept alive for the RCU grace
period, or should the fence hold a proper reference to prevent the
use-after-free when get_driver_name() and get_timeline_name() access
the freed CRTC structure?
=== snap ===

I believe this to be a correct observation and this patch implements
the suggestion of waiting for an RCU grace period before proceeding
with destruction of the drm_crtc, so that get_driver_name() and
get_timeline_name() can still work.

Link: https://sashiko.dev/#/patchset/20260618-linux-drm_crtc_fix2-v1-1-c03e77b36f34@linaro.org?part=1
Fixes: 6d6003c4b613 ("drm/fence: add fence timeline to drm_crtc")
Cc: stable@vger.kernel.org
Signed-off-by: André Draszik <andre.draszik@linaro.org>

---
v3:
- Philipp: update kerneldoc, add Fixes:

v2: new patch
---
 drivers/gpu/drm/drm_crtc.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/drm_crtc.c b/drivers/gpu/drm/drm_crtc.c
index 63ead8ba6756..e8e80c936852 100644
--- a/drivers/gpu/drm/drm_crtc.c
+++ b/drivers/gpu/drm/drm_crtc.c
@@ -493,14 +493,23 @@ EXPORT_SYMBOL(__drmm_crtc_alloc_with_planes);
  * drm_crtc_cleanup - Clean up the core crtc usage
  * @crtc: CRTC to cleanup
  *
- * This function cleans up @crtc and removes it from the DRM mode setting
- * core. Note that the function does *not* free the crtc structure itself,
- * this is the responsibility of the caller.
+ * This function cleans up @crtc and removes it from the DRM mode setting core,
+ * after first waiting an RCU grace period to ensure @crtc->dev can safely be
+ * dereferenced by our dma_fence_ops.
+ *
+ * Note that the function does *not* free the crtc structure itself, this is the
+ * responsibility of the caller.
  */
 void drm_crtc_cleanup(struct drm_crtc *crtc)
 {
 	struct drm_device *dev = crtc->dev;
 
+	/* Ensure our dma_fence_ops remain valid for an RCU grace period after
+	 * the fence is signaled. This is necessary because our dma_fence_ops
+	 * dereference crtc->dev.
+	 */
+	synchronize_rcu();
+
 	/* Note that the crtc_list is considered to be static; should we
 	 * remove the drm_crtc at runtime we would have to decrement all
 	 * the indices on the drm_crtc after us in the crtc_list.

-- 
2.55.0.229.g6434b31f56-goog

