Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAFF4C56208
	for <dri-devel@archiver.kernel.org>; Thu,  6 Aug 2026 10:00:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 059A610E2B8;
	Thu,  6 Aug 2026 10:00:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DCV0VvdY";
	dkim-atps=neutral
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3962210E2DF
 for <dri-devel@lists.freedesktop.org>; Thu,  6 Aug 2026 10:00:01 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-495522bc0e2so614325e9.2
 for <dri-devel@lists.freedesktop.org>; Thu, 06 Aug 2026 03:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786010399; x=1786615199; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8102EMdRsA752wQbhXTdKaIRmXwR/nDaRkxmP1E6VH4=;
 b=DCV0VvdYMsaqd8YRqzANMEmeJsCCfRgDwX9p6A03qJeWVfze2oPaSwGlmocN/j21D5
 bft7GhGzx6hClGExmOsAwKsPyBnlOlCB9+TUvOKDUKQD0uGKSEh0qvmt1vIMo+GIfk1i
 dNXzMtcGUCHBc8N/GSZZPrqUbcjsirPewTNcr2XHpKcxqVSnguraaloEywvr4HAtw2aS
 0v6SG8Cxyjq0jSf00bAhemTxnd1GFRh5pgJH2kWfaWpvIGtH/L/XInSV1LleMxt87+Rb
 xHDVlFDBIi3+Uh56Bs6As7n4NuhEs646xU6nbM7Z2j4QLtWvbBWnW/0pxiOspb1frU7u
 EaAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786010399; x=1786615199;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=8102EMdRsA752wQbhXTdKaIRmXwR/nDaRkxmP1E6VH4=;
 b=As1qD8G4uz1ByuJd6wuAEge/zp+sK3PKyCz32kRh0jzWJaxh7ytHEO+Z6blJP4BhV2
 8eP9TQCDq2FO90Lm8WGPwfEynq8bBHjPA0uRMEOPrv4DrsiG1nj+/MDYktFoz7Dc64WZ
 40b0ouHVinlUVPYIft0tGkvHveDEYuyr7dfPUGZD2SZ13EYNuz9seu7c4VQPMjIGlDY6
 BYti/9duupQBWJNpT4VZzWuHiB+aZjmITr77+VY4p5iMt6jXccP0dOqYHLVGqjqaHZLq
 Jk6AKuoGDWNc9JcLAV0/qBbSX8PUy8EKpTgetZTTuz+QWWoTVFT/p2/PqpQ63N4eHUML
 u/5Q==
X-Forwarded-Encrypted: i=1;
 AHgh+Rrs4E6nRo8Oz0K9rUIF1OnudG8S8v2gvDCws2cCUiFoMIVW4Gy4Et7aH1qcSuUvJkQSxSytpAInaeg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz8XDSxrM5U7T8OR6LseoJWwiJpkfU8Cb1bcDd39X00/UMsAEtp
 8rODom+81/hdKMQPuvd7NkAd+463lVpkkquAxgOAGLRoyI5sAvZriYqz
X-Gm-Gg: AR+sD10W0tPMmtprhioVmui22Hh+ldJ0Vh9gYnDFwmuX0dJgQQn8Mq3BbOrzkMzO6Vd
 pEpjKiyCCOYO5dw6FDcOonHIui1HDWSBisfewHUpZ5rgVjIaz80kQz+73iSSCt6xlOrAsPzZ+0e
 lbcDm9nONFWlP83hgPiVsJiNxKi/aVcf6o2psq4v2EPd9B5Aroi1+ARtlrHIhkOAaRZxweOIA37
 +JbJ7uviy646yyvDxgqdx8CerHNzaP9HTvGwjKQAPy0eTAJh9UOWVs4tJcO4QMuDFmfWcRLbMS3
 8fnBOEFs24nDuVJtG0dfYv/Jglr6kcKIWTqNWwBQWNqPULgE0Nb4nAb5miv3oIzsX1kj+poPJ7N
 BbZDOXxlXbWOrdHklg28DyxnlsL6WSCsljGmQZI4Ik52GDl4gCaopPj8kadlcuak4OuMfu+tooV
 aDpFwN07si0QrTyl8X17yi/5KJU5B5tocsTq/wtWHtKWF4htM/IO190WY7VtzdW2gb41H9JGfHi
 LSQWlm0lC2w9bQaJ3FSClGYqM94qUl5nOUVHvtUYxvmLEgxhCKD9J37nHZfIt64Dg==
X-Received: by 2002:a05:600c:1393:b0:495:650b:4c61 with SMTP id
 5b1f17b1804b1-4994e7d0166mr98743685e9.3.1786010399195; 
 Thu, 06 Aug 2026 02:59:59 -0700 (PDT)
Received: from Neo.taile6b6ba.ts.net
 (ip-109-193-028-127.um39.pools.vodafone-ip.de. [109.193.28.127])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49954206d9dsm56510905e9.2.2026.08.06.02.59.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2026 02:59:58 -0700 (PDT)
From: Marek Czernohous <mczernohous@gmail.com>
To: nouveau@lists.freedesktop.org
Cc: Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] drm/nouveau: nv04 FIFO cleanup + recovery for Tesla
Date: Thu,  6 Aug 2026 11:59:57 +0200
Message-ID: <20260806095957.1908908-1-mczernohous@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260806085228.1848994-1-mczernohous@gmail.com>
References: <20260806085228.1848994-1-mczernohous@gmail.com>
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

Both findings are correct, thank you.

I checked them against mainline rather than against my downstream tree:

1) nouveau_channel_del() frees the fence context first and only drops the
   kill subscription later, among the nvif object teardown calls. The
   subscribed handler reaches nouveau_fence_context_kill(chan->fence), so
   a kill delivered in that window takes fctx->lock and walks
   fctx->pending on a context that context_del() has already freed.

2) nouveau_channel_init() arms the subscription right after mapping userd
   and creates the fence context at the end of the same function. The
   backends publish the pointer before the context is usable:

	fctx = chan->fence = kzalloc_obj(*fctx);
	if (!fctx)
		return -ENOMEM;

	nouveau_fence_context_new(chan, &fctx->base);

   and it is nouveau_fence_context_new() that runs spin_lock_init(&fctx->lock)
   and INIT_LIST_HEAD(&fctx->pending). The NULL check in
   nouveau_channel_kill() does not cover that window: chan->fence is
   non-NULL and unusable, so the handler locks something that was never
   initialised and walks a list head whose next pointer is still the NULL
   left by kzalloc().

Both are unreachable below Fermi today, which is exactly why they belong
in this series: 2/3 lowers the gate to NV50 and 3/3 adds the caller that
kills Tesla channels. This series is what makes them reachable, so
shipping it without them would trade a recoverable fault for a
use-after-free.

I should have carried the first one from the start. It has been running
on the reference machine since 2026-07-25, and my v2 cover letter
described that same ordering and then dismissed it as "most of that
window is harmless". That judgement was wrong.

v3 will put both in front of the subscription change, as 1/5 and 2/5,
with the remaining three unchanged apart from the rebase.
