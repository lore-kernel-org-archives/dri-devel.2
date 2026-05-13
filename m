Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A423CD4F21
	for <dri-devel@archiver.kernel.org>; Wed, 13 May 2026 20:57:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA37410F080;
	Wed, 13 May 2026 20:57:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=baidu.com header.i=@baidu.com header.b="WGjws5gg";
	dkim-atps=neutral
X-Greylist: delayed 484 seconds by postgrey-1.36 at gabe;
 Wed, 13 May 2026 11:45:55 UTC
Received: from outbound.baidu.com (mx24.baidu.com [111.206.215.185])
 by gabe.freedesktop.org (Postfix) with SMTP id D7CF789153;
 Wed, 13 May 2026 11:45:55 +0000 (UTC)
X-MD-Sfrom: lirongqing@baidu.com
X-MD-SrcIP: 172.31.50.47
From: lirongqing <lirongqing@baidu.com>
To: Matthew Brost <matthew.brost@intel.com>,
 =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Matthew Auld <matthew.auld@intel.com>,
 <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>
CC: Li RongQing <lirongqing@baidu.com>
Subject: [PATCH] drm/xe: Fix operator precedence bug in emit_flush_invalidate
Date: Wed, 13 May 2026 07:37:25 -0400
Message-ID: <20260513113725.2313-1-lirongqing@baidu.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.31.63.8]
X-ClientProxiedBy: bjkjy-exc3.internal.baidu.com (172.31.50.47) To
 bjkjy-exc3.internal.baidu.com (172.31.50.47)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=baidu.com;
 s=selector1; t=1778672268;
 bh=F3H1X2KRrTmbZ2l6IxWOwM+uPgbxIffYhwH97fCACPs=;
 h=From:To:CC:Subject:Date:Message-ID:Content-Type;
 b=WGjws5ggI/VrzHpQG37tD+ckHrQjoYU4K3IZ+uyMRuDZnSwUDhIZBSTVE6Xp8hnRB
 Q5trHez1m+ZCOES7t4j54XnixB9F4F3L/BgNeiLMmTeLSHsZ+k/eKm/LhU5XDC8TR6
 SFnylc3WfVC0EZncxRLtWqQR2QUr0rQGDgzPp3WWye3WR/1UiDtG4Z2oHJK6TDpCYh
 3v805b66VSwdqwL9BnApJ/ZIUhT1/NeIfIEzWEG12/QUtkWuam/tr5F97ogfqHk8yQ
 SKLI3aAeAD3Uqw78FSGyi5UiGcwGNH5xtD0O2qVQ7GIbISdvp88bB5nHp7nrpFKjIr
 Y4ETknN0IxjgQ==
X-Mailman-Approved-At: Wed, 13 May 2026 20:57:01 +0000
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

From: Li RongQing <lirongqing@baidu.com>

The expression:
    MI_FLUSH_IMM_DW | (flush_flags & MI_INVALIDATE_TLB) ?: 0;

is parsed as:
    (MI_FLUSH_DW | MI_FLUSH_DW_OP_STOREDW | MI_FLUSH_IMM_DW |
     (flush_flags & MI_INVALIDATE_TLB)) ?: 0;

Since the combined constant flags are always non-zero, the GNU extension
'?: 0' acts as a no-op and does not change the value. Remove this redundant
and confusing logic.

Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
 drivers/gpu/drm/xe/xe_ring_ops.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_ring_ops.c b/drivers/gpu/drm/xe/xe_ring_ops.c
index cfeb4fc..ee468d3 100644
--- a/drivers/gpu/drm/xe/xe_ring_ops.c
+++ b/drivers/gpu/drm/xe/xe_ring_ops.c
@@ -144,7 +144,7 @@ static int emit_bb_start(u64 batch_addr, u32 ppgtt_flag, u32 *dw, int i)
 static int emit_flush_invalidate(u32 addr, u32 val, u32 flush_flags, u32 *dw, int i)
 {
 	dw[i++] = MI_FLUSH_DW | MI_FLUSH_DW_OP_STOREDW |
-		  MI_FLUSH_IMM_DW | (flush_flags & MI_INVALIDATE_TLB) ?: 0;
+		  MI_FLUSH_IMM_DW | (flush_flags & MI_INVALIDATE_TLB);
 
 	dw[i++] = addr | MI_FLUSH_DW_USE_GTT;
 	dw[i++] = 0;
-- 
2.9.4

