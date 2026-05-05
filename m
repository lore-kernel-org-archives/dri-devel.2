Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5FD4CD13DA
	for <dri-devel@archiver.kernel.org>; Tue,  5 May 2026 07:23:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 122D610E03F;
	Tue,  5 May 2026 07:23:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="KK/tRHoj";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 99E2710E03F
 for <dri-devel@lists.freedesktop.org>; Tue,  5 May 2026 07:23:07 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 5B0E8404FC;
 Tue,  5 May 2026 07:23:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A85C3C2BCB4;
 Tue,  5 May 2026 07:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777965787;
 bh=3BtQrd+NUk0P1mGoJXaCFFD0wXEpuR2Jz+eNtx6jV/E=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=KK/tRHojvi0M8VolIkN2K06EyOE+Kvg5JsWZqDZNod4JhuRIuiuSaxaoYMsNsZXMv
 j1KwX4FraJ11JXTtzpXvLOQ/nRWuyobpMmDsffawPH33etDbgY1cNB7HcUFid0oWcf
 /0DzJBlhXDIkWQRyFvQgeQ8W429l3H3O95jGFFI+vDOZ9+oMP713/DpDojd1La6bel
 SJOHb/Q4oRjGQKVcZL8rP1n2jcsdAyxPjVs5PjuaRd0s/zFD343cAZdsNHehUGgxbO
 iGqhmN8RXSROnFt2A7zptIHHmgvhWtapwcPGtNpyb/8irl32VbwPXNbwXMtmKL0cre
 Dn5Y7KDXs3fLg==
Date: Tue, 5 May 2026 09:23:04 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: display: panel: document the Renesas
 R63419 based dual-DSI video mode Display Panels
Message-ID: <20260505-tunneling-antique-degu-1dfc60@quoll>
References: <20260504-topic-sm8650-ayaneo-pocket-s2-r63419-v3-0-9f61cf24aebf@linaro.org>
 <20260504-topic-sm8650-ayaneo-pocket-s2-r63419-v3-1-9f61cf24aebf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260504-topic-sm8650-ayaneo-pocket-s2-r63419-v3-1-9f61cf24aebf@linaro.org>
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

On Mon, May 04, 2026 at 10:02:05AM +0200, Neil Armstrong wrote:
> Document the Renesas R63419 based dual-DSI video mode Display Panels found
> in the Ayaneo gaming handled devices.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  .../bindings/display/panel/renesas,r63419.yaml     | 97 ++++++++++++++++++++++
>  1 file changed, 97 insertions(+)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

