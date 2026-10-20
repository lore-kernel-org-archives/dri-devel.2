Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 839D3606A319
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 08:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X1QbPGdg
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F401A10F3CA;
	Tue, 20 Oct 2026 08:29:11 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 75CD410F3A1
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 08:28:59 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 961C060534;
 Tue, 20 Oct 2026 08:28:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D432C1F000C4;
 Tue, 20 Oct 2026 08:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792484938;
 bh=vyucOTsSgLZgrADiAoF4uVAGYoXy/9hXlyt8Dq2To40=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=X1QbPGdgGnyhvJgbj7nWBs0fVTqa5p3X3mLygwxpvPDz9+wfNiTKokVt0ZtNOjqUb
 9cJVxAXCFuD3SCUwfbCHTxcYB3tsU6zhrXh8vS5UymufrU7P++7C8dFUNBOsSNlK1c
 E2d6mNbN5GR6oWEY4Zk/+p4UsxGJz6e2ndGdP5oZwd1/FPmLe5EmhM8Ei0WCxECcNH
 bsMY5aEaq+fEx5ihYAfkfBb8nQLL615Xe/GUSikth3TmMaehviaPtc/VJaMDEvsQO6
 eV3pDVkCZshpB9c9lHzueJ0U+q5EGx8ORf4nzypZ42lMu6hoE1wyrN97augvkuf7tF
 FRQFMtjq4blYA==
Date: Tue, 20 Oct 2026 10:28:52 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Frank.Li@oss.nxp.com
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, 
 "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>, 
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>,
 imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH v2 1/1] dt-bindings: display: sgd,gktw70sdae4se: use
 unevaluatedProperties
Message-ID: <20261020-artificial-olive-mushroom-b798c5@quoll>
References: <20261019205000.1084408-1-Frank.Li@oss.nxp.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261019205000.1084408-1-Frank.Li@oss.nxp.com>
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

On Mon, Oct 19, 2026 at 04:50:00PM -0400, Frank.Li@oss.nxp.com wrote:
> From: Frank Li <Frank.Li@nxp.com>
> 
> Use unevaluatedProperties replace additionalProperties because it ref
> other yaml file to allow backlight and label property.
> 
> Drop panel-timing and port, which copy from panel-common.yaml. Others have
> additional restrictions.
> 
> Fix below CHECK_DTBS warning:
>   arch/arm/boot/dts/nxp/imx/imx6q-var-dt6customboard.dtb: lvds-panel (sgd,gktw70sdae4se): 'backlight', 'label' do not match any of the regexes: '^pinctrl-[0-9]+$'
>         from schema $id: http://devicetree.org/schemas/display/panel/sgd,gktw70sdae4se.yaml
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> changes in v2:
> - drop panel-timing and port

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

