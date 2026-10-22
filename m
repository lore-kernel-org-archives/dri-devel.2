Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D97C606A319
	for <dri-devel@archiver.kernel.org>; Thu, 22 Oct 2026 21:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=nw2imRty
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A64010E4C8;
	Thu, 22 Oct 2026 21:01:21 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DDFFD10E4C8
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 21:01:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
 MIME-Version:Date:Message-ID:From:Reply-To;
 bh=FxX5EBvMM3Ts4o/2IPFmJrwKpQrRzNfPkqphacz/F4k=; b=nw2imRtyFUJJxGC97qszk9Jefh
 mVjwkueA7/PPfCLoB3GUVJ5Nvncih9iNe5aOpgzOJBBv0NOC8XVCrsmpBmG8q5tooaxofZZgt0QNJ
 Qu+NlBuFepYAwSd0/Hfs3sQiTgUL4e6suWx9JKf+eS5KaWprtDVvuuNhEn/bvE/SowH7W4gR+vR2m
 W9ru/w+SZR3/axj4tXsRZSVt5R1ZVJynpwn6cNA/vsh24H5VcX2J8o4IZQP+HJ5mkAEzpbnp+prRG
 Ue9iJVXyGExcGc7fuPP9rmMRWj/QmS9zM7o2FvVAe2i3B/KYsfCgDzQGYmIJBUnyQnPzKFjq+S4fJ
 A9+U6FLA==;
Received: from [179.105.94.163] (helo=[192.168.0.2])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1xJzuM-007B1J-6m; Thu, 22 Oct 2026 23:01:06 +0200
Message-ID: <c1f76b88-ba69-431d-be22-1277be5a7b89@igalia.com>
Date: Thu, 22 Oct 2026 18:01:02 -0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/59] drm/atomic-state-helper: Rename
 connector_tv_reset to state_init
To: Maxime Ripard <mripard@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Chen-Yu Tsai <wens@kernel.org>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 Samuel Holland <samuel@sholland.org>, linux-sunxi@lists.linux.dev
References: <20261022-drm-no-more-connector-reset-v2-0-0b7e4e85b1e8@kernel.org>
 <20261022-drm-no-more-connector-reset-v2-3-0b7e4e85b1e8@kernel.org>
