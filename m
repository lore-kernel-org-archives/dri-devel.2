Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9442C98304
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 05:35:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD82510EB6E;
	Tue, 22 Sep 2026 05:35:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="UvASsNjw";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ADEBE10E6C3
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 05:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790055321;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xEEzUKmwPcuLDb8KHUBfxekosp3Yw5qO1BP0yTFVDsQ=;
 b=UvASsNjwNk+oVdt28xpUo6LmNEH3PULy/Ax6+G6tBe+SnHIzAslC/+xJKtHVre//VJTvjO
 HiEgB7jdPUqotdgZnSpFHZPwwh+LRqN7HommmQDq087NIWzsTbMKSO/5L6l28dMmG6pgtd
 BLqRiAlGJWBtg7be+xSoCS2eJ8tkQgI=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-450-MnmJ5Ie1PTyAwEhaehx2hg-1; Tue, 22 Sep 2026 01:35:20 -0400
X-MC-Unique: MnmJ5Ie1PTyAwEhaehx2hg-1
X-Mimecast-MFC-AGG-ID: MnmJ5Ie1PTyAwEhaehx2hg_1790055319
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-5b8c58cd8c0so2124866e87.2
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 22:35:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790055318; x=1790660118;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=xEEzUKmwPcuLDb8KHUBfxekosp3Yw5qO1BP0yTFVDsQ=;
 b=YgSdSJ4zb/CzG6uiFRqTSQLSWw6/J2hjHOfq3Rc8VzI6Ua7n5ZvEKMdCrnXSuwtAWV
 2WJ807/k8Td//Crql0Yhn+4kJx1OZaMWips4rMCfRFVK4c7nSJmVVICZPW2Y2Us42vAn
 lsi52lKGbuA18/cqQYXPDNBu5WN3a7CqKAtsSgeZ/mx2A5NCXq35DvbQB44yfjQvwSdO
 XPMw9/kZFSN4eOk0BysBF0Vo8AfUYMa480TQt9YtNVBTs0jAHyaJ6OwPwFj9sLhm2OO1
 OvmjMrHxbW/R9S+vlYZSDCZThoVFFDT6FIsh8gT6Zq8TuNZcTnPfBDWN1RTAQxdrOoZa
 W9WQ==
X-Gm-Message-State: AFuF++l/tRxVfw7iW1fCgQ6KUa9iDioowjCs4Fkj9qqqvttFHWWNVnMD
 6NcJEsMgmZlU88xDw3xmjxsHU1Ek1jyd9iGw/ETdAgMLY3Ey9USGwZcTkkUeMwdby/my1cY/cqP
 knyfE0oplZKYmNh4rqzfFv8M08NK+rC2/5JcWsa1IckKTtI8NNMMKRIayi4G+WcVf4nee
X-Gm-Gg: AYBFou0gqXSxm62337KKI8EeUuhv7yZZxhPGwIDfvN+u8VE/xXaZ/tSrIyOgvNyhqM9
 9TO/Ag9E93WhfWR0kXztOpPolShXU2NF3PcqO97hlBWWWtsEME5g3RVOf0oMUnpJKPfsCJh6wSC
 6D7s7DmWpyf53jiqgV3PHbS4LvMB/F2t6a3mNvtddaRnw/rTmwdt9hqrQIlfEO4RMfYB2Ayn8Mj
 qNk3HtuBDkcDoAK9DqT0mDL+0IEtz63fdE2DtTxsU53eKeiNclo9fXkv06mpwn8cZQd5Kbh+8RI
 irYYLZt5HPDB6LzHK8kmHt52VeyI92qANpCxrTjcDRIjLV3bmwR8+Lo/y7slyvXEycyLWA4VSqP
 9lUkmLr5GJ4G5if9yMIDD
X-Received: by 2002:ac2:51c3:0:b0:5b5:e86f:3550 with SMTP id
 2adb3069b0e04-5b8c1833648mr3732732e87.9.1790055318578; 
 Mon, 21 Sep 2026 22:35:18 -0700 (PDT)
X-Received: by 2002:ac2:51c3:0:b0:5b5:e86f:3550 with SMTP id
 2adb3069b0e04-5b8c1833648mr3732729e87.9.1790055318145; 
 Mon, 21 Sep 2026 22:35:18 -0700 (PDT)
