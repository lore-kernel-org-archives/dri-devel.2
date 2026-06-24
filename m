Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F896CDE002
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 07:03:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D3EE310F137;
	Thu, 25 Jun 2026 07:03:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="c1pq4YPQ";
	dkim-atps=neutral
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 35DD110F017
 for <dri-devel@lists.freedesktop.org>; Wed, 24 Jun 2026 18:56:15 +0000 (UTC)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-490ace40f4bso14204965e9.3
 for <dri-devel@lists.freedesktop.org>; Wed, 24 Jun 2026 11:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782327373; x=1782932173; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=lhVt2J9kxRnCfR4wNcazQj8MApDZVyZIUNbf0hyt/Lw=;
 b=c1pq4YPQSXY7P93JKLuD2V0asdPZkRmMtwj0IQ6xVrBmIO6rf+Feag2AJBxaclr+RB
 lPQCudy5YTwVvuo9siomOPTMeg2K3T65cxDgZT/jTiiBk4mljypO5MD22G8CxCtTDEoM
 Gxfsz+9fx4Yltxz1qRronxulEKjPnN8tljKZUHPm1U6h4rpb11s697xW4l/i+/1ykO8/
 aDMiundFZWZxpYQHlDNeNiJknzCN9ihRaNF9+lUxYuGhgi+ntrUxkTIPbQ0hpPeZ4E0K
 LFuLiJ6p0XhwbYzGd8qeMVb/gDy6DKgxsiJLWdosPSQ/eLrQZWRbOA2XJQNPfjPvFE0Y
 klxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782327373; x=1782932173;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lhVt2J9kxRnCfR4wNcazQj8MApDZVyZIUNbf0hyt/Lw=;
 b=TepjiafvvQSFNoj/fBAulmfnPmXePGITUZf3SpUkn956rVonnGuR/DJQeT8EjmMsUq
 IaR59ok3lBSB61ELmuhgl3q+x0JJrXeR5mlIK8pkBNYDl6Vo/E9ypWMnzZ8bNC5FfkPX
 dld2Tv9kgctlTU1wtv8PiOyY5XpfgENQ28aWzzRPVxe2drAUL8k7KTMBd9hD36cd+9N8
 DNvKsF9FSAuFfQNe+BXvxJQqR4qOKv/zYvpaLX1CimZgVLdEJSHQHoMjs1m46Y9qzrD4
 50IwV/tfCwf1Z4ESzc+AU5TbIEyfQVy7bxGoal0T73djWhgJMthr0GNPro8cPpGrpins
 cYKw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9h4e0Y20edFm4I4TlTO2VCffzghdQ68wpDBarkb41Vem4ncJ4Z+RsE4t1917p9gjpBQs4V4cSWkIE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyT936Alqiw1CivO5QFz/Havijs2JHeluyE2DdYeK+S4iRKfUFf
 8fQ7D0CB0EUHvOyPD6Lv/UYEEdlHxDaKDgZHo88S7JSZF2eNYfLw959A
X-Gm-Gg: AfdE7ckf0tZ07b1kSrZXlfiX8yvyo0niuFKi+h/22fJg23CpeOrbM6Sr0Wkc3BJiM3U
 9Fv1FQvP7ReEVqN//T0UCwJqEyU/vM8bDEdWv/aqW0lx0TawnMAWgwpNcwqI/rg5+hAMMkt06gE
 dFmtEjgbcx7zgAYHBwVqbrQZalAWfgDfU61o8YctEKYat4NNBGC29Bz9z+ivCqza7a2zEBaji4s
 1e/TszyHA55IPaZNRJVywOFvhOae32/ua01s9Sdcy7xNcLb0FHAH1vqBybGhHBEy3ziekLN2uIQ
 akazVUI2WGSCaI4HIiy5MdVrk2nJgqy7ewRLayFSHKRe/wBK8J80+dlxaHgW4BA4WLlaV14iecV
 NvlxXlhXbOu0OblPT/VnAnVZTbjz2QGzT0s5uoOznAgXGVnE0VYWCePqiuqGAqW/NFX1BoTsCor
 0+rNfFIzguNhc7f1Q6kimooOR4iA==
X-Received: by 2002:a05:600c:5298:b0:490:bad9:de43 with SMTP id
 5b1f17b1804b1-49264821ab4mr7006525e9.0.1782327373304; 
 Wed, 24 Jun 2026 11:56:13 -0700 (PDT)
Received: from Dev-Null-MSI ([2a0d:3344:52ac:a808:98a4:4381:be45:536f])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4926401a2dasm12122375e9.2.2026.06.24.11.56.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jun 2026 11:56:12 -0700 (PDT)
From: Yousef Alhouseen <alhouseenyousef@gmail.com>
To: Srinivas Kandagatla <srini@kernel.org>,
 Amol Maheshwari <amahesh@qti.qualcomm.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Yousef Alhouseen <alhouseenyousef@gmail.com>
Subject: [PATCH] misc: fastrpc: reject oversized inline invoke payloads
Date: Wed, 24 Jun 2026 20:55:49 +0200
Message-ID: <20260624185549.1669-1-alhouseenyousef@gmail.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 25 Jun 2026 07:03:17 +0000
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

fastrpc_get_args() computes inline payload spans from 64-bit user
buffer ranges, but stores each span in an int before comparing it with
the remaining DMA buffer space.

A large span can truncate before the bounds check and advance the DMA
write cursor by the wrong amount. Keep the span 64-bit and fail the
invoke when the serialized payload would exceed the buffer.

Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>
---
 drivers/misc/fastrpc.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 42fc128e1..8dd8315d5 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -1079,7 +1079,7 @@ static int fastrpc_get_args(u32 kernel, struct fastrpc_invoke_ctx *ctx)
 	ctx->rpra = rpra;
 
 	for (oix = 0; oix < ctx->nbufs; ++oix) {
-		int mlen;
+		u64 mlen;
 
 		i = ctx->olaps[oix].raix;
 		len = ctx->args[i].length;
@@ -1119,8 +1119,10 @@ static int fastrpc_get_args(u32 kernel, struct fastrpc_invoke_ctx *ctx)
 
 			mlen = ctx->olaps[oix].mend - ctx->olaps[oix].mstart;
 
-			if (rlen < mlen)
+			if (rlen < mlen) {
+				err = -EOVERFLOW;
 				goto bail;
+			}
 
 			rpra[i].buf.pv = args - ctx->olaps[oix].offset;
 			pages[i].addr = ctx->buf->dma_addr -
-- 
2.54.0

