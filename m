Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0A32C98314
	for <dri-devel@archiver.kernel.org>; Thu, 24 Sep 2026 06:54:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6241C10F337;
	Thu, 24 Sep 2026 06:54:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="Di2c2Vg8";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8369610F337
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 06:54:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790232856;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xEEzUKmwPcuLDb8KHUBfxekosp3Yw5qO1BP0yTFVDsQ=;
 b=Di2c2Vg8lOFUAaEUBDlbLNQndMfcuf485e4Z7X8HpI71JXcA4cDpYo3uoAspnJijFO+MbV
 DurbIU/+AesSOc4NJJWKsVijNOiVP2yTqtYya8Fnb3y0n7WsyBLaHsfAnaPumtiw1xqlls
 dLNu4qlpaHZHgiQJIKk55JijT+niLP8=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-1vrbzjV2NEOW6xwzIyEFCw-1; Thu, 24 Sep 2026 02:54:13 -0400
X-MC-Unique: 1vrbzjV2NEOW6xwzIyEFCw-1
X-Mimecast-MFC-AGG-ID: 1vrbzjV2NEOW6xwzIyEFCw_1790232852
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-3a208b764f1so7594601fa.1
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 23:54:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790232852; x=1790837652;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=xEEzUKmwPcuLDb8KHUBfxekosp3Yw5qO1BP0yTFVDsQ=;
 b=0gUsxiLd2izUatPhHmo7flQxS70RL/uKHAxghgx2SwitM0YYivkpuXxdYC0GYvjjr2
 Kr5imAij0RSpe1mHLs8VM5tGVRqHm4JIfCqJZ9SuhEBWkfEM6unQLWI3nRVAAIOoFUv5
 1sr8ONsNA4VpQjbXM/8kEvj2eM+54Oxqe4xG0GcRqOdBQ6V+Dp2VXpjWz6FVQj2PhbKA
 L7pUXKaXtIenhAI2Z2Ev+EOVQegOk5Zlpv/NvfHEgeeLXYpHcTcjrgt2iootAEGW3xDo
 dpoIxs08YbEsqeiqUsy0nT7L5JsfpiYBQpfTE4MVmpPOOQgk0I2pcOz9EyVO3R9Sr+4O
 ZW8Q==
X-Gm-Message-State: AFuF++nU/26f6eokJHxewqxniQV3QTt9Vs31Ov2PRTgulXhLYsdoKjNH
 WkeUBtKApe0jIVWdS+6+lHRH/nUHhJf0uEeJw1hOLfoeGZRB5AV9+WesQebi4rRv6kHZj2Q2tzI
 lAudkCWlr2gE9GVNuejUHqMRCQhJk7OI2WebmpLBsycxC6R/Yy8zgq40Ra07qODEA0FWsVXe7ax
 WR3GQ=
X-Gm-Gg: AYBFou1u/RzP88vSKdP+3hvV6cR7Ss0fygynk+Tj9xLhGgJaaU29JfmEPPsy1StECwE
 m83a0xbJocvbpwxu3nRESRYrbLen/wij/LnL05vdFHRo3KJvXDkb+yG1Ls7DF7eXmJwGDnLAdTu
 6yf+Zp9gNuV27mgs/YON3pVviqQ40WgzSLk0BgVXisPwgs4V/bvtSpTPZjRW/ymGeCaW9QINQmc
 QURt+SqemGSlnyUbVXitVG4bJsyEN55BneQgZccd3lBqXC4kKmcSfI921P1S6278m8n9wUf5n2G
 pTvFL1zhYHzKMKlGh/U0vKPEpV9yvLFFf4oN8tM+XT9bx9VK1GeBAIX5wBr2IU7Z02qp/EBPRZc
 RpUE0Tu7nHVZ4DRby26GU
X-Received: by 2002:a2e:b893:0:b0:3a2:f233:5c6e with SMTP id
 38308e7fff4ca-3a63bf652b3mr3928461fa.6.1790232852083; 
 Wed, 23 Sep 2026 23:54:12 -0700 (PDT)
X-Received: by 2002:a2e:b893:0:b0:3a2:f233:5c6e with SMTP id
 38308e7fff4ca-3a63bf652b3mr3928141fa.6.1790232851558; 
 Wed, 23 Sep 2026 23:54:11 -0700 (PDT)
Received: from fedora (89-27-86-246.bb.dnainternet.fi. [89.27.86.246])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3a63bf57909sm4803141fa.29.2026.09.23.23.54.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 23:54:08 -0700 (PDT)
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
Subject: [PATCH v15 11/11] Documentation/mm/hmm: document migration through
 hmm_range_fault()
Date: Thu, 24 Sep 2026 09:53:13 +0300
Message-ID: <20260924065313.899730-12-mpenttil@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260924065313.899730-1-mpenttil@redhat.com>
References: <20260924065313.899730-1-mpenttil@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: qcId3HNbYg-Z0xpWWnf74d2y2DYyMlK6OY1yn9K1bBU_1790232852
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

