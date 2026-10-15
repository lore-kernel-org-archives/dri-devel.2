Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F431CC6B33
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 11:08:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7DFA31122D7;
	Thu, 15 Oct 2026 11:08:05 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B8F11122D6
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 11:07:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
 MIME-Version:Date:Message-ID:From:Reply-To;
 bh=4Hj9kWH5qoRG+jQr1gKyl09XYExSBMsDJ5EWUBR683I=; b=d4fh+76iC4MoEtjhSut94qZW+d
 Y0FfGXaRv9oNHKbQXsD9/hZ17+e0xkdzELgEQ+PNLQ/W874UjpI3wcefbwuY5U4IMatI161JTKalT
 ZZWeLa4d5IFigFhdKUxHiyWRworLv/8gyOPAuOzOGKHK7ZUPqGmrrstYX6d9eN+9TiLR3YFV3GDv1
 hlTNvT04GZnO2PixTeBz4YeGhP/0MW2beipxeii707h7wpkcoEkxcY+WOyoBEbsBdf5enGcDmvDDm
 a4Tm0sbTD4s4hVzQMEi7tPX1803rOnCGFkIH2A0jlDIR4gjAn0xYpZR7UhDPX2HYDuDDbVdprFz3l
 CzapY1xA==;
Received: from [179.105.94.163] (helo=[192.168.0.2])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1xHJJN-000VUk-L4; Thu, 15 Oct 2026 13:07:49 +0200
Message-ID: <c0f448b2-128e-47ae-b63e-168948673b89@igalia.com>
Date: Thu, 15 Oct 2026 08:07:45 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 63/75] drm/vc4: hdmi: Convert to atomic_create_state
To: Maxime Ripard <mripard@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>
References: <20261014-drm-no-more-connector-reset-v1-0-586c9c026823@kernel.org>
 <20261014-drm-no-more-connector-reset-v1-63-586c9c026823@kernel.org>
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
In-Reply-To: <20261014-drm-no-more-connector-reset-v1-63-586c9c026823@kernel.org>
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

Hi Maxime,

On 14/10/26 14:27, Maxime Ripard wrote:
> The vc4 HDMI connector reset implementation creates a pristine state,
> initializes the HDMI state, and sets the TV margins. It does not
> perform any hardware reset.
> 
> Since this is equivalent to what atomic_create_state expects, convert
> the reset function to an atomic_create_state hook that returns the
> initialized state.
> 
> Signed-off-by: Maxime Ripard <mripard@kernel.org>

The order of the parameters in
__drm_atomic_helper_connector_hdmi_state_init() bothers me a bit, as
it's the reverse of drm_atomic_helper_connector_tv_margins_state_init(),
but anyway:

Reviewed-by: Maíra Canal <mcanal@igalia.com>

Best regards,
- Maíra

> ---
> Cc: "Maíra Canal" <mcanal@igalia.com>
> Cc: Dave Stevenson <dave.stevenson@raspberrypi.com>
> Cc: Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>
> ---
>   drivers/gpu/drm/vc4/vc4_hdmi.c | 31 ++++++++++++++++++++++++-------
>   1 file changed, 24 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
> index cf84eff847d1..bf4b19910e56 100644
> --- a/drivers/gpu/drm/vc4/vc4_hdmi.c
> +++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
> @@ -503,23 +503,33 @@ static int vc4_hdmi_connector_atomic_check(struct drm_connector *connector,
>   	}
>   
>   	return drm_atomic_helper_connector_hdmi_check(connector, state);
>   }
>   
> -static void vc4_hdmi_connector_reset(struct drm_connector *connector)
> +static struct drm_connector_state *
> +vc4_hdmi_connector_create_state(struct drm_connector *connector)
>   {
> -	drm_atomic_helper_connector_reset(connector);
> -	__drm_atomic_helper_connector_hdmi_state_init(connector, connector->state);
> -	drm_atomic_helper_connector_tv_margins_state_init(connector->state,
> +	struct drm_connector_state *connector_state;
> +
> +	connector_state = drm_atomic_helper_connector_create_state(connector);
> +	if (IS_ERR(connector_state))
> +		return connector_state;
> +
> +	__drm_atomic_helper_connector_hdmi_state_init(connector,
> +						      connector_state);
> +
> +	drm_atomic_helper_connector_tv_margins_state_init(connector_state,
>   							  connector);
> +
> +	return connector_state;
>   }
>   
>   static const struct drm_connector_funcs vc4_hdmi_connector_funcs = {
>   	.debugfs_init = drm_hdmi_connector_debugfs_init,
>   	.force = drm_atomic_helper_connector_hdmi_force,
>   	.fill_modes = drm_helper_probe_single_connector_modes,
> -	.reset = vc4_hdmi_connector_reset,
> +	.atomic_create_state = vc4_hdmi_connector_create_state,
>   	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
>   	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
>   };
>   
>   static const struct drm_connector_helper_funcs vc4_hdmi_connector_helper_funcs = {
> @@ -566,12 +576,19 @@ static int vc4_hdmi_connector_init(struct drm_device *dev,
>   
>   	/*
>   	 * Some of the properties below require access to state, like bpc.
>   	 * Allocate some default initial connector state with our reset helper.
>   	 */
> -	if (connector->funcs->reset)
> -		connector->funcs->reset(connector);
> +	if (!connector->state) {
> +		struct drm_connector_state *conn_state;
> +
> +		conn_state = vc4_hdmi_connector_create_state(connector);
> +		if (IS_ERR(conn_state))
> +			return PTR_ERR(conn_state);
> +
> +		connector->state = conn_state;
> +	}
>   
>   	/* Create and attach TV margin props to this connector. */
>   	ret = drm_mode_create_tv_margin_properties(dev);
>   	if (ret)
>   		return ret;
> 

