Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4814606A32E
	for <dri-devel@archiver.kernel.org>; Fri, 23 Oct 2026 09:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SAMiazq0
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E0B6B10E5DA;
	Fri, 23 Oct 2026 09:28:21 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F150B10E5DA
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 09:28:15 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id DA6FB602C3;
 Fri, 23 Oct 2026 09:28:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B14DC1F01825;
 Fri, 23 Oct 2026 09:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792747694;
 bh=tlePnP3GE78vbgKi5tLSYix5xa2MNZBwLKVMInUWwZ8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=SAMiazq0h/d4fr7VYelFNOoHhHhBYWz8XP8e8Tkhw420EvwAw9Umtlm16H1x+YAm1
 yspCfKmJlVDvuuz+DX8MhDfHgXkciawgUp/iHUmny3Ge3LUZy0rWnXMJwC5RgA5TxB
 QheRdXq+kNXoukztdjuAkaUr/0vjNROT5NeJXX1hZ50T1Jh6GuYmkIWXlufDKw1BFA
 gto3ZRZcrjAX0O/8e0/1jIxI5jHnhFSvd2hH0Fx7JqNAUeOWUjzz8U5xO2ED16NYRk
 YAYnDCRbwQ5FZhjYoV+D188RwVwcg9lao1puIsFDtOCYhw4tRTxaKYaHz4QL73xdHO
 Oo/18fZpTQD2A==
Date: Fri, 23 Oct 2026 11:28:11 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Frank.Li@oss.nxp.com
Cc: Marek Vasut <marex@denx.de>, Stefan Agner <stefan@agner.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Thierry Reding <thierry.reding@gmail.com>, Sam Ravnborg <sam@ravnborg.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, 
 Robert Chiras <robert.chiras@nxp.com>, Liu Ying <victor.liu@nxp.com>,
 Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH v3 1/7] dt-bindings: lcdif: add compatible string for
 i.MX8QXP and i.MX8DXL
Message-ID: <20261023-uppish-invincible-chinchilla-cf8a47@quoll>
References: <20261020-dxl_lcdif-v3-0-adc944659e14@nxp.com>
 <20261020-dxl_lcdif-v3-1-adc944659e14@nxp.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261020-dxl_lcdif-v3-1-adc944659e14@nxp.com>
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Oct 20, 2026 at 04:12:51PM -0400, Frank.Li@oss.nxp.com wrote:
> From: Frank Li <Frank.Li@nxp.com>
> 
> i.MX8QXP and i.MX8DXL have lcdif, which back compatible with i.MX6SX. Add
> front compatible string "fsl,imx8dxl-lcdif" and "fsl,imx8qxp-lcdif", which
> fallback to "fsl,imx6sx-lcdif".
> 
> Required power-domains for both. Required 3 clocks and clock-names.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

