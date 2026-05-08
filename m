Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0ACCCD342F
	for <dri-devel@archiver.kernel.org>; Fri,  8 May 2026 07:29:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 592FA10F390;
	Fri,  8 May 2026 07:29:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="k6aY4Ax+";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="wYklNYxi";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="k6aY4Ax+";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="wYklNYxi";
	dkim-atps=neutral
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F2E0110F390
 for <dri-devel@lists.freedesktop.org>; Fri,  8 May 2026 07:29:32 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B59E65CF25;
 Fri,  8 May 2026 07:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1778225371; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=4YT1mBb7pU7f4JmGGWQNLY8pwjW5TwwIzjaQDyppQjw=;
 b=k6aY4Ax+lckfp6BGcNkw7mpWgJ2vXekeTLh+Bnv4Wjbx312SXoXLwnA0n58giV3a5VFNJ4
 HV1cu7k7jwAhbhbwzsu5bL8zcurN2/NnPZBKZzxt9h8AC/hNg6ksi5Aw4GQTR/nVyDt+dy
 /mltU9qa0lV18YqyRoYQTjHPAcpPJ5A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1778225371;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=4YT1mBb7pU7f4JmGGWQNLY8pwjW5TwwIzjaQDyppQjw=;
 b=wYklNYxiIQm6f2UNP0/CEWrqwLXSFc1GZaZewZKxTP2XWF/L/U/hIqI/TYscA05zUu30hb
 7N+5J/XR+i4gc4CA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1778225371; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=4YT1mBb7pU7f4JmGGWQNLY8pwjW5TwwIzjaQDyppQjw=;
 b=k6aY4Ax+lckfp6BGcNkw7mpWgJ2vXekeTLh+Bnv4Wjbx312SXoXLwnA0n58giV3a5VFNJ4
 HV1cu7k7jwAhbhbwzsu5bL8zcurN2/NnPZBKZzxt9h8AC/hNg6ksi5Aw4GQTR/nVyDt+dy
 /mltU9qa0lV18YqyRoYQTjHPAcpPJ5A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1778225371;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=4YT1mBb7pU7f4JmGGWQNLY8pwjW5TwwIzjaQDyppQjw=;
 b=wYklNYxiIQm6f2UNP0/CEWrqwLXSFc1GZaZewZKxTP2XWF/L/U/hIqI/TYscA05zUu30hb
 7N+5J/XR+i4gc4CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 52538593A7;
 Fri,  8 May 2026 07:29:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 5DvMEtuQ/Wl2GwAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Fri, 08 May 2026 07:29:31 +0000
Message-ID: <edcbfa95-6602-45ae-baaf-26e7be628384@suse.de>
Date: Fri, 8 May 2026 09:29:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/10] drm/panel: Use refcounted allocation for
 remaining panel drivers
To: Albert Esteve <aesteve@redhat.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Michael Tretter <m.tretter@pengutronix.de>,
 Michael Walle <mwalle@kernel.org>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260508-drm_panel_init_rm-v2-0-0bd4ac429971@redhat.com>
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
In-Reply-To: <20260508-drm_panel_init_rm-v2-0-0bd4ac429971@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 MIME_TRACE(0.00)[0:+]; RCPT_COUNT_TWELVE(0.00)[12];
 FREEMAIL_TO(0.00)[redhat.com,linaro.org,gmail.com,linux.intel.com,kernel.org,ffwll.ch,pengutronix.de,amarulasolutions.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.de:email,
 suse.de:mid, suse.com:url]
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

For this series:

Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>

Am 08.05.26 um 09:04 schrieb Albert Esteve:
> This series converts 9 remaining panel drivers from the deprecated
> devm_kzalloc() + drm_panel_init() pattern to the refcounted
> devm_drm_panel_alloc() API. This follows the work by Anusha Srivatsa
> who introduced the refcounted panel allocation infrastructure [1] and
> converted a first batch of drivers [2] (the last part of a 5 sub-series).
>
> Reasoning:
> ----------
> The old allocation pattern is unsafe: when the panel device is
> unbound, devm frees the context struct immediately, but the DRM
> device may still hold a reference to the embedded drm_panel through
> the panel bridge, leading to a use-after-free. devm_drm_panel_alloc()
> wraps the allocation in a kref scheme, so the memory is only freed
> when the last reference is dropped.
>
> After this series, there are no remaining callers of drm_panel_init()
> under drivers/gpu/drm/panel/, and drm_panel_init() is entirely removed
> from the public API.
>
> [1] https://lore.kernel.org/all/20250331-b4-panel-refcounting-v4-0-dad50c60c6c9@redhat.com/
> [2] https://lore.kernel.org/all/20250710-b4-driver-convert-last-part-july-v1-0-de73ba81b2f5@redhat.com/
>
> Signed-off-by: Albert Esteve <aesteve@redhat.com>
> ---
> Changes in v2:
> - Remove drm_panel_init/alloc precedence mentions in kdocs
> - Link to v1: https://lore.kernel.org/r/20260507-drm_panel_init_rm-v1-0-51f448c7c291@redhat.com
>
> ---
> Albert Esteve (10):
>        drm/panel/visionox-g2647fb105: Use refcounted allocation in place of devm_kzalloc()
>        drm/panel/samsung-s6e63m0: Use refcounted allocation in place of devm_kzalloc()
>        drm/panel/novatek-nt37700f: Use refcounted allocation in place of devm_kzalloc()
>        drm/panel/lxd-m9189a: Use refcounted allocation in place of devm_kzalloc()
>        drm/panel/ilitek-ili9806e: Use refcounted allocation in place of devm_kzalloc()
>        drm/panel/tdo-tl070wsh30: Use refcounted allocation in place of devm_kzalloc()
>        drm/panel/sharp-ls043t1le01: Use refcounted allocation in place of devm_kzalloc()
>        drm/panel/truly-nt35597: Use refcounted allocation in place of devm_kzalloc()
>        drm/panel/startek-kd070fhfid015: Use refcounted allocation in place of devm_kzalloc()
>        drm/panel: Make drm_panel_init() static
>
>   drivers/gpu/drm/display/drm_dp_helper.c             |  2 --
>   drivers/gpu/drm/drm_panel.c                         |  7 +++----
>   drivers/gpu/drm/panel/panel-ilitek-ili9806e-core.c  | 10 +++++-----
>   drivers/gpu/drm/panel/panel-lxd-m9189a.c            | 11 ++++++-----
>   drivers/gpu/drm/panel/panel-novatek-nt37700f.c      | 11 ++++++-----
>   drivers/gpu/drm/panel/panel-samsung-s6e63m0.c       | 14 +++++++-------
>   drivers/gpu/drm/panel/panel-sharp-ls043t1le01.c     | 11 ++++++-----
>   drivers/gpu/drm/panel/panel-startek-kd070fhfid015.c | 12 ++++++------
>   drivers/gpu/drm/panel/panel-tdo-tl070wsh30.c        | 14 +++++++-------
>   drivers/gpu/drm/panel/panel-truly-nt35597.c         | 10 +++++-----
>   drivers/gpu/drm/panel/panel-visionox-g2647fb105.c   | 13 ++++++-------
>   include/drm/drm_panel.h                             |  4 ----
>   12 files changed, 57 insertions(+), 62 deletions(-)
> ---
> base-commit: 74fe02ce122a6103f207d29fafc8b3a53de6abaf
> change-id: 20260506-drm_panel_init_rm-3a4489701f10
>
> Best regards,

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG Nürnberg)


