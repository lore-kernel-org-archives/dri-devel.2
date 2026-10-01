Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95DBECA5FC5
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 07:25:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B52A10F5AA;
	Thu,  1 Oct 2026 07:25:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="Oat2kc7c";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="GaPFY4M2";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="cc9t1wUF";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="grT5uCwJ";
	dkim-atps=neutral
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ACA7310F5AA
 for <dri-devel@lists.freedesktop.org>; Thu,  1 Oct 2026 07:25:40 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E8C8E21F1D;
 Thu,  1 Oct 2026 07:25:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1790839535; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=8lmDrlQXdwRiUij1zDhcqVr9MCM/4m0dtendWI2HC6s=;
 b=Oat2kc7cQOdQgPKJWR8/hEwQ8eZORgassMxE0pakHy6MJk64YCZxVebDrNsmxGDVEF43VA
 7sQ7N6VzeUF1lR1jIttA00AR/vJV4T4xdt51l7pG8d7ssbgWkI14qibeYG9RMAxgM1LVWR
 oToyAp7La7LY6MG9Qu/i6D9UBoFWv9E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1790839535;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=8lmDrlQXdwRiUij1zDhcqVr9MCM/4m0dtendWI2HC6s=;
 b=GaPFY4M2iC7TyRoTRWDSMEuCj/mcVEr3sJKlCW8bnZU1Bia8LJ2gmfMeyeTDydCqDtWkyJ
 bHuZCbdBoG87oZDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1790839530; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=8lmDrlQXdwRiUij1zDhcqVr9MCM/4m0dtendWI2HC6s=;
 b=cc9t1wUF/J0WkIpSwpkG6LTodJj7/VlDJCUD8d5MR1Kjix+at7UIfGLZZJrhJbnqMy4/Wg
 LQ5JOuxryEL0qFHYSziVXCX+HGlc8CZJby/GCpbwwdOdTP/UnITxkuf/PYU5WEBEQchCDw
 FqHsEAGIQKcTU1txsEm7GNombr5CQEc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1790839530;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=8lmDrlQXdwRiUij1zDhcqVr9MCM/4m0dtendWI2HC6s=;
 b=grT5uCwJepG6I7dLtNqZdpjKN+XNFmt3LLgo3E7/v4mTgnWHUFJTbpnnILD9m7MGa1udDe
 MKVU9agYzHvG8MBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 60DCE13699;
 Thu,  1 Oct 2026 07:25:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id BThUCuoKvmpSIAAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Thu, 01 Oct 2026 07:25:30 +0000
Message-ID: <76d760b8-f4b2-4198-b6b6-1051e51fbebd@suse.de>
Date: Thu, 1 Oct 2026 09:25:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/2] drm/imx: replace simple display pipe with atomic
 helpers
To: Ze Huang <ze.huang@oss.qualcomm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Frank Li <Frank.Li@nxp.com>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Philipp Zabel <p.zabel@pengutronix.de>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 Marian Cichy <m.cichy@pengutronix.de>
Cc: dri-devel@lists.freedesktop.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260919-b4-imx-simple-kms-v4-v4-0-53b1fdf4589e@oss.qualcomm.com>
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
In-Reply-To: <20260919-b4-imx-simple-kms-v4-v4-0-53b1fdf4589e@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+];
 FREEMAIL_TO(0.00)[oss.qualcomm.com,linux.intel.com,kernel.org,gmail.com,ffwll.ch,nxp.com,pengutronix.de];
 RCPT_COUNT_TWELVE(0.00)[16]; MID_RHS_MATCH_FROM(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid, suse.de:email, intel.com:email,
 msgid.link:url, infradead.org:email, linux.dev:email, qualcomm.com:email,
 imap1.dmz-prg2.suse.org:helo, nxp.com:email, ffwll.ch:email,
 pengutronix.de:email, lists.freedesktop.org:email]
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

Merged into drm-misc-next

