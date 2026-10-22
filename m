Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9BA1606A31A
	for <dri-devel@archiver.kernel.org>; Thu, 22 Oct 2026 13:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dkZiZWN1
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 53B98112674;
	Thu, 22 Oct 2026 13:59:46 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D29BE112674;
 Thu, 22 Oct 2026 13:59:39 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8C47740998;
 Thu, 22 Oct 2026 13:59:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A05F1F000C1;
 Thu, 22 Oct 2026 13:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792677579;
 bh=IqlNBP/wAtbwQo7xZ/xZDUvg+Bkn2sMCJfu/91I8hOI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=dkZiZWN174XKTJXmy04vdO2XBnj0gggZ+RNBo3FHzwU8y9s8xOkuqq2W5NSF1zVRs
 aMEL1XCQtBfa8ZheObeswL8hxM5xkjEPVFS8+juXJQvHNA4+2I9eXqhruWTYaEy0Il
 PX1cUtufE+/NSScwArr480UhLPZs9XjBqSmVzpAXQ/iN9fYTo+rq6K7GCZaIBCCJWa
 PfA9GEYmXISsV/NEyhYuA5zQOF8bY0Zo766j3ZtE+XrYHxXJZ+mwzhmheVKo1bK+rl
 wXkuD8t9ooFA3TMgUqlN5Gn8ZzYQ7tKFsz9WBuRBt6GLu7XWpTgNsueF2Y9DmHZ4uw
 T277/UaWky2gg==
Date: Thu, 22 Oct 2026 08:59:38 -0500
From: Rob Herring <robh@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: Thierry Reding <thierry.reding@kernel.org>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Alexandre Courbot <acourbot@nvidia.com>,
 Mikko Perttunen <mperttunen@nvidia.com>,
 Aaron Kling <webgeek1234@gmail.com>, Diogo Ivo <diogo.ivo@bootlin.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/6] dt-bindings: gpu: nvidia,gk20a: Require the fuse
 clock
Message-ID: <20261022135938.GA937780-robh@kernel.org>
References: <20261016160700.3831336-1-sashal@kernel.org>
 <20261016160700.3831336-2-sashal@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261016160700.3831336-2-sashal@kernel.org>
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Oct 16, 2026 at 12:06:54PM -0400, Sasha Levin wrote:
> The GM20B on Tegra210 often fails to initialize unless the fuse clock
> is running while the GPU is powered, and the GPUs on the other Tegra
> generations are expected to have the same requirement. Tegra194 already
> describes the fuse clock for its GV11B.
> 
> Make the fuse clock required for all of them, and list the exact clocks
> for each GPU instead of allowing either the reference or the fuse clock
> as the third one: GM20B takes the fuse clock after its reference clock,
> the others take it after the GPU and power clocks.
> 
> The nouveau driver keeps treating the fuse clock as optional, so device
> trees that lack it continue to work as before.
> 
> Assisted-by: LLM
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  .../devicetree/bindings/gpu/nvidia,gk20a.yaml | 52 ++++++++++++++-----
>  1 file changed, 40 insertions(+), 12 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/gpu/nvidia,gk20a.yaml b/Documentation/devicetree/bindings/gpu/nvidia,gk20a.yaml
> index 4d856a8b674c5..af0ada6e02557 100644
> --- a/Documentation/devicetree/bindings/gpu/nvidia,gk20a.yaml
> +++ b/Documentation/devicetree/bindings/gpu/nvidia,gk20a.yaml
> @@ -39,18 +39,12 @@ properties:
>        Regulator for GPU supply voltage
>  
>    clocks:
> -    minItems: 2
> -    items:
> -      - description: GPU clock
> -      - description: Power clock
> -      - description: Reference or fuse clock
> +    minItems: 3
> +    maxItems: 4
>  
>    clock-names:
> -    minItems: 2
> -    items:
> -      - const: gpu
> -      - const: pwr
> -      - enum: [ ref, fuse ]
> +    minItems: 3
> +    maxItems: 4

See my reply on v1. We want to keep the names defined at the top-level 
(to avoid ever variant making up their own names).

Rob
