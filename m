Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D5CE606A31B
	for <dri-devel@archiver.kernel.org>; Fri, 23 Oct 2026 09:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FU8TCa39
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A9C4B10E600;
	Fri, 23 Oct 2026 09:29:45 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2607810E600
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 09:29:39 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D9F9A405A9;
 Fri, 23 Oct 2026 09:29:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A82B1F031E2;
 Fri, 23 Oct 2026 09:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792747778;
 bh=WH6ppsWJmNp7XsRvR8E8E9xrLV/H91K1v+S1jWsOr98=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=FU8TCa39PytfbnkRY4DJctKSSCC37mFhtmkpTw/Q94ZEsGIoe0POJ9U45KcVMVCmA
 X93457lPUGQNQhbMzjXZi9TtOhLLJEEnns5i04OVWAR5ItVlUMr8IBGUf1yh2/z22r
 rKMGp6BOFV5sKqpCWzTup7fm3xngwwuN/4UF1FI0X99Fmm00H/fg5h4dOOIdUFlSCe
 BOOaHM99eoXMiHFuQ54EgmIB2LRNPgrrOVrxbfDorOvOjn/6+4I8U3cJNbwOKsk9j8
 xEKFYMbNIVB5SqBM/YLYBAj82ZRmlVeqGjGFk3hBn1s6sE4NT3nOhIZKltMUMaw0MN
 yU9Jcki0kExtw==
Date: Fri, 23 Oct 2026 11:29:36 +0200
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
Subject: Re: [PATCH v3 2/7] dt-bindings: display: simple: Add
 waiken,101wx001-wct
Message-ID: <20261023-apricot-hawk-of-spirit-267aed@quoll>
References: <20261020-dxl_lcdif-v3-0-adc944659e14@nxp.com>
 <20261020-dxl_lcdif-v3-2-adc944659e14@nxp.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261020-dxl_lcdif-v3-2-adc944659e14@nxp.com>
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

On Tue, Oct 20, 2026 at 04:12:52PM -0400, Frank.Li@oss.nxp.com wrote:
> From: Frank Li <Frank.Li@nxp.com>
> 
> Add WKS101WX001-WCT panel, which is an industrial-grade 10.1-inch IPS TFT
> LCD capacitive touch screen display module.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> change in v3
> - Use Waiken Technology Limited in description
> - Use 10.1" at comments
> - Use waiken,101wx001-wct

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

