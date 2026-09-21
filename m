Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26107C982F1
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 12:19:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4354C10E5AF;
	Mon, 21 Sep 2026 12:18:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="P/4DeJ6/";
	dkim-atps=neutral
X-Greylist: delayed 536 seconds by postgrey-1.36 at gabe;
 Mon, 21 Sep 2026 10:21:38 UTC
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2BD5010E023
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 10:21:38 +0000 (UTC)
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
 by mailout1.samsung.com (KnoxPortal) with ESMTP id
 20260921101240epoutp0121e1fcfbc50348f11a05d389efb90cbf~XTmIWXUSX1348613486epoutp017
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 10:12:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com
 20260921101240epoutp0121e1fcfbc50348f11a05d389efb90cbf~XTmIWXUSX1348613486epoutp017
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1789985560;
 bh=H6EckjlZbTDuDbr8yAjtNMKEFEFvX00BNEUZIPb4CHo=;
 h=From:To:Cc:Subject:Date:References:From;
 b=P/4DeJ6/e0/RjQVsRJ0kC/ReA4NwL273z7HLSEO6wmDztjTGpKhs8+NW9k2BvaRXS
 PI5XVb01d6OPU57or+aZXGt8wP9eQL4xB5nsEeYET9dwpe8GVlx+KbYQ/bDejMfCMl
 phikOd3M2fyhImrCEAbxJjk3mR8DdsG5b63oAvbg=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
 epcas2p1.samsung.com (KnoxPortal) with ESMTPS id
 20260921101239epcas2p174aa964020ddd17ed666d3db3b656bde~XTmIFdRIH2148721487epcas2p1Z;
 Mon, 21 Sep 2026 10:12:39 +0000 (GMT)
Received: from epcas2p1.samsung.com (unknown [182.195.38.200]) by
 epsnrtp04.localdomain (Postfix) with ESMTP id 4hpJvC3NrVz6B9m8; Mon, 21 Sep
 2026 10:12:39 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
 epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
 20260921101238epcas2p39bec3831b3cbaaa71de0ece7b7f7329d~XTmHUpWgl0503405034epcas2p3B;
 Mon, 21 Sep 2026 10:12:38 +0000 (GMT)
Received: from KORCO090182.samsungds.net (unknown [12.80.211.164]) by
 epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20260921101238epsmtip13d954d6aed26e77e2ba84064f8c60b7f~XTmHQTWSs2430824308epsmtip1L;
 Mon, 21 Sep 2026 10:12:38 +0000 (GMT)
From: Janghyuck Kim <janghyuck.kim@samsung.com>
To: sumit.semwal@linaro.org, christian.koenig@amd.com, phasta@kernel.org
Cc: linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org, Janghyuck Kim
 <janghyuck.kim@samsung.com>
Subject: [PATCH] dma-buf: don't WARN_ON_ONCE() on a failing dmabuf->ops->vmap()
Date: Mon, 21 Sep 2026 19:09:46 +0900
Message-Id: <20260921100946.353521-1-janghyuck.kim@samsung.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260921101238epcas2p39bec3831b3cbaaa71de0ece7b7f7329d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
cpgsPolicy: CPGSC10-234,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260921101238epcas2p39bec3831b3cbaaa71de0ece7b7f7329d
References: <CGME20260921101238epcas2p39bec3831b3cbaaa71de0ece7b7f7329d@epcas2p3.samsung.com>
X-Mailman-Approved-At: Mon, 21 Sep 2026 12:18:56 +0000
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

dma_buf_vmap() escalates any non-zero return from dmabuf->ops->vmap()
into a WARN_ON_ONCE(). But a failing vmap() is not, by itself,
evidence of a violated invariant or a driver bug -- it's an ordinary
runtime failure of a fallible operation, no different from any other
allocation-shaped kernel API that can return an error. The dma-buf
core has no visibility into what a given exporter's vmap()
implementation considers a normal failure versus an internal bug;
that distinction, if it matters at all, belongs to the exporter, not
to this generic passthrough.

-ENOMEM is a concrete, easily reproduced example of this. Page
allocation on the vmap()/vmalloc() path can fail purely because the
calling task has a fatal signal pending: should_reclaim_retry() in
mm/page_alloc.c intentionally gives up reclaim and returns false
once fatal_signal_pending(current) is true, so that a task that is
already being killed (e.g. by a userspace low-memory killer) isn't
stuck retrying reclaim on its way out. The resulting -ENOMEM from
dmabuf->ops->vmap() is expected behaviour in that case, not a bug in
the exporter -- and it is far from the only way ops->vmap() can
legitimately fail (an exporter may just as well refuse to vmap a
buffer for other, unrelated reasons of its own).

This is exactly the kind of condition Documentation/process/coding-style.rst
warns against for WARN*():

    WARN*() must not be used for a condition that is expected to
    trigger easily, for example, by user space actions.

A failing vmap() is reachable purely by driving the system into low
memory and then issuing an ioctl that happens to map a dma-buf -- no
driver misbehaviour required. Turning that into a WARN_ON_ONCE(),
and on panic_on_warn kernels into an outright panic, doesn't help
debugging; it just turns an otherwise-recoverable error into a fatal
one.

Drop the WARN_ON_ONCE() and simply propagate the error, consistent
with how other allocation-failure paths in the kernel are handled.
The dma_buf_vmap_unlocked()/dma_buf_vmap() contract is unchanged:
both still return the negative errno from dmabuf->ops->vmap() to the
caller. Only the WARN_ON_ONCE() splat (and, transitively, the panic
on panic_on_warn kernels) is removed.

Signed-off-by: Janghyuck Kim <janghyuck.kim@samsung.com>
---
 drivers/dma-buf/dma-buf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
index 36cdc342627e..252495761a21 100644
--- a/drivers/dma-buf/dma-buf.c
+++ b/drivers/dma-buf/dma-buf.c
@@ -1670,7 +1670,7 @@ int dma_buf_vmap(struct dma_buf *dmabuf, struct iosys_map *map)
 	BUG_ON(iosys_map_is_set(&dmabuf->vmap_ptr));
 
 	ret = dmabuf->ops->vmap(dmabuf, &ptr);
-	if (WARN_ON_ONCE(ret))
+	if (ret)
 		return ret;
 
 	dmabuf->vmap_ptr = ptr;
-- 
2.34.1

