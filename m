Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62199CC6B33
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 10:41:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C57561122A9;
	Thu, 15 Oct 2026 10:41:18 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C83881122B0
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 10:41:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
 MIME-Version:Date:Message-ID:From:Reply-To;
 bh=PWYj8ru7BPIHqOSp/fiXglh4U22uI39N69/dLvV/sG0=; b=UWsBALM+RA+8VflVD8dZiyh6HP
 Hiom+jMGVoHnfzKB+q8TfE+vP2dLVDTCZoDG7DR1KjlS6jWtlFmUU1XnIeO+ii8IzMmJGkEgxivjy
 /TyIlCzyrCdYo+QRu/OrCmraUeR0uBkoLITGDZpCIfsDvrQk1dgRNkk4I0Ynyf/rp1WCvluygj8va
 kbRve4NGaZpWNuRvrQXewE2vBQeUhrsfuExGmDgxmEfKQpjTrkC0b2ooxHnpev1bnzduzlX3IcZb+
 y60sclHI6wxTwqkOeWJfNuNJkxsW1JB1F7lE2mEwBv+gshbQGR2bTOdtXxQLrlQXhjWA6Zh74aVm1
 Pm14OQCw==;
Received: from [179.105.94.163] (helo=[192.168.0.2])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1xHItS-000Uy3-21; Thu, 15 Oct 2026 12:41:02 +0200
Message-ID: <351cced9-29f0-45e9-9264-615d5f4477cf@igalia.com>
Date: Thu, 15 Oct 2026 07:40:57 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 55/75] drm/atomic-state-helper: Rename
 connector_tv_margins_reset to state_init
To: Maxime Ripard <mripard@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 Ruben Wauters <rubenru09@aol.com>
References: <20261014-drm-no-more-connector-reset-v1-0-586c9c026823@kernel.org>
 <20261014-drm-no-more-connector-reset-v1-55-586c9c026823@kernel.org>
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
In-Reply-To: <20261014-drm-no-more-connector-reset-v1-55-586c9c026823@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On 14/10/26 14:27, Maxime Ripard wrote:
> Recent commits renamed other reset helpers to use the state_init
> suffix when they only initialize properties rather than allocate or
> update the object state itself.
> 
> drm_atomic_helper_connector_tv_margins_reset() falls in the same
> category: it initializes the TV margin properties from the kernel
> command line without allocating any state. It also reads the
> connector state through connector->state, coupling it to the reset
> path.
> 
> Rename it to drm_atomic_helper_connector_tv_margins_state_init() and
> pass the connector state explicitly as a parameter. This decouples
> it from the reset hook and prepares for the conversion to
> atomic_create_state where connector->state is not yet assigned.
> 
> Signed-off-by: Maxime Ripard <mripard@kernel.org>

Reviewed-by: Maíra Canal <mcanal@igalia.com>

Best regards,
- Maíra