From: =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Content-Language: en-US
Autocrypt: addr=mcanal@igalia.com; keydata=
 xsBNBGcCwywBCADgTji02Sv9zjHo26LXKdCaumcSWglfnJ93rwOCNkHfPIBll85LL9G0J7H8
 /PmEL9y0LPo9/B3fhIpbD8VhSy9Sqz8qVl1oeqSe/rh3M+GceZbFUPpMSk5pNY9wr5raZ63d
 gJc1cs8XBhuj1EzeE8qbP6JAmsL+NMEmtkkNPfjhX14yqzHDVSqmAFEsh4Vmw6oaTMXvwQ40
 SkFjtl3sr20y07cJMDe++tFet2fsfKqQNxwiGBZJsjEMO2T+mW7DuV2pKHr9aifWjABY5EPw
 G7qbrh+hXgfT+njAVg5+BcLz7w9Ju/7iwDMiIY1hx64Ogrpwykj9bXav35GKobicCAwHABEB
 AAHNIE1hw61yYSBDYW5hbCA8bWNhbmFsQGlnYWxpYS5jb20+wsCRBBMBCAA7FiEE+ORdfQEW
 dwcppnfRP/MOinaI+qoFAmcCwywCGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgkQ
 P/MOinaI+qoUBQgAqz2gzUP7K3EBI24+a5FwFlruQGtim85GAJZXToBtzsfGLLVUSCL3aF/5
 O335Bh6ViSBgxmowIwVJlS/e+L95CkTGzIIMHgyUZfNefR2L3aZA6cgc9z8cfow62Wu8eXnq
 GM/+WWvrFQb/dBKKuohfBlpThqDWXxhozazCcJYYHradIuOM8zyMtCLDYwPW7Vqmewa+w994
 7Lo4CgOhUXVI2jJSBq3sgHEPxiUBOGxvOt1YBg7H9C37BeZYZxFmU8vh7fbOsvhx7Aqu5xV7
 FG+1ZMfDkv+PixCuGtR5yPPaqU2XdjDC/9mlRWWQTPzg74RLEw5sz/tIHQPPm6ROCACFls7A
 TQRnAsMsAQgAxTU8dnqzK6vgODTCW2A6SAzcvKztxae4YjRwN1SuGhJR2isJgQHoOH6oCItW
 Xc1CGAWnci6doh1DJvbbB7uvkQlbeNxeIz0OzHSiB+pb1ssuT31Hz6QZFbX4q+crregPIhr+
 0xeDi6Mtu+paYprI7USGFFjDUvJUf36kK0yuF2XUOBlF0beCQ7Jhc+UoI9Akmvl4sHUrZJzX
 LMeajARnSBXTcig6h6/NFVkr1mi1uuZfIRNCkxCE8QRYebZLSWxBVr3h7dtOUkq2CzL2kRCK
 T2rKkmYrvBJTqSvfK3Ba7QrDg3szEe+fENpL3gHtH6h/XQF92EOulm5S5o0I+ceREwARAQAB
 wsB2BBgBCAAgFiEE+ORdfQEWdwcppnfRP/MOinaI+qoFAmcCwywCGwwACgkQP/MOinaI+qpI
 zQf+NAcNDBXWHGA3lgvYvOU31+ik9bb30xZ7IqK9MIi6TpZqL7cxNwZ+FAK2GbUWhy+/gPkX
 it2gCAJsjo/QEKJi7Zh8IgHN+jfim942QZOkU+p/YEcvqBvXa0zqW0sYfyAxkrf/OZfTnNNE
 Tr+uBKNaQGO2vkn5AX5l8zMl9LCH3/Ieaboni35qEhoD/aM0Kpf93PhCvJGbD4n1DnRhrxm1
 uEdQ6HUjWghEjC+Jh9xUvJco2tUTepw4OwuPxOvtuPTUa1kgixYyG1Jck/67reJzMigeuYFt
 raV3P8t/6cmtawVjurhnCDuURyhUrjpRhgFp+lW8OGr6pepHol/WFIOQEg==
In-Reply-To: <20261022-drm-no-more-connector-reset-v2-3-0b7e4e85b1e8@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 22/10/26 09:31, Maxime Ripard wrote:
> Recent commits renamed other reset helpers to use the state_init
> suffix when they only initialize properties rather than allocate or
> update the object state itself.
> 
> drm_atomic_helper_connector_tv_reset() falls in the same category:
> it initializes the analog TV properties from the kernel command line
> defaults without allocating any state. It also reads the connector
> state through connector->state, coupling it to the reset path.
> 
> Rename it to drm_atomic_helper_connector_tv_state_init() and pass
> the connector state explicitly as a parameter. This decouples it
> from the reset hook and prepares for the conversion to
> atomic_create_state where connector->state is not yet assigned.
> 
> Signed-off-by: Maxime Ripard <mripard@kernel.org>

Reviewed-by: Maíra Canal <mcanal@igalia.com>

