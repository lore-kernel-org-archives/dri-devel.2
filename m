Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1FE7FF8855
	for <dri-devel@archiver.kernel.org>; Tue,  5 May 2026 22:27:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0472910E488;
	Tue,  5 May 2026 22:27:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=broadcom.com header.i=@broadcom.com header.b="RciFzWXL";
	dkim-atps=neutral
Received: from mail-dy1-f228.google.com (mail-dy1-f228.google.com
 [74.125.82.228])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C8F0A10E483
 for <dri-devel@lists.freedesktop.org>; Tue,  5 May 2026 22:27:52 +0000 (UTC)
Received: by mail-dy1-f228.google.com with SMTP id
 5a478bee46e88-2f03d6cf77bso4169349eec.0
 for <dri-devel@lists.freedesktop.org>; Tue, 05 May 2026 15:27:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778020072; x=1778624872;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zUzPAGUmnW9nuYsWnE/ryysW/QEIR4wcMfsbCfzx84w=;
 b=H6qXfjJglTqUvvhdO3WcfpxyZFOspDAiDOnNshSe8BzXeTyUzeyYmhFJIjDHNKGoTF
 TRSdmZZHgw/hyg8lYzs4D2GQM3QlUvBCYFE5oShDRpa4S1wcjSFN/F2wLGC9OLSAUuzW
 2TiEaQAc1+FCHega0w2tvUN+dV7XTfyIL0LjR/MdHoedHqHkU8DR9QNrh9/UOMpac9D2
 fcK2Z6aGRcCCaO1C8h4Iuc1pObUUeKQYMOxzPglxfev3vYstB/SCcFv5Xr6eQBmqggqB
 brdQhLn67ENA/peW03opy+Bt5OencTDvg8n08k40tZuyQNecIaPSqWA4U9mQmAQ3W3R7
 O2oA==
X-Gm-Message-State: AOJu0Ywc3T/dPSO2pwU2XQ8Il9yB/v/OT/yUscS5npiiMmJu4sOqpuI1
 pBCrTgqBoi5JFzGmavOXNsOcKau6qs+P4823xlhK7VDEi51A9w7VefZgyxGYB/s9GWjTU6ev9dT
 baoOcxmYQqtQ/c+8bjPlqhrcX8BYW9ER5P+ghcmdGcFtrPLtqpKha6RgPiVCiTkiA+wwXcniJlM
 ZMMrNapwHuZZA6svJ3NFDx0PYmOgvkvbApffaAxjU6YOK5/aGkAIxjUSG7imqkKglz6+mzydDcu
 HqpVAk2vIJoML6ZNj8q
X-Gm-Gg: AeBDietQ5t3NvxhYZ7fSU7U/DTbFFYYpB1vqUyVQp/6YEIogajdUbbHmeLf423LBnjB
 y+5qxYAx3AFzARDvtv2HPHlRSNxAWVnpWdOhIkxxVp0Mvaah4ILNZ1duwNtpNzCEiyTxoTJ+g6p
 RXYkb+qdCgZlaU6q/lAgwcgDJYSwLHBQe7zH+xEF8NabxqQLO+spGTdH+0pMlrLVMrPj2XWwxzY
 o+4/Qot8A2iE0r2ePf6hethDBXn1cboMOlw+4e+FsUMnUN0r+8pbQ8kumhWghz135y73SlWzZ4F
 GzwERgxMXrXDw+LT0EnS4IFFRBB8tVZEecRke2fEz5PlxzI8rhg25c45juqyb6MTFBCTiEs/bbZ
 HNjxBPS70gkmC5gEEDo9+0byFEjkKkqlajWKgxj6EWlOzxcek2Z3xQlCeX8sDX67R3BbMkM+Vrb
 +yV/2x7Ak8QI++5e/G6aKow6Amyh96cdw59/ZywbIZf45XMKGoopq8oCXvntC4IycZ
