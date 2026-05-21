Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06F31CD5BA4
	for <dri-devel@archiver.kernel.org>; Thu, 21 May 2026 10:43:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F05B10F2D8;
	Thu, 21 May 2026 10:43:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IbcXeYRy";
	dkim-atps=neutral
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com
 [209.85.208.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8343A10E17E
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 10:43:43 +0000 (UTC)
Received: by mail-lj1-f169.google.com with SMTP id
 38308e7fff4ca-39380e79936so63205001fa.2
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 03:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779360222; x=1779965022; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IotSskqgPt1trYIpm3eRWveVqEambqTQS5bkqN0X6AA=;
 b=IbcXeYRywC8HIe3iXinxU3/sellpxOl/ZB+L/Fng3kfNA9blglCfikxIi5hpr/umL7
 XYqc204IydXlFlh4mVuW+U+XCwpH8d9ImgiIzLp8S5yGgt57FrdL0NsLgzr/iJlM9lbq
 YBVAnPDIbHaVq/ht4l1mOQZsv0LsI3bMU4QkF3Fcv5Uzk4SFGYszJ9jadc9NryVZgszn
 MMHL0B04L6+j37aBzy3bWSdC0mV15dZCmJLmjnFbw3vdiuh+6088nfzvyJeZj1CWefsS
 /AMZl7pPNajGVkshcOZmt9Di2gAxcYRdbTiMkFjC9RrDObsHJF3zq3vRNi4p6wnJ7UWt
 YECA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779360222; x=1779965022;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=IotSskqgPt1trYIpm3eRWveVqEambqTQS5bkqN0X6AA=;
 b=ak4kaoO2J3xHJ9PgQVeyudsOT8XJfkENhCrAfT4wn4vqPr8JUiDGRWcxcXzT0Satf9
 LQlch1uVwVbZbZhrL9bZnvLXo0V+gSpm3kqtoSYTOmb9Iu6BAS9Sb/qW0FBCJ3fBQMld
 I9SrRETxd2FSnjo1BvbfYOZPBaM58ojr6sCbXKaq8mcvHqqj0mT8moHs/6FkqLoXt9JF
 UklN1s7b2brybE7mfNva69cNsCSJdtBYjwnHF7UGgLQQhfsEaMX7eqHGh2i+M2b7Fioq
 iKZuGA0sOm5WIgwkiY7jEKR+dTrfYkQvkdRU9hB3Z18VGbf4DDUsc34at/Q3IeJCPU4E
 TXKg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8P5KoC/LZDFU4Zcwzt2xYTQ0t+GICcwys/JjVkax25h46evnMxaQkXrvOIBHxwN3zMPQRMB7q35uU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwERpvQ4AMAd4MIttUI9obCE59j/OjjsDpmVP9z+QiP6O+Q8vmg
 DGxCJotWLAWovBQLxXPZcCNjVYXwkKVMODhewEAKsO5zYz4POw9nN6lb
X-Gm-Gg: Acq92OEM3vgCTX1C4k55IVqVqSZVM6j6Qi84W9crC2Atm7h0UKMMT918waxHSnR+/m0
 5shZIx84moPDMA2+7BdUE1tsUyB+G8CVA5yUTV3pwFYW8Z7J8HpqphPwC++2Z7gyMpDCk1ZpqSp
 NFDDiBaZAm/c+yF8bdu2PalxiLe203JY7/EWOfIEQqnR62/GfNT8dJC5MlRzvWfQKxmlRDEVzTY
 pmAnG/io2vZura2MFq9dAH5K3+an4ztx2estcxOjMRM1eXgxtxqjeBaWSaoa3wxxO0Dc14LOPlZ
 cFW2Sn4T0sL87kfFxDvjHLj3Peq+KjRIUf4ppGu72io7Qi0JQ9l8c3hB/+fR5XGV5HpPnIlJI2E
 pXGRAxvEtdsGUModa9o6y/ISmf2Cn2qBzqRMuKLRbSCaq2q7mewEIc3w7rPJvYb43tsOUoXVY10
 VVmscWLy7I+ZCzGQlV8kx1pvTS6btiamraluKaj2YvhhUR
X-Received: by 2002:a2e:be89:0:b0:394:2b8a:2348 with SMTP id
 38308e7fff4ca-395ca644e5amr9678271fa.20.1779360221305; 
 Thu, 21 May 2026 03:43:41 -0700 (PDT)
Received: from localhost ([188.234.148.119]) by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-395d0b49073sm1595611fa.31.2026.05.21.03.43.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 03:43:40 -0700 (PDT)
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
To: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Sumit Semwal <sumit.semwal@linaro.org>, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org,
 Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Subject: [PATCH v4 0/2] drm/amdgpu: fix recursive ww_mutex in devcoredump IB
 dump
Date: Thu, 21 May 2026 15:43:31 +0500
Message-ID: <20260521104335.28978-1-mikhail.v.gavrilov@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520151741.50575-1-mikhail.v.gavrilov@gmail.com>
References: <20260520151741.50575-1-mikhail.v.gavrilov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

This series fixes a lockdep "possible recursive locking" splat in
amdgpu_devcoredump_format() that fires on every GPU timeout once a job
with a PASID context is involved. With amdgpu.gpu_recovery=0 the timeout
handler refires every ~2 s, so the splat repeats until it drowns the
kernel ring buffer. It is also a real self-deadlock for IB BOs that
share their dma_resv with the root PD (the always-valid case).
 
The root cause: amdgpu_devcoredump_format() holds the VM root PD's
reservation and then reserves each IB BO on top of it, nesting two
reservation_ww_class_mutex acquires without a ww_acquire_ctx.
 
The fix teaches amdgpu_vm_lock_by_pasid() to lock the root PD in a
drm_exec context, so the devcoredump path can lock the root PD and all
the IB BOs together in one ww ticket. Because amdgpu_vm_lock_by_pasid()
has a second caller in the page-fault path, the series is split so each
patch builds and works on its own:
 
  1/2  Convert amdgpu_vm_lock_by_pasid() to take a drm_exec context and
       lock the root PD with drm_exec_lock_obj(). The drm_exec context
       holds the root BO reference, so the root output parameter is
       dropped. Updates the existing caller, amdgpu_vm_handle_fault().
       Pure refactor, no functional change to the page-fault path.
 
  2/2  Use the new signature in amdgpu_devcoredump_format(): lock the
       root PD and every IB BO together in one drm_exec ticket. The
       per-IB amdgpu_bo_reserve() nesting is gone, along with a BO
       refcount leak on the old reserve-failure path. This is the
       actual bug fix and carries the Fixes: tag.
 
Tested on Linux 7.1-rc4 + this series, Radeon RX 7900 XTX (gfx1100),
KASAN + PROVE_LOCKING enabled, using a small libdrm_amdgpu reproducer
that submits a GFX IB chained at GPU VA 0 and waits for the hang. Before
the series the splat fires on every TDR; after it the dmesg is clean
across repeated timeouts and the devcoredump output is unchanged.
 
v1: https://lore.kernel.org/amd-gfx/20260429143743.50743-1-mikhail.v.gavrilov@gmail.com/
v2: https://lore.kernel.org/amd-gfx/20260519161541.19994-1-mikhail.v.gavrilov@gmail.com/
v3: https://lore.kernel.org/amd-gfx/20260520151741.50575-1-mikhail.v.gavrilov@gmail.com/
 
Changes since v3:
- Lock the root PD with drm_exec_lock_obj() instead of
  amdgpu_vm_lock_pd(): the latter dereferences the VM pointer, which is
  not yet re-validated at that point (Christian).
- Drop the root output parameter of amdgpu_vm_lock_by_pasid() entirely;
  the drm_exec context already holds a reference on the locked root BO,
  so the extra reference and the parameter are unnecessary (Christian).
- Unlock the root BO with drm_exec_unlock_obj() on the VM-recheck-failed
  path (Christian).
- amdgpu_vm_handle_fault() and amdgpu_devcoredump_format() updated for
  the simplified signature; both lose their root variable.
- Drops the v3 kernel-doc "*root" reference, which also resolves the
  docutils "Inline emphasis start-string without end-string" warning
  the kernel test robot reported against v3.
 
Changes since v2:
- Reworked along the lines Christian suggested: amdgpu_vm_lock_by_pasid()
  takes a drm_exec context directly (patch 1), and the devcoredump code
  locks the root PD and all IB BOs in a single ticket (patch 2). The
  amdgpu_devcoredump_ib_ref struct and the three collect/lock/release
  helpers from v2 are gone.
 
Changes since v1:
- Switched from per-IB amdgpu_bo_reserve() to drm_exec.
- Dropped the Cc: stable tag: the regression only landed in 7.1-rc1, so
  the fix reaches 7.1 via drm-fixes without a stable backport.

Mikhail Gavrilov (2):
  drm/amdgpu: convert amdgpu_vm_lock_by_pasid() to drm_exec
  drm/amdgpu: fix recursive ww_mutex acquire in
    amdgpu_devcoredump_format

 .../gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c  | 105 ++++++++++++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c        |  91 +++++++++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h        |   2 +-
 3 files changed, 129 insertions(+), 69 deletions(-)

-- 
2.54.0

