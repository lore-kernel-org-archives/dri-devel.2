Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEEDAFF8862
	for <dri-devel@archiver.kernel.org>; Mon, 27 Apr 2026 07:35:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C42D10E5D2;
	Mon, 27 Apr 2026 07:35:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="SFvoZ1W7";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="VekmulcX";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="YBtcAewo";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="yPO43GBx";
	dkim-atps=neutral
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E0D710E5D2
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 07:35:17 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 180B65BD0A;
 Mon, 27 Apr 2026 07:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1777275316; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=NyvDZBPkQp0BIMpb6oUgxSkc+PU00QABqISUicKCUJU=;
 b=SFvoZ1W73ogHN0mZ5W0pVAIemapL6LofMsyEHW3m3ToJjCKC1ADKtQvrQsDTE9OWjiLv5Z
 GklK9hRVodf81CT4UTI0opjWygKW/w/gH7Gc4x3mkGSkIVEe2fWpZTNHzakZmKsmvn/hai
 jJvpNpMTos5zpPnGWxknEG7Avc4WT1g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1777275316;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=NyvDZBPkQp0BIMpb6oUgxSkc+PU00QABqISUicKCUJU=;
 b=VekmulcXIylyFkD437kC7SJi+nMvExH58RsFpjbP8qM+pK9JxHcmu8xBmYW40G8RTBuxUh
 xbUJyUceyCdQ3NBQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=YBtcAewo;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=yPO43GBx
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1777275315; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=NyvDZBPkQp0BIMpb6oUgxSkc+PU00QABqISUicKCUJU=;
 b=YBtcAewogDTh66F1OCA2DS7K5y00/HD2TRkNEYKrsgPEvWU+W0ycKDAYlJ1sQPFKT306n+
 bkIWmeeqWwfDYzxF2I4TdaycxPzSrfs56vfdnMGku6wsxSyERBPpuZhpDBrmbg8GzwSekA
 pYo767w1/ozNfyB7JMqciLZxZawE0PE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1777275315;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=NyvDZBPkQp0BIMpb6oUgxSkc+PU00QABqISUicKCUJU=;
 b=yPO43GBxSKEbhmGw9BCNyGXZCoCaGH4l53HCGwepIlfGD6avIt5yQdT6AcgfNcS3k8k4ub
 okoyWeSpA/oYt4Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 90C66593B0;
 Mon, 27 Apr 2026 07:35:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id zYnxIbIR72kLXwAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Mon, 27 Apr 2026 07:35:14 +0000
Message-ID: <c5d2b5cd-df8b-4bbd-a0cc-4d7e3ad61da3@suse.de>
Date: Mon, 27 Apr 2026 09:35:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for drm-misc-fixes v5 4/4] drm/hisilicon/hibmc: use clock
 to look up the PLL value
To: Yongbang Shi <shiyongbang@huawei.com>, dmitry.baryshkov@oss.qualcomm.com, 
 tiantao6@hisilicon.com, xinliang.liu@linaro.org,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, airlied@gmail.com,
 daniel@ffwll.ch, kong.kongxinwei@hisilicon.com
