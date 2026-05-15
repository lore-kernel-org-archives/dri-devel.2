Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43B2BCD4F25
	for <dri-devel@archiver.kernel.org>; Fri, 15 May 2026 13:59:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A0F1D10E611;
	Fri, 15 May 2026 13:59:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=bitbyteword.org header.i=@bitbyteword.org header.b="jr1nm1Mi";
	dkim-atps=neutral
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com
 [209.85.222.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C5C3110E611
 for <dri-devel@lists.freedesktop.org>; Fri, 15 May 2026 13:59:33 +0000 (UTC)
Received: by mail-qk1-f178.google.com with SMTP id
 af79cd13be357-90ea08cc5ceso562330685a.2
 for <dri-devel@lists.freedesktop.org>; Fri, 15 May 2026 06:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bitbyteword.org; s=google; t=1778853573; x=1779458373;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=okrIOhQe2ZLHKZjZRr+SV2MUNrdUF09nc7mShRbgYsc=;
 b=jr1nm1MimyoTld660IPMZ4T4BYyPidn1okK8C6g45XheeOb2l9GfSXya2vU6PnMGxb
 vcmBOOgkQYDNU3XxEeVLvHSpsVUNX13S+cWtEP2Nk60tXKRNq03zry7j3PkxiCYCzgPI
 v4LgqpT952GSrZ6J4nub224jOBVjIBaX95ozLlluR/ghIq1cAWqRiEKW+plm7HmhqZcZ
 NfKhxjHeW/TzIHK2EYNu1KPgGqodtzVm+6L/WDFACxIZC5eqJ//dY0TZp39FO31iAyWT
 Oht4kHiSZdAVPOFgbzsPlVnic0HvVb5/AjFpbd38flwST49x9vk+qDQStoanrbY3nb6W
 wW9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778853573; x=1779458373;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=okrIOhQe2ZLHKZjZRr+SV2MUNrdUF09nc7mShRbgYsc=;
 b=r6sj2AlOkLlunBrtikmymw+MEpg7C/vrCnUOqUHw2OMye48BW0S9BQMwHZQbSedgda
 sdhw7JoptKLUOaLKE5phSdfwMNj/EDWaBNT742V85Jn1hql6dh/ha00AdWNpZKjWI8nB
 f30zzWINjoQYP81Mp1lfNdou2ZziaG6HrQkOa3s98J7PSKj5alrpA4eQD42dGEwn7NRO
 r4m3TQiIUINQKl9vjHL/x74/O1FMGG7hHHbwh7L46KXEfBM61xQx9O4qbiNpUYtAYJe4
 Zpq8HtEyFc3OxvHpNGkMKO3sTSWgRldv0mVpUglK4IQyrlsvyyxPnkX1K5lqLIlJ9Lu3
 ijGA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/80hjdJ8mRmxyxio5evZ6Ba4boK+hIyGjqIM7ji9dV5AQSrXP+oY+pBw9H+npYdYovv4y/yrTjH1g=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwZvA9L1OpPPXTa5D7qxAk7AU0eGEdGIqpD9MM/PxHuaaiL41fQ
 iNOu1YrTELVTMM25NdRytZhnvvlJgPUvzS0GmefCxSH1g//yjjV4iy5y/JlZaMlcAbI=
X-Gm-Gg: Acq92OG+KVS6IPwpbr2wQ8KRCTksvyPkUfnHXKXEb4TPBDLABlXmgzkkwXVH+n8e3/B
 dmmO/wNhe558I+i6mpGPswYKWlvx3uymocR6gSFSojaCUZMgMKUuHH7pIpj8+bF9oAohadFvjZ1
 DDXxSHwfBaPRElT+56irMubYBuFCNTs1g1Ze5nB3HNa3X+ewBeCFHlnWnSiT/9Ttl5E/8Qay7Pj
 kRARjAzGXfoFbEFfUFmsqQLltRv8OxAMm1Z4VlqOcY3JjdiyARDug4bmfD2M6Q5LNt0lZVlmMAg
 9jrVOHkPhyV3sDOPV7tswJVMla6XqQAiJb1TXmq6pAE07ZkV5V1pwVq2xm/kezFIXq4z73xINNk
 6FwG1EMx+4ieapX3eMp+J+tobZRlHNE+ochpPu55UzbunvGFTWcY2ZxI7WQoHh2joCguYPF7jVe
 vjJSR9HWtMe0NQgDzCJqd6r5Ph2rIH
X-Received: by 2002:a05:620a:44c4:b0:910:3078:5cf6 with SMTP id
 af79cd13be357-911d02ad04cmr617447785a.44.1778853572241; 
 Fri, 15 May 2026 06:59:32 -0700 (PDT)
Received: from vinp2.lan ([2607:fb92:1900:6734:902:ab48:6190:9c1e])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-910bcf318e4sm535460585a.32.2026.05.15.06.59.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 06:59:31 -0700 (PDT)
From: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>
To: Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, Steven Rostedt <rostedt@goodmis.org>,
 linux-trace-kernel@vger.kernel.org,
 Vineeth Pillai <vineeth@bitbyteword.org>,
 Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v3 05/11] dma-buf: Use trace_call__##name() at guarded
 tracepoint call sites
Date: Fri, 15 May 2026 09:59:27 -0400
Message-ID: <20260515135927.2238823-1-vineeth@bitbyteword.org>
X-Mailer: git-send-email 2.54.0
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

From: Vineeth Pillai <vineeth@bitbyteword.org>

Replace trace_foo() with the new trace_call__foo() at sites already
guarded by trace_foo_enabled(), avoiding a redundant
static_branch_unlikely() re-evaluation inside the tracepoint.
trace_call__foo() calls the tracepoint callbacks directly without
utilizing the static branch again.

Original v2 series:
https://lore.kernel.org/linux-trace-kernel/20260323160052.17528-1-vineeth@bitbyteword.org/

Parts of the original v2 series have already been merged in mainline.
This patch is being reposted as a follow-up cleanup for the remaining
unmerged pieces.

Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Vineeth Pillai (Google) <vineeth@bitbyteword.org>
Assisted-by: Claude:claude-sonnet-4-6
---
 drivers/dma-buf/dma-fence.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma-buf/dma-fence.c b/drivers/dma-buf/dma-fence.c
index a2aa82f4eedd..a41cdd9c9343 100644
--- a/drivers/dma-buf/dma-fence.c
+++ b/drivers/dma-buf/dma-fence.c
@@ -553,7 +553,7 @@ dma_fence_wait_timeout(struct dma_fence *fence, bool intr, signed long timeout)
 	}
 	if (trace_dma_fence_wait_end_enabled()) {
 		rcu_read_lock();
-		trace_dma_fence_wait_end(fence);
+		trace_call__dma_fence_wait_end(fence);
 		rcu_read_unlock();
 	}
 	return ret;
-- 
2.54.0

