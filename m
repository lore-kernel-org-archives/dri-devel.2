Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41062C5B56A
	for <dri-devel@archiver.kernel.org>; Wed, 12 Aug 2026 07:08:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8909210EE64;
	Wed, 12 Aug 2026 07:08:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="o8j7Ih0L";
	dkim-atps=neutral
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com
 [209.85.216.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B1B1810E240
 for <dri-devel@lists.freedesktop.org>; Tue, 11 Aug 2026 08:47:18 +0000 (UTC)
Received: by mail-pj1-f51.google.com with SMTP id
 98e67ed59e1d1-382ef647e20so2968487a91.1
 for <dri-devel@lists.freedesktop.org>; Tue, 11 Aug 2026 01:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786438038; x=1787042838; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ly/Mo1nbCV/oSok4ztJy2PbfdvW3bZVZXW3Etcdsh1I=;
 b=o8j7Ih0L5RtmDv2doVKS7+EjwouptxEH29swEtxr+dd0kgGIdWh1WtPW+ibqxoiC01
 hA0uCR7HDqT2BIRgikyn83bD/FI+RZVAaBS0sskDlxzZs+5+uvEdx5hNT+gFvuPc+O60
 4hrpuO2pSr6osIRaARc0Kq/+4qoI/PkgDABstAxO9zWt78XRqIERIXG4t5Aou/o+nhN0
 FDFKT5bDLiNfuCHsMGgVRRq0fvVr1yqXkfgBtIudXXAXFxsTIQkCfDC4as4rixxGr7Zr
 9Wnk2Ra37jfRETy+jJBKqf9ihNaN4SoSzcBIcjDeqeNZFIf5Dm1nJiKYfaGrIUTBOyHI
 KR6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786438038; x=1787042838;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ly/Mo1nbCV/oSok4ztJy2PbfdvW3bZVZXW3Etcdsh1I=;
 b=dl/4+agMyrLw5iPRnO+fsn8H9LZnbJzRy7RnvF/eqk3HpAy7hgLmLUnqeUbBMmWOIH
 1enQSsmzqnTJUewiYail6irgg+f8/kv1aI3bvQWSmVf9+KnUpz1BD5ZQ89Inf/EDrmhu
 CdnJSi5JH4clY9bFM9tQLDmyYOMcmr4d1aL1JowY8Y/OZWU2a55ro15tNgYOq5n6p+tF
 zUDAeG6Dvp+YDZmkEmRMfUH/IqHU6vFp3U0/WtZ+fvYD5vhiAg6Y93pe08A51dDTG75E
 BEx2DXmYMw5p747k4VW5GW5XVD1qI+FTil8lDbZ4X2E5Xwz8FW9sNuehRyEnJ9JNWxwv
 YYiw==
X-Gm-Message-State: AOJu0Ywl9nw57KQ0quk963+Od/toP5yTLMnX20mmK8VylPqF+mkF20Bc
 914wqO6SkOrvQkOMOkCO1H0EOqvRHBSqZHnVk6DK4oeDRgTw0zBdkAyCzLs/9SZyylQ=
X-Gm-Gg: AR+sD13ZJcY8DGpz+hWtqTzBqj0YdNyQByLGhkLp66AvyH9DcV/zky7aaHbF7OoCwXL
 6bLlHihRj33xdkdK7Z9bRCt8Myi8GyR3d883hxg4l3+DGAzMAOsqXGjyIiBFx8hDkNRUPIYWKjQ
 rxIZw8XI9Em5p3p5NxS4Ey6ZfcvoUto42aX24CI7lOy8tht+iXcjUlNTDK4Q7soYuaB3XSjxKxl
 qtzrIeh47pnkChCgRSx0KvysWSpjgttSbHxyd0WPsURn6LrKpElCtGlcfSeWAlnL+AUdweDEGHw
 nlCFaR4+m4HNBLYIJKEONnr1yOYDJPKIMU3YV394iKlpAmxkL3RppuVyOtBvnybxgi/8E5uERrl
 U7dRDTN5l34z9v43LUAr3c1sHHq49rble3weMkP6azATtCs/0Ywvb+NglB1ZZCBJWGZZSHONV5d
 YwpeqzCVJ0dFVRSOGSlrbgOWsUCu/mBdon/zJRn9Gd4x/acz/aW02qcbZk2RQ=
X-Received: by 2002:a17:90a:ec90:b0:38e:2860:253f with SMTP id
 98e67ed59e1d1-392ec53e6c1mr1809410a91.12.1786438038162; 
 Tue, 11 Aug 2026 01:47:18 -0700 (PDT)
Received: from LAPTOP-N3B6U5LC.localdomain ([117.147.100.52])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-392e58a94aasm633058a91.4.2026.08.11.01.47.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Aug 2026 01:47:17 -0700 (PDT)
From: Zhenhao Wan <whi4ed0g@gmail.com>
Date: Tue, 11 Aug 2026 16:46:29 +0800
Subject: [PATCH v2 2/3] drm/nouveau/uvmm: fix premature region free on
 failed OP_UNMAP_SPARSE
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260811-nouveau-uvmm-vmbind-fixes-v2-2-aaee4b395d04@gmail.com>
References: <20260811-nouveau-uvmm-vmbind-fixes-v2-0-aaee4b395d04@gmail.com>
In-Reply-To: <20260811-nouveau-uvmm-vmbind-fixes-v2-0-aaee4b395d04@gmail.com>
To: Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Dave Airlie <airlied@redhat.com>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Zhenhao Wan <whi4ed0g@gmail.com>, 
 Yuhao Jiang <danisjiang@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786438000; l=2185;
 i=whi4ed0g@gmail.com; h=from:subject:message-id;
 bh=fKwS8hLuASUBBkfhmQft0t9owMYTP3CSXRQ1mDs9JW0=;
 b=yrXi/GfTrG95r3RXD9fwP33siW9x0kLUCR1OkBk7w2hfnn9/lRMc+wLYmEKPbf+pCazGFbf1e
 HvXu2K4qPhFBTyDVzpUhsUqHjP6hqOL8DT8dLd6LvcoE6Kq50n4Egw2
X-Developer-Key: i=whi4ed0g@gmail.com; a=ed25519;
 pk=zRTKlstE0LmilshGwJsFYEVjiT6RiXMBXK8Og6VmuVQ=
X-Mailman-Approved-At: Wed, 12 Aug 2026 07:08:20 +0000
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

In nouveau_uvmm_bind_job_submit()'s OP_UNMAP_SPARSE arm, op->reg is set
from nouveau_uvma_region_find(), which only looks the region up and takes
no reference; a region's sole reference is its membership in
uvmm->region_mt. Two failure paths leave op->reg set: the -ENOENT check
when the region is busy, and the drm_gpuvm_sm_unmap_ops_create() failure.
The sibling nouveau_uvmm_sm_unmap_prepare() failure just below clears
op->reg; these two do not.

unwind_continue steps back one op, so the failing op is skipped by the
unwind loop and its op->reg stays set. nouveau_uvmm_bind_job_cleanup()
then enters its if (op->reg) branch and calls nouveau_uvma_region_remove()
and nouveau_uvma_region_put() on it, dropping the tree's sole reference
and freeing a region this job never created. The comment above the
cleanup loop documents the broken invariant: op->reg must be NULL on
submit failure.

This frees a live region on an unrelated failure, reachable single-job
when drm_gpuvm_sm_unmap_ops_create() returns -ENOMEM; if another job owns
the same region, its cleanup then removes and puts the freed region, a
use-after-free. Clear op->reg on both failure paths.

Fixes: b88baab82871 ("drm/nouveau: implement new VM_BIND uAPI")
Reported-by: Yuhao Jiang <danisjiang@gmail.com>
Assisted-by: Claude:claude-opus-5
Cc: stable@vger.kernel.org
Signed-off-by: Zhenhao Wan <whi4ed0g@gmail.com>
---
 drivers/gpu/drm/nouveau/nouveau_uvmm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/nouveau/nouveau_uvmm.c b/drivers/gpu/drm/nouveau/nouveau_uvmm.c
index 849bf42c124e..3412200b21fd 100644
--- a/drivers/gpu/drm/nouveau/nouveau_uvmm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_uvmm.c
@@ -1319,6 +1319,7 @@ nouveau_uvmm_bind_job_submit(struct nouveau_job *job,
 							   op->va.range);
 			if (!op->reg || op->reg->dirty) {
 				ret = -ENOENT;
+				op->reg = NULL;
 				goto unwind_continue;
 			}
 
@@ -1327,6 +1328,7 @@ nouveau_uvmm_bind_job_submit(struct nouveau_job *job,
 								op->va.range);
 			if (IS_ERR(op->ops)) {
 				ret = PTR_ERR(op->ops);
+				op->reg = NULL;
 				goto unwind_continue;
 			}
 

-- 
2.34.1

