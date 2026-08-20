Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB2D0C5DF89
	for <dri-devel@archiver.kernel.org>; Thu, 20 Aug 2026 10:57:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2075A10EFE3;
	Thu, 20 Aug 2026 10:57:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="rHHapAKZ";
	dkim-atps=neutral
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com
 [209.85.221.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3CD7E10EFF3
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 10:57:23 +0000 (UTC)
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-47db714766aso619980f8f.0
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 03:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787223441; x=1787828241; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=h/HhSZtTG2M/MhbMK/mYTVAf7lwkJQIPzztoCbrat6E=;
 b=rHHapAKZ+9ycAx2TWkC4Hvc/FiKfINFn91Zs3+1VbSmi3x6K84e8BFiMpSxDy8bZ4Y
 UQIa1FR2avSlXVjf/iruza3KdAu39U3qCpc13Wn479kKWEDmPDvVNp2y1es/9e1YYIKb
 R91CYVVD5LV/Vn5yLj3ARJ+2Go0moJrZgeXJFh/8o/EOHqFmnnu/KL8qBsOh58riDEwr
 qPWikLG2Y/8S+0pdngOWHz4YmePXn5lQZaoUa9xue1eZZYOPgTtwaV9vmn+xgns0Ki1H
 b94oEbdeC816lfgrgmW8m74eKuz3jOB5l+Jrns25Ca5hwBq+jVk68SgYZFeW9psKUCI2
 WbhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787223441; x=1787828241;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=h/HhSZtTG2M/MhbMK/mYTVAf7lwkJQIPzztoCbrat6E=;
 b=KHMNKUrHhmdOVkkX0uwW+Mwa3zDrAUqkmZGRrY9PMDN9j4fyIwvaS5bKFncSTrSehT
 jwOtdKCNTXi5Q7TZaCHqT9KVzAcJNExFAM6IEcZRS4nZQI8O+CkKQGFn531UZys8A0jg
 Ab94OfJGmBt2N7c309sqhl1dE0DI+nKB8hu9dI43NW0Smo8AGwO1Z8ETxYK6MZxcCsIL
 9zKrp+szpThAkt+3n3jhCImoE4ZdKphoJOjoYszM+t73DuPzFJl4G1AqQ9OSv/lSE085
 /0BgUcxGViuAwH+CJ9uVhNIaukhIM670l5e9yde8jucRm0wKw+D792ckJtq+BK0fQzou
 ixkQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrUiuh4PPMFL169EETkwQ8SW3jokXx0SRXP6QHUaoHAfgsBNol0mX1HTU4l0RdboWxJBkKIIoq4/D4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YylHUezAiAJCUH1Aqokvqq31Y5VGLlUAGf8bPUI9gBGQaGtA/+t
 HmaqbEMXKzeDwBXXdTV5Do8m4CTkxQLDBaix/Ua1gBDW/YWxrIpVrSnV
X-Gm-Gg: AR+sD11N4rYfAmgOcKRQwIcFnaoXQw5pMLiBYEl9lnGx6H4GREMc+N3BeyN9chZ6DUk
 xjWQBB1/J6VecbQVTcfk/Y7O5On3byoo7gD/RprIdx0KbN11OK6lb3gykdDEFoWO1Fun9MmQDdo
 ylEurtXIImVxUum92DrTS0WNNM2wlC5SEha6hkG7zCClzY9yh50Fb/xzQKhjR/0gD6ACYeD6DdI
 yVqkllhz8GnbVgPB1874ymmCPJ+OUZMfZlp9QRz/WccCCMMUe0bmeSw6pUjAkrva5IYSFnan/on
 VcErqtWC3fvMyNp4sV2TKOenlPDA3CNahvRhu6YV1A+VTuQ6/ofJ7CqnqyjkufjUDKVtJTRk9bL
 cL26A+WgbFFZKhjqpsOHFSmUDzkv+W8Sy3wTgXWooP1SdP+wQaOphV4nq+wcAppfrGBQ5QDQwFM
 pKfqkBcBrlNg+Z0c5JDa4Dtrf8lBX8TkwLTa0/0CPG8n9pjs3xbMZstAl3nlscnRqI47sdGD5Wb
 SkQuzMEJ8Vfmltofxbsp8qRbNyFpe/Y6Q9oYJoAFvSlwPYe5Ovx6WHHZAnGpoNwyIBCWK9jCZ3G
 luGKWxGlzAeS8qf2
X-Received: by 2002:a05:600c:3487:b0:495:5d6d:9cc1 with SMTP id
 5b1f17b1804b1-499b0633f1bmr82252225e9.0.1787223441255; 
 Thu, 20 Aug 2026 03:57:21 -0700 (PDT)
Received: from horsehead.lan (p548c9e2a.dip0.t-ipconnect.de. [84.140.158.42])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499b4568a65sm13872775e9.2.2026.08.20.03.57.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 03:57:20 -0700 (PDT)
From: Denis Pisarev <pisarevden@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, christian.koenig@amd.com,
 mario.limonciello@amd.com, ionut_n2001@yahoo.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Denis Pisarev <pisarevden@gmail.com>
Subject: [RFC PATCH v2 0/1] drm/amdgpu: MMIO TLB invalidation fallback when
 KIQ is wedged after S4 resume
Date: Thu, 20 Aug 2026 12:57:15 +0200
Message-ID: <20260820105716.148732-1-pisarevden@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260819185349.29407-1-pisarevden@gmail.com>
References: <20260819185349.29407-1-pisarevden@gmail.com>
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

Hi,

v2 of this RFC, addressing the automated sashiko-bot review of v1.
The failure data and trigger isolation are unchanged from v1
(bugzilla 219492):

- S4 resume on Cezanne (gmc_v9, GFXOFF) -> KIQ TLB flush reg failures
  at 80-140/hour for 9+ hours, sched.ready true throughout; each
  failure burns the ~5 s retry window and the invalidation is dropped
- GFXOFF held off across S4: 0 errors (vs ~70-140/30 min stock);
  re-enabled 40 min after a clean resume: 0 errors in 15 min
- so the wedge forms in the S4 resume window while GFXOFF is allowed

Changes since v1 (all from the bot review, all reasonable):

1. [Critical] the runtime MMIO fallback now holds the GC block awake
   with amdgpu_gfx_off_ctrl(adev, false) across the direct register
   access - the unguarded v1 could touch power-gated registers.
   Because that call may sleep, the fallback is restricted to process
   context.
2. [High] failure counter moved from a global in amdgpu_gmc to the
   per-instance struct amdgpu_kiq - no cross-talk between XCCs.
3. [High] SR-IOV VFs never take the runtime MMIO fallback (they lack
   privileges for direct GMC invalidation register writes).
4. [Medium] gmc_v9_0_flush_gpu_tlb_mmio() (extracted helper) takes
   invalidate_lock with irqsave since the path is now
   runtime-reachable.
5. [High, pre-existing] the MES branch now propagates
   amdgpu_mes_reg_write_reg_wait()'s error instead of hardcoding
   success.
6. [Medium] threshold warning no longer claims a fallback that
   gmc_v10/v11/v12 do not implement.

Open question kept from v1: a KIQ command that timed out remains
queued in the ring; if the ring recovers late, a duplicate
(idempotent) invalidation could race a CPU MMIO flush. Input on
whether the req/ack handshake needs protection for that case is
welcome. Alternative direction also still open: fix the S4 resume
ordering itself (RLC/ME vs GFXOFF) instead of a runtime fallback -
happy to run tracing on the affected hardware.

Patch 1/1 follows.

Denis Pisarev

Denis Pisarev (1):
  drm/amdgpu: fall back to MMIO TLB invalidation when KIQ is
    unresponsive

 drivers/gpu/drm/amd/amdgpu/amdgpu.h     |   2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h |   2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c |  18 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h |   2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c   | 111 ++++++++++++++++++------
 5 files changed, 102 insertions(+), 33 deletions(-)

-- 
2.55.0

