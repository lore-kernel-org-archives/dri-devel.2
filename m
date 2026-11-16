Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FBF7606A329
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 13:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FEAgMfR4
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A996810F13B;
	Mon, 16 Nov 2026 13:12:11 +0000 (UTC)
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com
 [209.85.210.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CDE0210E3D8
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 10:53:28 +0000 (UTC)
Received: by mail-pf1-f181.google.com with SMTP id
 d2e1a72fcca58-8b4c8b51b58so2840729b3a.1
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 02:53:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794826408; x=1795431208; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=PAvLjaQHm95bpI85WuhjYZDGCvdWFtQOLeuhomlJrGw=;
 b=FEAgMfR4iXyFm/Z1p5M5Sjb9UIGk2wjot7a1eUwcSscmktk421oNORrh+sAydp6lcN
 cLU7NKD7SVv3fDTFTP3wzXvzEaaenSYv7FlLGLJOYKkLoictnN18BQDT9p23PP5UkAYo
 TjxfNKLlEdcVuscYg6c5TnN8c5Uec5i6F06KI3OzTvBxP76ytAbKVG5PUFmfIl//tx1+
 tObWOgR3mK/eo8+h+yzsW2oqg08Zs5WTki9Ps61OuIVtR1Rg0WSkHIrv8zbsS2atqk3K
 +LTv/4vSwWBY9LgLerhcNkwu0gmRp6C248xile7CbcbSBEx2riHkjkGbMa430ophFmTE
 ROVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794826408; x=1795431208;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=PAvLjaQHm95bpI85WuhjYZDGCvdWFtQOLeuhomlJrGw=;
 b=0DjQ2WOhHoOTR/wuyp9gJcL3qmv8JB0g4MdmtRHgjNXOZoojReHVOLeEM+Q4sQhqVY
 o0/pLQhMDWuZ/Tl/IIWypH7vyHWnpv9QcTwI0CZQ765Tf1oz/510+b8uTqreF2wRPgaF
 O8l63CWQR39/LIZSZUOymJlHhYs1jlbvpdOFsupaXjMy2sFyiPU8VS2rBH+n6nKsCyzl
 1obv8QjwM94uRT8JstTMZpXzjFMNKBPeXUrgLFIgW6MS/3y9CJ3onsQN10tdGqPkWgbj
 Qj59sMV7/GKR+6f6fS8+o9wF+6ySRa78bsiC5VU1kINfIH+oJT9OOtC7jr3yyYtespBn
 MIYA==
X-Gm-Message-State: APuU4Z/zNAiyz+Hprs8tt4xBX01sVY8Q8TjHCQpVJDkbLJYeQisvpxey
 go81sq8DNa1fyIEZ6H3KntCJRHO1vpIJNraMEWId5cZI+c+KHnd/mLzE
X-Gm-Gg: AYBFou2DvD8sj3WOznX5HJvFO812SCsvG1gdjvvtSO9G/e4lHjz1JNVg534uZb1h0Zj
 GOazmg0c26/1fyPJ9EAlqU3aKjCCjLYrPYEg8B/x932a+DSuS4+wdmyQjqIw4Q6gzcV338NCfuC
 jRO/bX/Qfqr+uFUVfg6IULKyqElfFN/naiTt0irHvQBfPzSdDYoOjJOcYFtxAZs4rQGQV5u38Tv
 RB7UVCdNtHgMf9zXz88Y0h5V2acga30FlBnWBYtw7S8uUdNYbUbZRhiczLETTSAV3g7YIJB7zxy
 aBKba5udQbSjMWT6SvxO3RJ97YxpMgoUgoaHgq+mS913LtLgCyr6bUWjbTG69s36akj+gzsNEkL
 f5Bm7eBUH+OBZhIkMfPTHFlmCabqciQRspoVzQk8l6GK8fg1ZFFFWV+Hjda0NXhQJZhmSajywdv
 ETHzl9CLIbvIuGrd4z9UA54KTiOrULO/nR5pP9mfrOHf4nhgE1n5UBA8SzbEBB+b7y7r/K1Gqra
 lclT/z4k4Jhp7M1yFEsNmbFuQnvFLW8/AMi++pEwuKyG9oW6i43O0zq3ISpanoi+Ra4L/UiZdQn
 FSWahOzFHEI6yre9+JPAIdY/Qio3yNvlPoI=
X-Received: by 2002:a05:6a00:94c4:b0:89d:7f51:6492 with SMTP id
 d2e1a72fcca58-8beb65953fdmr9351345b3a.32.1794826408064; 
 Mon, 16 Nov 2026 02:53:28 -0800 (PST)
Received: from leonardoc-nb ([67.159.246.222])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8bed263b354sm3407230b3a.47.2026.11.16.02.53.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 02:53:27 -0800 (PST)
Date: Mon, 16 Nov 2026 07:53:20 -0300
From: Leonardo Costa <leoreis.costa@gmail.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Leonardo Costa <leonardo.costa@toradex.com>, stable@vger.kernel.org
Subject: Re: [PATCH] drm/bridge: simple-bridge: Enforce input bus flags via
 atomic_check
Message-ID: <mvwowftpwgn6vypc25fkqgajpizsnnmkceoaclot4ms2b43y56@q2oiqnpwrled>
References: <20261002-v1-simple-bridge-atomic-check-v1-1-ef5d8332b078@toradex.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261002-v1-simple-bridge-atomic-check-v1-1-ef5d8332b078@toradex.com>
X-Mailman-Approved-At: Mon, 16 Nov 2026 13:12:05 +0000
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
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi all,

On Fri, Oct 02, 2026 at 04:15:23AM -0300, Leonardo Costa wrote:
> From: Leonardo Costa <leonardo.costa@toradex.com>
> 
> The input bus flags set at each bridge's timings are never actually
> added to the bridge state and are not considered during modeset.
> 
> Implement the atomic_check function, to allow simple bridges to declare
> their required input bus flags.
> 
> Existing bridges that configure specific flags (currently the ADV7123
> and THS813* bridges, which set DRM_BUS_FLAG_PIXDATA_SAMPLE_POSEDGE) now
> write them to their bridge state, and have them propagated to the
> previous bridge in the pipeline.
> 
> Fixes: 0a01de65a741 ("drm/bridge: simple-bridge: Switch to atomic bridge callbacks")
> Cc: stable@vger.kernel.org
> Signed-off-by: Leonardo Costa <leonardo.costa@toradex.com>
> ---
>  drivers/gpu/drm/bridge/simple-bridge.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/gpu/drm/bridge/simple-bridge.c b/drivers/gpu/drm/bridge/simple-bridge.c
> index 3fba7002322e9..848c2df2a276a 100644
> --- a/drivers/gpu/drm/bridge/simple-bridge.c
> +++ b/drivers/gpu/drm/bridge/simple-bridge.c
> @@ -158,11 +158,23 @@ static void simple_bridge_disable(struct drm_bridge *bridge,
>  		regulator_disable(sbridge->vdd);
>  }
>  
> +static int simple_bridge_atomic_check(struct drm_bridge *bridge,
> +				      struct drm_bridge_state *bridge_state,
> +				      struct drm_crtc_state *crtc_state,
> +				      struct drm_connector_state *conn_state)
> +{
> +	if (bridge->timings)
> +		bridge_state->input_bus_cfg.flags = bridge->timings->input_bus_flags;
> +
> +	return 0;
> +}
> +
>  static const struct drm_bridge_funcs simple_bridge_bridge_funcs = {
>  	.atomic_create_state = drm_atomic_helper_bridge_create_state,
>  	.atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
>  	.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
>  	.attach		= simple_bridge_attach,
> +	.atomic_check = simple_bridge_atomic_check,
>  	.atomic_enable = simple_bridge_enable,
>  	.atomic_disable = simple_bridge_disable,
>  };
> 
> ---
> base-commit: 6c2cb8b8b843d216ab549b678a0d8831c43153e0
> change-id: 20261001-v1-simple-bridge-atomic-check-e7b7eb8381e9
> 
> Best regards,
> -- 
> Leonardo Costa <leonardo.costa@toradex.com>
> 

Just gentle ping, could we get this fix merged?

Best regards,
Leonardo
