Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5623CD4F3C
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 15:17:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F3F2110E18E;
	Wed, 20 May 2026 15:17:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DZ++54/7";
	dkim-atps=neutral
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com
 [209.85.167.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 30F9A10E18E
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 15:17:49 +0000 (UTC)
Received: by mail-lf1-f47.google.com with SMTP id
 2adb3069b0e04-5a887ebb416so6122712e87.2
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 08:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779290267; x=1779895067; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ircF4PWSycvWSmAyVL8auld82Bsa3FQOWa7WNmN+a+A=;
 b=DZ++54/7DHhSq5NGsUH9H2iJzjv+Me2uCFsdcdWKDTFIaVh7ZzoF3DSPKmoen1STym
 qD0uWcJrLfpJswAKj43MMCjH+ViEUA0WydgvBO3tBCg+xYFVrrRqwnW6uTwxILZqazIt
 VpKRTC3u4na7gocOAqbeAO9073ytMmnFp57LXmz6wUpwTA/1fDNI0hIM5ciYuX/wL94y
 ojTR67mMYjWwVcgNMSBE5afGubGGEWPiU50jJQke34iHxgV/VQsAYUjl2O8tp2GWjcPj
 Sl4b+gXALBvPj+rrZFfNrSoFUhwyVgHY3OSxl0PxMut9MURqOXcCfNLl7TparmZVFRwI
 HZCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779290267; x=1779895067;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ircF4PWSycvWSmAyVL8auld82Bsa3FQOWa7WNmN+a+A=;
 b=NQt/yt+14U0C31Ccb/nLjGd2q6AUl2LoHAikcIDSx0f9OMKDKyEPtmNV6VVSbQC2Mc
 3PoM2eU6GVAsFbB/IHHO2khN13ze62YaHabXXKirHj4wsZbjo3Kw8W0AiIo1gZriq2py
 f12q79N+090zCEy4YxGIaFuP3pQNwg3/4HbdorhS0454Z4aniOnscxTwOxkv3hVHzOLW
 Lrx05jFlkEF1s8BoRzfuHPNCIMtDxraX7fmTQ2gRBdJDSz6bnsEvLtytTi7bAlxAoOtU
 3i2PIQm34R3KtTD+ENMwsn2jyFsOj+GM3/hDvaqqhXKTS5izRSV5la26QEk6Gqe2V+R1
 n5yA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8GVsechXCrb4VkdkNd8GnHi/z95tEQKoi1NDFeU6VhlGUW6EPBKaddMpZMcqZkoAFgmii/l1H9VcM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwwzghsvP16y4XNdt2DzWKg1VDRvkgOxExkkbwiEiGUllMVA6vZ
 xUmKTcj8AGHfk7ru58WOkWlv4xXOKLGqSb6kv2+bNgmN2N9cVaDSJmr4
X-Gm-Gg: Acq92OFZAWM1gv37amj+QxBc4bAdIK3+U4Pr3afpf5VxKjKGPziygxO0XiitzhDWI9w
 Z9iymNM5FlCRy/IgKJmLKyYGD0LsuU9l9aqEP+tFDdmbBMj8fnsVwhEpKC/gAn3e/ybarkxfO9/
 Ng9B+wxn3DNFOuLSQk7tlT+KmFwFPv4n+aRAKF2nlksuDbYQ9I1pWu6pX60QgbVxTRhHD6cVRA0
 GSyMf5JgLKCudpWmIfbzEvlguYRW7Ml4vSY7AoGpWOZ3fIIAT00EM39H2dzwJvq3df2aflktu8s
 HT6VyqeqAas/9VQKHIEMjLN80/zCHzPpgCkAJ8LBJXHvLaPgaL3FGb9nMkOqEnRNM1ACxaxSZG1
 eC8mE1wu8YMaIpZjqAGudGPMmAno6a+KWOT5GRzPrH01ZfEPiRsbgN8fSU84tvlBAUCF/3arCA/
 Nv7beg+1YVjXlooSXt6F4GHsPfTbEZw+Ze
X-Received: by 2002:a05:6512:1252:b0:5a4:1672:59d0 with SMTP id
 2adb3069b0e04-5aa0e7278f0mr9211402e87.19.1779290267082; 
 Wed, 20 May 2026 08:17:47 -0700 (PDT)
Received: from localhost ([188.234.148.119]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a90f10c8b2sm5022470e87.17.2026.05.20.08.17.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 08:17:46 -0700 (PDT)
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
Subject: [PATCH v3 0/2] drm/amdgpu: fix recursive ww_mutex in devcoredump IB
 dump
Date: Wed, 20 May 2026 20:17:38 +0500
Message-ID: <20260520151741.50575-1-mikhail.v.gavrilov@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260429143743.50743-1-mikhail.v.gavrilov@gmail.com>
References: <20260429143743.50743-1-mikhail.v.gavrilov@gmail.com>
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
 
v1 fixed this with a snapshot helper that collected BO references under
the root reservation and reserved them one by one afterwards. Christian
pointed out that drm_exec already solves exactly this — lock everything
in one ww ticket — and suggested teaching amdgpu_vm_lock_by_pasid()
to take a drm_exec context. This v3 follows that approach.
 
Because amdgpu_vm_lock_by_pasid() has a second caller in the page-fault
path, the series is split so each patch builds and works on its own:
 
  1/2  Convert amdgpu_vm_lock_by_pasid() to take a drm_exec context and
       lock the root PD via amdgpu_vm_lock_pd(). Updates the existing
       caller, amdgpu_vm_handle_fault(). Pure refactor, no functional
       change to the page-fault path.
 
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
 
Changes since v2:
- Reworked along the lines Christian suggested: instead of a private
  snapshot helper and a separate drm_exec pass, amdgpu_vm_lock_by_pasid()
  now takes a drm_exec context directly (patch 1), and the devcoredump
  code locks the root PD and all IB BOs in a single ticket (patch 2).
- Dropped the amdgpu_devcoredump_ib_ref struct and the three
  collect/lock/release helpers from v2 entirely.
 
Changes since v1:
- Switched from per-IB amdgpu_bo_reserve() to drm_exec.
- Dropped the Cc: stable tag: the regression only landed in 7.1-rc1, so
  the fix reaches 7.1 via drm-fixes without a stable backport.

Mikhail Gavrilov (2):
  drm/amdgpu: convert amdgpu_vm_lock_by_pasid() to drm_exec
  drm/amdgpu: fix recursive ww_mutex acquire in
    amdgpu_devcoredump_format

 .../gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c  | 103 ++++++++++++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c        |  72 ++++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h        |   3 +-
 3 files changed, 122 insertions(+), 56 deletions(-)

-- 
2.54.0

