Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2461DCD4855
	for <dri-devel@archiver.kernel.org>; Tue, 12 May 2026 07:31:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 86D3110E1B5;
	Tue, 12 May 2026 07:31:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="FOnO2F2b";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="yK83A5Jw";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="FOnO2F2b";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="yK83A5Jw";
	dkim-atps=neutral
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC84710E1B5
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 07:31:15 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7ECD661F52;
 Tue, 12 May 2026 07:31:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1778571074; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Iirvc59L7aI8RoFaXdEGeBMR8NhXaJpkhZdqLUFzNwg=;
 b=FOnO2F2b1vZ5Slg1jQlWAu515Aa0hP6pMZUZey0GPPxhYti7FZtPOCiGR32+VK2X3qTPqd
 82hAhPbI7SE8vmyr5i4wDbUoz5EU5HbsIYLMShbHh8SwdkmeGBAT8tAsSBCy2/Eg+EouCL
 Ng36uS9wx+D9MMlZ/eMwkk1MclYrZts=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1778571074;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Iirvc59L7aI8RoFaXdEGeBMR8NhXaJpkhZdqLUFzNwg=;
 b=yK83A5Jw3eznq3i2eHWXuuWuPhBDDDXjHBV1YpN6rF2ywMXRJlp0cpnxdSL6hrLibILHDo
 Y4/YzOZROPyQcDAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1778571074; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Iirvc59L7aI8RoFaXdEGeBMR8NhXaJpkhZdqLUFzNwg=;
 b=FOnO2F2b1vZ5Slg1jQlWAu515Aa0hP6pMZUZey0GPPxhYti7FZtPOCiGR32+VK2X3qTPqd
 82hAhPbI7SE8vmyr5i4wDbUoz5EU5HbsIYLMShbHh8SwdkmeGBAT8tAsSBCy2/Eg+EouCL
 Ng36uS9wx+D9MMlZ/eMwkk1MclYrZts=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1778571074;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Iirvc59L7aI8RoFaXdEGeBMR8NhXaJpkhZdqLUFzNwg=;
 b=yK83A5Jw3eznq3i2eHWXuuWuPhBDDDXjHBV1YpN6rF2ywMXRJlp0cpnxdSL6hrLibILHDo
 Y4/YzOZROPyQcDAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A4E78593A9;
 Tue, 12 May 2026 07:31:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id LhzSJkDXAmqdQgAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Tue, 12 May 2026 07:31:12 +0000
Message-ID: <308b5681-01ff-4bec-a449-522060a7d7fc@suse.de>
Date: Tue, 12 May 2026 09:31:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for drm-misc-fixes v6 2/4] drm/hisilicon/hibmc: fix no
 showing when no connectors connected
To: Yongbang Shi <shiyongbang@huawei.com>, dmitry.baryshkov@oss.qualcomm.com, 
 tiantao6@hisilicon.com, xinliang.liu@linaro.org,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, airlied@gmail.com,
 daniel@ffwll.ch, kong.kongxinwei@hisilicon.com
Cc: liangjian010@huawei.com, chenjianmin@huawei.com, fengsheng5@huawei.com,
 helin52@h-partners.com, shenjian15@huawei.com, shaojijie@huawei.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260509032302.2057227-1-shiyongbang@huawei.com>
 <20260509032302.2057227-3-shiyongbang@huawei.com>
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
In-Reply-To: <20260509032302.2057227-3-shiyongbang@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCPT_COUNT_TWELVE(0.00)[17];
 MIME_TRACE(0.00)[0:+]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 FREEMAIL_TO(0.00)[huawei.com,oss.qualcomm.com,hisilicon.com,linaro.org,linux.intel.com,kernel.org,gmail.com,ffwll.ch];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 URIBL_BLOCKED(0.00)[hisilicon.com:email,imap1.dmz-prg2.suse.org:helo,suse.com:url,huawei.com:email,suse.de:mid,suse.de:email,checkpatch.pl:url];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid, suse.de:email, checkpatch.pl:url,
 imap1.dmz-prg2.suse.org:helo, suse.com:url, huawei.com:email]
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