Cc: liangjian010@huawei.com, chenjianmin@huawei.com, fengsheng5@huawei.com,
 helin52@h-partners.com, shenjian15@huawei.com, shaojijie@huawei.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260423063233.1267631-1-shiyongbang@huawei.com>
 <20260423063233.1267631-5-shiyongbang@huawei.com>
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
In-Reply-To: <20260423063233.1267631-5-shiyongbang@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 URIBL_BLOCKED(0.00)[huawei.com:email,suse.de:dkim,suse.de:mid,hisilicon.com:email,suse.com:url,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCPT_COUNT_TWELVE(0.00)[17];
 FREEMAIL_TO(0.00)[huawei.com,oss.qualcomm.com,hisilicon.com,linaro.org,linux.intel.com,kernel.org,gmail.com,ffwll.ch];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 MID_RHS_MATCH_FROM(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:url, hisilicon.com:email,
 imap1.dmz-prg2.suse.org:helo, imap1.dmz-prg2.suse.org:rdns, suse.de:dkim,
 suse.de:mid, huawei.com:email]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 180B65BD0A
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

Hi

Am 23.04.26 um 08:32 schrieb Yongbang Shi:
> From: Lin He <helin52@huawei.com>
>
> In the past, we use width and height to look up our PLL value.
> But actually the actual clock check is also necessnary. There are
> some resolutions that width and height same, but its clock different.
> Add the clock check when using pll_table to determine the PLL value.
>
> Fixes: da52605eea8f ("drm/hisilicon/hibmc: Add support for display engine")
> Signed-off-by: Lin He <helin52@huawei.com>
> Signed-off-by: Yongbang Shi <shiyongbang@huawei.com>
> ---
> ChangeLog:
> v2 -> v3:
>    - remove unused macro CLOCK_TOLERANCE.
> v1 -> v2:
>    - remove tag "Reviewed-by: Tao Tian <tiantao6@hisilicon.com>", witch will
>      be given in public.
>    - add 'drm-misc-fixes' in subject prefix.
> ---
>   .../gpu/drm/hisilicon/hibmc/hibmc_drm_de.c    | 78 +++++++++++--------
>   1 file changed, 44 insertions(+), 34 deletions(-)
>
> diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c
> index 89bed78f1466..1a07e8146eee 100644
> --- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c
> +++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c
> @@ -32,26 +32,43 @@ struct hibmc_display_panel_pll {
>   struct hibmc_dislay_pll_config {
>   	u64 hdisplay;
>   	u64 vdisplay;
> +	int clock;
>   	u32 pll1_config_value;
>   	u32 pll2_config_value;
>   };
>   
>   static const struct hibmc_dislay_pll_config hibmc_pll_table[] = {
> -	{640, 480, CRT_PLL1_HS_25MHZ, CRT_PLL2_HS_25MHZ},
> -	{800, 600, CRT_PLL1_HS_40MHZ, CRT_PLL2_HS_40MHZ},
> -	{1024, 768, CRT_PLL1_HS_65MHZ, CRT_PLL2_HS_65MHZ},
> -	{1152, 864, CRT_PLL1_HS_80MHZ_1152, CRT_PLL2_HS_80MHZ},
> -	{1280, 768, CRT_PLL1_HS_80MHZ, CRT_PLL2_HS_80MHZ},
> -	{1280, 720, CRT_PLL1_HS_74MHZ, CRT_PLL2_HS_74MHZ},
> -	{1280, 960, CRT_PLL1_HS_108MHZ, CRT_PLL2_HS_108MHZ},
> -	{1280, 1024, CRT_PLL1_HS_108MHZ, CRT_PLL2_HS_108MHZ},
> -	{1440, 900, CRT_PLL1_HS_106MHZ, CRT_PLL2_HS_106MHZ},
> -	{1600, 900, CRT_PLL1_HS_108MHZ, CRT_PLL2_HS_108MHZ},
> -	{1600, 1200, CRT_PLL1_HS_162MHZ, CRT_PLL2_HS_162MHZ},
> -	{1920, 1080, CRT_PLL1_HS_148MHZ, CRT_PLL2_HS_148MHZ},
> -	{1920, 1200, CRT_PLL1_HS_193MHZ, CRT_PLL2_HS_193MHZ},
> +	{640, 480, 25000, CRT_PLL1_HS_25MHZ, CRT_PLL2_HS_25MHZ},
> +	{800, 600, 40000, CRT_PLL1_HS_40MHZ, CRT_PLL2_HS_40MHZ},
> +	{1024, 768, 65000, CRT_PLL1_HS_65MHZ, CRT_PLL2_HS_65MHZ},
> +	{1152, 864, 78750, CRT_PLL1_HS_80MHZ_1152, CRT_PLL2_HS_80MHZ},
> +	{1280, 768, 80000, CRT_PLL1_HS_80MHZ, CRT_PLL2_HS_80MHZ},
> +	{1280, 720, 74375, CRT_PLL1_HS_74MHZ, CRT_PLL2_HS_74MHZ},
> +	{1280, 960, 108000, CRT_PLL1_HS_108MHZ, CRT_PLL2_HS_108MHZ},
> +	{1280, 1024, 108000, CRT_PLL1_HS_108MHZ, CRT_PLL2_HS_108MHZ},
> +	{1440, 900, 105952, CRT_PLL1_HS_106MHZ, CRT_PLL2_HS_106MHZ},
> +	{1600, 900, 108000, CRT_PLL1_HS_108MHZ, CRT_PLL2_HS_108MHZ},
> +	{1600, 1200, 162500, CRT_PLL1_HS_162MHZ, CRT_PLL2_HS_162MHZ},
> +	{1920, 1080, 148750, CRT_PLL1_HS_148MHZ, CRT_PLL2_HS_148MHZ},
> +	{1920, 1200, 193750, CRT_PLL1_HS_193MHZ, CRT_PLL2_HS_193MHZ},
>   };
>   
> +static int hibmc_get_best_clock_idx(const struct drm_display_mode *mode)
> +{
> +	int i, diff;
> +
> +	for (i = 0; i < ARRAY_SIZE(hibmc_pll_table); i++) {
> +		if (hibmc_pll_table[i].hdisplay == mode->hdisplay &&
> +		    hibmc_pll_table[i].vdisplay == mode->vdisplay) {
> +			diff = abs(mode->clock - hibmc_pll_table[i].clock);
> +			if (diff < mode->clock / 100) /* tolerance 1/100 */
> +				return i;
> +		}
> +	}
> +
> +	return -EOPNOTSUPP;

This errno code is for sockets.

Rather return -MODE_CLOCK_RANGE here, which you can then return from 
.mode_valid as well.

Best regards
Thomas


> +}
> +
>   static int hibmc_plane_atomic_check(struct drm_plane *plane,
>   				    struct drm_atomic_state *state)
>   {
> @@ -214,17 +231,13 @@ static enum drm_mode_status
>   hibmc_crtc_mode_valid(struct drm_crtc *crtc,
>   		      const struct drm_display_mode *mode)
>   {
> -	size_t i = 0;
>   	int vrefresh = drm_mode_vrefresh(mode);
>   
>   	if (vrefresh < 59 || vrefresh > 61)
>   		return MODE_NOCLOCK;
>   
> -	for (i = 0; i < ARRAY_SIZE(hibmc_pll_table); i++) {
> -		if (hibmc_pll_table[i].hdisplay == mode->hdisplay &&
> -		    hibmc_pll_table[i].vdisplay == mode->vdisplay)
> -			return MODE_OK;
> -	}
> +	if (hibmc_get_best_clock_idx(mode) >= 0)
> +		return MODE_OK;
>   
>   	return MODE_BAD;
>   }
> @@ -281,23 +294,20 @@ static void set_vclock_hisilicon(struct drm_device *dev, u64 pll)
>   	writel(val, priv->mmio + CRT_PLL1_HS);
>   }
>   
> -static void get_pll_config(u64 x, u64 y, u32 *pll1, u32 *pll2)
> +static void get_pll_config(struct drm_display_mode *mode, u32 *pll1, u32 *pll2)
>   {
> -	size_t i;
> -	size_t count = ARRAY_SIZE(hibmc_pll_table);
> -
> -	for (i = 0; i < count; i++) {
> -		if (hibmc_pll_table[i].hdisplay == x &&
> -		    hibmc_pll_table[i].vdisplay == y) {
> -			*pll1 = hibmc_pll_table[i].pll1_config_value;
> -			*pll2 = hibmc_pll_table[i].pll2_config_value;
> -			return;
> -		}
> +	int idx;
> +
> +	idx = hibmc_get_best_clock_idx(mode);
> +	if (idx < 0) {
> +		/* if found none, we use default value */
> +		*pll1 = CRT_PLL1_HS_25MHZ;
> +		*pll2 = CRT_PLL2_HS_25MHZ;
> +		return;
>   	}
>   
> -	/* if found none, we use default value */
> -	*pll1 = CRT_PLL1_HS_25MHZ;
> -	*pll2 = CRT_PLL2_HS_25MHZ;
> +	*pll1 = hibmc_pll_table[idx].pll1_config_value;
> +	*pll2 = hibmc_pll_table[idx].pll2_config_value;
>   }
>   
>   /*
> @@ -319,7 +329,7 @@ static u32 display_ctrl_adjust(struct drm_device *dev,
>   	x = mode->hdisplay;
>   	y = mode->vdisplay;
>   
> -	get_pll_config(x, y, &pll1, &pll2);
> +	get_pll_config(mode, &pll1, &pll2);
>   	writel(pll2, priv->mmio + CRT_PLL2_HS);
>   	set_vclock_hisilicon(dev, pll1);
>   

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG Nürnberg)


