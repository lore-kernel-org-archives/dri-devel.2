Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEC10C5DF85
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 18:53:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 305F010E4D5;
	Wed, 19 Aug 2026 18:53:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="qVEc/0Am";
	dkim-atps=neutral
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 454C310EC65
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 18:53:55 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-4996f1ee4a4so12087385e9.2
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 11:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787165634; x=1787770434; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=LeaiBk7jtPj1JV25dNEYhySyvqZDMBq0LxTmZgiU7l8=;
 b=qVEc/0AmaRFJetyb5ehO2lsMwC14fKhHXEsescnnXQKTtm/N0Od4pPjXiHJaRt+KUu
 IsPyOZY7uImuSe569quyO+HjRiu3XMVOs8gMH1a3qcQRJXYOdyUK55Ce4ktvG28tfRB/
 /Jyb7pWG26iEKlgNNB+ecvejt/hpLynEeyG8IUX5RJwPt+tHtTMleyzXTi1ygFpX8U/T
 9mW0TJpVIx0vZVPVIfqxUtJIFWszq+bGi70AAkBg2Uiag4t3RxlpjsiPRVMEy5HFuiYO
 8dYRJfW1mq5h9PFeMYp/14gHdg+osz3v2crHfZe+zfEqW0t1lin5K2gKJa8qPDgaBX6X
 P3wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787165634; x=1787770434;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LeaiBk7jtPj1JV25dNEYhySyvqZDMBq0LxTmZgiU7l8=;
 b=UJc0Ud0Drlsvq6eb+7Yl6tzkULItaatwH3uLliUVIb/8XiXOn2rRYwdfq9wMQmZxy3
 zOt53d+2kx+O9QahieGSqXt3nrizZJCfzDiFx0D948HTGx1rWfm1pgUGP82NK6wk8C1s
 eeqSa0bbEaMlbhGL8PyLc82NAsKK3nZEjbHfljQBan+qTiBlO69ShSGK7nwrQYi2DMyv
 akIj5xao2tWqLlsR9AyQHH5HV/5oMx2mPGg5ougLnF96fuorV6ZUK3hsSsNBBnHNgQiZ
 rX7VLdZ5sQhsjQgvXZImmvH2xwt50+xAba3C4u8QcLWsOGSQ6lQKojirWZ8fXiRU+x/D
 8QgQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqZTbYGD4wNRHHF1CasFJ4IeX8wBIqhreFkzFV1+K5jKVCN3qiHcw98yfU1zRcMv7gsvJUXeDFRduI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw8hdtXQEMjLRDAuGEBnqL7Gv4tsIZtaw+qgF5ePURVEnI/cPmO
 VnAnQHUh/bZ+MX3ilJbkxYj8OhNjdZnhzd2FIO0Ylnln8oz9kAnVqolo
X-Gm-Gg: AR+sD12bFEIYNaAgtm1tuxZiEUWRKKdYobOWhGzA+O8ZJvmMCVxKiH0fCHEY2Fp79BR
 0LVCeGYJWvkr2NUEpbPxvwUCfOdXGOIoHpvf5Y3x+w7zcZgknUKf8oe9WOkuMqOKEuq8LsSsOz2
 opogKnQj2JgrBHs1CwhZbqKxl7JseZm9h6nq+Mrz4l0FXsbtl5EwbTZVpnWdi6aNowHJlyVNhy7
 mZBG6HyICYzIWB0Iw194E64ZTYII+2BIz0zbfpvZ4Wki2srbEfE7mcWcCYXkOX0SDIhlGuwfFt9
 B90wJW8KdXf9mF6XoPBcAfDzKNYng1kQwwLaJbVfpEgTKexiJvVZeGfb3wMUrquJmkr9q2xModz
 7aZjqsZcsQMGJ/i/0tMDVYMJmogrfCEDx0jk5Pfw+jarSj8oFvMGork6p53SJvZVrttINHwOBmg
 /QLPbY5ls4HiZHdrmfp+a1FXO/C166ZSTrD6uIQAgmVuKrnV0vl36v2v9V9cjHH7p0WA+/mEC0o
 nLm7+F5HXHaTBAd3so5tnCxxGvCY7ecimlPuvWbDoh0ULS2VqPUtD4/qOB0FhW/F6EozGtgI9qO
 /LgSj/Vkodw/7SVs
X-Received: by 2002:a05:600c:4ec9:b0:495:6e68:5df2 with SMTP id
 5b1f17b1804b1-499aa1e33femr110408125e9.12.1787165633486; 
 Wed, 19 Aug 2026 11:53:53 -0700 (PDT)
