Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 602D7C982C1
	for <dri-devel@archiver.kernel.org>; Thu, 17 Sep 2026 08:18:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8491C10EC43;
	Thu, 17 Sep 2026 08:18:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="FZzb+MUv";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B142F10EC43
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 08:18:42 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D37F560211;
 Thu, 17 Sep 2026 08:18:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C567B1F000FF;
 Thu, 17 Sep 2026 08:18:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789633121;
 bh=SvOAAvEqQrXLsQwlnPnQWnbNbrravmSOiEtsZTzR2W0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=FZzb+MUvs6DCrqSinxiRcAYbsiqLJmbaQGqvWAaPxdsyKGJrCYTqyOls4HSAXgZdW
 CQn7MYibOWxHyT1JtOiT/aPpYQJbdKx7v2p/y29eC+07Puc2JDxM9BMzCPQotOKKDh
 NYHNfeoo7GN9L82+janmD/eln+b1xqpG4GXAovuzpjME8VQFyWiwo4joFP5AsdVXs9
 PhpOT2C960tkSIrhDIdOhhFWjEoC98CtLR4Szior/6FJ/gtAcbVyF56DNjICHKpgsE
 JSLAUxzVg8Gp3IxgGO0xFz75JwXLTcawr5rjgZY7SuNk/gruMnK5Dour9h9SHNuRul
 MBuF/um2AyKrw==
Date: Thu, 17 Sep 2026 10:18:37 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Linus Walleij <linusw@kernel.org>
Cc: Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Ulf Hansson <ulfh@kernel.org>, Mark Brown <broonie@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Vinod Koul <vkoul@kernel.org>,
 Frank Li <Frank.Li@kernel.org>, 
 Lee Jones <lee@kernel.org>, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, 
 linux-pm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 dmaengine@vger.kernel.org
Subject: Re: [PATCH v2 08/20] dt-bindings: cache: l2c2x0: Document power domain
Message-ID: <20260917-sexy-jasmine-roadrunner-c31d90@quoll>
References: <20260914-ux500-power-domains-v7-1-v2-0-9d0c17e1f816@kernel.org>
 <20260914-ux500-power-domains-v7-1-v2-8-9d0c17e1f816@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260914-ux500-power-domains-v7-1-v2-8-9d0c17e1f816@kernel.org>
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

On Mon, Sep 14, 2026 at 01:54:36PM +0200, Linus Walleij wrote:
> Describe the optional power domain for cache controllers.

It is already described.

Best regards,
Krzysztof