Received: from fedora (89-27-86-246.bb.dnainternet.fi. [89.27.86.246])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b8d46e0966sm191742e87.55.2026.09.21.22.35.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2026 22:35:15 -0700 (PDT)
From: mpenttil@redhat.com
To: linux-mm@kvack.org
Cc: dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 linux-kernel@vger.kernel.org,
 =?UTF-8?q?Mika=20Penttil=C3=A4?= <mpenttil@redhat.com>,
 David Hildenbrand <david@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>,
 Leon Romanovsky <leonro@nvidia.com>, Alistair Popple <apopple@nvidia.com>,
 Balbir Singh <balbirs@nvidia.com>, Zi Yan <ziy@nvidia.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>
Subject: [PATCH v14 12/12] Documentation/mm/hmm: document migration through
 hmm_range_fault()
Date: Tue, 22 Sep 2026 08:34:21 +0300
Message-ID: <20260922053421.4092027-13-mpenttil@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260922053421.4092027-1-mpenttil@redhat.com>
References: <20260922053421.4092027-1-mpenttil@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: w27EbOhybUe3OYYrJuJPOt1HGPV1xuWIZWTq1UeXW-Q_1790055319
X-Mimecast-Originator: redhat.com
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

From: Mika Penttilä <mpenttil@redhat.com>

Describe the two new MIGRATE_VMA_FAULT / MIGRATE_VMA_WRITE flags of
migrate_vma_setup(), and add a section on driving the migration
collection phase directly from hmm_range_fault() via HMM_PFN_REQ_MIGRATE
and migrate_hmm_range_setup().

Signed-off-by: Mika Penttilä <mpenttil@redhat.com>
---
 Documentation/mm/hmm.rst | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/Documentation/mm/hmm.rst b/Documentation/mm/hmm.rst
index fc1b8dc19825..58424e5f5873 100644
--- a/Documentation/mm/hmm.rst
+++ b/Documentation/mm/hmm.rst
@@ -348,6 +348,13 @@ between device driver specific code and shared common code:
    Currently only anonymous private VMA ranges can be migrated to or from
    system memory and device private memory.
 
+   By default only pages already present are collected. Two additional flags
+   ask migrate_vma_setup() to fault in missing pages first:
+
+   * ``MIGRATE_VMA_FAULT`` faults in missing pages with read access.
+   * ``MIGRATE_VMA_WRITE`` faults in missing pages with write access
+     (implies faulting).
+
    One of the first steps migrate_vma_setup() does is to invalidate other
    device's MMUs with the ``mmu_notifier_invalidate_range_start()`` and
    ``mmu_notifier_invalidate_range_end()`` calls around the page table
@@ -427,6 +434,38 @@ between device driver specific code and shared common code:
 
    The lock can now be released.
 
+Migration collection through hmm_range_fault()
+==============================================
+
+The collection phase of migration (steps 1 and 2 above) can also be driven by
+hmm_range_fault() directly, sharing its page table walk. This lets a driver
+fault in and collect a range for migration in one walk, which is useful for
+migrate on fault.
+
+To do so, the driver sets ``HMM_PFN_REQ_MIGRATE`` in ``range->default_flags``
+and points ``range->migrate`` at a ``struct migrate_vma`` it has filled in
+(``flags``, ``src``, ``dst``, ``pgmap_owner``). Usually ``HMM_PFN_REQ_FAULT``
+(and ``HMM_PFN_REQ_WRITE``) is set as well, so missing pages are faulted in
+before being collected. The mmap_read_lock() has to be held for the whole
+migration, since the vma must stay stable.
+
+hmm_range_fault() collects the entries the same way migrate_vma_setup() does,
+taking a folio reference, locking it and installing a migration PTE. Collected
+entries are marked with ``HMM_PFN_VALID | HMM_PFN_MIGRATE`` in
+``range->hmm_pfns``. If the page tables change while locks are dropped the
+partially collected entries are rolled back automatically.
+
+After hmm_range_fault() returns, the driver calls::
+
+    void migrate_hmm_range_setup(struct hmm_range *range);
+
+to translate ``range->hmm_pfns`` into ``migrate->src[]`` (``migrate->dst[]`` is
+zeroed) and initialize ``migrate->cpages`` and ``migrate->npages``. From here on
+the ``range->migrate`` struct is ready for the rest of the flow (steps 3
+onwards), i.e. migrate_vma_pages() and migrate_vma_finalize(). This should be
+called even on error, since hmm_range_fault() may have collected part of the
+range before failing.
+
 Exclusive access memory
 =======================
 
-- 
2.55.0

