Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E86BFC88E63
	for <dri-devel@archiver.kernel.org>; Sun, 13 Sep 2026 21:13:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8369310E256;
	Sun, 13 Sep 2026 21:13:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=matt3o12.de header.i=@matt3o12.de header.b="Kp3LF3yG";
	dkim-atps=neutral
Received: from mx1.mail-out.lima-city.de (mx1.mail-out.lima-city.de
 [91.216.248.203])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D45A10EA29
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 21:08:05 +0000 (UTC)
From: Matteo Kloiber <kernel@matt3o12.de>
X-Lima-ML-UUID: 2fbc39a2-13f5-4230-8f8b-cc3368733281
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=matt3o12.de;
 s=securedbylima-20230709; t=1789333683;
 bh=DzSFHRV3zOFFCm1Go+rK4cpdDjKv6Cdst3eWt/ksoF0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Kp3LF3yGmb2/UWK2NrqqMLhKi+aI+viD6AmyNRJLVSleyYJ8wNr2hmStTlj8kQq4+
 +O0o7M/aicxnIboJ8NrSVI6t3Lx8owtE1tDqMnHJJS7HLuArlMN5lmdkVJ5q/nXU28
 kdclNABqJiGznU8ayXUJbp98qtWMakf5Y/cK4sTyeqooGhlX5nfVJk5O0y+M4rSlxL
 TfoZlRPQO7jsREdWDNtjolBNaqXSi4dGS++O/G+jHQC/mFmAHCILnUNR54L7eAiKsY
 gNX+1XM/hosKfWCdad4gw1RExFeUbsL79cglDoX2uiMAPPx8+ajPVe0dlkTNwXp/P2
 acxKXHnARExpQ==
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: dakr@kernel.org, aliceryhl@google.com, ojeda@kernel.org, airlied@gmail.com,
 simona@ffwll.ch, abdiel.janulgue@gmail.com, daniel.almeida@collabora.com,
 robin.murphy@arm.com, a.hindborg@kernel.org, nova-gpu@lists.linux.dev,
 dri-devel@lists.freedesktop.org, driver-core@lists.linux.dev,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] gpu: nova-core: declare unlimited DMA max segment size
Date: Sun, 13 Sep 2026 23:07:01 +0200
Message-ID: <20260913210706.125278-1-kernel@matt3o12.de>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <DL8PWSOK6S11.3T0U8AX63YFO1@nvidia.com>
References: <20260831233215.287881-1-kernel@matt3o12.de>
 <20260831233215.287881-2-kernel@matt3o12.de>
 <DL8PWSOK6S11.3T0U8AX63YFO1@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 13 Sep 2026 21:13:31 +0000
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

On Mon Sep 7, 2026 at 11:10 AM JST, Alexandre Courbot wrote:
> Note: new kernel policy [1] asks that the specific model is not named, so
> this should just be `Assisted-by: LLM`.

Got it, thanks! I was checking what other people did and noticed a lot of
mentions of Claude, etc., so I went with it. Changed for v2.

> Thanks, this patch looks correct and I would like to merge it early, but
> one thing about the comment: it carries way more context than needed and
> reads heavily, as is often the case when AI-generated. For instance,
> "declare that to the DMA layer" is obvious from the method we are
> calling. Make sure to give a human pass to such comments as they can
> make the code tedious when they accumulate.

Thanks! I agree. I was unsure about that and decided to leave a bit more
in for the review. I'll just use your comment verbatim.

> Since this seems to be your first patch, this is a good opportunity to
> practice sending a v2. :)

Yes, submitting patches to the mailing list was certainly a new experience.
Thank you for your help and time so far!
