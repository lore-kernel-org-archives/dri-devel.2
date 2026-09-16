Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44FE1C982C1
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 09:13:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 604F310E041;
	Wed, 16 Sep 2026 09:13:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="lvnoh49i";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="yMkCbc16";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="YqbbT6+r";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="7/obx3uu";
	dkim-atps=neutral
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8721910E041
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 09:13:39 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id DF3F421BE9;
 Wed, 16 Sep 2026 09:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789550014; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=54NGbJBboaY168mC65ZCajEU3DidFevPTT4pCXshZds=;
 b=lvnoh49imbwXgnnZpbBxD0mK0M4d7zjzgGRhE0moQTYipNCzxo4LSijVGRBTlL9KvyuGDx
 GaQnkLD8qZXkN1kFly00lyPQ3Bb38YjFvn1NkxKFGJOGGXJ8NoWY0h+A1ghz3LqdLVPqSS
 WN8f3sv6ROeHfVA/MNCnN7hUFc/JqWw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789550014;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=54NGbJBboaY168mC65ZCajEU3DidFevPTT4pCXshZds=;
 b=yMkCbc16cCVpYTdVZ9jsJobAe93LWq1DbRmRPmxsBUURm4a/aR9fAXOCHu/gx4C/0VGn66
 4rv0xK3s4LPNFvAg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=YqbbT6+r;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="7/obx3uu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789550009; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=54NGbJBboaY168mC65ZCajEU3DidFevPTT4pCXshZds=;
 b=YqbbT6+rXvvLXisTj5ECpidWHJ5WmSbg+I0klTQSe9/cKOYOIPBc+L/fLmYjeHLBUZwgw/
 sIWow1SXhaX66zG0qgf71vf0vF1+HhShzmFukMFOWWVX3dg9D3WSwRHhBU5gSxu3p4hbMh
 vB9rKngmOQK3AbYQO/Ndv3pBpZJXsDs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789550009;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=54NGbJBboaY168mC65ZCajEU3DidFevPTT4pCXshZds=;
 b=7/obx3uuYwpFNOn6Q6S2bUhxLfTcLh0dF0f4KcQZSl06JnXRQhBTGa3M7RJM4QKi4ObaFu
 FagwhfGhx2UMAMCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 99AAF1348F;
 Wed, 16 Sep 2026 09:13:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id x1PODrldqmreBQAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Wed, 16 Sep 2026 09:13:29 +0000
Message-ID: <800d6fd2-db1c-468e-8403-4162fe404dcd@suse.de>
Date: Wed, 16 Sep 2026 11:13:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/9] drm/plane: Convert all drivers to
 atomic_create_state and remove reset
To: Maxime Ripard <mripard@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
References: <20260916-drm-no-more-plane-reset-v5-0-f590d2003f2c@kernel.org>
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
In-Reply-To: <20260916-drm-no-more-plane-reset-v5-0-f590d2003f2c@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: DF3F421BE9
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+];
 FREEMAIL_TO(0.00)[kernel.org,linux.intel.com,gmail.com,ffwll.ch];
 MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5]; RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:url,suse.de:dkim,suse.de:email,suse.de:mid];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]
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



Am 16.09.26 um 10:55 schrieb Maxime Ripard:
> This is a follow-up to the bridge reset removal series, and part of a
> larger effort to remove the reset hook from all KMS objects.
>
> The plane reset hook is overloaded: it is called both at probe time
> to create the initial software state and during suspend/resume to
> reset hardware and software state. These two roles have different
> requirements, and the reset hook is not fallible, making error
> handling difficult for the initial state allocation path.
>
> While reset has the semantics to reset both the software and hardware
> state, the vast majority of implementations and all the helpers only
> reset the software state, making them equivalent to
> atomic_create_state in practice. The atomic_create_state hook makes
> this explicit: it only allocates and initializes a pristine state
> without any side effect, and returns the state pointer or an ERR_PTR
> on failure.
>
> This series first adds the necessary infrastructure in the simple-kms
> and GEM atomic helpers, then converts all 51 plane drivers tree-wide
> from the reset hook to atomic_create_state. The conversions were done
> using a combination of Coccinelle semantic patches and manual
> adjustments. Once all drivers are converted, the old helpers and the
> reset hook itself are removed from struct drm_plane_funcs.
>
> Signed-off-by: Maxime Ripard <mripard@kernel.org>

For this series:

Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>

> ---
> Changes in v5:
> - Convert former simple-display drivers that were recently merged
> - Link to v4: https://lore.kernel.org/r/20260908-drm-no-more-plane-reset-v4-0-a31b3fcfc989@kernel.org
>
> Changes in v4:
> - Fix a NULL pointer dereference with vkms
> - Rebase on drm-misc-next-2026-09-03
> - Link to v3: https://lore.kernel.org/r/20260831-drm-no-more-plane-reset-v3-0-1877c7aa57b3@kernel.org
>
> Changes in v3:
> - Drop leftover state destruction in sun4i
> - Rebase on current drm-misc-next
> - Link to v2: https://lore.kernel.org/r/20260814-drm-no-more-plane-reset-v2-0-82d2963dd134@kernel.org
>
> Changes in v2:
> - Rebase on latest drm-misc-next tag
> - Fix sashiko reviews
> - Fix atmel-hlcdc breakage
> - Link to v1: https://lore.kernel.org/r/20260709-drm-no-more-plane-reset-v1-0-302d986fe5f0@kernel.org
>
> ---
> Maxime Ripard (9):
>        drm/arcgpu: Switch to drm_atomic_helper_plane_create_state
>        drm/aspeed: Switch to drm_atomic_helper_plane_create_state
>        drm/mcde: Switch to drm_atomic_helper_plane_create_state
>        drm/pl111: Switch to drm_atomic_helper_plane_create_state
>        drm/tve200: Switch to drm_atomic_helper_plane_create_state
>        drm/xen: Switch to drm_atomic_helper_plane_create_state
>        drm/atomic-state-helper: Remove drm_atomic_helper_plane_reset()
>        drm/atomic-state-helper: Remove __drm_atomic_helper_plane_reset()
>        drm/plane: Remove reset
>
>   drivers/gpu/drm/aspeed/aspeed_gfx_crtc.c  |  2 +-
>   drivers/gpu/drm/drm_atomic_state_helper.c | 41 -------------------------------
>   drivers/gpu/drm/drm_mode_config.c         |  4 +--
>   drivers/gpu/drm/mcde/mcde_display.c       |  2 +-
>   drivers/gpu/drm/pl111/pl111_display.c     |  2 +-
>   drivers/gpu/drm/tiny/arcpgu.c             |  2 +-
>   drivers/gpu/drm/tve200/tve200_display.c   |  2 +-
>   drivers/gpu/drm/xen/xen_drm_front_kms.c   |  2 +-
>   include/drm/drm_atomic_state_helper.h     |  3 ---
>   include/drm/drm_plane.h                   | 12 ---------
>   10 files changed, 7 insertions(+), 65 deletions(-)
> ---
> base-commit: 17c6b88e85ffe5de5720004ae8c2176d52944aca
> change-id: 20260629-drm-no-more-plane-reset-04950f42e07f
>
> Best regards,

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, (HRB 36809, AG Nürnberg)


