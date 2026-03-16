Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DE67F4645F
	for <dri-devel@archiver.kernel.org>; Mon, 16 Mar 2026 12:17:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7662E10E507;
	Mon, 16 Mar 2026 12:17:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="mEGFbxye";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="jiCSqO3K";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="mEGFbxye";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="jiCSqO3K";
	dkim-atps=neutral
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C2BE610E507
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 12:17:46 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 76BFF5BD1A;
 Mon, 16 Mar 2026 12:17:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1773663465; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ejUjcwIGFdLCqMKZAxV+B0YfEULhqWOq3Y49S9/SDV0=;
 b=mEGFbxyetc1TE4RnNVH0AvLAbrG/eCfWhnFVC0Dc1XrE6FqQZiY/9vtN5R/XfbTj2d0y+L
 NwPKi9sHvGpRHFQaBfCoIrhg+/MprCWppVzMGUafyYPxI0hVXvhyhTL1mVNPd8/MsgpKow
 Kfj/1yKIVu2NRVr3/PcGbUfkwVaIiPM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1773663465;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ejUjcwIGFdLCqMKZAxV+B0YfEULhqWOq3Y49S9/SDV0=;
 b=jiCSqO3KjvugUBpaEPrdH+Yr4UZW1nVdLWbIlQ5uX9aVnZtxRtpSmmhtEJ3fdqHd8mL/CT
 MrCA6+DLm0SfFJBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1773663465; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ejUjcwIGFdLCqMKZAxV+B0YfEULhqWOq3Y49S9/SDV0=;
 b=mEGFbxyetc1TE4RnNVH0AvLAbrG/eCfWhnFVC0Dc1XrE6FqQZiY/9vtN5R/XfbTj2d0y+L
 NwPKi9sHvGpRHFQaBfCoIrhg+/MprCWppVzMGUafyYPxI0hVXvhyhTL1mVNPd8/MsgpKow
 Kfj/1yKIVu2NRVr3/PcGbUfkwVaIiPM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1773663465;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ejUjcwIGFdLCqMKZAxV+B0YfEULhqWOq3Y49S9/SDV0=;
 b=jiCSqO3KjvugUBpaEPrdH+Yr4UZW1nVdLWbIlQ5uX9aVnZtxRtpSmmhtEJ3fdqHd8mL/CT
 MrCA6+DLm0SfFJBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2FBCD4273B;
 Mon, 16 Mar 2026 12:17:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id HV44Cun0t2nwUgAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Mon, 16 Mar 2026 12:17:45 +0000
Message-ID: <1729c256-5854-4ffd-ab90-730047a47067@suse.de>
Date: Mon, 16 Mar 2026 13:17:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] [linux-next mismerge] drm/fbdev-emulation: restore
 drm_fb_helper_gem_is_fb() dummy
To: Arnd Bergmann <arnd@kernel.org>, Mark Brown <broonie@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260313095657.4115599-1-arnd@kernel.org>
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
In-Reply-To: <20260313095657.4115599-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_SEVEN(0.00)[11];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 MID_RHS_MATCH_FROM(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[arndb.de,linux.intel.com,kernel.org,gmail.com,ffwll.ch,amd.com,lists.freedesktop.org,vger.kernel.org];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:url,imap1.dmz-prg2.suse.org:helo]
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



Am 13.03.26 um 10:56 schrieb Arnd Bergmann:
> From: Arnd Bergmann <arnd@arndb.de>
>
> linux-next contains an incorrect merge of the drm tree and the amdgpu tree,
> which have conflicting patches from Thomas Zimmermann:
>
> drivers/gpu/drm/amd/amdgpu/amdgpu_display.c: In function 'amdgpu_display_suspend_helper':
> drivers/gpu/drm/amd/amdgpu/amdgpu_display.c:1777:22: error: implicit declaration of function 'drm_fb_helper_gem_is_fb'; did you mean 'drm_fb_helper_from_client'? [-Wimplicit-function-declaration]
>   1777 |                 if (!drm_fb_helper_gem_is_fb(dev->fb_helper, fb->obj[0])) {
>
> drivers/gpu/drm/radeon/radeon_device.c: In function 'radeon_suspend_kms':
> drivers/gpu/drm/radeon/radeon_device.c:1592:22: error: implicit declaration of function 'drm_fb_helper_gem_is_fb'; did you mean 'drm_fb_helper_from_client'? [-Wimplicit-function-declaration]
>   1592 |                 if (!drm_fb_helper_gem_is_fb(dev->fb_helper, fb->obj[0])) {
>        |                      ^~~~~~~~~~~~~~~~~~~~~~~
>        |                      drm_fb_helper_from_client
>
> The newly added drm_fb_helper_from_client() stub is in fact needed, while all
> the other stubs are correctly removed.
>
> Fixes: 6d438685340d ("drm/fbdev-emulation: Remove empty placeholders")
> Fixes: 1837c76b780a ("drm/amdgpu: Move test for fbdev GEM object into generic helper")
> Fixes: 9c63d743d5cc ("Merge branch 'drm-next' of https://gitlab.freedesktop.org/agd5f/linux.git")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>

> ---
>   include/drm/drm_fb_helper.h | 8 ++++++++
>   1 file changed, 8 insertions(+)
>
> diff --git a/include/drm/drm_fb_helper.h b/include/drm/drm_fb_helper.h
> index bf391903443d..80c81fdb04a2 100644
> --- a/include/drm/drm_fb_helper.h
> +++ b/include/drm/drm_fb_helper.h
> @@ -273,6 +273,14 @@ int drm_fb_helper_hotplug_event(struct drm_fb_helper *fb_helper);
>   int drm_fb_helper_initial_config(struct drm_fb_helper *fb_helper);
>   bool drm_fb_helper_gem_is_fb(const struct drm_fb_helper *fb_helper,
>   			     const struct drm_gem_object *obj);
> +#else
> +static inline bool
> +drm_fb_helper_gem_is_fb(const struct drm_fb_helper *fb_helper,
> +			const struct drm_gem_object *obj)
> +{
> +	return false;
> +}
> +
>   #endif
>   
>   #endif

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG Nürnberg)