Received: from horsehead.lan (p548c9e2a.dip0.t-ipconnect.de. [84.140.158.42])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499aa0d6721sm104205315e9.11.2026.08.19.11.53.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 11:53:53 -0700 (PDT)
From: Denis Pisarev <pisarevden@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, christian.koenig@amd.com,
 mario.limonciello@amd.com, ionut_n2001@yahoo.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Denis Pisarev <pisarevden@gmail.com>
Subject: [RFC PATCH 0/1] drm/amdgpu: MMIO TLB invalidation fallback when KIQ
 is wedged after S4 resume
Date: Wed, 19 Aug 2026 20:53:48 +0200
Message-ID: <20260819185349.29407-1-pisarevden@gmail.com>
X-Mailer: git-send-email 2.55.0
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

This RFC follows up on bugzilla 219492 ("failed to write reg 28b4 wait
reg 28c6" after hibernation) and on the resume_gpu_stable proposal
rejected in January:

  https://lore.kernel.org/amd-gfx/20260106125929.25214-6-sunlightlinux@gmail.com/

The rejection argued that (a) kiq sched.ready is managed correctly -
set false in suspend, set true again only after ring tests pass on
resume - and (b) the proposed flag would have disabled the KIQ flush
path permanently. Both points are correct, and this RFC takes a
different route: nothing is disabled proactively; the driver reacts to
observed failures.

MEASURED FAILURE MODE (Cezanne iGPU, Ryzen 7 PRO 5850U, 7.1.8, KDE
Wayland, no ROCm):

- S4 resume -> "failed to write reg 28b4/28c6" + "1a6f4/1a706" pairs
  begin in the same second as the thaw and continue at 80-140/hour
  for 9+ hours until reboot. kiq sched.ready is true throughout (the
  ring test at resume passed).
- Two user-visible consequences: each failed flush burns the ~5 s KIQ
  retry window (desktop-wide sluggishness), and the invalidation is
  then silently dropped (stale TLBs - correctness).

TRIGGER ISOLATION (single-variable tests, one hibernate cycle each):

- stock (GFXOFF allowed across S4):    ~70-140 errors / 30 min of use
- GFXOFF held off across S4:                    0 errors (30 min)
- GFXOFF re-enabled 40 min after the clean
  resume:                                      0 errors (15 min;
  gating resumption not independently verified)

So the wedge forms in the S4 resume window while GFXOFF is allowed,
and is consistent with the existing semaphore workaround comment in
gmc_v9_0.c about losing invalidate-acknowledge state across
power-gating cycles. A boot-time amdgpu.pg_mask=0 does not even
initialize on this part (probe -ETIMEDOUT), so runtime debugfs
control was used.

THE PATCH (1/1):

- amdgpu_gmc_fw_reg_write_reg_wait() returns -ETIME on failure and
  counts consecutive failures
- gmc_v9_0_flush_gpu_tlb() uses its existing MMIO path as fallback
  when the KIQ submit fails (invalidations no longer dropped), and
  after 3 consecutive failures skips the KIQ path entirely until the
  counter resets - so wedged systems stop paying 5 s per flush
- counter resets on every success and in gmc_v9_0_hw_fini(); each
  suspend/resume cycle re-arms KIQ. No proactive disabling anywhere.
- gmc_v10/v11/v12 call sites unchanged and compile-safe (int return
  used as statement); extending the fallback to them is trivial once
  the approach is agreed.

This mirrors what the sibling PASID path already does (KIQ submit,
-ETIME on timeout, MMIO variant as fallback), applied to the per-VMID
path.

OPEN QUESTIONS:

1. Root cause in the S4 window: RLC/ME not processing KIQ invalidates
   while GFXOFF is allowed? Happy to run tracing (amdgpu.vm_debug,
   VM_INVALIDATE ack registers) on the affected hardware on request.
2. Should the latch be per-xcc-inst?
3. Should amdgpu_gmc_flush_gpu_tlb_pasid()'s KIQ branch share the
   latch?

Patch 1/1 follows. Comments very welcome - especially on whether the
failure-driven fallback is the right shape vs. fixing the S4 resume
ordering directly.

Denis Pisarev

Denis Pisarev (1):
  drm/amdgpu: fall back to MMIO TLB invalidation when KIQ is
    unresponsive

 drivers/gpu/drm/amd/amdgpu/amdgpu.h     |  2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 15 +++++++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h |  4 +++-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c   | 18 ++++++++++++++----
 4 files changed, 30 insertions(+), 9 deletions(-)

-- 
2.55.0

