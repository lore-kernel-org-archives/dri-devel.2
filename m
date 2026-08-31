Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04828C624A4
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 15:13:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 30D1D10E39F;
	Mon, 31 Aug 2026 15:13:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=geanix.com header.i=@geanix.com header.b="qyKrFVsA";
	dkim-atps=neutral
Received: from mail-244108.protonmail.ch (mail-244108.protonmail.ch
 [109.224.244.108])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F246010E39F
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 15:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
 s=protonmail; t=1788189232; x=1788448432;
 bh=ULr1CbAlROLTSTSWTpgKZv1rM2J3GWPn2ux4glhFpio=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:From:To:
 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=qyKrFVsA0g5jYowzoMSDZ2egsnD0O6YCzQEXmbt/tpQV64yK/6k7PFPN45BS+YlSX
 X+V2AMlWgcP34k2tJKCusClJIMZ8/+jYtqs8Z/GZwkBeh45GrHgMYj5iuQP5kxhBmb
 hDEOcc6FarnUIdXlZjztFLySf9lDR4dibr9kICiwMCD6uP1gHEO5S8TSjYgiBHhmp1
 fHv5vuvFM5lg62eFPPukD5KMcHyH8ADnLnaTPqzSwKIpvucK7pNuqx5L765HoJ3i/f
 qYYCN4KYsSkDDio7IOtroiekr6KuTQNaQA/48jyVU33c93PFugGchSk5cIQQHZaovZ
 kgTeAyU9Vaujw==
X-Pm-Submission-Id: 4hYXZP0t8Zz1DDs7
From: Esben Haabendal <esben@geanix.com>
To: <sashiko-bot@kernel.org>
Cc: <sashiko-reviews@lists.linux.dev>,  <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH v4 1/4] drm/bridge: nwl-dsi: Cleanup endpoint mux
 control selection
In-Reply-To: <20260831133448.DB07A1F00A3E@smtp.kernel.org>
 (sashiko-bot@kernel.org's message of "Mon, 31 Aug 2026 13:34:48
 +0000")
References: <20260831-nwl-dsi-fixes-v4-0-6a2a1cb23910@geanix.com>
 <20260831-nwl-dsi-fixes-v4-1-6a2a1cb23910@geanix.com>
 <c29_epPmBRcdNhmdPrhhKaZrpV7WRr2PtdmWdmXP1hUPoaUV3tDu0Ibu9jKo9MSUzO-FlDvFeBQVv4I2Y0p3wg==@protonmail.internalid>
 <20260831133448.DB07A1F00A3E@smtp.kernel.org>
Date: Mon, 31 Aug 2026 17:13:47 +0200
Message-ID: <87mru2uxuc.fsf@geanix.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
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

<sashiko-bot@kernel.org> writes:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
>
> Pre-existing issues:
> - [High] Dangling pointer to stack variable left in dsi->xfer after transfer completes or times out.

I will add a fix for this pre-existing issue to the next patch series I
have lined up for the nwl-dsi.c driver.

So let's try and get this one merged :)

/Esben
