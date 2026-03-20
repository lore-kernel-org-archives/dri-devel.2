Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 968E210987A3
	for <dri-devel@archiver.kernel.org>; Fri, 20 Mar 2026 16:08:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 85A8310EB22;
	Fri, 20 Mar 2026 16:08:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="qMvgkCo4";
	dkim-atps=neutral
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com
 [209.85.128.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D62AF10EB21
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Mar 2026 16:08:40 +0000 (UTC)
Received: by mail-wm1-f74.google.com with SMTP id
 5b1f17b1804b1-4837bfcfe0dso6998315e9.1
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Mar 2026 09:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1774022919; x=1774627719;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
 :reply-to; bh=/BAV0UN0oxOpyXD+zO9adlHObupqiFm/cwhTS5hHbNM=;
 b=qMvgkCo4sNBEyZl748zl/GtI/3kuTsAk8Ql7YraXINtERLiOj4iM+yUq8rgJRwD2Cp
 MGLpcE/8Q0dOsJ/RWDDURkmWbRmCs2p4Sk+7P8XlEDLGXiTRvYJYd3wNo3Gz9jQ/DTYC
 DfnjZDxV9IYbw03HT9B/xwjkTmTvyj5gOCtJZExdEjPu5l/XjOu0dYwGKdesXSXefoCn
 caVr8AEpkQYsjd0UYNHu16Xk8SB2al4tZqXqj7ywnCVTHuSyURvaYnnHQOciisnHirsm
 F5EiS3FhS5y8Ct9fcg3v+2fVIrqQH7NxBY8x6SvgW7C+5QjjBPd3KxmPcDqKHGoziY9b
 ZIRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774022919; x=1774627719;
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=/BAV0UN0oxOpyXD+zO9adlHObupqiFm/cwhTS5hHbNM=;
 b=o73BkuMpKeXuNvQjZ7/gHDEq4kcMGaQ9rQywnfv20qHA+LC18pU3bNn3OoQZEhqsTp
 mf0DCJgLsJkiuF2MPDFUhh0fdGg+HP/CTkGwaHjsfEwsoe5k5R68ZKRDDc/ZTaj9M6Iy
 +ggTsF/0im1KpjMgcoxwNClOa43ownqfL3v8GHLHhfSXBKNq0kody8VT6+0E9nOsMPEw
 AoFZi8WT3Y2M++ILZg6v461uvbsQY+XVfIGXVAlxmbN2PlOACQCqrR9G58rKt+Kv3ISW
 BgYMk0EbbVeSI6oSvAdzvcJCP/94EkoK7rqs8StpWodCKa0cLcGimwFbqQhZM920vVax
 oeNw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWx/yItI8JRJMqmfqJjR56bwRpGixJ0ZCD/O5V+MVcPusUbrkBLy4pQxN2WqyPuB3Wa7kAH/lFO+08=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz0XtqfsWWYUs16qSVBYzIqMIL9Ui8r+pYDfrpVVA0rKOKUHyUV
 ACGdyfD5j48PqpW4x5kcX1xF+cY26CzWWsuSrlYS3/zpIOVL82FNMS5CdcHrl0h4g/u4Pim5rIr
 FnaMsSJKb7N04mJgjpw==
X-Received: from wmej19.prod.google.com ([2002:a05:600c:42d3:b0:485:4f4a:bd87])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:5291:b0:485:4278:24fb with SMTP id
 5b1f17b1804b1-486ff04d6afmr53214535e9.32.1774022919337; 
 Fri, 20 Mar 2026 09:08:39 -0700 (PDT)
Date: Fri, 20 Mar 2026 16:08:26 +0000
In-Reply-To: <20260320-gpuvm-rust-v5-0-76fd44f17a87@google.com>
Mime-Version: 1.0
References: <20260320-gpuvm-rust-v5-0-76fd44f17a87@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp;
 fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=2619; i=aliceryhl@google.com; 
 h=from:subject:message-id;
 bh=9MaSYeQMVsO/xbbV7cBT0cy87FW81cANB6QK+J3LWZk=; 
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBpvXEClNe6r8Fk87JnvEfKv8OUplzwJoPGzIoGr
 3cMu7WCI+6JAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCab1xAgAKCRAEWL7uWMY5
 RhH/D/9TrPthCru1C4LRuKvU6ahTZweO8txlFbO6CbGuDachWky66rslljqV7IqQsMd0y+JrJ1G
 SgzuIT2lcF/BLpHi5xsHV55YemywXjL5hcw8qd/XirPkt/fK+Jk6AqjGBUGOmp8RJOvCbhvLyEn
 8H33yDXFid4QqQC59tU2miqHhb3ZLyWEu7LHQCeMGXWAhIJ18viTkhaKczyBRLAw6FTFkVOTVcs
 nWqP2jVMg6Ma4BMbd1kHM9iTMG4HdLW1ruYoYQDGESlFUsnCBJod73ZZOwUIi03SMZL2oi8PUQs
 cE6lYtphUfeRwjGkW+ghdy0XtvBQRD31bdThgJ//Akx6uxPh06E4pS+iKPyRj/ZTP+ABgQNPOQx
 8/vps2cnyJ9iTPGdeb47dOlrzEWxMW5uRK83h+hem3XKhoiimoeQwBRkWU2ZomsaIrw22wRoVHd
 /jr1ndvB1s53AtyJzCasjJ/kIM0+pqaG+l5mWL+v+ZjvknmPbj1U4pdciQprcHOroOLPG6scQQZ
 /L5LcOdowEj2115j0LTMFuoIIQA3SCMHuE3ixpv6jJYq5UkxIVh121kF3jwDKWg1B0xkVqlZuz3
 8XKsd/AGdZsssHMwAIiziHdUi8fDRymqF1m5MvIE9tsNwcMXz5Ulq81v1FeWXV3joAc4hJIDod0
 SelsXQkWve0JR5A==
X-Mailer: b4 0.14.3
Message-ID: <20260320-gpuvm-rust-v5-2-76fd44f17a87@google.com>
Subject: [PATCH v5 2/6] rust: helpers: Add bindings/wrappers for dma_resv_lock
From: Alice Ryhl <aliceryhl@google.com>
To: Danilo Krummrich <dakr@kernel.org>,
 Daniel Almeida <daniel.almeida@collabora.com>
Cc: Boris Brezillon <boris.brezillon@collabora.com>,
 Janne Grunau <j@jannau.net>, Matthew Brost <matthew.brost@intel.com>, 
 "=?utf-8?q?Thomas_Hellstr=C3=B6m?=" <thomas.hellstrom@linux.intel.com>,
 Lyude Paul <lyude@redhat.com>, 
 Asahi Lina <lina+kernel@asahilina.net>, Sumit Semwal <sumit.semwal@linaro.org>,
 "=?utf-8?q?Christian_K=C3=B6nig?=" <christian.koenig@amd.com>,
 dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-media@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
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

From: Asahi Lina <lina+kernel@asahilina.net>

This is just for basic usage in the DRM shmem abstractions for implied
locking, not intended as a full DMA Reservation abstraction yet.

Cc: Sumit Semwal <sumit.semwal@linaro.org>
Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
Signed-off-by: Asahi Lina <lina+kernel@asahilina.net>
Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Lyude Paul <lyude@redhat.com>
Reviewed-by: Janne Grunau <j@jannau.net>
Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
Taken from:
https://lore.kernel.org/all/20251202220924.520644-3-lyude@redhat.com/
with __rust_helper and MAINTAINERS file added.
---
 MAINTAINERS                     |  1 +
 rust/bindings/bindings_helper.h |  1 +
 rust/helpers/dma-resv.c         | 14 ++++++++++++++
 rust/helpers/helpers.c          |  1 +
 4 files changed, 17 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index b40923a18066..5d013a36f46f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7534,6 +7534,7 @@ F:	include/linux/*fence.h
 F:	include/linux/dma-buf.h
 F:	include/linux/dma-buf/
 F:	include/linux/dma-resv.h
+F:	rust/helpers/dma-resv.c
 K:	\bdma_(?:buf|fence|resv)\b
=20
 DMA GENERIC OFFLOAD ENGINE SUBSYSTEM
diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helpe=
r.h
index ef0f010c268b..47279e993934 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -52,6 +52,7 @@
 #include <linux/device/faux.h>
 #include <linux/dma-direction.h>
 #include <linux/dma-mapping.h>
+#include <linux/dma-resv.h>
 #include <linux/errname.h>
 #include <linux/ethtool.h>
 #include <linux/fdtable.h>
diff --git a/rust/helpers/dma-resv.c b/rust/helpers/dma-resv.c
new file mode 100644
index 000000000000..71914d8241e2
--- /dev/null
+++ b/rust/helpers/dma-resv.c
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/dma-resv.h>
+
+__rust_helper
+int rust_helper_dma_resv_lock(struct dma_resv *obj, struct ww_acquire_ctx =
*ctx)
+{
+	return dma_resv_lock(obj, ctx);
+}
+
+__rust_helper void rust_helper_dma_resv_unlock(struct dma_resv *obj)
+{
+	dma_resv_unlock(obj);
+}
diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
index a83060f8500c..fa56d62c9014 100644
--- a/rust/helpers/helpers.c
+++ b/rust/helpers/helpers.c
@@ -28,6 +28,7 @@
 #include "cred.c"
 #include "device.c"
 #include "dma.c"
+#include "dma-resv.c"
 #include "drm.c"
 #include "drm_gpuvm.c"
 #include "err.c"

--=20
2.53.0.959.g497ff81fa9-goog

