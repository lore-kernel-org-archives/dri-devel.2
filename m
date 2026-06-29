Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A881AC43458
	for <dri-devel@archiver.kernel.org>; Tue, 30 Jun 2026 07:19:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D95110EB08;
	Tue, 30 Jun 2026 07:19:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=mtcoster.net header.i=@mtcoster.net header.b="j62z7qwA";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="GSzrox/i";
	dkim-atps=neutral
X-Greylist: delayed 431 seconds by postgrey-1.36 at gabe;
 Mon, 29 Jun 2026 15:56:04 UTC
Received: from fout-b4-smtp.messagingengine.com
 (fout-b4-smtp.messagingengine.com [202.12.124.147])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A7DB10E977;
 Mon, 29 Jun 2026 15:56:04 +0000 (UTC)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfout.stl.internal (Postfix) with ESMTP id E47AF1D00116;
 Mon, 29 Jun 2026 11:48:52 -0400 (EDT)
Received: from phl-imap-03 ([10.202.2.93])
 by phl-compute-04.internal (MEProxy); Mon, 29 Jun 2026 11:48:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mtcoster.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1782748132;
 x=1782834532; bh=caj7NhxS+zfIfbXQGNobhEaj6J+GBhedpqhuGQWWRII=; b=
 j62z7qwAllMd89cHW1sEjJdSNVBtwxRv7xjEgoA4uTGpcVSaouVCwW9iWqlmhRmf
 F/sorL4LYU361JrhOTB7s+cTz/chpY+eu+6Onore6d7ejpBRdix/tWEjoSrKzxd+
 250UIDBpFGfTldzxtIj3urItrxQhu7bAm/mW9Y/EbuYLaVtMHSdeRERyW7cuXwxG
 43eXmuzitOTAIJDLarqJtreKC6J2tmL6tCW2mG+jxzEOcN3ux9Hp6cIbKzpzxP8+
 VUCfrtVXvllsY0nvazgu8xS4SfKwvlmWuCGZqDlHTzZVq8g7KYetkBLj7bDUZQw1
 /XGWmVipEbdLYr3e/OdynA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782748132; x=
 1782834532; bh=caj7NhxS+zfIfbXQGNobhEaj6J+GBhedpqhuGQWWRII=; b=G
 Szrox/iO8ycXO0ZFNudxuEjuvWMY1ouSn1vnUy8Oj1J2SJ9YDX8aNSkxhrkXNyVg
 s7nX+QftS2FUyLy7VH7Jz8gRNbiq4S5/YRvVehDsnf+mdGhLkRRnv/R/8YsKMPUu
 JdQMV+eUGoOnEJQ7M0aDzHYqPcNHB84KFUIjalCi/nzlKjbROMENBJmnWOB/JWkM
 cYsq5OGKRvDErr9e9XRbTLb9zXFAMVwvloHrPvRzpB8NBFX+EuSWWQH6ohaakKsq
 OMEuRG2/Oa3vB3uytT/tbAus61a6M1hGHWLXNS2bYF97V1V8qYbfHDxSgJoj0oiO
 cjAnvVDjAAvxXqaGZmRMQ==
X-ME-Sender: <xms:5JNCao_gkI21wqYj62sZkgRybKsPp8PnoSv7ot5kWty2Dkc5hafNAg>
 <xme:5JNCarjq0lGA0SL1fcGtR_C6u0kNGt2esRihOUAxsgpKXkDyYRwjaUZDZ1WQnVhxY
 M1P3w5SbBrouBZ2uht3EbneaqeojNn0ENNcddb-CJSTsM8Q3hRK7Tw>
