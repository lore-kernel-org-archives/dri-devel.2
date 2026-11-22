Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A061606A320
	for <dri-devel@archiver.kernel.org>; Sun, 22 Nov 2026 07:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=kAr52fgL
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DBEA810E3EA;
	Sun, 22 Nov 2026 07:44:01 +0000 (UTC)
X-Greylist: delayed 368 seconds by postgrey-1.36 at gabe;
 Sun, 22 Nov 2026 07:43:54 UTC
Received: from mta1.migadu.com (out-2.mta1.migadu.com [95.215.58.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E767910E00C
 for <dri-devel@lists.freedesktop.org>; Sun, 22 Nov 2026 07:43:54 +0000 (UTC)
X-Envelope-To: dri-devel@lists.freedesktop.org
DKIM-Signature: a=rsa-sha256; bh=OX2Dl1yXBEikHAL+zTZY/BAfC4M/xpOaeaiU2uI76oM=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795333433; v=1; x=1795938233;
 b=kAr52fgLkTkK6DxlraxwTqtQ0UM/L91ZgwFeZ917SCVoVmvZTwQ3wl0KFOFjTIPxCm/dXMs1
 yBHryv7mN9R8dOeJqOKFSf8hq7lfDuCaIecxXtlj4JUhpbqFXz49paFrUty6/S+fozTbZ+jTX2/
 zOtFY63t54bRXjJLf47DP6Pc=
X-Envelope-To: dri-devel@lists.freedesktop.org
Received: by smtp.migadu.com with ESMTPS id 295cb77bfbe198e6;
 Sun, 22 Nov 2026 07:37:49 +0000
X-Mizu-Trace-ID: 295cb77bfbe198e6
X-Migadu-Flow: FLOW_OUT
From: Qiliang Yuan <qiliang.yuan@linux.dev>
Date: Sun, 22 Nov 2026 02:37:36 -0500
Subject: [PATCH 1/3] dma-buf: align large mappings to PMD boundaries
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261122-feat-udmabuf-huge-pfnmap-v1-1-dcba888940c2@linux.dev>
References: <20261122-feat-udmabuf-huge-pfnmap-v1-0-dcba888940c2@linux.dev>
In-Reply-To: <20261122-feat-udmabuf-huge-pfnmap-v1-0-dcba888940c2@linux.dev>
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

A dma-buf exporter whose buffer is backed by physically contiguous memory
can map it with PMDs from a ->huge_fault() handler, which only works where
the user address and the buffer offset are aligned alike to PMD_SIZE.

dma_buf_fops has no ->get_unmapped_area(), so mmap() places a dma-buf at
whatever page aligned address the default allocator returns. A 4 GiB
udmabuf, for one, lands 616 KiB past a 2 MiB boundary, and then none of
its PMD-sized ranges can be mapped with a PMD.

Use thp_get_unmapped_area(), as filesystems that support huge mappings
do. It aligns a mapping that covers at least one whole PMD to the buffer
offset and leaves smaller mappings where they would be placed anyway.

Signed-off-by: Qiliang Yuan <qiliang.yuan@linux.dev>
---
 drivers/dma-buf/dma-buf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
index 5c6957f8839a8..015a03c8d04db 100644
--- a/drivers/dma-buf/dma-buf.c
+++ b/drivers/dma-buf/dma-buf.c
@@ -608,6 +608,7 @@ static void dma_buf_show_fdinfo(struct seq_file *m, struct file *file)
 static const struct file_operations dma_buf_fops = {
 	.release	= dma_buf_file_release,
 	.mmap		= dma_buf_mmap_internal,
+	.get_unmapped_area = thp_get_unmapped_area,
 	.llseek		= dma_buf_llseek,
 	.poll		= dma_buf_poll,
 	.unlocked_ioctl	= dma_buf_ioctl,

-- 
2.43.0

