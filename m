Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E248C5CFDB
	for <dri-devel@archiver.kernel.org>; Tue, 11 Aug 2026 23:22:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 933F310E3B5;
	Tue, 11 Aug 2026 23:22:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kaitmazov.com header.i=@kaitmazov.com header.b="E6TylQbZ";
	dkim-atps=neutral
Received: from out-171.mta1.migadu.com (mta1.migadu.com [37.59.57.117])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8538610E3C1
 for <dri-devel@lists.freedesktop.org>; Tue, 11 Aug 2026 23:22:32 +0000 (UTC)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kaitmazov.com;
 s=key1; t=1786490068;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RhPiTO5hHmMsbplOE4VZhjPCewyKBwHlOk0RsTNLVB8=;
 b=E6TylQbZindhqfI4pmIhNsvonbf3geun5aX31jIMCK1EX79SbLcfK86fAKGmSDft/X0tPe
 R3MXieAHQsA6VPTzoxD8M4Q4PRwvlxVEKk09HhSe7MzU98RrZBK669qD2nG1KJRD3vDFP9
 WrNu1vgAg6dbBQjqIXwNFtF5GRVtdcqFTzxGDbemWLV2qxyFQcD+x7Ek9qwdmu3QN03Rja
 RHkoz9eoGPo7MLq8rrD38pv8nd2/5J2hHrA60NL8FNBuPcPcr55UJkmHflTq9BVcbDl2co
 0ZhadOtH/ybUw2yl3/e6K0cv5MJ0UFjsCwbxSadwGXhFIzK9J0cijU+f6+L6eQ==
From: Taimuraz Kaitmazov <taimuraz@kaitmazov.com>
To: mamin506@gmail.com,
	lizhi.hou@amd.com,
	ogabbay@kernel.org
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 sumit.semwal@linaro.org, christian.koenig@amd.com,
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
 Taimuraz Kaitmazov <taimuraz@kaitmazov.com>
Subject: [PATCH v2 3/5] accel/amdxdna: return early from a zero-length flush
Date: Wed, 12 Aug 2026 02:13:49 +0300
Message-ID: <20260811231351.1011244-4-taimuraz@kaitmazov.com>
In-Reply-To: <20260811231351.1011244-1-taimuraz@kaitmazov.com>
References: <20260811231351.1011244-1-taimuraz@kaitmazov.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
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
amdxdna_flush_bo() and, on the vmap path, calls drm_clflush_virt_range()
with a length of zero. That helper flushes the line at end - 1 to
serialise, which for a zero length is the byte in front of the region
rather than anything the caller asked to maintain.

Nothing needs flushing for an empty range, so answer before choosing a
path.

Signed-off-by: Taimuraz Kaitmazov <taimuraz@kaitmazov.com>
---
 drivers/accel/amdxdna/amdxdna_gem.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/accel/amdxdna/amdxdna_gem.c b/drivers/accel/amdxdna/amdxdna_gem.c
index 1b8e90cd7..7df4bbb16 100644
--- a/drivers/accel/amdxdna/amdxdna_gem.c
+++ b/drivers/accel/amdxdna/amdxdna_gem.c
@@ -1244,6 +1244,9 @@ static int amdxdna_flush_bo(struct amdxdna_gem_obj *abo, u64 offset, u64 size)
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

