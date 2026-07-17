Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13941C44507
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 07:51:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6484E10F486;
	Fri, 17 Jul 2026 07:51:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="dP8MMfrG";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="itOI2W+S";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="dP8MMfrG";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="itOI2W+S";
	dkim-atps=neutral
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 997BC10F486
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 07:51:07 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2D1BB78DA8;
 Fri, 17 Jul 2026 07:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1784274666; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=bUuGmw5tyOc/1Rjy8hzhSNO6cFGjdgIIAvVlsFl2lHw=;
 b=dP8MMfrGJUxCLn7v0/7Irm2GyyJRUQuWjYNxxF6c2Eadoz2dLLKoP/CZU2YGd3AsSZpTCo
 EsuJwFbmJ2OYfI+ZeX/V6xq0Opf3lZNnDWz/u85V+x64rlm4AXyIcGFMpbJIdMLnNq/54m
 Dor32bbhFx4vBAM8I6ppvNtqQYlgpT8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1784274666;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=bUuGmw5tyOc/1Rjy8hzhSNO6cFGjdgIIAvVlsFl2lHw=;
 b=itOI2W+SgcQWu9FxXtVfs20IEtFHBJ0H6gFINeAd/3y2xt33BsERGI9/uOr8GwsBrOqDjY
 xgeB89TuNKHsRHCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1784274666; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=bUuGmw5tyOc/1Rjy8hzhSNO6cFGjdgIIAvVlsFl2lHw=;
 b=dP8MMfrGJUxCLn7v0/7Irm2GyyJRUQuWjYNxxF6c2Eadoz2dLLKoP/CZU2YGd3AsSZpTCo
 EsuJwFbmJ2OYfI+ZeX/V6xq0Opf3lZNnDWz/u85V+x64rlm4AXyIcGFMpbJIdMLnNq/54m
 Dor32bbhFx4vBAM8I6ppvNtqQYlgpT8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1784274666;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=bUuGmw5tyOc/1Rjy8hzhSNO6cFGjdgIIAvVlsFl2lHw=;
 b=itOI2W+SgcQWu9FxXtVfs20IEtFHBJ0H6gFINeAd/3y2xt33BsERGI9/uOr8GwsBrOqDjY
 xgeB89TuNKHsRHCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E4E8B779AA;
 Fri, 17 Jul 2026 07:51:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id jc2gNuneWWoIGgAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Fri, 17 Jul 2026 07:51:05 +0000
Message-ID: <45f2c37d-0318-46e9-9b55-c840cffdafec@suse.de>
Date: Fri, 17 Jul 2026 09:51:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/gma500: cdv_intel_dp: fix indentation to use tabs
 instead of spaces
To: Diogo Silva <diogompaissilva@gmail.com>,
 Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260623-cdv_intel_dp_indentation-v1-1-bcb61da38f17@gmail.com>