Am 09.05.26 um 05:23 schrieb Yongbang Shi:
> From: Lin He <helin52@huawei.com>
>
> Our chip support KVM over IP feature, so hibmc driver need to support
> displaying without any connectors plugged in. If no connectors are
> connected, the vdac connector status should be set to 'connected' to
> ensure proper KVM display functionality. Additionally, for
> previous-generation products that may lack hardware link support and
> thus cannot detect the monitor, the same approach should be applied
> to ensure VGA display functionality.
>
> * Add phys_state in the struct of dp and vdac to check physical outputs.
>
> * The 'epoch_counter' of the vdac connector is incremented when the
> physical status changes.
>
> For get_modes: using BMC modes for connector if no display is attached to
> phys VGA cable, otherwise use EDID modes by drm_connector_helper_get_modes,
> because KVM doesn't provide EDID reads.
>
> The polling mechanism for the KMS helper is enabled.
>
> Fixes: 4c962bc929f1 ("drm/hisilicon/hibmc: Add vga connector detect functions")
> Reported-by: Thomas Zimmermann <tzimmermann@suse.de>
> Closes: https://lore.kernel.org/all/0eb5c509-2724-4c57-87ad-74e4270d5a5a@suse.de/
> Signed-off-by: Lin He <helin52@huawei.com>
> Signed-off-by: Yongbang Shi <shiyongbang@huawei.com>

Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>

This patch fixes the problem with my test device. I now get the default 
VGA resolutions, which seems like the correct solution to me.

Tested-by: Thomas Zimmermann <tzimmermann@suse.de>

