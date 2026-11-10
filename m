Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9846606A51E
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 12:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=ad6bW3QV
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 15F8610F64A;
	Tue, 10 Nov 2026 12:12:12 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6579510F641
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 12:12:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
 MIME-Version:Date:Message-ID:From:Reply-To;
 bh=MJg9HWWDp1O4Z7cghxzjMqdZhX56ozh/QxqG4MRNW/Y=; t=1794312725; x=2109672725; 
 b=ad6bW3QVraEYfYtlgrLQr/Upx6dfua4KoROI+LXYLmyBpOl2znN6Qza+e5fR2lqUd56qziVDZ70
 iZfefwE4oj67tr8gv2f/RhEcDH2r/z7u1VciT8x/8O6S8IzJzc2NatSU2iOWUA0tFkz+4gQZGsjVB
 og1PQEtM4URPo24Yuze50DuEN6X22Zm4K2uzS+4x6qEWhpVWnPwpmelZ1wJtzmLdIOHid+QOSbsmh
 WEviwMdrbPgm1OjG1q8nh4LZN6mFNxn9SQ9c7pfajxSY85GzW5dZf76lRlo4qmhX2/BiK4Kj25xyT
 J5y+pXKTRAUkBl5UAhA9mhdXlVpEZDiBUErQ==;
Received: from [179.105.94.163] (helo=[192.168.0.4])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1xQkha-0089Eh-F5; Tue, 10 Nov 2026 13:11:51 +0100
Message-ID: <6044130c-8753-4928-990f-04f0ad43d9f1@igalia.com>
Date: Tue, 10 Nov 2026 09:11:45 -0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/9] drm/vc4: hdmi: Convert to common HDMI 2.0
 scrambling infrastructure
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
 <20261110-vc4-common-scramb-v4-6-eaa141a0da0f@collabora.com>
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
In-Reply-To: <20261110-vc4-common-scramb-v4-6-eaa141a0da0f@collabora.com>
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
> Replace driver local scrambling logic with the newly introduced common
> HDMI 2.0 scrambling support:
> 
> - Advertise source-side scrambling capability by setting supported HDMI
>    version based on the variant's max_pixel_clock.
> 
> - Provide minimal .scrambler_{enable,disable} connector callbacks that
>    only toggle the VC5 HDMI_SCRAMBLER_CTL register, while delegating
>    sink-side SCDC programming and periodic status monitoring to
>    drm_connector_hdmi_{enable,disable}_scrambling().
> 
> - Drop vc4_hdmi_reset_link() and vc4_hdmi_handle_hotplug(), switching
>    the .detect_ctx() path to drm_atomic_helper_connector_hdmi_hotplug()
>    which internally calls drm_connector_hdmi_sync_scdc() to trigger a
>    CRTC reset on reconnection.
> 
> - Drop the local scrambling_work delayed workqueue and scdc_enabled
>    flag, now tracked by the common drm_connector_hdmi layer, as well as
>    the now unused output_{bpc,color_format} driver data members.
> 
> No functional change intended.
> 
> Acked-by: Maxime Ripard <mripard@kernel.org>
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>

Reviewed-by: Maíra Canal <mcanal@igalia.com>

Feel free to push the series to drm-misc-next. Thank you!

Best regards,
- Maíra

