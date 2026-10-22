Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A87B606A319
	for <dri-devel@archiver.kernel.org>; Thu, 22 Oct 2026 20:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=EbMmmjm/
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7068910E4A7;
	Thu, 22 Oct 2026 20:57:24 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB86110E4A7
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 20:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
 MIME-Version:Date:Message-ID:From:Reply-To;
 bh=LBVNmxHIBqI3Oyxl9ZbK1IwWIBFXuEsE07zv3Xtit/A=; b=EbMmmjm/HrZEzcE/ZJMuCuiKKH
 N1Zeo/QNQpHBZyjqJG7iiMtFRGNMItsBK/0mugAgWlCnlh0rm+W5ne+sbuN+UvLt9ox7z5SW6xmCe
 qxI9n99IKzCjd8ANFaJ28YRiwdGiZiWQqrOsADyNXsKa/K6kqbPyo/UFZP0y0CsgNmHuBSkfGt4DC
 7pcnSGF9EwKkf+gvKELjUo5WigBKM33/pxit97vrjaJja7DsbJkDQDtUe5ZL+glQ6K6j+6J0AlzEK
 moc9xz+6AP3nccvo7IP3wNa44zg/H25AMjm5K8E+NTElEFLpVEAAC8VhFYZRZZ7QBoVYt+Y+XNOWw
 9NEQaXIw==;
Received: from [179.105.94.163] (helo=[192.168.0.2])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1xJzqW-007Aqb-19; Thu, 22 Oct 2026 22:57:08 +0200
Message-ID: <997f0f83-13a0-4054-b195-85d90d72aa53@igalia.com>
Date: Thu, 22 Oct 2026 17:57:03 -0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/59] drm/hdmi: Change
 __drm_atomic_helper_connector_hdmi_state_init parameter order
To: Maxime Ripard <mripard@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
References: <20261022-drm-no-more-connector-reset-v2-0-0b7e4e85b1e8@kernel.org>
 <20261022-drm-no-more-connector-reset-v2-1-0b7e4e85b1e8@kernel.org>
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
In-Reply-To: <20261022-drm-no-more-connector-reset-v2-1-0b7e4e85b1e8@kernel.org>
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
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 22/10/26 09:31, Maxime Ripard wrote:
> All other state init helpers take the state as first parameter and the
> entity as second: __drm_atomic_helper_crtc_state_init(),
> __drm_atomic_helper_plane_state_init(),
> __drm_atomic_helper_connector_state_init(), and
> __drm_atomic_helper_bridge_state_init().
> 
> __drm_atomic_helper_connector_hdmi_state_init() is the only one taking
> the connector first and the state second. Swap its parameters to match
> the established convention.
> 
> Suggested-by: Maíra Canal <mcanal@igalia.com>
> Signed-off-by: Maxime Ripard <mripard@kernel.org>

Reviewed-by: Maíra Canal <mcanal@igalia.com>

Best regards,
- Maíra

> ---
>   drivers/gpu/drm/display/drm_bridge_connector.c     | 4 ++--
>   drivers/gpu/drm/display/drm_hdmi_state_helper.c    | 6 +++---
>   drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c             | 3 ++-
>   drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c | 3 ++-
>   drivers/gpu/drm/vc4/vc4_hdmi.c                     | 2 +-
>   include/drm/display/drm_hdmi_state_helper.h        | 4 ++--
>   6 files changed, 12 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/gpu/drm/display/drm_bridge_connector.c b/drivers/gpu/drm/display/drm_bridge_connector.c
> index 81f3e26f6fdf..2202e6044444 100644
> --- a/drivers/gpu/drm/display/drm_bridge_connector.c
> +++ b/drivers/gpu/drm/display/drm_bridge_connector.c
> @@ -239,6 +239,6 @@ drm_bridge_connector_create_state(struct drm_connector *connector)
>   
>   	if (bridge_connector->bridge_hdmi)
> -		__drm_atomic_helper_connector_hdmi_state_init(connector,
> -							      conn_state);
> +		__drm_atomic_helper_connector_hdmi_state_init(conn_state,
> +							      connector);
>   
>   	return conn_state;
> diff --git a/drivers/gpu/drm/display/drm_hdmi_state_helper.c b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
> index 7cdb7ca3dc12..c63d439382bb 100644
> --- a/drivers/gpu/drm/display/drm_hdmi_state_helper.c
> +++ b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
> @@ -310,6 +310,6 @@
>   /**
>    * __drm_atomic_helper_connector_hdmi_state_init() - Initialize all HDMI @drm_connector_state resources
> - * @connector: DRM connector
>    * @new_conn_state: connector state to initialize
> + * @connector: DRM connector
>    *
>    * Initializes all HDMI resources from a @drm_connector_state without
> @@ -319,6 +319,6 @@
>    * drm_atomic_helper_connector_create_state().
>    */
> -void __drm_atomic_helper_connector_hdmi_state_init(struct drm_connector *connector,
> -						   struct drm_connector_state *new_conn_state)
> +void __drm_atomic_helper_connector_hdmi_state_init(struct drm_connector_state *new_conn_state,
> +						   struct drm_connector *connector)
>   {
>   	unsigned int max_bpc = connector->max_bpc;
> diff --git a/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c b/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
> index 6f4fe0c8efae..3084f6570c29 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
> +++ b/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
> @@ -294,5 +294,6 @@ static void sun4i_hdmi_connector_reset(struct drm_connector *connector)
>   {
>   	drm_atomic_helper_connector_reset(connector);
> -	__drm_atomic_helper_connector_hdmi_state_init(connector, connector->state);
> +	__drm_atomic_helper_connector_hdmi_state_init(connector->state,
> +						      connector);
>   }
>   
> diff --git a/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c b/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c
> index b2e347863a77..9953f5e661ce 100644
> --- a/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c
> +++ b/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c
> @@ -203,5 +203,6 @@ static void dummy_hdmi_connector_reset(struct drm_connector *connector)
>   {
>   	drm_atomic_helper_connector_reset(connector);
> -	__drm_atomic_helper_connector_hdmi_state_init(connector, connector->state);
> +	__drm_atomic_helper_connector_hdmi_state_init(connector->state,
> +						      connector);
>   }
>   
> diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
> index 6b00581f304f..31942638fcd8 100644
> --- a/drivers/gpu/drm/vc4/vc4_hdmi.c
> +++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
> @@ -508,5 +508,5 @@ static void vc4_hdmi_connector_reset(struct drm_connector *connector)
>   {
>   	drm_atomic_helper_connector_reset(connector);
> -	__drm_atomic_helper_connector_hdmi_state_init(connector, connector->state);
> +	__drm_atomic_helper_connector_hdmi_state_init(connector->state, connector);
>   	drm_atomic_helper_connector_tv_margins_reset(connector);
>   }
> diff --git a/include/drm/display/drm_hdmi_state_helper.h b/include/drm/display/drm_hdmi_state_helper.h
> index 965342f6bbc9..21e5a9215319 100644
> --- a/include/drm/display/drm_hdmi_state_helper.h
> +++ b/include/drm/display/drm_hdmi_state_helper.h
> @@ -14,6 +14,6 @@ struct hdmi_audio_infoframe;
>   enum drm_connector_status;
>   
> -void __drm_atomic_helper_connector_hdmi_state_init(struct drm_connector *connector,
> -						   struct drm_connector_state *new_conn_state);
> +void __drm_atomic_helper_connector_hdmi_state_init(struct drm_connector_state *new_conn_state,
> +						   struct drm_connector *connector);
>   
>   int drm_atomic_helper_connector_hdmi_check(struct drm_connector *connector,
> 

