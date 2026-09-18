Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BBB6C982D7
	for <dri-devel@archiver.kernel.org>; Fri, 18 Sep 2026 21:54:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D81D610E2E5;
	Fri, 18 Sep 2026 21:54:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="QLbvXml5";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D888510E2E5
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 21:54:31 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E8F336053B;
 Fri, 18 Sep 2026 21:54:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C9771F000FF;
 Fri, 18 Sep 2026 21:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789768470;
 bh=UN/6arrxng22tJrn7BRCyO+ECsAZSProc9+N1c5mFT4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=QLbvXml5HHRNDrwkCg+JH2fLuaCctWQ8iqIQd6SJOLgqvoHb2+X8/5bGYMqryclzG
 uFXYD145O0HyAaSciFIjZylqQC74BunUrPHuE5MDQV4FM08qCaO8OnrwvfiNVEk2IB
 /knds9ot/tok9odystSPYMruqvTiJlsf0ubXx9VWXezfyWoB8ZhRAknMwPjVQNHkce
 7WaAuEdUVfzZo5h1fvF2GfOFppsdkYlIEj0kFgNYmgXwqWxkf/qas/WwnzlFvwZJ7F
 /UH4dUkLO1j9uNMqcKpRWYOPCcF1ldLZZODsjqcKsk3RBZqmEymdYUCWjUXzruBGGi
 CKXHZ2QpQJMpw==
Date: Fri, 18 Sep 2026 16:54:29 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Linus Walleij <linusw@kernel.org>
Cc: David Airlie <airlied@gmail.com>, Mark Brown <broonie@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Simona Vetter <simona@ffwll.ch>, devicetree@vger.kernel.org,
 Ulf Hansson <ulfh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Lee Jones <lee@kernel.org>, Frank Li <Frank.Li@kernel.org>,
 linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org,
 Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org,
 dri-devel@lists.freedesktop.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Vinod Koul <vkoul@kernel.org>, Maxime Ripard <mripard@kernel.org>
Subject: Re: [PATCH v2 11/20] dt-bindings: timer: arm,twd-timer: Allow power
 domains
Message-ID: <178976846922.2411312.3899064627778136436.robh@kernel.org>
References: <20260914-ux500-power-domains-v7-1-v2-0-9d0c17e1f816@kernel.org>
 <20260914-ux500-power-domains-v7-1-v2-11-9d0c17e1f816@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260914-ux500-power-domains-v7-1-v2-11-9d0c17e1f816@kernel.org>
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


On Mon, 14 Sep 2026 13:54:39 +0200, Linus Walleij wrote:
> Allow TWD timer nodes to reference their power domain.
> 
> Signed-off-by: Linus Walleij <linusw@kernel.org>
> ---
>  Documentation/devicetree/bindings/timer/arm,twd-timer.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>