Content-Language: en-US
From: Thomas Zimmermann <tzimmermann@suse.de>
Autocrypt: addr=tzimmermann@suse.de; keydata=
 xsBNBFs50uABCADEHPidWt974CaxBVbrIBwqcq/WURinJ3+2WlIrKWspiP83vfZKaXhFYsdg
 XH47fDVbPPj+d6tQrw5lPQCyqjwrCPYnq3WlIBnGPJ4/jreTL6V+qfKRDlGLWFjZcsrPJGE0
 BeB5BbqP5erN1qylK9i3gPoQjXGhpBpQYwRrEyQyjuvk+Ev0K1Jc5tVDeJAuau3TGNgah4Yc
 hdHm3bkPjz9EErV85RwvImQ1dptvx6s7xzwXTgGAsaYZsL8WCwDaTuqFa1d1jjlaxg6+tZsB
 9GluwvIhSezPgnEmimZDkGnZRRSFiGP8yjqTjjWuf0bSj5rUnTGiyLyRZRNGcXmu6hjlABEB
 AAHNJ1Rob21hcyBaaW1tZXJtYW5uIDx0emltbWVybWFubkBzdXNlLmRlPsLAjgQTAQgAOAIb
 AwULCQgHAgYVCgkICwIEFgIDAQIeAQIXgBYhBHIX+6yM6c9jRKFo5WgNwR1TC3ojBQJftODH
 AAoJEGgNwR1TC3ojx1wH/0hKGWugiqDgLNXLRD/4TfHBEKmxIrmfu9Z5t7vwUKfwhFL6hqvo
 lXPJJKQpQ2z8+X2vZm/slsLn7J1yjrOsoJhKABDi+3QWWSGkaGwRJAdPVVyJMfJRNNNIKwVb
 U6B1BkX2XDKDGffF4TxlOpSQzdtNI/9gleOoUA8+jy8knnDYzjBNOZqLG2FuTdicBXblz0Mf
 vg41gd9kCwYXDnD91rJU8tzylXv03E75NCaTxTM+FBXPmsAVYQ4GYhhgFt8S2UWMoaaABLDe
 7l5FdnLdDEcbmd8uLU2CaG4W2cLrUaI4jz2XbkcPQkqTQ3EB67hYkjiEE6Zy3ggOitiQGcqp
 j//OwE0EWznS4AEIAMYmP4M/V+T5RY5at/g7rUdNsLhWv1APYrh9RQefODYHrNRHUE9eosYb
 T6XMryR9hT8XlGOYRwKWwiQBoWSDiTMo/Xi29jUnn4BXfI2px2DTXwc22LKtLAgTRjP+qbU6
 3Y0xnQN29UGDbYgyyK51DW3H0If2a3JNsheAAK+Xc9baj0LGIc8T9uiEWHBnCH+RdhgATnWW
 GKdDegUR5BkDfDg5O/FISymJBHx2Dyoklv5g4BzkgqTqwmaYzsl8UxZKvbaxq0zbehDda8lv
 hFXodNFMAgTLJlLuDYOGLK2AwbrS3Sp0AEbkpdJBb44qVlGm5bApZouHeJ/+n+7r12+lqdsA
 EQEAAcLAdgQYAQgAIAIbDBYhBHIX+6yM6c9jRKFo5WgNwR1TC3ojBQJftOH6AAoJEGgNwR1T
 C3ojVSkIALpAPkIJPQoURPb1VWjh34l0HlglmYHvZszJWTXYwavHR8+k6Baa6H7ufXNQtThR
 yIxJrQLW6rV5lm7TjhffEhxVCn37+cg0zZ3j7zIsSS0rx/aMwi6VhFJA5hfn3T0TtrijKP4A
 SAQO9xD1Zk9/61JWk8OysuIh7MXkl0fxbRKWE93XeQBhIJHQfnc+YBLprdnxR446Sh8Wn/2D
 Ya8cavuWf2zrB6cZurs048xe0UbSW5AOSo4V9M0jzYI4nZqTmPxYyXbm30Kvmz0rYVRaitYJ
 4kyYYMhuULvrJDMjZRvaNe52tkKAvMevcGdt38H4KSVXAylqyQOW5zvPc4/sq9c=
In-Reply-To: <20260623-cdv_intel_dp_indentation-v1-1-bcb61da38f17@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 FREEMAIL_TO(0.00)[gmail.com,linux.intel.com,kernel.org,ffwll.ch];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; RCPT_COUNT_SEVEN(0.00)[8];
 MID_RHS_MATCH_FROM(0.00)[]; TAGGED_RCPT(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.com:url,
 suse.de:email, suse.de:mid]
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



Am 23.06.26 um 21:56 schrieb Diogo Silva:
> The kernel coding style specifies that tabs should be used instead of
> spaces, which the cdv_intel_dp driver was not using in some places.
> This patch replaces the space indentations with tabs.
>
> Signed-off-by: Diogo Silva <diogompaissilva@gmail.com>

Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>