Am 19.09.26 um 16:59 schrieb Ze Huang:
> struct drm_simple_display_pipe was meant to simplify simple DRM
> drivers, but instead adds an extra wrapper around normal DRM atomic
> helper setup. As noted in Documentation/gpu/todo.rst, remaining users
> should be converted to regular atomic helpers and stop depending on the
> simple-KMS interfaces.
>
> The series replaces drm_simple_display_pipe_init() with explicit
> primary plane, CRTC and encoder setup, and moves the old simple-pipe
> callbacks into regular plane and CRTC helper callbacks named according
> to local driver conventions.
>
> The conversion preserves helper behavior that used to be implicit in
> drm_simple_kms_helper.c, including plane-state validation, CRTC
> primary-plane checks, affected-plane propagation, framebuffer prepare
> handling, and existing event/vblank flow where applicable.
>
> Result is less helper indirection and more explicit driver-side atomic
> wiring, with no remaining simple-KMS dependency in this driver.
>
> Changes are build-tested only. No hardware testing has been performed.
>
> The patches are based on v7.3-rc2.
>
> AI usage disclosure:
> - AI tools were also used to review the code and suggest code changes for
>    the DRM atomic conversion.
>
> Thanks,
> Ze Huang
>
> Signed-off-by: Ze Huang <ze.huang@oss.qualcomm.com>
> ---
> Changes in v4:
> - Use drm_crtc_vblank_atomic_flush() instead of the driver's own flush
>    callback.
> - Replace the reset callbacks with the atomic_create_state helpers and use
>    drm_mode_config_create_initial_state() in probe.
> - Link to v3: https://lore.kernel.org/all/20260727-drm-simple-kms-removal-v3-0-de36e534f7a1@oss.qualcomm.com/
>
> Changes in v3:
> - Add a new preparatory patch to avoid duplicate clk_per enables in
>    imx-lcdc pipe update after CRTC enable.
> - Use commit-local atomic state in enable/update/check paths.
> - Link to v2: https://patch.msgid.link/20260716-drm-simple-kms-removal-v2-1-7e4a6b8528e6@oss.qualcomm.com/
>
> Changes in v2:
> - use 'commit' as name of struct drm_atomic_commit in atomic helpers
> - improve control flow in *_crtc_helper_atomic_check() and
>    *_plane_helper_atomic_check()
> - Moved page-flip/vblank event handling out of plane update paths and into
>    CRTC atomic_flush(), using atomic_flush and disable paths
> - decide clock disable by old crtc state
> - add calls to drm_crtc_vblank_on() and drm_crtc_vblank_off() in crtc
>    atomic_enable() and atomic_disbale()
> - test crtc_state->enable before mode size check
> - Link to v1: https://patch.msgid.link/20260705-drm-simple-kms-removal-v1-0-b4e1ca053623@oss.qualcomm.com
>
> To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> To: Maxime Ripard <mripard@kernel.org>
> To: Thomas Zimmermann <tzimmermann@suse.de>
> To: David Airlie <airlied@gmail.com>
> To: Simona Vetter <simona@ffwll.ch>
> To: Frank Li <Frank.Li@nxp.com>
> To: Sascha Hauer <s.hauer@pengutronix.de>
> To: Pengutronix Kernel Team <kernel@pengutronix.de>
> To: Fabio Estevam <festevam@gmail.com>
> To: Philipp Zabel <p.zabel@pengutronix.de>
> To: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> To: Marian Cichy <m.cichy@pengutronix.de>
> Cc: dri-devel@lists.freedesktop.org
> Cc: imx@lists.linux.dev
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
>
> ---
> Ze Huang (2):
>        drm/imx/lcdc: avoid duplicate clk_per enable
>        drm/imx: replace struct drm_simple_display_pipe with regular atomic helpers
>
>   drivers/gpu/drm/imx/lcdc/imx-lcdc.c | 249 +++++++++++++++++++++++++-----------
>   1 file changed, 175 insertions(+), 74 deletions(-)
> ---
> base-commit: 5e036ce12de91c6fd674dad33b169c6150be2a7a
> change-id: 20260919-b4-imx-simple-kms-v4-3f7d32e17548
>
> Best regards,
> --
> Ze Huang <ze.huang@oss.qualcomm.com>
>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Stefan Gaiser, Jochen Jaser, Abhinav Puri, (HRB 36809, AG Nürnberg)


