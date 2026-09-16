Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A29DC88E77
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 06:54:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 86A0010E0BE;
	Wed, 16 Sep 2026 06:54:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="a6r5Er3W";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="z6/TLLVP";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="1YgfAJj6";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="LmHKXLkd";
	dkim-atps=neutral
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8044D10E0BE
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 06:54:55 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id CF48B21C09;
 Wed, 16 Sep 2026 06:54:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789541690; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=JfohTtnICl9IDbDoAqJgiLIZ7G/Xa+aT9gfz3dvk5N0=;
 b=a6r5Er3WKIpOmYUEZZ414Kh7KJjqtNGm3sIeXKyqFi1NdFHyBjubgJWBJxgTKaIMWv/Xe5
 mJ+MMJryzgQCz3ZM8IP8c3KX/ftwzXfnRkFucWPsPKteu1lWt20CHJpGQCmJvNdFvH/pSI
 Y5zsJtpjM4ZfN02+MxAwqzEcNbyRSsU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789541690;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=JfohTtnICl9IDbDoAqJgiLIZ7G/Xa+aT9gfz3dvk5N0=;
 b=z6/TLLVPQ2+11+g7uWXGQfBpHFQsy4e1VwevUbOsqWv1VIbws6fveLbufBCBvw/YRopk3z
 Oqc6nvOjCcFWbxAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789541685; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=JfohTtnICl9IDbDoAqJgiLIZ7G/Xa+aT9gfz3dvk5N0=;
 b=1YgfAJj68t/BEzUnkp2qNoGSPPWYMLjPtXO/SMoexxM//FD4Sj+TkwvJHnY9+Q0uFjY60X
 W8PpnZ64txypkQVUIlxuMZErupTpm1WZdCQMc274FFfwTh7zsYVts2QESU8ijgcDolA7VE
 IzoRaqX0+g98UOqg8nsKRkHURJWDVj8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789541685;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=JfohTtnICl9IDbDoAqJgiLIZ7G/Xa+aT9gfz3dvk5N0=;
 b=LmHKXLkdmwY+6qeIIdhFDv99oiiZiH63/Qma3JkJVtECdZkP+V8cpOrsmKi7Pg4s2TZCjH
 llvHOHIf4TyQTHBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 794F3136D1;
 Wed, 16 Sep 2026 06:54:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 2DK4DDU9qmrcZwAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Wed, 16 Sep 2026 06:54:45 +0000
Message-ID: <b1cb8dfd-4ec8-4024-bcbf-d22b2f4cc55b@suse.de>
Date: Wed, 16 Sep 2026 08:54:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 00/11] drm/crtc: Convert all drivers to
 atomic_create_state and remove reset
To: Maxime Ripard <mripard@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org,
 Javier Martinez Canillas <javierm@redhat.com>,
 Hans de Goede <hansg@kernel.org>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
References: <20260915-drm-no-more-crtc-reset-v5-0-bda007735748@kernel.org>
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
In-Reply-To: <20260915-drm-no-more-crtc-reset-v5-0-bda007735748@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FREEMAIL_TO(0.00)[kernel.org,linux.intel.com,gmail.com,ffwll.ch];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 RCPT_COUNT_SEVEN(0.00)[8]; MID_RHS_MATCH_FROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:url, suse.de:email, suse.de:mid,
 imap1.dmz-prg2.suse.org:helo]
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

Am 15.09.26 um 16:24 schrieb Maxime Ripard:
> This is a follow-up to the plane reset removal series, and part of a
> larger effort to remove the reset hook from all KMS objects.
>
> The CRTC reset hook is overloaded: it is called both at probe time to
> create the initial software state and during suspend/resume to reset
> hardware and software state. These two roles have different
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
> This series converts all CRTC drivers tree-wide from the reset hook to
> atomic_create_state, then removes the reset hook from struct
> drm_crtc_funcs entirely. Two drivers (tilcdc and loongson) had actual
> hardware reset logic mixed into their reset hook; those are moved to
> CRTC creation instead. The conversions were done using a combination of
> Coccinelle semantic patches and manual adjustments.
>
> Signed-off-by: Maxime Ripard <mripard@kernel.org>

