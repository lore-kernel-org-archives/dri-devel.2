Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D57ACA9EBB
	for <dri-devel@archiver.kernel.org>; Sat, 10 Oct 2026 03:02:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8270310EB85;
	Sat, 10 Oct 2026 03:02:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cztzEjaC";
	dkim-atps=neutral
Received: from mail-oo2-f11.google.com (mail-oo2-f11.google.com
 [74.125.231.139])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B36B410EB87
 for <dri-devel@lists.freedesktop.org>; Sat, 10 Oct 2026 03:02:42 +0000 (UTC)
Received: by mail-oo2-f11.google.com with SMTP id
 46e09a7af769-826f42e479dso247201a34.1
 for <dri-devel@lists.freedesktop.org>; Fri, 09 Oct 2026 20:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791601361; x=1792206161; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CYILw19ZFp1ITRTCjnSJ7SyTvlCLRVtxvPc/6sA5wsc=;
 b=cztzEjaCh0s6Qm0Nu0s5nIdO5K++lWipKDMLXoTwFRyks5nesteteDblDOk47dCe/J
 pC0v/UQyYe8p7BXkJmUsl2U47NTadWcwlhAa+8rhyDtYvS9WRY/ngE8mxmQt0DHuf9E8
 1VsoXX/kdo39ltLk82jwL2mkl6U/VFY9tqczHsclVRYq1UprUbjnsCn4iGKfX4zTgsQ9
 XN8w8GxtANw8L1iHII5WKLc+u6Mi7a9StoI+04GcXdBcwwx3Y3WJd3lUt7oLTV4YpmNl
 6HWX8q1Dk1mmr73xNPeFpbLDRiO4Ddc8Ijq7xkld7jYtrEw9cQ0KnwWwXOgRF9XjMF2M
 kF4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791601361; x=1792206161;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=CYILw19ZFp1ITRTCjnSJ7SyTvlCLRVtxvPc/6sA5wsc=;
 b=QPuVhjuf4Pwi0c7e0tgjGUeExlDqCHcM+dzhVD5XmLRQWaZDl535+5dINgkZWAyRWa
 Tw1bd7C1/2bKKP6TTj+4bPSmFjSnbx262jfgVawrAjQs9k3kSuHp1w0cRdS0AwBAmcYV
 hXjcQszC/BoxWAD6qHkVUWu7GhfBN5pGPtBf2nkRZMO4KXJZMKOnMMdHw6HXjV8JENWk
 g9B6X/tWdYsBBpJhylODL27vUn+eUvK5ZzthMGoswyeVFQammDCOiJ5pAsY1TbZs9Q0S
 hsYt7ZCeFH7lXwQPfz7D3hXPkDNBcRoonBaAjKZxU740y5c/Tqbzpr5NxzkpO7XKpyed
 xy4g==
X-Forwarded-Encrypted: i=1;
 AKwUvBw6ke3wgN2ykPComwrt+Ed2EqOVivB28D0iTAEkrJim8zghCD3Lxz1JAJW9BpvKHIHLjRZmWwC15cw=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYK8Rtgb9Qw3ZCGqM/NGztyltsdWPFZbeUMGNMlTck6ZRQk38wyZ
 Ntd7uF7tnAbKHiHmgSc+/3aIjnD6vjgXxjfm8x9U0pcCa653pHpay9cD
X-Gm-Gg: AYBFou3DEHDerOIY0a12rpRBs3mWZ4DmBlGW0A/EJzI6Ai6Bap12yOFPqDeNzyPfXSC
 mn3rYYI2/UbyKF/TP4EoKddOna+jpp7XLOkHHaURw442g3BLQw45BiKZpXOGjFltnSJ7Boogzm6
 NnwFg5TkiCE5R45XKTYG/ekwwa1AjLaHSLvBqmMwpZyoMa+mW80ZHBDOwqp+tA7KCZw2IzxJwnW
 dO9g5cFKgEtfMKze2gIMWJv2kKdliIvGSkwO2MJ1PyFFumx0Y5Oi2H9dWgFdnHzp1pJzq9HzKTr
 OdsMCQuNJiBlIZgW3HcQ8IsSg/ocF0yVuPCciBaqHptc+/WQYAw3r5M80yqE+9lWc+ng96iAPhN
 0MBFa9WzmG/wBldh5l/nNGC86dr/PV/UFvA0e0yukYrsu5axABpcxhvo5NJCCKO8tMkYEy4B8fk
 YqmYe9THWhEjiswgGDIprUMGitc0tUD6OflNwPrQ4GodNABTpfiyYNsd8I2PcG+keoEMFmWYiFS
 NnOD4f81nO6EPf14q7MVp4hDXp6ei8tw/wB0so=
X-Received: by 2002:a05:6820:f011:b0:6d9:7de7:e48c with SMTP id
 006d021491bc7-6ef0f1b6214mr2982823eaf.51.1791601361586; 
 Fri, 09 Oct 2026 20:02:41 -0700 (PDT)
