Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A99E8C5DF97
	for <dri-devel@archiver.kernel.org>; Sun, 23 Aug 2026 09:26:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C505F10E1BE;
	Sun, 23 Aug 2026 09:26:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EAoA7Sxp";
	dkim-atps=neutral
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com
 [209.85.128.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 382B510E401
 for <dri-devel@lists.freedesktop.org>; Sat, 22 Aug 2026 15:11:02 +0000 (UTC)
Received: by mail-yw1-f178.google.com with SMTP id
 00721157ae682-836cda225c1so29841337b3.2
 for <dri-devel@lists.freedesktop.org>; Sat, 22 Aug 2026 08:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787411461; x=1788016261; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tl+ydfXGpsApHyYdqtis4MbvgFxpMIFRVTomZ0enFKw=;
 b=EAoA7SxpSSGkKhYYdbhCn6Lh77naqJxmAPkMYxO8H4QdWPCFTzZbeMkS/fD/t1FSKi
 GYyrgNOMBgiEvKW8HLBlAxTptzFqw0jotJ2cLgFlONfwqUjg0F2rJp30r27Hr1Y4aw6g
 N1XyW6tuAUFwDJFyzvgLpocW7OdGXQLQmZ/3W9R6EVYnbDUKtTAcJ8nM9OpY3TnnKP3j
 IPZHi/Z9NiPdpwDGyYBPIWzekB4IqNA5Y5Rd7zX6PyKlR9TyHqES69KAHvFg9CVuXTwq
 rMk+cbAkL2hBu4CeVVL/NtBeRFr7i/QP73MoJXxevmJRh2dqfrsjF9/urEdq5SSyUQMM
 2dOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787411461; x=1788016261;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=tl+ydfXGpsApHyYdqtis4MbvgFxpMIFRVTomZ0enFKw=;
 b=VStGk6YTgvf16jIe5V1fSiGnWMwY4ZSPdufkAUVoI9n12CV7X4Ovpp0momQc/Mm0yy
 5smaUvOx4o/OlbTfzjO2hldrMJNoWMI5xdm5k+UdcHF5WElqhRAi3Qes2KyzCoZKbsIy
 m4yQggC30ig6prB7zsIJvDIG9xJYQMdMRzTMUTPb/Y1ojwIkYScrblqrDIVHdx7u/vne
 ptAuq5AotLB3yW9k9nTeVroLfC7OPUXkQxl0QN/kbL+lDRSwX3s0oVyILXXCeX+Z9avg
 /jDiNM0drTilY+CU3xvz0Tq8y1HMLQhlJR929Va37hCIRMUSkcw/25u1q1pSeTDUs/Fy
 l33w==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro7sm721FO6X3uQO1VGF/V+iyj8pKhVZATqFoTamtp9iayQ35DfFpt0v8kF67/WrvcQkQ/m1gyaDtc=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nEyuZw/59hZZCU5LZC5UzJFuGop6n+DJiaRqkDgrY9rglUT94P
 8z/8w7Ab5oCsMCXvCiNh9EbqpluEIBa4DrpB2CCJQi9YWVp9YKzHL9QI
X-Gm-Gg: AR+sD11m0+jpFg/TCWe3E60da1/iZCiu2uFiLh6aJBNpp0tUiL+K8ioFfSLxs7CJvzE
 1x16YCL8IZnNI3+m/zArSURPKM/fcEpmrE8KnOQP4wKihfO9+i4YYI0sqrTnbinJwWvKjQQpr4f
 1Ex0FTW6VKxEznikgXWhcMhaRDls7lB+WPYPnypckbcN2BEfWKGzTPWHr3ylu8UlThz8YxmDLkc
 LXB4wdtLDncSTU68/qDcYZWag7XbV1cGO089/PCXSRPXWWXhlZzDGQN5e8Ei33aT4R3q20QOCxx
 BihN+tMUscH/48kdhPUFL7+bhcLxQ/IXot1XBY37w2Ft3xqMI5ZlpKzV0zIyTUub7TojAtOUmBR
 Et8d+7mclA6PES46h6C5/rYcCfY8taMR9fIMG/FDB340H7CuQz10Uw0ZWiBBUYJ2SNsmjykJPp4
 2cFOy/BLyun8Z5EHf2DT6v1pGIqsH1hMAAihIStjT7n42y9MrQFc+irYdXCn++M45S5RBfU2qI8
 VVIfg1aktXqtpeg04X0vAN58Ve9dBGAC5z2+CONSiPOjohUKvqjl+eNRwgT9FOt2ptkBSzG3Oce
 wdQ=
X-Received: by 2002:a05:690c:7001:b0:82e:3aea:fa5d with SMTP id
 00721157ae682-849f245444cmr61904547b3.15.1787411460944; 
 Sat, 22 Aug 2026 08:11:00 -0700 (PDT)
Received: from DigitalOasis.tail29fcbc.ts.net
 (104-182-93-176.lightspeed.brhmal.sbcglobal.net. [104.182.93.176])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-84cac01026csm11076757b3.39.2026.08.22.08.11.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 22 Aug 2026 08:11:00 -0700 (PDT)
From: Bocaj Gnuoy <bocajgnuoy@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: Felix.Kuehling@amd.com, alexander.deucher@amd.com,
 christian.koenig@amd.com, airlied@gmail.com, simona@ffwll.ch,
 oded.gabbay@gmail.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Bocaj Gnuoy <bocajgnuoy@gmail.com>
Subject: Re: [PATCH v2] drm/amdkfd: don't leak BOs when process teardown can't
 unmap them
Date: Sat, 22 Aug 2026 10:10:46 -0500
Message-ID: <20260822151046.966976-1-bocajgnuoy@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260822144402.929677-1-bocajgnuoy@gmail.com>
References: <20260822144402.929677-1-bocajgnuoy@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 23 Aug 2026 09:26:47 +0000
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

Correcting a factual error in my own changelog before anyone spends
review time on it.

The changelog states:

  "Note the free path itself does not allocate - it reserves the BO,
   detaches the attachments and drops the references - so it can
   complete even when the unmap could not."

The first clause is wrong. Immediately after the -EBUSY bypass,
amdgpu_amdkfd_gpuvm_free_memory_of_gpu() calls:

	ret = reserve_bo_and_cond_vms(mem, NULL, BO_VM_ALL, &ctx);
	if (unlikely(ret))
		return ret;

reserve_bo_and_cond_vms() uses drm_exec_prepare_obj(), and drm_exec
allocates its object array with kvmalloc_array()/kvrealloc(GFP_KERNEL)
and returns -ENOMEM on failure; drm_exec_prepare_obj() also calls
dma_resv_reserve_fences(). So the free path can allocate, and can fail
with -ENOMEM.

Bounded consequence
-------------------

The forced free can therefore still fail, after which
kfd_process_device_free_bos() drops the idr handle regardless - the
same ownership violation the patch addresses, one level deeper.

This is not detectable through the teardown WARNs. The BO is removed
from process_info's lists before the reservation is attempted:

	/* Make sure restore workers don't access the BO any more */
	mutex_lock(&process_info->lock);
	if (!list_empty(&mem->validate_list))
		list_del_init(&mem->validate_list);
	mutex_unlock(&process_info->lock);

	ret = reserve_bo_and_cond_vms(mem, NULL, BO_VM_ALL, &ctx);
	if (unlikely(ret))
		return ret;

That ordering is deliberate, so reordering it is not a fix. The
consequence is that if the reservation fails, the attachments are
never detached and the free does not complete, but the lists that
amdgpu_amdkfd_gpuvm_destroy_cb() checks are already empty. The stale
lifetime condition implicated in the deadlock can therefore survive
without the WARNs firing. I have not driven that particular residual
failure through the eviction path and observed the deadlock, so I am
describing a reachable state, not a reproduced one.

Scope of the change
-------------------

The underlying violation is not introduced by this patch. Upstream
today can already reach it:

  mapped_to_gpu_memory == 0
    -> delist
    -> reservation fails
    -> free returns error
    -> teardown discards the handle

This patch additionally permits:

  mapped_to_gpu_memory > 0 after a failed unmap
    -> bypass -EBUSY
    -> delist
    -> reservation fails
    -> free returns error
    -> teardown discards the handle

So it widens the set of states that can reach the violation rather
than creating it. That is not offered as a justification, only as
scope.

What the testing does and does not show
---------------------------------------

The pr_err() this patch adds to kfd_process_device_free_bos() is the
only instrumentation in the patch that directly observes a
post-delisting free failure. It did not fire in any run, including
one with 1904 "failed to validate PT BOs" and 35 forced frees.

That is consistent with the drm_exec allocations being far smaller
than the page-table validation that failed, and therefore satisfiable
under the same pressure. It is a probability argument, not an
invariant.

The accurate evidentiary statement is: the fix reliably completed in
the tested pressure regime, but the implementation does not provide an
invariant guaranteeing teardown completion under arbitrary allocation
failure.

What this does and does not change
----------------------------------

The reproduced failure is unaffected: the unmap fails in
vm_validate_pt_pd_bos(), mapped_to_gpu_memory stays non-zero, the free
returns -EBUSY before list_del_init(&mem->validate_list), and the BO
is stranded. This patch removes that, and in every observed forced
teardown the cleanup completed and the machine-killing relaunch
stopped happening.

What the error invalidates is the completeness claim, not the safety
argument for forcing. Bypassing -EBUSY on irreversible teardown and
detaching the bo_vas when the reservation succeeds is still supported
by the evidence. What I can no longer claim is that the cleanup is
guaranteed to succeed merely because the failing page-table operation
was skipped.

v3 will correct the changelog and state this as an explicit
limitation. If the residual allocation failure should be repaired
rather than documented, there appear to be several possible
directions with different locking and lifetime implications - a
retry, a reservation path that does not allocate, or deferring
ownership so a later pass can free the BO, among others. I would
rather have maintainer guidance on which is wanted than guess at a
lifetime-ownership decision.

Thanks,
Bocaj
