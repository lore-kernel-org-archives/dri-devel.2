Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F682C624D4
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 07:34:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4306510F406;
	Thu,  3 Sep 2026 07:33:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HiIkbqTf";
	dkim-atps=neutral
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com
 [209.85.216.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9429A10E32A
 for <dri-devel@lists.freedesktop.org>; Wed,  2 Sep 2026 01:27:18 +0000 (UTC)
Received: by mail-pj1-f42.google.com with SMTP id
 98e67ed59e1d1-3966791a6eeso590261a91.3
 for <dri-devel@lists.freedesktop.org>; Tue, 01 Sep 2026 18:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788312438; x=1788917238; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=BrgdRCCQy4wk9/bV+rhJB1ZWew/obSOSpX6szpMZY4E=;
 b=HiIkbqTfzLFfnSz8Tf7SnChtePa11ZM25TyzXR0rkWzZzzOmtpQSPdu5IzTMTdHCtr
 ZKdmr7X5BWy0SZphwgENqzd3SHXMrGULT7tXOBzD7QtA/sqW5ZFMLZGsHupIp9RcCoUJ
 miNyqhnR1vZQ4wBAjZjnX3Sp50WPU7d5N3+K2toXse+u6+BI0bcwuO/HXLQPJmv0Yome
 U5PpcVbsfJLs0krg/RadZZ7h0bydfQ3Xx0weUZbFxVj1rk7H3EpXczcxUy4sMU218ebo
 MkdrIIOuYru1Y3U5p2Gx/sIRAsLFfBbw54EGDoO8JuEkYLuf+FbLJs7aGhKPJoQCfT1I
 QZpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788312438; x=1788917238;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BrgdRCCQy4wk9/bV+rhJB1ZWew/obSOSpX6szpMZY4E=;
 b=BQbfSkbcjRPyaCJQY3J0HUajBnJruKuBt6EvYv8ekLnsN9FELIbzKbA+EJnlCW2zP/
 H5I5ekUZKcGn9cXEAKzE5k20qD1EF1cyGWEHr0FmfOwyAvpNim4Q+1xpMA3gsYVuniUz
 DLUE3WH4AquqOvuPhYPyK7bI+Sprts55R5vlG9+5DsWkUrMb8/2qxUo06oUEnpundOMk
 hs6AimkV+c2G31vYiKBSa/+zk70wmN8LpWNUEOWVHWW90zvvWEHbURwjYbk7ibpQoTeV
 be/6sU0h6mI5jiSHhG/c5lDQGg8fpHzZ+rO9O6nSZ8b1pO4oNkES+2m10liKW1iM4X1I
 UlsA==
X-Gm-Message-State: AFuF++mzl9QLf2aHHua/PDOw2p7TOr2AW595bjIZgFEz5z9zFMPnUsNh
 PwAYLhPtGLgqIlvlAcORj8iXZbHqdtMXmcDkgiH1aksrv3QGdPbqAl0=
X-Gm-Gg: AYBFou0+46KLNKaIrkHCD7I8Hd+J+K4Vt7y89urpcdbMrW9wmFBcfb0wnMdsDh9diBm
 1ig4moLRe86e5KQgpyNHDPRRoDLmEyddRSSCvCqSrsS2nw7nAM735UPIt7Fy0TI74iXMx7XwA19
 Gk7uptMHDwpOBsP4ltcotEnft1UWNBYhuydaVMUoBTcDLO+g2WIH4aig2pt1KUkpb+syYvCD/Or
 FgBwZHw/fIDNjay546u938gcGxY3yQHFjUM314qHyed6oyeY3HTDxDb2MV5razYmEffUzonD9CP
 BKHICzWi7rMnYSu6PR8cpumTCkSI4vRbOglH3x3vFGKKvq5xp097NQY+8qFxihP7UDulMCw9XdW
 2erToRBiXpAUqPBzoxtpLl4zyRThXq5lATznBtEc7dgIwB3xCgDiZ/UlEs6P4QlFrNGpFvgZbWI
 CBdNeaIaxvpBQLdMLQcgD/arS3vrnvMep12lD0v65yrRwbUk7CE6UPl1A9r5QQE8OLzbtfj+dRo
 VFrVRItfhucxHVgXv39T2Ng4/0=
X-Received: by 2002:a17:90b:4c52:b0:38e:6aa7:68ad with SMTP id
 98e67ed59e1d1-39aedf7c6aemr1567465a91.5.1788312437952; 
 Tue, 01 Sep 2026 18:27:17 -0700 (PDT)
Received: from MalHyuk.localdomain ([211.201.32.99])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39ae0f2a315sm2443563a91.8.2026.09.01.18.27.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 18:27:17 -0700 (PDT)
From: "Jonghyuk Kim(MalHyuk)" <malhyuk97@gmail.com>
To: Min Ma <mamin506@gmail.com>, Lizhi Hou <lizhi.hou@amd.com>,
 Oded Gabbay <ogabbay@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: [PATCH] accel/amdxdna: RCU-free the scheduler-containing hwctx private
Date: Wed,  2 Sep 2026 10:27:12 +0900
Message-ID: <20260902012712.880520-1-malhyuk97@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 03 Sep 2026 07:33:13 +0000
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

struct amdxdna_hwctx_priv embeds a struct drm_gpu_scheduler (priv->sched).
aie2_hwctx_fini() calls drm_sched_fini(&priv->sched) and then frees the whole
object with plain kfree(hwctx->priv).

Every drm_sched_fence produced by that scheduler stores fence->sched =
&priv->sched, and drm_sched_fence_get_timeline_name() returns
fence->sched->name.  The scheduler fence ops keep a .release callback, so the
fence is not ops-detached on signalling: a finished fence that userspace still
holds (exported via drm_syncobj / sync_file) keeps pointing at priv->sched
after the hwctx is torn down.  A later get_timeline_name() -- reachable
unprivileged through SYNC_IOC_FILE_INFO on the exported sync_file -- then
dereferences priv->sched->name in freed slab memory (KASAN
slab-use-after-free read).

This is the amdxdna instance of the dma-fence lifetime contract: the exporter
must keep the driver data backing a fence alive for an RCU grace period after
the fence is signalled, so a concurrent rcu_read_lock'd dma_fence_timeline_name()
cannot observe freed memory.  aie2_hwctx_fini() already waits for all submitted
jobs to complete/cancel, so the fences are signalled by teardown time; only the
teardown race window remains, which an RCU-delayed free closes.

Free the scheduler-containing private with kfree_rcu() instead of kfree().  The
init-failure unwind keeps plain kfree(): no job has been submitted there, so no
drm_sched_fence has been exported.

Fixes: be462c97b7df ("accel/amdxdna: Add hardware context")
Cc: stable@vger.kernel.org
Signed-off-by: Jonghyuk Kim(MalHyuk) <malhyuk97@gmail.com>
---
 drivers/accel/amdxdna/aie2_ctx.c | 2 +-
 drivers/accel/amdxdna/aie2_pci.h | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/accel/amdxdna/aie2_ctx.c b/drivers/accel/amdxdna/aie2_ctx.c
index 4b3a62aa8798..26bd6e001792 100644
--- a/drivers/accel/amdxdna/aie2_ctx.c
+++ b/drivers/accel/amdxdna/aie2_ctx.c
@@ -842,7 +842,7 @@ void aie2_hwctx_fini(struct amdxdna_hwctx *hwctx)
 
 	mutex_destroy(&hwctx->priv->io_lock);
 	kfree(hwctx->col_list);
-	kfree(hwctx->priv);
+	kfree_rcu(hwctx->priv, rcu);
 	kfree(hwctx->cus);
 }
 
diff --git a/drivers/accel/amdxdna/aie2_pci.h b/drivers/accel/amdxdna/aie2_pci.h
index ea1dac106400..e08b8f64328c 100644
--- a/drivers/accel/amdxdna/aie2_pci.h
+++ b/drivers/accel/amdxdna/aie2_pci.h
@@ -107,6 +107,8 @@ struct amdxdna_hwctx_priv {
 	struct amdxdna_gem_obj		*heap;
 	void				*mbox_chann;
 
+	struct rcu_head			rcu;
+
 	struct drm_gpu_scheduler	sched;
 	struct drm_sched_entity		entity;
 
