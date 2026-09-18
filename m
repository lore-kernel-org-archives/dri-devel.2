Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96D06C982D7
	for <dri-devel@archiver.kernel.org>; Fri, 18 Sep 2026 21:55:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D3A4010E256;
	Fri, 18 Sep 2026 21:55:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="FR5oM+9/";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3CF9910E256
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 21:55:40 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 83DAA6053B;
 Fri, 18 Sep 2026 21:55:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C1521F00898;
 Fri, 18 Sep 2026 21:55:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789768539;
 bh=J8d54ZjF80j5PSeUUGJOwzN8j8yyoXk5bK5VrCr6trE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=FR5oM+9/Q9Gt7NasIOp2sGg+Hd8SkJeOIApn+kgvLPBhyKowszo/f1INrNqWLrUZ8
 fJfKV7IKFBaWQImHLJGKCr+oPg/r8j0jM8Fg0GpOtIk8E09QF4s7nJnVTsVN0LiigU
 57rIx5IYFGLbweQoREwF4uiJOsVN95CDkR4i71gDGnrps4JYkTOTmrVSW0nSC+/xJg
 8B+l6FkQ38lFMGoaib9NVAUFluoMu3jjNSbGhh1rhq6t3KeidD8TU+58wC3QfupWis
 rijZ/Way9jBq3VyYXSqYvfPWzzc6ShiNElyYOzpzeBuJvKrEJGMZX/k6d7I4bSbe4c
 7/5vvyRYXP7nQ==
Date: Fri, 18 Sep 2026 16:55:37 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Linus Walleij <linusw@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 linux-arm-kernel@lists.infradead.org, David Airlie <airlied@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@kernel.org>,
 Maxime Ripard <mripard@kernel.org>, dmaengine@vger.kernel.org,
 Simona Vetter <simona@ffwll.ch>, linux-pm@vger.kernel.org,
 Vinod Koul <vkoul@kernel.org>, devicetree@vger.kernel.org,
 Lee Jones <lee@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 dri-devel@lists.freedesktop.org, Ulf Hansson <ulfh@kernel.org>
Subject: Re: [PATCH v2 19/20] dt-bindings: display: ste,mcde: Deprecate EPOD
 supply
Message-ID: <178976853742.2415043.13414750295183513008.robh@kernel.org>
References: <20260914-ux500-power-domains-v7-1-v2-0-9d0c17e1f816@kernel.org>
 <20260914-ux500-power-domains-v7-1-v2-19-9d0c17e1f816@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260914-ux500-power-domains-v7-1-v2-19-9d0c17e1f816@kernel.org>
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


On Mon, 14 Sep 2026 13:54:47 +0200, Linus Walleij wrote:
> Make epod-supply optional and mark it deprecated.
> 
> The MCDE should use its power domain instead.
> 
> Assisted-by: LLM
> Signed-off-by: Linus Walleij <linusw@kernel.org>
> ---
>  Documentation/devicetree/bindings/display/ste,mcde.yaml | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>

