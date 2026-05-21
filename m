Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 439C2CD5BAC
	for <dri-devel@archiver.kernel.org>; Thu, 21 May 2026 15:08:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5638D10F37D;
	Thu, 21 May 2026 15:08:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OSjwBA+3";
	dkim-atps=neutral
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com
 [209.85.167.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 47B0210E0CC
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 15:08:49 +0000 (UTC)
Received: by mail-lf1-f47.google.com with SMTP id
 2adb3069b0e04-5a8c94cefcdso5270824e87.0
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 08:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779376127; x=1779980927; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mR8YNzhzHv5g5ezNdxi/IR56+HrSSzrEa6IF1DOutaU=;
 b=OSjwBA+3szqkYhv7PgaHCrEWeu84xCagI4SucUvypjbLgdVDHy7Wx+gl3joSwmkvgl
 /LDyjJjlvgTl5eH+Qt2Vxf/ShOa2WTqWByljk+ixv/6g/7MjjLvwhjcho95/oh5H0cPF
 cPlDlN8rX7FSzfMhDig1TJDdh2ujjxG5Fnu8v1lLgTyn+kYHHx2zUepFTgZ7XgnTv+Xp
 ipbF68tswMxn1NBOEQOz/krfaApKZm0EKpARZDQOVeZHXSWCeHhTo9E0IcYk2lMS43sz
 khlFn4gZjbuEXBjY8I9BzccfZu1CFe6buDlj73bwFdtnRPXXYmEl0+XdUXBZpxQXh3CU
 5lpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779376127; x=1779980927;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mR8YNzhzHv5g5ezNdxi/IR56+HrSSzrEa6IF1DOutaU=;
 b=jLGCVsUPCBJKm0tmpoeCYVdfvSnc+XK8Zj+DqgbHlJZJsahig1NRQcTH+f4l1PLsnu
 LUTxdMhEO6PQF0z576x1V5LvONK2ahOEwk24GOH5oeRB5jKsbVNl/aqkIzWAaoN4VhTX
 ++A87MmUXJjuqYpIg1hyGdQL1uvImiyLwVXLUGxsHts4AP6Hybk2FyFSNM0XrWJKhACw
 1HHdaxGKG+SRq5LDB/kK4cdk2OoVBtOLgFD7MtWW6Wooc7bKKCULTnleT20fMZeEaM7M
 Tk2V6Jr2inasbw8eiRE861susYVIkecDtxKdtaLC/70khZUoJKXRWHztwZXtGsZFabiW
 xhMg==
X-Forwarded-Encrypted: i=1;
 AFNElJ86nDBVMkrnOi8+2gu4gfpIFIw5JOahHdKYgRqaV9DhBbcqTcGEOHQcuGPdscF7nogsK9tS4To3AZQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YykAsvt4MZ59LjO3v9Tu/QTFSEEenZIPTu0hAOfOE2mv+OvH6To
 qoy43W/el8SjfIUQ5JZbDxTX/sZAXmLjZLJKBQS4NVAWkTn6Uy1SmyR/
X-Gm-Gg: Acq92OFyEyALq1+wBQIgRNHZHaLVg2ysnTVrRBxC/ALr0FplZFuqpCYUcslfrog1InT
 1Ac3tYit2jY/mFKZNvyBffsiXDEj6vVOSBMsoMmmEo9y/4dsiZxnTHNVlnRqJzT3PWWBcnYCe7C
 Tu/7vpQH4D0YBInR52OVAx4RTZ3GRaoqTO3y/UGjBUSSXSVZ3k5GVMuWLjg6p/5VbmBBHH0t4Ha
 9vpN7OHfecRfyblQce8DPN8X1QUGwDPEykQqU75YELoaopOhIMrL44No90a4eOWEO6xd1Ubca6a
 pRRXTNZTg0+aJBBYqo/fje7wJct+GnVlv4eS7vEjhrra0bOvmLWA6BgrEaX7UtQaSF7vafplokd
 HBPcXKm5QTLvcZ3DIJpQS4Wk52JMi/12hGZxk6KyaR6HEcZcFNI5XJRgHwGedt5ArbNAeLEeHrD
 ktaTd74x6nvdHS5V3ynIpD4aMK6MKpFkJbPGdyMsJPabI=
X-Received: by 2002:a19:7001:0:b0:5aa:265f:acd0 with SMTP id
 2adb3069b0e04-5aa2bc90bacmr751255e87.39.1779376126773; 
 Thu, 21 May 2026 08:08:46 -0700 (PDT)
Received: from localhost ([188.234.148.119]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5aa2f120c6esm335686e87.19.2026.05.21.08.08.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 08:08:46 -0700 (PDT)
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
Subject: [PATCH v5 0/2] drm/amdgpu: fix recursive ww_mutex in devcoredump IB
 dump
Date: Thu, 21 May 2026 20:08:38 +0500
Message-ID: <20260521150841.20625-1-mikhail.v.gavrilov@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260521104335.28978-1-mikhail.v.gavrilov@gmail.com>
References: <20260521104335.28978-1-mikhail.v.gavrilov@gmail.com>
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
across repeated timeouts and the devcoredump IB dump is produced
correctly.
 
v1: https://lore.kernel.org/amd-gfx/20260429143743.50743-1-mikhail.v.gavrilov@gmail.com/
v2: https://lore.kernel.org/amd-gfx/20260519161541.19994-1-mikhail.v.gavrilov@gmail.com/
v3: https://lore.kernel.org/amd-gfx/20260520151741.50575-1-mikhail.v.gavrilov@gmail.com/
v4: https://lore.kernel.org/amd-gfx/20260521104335.28978-1-mikhail.v.gavrilov@gmail.com/
 
Changes since v4:
- Pass nr=1 to drm_exec_init() in amdgpu_vm_handle_fault(), since
  exactly one object (the root PD) is locked there (Christian).
- Picked up Christian's Reviewed-by on patch 1.
 
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

