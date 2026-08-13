Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30913C5CFDB
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 18:33:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 953CA10F4C9;
	Thu, 13 Aug 2026 18:33:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kaitmazov.com header.i=@kaitmazov.com header.b="H1OXUkxB";
	dkim-atps=neutral
Received: from mta0.migadu.com (out-105.mta0.migadu.com [91.218.175.105])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C59B10F4CA
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 18:33:38 +0000 (UTC)
X-Envelope-To: dri-devel@lists.freedesktop.org
DKIM-Signature: a=rsa-sha256; bh=7KtavsBAYZZgtG94hBCiuH8I75lc2MLciVw0wSBM7K0=; 
 c=simple/simple; d=kaitmazov.com;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786646016; v=1; x=1787250816;
 b=H1OXUkxBbP8weOZck+A1UVW5w0OQo05LtrumRPrX7EDCtaFAAovvE+NKNTRQuJ+G8tH8oAdU
 KHeZ3zhnivRwHKMJCKDsgr/2zUHZj/YzLlv2heZ9uhlhdRRyhEOcA5FZGEta2/u/B0XckCspymA
 lS5ggIGpNXH/ir4fiH2v/h/8y6yTIYgqxeyJfzjx71iWvJUS//nVPqKnDXxkDZpFuDTnDeE5AK1
 fZHpWXuDDd29bx2m12zy/rTNYIMf/sNRi/6gpjItOKq+HljNYaBuP9UD2V7vGeKCTQrKs0dKteI
 v4L+Yi3hwlqb1pGuvmEZ7IyubsBXH87iGNhgYVwaUgw2w==
X-Envelope-To: dri-devel@lists.freedesktop.org
Received: from cachyos-26.lan (193.42.111.69)
 by smtp.migadu.com with ESMTPS id 6ca3d1c1ef0972b6;
 Thu, 13 Aug 2026 18:33:36 +0000
X-Migadu-Flow: FLOW_OUT
From: Taimuraz Kaitmazov <taimuraz@kaitmazov.com>
To: dri-devel@lists.freedesktop.org
Subject: [PATCH v3 2/3] accel/amdxdna: return early from a zero-length flush
Date: Thu, 13 Aug 2026 21:33:17 +0300
Message-ID: <20260813164700.43960-3-taimuraz@kaitmazov.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260813164700.43960-1-taimuraz@kaitmazov.com>
References: <20260813164700.43960-1-taimuraz@kaitmazov.com>
MIME-Version: 1.0
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

SYNC_BO does not constrain its size, so a request for zero bytes reaches
amdxdna_flush_bo(). On the vmap path that calls drm_clflush_virt_range()
with a length of zero, which flushes the byte in front of the region
rather than anything the caller asked to maintain; on the import path it
flushes the whole scatterlist, since that arm ignores the range.

Nothing needs flushing for an empty range, so answer before choosing a
path.

Signed-off-by: Taimuraz Kaitmazov <taimuraz@kaitmazov.com>
---
 drivers/accel/amdxdna/amdxdna_gem.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/accel/amdxdna/amdxdna_gem.c b/drivers/accel/amdxdna/amdxdna_gem.c
index b66ec9e4828..813b212a53f 100644
--- a/drivers/accel/amdxdna/amdxdna_gem.c
+++ b/drivers/accel/amdxdna/amdxdna_gem.c
@@ -1232,6 +1232,9 @@ static int amdxdna_flush_bo(struct amdxdna_gem_obj *abo, u64 offset, u64 size)
 		return -EINVAL;
 
 	size = min(abo->mem.size, end) - offset;
+	if (!size)
+		return 0;
+
 	if (is_import_bo(abo))
 		drm_clflush_sg(abo->base.sgt);
 	else if (amdxdna_gem_vmap(abo))
-- 
2.55.0