> ---
> ChangeLog:
> v5 -> v6:
>    - Rename 'phys_state' to 'phys_status'
>    - Replace `drm_kms_helper_poll_init` with `drmm_kms_helper_poll_init`
>      and adjust the timing of the call.
>    - Split "return vdac->phys_state = state;" into separate statements.
>    - Change `get_modes` to return 0 when no modes are available, allowing DRM to
>      install a default resolution.
>    - Change the initial phys_status of vdac from
>      'connector_status_connected' to 'connector_status_disconnected'
> v4 -> v5:
>    - The 'epoch_counter' of the vdac connector is incremented when the physical
>      status changes.
>    - The polling mechanism for the KMS helper is enabled.
> v1 -> v2:
>    - fix the checkpatch.pl warning "line length of 83/85 exceeds 80 columns".
>    - remove tag "Reviewed-by: Tao Tian <tiantao6@hisilicon.com>", witch will
>      be given in public.
>    - add 'drm-misc-fixes' in subject prefix.
> ---
>   drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.h    |  1 +
>   .../gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c    | 33 ++++++++----
>   .../gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c   |  3 ++
>   .../gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h   |  1 +
>   .../gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c  | 53 +++++++++++++------
>   5 files changed, 64 insertions(+), 27 deletions(-)
>
> diff --git a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.h b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.h
> index 31316fe1ea8d..0f3662d8737e 100644
> --- a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.h
> +++ b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.h
> @@ -55,6 +55,7 @@ struct hibmc_dp {
>   	struct drm_dp_aux aux;
>   	struct hibmc_dp_cbar_cfg cfg;
>   	u32 irq_status;
> +	int phys_status;
>   };
>   
>   int hibmc_dp_hw_init(struct hibmc_dp *dp);
> diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c
> index 35dff7bfbf76..596c5bfe32d8 100644
> --- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c
> +++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c
> @@ -61,27 +61,38 @@ static int hibmc_dp_detect(struct drm_connector *connector,
>   {
>   	struct hibmc_dp *dp = to_hibmc_dp(connector);
>   	struct hibmc_dp_dev *dp_dev = dp->dp_dev;
> -	int ret;
> +	int ret = connector_status_disconnected;
>   
>   	if (dp->irq_status) {
> -		if (dp_dev->hpd_status != HIBMC_HPD_IN)
> -			return connector_status_disconnected;
> +		if (dp_dev->hpd_status != HIBMC_HPD_IN) {
> +			ret = connector_status_disconnected;
> +			goto exit;
> +		}
>   	}
>   
> -	if (!hibmc_dp_get_dpcd(dp_dev))
> -		return connector_status_disconnected;
> +	if (!hibmc_dp_get_dpcd(dp_dev)) {
> +		ret = connector_status_disconnected;
> +		goto exit;
> +	}
>   
> -	if (!dp_dev->is_branch)
> -		return connector_status_connected;
> +	if (!dp_dev->is_branch) {
> +		ret = connector_status_connected;
> +		goto exit;
> +	}
>   
>   	if (drm_dp_read_sink_count_cap(connector, dp_dev->dpcd, &dp_dev->desc) &&
>   	    dp_dev->downstream_ports[0] & DP_DS_PORT_HPD) {
>   		ret = drm_dp_read_sink_count(dp_dev->aux);
> -		if (ret > 0)
> -			return connector_status_connected;
> +		if (ret > 0) {
> +			ret = connector_status_connected;
> +			goto exit;
> +		}
>   	}
>   
> -	return connector_status_disconnected;
> +exit:
> +	dp->phys_status = ret;
> +
> +	return ret;
>   }
>   
>   static int hibmc_dp_mode_valid(struct drm_connector *connector,
> @@ -243,5 +254,7 @@ int hibmc_dp_init(struct hibmc_drm_private *priv)
>   
>   	connector->polled = DRM_CONNECTOR_POLL_HPD;
>   
> +	dp->phys_status = connector_status_disconnected;
> +
>   	return 0;
>   }
> diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
> index a0ecf82b576f..e3b40c6a6250 100644
> --- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
> +++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
> @@ -25,6 +25,7 @@
>   #include <drm/drm_managed.h>
>   #include <drm/drm_module.h>
>   #include <drm/drm_vblank.h>
> +#include <drm/drm_probe_helper.h>
>   
>   #include "hibmc_drm_drv.h"
>   #include "hibmc_drm_regs.h"
> @@ -385,6 +386,8 @@ static int hibmc_load(struct drm_device *dev)
>   	/* reset all the states of crtc/plane/encoder/connector */
>   	drm_mode_config_reset(dev);
>   
> +	drmm_kms_helper_poll_init(dev);
> +
>   	return 0;
>   
>   err:
> diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
> index 4e212af6143d..dce8572bf63e 100644
> --- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
> +++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
> @@ -31,6 +31,7 @@ struct hibmc_vdac {
>   	struct drm_connector connector;
>   	struct i2c_adapter adapter;
>   	struct i2c_algo_bit_data bit_data;
> +	int phys_status;
>   };
>   
>   struct hibmc_drm_private {
> diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c
> index 841e81f47b68..2fcfa3246fd1 100644
> --- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c
> +++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c
> @@ -24,28 +24,21 @@
>   
>   static int hibmc_connector_get_modes(struct drm_connector *connector)
>   {
> +	struct drm_mode_config *mode_config = &connector->dev->mode_config;
>   	struct hibmc_vdac *vdac = to_hibmc_vdac(connector);
> -	const struct drm_edid *drm_edid;
>   	int count;
>   
> -	drm_edid = drm_edid_read_ddc(connector, &vdac->adapter);
> -
> -	drm_edid_connector_update(connector, drm_edid);
> -
> -	if (drm_edid) {
> -		count = drm_edid_connector_add_modes(connector);
> +	if (vdac->phys_status == connector_status_connected) {
> +		count = drm_connector_helper_get_modes(connector);
> +	} else {
> +		drm_edid_connector_update(connector, NULL);
> +		count = drm_add_modes_noedid(connector,
> +					     mode_config->max_width,
> +					     mode_config->max_height);
>   		if (count)
> -			goto out;
> +			drm_set_preferred_mode(connector, 1024, 768);
>   	}
>   
> -	count = drm_add_modes_noedid(connector,
> -				     connector->dev->mode_config.max_width,
> -				     connector->dev->mode_config.max_height);
> -	drm_set_preferred_mode(connector, 1024, 768);
> -
> -out:
> -	drm_edid_free(drm_edid);
> -
>   	return count;
>   }
>   
> @@ -57,10 +50,34 @@ static void hibmc_connector_destroy(struct drm_connector *connector)
>   	drm_connector_cleanup(connector);
>   }
>   
> +static int hibmc_vdac_detect(struct drm_connector *connector,
> +			     struct drm_modeset_acquire_ctx *ctx,
> +			     bool force)
> +{
> +	struct hibmc_drm_private *priv = to_hibmc_drm_private(connector->dev);
> +	int status = drm_connector_helper_detect_from_ddc(connector, ctx,
> +							 force);
> +	struct hibmc_vdac *vdac = to_hibmc_vdac(connector);
> +
> +	if (priv->dp.phys_status == connector_status_connected) {
> +		vdac->phys_status = status;
> +		return status;
> +	}
> +
> +	if (status != vdac->phys_status)
> +		++connector->epoch_counter;
> +	vdac->phys_status = status;
> +
> +	/* When both the DP and VDAC physical status are disconnected,
> +	 * the "connected" status is returned to support KVM display.
> +	 */
> +	return connector_status_connected;
> +}
> +
>   static const struct drm_connector_helper_funcs
>   	hibmc_connector_helper_funcs = {
>   	.get_modes = hibmc_connector_get_modes,
> -	.detect_ctx = drm_connector_helper_detect_from_ddc,
> +	.detect_ctx = hibmc_vdac_detect,
>   };
>   
>   static const struct drm_connector_funcs hibmc_connector_funcs = {
> @@ -130,6 +147,8 @@ int hibmc_vdac_init(struct hibmc_drm_private *priv)
>   
>   	connector->polled = DRM_CONNECTOR_POLL_CONNECT | DRM_CONNECTOR_POLL_DISCONNECT;
>   
> +	vdac->phys_status = connector_status_disconnected;
> +
>   	return 0;
>   
>   err:

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG Nürnberg)


