Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B548C4451B
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 19:59:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 986AD10E4CF;
	Fri, 17 Jul 2026 19:59:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="PJzp6IY2";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 20D1610E4CF
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 19:59:39 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id AC35340B75;
 Fri, 17 Jul 2026 19:59:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 745E31F000E9;
 Fri, 17 Jul 2026 19:59:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784318378;
 bh=FOQnC3ZR9kL0lGh3noW5T0qO8jgS2NrQL/DNGhgVjvg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=PJzp6IY2xeS9/4p2I7YmPYFltinaiR78ojdZX3I3uxLRrwHrUJmVLmFpdF07gqqc+
 76Qc6yaDF2GfXvWOsgq/ifQFtiDRnji9DqLBJQwG8JG7x+phR2RwmOqtO4HhN8AIDm
 V4q8qxUIj3l0YhVkCOBeKCLm90o+R7a0M62a52Zm34eUL1PGEiClayGv0goPEiSrJ0
 nLq03cs2+6MBhHEwOV0EluGeGT9MRTW+DIKgGAR8PH5xWPrP9WmwKUvWLqNFWR+Aav
 zzD3TmGknGXEucq1/6Xy/cz4Ok4e9uFrI92x+Y4mAhMsB/5TurTPF7zEAfhleLystX
 3DGM2bJpEEkOg==
Date: Fri, 17 Jul 2026 14:59:37 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Marc-Olivier Champagne <marc-olivier.champagne@savoirfairelinux.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Jagan Teki <jagan@edgeble.ai>, Thomas Zimmermann <tzimmermann@suse.de>,
 Simona Vetter <simona@ffwll.ch>,
 Felix Boucher <felix.boucher@savoirfairelinux.com>,
 David Airlie <airlied@gmail.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Quentin Lehoux <quentin.lehoux@savoirfairelinux.com>,
 linux-kernel@vger.kernel.org,
 Jerome Oufella <jerome.oufella@savoirfairelinux.com>,
 Hugo Villeneuve <hvilleneuve@dimonoff.com>,
 Maxime Ripard <mripard@kernel.org>, devicetree@vger.kernel.org,
 Conor Dooley <conor+dt@kernel.org>, Jessica Zhang <jesszhan0024@gmail.com>,
 dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 3/5] dt-bindings: vendor-prefixes: Add DCLTEK
Message-ID: <178431837732.2207960.14757839702768025610.robh@kernel.org>
References: <20260708213500.1867092-1-marc-olivier.champagne@savoirfairelinux.com>
 <20260708213500.1867092-4-marc-olivier.champagne@savoirfairelinux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260708213500.1867092-4-marc-olivier.champagne@savoirfairelinux.com>
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


On Wed, 08 Jul 2026 17:34:58 -0400, Marc-Olivier Champagne wrote:
> Add DCL Technologies Inc. (DCLTEK) to the devicetree vendor prefixes
> registry.
> 
> Link: https://www.dcltek.com/
> 
> Signed-off-by: Marc-Olivier Champagne <marc-olivier.champagne@savoirfairelinux.com>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>

