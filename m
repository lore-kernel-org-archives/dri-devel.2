Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEB08CA5FA5
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 21:02:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1FF7A10F0C4;
	Tue, 29 Sep 2026 21:02:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RGFouBOe";
	dkim-atps=neutral
Received: from mail-yx2-f38.google.com (mail-yx2-f38.google.com
 [74.125.224.166])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D73010F0C4
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 21:02:41 +0000 (UTC)
Received: by mail-yx2-f38.google.com with SMTP id
 956f58d0204a3-675617094f5so1267297d50.1
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 14:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790715760; x=1791320560; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=QduLVvo/6LGEURIIdyO8Zm2sFyH0SPaSfM/HS570OMU=;
 b=RGFouBOep2wKbEJUI1BObHntYTBa37LE/XXDdR1eHTtlh9/zghUWbuxVjIXgYQSyPc
 R+BPoD3G/jI/hHOoU7Bp9aAIj2MBCpUY5n9gMgtjui13UsMI1iCMoTgQ+bwrycm3i6m7
 jIx7BwJTuutYvVhT4GBMjXFS/ORwKFggPYiNZm3CePqC9jnsSEeiDheB2d3RllsI5aZE
 S4rd/LKARmFFapgdOrKZQvonVdG1P+eEtGgula4dhnQOXplIMJYi42Xxcbyz4KYCoz4H
 ZaBVaJxHIfFrV0HfqLLVrCEkq8mnFmRLs1CvLufNCZPJdYLg0fcjjTs1F+mZmUvQMi59
 M0dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790715760; x=1791320560;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QduLVvo/6LGEURIIdyO8Zm2sFyH0SPaSfM/HS570OMU=;
 b=s3puqXITqxZb5iBJRf7ACdwg5jikAgqhhR0crcZp+f1YzMvEpVS3BBCjm8M3i5uGqu
 xyKe+/j6n5VMKebvGl10JoqRvNXjBrAOx+8+mIsVj67uHtvaHL+shykhu3Uls32pBPjk
 rcmMoVCqxU3kDz1xaghb7r6aOe1Q8Gb/DP7linsQRKGD4AchYwVozwDfxm6GAVSEz10H
 xeGGgwaiPSjiVKTrfFLqu3ZcP6JEHCOU6KgOt2gNZWxD0LqItVTaf24R0QYoVBN6VlWn
 lHe4rvgskeJU3pu1Huu9nBXnTt43eJGUO+KpYFIgyPhYFSLOhQk04bBjbx6nKgziwBkG
 XxtA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzHV5ZMJDGZe6bwNFdVLr1LbY+wLczh8PLdq6NLXHqodAbyve0dmQvK6nQcj89ARtDbBlXBELmuEz0=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYK2x2Ri6Tna4PtlzLVkqQhcXtWsaV0hNVxnr/ey4jzBLCrUdABx
 rEQEFRb7c6T3Sv7DZwMvCsLqGmF2SkPvL40cOtSIwKc3KNuaOpTqpmDl
X-Gm-Gg: AYBFou21F4qzNr/0RNdVkNFvXfZCOp16E0FPX9U7dWrh0VwJNde0G59FP7olg8cQRxU
 NwEkiZgkscIsepTxPLh73k+K0kg2r3TfNS17wNPkxkPCGuxqpc1IpIDyaUTxoQsj2kuHLbI0jcB
 sg5GW0ZIYhvmzN8OaUMGPD+GUXSYSOnM+2Cs9hnZJAD652EkAagWgckMcT9YsmSgyqt5d9H5EP3
 u9+q8TaKgMsLgm1YwBchkAO8IrzRqTYFwRC/SwPVjoyVdoQW0n8WdkL9+28uoxZ4Ec6oVcEZYwy
 6glh3C8e7WaXwjis15LimbAHxVsqadqimIrf22o94er5MiQzLJaStQ8Cu1Ct/418fthdeCyAKV2
 cr+pbZyUrr7ZgUIspxV5OI1jpMnE5Wo9FeMg4uM9v80at7tzdmsPfrt6gu6sTgzgpEcc4kA2aQn
 yHm09J2tgt/VaP2s2Q7CGel4KNZQsHwSNlbos0zSM8TRWmgMkfDFaDPv/ocH0UvM55jKcZIQofk
 QtqLuTeSOKSK7buqvWUMEyRC/u0n2wlvBKXEioNzHt7WAYxZRbNrgZ+EqjFiNeTFdppqqNtzo57
 gz8Q+cJgbcqg3rArC04hBKqHkpKrqp813DcPmDEG5rB62WKrZrMNWZY4DNxJ0P1I4mAqnDClXaE
 =
X-Received: by 2002:a05:690e:484a:b0:668:172a:47a7 with SMTP id
 956f58d0204a3-67644049386mr127939d50.25.1790715759914; 
 Tue, 29 Sep 2026 14:02:39 -0700 (PDT)
Received: from fos (107-215-62-97.lightspeed.tukrga.sbcglobal.net.
 [107.215.62.97]) by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-675b773e342sm490345d50.20.2026.09.29.14.02.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 14:02:39 -0700 (PDT)
From: Adam Lewis <adam.j.lewis@gmail.com>
To: Zack Rusin <zack.rusin@broadcom.com>
Cc: Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, 
 Ian Forbes <ian.forbes@broadcom.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Adam Lewis <adam.j.lewis@gmail.com>,
 stable@vger.kernel.org
Subject: [PATCH] drm/vmwgfx: release imported dma-buf when the BO is freed
Date: Tue, 29 Sep 2026 16:59:28 -0400
Message-ID: <20260929205928.230301-1-adam.j.lewis@gmail.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

