Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02BDFC55173
	for <dri-devel@archiver.kernel.org>; Sat,  1 Aug 2026 19:43:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4ED4D10E38F;
	Sat,  1 Aug 2026 19:43:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bVQKXaNn";
	dkim-atps=neutral
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E8F7410E316
 for <dri-devel@lists.freedesktop.org>; Sat,  1 Aug 2026 12:11:33 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-496b7622a83so3794685e9.2
 for <dri-devel@lists.freedesktop.org>; Sat, 01 Aug 2026 05:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785586292; x=1786191092; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DOZGrUXGjxDGJTEIeB1H6x5d4O0bKmWClzqnhdgmKgE=;
 b=bVQKXaNnNL7rv5fPQFunGQezC2eGfTxGIvu6meWBdspwiLmv1Ra8v0so4Tej/YXGSK
 n1JsjC+i2ywXHzwj0ADpKI5RS0TAQ7jdjRQJGYmceMh1b3YB97bwB+G6Ynx/V3+m/bBx
 jVJJp5ATWnWb5LAi1Gvi4xlrMv8FqqwpNWsS2ZfR8feqqlsU+bO7zyFe59/5yJZxUAQT
 D5XEDWa+BgjLcfCSLVYyGi6F4lI+sWkEXnjADo6JafIdbRvDHvvDbGjS29GES3A92OAK
 dS9ZTl2UeVa+tmWCNJ4yzkoA/PldhU/BXkt5lmgmMcxrFNkJWkdxDudixWQyjBH4ZHPi
 TJbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785586292; x=1786191092;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=DOZGrUXGjxDGJTEIeB1H6x5d4O0bKmWClzqnhdgmKgE=;
 b=pPYK0wo4Ao38wz4dpYQKxp5lET4fJ5yOzuvFU8RKshMcHeEXY2q07x/mFKmRKMQFnl
 +7rrFqR+A2Eqs4SSZl3srJzMrXfkZNab07OeRWgkytqrocdWSM7kUwmfNfGX9WxrPZEO
 Td+otEW8C7r3+neWka214XFjUB5xN6wrNi/AhpwLCvy1DjEvcLQGU32T0b/iUEX6VH4D
 9vfLQiWV5iGowEhWTJ4oC0mJUoeb3zmQ1zq8jX6HH7cAsbA8Qh+BdPpnqq1ZC2nKgCwF
 MZII3R6nIG3NsOkNu8CYGQrlZpsQUxnx0VJYESeY5tlq5Q4EKLfnhI+gih3Q6IWHVsJ3
 ywDw==
X-Gm-Message-State: AOJu0YzQrYmYkJ/4xBQcaUGZ8488FfZJCmZle/QsDT/Bpi13dHmDhRya
 OjvIpAyr+RBBISiIm6UYdT7K1li+engcGkPOwP8CqqY6WUI7VCPx2MZf
X-Gm-Gg: AR+sD10pMkNiS+pW862JLaHHipUmW79gMTF2X4uJrCksJ/01DguiUb82LHXdOsxIvjj
 ZTq0lus5hlxtWawnSXqDY6cx+ffboS/y9OHpvKK3AFPBoFOLyASXGfQwV3zHi1v1BcHcOqDQGAq
 Lpb1iG+GBLgPyBZk6vRPrDgWqo/lNcPpfue8Gf47X9kVH6gK5UeHyreZxnE6b5KAAzabpzMURPV
 poSpiA/ye8az2lFQgO+F8y17dRuKjS4dBCr2r2ge1wzd0unMQ18537BOFoeLDMVrwDspjA6Xrlh
 riDOovF+J11j9uBZXoo0pjWvTQ/eOCU/FFc03LyFLRL6VDXsBVlGh5HUusqgLQQA8dvZUGbPlnM
 FIsWHPTZ8Qs6xJC6XvPPi6lCTICvbGl5h9ic/6CEnlqe7aakISc1+Gc+zCjt2P/QplPfxmPoCjS
 oT0DKiY692Gk656mp53F3h3zWttHH9Ju5ZrYeHs7D8+KJo68Kua+dVnycNpc36VxV7p1qB7K89P
 g==
X-Received: by 2002:a05:600c:c3c1:10b0:495:63e4:7f78 with SMTP id
 5b1f17b1804b1-4980c672b1cmr33123135e9.10.1785586292085; 
 Sat, 01 Aug 2026 05:11:32 -0700 (PDT)
Received: from fra-x8664.wind3.hub ([151.83.195.12])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fd41d17f2sm18174953f8f.2.2026.08.01.05.11.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 01 Aug 2026 05:11:31 -0700 (PDT)
From: Francesco Magazzu <postadelmaga@gmail.com>
To: lyude@redhat.com,
	dakr@kernel.org
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, kherbst@redhat.com
Subject: Re: [PATCH 0/2] drm/nouveau/clk: fix RAM error handling and pstate
 desync in nvkm_pstate_prog
Date: Sat,  1 Aug 2026 14:11:22 +0200
Message-ID: <20260801121122.358187-1-postadelmaga@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260727152821.128432-1-postadelmaga@gmail.com>
References: <20260727152821.128432-1-postadelmaga@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 01 Aug 2026 19:43:31 +0000
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

Note: this series applies on top of my earlier "[PATCH v2 0/4]
drm/nouveau: fix list cursor use after loop in the clk pstate paths"
(20260712123616.1180830-1-postadelmaga@gmail.com, sent 2026-07-12), not
on a clean tree -- patch 2/2 here touches the same nvkm_pstate_prog()
that v2's patch 2/4 modifies.

Both patches fix pre-existing issues an automated review (Sashiko)
found in v2's patch 2/4 while reviewing it: nvkm_pstate_prog() silently
discarding RAM clock programming errors, and clk->pstate being updated
before hardware programming actually succeeds. Neither bug was
introduced by v2 itself.

If it's easier to review as one unit, happy to resend as a v3 of the
original series with these two folded in -- let me know what you'd
prefer.

Francesco
