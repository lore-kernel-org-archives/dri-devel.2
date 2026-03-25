Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F389FEA830
	for <dri-devel@archiver.kernel.org>; Wed, 25 Mar 2026 08:17:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7245110E00D;
	Wed, 25 Mar 2026 08:17:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="A1hYdX/W";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 018C210E00D
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 08:17:24 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 34A57600AC;
 Wed, 25 Mar 2026 08:17:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 582C7C4CEF7;
 Wed, 25 Mar 2026 08:17:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1774426643;
 bh=nYFxOoFBdJDJAtHSqZjQoKIJ0Nr8zwnTAqqylX7FTBw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=A1hYdX/W978ySG20Jup77ph5rBseGqjxnja0LRKYMjW8AwyFzxsD/EViH/I0aoIkD
 WYsfqRRYc88AwzIPadliQ4jGJWyjL78fjWlrhiObbFuropE04BiCVkhn/OJKOhwagv
 V/ayRoaGKpe1VTR9ndtXJ7wQ2BEBCusld3HEjJWKXd0uYVTeomWT2pyWjyQCoJfvJU
 Hmt6wvNfd0zNmbWqphegQemZFUV09EZw+4EfLZRmu7ydCELdYRvfRGBL/hIDm/WOhE
 sG9hW0ETnUKX75jeCesFfMRdDQ9OfOiThMa+u2KYNkXvuWSkwmw6CNDV9PyX9p9VAK
 Hlef7DuLYym7g==
Date: Wed, 25 Mar 2026 09:17:21 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Jay Liu <jay.liu@mediatek.com>
Cc: Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 dri-devel@lists.freedesktop.org, 
 linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 0/6] porting pq compnent for MT8196
Message-ID: <20260325-hissing-jasmine-crayfish-caef70@quoll>
References: <20260324125315.4715-1-jay.liu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260324125315.4715-1-jay.liu@mediatek.com>
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

On Tue, Mar 24, 2026 at 08:51:57PM +0800, Jay Liu wrote:
> Change in v4:
> - Address coding style comments for disp-tdshp binding. 

Coding style? Why so vague? So does that mean you ignored all important
changes but did the "style" things?

> - Rebase ccorr driver patch on top of latest linux-next to fix conficts.

Where is the rest of the changeglog?

Why aren't you using b4 to provide also lore links and solve above
problem?

Best regards,
Krzysztof

