Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9172606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 12:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=ad9hlv/b
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 46FA41120E0;
	Thu, 12 Nov 2026 12:55:15 +0000 (UTC)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com
 [209.85.221.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9DC2010FA4D
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 09:43:44 +0000 (UTC)
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-48e47347279so1902585f8f.1
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 01:43:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1794390223; x=1794995023;
 darn=lists.freedesktop.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=17nTIOS/dd/uGgTMm9wblinmfvVg+kfi3Q9xJ7p3hHc=;
 b=ad9hlv/botKxJuURLhUX1a/Dhw4VrzZVkl+4D3teBdUxsLJwRt7WQvMAGFupC29Sp+
 uOzcDjNmQ/TG+cq3KtQuwaQuKFDu/xyrUObTSZ8DIi6HH5m4/pJUKV7uSGLJr3FIUbyb
 fM9mCK+J5NzQZzdZ2ARE7iuduXuJSD+kkJ96J4rlr4BP6XnAr5e+11cY8ypKO3Mnekqr
 DqYVZF+UU9E5azjcI9dU6QI5+tR1UVEcbk6TPiIB8sAGJkElGgeB62bfoLeAslKC6fAo
 voxKg/GE+aizzapKmqMSc8+hlGesjoSx7ztCLl+ru5yNhnttGBOojmhCwjQy+EBerVMl
 Gl7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794390223; x=1794995023;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=17nTIOS/dd/uGgTMm9wblinmfvVg+kfi3Q9xJ7p3hHc=;
 b=ueGjO5YOYfvsdA7obNsbCek/2YhxG+1T8biZf7PMQehYUj4JdYVoJuEmLUxPh4rKNH
 K7A0meNLAuyKmgiShrhLTV3/CEMynqY79CW14zAHffd2snp9dWnPEWIfElkKLdc3NNJs
 LLhyKc/JCvNRdHjyJ30QWS61Xj7HzNLeOd78hdQTjIgrtA8TghDfelbjk1hnmgwFQqEU
 iN24Fqw2JbsoqBBzwoBFIMrcBV4OzFVvJUO+uVVF3XfwrMjnsk/+7y67xUjlyZHOeGSJ
 4fbp9/8EP4mjNbDom/3EFUHZPMVo9BD1DWMeW34YRN3raan39k2TP7UTdVFgyJfFyrqC
 8InQ==
X-Forwarded-Encrypted: i=1;
 AL+hErE5R4todYl6SLdbfWIsylBeSPHlAKGxcGUjPMe0Uayq0j5lzEWFrzFOGbShffXAzRfoO3Rjki7K66g=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/badkBSkI//B/oJtCVd4BvQ7b4EGlJh4iBZmZ19JxSkugeLrJ3
 b9oH8I4q/68v1CWknL/0v2MGzOk7IdH4HqxXZjYIQXXwIv9A/83w5st++8doCHVdt7k=
X-Gm-Gg: AYBFou3+EVX3pDwW2f68QKY9Cmk2L7fHgtW5UpTf34n45n4c37usFnZ7R9kL3LMsmKI
 g4rop6455Ks+VnHoBupBMlWTFeBlwKst0312jnC64i7CfJIItaNQfXPlR7vz2Hgb1Q0JWB95SY/
 dW8VC46XCVBJjCSoJYqoq1+NbLH3RzAVv5ZlnL0bWOHe0y88NL6qnMtKU4oMJdIeyGqrqS/7QFv
 Au3s1CYGLzPFfs52KCI3DhieiF7QMNlv7hYCVwkfKneUxF+yEf1HqOmZtbJ2jssiLnodEXiUZeL
 adFOAv2fqX84417uzlV32ntu5t7KLxRxWOVgNIcXKF4krMD72zSIbbSMoXe37rrBLdqFDuM4KBy
 y6RXtRlPLV4O4/vNyhwfBEQbNSUj/UTHXWvUAPQZr3VluRuxcLnZ55w+59MB7BUbe0tizLxBhdO
 n3zUUNtu1q5DSEnt1W+04ub4MqPhvD7MOJ1c5aTwAtnJzjGIdhT93HvmkgNcq10IUE+9+Aqrty1
 +Nf6HUcgyJE/ysD+479CZs6WyMg1ZiwPgKMRNhoPeNAWycSkmbZ+UoL1yZfSbtOow+cIJPwEPlo
 8eeVFTreFKMnc7hxCJFM6OchsxwyWJNaKOLCFF/9rVujqz8gAreWbbyQzLZpI9+D9c1s7YH9
X-Received: by 2002:a05:6000:2506:b0:497:bd30:8df5 with SMTP id
 ffacd0b85a97d-499c434ba2fmr3395414f8f.2.1794390222924; 
 Wed, 11 Nov 2026 01:43:42 -0800 (PST)
Received: from [127.0.1.1] ([2a01:e0a:e50:3860::e1d1:d182])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-498365ccbccsm10200316f8f.44.2026.11.11.01.43.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 01:43:42 -0800 (PST)
From: Guillaume La Roque <glaroque@baylibre.com>
Date: Wed, 11 Nov 2026 10:43:18 +0100
Subject: [PATCH] drm/imagination: drop redundant zeroing of new GEM objects
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261111-pvr-gem-drop-zeroing-v1-1-2dc725857053@baylibre.com>
X-B4-Tracking: v=1; b=H4sIALU49GoC/yXMQQ6CMBBA0auQWTtJiykCVzEuoB3rmNg2UyWEh
 rtTdfkW/xfIJEwZxqaA0MKZY6jQpwbsYwqekF01tKrttFYG0yLo6YVOYsKNJHLw2F2sHfpzryZ
 joKZJ6M7rb3u9/Z0/85Ps+/uCfT8AnEw+4HgAAAA=
X-Change-ID: 20261105-pvr-gem-drop-zeroing-67cc98380a55
To: Alessio Belle <alessio.belle@imgtec.com>, 
 Luigi Santivetti <luigi.santivetti@imgtec.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>
Cc: imagination@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
 Guillaume La Roque <glaroque@baylibre.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794390222; l=3784;
 i=glaroque@baylibre.com; s=20261019; h=from:subject:message-id;
 bh=5J7YBCe5j9+nwpij7d9ckYkfgn/eiOZ+W8MPorbIWNA=;
 b=jXV9kmOq6eP63sQqsQoSW70q6JsnWFoM+OGtbLmsKdJIx9xdThIWLdwEkoqj7cAiAG6LXxJ1/
 9vYT5k+p7oCB3KHyclIJ9uTuCM3bYzvi0nDgdTajHlv36UlUxr7laUQ
X-Developer-Key: i=glaroque@baylibre.com; a=ed25519;
 pk=nMpSg4NT6M6q143E089emouMc+MXpHO9CWmnEUfjhjI=
X-Mailman-Approved-At: Thu, 12 Nov 2026 12:55:13 +0000
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

pvr_gem_object_create() clears every new object through a CPU mapping
so that userspace never sees data left by a previous owner of the
pages [1]. shmem already guarantees that: it clears each page it
allocates, and the dma_sync_sgtable_for_device() call that follows
makes those zeroes visible to the GPU. The second pass, write-combined
on non-coherent devices, only adds latency.

Link: https://lore.kernel.org/dd2ceacc-f59b-9c3c-e4ce-30b3bbd6939b@mailbox.org [1]
Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
---
pvr_gem_object_create() clears every new object through a CPU mapping,
on top of the zeroing shmem already does. Dropping that pass speeds up
object creation, most visibly where it goes through a write-combined
mapping on a non-coherent platform.

Testing: drm-misc-next (41ecf852c073) with a Debian rootfs, on a TI
J722S EVM (BXS-4-64, arm64) and a SpacemiT K3 Pico-ITX (BXM-4-64,
riscv64). The K3 also needs local patches that are not upstream yet:
its GPU DT node, an RPMI power domain fix for its firmware and BVNC
36.56.104.183. Each board ran two small test programs, once without and
once with the patch:

- The first one only uses the powervr DRM ioctls. It fills 250 objects
  with a pattern through their CPU mapping, frees them, creates new
  objects of the same size and checks they read back as zero. It also
  times DRM_IOCTL_PVR_CREATE_BO. Result, without -> with the patch:
    J722S: 0 -> 0 non-zero bytes, 16 MiB object in 20.6 -> 17.4 ms
    K3:    0 -> 0 non-zero bytes, 16 MiB object in 41.6 ->  9.2 ms

- The second one does the same check through Mesa's Vulkan driver,
  and also reads the new memory from the GPU: the GPU copies it into a
  buffer that the CPU then checks. 80 allocations, on the J722S only, as
  Mesa is not built on the K3 yet. Result: 0 non-zero bytes without and
  with the patch.

The test programs were written and run with the help of an LLM.
---
 drivers/gpu/drm/imagination/pvr_gem.c | 34 ----------------------------------
 1 file changed, 34 deletions(-)

diff --git a/drivers/gpu/drm/imagination/pvr_gem.c b/drivers/gpu/drm/imagination/pvr_gem.c
index d8660d6a8e01..01b8e08d12f0 100644
--- a/drivers/gpu/drm/imagination/pvr_gem.c
+++ b/drivers/gpu/drm/imagination/pvr_gem.c
@@ -275,34 +275,6 @@ pvr_gem_object_vunmap(struct pvr_gem_object *pvr_obj)
 	dma_resv_unlock(obj->resv);
 }
 
