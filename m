Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B45F606A335
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 08:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=eyPdpmU2
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A2E6C10F377;
	Tue, 24 Nov 2026 08:49:14 +0000 (UTC)
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B67C10F377
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 08:49:08 +0000 (UTC)
Received: from [192.168.88.20] (91-158-153-178.elisa-laajakaista.fi
 [91.158.153.178])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id 1E47DC4B;
 Tue, 24 Nov 2026 09:46:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1795509994;
 bh=s85ke5xILBKitJ20NYeyH6CMnHcFcW46+r75WiyW9Pc=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=eyPdpmU2/e3CD5SwBMFWJOnMuJfA2aaaIBh9I40bMdQPga0OSqi4q33WqvCo8JUqw
 hrExtwnRadsRyr8eac1T559RmNAHTGnLTVSSsMaTYRKg78ARe/L/dLUF5KCuyKs87S
 rYm3m2GW1OO3AXZQl/lynQETPMx0M2VtDSE1CqbQ=
Message-ID: <68703b58-0701-411a-bf86-823fc528a9f3@ideasonboard.com>
Date: Tue, 24 Nov 2026 10:49:04 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 09/42] drm/bridge: Add drm_private_obj_is_bridge()
To: Maxime Ripard <mripard@kernel.org>
Cc: Devarsh Thakkar <devarsht@ti.com>, dri-devel@lists.freedesktop.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Jyri Sarha <jyri.sarha@iki.fi>
References: <20261120-drm-state-readout-v9-0-a67c2b45b8ec@kernel.org>
 <20261120-drm-state-readout-v9-9-a67c2b45b8ec@kernel.org>
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Content-Language: en-US
In-Reply-To: <20261120-drm-state-readout-v9-9-a67c2b45b8ec@kernel.org>
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

Hi,

On 20/11/2026 14:55, Maxime Ripard wrote:
> The SRO readout helpers need to distinguish bridge-backed private
> objects from other private objects, because bridges require special
> readout ordering through the encoder bridge chains.
> 
> Add drm_private_obj_is_bridge() which checks whether a private
> object's funcs pointer matches the bridge private state funcs.
> 
> Reviewed-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> ---
>   drivers/gpu/drm/drm_bridge.c | 15 +++++++++++++++
>   include/drm/drm_bridge.h     |  2 ++
>   2 files changed, 17 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
> index aed3fcf0e180..b6cdbc172f68 100644
> --- a/drivers/gpu/drm/drm_bridge.c
> +++ b/drivers/gpu/drm/drm_bridge.c
> @@ -589,10 +589,25 @@ static const struct drm_private_state_funcs drm_bridge_priv_state_funcs = {
>   	.atomic_duplicate_state = drm_bridge_atomic_duplicate_priv_state,
>   	.atomic_destroy_state = drm_bridge_atomic_destroy_priv_state,
>   	.atomic_print_state = drm_bridge_atomic_print_priv_state,
>   };
>   
> +/**
> + * drm_private_obj_is_bridge - check if a private object backs a bridge
> + * @obj: private object to check
> + *
> + * RETURNS:
> + *
> + * True if @obj is the &drm_private_obj embedded in a &struct drm_bridge,
> + * false otherwise.
> + */
> +bool drm_private_obj_is_bridge(struct drm_private_obj *obj)
> +{
> +	return obj && obj->funcs == &drm_bridge_priv_state_funcs;
> +}
> +EXPORT_SYMBOL(drm_private_obj_is_bridge);
> +
>   /**
>    * drm_bridge_attach - attach the bridge to an encoder's chain
>    *
>    * @encoder: DRM encoder
>    * @bridge: bridge to attach
> diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
> index 54cf0d223bba..a22a0bdf3251 100644
> --- a/include/drm/drm_bridge.h
> +++ b/include/drm/drm_bridge.h
> @@ -1232,10 +1232,12 @@ static inline struct drm_bridge *
>   drm_priv_to_bridge(struct drm_private_obj *priv)
>   {
>   	return container_of(priv, struct drm_bridge, base);
>   }
>   
> +bool drm_private_obj_is_bridge(struct drm_private_obj *obj);
> +
>   bool drm_bridge_enter(struct drm_bridge *bridge, int *idx);
>   void drm_bridge_exit(int idx);
>   void drm_bridge_unplug(struct drm_bridge *bridge);
>   
>   struct drm_bridge *drm_bridge_get(struct drm_bridge *bridge);
> 

I can't help but feel that this is a bit hacky. Nevertheless, it's 
simple and I understand the need to deal with bridges with SRO.

Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>

  Tomi

