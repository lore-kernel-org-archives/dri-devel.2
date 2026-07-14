Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72A9EC4450A
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 08:19:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 15D9410F200;
	Thu, 16 Jul 2026 08:19:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HMqYcdex";
	dkim-atps=neutral
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com
 [209.85.210.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4FE0A10E0C8
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Jul 2026 20:13:26 +0000 (UTC)
Received: by mail-pf1-f171.google.com with SMTP id
 d2e1a72fcca58-848d21bbaffso3812766b3a.0
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Jul 2026 13:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784060006; x=1784664806; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:user-agent
 :message-id:date:cc:to:from:subject:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TgA5/ZNNqpom9Ojeo649tW4NqgfWq3ikZU/yXXQBBgI=;
 b=HMqYcdexkHdArUO1/rP8tshmydvD5MO82gSy8RRSELqnJpTOlrffDzFH6lha54J9wr
 zxDlEMswqMUikE1jn3IrTvTN0DhT60RImyxP7oQQMcliEk6y+zC1Er+X5Xq7BW15W1r1
 abF7TBnzSN6kq+gg3TVdyyx5FFri3vzAdGI3Pq26RTtOq5h5s1w6VGeXt6WFZLonbu57
 pOd66vkHQ3HKbGi8jv25FRaDMgMVVjxOSTePdocisCunpHtDf7yVeuC8lE3DQzhxYARF
 Yp9ufC4AKCYIJByyforpLQlLTPDZ/VBzQWz2Ck1BDsl/KKkeEU248JylORBPcqpodzRs
 PsSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784060006; x=1784664806;
 h=content-transfer-encoding:content-type:mime-version:user-agent
 :message-id:date:cc:to:from:subject:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=TgA5/ZNNqpom9Ojeo649tW4NqgfWq3ikZU/yXXQBBgI=;
 b=joU0Pe2xqb95DWCQ1cmAy0F85S4f0v9iTtJH1AM/Fr9xm0AP2MtchOfNbdbdHH6P5m
 bRyIvUh6Bea/rhfAGLV3rkEtVh0/O0xLAOvpAnWUv9FM7NYZOVytxLhJ91FByB5zxxiI
 z/FzByMA3iMxFGiKrGQZIAGlNSgfHlCRsbNvNTqKl9rSXvNwbskGGqbP9GnECijKbXLv
 yeShVtoKY4jjgjYmgbwNYa5Fo7mQlN6EviWEVZNIS2kV+Fi9ifLiMZ+lPUjGfAGN1wIC
 FggJeiBIzQJFkYZ6Iv0YwTXtocC4lDjzQvTtLzN6c7kD/EuB39krqYqzXURSMxCrl4w1
 UW2A==
X-Gm-Message-State: AOJu0YwMFGFWPprbJ4q3dElquVXPPcpAehudYvAzuPztOTHg7y5iyN29
 bi1ShgNQPGB91S0mPvbYGVfyN+t6C+8/i+fsUjEORu5phZGIHrJqH/IF
X-Gm-Gg: AfdE7cle8D0eyBPJLJFDCSc0VrCWTeLjbWneEZRY5OAhUui2WroUAQ0JEKUGW4OsDYV
 RXYZNylmck45S+d8XtF/3Hu/L18xgFfc0+igFvWLkeRxp7NKO68HiHQtSvXWIZW9OVdLKvTjSpb
 L9oGsB8VJj9IETa9Hq7n1DyTghVN9itnQAzxC5inaxQI4LFzSW8kKG9WPJCsWbBR9hfMaHjpDmk
 8djzkBzu0LRxSr9wZtNFLpOAgo5zMO3qroPzMd/8TjlxA2hWUz3KDRTEgSTbnt4d2lNGbUw5ZkX
 t99zqN6Z8todDn4qSWRFZVW6qN7AHrHGF7uMmxVG/Zqi8ukdKgTpujXyBo8gabP2bSVTUI49eTH
 sdCXfh21w2rcibrfh4BJ5T8hy6lMUiYAP2e9ESgpCGX5IF/Mjop9ky4s7rkPyE9Yfr/OND+gfzg
 nl376MldNVdXA8Ms9zueBniDUc7qRobL4npyDbGGXZrahojRDxtQXViGL33G5xUJm3SsdLDQ==
X-Received: by 2002:a05:6a00:1f14:b0:845:e9e5:cdec with SMTP id
 d2e1a72fcca58-84a559bb7dfmr3412771b3a.62.1784060005776; 
 Tue, 14 Jul 2026 13:13:25 -0700 (PDT)
Received: from [192.168.0.160] (c-98-225-44-182.hsd1.wa.comcast.net.
 [98.225.44.182]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84a4f7dade0sm1998127b3a.46.2026.07.14.13.13.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2026 13:13:25 -0700 (PDT)
Subject: [PATCH 0/4] mm/hmm: Clarify notifier retry state and scope HMM
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
Date: Tue, 14 Jul 2026 13:13:23 -0700
Message-ID: <178405975214.1082778.5193079941156341151.stgit@skinsburskii>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
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

---

Stanislav Kinsburskii (4):
      fixup! mm/hmm: add hmm_range_fault_unlocked_timeout() for mmap lock-drop support
      fixup! drm/nouveau: use hmm_range_fault_unlocked_timeout() for SVM faults
      fixup! accel/amdxdna: use hmm_range_fault_unlocked_timeout() for range population
      fixup! drm/gpusvm: use hmm_range_fault_unlocked_timeout() for range faults


 Documentation/mm/hmm.rst              |    5 +++--
 drivers/accel/amdxdna/aie2_ctx.c      |   12 ++++--------
 drivers/gpu/drm/drm_gpusvm.c          |   21 ++++++---------------
 drivers/gpu/drm/nouveau/nouveau_svm.c |   30 ++++++++++--------------------
 4 files changed, 23 insertions(+), 45 deletions(-)

