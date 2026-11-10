Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 142EF60A6F6A
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 12:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=q9vTgOpW
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8149010F63C;
	Tue, 10 Nov 2026 12:09:02 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 81DBD10F63C
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 12:08:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
 MIME-Version:Date:Message-ID:From:Reply-To;
 bh=suRO7IXcHs/kdn6Tu9XVOti31enSt55p3HCSbFlmGg8=; t=1794312536; x=2109672536; 
 b=q9vTgOpWfJ8yo4Hn7KBU74W5y7LLiix1TYhYT0LVBUJNo08cFKxNbNzdc6okJLr25FOAxcn8LuR
 C8CcE7/Azg+weamk12OVPOfYQkpUd4wNg8BCMG6Q9rKVVXPSbgOoF2awB7rv36kIuIbmysqF/wcH4
 TMVDLLtYU3Dksi3OwTawr8pvbvHxGtdoP+l/ZLALu7Zmhw9s5XMuKVj3zwGnBWSdBnueyEt8ZVfOh
 OBqnniXm2miFch5bqJl6mOXDY0mqU88Djdt6DOwALu6MIq3p1L7vhQwH5AqrGZMQXys3EOM2OropT
 QDNI49jvFcGOd8zN1h1bHi7wvpP0aEucjKgg==;
Received: from [179.105.94.163] (helo=[192.168.0.4])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1xQkeV-00896x-9d; Tue, 10 Nov 2026 13:08:39 +0100
Message-ID: <e997d667-0070-4f65-a552-51bc41e2af97@igalia.com>
Date: Tue, 10 Nov 2026 09:08:31 -0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/9] drm/vc4: hdmi: Propagate -EDEADLK to the top level
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
 Maxime Ripard <mripard@kernel.org>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: kernel@collabora.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Lucas Tanure <lucas.tanure@neat.no>
References: <20261110-vc4-common-scramb-v4-0-eaa141a0da0f@collabora.com>
 <20261110-vc4-common-scramb-v4-4-eaa141a0da0f@collabora.com>
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
In-Reply-To: <20261110-vc4-common-scramb-v4-4-eaa141a0da0f@collabora.com>
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 09/11/26 21:13, Cristian Ciocaltea wrote:
> drm_connector_helper_funcs.detect_ctx() is expected to propagate
> -EDEADLK so that context owners, e.g. drm_helper_probe_detect_ctx(), can
> perform the required backoff and retry.
> 
> vc4_hdmi_handle_hotplug() instead runs its own retry loop and calls
> drm_modeset_backoff() on an acquire context it does not own.  This drops
> all locks in the context, including connection_mutex held by the core.
> 
> Drop the local retry logic and propagate -EDEADLK to the caller instead.
> This aligns VC4 with the expected detect_ctx() semantics.
> 
> Acked-by: Maxime Ripard <mripard@kernel.org>
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>

Reviewed-by: Maíra Canal <mcanal@igalia.com>

Best regards,
- Maíra

> ---
>   drivers/gpu/drm/vc4/vc4_hdmi.c | 23 +++++++----------------
>   1 file changed, 7 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
> index 0e6696644687..fc9d5fe07849 100644
> --- a/drivers/gpu/drm/vc4/vc4_hdmi.c
> +++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
> @@ -343,12 +343,11 @@ static int vc4_hdmi_reset_link(struct drm_connector *connector,
>   	return drm_atomic_helper_reset_crtc(crtc, ctx);
>   }
>   
> -static void vc4_hdmi_handle_hotplug(struct vc4_hdmi *vc4_hdmi,
> -				    struct drm_modeset_acquire_ctx *ctx,
> -				    enum drm_connector_status status)
> +static int vc4_hdmi_handle_hotplug(struct vc4_hdmi *vc4_hdmi,
> +				   struct drm_modeset_acquire_ctx *ctx,
> +				   enum drm_connector_status status)
>   {
>   	struct drm_connector *connector = &vc4_hdmi->connector;
> -	int ret;
>   
>   	/*
>   	 * NOTE: This function should really be called with vc4_hdmi->mutex
> @@ -367,17 +366,9 @@ static void vc4_hdmi_handle_hotplug(struct vc4_hdmi *vc4_hdmi,
>   	drm_atomic_helper_connector_hdmi_hotplug(connector, ctx, status);
>   
>   	if (status != connector_status_connected)
> -		return;
> +		return 0;
>   
> -	for (;;) {
> -		ret = vc4_hdmi_reset_link(connector, ctx);
> -		if (ret == -EDEADLK) {
> -			drm_modeset_backoff(ctx);
> -			continue;
> -		}
> -
> -		break;
> -	}
> +	return vc4_hdmi_reset_link(connector, ctx);
>   }
>   
>   static int vc4_hdmi_connector_detect_ctx(struct drm_connector *connector,
> @@ -415,10 +406,10 @@ static int vc4_hdmi_connector_detect_ctx(struct drm_connector *connector,
>   			status = connector_status_connected;
>   	}
>   
> -	vc4_hdmi_handle_hotplug(vc4_hdmi, ctx, status);
> +	ret = vc4_hdmi_handle_hotplug(vc4_hdmi, ctx, status);
>   	pm_runtime_put(&vc4_hdmi->pdev->dev);
>   
> -	return status;
> +	return ret == -EDEADLK ? ret : status;
>   }
>   
>   static int vc4_hdmi_connector_get_modes(struct drm_connector *connector)
> 

