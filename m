Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49730C4450A
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 08:19:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C8D310F1EF;
	Thu, 16 Jul 2026 08:19:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="aO16qDtT";
	dkim-atps=neutral
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com
 [209.85.210.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 25EF010E0DA
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Jul 2026 22:21:24 +0000 (UTC)
Received: by mail-pf1-f169.google.com with SMTP id
 d2e1a72fcca58-8487b7b3fc7so2269419b3a.0
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Jul 2026 15:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784067684; x=1784672484; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:user-agent
 :message-id:date:cc:to:from:subject:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Vv0t/+7auxcbtGWpvakmJ0ritrqSQFOQmC0jKQCZU2I=;
 b=aO16qDtT8i/HS2KXG0ZlqTI7Q/ewa2MiOpfqFMmxW6PIa/7cMpkIIsI28aKvDiaDi1
 vRnc7jpMctCQRhbqw+WYkd/UGtir6XS8d1AEVpccTUAgCMblTKORpGjJCPrp58H0tQro
 K0NMPgeabTOnsPIgmZW1OEvDa9yhME7S3AmKbjYxFC9RpmL7zjQE7AoWpp/J62rEymtx
 8wqzxeqDF8O2UCHxC56v2BVJ019sQIsUan1KmOEhwtzodurIY5/aN+KKro+aHV02bZ24
 qWHBSkGoGrMREBlZ1cvnLJL4C0FOmSXFHsXYt8pb4ecwsV6duiFdWIw6fyG072xYggFb
 Bjlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784067684; x=1784672484;
 h=content-transfer-encoding:content-type:mime-version:user-agent
 :message-id:date:cc:to:from:subject:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Vv0t/+7auxcbtGWpvakmJ0ritrqSQFOQmC0jKQCZU2I=;
 b=N57Fev8fmCQbj3Oxd2ck/r6fUvVM75Eo4Ty1Bt5QiiH4wrfK5xQMwQJjtOs2Yoib77
 ppqvXzln/9rbpcXPWZ+yQ7L118pDnHg0yKCJP6+SSEqF6/ZVuw25laWjx+pC7cF1mT5p
 48SwL3WZhtQRnL2sJmkcHWuksgbZk2An0zvNAnw9kSpKVHYJefmBY7BT40AmqhDKFlaO
 JelmTE11fEKO5N2VeGfMkX80mMVLee0eRT6objovQub9ywuiV+QTosU6NJoqwGBm8I0p
 NEi9U4mFvLZsmJc9dr1J6GFd0jif7uS8N/xcqcmPsdPrsAjN74AzA7EBVwguzPHhQ1oz
 Wc2g==
X-Gm-Message-State: AOJu0YzVYGvR22x8RktHfs0LbsRFeSwPC7WDVDa8N8ReTO0a+VntB6js
 3rWDQgRcJGAPpAIurWhcoyrng8be4ZFVSJzLQU1/lwDVEbyhzI1OE6wr
X-Gm-Gg: AfdE7ckQ1+S2FONJtXZ1MI2oFVQ+HjdD4lOfZxqUKT/mXNUUFLfConb03eJWcKBKhar
 W8Cm2qwyspxdlWF9vo5tOVidmMrhp/2G4VCy1A8jMWafznlTRZzpdzqDVu9lyI9hycd7g/KNolT
 8ofSbb2bMQsMbmViJhJGGzQC+iWdJiGL1IGMRbR47Ka9ZvE+Wy2HPszcZYbAE/fb4pR6LPUOsMm
 XzJOqZKLuMoOCJhPHqFv93E/CwRsxHBBqCn6CjORddzS3f9PCVRRTLbyR20LooVGepmbofuqnfb
 IezcEj60I8Np4AYeWHgVWx4ckJHkAKeEHck3xSbpE8a6fQbDNx/HTWtZjsmq9hktwEllDI5Yp5A
 xzNaS/Ax9dSnzHStmE9T3Azn5YMxN5TmYEXaqwB2HciR+xGbe2RbE8VPq4dpxjr45Mc5l9i9UxR
 iEonyI1Gdp5mEEAGWWHT6i/tEqv8xj37ux7Nt2q9B4IHbgO4EyKMJxqDtamWU=
X-Received: by 2002:a05:6a00:b4c:b0:848:6895:b763 with SMTP id
 d2e1a72fcca58-84a6735881cmr262012b3a.40.1784067683556; 
 Tue, 14 Jul 2026 15:21:23 -0700 (PDT)
Received: from [192.168.0.160] (c-98-225-44-182.hsd1.wa.comcast.net.
 [98.225.44.182]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-ca5b3643cd6sm10622134a12.26.2026.07.14.15.21.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2026 15:21:23 -0700 (PDT)
Subject: [PATCH v2 0/4] mm/hmm: Clarify notifier retry state and scope HMM
 timeouts
From: Stanislav Kinsburskii <skinsburskii@gmail.com>
To: airlied@gmail.com, akhilesh@ee.iitb.ac.in, akpm@linux-foundation.org,
 corbet@lwn.net, dakr@kernel.org, david@kernel.org, jgg@ziepe.ca,
 kees@kernel.org, leon@kernel.org, liam@infradead.org, lizhi.hou@amd.com,
 ljs@kernel.org, lyude@redhat.com, maarten.lankhorst@linux.intel.com,
 mamin506@gmail.com, mhocko@suse.com, mripard@kernel.org,
 nouveau@lists.freedesktop.org, ogabbay@kernel.org, oleg@redhat.com,
 rppt@kernel.org, shuah@kernel.org, simona@ffwll.ch,
 skhan@linuxfoundation.org, skinsburskii@gmail.com, surenb@google.com,
 tzimmermann@suse.de, vbabka@kernel.org
Cc: dri-devel@lists.freedesktop.org, linux-mm@kvack.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-rdma@vger.kernel.org
Date: Tue, 14 Jul 2026 15:21:21 -0700
Message-ID: <178406760622.1106335.2379450382728057793.stgit@skinsburskii>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 16 Jul 2026 08:18:22 +0000
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

This small fixup series applies on top of:

  [PATCH v8 0/8] mm/hmm: Add mmap lock-drop support for userfaultfd-backed mappings

The first patch updates the HMM documentation example to make the
mmu_interval_read_retry() state explicit: callers should use the notifier and
notifier_seq stored in the same hmm_range that was passed to
hmm_range_fault_unlocked_timeout().

The remaining patches adjust nouveau, amdxdna, and drm_gpusvm users so the
timeout passed to hmm_range_fault_unlocked_timeout() is treated as a relative
HMM retry budget. These callers no longer keep an absolute deadline around
their outer driver retry loops or pass a computed remaining time into HMM.

This keeps the timeout scoped to HMM's internal mmu-notifier retry handling. If
HMM succeeds and the driver later observes an invalidation through
mmu_interval_read_retry(), the driver retries the operation with a fresh HMM
retry budget.

Changes in v2:
  - Kept the nouveau outer absolute timeout around the
    mmu_interval_read_retry() loop. hmm_range_fault_unlocked_timeout() only
    bounds HMM’s internal retries, while nouveau faults are handled from a GPU
    fault worker, so userspace fatal signals cannot break an endless stream of
    invalidations there.
  - Updated nouveau to use time_after_eq() before calling HMM, so the remaining
    timeout passed to hmm_range_fault_unlocked_timeout() is always positive and
    never 0, which would mean retry indefinitely.
  - Updated the nouveau fixup commit message to explain the worker-thread
    timeout issue and the time_after_eq() boundary behavior.
  - Fixed the amdxdna fixup commit message. It now describes
    aie2_populate_range() correctly instead of carrying stale nouveau prose,
    and notes that command submission still keeps its broader timeout while HMM
    gets a fresh relative retry budget.


---

Stanislav Kinsburskii (4):
      fixup! mm/hmm: add hmm_range_fault_unlocked_timeout() for mmap lock-drop support
      fixup! drm/nouveau: use hmm_range_fault_unlocked_timeout() for SVM faults
      fixup! accel/amdxdna: use hmm_range_fault_unlocked_timeout() for range population
      fixup! drm/gpusvm: use hmm_range_fault_unlocked_timeout() for range faults


 Documentation/mm/hmm.rst              |    5 +++--
 drivers/accel/amdxdna/aie2_ctx.c      |   12 ++++--------
 drivers/gpu/drm/drm_gpusvm.c          |   21 ++++++---------------
 drivers/gpu/drm/nouveau/nouveau_svm.c |   14 ++++++++++----
 4 files changed, 23 insertions(+), 29 deletions(-)