-/**
- * pvr_gem_object_zero() - Zeroes the physical memory behind an object.
- * @pvr_obj: Target PowerVR GEM object.
- *
- * Return:
- *  * 0 on success, or
- *  * Any error encountered while attempting to map @pvr_obj to the CPU (see
- *    pvr_gem_object_vmap()).
- */
-static int
-pvr_gem_object_zero(struct pvr_gem_object *pvr_obj)
-{
-	void *cpu_ptr;
-
-	cpu_ptr = pvr_gem_object_vmap(pvr_obj);
-	if (IS_ERR(cpu_ptr))
-		return PTR_ERR(cpu_ptr);
-
-	memset(cpu_ptr, 0, pvr_gem_object_size(pvr_obj));
-
-	/* Make sure the zero-ing is done before vumap-ing the object. */
-	wmb();
-
-	pvr_gem_object_vunmap(pvr_obj);
-
-	return 0;
-}
-
 /**
  * pvr_gem_create_object() - Allocate and pre-initializes a pvr_gem_object
  * @drm_dev: DRM device creating this object.
@@ -378,12 +350,6 @@ pvr_gem_object_create(struct pvr_device *pvr_dev, size_t size, u64 flags)
 
 	dma_sync_sgtable_for_device(drm_dev->dev, sgt, DMA_BIDIRECTIONAL);
 
-	/*
-	 * Do this last because pvr_gem_object_zero() requires a fully
-	 * configured instance of struct pvr_gem_object.
-	 */
-	pvr_gem_object_zero(pvr_obj);
-
 	return pvr_obj;
 
 err_shmem_object_free:

---
base-commit: 41b5458595c60143d0ebaa1e032c9cda5d764dff
change-id: 20261105-pvr-gem-drop-zeroing-67cc98380a55

Best regards,
--  
Guillaume La Roque <glaroque@baylibre.com>