X-ME-Proxy-Cause: dmFkZTFyrGHzQxOGKuyDxh+BFBPqSEF8ztq1BPMqg2fmi80m+dqZMCnIREg7xkWG9OnWJw
 AdShqOLjYq0LieOs6yIF9xiPBdajB36tBrcsOnz/FOs/z8q2ZIkZyqYgceNCT2airy7gNy
 cgxX4v8hG6qJBwWak8viEQ9l4qguwcqayaa4A3qMSmRQJFQA4UwIdNjBEsHuKEtmJLXV6o
 H862P1VSvcrKhTm/pnbAgzLz+0Q8C8bWT8lQ0x328eQGXt8hRWllEibHD7OZiegQfezkwl
 qChWpYcnpNqVNfqRaKQ2/RrGmwMv2EaCDvqqMaY2BBu4l3RtrZ6pfIF2nT+d79cSxNzGly
 JylbQwdbbsqVAnn0IlG/S4pRIpja7HChnkJxWsiS5RAqTOr7bAaBMlna+TYmiaF93hEA5E
 eWq41K72xnpbi00HcG6DWW271m8dEuKF6eI9+PhavsVMj6q1n79ShDCjO23RUf9pW4DGta
 E7uKLuOp6zPaIFMEX0+jqeqAlr7NK3XhyEAsBH6nHdHphkFlD4QVUhObE4hLyr02dcFAxI
 dkJSQmp6vQVLkeiqZTG2CF9IxHNh6931LtL2k+LCST6b5sEsBXQXPYuqHrTgFVeU+3rvo6
 nlcm/NVDYEuT+U3nWAKiqkCOJeN2pjFIGCrhf+FwZLv+G4nDFLcax64nrXUQ
X-ME-Proxy: <xmx:5JNCamqxPJuv4nEc8P-pF_4LA_aU_4syiZzKLKdwBoCkwGtQpafh3A>
 <xmx:5JNCai5MbXxvitAoROFr1xx3CIDk1RRpIow9TDy2cP4z8CtNaZS5cg>
 <xmx:5JNCakgHsUJhB5mrDtpKR0EIlx30ylRhRup9l1sd4jqDkp9ttfKDMg>
 <xmx:5JNCao6cL481Kw700dcsMpnZYpy1oy4elC8NYZyYM-M--jGcBRrtgA>
 <xmx:5JNCavym-Qoo_vYLbjdlCnieU4OymZsiOfbisoiZ7l7wwqO0kdJVM9Hq>
Feedback-ID: ia289499a:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
 id 54B0F18E006C; Mon, 29 Jun 2026 11:48:52 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
Date: Mon, 29 Jun 2026 16:48:31 +0100
From: "Matt Coster" <opensource@mtcoster.net>
To: "Matt Coster" <matt.coster@imgtec.com>, imagination@lists.freedesktop.org
Cc: "Alessio Belle" <alessio.belle@imgtec.com>,
 "Luigi Santivetti" <luigi.santivetti@imgtec.com>,
 "Frank Binns" <frank.binns@imgtec.com>,
 "Brajesh Gupta" <brajesh.gupta@imgtec.com>,
 "Alexandru Dadu" <alexandru.dadu@imgtec.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-Id: <272ffadb-9521-45d2-8564-024b68a94549@app.fastmail.com>
In-Reply-To: <20260629-goodbye-v1-0-3bab53a80c53@imgtec.com>
References: <20260629-goodbye-v1-0-3bab53a80c53@imgtec.com>
Subject: Re: [PATCH 0/2] drm/imagination: Remove Matt Coster as maintainer
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Tue, 30 Jun 2026 07:19:13 +0000
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

On Mon, 29 Jun 2026, at 16:47, Matt Coster wrote:
> I'll apply this towards the end of business tomorrow; my last day.
>
> In case anyone reads this, I'd like to take the opportunity to thank
> everyone who reviewed my patches, or sent patches for me to review. It's
> been a great chapter of my life contributing to this project, and I hope
> to cross paths with it again in the future.
>
> Signed-off-by: Matt Coster <matt.coster@imgtec.com>

Acked-by: Matt Coster <opensource@mtcoster.net>

> ---
> Matt Coster (2):
>       MAINTAINERS, mailmap: Update address for Matt Coster
>       dt-bindings: gpu: img,powervr-*: Remove Matt Coster as maintainer
>
>  .mailmap                                                     | 1 +
>  Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml | 1 -
>  Documentation/devicetree/bindings/gpu/img,powervr-sgx.yaml   | 1 -
>  MAINTAINERS                                                  | 1 -
>  4 files changed, 1 insertion(+), 3 deletions(-)
> ---
> base-commit: 2637cc60b0e10dbb77fbc749f5d2de10acf133f6
> change-id: 20260629-goodbye-26468f9502b4
