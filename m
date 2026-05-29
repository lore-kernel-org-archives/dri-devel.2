Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B1AECD6E45
	for <dri-devel@archiver.kernel.org>; Fri, 29 May 2026 06:48:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6670810F990;
	Fri, 29 May 2026 06:48:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nVJXKwNg";
	dkim-atps=neutral
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com
 [209.85.167.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 59A2E10F990
 for <dri-devel@lists.freedesktop.org>; Fri, 29 May 2026 06:48:21 +0000 (UTC)
Received: by mail-lf1-f44.google.com with SMTP id
 2adb3069b0e04-5a8ee4b703fso12484824e87.0
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 23:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780037300; x=1780642100; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=doPRw5QapmDdqAPGgFbdNczGbZz+3rVnzTYKju4SbAA=;
 b=nVJXKwNgLEkYGbSon8RuduJfibLMASrGKUPxGSk2qpsGFTRtpHg63delRTE4QjoV8+
 q+4Eum+etnez1tHO8oxNEa7ttBLb+bD2Y0LSqlkZv+K1CF6trfmOcwdCOhgFNegWfcUI
 xMqjS1VRxjfcQ7zicAS+lZKdS8l4Mw4DoHjDCrKUPfe+2KJMV/zHdvhJ2jfrJPv+mnbV
 vopVb05dcOG5jZg4Fm5hPfZpONCjEzktmGShBfulvWFEvC8in6Dv0oh8HNXMyfsRoQ65
 CmBU7EQUvHVz8f1qNzkfAptUei5C2ZfvmdVXJB50wBmjB24ofipiO/99bH1Iz6T3/FtM
 0jdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780037300; x=1780642100;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=doPRw5QapmDdqAPGgFbdNczGbZz+3rVnzTYKju4SbAA=;
 b=aeKCQBQ6KU2JuMqg/a1efy+w/jzqLEuFVcFAXJwvfUYEkZFNnKNF9drKf1TmCqJITr
 9yGseffVM18vc34/GxyI1Z7UCt2mjtufUMmla9WR9nFbhqwmtK7BVbpRd9eDL+LSMWAb
 7mfW167YVNNq070TOoq/o8FwoSNJsBn/616XNTK0Z+rp+h3oAIHRNR5Bfuvva5xOOQLn
 MH25YqYZK71W8JwjfH/nCaduPGaY0IC1pqUWn2lo11G8KpJ1twZSlR5AtozaILfNsgIY
 9BTTUU4xkHXxvBXvBF1FEr0Uv35bQ0++IYpwl0RngGArlY/KZ4ZKUZNWI0CcgUhHK54M
 STfw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8zBCEI6CiTQxw6NWUr+bIHYD1KlVCV/I1xqZAiTh9FqQy1QKN0wLrstOvI03gQO2XUpybHbrzOHM8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwGotcRFRe9/lKspB+aOHc5EAcHe3suX1mrz4H/jp3IpvVmV3RT
 JKFXnjQmYcsss3X3uEAtBaJ3QmkomVbOpYlSSWBQN9Vz0oYgokTEh72R
X-Gm-Gg: Acq92OF0y5kMIYM6LJAu3ODYVbuZ9Itajb5IRt06nTi/JDW97ZQqycbLueztDOz6Wc3
 tOTLVnTnb1vqEeiz+fSwqu6u0MEMXgiLT11eKaObSCHjsKnQ0ZNzdz0hk6yVqK+WqQvRXsAmy6+
 IPIQ84CDy/51ZStFoMPPqV3h9uiMeccIBOmVDHdTLvmBZAbk/mCsQJEaHwfTOUy7H2d+iGwSRJ4
 SxIus3DH/sSOGFRk1m2p4ZKJG9BFUXWk9uYKZkzuwIBvGgn4vbt9iEoFsmt/cTfRlnS1JYlU+Rv
 cythXRwXYptvqLB//nl+VGh5LtnD8xY97uRNhmngpTWR6iUqqB4KZJXV3/yAwd47RLU7DN9W5cO
 d8UyTunC+UOJrXcP5mSVwLTa1yFYITnKW7hO1W6wH6ylZS7ossxeM1f73KGVRstsvM77Gb8Lz/Z
 nzSv4yJzBzDuLzfn925IqT57boSb7RNpx6tehT79incHw=
X-Received: by 2002:a05:6512:3d1c:b0:5aa:2a30:217a with SMTP id
 2adb3069b0e04-5aa594a573bmr325607e87.34.1780037299072; 
 Thu, 28 May 2026 23:48:19 -0700 (PDT)
Received: from localhost ([188.234.148.119]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5aa5b79f04dsm72147e87.83.2026.05.28.23.48.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2026 23:48:17 -0700 (PDT)
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
Subject: [PATCH v6 0/2] drm/amdgpu: fix recursive ww_mutex in devcoredump IB
 dump
Date: Fri, 29 May 2026 11:47:37 +0500
Message-ID: <20260529064740.25060-1-mikhail.v.gavrilov@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260521150841.20625-1-mikhail.v.gavrilov@gmail.com>
References: <20260521150841.20625-1-mikhail.v.gavrilov@gmail.com>
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
       (Reviewed-by Christian on v5.)
 
  2/2  Move the IB dumping into a separate helper that locks the root PD
       and every IB BO together in one drm_exec ticket. The per-IB
       amdgpu_bo_reserve() nesting is gone, along with a BO refcount
       leak on the old reserve-failure path. This is the actual bug fix
       and carries the Fixes: tag.
 
Tested on Linux 7.1-rc4 + this series, Radeon RX 7900 XTX (gfx1100),
KASAN + PROVE_LOCKING enabled, using a small libdrm_amdgpu reproducer
that submits a GFX IB chained at GPU VA 0 and waits for the hang. Before
the series the splat fires on every TDR; after it the dmesg is clean
across repeated timeouts and the devcoredump IB dump is produced
correctly.
 
v1: https://lore.kernel.org/amd-gfx/20260429143743.50743-1-mikhail.v.gavrilov@gmail.com/
v2: https://lore.kernel.org/amd-gfx/20260519161541.19994-1-mikhail.v.gavrilov@gmail.com/
v3: https://lore.kernel.org/amd-gfx/20260520151741.50575-1-mikhail.v.gavrilov@gmail.com/
v4: https://lore.kernel.org/amd-gfx/20260521104335.28978-1-mikhail.v.gavrilov@gmail.com/
v5: https://lore.kernel.org/amd-gfx/20260521150841.20625-1-mikhail.v.gavrilov@gmail.com/
 
Changes since v5 (all in patch 2, per Christian's review):
- Trim the commit message: drop the reproducer paragraph, keep the
  problem description and the solution.
- Move the IB dumping out of amdgpu_devcoredump_format() into a separate
  amdgpu_devcoredump_print_ibs() helper.
- Use goto error handling inside drm_exec_until_all_locked() instead of
  break, and drop the now-superfluous `locked` variable. drm_exec_fini()
  is called once at the end of the helper, not in the locking path.
- Patch 1 is unchanged from v5 and keeps Christian's Reviewed-by.
 
A note on one review point I couldn't fully confirm before respinning
(asked on the v5 thread [1], no reply yet): in the locking loop, when
amdgpu_vm_bo_lookup_mapping() returns no mapping for an IB, this version
treats it as non-fatal -- there is simply nothing to lock for that IB,
so the loop continues, and the content loop still emits the
"IB #N <addr>" header without a body. goto-abort is reserved for real
errors (VM not found, drm_exec_lock_obj() failure). If a missing mapping
should instead abort the whole dump, I'll change it.
 
[1] https://lore.kernel.org/amd-gfx/CABXGCsPPY3qX7Ad-a7==nmA5R7aejCTCrmWYpn-9OQQU=1eMMA@mail.gmail.com/
 
Changes since v4:
- Pass nr=1 to drm_exec_init() in amdgpu_vm_handle_fault() (Christian).
- Picked up Christian's Reviewed-by on patch 1.
 
Changes since v3:
- Lock the root PD with drm_exec_lock_obj() instead of
  amdgpu_vm_lock_pd(); drop the root output parameter; unlock with
  drm_exec_unlock_obj() on the VM-recheck-failed path (Christian).
- Resolves the docutils warning the kernel test robot reported on v3.
 
Changes since v2:
- Reworked along the lines Christian suggested: amdgpu_vm_lock_by_pasid()
  takes a drm_exec context directly (patch 1), devcoredump locks the
  root PD and all IB BOs in one ticket (patch 2). The v2 helper struct
  and the three collect/lock/release helpers are gone.
 
Changes since v1:
- Switched from per-IB amdgpu_bo_reserve() to drm_exec.
- Dropped the Cc: stable tag: the regression only landed in 7.1-rc1, so
  the fix reaches 7.1 via drm-fixes without a stable backport.

Mikhail Gavrilov (2):
  drm/amdgpu: convert amdgpu_vm_lock_by_pasid() to drm_exec
  drm/amdgpu: fix recursive ww_mutex acquire in
    amdgpu_devcoredump_format

 .../gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c  | 215 ++++++++++--------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c        |  91 +++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h        |   2 +-
 3 files changed, 184 insertions(+), 124 deletions(-)

-- 
2.54.0

