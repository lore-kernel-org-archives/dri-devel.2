Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78959C5AD7B
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 16:17:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BDA7510E918;
	Mon, 10 Aug 2026 16:17:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="W2u55l+l";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E26110E0F8;
 Mon, 10 Aug 2026 16:17:48 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id E0F7540939;
 Mon, 10 Aug 2026 16:17:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BEFFBC2BCF5;
 Mon, 10 Aug 2026 16:17:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1786378667;
 bh=JLiEjUV2M/GXqGn0sCPZe30rDApH2W8yKBOjkSz2S8E=;
 h=From:Subject:Date:To:Cc:Reply-To:From;
 b=W2u55l+lju3FBknQz9IHY6d46EnAiCmMu4WwCdL4bVHNA2oJ1WZq/k8iRV0anzJ+C
 ZUJB/sc/IbMoAuqSFWfx34YaWvuzocYvfHHYVsie9Sx0ILIMNGwHojT3pT+s0WOLwH
 HxUpJAxr1piW0NBsUyq7oQvfQbnIvMK/GrDBXAbsHWEIToVftE9vO67BTd7yNpoSUq
 v9AiyVyq4byhk/RJOBEWyla4uI5sUBpz14lCkj+gddHM4mOTIx2IIIxwnFSsi0c5F1
 PfuEG/CvP13Zl4qBd9yFWUlKljuvCjNUSRJPmKrZUN0brQuv+d+EkVTa+mVRKUYKwB
 v7jqRUqMR1XwQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 96BD5C5B56A;
 Mon, 10 Aug 2026 16:17:47 +0000 (UTC)
From: Junrui Luo via B4 Relay <devnull+moonafterrain.outlook.com@kernel.org>
Subject: [PATCH 0/5] drm/amdgpu: five independent fixes in the KMS, userq,
 UVD and CS paths
Date: Tue, 11 Aug 2026 00:13:09 +0800
Message-Id: <20260811-amdgpu-fixes-v1-0-4954a417b8ff@outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJX4eWoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDC0MD3cTclPSCUt20zIrUYt0ks8QkQwNTy0QDYxMloJaColSwBFBHdGx
 tLQCXaaHtXgAAAA==
X-Change-ID: 20260810-amdgpu-fixes-b6ab1059a034
To: Alex Deucher <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Sumit Semwal <sumit.semwal@linaro.org>, Junwei Zhang <Jerry.Zhang@amd.com>, 
 =?utf-8?q?Nicolai_H=C3=A4hnle?= <nicolai.haehnle@amd.com>, 
 Prike Liang <Prike.Liang@amd.com>, Arvind Yadav <arvind.yadav@amd.com>, 
 Shashank Sharma <shashank.sharma@amd.com>, Leo Liu <leo.liu@amd.com>, 
 Felix Kuehling <Felix.Kuehling@amd.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
 linaro-mm-sig@lists.linaro.org, Junrui Luo <moonafterrain@outlook.com>, 
 Yuhao Jiang <danisjiang@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3006;
 i=moonafterrain@outlook.com; h=from:subject:message-id;
 bh=JLiEjUV2M/GXqGn0sCPZe30rDApH2W8yKBOjkSz2S8E=;
 b=owJ4nJvAy8zAJVb4wiKgu++DA+NptSSGrMqfS45nTpH4cCXLbNGHq64yixJZ+uY62L/y3L8oV
 FVl7dwL8ec6SlkYxLgYZMUUWY4XXPpm4btFd4vPlmSYOaxMIEMYuDgFYCLMBxj+p/c9attUlxr1
 eOpJLwv1w5u+C66bFhVuxLLgSPZcD85pKQz/q90nLO+eI/jptb/gvPvVR5j6SsPuex5dNOtahYr
 zmvUTmADHzk6K
X-Developer-Key: i=moonafterrain@outlook.com; a=openpgp;
 fpr=C770D2F6384DB42DB44CB46371E838508B8EF040
X-Endpoint-Received: by B4 Relay for moonafterrain@outlook.com/default with
 auth_id=909
X-Original-From: Junrui Luo <moonafterrain@outlook.com>
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
Reply-To: moonafterrain@outlook.com
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Five independent fixes; no dependency between them, they can be applied
or dropped individually.

Patch 1 frees fpriv->prt_va on the amdgpu_driver_open_kms() error path.
amdgpu_vm_fini() releases mappings but never a struct amdgpu_bo_va, so a
failure to map the CSA or the seq64 buffer leaks the bo_va and the
dma_fence stub reference it holds.  postclose_kms() already gets this
right; only the open() unwind was missing it.

Patch 2 rejects a mapping without a backing BO in
amdgpu_userq_input_va_validate().  A PRT mapping is routed through
fpriv->prt_va, whose base.bo is NULL, yet a queue_va/rptr_va/wptr_va
inside it passes validation and latches userq_va_mapped.  The next unmap
of any PRT mapping in that VM then dereferences bo_va->base.bo in
amdgpu_userq_gem_va_unmap_validate().

Patch 3 bounds the retry loop in amdgpu_userq_ensure_ev_fence().  Every
failure ahead of amdgpu_evf_mgr_rearm() leaves the restore worker giving
up with only a drm_file_err(), so the waiting thread reschedules and
flushes forever in TASK_UNINTERRUPTIBLE - unkillable and out of reach of
the OOM killer.  The eviction fence sequence number is used as the loop's
progress condition instead.

Patch 4 applies the decode arm's handle ownership test to the UVD destroy
arm.  handles[] and filp[] are per-device, and destroy clears every slot
matching the handle from the command stream without checking the owner,
so one render node client can tear down another's UVD session and leave a
stale filp behind.

Patch 5 releases the userptr HMM ranges in amdgpu_cs_parser_fini().
amdgpu_cs_parser_bos() returns with them live and only two sites free
them; every error edge in between leaks a struct amdgpu_hmm_range plus a
kvmalloc_array() of one hmm_pfn per page of the userptr mapping,
allocated GFP_KERNEL and not charged to the caller's memcg.  An IB
address with no VM mapping is enough to reach one of those edges, so it
is repeatable at will from an unprivileged fd.

Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
---
Junrui Luo (5):
      drm/amdgpu: free prt_va on the open_kms error path
      drm/amdgpu: reject PRT mappings as user queue buffer VAs
      drm/amdgpu/userq: bound the eviction fence rearm retry loop
      drm/amdgpu: enforce UVD handle ownership on destroy
      drm/amdgpu: free userptr HMM ranges on the CS error path

 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c          | 10 +++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c         |  5 +++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c       | 29 +++++++++++++++++++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h       |  4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c | 10 ++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c         | 14 ++++++++++--
 6 files changed, 65 insertions(+), 7 deletions(-)
---
base-commit: c4f76bf5e107bcda6e496f1c4060c55af091fa79
change-id: 20260810-amdgpu-fixes-b6ab1059a034

Best regards,
-- 
Junrui Luo <moonafterrain@outlook.com>


