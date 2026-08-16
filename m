Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76E76C5DF66
	for <dri-devel@archiver.kernel.org>; Sun, 16 Aug 2026 04:12:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 39D6A10E1ED;
	Sun, 16 Aug 2026 04:12:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gahingwoo.com header.i=@gahingwoo.com header.b="N9UiwR5Y";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="ONomEOrE";
	dkim-atps=neutral
Received: from flow-a1-smtp.messagingengine.com
 (flow-a1-smtp.messagingengine.com [103.168.172.136])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 302E910E1ED
 for <dri-devel@lists.freedesktop.org>; Sun, 16 Aug 2026 04:12:40 +0000 (UTC)
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailflow.phl.internal (Postfix) with ESMTP id 316191380153;
 Sun, 16 Aug 2026 00:12:40 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-02.internal (MEProxy); Sun, 16 Aug 2026 00:12:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1786853560; x=
 1786857160; bh=lJ3os724hSt3ktSUr45GRnoaHyq1InmNCTom8Lp4Cp0=; b=N
 9UiwR5YdgCDMjHjyIwwI2D8MI8jwnFMtBufcYW9sGtahJNn+IZXWCxj/dZAy16H2
 CEbKBQVbC5jN+nQ+iFEGkCXwBaZekCw+cPW5O4bjTlFZtp84SgRDsqvWu9SEOCSu
 F4AIqYzlq7RC/o6F1uBrkfjqgTK14yOTUKdygs65q1siYukeYEgfrJaB8Wfv2rMb
 nL2kdQbp1KfndVUgEyXjUirABp0x+uWQv97XPYKSrqK5oilPs9UINGHCgyd9O1+a
 zPZvlQQzPpf0p9I9Yr4QfT3y4j7kYekFBpbDldd91dIWAWvrwuT8m/8l3QYqNBLL
 Vc8vhDStYOOQjHRMfd1sg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1786853560; x=1786857160; bh=l
 J3os724hSt3ktSUr45GRnoaHyq1InmNCTom8Lp4Cp0=; b=ONomEOrEFd5CcI2QG
 +P42rYjDC82valwj7k7SklEnlnwq88itdEBnHzbCk4/2HC7QbTp03HLDWhvqd+7N
 g5bk1gjF/kUBpgq5gQlWSNE89mdyjAznHkFrjTF8gWKJxHHB+5USZQxx6u3zpOLo
 80wm1HSiVyDbuI91xD+xVkUiT0tF4wbKaj5LO4QPoJdooSPuafGdrOiTnFwB2Dki
 dGSGusH7SUyCXNyVJ+JCTFrbsBfsHBXVGoNGieE1LxjGbkcEPnAt9MuoBi1J8DOo
 xtAxNfjKX5XfxTbSAhJLhqHgpTQ6XS0J/YP9DgPxrdVyoK6FJm2yU9k3CX8s01Vz
 3AP7g==
X-ME-Sender: <xms:tjiBauRFar-Q-qEQ6nVwaD1Q4ONkH3HvIo8yVXfBtWmFppxAq1v3GA>
 <xme:tjiBar-qrOM47lYStBzgZPLr3kmZAO5KknmczWlHDDy4KiTndbKW8YCYwHqmsGFEl
 J5vZWrM7LTrCiX49ByJgupZig1doJY9Aw3zHGtbYRmXJHGgD0r2prw>