> ---
>   drivers/gpu/drm/vc4/vc4_hdmi.c | 226 +++++------------------------------------
>   drivers/gpu/drm/vc4/vc4_hdmi.h |  21 ----
>   2 files changed, 25 insertions(+), 222 deletions(-)
> 
> diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
> index c3636ed60d56..d7ef47dc4b02 100644
> --- a/drivers/gpu/drm/vc4/vc4_hdmi.c
> +++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
> @@ -35,7 +35,6 @@
>   #include <drm/display/drm_hdmi_cec_helper.h>
>   #include <drm/display/drm_hdmi_helper.h>
>   #include <drm/display/drm_hdmi_state_helper.h>
> -#include <drm/display/drm_scdc_helper.h>
>   #include <drm/drm_atomic_helper.h>
>   #include <drm/drm_drv.h>
>   #include <drm/drm_edid.h>
> @@ -113,22 +112,6 @@
>   #define HSM_MIN_CLOCK_FREQ	120000000
>   #define CEC_CLOCK_FREQ 40000
>   
> -static bool vc4_hdmi_supports_scrambling(struct vc4_hdmi *vc4_hdmi)
> -{
> -	struct drm_display_info *display = &vc4_hdmi->connector.display_info;
> -
> -	lockdep_assert_held(&vc4_hdmi->mutex);
> -
> -	if (!display->is_hdmi)
> -		return false;
> -
> -	if (!display->hdmi.scdc.supported ||
> -	    !display->hdmi.scdc.scrambling.supported)
> -		return false;
> -
> -	return true;
> -}
> -
>   static int vc4_hdmi_debugfs_regs(struct seq_file *m, void *unused)
>   {
>   	struct drm_debugfs_entry *entry = m->private;
> @@ -262,115 +245,6 @@ static void vc4_hdmi_cec_update_clk_div(struct vc4_hdmi *vc4_hdmi)
>   static void vc4_hdmi_cec_update_clk_div(struct vc4_hdmi *vc4_hdmi) {}
>   #endif
>   
> -static int vc4_hdmi_reset_link(struct drm_connector *connector,
> -			       struct drm_modeset_acquire_ctx *ctx)
> -{
> -	struct drm_device *drm;
> -	struct vc4_hdmi *vc4_hdmi;
> -	struct drm_connector_state *conn_state;
> -	struct drm_crtc_state *crtc_state;
> -	struct drm_crtc *crtc;
> -	bool scrambling_needed;
> -	u8 config;
> -	int ret;
> -
> -	if (!connector)
> -		return 0;
> -
> -	drm = connector->dev;
> -	ret = drm_modeset_lock(&drm->mode_config.connection_mutex, ctx);
> -	if (ret)
> -		return ret;
> -
> -	conn_state = connector->state;
> -	crtc = conn_state->crtc;
> -	if (!crtc)
> -		return 0;
> -
> -	ret = drm_modeset_lock(&crtc->mutex, ctx);
> -	if (ret)
> -		return ret;
> -
> -	crtc_state = crtc->state;
> -	if (!crtc_state->active)
> -		return 0;
> -
> -	vc4_hdmi = connector_to_vc4_hdmi(connector);
> -	mutex_lock(&vc4_hdmi->mutex);
> -
> -	if (!vc4_hdmi_supports_scrambling(vc4_hdmi)) {
> -		mutex_unlock(&vc4_hdmi->mutex);
> -		return 0;
> -	}
> -
> -	scrambling_needed = drm_hdmi_mode_needs_scrambling(&vc4_hdmi->saved_adjusted_mode,
> -							   vc4_hdmi->output_bpc,
> -							   vc4_hdmi->output_format);
> -	if (!scrambling_needed) {
> -		mutex_unlock(&vc4_hdmi->mutex);
> -		return 0;
> -	}
> -
> -	if (conn_state->commit &&
> -	    !try_wait_for_completion(&conn_state->commit->hw_done)) {
> -		mutex_unlock(&vc4_hdmi->mutex);
> -		return 0;
> -	}
> -
> -	ret = drm_scdc_readb(connector->ddc, SCDC_TMDS_CONFIG, &config);
> -	if (ret < 0) {
> -		drm_err(drm, "Failed to read TMDS config: %d\n", ret);
> -		mutex_unlock(&vc4_hdmi->mutex);
> -		return 0;
> -	}
> -
> -	if (!!(config & SCDC_SCRAMBLING_ENABLE) == scrambling_needed) {
> -		mutex_unlock(&vc4_hdmi->mutex);
> -		return 0;
> -	}
> -
> -	mutex_unlock(&vc4_hdmi->mutex);
> -
> -	/*
> -	 * HDMI 2.0 says that one should not send scrambled data
> -	 * prior to configuring the sink scrambling, and that
> -	 * TMDS clock/data transmission should be suspended when
> -	 * changing the TMDS clock rate in the sink. So let's
> -	 * just do a full modeset here, even though some sinks
> -	 * would be perfectly happy if were to just reconfigure
> -	 * the SCDC settings on the fly.
> -	 */
> -	return drm_atomic_helper_reset_crtc(crtc, ctx);
> -}
> -
> -static int vc4_hdmi_handle_hotplug(struct vc4_hdmi *vc4_hdmi,
> -				   struct drm_modeset_acquire_ctx *ctx,
> -				   enum drm_connector_status status)
> -{
> -	struct drm_connector *connector = &vc4_hdmi->connector;
> -
> -	/*
> -	 * NOTE: This function should really be called with vc4_hdmi->mutex
> -	 * held, but doing so results in reentrancy issues since
> -	 * cec_s_phys_addr() might call .adap_enable, which leads to that
> -	 * funtion being called with our mutex held.
> -	 *
> -	 * A similar situation occurs with vc4_hdmi_reset_link() that
> -	 * will call into our KMS hooks if the scrambling was enabled.
> -	 *
> -	 * Concurrency isn't an issue at the moment since we don't share
> -	 * any state with any of the other frameworks so we can ignore
> -	 * the lock for now.
> -	 */
> -
> -	drm_atomic_helper_connector_hdmi_hotplug(connector, ctx, status);
> -
> -	if (status != connector_status_connected)
> -		return 0;
> -
> -	return vc4_hdmi_reset_link(connector, ctx);
> -}
> -
>   static int vc4_hdmi_connector_detect_ctx(struct drm_connector *connector,
>   					 struct drm_modeset_acquire_ctx *ctx,
>   					 bool force)
> @@ -382,8 +256,8 @@ static int vc4_hdmi_connector_detect_ctx(struct drm_connector *connector,
>   	/*
>   	 * NOTE: This function should really take vc4_hdmi->mutex, but
>   	 * doing so results in reentrancy issues since
> -	 * vc4_hdmi_handle_hotplug() can call into other functions that
> -	 * would take the mutex while it's held here.
> +	 * drm_atomic_helper_connector_hdmi_hotplug() can call into other
> +	 * functions that would take the mutex while it's held here.
>   	 *
>   	 * Concurrency isn't an issue at the moment since we don't share
>   	 * any state with any of the other frameworks so we can ignore
> @@ -406,7 +280,8 @@ static int vc4_hdmi_connector_detect_ctx(struct drm_connector *connector,
>   			status = connector_status_connected;
>   	}
>   
> -	ret = vc4_hdmi_handle_hotplug(vc4_hdmi, ctx, status);
> +	ret = drm_atomic_helper_connector_hdmi_hotplug(connector, ctx, status);
> +
>   	pm_runtime_put(&vc4_hdmi->pdev->dev);
>   
>   	return ret == -EDEADLK ? ret : status;
> @@ -544,6 +419,14 @@ static int vc4_hdmi_connector_init(struct drm_device *dev,
>   
>   	drm_connector_helper_add(connector, &vc4_hdmi_connector_helper_funcs);
>   
> +	/*
> +	 * Since we don't know the state of the controller and its
> +	 * display (if any), let's assume it's always enabled.
> +	 * drm_connector_hdmi_disable_scrambling() will thus run at boot,
> +	 * make sure it's disabled, and avoid any inconsistency.
> +	 */
> +	connector->hdmi.scrambler_enabled = drm_connector_hdmi_scrambler_supported(connector);
> +
>   	/*
>   	 * Some of the properties below require access to state, like bpc.
>   	 * Allocate some default initial connector state with our reset helper.
> @@ -776,32 +659,15 @@ static int vc4_hdmi_write_spd_infoframe(struct drm_connector *connector,
>   					buffer, len);
>   }
>   
> -#define SCRAMBLING_POLLING_DELAY_MS	1000
> -
> -static void vc4_hdmi_enable_scrambling(struct drm_encoder *encoder)
> +static int vc4_hdmi_scrambler_enable(struct drm_connector *connector)
>   {
> -	struct vc4_hdmi *vc4_hdmi = encoder_to_vc4_hdmi(encoder);
> -	struct drm_connector *connector = &vc4_hdmi->connector;
> +	struct vc4_hdmi *vc4_hdmi = connector_to_vc4_hdmi(connector);
>   	struct drm_device *drm = connector->dev;
> -	const struct drm_display_mode *mode = &vc4_hdmi->saved_adjusted_mode;
>   	unsigned long flags;
>   	int idx;
>   
> -	lockdep_assert_held(&vc4_hdmi->mutex);
> -
> -	if (!vc4_hdmi_supports_scrambling(vc4_hdmi))
> -		return;
> -
> -	if (!drm_hdmi_mode_needs_scrambling(mode,
> -					    vc4_hdmi->output_bpc,
> -					    vc4_hdmi->output_format))
> -		return;
> -
>   	if (!drm_dev_enter(drm, &idx))
> -		return;
> -
> -	drm_scdc_set_high_tmds_clock_ratio(connector, true);
> -	drm_scdc_set_scrambling(connector, true);
> +		return 0;
>   
>   	spin_lock_irqsave(&vc4_hdmi->hw_lock, flags);
>   	HDMI_WRITE(HDMI_SCRAMBLER_CTL, HDMI_READ(HDMI_SCRAMBLER_CTL) |
> @@ -810,58 +676,27 @@ static void vc4_hdmi_enable_scrambling(struct drm_encoder *encoder)
>   
>   	drm_dev_exit(idx);
>   
> -	vc4_hdmi->scdc_enabled = true;
> -
> -	queue_delayed_work(system_percpu_wq, &vc4_hdmi->scrambling_work,
> -			   msecs_to_jiffies(SCRAMBLING_POLLING_DELAY_MS));
> +	return 0;
>   }
>   
> -static void vc4_hdmi_disable_scrambling(struct drm_encoder *encoder)
> +static int vc4_hdmi_scrambler_disable(struct drm_connector *connector)
>   {
> -	struct vc4_hdmi *vc4_hdmi = encoder_to_vc4_hdmi(encoder);
> -	struct drm_connector *connector = &vc4_hdmi->connector;
> +	struct vc4_hdmi *vc4_hdmi = connector_to_vc4_hdmi(connector);
>   	struct drm_device *drm = connector->dev;
>   	unsigned long flags;
>   	int idx;
>   
> -	lockdep_assert_held(&vc4_hdmi->mutex);
> -
> -	if (!vc4_hdmi->scdc_enabled)
> -		return;
> -
> -	vc4_hdmi->scdc_enabled = false;
> -
> -	cancel_delayed_work_sync(&vc4_hdmi->scrambling_work);
> -
>   	if (!drm_dev_enter(drm, &idx))
> -		return;
> +		return 0;
>   
>   	spin_lock_irqsave(&vc4_hdmi->hw_lock, flags);
>   	HDMI_WRITE(HDMI_SCRAMBLER_CTL, HDMI_READ(HDMI_SCRAMBLER_CTL) &
>   		   ~VC5_HDMI_SCRAMBLER_CTL_ENABLE);
>   	spin_unlock_irqrestore(&vc4_hdmi->hw_lock, flags);
>   
> -	drm_scdc_set_scrambling(connector, false);
> -	drm_scdc_set_high_tmds_clock_ratio(connector, false);
> -
>   	drm_dev_exit(idx);
> -}
>   
> -static void vc4_hdmi_scrambling_wq(struct work_struct *work)
> -{
> -	struct vc4_hdmi *vc4_hdmi = container_of(to_delayed_work(work),
> -						 struct vc4_hdmi,
> -						 scrambling_work);
> -	struct drm_connector *connector = &vc4_hdmi->connector;
> -
> -	if (drm_scdc_get_scrambling_status(connector))
> -		return;
> -
> -	drm_scdc_set_high_tmds_clock_ratio(connector, true);
> -	drm_scdc_set_scrambling(connector, true);
> -
> -	queue_delayed_work(system_percpu_wq, &vc4_hdmi->scrambling_work,
> -			   msecs_to_jiffies(SCRAMBLING_POLLING_DELAY_MS));
> +	return 0;
>   }
>   
>   static void vc4_hdmi_encoder_post_crtc_disable(struct drm_encoder *encoder,
> @@ -931,7 +766,7 @@ static void vc4_hdmi_encoder_post_crtc_powerdown(struct drm_encoder *encoder,
>   	if (vc4_hdmi->variant->phy_disable)
>   		vc4_hdmi->variant->phy_disable(vc4_hdmi);
>   
> -	vc4_hdmi_disable_scrambling(encoder);
> +	drm_connector_hdmi_disable_scrambling(&vc4_hdmi->connector);
>   
>   	clk_disable_unprepare(vc4_hdmi->pixel_bvb_clock);
>   	clk_disable_unprepare(vc4_hdmi->pixel_clock);
> @@ -1540,7 +1375,7 @@ static void vc4_hdmi_encoder_pre_crtc_configure(struct drm_encoder *encoder,
>   		goto err_disable_pixel_clock;
>   	}
>   
> -	vc4_hdmi_enable_scrambling(encoder);
> +	drm_connector_hdmi_enable_scrambling(connector, conn_state);
>   
>   	if (vc4_hdmi->variant->phy_init)
>   		vc4_hdmi->variant->phy_init(vc4_hdmi, conn_state);
> @@ -1691,8 +1526,6 @@ static void vc4_hdmi_encoder_atomic_mode_set(struct drm_encoder *encoder,
>   	mutex_lock(&vc4_hdmi->mutex);
>   	drm_mode_copy(&vc4_hdmi->saved_adjusted_mode,
>   		      &crtc_state->adjusted_mode);
> -	vc4_hdmi->output_bpc = conn_state->hdmi.output_bpc;
> -	vc4_hdmi->output_format = conn_state->hdmi.output_format;
>   	mutex_unlock(&vc4_hdmi->mutex);
>   }
>   
> @@ -1762,8 +1595,9 @@ static const struct drm_connector_hdmi_funcs vc4_hdmi_connector_funcs_hdmi14 = {
>   static const struct drm_connector_hdmi_funcs vc4_hdmi_connector_funcs_hdmi20 = {
>   	VC4_HDMI_CONNECTOR_FUNCS_COMMON,
>   	.max_bpc		= 12,
> -	/* TODO: set HDMI_VERSION_2_0 and convert to common scrambler infra */
> -	.supported_hdmi_ver	= HDMI_VERSION_UNKNOWN,
> +	.supported_hdmi_ver	= HDMI_VERSION_2_0,
> +	.scrambler_enable	= vc4_hdmi_scrambler_enable,
> +	.scrambler_disable	= vc4_hdmi_scrambler_disable,
>   };
>   
>   #define WIFI_2_4GHz_CH1_MIN_FREQ	2400000000ULL
> @@ -3245,7 +3079,6 @@ static int vc4_hdmi_bind(struct device *dev, struct device *master, void *data)
>   		return ret;
>   
>   	spin_lock_init(&vc4_hdmi->hw_lock);
> -	INIT_DELAYED_WORK(&vc4_hdmi->scrambling_work, vc4_hdmi_scrambling_wq);
>   
>   	dev_set_drvdata(dev, vc4_hdmi);
>   	encoder = &vc4_hdmi->encoder.base;
> @@ -3258,15 +3091,6 @@ static int vc4_hdmi_bind(struct device *dev, struct device *master, void *data)
>   	vc4_hdmi->pdev = pdev;
>   	vc4_hdmi->variant = variant;
>   
> -	/*
> -	 * Since we don't know the state of the controller and its
> -	 * display (if any), let's assume it's always enabled.
> -	 * vc4_hdmi_disable_scrambling() will thus run at boot, make
> -	 * sure it's disabled, and avoid any inconsistency.
> -	 */
> -	if (variant->max_pixel_clock > HDMI_1_3_TMDS_CHAR_RATE_MAX_HZ)
> -		vc4_hdmi->scdc_enabled = true;
> -
>   	ret = variant->init_resources(drm, vc4_hdmi);
>   	if (ret)
>   		return ret;
> diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.h b/drivers/gpu/drm/vc4/vc4_hdmi.h
> index b2879c29d02e..e6cd40acc843 100644
> --- a/drivers/gpu/drm/vc4/vc4_hdmi.h
> +++ b/drivers/gpu/drm/vc4/vc4_hdmi.h
> @@ -118,8 +118,6 @@ struct vc4_hdmi {
>   	struct vc4_encoder encoder;
>   	struct drm_connector connector;
>   
> -	struct delayed_work scrambling_work;
> -
>   	struct i2c_adapter *ddc;
>   	void __iomem *hdmicore_regs;
>   	void __iomem *hd_regs;
> @@ -187,25 +185,6 @@ struct vc4_hdmi {
>   	 */
>   	struct drm_display_mode saved_adjusted_mode;
>   
> -	/**
> -	 * @scdc_enabled: Is the HDMI controller currently running with
> -	 * the scrambler on? Protected by @mutex.
> -	 */
> -	bool scdc_enabled;
> -
> -	/**
> -	 * @output_bpc: Copy of @drm_connector_state.hdmi.output_bpc for
> -	 * use outside of KMS hooks. Protected by @mutex.
> -	 */
> -	unsigned int output_bpc;
> -
> -	/**
> -	 * @output_format: Copy of
> -	 * @drm_connector_state.hdmi.output_format for use outside of
> -	 * KMS hooks. Protected by @mutex.
> -	 */
> -	enum drm_output_color_format output_format;
> -
>   	/**
>   	 * @hdmi_jack: Represents the connection state of the HDMI plug, for
>   	 * ALSA jack detection.
> 

