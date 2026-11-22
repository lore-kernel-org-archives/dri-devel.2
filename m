Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC80606A320
	for <dri-devel@archiver.kernel.org>; Sun, 22 Nov 2026 08:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=xtPnJ+8e
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 60D5310E17E;
	Sun, 22 Nov 2026 08:13:59 +0000 (UTC)
Received: from mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C0C7A10E17E
 for <dri-devel@lists.freedesktop.org>; Sun, 22 Nov 2026 08:13:52 +0000 (UTC)
X-Envelope-To: dri-devel@lists.freedesktop.org
DKIM-Signature: a=rsa-sha256; bh=h/GTrd6gvXy6aK8t1D7cqsfPdYQXwAl/ymNtfNBswfo=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795335230; v=1; x=1795940030;
 b=xtPnJ+8eY6JHES5FMnhWn9JUGCrfO0EHVrO4acSMai6VUBuT6plgP95+xRpKR/6K8p6zOinl
 FEYy9FnRIy6VPd1jrBZiVfn62uk4CVzl8kixk+3Dj5Bs/sEnVR+KEm4NmOgy4uo8JX+Sq3MXdo+
 97y6HFR8+ggpaQV7APs72MY0=
X-Envelope-To: dri-devel@lists.freedesktop.org
Received: by smtp.migadu.com with ESMTPS id 3ac586d565c110b2;
 Sun, 22 Nov 2026 07:37:43 +0000
X-Mizu-Trace-ID: 3ac586d565c110b2
X-Migadu-Flow: FLOW_OUT
From: Qiliang Yuan <qiliang.yuan@linux.dev>
Subject: [PATCH 0/3] udmabuf: speed up mmap() of huge page backed buffers
Date: Sun, 22 Nov 2026 02:37:35 -0500
Message-Id: <20261122-feat-udmabuf-huge-pfnmap-v1-0-dcba888940c2@linux.dev>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAL+bAmsC/x2MwQqFIBAAfyX2/BZyo4x+Jd7Bcq09ZKIZQfTvS
 ceBmbkhcRROMFQ3RD4lye4LqF8F82r8wii2MFBNnVKk0LE5MNvNTNnhmosQnN9MwIbanjTZWmu
 GkofITq5vPf6f5wW/Ik1zagAAAA==
To: Sumit Semwal <sumit.semwal@linaro.org>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Philipp Stanner <phasta@kernel.org>, Gerd Hoffmann <kraxel@redhat.com>, 
 Vivek Kasireddy <vivek.kasireddy@intel.com>, Shuah Khan <shuah@kernel.org>
Cc: linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Qiliang Yuan <qiliang.yuan@linux.dev>
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
Qiliang Yuan (3):
      dma-buf: align large mappings to PMD boundaries
      udmabuf: map huge page backed ranges with PMDs
      selftests/udmabuf: test mapping a huge page backed udmabuf

 drivers/dma-buf/dma-buf.c                         |  1 +
 drivers/dma-buf/udmabuf.c                         | 69 ++++++++++++++++-
 tools/testing/selftests/drivers/dma-buf/udmabuf.c | 90 ++++++++++++++++++++++-
 3 files changed, 158 insertions(+), 2 deletions(-)
---
base-commit: c408466a4dfaee4b12587e926c5b85e68c8b3c40
change-id: 20261121-feat-udmabuf-huge-pfnmap-3258272d077e

Best regards,
-- 
Qiliang Yuan <qiliang.yuan@linux.dev>

