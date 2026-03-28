Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FB8810F3DE2
	for <dri-devel@archiver.kernel.org>; Sat, 28 Mar 2026 12:05:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C28510E079;
	Sat, 28 Mar 2026 12:05:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="mIOybRmP";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 53FC010E079
 for <dri-devel@lists.freedesktop.org>; Sat, 28 Mar 2026 12:05:07 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 2C4266011F;
 Sat, 28 Mar 2026 12:05:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E54D5C4CEF7;
 Sat, 28 Mar 2026 12:05:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1774699505;
 bh=iEyN33zGewc1XgxgB8M5s8QhjAal00jdoinGDPErVIs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=mIOybRmPqc96WQ8IxxFLC3eHKhUHPTYyTIUa3mNXJAkS2YkdXna7fQ1F9OYeLCY3B
 C4P1wyNTprfbllsGsihVr3Jxd0mmV5J74/aqzt4xSCiKpf1ZnaUg3BuTjHo26al1qD
 lApLQonO+DLVcbmisHKBIEulCAcSRbfCe6Sd6wS9bQTmOw8+FL2dohPEc4ThzK0UCW
 4vcL71XpvclwlwuBmsH3jVbdedv2+oVNCZo3XjtyCEUaxKaYfRzaffCB5Cdr/FIPqR
 74edaQmmfIKtWVfFFCVuXS0MscQgNfZtf3VTrXpbxtw4Ssy9KE1RwsmdGVlFwIM03C
 DBLFnEGBWRErA==
Date: Sat, 28 Mar 2026 13:05:02 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Cristian Cozzolino <cristian_ci@protonmail.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
Subject: Re: [PATCH v4 1/6] dt-bindings: display: panel: Add Novatek NT35532
 LCD DSI
Message-ID: <20260328-nondescript-bipedal-cow-39d00f@quoll>
References: <20260327-rimob-new-features-v4-0-06edff9c4509@protonmail.com>
 <20260327-rimob-new-features-v4-1-06edff9c4509@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260327-rimob-new-features-v4-1-06edff9c4509@protonmail.com>
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

On Fri, Mar 27, 2026 at 03:30:47PM +0100, Cristian Cozzolino wrote:
> Document Novatek NT35532-based DSI display panel.
> Since it's not possible to identify panel vendor nor id, add a suitable
> compatible (matching the device's user, which makes use of this DDIC)
> and set "novatek,nt35532" as fallback.
> 
> Signed-off-by: Cristian Cozzolino <cristian_ci@protonmail.com>

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