X-Received: by 2002:a05:7300:a507:b0:2d9:db50:c6a5 with SMTP id
 5a478bee46e88-2f544bea5c1mr755864eec.0.1778020071546; 
 Tue, 05 May 2026 15:27:51 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-16.dlp.protect.broadcom.com. [144.49.247.16])
 by smtp-relay.gmail.com with ESMTPS id
 5a478bee46e88-2f56d8bf736sm36339eec.7.2026.05.05.15.27.49
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 05 May 2026 15:27:51 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-8aca14d1faaso223880956d6.3
 for <dri-devel@lists.freedesktop.org>; Tue, 05 May 2026 15:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1778020068; x=1778624868;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zUzPAGUmnW9nuYsWnE/ryysW/QEIR4wcMfsbCfzx84w=;
 b=RciFzWXL2vQvsgBo0PiZtoVDq64KyP96kn6YULlFYPPH2bVc1+AXwVHARlhWPFPPMH
 cOvNNkzdrZhdQaIppRxZpPwxfhZ0ulI0kfZ33UIl5EndEJWJ1TVhfffiDBD5IM0ND/pg
 EABuIOlmyPFlpYRWcLQ6ergF0Ryh+Mi5joV/Q=
X-Received: by 2002:a05:6214:450c:b0:8a1:478a:e580 with SMTP id
 6a1803df08f44-8bc422a64f8mr10868286d6.8.1778020068003; 
 Tue, 05 May 2026 15:27:48 -0700 (PDT)
X-Received: by 2002:a05:6214:450c:b0:8a1:478a:e580 with SMTP id
 6a1803df08f44-8bc422a64f8mr10867776d6.8.1778020067409; 
 Tue, 05 May 2026 15:27:47 -0700 (PDT)
Received: from vertex.localdomain
 (pool-173-49-113-140.phlapa.fios.verizon.net. [173.49.113.140])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8b539aa6f5fsm162692886d6.21.2026.05.05.15.27.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2026 15:27:46 -0700 (PDT)
From: Zack Rusin <zack.rusin@broadcom.com>
To: dri-devel@lists.freedesktop.org
Cc: ian.forbes@broadcom.com, maaz.mombasawala@broadcom.com,
 Zack Rusin <zack.rusin@broadcom.com>, stable@vger.kernel.org
Subject: [PATCH 03/12] drm/vmwgfx: clamp dirty-page range with min, not max
Date: Tue,  5 May 2026 18:22:24 -0400
Message-ID: <20260505222728.519626-4-zack.rusin@broadcom.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260505222728.519626-1-zack.rusin@broadcom.com>
References: <20260505222728.519626-1-zack.rusin@broadcom.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
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

vmw_bo_dirty_transfer_to_res() and vmw_bo_dirty_clear() compute the
intersection of a resource's page range with the BO's tracked dirty
range, but clamp res_end against dirty->end with max() instead of
min().  When dirty->end exceeds the resource end, the loop walks past
the resource's pages, calls vmw_resource_dirty_update() for ranges
owned by other resources sharing the same backing MOB and clears
their pending dirty bits via bitmap_clear().  The result is silent
loss of writeback for unrelated resources whenever two resources
share a MOB.

Use min() in both functions so the loop is bounded to the
intersection of the resource and dirty ranges.

Fixes: b7468b15d271 ("drm/vmwgfx: Implement an infrastructure for write-coherent resources")
Fixes: 965544150d1c ("drm/vmwgfx: Refactor cursor handling")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4.7
Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_page_dirty.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_page_dirty.c b/drivers/gpu/drm/vmwgfx/vmwgfx_page_dirty.c
index 45561bc1c9ef..8ab88f388652 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_page_dirty.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_page_dirty.c
@@ -311,7 +311,7 @@ void vmw_bo_dirty_transfer_to_res(struct vmw_resource *res)
 		return;
 
 	cur = max(res_start, dirty->start);
-	res_end = max(res_end, dirty->end);
+	res_end = min(res_end, dirty->end);
 	while (cur < res_end) {
 		unsigned long num;
 
@@ -347,7 +347,7 @@ void vmw_bo_dirty_clear(struct vmw_bo *vbo)
 		return;
 
 	cur = max(res_start, dirty->start);
-	res_end = max(res_end, dirty->end);
+	res_end = min(res_end, dirty->end);
 	while (cur < res_end) {
 		unsigned long num;
 
-- 
2.51.0

