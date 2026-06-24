Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24CB8CDB47C
	for <dri-devel@archiver.kernel.org>; Wed, 24 Jun 2026 10:00:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8198C10EE4F;
	Wed, 24 Jun 2026 10:00:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="bK5M5mGI";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BFA1410EE4F
 for <dri-devel@lists.freedesktop.org>; Wed, 24 Jun 2026 10:00:54 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A8EA4402F5;
 Wed, 24 Jun 2026 10:00:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25B891F000E9;
 Wed, 24 Jun 2026 10:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782295254;
 bh=pIvYjWqlDZLqoStvcTjkJE5Gx1FLDsejyO0rZEZzs2A=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=bK5M5mGIONepHqqYf+OkaQrAneGgb0D5nPQ+60445jLOU7o2+QLr4NbyTuWjTMo8w
 ecFydHHW8T2y3I7YRJ0KKpHRL3k473g4lyt0y5sUl/TjJLKIShZX7/IjWAqFrDXqJB
 vWkZK7SedgwhP0SBdv+KvgtR28Eqsh2g87NsN3U2nE/dzoat6jADkR4HOUlV+6cm6h
 0e9M10Gg+og+/5sblWAJePWkcx1cxOoI0xmTHa4xMms3lrRHDXaS+bhGIfgqcVd0fX
 zWeGKe+d9DUP4mIocsbUVSWUZ9t1qK0SckJ06wIRUCNzv6OZK4tuRZiRoJxheaMhNb
 R6qVc4j20Z7mQ==
Date: Wed, 24 Jun 2026 11:00:48 +0100
From: Daniel Thompson <danielt@kernel.org>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Lee Jones <lee@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
 Pavel Machek <pavel@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Helge Deller <deller@gmx.de>,
 dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fbdev@vger.kernel.org, KancyJoe <kancy2333@outlook.com>
Subject: Re: [PATCH v5 2/2] backlight: Add SY7758 6-channel High Efficiency
 LED Driver support
Message-ID: <ajuq0IsFT1UV2pAi@aspen.lan>
References: <20260529-topic-sm8650-ayaneo-pocket-s2-sy7758-v5-0-03aacd49747c@linaro.org>
 <20260529-topic-sm8650-ayaneo-pocket-s2-sy7758-v5-2-03aacd49747c@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260529-topic-sm8650-ayaneo-pocket-s2-sy7758-v5-2-03aacd49747c@linaro.org>
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

On Fri, May 29, 2026 at 09:23:09PM +0200, Neil Armstrong wrote:
> From: KancyJoe <kancy2333@outlook.com>
>
> Implement support for the Silergy SY7758 6-channel High Efficiency LED
> Driver used for backlight brightness control in the Ayaneo Pocket S2
> dual-DSI panel.
>
> Signed-off-by: KancyJoe <kancy2333@outlook.com>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>

Reviewed-by: Daniel Thompson (RISCstar) <danielt@kernel.org>


Daniel.
