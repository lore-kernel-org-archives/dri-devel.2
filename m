Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60798606A31C
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 12:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=pZeehOCz
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F41610E89E;
	Mon,  9 Nov 2026 12:04:19 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 43D3410E89E
 for <dri-devel@lists.freedesktop.org>; Mon,  9 Nov 2026 12:04:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
 MIME-Version:Date:Message-ID:From:Reply-To;
 bh=poUHFhBacCIBc6IKxtGxEHUIb6ec3qc6fq+C0UVooSA=; t=1794225854; x=2109585854; 
 b=pZeehOCzlSKrTHD+6PZKMYHfb4tEhZR9+FsJX0bApz77iVC7ubtHJO50C2xj1EWeG39n5phzU2o
 54AGfULaWB56MuWgvk5T4c9N6BYdEXI2bYgjebf3Tn1Qk1QKIUdwLArDYqcKeECss14PMNT1++tf4
 ZHFd4XAcL0lu7pUBnVhrnDneK9uLpdAqqXG5CqUh9TpLQ6nknbO5ADhou+eBby4zJA4PQ4PLlRmZw
 p1hEyAS4r5rfoemzzhAzYeJj536ZXfOr186LULDr/5FTSJ+W9lJ0p4BlzAkqZPbBUkFV/TPeRjXLN
 T7tv16LncKgyUvAAeQ1yEl0SiA5zEZer7fcw==;
Received: from [179.105.94.163] (helo=[192.168.0.4])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1xQO6V-007FBg-H3; Mon, 09 Nov 2026 13:04:03 +0100
Message-ID: <9c8f001a-afcb-4b52-b5d5-645289c74513@igalia.com>
Date: Mon, 9 Nov 2026 09:04:00 -0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] drm/display: hdmi: Use committed state to decide on
 SCDC resync
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: kernel@collabora.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>
References: <20261104-hdmi-scdc-scramb-fixes-v1-0-16a9bb3d64a6@collabora.com>
 <20261104-hdmi-scdc-scramb-fixes-v1-2-16a9bb3d64a6@collabora.com>
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
In-Reply-To: <20261104-hdmi-scdc-scramb-fixes-v1-2-16a9bb3d64a6@collabora.com>
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

Hi Cristian,

On 04/11/26 10:26, Cristian Ciocaltea wrote:
> drm_connector_hdmi_sync_scdc() uses the scrambler_enabled flag to decide
> whether the sink-side SCDC status is worth checking on a hotplug/detect
> event.  That flag tracks the source-side scrambler status, which is not
> necessarily in sync with what the committed mode actually requires.
> 
> In particular, a source driver may deliberately set scrambler_enabled at
> init to force a disable at boot and resync hardware left enabled by the
> firmware, as vc4 does.  If the pipeline doesn't get disabled afterwards,
> e.g. because no display was active at probe time, the flag remains
> stale.  A subsequent detect (e.g. an HPD event) then finds scrambling
> disabled on the sink while the flag claims otherwise, and triggers a
> CRTC reset.  This results in a one-time spurious flicker on an otherwise
> correctly configured non-scrambled mode.
> 
> Verify conn_state->hdmi.scrambler_needed instead, as it is computed
> during atomic check and reliably describes the requirements of the
> active mode.
> 
> Fixes: d653818324ed ("drm/display: hdmi: Add HDMI 2.0 scrambling management helpers")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/all/sashiko-outbox-170670@kernel.org/
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>

Reviewed-by: Maíra Canal <mcanal@igalia.com>

Best regards,
- Maíra

> ---
>   drivers/gpu/drm/display/drm_hdmi_helper.c | 17 +++++++++++------
>   1 file changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/display/drm_hdmi_helper.c b/drivers/gpu/drm/display/drm_hdmi_helper.c
> index 872f7e32e8d2..974d5de6d380 100644
> --- a/drivers/gpu/drm/display/drm_hdmi_helper.c
> +++ b/drivers/gpu/drm/display/drm_hdmi_helper.c
> @@ -653,7 +653,6 @@ EXPORT_SYMBOL(drm_connector_hdmi_disable_scrambling);
>   int drm_connector_hdmi_sync_scdc(struct drm_connector *connector, bool plugged,
>   				 struct drm_modeset_acquire_ctx *ctx)
>   {
> -	struct drm_connector_hdmi *hdmi;
>   	struct drm_connector_state *conn_state;
>   	struct drm_device *dev;
>   	struct drm_crtc *crtc;
> @@ -663,7 +662,6 @@ int drm_connector_hdmi_sync_scdc(struct drm_connector *connector, bool plugged,
>   	if (!connector || !plugged || !ctx)
>   		return 0;
>   
> -	hdmi = &connector->hdmi;
>   	dev = connector->dev;
>   
>   	/*
> @@ -677,14 +675,21 @@ int drm_connector_hdmi_sync_scdc(struct drm_connector *connector, bool plugged,
>   
>   	/* TODO: Also handle HDMI 2.1 FRL link training */
>   
> -	if (!drm_connector_hdmi_scrambler_supported(connector) ||
> -	    !READ_ONCE(hdmi->scrambler_enabled))
> -		return 0;
> -
>   	conn_state = connector->state;
>   	if (!conn_state)
>   		return 0;
>   
> +	/*
> +	 * Rely on the committed connector state rather than on the current
> +	 * scrambler status: a source driver may force scrambler_enabled at
> +	 * init to get a disable at boot (e.g. vc4), and that value would
> +	 * remain stale until the first disable actually happens, leading to
> +	 * a spurious CRTC reset whenever the active mode needs no scrambling.
> +	 */
> +	if (!drm_connector_hdmi_scrambler_supported(connector) ||
> +	    !conn_state->hdmi.scrambler_needed)
> +		return 0;
> +
>   	crtc = conn_state->crtc;
>   	if (!crtc)
>   		return 0;
> 