It might be my mail client but the formatting in patch 5 looks off. 
Besides that, for the series:

Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>

Best regards
Thomas

> ---
> Changes in v5:
> - Convert more drivers recently posted
> - Link to v4: https://lore.kernel.org/r/20260911-drm-no-more-crtc-reset-v4-0-662e0ccd815c@kernel.org
>
> Changes in v4:
> - Convert gm12u320 too
> - Link to v3: https://lore.kernel.org/r/20260904-drm-no-more-crtc-reset-v3-0-27d9891512ce@kernel.org
>
> Changes in v3:
> - Test if crtc->helper_private is set before accessing it, and call the
>    temp variable to store it helper_funcs
> - Rework outdated commit logs
> - Fix error path for amdgpu_dm_crtc_init
> - Fix new amdgpu tests doc
> - Rebased on drm-misc-next-2026-09-03
> - Link to v2: https://lore.kernel.org/r/20260831-drm-no-more-crtc-reset-v2-0-4500d49a337f@kernel.org
>
> Changes in v2:
> - Fix indentation in logicvc
> - Fix hardware reset at probe and suspend for loonsoon and tilcldc
> - Fix state creation for amdgpu
> - Rebase on current drm-misc-next
> - Fix commit message for st7920
> - Fix merge conflict for mediatek
> - Link to v1: https://lore.kernel.org/r/20260821-drm-no-more-crtc-reset-v1-0-fb793475c05a@kernel.org
>
> ---
> Maxime Ripard (11):
>        drm/arcgpu: Switch to drm_atomic_helper_crtc_create_state
>        drm/aspeed: Switch to drm_atomic_helper_crtc_create_state
>        drm/gm12u320: Switch to drm_atomic_helper_crtc_create_state
>        drm/mcde: Switch to drm_atomic_helper_crtc_create_state
>        drm/pl111: Switch to drm_atomic_helper_crtc_create_state
>        drm/repaper: Switch to drm_atomic_helper_crtc_create_state
>        drm/tve200: Switch to drm_atomic_helper_crtc_create_state
>        drm/xen: Switch to drm_atomic_helper_crtc_create_state
>        drm/atomic-helper: Remove drm_atomic_helper_crtc_reset
>        drm/atomic-helper: Remove __drm_atomic_helper_crtc_reset
>        drm/crtc: Remove reset
>
>   drivers/gpu/drm/aspeed/aspeed_gfx_crtc.c  |  2 +-
>   drivers/gpu/drm/drm_atomic_state_helper.c | 45 -------------------------------
>   drivers/gpu/drm/drm_mode_config.c         |  4 +--
>   drivers/gpu/drm/mcde/mcde_display.c       |  2 +-
>   drivers/gpu/drm/pl111/pl111_display.c     |  2 +-
>   drivers/gpu/drm/tiny/arcpgu.c             |  2 +-
>   drivers/gpu/drm/tiny/gm12u320.c           |  2 +-
>   drivers/gpu/drm/tiny/repaper.c            |  2 +-
>   drivers/gpu/drm/tve200/tve200_display.c   |  2 +-
>   drivers/gpu/drm/xen/xen_drm_front_kms.c   |  2 +-
>   include/drm/drm_atomic_state_helper.h     |  3 ---
>   include/drm/drm_crtc.h                    | 12 ---------
>   12 files changed, 9 insertions(+), 71 deletions(-)
> ---
> base-commit: 17c6b88e85ffe5de5720004ae8c2176d52944aca
> change-id: 20260709-drm-no-more-crtc-reset-14a4d5bc8d41
>
> Best regards,

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, (HRB 36809, AG Nürnberg)


