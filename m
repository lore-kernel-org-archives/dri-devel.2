Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4663F10F2862
	for <dri-devel@archiver.kernel.org>; Fri, 27 Mar 2026 18:47:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E58310ED13;
	Fri, 27 Mar 2026 18:47:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="TrdolQ4+";
	dkim-atps=neutral
Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com
 [136.143.188.94])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6694610ED13
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 18:47:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1774637264; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Wa0Z53itwQFqASrzKx8rouFn/yL36+kjWbjuYLxvYg15Ec0p/u7DRq+EXAI8A1Fs4oCA267gwiZyfK7vuOAvGmTVdGumQbM17ythpYXPd4nEc1sBI7Zt/YHCoM3Cj6VEccYu/v8ZOnNT+5OUdRR/nvGFgLhc0tb+3Xe9H/28VoE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1774637264;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=Y7oh+a8faCMP0nn2EAP8q8UOeOBQTSgBhDx/Ls2KJr4=; 
 b=mFu5RJfqmq8TW6AP01Jkd3/fYIzSKEqEv2aotQIzFEci0/6RPYRqO1INbwb+zGqkSk4HeeIUxXltJ7MmG/BrK0Oe+NxHMhOyFuqmjvn2Os+49LWaUxZIzasGtynoIfVjOhsdB53lUIWlIcSYNy7xNodp9D5theO/DMbBkiCpE6g=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=zohomail.com;
 spf=pass  smtp.mailfrom=ming.li@zohomail.com;
 dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1774637264; 
 s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:To:To:Cc:Cc:Feedback-ID:Reply-To;
 bh=Y7oh+a8faCMP0nn2EAP8q8UOeOBQTSgBhDx/Ls2KJr4=;
 b=TrdolQ4+1rO+JaByD0f/IPjIlmPfiouYzZCe/we3b/YH3rcNmJnb4b47PrV2INB4
 T4u9GlEacILLaMlo+porIHSCdZ/S6+h6hHYbQHXwSxn7nXcSEMz6t9ajNsvb0ZCO5m+
 V5St6yxmPuhoD96nPCwe8YKf2w7aw5yRuxKslb2Q=
Received: by mx.zohomail.com with SMTPS id 1774637262091797.4127866298093;
 Fri, 27 Mar 2026 11:47:42 -0700 (PDT)
From: Li Ming <ming.li@zohomail.com>
Date: Sat, 28 Mar 2026 02:47:24 +0800
Subject: [PATCH RESEND] dma-fence: Dereference correct dma_fence in
 dma_fence_chain_find_seqno()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260328-fix_dma_fence_chain_find_seqno-v1-1-3847c8ef0292@zohomail.com>
To: Sumit Semwal <sumit.semwal@linaro.org>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Lionel Landwerlin <lionel.g.landwerlin@intel.com>
Cc: =?utf-8?q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>, 
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org, 
 Li Ming <ming.li@zohomail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774637259; l=1233;
 i=ming.li@zohomail.com; s=20260210; h=from:subject:message-id;
 bh=+zLhFjmQDcbbt7AWjLmj5y51IOac2tCxLouPPcLnI8s=;
 b=HFIUy3+KdDFXVMti/Ga/SxpCMQOaEDfvxnCIt8Wj8X+yVkCUbfSkpmZieZXXc00RDhKtIUJFF
 AK+F53ygqNLCK2Y1OKwgzSKCdvD+AAwqB3RUtIDzRal2eXT4qjI8hew
X-Developer-Key: i=ming.li@zohomail.com; a=ed25519;
 pk=JfhrdHjyYJMXt47Hy8d/fsqZuhGPD4Z3whV5lTfVvhE=
Feedback-ID: rr08011228b211dd271431ffbf402eaf1e0000b83e2267d51a1f7e34f210ea5ac143badbbdb7ca67a49d823375:zu0801122773f2ec82482f97e6caa0fb030000c3261d8540fa7ed02b3199d1d6543ffa4200911cde1f047276:rf0801122d2538852d2bc1da22113372b30000278184736ab56759343bdfb987b5b1873b0691eb11ba36abdbe3fcf81e8b24:ZohoMail
X-ZohoMailClient: External
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

dma_fence_chain_find_seqno() uses dma_fence_chain_for_each() to walk a
given dma_fence_chain. dma_fence_chain_for_each() always holds a
reference for the current fence during iteration. The reference must
be dropped after breaking out. Instead of dereferencing the last fence
as intended, dma_fence_chain_find_seqno() incorrectly dereferences the
first fence in the chain.

Fixes: 7bf60c52e093 ("dma-buf: add new dma_fence_chain container v7")
Signed-off-by: Li Ming <ming.li@zohomail.com>
---
 drivers/dma-buf/dma-fence-chain.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma-buf/dma-fence-chain.c b/drivers/dma-buf/dma-fence-chain.c
index a8a90acf4f34..71fa173aef13 100644
--- a/drivers/dma-buf/dma-fence-chain.c
+++ b/drivers/dma-buf/dma-fence-chain.c
@@ -103,7 +103,7 @@ int dma_fence_chain_find_seqno(struct dma_fence **pfence, uint64_t seqno)
 		    to_dma_fence_chain(*pfence)->prev_seqno < seqno)
 			break;
 	}
-	dma_fence_put(&chain->base);
+	dma_fence_put(*pfence);
 
 	return 0;
 }

---
base-commit: c369299895a591d96745d6492d4888259b004a9e
change-id: 20260327-fix_dma_fence_chain_find_seqno-7adea64efe01

Best regards,
-- 
Li Ming <ming.li@zohomail.com>

