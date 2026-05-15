Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 256EECD343F
	for <dri-devel@archiver.kernel.org>; Fri, 15 May 2026 16:16:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 474AB10E206;
	Fri, 15 May 2026 16:16:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="rm0aXw47";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D0FF10E206
 for <dri-devel@lists.freedesktop.org>; Fri, 15 May 2026 16:16:45 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id BF745601D9;
 Fri, 15 May 2026 16:16:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1BCCC2BCB0;
 Fri, 15 May 2026 16:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778861804;
 bh=mqYa/GHvUQdJjr9Q95SDUrpGgPrZMqy7TvdIMziLca4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=rm0aXw475XclSOQxzbBcwZmoJvlAcMjc/q9W7OMqBVQu7sP6shKwJ9Z+kMjOl2eMX
 JuusKkOGT+DqKZhtyGCVb7YQffUPqnz4cq0gR/oD0MQAXDw7lqa4yJKDE1i9eQzISm
 Zsrih3IKg28VGKiLPrK7+jfFe9s3JJ3h6YgMP2R3pXiq5aPn2ZPf6Cg6MyLTTPTKYt
 Ulao28EsiYLXO8TmWkHGGJbV0clMoMbHTKjDcL1Nws8E58CFEn8Q4sf8n7I7J/+azl
 yA4PDtVTEZ3Cvs2TjzwFUH5WTnAtDlu9mK65GKDBLsJKSnneoOYxMb0q/5OCbkKIjg
 MDcuaigPoKUCg==
Date: Fri, 15 May 2026 17:16:38 +0100
From: Daniel Thompson <danielt@kernel.org>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Lee Jones <lee@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
 Pavel Machek <pavel@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Helge Deller <deller@gmx.de>,
 dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fbdev@vger.kernel.org, KancyJoe <kancy2333@outlook.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: leds: backlight: document the SY7758
 6-channel High Efficiency LED Driver
Message-ID: <agdG5hdbLkZt2pAZ@aspen.lan>
References: <20260430-topic-sm8650-ayaneo-pocket-s2-sy7758-v2-0-308140640de9@linaro.org>
 <20260430-topic-sm8650-ayaneo-pocket-s2-sy7758-v2-1-308140640de9@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260430-topic-sm8650-ayaneo-pocket-s2-sy7758-v2-1-308140640de9@linaro.org>
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

On Thu, Apr 30, 2026 at 11:47:15AM +0200, Neil Armstrong wrote:
> Document the Silergy SY7758 6-channel High Efficiency LED Driver
> used for backlight brightness control.
>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>

Reviewed-by: Daniel Thompson (RISCstar) <danielt@kernel.org>


Daniel.
