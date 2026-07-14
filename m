Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF73CC4450A
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 08:19:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C3D1510F205;
	Thu, 16 Jul 2026 08:19:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="h28XSsV9";
	dkim-atps=neutral
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com
 [209.85.210.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 806F810E721
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Jul 2026 20:13:33 +0000 (UTC)
Received: by mail-pf1-f175.google.com with SMTP id
 d2e1a72fcca58-848882fdb18so1315983b3a.0
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Jul 2026 13:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784060013; x=1784664813; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:user-agent
 :references:in-reply-to:message-id:date:cc:to:from:subject:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Vc1a4EA+CKVDZWmxoam2W7gn+VW7+IE4FDUnuymM6t4=;
 b=h28XSsV9o081kMgK7EZFHLjOejwOM77Faz3eVI/IkFUnCjH9xRS6q+3QkZWVIqAFbZ
 pEjLiMXS/jQh7DhPGeM2pjJGAZdHMe2NAa8tuLlEh4WRCqig2g0PuqBwGkA12UC83WBi
 isS0aI1N5uu38ap1pRVOii5bhEXP4YwKNaORu1WpGa6hVAAa6WqGZRLf+fcKmNL19NfL
 rCwhRectI0TckuglFsJtYdPGRHycoBxJfphViSYtlDOGs+U3tEUxAghTaJbLUO7aFj/+
 5Y1Iay18obpGhnbdr56FrMzlUI/FDxfCqvt+qsNUGeICRBbvnKYWcT10n02CrijLmGt4
 d96g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784060013; x=1784664813;
 h=content-transfer-encoding:content-type:mime-version:user-agent
 :references:in-reply-to:message-id:date:cc:to:from:subject:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Vc1a4EA+CKVDZWmxoam2W7gn+VW7+IE4FDUnuymM6t4=;
 b=j3pWwlOchlZMMYcA7p3kZrT+B892nDWsHWNYKH3Ad2CMaNTktx5tq5lmMOtKDyrwY0
 bSCIY7pH1Er0k2RtVdcuc5O+4m1pWckaPNNaW4QddR9AEGo4WfN8Qcy/IqcG1/K6Gq4m
 hOAx50PVKs+vj8puKP/v3D421i+7DPZx0LnSRUlCartQwBGkBFlrM/Z6rkPGmp4dhf08
 BqksQXzOlgowpRskcQ8qJ6fM4vTeAOd56L9NSeU0sOm5gZTOb7bLkARxuj+tcMn+B3uv
 rkDaXmT3BoCT5iJTeGHkowAc9Im5pBVavSAflNy93DcMZhGYto4+ovuQJyo5A/uHCaca
 wYfg==
X-Gm-Message-State: AOJu0Yya6fKEHoTd8FliS1pgo/JVJPIDeKWjHI5GJdvgrq9zD0FBf/Js
 x2nwkK8pcMl8+toQgRfM5/+jvPzTOvPb1pOzt1wou/kmBBJQoPV4lOyC
X-Gm-Gg: AfdE7cmXSXaeKfHcbxPn1EdlEQc0EGiYVrlyuPoMdhRIrNY4ZN9gE1uZnuG0gwyuSD5
 lB4HEl3lWqG/nUjm0csbXKv9pO1YcnvsyFKI3e5wvURGMvdvGdjFtFqg88KXz7H744Xsf0xTnF2
 iQL/4Bokx8kV3DxW6zry0QGQGvk7CUn1IxpkNXcBnqbHLemOULYmoJ/Ckxdbn47YyQ4u3aKvdSr
 sLsEIK5IVoBs6adSDa5rDckaMkolItBy/a1ts8qrNdARMp0jLorqiNHSpup028QvClgHGpCGJRk
 OLa9XzzQM5JZDNn1RZ1enaKST9gOYwzJ3L4CQ57Ywz94OYhWvJEIbGm4HIz726IVxZeUWB/4VhH
 5Dv5SNr2x5bP2b1BJR4SEftPdKG2n5zEwT87K9xe068NYVEZmSnsp9nL3nR78eWtAoHfymO4H1Q
 12vrxkW7mY3x3D3h7lBAfbo1UkXOkpRlBp7drDcLS9u61v8LDSakR3ps/FYnE=
X-Received: by 2002:a05:6a00:2341:b0:848:2f84:f429 with SMTP id
 d2e1a72fcca58-84a6738a72fmr16414b3a.66.1784060012852; 
 Tue, 14 Jul 2026 13:13:32 -0700 (PDT)
Received: from [192.168.0.160] (c-98-225-44-182.hsd1.wa.comcast.net.
 [98.225.44.182]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84a4f6bf5ecsm1974797b3a.29.2026.07.14.13.13.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2026 13:13:32 -0700 (PDT)
Subject: [PATCH 1/4] fixup! mm/hmm: add hmm_range_fault_unlocked_timeout() for
 mmap lock-drop support
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
Date: Tue, 14 Jul 2026 13:13:31 -0700
Message-ID: <178406001098.1082778.7615814555318834246.stgit@skinsburskii>
In-Reply-To: <178405975214.1082778.5193079941156341151.stgit@skinsburskii>
References: <178405975214.1082778.5193079941156341151.stgit@skinsburskii>
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

The hmm_range_fault_unlocked_timeout() example checks for a concurrent
mmu_interval_notifier invalidation after the HMM fault has succeeded.
The sequence number used for that check is stored in range->notifier_seq
by hmm_range_fault_unlocked_timeout(), so the retry check should use the
same notifier stored in range as well.

Update the example to pass range.notifier to mmu_interval_read_retry(),
and spell out that the retry check uses the notifier and sequence number
stored in range by the HMM fault helper. This makes the relationship
between the HMM walk and the later invalidation check explicit.

Signed-off-by: Stanislav Kinsburskii <skinsburskii@gmail.com>
---
 Documentation/mm/hmm.rst |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/mm/hmm.rst b/Documentation/mm/hmm.rst
index 5c88d2cf0818..fc1b8dc19825 100644
--- a/Documentation/mm/hmm.rst
+++ b/Documentation/mm/hmm.rst
@@ -206,7 +206,7 @@ The usage pattern is::
           goto out_put;
 
       take_lock(driver->update);
-      if (mmu_interval_read_retry(&interval_sub, range.notifier_seq)) {
+      if (mmu_interval_read_retry(range.notifier, range.notifier_seq)) {
           release_lock(driver->update);
           goto again;
       }
@@ -225,7 +225,8 @@ The usage pattern is::
 The driver->update lock is the same lock that the driver takes inside its
 invalidate() callback. That lock must be held before calling
 mmu_interval_read_retry() to avoid any race with a concurrent CPU page table
-update.
+update. The retry check must use the same notifier and sequence number stored
+in ``range`` by ``hmm_range_fault_unlocked_timeout()``.
 
 Holding the mmap lock across HMM faults
 =======================================


