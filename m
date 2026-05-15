Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74BACCD4851
	for <dri-devel@archiver.kernel.org>; Fri, 15 May 2026 07:37:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB4D410F445;
	Fri, 15 May 2026 07:37:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="IvCFukU+";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 96F0610F445
 for <dri-devel@lists.freedesktop.org>; Fri, 15 May 2026 07:37:27 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 0EEE94424E;
 Fri, 15 May 2026 07:37:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64A80C2BCB8;
 Fri, 15 May 2026 07:37:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778830646;
 bh=a8EYgOEz++YwUaCdJC5iuFQH3G+D7Z3AA/LV/KjouHQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=IvCFukU+krehMgs77r1eo1DOe8p6PhMicmvj3a2hns+H7LMtIip+pPzY/sklR7o2s
 +KB9LebJmj3GJJxDcscEY9TQo4ZA3NyhuNHhpEaao1szG3L7D+LLMtE68Vf/3L1iGP
 AuVAqPf30D73I4Gc/fV5p6yFZjkaG5xcjLcak61mclalI4bs6SKAV5bmsHZnUmqOXW
 wCFVoYZdMJFkXOSjZsu/7e1DUBgHZuX9dvGvmqR+SK/EurDnrwD8tQkAw9Pd/uQfXR
 ciPYKQCiRuPbWNHrzvSo8bhagrEr91UH5eS4marGBbBkpilrSMWE8jqr+eOGKG4KSg
 EXd+BEohmQXKw==
Date: Fri, 15 May 2026 09:37:24 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Alexandre Hamamdjian <azkali.limited@gmail.com>
Cc: Philippe Simons <simons.philippe@gmail.com>, 
 Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>, 
 Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>,
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Helge Deller <deller@gmx.de>, 
 dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
 devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: leds: backlight: add Silergy SY7758
Message-ID: <20260515-friendly-anaconda-of-dew-abd4dd@quoll>
References: <20260511-sy7758-v1-0-999a33081304@gmail.com>
 <20260511-sy7758-v1-1-999a33081304@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260511-sy7758-v1-1-999a33081304@gmail.com>
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

On Mon, May 11, 2026 at 12:08:02AM +0700, Alexandre Hamamdjian wrote:
> The Silergy SY7758 is an I2C-controlled multi-channel LED backlight
> driver typically used to drive the edge-lit LED strings of LCD panels
> in handheld and embedded devices. Brightness is programmed as a 12-bit
> linear value through two 8-bit registers.
> 
> Document the binding for the new compatible "silergy,sy7758" so it can
> be referenced by board device trees and the matching driver, and add a
> MAINTAINERS entry covering both the binding and the upcoming driver.
> 
> Co-developed-by: Philippe Simons <simons.philippe@gmail.com>
> Signed-off-by: Philippe Simons <simons.philippe@gmail.com>
> Signed-off-by: Alexandre Hamamdjian <azkali.limited@gmail.com>
> ---
>  .../bindings/leds/backlight/silergy,sy7758.yaml    | 47 ++++++++++++++++++++++

This was already sent two weeks ago:
<20260430-topic-sm8650-ayaneo-pocket-s2-sy7758-v2-1-308140640de9@linaro.org>
and that posting looks closer to complete.

Best regards,
Krzysztof

