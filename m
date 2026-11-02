Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C43606A32F
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 11:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IOtAbMoq
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3547410ED1F;
	Mon,  2 Nov 2026 11:33:03 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6307510ED1F;
 Mon,  2 Nov 2026 11:32:57 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id DB0AA60DC0;
 Mon,  2 Nov 2026 11:32:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9770D1F00A16;
 Mon,  2 Nov 2026 11:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793619176;
 bh=XfJpU24NB6L3WzchK489NcFec+igVtMIzGuaUsha6Ls=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=IOtAbMoqAvtp86YSSc7kpLmsuK28FJr7RyvWW2IF9vFgeH6EJZucGWV79+D+TpCVm
 OhHy0Y/V8U5fX6Y+SRAkegK4GvHbZ5wBycGsTFml0HYbMZxnWWOebr1KpS4tsiF1yQ
 jfJF/fODV4xEYoixBpK47NWNrzmN9RXdZe5gjZkgQa/xJSxeA2xMHCkueLYhA4yqQa
 gxfBkvDJQp8bcwG2H+ErDj1yctHZAIGkU+hI3kK9M05N8eoSQUMpI7hPCsM/WeDSCZ
 SdZ18aHK9H9jEW2CK/9YQ4GELGF5/8xrR8qEgH4u5bcL9hJtOJLS9MS1j9gLHyt7gP
 RYQVYhpvdE3AA==
Date: Mon, 2 Nov 2026 12:32:53 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Ishu Brar <patches@brar.si>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>,
 Krishna Manikandan <quic_mkrishn@quicinc.com>, 
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] dt-bindings: display/msm: dpu: Document SM7250
Message-ID: <20261102-placid-soft-bee-b5b848@quoll>
References: <20261031-dpu-sm7250-v1-0-159f403ec405@brar.si>
 <20261031-dpu-sm7250-v1-2-159f403ec405@brar.si>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261031-dpu-sm7250-v1-2-159f403ec405@brar.si>
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

On Sat, Oct 31, 2026 at 01:23:38PM +0530, Ishu Brar wrote:
> The SM7250 DPU node has the same register regions (mdp, vbif) and the
> same four clocks (iface, bus, core, vsync) as the SM8150 and SM8250
> ones, so add its compatible to the existing qcom,sm8150-dpu.yaml
> instead of creating a new schema. qcom,sm7150-dpu.yaml is not a fit, it
> describes six clocks including rot and lut.
> 
> Signed-off-by: Ishu Brar <patches@brar.si>
> ---
>  Documentation/devicetree/bindings/display/msm/qcom,sm8150-dpu.yaml | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