X-ME-Received: <xmr:tjiBanYPe6WXWHDtQY-M780_Ia5UgfvbSwle6WsXIG9aHrfAV8B3DIAsEPoHEsdj6yiKyC-J8w>
X-ME-Proxy-Cause: dmFkZTFas/+GXIf2+2Hy21pKo1/GKerUN9Ajhwld/TvCJzBGNf4sYLQxUc6KVmATaijvaF
 VifnljgyxDMkhJGC5y2bWPTCM7k+R/0uS91FvQbeVrn8XlXSf8nYzbK1+KyR/lAoxd7eSe
 iB9DflzfFdkcdlZ+Kb2NdZpuw2cmf7pM/dHcY0YaJtw4xPL4O70AOWW8JKuAX3AskA26JV
 5rISjyY8j1JAmbG5jSdJHZqWLO+2clgZCR4uQ2nFakxrsMIDgdOMahN0y0U31TLt+zlzsN
 1wmoMIIXZLvEZ08N4Ma0Ds+JXs4LyOo1GiM1Tkt10TF5sgX9+XjVInu8rwe/p/5kZkQSMd
 vy23pZVJQ4MWjz2519yr6dsyQblKT0jO9Y6QsBH7pC5eYBoh6GJVTKd5ZtJRVfiEOgOg4S
 TNB76rYicjIXiXdFZPe/f1+5X36mCYg6h3ErX3fOT8dEuA2Yudy9q+qHAuc1wE05MgjDkl
 OegRpxQkAC7VsRoMC2fHZE1Ied/lyO4zvig745AYQx5lP9ufAKZLALVuekSzJrH9roOTLm
 FzWF1ITagxVxMi9h8xfLMsjfX7G9o/tK+5jHssGJS+yPHuV7SXW5vDTajmEbmM2eSK6lAh
 2BYXf+3jpE+TEGgWJDxAxIlcuoqe+CtaqjIrbsRsuhbSuKkp1Acf6CrXPkjA
X-ME-Proxy: <xmx:tjiBakofivz3WHuZmwPrCW6BdEbqD7eGhNz2uaD9JoLABuCFFXmsEQ>
 <xmx:tjiBajQScpr1UzLu6OY1fIlyEAYp_5-yL6VS11bjYT-OiW70th5cyg>
 <xmx:tjiBagpLwRXPBBlzZ4kojgTrg-bzqjGM_JX9068Z1sLPyIpWLmK7-g>
 <xmx:tjiBal0Ku5Vgfk05A413k3jcitqrXQNLwRWQIzThkUP6Bx5Vs6lYKA>
 <xmx:uDiBarT9haR-XsKxP4MNik_NpQKNm0NrqhuyWGmadiZ1YWfqK_Jd_I2d>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 16 Aug 2026 00:12:35 -0400 (EDT)
From: Jiaxing Hu <gahing@gahingwoo.com>
To: royalnet026@gmail.com
Cc: tomeu@tomeuvizoso.net, heiko@sntech.de, chaoyi.chen@rock-chips.com,
 alchark@flipper.net, dri-devel@lists.freedesktop.org,
 linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 08/10] accel/rocket: add RK3576 NPU (RKNN) support
Date: Sun, 16 Aug 2026 16:12:33 +1200
Message-ID: <20260816041233.3566625-1-gahing@gahingwoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260815130556.68876-1-royalnet026@gmail.com>
References: <20260815130556.68876-1-royalnet026@gmail.com>
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

Hi Igor,

Thank you for running it, and for the unclamped reference.

Your 1001 does not discriminate between the two forms, which I should have said
when I described them. DIV_ROUND_UP(1001,16) is 63, odd, so the parity form
gives 0x80011011 there and so does oc % 32. They differ only where a count is a
multiple of neither 32 nor 16. On RK3576 the failing one was 56, and 88 or 120
would do as well. So your clean result rules nothing out, and I am not reading
it as support either way.

On my side that register turned out to be the whole of it. A 1x1 layer with 56
output channels had timed out in every round it ever ran, 32 of 56, and with
the parity form it is 56 of 56 every channel correct, with the old form
reproducing the timeout in the same log.

You are right about perch.py and there were three of them rather than one. The
inner maxdiff, the interior statistics and the raw row dump all assume a
surface with an interior, and all three raise on a 1x1x1001 classifier after
the useful lines have printed. Fixed here, and checked on the host at 1x1x1001,
5x5x8 and 56x56x64 before flashing, which is a check I should have been running
all along.

And I will re-score operator 28 against the unclamped output. The max(cpu, zp)
reference does move channels that are not wrong, and reading an empty
convolution off it is the kind of mistake I would rather not make twice.

Jiaxing
