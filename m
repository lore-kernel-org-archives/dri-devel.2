Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B00DC88E75
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 10:41:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 610D010F388;
	Tue, 15 Sep 2026 10:41:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="iU6AAjkP";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 75B3C10F388
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 10:41:39 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A088D6025F;
 Tue, 15 Sep 2026 10:41:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E0341F000FF;
 Tue, 15 Sep 2026 10:41:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789468898;
 bh=Z3n8Dt8JvPMMO8BuW7lqztk2z8qFFdCmvnz/BIiU4i4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=iU6AAjkPFj9Hj++Naq1Vg/Iw8Lq0NmiMSmqpadRnNFRqDno/tlBiPYKNOi6mQZUKF
 7sc+8uED3EnNp5wG1Fjn1tgFv6dVwfhqA8TJUqTSh2XVViQlfsnH9rVTYuiFx4uIE6
 CBzEIt+hSSsEGhZmHVinPX1QbgTqvxKFBKbnNDgCwejNbO5zEbjiFSYXLCeIBx3/6s
 CsU+T9SsU6C9iogqZ53Fjlb842ByauU7ePGPT0OdagNK6mCPFEbU+bRFeNgKmZDiD0
 c92vmfgMn/IMVRknXNXzN8DXVl25iAOO9t93mWY++KsrfKlNGUFXpF466DWAGjvQ0h
 nrLic9XxcCmnw==
Date: Tue, 15 Sep 2026 12:41:35 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Nickolay Goppen <setotau@mainlining.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Ryan Brue <ryanbrue.dev@gmail.com>, 
 Alexey Minnekhanov <alexeymin@minlexx.ru>, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v3 1/3] dt-bindings: display: panel: Add Novatek NT51021
Message-ID: <20260915-determined-nondescript-hedgehog-fcda08@quoll>
References: <20260913-qcom-novatek-nt51021-panels-v3-0-266bc5d7e8c9@mainlining.org>
 <20260913-qcom-novatek-nt51021-panels-v3-1-266bc5d7e8c9@mainlining.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260913-qcom-novatek-nt51021-panels-v3-1-266bc5d7e8c9@mainlining.org>
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

On Sun, Sep 13, 2026 at 05:50:16PM +0300, Nickolay Goppen wrote:
> +required:
> +  - compatible
> +  - reg
> +  - vdd-supply
> +  - avdd-supply
> +  - havdd-supply
> +  - reset-gpios
> +  - port
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |+

Drop +, not needed.

With this fixed and without fake tag applied here and to maintainers
update:

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

