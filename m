Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C68606A31A
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 08:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DxXqkW9E
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A3C710EC2D;
	Mon, 26 Oct 2026 08:04:23 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A4B0F10EC43
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 08:04:16 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5C9DE40128;
 Mon, 26 Oct 2026 08:04:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 425F31F01825;
 Mon, 26 Oct 2026 08:04:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793001856;
 bh=gEr8Jp+Ny4YtsUekpUShINHIGkwK2BkTrE3Zld9rNuw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=DxXqkW9E+JzaMAvDiRXG0Xzi6+JdRIL4xCzN2V6egLlB7qKOjaKgYOaVW+dpK/rn6
 MpNO++pB342va2JOO4oKNtWCcBq4yq2eO4k3m4JLKjku9kzVmCY5qZ4aIxBWaucifk
 vZVph1+iuIqlUE6xWzJKqO+P55aPZIJUg5YQFFy1FkKN72GILaqhlHiBlcxzt/zZhf
 3Yd+rs68rnrk7wVTrO54XuE/V4rU8zzKh/cyyNVDSNZpj3OP0EA8CZbp4ibyg4ve6B
 W+38Au+p4pgbu32P3djgPbdGBMP6pR1xTfBaZFg43Tl81trUPI2J5tO/rL5Igbeuu9
 2GXZP5oWCACQA==
Date: Mon, 26 Oct 2026 09:04:12 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Ishu Brar <patches@brar.si>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: display: panel: Add Samsung AMS644VK04
Message-ID: <20261026-petite-ultramarine-barnacle-4ca4db@quoll>
References: <20261023-panel-ams644vk04-v1-0-56096aecd0ff@brar.si>
 <20261023-panel-ams644vk04-v1-1-56096aecd0ff@brar.si>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261023-panel-ams644vk04-v1-1-56096aecd0ff@brar.si>
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
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Oct 23, 2026 at 01:51:16PM +0530, Ishu Brar wrote:
> +...
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a08087fb6..1eec53b0e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8462,6 +8462,12 @@ S:	Maintained
>  F:	Documentation/devicetree/bindings/display/panel/raydium,rm69220.yaml
>  F:	drivers/gpu/drm/panel/panel-raydium-rm69220.c
>  
> +DRM DRIVER FOR SAMSUNG AMS644VK04 PANEL
> +M:	Ishu Brar <patches@brar.si>
> +S:	Maintained
> +T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git

Drop, unless you are committer there. There is little point in
duplicating subsystem data in individual entries.

With this fixed:

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

