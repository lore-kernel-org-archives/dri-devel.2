Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ED94C61DD3
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 12:27:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B3B010E040;
	Mon, 31 Aug 2026 12:27:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=geanix.com header.i=@geanix.com header.b="Yb93gXzi";
	dkim-atps=neutral
Received: from mail-244106.protonmail.ch (mail-244106.protonmail.ch
 [109.224.244.106])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B994710E040
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 12:27:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
 s=protonmail; t=1788179268; x=1788438468;
 bh=YfqR/vMRmNS8dD3ZfLMM3JhQFyP64RQ/IUaqphE03xI=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:From:To:
 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=Yb93gXzipfdDHWha8nGItK1Px0Mzkm5blaajgpjlFchKN3X0ROfNENspnpzkXY2vU
 r9GacfgJmbxIv0fp1mOG1huol7Od/lRr2oqXetLnbS7qPBGqf8+LMNetNc2ETVyaq/
 4vqzopZGFr2hm0mVSHuSZ1sMq8YKzbLEKCabs/bwNxrfDnuFZh8gy8Y9ekhIvDfT8Y
 xDSVvomZH1WjYUljlTbj+ISb3Yd1/s+1VmPDHLEXWL+VVI0Kt6qgzNJ1JUfDDicenR
 iqEn4kk3wdqOGfdRJZf3FevHazqBO+fKVF5C8h3w2oSl+G6SqykOIE7awhucaPI849
 fvLo/FHwQUbMw==
X-Pm-Submission-Id: 4hYStp0Sxbz2SchS
From: Esben Haabendal <esben@geanix.com>
To: <sashiko-bot@kernel.org>
Cc: <sashiko-reviews@lists.linux.dev>,  <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH v3 4/5] drm/bridge: nwl-dsi: Add error handling of
 nwl_dsi_mode_set()
In-Reply-To: <20260810072257.2ABD61F000E9@smtp.kernel.org>
 (sashiko-bot@kernel.org's message of "Mon, 10 Aug 2026 07:22:56
 +0000")
References: <20260810-nwl-dsi-fixes-v3-0-256da9d672e1@geanix.com>
 <20260810-nwl-dsi-fixes-v3-4-256da9d672e1@geanix.com>
 <5q9c0nOychvLDFd3tAjzhmVICVDZQWFIPqhVqa1FQJGcjJTarKOeTu1dJqvF_NiZXLKlWwb68VedbPjlDsJ8gg==@protonmail.internalid>
 <20260810072257.2ABD61F000E9@smtp.kernel.org>
Date: Mon, 31 Aug 2026 14:27:45 +0200
Message-ID: <87v78qv5j2.fsf@geanix.com>
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
> - [High] Unbalanced resource teardown and PM runtime underflow in mode_set error path.

I am preparing a new patch series where this will be adressed. I will
send it when this series is merged.

/Esben
