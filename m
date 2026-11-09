Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15044606A335
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 12:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=AD/PFef6
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B24210F206;
	Mon,  9 Nov 2026 12:16:17 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C80F10F206
 for <dri-devel@lists.freedesktop.org>; Mon,  9 Nov 2026 12:16:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
 MIME-Version:Date:Message-ID:From:Reply-To;
 bh=8TAq2QyHAbaRrxjpEblbq+kj+i/LwgTgkLNLPqW3GRY=; t=1794226570; x=2109586570; 
 b=AD/PFef6VQetjHV28eo2dweZXFBVMTGqOAnJOyFV+eLa7OTT1rnpl4Af9dkjMmxAH+f5wNKdDVU
 awUdbIItQQUiblAM4RHRmZlyYi5lwyyTBOJJM93yf1lLePvj1woQZfgLcZTndJezzuHbHB1Wa1oHu
 JY+E6g7MkfdH7DCXAzos1g3ndNe1jeSnSeiamYnatGpVdhmKraFUAvrt/xrOBQsSN3qg14/nn40nu
 bWwm7r7Z9KvwNRRtBw66RFJ6LmE2nccmtWCpfWhwWf/TL1B7Xb3O6nim+TDn8y1ar+0BftppjQFxm
 4p/rrzZGT47w4L8ndMu1AoTB62j39+CbU89g==;
Received: from [179.105.94.163] (helo=[192.168.0.4])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1xQOI3-007Fj2-0Z; Mon, 09 Nov 2026 13:15:59 +0100
Message-ID: <0d32ee68-9f2b-472a-80ef-f4a69705b115@igalia.com>
Date: Mon, 9 Nov 2026 09:15:54 -0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] drm/display: hdmi: Reset sink scrambling on
 non-scrambled modesets
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: kernel@collabora.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20261104-hdmi-scdc-scramb-fixes-v1-0-16a9bb3d64a6@collabora.com>
 <20261104-hdmi-scdc-scramb-fixes-v1-3-16a9bb3d64a6@collabora.com>
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
In-Reply-To: <20261104-hdmi-scdc-scramb-fixes-v1-3-16a9bb3d64a6@collabora.com>
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

On 04/11/26 10:26, Cristian Ciocaltea wrote:
> drm_connector_hdmi_disable_scrambling() only clears the sink SCDC status
> when the connector is known to be connected.  That is never true when a
> source driver disables scrambling at boot to clean up after the
> firmware, as vc4 does from vc4_crtc_disable_at_boot(), where
> connector->status is still unknown and no EDID has been read.
> 
> A sink left scrambling by the firmware thus keeps both Scrambling_Enable
> and the 1/40 TMDS bit clock ratio set.  If the first modeset picks a
> mode below 340 MHz, no disable happens in between, since the CRTC was
> never active in atomic state, and drm_connector_hdmi_enable_scrambling()
> returns early, leaving the sink trying to descramble an unscrambled
> stream.
> 
> Instead of blind SCDC writes at boot towards a possibly absent sink,
> reset the sink status from drm_connector_hdmi_enable_scrambling() when
> no scrambling is required.  By then the sink has been probed, and HDMI
> 2.0 expects a scrambling capable sink to have Scrambling_Enable cleared
> below 340 MHz anyway.  The reset runs regardless of source scrambler
> support, since the firmware may have left the sink scrambling.
> 
> Factor the reset out into a helper also used by the disable and error
> paths, gated only on drm_scdc_sink_supports_scrambling(), which suffices
> because drm_display_info is zeroed until the first EDID read and reset
> on disconnect, making the connector->status check redundant.  As the
> helper now runs on every non-scrambled modeset, read SCDC_TMDS_CONFIG
> first and only clear the bits actually set, so the common case costs a
> single DDC read.
> 
> Fixes: d653818324ed ("drm/display: hdmi: Add HDMI 2.0 scrambling management helpers")
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>

Reviewed-by: Maíra Canal <mcanal@igalia.com>

Best regards,
- Maíra

