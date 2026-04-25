Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30A49FF885C
	for <dri-devel@archiver.kernel.org>; Sat, 25 Apr 2026 09:56:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9DDAA10E122;
	Sat, 25 Apr 2026 09:56:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="YQaav5Vz";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C1E5A10E122
 for <dri-devel@lists.freedesktop.org>; Sat, 25 Apr 2026 09:56:06 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id A3315442A9;
 Sat, 25 Apr 2026 09:56:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1EA9C2BCB0;
 Sat, 25 Apr 2026 09:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777110966;
 bh=WJcc1NZETmbddcBcUKF7rrXIoSuykV0QJB1jUEB7vEQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=YQaav5VzbXA3ZKzDIAcL2FZVk7pFwk4MWSaisn9CqO/T5tbx63RhH0O0/4h/UuDz2
 J1HRbdWoue6NAxI5kU4UT9sL9c/e48aJlD5tb/ZEGds0rkTjaZJ+mU8cNgvx+IxSz3
 Q10QxMOHtnmdz2CaVydUMd7IknbArXP8sqkcfI9yGr8wRyHuif6QPeJqlk4ofFIAgH
 cpVJlKKDpZ6Z34sjVh4PBguEwDuwJ4R5vcXkMUNUnzSbNc3xOvsLmbn6lBciwJtdxj
 4OGgw7wdjWGnINf5OSVMmxNO/zJD/pPfWMZ1gTcQCOZ8q8aeMYKqIMYGiiPjp/safH
 XMPzpaERlmqyg==
Date: Sat, 25 Apr 2026 11:56:04 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Lukas Timmermann <linux@timmermann.space>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Thierry Reding <thierry.reding@gmail.com>, Sam Ravnborg <sam@ravnborg.org>, 
 Douglas Anderson <dianders@chromium.org>,
 Sylwester Nawrocki <s.nawrocki@samsung.com>, 
 Chanwoo Choi <cw00.choi@samsung.com>, Alim Akhtar <alim.akhtar@samsung.com>, 
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>,
 dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-samsung-soc@vger.kernel.org, 
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 3/5] dt-bindings: clock: samsung: Add fimd1 and vpll muxes
Message-ID: <20260425-uncovered-otter-of-sunshine-d00ed0@quoll>
References: <20260423-manta-display-v1-0-196f80c5673a@timmermann.space>
 <20260423-manta-display-v1-3-196f80c5673a@timmermann.space>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260423-manta-display-v1-3-196f80c5673a@timmermann.space>
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

On Thu, Apr 23, 2026 at 11:14:39PM +0200, Lukas Timmermann wrote:
> Add two clocks necessary for the google-manta board
> display.
> 
> Signed-off-by: Lukas Timmermann <linux@timmermann.space>
> ---
>  include/dt-bindings/clock/exynos5250.h | 2 ++
>  1 file changed, 2 insertions(+)
>

If there is going to be any new version, better to split this and send
all SoC patches (clk + DTS) separately from DRM.

No need to resend just for that, I will pick up Samsung SoC things after
the merge window.

Best regards,
Krzysztof