Received: from localhost.localdomain ([180.101.244.69])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-83039076d72sm3562310a34.12.2026.10.09.20.02.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Oct 2026 20:02:40 -0700 (PDT)
From: Henry Martin <bsdhenrymartin@gmail.com>
To: Felix Kuehling <Felix.Kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Harry Wentland <harry.wentland@amd.com>, Alex Hung <alex.hung@amd.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Henry Martin <bsdhenrymartin@gmail.com>,
 stable@vger.kernel.org
Subject: [PATCH v2] amdkfd: fix doorbell allocation race creating duplicate
 allocations
Date: Sat, 10 Oct 2026 11:02:30 +0800
Message-ID: <20261010030230.1764682-1-bsdhenrymartin@gmail.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <9e519955-e63b-469d-8acf-268b9802e0b6@amd.com>
References: <9e519955-e63b-469d-8acf-268b9802e0b6@amd.com>
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

The check-and-allocate sequence on pdd->qpd.proc_doorbells is
lockless at every call site of kfd_alloc_process_doorbells():
kfd_get_process_doorbells() (mmap of /dev/kfd),
kfd_ioctl_create_queue() and the CRIU restore path each test the
pointer under different locking (or none), so two racing threads can
both observe NULL and each allocate a doorbell BO and bitmap,
orphaning one allocation and handing the two mappings different
backing pages.

Move the serialization into kfd_alloc_process_doorbells() itself,
using a new per-process-device mutex so all three call sites are
covered regardless of their own locking.  The device-global
kfd->doorbell_mutex is not suitable here: it is acquired under
dqm->lock on the kernel-doorbell path (start_cpsch() -> pm_init() ->
kq_initialize() -> kfd_get_kernel_doorbell()), so holding it across
the sleeping allocations above would create a lock-ordering
inversion with dqm->lock via TTM eviction, and it would also
serialize doorbell setup of unrelated processes behind a
device-wide lock for per-process state.

This issue was discovered by Tencent CodeBuddy Security.

Cc: stable@vger.kernel.org
Fixes: 2105a15a2046 ("drm/amdgpu: use doorbell mgr for kfd process doorbells")
Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
---

v2: Use a per-process-device mutex instead of kfd->doorbell_mutex
    (avoids the dqm->lock ordering inversion and the device-wide
    serialization) and correct the Fixes tag.  Pointed out by Felix
    Kuehling.

 drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c | 15 ++++++++++++++-
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h     |  3 +++
 drivers/gpu/drm/amd/amdkfd/kfd_process.c  |  1 +
 3 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c b/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c
index fdcf7f2d1b5b4..55acadc986bee 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c
@@ -257,12 +257,21 @@ int kfd_alloc_process_doorbells(struct kfd_dev *kfd, struct kfd_process_device *
 	int r;
 	struct qcm_process_device *qpd = &pdd->qpd;
 
+	mutex_lock(&pdd->doorbell_mutex);
+
+	/* Another thread may have won the check-and-allocate race */
+	if (qpd->proc_doorbells) {
+		mutex_unlock(&pdd->doorbell_mutex);
+		return 0;
+	}
+
 	/* Allocate bitmap for dynamic doorbell allocation */
 	qpd->doorbell_bitmap = bitmap_zalloc(KFD_MAX_NUM_OF_QUEUES_PER_PROCESS,
 					     GFP_KERNEL);
 	if (!qpd->doorbell_bitmap) {
 		DRM_ERROR("Failed to allocate process doorbell bitmap\n");
-		return -ENOMEM;
+		r = -ENOMEM;
+		goto unlock;
 	}
 
 	r = init_doorbell_bitmap(&pdd->qpd, kfd);
@@ -284,11 +293,15 @@ int kfd_alloc_process_doorbells(struct kfd_dev *kfd, struct kfd_process_device *
 		DRM_ERROR("Failed to allocate process doorbells\n");
 		goto err;
 	}
+
+	mutex_unlock(&pdd->doorbell_mutex);
 	return 0;
 
 err:
 	bitmap_free(qpd->doorbell_bitmap);
 	qpd->doorbell_bitmap = NULL;
+unlock:
+	mutex_unlock(&pdd->doorbell_mutex);
 	return r;
 }
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index d8631847f0eb9..96e59133fee02 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -779,6 +779,9 @@ struct kfd_process_device {
 	/* per-process-per device QCM data structure */
 	struct qcm_process_device qpd;
 
+	/* Serializes process doorbell allocation for this device */
+	struct mutex doorbell_mutex;
+
 	/*Apertures*/
 	uint64_t lds_base;
 	uint64_t lds_limit;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 0a7c1900da959..4efe4dae79c13 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -1788,6 +1788,7 @@ struct kfd_process_device *kfd_create_process_device_data(struct kfd_node *dev,
 	pdd->dev = dev;
 	INIT_LIST_HEAD(&pdd->qpd.queues_list);
 	INIT_LIST_HEAD(&pdd->qpd.priv_queue_list);
+	mutex_init(&pdd->doorbell_mutex);
 	pdd->qpd.dqm = dev->dqm;
 	pdd->qpd.pqm = &p->pqm;
 	pdd->qpd.evicted = 0;
-- 
2.43.7
