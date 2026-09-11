Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F14B2C88E69
	for <dri-devel@archiver.kernel.org>; Sun, 13 Sep 2026 20:53:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C678910E9CC;
	Sun, 13 Sep 2026 20:53:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IhQaDmaj";
	dkim-atps=neutral
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 15CCC10E363
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 19:54:51 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-4998b5a63e2so14452695e9.1
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 12:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789156489; x=1789761289; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=+i+YV2SDOJ/fUOjXL4JkdG0lXGyDg3CLUWfYcCyxsKs=;
 b=IhQaDmajzxcvbe0o553f/3q7jpPfJvm6udVw8RWfHcoekJVX/xbojWZkQgI7tS8JvF
 dTgpc3gpCr8F8bA7lXG+5XQR8Qrc/lr7PA7h0U/LHmZI3ZNDoCxEfsZOX1mxw0zXMiqI
 D1vuGqKh3TohuZqUxUzu4dWJ2GlXKXWrqMxfFF1wfUxdfq0zdb0d7YIa2+1eIkVIFjy6
 9yWnDI5tlxtwJtA3KaO/oj2I0TgYk4BF79HAk3jbW8JKW5TgzbLiiUGD6PsZbP9dUWM3
 yUz0HPSQvhyp8Hu892TMCaZy8ZiSMebonSYV7GqdPqImm2dvIwQQdfeeDpoFy6Cl+OXH
 VIMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789156489; x=1789761289;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+i+YV2SDOJ/fUOjXL4JkdG0lXGyDg3CLUWfYcCyxsKs=;
 b=hpe7lHw+c03RRe4UPBLIdQj/7P493SzIT2362+25+j2GoZlJ9+Nqld/W2UvZQWxNK5
 CQL0cuwB9AXL0VN+g9aH1tL2HRN8PUv5W8sW9uBxwDFPe6Z4dfLB3sGX1qilNLUY2+S2
 8PmxyKmvmg2WZlDLMbuNIt75dywQn8NaejX+cbeImFgLshCH9iEDXgEMWFgJs3FcJO4I
 /1Y0UIFFEEndO8YehnMmbkiVat8Xya62Cj1ZN0AWHnzMbm05z0J7ain5u7MtEMm1PGsZ
 P6pEApdFCXnoIUGsLY9cqOaxpuchomkGLgq2M8fIu3fwhcSnjimIJtbpCvmBa3cbhNhO
 q0Dw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxAfkM0UYTSXyaRZtQGcI4VEzScGNPgYQtPKuAYc1/cDx1sZq9MENYI3Go+UR/tMJGCnfRtBr7P2yY=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lG9AoQdhQ441tTOPYGKTB6RLlun4NLFVhyo/UUCcLVPAQJ7Ga4
 NMJTBtM2C8qbqFemGPUA1sgDnWSScy1yGc/oIT8Z8PgBWWPB2cq7SSb0
X-Gm-Gg: AYBFou1HNDSUK8lrq0b9t6E8KyH6LYKsbn6ie+zVimnSKYIA2+ZsS5nVYMv8BG5kelX
 1ycU3F52gHbsFYrxd7eqVkTwacGFv0Lj9FKGLuI3oVfOmnIbb36P9RiW9Ti8N1bLZ9DpqUxuRgR
 vdAsn6r577d0HoeBCY19PsdfR81TA+YFhfll1wmNh8SASTX4SXZZSsc8uaqoD/EZPXFvQJ1jiDq
 6K9/uyKqzpjcC5Tzy7wnJjLad0Hkmp8XJNle6/nRof7Zs99XIuyobFN9pcn0MMJFgPqtnu4JNQ1
 Dfswmy0yDdxBUNE+w3Yfii5Ur7SQQca6XYhMWgTFRZ1GKpS+CDiD/Bl+XPsq+iA0kAbsS0w/0Lq
 hG+RRz69P+yhxEfmOdlk1Wx7Dau8IufF8bDJXkrg2lCPLNFrKNUBG+avnAv/Z0XsQwLLeyqeJwo
 MxXosk83y7KmsS05KPfPnN7APw7+kbhl84BY0tDKlwoB4QpdEX16EioNdb1a3mEm1Apw8OupjFb
 ocUEkJondY8ugwYH4cZFdSp4PmQgpdNAEoVq5DlYvXLzR+Sv+XwmSTbsbqH350ieJLh0uU2fMJ7
 FIu5b62i3WDJ/+KYAAtxlSeqSCGmp3AqYhpH
X-Received: by 2002:a05:600d:6501:20b0:49e:69e3:8848 with SMTP id
 5b1f17b1804b1-49e69e3916emr21708305e9.30.1789156488932; 
 Fri, 11 Sep 2026 12:54:48 -0700 (PDT)
Received: from localhost.localdomain
 (dynamic-095-114-033-154.95.114.pool.telefonica.de. [95.114.33.154])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e6576122bsm92640705e9.2.2026.09.11.12.54.47
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 11 Sep 2026 12:54:48 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Danilo Krummrich <dakr@kernel.org>,
 Matthew Brost <matthew.brost@intel.com>,
 =?utf-8?q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Alice Ryhl <aliceryhl@google.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Sumit Semwal <sumit.semwal@linaro.org>,
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Antonino Maniscalco <antomani103@gmail.com>
Cc: Karl Mehltretter <kmehltretter@gmail.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org
Subject: [PATCH] drm/gpuvm: Fix names that do not exist in kernel-doc comments
Date: Fri, 11 Sep 2026 21:53:28 +0200
Message-Id: <20260911195328.78529-1-kmehltretter@gmail.com>
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

The GPUVM documentation refers to drm_resv and
drm_exec_prepare_object(), but the reservation object type is dma_resv
and the locking helper is drm_exec_prepare_obj().

Use the existing names in the reservation object and map locking
documentation.

Fixes: bbe8458037e7 ("drm/gpuvm: add common dma-resv per struct drm_gpuvm")
Fixes: 471920ce25d5 ("drm/gpuvm: Add locking helpers")
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 drivers/gpu/drm/drm_gpuvm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_gpuvm.c b/drivers/gpu/drm/drm_gpuvm.c
index d1c80ad3deadb7f2e78abf7e50e61ad085391e3f..c43708be348c3659bc7888c1aad25b470ff2cee0 100644
--- a/drivers/gpu/drm/drm_gpuvm.c
+++ b/drivers/gpu/drm/drm_gpuvm.c
@@ -1051,7 +1051,7 @@ static const struct drm_gem_object_funcs drm_gpuvm_object_funcs = {
  * @drm: the drivers &drm_device
  *
  * Allocates a dummy &drm_gem_object which can be passed to drm_gpuvm_init() in
- * order to serve as root GEM object providing the &drm_resv shared across
+ * order to serve as root GEM object providing the &dma_resv shared across
  * &drm_gem_objects local to a single GPUVM.
  *
  * Returns: the &drm_gem_object on success, NULL on failure
@@ -2718,7 +2718,7 @@ static const struct drm_gpuvm_ops lock_ops = {
  * @req: ptr to drm_gpuvm_map_req struct
  *
  * This function locks (drm_exec_lock_obj()) objects that will be unmapped/
- * remapped, and locks+prepares (drm_exec_prepare_object()) objects that
+ * remapped, and locks+prepares (drm_exec_prepare_obj()) objects that
  * will be newly mapped.
  *
  * The expected usage is::
