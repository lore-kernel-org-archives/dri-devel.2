Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80D46C98338
	for <dri-devel@archiver.kernel.org>; Sun, 27 Sep 2026 17:42:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE67210E2FE;
	Sun, 27 Sep 2026 17:42:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="oEAv1UKQ";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6EF3410E2FE
 for <dri-devel@lists.freedesktop.org>; Sun, 27 Sep 2026 17:42:04 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2A67741982;
 Sun, 27 Sep 2026 17:42:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B3241F000FF;
 Sun, 27 Sep 2026 17:42:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790530924;
 bh=M2R8EMCtjqgp1q1NPnQ6MJ7JMpNjZuPZJDYN1u2/JAI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=oEAv1UKQJT6is75huFGYW7NJC04wu+aBTFD49Ru5Mv9YlyWpD6/E1XqyQaos3wo6z
 Xp1oRzBqw21PN46cOJYweBt8Tx5vVOLI0zM5GDCd5EpAvqBiSMqw/k73RDgN3o84zN
 ELs0UihXcSPIsV7DrOXPh8kBDPp7rZ1IBv5TskValWjJ90w9gdrfSCyIdsdFeMS2c8
 HUjVowyYU5YSPnpYyKkrkotqTnS7kUWmEXIUmNfyT8fSFKkTHhJdc7HpTbZpvqqmfs
 5A1Uebfc0lYx8FfeUXNZ3tDN2es3W9MbAkaYhlQaCSaQG03wVy70qqhx4noW3TqV3e
 UrlFh3ZymiP+g==
Date: Sun, 27 Sep 2026 19:42:00 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Linus Walleij <linusw@kernel.org>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Hans Ulli Kroll <ulli.kroll@googlemail.com>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: display: faraday,tve200: Use a
 level-high interrupt
Message-ID: <20260927-steady-infrared-penguin-baa4fb@quoll>
References: <20260921-gemini-tve200-fix-v1-0-8be03ac2a8f7@kernel.org>
 <20260921-gemini-tve200-fix-v1-1-8be03ac2a8f7@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260921-gemini-tve200-fix-v1-1-8be03ac2a8f7@kernel.org>
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

On Mon, Sep 21, 2026 at 11:15:54AM +0200, Linus Walleij wrote:
> The TVE200 vertical interrupt can remain pending after acknowledgment.
> Using rising-edge triggering can leave it unserviced when no new edge
> is generated, causing vblank and page-flip timeouts on the D-Link DIR-685.
> 
> Use level-high triggering in the binding example so a pending interrupt
> is delivered again without requiring a new edge.
> 
> Fixes: 8b17e80d9e46 ("drm/tve200: Add DT bindings")

Example has no impact beside validation, thus no bug to fix here,
really.

> Assisted-by: LLM
> Signed-off-by: Linus Walleij <linusw@kernel.org>

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

