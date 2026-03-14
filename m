Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B321106FD9E
	for <dri-devel@archiver.kernel.org>; Sat, 14 Mar 2026 09:39:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B726910E13A;
	Sat, 14 Mar 2026 09:39:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="C6xVJuRV";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 977BD10E13A
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Mar 2026 09:39:24 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 9E8F46132E;
 Sat, 14 Mar 2026 09:39:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3787C116C6;
 Sat, 14 Mar 2026 09:39:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1773481163;
 bh=/T27SgPuJ9tG4ll4/hiyf8ufo6FzDa78qv1iAZ8cmKo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=C6xVJuRVaMCY40Y/gNiU39cmNhiMvlzU38yDfEUffkl5Z0VFrqRQwrNCSWn62Q/9P
 LWrPxaA8ekgd9aES/uRFe/xs3i+beSHbohEcF3k80QvGRi3toO5MgYxRZ5z5RQyg7j
 ymY4ANF6eBjipxJt1FiRC7NZrRGENRx+BvIJUZxCIqotJ6VkiirFrm68OrlLZ947d8
 eA+dwcE5DCZJ9sA1ob4HqWYVQhHlizT3BeJ0ljrqKyNcUNzC7ZXR132oGCYRDbYnG3
 aBenbkrtAQJzTQEOXL9Regw1he9wC2t0empiX4oH0j37PMKW0DynXW9vihYczGXquR
 49JWCKCuR6UMw==
Date: Sat, 14 Mar 2026 10:39:21 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Hermes Wu <Hermes.wu@ite.com.tw>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Pet.Weng@ite.com.tw,
 Kenneth.Hung@ite.com.tw, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: display: bridge: Add ITE IT6162 MIPI
 DSI to HDMI bridge
Message-ID: <20260314-electric-enlightened-rook-98613d@quoll>
References: <20260313-upstream-6162-v3-0-8497fb7c4406@ite.com.tw>
 <20260313-upstream-6162-v3-1-8497fb7c4406@ite.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260313-upstream-6162-v3-1-8497fb7c4406@ite.com.tw>
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

On Fri, Mar 13, 2026 at 02:16:00PM +0800, Hermes Wu wrote:
> +    required:
> +      - port@1
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - ports

Your driver clearly marks supplies and gpio as required. Probably much
more, so all this is just not matching ABI you wrote.

Best regards,
Krzysztof

