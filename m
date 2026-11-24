Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29368606A33E
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 02:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=EXbkdwU7
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 53FB410E09B;
	Tue, 24 Nov 2026 02:45:24 +0000 (UTC)
X-Greylist: delayed 155179 seconds by postgrey-1.36 at gabe;
 Tue, 24 Nov 2026 02:45:17 UTC
Received: from mta0.migadu.com (out-114.mta0.migadu.com [91.218.175.114])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CAAD810E09B
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 02:45:17 +0000 (UTC)
X-Envelope-To: dri-devel@lists.freedesktop.org
DKIM-Signature: a=rsa-sha256; bh=ir4B76zlkpWj23djjJNSYj9nLGcKKUpZKOTxUa3rwUQ=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795488314; v=1; x=1796093114;
 b=EXbkdwU7acpx0ZFw2wzqbbCGO9XSCQexoH8bHNRCZ9fGkvfEW+CFB4ZGzA2LDU035s9k5n/z
 VgEI6cgE/Xlc2sxojb6qhl3H+D9K3l+eMdWFh8pGUr04nAW9wwrFyX6VAfG+K4TzDLmmUbMNeFc
 e9uPYZPdPKaqCHtWhR+nkf5o=
X-Envelope-To: dri-devel@lists.freedesktop.org
Received: by smtp.migadu.com with ESMTPS id 9e699e5a7949427e;
 Tue, 24 Nov 2026 02:45:14 +0000
X-Mizu-Trace-ID: 9e699e5a7949427e
X-Migadu-Flow: FLOW_OUT
From: Qiliang Yuan <qiliang.yuan@linux.dev>
Subject: [PATCH v2 0/3] udmabuf: speed up mmap() of huge page backed
 buffers
Date: Mon, 23 Nov 2026 21:44:59 -0500
Message-Id: <20261123-feat-udmabuf-huge-pfnmap-v2-0-3254f801fc36@linux.dev>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIACv6BGsC/3WNzQ7CIBCEX6XZsxhYf4qefA/TAy2L3URpA4XUN
 H13sYlHj99k5psFIgWmCNdqgUCZIw++AO4q6HrjHyTYFgaUeFYKlXBkJpHsy7TJiT6Vwuj8y4z
 igCeNNVpZ1wRlPgZyPG/qe1O45zgN4b09ZfVNf1L8L81KSGG71mitL0fZ4e3JPs17SxmadV0/6
 Sq7dMAAAAA=
To: Sumit Semwal <sumit.semwal@linaro.org>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Philipp Stanner <phasta@kernel.org>, Gerd Hoffmann <kraxel@redhat.com>, 
 Vivek Kasireddy <vivek.kasireddy@intel.com>, Shuah Khan <shuah@kernel.org>
Cc: =?utf-8?q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
 "T.J. Mercier" <tjmercier@google.com>, Philip Yang <Philip.Yang@amd.com>, 
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Qiliang Yuan <qiliang.yuan@linux.dev>, 
 Natalie Vock <nat@pixelcluster.dev>
X-Mailer: b4 0.13.0
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

QEMU and crosvm export virtio-gpu blob resources from guest memory as
udmabufs, which the host renderer and display mmap(). The guest memory is
often backed by 2 MiB huge pages, yet udmabuf maps it 4 KiB at a time:
mapping and touching a 4 GiB buffer inserts a million PTEs and takes over
200 ms.

Patch 1 has mmap() of a dma-buf align large mappings to PMD boundaries,
which any exporter mapping contiguous memory with PMDs needs, such as the
proposed VFIO dma-buf mmap() [1]. Patch 2 maps the huge page backed
ranges of a udmabuf with PMDs, which cuts the time to map and touch it
by 87-90% for hugetlb and shmem THP backed buffers and leaves 4 KiB
backed ones as they are. Patch 3 adds selftests.

[1] https://lore.kernel.org/r/20260527102319.100128-1-mattev@meta.com

Signed-off-by: Qiliang Yuan <qiliang.yuan@linux.dev>
---
V1 -> V2:
- 1/3: Add Reviewed-by (Christian König).
- 2/3: Pre-fault only the faulting PMD range when the VMA can't have
  PMDs, so that disabling THP after a PMD was mapped no longer has
  vmf_insert_pfn() walk into that PMD (Sashiko review).
- 3/3: Give each huge page its own data pattern, skip the alignment
  check for 32-bit tasks and read the inherited mapping in the forked
  child (Sashiko review).

A fault racing with prctl(PR_SET_THP_DISABLE) can still see a PMD
installed by a concurrent fault. Lorenzo's series in mm/core fixes this
in the core mm for all PFN maps with ->huge_fault() [2].

[2] https://lore.kernel.org/r/20261117-huge-pfnmap-fault-races-v2-0-276007e73bcb@kernel.org

v1: https://lore.kernel.org/r/20261122-feat-udmabuf-huge-pfnmap-v1-0-dcba888940c2@linux.dev

---
Qiliang Yuan (3):
      dma-buf: align large mappings to PMD boundaries
      udmabuf: map huge page backed ranges with PMDs
      selftests/udmabuf: test mapping a huge page backed udmabuf

 drivers/dma-buf/dma-buf.c                         |  1 +
 drivers/dma-buf/udmabuf.c                         | 85 +++++++++++++++++++-
 tools/testing/selftests/drivers/dma-buf/udmabuf.c | 97 ++++++++++++++++++++++-
 3 files changed, 178 insertions(+), 5 deletions(-)
---
base-commit: c408466a4dfaee4b12587e926c5b85e68c8b3c40
change-id: 20261121-feat-udmabuf-huge-pfnmap-3258272d077e

Best regards,
-- 
Qiliang Yuan <qiliang.yuan@linux.dev>