> ---
>   drivers/gpu/drm/display/drm_hdmi_helper.c | 45 ++++++++++++++++++++++++-------
>   1 file changed, 36 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/gpu/drm/display/drm_hdmi_helper.c b/drivers/gpu/drm/display/drm_hdmi_helper.c
> index 974d5de6d380..278cfda38e18 100644
> --- a/drivers/gpu/drm/display/drm_hdmi_helper.c
> +++ b/drivers/gpu/drm/display/drm_hdmi_helper.c
> @@ -470,6 +470,28 @@ static bool drm_scdc_sink_supports_scrambling(struct drm_connector *connector)
>   	       info->hdmi.scdc.scrambling.supported;
>   }
>   
> +static void drm_connector_hdmi_reset_sink_scrambling(struct drm_connector *connector)
> +{
> +	struct drm_device *dev = connector->dev;
> +	u8 config;
> +	int ret;
> +
> +	if (!connector->ddc || !drm_scdc_sink_supports_scrambling(connector))
> +		return;
> +
> +	ret = drm_scdc_readb(connector->ddc, SCDC_TMDS_CONFIG, &config);
> +	if (ret) {
> +		drm_dbg_kms(dev, "Failed to read TMDS config: %d\n", ret);
> +		return;
> +	}
> +
> +	if (config & SCDC_SCRAMBLING_ENABLE)
> +		drm_scdc_set_scrambling(connector, false);
> +
> +	if (config & SCDC_TMDS_BIT_CLOCK_RATIO_BY_40)
> +		drm_scdc_set_high_tmds_clock_ratio(connector, false);
> +}
> +
>   static int drm_connector_hdmi_try_scrambling_setup(struct drm_connector *connector)
>   {
>   	bool done;
> @@ -522,6 +544,11 @@ static void drm_connector_hdmi_scdc_work(struct work_struct *work)
>    * the sink side and retry the operation, as some displays refuse to set the
>    * scrambling bit right away.
>    *
> + * When @conn_state doesn't require scrambling, the sink-side SCDC status is
> + * reset instead, so that a sink left scrambling by a state the driver did not
> + * control, e.g. set up by the firmware before boot, doesn't end up out of sync
> + * with the source.
> + *
>    * The work item is cancelled by drm_connector_hdmi_disable_scrambling(), hence
>    * source drivers must ensure the display pipeline is shut down on unbind, e.g.
>    * via drm_atomic_helper_shutdown(). Otherwise the work may outlive the driver's
> @@ -541,8 +568,14 @@ int drm_connector_hdmi_enable_scrambling(struct drm_connector *connector,
>   	if (!conn_state)
>   		return -EINVAL;
>   
> -	if (!conn_state->hdmi.scrambler_needed)
> +	if (!conn_state->hdmi.scrambler_needed) {
> +		/*
> +		 * Resync the sink here, where it is known to be connected
> +		 * and its capabilities have been parsed.
> +		 */
> +		drm_connector_hdmi_reset_sink_scrambling(connector);
>   		return 0;
> +	}
>   
>   	if (!drm_connector_hdmi_scrambler_supported(connector)) {
>   		drm_dbg_kms(dev, "Source doesn't support scrambling.\n");
> @@ -581,8 +614,7 @@ int drm_connector_hdmi_enable_scrambling(struct drm_connector *connector,
>   		WRITE_ONCE(hdmi->scrambler_enabled, false);
>   		cancel_delayed_work_sync(&hdmi->scdc_work);
>   
> -		drm_scdc_set_scrambling(connector, false);
> -		drm_scdc_set_high_tmds_clock_ratio(connector, false);
> +		drm_connector_hdmi_reset_sink_scrambling(connector);
>   	}
>   
>   	return ret;
> @@ -619,12 +651,7 @@ int drm_connector_hdmi_disable_scrambling(struct drm_connector *connector)
>   	if (hdmi->scdc_work_initialized)
>   		cancel_delayed_work_sync(&hdmi->scdc_work);
>   
> -	if (connector->ddc &&
> -	    connector->status == connector_status_connected &&
> -	    drm_scdc_sink_supports_scrambling(connector)) {
> -		drm_scdc_set_scrambling(connector, false);
> -		drm_scdc_set_high_tmds_clock_ratio(connector, false);
> -	}
> +	drm_connector_hdmi_reset_sink_scrambling(connector);
>   
>   	return hdmi->funcs->scrambler_disable(connector);
>   }
> 

