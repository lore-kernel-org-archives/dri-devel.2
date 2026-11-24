Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CDC8606A321
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 08:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=U68O4hE4
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3302D10F330;
	Tue, 24 Nov 2026 08:44:04 +0000 (UTC)
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B3B3610F33B
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 08:43:57 +0000 (UTC)
Received: from [192.168.88.20] (91-158-153-178.elisa-laajakaista.fi
 [91.158.153.178])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id 66EFC12B2;
 Tue, 24 Nov 2026 09:41:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1795509684;
 bh=WMIjvho28RlUqthyqYnkSMaU4rF/YSaSR0wpYSuKHmE=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=U68O4hE4UEIFXjc+z5/gKUaDang7gg+OslRyyV/B9aPp226oHeRtw+3PaEyCe1JUZ
 /zzSHCaaTJl9Uf+sHwItrFwol88IogHAsshQaGLX6apxT0ZR14VP6DtfAR0t+JS4tx
 /6WiIMtEWOS4G7eF09qikGmB3Z+uFPbrjBCV9N0I=
Message-ID: <88fc6833-92c7-4cf7-901b-24124992f235@ideasonboard.com>
Date: Tue, 24 Nov 2026 10:43:53 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 08/42] drm/bridge: Switch print_state to use bridge name
To: Maxime Ripard <mripard@kernel.org>
Cc: Devarsh Thakkar <devarsht@ti.com>, dri-devel@lists.freedesktop.org,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Jyri Sarha <jyri.sarha@iki.fi>
References: <20261120-drm-state-readout-v9-0-a67c2b45b8ec@kernel.org>
 <20261120-drm-state-readout-v9-8-a67c2b45b8ec@kernel.org>
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Content-Language: en-US
In-Reply-To: <20261120-drm-state-readout-v9-8-a67c2b45b8ec@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 20/11/2026 14:55, Maxime Ripard wrote:
> drm_bridge_atomic_print_priv_state() currently identifies bridges by
> printing the symbol name of bridge->funcs using the %ps format
> specifier. This produces output like a raw function pointer name, which
> is not particularly user-friendly for debugging.
> 
> Since bridges now carry a human-readable name, switch to printing
> bridge->name instead. This makes the state readout output more
> consistent and easier to interpret.
> 
> Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> Reviewed-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> ---
>   drivers/gpu/drm/drm_bridge.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
> index 11aaa4ae5102..aed3fcf0e180 100644
> --- a/drivers/gpu/drm/drm_bridge.c
> +++ b/drivers/gpu/drm/drm_bridge.c
> @@ -570,13 +570,13 @@ drm_bridge_atomic_print_priv_state(struct drm_printer *p,
>   {
>   	const struct drm_bridge_state *state = drm_priv_to_bridge_state(s);
>   	struct drm_bridge *bridge = drm_priv_to_bridge(s->obj);
>   
>   	if (bridge->of_node)
> -		drm_printf(p, "bridge: %ps (%pOFfc)\n", bridge->funcs, bridge->of_node);
> +		drm_printf(p, "bridge: %s (%pOFfc)\n", bridge->name, bridge->of_node);
>   	else
> -		drm_printf(p, "bridge: %ps\n", bridge->funcs);
> +		drm_printf(p, "bridge: %s\n", bridge->name);
>   
>   	drm_printf_indent(p, 1, "input bus configuration:");
>   	drm_printf_indent(p, 2, "code: %04x", state->input_bus_cfg.format);
>   	drm_printf_indent(p, 2, "flags: %08x", state->input_bus_cfg.flags);
>   	drm_printf_indent(p, 1, "output bus configuration:");
> 

Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>

  Tomi

