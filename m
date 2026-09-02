Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B954CC61DD6
	for <dri-devel@archiver.kernel.org>; Wed,  2 Sep 2026 07:12:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB2EA10F02D;
	Wed,  2 Sep 2026 07:12:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="sxEbE6aL";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="2FJqRFOM";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="HafhIEjf";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="La9YgtCa";
	dkim-atps=neutral
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C944810E463;
 Wed,  2 Sep 2026 07:12:00 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 02CFB21E41;
 Wed,  2 Sep 2026 07:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788333115; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=59OLglZdllYKmlv7gAPKZYW3ffj6PV5vGZK7KTBTC/w=;
 b=sxEbE6aLw1h1F+0zA7kdoK2d+tQejyfkOsM3xVbvRRabG+UJPSq9q+rB1OGI3MWizG00/Z
 AJG1jlvCzxhN+zmk0jWmAiyA4O7T1DEvDun3XJyGYoy2vEnx1eywInKoNkUw0ZiaoWxl77
 /twJd989yyvtJq8YihnIOqDxGWHUiXY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788333115;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=59OLglZdllYKmlv7gAPKZYW3ffj6PV5vGZK7KTBTC/w=;
 b=2FJqRFOMUlXUGzExmDjZKFF6m2KLzUsG08bsDot32jSHHq0KRpXKG6hlOSD2hIiNuPeCTp
 ibeHp3QruXMBC2AA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=HafhIEjf;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=La9YgtCa
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788333111; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=59OLglZdllYKmlv7gAPKZYW3ffj6PV5vGZK7KTBTC/w=;
 b=HafhIEjfR/0/2xNEvZ0T9NfR6k8/h1Gk4eCxGSasEPHVOoX3jg9Kg4D94qHZm2QB1WseLQ
 wg4uy/sHSgVDJGFQOvuwTBty5RX5Z+/s5KpO+XtqQAiEOKwWWb6/Qj/xrK5qCnBgGT4yac
 OhfqRtfFFVCLJByLgpHLPgjPFeJG+ro=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788333111;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=59OLglZdllYKmlv7gAPKZYW3ffj6PV5vGZK7KTBTC/w=;
 b=La9YgtCas/0V6IMSVPLa23/xT+vXryZg5+kh1pkhZz5WIqEVeSW48MfJh411T5WgfteI6b
 Q80x2PoOMPLBhlCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4063B13736;
 Wed,  2 Sep 2026 07:11:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id e4BcDjbMl2o9WAAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Wed, 02 Sep 2026 07:11:50 +0000
Message-ID: <effc093c-646d-451a-aa9a-4ee0334d75ae@suse.de>
Date: Wed, 2 Sep 2026 09:11:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/13] drm/crtc: Convert all drivers to
 atomic_create_state and remove reset
To: Maxime Ripard <mripard@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org,
 Paul Kocialkowski <paulk@sys-base.io>, Jyri Sarha <jyri.sarha@iki.fi>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>, Huacai Chen <chenhuacai@kernel.org>,
 Icenowy Zheng <zhengxingda@iscas.ac.cn>, Jianmin Lv <lvjianmin@loongson.cn>,
 Mingcong Bai <jeffbai@aosc.io>, Qianhai Wu <wuqianhai@loongson.cn>,
 Xi Ruoyao <xry111@xry111.site>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Philipp Zabel <p.zabel@pengutronix.de>, Iker Pedrosa
 <ikerpedrosam@gmail.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
References: <20260831-drm-no-more-crtc-reset-v2-0-4500d49a337f@kernel.org>
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
In-Reply-To: <20260831-drm-no-more-crtc-reset-v2-0-4500d49a337f@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 02CFB21E41
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TAGGED_RCPT(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; RCVD_TLS_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RCPT_COUNT_TWELVE(0.00)[26]; MIME_TRACE(0.00)[0:+];
 FREEMAIL_TO(0.00)[kernel.org,linux.intel.com,gmail.com,ffwll.ch];
 MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[lists.freedesktop.org,amd.com,sys-base.io,iki.fi,ideasonboard.com,igalia.com,kernel.org,iscas.ac.cn,loongson.cn,aosc.io,xry111.site,collabora.com,gmail.com,pengutronix.de,oss.qualcomm.com];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:url];
 RCVD_COUNT_TWO(0.00)[2]; DKIM_TRACE(0.00)[suse.de:+]
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

Hi Maxime,

I've gone over the remaining patches again and it all looks good now.

Best regards
Thomas

Am 31.08.26 um 17:34 schrieb Maxime Ripard:
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
> ---
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
> Maxime Ripard (13):
>        drm/crtc: Introduce hw_reset helper hook
>        drm/amdgpu: vkms: Switch to drm_atomic_helper_crtc_create_state
>        drm/logicvc: Switch to drm_atomic_helper_crtc_create_state
>        drm/tilcdc: Move hardware reset to CRTC creation
>        drm/tilcdc: Switch to drm_atomic_helper_crtc_create_state
>        drm/atomic-helper: Remove drm_atomic_helper_crtc_reset
>        drm/amdgpu: dm: Convert to atomic_create_state
>        drm/loongson: Move hardware reset to CRTC creation
>        drm/loongson: Convert to atomic_create_state
>        drm/mediatek: Convert to atomic_create_state
>        drm/sitronix: st7920: Convert to atomic_create_state
>        drm/atomic-helper: Remove __drm_atomic_helper_crtc_reset
>        drm/crtc: Remove reset
>
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c           |  2 +-
>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c | 28 +++++++++-----
>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.h |  2 +-
>   .../display/amdgpu_dm/tests/amdgpu_dm_crtc_test.c  | 20 +++++-----
>   drivers/gpu/drm/drm_atomic_state_helper.c          | 45 ----------------------
>   drivers/gpu/drm/drm_mode_config.c                  | 17 ++++++--
>   drivers/gpu/drm/logicvc/logicvc_crtc.c             |  2 +-
>   drivers/gpu/drm/loongson/lsdc_crtc.c               | 30 ++++++++-------
>   drivers/gpu/drm/mediatek/mtk_crtc.c                | 18 ++++-----
>   drivers/gpu/drm/sitronix/st7920.c                  | 12 +++---
>   drivers/gpu/drm/tilcdc/tilcdc_crtc.c               |  7 ++--
>   drivers/gpu/drm/tilcdc/tilcdc_drv.c                |  2 +
>   include/drm/drm_atomic_state_helper.h              |  3 --
>   include/drm/drm_crtc.h                             | 12 ------
>   include/drm/drm_modeset_helper_vtables.h           | 14 +++++++
>   15 files changed, 94 insertions(+), 120 deletions(-)
> ---
> base-commit: 07c66ce1e6446f5cc6a4ace99a8d46880f45c527
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


