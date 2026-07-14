Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07ABAC4450A
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 08:21:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F14510F203;
	Thu, 16 Jul 2026 08:21:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WZNRhfez";
	dkim-atps=neutral
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com
 [209.85.216.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3449010E0F9
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Jul 2026 22:21:31 +0000 (UTC)
Received: by mail-pj1-f41.google.com with SMTP id
 98e67ed59e1d1-38de840f2f0so1616156a91.0
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Jul 2026 15:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784067691; x=1784672491; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:user-agent
 :references:in-reply-to:message-id:date:cc:to:from:subject:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Vc1a4EA+CKVDZWmxoam2W7gn+VW7+IE4FDUnuymM6t4=;
 b=WZNRhfezjIs7dGxGhDzDMMQt0opXCLE1Q3/l9D9SXmcJqONaKuorTUZv+DYgToVMxa
 MxbAsds3Bs5+MLUi5J1Ef02WFEkZmA3UBXhGOoOCbce++8TrC3fHqhia0iXblJMwUd24
 L7DHrn1m/VUVQQAqhrcGl2N/4zTzIHyO7KbGD/0dDK+3+oZHAOpVq6kq0ndTzcWOyP6w
 pgBBUGY/rvp+3E9tSsx40N4Y8Wqqa1ZzjpNBcEt/VpOxCSFSYVHhJDL+gv1x5dI7pdZG
 FfsG8fc7V3cV5jyUVLWBQseh9aKCfwYTD7C8UvL7qfsPIoiil9HwPY1+U1hPj4HcGFx5
 86GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784067691; x=1784672491;
 h=content-transfer-encoding:content-type:mime-version:user-agent
 :references:in-reply-to:message-id:date:cc:to:from:subject:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Vc1a4EA+CKVDZWmxoam2W7gn+VW7+IE4FDUnuymM6t4=;
 b=kpZM4a1SpBuDC6RIAMbeaPWiAM1Xd/6akEdea8n98WdsNN6ZESZPEIWCVyRCXrk/Bm
 gGstfWiu49sdBvRVambd+EnX3ZynczoLniPPhO8zl2lK0gm2Fx8kvwBD+Kr7KsIjp+UN
 RfLAlVYCKc0snf7XuXGfF9V6Zbvkc03RjPUBeoY59cQwN6L2iDic+IAh9YUIXpScz/Ob
 YBNPsynv0o3PwF5StLTy2YT5e1shlU882/hautuCZWXbNnVDdU8W46luvxw7Zw/IT3UU
 +d5kYs3bADhjbSmHbxEVXV6CntuOBnsDwoI1RQa29hpu0HldxdKuq3ROGNNiBdQ3Tq8N
 79zw==
X-Gm-Message-State: AOJu0YwhOzWyQdgqcMnNWUXgwC85KizHjGW2T7TYis5kYb6PAYGbhPQF
 5pt93ioA5ShzHEMWVkVj7fE5FJTdV7OCC7J951rhZp3SkxC4qWI2VsX+
X-Gm-Gg: AfdE7clcfvQTrP1pbK7Up1fGlkuqryv5tpC4PjpEFO7LZ9vzRcZzWJ7MkVCcPOQdeg1
 EaXaRKqZfbPHdUll0sknnxI3+A/wosEfXvkO2lQ7Y7wNjahvfpt36KsvtrUO1d+l18gR8yIw8ci
 B+7ClOXI0+qj4J4dqL8roVmnfYd12zTKYOJ0AnkPfww46qUijnG5sLMZqVv9xkthdwA6fGph7l3
 OCgRWR4bTgkFlEXBxtp8Eu7iLGn7jzcwlEyTttEs4uuEUMujj0XbUqjE8ME7m91vHqyMKRsihJI
 wP3qWf7fMcShTGVKD1+TuIVS3P4GBmoecL/HRfintH6/FeqX827lFIplqcPkVu/XMNSOv2g3u0n
 RZ6HCdqyS3mMzKvtYyviH7hdu/srh/F7uqVXKLQv+590CAg7sZLv380ZAY2jb9H7ZUmRRWKU7zY
 S+aeRHHneDjt5emyoL3o35dOPE4c4gMPuuMsxW7MBxxY+NndRZCzvgBV+/lkI=
X-Received: by 2002:a17:90b:3d4b:b0:381:1f51:1ff0 with SMTP id
 98e67ed59e1d1-38dc782ab85mr13404006a91.2.1784067690606; 
 Tue, 14 Jul 2026 15:21:30 -0700 (PDT)
Received: from [192.168.0.160] (c-98-225-44-182.hsd1.wa.comcast.net.
 [98.225.44.182]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-38e172b6d08sm2132074a91.2.2026.07.14.15.21.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2026 15:21:30 -0700 (PDT)
Subject: [PATCH v2 1/4] fixup! mm/hmm: add hmm_range_fault_unlocked_timeout()
 for mmap lock-drop support
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
Date: Tue, 14 Jul 2026 15:21:28 -0700
Message-ID: <178406768885.1106335.9955379956617151440.stgit@skinsburskii>
In-Reply-To: <178406760622.1106335.2379450382728057793.stgit@skinsburskii>
References: <178406760622.1106335.2379450382728057793.stgit@skinsburskii>
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


