Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41541606A31B
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 07:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kK6KAtcp
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A240910E09D;
	Mon, 26 Oct 2026 07:51:45 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 04F8A10E263
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 07:51:39 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 545E6600CB;
 Mon, 26 Oct 2026 07:51:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BF581F01825;
 Mon, 26 Oct 2026 07:51:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793001098;
 bh=ReopTLtwQNEVhs7qRFvgKJ+ZmFHz1cCFpaMGBdlN7ds=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=kK6KAtcpcJVtoleORKRGvQMTbkBoXD6YMNGx/enpf+xC5rMP/oswCcruMBvWnxCVb
 09gboOOnQYNlQgt4cSaAZhBLWhfSVpuNq9NzxvM0UiWrLykPMgkZPt+rVdFngQChet
 cV0Wke/cdj5gDrWaPCG5jsaMbR/kST2oO+jDHGfyGfHFtAS0qwhf3RJtK6HALcr9aq
 ffYblwaIm+2djIWwu9R9qj0k6vBwfJwFEKXmIclifXTkCFxZPAPMTfd0MP6hxBeXaI
 j0u9OEX5daFxBICOSYnIHtKIpT8MqxcUSPM4g5i5JKcxORGxBxEx/nLOXtru05DHFm
 Yt9lksUulWEkg==
Date: Mon, 26 Oct 2026 08:51:34 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Tomeu Vizoso <tomeu.vizoso@gmail.com>
Cc: Nishanth Menon <nm@ti.com>, "Andrew F. Davis" <afd@ti.com>, 
 Randolph Sapp <rs@ti.com>, Jonathan Humphreys <j-humphreys@ti.com>, 
 Andrei Aldea <a-aldea@ti.com>, Chirag Shilwant <c-shilwant@ti.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Beleswar Padhi <b-padhi@ti.com>,
 Tero Kristo <kristo@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Oded Gabbay <ogabbay@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Sumit Semwal <sumit.semwal@linaro.org>, 
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Robert Nelson <robertcnelson@gmail.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>,
 Jani Nikula <jani.nikula@linux.intel.com>, 
 Tvrtko Ursulin <tursulin@ursulin.net>, Markus Elfring <Markus.Elfring@web.de>, 
 Bjorn Andersson <andersson@kernel.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>, 
 Suman Anna <s-anna@ti.com>, Kees Cook <kees@kernel.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-doc@vger.kernel.org, 
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org, 
 Tomeu Vizoso <tomeu@tomeuvizoso.net>, linux-remoteproc@vger.kernel.org, 
 linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3 03/16] dt-bindings: remoteproc: k3-dsp: Allow
 referencing the timers' power domains
Message-ID: <20261026-encouraging-musical-piculet-debfeb@quoll>
References: <20261023-thames-v3-0-3ab40aa17157@tomeuvizoso.net>
 <20261023-thames-v3-3-3ab40aa17157@tomeuvizoso.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261023-thames-v3-3-3ab40aa17157@tomeuvizoso.net>
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

On Fri, Oct 23, 2026 at 08:39:28AM +0200, Tomeu Vizoso wrote:
> A firmware may drive the core's timers, which need their power domains
> held; the remoteproc driver does not hold them, so let the DSP node
> reference them for a driver that attaches to the running core to hold.
> 
> Assisted-by: LLM
> Signed-off-by: Tomeu Vizoso <tomeu@tomeuvizoso.net>
> 
> ---
> 
> v3:
> - Initial version
> ---
>  .../devicetree/bindings/remoteproc/ti,k3-dsp-rproc.yaml | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/remoteproc/ti,k3-dsp-rproc.yaml b/Documentation/devicetree/bindings/remoteproc/ti,k3-dsp-rproc.yaml
> index d6319c8e96f8..80eaef0a19b8 100644
> --- a/Documentation/devicetree/bindings/remoteproc/ti,k3-dsp-rproc.yaml
> +++ b/Documentation/devicetree/bindings/remoteproc/ti,k3-dsp-rproc.yaml
> @@ -76,6 +76,23 @@ properties:
>  # Optional properties:
>  # --------------------
>  
> +  power-domains:
> +    description: |
> +      Power domains of the SoC timers the running firmware ticks on and
> +      times its work out with. The firmware programs these timers itself
> +      and makes no power request for them, and the timers' own nodes are
> +      reserved for it, so nothing else requests their power; a client
> +      driver of the firmware holds them on while it drives the processor.
> +      The processor's own power is managed through ti,sci-dev-id, not here.
> +    items:
> +      - description: power domain of the first timer

first timer

> +      - description: power domain of the second timer

second timer

No need to say that power domain is a power domain.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