> ---
>   drivers/gpu/drm/gma500/cdv_intel_dp.c | 111 +++++++++++++++++-----------------
>   1 file changed, 56 insertions(+), 55 deletions(-)
>
> diff --git a/drivers/gpu/drm/gma500/cdv_intel_dp.c b/drivers/gpu/drm/gma500/cdv_intel_dp.c
> index fbed35cf7603..7d08011d9663 100644
> --- a/drivers/gpu/drm/gma500/cdv_intel_dp.c
> +++ b/drivers/gpu/drm/gma500/cdv_intel_dp.c
> @@ -232,16 +232,17 @@ i2c_dp_aux_add_bus(struct i2c_adapter *adapter)
>   }
>   
>   #define _wait_for(COND, MS, W) ({ \
> -        unsigned long timeout__ = jiffies + msecs_to_jiffies(MS);       \
> -        int ret__ = 0;                                                  \
> -        while (! (COND)) {                                              \
> -                if (time_after(jiffies, timeout__)) {                   \
> -                        ret__ = -ETIMEDOUT;                             \
> -                        break;                                          \
> -                }                                                       \
> -                if (W && !in_dbg_master()) msleep(W);                   \
> -        }                                                               \
> -        ret__;                                                          \
> +	unsigned long timeout__ = jiffies + msecs_to_jiffies(MS);       \
> +	int ret__ = 0;                                                  \
> +	while (!(COND)) {                                               \
> +		if (time_after(jiffies, timeout__)) {                   \
> +			ret__ = -ETIMEDOUT;                             \
> +			break;                                          \
> +		}                                                       \
> +		if (W && !in_dbg_master())                              \
> +			msleep(W);                                      \
> +	}                                                               \
> +	ret__;                                                          \
>   })
>   
>   #define wait_for(COND, MS) _wait_for(COND, MS, 1)
> @@ -296,10 +297,10 @@ static struct ddi_regoff ddi_DP_train_table[] = {
>   };
>   
>   static uint32_t dp_vswing_premph_table[] = {
> -        0x55338954,	0x4000,
> -        0x554d8954,	0x2000,
> -        0x55668954,	0,
> -        0x559ac0d4,	0x6000,
> +	0x55338954,	0x4000,
> +	0x554d8954,	0x2000,
> +	0x55668954,	0,
> +	0x559ac0d4,	0x6000,
>   };
>   /**
>    * is_edp - is the given port attached to an eDP panel (either CPU or PCH)
> @@ -1141,7 +1142,7 @@ static void cdv_intel_dp_prepare(struct drm_encoder *encoder)
>   		cdv_intel_edp_backlight_off(intel_encoder);
>   		cdv_intel_edp_panel_off(intel_encoder);
>   		cdv_intel_edp_panel_vdd_on(intel_encoder);
> -        }
> +	}
>   	/* Wake up the sink first */
>   	cdv_intel_dp_sink_dpms(intel_encoder, DRM_MODE_DPMS_ON);
>   	cdv_intel_dp_link_down(intel_encoder);
> @@ -1183,7 +1184,7 @@ cdv_intel_dp_dpms(struct drm_encoder *encoder, int mode)
>   			cdv_intel_edp_panel_off(intel_encoder);
>   		}
>   	} else {
> -        	if (edp)
> +		if (edp)
>   			cdv_intel_edp_panel_on(intel_encoder);
>   		cdv_intel_dp_sink_dpms(intel_encoder, mode);
>   		if (!(dp_reg & DP_PORT_EN)) {
> @@ -1191,7 +1192,7 @@ cdv_intel_dp_dpms(struct drm_encoder *encoder, int mode)
>   			cdv_intel_dp_complete_link_train(intel_encoder);
>   		}
>   		if (edp)
> -        		cdv_intel_edp_backlight_on(intel_encoder);
> +			cdv_intel_edp_backlight_on(intel_encoder);
>   	}
>   }
>   
> @@ -1419,8 +1420,8 @@ cdv_intel_dp_set_vswing_premph(struct gma_encoder *encoder, uint8_t signal_level
>   	DRM_DEBUG_KMS("Test2\n");
>   	//return ;
>   	cdv_sb_reset(dev);
> -	/* ;Swing voltage programming
> -        ;gfx_dpio_set_reg(0xc058, 0x0505313A) */
> +	/* ;Swing voltage programming */
> +	/* ;gfx_dpio_set_reg(0xc058, 0x0505313A) */
>   	cdv_sb_write(dev, ddi_reg->VSwing5, 0x0505313A);
>   
>   	/* ;gfx_dpio_set_reg(0x8154, 0x43406055) */
> @@ -1575,7 +1576,7 @@ cdv_intel_dp_complete_link_train(struct gma_encoder *encoder)
>   				intel_dp->train_set[0],
>   				intel_dp->link_configuration[0],
>   				intel_dp->link_configuration[1]);
> -        	/* channel eq pattern */
> +		/* channel eq pattern */
>   
>   		if (!cdv_intel_dp_set_link_train(encoder, reg,
>   					     DP_TRAINING_PATTERN_2)) {
> @@ -1704,7 +1705,7 @@ cdv_intel_dp_detect(struct drm_connector *connector, bool force)
>   		if (edp)
>   			cdv_intel_edp_panel_vdd_off(encoder);
>   		return status;
> -        }
> +	}
>   
>   	if (intel_dp->force_audio) {
>   		intel_dp->has_audio = intel_dp->force_audio > 0;
> @@ -1956,12 +1957,12 @@ cdv_intel_dp_init(struct drm_device *dev, struct psb_intel_mode_device *mode_dev
>   	gma_encoder = kzalloc_obj(struct gma_encoder);
>   	if (!gma_encoder)
>   		return;
> -        gma_connector = kzalloc_obj(struct gma_connector);
> -        if (!gma_connector)
> -                goto err_connector;
> +	gma_connector = kzalloc_obj(struct gma_connector);
> +	if (!gma_connector)
> +		goto err_connector;
>   	intel_dp = kzalloc_obj(struct cdv_intel_dp);
>   	if (!intel_dp)
> -	        goto err_priv;
> +		goto err_priv;
>   
>   	if ((output_reg == DP_C) && cdv_intel_dpc_is_edp(dev))
>   		type = DRM_MODE_CONNECTOR_eDP;
> @@ -1976,7 +1977,7 @@ cdv_intel_dp_init(struct drm_device *dev, struct psb_intel_mode_device *mode_dev
>   
>   	if (type == DRM_MODE_CONNECTOR_DisplayPort)
>   		gma_encoder->type = INTEL_OUTPUT_DISPLAYPORT;
> -        else
> +	else
>   		gma_encoder->type = INTEL_OUTPUT_EDP;
>   
>   
> @@ -2006,18 +2007,18 @@ cdv_intel_dp_init(struct drm_device *dev, struct psb_intel_mode_device *mode_dev
>   	cdv_disable_intel_clock_gating(dev);
>   
>   	cdv_intel_dp_i2c_init(gma_connector, gma_encoder, name);
> -        /* FIXME:fail check */
> +	/* FIXME:fail check */
>   	cdv_intel_dp_add_properties(connector);
>   
>   	if (is_edp(gma_encoder)) {
>   		int ret;
>   		struct edp_power_seq cur;
> -                u32 pp_on, pp_off, pp_div;
> +		u32 pp_on, pp_off, pp_div;
>   		u32 pwm_ctrl;
>   
>   		pp_on = REG_READ(PP_CONTROL);
>   		pp_on &= ~PANEL_UNLOCK_MASK;
> -	        pp_on |= PANEL_UNLOCK_REGS;
> +		pp_on |= PANEL_UNLOCK_REGS;
>   
>   		REG_WRITE(PP_CONTROL, pp_on);
>   
> @@ -2025,42 +2026,42 @@ cdv_intel_dp_init(struct drm_device *dev, struct psb_intel_mode_device *mode_dev
>   		pwm_ctrl |= PWM_PIPE_B;
>   		REG_WRITE(BLC_PWM_CTL2, pwm_ctrl);
>   
> -                pp_on = REG_READ(PP_ON_DELAYS);
> -                pp_off = REG_READ(PP_OFF_DELAYS);
> -                pp_div = REG_READ(PP_DIVISOR);
> +		pp_on = REG_READ(PP_ON_DELAYS);
> +		pp_off = REG_READ(PP_OFF_DELAYS);
> +		pp_div = REG_READ(PP_DIVISOR);
>   
>   		/* Pull timing values out of registers */
> -                cur.t1_t3 = (pp_on & PANEL_POWER_UP_DELAY_MASK) >>
> -                        PANEL_POWER_UP_DELAY_SHIFT;
> +		cur.t1_t3 = (pp_on & PANEL_POWER_UP_DELAY_MASK) >>
> +			    PANEL_POWER_UP_DELAY_SHIFT;
>   
> -                cur.t8 = (pp_on & PANEL_LIGHT_ON_DELAY_MASK) >>
> -                        PANEL_LIGHT_ON_DELAY_SHIFT;
> +		cur.t8 = (pp_on & PANEL_LIGHT_ON_DELAY_MASK) >>
> +			 PANEL_LIGHT_ON_DELAY_SHIFT;
>   
> -                cur.t9 = (pp_off & PANEL_LIGHT_OFF_DELAY_MASK) >>
> -                        PANEL_LIGHT_OFF_DELAY_SHIFT;
> +		cur.t9 = (pp_off & PANEL_LIGHT_OFF_DELAY_MASK) >>
> +			 PANEL_LIGHT_OFF_DELAY_SHIFT;
>   
> -                cur.t10 = (pp_off & PANEL_POWER_DOWN_DELAY_MASK) >>
> -                        PANEL_POWER_DOWN_DELAY_SHIFT;
> +		cur.t10 = (pp_off & PANEL_POWER_DOWN_DELAY_MASK) >>
> +			  PANEL_POWER_DOWN_DELAY_SHIFT;
>   
> -                cur.t11_t12 = ((pp_div & PANEL_POWER_CYCLE_DELAY_MASK) >>
> -                               PANEL_POWER_CYCLE_DELAY_SHIFT);
> +		cur.t11_t12 = ((pp_div & PANEL_POWER_CYCLE_DELAY_MASK) >>
> +			      PANEL_POWER_CYCLE_DELAY_SHIFT);
>   
> -                DRM_DEBUG_KMS("cur t1_t3 %d t8 %d t9 %d t10 %d t11_t12 %d\n",
> -                              cur.t1_t3, cur.t8, cur.t9, cur.t10, cur.t11_t12);
> +		DRM_DEBUG_KMS("cur t1_t3 %d t8 %d t9 %d t10 %d t11_t12 %d\n",
> +			      cur.t1_t3, cur.t8, cur.t9, cur.t10, cur.t11_t12);
>   
>   
>   		intel_dp->panel_power_up_delay = cur.t1_t3 / 10;
> -                intel_dp->backlight_on_delay = cur.t8 / 10;
> -                intel_dp->backlight_off_delay = cur.t9 / 10;
> -                intel_dp->panel_power_down_delay = cur.t10 / 10;
> -                intel_dp->panel_power_cycle_delay = (cur.t11_t12 - 1) * 100;
> +		intel_dp->backlight_on_delay = cur.t8 / 10;
> +		intel_dp->backlight_off_delay = cur.t9 / 10;
> +		intel_dp->panel_power_down_delay = cur.t10 / 10;
> +		intel_dp->panel_power_cycle_delay = (cur.t11_t12 - 1) * 100;
>   
> -                DRM_DEBUG_KMS("panel power up delay %d, power down delay %d, power cycle delay %d\n",
> -                              intel_dp->panel_power_up_delay, intel_dp->panel_power_down_delay,
> -                              intel_dp->panel_power_cycle_delay);
> +		DRM_DEBUG_KMS("panel power up delay %d, power down delay %d, power cycle delay %d\n",
> +			      intel_dp->panel_power_up_delay, intel_dp->panel_power_down_delay,
> +			      intel_dp->panel_power_cycle_delay);
>   
> -                DRM_DEBUG_KMS("backlight on delay %d, off delay %d\n",
> -                              intel_dp->backlight_on_delay, intel_dp->backlight_off_delay);
> +		DRM_DEBUG_KMS("backlight on delay %d, off delay %d\n",
> +			      intel_dp->backlight_on_delay, intel_dp->backlight_off_delay);
>   
>   
>   		cdv_intel_edp_panel_vdd_on(gma_encoder);
> @@ -2075,7 +2076,7 @@ cdv_intel_dp_init(struct drm_device *dev, struct psb_intel_mode_device *mode_dev
>   			cdv_intel_dp_destroy(connector);
>   			goto err_connector;
>   		} else {
> -        		DRM_DEBUG_KMS("DPCD: Rev=%x LN_Rate=%x LN_CNT=%x LN_DOWNSP=%x\n",
> +			DRM_DEBUG_KMS("DPCD: Rev=%x LN_Rate=%x LN_CNT=%x LN_DOWNSP=%x\n",
>   				intel_dp->dpcd[0], intel_dp->dpcd[1],
>   				intel_dp->dpcd[2], intel_dp->dpcd[3]);
>   
> @@ -2083,7 +2084,7 @@ cdv_intel_dp_init(struct drm_device *dev, struct psb_intel_mode_device *mode_dev
>   		/* The CDV reference driver moves pnale backlight setup into the displays that
>   		   have a backlight: this is a good idea and one we should probably adopt, however
>   		   we need to migrate all the drivers before we can do that */
> -                /*cdv_intel_panel_setup_backlight(dev); */
> +		/*cdv_intel_panel_setup_backlight(dev); */
>   	}
>   	return;
>   
>
> ---
> base-commit: e2a6e04d045a56c6dc61e1eb9e2a6d7cf86512cd
> change-id: 20260623-cdv_intel_dp_indentation-bac45d43abcb
>
> Best regards,

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, (HRB 36809, AG Nürnberg)