> ---
> Cc: "Maíra Canal" <mcanal@igalia.com>
> Cc: Dave Stevenson <dave.stevenson@raspberrypi.com>
> Cc: Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>
> Cc: Ruben Wauters <rubenru09@aol.com>
> ---
>   drivers/gpu/drm/drm_atomic_state_helper.c | 14 ++++++++------
>   drivers/gpu/drm/gud/gud_connector.c       |  3 ++-
>   drivers/gpu/drm/vc4/vc4_hdmi.c            |  3 ++-
>   include/drm/drm_atomic_state_helper.h     |  3 ++-
>   4 files changed, 14 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_atomic_state_helper.c b/drivers/gpu/drm/drm_atomic_state_helper.c
> index 406157a3660f..6238066fd5d6 100644
> --- a/drivers/gpu/drm/drm_atomic_state_helper.c
> +++ b/drivers/gpu/drm/drm_atomic_state_helper.c
> @@ -480,26 +480,27 @@ drm_atomic_helper_connector_create_state(struct drm_connector *connector)
>   	return state;
>   }
>   EXPORT_SYMBOL(drm_atomic_helper_connector_create_state);
>   
>   /**
> - * drm_atomic_helper_connector_tv_margins_reset - Resets TV connector properties
> + * drm_atomic_helper_connector_tv_margins_state_init - Initializes TV connector properties
> + * @state: the DRM State object
>    * @connector: DRM connector
>    *
> - * Resets the TV-related properties attached to a connector.
> + * Initializes the TV-related properties attached to a connector.
>    */
> -void drm_atomic_helper_connector_tv_margins_reset(struct drm_connector *connector)
> +void drm_atomic_helper_connector_tv_margins_state_init(struct drm_connector_state *state,
> +						       struct drm_connector *connector)
>   {
>   	struct drm_cmdline_mode *cmdline = &connector->cmdline_mode;
> -	struct drm_connector_state *state = connector->state;
>   
>   	state->tv.margins.left = cmdline->tv_margins.left;
>   	state->tv.margins.right = cmdline->tv_margins.right;
>   	state->tv.margins.top = cmdline->tv_margins.top;
>   	state->tv.margins.bottom = cmdline->tv_margins.bottom;
>   }
> -EXPORT_SYMBOL(drm_atomic_helper_connector_tv_margins_reset);
> +EXPORT_SYMBOL(drm_atomic_helper_connector_tv_margins_state_init);
>   
>   /**
>    * drm_atomic_helper_connector_tv_reset - Resets Analog TV connector properties
>    * @connector: DRM connector
>    *
> @@ -568,11 +569,12 @@ void drm_atomic_helper_connector_tv_reset(struct drm_connector *connector)
>   	if (prop)
>   		if (!drm_object_property_get_default_value(&connector->base,
>   							   prop, &val))
>   			state->tv.hue = val;
>   
> -	drm_atomic_helper_connector_tv_margins_reset(connector);
> +	drm_atomic_helper_connector_tv_margins_state_init(connector->state,
> +							  connector);
>   }
>   EXPORT_SYMBOL(drm_atomic_helper_connector_tv_reset);
>   
>   /**
>    * drm_atomic_helper_connector_tv_check - Validate an analog TV connector state
> diff --git a/drivers/gpu/drm/gud/gud_connector.c b/drivers/gpu/drm/gud/gud_connector.c
> index 8141c3a1e30a..a57f2565d33e 100644
> --- a/drivers/gpu/drm/gud/gud_connector.c
> +++ b/drivers/gpu/drm/gud/gud_connector.c
> @@ -352,11 +352,12 @@ static void gud_connector_reset(struct drm_connector *connector)
>   	struct gud_connector *gconn = to_gud_connector(connector);
>   
>   	drm_atomic_helper_connector_reset(connector);
>   	connector->state->tv = gconn->initial_tv_state;
>   	/* Set margins from command line */
> -	drm_atomic_helper_connector_tv_margins_reset(connector);
> +	drm_atomic_helper_connector_tv_margins_state_init(connector->state,
> +							  connector);
>   	if (gconn->initial_brightness >= 0)
>   		connector->state->tv.brightness = gconn->initial_brightness;
>   }
>   
>   static const struct drm_connector_funcs gud_connector_funcs = {
> diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
> index 3a90dbb61f4e..cf84eff847d1 100644
> --- a/drivers/gpu/drm/vc4/vc4_hdmi.c
> +++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
> @@ -507,11 +507,12 @@ static int vc4_hdmi_connector_atomic_check(struct drm_connector *connector,
>   
>   static void vc4_hdmi_connector_reset(struct drm_connector *connector)
>   {
>   	drm_atomic_helper_connector_reset(connector);
>   	__drm_atomic_helper_connector_hdmi_state_init(connector, connector->state);
> -	drm_atomic_helper_connector_tv_margins_reset(connector);
> +	drm_atomic_helper_connector_tv_margins_state_init(connector->state,
> +							  connector);
>   }
>   
>   static const struct drm_connector_funcs vc4_hdmi_connector_funcs = {
>   	.debugfs_init = drm_hdmi_connector_debugfs_init,
>   	.force = drm_atomic_helper_connector_hdmi_force,
> diff --git a/include/drm/drm_atomic_state_helper.h b/include/drm/drm_atomic_state_helper.h
> index 4706eeab52c1..4dac741af22c 100644
> --- a/include/drm/drm_atomic_state_helper.h
> +++ b/include/drm/drm_atomic_state_helper.h
> @@ -72,11 +72,12 @@ void drm_atomic_helper_connector_reset(struct drm_connector *connector);
>   struct drm_connector_state *
>   drm_atomic_helper_connector_create_state(struct drm_connector *connector);
>   void drm_atomic_helper_connector_tv_reset(struct drm_connector *connector);
>   int drm_atomic_helper_connector_tv_check(struct drm_connector *connector,
>   					 struct drm_atomic_commit *state);
> -void drm_atomic_helper_connector_tv_margins_reset(struct drm_connector *connector);
> +void drm_atomic_helper_connector_tv_margins_state_init(struct drm_connector_state *state,
> +						       struct drm_connector *connector);
>   void
>   __drm_atomic_helper_connector_duplicate_state(struct drm_connector *connector,
>   					   struct drm_connector_state *state);
>   struct drm_connector_state *
>   drm_atomic_helper_connector_duplicate_state(struct drm_connector *connector);
> 

