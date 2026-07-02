Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9901C43327
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 16:31:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D073110F4E3;
	Thu,  2 Jul 2026 16:31:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="FpMAF901";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BAD4D10F4E1
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Jul 2026 16:31:47 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1640E601E3;
 Thu,  2 Jul 2026 16:31:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B82AB1F000E9;
 Thu,  2 Jul 2026 16:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783009906;
 bh=RzzfmIogOoChfCuB1Ba9o2vBi864tKCQNnuaaTtA2d0=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date;
 b=FpMAF901KOCXsLd9Peup0g2nFxlws6YELsM6AeOcDUdHrNZTxBbYwbFPemRHFOrPm
 WeoMU7b24n0MLm0SN62gtXKt6cOaVz1trQF1m6P6xawmpvqbHMtuekkcUE2BKRN8oy
 iNtPaMFUFktzbSTbZSgrhOaVguNpvX0/clrZNEZoRJ0UeEkYhXB6HmPh5Q6K/0Tn2w
 dlbUR0TG0l/hGuupWcYnV6+Ze6hQtoQIOx0dbDSduHKInlWJ5HkcVqY8dh6h1xsZp8
 1SO7zYM2TcWCJjyBxxdwyQ66uyj2W11jhZ3BZHot3XYroQmTM1PHfj2EoYrca9LoZL
 U6evvTzS2aACA==
From: Lee Jones <lee@kernel.org>
To: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>, 
 Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Helge Deller <deller@gmx.de>, 
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-fbdev@vger.kernel.org, KancyJoe <kancy2333@outlook.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
In-Reply-To: <20260529-topic-sm8650-ayaneo-pocket-s2-sy7758-v5-0-03aacd49747c@linaro.org>
References: <20260529-topic-sm8650-ayaneo-pocket-s2-sy7758-v5-0-03aacd49747c@linaro.org>
Subject: Re: [PATCH v5 0/2] backlight: Add SY7758 6-channel High Efficiency
 LED Driver support
Message-Id: <178300990349.2239788.13080024963462152507.b4-ty@b4>
Date: Thu, 02 Jul 2026 17:31:43 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.16-dev-ad80c
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

On Fri, 29 May 2026 21:23:07 +0200, Neil Armstrong wrote:
> Implement support for the Silergy SY7758 6-channel High Efficiency LED Driver
> used for backlight brightness control in the Ayaneo Pocket S2 dual-DSI panel.

Applied, thanks!

[1/2] dt-bindings: leds: backlight: document the SY7758 6-channel High Efficiency LED Driver
      commit: 2019a2a7268f6f7387f052110558b9f90b500324
[2/2] backlight: Add SY7758 6-channel High Efficiency LED Driver support
      commit: 110d67699a430daf0316f941254c46221e3f0914

--
Lee Jones [李琼斯]

