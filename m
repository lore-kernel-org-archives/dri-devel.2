Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 586A0C982D8
	for <dri-devel@archiver.kernel.org>; Fri, 18 Sep 2026 21:54:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C3FA610E22B;
	Fri, 18 Sep 2026 21:54:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Z1PxyPvP";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 768E510E22B
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 21:54:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5E5C74394F;
 Fri, 18 Sep 2026 21:54:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E8101F000FF;
 Fri, 18 Sep 2026 21:54:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789768462;
 bh=Lco0nsfOk/y1oLd4zNBhcBNCczg5cJsEqylfHR9vG+8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=Z1PxyPvPAQI8S9FUlJC53CweFvKxnBH/6aUfb/nP/Mj+xboet4C6ZO0QiGEpF0N6o
 +EniklQnUAiSTgJt9mP7ubukOU27ICP+pC2c/4wpiqaSv608ilBBYQVVUx2iIZsU+f
 ivQcMh5CsgyVliIIoPx2frq5qKWRjYrhSe8hJ3dcKo515UOjXjKeJwvtap8LdPbboQ
 9R8Hs2CpNmPCbGnbrd0YGqqgyCquflXVJ5AZIIA1qTuqAdGmGN5lzooz1ehdKJIMvY
 uzrJ0HzdmksvWFQiif6tuJMmNux74FiryAR+Dd6DSijVZenXkUpdRAyVzxPoD1mjnk
 qVht87VZt9j4g==
Date: Fri, 18 Sep 2026 16:54:20 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Linus Walleij <linusw@kernel.org>
Cc: Maxime Ripard <mripard@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Frank Li <Frank.Li@kernel.org>, dri-devel@lists.freedesktop.org,
 Lee Jones <lee@kernel.org>, David Airlie <airlied@gmail.com>,
 Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
 Conor Dooley <conor+dt@kernel.org>, Simona Vetter <simona@ffwll.ch>,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 Mark Brown <broonie@kernel.org>, linux-pm@vger.kernel.org,
 Ulf Hansson <ulfh@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>
Subject: Re: [PATCH v2 10/20] dt-bindings: clock: stericsson,u8500-clks:
 Allow power domains
Message-ID: <178976846033.2410726.8701362101092342072.robh@kernel.org>
References: <20260914-ux500-power-domains-v7-1-v2-0-9d0c17e1f816@kernel.org>
 <20260914-ux500-power-domains-v7-1-v2-10-9d0c17e1f816@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260914-ux500-power-domains-v7-1-v2-10-9d0c17e1f816@kernel.org>
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


On Mon, 14 Sep 2026 13:54:38 +0200, Linus Walleij wrote:
> Allow the DB8500 clock controller node to reference its power domain.
> 
> Signed-off-by: Linus Walleij <linusw@kernel.org>
> ---
>  Documentation/devicetree/bindings/clock/stericsson,u8500-clks.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>