vmw_prime_import_sg_table() creates a BO for a foreign dma-buf through
drm_gem_prime_import_dev(), which attaches to the dma-buf, maps the
attachment and takes a reference on it.  vmw_bo_free() never undoes
this, so each foreign import leaks the attachment, its sg table and the
dma-buf reference, and the exporter's pages stay pinned after the GEM
handle, the DRM file and the importing process are gone.

Any client that can open a render node and obtain a dma-buf from
another exporter (udmabuf, V4L2, another DRM device) can pin memory
without bound.  KWin does so on its own in VMware guests: it wraps
wl_shm client buffers in udmabufs and imports them, leaking gigabytes
within days.

Call drm_prime_gem_destroy() for imported objects before releasing the
GEM object, as amdgpu, radeon and nouveau do.  vmw_bo_free() is TTM's
destroy callback, so TTM is done with the reservation object shared
with the dma-buf by then.

Tested on 7.1.13 and 7.2.7 with a udmabuf import reproducer and on a
Plasma desktop, where KWin's imported client buffers are now released.
The leak was found and the fix written with the help of an LLM coding
assistant.

Fixes: b32233accefff ("drm/vmwgfx: Fix prime import/export")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-fable-5.1
Signed-off-by: Adam Lewis <adam.j.lewis@gmail.com>
---
Notes (dropped on apply):

Security note: per Documentation/process/threat-model.rst an unprivileged
user must not be able to make the system unresponsive through unbounded
resource exhaustion.  On a default systemd desktop every logged-in user
has a render node (0666) and /dev/udmabuf (uaccess ACL), which is all
this needs, and the pinned memory survives the triggering process.  The
bug was found with AI assistance, so per security-bugs.rst it is treated
as public and the reproducer is not attached (available privately).
A CVE request will follow once the fix is in a released kernel.

Environment: VMware Fusion on an Apple M3 Max host, Fedora 44 aarch64
guest, vmwgfx 2.21.0, no swap.  Found on 7.1.12/7.1.13 (Mesa 26.1.8,
KWin 6.7.4), confirmed on 7.2.7 (Mesa 26.2.3, KWin 6.7.5).  The import
and destructor code is unchanged from v7.1 through v7.3-rc5 and current
drm-misc-fixes; b32233accefff went to stable # v6.6+.  Not the same
issue as f739416dc555 ("drm/vmwgfx: drop dma_buf reference on
foreign-fd prime import"), which covers ttm_prime_fd_to_handle()'s
error path and was already in the kernels tested.

How it shows up: KWin wraps every wl_shm client buffer in a udmabuf and
imports it into vmwgfx, for scanout and, when it renders with llvmpipe
because svga reports "No 3D enabled", as a texture.  Every import
leaked, so every client buffer stayed pinned: ~6 GB after a few days on
7.1.  debugfs bufinfo then listed 961 live udmabufs, 954 of them still
attached to vmwgfx, while kwin_wayland held 35 dma-buf fds.  On an
unpatched 7.2.7 boot, nr_foll_pin_released did not move at all in four
hours of desktop use, while MemAvailable fell to 2.8 of 24.5 GB.

Testing:
  - reproducer (udmabuf -> PRIME_FD_TO_HANDLE -> GEM_CLOSE -> close the
    dma-buf -> close the DRM fd): unpatched, the dma-buf outlives the
    process with refcount 1 and vmwgfx still attached; patched (7.1.13
    and 7.2.7), the pins are released as soon as the dma-buf fd is
    closed;
  - imported framebuffer: ADDFB2 + SETPLANE on/off + CLOSEFB through the
    screen-target path on 7.1.13, and ADDFB2 + CLOSEFB on 7.2.7, both
    release cleanly;
  - Plasma desktop on 7.2.7 with the patch, 30 terminal windows opened
    and closed: KWin created 298 udmabufs and 296 were freed (the other
    two were still in use), drm_prime_gem_destroy() ran for 85 imported
    objects, and the pin counters, slab usage and dma-buf census went
    back to their baseline;
  - builds without warnings with W=1 on drm-misc-fixes (e78a9fb).

Two related leaks on the same desktop, to be reported separately:
  - Mesa's kms-dri-sw winsys releases GEM handles with MODE_DESTROY_DUMB,
    which is EACCES on render nodes, so a compositor rendering with
    llvmpipe on a render node leaks the handle of every imported buffer
    (KWin up to 6.7.4; 6.7.5 falls back to the KMS node);
  - vmw_buffer_prime_to_surface_base() creates a GEM handle the caller
    never sees and WARNs for every foreign dma-buf.
With this fix those leaks last until the owning process exits; without
it they pin memory permanently too.

 drivers/gpu/drm/vmwgfx/vmwgfx_bo.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_bo.c b/drivers/gpu/drm/vmwgfx/vmwgfx_bo.c
index 9c7a73c..f226b32 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_bo.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_bo.c
@@ -31,6 +31,7 @@
 #include "vmwgfx_resource_priv.h"
 
 #include <drm/ttm/ttm_placement.h>
+#include <drm/drm_prime.h>
 
 /**
  * vmw_bo_free - vmw_bo destructor
@@ -69,6 +70,8 @@ static void vmw_bo_free(struct ttm_buffer_object *bo)
 		vmw_surface_unreference(&vbo->dumb_surface);
 	}
 	WARN_ON(!RB_EMPTY_ROOT(&vbo->res_tree));
+	if (drm_gem_is_imported(&vbo->tbo.base))
+		drm_prime_gem_destroy(&vbo->tbo.base, vbo->tbo.sg);
 	drm_gem_object_release(&vbo->tbo.base);
 	WARN_ON(vbo->dirty);
 	kfree(vbo);

base-commit: e78a9fb7a40c55ec2a70ae39903dde4f898af2ef
-- 
2.55.0