Best regards,
- Maíra
> ---
> Cc: "Maíra Canal" <mcanal@igalia.com>
> Cc: Chen-Yu Tsai <wens@kernel.org>
> Cc: Dave Stevenson <dave.stevenson@raspberrypi.com>
> Cc: Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>
> Cc: Samuel Holland <samuel@sholland.org>
> Cc: linux-sunxi@lists.linux.dev
> ---
>   drivers/gpu/drm/drm_atomic_state_helper.c | 13 +++++++------
>   drivers/gpu/drm/sun4i/sun4i_tv.c          |  2 +-
>   drivers/gpu/drm/vc4/vc4_vec.c             |  2 +-
>   include/drm/drm_atomic_state_helper.h     |  3 ++-
>   4 files changed, 11 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_atomic_state_helper.c b/drivers/gpu/drm/drm_atomic_state_helper.c
> index 565947c544fe..3534925636d5 100644
> --- a/drivers/gpu/drm/drm_atomic_state_helper.c
> +++ b/drivers/gpu/drm/drm_atomic_state_helper.c
> @@ -502,14 +502,15 @@ EXPORT_SYMBOL(drm_atomic_helper_connector_tv_margins_state_init);
>   
>   /**
> - * drm_atomic_helper_connector_tv_reset - Resets Analog TV connector properties
> + * drm_atomic_helper_connector_tv_state_init - Initializes Analog TV connector properties
> + * @state: the DRM state object
>    * @connector: DRM connector
>    *
> - * Resets the analog TV properties attached to a connector
> + * Initializes the analog TV properties attached to a connector
>    */
> -void drm_atomic_helper_connector_tv_reset(struct drm_connector *connector)
> +void drm_atomic_helper_connector_tv_state_init(struct drm_connector_state *state,
> +					       struct drm_connector *connector)
>   {
>   	struct drm_device *dev = connector->dev;
>   	struct drm_cmdline_mode *cmdline = &connector->cmdline_mode;
> -	struct drm_connector_state *state = connector->state;
>   	struct drm_property *prop;
>   	uint64_t val;
> @@ -572,7 +573,7 @@ void drm_atomic_helper_connector_tv_reset(struct drm_connector *connector)
>   			state->tv.hue = val;
>   
> -	drm_atomic_helper_connector_tv_margins_state_init(connector->state, connector);
> +	drm_atomic_helper_connector_tv_margins_state_init(state, connector);
>   }
> -EXPORT_SYMBOL(drm_atomic_helper_connector_tv_reset);
> +EXPORT_SYMBOL(drm_atomic_helper_connector_tv_state_init);
>   
>   /**
> diff --git a/drivers/gpu/drm/sun4i/sun4i_tv.c b/drivers/gpu/drm/sun4i/sun4i_tv.c
> index ce22f1662c0c..ea86f8a6a35e 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_tv.c
> +++ b/drivers/gpu/drm/sun4i/sun4i_tv.c
> @@ -409,5 +409,5 @@ static void sun4i_tv_connector_reset(struct drm_connector *connector)
>   {
>   	drm_atomic_helper_connector_reset(connector);
> -	drm_atomic_helper_connector_tv_reset(connector);
> +	drm_atomic_helper_connector_tv_state_init(connector->state, connector);
>   }
>   
> diff --git a/drivers/gpu/drm/vc4/vc4_vec.c b/drivers/gpu/drm/vc4/vc4_vec.c
> index 215b5d3dc5c5..7ab77f97df31 100644
> --- a/drivers/gpu/drm/vc4/vc4_vec.c
> +++ b/drivers/gpu/drm/vc4/vc4_vec.c
> @@ -381,5 +381,5 @@ static void vc4_vec_connector_reset(struct drm_connector *connector)
>   {
>   	drm_atomic_helper_connector_reset(connector);
> -	drm_atomic_helper_connector_tv_reset(connector);
> +	drm_atomic_helper_connector_tv_state_init(connector->state, connector);
>   }
>   
> diff --git a/include/drm/drm_atomic_state_helper.h b/include/drm/drm_atomic_state_helper.h
> index 4dac741af22c..5e8619aeef21 100644
> --- a/include/drm/drm_atomic_state_helper.h
> +++ b/include/drm/drm_atomic_state_helper.h
> @@ -72,5 +72,6 @@ void drm_atomic_helper_connector_reset(struct drm_connector *connector);
>   struct drm_connector_state *
>   drm_atomic_helper_connector_create_state(struct drm_connector *connector);
> -void drm_atomic_helper_connector_tv_reset(struct drm_connector *connector);
> +void drm_atomic_helper_connector_tv_state_init(struct drm_connector_state *state,
> +					       struct drm_connector *connector);
>   int drm_atomic_helper_connector_tv_check(struct drm_connector *connector,
>   					 struct drm_atomic_commit *state);
> 

