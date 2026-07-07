Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 275F9C43458
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 09:38:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 37C2110EC10;
	Tue,  7 Jul 2026 09:38:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.b="dByC/pNr";
	dkim-atps=neutral
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com
 [209.85.221.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5488A10EC10
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 09:38:23 +0000 (UTC)
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-46ed4f66256so3580716f8f.3
 for <dri-devel@lists.freedesktop.org>; Tue, 07 Jul 2026 02:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1783417101; x=1784021901; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=/GXN7KALIdbRbK09e4URWXHozY0BPCu8Afi5h74f/sk=;
 b=dByC/pNrWS+mnVJ6M7BuUxdFRB9v+MJBeh5tF8a4rZLeOBgkq8ZPPCAk5CCyAu2WGn
 S1+xKfTJNjkbY5SJNe+Y4o27GEbOHMHI3PX386JyK7qMkusnCHi40+7mRP/0P4vjtWB4
 x25gmy5/Guh9nz0LPdRYkXNvXFV8i55rd/7XOip9JoSiS5eUTb1c5Tmz5Ojb/SyZaPRr
 6ejunm18yo/CyCJ0t/GBlKrI2oP1ETs09Oa0MDb9Yd0gW6eCWfLe8abeqlBiUgP40270
 JnMox/GyI+TsT3N7mnXFjoZ/FidqGD/Tx1YPJqfaryk0kAEJHohJ+5fwDcl5pp5/tIAC
 Msuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783417101; x=1784021901;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/GXN7KALIdbRbK09e4URWXHozY0BPCu8Afi5h74f/sk=;
 b=rLkL0qsP4Ktkfs9mUutjzL3aSP0VP+zN/PyS3nREcdBfvvyJ3iTN2NzaKjCs8tUgrr
 C5X2cBrOdxn1wVfq5oHKRAgyaG+dCYsT3swKfPU6/4qPtz/KjK6ql/y92Vjdz4X1bDtR
 4Ah94gQ3e4xbnE5QmEeRGIs/eWEHEpgRg5dBVg+502jysCTLW/ZuJbVSGthnGX19/Mod
 ii3/8hgeM47r7Z4VAJMh8/E90mBATQrQPQ8UA2JYYFhX8Y1oQn3V/2e1pm12QTQSHXGT
 66nymmQKy71qsS5Uf/BoDL/+KPU6rhKVF1uG7x5qZA5sLuX2hVqO0Uv3iSZM7XYOdzyk
 PFyg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqiSuptu57VxyzYWrcnN2c8tT+m9WsCrcnvBG4WX56aiZInoFTUV0+JetJr6y0tg8m9+/k2w1r4cdY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwjNSUO+fAlfDfhLIh6Bn8xqByk8XnSZcAPo5EEsklkRLQti8Ts
 4sjkN3R/jpkNmtMrxxBrqf7iskD9xteSpVOgq0Lm28yTE6UaLie4f942KjFDfAeQKAI=
X-Gm-Gg: AfdE7clDKza5bj0dNxJcn97fMY6FHhCFUhFN0W/gvjg6P/VrIE3TGabk2AVLhKOK8Q/
 K+/JbgzL2nOOPvUbVPlOSPjisWcBrfyfg/EGrPvlSzUCy/dnCjILBxISjN4qBXxLJ54xfNtE1uh
 Gt73hspkGnBhCC85Vsfgu3r2TN/MhjaoHJRwlgSYzuKMDCdLTDbnZkfZWZCoMMwSYgtfmYvZ8kx
 sUuPpugPDZkfZv85fr79KKAwJDkRoe7m7su1pX+bsQ3YX80gbg0Omnxi+ff5Qe522W4F7G4eMpw
 s2vU1L5KHGhgs4tGEpB4YdRsTjYmPUsjLYWjL9PecajcGyTXIVLWj/l2G883hv0U9zt4N0jbPVy
 Lp6RVziXjCZVSRpKMTaff7bZgY9ZkTWXiOkQWnVd6OMKjYt+eA6HbCyf05JjBRDEO6t6NpcrzcC
 rja/h29L1ESkXLIcdusz/zZtwrg7fTyHSc+POm
X-Received: by 2002:a05:6000:46d0:b0:475:f0d1:eb6d with SMTP id
 ffacd0b85a97d-47de666d761mr3612337f8f.58.1783417101587; 
 Tue, 07 Jul 2026 02:38:21 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47aa0f214d2sm31578816f8f.33.2026.07.07.02.38.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 02:38:21 -0700 (PDT)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org
Cc: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
 Frederic Weisbecker <frederic@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Marco Crivellari <marco.crivellari@suse.com>,
 Michal Hocko <mhocko@suse.com>, Alex Deucher <alexander.deucher@amd.com>,
 Christian Konig <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Kees Cook <kees@kernel.org>, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Ce Sun <cesun102@amd.com>, Tao Zhou <tao.zhou1@amd.com>,
 Timur Kristof <timur.kristof@gmail.com>,
 Thadeu Lima de Souza Cascardo <cascardo@igalia.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: Change system_unbound_wq with system_dfl_wq
Date: Tue,  7 Jul 2026 11:38:12 +0200
Message-ID: <20260707093812.109176-1-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.54.0
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

system_wq (per-CPU) and system_unbound_wq (unbound) are the older
workqueue name, replaced by system_{percpu|dfl}_wq.
The new workqueues have been introduced by:

  128ea9f6ccfb ("workqueue: Add system_percpu_wq and system_dfl_wq")

Usage of older workqueues will now trigger a pr_warn_once() because they are
marked as deprecated as per commit:

  64d8eae3f895 ("workqueue: Add warnings and fallback if system_{unbound}_wq is used")

So change the used workqueue with the newer, keeping the same behavior.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
index 53be764968e4..95cceed4e971 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
@@ -545,7 +545,7 @@ void amdgpu_irq_delegate(struct amdgpu_device *adev,
 			 unsigned int num_dw)
 {
 	amdgpu_ih_ring_write(adev, &adev->irq.ih_soft, entry->iv_entry, num_dw);
-	queue_work(system_unbound_wq, &adev->irq.ih_soft_work);
+	queue_work(system_dfl_wq, &adev->irq.ih_soft_work);
 }
 
 /**
-- 
2.54.0

