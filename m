Return-Path: <dri-devel-bounces@lists.freedesktop.org>
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 351EDE7E351
	for <dri-devel@archiver.kernel.org>; Fri,  3 Apr 2026 08:59:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4DA3C10F429;
	Fri,  3 Apr 2026 08:59:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="t1yX2dS4";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="6srzaKq1";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="t1yX2dS4";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="6srzaKq1";
	dkim-atps=neutral
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 166C110E337
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Apr 2026 06:05:16 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 4CB005BCDD;
 Wed,  1 Apr 2026 06:05:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1775023514; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=yENRbAi1NMyVqhbkKAY8dOjMYTLs6PTCeSYzcNONHN0=;
 b=t1yX2dS4YjNBIYZvsJ6Q7dOlf86trp2WipsHPNanQJR5yxw50kpmOw2l5pd3dt+dRxrL8B
 z2Gx9sVqpaiEqAn8cMEKC5/6LJIjQLZS1b4wnyBr9ZIen6SrvMMIkjQP75VJBNMGiv0p7r
 LI8DRJoQhYNVSJcuYOOrD5/4BDcDcgM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1775023514;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=yENRbAi1NMyVqhbkKAY8dOjMYTLs6PTCeSYzcNONHN0=;
 b=6srzaKq1PQdPE6vabyqn2agVUw851YfQcgl/4oLM2UcIYlUB1KjX9cO6Rl0i6gO0zfg1OX
 j7i8YIKSLR8ZihDQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=t1yX2dS4;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=6srzaKq1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1775023514; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=yENRbAi1NMyVqhbkKAY8dOjMYTLs6PTCeSYzcNONHN0=;
 b=t1yX2dS4YjNBIYZvsJ6Q7dOlf86trp2WipsHPNanQJR5yxw50kpmOw2l5pd3dt+dRxrL8B
 z2Gx9sVqpaiEqAn8cMEKC5/6LJIjQLZS1b4wnyBr9ZIen6SrvMMIkjQP75VJBNMGiv0p7r
 LI8DRJoQhYNVSJcuYOOrD5/4BDcDcgM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1775023514;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=yENRbAi1NMyVqhbkKAY8dOjMYTLs6PTCeSYzcNONHN0=;
 b=6srzaKq1PQdPE6vabyqn2agVUw851YfQcgl/4oLM2UcIYlUB1KjX9cO6Rl0i6gO0zfg1OX
 j7i8YIKSLR8ZihDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 55FC74A0B0;
 Wed,  1 Apr 2026 06:05:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id n2iJE5m1zGnYcgAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Wed, 01 Apr 2026 06:05:13 +0000
Message-ID: <316d8ab8-78d0-4169-9264-e4da5424b5d6@suse.de>
Date: Wed, 1 Apr 2026 08:05:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] drm: Rename drm_atomic_state
To: Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Jonathan Corbet <corbet@lwn.net>
Cc: Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Tvrtko Ursulin
 <tursulin@ursulin.net>, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
 Simona Vetter <simona.vetter@ffwll.ch>
References: <20260331-drm-drm-atomic-update-v2-0-7e8fe6ddcd32@kernel.org>
 <20260331-drm-drm-atomic-update-v2-1-7e8fe6ddcd32@kernel.org>
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
In-Reply-To: <20260331-drm-drm-atomic-update-v2-1-7e8fe6ddcd32@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FREEMAIL_TO(0.00)[kernel.org,gmail.com,ffwll.ch,linux.intel.com,lwn.net];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 ARC_NA(0.00)[]; RCPT_COUNT_TWELVE(0.00)[21];
 MIME_TRACE(0.00)[0:+]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; RCVD_TLS_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MID_RHS_MATCH_FROM(0.00)[]; DKIM_TRACE(0.00)[suse.de:+];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[ffwll.ch:email, suse.com:url, suse.de:dkim,
 suse.de:mid, suse.de:email, imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns, chromium.org:email, 128x128-left-edge:email]
X-Rspamd-Queue-Id: 4CB005BCDD
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Spam-Level: 
X-Mailman-Approved-At: Fri, 03 Apr 2026 08:59:17 +0000
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

Am 31.03.26 um 16:41 schrieb Maxime Ripard:
> The KMS framework uses two slightly different definitions for the state
> concept. For a given object (plane, CRTC, encoder, etc., so
> drm_$OBJECT_state), the state is the entire state of that object.
> However, at the device level, drm_atomic_state refers to a state update
> for a limited number of objects.
>
> Thus, drm_atomic_state isn't the entire device state, but only the full
> state of some objects in that device. This has been an endless source of
> confusion and thus bugs.
>
> We can rename drm_atomic_state to drm_atomic_commit to make it less
> confusing.

Nit: The subject should already spell out the new name.

>
> This patch was created using:
>
> rg -l drm_atomic_state | \
> 	xargs sed -i 's/drm_atomic_state/drm_atomic_commit/g; s/drm_atomic_commit_helper/drm_atomic_state_helper/g'
> mv drivers/gpu/drm/tests/drm_atomic_state_test.c drivers/gpu/drm/tests/drm_atomic_commit_test.c

We now have many places that read like "struct drm_atomic_commit 
*state', which mixes up terminology. Is there a way of transforming this 
automatically to use 'commit' for the variable's name?

Best regards
Thomas

>
> Acked-by: Simona Vetter <simona.vetter@ffwll.ch>
> Acked-by: Thomas Zimmermann <tzimmermann@suse.de>
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> ---
>   Documentation/gpu/drm-kms.rst                      |  14 +-
>   Documentation/gpu/komeda-kms.rst                   |   6 +-
>   Documentation/gpu/todo.rst                         |  12 +-
>   drivers/gpu/drm/adp/adp_drv.c                      |  12 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c           |  10 +-
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |  62 ++++----
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h  |   6 +-
>   .../drm/amd/display/amdgpu_dm/amdgpu_dm_color.c    |  12 +-
>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c |   4 +-
>   .../amd/display/amdgpu_dm/amdgpu_dm_mst_types.c    |  22 +--
>   .../amd/display/amdgpu_dm/amdgpu_dm_mst_types.h    |   4 +-
>   .../drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c    |   6 +-
>   .../drm/amd/display/amdgpu_dm/amdgpu_dm_trace.h    |  20 +--
>   drivers/gpu/drm/arm/display/komeda/komeda_crtc.c   |   8 +-
>   drivers/gpu/drm/arm/display/komeda/komeda_kms.c    |  10 +-
>   .../gpu/drm/arm/display/komeda/komeda_pipeline.h   |  14 +-
>   .../drm/arm/display/komeda/komeda_pipeline_state.c |  28 ++--
>   drivers/gpu/drm/arm/display/komeda/komeda_plane.c  |   4 +-
>   drivers/gpu/drm/arm/hdlcd_crtc.c                   |  10 +-
>   drivers/gpu/drm/arm/malidp_crtc.c                  |   6 +-
>   drivers/gpu/drm/arm/malidp_drv.c                   |   4 +-
>   drivers/gpu/drm/arm/malidp_mw.c                    |   2 +-
>   drivers/gpu/drm/arm/malidp_mw.h                    |   2 +-
>   drivers/gpu/drm/arm/malidp_planes.c                |   6 +-
>   drivers/gpu/drm/armada/armada_crtc.c               |  10 +-
>   drivers/gpu/drm/armada/armada_overlay.c            |  10 +-
>   drivers/gpu/drm/armada/armada_plane.c              |   6 +-
>   drivers/gpu/drm/armada/armada_plane.h              |   2 +-
>   drivers/gpu/drm/ast/ast_cursor.c                   |   6 +-
>   drivers/gpu/drm/ast/ast_dp.c                       |   4 +-
>   drivers/gpu/drm/ast/ast_dp501.c                    |   4 +-
>   drivers/gpu/drm/ast/ast_mode.c                     |  18 +--
>   drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c     |  10 +-
>   drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c       |   2 +-
>   drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h       |   2 +-
>   drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c    |   6 +-
>   drivers/gpu/drm/bridge/adv7511/adv7511_drv.c       |   4 +-
>   drivers/gpu/drm/bridge/analogix/analogix_dp_core.c |  14 +-
>   drivers/gpu/drm/bridge/analogix/anx7625.c          |   4 +-
>   drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c     |   4 +-
>   .../gpu/drm/bridge/cadence/cdns-mhdp8546-core.c    |   6 +-
>   drivers/gpu/drm/bridge/chipone-icn6211.c           |   6 +-
>   drivers/gpu/drm/bridge/fsl-ldb.c                   |   4 +-
>   drivers/gpu/drm/bridge/imx/imx8mp-hdmi-pvi.c       |   4 +-
>   drivers/gpu/drm/bridge/imx/imx8qm-ldb.c            |   4 +-
>   drivers/gpu/drm/bridge/imx/imx8qxp-ldb.c           |   6 +-
>   .../gpu/drm/bridge/imx/imx8qxp-pixel-combiner.c    |   2 +-
>   drivers/gpu/drm/bridge/imx/imx8qxp-pixel-link.c    |   4 +-
>   drivers/gpu/drm/bridge/imx/imx8qxp-pxl2dpi.c       |   2 +-
>   drivers/gpu/drm/bridge/inno-hdmi.c                 |   6 +-
>   drivers/gpu/drm/bridge/ite-it6263.c                |   4 +-
>   drivers/gpu/drm/bridge/ite-it6505.c                |   8 +-
>   drivers/gpu/drm/bridge/ite-it66121.c               |   4 +-
>   drivers/gpu/drm/bridge/lontium-lt9211.c            |   4 +-
>   drivers/gpu/drm/bridge/lontium-lt9611.c            |   8 +-
>   drivers/gpu/drm/bridge/nwl-dsi.c                   |   4 +-
>   drivers/gpu/drm/bridge/panel.c                     |   8 +-
>   drivers/gpu/drm/bridge/parade-ps8640.c             |   4 +-
>   drivers/gpu/drm/bridge/samsung-dsim.c              |   8 +-
>   drivers/gpu/drm/bridge/sii902x.c                   |   4 +-
>   drivers/gpu/drm/bridge/ssd2825.c                   |   6 +-
>   drivers/gpu/drm/bridge/synopsys/dw-dp.c            |   4 +-
>   drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c       |   4 +-
>   drivers/gpu/drm/bridge/synopsys/dw-hdmi.c          |   6 +-
>   drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c      |   6 +-
>   drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi2.c     |   6 +-
>   drivers/gpu/drm/bridge/tc358762.c                  |   6 +-
>   drivers/gpu/drm/bridge/tc358767.c                  |   8 +-
>   drivers/gpu/drm/bridge/tc358768.c                  |   8 +-
>   drivers/gpu/drm/bridge/tc358775.c                  |   6 +-
>   drivers/gpu/drm/bridge/ti-dlpc3433.c               |   6 +-
>   drivers/gpu/drm/bridge/ti-sn65dsi83.c              |   6 +-
>   drivers/gpu/drm/bridge/ti-sn65dsi86.c              |  22 +--
>   drivers/gpu/drm/bridge/ti-tdp158.c                 |   4 +-
>   drivers/gpu/drm/ci/xfails/vkms-none-skips.txt      |  20 +--
>   drivers/gpu/drm/display/drm_bridge_connector.c     |   2 +-
>   drivers/gpu/drm/display/drm_dp_mst_topology.c      |  26 ++--
>   drivers/gpu/drm/display/drm_dp_tunnel.c            |  14 +-
>   drivers/gpu/drm/display/drm_hdmi_state_helper.c    |   6 +-
>   drivers/gpu/drm/drm_atomic.c                       | 128 +++++++--------
>   drivers/gpu/drm/drm_atomic_helper.c                | 172 ++++++++++-----------
>   drivers/gpu/drm/drm_atomic_state_helper.c          |   2 +-
>   drivers/gpu/drm/drm_atomic_uapi.c                  |  28 ++--
>   drivers/gpu/drm/drm_blend.c                        |   8 +-
>   drivers/gpu/drm/drm_bridge.c                       |  14 +-
>   drivers/gpu/drm/drm_client_modeset.c               |   8 +-
>   drivers/gpu/drm/drm_color_mgmt.c                   |   6 +-
>   drivers/gpu/drm/drm_crtc_helper.c                  |   2 +-
>   drivers/gpu/drm/drm_crtc_internal.h                |  10 +-
>   drivers/gpu/drm/drm_damage_helper.c                |  10 +-
>   drivers/gpu/drm/drm_fb_helper.c                    |   8 +-
>   drivers/gpu/drm/drm_framebuffer.c                  |   8 +-
>   drivers/gpu/drm/drm_mode_object.c                  |   8 +-
>   drivers/gpu/drm/drm_modeset_helper.c               |   2 +-
>   drivers/gpu/drm/drm_self_refresh_helper.c          |  12 +-
>   drivers/gpu/drm/drm_simple_kms_helper.c            |  10 +-
>   drivers/gpu/drm/drm_vblank_helper.c                |   6 +-
>   drivers/gpu/drm/exynos/exynos_drm_crtc.c           |  10 +-
>   drivers/gpu/drm/exynos/exynos_drm_plane.c          |   6 +-
>   drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_crtc.c         |   6 +-
>   drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_plane.c        |   6 +-
>   drivers/gpu/drm/gud/gud_connector.c                |  10 +-
>   drivers/gpu/drm/gud/gud_internal.h                 |   8 +-
>   drivers/gpu/drm/gud/gud_pipe.c                     |   8 +-
>   drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c     |  12 +-
>   drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c     |   4 +-
>   drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c    |  14 +-
>   drivers/gpu/drm/hyperv/hyperv_drm_modeset.c        |   6 +-
>   drivers/gpu/drm/i915/display/g4x_hdmi.c            |   2 +-
>   drivers/gpu/drm/i915/display/g4x_hdmi.h            |   6 +-
>   drivers/gpu/drm/i915/display/i9xx_wm.c             |  10 +-
>   drivers/gpu/drm/i915/display/intel_atomic.c        |  16 +-
>   drivers/gpu/drm/i915/display/intel_atomic.h        |  12 +-
>   drivers/gpu/drm/i915/display/intel_audio.c         |   8 +-
>   drivers/gpu/drm/i915/display/intel_crt.c           |   2 +-
>   drivers/gpu/drm/i915/display/intel_display.c       |  22 +--
>   drivers/gpu/drm/i915/display/intel_display.h       |   6 +-
>   drivers/gpu/drm/i915/display/intel_display_core.h  |   2 +-
>   .../gpu/drm/i915/display/intel_display_driver.c    |   8 +-
>   .../gpu/drm/i915/display/intel_display_driver.h    |   4 +-
>   drivers/gpu/drm/i915/display/intel_display_reset.c |   8 +-
>   drivers/gpu/drm/i915/display/intel_display_types.h |   2 +-
>   drivers/gpu/drm/i915/display/intel_dp.c            |   2 +-
>   drivers/gpu/drm/i915/display/intel_dp_mst.c        |   6 +-
>   drivers/gpu/drm/i915/display/intel_dpll_mgr.c      |   2 +-
>   drivers/gpu/drm/i915/display/intel_fdi.c           |   2 +-
>   drivers/gpu/drm/i915/display/intel_hdmi.c          |   2 +-
>   drivers/gpu/drm/i915/display/intel_load_detect.c   |  20 +--
>   drivers/gpu/drm/i915/display/intel_load_detect.h   |   6 +-
>   drivers/gpu/drm/i915/display/intel_modeset_lock.c  |   2 +-
>   drivers/gpu/drm/i915/display/intel_modeset_setup.c |   6 +-
>   drivers/gpu/drm/i915/display/intel_pipe_crc.c      |   8 +-
>   drivers/gpu/drm/i915/display/intel_plane.c         |   2 +-
>   drivers/gpu/drm/i915/display/intel_psr.c           |   8 +-
>   drivers/gpu/drm/i915/display/intel_sdvo.c          |   2 +-
>   drivers/gpu/drm/i915/display/intel_sprite_uapi.c   |   8 +-
>   drivers/gpu/drm/i915/display/intel_tc.c            |   6 +-
>   drivers/gpu/drm/i915/display/intel_tv.c            |   4 +-
>   drivers/gpu/drm/imx/dc/dc-crtc.c                   |  10 +-
>   drivers/gpu/drm/imx/dc/dc-plane.c                  |   6 +-
>   drivers/gpu/drm/imx/dcss/dcss-crtc.c               |   8 +-
>   drivers/gpu/drm/imx/dcss/dcss-plane.c              |   6 +-
>   drivers/gpu/drm/imx/ipuv3/imx-drm-core.c           |   4 +-
>   drivers/gpu/drm/imx/ipuv3/imx-drm.h                |   2 +-
>   drivers/gpu/drm/imx/ipuv3/ipuv3-crtc.c             |  10 +-
>   drivers/gpu/drm/imx/ipuv3/ipuv3-plane.c            |   8 +-
>   drivers/gpu/drm/ingenic/ingenic-drm-drv.c          |  24 +--
>   drivers/gpu/drm/ingenic/ingenic-ipu.c              |  10 +-
>   drivers/gpu/drm/kmb/kmb_crtc.c                     |  10 +-
>   drivers/gpu/drm/kmb/kmb_drv.h                      |   2 +-
>   drivers/gpu/drm/kmb/kmb_dsi.c                      |   4 +-
>   drivers/gpu/drm/kmb/kmb_dsi.h                      |   2 +-
>   drivers/gpu/drm/kmb/kmb_plane.c                    |   6 +-
>   drivers/gpu/drm/logicvc/logicvc_crtc.c             |   6 +-
>   drivers/gpu/drm/logicvc/logicvc_layer.c            |   6 +-
>   drivers/gpu/drm/loongson/lsdc_crtc.c               |   8 +-
>   drivers/gpu/drm/loongson/lsdc_output_7a1000.c      |   2 +-
>   drivers/gpu/drm/loongson/lsdc_output_7a2000.c      |   6 +-
>   drivers/gpu/drm/loongson/lsdc_plane.c              |  22 +--
>   drivers/gpu/drm/mediatek/mtk_crtc.c                |  12 +-
>   drivers/gpu/drm/mediatek/mtk_crtc.h                |   2 +-
>   drivers/gpu/drm/mediatek/mtk_dp.c                  |   4 +-
>   drivers/gpu/drm/mediatek/mtk_drm_drv.h             |   2 +-
>   drivers/gpu/drm/mediatek/mtk_dsi.c                 |   8 +-
>   drivers/gpu/drm/mediatek/mtk_hdmi.c                |   8 +-
>   drivers/gpu/drm/mediatek/mtk_hdmi_v2.c             |   8 +-
>   drivers/gpu/drm/mediatek/mtk_plane.c               |  10 +-
>   drivers/gpu/drm/meson/meson_crtc.c                 |  12 +-
>   drivers/gpu/drm/meson/meson_encoder_cvbs.c         |   4 +-
>   drivers/gpu/drm/meson/meson_encoder_dsi.c          |   4 +-
>   drivers/gpu/drm/meson/meson_encoder_hdmi.c         |   4 +-
>   drivers/gpu/drm/meson/meson_overlay.c              |   6 +-
>   drivers/gpu/drm/meson/meson_plane.c                |   6 +-
>   drivers/gpu/drm/mgag200/mgag200_drv.h              |  26 ++--
>   drivers/gpu/drm/mgag200/mgag200_g200.c             |   4 +-
>   drivers/gpu/drm/mgag200/mgag200_g200eh.c           |   4 +-
>   drivers/gpu/drm/mgag200/mgag200_g200eh3.c          |   2 +-
>   drivers/gpu/drm/mgag200/mgag200_g200eh5.c          |   2 +-
>   drivers/gpu/drm/mgag200/mgag200_g200er.c           |   6 +-
>   drivers/gpu/drm/mgag200/mgag200_g200ev.c           |   6 +-
>   drivers/gpu/drm/mgag200/mgag200_g200ew3.c          |   2 +-
>   drivers/gpu/drm/mgag200/mgag200_g200se.c           |  10 +-
>   drivers/gpu/drm/mgag200/mgag200_g200wb.c           |   4 +-
>   drivers/gpu/drm/mgag200/mgag200_mode.c             |  18 +--
>   drivers/gpu/drm/mgag200/mgag200_vga_bmc.c          |   4 +-
>   drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c           |  12 +-
>   drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c        |   8 +-
>   drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h        |   4 +-
>   drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c            |   4 +-
>   drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h            |   2 +-
>   drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c          |  12 +-
>   drivers/gpu/drm/msm/disp/dpu1/dpu_plane.h          |   2 +-
>   drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.c      |   2 +-
>   drivers/gpu/drm/msm/disp/mdp4/mdp4_crtc.c          |  10 +-
>   drivers/gpu/drm/msm/disp/mdp4/mdp4_plane.c         |   4 +-
>   drivers/gpu/drm/msm/disp/mdp5/mdp5_crtc.c          |  10 +-
>   drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c           |   4 +-
>   drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.h           |   4 +-
>   drivers/gpu/drm/msm/disp/mdp5/mdp5_mixer.c         |   4 +-
>   drivers/gpu/drm/msm/disp/mdp5/mdp5_mixer.h         |   4 +-
>   drivers/gpu/drm/msm/disp/mdp5/mdp5_pipe.c          |   4 +-
>   drivers/gpu/drm/msm/disp/mdp5/mdp5_pipe.h          |   4 +-
>   drivers/gpu/drm/msm/disp/mdp5/mdp5_plane.c         |   8 +-
>   drivers/gpu/drm/msm/disp/msm_disp_snapshot.h       |   2 +-
>   drivers/gpu/drm/msm/disp/msm_disp_snapshot_util.c  |   2 +-
>   drivers/gpu/drm/msm/dp/dp_display.c                |   6 +-
>   drivers/gpu/drm/msm/dp/dp_drm.c                    |   6 +-
>   drivers/gpu/drm/msm/dp/dp_drm.h                    |   6 +-
>   drivers/gpu/drm/msm/hdmi/hdmi_bridge.c             |   4 +-
>   drivers/gpu/drm/msm/msm_atomic.c                   |   8 +-
>   drivers/gpu/drm/msm/msm_drv.h                      |   6 +-
>   drivers/gpu/drm/msm/msm_kms.h                      |   4 +-
>   drivers/gpu/drm/mxsfb/lcdif_kms.c                  |  12 +-
>   drivers/gpu/drm/mxsfb/mxsfb_kms.c                  |  16 +-
>   drivers/gpu/drm/nouveau/dispnv50/atom.h            |   6 +-
>   drivers/gpu/drm/nouveau/dispnv50/crc.c             |  16 +-
>   drivers/gpu/drm/nouveau/dispnv50/crc.h             |  16 +-
>   drivers/gpu/drm/nouveau/dispnv50/disp.c            |  68 ++++----
>   drivers/gpu/drm/nouveau/dispnv50/head.c            |   2 +-
>   drivers/gpu/drm/nouveau/dispnv50/wndw.c            |   2 +-
>   drivers/gpu/drm/nouveau/nouveau_connector.c        |   2 +-
>   drivers/gpu/drm/nouveau/nouveau_display.h          |   2 +-
>   drivers/gpu/drm/nouveau/nouveau_encoder.h          |   4 +-
>   drivers/gpu/drm/omapdrm/dss/hdmi4.c                |   4 +-
>   drivers/gpu/drm/omapdrm/dss/hdmi5.c                |   4 +-
>   drivers/gpu/drm/omapdrm/omap_crtc.c                |  10 +-
>   drivers/gpu/drm/omapdrm/omap_drv.c                 |  14 +-
>   drivers/gpu/drm/omapdrm/omap_drv.h                 |   2 +-
>   drivers/gpu/drm/omapdrm/omap_overlay.c             |   4 +-
>   drivers/gpu/drm/omapdrm/omap_overlay.h             |   4 +-
>   drivers/gpu/drm/omapdrm/omap_plane.c               |   6 +-
>   drivers/gpu/drm/qxl/qxl_display.c                  |  16 +-
>   drivers/gpu/drm/renesas/rcar-du/rcar_du_crtc.c     |  18 +--
>   drivers/gpu/drm/renesas/rcar-du/rcar_du_kms.c      |   4 +-
>   drivers/gpu/drm/renesas/rcar-du/rcar_du_plane.c    |   6 +-
>   drivers/gpu/drm/renesas/rcar-du/rcar_du_plane.h    |   2 +-
>   drivers/gpu/drm/renesas/rcar-du/rcar_du_vsp.c      |   4 +-
>   drivers/gpu/drm/renesas/rcar-du/rcar_lvds.c        |   6 +-
>   drivers/gpu/drm/renesas/rcar-du/rcar_mipi_dsi.c    |   6 +-
>   drivers/gpu/drm/renesas/rcar-du/rcar_mipi_dsi.h    |   6 +-
>   drivers/gpu/drm/renesas/rz-du/rzg2l_du_crtc.c      |   6 +-
>   drivers/gpu/drm/renesas/rz-du/rzg2l_du_vsp.c       |   4 +-
>   drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c     |   8 +-
>   drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.c  |   6 +-
>   drivers/gpu/drm/renesas/shmobile/shmob_drm_plane.c |   6 +-
>   drivers/gpu/drm/rockchip/analogix_dp-rockchip.c    |   6 +-
>   drivers/gpu/drm/rockchip/cdn-dp-core.c             |   4 +-
>   drivers/gpu/drm/rockchip/dw-mipi-dsi2-rockchip.c   |   2 +-
>   drivers/gpu/drm/rockchip/dw_dp-rockchip.c          |   2 +-
>   drivers/gpu/drm/rockchip/rk3066_hdmi.c             |   6 +-
>   drivers/gpu/drm/rockchip/rockchip_drm_vop.c        |  22 +--
>   drivers/gpu/drm/rockchip/rockchip_drm_vop2.c       |  18 +--
>   drivers/gpu/drm/sitronix/st7571.c                  |  10 +-
>   drivers/gpu/drm/sitronix/st7920.c                  |  12 +-
>   drivers/gpu/drm/solomon/ssd130x.c                  |  32 ++--
>   drivers/gpu/drm/sprd/sprd_dpu.c                    |  12 +-
>   drivers/gpu/drm/sti/sti_crtc.c                     |   6 +-
>   drivers/gpu/drm/sti/sti_cursor.c                   |   6 +-
>   drivers/gpu/drm/sti/sti_gdp.c                      |   6 +-
>   drivers/gpu/drm/sti/sti_hqvdp.c                    |   6 +-
>   drivers/gpu/drm/stm/drv.c                          |   2 +-
>   drivers/gpu/drm/stm/ltdc.c                         |  12 +-
>   drivers/gpu/drm/stm/ltdc.h                         |   2 +-
>   drivers/gpu/drm/stm/lvds.c                         |   6 +-
>   drivers/gpu/drm/sun4i/sun4i_backend.c              |   4 +-
>   drivers/gpu/drm/sun4i/sun4i_crtc.c                 |  10 +-
>   drivers/gpu/drm/sun4i/sun4i_framebuffer.c          |   2 +-
>   drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c             |   4 +-
>   drivers/gpu/drm/sun4i/sun4i_layer.c                |   4 +-
>   drivers/gpu/drm/sun4i/sun4i_tv.c                   |   4 +-
>   drivers/gpu/drm/sun4i/sun8i_mixer.c                |   2 +-
>   drivers/gpu/drm/sun4i/sun8i_ui_layer.c             |   4 +-
>   drivers/gpu/drm/sun4i/sun8i_vi_layer.c             |   4 +-
>   drivers/gpu/drm/sun4i/sunxi_engine.h               |   4 +-
>   drivers/gpu/drm/sysfb/drm_sysfb_helper.h           |   8 +-
>   drivers/gpu/drm/sysfb/drm_sysfb_modeset.c          |   8 +-
>   drivers/gpu/drm/sysfb/ofdrm.c                      |   2 +-
>   drivers/gpu/drm/sysfb/vesadrm.c                    |   4 +-
>   drivers/gpu/drm/tegra/dc.c                         |  32 ++--
>   drivers/gpu/drm/tegra/dc.h                         |   2 +-
>   drivers/gpu/drm/tegra/drm.c                        |   6 +-
>   drivers/gpu/drm/tegra/hub.c                        |  12 +-
>   drivers/gpu/drm/tegra/hub.h                        |   4 +-
>   drivers/gpu/drm/tests/Makefile                     |   2 +-
>   ...tomic_state_test.c => drm_atomic_commit_test.c} |  12 +-
>   drivers/gpu/drm/tests/drm_bridge_test.c            |   8 +-
>   drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c |  88 +++++------
>   drivers/gpu/drm/tests/drm_kunit_helpers.c          |  18 +--
>   drivers/gpu/drm/tidss/tidss_crtc.c                 |  10 +-
>   drivers/gpu/drm/tidss/tidss_kms.c                  |   4 +-
>   drivers/gpu/drm/tidss/tidss_oldi.c                 |   4 +-
>   drivers/gpu/drm/tidss/tidss_plane.c                |   8 +-
>   drivers/gpu/drm/tilcdc/tilcdc_crtc.c               |   8 +-
>   drivers/gpu/drm/tilcdc/tilcdc_drv.c                |   2 +-
>   drivers/gpu/drm/tilcdc/tilcdc_plane.c              |   4 +-
>   drivers/gpu/drm/tiny/appletbdrm.c                  |   6 +-
>   drivers/gpu/drm/tiny/bochs.c                       |  10 +-
>   drivers/gpu/drm/tiny/cirrus-qemu.c                 |   8 +-
>   drivers/gpu/drm/tiny/pixpaper.c                    |  10 +-
>   drivers/gpu/drm/tiny/sharp-memory.c                |  10 +-
>   drivers/gpu/drm/udl/udl_modeset.c                  |   8 +-
>   drivers/gpu/drm/vboxvideo/vbox_mode.c              |  18 +--
>   drivers/gpu/drm/vc4/tests/vc4_mock.h               |   4 +-
>   drivers/gpu/drm/vc4/tests/vc4_mock_output.c        |   4 +-
>   drivers/gpu/drm/vc4/tests/vc4_test_pv_muxing.c     |  50 +++---
>   drivers/gpu/drm/vc4/vc4_crtc.c                     |  10 +-
>   drivers/gpu/drm/vc4/vc4_drv.h                      |  28 ++--
>   drivers/gpu/drm/vc4/vc4_dsi.c                      |   8 +-
>   drivers/gpu/drm/vc4/vc4_hdmi.c                     |  12 +-
>   drivers/gpu/drm/vc4/vc4_hvs.c                      |  10 +-
>   drivers/gpu/drm/vc4/vc4_kms.c                      |  30 ++--
>   drivers/gpu/drm/vc4/vc4_plane.c                    |   8 +-
>   drivers/gpu/drm/vc4/vc4_txp.c                      |  10 +-
>   drivers/gpu/drm/vc4/vc4_vec.c                      |   4 +-
>   drivers/gpu/drm/verisilicon/vs_bridge.c            |   6 +-
>   drivers/gpu/drm/verisilicon/vs_crtc.c              |   4 +-
>   drivers/gpu/drm/verisilicon/vs_primary_plane.c     |   8 +-
>   drivers/gpu/drm/virtio/virtgpu_display.c           |   8 +-
>   drivers/gpu/drm/virtio/virtgpu_plane.c             |   6 +-
>   drivers/gpu/drm/vkms/vkms_crtc.c                   |   6 +-
>   drivers/gpu/drm/vkms/vkms_drv.c                    |   4 +-
>   drivers/gpu/drm/vkms/vkms_plane.c                  |   4 +-
>   drivers/gpu/drm/vkms/vkms_writeback.c              |   4 +-
>   drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c       |   4 +-
>   drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.h       |   4 +-
>   drivers/gpu/drm/vmwgfx/vmwgfx_drv.h                |   2 +-
>   drivers/gpu/drm/vmwgfx/vmwgfx_kms.c                |  18 +--
>   drivers/gpu/drm/vmwgfx/vmwgfx_kms.h                |   6 +-
>   drivers/gpu/drm/vmwgfx/vmwgfx_ldu.c                |   2 +-
>   drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c               |   4 +-
>   drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c               |   8 +-
>   drivers/gpu/drm/vmwgfx/vmwgfx_vkms.c               |   8 +-
>   drivers/gpu/drm/vmwgfx/vmwgfx_vkms.h               |  10 +-
>   drivers/gpu/drm/xlnx/zynqmp_dp.c                   |   6 +-
>   drivers/gpu/drm/xlnx/zynqmp_kms.c                  |  16 +-
>   include/drm/display/drm_dp_mst_helper.h            |  32 ++--
>   include/drm/display/drm_dp_tunnel.h                |  24 +--
>   include/drm/display/drm_hdmi_state_helper.h        |   6 +-
>   include/drm/drm_atomic.h                           | 158 +++++++++----------
>   include/drm/drm_atomic_helper.h                    |  78 +++++-----
>   include/drm/drm_atomic_state_helper.h              |   4 +-
>   include/drm/drm_blend.h                            |   4 +-
>   include/drm/drm_bridge.h                           |  16 +-
>   include/drm/drm_colorop.h                          |   4 +-
>   include/drm/drm_connector.h                        |   6 +-
>   include/drm/drm_crtc.h                             |  10 +-
>   include/drm/drm_crtc_helper.h                      |   4 +-
>   include/drm/drm_damage_helper.h                    |   2 +-
>   include/drm/drm_kunit_helpers.h                    |   2 +-
>   include/drm/drm_mode_config.h                      |  38 ++---
>   include/drm/drm_modeset_helper_vtables.h           |  44 +++---
>   include/drm/drm_plane.h                            |   6 +-
>   include/drm/drm_self_refresh_helper.h              |   6 +-
>   include/drm/drm_vblank_helper.h                    |   8 +-
>   354 files changed, 1729 insertions(+), 1729 deletions(-)
>
> diff --git a/Documentation/gpu/drm-kms.rst b/Documentation/gpu/drm-kms.rst
> index 2292e65f044c3bdebafbb8f83dfe7ac12e831273..fbe0583eb84c9c14bf9be9c59c7e8a44c7cd01bc 100644
> --- a/Documentation/gpu/drm-kms.rst
> +++ b/Documentation/gpu/drm-kms.rst
> @@ -204,15 +204,15 @@ Atomic Mode Setting
>   
>         subgraph cluster_state {
>             style=dashed
>             label="Free-standing state"
>   
> -          "drm_atomic_state" -> "duplicated drm_plane_state A"
> -          "drm_atomic_state" -> "duplicated drm_plane_state B"
> -          "drm_atomic_state" -> "duplicated drm_crtc_state"
> -          "drm_atomic_state" -> "duplicated drm_connector_state"
> -          "drm_atomic_state" -> "duplicated driver private state"
> +          "drm_atomic_commit" -> "duplicated drm_plane_state A"
> +          "drm_atomic_commit" -> "duplicated drm_plane_state B"
> +          "drm_atomic_commit" -> "duplicated drm_crtc_state"
> +          "drm_atomic_commit" -> "duplicated drm_connector_state"
> +          "drm_atomic_commit" -> "duplicated driver private state"
>         }
>   
>         subgraph cluster_current {
>             style=dashed
>             label="Current state"
> @@ -228,11 +228,11 @@ Atomic Mode Setting
>             "drm_crtc" -> "drm_crtc_state"
>             "drm_connector" -> "drm_connector_state"
>             "driver private object" -> "driver private state"
>         }
>   
> -      "drm_atomic_state" -> "drm_device" [label="atomic_commit"]
> +      "drm_atomic_commit" -> "drm_device" [label="atomic_commit"]
>         "duplicated drm_plane_state A" -> "drm_device"[style=invis]
>      }
>   
>   Atomic provides transactional modeset (including planes) updates, but a
>   bit differently from the usual transactional approach of try-commit and
> @@ -263,11 +263,11 @@ Taken all together there's two consequences for the atomic design:
>     can subclass these structures through embedding, or add entirely new state
>     structures for their globally shared hardware functions, see :c:type:`struct
>     drm_private_state<drm_private_state>`.
>   
>   - An atomic update is assembled and validated as an entirely free-standing pile
> -  of structures within the :c:type:`drm_atomic_state <drm_atomic_state>`
> +  of structures within the :c:type:`drm_atomic_commit <drm_atomic_commit>`
>     container. Driver private state structures are also tracked in the same
>     structure; see the next chapter.  Only when a state is committed is it applied
>     to the driver and modeset objects. This way rolling back an update boils down
>     to releasing memory and unreferencing objects like framebuffers.
>   
> diff --git a/Documentation/gpu/komeda-kms.rst b/Documentation/gpu/komeda-kms.rst
> index eaea40eb725b7548a4cd4f808ca37725a34435ba..883d68fd03741388a2029b8165fc897125f0a8d9 100644
> --- a/Documentation/gpu/komeda-kms.rst
> +++ b/Documentation/gpu/komeda-kms.rst
> @@ -365,11 +365,11 @@ So, one KMS-Obj represents a sub-pipeline of komeda resources.
>   -   Crtc: `Display output pipeline`_
>   
>   So, for komeda, we treat KMS crtc/plane/connector as users of pipeline and
>   component, and at any one time a pipeline/component only can be used by one
>   user. And pipeline/component will be treated as private object of DRM-KMS; the
> -state will be managed by drm_atomic_state as well.
> +state will be managed by drm_atomic_commit as well.
>   
>   How to map plane to Layer(input) pipeline
>   -----------------------------------------
>   
>   Komeda has multiple Layer input pipelines, see:
> @@ -414,11 +414,11 @@ Add :c:type:`drm_private_obj` to :c:type:`komeda_component`, :c:type:`komeda_pip
>       struct komeda_pipeline {
>           struct drm_private_obj obj;
>           ...
>       }
>   
> -Tracking component_state/pipeline_state by drm_atomic_state
> +Tracking component_state/pipeline_state by drm_atomic_commit
>   -----------------------------------------------------------
>   
>   Add :c:type:`drm_private_state` and user to :c:type:`komeda_component_state`,
>   :c:type:`komeda_pipeline_state`
>   
> @@ -452,11 +452,11 @@ similar, usually including the following steps:
>            setup 1: check if component is needed, like the scaler is optional depending
>                     on the user_state; if unneeded, just return, and the caller will
>                     put the data flow into next stage.
>            Setup 2: check user_state with component features and capabilities to see
>                     if requirements can be met; if not, return fail.
> -         Setup 3: get component_state from drm_atomic_state, and try set to set
> +         Setup 3: get component_state from drm_atomic_commit, and try set to set
>                     user to component; fail if component has been assigned to another
>                     user already.
>            Setup 3: configure the component_state, like set its input component,
>                     convert user_state to component specific state.
>            Setup 4: adjust the input_dflow and prepare it for the next stage.
> diff --git a/Documentation/gpu/todo.rst b/Documentation/gpu/todo.rst
> index 520da44a04a625e6ded3c6ef672c221523a993f8..356f4e18b95723141cb5eb0e41bd1c3d12fa1cff 100644
> --- a/Documentation/gpu/todo.rst
> +++ b/Documentation/gpu/todo.rst
> @@ -118,28 +118,28 @@ still look at that flag.
>   
>   Contact: Simona Vetter, respective driver maintainers
>   
>   Level: Advanced
>   
> -Rename drm_atomic_state
> +Rename drm_atomic_commit
>   -----------------------
>   
>   The KMS framework uses two slightly different definitions for the ``state``
>   concept. For a given object (plane, CRTC, encoder, etc., so
>   ``drm_$OBJECT_state``), the state is the entire state of that object. However,
> -at the device level, ``drm_atomic_state`` refers to a state update for a
> +at the device level, ``drm_atomic_commit`` refers to a state update for a
>   limited number of objects.
>   
>   The state isn't the entire device state, but only the full state of some
>   objects in that device. This is confusing to newcomers, and
> -``drm_atomic_state`` should be renamed to something clearer like
> +``drm_atomic_commit`` should be renamed to something clearer like
>   ``drm_atomic_commit``.
>   
>   In addition to renaming the structure itself, it would also imply renaming some
> -related functions (``drm_atomic_state_alloc``, ``drm_atomic_state_get``,
> -``drm_atomic_state_put``, ``drm_atomic_state_init``,
> -``__drm_atomic_state_free``, etc.).
> +related functions (``drm_atomic_commit_alloc``, ``drm_atomic_commit_get``,
> +``drm_atomic_commit_put``, ``drm_atomic_commit_init``,
> +``__drm_atomic_commit_free``, etc.).
>   
>   Contact: Maxime Ripard <mripard@kernel.org>
>   
>   Level: Advanced
>   
> diff --git a/drivers/gpu/drm/adp/adp_drv.c b/drivers/gpu/drm/adp/adp_drv.c
> index 4554cf75565e2268f19d1785a3bc886e8a8d8266..a5913c71b39c7626d151890ce138f597207d0de8 100644
> --- a/drivers/gpu/drm/adp/adp_drv.c
> +++ b/drivers/gpu/drm/adp/adp_drv.c
> @@ -127,11 +127,11 @@ struct adp_drv_private {
>   
>   #define to_adp(x) container_of(x, struct adp_drv_private, drm)
>   #define crtc_to_adp(x) container_of(x, struct adp_drv_private, crtc)
>   
>   static int adp_plane_atomic_check(struct drm_plane *plane,
> -				    struct drm_atomic_state *state)
> +				    struct drm_atomic_commit *state)
>   {
>   	struct drm_plane_state *new_plane_state;
>   	struct drm_crtc_state *crtc_state;
>   
>   	new_plane_state = drm_atomic_get_new_plane_state(state, plane);
> @@ -149,11 +149,11 @@ static int adp_plane_atomic_check(struct drm_plane *plane,
>   						   DRM_PLANE_NO_SCALING,
>   						   true, true);
>   }
>   
>   static void adp_plane_atomic_update(struct drm_plane *plane,
> -				    struct drm_atomic_state *state)
> +				    struct drm_atomic_commit *state)
>   {
>   	struct adp_drv_private *adp;
>   	struct drm_rect src_rect;
>   	struct drm_gem_dma_object *obj;
>   	struct drm_framebuffer *fb;
> @@ -191,11 +191,11 @@ static void adp_plane_atomic_update(struct drm_plane *plane,
>   	writel(ADBE_LAYER_CTL_ENABLE | BIT(0), adp->be + ADBE_LAYER_CTL);
>   	writel(ADBE_PIX_FMT_XRGB32, adp->be + ADBE_PIX_FMT);
>   }
>   
>   static void adp_plane_atomic_disable(struct drm_plane *plane,
> -				     struct drm_atomic_state *state)
> +				     struct drm_atomic_commit *state)
>   {
>   	struct adp_drv_private *adp = to_adp(plane->dev);
>   
>   	writel(0x0, adp->be + ADBE_LAYER_EN1);
>   	writel(0x0, adp->be + ADBE_LAYER_EN2);
> @@ -277,11 +277,11 @@ static void adp_crtc_disable_vblank(struct drm_crtc *crtc)
>   
>   	adp_disable_vblank(adp);
>   }
>   
>   static void adp_crtc_atomic_enable(struct drm_crtc *crtc,
> -				   struct drm_atomic_state *state)
> +				   struct drm_atomic_commit *state)
>   {
>   	struct adp_drv_private *adp = crtc_to_adp(crtc);
>   
>   	writel(BIT(0), adp->be + ADBE_BLEND_EN2);
>   	writel(BIT(4), adp->be + ADBE_BLEND_EN1);
> @@ -290,11 +290,11 @@ static void adp_crtc_atomic_enable(struct drm_crtc *crtc,
>   	writel(BIT(0), adp->be + ADBE_BLEND_EN4);
>   	drm_crtc_vblank_on(crtc);
>   }
>   
>   static void adp_crtc_atomic_disable(struct drm_crtc *crtc,
> -				    struct drm_atomic_state *state)
> +				    struct drm_atomic_commit *state)
>   {
>   	struct adp_drv_private *adp = crtc_to_adp(crtc);
>   	struct drm_crtc_state *old_state = drm_atomic_get_old_crtc_state(state, crtc);
>   
>   	drm_atomic_helper_disable_planes_on_crtc(old_state, false);
> @@ -306,11 +306,11 @@ static void adp_crtc_atomic_disable(struct drm_crtc *crtc,
>   	writel(0x0, adp->be + ADBE_BLEND_EN4);
>   	drm_crtc_vblank_off(crtc);
>   }
>   
>   static void adp_crtc_atomic_flush(struct drm_crtc *crtc,
> -				  struct drm_atomic_state *state)
> +				  struct drm_atomic_commit *state)
>   {
>   	u32 frame_num = 1;
>   	unsigned long flags;
>   	struct adp_drv_private *adp = crtc_to_adp(crtc);
>   	struct drm_crtc_state *new_state = drm_atomic_get_new_crtc_state(state, crtc);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
> index 5cef8cd141485337b92618dcee3bbf0cdd06faaf..eddf1162a1c87bcbeff15348abf44e519c5f3aac 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
> @@ -128,23 +128,23 @@ static const struct drm_crtc_funcs amdgpu_vkms_crtc_funcs = {
>   	.disable_vblank		= amdgpu_vkms_disable_vblank,
>   	.get_vblank_timestamp	= amdgpu_vkms_get_vblank_timestamp,
>   };
>   
>   static void amdgpu_vkms_crtc_atomic_enable(struct drm_crtc *crtc,
> -					   struct drm_atomic_state *state)
> +					   struct drm_atomic_commit *state)
>   {
>   	drm_crtc_vblank_on(crtc);
>   }
>   
>   static void amdgpu_vkms_crtc_atomic_disable(struct drm_crtc *crtc,
> -					    struct drm_atomic_state *state)
> +					    struct drm_atomic_commit *state)
>   {
>   	drm_crtc_vblank_off(crtc);
>   }
>   
>   static void amdgpu_vkms_crtc_atomic_flush(struct drm_crtc *crtc,
> -					  struct drm_atomic_state *state)
> +					  struct drm_atomic_commit *state)
>   {
>   	unsigned long flags;
>   	if (crtc->state->event) {
>   		spin_lock_irqsave(&crtc->dev->event_lock, flags);
>   
> @@ -260,17 +260,17 @@ static const struct drm_plane_funcs amdgpu_vkms_plane_funcs = {
>   	.atomic_duplicate_state = drm_atomic_helper_plane_duplicate_state,
>   	.atomic_destroy_state	= drm_atomic_helper_plane_destroy_state,
>   };
>   
>   static void amdgpu_vkms_plane_atomic_update(struct drm_plane *plane,
> -					    struct drm_atomic_state *old_state)
> +					    struct drm_atomic_commit *old_state)
>   {
>   	return;
>   }
>   
>   static int amdgpu_vkms_plane_atomic_check(struct drm_plane *plane,
> -					  struct drm_atomic_state *state)
> +					  struct drm_atomic_commit *state)
>   {
>   	struct drm_plane_state *new_plane_state = drm_atomic_get_new_plane_state(state,
>   										 plane);
>   	struct drm_crtc_state *crtc_state;
>   	int ret;
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 205a7fab103705fc1c449eb8f1952a6a4fc92be5..cd4e89a257fbc0096c355046a7b6a124ca559705 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -229,15 +229,15 @@ static int amdgpu_dm_encoder_init(struct drm_device *dev,
>   				  struct amdgpu_encoder *aencoder,
>   				  uint32_t link_index);
>   
>   static int amdgpu_dm_connector_get_modes(struct drm_connector *connector);
>   
> -static int amdgpu_dm_atomic_setup_commit(struct drm_atomic_state *state);
> -static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state);
> +static int amdgpu_dm_atomic_setup_commit(struct drm_atomic_commit *state);
> +static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_commit *state);
>   
>   static int amdgpu_dm_atomic_check(struct drm_device *dev,
> -				  struct drm_atomic_state *state);
> +				  struct drm_atomic_commit *state);
>   
>   static void handle_hpd_irq_helper(struct amdgpu_dm_connector *aconnector);
>   static void handle_hpd_rx_irq(void *param);
>   
>   static void amdgpu_dm_backlight_set_level(struct amdgpu_display_manager *dm,
> @@ -3327,11 +3327,11 @@ static int dm_suspend(struct amdgpu_ip_block *ip_block)
>   
>   	return 0;
>   }
>   
>   struct drm_connector *
> -amdgpu_dm_find_first_crtc_matching_connector(struct drm_atomic_state *state,
> +amdgpu_dm_find_first_crtc_matching_connector(struct drm_atomic_commit *state,
>   					     struct drm_crtc *crtc)
>   {
>   	u32 i;
>   	struct drm_connector_state *new_con_state;
>   	struct drm_connector *connector;
> @@ -4830,11 +4830,11 @@ static int register_outbox_irq_handlers(struct amdgpu_device *adev)
>    * Acquires the lock for the atomic state object and returns
>    * the new atomic state.
>    *
>    * This should only be called during atomic check.
>    */
> -int dm_atomic_get_state(struct drm_atomic_state *state,
> +int dm_atomic_get_state(struct drm_atomic_commit *state,
>   			struct dm_atomic_state **dm_state)
>   {
>   	struct drm_device *dev = state->dev;
>   	struct amdgpu_device *adev = drm_to_adev(dev);
>   	struct amdgpu_display_manager *dm = &adev->dm;
> @@ -4851,11 +4851,11 @@ int dm_atomic_get_state(struct drm_atomic_state *state,
>   
>   	return 0;
>   }
>   
>   static struct dm_atomic_state *
> -dm_atomic_get_new_state(struct drm_atomic_state *state)
> +dm_atomic_get_new_state(struct drm_atomic_commit *state)
>   {
>   	struct drm_device *dev = state->dev;
>   	struct amdgpu_device *adev = drm_to_adev(dev);
>   	struct amdgpu_display_manager *dm = &adev->dm;
>   	struct drm_private_obj *obj;
> @@ -8293,11 +8293,11 @@ static int fill_hdr_info_packet(const struct drm_connector_state *state,
>   	return 0;
>   }
>   
>   static int
>   amdgpu_dm_connector_atomic_check(struct drm_connector *conn,
> -				 struct drm_atomic_state *state)
> +				 struct drm_atomic_commit *state)
>   {
>   	struct drm_connector_state *new_con_state =
>   		drm_atomic_get_new_connector_state(state, conn);
>   	struct drm_connector_state *old_con_state =
>   		drm_atomic_get_old_connector_state(state, conn);
> @@ -8415,11 +8415,11 @@ int convert_dc_color_depth_into_bpc(enum dc_color_depth display_color_depth)
>   
>   static int dm_encoder_helper_atomic_check(struct drm_encoder *encoder,
>   					  struct drm_crtc_state *crtc_state,
>   					  struct drm_connector_state *conn_state)
>   {
> -	struct drm_atomic_state *state = crtc_state->state;
> +	struct drm_atomic_commit *state = crtc_state->state;
>   	struct drm_connector *connector = conn_state->connector;
>   	struct amdgpu_dm_connector *aconnector = to_amdgpu_dm_connector(connector);
>   	struct dm_connector_state *dm_new_connector_state = to_dm_connector_state(conn_state);
>   	const struct drm_display_mode *adjusted_mode = &crtc_state->adjusted_mode;
>   	struct drm_dp_mst_topology_mgr *mst_mgr;
> @@ -8487,11 +8487,11 @@ static int dm_encoder_helper_atomic_check(struct drm_encoder *encoder,
>   const struct drm_encoder_helper_funcs amdgpu_dm_encoder_helper_funcs = {
>   	.disable = dm_encoder_helper_disable,
>   	.atomic_check = dm_encoder_helper_atomic_check
>   };
>   
> -static int dm_update_mst_vcpi_slots_for_dsc(struct drm_atomic_state *state,
> +static int dm_update_mst_vcpi_slots_for_dsc(struct drm_atomic_commit *state,
>   					    struct dc_state *dc_state,
>   					    struct dsc_mst_fairness_vars *vars)
>   {
>   	struct dc_stream_state *stream = NULL;
>   	struct drm_connector *connector;
> @@ -9773,11 +9773,11 @@ static void amdgpu_dm_handle_vrr_transition(struct dm_crtc_state *old_state,
>   		drm_dbg_driver(new_state->base.crtc->dev, "%s: crtc=%u VRR on->off: Drop vblank ref\n",
>   				 __func__, new_state->base.crtc->base.id);
>   	}
>   }
>   
> -static void amdgpu_dm_commit_cursors(struct drm_atomic_state *state)
> +static void amdgpu_dm_commit_cursors(struct drm_atomic_commit *state)
>   {
>   	struct drm_plane *plane;
>   	struct drm_plane_state *old_plane_state;
>   	int i;
>   
> @@ -9920,11 +9920,11 @@ static void amdgpu_dm_enable_self_refresh(struct amdgpu_crtc *acrtc_attach,
>   	} else {
>   		acrtc_attach->dm_irq_params.allow_sr_entry = false;
>   	}
>   }
>   
> -static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
> +static void amdgpu_dm_commit_planes(struct drm_atomic_commit *state,
>   				    struct drm_device *dev,
>   				    struct amdgpu_display_manager *dm,
>   				    struct drm_crtc *pcrtc,
>   				    bool wait_for_vblank)
>   {
> @@ -10314,11 +10314,11 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
>   cleanup:
>   	kfree(bundle);
>   }
>   
>   static void amdgpu_dm_commit_audio(struct drm_device *dev,
> -				   struct drm_atomic_state *state)
> +				   struct drm_atomic_commit *state)
>   {
>   	struct amdgpu_device *adev = drm_to_adev(dev);
>   	struct amdgpu_dm_connector *aconnector;
>   	struct drm_connector *connector;
>   	struct drm_connector_state *old_con_state, *new_con_state;
> @@ -10414,11 +10414,11 @@ static void dm_clear_writeback(struct amdgpu_display_manager *dm,
>   			      struct dm_crtc_state *crtc_state)
>   {
>   	dc_stream_remove_writeback(dm->dc, crtc_state->stream, 0);
>   }
>   
> -static void amdgpu_dm_commit_streams(struct drm_atomic_state *state,
> +static void amdgpu_dm_commit_streams(struct drm_atomic_commit *state,
>   					struct dc_state *dc_state)
>   {
>   	struct drm_device *dev = state->dev;
>   	struct amdgpu_device *adev = drm_to_adev(dev);
>   	struct amdgpu_display_manager *dm = &adev->dm;
> @@ -10714,11 +10714,11 @@ static void dm_set_writeback(struct amdgpu_display_manager *dm,
>   	acrtc->wb_pending = true;
>   	acrtc->wb_conn = wb_conn;
>   	drm_writeback_queue_job(wb_conn, new_con_state);
>   }
>   
> -static void amdgpu_dm_update_hdcp(struct drm_atomic_state *state)
> +static void amdgpu_dm_update_hdcp(struct drm_atomic_commit *state)
>   {
>   	struct drm_connector_state *old_con_state, *new_con_state;
>   	struct drm_device *dev = state->dev;
>   	struct drm_connector *connector;
>   	struct amdgpu_device *adev = drm_to_adev(dev);
> @@ -10829,11 +10829,11 @@ static void amdgpu_dm_update_hdcp(struct drm_atomic_state *state)
>   					new_con_state->hdcp_content_type, enable_encryption);
>   		}
>   	}
>   }
>   
> -static int amdgpu_dm_atomic_setup_commit(struct drm_atomic_state *state)
> +static int amdgpu_dm_atomic_setup_commit(struct drm_atomic_commit *state)
>   {
>   	struct drm_crtc *crtc;
>   	struct drm_crtc_state *old_crtc_state, *new_crtc_state;
>   	struct dm_crtc_state *dm_old_crtc_state, *dm_new_crtc_state;
>   	int i, ret;
> @@ -10870,11 +10870,11 @@ static int amdgpu_dm_atomic_setup_commit(struct drm_atomic_state *state)
>    *
>    * This will tell DC to commit the constructed DC state from atomic_check,
>    * programming the hardware. Any failures here implies a hardware failure, since
>    * atomic check should have filtered anything non-kosher.
>    */
> -static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
> +static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_commit *state)
>   {
>   	struct drm_device *dev = state->dev;
>   	struct amdgpu_device *adev = drm_to_adev(dev);
>   	struct amdgpu_display_manager *dm = &adev->dm;
>   	struct dm_atomic_state *dm_state;
> @@ -11175,11 +11175,11 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
>   
>   static int dm_force_atomic_commit(struct drm_connector *connector)
>   {
>   	int ret = 0;
>   	struct drm_device *ddev = connector->dev;
> -	struct drm_atomic_state *state = drm_atomic_state_alloc(ddev);
> +	struct drm_atomic_commit *state = drm_atomic_commit_alloc(ddev);
>   	struct amdgpu_crtc *disconnected_acrtc = to_amdgpu_crtc(connector->encoder->crtc);
>   	struct drm_plane *plane = disconnected_acrtc->base.primary;
>   	struct drm_connector_state *conn_state;
>   	struct drm_crtc_state *crtc_state;
>   	struct drm_plane_state *plane_state;
> @@ -11190,21 +11190,21 @@ static int dm_force_atomic_commit(struct drm_connector *connector)
>   	state->acquire_ctx = ddev->mode_config.acquire_ctx;
>   
>   	/* Construct an atomic state to restore previous display setting */
>   
>   	/*
> -	 * Attach connectors to drm_atomic_state
> +	 * Attach connectors to drm_atomic_commit
>   	 */
>   	conn_state = drm_atomic_get_connector_state(state, connector);
>   
>   	/* Check for error in getting connector state */
>   	if (IS_ERR(conn_state)) {
>   		ret = PTR_ERR(conn_state);
>   		goto out;
>   	}
>   
> -	/* Attach crtc to drm_atomic_state*/
> +	/* Attach crtc to drm_atomic_commit*/
>   	crtc_state = drm_atomic_get_crtc_state(state, &disconnected_acrtc->base);
>   
>   	/* Check for error in getting crtc state */
>   	if (IS_ERR(crtc_state)) {
>   		ret = PTR_ERR(crtc_state);
> @@ -11212,11 +11212,11 @@ static int dm_force_atomic_commit(struct drm_connector *connector)
>   	}
>   
>   	/* force a restore */
>   	crtc_state->mode_changed = true;
>   
> -	/* Attach plane to drm_atomic_state */
> +	/* Attach plane to drm_atomic_commit */
>   	plane_state = drm_atomic_get_plane_state(state, plane);
>   
>   	/* Check for error in getting plane state */
>   	if (IS_ERR(plane_state)) {
>   		ret = PTR_ERR(plane_state);
> @@ -11225,11 +11225,11 @@ static int dm_force_atomic_commit(struct drm_connector *connector)
>   
>   	/* Call commit internally with the state we just constructed */
>   	ret = drm_atomic_commit(state);
>   
>   out:
> -	drm_atomic_state_put(state);
> +	drm_atomic_commit_put(state);
>   	if (ret)
>   		drm_err(ddev, "Restoring old state failed with %i\n", ret);
>   
>   	return ret;
>   }
> @@ -11274,11 +11274,11 @@ void dm_restore_drm_connector_state(struct drm_device *dev,
>   /*
>    * Grabs all modesetting locks to serialize against any blocking commits,
>    * Waits for completion of all non blocking commits.
>    */
>   static int do_aquire_global_lock(struct drm_device *dev,
> -				 struct drm_atomic_state *state)
> +				 struct drm_atomic_commit *state)
>   {
>   	struct drm_crtc *crtc;
>   	struct drm_crtc_commit *commit;
>   	long ret;
>   
> @@ -11419,11 +11419,11 @@ static void set_freesync_fixed_config(struct dm_crtc_state *dm_new_crtc_state)
>   	res = div_u64(num, den);
>   	dm_new_crtc_state->freesync_config.fixed_refresh_in_uhz = res;
>   }
>   
>   static int dm_update_crtc_state(struct amdgpu_display_manager *dm,
> -			 struct drm_atomic_state *state,
> +			 struct drm_atomic_commit *state,
>   			 struct drm_crtc *crtc,
>   			 struct drm_crtc_state *old_crtc_state,
>   			 struct drm_crtc_state *new_crtc_state,
>   			 bool enable,
>   			 bool *lock_and_validation_needed)
> @@ -11693,11 +11693,11 @@ static int dm_update_crtc_state(struct amdgpu_display_manager *dm,
>   	if (new_stream)
>   		dc_stream_release(new_stream);
>   	return ret;
>   }
>   
> -static bool should_reset_plane(struct drm_atomic_state *state,
> +static bool should_reset_plane(struct drm_atomic_commit *state,
>   			       struct drm_plane *plane,
>   			       struct drm_plane_state *old_plane_state,
>   			       struct drm_plane_state *new_plane_state)
>   {
>   	struct drm_plane *other;
> @@ -11951,11 +11951,11 @@ static int dm_check_native_cursor_state(struct drm_crtc *new_plane_crtc,
>   	}
>   
>   	return 0;
>   }
>   
> -static bool dm_should_update_native_cursor(struct drm_atomic_state *state,
> +static bool dm_should_update_native_cursor(struct drm_atomic_commit *state,
>   					   struct drm_crtc *old_plane_crtc,
>   					   struct drm_crtc *new_plane_crtc,
>   					   bool enable)
>   {
>   	struct drm_crtc_state *old_crtc_state, *new_crtc_state;
> @@ -11981,11 +11981,11 @@ static bool dm_should_update_native_cursor(struct drm_atomic_state *state,
>   		return dm_new_crtc_state->cursor_mode == DM_CURSOR_NATIVE_MODE;
>   	}
>   }
>   
>   static int dm_update_plane_state(struct dc *dc,
> -				 struct drm_atomic_state *state,
> +				 struct drm_atomic_commit *state,
>   				 struct drm_plane *plane,
>   				 struct drm_plane_state *old_plane_state,
>   				 struct drm_plane_state *new_plane_state,
>   				 bool enable,
>   				 bool *lock_and_validation_needed,
> @@ -12189,11 +12189,11 @@ dm_get_plane_scale(struct drm_plane_state *plane_state,
>    * between enabled/disabled planes in the atomic state. We need a unique value
>    * so that the iterator will not generate the same object twice, or loop
>    * indefinitely.
>    */
>   static inline struct __drm_planes_state *__get_next_zpos(
> -	struct drm_atomic_state *state,
> +	struct drm_atomic_commit *state,
>   	struct __drm_planes_state *prev)
>   {
>   	unsigned int highest_zpos = 0, prev_zpos = 256;
>   	uint32_t highest_id = 0, prev_id = UINT_MAX;
>   	struct drm_plane_state *new_plane_state;
> @@ -12239,11 +12239,11 @@ static inline struct __drm_planes_state *__get_next_zpos(
>   		for_each_if(((plane) = __i->ptr,				\
>   			     (void)(plane) /* Only to avoid unused-but-set-variable warning */, \
>   			     (old_plane_state) = __i->old_state,		\
>   			     (new_plane_state) = __i->new_state, 1))
>   
> -static int add_affected_mst_dsc_crtcs(struct drm_atomic_state *state, struct drm_crtc *crtc)
> +static int add_affected_mst_dsc_crtcs(struct drm_atomic_commit *state, struct drm_crtc *crtc)
>   {
>   	struct drm_connector *connector;
>   	struct drm_connector_state *conn_state, *old_conn_state;
>   	struct amdgpu_dm_connector *aconnector = NULL;
>   	int i;
> @@ -12306,11 +12306,11 @@ static int add_affected_mst_dsc_crtcs(struct drm_atomic_state *state, struct drm
>    *
>    * Return: 0 on success, or an error code if getting the cursor plane state
>    * failed.
>    */
>   static int dm_crtc_get_cursor_mode(struct amdgpu_device *adev,
> -				   struct drm_atomic_state *state,
> +				   struct drm_atomic_commit *state,
>   				   struct dm_crtc_state *dm_crtc_state,
>   				   enum amdgpu_dm_cursor_mode *cursor_mode)
>   {
>   	struct drm_plane_state *old_plane_state, *plane_state, *cursor_state;
>   	struct drm_crtc_state *crtc_state = &dm_crtc_state->base;
> @@ -12433,11 +12433,11 @@ static int dm_crtc_get_cursor_mode(struct amdgpu_device *adev,
>   
>   	return 0;
>   }
>   
>   static bool amdgpu_dm_crtc_mem_type_changed(struct drm_device *dev,
> -					    struct drm_atomic_state *state,
> +					    struct drm_atomic_commit *state,
>   					    struct drm_crtc_state *crtc_state)
>   {
>   	struct drm_plane *plane;
>   	struct drm_plane_state *new_plane_state, *old_plane_state;
>   
> @@ -12482,11 +12482,11 @@ static bool amdgpu_dm_crtc_mem_type_changed(struct drm_device *dev,
>    * be possible but non-trivial - a possible TODO item.
>    *
>    * Return: -Error code if validation failed.
>    */
>   static int amdgpu_dm_atomic_check(struct drm_device *dev,
> -				  struct drm_atomic_state *state)
> +				  struct drm_atomic_commit *state)
>   {
>   	struct amdgpu_device *adev = drm_to_adev(dev);
>   	struct dm_atomic_state *dm_state = NULL;
>   	struct dc *dc = adev->dm.dc;
>   	struct drm_connector *connector;
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> index d1a14e0c12bd4e497d16100f6522f69303f31a06..981bed8bbb506529db83c14dc9a0b0b10817a58c 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> @@ -596,11 +596,11 @@ struct amdgpu_display_manager {
>   	 *
>   	 * Periodic work for idle events.
>   	 */
>   	struct idle_workqueue *idle_workqueue;
>   
> -	struct drm_atomic_state *cached_state;
> +	struct drm_atomic_commit *cached_state;
>   	struct dc_state *cached_dc_state;
>   
>   	struct dm_compressor_info compressor;
>   
>   	const struct firmware *fw_dmcu;
> @@ -1130,15 +1130,15 @@ struct dc_stream_state *
>   	create_validate_stream_for_sink(struct drm_connector *connector,
>   					const struct drm_display_mode *drm_mode,
>   					const struct dm_connector_state *dm_state,
>   					const struct dc_stream_state *old_stream);
>   
> -int dm_atomic_get_state(struct drm_atomic_state *state,
> +int dm_atomic_get_state(struct drm_atomic_commit *state,
>   			struct dm_atomic_state **dm_state);
>   
>   struct drm_connector *
> -amdgpu_dm_find_first_crtc_matching_connector(struct drm_atomic_state *state,
> +amdgpu_dm_find_first_crtc_matching_connector(struct drm_atomic_commit *state,
>   					     struct drm_crtc *crtc);
>   
>   int convert_dc_color_depth_into_bpc(enum dc_color_depth display_color_depth);
>   struct idle_workqueue *idle_create_workqueue(struct amdgpu_device *adev);
>   
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
> index cd1e58b8defcb243e99bd3dd23408c5aa26bb51c..fa6883ae4dfb80abd6ad3ccd0e0dec04e917b753 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
> @@ -1497,11 +1497,11 @@ __set_dm_plane_colorop_degamma(struct drm_plane_state *plane_state,
>   			       struct dc_plane_state *dc_plane_state,
>   			       struct drm_colorop *colorop)
>   {
>   	struct drm_colorop *old_colorop;
>   	struct drm_colorop_state *colorop_state = NULL, *new_colorop_state;
> -	struct drm_atomic_state *state = plane_state->state;
> +	struct drm_atomic_commit *state = plane_state->state;
>   	int i = 0;
>   
>   	old_colorop = colorop;
>   
>   	/* 1st op: 1d curve - degamma */
> @@ -1524,11 +1524,11 @@ __set_dm_plane_colorop_3x4_matrix(struct drm_plane_state *plane_state,
>   				  struct dc_plane_state *dc_plane_state,
>   				  struct drm_colorop *colorop)
>   {
>   	struct drm_colorop *old_colorop;
>   	struct drm_colorop_state *colorop_state = NULL, *new_colorop_state;
> -	struct drm_atomic_state *state = plane_state->state;
> +	struct drm_atomic_commit *state = plane_state->state;
>   	const struct drm_device *dev = colorop->dev;
>   	const struct drm_property_blob *blob;
>   	struct drm_color_ctm_3x4 *ctm = NULL;
>   	int i = 0;
>   
> @@ -1565,11 +1565,11 @@ __set_dm_plane_colorop_multiplier(struct drm_plane_state *plane_state,
>   				  struct dc_plane_state *dc_plane_state,
>   				  struct drm_colorop *colorop)
>   {
>   	struct drm_colorop *old_colorop;
>   	struct drm_colorop_state *colorop_state = NULL, *new_colorop_state;
> -	struct drm_atomic_state *state = plane_state->state;
> +	struct drm_atomic_commit *state = plane_state->state;
>   	const struct drm_device *dev = colorop->dev;
>   	int i = 0;
>   
>   	/* Multiplier */
>   	old_colorop = colorop;
> @@ -1594,11 +1594,11 @@ __set_dm_plane_colorop_shaper(struct drm_plane_state *plane_state,
>   			      struct dc_plane_state *dc_plane_state,
>   			      struct drm_colorop *colorop)
>   {
>   	struct drm_colorop *old_colorop;
>   	struct drm_colorop_state *colorop_state = NULL, *new_colorop_state;
> -	struct drm_atomic_state *state = plane_state->state;
> +	struct drm_atomic_commit *state = plane_state->state;
>   	enum dc_transfer_func_predefined default_tf = TRANSFER_FUNCTION_LINEAR;
>   	struct dc_transfer_func *tf = &dc_plane_state->in_shaper_func;
>   	const struct drm_color_lut32 *shaper_lut;
>   	struct drm_device *dev = colorop->dev;
>   	bool enabled = false;
> @@ -1702,11 +1702,11 @@ __set_dm_plane_colorop_3dlut(struct drm_plane_state *plane_state,
>   			     struct drm_colorop *colorop)
>   {
>   	struct drm_colorop *old_colorop;
>   	struct drm_colorop_state *colorop_state = NULL, *new_colorop_state;
>   	struct dc_transfer_func *tf = &dc_plane_state->in_shaper_func;
> -	struct drm_atomic_state *state = plane_state->state;
> +	struct drm_atomic_commit *state = plane_state->state;
>   	const struct amdgpu_device *adev = drm_to_adev(colorop->dev);
>   	bool has_3dlut = adev->dm.dc->caps.color.dpp.hw_3d_lut || adev->dm.dc->caps.color.mpc.preblend;
>   	const struct drm_device *dev = colorop->dev;
>   	const struct drm_color_lut32 *lut3d;
>   	uint32_t lut3d_size;
> @@ -1757,11 +1757,11 @@ __set_dm_plane_colorop_blend(struct drm_plane_state *plane_state,
>   			     struct dc_plane_state *dc_plane_state,
>   			     struct drm_colorop *colorop)
>   {
>   	struct drm_colorop *old_colorop;
>   	struct drm_colorop_state *colorop_state = NULL, *new_colorop_state;
> -	struct drm_atomic_state *state = plane_state->state;
> +	struct drm_atomic_commit *state = plane_state->state;
>   	enum dc_transfer_func_predefined default_tf = TRANSFER_FUNCTION_LINEAR;
>   	struct dc_transfer_func *tf = &dc_plane_state->blend_tf;
>   	const struct drm_color_lut32 *blend_lut = NULL;
>   	struct drm_device *dev = colorop->dev;
>   	uint32_t blend_size = 0;
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
> index 82727f6ec469a0e6dbb3ef59a017fa80095d457a..5eb94fa559f8a69d68825c8bae232d225066b8b8 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
> @@ -595,11 +595,11 @@ static void amdgpu_dm_crtc_helper_disable(struct drm_crtc *crtc)
>   {
>   }
>   
>   static int amdgpu_dm_crtc_count_crtc_active_planes(struct drm_crtc_state *new_crtc_state)
>   {
> -	struct drm_atomic_state *state = new_crtc_state->state;
> +	struct drm_atomic_commit *state = new_crtc_state->state;
>   	struct drm_plane *plane;
>   	int num_active = 0;
>   
>   	drm_for_each_plane_mask(plane, state->dev, new_crtc_state->plane_mask) {
>   		struct drm_plane_state *new_plane_state;
> @@ -648,11 +648,11 @@ static bool amdgpu_dm_crtc_helper_mode_fixup(struct drm_crtc *crtc,
>   {
>   	return true;
>   }
>   
>   static int amdgpu_dm_crtc_helper_atomic_check(struct drm_crtc *crtc,
> -					      struct drm_atomic_state *state)
> +					      struct drm_atomic_commit *state)
>   {
>   	struct drm_crtc_state *crtc_state = drm_atomic_get_new_crtc_state(state,
>   										crtc);
>   	struct amdgpu_device *adev = drm_to_adev(crtc->dev);
>   	struct dc *dc = adev->dm.dc;
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> index 5d8c4c7020b141a8760828ed70b8cb1ab0273fdf..ff26397f878a968fc20179b2a69c74792f9ef2f9 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> @@ -495,11 +495,11 @@ static int dm_dp_mst_get_modes(struct drm_connector *connector)
>   	return ret;
>   }
>   
>   static struct drm_encoder *
>   dm_mst_atomic_best_encoder(struct drm_connector *connector,
> -			   struct drm_atomic_state *state)
> +			   struct drm_atomic_commit *state)
>   {
>   	struct drm_connector_state *connector_state = drm_atomic_get_new_connector_state(state,
>   											 connector);
>   	struct amdgpu_device *adev = drm_to_adev(connector->dev);
>   	struct amdgpu_crtc *acrtc = to_amdgpu_crtc(connector_state->crtc);
> @@ -577,11 +577,11 @@ dm_dp_mst_detect(struct drm_connector *connector,
>   
>   	return connection_status;
>   }
>   
>   static int dm_dp_mst_atomic_check(struct drm_connector *connector,
> -				  struct drm_atomic_state *state)
> +				  struct drm_atomic_commit *state)
>   {
>   	struct amdgpu_dm_connector *aconnector = to_amdgpu_dm_connector(connector);
>   	struct drm_dp_mst_topology_mgr *mst_mgr = &aconnector->mst_root->mst_mgr;
>   	struct drm_dp_mst_port *mst_port = aconnector->mst_output_port;
>   
> @@ -984,11 +984,11 @@ static int bpp_x16_from_pbn(struct dsc_mst_fairness_params param, int pbn)
>   			&dsc_config);
>   
>   	return dsc_config.bits_per_pixel;
>   }
>   
> -static int increase_dsc_bpp(struct drm_atomic_state *state,
> +static int increase_dsc_bpp(struct drm_atomic_commit *state,
>   			    struct drm_dp_mst_topology_state *mst_state,
>   			    struct dc_link *dc_link,
>   			    struct dsc_mst_fairness_params *params,
>   			    struct dsc_mst_fairness_vars *vars,
>   			    int count,
> @@ -1088,11 +1088,11 @@ static int increase_dsc_bpp(struct drm_atomic_state *state,
>   		remaining_to_increase--;
>   	}
>   	return 0;
>   }
>   
> -static int try_disable_dsc(struct drm_atomic_state *state,
> +static int try_disable_dsc(struct drm_atomic_commit *state,
>   			   struct dc_link *dc_link,
>   			   struct dsc_mst_fairness_params *params,
>   			   struct dsc_mst_fairness_vars *vars,
>   			   int count,
>   			   int k)
> @@ -1181,11 +1181,11 @@ static void log_dsc_params(int count, struct dsc_mst_fairness_vars *vars, int k)
>   	for (i = 0; i < count; i++)
>   		DRM_DEBUG_DRIVER("MST_DSC DSC params: stream #%d --- dsc_enabled = %d, bpp_x16 = %d, pbn = %d\n",
>   				 i, vars[i + k].dsc_enabled, vars[i + k].bpp_x16, vars[i + k].pbn);
>   }
>   
> -static int compute_mst_dsc_configs_for_link(struct drm_atomic_state *state,
> +static int compute_mst_dsc_configs_for_link(struct drm_atomic_commit *state,
>   					    struct dc_state *dc_state,
>   					    struct dc_link *dc_link,
>   					    struct dsc_mst_fairness_vars *vars,
>   					    struct drm_dp_mst_topology_mgr *mgr,
>   					    int *link_vars_start_index)
> @@ -1346,11 +1346,11 @@ static int compute_mst_dsc_configs_for_link(struct drm_atomic_state *state,
>   
>   	return 0;
>   }
>   
>   static bool is_dsc_need_re_compute(
> -	struct drm_atomic_state *state,
> +	struct drm_atomic_commit *state,
>   	struct dc_state *dc_state,
>   	struct dc_link *dc_link)
>   {
>   	int i, j;
>   	bool is_dsc_need_re_compute = false;
> @@ -1477,11 +1477,11 @@ static bool is_dsc_need_re_compute(
>   			 __func__, is_dsc_need_re_compute ? "required" : "not required");
>   
>   	return is_dsc_need_re_compute;
>   }
>   
> -int compute_mst_dsc_configs_for_state(struct drm_atomic_state *state,
> +int compute_mst_dsc_configs_for_state(struct drm_atomic_commit *state,
>   				      struct dc_state *dc_state,
>   				      struct dsc_mst_fairness_vars *vars)
>   {
>   	int i, j;
>   	struct dc_stream_state *stream;
> @@ -1547,11 +1547,11 @@ int compute_mst_dsc_configs_for_state(struct drm_atomic_state *state,
>   	}
>   
>   	return ret;
>   }
>   
> -static int pre_compute_mst_dsc_configs_for_state(struct drm_atomic_state *state,
> +static int pre_compute_mst_dsc_configs_for_state(struct drm_atomic_commit *state,
>   						 struct dc_state *dc_state,
>   						 struct dsc_mst_fairness_vars *vars)
>   {
>   	int i, j;
>   	struct dc_stream_state *stream;
> @@ -1600,11 +1600,11 @@ static int pre_compute_mst_dsc_configs_for_state(struct drm_atomic_state *state,
>   	}
>   
>   	return ret;
>   }
>   
> -static int find_crtc_index_in_state_by_stream(struct drm_atomic_state *state,
> +static int find_crtc_index_in_state_by_stream(struct drm_atomic_commit *state,
>   					      struct dc_stream_state *stream)
>   {
>   	int i;
>   	struct drm_crtc *crtc;
>   	struct drm_crtc_state *new_state, *old_state;
> @@ -1631,11 +1631,11 @@ static bool is_link_to_dschub(struct dc_link *dc_link)
>   	      dsc_caps->fields.dsc_support.DSC_PASSTHROUGH_SUPPORT))
>   		return false;
>   	return true;
>   }
>   
> -static bool is_dsc_precompute_needed(struct drm_atomic_state *state)
> +static bool is_dsc_precompute_needed(struct drm_atomic_commit *state)
>   {
>   	int i;
>   	struct drm_crtc *crtc;
>   	struct drm_crtc_state *old_crtc_state, *new_crtc_state;
>   	bool ret = false;
> @@ -1652,11 +1652,11 @@ static bool is_dsc_precompute_needed(struct drm_atomic_state *state)
>   				ret = true;
>   	}
>   	return ret;
>   }
>   
> -int pre_validate_dsc(struct drm_atomic_state *state,
> +int pre_validate_dsc(struct drm_atomic_commit *state,
>   		     struct dm_atomic_state **dm_state_ptr,
>   		     struct dsc_mst_fairness_vars *vars)
>   {
>   	int i;
>   	struct dm_atomic_state *dm_state;
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.h
> index 6f7ea684b555f7b4ff03df6c2f16317932673d5a..0e8eef5bdb743b01be52100e49529f8ddec58389 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.h
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.h
> @@ -78,17 +78,17 @@ struct dsc_mst_fairness_vars {
>   	bool dsc_enabled;
>   	int bpp_x16;
>   	struct amdgpu_dm_connector *aconnector;
>   };
>   
> -int compute_mst_dsc_configs_for_state(struct drm_atomic_state *state,
> +int compute_mst_dsc_configs_for_state(struct drm_atomic_commit *state,
>   				      struct dc_state *dc_state,
>   				      struct dsc_mst_fairness_vars *vars);
>   
>   bool needs_dsc_aux_workaround(struct dc_link *link);
>   
> -int pre_validate_dsc(struct drm_atomic_state *state,
> +int pre_validate_dsc(struct drm_atomic_commit *state,
>   		     struct dm_atomic_state **dm_state_ptr,
>   		     struct dsc_mst_fairness_vars *vars);
>   
>   enum dc_status dm_dp_mst_is_port_support_mode(
>   	struct amdgpu_dm_connector *aconnector,
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> index 54ae1c371511f8f01f04c10891a90e16afced780..827904c46d7e33ac0c1cd389d4a539039acf8c08 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> @@ -1227,11 +1227,11 @@ int amdgpu_dm_plane_fill_dc_scaling_info(struct amdgpu_device *adev,
>   
>   	return 0;
>   }
>   
>   static int amdgpu_dm_plane_atomic_check(struct drm_plane *plane,
> -					struct drm_atomic_state *state)
> +					struct drm_atomic_commit *state)
>   {
>   	struct drm_plane_state *new_plane_state = drm_atomic_get_new_plane_state(state,
>   										 plane);
>   	struct amdgpu_device *adev = drm_to_adev(plane->dev);
>   	struct dc *dc = adev->dm.dc;
> @@ -1274,11 +1274,11 @@ static int amdgpu_dm_plane_atomic_check(struct drm_plane *plane,
>   
>   	return -EINVAL;
>   }
>   
>   static int amdgpu_dm_plane_atomic_async_check(struct drm_plane *plane,
> -					      struct drm_atomic_state *state, bool flip)
> +					      struct drm_atomic_commit *state, bool flip)
>   {
>   	struct drm_crtc_state *new_crtc_state;
>   	struct drm_plane_state *new_plane_state;
>   	struct dm_crtc_state *dm_new_crtc_state;
>   
> @@ -1415,11 +1415,11 @@ void amdgpu_dm_plane_handle_cursor_update(struct drm_plane *plane,
>   		mutex_unlock(&adev->dm.dc_lock);
>   	}
>   }
>   
>   static void amdgpu_dm_plane_atomic_async_update(struct drm_plane *plane,
> -						struct drm_atomic_state *state)
> +						struct drm_atomic_commit *state)
>   {
>   	struct drm_plane_state *new_state = drm_atomic_get_new_plane_state(state,
>   									   plane);
>   	struct drm_plane_state *old_state =
>   		drm_atomic_get_old_plane_state(state, plane);
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_trace.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_trace.h
> index aa56fd6d56c349bd50b35e8e95e3e19d277a2c43..15791673a33c39cc4ec5ed72f2ea8b4c56d13acc 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_trace.h
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_trace.h
> @@ -106,11 +106,11 @@ TRACE_EVENT(amdgpu_dm_connector_atomic_check,
>   	    TP_ARGS(state),
>   
>   	    TP_STRUCT__entry(
>   			     __field(uint32_t, conn_id)
>   			     __field(const struct drm_connector_state *, conn_state)
> -			     __field(const struct drm_atomic_state *, state)
> +			     __field(const struct drm_atomic_commit *, state)
>   			     __field(const struct drm_crtc_commit *, commit)
>   			     __field(uint32_t, crtc_id)
>   			     __field(uint32_t, best_encoder_id)
>   			     __field(enum drm_link_status, link_status)
>   			     __field(bool, self_refresh_aware)
> @@ -161,11 +161,11 @@ TRACE_EVENT(amdgpu_dm_connector_atomic_check,
>   TRACE_EVENT(amdgpu_dm_crtc_atomic_check,
>   	    TP_PROTO(const struct drm_crtc_state *state),
>   	    TP_ARGS(state),
>   
>   	    TP_STRUCT__entry(
> -			     __field(const struct drm_atomic_state *, state)
> +			     __field(const struct drm_atomic_commit *, state)
>   			     __field(const struct drm_crtc_state *, crtc_state)
>   			     __field(const struct drm_crtc_commit *, commit)
>   			     __field(uint32_t, crtc_id)
>   			     __field(bool, enable)
>   			     __field(bool, active)
> @@ -227,11 +227,11 @@ DECLARE_EVENT_CLASS(amdgpu_dm_plane_state_template,
>   	    TP_ARGS(state),
>   	    TP_STRUCT__entry(
>   			     __field(uint32_t, plane_id)
>   			     __field(enum drm_plane_type, plane_type)
>   			     __field(const struct drm_plane_state *, plane_state)
> -			     __field(const struct drm_atomic_state *, state)
> +			     __field(const struct drm_atomic_commit *, state)
>   			     __field(uint32_t, crtc_id)
>   			     __field(uint32_t, fb_id)
>   			     __field(uint32_t, fb_format)
>   			     __field(uint8_t, fb_planes)
>   			     __field(uint64_t, fb_modifier)
> @@ -313,15 +313,15 @@ DEFINE_EVENT(amdgpu_dm_plane_state_template, amdgpu_dm_plane_atomic_check,
>   DEFINE_EVENT(amdgpu_dm_plane_state_template, amdgpu_dm_atomic_update_cursor,
>   	     TP_PROTO(const struct drm_plane_state *state),
>   	     TP_ARGS(state));
>   
>   TRACE_EVENT(amdgpu_dm_atomic_state_template,
> -	    TP_PROTO(const struct drm_atomic_state *state),
> +	    TP_PROTO(const struct drm_atomic_commit *state),
>   	    TP_ARGS(state),
>   
>   	    TP_STRUCT__entry(
> -			     __field(const struct drm_atomic_state *, state)
> +			     __field(const struct drm_atomic_commit *, state)
>   			     __field(bool, allow_modeset)
>   			     __field(bool, legacy_cursor_update)
>   			     __field(bool, async_update)
>   			     __field(bool, duplicated)
>   			     __field(int, num_connector)
> @@ -345,27 +345,27 @@ TRACE_EVENT(amdgpu_dm_atomic_state_template,
>   		      __entry->async_update, __entry->duplicated, __entry->num_connector,
>   		      __entry->num_private_objs)
>   );
>   
>   DEFINE_EVENT(amdgpu_dm_atomic_state_template, amdgpu_dm_atomic_commit_tail_begin,
> -	     TP_PROTO(const struct drm_atomic_state *state),
> +	     TP_PROTO(const struct drm_atomic_commit *state),
>   	     TP_ARGS(state));
>   
>   DEFINE_EVENT(amdgpu_dm_atomic_state_template, amdgpu_dm_atomic_commit_tail_finish,
> -	     TP_PROTO(const struct drm_atomic_state *state),
> +	     TP_PROTO(const struct drm_atomic_commit *state),
>   	     TP_ARGS(state));
>   
>   DEFINE_EVENT(amdgpu_dm_atomic_state_template, amdgpu_dm_atomic_check_begin,
> -	     TP_PROTO(const struct drm_atomic_state *state),
> +	     TP_PROTO(const struct drm_atomic_commit *state),
>   	     TP_ARGS(state));
>   
>   TRACE_EVENT(amdgpu_dm_atomic_check_finish,
> -	    TP_PROTO(const struct drm_atomic_state *state, int res),
> +	    TP_PROTO(const struct drm_atomic_commit *state, int res),
>   	    TP_ARGS(state, res),
>   
>   	    TP_STRUCT__entry(
> -			     __field(const struct drm_atomic_state *, state)
> +			     __field(const struct drm_atomic_commit *, state)
>   			     __field(int, res)
>   			     __field(bool, async_update)
>   			     __field(bool, allow_modeset)
>   	    ),
>   
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c b/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
> index 714af5c889d742144113f6d86c79b009d6a19384..e8cb782a6f8ed19d75fc94ed0cf813427b61ef8b 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
> @@ -73,11 +73,11 @@ static void komeda_crtc_update_clock_ratio(struct komeda_crtc_state *kcrtc_st)
>    * RETURNS:
>    * Zero for success or -errno
>    */
>   static int
>   komeda_crtc_atomic_check(struct drm_crtc *crtc,
> -			 struct drm_atomic_state *state)
> +			 struct drm_atomic_commit *state)
>   {
>   	struct drm_crtc_state *crtc_state = drm_atomic_get_new_crtc_state(state,
>   									  crtc);
>   	struct komeda_crtc *kcrtc = to_kcrtc(crtc);
>   	struct komeda_crtc_state *kcrtc_st = to_kcrtc_st(crtc_state);
> @@ -277,11 +277,11 @@ komeda_crtc_do_flush(struct drm_crtc *crtc,
>   	mdev->funcs->flush(mdev, master->id, kcrtc_st->active_pipes);
>   }
>   
>   static void
>   komeda_crtc_atomic_enable(struct drm_crtc *crtc,
> -			  struct drm_atomic_state *state)
> +			  struct drm_atomic_commit *state)
>   {
>   	struct drm_crtc_state *old = drm_atomic_get_old_crtc_state(state,
>   								   crtc);
>   	pm_runtime_get_sync(crtc->dev->dev);
>   	komeda_crtc_prepare(to_kcrtc(crtc));
> @@ -323,11 +323,11 @@ komeda_crtc_flush_and_wait_for_flip_done(struct komeda_crtc *kcrtc,
>   	}
>   }
>   
>   static void
>   komeda_crtc_atomic_disable(struct drm_crtc *crtc,
> -			   struct drm_atomic_state *state)
> +			   struct drm_atomic_commit *state)
>   {
>   	struct drm_crtc_state *old = drm_atomic_get_old_crtc_state(state,
>   								   crtc);
>   	struct komeda_crtc *kcrtc = to_kcrtc(crtc);
>   	struct komeda_crtc_state *old_st = to_kcrtc_st(old);
> @@ -385,11 +385,11 @@ komeda_crtc_atomic_disable(struct drm_crtc *crtc,
>   	pm_runtime_put(crtc->dev->dev);
>   }
>   
>   static void
>   komeda_crtc_atomic_flush(struct drm_crtc *crtc,
> -			 struct drm_atomic_state *state)
> +			 struct drm_atomic_commit *state)
>   {
>   	struct drm_crtc_state *crtc_state = drm_atomic_get_new_crtc_state(state,
>   									  crtc);
>   	struct drm_crtc_state *old = drm_atomic_get_old_crtc_state(state,
>   								   crtc);
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_kms.c b/drivers/gpu/drm/arm/display/komeda/komeda_kms.c
> index 6ed504099188714e86d75abbeda4c194f5a42299..faa8b041373a71c19ff03d4dd8c07008ecf46981 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_kms.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_kms.c
> @@ -65,11 +65,11 @@ static const struct drm_driver komeda_kms_driver = {
>   	.desc = "Arm Komeda Display Processor driver",
>   	.major = 0,
>   	.minor = 1,
>   };
>   
> -static void komeda_kms_atomic_commit_hw_done(struct drm_atomic_state *state)
> +static void komeda_kms_atomic_commit_hw_done(struct drm_atomic_commit *state)
>   {
>   	struct drm_device *dev = state->dev;
>   	struct komeda_kms_dev *kms = to_kdev(dev);
>   	int i;
>   
> @@ -84,11 +84,11 @@ static void komeda_kms_atomic_commit_hw_done(struct drm_atomic_state *state)
>   		}
>   	}
>   	drm_atomic_helper_commit_hw_done(state);
>   }
>   
> -static void komeda_kms_commit_tail(struct drm_atomic_state *old_state)
> +static void komeda_kms_commit_tail(struct drm_atomic_commit *old_state)
>   {
>   	struct drm_device *dev = old_state->dev;
>   	bool fence_cookie = dma_fence_begin_signalling();
>   
>   	drm_atomic_helper_commit_modeset_disables(dev, old_state);
> @@ -151,11 +151,11 @@ static int komeda_plane_state_list_add(struct drm_plane_state *plane_st,
>   }
>   
>   static int komeda_crtc_normalize_zpos(struct drm_crtc *crtc,
>   				      struct drm_crtc_state *crtc_st)
>   {
> -	struct drm_atomic_state *state = crtc_st->state;
> +	struct drm_atomic_commit *state = crtc_st->state;
>   	struct komeda_crtc *kcrtc = to_kcrtc(crtc);
>   	struct komeda_crtc_state *kcrtc_st = to_kcrtc_st(crtc_st);
>   	struct komeda_plane_state *kplane_st;
>   	struct drm_plane_state *plane_st;
>   	struct drm_plane *plane;
> @@ -214,11 +214,11 @@ static int komeda_crtc_normalize_zpos(struct drm_crtc *crtc,
>   
>   	return 0;
>   }
>   
>   static int komeda_kms_check(struct drm_device *dev,
> -			    struct drm_atomic_state *state)
> +			    struct drm_atomic_commit *state)
>   {
>   	struct drm_crtc *crtc;
>   	struct drm_crtc_state *new_crtc_st;
>   	int i, err;
>   
> @@ -226,11 +226,11 @@ static int komeda_kms_check(struct drm_device *dev,
>   	if (err)
>   		return err;
>   
>   	/* Komeda need to re-calculate resource assumption in every commit
>   	 * so need to add all affected_planes (even unchanged) to
> -	 * drm_atomic_state.
> +	 * drm_atomic_commit.
>   	 */
>   	for_each_new_crtc_in_state(state, crtc, new_crtc_st, i) {
>   		err = drm_atomic_add_affected_planes(state, crtc);
>   		if (err)
>   			return err;
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
> index bbee6da43164f7cc32340ff4479d99609c18db7e..955f9f683ce3145a41f4e28f689186d327a9b32a 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
> @@ -153,11 +153,11 @@ struct komeda_component_output {
>    * component_state is the data flow configuration of the component, and it's
>    * the superclass of all specific component_state like @komeda_layer_state,
>    * @komeda_scaler_state
>    */
>   struct komeda_component_state {
> -	/** @obj: tracking component_state by drm_atomic_state */
> +	/** @obj: tracking component_state by drm_atomic_commit */
>   	struct drm_private_state obj;
>   	/** @component: backpointer to the component */
>   	struct komeda_component *component;
>   	/**
>   	 * @binding_user:
> @@ -386,11 +386,11 @@ struct komeda_pipeline_funcs {
>    * struct komeda_pipeline
>    *
>    * Represent a complete display pipeline and hold all functional components.
>    */
>   struct komeda_pipeline {
> -	/** @obj: link pipeline as private obj of drm_atomic_state */
> +	/** @obj: link pipeline as private obj of drm_atomic_commit */
>   	struct drm_private_obj obj;
>   	/** @mdev: the parent komeda_dev */
>   	struct komeda_dev *mdev;
>   	/** @pxlclk: pixel clock */
>   	struct clk *pxlclk;
> @@ -446,14 +446,14 @@ struct komeda_pipeline {
>   /**
>    * struct komeda_pipeline_state
>    *
>    * NOTE:
>    * Unlike the pipeline, pipeline_state doesn’t gather any component_state
> - * into it. It because all component will be managed by drm_atomic_state.
> + * into it. It because all component will be managed by drm_atomic_commit.
>    */
>   struct komeda_pipeline_state {
> -	/** @obj: tracking pipeline_state by drm_atomic_state */
> +	/** @obj: tracking pipeline_state by drm_atomic_commit */
>   	struct drm_private_state obj;
>   	/** @pipe: backpointer to the pipeline */
>   	struct komeda_pipeline *pipe;
>   	/** @crtc: currently bound crtc */
>   	struct drm_crtc *crtc;
> @@ -553,15 +553,15 @@ int komeda_build_wb_split_data_flow(struct komeda_layer *wb_layer,
>   int komeda_release_unclaimed_resources(struct komeda_pipeline *pipe,
>   				       struct komeda_crtc_state *kcrtc_st);
>   
>   struct komeda_pipeline_state *
>   komeda_pipeline_get_old_state(struct komeda_pipeline *pipe,
> -			      struct drm_atomic_state *state);
> +			      struct drm_atomic_commit *state);
>   bool komeda_pipeline_disable(struct komeda_pipeline *pipe,
> -			     struct drm_atomic_state *old_state);
> +			     struct drm_atomic_commit *old_state);
>   void komeda_pipeline_update(struct komeda_pipeline *pipe,
> -			    struct drm_atomic_state *old_state);
> +			    struct drm_atomic_commit *old_state);
>   
>   void komeda_complete_data_flow_cfg(struct komeda_layer *layer,
>   				   struct komeda_data_flow_cfg *dflow,
>   				   struct drm_framebuffer *fb);
>   
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
> index 6f9b10cc831ff748296b9ed30b6de398c90c4786..457b21397014cf64a97efac5152b797bfd7c9e6e 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
> @@ -20,11 +20,11 @@ static inline bool is_switching_user(void *old, void *new)
>   	return old != new;
>   }
>   
>   static struct komeda_pipeline_state *
>   komeda_pipeline_get_state(struct komeda_pipeline *pipe,
> -			  struct drm_atomic_state *state)
> +			  struct drm_atomic_commit *state)
>   {
>   	struct drm_private_state *priv_st;
>   
>   	priv_st = drm_atomic_get_private_obj_state(state, &pipe->obj);
>   	if (IS_ERR(priv_st))
> @@ -33,11 +33,11 @@ komeda_pipeline_get_state(struct komeda_pipeline *pipe,
>   	return priv_to_pipe_st(priv_st);
>   }
>   
>   struct komeda_pipeline_state *
>   komeda_pipeline_get_old_state(struct komeda_pipeline *pipe,
> -			      struct drm_atomic_state *state)
> +			      struct drm_atomic_commit *state)
>   {
>   	struct drm_private_state *priv_st;
>   
>   	priv_st = drm_atomic_get_old_private_obj_state(state, &pipe->obj);
>   	if (priv_st)
> @@ -45,11 +45,11 @@ komeda_pipeline_get_old_state(struct komeda_pipeline *pipe,
>   	return NULL;
>   }
>   
>   static struct komeda_pipeline_state *
>   komeda_pipeline_get_new_state(struct komeda_pipeline *pipe,
> -			      struct drm_atomic_state *state)
> +			      struct drm_atomic_commit *state)
>   {
>   	struct drm_private_state *priv_st;
>   
>   	priv_st = drm_atomic_get_new_private_obj_state(state, &pipe->obj);
>   	if (priv_st)
> @@ -58,11 +58,11 @@ komeda_pipeline_get_new_state(struct komeda_pipeline *pipe,
>   }
>   
>   /* Assign pipeline for crtc */
>   static struct komeda_pipeline_state *
>   komeda_pipeline_get_state_and_set_crtc(struct komeda_pipeline *pipe,
> -				       struct drm_atomic_state *state,
> +				       struct drm_atomic_commit *state,
>   				       struct drm_crtc *crtc)
>   {
>   	struct komeda_pipeline_state *st;
>   
>   	st = komeda_pipeline_get_state(pipe, state);
> @@ -95,11 +95,11 @@ komeda_pipeline_get_state_and_set_crtc(struct komeda_pipeline *pipe,
>   	return st;
>   }
>   
>   static struct komeda_component_state *
>   komeda_component_get_state(struct komeda_component *c,
> -			   struct drm_atomic_state *state)
> +			   struct drm_atomic_commit *state)
>   {
>   	struct drm_private_state *priv_st;
>   
>   	WARN_ON(!drm_modeset_is_locked(&c->pipeline->obj.lock));
>   
> @@ -110,11 +110,11 @@ komeda_component_get_state(struct komeda_component *c,
>   	return priv_to_comp_st(priv_st);
>   }
>   
>   static struct komeda_component_state *
>   komeda_component_get_old_state(struct komeda_component *c,
> -			       struct drm_atomic_state *state)
> +			       struct drm_atomic_commit *state)
>   {
>   	struct drm_private_state *priv_st;
>   
>   	priv_st = drm_atomic_get_old_private_obj_state(state, &c->obj);
>   	if (priv_st)
> @@ -147,11 +147,11 @@ komeda_component_get_old_state(struct komeda_component *c,
>    * CRTC. if the pipeline is busy (assigned to another CRTC), even the required
>    * component is free, the component still cannot be assigned to the direct user.
>    */
>   static struct komeda_component_state *
>   komeda_component_get_state_and_set_user(struct komeda_component *c,
> -					struct drm_atomic_state *state,
> +					struct drm_atomic_commit *state,
>   					void *user,
>   					struct drm_crtc *crtc)
>   {
>   	struct komeda_pipeline_state *pipe_st;
>   	struct komeda_component_state *st;
> @@ -251,11 +251,11 @@ komeda_component_validate_private(struct komeda_component *c,
>   }
>   
>   /* Get current available scaler from the component->supported_outputs */
>   static struct komeda_scaler *
>   komeda_component_get_avail_scaler(struct komeda_component *c,
> -				  struct drm_atomic_state *state)
> +				  struct drm_atomic_commit *state)
>   {
>   	struct komeda_pipeline_state *pipe_st;
>   	u32 avail_scalers;
>   
>   	pipe_st = komeda_pipeline_get_state(c->pipeline, state);
> @@ -503,11 +503,11 @@ komeda_scaler_check_cfg(struct komeda_scaler *scaler,
>   static int
>   komeda_scaler_validate(void *user,
>   		       struct komeda_crtc_state *kcrtc_st,
>   		       struct komeda_data_flow_cfg *dflow)
>   {
> -	struct drm_atomic_state *drm_st = kcrtc_st->base.state;
> +	struct drm_atomic_commit *drm_st = kcrtc_st->base.state;
>   	struct komeda_component_state *c_st;
>   	struct komeda_scaler_state *st;
>   	struct komeda_scaler *scaler;
>   	int err = 0;
>   
> @@ -667,11 +667,11 @@ void pipeline_composition_size(struct komeda_crtc_state *kcrtc_st,
>   static int
>   komeda_compiz_set_input(struct komeda_compiz *compiz,
>   			struct komeda_crtc_state *kcrtc_st,
>   			struct komeda_data_flow_cfg *dflow)
>   {
> -	struct drm_atomic_state *drm_st = kcrtc_st->base.state;
> +	struct drm_atomic_commit *drm_st = kcrtc_st->base.state;
>   	struct komeda_component_state *c_st, *old_st;
>   	struct komeda_compiz_input_cfg *cin;
>   	u16 compiz_w, compiz_h;
>   	int idx = dflow->blending_zorder;
>   
> @@ -1225,11 +1225,11 @@ int komeda_build_display_data_flow(struct komeda_crtc *kcrtc,
>   
>   static int
>   komeda_pipeline_unbound_components(struct komeda_pipeline *pipe,
>   				   struct komeda_pipeline_state *new)
>   {
> -	struct drm_atomic_state *drm_st = new->obj.state;
> +	struct drm_atomic_commit *drm_st = new->obj.state;
>   	struct komeda_pipeline_state *old = priv_to_pipe_st(pipe->obj.state);
>   	struct komeda_component_state *c_st;
>   	struct komeda_component *c;
>   	u32 id;
>   	unsigned long disabling_comps;
> @@ -1253,11 +1253,11 @@ komeda_pipeline_unbound_components(struct komeda_pipeline *pipe,
>   
>   /* release unclaimed pipeline resource */
>   int komeda_release_unclaimed_resources(struct komeda_pipeline *pipe,
>   				       struct komeda_crtc_state *kcrtc_st)
>   {
> -	struct drm_atomic_state *drm_st = kcrtc_st->base.state;
> +	struct drm_atomic_commit *drm_st = kcrtc_st->base.state;
>   	struct komeda_pipeline_state *st;
>   
>   	/* ignore the pipeline which is not affected */
>   	if (!pipe || !has_bit(pipe->id, kcrtc_st->affected_pipes))
>   		return 0;
> @@ -1283,11 +1283,11 @@ int komeda_release_unclaimed_resources(struct komeda_pipeline *pipe,
>    * RETURNS:
>    * true: disable is not complete, needs a phase 2 disable.
>    * false: disable is complete.
>    */
>   bool komeda_pipeline_disable(struct komeda_pipeline *pipe,
> -			     struct drm_atomic_state *old_state)
> +			     struct drm_atomic_commit *old_state)
>   {
>   	struct komeda_pipeline_state *old;
>   	struct komeda_component *c;
>   	struct komeda_component_state *c_st;
>   	u32 id;
> @@ -1328,11 +1328,11 @@ bool komeda_pipeline_disable(struct komeda_pipeline *pipe,
>   
>   	return old->active_comps ? true : false;
>   }
>   
>   void komeda_pipeline_update(struct komeda_pipeline *pipe,
> -			    struct drm_atomic_state *old_state)
> +			    struct drm_atomic_commit *old_state)
>   {
>   	struct komeda_pipeline_state *new = priv_to_pipe_st(pipe->obj.state);
>   	struct komeda_pipeline_state *old;
>   	struct komeda_component *c;
>   	u32 id;
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_plane.c b/drivers/gpu/drm/arm/display/komeda/komeda_plane.c
> index 835c11fdd7ff5d5f56cd9ae2aa467fa41542b4eb..57a4a0c7d404a961fae4c6a7885fa611344bbea5 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_plane.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_plane.c
> @@ -67,11 +67,11 @@ komeda_plane_init_data_flow(struct drm_plane_state *st,
>    * RETURNS:
>    * Zero for success or -errno
>    */
>   static int
>   komeda_plane_atomic_check(struct drm_plane *plane,
> -			  struct drm_atomic_state *state)
> +			  struct drm_atomic_commit *state)
>   {
>   	struct drm_plane_state *new_plane_state = drm_atomic_get_new_plane_state(state,
>   										 plane);
>   	struct komeda_plane *kplane = to_kplane(plane);
>   	struct komeda_plane_state *kplane_st = to_kplane_st(new_plane_state);
> @@ -114,11 +114,11 @@ komeda_plane_atomic_check(struct drm_plane *plane,
>   /* plane doesn't represent a real HW, so there is no HW update for plane.
>    * komeda handles all the HW update in crtc->atomic_flush
>    */
>   static void
>   komeda_plane_atomic_update(struct drm_plane *plane,
> -			   struct drm_atomic_state *state)
> +			   struct drm_atomic_commit *state)
>   {
>   }
>   
>   static const struct drm_plane_helper_funcs komeda_plane_helper_funcs = {
>   	.atomic_check	= komeda_plane_atomic_check,
> diff --git a/drivers/gpu/drm/arm/hdlcd_crtc.c b/drivers/gpu/drm/arm/hdlcd_crtc.c
> index 4b4a08cb396dd5f59e6bc9daa1110d5308286fe5..8565749a3e48d253c332e61dcf35cad870f04903 100644
> --- a/drivers/gpu/drm/arm/hdlcd_crtc.c
> +++ b/drivers/gpu/drm/arm/hdlcd_crtc.c
> @@ -173,22 +173,22 @@ static void hdlcd_crtc_mode_set_nofb(struct drm_crtc *crtc)
>   
>   	clk_set_rate(hdlcd->clk, m->crtc_clock * 1000);
>   }
>   
>   static void hdlcd_crtc_atomic_enable(struct drm_crtc *crtc,
> -				     struct drm_atomic_state *state)
> +				     struct drm_atomic_commit *state)
>   {
>   	struct hdlcd_drm_private *hdlcd = crtc_to_hdlcd_priv(crtc);
>   
>   	clk_prepare_enable(hdlcd->clk);
>   	hdlcd_crtc_mode_set_nofb(crtc);
>   	hdlcd_write(hdlcd, HDLCD_REG_COMMAND, 1);
>   	drm_crtc_vblank_on(crtc);
>   }
>   
>   static void hdlcd_crtc_atomic_disable(struct drm_crtc *crtc,
> -				      struct drm_atomic_state *state)
> +				      struct drm_atomic_commit *state)
>   {
>   	struct hdlcd_drm_private *hdlcd = crtc_to_hdlcd_priv(crtc);
>   
>   	drm_crtc_vblank_off(crtc);
>   	hdlcd_write(hdlcd, HDLCD_REG_COMMAND, 0);
> @@ -210,11 +210,11 @@ static enum drm_mode_status hdlcd_crtc_mode_valid(struct drm_crtc *crtc,
>   
>   	return MODE_OK;
>   }
>   
>   static void hdlcd_crtc_atomic_begin(struct drm_crtc *crtc,
> -				    struct drm_atomic_state *state)
> +				    struct drm_atomic_commit *state)
>   {
>   	struct drm_pending_vblank_event *event = crtc->state->event;
>   
>   	if (event) {
>   		crtc->state->event = NULL;
> @@ -234,11 +234,11 @@ static const struct drm_crtc_helper_funcs hdlcd_crtc_helper_funcs = {
>   	.atomic_enable	= hdlcd_crtc_atomic_enable,
>   	.atomic_disable	= hdlcd_crtc_atomic_disable,
>   };
>   
>   static int hdlcd_plane_atomic_check(struct drm_plane *plane,
> -				    struct drm_atomic_state *state)
> +				    struct drm_atomic_commit *state)
>   {
>   	struct drm_plane_state *new_plane_state = drm_atomic_get_new_plane_state(state,
>   										 plane);
>   	int i;
>   	struct drm_crtc *crtc;
> @@ -265,11 +265,11 @@ static int hdlcd_plane_atomic_check(struct drm_plane *plane,
>   
>   	return 0;
>   }
>   
>   static void hdlcd_plane_atomic_update(struct drm_plane *plane,
> -				      struct drm_atomic_state *state)
> +				      struct drm_atomic_commit *state)
>   {
>   	struct drm_plane_state *new_plane_state = drm_atomic_get_new_plane_state(state,
>   										 plane);
>   	struct drm_framebuffer *fb = new_plane_state->fb;
>   	struct hdlcd_drm_private *hdlcd;
> diff --git a/drivers/gpu/drm/arm/malidp_crtc.c b/drivers/gpu/drm/arm/malidp_crtc.c
> index 18e6157b10474878d62de439adc7e03c9836f9dd..ebe8e10787772df0de6fec922c8f9853d88006db 100644
> --- a/drivers/gpu/drm/arm/malidp_crtc.c
> +++ b/drivers/gpu/drm/arm/malidp_crtc.c
> @@ -45,11 +45,11 @@ static enum drm_mode_status malidp_crtc_mode_valid(struct drm_crtc *crtc,
>   
>   	return MODE_OK;
>   }
>   
>   static void malidp_crtc_atomic_enable(struct drm_crtc *crtc,
> -				      struct drm_atomic_state *state)
> +				      struct drm_atomic_commit *state)
>   {
>   	struct malidp_drm *malidp = crtc_to_malidp_device(crtc);
>   	struct malidp_hw_device *hwdev = malidp->dev;
>   	struct videomode vm;
>   	int err = pm_runtime_get_sync(crtc->dev->dev);
> @@ -69,11 +69,11 @@ static void malidp_crtc_atomic_enable(struct drm_crtc *crtc,
>   	hwdev->hw->leave_config_mode(hwdev);
>   	drm_crtc_vblank_on(crtc);
>   }
>   
>   static void malidp_crtc_atomic_disable(struct drm_crtc *crtc,
> -				       struct drm_atomic_state *state)
> +				       struct drm_atomic_commit *state)
>   {
>   	struct drm_crtc_state *old_state = drm_atomic_get_old_crtc_state(state,
>   									 crtc);
>   	struct malidp_drm *malidp = crtc_to_malidp_device(crtc);
>   	struct malidp_hw_device *hwdev = malidp->dev;
> @@ -332,11 +332,11 @@ static int malidp_crtc_atomic_check_scaling(struct drm_crtc *crtc,
>   		return -EINVAL;
>   	return 0;
>   }
>   
>   static int malidp_crtc_atomic_check(struct drm_crtc *crtc,
> -				    struct drm_atomic_state *state)
> +				    struct drm_atomic_commit *state)
>   {
>   	struct drm_crtc_state *crtc_state = drm_atomic_get_new_crtc_state(state,
>   									  crtc);
>   	struct malidp_drm *malidp = crtc_to_malidp_device(crtc);
>   	struct malidp_hw_device *hwdev = malidp->dev;
> diff --git a/drivers/gpu/drm/arm/malidp_drv.c b/drivers/gpu/drm/arm/malidp_drv.c
> index b765f6c9eea4e14051be8d4b32bfda06801ddcde..9abe800f598aca38a65ce45d048884e1904bdf43 100644
> --- a/drivers/gpu/drm/arm/malidp_drv.c
> +++ b/drivers/gpu/drm/arm/malidp_drv.c
> @@ -188,11 +188,11 @@ static int malidp_set_and_wait_config_valid(struct drm_device *drm)
>   			msecs_to_jiffies(MALIDP_CONF_VALID_TIMEOUT));
>   
>   	return (ret > 0) ? 0 : -ETIMEDOUT;
>   }
>   
> -static void malidp_atomic_commit_hw_done(struct drm_atomic_state *state)
> +static void malidp_atomic_commit_hw_done(struct drm_atomic_commit *state)
>   {
>   	struct drm_device *drm = state->dev;
>   	struct malidp_drm *malidp = drm_to_malidp(drm);
>   	int loop = 5;
>   
> @@ -229,11 +229,11 @@ static void malidp_atomic_commit_hw_done(struct drm_atomic_state *state)
>   		spin_unlock_irq(&drm->event_lock);
>   	}
>   	drm_atomic_helper_commit_hw_done(state);
>   }
>   
> -static void malidp_atomic_commit_tail(struct drm_atomic_state *state)
> +static void malidp_atomic_commit_tail(struct drm_atomic_commit *state)
>   {
>   	struct drm_device *drm = state->dev;
>   	struct malidp_drm *malidp = drm_to_malidp(drm);
>   	struct drm_crtc *crtc;
>   	struct drm_crtc_state *old_crtc_state;
> diff --git a/drivers/gpu/drm/arm/malidp_mw.c b/drivers/gpu/drm/arm/malidp_mw.c
> index fad34384203867e6059bb287f649211a43641b25..f8be65119e3b0ca641037c19b581a46f77213fa4 100644
> --- a/drivers/gpu/drm/arm/malidp_mw.c
> +++ b/drivers/gpu/drm/arm/malidp_mw.c
> @@ -235,11 +235,11 @@ int malidp_mw_connector_init(struct drm_device *drm)
>   
>   	return 0;
>   }
>   
>   void malidp_mw_atomic_commit(struct drm_device *drm,
> -			     struct drm_atomic_state *old_state)
> +			     struct drm_atomic_commit *old_state)
>   {
>   	struct malidp_drm *malidp = drm_to_malidp(drm);
>   	struct drm_writeback_connector *mw_conn = &malidp->mw_connector;
>   	struct drm_connector_state *conn_state = mw_conn->base.state;
>   	struct malidp_hw_device *hwdev = malidp->dev;
> diff --git a/drivers/gpu/drm/arm/malidp_mw.h b/drivers/gpu/drm/arm/malidp_mw.h
> index 19a007676a1db1ea13bd50d71c020ee1e7f3e1ae..53a2d6a956a956c4e08e9ffd0365a1ffcb259db4 100644
> --- a/drivers/gpu/drm/arm/malidp_mw.h
> +++ b/drivers/gpu/drm/arm/malidp_mw.h
> @@ -8,7 +8,7 @@
>   #ifndef __MALIDP_MW_H__
>   #define __MALIDP_MW_H__
>   
>   int malidp_mw_connector_init(struct drm_device *drm);
>   void malidp_mw_atomic_commit(struct drm_device *drm,
> -			     struct drm_atomic_state *old_state);
> +			     struct drm_atomic_commit *old_state);
>   #endif
> diff --git a/drivers/gpu/drm/arm/malidp_planes.c b/drivers/gpu/drm/arm/malidp_planes.c
> index 4b98763225012543b55427f7f5f6508016e40f2d..60b3f2bb153b5f18be1bba490fe320692edcf007 100644
> --- a/drivers/gpu/drm/arm/malidp_planes.c
> +++ b/drivers/gpu/drm/arm/malidp_planes.c
> @@ -488,11 +488,11 @@ static void malidp_de_prefetch_settings(struct malidp_plane *mp,
>   	ms->mmu_prefetch_mode  =
>   		malidp_mmu_prefetch_select_mode(ms, &ms->mmu_prefetch_pgsize);
>   }
>   
>   static int malidp_de_plane_check(struct drm_plane *plane,
> -				 struct drm_atomic_state *state)
> +				 struct drm_atomic_commit *state)
>   {
>   	struct drm_plane_state *new_plane_state = drm_atomic_get_new_plane_state(state,
>   										 plane);
>   	struct malidp_plane *mp = to_malidp_plane(plane);
>   	struct malidp_plane_state *ms = to_malidp_plane_state(new_plane_state);
> @@ -777,11 +777,11 @@ static void malidp_de_set_plane_afbc(struct drm_plane *plane)
>   
>   	malidp_hw_write(mp->hwdev, val, mp->layer->afbc_decoder_offset);
>   }
>   
>   static void malidp_de_plane_update(struct drm_plane *plane,
> -				   struct drm_atomic_state *state)
> +				   struct drm_atomic_commit *state)
>   {
>   	struct drm_plane_state *old_state = drm_atomic_get_old_plane_state(state,
>   									   plane);
>   	struct malidp_plane *mp;
>   	struct malidp_plane_state *ms = to_malidp_plane_state(plane->state);
> @@ -898,11 +898,11 @@ static void malidp_de_plane_update(struct drm_plane *plane,
>   	malidp_hw_write(mp->hwdev, val,
>   			mp->layer->base + MALIDP_LAYER_CONTROL);
>   }
>   
>   static void malidp_de_plane_disable(struct drm_plane *plane,
> -				    struct drm_atomic_state *state)
> +				    struct drm_atomic_commit *state)
>   {
>   	struct malidp_plane *mp = to_malidp_plane(plane);
>   
>   	malidp_hw_clearbits(mp->hwdev,
>   			    LAYER_ENABLE | LAYER_FLOWCFG(LAYER_FLOWCFG_MASK),
> diff --git a/drivers/gpu/drm/armada/armada_crtc.c b/drivers/gpu/drm/armada/armada_crtc.c
> index d40bb9cf9ff1f04d4fdd881140da0178998ace8a..5e006212fea0d5d4fd17db82314cefadbb8caeca 100644
> --- a/drivers/gpu/drm/armada/armada_crtc.c
> +++ b/drivers/gpu/drm/armada/armada_crtc.c
> @@ -412,11 +412,11 @@ static void armada_drm_crtc_mode_set_nofb(struct drm_crtc *crtc)
>   	armada_drm_crtc_update_regs(dcrtc, regs);
>   	spin_unlock_irqrestore(&dcrtc->irq_lock, flags);
>   }
>   
>   static int armada_drm_crtc_atomic_check(struct drm_crtc *crtc,
> -					struct drm_atomic_state *state)
> +					struct drm_atomic_commit *state)
>   {
>   	struct drm_crtc_state *crtc_state = drm_atomic_get_new_crtc_state(state,
>   									  crtc);
>   	DRM_DEBUG_KMS("[CRTC:%d:%s]\n", crtc->base.id, crtc->name);
>   
> @@ -428,11 +428,11 @@ static int armada_drm_crtc_atomic_check(struct drm_crtc *crtc,
>   
>   	return 0;
>   }
>   
>   static void armada_drm_crtc_atomic_begin(struct drm_crtc *crtc,
> -					 struct drm_atomic_state *state)
> +					 struct drm_atomic_commit *state)
>   {
>   	struct drm_crtc_state *crtc_state = drm_atomic_get_new_crtc_state(state,
>   									  crtc);
>   	struct armada_crtc *dcrtc = drm_to_armada_crtc(crtc);
>   
> @@ -444,11 +444,11 @@ static void armada_drm_crtc_atomic_begin(struct drm_crtc *crtc,
>   	dcrtc->regs_idx = 0;
>   	dcrtc->regs = dcrtc->atomic_regs;
>   }
>   
>   static void armada_drm_crtc_atomic_flush(struct drm_crtc *crtc,
> -					 struct drm_atomic_state *state)
> +					 struct drm_atomic_commit *state)
>   {
>   	struct drm_crtc_state *crtc_state = drm_atomic_get_new_crtc_state(state,
>   									  crtc);
>   	struct armada_crtc *dcrtc = drm_to_armada_crtc(crtc);
>   
> @@ -472,11 +472,11 @@ static void armada_drm_crtc_atomic_flush(struct drm_crtc *crtc,
>   		spin_unlock_irq(&dcrtc->irq_lock);
>   	}
>   }
>   
>   static void armada_drm_crtc_atomic_disable(struct drm_crtc *crtc,
> -					   struct drm_atomic_state *state)
> +					   struct drm_atomic_commit *state)
>   {
>   	struct drm_crtc_state *old_state = drm_atomic_get_old_crtc_state(state,
>   									 crtc);
>   	struct armada_crtc *dcrtc = drm_to_armada_crtc(crtc);
>   	struct drm_pending_vblank_event *event;
> @@ -510,11 +510,11 @@ static void armada_drm_crtc_atomic_disable(struct drm_crtc *crtc,
>   		}
>   	}
>   }
>   
>   static void armada_drm_crtc_atomic_enable(struct drm_crtc *crtc,
> -					  struct drm_atomic_state *state)
> +					  struct drm_atomic_commit *state)
>   {
>   	struct drm_crtc_state *old_state = drm_atomic_get_old_crtc_state(state,
>   									 crtc);
>   	struct armada_crtc *dcrtc = drm_to_armada_crtc(crtc);
>   
> diff --git a/drivers/gpu/drm/armada/armada_overlay.c b/drivers/gpu/drm/armada/armada_overlay.c
> index 361fdcece4b0f3e5598b92b1fd35e9194d446d68..3da0b857ef95a0837ec1e75aa1293cf0bdde4c18 100644
> --- a/drivers/gpu/drm/armada/armada_overlay.c
> +++ b/drivers/gpu/drm/armada/armada_overlay.c
> @@ -67,11 +67,11 @@ static inline u32 armada_csc(struct drm_plane_state *state)
>   			CFG_CSC_YUV_CCIR709 : CFG_CSC_YUV_CCIR601);
>   }
>   
>   /* === Plane support === */
>   static void armada_drm_overlay_plane_atomic_update(struct drm_plane *plane,
> -	struct drm_atomic_state *state)
> +	struct drm_atomic_commit *state)
>   {
>   	struct drm_plane_state *old_state = drm_atomic_get_old_plane_state(state,
>   									   plane);
>   	struct drm_plane_state *new_state = drm_atomic_get_new_plane_state(state,
>   									   plane);
> @@ -218,11 +218,11 @@ static void armada_drm_overlay_plane_atomic_update(struct drm_plane *plane,
>   
>   	dcrtc->regs_idx += idx;
>   }
>   
>   static void armada_drm_overlay_plane_atomic_disable(struct drm_plane *plane,
> -	struct drm_atomic_state *state)
> +	struct drm_atomic_commit *state)
>   {
>   	struct drm_plane_state *old_state = drm_atomic_get_old_plane_state(state,
>   									   plane);
>   	struct armada_crtc *dcrtc;
>   	struct armada_regs *regs;
> @@ -260,19 +260,19 @@ armada_overlay_plane_update(struct drm_plane *plane, struct drm_crtc *crtc,
>   	struct drm_framebuffer *fb,
>   	int crtc_x, int crtc_y, unsigned crtc_w, unsigned crtc_h,
>   	uint32_t src_x, uint32_t src_y, uint32_t src_w, uint32_t src_h,
>   	struct drm_modeset_acquire_ctx *ctx)
>   {
> -	struct drm_atomic_state *state;
> +	struct drm_atomic_commit *state;
>   	struct drm_plane_state *plane_state;
>   	int ret = 0;
>   
>   	trace_armada_ovl_plane_update(plane, crtc, fb,
>   				 crtc_x, crtc_y, crtc_w, crtc_h,
>   				 src_x, src_y, src_w, src_h);
>   
> -	state = drm_atomic_state_alloc(plane->dev);
> +	state = drm_atomic_commit_alloc(plane->dev);
>   	if (!state)
>   		return -ENOMEM;
>   
>   	state->acquire_ctx = ctx;
>   	plane_state = drm_atomic_get_plane_state(state, plane);
> @@ -295,11 +295,11 @@ armada_overlay_plane_update(struct drm_plane *plane, struct drm_crtc *crtc,
>   	plane_state->src_h = src_h;
>   	plane_state->src_w = src_w;
>   
>   	ret = drm_atomic_nonblocking_commit(state);
>   fail:
> -	drm_atomic_state_put(state);
> +	drm_atomic_commit_put(state);
>   	return ret;
>   }
>   
>   static void armada_overlay_reset(struct drm_plane *plane)
>   {
> diff --git a/drivers/gpu/drm/armada/armada_plane.c b/drivers/gpu/drm/armada/armada_plane.c
> index eba12bba1e09866bb5cd9c99ddad98d762a8f93a..fe46a8e4508a2c22eac6c87cac85e9af95df194d 100644
> --- a/drivers/gpu/drm/armada/armada_plane.c
> +++ b/drivers/gpu/drm/armada/armada_plane.c
> @@ -78,11 +78,11 @@ void armada_drm_plane_calc(struct drm_plane_state *state, u32 addrs[2][3],
>   			addrs[1][i] = addrs[0][i];
>   	}
>   }
>   
>   int armada_drm_plane_atomic_check(struct drm_plane *plane,
> -	struct drm_atomic_state *state)
> +	struct drm_atomic_commit *state)
>   {
>   	struct drm_plane_state *new_plane_state = drm_atomic_get_new_plane_state(state,
>   										 plane);
>   	struct armada_plane_state *st = to_armada_plane_state(new_plane_state);
>   	struct drm_crtc *crtc = new_plane_state->crtc;
> @@ -128,11 +128,11 @@ int armada_drm_plane_atomic_check(struct drm_plane *plane,
>   
>   	return 0;
>   }
>   
>   static void armada_drm_primary_plane_atomic_update(struct drm_plane *plane,
> -	struct drm_atomic_state *state)
> +	struct drm_atomic_commit *state)
>   {
>   	struct drm_plane_state *old_state = drm_atomic_get_old_plane_state(state,
>   									   plane);
>   	struct drm_plane_state *new_state = drm_atomic_get_new_plane_state(state,
>   									   plane);
> @@ -218,11 +218,11 @@ static void armada_drm_primary_plane_atomic_update(struct drm_plane *plane,
>   
>   	dcrtc->regs_idx += idx;
>   }
>   
>   static void armada_drm_primary_plane_atomic_disable(struct drm_plane *plane,
> -	struct drm_atomic_state *state)
> +	struct drm_atomic_commit *state)
>   {
>   	struct drm_plane_state *old_state = drm_atomic_get_old_plane_state(state,
>   									   plane);
>   	struct armada_crtc *dcrtc;
>   	struct armada_regs *regs;
> diff --git a/drivers/gpu/drm/armada/armada_plane.h b/drivers/gpu/drm/armada/armada_plane.h
> index 368415c609a65b7bd80b1b4cf6df4cf3131688a9..69bef09ea02898e04db7311abdf72d053a276115 100644
> --- a/drivers/gpu/drm/armada/armada_plane.h
> +++ b/drivers/gpu/drm/armada/armada_plane.h
> @@ -22,11 +22,11 @@ struct armada_plane_state {
>   void armada_drm_plane_calc(struct drm_plane_state *state, u32 addrs[2][3],
>   	u16 pitches[3], bool interlaced);
>   void armada_drm_plane_cleanup_fb(struct drm_plane *plane,
>   	struct drm_plane_state *old_state);
>   int armada_drm_plane_atomic_check(struct drm_plane *plane,
> -	struct drm_atomic_state *state);
> +	struct drm_atomic_commit *state);
>   void armada_plane_reset(struct drm_plane *plane);
>   struct drm_plane_state *armada_plane_duplicate_state(struct drm_plane *plane);
>   void armada_plane_destroy_state(struct drm_plane *plane,
>   				struct drm_plane_state *state);
>   
> diff --git a/drivers/gpu/drm/ast/ast_cursor.c b/drivers/gpu/drm/ast/ast_cursor.c
> index 3fa8e75db9c0542951ecfb57ee87d6f33c4b2dcc..fd19c45f2abe279a9818a72350f2d8ea9501ae6f 100644
> --- a/drivers/gpu/drm/ast/ast_cursor.c
> +++ b/drivers/gpu/drm/ast/ast_cursor.c
> @@ -162,11 +162,11 @@ static const uint32_t ast_cursor_plane_formats[] = {
>   	DRM_FORMAT_ARGB4444,
>   	DRM_FORMAT_ARGB8888,
>   };
>   
>   static int ast_cursor_plane_helper_atomic_check(struct drm_plane *plane,
> -						struct drm_atomic_state *state)
> +						struct drm_atomic_commit *state)
>   {
>   	struct drm_plane_state *new_plane_state = drm_atomic_get_new_plane_state(state, plane);
>   	struct drm_framebuffer *new_fb = new_plane_state->fb;
>   	struct drm_crtc_state *new_crtc_state = NULL;
>   	int ret;
> @@ -242,11 +242,11 @@ static const u8 *ast_cursor_plane_get_argb4444(struct ast_cursor_plane *ast_curs
>   
>   	return argb4444;
>   }
>   
>   static void ast_cursor_plane_helper_atomic_update(struct drm_plane *plane,
> -						  struct drm_atomic_state *state)
> +						  struct drm_atomic_commit *state)
>   {
>   	struct ast_cursor_plane *ast_cursor_plane = to_ast_cursor_plane(plane);
>   	struct ast_plane *ast_plane = to_ast_plane(plane);
>   	struct drm_plane_state *plane_state = drm_atomic_get_new_plane_state(state, plane);
>   	struct drm_shadow_plane_state *shadow_plane_state = to_drm_shadow_plane_state(plane_state);
> @@ -307,11 +307,11 @@ static void ast_cursor_plane_helper_atomic_update(struct drm_plane *plane,
>   	/* Dummy write to enable HWC and make the HW pick-up the changes. */
>   	ast_set_cursor_enabled(ast, true);
>   }
>   
>   static void ast_cursor_plane_helper_atomic_disable(struct drm_plane *plane,
> -						   struct drm_atomic_state *state)
> +						   struct drm_atomic_commit *state)
>   {
>   	struct ast_device *ast = to_ast_device(plane->dev);
>   
>   	ast_set_cursor_enabled(ast, false);
>   }
> diff --git a/drivers/gpu/drm/ast/ast_dp.c b/drivers/gpu/drm/ast/ast_dp.c
> index 9d07dad358cfd09b560cab5eba4484bc7852191b..5f266a05419baf6ad2ee54d09f5b9dccbe1a4964 100644
> --- a/drivers/gpu/drm/ast/ast_dp.c
> +++ b/drivers/gpu/drm/ast/ast_dp.c
> @@ -357,11 +357,11 @@ static void ast_astdp_encoder_helper_atomic_mode_set(struct drm_encoder *encoder
>   	ast_set_index_reg(ast, AST_IO_VGACRI, 0xe1, vgacre1);
>   	ast_set_index_reg(ast, AST_IO_VGACRI, 0xe2, vgacre2);
>   }
>   
>   static void ast_astdp_encoder_helper_atomic_enable(struct drm_encoder *encoder,
> -						   struct drm_atomic_state *state)
> +						   struct drm_atomic_commit *state)
>   {
>   	struct ast_device *ast = to_ast_device(encoder->dev);
>   	struct ast_connector *ast_connector = &ast->output.astdp.connector;
>   
>   	if (ast_connector->physical_status == connector_status_connected) {
> @@ -372,11 +372,11 @@ static void ast_astdp_encoder_helper_atomic_enable(struct drm_encoder *encoder,
>   		ast_dp_set_enable(ast, true);
>   	}
>   }
>   
>   static void ast_astdp_encoder_helper_atomic_disable(struct drm_encoder *encoder,
> -						    struct drm_atomic_state *state)
> +						    struct drm_atomic_commit *state)
>   {
>   	struct ast_device *ast = to_ast_device(encoder->dev);
>   
>   	ast_dp_set_enable(ast, false);
>   	ast_dp_set_phy_sleep(ast, true);
> diff --git a/drivers/gpu/drm/ast/ast_dp501.c b/drivers/gpu/drm/ast/ast_dp501.c
> index 9e19d8c17730834bbbb8782b3d58999c79b96098..f829c1be3b643bb00d0a5380032a6c0ee3c29b66 100644
> --- a/drivers/gpu/drm/ast/ast_dp501.c
> +++ b/drivers/gpu/drm/ast/ast_dp501.c
> @@ -475,19 +475,19 @@ void ast_init_3rdtx(struct ast_device *ast)
>   static const struct drm_encoder_funcs ast_dp501_encoder_funcs = {
>   	.destroy = drm_encoder_cleanup,
>   };
>   
>   static void ast_dp501_encoder_helper_atomic_enable(struct drm_encoder *encoder,
> -						   struct drm_atomic_state *state)
> +						   struct drm_atomic_commit *state)
>   {
>   	struct ast_device *ast = to_ast_device(encoder->dev);
>   
>   	ast_set_dp501_video_output(ast, 1);
>   }
>   
>   static void ast_dp501_encoder_helper_atomic_disable(struct drm_encoder *encoder,
> -						    struct drm_atomic_state *state)
> +						    struct drm_atomic_commit *state)
>   {
>   	struct ast_device *ast = to_ast_device(encoder->dev);
>   
>   	ast_set_dp501_video_output(ast, 0);
>   }
> diff --git a/drivers/gpu/drm/ast/ast_mode.c b/drivers/gpu/drm/ast/ast_mode.c
> index 21abb6a6d8bcdc23870f9d5d72a0a5ee410a4af9..fe05b9fe84d1542b533e1a04d3340f1f675e5789 100644
> --- a/drivers/gpu/drm/ast/ast_mode.c
> +++ b/drivers/gpu/drm/ast/ast_mode.c
> @@ -491,11 +491,11 @@ static const uint32_t ast_primary_plane_formats[] = {
>   	DRM_FORMAT_RGB565,
>   	DRM_FORMAT_C8,
>   };
>   
>   static int ast_primary_plane_helper_atomic_check(struct drm_plane *plane,
> -						 struct drm_atomic_state *state)
> +						 struct drm_atomic_commit *state)
>   {
>   	struct drm_device *dev = plane->dev;
>   	struct drm_plane_state *new_plane_state = drm_atomic_get_new_plane_state(state, plane);
>   	struct drm_crtc_state *new_crtc_state = NULL;
>   	struct ast_crtc_state *new_ast_crtc_state;
> @@ -539,11 +539,11 @@ static void ast_handle_damage(struct ast_plane *ast_plane, struct iosys_map *src
>   	drm_fb_memcpy(&dst, fb->pitches, src, fb, clip);
>   #endif
>   }
>   
>   static void ast_primary_plane_helper_atomic_update(struct drm_plane *plane,
> -						   struct drm_atomic_state *state)
> +						   struct drm_atomic_commit *state)
>   {
>   	struct drm_device *dev = plane->dev;
>   	struct ast_device *ast = to_ast_device(dev);
>   	struct drm_plane_state *plane_state = drm_atomic_get_new_plane_state(state, plane);
>   	struct drm_shadow_plane_state *shadow_plane_state = to_drm_shadow_plane_state(plane_state);
> @@ -583,11 +583,11 @@ static void ast_primary_plane_helper_atomic_update(struct drm_plane *plane,
>   	if (!old_fb || old_fb->pitches[0] != fb->pitches[0])
>   		ast_set_offset_reg(ast, fb);
>   }
>   
>   static void ast_primary_plane_helper_atomic_enable(struct drm_plane *plane,
> -						   struct drm_atomic_state *state)
> +						   struct drm_atomic_commit *state)
>   {
>   	struct ast_device *ast = to_ast_device(plane->dev);
>   	struct ast_plane *ast_plane = to_ast_plane(plane);
>   
>   	/*
> @@ -598,11 +598,11 @@ static void ast_primary_plane_helper_atomic_enable(struct drm_plane *plane,
>   	 */
>   	ast_set_start_address_crt1(ast, (u32)ast_plane->offset);
>   }
>   
>   static void ast_primary_plane_helper_atomic_disable(struct drm_plane *plane,
> -						    struct drm_atomic_state *state)
> +						    struct drm_atomic_commit *state)
>   {
>   	/*
>   	 * Keep this empty function to avoid calling
>   	 * atomic_update when disabling the plane.
>   	 */
> @@ -706,11 +706,11 @@ static void ast_crtc_helper_mode_set_nofb(struct drm_crtc *crtc)
>   	ast_set_crtthd_reg(ast);
>   	ast_set_sync_reg(ast, adjusted_mode, vmode);
>   }
>   
>   static int ast_crtc_helper_atomic_check(struct drm_crtc *crtc,
> -					struct drm_atomic_state *state)
> +					struct drm_atomic_commit *state)
>   {
>   	struct drm_crtc_state *crtc_state = drm_atomic_get_new_crtc_state(state, crtc);
>   	struct drm_display_mode *adjusted_mode = &crtc_state->adjusted_mode;
>   	struct drm_crtc_state *old_crtc_state = drm_atomic_get_old_crtc_state(state, crtc);
>   	struct ast_crtc_state *old_ast_crtc_state = to_ast_crtc_state(old_crtc_state);
> @@ -806,11 +806,11 @@ static int ast_crtc_helper_atomic_check(struct drm_crtc *crtc,
>   	return 0;
>   }
>   
>   static void
>   ast_crtc_helper_atomic_flush(struct drm_crtc *crtc,
> -			     struct drm_atomic_state *state)
> +			     struct drm_atomic_commit *state)
>   {
>   	struct drm_crtc_state *crtc_state = drm_atomic_get_new_crtc_state(state,
>   									  crtc);
>   	struct drm_device *dev = crtc->dev;
>   	struct ast_device *ast = to_ast_device(dev);
> @@ -828,11 +828,11 @@ ast_crtc_helper_atomic_flush(struct drm_crtc *crtc,
>   		else
>   			ast_crtc_fill_gamma(ast, ast_crtc_state->format);
>   	}
>   }
>   
> -static void ast_crtc_helper_atomic_enable(struct drm_crtc *crtc, struct drm_atomic_state *state)
> +static void ast_crtc_helper_atomic_enable(struct drm_crtc *crtc, struct drm_atomic_commit *state)
>   {
>   	struct ast_device *ast = to_ast_device(crtc->dev);
>   	u8 vgacr17 = 0x00;
>   	u8 vgacrb6 = 0xff;
>   
> @@ -841,11 +841,11 @@ static void ast_crtc_helper_atomic_enable(struct drm_crtc *crtc, struct drm_atom
>   
>   	ast_set_index_reg_mask(ast, AST_IO_VGACRI, 0x17, 0x7f, vgacr17);
>   	ast_set_index_reg_mask(ast, AST_IO_VGACRI, 0xb6, 0xfc, vgacrb6);
>   }
>   
> -static void ast_crtc_helper_atomic_disable(struct drm_crtc *crtc, struct drm_atomic_state *state)
> +static void ast_crtc_helper_atomic_disable(struct drm_crtc *crtc, struct drm_atomic_commit *state)
>   {
>   	struct drm_crtc_state *old_crtc_state = drm_atomic_get_old_crtc_state(state, crtc);
>   	struct ast_device *ast = to_ast_device(crtc->dev);
>   	u8 vgacr17 = 0xff;
>   
> @@ -950,11 +950,11 @@ static int ast_crtc_init(struct ast_device *ast)
>   
>   /*
>    * Mode config
>    */
>   
> -static void ast_mode_config_helper_atomic_commit_tail(struct drm_atomic_state *state)
> +static void ast_mode_config_helper_atomic_commit_tail(struct drm_atomic_commit *state)
>   {
>   	struct ast_device *ast = to_ast_device(state->dev);
>   
>   	/*
>   	 * Concurrent operations could possibly trigger a call to
> diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
> index d8cf3d231920c7e3e6d18ad1e6309d560dbe122f..9dbac2def333e1937a8494bbdc7eb52900d1b193 100644
> --- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
> +++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
> @@ -198,11 +198,11 @@ atmel_hlcdc_crtc_mode_valid(struct drm_crtc *c,
>   
>   	return atmel_hlcdc_dc_mode_valid(crtc->dc, mode);
>   }
>   
>   static void atmel_hlcdc_crtc_atomic_disable(struct drm_crtc *c,
> -					    struct drm_atomic_state *state)
> +					    struct drm_atomic_commit *state)
>   {
>   	struct drm_device *dev = c->dev;
>   	struct atmel_hlcdc_crtc *crtc = drm_crtc_to_atmel_hlcdc_crtc(c);
>   	struct regmap *regmap = crtc->dc->hlcdc->regmap;
>   	unsigned int status;
> @@ -250,11 +250,11 @@ static void atmel_hlcdc_crtc_atomic_disable(struct drm_crtc *c,
>   
>   	pm_runtime_put_sync(dev->dev);
>   }
>   
>   static void atmel_hlcdc_crtc_atomic_enable(struct drm_crtc *c,
> -					   struct drm_atomic_state *state)
> +					   struct drm_atomic_commit *state)
>   {
>   	struct drm_device *dev = c->dev;
>   	struct atmel_hlcdc_crtc *crtc = drm_crtc_to_atmel_hlcdc_crtc(c);
>   	struct regmap *regmap = crtc->dc->hlcdc->regmap;
>   	unsigned int status;
> @@ -456,11 +456,11 @@ static int atmel_hlcdc_crtc_select_output_mode(struct drm_crtc_state *state)
>   	}
>   	return 0;
>   }
>   
>   static int atmel_hlcdc_crtc_atomic_check(struct drm_crtc *c,
> -					 struct drm_atomic_state *state)
> +					 struct drm_atomic_commit *state)
>   {
>   	struct drm_crtc_state *s = drm_atomic_get_new_crtc_state(state, c);
>   	int ret;
>   
>   	ret = atmel_hlcdc_crtc_select_output_mode(s);
> @@ -473,17 +473,17 @@ static int atmel_hlcdc_crtc_atomic_check(struct drm_crtc *c,
>   
>   	return atmel_hlcdc_plane_prepare_ahb_routing(s);
>   }
>   
>   static void atmel_hlcdc_crtc_atomic_begin(struct drm_crtc *c,
> -					  struct drm_atomic_state *state)
> +					  struct drm_atomic_commit *state)
>   {
>   	drm_crtc_vblank_on(c);
>   }
>   
>   static void atmel_hlcdc_crtc_atomic_flush(struct drm_crtc *c,
> -					  struct drm_atomic_state *state)
> +					  struct drm_atomic_commit *state)
>   {
>   	struct atmel_hlcdc_crtc *crtc = drm_crtc_to_atmel_hlcdc_crtc(c);
>   	unsigned long flags;
>   
>   	spin_lock_irqsave(&c->dev->event_lock, flags);
> diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
> index 97482fc82ec2ff22d525a6fbd39cc6bcae643560..2f41bce574dc546bce9cd23b71c00c6461d82308 100644
> --- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
> +++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
> @@ -981,11 +981,11 @@ static void atmel_hlcdc_dc_drm_shutdown(struct platform_device *pdev)
>   static int atmel_hlcdc_dc_drm_suspend(struct device *dev)
>   {
>   	struct drm_device *drm_dev = dev_get_drvdata(dev);
>   	struct atmel_hlcdc_dc *dc = drm_dev->dev_private;
>   	struct regmap *regmap = dc->hlcdc->regmap;
> -	struct drm_atomic_state *state;
> +	struct drm_atomic_commit *state;
>   
>   	state = drm_atomic_helper_suspend(drm_dev);
>   	if (IS_ERR(state))
>   		return PTR_ERR(state);
>   
> diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h
> index 26b26185cf34ac1678f385982caabd2dbbc22630..390dfbf3c77ddb03c9233abe9370b305e367140f 100644
> --- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h
> +++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h
> @@ -352,11 +352,11 @@ struct atmel_hlcdc_dc {
>   	struct drm_crtc *crtc;
>   	struct drm_device dev;
>   	struct atmel_hlcdc_layer *layers[ATMEL_HLCDC_MAX_LAYERS];
>   	struct {
>   		u32 imr;
> -		struct drm_atomic_state *state;
> +		struct drm_atomic_commit *state;
>   	} suspend;
>   };
>   
>   struct atmel_hlcdc_plane_state;
>   
> diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
> index bccd1564216e699a274d135b30a858f1dbbefee5..f17a832351e9d7cd216a3656ff4e1400cb6ec178 100644
> --- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
> +++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
> @@ -716,11 +716,11 @@ atmel_hlcdc_plane_update_disc_area(struct atmel_hlcdc_plane *plane,
>   				ATMEL_HLCDC_LAYER_DISC_SIZE(state->disc_w,
>   							    state->disc_h));
>   }
>   
>   static int atmel_hlcdc_plane_atomic_check(struct drm_plane *p,
> -					  struct drm_atomic_state *state)
> +					  struct drm_atomic_commit *state)
>   {
>   	struct drm_plane_state *s = drm_atomic_get_new_plane_state(state, p);
>   	struct atmel_hlcdc_plane *plane = drm_plane_to_atmel_hlcdc_plane(p);
>   	struct atmel_hlcdc_plane_state *hstate =
>   				drm_plane_state_to_atmel_hlcdc_plane_state(s);
> @@ -867,11 +867,11 @@ static void atmel_xlcdc_atomic_disable(struct atmel_hlcdc_plane *plane,
>   	/* Clear all pending interrupts */
>   	atmel_hlcdc_layer_read_reg(&plane->layer, ATMEL_XLCDC_LAYER_ISR);
>   }
>   
>   static void atmel_hlcdc_plane_atomic_disable(struct drm_plane *p,
> -					     struct drm_atomic_state *state)
> +					     struct drm_atomic_commit *state)
>   {
>   	struct atmel_hlcdc_plane *plane = drm_plane_to_atmel_hlcdc_plane(p);
>   	struct atmel_hlcdc_dc *dc = plane->base.dev->dev_private;
>   
>   	dc->desc->ops->lcdc_atomic_disable(plane, dc);
> @@ -917,11 +917,11 @@ static void atmel_xlcdc_atomic_update(struct atmel_hlcdc_plane *plane,
>   		     ATMEL_XLCDC_OVR1_UPDATE | ATMEL_XLCDC_OVR3_UPDATE |
>   		     ATMEL_XLCDC_HEO_UPDATE);
>   }
>   
>   static void atmel_hlcdc_plane_atomic_update(struct drm_plane *p,
> -					    struct drm_atomic_state *state)
> +					    struct drm_atomic_commit *state)
>   {
>   	struct drm_plane_state *new_s = drm_atomic_get_new_plane_state(state,
>   								       p);
>   	struct atmel_hlcdc_plane *plane = drm_plane_to_atmel_hlcdc_plane(p);
>   	struct atmel_hlcdc_plane_state *hstate =
> diff --git a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
> index 6bd76c1fb0071c8c9cd9c293b3a48a2b4487768e..b47d8eea45663944c789dca387b4893b3ecc641e 100644
> --- a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
> +++ b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
> @@ -781,11 +781,11 @@ static const struct adv7511 *bridge_to_adv7511_const(const struct drm_bridge *br
>   {
>   	return container_of(bridge, struct adv7511, bridge);
>   }
>   
>   static void adv7511_bridge_atomic_enable(struct drm_bridge *bridge,
> -					 struct drm_atomic_state *state)
> +					 struct drm_atomic_commit *state)
>   {
>   	struct adv7511 *adv = bridge_to_adv7511(bridge);
>   	struct drm_connector *connector;
>   	struct drm_connector_state *conn_state;
>   	struct drm_crtc_state *crtc_state;
> @@ -810,11 +810,11 @@ static void adv7511_bridge_atomic_enable(struct drm_bridge *bridge,
>   
>   	drm_atomic_helper_connector_hdmi_update_infoframes(connector, state);
>   }
>   
>   static void adv7511_bridge_atomic_disable(struct drm_bridge *bridge,
> -					  struct drm_atomic_state *state)
> +					  struct drm_atomic_commit *state)
>   {
>   	struct adv7511 *adv = bridge_to_adv7511(bridge);
>   
>   	adv7511_power_off(adv);
>   }
> diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> index 8dee5f2fbde51637cf2eddd48832fec25d7e4cce..e5361a3fd6a6e4e4a62a1695dcb7caf297414401 100644
> --- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> +++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> @@ -889,11 +889,11 @@ analogix_dp_best_encoder(struct drm_connector *connector)
>   	return dp->encoder;
>   }
>   
>   
>   static int analogix_dp_atomic_check(struct drm_connector *connector,
> -				    struct drm_atomic_state *state)
> +				    struct drm_atomic_commit *state)
>   {
>   	struct analogix_dp_device *dp = to_dp(connector);
>   	struct drm_connector_state *conn_state;
>   	struct drm_crtc_state *crtc_state;
>   
> @@ -993,11 +993,11 @@ static int analogix_dp_bridge_attach(struct drm_bridge *bridge,
>   	return 0;
>   }
>   
>   static
>   struct drm_crtc *analogix_dp_get_old_crtc(struct analogix_dp_device *dp,
> -					  struct drm_atomic_state *state)
> +					  struct drm_atomic_commit *state)
>   {
>   	struct drm_encoder *encoder = dp->encoder;
>   	struct drm_connector *connector;
>   	struct drm_connector_state *conn_state;
>   
> @@ -1012,11 +1012,11 @@ struct drm_crtc *analogix_dp_get_old_crtc(struct analogix_dp_device *dp,
>   	return conn_state->crtc;
>   }
>   
>   static
>   struct drm_crtc *analogix_dp_get_new_crtc(struct analogix_dp_device *dp,
> -					  struct drm_atomic_state *state)
> +					  struct drm_atomic_commit *state)
>   {
>   	struct drm_encoder *encoder = dp->encoder;
>   	struct drm_connector *connector;
>   	struct drm_connector_state *conn_state;
>   
> @@ -1030,11 +1030,11 @@ struct drm_crtc *analogix_dp_get_new_crtc(struct analogix_dp_device *dp,
>   
>   	return conn_state->crtc;
>   }
>   
>   static void analogix_dp_bridge_atomic_pre_enable(struct drm_bridge *bridge,
> -						 struct drm_atomic_state *old_state)
> +						 struct drm_atomic_commit *old_state)
>   {
>   	struct analogix_dp_device *dp = to_dp(bridge);
>   	struct drm_crtc *crtc;
>   	struct drm_crtc_state *old_crtc_state;
>   
> @@ -1161,11 +1161,11 @@ static void analogix_dp_bridge_mode_set(struct drm_bridge *bridge,
>   	if (of_property_read_bool(dp_node, "interlaced"))
>   		video->interlaced = true;
>   }
>   
>   static void analogix_dp_bridge_atomic_enable(struct drm_bridge *bridge,
> -					     struct drm_atomic_state *old_state)
> +					     struct drm_atomic_commit *old_state)
>   {
>   	struct analogix_dp_device *dp = to_dp(bridge);
>   	struct drm_crtc *crtc;
>   	struct drm_crtc_state *old_crtc_state, *new_crtc_state;
>   	int timeout_loop = 0;
> @@ -1226,11 +1226,11 @@ static void analogix_dp_bridge_disable(struct drm_bridge *bridge)
>   	dp->psr_supported = false;
>   	dp->dpms_mode = DRM_MODE_DPMS_OFF;
>   }
>   
>   static void analogix_dp_bridge_atomic_disable(struct drm_bridge *bridge,
> -					      struct drm_atomic_state *old_state)
> +					      struct drm_atomic_commit *old_state)
>   {
>   	struct analogix_dp_device *dp = to_dp(bridge);
>   	struct drm_crtc *old_crtc, *new_crtc;
>   	struct drm_crtc_state *old_crtc_state = NULL;
>   	struct drm_crtc_state *new_crtc_state = NULL;
> @@ -1264,11 +1264,11 @@ static void analogix_dp_bridge_atomic_disable(struct drm_bridge *bridge,
>   
>   	analogix_dp_bridge_disable(bridge);
>   }
>   
>   static void analogix_dp_bridge_atomic_post_disable(struct drm_bridge *bridge,
> -						   struct drm_atomic_state *old_state)
> +						   struct drm_atomic_commit *old_state)
>   {
>   	struct analogix_dp_device *dp = to_dp(bridge);
>   	struct drm_crtc *crtc;
>   	struct drm_crtc_state *new_crtc_state;
>   	int ret;
> diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu/drm/bridge/analogix/anx7625.c
> index 54b02242d6db4b4bd9d0a2ff074a72d6d84d9028..513c11cdbc74a90a5c45b50e74077ce3e63a5a30 100644
> --- a/drivers/gpu/drm/bridge/analogix/anx7625.c
> +++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
> @@ -2557,11 +2557,11 @@ static int anx7625_bridge_atomic_check(struct drm_bridge *bridge,
>   
>   	return 0;
>   }
>   
>   static void anx7625_bridge_atomic_enable(struct drm_bridge *bridge,
> -					 struct drm_atomic_state *state)
> +					 struct drm_atomic_commit *state)
>   {
>   	struct anx7625_data *ctx = bridge_to_anx7625(bridge);
>   	struct device *dev = ctx->dev;
>   	struct drm_connector *connector;
>   	struct drm_connector_state *conn_state;
> @@ -2596,11 +2596,11 @@ static void anx7625_bridge_atomic_enable(struct drm_bridge *bridge,
>   		}
>   	}
>   }
>   
>   static void anx7625_bridge_atomic_disable(struct drm_bridge *bridge,
> -					  struct drm_atomic_state *state)
> +					  struct drm_atomic_commit *state)
>   {
>   	struct anx7625_data *ctx = bridge_to_anx7625(bridge);
>   	struct device *dev = ctx->dev;
>   
>   	dev_dbg(dev, "drm atomic disable\n");
> diff --git a/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c b/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
> index 0dd85e26248cc8d63483690d40948deed06fa0fd..50ea40a6ae0508bdc9bccbe9aae8669c63574a93 100644
> --- a/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
> +++ b/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
> @@ -589,11 +589,11 @@ cdns_dsi_bridge_mode_valid(struct drm_bridge *bridge,
>   
>   	return MODE_OK;
>   }
>   
>   static void cdns_dsi_bridge_atomic_post_disable(struct drm_bridge *bridge,
> -						struct drm_atomic_state *state)
> +						struct drm_atomic_commit *state)
>   {
>   	struct cdns_dsi_input *input = bridge_to_cdns_dsi_input(bridge);
>   	struct cdns_dsi *dsi = input_to_dsi(input);
>   	u32 val;
>   
> @@ -699,11 +699,11 @@ static void cdns_dsi_init_link(struct cdns_dsi *dsi)
>   
>   	dsi->link_initialized = true;
>   }
>   
>   static void cdns_dsi_bridge_atomic_pre_enable(struct drm_bridge *bridge,
> -					      struct drm_atomic_state *state)
> +					      struct drm_atomic_commit *state)
>   {
>   	struct cdns_dsi_input *input = bridge_to_cdns_dsi_input(bridge);
>   	struct cdns_dsi *dsi = input_to_dsi(input);
>   	struct cdns_dsi_output *output = &dsi->output;
>   	struct drm_connector_state *conn_state;
> diff --git a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
> index 064c6915c8960ec12a2980f83d3bdb21b782f111..36c07b71fe04bfab3a2ce9b04231f91c7f741723 100644
> --- a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
> +++ b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
> @@ -1748,11 +1748,11 @@ static void cdns_mhdp_sst_enable(struct cdns_mhdp_device *mhdp,
>   
>   	cdns_mhdp_configure_video(mhdp, mode);
>   }
>   
>   static void cdns_mhdp_atomic_enable(struct drm_bridge *bridge,
> -				    struct drm_atomic_state *state)
> +				    struct drm_atomic_commit *state)
>   {
>   	struct cdns_mhdp_device *mhdp = bridge_to_mhdp(bridge);
>   	struct cdns_mhdp_bridge_state *mhdp_state;
>   	struct drm_crtc_state *crtc_state;
>   	struct drm_connector_state *conn_state;
> @@ -1839,11 +1839,11 @@ static void cdns_mhdp_atomic_enable(struct drm_bridge *bridge,
>   	if (ret < 0)
>   		schedule_work(&mhdp->modeset_retry_work);
>   }
>   
>   static void cdns_mhdp_atomic_disable(struct drm_bridge *bridge,
> -				     struct drm_atomic_state *state)
> +				     struct drm_atomic_commit *state)
>   {
>   	struct cdns_mhdp_device *mhdp = bridge_to_mhdp(bridge);
>   	u32 resp;
>   
>   	dev_dbg(mhdp->dev, "%s\n", __func__);
> @@ -1961,11 +1961,11 @@ static int cdns_mhdp_atomic_check(struct drm_bridge *bridge,
>   				  struct drm_connector_state *conn_state)
>   {
>   	struct cdns_mhdp_device *mhdp = bridge_to_mhdp(bridge);
>   	const struct drm_display_mode *mode = &crtc_state->adjusted_mode;
>   	struct drm_connector_state *old_state, *new_state;
> -	struct drm_atomic_state *state = crtc_state->state;
> +	struct drm_atomic_commit *state = crtc_state->state;
>   	struct drm_connector *conn = mhdp->connector;
>   	u64 old_cp, new_cp;
>   
>   	mutex_lock(&mhdp->link_mutex);
>   
> diff --git a/drivers/gpu/drm/bridge/chipone-icn6211.c b/drivers/gpu/drm/bridge/chipone-icn6211.c
> index 814713c5bea97dcdc2b847d2f266a567ef40e981..08775381b0758b108da7630b58ff6a77b43db6cc 100644
> --- a/drivers/gpu/drm/bridge/chipone-icn6211.c
> +++ b/drivers/gpu/drm/bridge/chipone-icn6211.c
> @@ -339,11 +339,11 @@ static void chipone_configure_pll(struct chipone *icn,
>   	chipone_writeb(icn, PLL_REF_DIV, ref_div);
>   	chipone_writeb(icn, PLL_INT(0), best_m);
>   }
>   
>   static void chipone_atomic_enable(struct drm_bridge *bridge,
> -				  struct drm_atomic_state *state)
> +				  struct drm_atomic_commit *state)
>   {
>   	struct chipone *icn = bridge_to_chipone(bridge);
>   	struct drm_display_mode *mode = &icn->mode;
>   	const struct drm_bridge_state *bridge_state;
>   	u16 hfp, hbp, hsync;
> @@ -442,11 +442,11 @@ static void chipone_atomic_enable(struct drm_bridge *bridge,
>   
>   	usleep_range(10000, 11000);
>   }
>   
>   static void chipone_atomic_pre_enable(struct drm_bridge *bridge,
> -				      struct drm_atomic_state *state)
> +				      struct drm_atomic_commit *state)
>   {
>   	struct chipone *icn = bridge_to_chipone(bridge);
>   	int ret;
>   
>   	if (icn->vdd1) {
> @@ -479,11 +479,11 @@ static void chipone_atomic_pre_enable(struct drm_bridge *bridge,
>   
>   	usleep_range(10000, 11000);
>   }
>   
>   static void chipone_atomic_post_disable(struct drm_bridge *bridge,
> -					struct drm_atomic_state *state)
> +					struct drm_atomic_commit *state)
>   {
>   	struct chipone *icn = bridge_to_chipone(bridge);
>   
>   	clk_disable_unprepare(icn->refclk);
>   
> diff --git a/drivers/gpu/drm/bridge/fsl-ldb.c b/drivers/gpu/drm/bridge/fsl-ldb.c
> index 7b71cde173e0ce0a61fe210e0002eba28091155c..9bfaa3f933709da3c4abdd1434036b5db16f3808 100644
> --- a/drivers/gpu/drm/bridge/fsl-ldb.c
> +++ b/drivers/gpu/drm/bridge/fsl-ldb.c
> @@ -122,11 +122,11 @@ static int fsl_ldb_attach(struct drm_bridge *bridge,
>   	return drm_bridge_attach(encoder, fsl_ldb->panel_bridge,
>   				 bridge, flags);
>   }
>   
>   static void fsl_ldb_atomic_enable(struct drm_bridge *bridge,
> -				  struct drm_atomic_state *state)
> +				  struct drm_atomic_commit *state)
>   {
>   	struct fsl_ldb *fsl_ldb = to_fsl_ldb(bridge);
>   	const struct drm_bridge_state *bridge_state;
>   	const struct drm_crtc_state *crtc_state;
>   	const struct drm_display_mode *mode;
> @@ -226,11 +226,11 @@ static void fsl_ldb_atomic_enable(struct drm_bridge *bridge,
>   
>   	regmap_write(fsl_ldb->regmap, fsl_ldb->devdata->lvds_ctrl, reg);
>   }
>   
>   static void fsl_ldb_atomic_disable(struct drm_bridge *bridge,
> -				   struct drm_atomic_state *state)
> +				   struct drm_atomic_commit *state)
>   {
>   	struct fsl_ldb *fsl_ldb = to_fsl_ldb(bridge);
>   
>   	/* Stop channel(s). */
>   	if (fsl_ldb->devdata->lvds_en_bit)
> diff --git a/drivers/gpu/drm/bridge/imx/imx8mp-hdmi-pvi.c b/drivers/gpu/drm/bridge/imx/imx8mp-hdmi-pvi.c
> index 15fbb1be07cdf5eb0dde74bba0a7eea466767464..7d5fda7173e5fa9b290cc56add091ea46d48a707 100644
> --- a/drivers/gpu/drm/bridge/imx/imx8mp-hdmi-pvi.c
> +++ b/drivers/gpu/drm/bridge/imx/imx8mp-hdmi-pvi.c
> @@ -47,11 +47,11 @@ static int imx8mp_hdmi_pvi_bridge_attach(struct drm_bridge *bridge,
>   	return drm_bridge_attach(encoder, pvi->bridge.next_bridge,
>   				 bridge, flags);
>   }
>   
>   static void imx8mp_hdmi_pvi_bridge_enable(struct drm_bridge *bridge,
> -					  struct drm_atomic_state *state)
> +					  struct drm_atomic_commit *state)
>   {
>   	struct imx8mp_hdmi_pvi *pvi = to_imx8mp_hdmi_pvi(bridge);
>   	struct drm_connector_state *conn_state;
>   	struct drm_bridge_state *bridge_state;
>   	const struct drm_display_mode *mode;
> @@ -87,11 +87,11 @@ static void imx8mp_hdmi_pvi_bridge_enable(struct drm_bridge *bridge,
>   
>   	writel(val, pvi->regs + HTX_PVI_CTRL);
>   }
>   
>   static void imx8mp_hdmi_pvi_bridge_disable(struct drm_bridge *bridge,
> -					   struct drm_atomic_state *state)
> +					   struct drm_atomic_commit *state)
>   {
>   	struct imx8mp_hdmi_pvi *pvi = to_imx8mp_hdmi_pvi(bridge);
>   
>   	writel(0x0, pvi->regs + HTX_PVI_CTRL);
>   
> diff --git a/drivers/gpu/drm/bridge/imx/imx8qm-ldb.c b/drivers/gpu/drm/bridge/imx/imx8qm-ldb.c
> index bdecee56fa4938884f1bb83ae6911ccdb73d5b0c..a6ca4f5c6cc60590b22dcdd6172face0e1c87a7a 100644
> --- a/drivers/gpu/drm/bridge/imx/imx8qm-ldb.c
> +++ b/drivers/gpu/drm/bridge/imx/imx8qm-ldb.c
> @@ -199,11 +199,11 @@ imx8qm_ldb_bridge_mode_set(struct drm_bridge *bridge,
>   		regmap_update_bits(ldb->regmap, SS_CTRL,
>   				   CH_HSYNC_M(chno), CH_PHSYNC(chno));
>   }
>   
>   static void imx8qm_ldb_bridge_atomic_enable(struct drm_bridge *bridge,
> -					    struct drm_atomic_state *state)
> +					    struct drm_atomic_commit *state)
>   {
>   	struct ldb_channel *ldb_ch = bridge->driver_private;
>   	struct ldb *ldb = ldb_ch->ldb;
>   	struct imx8qm_ldb_channel *imx8qm_ldb_ch =
>   					base_to_imx8qm_ldb_channel(ldb_ch);
> @@ -245,11 +245,11 @@ static void imx8qm_ldb_bridge_atomic_enable(struct drm_bridge *bridge,
>   
>   	ldb_bridge_enable_helper(bridge);
>   }
>   
>   static void imx8qm_ldb_bridge_atomic_disable(struct drm_bridge *bridge,
> -					     struct drm_atomic_state *state)
> +					     struct drm_atomic_commit *state)
>   {
>   	struct ldb_channel *ldb_ch = bridge->driver_private;
>   	struct ldb *ldb = ldb_ch->ldb;
>   	struct imx8qm_ldb_channel *imx8qm_ldb_ch =
>   					base_to_imx8qm_ldb_channel(ldb_ch);
> diff --git a/drivers/gpu/drm/bridge/imx/imx8qxp-ldb.c b/drivers/gpu/drm/bridge/imx/imx8qxp-ldb.c
> index fbd7a37c08129aa5c363ab54ccb884b204524f2d..a7906314ade14978bab1bc4369c3ec654d6ec816 100644
> --- a/drivers/gpu/drm/bridge/imx/imx8qxp-ldb.c
> +++ b/drivers/gpu/drm/bridge/imx/imx8qxp-ldb.c
> @@ -214,11 +214,11 @@ imx8qxp_ldb_bridge_mode_set(struct drm_bridge *bridge,
>   	if (is_split && companion)
>   		companion->funcs->mode_set(companion, mode, adjusted_mode);
>   }
>   
>   static void imx8qxp_ldb_bridge_atomic_pre_enable(struct drm_bridge *bridge,
> -						 struct drm_atomic_state *state)
> +						 struct drm_atomic_commit *state)
>   {
>   	struct ldb_channel *ldb_ch = bridge->driver_private;
>   	struct ldb *ldb = ldb_ch->ldb;
>   	struct imx8qxp_ldb *imx8qxp_ldb = base_to_imx8qxp_ldb(ldb);
>   	struct drm_bridge *companion = imx8qxp_ldb->companion;
> @@ -230,11 +230,11 @@ static void imx8qxp_ldb_bridge_atomic_pre_enable(struct drm_bridge *bridge,
>   	if (is_split && companion)
>   		companion->funcs->atomic_pre_enable(companion, state);
>   }
>   
>   static void imx8qxp_ldb_bridge_atomic_enable(struct drm_bridge *bridge,
> -					     struct drm_atomic_state *state)
> +					     struct drm_atomic_commit *state)
>   {
>   	struct ldb_channel *ldb_ch = bridge->driver_private;
>   	struct ldb *ldb = ldb_ch->ldb;
>   	struct imx8qxp_ldb_channel *imx8qxp_ldb_ch =
>   					base_to_imx8qxp_ldb_channel(ldb_ch);
> @@ -264,11 +264,11 @@ static void imx8qxp_ldb_bridge_atomic_enable(struct drm_bridge *bridge,
>   	if (is_split && companion)
>   		companion->funcs->atomic_enable(companion, state);
>   }
>   
>   static void imx8qxp_ldb_bridge_atomic_disable(struct drm_bridge *bridge,
> -					      struct drm_atomic_state *state)
> +					      struct drm_atomic_commit *state)
>   {
>   	struct ldb_channel *ldb_ch = bridge->driver_private;
>   	struct ldb *ldb = ldb_ch->ldb;
>   	struct imx8qxp_ldb_channel *imx8qxp_ldb_ch =
>   					base_to_imx8qxp_ldb_channel(ldb_ch);
> diff --git a/drivers/gpu/drm/bridge/imx/imx8qxp-pixel-combiner.c b/drivers/gpu/drm/bridge/imx/imx8qxp-pixel-combiner.c
> index 5582456a44909bdb5e3d53a730347fbb948a73fe..e0ee51a9ca7f85cd43c67195f2775c69da66ab9b 100644
> --- a/drivers/gpu/drm/bridge/imx/imx8qxp-pixel-combiner.c
> +++ b/drivers/gpu/drm/bridge/imx/imx8qxp-pixel-combiner.c
> @@ -174,11 +174,11 @@ imx8qxp_pc_bridge_mode_set(struct drm_bridge *bridge,
>   
>   	clk_disable_unprepare(pc->clk_apb);
>   }
>   
>   static void imx8qxp_pc_bridge_atomic_disable(struct drm_bridge *bridge,
> -					     struct drm_atomic_state *state)
> +					     struct drm_atomic_commit *state)
>   {
>   	struct imx8qxp_pc_channel *ch = bridge->driver_private;
>   	struct imx8qxp_pc *pc = ch->pc;
>   
>   	pm_runtime_put(pc->dev);
> diff --git a/drivers/gpu/drm/bridge/imx/imx8qxp-pixel-link.c b/drivers/gpu/drm/bridge/imx/imx8qxp-pixel-link.c
> index 63a8d8b1f76b14075054854877cd60889997bb3b..ee6b6dbbe9527f863325f504bff74e0b713f4a98 100644
> --- a/drivers/gpu/drm/bridge/imx/imx8qxp-pixel-link.c
> +++ b/drivers/gpu/drm/bridge/imx/imx8qxp-pixel-link.c
> @@ -152,21 +152,21 @@ imx8qxp_pixel_link_bridge_mode_set(struct drm_bridge *bridge,
>   
>   	imx8qxp_pixel_link_set_mst_addr(pl);
>   }
>   
>   static void imx8qxp_pixel_link_bridge_atomic_enable(struct drm_bridge *bridge,
> -						    struct drm_atomic_state *state)
> +						    struct drm_atomic_commit *state)
>   {
>   	struct imx8qxp_pixel_link *pl = bridge->driver_private;
>   
>   	imx8qxp_pixel_link_enable_mst_en(pl);
>   	imx8qxp_pixel_link_enable_mst_vld(pl);
>   	imx8qxp_pixel_link_enable_sync(pl);
>   }
>   
>   static void imx8qxp_pixel_link_bridge_atomic_disable(struct drm_bridge *bridge,
> -						     struct drm_atomic_state *state)
> +						     struct drm_atomic_commit *state)
>   {
>   	struct imx8qxp_pixel_link *pl = bridge->driver_private;
>   
>   	imx8qxp_pixel_link_disable_mst_en(pl);
>   	imx8qxp_pixel_link_disable_mst_vld(pl);
> diff --git a/drivers/gpu/drm/bridge/imx/imx8qxp-pxl2dpi.c b/drivers/gpu/drm/bridge/imx/imx8qxp-pxl2dpi.c
> index 441fd32dc91c7a3e61e1f19a33726aca4349d66c..2e59f53f0eb6fa7557bde33b98943e34f111a8b5 100644
> --- a/drivers/gpu/drm/bridge/imx/imx8qxp-pxl2dpi.c
> +++ b/drivers/gpu/drm/bridge/imx/imx8qxp-pxl2dpi.c
> @@ -131,11 +131,11 @@ imx8qxp_pxl2dpi_bridge_mode_set(struct drm_bridge *bridge,
>   							adjusted_mode);
>   	}
>   }
>   
>   static void imx8qxp_pxl2dpi_bridge_atomic_disable(struct drm_bridge *bridge,
> -						  struct drm_atomic_state *state)
> +						  struct drm_atomic_commit *state)
>   {
>   	struct imx8qxp_pxl2dpi *p2d = bridge->driver_private;
>   
>   	pm_runtime_put(p2d->dev);
>   
> diff --git a/drivers/gpu/drm/bridge/inno-hdmi.c b/drivers/gpu/drm/bridge/inno-hdmi.c
> index 87422d15d9a2148498fb257667049939788071fd..1091af29ad8f1dfc5fb5b57c5323ef5a4f358edd 100644
> --- a/drivers/gpu/drm/bridge/inno-hdmi.c
> +++ b/drivers/gpu/drm/bridge/inno-hdmi.c
> @@ -754,11 +754,11 @@ static int inno_hdmi_config_video_timing(struct inno_hdmi *hdmi,
>   	hdmi_writeb(hdmi, HDMI_PHY_FEEDBACK_DIV_RATIO_HIGH, 0x01);
>   
>   	return 0;
>   }
>   
> -static int inno_hdmi_setup(struct inno_hdmi *hdmi, struct drm_atomic_state *state)
> +static int inno_hdmi_setup(struct inno_hdmi *hdmi, struct drm_atomic_commit *state)
>   {
>   	struct drm_bridge *bridge = &hdmi->bridge;
>   	struct drm_connector *connector;
>   	struct drm_display_info *info;
>   	struct drm_connector_state *new_conn_state;
> @@ -861,19 +861,19 @@ inno_hdmi_bridge_edid_read(struct drm_bridge *bridge, struct drm_connector *conn
>   
>   	return drm_edid;
>   }
>   
>   static void inno_hdmi_bridge_atomic_enable(struct drm_bridge *bridge,
> -					   struct drm_atomic_state *state)
> +					   struct drm_atomic_commit *state)
>   {
>   	struct inno_hdmi *hdmi = bridge_to_inno_hdmi(bridge);
>   
>   	inno_hdmi_setup(hdmi, state);
>   }
>   
>   static void inno_hdmi_bridge_atomic_disable(struct drm_bridge *bridge,
> -					    struct drm_atomic_state *state)
> +					    struct drm_atomic_commit *state)
>   {
>   	struct inno_hdmi *hdmi = bridge_to_inno_hdmi(bridge);
>   
>   	inno_hdmi_standby(hdmi);
>   }
> diff --git a/drivers/gpu/drm/bridge/ite-it6263.c b/drivers/gpu/drm/bridge/ite-it6263.c
> index 4f3ebb7af4d4d845f2458caa739fa56991fc78a7..48499aaba6a9aa85afc932cf4c4747b6e5dbf331 100644
> --- a/drivers/gpu/drm/bridge/ite-it6263.c
> +++ b/drivers/gpu/drm/bridge/ite-it6263.c
> @@ -577,22 +577,22 @@ static int it6263_read_edid(void *data, u8 *buf, unsigned int block, size_t len)
>   
>   	return 0;
>   }
>   
>   static void it6263_bridge_atomic_disable(struct drm_bridge *bridge,
> -					 struct drm_atomic_state *state)
> +					 struct drm_atomic_commit *state)
>   {
>   	struct it6263 *it = bridge_to_it6263(bridge);
>   
>   	regmap_write_bits(it->hdmi_regmap, HDMI_REG_GCP, AVMUTE, AVMUTE);
>   	regmap_write(it->hdmi_regmap, HDMI_REG_PKT_GENERAL_CTRL, 0);
>   	regmap_write(it->hdmi_regmap, HDMI_REG_AFE_DRV_CTRL,
>   		     AFE_DRV_RST | AFE_DRV_PWD);
>   }
>   
>   static void it6263_bridge_atomic_enable(struct drm_bridge *bridge,
> -					struct drm_atomic_state *state)
> +					struct drm_atomic_commit *state)
>   {
>   	struct it6263 *it = bridge_to_it6263(bridge);
>   	const struct drm_crtc_state *crtc_state;
>   	struct regmap *regmap = it->hdmi_regmap;
>   	const struct drm_display_mode *mode;
> diff --git a/drivers/gpu/drm/bridge/ite-it6505.c b/drivers/gpu/drm/bridge/ite-it6505.c
> index a094803ba7aa4e12165fcde432d4e6417fbf3676..0651e44fc07e4d3f6762b5e6742c7bd3dffde586 100644
> --- a/drivers/gpu/drm/bridge/ite-it6505.c
> +++ b/drivers/gpu/drm/bridge/ite-it6505.c
> @@ -3117,11 +3117,11 @@ it6505_bridge_mode_valid(struct drm_bridge *bridge,
>   
>   	return MODE_OK;
>   }
>   
>   static void it6505_bridge_atomic_enable(struct drm_bridge *bridge,
> -					struct drm_atomic_state *state)
> +					struct drm_atomic_commit *state)
>   {
>   	struct it6505 *it6505 = bridge_to_it6505(bridge);
>   	struct device *dev = it6505->dev;
>   	struct hdmi_avi_infoframe frame;
>   	struct drm_crtc_state *crtc_state;
> @@ -3171,11 +3171,11 @@ static void it6505_bridge_atomic_enable(struct drm_bridge *bridge,
>   
>   	drm_dp_link_power_up(&it6505->aux, it6505->link.revision);
>   }
>   
>   static void it6505_bridge_atomic_disable(struct drm_bridge *bridge,
> -					 struct drm_atomic_state *state)
> +					 struct drm_atomic_commit *state)
>   {
>   	struct it6505 *it6505 = bridge_to_it6505(bridge);
>   	struct device *dev = it6505->dev;
>   
>   	DRM_DEV_DEBUG_DRIVER(dev, "start");
> @@ -3185,22 +3185,22 @@ static void it6505_bridge_atomic_disable(struct drm_bridge *bridge,
>   		it6505_video_disable(it6505);
>   	}
>   }
>   
>   static void it6505_bridge_atomic_pre_enable(struct drm_bridge *bridge,
> -					    struct drm_atomic_state *state)
> +					    struct drm_atomic_commit *state)
>   {
>   	struct it6505 *it6505 = bridge_to_it6505(bridge);
>   	struct device *dev = it6505->dev;
>   
>   	DRM_DEV_DEBUG_DRIVER(dev, "start");
>   
>   	pm_runtime_get_sync(dev);
>   }
>   
>   static void it6505_bridge_atomic_post_disable(struct drm_bridge *bridge,
> -					      struct drm_atomic_state *state)
> +					      struct drm_atomic_commit *state)
>   {
>   	struct it6505 *it6505 = bridge_to_it6505(bridge);
>   	struct device *dev = it6505->dev;
>   
>   	DRM_DEV_DEBUG_DRIVER(dev, "start");
> diff --git a/drivers/gpu/drm/bridge/ite-it66121.c b/drivers/gpu/drm/bridge/ite-it66121.c
> index 9246e9c15a6ef588d18d5a67234e836e50ac96f4..19a027d75b6101e93ba55be6982c9ea871de8bb0 100644
> --- a/drivers/gpu/drm/bridge/ite-it66121.c
> +++ b/drivers/gpu/drm/bridge/ite-it66121.c
> @@ -720,21 +720,21 @@ static u32 *it66121_bridge_atomic_get_input_bus_fmts(struct drm_bridge *bridge,
>   
>   	return input_fmts;
>   }
>   
>   static void it66121_bridge_enable(struct drm_bridge *bridge,
> -				  struct drm_atomic_state *state)
> +				  struct drm_atomic_commit *state)
>   {
>   	struct it66121_ctx *ctx = container_of(bridge, struct it66121_ctx, bridge);
>   
>   	ctx->connector = drm_atomic_get_new_connector_for_encoder(state, bridge->encoder);
>   
>   	it66121_set_mute(ctx, false);
>   }
>   
>   static void it66121_bridge_disable(struct drm_bridge *bridge,
> -				   struct drm_atomic_state *state)
> +				   struct drm_atomic_commit *state)
>   {
>   	struct it66121_ctx *ctx = container_of(bridge, struct it66121_ctx, bridge);
>   
>   	it66121_set_mute(ctx, true);
>   
> diff --git a/drivers/gpu/drm/bridge/lontium-lt9211.c b/drivers/gpu/drm/bridge/lontium-lt9211.c
> index 03fc8fd10f20aa486ac6869e816a1e0f11f05d8b..870175a8483900772d622085f0edf9d50f906b9e 100644
> --- a/drivers/gpu/drm/bridge/lontium-lt9211.c
> +++ b/drivers/gpu/drm/bridge/lontium-lt9211.c
> @@ -453,11 +453,11 @@ static int lt9211_configure_tx(struct lt9211 *ctx, bool jeida,
>   
>   	return 0;
>   }
>   
>   static void lt9211_atomic_enable(struct drm_bridge *bridge,
> -				 struct drm_atomic_state *state)
> +				 struct drm_atomic_commit *state)
>   {
>   	struct lt9211 *ctx = bridge_to_lt9211(bridge);
>   	const struct drm_bridge_state *bridge_state;
>   	const struct drm_crtc_state *crtc_state;
>   	const struct drm_display_mode *mode;
> @@ -550,11 +550,11 @@ static void lt9211_atomic_enable(struct drm_bridge *bridge,
>   
>   	dev_dbg(ctx->dev, "LT9211 enabled.\n");
>   }
>   
>   static void lt9211_atomic_disable(struct drm_bridge *bridge,
> -				  struct drm_atomic_state *state)
> +				  struct drm_atomic_commit *state)
>   {
>   	struct lt9211 *ctx = bridge_to_lt9211(bridge);
>   	int ret;
>   
>   	/*
> diff --git a/drivers/gpu/drm/bridge/lontium-lt9611.c b/drivers/gpu/drm/bridge/lontium-lt9611.c
> index 4517aee83332a1deef84a039da7199002944c945..0f49b13193b930d3a75a2d3cfaf8cf9ed92ee360 100644
> --- a/drivers/gpu/drm/bridge/lontium-lt9611.c
> +++ b/drivers/gpu/drm/bridge/lontium-lt9611.c
> @@ -655,11 +655,11 @@ lt9611_get_edid_block(void *data, u8 *buf, unsigned int block, size_t len)
>   	return 0;
>   }
>   
>   /* bridge funcs */
>   static void lt9611_bridge_atomic_enable(struct drm_bridge *bridge,
> -					struct drm_atomic_state *state)
> +					struct drm_atomic_commit *state)
>   {
>   	struct lt9611 *lt9611 = bridge_to_lt9611(bridge);
>   	struct drm_connector *connector;
>   	struct drm_connector_state *conn_state;
>   	struct drm_crtc_state *crtc_state;
> @@ -702,11 +702,11 @@ static void lt9611_bridge_atomic_enable(struct drm_bridge *bridge,
>   	/* Enable HDMI output */
>   	regmap_write(lt9611->regmap, 0x8130, 0xea);
>   }
>   
>   static void lt9611_bridge_atomic_disable(struct drm_bridge *bridge,
> -					 struct drm_atomic_state *state)
> +					 struct drm_atomic_commit *state)
>   {
>   	struct lt9611 *lt9611 = bridge_to_lt9611(bridge);
>   	int ret;
>   
>   	/* Disable HDMI output */
> @@ -780,11 +780,11 @@ static enum drm_mode_status lt9611_bridge_mode_valid(struct drm_bridge *bridge,
>   
>   	return MODE_OK;
>   }
>   
>   static void lt9611_bridge_atomic_pre_enable(struct drm_bridge *bridge,
> -					    struct drm_atomic_state *state)
> +					    struct drm_atomic_commit *state)
>   {
>   	struct lt9611 *lt9611 = bridge_to_lt9611(bridge);
>   	static const struct reg_sequence reg_cfg[] = {
>   		{ 0x8102, 0x12 },
>   		{ 0x8123, 0x40 },
> @@ -800,11 +800,11 @@ static void lt9611_bridge_atomic_pre_enable(struct drm_bridge *bridge,
>   
>   	lt9611->sleep = false;
>   }
>   
>   static void lt9611_bridge_atomic_post_disable(struct drm_bridge *bridge,
> -					      struct drm_atomic_state *state)
> +					      struct drm_atomic_commit *state)
>   {
>   	struct lt9611 *lt9611 = bridge_to_lt9611(bridge);
>   
>   	lt9611_sleep_setup(lt9611);
>   }
> diff --git a/drivers/gpu/drm/bridge/nwl-dsi.c b/drivers/gpu/drm/bridge/nwl-dsi.c
> index 2f7429b24fc20db104dec17182f1119c6c75e600..3c9ae93c4f671216c365917a8a297169595e5a7d 100644
> --- a/drivers/gpu/drm/bridge/nwl-dsi.c
> +++ b/drivers/gpu/drm/bridge/nwl-dsi.c
> @@ -735,11 +735,11 @@ static int nwl_dsi_disable(struct nwl_dsi *dsi)
>   
>   	return 0;
>   }
>   
>   static void nwl_dsi_bridge_atomic_disable(struct drm_bridge *bridge,
> -					  struct drm_atomic_state *state)
> +					  struct drm_atomic_commit *state)
>   {
>   	struct nwl_dsi *dsi = bridge_to_dsi(bridge);
>   	int ret;
>   
>   	nwl_dsi_disable(dsi);
> @@ -896,11 +896,11 @@ nwl_dsi_bridge_mode_set(struct drm_bridge *bridge,
>   runtime_put:
>   	pm_runtime_put_sync(dev);
>   }
>   
>   static void nwl_dsi_bridge_atomic_enable(struct drm_bridge *bridge,
> -					 struct drm_atomic_state *state)
> +					 struct drm_atomic_commit *state)
>   {
>   	struct nwl_dsi *dsi = bridge_to_dsi(bridge);
>   	int ret;
>   
>   	/* Step 5 from DSI reset-out instructions */
> diff --git a/drivers/gpu/drm/bridge/panel.c b/drivers/gpu/drm/bridge/panel.c
> index 184a8b7049a7e664befc737756b4846247eadae6..4978ec98a082848b6496df8419894f5e3d4c977b 100644
> --- a/drivers/gpu/drm/bridge/panel.c
> +++ b/drivers/gpu/drm/bridge/panel.c
> @@ -109,11 +109,11 @@ static void panel_bridge_detach(struct drm_bridge *bridge)
>   	if (connector->dev)
>   		drm_connector_cleanup(connector);
>   }
>   
>   static void panel_bridge_atomic_pre_enable(struct drm_bridge *bridge,
> -					   struct drm_atomic_state *atomic_state)
> +					   struct drm_atomic_commit *atomic_state)
>   {
>   	struct panel_bridge *panel_bridge = drm_bridge_to_panel_bridge(bridge);
>   	struct drm_encoder *encoder = bridge->encoder;
>   	struct drm_crtc *crtc;
>   	struct drm_crtc_state *old_crtc_state;
> @@ -128,11 +128,11 @@ static void panel_bridge_atomic_pre_enable(struct drm_bridge *bridge,
>   
>   	drm_panel_prepare(panel_bridge->panel);
>   }
>   
>   static void panel_bridge_atomic_enable(struct drm_bridge *bridge,
> -				       struct drm_atomic_state *atomic_state)
> +				       struct drm_atomic_commit *atomic_state)
>   {
>   	struct panel_bridge *panel_bridge = drm_bridge_to_panel_bridge(bridge);
>   	struct drm_encoder *encoder = bridge->encoder;
>   	struct drm_crtc *crtc;
>   	struct drm_crtc_state *old_crtc_state;
> @@ -147,11 +147,11 @@ static void panel_bridge_atomic_enable(struct drm_bridge *bridge,
>   
>   	drm_panel_enable(panel_bridge->panel);
>   }
>   
>   static void panel_bridge_atomic_disable(struct drm_bridge *bridge,
> -					struct drm_atomic_state *atomic_state)
> +					struct drm_atomic_commit *atomic_state)
>   {
>   	struct panel_bridge *panel_bridge = drm_bridge_to_panel_bridge(bridge);
>   	struct drm_encoder *encoder = bridge->encoder;
>   	struct drm_crtc *crtc;
>   	struct drm_crtc_state *new_crtc_state;
> @@ -166,11 +166,11 @@ static void panel_bridge_atomic_disable(struct drm_bridge *bridge,
>   
>   	drm_panel_disable(panel_bridge->panel);
>   }
>   
>   static void panel_bridge_atomic_post_disable(struct drm_bridge *bridge,
> -					     struct drm_atomic_state *atomic_state)
> +					     struct drm_atomic_commit *atomic_state)
>   {
>   	struct panel_bridge *panel_bridge = drm_bridge_to_panel_bridge(bridge);
>   	struct drm_encoder *encoder = bridge->encoder;
>   	struct drm_crtc *crtc;
>   	struct drm_crtc_state *new_crtc_state;
> diff --git a/drivers/gpu/drm/bridge/parade-ps8640.c b/drivers/gpu/drm/bridge/parade-ps8640.c
> index 825777a5758f67b5bdaa5f9de2e0e4f597f0f7a4..b93514023baa8ba03216b5eac4899edf9ea3fa93 100644
> --- a/drivers/gpu/drm/bridge/parade-ps8640.c
> +++ b/drivers/gpu/drm/bridge/parade-ps8640.c
> @@ -435,11 +435,11 @@ static const struct dev_pm_ops ps8640_pm_ops = {
>   	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
>   				pm_runtime_force_resume)
>   };
>   
>   static void ps8640_atomic_pre_enable(struct drm_bridge *bridge,
> -				     struct drm_atomic_state *state)
> +				     struct drm_atomic_commit *state)
>   {
>   	struct ps8640 *ps_bridge = bridge_to_ps8640(bridge);
>   	struct regmap *map = ps_bridge->regmap[PAGE2_TOP_CNTL];
>   	struct device *dev = &ps_bridge->page[PAGE0_DP_CNTL]->dev;
>   	int ret;
> @@ -470,11 +470,11 @@ static void ps8640_atomic_pre_enable(struct drm_bridge *bridge,
>   
>   	ps_bridge->pre_enabled = true;
>   }
>   
>   static void ps8640_atomic_post_disable(struct drm_bridge *bridge,
> -				       struct drm_atomic_state *state)
> +				       struct drm_atomic_commit *state)
>   {
>   	struct ps8640 *ps_bridge = bridge_to_ps8640(bridge);
>   
>   	ps_bridge->pre_enabled = false;
>   
> diff --git a/drivers/gpu/drm/bridge/samsung-dsim.c b/drivers/gpu/drm/bridge/samsung-dsim.c
> index c3eb437ef1b0b2b259adf100e49f43e9201cc2e8..9ee0515074c78ae027adea5d9872bda3d258bc66 100644
> --- a/drivers/gpu/drm/bridge/samsung-dsim.c
> +++ b/drivers/gpu/drm/bridge/samsung-dsim.c
> @@ -1638,11 +1638,11 @@ static int samsung_dsim_init(struct samsung_dsim *dsi)
>   
>   	return 0;
>   }
>   
>   static void samsung_dsim_atomic_pre_enable(struct drm_bridge *bridge,
> -					   struct drm_atomic_state *state)
> +					   struct drm_atomic_commit *state)
>   {
>   	struct samsung_dsim *dsi = bridge_to_dsi(bridge);
>   	int ret;
>   
>   	if (dsi->state & DSIM_STATE_ENABLED)
> @@ -1666,22 +1666,22 @@ static void samsung_dsim_atomic_pre_enable(struct drm_bridge *bridge,
>   			return;
>   	}
>   }
>   
>   static void samsung_dsim_atomic_enable(struct drm_bridge *bridge,
> -				       struct drm_atomic_state *state)
> +				       struct drm_atomic_commit *state)
>   {
>   	struct samsung_dsim *dsi = bridge_to_dsi(bridge);
>   
>   	samsung_dsim_set_display_mode(dsi);
>   	samsung_dsim_set_display_enable(dsi, true);
>   
>   	dsi->state |= DSIM_STATE_VIDOUT_AVAILABLE;
>   }
>   
>   static void samsung_dsim_atomic_disable(struct drm_bridge *bridge,
> -					struct drm_atomic_state *state)
> +					struct drm_atomic_commit *state)
>   {
>   	struct samsung_dsim *dsi = bridge_to_dsi(bridge);
>   
>   	if (!(dsi->state & DSIM_STATE_ENABLED))
>   		return;
> @@ -1689,11 +1689,11 @@ static void samsung_dsim_atomic_disable(struct drm_bridge *bridge,
>   	samsung_dsim_set_display_enable(dsi, false);
>   	dsi->state &= ~DSIM_STATE_VIDOUT_AVAILABLE;
>   }
>   
>   static void samsung_dsim_atomic_post_disable(struct drm_bridge *bridge,
> -					     struct drm_atomic_state *state)
> +					     struct drm_atomic_commit *state)
>   {
>   	struct samsung_dsim *dsi = bridge_to_dsi(bridge);
>   
>   	dsi->state &= ~DSIM_STATE_ENABLED;
>   	pm_runtime_put_sync(dsi->dev);
> diff --git a/drivers/gpu/drm/bridge/sii902x.c b/drivers/gpu/drm/bridge/sii902x.c
> index 12497f5ce4ff577cae1e10d6cd387cdd03dd1658..ea543be4ae3e2109f37698fcb142ea02083df230 100644
> --- a/drivers/gpu/drm/bridge/sii902x.c
> +++ b/drivers/gpu/drm/bridge/sii902x.c
> @@ -319,11 +319,11 @@ static int sii902x_get_modes(struct drm_connector *connector)
>   static const struct drm_connector_helper_funcs sii902x_connector_helper_funcs = {
>   	.get_modes = sii902x_get_modes,
>   };
>   
>   static void sii902x_bridge_atomic_disable(struct drm_bridge *bridge,
> -					  struct drm_atomic_state *state)
> +					  struct drm_atomic_commit *state)
>   {
>   	struct sii902x *sii902x = bridge_to_sii902x(bridge);
>   
>   	mutex_lock(&sii902x->mutex);
>   
> @@ -333,11 +333,11 @@ static void sii902x_bridge_atomic_disable(struct drm_bridge *bridge,
>   
>   	mutex_unlock(&sii902x->mutex);
>   }
>   
>   static void sii902x_bridge_atomic_enable(struct drm_bridge *bridge,
> -					 struct drm_atomic_state *state)
> +					 struct drm_atomic_commit *state)
>   {
>   	struct sii902x *sii902x = bridge_to_sii902x(bridge);
>   	struct drm_connector *connector;
>   	u8 output_mode = SII902X_SYS_CTRL_OUTPUT_DVI;
>   
> diff --git a/drivers/gpu/drm/bridge/ssd2825.c b/drivers/gpu/drm/bridge/ssd2825.c
> index f2fdbf7c117d34b261444f03bb32b6c8017822e4..91f1510fc2d407672efaf614cf0ce6166f8365b7 100644
> --- a/drivers/gpu/drm/bridge/ssd2825.c
> +++ b/drivers/gpu/drm/bridge/ssd2825.c
> @@ -480,11 +480,11 @@ static int ssd2825_setup_pll(struct ssd2825_priv *priv,
>   
>   	return 0;
>   }
>   
>   static void ssd2825_bridge_atomic_pre_enable(struct drm_bridge *bridge,
> -					     struct drm_atomic_state *state)
> +					     struct drm_atomic_commit *state)
>   {
>   	struct ssd2825_priv *priv = bridge_to_ssd2825(bridge);
>   	struct mipi_dsi_device *dsi_dev = priv->output.dev;
>   	const struct drm_crtc_state *crtc_state;
>   	const struct drm_display_mode *mode;
> @@ -583,11 +583,11 @@ static void ssd2825_bridge_atomic_pre_enable(struct drm_bridge *bridge,
>   	if (priv->output.panel)
>   		drm_panel_enable(priv->output.panel);
>   }
>   
>   static void ssd2825_bridge_atomic_enable(struct drm_bridge *bridge,
> -					 struct drm_atomic_state *state)
> +					 struct drm_atomic_commit *state)
>   {
>   	struct ssd2825_priv *priv = bridge_to_ssd2825(bridge);
>   	struct mipi_dsi_device *dsi_dev = priv->output.dev;
>   	u16 config;
>   
> @@ -605,11 +605,11 @@ static void ssd2825_bridge_atomic_enable(struct drm_bridge *bridge,
>   	ssd2825_write_reg(priv, SSD2825_PLL_CTRL_REG, 0x0001);
>   	ssd2825_write_reg(priv, SSD2825_VC_CTRL_REG, 0x0000);
>   }
>   
>   static void ssd2825_bridge_atomic_disable(struct drm_bridge *bridge,
> -					  struct drm_atomic_state *state)
> +					  struct drm_atomic_commit *state)
>   {
>   	struct ssd2825_priv *priv = bridge_to_ssd2825(bridge);
>   	int ret;
>   
>   	msleep(100);
> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-dp.c b/drivers/gpu/drm/bridge/synopsys/dw-dp.c
> index 45b37885d719dcf291383499a69d7e27c36513b2..3cfa7d73bec2beb280efcb86495f4457b5326395 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-dp.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-dp.c
> @@ -1642,11 +1642,11 @@ static int dw_dp_link_enable(struct dw_dp *dp)
>   
>   	return ret;
>   }
>   
>   static void dw_dp_bridge_atomic_enable(struct drm_bridge *bridge,
> -				       struct drm_atomic_state *state)
> +				       struct drm_atomic_commit *state)
>   {
>   	struct dw_dp *dp = bridge_to_dp(bridge);
>   	struct drm_connector *connector;
>   	struct drm_connector_state *conn_state;
>   	int ret;
> @@ -1695,11 +1695,11 @@ static void dw_dp_reset(struct dw_dp *dp)
>   	regmap_write(dp->regmap, DW_DP_HPD_STATUS, HPD_HOT_PLUG);
>   	enable_irq(dp->irq);
>   }
>   
>   static void dw_dp_bridge_atomic_disable(struct drm_bridge *bridge,
> -					struct drm_atomic_state *state)
> +					struct drm_atomic_commit *state)
>   {
>   	struct dw_dp *dp = bridge_to_dp(bridge);
>   
>   	dw_dp_video_disable(dp);
>   	dw_dp_link_disable(dp);
> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
> index d649a1cf07f5cfd6c6de78f6ba5ecd88d0ea08c1..0dbb1274360945088f578a366dbf6ab560677df1 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
> @@ -748,11 +748,11 @@ static struct i2c_adapter *dw_hdmi_qp_i2c_adapter(struct dw_hdmi_qp *hdmi)
>   
>   	return adap;
>   }
>   
>   static void dw_hdmi_qp_bridge_atomic_enable(struct drm_bridge *bridge,
> -					    struct drm_atomic_state *state)
> +					    struct drm_atomic_commit *state)
>   {
>   	struct dw_hdmi_qp *hdmi = bridge->driver_private;
>   	struct drm_connector_state *conn_state;
>   	struct drm_connector *connector;
>   	unsigned int op_mode;
> @@ -783,11 +783,11 @@ static void dw_hdmi_qp_bridge_atomic_enable(struct drm_bridge *bridge,
>   
>   	drm_atomic_helper_connector_hdmi_update_infoframes(connector, state);
>   }
>   
>   static void dw_hdmi_qp_bridge_atomic_disable(struct drm_bridge *bridge,
> -					     struct drm_atomic_state *state)
> +					     struct drm_atomic_commit *state)
>   {
>   	struct dw_hdmi_qp *hdmi = bridge->driver_private;
>   
>   	hdmi->tmds_char_rate = 0;
>   
> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> index 0296e110ce65ffc284e120f4e3f92052474e83e5..255bc3b37eba5c7ad6fecf07db411d0b101f2eae 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> @@ -2527,11 +2527,11 @@ static int dw_hdmi_connector_get_modes(struct drm_connector *connector)
>   
>   	return ret;
>   }
>   
>   static int dw_hdmi_connector_atomic_check(struct drm_connector *connector,
> -					  struct drm_atomic_state *state)
> +					  struct drm_atomic_commit *state)
>   {
>   	struct drm_connector_state *old_state =
>   		drm_atomic_get_old_connector_state(state, connector);
>   	struct drm_connector_state *new_state =
>   		drm_atomic_get_new_connector_state(state, connector);
> @@ -2960,11 +2960,11 @@ static void dw_hdmi_bridge_mode_set(struct drm_bridge *bridge,
>   
>   	mutex_unlock(&hdmi->mutex);
>   }
>   
>   static void dw_hdmi_bridge_atomic_disable(struct drm_bridge *bridge,
> -					  struct drm_atomic_state *state)
> +					  struct drm_atomic_commit *state)
>   {
>   	struct dw_hdmi *hdmi = bridge->driver_private;
>   
>   	mutex_lock(&hdmi->mutex);
>   	hdmi->disabled = true;
> @@ -2974,11 +2974,11 @@ static void dw_hdmi_bridge_atomic_disable(struct drm_bridge *bridge,
>   	handle_plugged_change(hdmi, false);
>   	mutex_unlock(&hdmi->mutex);
>   }
>   
>   static void dw_hdmi_bridge_atomic_enable(struct drm_bridge *bridge,
> -					 struct drm_atomic_state *state)
> +					 struct drm_atomic_commit *state)
>   {
>   	struct dw_hdmi *hdmi = bridge->driver_private;
>   	struct drm_connector *connector;
>   
>   	connector = drm_atomic_get_new_connector_for_encoder(state,
> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
> index ca4dea226f4b5f7b6a3e869baa7bd9281e507e9d..db3f62ef135e2a7f3eb6cac9de73e2d93e92ad7d 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
> @@ -933,11 +933,11 @@ static void dw_mipi_dsi_clear_err(struct dw_mipi_dsi *dsi)
>   	dsi_write(dsi, DSI_INT_MSK0, 0);
>   	dsi_write(dsi, DSI_INT_MSK1, 0);
>   }
>   
>   static void dw_mipi_dsi_bridge_post_atomic_disable(struct drm_bridge *bridge,
> -						   struct drm_atomic_state *state)
> +						   struct drm_atomic_commit *state)
>   {
>   	struct dw_mipi_dsi *dsi = bridge_to_dsi(bridge);
>   	const struct dw_mipi_dsi_phy_ops *phy_ops = dsi->plat_data->phy_ops;
>   
>   	/*
> @@ -1021,11 +1021,11 @@ static void dw_mipi_dsi_mode_set(struct dw_mipi_dsi *dsi,
>   	if (phy_ops->power_on)
>   		phy_ops->power_on(dsi->plat_data->priv_data);
>   }
>   
>   static void dw_mipi_dsi_bridge_atomic_pre_enable(struct drm_bridge *bridge,
> -						 struct drm_atomic_state *state)
> +						 struct drm_atomic_commit *state)
>   {
>   	struct dw_mipi_dsi *dsi = bridge_to_dsi(bridge);
>   
>   	/* Power up the dsi ctl into a command mode */
>   	dw_mipi_dsi_mode_set(dsi, &dsi->mode);
> @@ -1042,11 +1042,11 @@ static void dw_mipi_dsi_bridge_mode_set(struct drm_bridge *bridge,
>   	/* Store the display mode for later use in pre_enable callback */
>   	drm_mode_copy(&dsi->mode, adjusted_mode);
>   }
>   
>   static void dw_mipi_dsi_bridge_atomic_enable(struct drm_bridge *bridge,
> -					     struct drm_atomic_state *state)
> +					     struct drm_atomic_commit *state)
>   {
>   	struct dw_mipi_dsi *dsi = bridge_to_dsi(bridge);
>   
>   	/* Switch to video mode for panel-bridge enable & panel enable */
>   	dw_mipi_dsi_set_mode(dsi, MIPI_DSI_MODE_VIDEO);
> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi2.c b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi2.c
> index e6eaf9fd02516b0ee67680da28f789044cdae8f6..66da317628334a9486f44d18d036bcba9c5f6070 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi2.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi2.c
> @@ -744,11 +744,11 @@ static int dw_mipi_dsi2_bridge_atomic_check(struct drm_bridge *bridge,
>   
>   	return 0;
>   }
>   
>   static void dw_mipi_dsi2_bridge_post_atomic_disable(struct drm_bridge *bridge,
> -						    struct drm_atomic_state *state)
> +						    struct drm_atomic_commit *state)
>   {
>   	struct dw_mipi_dsi2 *dsi2 = bridge_to_dsi2(bridge);
>   	const struct dw_mipi_dsi2_phy_ops *phy_ops = dsi2->plat_data->phy_ops;
>   
>   	regmap_write(dsi2->regmap, DSI2_IPI_PIX_PKT_CFG, 0);
> @@ -820,11 +820,11 @@ static void dw_mipi_dsi2_mode_set(struct dw_mipi_dsi2 *dsi2,
>   
>   	dw_mipi_dsi2_ipi_set(dsi2);
>   }
>   
>   static void dw_mipi_dsi2_bridge_atomic_pre_enable(struct drm_bridge *bridge,
> -						  struct drm_atomic_state *state)
> +						  struct drm_atomic_commit *state)
>   {
>   	struct dw_mipi_dsi2 *dsi2 = bridge_to_dsi2(bridge);
>   
>   	/* Power up the dsi ctl into a command mode */
>   	dw_mipi_dsi2_mode_set(dsi2, &dsi2->mode);
> @@ -839,11 +839,11 @@ static void dw_mipi_dsi2_bridge_mode_set(struct drm_bridge *bridge,
>   	/* Store the display mode for later use in pre_enable callback */
>   	drm_mode_copy(&dsi2->mode, adjusted_mode);
>   }
>   
>   static void dw_mipi_dsi2_bridge_atomic_enable(struct drm_bridge *bridge,
> -					      struct drm_atomic_state *state)
> +					      struct drm_atomic_commit *state)
>   {
>   	struct dw_mipi_dsi2 *dsi2 = bridge_to_dsi2(bridge);
>   
>   	/* Switch to video mode for panel-bridge enable & panel enable */
>   	if (dsi2->mode_flags & MIPI_DSI_MODE_VIDEO)
> diff --git a/drivers/gpu/drm/bridge/tc358762.c b/drivers/gpu/drm/bridge/tc358762.c
> index 98df3e667d4aac48c19c82c8bc9e116b36a4cec8..3d75d9cfa45e06f367f60ecdca09ffb0ec0f5798 100644
> --- a/drivers/gpu/drm/bridge/tc358762.c
> +++ b/drivers/gpu/drm/bridge/tc358762.c
> @@ -148,11 +148,11 @@ static int tc358762_init(struct tc358762 *ctx)
>   
>   	return tc358762_clear_error(ctx);
>   }
>   
>   static void tc358762_post_disable(struct drm_bridge *bridge,
> -				  struct drm_atomic_state *state)
> +				  struct drm_atomic_commit *state)
>   {
>   	struct tc358762 *ctx = bridge_to_tc358762(bridge);
>   	int ret;
>   
>   	/*
> @@ -171,11 +171,11 @@ static void tc358762_post_disable(struct drm_bridge *bridge,
>   	if (ret < 0)
>   		dev_err(ctx->dev, "error disabling regulators (%d)\n", ret);
>   }
>   
>   static void tc358762_pre_enable(struct drm_bridge *bridge,
> -				struct drm_atomic_state *state)
> +				struct drm_atomic_commit *state)
>   {
>   	struct tc358762 *ctx = bridge_to_tc358762(bridge);
>   	int ret;
>   
>   	ret = regulator_enable(ctx->regulator);
> @@ -189,11 +189,11 @@ static void tc358762_pre_enable(struct drm_bridge *bridge,
>   
>   	ctx->pre_enabled = true;
>   }
>   
>   static void tc358762_enable(struct drm_bridge *bridge,
> -			    struct drm_atomic_state *state)
> +			    struct drm_atomic_commit *state)
>   {
>   	struct tc358762 *ctx = bridge_to_tc358762(bridge);
>   	int ret;
>   
>   	ret = tc358762_init(ctx);
> diff --git a/drivers/gpu/drm/bridge/tc358767.c b/drivers/gpu/drm/bridge/tc358767.c
> index 4097fef4b86b5fa87f9032fe55a8df4d9dfb3403..7188935fdb826181579a08614434501759325b4b 100644
> --- a/drivers/gpu/drm/bridge/tc358767.c
> +++ b/drivers/gpu/drm/bridge/tc358767.c
> @@ -1555,11 +1555,11 @@ static int tc_edp_stream_disable(struct tc_data *tc)
>   
>   	return 0;
>   }
>   
>   static void tc_dpi_bridge_atomic_enable(struct drm_bridge *bridge,
> -					struct drm_atomic_state *state)
> +					struct drm_atomic_commit *state)
>   
>   {
>   	struct tc_data *tc = bridge_to_tc(bridge);
>   	int ret;
>   
> @@ -1570,22 +1570,22 @@ static void tc_dpi_bridge_atomic_enable(struct drm_bridge *bridge,
>   		return;
>   	}
>   }
>   
>   static void tc_dpi_bridge_atomic_disable(struct drm_bridge *bridge,
> -					 struct drm_atomic_state *state)
> +					 struct drm_atomic_commit *state)
>   {
>   	struct tc_data *tc = bridge_to_tc(bridge);
>   	int ret;
>   
>   	ret = tc_dpi_stream_disable(tc);
>   	if (ret < 0)
>   		dev_err(tc->dev, "main link stream stop error: %d\n", ret);
>   }
>   
>   static void tc_edp_bridge_atomic_enable(struct drm_bridge *bridge,
> -					struct drm_atomic_state *state)
> +					struct drm_atomic_commit *state)
>   {
>   	struct tc_data *tc = bridge_to_tc(bridge);
>   	int ret;
>   
>   	ret = tc_get_display_props(tc);
> @@ -1607,11 +1607,11 @@ static void tc_edp_bridge_atomic_enable(struct drm_bridge *bridge,
>   		return;
>   	}
>   }
>   
>   static void tc_edp_bridge_atomic_disable(struct drm_bridge *bridge,
> -					 struct drm_atomic_state *state)
> +					 struct drm_atomic_commit *state)
>   {
>   	struct tc_data *tc = bridge_to_tc(bridge);
>   	int ret;
>   
>   	ret = tc_edp_stream_disable(tc);
> diff --git a/drivers/gpu/drm/bridge/tc358768.c b/drivers/gpu/drm/bridge/tc358768.c
> index fbdc44e162293f2f9b090bc956604184a2a406b2..e652a2bcd64aa577dcdadaadd1c59560cf1917ff 100644
> --- a/drivers/gpu/drm/bridge/tc358768.c
> +++ b/drivers/gpu/drm/bridge/tc358768.c
> @@ -580,11 +580,11 @@ tc358768_bridge_mode_valid(struct drm_bridge *bridge,
>   
>   	return MODE_OK;
>   }
>   
>   static void tc358768_bridge_atomic_disable(struct drm_bridge *bridge,
> -					   struct drm_atomic_state *state)
> +					   struct drm_atomic_commit *state)
>   {
>   	struct tc358768_priv *priv = bridge_to_tc358768(bridge);
>   	int ret;
>   
>   	/* set FrmStop */
> @@ -603,11 +603,11 @@ static void tc358768_bridge_atomic_disable(struct drm_bridge *bridge,
>   	if (ret)
>   		dev_warn(priv->dev, "Software disable failed: %d\n", ret);
>   }
>   
>   static void tc358768_bridge_atomic_post_disable(struct drm_bridge *bridge,
> -						struct drm_atomic_state *state)
> +						struct drm_atomic_commit *state)
>   {
>   	struct tc358768_priv *priv = bridge_to_tc358768(bridge);
>   
>   	tc358768_hw_disable(priv);
>   }
> @@ -684,11 +684,11 @@ static u32 tc358768_dsi_bytes_to_ns(struct tc358768_priv *priv, u32 val)
>   
>   	return (u32)div_u64(m, n);
>   }
>   
>   static void tc358768_bridge_atomic_pre_enable(struct drm_bridge *bridge,
> -					      struct drm_atomic_state *state)
> +					      struct drm_atomic_commit *state)
>   {
>   	struct tc358768_priv *priv = bridge_to_tc358768(bridge);
>   	struct mipi_dsi_device *dsi_dev = priv->output.dev;
>   	unsigned long mode_flags = dsi_dev->mode_flags;
>   	u32 val, val2, lptxcnt, hact, data_type;
> @@ -1089,11 +1089,11 @@ static void tc358768_bridge_atomic_pre_enable(struct drm_bridge *bridge,
>   	if (ret)
>   		dev_err(dev, "Bridge pre_enable failed: %d\n", ret);
>   }
>   
>   static void tc358768_bridge_atomic_enable(struct drm_bridge *bridge,
> -					  struct drm_atomic_state *state)
> +					  struct drm_atomic_commit *state)
>   {
>   	struct tc358768_priv *priv = bridge_to_tc358768(bridge);
>   	int ret;
>   
>   	if (!priv->enabled) {
> diff --git a/drivers/gpu/drm/bridge/tc358775.c b/drivers/gpu/drm/bridge/tc358775.c
> index 366b12db0e7cbfb45b3dfc2a83a7af580cfde41f..e067b671cecee518e9bae308974fc74f1db7b0e1 100644
> --- a/drivers/gpu/drm/bridge/tc358775.c
> +++ b/drivers/gpu/drm/bridge/tc358775.c
> @@ -285,11 +285,11 @@ static inline struct tc_data *bridge_to_tc(struct drm_bridge *b)
>   {
>   	return container_of(b, struct tc_data, bridge);
>   }
>   
>   static void tc_bridge_atomic_pre_enable(struct drm_bridge *bridge,
> -					struct drm_atomic_state *state)
> +					struct drm_atomic_commit *state)
>   {
>   	struct tc_data *tc = bridge_to_tc(bridge);
>   	struct device *dev = &tc->dsi->dev;
>   	int ret;
>   
> @@ -309,11 +309,11 @@ static void tc_bridge_atomic_pre_enable(struct drm_bridge *bridge,
>   	gpiod_set_value(tc->reset_gpio, 0);
>   	usleep_range(10, 20);
>   }
>   
>   static void tc_bridge_atomic_post_disable(struct drm_bridge *bridge,
> -					  struct drm_atomic_state *state)
> +					  struct drm_atomic_commit *state)
>   {
>   	struct tc_data *tc = bridge_to_tc(bridge);
>   	struct device *dev = &tc->dsi->dev;
>   	int ret;
>   
> @@ -369,11 +369,11 @@ static void d2l_write(struct i2c_client *i2c, u16 addr, u32 val)
>   		dev_err(&i2c->dev, "Error %d writing to subaddress 0x%x\n",
>   			ret, addr);
>   }
>   
>   static void tc_bridge_atomic_enable(struct drm_bridge *bridge,
> -				    struct drm_atomic_state *state)
> +				    struct drm_atomic_commit *state)
>   {
>   	struct tc_data *tc = bridge_to_tc(bridge);
>   	u32 hback_porch, hsync_len, hfront_porch, hactive, htime1, htime2;
>   	u32 vback_porch, vsync_len, vfront_porch, vactive, vtime1, vtime2;
>   	u32 val = 0;
> diff --git a/drivers/gpu/drm/bridge/ti-dlpc3433.c b/drivers/gpu/drm/bridge/ti-dlpc3433.c
> index b07f7c9d5890967a6db7bb01a9695abc809babbd..9c35eade0a78edc5af05d2ab91f5fc1bf2705ce8 100644
> --- a/drivers/gpu/drm/bridge/ti-dlpc3433.c
> +++ b/drivers/gpu/drm/bridge/ti-dlpc3433.c
> @@ -103,11 +103,11 @@ static const struct regmap_config dlpc_regmap_config = {
>   	.cache_type		= REGCACHE_MAPLE,
>   	.name			= "dlpc3433",
>   };
>   
>   static void dlpc_atomic_enable(struct drm_bridge *bridge,
> -			       struct drm_atomic_state *state)
> +			       struct drm_atomic_commit *state)
>   {
>   	struct dlpc *dlpc = bridge_to_dlpc(bridge);
>   	struct device *dev = dlpc->dev;
>   	struct drm_display_mode *mode = &dlpc->mode;
>   	struct regmap *regmap = dlpc->regmap;
> @@ -168,11 +168,11 @@ static void dlpc_atomic_enable(struct drm_bridge *bridge,
>   
>   	msleep(10);
>   }
>   
>   static void dlpc_atomic_pre_enable(struct drm_bridge *bridge,
> -				   struct drm_atomic_state *state)
> +				   struct drm_atomic_commit *state)
>   {
>   	struct dlpc *dlpc = bridge_to_dlpc(bridge);
>   	int ret;
>   
>   	gpiod_set_value(dlpc->enable_gpio, 1);
> @@ -191,11 +191,11 @@ static void dlpc_atomic_pre_enable(struct drm_bridge *bridge,
>   
>   	msleep(10);
>   }
>   
>   static void dlpc_atomic_post_disable(struct drm_bridge *bridge,
> -				     struct drm_atomic_state *state)
> +				     struct drm_atomic_commit *state)
>   {
>   	struct dlpc *dlpc = bridge_to_dlpc(bridge);
>   
>   	regulator_disable(dlpc->vcc_flsh);
>   	regulator_disable(dlpc->vcc_intf);
> diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi83.c b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
> index 17a885244e1e160b53fc56ae31e9b6ddae996720..108953a8fa4534e50562711d8e0d737a45f5d385 100644
> --- a/drivers/gpu/drm/bridge/ti-sn65dsi83.c
> +++ b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
> @@ -512,11 +512,11 @@ static void sn65dsi83_release_resources(void *data)
>   
>   	regcache_mark_dirty(ctx->regmap);
>   }
>   
>   static void sn65dsi83_atomic_pre_enable(struct drm_bridge *bridge,
> -					struct drm_atomic_state *state)
> +					struct drm_atomic_commit *state)
>   {
>   	struct sn65dsi83 *ctx = bridge_to_sn65dsi83(bridge);
>   	const unsigned int dual_factor = ctx->lvds_dual_link ? 2 : 1;
>   	const struct drm_bridge_state *bridge_state;
>   	const struct drm_crtc_state *crtc_state;
> @@ -694,11 +694,11 @@ static void sn65dsi83_atomic_pre_enable(struct drm_bridge *bridge,
>   err_exit:
>   	drm_bridge_exit(idx);
>   }
>   
>   static void sn65dsi83_atomic_enable(struct drm_bridge *bridge,
> -				    struct drm_atomic_state *state)
> +				    struct drm_atomic_commit *state)
>   {
>   	struct sn65dsi83 *ctx = bridge_to_sn65dsi83(bridge);
>   	unsigned int pval;
>   	int idx;
>   
> @@ -726,11 +726,11 @@ static void sn65dsi83_atomic_enable(struct drm_bridge *bridge,
>   
>   	drm_bridge_exit(idx);
>   }
>   
>   static void sn65dsi83_atomic_disable(struct drm_bridge *bridge,
> -				     struct drm_atomic_state *state)
> +				     struct drm_atomic_commit *state)
>   {
>   	struct sn65dsi83 *ctx = bridge_to_sn65dsi83(bridge);
>   	int idx;
>   
>   	if (!drm_bridge_enter(bridge, &idx))
> diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> index 98d64ad791d04009236c8e0ff98abf364c86f644..671b2bc75cb1c83805f506c4cd9a9ff7c0fe3c2a 100644
> --- a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> +++ b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> @@ -276,11 +276,11 @@ static void ti_sn65dsi86_write_u16(struct ti_sn65dsi86 *pdata,
>   	regmap_bulk_write(pdata->regmap, reg, buf, ARRAY_SIZE(buf));
>   }
>   
>   static struct drm_display_mode *
>   get_new_adjusted_display_mode(struct drm_bridge *bridge,
> -			      struct drm_atomic_state *state)
> +			      struct drm_atomic_commit *state)
>   {
>   	struct drm_connector *connector =
>   		drm_atomic_get_new_connector_for_encoder(state, bridge->encoder);
>   	struct drm_connector_state *conn_state =
>   		drm_atomic_get_new_connector_state(state, connector);
> @@ -289,11 +289,11 @@ get_new_adjusted_display_mode(struct drm_bridge *bridge,
>   
>   	return &crtc_state->adjusted_mode;
>   }
>   
>   static u32 ti_sn_bridge_get_dsi_freq(struct ti_sn65dsi86 *pdata,
> -				     struct drm_atomic_state *state)
> +				     struct drm_atomic_commit *state)
>   {
>   	u32 bit_rate_khz, clk_freq_khz;
>   	struct drm_display_mode *mode =
>   		get_new_adjusted_display_mode(&pdata->bridge, state);
>   
> @@ -321,11 +321,11 @@ static const u32 ti_sn_bridge_dsiclk_lut[] = {
>   	486000000,
>   	460800000,
>   };
>   
>   static void ti_sn_bridge_set_refclk_freq(struct ti_sn65dsi86 *pdata,
> -					 struct drm_atomic_state *state)
> +					 struct drm_atomic_commit *state)
>   {
>   	int i;
>   	u32 refclk_rate;
>   	const u32 *refclk_lut;
>   	size_t refclk_lut_size;
> @@ -359,11 +359,11 @@ static void ti_sn_bridge_set_refclk_freq(struct ti_sn65dsi86 *pdata,
>   	 */
>   	pdata->pwm_refclk_freq = ti_sn_bridge_refclk_lut[i];
>   }
>   
>   static void ti_sn65dsi86_enable_comms(struct ti_sn65dsi86 *pdata,
> -				      struct drm_atomic_state *state)
> +				      struct drm_atomic_commit *state)
>   {
>   	mutex_lock(&pdata->comms_mutex);
>   
>   	/* configure bridge ref_clk */
>   	ti_sn_bridge_set_refclk_freq(pdata, state);
> @@ -824,20 +824,20 @@ ti_sn_bridge_mode_valid(struct drm_bridge *bridge,
>   
>   	return MODE_OK;
>   }
>   
>   static void ti_sn_bridge_atomic_disable(struct drm_bridge *bridge,
> -					struct drm_atomic_state *state)
> +					struct drm_atomic_commit *state)
>   {
>   	struct ti_sn65dsi86 *pdata = bridge_to_ti_sn65dsi86(bridge);
>   
>   	/* disable video stream */
>   	regmap_update_bits(pdata->regmap, SN_ENH_FRAME_REG, VSTREAM_ENABLE, 0);
>   }
>   
>   static void ti_sn_bridge_set_dsi_rate(struct ti_sn65dsi86 *pdata,
> -				      struct drm_atomic_state *state)
> +				      struct drm_atomic_commit *state)
>   {
>   	unsigned int bit_rate_mhz, clk_freq_mhz;
>   	unsigned int val;
>   	struct drm_display_mode *mode =
>   		get_new_adjusted_display_mode(&pdata->bridge, state);
> @@ -869,11 +869,11 @@ static unsigned int ti_sn_bridge_get_bpp(struct drm_connector *connector)
>   static const unsigned int ti_sn_bridge_dp_rate_lut[] = {
>   	0, 1620, 2160, 2430, 2700, 3240, 4320, 5400
>   };
>   
>   static int ti_sn_bridge_calc_min_dp_rate_idx(struct ti_sn65dsi86 *pdata,
> -					     struct drm_atomic_state *state,
> +					     struct drm_atomic_commit *state,
>   					     unsigned int bpp)
>   {
>   	unsigned int bit_rate_khz, dp_rate_mhz;
>   	unsigned int i;
>   	struct drm_display_mode *mode =
> @@ -975,11 +975,11 @@ static unsigned int ti_sn_bridge_read_valid_rates(struct ti_sn65dsi86 *pdata)
>   
>   	return valid_rates;
>   }
>   
>   static void ti_sn_bridge_set_video_timings(struct ti_sn65dsi86 *pdata,
> -					   struct drm_atomic_state *state)
> +					   struct drm_atomic_commit *state)
>   {
>   	struct drm_display_mode *mode =
>   		get_new_adjusted_display_mode(&pdata->bridge, state);
>   	u8 hsync_polarity = 0, vsync_polarity = 0;
>   
> @@ -1088,11 +1088,11 @@ static int ti_sn_link_training(struct ti_sn65dsi86 *pdata, int dp_rate_idx,
>   
>   	return ret;
>   }
>   
>   static void ti_sn_bridge_atomic_enable(struct drm_bridge *bridge,
> -				       struct drm_atomic_state *state)
> +				       struct drm_atomic_commit *state)
>   {
>   	struct ti_sn65dsi86 *pdata = bridge_to_ti_sn65dsi86(bridge);
>   	struct drm_connector *connector;
>   	const char *last_err_str = "No supported DP rate";
>   	unsigned int valid_rates;
> @@ -1179,11 +1179,11 @@ static void ti_sn_bridge_atomic_enable(struct drm_bridge *bridge,
>   	regmap_update_bits(pdata->regmap, SN_ENH_FRAME_REG, VSTREAM_ENABLE,
>   			   VSTREAM_ENABLE);
>   }
>   
>   static void ti_sn_bridge_atomic_pre_enable(struct drm_bridge *bridge,
> -					   struct drm_atomic_state *state)
> +					   struct drm_atomic_commit *state)
>   {
>   	struct ti_sn65dsi86 *pdata = bridge_to_ti_sn65dsi86(bridge);
>   
>   	pm_runtime_get_sync(pdata->dev);
>   
> @@ -1193,11 +1193,11 @@ static void ti_sn_bridge_atomic_pre_enable(struct drm_bridge *bridge,
>   	/* td7: min 100 us after enable before DSI data */
>   	usleep_range(100, 110);
>   }
>   
>   static void ti_sn_bridge_atomic_post_disable(struct drm_bridge *bridge,
> -					     struct drm_atomic_state *state)
> +					     struct drm_atomic_commit *state)
>   {
>   	struct ti_sn65dsi86 *pdata = bridge_to_ti_sn65dsi86(bridge);
>   
>   	/* semi auto link training mode OFF */
>   	regmap_write(pdata->regmap, SN_ML_TX_MODE_REG, 0);
> diff --git a/drivers/gpu/drm/bridge/ti-tdp158.c b/drivers/gpu/drm/bridge/ti-tdp158.c
> index 27053d020df7c6fabbd5ce631b46c3f2358f12b2..3a19967f213fb6f5552497af2b3b4c585516d854 100644
> --- a/drivers/gpu/drm/bridge/ti-tdp158.c
> +++ b/drivers/gpu/drm/bridge/ti-tdp158.c
> @@ -17,11 +17,11 @@ struct tdp158 {
>   	struct regulator *vdd; // 1.1V
>   	struct device *dev;
>   };
>   
>   static void tdp158_enable(struct drm_bridge *bridge,
> -			  struct drm_atomic_state *state)
> +			  struct drm_atomic_commit *state)
>   {
>   	int err;
>   	struct tdp158 *tdp158 = bridge->driver_private;
>   
>   	err = regulator_enable(tdp158->vcc);
> @@ -34,11 +34,11 @@ static void tdp158_enable(struct drm_bridge *bridge,
>   
>   	gpiod_set_value_cansleep(tdp158->enable, 1);
>   }
>   
>   static void tdp158_disable(struct drm_bridge *bridge,
> -			   struct drm_atomic_state *state)
> +			   struct drm_atomic_commit *state)
>   {
>   	struct tdp158 *tdp158 = bridge->driver_private;
>   
>   	gpiod_set_value_cansleep(tdp158->enable, 0);
>   	regulator_disable(tdp158->vdd);
> diff --git a/drivers/gpu/drm/ci/xfails/vkms-none-skips.txt b/drivers/gpu/drm/ci/xfails/vkms-none-skips.txt
> index 716d2d4e452d84862fb775c90c9cb4dd84c55578..afcc09d1683d8103bcf79eea745ea6cb9ee2dac4 100644
> --- a/drivers/gpu/drm/ci/xfails/vkms-none-skips.txt
> +++ b/drivers/gpu/drm/ci/xfails/vkms-none-skips.txt
> @@ -286,12 +286,12 @@ kms_cursor_edge_walk@128x128-left-edge
>   #  ? exc_invalid_op+0x17/0x70
>   #  ? asm_exc_invalid_op+0x1a/0x20
>   #  ? __pfx_drm_property_free_blob+0x10/0x10
>   #  ? vkms_atomic_crtc_destroy_state+0x31/0x40 [vkms]
>   #  ? vkms_atomic_crtc_destroy_state+0x10/0x40 [vkms]
> -#  drm_atomic_state_default_clear+0x137/0x2f0
> -#  __drm_atomic_state_free+0x6c/0xb0
> +#  drm_atomic_commit_default_clear+0x137/0x2f0
> +#  __drm_atomic_commit_free+0x6c/0xb0
>   #  drm_atomic_helper_update_plane+0x100/0x150
>   #  drm_mode_cursor_universal+0x10e/0x270
>   #  drm_mode_cursor_common+0x115/0x240
>   #  ? __pfx_drm_mode_cursor_ioctl+0x10/0x10
>   #  drm_mode_cursor_ioctl+0x4a/0x70
> @@ -392,12 +392,12 @@ kms_cursor_edge_walk@128x128-left-edge
>   #  ? exc_invalid_op+0x17/0x70
>   #  ? asm_exc_invalid_op+0x1a/0x20
>   #  ? __pfx_drm_property_free_blob+0x10/0x10
>   #  ? vkms_atomic_crtc_destroy_state+0x31/0x40 [vkms]
>   #  ? vkms_atomic_crtc_destroy_state+0x10/0x40 [vkms]
> -#  drm_atomic_state_default_clear+0x137/0x2f0
> -#  __drm_atomic_state_free+0x6c/0xb0
> +#  drm_atomic_commit_default_clear+0x137/0x2f0
> +#  __drm_atomic_commit_free+0x6c/0xb0
>   #  drm_atomic_helper_update_plane+0x100/0x150
>   #  drm_mode_cursor_universal+0x10e/0x270
>   #  drm_mode_cursor_common+0x115/0x240
>   #  ? __pfx_drm_mode_cursor_ioctl+0x10/0x10
>   #  drm_mode_cursor_ioctl+0x4a/0x70
> @@ -498,12 +498,12 @@ kms_cursor_edge_walk@128x128-left-edge
>   #  ? exc_invalid_op+0x17/0x70
>   #  ? asm_exc_invalid_op+0x1a/0x20
>   #  ? __pfx_drm_property_free_blob+0x10/0x10
>   #  ? vkms_atomic_crtc_destroy_state+0x31/0x40 [vkms]
>   #  ? vkms_atomic_crtc_destroy_state+0x10/0x40 [vkms]
> -#  drm_atomic_state_default_clear+0x137/0x2f0
> -#  __drm_atomic_state_free+0x6c/0xb0
> +#  drm_atomic_commit_default_clear+0x137/0x2f0
> +#  __drm_atomic_commit_free+0x6c/0xb0
>   #  drm_atomic_helper_update_plane+0x100/0x150
>   #  drm_mode_cursor_universal+0x10e/0x270
>   #  drm_mode_cursor_common+0x115/0x240
>   #  ? __pfx_drm_mode_cursor_ioctl+0x10/0x10
>   #  drm_mode_cursor_ioctl+0x4a/0x70
> @@ -604,12 +604,12 @@ kms_cursor_edge_walk@128x128-left-edge
>   #  ? exc_invalid_op+0x17/0x70
>   #  ? asm_exc_invalid_op+0x1a/0x20
>   #  ? __pfx_drm_property_free_blob+0x10/0x10
>   #  ? vkms_atomic_crtc_destroy_state+0x31/0x40 [vkms]
>   #  ? vkms_atomic_crtc_destroy_state+0x10/0x40 [vkms]
> -#  drm_atomic_state_default_clear+0x137/0x2f0
> -#  __drm_atomic_state_free+0x6c/0xb0
> +#  drm_atomic_commit_default_clear+0x137/0x2f0
> +#  __drm_atomic_commit_free+0x6c/0xb0
>   #  drm_atomic_helper_update_plane+0x100/0x150
>   #  drm_mode_cursor_universal+0x10e/0x270
>   #  drm_mode_cursor_common+0x115/0x240
>   #  ? __pfx_drm_mode_cursor_ioctl+0x10/0x10
>   #  drm_mode_cursor_ioctl+0x4a/0x70
> @@ -710,12 +710,12 @@ kms_cursor_edge_walk@128x128-left-edge
>   #  ? exc_invalid_op+0x17/0x70
>   #  ? asm_exc_invalid_op+0x1a/0x20
>   #  ? __pfx_drm_property_free_blob+0x10/0x10
>   #  ? vkms_atomic_crtc_destroy_state+0x31/0x40 [vkms]
>   #  ? vkms_atomic_crtc_destroy_state+0x10/0x40 [vkms]
> -#  drm_atomic_state_default_clear+0x137/0x2f0
> -#  __drm_atomic_state_free+0x6c/0xb0
> +#  drm_atomic_commit_default_clear+0x137/0x2f0
> +#  __drm_atomic_commit_free+0x6c/0xb0
>   #  drm_atomic_helper_update_plane+0x100/0x150
>   #  drm_mode_cursor_universal+0x10e/0x270
>   #  drm_mode_cursor_common+0x115/0x240
>   #  ? __pfx_drm_mode_cursor_ioctl+0x10/0x10
>   #  drm_mode_cursor_ioctl+0x4a/0x70
> diff --git a/drivers/gpu/drm/display/drm_bridge_connector.c b/drivers/gpu/drm/display/drm_bridge_connector.c
> index 39cc18f78eda11ba35954f75315f646c0cb0d8e6..a23b7e33fba614c099cba12318893329aaea08fe 100644
> --- a/drivers/gpu/drm/display/drm_bridge_connector.c
> +++ b/drivers/gpu/drm/display/drm_bridge_connector.c
> @@ -369,11 +369,11 @@ drm_bridge_connector_mode_valid(struct drm_connector *connector,
>   
>   	return MODE_OK;
>   }
>   
>   static int drm_bridge_connector_atomic_check(struct drm_connector *connector,
> -					     struct drm_atomic_state *state)
> +					     struct drm_atomic_commit *state)
>   {
>   	struct drm_bridge_connector *bridge_connector =
>   		to_drm_bridge_connector(connector);
>   
>   	if (bridge_connector->bridge_hdmi)
> diff --git a/drivers/gpu/drm/display/drm_dp_mst_topology.c b/drivers/gpu/drm/display/drm_dp_mst_topology.c
> index 8757972e8e2427cbbab2e90d1c9c291d97e96c0a..35dc4f24ae53efa3cfd37430241af2c6531d3d77 100644
> --- a/drivers/gpu/drm/display/drm_dp_mst_topology.c
> +++ b/drivers/gpu/drm/display/drm_dp_mst_topology.c
> @@ -4431,11 +4431,11 @@ EXPORT_SYMBOL(drm_dp_mst_get_edid);
>    *
>    * Returns:
>    * Total slots in the atomic state assigned for this port, or a negative error
>    * code if the port no longer exists
>    */
> -int drm_dp_atomic_find_time_slots(struct drm_atomic_state *state,
> +int drm_dp_atomic_find_time_slots(struct drm_atomic_commit *state,
>   				  struct drm_dp_mst_topology_mgr *mgr,
>   				  struct drm_dp_mst_port *port, int pbn)
>   {
>   	struct drm_dp_mst_topology_state *topology_state;
>   	struct drm_dp_mst_atomic_payload *payload = NULL;
> @@ -4521,11 +4521,11 @@ EXPORT_SYMBOL(drm_dp_atomic_find_time_slots);
>    * drm_dp_mst_atomic_check()
>    *
>    * Returns:
>    * 0 on success, negative error code otherwise
>    */
> -int drm_dp_atomic_release_time_slots(struct drm_atomic_state *state,
> +int drm_dp_atomic_release_time_slots(struct drm_atomic_commit *state,
>   				     struct drm_dp_mst_topology_mgr *mgr,
>   				     struct drm_dp_mst_port *port)
>   {
>   	struct drm_dp_mst_topology_state *topology_state;
>   	struct drm_dp_mst_atomic_payload *payload;
> @@ -4589,11 +4589,11 @@ EXPORT_SYMBOL(drm_dp_atomic_release_time_slots);
>    * &drm_mode_config_helper_funcs.atomic_commit_setup hook.
>    *
>    * Returns:
>    * 0 if all CRTC commits were retrieved successfully, negative error code otherwise
>    */
> -int drm_dp_mst_atomic_setup_commit(struct drm_atomic_state *state)
> +int drm_dp_mst_atomic_setup_commit(struct drm_atomic_commit *state)
>   {
>   	struct drm_dp_mst_topology_mgr *mgr;
>   	struct drm_dp_mst_topology_state *mst_state;
>   	struct drm_crtc *crtc;
>   	struct drm_crtc_state *crtc_state;
> @@ -4639,11 +4639,11 @@ EXPORT_SYMBOL(drm_dp_mst_atomic_setup_commit);
>    * determined at commit-time) from the previous state.
>    *
>    * All MST drivers must call this function after calling drm_atomic_helper_wait_for_dependencies(),
>    * or whatever their equivalent of that is.
>    */
> -void drm_dp_mst_atomic_wait_for_dependencies(struct drm_atomic_state *state)
> +void drm_dp_mst_atomic_wait_for_dependencies(struct drm_atomic_commit *state)
>   {
>   	struct drm_dp_mst_topology_state *old_mst_state, *new_mst_state;
>   	struct drm_dp_mst_topology_mgr *mgr;
>   	struct drm_dp_mst_atomic_payload *old_payload, *new_payload;
>   	int i, j, ret;
> @@ -4696,11 +4696,11 @@ EXPORT_SYMBOL(drm_dp_mst_atomic_wait_for_dependencies);
>    * 0 on success, negative error code otherwise
>    */
>   int drm_dp_mst_root_conn_atomic_check(struct drm_connector_state *new_conn_state,
>   				      struct drm_dp_mst_topology_mgr *mgr)
>   {
> -	struct drm_atomic_state *state = new_conn_state->state;
> +	struct drm_atomic_commit *state = new_conn_state->state;
>   	struct drm_connector_state *old_conn_state =
>   		drm_atomic_get_old_connector_state(state, new_conn_state->connector);
>   	struct drm_crtc_state *crtc_state;
>   	struct drm_dp_mst_topology_state *mst_state = NULL;
>   
> @@ -5434,11 +5434,11 @@ drm_dp_mst_atomic_check_payload_alloc_limits(struct drm_dp_mst_topology_mgr *mgr
>    * CRTCs in that topology
>    *
>    * See also:
>    * drm_dp_mst_atomic_enable_dsc()
>    */
> -int drm_dp_mst_add_affected_dsc_crtcs(struct drm_atomic_state *state, struct drm_dp_mst_topology_mgr *mgr)
> +int drm_dp_mst_add_affected_dsc_crtcs(struct drm_atomic_commit *state, struct drm_dp_mst_topology_mgr *mgr)
>   {
>   	struct drm_dp_mst_topology_state *mst_state;
>   	struct drm_dp_mst_atomic_payload *pos;
>   	struct drm_connector *connector;
>   	struct drm_connector_state *conn_state;
> @@ -5484,22 +5484,22 @@ int drm_dp_mst_add_affected_dsc_crtcs(struct drm_atomic_state *state, struct drm
>   }
>   EXPORT_SYMBOL(drm_dp_mst_add_affected_dsc_crtcs);
>   
>   /**
>    * drm_dp_mst_atomic_enable_dsc - Set DSC Enable Flag to On/Off
> - * @state: Pointer to the new drm_atomic_state
> + * @state: Pointer to the new drm_atomic_commit
>    * @port: Pointer to the affected MST Port
>    * @pbn: Newly recalculated bw required for link with DSC enabled
>    * @enable: Boolean flag to enable or disable DSC on the port
>    *
>    * This function enables DSC on the given Port
>    * by recalculating its vcpi from pbn provided
>    * and sets dsc_enable flag to keep track of which
>    * ports have DSC enabled
>    *
>    */
> -int drm_dp_mst_atomic_enable_dsc(struct drm_atomic_state *state,
> +int drm_dp_mst_atomic_enable_dsc(struct drm_atomic_commit *state,
>   				 struct drm_dp_mst_port *port,
>   				 int pbn, bool enable)
>   {
>   	struct drm_dp_mst_topology_state *mst_state;
>   	struct drm_dp_mst_atomic_payload *payload;
> @@ -5574,11 +5574,11 @@ EXPORT_SYMBOL(drm_dp_mst_atomic_enable_dsc);
>    *           the BW limit check.
>    *
>    *   - %-EINVAL, if the new state is invalid, because the root port has
>    *     too many payloads.
>    */
> -int drm_dp_mst_atomic_check_mgr(struct drm_atomic_state *state,
> +int drm_dp_mst_atomic_check_mgr(struct drm_atomic_commit *state,
>   				struct drm_dp_mst_topology_mgr *mgr,
>   				struct drm_dp_mst_topology_state *mst_state,
>   				struct drm_dp_mst_port **failing_port)
>   {
>   	int ret;
> @@ -5621,11 +5621,11 @@ EXPORT_SYMBOL(drm_dp_mst_atomic_check_mgr);
>    * drm_dp_atomic_release_time_slots()
>    *
>    * Returns:
>    * 0 if the new state is valid, negative error code otherwise.
>    */
> -int drm_dp_mst_atomic_check(struct drm_atomic_state *state)
> +int drm_dp_mst_atomic_check(struct drm_atomic_commit *state)
>   {
>   	struct drm_dp_mst_topology_mgr *mgr;
>   	struct drm_dp_mst_topology_state *mst_state;
>   	int i, ret = 0;
>   
> @@ -5658,11 +5658,11 @@ EXPORT_SYMBOL(drm_dp_mst_topology_state_funcs);
>    * topology object.
>    *
>    * RETURNS:
>    * The MST topology state or error pointer.
>    */
> -struct drm_dp_mst_topology_state *drm_atomic_get_mst_topology_state(struct drm_atomic_state *state,
> +struct drm_dp_mst_topology_state *drm_atomic_get_mst_topology_state(struct drm_atomic_commit *state,
>   								    struct drm_dp_mst_topology_mgr *mgr)
>   {
>   	return to_dp_mst_topology_state(drm_atomic_get_private_obj_state(state, &mgr->base));
>   }
>   EXPORT_SYMBOL(drm_atomic_get_mst_topology_state);
> @@ -5679,11 +5679,11 @@ EXPORT_SYMBOL(drm_atomic_get_mst_topology_state);
>    * Returns:
>    * The old MST topology state, or NULL if there's no topology state for this MST mgr
>    * in the global atomic state
>    */
>   struct drm_dp_mst_topology_state *
> -drm_atomic_get_old_mst_topology_state(struct drm_atomic_state *state,
> +drm_atomic_get_old_mst_topology_state(struct drm_atomic_commit *state,
>   				      struct drm_dp_mst_topology_mgr *mgr)
>   {
>   	struct drm_private_state *old_priv_state =
>   		drm_atomic_get_old_private_obj_state(state, &mgr->base);
>   
> @@ -5703,11 +5703,11 @@ EXPORT_SYMBOL(drm_atomic_get_old_mst_topology_state);
>    * Returns:
>    * The new MST topology state, or NULL if there's no topology state for this MST mgr
>    * in the global atomic state
>    */
>   struct drm_dp_mst_topology_state *
> -drm_atomic_get_new_mst_topology_state(struct drm_atomic_state *state,
> +drm_atomic_get_new_mst_topology_state(struct drm_atomic_commit *state,
>   				      struct drm_dp_mst_topology_mgr *mgr)
>   {
>   	struct drm_private_state *new_priv_state =
>   		drm_atomic_get_new_private_obj_state(state, &mgr->base);
>   
> diff --git a/drivers/gpu/drm/display/drm_dp_tunnel.c b/drivers/gpu/drm/display/drm_dp_tunnel.c
> index 6519b42447285b58892ac07a3570cf6c457e4c27..bb67f1b8362678def6e61097ffde639b274d7235 100644
> --- a/drivers/gpu/drm/display/drm_dp_tunnel.c
> +++ b/drivers/gpu/drm/display/drm_dp_tunnel.c
> @@ -1367,11 +1367,11 @@ int drm_dp_tunnel_available_bw(const struct drm_dp_tunnel *tunnel)
>   	return tunnel->group->available_bw;
>   }
>   EXPORT_SYMBOL(drm_dp_tunnel_available_bw);
>   
>   static struct drm_dp_tunnel_group_state *
> -drm_dp_tunnel_atomic_get_group_state(struct drm_atomic_state *state,
> +drm_dp_tunnel_atomic_get_group_state(struct drm_atomic_commit *state,
>   				     const struct drm_dp_tunnel *tunnel)
>   {
>   	return (struct drm_dp_tunnel_group_state *)
>   		drm_atomic_get_private_obj_state(state,
>   						 &tunnel->group->base);
> @@ -1526,11 +1526,11 @@ static const struct drm_private_state_funcs tunnel_group_funcs = {
>    * state if not yet allocated.
>    *
>    * Return the state or an ERR_PTR() error on failure.
>    */
>   struct drm_dp_tunnel_state *
> -drm_dp_tunnel_atomic_get_state(struct drm_atomic_state *state,
> +drm_dp_tunnel_atomic_get_state(struct drm_atomic_commit *state,
>   			       struct drm_dp_tunnel *tunnel)
>   {
>   	struct drm_dp_tunnel_group_state *group_state;
>   	struct drm_dp_tunnel_state *tunnel_state;
>   
> @@ -1554,11 +1554,11 @@ EXPORT_SYMBOL(drm_dp_tunnel_atomic_get_state);
>    * Get the old atomic state for @tunnel.
>    *
>    * Return the old state or NULL if the tunnel's atomic state is not in @state.
>    */
>   struct drm_dp_tunnel_state *
> -drm_dp_tunnel_atomic_get_old_state(struct drm_atomic_state *state,
> +drm_dp_tunnel_atomic_get_old_state(struct drm_atomic_commit *state,
>   				   const struct drm_dp_tunnel *tunnel)
>   {
>   	struct drm_dp_tunnel_group_state *old_group_state;
>   	int i;
>   
> @@ -1578,11 +1578,11 @@ EXPORT_SYMBOL(drm_dp_tunnel_atomic_get_old_state);
>    * Get the new atomic state for @tunnel.
>    *
>    * Return the new state or NULL if the tunnel's atomic state is not in @state.
>    */
>   struct drm_dp_tunnel_state *
> -drm_dp_tunnel_atomic_get_new_state(struct drm_atomic_state *state,
> +drm_dp_tunnel_atomic_get_new_state(struct drm_atomic_commit *state,
>   				   const struct drm_dp_tunnel *tunnel)
>   {
>   	struct drm_dp_tunnel_group_state *new_group_state;
>   	int i;
>   
> @@ -1704,11 +1704,11 @@ static int clear_stream_bw(struct drm_dp_tunnel_state *tunnel_state,
>    *
>    * Set a DP tunnel stream's required BW in the atomic state.
>    *
>    * Returns 0 in case of success, a negative error code otherwise.
>    */
> -int drm_dp_tunnel_atomic_set_stream_bw(struct drm_atomic_state *state,
> +int drm_dp_tunnel_atomic_set_stream_bw(struct drm_atomic_commit *state,
>   				       struct drm_dp_tunnel *tunnel,
>   				       u8 stream_id, int bw)
>   {
>   	struct drm_dp_tunnel_group_state *new_group_state;
>   	struct drm_dp_tunnel_state *tunnel_state;
> @@ -1781,11 +1781,11 @@ EXPORT_SYMBOL(drm_dp_tunnel_atomic_get_required_bw);
>    * Get the mask of all the stream IDs in the tunnel group of @tunnel.
>    *
>    * Return 0 in case of success - with the stream IDs in @stream_mask - or a
>    * negative error code in case of failure.
>    */
> -int drm_dp_tunnel_atomic_get_group_streams_in_state(struct drm_atomic_state *state,
> +int drm_dp_tunnel_atomic_get_group_streams_in_state(struct drm_atomic_commit *state,
>   						    const struct drm_dp_tunnel *tunnel,
>   						    u32 *stream_mask)
>   {
>   	struct drm_dp_tunnel_group_state *group_state;
>   	struct drm_dp_tunnel_state *tunnel_state;
> @@ -1859,11 +1859,11 @@ drm_dp_tunnel_atomic_check_group_bw(struct drm_dp_tunnel_group_state *new_group_
>    *
>    * Return 0 if all the BW limit checks passed, -ENOSPC in case a BW limit
>    * check failed - with @failed_stream_mask containing the streams failing the
>    * check - or a negative error code otherwise.
>    */
> -int drm_dp_tunnel_atomic_check_stream_bws(struct drm_atomic_state *state,
> +int drm_dp_tunnel_atomic_check_stream_bws(struct drm_atomic_commit *state,
>   					  u32 *failed_stream_mask)
>   {
>   	struct drm_dp_tunnel_group_state *new_group_state;
>   	int i;
>   
> diff --git a/drivers/gpu/drm/display/drm_hdmi_state_helper.c b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
> index 9f3b696aceeb4b60e6e7dea6bc5458ce5027a4aa..4867edbf2622bf7c92c42203280e8e82d8d19656 100644
> --- a/drivers/gpu/drm/display/drm_hdmi_state_helper.c
> +++ b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
> @@ -346,11 +346,11 @@ output_color_format_to_hdmi_colorspace(const struct drm_connector *connector,
>   }
>   
>   static const struct drm_display_mode *
>   connector_state_get_mode(const struct drm_connector_state *conn_state)
>   {
> -	struct drm_atomic_state *state;
> +	struct drm_atomic_commit *state;
>   	struct drm_crtc_state *crtc_state;
>   	struct drm_crtc *crtc;
>   
>   	state = conn_state->state;
>   	if (!state)
> @@ -856,11 +856,11 @@ hdmi_generate_infoframes(const struct drm_connector *connector,
>    *
>    * RETURNS:
>    * Zero on success, or an errno code otherwise.
>    */
>   int drm_atomic_helper_connector_hdmi_check(struct drm_connector *connector,
> -					   struct drm_atomic_state *state)
> +					   struct drm_atomic_commit *state)
>   {
>   	struct drm_connector_state *old_conn_state =
>   		drm_atomic_get_old_connector_state(state, connector);
>   	struct drm_connector_state *new_conn_state =
>   		drm_atomic_get_new_connector_state(state, connector);
> @@ -998,11 +998,11 @@ static int write_or_clear_infoframe(struct drm_connector *connector,
>    *
>    * Returns:
>    * Zero on success, error code on failure.
>    */
>   int drm_atomic_helper_connector_hdmi_update_infoframes(struct drm_connector *connector,
> -						       struct drm_atomic_state *state)
> +						       struct drm_atomic_commit *state)
>   {
>   	const struct drm_connector_hdmi_funcs *funcs = connector->hdmi.funcs;
>   	struct drm_connector_state *old_conn_state =
>   		drm_atomic_get_old_connector_state(state, connector);
>   	struct drm_connector_state *new_conn_state =
> diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
> index 41c57063f3b4d6d6e61a274d818844fa9bd582bf..4ffa057e27847913309c9c68faa4d20436183b9b 100644
> --- a/drivers/gpu/drm/drm_atomic.c
> +++ b/drivers/gpu/drm/drm_atomic.c
> @@ -93,39 +93,39 @@ int drm_crtc_commit_wait(struct drm_crtc_commit *commit)
>   	return 0;
>   }
>   EXPORT_SYMBOL(drm_crtc_commit_wait);
>   
>   /**
> - * drm_atomic_state_default_release -
> - * release memory initialized by drm_atomic_state_init
> + * drm_atomic_commit_default_release -
> + * release memory initialized by drm_atomic_commit_init
>    * @state: atomic state
>    *
> - * Free all the memory allocated by drm_atomic_state_init.
> + * Free all the memory allocated by drm_atomic_commit_init.
>    * This should only be used by drivers which are still subclassing
> - * &drm_atomic_state and haven't switched to &drm_private_state yet.
> + * &drm_atomic_commit and haven't switched to &drm_private_state yet.
>    */
> -void drm_atomic_state_default_release(struct drm_atomic_state *state)
> +void drm_atomic_commit_default_release(struct drm_atomic_commit *state)
>   {
>   	kfree(state->connectors);
>   	kfree(state->crtcs);
>   	kfree(state->planes);
>   	kfree(state->colorops);
>   	kfree(state->private_objs);
>   }
> -EXPORT_SYMBOL(drm_atomic_state_default_release);
> +EXPORT_SYMBOL(drm_atomic_commit_default_release);
>   
>   /**
> - * drm_atomic_state_init - init new atomic state
> + * drm_atomic_commit_init - init new atomic state
>    * @dev: DRM device
>    * @state: atomic state
>    *
>    * Default implementation for filling in a new atomic state.
>    * This should only be used by drivers which are still subclassing
> - * &drm_atomic_state and haven't switched to &drm_private_state yet.
> + * &drm_atomic_commit and haven't switched to &drm_private_state yet.
>    */
>   int
> -drm_atomic_state_init(struct drm_device *dev, struct drm_atomic_state *state)
> +drm_atomic_commit_init(struct drm_device *dev, struct drm_atomic_commit *state)
>   {
>   	kref_init(&state->ref);
>   
>   	/* TODO legacy paths should maybe do a better job about
>   	 * setting this appropriately?
> @@ -143,63 +143,63 @@ drm_atomic_state_init(struct drm_device *dev, struct drm_atomic_state *state)
>   				       dev->mode_config.num_colorop);
>   	if (!state->colorops)
>   		goto fail;
>   
>   	/*
> -	 * Because drm_atomic_state can be committed asynchronously we need our
> +	 * Because drm_atomic_commit can be committed asynchronously we need our
>   	 * own reference and cannot rely on the on implied by drm_file in the
>   	 * ioctl call.
>   	 */
>   	drm_dev_get(dev);
>   	state->dev = dev;
>   
>   	drm_dbg_atomic(dev, "Allocated atomic state %p\n", state);
>   
>   	return 0;
>   fail:
> -	drm_atomic_state_default_release(state);
> +	drm_atomic_commit_default_release(state);
>   	return -ENOMEM;
>   }
> -EXPORT_SYMBOL(drm_atomic_state_init);
> +EXPORT_SYMBOL(drm_atomic_commit_init);
>   
>   /**
> - * drm_atomic_state_alloc - allocate atomic state
> + * drm_atomic_commit_alloc - allocate atomic state
>    * @dev: DRM device
>    *
>    * This allocates an empty atomic state to track updates.
>    */
> -struct drm_atomic_state *
> -drm_atomic_state_alloc(struct drm_device *dev)
> +struct drm_atomic_commit *
> +drm_atomic_commit_alloc(struct drm_device *dev)
>   {
>   	struct drm_mode_config *config = &dev->mode_config;
>   
>   	if (!config->funcs->atomic_state_alloc) {
> -		struct drm_atomic_state *state;
> +		struct drm_atomic_commit *state;
>   
>   		state = kzalloc_obj(*state);
>   		if (!state)
>   			return NULL;
> -		if (drm_atomic_state_init(dev, state) < 0) {
> +		if (drm_atomic_commit_init(dev, state) < 0) {
>   			kfree(state);
>   			return NULL;
>   		}
>   		return state;
>   	}
>   
>   	return config->funcs->atomic_state_alloc(dev);
>   }
> -EXPORT_SYMBOL(drm_atomic_state_alloc);
> +EXPORT_SYMBOL(drm_atomic_commit_alloc);
>   
>   /**
> - * drm_atomic_state_default_clear - clear base atomic state
> + * drm_atomic_commit_default_clear - clear base atomic state
>    * @state: atomic state
>    *
>    * Default implementation for clearing atomic state.
>    * This should only be used by drivers which are still subclassing
> - * &drm_atomic_state and haven't switched to &drm_private_state yet.
> + * &drm_atomic_commit and haven't switched to &drm_private_state yet.
>    */
> -void drm_atomic_state_default_clear(struct drm_atomic_state *state)
> +void drm_atomic_commit_default_clear(struct drm_atomic_commit *state)
>   {
>   	struct drm_device *dev = state->dev;
>   	struct drm_mode_config *config = &dev->mode_config;
>   	int i;
>   
> @@ -285,14 +285,14 @@ void drm_atomic_state_default_clear(struct drm_atomic_state *state)
>   	if (state->fake_commit) {
>   		drm_crtc_commit_put(state->fake_commit);
>   		state->fake_commit = NULL;
>   	}
>   }
> -EXPORT_SYMBOL(drm_atomic_state_default_clear);
> +EXPORT_SYMBOL(drm_atomic_commit_default_clear);
>   
>   /**
> - * drm_atomic_state_clear - clear state object
> + * drm_atomic_commit_clear - clear state object
>    * @state: atomic state
>    *
>    * When the w/w mutex algorithm detects a deadlock we need to back off and drop
>    * all locks. So someone else could sneak in and change the current modeset
>    * configuration. Which means that all the state assembled in @state is no
> @@ -301,49 +301,49 @@ EXPORT_SYMBOL(drm_atomic_state_default_clear);
>    * &drm_mode_config_funcs.atomic_check likely relies on.
>    *
>    * Hence we must clear all cached state and completely start over, using this
>    * function.
>    */
> -void drm_atomic_state_clear(struct drm_atomic_state *state)
> +void drm_atomic_commit_clear(struct drm_atomic_commit *state)
>   {
>   	struct drm_device *dev = state->dev;
>   	struct drm_mode_config *config = &dev->mode_config;
>   
>   	if (config->funcs->atomic_state_clear)
>   		config->funcs->atomic_state_clear(state);
>   	else
> -		drm_atomic_state_default_clear(state);
> +		drm_atomic_commit_default_clear(state);
>   }
> -EXPORT_SYMBOL(drm_atomic_state_clear);
> +EXPORT_SYMBOL(drm_atomic_commit_clear);
>   
>   /**
> - * __drm_atomic_state_free - free all memory for an atomic state
> + * __drm_atomic_commit_free - free all memory for an atomic state
>    * @ref: This atomic state to deallocate
>    *
>    * This frees all memory associated with an atomic state, including all the
>    * per-object state for planes, CRTCs and connectors.
>    */
> -void __drm_atomic_state_free(struct kref *ref)
> +void __drm_atomic_commit_free(struct kref *ref)
>   {
> -	struct drm_atomic_state *state = container_of(ref, typeof(*state), ref);
> +	struct drm_atomic_commit *state = container_of(ref, typeof(*state), ref);
>   	struct drm_device *dev = state->dev;
>   	struct drm_mode_config *config = &dev->mode_config;
>   
> -	drm_atomic_state_clear(state);
> +	drm_atomic_commit_clear(state);
>   
>   	drm_dbg_atomic(state->dev, "Freeing atomic state %p\n", state);
>   
>   	if (config->funcs->atomic_state_free) {
>   		config->funcs->atomic_state_free(state);
>   	} else {
> -		drm_atomic_state_default_release(state);
> +		drm_atomic_commit_default_release(state);
>   		kfree(state);
>   	}
>   
>   	drm_dev_put(dev);
>   }
> -EXPORT_SYMBOL(__drm_atomic_state_free);
> +EXPORT_SYMBOL(__drm_atomic_commit_free);
>   
>   /**
>    * drm_atomic_get_crtc_state - get CRTC state
>    * @state: global atomic state object
>    * @crtc: CRTC to get state object for
> @@ -351,20 +351,20 @@ EXPORT_SYMBOL(__drm_atomic_state_free);
>    * This function returns the CRTC state for the given CRTC, allocating it if
>    * needed. It will also grab the relevant CRTC lock to make sure that the state
>    * is consistent.
>    *
>    * WARNING: Drivers may only add new CRTC states to a @state if
> - * drm_atomic_state.allow_modeset is set, or if it's a driver-internal commit
> + * drm_atomic_commit.allow_modeset is set, or if it's a driver-internal commit
>    * not created by userspace through an IOCTL call.
>    *
>    * Returns:
>    * Either the allocated state or the error code encoded into the pointer. When
>    * the error is EDEADLK then the w/w mutex code has detected a deadlock and the
>    * entire atomic sequence must be restarted. All other errors are fatal.
>    */
>   struct drm_crtc_state *
> -drm_atomic_get_crtc_state(struct drm_atomic_state *state,
> +drm_atomic_get_crtc_state(struct drm_atomic_commit *state,
>   			  struct drm_crtc *crtc)
>   {
>   	int ret, index = drm_crtc_index(crtc);
>   	struct drm_crtc_state *crtc_state;
>   
> @@ -542,11 +542,11 @@ static int drm_atomic_connector_check(struct drm_connector *connector,
>    * Either the allocated state or the error code encoded into the pointer. When
>    * the error is EDEADLK then the w/w mutex code has detected a deadlock and the
>    * entire atomic sequence must be restarted. All other errors are fatal.
>    */
>   struct drm_plane_state *
> -drm_atomic_get_plane_state(struct drm_atomic_state *state,
> +drm_atomic_get_plane_state(struct drm_atomic_commit *state,
>   			  struct drm_plane *plane)
>   {
>   	int ret, index = drm_plane_index(plane);
>   	struct drm_plane_state *plane_state;
>   
> @@ -606,11 +606,11 @@ EXPORT_SYMBOL(drm_atomic_get_plane_state);
>    * Either the allocated state or the error code encoded into the pointer. When
>    * the error is EDEADLK then the w/w mutex code has detected a deadlock and the
>    * entire atomic sequence must be restarted. All other errors are fatal.
>    */
>   struct drm_colorop_state *
> -drm_atomic_get_colorop_state(struct drm_atomic_state *state,
> +drm_atomic_get_colorop_state(struct drm_atomic_commit *state,
>   			     struct drm_colorop *colorop)
>   {
>   	int ret, index = drm_colorop_index(colorop);
>   	struct drm_colorop_state *colorop_state;
>   
> @@ -648,11 +648,11 @@ EXPORT_SYMBOL(drm_atomic_get_colorop_state);
>    *
>    * This function returns the old colorop state for the given colorop, or
>    * NULL if the colorop is not part of the global atomic state.
>    */
>   struct drm_colorop_state *
> -drm_atomic_get_old_colorop_state(struct drm_atomic_state *state,
> +drm_atomic_get_old_colorop_state(struct drm_atomic_commit *state,
>   				 struct drm_colorop *colorop)
>   {
>   	return state->colorops[drm_colorop_index(colorop)].old_state;
>   }
>   EXPORT_SYMBOL(drm_atomic_get_old_colorop_state);
> @@ -664,11 +664,11 @@ EXPORT_SYMBOL(drm_atomic_get_old_colorop_state);
>    *
>    * This function returns the new colorop state for the given colorop, or
>    * NULL if the colorop is not part of the global atomic state.
>    */
>   struct drm_colorop_state *
> -drm_atomic_get_new_colorop_state(struct drm_atomic_state *state,
> +drm_atomic_get_new_colorop_state(struct drm_atomic_commit *state,
>   				 struct drm_colorop *colorop)
>   {
>   	return state->colorops[drm_colorop_index(colorop)].new_state;
>   }
>   EXPORT_SYMBOL(drm_atomic_get_new_colorop_state);
> @@ -899,21 +899,21 @@ static void drm_atomic_plane_print_state(struct drm_printer *p,
>    * acquired by calling drm_atomic_get_private_obj_state(). This also takes care
>    * of locking, hence drivers should not have a need to call drm_modeset_lock()
>    * directly. Sequence of the actual hardware state commit is not handled,
>    * drivers might need to keep track of struct drm_crtc_commit within subclassed
>    * structure of &drm_private_state as necessary, e.g. similar to
> - * &drm_plane_state.commit. See also &drm_atomic_state.fake_commit.
> + * &drm_plane_state.commit. See also &drm_atomic_commit.fake_commit.
>    *
> - * All private state structures contained in a &drm_atomic_state update can be
> + * All private state structures contained in a &drm_atomic_commit update can be
>    * iterated using for_each_oldnew_private_obj_in_state(),
>    * for_each_new_private_obj_in_state() and for_each_old_private_obj_in_state().
>    * Drivers are recommended to wrap these for each type of driver private state
>    * object they have, filtering on &drm_private_obj.funcs using for_each_if(), at
>    * least if they want to iterate over all objects of a given type.
>    *
>    * An earlier way to handle driver private state was by subclassing struct
> - * &drm_atomic_state. But since that encourages non-standard ways to implement
> + * &drm_atomic_commit. But since that encourages non-standard ways to implement
>    * the check/commit split atomic requires (by using e.g. "check and rollback or
>    * commit instead" of "duplicate state, check, then either commit or release
>    * duplicated state) it is deprecated in favour of using &drm_private_state.
>    */
>   
> @@ -979,11 +979,11 @@ EXPORT_SYMBOL(drm_atomic_private_obj_fini);
>    *
>    * RETURNS:
>    * Either the allocated state or the error code encoded into a pointer.
>    */
>   struct drm_private_state *
> -drm_atomic_get_private_obj_state(struct drm_atomic_state *state,
> +drm_atomic_get_private_obj_state(struct drm_atomic_commit *state,
>   				 struct drm_private_obj *obj)
>   {
>   	int index, num_objs, ret;
>   	size_t size;
>   	struct __drm_private_objs_state *arr;
> @@ -1037,11 +1037,11 @@ EXPORT_SYMBOL(drm_atomic_get_private_obj_state);
>    *
>    * This function returns the old private object state for the given private_obj,
>    * or NULL if the private_obj is not part of the global atomic state.
>    */
>   struct drm_private_state *
> -drm_atomic_get_old_private_obj_state(const struct drm_atomic_state *state,
> +drm_atomic_get_old_private_obj_state(const struct drm_atomic_commit *state,
>   				     struct drm_private_obj *obj)
>   {
>   	int i;
>   
>   	for (i = 0; i < state->num_private_objs; i++)
> @@ -1059,11 +1059,11 @@ EXPORT_SYMBOL(drm_atomic_get_old_private_obj_state);
>    *
>    * This function returns the new private object state for the given private_obj,
>    * or NULL if the private_obj is not part of the global atomic state.
>    */
>   struct drm_private_state *
> -drm_atomic_get_new_private_obj_state(const struct drm_atomic_state *state,
> +drm_atomic_get_new_private_obj_state(const struct drm_atomic_commit *state,
>   				     struct drm_private_obj *obj)
>   {
>   	int i;
>   
>   	for (i = 0; i < state->num_private_objs; i++)
> @@ -1094,11 +1094,11 @@ EXPORT_SYMBOL(drm_atomic_get_new_private_obj_state);
>    *
>    * Returns: The old connector connected to @encoder, or NULL if the encoder is
>    * not connected.
>    */
>   struct drm_connector *
> -drm_atomic_get_old_connector_for_encoder(const struct drm_atomic_state *state,
> +drm_atomic_get_old_connector_for_encoder(const struct drm_atomic_commit *state,
>   					 struct drm_encoder *encoder)
>   {
>   	struct drm_connector_state *conn_state;
>   	struct drm_connector *connector;
>   	unsigned int i;
> @@ -1131,11 +1131,11 @@ EXPORT_SYMBOL(drm_atomic_get_old_connector_for_encoder);
>    *
>    * Returns: The new connector connected to @encoder, or NULL if the encoder is
>    * not connected.
>    */
>   struct drm_connector *
> -drm_atomic_get_new_connector_for_encoder(const struct drm_atomic_state *state,
> +drm_atomic_get_new_connector_for_encoder(const struct drm_atomic_commit *state,
>   					 struct drm_encoder *encoder)
>   {
>   	struct drm_connector_state *conn_state;
>   	struct drm_connector *connector;
>   	unsigned int i;
> @@ -1212,11 +1212,11 @@ EXPORT_SYMBOL(drm_atomic_get_connector_for_encoder);
>    *
>    * Returns: The old crtc connected to @encoder, or NULL if the encoder is
>    * not connected.
>    */
>   struct drm_crtc *
> -drm_atomic_get_old_crtc_for_encoder(struct drm_atomic_state *state,
> +drm_atomic_get_old_crtc_for_encoder(struct drm_atomic_commit *state,
>   				    struct drm_encoder *encoder)
>   {
>   	struct drm_connector *connector;
>   	struct drm_connector_state *conn_state;
>   
> @@ -1242,11 +1242,11 @@ EXPORT_SYMBOL(drm_atomic_get_old_crtc_for_encoder);
>    *
>    * Returns: The new crtc connected to @encoder, or NULL if the encoder is
>    * not connected.
>    */
>   struct drm_crtc *
> -drm_atomic_get_new_crtc_for_encoder(struct drm_atomic_state *state,
> +drm_atomic_get_new_crtc_for_encoder(struct drm_atomic_commit *state,
>   				    struct drm_encoder *encoder)
>   {
>   	struct drm_connector *connector;
>   	struct drm_connector_state *conn_state;
>   
> @@ -1275,11 +1275,11 @@ EXPORT_SYMBOL(drm_atomic_get_new_crtc_for_encoder);
>    * Either the allocated state or the error code encoded into the pointer. When
>    * the error is EDEADLK then the w/w mutex code has detected a deadlock and the
>    * entire atomic sequence must be restarted. All other errors are fatal.
>    */
>   struct drm_connector_state *
> -drm_atomic_get_connector_state(struct drm_atomic_state *state,
> +drm_atomic_get_connector_state(struct drm_atomic_commit *state,
>   			  struct drm_connector *connector)
>   {
>   	int ret, index;
>   	struct drm_mode_config *config = &connector->dev->mode_config;
>   	struct drm_connector_state *connector_state;
> @@ -1386,11 +1386,11 @@ static void drm_atomic_connector_print_state(struct drm_printer *p,
>    * Either the allocated state or the error code encoded into the pointer. When
>    * the error is EDEADLK then the w/w mutex code has detected a deadlock and the
>    * entire atomic sequence must be restarted.
>    */
>   struct drm_bridge_state *
> -drm_atomic_get_bridge_state(struct drm_atomic_state *state,
> +drm_atomic_get_bridge_state(struct drm_atomic_commit *state,
>   			    struct drm_bridge *bridge)
>   {
>   	struct drm_private_state *obj_state;
>   
>   	obj_state = drm_atomic_get_private_obj_state(state, &bridge->base);
> @@ -1408,11 +1408,11 @@ EXPORT_SYMBOL(drm_atomic_get_bridge_state);
>    *
>    * This function returns the old bridge state for the given bridge, or NULL if
>    * the bridge is not part of the global atomic state.
>    */
>   struct drm_bridge_state *
> -drm_atomic_get_old_bridge_state(const struct drm_atomic_state *state,
> +drm_atomic_get_old_bridge_state(const struct drm_atomic_commit *state,
>   				struct drm_bridge *bridge)
>   {
>   	struct drm_private_state *obj_state;
>   
>   	obj_state = drm_atomic_get_old_private_obj_state(state, &bridge->base);
> @@ -1430,11 +1430,11 @@ EXPORT_SYMBOL(drm_atomic_get_old_bridge_state);
>    *
>    * This function returns the new bridge state for the given bridge, or NULL if
>    * the bridge is not part of the global atomic state.
>    */
>   struct drm_bridge_state *
> -drm_atomic_get_new_bridge_state(const struct drm_atomic_state *state,
> +drm_atomic_get_new_bridge_state(const struct drm_atomic_commit *state,
>   				struct drm_bridge *bridge)
>   {
>   	struct drm_private_state *obj_state;
>   
>   	obj_state = drm_atomic_get_new_private_obj_state(state, &bridge->base);
> @@ -1460,11 +1460,11 @@ EXPORT_SYMBOL(drm_atomic_get_new_bridge_state);
>    * 0 on success or can fail with -EDEADLK or -ENOMEM. When the error is EDEADLK
>    * then the w/w mutex code has detected a deadlock and the entire atomic
>    * sequence must be restarted. All other errors are fatal.
>    */
>   int
> -drm_atomic_add_encoder_bridges(struct drm_atomic_state *state,
> +drm_atomic_add_encoder_bridges(struct drm_atomic_commit *state,
>   			       struct drm_encoder *encoder)
>   {
>   	struct drm_bridge_state *bridge_state;
>   
>   	if (!encoder)
> @@ -1504,11 +1504,11 @@ EXPORT_SYMBOL(drm_atomic_add_encoder_bridges);
>    * 0 on success or can fail with -EDEADLK or -ENOMEM. When the error is EDEADLK
>    * then the w/w mutex code has detected a deadlock and the entire atomic
>    * sequence must be restarted. All other errors are fatal.
>    */
>   int
> -drm_atomic_add_affected_connectors(struct drm_atomic_state *state,
> +drm_atomic_add_affected_connectors(struct drm_atomic_commit *state,
>   				   struct drm_crtc *crtc)
>   {
>   	struct drm_mode_config *config = &state->dev->mode_config;
>   	struct drm_connector *connector;
>   	struct drm_connector_state *conn_state;
> @@ -1568,11 +1568,11 @@ EXPORT_SYMBOL(drm_atomic_add_affected_connectors);
>    * 0 on success or can fail with -EDEADLK or -ENOMEM. When the error is EDEADLK
>    * then the w/w mutex code has detected a deadlock and the entire atomic
>    * sequence must be restarted. All other errors are fatal.
>    */
>   int
> -drm_atomic_add_affected_planes(struct drm_atomic_state *state,
> +drm_atomic_add_affected_planes(struct drm_atomic_commit *state,
>   			       struct drm_crtc *crtc)
>   {
>   	const struct drm_crtc_state *old_crtc_state =
>   		drm_atomic_get_old_crtc_state(state, crtc);
>   	struct drm_plane *plane;
> @@ -1620,11 +1620,11 @@ EXPORT_SYMBOL(drm_atomic_add_affected_planes);
>    * 0 on success or can fail with -EDEADLK or -ENOMEM. When the error is EDEADLK
>    * then the w/w mutex code has detected a deadlock and the entire atomic
>    * sequence must be restarted. All other errors are fatal.
>    */
>   int
> -drm_atomic_add_affected_colorops(struct drm_atomic_state *state,
> +drm_atomic_add_affected_colorops(struct drm_atomic_commit *state,
>   				 struct drm_plane *plane)
>   {
>   	struct drm_colorop *colorop;
>   	struct drm_colorop_state *colorop_state;
>   
> @@ -1656,11 +1656,11 @@ EXPORT_SYMBOL(drm_atomic_add_affected_colorops);
>    * backoff dance and restart. All other errors are fatal.
>    *
>    * Returns:
>    * 0 on success, negative error code on failure.
>    */
> -int drm_atomic_check_only(struct drm_atomic_state *state)
> +int drm_atomic_check_only(struct drm_atomic_commit *state)
>   {
>   	struct drm_device *dev = state->dev;
>   	struct drm_mode_config *config = &dev->mode_config;
>   	struct drm_plane *plane;
>   	struct drm_plane_state *old_plane_state;
> @@ -1764,16 +1764,16 @@ EXPORT_SYMBOL(drm_atomic_check_only);
>    * Note that this function can return -EDEADLK if the driver needed to acquire
>    * more locks but encountered a deadlock. The caller must then do the usual w/w
>    * backoff dance and restart. All other errors are fatal.
>    *
>    * This function will take its own reference on @state.
> - * Callers should always release their reference with drm_atomic_state_put().
> + * Callers should always release their reference with drm_atomic_commit_put().
>    *
>    * Returns:
>    * 0 on success, negative error code on failure.
>    */
> -int drm_atomic_commit(struct drm_atomic_state *state)
> +int drm_atomic_commit(struct drm_atomic_commit *state)
>   {
>   	struct drm_mode_config *config = &state->dev->mode_config;
>   	struct drm_printer p = drm_info_printer(state->dev->dev);
>   	int ret;
>   
> @@ -1797,16 +1797,16 @@ EXPORT_SYMBOL(drm_atomic_commit);
>    * Note that this function can return -EDEADLK if the driver needed to acquire
>    * more locks but encountered a deadlock. The caller must then do the usual w/w
>    * backoff dance and restart. All other errors are fatal.
>    *
>    * This function will take its own reference on @state.
> - * Callers should always release their reference with drm_atomic_state_put().
> + * Callers should always release their reference with drm_atomic_commit_put().
>    *
>    * Returns:
>    * 0 on success, negative error code on failure.
>    */
> -int drm_atomic_nonblocking_commit(struct drm_atomic_state *state)
> +int drm_atomic_nonblocking_commit(struct drm_atomic_commit *state)
>   {
>   	struct drm_mode_config *config = &state->dev->mode_config;
>   	int ret;
>   
>   	ret = drm_atomic_check_only(state);
> @@ -1841,11 +1841,11 @@ int __drm_atomic_helper_disable_plane(struct drm_plane *plane,
>   
>   	return 0;
>   }
>   EXPORT_SYMBOL(__drm_atomic_helper_disable_plane);
>   
> -static int update_output_state(struct drm_atomic_state *state,
> +static int update_output_state(struct drm_atomic_commit *state,
>   			       struct drm_mode_set *set)
>   {
>   	struct drm_device *dev = set->crtc->dev;
>   	struct drm_crtc *crtc;
>   	struct drm_crtc_state *new_crtc_state;
> @@ -1911,11 +1911,11 @@ static int update_output_state(struct drm_atomic_state *state,
>   	return 0;
>   }
>   
>   /* just used from drm-client and atomic-helper: */
>   int __drm_atomic_helper_set_config(struct drm_mode_set *set,
> -				   struct drm_atomic_state *state)
> +				   struct drm_atomic_commit *state)
>   {
>   	struct drm_crtc_state *crtc_state;
>   	struct drm_plane_state *primary_state;
>   	struct drm_crtc *crtc = set->crtc;
>   	int hdisplay, vdisplay;
> @@ -2005,11 +2005,11 @@ static void drm_atomic_private_obj_print_state(struct drm_printer *p,
>    * which is passed to it. This snapshot can be used for debugging purposes.
>    *
>    * Note that this function looks into the new state objects and hence its not
>    * safe to be used after the call to drm_atomic_helper_commit_hw_done().
>    */
> -void drm_atomic_print_new_state(const struct drm_atomic_state *state,
> +void drm_atomic_print_new_state(const struct drm_atomic_commit *state,
>   		struct drm_printer *p)
>   {
>   	struct drm_plane *plane;
>   	struct drm_plane_state *plane_state;
>   	struct drm_crtc *crtc;
> diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
> index 26953ed6b53e811cd634277bfc4bb627414aea6a..35b53f7b25f18fbafb151fcc23ee58d5ba14f4e5 100644
> --- a/drivers/gpu/drm/drm_atomic_helper.c
> +++ b/drivers/gpu/drm/drm_atomic_helper.c
> @@ -75,11 +75,11 @@
>    * struct &drm_encoder_helper_funcs and &struct drm_connector_helper_funcs. It
>    * also shares the &struct drm_plane_helper_funcs function table with the plane
>    * helpers.
>    */
>   static void
> -drm_atomic_helper_plane_changed(struct drm_atomic_state *state,
> +drm_atomic_helper_plane_changed(struct drm_atomic_commit *state,
>   				struct drm_plane_state *old_plane_state,
>   				struct drm_plane_state *plane_state,
>   				struct drm_plane *plane)
>   {
>   	struct drm_crtc_state *crtc_state;
> @@ -102,11 +102,11 @@ drm_atomic_helper_plane_changed(struct drm_atomic_state *state,
>   
>   		crtc_state->planes_changed = true;
>   	}
>   }
>   
> -static int handle_conflicting_encoders(struct drm_atomic_state *state,
> +static int handle_conflicting_encoders(struct drm_atomic_commit *state,
>   				       bool disable_conflicting_encoders)
>   {
>   	struct drm_connector_state *new_conn_state;
>   	struct drm_connector *connector;
>   	struct drm_connector_list_iter conn_iter;
> @@ -216,11 +216,11 @@ static int handle_conflicting_encoders(struct drm_atomic_state *state,
>   
>   	return ret;
>   }
>   
>   static void
> -set_best_encoder(struct drm_atomic_state *state,
> +set_best_encoder(struct drm_atomic_commit *state,
>   		 struct drm_connector_state *conn_state,
>   		 struct drm_encoder *encoder)
>   {
>   	struct drm_crtc_state *crtc_state;
>   	struct drm_crtc *crtc;
> @@ -257,11 +257,11 @@ set_best_encoder(struct drm_atomic_state *state,
>   
>   	conn_state->best_encoder = encoder;
>   }
>   
>   static void
> -steal_encoder(struct drm_atomic_state *state,
> +steal_encoder(struct drm_atomic_commit *state,
>   	      struct drm_encoder *encoder)
>   {
>   	struct drm_crtc_state *crtc_state;
>   	struct drm_connector *connector;
>   	struct drm_connector_state *old_connector_state, *new_connector_state;
> @@ -288,11 +288,11 @@ steal_encoder(struct drm_atomic_state *state,
>   		return;
>   	}
>   }
>   
>   static int
> -update_connector_routing(struct drm_atomic_state *state,
> +update_connector_routing(struct drm_atomic_commit *state,
>   			 struct drm_connector *connector,
>   			 struct drm_connector_state *old_connector_state,
>   			 struct drm_connector_state *new_connector_state,
>   			 bool added_by_user)
>   {
> @@ -414,11 +414,11 @@ update_connector_routing(struct drm_atomic_state *state,
>   
>   	return 0;
>   }
>   
>   static int
> -mode_fixup(struct drm_atomic_state *state)
> +mode_fixup(struct drm_atomic_commit *state)
>   {
>   	struct drm_crtc *crtc;
>   	struct drm_crtc_state *new_crtc_state;
>   	struct drm_connector *connector;
>   	struct drm_connector_state *new_conn_state;
> @@ -544,11 +544,11 @@ static enum drm_mode_status mode_valid_path(struct drm_connector *connector,
>   
>   	return ret;
>   }
>   
>   static int
> -mode_valid(struct drm_atomic_state *state)
> +mode_valid(struct drm_atomic_commit *state)
>   {
>   	struct drm_connector_state *conn_state;
>   	struct drm_connector *connector;
>   	int i;
>   
> @@ -576,11 +576,11 @@ mode_valid(struct drm_atomic_state *state)
>   	}
>   
>   	return 0;
>   }
>   
> -static int drm_atomic_check_valid_clones(struct drm_atomic_state *state,
> +static int drm_atomic_check_valid_clones(struct drm_atomic_commit *state,
>   					 struct drm_crtc *crtc)
>   {
>   	struct drm_encoder *drm_enc;
>   	struct drm_crtc_state *crtc_state = drm_atomic_get_new_crtc_state(state,
>   									  crtc);
> @@ -645,11 +645,11 @@ static int drm_atomic_check_valid_clones(struct drm_atomic_state *state,
>    * RETURNS:
>    * Zero for success or -errno
>    */
>   int
>   drm_atomic_helper_check_modeset(struct drm_device *dev,
> -				struct drm_atomic_state *state)
> +				struct drm_atomic_commit *state)
>   {
>   	struct drm_crtc *crtc;
>   	struct drm_crtc_state *old_crtc_state, *new_crtc_state;
>   	struct drm_connector *connector;
>   	struct drm_connector_state *old_connector_state, *new_connector_state;
> @@ -839,11 +839,11 @@ EXPORT_SYMBOL(drm_atomic_helper_check_modeset);
>    * RETURNS:
>    * Zero for success or -errno
>    */
>   int
>   drm_atomic_helper_check_wb_connector_state(struct drm_connector *connector,
> -					   struct drm_atomic_state *state)
> +					   struct drm_atomic_commit *state)
>   {
>   	struct drm_connector_state *conn_state =
>   		drm_atomic_get_new_connector_state(state, connector);
>   	struct drm_writeback_job *wb_job = conn_state->writeback_job;
>   	struct drm_property_blob *pixel_format_blob;
> @@ -1015,11 +1015,11 @@ EXPORT_SYMBOL(drm_atomic_helper_check_crtc_primary_plane);
>    * RETURNS:
>    * Zero for success or -errno
>    */
>   int
>   drm_atomic_helper_check_planes(struct drm_device *dev,
> -			       struct drm_atomic_state *state)
> +			       struct drm_atomic_commit *state)
>   {
>   	struct drm_crtc *crtc;
>   	struct drm_crtc_state *new_crtc_state;
>   	struct drm_plane *plane;
>   	struct drm_plane_state *new_plane_state, *old_plane_state;
> @@ -1103,11 +1103,11 @@ EXPORT_SYMBOL(drm_atomic_helper_check_planes);
>    *
>    * RETURNS:
>    * Zero for success or -errno
>    */
>   int drm_atomic_helper_check(struct drm_device *dev,
> -			    struct drm_atomic_state *state)
> +			    struct drm_atomic_commit *state)
>   {
>   	int ret;
>   
>   	ret = drm_atomic_helper_check_modeset(dev, state);
>   	if (ret)
> @@ -1172,11 +1172,11 @@ crtc_needs_disable(struct drm_crtc_state *old_state,
>    * it, disables the bridge chain all the way, then disables the encoder
>    * afterwards.
>    */
>   void
>   drm_atomic_helper_commit_encoder_bridge_disable(struct drm_device *dev,
> -						struct drm_atomic_state *state)
> +						struct drm_atomic_commit *state)
>   {
>   	struct drm_connector *connector;
>   	struct drm_connector_state *old_conn_state, *new_conn_state;
>   	struct drm_crtc_state *old_crtc_state, *new_crtc_state;
>   	int i;
> @@ -1249,11 +1249,11 @@ EXPORT_SYMBOL(drm_atomic_helper_commit_encoder_bridge_disable);
>    *
>    * Loops over all CRTCs in the current state and if the CRTC needs
>    * it, disables it.
>    */
>   void
> -drm_atomic_helper_commit_crtc_disable(struct drm_device *dev, struct drm_atomic_state *state)
> +drm_atomic_helper_commit_crtc_disable(struct drm_device *dev, struct drm_atomic_commit *state)
>   {
>   	struct drm_crtc *crtc;
>   	struct drm_crtc_state *old_crtc_state, *new_crtc_state;
>   	int i;
>   
> @@ -1311,11 +1311,11 @@ EXPORT_SYMBOL(drm_atomic_helper_commit_crtc_disable);
>    *
>    * Loops over all connectors in the current state and if the CRTC needs
>    * it, post-disables all encoder bridges.
>    */
>   void
> -drm_atomic_helper_commit_encoder_bridge_post_disable(struct drm_device *dev, struct drm_atomic_state *state)
> +drm_atomic_helper_commit_encoder_bridge_post_disable(struct drm_device *dev, struct drm_atomic_commit *state)
>   {
>   	struct drm_connector *connector;
>   	struct drm_connector_state *old_conn_state, *new_conn_state;
>   	struct drm_crtc_state *old_crtc_state, *new_crtc_state;
>   	int i;
> @@ -1365,11 +1365,11 @@ drm_atomic_helper_commit_encoder_bridge_post_disable(struct drm_device *dev, str
>   	}
>   }
>   EXPORT_SYMBOL(drm_atomic_helper_commit_encoder_bridge_post_disable);
>   
>   static void
> -disable_outputs(struct drm_device *dev, struct drm_atomic_state *state)
> +disable_outputs(struct drm_device *dev, struct drm_atomic_commit *state)
>   {
>   	drm_atomic_helper_commit_encoder_bridge_disable(dev, state);
>   
>   	drm_atomic_helper_commit_encoder_bridge_post_disable(dev, state);
>   
> @@ -1393,11 +1393,11 @@ disable_outputs(struct drm_device *dev, struct drm_atomic_state *state)
>    * the legacy state pointers are only really useful for transitioning an
>    * existing driver to the atomic world.
>    */
>   void
>   drm_atomic_helper_update_legacy_modeset_state(struct drm_device *dev,
> -					      struct drm_atomic_state *state)
> +					      struct drm_atomic_commit *state)
>   {
>   	struct drm_connector *connector;
>   	struct drm_connector_state *old_conn_state, *new_conn_state;
>   	struct drm_crtc *crtc;
>   	struct drm_crtc_state *new_crtc_state;
> @@ -1460,11 +1460,11 @@ EXPORT_SYMBOL(drm_atomic_helper_update_legacy_modeset_state);
>    * @state: atomic state object
>    *
>    * Updates the timestamping constants used for precise vblank timestamps
>    * by calling drm_calc_timestamping_constants() for all enabled crtcs in @state.
>    */
> -void drm_atomic_helper_calc_timestamping_constants(struct drm_atomic_state *state)
> +void drm_atomic_helper_calc_timestamping_constants(struct drm_atomic_commit *state)
>   {
>   	struct drm_crtc_state *new_crtc_state;
>   	struct drm_crtc *crtc;
>   	int i;
>   
> @@ -1484,11 +1484,11 @@ EXPORT_SYMBOL(drm_atomic_helper_calc_timestamping_constants);
>    * Loops over all connectors in the current state and if the mode has
>    * changed, change the mode of the CRTC, then call down the bridge
>    * chain and change the mode in all bridges as well.
>    */
>   void
> -drm_atomic_helper_commit_crtc_set_mode(struct drm_device *dev, struct drm_atomic_state *state)
> +drm_atomic_helper_commit_crtc_set_mode(struct drm_device *dev, struct drm_atomic_commit *state)
>   {
>   	struct drm_crtc *crtc;
>   	struct drm_crtc_state *new_crtc_state;
>   	struct drm_connector *connector;
>   	struct drm_connector_state *new_conn_state;
> @@ -1562,11 +1562,11 @@ EXPORT_SYMBOL(drm_atomic_helper_commit_crtc_set_mode);
>    * does. But drivers with different needs can group the modeset commits together
>    * and do the plane commits at the end. This is useful for drivers doing runtime
>    * PM since planes updates then only happen when the CRTC is actually enabled.
>    */
>   void drm_atomic_helper_commit_modeset_disables(struct drm_device *dev,
> -					       struct drm_atomic_state *state)
> +					       struct drm_atomic_commit *state)
>   {
>   	disable_outputs(dev, state);
>   
>   	drm_atomic_helper_update_legacy_modeset_state(dev, state);
>   	drm_atomic_helper_calc_timestamping_constants(state);
> @@ -1583,11 +1583,11 @@ EXPORT_SYMBOL(drm_atomic_helper_commit_modeset_disables);
>    * This loops over the connectors, checks if the new state requires
>    * a writeback job to be issued and in that case issues an atomic
>    * commit on each connector.
>    */
>   void drm_atomic_helper_commit_writebacks(struct drm_device *dev,
> -					 struct drm_atomic_state *state)
> +					 struct drm_atomic_commit *state)
>   {
>   	struct drm_connector *connector;
>   	struct drm_connector_state *new_conn_state;
>   	int i;
>   
> @@ -1613,11 +1613,11 @@ EXPORT_SYMBOL(drm_atomic_helper_commit_writebacks);
>    *
>    * This loops over the connectors and if the CRTC needs it, pre-enables
>    * the entire bridge chain.
>    */
>   void
> -drm_atomic_helper_commit_encoder_bridge_pre_enable(struct drm_device *dev, struct drm_atomic_state *state)
> +drm_atomic_helper_commit_encoder_bridge_pre_enable(struct drm_device *dev, struct drm_atomic_commit *state)
>   {
>   	struct drm_connector *connector;
>   	struct drm_connector_state *new_conn_state;
>   	int i;
>   
> @@ -1655,11 +1655,11 @@ EXPORT_SYMBOL(drm_atomic_helper_commit_encoder_bridge_pre_enable);
>    *
>    * This loops over CRTCs in the new state, and of the CRTC needs
>    * it, enables it.
>    */
>   void
> -drm_atomic_helper_commit_crtc_enable(struct drm_device *dev, struct drm_atomic_state *state)
> +drm_atomic_helper_commit_crtc_enable(struct drm_device *dev, struct drm_atomic_commit *state)
>   {
>   	struct drm_crtc *crtc;
>   	struct drm_crtc_state *old_crtc_state;
>   	struct drm_crtc_state *new_crtc_state;
>   	int i;
> @@ -1695,11 +1695,11 @@ EXPORT_SYMBOL(drm_atomic_helper_commit_crtc_enable);
>    *
>    * This loops over all connectors in the new state, and of the CRTC needs
>    * it, enables the entire bridge chain.
>    */
>   void
> -drm_atomic_helper_commit_encoder_bridge_enable(struct drm_device *dev, struct drm_atomic_state *state)
> +drm_atomic_helper_commit_encoder_bridge_enable(struct drm_device *dev, struct drm_atomic_commit *state)
>   {
>   	struct drm_connector *connector;
>   	struct drm_connector_state *new_conn_state;
>   	int i;
>   
> @@ -1755,11 +1755,11 @@ EXPORT_SYMBOL(drm_atomic_helper_commit_encoder_bridge_enable);
>    * does. But drivers with different needs can group the modeset commits together
>    * and do the plane commits at the end. This is useful for drivers doing runtime
>    * PM since planes updates then only happen when the CRTC is actually enabled.
>    */
>   void drm_atomic_helper_commit_modeset_enables(struct drm_device *dev,
> -					      struct drm_atomic_state *state)
> +					      struct drm_atomic_commit *state)
>   {
>   	drm_atomic_helper_commit_crtc_enable(dev, state);
>   
>   	drm_atomic_helper_commit_encoder_bridge_pre_enable(dev, state);
>   
> @@ -1772,11 +1772,11 @@ EXPORT_SYMBOL(drm_atomic_helper_commit_modeset_enables);
>   /*
>    * For atomic updates which touch just a single CRTC, calculate the time of the
>    * next vblank, and inform all the fences of the deadline.
>    */
>   static void set_fence_deadline(struct drm_device *dev,
> -			       struct drm_atomic_state *state)
> +			       struct drm_atomic_commit *state)
>   {
>   	struct drm_crtc *crtc;
>   	struct drm_crtc_state *new_crtc_state;
>   	struct drm_plane *plane;
>   	struct drm_plane_state *new_plane_state;
> @@ -1830,11 +1830,11 @@ static void set_fence_deadline(struct drm_device *dev,
>    * before we call drm_atomic_helper_swap_state().
>    *
>    * Returns zero if success or < 0 if dma_fence_wait() fails.
>    */
>   int drm_atomic_helper_wait_for_fences(struct drm_device *dev,
> -				      struct drm_atomic_state *state,
> +				      struct drm_atomic_commit *state,
>   				      bool pre_swap)
>   {
>   	struct drm_plane *plane;
>   	struct drm_plane_state *new_plane_state;
>   	int i, ret;
> @@ -1879,11 +1879,11 @@ EXPORT_SYMBOL(drm_atomic_helper_wait_for_fences);
>    * drm_atomic_helper_setup_commit() should look at
>    * drm_atomic_helper_wait_for_flip_done() as an alternative.
>    */
>   void
>   drm_atomic_helper_wait_for_vblanks(struct drm_device *dev,
> -				   struct drm_atomic_state *state)
> +				   struct drm_atomic_commit *state)
>   {
>   	struct drm_crtc *crtc;
>   	struct drm_crtc_state *old_crtc_state, *new_crtc_state;
>   	int i, ret;
>   	unsigned int crtc_mask = 0;
> @@ -1940,11 +1940,11 @@ EXPORT_SYMBOL(drm_atomic_helper_wait_for_vblanks);
>    *
>    * This requires that drivers use the nonblocking commit tracking support
>    * initialized using drm_atomic_helper_setup_commit().
>    */
>   void drm_atomic_helper_wait_for_flip_done(struct drm_device *dev,
> -					  struct drm_atomic_state *state)
> +					  struct drm_atomic_commit *state)
>   {
>   	struct drm_crtc *crtc;
>   	int i;
>   
>   	for (i = 0; i < dev->mode_config.num_crtc; i++) {
> @@ -1978,11 +1978,11 @@ EXPORT_SYMBOL(drm_atomic_helper_wait_for_flip_done);
>    * drm_atomic_helper_commit_tail_rpm().
>    *
>    * Note that the default ordering of how the various stages are called is to
>    * match the legacy modeset helper library closest.
>    */
> -void drm_atomic_helper_commit_tail(struct drm_atomic_state *state)
> +void drm_atomic_helper_commit_tail(struct drm_atomic_commit *state)
>   {
>   	struct drm_device *dev = state->dev;
>   
>   	drm_atomic_helper_commit_modeset_disables(dev, state);
>   
> @@ -2008,11 +2008,11 @@ EXPORT_SYMBOL(drm_atomic_helper_commit_tail);
>    * &drm_mode_config_helper_funcs.atomic_commit_tail hook, for drivers
>    * that support runtime_pm or need the CRTC to be enabled to perform a
>    * commit. Otherwise, one should use the default implementation
>    * drm_atomic_helper_commit_tail().
>    */
> -void drm_atomic_helper_commit_tail_rpm(struct drm_atomic_state *state)
> +void drm_atomic_helper_commit_tail_rpm(struct drm_atomic_commit *state)
>   {
>   	struct drm_device *dev = state->dev;
>   
>   	drm_atomic_helper_commit_modeset_disables(dev, state);
>   
> @@ -2029,11 +2029,11 @@ void drm_atomic_helper_commit_tail_rpm(struct drm_atomic_state *state)
>   
>   	drm_atomic_helper_cleanup_planes(dev, state);
>   }
>   EXPORT_SYMBOL(drm_atomic_helper_commit_tail_rpm);
>   
> -static void commit_tail(struct drm_atomic_state *state)
> +static void commit_tail(struct drm_atomic_commit *state)
>   {
>   	struct drm_device *dev = state->dev;
>   	const struct drm_mode_config_helper_funcs *funcs;
>   	struct drm_crtc_state *new_crtc_state;
>   	struct drm_crtc *crtc;
> @@ -2079,17 +2079,17 @@ static void commit_tail(struct drm_atomic_state *state)
>   						 (unsigned long)commit_time_ms,
>   						 new_self_refresh_mask);
>   
>   	drm_atomic_helper_commit_cleanup_done(state);
>   
> -	drm_atomic_state_put(state);
> +	drm_atomic_commit_put(state);
>   }
>   
>   static void commit_work(struct work_struct *work)
>   {
> -	struct drm_atomic_state *state = container_of(work,
> -						      struct drm_atomic_state,
> +	struct drm_atomic_commit *state = container_of(work,
> +						      struct drm_atomic_commit,
>   						      commit_work);
>   	commit_tail(state);
>   }
>   
>   /**
> @@ -2104,11 +2104,11 @@ static void commit_work(struct work_struct *work)
>    * It will return 0 if the commit can happen in an asynchronous fashion or error
>    * if not. Note that error just mean it can't be committed asynchronously, if it
>    * fails the commit should be treated like a normal synchronous commit.
>    */
>   int drm_atomic_helper_async_check(struct drm_device *dev,
> -				   struct drm_atomic_state *state)
> +				   struct drm_atomic_commit *state)
>   {
>   	struct drm_crtc *crtc;
>   	struct drm_crtc_state *crtc_state;
>   	struct drm_plane *plane = NULL;
>   	struct drm_plane_state *old_plane_state = NULL;
> @@ -2188,11 +2188,11 @@ EXPORT_SYMBOL(drm_atomic_helper_async_check);
>    * current state.
>    *
>    * TODO: Implement full swap instead of doing in-place changes.
>    */
>   void drm_atomic_helper_async_commit(struct drm_device *dev,
> -				    struct drm_atomic_state *state)
> +				    struct drm_atomic_commit *state)
>   {
>   	struct drm_plane *plane;
>   	struct drm_plane_state *plane_state;
>   	const struct drm_plane_helper_funcs *funcs;
>   	int i;
> @@ -2241,11 +2241,11 @@ EXPORT_SYMBOL(drm_atomic_helper_async_commit);
>    *
>    * RETURNS:
>    * Zero for success or -errno.
>    */
>   int drm_atomic_helper_commit(struct drm_device *dev,
> -			     struct drm_atomic_state *state,
> +			     struct drm_atomic_commit *state,
>   			     bool nonblock)
>   {
>   	int ret;
>   
>   	if (state->async_update) {
> @@ -2303,11 +2303,11 @@ int drm_atomic_helper_commit(struct drm_device *dev,
>   	 * NOTE: Commit work has multiple phases, first hardware commit, then
>   	 * cleanup. We want them to overlap, hence need system_dfl_wq to
>   	 * make sure work items don't artificially stall on each another.
>   	 */
>   
> -	drm_atomic_state_get(state);
> +	drm_atomic_commit_get(state);
>   	if (nonblock)
>   		queue_work(system_dfl_wq, &state->commit_work);
>   	else
>   		commit_tail(state);
>   
> @@ -2345,11 +2345,11 @@ EXPORT_SYMBOL(drm_atomic_helper_commit);
>    * individual commit in parallel - userspace is supposed to do that if it cares.
>    * But it might be beneficial to do that for modesets, since those necessarily
>    * must be done as one global operation, and enabling or disabling a CRTC can
>    * take a long time. But even that is not required.
>    *
> - * IMPORTANT: A &drm_atomic_state update for multiple CRTCs is sequenced
> + * IMPORTANT: A &drm_atomic_commit update for multiple CRTCs is sequenced
>    * against all CRTCs therein. Therefore for atomic state updates which only flip
>    * planes the driver must not get the struct &drm_crtc_state of unrelated CRTCs
>    * in its atomic check code: This would prevent committing of atomic updates to
>    * multiple CRTCs in parallel. In general, adding additional state structures
>    * should be avoided as much as possible, because this reduces parallelism in
> @@ -2440,11 +2440,11 @@ static void init_commit(struct drm_crtc_commit *commit, struct drm_crtc *crtc)
>   	kref_init(&commit->ref);
>   	commit->crtc = crtc;
>   }
>   
>   static struct drm_crtc_commit *
> -crtc_or_fake_commit(struct drm_atomic_state *state, struct drm_crtc *crtc)
> +crtc_or_fake_commit(struct drm_atomic_commit *state, struct drm_crtc *crtc)
>   {
>   	if (crtc) {
>   		struct drm_crtc_state *new_crtc_state;
>   
>   		new_crtc_state = drm_atomic_get_new_crtc_state(state, crtc);
> @@ -2499,18 +2499,18 @@ crtc_or_fake_commit(struct drm_atomic_state *state, struct drm_crtc *crtc)
>    *
>    * The tracking of asynchronously executed and still pending commits is done
>    * using the core structure &drm_crtc_commit.
>    *
>    * By default there's no need to clean up resources allocated by this function
> - * explicitly: drm_atomic_state_default_clear() will take care of that
> + * explicitly: drm_atomic_commit_default_clear() will take care of that
>    * automatically.
>    *
>    * Returns:
>    * 0 on success. -EBUSY when userspace schedules nonblocking commits too fast,
>    * -ENOMEM on allocation failures and -EINTR when a signal is pending.
>    */
> -int drm_atomic_helper_setup_commit(struct drm_atomic_state *state,
> +int drm_atomic_helper_setup_commit(struct drm_atomic_commit *state,
>   				   bool nonblock)
>   {
>   	struct drm_crtc *crtc;
>   	struct drm_crtc_state *old_crtc_state, *new_crtc_state;
>   	struct drm_connector *conn;
> @@ -2631,11 +2631,11 @@ EXPORT_SYMBOL(drm_atomic_helper_setup_commit);
>    * by calling drm_crtc_send_vblank_event() on the &drm_crtc_state.event).
>    *
>    * This is part of the atomic helper support for nonblocking commits, see
>    * drm_atomic_helper_setup_commit() for an overview.
>    */
> -void drm_atomic_helper_wait_for_dependencies(struct drm_atomic_state *state)
> +void drm_atomic_helper_wait_for_dependencies(struct drm_atomic_commit *state)
>   {
>   	struct drm_crtc *crtc;
>   	struct drm_crtc_state *old_crtc_state;
>   	struct drm_plane *plane;
>   	struct drm_plane_state *old_plane_state;
> @@ -2686,11 +2686,11 @@ EXPORT_SYMBOL(drm_atomic_helper_wait_for_dependencies);
>    * VBLANK interrupt.
>    *
>    * This is part of the atomic helper support for nonblocking commits, see
>    * drm_atomic_helper_setup_commit() for an overview.
>    */
> -void drm_atomic_helper_fake_vblank(struct drm_atomic_state *state)
> +void drm_atomic_helper_fake_vblank(struct drm_atomic_commit *state)
>   {
>   	struct drm_crtc_state *new_crtc_state;
>   	struct drm_crtc *crtc;
>   	int i;
>   
> @@ -2724,11 +2724,11 @@ EXPORT_SYMBOL(drm_atomic_helper_fake_vblank);
>    * this function is called.
>    *
>    * This is part of the atomic helper support for nonblocking commits, see
>    * drm_atomic_helper_setup_commit() for an overview.
>    */
> -void drm_atomic_helper_commit_hw_done(struct drm_atomic_state *state)
> +void drm_atomic_helper_commit_hw_done(struct drm_atomic_commit *state)
>   {
>   	struct drm_crtc *crtc;
>   	struct drm_crtc_state *old_crtc_state, *new_crtc_state;
>   	struct drm_crtc_commit *commit;
>   	int i;
> @@ -2764,16 +2764,16 @@ EXPORT_SYMBOL(drm_atomic_helper_commit_hw_done);
>    * drm_atomic_helper_commit_cleanup_done - signal completion of commit
>    * @state: atomic state object being committed
>    *
>    * This signals completion of the atomic update @state, including any
>    * cleanup work. If used, it must be called right before calling
> - * drm_atomic_state_put().
> + * drm_atomic_commit_put().
>    *
>    * This is part of the atomic helper support for nonblocking commits, see
>    * drm_atomic_helper_setup_commit() for an overview.
>    */
> -void drm_atomic_helper_commit_cleanup_done(struct drm_atomic_state *state)
> +void drm_atomic_helper_commit_cleanup_done(struct drm_atomic_commit *state)
>   {
>   	struct drm_crtc *crtc;
>   	struct drm_crtc_state *old_crtc_state;
>   	struct drm_crtc_commit *commit;
>   	int i;
> @@ -2810,11 +2810,11 @@ EXPORT_SYMBOL(drm_atomic_helper_commit_cleanup_done);
>    *
>    * Returns:
>    * 0 on success, negative error code on failure.
>    */
>   int drm_atomic_helper_prepare_planes(struct drm_device *dev,
> -				     struct drm_atomic_state *state)
> +				     struct drm_atomic_commit *state)
>   {
>   	struct drm_connector *connector;
>   	struct drm_connector_state *new_conn_state;
>   	struct drm_plane *plane;
>   	struct drm_plane_state *new_plane_state;
> @@ -2899,11 +2899,11 @@ EXPORT_SYMBOL(drm_atomic_helper_prepare_planes);
>    * atomic state. It undoes the effects of drm_atomic_helper_prepare_planes()
>    * when aborting an atomic commit. For cleaning up after a successful commit
>    * use drm_atomic_helper_cleanup_planes().
>    */
>   void drm_atomic_helper_unprepare_planes(struct drm_device *dev,
> -					struct drm_atomic_state *state)
> +					struct drm_atomic_commit *state)
>   {
>   	struct drm_plane *plane;
>   	struct drm_plane_state *new_plane_state;
>   	int i;
>   
> @@ -2968,11 +2968,11 @@ static bool plane_crtc_active(const struct drm_plane_state *state)
>    * The drm_atomic_helper_commit() default implementation doesn't set the
>    * ACTIVE_ONLY flag to most closely match the behaviour of the legacy helpers.
>    * This should not be copied blindly by drivers.
>    */
>   void drm_atomic_helper_commit_planes(struct drm_device *dev,
> -				     struct drm_atomic_state *state,
> +				     struct drm_atomic_commit *state,
>   				     uint32_t flags)
>   {
>   	struct drm_crtc *crtc;
>   	struct drm_crtc_state *old_crtc_state, *new_crtc_state;
>   	struct drm_plane *plane;
> @@ -3091,11 +3091,11 @@ EXPORT_SYMBOL(drm_atomic_helper_commit_planes);
>   void
>   drm_atomic_helper_commit_planes_on_crtc(struct drm_crtc_state *old_crtc_state)
>   {
>   	const struct drm_crtc_helper_funcs *crtc_funcs;
>   	struct drm_crtc *crtc = old_crtc_state->crtc;
> -	struct drm_atomic_state *old_state = old_crtc_state->state;
> +	struct drm_atomic_commit *old_state = old_crtc_state->state;
>   	struct drm_crtc_state *new_crtc_state =
>   		drm_atomic_get_new_crtc_state(old_state, crtc);
>   	struct drm_plane *plane;
>   	unsigned int plane_mask;
>   
> @@ -3198,11 +3198,11 @@ EXPORT_SYMBOL(drm_atomic_helper_disable_planes_on_crtc);
>    * This function may not be called on the new state when the atomic update
>    * fails at any point after calling drm_atomic_helper_prepare_planes(). Use
>    * drm_atomic_helper_unprepare_planes() in this case.
>    */
>   void drm_atomic_helper_cleanup_planes(struct drm_device *dev,
> -				      struct drm_atomic_state *state)
> +				      struct drm_atomic_commit *state)
>   {
>   	struct drm_plane *plane;
>   	struct drm_plane_state *old_plane_state;
>   	int i;
>   
> @@ -3247,11 +3247,11 @@ EXPORT_SYMBOL(drm_atomic_helper_cleanup_planes);
>    *
>    * Returns:
>    * Returns 0 on success. Can return -ERESTARTSYS when @stall is true and the
>    * waiting for the previous commits has been interrupted.
>    */
> -int drm_atomic_helper_swap_state(struct drm_atomic_state *state,
> +int drm_atomic_helper_swap_state(struct drm_atomic_commit *state,
>   				  bool stall)
>   {
>   	int i, ret;
>   	unsigned long flags = 0;
>   	struct drm_connector *connector;
> @@ -3402,15 +3402,15 @@ int drm_atomic_helper_update_plane(struct drm_plane *plane,
>   				   unsigned int crtc_w, unsigned int crtc_h,
>   				   uint32_t src_x, uint32_t src_y,
>   				   uint32_t src_w, uint32_t src_h,
>   				   struct drm_modeset_acquire_ctx *ctx)
>   {
> -	struct drm_atomic_state *state;
> +	struct drm_atomic_commit *state;
>   	struct drm_plane_state *plane_state;
>   	int ret = 0;
>   
> -	state = drm_atomic_state_alloc(plane->dev);
> +	state = drm_atomic_commit_alloc(plane->dev);
>   	if (!state)
>   		return -ENOMEM;
>   
>   	state->acquire_ctx = ctx;
>   	plane_state = drm_atomic_get_plane_state(state, plane);
> @@ -3435,11 +3435,11 @@ int drm_atomic_helper_update_plane(struct drm_plane *plane,
>   	if (plane == crtc->cursor)
>   		state->legacy_cursor_update = true;
>   
>   	ret = drm_atomic_commit(state);
>   fail:
> -	drm_atomic_state_put(state);
> +	drm_atomic_commit_put(state);
>   	return ret;
>   }
>   EXPORT_SYMBOL(drm_atomic_helper_update_plane);
>   
>   /**
> @@ -3453,15 +3453,15 @@ EXPORT_SYMBOL(drm_atomic_helper_update_plane);
>    * Zero on success, error code on failure
>    */
>   int drm_atomic_helper_disable_plane(struct drm_plane *plane,
>   				    struct drm_modeset_acquire_ctx *ctx)
>   {
> -	struct drm_atomic_state *state;
> +	struct drm_atomic_commit *state;
>   	struct drm_plane_state *plane_state;
>   	int ret = 0;
>   
> -	state = drm_atomic_state_alloc(plane->dev);
> +	state = drm_atomic_commit_alloc(plane->dev);
>   	if (!state)
>   		return -ENOMEM;
>   
>   	state->acquire_ctx = ctx;
>   	plane_state = drm_atomic_get_plane_state(state, plane);
> @@ -3477,11 +3477,11 @@ int drm_atomic_helper_disable_plane(struct drm_plane *plane,
>   	if (ret != 0)
>   		goto fail;
>   
>   	ret = drm_atomic_commit(state);
>   fail:
> -	drm_atomic_state_put(state);
> +	drm_atomic_commit_put(state);
>   	return ret;
>   }
>   EXPORT_SYMBOL(drm_atomic_helper_disable_plane);
>   
>   /**
> @@ -3501,15 +3501,15 @@ EXPORT_SYMBOL(drm_atomic_helper_disable_plane);
>    * Returns 0 on success, negative errno numbers on failure.
>    */
>   int drm_atomic_helper_set_config(struct drm_mode_set *set,
>   				 struct drm_modeset_acquire_ctx *ctx)
>   {
> -	struct drm_atomic_state *state;
> +	struct drm_atomic_commit *state;
>   	struct drm_crtc *crtc = set->crtc;
>   	int ret = 0;
>   
> -	state = drm_atomic_state_alloc(crtc->dev);
> +	state = drm_atomic_commit_alloc(crtc->dev);
>   	if (!state)
>   		return -ENOMEM;
>   
>   	state->acquire_ctx = ctx;
>   	ret = __drm_atomic_helper_set_config(set, state);
> @@ -3521,11 +3521,11 @@ int drm_atomic_helper_set_config(struct drm_mode_set *set,
>   		goto fail;
>   
>   	ret = drm_atomic_commit(state);
>   
>   fail:
> -	drm_atomic_state_put(state);
> +	drm_atomic_commit_put(state);
>   	return ret;
>   }
>   EXPORT_SYMBOL(drm_atomic_helper_set_config);
>   
>   /**
> @@ -3552,20 +3552,20 @@ EXPORT_SYMBOL(drm_atomic_helper_set_config);
>    * drm_atomic_helper_shutdown().
>    */
>   int drm_atomic_helper_disable_all(struct drm_device *dev,
>   				  struct drm_modeset_acquire_ctx *ctx)
>   {
> -	struct drm_atomic_state *state;
> +	struct drm_atomic_commit *state;
>   	struct drm_connector_state *conn_state;
>   	struct drm_connector *conn;
>   	struct drm_plane_state *plane_state;
>   	struct drm_plane *plane;
>   	struct drm_crtc_state *crtc_state;
>   	struct drm_crtc *crtc;
>   	int ret, i;
>   
> -	state = drm_atomic_state_alloc(dev);
> +	state = drm_atomic_commit_alloc(dev);
>   	if (!state)
>   		return -ENOMEM;
>   
>   	state->acquire_ctx = ctx;
>   
> @@ -3605,11 +3605,11 @@ int drm_atomic_helper_disable_all(struct drm_device *dev,
>   		drm_atomic_set_fb_for_plane(plane_state, NULL);
>   	}
>   
>   	ret = drm_atomic_commit(state);
>   free:
> -	drm_atomic_state_put(state);
> +	drm_atomic_commit_put(state);
>   	return ret;
>   }
>   EXPORT_SYMBOL(drm_atomic_helper_disable_all);
>   
>   /**
> @@ -3632,15 +3632,15 @@ EXPORT_SYMBOL(drm_atomic_helper_disable_all);
>    * 0 on success or a negative error code on failure.
>    */
>   int drm_atomic_helper_reset_crtc(struct drm_crtc *crtc,
>   				 struct drm_modeset_acquire_ctx *ctx)
>   {
> -	struct drm_atomic_state *state;
> +	struct drm_atomic_commit *state;
>   	struct drm_crtc_state *crtc_state;
>   	int ret;
>   
> -	state = drm_atomic_state_alloc(crtc->dev);
> +	state = drm_atomic_commit_alloc(crtc->dev);
>   	if (!state)
>   		return -ENOMEM;
>   
>   	state->acquire_ctx = ctx;
>   
> @@ -3652,11 +3652,11 @@ int drm_atomic_helper_reset_crtc(struct drm_crtc *crtc,
>   
>   	crtc_state->connectors_changed = true;
>   
>   	ret = drm_atomic_commit(state);
>   out:
> -	drm_atomic_state_put(state);
> +	drm_atomic_commit_put(state);
>   
>   	return ret;
>   }
>   EXPORT_SYMBOL(drm_atomic_helper_reset_crtc);
>   
> @@ -3713,22 +3713,22 @@ EXPORT_SYMBOL(drm_atomic_helper_shutdown);
>    * ERR_PTR()-encoded error code on failure.
>    *
>    * See also:
>    * drm_atomic_helper_suspend(), drm_atomic_helper_resume()
>    */
> -struct drm_atomic_state *
> +struct drm_atomic_commit *
>   drm_atomic_helper_duplicate_state(struct drm_device *dev,
>   				  struct drm_modeset_acquire_ctx *ctx)
>   {
> -	struct drm_atomic_state *state;
> +	struct drm_atomic_commit *state;
>   	struct drm_connector *conn;
>   	struct drm_connector_list_iter conn_iter;
>   	struct drm_plane *plane;
>   	struct drm_crtc *crtc;
>   	int err = 0;
>   
> -	state = drm_atomic_state_alloc(dev);
> +	state = drm_atomic_commit_alloc(dev);
>   	if (!state)
>   		return ERR_PTR(-ENOMEM);
>   
>   	state->acquire_ctx = ctx;
>   	state->duplicated = true;
> @@ -3769,11 +3769,11 @@ drm_atomic_helper_duplicate_state(struct drm_device *dev,
>   	/* clear the acquire context so that it isn't accidentally reused */
>   	state->acquire_ctx = NULL;
>   
>   free:
>   	if (err < 0) {
> -		drm_atomic_state_put(state);
> +		drm_atomic_commit_put(state);
>   		state = ERR_PTR(err);
>   	}
>   
>   	return state;
>   }
> @@ -3802,14 +3802,14 @@ EXPORT_SYMBOL(drm_atomic_helper_duplicate_state);
>    *
>    * See also:
>    * drm_atomic_helper_duplicate_state(), drm_atomic_helper_disable_all(),
>    * drm_atomic_helper_resume(), drm_atomic_helper_commit_duplicated_state()
>    */
> -struct drm_atomic_state *drm_atomic_helper_suspend(struct drm_device *dev)
> +struct drm_atomic_commit *drm_atomic_helper_suspend(struct drm_device *dev)
>   {
>   	struct drm_modeset_acquire_ctx ctx;
> -	struct drm_atomic_state *state;
> +	struct drm_atomic_commit *state;
>   	int err;
>   
>   	/* This can never be returned, but it makes the compiler happy */
>   	state = ERR_PTR(-EINVAL);
>   
> @@ -3819,11 +3819,11 @@ struct drm_atomic_state *drm_atomic_helper_suspend(struct drm_device *dev)
>   	if (IS_ERR(state))
>   		goto unlock;
>   
>   	err = drm_atomic_helper_disable_all(dev, &ctx);
>   	if (err < 0) {
> -		drm_atomic_state_put(state);
> +		drm_atomic_commit_put(state);
>   		state = ERR_PTR(err);
>   		goto unlock;
>   	}
>   
>   unlock:
> @@ -3848,11 +3848,11 @@ EXPORT_SYMBOL(drm_atomic_helper_suspend);
>    * 0 on success or a negative error code on failure.
>    *
>    * See also:
>    * drm_atomic_helper_suspend()
>    */
> -int drm_atomic_helper_commit_duplicated_state(struct drm_atomic_state *state,
> +int drm_atomic_helper_commit_duplicated_state(struct drm_atomic_commit *state,
>   					      struct drm_modeset_acquire_ctx *ctx)
>   {
>   	int i, ret;
>   	struct drm_plane *plane;
>   	struct drm_plane_state *new_plane_state;
> @@ -3895,11 +3895,11 @@ EXPORT_SYMBOL(drm_atomic_helper_commit_duplicated_state);
>    *
>    * See also:
>    * drm_atomic_helper_suspend()
>    */
>   int drm_atomic_helper_resume(struct drm_device *dev,
> -			     struct drm_atomic_state *state)
> +			     struct drm_atomic_commit *state)
>   {
>   	struct drm_modeset_acquire_ctx ctx;
>   	int err;
>   
>   	drm_mode_config_reset(dev);
> @@ -3907,17 +3907,17 @@ int drm_atomic_helper_resume(struct drm_device *dev,
>   	DRM_MODESET_LOCK_ALL_BEGIN(dev, ctx, 0, err);
>   
>   	err = drm_atomic_helper_commit_duplicated_state(state, &ctx);
>   
>   	DRM_MODESET_LOCK_ALL_END(dev, ctx, err);
> -	drm_atomic_state_put(state);
> +	drm_atomic_commit_put(state);
>   
>   	return err;
>   }
>   EXPORT_SYMBOL(drm_atomic_helper_resume);
>   
> -static int page_flip_common(struct drm_atomic_state *state,
> +static int page_flip_common(struct drm_atomic_commit *state,
>   			    struct drm_crtc *crtc,
>   			    struct drm_framebuffer *fb,
>   			    struct drm_pending_vblank_event *event,
>   			    uint32_t flags)
>   {
> @@ -3976,14 +3976,14 @@ int drm_atomic_helper_page_flip(struct drm_crtc *crtc,
>   				struct drm_pending_vblank_event *event,
>   				uint32_t flags,
>   				struct drm_modeset_acquire_ctx *ctx)
>   {
>   	struct drm_plane *plane = crtc->primary;
> -	struct drm_atomic_state *state;
> +	struct drm_atomic_commit *state;
>   	int ret = 0;
>   
> -	state = drm_atomic_state_alloc(plane->dev);
> +	state = drm_atomic_commit_alloc(plane->dev);
>   	if (!state)
>   		return -ENOMEM;
>   
>   	state->acquire_ctx = ctx;
>   
> @@ -3991,11 +3991,11 @@ int drm_atomic_helper_page_flip(struct drm_crtc *crtc,
>   	if (ret != 0)
>   		goto fail;
>   
>   	ret = drm_atomic_nonblocking_commit(state);
>   fail:
> -	drm_atomic_state_put(state);
> +	drm_atomic_commit_put(state);
>   	return ret;
>   }
>   EXPORT_SYMBOL(drm_atomic_helper_page_flip);
>   
>   /**
> @@ -4020,15 +4020,15 @@ int drm_atomic_helper_page_flip_target(struct drm_crtc *crtc,
>   				       uint32_t flags,
>   				       uint32_t target,
>   				       struct drm_modeset_acquire_ctx *ctx)
>   {
>   	struct drm_plane *plane = crtc->primary;
> -	struct drm_atomic_state *state;
> +	struct drm_atomic_commit *state;
>   	struct drm_crtc_state *crtc_state;
>   	int ret = 0;
>   
> -	state = drm_atomic_state_alloc(plane->dev);
> +	state = drm_atomic_commit_alloc(plane->dev);
>   	if (!state)
>   		return -ENOMEM;
>   
>   	state->acquire_ctx = ctx;
>   
> @@ -4043,11 +4043,11 @@ int drm_atomic_helper_page_flip_target(struct drm_crtc *crtc,
>   	}
>   	crtc_state->target_vblank = target;
>   
>   	ret = drm_atomic_nonblocking_commit(state);
>   fail:
> -	drm_atomic_state_put(state);
> +	drm_atomic_commit_put(state);
>   	return ret;
>   }
>   EXPORT_SYMBOL(drm_atomic_helper_page_flip_target);
>   
>   /**
> diff --git a/drivers/gpu/drm/drm_atomic_state_helper.c b/drivers/gpu/drm/drm_atomic_state_helper.c
> index 76746ad4a1bbb7142c067c93dd05fbec5d2f98eb..cc70508d4fdba1fbb8c5edd74f1cd3efd077071c 100644
> --- a/drivers/gpu/drm/drm_atomic_state_helper.c
> +++ b/drivers/gpu/drm/drm_atomic_state_helper.c
> @@ -587,11 +587,11 @@ EXPORT_SYMBOL(drm_atomic_helper_connector_tv_reset);
>    *
>    * Return:
>    * %0 for success, a negative error code on error.
>    */
>   int drm_atomic_helper_connector_tv_check(struct drm_connector *connector,
> -					 struct drm_atomic_state *state)
> +					 struct drm_atomic_commit *state)
>   {
>   	struct drm_connector_state *old_conn_state =
>   		drm_atomic_get_old_connector_state(state, connector);
>   	struct drm_connector_state *new_conn_state =
>   		drm_atomic_get_new_connector_state(state, connector);
> diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/drm_atomic_uapi.c
> index 5bd5bf6661df7f6cefae616970a99a4b04de7121..6441b55cc2740cad66ab395df34c321ab8066ed9 100644
> --- a/drivers/gpu/drm/drm_atomic_uapi.c
> +++ b/drivers/gpu/drm/drm_atomic_uapi.c
> @@ -345,28 +345,28 @@ drm_atomic_set_crtc_for_connector(struct drm_connector_state *conn_state,
>   
>   	return 0;
>   }
>   EXPORT_SYMBOL(drm_atomic_set_crtc_for_connector);
>   
> -static void set_out_fence_for_crtc(struct drm_atomic_state *state,
> +static void set_out_fence_for_crtc(struct drm_atomic_commit *state,
>   				   struct drm_crtc *crtc, s32 __user *fence_ptr)
>   {
>   	state->crtcs[drm_crtc_index(crtc)].out_fence_ptr = fence_ptr;
>   }
>   
> -static s32 __user *get_out_fence_for_crtc(struct drm_atomic_state *state,
> +static s32 __user *get_out_fence_for_crtc(struct drm_atomic_commit *state,
>   					  struct drm_crtc *crtc)
>   {
>   	s32 __user *fence_ptr;
>   
>   	fence_ptr = state->crtcs[drm_crtc_index(crtc)].out_fence_ptr;
>   	state->crtcs[drm_crtc_index(crtc)].out_fence_ptr = NULL;
>   
>   	return fence_ptr;
>   }
>   
> -static int set_out_fence_for_connector(struct drm_atomic_state *state,
> +static int set_out_fence_for_connector(struct drm_atomic_commit *state,
>   					struct drm_connector *connector,
>   					s32 __user *fence_ptr)
>   {
>   	unsigned int index = drm_connector_index(connector);
>   
> @@ -379,11 +379,11 @@ static int set_out_fence_for_connector(struct drm_atomic_state *state,
>   	state->connectors[index].out_fence_ptr = fence_ptr;
>   
>   	return 0;
>   }
>   
> -static s32 __user *get_out_fence_for_connector(struct drm_atomic_state *state,
> +static s32 __user *get_out_fence_for_connector(struct drm_atomic_commit *state,
>   					       struct drm_connector *connector)
>   {
>   	unsigned int index = drm_connector_index(connector);
>   	s32 __user *fence_ptr;
>   
> @@ -1102,11 +1102,11 @@ static struct drm_pending_vblank_event *create_vblank_event(
>   	e->event.vbl.user_data = user_data;
>   
>   	return e;
>   }
>   
> -int drm_atomic_connector_commit_dpms(struct drm_atomic_state *state,
> +int drm_atomic_connector_commit_dpms(struct drm_atomic_commit *state,
>   				     struct drm_connector *connector,
>   				     int mode)
>   {
>   	struct drm_connector *tmp_connector;
>   	struct drm_connector_state *new_conn_state;
> @@ -1169,11 +1169,11 @@ static int drm_atomic_check_prop_changes(int ret, uint64_t old_val, uint64_t pro
>   	}
>   
>   	return 0;
>   }
>   
> -int drm_atomic_set_property(struct drm_atomic_state *state,
> +int drm_atomic_set_property(struct drm_atomic_commit *state,
>   			    struct drm_file *file_priv,
>   			    struct drm_mode_object *obj,
>   			    struct drm_property *prop,
>   			    u64 prop_value,
>   			    bool async_flip)
> @@ -1372,11 +1372,11 @@ static int setup_out_fence(struct drm_out_fence_state *fence_state,
>   
>   	return 0;
>   }
>   
>   static int prepare_signaling(struct drm_device *dev,
> -				  struct drm_atomic_state *state,
> +				  struct drm_atomic_commit *state,
>   				  struct drm_mode_atomic *arg,
>   				  struct drm_file *file_priv,
>   				  struct drm_out_fence_state **fence_state,
>   				  unsigned int *num_fences)
>   {
> @@ -1497,11 +1497,11 @@ static int prepare_signaling(struct drm_device *dev,
>   
>   	return 0;
>   }
>   
>   static void complete_signaling(struct drm_device *dev,
> -			       struct drm_atomic_state *state,
> +			       struct drm_atomic_commit *state,
>   			       struct drm_out_fence_state *fence_state,
>   			       unsigned int num_fences,
>   			       bool install_fds)
>   {
>   	struct drm_crtc *crtc;
> @@ -1520,11 +1520,11 @@ static void complete_signaling(struct drm_device *dev,
>   	for_each_new_crtc_in_state(state, crtc, crtc_state, i) {
>   		struct drm_pending_vblank_event *event = crtc_state->event;
>   		/*
>   		 * Free the allocated event. drm_atomic_helper_setup_commit
>   		 * can allocate an event too, so only free it if it's ours
> -		 * to prevent a double free in drm_atomic_state_clear.
> +		 * to prevent a double free in drm_atomic_commit_clear.
>   		 */
>   		if (event && (event->base.fence || event->base.file_priv)) {
>   			drm_event_cancel_free(dev, &event->base);
>   			crtc_state->event = NULL;
>   		}
> @@ -1547,11 +1547,11 @@ static void complete_signaling(struct drm_device *dev,
>   
>   	kfree(fence_state);
>   }
>   
>   static void
> -set_async_flip(struct drm_atomic_state *state)
> +set_async_flip(struct drm_atomic_commit *state)
>   {
>   	struct drm_crtc *crtc;
>   	struct drm_crtc_state *crtc_state;
>   	int i;
>   
> @@ -1567,11 +1567,11 @@ int drm_mode_atomic_ioctl(struct drm_device *dev,
>   	uint32_t __user *objs_ptr = (uint32_t __user *)(unsigned long)(arg->objs_ptr);
>   	uint32_t __user *count_props_ptr = (uint32_t __user *)(unsigned long)(arg->count_props_ptr);
>   	uint32_t __user *props_ptr = (uint32_t __user *)(unsigned long)(arg->props_ptr);
>   	uint64_t __user *prop_values_ptr = (uint64_t __user *)(unsigned long)(arg->prop_values_ptr);
>   	unsigned int copied_objs, copied_props;
> -	struct drm_atomic_state *state;
> +	struct drm_atomic_commit *state;
>   	struct drm_modeset_acquire_ctx ctx;
>   	struct drm_out_fence_state *fence_state;
>   	int ret = 0;
>   	unsigned int i, j, num_fences;
>   	bool async_flip = false;
> @@ -1616,11 +1616,11 @@ int drm_mode_atomic_ioctl(struct drm_device *dev,
>   		drm_dbg_atomic(dev,
>   			       "commit failed: page-flip event requested with test-only commit\n");
>   		return -EINVAL;
>   	}
>   
> -	state = drm_atomic_state_alloc(dev);
> +	state = drm_atomic_commit_alloc(dev);
>   	if (!state)
>   		return -ENOMEM;
>   
>   	drm_modeset_acquire_init(&ctx, DRM_MODESET_ACQUIRE_INTERRUPTIBLE);
>   	state->acquire_ctx = &ctx;
> @@ -1724,17 +1724,17 @@ int drm_mode_atomic_ioctl(struct drm_device *dev,
>   
>   out:
>   	complete_signaling(dev, state, fence_state, num_fences, !ret);
>   
>   	if (ret == -EDEADLK) {
> -		drm_atomic_state_clear(state);
> +		drm_atomic_commit_clear(state);
>   		ret = drm_modeset_backoff(&ctx);
>   		if (!ret)
>   			goto retry;
>   	}
>   
> -	drm_atomic_state_put(state);
> +	drm_atomic_commit_put(state);
>   
>   	drm_modeset_drop_locks(&ctx);
>   	drm_modeset_acquire_fini(&ctx);
>   
>   	return ret;
> diff --git a/drivers/gpu/drm/drm_blend.c b/drivers/gpu/drm/drm_blend.c
> index 1f3af27d2418e3104c4d770c8226d4c10c214833..2f0d1ba285be872c87a8609b0d5015cb4d78ae9b 100644
> --- a/drivers/gpu/drm/drm_blend.c
> +++ b/drivers/gpu/drm/drm_blend.c
> @@ -447,11 +447,11 @@ int drm_plane_create_zpos_immutable_property(struct drm_plane *plane,
>   
>   	return 0;
>   }
>   EXPORT_SYMBOL(drm_plane_create_zpos_immutable_property);
>   
> -static int drm_atomic_state_zpos_cmp(const void *a, const void *b)
> +static int drm_atomic_commit_zpos_cmp(const void *a, const void *b)
>   {
>   	const struct drm_plane_state *sa = *(struct drm_plane_state **)a;
>   	const struct drm_plane_state *sb = *(struct drm_plane_state **)b;
>   
>   	if (sa->zpos != sb->zpos)
> @@ -461,11 +461,11 @@ static int drm_atomic_state_zpos_cmp(const void *a, const void *b)
>   }
>   
>   static int drm_atomic_helper_crtc_normalize_zpos(struct drm_crtc *crtc,
>   					  struct drm_crtc_state *crtc_state)
>   {
> -	struct drm_atomic_state *state = crtc_state->state;
> +	struct drm_atomic_commit *state = crtc_state->state;
>   	struct drm_device *dev = crtc->dev;
>   	int total_planes = dev->mode_config.num_total_plane;
>   	struct drm_plane_state **states;
>   	struct drm_plane *plane;
>   	int i, n = 0;
> @@ -492,11 +492,11 @@ static int drm_atomic_helper_crtc_normalize_zpos(struct drm_crtc *crtc,
>   		states[n++] = plane_state;
>   		drm_dbg_atomic(dev, "[PLANE:%d:%s] processing zpos value %d\n",
>   			       plane->base.id, plane->name, plane_state->zpos);
>   	}
>   
> -	sort(states, n, sizeof(*states), drm_atomic_state_zpos_cmp, NULL);
> +	sort(states, n, sizeof(*states), drm_atomic_commit_zpos_cmp, NULL);
>   
>   	for (i = 0; i < n; i++) {
>   		plane = states[i]->plane;
>   
>   		states[i]->normalized_zpos = i;
> @@ -527,11 +527,11 @@ static int drm_atomic_helper_crtc_normalize_zpos(struct drm_crtc *crtc,
>    *
>    * RETURNS
>    * Zero for success or -errno
>    */
>   int drm_atomic_normalize_zpos(struct drm_device *dev,
> -			      struct drm_atomic_state *state)
> +			      struct drm_atomic_commit *state)
>   {
>   	struct drm_crtc *crtc;
>   	struct drm_crtc_state *old_crtc_state, *new_crtc_state;
>   	struct drm_plane *plane;
>   	struct drm_plane_state *old_plane_state, *new_plane_state;
> diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
> index 1c2903c6e44b0bf118376f464ffcfa99ecfedcc7..e6246a8a8dc22385b3b8746bf7c219cda3eb6929 100644
> --- a/drivers/gpu/drm/drm_bridge.c
> +++ b/drivers/gpu/drm/drm_bridge.c
> @@ -800,11 +800,11 @@ EXPORT_SYMBOL(drm_bridge_chain_mode_set);
>    * &drm_encoder_helper_funcs.atomic_disable
>    *
>    * Note: the bridge passed should be the one closest to the encoder
>    */
>   void drm_atomic_bridge_chain_disable(struct drm_bridge *bridge,
> -				     struct drm_atomic_state *state)
> +				     struct drm_atomic_commit *state)
>   {
>   	struct drm_encoder *encoder;
>   	struct drm_bridge *iter;
>   
>   	if (!bridge)
> @@ -823,11 +823,11 @@ void drm_atomic_bridge_chain_disable(struct drm_bridge *bridge,
>   	}
>   }
>   EXPORT_SYMBOL(drm_atomic_bridge_chain_disable);
>   
>   static void drm_atomic_bridge_call_post_disable(struct drm_bridge *bridge,
> -						struct drm_atomic_state *state)
> +						struct drm_atomic_commit *state)
>   {
>   	if (state && bridge->funcs->atomic_post_disable)
>   		bridge->funcs->atomic_post_disable(bridge, state);
>   	else if (bridge->funcs->post_disable)
>   		bridge->funcs->post_disable(bridge);
> @@ -856,11 +856,11 @@ static void drm_atomic_bridge_call_post_disable(struct drm_bridge *bridge,
>    * Bridge B, Bridge A, Bridge E, Bridge D, Bridge C.
>    *
>    * Note: the bridge passed should be the one closest to the encoder
>    */
>   void drm_atomic_bridge_chain_post_disable(struct drm_bridge *bridge,
> -					  struct drm_atomic_state *state)
> +					  struct drm_atomic_commit *state)
>   {
>   	struct drm_encoder *encoder;
>   	struct drm_bridge *next, *limit;
>   
>   	if (!bridge)
> @@ -918,11 +918,11 @@ void drm_atomic_bridge_chain_post_disable(struct drm_bridge *bridge,
>   	}
>   }
>   EXPORT_SYMBOL(drm_atomic_bridge_chain_post_disable);
>   
>   static void drm_atomic_bridge_call_pre_enable(struct drm_bridge *bridge,
> -					      struct drm_atomic_state *state)
> +					      struct drm_atomic_commit *state)
>   {
>   	if (state && bridge->funcs->atomic_pre_enable)
>   		bridge->funcs->atomic_pre_enable(bridge, state);
>   	else if (bridge->funcs->pre_enable)
>   		bridge->funcs->pre_enable(bridge);
> @@ -950,11 +950,11 @@ static void drm_atomic_bridge_call_pre_enable(struct drm_bridge *bridge,
>    * Bridge C, Bridge D, Bridge E, Bridge A, Bridge B.
>    *
>    * Note: the bridge passed should be the one closest to the encoder
>    */
>   void drm_atomic_bridge_chain_pre_enable(struct drm_bridge *bridge,
> -					struct drm_atomic_state *state)
> +					struct drm_atomic_commit *state)
>   {
>   	struct drm_encoder *encoder;
>   	struct drm_bridge *iter, *next, *limit;
>   
>   	if (!bridge)
> @@ -1018,11 +1018,11 @@ EXPORT_SYMBOL(drm_atomic_bridge_chain_pre_enable);
>    * &drm_encoder_helper_funcs.atomic_enable
>    *
>    * Note: the bridge passed should be the one closest to the encoder
>    */
>   void drm_atomic_bridge_chain_enable(struct drm_bridge *bridge,
> -				    struct drm_atomic_state *state)
> +				    struct drm_atomic_commit *state)
>   {
>   	struct drm_encoder *encoder;
>   
>   	if (!bridge)
>   		return;
> @@ -1247,11 +1247,11 @@ drm_atomic_bridge_chain_select_bus_fmts(struct drm_bridge *bridge,
>   }
>   
>   static void
>   drm_atomic_bridge_propagate_bus_flags(struct drm_bridge *bridge,
>   				      struct drm_connector *conn,
> -				      struct drm_atomic_state *state)
> +				      struct drm_atomic_commit *state)
>   {
>   	struct drm_bridge_state *bridge_state, *next_bridge_state;
>   	u32 output_flags = 0;
>   
>   	bridge_state = drm_atomic_get_new_bridge_state(state, bridge);
> diff --git a/drivers/gpu/drm/drm_client_modeset.c b/drivers/gpu/drm/drm_client_modeset.c
> index bb49b8361271a3f8a09a2f0579f4fe1d2271b2d8..0080a8e9556a581a66d239dce875b7d15f9e6bcd 100644
> --- a/drivers/gpu/drm/drm_client_modeset.c
> +++ b/drivers/gpu/drm/drm_client_modeset.c
> @@ -1033,18 +1033,18 @@ EXPORT_SYMBOL(drm_client_rotation);
>   
>   static int drm_client_modeset_commit_atomic(struct drm_client_dev *client, bool active, bool check)
>   {
>   	struct drm_device *dev = client->dev;
>   	struct drm_plane *plane;
> -	struct drm_atomic_state *state;
> +	struct drm_atomic_commit *state;
>   	struct drm_modeset_acquire_ctx ctx;
>   	struct drm_mode_set *mode_set;
>   	int ret;
>   
>   	drm_modeset_acquire_init(&ctx, 0);
>   
> -	state = drm_atomic_state_alloc(dev);
> +	state = drm_atomic_commit_alloc(dev);
>   	if (!state) {
>   		ret = -ENOMEM;
>   		goto out_ctx;
>   	}
>   
> @@ -1105,19 +1105,19 @@ static int drm_client_modeset_commit_atomic(struct drm_client_dev *client, bool
>   
>   out_state:
>   	if (ret == -EDEADLK)
>   		goto backoff;
>   
> -	drm_atomic_state_put(state);
> +	drm_atomic_commit_put(state);
>   out_ctx:
>   	drm_modeset_drop_locks(&ctx);
>   	drm_modeset_acquire_fini(&ctx);
>   
>   	return ret;
>   
>   backoff:
> -	drm_atomic_state_clear(state);
> +	drm_atomic_commit_clear(state);
>   	drm_modeset_backoff(&ctx);
>   
>   	goto retry;
>   }
>   
> diff --git a/drivers/gpu/drm/drm_color_mgmt.c b/drivers/gpu/drm/drm_color_mgmt.c
> index c598b99673fc15159e2e2b56563f17ce9ce81a65..ca28db72fa890c63182136c6cb5466652f627134 100644
> --- a/drivers/gpu/drm/drm_color_mgmt.c
> +++ b/drivers/gpu/drm/drm_color_mgmt.c
> @@ -278,11 +278,11 @@ static int drm_crtc_legacy_gamma_set(struct drm_crtc *crtc,
>   				     u16 *red, u16 *green, u16 *blue,
>   				     u32 size,
>   				     struct drm_modeset_acquire_ctx *ctx)
>   {
>   	struct drm_device *dev = crtc->dev;
> -	struct drm_atomic_state *state;
> +	struct drm_atomic_commit *state;
>   	struct drm_crtc_state *crtc_state;
>   	struct drm_property_blob *blob;
>   	struct drm_color_lut *blob_data;
>   	u32 gamma_id = dev->mode_config.gamma_lut_property->base.id;
>   	u32 degamma_id = dev->mode_config.degamma_lut_property->base.id;
> @@ -298,11 +298,11 @@ static int drm_crtc_legacy_gamma_set(struct drm_crtc *crtc,
>   	else if (drm_mode_obj_find_prop_id(&crtc->base, degamma_id))
>   		use_gamma_lut = false;
>   	else
>   		return -ENODEV;
>   
> -	state = drm_atomic_state_alloc(crtc->dev);
> +	state = drm_atomic_commit_alloc(crtc->dev);
>   	if (!state)
>   		return -ENOMEM;
>   
>   	blob = drm_property_create_blob(dev,
>   					sizeof(struct drm_color_lut) * size,
> @@ -337,11 +337,11 @@ static int drm_crtc_legacy_gamma_set(struct drm_crtc *crtc,
>   	crtc_state->color_mgmt_changed |= replaced;
>   
>   	ret = drm_atomic_commit(state);
>   
>   fail:
> -	drm_atomic_state_put(state);
> +	drm_atomic_commit_put(state);
>   	drm_property_blob_put(blob);
>   	return ret;
>   }
>   
>   /**
> diff --git a/drivers/gpu/drm/drm_crtc_helper.c b/drivers/gpu/drm/drm_crtc_helper.c
> index 5de9aaa5ba04343b7e0c419c2b720a4b36c8365a..4a8cfe046e4abbf4d200d955fead8dbffbe81c3a 100644
> --- a/drivers/gpu/drm/drm_crtc_helper.c
> +++ b/drivers/gpu/drm/drm_crtc_helper.c
> @@ -444,11 +444,11 @@ EXPORT_SYMBOL(drm_crtc_helper_set_mode);
>    * of simple framebuffers.
>    *
>    * RETURNS:
>    * Zero on success, or an errno code otherwise.
>    */
> -int drm_crtc_helper_atomic_check(struct drm_crtc *crtc, struct drm_atomic_state *state)
> +int drm_crtc_helper_atomic_check(struct drm_crtc *crtc, struct drm_atomic_commit *state)
>   {
>   	struct drm_crtc_state *new_crtc_state = drm_atomic_get_new_crtc_state(state, crtc);
>   
>   	if (!new_crtc_state->enable)
>   		return 0;
> diff --git a/drivers/gpu/drm/drm_crtc_internal.h b/drivers/gpu/drm/drm_crtc_internal.h
> index c094092296448093c5cd192ecdc8ea9a50769c90..83146ffef00cd2f165b3c4bc84019bfc2edcd3d4 100644
> --- a/drivers/gpu/drm/drm_crtc_internal.h
> +++ b/drivers/gpu/drm/drm_crtc_internal.h
> @@ -42,11 +42,11 @@ enum drm_color_encoding;
>   enum drm_color_range;
>   enum drm_connector_force;
>   enum drm_mode_status;
>   
>   struct cea_sad;
> -struct drm_atomic_state;
> +struct drm_atomic_commit;
>   struct drm_bridge;
>   struct drm_connector;
>   struct drm_crtc;
>   struct drm_device;
>   struct drm_display_mode;
> @@ -246,20 +246,20 @@ void drm_atomic_debugfs_init(struct drm_device *dev);
>   #endif
>   
>   int __drm_atomic_helper_disable_plane(struct drm_plane *plane,
>   				      struct drm_plane_state *plane_state);
>   int __drm_atomic_helper_set_config(struct drm_mode_set *set,
> -				   struct drm_atomic_state *state);
> +				   struct drm_atomic_commit *state);
>   
> -void drm_atomic_print_new_state(const struct drm_atomic_state *state,
> +void drm_atomic_print_new_state(const struct drm_atomic_commit *state,
>   		struct drm_printer *p);
>   
>   /* drm_atomic_uapi.c */
> -int drm_atomic_connector_commit_dpms(struct drm_atomic_state *state,
> +int drm_atomic_connector_commit_dpms(struct drm_atomic_commit *state,
>   				     struct drm_connector *connector,
>   				     int mode);
> -int drm_atomic_set_property(struct drm_atomic_state *state,
> +int drm_atomic_set_property(struct drm_atomic_commit *state,
>   			    struct drm_file *file_priv,
>   			    struct drm_mode_object *obj,
>   			    struct drm_property *prop,
>   			    u64 prop_value, bool async_flip);
>   int drm_atomic_get_property(struct drm_mode_object *obj,
> diff --git a/drivers/gpu/drm/drm_damage_helper.c b/drivers/gpu/drm/drm_damage_helper.c
> index 1b6850aa1688a8859d43e48e8cce5c85abd8e138..74a7f4252ecff14e84d659da05cbca61a54e6ec6 100644
> --- a/drivers/gpu/drm/drm_damage_helper.c
> +++ b/drivers/gpu/drm/drm_damage_helper.c
> @@ -64,11 +64,11 @@ static void convert_clip_rect_to_rect(const struct drm_clip_rect *src,
>    *
>    * Note that &drm_plane_state.fb_damage_clips == NULL in plane state means that
>    * full plane update should happen. It also ensure helper iterator will return
>    * &drm_plane_state.src as damage.
>    */
> -void drm_atomic_helper_check_plane_damage(struct drm_atomic_state *state,
> +void drm_atomic_helper_check_plane_damage(struct drm_atomic_commit *state,
>   					  struct drm_plane_state *plane_state)
>   {
>   	struct drm_crtc_state *crtc_state;
>   
>   	if (plane_state->crtc) {
> @@ -112,22 +112,22 @@ int drm_atomic_helper_dirtyfb(struct drm_framebuffer *fb,
>   			      unsigned int num_clips)
>   {
>   	struct drm_modeset_acquire_ctx ctx;
>   	struct drm_property_blob *damage = NULL;
>   	struct drm_mode_rect *rects = NULL;
> -	struct drm_atomic_state *state;
> +	struct drm_atomic_commit *state;
>   	struct drm_plane *plane;
>   	int ret = 0;
>   
>   	/*
>   	 * When called from ioctl, we are interruptible, but not when called
>   	 * internally (ie. defio worker)
>   	 */
>   	drm_modeset_acquire_init(&ctx,
>   		file_priv ? DRM_MODESET_ACQUIRE_INTERRUPTIBLE : 0);
>   
> -	state = drm_atomic_state_alloc(fb->dev);
> +	state = drm_atomic_commit_alloc(fb->dev);
>   	if (!state) {
>   		ret = -ENOMEM;
>   		goto out_drop_locks;
>   	}
>   	state->acquire_ctx = &ctx;
> @@ -182,19 +182,19 @@ int drm_atomic_helper_dirtyfb(struct drm_framebuffer *fb,
>   
>   	ret = drm_atomic_commit(state);
>   
>   out:
>   	if (ret == -EDEADLK) {
> -		drm_atomic_state_clear(state);
> +		drm_atomic_commit_clear(state);
>   		ret = drm_modeset_backoff(&ctx);
>   		if (!ret)
>   			goto retry;
>   	}
>   
>   	drm_property_blob_put(damage);
>   	kfree(rects);
> -	drm_atomic_state_put(state);
> +	drm_atomic_commit_put(state);
>   
>   out_drop_locks:
>   	drm_modeset_drop_locks(&ctx);
>   	drm_modeset_acquire_fini(&ctx);
>   
> diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
> index c4adad77c8d6cdded07da1b583118a4ccfaa1937..ad17d369da76f74037e14e27cdd7935eb6331518 100644
> --- a/drivers/gpu/drm/drm_fb_helper.c
> +++ b/drivers/gpu/drm/drm_fb_helper.c
> @@ -761,20 +761,20 @@ static int setcmap_atomic(struct fb_cmap *cmap, struct fb_info *info)
>   	struct drm_fb_helper *fb_helper = info->par;
>   	struct drm_device *dev = fb_helper->dev;
>   	struct drm_property_blob *gamma_lut = NULL;
>   	struct drm_modeset_acquire_ctx ctx;
>   	struct drm_crtc_state *crtc_state;
> -	struct drm_atomic_state *state;
> +	struct drm_atomic_commit *state;
>   	struct drm_mode_set *modeset;
>   	struct drm_crtc *crtc;
>   	u16 *r, *g, *b;
>   	bool replaced;
>   	int ret = 0;
>   
>   	drm_modeset_acquire_init(&ctx, 0);
>   
> -	state = drm_atomic_state_alloc(dev);
> +	state = drm_atomic_commit_alloc(dev);
>   	if (!state) {
>   		ret = -ENOMEM;
>   		goto out_ctx;
>   	}
>   
> @@ -829,19 +829,19 @@ static int setcmap_atomic(struct fb_cmap *cmap, struct fb_info *info)
>   out_state:
>   	if (ret == -EDEADLK)
>   		goto backoff;
>   
>   	drm_property_blob_put(gamma_lut);
> -	drm_atomic_state_put(state);
> +	drm_atomic_commit_put(state);
>   out_ctx:
>   	drm_modeset_drop_locks(&ctx);
>   	drm_modeset_acquire_fini(&ctx);
>   
>   	return ret;
>   
>   backoff:
> -	drm_atomic_state_clear(state);
> +	drm_atomic_commit_clear(state);
>   	drm_modeset_backoff(&ctx);
>   	goto retry;
>   }
>   
>   /**
> diff --git a/drivers/gpu/drm/drm_framebuffer.c b/drivers/gpu/drm/drm_framebuffer.c
> index 147ac19f851b23a04b4ece341c8a087b74a0d128..d32aceb6ca9b8fe9adb8b60c7dc0d2e43c568b3e 100644
> --- a/drivers/gpu/drm/drm_framebuffer.c
> +++ b/drivers/gpu/drm/drm_framebuffer.c
> @@ -998,22 +998,22 @@ EXPORT_SYMBOL(drm_framebuffer_cleanup);
>   
>   static int atomic_remove_fb(struct drm_framebuffer *fb)
>   {
>   	struct drm_modeset_acquire_ctx ctx;
>   	struct drm_device *dev = fb->dev;
> -	struct drm_atomic_state *state;
> +	struct drm_atomic_commit *state;
>   	struct drm_plane *plane;
>   	struct drm_connector *conn __maybe_unused;
>   	struct drm_connector_state *conn_state;
>   	int i, ret;
>   	unsigned plane_mask;
>   	bool disable_crtcs = false;
>   
>   retry_disable:
>   	drm_modeset_acquire_init(&ctx, 0);
>   
> -	state = drm_atomic_state_alloc(dev);
> +	state = drm_atomic_commit_alloc(dev);
>   	if (!state) {
>   		ret = -ENOMEM;
>   		goto out;
>   	}
>   	state->acquire_ctx = &ctx;
> @@ -1079,16 +1079,16 @@ static int atomic_remove_fb(struct drm_framebuffer *fb)
>   	if (plane_mask)
>   		ret = drm_atomic_commit(state);
>   
>   unlock:
>   	if (ret == -EDEADLK) {
> -		drm_atomic_state_clear(state);
> +		drm_atomic_commit_clear(state);
>   		drm_modeset_backoff(&ctx);
>   		goto retry;
>   	}
>   
> -	drm_atomic_state_put(state);
> +	drm_atomic_commit_put(state);
>   
>   out:
>   	drm_modeset_drop_locks(&ctx);
>   	drm_modeset_acquire_fini(&ctx);
>   
> diff --git a/drivers/gpu/drm/drm_mode_object.c b/drivers/gpu/drm/drm_mode_object.c
> index 2d943a610b88b733d9ff59020097ad95cd239086..21fc9deda4371fffaf469cc9d0e3e4bf84e14364 100644
> --- a/drivers/gpu/drm/drm_mode_object.c
> +++ b/drivers/gpu/drm/drm_mode_object.c
> @@ -559,15 +559,15 @@ static int set_property_atomic(struct drm_mode_object *obj,
>   			       struct drm_file *file_priv,
>   			       struct drm_property *prop,
>   			       uint64_t prop_value)
>   {
>   	struct drm_device *dev = prop->dev;
> -	struct drm_atomic_state *state;
> +	struct drm_atomic_commit *state;
>   	struct drm_modeset_acquire_ctx ctx;
>   	int ret;
>   
> -	state = drm_atomic_state_alloc(dev);
> +	state = drm_atomic_commit_alloc(dev);
>   	if (!state)
>   		return -ENOMEM;
>   
>   	drm_modeset_acquire_init(&ctx, 0);
>   	state->acquire_ctx = &ctx;
> @@ -588,16 +588,16 @@ static int set_property_atomic(struct drm_mode_object *obj,
>   			goto out;
>   		ret = drm_atomic_commit(state);
>   	}
>   out:
>   	if (ret == -EDEADLK) {
> -		drm_atomic_state_clear(state);
> +		drm_atomic_commit_clear(state);
>   		drm_modeset_backoff(&ctx);
>   		goto retry;
>   	}
>   
> -	drm_atomic_state_put(state);
> +	drm_atomic_commit_put(state);
>   
>   	drm_modeset_drop_locks(&ctx);
>   	drm_modeset_acquire_fini(&ctx);
>   
>   	return ret;
> diff --git a/drivers/gpu/drm/drm_modeset_helper.c b/drivers/gpu/drm/drm_modeset_helper.c
> index a57f6a10ada41c1defbb961d03594bdacb1a4686..35f7ef5b6140cacb045e509a6710d0bf9d14ad9b 100644
> --- a/drivers/gpu/drm/drm_modeset_helper.c
> +++ b/drivers/gpu/drm/drm_modeset_helper.c
> @@ -191,11 +191,11 @@ EXPORT_SYMBOL(drm_crtc_init);
>    * See also:
>    * drm_kms_helper_poll_disable() and drm_client_dev_suspend().
>    */
>   int drm_mode_config_helper_suspend(struct drm_device *dev)
>   {
> -	struct drm_atomic_state *state;
> +	struct drm_atomic_commit *state;
>   
>   	if (!dev)
>   		return 0;
>   	/*
>   	 * Don't disable polling if it was never initialized
> diff --git a/drivers/gpu/drm/drm_self_refresh_helper.c b/drivers/gpu/drm/drm_self_refresh_helper.c
> index c08e7f590ca55edb8a34efe8858ece1b559dace8..37ec7fb00f034a450fbc0755e1c474f0251e1d29 100644
> --- a/drivers/gpu/drm/drm_self_refresh_helper.c
> +++ b/drivers/gpu/drm/drm_self_refresh_helper.c
> @@ -71,19 +71,19 @@ static void drm_self_refresh_helper_entry_work(struct work_struct *work)
>   				to_delayed_work(work),
>   				struct drm_self_refresh_data, entry_work);
>   	struct drm_crtc *crtc = sr_data->crtc;
>   	struct drm_device *dev = crtc->dev;
>   	struct drm_modeset_acquire_ctx ctx;
> -	struct drm_atomic_state *state;
> +	struct drm_atomic_commit *state;
>   	struct drm_connector *conn;
>   	struct drm_connector_state *conn_state;
>   	struct drm_crtc_state *crtc_state;
>   	int i, ret = 0;
>   
>   	drm_modeset_acquire_init(&ctx, 0);
>   
> -	state = drm_atomic_state_alloc(dev);
> +	state = drm_atomic_commit_alloc(dev);
>   	if (!state) {
>   		ret = -ENOMEM;
>   		goto out_drop_locks;
>   	}
>   
> @@ -115,17 +115,17 @@ static void drm_self_refresh_helper_entry_work(struct work_struct *work)
>   	if (ret)
>   		goto out;
>   
>   out:
>   	if (ret == -EDEADLK) {
> -		drm_atomic_state_clear(state);
> +		drm_atomic_commit_clear(state);
>   		ret = drm_modeset_backoff(&ctx);
>   		if (!ret)
>   			goto retry;
>   	}
>   
> -	drm_atomic_state_put(state);
> +	drm_atomic_commit_put(state);
>   
>   out_drop_locks:
>   	drm_modeset_drop_locks(&ctx);
>   	drm_modeset_acquire_fini(&ctx);
>   }
> @@ -141,11 +141,11 @@ static void drm_self_refresh_helper_entry_work(struct work_struct *work)
>    * update the average entry/exit self refresh times on self refresh transitions.
>    * These averages will be used when calculating how long to delay before
>    * entering self refresh mode after activity.
>    */
>   void
> -drm_self_refresh_helper_update_avg_times(struct drm_atomic_state *state,
> +drm_self_refresh_helper_update_avg_times(struct drm_atomic_commit *state,
>   					 unsigned int commit_time_ms,
>   					 unsigned int new_self_refresh_mask)
>   {
>   	struct drm_crtc *crtc;
>   	struct drm_crtc_state *old_crtc_state;
> @@ -183,11 +183,11 @@ EXPORT_SYMBOL(drm_self_refresh_helper_update_avg_times);
>    * userspace, this is required.
>    *
>    * At the end, we queue up the self refresh entry work so we can enter PSR after
>    * the desired delay.
>    */
> -void drm_self_refresh_helper_alter_state(struct drm_atomic_state *state)
> +void drm_self_refresh_helper_alter_state(struct drm_atomic_commit *state)
>   {
>   	struct drm_crtc *crtc;
>   	struct drm_crtc_state *crtc_state;
>   	int i;
>   
> diff --git a/drivers/gpu/drm/drm_simple_kms_helper.c b/drivers/gpu/drm/drm_simple_kms_helper.c
> index fcbcaaa36b5f632f6e10a23013c338c32d0be902..26671f2b5a94357394ca987ead8b8a3d8be8a5a8 100644
> --- a/drivers/gpu/drm/drm_simple_kms_helper.c
> +++ b/drivers/gpu/drm/drm_simple_kms_helper.c
> @@ -96,11 +96,11 @@ drm_simple_kms_crtc_mode_valid(struct drm_crtc *crtc,
>   
>   	return pipe->funcs->mode_valid(pipe, mode);
>   }
>   
>   static int drm_simple_kms_crtc_check(struct drm_crtc *crtc,
> -				     struct drm_atomic_state *state)
> +				     struct drm_atomic_commit *state)
>   {
>   	struct drm_crtc_state *crtc_state = drm_atomic_get_new_crtc_state(state, crtc);
>   	int ret;
>   
>   	if (!crtc_state->enable)
> @@ -113,11 +113,11 @@ static int drm_simple_kms_crtc_check(struct drm_crtc *crtc,
>   out:
>   	return drm_atomic_add_affected_planes(state, crtc);
>   }
>   
>   static void drm_simple_kms_crtc_enable(struct drm_crtc *crtc,
> -				       struct drm_atomic_state *state)
> +				       struct drm_atomic_commit *state)
>   {
>   	struct drm_plane *plane;
>   	struct drm_simple_display_pipe *pipe;
>   
>   	pipe = container_of(crtc, struct drm_simple_display_pipe, crtc);
> @@ -127,11 +127,11 @@ static void drm_simple_kms_crtc_enable(struct drm_crtc *crtc,
>   	plane = &pipe->plane;
>   	pipe->funcs->enable(pipe, crtc->state, plane->state);
>   }
>   
>   static void drm_simple_kms_crtc_disable(struct drm_crtc *crtc,
> -					struct drm_atomic_state *state)
> +					struct drm_atomic_commit *state)
>   {
>   	struct drm_simple_display_pipe *pipe;
>   
>   	pipe = container_of(crtc, struct drm_simple_display_pipe, crtc);
>   	if (!pipe->funcs || !pipe->funcs->disable)
> @@ -212,11 +212,11 @@ static const struct drm_crtc_funcs drm_simple_kms_crtc_funcs = {
>   	.enable_vblank = drm_simple_kms_crtc_enable_vblank,
>   	.disable_vblank = drm_simple_kms_crtc_disable_vblank,
>   };
>   
>   static int drm_simple_kms_plane_atomic_check(struct drm_plane *plane,
> -					struct drm_atomic_state *state)
> +					struct drm_atomic_commit *state)
>   {
>   	struct drm_plane_state *plane_state = drm_atomic_get_new_plane_state(state,
>   									     plane);
>   	struct drm_simple_display_pipe *pipe;
>   	struct drm_crtc_state *crtc_state;
> @@ -241,11 +241,11 @@ static int drm_simple_kms_plane_atomic_check(struct drm_plane *plane,
>   
>   	return pipe->funcs->check(pipe, plane_state, crtc_state);
>   }
>   
>   static void drm_simple_kms_plane_atomic_update(struct drm_plane *plane,
> -					struct drm_atomic_state *state)
> +					struct drm_atomic_commit *state)
>   {
>   	struct drm_plane_state *old_pstate = drm_atomic_get_old_plane_state(state,
>   									    plane);
>   	struct drm_simple_display_pipe *pipe;
>   
> diff --git a/drivers/gpu/drm/drm_vblank_helper.c b/drivers/gpu/drm/drm_vblank_helper.c
> index a04a6ba1b0ca055d1186f496b3dcd16e68c47287..d3f8147ecdc126e02010da2b9a7435e0a8708ba1 100644
> --- a/drivers/gpu/drm/drm_vblank_helper.c
> +++ b/drivers/gpu/drm/drm_vblank_helper.c
> @@ -47,11 +47,11 @@
>    * VBLANK event.
>    *
>    * See also struct &drm_crtc_helper_funcs.atomic_flush.
>    */
>   void drm_crtc_vblank_atomic_flush(struct drm_crtc *crtc,
> -				  struct drm_atomic_state *state)
> +				  struct drm_atomic_commit *state)
>   {
>   	struct drm_device *dev = crtc->dev;
>   	struct drm_crtc_state *crtc_state = drm_atomic_get_new_crtc_state(state, crtc);
>   	struct drm_pending_vblank_event *event;
>   
> @@ -80,11 +80,11 @@ EXPORT_SYMBOL(drm_crtc_vblank_atomic_flush);
>    * of struct drm_crtc_helper_funcs for CRTCs the only need to enable VBLANKs.
>    *
>    * See also struct &drm_crtc_helper_funcs.atomic_enable.
>    */
>   void drm_crtc_vblank_atomic_enable(struct drm_crtc *crtc,
> -				   struct drm_atomic_state *state)
> +				   struct drm_atomic_commit *state)
>   {
>   	drm_crtc_vblank_on(crtc);
>   }
>   EXPORT_SYMBOL(drm_crtc_vblank_atomic_enable);
>   
> @@ -97,11 +97,11 @@ EXPORT_SYMBOL(drm_crtc_vblank_atomic_enable);
>    * of struct drm_crtc_helper_funcs for CRTCs the only need to disable VBLANKs.
>    *
>    * See also struct &drm_crtc_funcs.atomic_disable.
>    */
>   void drm_crtc_vblank_atomic_disable(struct drm_crtc *crtc,
> -				    struct drm_atomic_state *state)
> +				    struct drm_atomic_commit *state)
>   {
>   	drm_crtc_vblank_off(crtc);
>   }
>   EXPORT_SYMBOL(drm_crtc_vblank_atomic_disable);
>   
> diff --git a/drivers/gpu/drm/exynos/exynos_drm_crtc.c b/drivers/gpu/drm/exynos/exynos_drm_crtc.c
> index 41252caccd674b4bde9020bc34ecf3023749713f..b071c019670de8e40a44d04636c77de1d0eb43cf 100644
> --- a/drivers/gpu/drm/exynos/exynos_drm_crtc.c
> +++ b/drivers/gpu/drm/exynos/exynos_drm_crtc.c
> @@ -17,22 +17,22 @@
>   #include "exynos_drm_crtc.h"
>   #include "exynos_drm_drv.h"
>   #include "exynos_drm_plane.h"
>   
>   static void exynos_drm_crtc_atomic_enable(struct drm_crtc *crtc,
> -					  struct drm_atomic_state *state)
> +					  struct drm_atomic_commit *state)
>   {
>   	struct exynos_drm_crtc *exynos_crtc = to_exynos_crtc(crtc);
>   
>   	if (exynos_crtc->ops->atomic_enable)
>   		exynos_crtc->ops->atomic_enable(exynos_crtc);
>   
>   	drm_crtc_vblank_on(crtc);
>   }
>   
>   static void exynos_drm_crtc_atomic_disable(struct drm_crtc *crtc,
> -					   struct drm_atomic_state *state)
> +					   struct drm_atomic_commit *state)
>   {
>   	struct exynos_drm_crtc *exynos_crtc = to_exynos_crtc(crtc);
>   
>   	drm_crtc_vblank_off(crtc);
>   
> @@ -46,11 +46,11 @@ static void exynos_drm_crtc_atomic_disable(struct drm_crtc *crtc,
>   	}
>   	spin_unlock_irq(&crtc->dev->event_lock);
>   }
>   
>   static int exynos_crtc_atomic_check(struct drm_crtc *crtc,
> -				     struct drm_atomic_state *state)
> +				     struct drm_atomic_commit *state)
>   {
>   	struct drm_crtc_state *crtc_state = drm_atomic_get_new_crtc_state(state,
>   									  crtc);
>   	struct exynos_drm_crtc *exynos_crtc = to_exynos_crtc(crtc);
>   
> @@ -62,20 +62,20 @@ static int exynos_crtc_atomic_check(struct drm_crtc *crtc,
>   
>   	return 0;
>   }
>   
>   static void exynos_crtc_atomic_begin(struct drm_crtc *crtc,
> -				     struct drm_atomic_state *state)
> +				     struct drm_atomic_commit *state)
>   {
>   	struct exynos_drm_crtc *exynos_crtc = to_exynos_crtc(crtc);
>   
>   	if (exynos_crtc->ops->atomic_begin)
>   		exynos_crtc->ops->atomic_begin(exynos_crtc);
>   }
>   
>   static void exynos_crtc_atomic_flush(struct drm_crtc *crtc,
> -				     struct drm_atomic_state *state)
> +				     struct drm_atomic_commit *state)
>   {
>   	struct exynos_drm_crtc *exynos_crtc = to_exynos_crtc(crtc);
>   
>   	if (exynos_crtc->ops->atomic_flush)
>   		exynos_crtc->ops->atomic_flush(exynos_crtc);
> diff --git a/drivers/gpu/drm/exynos/exynos_drm_plane.c b/drivers/gpu/drm/exynos/exynos_drm_plane.c
> index da043bd357a4fa6a35c3be4fd9f1fc82fa2b2bf5..5c04ef87e4007e7ca64c816ca6dedaa753ef5c5e 100644
> --- a/drivers/gpu/drm/exynos/exynos_drm_plane.c
> +++ b/drivers/gpu/drm/exynos/exynos_drm_plane.c
> @@ -228,11 +228,11 @@ exynos_drm_plane_check_size(const struct exynos_drm_plane_config *config,
>   	DRM_DEV_DEBUG_KMS(crtc->dev->dev, "scaling mode is not supported");
>   	return -ENOTSUPP;
>   }
>   
>   static int exynos_plane_atomic_check(struct drm_plane *plane,
> -				     struct drm_atomic_state *state)
> +				     struct drm_atomic_commit *state)
>   {
>   	struct drm_plane_state *new_plane_state = drm_atomic_get_new_plane_state(state,
>   										 plane);
>   	struct exynos_drm_plane *exynos_plane = to_exynos_plane(plane);
>   	struct exynos_drm_plane_state *exynos_state =
> @@ -252,11 +252,11 @@ static int exynos_plane_atomic_check(struct drm_plane *plane,
>   	ret = exynos_drm_plane_check_size(exynos_plane->config, exynos_state);
>   	return ret;
>   }
>   
>   static void exynos_plane_atomic_update(struct drm_plane *plane,
> -				       struct drm_atomic_state *state)
> +				       struct drm_atomic_commit *state)
>   {
>   	struct drm_plane_state *new_state = drm_atomic_get_new_plane_state(state,
>   								           plane);
>   	struct exynos_drm_crtc *exynos_crtc = to_exynos_crtc(new_state->crtc);
>   	struct exynos_drm_plane *exynos_plane = to_exynos_plane(plane);
> @@ -267,11 +267,11 @@ static void exynos_plane_atomic_update(struct drm_plane *plane,
>   	if (exynos_crtc->ops->update_plane)
>   		exynos_crtc->ops->update_plane(exynos_crtc, exynos_plane);
>   }
>   
>   static void exynos_plane_atomic_disable(struct drm_plane *plane,
> -					struct drm_atomic_state *state)
> +					struct drm_atomic_commit *state)
>   {
>   	struct drm_plane_state *old_state = drm_atomic_get_old_plane_state(state, plane);
>   	struct exynos_drm_plane *exynos_plane = to_exynos_plane(plane);
>   	struct exynos_drm_crtc *exynos_crtc = to_exynos_crtc(old_state->crtc);
>   
> diff --git a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_crtc.c b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_crtc.c
> index 2af60d98f48f99b6eae235d3d117f9b8523166f3..9ef16f5eb613e5c3b735db858e54e7096c6312e7 100644
> --- a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_crtc.c
> +++ b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_crtc.c
> @@ -19,11 +19,11 @@
>   #include "fsl_dcu_drm_crtc.h"
>   #include "fsl_dcu_drm_drv.h"
>   #include "fsl_dcu_drm_plane.h"
>   
>   static void fsl_dcu_drm_crtc_atomic_flush(struct drm_crtc *crtc,
> -					  struct drm_atomic_state *state)
> +					  struct drm_atomic_commit *state)
>   {
>   	struct drm_device *dev = crtc->dev;
>   	struct fsl_dcu_drm_device *fsl_dev = dev->dev_private;
>   	struct drm_pending_vblank_event *event = crtc->state->event;
>   
> @@ -41,11 +41,11 @@ static void fsl_dcu_drm_crtc_atomic_flush(struct drm_crtc *crtc,
>   		spin_unlock_irq(&crtc->dev->event_lock);
>   	}
>   }
>   
>   static void fsl_dcu_drm_crtc_atomic_disable(struct drm_crtc *crtc,
> -					struct drm_atomic_state *state)
> +					struct drm_atomic_commit *state)
>   {
>   	struct drm_crtc_state *old_crtc_state = drm_atomic_get_old_crtc_state(state,
>   									      crtc);
>   	struct drm_device *dev = crtc->dev;
>   	struct fsl_dcu_drm_device *fsl_dev = dev->dev_private;
> @@ -62,11 +62,11 @@ static void fsl_dcu_drm_crtc_atomic_disable(struct drm_crtc *crtc,
>   		     DCU_UPDATE_MODE_READREG);
>   	clk_disable_unprepare(fsl_dev->pix_clk);
>   }
>   
>   static void fsl_dcu_drm_crtc_atomic_enable(struct drm_crtc *crtc,
> -					   struct drm_atomic_state *state)
> +					   struct drm_atomic_commit *state)
>   {
>   	struct drm_device *dev = crtc->dev;
>   	struct fsl_dcu_drm_device *fsl_dev = dev->dev_private;
>   
>   	clk_prepare_enable(fsl_dev->pix_clk);
> diff --git a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_plane.c b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_plane.c
> index a9b3467263d625a25968fcb06878c35c98c1c734..b34f880c1e098a409cde2ebb82415a98dc3d0373 100644
> --- a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_plane.c
> +++ b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_plane.c
> @@ -34,11 +34,11 @@ static int fsl_dcu_drm_plane_index(struct drm_plane *plane)
>   	dev_err(fsl_dev->dev, "No more layer left\n");
>   	return -EINVAL;
>   }
>   
>   static int fsl_dcu_drm_plane_atomic_check(struct drm_plane *plane,
> -					  struct drm_atomic_state *state)
> +					  struct drm_atomic_commit *state)
>   {
>   	struct drm_plane_state *new_plane_state = drm_atomic_get_new_plane_state(state,
>   										 plane);
>   	struct drm_framebuffer *fb = new_plane_state->fb;
>   
> @@ -60,11 +60,11 @@ static int fsl_dcu_drm_plane_atomic_check(struct drm_plane *plane,
>   		return -EINVAL;
>   	}
>   }
>   
>   static void fsl_dcu_drm_plane_atomic_disable(struct drm_plane *plane,
> -					     struct drm_atomic_state *state)
> +					     struct drm_atomic_commit *state)
>   {
>   	struct fsl_dcu_drm_device *fsl_dev = plane->dev->dev_private;
>   	unsigned int value;
>   	int index;
>   
> @@ -76,11 +76,11 @@ static void fsl_dcu_drm_plane_atomic_disable(struct drm_plane *plane,
>   	value &= ~DCU_LAYER_EN;
>   	regmap_write(fsl_dev->regmap, DCU_CTRLDESCLN(index, 4), value);
>   }
>   
>   static void fsl_dcu_drm_plane_atomic_update(struct drm_plane *plane,
> -					    struct drm_atomic_state *state)
> +					    struct drm_atomic_commit *state)
>   
>   {
>   	struct fsl_dcu_drm_device *fsl_dev = plane->dev->dev_private;
>   	struct drm_plane_state *new_state = drm_atomic_get_new_plane_state(state,
>   									   plane);
> diff --git a/drivers/gpu/drm/gud/gud_connector.c b/drivers/gpu/drm/gud/gud_connector.c
> index a91a7e96cb886a62c3b470c66f995be835c5bd18..ea0cca58b7c8925b9f4680da106b0fa310ef3b83 100644
> --- a/drivers/gpu/drm/gud/gud_connector.c
> +++ b/drivers/gpu/drm/gud/gud_connector.c
> @@ -60,17 +60,17 @@ static void gud_connector_backlight_update_status_work(struct work_struct *work)
>   	struct gud_connector *gconn = container_of(work, struct gud_connector, backlight_work);
>   	struct drm_connector *connector = &gconn->connector;
>   	struct drm_connector_state *connector_state;
>   	struct drm_device *drm = connector->dev;
>   	struct drm_modeset_acquire_ctx ctx;
> -	struct drm_atomic_state *state;
> +	struct drm_atomic_commit *state;
>   	int idx, ret;
>   
>   	if (!drm_dev_enter(drm, &idx))
>   		return;
>   
> -	state = drm_atomic_state_alloc(drm);
> +	state = drm_atomic_commit_alloc(drm);
>   	if (!state) {
>   		ret = -ENOMEM;
>   		goto exit;
>   	}
>   
> @@ -87,16 +87,16 @@ static void gud_connector_backlight_update_status_work(struct work_struct *work)
>   	connector_state->tv.brightness = gconn->backlight->props.brightness;
>   
>   	ret = drm_atomic_commit(state);
>   out:
>   	if (ret == -EDEADLK) {
> -		drm_atomic_state_clear(state);
> +		drm_atomic_commit_clear(state);
>   		drm_modeset_backoff(&ctx);
>   		goto retry;
>   	}
>   
> -	drm_atomic_state_put(state);
> +	drm_atomic_commit_put(state);
>   
>   	drm_modeset_drop_locks(&ctx);
>   	drm_modeset_acquire_fini(&ctx);
>   exit:
>   	drm_dev_exit(idx);
> @@ -283,11 +283,11 @@ static int gud_connector_get_modes(struct drm_connector *connector)
>   
>   	return num_modes;
>   }
>   
>   static int gud_connector_atomic_check(struct drm_connector *connector,
> -				      struct drm_atomic_state *state)
> +				      struct drm_atomic_commit *state)
>   {
>   	struct drm_connector_state *new_state;
>   	struct drm_crtc_state *new_crtc_state;
>   	struct drm_connector_state *old_state;
>   
> diff --git a/drivers/gpu/drm/gud/gud_internal.h b/drivers/gpu/drm/gud/gud_internal.h
> index 8eec8335f5f9034aa5c1b6e7735def311e86b07e..95744b0b6c727c6f7bf4952635afa5772970c6c0 100644
> --- a/drivers/gpu/drm/gud/gud_internal.h
> +++ b/drivers/gpu/drm/gud/gud_internal.h
> @@ -61,17 +61,17 @@ int gud_usb_get_u8(struct gud_device *gdrm, u8 request, u16 index, u8 *val);
>   int gud_usb_set_u8(struct gud_device *gdrm, u8 request, u8 val);
>   
>   void gud_clear_damage(struct gud_device *gdrm);
>   void gud_flush_work(struct work_struct *work);
>   void gud_crtc_atomic_enable(struct drm_crtc *crtc,
> -			    struct drm_atomic_state *state);
> +			    struct drm_atomic_commit *state);
>   void gud_crtc_atomic_disable(struct drm_crtc *crtc,
> -			     struct drm_atomic_state *state);
> +			     struct drm_atomic_commit *state);
>   int gud_plane_atomic_check(struct drm_plane *plane,
> -			   struct drm_atomic_state *state);
> +			   struct drm_atomic_commit *state);
>   void gud_plane_atomic_update(struct drm_plane *plane,
> -			     struct drm_atomic_state *atomic_state);
> +			     struct drm_atomic_commit *atomic_state);
>   int gud_connector_fill_properties(struct drm_connector_state *connector_state,
>   				  struct gud_property_req *properties);
>   int gud_get_connectors(struct gud_device *gdrm);
>   
>   /* Driver internal fourcc transfer formats */
> diff --git a/drivers/gpu/drm/gud/gud_pipe.c b/drivers/gpu/drm/gud/gud_pipe.c
> index 495804e1d20059168251691df72d0ca936926167..5ef887d8485a3d63e6ca8746818fba78b90a8db3 100644
> --- a/drivers/gpu/drm/gud/gud_pipe.c
> +++ b/drivers/gpu/drm/gud/gud_pipe.c
> @@ -449,11 +449,11 @@ static void gud_fb_handle_damage(struct gud_device *gdrm, struct drm_framebuffer
>   	/* Imported buffers are assumed to be WriteCombined with uncached reads */
>   	gud_flush_damage(gdrm, fb, src, !drm_gem_is_imported(fb->obj[0]), damage);
>   }
>   
>   int gud_plane_atomic_check(struct drm_plane *plane,
> -			   struct drm_atomic_state *state)
> +			   struct drm_atomic_commit *state)
>   {
>   	struct gud_device *gdrm = to_gud_device(plane->dev);
>   	struct drm_plane_state *old_plane_state = drm_atomic_get_old_plane_state(state, plane);
>   	struct drm_plane_state *new_plane_state = drm_atomic_get_new_plane_state(state, plane);
>   	struct drm_crtc *crtc = new_plane_state->crtc;
> @@ -579,11 +579,11 @@ int gud_plane_atomic_check(struct drm_plane *plane,
>   
>   	return ret;
>   }
>   
>   void gud_crtc_atomic_enable(struct drm_crtc *crtc,
> -			    struct drm_atomic_state *state)
> +			    struct drm_atomic_commit *state)
>   {
>   	struct drm_device *drm = crtc->dev;
>   	struct gud_device *gdrm = to_gud_device(drm);
>   	int idx;
>   
> @@ -596,11 +596,11 @@ void gud_crtc_atomic_enable(struct drm_crtc *crtc,
>   
>   	drm_dev_exit(idx);
>   }
>   
>   void gud_crtc_atomic_disable(struct drm_crtc *crtc,
> -			     struct drm_atomic_state *state)
> +			     struct drm_atomic_commit *state)
>   {
>   	struct drm_device *drm = crtc->dev;
>   	struct gud_device *gdrm = to_gud_device(drm);
>   	int idx;
>   
> @@ -612,11 +612,11 @@ void gud_crtc_atomic_disable(struct drm_crtc *crtc,
>   
>   	drm_dev_exit(idx);
>   }
>   
>   void gud_plane_atomic_update(struct drm_plane *plane,
> -			     struct drm_atomic_state *atomic_state)
> +			     struct drm_atomic_commit *atomic_state)
>   {
>   	struct drm_device *drm = plane->dev;
>   	struct gud_device *gdrm = to_gud_device(drm);
>   	struct drm_plane_state *old_state = drm_atomic_get_old_plane_state(atomic_state, plane);
>   	struct drm_plane_state *new_state = drm_atomic_get_new_plane_state(atomic_state, plane);
> diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c
> index 89bed78f14666aa741824d213877d503bbeb91da..e276b8ca213c094da42cb6d379471370cb606c10 100644
> --- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c
> +++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c
> @@ -51,11 +51,11 @@ static const struct hibmc_dislay_pll_config hibmc_pll_table[] = {
>   	{1920, 1080, CRT_PLL1_HS_148MHZ, CRT_PLL2_HS_148MHZ},
>   	{1920, 1200, CRT_PLL1_HS_193MHZ, CRT_PLL2_HS_193MHZ},
>   };
>   
>   static int hibmc_plane_atomic_check(struct drm_plane *plane,
> -				    struct drm_atomic_state *state)
> +				    struct drm_atomic_commit *state)
>   {
>   	struct drm_plane_state *new_plane_state = drm_atomic_get_new_plane_state(state,
>   										 plane);
>   	struct drm_framebuffer *fb = new_plane_state->fb;
>   	struct drm_crtc *crtc = new_plane_state->crtc;
> @@ -97,11 +97,11 @@ static int hibmc_plane_atomic_check(struct drm_plane *plane,
>   	}
>   	return 0;
>   }
>   
>   static void hibmc_plane_atomic_update(struct drm_plane *plane,
> -				      struct drm_atomic_state *state)
> +				      struct drm_atomic_commit *state)
>   {
>   	struct drm_plane_state *new_state = drm_atomic_get_new_plane_state(state,
>   									   plane);
>   	u32 reg;
>   	s64 gpu_addr = 0;
> @@ -170,11 +170,11 @@ static void hibmc_crtc_dpms(struct drm_crtc *crtc, u32 dpms)
>   		reg |= HIBMC_CRT_DISP_CTL_TIMING(1);
>   	writel(reg, priv->mmio + HIBMC_CRT_DISP_CTL);
>   }
>   
>   static void hibmc_crtc_atomic_enable(struct drm_crtc *crtc,
> -				     struct drm_atomic_state *state)
> +				     struct drm_atomic_commit *state)
>   {
>   	u32 reg;
>   	struct hibmc_drm_private *priv = to_hibmc_drm_private(crtc->dev);
>   
>   	hibmc_set_power_mode(priv, HIBMC_PW_MODE_CTL_MODE_MODE0);
> @@ -189,11 +189,11 @@ static void hibmc_crtc_atomic_enable(struct drm_crtc *crtc,
>   	drm_crtc_vblank_on(crtc);
>   	hibmc_crtc_dpms(crtc, HIBMC_CRT_DPMS_ON);
>   }
>   
>   static void hibmc_crtc_atomic_disable(struct drm_crtc *crtc,
> -				      struct drm_atomic_state *state)
> +				      struct drm_atomic_commit *state)
>   {
>   	u32 reg;
>   	struct hibmc_drm_private *priv = to_hibmc_drm_private(crtc->dev);
>   
>   	hibmc_crtc_dpms(crtc, HIBMC_CRT_DPMS_OFF);
> @@ -390,11 +390,11 @@ static void hibmc_crtc_mode_set_nofb(struct drm_crtc *crtc)
>   
>   	display_ctrl_adjust(dev, mode, val);
>   }
>   
>   static void hibmc_crtc_atomic_begin(struct drm_crtc *crtc,
> -				    struct drm_atomic_state *state)
> +				    struct drm_atomic_commit *state)
>   {
>   	u32 reg;
>   	struct drm_device *dev = crtc->dev;
>   	struct hibmc_drm_private *priv = to_hibmc_drm_private(dev);
>   
> @@ -410,11 +410,11 @@ static void hibmc_crtc_atomic_begin(struct drm_crtc *crtc,
>   
>   	/* We can add more initialization as needed. */
>   }
>   
>   static void hibmc_crtc_atomic_flush(struct drm_crtc *crtc,
> -				    struct drm_atomic_state *state)
> +				    struct drm_atomic_commit *state)
>   
>   {
>   	unsigned long flags;
>   
>   	spin_lock_irqsave(&crtc->dev->event_lock, flags);
> diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c
> index 616821e3c933bcd9ac5dbe42c950ac542df86485..2da04ac89d4d402f241e437da65642ad432026f2 100644
> --- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c
> +++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c
> @@ -146,11 +146,11 @@ static inline int hibmc_dp_prepare(struct hibmc_dp *dp, struct drm_display_mode
>   
>   	return ret;
>   }
>   
>   static void hibmc_dp_encoder_enable(struct drm_encoder *drm_encoder,
> -				    struct drm_atomic_state *state)
> +				    struct drm_atomic_commit *state)
>   {
>   	struct hibmc_dp *dp = container_of(drm_encoder, struct hibmc_dp, encoder);
>   	struct drm_display_mode *mode = &drm_encoder->crtc->state->mode;
>   
>   	if (hibmc_dp_prepare(dp, mode))
> @@ -158,11 +158,11 @@ static void hibmc_dp_encoder_enable(struct drm_encoder *drm_encoder,
>   
>   	hibmc_dp_display_en(dp, true);
>   }
>   
>   static void hibmc_dp_encoder_disable(struct drm_encoder *drm_encoder,
> -				     struct drm_atomic_state *state)
> +				     struct drm_atomic_commit *state)
>   {
>   	struct hibmc_dp *dp = container_of(drm_encoder, struct hibmc_dp, encoder);
>   
>   	hibmc_dp_display_en(dp, false);
>   }
> diff --git a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
> index 76384b4581bf36039c303fc4065629a571bc79e2..902c5dace4ff5698d66f8fc48358c39b39b620e9 100644
> --- a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
> +++ b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
> @@ -436,11 +436,11 @@ static void ade_dump_regs(void __iomem *base)
>   #else
>   static void ade_dump_regs(void __iomem *base) { }
>   #endif
>   
>   static void ade_crtc_atomic_enable(struct drm_crtc *crtc,
> -				   struct drm_atomic_state *state)
> +				   struct drm_atomic_commit *state)
>   {
>   	struct kirin_crtc *kcrtc = to_kirin_crtc(crtc);
>   	struct ade_hw_ctx *ctx = kcrtc->hw_ctx;
>   	int ret;
>   
> @@ -459,11 +459,11 @@ static void ade_crtc_atomic_enable(struct drm_crtc *crtc,
>   	drm_crtc_vblank_on(crtc);
>   	kcrtc->enable = true;
>   }
>   
>   static void ade_crtc_atomic_disable(struct drm_crtc *crtc,
> -				    struct drm_atomic_state *state)
> +				    struct drm_atomic_commit *state)
>   {
>   	struct kirin_crtc *kcrtc = to_kirin_crtc(crtc);
>   	struct ade_hw_ctx *ctx = kcrtc->hw_ctx;
>   
>   	if (!kcrtc->enable)
> @@ -485,11 +485,11 @@ static void ade_crtc_mode_set_nofb(struct drm_crtc *crtc)
>   		(void)ade_power_up(ctx);
>   	ade_ldi_set_mode(ctx, mode, adj_mode);
>   }
>   
>   static void ade_crtc_atomic_begin(struct drm_crtc *crtc,
> -				  struct drm_atomic_state *state)
> +				  struct drm_atomic_commit *state)
>   {
>   	struct kirin_crtc *kcrtc = to_kirin_crtc(crtc);
>   	struct ade_hw_ctx *ctx = kcrtc->hw_ctx;
>   	struct drm_display_mode *mode = &crtc->state->mode;
>   	struct drm_display_mode *adj_mode = &crtc->state->adjusted_mode;
> @@ -498,11 +498,11 @@ static void ade_crtc_atomic_begin(struct drm_crtc *crtc,
>   		(void)ade_power_up(ctx);
>   	ade_ldi_set_mode(ctx, mode, adj_mode);
>   }
>   
>   static void ade_crtc_atomic_flush(struct drm_crtc *crtc,
> -				  struct drm_atomic_state *state)
> +				  struct drm_atomic_commit *state)
>   
>   {
>   	struct kirin_crtc *kcrtc = to_kirin_crtc(crtc);
>   	struct ade_hw_ctx *ctx = kcrtc->hw_ctx;
>   	struct drm_pending_vblank_event *event = crtc->state->event;
> @@ -757,11 +757,11 @@ static void ade_disable_channel(struct kirin_plane *kplane)
>   	/* disable compositor routing */
>   	ade_compositor_routing_disable(base, ch);
>   }
>   
>   static int ade_plane_atomic_check(struct drm_plane *plane,
> -				  struct drm_atomic_state *state)
> +				  struct drm_atomic_commit *state)
>   {
>   	struct drm_plane_state *new_plane_state = drm_atomic_get_new_plane_state(state,
>   										 plane);
>   	struct drm_framebuffer *fb = new_plane_state->fb;
>   	struct drm_crtc *crtc = new_plane_state->crtc;
> @@ -804,11 +804,11 @@ static int ade_plane_atomic_check(struct drm_plane *plane,
>   
>   	return 0;
>   }
>   
>   static void ade_plane_atomic_update(struct drm_plane *plane,
> -				    struct drm_atomic_state *state)
> +				    struct drm_atomic_commit *state)
>   {
>   	struct drm_plane_state *new_state = drm_atomic_get_new_plane_state(state,
>   									   plane);
>   	struct kirin_plane *kplane = to_kirin_plane(plane);
>   
> @@ -818,11 +818,11 @@ static void ade_plane_atomic_update(struct drm_plane *plane,
>   			   new_state->src_x >> 16, new_state->src_y >> 16,
>   			   new_state->src_w >> 16, new_state->src_h >> 16);
>   }
>   
>   static void ade_plane_atomic_disable(struct drm_plane *plane,
> -				     struct drm_atomic_state *state)
> +				     struct drm_atomic_commit *state)
>   {
>   	struct kirin_plane *kplane = to_kirin_plane(plane);
>   
>   	ade_disable_channel(kplane);
>   }
> diff --git a/drivers/gpu/drm/hyperv/hyperv_drm_modeset.c b/drivers/gpu/drm/hyperv/hyperv_drm_modeset.c
> index 7978f8c8108c237290bc1d878c4ed0fef046a7ee..1bbb7de5ab49a378f7fec75f36402b1e5e659d74 100644
> --- a/drivers/gpu/drm/hyperv/hyperv_drm_modeset.c
> +++ b/drivers/gpu/drm/hyperv/hyperv_drm_modeset.c
> @@ -100,11 +100,11 @@ static const uint64_t hyperv_modifiers[] = {
>   	DRM_FORMAT_MOD_LINEAR,
>   	DRM_FORMAT_MOD_INVALID
>   };
>   
>   static void hyperv_crtc_helper_atomic_enable(struct drm_crtc *crtc,
> -					     struct drm_atomic_state *state)
> +					     struct drm_atomic_commit *state)
>   {
>   	struct hyperv_drm_device *hv = to_hv(crtc->dev);
>   	struct drm_plane *plane = &hv->plane;
>   	struct drm_plane_state *plane_state = plane->state;
>   	struct drm_crtc_state *crtc_state = crtc->state;
> @@ -134,11 +134,11 @@ static const struct drm_crtc_funcs hyperv_crtc_funcs = {
>   	.atomic_destroy_state = drm_atomic_helper_crtc_destroy_state,
>   	DRM_CRTC_VBLANK_TIMER_FUNCS,
>   };
>   
>   static int hyperv_plane_atomic_check(struct drm_plane *plane,
> -				     struct drm_atomic_state *state)
> +				     struct drm_atomic_commit *state)
>   {
>   	struct drm_plane_state *plane_state = drm_atomic_get_new_plane_state(state, plane);
>   	struct hyperv_drm_device *hv = to_hv(plane->dev);
>   	struct drm_framebuffer *fb = plane_state->fb;
>   	struct drm_crtc *crtc = plane_state->crtc;
> @@ -166,11 +166,11 @@ static int hyperv_plane_atomic_check(struct drm_plane *plane,
>   
>   	return 0;
>   }
>   
>   static void hyperv_plane_atomic_update(struct drm_plane *plane,
> -				       struct drm_atomic_state *state)
> +				       struct drm_atomic_commit *state)
>   {
>   	struct hyperv_drm_device *hv = to_hv(plane->dev);
>   	struct drm_plane_state *old_state = drm_atomic_get_old_plane_state(state, plane);
>   	struct drm_plane_state *new_state = drm_atomic_get_new_plane_state(state, plane);
>   	struct drm_shadow_plane_state *shadow_plane_state = to_drm_shadow_plane_state(new_state);
> diff --git a/drivers/gpu/drm/i915/display/g4x_hdmi.c b/drivers/gpu/drm/i915/display/g4x_hdmi.c
> index 5fe5067c4237c01d7640661ec8ea6f5a95460c0f..380e07d11647342064eea51c5947d30118497cf0 100644
> --- a/drivers/gpu/drm/i915/display/g4x_hdmi.c
> +++ b/drivers/gpu/drm/i915/display/g4x_hdmi.c
> @@ -590,11 +590,11 @@ intel_hdmi_hotplug(struct intel_encoder *encoder,
>   
>   	return state;
>   }
>   
>   int g4x_hdmi_connector_atomic_check(struct drm_connector *connector,
> -				    struct drm_atomic_state *state)
> +				    struct drm_atomic_commit *state)
>   {
>   	struct intel_display *display = to_intel_display(connector->dev);
>   	struct drm_connector_list_iter conn_iter;
>   	struct drm_connector *conn;
>   	int ret;
> diff --git a/drivers/gpu/drm/i915/display/g4x_hdmi.h b/drivers/gpu/drm/i915/display/g4x_hdmi.h
> index 039d2bdba06c1dd77aa8641f264fce60b7239505..c37f4d21866979760f5377fa620a85e4e5b7cf19 100644
> --- a/drivers/gpu/drm/i915/display/g4x_hdmi.h
> +++ b/drivers/gpu/drm/i915/display/g4x_hdmi.h
> @@ -9,27 +9,27 @@
>   #include <linux/types.h>
>   
>   #include "i915_reg_defs.h"
>   
>   enum port;
> -struct drm_atomic_state;
> +struct drm_atomic_commit;
>   struct drm_connector;
>   struct intel_display;
>   
>   #ifdef I915
>   bool g4x_hdmi_init(struct intel_display *display,
>   		   i915_reg_t hdmi_reg, enum port port);
>   int g4x_hdmi_connector_atomic_check(struct drm_connector *connector,
> -				    struct drm_atomic_state *state);
> +				    struct drm_atomic_commit *state);
>   #else
>   static inline bool g4x_hdmi_init(struct intel_display *display,
>   				 i915_reg_t hdmi_reg, int port)
>   {
>   	return false;
>   }
>   static inline int g4x_hdmi_connector_atomic_check(struct drm_connector *connector,
> -						  struct drm_atomic_state *state)
> +						  struct drm_atomic_commit *state)
>   {
>   	return 0;
>   }
>   #endif
>   
> diff --git a/drivers/gpu/drm/i915/display/i9xx_wm.c b/drivers/gpu/drm/i915/display/i9xx_wm.c
> index 9e170e79dcf6764e2f12df5d37ceef39cb3cc223..ca7010da941992a1e4e036962eefba70b20f6025 100644
> --- a/drivers/gpu/drm/i915/display/i9xx_wm.c
> +++ b/drivers/gpu/drm/i915/display/i9xx_wm.c
> @@ -3532,11 +3532,11 @@ static void ilk_pipe_wm_get_hw_state(struct intel_crtc *crtc)
>   	}
>   
>   	crtc->wm.active.ilk = *active;
>   }
>   
> -static int ilk_sanitize_watermarks_add_affected(struct drm_atomic_state *state)
> +static int ilk_sanitize_watermarks_add_affected(struct drm_atomic_commit *state)
>   {
>   	struct drm_plane *plane;
>   	struct intel_crtc *crtc;
>   
>   	for_each_intel_crtc(state->dev, crtc) {
> @@ -3576,11 +3576,11 @@ static int ilk_sanitize_watermarks_add_affected(struct drm_atomic_state *state)
>    * through the atomic check code to calculate new watermark values in the
>    * state object.
>    */
>   void ilk_wm_sanitize(struct intel_display *display)
>   {
> -	struct drm_atomic_state *state;
> +	struct drm_atomic_commit *state;
>   	struct intel_atomic_state *intel_state;
>   	struct intel_crtc *crtc;
>   	struct intel_crtc_state *crtc_state;
>   	struct drm_modeset_acquire_ctx ctx;
>   	int ret;
> @@ -3591,11 +3591,11 @@ void ilk_wm_sanitize(struct intel_display *display)
>   		return;
>   
>   	if (drm_WARN_ON(display->drm, DISPLAY_VER(display) >= 9))
>   		return;
>   
> -	state = drm_atomic_state_alloc(display->drm);
> +	state = drm_atomic_commit_alloc(display->drm);
>   	if (drm_WARN_ON(display->drm, !state))
>   		return;
>   
>   	intel_state = to_intel_atomic_state(state);
>   
> @@ -3629,11 +3629,11 @@ void ilk_wm_sanitize(struct intel_display *display)
>   		to_intel_crtc_state(crtc->base.state)->wm = crtc_state->wm;
>   	}
>   
>   fail:
>   	if (ret == -EDEADLK) {
> -		drm_atomic_state_clear(state);
> +		drm_atomic_commit_clear(state);
>   		drm_modeset_backoff(&ctx);
>   		goto retry;
>   	}
>   
>   	/*
> @@ -3648,11 +3648,11 @@ void ilk_wm_sanitize(struct intel_display *display)
>   	 * BIOS-programmed watermarks untouched and hope for the best.
>   	 */
>   	drm_WARN(display->drm, ret,
>   		 "Could not determine valid watermarks for inherited state\n");
>   
> -	drm_atomic_state_put(state);
> +	drm_atomic_commit_put(state);
>   
>   	drm_modeset_drop_locks(&ctx);
>   	drm_modeset_acquire_fini(&ctx);
>   }
>   
> diff --git a/drivers/gpu/drm/i915/display/intel_atomic.c b/drivers/gpu/drm/i915/display/intel_atomic.c
> index 71b7325917b6e650697c15c8287f39f02fc30054..38bbd6964d8ee4587576637648a7cab671d38ea2 100644
> --- a/drivers/gpu/drm/i915/display/intel_atomic.c
> +++ b/drivers/gpu/drm/i915/display/intel_atomic.c
> @@ -110,11 +110,11 @@ int intel_digital_connector_atomic_set_property(struct drm_connector *connector,
>   		       property->base.id, property->name);
>   	return -EINVAL;
>   }
>   
>   int intel_digital_connector_atomic_check(struct drm_connector *conn,
> -					 struct drm_atomic_state *state)
> +					 struct drm_atomic_commit *state)
>   {
>   	struct drm_connector_state *new_state =
>   		drm_atomic_get_new_connector_state(state, conn);
>   	struct intel_digital_connector_state *new_conn_state =
>   		to_intel_digital_connector_state(new_state);
> @@ -318,48 +318,48 @@ intel_crtc_destroy_state(struct drm_crtc *crtc,
>   	if (crtc_state->dp_tunnel_ref.tunnel)
>   		drm_dp_tunnel_ref_put(&crtc_state->dp_tunnel_ref);
>   	kfree(crtc_state);
>   }
>   
> -struct drm_atomic_state *
> +struct drm_atomic_commit *
>   intel_atomic_state_alloc(struct drm_device *dev)
>   {
>   	struct intel_atomic_state *state = kzalloc_obj(*state);
>   
> -	if (!state || drm_atomic_state_init(dev, &state->base) < 0) {
> +	if (!state || drm_atomic_commit_init(dev, &state->base) < 0) {
>   		kfree(state);
>   		return NULL;
>   	}
>   
>   	return &state->base;
>   }
>   
> -void intel_atomic_state_free(struct drm_atomic_state *_state)
> +void intel_atomic_state_free(struct drm_atomic_commit *_state)
>   {
>   	struct intel_atomic_state *state = to_intel_atomic_state(_state);
>   
> -	drm_atomic_state_default_release(&state->base);
> +	drm_atomic_commit_default_release(&state->base);
>   	kfree(state->global_objs);
>   	kfree(state);
>   }
>   
> -void intel_atomic_state_clear(struct drm_atomic_state *s)
> +void intel_atomic_state_clear(struct drm_atomic_commit *s)
>   {
>   	struct intel_atomic_state *state = to_intel_atomic_state(s);
>   
> -	drm_atomic_state_default_clear(&state->base);
> +	drm_atomic_commit_default_clear(&state->base);
>   	intel_atomic_clear_global_state(state);
>   
>   	/* state->internal not reset on purpose */
>   
>   	state->dpll_set = state->modeset = false;
>   
>   	intel_dp_tunnel_atomic_cleanup_inherited_state(state);
>   }
>   
>   struct intel_crtc_state *
> -intel_atomic_get_crtc_state(struct drm_atomic_state *state,
> +intel_atomic_get_crtc_state(struct drm_atomic_commit *state,
>   			    struct intel_crtc *crtc)
>   {
>   	struct drm_crtc_state *crtc_state;
>   	crtc_state = drm_atomic_get_crtc_state(state, &crtc->base);
>   	if (IS_ERR(crtc_state))
> diff --git a/drivers/gpu/drm/i915/display/intel_atomic.h b/drivers/gpu/drm/i915/display/intel_atomic.h
> index a5a7e2906ba89d00d9f271ad1f115795e1664e22..4dc5205a47331e004c293bca7e44ffd5a8f25c33 100644
> --- a/drivers/gpu/drm/i915/display/intel_atomic.h
> +++ b/drivers/gpu/drm/i915/display/intel_atomic.h
> @@ -6,11 +6,11 @@
>   #ifndef __INTEL_ATOMIC_H__
>   #define __INTEL_ATOMIC_H__
>   
>   #include <linux/types.h>
>   
> -struct drm_atomic_state;
> +struct drm_atomic_commit;
>   struct drm_connector;
>   struct drm_connector_state;
>   struct drm_crtc;
>   struct drm_crtc_state;
>   struct drm_device;
> @@ -27,11 +27,11 @@ int intel_digital_connector_atomic_get_property(struct drm_connector *connector,
>   int intel_digital_connector_atomic_set_property(struct drm_connector *connector,
>   						struct drm_connector_state *state,
>   						struct drm_property *property,
>   						u64 val);
>   int intel_digital_connector_atomic_check(struct drm_connector *conn,
> -					 struct drm_atomic_state *state);
> +					 struct drm_atomic_commit *state);
>   struct drm_connector_state *
>   intel_digital_connector_duplicate_state(struct drm_connector *connector);
>   bool intel_connector_needs_modeset(struct intel_atomic_state *state,
>   				   struct drm_connector *connector);
>   bool intel_any_crtc_needs_modeset(struct intel_atomic_state *state);
> @@ -41,14 +41,14 @@ intel_atomic_get_digital_connector_state(struct intel_atomic_state *state,
>   
>   struct drm_crtc_state *intel_crtc_duplicate_state(struct drm_crtc *crtc);
>   void intel_crtc_destroy_state(struct drm_crtc *crtc,
>   			       struct drm_crtc_state *state);
>   void intel_crtc_free_hw_state(struct intel_crtc_state *crtc_state);
> -struct drm_atomic_state *intel_atomic_state_alloc(struct drm_device *dev);
> -void intel_atomic_state_free(struct drm_atomic_state *state);
> -void intel_atomic_state_clear(struct drm_atomic_state *state);
> +struct drm_atomic_commit *intel_atomic_state_alloc(struct drm_device *dev);
> +void intel_atomic_state_free(struct drm_atomic_commit *state);
> +void intel_atomic_state_clear(struct drm_atomic_commit *state);
>   
>   struct intel_crtc_state *
> -intel_atomic_get_crtc_state(struct drm_atomic_state *state,
> +intel_atomic_get_crtc_state(struct drm_atomic_commit *state,
>   			    struct intel_crtc *crtc);
>   
>   #endif /* __INTEL_ATOMIC_H__ */
> diff --git a/drivers/gpu/drm/i915/display/intel_audio.c b/drivers/gpu/drm/i915/display/intel_audio.c
> index 081627e0d9171faf6ef63a6eb656204b8ad9bcc4..8ff128fde7ea2cb3ebe859491a0582afd98a7b70 100644
> --- a/drivers/gpu/drm/i915/display/intel_audio.c
> +++ b/drivers/gpu/drm/i915/display/intel_audio.c
> @@ -956,38 +956,38 @@ static int glk_force_audio_cdclk_commit(struct intel_atomic_state *state,
>   
>   static void glk_force_audio_cdclk(struct intel_display *display,
>   				  bool enable)
>   {
>   	struct drm_modeset_acquire_ctx ctx;
> -	struct drm_atomic_state *state;
> +	struct drm_atomic_commit *state;
>   	struct intel_crtc *crtc;
>   	int ret;
>   
>   	crtc = intel_first_crtc(display);
>   	if (!crtc)
>   		return;
>   
>   	drm_modeset_acquire_init(&ctx, 0);
> -	state = drm_atomic_state_alloc(display->drm);
> +	state = drm_atomic_commit_alloc(display->drm);
>   	if (drm_WARN_ON(display->drm, !state))
>   		return;
>   
>   	state->acquire_ctx = &ctx;
>   	to_intel_atomic_state(state)->internal = true;
>   
>   retry:
>   	ret = glk_force_audio_cdclk_commit(to_intel_atomic_state(state), crtc,
>   					   enable);
>   	if (ret == -EDEADLK) {
> -		drm_atomic_state_clear(state);
> +		drm_atomic_commit_clear(state);
>   		drm_modeset_backoff(&ctx);
>   		goto retry;
>   	}
>   
>   	drm_WARN_ON(display->drm, ret);
>   
> -	drm_atomic_state_put(state);
> +	drm_atomic_commit_put(state);
>   
>   	drm_modeset_drop_locks(&ctx);
>   	drm_modeset_acquire_fini(&ctx);
>   }
>   
> diff --git a/drivers/gpu/drm/i915/display/intel_crt.c b/drivers/gpu/drm/i915/display/intel_crt.c
> index 6aa6a1dd6e1b0159c61d1529d07e7cfeca5d06b5..adab1cf2f3c49b5444804a33a80c8f8e90c9c4c3 100644
> --- a/drivers/gpu/drm/i915/display/intel_crt.c
> +++ b/drivers/gpu/drm/i915/display/intel_crt.c
> @@ -848,11 +848,11 @@ intel_crt_detect(struct drm_connector *connector,
>   		 bool force)
>   {
>   	struct intel_display *display = to_intel_display(connector->dev);
>   	struct intel_crt *crt = intel_attached_crt(to_intel_connector(connector));
>   	struct intel_encoder *encoder = &crt->base;
> -	struct drm_atomic_state *state;
> +	struct drm_atomic_commit *state;
>   	struct ref_tracker *wakeref;
>   	int status;
>   
>   	drm_dbg_kms(display->drm, "[CONNECTOR:%d:%s] force=%d\n",
>   		    connector->base.id, connector->name,
> diff --git a/drivers/gpu/drm/i915/display/intel_display.c b/drivers/gpu/drm/i915/display/intel_display.c
> index 10b6c6fcb03f693d85f26a0fabceff2afecdd274..83fcf3499fdee1e4a580a125d284911f3bf75986 100644
> --- a/drivers/gpu/drm/i915/display/intel_display.c
> +++ b/drivers/gpu/drm/i915/display/intel_display.c
> @@ -5656,15 +5656,15 @@ int intel_modeset_all_pipes_late(struct intel_atomic_state *state,
>   
>   int intel_modeset_commit_pipes(struct intel_display *display,
>   			       u8 pipe_mask,
>   			       struct drm_modeset_acquire_ctx *ctx)
>   {
> -	struct drm_atomic_state *state;
> +	struct drm_atomic_commit *state;
>   	struct intel_crtc *crtc;
>   	int ret;
>   
> -	state = drm_atomic_state_alloc(display->drm);
> +	state = drm_atomic_commit_alloc(display->drm);
>   	if (!state)
>   		return -ENOMEM;
>   
>   	state->acquire_ctx = ctx;
>   	to_intel_atomic_state(state)->internal = true;
> @@ -5681,11 +5681,11 @@ int intel_modeset_commit_pipes(struct intel_display *display,
>   		crtc_state->uapi.connectors_changed = true;
>   	}
>   
>   	ret = drm_atomic_commit(state);
>   out:
> -	drm_atomic_state_put(state);
> +	drm_atomic_commit_put(state);
>   
>   	return ret;
>   }
>   
>   /*
> @@ -6413,11 +6413,11 @@ static int intel_atomic_check_config_and_link(struct intel_atomic_state *state)
>    * intel_atomic_check - validate state object
>    * @dev: drm device
>    * @_state: state to validate
>    */
>   int intel_atomic_check(struct drm_device *dev,
> -		       struct drm_atomic_state *_state)
> +		       struct drm_atomic_commit *_state)
>   {
>   	struct intel_display *display = to_intel_display(dev);
>   	struct intel_atomic_state *state = to_intel_atomic_state(_state);
>   	struct intel_crtc_state *old_crtc_state, *new_crtc_state;
>   	struct intel_crtc *crtc;
> @@ -7223,11 +7223,11 @@ static void intel_atomic_cleanup_work(struct work_struct *work)
>   	for_each_old_intel_crtc_in_state(state, crtc, old_crtc_state, i)
>   		intel_atomic_dsb_cleanup(old_crtc_state);
>   
>   	drm_atomic_helper_cleanup_planes(display->drm, &state->base);
>   	drm_atomic_helper_commit_cleanup_done(&state->base);
> -	drm_atomic_state_put(&state->base);
> +	drm_atomic_commit_put(&state->base);
>   }
>   
>   static void intel_atomic_prepare_plane_clear_colors(struct intel_atomic_state *state)
>   {
>   	struct intel_display *display = to_intel_display(state);
> @@ -7727,11 +7727,11 @@ static int intel_atomic_swap_state(struct intel_atomic_state *state)
>   	intel_atomic_track_fbs(state);
>   
>   	return 0;
>   }
>   
> -int intel_atomic_commit(struct drm_device *dev, struct drm_atomic_state *_state,
> +int intel_atomic_commit(struct drm_device *dev, struct drm_atomic_commit *_state,
>   			bool nonblock)
>   {
>   	struct intel_display *display = to_intel_display(dev);
>   	struct intel_atomic_state *state = to_intel_atomic_state(_state);
>   	int ret = 0;
> @@ -7782,11 +7782,11 @@ int intel_atomic_commit(struct drm_device *dev, struct drm_atomic_state *_state,
>   		drm_atomic_helper_unprepare_planes(dev, &state->base);
>   		intel_display_rpm_put(display, state->wakeref);
>   		return ret;
>   	}
>   
> -	drm_atomic_state_get(&state->base);
> +	drm_atomic_commit_get(&state->base);
>   	INIT_WORK(&state->base.commit_work, intel_atomic_commit_work);
>   
>   	if (nonblock && state->modeset) {
>   		queue_work(display->wq.modeset, &state->base.commit_work);
>   	} else if (nonblock) {
> @@ -8296,16 +8296,16 @@ void intel_init_display_hooks(struct intel_display *display)
>   	}
>   }
>   
>   int intel_initial_commit(struct intel_display *display)
>   {
> -	struct drm_atomic_state *state = NULL;
> +	struct drm_atomic_commit *state = NULL;
>   	struct drm_modeset_acquire_ctx ctx;
>   	struct intel_crtc *crtc;
>   	int ret = 0;
>   
> -	state = drm_atomic_state_alloc(display->drm);
> +	state = drm_atomic_commit_alloc(display->drm);
>   	if (!state)
>   		return -ENOMEM;
>   
>   	drm_modeset_acquire_init(&ctx, 0);
>   
> @@ -8355,16 +8355,16 @@ int intel_initial_commit(struct intel_display *display)
>   
>   	ret = drm_atomic_commit(state);
>   
>   out:
>   	if (ret == -EDEADLK) {
> -		drm_atomic_state_clear(state);
> +		drm_atomic_commit_clear(state);
>   		drm_modeset_backoff(&ctx);
>   		goto retry;
>   	}
>   
> -	drm_atomic_state_put(state);
> +	drm_atomic_commit_put(state);
>   
>   	drm_modeset_drop_locks(&ctx);
>   	drm_modeset_acquire_fini(&ctx);
>   
>   	return ret;
> diff --git a/drivers/gpu/drm/i915/display/intel_display.h b/drivers/gpu/drm/i915/display/intel_display.h
> index 552a59d19e0f621081c88d0ea2f6bd0cf7ff7159..8b715d5b4cd88ec21ac3c3a36557bbcc53d503fa 100644
> --- a/drivers/gpu/drm/i915/display/intel_display.h
> +++ b/drivers/gpu/drm/i915/display/intel_display.h
> @@ -28,11 +28,11 @@
>   #include <drm/drm_util.h>
>   
>   #include "i915_reg_defs.h"
>   #include "intel_display_limits.h"
>   
> -struct drm_atomic_state;
> +struct drm_atomic_commit;
>   struct drm_device;
>   struct drm_display_mode;
>   struct drm_encoder;
>   struct drm_format_info;
>   struct drm_modeset_acquire_ctx;
> @@ -366,11 +366,11 @@ enum phy_fia {
>   	for_each_crtc_in_masks_reverse(display, crtc, \
>   				       _intel_modeset_primary_pipes(crtc_state), \
>   				       _intel_modeset_secondary_pipes(crtc_state), \
>   				       i)
>   
> -int intel_atomic_check(struct drm_device *dev, struct drm_atomic_state *state);
> +int intel_atomic_check(struct drm_device *dev, struct drm_atomic_commit *state);
>   u8 intel_calc_enabled_pipes(struct intel_atomic_state *state,
>   			    u8 enabled_pipes);
>   u8 intel_calc_active_pipes(struct intel_atomic_state *state,
>   			   u8 active_pipes);
>   void intel_link_compute_m_n(u16 bpp, int nlanes,
> @@ -505,11 +505,11 @@ void intel_init_display_hooks(struct intel_display *display);
>   void intel_setup_outputs(struct intel_display *display);
>   int intel_initial_commit(struct intel_display *display);
>   void intel_panel_sanitize_ssc(struct intel_display *display);
>   enum drm_mode_status intel_mode_valid(struct drm_device *dev,
>   				      const struct drm_display_mode *mode);
> -int intel_atomic_commit(struct drm_device *dev, struct drm_atomic_state *_state,
> +int intel_atomic_commit(struct drm_device *dev, struct drm_atomic_commit *_state,
>   			bool nonblock);
>   
>   /* modesetting asserts */
>   void assert_transcoder(struct intel_display *display,
>   		       enum transcoder cpu_transcoder, bool state);
> diff --git a/drivers/gpu/drm/i915/display/intel_display_core.h b/drivers/gpu/drm/i915/display/intel_display_core.h
> index d708d322aa85a01a95daaed393f29f21b466aacc..a54f40115f1d9d4871a2dd2b9ad40d17f919981d 100644
> --- a/drivers/gpu/drm/i915/display/intel_display_core.h
> +++ b/drivers/gpu/drm/i915/display/intel_display_core.h
> @@ -556,11 +556,11 @@ struct intel_display {
>   		unsigned long mask;
>   	} quirks;
>   
>   	struct {
>   		/* restore state for suspend/resume and display reset */
> -		struct drm_atomic_state *modeset_state;
> +		struct drm_atomic_commit *modeset_state;
>   		struct drm_modeset_acquire_ctx reset_ctx;
>   		/* modeset stuck tracking for reset */
>   		atomic_t pending_fb_pin;
>   		u32 saveDSPARB;
>   		u32 saveSWF0[16];
> diff --git a/drivers/gpu/drm/i915/display/intel_display_driver.c b/drivers/gpu/drm/i915/display/intel_display_driver.c
> index 23bfecc983e8d4b8956e143afe06f1d0bbc20982..36891aa5717e34e2ada116211715c4831d151b68 100644
> --- a/drivers/gpu/drm/i915/display/intel_display_driver.c
> +++ b/drivers/gpu/drm/i915/display/intel_display_driver.c
> @@ -677,11 +677,11 @@ void intel_display_driver_unregister(struct intel_display *display)
>    * turn all crtc's off, but do not adjust state
>    * This has to be paired with a call to intel_modeset_setup_hw_state.
>    */
>   int intel_display_driver_suspend(struct intel_display *display)
>   {
> -	struct drm_atomic_state *state;
> +	struct drm_atomic_commit *state;
>   	int ret;
>   
>   	if (!HAS_DISPLAY(display))
>   		return 0;
>   
> @@ -701,11 +701,11 @@ int intel_display_driver_suspend(struct intel_display *display)
>   	return ret;
>   }
>   
>   int
>   __intel_display_driver_resume(struct intel_display *display,
> -			      struct drm_atomic_state *state,
> +			      struct drm_atomic_commit *state,
>   			      struct drm_modeset_acquire_ctx *ctx)
>   {
>   	struct drm_crtc_state *crtc_state;
>   	struct drm_crtc *crtc;
>   	int ret, i;
> @@ -740,11 +740,11 @@ __intel_display_driver_resume(struct intel_display *display,
>   	return ret;
>   }
>   
>   void intel_display_driver_resume(struct intel_display *display)
>   {
> -	struct drm_atomic_state *state = display->restore.modeset_state;
> +	struct drm_atomic_commit *state = display->restore.modeset_state;
>   	struct drm_modeset_acquire_ctx ctx;
>   	int ret;
>   
>   	if (!HAS_DISPLAY(display))
>   		return;
> @@ -775,7 +775,7 @@ void intel_display_driver_resume(struct intel_display *display)
>   
>   	if (ret)
>   		drm_err(display->drm,
>   			"Restoring old state failed with %i\n", ret);
>   	if (state)
> -		drm_atomic_state_put(state);
> +		drm_atomic_commit_put(state);
>   }
> diff --git a/drivers/gpu/drm/i915/display/intel_display_driver.h b/drivers/gpu/drm/i915/display/intel_display_driver.h
> index 2966ff91b219c9eab70641a885327fe3fd04b90c..5270c26a32e0adf2298a993a31afcf5957b118f0 100644
> --- a/drivers/gpu/drm/i915/display/intel_display_driver.h
> +++ b/drivers/gpu/drm/i915/display/intel_display_driver.h
> @@ -6,11 +6,11 @@
>   #ifndef __INTEL_DISPLAY_DRIVER_H__
>   #define __INTEL_DISPLAY_DRIVER_H__
>   
>   #include <linux/types.h>
>   
> -struct drm_atomic_state;
> +struct drm_atomic_commit;
>   struct drm_modeset_acquire_ctx;
>   struct intel_display;
>   struct pci_dev;
>   
>   bool intel_display_driver_probe_defer(struct pci_dev *pdev);
> @@ -27,11 +27,11 @@ void intel_display_driver_unregister(struct intel_display *display);
>   int intel_display_driver_suspend(struct intel_display *display);
>   void intel_display_driver_resume(struct intel_display *display);
>   
>   /* interface for intel_display_reset.c */
>   int __intel_display_driver_resume(struct intel_display *display,
> -				  struct drm_atomic_state *state,
> +				  struct drm_atomic_commit *state,
>   				  struct drm_modeset_acquire_ctx *ctx);
>   
>   void intel_display_driver_enable_user_access(struct intel_display *display);
>   void intel_display_driver_disable_user_access(struct intel_display *display);
>   void intel_display_driver_suspend_access(struct intel_display *display);
> diff --git a/drivers/gpu/drm/i915/display/intel_display_reset.c b/drivers/gpu/drm/i915/display/intel_display_reset.c
> index d00ef5bdcbda90f25d5b6995d45e60c986f64547..9481165ecfec409ad58cf72917deb5bea760740a 100644
> --- a/drivers/gpu/drm/i915/display/intel_display_reset.c
> +++ b/drivers/gpu/drm/i915/display/intel_display_reset.c
> @@ -24,11 +24,11 @@ bool intel_display_reset_test(struct intel_display *display)
>   /* returns true if intel_display_reset_finish() needs to be called */
>   bool intel_display_reset_prepare(struct intel_display *display,
>   				 modeset_stuck_fn modeset_stuck, void *context)
>   {
>   	struct drm_modeset_acquire_ctx *ctx = &display->restore.reset_ctx;
> -	struct drm_atomic_state *state;
> +	struct drm_atomic_commit *state;
>   	int ret;
>   
>   	if (!HAS_DISPLAY(display))
>   		return false;
>   
> @@ -65,11 +65,11 @@ bool intel_display_reset_prepare(struct intel_display *display,
>   
>   	ret = drm_atomic_helper_disable_all(display->drm, ctx);
>   	if (ret) {
>   		drm_err(display->drm, "Suspending crtc's failed with %i\n",
>   			ret);
> -		drm_atomic_state_put(state);
> +		drm_atomic_commit_put(state);
>   		return true;
>   	}
>   
>   	display->restore.modeset_state = state;
>   	state->acquire_ctx = ctx;
> @@ -78,11 +78,11 @@ bool intel_display_reset_prepare(struct intel_display *display,
>   }
>   
>   void intel_display_reset_finish(struct intel_display *display, bool test_only)
>   {
>   	struct drm_modeset_acquire_ctx *ctx = &display->restore.reset_ctx;
> -	struct drm_atomic_state *state;
> +	struct drm_atomic_commit *state;
>   	int ret;
>   
>   	if (!HAS_DISPLAY(display))
>   		return;
>   
> @@ -116,11 +116,11 @@ void intel_display_reset_finish(struct intel_display *display, bool test_only)
>   				"Restoring old state failed with %i\n", ret);
>   
>   		intel_hpd_poll_disable(display);
>   	}
>   
> -	drm_atomic_state_put(state);
> +	drm_atomic_commit_put(state);
>   unlock:
>   	drm_modeset_drop_locks(ctx);
>   	drm_modeset_acquire_fini(ctx);
>   	mutex_unlock(&display->drm->mode_config.mutex);
>   }
> diff --git a/drivers/gpu/drm/i915/display/intel_display_types.h b/drivers/gpu/drm/i915/display/intel_display_types.h
> index e2496db1642adccf87fbc29d730a83277f3b056f..b519be0e76d384d06fdc8b67b4c07387263d49a3 100644
> --- a/drivers/gpu/drm/i915/display/intel_display_types.h
> +++ b/drivers/gpu/drm/i915/display/intel_display_types.h
> @@ -631,11 +631,11 @@ struct dpll {
>   	int	m;
>   	int	p;
>   };
>   
>   struct intel_atomic_state {
> -	struct drm_atomic_state base;
> +	struct drm_atomic_commit base;
>   
>   	struct ref_tracker *wakeref;
>   
>   	struct intel_global_objs_state *global_objs;
>   	int num_global_objs;
> diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
> index 4955bd8b11d7ad04d918c9e43b59c3a06bddeebc..45c54970b0dfd3d91d9f0ce0055a89d2061fedb8 100644
> --- a/drivers/gpu/drm/i915/display/intel_dp.c
> +++ b/drivers/gpu/drm/i915/display/intel_dp.c
> @@ -6731,11 +6731,11 @@ static int intel_modeset_synced_crtcs(struct intel_atomic_state *state,
>   	return intel_modeset_affected_transcoders(state,
>   						  transcoders);
>   }
>   
>   static int intel_dp_connector_atomic_check(struct drm_connector *_connector,
> -					   struct drm_atomic_state *_state)
> +					   struct drm_atomic_commit *_state)
>   {
>   	struct intel_connector *connector = to_intel_connector(_connector);
>   	struct intel_display *display = to_intel_display(connector);
>   	struct intel_atomic_state *state = to_intel_atomic_state(_state);
>   	struct drm_connector_state *conn_state =
> diff --git a/drivers/gpu/drm/i915/display/intel_dp_mst.c b/drivers/gpu/drm/i915/display/intel_dp_mst.c
> index 887b6de14e46776c1244ce4d51bd46c3a4105d33..f9c8a7d79ab66c522b4e1985d3a66fe913d75404 100644
> --- a/drivers/gpu/drm/i915/display/intel_dp_mst.c
> +++ b/drivers/gpu/drm/i915/display/intel_dp_mst.c
> @@ -249,11 +249,11 @@ int intel_dp_mtp_tu_compute_config(struct intel_dp *intel_dp,
>   				   struct intel_crtc_state *crtc_state,
>   				   struct drm_connector_state *conn_state,
>   				   int min_bpp_x16, int max_bpp_x16, int bpp_step_x16, bool dsc)
>   {
>   	struct intel_display *display = to_intel_display(intel_dp);
> -	struct drm_atomic_state *state = crtc_state->uapi.state;
> +	struct drm_atomic_commit *state = crtc_state->uapi.state;
>   	struct drm_dp_mst_topology_state *mst_state = NULL;
>   	struct intel_connector *connector =
>   		to_intel_connector(conn_state->connector);
>   	const struct drm_display_mode *adjusted_mode =
>   		&crtc_state->hw.adjusted_mode;
> @@ -994,11 +994,11 @@ mst_connector_atomic_topology_check(struct intel_connector *connector,
>   	return ret;
>   }
>   
>   static int
>   mst_connector_atomic_check(struct drm_connector *_connector,
> -			   struct drm_atomic_state *_state)
> +			   struct drm_atomic_commit *_state)
>   {
>   	struct intel_atomic_state *state = to_intel_atomic_state(_state);
>   	struct intel_connector *connector = to_intel_connector(_connector);
>   	int ret;
>   
> @@ -1601,11 +1601,11 @@ mst_connector_mode_valid_ctx(struct drm_connector *_connector,
>   	return 0;
>   }
>   
>   static struct drm_encoder *
>   mst_connector_atomic_best_encoder(struct drm_connector *_connector,
> -				  struct drm_atomic_state *state)
> +				  struct drm_atomic_commit *state)
>   {
>   	struct intel_connector *connector = to_intel_connector(_connector);
>   	struct drm_connector_state *connector_state =
>   		drm_atomic_get_new_connector_state(state, &connector->base);
>   	struct intel_dp *intel_dp = connector->mst.dp;
> diff --git a/drivers/gpu/drm/i915/display/intel_dpll_mgr.c b/drivers/gpu/drm/i915/display/intel_dpll_mgr.c
> index f5d4f7146fbc6ac33968b79404e849bf26c854e6..5f92391e4bdd5838a9a8b183d30811351114c6cd 100644
> --- a/drivers/gpu/drm/i915/display/intel_dpll_mgr.c
> +++ b/drivers/gpu/drm/i915/display/intel_dpll_mgr.c
> @@ -132,11 +132,11 @@ intel_atomic_duplicate_dpll_state(struct intel_display *display,
>   	for_each_dpll(display, pll, i)
>   		dpll_state[pll->index] = pll->state;
>   }
>   
>   static struct intel_dpll_state *
> -intel_atomic_get_dpll_state(struct drm_atomic_state *s)
> +intel_atomic_get_dpll_state(struct drm_atomic_commit *s)
>   {
>   	struct intel_atomic_state *state = to_intel_atomic_state(s);
>   	struct intel_display *display = to_intel_display(state);
>   
>   	drm_WARN_ON(s->dev, !drm_modeset_is_locked(&s->dev->mode_config.connection_mutex));
> diff --git a/drivers/gpu/drm/i915/display/intel_fdi.c b/drivers/gpu/drm/i915/display/intel_fdi.c
> index 24ce8a7842c7de234bdd505ee95abfeac74e4695..feef8e3f2b4e75dee5f3e53cbd3969318e8a5c0a 100644
> --- a/drivers/gpu/drm/i915/display/intel_fdi.c
> +++ b/drivers/gpu/drm/i915/display/intel_fdi.c
> @@ -183,11 +183,11 @@ static int pipe_required_fdi_lanes(struct intel_crtc_state *crtc_state)
>   
>   static int ilk_check_fdi_lanes(struct intel_display *display, enum pipe pipe,
>   			       struct intel_crtc_state *pipe_config,
>   			       enum pipe *pipe_to_reduce)
>   {
> -	struct drm_atomic_state *state = pipe_config->uapi.state;
> +	struct drm_atomic_commit *state = pipe_config->uapi.state;
>   	struct intel_crtc *other_crtc;
>   	struct intel_crtc_state *other_crtc_state;
>   
>   	*pipe_to_reduce = pipe;
>   
> diff --git a/drivers/gpu/drm/i915/display/intel_hdmi.c b/drivers/gpu/drm/i915/display/intel_hdmi.c
> index 05e898d10a2be7e0fa4bf9282454b1ba417c194c..f9858b91f4978f71d655d0355b62d558517a4f40 100644
> --- a/drivers/gpu/drm/i915/display/intel_hdmi.c
> +++ b/drivers/gpu/drm/i915/display/intel_hdmi.c
> @@ -2654,11 +2654,11 @@ static const struct drm_connector_funcs intel_hdmi_connector_funcs = {
>   	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
>   	.atomic_duplicate_state = intel_digital_connector_duplicate_state,
>   };
>   
>   static int intel_hdmi_connector_atomic_check(struct drm_connector *_connector,
> -					     struct drm_atomic_state *state)
> +					     struct drm_atomic_commit *state)
>   {
>   	struct intel_connector *connector = to_intel_connector(_connector);
>   	struct intel_display *display = to_intel_display(connector);
>   
>   	if (HAS_DDI(display))
> diff --git a/drivers/gpu/drm/i915/display/intel_load_detect.c b/drivers/gpu/drm/i915/display/intel_load_detect.c
> index aad52d0d83e1ef3bb7f32103a838437ca56028a4..2f767b15a7f9ba07aec1dd83fd1da1f011de82a5 100644
> --- a/drivers/gpu/drm/i915/display/intel_load_detect.c
> +++ b/drivers/gpu/drm/i915/display/intel_load_detect.c
> @@ -18,11 +18,11 @@
>   static const struct drm_display_mode load_detect_mode = {
>   	DRM_MODE("640x480", DRM_MODE_TYPE_DEFAULT, 31500, 640, 664,
>   		 704, 832, 0, 480, 489, 491, 520, 0, DRM_MODE_FLAG_NHSYNC | DRM_MODE_FLAG_NVSYNC),
>   };
>   
> -static int intel_modeset_disable_planes(struct drm_atomic_state *state,
> +static int intel_modeset_disable_planes(struct drm_atomic_commit *state,
>   					struct drm_crtc *crtc)
>   {
>   	struct drm_plane *plane;
>   	struct drm_plane_state *plane_state;
>   	int ret, i;
> @@ -43,21 +43,21 @@ static int intel_modeset_disable_planes(struct drm_atomic_state *state,
>   	}
>   
>   	return 0;
>   }
>   
> -struct drm_atomic_state *
> +struct drm_atomic_commit *
>   intel_load_detect_get_pipe(struct drm_connector *connector,
>   			   struct drm_modeset_acquire_ctx *ctx)
>   {
>   	struct intel_display *display = to_intel_display(connector->dev);
>   	struct intel_encoder *encoder =
>   		intel_attached_encoder(to_intel_connector(connector));
>   	struct intel_crtc *possible_crtc;
>   	struct intel_crtc *crtc = NULL;
>   	struct drm_mode_config *config = &display->drm->mode_config;
> -	struct drm_atomic_state *state = NULL, *restore_state = NULL;
> +	struct drm_atomic_commit *state = NULL, *restore_state = NULL;
>   	struct drm_connector_state *connector_state;
>   	struct intel_crtc_state *crtc_state;
>   	int ret;
>   
>   	drm_dbg_kms(display->drm, "[CONNECTOR:%d:%s], [ENCODER:%d:%s]\n",
> @@ -116,12 +116,12 @@ intel_load_detect_get_pipe(struct drm_connector *connector,
>   		ret = -ENODEV;
>   		goto fail;
>   	}
>   
>   found:
> -	state = drm_atomic_state_alloc(display->drm);
> -	restore_state = drm_atomic_state_alloc(display->drm);
> +	state = drm_atomic_commit_alloc(display->drm);
> +	restore_state = drm_atomic_commit_alloc(display->drm);
>   	if (!state || !restore_state) {
>   		ret = -ENOMEM;
>   		goto fail;
>   	}
>   
> @@ -175,35 +175,35 @@ intel_load_detect_get_pipe(struct drm_connector *connector,
>   		drm_dbg_kms(display->drm,
>   			    "failed to set mode on load-detect pipe\n");
>   		goto fail;
>   	}
>   
> -	drm_atomic_state_put(state);
> +	drm_atomic_commit_put(state);
>   
>   	/* let the connector get through one full cycle before testing */
>   	intel_crtc_wait_for_next_vblank(crtc);
>   
>   	return restore_state;
>   
>   fail:
>   	if (state) {
> -		drm_atomic_state_put(state);
> +		drm_atomic_commit_put(state);
>   		state = NULL;
>   	}
>   	if (restore_state) {
> -		drm_atomic_state_put(restore_state);
> +		drm_atomic_commit_put(restore_state);
>   		restore_state = NULL;
>   	}
>   
>   	if (ret == -EDEADLK)
>   		return ERR_PTR(ret);
>   
>   	return NULL;
>   }
>   
>   void intel_load_detect_release_pipe(struct drm_connector *connector,
> -				    struct drm_atomic_state *state,
> +				    struct drm_atomic_commit *state,
>   				    struct drm_modeset_acquire_ctx *ctx)
>   {
>   	struct intel_display *display = to_intel_display(connector->dev);
>   	struct intel_encoder *intel_encoder =
>   		intel_attached_encoder(to_intel_connector(connector));
> @@ -219,7 +219,7 @@ void intel_load_detect_release_pipe(struct drm_connector *connector,
>   
>   	ret = drm_atomic_helper_commit_duplicated_state(state, ctx);
>   	if (ret)
>   		drm_dbg_kms(display->drm,
>   			    "Couldn't release load detect pipe: %i\n", ret);
> -	drm_atomic_state_put(state);
> +	drm_atomic_commit_put(state);
>   }
> diff --git a/drivers/gpu/drm/i915/display/intel_load_detect.h b/drivers/gpu/drm/i915/display/intel_load_detect.h
> index aed51901b9ba8951e5ab48882a85e60d00dddbc0..7525988e45b18773d29825962994ddf6d0045611 100644
> --- a/drivers/gpu/drm/i915/display/intel_load_detect.h
> +++ b/drivers/gpu/drm/i915/display/intel_load_detect.h
> @@ -4,17 +4,17 @@
>    */
>   
>   #ifndef __INTEL_LOAD_DETECT_H__
>   #define __INTEL_LOAD_DETECT_H__
>   
> -struct drm_atomic_state;
> +struct drm_atomic_commit;
>   struct drm_connector;
>   struct drm_modeset_acquire_ctx;
>   
> -struct drm_atomic_state *
> +struct drm_atomic_commit *
>   intel_load_detect_get_pipe(struct drm_connector *connector,
>   			   struct drm_modeset_acquire_ctx *ctx);
>   void intel_load_detect_release_pipe(struct drm_connector *connector,
> -				    struct drm_atomic_state *old,
> +				    struct drm_atomic_commit *old,
>   				    struct drm_modeset_acquire_ctx *ctx);
>   
>   #endif /* __INTEL_LOAD_DETECT_H__ */
> diff --git a/drivers/gpu/drm/i915/display/intel_modeset_lock.c b/drivers/gpu/drm/i915/display/intel_modeset_lock.c
> index 8fb6fd849a75db33fe0c0c2ff59ecf000f877598..eb6a5a99328b6124243a0b54d78f83d17c4862df 100644
> --- a/drivers/gpu/drm/i915/display/intel_modeset_lock.c
> +++ b/drivers/gpu/drm/i915/display/intel_modeset_lock.c
> @@ -34,11 +34,11 @@ void _intel_modeset_lock_end(struct drm_modeset_acquire_ctx *ctx,
>   			     struct intel_atomic_state *state,
>   			     int *ret)
>   {
>   	if (*ret == -EDEADLK) {
>   		if (state)
> -			drm_atomic_state_clear(&state->base);
> +			drm_atomic_commit_clear(&state->base);
>   
>   		*ret = drm_modeset_backoff(ctx);
>   		if (*ret == 0) {
>   			*ret = -EDEADLK;
>   			return;
> diff --git a/drivers/gpu/drm/i915/display/intel_modeset_setup.c b/drivers/gpu/drm/i915/display/intel_modeset_setup.c
> index 4086f16a12bf472e52f9ba2f4939acd6d7187b9a..9a0f89f1a1f2a6409a44496baf3c81b1e9308020 100644
> --- a/drivers/gpu/drm/i915/display/intel_modeset_setup.c
> +++ b/drivers/gpu/drm/i915/display/intel_modeset_setup.c
> @@ -42,11 +42,11 @@ static void intel_crtc_disable_noatomic_begin(struct intel_crtc *crtc,
>   {
>   	struct intel_display *display = to_intel_display(crtc);
>   	struct intel_crtc_state *crtc_state =
>   		to_intel_crtc_state(crtc->base.state);
>   	struct intel_plane *plane;
> -	struct drm_atomic_state *state;
> +	struct drm_atomic_commit *state;
>   	struct intel_crtc *temp_crtc;
>   	enum pipe pipe = crtc->pipe;
>   
>   	if (!crtc_state->hw.active)
>   		return;
> @@ -57,11 +57,11 @@ static void intel_crtc_disable_noatomic_begin(struct intel_crtc *crtc,
>   
>   		if (plane_state->uapi.visible)
>   			intel_plane_disable_noatomic(crtc, plane);
>   	}
>   
> -	state = drm_atomic_state_alloc(display->drm);
> +	state = drm_atomic_commit_alloc(display->drm);
>   	if (!state) {
>   		drm_dbg_kms(display->drm,
>   			    "failed to disable [CRTC:%d:%s], out of memory",
>   			    crtc->base.base.id, crtc->base.name);
>   		return;
> @@ -83,11 +83,11 @@ static void intel_crtc_disable_noatomic_begin(struct intel_crtc *crtc,
>   		drm_WARN_ON(display->drm, IS_ERR(temp_crtc_state) || ret);
>   	}
>   
>   	display->funcs.display->crtc_disable(to_intel_atomic_state(state), crtc);
>   
> -	drm_atomic_state_put(state);
> +	drm_atomic_commit_put(state);
>   
>   	drm_dbg_kms(display->drm,
>   		    "[CRTC:%d:%s] hw state adjusted, was enabled, now disabled\n",
>   		    crtc->base.base.id, crtc->base.name);
>   
> diff --git a/drivers/gpu/drm/i915/display/intel_pipe_crc.c b/drivers/gpu/drm/i915/display/intel_pipe_crc.c
> index 57586c78582dad12ca50ce49bfe998c88c9fd0c7..5434d7f823d4d87164e33a38486179f7d1dd47c1 100644
> --- a/drivers/gpu/drm/i915/display/intel_pipe_crc.c
> +++ b/drivers/gpu/drm/i915/display/intel_pipe_crc.c
> @@ -282,20 +282,20 @@ static int ilk_pipe_crc_ctl_reg(enum intel_pipe_crc_source *source,
>   static void
>   intel_crtc_crc_setup_workarounds(struct intel_crtc *crtc, bool enable)
>   {
>   	struct intel_display *display = to_intel_display(crtc);
>   	struct intel_crtc_state *pipe_config;
> -	struct drm_atomic_state *state;
> +	struct drm_atomic_commit *state;
>   	struct drm_modeset_acquire_ctx ctx;
>   	int ret;
>   
>   	if (display->platform.i945gm || display->platform.i915gm)
>   		i915gm_irq_cstate_wa(display, enable);
>   
>   	drm_modeset_acquire_init(&ctx, 0);
>   
> -	state = drm_atomic_state_alloc(display->drm);
> +	state = drm_atomic_commit_alloc(display->drm);
>   	if (!state) {
>   		ret = -ENOMEM;
>   		goto unlock;
>   	}
>   
> @@ -319,16 +319,16 @@ intel_crtc_crc_setup_workarounds(struct intel_crtc *crtc, bool enable)
>   
>   	ret = drm_atomic_commit(state);
>   
>   put_state:
>   	if (ret == -EDEADLK) {
> -		drm_atomic_state_clear(state);
> +		drm_atomic_commit_clear(state);
>   		drm_modeset_backoff(&ctx);
>   		goto retry;
>   	}
>   
> -	drm_atomic_state_put(state);
> +	drm_atomic_commit_put(state);
>   unlock:
>   	drm_WARN(display->drm, ret,
>   		 "Toggling workaround to %i returns %i\n", enable, ret);
>   	drm_modeset_drop_locks(&ctx);
>   	drm_modeset_acquire_fini(&ctx);
> diff --git a/drivers/gpu/drm/i915/display/intel_plane.c b/drivers/gpu/drm/i915/display/intel_plane.c
> index 5390ceb21ca42fe5dc64f1458fc0e31653422731..99b0c8325dba620c1dfdae463bd339eb3d960766 100644
> --- a/drivers/gpu/drm/i915/display/intel_plane.c
> +++ b/drivers/gpu/drm/i915/display/intel_plane.c
> @@ -362,11 +362,11 @@ intel_plane_color_copy_uapi_to_hw_state(struct intel_plane_state *plane_state,
>   					const struct intel_plane_state *from_plane_state,
>   					struct intel_crtc *crtc)
>   {
>   	struct drm_colorop *iter_colorop, *colorop;
>   	struct drm_colorop_state *new_colorop_state;
> -	struct drm_atomic_state *state = plane_state->uapi.state;
> +	struct drm_atomic_commit *state = plane_state->uapi.state;
>   	struct intel_colorop *intel_colorop;
>   	struct drm_property_blob *blob;
>   	struct intel_atomic_state *intel_atomic_state = to_intel_atomic_state(state);
>   	struct intel_crtc_state *new_crtc_state = intel_atomic_state ?
>   		intel_atomic_get_new_crtc_state(intel_atomic_state, crtc) : NULL;
> diff --git a/drivers/gpu/drm/i915/display/intel_psr.c b/drivers/gpu/drm/i915/display/intel_psr.c
> index b319e5bd62747de8bf84854c71ca9dadf8b9864b..df1a0c0d94e93a4afc79bffdd17d4cb29a3527fe 100644
> --- a/drivers/gpu/drm/i915/display/intel_psr.c
> +++ b/drivers/gpu/drm/i915/display/intel_psr.c
> @@ -3347,15 +3347,15 @@ static bool __psr_wait_for_idle_locked(struct intel_dp *intel_dp)
>   
>   static int intel_psr_fastset_force(struct intel_display *display)
>   {
>   	struct drm_connector_list_iter conn_iter;
>   	struct drm_modeset_acquire_ctx ctx;
> -	struct drm_atomic_state *state;
> +	struct drm_atomic_commit *state;
>   	struct drm_connector *conn;
>   	int err = 0;
>   
> -	state = drm_atomic_state_alloc(display->drm);
> +	state = drm_atomic_commit_alloc(display->drm);
>   	if (!state)
>   		return -ENOMEM;
>   
>   	drm_modeset_acquire_init(&ctx, DRM_MODESET_ACQUIRE_INTERRUPTIBLE);
>   
> @@ -3393,19 +3393,19 @@ static int intel_psr_fastset_force(struct intel_display *display)
>   
>   	if (err == 0)
>   		err = drm_atomic_commit(state);
>   
>   	if (err == -EDEADLK) {
> -		drm_atomic_state_clear(state);
> +		drm_atomic_commit_clear(state);
>   		err = drm_modeset_backoff(&ctx);
>   		if (!err)
>   			goto retry;
>   	}
>   
>   	drm_modeset_drop_locks(&ctx);
>   	drm_modeset_acquire_fini(&ctx);
> -	drm_atomic_state_put(state);
> +	drm_atomic_commit_put(state);
>   
>   	return err;
>   }
>   
>   int intel_psr_debug_set(struct intel_dp *intel_dp, u64 val)
> diff --git a/drivers/gpu/drm/i915/display/intel_sdvo.c b/drivers/gpu/drm/i915/display/intel_sdvo.c
> index 2e1af9e869ded3f50437cb77cb42ce5c4324174c..db90a0a651c87c0414f924d1d93b15ffa9db2cb1 100644
> --- a/drivers/gpu/drm/i915/display/intel_sdvo.c
> +++ b/drivers/gpu/drm/i915/display/intel_sdvo.c
> @@ -2510,11 +2510,11 @@ static const struct drm_connector_funcs intel_sdvo_connector_funcs = {
>   	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
>   	.atomic_duplicate_state = intel_sdvo_connector_duplicate_state,
>   };
>   
>   static int intel_sdvo_atomic_check(struct drm_connector *conn,
> -				   struct drm_atomic_state *state)
> +				   struct drm_atomic_commit *state)
>   {
>   	struct drm_connector_state *new_conn_state =
>   		drm_atomic_get_new_connector_state(state, conn);
>   	struct drm_connector_state *old_conn_state =
>   		drm_atomic_get_old_connector_state(state, conn);
> diff --git a/drivers/gpu/drm/i915/display/intel_sprite_uapi.c b/drivers/gpu/drm/i915/display/intel_sprite_uapi.c
> index 4981cc34da05f0ecbc4287076a0362331e4ef7f7..a62146133f99044bbc9b45eb8072745259300254 100644
> --- a/drivers/gpu/drm/i915/display/intel_sprite_uapi.c
> +++ b/drivers/gpu/drm/i915/display/intel_sprite_uapi.c
> @@ -44,11 +44,11 @@ int intel_sprite_set_colorkey_ioctl(struct drm_device *dev, void *data,
>   {
>   	struct intel_display *display = to_intel_display(dev);
>   	struct drm_intel_sprite_colorkey *set = data;
>   	struct drm_plane *plane;
>   	struct drm_plane_state *plane_state;
> -	struct drm_atomic_state *state;
> +	struct drm_atomic_commit *state;
>   	struct drm_modeset_acquire_ctx ctx;
>   	int ret = 0;
>   
>   	/* ignore the pointless "none" flag */
>   	set->flags &= ~I915_SET_COLORKEY_NONE;
> @@ -78,11 +78,11 @@ int intel_sprite_set_colorkey_ioctl(struct drm_device *dev, void *data,
>   	    set->flags & I915_SET_COLORKEY_DESTINATION)
>   		return -EINVAL;
>   
>   	drm_modeset_acquire_init(&ctx, 0);
>   
> -	state = drm_atomic_state_alloc(plane->dev);
> +	state = drm_atomic_commit_alloc(plane->dev);
>   	if (!state) {
>   		ret = -ENOMEM;
>   		goto out;
>   	}
>   	state->acquire_ctx = &ctx;
> @@ -114,15 +114,15 @@ int intel_sprite_set_colorkey_ioctl(struct drm_device *dev, void *data,
>   			ret = drm_atomic_commit(state);
>   
>   		if (ret != -EDEADLK)
>   			break;
>   
> -		drm_atomic_state_clear(state);
> +		drm_atomic_commit_clear(state);
>   		drm_modeset_backoff(&ctx);
>   	}
>   
> -	drm_atomic_state_put(state);
> +	drm_atomic_commit_put(state);
>   out:
>   	drm_modeset_drop_locks(&ctx);
>   	drm_modeset_acquire_fini(&ctx);
>   	return ret;
>   }
> diff --git a/drivers/gpu/drm/i915/display/intel_tc.c b/drivers/gpu/drm/i915/display/intel_tc.c
> index a21dd4e3fe4caab814c6d290fcc5d2e84e804195..fc0d470fe9491d559c14f5391076d3b7877dfcc2 100644
> --- a/drivers/gpu/drm/i915/display/intel_tc.c
> +++ b/drivers/gpu/drm/i915/display/intel_tc.c
> @@ -1797,25 +1797,25 @@ static int reset_link_commit(struct intel_tc_port *tc,
>   
>   static int reset_link(struct intel_tc_port *tc)
>   {
>   	struct intel_display *display = to_intel_display(tc->dig_port);
>   	struct drm_modeset_acquire_ctx ctx;
> -	struct drm_atomic_state *_state;
> +	struct drm_atomic_commit *_state;
>   	struct intel_atomic_state *state;
>   	int ret;
>   
> -	_state = drm_atomic_state_alloc(display->drm);
> +	_state = drm_atomic_commit_alloc(display->drm);
>   	if (!_state)
>   		return -ENOMEM;
>   
>   	state = to_intel_atomic_state(_state);
>   	state->internal = true;
>   
>   	intel_modeset_lock_ctx_retry(&ctx, state, 0, ret)
>   		ret = reset_link_commit(tc, state, &ctx);
>   
> -	drm_atomic_state_put(&state->base);
> +	drm_atomic_commit_put(&state->base);
>   
>   	return ret;
>   }
>   
>   static void intel_tc_port_link_reset_work(struct work_struct *work)
> diff --git a/drivers/gpu/drm/i915/display/intel_tv.c b/drivers/gpu/drm/i915/display/intel_tv.c
> index 8fbf0adb569925f2645448684c556fbb868bd0c0..0a926c6f25f46281cf41290fad0255f593f834cc 100644
> --- a/drivers/gpu/drm/i915/display/intel_tv.c
> +++ b/drivers/gpu/drm/i915/display/intel_tv.c
> @@ -1722,11 +1722,11 @@ intel_tv_detect(struct drm_connector *connector,
>   
>   	if (!intel_display_driver_check_access(display))
>   		return connector->status;
>   
>   	if (force) {
> -		struct drm_atomic_state *state;
> +		struct drm_atomic_commit *state;
>   
>   		state = intel_load_detect_get_pipe(connector, ctx);
>   		if (IS_ERR(state))
>   			return PTR_ERR(state);
>   
> @@ -1845,11 +1845,11 @@ static const struct drm_connector_funcs intel_tv_connector_funcs = {
>   	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
>   	.atomic_duplicate_state = intel_tv_connector_duplicate_state,
>   };
>   
>   static int intel_tv_atomic_check(struct drm_connector *connector,
> -				 struct drm_atomic_state *state)
> +				 struct drm_atomic_commit *state)
>   {
>   	struct drm_connector_state *new_state;
>   	struct drm_crtc_state *new_crtc_state;
>   	struct drm_connector_state *old_state;
>   
> diff --git a/drivers/gpu/drm/imx/dc/dc-crtc.c b/drivers/gpu/drm/imx/dc/dc-crtc.c
> index 608c610662dce741f0adf98a54196769d5dfc1b0..764510ff90a4a93fd4a7c94b6c486baa9b7abf34 100644
> --- a/drivers/gpu/drm/imx/dc/dc-crtc.c
> +++ b/drivers/gpu/drm/imx/dc/dc-crtc.c
> @@ -146,11 +146,11 @@ dc_crtc_mode_valid(struct drm_crtc *crtc, const struct drm_display_mode *mode)
>   
>   	return MODE_OK;
>   }
>   
>   static int
> -dc_crtc_atomic_check(struct drm_crtc *crtc, struct drm_atomic_state *state)
> +dc_crtc_atomic_check(struct drm_crtc *crtc, struct drm_atomic_commit *state)
>   {
>   	struct drm_crtc_state *new_crtc_state =
>   				drm_atomic_get_new_crtc_state(state, crtc);
>   	struct drm_display_mode *adj = &new_crtc_state->adjusted_mode;
>   	struct dc_crtc *dc_crtc = to_dc_crtc(crtc);
> @@ -162,11 +162,11 @@ dc_crtc_atomic_check(struct drm_crtc *crtc, struct drm_atomic_state *state)
>   
>   	return 0;
>   }
>   
>   static void
> -dc_crtc_atomic_begin(struct drm_crtc *crtc, struct drm_atomic_state *state)
> +dc_crtc_atomic_begin(struct drm_crtc *crtc, struct drm_atomic_commit *state)
>   {
>   	struct drm_crtc_state *new_crtc_state =
>   				drm_atomic_get_new_crtc_state(state, crtc);
>   	struct dc_drm_device *dc_drm = to_dc_drm_device(crtc->dev);
>   	int idx, ret;
> @@ -186,11 +186,11 @@ dc_crtc_atomic_begin(struct drm_crtc *crtc, struct drm_atomic_state *state)
>   
>   	drm_dev_exit(idx);
>   }
>   
>   static void
> -dc_crtc_atomic_flush(struct drm_crtc *crtc, struct drm_atomic_state *state)
> +dc_crtc_atomic_flush(struct drm_crtc *crtc, struct drm_atomic_commit *state)
>   {
>   	struct drm_crtc_state *old_crtc_state =
>   				drm_atomic_get_old_crtc_state(state, crtc);
>   	struct drm_crtc_state *new_crtc_state =
>   				drm_atomic_get_new_crtc_state(state, crtc);
> @@ -220,11 +220,11 @@ dc_crtc_atomic_flush(struct drm_crtc *crtc, struct drm_atomic_state *state)
>   out:
>   	dc_crtc_queue_state_event(new_crtc_state);
>   }
>   
>   static void
> -dc_crtc_atomic_enable(struct drm_crtc *crtc, struct drm_atomic_state *state)
> +dc_crtc_atomic_enable(struct drm_crtc *crtc, struct drm_atomic_commit *state)
>   {
>   	struct drm_crtc_state *new_crtc_state =
>   				drm_atomic_get_new_crtc_state(state, crtc);
>   	struct drm_display_mode *adj = &new_crtc_state->adjusted_mode;
>   	struct dc_crtc *dc_crtc = to_dc_crtc(crtc);
> @@ -292,11 +292,11 @@ dc_crtc_atomic_enable(struct drm_crtc *crtc, struct drm_atomic_state *state)
>   out:
>   	dc_crtc_queue_state_event(new_crtc_state);
>   }
>   
>   static void
> -dc_crtc_atomic_disable(struct drm_crtc *crtc, struct drm_atomic_state *state)
> +dc_crtc_atomic_disable(struct drm_crtc *crtc, struct drm_atomic_commit *state)
>   {
>   	struct drm_crtc_state *new_crtc_state =
>   				drm_atomic_get_new_crtc_state(state, crtc);
>   	struct dc_drm_device *dc_drm = to_dc_drm_device(crtc->dev);
>   	struct dc_crtc *dc_crtc = to_dc_crtc(crtc);
> diff --git a/drivers/gpu/drm/imx/dc/dc-plane.c b/drivers/gpu/drm/imx/dc/dc-plane.c
> index e40d5d66c5c1f0d579a7a1019c0f2e00489ce15e..dea7404fe6590e2adfe8bce6507918d1da3eb134 100644
> --- a/drivers/gpu/drm/imx/dc/dc-plane.c
> +++ b/drivers/gpu/drm/imx/dc/dc-plane.c
> @@ -87,11 +87,11 @@ static int dc_plane_check_fb(struct drm_plane_state *state)
>   
>   	return 0;
>   }
>   
>   static int
> -dc_plane_atomic_check(struct drm_plane *plane, struct drm_atomic_state *state)
> +dc_plane_atomic_check(struct drm_plane *plane, struct drm_atomic_commit *state)
>   {
>   	struct drm_plane_state *plane_state =
>   				drm_atomic_get_new_plane_state(state, plane);
>   	struct drm_crtc_state *crtc_state;
>   	int ret;
> @@ -125,11 +125,11 @@ dc_plane_atomic_check(struct drm_plane *plane, struct drm_atomic_state *state)
>   
>   	return dc_plane_check_fb(plane_state);
>   }
>   
>   static void
> -dc_plane_atomic_update(struct drm_plane *plane, struct drm_atomic_state *state)
> +dc_plane_atomic_update(struct drm_plane *plane, struct drm_atomic_commit *state)
>   {
>   	struct drm_plane_state *new_state =
>   				drm_atomic_get_new_plane_state(state, plane);
>   	struct dc_plane *dplane = to_dc_plane(plane);
>   	struct drm_framebuffer *fb = new_state->fb;
> @@ -174,11 +174,11 @@ dc_plane_atomic_update(struct drm_plane *plane, struct drm_atomic_state *state)
>   
>   	drm_dev_exit(idx);
>   }
>   
>   static void dc_plane_atomic_disable(struct drm_plane *plane,
> -				    struct drm_atomic_state *state)
> +				    struct drm_atomic_commit *state)
>   {
>   	struct dc_plane *dplane = to_dc_plane(plane);
>   	const struct dc_fu_ops *fu_ops;
>   	int idx;
>   
> diff --git a/drivers/gpu/drm/imx/dcss/dcss-crtc.c b/drivers/gpu/drm/imx/dcss/dcss-crtc.c
> index af91e45b5d13b72cf2609d101abdc7e34d848bc8..ab41759a9f52d25077180db35dd18777ce5abb64 100644
> --- a/drivers/gpu/drm/imx/dcss/dcss-crtc.c
> +++ b/drivers/gpu/drm/imx/dcss/dcss-crtc.c
> @@ -51,17 +51,17 @@ static const struct drm_crtc_funcs dcss_crtc_funcs = {
>   	.enable_vblank = dcss_enable_vblank,
>   	.disable_vblank = dcss_disable_vblank,
>   };
>   
>   static void dcss_crtc_atomic_begin(struct drm_crtc *crtc,
> -				   struct drm_atomic_state *state)
> +				   struct drm_atomic_commit *state)
>   {
>   	drm_crtc_vblank_on(crtc);
>   }
>   
>   static void dcss_crtc_atomic_flush(struct drm_crtc *crtc,
> -				   struct drm_atomic_state *state)
> +				   struct drm_atomic_commit *state)
>   {
>   	struct dcss_crtc *dcss_crtc = container_of(crtc, struct dcss_crtc,
>   						   base);
>   	struct dcss_dev *dcss = dcss_crtc->base.dev->dev_private;
>   
> @@ -76,11 +76,11 @@ static void dcss_crtc_atomic_flush(struct drm_crtc *crtc,
>   	if (dcss_dtg_is_enabled(dcss->dtg))
>   		dcss_ctxld_enable(dcss->ctxld);
>   }
>   
>   static void dcss_crtc_atomic_enable(struct drm_crtc *crtc,
> -				    struct drm_atomic_state *state)
> +				    struct drm_atomic_commit *state)
>   {
>   	struct drm_crtc_state *old_crtc_state = drm_atomic_get_old_crtc_state(state,
>   									      crtc);
>   	struct dcss_crtc *dcss_crtc = container_of(crtc, struct dcss_crtc,
>   						   base);
> @@ -112,11 +112,11 @@ static void dcss_crtc_atomic_enable(struct drm_crtc *crtc,
>   	/* Allow CTXLD kick interrupt to be disabled when VBLANK is disabled. */
>   	dcss_crtc->disable_ctxld_kick_irq = true;
>   }
>   
>   static void dcss_crtc_atomic_disable(struct drm_crtc *crtc,
> -				     struct drm_atomic_state *state)
> +				     struct drm_atomic_commit *state)
>   {
>   	struct drm_crtc_state *old_crtc_state = drm_atomic_get_old_crtc_state(state,
>   									      crtc);
>   	struct dcss_crtc *dcss_crtc = container_of(crtc, struct dcss_crtc,
>   						   base);
> diff --git a/drivers/gpu/drm/imx/dcss/dcss-plane.c b/drivers/gpu/drm/imx/dcss/dcss-plane.c
> index c014ef70dfd16d816175afd715219b7c15afda00..1746dc5d4b64223314eb8ad4606bb2e29b449aea 100644
> --- a/drivers/gpu/drm/imx/dcss/dcss-plane.c
> +++ b/drivers/gpu/drm/imx/dcss/dcss-plane.c
> @@ -138,11 +138,11 @@ static bool dcss_plane_is_source_size_allowed(u16 src_w, u16 src_h, u32 pix_fmt)
>   
>   	return src_w >= 16 && src_h >= 8;
>   }
>   
>   static int dcss_plane_atomic_check(struct drm_plane *plane,
> -				   struct drm_atomic_state *state)
> +				   struct drm_atomic_commit *state)
>   {
>   	struct drm_plane_state *new_plane_state = drm_atomic_get_new_plane_state(state,
>   										 plane);
>   	struct dcss_plane *dcss_plane = to_dcss_plane(plane);
>   	struct dcss_dev *dcss = plane->dev->dev_private;
> @@ -265,11 +265,11 @@ static bool dcss_plane_needs_setup(struct drm_plane_state *state,
>   	       state->rotation != old_state->rotation ||
>   	       state->scaling_filter != old_state->scaling_filter;
>   }
>   
>   static void dcss_plane_atomic_update(struct drm_plane *plane,
> -				     struct drm_atomic_state *state)
> +				     struct drm_atomic_commit *state)
>   {
>   	struct drm_plane_state *old_state = drm_atomic_get_old_plane_state(state,
>   									   plane);
>   	struct drm_plane_state *new_state = drm_atomic_get_new_plane_state(state,
>   									   plane);
> @@ -350,11 +350,11 @@ static void dcss_plane_atomic_update(struct drm_plane *plane,
>   
>   	dcss_dtg_ch_enable(dcss->dtg, dcss_plane->ch_num, enable);
>   }
>   
>   static void dcss_plane_atomic_disable(struct drm_plane *plane,
> -				      struct drm_atomic_state *state)
> +				      struct drm_atomic_commit *state)
>   {
>   	struct dcss_plane *dcss_plane = to_dcss_plane(plane);
>   	struct dcss_dev *dcss = plane->dev->dev_private;
>   
>   	dcss_dpr_enable(dcss->dpr, dcss_plane->ch_num, false);
> diff --git a/drivers/gpu/drm/imx/ipuv3/imx-drm-core.c b/drivers/gpu/drm/imx/ipuv3/imx-drm-core.c
> index eddb471119c66fd48f0b7306a91ceb490298cc20..51a0ec043248462beca3b9ae462613c0a347fb21 100644
> --- a/drivers/gpu/drm/imx/ipuv3/imx-drm-core.c
> +++ b/drivers/gpu/drm/imx/ipuv3/imx-drm-core.c
> @@ -36,11 +36,11 @@ static int legacyfb_depth = 16;
>   module_param(legacyfb_depth, int, 0444);
>   
>   DEFINE_DRM_GEM_DMA_FOPS(imx_drm_driver_fops);
>   
>   static int imx_drm_atomic_check(struct drm_device *dev,
> -				struct drm_atomic_state *state)
> +				struct drm_atomic_commit *state)
>   {
>   	int ret;
>   
>   	ret = drm_atomic_helper_check(dev, state);
>   	if (ret)
> @@ -66,11 +66,11 @@ static const struct drm_mode_config_funcs imx_drm_mode_config_funcs = {
>   	.fb_create = drm_gem_fb_create,
>   	.atomic_check = imx_drm_atomic_check,
>   	.atomic_commit = drm_atomic_helper_commit,
>   };
>   
> -static void imx_drm_atomic_commit_tail(struct drm_atomic_state *state)
> +static void imx_drm_atomic_commit_tail(struct drm_atomic_commit *state)
>   {
>   	struct drm_device *dev = state->dev;
>   	struct drm_plane *plane;
>   	struct drm_plane_state *old_plane_state, *new_plane_state;
>   	bool plane_disabling = false;
> diff --git a/drivers/gpu/drm/imx/ipuv3/imx-drm.h b/drivers/gpu/drm/imx/ipuv3/imx-drm.h
> index 0c85bf83ffbff96d038ebdd5b011ab53e72b4738..2c0f4bd2569b10762c99f65277133f39727e3849 100644
> --- a/drivers/gpu/drm/imx/ipuv3/imx-drm.h
> +++ b/drivers/gpu/drm/imx/ipuv3/imx-drm.h
> @@ -24,8 +24,8 @@ extern struct platform_driver ipu_drm_driver;
>   
>   int imx_drm_encoder_parse_of(struct drm_device *drm,
>   	struct drm_encoder *encoder, struct device_node *np);
>   
>   int ipu_planes_assign_pre(struct drm_device *dev,
> -			  struct drm_atomic_state *state);
> +			  struct drm_atomic_commit *state);
>   
>   #endif /* _IMX_DRM_H_ */
> diff --git a/drivers/gpu/drm/imx/ipuv3/ipuv3-crtc.c b/drivers/gpu/drm/imx/ipuv3/ipuv3-crtc.c
> index a18b9d1a68b6c7ae4ce9026b082b809dbe0462bb..1405e50ee56b5e1b2184f55f966b2846fe8cc4f3 100644
> --- a/drivers/gpu/drm/imx/ipuv3/ipuv3-crtc.c
> +++ b/drivers/gpu/drm/imx/ipuv3/ipuv3-crtc.c
> @@ -45,11 +45,11 @@ static inline struct ipu_crtc *to_ipu_crtc(struct drm_crtc *crtc)
>   {
>   	return container_of(crtc, struct ipu_crtc, base);
>   }
>   
>   static void ipu_crtc_atomic_enable(struct drm_crtc *crtc,
> -				   struct drm_atomic_state *state)
> +				   struct drm_atomic_commit *state)
>   {
>   	struct ipu_crtc *ipu_crtc = to_ipu_crtc(crtc);
>   	struct ipu_soc *ipu = dev_get_drvdata(ipu_crtc->dev->parent);
>   
>   	ipu_prg_enable(ipu);
> @@ -77,11 +77,11 @@ static void ipu_crtc_disable_planes(struct ipu_crtc *ipu_crtc,
>   	if (disable_full)
>   		ipu_plane_disable(ipu_crtc->plane[0], true);
>   }
>   
>   static void ipu_crtc_atomic_disable(struct drm_crtc *crtc,
> -				    struct drm_atomic_state *state)
> +				    struct drm_atomic_commit *state)
>   {
>   	struct drm_crtc_state *old_crtc_state = drm_atomic_get_old_crtc_state(state,
>   									      crtc);
>   	struct ipu_crtc *ipu_crtc = to_ipu_crtc(crtc);
>   	struct ipu_soc *ipu = dev_get_drvdata(ipu_crtc->dev->parent);
> @@ -224,11 +224,11 @@ static bool ipu_crtc_mode_fixup(struct drm_crtc *crtc,
>   
>   	return true;
>   }
>   
>   static int ipu_crtc_atomic_check(struct drm_crtc *crtc,
> -				 struct drm_atomic_state *state)
> +				 struct drm_atomic_commit *state)
>   {
>   	struct drm_crtc_state *crtc_state = drm_atomic_get_new_crtc_state(state,
>   									  crtc);
>   	u32 primary_plane_mask = drm_plane_mask(crtc->primary);
>   
> @@ -237,17 +237,17 @@ static int ipu_crtc_atomic_check(struct drm_crtc *crtc,
>   
>   	return 0;
>   }
>   
>   static void ipu_crtc_atomic_begin(struct drm_crtc *crtc,
> -				  struct drm_atomic_state *state)
> +				  struct drm_atomic_commit *state)
>   {
>   	drm_crtc_vblank_on(crtc);
>   }
>   
>   static void ipu_crtc_atomic_flush(struct drm_crtc *crtc,
> -				  struct drm_atomic_state *state)
> +				  struct drm_atomic_commit *state)
>   {
>   	spin_lock_irq(&crtc->dev->event_lock);
>   	if (crtc->state->event) {
>   		struct ipu_crtc *ipu_crtc = to_ipu_crtc(crtc);
>   
> diff --git a/drivers/gpu/drm/imx/ipuv3/ipuv3-plane.c b/drivers/gpu/drm/imx/ipuv3/ipuv3-plane.c
> index c1c7be4e26c64dc53ac818d5dd77aaf543cefd37..c7ec09e557c19ff1fc68dbdb644204a1b8e42a90 100644
> --- a/drivers/gpu/drm/imx/ipuv3/ipuv3-plane.c
> +++ b/drivers/gpu/drm/imx/ipuv3/ipuv3-plane.c
> @@ -363,11 +363,11 @@ static const struct drm_plane_funcs ipu_plane_funcs = {
>   	.atomic_destroy_state	= ipu_plane_destroy_state,
>   	.format_mod_supported = ipu_plane_format_mod_supported,
>   };
>   
>   static int ipu_plane_atomic_check(struct drm_plane *plane,
> -				  struct drm_atomic_state *state)
> +				  struct drm_atomic_commit *state)
>   {
>   	struct drm_plane_state *new_state = drm_atomic_get_new_plane_state(state,
>   									   plane);
>   	struct drm_plane_state *old_state = drm_atomic_get_old_plane_state(state,
>   									   plane);
> @@ -525,11 +525,11 @@ static int ipu_plane_atomic_check(struct drm_plane *plane,
>   
>   	return 0;
>   }
>   
>   static void ipu_plane_atomic_disable(struct drm_plane *plane,
> -				     struct drm_atomic_state *state)
> +				     struct drm_atomic_commit *state)
>   {
>   	struct ipu_plane *ipu_plane = to_ipu_plane(plane);
>   
>   	if (ipu_plane->dp)
>   		ipu_dp_disable_channel(ipu_plane->dp, true);
> @@ -570,11 +570,11 @@ static void ipu_calculate_bursts(u32 width, u32 cpp, u32 stride,
>   	}
>   	*num_bursts = bursts;
>   }
>   
>   static void ipu_plane_atomic_update(struct drm_plane *plane,
> -				    struct drm_atomic_state *state)
> +				    struct drm_atomic_commit *state)
>   {
>   	struct drm_plane_state *old_state = drm_atomic_get_old_plane_state(state,
>   									   plane);
>   	struct ipu_plane *ipu_plane = to_ipu_plane(plane);
>   	struct drm_plane_state *new_state = drm_atomic_get_new_plane_state(state,
> @@ -802,11 +802,11 @@ bool ipu_plane_atomic_update_pending(struct drm_plane *plane)
>   	 * executed.
>   	 */
>   	return false;
>   }
>   int ipu_planes_assign_pre(struct drm_device *dev,
> -			  struct drm_atomic_state *state)
> +			  struct drm_atomic_commit *state)
>   {
>   	struct drm_crtc_state *old_crtc_state, *crtc_state;
>   	struct drm_plane_state *plane_state;
>   	struct ipu_plane_state *ipu_state;
>   	struct ipu_plane *ipu_plane;
> diff --git a/drivers/gpu/drm/ingenic/ingenic-drm-drv.c b/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
> index 4068114adf8c2068a94a3aaa308cf91847712acb..2350c9499aef3e226fd3dbc087e20b2634db2c41 100644
> --- a/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
> +++ b/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
> @@ -138,11 +138,11 @@ to_ingenic_drm_priv_state(struct drm_private_state *state)
>   {
>   	return container_of(state, struct ingenic_drm_private_state, base);
>   }
>   
>   static struct ingenic_drm_private_state *
> -ingenic_drm_get_priv_state(struct ingenic_drm *priv, struct drm_atomic_state *state)
> +ingenic_drm_get_priv_state(struct ingenic_drm *priv, struct drm_atomic_commit *state)
>   {
>   	struct drm_private_state *priv_state;
>   
>   	priv_state = drm_atomic_get_private_obj_state(state, &priv->private_obj);
>   	if (IS_ERR(priv_state))
> @@ -150,11 +150,11 @@ ingenic_drm_get_priv_state(struct ingenic_drm *priv, struct drm_atomic_state *st
>   
>   	return to_ingenic_drm_priv_state(priv_state);
>   }
>   
>   static struct ingenic_drm_private_state *
> -ingenic_drm_get_new_priv_state(struct ingenic_drm *priv, struct drm_atomic_state *state)
> +ingenic_drm_get_new_priv_state(struct ingenic_drm *priv, struct drm_atomic_commit *state)
>   {
>   	struct drm_private_state *priv_state;
>   
>   	priv_state = drm_atomic_get_new_private_obj_state(state, &priv->private_obj);
>   	if (!priv_state)
> @@ -227,11 +227,11 @@ static int ingenic_drm_update_pixclk(struct notifier_block *nb,
>   		return NOTIFY_OK;
>   	}
>   }
>   
>   static void ingenic_drm_bridge_atomic_enable(struct drm_bridge *bridge,
> -					     struct drm_atomic_state *state)
> +					     struct drm_atomic_commit *state)
>   {
>   	struct ingenic_drm *priv = drm_device_get_priv(bridge->dev);
>   
>   	regmap_write(priv->map, JZ_REG_LCD_STATE, 0);
>   
> @@ -239,11 +239,11 @@ static void ingenic_drm_bridge_atomic_enable(struct drm_bridge *bridge,
>   			   JZ_LCD_CTRL_ENABLE | JZ_LCD_CTRL_DISABLE,
>   			   JZ_LCD_CTRL_ENABLE);
>   }
>   
>   static void ingenic_drm_crtc_atomic_enable(struct drm_crtc *crtc,
> -					   struct drm_atomic_state *state)
> +					   struct drm_atomic_commit *state)
>   {
>   	struct ingenic_drm *priv = drm_crtc_get_priv(crtc);
>   	struct ingenic_drm_private_state *priv_state;
>   	unsigned int next_id;
>   
> @@ -258,11 +258,11 @@ static void ingenic_drm_crtc_atomic_enable(struct drm_crtc *crtc,
>   
>   	drm_crtc_vblank_on(crtc);
>   }
>   
>   static void ingenic_drm_bridge_atomic_disable(struct drm_bridge *bridge,
> -					      struct drm_atomic_state *state)
> +					      struct drm_atomic_commit *state)
>   {
>   	struct ingenic_drm *priv = drm_device_get_priv(bridge->dev);
>   	unsigned int var;
>   
>   	regmap_update_bits(priv->map, JZ_REG_LCD_CTRL,
> @@ -272,11 +272,11 @@ static void ingenic_drm_bridge_atomic_disable(struct drm_bridge *bridge,
>   				 var & JZ_LCD_STATE_DISABLED,
>   				 1000, 0);
>   }
>   
>   static void ingenic_drm_crtc_atomic_disable(struct drm_crtc *crtc,
> -					    struct drm_atomic_state *state)
> +					    struct drm_atomic_commit *state)
>   {
>   	drm_crtc_vblank_off(crtc);
>   }
>   
>   static void ingenic_drm_crtc_update_timings(struct ingenic_drm *priv,
> @@ -332,11 +332,11 @@ static void ingenic_drm_crtc_update_timings(struct ingenic_drm *priv,
>   	regmap_write(priv->map, JZ_REG_LCD_IPUR, JZ_LCD_IPUR_IPUREN |
>   		     (ht * vpe / 3) << JZ_LCD_IPUR_IPUR_LSB);
>   }
>   
>   static int ingenic_drm_crtc_atomic_check(struct drm_crtc *crtc,
> -					 struct drm_atomic_state *state)
> +					 struct drm_atomic_commit *state)
>   {
>   	struct drm_crtc_state *crtc_state = drm_atomic_get_new_crtc_state(state,
>   									  crtc);
>   	struct ingenic_drm *priv = drm_crtc_get_priv(crtc);
>   	struct drm_plane_state *f1_state, *f0_state, *ipu_state = NULL;
> @@ -402,11 +402,11 @@ ingenic_drm_crtc_mode_valid(struct drm_crtc *crtc, const struct drm_display_mode
>   
>   	return MODE_OK;
>   }
>   
>   static void ingenic_drm_crtc_atomic_begin(struct drm_crtc *crtc,
> -					  struct drm_atomic_state *state)
> +					  struct drm_atomic_commit *state)
>   {
>   	struct drm_crtc_state *crtc_state = drm_atomic_get_new_crtc_state(state,
>   									  crtc);
>   	struct ingenic_drm *priv = drm_crtc_get_priv(crtc);
>   	u32 ctrl = 0;
> @@ -424,11 +424,11 @@ static void ingenic_drm_crtc_atomic_begin(struct drm_crtc *crtc,
>   				   JZ_LCD_OSDCTRL_IPU, ctrl);
>   	}
>   }
>   
>   static void ingenic_drm_crtc_atomic_flush(struct drm_crtc *crtc,
> -					  struct drm_atomic_state *state)
> +					  struct drm_atomic_commit *state)
>   {
>   	struct ingenic_drm *priv = drm_crtc_get_priv(crtc);
>   	struct drm_crtc_state *crtc_state = drm_atomic_get_new_crtc_state(state,
>   									  crtc);
>   	struct drm_pending_vblank_event *event = crtc_state->event;
> @@ -457,11 +457,11 @@ static void ingenic_drm_crtc_atomic_flush(struct drm_crtc *crtc,
>   		spin_unlock_irq(&crtc->dev->event_lock);
>   	}
>   }
>   
>   static int ingenic_drm_plane_atomic_check(struct drm_plane *plane,
> -					  struct drm_atomic_state *state)
> +					  struct drm_atomic_commit *state)
>   {
>   	struct drm_plane_state *old_plane_state = drm_atomic_get_old_plane_state(state,
>   										 plane);
>   	struct drm_plane_state *new_plane_state = drm_atomic_get_new_plane_state(state,
>   										 plane);
> @@ -554,11 +554,11 @@ void ingenic_drm_plane_disable(struct device *dev, struct drm_plane *plane)
>   		regmap_clear_bits(priv->map, JZ_REG_LCD_OSDC, en_bit);
>   	}
>   }
>   
>   static void ingenic_drm_plane_atomic_disable(struct drm_plane *plane,
> -					     struct drm_atomic_state *state)
> +					     struct drm_atomic_commit *state)
>   {
>   	struct ingenic_drm *priv = drm_device_get_priv(plane->dev);
>   
>   	ingenic_drm_plane_disable(priv->dev, plane);
>   }
> @@ -658,11 +658,11 @@ static void ingenic_drm_update_palette(struct ingenic_drm *priv,
>   		priv->dma_hwdescs->palette[i] = color;
>   	}
>   }
>   
>   static void ingenic_drm_plane_atomic_update(struct drm_plane *plane,
> -					    struct drm_atomic_state *state)
> +					    struct drm_atomic_commit *state)
>   {
>   	struct ingenic_drm *priv = drm_device_get_priv(plane->dev);
>   	struct drm_plane_state *newstate = drm_atomic_get_new_plane_state(state, plane);
>   	struct drm_plane_state *oldstate = drm_atomic_get_old_plane_state(state, plane);
>   	unsigned int width, height, cpp, next_id, plane_id;
> diff --git a/drivers/gpu/drm/ingenic/ingenic-ipu.c b/drivers/gpu/drm/ingenic/ingenic-ipu.c
> index 34545b9c8c33833c3cc65f3d111b3f3bf9a60137..56143a191f361f86574e7e390a51f06d81e60061 100644
> --- a/drivers/gpu/drm/ingenic/ingenic-ipu.c
> +++ b/drivers/gpu/drm/ingenic/ingenic-ipu.c
> @@ -84,11 +84,11 @@ to_ingenic_ipu_priv_state(struct drm_private_state *state)
>   {
>   	return container_of(state, struct ingenic_ipu_private_state, base);
>   }
>   
>   static struct ingenic_ipu_private_state *
> -ingenic_ipu_get_priv_state(struct ingenic_ipu *priv, struct drm_atomic_state *state)
> +ingenic_ipu_get_priv_state(struct ingenic_ipu *priv, struct drm_atomic_commit *state)
>   {
>   	struct drm_private_state *priv_state;
>   
>   	priv_state = drm_atomic_get_private_obj_state(state, &priv->private_obj);
>   	if (IS_ERR(priv_state))
> @@ -96,11 +96,11 @@ ingenic_ipu_get_priv_state(struct ingenic_ipu *priv, struct drm_atomic_state *st
>   
>   	return to_ingenic_ipu_priv_state(priv_state);
>   }
>   
>   static struct ingenic_ipu_private_state *
> -ingenic_ipu_get_new_priv_state(struct ingenic_ipu *priv, struct drm_atomic_state *state)
> +ingenic_ipu_get_new_priv_state(struct ingenic_ipu *priv, struct drm_atomic_commit *state)
>   {
>   	struct drm_private_state *priv_state;
>   
>   	priv_state = drm_atomic_get_new_private_obj_state(state, &priv->private_obj);
>   	if (!priv_state)
> @@ -319,11 +319,11 @@ static inline bool osd_changed(struct drm_plane_state *state,
>   		state->crtc_w != oldstate->crtc_w ||
>   		state->crtc_h != oldstate->crtc_h;
>   }
>   
>   static void ingenic_ipu_plane_atomic_update(struct drm_plane *plane,
> -					    struct drm_atomic_state *state)
> +					    struct drm_atomic_commit *state)
>   {
>   	struct ingenic_ipu *ipu = plane_to_ingenic_ipu(plane);
>   	struct drm_plane_state *newstate = drm_atomic_get_new_plane_state(state, plane);
>   	struct drm_plane_state *oldstate = drm_atomic_get_old_plane_state(state, plane);
>   	const struct drm_format_info *finfo;
> @@ -563,11 +563,11 @@ static void ingenic_ipu_plane_atomic_update(struct drm_plane *plane,
>   		ipu_state->num_w, ipu_state->denom_w,
>   		ipu_state->num_h, ipu_state->denom_h);
>   }
>   
>   static int ingenic_ipu_plane_atomic_check(struct drm_plane *plane,
> -					  struct drm_atomic_state *state)
> +					  struct drm_atomic_commit *state)
>   {
>   	struct drm_plane_state *old_plane_state = drm_atomic_get_old_plane_state(state,
>   										 plane);
>   	struct drm_plane_state *new_plane_state = drm_atomic_get_new_plane_state(state,
>   										 plane);
> @@ -651,11 +651,11 @@ static int ingenic_ipu_plane_atomic_check(struct drm_plane *plane,
>   
>   	return 0;
>   }
>   
>   static void ingenic_ipu_plane_atomic_disable(struct drm_plane *plane,
> -					     struct drm_atomic_state *state)
> +					     struct drm_atomic_commit *state)
>   {
>   	struct ingenic_ipu *ipu = plane_to_ingenic_ipu(plane);
>   
>   	regmap_set_bits(ipu->map, JZ_REG_IPU_CTRL, JZ_IPU_CTRL_STOP);
>   	regmap_clear_bits(ipu->map, JZ_REG_IPU_CTRL, JZ_IPU_CTRL_CHIP_EN);
> diff --git a/drivers/gpu/drm/kmb/kmb_crtc.c b/drivers/gpu/drm/kmb/kmb_crtc.c
> index 647872f65bff98cfb35822b78e6fa004fa69ebf0..1dcdc55b00696cbd45db49e1811c6627072470e7 100644
> --- a/drivers/gpu/drm/kmb/kmb_crtc.c
> +++ b/drivers/gpu/drm/kmb/kmb_crtc.c
> @@ -64,11 +64,11 @@ static const struct drm_crtc_funcs kmb_crtc_funcs = {
>   	.enable_vblank = kmb_crtc_enable_vblank,
>   	.disable_vblank = kmb_crtc_disable_vblank,
>   };
>   
>   static void kmb_crtc_set_mode(struct drm_crtc *crtc,
> -			      struct drm_atomic_state *old_state)
> +			      struct drm_atomic_commit *old_state)
>   {
>   	struct drm_device *dev = crtc->dev;
>   	struct drm_display_mode *m = &crtc->state->adjusted_mode;
>   	struct kmb_crtc_timing vm;
>   	struct kmb_drm_private *kmb = to_kmb(dev);
> @@ -131,21 +131,21 @@ static void kmb_crtc_set_mode(struct drm_crtc *crtc,
>   	kmb_set_bitmask_lcd(kmb, LCD_CONTROL, LCD_CTRL_ENABLE);
>   	kmb_set_bitmask_lcd(kmb, LCD_INT_ENABLE, val);
>   }
>   
>   static void kmb_crtc_atomic_enable(struct drm_crtc *crtc,
> -				   struct drm_atomic_state *state)
> +				   struct drm_atomic_commit *state)
>   {
>   	struct kmb_drm_private *kmb = crtc_to_kmb_priv(crtc);
>   
>   	clk_prepare_enable(kmb->kmb_clk.clk_lcd);
>   	kmb_crtc_set_mode(crtc, state);
>   	drm_crtc_vblank_on(crtc);
>   }
>   
>   static void kmb_crtc_atomic_disable(struct drm_crtc *crtc,
> -				    struct drm_atomic_state *state)
> +				    struct drm_atomic_commit *state)
>   {
>   	struct kmb_drm_private *kmb = crtc_to_kmb_priv(crtc);
>   	struct drm_crtc_state *old_state = drm_atomic_get_old_crtc_state(state, crtc);
>   
>   	/* due to hw limitations, planes need to be off when crtc is off */
> @@ -154,21 +154,21 @@ static void kmb_crtc_atomic_disable(struct drm_crtc *crtc,
>   	drm_crtc_vblank_off(crtc);
>   	clk_disable_unprepare(kmb->kmb_clk.clk_lcd);
>   }
>   
>   static void kmb_crtc_atomic_begin(struct drm_crtc *crtc,
> -				  struct drm_atomic_state *state)
> +				  struct drm_atomic_commit *state)
>   {
>   	struct drm_device *dev = crtc->dev;
>   	struct kmb_drm_private *kmb = to_kmb(dev);
>   
>   	kmb_clr_bitmask_lcd(kmb, LCD_INT_ENABLE,
>   			    LCD_INT_VERT_COMP);
>   }
>   
>   static void kmb_crtc_atomic_flush(struct drm_crtc *crtc,
> -				  struct drm_atomic_state *state)
> +				  struct drm_atomic_commit *state)
>   {
>   	struct drm_device *dev = crtc->dev;
>   	struct kmb_drm_private *kmb = to_kmb(dev);
>   
>   	kmb_set_bitmask_lcd(kmb, LCD_INT_ENABLE,
> diff --git a/drivers/gpu/drm/kmb/kmb_drv.h b/drivers/gpu/drm/kmb/kmb_drv.h
> index 1f0c10d317febc615c31e069e1eafbdfadcb90dc..52ec4c2369825ab330a52c3aa52e2329b469ee56 100644
> --- a/drivers/gpu/drm/kmb/kmb_drv.h
> +++ b/drivers/gpu/drm/kmb/kmb_drv.h
> @@ -50,11 +50,11 @@ struct kmb_drm_private {
>   	struct kmb_dsi			*kmb_dsi;
>   	void __iomem			*lcd_mmio;
>   	struct kmb_clock		kmb_clk;
>   	struct drm_crtc			crtc;
>   	struct kmb_plane		*plane;
> -	struct drm_atomic_state		*state;
> +	struct drm_atomic_commit		*state;
>   	spinlock_t			irq_lock;
>   	int				irq_lcd;
>   	int				sys_clk_mhz;
>   	struct disp_cfg			init_disp_cfg[KMB_MAX_PLANES];
>   	struct layer_status		plane_status[KMB_MAX_PLANES];
> diff --git a/drivers/gpu/drm/kmb/kmb_dsi.c b/drivers/gpu/drm/kmb/kmb_dsi.c
> index aeb2f9f98f231e5b22f2a30e8b09d868e631cb5c..e3eb83fd57ce64af994fdf9460963516718e30fd 100644
> --- a/drivers/gpu/drm/kmb/kmb_dsi.c
> +++ b/drivers/gpu/drm/kmb/kmb_dsi.c
> @@ -1331,11 +1331,11 @@ static u32 mipi_tx_init_dphy(struct kmb_dsi *kmb_dsi,
>   
>   	return 0;
>   }
>   
>   static void connect_lcd_to_mipi(struct kmb_dsi *kmb_dsi,
> -				struct drm_atomic_state *old_state)
> +				struct drm_atomic_commit *old_state)
>   {
>   	struct regmap *msscam;
>   
>   	msscam = syscon_regmap_lookup_by_compatible("intel,keembay-msscam");
>   	if (IS_ERR(msscam)) {
> @@ -1351,11 +1351,11 @@ static void connect_lcd_to_mipi(struct kmb_dsi *kmb_dsi,
>   	/* DISABLE LCD->CIF LOOPBACK */
>   	regmap_write(msscam, MSS_LOOPBACK_CFG, 1);
>   }
>   
>   int kmb_dsi_mode_set(struct kmb_dsi *kmb_dsi, struct drm_display_mode *mode,
> -		     int sys_clk_mhz, struct drm_atomic_state *old_state)
> +		     int sys_clk_mhz, struct drm_atomic_commit *old_state)
>   {
>   	u64 data_rate;
>   
>   	kmb_dsi->sys_clk_mhz = sys_clk_mhz;
>   	mipi_tx_init_cfg.active_lanes = MIPI_TX_ACTIVE_LANES;
> diff --git a/drivers/gpu/drm/kmb/kmb_dsi.h b/drivers/gpu/drm/kmb/kmb_dsi.h
> index 09dc88743d7799f361537c7ad57b55e26b2a91bd..0faadeb9f1ddc3cdeaf136c73e4d534a26877a93 100644
> --- a/drivers/gpu/drm/kmb/kmb_dsi.h
> +++ b/drivers/gpu/drm/kmb/kmb_dsi.h
> @@ -378,10 +378,10 @@ static inline void kmb_clr_bit_mipi(struct kmb_dsi *kmb_dsi,
>   
>   int kmb_dsi_host_bridge_init(struct device *dev);
>   struct kmb_dsi *kmb_dsi_init(struct platform_device *pdev);
>   void kmb_dsi_host_unregister(struct kmb_dsi *kmb_dsi);
>   int kmb_dsi_mode_set(struct kmb_dsi *kmb_dsi, struct drm_display_mode *mode,
> -		     int sys_clk_mhz, struct drm_atomic_state *old_state);
> +		     int sys_clk_mhz, struct drm_atomic_commit *old_state);
>   int kmb_dsi_map_mmio(struct kmb_dsi *kmb_dsi);
>   int kmb_dsi_clk_init(struct kmb_dsi *kmb_dsi);
>   int kmb_dsi_encoder_init(struct drm_device *dev, struct kmb_dsi *kmb_dsi);
>   #endif /* __KMB_DSI_H__ */
> diff --git a/drivers/gpu/drm/kmb/kmb_plane.c b/drivers/gpu/drm/kmb/kmb_plane.c
> index a935ff1503cdf267946136540a2212fe9880f9b4..a0001edb1e21aa9e6f4486e0bd9ec87d2c10f766 100644
> --- a/drivers/gpu/drm/kmb/kmb_plane.c
> +++ b/drivers/gpu/drm/kmb/kmb_plane.c
> @@ -88,11 +88,11 @@ static unsigned int check_pixel_format(struct drm_plane *plane, u32 format)
>   	}
>   	return -EINVAL;
>   }
>   
>   static int kmb_plane_atomic_check(struct drm_plane *plane,
> -				  struct drm_atomic_state *state)
> +				  struct drm_atomic_commit *state)
>   {
>   	struct drm_plane_state *new_plane_state = drm_atomic_get_new_plane_state(state,
>   										 plane);
>   	struct kmb_drm_private *kmb;
>   	struct kmb_plane *kmb_plane = to_kmb_plane(plane);
> @@ -137,11 +137,11 @@ static int kmb_plane_atomic_check(struct drm_plane *plane,
>   						   DRM_PLANE_NO_SCALING,
>   						   can_position, true);
>   }
>   
>   static void kmb_plane_atomic_disable(struct drm_plane *plane,
> -				     struct drm_atomic_state *state)
> +				     struct drm_atomic_commit *state)
>   {
>   	struct kmb_plane *kmb_plane = to_kmb_plane(plane);
>   	int plane_id = kmb_plane->id;
>   	struct kmb_drm_private *kmb;
>   
> @@ -337,11 +337,11 @@ static void kmb_plane_set_alpha(struct kmb_drm_private *kmb,
>   
>   	kmb_write_lcd(kmb, LCD_LAYERn_ALPHA(plane_id), plane_alpha);
>   }
>   
>   static void kmb_plane_atomic_update(struct drm_plane *plane,
> -				    struct drm_atomic_state *state)
> +				    struct drm_atomic_commit *state)
>   {
>   	struct drm_plane_state *old_plane_state = drm_atomic_get_old_plane_state(state,
>   										 plane);
>   	struct drm_plane_state *new_plane_state = drm_atomic_get_new_plane_state(state,
>   										 plane);
> diff --git a/drivers/gpu/drm/logicvc/logicvc_crtc.c b/drivers/gpu/drm/logicvc/logicvc_crtc.c
> index 43a675d03808fbff4249a6aa915726f7e2443282..81e5b80736fa790b5b29020bb3037ce863c779df 100644
> --- a/drivers/gpu/drm/logicvc/logicvc_crtc.c
> +++ b/drivers/gpu/drm/logicvc/logicvc_crtc.c
> @@ -34,11 +34,11 @@ logicvc_crtc_mode_valid(struct drm_crtc *drm_crtc,
>   
>   	return 0;
>   }
>   
>   static void logicvc_crtc_atomic_begin(struct drm_crtc *drm_crtc,
> -				      struct drm_atomic_state *state)
> +				      struct drm_atomic_commit *state)
>   {
>   	struct logicvc_crtc *crtc = logicvc_crtc(drm_crtc);
>   	struct drm_crtc_state *old_state =
>   		drm_atomic_get_old_crtc_state(state, drm_crtc);
>   	struct drm_device *drm_dev = drm_crtc->dev;
> @@ -58,11 +58,11 @@ static void logicvc_crtc_atomic_begin(struct drm_crtc *drm_crtc,
>   		spin_unlock_irqrestore(&drm_dev->event_lock, flags);
>   	}
>   }
>   
>   static void logicvc_crtc_atomic_enable(struct drm_crtc *drm_crtc,
> -				       struct drm_atomic_state *state)
> +				       struct drm_atomic_commit *state)
>   {
>   	struct logicvc_crtc *crtc = logicvc_crtc(drm_crtc);
>   	struct logicvc_drm *logicvc = logicvc_drm(drm_crtc->dev);
>   	struct drm_crtc_state *old_state =
>   		drm_atomic_get_old_crtc_state(state, drm_crtc);
> @@ -148,11 +148,11 @@ static void logicvc_crtc_atomic_enable(struct drm_crtc *drm_crtc,
>   		spin_unlock_irqrestore(&drm_dev->event_lock, flags);
>   	}
>   }
>   
>   static void logicvc_crtc_atomic_disable(struct drm_crtc *drm_crtc,
> -					struct drm_atomic_state *state)
> +					struct drm_atomic_commit *state)
>   {
>   	struct logicvc_drm *logicvc = logicvc_drm(drm_crtc->dev);
>   	struct drm_device *drm_dev = drm_crtc->dev;
>   
>   	drm_crtc_vblank_off(drm_crtc);
> diff --git a/drivers/gpu/drm/logicvc/logicvc_layer.c b/drivers/gpu/drm/logicvc/logicvc_layer.c
> index eab4d773f92b66a9edb9770aa7a95349d665ec18..7f5ba000188aba5835a392e84f6fb1ec902eb63e 100644
> --- a/drivers/gpu/drm/logicvc/logicvc_layer.c
> +++ b/drivers/gpu/drm/logicvc/logicvc_layer.c
> @@ -79,11 +79,11 @@ static bool logicvc_layer_format_inverted(uint32_t format)
>   		return false;
>   	}
>   }
>   
>   static int logicvc_plane_atomic_check(struct drm_plane *drm_plane,
> -				      struct drm_atomic_state *state)
> +				      struct drm_atomic_commit *state)
>   {
>   	struct drm_device *drm_dev = drm_plane->dev;
>   	struct logicvc_layer *layer = logicvc_layer(drm_plane);
>   	struct logicvc_drm *logicvc = logicvc_drm(drm_dev);
>   	struct drm_plane_state *new_state =
> @@ -133,11 +133,11 @@ static int logicvc_plane_atomic_check(struct drm_plane *drm_plane,
>   
>   	return 0;
>   }
>   
>   static void logicvc_plane_atomic_update(struct drm_plane *drm_plane,
> -					struct drm_atomic_state *state)
> +					struct drm_atomic_commit *state)
>   {
>   	struct logicvc_layer *layer = logicvc_layer(drm_plane);
>   	struct logicvc_drm *logicvc = logicvc_drm(drm_plane->dev);
>   	struct drm_device *drm_dev = &logicvc->drm_dev;
>   	struct drm_plane_state *new_state =
> @@ -230,11 +230,11 @@ static void logicvc_plane_atomic_update(struct drm_plane *drm_plane,
>   
>   	regmap_write(logicvc->regmap, LOGICVC_LAYER_CTRL_REG(index), reg);
>   }
>   
>   static void logicvc_plane_atomic_disable(struct drm_plane *drm_plane,
> -					 struct drm_atomic_state *state)
> +					 struct drm_atomic_commit *state)
>   {
>   	struct logicvc_layer *layer = logicvc_layer(drm_plane);
>   	struct logicvc_drm *logicvc = logicvc_drm(drm_plane->dev);
>   	u32 index = layer->index;
>   
> diff --git a/drivers/gpu/drm/loongson/lsdc_crtc.c b/drivers/gpu/drm/loongson/lsdc_crtc.c
> index 587fbe285e9ef1707334ce802e5922f70d12ccd6..16b8f36a4071077a53010feca5e8136bad766542 100644
> --- a/drivers/gpu/drm/loongson/lsdc_crtc.c
> +++ b/drivers/gpu/drm/loongson/lsdc_crtc.c
> @@ -791,11 +791,11 @@ static int lsdc_pixpll_atomic_check(struct drm_crtc *crtc,
>   
>   	return 0;
>   }
>   
>   static int lsdc_crtc_helper_atomic_check(struct drm_crtc *crtc,
> -					 struct drm_atomic_state *state)
> +					 struct drm_atomic_commit *state)
>   {
>   	struct drm_crtc_state *crtc_state = drm_atomic_get_new_crtc_state(state, crtc);
>   
>   	if (!crtc_state->enable)
>   		return 0;
> @@ -853,22 +853,22 @@ static void lsdc_crtc_send_vblank(struct drm_crtc *crtc)
>   	crtc->state->event = NULL;
>   	spin_unlock_irqrestore(&ddev->event_lock, flags);
>   }
>   
>   static void lsdc_crtc_atomic_enable(struct drm_crtc *crtc,
> -				    struct drm_atomic_state *state)
> +				    struct drm_atomic_commit *state)
>   {
>   	struct lsdc_crtc *lcrtc = to_lsdc_crtc(crtc);
>   
>   	if (lcrtc->has_vblank)
>   		drm_crtc_vblank_on(crtc);
>   
>   	lcrtc->hw_ops->enable(lcrtc);
>   }
>   
>   static void lsdc_crtc_atomic_disable(struct drm_crtc *crtc,
> -				     struct drm_atomic_state *state)
> +				     struct drm_atomic_commit *state)
>   {
>   	struct lsdc_crtc *lcrtc = to_lsdc_crtc(crtc);
>   
>   	if (lcrtc->has_vblank)
>   		drm_crtc_vblank_off(crtc);
> @@ -881,11 +881,11 @@ static void lsdc_crtc_atomic_disable(struct drm_crtc *crtc,
>   	 */
>   	lsdc_crtc_send_vblank(crtc);
>   }
>   
>   static void lsdc_crtc_atomic_flush(struct drm_crtc *crtc,
> -				   struct drm_atomic_state *state)
> +				   struct drm_atomic_commit *state)
>   {
>   	spin_lock_irq(&crtc->dev->event_lock);
>   	if (crtc->state->event) {
>   		if (drm_crtc_vblank_get(crtc) == 0)
>   			drm_crtc_arm_vblank_event(crtc, crtc->state->event);
> diff --git a/drivers/gpu/drm/loongson/lsdc_output_7a1000.c b/drivers/gpu/drm/loongson/lsdc_output_7a1000.c
> index ccca67e01fd95eb5b57ac5cacfd6f4c8f25255f3..5c483baa3762ed1d703d7173a995618432995f46 100644
> --- a/drivers/gpu/drm/loongson/lsdc_output_7a1000.c
> +++ b/drivers/gpu/drm/loongson/lsdc_output_7a1000.c
> @@ -61,11 +61,11 @@ static int ls7a1000_dpi_connector_get_modes(struct drm_connector *conn)
>   	return num;
>   }
>   
>   static struct drm_encoder *
>   ls7a1000_dpi_connector_get_best_encoder(struct drm_connector *connector,
> -					struct drm_atomic_state *state)
> +					struct drm_atomic_commit *state)
>   {
>   	struct lsdc_output *output = connector_to_lsdc_output(connector);
>   
>   	return &output->encoder;
>   }
> diff --git a/drivers/gpu/drm/loongson/lsdc_output_7a2000.c b/drivers/gpu/drm/loongson/lsdc_output_7a2000.c
> index aa7daee4c065617f72c45c19508aa9d1ddab07ab..a9798b3dadee05e0ab6a4f88d38b8cf35ac36d33 100644
> --- a/drivers/gpu/drm/loongson/lsdc_output_7a2000.c
> +++ b/drivers/gpu/drm/loongson/lsdc_output_7a2000.c
> @@ -65,11 +65,11 @@ static int ls7a2000_connector_get_modes(struct drm_connector *connector)
>   	return num;
>   }
>   
>   static struct drm_encoder *
>   ls7a2000_connector_get_best_encoder(struct drm_connector *connector,
> -				    struct drm_atomic_state *state)
> +				    struct drm_atomic_commit *state)
>   {
>   	struct lsdc_output *output = connector_to_lsdc_output(connector);
>   
>   	return &output->encoder;
>   }
> @@ -330,11 +330,11 @@ static int ls7a2000_hdmi_set_avi_infoframe(struct drm_encoder *encoder,
>   
>   	return 0;
>   }
>   
>   static void ls7a2000_hdmi_atomic_disable(struct drm_encoder *encoder,
> -					 struct drm_atomic_state *state)
> +					 struct drm_atomic_commit *state)
>   {
>   	struct lsdc_output *output = encoder_to_lsdc_output(encoder);
>   	struct lsdc_display_pipe *dispipe = output_to_display_pipe(output);
>   	unsigned int index = dispipe->index;
>   	struct drm_device *ddev = encoder->dev;
> @@ -353,11 +353,11 @@ static void ls7a2000_hdmi_atomic_disable(struct drm_encoder *encoder,
>   
>   	drm_dbg(ddev, "HDMI-%u disabled\n", index);
>   }
>   
>   static void ls7a2000_hdmi_atomic_enable(struct drm_encoder *encoder,
> -					struct drm_atomic_state *state)
> +					struct drm_atomic_commit *state)
>   {
>   	struct drm_device *ddev = encoder->dev;
>   	struct lsdc_device *ldev = to_lsdc(ddev);
>   	struct lsdc_output *output = encoder_to_lsdc_output(encoder);
>   	struct lsdc_display_pipe *dispipe = output_to_display_pipe(output);
> diff --git a/drivers/gpu/drm/loongson/lsdc_plane.c b/drivers/gpu/drm/loongson/lsdc_plane.c
> index 9675344128d02bd94a57c1ee5fdd27f93c28bf93..bea42215796d423563772bc6717f3796e502b488 100644
> --- a/drivers/gpu/drm/loongson/lsdc_plane.c
> +++ b/drivers/gpu/drm/loongson/lsdc_plane.c
> @@ -46,11 +46,11 @@ static u64 lsdc_fb_base_addr(struct drm_framebuffer *fb)
>   
>   	return lsdc_bo_gpu_offset(lbo) + ldev->vram_base;
>   }
>   
>   static int lsdc_primary_atomic_check(struct drm_plane *plane,
> -				     struct drm_atomic_state *state)
> +				     struct drm_atomic_commit *state)
>   {
>   	struct drm_plane_state *new_plane_state = drm_atomic_get_new_plane_state(state, plane);
>   	struct drm_crtc *crtc = new_plane_state->crtc;
>   	struct drm_crtc_state *new_crtc_state;
>   
> @@ -65,11 +65,11 @@ static int lsdc_primary_atomic_check(struct drm_plane *plane,
>   						   DRM_PLANE_NO_SCALING,
>   						   false, true);
>   }
>   
>   static void lsdc_primary_atomic_update(struct drm_plane *plane,
> -				       struct drm_atomic_state *state)
> +				       struct drm_atomic_commit *state)
>   {
>   	struct lsdc_primary *primary = to_lsdc_primary(plane);
>   	const struct lsdc_primary_plane_ops *ops = primary->ops;
>   	struct drm_plane_state *old_plane_state = drm_atomic_get_old_plane_state(state, plane);
>   	struct drm_plane_state *new_plane_state = drm_atomic_get_new_plane_state(state, plane);
> @@ -85,11 +85,11 @@ static void lsdc_primary_atomic_update(struct drm_plane *plane,
>   	if (!old_fb || old_fb->format != new_fb->format)
>   		ops->update_fb_format(primary, new_fb->format);
>   }
>   
>   static void lsdc_primary_atomic_disable(struct drm_plane *plane,
> -					struct drm_atomic_state *state)
> +					struct drm_atomic_commit *state)
>   {
>   	/*
>   	 * Do nothing, just prevent call into atomic_update().
>   	 * Writing the format as LSDC_PF_NONE can disable the primary,
>   	 * But it seems not necessary...
> @@ -170,11 +170,11 @@ static const struct drm_plane_helper_funcs lsdc_primary_helper_funcs = {
>   	.atomic_update = lsdc_primary_atomic_update,
>   	.atomic_disable = lsdc_primary_atomic_disable,
>   };
>   
>   static int lsdc_cursor_plane_atomic_async_check(struct drm_plane *plane,
> -						struct drm_atomic_state *state,
> +						struct drm_atomic_commit *state,
>   						bool flip)
>   {
>   	struct drm_plane_state *new_state;
>   	struct drm_crtc_state *crtc_state;
>   
> @@ -217,11 +217,11 @@ static int lsdc_cursor_plane_atomic_async_check(struct drm_plane *plane,
>   						   DRM_PLANE_NO_SCALING,
>   						   true, true);
>   }
>   
>   static void lsdc_cursor_plane_atomic_async_update(struct drm_plane *plane,
> -						  struct drm_atomic_state *state)
> +						  struct drm_atomic_commit *state)
>   {
>   	struct lsdc_cursor *cursor = to_lsdc_cursor(plane);
>   	const struct lsdc_cursor_plane_ops *ops = cursor->ops;
>   	struct drm_framebuffer *old_fb = plane->state->fb;
>   	struct drm_framebuffer *new_fb;
> @@ -266,11 +266,11 @@ static void lsdc_cursor_plane_atomic_async_update(struct drm_plane *plane,
>   }
>   
>   /* ls7a1000 cursor plane helpers */
>   
>   static int ls7a1000_cursor_plane_atomic_check(struct drm_plane *plane,
> -					      struct drm_atomic_state *state)
> +					      struct drm_atomic_commit *state)
>   {
>   	struct drm_plane_state *new_plane_state;
>   	struct drm_crtc_state *new_crtc_state;
>   	struct drm_crtc *crtc;
>   
> @@ -296,11 +296,11 @@ static int ls7a1000_cursor_plane_atomic_check(struct drm_plane *plane,
>   						   DRM_PLANE_NO_SCALING,
>   						   true, true);
>   }
>   
>   static void ls7a1000_cursor_plane_atomic_update(struct drm_plane *plane,
> -						struct drm_atomic_state *state)
> +						struct drm_atomic_commit *state)
>   {
>   	struct lsdc_cursor *cursor = to_lsdc_cursor(plane);
>   	struct drm_plane_state *old_plane_state = drm_atomic_get_old_plane_state(state, plane);
>   	struct drm_plane_state *new_plane_state = drm_atomic_get_new_plane_state(state, plane);
>   	struct drm_framebuffer *new_fb = new_plane_state->fb;
> @@ -318,11 +318,11 @@ static void ls7a1000_cursor_plane_atomic_update(struct drm_plane *plane,
>   
>   	ops->update_cfg(cursor, CURSOR_SIZE_32X32, CURSOR_FORMAT_ARGB8888);
>   }
>   
>   static void ls7a1000_cursor_plane_atomic_disable(struct drm_plane *plane,
> -						 struct drm_atomic_state *state)
> +						 struct drm_atomic_commit *state)
>   {
>   	struct lsdc_cursor *cursor = to_lsdc_cursor(plane);
>   	const struct lsdc_cursor_plane_ops *ops = cursor->ops;
>   
>   	ops->update_cfg(cursor, CURSOR_SIZE_32X32, CURSOR_FORMAT_DISABLE);
> @@ -339,11 +339,11 @@ static const struct drm_plane_helper_funcs ls7a1000_cursor_plane_helper_funcs =
>   };
>   
>   /* ls7a2000 cursor plane helpers */
>   
>   static int ls7a2000_cursor_plane_atomic_check(struct drm_plane *plane,
> -					      struct drm_atomic_state *state)
> +					      struct drm_atomic_commit *state)
>   {
>   	struct drm_plane_state *new_plane_state;
>   	struct drm_crtc_state *new_crtc_state;
>   	struct drm_crtc *crtc;
>   
> @@ -377,11 +377,11 @@ static int ls7a2000_cursor_plane_atomic_check(struct drm_plane *plane,
>   }
>   
>   /* Update the format, size and location of the cursor */
>   
>   static void ls7a2000_cursor_plane_atomic_update(struct drm_plane *plane,
> -						struct drm_atomic_state *state)
> +						struct drm_atomic_commit *state)
>   {
>   	struct lsdc_cursor *cursor = to_lsdc_cursor(plane);
>   	struct drm_plane_state *old_plane_state = drm_atomic_get_old_plane_state(state, plane);
>   	struct drm_plane_state *new_plane_state = drm_atomic_get_new_plane_state(state, plane);
>   	struct drm_framebuffer *new_fb = new_plane_state->fb;
> @@ -414,11 +414,11 @@ static void ls7a2000_cursor_plane_atomic_update(struct drm_plane *plane,
>   
>   	ops->update_cfg(cursor, cursor_size, CURSOR_FORMAT_ARGB8888);
>   }
>   
>   static void ls7a2000_cursor_plane_atomic_disable(struct drm_plane *plane,
> -						 struct drm_atomic_state *state)
> +						 struct drm_atomic_commit *state)
>   {
>   	struct lsdc_cursor *cursor = to_lsdc_cursor(plane);
>   	const struct lsdc_cursor_plane_ops *hw_ops = cursor->ops;
>   
>   	hw_ops->update_cfg(cursor, CURSOR_SIZE_64X64, CURSOR_FORMAT_DISABLE);
> diff --git a/drivers/gpu/drm/mediatek/mtk_crtc.c b/drivers/gpu/drm/mediatek/mtk_crtc.c
> index fcb16f3f7b23b37f939e0e52159be7152763cb0e..caa02a708d0a54909ba09a4e27e070c9ecd5cdcb 100644
> --- a/drivers/gpu/drm/mediatek/mtk_crtc.c
> +++ b/drivers/gpu/drm/mediatek/mtk_crtc.c
> @@ -679,11 +679,11 @@ static void mtk_crtc_disable_vblank(struct drm_crtc *crtc)
>   
>   	mtk_ddp_comp_disable_vblank(comp);
>   }
>   
>   static void mtk_crtc_update_output(struct drm_crtc *crtc,
> -				   struct drm_atomic_state *state)
> +				   struct drm_atomic_commit *state)
>   {
>   	int crtc_index = drm_crtc_index(crtc);
>   	int i;
>   	struct device *dev;
>   	struct drm_crtc_state *crtc_state = state->crtcs[crtc_index].new_state;
> @@ -761,22 +761,22 @@ void mtk_crtc_plane_disable(struct drm_crtc *crtc, struct drm_plane *plane)
>   			   msecs_to_jiffies(500));
>   #endif
>   }
>   
>   void mtk_crtc_async_update(struct drm_crtc *crtc, struct drm_plane *plane,
> -			   struct drm_atomic_state *state)
> +			   struct drm_atomic_commit *state)
>   {
>   	struct mtk_crtc *mtk_crtc = to_mtk_crtc(crtc);
>   
>   	if (!mtk_crtc->enabled)
>   		return;
>   
>   	mtk_crtc_update_config(mtk_crtc, false);
>   }
>   
>   static void mtk_crtc_atomic_enable(struct drm_crtc *crtc,
> -				   struct drm_atomic_state *state)
> +				   struct drm_atomic_commit *state)
>   {
>   	struct mtk_crtc *mtk_crtc = to_mtk_crtc(crtc);
>   	struct mtk_ddp_comp *comp = mtk_crtc->ddp_comp[0];
>   	struct drm_device *dev = mtk_crtc->base.dev;
>   	int ret;
> @@ -800,11 +800,11 @@ static void mtk_crtc_atomic_enable(struct drm_crtc *crtc,
>   	drm_crtc_vblank_on(crtc);
>   	mtk_crtc->enabled = true;
>   }
>   
>   static void mtk_crtc_atomic_disable(struct drm_crtc *crtc,
> -				    struct drm_atomic_state *state)
> +				    struct drm_atomic_commit *state)
>   {
>   	struct mtk_crtc *mtk_crtc = to_mtk_crtc(crtc);
>   	struct mtk_ddp_comp *comp = mtk_crtc->ddp_comp[0];
>   	struct drm_device *dev = mtk_crtc->base.dev;
>   	int i;
> @@ -841,11 +841,11 @@ static void mtk_crtc_atomic_disable(struct drm_crtc *crtc,
>   
>   	mtk_crtc->enabled = false;
>   }
>   
>   static void mtk_crtc_atomic_begin(struct drm_crtc *crtc,
> -				  struct drm_atomic_state *state)
> +				  struct drm_atomic_commit *state)
>   {
>   	struct drm_crtc_state *crtc_state = drm_atomic_get_new_crtc_state(state,
>   									  crtc);
>   	struct mtk_crtc_state *mtk_crtc_state = to_mtk_crtc_state(crtc_state);
>   	struct mtk_crtc *mtk_crtc = to_mtk_crtc(crtc);
> @@ -866,11 +866,11 @@ static void mtk_crtc_atomic_begin(struct drm_crtc *crtc,
>   		mtk_crtc_state->base.event = NULL;
>   	}
>   }
>   
>   static void mtk_crtc_atomic_flush(struct drm_crtc *crtc,
> -				  struct drm_atomic_state *state)
> +				  struct drm_atomic_commit *state)
>   {
>   	struct mtk_crtc *mtk_crtc = to_mtk_crtc(crtc);
>   	int i;
>   
>   	if (crtc->state->color_mgmt_changed)
> diff --git a/drivers/gpu/drm/mediatek/mtk_crtc.h b/drivers/gpu/drm/mediatek/mtk_crtc.h
> index 828f109b83e78ff00de6d69d860b9b8eb081be33..a6b8697cca977a1acf1073c8307ec09c8320ebe1 100644
> --- a/drivers/gpu/drm/mediatek/mtk_crtc.h
> +++ b/drivers/gpu/drm/mediatek/mtk_crtc.h
> @@ -21,9 +21,9 @@ int mtk_crtc_create(struct drm_device *drm_dev, const unsigned int *path,
>   		    unsigned int num_conn_routes);
>   int mtk_crtc_plane_check(struct drm_crtc *crtc, struct drm_plane *plane,
>   			 struct mtk_plane_state *state);
>   void mtk_crtc_plane_disable(struct drm_crtc *crtc, struct drm_plane *plane);
>   void mtk_crtc_async_update(struct drm_crtc *crtc, struct drm_plane *plane,
> -			   struct drm_atomic_state *plane_state);
> +			   struct drm_atomic_commit *plane_state);
>   struct device *mtk_crtc_dma_dev_get(struct drm_crtc *crtc);
>   
>   #endif /* MTK_CRTC_H */
> diff --git a/drivers/gpu/drm/mediatek/mtk_dp.c b/drivers/gpu/drm/mediatek/mtk_dp.c
> index c52cc7c2e20063b9dcc99be46bc7de50d67b0d6b..eefbc7e0f9c8d47dca073fee65b7de9f835ccd61 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dp.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dp.c
> @@ -2372,11 +2372,11 @@ static void mtk_dp_bridge_detach(struct drm_bridge *bridge)
>   	mtk_dp_poweroff(mtk_dp);
>   	drm_dp_aux_unregister(&mtk_dp->aux);
>   }
>   
>   static void mtk_dp_bridge_atomic_enable(struct drm_bridge *bridge,
> -					struct drm_atomic_state *state)
> +					struct drm_atomic_commit *state)
>   {
>   	struct mtk_dp *mtk_dp = mtk_dp_from_bridge(bridge);
>   	int ret;
>   
>   	mtk_dp->conn = drm_atomic_get_new_connector_for_encoder(state,
> @@ -2426,11 +2426,11 @@ static void mtk_dp_bridge_atomic_enable(struct drm_bridge *bridge,
>   			   DP_PWR_STATE_BANDGAP_TPLL,
>   			   DP_PWR_STATE_MASK);
>   }
>   
>   static void mtk_dp_bridge_atomic_disable(struct drm_bridge *bridge,
> -					 struct drm_atomic_state *state)
> +					 struct drm_atomic_commit *state)
>   {
>   	struct mtk_dp *mtk_dp = mtk_dp_from_bridge(bridge);
>   
>   	if (mtk_dp->data->bridge_type == DRM_MODE_CONNECTOR_eDP) {
>   		mtk_dp->enabled = false;
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.h b/drivers/gpu/drm/mediatek/mtk_drm_drv.h
> index 1fc3df4b5485804f538b4dab09969178ae496016..d48da019a4a3eba044020f40fea9b2bcbd21c5e3 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_drv.h
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.h
> @@ -61,11 +61,11 @@ struct mtk_drm_private {
>   	struct device *mutex_dev;
>   	struct device *mmsys_dev;
>   	struct device_node *comp_node[DDP_COMPONENT_DRM_ID_MAX];
>   	struct mtk_ddp_comp ddp_comp[DDP_COMPONENT_DRM_ID_MAX];
>   	struct mtk_mmsys_driver_data *data;
> -	struct drm_atomic_state *suspend_state;
> +	struct drm_atomic_commit *suspend_state;
>   	unsigned int mbox_index;
>   	struct mtk_drm_private **all_drm_private;
>   };
>   
>   extern struct platform_driver mtk_disp_aal_driver;
> diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
> index 17c67f02016bbe5bc6a9588365ac3e55a1c1f0df..e9ce7f1a1a5394b576b40625983ec224fc50cc38 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dsi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
> @@ -826,41 +826,41 @@ static void mtk_dsi_bridge_mode_set(struct drm_bridge *bridge,
>   
>   	drm_display_mode_to_videomode(adjusted, &dsi->vm);
>   }
>   
>   static void mtk_dsi_bridge_atomic_disable(struct drm_bridge *bridge,
> -					  struct drm_atomic_state *state)
> +					  struct drm_atomic_commit *state)
>   {
>   	struct mtk_dsi *dsi = bridge_to_dsi(bridge);
>   
>   	mtk_output_dsi_disable(dsi);
>   }
>   
>   static void mtk_dsi_bridge_atomic_enable(struct drm_bridge *bridge,
> -					 struct drm_atomic_state *state)
> +					 struct drm_atomic_commit *state)
>   {
>   	struct mtk_dsi *dsi = bridge_to_dsi(bridge);
>   
>   	if (dsi->refcount == 0)
>   		return;
>   
>   	mtk_output_dsi_enable(dsi);
>   }
>   
>   static void mtk_dsi_bridge_atomic_pre_enable(struct drm_bridge *bridge,
> -					     struct drm_atomic_state *state)
> +					     struct drm_atomic_commit *state)
>   {
>   	struct mtk_dsi *dsi = bridge_to_dsi(bridge);
>   	int ret;
>   
>   	ret = mtk_dsi_poweron(dsi);
>   	if (ret < 0)
>   		DRM_ERROR("failed to power on dsi\n");
>   }
>   
>   static void mtk_dsi_bridge_atomic_post_disable(struct drm_bridge *bridge,
> -					       struct drm_atomic_state *state)
> +					       struct drm_atomic_commit *state)
>   {
>   	struct mtk_dsi *dsi = bridge_to_dsi(bridge);
>   
>   	mtk_dsi_poweroff(dsi);
>   }
> diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi.c b/drivers/gpu/drm/mediatek/mtk_hdmi.c
> index 1ea2598547800025e2fa8b7876e7f91e1a3085ce..17b10de5ff60d88e78f175ac77ce1100c6c1faf8 100644
> --- a/drivers/gpu/drm/mediatek/mtk_hdmi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_hdmi.c
> @@ -997,11 +997,11 @@ static int mtk_hdmi_bridge_attach(struct drm_bridge *bridge,
>   
>   	return 0;
>   }
>   
>   static void mtk_hdmi_bridge_atomic_disable(struct drm_bridge *bridge,
> -					   struct drm_atomic_state *state)
> +					   struct drm_atomic_commit *state)
>   {
>   	struct mtk_hdmi *hdmi = hdmi_ctx_from_bridge(bridge);
>   
>   	if (!hdmi->enabled)
>   		return;
> @@ -1014,11 +1014,11 @@ static void mtk_hdmi_bridge_atomic_disable(struct drm_bridge *bridge,
>   
>   	hdmi->enabled = false;
>   }
>   
>   static void mtk_hdmi_bridge_atomic_post_disable(struct drm_bridge *bridge,
> -						struct drm_atomic_state *state)
> +						struct drm_atomic_commit *state)
>   {
>   	struct mtk_hdmi *hdmi = hdmi_ctx_from_bridge(bridge);
>   
>   	if (!hdmi->powered)
>   		return;
> @@ -1028,11 +1028,11 @@ static void mtk_hdmi_bridge_atomic_post_disable(struct drm_bridge *bridge,
>   
>   	hdmi->powered = false;
>   }
>   
>   static void mtk_hdmi_bridge_atomic_pre_enable(struct drm_bridge *bridge,
> -					      struct drm_atomic_state *state)
> +					      struct drm_atomic_commit *state)
>   {
>   	struct mtk_hdmi *hdmi = hdmi_ctx_from_bridge(bridge);
>   
>   	mtk_hdmi_hw_make_reg_writable(hdmi, true);
>   	mtk_hdmi_hw_1p4_version_enable(hdmi, true);
> @@ -1049,11 +1049,11 @@ static void mtk_hdmi_send_infoframe(struct mtk_hdmi *hdmi,
>   	if (mode->flags & DRM_MODE_FLAG_3D_MASK)
>   		mtk_hdmi_setup_vendor_specific_infoframe(hdmi, mode);
>   }
>   
>   static void mtk_hdmi_bridge_atomic_enable(struct drm_bridge *bridge,
> -					  struct drm_atomic_state *state)
> +					  struct drm_atomic_commit *state)
>   {
>   	struct mtk_hdmi *hdmi = hdmi_ctx_from_bridge(bridge);
>   
>   	/* Retrieve the connector through the atomic state. */
>   	hdmi->curr_conn = drm_atomic_get_new_connector_for_encoder(state,
> diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi_v2.c b/drivers/gpu/drm/mediatek/mtk_hdmi_v2.c
> index b5c738380dc2537d0a8deee73e99c95dde1d2c37..81787cc95d2aa96a589627964ee4ee931188e711 100644
> --- a/drivers/gpu/drm/mediatek/mtk_hdmi_v2.c
> +++ b/drivers/gpu/drm/mediatek/mtk_hdmi_v2.c
> @@ -1008,11 +1008,11 @@ static void mtk_hdmi_v2_handle_plugged_change(struct mtk_hdmi *hdmi, bool plugge
>   		hdmi->plugged_cb(hdmi->codec_dev, plugged);
>   	mutex_unlock(&hdmi->update_plugged_status_lock);
>   }
>   
>   static void mtk_hdmi_v2_bridge_pre_enable(struct drm_bridge *bridge,
> -					  struct drm_atomic_state *state)
> +					  struct drm_atomic_commit *state)
>   {
>   	struct mtk_hdmi *hdmi = hdmi_ctx_from_bridge(bridge);
>   	struct drm_connector_state *conn_state;
>   	union phy_configure_opts opts = {
>   		.dp = { .link_rate = hdmi->mode.clock * KILO }
> @@ -1046,11 +1046,11 @@ static void mtk_hdmi_v2_bridge_pre_enable(struct drm_bridge *bridge,
>   
>   	hdmi->powered = true;
>   }
>   
>   static void mtk_hdmi_v2_bridge_enable(struct drm_bridge *bridge,
> -				      struct drm_atomic_state *state)
> +				      struct drm_atomic_commit *state)
>   {
>   	struct mtk_hdmi *hdmi = hdmi_ctx_from_bridge(bridge);
>   	int ret;
>   
>   	if (WARN_ON(!hdmi->powered))
> @@ -1067,11 +1067,11 @@ static void mtk_hdmi_v2_bridge_enable(struct drm_bridge *bridge,
>   
>   	hdmi->enabled = true;
>   }
>   
>   static void mtk_hdmi_v2_bridge_disable(struct drm_bridge *bridge,
> -				       struct drm_atomic_state *state)
> +				       struct drm_atomic_commit *state)
>   {
>   	struct mtk_hdmi *hdmi = hdmi_ctx_from_bridge(bridge);
>   
>   	if (!hdmi->enabled)
>   		return;
> @@ -1084,11 +1084,11 @@ static void mtk_hdmi_v2_bridge_disable(struct drm_bridge *bridge,
>   
>   	hdmi->enabled = false;
>   }
>   
>   static void mtk_hdmi_v2_bridge_post_disable(struct drm_bridge *bridge,
> -					    struct drm_atomic_state *state)
> +					    struct drm_atomic_commit *state)
>   {
>   	struct mtk_hdmi *hdmi = hdmi_ctx_from_bridge(bridge);
>   
>   	if (!hdmi->powered)
>   		return;
> diff --git a/drivers/gpu/drm/mediatek/mtk_plane.c b/drivers/gpu/drm/mediatek/mtk_plane.c
> index 86c6f60eadb32c63d51cbb4b1256b27695dc99d5..2598c8edb443d28417b54d8ce810835516d6a59b 100644
> --- a/drivers/gpu/drm/mediatek/mtk_plane.c
> +++ b/drivers/gpu/drm/mediatek/mtk_plane.c
> @@ -78,11 +78,11 @@ static void mtk_plane_destroy_state(struct drm_plane *plane,
>   	__drm_atomic_helper_plane_destroy_state(state);
>   	kfree(to_mtk_plane_state(state));
>   }
>   
>   static int mtk_plane_atomic_async_check(struct drm_plane *plane,
> -					struct drm_atomic_state *state, bool flip)
> +					struct drm_atomic_commit *state, bool flip)
>   {
>   	struct drm_plane_state *new_plane_state = drm_atomic_get_new_plane_state(state,
>   										 plane);
>   	struct drm_crtc_state *crtc_state;
>   	int ret;
> @@ -191,11 +191,11 @@ static void mtk_plane_update_new_state(struct drm_plane_state *new_state,
>   	mtk_plane_state->pending.rotation = new_state->rotation;
>   	mtk_plane_state->pending.color_encoding = new_state->color_encoding;
>   }
>   
>   static void mtk_plane_atomic_async_update(struct drm_plane *plane,
> -					  struct drm_atomic_state *state)
> +					  struct drm_atomic_commit *state)
>   {
>   	struct drm_plane_state *new_state = drm_atomic_get_new_plane_state(state,
>   									   plane);
>   	struct mtk_plane_state *new_plane_state = to_mtk_plane_state(plane->state);
>   
> @@ -226,11 +226,11 @@ static const struct drm_plane_funcs mtk_plane_funcs = {
>   	.atomic_destroy_state = mtk_plane_destroy_state,
>   	.format_mod_supported = mtk_plane_format_mod_supported,
>   };
>   
>   static int mtk_plane_atomic_check(struct drm_plane *plane,
> -				  struct drm_atomic_state *state)
> +				  struct drm_atomic_commit *state)
>   {
>   	struct drm_plane_state *new_plane_state = drm_atomic_get_new_plane_state(state,
>   										 plane);
>   	struct drm_framebuffer *fb = new_plane_state->fb;
>   	struct drm_crtc_state *crtc_state;
> @@ -258,11 +258,11 @@ static int mtk_plane_atomic_check(struct drm_plane *plane,
>   						   DRM_PLANE_NO_SCALING,
>   						   true, true);
>   }
>   
>   static void mtk_plane_atomic_disable(struct drm_plane *plane,
> -				     struct drm_atomic_state *state)
> +				     struct drm_atomic_commit *state)
>   {
>   	struct drm_plane_state *new_state = drm_atomic_get_new_plane_state(state,
>   									   plane);
>   	struct mtk_plane_state *mtk_plane_state = to_mtk_plane_state(new_state);
>   	struct drm_plane_state *old_state = drm_atomic_get_old_plane_state(state,
> @@ -275,11 +275,11 @@ static void mtk_plane_atomic_disable(struct drm_plane *plane,
>   	if (old_state && old_state->crtc)
>   		mtk_crtc_plane_disable(old_state->crtc, plane);
>   }
>   
>   static void mtk_plane_atomic_update(struct drm_plane *plane,
> -				    struct drm_atomic_state *state)
> +				    struct drm_atomic_commit *state)
>   {
>   	struct drm_plane_state *new_state = drm_atomic_get_new_plane_state(state,
>   									   plane);
>   	struct mtk_plane_state *mtk_plane_state = to_mtk_plane_state(new_state);
>   
> diff --git a/drivers/gpu/drm/meson/meson_crtc.c b/drivers/gpu/drm/meson/meson_crtc.c
> index d70616da8ce2fd974b57af6aadca5c98fbb88fce..b77d2d24ead1c0ba9c7385a2be302b6a0182d85c 100644
> --- a/drivers/gpu/drm/meson/meson_crtc.c
> +++ b/drivers/gpu/drm/meson/meson_crtc.c
> @@ -80,11 +80,11 @@ static const struct drm_crtc_funcs meson_crtc_funcs = {
>   	.disable_vblank		= meson_crtc_disable_vblank,
>   
>   };
>   
>   static void meson_g12a_crtc_atomic_enable(struct drm_crtc *crtc,
> -					  struct drm_atomic_state *state)
> +					  struct drm_atomic_commit *state)
>   {
>   	struct meson_crtc *meson_crtc = to_meson_crtc(crtc);
>   	struct drm_crtc_state *crtc_state = crtc->state;
>   	struct meson_drm *priv = meson_crtc->priv;
>   
> @@ -116,11 +116,11 @@ static void meson_g12a_crtc_atomic_enable(struct drm_crtc *crtc,
>   
>   	drm_crtc_vblank_on(crtc);
>   }
>   
>   static void meson_crtc_atomic_enable(struct drm_crtc *crtc,
> -				     struct drm_atomic_state *state)
> +				     struct drm_atomic_commit *state)
>   {
>   	struct meson_crtc *meson_crtc = to_meson_crtc(crtc);
>   	struct drm_crtc_state *crtc_state = crtc->state;
>   	struct meson_drm *priv = meson_crtc->priv;
>   
> @@ -144,11 +144,11 @@ static void meson_crtc_atomic_enable(struct drm_crtc *crtc,
>   
>   	drm_crtc_vblank_on(crtc);
>   }
>   
>   static void meson_g12a_crtc_atomic_disable(struct drm_crtc *crtc,
> -					   struct drm_atomic_state *state)
> +					   struct drm_atomic_commit *state)
>   {
>   	struct meson_crtc *meson_crtc = to_meson_crtc(crtc);
>   	struct meson_drm *priv = meson_crtc->priv;
>   
>   	DRM_DEBUG_DRIVER("\n");
> @@ -169,11 +169,11 @@ static void meson_g12a_crtc_atomic_disable(struct drm_crtc *crtc,
>   		crtc->state->event = NULL;
>   	}
>   }
>   
>   static void meson_crtc_atomic_disable(struct drm_crtc *crtc,
> -				      struct drm_atomic_state *state)
> +				      struct drm_atomic_commit *state)
>   {
>   	struct meson_crtc *meson_crtc = to_meson_crtc(crtc);
>   	struct meson_drm *priv = meson_crtc->priv;
>   
>   	DRM_DEBUG_DRIVER("\n");
> @@ -199,11 +199,11 @@ static void meson_crtc_atomic_disable(struct drm_crtc *crtc,
>   		crtc->state->event = NULL;
>   	}
>   }
>   
>   static void meson_crtc_atomic_begin(struct drm_crtc *crtc,
> -				    struct drm_atomic_state *state)
> +				    struct drm_atomic_commit *state)
>   {
>   	struct meson_crtc *meson_crtc = to_meson_crtc(crtc);
>   	unsigned long flags;
>   
>   	if (crtc->state->event) {
> @@ -215,11 +215,11 @@ static void meson_crtc_atomic_begin(struct drm_crtc *crtc,
>   		crtc->state->event = NULL;
>   	}
>   }
>   
>   static void meson_crtc_atomic_flush(struct drm_crtc *crtc,
> -				    struct drm_atomic_state *state)
> +				    struct drm_atomic_commit *state)
>   {
>   	struct meson_crtc *meson_crtc = to_meson_crtc(crtc);
>   	struct meson_drm *priv = meson_crtc->priv;
>   
>   	priv->viu.osd1_commit = true;
> diff --git a/drivers/gpu/drm/meson/meson_encoder_cvbs.c b/drivers/gpu/drm/meson/meson_encoder_cvbs.c
> index 41071d6e05e5f51357d1c08f9f3a460af8c1b755..574ffffd4a2702f8c52bd6e5db969af41f488893 100644
> --- a/drivers/gpu/drm/meson/meson_encoder_cvbs.c
> +++ b/drivers/gpu/drm/meson/meson_encoder_cvbs.c
> @@ -137,11 +137,11 @@ static int meson_encoder_cvbs_atomic_check(struct drm_bridge *bridge,
>   
>   	return -EINVAL;
>   }
>   
>   static void meson_encoder_cvbs_atomic_enable(struct drm_bridge *bridge,
> -					     struct drm_atomic_state *state)
> +					     struct drm_atomic_commit *state)
>   {
>   	struct meson_encoder_cvbs *encoder_cvbs = bridge_to_meson_encoder_cvbs(bridge);
>   	struct meson_drm *priv = encoder_cvbs->priv;
>   	const struct meson_cvbs_mode *meson_mode;
>   	struct drm_connector_state *conn_state;
> @@ -188,11 +188,11 @@ static void meson_encoder_cvbs_atomic_enable(struct drm_bridge *bridge,
>   		regmap_write(priv->hhi, HHI_VDAC_CNTL1_G12A, 0);
>   	}
>   }
>   
>   static void meson_encoder_cvbs_atomic_disable(struct drm_bridge *bridge,
> -					      struct drm_atomic_state *state)
> +					      struct drm_atomic_commit *state)
>   {
>   	struct meson_encoder_cvbs *meson_encoder_cvbs =
>   					bridge_to_meson_encoder_cvbs(bridge);
>   	struct meson_drm *priv = meson_encoder_cvbs->priv;
>   
> diff --git a/drivers/gpu/drm/meson/meson_encoder_dsi.c b/drivers/gpu/drm/meson/meson_encoder_dsi.c
> index eba246791c686da5b536be9baf341ed22fdfcda1..c1f4685073bbc0e54cad61be1f4ae29426c4b3da 100644
> --- a/drivers/gpu/drm/meson/meson_encoder_dsi.c
> +++ b/drivers/gpu/drm/meson/meson_encoder_dsi.c
> @@ -40,11 +40,11 @@ static int meson_encoder_dsi_attach(struct drm_bridge *bridge,
>   	return drm_bridge_attach(encoder, encoder_dsi->bridge.next_bridge,
>   				 &encoder_dsi->bridge, flags);
>   }
>   
>   static void meson_encoder_dsi_atomic_enable(struct drm_bridge *bridge,
> -					    struct drm_atomic_state *state)
> +					    struct drm_atomic_commit *state)
>   {
>   	struct meson_encoder_dsi *encoder_dsi = bridge_to_meson_encoder_dsi(bridge);
>   	struct meson_drm *priv = encoder_dsi->priv;
>   	struct drm_connector_state *conn_state;
>   	struct drm_crtc_state *crtc_state;
> @@ -77,11 +77,11 @@ static void meson_encoder_dsi_atomic_enable(struct drm_bridge *bridge,
>   
>   	writel_relaxed(1, priv->io_base + _REG(ENCL_VIDEO_EN));
>   }
>   
>   static void meson_encoder_dsi_atomic_disable(struct drm_bridge *bridge,
> -					     struct drm_atomic_state *state)
> +					     struct drm_atomic_commit *state)
>   {
>   	struct meson_encoder_dsi *meson_encoder_dsi =
>   					bridge_to_meson_encoder_dsi(bridge);
>   	struct meson_drm *priv = meson_encoder_dsi->priv;
>   
> diff --git a/drivers/gpu/drm/meson/meson_encoder_hdmi.c b/drivers/gpu/drm/meson/meson_encoder_hdmi.c
> index 1abb0572bb5fd4e8d9429db8dc0799998a708cb3..d766625aa1d0de298d61a4d1c751ea5d5452d39b 100644
> --- a/drivers/gpu/drm/meson/meson_encoder_hdmi.c
> +++ b/drivers/gpu/drm/meson/meson_encoder_hdmi.c
> @@ -187,11 +187,11 @@ static enum drm_mode_status meson_encoder_hdmi_mode_valid(struct drm_bridge *bri
>   
>   	return meson_vclk_vic_supported_freq(priv, phy_freq, vclk_freq);
>   }
>   
>   static void meson_encoder_hdmi_atomic_enable(struct drm_bridge *bridge,
> -					     struct drm_atomic_state *state)
> +					     struct drm_atomic_commit *state)
>   {
>   	struct meson_encoder_hdmi *encoder_hdmi = bridge_to_meson_encoder_hdmi(bridge);
>   	unsigned int ycrcb_map = VPU_HDMI_OUTPUT_CBYCR;
>   	struct meson_drm *priv = encoder_hdmi->priv;
>   	struct drm_connector_state *conn_state;
> @@ -250,11 +250,11 @@ static void meson_encoder_hdmi_atomic_enable(struct drm_bridge *bridge,
>   	else
>   		writel_relaxed(1, priv->io_base + _REG(ENCP_VIDEO_EN));
>   }
>   
>   static void meson_encoder_hdmi_atomic_disable(struct drm_bridge *bridge,
> -					      struct drm_atomic_state *state)
> +					      struct drm_atomic_commit *state)
>   {
>   	struct meson_encoder_hdmi *encoder_hdmi = bridge_to_meson_encoder_hdmi(bridge);
>   	struct meson_drm *priv = encoder_hdmi->priv;
>   
>   	writel_bits_relaxed(0x3, 0,
> diff --git a/drivers/gpu/drm/meson/meson_overlay.c b/drivers/gpu/drm/meson/meson_overlay.c
> index 783572b16963edeab6099f71df5e10d347bca0b1..7047807f1a3e2ac0ac88a49bc48c976121c6eed9 100644
> --- a/drivers/gpu/drm/meson/meson_overlay.c
> +++ b/drivers/gpu/drm/meson/meson_overlay.c
> @@ -165,11 +165,11 @@ struct meson_overlay {
>   #define to_meson_overlay(x) container_of(x, struct meson_overlay, base)
>   
>   #define FRAC_16_16(mult, div)    (((mult) << 16) / (div))
>   
>   static int meson_overlay_atomic_check(struct drm_plane *plane,
> -				      struct drm_atomic_state *state)
> +				      struct drm_atomic_commit *state)
>   {
>   	struct drm_plane_state *new_plane_state = drm_atomic_get_new_plane_state(state,
>   										 plane);
>   	struct drm_crtc_state *crtc_state;
>   
> @@ -468,11 +468,11 @@ static void meson_overlay_setup_scaler_params(struct meson_drm *priv,
>   	priv->viu.vpp_vsc_region4_endp = vsc_endp - vsc_startp;
>   	priv->viu.vpp_vsc_start_phase_step = ratio_y << 6;
>   }
>   
>   static void meson_overlay_atomic_update(struct drm_plane *plane,
> -					struct drm_atomic_state *state)
> +					struct drm_atomic_commit *state)
>   {
>   	struct meson_overlay *meson_overlay = to_meson_overlay(plane);
>   	struct drm_plane_state *new_state = drm_atomic_get_new_plane_state(state,
>   									   plane);
>   	struct drm_framebuffer *fb = new_state->fb;
> @@ -722,11 +722,11 @@ static void meson_overlay_atomic_update(struct drm_plane *plane,
>   
>   	DRM_DEBUG_DRIVER("\n");
>   }
>   
>   static void meson_overlay_atomic_disable(struct drm_plane *plane,
> -				       struct drm_atomic_state *state)
> +				       struct drm_atomic_commit *state)
>   {
>   	struct meson_overlay *meson_overlay = to_meson_overlay(plane);
>   	struct meson_drm *priv = meson_overlay->priv;
>   
>   	DRM_DEBUG_DRIVER("\n");
> diff --git a/drivers/gpu/drm/meson/meson_plane.c b/drivers/gpu/drm/meson/meson_plane.c
> index f8d0e0874a5d677540f252761476070f8d1c357f..2d88fe87a11acdaca229c3eb8198b9be08cb8afc 100644
> --- a/drivers/gpu/drm/meson/meson_plane.c
> +++ b/drivers/gpu/drm/meson/meson_plane.c
> @@ -71,11 +71,11 @@ struct meson_plane {
>   #define to_meson_plane(x) container_of(x, struct meson_plane, base)
>   
>   #define FRAC_16_16(mult, div)    (((mult) << 16) / (div))
>   
>   static int meson_plane_atomic_check(struct drm_plane *plane,
> -				    struct drm_atomic_state *state)
> +				    struct drm_atomic_commit *state)
>   {
>   	struct drm_plane_state *new_plane_state = drm_atomic_get_new_plane_state(state,
>   										 plane);
>   	struct drm_crtc_state *crtc_state;
>   
> @@ -130,11 +130,11 @@ static u32 meson_g12a_afbcd_line_stride(struct meson_drm *priv)
>   
>   	return ((line_stride + 1) >> 1) << 1;
>   }
>   
>   static void meson_plane_atomic_update(struct drm_plane *plane,
> -				      struct drm_atomic_state *state)
> +				      struct drm_atomic_commit *state)
>   {
>   	struct meson_plane *meson_plane = to_meson_plane(plane);
>   	struct drm_plane_state *new_state = drm_atomic_get_new_plane_state(state,
>   									   plane);
>   	struct drm_rect dest = drm_plane_state_dest(new_state);
> @@ -396,11 +396,11 @@ static void meson_plane_atomic_update(struct drm_plane *plane,
>   
>   	spin_unlock_irqrestore(&priv->drm->event_lock, flags);
>   }
>   
>   static void meson_plane_atomic_disable(struct drm_plane *plane,
> -				       struct drm_atomic_state *state)
> +				       struct drm_atomic_commit *state)
>   {
>   	struct meson_plane *meson_plane = to_meson_plane(plane);
>   	struct meson_drm *priv = meson_plane->priv;
>   
>   	if (priv->afbcd.ops) {
> diff --git a/drivers/gpu/drm/mgag200/mgag200_drv.h b/drivers/gpu/drm/mgag200/mgag200_drv.h
> index a875c4bf8cbe4c794597ad0e14ac019febfad9ad..3732c62351bbb391091e5e3b2b07935a2a55df55 100644
> --- a/drivers/gpu/drm/mgag200/mgag200_drv.h
> +++ b/drivers/gpu/drm/mgag200/mgag200_drv.h
> @@ -251,18 +251,18 @@ struct mgag200_device_funcs {
>   	/*
>   	 * Validate that the given state can be programmed into PIXPLLC. On
>   	 * success, the calculated parameters should be stored in the CRTC's
>   	 * state in struct @mgag200_crtc_state.pixpllc.
>   	 */
> -	int (*pixpllc_atomic_check)(struct drm_crtc *crtc, struct drm_atomic_state *new_state);
> +	int (*pixpllc_atomic_check)(struct drm_crtc *crtc, struct drm_atomic_commit *new_state);
>   
>   	/*
>   	 * Program PIXPLLC from the CRTC state. The parameters should have been
>   	 * stored in struct @mgag200_crtc_state.pixpllc by the corresponding
>   	 * implementation of @pixpllc_atomic_check.
>   	 */
> -	void (*pixpllc_atomic_update)(struct drm_crtc *crtc, struct drm_atomic_state *old_state);
> +	void (*pixpllc_atomic_update)(struct drm_crtc *crtc, struct drm_atomic_commit *old_state);
>   };
>   
>   struct mga_device {
>   	struct drm_device base;
>   
> @@ -330,15 +330,15 @@ int mgag200_device_init(struct mga_device *mdev,
>   				/* mgag200_<device type>.c */
>   struct mga_device *mgag200_g200_device_create(struct pci_dev *pdev, const struct drm_driver *drv);
>   struct mga_device *mgag200_g200se_device_create(struct pci_dev *pdev, const struct drm_driver *drv,
>   						enum mga_type type);
>   void mgag200_g200wb_init_registers(struct mga_device *mdev);
> -void mgag200_g200wb_pixpllc_atomic_update(struct drm_crtc *crtc, struct drm_atomic_state *old_state);
> +void mgag200_g200wb_pixpllc_atomic_update(struct drm_crtc *crtc, struct drm_atomic_commit *old_state);
>   struct mga_device *mgag200_g200wb_device_create(struct pci_dev *pdev, const struct drm_driver *drv);
>   struct mga_device *mgag200_g200ev_device_create(struct pci_dev *pdev, const struct drm_driver *drv);
>   void mgag200_g200eh_init_registers(struct mga_device *mdev);
> -void mgag200_g200eh_pixpllc_atomic_update(struct drm_crtc *crtc, struct drm_atomic_state *old_state);
> +void mgag200_g200eh_pixpllc_atomic_update(struct drm_crtc *crtc, struct drm_atomic_commit *old_state);
>   struct mga_device *mgag200_g200eh_device_create(struct pci_dev *pdev,
>   						const struct drm_driver *drv);
>   struct mga_device *mgag200_g200eh3_device_create(struct pci_dev *pdev,
>   						 const struct drm_driver *drv);
>   struct mga_device *mgag200_g200eh5_device_create(struct pci_dev *pdev,
> @@ -354,25 +354,25 @@ struct mga_device *mgag200_g200ew3_device_create(struct pci_dev *pdev,
>   
>   struct drm_crtc;
>   struct drm_crtc_state;
>   struct drm_display_mode;
>   struct drm_plane;
> -struct drm_atomic_state;
> +struct drm_atomic_commit;
>   struct drm_scanout_buffer;
>   
>   extern const uint32_t mgag200_primary_plane_formats[];
>   extern const size_t   mgag200_primary_plane_formats_size;
>   extern const uint64_t mgag200_primary_plane_fmtmods[];
>   
>   int mgag200_primary_plane_helper_atomic_check(struct drm_plane *plane,
> -					      struct drm_atomic_state *new_state);
> +					      struct drm_atomic_commit *new_state);
>   void mgag200_primary_plane_helper_atomic_update(struct drm_plane *plane,
> -						struct drm_atomic_state *old_state);
> +						struct drm_atomic_commit *old_state);
>   void mgag200_primary_plane_helper_atomic_enable(struct drm_plane *plane,
> -						struct drm_atomic_state *state);
> +						struct drm_atomic_commit *state);
>   void mgag200_primary_plane_helper_atomic_disable(struct drm_plane *plane,
> -						 struct drm_atomic_state *old_state);
> +						 struct drm_atomic_commit *old_state);
>   int mgag200_primary_plane_helper_get_scanout_buffer(struct drm_plane *plane,
>   						    struct drm_scanout_buffer *sb);
>   
>   #define MGAG200_PRIMARY_PLANE_HELPER_FUNCS \
>   	DRM_GEM_SHADOW_PLANE_HELPER_FUNCS, \
> @@ -393,14 +393,14 @@ void mgag200_crtc_load_gamma(struct mga_device *mdev,
>   			     const struct drm_format_info *format,
>   			     struct drm_color_lut *lut);
>   
>   enum drm_mode_status mgag200_crtc_helper_mode_valid(struct drm_crtc *crtc,
>   						    const struct drm_display_mode *mode);
> -int mgag200_crtc_helper_atomic_check(struct drm_crtc *crtc, struct drm_atomic_state *new_state);
> -void mgag200_crtc_helper_atomic_flush(struct drm_crtc *crtc, struct drm_atomic_state *old_state);
> -void mgag200_crtc_helper_atomic_enable(struct drm_crtc *crtc, struct drm_atomic_state *old_state);
> -void mgag200_crtc_helper_atomic_disable(struct drm_crtc *crtc, struct drm_atomic_state *old_state);
> +int mgag200_crtc_helper_atomic_check(struct drm_crtc *crtc, struct drm_atomic_commit *new_state);
> +void mgag200_crtc_helper_atomic_flush(struct drm_crtc *crtc, struct drm_atomic_commit *old_state);
> +void mgag200_crtc_helper_atomic_enable(struct drm_crtc *crtc, struct drm_atomic_commit *old_state);
> +void mgag200_crtc_helper_atomic_disable(struct drm_crtc *crtc, struct drm_atomic_commit *old_state);
>   
>   #define MGAG200_CRTC_HELPER_FUNCS \
>   	.mode_valid = mgag200_crtc_helper_mode_valid, \
>   	.atomic_check = mgag200_crtc_helper_atomic_check, \
>   	.atomic_flush = mgag200_crtc_helper_atomic_flush, \
> diff --git a/drivers/gpu/drm/mgag200/mgag200_g200.c b/drivers/gpu/drm/mgag200/mgag200_g200.c
> index a5e291b344dbd25f5f911a99ff97e43f7d057c5c..9e6b4618fadda252d2e3941e00ef8225cd9424bf 100644
> --- a/drivers/gpu/drm/mgag200/mgag200_g200.c
> +++ b/drivers/gpu/drm/mgag200/mgag200_g200.c
> @@ -60,11 +60,11 @@ static void mgag200_g200_init_registers(struct mgag200_g200_device *g200)
>   
>   /*
>    * PIXPLLC
>    */
>   
> -static int mgag200_g200_pixpllc_atomic_check(struct drm_crtc *crtc, struct drm_atomic_state *new_state)
> +static int mgag200_g200_pixpllc_atomic_check(struct drm_crtc *crtc, struct drm_atomic_commit *new_state)
>   {
>   	static const int post_div_max = 7;
>   	static const int in_div_min = 1;
>   	static const int in_div_max = 6;
>   	static const int feed_div_min = 7;
> @@ -136,11 +136,11 @@ static int mgag200_g200_pixpllc_atomic_check(struct drm_crtc *crtc, struct drm_a
>   
>   	return 0;
>   }
>   
>   static void mgag200_g200_pixpllc_atomic_update(struct drm_crtc *crtc,
> -					       struct drm_atomic_state *old_state)
> +					       struct drm_atomic_commit *old_state)
>   {
>   	struct drm_device *dev = crtc->dev;
>   	struct mga_device *mdev = to_mga_device(dev);
>   	struct drm_crtc_state *crtc_state = crtc->state;
>   	struct mgag200_crtc_state *mgag200_crtc_state = to_mgag200_crtc_state(crtc_state);
> diff --git a/drivers/gpu/drm/mgag200/mgag200_g200eh.c b/drivers/gpu/drm/mgag200/mgag200_g200eh.c
> index d2aa931f579d911e4d1d8c4b61ca3d308e8dc00f..e64bfeafbefc4d2068e65aae24b8f1e3e8fa0311 100644
> --- a/drivers/gpu/drm/mgag200/mgag200_g200eh.c
> +++ b/drivers/gpu/drm/mgag200/mgag200_g200eh.c
> @@ -39,11 +39,11 @@ void mgag200_g200eh_init_registers(struct mga_device *mdev)
>   /*
>    * PIXPLLC
>    */
>   
>   static int mgag200_g200eh_pixpllc_atomic_check(struct drm_crtc *crtc,
> -					       struct drm_atomic_state *new_state)
> +					       struct drm_atomic_commit *new_state)
>   {
>   	static const unsigned int vcomax = 800000;
>   	static const unsigned int vcomin = 400000;
>   	static const unsigned int pllreffreq = 33333;
>   
> @@ -89,11 +89,11 @@ static int mgag200_g200eh_pixpllc_atomic_check(struct drm_crtc *crtc,
>   
>   	return 0;
>   }
>   
>   void mgag200_g200eh_pixpllc_atomic_update(struct drm_crtc *crtc,
> -					  struct drm_atomic_state *old_state)
> +					  struct drm_atomic_commit *old_state)
>   {
>   	struct drm_device *dev = crtc->dev;
>   	struct mga_device *mdev = to_mga_device(dev);
>   	struct drm_crtc_state *crtc_state = crtc->state;
>   	struct mgag200_crtc_state *mgag200_crtc_state = to_mgag200_crtc_state(crtc_state);
> diff --git a/drivers/gpu/drm/mgag200/mgag200_g200eh3.c b/drivers/gpu/drm/mgag200/mgag200_g200eh3.c
> index 7bea7a728f5625f7f42d1b0f1e5f4770af922760..183b7676ea6a14ce9758b9f07d9bf4be38ba0096 100644
> --- a/drivers/gpu/drm/mgag200/mgag200_g200eh3.c
> +++ b/drivers/gpu/drm/mgag200/mgag200_g200eh3.c
> @@ -14,11 +14,11 @@
>   /*
>    * PIXPLLC
>    */
>   
>   static int mgag200_g200eh3_pixpllc_atomic_check(struct drm_crtc *crtc,
> -						struct drm_atomic_state *new_state)
> +						struct drm_atomic_commit *new_state)
>   {
>   	static const unsigned int vcomax = 3000000;
>   	static const unsigned int vcomin = 1500000;
>   	static const unsigned int pllreffreq = 25000;
>   
> diff --git a/drivers/gpu/drm/mgag200/mgag200_g200eh5.c b/drivers/gpu/drm/mgag200/mgag200_g200eh5.c
> index 36da6529d74fc3dca9e6e27cb153f763ca0bbb67..dc375c055b0e68ac5397d9b1f67a065cab9f08c4 100644
> --- a/drivers/gpu/drm/mgag200/mgag200_g200eh5.c
> +++ b/drivers/gpu/drm/mgag200/mgag200_g200eh5.c
> @@ -16,11 +16,11 @@
>   /*
>    * PIXPLLC
>    */
>   
>   static int mgag200_g200eh5_pixpllc_atomic_check(struct drm_crtc *crtc,
> -						struct drm_atomic_state *new_state)
> +						struct drm_atomic_commit *new_state)
>   {
>   	const unsigned long long VCO_MAX = 10 * GIGA; // Hz
>   	const unsigned long long VCO_MIN = 2500 * MEGA; // Hz
>   	const unsigned long long PLL_FREQ_REF = 25 * MEGA; // Hz
>   
> diff --git a/drivers/gpu/drm/mgag200/mgag200_g200er.c b/drivers/gpu/drm/mgag200/mgag200_g200er.c
> index 8fa8fe943abfd75b2e775b45dcc8782b561bdb91..205678a57bfe9f165e5ba1cfe54269b7119034ff 100644
> --- a/drivers/gpu/drm/mgag200/mgag200_g200er.c
> +++ b/drivers/gpu/drm/mgag200/mgag200_g200er.c
> @@ -56,11 +56,11 @@ static void mgag200_g200er_reset_tagfifo(struct mga_device *mdev)
>   /*
>    * PIXPLLC
>    */
>   
>   static int mgag200_g200er_pixpllc_atomic_check(struct drm_crtc *crtc,
> -					       struct drm_atomic_state *new_state)
> +					       struct drm_atomic_commit *new_state)
>   {
>   	static const unsigned int vcomax = 1488000;
>   	static const unsigned int vcomin = 1056000;
>   	static const unsigned int pllreffreq = 48000;
>   	static const unsigned int m_div_val[] = { 1, 2, 4, 8 };
> @@ -117,11 +117,11 @@ static int mgag200_g200er_pixpllc_atomic_check(struct drm_crtc *crtc,
>   
>   	return 0;
>   }
>   
>   static void mgag200_g200er_pixpllc_atomic_update(struct drm_crtc *crtc,
> -						 struct drm_atomic_state *old_state)
> +						 struct drm_atomic_commit *old_state)
>   {
>   	struct drm_device *dev = crtc->dev;
>   	struct mga_device *mdev = to_mga_device(dev);
>   	struct drm_crtc_state *crtc_state = crtc->state;
>   	struct mgag200_crtc_state *mgag200_crtc_state = to_mgag200_crtc_state(crtc_state);
> @@ -180,11 +180,11 @@ static const struct drm_plane_helper_funcs mgag200_g200er_primary_plane_helper_f
>   static const struct drm_plane_funcs mgag200_g200er_primary_plane_funcs = {
>   	MGAG200_PRIMARY_PLANE_FUNCS,
>   };
>   
>   static void mgag200_g200er_crtc_helper_atomic_enable(struct drm_crtc *crtc,
> -						     struct drm_atomic_state *old_state)
> +						     struct drm_atomic_commit *old_state)
>   {
>   	struct drm_device *dev = crtc->dev;
>   	struct mga_device *mdev = to_mga_device(dev);
>   	const struct mgag200_device_funcs *funcs = mdev->funcs;
>   	struct drm_crtc_state *crtc_state = crtc->state;
> diff --git a/drivers/gpu/drm/mgag200/mgag200_g200ev.c b/drivers/gpu/drm/mgag200/mgag200_g200ev.c
> index 3fadbeb10af965c3c6ae90cbb3969204218c4e93..d60693ac0749d8b11f9747cc31aee8c5677df0d1 100644
> --- a/drivers/gpu/drm/mgag200/mgag200_g200ev.c
> +++ b/drivers/gpu/drm/mgag200/mgag200_g200ev.c
> @@ -45,11 +45,11 @@ static void mgag200_g200ev_set_hiprilvl(struct mga_device *mdev)
>   /*
>    * PIXPLLC
>    */
>   
>   static int mgag200_g200ev_pixpllc_atomic_check(struct drm_crtc *crtc,
> -					       struct drm_atomic_state *new_state)
> +					       struct drm_atomic_commit *new_state)
>   {
>   	static const unsigned int vcomax = 550000;
>   	static const unsigned int vcomin = 150000;
>   	static const unsigned int pllreffreq = 50000;
>   
> @@ -96,11 +96,11 @@ static int mgag200_g200ev_pixpllc_atomic_check(struct drm_crtc *crtc,
>   
>   	return 0;
>   }
>   
>   static void mgag200_g200ev_pixpllc_atomic_update(struct drm_crtc *crtc,
> -						 struct drm_atomic_state *old_state)
> +						 struct drm_atomic_commit *old_state)
>   {
>   	struct drm_device *dev = crtc->dev;
>   	struct mga_device *mdev = to_mga_device(dev);
>   	struct drm_crtc_state *crtc_state = crtc->state;
>   	struct mgag200_crtc_state *mgag200_crtc_state = to_mgag200_crtc_state(crtc_state);
> @@ -181,11 +181,11 @@ static const struct drm_plane_helper_funcs mgag200_g200ev_primary_plane_helper_f
>   static const struct drm_plane_funcs mgag200_g200ev_primary_plane_funcs = {
>   	MGAG200_PRIMARY_PLANE_FUNCS,
>   };
>   
>   static void mgag200_g200ev_crtc_helper_atomic_enable(struct drm_crtc *crtc,
> -						     struct drm_atomic_state *old_state)
> +						     struct drm_atomic_commit *old_state)
>   {
>   	struct drm_device *dev = crtc->dev;
>   	struct mga_device *mdev = to_mga_device(dev);
>   	const struct mgag200_device_funcs *funcs = mdev->funcs;
>   	struct drm_crtc_state *crtc_state = crtc->state;
> diff --git a/drivers/gpu/drm/mgag200/mgag200_g200ew3.c b/drivers/gpu/drm/mgag200/mgag200_g200ew3.c
> index e387a455eae5c9ee8cabea9ee30f2ddeadb315c2..9c14d0eb66bca6f00a3331cbe319d88315f6e9eb 100644
> --- a/drivers/gpu/drm/mgag200/mgag200_g200ew3.c
> +++ b/drivers/gpu/drm/mgag200/mgag200_g200ew3.c
> @@ -21,11 +21,11 @@ static void mgag200_g200ew3_init_registers(struct mga_device *mdev)
>   /*
>    * PIXPLLC
>    */
>   
>   static int mgag200_g200ew3_pixpllc_atomic_check(struct drm_crtc *crtc,
> -						struct drm_atomic_state *new_state)
> +						struct drm_atomic_commit *new_state)
>   {
>   	static const unsigned int vcomax = 800000;
>   	static const unsigned int vcomin = 400000;
>   	static const unsigned int pllreffreq = 25000;
>   
> diff --git a/drivers/gpu/drm/mgag200/mgag200_g200se.c b/drivers/gpu/drm/mgag200/mgag200_g200se.c
> index a0ac19ee03531d5eaccf47d284c35e03b51e4079..e613c8ea66a52a1ddfe8047cb7818539a70e56f3 100644
> --- a/drivers/gpu/drm/mgag200/mgag200_g200se.c
> +++ b/drivers/gpu/drm/mgag200/mgag200_g200se.c
> @@ -111,11 +111,11 @@ static void mgag200_g200se_set_hiprilvl(struct mga_device *mdev,
>   /*
>    * PIXPLLC
>    */
>   
>   static int mgag200_g200se_00_pixpllc_atomic_check(struct drm_crtc *crtc,
> -						  struct drm_atomic_state *new_state)
> +						  struct drm_atomic_commit *new_state)
>   {
>   	static const unsigned int vcomax = 320000;
>   	static const unsigned int vcomin = 160000;
>   	static const unsigned int pllreffreq = 25000;
>   
> @@ -167,11 +167,11 @@ static int mgag200_g200se_00_pixpllc_atomic_check(struct drm_crtc *crtc,
>   
>   	return 0;
>   }
>   
>   static void mgag200_g200se_00_pixpllc_atomic_update(struct drm_crtc *crtc,
> -						    struct drm_atomic_state *old_state)
> +						    struct drm_atomic_commit *old_state)
>   {
>   	struct drm_device *dev = crtc->dev;
>   	struct mga_device *mdev = to_mga_device(dev);
>   	struct drm_crtc_state *crtc_state = crtc->state;
>   	struct mgag200_crtc_state *mgag200_crtc_state = to_mgag200_crtc_state(crtc_state);
> @@ -194,11 +194,11 @@ static void mgag200_g200se_00_pixpllc_atomic_update(struct drm_crtc *crtc,
>   	WREG_DAC(MGA1064_PIX_PLLC_N, xpixpllcn);
>   	WREG_DAC(MGA1064_PIX_PLLC_P, xpixpllcp);
>   }
>   
>   static int mgag200_g200se_04_pixpllc_atomic_check(struct drm_crtc *crtc,
> -						  struct drm_atomic_state *new_state)
> +						  struct drm_atomic_commit *new_state)
>   {
>   	static const unsigned int vcomax = 1600000;
>   	static const unsigned int vcomin = 800000;
>   	static const unsigned int pllreffreq = 25000;
>   	static const unsigned int pvalues_e4[] = {16, 14, 12, 10, 8, 6, 4, 2, 1};
> @@ -268,11 +268,11 @@ static int mgag200_g200se_04_pixpllc_atomic_check(struct drm_crtc *crtc,
>   
>   	return 0;
>   }
>   
>   static void mgag200_g200se_04_pixpllc_atomic_update(struct drm_crtc *crtc,
> -						    struct drm_atomic_state *old_state)
> +						    struct drm_atomic_commit *old_state)
>   {
>   	struct drm_device *dev = crtc->dev;
>   	struct mga_device *mdev = to_mga_device(dev);
>   	struct drm_crtc_state *crtc_state = crtc->state;
>   	struct mgag200_crtc_state *mgag200_crtc_state = to_mgag200_crtc_state(crtc_state);
> @@ -312,11 +312,11 @@ static const struct drm_plane_helper_funcs mgag200_g200se_primary_plane_helper_f
>   static const struct drm_plane_funcs mgag200_g200se_primary_plane_funcs = {
>   	MGAG200_PRIMARY_PLANE_FUNCS,
>   };
>   
>   static void mgag200_g200se_crtc_helper_atomic_enable(struct drm_crtc *crtc,
> -						     struct drm_atomic_state *old_state)
> +						     struct drm_atomic_commit *old_state)
>   {
>   	struct drm_device *dev = crtc->dev;
>   	struct mga_device *mdev = to_mga_device(dev);
>   	const struct mgag200_device_funcs *funcs = mdev->funcs;
>   	struct drm_crtc_state *crtc_state = crtc->state;
> diff --git a/drivers/gpu/drm/mgag200/mgag200_g200wb.c b/drivers/gpu/drm/mgag200/mgag200_g200wb.c
> index d847fa8ded8c8b3e9d9e5f4816019ad0355b92fa..f65d4238422f48d82c950e84ea520d9b9953ea03 100644
> --- a/drivers/gpu/drm/mgag200/mgag200_g200wb.c
> +++ b/drivers/gpu/drm/mgag200/mgag200_g200wb.c
> @@ -37,11 +37,11 @@ void mgag200_g200wb_init_registers(struct mga_device *mdev)
>   /*
>    * PIXPLLC
>    */
>   
>   static int mgag200_g200wb_pixpllc_atomic_check(struct drm_crtc *crtc,
> -					       struct drm_atomic_state *new_state)
> +					       struct drm_atomic_commit *new_state)
>   {
>   	static const unsigned int vcomax = 550000;
>   	static const unsigned int vcomin = 150000;
>   	static const unsigned int pllreffreq = 48000;
>   
> @@ -88,11 +88,11 @@ static int mgag200_g200wb_pixpllc_atomic_check(struct drm_crtc *crtc,
>   
>   	return 0;
>   }
>   
>   void mgag200_g200wb_pixpllc_atomic_update(struct drm_crtc *crtc,
> -					  struct drm_atomic_state *old_state)
> +					  struct drm_atomic_commit *old_state)
>   {
>   	struct drm_device *dev = crtc->dev;
>   	struct mga_device *mdev = to_mga_device(dev);
>   	struct drm_crtc_state *crtc_state = crtc->state;
>   	struct mgag200_crtc_state *mgag200_crtc_state = to_mgag200_crtc_state(crtc_state);
> diff --git a/drivers/gpu/drm/mgag200/mgag200_mode.c b/drivers/gpu/drm/mgag200/mgag200_mode.c
> index 8894a063b1a15f2d948e2eff41d92128e2fc6bc7..89b56b753fd41734ab79f5925f797273267f40c7 100644
> --- a/drivers/gpu/drm/mgag200/mgag200_mode.c
> +++ b/drivers/gpu/drm/mgag200/mgag200_mode.c
> @@ -472,11 +472,11 @@ const uint64_t mgag200_primary_plane_fmtmods[] = {
>   	DRM_FORMAT_MOD_LINEAR,
>   	DRM_FORMAT_MOD_INVALID
>   };
>   
>   int mgag200_primary_plane_helper_atomic_check(struct drm_plane *plane,
> -					      struct drm_atomic_state *new_state)
> +					      struct drm_atomic_commit *new_state)
>   {
>   	struct drm_plane_state *new_plane_state = drm_atomic_get_new_plane_state(new_state, plane);
>   	struct drm_framebuffer *new_fb = new_plane_state->fb;
>   	struct drm_framebuffer *fb = NULL;
>   	struct drm_crtc *new_crtc = new_plane_state->crtc;
> @@ -507,11 +507,11 @@ int mgag200_primary_plane_helper_atomic_check(struct drm_plane *plane,
>   
>   	return 0;
>   }
>   
>   void mgag200_primary_plane_helper_atomic_update(struct drm_plane *plane,
> -						struct drm_atomic_state *old_state)
> +						struct drm_atomic_commit *old_state)
>   {
>   	struct drm_device *dev = plane->dev;
>   	struct mga_device *mdev = to_mga_device(dev);
>   	struct drm_plane_state *plane_state = plane->state;
>   	struct drm_plane_state *old_plane_state = drm_atomic_get_old_plane_state(old_state, plane);
> @@ -530,11 +530,11 @@ void mgag200_primary_plane_helper_atomic_update(struct drm_plane *plane,
>   	mgag200_set_startadd(mdev, (u32)0);
>   	mgag200_set_offset(mdev, fb);
>   }
>   
>   void mgag200_primary_plane_helper_atomic_enable(struct drm_plane *plane,
> -						struct drm_atomic_state *state)
> +						struct drm_atomic_commit *state)
>   {
>   	struct drm_device *dev = plane->dev;
>   	struct mga_device *mdev = to_mga_device(dev);
>   	u8 seq1;
>   
> @@ -543,11 +543,11 @@ void mgag200_primary_plane_helper_atomic_enable(struct drm_plane *plane,
>   	WREG_SEQ(0x01, seq1);
>   	msleep(20);
>   }
>   
>   void mgag200_primary_plane_helper_atomic_disable(struct drm_plane *plane,
> -						 struct drm_atomic_state *old_state)
> +						 struct drm_atomic_commit *old_state)
>   {
>   	struct drm_device *dev = plane->dev;
>   	struct mga_device *mdev = to_mga_device(dev);
>   	u8 seq1;
>   
> @@ -606,11 +606,11 @@ enum drm_mode_status mgag200_crtc_helper_mode_valid(struct drm_crtc *crtc,
>   	}
>   
>   	return MODE_OK;
>   }
>   
> -int mgag200_crtc_helper_atomic_check(struct drm_crtc *crtc, struct drm_atomic_state *new_state)
> +int mgag200_crtc_helper_atomic_check(struct drm_crtc *crtc, struct drm_atomic_commit *new_state)
>   {
>   	struct drm_device *dev = crtc->dev;
>   	struct mga_device *mdev = to_mga_device(dev);
>   	const struct mgag200_device_funcs *funcs = mdev->funcs;
>   	struct drm_crtc_state *new_crtc_state = drm_atomic_get_new_crtc_state(new_state, crtc);
> @@ -640,11 +640,11 @@ int mgag200_crtc_helper_atomic_check(struct drm_crtc *crtc, struct drm_atomic_st
>   	}
>   
>   	return 0;
>   }
>   
> -void mgag200_crtc_helper_atomic_flush(struct drm_crtc *crtc, struct drm_atomic_state *old_state)
> +void mgag200_crtc_helper_atomic_flush(struct drm_crtc *crtc, struct drm_atomic_commit *old_state)
>   {
>   	struct drm_crtc_state *crtc_state = crtc->state;
>   	struct mgag200_crtc_state *mgag200_crtc_state = to_mgag200_crtc_state(crtc_state);
>   	struct drm_device *dev = crtc->dev;
>   	struct mga_device *mdev = to_mga_device(dev);
> @@ -657,11 +657,11 @@ void mgag200_crtc_helper_atomic_flush(struct drm_crtc *crtc, struct drm_atomic_s
>   		else
>   			mgag200_crtc_fill_gamma(mdev, format);
>   	}
>   }
>   
> -void mgag200_crtc_helper_atomic_enable(struct drm_crtc *crtc, struct drm_atomic_state *old_state)
> +void mgag200_crtc_helper_atomic_enable(struct drm_crtc *crtc, struct drm_atomic_commit *old_state)
>   {
>   	struct drm_device *dev = crtc->dev;
>   	struct mga_device *mdev = to_mga_device(dev);
>   	const struct mgag200_device_funcs *funcs = mdev->funcs;
>   	struct drm_crtc_state *crtc_state = crtc->state;
> @@ -681,11 +681,11 @@ void mgag200_crtc_helper_atomic_enable(struct drm_crtc *crtc, struct drm_atomic_
>   		mgag200_crtc_fill_gamma(mdev, format);
>   
>   	mgag200_enable_display(mdev);
>   }
>   
> -void mgag200_crtc_helper_atomic_disable(struct drm_crtc *crtc, struct drm_atomic_state *old_state)
> +void mgag200_crtc_helper_atomic_disable(struct drm_crtc *crtc, struct drm_atomic_commit *old_state)
>   {
>   	struct mga_device *mdev = to_mga_device(crtc->dev);
>   
>   	mgag200_disable_display(mdev);
>   }
> @@ -736,11 +736,11 @@ void mgag200_crtc_atomic_destroy_state(struct drm_crtc *crtc, struct drm_crtc_st
>   
>   /*
>    * Mode config
>    */
>   
> -static void mgag200_mode_config_helper_atomic_commit_tail(struct drm_atomic_state *state)
> +static void mgag200_mode_config_helper_atomic_commit_tail(struct drm_atomic_commit *state)
>   {
>   	struct mga_device *mdev = to_mga_device(state->dev);
>   
>   	/*
>   	 * Concurrent operations could possibly trigger a call to
> diff --git a/drivers/gpu/drm/mgag200/mgag200_vga_bmc.c b/drivers/gpu/drm/mgag200/mgag200_vga_bmc.c
> index a855f1734316184380d9c39e1964491a94087400..805636990b55f95a1519779bce1c60eb2428ed8a 100644
> --- a/drivers/gpu/drm/mgag200/mgag200_vga_bmc.c
> +++ b/drivers/gpu/drm/mgag200/mgag200_vga_bmc.c
> @@ -8,20 +8,20 @@
>   
>   #include "mgag200_ddc.h"
>   #include "mgag200_drv.h"
>   
>   static void mgag200_vga_bmc_encoder_atomic_disable(struct drm_encoder *encoder,
> -						   struct drm_atomic_state *state)
> +						   struct drm_atomic_commit *state)
>   {
>   	struct mga_device *mdev = to_mga_device(encoder->dev);
>   
>   	if (mdev->info->sync_bmc)
>   		mgag200_bmc_stop_scanout(mdev);
>   }
>   
>   static void mgag200_vga_bmc_encoder_atomic_enable(struct drm_encoder *encoder,
> -						  struct drm_atomic_state *state)
> +						  struct drm_atomic_commit *state)
>   {
>   	struct mga_device *mdev = to_mga_device(encoder->dev);
>   
>   	if (mdev->info->sync_bmc)
>   		mgag200_bmc_start_scanout(mdev);
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
> index 411a6fa832b53e312cf34a5c018f693c9d4688c6..42d0a529b4d515712de3ac2e6e46873406b61adc 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
> @@ -897,11 +897,11 @@ static void _dpu_crtc_setup_cp_blocks(struct drm_crtc *crtc)
>   		}
>   	}
>   }
>   
>   static void dpu_crtc_atomic_begin(struct drm_crtc *crtc,
> -		struct drm_atomic_state *state)
> +		struct drm_atomic_commit *state)
>   {
>   	struct dpu_crtc_state *cstate = to_dpu_crtc_state(crtc->state);
>   	struct drm_encoder *encoder;
>   
>   	if (!crtc->state->enable) {
> @@ -938,11 +938,11 @@ static void dpu_crtc_atomic_begin(struct drm_crtc *crtc,
>   	 * in command mode.
>   	 */
>   }
>   
>   static void dpu_crtc_atomic_flush(struct drm_crtc *crtc,
> -		struct drm_atomic_state *state)
> +		struct drm_atomic_commit *state)
>   {
>   	struct dpu_crtc *dpu_crtc;
>   	struct drm_device *dev;
>   	struct drm_plane *plane;
>   	struct msm_drm_private *priv;
> @@ -1186,11 +1186,11 @@ static void dpu_crtc_atomic_print_state(struct drm_printer *p,
>   			drm_printf(p, "\tdspp[%d]=%d\n", i, cstate->mixers[i].hw_dspp->idx - DSPP_0);
>   	}
>   }
>   
>   static void dpu_crtc_disable(struct drm_crtc *crtc,
> -			     struct drm_atomic_state *state)
> +			     struct drm_atomic_commit *state)
>   {
>   	struct drm_crtc_state *old_crtc_state = drm_atomic_get_old_crtc_state(state,
>   									      crtc);
>   	struct dpu_crtc *dpu_crtc = to_dpu_crtc(crtc);
>   	struct dpu_crtc_state *cstate = to_dpu_crtc_state(crtc->state);
> @@ -1265,11 +1265,11 @@ static void dpu_crtc_disable(struct drm_crtc *crtc,
>   
>   	pm_runtime_put_sync(crtc->dev->dev);
>   }
>   
>   static void dpu_crtc_enable(struct drm_crtc *crtc,
> -		struct drm_atomic_state *state)
> +		struct drm_atomic_commit *state)
>   {
>   	struct dpu_crtc *dpu_crtc = to_dpu_crtc(crtc);
>   	struct drm_encoder *encoder;
>   	bool request_bandwidth = false;
>   	struct drm_crtc_state *old_crtc_state;
> @@ -1322,11 +1322,11 @@ static bool dpu_crtc_needs_dirtyfb(struct drm_crtc_state *cstate)
>   }
>   
>   static int dpu_crtc_assign_planes(struct drm_crtc *crtc, struct drm_crtc_state *crtc_state)
>   {
>   	int total_planes = crtc->dev->mode_config.num_total_plane;
> -	struct drm_atomic_state *state = crtc_state->state;
> +	struct drm_atomic_commit *state = crtc_state->state;
>   	struct dpu_global_state *global_state;
>   	struct drm_plane_state **states;
>   	struct drm_plane *plane;
>   	int ret;
>   
> @@ -1518,11 +1518,11 @@ int dpu_crtc_check_mode_changed(struct drm_crtc_state *old_crtc_state,
>   
>   	return 0;
>   }
>   
>   static int dpu_crtc_atomic_check(struct drm_crtc *crtc,
> -		struct drm_atomic_state *state)
> +		struct drm_atomic_commit *state)
>   {
>   	struct drm_crtc_state *crtc_state = drm_atomic_get_new_crtc_state(state,
>   									  crtc);
>   	struct dpu_crtc *dpu_crtc = to_dpu_crtc(crtc);
>   	struct dpu_crtc_state *cstate = to_dpu_crtc_state(crtc_state);
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> index eba1d52211f68f3a70c6902fa4c6c9bd28705c51..778e231d496777f7157d54c549c20765afb4488f 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> @@ -653,11 +653,11 @@ struct drm_dsc_config *dpu_encoder_get_dsc_config(struct drm_encoder *drm_enc)
>   	return NULL;
>   }
>   
>   void dpu_encoder_update_topology(struct drm_encoder *drm_enc,
>   				 struct msm_display_topology *topology,
> -				 struct drm_atomic_state *state,
> +				 struct drm_atomic_commit *state,
>   				 const struct drm_display_mode *adj_mode)
>   {
>   	struct dpu_encoder_virt *dpu_enc = to_dpu_encoder_virt(drm_enc);
>   	struct msm_drm_private *priv = dpu_enc->base.dev->dev_private;
>   	struct msm_display_info *disp_info = &dpu_enc->disp_info;
> @@ -714,11 +714,11 @@ void dpu_encoder_update_topology(struct drm_encoder *drm_enc,
>   					      adj_mode))
>   			topology->num_cdm++;
>   	}
>   }
>   
> -bool dpu_encoder_needs_modeset(struct drm_encoder *drm_enc, struct drm_atomic_state *state)
> +bool dpu_encoder_needs_modeset(struct drm_encoder *drm_enc, struct drm_atomic_commit *state)
>   {
>   	struct drm_connector *connector;
>   	struct drm_connector_state *conn_state;
>   	struct drm_framebuffer *fb;
>   	struct dpu_encoder_virt *dpu_enc = to_dpu_encoder_virt(drm_enc);
> @@ -1333,11 +1333,11 @@ void dpu_encoder_virt_runtime_resume(struct drm_encoder *drm_enc)
>   out:
>   	mutex_unlock(&dpu_enc->enc_lock);
>   }
>   
>   static void dpu_encoder_virt_atomic_enable(struct drm_encoder *drm_enc,
> -					struct drm_atomic_state *state)
> +					struct drm_atomic_commit *state)
>   {
>   	struct dpu_encoder_virt *dpu_enc = NULL;
>   	int ret = 0;
>   	struct drm_display_mode *cur_mode = NULL;
>   
> @@ -1380,11 +1380,11 @@ static void dpu_encoder_virt_atomic_enable(struct drm_encoder *drm_enc,
>   out:
>   	mutex_unlock(&dpu_enc->enc_lock);
>   }
>   
>   static void dpu_encoder_virt_atomic_disable(struct drm_encoder *drm_enc,
> -					struct drm_atomic_state *state)
> +					struct drm_atomic_commit *state)
>   {
>   	struct dpu_encoder_virt *dpu_enc = NULL;
>   	struct drm_crtc *crtc;
>   	struct drm_crtc_state *old_state = NULL;
>   	int i = 0;
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h
> index ca1ca2e51d7ead0eb34b27f3168e6bb06a71a11a..4942097e7613791f3bea03e2bac5a9a4c32ae8d4 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h
> @@ -82,14 +82,14 @@ int dpu_encoder_get_crc(const struct drm_encoder *drm_enc, u32 *crcs, int pos);
>   
>   bool dpu_encoder_use_dsc_merge(struct drm_encoder *drm_enc);
>   
>   void dpu_encoder_update_topology(struct drm_encoder *drm_enc,
>   				 struct msm_display_topology *topology,
> -				 struct drm_atomic_state *state,
> +				 struct drm_atomic_commit *state,
>   				 const struct drm_display_mode *adj_mode);
>   
> -bool dpu_encoder_needs_modeset(struct drm_encoder *drm_enc, struct drm_atomic_state *state);
> +bool dpu_encoder_needs_modeset(struct drm_encoder *drm_enc, struct drm_atomic_commit *state);
>   
>   void dpu_encoder_prepare_wb_job(struct drm_encoder *drm_enc,
>   		struct drm_writeback_job *job);
>   
>   void dpu_encoder_cleanup_wb_job(struct drm_encoder *drm_enc,
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
> index 35f7af4743d7ef73561c9056febd7ee31f0033c8..657d956a6ca4ce7c30f88859dbd560adfbf3d99a 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
> @@ -329,11 +329,11 @@ dpu_kms_get_existing_global_state(struct dpu_kms *dpu_kms)
>   
>   /*
>    * This acquires the modeset lock set aside for global state, creates
>    * a new duplicated private object state.
>    */
> -struct dpu_global_state *dpu_kms_get_global_state(struct drm_atomic_state *s)
> +struct dpu_global_state *dpu_kms_get_global_state(struct drm_atomic_commit *s)
>   {
>   	struct msm_drm_private *priv = s->dev->dev_private;
>   	struct dpu_kms *dpu_kms = to_dpu_kms(priv->kms);
>   	struct drm_private_state *priv_state;
>   
> @@ -447,11 +447,11 @@ static void dpu_kms_disable_commit(struct msm_kms *kms)
>   {
>   	struct dpu_kms *dpu_kms = to_dpu_kms(kms);
>   	pm_runtime_put_sync(&dpu_kms->pdev->dev);
>   }
>   
> -static int dpu_kms_check_mode_changed(struct msm_kms *kms, struct drm_atomic_state *state)
> +static int dpu_kms_check_mode_changed(struct msm_kms *kms, struct drm_atomic_commit *state)
>   {
>   	struct drm_crtc_state *new_crtc_state;
>   	struct drm_crtc_state *old_crtc_state;
>   	struct drm_crtc *crtc;
>   	int i;
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h
> index bb3393bd102eb0091fd5be18a322fafde47e3178..e39831a397b165064f561e18a14b4ce0ec24e7fc 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h
> @@ -136,11 +136,11 @@ struct dpu_global_state {
>   };
>   
>   struct dpu_global_state
>   	*dpu_kms_get_existing_global_state(struct dpu_kms *dpu_kms);
>   struct dpu_global_state
> -	*__must_check dpu_kms_get_global_state(struct drm_atomic_state *s);
> +	*__must_check dpu_kms_get_global_state(struct drm_atomic_commit *s);
>   
>   /**
>    * Debugfs functions - extra helper functions for debugfs support
>    *
>    * Main debugfs documentation is located at,
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
> index 3c315d5805b81462e55ade8a8d3da22878d6959d..5642f3bc356884120ed2ea5ef2e195fdf3ff001a 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
> @@ -1047,11 +1047,11 @@ static bool dpu_plane_get_single_pipe_in_stage(struct dpu_plane_state *pstate,
>   
>   	return false;
>   }
>   
>   static int dpu_plane_atomic_check_sspp(struct drm_plane *plane,
> -				       struct drm_atomic_state *state,
> +				       struct drm_atomic_commit *state,
>   				       const struct drm_crtc_state *crtc_state)
>   {
>   	struct drm_plane_state *new_plane_state =
>   		drm_atomic_get_new_plane_state(state, plane);
>   	struct dpu_plane *pdpu = to_dpu_plane(plane);
> @@ -1168,11 +1168,11 @@ static int dpu_plane_try_multirect_shared(struct dpu_plane_state *pstate,
>   
>   	return false;
>   }
>   
>   static int dpu_plane_atomic_check(struct drm_plane *plane,
> -				  struct drm_atomic_state *state)
> +				  struct drm_atomic_commit *state)
>   {
>   	struct drm_plane_state *plane_state =
>   		drm_atomic_get_plane_state(state, plane);
>   	struct drm_plane_state *old_plane_state =
>   		drm_atomic_get_old_plane_state(state, plane);
> @@ -1248,11 +1248,11 @@ static int dpu_plane_assign_resource_in_stage(struct dpu_sw_pipe *pipe,
>   	return 0;
>   }
>   
>   static int dpu_plane_virtual_assign_resources(struct drm_crtc *crtc,
>   					      struct dpu_global_state *global_state,
> -					      struct drm_atomic_state *state,
> +					      struct drm_atomic_commit *state,
>   					      struct drm_plane_state *plane_state,
>   					      const struct drm_crtc_state *crtc_state,
>   					      struct drm_plane_state **prev_adjacent_plane_state)
>   {
>   	struct drm_plane *plane = plane_state->plane;
> @@ -1309,11 +1309,11 @@ static int dpu_plane_virtual_assign_resources(struct drm_crtc *crtc,
>   	return dpu_plane_atomic_check_sspp(plane, state, crtc_state);
>   }
>   
>   static int dpu_plane_assign_resources(struct drm_crtc *crtc,
>   				      struct dpu_global_state *global_state,
> -				      struct drm_atomic_state *state,
> +				      struct drm_atomic_commit *state,
>   				      struct drm_plane_state *plane_state,
>   				      const struct drm_crtc_state *crtc_state)
>   {
>   	struct drm_plane *plane = plane_state->plane;
>   	struct dpu_kms *dpu_kms = _dpu_plane_get_kms(plane);
> @@ -1347,11 +1347,11 @@ static int dpu_plane_assign_resources(struct drm_crtc *crtc,
>   
>   	return dpu_plane_atomic_check_sspp(plane, state, crtc_state);
>   }
>   
>   int dpu_assign_plane_resources(struct dpu_global_state *global_state,
> -			       struct drm_atomic_state *state,
> +			       struct drm_atomic_commit *state,
>   			       struct drm_crtc *crtc,
>   			       struct drm_plane_state **states,
>   			       unsigned int num_planes)
>   {
>   	struct drm_plane_state *prev_adjacent_plane_state[STAGES_PER_PLANE] = { NULL };
> @@ -1615,11 +1615,11 @@ static void _dpu_plane_atomic_disable(struct drm_plane *plane)
>   
>   	pstate->pending = true;
>   }
>   
>   static void dpu_plane_atomic_update(struct drm_plane *plane,
> -				struct drm_atomic_state *state)
> +				struct drm_atomic_commit *state)
>   {
>   	struct dpu_plane *pdpu = to_dpu_plane(plane);
>   	struct drm_plane_state *new_state = drm_atomic_get_new_plane_state(state,
>   									   plane);
>   
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.h
> index 1ef5a041b8acae270826f20ea9553cbfa35a9f82..d2e7c8c25115150fb8a366695d40fd8d5f2ae78e 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.h
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.h
> @@ -68,11 +68,11 @@ void dpu_plane_danger_signal_ctrl(struct drm_plane *plane, bool enable);
>   #else
>   static inline void dpu_plane_danger_signal_ctrl(struct drm_plane *plane, bool enable) {}
>   #endif
>   
>   int dpu_assign_plane_resources(struct dpu_global_state *global_state,
> -			       struct drm_atomic_state *state,
> +			       struct drm_atomic_commit *state,
>   			       struct drm_crtc *crtc,
>   			       struct drm_plane_state **states,
>   			       unsigned int num_planes);
>   
>   #endif /* _DPU_PLANE_H_ */
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.c
> index 7545c0293efbd8f7eb34a4ac56f616b7cadae1c0..54bd7c354b63849f61de382617d01a96a7d80e55 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.c
> @@ -24,11 +24,11 @@ static int dpu_wb_conn_get_modes(struct drm_connector *connector)
>   	return drm_add_modes_noedid(connector, dpu_kms->catalog->caps->max_mixer_width,
>   			dev->mode_config.max_height);
>   }
>   
>   static int dpu_wb_conn_atomic_check(struct drm_connector *connector,
> -				    struct drm_atomic_state *state)
> +				    struct drm_atomic_commit *state)
>   {
>   	struct drm_writeback_connector *wb_conn = drm_connector_to_writeback(connector);
>   	struct dpu_wb_connector *dpu_wb_conn = to_dpu_wb_conn(wb_conn);
>   	struct drm_connector_state *conn_state =
>   		drm_atomic_get_new_connector_state(state, connector);
> diff --git a/drivers/gpu/drm/msm/disp/mdp4/mdp4_crtc.c b/drivers/gpu/drm/msm/disp/mdp4/mdp4_crtc.c
> index e8066f9fd534339689fa1270e10fb0c0d366371a..57dfce58450b3298c8070fc5b43eb2c0966a832a 100644
> --- a/drivers/gpu/drm/msm/disp/mdp4/mdp4_crtc.c
> +++ b/drivers/gpu/drm/msm/disp/mdp4/mdp4_crtc.c
> @@ -253,11 +253,11 @@ static void mdp4_crtc_mode_set_nofb(struct drm_crtc *crtc)
>   		mdp4_write(mdp4_kms, REG_MDP4_DMA_E_QUANT(2), 0x00ff0000);
>   	}
>   }
>   
>   static void mdp4_crtc_atomic_disable(struct drm_crtc *crtc,
> -				     struct drm_atomic_state *state)
> +				     struct drm_atomic_commit *state)
>   {
>   	struct mdp4_crtc *mdp4_crtc = to_mdp4_crtc(crtc);
>   	struct mdp4_kms *mdp4_kms = get_kms(crtc);
>   	unsigned long flags;
>   
> @@ -282,11 +282,11 @@ static void mdp4_crtc_atomic_disable(struct drm_crtc *crtc,
>   
>   	mdp4_crtc->enabled = false;
>   }
>   
>   static void mdp4_crtc_atomic_enable(struct drm_crtc *crtc,
> -				    struct drm_atomic_state *state)
> +				    struct drm_atomic_commit *state)
>   {
>   	struct mdp4_crtc *mdp4_crtc = to_mdp4_crtc(crtc);
>   	struct mdp4_kms *mdp4_kms = get_kms(crtc);
>   
>   	DBG("%s", mdp4_crtc->name);
> @@ -305,27 +305,27 @@ static void mdp4_crtc_atomic_enable(struct drm_crtc *crtc,
>   
>   	mdp4_crtc->enabled = true;
>   }
>   
>   static int mdp4_crtc_atomic_check(struct drm_crtc *crtc,
> -		struct drm_atomic_state *state)
> +		struct drm_atomic_commit *state)
>   {
>   	struct mdp4_crtc *mdp4_crtc = to_mdp4_crtc(crtc);
>   	DBG("%s: check", mdp4_crtc->name);
>   	// TODO anything else to check?
>   	return 0;
>   }
>   
>   static void mdp4_crtc_atomic_begin(struct drm_crtc *crtc,
> -				   struct drm_atomic_state *state)
> +				   struct drm_atomic_commit *state)
>   {
>   	struct mdp4_crtc *mdp4_crtc = to_mdp4_crtc(crtc);
>   	DBG("%s: begin", mdp4_crtc->name);
>   }
>   
>   static void mdp4_crtc_atomic_flush(struct drm_crtc *crtc,
> -				   struct drm_atomic_state *state)
> +				   struct drm_atomic_commit *state)
>   {
>   	struct mdp4_crtc *mdp4_crtc = to_mdp4_crtc(crtc);
>   	struct drm_device *dev = crtc->dev;
>   	unsigned long flags;
>   
> diff --git a/drivers/gpu/drm/msm/disp/mdp4/mdp4_plane.c b/drivers/gpu/drm/msm/disp/mdp4/mdp4_plane.c
> index 098c3b5ff2b285ef3dbba3b6b6dc492f4f515001..9459f70ce0badc718a45de4ed7fd0b76dfc3a61d 100644
> --- a/drivers/gpu/drm/msm/disp/mdp4/mdp4_plane.c
> +++ b/drivers/gpu/drm/msm/disp/mdp4/mdp4_plane.c
> @@ -100,17 +100,17 @@ static void mdp4_plane_cleanup_fb(struct drm_plane *plane,
>   	msm_framebuffer_cleanup(fb, false);
>   }
>   
>   
>   static int mdp4_plane_atomic_check(struct drm_plane *plane,
> -		struct drm_atomic_state *state)
> +		struct drm_atomic_commit *state)
>   {
>   	return 0;
>   }
>   
>   static void mdp4_plane_atomic_update(struct drm_plane *plane,
> -				     struct drm_atomic_state *state)
> +				     struct drm_atomic_commit *state)
>   {
>   	struct drm_plane_state *new_state = drm_atomic_get_new_plane_state(state,
>   									   plane);
>   	int ret;
>   
> diff --git a/drivers/gpu/drm/msm/disp/mdp5/mdp5_crtc.c b/drivers/gpu/drm/msm/disp/mdp5/mdp5_crtc.c
> index b29541bc484384e6ab828c07d83f0196bb68e4ae..4c4a897fc1eeee17a943669b0f6a55c29ab86b8a 100644
> --- a/drivers/gpu/drm/msm/disp/mdp5/mdp5_crtc.c
> +++ b/drivers/gpu/drm/msm/disp/mdp5/mdp5_crtc.c
> @@ -483,11 +483,11 @@ static u32 mdp5_crtc_get_vblank_counter(struct drm_crtc *crtc)
>   
>   	return mdp5_encoder_get_framecount(encoder);
>   }
>   
>   static void mdp5_crtc_atomic_disable(struct drm_crtc *crtc,
> -				     struct drm_atomic_state *state)
> +				     struct drm_atomic_commit *state)
>   {
>   	struct mdp5_crtc *mdp5_crtc = to_mdp5_crtc(crtc);
>   	struct mdp5_crtc_state *mdp5_cstate = to_mdp5_crtc_state(crtc->state);
>   	struct mdp5_kms *mdp5_kms = get_kms(crtc);
>   	struct device *dev = &mdp5_kms->pdev->dev;
> @@ -529,11 +529,11 @@ static void mdp5_crtc_vblank_on(struct drm_crtc *crtc)
>   
>   	drm_crtc_vblank_on(crtc);
>   }
>   
>   static void mdp5_crtc_atomic_enable(struct drm_crtc *crtc,
> -				    struct drm_atomic_state *state)
> +				    struct drm_atomic_commit *state)
>   {
>   	struct mdp5_crtc *mdp5_crtc = to_mdp5_crtc(crtc);
>   	struct mdp5_crtc_state *mdp5_cstate = to_mdp5_crtc_state(crtc->state);
>   	struct mdp5_kms *mdp5_kms = get_kms(crtc);
>   	struct device *dev = &mdp5_kms->pdev->dev;
> @@ -688,11 +688,11 @@ static enum mdp_mixer_stage_id get_start_stage(struct drm_crtc *crtc,
>   
>   	return STAGE_BASE;
>   }
>   
>   static int mdp5_crtc_atomic_check(struct drm_crtc *crtc,
> -		struct drm_atomic_state *state)
> +		struct drm_atomic_commit *state)
>   {
>   	struct drm_crtc_state *crtc_state = drm_atomic_get_new_crtc_state(state,
>   									  crtc);
>   	struct mdp5_crtc_state *mdp5_cstate = to_mdp5_crtc_state(crtc_state);
>   	struct mdp5_interface *intf = mdp5_cstate->pipeline.intf;
> @@ -785,17 +785,17 @@ static int mdp5_crtc_atomic_check(struct drm_crtc *crtc,
>   
>   	return 0;
>   }
>   
>   static void mdp5_crtc_atomic_begin(struct drm_crtc *crtc,
> -				   struct drm_atomic_state *state)
> +				   struct drm_atomic_commit *state)
>   {
>   	DBG("%s: begin", crtc->name);
>   }
>   
>   static void mdp5_crtc_atomic_flush(struct drm_crtc *crtc,
> -				   struct drm_atomic_state *state)
> +				   struct drm_atomic_commit *state)
>   {
>   	struct mdp5_crtc *mdp5_crtc = to_mdp5_crtc(crtc);
>   	struct mdp5_crtc_state *mdp5_cstate = to_mdp5_crtc_state(crtc->state);
>   	struct drm_device *dev = crtc->dev;
>   	unsigned long flags;
> diff --git a/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c b/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c
> index 2d26b07b06f54bbe8e26e538c155b8de994a4543..0a004ab9fc856c8cf62e935e6ea157d3be210311 100644
> --- a/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c
> +++ b/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c
> @@ -77,11 +77,11 @@ mdp5_get_existing_global_state(struct mdp5_kms *mdp5_kms)
>   
>   /*
>    * This acquires the modeset lock set aside for global state, creates
>    * a new duplicated private object state.
>    */
> -struct mdp5_global_state *mdp5_get_global_state(struct drm_atomic_state *s)
> +struct mdp5_global_state *mdp5_get_global_state(struct drm_atomic_commit *s)
>   {
>   	struct msm_drm_private *priv = s->dev->dev_private;
>   	struct mdp5_kms *mdp5_kms = to_mdp5_kms(to_mdp_kms(priv->kms));
>   	struct drm_private_state *priv_state;
>   
> @@ -158,11 +158,11 @@ static void mdp5_disable_commit(struct msm_kms *kms)
>   {
>   	struct mdp5_kms *mdp5_kms = to_mdp5_kms(to_mdp_kms(kms));
>   	pm_runtime_put_sync(&mdp5_kms->pdev->dev);
>   }
>   
> -static void mdp5_prepare_commit(struct msm_kms *kms, struct drm_atomic_state *state)
> +static void mdp5_prepare_commit(struct msm_kms *kms, struct drm_atomic_commit *state)
>   {
>   	struct mdp5_kms *mdp5_kms = to_mdp5_kms(to_mdp_kms(kms));
>   	struct mdp5_global_state *global_state;
>   
>   	global_state = mdp5_get_existing_global_state(mdp5_kms);
> diff --git a/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.h b/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.h
> index 36b6842dfc9c63bce8f26ba351fdb1c77180300d..7bf2172fce0bd45331b6ea14c5fdce1ed5320b50 100644
> --- a/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.h
> +++ b/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.h
> @@ -75,20 +75,20 @@ struct mdp5_kms {
>    */
>   #define to_mdp5_global_state(x) container_of(x, struct mdp5_global_state, base)
>   struct mdp5_global_state {
>   	struct drm_private_state base;
>   
> -	struct drm_atomic_state *state;
> +	struct drm_atomic_commit *state;
>   	struct mdp5_kms *mdp5_kms;
>   
>   	struct mdp5_hw_pipe_state hwpipe;
>   	struct mdp5_hw_mixer_state hwmixer;
>   	struct mdp5_smp_state smp;
>   };
>   
>   struct mdp5_global_state * mdp5_get_existing_global_state(struct mdp5_kms *mdp5_kms);
> -struct mdp5_global_state *__must_check mdp5_get_global_state(struct drm_atomic_state *s);
> +struct mdp5_global_state *__must_check mdp5_get_global_state(struct drm_atomic_commit *s);
>   
>   /* Atomic plane state.  Subclasses the base drm_plane_state in order to
>    * track assigned hwpipe and hw specific state.
>    */
>   struct mdp5_plane_state {
> diff --git a/drivers/gpu/drm/msm/disp/mdp5/mdp5_mixer.c b/drivers/gpu/drm/msm/disp/mdp5/mdp5_mixer.c
> index 2822b533f80774853cb15c6dc0d8573924d5171e..253b29629ed709e3918b22311fac90efa50a9a0d 100644
> --- a/drivers/gpu/drm/msm/disp/mdp5/mdp5_mixer.c
> +++ b/drivers/gpu/drm/msm/disp/mdp5/mdp5_mixer.c
> @@ -33,11 +33,11 @@ static int get_right_pair_idx(struct mdp5_kms *mdp5_kms, int lm)
>   	}
>   
>   	return -1;
>   }
>   
> -int mdp5_mixer_assign(struct drm_atomic_state *s, struct drm_crtc *crtc,
> +int mdp5_mixer_assign(struct drm_atomic_commit *s, struct drm_crtc *crtc,
>   		      uint32_t caps, struct mdp5_hw_mixer **mixer,
>   		      struct mdp5_hw_mixer **r_mixer)
>   {
>   	struct msm_drm_private *priv = s->dev->dev_private;
>   	struct mdp5_kms *mdp5_kms = to_mdp5_kms(to_mdp_kms(priv->kms));
> @@ -114,11 +114,11 @@ int mdp5_mixer_assign(struct drm_atomic_state *s, struct drm_crtc *crtc,
>   	}
>   
>   	return 0;
>   }
>   
> -int mdp5_mixer_release(struct drm_atomic_state *s, struct mdp5_hw_mixer *mixer)
> +int mdp5_mixer_release(struct drm_atomic_commit *s, struct mdp5_hw_mixer *mixer)
>   {
>   	struct mdp5_global_state *global_state = mdp5_get_global_state(s);
>   	struct mdp5_hw_mixer_state *new_state;
>   
>   	if (!mixer)
> diff --git a/drivers/gpu/drm/msm/disp/mdp5/mdp5_mixer.h b/drivers/gpu/drm/msm/disp/mdp5/mdp5_mixer.h
> index 2bedd75835bcd983ed522988b9ab8af2a6236826..46bca461b2d0596a3121c9ce9810400af60d305d 100644
> --- a/drivers/gpu/drm/msm/disp/mdp5/mdp5_mixer.h
> +++ b/drivers/gpu/drm/msm/disp/mdp5/mdp5_mixer.h
> @@ -25,12 +25,12 @@ struct mdp5_hw_mixer_state {
>   	struct drm_crtc *hwmixer_to_crtc[8];
>   };
>   
>   struct mdp5_hw_mixer *mdp5_mixer_init(struct drm_device *dev,
>   				      const struct mdp5_lm_instance *lm);
> -int mdp5_mixer_assign(struct drm_atomic_state *s, struct drm_crtc *crtc,
> +int mdp5_mixer_assign(struct drm_atomic_commit *s, struct drm_crtc *crtc,
>   		      uint32_t caps, struct mdp5_hw_mixer **mixer,
>   		      struct mdp5_hw_mixer **r_mixer);
> -int mdp5_mixer_release(struct drm_atomic_state *s,
> +int mdp5_mixer_release(struct drm_atomic_commit *s,
>   		       struct mdp5_hw_mixer *mixer);
>   
>   #endif /* __MDP5_LM_H__ */
> diff --git a/drivers/gpu/drm/msm/disp/mdp5/mdp5_pipe.c b/drivers/gpu/drm/msm/disp/mdp5/mdp5_pipe.c
> index 99b2c30b1d486ec8c78140e4900ff91d3d907ca7..606e18973ea4ba6d00899441151b738a4b295b96 100644
> --- a/drivers/gpu/drm/msm/disp/mdp5/mdp5_pipe.c
> +++ b/drivers/gpu/drm/msm/disp/mdp5/mdp5_pipe.c
> @@ -4,11 +4,11 @@
>    * Author: Rob Clark <robdclark@gmail.com>
>    */
>   
>   #include "mdp5_kms.h"
>   
> -int mdp5_pipe_assign(struct drm_atomic_state *s, struct drm_plane *plane,
> +int mdp5_pipe_assign(struct drm_atomic_commit *s, struct drm_plane *plane,
>   		     uint32_t caps, uint32_t blkcfg,
>   		     struct mdp5_hw_pipe **hwpipe,
>   		     struct mdp5_hw_pipe **r_hwpipe)
>   {
>   	struct msm_drm_private *priv = s->dev->dev_private;
> @@ -117,11 +117,11 @@ int mdp5_pipe_assign(struct drm_atomic_state *s, struct drm_plane *plane,
>   	}
>   
>   	return 0;
>   }
>   
> -int mdp5_pipe_release(struct drm_atomic_state *s, struct mdp5_hw_pipe *hwpipe)
> +int mdp5_pipe_release(struct drm_atomic_commit *s, struct mdp5_hw_pipe *hwpipe)
>   {
>   	struct msm_drm_private *priv = s->dev->dev_private;
>   	struct mdp5_kms *mdp5_kms = to_mdp5_kms(to_mdp_kms(priv->kms));
>   	struct mdp5_global_state *state;
>   	struct mdp5_hw_pipe_state *new_state;
> diff --git a/drivers/gpu/drm/msm/disp/mdp5/mdp5_pipe.h b/drivers/gpu/drm/msm/disp/mdp5/mdp5_pipe.h
> index 452138821f600847876dc396f705dec2b2405d6c..37485d2fdebaf439c6a3410ba1fbb6f241239a45 100644
> --- a/drivers/gpu/drm/msm/disp/mdp5/mdp5_pipe.h
> +++ b/drivers/gpu/drm/msm/disp/mdp5/mdp5_pipe.h
> @@ -31,15 +31,15 @@ struct mdp5_hw_pipe {
>   /* global atomic state of assignment between pipes and planes: */
>   struct mdp5_hw_pipe_state {
>   	struct drm_plane *hwpipe_to_plane[SSPP_MAX];
>   };
>   
> -int mdp5_pipe_assign(struct drm_atomic_state *s, struct drm_plane *plane,
> +int mdp5_pipe_assign(struct drm_atomic_commit *s, struct drm_plane *plane,
>   		     uint32_t caps, uint32_t blkcfg,
>   		     struct mdp5_hw_pipe **hwpipe,
>   		     struct mdp5_hw_pipe **r_hwpipe);
> -int mdp5_pipe_release(struct drm_atomic_state *s, struct mdp5_hw_pipe *hwpipe);
> +int mdp5_pipe_release(struct drm_atomic_commit *s, struct mdp5_hw_pipe *hwpipe);
>   
>   struct mdp5_hw_pipe *mdp5_pipe_init(struct drm_device *dev,
>   		enum mdp5_pipe pipe,
>   		uint32_t reg_offset, uint32_t caps);
>   
> diff --git a/drivers/gpu/drm/msm/disp/mdp5/mdp5_plane.c b/drivers/gpu/drm/msm/disp/mdp5/mdp5_plane.c
> index c4624a49b32f34b18fcd04e17e640282ade8655a..841f444a8d68d3b414bae86b20454d5af59c84e5 100644
> --- a/drivers/gpu/drm/msm/disp/mdp5/mdp5_plane.c
> +++ b/drivers/gpu/drm/msm/disp/mdp5/mdp5_plane.c
> @@ -321,11 +321,11 @@ static int mdp5_plane_atomic_check_with_state(struct drm_crtc_state *crtc_state,
>   
>   	return 0;
>   }
>   
>   static int mdp5_plane_atomic_check(struct drm_plane *plane,
> -				   struct drm_atomic_state *state)
> +				   struct drm_atomic_commit *state)
>   {
>   	struct drm_plane_state *old_plane_state = drm_atomic_get_old_plane_state(state,
>   										 plane);
>   	struct drm_plane_state *new_plane_state = drm_atomic_get_new_plane_state(state,
>   										 plane);
> @@ -342,11 +342,11 @@ static int mdp5_plane_atomic_check(struct drm_plane *plane,
>   
>   	return mdp5_plane_atomic_check_with_state(crtc_state, new_plane_state);
>   }
>   
>   static void mdp5_plane_atomic_update(struct drm_plane *plane,
> -				     struct drm_atomic_state *state)
> +				     struct drm_atomic_commit *state)
>   {
>   	struct drm_plane_state *new_state = drm_atomic_get_new_plane_state(state,
>   									   plane);
>   
>   	DBG("%s: update", plane->name);
> @@ -361,11 +361,11 @@ static void mdp5_plane_atomic_update(struct drm_plane *plane,
>   		WARN_ON(ret < 0);
>   	}
>   }
>   
>   static int mdp5_plane_atomic_async_check(struct drm_plane *plane,
> -					 struct drm_atomic_state *state, bool flip)
> +					 struct drm_atomic_commit *state, bool flip)
>   {
>   	struct drm_plane_state *new_plane_state = drm_atomic_get_new_plane_state(state,
>   										 plane);
>   	struct mdp5_plane_state *mdp5_state = to_mdp5_plane_state(new_plane_state);
>   	struct drm_crtc_state *crtc_state;
> @@ -415,11 +415,11 @@ static int mdp5_plane_atomic_async_check(struct drm_plane *plane,
>   
>   	return 0;
>   }
>   
>   static void mdp5_plane_atomic_async_update(struct drm_plane *plane,
> -					   struct drm_atomic_state *state)
> +					   struct drm_atomic_commit *state)
>   {
>   	struct drm_plane_state *new_state = drm_atomic_get_new_plane_state(state,
>   									   plane);
>   	struct drm_framebuffer *old_fb = plane->state->fb;
>   
> diff --git a/drivers/gpu/drm/msm/disp/msm_disp_snapshot.h b/drivers/gpu/drm/msm/disp/msm_disp_snapshot.h
> index 53bd1dcde15fb90ba9887e6a026e54b627fc79cd..38bde9e60e11feb1e38e7bc86c91140916a39988 100644
> --- a/drivers/gpu/drm/msm/disp/msm_disp_snapshot.h
> +++ b/drivers/gpu/drm/msm/disp/msm_disp_snapshot.h
> @@ -46,11 +46,11 @@ struct msm_disp_state {
>   	struct device *dev;
>   	struct drm_device *drm_dev;
>   
>   	struct list_head blocks;
>   
> -	struct drm_atomic_state *atomic_state;
> +	struct drm_atomic_commit *atomic_state;
>   
>   	struct timespec64 time;
>   };
>   
>   /**
> diff --git a/drivers/gpu/drm/msm/disp/msm_disp_snapshot_util.c b/drivers/gpu/drm/msm/disp/msm_disp_snapshot_util.c
> index 427d3ee2b8337b54b319bdc9143169fefa2c4e7b..5e151952dea8d126a02e28a0cbeb0aa19a246880 100644
> --- a/drivers/gpu/drm/msm/disp/msm_disp_snapshot_util.c
> +++ b/drivers/gpu/drm/msm/disp/msm_disp_snapshot_util.c
> @@ -150,11 +150,11 @@ void msm_disp_state_free(void *data)
>   {
>   	struct msm_disp_state *disp_state = data;
>   	struct msm_disp_state_block *block, *tmp;
>   
>   	if (disp_state->atomic_state) {
> -		drm_atomic_state_put(disp_state->atomic_state);
> +		drm_atomic_commit_put(disp_state->atomic_state);
>   		disp_state->atomic_state = NULL;
>   	}
>   
>   	list_for_each_entry_safe(block, tmp, &disp_state->blocks, node) {
>   		list_del(&block->node);
> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> index d2124d6254855bd836b656f76478973afca64c3f..1b3cbf4016ef7a257073cf0adeebb76390dfdc7b 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> @@ -1589,11 +1589,11 @@ int msm_dp_modeset_init(struct msm_dp *msm_dp_display, struct drm_device *dev,
>   
>   	return 0;
>   }
>   
>   void msm_dp_bridge_atomic_enable(struct drm_bridge *drm_bridge,
> -				 struct drm_atomic_state *state)
> +				 struct drm_atomic_commit *state)
>   {
>   	struct msm_dp_bridge *msm_dp_bridge = to_dp_bridge(drm_bridge);
>   	struct msm_dp *dp = msm_dp_bridge->msm_dp_display;
>   	int rc = 0;
>   	struct msm_dp_display_private *msm_dp_display;
> @@ -1650,11 +1650,11 @@ void msm_dp_bridge_atomic_enable(struct drm_bridge *drm_bridge,
>   	drm_dbg_dp(dp->drm_dev, "type=%d Done\n", dp->connector_type);
>   	mutex_unlock(&msm_dp_display->event_mutex);
>   }
>   
>   void msm_dp_bridge_atomic_disable(struct drm_bridge *drm_bridge,
> -				  struct drm_atomic_state *state)
> +				  struct drm_atomic_commit *state)
>   {
>   	struct msm_dp_bridge *msm_dp_bridge = to_dp_bridge(drm_bridge);
>   	struct msm_dp *dp = msm_dp_bridge->msm_dp_display;
>   	struct msm_dp_display_private *msm_dp_display;
>   
> @@ -1662,11 +1662,11 @@ void msm_dp_bridge_atomic_disable(struct drm_bridge *drm_bridge,
>   
>   	msm_dp_ctrl_push_idle(msm_dp_display->ctrl);
>   }
>   
>   void msm_dp_bridge_atomic_post_disable(struct drm_bridge *drm_bridge,
> -				       struct drm_atomic_state *state)
> +				       struct drm_atomic_commit *state)
>   {
>   	struct msm_dp_bridge *msm_dp_bridge = to_dp_bridge(drm_bridge);
>   	struct msm_dp *dp = msm_dp_bridge->msm_dp_display;
>   	u32 hpd_state;
>   	struct msm_dp_display_private *msm_dp_display;
> diff --git a/drivers/gpu/drm/msm/dp/dp_drm.c b/drivers/gpu/drm/msm/dp/dp_drm.c
> index fd6443d2b6cea1b3e43f63fc9f930d37dc25e0c6..ec4652e620c48a741e73388093b081b860a0ad58 100644
> --- a/drivers/gpu/drm/msm/dp/dp_drm.c
> +++ b/drivers/gpu/drm/msm/dp/dp_drm.c
> @@ -142,11 +142,11 @@ static int msm_edp_bridge_atomic_check(struct drm_bridge *drm_bridge,
>   
>   	return 0;
>   }
>   
>   static void msm_edp_bridge_atomic_enable(struct drm_bridge *drm_bridge,
> -					 struct drm_atomic_state *state)
> +					 struct drm_atomic_commit *state)
>   {
>   	struct drm_crtc *crtc;
>   	struct drm_crtc_state *old_crtc_state;
>   	struct msm_dp_bridge *msm_dp_bridge = to_dp_bridge(drm_bridge);
>   	struct msm_dp *dp = msm_dp_bridge->msm_dp_display;
> @@ -171,11 +171,11 @@ static void msm_edp_bridge_atomic_enable(struct drm_bridge *drm_bridge,
>   
>   	msm_dp_bridge_atomic_enable(drm_bridge, state);
>   }
>   
>   static void msm_edp_bridge_atomic_disable(struct drm_bridge *drm_bridge,
> -					  struct drm_atomic_state *atomic_state)
> +					  struct drm_atomic_commit *atomic_state)
>   {
>   	struct drm_crtc *crtc;
>   	struct drm_crtc_state *new_crtc_state = NULL, *old_crtc_state = NULL;
>   	struct msm_dp_bridge *msm_dp_bridge = to_dp_bridge(drm_bridge);
>   	struct msm_dp *dp = msm_dp_bridge->msm_dp_display;
> @@ -215,11 +215,11 @@ static void msm_edp_bridge_atomic_disable(struct drm_bridge *drm_bridge,
>   out:
>   	msm_dp_bridge_atomic_disable(drm_bridge, atomic_state);
>   }
>   
>   static void msm_edp_bridge_atomic_post_disable(struct drm_bridge *drm_bridge,
> -					       struct drm_atomic_state *atomic_state)
> +					       struct drm_atomic_commit *atomic_state)
>   {
>   	struct drm_crtc *crtc;
>   	struct drm_crtc_state *new_crtc_state = NULL;
>   
>   	crtc = drm_atomic_get_old_crtc_for_encoder(atomic_state,
> diff --git a/drivers/gpu/drm/msm/dp/dp_drm.h b/drivers/gpu/drm/msm/dp/dp_drm.h
> index 9eb3431dd93adf096f45b6d981967734bc8a2b0c..ec76448e71aefc244aaf3c8e1ff0531979a369a6 100644
> --- a/drivers/gpu/drm/msm/dp/dp_drm.h
> +++ b/drivers/gpu/drm/msm/dp/dp_drm.h
> @@ -24,15 +24,15 @@ struct drm_connector *msm_dp_drm_connector_init(struct msm_dp *msm_dp_display,
>   int msm_dp_bridge_init(struct msm_dp *msm_dp_display, struct drm_device *dev,
>   		   struct drm_encoder *encoder,
>   		   bool yuv_supported);
>   
>   void msm_dp_bridge_atomic_enable(struct drm_bridge *drm_bridge,
> -				 struct drm_atomic_state *state);
> +				 struct drm_atomic_commit *state);
>   void msm_dp_bridge_atomic_disable(struct drm_bridge *drm_bridge,
> -				  struct drm_atomic_state *state);
> +				  struct drm_atomic_commit *state);
>   void msm_dp_bridge_atomic_post_disable(struct drm_bridge *drm_bridge,
> -				       struct drm_atomic_state *state);
> +				       struct drm_atomic_commit *state);
>   enum drm_mode_status msm_dp_bridge_mode_valid(struct drm_bridge *bridge,
>   					  const struct drm_display_info *info,
>   					  const struct drm_display_mode *mode);
>   void msm_dp_bridge_mode_set(struct drm_bridge *drm_bridge,
>   			const struct drm_display_mode *mode,
> diff --git a/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c b/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c
> index a9eb6489c520313381792ae4b1a5faec1d983809..c4d5e0faf3b32854ec751ff67047066f1a1e91fe 100644
> --- a/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c
> +++ b/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c
> @@ -281,11 +281,11 @@ static int msm_hdmi_bridge_write_hdmi_infoframe(struct drm_bridge *bridge,
>   
>   static void msm_hdmi_set_timings(struct hdmi *hdmi,
>   				 const struct drm_display_mode *mode);
>   
>   static void msm_hdmi_bridge_atomic_pre_enable(struct drm_bridge *bridge,
> -					      struct drm_atomic_state *state)
> +					      struct drm_atomic_commit *state)
>   {
>   	struct hdmi_bridge *hdmi_bridge = to_hdmi_bridge(bridge);
>   	struct hdmi *hdmi = hdmi_bridge->hdmi;
>   	struct hdmi_phy *phy = hdmi->phy;
>   	struct drm_encoder *encoder = bridge->encoder;
> @@ -323,11 +323,11 @@ static void msm_hdmi_bridge_atomic_pre_enable(struct drm_bridge *bridge,
>   	if (hdmi->hdcp_ctrl)
>   		msm_hdmi_hdcp_on(hdmi->hdcp_ctrl);
>   }
>   
>   static void msm_hdmi_bridge_atomic_post_disable(struct drm_bridge *bridge,
> -						struct drm_atomic_state *state)
> +						struct drm_atomic_commit *state)
>   {
>   	struct hdmi_bridge *hdmi_bridge = to_hdmi_bridge(bridge);
>   	struct hdmi *hdmi = hdmi_bridge->hdmi;
>   	struct hdmi_phy *phy = hdmi->phy;
>   
> diff --git a/drivers/gpu/drm/msm/msm_atomic.c b/drivers/gpu/drm/msm/msm_atomic.c
> index 87a91148a731dc911f30695add4c8f5002770220..a8babf1dbe0d33f8a0ecdbdc864a07747520df75 100644
> --- a/drivers/gpu/drm/msm/msm_atomic.c
> +++ b/drivers/gpu/drm/msm/msm_atomic.c
> @@ -134,11 +134,11 @@ void msm_atomic_destroy_pending_timer(struct msm_pending_timer *timer)
>   {
>   	if (timer->worker)
>   		kthread_destroy_worker(timer->worker);
>   }
>   
> -static bool can_do_async(struct drm_atomic_state *state,
> +static bool can_do_async(struct drm_atomic_commit *state,
>   		struct drm_crtc **async_crtc)
>   {
>   	struct drm_connector_state *connector_state;
>   	struct drm_connector *connector;
>   	struct drm_crtc_state *crtc_state;
> @@ -167,11 +167,11 @@ static bool can_do_async(struct drm_atomic_state *state,
>   
>   /* Get bitmask of crtcs that will need to be flushed.  The bitmask
>    * can be used with for_each_crtc_mask() iterator, to iterate
>    * effected crtcs without needing to preserve the atomic state.
>    */
> -static unsigned get_crtc_mask(struct drm_atomic_state *state)
> +static unsigned get_crtc_mask(struct drm_atomic_commit *state)
>   {
>   	struct drm_crtc_state *crtc_state;
>   	struct drm_crtc *crtc;
>   	unsigned i, mask = 0;
>   
> @@ -179,11 +179,11 @@ static unsigned get_crtc_mask(struct drm_atomic_state *state)
>   		mask |= drm_crtc_mask(crtc);
>   
>   	return mask;
>   }
>   
> -int msm_atomic_check(struct drm_device *dev, struct drm_atomic_state *state)
> +int msm_atomic_check(struct drm_device *dev, struct drm_atomic_commit *state)
>   {
>   	struct msm_drm_private *priv = dev->dev_private;
>   	struct msm_kms *kms = priv->kms;
>   	struct drm_crtc_state *old_crtc_state, *new_crtc_state;
>   	struct drm_crtc *crtc;
> @@ -208,11 +208,11 @@ int msm_atomic_check(struct drm_device *dev, struct drm_atomic_state *state)
>   		return ret;
>   
>   	return drm_atomic_helper_check(dev, state);
>   }
>   
> -void msm_atomic_commit_tail(struct drm_atomic_state *state)
> +void msm_atomic_commit_tail(struct drm_atomic_commit *state)
>   {
>   	struct drm_device *dev = state->dev;
>   	struct msm_drm_private *priv = dev->dev_private;
>   	struct msm_kms *kms = priv->kms;
>   	struct drm_crtc *async_crtc = NULL;
> diff --git a/drivers/gpu/drm/msm/msm_drv.h b/drivers/gpu/drm/msm/msm_drv.h
> index 6d847d593f1aebdf90e4389ef7ecdf5721d910a5..76ac61df0b352491406220c83d3b1672070278cb 100644
> --- a/drivers/gpu/drm/msm/msm_drv.h
> +++ b/drivers/gpu/drm/msm/msm_drv.h
> @@ -217,13 +217,13 @@ const struct msm_format *mdp_get_format(struct msm_kms *kms, uint32_t format, ui
>   struct msm_pending_timer;
>   
>   int msm_atomic_init_pending_timer(struct msm_pending_timer *timer,
>   		struct msm_kms *kms, int crtc_idx);
>   void msm_atomic_destroy_pending_timer(struct msm_pending_timer *timer);
> -void msm_atomic_commit_tail(struct drm_atomic_state *state);
> -int msm_atomic_check(struct drm_device *dev, struct drm_atomic_state *state);
> -struct drm_atomic_state *msm_atomic_state_alloc(struct drm_device *dev);
> +void msm_atomic_commit_tail(struct drm_atomic_commit *state);
> +int msm_atomic_check(struct drm_device *dev, struct drm_atomic_commit *state);
> +struct drm_atomic_commit *msm_atomic_state_alloc(struct drm_device *dev);
>   
>   int msm_crtc_enable_vblank(struct drm_crtc *crtc);
>   void msm_crtc_disable_vblank(struct drm_crtc *crtc);
>   
>   int msm_register_mmu(struct drm_device *dev, struct msm_mmu *mmu);
> diff --git a/drivers/gpu/drm/msm/msm_kms.h b/drivers/gpu/drm/msm/msm_kms.h
> index 8a7be7b854deea9b763ec45df275fab77d806e44..f25b31e502d2189d6f87a718d4fcf94bbd3c5a41 100644
> --- a/drivers/gpu/drm/msm/msm_kms.h
> +++ b/drivers/gpu/drm/msm/msm_kms.h
> @@ -64,17 +64,17 @@ struct msm_kms_funcs {
>   	/**
>   	 * @check_mode_changed:
>   	 *
>   	 * Verify if the commit requires a full modeset on one of CRTCs.
>   	 */
> -	int (*check_mode_changed)(struct msm_kms *kms, struct drm_atomic_state *state);
> +	int (*check_mode_changed)(struct msm_kms *kms, struct drm_atomic_commit *state);
>   
>   	/**
>   	 * Prepare for atomic commit.  This is called after any previous
>   	 * (async or otherwise) commit has completed.
>   	 */
> -	void (*prepare_commit)(struct msm_kms *kms, struct drm_atomic_state *state);
> +	void (*prepare_commit)(struct msm_kms *kms, struct drm_atomic_commit *state);
>   
>   	/**
>   	 * Flush an atomic commit.  This is called after the hardware
>   	 * updates have already been pushed down to effected planes/
>   	 * crtcs/encoders/connectors.
> diff --git a/drivers/gpu/drm/mxsfb/lcdif_kms.c b/drivers/gpu/drm/mxsfb/lcdif_kms.c
> index ef3250a5c54f003200fa13204214e69f96512c1a..ade76c3f4e4e90d13637d9b86266b393c577a59c 100644
> --- a/drivers/gpu/drm/mxsfb/lcdif_kms.c
> +++ b/drivers/gpu/drm/mxsfb/lcdif_kms.c
> @@ -420,11 +420,11 @@ static void lcdif_crtc_mode_set_nofb(struct drm_crtc_state *crtc_state,
>   
>   	lcdif_set_mode(lcdif, lcdif_crtc_state->bus_flags);
>   }
>   
>   static int lcdif_crtc_atomic_check(struct drm_crtc *crtc,
> -				   struct drm_atomic_state *state)
> +				   struct drm_atomic_commit *state)
>   {
>   	struct drm_device *drm = crtc->dev;
>   	struct drm_crtc_state *crtc_state = drm_atomic_get_new_crtc_state(state,
>   									  crtc);
>   	struct lcdif_crtc_state *lcdif_crtc_state = to_lcdif_crtc_state(crtc_state);
> @@ -501,11 +501,11 @@ static int lcdif_crtc_atomic_check(struct drm_crtc *crtc,
>   
>   	return 0;
>   }
>   
>   static void lcdif_crtc_atomic_flush(struct drm_crtc *crtc,
> -				    struct drm_atomic_state *state)
> +				    struct drm_atomic_commit *state)
>   {
>   	struct lcdif_drm_private *lcdif = to_lcdif_drm_private(crtc->dev);
>   	struct drm_pending_vblank_event *event;
>   	u32 reg;
>   
> @@ -526,11 +526,11 @@ static void lcdif_crtc_atomic_flush(struct drm_crtc *crtc,
>   		drm_crtc_send_vblank_event(crtc, event);
>   	spin_unlock_irq(&crtc->dev->event_lock);
>   }
>   
>   static void lcdif_crtc_atomic_enable(struct drm_crtc *crtc,
> -				     struct drm_atomic_state *state)
> +				     struct drm_atomic_commit *state)
>   {
>   	struct lcdif_drm_private *lcdif = to_lcdif_drm_private(crtc->dev);
>   	struct drm_crtc_state *new_cstate = drm_atomic_get_new_crtc_state(state, crtc);
>   	struct drm_plane_state *new_pstate = drm_atomic_get_new_plane_state(state,
>   									    crtc->primary);
> @@ -556,11 +556,11 @@ static void lcdif_crtc_atomic_enable(struct drm_crtc *crtc,
>   
>   	drm_crtc_vblank_on(crtc);
>   }
>   
>   static void lcdif_crtc_atomic_disable(struct drm_crtc *crtc,
> -				      struct drm_atomic_state *state)
> +				      struct drm_atomic_commit *state)
>   {
>   	struct lcdif_drm_private *lcdif = to_lcdif_drm_private(crtc->dev);
>   	struct drm_device *drm = lcdif->drm;
>   	struct drm_pending_vblank_event *event;
>   
> @@ -662,11 +662,11 @@ static const struct drm_crtc_funcs lcdif_crtc_funcs = {
>   /* -----------------------------------------------------------------------------
>    * Planes
>    */
>   
>   static int lcdif_plane_atomic_check(struct drm_plane *plane,
> -				    struct drm_atomic_state *state)
> +				    struct drm_atomic_commit *state)
>   {
>   	struct drm_plane_state *plane_state = drm_atomic_get_new_plane_state(state,
>   									     plane);
>   	struct lcdif_drm_private *lcdif = to_lcdif_drm_private(plane->dev);
>   	struct drm_crtc_state *crtc_state;
> @@ -679,11 +679,11 @@ static int lcdif_plane_atomic_check(struct drm_plane *plane,
>   						   DRM_PLANE_NO_SCALING,
>   						   false, true);
>   }
>   
>   static void lcdif_plane_primary_atomic_update(struct drm_plane *plane,
> -					      struct drm_atomic_state *state)
> +					      struct drm_atomic_commit *state)
>   {
>   	struct lcdif_drm_private *lcdif = to_lcdif_drm_private(plane->dev);
>   	struct drm_plane_state *new_pstate = drm_atomic_get_new_plane_state(state,
>   									    plane);
>   	dma_addr_t paddr;
> diff --git a/drivers/gpu/drm/mxsfb/mxsfb_kms.c b/drivers/gpu/drm/mxsfb/mxsfb_kms.c
> index 8cac0a275b7da7e0ce549a4d8b39b55d5806054c..d8ebebc5314bba3ede39a4548747459d87e646db 100644
> --- a/drivers/gpu/drm/mxsfb/mxsfb_kms.c
> +++ b/drivers/gpu/drm/mxsfb/mxsfb_kms.c
> @@ -308,11 +308,11 @@ static void mxsfb_crtc_mode_set_nofb(struct mxsfb_drm_private *mxsfb,
>   
>   	mxsfb_set_mode(mxsfb, bus_flags);
>   }
>   
>   static int mxsfb_crtc_atomic_check(struct drm_crtc *crtc,
> -				   struct drm_atomic_state *state)
> +				   struct drm_atomic_commit *state)
>   {
>   	struct drm_crtc_state *crtc_state = drm_atomic_get_new_crtc_state(state,
>   									  crtc);
>   	bool has_primary = crtc_state->plane_mask &
>   			   drm_plane_mask(crtc->primary);
> @@ -324,11 +324,11 @@ static int mxsfb_crtc_atomic_check(struct drm_crtc *crtc,
>   	/* TODO: Is this needed ? */
>   	return drm_atomic_add_affected_planes(state, crtc);
>   }
>   
>   static void mxsfb_crtc_atomic_flush(struct drm_crtc *crtc,
> -				    struct drm_atomic_state *state)
> +				    struct drm_atomic_commit *state)
>   {
>   	struct drm_pending_vblank_event *event;
>   
>   	event = crtc->state->event;
>   	crtc->state->event = NULL;
> @@ -343,11 +343,11 @@ static void mxsfb_crtc_atomic_flush(struct drm_crtc *crtc,
>   		drm_crtc_send_vblank_event(crtc, event);
>   	spin_unlock_irq(&crtc->dev->event_lock);
>   }
>   
>   static void mxsfb_crtc_atomic_enable(struct drm_crtc *crtc,
> -				     struct drm_atomic_state *state)
> +				     struct drm_atomic_commit *state)
>   {
>   	struct mxsfb_drm_private *mxsfb = to_mxsfb_drm_private(crtc->dev);
>   	struct drm_plane_state *new_pstate = drm_atomic_get_new_plane_state(state,
>   									    crtc->primary);
>   	struct drm_bridge_state *bridge_state = NULL;
> @@ -397,11 +397,11 @@ static void mxsfb_crtc_atomic_enable(struct drm_crtc *crtc,
>   
>   	mxsfb_enable_controller(mxsfb);
>   }
>   
>   static void mxsfb_crtc_atomic_disable(struct drm_crtc *crtc,
> -				      struct drm_atomic_state *state)
> +				      struct drm_atomic_commit *state)
>   {
>   	struct mxsfb_drm_private *mxsfb = to_mxsfb_drm_private(crtc->dev);
>   	struct drm_device *drm = mxsfb->drm;
>   	struct drm_pending_vblank_event *event;
>   
> @@ -518,11 +518,11 @@ static const struct drm_encoder_funcs mxsfb_encoder_funcs = {
>   /* -----------------------------------------------------------------------------
>    * Planes
>    */
>   
>   static int mxsfb_plane_atomic_check(struct drm_plane *plane,
> -				    struct drm_atomic_state *state)
> +				    struct drm_atomic_commit *state)
>   {
>   	struct drm_plane_state *plane_state = drm_atomic_get_new_plane_state(state,
>   									     plane);
>   	struct mxsfb_drm_private *mxsfb = to_mxsfb_drm_private(plane->dev);
>   	struct drm_crtc_state *crtc_state;
> @@ -535,11 +535,11 @@ static int mxsfb_plane_atomic_check(struct drm_plane *plane,
>   						   DRM_PLANE_NO_SCALING,
>   						   false, true);
>   }
>   
>   static void mxsfb_plane_primary_atomic_update(struct drm_plane *plane,
> -					      struct drm_atomic_state *state)
> +					      struct drm_atomic_commit *state)
>   {
>   	struct mxsfb_drm_private *mxsfb = to_mxsfb_drm_private(plane->dev);
>   	struct drm_plane_state *new_pstate = drm_atomic_get_new_plane_state(state,
>   									    plane);
>   	dma_addr_t dma_addr;
> @@ -548,11 +548,11 @@ static void mxsfb_plane_primary_atomic_update(struct drm_plane *plane,
>   	if (dma_addr)
>   		writel(dma_addr, mxsfb->base + mxsfb->devdata->next_buf);
>   }
>   
>   static void mxsfb_plane_overlay_atomic_update(struct drm_plane *plane,
> -					      struct drm_atomic_state *state)
> +					      struct drm_atomic_commit *state)
>   {
>   	struct drm_plane_state *old_pstate = drm_atomic_get_old_plane_state(state,
>   									    plane);
>   	struct mxsfb_drm_private *mxsfb = to_mxsfb_drm_private(plane->dev);
>   	struct drm_plane_state *new_pstate = drm_atomic_get_new_plane_state(state,
> @@ -611,11 +611,11 @@ static void mxsfb_plane_overlay_atomic_update(struct drm_plane *plane,
>   
>   	writel(ctrl, mxsfb->base + LCDC_AS_CTRL);
>   }
>   
>   static void mxsfb_plane_overlay_atomic_disable(struct drm_plane *plane,
> -					       struct drm_atomic_state *state)
> +					       struct drm_atomic_commit *state)
>   {
>   	struct mxsfb_drm_private *mxsfb = to_mxsfb_drm_private(plane->dev);
>   
>   	writel(0, mxsfb->base + LCDC_AS_CTRL);
>   }
> diff --git a/drivers/gpu/drm/nouveau/dispnv50/atom.h b/drivers/gpu/drm/nouveau/dispnv50/atom.h
> index b43c4f9bbcdf58243325d36f01e206aee816315a..c34a42ea9ac470badd03421c6fa08a221883916f 100644
> --- a/drivers/gpu/drm/nouveau/dispnv50/atom.h
> +++ b/drivers/gpu/drm/nouveau/dispnv50/atom.h
> @@ -5,11 +5,11 @@
>   #include "crc.h"
>   
>   struct nouveau_encoder;
>   
>   struct nv50_atom {
> -	struct drm_atomic_state state;
> +	struct drm_atomic_commit state;
>   
>   	struct list_head outp;
>   	bool lock_core;
>   	bool flush_disable;
>   };
> @@ -147,22 +147,22 @@ struct nv50_head_atom {
>   		u16 mask;
>   	} set, clr;
>   };
>   
>   static inline struct nv50_head_atom *
> -nv50_head_atom_get(struct drm_atomic_state *state, struct drm_crtc *crtc)
> +nv50_head_atom_get(struct drm_atomic_commit *state, struct drm_crtc *crtc)
>   {
>   	struct drm_crtc_state *statec = drm_atomic_get_crtc_state(state, crtc);
>   
>   	if (IS_ERR(statec))
>   		return (void *)statec;
>   
>   	return nv50_head_atom(statec);
>   }
>   
>   static inline struct nv50_head_atom *
> -nv50_head_atom_get_new(struct drm_atomic_state *state, struct drm_crtc *crtc)
> +nv50_head_atom_get_new(struct drm_atomic_commit *state, struct drm_crtc *crtc)
>   {
>   	struct drm_crtc_state *statec = drm_atomic_get_new_crtc_state(state, crtc);
>   
>   	if (!statec)
>   		return NULL;
> diff --git a/drivers/gpu/drm/nouveau/dispnv50/crc.c b/drivers/gpu/drm/nouveau/dispnv50/crc.c
> index deb6af40ef328cf6957fd252ac6e5738686e6f4a..e736318fb0dc7d0709d50f4811a2a0e8ba61b482 100644
> --- a/drivers/gpu/drm/nouveau/dispnv50/crc.c
> +++ b/drivers/gpu/drm/nouveau/dispnv50/crc.c
> @@ -235,11 +235,11 @@ static void nv50_crc_wait_ctx_finished(struct nv50_head *head,
>   		NV_ATOMIC(drm,
>   			  "CRC notifier ctx for head-%d finished after %lldns\n",
>   			  head->base.index, ret);
>   }
>   
> -void nv50_crc_atomic_stop_reporting(struct drm_atomic_state *state)
> +void nv50_crc_atomic_stop_reporting(struct drm_atomic_commit *state)
>   {
>   	struct drm_crtc_state *crtc_state;
>   	struct drm_crtc *crtc;
>   	int i;
>   
> @@ -267,11 +267,11 @@ void nv50_crc_atomic_stop_reporting(struct drm_atomic_state *state)
>   		 * in hardware
>   		 */
>   	}
>   }
>   
> -void nv50_crc_atomic_init_notifier_contexts(struct drm_atomic_state *state)
> +void nv50_crc_atomic_init_notifier_contexts(struct drm_atomic_commit *state)
>   {
>   	struct drm_crtc_state *new_crtc_state;
>   	struct drm_crtc *crtc;
>   	int i;
>   
> @@ -289,11 +289,11 @@ void nv50_crc_atomic_init_notifier_contexts(struct drm_atomic_state *state)
>   		for (i = 0; i < ARRAY_SIZE(crc->ctx); i++)
>   			nv50_crc_reset_ctx(&crc->ctx[i]);
>   	}
>   }
>   
> -void nv50_crc_atomic_release_notifier_contexts(struct drm_atomic_state *state)
> +void nv50_crc_atomic_release_notifier_contexts(struct drm_atomic_commit *state)
>   {
>   	const struct nv50_crc_func *func =
>   		nv50_disp(state->dev)->core->func->crc;
>   	struct drm_crtc_state *new_crtc_state;
>   	struct drm_crtc *crtc;
> @@ -314,11 +314,11 @@ void nv50_crc_atomic_release_notifier_contexts(struct drm_atomic_state *state)
>   		}
>   		nv50_crc_wait_ctx_finished(head, func, ctx);
>   	}
>   }
>   
> -void nv50_crc_atomic_start_reporting(struct drm_atomic_state *state)
> +void nv50_crc_atomic_start_reporting(struct drm_atomic_commit *state)
>   {
>   	struct drm_crtc_state *crtc_state;
>   	struct drm_crtc *crtc;
>   	int i;
>   
> @@ -542,11 +542,11 @@ nv50_crc_ctx_fini(struct nv50_crc_notifier_ctx *ctx)
>   }
>   
>   int nv50_crc_set_source(struct drm_crtc *crtc, const char *source_str)
>   {
>   	struct drm_device *dev = crtc->dev;
> -	struct drm_atomic_state *state;
> +	struct drm_atomic_commit *state;
>   	struct drm_modeset_acquire_ctx ctx;
>   	struct nv50_head *head = nv50_head(crtc);
>   	struct nv50_crc *crc = &head->crc;
>   	const struct nv50_crc_func *func = nv50_disp(dev)->core->func->crc;
>   	struct nvif_mmu *mmu = &nouveau_drm(dev)->client.mmu;
> @@ -565,11 +565,11 @@ int nv50_crc_set_source(struct drm_crtc *crtc, const char *source_str)
>   	 */
>   	if (source)
>   		ctx_flags |= DRM_MODESET_ACQUIRE_INTERRUPTIBLE;
>   	drm_modeset_acquire_init(&ctx, ctx_flags);
>   
> -	state = drm_atomic_state_alloc(dev);
> +	state = drm_atomic_commit_alloc(dev);
>   	if (!state) {
>   		ret = -ENOMEM;
>   		goto out_acquire_fini;
>   	}
>   	state->acquire_ctx = &ctx;
> @@ -615,17 +615,17 @@ int nv50_crc_set_source(struct drm_crtc *crtc, const char *source_str)
>   out_ctx_fini:
>   	if (!source || ret) {
>   		for (i = 0; i < ARRAY_SIZE(crc->ctx); i++)
>   			nv50_crc_ctx_fini(&crc->ctx[i]);
>   	}
> -	drm_atomic_state_put(state);
> +	drm_atomic_commit_put(state);
>   out_acquire_fini:
>   	drm_modeset_acquire_fini(&ctx);
>   	return ret;
>   
>   deadlock:
> -	drm_atomic_state_clear(state);
> +	drm_atomic_commit_clear(state);
>   	drm_modeset_backoff(&ctx);
>   	goto retry;
>   }
>   
>   static int
> diff --git a/drivers/gpu/drm/nouveau/dispnv50/crc.h b/drivers/gpu/drm/nouveau/dispnv50/crc.h
> index 75a2009e819346e4654e8c135ec7a1e96317d50c..cefa2dd52f12d8d2bf1e9efada210f486f71714a 100644
> --- a/drivers/gpu/drm/nouveau/dispnv50/crc.h
> +++ b/drivers/gpu/drm/nouveau/dispnv50/crc.h
> @@ -82,14 +82,14 @@ const char *const *nv50_crc_get_sources(struct drm_crtc *, size_t *);
>   int nv50_crc_set_source(struct drm_crtc *, const char *);
>   
>   int nv50_crc_atomic_check_head(struct nv50_head *, struct nv50_head_atom *,
>   			       struct nv50_head_atom *);
>   void nv50_crc_atomic_check_outp(struct nv50_atom *atom);
> -void nv50_crc_atomic_stop_reporting(struct drm_atomic_state *);
> -void nv50_crc_atomic_init_notifier_contexts(struct drm_atomic_state *);
> -void nv50_crc_atomic_release_notifier_contexts(struct drm_atomic_state *);
> -void nv50_crc_atomic_start_reporting(struct drm_atomic_state *);
> +void nv50_crc_atomic_stop_reporting(struct drm_atomic_commit *);
> +void nv50_crc_atomic_init_notifier_contexts(struct drm_atomic_commit *);
> +void nv50_crc_atomic_release_notifier_contexts(struct drm_atomic_commit *);
> +void nv50_crc_atomic_start_reporting(struct drm_atomic_commit *);
>   void nv50_crc_atomic_set(struct nv50_head *, struct nv50_head_atom *);
>   void nv50_crc_atomic_clr(struct nv50_head *);
>   
>   extern const struct nv50_crc_func crc907d;
>   extern const struct nv50_crc_func crcc37d;
> @@ -114,17 +114,17 @@ static inline int
>   nv50_crc_atomic_check_head(struct nv50_head *head,
>   			   struct nv50_head_atom *asyh,
>   			   struct nv50_head_atom *armh) { return 0; }
>   static inline void nv50_crc_atomic_check_outp(struct nv50_atom *atom) {}
>   static inline void
> -nv50_crc_atomic_stop_reporting(struct drm_atomic_state *state) {}
> +nv50_crc_atomic_stop_reporting(struct drm_atomic_commit *state) {}
>   static inline void
> -nv50_crc_atomic_init_notifier_contexts(struct drm_atomic_state *state) {}
> +nv50_crc_atomic_init_notifier_contexts(struct drm_atomic_commit *state) {}
>   static inline void
> -nv50_crc_atomic_release_notifier_contexts(struct drm_atomic_state *state) {}
> +nv50_crc_atomic_release_notifier_contexts(struct drm_atomic_commit *state) {}
>   static inline void
> -nv50_crc_atomic_start_reporting(struct drm_atomic_state *state) {}
> +nv50_crc_atomic_start_reporting(struct drm_atomic_commit *state) {}
>   static inline void
>   nv50_crc_atomic_set(struct nv50_head *head, struct nv50_head_atom *state) {}
>   static inline void
>   nv50_crc_atomic_clr(struct nv50_head *head) {}
>   
> diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.c b/drivers/gpu/drm/nouveau/dispnv50/disp.c
> index 6c3a8712d38ab471b5eef0d3dfef42ddc28e981a..b983f4f9bcd78c74caee8d23807fb66693f2acc0 100644
> --- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
> +++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
> @@ -426,11 +426,11 @@ nv50_outp_atomic_check(struct drm_encoder *encoder,
>   
>   	return 0;
>   }
>   
>   struct nouveau_connector *
> -nv50_outp_get_new_connector(struct drm_atomic_state *state, struct nouveau_encoder *outp)
> +nv50_outp_get_new_connector(struct drm_atomic_commit *state, struct nouveau_encoder *outp)
>   {
>   	struct drm_connector *connector;
>   	struct drm_connector_state *connector_state;
>   	struct drm_encoder *encoder = to_drm_encoder(outp);
>   	int i;
> @@ -442,11 +442,11 @@ nv50_outp_get_new_connector(struct drm_atomic_state *state, struct nouveau_encod
>   
>   	return NULL;
>   }
>   
>   struct nouveau_connector *
> -nv50_outp_get_old_connector(struct drm_atomic_state *state, struct nouveau_encoder *outp)
> +nv50_outp_get_old_connector(struct drm_atomic_commit *state, struct nouveau_encoder *outp)
>   {
>   	struct drm_connector *connector;
>   	struct drm_connector_state *connector_state;
>   	struct drm_encoder *encoder = to_drm_encoder(outp);
>   	int i;
> @@ -458,11 +458,11 @@ nv50_outp_get_old_connector(struct drm_atomic_state *state, struct nouveau_encod
>   
>   	return NULL;
>   }
>   
>   static struct nouveau_crtc *
> -nv50_outp_get_new_crtc(const struct drm_atomic_state *state, const struct nouveau_encoder *outp)
> +nv50_outp_get_new_crtc(const struct drm_atomic_commit *state, const struct nouveau_encoder *outp)
>   {
>   	struct drm_crtc *crtc;
>   	struct drm_crtc_state *crtc_state;
>   	const u32 mask = drm_encoder_mask(&outp->base.base);
>   	int i;
> @@ -477,22 +477,22 @@ nv50_outp_get_new_crtc(const struct drm_atomic_state *state, const struct nouvea
>   
>   /******************************************************************************
>    * DAC
>    *****************************************************************************/
>   static void
> -nv50_dac_atomic_disable(struct drm_encoder *encoder, struct drm_atomic_state *state)
> +nv50_dac_atomic_disable(struct drm_encoder *encoder, struct drm_atomic_commit *state)
>   {
>   	struct nouveau_encoder *nv_encoder = nouveau_encoder(encoder);
>   	struct nv50_core *core = nv50_disp(encoder->dev)->core;
>   	const u32 ctrl = NVDEF(NV507D, DAC_SET_CONTROL, OWNER, NONE);
>   
>   	core->func->dac->ctrl(core, nv_encoder->outp.or.id, ctrl, NULL);
>   	nv_encoder->crtc = NULL;
>   }
>   
>   static void
> -nv50_dac_atomic_enable(struct drm_encoder *encoder, struct drm_atomic_state *state)
> +nv50_dac_atomic_enable(struct drm_encoder *encoder, struct drm_atomic_commit *state)
>   {
>   	struct nouveau_encoder *nv_encoder = nouveau_encoder(encoder);
>   	struct nouveau_crtc *nv_crtc = nv50_outp_get_new_crtc(state, nv_encoder);
>   	struct nv50_head_atom *asyh =
>   		nv50_head_atom(drm_atomic_get_new_crtc_state(state, &nv_crtc->base));
> @@ -748,11 +748,11 @@ nv50_audio_disable(struct drm_encoder *encoder, struct nouveau_crtc *nv_crtc)
>   	nv50_audio_component_eld_notify(drm->audio.component, outp->or.id, nv_crtc->index);
>   }
>   
>   static void
>   nv50_audio_enable(struct drm_encoder *encoder, struct nouveau_crtc *nv_crtc,
> -		  struct nouveau_connector *nv_connector, struct drm_atomic_state *state,
> +		  struct nouveau_connector *nv_connector, struct drm_atomic_commit *state,
>   		  struct drm_display_mode *mode)
>   {
>   	struct nouveau_drm *drm = nouveau_drm(encoder->dev);
>   	struct nouveau_encoder *nv_encoder = nouveau_encoder(encoder);
>   	struct nvif_outp *outp = &nv_encoder->outp;
> @@ -774,11 +774,11 @@ nv50_audio_enable(struct drm_encoder *encoder, struct nouveau_crtc *nv_crtc,
>   /******************************************************************************
>    * HDMI
>    *****************************************************************************/
>   static void
>   nv50_hdmi_enable(struct drm_encoder *encoder, struct nouveau_crtc *nv_crtc,
> -		 struct nouveau_connector *nv_connector, struct drm_atomic_state *state,
> +		 struct nouveau_connector *nv_connector, struct drm_atomic_commit *state,
>   		 struct drm_display_mode *mode, bool hda)
>   {
>   	struct nouveau_drm *drm = nouveau_drm(encoder->dev);
>   	struct nouveau_encoder *nv_encoder = nouveau_encoder(encoder);
>   	struct drm_hdmi_info *hdmi = &nv_connector->base.display_info.hdmi;
> @@ -890,11 +890,11 @@ struct nouveau_encoder *nv50_real_outp(struct drm_encoder *encoder)
>   		return NULL;
>   	return msto->mstc->mstm->outp;
>   }
>   
>   static void
> -nv50_msto_cleanup(struct drm_atomic_state *state,
> +nv50_msto_cleanup(struct drm_atomic_commit *state,
>   		  struct drm_dp_mst_topology_state *new_mst_state,
>   		  struct drm_dp_mst_topology_mgr *mgr,
>   		  struct nv50_msto *msto)
>   {
>   	struct nouveau_drm *drm = nouveau_drm(msto->encoder.dev);
> @@ -923,11 +923,11 @@ nv50_msto_cleanup(struct drm_atomic_state *state,
>   		msto->enabled = false;
>   	}
>   }
>   
>   static void
> -nv50_msto_prepare(struct drm_atomic_state *state,
> +nv50_msto_prepare(struct drm_atomic_commit *state,
>   		  struct drm_dp_mst_topology_state *mst_state,
>   		  struct drm_dp_mst_topology_mgr *mgr,
>   		  struct nv50_msto *msto)
>   {
>   	struct nouveau_drm *drm = nouveau_drm(msto->encoder.dev);
> @@ -962,11 +962,11 @@ nv50_msto_prepare(struct drm_atomic_state *state,
>   static int
>   nv50_msto_atomic_check(struct drm_encoder *encoder,
>   		       struct drm_crtc_state *crtc_state,
>   		       struct drm_connector_state *conn_state)
>   {
> -	struct drm_atomic_state *state = crtc_state->state;
> +	struct drm_atomic_commit *state = crtc_state->state;
>   	struct drm_connector *connector = conn_state->connector;
>   	struct drm_dp_mst_topology_state *mst_state;
>   	struct nv50_mstc *mstc = nv50_mstc(connector);
>   	struct nv50_mstm *mstm = mstc->mstm;
>   	struct nv50_head_atom *asyh = nv50_head_atom(crtc_state);
> @@ -1022,11 +1022,11 @@ nv50_dp_bpc_to_depth(unsigned int bpc)
>   	default: return NV837D_SOR_SET_CONTROL_PIXEL_DEPTH_BPP_30_444;
>   	}
>   }
>   
>   static void
> -nv50_msto_atomic_enable(struct drm_encoder *encoder, struct drm_atomic_state *state)
> +nv50_msto_atomic_enable(struct drm_encoder *encoder, struct drm_atomic_commit *state)
>   {
>   	struct nv50_msto *msto = nv50_msto(encoder);
>   	struct nv50_head *head = msto->head;
>   	struct nv50_head_atom *asyh =
>   		nv50_head_atom(drm_atomic_get_new_crtc_state(state, &head->base.base));
> @@ -1071,11 +1071,11 @@ nv50_msto_atomic_enable(struct drm_encoder *encoder, struct drm_atomic_state *st
>   	msto->enabled = true;
>   	mstm->modified = true;
>   }
>   
>   static void
> -nv50_msto_atomic_disable(struct drm_encoder *encoder, struct drm_atomic_state *state)
> +nv50_msto_atomic_disable(struct drm_encoder *encoder, struct drm_atomic_commit *state)
>   {
>   	struct nv50_msto *msto = nv50_msto(encoder);
>   	struct nv50_mstc *mstc = msto->mstc;
>   	struct nv50_mstm *mstm = mstc->mstm;
>   
> @@ -1132,11 +1132,11 @@ nv50_msto_new(struct drm_device *dev, struct nv50_head *head, int id)
>   	return msto;
>   }
>   
>   static struct drm_encoder *
>   nv50_mstc_atomic_best_encoder(struct drm_connector *connector,
> -			      struct drm_atomic_state *state)
> +			      struct drm_atomic_commit *state)
>   {
>   	struct drm_connector_state *connector_state = drm_atomic_get_new_connector_state(state,
>   											 connector);
>   	struct nv50_mstc *mstc = nv50_mstc(connector);
>   	struct drm_crtc *crtc = connector_state->crtc;
> @@ -1190,11 +1190,11 @@ nv50_mstc_get_modes(struct drm_connector *connector)
>   	return ret;
>   }
>   
>   static int
>   nv50_mstc_atomic_check(struct drm_connector *connector,
> -		       struct drm_atomic_state *state)
> +		       struct drm_atomic_commit *state)
>   {
>   	struct nv50_mstc *mstc = nv50_mstc(connector);
>   	struct drm_dp_mst_topology_mgr *mgr = &mstc->mstm->mgr;
>   
>   	return drm_dp_atomic_release_time_slots(state, mgr, mstc->port);
> @@ -1299,11 +1299,11 @@ nv50_mstc_new(struct nv50_mstm *mstm, struct drm_dp_mst_port *port,
>   	drm_dp_mst_get_port_malloc(port);
>   	return 0;
>   }
>   
>   static void
> -nv50_mstm_cleanup(struct drm_atomic_state *state,
> +nv50_mstm_cleanup(struct drm_atomic_commit *state,
>   		  struct drm_dp_mst_topology_state *mst_state,
>   		  struct nv50_mstm *mstm)
>   {
>   	struct nouveau_drm *drm = nouveau_drm(mstm->outp->base.base.dev);
>   	struct drm_encoder *encoder;
> @@ -1328,11 +1328,11 @@ nv50_mstm_cleanup(struct drm_atomic_state *state,
>   
>   	mstm->modified = false;
>   }
>   
>   static void
> -nv50_mstm_prepare(struct drm_atomic_state *state,
> +nv50_mstm_prepare(struct drm_atomic_commit *state,
>   		  struct drm_dp_mst_topology_state *mst_state,
>   		  struct nv50_mstm *mstm)
>   {
>   	struct nouveau_drm *drm = nouveau_drm(mstm->outp->base.base.dev);
>   	struct drm_encoder *encoder;
> @@ -1560,11 +1560,11 @@ nv50_sor_update(struct nouveau_encoder *nv_encoder, u8 head,
>    * As well, should we add a DRM helper for waiting for the backlight to acknowledge
>    * the panel backlight has been shut off? Intel doesn't seem to do this, and uses a
>    * fixed time delay from the vbios…
>    */
>   static void
> -nv50_sor_atomic_disable(struct drm_encoder *encoder, struct drm_atomic_state *state)
> +nv50_sor_atomic_disable(struct drm_encoder *encoder, struct drm_atomic_commit *state)
>   {
>   	struct nouveau_encoder *nv_encoder = nouveau_encoder(encoder);
>   	struct nv50_head *head = nv50_head(nv_encoder->crtc);
>   #ifdef CONFIG_DRM_NOUVEAU_BACKLIGHT
>   	struct nouveau_connector *nv_connector = nv50_outp_get_old_connector(state, nv_encoder);
> @@ -1739,11 +1739,11 @@ nv50_sor_dp_watermark_sst(struct nouveau_encoder *outp,
>   
>   	return nvif_outp_dp_sst(&outp->outp, head->base.index, waterMark, hBlankSym, vBlankSym);
>   }
>   
>   static void
> -nv50_sor_atomic_enable(struct drm_encoder *encoder, struct drm_atomic_state *state)
> +nv50_sor_atomic_enable(struct drm_encoder *encoder, struct drm_atomic_commit *state)
>   {
>   	struct nouveau_encoder *nv_encoder = nouveau_encoder(encoder);
>   	struct nouveau_crtc *nv_crtc = nv50_outp_get_new_crtc(state, nv_encoder);
>   	struct nv50_head_atom *asyh =
>   		nv50_head_atom(drm_atomic_get_new_crtc_state(state, &nv_crtc->base));
> @@ -1965,22 +1965,22 @@ nv50_pior_atomic_check(struct drm_encoder *encoder,
>   	crtc_state->adjusted_mode.clock *= 2;
>   	return 0;
>   }
>   
>   static void
> -nv50_pior_atomic_disable(struct drm_encoder *encoder, struct drm_atomic_state *state)
> +nv50_pior_atomic_disable(struct drm_encoder *encoder, struct drm_atomic_commit *state)
>   {
>   	struct nouveau_encoder *nv_encoder = nouveau_encoder(encoder);
>   	struct nv50_core *core = nv50_disp(encoder->dev)->core;
>   	const u32 ctrl = NVDEF(NV507D, PIOR_SET_CONTROL, OWNER, NONE);
>   
>   	core->func->pior->ctrl(core, nv_encoder->outp.or.id, ctrl, NULL);
>   	nv_encoder->crtc = NULL;
>   }
>   
>   static void
> -nv50_pior_atomic_enable(struct drm_encoder *encoder, struct drm_atomic_state *state)
> +nv50_pior_atomic_enable(struct drm_encoder *encoder, struct drm_atomic_commit *state)
>   {
>   	struct nouveau_encoder *nv_encoder = nouveau_encoder(encoder);
>   	struct nouveau_crtc *nv_crtc = nv50_outp_get_new_crtc(state, nv_encoder);
>   	struct nv50_head_atom *asyh =
>   		nv50_head_atom(drm_atomic_get_new_crtc_state(state, &nv_crtc->base));
> @@ -2097,11 +2097,11 @@ nv50_pior_create(struct nouveau_encoder *nv_encoder)
>   /******************************************************************************
>    * Atomic
>    *****************************************************************************/
>   
>   static void
> -nv50_disp_atomic_commit_core(struct drm_atomic_state *state, u32 *interlock)
> +nv50_disp_atomic_commit_core(struct drm_atomic_commit *state, u32 *interlock)
>   {
>   	struct drm_dp_mst_topology_mgr *mgr;
>   	struct drm_dp_mst_topology_state *mst_state;
>   	struct nouveau_drm *drm = nouveau_drm(state->dev);
>   	struct nv50_disp *disp = nv50_disp(drm->dev);
> @@ -2148,11 +2148,11 @@ nv50_disp_atomic_commit_core(struct drm_atomic_state *state, u32 *interlock)
>   		}
>   	}
>   }
>   
>   static void
> -nv50_disp_atomic_commit_wndw(struct drm_atomic_state *state, u32 *interlock)
> +nv50_disp_atomic_commit_wndw(struct drm_atomic_commit *state, u32 *interlock)
>   {
>   	struct drm_plane_state *new_plane_state;
>   	struct drm_plane *plane;
>   	int i;
>   
> @@ -2164,11 +2164,11 @@ nv50_disp_atomic_commit_wndw(struct drm_atomic_state *state, u32 *interlock)
>   		}
>   	}
>   }
>   
>   static void
> -nv50_disp_atomic_commit_tail(struct drm_atomic_state *state)
> +nv50_disp_atomic_commit_tail(struct drm_atomic_commit *state)
>   {
>   	struct drm_device *dev = state->dev;
>   	struct drm_crtc_state *new_crtc_state, *old_crtc_state;
>   	struct drm_crtc *crtc;
>   	struct drm_plane_state *new_plane_state;
> @@ -2406,28 +2406,28 @@ nv50_disp_atomic_commit_tail(struct drm_atomic_state *state)
>   		nv50_crc_atomic_release_notifier_contexts(state);
>   
>   	drm_atomic_helper_commit_hw_done(state);
>   	drm_atomic_helper_cleanup_planes(dev, state);
>   	drm_atomic_helper_commit_cleanup_done(state);
> -	drm_atomic_state_put(state);
> +	drm_atomic_commit_put(state);
>   
>   	/* Drop the RPM ref we got from nv50_disp_atomic_commit() */
>   	pm_runtime_mark_last_busy(dev->dev);
>   	pm_runtime_put_autosuspend(dev->dev);
>   }
>   
>   static void
>   nv50_disp_atomic_commit_work(struct work_struct *work)
>   {
> -	struct drm_atomic_state *state =
> +	struct drm_atomic_commit *state =
>   		container_of(work, typeof(*state), commit_work);
>   	nv50_disp_atomic_commit_tail(state);
>   }
>   
>   static int
>   nv50_disp_atomic_commit(struct drm_device *dev,
> -			struct drm_atomic_state *state, bool nonblock)
> +			struct drm_atomic_commit *state, bool nonblock)
>   {
>   	struct drm_plane_state *new_plane_state;
>   	struct drm_plane *plane;
>   	int ret, i;
>   
> @@ -2463,11 +2463,11 @@ nv50_disp_atomic_commit(struct drm_device *dev,
>   
>   		if (asyw->set.image)
>   			nv50_wndw_ntfy_enable(wndw, asyw);
>   	}
>   
> -	drm_atomic_state_get(state);
> +	drm_atomic_commit_get(state);
>   
>   	/*
>   	 * Grab another RPM ref for the commit tail, which will release the
>   	 * ref when it's finished
>   	 */
> @@ -2558,11 +2558,11 @@ nv50_disp_outp_atomic_check_set(struct nv50_atom *atom,
>   
>   	return 0;
>   }
>   
>   static int
> -nv50_disp_atomic_check(struct drm_device *dev, struct drm_atomic_state *state)
> +nv50_disp_atomic_check(struct drm_device *dev, struct drm_atomic_commit *state)
>   {
>   	struct nv50_atom *atom = nv50_atom(state);
>   	struct nv50_core *core = nv50_disp(dev)->core;
>   	struct drm_connector_state *old_connector_state, *new_connector_state;
>   	struct drm_connector *connector;
> @@ -2616,37 +2616,37 @@ nv50_disp_atomic_check(struct drm_device *dev, struct drm_atomic_state *state)
>   
>   	return 0;
>   }
>   
>   static void
> -nv50_disp_atomic_state_clear(struct drm_atomic_state *state)
> +nv50_disp_atomic_state_clear(struct drm_atomic_commit *state)
>   {
>   	struct nv50_atom *atom = nv50_atom(state);
>   	struct nv50_outp_atom *outp, *outt;
>   
>   	list_for_each_entry_safe(outp, outt, &atom->outp, head) {
>   		list_del(&outp->head);
>   		kfree(outp);
>   	}
>   
> -	drm_atomic_state_default_clear(state);
> +	drm_atomic_commit_default_clear(state);
>   }
>   
>   static void
> -nv50_disp_atomic_state_free(struct drm_atomic_state *state)
> +nv50_disp_atomic_state_free(struct drm_atomic_commit *state)
>   {
>   	struct nv50_atom *atom = nv50_atom(state);
> -	drm_atomic_state_default_release(&atom->state);
> +	drm_atomic_commit_default_release(&atom->state);
>   	kfree(atom);
>   }
>   
> -static struct drm_atomic_state *
> +static struct drm_atomic_commit *
>   nv50_disp_atomic_state_alloc(struct drm_device *dev)
>   {
>   	struct nv50_atom *atom;
>   	if (!(atom = kzalloc_obj(*atom)) ||
> -	    drm_atomic_state_init(dev, &atom->state) < 0) {
> +	    drm_atomic_commit_init(dev, &atom->state) < 0) {
>   		kfree(atom);
>   		return NULL;
>   	}
>   	INIT_LIST_HEAD(&atom->outp);
>   	return &atom->state;
> diff --git a/drivers/gpu/drm/nouveau/dispnv50/head.c b/drivers/gpu/drm/nouveau/dispnv50/head.c
> index 4ca7700fb784d3d7a54a7c928ce9af1dd2f95259..1affa0378bd0292e080365eb24133dc140962dcf 100644
> --- a/drivers/gpu/drm/nouveau/dispnv50/head.c
> +++ b/drivers/gpu/drm/nouveau/dispnv50/head.c
> @@ -328,11 +328,11 @@ nv50_head_atomic_check_mode(struct nv50_head *head, struct nv50_head_atom *asyh)
>   	asyh->set.or = head->func->or != NULL;
>   	asyh->set.mode = true;
>   }
>   
>   static int
> -nv50_head_atomic_check(struct drm_crtc *crtc, struct drm_atomic_state *state)
> +nv50_head_atomic_check(struct drm_crtc *crtc, struct drm_atomic_commit *state)
>   {
>   	struct drm_crtc_state *old_crtc_state = drm_atomic_get_old_crtc_state(state,
>   									      crtc);
>   	struct drm_crtc_state *crtc_state = drm_atomic_get_new_crtc_state(state,
>   									  crtc);
> diff --git a/drivers/gpu/drm/nouveau/dispnv50/wndw.c b/drivers/gpu/drm/nouveau/dispnv50/wndw.c
> index 9ad4973716f7f5894611f9b82678e0696ffd9979..2635458d52acc0a80cab4963f63594e56d53e637 100644
> --- a/drivers/gpu/drm/nouveau/dispnv50/wndw.c
> +++ b/drivers/gpu/drm/nouveau/dispnv50/wndw.c
> @@ -439,11 +439,11 @@ nv50_wndw_atomic_check_lut(struct nv50_wndw *wndw,
>   	return 0;
>   }
>   
>   static int
>   nv50_wndw_atomic_check(struct drm_plane *plane,
> -		       struct drm_atomic_state *state)
> +		       struct drm_atomic_commit *state)
>   {
>   	struct drm_plane_state *new_plane_state = drm_atomic_get_new_plane_state(state,
>   										 plane);
>   	struct nouveau_drm *drm = nouveau_drm(plane->dev);
>   	struct nv50_wndw *wndw = nv50_wndw(plane);
> diff --git a/drivers/gpu/drm/nouveau/nouveau_connector.c b/drivers/gpu/drm/nouveau/nouveau_connector.c
> index cc239492c7f0b88b832ac9e6f4610b4833cc3b78..b0b0ad9a0c248cb55aaa90cfc4b80512324fb778 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_connector.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_connector.c
> @@ -1130,11 +1130,11 @@ nouveau_connector_best_encoder(struct drm_connector *connector)
>   
>   	return NULL;
>   }
>   
>   static int
> -nouveau_connector_atomic_check(struct drm_connector *connector, struct drm_atomic_state *state)
> +nouveau_connector_atomic_check(struct drm_connector *connector, struct drm_atomic_commit *state)
>   {
>   	struct nouveau_connector *nv_conn = nouveau_connector(connector);
>   	struct drm_connector_state *conn_state =
>   		drm_atomic_get_new_connector_state(state, connector);
>   
> diff --git a/drivers/gpu/drm/nouveau/nouveau_display.h b/drivers/gpu/drm/nouveau/nouveau_display.h
> index 470e0910d48458cce7f73fc631a66f30a11cae7f..e711c89723e80129f3c7b94f05a9fcf3a892597b 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_display.h
> +++ b/drivers/gpu/drm/nouveau/nouveau_display.h
> @@ -32,11 +32,11 @@ struct nouveau_display {
>   	struct drm_property *underscan_vborder_property;
>   	/* not really hue and saturation: */
>   	struct drm_property *vibrant_hue_property;
>   	struct drm_property *color_vibrance_property;
>   
> -	struct drm_atomic_state *suspend;
> +	struct drm_atomic_commit *suspend;
>   
>   	const u64 *format_modifiers;
>   };
>   
>   static inline struct nouveau_display *
> diff --git a/drivers/gpu/drm/nouveau/nouveau_encoder.h b/drivers/gpu/drm/nouveau/nouveau_encoder.h
> index dce8e5d9d4964842adcc7725ae4e12a36c4beb5a..4422c6185d4989dc460b1c76a9a0ed02497f7979 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_encoder.h
> +++ b/drivers/gpu/drm/nouveau/nouveau_encoder.h
> @@ -163,13 +163,13 @@ void nouveau_dp_irq(struct work_struct *);
>   enum drm_mode_status nv50_dp_mode_valid(struct nouveau_encoder *,
>   					const struct drm_display_mode *,
>   					unsigned *clock);
>   
>   struct nouveau_connector *
> -nv50_outp_get_new_connector(struct drm_atomic_state *state, struct nouveau_encoder *outp);
> +nv50_outp_get_new_connector(struct drm_atomic_commit *state, struct nouveau_encoder *outp);
>   struct nouveau_connector *
> -nv50_outp_get_old_connector(struct drm_atomic_state *state, struct nouveau_encoder *outp);
> +nv50_outp_get_old_connector(struct drm_atomic_commit *state, struct nouveau_encoder *outp);
>   
>   int nv50_mstm_detect(struct nouveau_encoder *encoder);
>   void nv50_mstm_remove(struct nv50_mstm *mstm);
>   bool nv50_mstm_service(struct nouveau_drm *drm,
>   		       struct nouveau_connector *nv_connector,
> diff --git a/drivers/gpu/drm/omapdrm/dss/hdmi4.c b/drivers/gpu/drm/omapdrm/dss/hdmi4.c
> index 29b2dfb90b5fa3b137d05725d65a1cccb9cd1345..e306247ed8a0543606b9cc831f485c0c9a30e37a 100644
> --- a/drivers/gpu/drm/omapdrm/dss/hdmi4.c
> +++ b/drivers/gpu/drm/omapdrm/dss/hdmi4.c
> @@ -340,11 +340,11 @@ static void hdmi4_bridge_mode_set(struct drm_bridge *bridge,
>   
>   	mutex_unlock(&hdmi->lock);
>   }
>   
>   static void hdmi4_bridge_enable(struct drm_bridge *bridge,
> -				struct drm_atomic_state *state)
> +				struct drm_atomic_commit *state)
>   {
>   	struct omap_hdmi *hdmi = drm_bridge_to_hdmi(bridge);
>   	struct drm_connector_state *conn_state;
>   	struct drm_connector *connector;
>   	struct drm_crtc_state *crtc_state;
> @@ -408,11 +408,11 @@ static void hdmi4_bridge_enable(struct drm_bridge *bridge,
>   done:
>   	mutex_unlock(&hdmi->lock);
>   }
>   
>   static void hdmi4_bridge_disable(struct drm_bridge *bridge,
> -				 struct drm_atomic_state *state)
> +				 struct drm_atomic_commit *state)
>   {
>   	struct omap_hdmi *hdmi = drm_bridge_to_hdmi(bridge);
>   	unsigned long flags;
>   
>   	mutex_lock(&hdmi->lock);
> diff --git a/drivers/gpu/drm/omapdrm/dss/hdmi5.c b/drivers/gpu/drm/omapdrm/dss/hdmi5.c
> index 5636b3dfec1c9581118b20adecd268c03e882efb..ab2d4eb6787f2e7bb5e17d1d129c81b9de17bb4b 100644
> --- a/drivers/gpu/drm/omapdrm/dss/hdmi5.c
> +++ b/drivers/gpu/drm/omapdrm/dss/hdmi5.c
> @@ -338,11 +338,11 @@ static void hdmi5_bridge_mode_set(struct drm_bridge *bridge,
>   
>   	mutex_unlock(&hdmi->lock);
>   }
>   
>   static void hdmi5_bridge_enable(struct drm_bridge *bridge,
> -				struct drm_atomic_state *state)
> +				struct drm_atomic_commit *state)
>   {
>   	struct omap_hdmi *hdmi = drm_bridge_to_hdmi(bridge);
>   	struct drm_connector_state *conn_state;
>   	struct drm_connector *connector;
>   	struct drm_crtc_state *crtc_state;
> @@ -406,11 +406,11 @@ static void hdmi5_bridge_enable(struct drm_bridge *bridge,
>   done:
>   	mutex_unlock(&hdmi->lock);
>   }
>   
>   static void hdmi5_bridge_disable(struct drm_bridge *bridge,
> -				 struct drm_atomic_state *state)
> +				 struct drm_atomic_commit *state)
>   {
>   	struct omap_hdmi *hdmi = drm_bridge_to_hdmi(bridge);
>   	unsigned long flags;
>   
>   	mutex_lock(&hdmi->lock);
> diff --git a/drivers/gpu/drm/omapdrm/omap_crtc.c b/drivers/gpu/drm/omapdrm/omap_crtc.c
> index ee4c0119d40899242e4c5b67cb0d7e2230207315..c1b41e010a004581544db99da401308e276c3a48 100644
> --- a/drivers/gpu/drm/omapdrm/omap_crtc.c
> +++ b/drivers/gpu/drm/omapdrm/omap_crtc.c
> @@ -444,11 +444,11 @@ static void omap_crtc_arm_event(struct drm_crtc *crtc)
>   		crtc->state->event = NULL;
>   	}
>   }
>   
>   static void omap_crtc_atomic_enable(struct drm_crtc *crtc,
> -				    struct drm_atomic_state *state)
> +				    struct drm_atomic_commit *state)
>   {
>   	struct omap_drm_private *priv = crtc->dev->dev_private;
>   	struct omap_crtc *omap_crtc = to_omap_crtc(crtc);
>   	struct omap_crtc_state *omap_state = to_omap_crtc_state(crtc->state);
>   	int ret;
> @@ -470,11 +470,11 @@ static void omap_crtc_atomic_enable(struct drm_crtc *crtc,
>   	omap_crtc_arm_event(crtc);
>   	spin_unlock_irq(&crtc->dev->event_lock);
>   }
>   
>   static void omap_crtc_atomic_disable(struct drm_crtc *crtc,
> -				     struct drm_atomic_state *state)
> +				     struct drm_atomic_commit *state)
>   {
>   	struct omap_drm_private *priv = crtc->dev->dev_private;
>   	struct omap_crtc *omap_crtc = to_omap_crtc(crtc);
>   	struct drm_device *dev = crtc->dev;
>   
> @@ -575,11 +575,11 @@ static bool omap_crtc_is_manually_updated(struct drm_crtc *crtc)
>   	DBG("detected manually updated display!");
>   	return true;
>   }
>   
>   static int omap_crtc_atomic_check(struct drm_crtc *crtc,
> -				struct drm_atomic_state *state)
> +				struct drm_atomic_commit *state)
>   {
>   	struct drm_crtc_state *crtc_state = drm_atomic_get_new_crtc_state(state,
>   									  crtc);
>   	struct drm_plane_state *pri_state;
>   
> @@ -607,16 +607,16 @@ static int omap_crtc_atomic_check(struct drm_crtc *crtc,
>   
>   	return 0;
>   }
>   
>   static void omap_crtc_atomic_begin(struct drm_crtc *crtc,
> -				   struct drm_atomic_state *state)
> +				   struct drm_atomic_commit *state)
>   {
>   }
>   
>   static void omap_crtc_atomic_flush(struct drm_crtc *crtc,
> -				   struct drm_atomic_state *state)
> +				   struct drm_atomic_commit *state)
>   {
>   	struct omap_drm_private *priv = crtc->dev->dev_private;
>   	struct omap_crtc *omap_crtc = to_omap_crtc(crtc);
>   	struct omap_crtc_state *omap_crtc_state = to_omap_crtc_state(crtc->state);
>   	int ret;
> diff --git a/drivers/gpu/drm/omapdrm/omap_drv.c b/drivers/gpu/drm/omapdrm/omap_drv.c
> index ae678696fbacb0572869c7152a484fc5736ac44a..2042a633835f790e13dafb9eb8cf831ac0d5ac02 100644
> --- a/drivers/gpu/drm/omapdrm/omap_drv.c
> +++ b/drivers/gpu/drm/omapdrm/omap_drv.c
> @@ -44,11 +44,11 @@
>    *    connector:   dssdev.. manager can be attached/detached from different
>    *                 devices
>    */
>   
>   static void omap_atomic_wait_for_completion(struct drm_device *dev,
> -					    struct drm_atomic_state *old_state)
> +					    struct drm_atomic_commit *old_state)
>   {
>   	struct drm_crtc_state *new_crtc_state;
>   	struct drm_crtc *crtc;
>   	unsigned int i;
>   	int ret;
> @@ -63,11 +63,11 @@ static void omap_atomic_wait_for_completion(struct drm_device *dev,
>   			dev_warn(dev->dev,
>   				 "atomic complete timeout (pipe %u)!\n", i);
>   	}
>   }
>   
> -static void omap_atomic_commit_tail(struct drm_atomic_state *old_state)
> +static void omap_atomic_commit_tail(struct drm_atomic_commit *old_state)
>   {
>   	struct drm_device *dev = old_state->dev;
>   	struct omap_drm_private *priv = dev->dev_private;
>   
>   	dispc_runtime_get(priv->dispc);
> @@ -115,11 +115,11 @@ static void omap_atomic_commit_tail(struct drm_atomic_state *old_state)
>   	drm_atomic_helper_cleanup_planes(dev, old_state);
>   
>   	dispc_runtime_put(priv->dispc);
>   }
>   
> -static int drm_atomic_state_normalized_zpos_cmp(const void *a, const void *b)
> +static int drm_atomic_commit_normalized_zpos_cmp(const void *a, const void *b)
>   {
>   	const struct drm_plane_state *sa = *(struct drm_plane_state **)a;
>   	const struct drm_plane_state *sb = *(struct drm_plane_state **)b;
>   
>   	if (sa->normalized_zpos != sb->normalized_zpos)
> @@ -134,11 +134,11 @@ static int drm_atomic_state_normalized_zpos_cmp(const void *a, const void *b)
>    * Since both halves need to be 'appear' side by side the zpos is
>    * recalculated when dealing with dual overlay cases so that the other
>    * planes zpos is consistent.
>    */
>   static int omap_atomic_update_normalize_zpos(struct drm_device *dev,
> -					     struct drm_atomic_state *state)
> +					     struct drm_atomic_commit *state)
>   {
>   	struct drm_crtc *crtc;
>   	struct drm_crtc_state *old_state, *new_state;
>   	struct drm_plane *plane;
>   	int c, i, n, inc;
> @@ -172,11 +172,11 @@ static int omap_atomic_update_normalize_zpos(struct drm_device *dev,
>   			}
>   			states[n++] = plane_state;
>   		}
>   
>   		sort(states, n, sizeof(*states),
> -		     drm_atomic_state_normalized_zpos_cmp, NULL);
> +		     drm_atomic_commit_normalized_zpos_cmp, NULL);
>   
>   		for (i = 0, inc = 0; i < n; i++) {
>   			plane = states[i]->plane;
>   
>   			states[i]->normalized_zpos = i + inc;
> @@ -194,11 +194,11 @@ static int omap_atomic_update_normalize_zpos(struct drm_device *dev,
>   	kfree(states);
>   	return ret;
>   }
>   
>   static int omap_atomic_check(struct drm_device *dev,
> -			     struct drm_atomic_state *state)
> +			     struct drm_atomic_commit *state)
>   {
>   	int ret;
>   
>   	ret = drm_atomic_helper_check(dev, state);
>   	if (ret)
> @@ -239,11 +239,11 @@ omap_get_existing_global_state(struct omap_drm_private *priv)
>   /*
>    * This acquires the modeset lock set aside for global state, creates
>    * a new duplicated private object state.
>    */
>   struct omap_global_state *__must_check
> -omap_get_global_state(struct drm_atomic_state *s)
> +omap_get_global_state(struct drm_atomic_commit *s)
>   {
>   	struct omap_drm_private *priv = s->dev->dev_private;
>   	struct drm_private_state *priv_state;
>   
>   	priv_state = drm_atomic_get_private_obj_state(s, &priv->glob_obj);
> diff --git a/drivers/gpu/drm/omapdrm/omap_drv.h b/drivers/gpu/drm/omapdrm/omap_drv.h
> index d903568fd8ccadb33ccc01b906d8a39a8402453a..c1f24ce929d966104eb6a39b1f355f42fa1cdd81 100644
> --- a/drivers/gpu/drm/omapdrm/omap_drv.h
> +++ b/drivers/gpu/drm/omapdrm/omap_drv.h
> @@ -103,10 +103,10 @@ struct omap_drm_private {
>   };
>   
>   
>   void omap_debugfs_init(struct drm_minor *minor);
>   
> -struct omap_global_state * __must_check omap_get_global_state(struct drm_atomic_state *s);
> +struct omap_global_state * __must_check omap_get_global_state(struct drm_atomic_commit *s);
>   
>   struct omap_global_state *omap_get_existing_global_state(struct omap_drm_private *priv);
>   
>   #endif /* __OMAPDRM_DRV_H__ */
> diff --git a/drivers/gpu/drm/omapdrm/omap_overlay.c b/drivers/gpu/drm/omapdrm/omap_overlay.c
> index 77c1b78d0163a2019707f7790db172611d796ff3..d722e3c7db760b89ffcec760125bdce53b7689ab 100644
> --- a/drivers/gpu/drm/omapdrm/omap_overlay.c
> +++ b/drivers/gpu/drm/omapdrm/omap_overlay.c
> @@ -64,11 +64,11 @@ omap_plane_find_free_overlay(struct drm_device *dev, struct drm_plane *hwoverlay
>    * If a plane need a new overlay, the previous one should have been released
>    * with omap_overlay_release()
>    * This should be called from the plane atomic_check() in order to prepare the
>    * next global overlay_map to be enabled when atomic transaction is valid.
>    */
> -int omap_overlay_assign(struct drm_atomic_state *s, struct drm_plane *plane,
> +int omap_overlay_assign(struct drm_atomic_commit *s, struct drm_plane *plane,
>   			u32 caps, u32 fourcc, struct omap_hw_overlay **overlay,
>   			struct omap_hw_overlay **r_overlay)
>   {
>   	/* Get the global state of the current atomic transaction */
>   	struct omap_global_state *state = omap_get_global_state(s);
> @@ -109,11 +109,11 @@ int omap_overlay_assign(struct drm_atomic_state *s, struct drm_plane *plane,
>    * Release an overlay from a plane if the plane gets not visible or the plane
>    * need a new overlay if overlay caps changes.
>    * This should be called from the plane atomic_check() in order to prepare the
>    * next global overlay_map to be enabled when atomic transaction is valid.
>    */
> -void omap_overlay_release(struct drm_atomic_state *s, struct omap_hw_overlay *overlay)
> +void omap_overlay_release(struct drm_atomic_commit *s, struct omap_hw_overlay *overlay)
>   {
>   	/* Get the global state of the current atomic transaction */
>   	struct omap_global_state *state = omap_get_global_state(s);
>   	struct drm_plane **overlay_map = state->hwoverlay_to_plane;
>   
> diff --git a/drivers/gpu/drm/omapdrm/omap_overlay.h b/drivers/gpu/drm/omapdrm/omap_overlay.h
> index e36a43f355638d3a3e50e3e8ad1f6a596e7ebf93..e44332455210c41986f5cf26dc51b9876f1fb9a9 100644
> --- a/drivers/gpu/drm/omapdrm/omap_overlay.h
> +++ b/drivers/gpu/drm/omapdrm/omap_overlay.h
> @@ -25,11 +25,11 @@ struct omap_hw_overlay {
>   	enum omap_overlay_caps caps;
>   };
>   
>   int omap_hwoverlays_init(struct omap_drm_private *priv);
>   void omap_hwoverlays_destroy(struct omap_drm_private *priv);
> -int omap_overlay_assign(struct drm_atomic_state *s, struct drm_plane *plane,
> +int omap_overlay_assign(struct drm_atomic_commit *s, struct drm_plane *plane,
>   			u32 caps, u32 fourcc, struct omap_hw_overlay **overlay,
>   			struct omap_hw_overlay **r_overlay);
> -void omap_overlay_release(struct drm_atomic_state *s, struct omap_hw_overlay *overlay);
> +void omap_overlay_release(struct drm_atomic_commit *s, struct omap_hw_overlay *overlay);
>   void omap_overlay_update_state(struct omap_drm_private *priv, struct omap_hw_overlay *overlay);
>   #endif /* __OMAPDRM_OVERLAY_H__ */
> diff --git a/drivers/gpu/drm/omapdrm/omap_plane.c b/drivers/gpu/drm/omapdrm/omap_plane.c
> index 0e09d8f1fe5e3269a459b0f90b954fd806fe394a..c024cdbbd87afefa4327be10a4455327fe0a8365 100644
> --- a/drivers/gpu/drm/omapdrm/omap_plane.c
> +++ b/drivers/gpu/drm/omapdrm/omap_plane.c
> @@ -60,11 +60,11 @@ static void omap_plane_cleanup_fb(struct drm_plane *plane,
>   	if (old_state->fb)
>   		omap_framebuffer_unpin(old_state->fb);
>   }
>   
>   static void omap_plane_atomic_update(struct drm_plane *plane,
> -				     struct drm_atomic_state *state)
> +				     struct drm_atomic_commit *state)
>   {
>   	struct omap_drm_private *priv = plane->dev->dev_private;
>   	struct drm_plane_state *new_state = drm_atomic_get_new_plane_state(state,
>   									   plane);
>   	struct drm_plane_state *old_state = drm_atomic_get_old_plane_state(state,
> @@ -165,11 +165,11 @@ static void omap_plane_atomic_update(struct drm_plane *plane,
>   		dispc_ovl_enable(priv->dispc, r_ovl_id, true);
>   	}
>   }
>   
>   static void omap_plane_atomic_disable(struct drm_plane *plane,
> -				      struct drm_atomic_state *state)
> +				      struct drm_atomic_commit *state)
>   {
>   	struct omap_drm_private *priv = plane->dev->dev_private;
>   	struct omap_plane *omap_plane = to_omap_plane(plane);
>   	struct drm_plane_state *new_state = drm_atomic_get_new_plane_state(state,
>   									   plane);
> @@ -197,11 +197,11 @@ static void omap_plane_atomic_disable(struct drm_plane *plane,
>   }
>   
>   #define FRAC_16_16(mult, div)    (((mult) << 16) / (div))
>   
>   static int omap_plane_atomic_check(struct drm_plane *plane,
> -				   struct drm_atomic_state *state)
> +				   struct drm_atomic_commit *state)
>   {
>   	struct drm_plane_state *new_plane_state = drm_atomic_get_new_plane_state(state,
>   										 plane);
>   	struct drm_plane_state *old_plane_state = drm_atomic_get_old_plane_state(state,
>   										 plane);
> diff --git a/drivers/gpu/drm/qxl/qxl_display.c b/drivers/gpu/drm/qxl/qxl_display.c
> index 75d47e6b914222c85bec9f50fb67e393842f482d..a026bd35ef485851d2fa3b3856a731d594c0f06a 100644
> --- a/drivers/gpu/drm/qxl/qxl_display.c
> +++ b/drivers/gpu/drm/qxl/qxl_display.c
> @@ -380,11 +380,11 @@ static void qxl_crtc_update_monitors_config(struct drm_crtc *crtc,
>   	qdev->monitors_config->max_allowed = qxl_num_crtc;
>   	qxl_send_monitors_config(qdev);
>   }
>   
>   static void qxl_crtc_atomic_flush(struct drm_crtc *crtc,
> -				  struct drm_atomic_state *state)
> +				  struct drm_atomic_commit *state)
>   {
>   	struct drm_device *dev = crtc->dev;
>   	struct drm_crtc_state *crtc_state = drm_atomic_get_new_crtc_state(state, crtc);
>   	struct drm_pending_vblank_event *event;
>   
> @@ -471,19 +471,19 @@ static const struct drm_framebuffer_funcs qxl_fb_funcs = {
>   	.dirty = qxl_framebuffer_surface_dirty,
>   	.create_handle = drm_gem_fb_create_handle,
>   };
>   
>   static void qxl_crtc_atomic_enable(struct drm_crtc *crtc,
> -				   struct drm_atomic_state *state)
> +				   struct drm_atomic_commit *state)
>   {
>   	qxl_crtc_update_monitors_config(crtc, "enable");
>   
>   	drm_crtc_vblank_on(crtc);
>   }
>   
>   static void qxl_crtc_atomic_disable(struct drm_crtc *crtc,
> -				    struct drm_atomic_state *state)
> +				    struct drm_atomic_commit *state)
>   {
>   	drm_crtc_vblank_off(crtc);
>   
>   	qxl_crtc_update_monitors_config(crtc, "disable");
>   }
> @@ -493,11 +493,11 @@ static const struct drm_crtc_helper_funcs qxl_crtc_helper_funcs = {
>   	.atomic_enable = qxl_crtc_atomic_enable,
>   	.atomic_disable = qxl_crtc_atomic_disable,
>   };
>   
>   static int qxl_primary_atomic_check(struct drm_plane *plane,
> -				    struct drm_atomic_state *state)
> +				    struct drm_atomic_commit *state)
>   {
>   	struct drm_plane_state *new_plane_state = drm_atomic_get_new_plane_state(state,
>   										 plane);
>   	struct qxl_device *qdev = to_qxl(plane->dev);
>   	struct qxl_bo *bo;
> @@ -660,11 +660,11 @@ static void qxl_free_cursor(struct qxl_bo *cursor_bo)
>   	qxl_bo_unpin(cursor_bo);
>   	qxl_bo_unref(&cursor_bo);
>   }
>   
>   static void qxl_primary_atomic_update(struct drm_plane *plane,
> -				      struct drm_atomic_state *state)
> +				      struct drm_atomic_commit *state)
>   {
>   	struct drm_plane_state *new_state = drm_atomic_get_new_plane_state(state,
>   									   plane);
>   	struct qxl_device *qdev = to_qxl(plane->dev);
>   	struct qxl_bo *bo = gem_to_qxl_bo(new_state->fb->obj[0]);
> @@ -693,11 +693,11 @@ static void qxl_primary_atomic_update(struct drm_plane *plane,
>   	qxl_draw_dirty_fb(qdev, new_state->fb, bo, 0, 0, &norect, 1, 1,
>   			  dumb_shadow_offset);
>   }
>   
>   static void qxl_primary_atomic_disable(struct drm_plane *plane,
> -				       struct drm_atomic_state *state)
> +				       struct drm_atomic_commit *state)
>   {
>   	struct drm_plane_state *old_state = drm_atomic_get_old_plane_state(state,
>   									   plane);
>   	struct qxl_device *qdev = to_qxl(plane->dev);
>   
> @@ -710,11 +710,11 @@ static void qxl_primary_atomic_disable(struct drm_plane *plane,
>   			qxl_io_destroy_primary(qdev);
>   	}
>   }
>   
>   static void qxl_cursor_atomic_update(struct drm_plane *plane,
> -				     struct drm_atomic_state *state)
> +				     struct drm_atomic_commit *state)
>   {
>   	struct drm_plane_state *old_state = drm_atomic_get_old_plane_state(state,
>   									   plane);
>   	struct drm_plane_state *new_state = drm_atomic_get_new_plane_state(state,
>   									   plane);
> @@ -727,11 +727,11 @@ static void qxl_cursor_atomic_update(struct drm_plane *plane,
>   		qxl_primary_move_cursor(qdev, new_state);
>   	}
>   }
>   
>   static void qxl_cursor_atomic_disable(struct drm_plane *plane,
> -				      struct drm_atomic_state *state)
> +				      struct drm_atomic_commit *state)
>   {
>   	struct drm_plane_state *old_state = drm_atomic_get_old_plane_state(state,
>   									   plane);
>   	struct qxl_device *qdev = to_qxl(plane->dev);
>   	struct qxl_crtc *qcrtc;
> diff --git a/drivers/gpu/drm/renesas/rcar-du/rcar_du_crtc.c b/drivers/gpu/drm/renesas/rcar-du/rcar_du_crtc.c
> index 28a5aa5a14d803edca790f8033f38ff68b3a13b3..965beed9c0f2c0ba94adf90f80fc7d887af172b9 100644
> --- a/drivers/gpu/drm/renesas/rcar-du/rcar_du_crtc.c
> +++ b/drivers/gpu/drm/renesas/rcar-du/rcar_du_crtc.c
> @@ -687,11 +687,11 @@ static void rcar_du_crtc_stop(struct rcar_du_crtc *rcrtc)
>   /* -----------------------------------------------------------------------------
>    * CRTC Functions
>    */
>   
>   static int rcar_du_crtc_atomic_check(struct drm_crtc *crtc,
> -				     struct drm_atomic_state *state)
> +				     struct drm_atomic_commit *state)
>   {
>   	struct drm_crtc_state *crtc_state = drm_atomic_get_new_crtc_state(state,
>   									  crtc);
>   	struct rcar_du_crtc_state *rstate = to_rcar_crtc_state(crtc_state);
>   	struct drm_encoder *encoder;
> @@ -718,11 +718,11 @@ static int rcar_du_crtc_atomic_check(struct drm_crtc *crtc,
>   
>   	return 0;
>   }
>   
>   static void rcar_du_crtc_atomic_enable(struct drm_crtc *crtc,
> -				       struct drm_atomic_state *state)
> +				       struct drm_atomic_commit *state)
>   {
>   	struct rcar_du_crtc *rcrtc = to_rcar_crtc(crtc);
>   	struct rcar_du_crtc_state *rstate = to_rcar_crtc_state(crtc->state);
>   	struct rcar_du_device *rcdu = rcrtc->dev;
>   
> @@ -766,11 +766,11 @@ static void rcar_du_crtc_atomic_enable(struct drm_crtc *crtc,
>   	 */
>   	rcar_du_cmm_setup(crtc);
>   }
>   
>   static void rcar_du_crtc_atomic_disable(struct drm_crtc *crtc,
> -					struct drm_atomic_state *state)
> +					struct drm_atomic_commit *state)
>   {
>   	struct drm_crtc_state *old_state = drm_atomic_get_old_crtc_state(state,
>   									 crtc);
>   	struct rcar_du_crtc *rcrtc = to_rcar_crtc(crtc);
>   	struct rcar_du_crtc_state *rstate = to_rcar_crtc_state(old_state);
> @@ -810,11 +810,11 @@ static void rcar_du_crtc_atomic_disable(struct drm_crtc *crtc,
>   	}
>   	spin_unlock_irq(&crtc->dev->event_lock);
>   }
>   
>   static void rcar_du_crtc_atomic_begin(struct drm_crtc *crtc,
> -				      struct drm_atomic_state *state)
> +				      struct drm_atomic_commit *state)
>   {
>   	struct rcar_du_crtc *rcrtc = to_rcar_crtc(crtc);
>   
>   	WARN_ON(!crtc->state->enable);
>   
> @@ -839,11 +839,11 @@ static void rcar_du_crtc_atomic_begin(struct drm_crtc *crtc,
>   	if (rcar_du_has(rcrtc->dev, RCAR_DU_FEATURE_VSP1_SOURCE))
>   		rcar_du_vsp_atomic_begin(rcrtc);
>   }
>   
>   static void rcar_du_crtc_atomic_flush(struct drm_crtc *crtc,
> -				      struct drm_atomic_state *state)
> +				      struct drm_atomic_commit *state)
>   {
>   	struct rcar_du_crtc *rcrtc = to_rcar_crtc(crtc);
>   	struct drm_device *dev = rcrtc->crtc.dev;
>   	unsigned long flags;
>   
> @@ -1101,11 +1101,11 @@ static int rcar_du_crtc_set_crc_source(struct drm_crtc *crtc,
>   				       const char *source_name)
>   {
>   	struct rcar_du_crtc *rcrtc = to_rcar_crtc(crtc);
>   	struct drm_modeset_acquire_ctx ctx;
>   	struct drm_crtc_state *crtc_state;
> -	struct drm_atomic_state *state;
> +	struct drm_atomic_commit *state;
>   	enum vsp1_du_crc_source source;
>   	unsigned int index;
>   	int ret;
>   
>   	ret = rcar_du_crtc_parse_crc_source(rcrtc, source_name, &source);
> @@ -1115,11 +1115,11 @@ static int rcar_du_crtc_set_crc_source(struct drm_crtc *crtc,
>   	index = ret;
>   
>   	/* Perform an atomic commit to set the CRC source. */
>   	drm_modeset_acquire_init(&ctx, 0);
>   
> -	state = drm_atomic_state_alloc(crtc->dev);
> +	state = drm_atomic_commit_alloc(crtc->dev);
>   	if (!state) {
>   		ret = -ENOMEM;
>   		goto unlock;
>   	}
>   
> @@ -1138,16 +1138,16 @@ static int rcar_du_crtc_set_crc_source(struct drm_crtc *crtc,
>   	} else {
>   		ret = PTR_ERR(crtc_state);
>   	}
>   
>   	if (ret == -EDEADLK) {
> -		drm_atomic_state_clear(state);
> +		drm_atomic_commit_clear(state);
>   		drm_modeset_backoff(&ctx);
>   		goto retry;
>   	}
>   
> -	drm_atomic_state_put(state);
> +	drm_atomic_commit_put(state);
>   
>   unlock:
>   	drm_modeset_drop_locks(&ctx);
>   	drm_modeset_acquire_fini(&ctx);
>   
> diff --git a/drivers/gpu/drm/renesas/rcar-du/rcar_du_kms.c b/drivers/gpu/drm/renesas/rcar-du/rcar_du_kms.c
> index 60e6f43b8ab2f62a6744583e201699b760b9c1fe..519771f18fc3e2a76ae88e7a87114f1ecfec8bff 100644
> --- a/drivers/gpu/drm/renesas/rcar-du/rcar_du_kms.c
> +++ b/drivers/gpu/drm/renesas/rcar-du/rcar_du_kms.c
> @@ -500,11 +500,11 @@ rcar_du_fb_create(struct drm_device *dev, struct drm_file *file_priv,
>   /* -----------------------------------------------------------------------------
>    * Atomic Check and Update
>    */
>   
>   static int rcar_du_atomic_check(struct drm_device *dev,
> -				struct drm_atomic_state *state)
> +				struct drm_atomic_commit *state)
>   {
>   	struct rcar_du_device *rcdu = to_rcar_du_device(dev);
>   	int ret;
>   
>   	ret = drm_atomic_helper_check(dev, state);
> @@ -515,11 +515,11 @@ static int rcar_du_atomic_check(struct drm_device *dev,
>   		return 0;
>   
>   	return rcar_du_atomic_check_planes(dev, state);
>   }
>   
> -static void rcar_du_atomic_commit_tail(struct drm_atomic_state *old_state)
> +static void rcar_du_atomic_commit_tail(struct drm_atomic_commit *old_state)
>   {
>   	struct drm_device *dev = old_state->dev;
>   	struct rcar_du_device *rcdu = to_rcar_du_device(dev);
>   	struct drm_crtc_state *crtc_state;
>   	struct drm_crtc *crtc;
> diff --git a/drivers/gpu/drm/renesas/rcar-du/rcar_du_plane.c b/drivers/gpu/drm/renesas/rcar-du/rcar_du_plane.c
> index 01840feabdbed97c068dfb9b79739e31945f5574..8870766b9e541187ff8738eca8139f614c13a509 100644
> --- a/drivers/gpu/drm/renesas/rcar-du/rcar_du_plane.c
> +++ b/drivers/gpu/drm/renesas/rcar-du/rcar_du_plane.c
> @@ -125,11 +125,11 @@ static int rcar_du_plane_hwalloc(struct rcar_du_plane *plane,
>   
>   	return i < 0 ? -EBUSY : i;
>   }
>   
>   int rcar_du_atomic_check_planes(struct drm_device *dev,
> -				struct drm_atomic_state *state)
> +				struct drm_atomic_commit *state)
>   {
>   	struct rcar_du_device *rcdu = to_rcar_du_device(dev);
>   	unsigned int group_freed_planes[RCAR_DU_MAX_GROUPS] = { 0, };
>   	unsigned int group_free_planes[RCAR_DU_MAX_GROUPS] = { 0, };
>   	bool needs_realloc = false;
> @@ -633,22 +633,22 @@ int __rcar_du_plane_atomic_check(struct drm_plane *plane,
>   
>   	return 0;
>   }
>   
>   static int rcar_du_plane_atomic_check(struct drm_plane *plane,
> -				      struct drm_atomic_state *state)
> +				      struct drm_atomic_commit *state)
>   {
>   	struct drm_plane_state *new_plane_state = drm_atomic_get_new_plane_state(state,
>   										 plane);
>   	struct rcar_du_plane_state *rstate = to_rcar_plane_state(new_plane_state);
>   
>   	return __rcar_du_plane_atomic_check(plane, new_plane_state,
>   					    &rstate->format);
>   }
>   
>   static void rcar_du_plane_atomic_update(struct drm_plane *plane,
> -					struct drm_atomic_state *state)
> +					struct drm_atomic_commit *state)
>   {
>   	struct drm_plane_state *old_state = drm_atomic_get_old_plane_state(state, plane);
>   	struct drm_plane_state *new_state = drm_atomic_get_new_plane_state(state, plane);
>   	struct rcar_du_plane *rplane = to_rcar_plane(plane);
>   	struct rcar_du_plane_state *old_rstate;
> diff --git a/drivers/gpu/drm/renesas/rcar-du/rcar_du_plane.h b/drivers/gpu/drm/renesas/rcar-du/rcar_du_plane.h
> index e9e59c5e70d54db593f607653b6723895f2a2acc..49970f098b7bed774c0004dbed59a34dbadaaba9 100644
> --- a/drivers/gpu/drm/renesas/rcar-du/rcar_du_plane.h
> +++ b/drivers/gpu/drm/renesas/rcar-du/rcar_du_plane.h
> @@ -62,11 +62,11 @@ to_rcar_plane_state(struct drm_plane_state *state)
>   {
>   	return container_of(state, struct rcar_du_plane_state, state);
>   }
>   
>   int rcar_du_atomic_check_planes(struct drm_device *dev,
> -				struct drm_atomic_state *state);
> +				struct drm_atomic_commit *state);
>   
>   int __rcar_du_plane_atomic_check(struct drm_plane *plane,
>   				 struct drm_plane_state *state,
>   				 const struct rcar_du_format_info **format);
>   
> diff --git a/drivers/gpu/drm/renesas/rcar-du/rcar_du_vsp.c b/drivers/gpu/drm/renesas/rcar-du/rcar_du_vsp.c
> index 94c22d2db197e78f5ba4385304e5adb47f0314d5..33942a1e17d6f315bb6ce2a4c8fd2411a96df451 100644
> --- a/drivers/gpu/drm/renesas/rcar-du/rcar_du_vsp.c
> +++ b/drivers/gpu/drm/renesas/rcar-du/rcar_du_vsp.c
> @@ -362,22 +362,22 @@ static void rcar_du_vsp_plane_cleanup_fb(struct drm_plane *plane,
>   
>   	rcar_du_vsp_unmap_fb(vsp, state->fb, rstate->sg_tables);
>   }
>   
>   static int rcar_du_vsp_plane_atomic_check(struct drm_plane *plane,
> -					  struct drm_atomic_state *state)
> +					  struct drm_atomic_commit *state)
>   {
>   	struct drm_plane_state *new_plane_state = drm_atomic_get_new_plane_state(state,
>   										 plane);
>   	struct rcar_du_vsp_plane_state *rstate = to_rcar_vsp_plane_state(new_plane_state);
>   
>   	return __rcar_du_plane_atomic_check(plane, new_plane_state,
>   					    &rstate->format);
>   }
>   
>   static void rcar_du_vsp_plane_atomic_update(struct drm_plane *plane,
> -					struct drm_atomic_state *state)
> +					struct drm_atomic_commit *state)
>   {
>   	struct drm_plane_state *old_state = drm_atomic_get_old_plane_state(state, plane);
>   	struct drm_plane_state *new_state = drm_atomic_get_new_plane_state(state, plane);
>   	struct rcar_du_vsp_plane *rplane = to_rcar_vsp_plane(plane);
>   	struct rcar_du_crtc *crtc = to_rcar_crtc(old_state->crtc);
> diff --git a/drivers/gpu/drm/renesas/rcar-du/rcar_lvds.c b/drivers/gpu/drm/renesas/rcar-du/rcar_lvds.c
> index 227818e37390ffa6dae12156b3faf8c42fd9e106..154410745a74b82b4371234e29af930e24ce30f1 100644
> --- a/drivers/gpu/drm/renesas/rcar-du/rcar_lvds.c
> +++ b/drivers/gpu/drm/renesas/rcar-du/rcar_lvds.c
> @@ -349,11 +349,11 @@ static enum rcar_lvds_mode rcar_lvds_get_lvds_mode(struct rcar_lvds *lvds,
>   
>   	return mode;
>   }
>   
>   static void rcar_lvds_enable(struct drm_bridge *bridge,
> -			     struct drm_atomic_state *state,
> +			     struct drm_atomic_commit *state,
>   			     struct drm_crtc *crtc,
>   			     struct drm_connector *connector)
>   {
>   	struct rcar_lvds *lvds = bridge_to_rcar_lvds(bridge);
>   	u32 lvdhcr;
> @@ -580,11 +580,11 @@ EXPORT_SYMBOL_GPL(rcar_lvds_pclk_disable);
>   /* -----------------------------------------------------------------------------
>    * Bridge
>    */
>   
>   static void rcar_lvds_atomic_enable(struct drm_bridge *bridge,
> -				    struct drm_atomic_state *state)
> +				    struct drm_atomic_commit *state)
>   {
>   	struct drm_connector *connector;
>   	struct drm_crtc *crtc;
>   
>   	connector = drm_atomic_get_new_connector_for_encoder(state,
> @@ -593,11 +593,11 @@ static void rcar_lvds_atomic_enable(struct drm_bridge *bridge,
>   
>   	rcar_lvds_enable(bridge, state, crtc, connector);
>   }
>   
>   static void rcar_lvds_atomic_disable(struct drm_bridge *bridge,
> -				     struct drm_atomic_state *state)
> +				     struct drm_atomic_commit *state)
>   {
>   	struct rcar_lvds *lvds = bridge_to_rcar_lvds(bridge);
>   
>   	/*
>   	 * For D3 and E3, disabling the LVDS encoder before the DU would stall
> diff --git a/drivers/gpu/drm/renesas/rcar-du/rcar_mipi_dsi.c b/drivers/gpu/drm/renesas/rcar-du/rcar_mipi_dsi.c
> index 508977b9e8926d098b8411a99bb8ff71dbbce77c..aaafee1c060bce6adb4de063a9582d1e62faa4ed 100644
> --- a/drivers/gpu/drm/renesas/rcar-du/rcar_mipi_dsi.c
> +++ b/drivers/gpu/drm/renesas/rcar-du/rcar_mipi_dsi.c
> @@ -844,27 +844,27 @@ static int rcar_mipi_dsi_attach(struct drm_bridge *bridge,
>   	return drm_bridge_attach(encoder, dsi->next_bridge, bridge,
>   				 flags);
>   }
>   
>   static void rcar_mipi_dsi_atomic_enable(struct drm_bridge *bridge,
> -					struct drm_atomic_state *state)
> +					struct drm_atomic_commit *state)
>   {
>   	struct rcar_mipi_dsi *dsi = bridge_to_rcar_mipi_dsi(bridge);
>   
>   	rcar_mipi_dsi_start_video(dsi);
>   }
>   
>   static void rcar_mipi_dsi_atomic_disable(struct drm_bridge *bridge,
> -					 struct drm_atomic_state *state)
> +					 struct drm_atomic_commit *state)
>   {
>   	struct rcar_mipi_dsi *dsi = bridge_to_rcar_mipi_dsi(bridge);
>   
>   	rcar_mipi_dsi_stop_video(dsi);
>   }
>   
>   void rcar_mipi_dsi_pclk_enable(struct drm_bridge *bridge,
> -			       struct drm_atomic_state *state)
> +			       struct drm_atomic_commit *state)
>   {
>   	struct rcar_mipi_dsi *dsi = bridge_to_rcar_mipi_dsi(bridge);
>   	const struct drm_display_mode *mode;
>   	struct drm_connector *connector;
>   	struct drm_crtc *crtc;
> diff --git a/drivers/gpu/drm/renesas/rcar-du/rcar_mipi_dsi.h b/drivers/gpu/drm/renesas/rcar-du/rcar_mipi_dsi.h
> index 528a196e6eddb97f65971b9a9add7fd96dbe237c..cfb5d70a6b1f7d3e6994d55fc2614daf81c21680 100644
> --- a/drivers/gpu/drm/renesas/rcar-du/rcar_mipi_dsi.h
> +++ b/drivers/gpu/drm/renesas/rcar-du/rcar_mipi_dsi.h
> @@ -8,20 +8,20 @@
>    */
>   
>   #ifndef __RCAR_MIPI_DSI_H__
>   #define __RCAR_MIPI_DSI_H__
>   
> -struct drm_atomic_state;
> +struct drm_atomic_commit;
>   struct drm_bridge;
>   
>   #if IS_ENABLED(CONFIG_DRM_RCAR_MIPI_DSI)
>   void rcar_mipi_dsi_pclk_enable(struct drm_bridge *bridge,
> -			       struct drm_atomic_state *state);
> +			       struct drm_atomic_commit *state);
>   void rcar_mipi_dsi_pclk_disable(struct drm_bridge *bridge);
>   #else
>   static inline void rcar_mipi_dsi_pclk_enable(struct drm_bridge *bridge,
> -					     struct drm_atomic_state *state)
> +					     struct drm_atomic_commit *state)
>   {
>   }
>   
>   static inline void rcar_mipi_dsi_pclk_disable(struct drm_bridge *bridge)
>   {
> diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_crtc.c b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_crtc.c
> index 18e2b981b691fc683b503c5c8116d04aec91902a..26b95153ce8818e0dc90ee09e22a50b72ffe0475 100644
> --- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_crtc.c
> +++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_crtc.c
> @@ -247,21 +247,21 @@ static void rzg2l_du_crtc_stop(struct rzg2l_du_crtc *rcrtc)
>   /* -----------------------------------------------------------------------------
>    * CRTC Functions
>    */
>   
>   static void rzg2l_du_crtc_atomic_enable(struct drm_crtc *crtc,
> -					struct drm_atomic_state *state)
> +					struct drm_atomic_commit *state)
>   {
>   	struct rzg2l_du_crtc *rcrtc = to_rzg2l_crtc(crtc);
>   
>   	rzg2l_du_crtc_get(rcrtc);
>   
>   	rzg2l_du_crtc_start(rcrtc);
>   }
>   
>   static void rzg2l_du_crtc_atomic_disable(struct drm_crtc *crtc,
> -					 struct drm_atomic_state *state)
> +					 struct drm_atomic_commit *state)
>   {
>   	struct rzg2l_du_crtc *rcrtc = to_rzg2l_crtc(crtc);
>   
>   	rzg2l_du_crtc_stop(rcrtc);
>   	rzg2l_du_crtc_put(rcrtc);
> @@ -273,11 +273,11 @@ static void rzg2l_du_crtc_atomic_disable(struct drm_crtc *crtc,
>   	}
>   	spin_unlock_irq(&crtc->dev->event_lock);
>   }
>   
>   static void rzg2l_du_crtc_atomic_flush(struct drm_crtc *crtc,
> -				       struct drm_atomic_state *state)
> +				       struct drm_atomic_commit *state)
>   {
>   	struct rzg2l_du_crtc *rcrtc = to_rzg2l_crtc(crtc);
>   	struct drm_device *dev = rcrtc->crtc.dev;
>   	unsigned long flags;
>   
> diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_vsp.c b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_vsp.c
> index bd486377f037edcb042df84d96989def07103d0e..c3bf7c3da7bcd69c04bdd3f70066ba6cb4247963 100644
> --- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_vsp.c
> +++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_vsp.c
> @@ -210,21 +210,21 @@ static int __rzg2l_du_vsp_plane_atomic_check(struct drm_plane *plane,
>   
>   	return 0;
>   }
>   
>   static int rzg2l_du_vsp_plane_atomic_check(struct drm_plane *plane,
> -					   struct drm_atomic_state *state)
> +					   struct drm_atomic_commit *state)
>   {
>   	struct drm_plane_state *new_plane_state = drm_atomic_get_new_plane_state(state,
>   										 plane);
>   	struct rzg2l_du_vsp_plane_state *rstate = to_rzg2l_vsp_plane_state(new_plane_state);
>   
>   	return __rzg2l_du_vsp_plane_atomic_check(plane, new_plane_state, &rstate->format);
>   }
>   
>   static void rzg2l_du_vsp_plane_atomic_update(struct drm_plane *plane,
> -					     struct drm_atomic_state *state)
> +					     struct drm_atomic_commit *state)
>   {
>   	struct drm_plane_state *old_state = drm_atomic_get_old_plane_state(state, plane);
>   	struct drm_plane_state *new_state = drm_atomic_get_new_plane_state(state, plane);
>   	struct rzg2l_du_vsp_plane *rplane = to_rzg2l_vsp_plane(plane);
>   	struct rzg2l_du_crtc *crtc = to_rzg2l_crtc(old_state->crtc);
> diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c b/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
> index a87a301326c7aa4396dfb8551a226960b62417d9..e5402cb430faae9a865ac808480df2d82fb35f6f 100644
> --- a/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
> +++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
> @@ -1017,11 +1017,11 @@ static int rzg2l_mipi_dsi_attach(struct drm_bridge *bridge,
>   	return drm_bridge_attach(encoder, dsi->next_bridge, bridge,
>   				 flags);
>   }
>   
>   static void rzg2l_mipi_dsi_atomic_pre_enable(struct drm_bridge *bridge,
> -					     struct drm_atomic_state *state)
> +					     struct drm_atomic_commit *state)
>   {
>   	struct rzg2l_mipi_dsi *dsi = bridge_to_rzg2l_mipi_dsi(bridge);
>   	const struct drm_display_mode *mode;
>   	struct drm_connector *connector;
>   	struct drm_crtc *crtc;
> @@ -1037,11 +1037,11 @@ static void rzg2l_mipi_dsi_atomic_pre_enable(struct drm_bridge *bridge,
>   
>   	rzg2l_mipi_dsi_set_display_timing(dsi, mode);
>   }
>   
>   static void rzg2l_mipi_dsi_atomic_enable(struct drm_bridge *bridge,
> -					 struct drm_atomic_state *state)
> +					 struct drm_atomic_commit *state)
>   {
>   	struct rzg2l_mipi_dsi *dsi = bridge_to_rzg2l_mipi_dsi(bridge);
>   	int ret;
>   
>   	ret = rzg2l_mipi_dsi_start_hs_clock(dsi);
> @@ -1059,20 +1059,20 @@ static void rzg2l_mipi_dsi_atomic_enable(struct drm_bridge *bridge,
>   err_stop:
>   	rzg2l_mipi_dsi_stop(dsi);
>   }
>   
>   static void rzg2l_mipi_dsi_atomic_disable(struct drm_bridge *bridge,
> -					  struct drm_atomic_state *state)
> +					  struct drm_atomic_commit *state)
>   {
>   	struct rzg2l_mipi_dsi *dsi = bridge_to_rzg2l_mipi_dsi(bridge);
>   
>   	rzg2l_mipi_dsi_stop_video(dsi);
>   	rzg2l_mipi_dsi_stop_hs_clock(dsi);
>   }
>   
>   static void rzg2l_mipi_dsi_atomic_post_disable(struct drm_bridge *bridge,
> -					       struct drm_atomic_state *state)
> +					       struct drm_atomic_commit *state)
>   {
>   	struct rzg2l_mipi_dsi *dsi = bridge_to_rzg2l_mipi_dsi(bridge);
>   
>   	rzg2l_mipi_dsi_stop(dsi);
>   }
> diff --git a/drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.c b/drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.c
> index 5f460b38596ce0ead1fe5fb2a7287161a397b4ed..a799069e2f63d9fbc558680a258453fac38dfede 100644
> --- a/drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.c
> +++ b/drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.c
> @@ -196,11 +196,11 @@ static inline struct shmob_drm_crtc *to_shmob_crtc(struct drm_crtc *crtc)
>   {
>   	return container_of(crtc, struct shmob_drm_crtc, base);
>   }
>   
>   static void shmob_drm_crtc_atomic_enable(struct drm_crtc *crtc,
> -					 struct drm_atomic_state *state)
> +					 struct drm_atomic_commit *state)
>   {
>   	struct shmob_drm_crtc *scrtc = to_shmob_crtc(crtc);
>   	struct shmob_drm_device *sdev = to_shmob_device(crtc->dev);
>   	unsigned int clk_div = sdev->config.clk_div;
>   	struct device *dev = sdev->dev;
> @@ -254,11 +254,11 @@ static void shmob_drm_crtc_atomic_enable(struct drm_crtc *crtc,
>   	/* Turn vertical blank interrupt reporting back on. */
>   	drm_crtc_vblank_on(crtc);
>   }
>   
>   static void shmob_drm_crtc_atomic_disable(struct drm_crtc *crtc,
> -					  struct drm_atomic_state *state)
> +					  struct drm_atomic_commit *state)
>   {
>   	struct shmob_drm_crtc *scrtc = to_shmob_crtc(crtc);
>   	struct shmob_drm_device *sdev = to_shmob_device(crtc->dev);
>   
>   	/*
> @@ -277,11 +277,11 @@ static void shmob_drm_crtc_atomic_disable(struct drm_crtc *crtc,
>   
>   	pm_runtime_put(sdev->dev);
>   }
>   
>   static void shmob_drm_crtc_atomic_flush(struct drm_crtc *crtc,
> -					struct drm_atomic_state *state)
> +					struct drm_atomic_commit *state)
>   {
>   	struct drm_pending_vblank_event *event;
>   	struct drm_device *dev = crtc->dev;
>   	unsigned long flags;
>   
> diff --git a/drivers/gpu/drm/renesas/shmobile/shmob_drm_plane.c b/drivers/gpu/drm/renesas/shmobile/shmob_drm_plane.c
> index b61fda52d17a471dca4cbb7df1f1e769bf8cc052..148de34af78528cbc58e606aad85f35d2752a52f 100644
> --- a/drivers/gpu/drm/renesas/shmobile/shmob_drm_plane.c
> +++ b/drivers/gpu/drm/renesas/shmobile/shmob_drm_plane.c
> @@ -141,11 +141,11 @@ static void shmob_drm_overlay_plane_setup(struct shmob_drm_plane *splane,
>   	plane_reg_dump(sdev, splane, LDBnBSAYR);
>   	plane_reg_dump(sdev, splane, LDBnBSACR);
>   }
>   
>   static int shmob_drm_plane_atomic_check(struct drm_plane *plane,
> -					struct drm_atomic_state *state)
> +					struct drm_atomic_commit *state)
>   {
>   	struct drm_plane_state *new_plane_state = drm_atomic_get_new_plane_state(state, plane);
>   	struct shmob_drm_plane_state *sstate = to_shmob_plane_state(new_plane_state);
>   	struct drm_crtc_state *crtc_state;
>   	bool is_primary = plane->type == DRM_PLANE_TYPE_PRIMARY;
> @@ -190,11 +190,11 @@ static int shmob_drm_plane_atomic_check(struct drm_plane *plane,
>   
>   	return 0;
>   }
>   
>   static void shmob_drm_plane_atomic_update(struct drm_plane *plane,
> -					  struct drm_atomic_state *state)
> +					  struct drm_atomic_commit *state)
>   {
>   	struct drm_plane_state *new_plane_state = drm_atomic_get_new_plane_state(state, plane);
>   	struct shmob_drm_plane *splane = to_shmob_plane(plane);
>   
>   	if (!new_plane_state->visible)
> @@ -205,11 +205,11 @@ static void shmob_drm_plane_atomic_update(struct drm_plane *plane,
>   	else
>   		shmob_drm_overlay_plane_setup(splane, new_plane_state);
>   }
>   
>   static void shmob_drm_plane_atomic_disable(struct drm_plane *plane,
> -					   struct drm_atomic_state *state)
> +					   struct drm_atomic_commit *state)
>   {
>   	struct drm_plane_state *old_state = drm_atomic_get_old_plane_state(state, plane);
>   	struct shmob_drm_device *sdev = to_shmob_device(plane->dev);
>   	struct shmob_drm_plane *splane = to_shmob_plane(plane);
>   
> diff --git a/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c b/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
> index 96bd3dd239d251af3d5a7d0fbd4dd74942d44f2d..75fb3863b8950c353fabb6ea97003bb14138685b 100644
> --- a/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
> +++ b/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
> @@ -199,11 +199,11 @@ static void rockchip_dp_drm_encoder_mode_set(struct drm_encoder *encoder,
>   	/* do nothing */
>   }
>   
>   static
>   struct drm_crtc *rockchip_dp_drm_get_new_crtc(struct drm_encoder *encoder,
> -					      struct drm_atomic_state *state)
> +					      struct drm_atomic_commit *state)
>   {
>   	struct drm_connector *connector;
>   	struct drm_connector_state *conn_state;
>   
>   	connector = drm_atomic_get_new_connector_for_encoder(state, encoder);
> @@ -216,11 +216,11 @@ struct drm_crtc *rockchip_dp_drm_get_new_crtc(struct drm_encoder *encoder,
>   
>   	return conn_state->crtc;
>   }
>   
>   static void rockchip_dp_drm_encoder_enable(struct drm_encoder *encoder,
> -					   struct drm_atomic_state *state)
> +					   struct drm_atomic_commit *state)
>   {
>   	struct rockchip_dp_device *dp = encoder_to_dp(encoder);
>   	struct drm_crtc *crtc;
>   	struct drm_crtc_state *old_crtc_state;
>   	struct of_endpoint endpoint;
> @@ -270,11 +270,11 @@ static void rockchip_dp_drm_encoder_enable(struct drm_encoder *encoder,
>   
>   	clk_disable_unprepare(dp->grfclk);
>   }
>   
>   static void rockchip_dp_drm_encoder_disable(struct drm_encoder *encoder,
> -					    struct drm_atomic_state *state)
> +					    struct drm_atomic_commit *state)
>   {
>   	struct rockchip_dp_device *dp = encoder_to_dp(encoder);
>   	struct drm_crtc *crtc;
>   	struct drm_crtc_state *new_crtc_state = NULL;
>   	int ret;
> diff --git a/drivers/gpu/drm/rockchip/cdn-dp-core.c b/drivers/gpu/drm/rockchip/cdn-dp-core.c
> index 177e30445ee83e7d5098c72b772c95f1c70ec3c4..892fbea9ae9ccc59746568cc84d6034db161d416 100644
> --- a/drivers/gpu/drm/rockchip/cdn-dp-core.c
> +++ b/drivers/gpu/drm/rockchip/cdn-dp-core.c
> @@ -561,11 +561,11 @@ static void cdn_dp_display_info_update(struct cdn_dp_device *dp,
>   		video->color_depth = 8;
>   		break;
>   	}
>   }
>   
> -static void cdn_dp_bridge_atomic_enable(struct drm_bridge *bridge, struct drm_atomic_state *state)
> +static void cdn_dp_bridge_atomic_enable(struct drm_bridge *bridge, struct drm_atomic_commit *state)
>   {
>   	struct cdn_dp_device *dp = bridge_to_dp(bridge);
>   	struct drm_connector *connector;
>   	int ret, val;
>   
> @@ -628,11 +628,11 @@ static void cdn_dp_bridge_atomic_enable(struct drm_bridge *bridge, struct drm_at
>   
>   out:
>   	mutex_unlock(&dp->lock);
>   }
>   
> -static void cdn_dp_bridge_atomic_disable(struct drm_bridge *bridge, struct drm_atomic_state *state)
> +static void cdn_dp_bridge_atomic_disable(struct drm_bridge *bridge, struct drm_atomic_commit *state)
>   {
>   	struct cdn_dp_device *dp = bridge_to_dp(bridge);
>   	int ret;
>   
>   	mutex_lock(&dp->lock);
> diff --git a/drivers/gpu/drm/rockchip/dw-mipi-dsi2-rockchip.c b/drivers/gpu/drm/rockchip/dw-mipi-dsi2-rockchip.c
> index 0aea764e29b2c38d9e82a3bde0cb6fe3428dcc55..d2e76d36d7247c3b3132769435a283d98d239f9e 100644
> --- a/drivers/gpu/drm/rockchip/dw-mipi-dsi2-rockchip.c
> +++ b/drivers/gpu/drm/rockchip/dw-mipi-dsi2-rockchip.c
> @@ -210,11 +210,11 @@ static const struct dw_mipi_dsi2_phy_ops dw_mipi_dsi2_rockchip_phy_ops = {
>   	.get_lane_mbps = dw_mipi_dsi2_get_lane_mbps,
>   	.get_timing = dw_mipi_dsi2_phy_get_timing,
>   };
>   
>   static void dw_mipi_dsi2_encoder_atomic_enable(struct drm_encoder *encoder,
> -					       struct drm_atomic_state *state)
> +					       struct drm_atomic_commit *state)
>   {
>   	struct dw_mipi_dsi2_rockchip *dsi2 = to_dsi2(encoder);
>   	u32 color_depth;
>   
>   	switch (dsi2->format) {
> diff --git a/drivers/gpu/drm/rockchip/dw_dp-rockchip.c b/drivers/gpu/drm/rockchip/dw_dp-rockchip.c
> index dac3d202971edaecfd0db0688047b7a5b6f2d4ee..970f5f7af0074077f74fac49799933eb57787df5 100644
> --- a/drivers/gpu/drm/rockchip/dw_dp-rockchip.c
> +++ b/drivers/gpu/drm/rockchip/dw_dp-rockchip.c
> @@ -33,11 +33,11 @@ struct rockchip_dw_dp {
>   static int dw_dp_encoder_atomic_check(struct drm_encoder *encoder,
>   				      struct drm_crtc_state *crtc_state,
>   				      struct drm_connector_state *conn_state)
>   {
>   	struct rockchip_crtc_state *s = to_rockchip_crtc_state(crtc_state);
> -	struct drm_atomic_state *state = conn_state->state;
> +	struct drm_atomic_commit *state = conn_state->state;
>   	struct drm_display_info *di = &conn_state->connector->display_info;
>   	struct drm_bridge *bridge  = drm_bridge_chain_get_first_bridge(encoder);
>   	struct drm_bridge_state *bridge_state = drm_atomic_get_new_bridge_state(state, bridge);
>   	u32 bus_format = bridge_state->input_bus_cfg.format;
>   
> diff --git a/drivers/gpu/drm/rockchip/rk3066_hdmi.c b/drivers/gpu/drm/rockchip/rk3066_hdmi.c
> index 9066ee2d1dff4b97c28fcd3d56e146f72706db72..54a0f124c7e10a780b2e18320be1c921c5f17229 100644
> --- a/drivers/gpu/drm/rockchip/rk3066_hdmi.c
> +++ b/drivers/gpu/drm/rockchip/rk3066_hdmi.c
> @@ -311,11 +311,11 @@ static void rk3066_hdmi_config_phy(struct rk3066_hdmi *hdmi)
>   		rk3066_hdmi_phy_write(hdmi, 0x178, 0x00);
>   	}
>   }
>   
>   static int rk3066_hdmi_setup(struct rk3066_hdmi *hdmi,
> -			     struct drm_atomic_state *state)
> +			     struct drm_atomic_commit *state)
>   {
>   	struct drm_bridge *bridge = &hdmi->bridge;
>   	struct drm_connector *connector;
>   	struct drm_display_info *display;
>   	struct drm_display_mode *mode;
> @@ -392,11 +392,11 @@ static int rk3066_hdmi_setup(struct rk3066_hdmi *hdmi,
>   		  HDMI_VIDEO_AUDIO_DISABLE_MASK, HDMI_AUDIO_DISABLE);
>   	return 0;
>   }
>   
>   static void rk3066_hdmi_bridge_atomic_enable(struct drm_bridge *bridge,
> -					     struct drm_atomic_state *state)
> +					     struct drm_atomic_commit *state)
>   {
>   	struct rk3066_hdmi *hdmi = bridge_to_rk3066_hdmi(bridge);
>   	struct drm_connector_state *conn_state;
>   	struct drm_crtc_state *crtc_state;
>   	int mux, val;
> @@ -422,11 +422,11 @@ static void rk3066_hdmi_bridge_atomic_enable(struct drm_bridge *bridge,
>   
>   	rk3066_hdmi_setup(hdmi, state);
>   }
>   
>   static void rk3066_hdmi_bridge_atomic_disable(struct drm_bridge *bridge,
> -					      struct drm_atomic_state *state)
> +					      struct drm_atomic_commit *state)
>   {
>   	struct rk3066_hdmi *hdmi = bridge_to_rk3066_hdmi(bridge);
>   
>   	DRM_DEV_DEBUG(hdmi->dev, "hdmi encoder disable\n");
>   
> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> index 572f4adfd111b45039a57c8dee63ea5f91b3487a..0090d8ff0c79e74a3dd30a45b8a47f70a1c15608 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> @@ -726,11 +726,11 @@ static void rockchip_drm_set_win_enabled(struct drm_crtc *crtc, bool enabled)
>   
>           spin_unlock(&vop->reg_lock);
>   }
>   
>   static void vop_crtc_atomic_disable(struct drm_crtc *crtc,
> -				    struct drm_atomic_state *state)
> +				    struct drm_atomic_commit *state)
>   {
>   	struct vop *vop = to_vop(crtc);
>   
>   	WARN_ON(vop->event);
>   
> @@ -807,11 +807,11 @@ static bool rockchip_mod_supported(struct drm_plane *plane,
>   
>   	return vop_convert_afbc_format(format) >= 0;
>   }
>   
>   static int vop_plane_atomic_check(struct drm_plane *plane,
> -			   struct drm_atomic_state *state)
> +			   struct drm_atomic_commit *state)
>   {
>   	struct drm_plane_state *new_plane_state = drm_atomic_get_new_plane_state(state,
>   										 plane);
>   	struct drm_crtc *crtc = new_plane_state->crtc;
>   	struct drm_crtc_state *crtc_state;
> @@ -887,11 +887,11 @@ static int vop_plane_atomic_check(struct drm_plane *plane,
>   
>   	return 0;
>   }
>   
>   static void vop_plane_atomic_disable(struct drm_plane *plane,
> -				     struct drm_atomic_state *state)
> +				     struct drm_atomic_commit *state)
>   {
>   	struct drm_plane_state *old_state = drm_atomic_get_old_plane_state(state,
>   									   plane);
>   	struct vop_win *vop_win = to_vop_win(plane);
>   	struct vop *vop = to_vop(old_state->crtc);
> @@ -905,11 +905,11 @@ static void vop_plane_atomic_disable(struct drm_plane *plane,
>   
>   	spin_unlock(&vop->reg_lock);
>   }
>   
>   static void vop_plane_atomic_update(struct drm_plane *plane,
> -		struct drm_atomic_state *state)
> +		struct drm_atomic_commit *state)
>   {
>   	struct drm_plane_state *new_state = drm_atomic_get_new_plane_state(state,
>   									   plane);
>   	struct drm_crtc *crtc = new_state->crtc;
>   	struct vop_win *vop_win = to_vop_win(plane);
> @@ -1069,11 +1069,11 @@ static void vop_plane_atomic_update(struct drm_plane *plane,
>   	vop->win_enabled |= BIT(win_index);
>   	spin_unlock(&vop->reg_lock);
>   }
>   
>   static int vop_plane_atomic_async_check(struct drm_plane *plane,
> -					struct drm_atomic_state *state, bool flip)
> +					struct drm_atomic_commit *state, bool flip)
>   {
>   	struct drm_plane_state *new_plane_state = drm_atomic_get_new_plane_state(state,
>   										 plane);
>   	struct vop_win *vop_win = to_vop_win(plane);
>   	const struct vop_win_data *win = vop_win->data;
> @@ -1103,11 +1103,11 @@ static int vop_plane_atomic_async_check(struct drm_plane *plane,
>   						   min_scale, max_scale,
>   						   true, true);
>   }
>   
>   static void vop_plane_atomic_async_update(struct drm_plane *plane,
> -					  struct drm_atomic_state *state)
> +					  struct drm_atomic_commit *state)
>   {
>   	struct drm_plane_state *new_state = drm_atomic_get_new_plane_state(state,
>   									   plane);
>   	struct vop *vop = to_vop(plane->state->crtc);
>   	struct drm_framebuffer *old_fb = plane->state->fb;
> @@ -1340,11 +1340,11 @@ static void vop_crtc_gamma_set(struct vop *vop, struct drm_crtc *crtc,
>   		spin_unlock(&vop->reg_lock);
>   	}
>   }
>   
>   static void vop_crtc_atomic_begin(struct drm_crtc *crtc,
> -				  struct drm_atomic_state *state)
> +				  struct drm_atomic_commit *state)
>   {
>   	struct drm_crtc_state *crtc_state = drm_atomic_get_new_crtc_state(state,
>   									  crtc);
>   	struct drm_crtc_state *old_crtc_state = drm_atomic_get_old_crtc_state(state,
>   									      crtc);
> @@ -1358,11 +1358,11 @@ static void vop_crtc_atomic_begin(struct drm_crtc *crtc,
>   	    !crtc_state->active_changed)
>   		vop_crtc_gamma_set(vop, crtc, old_crtc_state);
>   }
>   
>   static void vop_crtc_atomic_enable(struct drm_crtc *crtc,
> -				   struct drm_atomic_state *state)
> +				   struct drm_atomic_commit *state)
>   {
>   	struct drm_crtc_state *old_state = drm_atomic_get_old_crtc_state(state,
>   									 crtc);
>   	struct vop *vop = to_vop(crtc);
>   	const struct vop_data *vop_data = vop->data;
> @@ -1513,11 +1513,11 @@ static void vop_wait_for_irq_handler(struct vop *vop)
>   
>   	synchronize_irq(vop->irq);
>   }
>   
>   static int vop_crtc_atomic_check(struct drm_crtc *crtc,
> -				 struct drm_atomic_state *state)
> +				 struct drm_atomic_commit *state)
>   {
>   	struct drm_crtc_state *crtc_state = drm_atomic_get_new_crtc_state(state,
>   									  crtc);
>   	struct vop *vop = to_vop(crtc);
>   	struct drm_plane *plane;
> @@ -1560,15 +1560,15 @@ static int vop_crtc_atomic_check(struct drm_crtc *crtc,
>   
>   	return 0;
>   }
>   
>   static void vop_crtc_atomic_flush(struct drm_crtc *crtc,
> -				  struct drm_atomic_state *state)
> +				  struct drm_atomic_commit *state)
>   {
>   	struct drm_crtc_state *old_crtc_state = drm_atomic_get_old_crtc_state(state,
>   									      crtc);
> -	struct drm_atomic_state *old_state = old_crtc_state->state;
> +	struct drm_atomic_commit *old_state = old_crtc_state->state;
>   	struct drm_plane_state *old_plane_state, *new_plane_state;
>   	struct vop *vop = to_vop(crtc);
>   	struct drm_plane *plane;
>   	struct rockchip_crtc_state *s;
>   	int i;
> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
> index 843c7ef979b21893d28f14e2e01562838573bb14..a160077a507f2346eb0681bd19dbfcf0f49c7dac 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
> @@ -921,11 +921,11 @@ static bool vop2_gamma_lut_in_use(struct vop2 *vop2, struct vop2_video_port *vp)
>   
>   	return gamma_en_vp_id != nr_vps && gamma_en_vp_id != vp->id;
>   }
>   
>   static void vop2_crtc_atomic_disable(struct drm_crtc *crtc,
> -				     struct drm_atomic_state *state)
> +				     struct drm_atomic_commit *state)
>   {
>   	struct vop2_video_port *vp = to_vop2_video_port(crtc);
>   	struct vop2 *vop2 = vp->vop2;
>   	struct drm_crtc_state *old_crtc_state;
>   	int ret;
> @@ -977,11 +977,11 @@ static void vop2_crtc_atomic_disable(struct drm_crtc *crtc,
>   		crtc->state->event = NULL;
>   	}
>   }
>   
>   static int vop2_plane_atomic_check(struct drm_plane *plane,
> -				   struct drm_atomic_state *astate)
> +				   struct drm_atomic_commit *astate)
>   {
>   	struct drm_plane_state *pstate = drm_atomic_get_new_plane_state(astate, plane);
>   	struct drm_framebuffer *fb = pstate->fb;
>   	struct drm_crtc *crtc = pstate->crtc;
>   	struct drm_crtc_state *cstate;
> @@ -1089,11 +1089,11 @@ static int vop2_plane_atomic_check(struct drm_plane *plane,
>   
>   	return 0;
>   }
>   
>   static void vop2_plane_atomic_disable(struct drm_plane *plane,
> -				      struct drm_atomic_state *state)
> +				      struct drm_atomic_commit *state)
>   {
>   	struct drm_plane_state *old_pstate = NULL;
>   	struct vop2_win *win = to_vop2_win(plane);
>   	struct vop2 *vop2 = win->vop2;
>   
> @@ -1157,11 +1157,11 @@ static void vop2_plane_setup_color_key(struct drm_plane *plane, u32 color_key)
>   	vop2_win_write(win, VOP2_WIN_COLOR_KEY_EN, color_key_en);
>   	vop2_win_write(win, VOP2_WIN_COLOR_KEY, (r << 20) | (g << 10) | b);
>   }
>   
>   static void vop2_plane_atomic_update(struct drm_plane *plane,
> -				     struct drm_atomic_state *state)
> +				     struct drm_atomic_commit *state)
>   {
>   	struct drm_plane_state *pstate = plane->state;
>   	struct drm_crtc *crtc = pstate->crtc;
>   	struct vop2_win *win = to_vop2_win(plane);
>   	struct vop2_video_port *vp = to_vop2_video_port(crtc);
> @@ -1620,11 +1620,11 @@ static int us_to_vertical_line(struct drm_display_mode *mode, int us)
>   {
>   	return us * mode->clock / mode->htotal / 1000;
>   }
>   
>   static void vop2_crtc_atomic_enable(struct drm_crtc *crtc,
> -				    struct drm_atomic_state *state)
> +				    struct drm_atomic_commit *state)
>   {
>   	struct vop2_video_port *vp = to_vop2_video_port(crtc);
>   	struct vop2 *vop2 = vp->vop2;
>   	const struct vop2_data *vop2_data = vop2->data;
>   	const struct vop2_video_port_data *vp_data = &vop2_data->vp[vp->id];
> @@ -1812,11 +1812,11 @@ static void vop2_crtc_atomic_enable(struct drm_crtc *crtc,
>   	vop2_unlock(vop2);
>   }
>   
>   static int vop2_crtc_atomic_check_gamma(struct vop2_video_port *vp,
>   					struct drm_crtc *crtc,
> -					struct drm_atomic_state *state,
> +					struct drm_atomic_commit *state,
>   					struct drm_crtc_state *crtc_state)
>   {
>   	struct vop2 *vop2 = vp->vop2;
>   	unsigned int len;
>   
> @@ -1838,11 +1838,11 @@ static int vop2_crtc_atomic_check_gamma(struct vop2_video_port *vp,
>   
>   	return 0;
>   }
>   
>   static int vop2_crtc_atomic_check(struct drm_crtc *crtc,
> -				  struct drm_atomic_state *state)
> +				  struct drm_atomic_commit *state)
>   {
>   	struct vop2_video_port *vp = to_vop2_video_port(crtc);
>   	struct drm_plane *plane;
>   	int nplanes = 0;
>   	struct drm_crtc_state *crtc_state = drm_atomic_get_new_crtc_state(state, crtc);
> @@ -1860,20 +1860,20 @@ static int vop2_crtc_atomic_check(struct drm_crtc *crtc,
>   
>   	return 0;
>   }
>   
>   static void vop2_crtc_atomic_begin(struct drm_crtc *crtc,
> -				   struct drm_atomic_state *state)
> +				   struct drm_atomic_commit *state)
>   {
>   	struct vop2_video_port *vp = to_vop2_video_port(crtc);
>   	struct vop2 *vop2 = vp->vop2;
>   
>   	vop2->ops->setup_overlay(vp);
>   }
>   
>   static void vop2_crtc_atomic_flush(struct drm_crtc *crtc,
> -				   struct drm_atomic_state *state)
> +				   struct drm_atomic_commit *state)
>   {
>   	struct drm_crtc_state *crtc_state = drm_atomic_get_new_crtc_state(state, crtc);
>   	struct vop2_video_port *vp = to_vop2_video_port(crtc);
>   	struct vop2 *vop2 = vp->vop2;
>   
> diff --git a/drivers/gpu/drm/sitronix/st7571.c b/drivers/gpu/drm/sitronix/st7571.c
> index 5fd575d972a2e3b6654af7ed0a4ab5c4323e7a33..20954c33eca93c0aa41ec8f0741a9b52948d6e04 100644
> --- a/drivers/gpu/drm/sitronix/st7571.c
> +++ b/drivers/gpu/drm/sitronix/st7571.c
> @@ -322,11 +322,11 @@ static const u64 st7571_primary_plane_fmtmods[] = {
>   	DRM_FORMAT_MOD_LINEAR,
>   	DRM_FORMAT_MOD_INVALID
>   };
>   
>   static int st7571_primary_plane_helper_atomic_check(struct drm_plane *plane,
> -						    struct drm_atomic_state *state)
> +						    struct drm_atomic_commit *state)
>   {
>   	struct drm_plane_state *new_plane_state = drm_atomic_get_new_plane_state(state, plane);
>   	struct drm_crtc *new_crtc = new_plane_state->crtc;
>   	struct drm_crtc_state *new_crtc_state = NULL;
>   
> @@ -338,11 +338,11 @@ static int st7571_primary_plane_helper_atomic_check(struct drm_plane *plane,
>   						   DRM_PLANE_NO_SCALING,
>   						   false, false);
>   }
>   
>   static void st7571_primary_plane_helper_atomic_update(struct drm_plane *plane,
> -						      struct drm_atomic_state *state)
> +						      struct drm_atomic_commit *state)
>   {
>   	struct drm_plane_state *old_plane_state = drm_atomic_get_old_plane_state(state, plane);
>   	struct drm_plane_state *plane_state = drm_atomic_get_new_plane_state(state, plane);
>   	struct drm_shadow_plane_state *shadow_plane_state = to_drm_shadow_plane_state(plane_state);
>   	struct drm_framebuffer *fb = plane_state->fb;
> @@ -377,11 +377,11 @@ static void st7571_primary_plane_helper_atomic_update(struct drm_plane *plane,
>   out_drm_gem_fb_end_cpu_access:
>   	drm_gem_fb_end_cpu_access(fb, DMA_FROM_DEVICE);
>   }
>   
>   static void st7571_primary_plane_helper_atomic_disable(struct drm_plane *plane,
> -						       struct drm_atomic_state *state)
> +						       struct drm_atomic_commit *state)
>   {
>   	struct drm_device *drm = plane->dev;
>   	struct st7571_device *st7571 = drm_to_st7571(plane->dev);
>   	int idx;
>   
> @@ -435,11 +435,11 @@ static const struct drm_crtc_funcs st7571_crtc_funcs = {
>   /*
>    * Encoder
>    */
>   
>   static void st7571_encoder_atomic_enable(struct drm_encoder *encoder,
> -					 struct drm_atomic_state *state)
> +					 struct drm_atomic_commit *state)
>   {
>   	struct drm_device *drm = encoder->dev;
>   	struct st7571_device *st7571 = drm_to_st7571(drm);
>   	u8 command = ST7571_DISPLAY_ON;
>   	int ret;
> @@ -450,11 +450,11 @@ static void st7571_encoder_atomic_enable(struct drm_encoder *encoder,
>   
>   	st7571_send_command_list(st7571, &command, 1);
>   }
>   
>   static void st7571_encoder_atomic_disable(struct drm_encoder *encoder,
> -					  struct drm_atomic_state *state)
> +					  struct drm_atomic_commit *state)
>   {
>   	struct drm_device *drm = encoder->dev;
>   	struct st7571_device *st7571 = drm_to_st7571(drm);
>   	u8 command = ST7571_DISPLAY_OFF;
>   
> diff --git a/drivers/gpu/drm/sitronix/st7920.c b/drivers/gpu/drm/sitronix/st7920.c
> index 18fe7a28ed07308e16d1d6c737db856e0a490236..d320391801f3f5fe40c991ba71b272d5efcb96ea 100644
> --- a/drivers/gpu/drm/sitronix/st7920.c
> +++ b/drivers/gpu/drm/sitronix/st7920.c
> @@ -336,11 +336,11 @@ static int st7920_fb_blit_rect(struct drm_framebuffer *fb,
>   
>   	return ret;
>   }
>   
>   static int st7920_primary_plane_atomic_check(struct drm_plane *plane,
> -					     struct drm_atomic_state *state)
> +					     struct drm_atomic_commit *state)
>   {
>   	struct drm_device *drm = plane->dev;
>   	struct st7920_device *st7920 = drm_to_st7920(drm);
>   	struct drm_plane_state *plane_state = drm_atomic_get_new_plane_state(state, plane);
>   	struct st7920_plane_state *st7920_state = to_st7920_plane_state(plane_state);
> @@ -385,11 +385,11 @@ static int st7920_primary_plane_atomic_check(struct drm_plane *plane,
>   
>   	return 0;
>   }
>   
>   static void st7920_primary_plane_atomic_update(struct drm_plane *plane,
> -					       struct drm_atomic_state *state)
> +					       struct drm_atomic_commit *state)
>   {
>   	struct drm_plane_state *plane_state = drm_atomic_get_new_plane_state(state, plane);
>   	struct drm_plane_state *old_plane_state = drm_atomic_get_old_plane_state(state, plane);
>   	struct drm_shadow_plane_state *shadow_plane_state = to_drm_shadow_plane_state(plane_state);
>   	struct drm_crtc_state *crtc_state = drm_atomic_get_new_crtc_state(state, plane_state->crtc);
> @@ -427,11 +427,11 @@ static void st7920_primary_plane_atomic_update(struct drm_plane *plane,
>   
>   	drm_dev_exit(idx);
>   }
>   
>   static void st7920_primary_plane_atomic_disable(struct drm_plane *plane,
> -						struct drm_atomic_state *state)
> +						struct drm_atomic_commit *state)
>   {
>   	struct drm_device *drm = plane->dev;
>   	struct st7920_device *st7920 = drm_to_st7920(drm);
>   	struct drm_plane_state *plane_state = drm_atomic_get_new_plane_state(state, plane);
>   	struct drm_crtc_state *crtc_state;
> @@ -520,11 +520,11 @@ static enum drm_mode_status st7920_crtc_mode_valid(struct drm_crtc *crtc,
>   
>   	return drm_crtc_helper_mode_valid_fixed(crtc, mode, &st7920->mode);
>   }
>   
>   static int st7920_crtc_atomic_check(struct drm_crtc *crtc,
> -				    struct drm_atomic_state *state)
> +				    struct drm_atomic_commit *state)
>   {
>   	struct drm_crtc_state *crtc_state = drm_atomic_get_new_crtc_state(state, crtc);
>   	struct st7920_crtc_state *st7920_state = to_st7920_crtc_state(crtc_state);
>   	int ret;
>   
> @@ -538,11 +538,11 @@ static int st7920_crtc_atomic_check(struct drm_crtc *crtc,
>   
>   	return 0;
>   }
>   
>   static void st7920_crtc_atomic_enable(struct drm_crtc *crtc,
> -				      struct drm_atomic_state *state)
> +				      struct drm_atomic_commit *state)
>   {
>   	struct drm_device *drm = crtc->dev;
>   	struct st7920_device *st7920 = drm_to_st7920(drm);
>   	int idx;
>   	int ret;
> @@ -558,11 +558,11 @@ static void st7920_crtc_atomic_enable(struct drm_crtc *crtc,
>   
>   	drm_dev_exit(idx);
>   }
>   
>   static void st7920_crtc_atomic_disable(struct drm_crtc *crtc,
> -				       struct drm_atomic_state *state)
> +				       struct drm_atomic_commit *state)
>   {
>   	struct spi7920_error err = {0};
>   	struct drm_device *drm = crtc->dev;
>   	struct st7920_device *st7920 = drm_to_st7920(drm);
>   	int idx;
> diff --git a/drivers/gpu/drm/solomon/ssd130x.c b/drivers/gpu/drm/solomon/ssd130x.c
> index c77455b1834dde3ef1d274c65244bf1a8219c4ac..cae92a3ae8a41d50aff91706eb54567b88d475e7 100644
> --- a/drivers/gpu/drm/solomon/ssd130x.c
> +++ b/drivers/gpu/drm/solomon/ssd130x.c
> @@ -1072,11 +1072,11 @@ static int ssd133x_fb_blit_rect(struct drm_framebuffer *fb,
>   
>   	return ret;
>   }
>   
>   static int ssd130x_primary_plane_atomic_check(struct drm_plane *plane,
> -					      struct drm_atomic_state *state)
> +					      struct drm_atomic_commit *state)
>   {
>   	struct drm_device *drm = plane->dev;
>   	struct ssd130x_device *ssd130x = drm_to_ssd130x(drm);
>   	struct drm_plane_state *plane_state = drm_atomic_get_new_plane_state(state, plane);
>   	struct ssd130x_plane_state *ssd130x_state = to_ssd130x_plane_state(plane_state);
> @@ -1121,11 +1121,11 @@ static int ssd130x_primary_plane_atomic_check(struct drm_plane *plane,
>   
>   	return 0;
>   }
>   
>   static int ssd132x_primary_plane_atomic_check(struct drm_plane *plane,
> -					      struct drm_atomic_state *state)
> +					      struct drm_atomic_commit *state)
>   {
>   	struct drm_device *drm = plane->dev;
>   	struct ssd130x_device *ssd130x = drm_to_ssd130x(drm);
>   	struct drm_plane_state *plane_state = drm_atomic_get_new_plane_state(state, plane);
>   	struct ssd130x_plane_state *ssd130x_state = to_ssd130x_plane_state(plane_state);
> @@ -1170,11 +1170,11 @@ static int ssd132x_primary_plane_atomic_check(struct drm_plane *plane,
>   
>   	return 0;
>   }
>   
>   static int ssd133x_primary_plane_atomic_check(struct drm_plane *plane,
> -					      struct drm_atomic_state *state)
> +					      struct drm_atomic_commit *state)
>   {
>   	struct drm_plane_state *plane_state = drm_atomic_get_new_plane_state(state, plane);
>   	struct drm_crtc *crtc = plane_state->crtc;
>   	struct drm_crtc_state *crtc_state = NULL;
>   	int ret;
> @@ -1193,11 +1193,11 @@ static int ssd133x_primary_plane_atomic_check(struct drm_plane *plane,
>   
>   	return 0;
>   }
>   
>   static void ssd130x_primary_plane_atomic_update(struct drm_plane *plane,
> -						struct drm_atomic_state *state)
> +						struct drm_atomic_commit *state)
>   {
>   	struct drm_plane_state *plane_state = drm_atomic_get_new_plane_state(state, plane);
>   	struct drm_plane_state *old_plane_state = drm_atomic_get_old_plane_state(state, plane);
>   	struct drm_shadow_plane_state *shadow_plane_state = to_drm_shadow_plane_state(plane_state);
>   	struct drm_crtc_state *crtc_state = drm_atomic_get_new_crtc_state(state, plane_state->crtc);
> @@ -1234,11 +1234,11 @@ static void ssd130x_primary_plane_atomic_update(struct drm_plane *plane,
>   out_drm_dev_exit:
>   	drm_dev_exit(idx);
>   }
>   
>   static void ssd132x_primary_plane_atomic_update(struct drm_plane *plane,
> -						struct drm_atomic_state *state)
> +						struct drm_atomic_commit *state)
>   {
>   	struct drm_plane_state *plane_state = drm_atomic_get_new_plane_state(state, plane);
>   	struct drm_plane_state *old_plane_state = drm_atomic_get_old_plane_state(state, plane);
>   	struct drm_shadow_plane_state *shadow_plane_state = to_drm_shadow_plane_state(plane_state);
>   	struct drm_crtc_state *crtc_state = drm_atomic_get_new_crtc_state(state, plane_state->crtc);
> @@ -1275,11 +1275,11 @@ static void ssd132x_primary_plane_atomic_update(struct drm_plane *plane,
>   out_drm_dev_exit:
>   	drm_dev_exit(idx);
>   }
>   
>   static void ssd133x_primary_plane_atomic_update(struct drm_plane *plane,
> -						struct drm_atomic_state *state)
> +						struct drm_atomic_commit *state)
>   {
>   	struct drm_plane_state *plane_state = drm_atomic_get_new_plane_state(state, plane);
>   	struct drm_plane_state *old_plane_state = drm_atomic_get_old_plane_state(state, plane);
>   	struct drm_shadow_plane_state *shadow_plane_state = to_drm_shadow_plane_state(plane_state);
>   	struct drm_crtc_state *crtc_state = drm_atomic_get_new_crtc_state(state, plane_state->crtc);
> @@ -1314,11 +1314,11 @@ static void ssd133x_primary_plane_atomic_update(struct drm_plane *plane,
>   out_drm_dev_exit:
>   	drm_dev_exit(idx);
>   }
>   
>   static void ssd130x_primary_plane_atomic_disable(struct drm_plane *plane,
> -						 struct drm_atomic_state *state)
> +						 struct drm_atomic_commit *state)
>   {
>   	struct drm_device *drm = plane->dev;
>   	struct ssd130x_device *ssd130x = drm_to_ssd130x(drm);
>   	struct drm_plane_state *plane_state = drm_atomic_get_new_plane_state(state, plane);
>   	struct drm_crtc_state *crtc_state;
> @@ -1338,11 +1338,11 @@ static void ssd130x_primary_plane_atomic_disable(struct drm_plane *plane,
>   
>   	drm_dev_exit(idx);
>   }
>   
>   static void ssd132x_primary_plane_atomic_disable(struct drm_plane *plane,
> -						 struct drm_atomic_state *state)
> +						 struct drm_atomic_commit *state)
>   {
>   	struct drm_device *drm = plane->dev;
>   	struct ssd130x_device *ssd130x = drm_to_ssd130x(drm);
>   	struct drm_plane_state *plane_state = drm_atomic_get_new_plane_state(state, plane);
>   	struct drm_crtc_state *crtc_state;
> @@ -1362,11 +1362,11 @@ static void ssd132x_primary_plane_atomic_disable(struct drm_plane *plane,
>   
>   	drm_dev_exit(idx);
>   }
>   
>   static void ssd133x_primary_plane_atomic_disable(struct drm_plane *plane,
> -						 struct drm_atomic_state *state)
> +						 struct drm_atomic_commit *state)
>   {
>   	struct drm_device *drm = plane->dev;
>   	struct ssd130x_device *ssd130x = drm_to_ssd130x(drm);
>   	struct drm_plane_state *plane_state = drm_atomic_get_new_plane_state(state, plane);
>   	struct drm_crtc_state *crtc_state;
> @@ -1474,11 +1474,11 @@ static enum drm_mode_status ssd130x_crtc_mode_valid(struct drm_crtc *crtc,
>   
>   	return drm_crtc_helper_mode_valid_fixed(crtc, mode, &ssd130x->mode);
>   }
>   
>   static int ssd130x_crtc_atomic_check(struct drm_crtc *crtc,
> -				     struct drm_atomic_state *state)
> +				     struct drm_atomic_commit *state)
>   {
>   	struct drm_device *drm = crtc->dev;
>   	struct ssd130x_device *ssd130x = drm_to_ssd130x(drm);
>   	struct drm_crtc_state *crtc_state = drm_atomic_get_new_crtc_state(state, crtc);
>   	struct ssd130x_crtc_state *ssd130x_state = to_ssd130x_crtc_state(crtc_state);
> @@ -1495,11 +1495,11 @@ static int ssd130x_crtc_atomic_check(struct drm_crtc *crtc,
>   
>   	return 0;
>   }
>   
>   static int ssd132x_crtc_atomic_check(struct drm_crtc *crtc,
> -				     struct drm_atomic_state *state)
> +				     struct drm_atomic_commit *state)
>   {
>   	struct drm_device *drm = crtc->dev;
>   	struct ssd130x_device *ssd130x = drm_to_ssd130x(drm);
>   	struct drm_crtc_state *crtc_state = drm_atomic_get_new_crtc_state(state, crtc);
>   	struct ssd130x_crtc_state *ssd130x_state = to_ssd130x_crtc_state(crtc_state);
> @@ -1516,11 +1516,11 @@ static int ssd132x_crtc_atomic_check(struct drm_crtc *crtc,
>   
>   	return 0;
>   }
>   
>   static int ssd133x_crtc_atomic_check(struct drm_crtc *crtc,
> -				     struct drm_atomic_state *state)
> +				     struct drm_atomic_commit *state)
>   {
>   	struct drm_device *drm = crtc->dev;
>   	struct ssd130x_device *ssd130x = drm_to_ssd130x(drm);
>   	struct drm_crtc_state *crtc_state = drm_atomic_get_new_crtc_state(state, crtc);
>   	struct ssd130x_crtc_state *ssd130x_state = to_ssd130x_crtc_state(crtc_state);
> @@ -1619,11 +1619,11 @@ static const struct drm_crtc_funcs ssd130x_crtc_funcs = {
>   	.atomic_duplicate_state = ssd130x_crtc_duplicate_state,
>   	.atomic_destroy_state = ssd130x_crtc_destroy_state,
>   };
>   
>   static void ssd130x_encoder_atomic_enable(struct drm_encoder *encoder,
> -					  struct drm_atomic_state *state)
> +					  struct drm_atomic_commit *state)
>   {
>   	struct drm_device *drm = encoder->dev;
>   	struct ssd130x_device *ssd130x = drm_to_ssd130x(drm);
>   	int ret;
>   
> @@ -1645,11 +1645,11 @@ static void ssd130x_encoder_atomic_enable(struct drm_encoder *encoder,
>   	ssd130x_power_off(ssd130x);
>   	return;
>   }
>   
>   static void ssd132x_encoder_atomic_enable(struct drm_encoder *encoder,
> -					  struct drm_atomic_state *state)
> +					  struct drm_atomic_commit *state)
>   {
>   	struct drm_device *drm = encoder->dev;
>   	struct ssd130x_device *ssd130x = drm_to_ssd130x(drm);
>   	int ret;
>   
> @@ -1670,11 +1670,11 @@ static void ssd132x_encoder_atomic_enable(struct drm_encoder *encoder,
>   power_off:
>   	ssd130x_power_off(ssd130x);
>   }
>   
>   static void ssd133x_encoder_atomic_enable(struct drm_encoder *encoder,
> -					  struct drm_atomic_state *state)
> +					  struct drm_atomic_commit *state)
>   {
>   	struct drm_device *drm = encoder->dev;
>   	struct ssd130x_device *ssd130x = drm_to_ssd130x(drm);
>   	int ret;
>   
> @@ -1695,11 +1695,11 @@ static void ssd133x_encoder_atomic_enable(struct drm_encoder *encoder,
>   power_off:
>   	ssd130x_power_off(ssd130x);
>   }
>   
>   static void ssd130x_encoder_atomic_disable(struct drm_encoder *encoder,
> -					   struct drm_atomic_state *state)
> +					   struct drm_atomic_commit *state)
>   {
>   	struct drm_device *drm = encoder->dev;
>   	struct ssd130x_device *ssd130x = drm_to_ssd130x(drm);
>   
>   	backlight_disable(ssd130x->bl_dev);
> diff --git a/drivers/gpu/drm/sprd/sprd_dpu.c b/drivers/gpu/drm/sprd/sprd_dpu.c
> index a3447622a33cd612e34be038e833222567bdcd2c..66990398b903794eb7407a301968be73863cd7d9 100644
> --- a/drivers/gpu/drm/sprd/sprd_dpu.c
> +++ b/drivers/gpu/drm/sprd/sprd_dpu.c
> @@ -499,11 +499,11 @@ void sprd_dpu_stop(struct sprd_dpu *dpu)
>   
>   	dpu_wait_stop_done(dpu);
>   }
>   
>   static int sprd_plane_atomic_check(struct drm_plane *plane,
> -				   struct drm_atomic_state *state)
> +				   struct drm_atomic_commit *state)
>   {
>   	struct drm_plane_state *plane_state = drm_atomic_get_new_plane_state(state,
>   									     plane);
>   	struct drm_crtc_state *crtc_state;
>   	u32 fmt;
> @@ -524,22 +524,22 @@ static int sprd_plane_atomic_check(struct drm_plane *plane,
>   						  DRM_PLANE_NO_SCALING,
>   						  true, true);
>   }
>   
>   static void sprd_plane_atomic_update(struct drm_plane *drm_plane,
> -				     struct drm_atomic_state *state)
> +				     struct drm_atomic_commit *state)
>   {
>   	struct drm_plane_state *new_state = drm_atomic_get_new_plane_state(state,
>   									   drm_plane);
>   	struct sprd_dpu *dpu = to_sprd_crtc(new_state->crtc);
>   
>   	/* start configure dpu layers */
>   	sprd_dpu_layer(dpu, new_state);
>   }
>   
>   static void sprd_plane_atomic_disable(struct drm_plane *drm_plane,
> -				      struct drm_atomic_state *state)
> +				      struct drm_atomic_commit *state)
>   {
>   	struct drm_plane_state *old_state = drm_atomic_get_old_plane_state(state,
>   									   drm_plane);
>   	struct sprd_dpu *dpu = to_sprd_crtc(old_state->crtc);
>   
> @@ -634,21 +634,21 @@ static void sprd_crtc_mode_set_nofb(struct drm_crtc *crtc)
>   
>   	sprd_dpi_init(dpu);
>   }
>   
>   static void sprd_crtc_atomic_enable(struct drm_crtc *crtc,
> -				    struct drm_atomic_state *state)
> +				    struct drm_atomic_commit *state)
>   {
>   	struct sprd_dpu *dpu = to_sprd_crtc(crtc);
>   
>   	sprd_dpu_init(dpu);
>   
>   	drm_crtc_vblank_on(&dpu->base);
>   }
>   
>   static void sprd_crtc_atomic_disable(struct drm_crtc *crtc,
> -				     struct drm_atomic_state *state)
> +				     struct drm_atomic_commit *state)
>   {
>   	struct sprd_dpu *dpu = to_sprd_crtc(crtc);
>   	struct drm_device *drm = dpu->base.dev;
>   
>   	drm_crtc_vblank_off(&dpu->base);
> @@ -662,11 +662,11 @@ static void sprd_crtc_atomic_disable(struct drm_crtc *crtc,
>   	}
>   	spin_unlock_irq(&drm->event_lock);
>   }
>   
>   static void sprd_crtc_atomic_flush(struct drm_crtc *crtc,
> -				   struct drm_atomic_state *state)
> +				   struct drm_atomic_commit *state)
>   
>   {
>   	struct sprd_dpu *dpu = to_sprd_crtc(crtc);
>   	struct drm_device *drm = dpu->base.dev;
>   
> diff --git a/drivers/gpu/drm/sti/sti_crtc.c b/drivers/gpu/drm/sti/sti_crtc.c
> index 3c7154f2d5f3729e7ca3c1b7d29ac3ea9d42ec27..f0e98653d35a2b4255757c52b433b7a5819e1775 100644
> --- a/drivers/gpu/drm/sti/sti_crtc.c
> +++ b/drivers/gpu/drm/sti/sti_crtc.c
> @@ -20,11 +20,11 @@
>   #include "sti_drv.h"
>   #include "sti_vid.h"
>   #include "sti_vtg.h"
>   
>   static void sti_crtc_atomic_enable(struct drm_crtc *crtc,
> -				   struct drm_atomic_state *state)
> +				   struct drm_atomic_commit *state)
>   {
>   	struct sti_mixer *mixer = to_sti_mixer(crtc);
>   
>   	DRM_DEBUG_DRIVER("\n");
>   
> @@ -32,11 +32,11 @@ static void sti_crtc_atomic_enable(struct drm_crtc *crtc,
>   
>   	drm_crtc_vblank_on(crtc);
>   }
>   
>   static void sti_crtc_atomic_disable(struct drm_crtc *crtc,
> -				    struct drm_atomic_state *state)
> +				    struct drm_atomic_commit *state)
>   {
>   	struct sti_mixer *mixer = to_sti_mixer(crtc);
>   
>   	DRM_DEBUG_DRIVER("\n");
>   
> @@ -130,11 +130,11 @@ sti_crtc_mode_set_nofb(struct drm_crtc *crtc)
>   {
>   	sti_crtc_mode_set(crtc, &crtc->state->adjusted_mode);
>   }
>   
>   static void sti_crtc_atomic_flush(struct drm_crtc *crtc,
> -				  struct drm_atomic_state *state)
> +				  struct drm_atomic_commit *state)
>   {
>   	struct drm_device *drm_dev = crtc->dev;
>   	struct sti_mixer *mixer = to_sti_mixer(crtc);
>   	struct sti_compositor *compo = dev_get_drvdata(mixer->dev);
>   	struct drm_plane *p;
> diff --git a/drivers/gpu/drm/sti/sti_cursor.c b/drivers/gpu/drm/sti/sti_cursor.c
> index 4e12a465be7fe2e2abfa6686361ad0d3483134e5..d0b89b28e50cca77d38cc0e77c80caa212afe151 100644
> --- a/drivers/gpu/drm/sti/sti_cursor.c
> +++ b/drivers/gpu/drm/sti/sti_cursor.c
> @@ -181,11 +181,11 @@ static void sti_cursor_init(struct sti_cursor *cursor)
>   						  (g * 5) << 4 |
>   						  (b * 5);
>   }
>   
>   static int sti_cursor_atomic_check(struct drm_plane *drm_plane,
> -				   struct drm_atomic_state *state)
> +				   struct drm_atomic_commit *state)
>   {
>   	struct drm_plane_state *new_plane_state = drm_atomic_get_new_plane_state(state,
>   										 drm_plane);
>   	struct sti_plane *plane = to_sti_plane(drm_plane);
>   	struct sti_cursor *cursor = to_sti_cursor(plane);
> @@ -259,11 +259,11 @@ static int sti_cursor_atomic_check(struct drm_plane *drm_plane,
>   
>   	return 0;
>   }
>   
>   static void sti_cursor_atomic_update(struct drm_plane *drm_plane,
> -				     struct drm_atomic_state *state)
> +				     struct drm_atomic_commit *state)
>   {
>   	struct drm_plane_state *newstate = drm_atomic_get_new_plane_state(state,
>   									  drm_plane);
>   	struct sti_plane *plane = to_sti_plane(drm_plane);
>   	struct sti_cursor *cursor = to_sti_cursor(plane);
> @@ -314,11 +314,11 @@ static void sti_cursor_atomic_update(struct drm_plane *drm_plane,
>   
>   	plane->status = STI_PLANE_UPDATED;
>   }
>   
>   static void sti_cursor_atomic_disable(struct drm_plane *drm_plane,
> -				      struct drm_atomic_state *state)
> +				      struct drm_atomic_commit *state)
>   {
>   	struct drm_plane_state *oldstate = drm_atomic_get_old_plane_state(state,
>   									  drm_plane);
>   	struct sti_plane *plane = to_sti_plane(drm_plane);
>   
> diff --git a/drivers/gpu/drm/sti/sti_gdp.c b/drivers/gpu/drm/sti/sti_gdp.c
> index 1e5aa8c30645775420b1b681a314413f975c879e..9a17b590aa3d871198d92a08e3fa41cbc39b10df 100644
> --- a/drivers/gpu/drm/sti/sti_gdp.c
> +++ b/drivers/gpu/drm/sti/sti_gdp.c
> @@ -616,11 +616,11 @@ static int sti_gdp_get_dst(struct device *dev, int dst, int src)
>   	dev_dbg(dev, "WARNING: GDP scale not supported, will clamp\n");
>   	return src;
>   }
>   
>   static int sti_gdp_atomic_check(struct drm_plane *drm_plane,
> -				struct drm_atomic_state *state)
> +				struct drm_atomic_commit *state)
>   {
>   	struct drm_plane_state *new_plane_state = drm_atomic_get_new_plane_state(state,
>   										 drm_plane);
>   	struct sti_plane *plane = to_sti_plane(drm_plane);
>   	struct sti_gdp *gdp = to_sti_gdp(plane);
> @@ -703,11 +703,11 @@ static int sti_gdp_atomic_check(struct drm_plane *drm_plane,
>   
>   	return 0;
>   }
>   
>   static void sti_gdp_atomic_update(struct drm_plane *drm_plane,
> -				  struct drm_atomic_state *state)
> +				  struct drm_atomic_commit *state)
>   {
>   	struct drm_plane_state *oldstate = drm_atomic_get_old_plane_state(state,
>   									  drm_plane);
>   	struct drm_plane_state *newstate = drm_atomic_get_new_plane_state(state,
>   									  drm_plane);
> @@ -871,11 +871,11 @@ static void sti_gdp_atomic_update(struct drm_plane *drm_plane,
>   
>   	plane->status = STI_PLANE_UPDATED;
>   }
>   
>   static void sti_gdp_atomic_disable(struct drm_plane *drm_plane,
> -				   struct drm_atomic_state *state)
> +				   struct drm_atomic_commit *state)
>   {
>   	struct drm_plane_state *oldstate = drm_atomic_get_old_plane_state(state,
>   									  drm_plane);
>   	struct sti_plane *plane = to_sti_plane(drm_plane);
>   
> diff --git a/drivers/gpu/drm/sti/sti_hqvdp.c b/drivers/gpu/drm/sti/sti_hqvdp.c
> index 57ef4ba3554ebd2e3cd4ce6a88335035a7b6a42f..cf1ed8a33b8e188348666705f5aaddb616c722b3 100644
> --- a/drivers/gpu/drm/sti/sti_hqvdp.c
> +++ b/drivers/gpu/drm/sti/sti_hqvdp.c
> @@ -1018,11 +1018,11 @@ static void sti_hqvdp_start_xp70(struct sti_hqvdp *hqvdp)
>   out:
>   	release_firmware(firmware);
>   }
>   
>   static int sti_hqvdp_atomic_check(struct drm_plane *drm_plane,
> -				  struct drm_atomic_state *state)
> +				  struct drm_atomic_commit *state)
>   {
>   	struct drm_plane_state *new_plane_state = drm_atomic_get_new_plane_state(state,
>   										 drm_plane);
>   	struct sti_plane *plane = to_sti_plane(drm_plane);
>   	struct sti_hqvdp *hqvdp = to_sti_hqvdp(plane);
> @@ -1113,11 +1113,11 @@ static int sti_hqvdp_atomic_check(struct drm_plane *drm_plane,
>   
>   	return 0;
>   }
>   
>   static void sti_hqvdp_atomic_update(struct drm_plane *drm_plane,
> -				    struct drm_atomic_state *state)
> +				    struct drm_atomic_commit *state)
>   {
>   	struct drm_plane_state *oldstate = drm_atomic_get_old_plane_state(state,
>   									  drm_plane);
>   	struct drm_plane_state *newstate = drm_atomic_get_new_plane_state(state,
>   									  drm_plane);
> @@ -1247,11 +1247,11 @@ static void sti_hqvdp_atomic_update(struct drm_plane *drm_plane,
>   
>   	plane->status = STI_PLANE_UPDATED;
>   }
>   
>   static void sti_hqvdp_atomic_disable(struct drm_plane *drm_plane,
> -				     struct drm_atomic_state *state)
> +				     struct drm_atomic_commit *state)
>   {
>   	struct drm_plane_state *oldstate = drm_atomic_get_old_plane_state(state,
>   									  drm_plane);
>   	struct sti_plane *plane = to_sti_plane(drm_plane);
>   
> diff --git a/drivers/gpu/drm/stm/drv.c b/drivers/gpu/drm/stm/drv.c
> index 56d53ac3082d9ec04a70a4cc3008e0939bb67cc3..144b7cda989ac30f42dd3c8a8d2eea4784336533 100644
> --- a/drivers/gpu/drm/stm/drv.c
> +++ b/drivers/gpu/drm/stm/drv.c
> @@ -124,11 +124,11 @@ static void drv_unload(struct drm_device *ddev)
>   
>   static __maybe_unused int drv_suspend(struct device *dev)
>   {
>   	struct drm_device *ddev = dev_get_drvdata(dev);
>   	struct ltdc_device *ldev = ddev->dev_private;
> -	struct drm_atomic_state *state;
> +	struct drm_atomic_commit *state;
>   
>   	WARN_ON(ldev->suspend_state);
>   
>   	state = drm_atomic_helper_suspend(ddev);
>   	if (IS_ERR(state))
> diff --git a/drivers/gpu/drm/stm/ltdc.c b/drivers/gpu/drm/stm/ltdc.c
> index f7e847cfa38f8dbf0dd5177320cbb08dcd5e99a8..95fcfa48d8be30073ce5a886030c8b77ee4f79b4 100644
> --- a/drivers/gpu/drm/stm/ltdc.c
> +++ b/drivers/gpu/drm/stm/ltdc.c
> @@ -771,11 +771,11 @@ static void ltdc_crtc_update_clut(struct drm_crtc *crtc)
>   		regmap_write(ldev->regmap, LTDC_L1CLUTWR, val);
>   	}
>   }
>   
>   static void ltdc_crtc_atomic_enable(struct drm_crtc *crtc,
> -				    struct drm_atomic_state *state)
> +				    struct drm_atomic_commit *state)
>   {
>   	struct ltdc_device *ldev = crtc_to_ltdc(crtc);
>   	struct drm_device *ddev = crtc->dev;
>   
>   	drm_dbg_driver(crtc->dev, "\n");
> @@ -794,11 +794,11 @@ static void ltdc_crtc_atomic_enable(struct drm_crtc *crtc,
>   
>   	drm_crtc_vblank_on(crtc);
>   }
>   
>   static void ltdc_crtc_atomic_disable(struct drm_crtc *crtc,
> -				     struct drm_atomic_state *state)
> +				     struct drm_atomic_commit *state)
>   {
>   	struct ltdc_device *ldev = crtc_to_ltdc(crtc);
>   	struct drm_device *ddev = crtc->dev;
>   	int layer_index = 0;
>   
> @@ -1035,11 +1035,11 @@ static void ltdc_crtc_mode_set_nofb(struct drm_crtc *crtc)
>   		}
>   	}
>   }
>   
>   static void ltdc_crtc_atomic_flush(struct drm_crtc *crtc,
> -				   struct drm_atomic_state *state)
> +				   struct drm_atomic_commit *state)
>   {
>   	struct ltdc_device *ldev = crtc_to_ltdc(crtc);
>   	struct drm_device *ddev = crtc->dev;
>   	struct drm_pending_vblank_event *event = crtc->state->event;
>   
> @@ -1234,11 +1234,11 @@ static const struct drm_crtc_funcs ltdc_crtc_with_crc_support_funcs = {
>   /*
>    * DRM_PLANE
>    */
>   
>   static int ltdc_plane_atomic_check(struct drm_plane *plane,
> -				   struct drm_atomic_state *state)
> +				   struct drm_atomic_commit *state)
>   {
>   	struct drm_plane_state *new_plane_state = drm_atomic_get_new_plane_state(state,
>   										 plane);
>   	struct drm_framebuffer *fb = new_plane_state->fb;
>   	u32 src_w, src_h;
> @@ -1261,11 +1261,11 @@ static int ltdc_plane_atomic_check(struct drm_plane *plane,
>   
>   	return 0;
>   }
>   
>   static void ltdc_plane_atomic_update(struct drm_plane *plane,
> -				     struct drm_atomic_state *state)
> +				     struct drm_atomic_commit *state)
>   {
>   	struct ltdc_device *ldev = plane_to_ltdc(plane);
>   	struct drm_plane_state *newstate = drm_atomic_get_new_plane_state(state,
>   									  plane);
>   	struct drm_framebuffer *fb = newstate->fb;
> @@ -1507,11 +1507,11 @@ static void ltdc_plane_atomic_update(struct drm_plane *plane,
>   	}
>   	mutex_unlock(&ldev->err_lock);
>   }
>   
>   static void ltdc_plane_atomic_disable(struct drm_plane *plane,
> -				      struct drm_atomic_state *state)
> +				      struct drm_atomic_commit *state)
>   {
>   	struct drm_plane_state *oldstate = drm_atomic_get_old_plane_state(state,
>   									  plane);
>   	struct ltdc_device *ldev = plane_to_ltdc(plane);
>   	u32 lofs = plane->index * LAY_OFS;
> diff --git a/drivers/gpu/drm/stm/ltdc.h b/drivers/gpu/drm/stm/ltdc.h
> index 17b51a7ce28eee5de6d24ca943ca3b1f48695dfd..452352e645d71d229b18f64bc6490e6a94e562ca 100644
> --- a/drivers/gpu/drm/stm/ltdc.h
> +++ b/drivers/gpu/drm/stm/ltdc.h
> @@ -56,11 +56,11 @@ struct ltdc_device {
>   	u32 fifo_err;		/* fifo underrun error counter */
>   	u32 fifo_warn;		/* fifo underrun warning counter */
>   	u32 fifo_threshold;	/* fifo underrun threshold */
>   	u32 transfer_err;	/* transfer error counter */
>   	struct fps_info plane_fpsi[LTDC_MAX_LAYER];
> -	struct drm_atomic_state *suspend_state;
> +	struct drm_atomic_commit *suspend_state;
>   	int crc_skip_count;
>   	bool crc_active;
>   };
>   
>   int ltdc_load(struct drm_device *ddev);
> diff --git a/drivers/gpu/drm/stm/lvds.c b/drivers/gpu/drm/stm/lvds.c
> index fe38c0984b2b552e1ccaef4d1e589b9d86a40ee3..f7121962b0b37dbdfee4beb971f8b8afc49687ed 100644
> --- a/drivers/gpu/drm/stm/lvds.c
> +++ b/drivers/gpu/drm/stm/lvds.c
> @@ -885,11 +885,11 @@ static int lvds_connector_get_modes(struct drm_connector *connector)
>   
>   	return drm_panel_get_modes(lvds->panel, connector);
>   }
>   
>   static int lvds_connector_atomic_check(struct drm_connector *connector,
> -				       struct drm_atomic_state *state)
> +				       struct drm_atomic_commit *state)
>   {
>   	const struct drm_display_mode *panel_mode;
>   	struct drm_connector_state *conn_state;
>   	struct drm_crtc_state *crtc_state;
>   
> @@ -979,11 +979,11 @@ static int lvds_attach(struct drm_bridge *bridge, struct drm_encoder *encoder,
>   
>   	return ret;
>   }
>   
>   static void lvds_atomic_enable(struct drm_bridge *bridge,
> -			       struct drm_atomic_state *state)
> +			       struct drm_atomic_commit *state)
>   {
>   	struct stm_lvds *lvds = bridge_to_stm_lvds(bridge);
>   	struct drm_connector_state *conn_state;
>   	struct drm_connector *connector;
>   	int ret;
> @@ -1015,11 +1015,11 @@ static void lvds_atomic_enable(struct drm_bridge *bridge,
>   		drm_panel_enable(lvds->panel);
>   	}
>   }
>   
>   static void lvds_atomic_disable(struct drm_bridge *bridge,
> -				struct drm_atomic_state *state)
> +				struct drm_atomic_commit *state)
>   {
>   	struct stm_lvds *lvds = bridge_to_stm_lvds(bridge);
>   
>   	if (lvds->panel) {
>   		drm_panel_disable(lvds->panel);
> diff --git a/drivers/gpu/drm/sun4i/sun4i_backend.c b/drivers/gpu/drm/sun4i/sun4i_backend.c
> index bc35dad53b07114f8d95978c83a74ca3de0058e9..03e46a2af6463902d77b124b432e191d68f0b332 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_backend.c
> +++ b/drivers/gpu/drm/sun4i/sun4i_backend.c
> @@ -70,11 +70,11 @@ static void sun4i_backend_disable_color_correction(struct sunxi_engine *engine)
>   			   SUN4I_BACKEND_OCCTL_ENABLE, 0);
>   }
>   
>   static void sun4i_backend_commit(struct sunxi_engine *engine,
>   				 struct drm_crtc *crtc,
> -				 struct drm_atomic_state *state)
> +				 struct drm_atomic_commit *state)
>   {
>   	DRM_DEBUG_DRIVER("Committing changes\n");
>   
>   	regmap_write(engine->regs, SUN4I_BACKEND_REGBUFFCTL_REG,
>   		     SUN4I_BACKEND_REGBUFFCTL_AUTOLOAD_DIS |
> @@ -470,11 +470,11 @@ static void sun4i_backend_atomic_begin(struct sunxi_engine *engine,
>   static int sun4i_backend_atomic_check(struct sunxi_engine *engine,
>   				      struct drm_crtc_state *crtc_state)
>   {
>   	struct drm_plane_state *plane_states[SUN4I_BACKEND_NUM_LAYERS] = { 0 };
>   	struct sun4i_backend *backend = engine_to_sun4i_backend(engine);
> -	struct drm_atomic_state *state = crtc_state->state;
> +	struct drm_atomic_commit *state = crtc_state->state;
>   	struct drm_device *drm = state->dev;
>   	struct drm_plane *plane;
>   	unsigned int num_planes = 0;
>   	unsigned int num_alpha_planes = 0;
>   	unsigned int num_frontend_planes = 0;
> diff --git a/drivers/gpu/drm/sun4i/sun4i_crtc.c b/drivers/gpu/drm/sun4i/sun4i_crtc.c
> index 18e74047b0f566312310bac67320e1928df4cbeb..c2f7f69baf75a34aae0272ea8a0c8eb1aff2a972 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_crtc.c
> +++ b/drivers/gpu/drm/sun4i/sun4i_crtc.c
> @@ -44,11 +44,11 @@ static struct drm_encoder *sun4i_crtc_get_encoder(struct drm_crtc *crtc)
>   
>   	return NULL;
>   }
>   
>   static int sun4i_crtc_atomic_check(struct drm_crtc *crtc,
> -				    struct drm_atomic_state *state)
> +				    struct drm_atomic_commit *state)
>   {
>   	struct drm_crtc_state *crtc_state = drm_atomic_get_new_crtc_state(state,
>   									  crtc);
>   	struct sun4i_crtc *scrtc = drm_crtc_to_sun4i_crtc(crtc);
>   	struct sunxi_engine *engine = scrtc->engine;
> @@ -59,11 +59,11 @@ static int sun4i_crtc_atomic_check(struct drm_crtc *crtc,
>   
>   	return ret;
>   }
>   
>   static void sun4i_crtc_atomic_begin(struct drm_crtc *crtc,
> -				    struct drm_atomic_state *state)
> +				    struct drm_atomic_commit *state)
>   {
>   	struct drm_crtc_state *old_state = drm_atomic_get_old_crtc_state(state,
>   									 crtc);
>   	struct sun4i_crtc *scrtc = drm_crtc_to_sun4i_crtc(crtc);
>   	struct drm_device *dev = crtc->dev;
> @@ -82,11 +82,11 @@ static void sun4i_crtc_atomic_begin(struct drm_crtc *crtc,
>   	if (engine->ops->atomic_begin)
>   		engine->ops->atomic_begin(engine, old_state);
>   }
>   
>   static void sun4i_crtc_atomic_flush(struct drm_crtc *crtc,
> -				    struct drm_atomic_state *state)
> +				    struct drm_atomic_commit *state)
>   {
>   	struct sun4i_crtc *scrtc = drm_crtc_to_sun4i_crtc(crtc);
>   	struct drm_pending_vblank_event *event = crtc->state->event;
>   
>   	DRM_DEBUG_DRIVER("Committing plane changes\n");
> @@ -104,11 +104,11 @@ static void sun4i_crtc_atomic_flush(struct drm_crtc *crtc,
>   		spin_unlock_irq(&crtc->dev->event_lock);
>   	}
>   }
>   
>   static void sun4i_crtc_atomic_disable(struct drm_crtc *crtc,
> -				      struct drm_atomic_state *state)
> +				      struct drm_atomic_commit *state)
>   {
>   	struct drm_encoder *encoder = sun4i_crtc_get_encoder(crtc);
>   	struct sun4i_crtc *scrtc = drm_crtc_to_sun4i_crtc(crtc);
>   
>   	DRM_DEBUG_DRIVER("Disabling the CRTC\n");
> @@ -125,11 +125,11 @@ static void sun4i_crtc_atomic_disable(struct drm_crtc *crtc,
>   		crtc->state->event = NULL;
>   	}
>   }
>   
>   static void sun4i_crtc_atomic_enable(struct drm_crtc *crtc,
> -				     struct drm_atomic_state *state)
> +				     struct drm_atomic_commit *state)
>   {
>   	struct drm_encoder *encoder = sun4i_crtc_get_encoder(crtc);
>   	struct sun4i_crtc *scrtc = drm_crtc_to_sun4i_crtc(crtc);
>   
>   	DRM_DEBUG_DRIVER("Enabling the CRTC\n");
> diff --git a/drivers/gpu/drm/sun4i/sun4i_framebuffer.c b/drivers/gpu/drm/sun4i/sun4i_framebuffer.c
> index 260136d60ceba919881e805019c257968cc95c33..9c8ef927d9297c8ad7c552aced34a3b1223b090d 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_framebuffer.c
> +++ b/drivers/gpu/drm/sun4i/sun4i_framebuffer.c
> @@ -13,11 +13,11 @@
>   
>   #include "sun4i_drv.h"
>   #include "sun4i_framebuffer.h"
>   
>   static int sun4i_de_atomic_check(struct drm_device *dev,
> -				 struct drm_atomic_state *state)
> +				 struct drm_atomic_commit *state)
>   {
>   	int ret;
>   
>   	ret = drm_atomic_helper_check_modeset(dev, state);
>   	if (ret)
> diff --git a/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c b/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
> index dd2a78defdb4b93f454d2af6167a3d4e83e3d542..07e2afcb4f95cb3ccc2c7b564880a7774e78415e 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
> +++ b/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
> @@ -74,11 +74,11 @@ static int sun4i_hdmi_write_hdmi_infoframe(struct drm_connector *connector,
>   
>   	return 0;
>   }
>   
>   static void sun4i_hdmi_disable(struct drm_encoder *encoder,
> -			       struct drm_atomic_state *state)
> +			       struct drm_atomic_commit *state)
>   {
>   	struct sun4i_hdmi *hdmi = drm_encoder_to_sun4i_hdmi(encoder);
>   	u32 val;
>   
>   	DRM_DEBUG_DRIVER("Disabling the HDMI Output\n");
> @@ -89,11 +89,11 @@ static void sun4i_hdmi_disable(struct drm_encoder *encoder,
>   
>   	clk_disable_unprepare(hdmi->tmds_clk);
>   }
>   
>   static void sun4i_hdmi_enable(struct drm_encoder *encoder,
> -			      struct drm_atomic_state *state)
> +			      struct drm_atomic_commit *state)
>   {
>   	struct drm_display_mode *mode = &encoder->crtc->state->adjusted_mode;
>   	struct sun4i_hdmi *hdmi = drm_encoder_to_sun4i_hdmi(encoder);
>   	struct drm_connector *connector = &hdmi->connector;
>   	struct drm_display_info *display = &connector->display_info;
> diff --git a/drivers/gpu/drm/sun4i/sun4i_layer.c b/drivers/gpu/drm/sun4i/sun4i_layer.c
> index 63cb8c7c36363d5740f3529f75fff61481126d59..d65587d96d9eee455e6917658d7736525c7edd36 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_layer.c
> +++ b/drivers/gpu/drm/sun4i/sun4i_layer.c
> @@ -59,11 +59,11 @@ static void sun4i_backend_layer_destroy_state(struct drm_plane *plane,
>   
>   	kfree(s_state);
>   }
>   
>   static void sun4i_backend_layer_atomic_disable(struct drm_plane *plane,
> -					       struct drm_atomic_state *state)
> +					       struct drm_atomic_commit *state)
>   {
>   	struct drm_plane_state *old_state = drm_atomic_get_old_plane_state(state,
>   									   plane);
>   	struct sun4i_layer_state *layer_state = state_to_sun4i_layer_state(old_state);
>   	struct sun4i_layer *layer = plane_to_sun4i_layer(plane);
> @@ -79,11 +79,11 @@ static void sun4i_backend_layer_atomic_disable(struct drm_plane *plane,
>   		spin_unlock_irqrestore(&backend->frontend_lock, flags);
>   	}
>   }
>   
>   static void sun4i_backend_layer_atomic_update(struct drm_plane *plane,
> -					      struct drm_atomic_state *state)
> +					      struct drm_atomic_commit *state)
>   {
>   	struct drm_plane_state *new_state = drm_atomic_get_new_plane_state(state,
>   									   plane);
>   	struct sun4i_layer_state *layer_state = state_to_sun4i_layer_state(new_state);
>   	struct sun4i_layer *layer = plane_to_sun4i_layer(plane);
> diff --git a/drivers/gpu/drm/sun4i/sun4i_tv.c b/drivers/gpu/drm/sun4i/sun4i_tv.c
> index cce4e38789b989a2261139073cdd508e0b7d2cb4..814b77f278f69cc224e1628ab660a115510d7d0e 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_tv.c
> +++ b/drivers/gpu/drm/sun4i/sun4i_tv.c
> @@ -259,11 +259,11 @@ sun4i_tv_find_tv_by_mode(unsigned int mode)
>   
>   	return NULL;
>   }
>   
>   static void sun4i_tv_disable(struct drm_encoder *encoder,
> -			    struct drm_atomic_state *state)
> +			    struct drm_atomic_commit *state)
>   {
>   	struct sun4i_tv *tv = drm_encoder_to_sun4i_tv(encoder);
>   	struct sun4i_crtc *crtc = drm_crtc_to_sun4i_crtc(encoder->crtc);
>   
>   	DRM_DEBUG_DRIVER("Disabling the TV Output\n");
> @@ -274,11 +274,11 @@ static void sun4i_tv_disable(struct drm_encoder *encoder,
>   
>   	sunxi_engine_disable_color_correction(crtc->engine);
>   }
>   
>   static void sun4i_tv_enable(struct drm_encoder *encoder,
> -			    struct drm_atomic_state *state)
> +			    struct drm_atomic_commit *state)
>   {
>   	struct sun4i_tv *tv = drm_encoder_to_sun4i_tv(encoder);
>   	struct sun4i_crtc *crtc = drm_crtc_to_sun4i_crtc(encoder->crtc);
>   	struct drm_crtc_state *crtc_state =
>   		drm_atomic_get_new_crtc_state(state, encoder->crtc);
> diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.c b/drivers/gpu/drm/sun4i/sun8i_mixer.c
> index 4071ab38b4ae526778bad4fa310692eefd5ccdc7..4e42262950104b7b164c86b49508bf73a35ae391 100644
> --- a/drivers/gpu/drm/sun4i/sun8i_mixer.c
> +++ b/drivers/gpu/drm/sun4i/sun8i_mixer.c
> @@ -251,11 +251,11 @@ int sun8i_mixer_drm_format_to_hw(u32 format, u32 *hw_format)
>   	return -EINVAL;
>   }
>   
>   static void sun8i_mixer_commit(struct sunxi_engine *engine,
>   			       struct drm_crtc *crtc,
> -			       struct drm_atomic_state *state)
> +			       struct drm_atomic_commit *state)
>   {
>   	struct sun8i_mixer *mixer = engine_to_sun8i_mixer(engine);
>   	u32 bld_base = sun8i_blender_base(mixer);
>   	struct regmap *bld_regs = sun8i_blender_regmap(mixer);
>   	struct drm_plane_state *plane_state;
> diff --git a/drivers/gpu/drm/sun4i/sun8i_ui_layer.c b/drivers/gpu/drm/sun4i/sun8i_ui_layer.c
> index 72c92203ae633e56ac7f3c3e8d37ba3d52c9d579..00756ab78b4eb253458b35eeaa376574f3839a60 100644
> --- a/drivers/gpu/drm/sun4i/sun8i_ui_layer.c
> +++ b/drivers/gpu/drm/sun4i/sun8i_ui_layer.c
> @@ -144,11 +144,11 @@ static void sun8i_ui_layer_update_buffer(struct sun8i_layer *layer,
>   		     SUN8I_MIXER_CHAN_UI_LAYER_TOP_LADDR(ch_base, layer->overlay),
>   		     lower_32_bits(dma_addr));
>   }
>   
>   static int sun8i_ui_layer_atomic_check(struct drm_plane *plane,
> -				       struct drm_atomic_state *state)
> +				       struct drm_atomic_commit *state)
>   {
>   	struct drm_plane_state *new_plane_state = drm_atomic_get_new_plane_state(state,
>   										 plane);
>   	struct sun8i_layer *layer = plane_to_sun8i_layer(plane);
>   	struct drm_crtc *crtc = new_plane_state->crtc;
> @@ -185,11 +185,11 @@ static int sun8i_ui_layer_atomic_check(struct drm_plane *plane,
>   						   true, true);
>   }
>   
>   
>   static void sun8i_ui_layer_atomic_update(struct drm_plane *plane,
> -					 struct drm_atomic_state *state)
> +					 struct drm_atomic_commit *state)
>   {
>   	struct drm_plane_state *new_state = drm_atomic_get_new_plane_state(state,
>   									   plane);
>   	struct sun8i_layer *layer = plane_to_sun8i_layer(plane);
>   
> diff --git a/drivers/gpu/drm/sun4i/sun8i_vi_layer.c b/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
> index cd8d6c2da0c72ae22479cd50917938e9da8021a3..09f668c8af2478a2eae4ef650c70b46bf7fc85cc 100644
> --- a/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
> +++ b/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
> @@ -224,11 +224,11 @@ static void sun8i_vi_layer_update_buffer(struct sun8i_layer *layer,
>   			     lower_32_bits(dma_addr));
>   	}
>   }
>   
>   static int sun8i_vi_layer_atomic_check(struct drm_plane *plane,
> -				       struct drm_atomic_state *state)
> +				       struct drm_atomic_commit *state)
>   {
>   	struct drm_plane_state *new_plane_state = drm_atomic_get_new_plane_state(state,
>   										 plane);
>   	struct sun8i_layer *layer = plane_to_sun8i_layer(plane);
>   	struct drm_crtc *crtc = new_plane_state->crtc;
> @@ -264,11 +264,11 @@ static int sun8i_vi_layer_atomic_check(struct drm_plane *plane,
>   						   min_scale, max_scale,
>   						   true, true);
>   }
>   
>   static void sun8i_vi_layer_atomic_update(struct drm_plane *plane,
> -					 struct drm_atomic_state *state)
> +					 struct drm_atomic_commit *state)
>   {
>   	struct drm_plane_state *new_state = drm_atomic_get_new_plane_state(state,
>   									   plane);
>   	struct sun8i_layer *layer = plane_to_sun8i_layer(plane);
>   
> diff --git a/drivers/gpu/drm/sun4i/sunxi_engine.h b/drivers/gpu/drm/sun4i/sunxi_engine.h
> index c9461de06cd04074d6c54c87d2740a9106f74879..1711c274a41b0d902a4b078c6b14aa5b60c3e28a 100644
> --- a/drivers/gpu/drm/sun4i/sunxi_engine.h
> +++ b/drivers/gpu/drm/sun4i/sunxi_engine.h
> @@ -60,11 +60,11 @@ struct sunxi_engine_ops {
>   	 *
>   	 * This function is optional.
>   	 */
>   	void (*commit)(struct sunxi_engine *engine,
>   		       struct drm_crtc *crtc,
> -		       struct drm_atomic_state *state);
> +		       struct drm_atomic_commit *state);
>   
>   	/**
>   	 * @layers_init:
>   	 *
>   	 * This callback is used to allocate, initialize and register
> @@ -151,11 +151,11 @@ struct sunxi_engine {
>    * @state:	atomic state
>    */
>   static inline void
>   sunxi_engine_commit(struct sunxi_engine *engine,
>   		    struct drm_crtc *crtc,
> -		    struct drm_atomic_state *state)
> +		    struct drm_atomic_commit *state)
>   {
>   	if (engine->ops && engine->ops->commit)
>   		engine->ops->commit(engine, crtc, state);
>   }
>   
> diff --git a/drivers/gpu/drm/sysfb/drm_sysfb_helper.h b/drivers/gpu/drm/sysfb/drm_sysfb_helper.h
> index b14df5b54bc9a8dc30b813abcfe0ff1026315903..2a2b553366fb74fe5769b2130e976b26387c0021 100644
> --- a/drivers/gpu/drm/sysfb/drm_sysfb_helper.h
> +++ b/drivers/gpu/drm/sysfb/drm_sysfb_helper.h
> @@ -109,15 +109,15 @@ size_t drm_sysfb_build_fourcc_list(struct drm_device *dev,
>   				   u32 *fourccs_out, size_t nfourccs_out);
>   
>   int drm_sysfb_plane_helper_begin_fb_access(struct drm_plane *plane,
>   					   struct drm_plane_state *plane_state);
>   int drm_sysfb_plane_helper_atomic_check(struct drm_plane *plane,
> -					struct drm_atomic_state *new_state);
> +					struct drm_atomic_commit *new_state);
>   void drm_sysfb_plane_helper_atomic_update(struct drm_plane *plane,
> -					  struct drm_atomic_state *state);
> +					  struct drm_atomic_commit *state);
>   void drm_sysfb_plane_helper_atomic_disable(struct drm_plane *plane,
> -					   struct drm_atomic_state *state);
> +					   struct drm_atomic_commit *state);
>   int drm_sysfb_plane_helper_get_scanout_buffer(struct drm_plane *plane,
>   					      struct drm_scanout_buffer *sb);
>   
>   #define DRM_SYSFB_PLANE_NFORMATS(_num_native) \
>   	((_num_native) + 1)
> @@ -163,11 +163,11 @@ to_drm_sysfb_crtc_state(struct drm_crtc_state *base)
>   	return container_of(base, struct drm_sysfb_crtc_state, base);
>   }
>   
>   enum drm_mode_status drm_sysfb_crtc_helper_mode_valid(struct drm_crtc *crtc,
>   						      const struct drm_display_mode *mode);
> -int drm_sysfb_crtc_helper_atomic_check(struct drm_crtc *crtc, struct drm_atomic_state *new_state);
> +int drm_sysfb_crtc_helper_atomic_check(struct drm_crtc *crtc, struct drm_atomic_commit *new_state);
>   
>   #define DRM_SYSFB_CRTC_HELPER_FUNCS \
>   	.mode_valid = drm_sysfb_crtc_helper_mode_valid, \
>   	.atomic_check = drm_sysfb_crtc_helper_atomic_check
>   
> diff --git a/drivers/gpu/drm/sysfb/drm_sysfb_modeset.c b/drivers/gpu/drm/sysfb/drm_sysfb_modeset.c
> index 808b1eda871a1366652422a96842bbd94a3f6639..d2de29caf89eb646b5a43fa02448f556562ad92b 100644
> --- a/drivers/gpu/drm/sysfb/drm_sysfb_modeset.c
> +++ b/drivers/gpu/drm/sysfb/drm_sysfb_modeset.c
> @@ -281,11 +281,11 @@ int drm_sysfb_plane_helper_begin_fb_access(struct drm_plane *plane,
>   	return ret;
>   }
>   EXPORT_SYMBOL(drm_sysfb_plane_helper_begin_fb_access);
>   
>   int drm_sysfb_plane_helper_atomic_check(struct drm_plane *plane,
> -					struct drm_atomic_state *new_state)
> +					struct drm_atomic_commit *new_state)
>   {
>   	struct drm_sysfb_device *sysfb = to_drm_sysfb_device(plane->dev);
>   	struct drm_plane_state *new_plane_state = drm_atomic_get_new_plane_state(new_state, plane);
>   	struct drm_shadow_plane_state *new_shadow_plane_state =
>   		to_drm_shadow_plane_state(new_plane_state);
> @@ -324,11 +324,11 @@ int drm_sysfb_plane_helper_atomic_check(struct drm_plane *plane,
>   
>   	return 0;
>   }
>   EXPORT_SYMBOL(drm_sysfb_plane_helper_atomic_check);
>   
> -void drm_sysfb_plane_helper_atomic_update(struct drm_plane *plane, struct drm_atomic_state *state)
> +void drm_sysfb_plane_helper_atomic_update(struct drm_plane *plane, struct drm_atomic_commit *state)
>   {
>   	struct drm_device *dev = plane->dev;
>   	struct drm_sysfb_device *sysfb = to_drm_sysfb_device(dev);
>   	struct drm_plane_state *plane_state = drm_atomic_get_new_plane_state(state, plane);
>   	struct drm_plane_state *old_plane_state = drm_atomic_get_old_plane_state(state, plane);
> @@ -369,11 +369,11 @@ void drm_sysfb_plane_helper_atomic_update(struct drm_plane *plane, struct drm_at
>   	drm_gem_fb_end_cpu_access(fb, DMA_FROM_DEVICE);
>   }
>   EXPORT_SYMBOL(drm_sysfb_plane_helper_atomic_update);
>   
>   void drm_sysfb_plane_helper_atomic_disable(struct drm_plane *plane,
> -					   struct drm_atomic_state *state)
> +					   struct drm_atomic_commit *state)
>   {
>   	struct drm_device *dev = plane->dev;
>   	struct drm_sysfb_device *sysfb = to_drm_sysfb_device(dev);
>   	struct iosys_map dst = sysfb->fb_addr;
>   	struct drm_plane_state *plane_state = drm_atomic_get_new_plane_state(state, plane);
> @@ -484,11 +484,11 @@ enum drm_mode_status drm_sysfb_crtc_helper_mode_valid(struct drm_crtc *crtc,
>   
>   	return drm_crtc_helper_mode_valid_fixed(crtc, mode, &sysfb->fb_mode);
>   }
>   EXPORT_SYMBOL(drm_sysfb_crtc_helper_mode_valid);
>   
> -int drm_sysfb_crtc_helper_atomic_check(struct drm_crtc *crtc, struct drm_atomic_state *new_state)
> +int drm_sysfb_crtc_helper_atomic_check(struct drm_crtc *crtc, struct drm_atomic_commit *new_state)
>   {
>   	struct drm_device *dev = crtc->dev;
>   	struct drm_sysfb_device *sysfb = to_drm_sysfb_device(dev);
>   	struct drm_crtc_state *new_crtc_state = drm_atomic_get_new_crtc_state(new_state, crtc);
>   	int ret;
> diff --git a/drivers/gpu/drm/sysfb/ofdrm.c b/drivers/gpu/drm/sysfb/ofdrm.c
> index d38ba70f4e0d37b7bd3cb4a65fdad8c42bf3c934..ff55e7d59dddaac3b4dd8a4f01690d24df548b78 100644
> --- a/drivers/gpu/drm/sysfb/ofdrm.c
> +++ b/drivers/gpu/drm/sysfb/ofdrm.c
> @@ -721,11 +721,11 @@ static const struct drm_plane_helper_funcs ofdrm_primary_plane_helper_funcs = {
>   static const struct drm_plane_funcs ofdrm_primary_plane_funcs = {
>   	DRM_SYSFB_PLANE_FUNCS,
>   	.destroy = drm_plane_cleanup,
>   };
>   
> -static void ofdrm_crtc_helper_atomic_flush(struct drm_crtc *crtc, struct drm_atomic_state *state)
> +static void ofdrm_crtc_helper_atomic_flush(struct drm_crtc *crtc, struct drm_atomic_commit *state)
>   {
>   	struct ofdrm_device *odev = ofdrm_device_of_dev(crtc->dev);
>   	struct drm_crtc_state *crtc_state = drm_atomic_get_new_crtc_state(state, crtc);
>   	struct drm_sysfb_crtc_state *sysfb_crtc_state = to_drm_sysfb_crtc_state(crtc_state);
>   
> diff --git a/drivers/gpu/drm/sysfb/vesadrm.c b/drivers/gpu/drm/sysfb/vesadrm.c
> index 4e00113e5c770043377ce243709371022d9a837b..dee3b4d6ec2604464ccce9a2702dfb5ab1afc3eb 100644
> --- a/drivers/gpu/drm/sysfb/vesadrm.c
> +++ b/drivers/gpu/drm/sysfb/vesadrm.c
> @@ -244,11 +244,11 @@ static void vesadrm_load_palette_lut(struct vesadrm_device *vesa,
>   static const u64 vesadrm_primary_plane_format_modifiers[] = {
>   	DRM_SYSFB_PLANE_FORMAT_MODIFIERS,
>   };
>   
>   static int vesadrm_primary_plane_helper_atomic_check(struct drm_plane *plane,
> -						     struct drm_atomic_state *new_state)
> +						     struct drm_atomic_commit *new_state)
>   {
>   	struct drm_sysfb_device *sysfb = to_drm_sysfb_device(plane->dev);
>   	struct drm_plane_state *new_plane_state = drm_atomic_get_new_plane_state(new_state, plane);
>   	struct drm_framebuffer *new_fb = new_plane_state->fb;
>   	struct drm_crtc_state *new_crtc_state;
> @@ -313,11 +313,11 @@ static const struct drm_plane_funcs vesadrm_primary_plane_funcs = {
>   	DRM_SYSFB_PLANE_FUNCS,
>   	.destroy = drm_plane_cleanup,
>   };
>   
>   static void vesadrm_crtc_helper_atomic_flush(struct drm_crtc *crtc,
> -					     struct drm_atomic_state *state)
> +					     struct drm_atomic_commit *state)
>   {
>   	struct drm_device *dev = crtc->dev;
>   	struct drm_sysfb_device *sysfb = to_drm_sysfb_device(dev);
>   	struct vesadrm_device *vesa = to_vesadrm_device(dev);
>   	struct drm_crtc_state *crtc_state = drm_atomic_get_new_crtc_state(state, crtc);
> diff --git a/drivers/gpu/drm/tegra/dc.c b/drivers/gpu/drm/tegra/dc.c
> index 06370b7e0e5678c7a91f288bc98599503fe9f049..de683644d6587c1b6986a5848739ef16055e1c0e 100644
> --- a/drivers/gpu/drm/tegra/dc.c
> +++ b/drivers/gpu/drm/tegra/dc.c
> @@ -614,11 +614,11 @@ static const u64 tegra124_modifiers[] = {
>   	DRM_FORMAT_MOD_NVIDIA_16BX2_BLOCK(5),
>   	DRM_FORMAT_MOD_INVALID
>   };
>   
>   static int tegra_plane_atomic_check(struct drm_plane *plane,
> -				    struct drm_atomic_state *state)
> +				    struct drm_atomic_commit *state)
>   {
>   	struct drm_plane_state *new_plane_state = drm_atomic_get_new_plane_state(state,
>   										 plane);
>   	struct tegra_plane_state *plane_state = to_tegra_plane_state(new_plane_state);
>   	unsigned int supported_rotation = DRM_MODE_ROTATE_0 |
> @@ -706,11 +706,11 @@ static int tegra_plane_atomic_check(struct drm_plane *plane,
>   
>   	return 0;
>   }
>   
>   static void tegra_plane_atomic_disable(struct drm_plane *plane,
> -				       struct drm_atomic_state *state)
> +				       struct drm_atomic_commit *state)
>   {
>   	struct drm_plane_state *old_state = drm_atomic_get_old_plane_state(state,
>   									   plane);
>   	struct tegra_plane *p = to_tegra_plane(plane);
>   	u32 value;
> @@ -723,11 +723,11 @@ static void tegra_plane_atomic_disable(struct drm_plane *plane,
>   	value &= ~WIN_ENABLE;
>   	tegra_plane_writel(p, value, DC_WIN_WIN_OPTIONS);
>   }
>   
>   static void tegra_plane_atomic_update(struct drm_plane *plane,
> -				      struct drm_atomic_state *state)
> +				      struct drm_atomic_commit *state)
>   {
>   	struct drm_plane_state *new_state = drm_atomic_get_new_plane_state(state,
>   									   plane);
>   	struct tegra_plane_state *tegra_plane_state = to_tegra_plane_state(new_state);
>   	struct drm_framebuffer *fb = new_state->fb;
> @@ -862,11 +862,11 @@ static const u32 tegra_legacy_cursor_plane_formats[] = {
>   static const u32 tegra_cursor_plane_formats[] = {
>   	DRM_FORMAT_ARGB8888,
>   };
>   
>   static int tegra_cursor_atomic_check(struct drm_plane *plane,
> -				     struct drm_atomic_state *state)
> +				     struct drm_atomic_commit *state)
>   {
>   	struct drm_plane_state *new_plane_state = drm_atomic_get_new_plane_state(state,
>   										 plane);
>   	struct tegra_plane_state *plane_state = to_tegra_plane_state(new_plane_state);
>   	struct tegra_plane *tegra = to_tegra_plane(plane);
> @@ -998,19 +998,19 @@ static void __tegra_cursor_atomic_update(struct drm_plane *plane,
>   	value = ((y & tegra->vmask) << 16) | (x & tegra->hmask);
>   	tegra_dc_writel(dc, value, DC_DISP_CURSOR_POSITION);
>   }
>   
>   static void tegra_cursor_atomic_update(struct drm_plane *plane,
> -				       struct drm_atomic_state *state)
> +				       struct drm_atomic_commit *state)
>   {
>   	struct drm_plane_state *new_state = drm_atomic_get_new_plane_state(state, plane);
>   
>   	__tegra_cursor_atomic_update(plane, new_state);
>   }
>   
>   static void tegra_cursor_atomic_disable(struct drm_plane *plane,
> -					struct drm_atomic_state *state)
> +					struct drm_atomic_commit *state)
>   {
>   	struct drm_plane_state *old_state = drm_atomic_get_old_plane_state(state,
>   									   plane);
>   	struct tegra_dc *dc;
>   	u32 value;
> @@ -1024,11 +1024,11 @@ static void tegra_cursor_atomic_disable(struct drm_plane *plane,
>   	value = tegra_dc_readl(dc, DC_DISP_DISP_WIN_OPTIONS);
>   	value &= ~CURSOR_ENABLE;
>   	tegra_dc_writel(dc, value, DC_DISP_DISP_WIN_OPTIONS);
>   }
>   
> -static int tegra_cursor_atomic_async_check(struct drm_plane *plane, struct drm_atomic_state *state,
> +static int tegra_cursor_atomic_async_check(struct drm_plane *plane, struct drm_atomic_commit *state,
>   					   bool flip)
>   {
>   	struct drm_plane_state *new_state = drm_atomic_get_new_plane_state(state, plane);
>   	struct drm_crtc_state *crtc_state;
>   	int min_scale, max_scale;
> @@ -1063,11 +1063,11 @@ static int tegra_cursor_atomic_async_check(struct drm_plane *plane, struct drm_a
>   
>   	return 0;
>   }
>   
>   static void tegra_cursor_atomic_async_update(struct drm_plane *plane,
> -					     struct drm_atomic_state *state)
> +					     struct drm_atomic_commit *state)
>   {
>   	struct drm_plane_state *new_state = drm_atomic_get_new_plane_state(state, plane);
>   	struct tegra_dc *dc = to_tegra_dc(new_state->crtc);
>   
>   	plane->state->src_x = new_state->src_x;
> @@ -1996,11 +1996,11 @@ static int tegra_dc_wait_idle(struct tegra_dc *dc, unsigned long timeout)
>   	return -ETIMEDOUT;
>   }
>   
>   static void
>   tegra_crtc_update_memory_bandwidth(struct drm_crtc *crtc,
> -				   struct drm_atomic_state *state,
> +				   struct drm_atomic_commit *state,
>   				   bool prepare_bandwidth_transition)
>   {
>   	const struct tegra_plane_state *old_tegra_state, *new_tegra_state;
>   	u32 i, new_avg_bw, old_avg_bw, new_peak_bw, old_peak_bw;
>   	const struct drm_plane_state *old_plane_state;
> @@ -2092,11 +2092,11 @@ tegra_crtc_update_memory_bandwidth(struct drm_crtc *crtc,
>   			icc_set_bw(tegra->icc_mem_vfilter, 0, 0);
>   	}
>   }
>   
>   static void tegra_crtc_atomic_disable(struct drm_crtc *crtc,
> -				      struct drm_atomic_state *state)
> +				      struct drm_atomic_commit *state)
>   {
>   	struct tegra_dc *dc = to_tegra_dc(crtc);
>   	u32 value;
>   	int err;
>   
> @@ -2156,11 +2156,11 @@ static void tegra_crtc_atomic_disable(struct drm_crtc *crtc,
>   				"failed to clear power domain state: %d\n", err);
>   	}
>   }
>   
>   static void tegra_crtc_atomic_enable(struct drm_crtc *crtc,
> -				     struct drm_atomic_state *state)
> +				     struct drm_atomic_commit *state)
>   {
>   	struct drm_display_mode *mode = &crtc->state->adjusted_mode;
>   	struct tegra_dc_state *crtc_state = to_dc_state(crtc->state);
>   	struct tegra_dc *dc = to_tegra_dc(crtc);
>   	u32 value;
> @@ -2287,11 +2287,11 @@ static void tegra_crtc_atomic_enable(struct drm_crtc *crtc,
>   
>   	drm_crtc_vblank_on(crtc);
>   }
>   
>   static void tegra_crtc_atomic_begin(struct drm_crtc *crtc,
> -				    struct drm_atomic_state *state)
> +				    struct drm_atomic_commit *state)
>   {
>   	unsigned long flags;
>   
>   	tegra_crtc_update_memory_bandwidth(crtc, state, true);
>   
> @@ -2308,11 +2308,11 @@ static void tegra_crtc_atomic_begin(struct drm_crtc *crtc,
>   		crtc->state->event = NULL;
>   	}
>   }
>   
>   static void tegra_crtc_atomic_flush(struct drm_crtc *crtc,
> -				    struct drm_atomic_state *state)
> +				    struct drm_atomic_commit *state)
>   {
>   	struct drm_crtc_state *crtc_state = drm_atomic_get_new_crtc_state(state,
>   									  crtc);
>   	struct tegra_dc_state *dc_state = to_dc_state(crtc_state);
>   	struct tegra_dc *dc = to_tegra_dc(crtc);
> @@ -2388,11 +2388,11 @@ tegra_plane_overlap_mask(struct drm_crtc_state *state,
>   
>   	return overlap_mask;
>   }
>   
>   static int tegra_crtc_calculate_memory_bandwidth(struct drm_crtc *crtc,
> -						 struct drm_atomic_state *state)
> +						 struct drm_atomic_commit *state)
>   {
>   	ulong overlap_mask[TEGRA_DC_LEGACY_PLANES_NUM] = {}, mask;
>   	u32 plane_peak_bw[TEGRA_DC_LEGACY_PLANES_NUM] = {};
>   	bool all_planes_overlap_simultaneously = true;
>   	const struct tegra_plane_state *tegra_state;
> @@ -2500,11 +2500,11 @@ static int tegra_crtc_calculate_memory_bandwidth(struct drm_crtc *crtc,
>   
>   	return 0;
>   }
>   
>   static int tegra_crtc_atomic_check(struct drm_crtc *crtc,
> -				   struct drm_atomic_state *state)
> +				   struct drm_atomic_commit *state)
>   {
>   	int err;
>   
>   	err = tegra_crtc_calculate_memory_bandwidth(crtc, state);
>   	if (err)
> @@ -2512,11 +2512,11 @@ static int tegra_crtc_atomic_check(struct drm_crtc *crtc,
>   
>   	return 0;
>   }
>   
>   void tegra_crtc_atomic_post_commit(struct drm_crtc *crtc,
> -				   struct drm_atomic_state *state)
> +				   struct drm_atomic_commit *state)
>   {
>   	/*
>   	 * Display bandwidth is allowed to go down only once hardware state
>   	 * is known to be armed, i.e. state was committed and VBLANK event
>   	 * received.
> diff --git a/drivers/gpu/drm/tegra/dc.h b/drivers/gpu/drm/tegra/dc.h
> index 0559fa6b1bf70416e51d5067cc04a6ae6572de23..577c2e8e3ab3b830b4eefad442a3a9c440b4ae53 100644
> --- a/drivers/gpu/drm/tegra/dc.h
> +++ b/drivers/gpu/drm/tegra/dc.h
> @@ -163,11 +163,11 @@ void tegra_dc_commit(struct tegra_dc *dc);
>   int tegra_dc_state_setup_clock(struct tegra_dc *dc,
>   			       struct drm_crtc_state *crtc_state,
>   			       struct clk *clk, unsigned long pclk,
>   			       unsigned int div);
>   void tegra_crtc_atomic_post_commit(struct drm_crtc *crtc,
> -				   struct drm_atomic_state *state);
> +				   struct drm_atomic_commit *state);
>   
>   /* from rgb.c */
>   int tegra_dc_rgb_probe(struct tegra_dc *dc);
>   void tegra_dc_rgb_remove(struct tegra_dc *dc);
>   int tegra_dc_rgb_init(struct drm_device *drm, struct tegra_dc *dc);
> diff --git a/drivers/gpu/drm/tegra/drm.c b/drivers/gpu/drm/tegra/drm.c
> index 1dcef4e7d104c7ef82d93f3458f82aedce325cba..dd6c564ff408bc01ebc16e6075a66df9b8285a8d 100644
> --- a/drivers/gpu/drm/tegra/drm.c
> +++ b/drivers/gpu/drm/tegra/drm.c
> @@ -42,11 +42,11 @@
>   
>   #define CARVEOUT_SZ SZ_64M
>   #define CDMA_GATHER_FETCHES_MAX_NB 16383
>   
>   static int tegra_atomic_check(struct drm_device *drm,
> -			      struct drm_atomic_state *state)
> +			      struct drm_atomic_commit *state)
>   {
>   	int err;
>   
>   	err = drm_atomic_helper_check(drm, state);
>   	if (err < 0)
> @@ -60,21 +60,21 @@ static const struct drm_mode_config_funcs tegra_drm_mode_config_funcs = {
>   	.atomic_check = tegra_atomic_check,
>   	.atomic_commit = drm_atomic_helper_commit,
>   };
>   
>   static void tegra_atomic_post_commit(struct drm_device *drm,
> -				     struct drm_atomic_state *old_state)
> +				     struct drm_atomic_commit *old_state)
>   {
>   	struct drm_crtc_state *old_crtc_state __maybe_unused;
>   	struct drm_crtc *crtc;
>   	unsigned int i;
>   
>   	for_each_old_crtc_in_state(old_state, crtc, old_crtc_state, i)
>   		tegra_crtc_atomic_post_commit(crtc, old_state);
>   }
>   
> -static void tegra_atomic_commit_tail(struct drm_atomic_state *old_state)
> +static void tegra_atomic_commit_tail(struct drm_atomic_commit *old_state)
>   {
>   	struct drm_device *drm = old_state->dev;
>   	struct tegra_drm *tegra = drm->dev_private;
>   
>   	if (tegra->hub) {
> diff --git a/drivers/gpu/drm/tegra/hub.c b/drivers/gpu/drm/tegra/hub.c
> index 10d993b8d043ab08ee65ab4db1e31624c953d0f3..bd442bfd4540763ce6a310f6ecbbef596c9df045 100644
> --- a/drivers/gpu/drm/tegra/hub.c
> +++ b/drivers/gpu/drm/tegra/hub.c
> @@ -422,11 +422,11 @@ static void tegra_dc_remove_shared_plane(struct tegra_dc *dc,
>   {
>   	tegra_shared_plane_set_owner(plane, NULL);
>   }
>   
>   static int tegra_shared_plane_atomic_check(struct drm_plane *plane,
> -					   struct drm_atomic_state *state)
> +					   struct drm_atomic_commit *state)
>   {
>   	struct drm_plane_state *new_plane_state = drm_atomic_get_new_plane_state(state,
>   										 plane);
>   	struct tegra_plane_state *plane_state = to_tegra_plane_state(new_plane_state);
>   	struct tegra_shared_plane *tegra = to_tegra_shared_plane(plane);
> @@ -480,11 +480,11 @@ static int tegra_shared_plane_atomic_check(struct drm_plane *plane,
>   
>   	return 0;
>   }
>   
>   static void tegra_shared_plane_atomic_disable(struct drm_plane *plane,
> -					      struct drm_atomic_state *state)
> +					      struct drm_atomic_commit *state)
>   {
>   	struct drm_plane_state *old_state = drm_atomic_get_old_plane_state(state,
>   									   plane);
>   	struct tegra_plane *p = to_tegra_plane(plane);
>   	struct tegra_dc *dc;
> @@ -530,11 +530,11 @@ static inline u32 compute_phase_incr(fixed20_12 in, unsigned int out)
>   
>   	return lower_32_bits(tmp1);
>   }
>   
>   static void tegra_shared_plane_atomic_update(struct drm_plane *plane,
> -					     struct drm_atomic_state *state)
> +					     struct drm_atomic_commit *state)
>   {
>   	struct drm_plane_state *new_state = drm_atomic_get_new_plane_state(state,
>   									   plane);
>   	struct tegra_plane_state *tegra_plane_state = to_tegra_plane_state(new_state);
>   	struct tegra_dc *dc = to_tegra_dc(new_state->crtc);
> @@ -845,11 +845,11 @@ static const struct drm_private_state_funcs tegra_display_hub_state_funcs = {
>   	.atomic_destroy_state = tegra_display_hub_destroy_state,
>   };
>   
>   static struct tegra_display_hub_state *
>   tegra_display_hub_get_state(struct tegra_display_hub *hub,
> -			    struct drm_atomic_state *state)
> +			    struct drm_atomic_commit *state)
>   {
>   	struct drm_private_state *priv;
>   
>   	priv = drm_atomic_get_private_obj_state(state, &hub->base);
>   	if (IS_ERR(priv))
> @@ -857,11 +857,11 @@ tegra_display_hub_get_state(struct tegra_display_hub *hub,
>   
>   	return to_tegra_display_hub_state(priv);
>   }
>   
>   int tegra_display_hub_atomic_check(struct drm_device *drm,
> -				   struct drm_atomic_state *state)
> +				   struct drm_atomic_commit *state)
>   {
>   	struct tegra_drm *tegra = drm->dev_private;
>   	struct tegra_display_hub_state *hub_state;
>   	struct drm_crtc_state *old, *new;
>   	struct drm_crtc *crtc;
> @@ -923,11 +923,11 @@ static void tegra_display_hub_update(struct tegra_dc *dc)
>   
>   	host1x_client_suspend(&dc->client);
>   }
>   
>   void tegra_display_hub_atomic_commit(struct drm_device *drm,
> -				     struct drm_atomic_state *state)
> +				     struct drm_atomic_commit *state)
>   {
>   	struct tegra_drm *tegra = drm->dev_private;
>   	struct tegra_display_hub *hub = tegra->hub;
>   	struct tegra_display_hub_state *hub_state;
>   	struct device *dev = hub->client.dev;
> diff --git a/drivers/gpu/drm/tegra/hub.h b/drivers/gpu/drm/tegra/hub.h
> index a66f18c4facc9df96ea8b9f54239b52f06536d12..9f3a108f6b59bbda2546f2d9408e6f4d84335d79 100644
> --- a/drivers/gpu/drm/tegra/hub.h
> +++ b/drivers/gpu/drm/tegra/hub.h
> @@ -82,13 +82,13 @@ struct drm_plane *tegra_shared_plane_create(struct drm_device *drm,
>   					    unsigned int wgrp,
>   					    unsigned int index,
>   					    enum drm_plane_type type);
>   
>   int tegra_display_hub_atomic_check(struct drm_device *drm,
> -				   struct drm_atomic_state *state);
> +				   struct drm_atomic_commit *state);
>   void tegra_display_hub_atomic_commit(struct drm_device *drm,
> -				     struct drm_atomic_state *state);
> +				     struct drm_atomic_commit *state);
>   
>   #define DC_CMD_IHUB_COMMON_MISC_CTL 0x068
>   #define  LATENCY_EVENT (1 << 3)
>   
>   #define DC_DISP_IHUB_COMMON_DISPLAY_FETCH_METER 0x451
> diff --git a/drivers/gpu/drm/tests/Makefile b/drivers/gpu/drm/tests/Makefile
> index d2e2e3d8349aee4189209ccfd15039baa1a2f0a9..3b83e6616fb251e13c53d64c7fea49aa1250e0a2 100644
> --- a/drivers/gpu/drm/tests/Makefile
> +++ b/drivers/gpu/drm/tests/Makefile
> @@ -3,11 +3,11 @@
>   obj-$(CONFIG_DRM_KUNIT_TEST_HELPERS) += \
>   	drm_kunit_helpers.o
>   
>   obj-$(CONFIG_DRM_KUNIT_TEST) += \
>   	drm_atomic_test.o \
> -	drm_atomic_state_test.o \
> +	drm_atomic_commit_test.o \
>   	drm_bridge_test.o \
>   	drm_cmdline_parser_test.o \
>   	drm_connector_test.o \
>   	drm_damage_helper_test.o \
>   	drm_dp_mst_helper_test.o \
> diff --git a/drivers/gpu/drm/tests/drm_atomic_state_test.c b/drivers/gpu/drm/tests/drm_atomic_commit_test.c
> similarity index 98%
> rename from drivers/gpu/drm/tests/drm_atomic_state_test.c
> rename to drivers/gpu/drm/tests/drm_atomic_commit_test.c
> index bc27f65b282339dc7de5f450298ce4e5459121c7..ff69bade19b8946617c577c047fe834fb65c22fe 100644
> --- a/drivers/gpu/drm/tests/drm_atomic_state_test.c
> +++ b/drivers/gpu/drm/tests/drm_atomic_commit_test.c
> @@ -1,8 +1,8 @@
>   // SPDX-License-Identifier: GPL-2.0
>   /*
> - * Test cases for the drm_atomic_state helpers
> + * Test cases for the drm_atomic_commit helpers
>    *
>    * Copyright (c) 2024 Qualcomm Innovation Center, Inc. All rights reserved.
>    */
>   
>   #include <drm/drm_atomic.h>
> @@ -144,11 +144,11 @@ static int set_up_atomic_state(struct kunit *test,
>   			       struct drm_connector *connector,
>   			       struct drm_modeset_acquire_ctx *ctx)
>   {
>   	struct drm_device *drm = &priv->drm;
>   	struct drm_crtc *crtc = priv->crtc;
> -	struct drm_atomic_state *state;
> +	struct drm_atomic_commit *state;
>   	struct drm_connector_state *conn_state;
>   	struct drm_crtc_state *crtc_state;
>   	int ret;
>   
>   	state = drm_kunit_helper_atomic_state_alloc(test, drm, ctx);
> @@ -194,11 +194,11 @@ static int set_up_atomic_state(struct kunit *test,
>   static void drm_test_check_connector_changed_modeset(struct kunit *test)
>   {
>   	struct drm_atomic_test_priv *priv;
>   	struct drm_modeset_acquire_ctx ctx;
>   	struct drm_connector *old_conn, *new_conn;
> -	struct drm_atomic_state *state;
> +	struct drm_atomic_commit *state;
>   	struct drm_device *drm;
>   	struct drm_connector_state *new_conn_state, *old_conn_state;
>   	int ret, initial_modeset_count;
>   
>   	priv = drm_atomic_test_init_drm_components(test, true);
> @@ -276,11 +276,11 @@ static void drm_test_check_valid_clones(struct kunit *test)
>   	int ret;
>   	const struct drm_clone_mode_test *param = test->param_value;
>   	struct drm_atomic_test_priv *priv;
>   	struct drm_modeset_acquire_ctx ctx;
>   	struct drm_device *drm;
> -	struct drm_atomic_state *state;
> +	struct drm_atomic_commit *state;
>   	struct drm_crtc_state *crtc_state;
>   
>   	priv = drm_atomic_test_init_drm_components(test, false);
>   	KUNIT_ASSERT_NOT_NULL(test, priv);
>   
> @@ -301,11 +301,11 @@ static void drm_test_check_valid_clones(struct kunit *test)
>   	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, state);
>   
>   retry:
>   	crtc_state = drm_atomic_get_crtc_state(state, priv->crtc);
>   	if (PTR_ERR(crtc_state) == -EDEADLK) {
> -		drm_atomic_state_clear(state);
> +		drm_atomic_commit_clear(state);
>   		ret = drm_modeset_backoff(&ctx);
>   		if (!ret)
>   			goto retry;
>   	}
>   	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, crtc_state);
> @@ -315,11 +315,11 @@ static void drm_test_check_valid_clones(struct kunit *test)
>   	// force modeset
>   	crtc_state->mode_changed = true;
>   
>   	ret = drm_atomic_helper_check_modeset(drm, state);
>   	if (ret == -EDEADLK) {
> -		drm_atomic_state_clear(state);
> +		drm_atomic_commit_clear(state);
>   		ret = drm_modeset_backoff(&ctx);
>   		if (!ret)
>   			goto retry;
>   	}
>   	KUNIT_ASSERT_EQ(test, ret, param->expected_result);
> diff --git a/drivers/gpu/drm/tests/drm_bridge_test.c b/drivers/gpu/drm/tests/drm_bridge_test.c
> index 887020141c7f42b5ae74655f9544c224d3b07605..1f473d70e7e84e304110a240dfe4b8392a3164e2 100644
> --- a/drivers/gpu/drm/tests/drm_bridge_test.c
> +++ b/drivers/gpu/drm/tests/drm_bridge_test.c
> @@ -69,19 +69,19 @@ static const struct drm_bridge_funcs drm_test_bridge_legacy_funcs = {
>   	.enable			= drm_test_bridge_enable,
>   	.disable		= drm_test_bridge_disable,
>   };
>   
>   static void drm_test_bridge_atomic_enable(struct drm_bridge *bridge,
> -					  struct drm_atomic_state *state)
> +					  struct drm_atomic_commit *state)
>   {
>   	struct drm_bridge_priv *priv = bridge_to_priv(bridge);
>   
>   	priv->enable_count++;
>   }
>   
>   static void drm_test_bridge_atomic_disable(struct drm_bridge *bridge,
> -					   struct drm_atomic_state *state)
> +					   struct drm_atomic_commit *state)
>   {
>   	struct drm_bridge_priv *priv = bridge_to_priv(bridge);
>   
>   	priv->disable_count++;
>   }
> @@ -188,11 +188,11 @@ static void drm_test_drm_bridge_get_current_state_atomic(struct kunit *test)
>   {
>   	struct drm_modeset_acquire_ctx ctx;
>   	struct drm_bridge_init_priv *priv;
>   	struct drm_bridge_state *curr_bridge_state;
>   	struct drm_bridge_state *bridge_state;
> -	struct drm_atomic_state *state;
> +	struct drm_atomic_commit *state;
>   	struct drm_bridge *bridge;
>   	struct drm_device *drm;
>   	int ret;
>   
>   	priv = drm_test_bridge_init(test, &drm_test_bridge_atomic_funcs);
> @@ -209,11 +209,11 @@ static void drm_test_drm_bridge_get_current_state_atomic(struct kunit *test)
>   	bridge_state = drm_atomic_get_bridge_state(state, bridge);
>   	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, bridge_state);
>   
>   	ret = drm_atomic_commit(state);
>   	if (ret == -EDEADLK) {
> -		drm_atomic_state_clear(state);
> +		drm_atomic_commit_clear(state);
>   		drm_modeset_backoff(&ctx);
>   		goto retry_commit;
>   	}
>   	KUNIT_ASSERT_EQ(test, ret, 0);
>   
> diff --git a/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c b/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c
> index a4357efaa983dbd10262b4f77fb0581d8d9690c8..c9819c3fc635a7b5cbe6d73f56676694b2619e98 100644
> --- a/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c
> +++ b/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c
> @@ -177,11 +177,11 @@ static const struct drm_connector_funcs dummy_connector_funcs = {
>   	.fill_modes		= drm_helper_probe_single_connector_modes,
>   	.reset			= dummy_hdmi_connector_reset,
>   };
>   
>   static void test_encoder_atomic_enable(struct drm_encoder *encoder,
> -			      struct drm_atomic_state *state)
> +			      struct drm_atomic_commit *state)
>   {
>   	struct drm_atomic_helper_connector_hdmi_priv *priv =
>   		encoder_to_priv(encoder);
>   	int ret;
>   
> @@ -290,11 +290,11 @@ static void drm_test_check_broadcast_rgb_crtc_mode_changed(struct kunit *test)
>   	struct drm_atomic_helper_connector_hdmi_priv *priv;
>   	struct drm_modeset_acquire_ctx ctx;
>   	struct drm_connector_state *old_conn_state;
>   	struct drm_connector_state *new_conn_state;
>   	struct drm_crtc_state *crtc_state;
> -	struct drm_atomic_state *state;
> +	struct drm_atomic_commit *state;
>   	struct drm_display_mode *preferred;
>   	struct drm_connector *conn;
>   	struct drm_device *drm;
>   	struct drm_crtc *crtc;
>   	int ret;
> @@ -365,11 +365,11 @@ static void drm_test_check_broadcast_rgb_crtc_mode_not_changed(struct kunit *tes
>   	struct drm_atomic_helper_connector_hdmi_priv *priv;
>   	struct drm_modeset_acquire_ctx ctx;
>   	struct drm_connector_state *old_conn_state;
>   	struct drm_connector_state *new_conn_state;
>   	struct drm_crtc_state *crtc_state;
> -	struct drm_atomic_state *state;
> +	struct drm_atomic_commit *state;
>   	struct drm_display_mode *preferred;
>   	struct drm_connector *conn;
>   	struct drm_device *drm;
>   	struct drm_crtc *crtc;
>   	int ret;
> @@ -440,11 +440,11 @@ static void drm_test_check_broadcast_rgb_crtc_mode_not_changed(struct kunit *tes
>   static void drm_test_check_broadcast_rgb_auto_cea_mode(struct kunit *test)
>   {
>   	struct drm_atomic_helper_connector_hdmi_priv *priv;
>   	struct drm_modeset_acquire_ctx ctx;
>   	struct drm_connector_state *conn_state;
> -	struct drm_atomic_state *state;
> +	struct drm_atomic_commit *state;
>   	struct drm_display_mode *preferred;
>   	struct drm_connector *conn;
>   	struct drm_device *drm;
>   	struct drm_crtc *crtc;
>   	int ret;
> @@ -507,11 +507,11 @@ static void drm_test_check_broadcast_rgb_auto_cea_mode(struct kunit *test)
>   static void drm_test_check_broadcast_rgb_auto_cea_mode_vic_1(struct kunit *test)
>   {
>   	struct drm_atomic_helper_connector_hdmi_priv *priv;
>   	struct drm_modeset_acquire_ctx ctx;
>   	struct drm_connector_state *conn_state;
> -	struct drm_atomic_state *state;
> +	struct drm_atomic_commit *state;
>   	struct drm_display_mode *mode;
>   	struct drm_connector *conn;
>   	struct drm_device *drm;
>   	struct drm_crtc *crtc;
>   	int ret;
> @@ -574,11 +574,11 @@ static void drm_test_check_broadcast_rgb_auto_cea_mode_vic_1(struct kunit *test)
>   static void drm_test_check_broadcast_rgb_full_cea_mode(struct kunit *test)
>   {
>   	struct drm_atomic_helper_connector_hdmi_priv *priv;
>   	struct drm_modeset_acquire_ctx ctx;
>   	struct drm_connector_state *conn_state;
> -	struct drm_atomic_state *state;
> +	struct drm_atomic_commit *state;
>   	struct drm_display_mode *preferred;
>   	struct drm_connector *conn;
>   	struct drm_device *drm;
>   	struct drm_crtc *crtc;
>   	int ret;
> @@ -643,11 +643,11 @@ static void drm_test_check_broadcast_rgb_full_cea_mode(struct kunit *test)
>   static void drm_test_check_broadcast_rgb_full_cea_mode_vic_1(struct kunit *test)
>   {
>   	struct drm_atomic_helper_connector_hdmi_priv *priv;
>   	struct drm_modeset_acquire_ctx ctx;
>   	struct drm_connector_state *conn_state;
> -	struct drm_atomic_state *state;
> +	struct drm_atomic_commit *state;
>   	struct drm_display_mode *mode;
>   	struct drm_connector *conn;
>   	struct drm_device *drm;
>   	struct drm_crtc *crtc;
>   	int ret;
> @@ -712,11 +712,11 @@ static void drm_test_check_broadcast_rgb_full_cea_mode_vic_1(struct kunit *test)
>   static void drm_test_check_broadcast_rgb_limited_cea_mode(struct kunit *test)
>   {
>   	struct drm_atomic_helper_connector_hdmi_priv *priv;
>   	struct drm_modeset_acquire_ctx ctx;
>   	struct drm_connector_state *conn_state;
> -	struct drm_atomic_state *state;
> +	struct drm_atomic_commit *state;
>   	struct drm_display_mode *preferred;
>   	struct drm_connector *conn;
>   	struct drm_device *drm;
>   	struct drm_crtc *crtc;
>   	int ret;
> @@ -781,11 +781,11 @@ static void drm_test_check_broadcast_rgb_limited_cea_mode(struct kunit *test)
>   static void drm_test_check_broadcast_rgb_limited_cea_mode_vic_1(struct kunit *test)
>   {
>   	struct drm_atomic_helper_connector_hdmi_priv *priv;
>   	struct drm_modeset_acquire_ctx ctx;
>   	struct drm_connector_state *conn_state;
> -	struct drm_atomic_state *state;
> +	struct drm_atomic_commit *state;
>   	struct drm_display_mode *mode;
>   	struct drm_connector *conn;
>   	struct drm_device *drm;
>   	struct drm_crtc *crtc;
>   	int ret;
> @@ -851,11 +851,11 @@ static void drm_test_check_broadcast_rgb_cea_mode_yuv420(struct kunit *test)
>   {
>   	struct drm_atomic_helper_connector_hdmi_priv *priv;
>   	enum drm_hdmi_broadcast_rgb broadcast_rgb;
>   	struct drm_modeset_acquire_ctx ctx;
>   	struct drm_connector_state *conn_state;
> -	struct drm_atomic_state *state;
> +	struct drm_atomic_commit *state;
>   	struct drm_display_mode *mode;
>   	struct drm_connector *conn;
>   	struct drm_device *drm;
>   	struct drm_crtc *crtc;
>   	int ret;
> @@ -894,22 +894,22 @@ static void drm_test_check_broadcast_rgb_cea_mode_yuv420(struct kunit *test)
>   	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, state);
>   
>   retry_conn_state:
>   	conn_state = drm_atomic_get_connector_state(state, conn);
>   	if (PTR_ERR(conn_state) == -EDEADLK) {
> -		drm_atomic_state_clear(state);
> +		drm_atomic_commit_clear(state);
>   		ret = drm_modeset_backoff(&ctx);
>   		if (!ret)
>   			goto retry_conn_state;
>   	}
>   	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, conn_state);
>   
>   	conn_state->hdmi.broadcast_rgb = broadcast_rgb;
>   
>   	ret = drm_atomic_check_only(state);
>   	if (ret == -EDEADLK) {
> -		drm_atomic_state_clear(state);
> +		drm_atomic_commit_clear(state);
>   		ret = drm_modeset_backoff(&ctx);
>   		if (!ret)
>   			goto retry_conn_state;
>   	}
>   	KUNIT_ASSERT_EQ(test, ret, 0);
> @@ -953,11 +953,11 @@ static void drm_test_check_output_bpc_crtc_mode_changed(struct kunit *test)
>   	struct drm_atomic_helper_connector_hdmi_priv *priv;
>   	struct drm_modeset_acquire_ctx ctx;
>   	struct drm_connector_state *old_conn_state;
>   	struct drm_connector_state *new_conn_state;
>   	struct drm_crtc_state *crtc_state;
> -	struct drm_atomic_state *state;
> +	struct drm_atomic_commit *state;
>   	struct drm_display_mode *preferred;
>   	struct drm_connector *conn;
>   	struct drm_device *drm;
>   	struct drm_crtc *crtc;
>   	int ret;
> @@ -1035,11 +1035,11 @@ static void drm_test_check_output_bpc_crtc_mode_not_changed(struct kunit *test)
>   	struct drm_atomic_helper_connector_hdmi_priv *priv;
>   	struct drm_modeset_acquire_ctx ctx;
>   	struct drm_connector_state *old_conn_state;
>   	struct drm_connector_state *new_conn_state;
>   	struct drm_crtc_state *crtc_state;
> -	struct drm_atomic_state *state;
> +	struct drm_atomic_commit *state;
>   	struct drm_display_mode *preferred;
>   	struct drm_connector *conn;
>   	struct drm_device *drm;
>   	struct drm_crtc *crtc;
>   	int ret;
> @@ -1337,11 +1337,11 @@ static void drm_test_check_tmds_char_rate_rgb_12bpc(struct kunit *test)
>    */
>   static void drm_test_check_hdmi_funcs_reject_rate(struct kunit *test)
>   {
>   	struct drm_atomic_helper_connector_hdmi_priv *priv;
>   	struct drm_modeset_acquire_ctx ctx;
> -	struct drm_atomic_state *state;
> +	struct drm_atomic_commit *state;
>   	struct drm_display_mode *preferred;
>   	struct drm_crtc_state *crtc_state;
>   	struct drm_connector *conn;
>   	struct drm_device *drm;
>   	struct drm_crtc *crtc;
> @@ -1704,11 +1704,11 @@ static void drm_test_check_driver_unsupported_fallback_yuv420(struct kunit *test
>   {
>   	struct drm_atomic_helper_connector_hdmi_priv *priv;
>   	struct drm_modeset_acquire_ctx ctx;
>   	struct drm_connector_state *conn_state;
>   	struct drm_crtc_state *crtc_state;
> -	struct drm_atomic_state *state;
> +	struct drm_atomic_commit *state;
>   	struct drm_display_info *info;
>   	struct drm_display_mode *preferred, *yuv420_only_mode;
>   	struct drm_connector *conn;
>   	struct drm_device *drm;
>   	struct drm_crtc *crtc;
> @@ -1756,11 +1756,11 @@ static void drm_test_check_driver_unsupported_fallback_yuv420(struct kunit *test
>   	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, state);
>   
>   retry_crtc_state:
>   	crtc_state = drm_atomic_get_crtc_state(state, crtc);
>   	if (PTR_ERR(crtc_state) == -EDEADLK) {
> -		drm_atomic_state_clear(state);
> +		drm_atomic_commit_clear(state);
>   		ret = drm_modeset_backoff(&ctx);
>   		if (!ret)
>   			goto retry_crtc_state;
>   	}
>   	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, crtc_state);
> @@ -1768,11 +1768,11 @@ static void drm_test_check_driver_unsupported_fallback_yuv420(struct kunit *test
>   	ret = drm_atomic_set_mode_for_crtc(crtc_state, yuv420_only_mode);
>   	KUNIT_EXPECT_EQ(test, ret, 0);
>   
>   	ret = drm_atomic_check_only(state);
>   	if (ret == -EDEADLK) {
> -		drm_atomic_state_clear(state);
> +		drm_atomic_commit_clear(state);
>   		ret = drm_modeset_backoff(&ctx);
>   		if (!ret)
>   			goto retry_crtc_state;
>   	}
>   	KUNIT_ASSERT_LT(test, ret, 0);
> @@ -2140,11 +2140,11 @@ static void drm_test_check_disable_connector(struct kunit *test)
>   {
>   	struct drm_atomic_helper_connector_hdmi_priv *priv;
>   	struct drm_modeset_acquire_ctx ctx;
>   	struct drm_connector_state *conn_state;
>   	struct drm_crtc_state *crtc_state;
> -	struct drm_atomic_state *state;
> +	struct drm_atomic_commit *state;
>   	struct drm_display_mode *preferred;
>   	struct drm_connector *conn;
>   	struct drm_device *drm;
>   	struct drm_crtc *crtc;
>   	int ret;
> @@ -2529,11 +2529,11 @@ static struct kunit_suite drm_atomic_helper_connector_hdmi_mode_valid_test_suite
>   static void drm_test_check_infoframes(struct kunit *test)
>   {
>   	struct drm_atomic_helper_connector_hdmi_priv *priv;
>   	struct drm_modeset_acquire_ctx ctx;
>   	struct drm_crtc_state *crtc_state;
> -	struct drm_atomic_state *state;
> +	struct drm_atomic_commit *state;
>   	struct drm_display_mode *preferred;
>   	struct drm_connector *conn;
>   	struct drm_device *drm;
>   	struct drm_crtc *crtc;
>   	int old_hdmi_update_failures;
> @@ -2571,11 +2571,11 @@ static void drm_test_check_infoframes(struct kunit *test)
>   	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, state);
>   
>   retry_crtc_state:
>   	crtc_state = drm_atomic_get_crtc_state(state, crtc);
>   	if (PTR_ERR(crtc_state) == -EDEADLK) {
> -		drm_atomic_state_clear(state);
> +		drm_atomic_commit_clear(state);
>   		ret = drm_modeset_backoff(&ctx);
>   		if (!ret)
>   			goto retry_crtc_state;
>   	}
>   	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, crtc_state);
> @@ -2584,20 +2584,20 @@ static void drm_test_check_infoframes(struct kunit *test)
>   
>   	old_hdmi_update_failures = priv->hdmi_update_failures;
>   
>   	ret = drm_atomic_check_only(state);
>   	if (ret == -EDEADLK) {
> -		drm_atomic_state_clear(state);
> +		drm_atomic_commit_clear(state);
>   		ret = drm_modeset_backoff(&ctx);
>   		if (!ret)
>   			goto retry_crtc_state;
>   	}
>   	KUNIT_ASSERT_EQ(test, ret, 0);
>   
>   	ret = drm_atomic_commit(state);
>   	if (ret == -EDEADLK) {
> -		drm_atomic_state_clear(state);
> +		drm_atomic_commit_clear(state);
>   		ret = drm_modeset_backoff(&ctx);
>   		if (!ret)
>   			goto retry_crtc_state;
>   	}
>   	KUNIT_ASSERT_EQ(test, ret, 0);
> @@ -2631,11 +2631,11 @@ static const struct drm_connector_hdmi_funcs reject_avi_infoframe_hdmi_funcs = {
>    */
>   static void drm_test_check_reject_avi_infoframe(struct kunit *test)
>   {
>   	struct drm_atomic_helper_connector_hdmi_priv *priv;
>   	struct drm_modeset_acquire_ctx ctx;
> -	struct drm_atomic_state *state;
> +	struct drm_atomic_commit *state;
>   	struct drm_crtc_state *crtc_state;
>   	struct drm_display_mode *preferred;
>   	struct drm_connector *conn;
>   	struct drm_device *drm;
>   	struct drm_crtc *crtc;
> @@ -2676,11 +2676,11 @@ static void drm_test_check_reject_avi_infoframe(struct kunit *test)
>   	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, state);
>   
>   retry_crtc_state:
>   	crtc_state = drm_atomic_get_crtc_state(state, crtc);
>   	if (PTR_ERR(crtc_state) == -EDEADLK) {
> -		drm_atomic_state_clear(state);
> +		drm_atomic_commit_clear(state);
>   		ret = drm_modeset_backoff(&ctx);
>   		if (!ret)
>   			goto retry_crtc_state;
>   	}
>   	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, crtc_state);
> @@ -2689,20 +2689,20 @@ static void drm_test_check_reject_avi_infoframe(struct kunit *test)
>   
>   	old_hdmi_update_failures = priv->hdmi_update_failures;
>   
>   	ret = drm_atomic_check_only(state);
>   	if (ret == -EDEADLK) {
> -		drm_atomic_state_clear(state);
> +		drm_atomic_commit_clear(state);
>   		ret = drm_modeset_backoff(&ctx);
>   		if (!ret)
>   			goto retry_crtc_state;
>   	}
>   	KUNIT_ASSERT_EQ(test, ret, 0);
>   
>   	ret = drm_atomic_commit(state);
>   	if (ret == -EDEADLK) {
> -		drm_atomic_state_clear(state);
> +		drm_atomic_commit_clear(state);
>   		ret = drm_modeset_backoff(&ctx);
>   		if (!ret)
>   			goto retry_crtc_state;
>   	}
>   	KUNIT_ASSERT_EQ(test, ret, 0);
> @@ -2734,11 +2734,11 @@ static const struct drm_connector_hdmi_funcs reject_hdr_infoframe_hdmi_funcs = {
>    */
>   static void drm_test_check_reject_hdr_infoframe_bpc_8(struct kunit *test)
>   {
>   	struct drm_atomic_helper_connector_hdmi_priv *priv;
>   	struct drm_modeset_acquire_ctx ctx;
> -	struct drm_atomic_state *state;
> +	struct drm_atomic_commit *state;
>   	struct drm_connector_state *new_conn_state;
>   	struct drm_crtc_state *crtc_state;
>   	struct drm_display_mode *preferred;
>   	struct drm_connector *conn;
>   	struct drm_device *drm;
> @@ -2780,20 +2780,20 @@ static void drm_test_check_reject_hdr_infoframe_bpc_8(struct kunit *test)
>   	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, state);
>   
>   retry_conn_state:
>   	new_conn_state = drm_atomic_get_connector_state(state, conn);
>   	if (PTR_ERR(new_conn_state) == -EDEADLK) {
> -		drm_atomic_state_clear(state);
> +		drm_atomic_commit_clear(state);
>   		ret = drm_modeset_backoff(&ctx);
>   		if (!ret)
>   			goto retry_conn_state;
>   	}
>   	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, new_conn_state);
>   
>   	crtc_state = drm_atomic_get_crtc_state(state, crtc);
>   	if (PTR_ERR(crtc_state) == -EDEADLK) {
> -		drm_atomic_state_clear(state);
> +		drm_atomic_commit_clear(state);
>   		ret = drm_modeset_backoff(&ctx);
>   		if (!ret)
>   			goto retry_conn_state;
>   	}
>   	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, crtc_state);
> @@ -2808,20 +2808,20 @@ static void drm_test_check_reject_hdr_infoframe_bpc_8(struct kunit *test)
>   
>   	old_hdmi_update_failures = priv->hdmi_update_failures;
>   
>   	ret = drm_atomic_check_only(state);
>   	if (ret == -EDEADLK) {
> -		drm_atomic_state_clear(state);
> +		drm_atomic_commit_clear(state);
>   		ret = drm_modeset_backoff(&ctx);
>   		if (!ret)
>   			goto retry_conn_state;
>   	}
>   	KUNIT_ASSERT_EQ(test, ret, 0);
>   
>   	ret = drm_atomic_commit(state);
>   	if (ret == -EDEADLK) {
> -		drm_atomic_state_clear(state);
> +		drm_atomic_commit_clear(state);
>   		ret = drm_modeset_backoff(&ctx);
>   		if (!ret)
>   			goto retry_conn_state;
>   	}
>   	KUNIT_ASSERT_EQ(test, ret, 0);
> @@ -2845,11 +2845,11 @@ static void drm_test_check_reject_hdr_infoframe_bpc_8(struct kunit *test)
>    */
>   static void drm_test_check_reject_hdr_infoframe_bpc_10(struct kunit *test)
>   {
>   	struct drm_atomic_helper_connector_hdmi_priv *priv;
>   	struct drm_modeset_acquire_ctx ctx;
> -	struct drm_atomic_state *state;
> +	struct drm_atomic_commit *state;
>   	struct drm_connector_state *new_conn_state;
>   	struct drm_crtc_state *crtc_state;
>   	struct drm_display_mode *preferred;
>   	struct drm_connector *conn;
>   	struct drm_device *drm;
> @@ -2894,20 +2894,20 @@ static void drm_test_check_reject_hdr_infoframe_bpc_10(struct kunit *test)
>   	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, state);
>   
>   retry_conn_state:
>   	new_conn_state = drm_atomic_get_connector_state(state, conn);
>   	if (PTR_ERR(new_conn_state) == -EDEADLK) {
> -		drm_atomic_state_clear(state);
> +		drm_atomic_commit_clear(state);
>   		ret = drm_modeset_backoff(&ctx);
>   		if (!ret)
>   			goto retry_conn_state;
>   	}
>   	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, new_conn_state);
>   
>   	crtc_state = drm_atomic_get_crtc_state(state, crtc);
>   	if (PTR_ERR(crtc_state) == -EDEADLK) {
> -		drm_atomic_state_clear(state);
> +		drm_atomic_commit_clear(state);
>   		ret = drm_modeset_backoff(&ctx);
>   		if (!ret)
>   			goto retry_conn_state;
>   	}
>   	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, crtc_state);
> @@ -2931,20 +2931,20 @@ static void drm_test_check_reject_hdr_infoframe_bpc_10(struct kunit *test)
>   
>   	old_hdmi_update_failures = priv->hdmi_update_failures;
>   
>   	ret = drm_atomic_check_only(state);
>   	if (ret == -EDEADLK) {
> -		drm_atomic_state_clear(state);
> +		drm_atomic_commit_clear(state);
>   		ret = drm_modeset_backoff(&ctx);
>   		if (!ret)
>   			goto retry_conn_state;
>   	}
>   	KUNIT_ASSERT_EQ(test, ret, 0);
>   
>   	ret = drm_atomic_commit(state);
>   	if (ret == -EDEADLK) {
> -		drm_atomic_state_clear(state);
> +		drm_atomic_commit_clear(state);
>   		ret = drm_modeset_backoff(&ctx);
>   		if (!ret)
>   			goto retry_conn_state;
>   	}
>   	KUNIT_ASSERT_EQ(test, ret, 0);
> @@ -2983,11 +2983,11 @@ static const struct drm_connector_hdmi_funcs reject_audio_infoframe_hdmi_funcs =
>    */
>   static void drm_test_check_reject_audio_infoframe(struct kunit *test)
>   {
>   	struct drm_atomic_helper_connector_hdmi_priv *priv;
>   	struct drm_modeset_acquire_ctx ctx;
> -	struct drm_atomic_state *state;
> +	struct drm_atomic_commit *state;
>   	struct drm_crtc_state *crtc_state;
>   	struct drm_display_mode *preferred;
>   	struct drm_connector *conn;
>   	struct drm_device *drm;
>   	struct drm_crtc *crtc;
> @@ -3029,11 +3029,11 @@ static void drm_test_check_reject_audio_infoframe(struct kunit *test)
>   	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, state);
>   
>   retry_crtc_state:
>   	crtc_state = drm_atomic_get_crtc_state(state, crtc);
>   	if (PTR_ERR(crtc_state) == -EDEADLK) {
> -		drm_atomic_state_clear(state);
> +		drm_atomic_commit_clear(state);
>   		ret = drm_modeset_backoff(&ctx);
>   		if (!ret)
>   			goto retry_crtc_state;
>   	}
>   	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, crtc_state);
> @@ -3042,20 +3042,20 @@ static void drm_test_check_reject_audio_infoframe(struct kunit *test)
>   
>   	old_hdmi_update_failures = priv->hdmi_update_failures;
>   
>   	ret = drm_atomic_check_only(state);
>   	if (ret == -EDEADLK) {
> -		drm_atomic_state_clear(state);
> +		drm_atomic_commit_clear(state);
>   		ret = drm_modeset_backoff(&ctx);
>   		if (!ret)
>   			goto retry_crtc_state;
>   	}
>   	KUNIT_ASSERT_EQ(test, ret, 0);
>   
>   	ret = drm_atomic_commit(state);
>   	if (ret == -EDEADLK) {
> -		drm_atomic_state_clear(state);
> +		drm_atomic_commit_clear(state);
>   		ret = drm_modeset_backoff(&ctx);
>   		if (!ret)
>   			goto retry_crtc_state;
>   	}
>   	KUNIT_ASSERT_EQ(test, ret, 0);
> @@ -3080,11 +3080,11 @@ static void drm_test_check_reject_audio_infoframe(struct kunit *test)
>   	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, state);
>   
>   retry_crtc_state_2:
>   	crtc_state = drm_atomic_get_crtc_state(state, crtc);
>   	if (PTR_ERR(crtc_state) == -EDEADLK) {
> -		drm_atomic_state_clear(state);
> +		drm_atomic_commit_clear(state);
>   		ret = drm_modeset_backoff(&ctx);
>   		if (!ret)
>   			goto retry_crtc_state_2;
>   	}
>   	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, crtc_state);
> @@ -3093,20 +3093,20 @@ static void drm_test_check_reject_audio_infoframe(struct kunit *test)
>   
>   	old_hdmi_update_failures = priv->hdmi_update_failures;
>   
>   	ret = drm_atomic_check_only(state);
>   	if (ret == -EDEADLK) {
> -		drm_atomic_state_clear(state);
> +		drm_atomic_commit_clear(state);
>   		ret = drm_modeset_backoff(&ctx);
>   		if (!ret)
>   			goto retry_crtc_state_2;
>   	}
>   	KUNIT_ASSERT_EQ(test, ret, 0);
>   
>   	ret = drm_atomic_commit(state);
>   	if (ret == -EDEADLK) {
> -		drm_atomic_state_clear(state);
> +		drm_atomic_commit_clear(state);
>   		ret = drm_modeset_backoff(&ctx);
>   		if (!ret)
>   			goto retry_crtc_state_2;
>   	}
>   	KUNIT_ASSERT_EQ(test, ret, 0);
> diff --git a/drivers/gpu/drm/tests/drm_kunit_helpers.c b/drivers/gpu/drm/tests/drm_kunit_helpers.c
> index 04edb6079c0d4ad40b2487eed99c1fd378c840b8..727766444d63844a2667db24e7573cfc75565256 100644
> --- a/drivers/gpu/drm/tests/drm_kunit_helpers.c
> +++ b/drivers/gpu/drm/tests/drm_kunit_helpers.c
> @@ -80,15 +80,15 @@ __drm_kunit_helper_alloc_drm_device_with_driver(struct kunit *test,
>   
>   	return drm;
>   }
>   EXPORT_SYMBOL_GPL(__drm_kunit_helper_alloc_drm_device_with_driver);
>   
> -static void kunit_action_drm_atomic_state_put(void *ptr)
> +static void kunit_action_drm_atomic_commit_put(void *ptr)
>   {
> -	struct drm_atomic_state *state = ptr;
> +	struct drm_atomic_commit *state = ptr;
>   
> -	drm_atomic_state_put(state);
> +	drm_atomic_commit_put(state);
>   }
>   
>   /**
>    * drm_kunit_helper_atomic_state_alloc - Allocates an atomic state
>    * @test: The test context object
> @@ -96,29 +96,29 @@ static void kunit_action_drm_atomic_state_put(void *ptr)
>    * @ctx: Locking context for that atomic update
>    *
>    * Allocates a empty atomic state.
>    *
>    * The state is tied to the kunit test context, so we must not call
> - * drm_atomic_state_put() on it, it will be done so automatically.
> + * drm_atomic_commit_put() on it, it will be done so automatically.
>    *
>    * Returns:
>    * An ERR_PTR on error, a pointer to the newly allocated state otherwise
>    */
> -struct drm_atomic_state *
> +struct drm_atomic_commit *
>   drm_kunit_helper_atomic_state_alloc(struct kunit *test,
>   				    struct drm_device *drm,
>   				    struct drm_modeset_acquire_ctx *ctx)
>   {
> -	struct drm_atomic_state *state;
> +	struct drm_atomic_commit *state;
>   	int ret;
>   
> -	state = drm_atomic_state_alloc(drm);
> +	state = drm_atomic_commit_alloc(drm);
>   	if (!state)
>   		return ERR_PTR(-ENOMEM);
>   
>   	ret = kunit_add_action_or_reset(test,
> -					kunit_action_drm_atomic_state_put,
> +					kunit_action_drm_atomic_commit_put,
>   					state);
>   	if (ret)
>   		return ERR_PTR(ret);
>   
>   	state->acquire_ctx = ctx;
> @@ -295,11 +295,11 @@ int drm_kunit_helper_enable_crtc_connector(struct kunit *test,
>   					   struct drm_crtc *crtc,
>   					   struct drm_connector *connector,
>   					   const struct drm_display_mode *mode,
>   					   struct drm_modeset_acquire_ctx *ctx)
>   {
> -	struct drm_atomic_state *state;
> +	struct drm_atomic_commit *state;
>   	struct drm_connector_state *conn_state;
>   	struct drm_crtc_state *crtc_state;
>   	int ret;
>   
>   	state = drm_kunit_helper_atomic_state_alloc(test, drm, ctx);
> diff --git a/drivers/gpu/drm/tidss/tidss_crtc.c b/drivers/gpu/drm/tidss/tidss_crtc.c
> index a31c21c5f855ac8a94089dd3908e2510193b7d67..acab9307bdf310e9d6227d31301a6525f5b25d5c 100644
> --- a/drivers/gpu/drm/tidss/tidss_crtc.c
> +++ b/drivers/gpu/drm/tidss/tidss_crtc.c
> @@ -81,11 +81,11 @@ void tidss_crtc_error_irq(struct drm_crtc *crtc, u64 irqstatus)
>   }
>   
>   /* drm_crtc_helper_funcs */
>   
>   static int tidss_crtc_atomic_check(struct drm_crtc *crtc,
> -				   struct drm_atomic_state *state)
> +				   struct drm_atomic_commit *state)
>   {
>   	struct drm_crtc_state *crtc_state = drm_atomic_get_new_crtc_state(state,
>   									  crtc);
>   	struct drm_device *ddev = crtc->dev;
>   	struct tidss_device *tidss = to_tidss(ddev);
> @@ -121,11 +121,11 @@ static int tidss_crtc_atomic_check(struct drm_crtc *crtc,
>   static void tidss_crtc_position_planes(struct tidss_device *tidss,
>   				       struct drm_crtc *crtc,
>   				       struct drm_crtc_state *old_state,
>   				       bool newmodeset)
>   {
> -	struct drm_atomic_state *ostate = old_state->state;
> +	struct drm_atomic_commit *ostate = old_state->state;
>   	struct tidss_crtc *tcrtc = to_tidss_crtc(crtc);
>   	struct drm_crtc_state *cstate = crtc->state;
>   	int layer;
>   
>   	if (!newmodeset && !cstate->zpos_changed &&
> @@ -160,11 +160,11 @@ static void tidss_crtc_position_planes(struct tidss_device *tidss,
>   				       layer_active);
>   	}
>   }
>   
>   static void tidss_crtc_atomic_flush(struct drm_crtc *crtc,
> -				    struct drm_atomic_state *state)
> +				    struct drm_atomic_commit *state)
>   {
>   	struct drm_crtc_state *old_crtc_state = drm_atomic_get_old_crtc_state(state,
>   									      crtc);
>   	struct tidss_crtc *tcrtc = to_tidss_crtc(crtc);
>   	struct drm_device *ddev = crtc->dev;
> @@ -209,11 +209,11 @@ static void tidss_crtc_atomic_flush(struct drm_crtc *crtc,
>   
>   	spin_unlock_irqrestore(&ddev->event_lock, flags);
>   }
>   
>   static void tidss_crtc_atomic_enable(struct drm_crtc *crtc,
> -				     struct drm_atomic_state *state)
> +				     struct drm_atomic_commit *state)
>   {
>   	struct drm_crtc_state *old_state = drm_atomic_get_old_crtc_state(state,
>   									 crtc);
>   	struct tidss_crtc *tcrtc = to_tidss_crtc(crtc);
>   	struct drm_device *ddev = crtc->dev;
> @@ -258,11 +258,11 @@ static void tidss_crtc_atomic_enable(struct drm_crtc *crtc,
>   
>   	spin_unlock_irqrestore(&ddev->event_lock, flags);
>   }
>   
>   static void tidss_crtc_atomic_disable(struct drm_crtc *crtc,
> -				      struct drm_atomic_state *state)
> +				      struct drm_atomic_commit *state)
>   {
>   	struct tidss_crtc *tcrtc = to_tidss_crtc(crtc);
>   	struct drm_device *ddev = crtc->dev;
>   	struct tidss_device *tidss = to_tidss(ddev);
>   	unsigned long flags;
> diff --git a/drivers/gpu/drm/tidss/tidss_kms.c b/drivers/gpu/drm/tidss/tidss_kms.c
> index 8bb93194e5ac686050c47f986b8cb6063eae22d3..533084d4fac1528bfca5e24ad7ceb981577f98a4 100644
> --- a/drivers/gpu/drm/tidss/tidss_kms.c
> +++ b/drivers/gpu/drm/tidss/tidss_kms.c
> @@ -17,11 +17,11 @@
>   #include "tidss_drv.h"
>   #include "tidss_encoder.h"
>   #include "tidss_kms.h"
>   #include "tidss_plane.h"
>   
> -static void tidss_atomic_commit_tail(struct drm_atomic_state *old_state)
> +static void tidss_atomic_commit_tail(struct drm_atomic_commit *old_state)
>   {
>   	struct drm_device *ddev = old_state->dev;
>   	struct tidss_device *tidss = to_tidss(ddev);
>   
>   	tidss_runtime_get(tidss);
> @@ -65,11 +65,11 @@ static void tidss_atomic_commit_tail(struct drm_atomic_state *old_state)
>   static const struct drm_mode_config_helper_funcs mode_config_helper_funcs = {
>   	.atomic_commit_tail = tidss_atomic_commit_tail,
>   };
>   
>   static int tidss_atomic_check(struct drm_device *ddev,
> -			      struct drm_atomic_state *state)
> +			      struct drm_atomic_commit *state)
>   {
>   	struct drm_plane_state *opstate;
>   	struct drm_plane_state *npstate;
>   	struct drm_plane *plane;
>   	struct drm_crtc_state *cstate;
> diff --git a/drivers/gpu/drm/tidss/tidss_oldi.c b/drivers/gpu/drm/tidss/tidss_oldi.c
> index 17c535bfa05765ad9ff774b259e35a1cb377f047..9c9725aac82906c954ad0e9a9275aef342fe70cc 100644
> --- a/drivers/gpu/drm/tidss/tidss_oldi.c
> +++ b/drivers/gpu/drm/tidss/tidss_oldi.c
> @@ -219,11 +219,11 @@ static int tidss_oldi_config(struct tidss_oldi *oldi)
>   
>   	return ret;
>   }
>   
>   static void tidss_oldi_atomic_pre_enable(struct drm_bridge *bridge,
> -					 struct drm_atomic_state *state)
> +					 struct drm_atomic_commit *state)
>   {
>   	struct tidss_oldi *oldi = drm_bridge_to_tidss_oldi(bridge);
>   	struct drm_connector *connector;
>   	struct drm_connector_state *conn_state;
>   	struct drm_crtc_state *crtc_state;
> @@ -256,11 +256,11 @@ static void tidss_oldi_atomic_pre_enable(struct drm_bridge *bridge,
>   	/* Enable OLDI IO power */
>   	tidss_oldi_tx_power(oldi, true);
>   }
>   
>   static void tidss_oldi_atomic_post_disable(struct drm_bridge *bridge,
> -					   struct drm_atomic_state *state)
> +					   struct drm_atomic_commit *state)
>   {
>   	struct tidss_oldi *oldi = drm_bridge_to_tidss_oldi(bridge);
>   
>   	if (oldi->link_type == OLDI_MODE_SECONDARY_CLONE_SINGLE_LINK)
>   		return;
> diff --git a/drivers/gpu/drm/tidss/tidss_plane.c b/drivers/gpu/drm/tidss/tidss_plane.c
> index aaa02c851c595aa3781ec2e6741af1999092aa40..1a8b44fb45f8f6d6ae0402758f1fb6c817310adc 100644
> --- a/drivers/gpu/drm/tidss/tidss_plane.c
> +++ b/drivers/gpu/drm/tidss/tidss_plane.c
> @@ -27,11 +27,11 @@ void tidss_plane_error_irq(struct drm_plane *plane, u64 irqstatus)
>   }
>   
>   /* drm_plane_helper_funcs */
>   
>   static int tidss_plane_atomic_check(struct drm_plane *plane,
> -				    struct drm_atomic_state *state)
> +				    struct drm_atomic_commit *state)
>   {
>   	struct drm_plane_state *new_plane_state = drm_atomic_get_new_plane_state(state,
>   										 plane);
>   	struct drm_device *ddev = plane->dev;
>   	struct tidss_device *tidss = to_tidss(ddev);
> @@ -111,11 +111,11 @@ static int tidss_plane_atomic_check(struct drm_plane *plane,
>   
>   	return 0;
>   }
>   
>   static void tidss_plane_atomic_update(struct drm_plane *plane,
> -				      struct drm_atomic_state *state)
> +				      struct drm_atomic_commit *state)
>   {
>   	struct drm_device *ddev = plane->dev;
>   	struct tidss_device *tidss = to_tidss(ddev);
>   	struct tidss_plane *tplane = to_tidss_plane(plane);
>   	struct drm_plane_state *new_state = drm_atomic_get_new_plane_state(state,
> @@ -131,21 +131,21 @@ static void tidss_plane_atomic_update(struct drm_plane *plane,
>   
>   	dispc_plane_setup(tidss->dispc, tplane->hw_plane_id, new_state, hw_videoport);
>   }
>   
>   static void tidss_plane_atomic_enable(struct drm_plane *plane,
> -				      struct drm_atomic_state *state)
> +				      struct drm_atomic_commit *state)
>   {
>   	struct drm_device *ddev = plane->dev;
>   	struct tidss_device *tidss = to_tidss(ddev);
>   	struct tidss_plane *tplane = to_tidss_plane(plane);
>   
>   	dispc_plane_enable(tidss->dispc, tplane->hw_plane_id, true);
>   }
>   
>   static void tidss_plane_atomic_disable(struct drm_plane *plane,
> -				       struct drm_atomic_state *state)
> +				       struct drm_atomic_commit *state)
>   {
>   	struct drm_device *ddev = plane->dev;
>   	struct tidss_device *tidss = to_tidss(ddev);
>   	struct tidss_plane *tplane = to_tidss_plane(plane);
>   
> diff --git a/drivers/gpu/drm/tilcdc/tilcdc_crtc.c b/drivers/gpu/drm/tilcdc/tilcdc_crtc.c
> index 4d3b7059cd5b260d5eb8ad5297526b19a23d22b3..6e885eb912c1ed0470aba21ed51e29602db82e25 100644
> --- a/drivers/gpu/drm/tilcdc/tilcdc_crtc.c
> +++ b/drivers/gpu/drm/tilcdc/tilcdc_crtc.c
> @@ -451,11 +451,11 @@ static void tilcdc_crtc_enable(struct drm_crtc *crtc)
>   	tilcdc_crtc->enabled = true;
>   	mutex_unlock(&tilcdc_crtc->enable_lock);
>   }
>   
>   static void tilcdc_crtc_atomic_enable(struct drm_crtc *crtc,
> -				      struct drm_atomic_state *state)
> +				      struct drm_atomic_commit *state)
>   {
>   	tilcdc_crtc_enable(crtc);
>   }
>   
>   static void tilcdc_crtc_off(struct drm_crtc *crtc, bool shutdown)
> @@ -508,17 +508,17 @@ static void tilcdc_crtc_disable(struct drm_crtc *crtc)
>   {
>   	tilcdc_crtc_off(crtc, false);
>   }
>   
>   static void tilcdc_crtc_atomic_disable(struct drm_crtc *crtc,
> -				       struct drm_atomic_state *state)
> +				       struct drm_atomic_commit *state)
>   {
>   	tilcdc_crtc_disable(crtc);
>   }
>   
>   static void tilcdc_crtc_atomic_flush(struct drm_crtc *crtc,
> -				     struct drm_atomic_state *state)
> +				     struct drm_atomic_commit *state)
>   {
>   	if (!crtc->state->event)
>   		return;
>   
>   	spin_lock_irq(&crtc->dev->event_lock);
> @@ -630,11 +630,11 @@ static bool tilcdc_crtc_mode_fixup(struct drm_crtc *crtc,
>   
>   	return true;
>   }
>   
>   static int tilcdc_crtc_atomic_check(struct drm_crtc *crtc,
> -				    struct drm_atomic_state *state)
> +				    struct drm_atomic_commit *state)
>   {
>   	struct drm_crtc_state *crtc_state = drm_atomic_get_new_crtc_state(state,
>   									  crtc);
>   	/* If we are not active we don't care */
>   	if (!crtc_state->active)
> diff --git a/drivers/gpu/drm/tilcdc/tilcdc_drv.c b/drivers/gpu/drm/tilcdc/tilcdc_drv.c
> index c877b2be9c2ec8841532430eb5745dece1d54489..e7f675c15c20c1ec910f361243fb974351c72471 100644
> --- a/drivers/gpu/drm/tilcdc/tilcdc_drv.c
> +++ b/drivers/gpu/drm/tilcdc/tilcdc_drv.c
> @@ -47,11 +47,11 @@ static const u32 tilcdc_crossed_formats[] = { DRM_FORMAT_BGR565,
>   static const u32 tilcdc_legacy_formats[] = { DRM_FORMAT_RGB565,
>   					     DRM_FORMAT_RGB888,
>   					     DRM_FORMAT_XRGB8888 };
>   
>   static int tilcdc_atomic_check(struct drm_device *dev,
> -			       struct drm_atomic_state *state)
> +			       struct drm_atomic_commit *state)
>   {
>   	int ret;
>   
>   	ret = drm_atomic_helper_check_modeset(dev, state);
>   	if (ret)
> diff --git a/drivers/gpu/drm/tilcdc/tilcdc_plane.c b/drivers/gpu/drm/tilcdc/tilcdc_plane.c
> index a9982a9956903c4d8ffcfddb6127f38f1cd45558..d2678af5dc22c41c65d8c7092b886e635fa01e78 100644
> --- a/drivers/gpu/drm/tilcdc/tilcdc_plane.c
> +++ b/drivers/gpu/drm/tilcdc/tilcdc_plane.c
> @@ -18,11 +18,11 @@ static const struct drm_plane_funcs tilcdc_plane_funcs = {
>   	.atomic_duplicate_state = drm_atomic_helper_plane_duplicate_state,
>   	.atomic_destroy_state = drm_atomic_helper_plane_destroy_state,
>   };
>   
>   static int tilcdc_plane_atomic_check(struct drm_plane *plane,
> -				     struct drm_atomic_state *state)
> +				     struct drm_atomic_commit *state)
>   {
>   	struct drm_plane_state *new_state = drm_atomic_get_new_plane_state(state,
>   									   plane);
>   	struct drm_crtc_state *crtc_state;
>   	struct drm_plane_state *old_state = drm_atomic_get_old_plane_state(state,
> @@ -72,11 +72,11 @@ static int tilcdc_plane_atomic_check(struct drm_plane *plane,
>   
>   	return 0;
>   }
>   
>   static void tilcdc_plane_atomic_update(struct drm_plane *plane,
> -				       struct drm_atomic_state *state)
> +				       struct drm_atomic_commit *state)
>   {
>   	struct drm_plane_state *new_state = drm_atomic_get_new_plane_state(state,
>   									   plane);
>   
>   	if (!new_state->crtc)
> diff --git a/drivers/gpu/drm/tiny/appletbdrm.c b/drivers/gpu/drm/tiny/appletbdrm.c
> index 3bae91d7eefed706fb6305b7a8053a8c9d03952a..d9ee3c6e146514b4ded169f0fbed92a3030bc802 100644
> --- a/drivers/gpu/drm/tiny/appletbdrm.c
> +++ b/drivers/gpu/drm/tiny/appletbdrm.c
> @@ -314,11 +314,11 @@ static const u32 appletbdrm_primary_plane_formats[] = {
>   	DRM_FORMAT_BGR888,
>   	DRM_FORMAT_XRGB8888, /* emulated */
>   };
>   
>   static int appletbdrm_primary_plane_helper_atomic_check(struct drm_plane *plane,
> -						   struct drm_atomic_state *state)
> +						   struct drm_atomic_commit *state)
>   {
>   	struct drm_plane_state *new_plane_state = drm_atomic_get_new_plane_state(state, plane);
>   	struct drm_plane_state *old_plane_state = drm_atomic_get_old_plane_state(state, plane);
>   	struct drm_crtc *new_crtc = new_plane_state->crtc;
>   	struct drm_crtc_state *new_crtc_state = NULL;
> @@ -466,11 +466,11 @@ static int appletbdrm_flush_damage(struct appletbdrm_device *adev,
>   
>   	return ret;
>   }
>   
>   static void appletbdrm_primary_plane_helper_atomic_update(struct drm_plane *plane,
> -						     struct drm_atomic_state *old_state)
> +						     struct drm_atomic_commit *old_state)
>   {
>   	struct appletbdrm_device *adev = drm_to_adev(plane->dev);
>   	struct drm_device *drm = plane->dev;
>   	struct drm_plane_state *plane_state = plane->state;
>   	struct drm_plane_state *old_plane_state = drm_atomic_get_old_plane_state(old_state, plane);
> @@ -483,11 +483,11 @@ static void appletbdrm_primary_plane_helper_atomic_update(struct drm_plane *plan
>   
>   	drm_dev_exit(idx);
>   }
>   
>   static void appletbdrm_primary_plane_helper_atomic_disable(struct drm_plane *plane,
> -							   struct drm_atomic_state *state)
> +							   struct drm_atomic_commit *state)
>   {
>   	struct drm_device *dev = plane->dev;
>   	struct appletbdrm_device *adev = drm_to_adev(dev);
>   	int idx;
>   
> diff --git a/drivers/gpu/drm/tiny/bochs.c b/drivers/gpu/drm/tiny/bochs.c
> index 222e4ae1abbd14e32554085ec75d55655ab0ae60..376465b79b06953d6cef5ec3151fee60b5433f8d 100644
> --- a/drivers/gpu/drm/tiny/bochs.c
> +++ b/drivers/gpu/drm/tiny/bochs.c
> @@ -417,11 +417,11 @@ static const uint32_t bochs_primary_plane_formats[] = {
>   	DRM_FORMAT_XRGB8888,
>   	DRM_FORMAT_BGRX8888,
>   };
>   
>   static int bochs_primary_plane_helper_atomic_check(struct drm_plane *plane,
> -						   struct drm_atomic_state *state)
> +						   struct drm_atomic_commit *state)
>   {
>   	struct drm_plane_state *new_plane_state = drm_atomic_get_new_plane_state(state, plane);
>   	struct drm_crtc *new_crtc = new_plane_state->crtc;
>   	struct drm_crtc_state *new_crtc_state = NULL;
>   	int ret;
> @@ -440,11 +440,11 @@ static int bochs_primary_plane_helper_atomic_check(struct drm_plane *plane,
>   
>   	return 0;
>   }
>   
>   static void bochs_primary_plane_helper_atomic_update(struct drm_plane *plane,
> -						     struct drm_atomic_state *state)
> +						     struct drm_atomic_commit *state)
>   {
>   	struct drm_device *dev = plane->dev;
>   	struct bochs_device *bochs = to_bochs_device(dev);
>   	struct drm_plane_state *plane_state = plane->state;
>   	struct drm_plane_state *old_plane_state = drm_atomic_get_old_plane_state(state, plane);
> @@ -511,31 +511,31 @@ static void bochs_crtc_helper_mode_set_nofb(struct drm_crtc *crtc)
>   
>   	bochs_hw_setmode(bochs, &crtc_state->mode);
>   }
>   
>   static int bochs_crtc_helper_atomic_check(struct drm_crtc *crtc,
> -					  struct drm_atomic_state *state)
> +					  struct drm_atomic_commit *state)
>   {
>   	struct drm_crtc_state *crtc_state = drm_atomic_get_new_crtc_state(state, crtc);
>   
>   	if (!crtc_state->enable)
>   		return 0;
>   
>   	return drm_atomic_helper_check_crtc_primary_plane(crtc_state);
>   }
>   
>   static void bochs_crtc_helper_atomic_enable(struct drm_crtc *crtc,
> -					    struct drm_atomic_state *state)
> +					    struct drm_atomic_commit *state)
>   {
>   	struct bochs_device *bochs = to_bochs_device(crtc->dev);
>   
>   	bochs_hw_blank(bochs, false);
>   	drm_crtc_vblank_on(crtc);
>   }
>   
>   static void bochs_crtc_helper_atomic_disable(struct drm_crtc *crtc,
> -					     struct drm_atomic_state *crtc_state)
> +					     struct drm_atomic_commit *crtc_state)
>   {
>   	struct bochs_device *bochs = to_bochs_device(crtc->dev);
>   
>   	drm_crtc_vblank_off(crtc);
>   	bochs_hw_blank(bochs, true);
> diff --git a/drivers/gpu/drm/tiny/cirrus-qemu.c b/drivers/gpu/drm/tiny/cirrus-qemu.c
> index 9ba0eab489bb3162d654a6b22f58a3d2657b8782..075221b431d3761c0d9acdbed5fcd966af27268e 100644
> --- a/drivers/gpu/drm/tiny/cirrus-qemu.c
> +++ b/drivers/gpu/drm/tiny/cirrus-qemu.c
> @@ -294,11 +294,11 @@ static const uint64_t cirrus_primary_plane_format_modifiers[] = {
>   	DRM_FORMAT_MOD_LINEAR,
>   	DRM_FORMAT_MOD_INVALID
>   };
>   
>   static int cirrus_primary_plane_helper_atomic_check(struct drm_plane *plane,
> -						    struct drm_atomic_state *state)
> +						    struct drm_atomic_commit *state)
>   {
>   	struct drm_plane_state *new_plane_state = drm_atomic_get_new_plane_state(state, plane);
>   	struct drm_framebuffer *fb = new_plane_state->fb;
>   	struct drm_crtc *new_crtc = new_plane_state->crtc;
>   	struct drm_crtc_state *new_crtc_state = NULL;
> @@ -324,11 +324,11 @@ static int cirrus_primary_plane_helper_atomic_check(struct drm_plane *plane,
>   
>   	return 0;
>   }
>   
>   static void cirrus_primary_plane_helper_atomic_update(struct drm_plane *plane,
> -						      struct drm_atomic_state *state)
> +						      struct drm_atomic_commit *state)
>   {
>   	struct cirrus_device *cirrus = to_cirrus(plane->dev);
>   	struct drm_plane_state *plane_state = drm_atomic_get_new_plane_state(state, plane);
>   	struct drm_shadow_plane_state *shadow_plane_state = to_drm_shadow_plane_state(plane_state);
>   	struct drm_framebuffer *fb = plane_state->fb;
> @@ -372,11 +372,11 @@ static const struct drm_plane_funcs cirrus_primary_plane_funcs = {
>   	.disable_plane = drm_atomic_helper_disable_plane,
>   	.destroy = drm_plane_cleanup,
>   	DRM_GEM_SHADOW_PLANE_FUNCS,
>   };
>   
> -static int cirrus_crtc_helper_atomic_check(struct drm_crtc *crtc, struct drm_atomic_state *state)
> +static int cirrus_crtc_helper_atomic_check(struct drm_crtc *crtc, struct drm_atomic_commit *state)
>   {
>   	struct drm_crtc_state *crtc_state = drm_atomic_get_new_crtc_state(state, crtc);
>   	int ret;
>   
>   	if (!crtc_state->enable)
> @@ -388,11 +388,11 @@ static int cirrus_crtc_helper_atomic_check(struct drm_crtc *crtc, struct drm_ato
>   
>   	return 0;
>   }
>   
>   static void cirrus_crtc_helper_atomic_enable(struct drm_crtc *crtc,
> -					     struct drm_atomic_state *state)
> +					     struct drm_atomic_commit *state)
>   {
>   	struct cirrus_device *cirrus = to_cirrus(crtc->dev);
>   	struct drm_crtc_state *crtc_state = drm_atomic_get_new_crtc_state(state, crtc);
>   	int idx;
>   
> diff --git a/drivers/gpu/drm/tiny/pixpaper.c b/drivers/gpu/drm/tiny/pixpaper.c
> index df3ec42edd57036e68339a52e2ceb8a48e1b1ea3..d02ac26d007c14de78c05ec806a852c00916e313 100644
> --- a/drivers/gpu/drm/tiny/pixpaper.c
> +++ b/drivers/gpu/drm/tiny/pixpaper.c
> @@ -772,11 +772,11 @@ static u8 pack_pixels_to_byte(__le32 *src_pixels, int i, int j,
>   
>   	return packed_byte;
>   }
>   
>   static int pixpaper_plane_helper_atomic_check(struct drm_plane *plane,
> -					      struct drm_atomic_state *state)
> +					      struct drm_atomic_commit *state)
>   {
>   	struct drm_plane_state *new_plane_state =
>   		drm_atomic_get_new_plane_state(state, plane);
>   	struct drm_crtc *new_crtc = new_plane_state->crtc;
>   	struct drm_crtc_state *new_crtc_state = NULL;
> @@ -795,11 +795,11 @@ static int pixpaper_plane_helper_atomic_check(struct drm_plane *plane,
>   
>   	return 0;
>   }
>   
>   static int pixpaper_crtc_helper_atomic_check(struct drm_crtc *crtc,
> -					     struct drm_atomic_state *state)
> +					     struct drm_atomic_commit *state)
>   {
>   	struct drm_crtc_state *crtc_state =
>   		drm_atomic_get_new_crtc_state(state, crtc);
>   
>   	if (!crtc_state->enable)
> @@ -807,11 +807,11 @@ static int pixpaper_crtc_helper_atomic_check(struct drm_crtc *crtc,
>   
>   	return drm_atomic_helper_check_crtc_primary_plane(crtc_state);
>   }
>   
>   static void pixpaper_crtc_atomic_enable(struct drm_crtc *crtc,
> -					struct drm_atomic_state *state)
> +					struct drm_atomic_commit *state)
>   {
>   	struct pixpaper_panel *panel = to_pixpaper_panel(crtc->dev);
>   	struct drm_device *drm = &panel->drm;
>   	int idx;
>   	struct pixpaper_error_ctx err = { .errno_code = 0 };
> @@ -832,11 +832,11 @@ static void pixpaper_crtc_atomic_enable(struct drm_crtc *crtc,
>   exit_drm_dev:
>   	drm_dev_exit(idx);
>   }
>   
>   static void pixpaper_crtc_atomic_disable(struct drm_crtc *crtc,
> -					 struct drm_atomic_state *state)
> +					 struct drm_atomic_commit *state)
>   {
>   	struct pixpaper_panel *panel = to_pixpaper_panel(crtc->dev);
>   	struct drm_device *drm = &panel->drm;
>   	struct pixpaper_error_ctx err = { .errno_code = 0 };
>   	int idx;
> @@ -856,11 +856,11 @@ static void pixpaper_crtc_atomic_disable(struct drm_crtc *crtc,
>   exit_drm_dev:
>   	drm_dev_exit(idx);
>   }
>   
>   static void pixpaper_plane_atomic_update(struct drm_plane *plane,
> -					 struct drm_atomic_state *state)
> +					 struct drm_atomic_commit *state)
>   {
>   	struct drm_plane_state *plane_state =
>   		drm_atomic_get_new_plane_state(state, plane);
>   	struct drm_shadow_plane_state *shadow_plane_state =
>   		to_drm_shadow_plane_state(plane_state);
> diff --git a/drivers/gpu/drm/tiny/sharp-memory.c b/drivers/gpu/drm/tiny/sharp-memory.c
> index cbf69460ebf32df602f34c2b26d183bad3ce39cf..506e6432e70dfaba454fff18d601090a2f147fd6 100644
> --- a/drivers/gpu/drm/tiny/sharp-memory.c
> +++ b/drivers/gpu/drm/tiny/sharp-memory.c
> @@ -221,11 +221,11 @@ static void sharp_memory_fb_dirty(struct drm_framebuffer *fb, const struct iosys
>   
>   	sharp_memory_update_display(smd, fb, vmap, clip, fmtconv_state);
>   }
>   
>   static int sharp_memory_plane_atomic_check(struct drm_plane *plane,
> -					   struct drm_atomic_state *state)
> +					   struct drm_atomic_commit *state)
>   {
>   	struct drm_plane_state *plane_state = drm_atomic_get_new_plane_state(state, plane);
>   	struct sharp_memory_device *smd;
>   	struct drm_crtc_state *crtc_state;
>   
> @@ -237,11 +237,11 @@ static int sharp_memory_plane_atomic_check(struct drm_plane *plane,
>   						   DRM_PLANE_NO_SCALING,
>   						   false, false);
>   }
>   
>   static void sharp_memory_plane_atomic_update(struct drm_plane *plane,
> -					     struct drm_atomic_state *state)
> +					     struct drm_atomic_commit *state)
>   {
>   	struct drm_plane_state *old_state = drm_atomic_get_old_plane_state(state, plane);
>   	struct drm_plane_state *plane_state = plane->state;
>   	struct drm_shadow_plane_state *shadow_plane_state = to_drm_shadow_plane_state(plane_state);
>   	struct sharp_memory_device *smd;
> @@ -285,11 +285,11 @@ static enum drm_mode_status sharp_memory_crtc_mode_valid(struct drm_crtc *crtc,
>   
>   	return drm_crtc_helper_mode_valid_fixed(crtc, mode, smd->mode);
>   }
>   
>   static int sharp_memory_crtc_check(struct drm_crtc *crtc,
> -				   struct drm_atomic_state *state)
> +				   struct drm_atomic_commit *state)
>   {
>   	struct drm_crtc_state *crtc_state = drm_atomic_get_new_crtc_state(state, crtc);
>   	int ret;
>   
>   	if (!crtc_state->enable)
> @@ -315,22 +315,22 @@ static int sharp_memory_sw_vcom_signal_thread(void *data)
>   
>   	return 0;
>   }
>   
>   static void sharp_memory_crtc_enable(struct drm_crtc *crtc,
> -				     struct drm_atomic_state *state)
> +				     struct drm_atomic_commit *state)
>   {
>   	struct sharp_memory_device *smd = drm_to_sharp_memory_device(crtc->dev);
>   
>   	sharp_memory_clear_display(smd);
>   
>   	if (smd->enable_gpio)
>   		gpiod_set_value(smd->enable_gpio, 1);
>   }
>   
>   static void sharp_memory_crtc_disable(struct drm_crtc *crtc,
> -				      struct drm_atomic_state *state)
> +				      struct drm_atomic_commit *state)
>   {
>   	struct sharp_memory_device *smd = drm_to_sharp_memory_device(crtc->dev);
>   
>   	sharp_memory_clear_display(smd);
>   
> diff --git a/drivers/gpu/drm/udl/udl_modeset.c b/drivers/gpu/drm/udl/udl_modeset.c
> index 231e829bd709a205e7fcc9839fcc790509a8abe9..ed62933dba26f97323c4d5bc5a2fc6069e809d69 100644
> --- a/drivers/gpu/drm/udl/udl_modeset.c
> +++ b/drivers/gpu/drm/udl/udl_modeset.c
> @@ -261,11 +261,11 @@ static const uint64_t udl_primary_plane_fmtmods[] = {
>   	DRM_FORMAT_MOD_LINEAR,
>   	DRM_FORMAT_MOD_INVALID
>   };
>   
>   static int udl_primary_plane_helper_atomic_check(struct drm_plane *plane,
> -						 struct drm_atomic_state *state)
> +						 struct drm_atomic_commit *state)
>   {
>   	struct drm_plane_state *new_plane_state = drm_atomic_get_new_plane_state(state, plane);
>   	struct drm_crtc *new_crtc = new_plane_state->crtc;
>   	struct drm_crtc_state *new_crtc_state = NULL;
>   
> @@ -277,11 +277,11 @@ static int udl_primary_plane_helper_atomic_check(struct drm_plane *plane,
>   						   DRM_PLANE_NO_SCALING,
>   						   false, false);
>   }
>   
>   static void udl_primary_plane_helper_atomic_update(struct drm_plane *plane,
> -						   struct drm_atomic_state *state)
> +						   struct drm_atomic_commit *state)
>   {
>   	struct drm_device *dev = plane->dev;
>   	struct drm_plane_state *plane_state = drm_atomic_get_new_plane_state(state, plane);
>   	struct drm_shadow_plane_state *shadow_plane_state = to_drm_shadow_plane_state(plane_state);
>   	struct drm_framebuffer *fb = plane_state->fb;
> @@ -326,11 +326,11 @@ static const struct drm_plane_funcs udl_primary_plane_funcs = {
>   
>   /*
>    * CRTC
>    */
>   
> -static void udl_crtc_helper_atomic_enable(struct drm_crtc *crtc, struct drm_atomic_state *state)
> +static void udl_crtc_helper_atomic_enable(struct drm_crtc *crtc, struct drm_atomic_commit *state)
>   {
>   	struct drm_device *dev = crtc->dev;
>   	struct udl_device *udl = to_udl(dev);
>   	struct drm_crtc_state *crtc_state = drm_atomic_get_new_crtc_state(state, crtc);
>   	struct drm_display_mode *mode = &crtc_state->mode;
> @@ -361,11 +361,11 @@ static void udl_crtc_helper_atomic_enable(struct drm_crtc *crtc, struct drm_atom
>   
>   out:
>   	drm_dev_exit(idx);
>   }
>   
> -static void udl_crtc_helper_atomic_disable(struct drm_crtc *crtc, struct drm_atomic_state *state)
> +static void udl_crtc_helper_atomic_disable(struct drm_crtc *crtc, struct drm_atomic_commit *state)
>   {
>   	struct drm_device *dev = crtc->dev;
>   	struct udl_device *udl = to_udl(dev);
>   	struct urb *urb;
>   	char *buf;
> diff --git a/drivers/gpu/drm/vboxvideo/vbox_mode.c b/drivers/gpu/drm/vboxvideo/vbox_mode.c
> index 9c11a6b945ff445fc4d150647d8971a14fd8304f..8e4e5fc9d3c5a0de4ccea547e97f096ba2fff158 100644
> --- a/drivers/gpu/drm/vboxvideo/vbox_mode.c
> +++ b/drivers/gpu/drm/vboxvideo/vbox_mode.c
> @@ -217,21 +217,21 @@ static void vbox_crtc_set_base_and_mode(struct drm_crtc *crtc,
>   
>   	mutex_unlock(&vbox->hw_mutex);
>   }
>   
>   static void vbox_crtc_atomic_enable(struct drm_crtc *crtc,
> -				    struct drm_atomic_state *state)
> +				    struct drm_atomic_commit *state)
>   {
>   }
>   
>   static void vbox_crtc_atomic_disable(struct drm_crtc *crtc,
> -				     struct drm_atomic_state *state)
> +				     struct drm_atomic_commit *state)
>   {
>   }
>   
>   static void vbox_crtc_atomic_flush(struct drm_crtc *crtc,
> -				   struct drm_atomic_state *state)
> +				   struct drm_atomic_commit *state)
>   {
>   }
>   
>   static const struct drm_crtc_helper_funcs vbox_crtc_helper_funcs = {
>   	.atomic_enable = vbox_crtc_atomic_enable,
> @@ -254,11 +254,11 @@ static const struct drm_crtc_funcs vbox_crtc_funcs = {
>   	.atomic_duplicate_state = drm_atomic_helper_crtc_duplicate_state,
>   	.atomic_destroy_state = drm_atomic_helper_crtc_destroy_state,
>   };
>   
>   static int vbox_primary_atomic_check(struct drm_plane *plane,
> -				     struct drm_atomic_state *state)
> +				     struct drm_atomic_commit *state)
>   {
>   	struct drm_plane_state *new_state = drm_atomic_get_new_plane_state(state,
>   									   plane);
>   	struct drm_crtc_state *crtc_state = NULL;
>   
> @@ -274,11 +274,11 @@ static int vbox_primary_atomic_check(struct drm_plane *plane,
>   						   DRM_PLANE_NO_SCALING,
>   						   false, true);
>   }
>   
>   static void vbox_primary_atomic_update(struct drm_plane *plane,
> -				       struct drm_atomic_state *state)
> +				       struct drm_atomic_commit *state)
>   {
>   	struct drm_plane_state *new_state = drm_atomic_get_new_plane_state(state,
>   									   plane);
>   	struct drm_crtc *crtc = new_state->crtc;
>   	struct drm_framebuffer *fb = new_state->fb;
> @@ -320,11 +320,11 @@ static void vbox_primary_atomic_update(struct drm_plane *plane,
>   
>   	mutex_unlock(&vbox->hw_mutex);
>   }
>   
>   static void vbox_primary_atomic_disable(struct drm_plane *plane,
> -					struct drm_atomic_state *state)
> +					struct drm_atomic_commit *state)
>   {
>   	struct drm_plane_state *old_state = drm_atomic_get_old_plane_state(state,
>   									   plane);
>   	struct drm_crtc *crtc = old_state->crtc;
>   
> @@ -333,11 +333,11 @@ static void vbox_primary_atomic_disable(struct drm_plane *plane,
>   				    old_state->src_x >> 16,
>   				    old_state->src_y >> 16);
>   }
>   
>   static int vbox_cursor_atomic_check(struct drm_plane *plane,
> -				    struct drm_atomic_state *state)
> +				    struct drm_atomic_commit *state)
>   {
>   	struct drm_plane_state *new_state = drm_atomic_get_new_plane_state(state,
>   									   plane);
>   	struct drm_crtc_state *crtc_state = NULL;
>   	u32 width = new_state->crtc_w;
> @@ -385,11 +385,11 @@ static void copy_cursor_image(u8 *src, u8 *dst, u32 width, u32 height,
>   			if (((u32 *)src)[i * width + j] > 0xf0000000)
>   				dst[i * line_size + j / 8] |= (0x80 >> (j % 8));
>   }
>   
>   static void vbox_cursor_atomic_update(struct drm_plane *plane,
> -				      struct drm_atomic_state *state)
> +				      struct drm_atomic_commit *state)
>   {
>   	struct drm_plane_state *old_state = drm_atomic_get_old_plane_state(state,
>   									   plane);
>   	struct drm_plane_state *new_state = drm_atomic_get_new_plane_state(state,
>   									   plane);
> @@ -436,11 +436,11 @@ static void vbox_cursor_atomic_update(struct drm_plane *plane,
>   
>   	mutex_unlock(&vbox->hw_mutex);
>   }
>   
>   static void vbox_cursor_atomic_disable(struct drm_plane *plane,
> -				       struct drm_atomic_state *state)
> +				       struct drm_atomic_commit *state)
>   {
>   	struct drm_plane_state *old_state = drm_atomic_get_old_plane_state(state,
>   									   plane);
>   	struct vbox_private *vbox =
>   		container_of(plane->dev, struct vbox_private, ddev);
> diff --git a/drivers/gpu/drm/vc4/tests/vc4_mock.h b/drivers/gpu/drm/vc4/tests/vc4_mock.h
> index 002b6218960c48dae102cafd4120f9713b89cb50..3cc4b4a0feed2ec93565c92855b9186d289efa88 100644
> --- a/drivers/gpu/drm/vc4/tests/vc4_mock.h
> +++ b/drivers/gpu/drm/vc4/tests/vc4_mock.h
> @@ -50,12 +50,12 @@ struct vc4_dummy_output *vc4_dummy_output(struct kunit *test,
>   
>   struct vc4_dev *vc4_mock_device(struct kunit *test);
>   struct vc4_dev *vc5_mock_device(struct kunit *test);
>   
>   int vc4_mock_atomic_add_output(struct kunit *test,
> -			       struct drm_atomic_state *state,
> +			       struct drm_atomic_commit *state,
>   			       enum vc4_encoder_type type);
>   int vc4_mock_atomic_del_output(struct kunit *test,
> -			       struct drm_atomic_state *state,
> +			       struct drm_atomic_commit *state,
>   			       enum vc4_encoder_type type);
>   
>   #endif // VC4_MOCK_H_
> diff --git a/drivers/gpu/drm/vc4/tests/vc4_mock_output.c b/drivers/gpu/drm/vc4/tests/vc4_mock_output.c
> index 577d9a9563696791632aec614c381a214886bf27..b53c3635ce673edd57686cdf5ed7512ff8452b1d 100644
> --- a/drivers/gpu/drm/vc4/tests/vc4_mock_output.c
> +++ b/drivers/gpu/drm/vc4/tests/vc4_mock_output.c
> @@ -73,11 +73,11 @@ static const struct drm_display_mode default_mode = {
>    * 0 on success, a negative error code on failure. If the error is
>    * EDEADLK, the entire atomic sequence must be restarted. All other
>    * errors are fatal.
>    */
>   int vc4_mock_atomic_add_output(struct kunit *test,
> -			       struct drm_atomic_state *state,
> +			       struct drm_atomic_commit *state,
>   			       enum vc4_encoder_type type)
>   {
>   	struct drm_device *drm = state->dev;
>   	struct drm_connector_state *conn_state;
>   	struct drm_crtc_state *crtc_state;
> @@ -130,11 +130,11 @@ int vc4_mock_atomic_add_output(struct kunit *test,
>    * 0 on success, a negative error code on failure. If the error is
>    * EDEADLK, the entire atomic sequence must be restarted. All other
>    * errors are fatal.
>    */
>   int vc4_mock_atomic_del_output(struct kunit *test,
> -			       struct drm_atomic_state *state,
> +			       struct drm_atomic_commit *state,
>   			       enum vc4_encoder_type type)
>   {
>   	struct drm_device *drm = state->dev;
>   	struct drm_connector_state *conn_state;
>   	struct drm_crtc_state *crtc_state;
> diff --git a/drivers/gpu/drm/vc4/tests/vc4_test_pv_muxing.c b/drivers/gpu/drm/vc4/tests/vc4_test_pv_muxing.c
> index d1f694029169adf6a907a72614bc66afd745017e..7a54f46acff91f5e9e8dab80537aa2075fc5c0c9 100644
> --- a/drivers/gpu/drm/vc4/tests/vc4_test_pv_muxing.c
> +++ b/drivers/gpu/drm/vc4/tests/vc4_test_pv_muxing.c
> @@ -21,11 +21,11 @@
>   struct pv_muxing_priv {
>   	struct vc4_dev *vc4;
>   };
>   
>   static bool check_fifo_conflict(struct kunit *test,
> -				const struct drm_atomic_state *state)
> +				const struct drm_atomic_commit *state)
>   {
>   	struct vc4_hvs_state *hvs_state;
>   	unsigned int used_fifos = 0;
>   	unsigned int i;
>   
> @@ -117,11 +117,11 @@ static bool check_vc5_encoder_constraints(enum vc4_encoder_type type, unsigned i
>   					   type, channel);
>   }
>   
>   static struct vc4_crtc_state *
>   get_vc4_crtc_state_for_encoder(struct kunit *test,
> -			       const struct drm_atomic_state *state,
> +			       const struct drm_atomic_commit *state,
>   			       enum vc4_encoder_type type)
>   {
>   	struct drm_device *drm = state->dev;
>   	struct drm_crtc_state *new_crtc_state;
>   	struct drm_encoder *encoder;
> @@ -139,11 +139,11 @@ get_vc4_crtc_state_for_encoder(struct kunit *test,
>   
>   	return to_vc4_crtc_state(new_crtc_state);
>   }
>   
>   static bool check_channel_for_encoder(struct kunit *test,
> -				      const struct drm_atomic_state *state,
> +				      const struct drm_atomic_commit *state,
>   				      enum vc4_encoder_type type,
>   				      bool (*check_fn)(enum vc4_encoder_type type, unsigned int channel))
>   {
>   	struct vc4_crtc_state *new_vc4_crtc_state;
>   	struct vc4_hvs_state *new_hvs_state;
> @@ -675,11 +675,11 @@ KUNIT_ARRAY_PARAM(vc5_test_pv_muxing_invalid,
>   static void drm_vc4_test_pv_muxing(struct kunit *test)
>   {
>   	const struct pv_muxing_param *params = test->param_value;
>   	const struct pv_muxing_priv *priv = test->priv;
>   	struct drm_modeset_acquire_ctx ctx;
> -	struct drm_atomic_state *state;
> +	struct drm_atomic_commit *state;
>   	struct drm_device *drm;
>   	struct vc4_dev *vc4;
>   	unsigned int i;
>   	int ret;
>   
> @@ -694,21 +694,21 @@ static void drm_vc4_test_pv_muxing(struct kunit *test)
>   	for (i = 0; i < params->nencoders; i++) {
>   		enum vc4_encoder_type enc_type = params->encoders[i];
>   
>   		ret = vc4_mock_atomic_add_output(test, state, enc_type);
>   		if (ret == -EDEADLK) {
> -			drm_atomic_state_clear(state);
> +			drm_atomic_commit_clear(state);
>   			ret = drm_modeset_backoff(&ctx);
>   			if (!ret)
>   				goto retry;
>   		}
>   		KUNIT_ASSERT_EQ(test, ret, 0);
>   	}
>   
>   	ret = drm_atomic_check_only(state);
>   	if (ret == -EDEADLK) {
> -		drm_atomic_state_clear(state);
> +		drm_atomic_commit_clear(state);
>   		ret = drm_modeset_backoff(&ctx);
>   		if (!ret)
>   			goto retry;
>   	}
>   	KUNIT_EXPECT_EQ(test, ret, 0);
> @@ -730,11 +730,11 @@ static void drm_vc4_test_pv_muxing(struct kunit *test)
>   static void drm_vc4_test_pv_muxing_invalid(struct kunit *test)
>   {
>   	const struct pv_muxing_param *params = test->param_value;
>   	const struct pv_muxing_priv *priv = test->priv;
>   	struct drm_modeset_acquire_ctx ctx;
> -	struct drm_atomic_state *state;
> +	struct drm_atomic_commit *state;
>   	struct drm_device *drm;
>   	struct vc4_dev *vc4;
>   	unsigned int i;
>   	int ret;
>   
> @@ -750,21 +750,21 @@ static void drm_vc4_test_pv_muxing_invalid(struct kunit *test)
>   	for (i = 0; i < params->nencoders; i++) {
>   		enum vc4_encoder_type enc_type = params->encoders[i];
>   
>   		ret = vc4_mock_atomic_add_output(test, state, enc_type);
>   		if (ret == -EDEADLK) {
> -			drm_atomic_state_clear(state);
> +			drm_atomic_commit_clear(state);
>   			ret = drm_modeset_backoff(&ctx);
>   			if (!ret)
>   				goto retry;
>   		}
>   		KUNIT_ASSERT_EQ(test, ret, 0);
>   	}
>   
>   	ret = drm_atomic_check_only(state);
>   	if (ret == -EDEADLK) {
> -		drm_atomic_state_clear(state);
> +		drm_atomic_commit_clear(state);
>   		ret = drm_modeset_backoff(&ctx);
>   		if (!ret)
>   			goto retry;
>   	}
>   	KUNIT_EXPECT_LT(test, ret, 0);
> @@ -824,11 +824,11 @@ static struct kunit_suite vc5_pv_muxing_test_suite = {
>    * https://lore.kernel.org/dri-devel/20200917121623.42023-1-maxime@cerno.tech/
>    */
>   static void drm_test_vc5_pv_muxing_bugs_subsequent_crtc_enable(struct kunit *test)
>   {
>   	struct drm_modeset_acquire_ctx ctx;
> -	struct drm_atomic_state *state;
> +	struct drm_atomic_commit *state;
>   	struct vc4_crtc_state *new_vc4_crtc_state;
>   	struct vc4_hvs_state *new_hvs_state;
>   	unsigned int hdmi0_channel;
>   	unsigned int hdmi1_channel;
>   	struct drm_device *drm;
> @@ -845,20 +845,20 @@ static void drm_test_vc5_pv_muxing_bugs_subsequent_crtc_enable(struct kunit *tes
>   	state = drm_kunit_helper_atomic_state_alloc(test, drm, &ctx);
>   	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, state);
>   
>   	ret = vc4_mock_atomic_add_output(test, state, VC4_ENCODER_TYPE_HDMI0);
>   	if (ret == -EDEADLK) {
> -		drm_atomic_state_clear(state);
> +		drm_atomic_commit_clear(state);
>   		ret = drm_modeset_backoff(&ctx);
>   		if (!ret)
>   			goto retry_first;
>   	}
>   	KUNIT_ASSERT_EQ(test, ret, 0);
>   
>   	ret = drm_atomic_check_only(state);
>   	if (ret == -EDEADLK) {
> -		drm_atomic_state_clear(state);
> +		drm_atomic_commit_clear(state);
>   		ret = drm_modeset_backoff(&ctx);
>   		if (!ret)
>   			goto retry_first;
>   	}
>   	KUNIT_ASSERT_EQ(test, ret, 0);
> @@ -881,20 +881,20 @@ static void drm_test_vc5_pv_muxing_bugs_subsequent_crtc_enable(struct kunit *tes
>   	state = drm_kunit_helper_atomic_state_alloc(test, drm, &ctx);
>   	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, state);
>   
>   	ret = vc4_mock_atomic_add_output(test, state, VC4_ENCODER_TYPE_HDMI1);
>   	if (ret == -EDEADLK) {
> -		drm_atomic_state_clear(state);
> +		drm_atomic_commit_clear(state);
>   		ret = drm_modeset_backoff(&ctx);
>   		if (!ret)
>   			goto retry_second;
>   	}
>   	KUNIT_ASSERT_EQ(test, ret, 0);
>   
>   	ret = drm_atomic_check_only(state);
>   	if (ret == -EDEADLK) {
> -		drm_atomic_state_clear(state);
> +		drm_atomic_commit_clear(state);
>   		ret = drm_modeset_backoff(&ctx);
>   		if (!ret)
>   			goto retry_second;
>   	}
>   	KUNIT_ASSERT_EQ(test, ret, 0);
> @@ -924,11 +924,11 @@ static void drm_test_vc5_pv_muxing_bugs_subsequent_crtc_enable(struct kunit *tes
>    * supposed to be unaffected by the commit.
>    */
>   static void drm_test_vc5_pv_muxing_bugs_stable_fifo(struct kunit *test)
>   {
>   	struct drm_modeset_acquire_ctx ctx;
> -	struct drm_atomic_state *state;
> +	struct drm_atomic_commit *state;
>   	struct vc4_crtc_state *new_vc4_crtc_state;
>   	struct vc4_hvs_state *new_hvs_state;
>   	unsigned int old_hdmi0_channel;
>   	unsigned int old_hdmi1_channel;
>   	struct drm_device *drm;
> @@ -945,29 +945,29 @@ static void drm_test_vc5_pv_muxing_bugs_stable_fifo(struct kunit *test)
>   	state = drm_kunit_helper_atomic_state_alloc(test, drm, &ctx);
>   	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, state);
>   
>   	ret = vc4_mock_atomic_add_output(test, state, VC4_ENCODER_TYPE_HDMI0);
>   	if (ret == -EDEADLK) {
> -		drm_atomic_state_clear(state);
> +		drm_atomic_commit_clear(state);
>   		ret = drm_modeset_backoff(&ctx);
>   		if (!ret)
>   			goto retry_first;
>   	}
>   	KUNIT_ASSERT_EQ(test, ret, 0);
>   
>   	ret = vc4_mock_atomic_add_output(test, state, VC4_ENCODER_TYPE_HDMI1);
>   	if (ret == -EDEADLK) {
> -		drm_atomic_state_clear(state);
> +		drm_atomic_commit_clear(state);
>   		ret = drm_modeset_backoff(&ctx);
>   		if (!ret)
>   			goto retry_first;
>   	}
>   	KUNIT_ASSERT_EQ(test, ret, 0);
>   
>   	ret = drm_atomic_check_only(state);
>   	if (ret == -EDEADLK) {
> -		drm_atomic_state_clear(state);
> +		drm_atomic_commit_clear(state);
>   		ret = drm_modeset_backoff(&ctx);
>   		if (!ret)
>   			goto retry_first;
>   	}
>   	KUNIT_ASSERT_EQ(test, ret, 0);
> @@ -998,20 +998,20 @@ static void drm_test_vc5_pv_muxing_bugs_stable_fifo(struct kunit *test)
>   	state = drm_kunit_helper_atomic_state_alloc(test, drm, &ctx);
>   	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, state);
>   
>   	ret = vc4_mock_atomic_del_output(test, state, VC4_ENCODER_TYPE_HDMI0);
>   	if (ret == -EDEADLK) {
> -		drm_atomic_state_clear(state);
> +		drm_atomic_commit_clear(state);
>   		ret = drm_modeset_backoff(&ctx);
>   		if (!ret)
>   			goto retry_second;
>   	}
>   	KUNIT_ASSERT_EQ(test, ret, 0);
>   
>   	ret = drm_atomic_check_only(state);
>   	if (ret == -EDEADLK) {
> -		drm_atomic_state_clear(state);
> +		drm_atomic_commit_clear(state);
>   		ret = drm_modeset_backoff(&ctx);
>   		if (!ret)
>   			goto retry_second;
>   	}
>   	KUNIT_ASSERT_EQ(test, ret, 0);
> @@ -1053,11 +1053,11 @@ static void drm_test_vc5_pv_muxing_bugs_stable_fifo(struct kunit *test)
>    */
>   static void
>   drm_test_vc5_pv_muxing_bugs_subsequent_crtc_enable_too_many_crtc_state(struct kunit *test)
>   {
>   	struct drm_modeset_acquire_ctx ctx;
> -	struct drm_atomic_state *state;
> +	struct drm_atomic_commit *state;
>   	struct vc4_crtc_state *new_vc4_crtc_state;
>   	struct drm_device *drm;
>   	struct vc4_dev *vc4;
>   	int ret;
>   
> @@ -1071,20 +1071,20 @@ drm_test_vc5_pv_muxing_bugs_subsequent_crtc_enable_too_many_crtc_state(struct ku
>   	state = drm_kunit_helper_atomic_state_alloc(test, drm, &ctx);
>   	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, state);
>   
>   	ret = vc4_mock_atomic_add_output(test, state, VC4_ENCODER_TYPE_HDMI0);
>   	if (ret == -EDEADLK) {
> -		drm_atomic_state_clear(state);
> +		drm_atomic_commit_clear(state);
>   		ret = drm_modeset_backoff(&ctx);
>   		if (!ret)
>   			goto retry_first;
>   	}
>   	KUNIT_ASSERT_EQ(test, ret, 0);
>   
>   	ret = drm_atomic_check_only(state);
>   	if (ret == -EDEADLK) {
> -		drm_atomic_state_clear(state);
> +		drm_atomic_commit_clear(state);
>   		ret = drm_modeset_backoff(&ctx);
>   		if (!ret)
>   			goto retry_first;
>   	}
>   	KUNIT_ASSERT_EQ(test, ret, 0);
> @@ -1095,20 +1095,20 @@ drm_test_vc5_pv_muxing_bugs_subsequent_crtc_enable_too_many_crtc_state(struct ku
>   	state = drm_kunit_helper_atomic_state_alloc(test, drm, &ctx);
>   	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, state);
>   
>   	ret = vc4_mock_atomic_add_output(test, state, VC4_ENCODER_TYPE_HDMI1);
>   	if (ret == -EDEADLK) {
> -		drm_atomic_state_clear(state);
> +		drm_atomic_commit_clear(state);
>   		ret = drm_modeset_backoff(&ctx);
>   		if (!ret)
>   			goto retry_second;
>   	}
>   	KUNIT_ASSERT_EQ(test, ret, 0);
>   
>   	ret = drm_atomic_check_only(state);
>   	if (ret == -EDEADLK) {
> -		drm_atomic_state_clear(state);
> +		drm_atomic_commit_clear(state);
>   		ret = drm_modeset_backoff(&ctx);
>   		if (!ret)
>   			goto retry_second;
>   	}
>   	KUNIT_ASSERT_EQ(test, ret, 0);
> diff --git a/drivers/gpu/drm/vc4/vc4_crtc.c b/drivers/gpu/drm/vc4/vc4_crtc.c
> index 4a606986afcc74beda9bee841deb4ab31a99e54f..4572b0b9bae1ce1dd3aa2599c0984b6258d9ef5c 100644
> --- a/drivers/gpu/drm/vc4/vc4_crtc.c
> +++ b/drivers/gpu/drm/vc4/vc4_crtc.c
> @@ -341,11 +341,11 @@ static void vc4_crtc_pixelvalve_reset(struct drm_crtc *crtc)
>   
>   	drm_dev_exit(idx);
>   }
>   
>   static void vc4_crtc_config_pv(struct drm_crtc *crtc, struct drm_encoder *encoder,
> -			       struct drm_atomic_state *state)
> +			       struct drm_atomic_commit *state)
>   {
>   	struct drm_device *dev = crtc->dev;
>   	struct vc4_dev *vc4 = to_vc4_dev(dev);
>   	struct vc4_encoder *vc4_encoder = to_vc4_encoder(encoder);
>   	struct vc4_crtc *vc4_crtc = to_vc4_crtc(crtc);
> @@ -495,11 +495,11 @@ static void require_hvs_enabled(struct drm_device *dev)
>   		WARN_ON_ONCE(!(HVS_READ(SCALER_DISPCTRL) & SCALER_DISPCTRL_ENABLE));
>   }
>   
>   static int vc4_crtc_disable(struct drm_crtc *crtc,
>   			    struct drm_encoder *encoder,
> -			    struct drm_atomic_state *state,
> +			    struct drm_atomic_commit *state,
>   			    unsigned int channel)
>   {
>   	struct vc4_encoder *vc4_encoder = to_vc4_encoder(encoder);
>   	struct vc4_crtc *vc4_crtc = to_vc4_crtc(crtc);
>   	struct drm_device *dev = crtc->dev;
> @@ -620,11 +620,11 @@ void vc4_crtc_send_vblank(struct drm_crtc *crtc)
>   	crtc->state->event = NULL;
>   	spin_unlock_irqrestore(&dev->event_lock, flags);
>   }
>   
>   static void vc4_crtc_atomic_disable(struct drm_crtc *crtc,
> -				    struct drm_atomic_state *state)
> +				    struct drm_atomic_commit *state)
>   {
>   	struct drm_crtc_state *old_state = drm_atomic_get_old_crtc_state(state,
>   									 crtc);
>   	struct vc4_crtc_state *old_vc4_state = to_vc4_crtc_state(old_state);
>   	struct drm_encoder *encoder = vc4_get_crtc_encoder(crtc, old_state);
> @@ -646,11 +646,11 @@ static void vc4_crtc_atomic_disable(struct drm_crtc *crtc,
>   	 */
>   	vc4_crtc_send_vblank(crtc);
>   }
>   
>   static void vc4_crtc_atomic_enable(struct drm_crtc *crtc,
> -				   struct drm_atomic_state *state)
> +				   struct drm_atomic_commit *state)
>   {
>   	struct drm_crtc_state *new_state = drm_atomic_get_new_crtc_state(state,
>   									 crtc);
>   	struct drm_device *dev = crtc->dev;
>   	struct vc4_crtc *vc4_crtc = to_vc4_crtc(crtc);
> @@ -738,11 +738,11 @@ void vc4_crtc_get_margins(struct drm_crtc_state *state,
>   		break;
>   	}
>   }
>   
>   int vc4_crtc_atomic_check(struct drm_crtc *crtc,
> -			  struct drm_atomic_state *state)
> +			  struct drm_atomic_commit *state)
>   {
>   	struct drm_crtc_state *crtc_state = drm_atomic_get_new_crtc_state(state,
>   									  crtc);
>   	struct vc4_crtc_state *vc4_state = to_vc4_crtc_state(crtc_state);
>   	struct drm_connector *conn;
> diff --git a/drivers/gpu/drm/vc4/vc4_drv.h b/drivers/gpu/drm/vc4/vc4_drv.h
> index dbcc83b7df004519c9c74a618b81877a14796d36..0f5958c1e6b601c1ce9c4fb499bbcb448ad15f9e 100644
> --- a/drivers/gpu/drm/vc4/vc4_drv.h
> +++ b/drivers/gpu/drm/vc4/vc4_drv.h
> @@ -373,13 +373,13 @@ struct vc4_hvs_state {
>   };
>   
>   #define to_vc4_hvs_state(_state)				\
>   	container_of_const(_state, struct vc4_hvs_state, base)
>   
> -struct vc4_hvs_state *vc4_hvs_get_global_state(struct drm_atomic_state *state);
> -struct vc4_hvs_state *vc4_hvs_get_old_global_state(const struct drm_atomic_state *state);
> -struct vc4_hvs_state *vc4_hvs_get_new_global_state(const struct drm_atomic_state *state);
> +struct vc4_hvs_state *vc4_hvs_get_global_state(struct drm_atomic_commit *state);
> +struct vc4_hvs_state *vc4_hvs_get_old_global_state(const struct drm_atomic_commit *state);
> +struct vc4_hvs_state *vc4_hvs_get_new_global_state(const struct drm_atomic_commit *state);
>   
>   struct vc4_plane {
>   	struct drm_plane base;
>   };
>   
> @@ -476,16 +476,16 @@ enum vc4_encoder_type {
>   struct vc4_encoder {
>   	struct drm_encoder base;
>   	enum vc4_encoder_type type;
>   	u32 clock_select;
>   
> -	void (*pre_crtc_configure)(struct drm_encoder *encoder, struct drm_atomic_state *state);
> -	void (*pre_crtc_enable)(struct drm_encoder *encoder, struct drm_atomic_state *state);
> -	void (*post_crtc_enable)(struct drm_encoder *encoder, struct drm_atomic_state *state);
> +	void (*pre_crtc_configure)(struct drm_encoder *encoder, struct drm_atomic_commit *state);
> +	void (*pre_crtc_enable)(struct drm_encoder *encoder, struct drm_atomic_commit *state);
> +	void (*post_crtc_enable)(struct drm_encoder *encoder, struct drm_atomic_commit *state);
>   
> -	void (*post_crtc_disable)(struct drm_encoder *encoder, struct drm_atomic_state *state);
> -	void (*post_crtc_powerdown)(struct drm_encoder *encoder, struct drm_atomic_state *state);
> +	void (*post_crtc_disable)(struct drm_encoder *encoder, struct drm_atomic_commit *state);
> +	void (*post_crtc_powerdown)(struct drm_encoder *encoder, struct drm_atomic_commit *state);
>   };
>   
>   #define to_vc4_encoder(_encoder)				\
>   	container_of_const(_encoder, struct vc4_encoder, base)
>   
> @@ -943,11 +943,11 @@ int vc4_page_flip(struct drm_crtc *crtc,
>   		  struct drm_framebuffer *fb,
>   		  struct drm_pending_vblank_event *event,
>   		  uint32_t flags,
>   		  struct drm_modeset_acquire_ctx *ctx);
>   int vc4_crtc_atomic_check(struct drm_crtc *crtc,
> -			  struct drm_atomic_state *state);
> +			  struct drm_atomic_commit *state);
>   struct drm_crtc_state *vc4_crtc_duplicate_state(struct drm_crtc *crtc);
>   void vc4_crtc_destroy_state(struct drm_crtc *crtc,
>   			    struct drm_crtc_state *state);
>   void vc4_crtc_reset(struct drm_crtc *crtc);
>   void vc4_crtc_handle_vblank(struct vc4_crtc *crtc);
> @@ -1023,15 +1023,15 @@ struct vc4_hvs *__vc4_hvs_alloc(struct vc4_dev *vc4,
>   				void __iomem *regs,
>   				struct platform_device *pdev);
>   void vc4_hvs_stop_channel(struct vc4_hvs *hvs, unsigned int output);
>   int vc4_hvs_get_fifo_from_output(struct vc4_hvs *hvs, unsigned int output);
>   u8 vc4_hvs_get_fifo_frame_count(struct vc4_hvs *hvs, unsigned int fifo);
> -int vc4_hvs_atomic_check(struct drm_crtc *crtc, struct drm_atomic_state *state);
> -void vc4_hvs_atomic_begin(struct drm_crtc *crtc, struct drm_atomic_state *state);
> -void vc4_hvs_atomic_enable(struct drm_crtc *crtc, struct drm_atomic_state *state);
> -void vc4_hvs_atomic_disable(struct drm_crtc *crtc, struct drm_atomic_state *state);
> -void vc4_hvs_atomic_flush(struct drm_crtc *crtc, struct drm_atomic_state *state);
> +int vc4_hvs_atomic_check(struct drm_crtc *crtc, struct drm_atomic_commit *state);
> +void vc4_hvs_atomic_begin(struct drm_crtc *crtc, struct drm_atomic_commit *state);
> +void vc4_hvs_atomic_enable(struct drm_crtc *crtc, struct drm_atomic_commit *state);
> +void vc4_hvs_atomic_disable(struct drm_crtc *crtc, struct drm_atomic_commit *state);
> +void vc4_hvs_atomic_flush(struct drm_crtc *crtc, struct drm_atomic_commit *state);
>   void vc4_hvs_dump_state(struct vc4_hvs *hvs);
>   void vc4_hvs_unmask_underrun(struct vc4_hvs *hvs, int channel);
>   void vc4_hvs_mask_underrun(struct vc4_hvs *hvs, int channel);
>   int vc4_hvs_debugfs_init(struct drm_minor *minor);
>   
> diff --git a/drivers/gpu/drm/vc4/vc4_dsi.c b/drivers/gpu/drm/vc4/vc4_dsi.c
> index deeeaebc702f7f39d220f2c7c96c687de2ca301c..fc76018b044cd4565778509c8e1d976cde536f1e 100644
> --- a/drivers/gpu/drm/vc4/vc4_dsi.c
> +++ b/drivers/gpu/drm/vc4/vc4_dsi.c
> @@ -797,22 +797,22 @@ dsi_esc_timing(u32 ns)
>   {
>   	return DIV_ROUND_UP(ns, ESC_TIME_NS);
>   }
>   
>   static void vc4_dsi_bridge_disable(struct drm_bridge *bridge,
> -				   struct drm_atomic_state *state)
> +				   struct drm_atomic_commit *state)
>   {
>   	struct vc4_dsi *dsi = bridge_to_vc4_dsi(bridge);
>   	u32 disp0_ctrl;
>   
>   	disp0_ctrl = DSI_PORT_READ(DISP0_CTRL);
>   	disp0_ctrl &= ~DSI_DISP0_ENABLE;
>   	DSI_PORT_WRITE(DISP0_CTRL, disp0_ctrl);
>   }
>   
>   static void vc4_dsi_bridge_post_disable(struct drm_bridge *bridge,
> -					struct drm_atomic_state *state)
> +					struct drm_atomic_commit *state)
>   {
>   	struct vc4_dsi *dsi = bridge_to_vc4_dsi(bridge);
>   	struct device *dev = &dsi->pdev->dev;
>   
>   	clk_disable_unprepare(dsi->pll_phy_clock);
> @@ -870,11 +870,11 @@ static bool vc4_dsi_bridge_mode_fixup(struct drm_bridge *bridge,
>   
>   	return true;
>   }
>   
>   static void vc4_dsi_bridge_pre_enable(struct drm_bridge *bridge,
> -				      struct drm_atomic_state *state)
> +				      struct drm_atomic_commit *state)
>   {
>   	struct vc4_dsi *dsi = bridge_to_vc4_dsi(bridge);
>   	const struct drm_crtc_state *crtc_state;
>   	struct device *dev = &dsi->pdev->dev;
>   	const struct drm_display_mode *mode;
> @@ -1139,11 +1139,11 @@ static void vc4_dsi_bridge_pre_enable(struct drm_bridge *bridge,
>   			       DSI_DISP0_COMMAND_MODE);
>   	}
>   }
>   
>   static void vc4_dsi_bridge_enable(struct drm_bridge *bridge,
> -				  struct drm_atomic_state *state)
> +				  struct drm_atomic_commit *state)
>   {
>   	struct vc4_dsi *dsi = bridge_to_vc4_dsi(bridge);
>   	bool debug_dump_regs = false;
>   	u32 disp0_ctrl;
>   
> diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
> index a99f53dadb283cacabbe0df0b7232d5846f8b3f2..a161d3b00a25516e1a494dfaedc2c49dd84924a2 100644
> --- a/drivers/gpu/drm/vc4/vc4_hdmi.c
> +++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
> @@ -453,11 +453,11 @@ static int vc4_hdmi_connector_get_modes(struct drm_connector *connector)
>   
>   	return ret;
>   }
>   
>   static int vc4_hdmi_connector_atomic_check(struct drm_connector *connector,
> -					   struct drm_atomic_state *state)
> +					   struct drm_atomic_commit *state)
>   {
>   	struct drm_connector_state *old_state =
>   		drm_atomic_get_old_connector_state(state, connector);
>   	struct drm_connector_state *new_state =
>   		drm_atomic_get_new_connector_state(state, connector);
> @@ -875,11 +875,11 @@ static void vc4_hdmi_scrambling_wq(struct work_struct *work)
>   	queue_delayed_work(system_percpu_wq, &vc4_hdmi->scrambling_work,
>   			   msecs_to_jiffies(SCRAMBLING_POLLING_DELAY_MS));
>   }
>   
>   static void vc4_hdmi_encoder_post_crtc_disable(struct drm_encoder *encoder,
> -					       struct drm_atomic_state *state)
> +					       struct drm_atomic_commit *state)
>   {
>   	struct vc4_hdmi *vc4_hdmi = encoder_to_vc4_hdmi(encoder);
>   	struct drm_device *drm = vc4_hdmi->connector.dev;
>   	struct vc4_dev *vc4 = to_vc4_dev(drm);
>   	unsigned long flags;
> @@ -925,11 +925,11 @@ static void vc4_hdmi_encoder_post_crtc_disable(struct drm_encoder *encoder,
>   out:
>   	mutex_unlock(&vc4_hdmi->mutex);
>   }
>   
>   static void vc4_hdmi_encoder_post_crtc_powerdown(struct drm_encoder *encoder,
> -						 struct drm_atomic_state *state)
> +						 struct drm_atomic_commit *state)
>   {
>   	struct vc4_hdmi *vc4_hdmi = encoder_to_vc4_hdmi(encoder);
>   	struct drm_device *drm = vc4_hdmi->connector.dev;
>   	unsigned long flags;
>   	int idx;
> @@ -1469,11 +1469,11 @@ static void vc4_hdmi_recenter_fifo(struct vc4_hdmi *vc4_hdmi)
>   
>   	drm_dev_exit(idx);
>   }
>   
>   static void vc4_hdmi_encoder_pre_crtc_configure(struct drm_encoder *encoder,
> -						struct drm_atomic_state *state)
> +						struct drm_atomic_commit *state)
>   {
>   	struct vc4_hdmi *vc4_hdmi = encoder_to_vc4_hdmi(encoder);
>   	struct drm_device *drm = vc4_hdmi->connector.dev;
>   	struct drm_connector *connector = &vc4_hdmi->connector;
>   	struct drm_connector_state *conn_state =
> @@ -1585,11 +1585,11 @@ static void vc4_hdmi_encoder_pre_crtc_configure(struct drm_encoder *encoder,
>   	mutex_unlock(&vc4_hdmi->mutex);
>   	return;
>   }
>   
>   static void vc4_hdmi_encoder_pre_crtc_enable(struct drm_encoder *encoder,
> -					     struct drm_atomic_state *state)
> +					     struct drm_atomic_commit *state)
>   {
>   	struct vc4_hdmi *vc4_hdmi = encoder_to_vc4_hdmi(encoder);
>   	struct drm_device *drm = vc4_hdmi->connector.dev;
>   	struct drm_connector *connector = &vc4_hdmi->connector;
>   	const struct drm_display_mode *mode = &vc4_hdmi->saved_adjusted_mode;
> @@ -1615,11 +1615,11 @@ static void vc4_hdmi_encoder_pre_crtc_enable(struct drm_encoder *encoder,
>   out:
>   	mutex_unlock(&vc4_hdmi->mutex);
>   }
>   
>   static void vc4_hdmi_encoder_post_crtc_enable(struct drm_encoder *encoder,
> -					      struct drm_atomic_state *state)
> +					      struct drm_atomic_commit *state)
>   {
>   	struct vc4_hdmi *vc4_hdmi = encoder_to_vc4_hdmi(encoder);
>   	struct drm_connector *connector = &vc4_hdmi->connector;
>   	struct drm_device *drm = connector->dev;
>   	const struct drm_display_mode *mode = &vc4_hdmi->saved_adjusted_mode;
> diff --git a/drivers/gpu/drm/vc4/vc4_hvs.c b/drivers/gpu/drm/vc4/vc4_hvs.c
> index ee8d0738501b874a38e7193bb2c9aae3e8c5675c..184d51ea3fa57abf59c315c53cb43a8ba2ff0ead 100644
> --- a/drivers/gpu/drm/vc4/vc4_hvs.c
> +++ b/drivers/gpu/drm/vc4/vc4_hvs.c
> @@ -785,11 +785,11 @@ void vc4_hvs_stop_channel(struct vc4_hvs *hvs, unsigned int chan)
>   		__vc6_hvs_stop_channel(hvs, chan);
>   	else
>   		__vc4_hvs_stop_channel(hvs, chan);
>   }
>   
> -int vc4_hvs_atomic_check(struct drm_crtc *crtc, struct drm_atomic_state *state)
> +int vc4_hvs_atomic_check(struct drm_crtc *crtc, struct drm_atomic_commit *state)
>   {
>   	struct drm_crtc_state *crtc_state = drm_atomic_get_new_crtc_state(state, crtc);
>   	struct vc4_crtc_state *vc4_state = to_vc4_crtc_state(crtc_state);
>   	struct drm_device *dev = crtc->dev;
>   	struct vc4_dev *vc4 = to_vc4_dev(dev);
> @@ -880,11 +880,11 @@ static void vc4_hvs_update_dlist(struct drm_crtc *crtc)
>   	vc4_crtc->current_dlist = vc4_state->mm.start;
>   	spin_unlock_irqrestore(&vc4_crtc->irq_lock, flags);
>   }
>   
>   void vc4_hvs_atomic_begin(struct drm_crtc *crtc,
> -			  struct drm_atomic_state *state)
> +			  struct drm_atomic_commit *state)
>   {
>   	struct vc4_crtc *vc4_crtc = to_vc4_crtc(crtc);
>   	struct vc4_crtc_state *vc4_state = to_vc4_crtc_state(crtc->state);
>   	unsigned long flags;
>   
> @@ -892,11 +892,11 @@ void vc4_hvs_atomic_begin(struct drm_crtc *crtc,
>   	vc4_crtc->current_hvs_channel = vc4_state->assigned_channel;
>   	spin_unlock_irqrestore(&vc4_crtc->irq_lock, flags);
>   }
>   
>   void vc4_hvs_atomic_enable(struct drm_crtc *crtc,
> -			   struct drm_atomic_state *state)
> +			   struct drm_atomic_commit *state)
>   {
>   	struct drm_device *dev = crtc->dev;
>   	struct vc4_dev *vc4 = to_vc4_dev(dev);
>   	struct drm_display_mode *mode = &crtc->state->adjusted_mode;
>   	struct vc4_crtc *vc4_crtc = to_vc4_crtc(crtc);
> @@ -910,11 +910,11 @@ void vc4_hvs_atomic_enable(struct drm_crtc *crtc,
>   	else
>   		vc4_hvs_init_channel(vc4->hvs, crtc, mode, oneshot);
>   }
>   
>   void vc4_hvs_atomic_disable(struct drm_crtc *crtc,
> -			    struct drm_atomic_state *state)
> +			    struct drm_atomic_commit *state)
>   {
>   	struct drm_device *dev = crtc->dev;
>   	struct vc4_dev *vc4 = to_vc4_dev(dev);
>   	struct drm_crtc_state *old_state = drm_atomic_get_old_crtc_state(state, crtc);
>   	struct vc4_crtc_state *vc4_state = to_vc4_crtc_state(old_state);
> @@ -922,11 +922,11 @@ void vc4_hvs_atomic_disable(struct drm_crtc *crtc,
>   
>   	vc4_hvs_stop_channel(vc4->hvs, chan);
>   }
>   
>   void vc4_hvs_atomic_flush(struct drm_crtc *crtc,
> -			  struct drm_atomic_state *state)
> +			  struct drm_atomic_commit *state)
>   {
>   	struct drm_crtc_state *old_state = drm_atomic_get_old_crtc_state(state,
>   									 crtc);
>   	struct drm_device *dev = crtc->dev;
>   	struct vc4_dev *vc4 = to_vc4_dev(dev);
> diff --git a/drivers/gpu/drm/vc4/vc4_kms.c b/drivers/gpu/drm/vc4/vc4_kms.c
> index 264b5e80c24d67f59dea8085f7d02d218db25697..b17e73bce3841a0a1640b17e7fae7c7d58659c84 100644
> --- a/drivers/gpu/drm/vc4/vc4_kms.c
> +++ b/drivers/gpu/drm/vc4/vc4_kms.c
> @@ -42,11 +42,11 @@ struct vc4_load_tracker_state {
>   };
>   
>   #define to_vc4_load_tracker_state(_state)				\
>   	container_of_const(_state, struct vc4_load_tracker_state, base)
>   
> -static struct vc4_ctm_state *vc4_get_ctm_state(struct drm_atomic_state *state,
> +static struct vc4_ctm_state *vc4_get_ctm_state(struct drm_atomic_commit *state,
>   					       struct drm_private_obj *manager)
>   {
>   	struct drm_device *dev = state->dev;
>   	struct vc4_dev *vc4 = to_vc4_dev(dev);
>   	struct drm_private_state *priv_state;
> @@ -140,11 +140,11 @@ static u16 vc4_ctm_s31_32_to_s0_9(u64 in)
>   
>   	return r;
>   }
>   
>   static void
> -vc4_ctm_commit(struct vc4_dev *vc4, struct drm_atomic_state *state)
> +vc4_ctm_commit(struct vc4_dev *vc4, struct drm_atomic_commit *state)
>   {
>   	struct vc4_hvs *hvs = vc4->hvs;
>   	struct vc4_ctm_state *ctm_state = to_vc4_ctm_state(vc4->ctm_manager.state);
>   	struct drm_color_ctm *ctm = ctm_state->ctm;
>   
> @@ -177,11 +177,11 @@ vc4_ctm_commit(struct vc4_dev *vc4, struct drm_atomic_state *state)
>   	HVS_WRITE(SCALER_OLEDOFFS,
>   		  VC4_SET_FIELD(ctm_state->fifo, SCALER_OLEDOFFS_DISPFIFO));
>   }
>   
>   struct vc4_hvs_state *
> -vc4_hvs_get_new_global_state(const struct drm_atomic_state *state)
> +vc4_hvs_get_new_global_state(const struct drm_atomic_commit *state)
>   {
>   	struct vc4_dev *vc4 = to_vc4_dev(state->dev);
>   	struct drm_private_state *priv_state;
>   
>   	priv_state = drm_atomic_get_new_private_obj_state(state, &vc4->hvs_channels);
> @@ -190,11 +190,11 @@ vc4_hvs_get_new_global_state(const struct drm_atomic_state *state)
>   
>   	return to_vc4_hvs_state(priv_state);
>   }
>   
>   struct vc4_hvs_state *
> -vc4_hvs_get_old_global_state(const struct drm_atomic_state *state)
> +vc4_hvs_get_old_global_state(const struct drm_atomic_commit *state)
>   {
>   	struct vc4_dev *vc4 = to_vc4_dev(state->dev);
>   	struct drm_private_state *priv_state;
>   
>   	priv_state = drm_atomic_get_old_private_obj_state(state, &vc4->hvs_channels);
> @@ -203,11 +203,11 @@ vc4_hvs_get_old_global_state(const struct drm_atomic_state *state)
>   
>   	return to_vc4_hvs_state(priv_state);
>   }
>   
>   struct vc4_hvs_state *
> -vc4_hvs_get_global_state(struct drm_atomic_state *state)
> +vc4_hvs_get_global_state(struct drm_atomic_commit *state)
>   {
>   	struct vc4_dev *vc4 = to_vc4_dev(state->dev);
>   	struct drm_private_state *priv_state;
>   
>   	priv_state = drm_atomic_get_private_obj_state(state, &vc4->hvs_channels);
> @@ -216,11 +216,11 @@ vc4_hvs_get_global_state(struct drm_atomic_state *state)
>   
>   	return to_vc4_hvs_state(priv_state);
>   }
>   
>   static void vc4_hvs_pv_muxing_commit(struct vc4_dev *vc4,
> -				     struct drm_atomic_state *state)
> +				     struct drm_atomic_commit *state)
>   {
>   	struct vc4_hvs *hvs = vc4->hvs;
>   	struct drm_crtc_state *crtc_state;
>   	struct drm_crtc *crtc;
>   	unsigned int i;
> @@ -259,11 +259,11 @@ static void vc4_hvs_pv_muxing_commit(struct vc4_dev *vc4,
>   		HVS_WRITE(SCALER_DISPCTRL, dispctrl | dsp3_mux);
>   	}
>   }
>   
>   static void vc5_hvs_pv_muxing_commit(struct vc4_dev *vc4,
> -				     struct drm_atomic_state *state)
> +				     struct drm_atomic_commit *state)
>   {
>   	struct vc4_hvs *hvs = vc4->hvs;
>   	struct drm_crtc_state *crtc_state;
>   	struct drm_crtc *crtc;
>   	unsigned char mux;
> @@ -335,11 +335,11 @@ static void vc5_hvs_pv_muxing_commit(struct vc4_dev *vc4,
>   		}
>   	}
>   }
>   
>   static void vc6_hvs_pv_muxing_commit(struct vc4_dev *vc4,
> -				     struct drm_atomic_state *state)
> +				     struct drm_atomic_commit *state)
>   {
>   	struct vc4_hvs *hvs = vc4->hvs;
>   	struct drm_crtc_state *crtc_state;
>   	struct drm_crtc *crtc;
>   	unsigned int i;
> @@ -382,11 +382,11 @@ static void vc6_hvs_pv_muxing_commit(struct vc4_dev *vc4,
>   			  (reg & ~SCALER6_CONTROL_DSP1_TARGET_MASK) |
>   			  VC4_SET_FIELD(mux, SCALER6_CONTROL_DSP1_TARGET));
>   	}
>   }
>   
> -static void vc4_atomic_commit_tail(struct drm_atomic_state *state)
> +static void vc4_atomic_commit_tail(struct drm_atomic_commit *state)
>   {
>   	struct drm_device *dev = state->dev;
>   	struct vc4_dev *vc4 = to_vc4_dev(dev);
>   	struct vc4_hvs *hvs = vc4->hvs;
>   	struct vc4_hvs_state *new_hvs_state;
> @@ -506,11 +506,11 @@ static void vc4_atomic_commit_tail(struct drm_atomic_state *state)
>   		drm_dbg(dev, "Core clock actual rate: %lu Hz\n",
>   			clk_get_rate(hvs->core_clk));
>   	}
>   }
>   
> -static int vc4_atomic_commit_setup(struct drm_atomic_state *state)
> +static int vc4_atomic_commit_setup(struct drm_atomic_commit *state)
>   {
>   	struct drm_crtc_state *crtc_state;
>   	struct vc4_hvs_state *hvs_state;
>   	struct drm_crtc *crtc;
>   	unsigned int i;
> @@ -585,11 +585,11 @@ static struct drm_framebuffer *vc4_fb_create(struct drm_device *dev,
>   /* Our CTM has some peculiar limitations: we can only enable it for one CRTC
>    * at a time and the HW only supports S0.9 scalars. To account for the latter,
>    * we don't allow userland to set a CTM that we have no hope of approximating.
>    */
>   static int
> -vc4_ctm_atomic_check(struct drm_device *dev, struct drm_atomic_state *state)
> +vc4_ctm_atomic_check(struct drm_device *dev, struct drm_atomic_commit *state)
>   {
>   	struct vc4_dev *vc4 = to_vc4_dev(dev);
>   	struct vc4_ctm_state *ctm_state = NULL;
>   	struct drm_crtc *crtc;
>   	struct drm_crtc_state *old_crtc_state, *new_crtc_state;
> @@ -651,11 +651,11 @@ vc4_ctm_atomic_check(struct drm_device *dev, struct drm_atomic_state *state)
>   	}
>   
>   	return 0;
>   }
>   
> -static int vc4_load_tracker_atomic_check(struct drm_atomic_state *state)
> +static int vc4_load_tracker_atomic_check(struct drm_atomic_commit *state)
>   {
>   	struct drm_plane_state *old_plane_state, *new_plane_state;
>   	struct vc4_dev *vc4 = to_vc4_dev(state->dev);
>   	struct vc4_load_tracker_state *load_state;
>   	struct drm_private_state *priv_state;
> @@ -896,11 +896,11 @@ static int cmp_vc4_crtc_hvs_output(const void *a, const void *b)
>    *   as the CRTC is enabled, only considering it free again once that
>    *   CRTC has been disabled. This can be tested by booting X11 on a
>    *   single display, and changing the resolution down and then back up.
>    */
>   static int vc4_pv_muxing_atomic_check(struct drm_device *dev,
> -				      struct drm_atomic_state *state)
> +				      struct drm_atomic_commit *state)
>   {
>   	struct vc4_hvs_state *hvs_new_state;
>   	struct drm_crtc **sorted_crtcs;
>   	struct drm_crtc *crtc;
>   	unsigned int unassigned_channels = 0;
> @@ -1017,11 +1017,11 @@ static int vc4_pv_muxing_atomic_check(struct drm_device *dev,
>   	kfree(sorted_crtcs);
>   	return ret;
>   }
>   
>   static int
> -vc4_core_clock_atomic_check(struct drm_atomic_state *state)
> +vc4_core_clock_atomic_check(struct drm_atomic_commit *state)
>   {
>   	struct vc4_dev *vc4 = to_vc4_dev(state->dev);
>   	struct drm_private_state *priv_state;
>   	struct vc4_hvs_state *hvs_new_state;
>   	struct vc4_load_tracker_state *load_state;
> @@ -1089,11 +1089,11 @@ vc4_core_clock_atomic_check(struct drm_atomic_state *state)
>   	return 0;
>   }
>   
>   
>   static int
> -vc4_atomic_check(struct drm_device *dev, struct drm_atomic_state *state)
> +vc4_atomic_check(struct drm_device *dev, struct drm_atomic_commit *state)
>   {
>   	int ret;
>   
>   	ret = vc4_pv_muxing_atomic_check(dev, state);
>   	if (ret)
> diff --git a/drivers/gpu/drm/vc4/vc4_plane.c b/drivers/gpu/drm/vc4/vc4_plane.c
> index 91d499fefba2189131ff96270a9b001d694ab2ae..3a510053fc54cfb6062b5724582a8be7a1542eb9 100644
> --- a/drivers/gpu/drm/vc4/vc4_plane.c
> +++ b/drivers/gpu/drm/vc4/vc4_plane.c
> @@ -2123,11 +2123,11 @@ static int vc6_plane_mode_set(struct drm_plane *plane,
>    * corresponding vc4_plane_atomic_update) won't get called.  Thus, we
>    * compute the dlist here and have all active plane dlists get updated
>    * in the CRTC's flush.
>    */
>   static int vc4_plane_atomic_check(struct drm_plane *plane,
> -				  struct drm_atomic_state *state)
> +				  struct drm_atomic_commit *state)
>   {
>   	struct vc4_dev *vc4 = to_vc4_dev(plane->dev);
>   	struct drm_plane_state *new_plane_state = drm_atomic_get_new_plane_state(state,
>   										 plane);
>   	struct vc4_plane_state *vc4_state = to_vc4_plane_state(new_plane_state);
> @@ -2169,11 +2169,11 @@ static int vc4_plane_atomic_check(struct drm_plane *plane,
>   
>   	return 0;
>   }
>   
>   static void vc4_plane_atomic_update(struct drm_plane *plane,
> -				    struct drm_atomic_state *state)
> +				    struct drm_atomic_commit *state)
>   {
>   	/* No contents here.  Since we don't know where in the CRTC's
>   	 * dlist we should be stored, our dlist is uploaded to the
>   	 * hardware with vc4_plane_write_dlist() at CRTC atomic_flush
>   	 * time.
> @@ -2261,11 +2261,11 @@ void vc4_plane_async_set_fb(struct drm_plane *plane, struct drm_framebuffer *fb)
>   
>   	drm_dev_exit(idx);
>   }
>   
>   static void vc4_plane_atomic_async_update(struct drm_plane *plane,
> -					  struct drm_atomic_state *state)
> +					  struct drm_atomic_commit *state)
>   {
>   	struct drm_plane_state *new_plane_state = drm_atomic_get_new_plane_state(state,
>   										 plane);
>   	struct vc4_plane_state *vc4_state, *new_vc4_state;
>   	int idx;
> @@ -2335,11 +2335,11 @@ static void vc4_plane_atomic_async_update(struct drm_plane *plane,
>   
>   	drm_dev_exit(idx);
>   }
>   
>   static int vc4_plane_atomic_async_check(struct drm_plane *plane,
> -					struct drm_atomic_state *state, bool flip)
> +					struct drm_atomic_commit *state, bool flip)
>   {
>   	struct vc4_dev *vc4 = to_vc4_dev(plane->dev);
>   	struct drm_plane_state *new_plane_state = drm_atomic_get_new_plane_state(state,
>   										 plane);
>   	struct vc4_plane_state *old_vc4_state, *new_vc4_state;
> diff --git a/drivers/gpu/drm/vc4/vc4_txp.c b/drivers/gpu/drm/vc4/vc4_txp.c
> index 9082902100e4bbeb776e47e51121344be7fe1df4..66b6f2acf86269928ee64d90d6c7987164184e06 100644
> --- a/drivers/gpu/drm/vc4/vc4_txp.c
> +++ b/drivers/gpu/drm/vc4/vc4_txp.c
> @@ -244,11 +244,11 @@ static void vc4_txp_armed(struct drm_crtc_state *state)
>   
>   	vc4_state->txp_armed = true;
>   }
>   
>   static int vc4_txp_connector_atomic_check(struct drm_connector *conn,
> -					  struct drm_atomic_state *state)
> +					  struct drm_atomic_commit *state)
>   {
>   	struct drm_connector_state *conn_state;
>   	struct drm_crtc_state *crtc_state;
>   	struct drm_framebuffer *fb;
>   	int i;
> @@ -283,11 +283,11 @@ static int vc4_txp_connector_atomic_check(struct drm_connector *conn,
>   
>   	return 0;
>   }
>   
>   static void vc4_txp_connector_atomic_commit(struct drm_connector *conn,
> -					struct drm_atomic_state *state)
> +					struct drm_atomic_commit *state)
>   {
>   	struct drm_device *drm = conn->dev;
>   	struct drm_connector_state *conn_state = drm_atomic_get_new_connector_state(state,
>   										    conn);
>   	struct vc4_txp *txp = connector_to_vc4_txp(conn);
> @@ -433,11 +433,11 @@ static const struct drm_crtc_funcs vc4_txp_crtc_funcs = {
>   	.disable_vblank		= vc4_txp_disable_vblank,
>   	.late_register		= vc4_crtc_late_register,
>   };
>   
>   static int vc4_txp_atomic_check(struct drm_crtc *crtc,
> -				struct drm_atomic_state *state)
> +				struct drm_atomic_commit *state)
>   {
>   	struct drm_crtc_state *crtc_state = drm_atomic_get_new_crtc_state(state,
>   									  crtc);
>   	int ret;
>   
> @@ -449,18 +449,18 @@ static int vc4_txp_atomic_check(struct drm_crtc *crtc,
>   
>   	return 0;
>   }
>   
>   static void vc4_txp_atomic_enable(struct drm_crtc *crtc,
> -				  struct drm_atomic_state *state)
> +				  struct drm_atomic_commit *state)
>   {
>   	drm_crtc_vblank_on(crtc);
>   	vc4_hvs_atomic_enable(crtc, state);
>   }
>   
>   static void vc4_txp_atomic_disable(struct drm_crtc *crtc,
> -				   struct drm_atomic_state *state)
> +				   struct drm_atomic_commit *state)
>   {
>   	struct drm_device *dev = crtc->dev;
>   
>   	/* Disable vblank irq handling before crtc is disabled. */
>   	drm_crtc_vblank_off(crtc);
> diff --git a/drivers/gpu/drm/vc4/vc4_vec.c b/drivers/gpu/drm/vc4/vc4_vec.c
> index b0b271d93b276282ff98ca9449d1174c252607d1..792b7b39be597fcd502f7ce4bac61835c99ab6a2 100644
> --- a/drivers/gpu/drm/vc4/vc4_vec.c
> +++ b/drivers/gpu/drm/vc4/vc4_vec.c
> @@ -536,11 +536,11 @@ static int vc4_vec_connector_init(struct drm_device *dev, struct vc4_vec *vec)
>   
>   	return 0;
>   }
>   
>   static void vc4_vec_encoder_disable(struct drm_encoder *encoder,
> -				    struct drm_atomic_state *state)
> +				    struct drm_atomic_commit *state)
>   {
>   	struct drm_device *drm = encoder->dev;
>   	struct vc4_vec *vec = encoder_to_vc4_vec(encoder);
>   	int idx;
>   
> @@ -560,11 +560,11 @@ static void vc4_vec_encoder_disable(struct drm_encoder *encoder,
>   
>   	drm_dev_exit(idx);
>   }
>   
>   static void vc4_vec_encoder_enable(struct drm_encoder *encoder,
> -				   struct drm_atomic_state *state)
> +				   struct drm_atomic_commit *state)
>   {
>   	struct drm_device *drm = encoder->dev;
>   	struct vc4_vec *vec = encoder_to_vc4_vec(encoder);
>   	struct drm_connector *connector = &vec->connector;
>   	struct drm_connector_state *conn_state =
> diff --git a/drivers/gpu/drm/verisilicon/vs_bridge.c b/drivers/gpu/drm/verisilicon/vs_bridge.c
> index 2a0ad00a94d6d15b0c8c6a96bf7d4f48e330a558..17add75b8878fe2838bbb4b3de30a57dc3dd82f8 100644
> --- a/drivers/gpu/drm/verisilicon/vs_bridge.c
> +++ b/drivers/gpu/drm/verisilicon/vs_bridge.c
> @@ -172,11 +172,11 @@ static void vs_bridge_enable_common(struct vs_crtc *crtc,
>   	regmap_set_bits(dc->regs, VSDC_DISP_PANEL_CONFIG_EX(crtc->id),
>   			VSDC_DISP_PANEL_CONFIG_EX_COMMIT);
>   }
>   
>   static void vs_bridge_atomic_enable_dpi(struct drm_bridge *bridge,
> -					struct drm_atomic_state *state)
> +					struct drm_atomic_commit *state)
>   {
>   	struct vs_bridge *vbridge = drm_bridge_to_vs_bridge(bridge);
>   	struct drm_bridge_state *br_state =
>   		drm_atomic_get_new_bridge_state(state, bridge);
>   	struct vs_crtc *crtc = vbridge->crtc;
> @@ -190,11 +190,11 @@ static void vs_bridge_atomic_enable_dpi(struct drm_bridge *bridge,
>   
>   	vs_bridge_enable_common(crtc, br_state);
>   }
>   
>   static void vs_bridge_atomic_enable_dp(struct drm_bridge *bridge,
> -					struct drm_atomic_state *state)
> +					struct drm_atomic_commit *state)
>   {
>   	struct vs_bridge *vbridge = drm_bridge_to_vs_bridge(bridge);
>   	struct drm_bridge_state *br_state =
>   		drm_atomic_get_new_bridge_state(state, bridge);
>   	struct vs_crtc *crtc = vbridge->crtc;
> @@ -219,11 +219,11 @@ static void vs_bridge_atomic_enable_dp(struct drm_bridge *bridge,
>   
>   	vs_bridge_enable_common(crtc, br_state);
>   }
>   
>   static void vs_bridge_atomic_disable(struct drm_bridge *bridge,
> -				     struct drm_atomic_state *state)
> +				     struct drm_atomic_commit *state)
>   {
>   	struct vs_bridge *vbridge = drm_bridge_to_vs_bridge(bridge);
>   	struct vs_crtc *crtc = vbridge->crtc;
>   	struct vs_dc *dc = crtc->dc;
>   	unsigned int output = crtc->id;
> diff --git a/drivers/gpu/drm/verisilicon/vs_crtc.c b/drivers/gpu/drm/verisilicon/vs_crtc.c
> index f49401713000677cf1c4717412f4e5dee2d39add..9080344398ca2f717f60f0776e5c8c2b8e77ca3a 100644
> --- a/drivers/gpu/drm/verisilicon/vs_crtc.c
> +++ b/drivers/gpu/drm/verisilicon/vs_crtc.c
> @@ -19,11 +19,11 @@
>   #include "vs_dc_top_regs.h"
>   #include "vs_drm.h"
>   #include "vs_plane.h"
>   
>   static void vs_crtc_atomic_disable(struct drm_crtc *crtc,
> -				   struct drm_atomic_state *state)
> +				   struct drm_atomic_commit *state)
>   {
>   	struct vs_crtc *vcrtc = drm_crtc_to_vs_crtc(crtc);
>   	struct vs_dc *dc = vcrtc->dc;
>   	unsigned int output = vcrtc->id;
>   
> @@ -31,11 +31,11 @@ static void vs_crtc_atomic_disable(struct drm_crtc *crtc,
>   
>   	clk_disable_unprepare(dc->pix_clk[output]);
>   }
>   
>   static void vs_crtc_atomic_enable(struct drm_crtc *crtc,
> -				  struct drm_atomic_state *state)
> +				  struct drm_atomic_commit *state)
>   {
>   	struct vs_crtc *vcrtc = drm_crtc_to_vs_crtc(crtc);
>   	struct vs_dc *dc = vcrtc->dc;
>   	unsigned int output = vcrtc->id;
>   
> diff --git a/drivers/gpu/drm/verisilicon/vs_primary_plane.c b/drivers/gpu/drm/verisilicon/vs_primary_plane.c
> index e8fcb5958615c09627ecb9ffec2dd9e5c7edead8..f3bf18c0e168f52323d15d4e3ecd435ce7dabd37 100644
> --- a/drivers/gpu/drm/verisilicon/vs_primary_plane.c
> +++ b/drivers/gpu/drm/verisilicon/vs_primary_plane.c
> @@ -19,11 +19,11 @@
>   #include "vs_plane.h"
>   #include "vs_dc.h"
>   #include "vs_primary_plane_regs.h"
>   
>   static int vs_primary_plane_atomic_check(struct drm_plane *plane,
> -					 struct drm_atomic_state *state)
> +					 struct drm_atomic_commit *state)
>   {
>   	struct drm_plane_state *new_plane_state = drm_atomic_get_new_plane_state(state,
>   										 plane);
>   	struct drm_crtc *crtc = new_plane_state->crtc;
>   	struct drm_crtc_state *crtc_state;
> @@ -47,11 +47,11 @@ static void vs_primary_plane_commit(struct vs_dc *dc, unsigned int output)
>   	regmap_set_bits(dc->regs, VSDC_FB_CONFIG_EX(output),
>   			VSDC_FB_CONFIG_EX_COMMIT);
>   }
>   
>   static void vs_primary_plane_atomic_enable(struct drm_plane *plane,
> -					   struct drm_atomic_state *atomic_state)
> +					   struct drm_atomic_commit *atomic_state)
>   {
>   	struct drm_plane_state *state = drm_atomic_get_new_plane_state(atomic_state,
>   								       plane);
>   	struct drm_crtc *crtc = state->crtc;
>   	struct vs_crtc *vcrtc = drm_crtc_to_vs_crtc(crtc);
> @@ -66,11 +66,11 @@ static void vs_primary_plane_atomic_enable(struct drm_plane *plane,
>   
>   	vs_primary_plane_commit(dc, output);
>   }
>   
>   static void vs_primary_plane_atomic_disable(struct drm_plane *plane,
> -					    struct drm_atomic_state *atomic_state)
> +					    struct drm_atomic_commit *atomic_state)
>   {
>   	struct drm_plane_state *state = drm_atomic_get_old_plane_state(atomic_state,
>   								       plane);
>   	struct drm_crtc *crtc = state->crtc;
>   	struct vs_crtc *vcrtc = drm_crtc_to_vs_crtc(crtc);
> @@ -82,11 +82,11 @@ static void vs_primary_plane_atomic_disable(struct drm_plane *plane,
>   
>   	vs_primary_plane_commit(dc, output);
>   }
>   
>   static void vs_primary_plane_atomic_update(struct drm_plane *plane,
> -					   struct drm_atomic_state *atomic_state)
> +					   struct drm_atomic_commit *atomic_state)
>   {
>   	struct drm_plane_state *state = drm_atomic_get_new_plane_state(atomic_state,
>   								       plane);
>   	struct drm_framebuffer *fb = state->fb;
>   	struct drm_crtc *crtc = state->crtc;
> diff --git a/drivers/gpu/drm/virtio/virtgpu_display.c b/drivers/gpu/drm/virtio/virtgpu_display.c
> index f1dae956980530ab4acafe55b27bf3c7dc547a03..44ffffec550fdcf1fd17635d2ef05835464adb70 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_display.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_display.c
> @@ -99,17 +99,17 @@ static void virtio_gpu_crtc_mode_set_nofb(struct drm_crtc *crtc)
>   				   crtc->mode.vdisplay, 0, 0);
>   	virtio_gpu_notify(vgdev);
>   }
>   
>   static void virtio_gpu_crtc_atomic_enable(struct drm_crtc *crtc,
> -					  struct drm_atomic_state *state)
> +					  struct drm_atomic_commit *state)
>   {
>   	drm_crtc_vblank_on(crtc);
>   }
>   
>   static void virtio_gpu_crtc_atomic_disable(struct drm_crtc *crtc,
> -					   struct drm_atomic_state *state)
> +					   struct drm_atomic_commit *state)
>   {
>   	struct drm_device *dev = crtc->dev;
>   	struct virtio_gpu_device *vgdev = dev->dev_private;
>   	struct virtio_gpu_output *output = drm_crtc_to_virtio_gpu_output(crtc);
>   
> @@ -118,17 +118,17 @@ static void virtio_gpu_crtc_atomic_disable(struct drm_crtc *crtc,
>   	virtio_gpu_cmd_set_scanout(vgdev, output->index, 0, 0, 0, 0, 0);
>   	virtio_gpu_notify(vgdev);
>   }
>   
>   static int virtio_gpu_crtc_atomic_check(struct drm_crtc *crtc,
> -					struct drm_atomic_state *state)
> +					struct drm_atomic_commit *state)
>   {
>   	return 0;
>   }
>   
>   static void virtio_gpu_crtc_atomic_flush(struct drm_crtc *crtc,
> -					 struct drm_atomic_state *state)
> +					 struct drm_atomic_commit *state)
>   {
>   	struct drm_device *dev = crtc->dev;
>   	struct drm_crtc_state *crtc_state = drm_atomic_get_new_crtc_state(state, crtc);
>   	struct virtio_gpu_output *output = drm_crtc_to_virtio_gpu_output(crtc);
>   	struct drm_pending_vblank_event *event;
> diff --git a/drivers/gpu/drm/virtio/virtgpu_plane.c b/drivers/gpu/drm/virtio/virtgpu_plane.c
> index a126d1b25f46436055f0121ccff9289ae1bf7974..73aa70bd42310bd12807cfd543e8876e508981ea 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_plane.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_plane.c
> @@ -95,11 +95,11 @@ static const struct drm_plane_funcs virtio_gpu_plane_funcs = {
>   	.atomic_duplicate_state = virtio_gpu_plane_duplicate_state,
>   	.atomic_destroy_state	= drm_atomic_helper_plane_destroy_state,
>   };
>   
>   static int virtio_gpu_plane_atomic_check(struct drm_plane *plane,
> -					 struct drm_atomic_state *state)
> +					 struct drm_atomic_commit *state)
>   {
>   	struct drm_plane_state *new_plane_state = drm_atomic_get_new_plane_state(state,
>   										 plane);
>   	struct drm_plane_state *old_plane_state = drm_atomic_get_old_plane_state(state,
>   										 plane);
> @@ -228,11 +228,11 @@ static void virtio_gpu_resource_flush(struct drm_plane *plane,
>   		virtio_gpu_notify(vgdev);
>   	}
>   }
>   
>   static void virtio_gpu_primary_plane_update(struct drm_plane *plane,
> -					    struct drm_atomic_state *state)
> +					    struct drm_atomic_commit *state)
>   {
>   	struct drm_plane_state *old_state = drm_atomic_get_old_plane_state(state,
>   									   plane);
>   	struct drm_device *dev = plane->dev;
>   	struct virtio_gpu_device *vgdev = dev->dev_private;
> @@ -421,11 +421,11 @@ static void virtio_gpu_plane_cleanup_fb(struct drm_plane *plane,
>   	if (drm_gem_is_imported(obj))
>   		virtio_gpu_cleanup_imported_obj(obj);
>   }
>   
>   static void virtio_gpu_cursor_plane_update(struct drm_plane *plane,
> -					   struct drm_atomic_state *state)
> +					   struct drm_atomic_commit *state)
>   {
>   	struct drm_plane_state *old_state = drm_atomic_get_old_plane_state(state,
>   									   plane);
>   	struct drm_device *dev = plane->dev;
>   	struct virtio_gpu_device *vgdev = dev->dev_private;
> diff --git a/drivers/gpu/drm/vkms/vkms_crtc.c b/drivers/gpu/drm/vkms/vkms_crtc.c
> index 35ddc553a5e663368754e1b6dd0148d830fe53a8..079abfba427d077976a34281a12613bb93b9437c 100644
> --- a/drivers/gpu/drm/vkms/vkms_crtc.c
> +++ b/drivers/gpu/drm/vkms/vkms_crtc.c
> @@ -109,11 +109,11 @@ static const struct drm_crtc_funcs vkms_crtc_funcs = {
>   	.set_crc_source		= vkms_set_crc_source,
>   	.verify_crc_source	= vkms_verify_crc_source,
>   };
>   
>   static int vkms_crtc_atomic_check(struct drm_crtc *crtc,
> -				  struct drm_atomic_state *state)
> +				  struct drm_atomic_commit *state)
>   {
>   	struct drm_crtc_state *crtc_state = drm_atomic_get_new_crtc_state(state,
>   									  crtc);
>   	struct vkms_crtc_state *vkms_state = to_vkms_crtc_state(crtc_state);
>   	struct drm_plane *plane;
> @@ -155,11 +155,11 @@ static int vkms_crtc_atomic_check(struct drm_crtc *crtc,
>   
>   	return 0;
>   }
>   
>   static void vkms_crtc_atomic_begin(struct drm_crtc *crtc,
> -				   struct drm_atomic_state *state)
> +				   struct drm_atomic_commit *state)
>   	__acquires(&vkms_output->lock)
>   {
>   	struct vkms_output *vkms_output = drm_crtc_to_vkms_output(crtc);
>   
>   	/* This lock is held across the atomic commit to block vblank timer
> @@ -167,11 +167,11 @@ static void vkms_crtc_atomic_begin(struct drm_crtc *crtc,
>   	 */
>   	spin_lock_irq(&vkms_output->lock);
>   }
>   
>   static void vkms_crtc_atomic_flush(struct drm_crtc *crtc,
> -				   struct drm_atomic_state *state)
> +				   struct drm_atomic_commit *state)
>   	__releases(&vkms_output->lock)
>   {
>   	struct vkms_output *vkms_output = drm_crtc_to_vkms_output(crtc);
>   
>   	if (crtc->state->event) {
> diff --git a/drivers/gpu/drm/vkms/vkms_drv.c b/drivers/gpu/drm/vkms/vkms_drv.c
> index 95020765c4c29977e45b609ac88dc00db24f62ef..5a640b531d88f5394a44ceab1d8c2d976004d18c 100644
> --- a/drivers/gpu/drm/vkms/vkms_drv.c
> +++ b/drivers/gpu/drm/vkms/vkms_drv.c
> @@ -60,11 +60,11 @@ static bool create_default_dev = true;
>   module_param_named(create_default_dev, create_default_dev, bool, 0444);
>   MODULE_PARM_DESC(create_default_dev, "Create or not the default VKMS device");
>   
>   DEFINE_DRM_GEM_FOPS(vkms_driver_fops);
>   
> -static void vkms_atomic_commit_tail(struct drm_atomic_state *old_state)
> +static void vkms_atomic_commit_tail(struct drm_atomic_commit *old_state)
>   {
>   	struct drm_device *dev = old_state->dev;
>   	struct drm_crtc *crtc;
>   	struct drm_crtc_state *old_crtc_state;
>   	int i;
> @@ -100,11 +100,11 @@ static const struct drm_driver vkms_driver = {
>   	.desc			= DRIVER_DESC,
>   	.major			= DRIVER_MAJOR,
>   	.minor			= DRIVER_MINOR,
>   };
>   
> -static int vkms_atomic_check(struct drm_device *dev, struct drm_atomic_state *state)
> +static int vkms_atomic_check(struct drm_device *dev, struct drm_atomic_commit *state)
>   {
>   	struct drm_crtc *crtc;
>   	struct drm_crtc_state *new_crtc_state;
>   	int i;
>   
> diff --git a/drivers/gpu/drm/vkms/vkms_plane.c b/drivers/gpu/drm/vkms/vkms_plane.c
> index ca7aee101a953d0f7e5262200c2c16cf0507e6ed..68cb2a3335e642a1f5aeee6326b2b038842d0283 100644
> --- a/drivers/gpu/drm/vkms/vkms_plane.c
> +++ b/drivers/gpu/drm/vkms/vkms_plane.c
> @@ -120,11 +120,11 @@ static const struct drm_plane_funcs vkms_plane_funcs = {
>   	.atomic_duplicate_state = vkms_plane_duplicate_state,
>   	.atomic_destroy_state	= vkms_plane_destroy_state,
>   };
>   
>   static void vkms_plane_atomic_update(struct drm_plane *plane,
> -				     struct drm_atomic_state *state)
> +				     struct drm_atomic_commit *state)
>   {
>   	struct drm_plane_state *new_state = drm_atomic_get_new_plane_state(state,
>   									   plane);
>   	struct vkms_plane_state *vkms_plane_state;
>   	struct drm_shadow_plane_state *shadow_plane_state;
> @@ -151,11 +151,11 @@ static void vkms_plane_atomic_update(struct drm_plane *plane,
>   	get_conversion_matrix_to_argb_u16(fmt, new_state->color_encoding, new_state->color_range,
>   					  &vkms_plane_state->conversion_matrix);
>   }
>   
>   static int vkms_plane_atomic_check(struct drm_plane *plane,
> -				   struct drm_atomic_state *state)
> +				   struct drm_atomic_commit *state)
>   {
>   	struct drm_plane_state *new_plane_state = drm_atomic_get_new_plane_state(state,
>   										 plane);
>   	struct drm_crtc_state *crtc_state;
>   	int ret;
> diff --git a/drivers/gpu/drm/vkms/vkms_writeback.c b/drivers/gpu/drm/vkms/vkms_writeback.c
> index 908b7e602ffbc8afe889e742ed30e8183c0610e6..ecf29a2c0c8e0b3348df43296c1453307f308b11 100644
> --- a/drivers/gpu/drm/vkms/vkms_writeback.c
> +++ b/drivers/gpu/drm/vkms/vkms_writeback.c
> @@ -30,11 +30,11 @@ static const struct drm_connector_funcs vkms_wb_connector_funcs = {
>   	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
>   	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
>   };
>   
>   static int vkms_wb_atomic_check(struct drm_connector *connector,
> -				struct drm_atomic_state *state)
> +				struct drm_atomic_commit *state)
>   {
>   	struct drm_connector_state *conn_state =
>   		drm_atomic_get_new_connector_state(state, connector);
>   	struct drm_crtc_state *crtc_state;
>   	struct drm_framebuffer *fb;
> @@ -121,11 +121,11 @@ static void vkms_wb_cleanup_job(struct drm_writeback_connector *connector,
>   	vkms_set_composer(vkms_output, false);
>   	kfree(vkmsjob);
>   }
>   
>   static void vkms_wb_atomic_commit(struct drm_connector *conn,
> -				  struct drm_atomic_state *state)
> +				  struct drm_atomic_commit *state)
>   {
>   	struct drm_connector_state *connector_state = drm_atomic_get_new_connector_state(state,
>   											 conn);
>   	struct vkms_output *output = drm_crtc_to_vkms_output(connector_state->crtc);
>   	struct drm_writeback_connector *wb_conn = &output->wb_connector;
> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c b/drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c
> index c46f17ba7236dedfa900dc0f5eae1f6173a2cd68..b010fc7ca68e2a658dad386d554ddcf434515b89 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c
> @@ -688,11 +688,11 @@ int vmw_cursor_plane_prepare_fb(struct drm_plane *plane,
>    * our requirements.
>    *
>    * Returns 0 on success
>    */
>   int vmw_cursor_plane_atomic_check(struct drm_plane *plane,
> -				  struct drm_atomic_state *state)
> +				  struct drm_atomic_commit *state)
>   {
>   	struct drm_plane_state *new_state =
>   		drm_atomic_get_new_plane_state(state, plane);
>   	struct vmw_private *vmw = vmw_priv(plane->dev);
>   	int ret = 0;
> @@ -737,11 +737,11 @@ int vmw_cursor_plane_atomic_check(struct drm_plane *plane,
>   	return 0;
>   }
>   
>   void
>   vmw_cursor_plane_atomic_update(struct drm_plane *plane,
> -			       struct drm_atomic_state *state)
> +			       struct drm_atomic_commit *state)
>   {
>   	struct vmw_bo *bo;
>   	struct drm_plane_state *new_state =
>   		drm_atomic_get_new_plane_state(state, plane);
>   	struct drm_plane_state *old_state =
> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.h b/drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.h
> index 0c2cc0699b0d93cae6daba578d93d28a2d46c9fd..d32cf17d013b51e22479737c39b604baec1edad1 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.h
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.h
> @@ -69,13 +69,13 @@ void vmw_cursor_cmd_dma_snoop(SVGA3dCmdHeader *header,
>   			      struct ttm_buffer_object *bo);
>   
>   void vmw_cursor_plane_destroy(struct drm_plane *plane);
>   
>   int vmw_cursor_plane_atomic_check(struct drm_plane *plane,
> -				  struct drm_atomic_state *state);
> +				  struct drm_atomic_commit *state);
>   void vmw_cursor_plane_atomic_update(struct drm_plane *plane,
> -				    struct drm_atomic_state *state);
> +				    struct drm_atomic_commit *state);
>   int vmw_cursor_plane_prepare_fb(struct drm_plane *plane,
>   				struct drm_plane_state *new_state);
>   void vmw_cursor_plane_cleanup_fb(struct drm_plane *plane,
>   				 struct drm_plane_state *old_state);
>   
> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h
> index 57465f69c68702bd39fbfd9f66069fd2954f3e56..38bea8abab84ced2d0936731b831fbfcf49fec00 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h
> @@ -505,11 +505,11 @@ struct vmw_private {
>   	struct vmw_legacy_display *ldu_priv;
>   	struct vmw_overlay *overlay_priv;
>   	struct drm_property *hotplug_mode_update_property;
>   	struct drm_property *implicit_placement_property;
>   	spinlock_t cursor_lock;
> -	struct drm_atomic_state *suspend_state;
> +	struct drm_atomic_commit *suspend_state;
>   
>   	/*
>   	 * Context and surface management.
>   	 */
>   
> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
> index e7bddf840a7951017a3c86c2d3eb44745536fa81..1b407b61f68386bca8da20b89c7d115188380efd 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
> @@ -99,11 +99,11 @@ vmw_du_plane_cleanup_fb(struct drm_plane *plane,
>    * the FB and maintaining one active framebuffer.
>    *
>    * Returns 0 on success
>    */
>   int vmw_du_primary_plane_atomic_check(struct drm_plane *plane,
> -				      struct drm_atomic_state *state)
> +				      struct drm_atomic_commit *state)
>   {
>   	struct drm_plane_state *new_state = drm_atomic_get_new_plane_state(state,
>   									   plane);
>   	struct drm_plane_state *old_state = drm_atomic_get_old_plane_state(state,
>   									   plane);
> @@ -130,11 +130,11 @@ int vmw_du_primary_plane_atomic_check(struct drm_plane *plane,
>   						  false, true);
>   	return ret;
>   }
>   
>   int vmw_du_crtc_atomic_check(struct drm_crtc *crtc,
> -			     struct drm_atomic_state *state)
> +			     struct drm_atomic_commit *state)
>   {
>   	struct vmw_private *vmw = vmw_priv(crtc->dev);
>   	struct drm_crtc_state *new_state = drm_atomic_get_new_crtc_state(state,
>   									 crtc);
>   	struct vmw_display_unit *du = vmw_crtc_to_du(new_state->crtc);
> @@ -167,11 +167,11 @@ int vmw_du_crtc_atomic_check(struct drm_crtc *crtc,
>   	return 0;
>   }
>   
>   
>   void vmw_du_crtc_atomic_begin(struct drm_crtc *crtc,
> -			      struct drm_atomic_state *state)
> +			      struct drm_atomic_commit *state)
>   {
>   	vmw_vkms_crtc_atomic_begin(crtc, state);
>   }
>   
>   /**
> @@ -862,11 +862,11 @@ static int vmw_kms_check_display_memory(struct drm_device *dev,
>    *
>    * Returns: A valid crtc state pointer or NULL. It may also return a
>    * pointer error, in particular -EDEADLK if locking needs to be rerun.
>    */
>   static struct drm_crtc_state *
> -vmw_crtc_state_and_lock(struct drm_atomic_state *state, struct drm_crtc *crtc)
> +vmw_crtc_state_and_lock(struct drm_atomic_commit *state, struct drm_crtc *crtc)
>   {
>   	struct drm_crtc_state *crtc_state;
>   
>   	crtc_state = drm_atomic_get_new_crtc_state(state, crtc);
>   	if (crtc_state) {
> @@ -893,11 +893,11 @@ vmw_crtc_state_and_lock(struct drm_atomic_state *state, struct drm_crtc *crtc)
>    *   Zero on success,
>    *   -EINVAL on invalid state,
>    *   -EDEADLK if modeset locking needs to be rerun.
>    */
>   static int vmw_kms_check_implicit(struct drm_device *dev,
> -				  struct drm_atomic_state *state)
> +				  struct drm_atomic_commit *state)
>   {
>   	struct drm_framebuffer *implicit_fb = NULL;
>   	struct drm_crtc *crtc;
>   	struct drm_crtc_state *crtc_state;
>   	struct drm_plane_state *plane_state;
> @@ -931,19 +931,19 @@ static int vmw_kms_check_implicit(struct drm_device *dev,
>   
>   	return 0;
>   }
>   
>   /**
> - * vmw_kms_check_topology - Validates topology in drm_atomic_state
> + * vmw_kms_check_topology - Validates topology in drm_atomic_commit
>    * @dev: DRM device
>    * @state: the driver state object
>    *
>    * Returns:
>    * 0 on success otherwise negative error code
>    */
>   static int vmw_kms_check_topology(struct drm_device *dev,
> -				  struct drm_atomic_state *state)
> +				  struct drm_atomic_commit *state)
>   {
>   	struct drm_crtc_state *old_crtc_state, *new_crtc_state;
>   	struct drm_rect *rects;
>   	struct drm_crtc *crtc;
>   	uint32_t i;
> @@ -1033,11 +1033,11 @@ static int vmw_kms_check_topology(struct drm_device *dev,
>    * Returns:
>    * Zero for success or -errno
>    */
>   static int
>   vmw_kms_atomic_check_modeset(struct drm_device *dev,
> -			     struct drm_atomic_state *state)
> +			     struct drm_atomic_commit *state)
>   {
>   	struct drm_crtc *crtc;
>   	struct drm_crtc_state *crtc_state;
>   	bool need_modeset = false;
>   	int i, ret;
> @@ -1131,11 +1131,11 @@ vmw_kms_create_hotplug_mode_update_property(struct vmw_private *dev_priv)
>   					  DRM_MODE_PROP_IMMUTABLE,
>   					  "hotplug_mode_update", 0, 1);
>   }
>   
>   static void
> -vmw_atomic_commit_tail(struct drm_atomic_state *old_state)
> +vmw_atomic_commit_tail(struct drm_atomic_commit *old_state)
>   {
>   	struct vmw_private *vmw = vmw_priv(old_state->dev);
>   	struct drm_crtc *crtc;
>   	struct drm_crtc_state *old_crtc_state;
>   	int i;
> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.h b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.h
> index 445471fe9be6eecbce76591f4f1cf931c1e6d944..1b05dde2bef3d386917ea161fbb5cb1de205650c 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.h
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.h
> @@ -408,23 +408,23 @@ void vmw_kms_create_implicit_placement_property(struct vmw_private *dev_priv);
>   /* Universal Plane Helpers */
>   void vmw_du_primary_plane_destroy(struct drm_plane *plane);
>   
>   /* Atomic Helpers */
>   int vmw_du_primary_plane_atomic_check(struct drm_plane *plane,
> -				      struct drm_atomic_state *state);
> +				      struct drm_atomic_commit *state);
>   void vmw_du_plane_cleanup_fb(struct drm_plane *plane,
>   			     struct drm_plane_state *old_state);
>   void vmw_du_plane_reset(struct drm_plane *plane);
>   struct drm_plane_state *vmw_du_plane_duplicate_state(struct drm_plane *plane);
>   void vmw_du_plane_destroy_state(struct drm_plane *plane,
>   				struct drm_plane_state *state);
>   void vmw_du_plane_unpin_surf(struct vmw_plane_state *vps);
>   
>   int vmw_du_crtc_atomic_check(struct drm_crtc *crtc,
> -			     struct drm_atomic_state *state);
> +			     struct drm_atomic_commit *state);
>   void vmw_du_crtc_atomic_begin(struct drm_crtc *crtc,
> -			      struct drm_atomic_state *state);
> +			      struct drm_atomic_commit *state);
>   void vmw_du_crtc_reset(struct drm_crtc *crtc);
>   struct drm_crtc_state *vmw_du_crtc_duplicate_state(struct drm_crtc *crtc);
>   void vmw_du_crtc_destroy_state(struct drm_crtc *crtc,
>   				struct drm_crtc_state *state);
>   void vmw_du_connector_reset(struct drm_connector *connector);
> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_ldu.c b/drivers/gpu/drm/vmwgfx/vmwgfx_ldu.c
> index f07669b27fbaa52b7bbb676c72b90205346c79a3..cd32b5e351991289ff747c2732683011add02666 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_ldu.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_ldu.c
> @@ -308,11 +308,11 @@ static int vmw_kms_ldu_do_bo_dirty(struct vmw_private *dev_priv,
>    * Legacy Display Plane Functions
>    */
>   
>   static void
>   vmw_ldu_primary_plane_atomic_update(struct drm_plane *plane,
> -				    struct drm_atomic_state *state)
> +				    struct drm_atomic_commit *state)
>   {
>   	struct drm_plane_state *old_state = drm_atomic_get_old_plane_state(state,
>   									   plane);
>   	struct drm_plane_state *new_state = drm_atomic_get_new_plane_state(state,
>   									   plane);
> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c b/drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c
> index 605d037d18c6b2a9ed5915a2e0f71c728880f21e..b6148e43717536f27a2af2236af4000eee560d69 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c
> @@ -275,11 +275,11 @@ static void vmw_sou_crtc_helper_prepare(struct drm_crtc *crtc)
>    *
>    * @crtc: CRTC to be turned off
>    * @state: Unused
>    */
>   static void vmw_sou_crtc_atomic_disable(struct drm_crtc *crtc,
> -					struct drm_atomic_state *state)
> +					struct drm_atomic_commit *state)
>   {
>   	struct vmw_private *dev_priv;
>   	struct vmw_screen_object_unit *sou;
>   	int ret;
>   
> @@ -717,11 +717,11 @@ static int vmw_sou_plane_update_surface(struct vmw_private *dev_priv,
>   	return vmw_du_helper_plane_update(&srf_update.base);
>   }
>   
>   static void
>   vmw_sou_primary_plane_atomic_update(struct drm_plane *plane,
> -				    struct drm_atomic_state *state)
> +				    struct drm_atomic_commit *state)
>   {
>   	struct drm_plane_state *old_state = drm_atomic_get_old_plane_state(state, plane);
>   	struct drm_plane_state *new_state = drm_atomic_get_new_plane_state(state, plane);
>   	struct drm_crtc *crtc = new_state->crtc;
>   	struct vmw_fence_obj *fence = NULL;
> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c b/drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c
> index dcbacee97f61c5035712784f3576b5b45752e07a..353495739c03052540a0ea81385b01a337004c33 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c
> @@ -412,11 +412,11 @@ static void vmw_stdu_crtc_mode_set_nofb(struct drm_crtc *crtc)
>   		DRM_ERROR("Failed to define Screen Target of size %dx%d\n",
>   			  crtc->x, crtc->y);
>   }
>   
>   static void vmw_stdu_crtc_atomic_disable(struct drm_crtc *crtc,
> -					 struct drm_atomic_state *state)
> +					 struct drm_atomic_commit *state)
>   {
>   	struct vmw_private *dev_priv;
>   	struct vmw_screen_target_display_unit *stdu;
>   	struct drm_crtc_state *new_crtc_state;
>   	int ret;
> @@ -877,11 +877,11 @@ vmw_stdu_connector_mode_valid(struct drm_connector *connector,
>    * Trigger a modeset if the X,Y position of the Screen Target changes.
>    * This is needed when multi-mon is cycled. The original Screen Target will have
>    * the same mode but its relative X,Y position in the topology will change.
>    */
>   static int vmw_stdu_connector_atomic_check(struct drm_connector *conn,
> -					   struct drm_atomic_state *state)
> +					   struct drm_atomic_commit *state)
>   {
>   	struct drm_connector_state *conn_state;
>   	struct vmw_screen_target_display_unit *du;
>   	struct drm_crtc_state *new_crtc_state;
>   
> @@ -1397,11 +1397,11 @@ static int vmw_stdu_plane_update_surface(struct vmw_private *dev_priv,
>    * all the preparation have been done and all the configurations have
>    * been checked.
>    */
>   static void
>   vmw_stdu_primary_plane_atomic_update(struct drm_plane *plane,
> -				     struct drm_atomic_state *state)
> +				     struct drm_atomic_commit *state)
>   {
>   	struct drm_plane_state *old_state = drm_atomic_get_old_plane_state(state, plane);
>   	struct drm_plane_state *new_state = drm_atomic_get_new_plane_state(state, plane);
>   	struct vmw_plane_state *vps = vmw_plane_state_to_vps(new_state);
>   	struct drm_crtc *crtc = new_state->crtc;
> @@ -1458,11 +1458,11 @@ vmw_stdu_primary_plane_atomic_update(struct drm_plane *plane,
>   		vmw_fence_obj_unreference(&fence);
>   }
>   
>   static void
>   vmw_stdu_crtc_atomic_flush(struct drm_crtc *crtc,
> -			   struct drm_atomic_state *state)
> +			   struct drm_atomic_commit *state)
>   {
>   	struct vmw_private *vmw = vmw_priv(crtc->dev);
>   	struct vmw_screen_target_display_unit *stdu = vmw_crtc_to_stdu(crtc);
>   
>   	if (vmw->vkms_enabled)
> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_vkms.c b/drivers/gpu/drm/vmwgfx/vmwgfx_vkms.c
> index 5abd7f5ad2db03199750f0b909234953a616ac88..1c59dec4c76979440cb93fd5fad01c7d42a3e144 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_vkms.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_vkms.c
> @@ -339,21 +339,21 @@ vmw_vkms_crtc_cleanup(struct drm_crtc *crtc)
>   	hrtimer_cancel(&du->vkms.timer);
>   }
>   
>   void
>   vmw_vkms_crtc_atomic_begin(struct drm_crtc *crtc,
> -			   struct drm_atomic_state *state)
> +			   struct drm_atomic_commit *state)
>   {
>   	struct vmw_private *vmw = vmw_priv(crtc->dev);
>   
>   	if (vmw->vkms_enabled)
>   		vmw_vkms_modeset_lock(crtc);
>   }
>   
>   void
>   vmw_vkms_crtc_atomic_flush(struct drm_crtc *crtc,
> -			   struct drm_atomic_state *state)
> +			   struct drm_atomic_commit *state)
>   {
>   	unsigned long flags;
>   	struct vmw_private *vmw = vmw_priv(crtc->dev);
>   
>   	if (!vmw->vkms_enabled)
> @@ -375,21 +375,21 @@ vmw_vkms_crtc_atomic_flush(struct drm_crtc *crtc,
>   	vmw_vkms_unlock(crtc);
>   }
>   
>   void
>   vmw_vkms_crtc_atomic_enable(struct drm_crtc *crtc,
> -			    struct drm_atomic_state *state)
> +			    struct drm_atomic_commit *state)
>   {
>   	struct vmw_private *vmw = vmw_priv(crtc->dev);
>   
>   	if (vmw->vkms_enabled)
>   		drm_crtc_vblank_on(crtc);
>   }
>   
>   void
>   vmw_vkms_crtc_atomic_disable(struct drm_crtc *crtc,
> -			     struct drm_atomic_state *state)
> +			     struct drm_atomic_commit *state)
>   {
>   	struct vmw_private *vmw = vmw_priv(crtc->dev);
>   
>   	if (vmw->vkms_enabled)
>   		drm_crtc_vblank_off(crtc);
> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_vkms.h b/drivers/gpu/drm/vmwgfx/vmwgfx_vkms.h
> index 69ddd33a8444f1f0d80f7ccbc4fe80fff35c32b5..825b31bf8d39ffb01531422781739b02182ad0dc 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_vkms.h
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_vkms.h
> @@ -30,11 +30,11 @@
>   #define VMWGFX_VKMS_H_
>   
>   #include <linux/hrtimer_types.h>
>   #include <linux/types.h>
>   
> -struct drm_atomic_state;
> +struct drm_atomic_commit;
>   struct drm_crtc;
>   struct vmw_private;
>   struct vmw_surface;
>   
>   void vmw_vkms_init(struct vmw_private *vmw);
> @@ -53,16 +53,16 @@ int vmw_vkms_enable_vblank(struct drm_crtc *crtc);
>   void vmw_vkms_disable_vblank(struct drm_crtc *crtc);
>   
>   void vmw_vkms_crtc_init(struct drm_crtc *crtc);
>   void vmw_vkms_crtc_cleanup(struct drm_crtc *crtc);
>   void  vmw_vkms_crtc_atomic_begin(struct drm_crtc *crtc,
> -				 struct drm_atomic_state *state);
> -void vmw_vkms_crtc_atomic_flush(struct drm_crtc *crtc, struct drm_atomic_state *state);
> +				 struct drm_atomic_commit *state);
> +void vmw_vkms_crtc_atomic_flush(struct drm_crtc *crtc, struct drm_atomic_commit *state);
>   void vmw_vkms_crtc_atomic_enable(struct drm_crtc *crtc,
> -				 struct drm_atomic_state *state);
> +				 struct drm_atomic_commit *state);
>   void vmw_vkms_crtc_atomic_disable(struct drm_crtc *crtc,
> -				  struct drm_atomic_state *state);
> +				  struct drm_atomic_commit *state);
>   
>   const char *const *vmw_vkms_get_crc_sources(struct drm_crtc *crtc,
>   					    size_t *count);
>   int vmw_vkms_verify_crc_source(struct drm_crtc *crtc,
>   			       const char *src_name,
> diff --git a/drivers/gpu/drm/xlnx/zynqmp_dp.c b/drivers/gpu/drm/xlnx/zynqmp_dp.c
> index 379180fb30043ebc93b1ec61549358a8d26a1632..05bd31fe675bc8cd64ac7d3764cfb663e2bc67fa 100644
> --- a/drivers/gpu/drm/xlnx/zynqmp_dp.c
> +++ b/drivers/gpu/drm/xlnx/zynqmp_dp.c
> @@ -1435,11 +1435,11 @@ zynqmp_dp_disp_connected_live_layer(struct zynqmp_dp *dp)
>   	else
>   		return NULL;
>   }
>   
>   static void zynqmp_dp_disp_enable(struct zynqmp_dp *dp,
> -				  struct drm_atomic_state *state)
> +				  struct drm_atomic_commit *state)
>   {
>   	struct zynqmp_disp_layer *layer;
>   	struct drm_bridge_state *bridge_state;
>   	u32 bus_fmt;
>   
> @@ -1547,11 +1547,11 @@ zynqmp_dp_bridge_mode_valid(struct drm_bridge *bridge,
>   
>   	return MODE_OK;
>   }
>   
>   static void zynqmp_dp_bridge_atomic_enable(struct drm_bridge *bridge,
> -					   struct drm_atomic_state *state)
> +					   struct drm_atomic_commit *state)
>   {
>   	struct zynqmp_dp *dp = bridge_to_dp(bridge);
>   	const struct drm_crtc_state *crtc_state;
>   	const struct drm_display_mode *adjusted_mode;
>   	const struct drm_display_mode *mode;
> @@ -1624,11 +1624,11 @@ static void zynqmp_dp_bridge_atomic_enable(struct drm_bridge *bridge,
>   			ZYNQMP_DP_SOFTWARE_RESET_ALL);
>   	zynqmp_dp_write(dp, ZYNQMP_DP_MAIN_STREAM_ENABLE, 1);
>   }
>   
>   static void zynqmp_dp_bridge_atomic_disable(struct drm_bridge *bridge,
> -					    struct drm_atomic_state *state)
> +					    struct drm_atomic_commit *state)
>   {
>   	struct drm_bridge_state *old_bridge_state = drm_atomic_get_old_bridge_state(state,
>   										    bridge);
>   	struct zynqmp_dp *dp = bridge_to_dp(bridge);
>   
> diff --git a/drivers/gpu/drm/xlnx/zynqmp_kms.c b/drivers/gpu/drm/xlnx/zynqmp_kms.c
> index 02f3a7d78cf8ef78119e016ab8347e8907cdde7b..dcb2fff54b6317d17907026865986a58d9cc0f79 100644
> --- a/drivers/gpu/drm/xlnx/zynqmp_kms.c
> +++ b/drivers/gpu/drm/xlnx/zynqmp_kms.c
> @@ -51,11 +51,11 @@ static inline struct zynqmp_dpsub *to_zynqmp_dpsub(struct drm_device *drm)
>   /* -----------------------------------------------------------------------------
>    * DRM Planes
>    */
>   
>   static int zynqmp_dpsub_plane_atomic_check(struct drm_plane *plane,
> -					   struct drm_atomic_state *state)
> +					   struct drm_atomic_commit *state)
>   {
>   	struct drm_plane_state *new_plane_state = drm_atomic_get_new_plane_state(state,
>   										 plane);
>   	struct drm_crtc_state *crtc_state;
>   
> @@ -72,11 +72,11 @@ static int zynqmp_dpsub_plane_atomic_check(struct drm_plane *plane,
>   						   DRM_PLANE_NO_SCALING,
>   						   false, false);
>   }
>   
>   static void zynqmp_dpsub_plane_atomic_disable(struct drm_plane *plane,
> -					      struct drm_atomic_state *state)
> +					      struct drm_atomic_commit *state)
>   {
>   	struct drm_plane_state *old_state = drm_atomic_get_old_plane_state(state,
>   									   plane);
>   	struct zynqmp_dpsub *dpsub = to_zynqmp_dpsub(plane->dev);
>   	struct zynqmp_disp_layer *layer = dpsub->layers[plane->index];
> @@ -90,11 +90,11 @@ static void zynqmp_dpsub_plane_atomic_disable(struct drm_plane *plane,
>   		zynqmp_disp_blend_set_global_alpha(dpsub->disp, false,
>   						   plane->state->alpha >> 8);
>   }
>   
>   static void zynqmp_dpsub_plane_atomic_update(struct drm_plane *plane,
> -					     struct drm_atomic_state *state)
> +					     struct drm_atomic_commit *state)
>   {
>   	struct drm_plane_state *old_state = drm_atomic_get_old_plane_state(state, plane);
>   	struct drm_plane_state *new_state = drm_atomic_get_new_plane_state(state, plane);
>   	struct zynqmp_dpsub *dpsub = to_zynqmp_dpsub(plane->dev);
>   	struct zynqmp_disp_layer *layer = dpsub->layers[plane->index];
> @@ -191,11 +191,11 @@ static inline struct zynqmp_dpsub *crtc_to_dpsub(struct drm_crtc *crtc)
>   {
>   	return container_of(crtc, struct zynqmp_dpsub_drm, crtc)->dpsub;
>   }
>   
>   static void zynqmp_dpsub_crtc_atomic_enable(struct drm_crtc *crtc,
> -					    struct drm_atomic_state *state)
> +					    struct drm_atomic_commit *state)
>   {
>   	struct zynqmp_dpsub *dpsub = crtc_to_dpsub(crtc);
>   	struct drm_display_mode *adjusted_mode = &crtc->state->adjusted_mode;
>   	int ret, vrefresh;
>   
> @@ -217,11 +217,11 @@ static void zynqmp_dpsub_crtc_atomic_enable(struct drm_crtc *crtc,
>   		   (adjusted_mode->vtotal * adjusted_mode->htotal);
>   	msleep(3 * 1000 / vrefresh);
>   }
>   
>   static void zynqmp_dpsub_crtc_atomic_disable(struct drm_crtc *crtc,
> -					     struct drm_atomic_state *state)
> +					     struct drm_atomic_commit *state)
>   {
>   	struct zynqmp_dpsub *dpsub = crtc_to_dpsub(crtc);
>   	struct drm_plane_state *old_plane_state;
>   
>   	/*
> @@ -247,23 +247,23 @@ static void zynqmp_dpsub_crtc_atomic_disable(struct drm_crtc *crtc,
>   	clk_disable_unprepare(dpsub->vid_clk);
>   	pm_runtime_put_sync(dpsub->dev);
>   }
>   
>   static int zynqmp_dpsub_crtc_atomic_check(struct drm_crtc *crtc,
> -					  struct drm_atomic_state *state)
> +					  struct drm_atomic_commit *state)
>   {
>   	return drm_atomic_add_affected_planes(state, crtc);
>   }
>   
>   static void zynqmp_dpsub_crtc_atomic_begin(struct drm_crtc *crtc,
> -					   struct drm_atomic_state *state)
> +					   struct drm_atomic_commit *state)
>   {
>   	drm_crtc_vblank_on(crtc);
>   }
>   
>   static void zynqmp_dpsub_crtc_atomic_flush(struct drm_crtc *crtc,
> -					   struct drm_atomic_state *state)
> +					   struct drm_atomic_commit *state)
>   {
>   	if (crtc->state->event) {
>   		struct drm_pending_vblank_event *event;
>   
>   		/* Consume the flip_done event from atomic helper. */
> diff --git a/include/drm/display/drm_dp_mst_helper.h b/include/drm/display/drm_dp_mst_helper.h
> index 2cfe1d4bfc960081f4fa1d8e0b35c9a1d905d529..27658bfb50016b917a6666840723243290640529 100644
> --- a/include/drm/display/drm_dp_mst_helper.h
> +++ b/include/drm/display/drm_dp_mst_helper.h
> @@ -914,50 +914,50 @@ int drm_dp_mst_connector_late_register(struct drm_connector *connector,
>   				       struct drm_dp_mst_port *port);
>   void drm_dp_mst_connector_early_unregister(struct drm_connector *connector,
>   					   struct drm_dp_mst_port *port);
>   
>   struct drm_dp_mst_topology_state *
> -drm_atomic_get_mst_topology_state(struct drm_atomic_state *state,
> +drm_atomic_get_mst_topology_state(struct drm_atomic_commit *state,
>   				  struct drm_dp_mst_topology_mgr *mgr);
>   struct drm_dp_mst_topology_state *
> -drm_atomic_get_old_mst_topology_state(struct drm_atomic_state *state,
> +drm_atomic_get_old_mst_topology_state(struct drm_atomic_commit *state,
>   				      struct drm_dp_mst_topology_mgr *mgr);
>   struct drm_dp_mst_topology_state *
> -drm_atomic_get_new_mst_topology_state(struct drm_atomic_state *state,
> +drm_atomic_get_new_mst_topology_state(struct drm_atomic_commit *state,
>   				      struct drm_dp_mst_topology_mgr *mgr);
>   struct drm_dp_mst_atomic_payload *
>   drm_atomic_get_mst_payload_state(struct drm_dp_mst_topology_state *state,
>   				 struct drm_dp_mst_port *port);
>   bool drm_dp_mst_port_downstream_of_parent(struct drm_dp_mst_topology_mgr *mgr,
>   					  struct drm_dp_mst_port *port,
>   					  struct drm_dp_mst_port *parent);
>   int __must_check
> -drm_dp_atomic_find_time_slots(struct drm_atomic_state *state,
> +drm_dp_atomic_find_time_slots(struct drm_atomic_commit *state,
>   			      struct drm_dp_mst_topology_mgr *mgr,
>   			      struct drm_dp_mst_port *port, int pbn);
> -int drm_dp_mst_atomic_enable_dsc(struct drm_atomic_state *state,
> +int drm_dp_mst_atomic_enable_dsc(struct drm_atomic_commit *state,
>   				 struct drm_dp_mst_port *port,
>   				 int pbn, bool enable);
>   int __must_check
> -drm_dp_mst_add_affected_dsc_crtcs(struct drm_atomic_state *state,
> +drm_dp_mst_add_affected_dsc_crtcs(struct drm_atomic_commit *state,
>   				  struct drm_dp_mst_topology_mgr *mgr);
>   int __must_check
> -drm_dp_atomic_release_time_slots(struct drm_atomic_state *state,
> +drm_dp_atomic_release_time_slots(struct drm_atomic_commit *state,
>   				 struct drm_dp_mst_topology_mgr *mgr,
>   				 struct drm_dp_mst_port *port);
> -void drm_dp_mst_atomic_wait_for_dependencies(struct drm_atomic_state *state);
> -int __must_check drm_dp_mst_atomic_setup_commit(struct drm_atomic_state *state);
> +void drm_dp_mst_atomic_wait_for_dependencies(struct drm_atomic_commit *state);
> +int __must_check drm_dp_mst_atomic_setup_commit(struct drm_atomic_commit *state);
>   int drm_dp_send_power_updown_phy(struct drm_dp_mst_topology_mgr *mgr,
>   				 struct drm_dp_mst_port *port, bool power_up);
>   int drm_dp_send_query_stream_enc_status(struct drm_dp_mst_topology_mgr *mgr,
>   		struct drm_dp_mst_port *port,
>   		struct drm_dp_query_stream_enc_status_ack_reply *status);
> -int __must_check drm_dp_mst_atomic_check_mgr(struct drm_atomic_state *state,
> +int __must_check drm_dp_mst_atomic_check_mgr(struct drm_atomic_commit *state,
>   					     struct drm_dp_mst_topology_mgr *mgr,
>   					     struct drm_dp_mst_topology_state *mst_state,
>   					     struct drm_dp_mst_port **failing_port);
> -int __must_check drm_dp_mst_atomic_check(struct drm_atomic_state *state);
> +int __must_check drm_dp_mst_atomic_check(struct drm_atomic_commit *state);
>   int __must_check drm_dp_mst_root_conn_atomic_check(struct drm_connector_state *new_conn_state,
>   						   struct drm_dp_mst_topology_mgr *mgr);
>   
>   void drm_dp_mst_get_port_malloc(struct drm_dp_mst_port *port);
>   void drm_dp_mst_put_port_malloc(struct drm_dp_mst_port *port);
> @@ -980,11 +980,11 @@ to_drm_dp_mst_topology_state(struct drm_private_state *state)
>   extern const struct drm_private_state_funcs drm_dp_mst_topology_state_funcs;
>   
>   /**
>    * __drm_dp_mst_state_iter_get - private atomic state iterator function for
>    * macro-internal use
> - * @state: &struct drm_atomic_state pointer
> + * @state: &struct drm_atomic_commit pointer
>    * @mgr: pointer to the &struct drm_dp_mst_topology_mgr iteration cursor
>    * @old_state: optional pointer to the old &struct drm_dp_mst_topology_state
>    * iteration cursor
>    * @new_state: optional pointer to the new &struct drm_dp_mst_topology_state
>    * iteration cursor
> @@ -997,11 +997,11 @@ extern const struct drm_private_state_funcs drm_dp_mst_topology_state_funcs;
>    * Returns:
>    * True if the current &struct drm_private_obj is a &struct
>    * drm_dp_mst_topology_mgr, false otherwise.
>    */
>   static inline bool
> -__drm_dp_mst_state_iter_get(struct drm_atomic_state *state,
> +__drm_dp_mst_state_iter_get(struct drm_atomic_commit *state,
>   			    struct drm_dp_mst_topology_mgr **mgr,
>   			    struct drm_dp_mst_topology_state **old_state,
>   			    struct drm_dp_mst_topology_state **new_state,
>   			    int i)
>   {
> @@ -1020,11 +1020,11 @@ __drm_dp_mst_state_iter_get(struct drm_atomic_state *state,
>   }
>   
>   /**
>    * for_each_oldnew_mst_mgr_in_state - iterate over all DP MST topology
>    * managers in an atomic update
> - * @__state: &struct drm_atomic_state pointer
> + * @__state: &struct drm_atomic_commit pointer
>    * @mgr: &struct drm_dp_mst_topology_mgr iteration cursor
>    * @old_state: &struct drm_dp_mst_topology_state iteration cursor for the old
>    * state
>    * @new_state: &struct drm_dp_mst_topology_state iteration cursor for the new
>    * state
> @@ -1039,11 +1039,11 @@ __drm_dp_mst_state_iter_get(struct drm_atomic_state *state,
>   		for_each_if(__drm_dp_mst_state_iter_get((__state), &(mgr), &(old_state), &(new_state), (__i)))
>   
>   /**
>    * for_each_old_mst_mgr_in_state - iterate over all DP MST topology managers
>    * in an atomic update
> - * @__state: &struct drm_atomic_state pointer
> + * @__state: &struct drm_atomic_commit pointer
>    * @mgr: &struct drm_dp_mst_topology_mgr iteration cursor
>    * @old_state: &struct drm_dp_mst_topology_state iteration cursor for the old
>    * state
>    * @__i: int iteration cursor, for macro-internal use
>    *
> @@ -1056,11 +1056,11 @@ __drm_dp_mst_state_iter_get(struct drm_atomic_state *state,
>   		for_each_if(__drm_dp_mst_state_iter_get((__state), &(mgr), &(old_state), NULL, (__i)))
>   
>   /**
>    * for_each_new_mst_mgr_in_state - iterate over all DP MST topology managers
>    * in an atomic update
> - * @__state: &struct drm_atomic_state pointer
> + * @__state: &struct drm_atomic_commit pointer
>    * @mgr: &struct drm_dp_mst_topology_mgr iteration cursor
>    * @new_state: &struct drm_dp_mst_topology_state iteration cursor for the new
>    * state
>    * @__i: int iteration cursor, for macro-internal use
>    *
> diff --git a/include/drm/display/drm_dp_tunnel.h b/include/drm/display/drm_dp_tunnel.h
> index 87212c84791505fe6a0ecb2042728b5efdc9da7c..6c565c5e66a863e8afae98fc1b83d8d32bbe5b9d 100644
> --- a/include/drm/display/drm_dp_tunnel.h
> +++ b/include/drm/display/drm_dp_tunnel.h
> @@ -12,11 +12,11 @@
>   
>   struct drm_dp_aux;
>   
>   struct drm_device;
>   
> -struct drm_atomic_state;
> +struct drm_atomic_commit;
>   struct drm_dp_tunnel_mgr;
>   struct drm_dp_tunnel_state;
>   
>   struct ref_tracker;
>   
> @@ -67,29 +67,29 @@ int drm_dp_tunnel_max_dprx_lane_count(const struct drm_dp_tunnel *tunnel);
>   int drm_dp_tunnel_available_bw(const struct drm_dp_tunnel *tunnel);
>   
>   const char *drm_dp_tunnel_name(const struct drm_dp_tunnel *tunnel);
>   
>   struct drm_dp_tunnel_state *
> -drm_dp_tunnel_atomic_get_state(struct drm_atomic_state *state,
> +drm_dp_tunnel_atomic_get_state(struct drm_atomic_commit *state,
>   			       struct drm_dp_tunnel *tunnel);
>   
>   struct drm_dp_tunnel_state *
> -drm_dp_tunnel_atomic_get_old_state(struct drm_atomic_state *state,
> +drm_dp_tunnel_atomic_get_old_state(struct drm_atomic_commit *state,
>   				   const struct drm_dp_tunnel *tunnel);
>   
>   struct drm_dp_tunnel_state *
> -drm_dp_tunnel_atomic_get_new_state(struct drm_atomic_state *state,
> +drm_dp_tunnel_atomic_get_new_state(struct drm_atomic_commit *state,
>   				   const struct drm_dp_tunnel *tunnel);
>   
> -int drm_dp_tunnel_atomic_set_stream_bw(struct drm_atomic_state *state,
> +int drm_dp_tunnel_atomic_set_stream_bw(struct drm_atomic_commit *state,
>   				       struct drm_dp_tunnel *tunnel,
>   				       u8 stream_id, int bw);
> -int drm_dp_tunnel_atomic_get_group_streams_in_state(struct drm_atomic_state *state,
> +int drm_dp_tunnel_atomic_get_group_streams_in_state(struct drm_atomic_commit *state,
>   						    const struct drm_dp_tunnel *tunnel,
>   						    u32 *stream_mask);
>   
> -int drm_dp_tunnel_atomic_check_stream_bws(struct drm_atomic_state *state,
> +int drm_dp_tunnel_atomic_check_stream_bws(struct drm_atomic_commit *state,
>   					  u32 *failed_stream_mask);
>   
>   int drm_dp_tunnel_atomic_get_required_bw(const struct drm_dp_tunnel_state *tunnel_state);
>   
>   struct drm_dp_tunnel_mgr *
> @@ -190,41 +190,41 @@ drm_dp_tunnel_name(const struct drm_dp_tunnel *tunnel)
>   {
>   	return NULL;
>   }
>   
>   static inline struct drm_dp_tunnel_state *
> -drm_dp_tunnel_atomic_get_state(struct drm_atomic_state *state,
> +drm_dp_tunnel_atomic_get_state(struct drm_atomic_commit *state,
>   			       struct drm_dp_tunnel *tunnel)
>   {
>   	return ERR_PTR(-EOPNOTSUPP);
>   }
>   
>   static inline struct drm_dp_tunnel_state *
> -drm_dp_tunnel_atomic_get_new_state(struct drm_atomic_state *state,
> +drm_dp_tunnel_atomic_get_new_state(struct drm_atomic_commit *state,
>   				   const struct drm_dp_tunnel *tunnel)
>   {
>   	return ERR_PTR(-EOPNOTSUPP);
>   }
>   
>   static inline int
> -drm_dp_tunnel_atomic_set_stream_bw(struct drm_atomic_state *state,
> +drm_dp_tunnel_atomic_set_stream_bw(struct drm_atomic_commit *state,
>   				   struct drm_dp_tunnel *tunnel,
>   				   u8 stream_id, int bw)
>   {
>   	return -EOPNOTSUPP;
>   }
>   
>   static inline int
> -drm_dp_tunnel_atomic_get_group_streams_in_state(struct drm_atomic_state *state,
> +drm_dp_tunnel_atomic_get_group_streams_in_state(struct drm_atomic_commit *state,
>   						const struct drm_dp_tunnel *tunnel,
>   						u32 *stream_mask)
>   {
>   	return -EOPNOTSUPP;
>   }
>   
>   static inline int
> -drm_dp_tunnel_atomic_check_stream_bws(struct drm_atomic_state *state,
> +drm_dp_tunnel_atomic_check_stream_bws(struct drm_atomic_commit *state,
>   				      u32 *failed_stream_mask)
>   {
>   	return -EOPNOTSUPP;
>   }
>   
> diff --git a/include/drm/display/drm_hdmi_state_helper.h b/include/drm/display/drm_hdmi_state_helper.h
> index 2349c0d0f00fb468167023d4db2055c70e603bcd..0adc30c55ec91aeed627827f4472e327fc1b23ae 100644
> --- a/include/drm/display/drm_hdmi_state_helper.h
> +++ b/include/drm/display/drm_hdmi_state_helper.h
> @@ -1,11 +1,11 @@
>   /* SPDX-License-Identifier: MIT */
>   
>   #ifndef DRM_HDMI_STATE_HELPER_H_
>   #define DRM_HDMI_STATE_HELPER_H_
>   
> -struct drm_atomic_state;
> +struct drm_atomic_commit;
>   struct drm_connector;
>   struct drm_connector_state;
>   struct drm_display_mode;
>   struct hdmi_audio_infoframe;
>   
> @@ -13,17 +13,17 @@ enum drm_connector_status;
>   
>   void __drm_atomic_helper_connector_hdmi_reset(struct drm_connector *connector,
>   					      struct drm_connector_state *new_conn_state);
>   
>   int drm_atomic_helper_connector_hdmi_check(struct drm_connector *connector,
> -					   struct drm_atomic_state *state);
> +					   struct drm_atomic_commit *state);
>   
>   int drm_atomic_helper_connector_hdmi_update_audio_infoframe(struct drm_connector *connector,
>   							    struct hdmi_audio_infoframe *frame);
>   int drm_atomic_helper_connector_hdmi_clear_audio_infoframe(struct drm_connector *connector);
>   int drm_atomic_helper_connector_hdmi_update_infoframes(struct drm_connector *connector,
> -						       struct drm_atomic_state *state);
> +						       struct drm_atomic_commit *state);
>   void drm_atomic_helper_connector_hdmi_hotplug(struct drm_connector *connector,
>   					      enum drm_connector_status status);
>   void drm_atomic_helper_connector_hdmi_force(struct drm_connector *connector);
>   
>   enum drm_mode_status
> diff --git a/include/drm/drm_atomic.h b/include/drm/drm_atomic.h
> index f03cd199aee73fa8e15b2d9e16a53d134fc7de7d..4cb83a9c26b1d6fda079e6d529482708a2814992 100644
> --- a/include/drm/drm_atomic.h
> +++ b/include/drm/drm_atomic.h
> @@ -167,13 +167,13 @@ struct __drm_planes_state {
>   
>   	/**
>   	 * @state_to_destroy:
>   	 *
>   	 * Used to track the @drm_plane_state we will need to free when
> -	 * tearing down the associated &drm_atomic_state in
> +	 * tearing down the associated &drm_atomic_commit in
>   	 * $drm_mode_config_funcs.atomic_state_clear or
> -	 * drm_atomic_state_default_clear().
> +	 * drm_atomic_commit_default_clear().
>   	 *
>   	 * Before a commit, and the call to
>   	 * drm_atomic_helper_swap_state() in particular, it points to
>   	 * the same state than @new_state. After a commit, it points to
>   	 * the same state than @old_state.
> @@ -188,13 +188,13 @@ struct __drm_crtcs_state {
>   
>   	/**
>   	 * @state_to_destroy:
>   	 *
>   	 * Used to track the @drm_crtc_state we will need to free when
> -	 * tearing down the associated &drm_atomic_state in
> +	 * tearing down the associated &drm_atomic_commit in
>   	 * $drm_mode_config_funcs.atomic_state_clear or
> -	 * drm_atomic_state_default_clear().
> +	 * drm_atomic_commit_default_clear().
>   	 *
>   	 * Before a commit, and the call to
>   	 * drm_atomic_helper_swap_state() in particular, it points to
>   	 * the same state than @new_state. After a commit, it points to
>   	 * the same state than @old_state.
> @@ -222,13 +222,13 @@ struct __drm_connnectors_state {
>   
>   	/**
>   	 * @state_to_destroy:
>   	 *
>   	 * Used to track the @drm_connector_state we will need to free
> -	 * when tearing down the associated &drm_atomic_state in
> +	 * when tearing down the associated &drm_atomic_commit in
>   	 * $drm_mode_config_funcs.atomic_state_clear or
> -	 * drm_atomic_state_default_clear().
> +	 * drm_atomic_commit_default_clear().
>   	 *
>   	 * Before a commit, and the call to
>   	 * drm_atomic_helper_swap_state() in particular, it points to
>   	 * the same state than @new_state. After a commit, it points to
>   	 * the same state than @old_state.
> @@ -400,13 +400,13 @@ struct drm_private_obj {
>    * and the relevant private object but in the future also might hold
>    * synchronization information similar to e.g. &drm_crtc.commit.
>    */
>   struct drm_private_state {
>   	/**
> -	 * @state: backpointer to global drm_atomic_state
> +	 * @state: backpointer to global drm_atomic_commit
>   	 */
> -	struct drm_atomic_state *state;
> +	struct drm_atomic_commit *state;
>   
>   	/**
>   	 * @obj: backpointer to the private object
>   	 */
>   	struct drm_private_obj *obj;
> @@ -417,13 +417,13 @@ struct __drm_private_objs_state {
>   
>   	/**
>   	 * @state_to_destroy:
>   	 *
>   	 * Used to track the @drm_private_state we will need to free
> -	 * when tearing down the associated &drm_atomic_state in
> +	 * when tearing down the associated &drm_atomic_commit in
>   	 * $drm_mode_config_funcs.atomic_state_clear or
> -	 * drm_atomic_state_default_clear().
> +	 * drm_atomic_commit_default_clear().
>   	 *
>   	 * Before a commit, and the call to
>   	 * drm_atomic_helper_swap_state() in particular, it points to
>   	 * the same state than @new_state. After a commit, it points to
>   	 * the same state than @old_state.
> @@ -432,11 +432,11 @@ struct __drm_private_objs_state {
>   
>   	struct drm_private_state *old_state, *new_state;
>   };
>   
>   /**
> - * struct drm_atomic_state - Atomic commit structure
> + * struct drm_atomic_commit - Atomic commit structure
>    *
>    * This structure is the kernel counterpart of @drm_mode_atomic and represents
>    * an atomic commit that transitions from an old to a new display state. It
>    * contains all the objects affected by the atomic commit and both the new
>    * state structures and pointers to the old state structures for
> @@ -444,42 +444,42 @@ struct __drm_private_objs_state {
>    *
>    * States are added to an atomic update by calling drm_atomic_get_crtc_state(),
>    * drm_atomic_get_plane_state(), drm_atomic_get_connector_state(), or for
>    * private state structures, drm_atomic_get_private_obj_state().
>    *
> - * NOTE: struct drm_atomic_state first started as a single collection of
> + * NOTE: struct drm_atomic_commit first started as a single collection of
>    * entities state pointers (drm_plane_state, drm_crtc_state, etc.).
>    *
>    * At atomic_check time, you could get the state about to be committed
> - * from drm_atomic_state, and the one currently running from the
> + * from drm_atomic_commit, and the one currently running from the
>    * entities state pointer (drm_crtc.state, for example). After the call
>    * to drm_atomic_helper_swap_state(), the entities state pointer would
> - * contain the state previously checked, and the drm_atomic_state
> + * contain the state previously checked, and the drm_atomic_commit
>    * structure the old state.
>    *
> - * Over time, and in order to avoid confusion, drm_atomic_state has
> + * Over time, and in order to avoid confusion, drm_atomic_commit has
>    * grown to have both the old state (ie, the state we replace) and the
>    * new state (ie, the state we want to apply). Those names are stable
>    * during the commit process, which makes it easier to reason about.
>    *
>    * You can still find some traces of that evolution through some hooks
> - * or callbacks taking a drm_atomic_state parameter called names like
> + * or callbacks taking a drm_atomic_commit parameter called names like
>    * "old_state". This doesn't necessarily mean that the previous
> - * drm_atomic_state is passed, but rather that this used to be the state
> + * drm_atomic_commit is passed, but rather that this used to be the state
>    * collection we were replacing after drm_atomic_helper_swap_state(),
>    * but the variable name was never updated.
>    *
>    * Some atomic operations implementations followed a similar process. We
>    * first started to pass the entity state only. However, it was pretty
>    * cumbersome for drivers, and especially CRTCs, to retrieve the states
>    * of other components. Thus, we switched to passing the whole
> - * drm_atomic_state as a parameter to those operations. Similarly, the
> + * drm_atomic_commit as a parameter to those operations. Similarly, the
>    * transition isn't complete yet, and one might still find atomic
> - * operations taking a drm_atomic_state pointer, or a component state
> + * operations taking a drm_atomic_commit pointer, or a component state
>    * pointer. The former is the preferred form.
>    */
> -struct drm_atomic_state {
> +struct drm_atomic_commit {
>   	/**
>   	 * @ref:
>   	 *
>   	 * Count of all references to this update (will not be freed until zero).
>   	 */
> @@ -677,97 +677,97 @@ static inline void drm_crtc_commit_put(struct drm_crtc_commit *commit)
>   	kref_put(&commit->ref, __drm_crtc_commit_free);
>   }
>   
>   int drm_crtc_commit_wait(struct drm_crtc_commit *commit);
>   
> -struct drm_atomic_state * __must_check
> -drm_atomic_state_alloc(struct drm_device *dev);
> -void drm_atomic_state_clear(struct drm_atomic_state *state);
> +struct drm_atomic_commit * __must_check
> +drm_atomic_commit_alloc(struct drm_device *dev);
> +void drm_atomic_commit_clear(struct drm_atomic_commit *state);
>   
>   /**
> - * drm_atomic_state_get - acquire a reference to the atomic state
> + * drm_atomic_commit_get - acquire a reference to the atomic state
>    * @state: The atomic state
>    *
>    * Returns a new reference to the @state
>    */
> -static inline struct drm_atomic_state *
> -drm_atomic_state_get(struct drm_atomic_state *state)
> +static inline struct drm_atomic_commit *
> +drm_atomic_commit_get(struct drm_atomic_commit *state)
>   {
>   	kref_get(&state->ref);
>   	return state;
>   }
>   
> -void __drm_atomic_state_free(struct kref *ref);
> +void __drm_atomic_commit_free(struct kref *ref);
>   
>   /**
> - * drm_atomic_state_put - release a reference to the atomic state
> + * drm_atomic_commit_put - release a reference to the atomic state
>    * @state: The atomic state
>    *
>    * This releases a reference to @state which is freed after removing the
>    * final reference. No locking required and callable from any context.
>    */
> -static inline void drm_atomic_state_put(struct drm_atomic_state *state)
> +static inline void drm_atomic_commit_put(struct drm_atomic_commit *state)
>   {
> -	kref_put(&state->ref, __drm_atomic_state_free);
> +	kref_put(&state->ref, __drm_atomic_commit_free);
>   }
>   
>   int  __must_check
> -drm_atomic_state_init(struct drm_device *dev, struct drm_atomic_state *state);
> -void drm_atomic_state_default_clear(struct drm_atomic_state *state);
> -void drm_atomic_state_default_release(struct drm_atomic_state *state);
> +drm_atomic_commit_init(struct drm_device *dev, struct drm_atomic_commit *state);
> +void drm_atomic_commit_default_clear(struct drm_atomic_commit *state);
> +void drm_atomic_commit_default_release(struct drm_atomic_commit *state);
>   
>   struct drm_crtc_state * __must_check
> -drm_atomic_get_crtc_state(struct drm_atomic_state *state,
> +drm_atomic_get_crtc_state(struct drm_atomic_commit *state,
>   			  struct drm_crtc *crtc);
>   struct drm_plane_state * __must_check
> -drm_atomic_get_plane_state(struct drm_atomic_state *state,
> +drm_atomic_get_plane_state(struct drm_atomic_commit *state,
>   			   struct drm_plane *plane);
>   struct drm_colorop_state *
> -drm_atomic_get_colorop_state(struct drm_atomic_state *state,
> +drm_atomic_get_colorop_state(struct drm_atomic_commit *state,
>   			     struct drm_colorop *colorop);
>   
>   struct drm_colorop_state *
> -drm_atomic_get_old_colorop_state(struct drm_atomic_state *state,
> +drm_atomic_get_old_colorop_state(struct drm_atomic_commit *state,
>   				 struct drm_colorop *colorop);
>   struct drm_colorop_state *
> -drm_atomic_get_new_colorop_state(struct drm_atomic_state *state,
> +drm_atomic_get_new_colorop_state(struct drm_atomic_commit *state,
>   				 struct drm_colorop *colorop);
>   
>   struct drm_connector_state * __must_check
> -drm_atomic_get_connector_state(struct drm_atomic_state *state,
> +drm_atomic_get_connector_state(struct drm_atomic_commit *state,
>   			       struct drm_connector *connector);
>   
>   int drm_atomic_private_obj_init(struct drm_device *dev,
>   				struct drm_private_obj *obj,
>   				const struct drm_private_state_funcs *funcs);
>   void drm_atomic_private_obj_fini(struct drm_private_obj *obj);
>   
>   struct drm_private_state * __must_check
> -drm_atomic_get_private_obj_state(struct drm_atomic_state *state,
> +drm_atomic_get_private_obj_state(struct drm_atomic_commit *state,
>   				 struct drm_private_obj *obj);
>   struct drm_private_state *
> -drm_atomic_get_old_private_obj_state(const struct drm_atomic_state *state,
> +drm_atomic_get_old_private_obj_state(const struct drm_atomic_commit *state,
>   				     struct drm_private_obj *obj);
>   struct drm_private_state *
> -drm_atomic_get_new_private_obj_state(const struct drm_atomic_state *state,
> +drm_atomic_get_new_private_obj_state(const struct drm_atomic_commit *state,
>   				     struct drm_private_obj *obj);
>   
>   struct drm_connector *
> -drm_atomic_get_old_connector_for_encoder(const struct drm_atomic_state *state,
> +drm_atomic_get_old_connector_for_encoder(const struct drm_atomic_commit *state,
>   					 struct drm_encoder *encoder);
>   struct drm_connector *
> -drm_atomic_get_new_connector_for_encoder(const struct drm_atomic_state *state,
> +drm_atomic_get_new_connector_for_encoder(const struct drm_atomic_commit *state,
>   					 struct drm_encoder *encoder);
>   struct drm_connector *
>   drm_atomic_get_connector_for_encoder(const struct drm_encoder *encoder,
>   				     struct drm_modeset_acquire_ctx *ctx);
>   
>   struct drm_crtc *
> -drm_atomic_get_old_crtc_for_encoder(struct drm_atomic_state *state,
> +drm_atomic_get_old_crtc_for_encoder(struct drm_atomic_commit *state,
>   					 struct drm_encoder *encoder);
>   struct drm_crtc *
> -drm_atomic_get_new_crtc_for_encoder(struct drm_atomic_state *state,
> +drm_atomic_get_new_crtc_for_encoder(struct drm_atomic_commit *state,
>   					 struct drm_encoder *encoder);
>   
>   /**
>    * drm_atomic_get_old_crtc_state - get old CRTC state, if it exists
>    * @state: global atomic state object
> @@ -775,11 +775,11 @@ drm_atomic_get_new_crtc_for_encoder(struct drm_atomic_state *state,
>    *
>    * This function returns the old CRTC state for the given CRTC, or
>    * NULL if the CRTC is not part of the global atomic state.
>    */
>   static inline struct drm_crtc_state *
> -drm_atomic_get_old_crtc_state(const struct drm_atomic_state *state,
> +drm_atomic_get_old_crtc_state(const struct drm_atomic_commit *state,
>   			      struct drm_crtc *crtc)
>   {
>   	return state->crtcs[drm_crtc_index(crtc)].old_state;
>   }
>   /**
> @@ -789,11 +789,11 @@ drm_atomic_get_old_crtc_state(const struct drm_atomic_state *state,
>    *
>    * This function returns the new CRTC state for the given CRTC, or
>    * NULL if the CRTC is not part of the global atomic state.
>    */
>   static inline struct drm_crtc_state *
> -drm_atomic_get_new_crtc_state(const struct drm_atomic_state *state,
> +drm_atomic_get_new_crtc_state(const struct drm_atomic_commit *state,
>   			      struct drm_crtc *crtc)
>   {
>   	return state->crtcs[drm_crtc_index(crtc)].new_state;
>   }
>   
> @@ -804,11 +804,11 @@ drm_atomic_get_new_crtc_state(const struct drm_atomic_state *state,
>    *
>    * This function returns the old plane state for the given plane, or
>    * NULL if the plane is not part of the global atomic state.
>    */
>   static inline struct drm_plane_state *
> -drm_atomic_get_old_plane_state(const struct drm_atomic_state *state,
> +drm_atomic_get_old_plane_state(const struct drm_atomic_commit *state,
>   			       struct drm_plane *plane)
>   {
>   	return state->planes[drm_plane_index(plane)].old_state;
>   }
>   
> @@ -819,11 +819,11 @@ drm_atomic_get_old_plane_state(const struct drm_atomic_state *state,
>    *
>    * This function returns the new plane state for the given plane, or
>    * NULL if the plane is not part of the global atomic state.
>    */
>   static inline struct drm_plane_state *
> -drm_atomic_get_new_plane_state(const struct drm_atomic_state *state,
> +drm_atomic_get_new_plane_state(const struct drm_atomic_commit *state,
>   			       struct drm_plane *plane)
>   {
>   	return state->planes[drm_plane_index(plane)].new_state;
>   }
>   
> @@ -834,11 +834,11 @@ drm_atomic_get_new_plane_state(const struct drm_atomic_state *state,
>    *
>    * This function returns the old connector state for the given connector,
>    * or NULL if the connector is not part of the global atomic state.
>    */
>   static inline struct drm_connector_state *
> -drm_atomic_get_old_connector_state(const struct drm_atomic_state *state,
> +drm_atomic_get_old_connector_state(const struct drm_atomic_commit *state,
>   				   struct drm_connector *connector)
>   {
>   	int index = drm_connector_index(connector);
>   
>   	if (index >= state->num_connector)
> @@ -854,11 +854,11 @@ drm_atomic_get_old_connector_state(const struct drm_atomic_state *state,
>    *
>    * This function returns the new connector state for the given connector,
>    * or NULL if the connector is not part of the global atomic state.
>    */
>   static inline struct drm_connector_state *
> -drm_atomic_get_new_connector_state(const struct drm_atomic_state *state,
> +drm_atomic_get_new_connector_state(const struct drm_atomic_commit *state,
>   				   struct drm_connector *connector)
>   {
>   	int index = drm_connector_index(connector);
>   
>   	if (index >= state->num_connector)
> @@ -892,11 +892,11 @@ drm_atomic_get_new_connector_state(const struct drm_atomic_state *state,
>    * Returns:
>    *
>    * Read-only pointer to the current plane state.
>    */
>   static inline const struct drm_plane_state *
> -__drm_atomic_get_current_plane_state(const struct drm_atomic_state *state,
> +__drm_atomic_get_current_plane_state(const struct drm_atomic_commit *state,
>   				     struct drm_plane *plane)
>   {
>   	struct drm_plane_state *plane_state;
>   
>   	plane_state = drm_atomic_get_new_plane_state(state, plane);
> @@ -908,31 +908,31 @@ __drm_atomic_get_current_plane_state(const struct drm_atomic_state *state,
>   	 */
>   	return plane->state;
>   }
>   
>   int __must_check
> -drm_atomic_add_encoder_bridges(struct drm_atomic_state *state,
> +drm_atomic_add_encoder_bridges(struct drm_atomic_commit *state,
>   			       struct drm_encoder *encoder);
>   int __must_check
> -drm_atomic_add_affected_connectors(struct drm_atomic_state *state,
> +drm_atomic_add_affected_connectors(struct drm_atomic_commit *state,
>   				   struct drm_crtc *crtc);
>   int __must_check
> -drm_atomic_add_affected_planes(struct drm_atomic_state *state,
> +drm_atomic_add_affected_planes(struct drm_atomic_commit *state,
>   			       struct drm_crtc *crtc);
>   int __must_check
> -drm_atomic_add_affected_colorops(struct drm_atomic_state *state,
> +drm_atomic_add_affected_colorops(struct drm_atomic_commit *state,
>   				 struct drm_plane *plane);
>   
> -int __must_check drm_atomic_check_only(struct drm_atomic_state *state);
> -int __must_check drm_atomic_commit(struct drm_atomic_state *state);
> -int __must_check drm_atomic_nonblocking_commit(struct drm_atomic_state *state);
> +int __must_check drm_atomic_check_only(struct drm_atomic_commit *state);
> +int __must_check drm_atomic_commit(struct drm_atomic_commit *state);
> +int __must_check drm_atomic_nonblocking_commit(struct drm_atomic_commit *state);
>   
>   void drm_state_dump(struct drm_device *dev, struct drm_printer *p);
>   
>   /**
>    * for_each_oldnew_connector_in_state - iterate over all connectors in an atomic update
> - * @__state: &struct drm_atomic_state pointer
> + * @__state: &struct drm_atomic_commit pointer
>    * @connector: &struct drm_connector iteration cursor
>    * @old_connector_state: &struct drm_connector_state iteration cursor for the
>    * 	old state
>    * @new_connector_state: &struct drm_connector_state iteration cursor for the
>    * 	new state
> @@ -952,11 +952,11 @@ void drm_state_dump(struct drm_device *dev, struct drm_printer *p);
>   			     (old_connector_state) = (__state)->connectors[__i].old_state,	\
>   			     (new_connector_state) = (__state)->connectors[__i].new_state, 1))
>   
>   /**
>    * for_each_old_connector_in_state - iterate over all connectors in an atomic update
> - * @__state: &struct drm_atomic_state pointer
> + * @__state: &struct drm_atomic_commit pointer
>    * @connector: &struct drm_connector iteration cursor
>    * @old_connector_state: &struct drm_connector_state iteration cursor for the
>    * 	old state
>    * @__i: int iteration cursor, for macro-internal use
>    *
> @@ -973,11 +973,11 @@ void drm_state_dump(struct drm_device *dev, struct drm_printer *p);
>   			     (void)(connector) /* Only to avoid unused-but-set-variable warning */, \
>   			     (old_connector_state) = (__state)->connectors[__i].old_state, 1))
>   
>   /**
>    * for_each_new_connector_in_state - iterate over all connectors in an atomic update
> - * @__state: &struct drm_atomic_state pointer
> + * @__state: &struct drm_atomic_commit pointer
>    * @connector: &struct drm_connector iteration cursor
>    * @new_connector_state: &struct drm_connector_state iteration cursor for the
>    * 	new state
>    * @__i: int iteration cursor, for macro-internal use
>    *
> @@ -995,11 +995,11 @@ void drm_state_dump(struct drm_device *dev, struct drm_printer *p);
>   			     (new_connector_state) = (__state)->connectors[__i].new_state, \
>   			     (void)(new_connector_state) /* Only to avoid unused-but-set-variable warning */, 1))
>   
>   /**
>    * for_each_oldnew_crtc_in_state - iterate over all CRTCs in an atomic update
> - * @__state: &struct drm_atomic_state pointer
> + * @__state: &struct drm_atomic_commit pointer
>    * @crtc: &struct drm_crtc iteration cursor
>    * @old_crtc_state: &struct drm_crtc_state iteration cursor for the old state
>    * @new_crtc_state: &struct drm_crtc_state iteration cursor for the new state
>    * @__i: int iteration cursor, for macro-internal use
>    *
> @@ -1019,11 +1019,11 @@ void drm_state_dump(struct drm_device *dev, struct drm_printer *p);
>   			     (new_crtc_state) = (__state)->crtcs[__i].new_state, \
>   			     (void)(new_crtc_state) /* Only to avoid unused-but-set-variable warning */, 1))
>   
>   /**
>    * for_each_old_crtc_in_state - iterate over all CRTCs in an atomic update
> - * @__state: &struct drm_atomic_state pointer
> + * @__state: &struct drm_atomic_commit pointer
>    * @crtc: &struct drm_crtc iteration cursor
>    * @old_crtc_state: &struct drm_crtc_state iteration cursor for the old state
>    * @__i: int iteration cursor, for macro-internal use
>    *
>    * This iterates over all CRTCs in an atomic update, tracking only the old
> @@ -1039,11 +1039,11 @@ void drm_state_dump(struct drm_device *dev, struct drm_printer *p);
>   			     (void)(crtc) /* Only to avoid unused-but-set-variable warning */, \
>   			     (old_crtc_state) = (__state)->crtcs[__i].old_state, 1))
>   
>   /**
>    * for_each_new_crtc_in_state - iterate over all CRTCs in an atomic update
> - * @__state: &struct drm_atomic_state pointer
> + * @__state: &struct drm_atomic_commit pointer
>    * @crtc: &struct drm_crtc iteration cursor
>    * @new_crtc_state: &struct drm_crtc_state iteration cursor for the new state
>    * @__i: int iteration cursor, for macro-internal use
>    *
>    * This iterates over all CRTCs in an atomic update, tracking only the new
> @@ -1060,11 +1060,11 @@ void drm_state_dump(struct drm_device *dev, struct drm_printer *p);
>   			     (new_crtc_state) = (__state)->crtcs[__i].new_state, \
>   			     (void)(new_crtc_state) /* Only to avoid unused-but-set-variable warning */, 1))
>   
>   /**
>    * for_each_oldnew_colorop_in_state - iterate over all colorops in an atomic update
> - * @__state: &struct drm_atomic_state pointer
> + * @__state: &struct drm_atomic_commit pointer
>    * @colorop: &struct drm_colorop iteration cursor
>    * @old_colorop_state: &struct drm_colorop_state iteration cursor for the old state
>    * @new_colorop_state: &struct drm_colorop_state iteration cursor for the new state
>    * @__i: int iteration cursor, for macro-internal use
>    *
> @@ -1083,11 +1083,11 @@ void drm_state_dump(struct drm_device *dev, struct drm_printer *p);
>   			      (old_colorop_state) = (__state)->colorops[__i].old_state,\
>   			      (new_colorop_state) = (__state)->colorops[__i].new_state, 1))
>   
>   /**
>    * for_each_new_colorop_in_state - iterate over all colorops in an atomic update
> - * @__state: &struct drm_atomic_state pointer
> + * @__state: &struct drm_atomic_commit pointer
>    * @colorop: &struct drm_colorop iteration cursor
>    * @new_colorop_state: &struct drm_colorop_state iteration cursor for the new state
>    * @__i: int iteration cursor, for macro-internal use
>    *
>    * This iterates over all colorops in an atomic update, tracking new state. This is
> @@ -1103,11 +1103,11 @@ void drm_state_dump(struct drm_device *dev, struct drm_printer *p);
>   			      (void)(colorop) /* Only to avoid unused-but-set-variable warning */, \
>   			      (new_colorop_state) = (__state)->colorops[__i].new_state, 1))
>   
>   /**
>    * for_each_oldnew_plane_in_state - iterate over all planes in an atomic update
> - * @__state: &struct drm_atomic_state pointer
> + * @__state: &struct drm_atomic_commit pointer
>    * @plane: &struct drm_plane iteration cursor
>    * @old_plane_state: &struct drm_plane_state iteration cursor for the old state
>    * @new_plane_state: &struct drm_plane_state iteration cursor for the new state
>    * @__i: int iteration cursor, for macro-internal use
>    *
> @@ -1126,11 +1126,11 @@ void drm_state_dump(struct drm_device *dev, struct drm_printer *p);
>   			      (new_plane_state) = (__state)->planes[__i].new_state, 1))
>   
>   /**
>    * for_each_oldnew_plane_in_state_reverse - iterate over all planes in an atomic
>    * update in reverse order
> - * @__state: &struct drm_atomic_state pointer
> + * @__state: &struct drm_atomic_commit pointer
>    * @plane: &struct drm_plane iteration cursor
>    * @old_plane_state: &struct drm_plane_state iteration cursor for the old state
>    * @new_plane_state: &struct drm_plane_state iteration cursor for the new state
>    * @__i: int iteration cursor, for macro-internal use
>    *
> @@ -1148,11 +1148,11 @@ void drm_state_dump(struct drm_device *dev, struct drm_printer *p);
>   			      (new_plane_state) = (__state)->planes[__i].new_state, 1))
>   
>   /**
>    * for_each_new_plane_in_state_reverse - other than only tracking new state,
>    * it's the same as for_each_oldnew_plane_in_state_reverse
> - * @__state: &struct drm_atomic_state pointer
> + * @__state: &struct drm_atomic_commit pointer
>    * @plane: &struct drm_plane iteration cursor
>    * @new_plane_state: &struct drm_plane_state iteration cursor for the new state
>    * @__i: int iteration cursor, for macro-internal use
>    */
>   #define for_each_new_plane_in_state_reverse(__state, plane, new_plane_state, __i) \
> @@ -1163,11 +1163,11 @@ void drm_state_dump(struct drm_device *dev, struct drm_printer *p);
>   			     ((plane) = (__state)->planes[__i].ptr,	\
>   			      (new_plane_state) = (__state)->planes[__i].new_state, 1))
>   
>   /**
>    * for_each_old_plane_in_state - iterate over all planes in an atomic update
> - * @__state: &struct drm_atomic_state pointer
> + * @__state: &struct drm_atomic_commit pointer
>    * @plane: &struct drm_plane iteration cursor
>    * @old_plane_state: &struct drm_plane_state iteration cursor for the old state
>    * @__i: int iteration cursor, for macro-internal use
>    *
>    * This iterates over all planes in an atomic update, tracking only the old
> @@ -1181,11 +1181,11 @@ void drm_state_dump(struct drm_device *dev, struct drm_printer *p);
>   		for_each_if ((__state)->planes[__i].ptr &&		\
>   			     ((plane) = (__state)->planes[__i].ptr,	\
>   			      (old_plane_state) = (__state)->planes[__i].old_state, 1))
>   /**
>    * for_each_new_plane_in_state - iterate over all planes in an atomic update
> - * @__state: &struct drm_atomic_state pointer
> + * @__state: &struct drm_atomic_commit pointer
>    * @plane: &struct drm_plane iteration cursor
>    * @new_plane_state: &struct drm_plane_state iteration cursor for the new state
>    * @__i: int iteration cursor, for macro-internal use
>    *
>    * This iterates over all planes in an atomic update, tracking only the new
> @@ -1202,11 +1202,11 @@ void drm_state_dump(struct drm_device *dev, struct drm_printer *p);
>   			      (new_plane_state) = (__state)->planes[__i].new_state, \
>   			      (void)(new_plane_state) /* Only to avoid unused-but-set-variable warning */, 1))
>   
>   /**
>    * for_each_oldnew_private_obj_in_state - iterate over all private objects in an atomic update
> - * @__state: &struct drm_atomic_state pointer
> + * @__state: &struct drm_atomic_commit pointer
>    * @obj: &struct drm_private_obj iteration cursor
>    * @old_obj_state: &struct drm_private_state iteration cursor for the old state
>    * @new_obj_state: &struct drm_private_state iteration cursor for the new state
>    * @__i: int iteration cursor, for macro-internal use
>    *
> @@ -1222,11 +1222,11 @@ void drm_state_dump(struct drm_device *dev, struct drm_printer *p);
>   		      (new_obj_state) = (__state)->private_objs[__i].new_state, 1); \
>   	     (__i)++)
>   
>   /**
>    * for_each_old_private_obj_in_state - iterate over all private objects in an atomic update
> - * @__state: &struct drm_atomic_state pointer
> + * @__state: &struct drm_atomic_commit pointer
>    * @obj: &struct drm_private_obj iteration cursor
>    * @old_obj_state: &struct drm_private_state iteration cursor for the old state
>    * @__i: int iteration cursor, for macro-internal use
>    *
>    * This iterates over all private objects in an atomic update, tracking only
> @@ -1240,11 +1240,11 @@ void drm_state_dump(struct drm_device *dev, struct drm_printer *p);
>   		      (old_obj_state) = (__state)->private_objs[__i].old_state, 1); \
>   	     (__i)++)
>   
>   /**
>    * for_each_new_private_obj_in_state - iterate over all private objects in an atomic update
> - * @__state: &struct drm_atomic_state pointer
> + * @__state: &struct drm_atomic_commit pointer
>    * @obj: &struct drm_private_obj iteration cursor
>    * @new_obj_state: &struct drm_private_state iteration cursor for the new state
>    * @__i: int iteration cursor, for macro-internal use
>    *
>    * This iterates over all private objects in an atomic update, tracking only
> @@ -1362,15 +1362,15 @@ drm_priv_to_bridge_state(struct drm_private_state *priv)
>   {
>   	return container_of(priv, struct drm_bridge_state, base);
>   }
>   
>   struct drm_bridge_state *
> -drm_atomic_get_bridge_state(struct drm_atomic_state *state,
> +drm_atomic_get_bridge_state(struct drm_atomic_commit *state,
>   			    struct drm_bridge *bridge);
>   struct drm_bridge_state *
> -drm_atomic_get_old_bridge_state(const struct drm_atomic_state *state,
> +drm_atomic_get_old_bridge_state(const struct drm_atomic_commit *state,
>   				struct drm_bridge *bridge);
>   struct drm_bridge_state *
> -drm_atomic_get_new_bridge_state(const struct drm_atomic_state *state,
> +drm_atomic_get_new_bridge_state(const struct drm_atomic_commit *state,
>   				struct drm_bridge *bridge);
>   
>   #endif /* DRM_ATOMIC_H_ */
> diff --git a/include/drm/drm_atomic_helper.h b/include/drm/drm_atomic_helper.h
> index e154ee4f0696c02d88feb4013c318775dea1a1ee..b84152810abb9a4b53c05b6bfd5b77ce5ab5be89 100644
> --- a/include/drm/drm_atomic_helper.h
> +++ b/include/drm/drm_atomic_helper.h
> @@ -41,111 +41,111 @@
>    * Due to src being in 16.16 fixed point and dest being in integer pixels,
>    * 1<<16 represents no scaling.
>    */
>   #define DRM_PLANE_NO_SCALING (1<<16)
>   
> -struct drm_atomic_state;
> +struct drm_atomic_commit;
>   struct drm_private_obj;
>   struct drm_private_state;
>   
>   int drm_atomic_helper_check_modeset(struct drm_device *dev,
> -				struct drm_atomic_state *state);
> +				struct drm_atomic_commit *state);
>   int drm_atomic_helper_check_wb_connector_state(struct drm_connector *connector,
> -					       struct drm_atomic_state *state);
> +					       struct drm_atomic_commit *state);
>   int drm_atomic_helper_check_plane_state(struct drm_plane_state *plane_state,
>   					const struct drm_crtc_state *crtc_state,
>   					int min_scale,
>   					int max_scale,
>   					bool can_position,
>   					bool can_update_disabled);
>   int drm_atomic_helper_check_planes(struct drm_device *dev,
> -			       struct drm_atomic_state *state);
> +			       struct drm_atomic_commit *state);
>   int drm_atomic_helper_check_crtc_primary_plane(struct drm_crtc_state *crtc_state);
>   void drm_atomic_helper_commit_encoder_bridge_disable(struct drm_device *dev,
> -						     struct drm_atomic_state *state);
> +						     struct drm_atomic_commit *state);
>   void drm_atomic_helper_commit_crtc_disable(struct drm_device *dev,
> -					   struct drm_atomic_state *state);
> +					   struct drm_atomic_commit *state);
>   void drm_atomic_helper_commit_encoder_bridge_post_disable(struct drm_device *dev,
> -							  struct drm_atomic_state *state);
> +							  struct drm_atomic_commit *state);
>   int drm_atomic_helper_check(struct drm_device *dev,
> -			    struct drm_atomic_state *state);
> -void drm_atomic_helper_commit_tail(struct drm_atomic_state *state);
> -void drm_atomic_helper_commit_tail_rpm(struct drm_atomic_state *state);
> +			    struct drm_atomic_commit *state);
> +void drm_atomic_helper_commit_tail(struct drm_atomic_commit *state);
> +void drm_atomic_helper_commit_tail_rpm(struct drm_atomic_commit *state);
>   int drm_atomic_helper_commit(struct drm_device *dev,
> -			     struct drm_atomic_state *state,
> +			     struct drm_atomic_commit *state,
>   			     bool nonblock);
>   int drm_atomic_helper_async_check(struct drm_device *dev,
> -				  struct drm_atomic_state *state);
> +				  struct drm_atomic_commit *state);
>   void drm_atomic_helper_async_commit(struct drm_device *dev,
> -				    struct drm_atomic_state *state);
> +				    struct drm_atomic_commit *state);
>   
>   int drm_atomic_helper_wait_for_fences(struct drm_device *dev,
> -					struct drm_atomic_state *state,
> +					struct drm_atomic_commit *state,
>   					bool pre_swap);
>   
>   void drm_atomic_helper_wait_for_vblanks(struct drm_device *dev,
> -					struct drm_atomic_state *old_state);
> +					struct drm_atomic_commit *old_state);
>   
>   void drm_atomic_helper_wait_for_flip_done(struct drm_device *dev,
> -					  struct drm_atomic_state *old_state);
> +					  struct drm_atomic_commit *old_state);
>   
>   void
>   drm_atomic_helper_update_legacy_modeset_state(struct drm_device *dev,
> -					      struct drm_atomic_state *old_state);
> +					      struct drm_atomic_commit *old_state);
>   
>   void
> -drm_atomic_helper_calc_timestamping_constants(struct drm_atomic_state *state);
> +drm_atomic_helper_calc_timestamping_constants(struct drm_atomic_commit *state);
>   
>   void drm_atomic_helper_commit_crtc_set_mode(struct drm_device *dev,
> -					    struct drm_atomic_state *state);
> +					    struct drm_atomic_commit *state);
>   
>   void drm_atomic_helper_commit_modeset_disables(struct drm_device *dev,
> -					       struct drm_atomic_state *state);
> +					       struct drm_atomic_commit *state);
>   
>   void drm_atomic_helper_commit_writebacks(struct drm_device *dev,
> -					 struct drm_atomic_state *state);
> +					 struct drm_atomic_commit *state);
>   
>   void drm_atomic_helper_commit_encoder_bridge_pre_enable(struct drm_device *dev,
> -							struct drm_atomic_state *state);
> +							struct drm_atomic_commit *state);
>   
>   void drm_atomic_helper_commit_crtc_enable(struct drm_device *dev,
> -					  struct drm_atomic_state *state);
> +					  struct drm_atomic_commit *state);
>   
>   void drm_atomic_helper_commit_encoder_bridge_enable(struct drm_device *dev,
> -						    struct drm_atomic_state *state);
> +						    struct drm_atomic_commit *state);
>   
>   void drm_atomic_helper_commit_modeset_enables(struct drm_device *dev,
> -					  struct drm_atomic_state *old_state);
> +					  struct drm_atomic_commit *old_state);
>   
>   int drm_atomic_helper_prepare_planes(struct drm_device *dev,
> -				     struct drm_atomic_state *state);
> +				     struct drm_atomic_commit *state);
>   void drm_atomic_helper_unprepare_planes(struct drm_device *dev,
> -					struct drm_atomic_state *state);
> +					struct drm_atomic_commit *state);
>   
>   #define DRM_PLANE_COMMIT_ACTIVE_ONLY			BIT(0)
>   #define DRM_PLANE_COMMIT_NO_DISABLE_AFTER_MODESET	BIT(1)
>   
>   void drm_atomic_helper_commit_planes(struct drm_device *dev,
> -				     struct drm_atomic_state *state,
> +				     struct drm_atomic_commit *state,
>   				     uint32_t flags);
>   void drm_atomic_helper_cleanup_planes(struct drm_device *dev,
> -				      struct drm_atomic_state *old_state);
> +				      struct drm_atomic_commit *old_state);
>   void drm_atomic_helper_commit_planes_on_crtc(struct drm_crtc_state *old_crtc_state);
>   void
>   drm_atomic_helper_disable_planes_on_crtc(struct drm_crtc_state *old_crtc_state,
>   					 bool atomic);
>   
> -int __must_check drm_atomic_helper_swap_state(struct drm_atomic_state *state,
> +int __must_check drm_atomic_helper_swap_state(struct drm_atomic_commit *state,
>   					      bool stall);
>   
>   /* nonblocking commit helpers */
> -int drm_atomic_helper_setup_commit(struct drm_atomic_state *state,
> +int drm_atomic_helper_setup_commit(struct drm_atomic_commit *state,
>   				   bool nonblock);
> -void drm_atomic_helper_wait_for_dependencies(struct drm_atomic_state *state);
> -void drm_atomic_helper_fake_vblank(struct drm_atomic_state *state);
> -void drm_atomic_helper_commit_hw_done(struct drm_atomic_state *state);
> -void drm_atomic_helper_commit_cleanup_done(struct drm_atomic_state *state);
> +void drm_atomic_helper_wait_for_dependencies(struct drm_atomic_commit *state);
> +void drm_atomic_helper_fake_vblank(struct drm_atomic_commit *state);
> +void drm_atomic_helper_commit_hw_done(struct drm_atomic_commit *state);
> +void drm_atomic_helper_commit_cleanup_done(struct drm_atomic_commit *state);
>   
>   /* implementations for legacy interfaces */
>   int drm_atomic_helper_update_plane(struct drm_plane *plane,
>   				   struct drm_crtc *crtc,
>   				   struct drm_framebuffer *fb,
> @@ -162,18 +162,18 @@ int drm_atomic_helper_set_config(struct drm_mode_set *set,
>   int drm_atomic_helper_disable_all(struct drm_device *dev,
>   				  struct drm_modeset_acquire_ctx *ctx);
>   int drm_atomic_helper_reset_crtc(struct drm_crtc *crtc,
>   				 struct drm_modeset_acquire_ctx *ctx);
>   void drm_atomic_helper_shutdown(struct drm_device *dev);
> -struct drm_atomic_state *
> +struct drm_atomic_commit *
>   drm_atomic_helper_duplicate_state(struct drm_device *dev,
>   				  struct drm_modeset_acquire_ctx *ctx);
> -struct drm_atomic_state *drm_atomic_helper_suspend(struct drm_device *dev);
> -int drm_atomic_helper_commit_duplicated_state(struct drm_atomic_state *state,
> +struct drm_atomic_commit *drm_atomic_helper_suspend(struct drm_device *dev);
> +int drm_atomic_helper_commit_duplicated_state(struct drm_atomic_commit *state,
>   					      struct drm_modeset_acquire_ctx *ctx);
>   int drm_atomic_helper_resume(struct drm_device *dev,
> -			     struct drm_atomic_state *state);
> +			     struct drm_atomic_commit *state);
>   
>   int drm_atomic_helper_page_flip(struct drm_crtc *crtc,
>   				struct drm_framebuffer *fb,
>   				struct drm_pending_vblank_event *event,
>   				uint32_t flags,
> diff --git a/include/drm/drm_atomic_state_helper.h b/include/drm/drm_atomic_state_helper.h
> index 900672c6ea90ba9cb87e38a7c84225972aee43c5..61a3b38ad49fd10861b1f65d838c99843ab47859 100644
> --- a/include/drm/drm_atomic_state_helper.h
> +++ b/include/drm/drm_atomic_state_helper.h
> @@ -24,11 +24,11 @@
>    * Daniel Vetter <daniel.vetter@ffwll.ch>
>    */
>   
>   #include <linux/types.h>
>   
> -struct drm_atomic_state;
> +struct drm_atomic_commit;
>   struct drm_bridge;
>   struct drm_bridge_state;
>   struct drm_crtc;
>   struct drm_crtc_state;
>   struct drm_plane;
> @@ -71,11 +71,11 @@ void __drm_atomic_helper_connector_state_reset(struct drm_connector_state *conn_
>   void __drm_atomic_helper_connector_reset(struct drm_connector *connector,
>   					 struct drm_connector_state *conn_state);
>   void drm_atomic_helper_connector_reset(struct drm_connector *connector);
>   void drm_atomic_helper_connector_tv_reset(struct drm_connector *connector);
>   int drm_atomic_helper_connector_tv_check(struct drm_connector *connector,
> -					 struct drm_atomic_state *state);
> +					 struct drm_atomic_commit *state);
>   void drm_atomic_helper_connector_tv_margins_reset(struct drm_connector *connector);
>   void
>   __drm_atomic_helper_connector_duplicate_state(struct drm_connector *connector,
>   					   struct drm_connector_state *state);
>   struct drm_connector_state *
> diff --git a/include/drm/drm_blend.h b/include/drm/drm_blend.h
> index c7e888767c81c2745cd3cce88c10db4bbe305d1e..bebbb77a8f2140279bd5b260c21d558d67a4be75 100644
> --- a/include/drm/drm_blend.h
> +++ b/include/drm/drm_blend.h
> @@ -29,11 +29,11 @@
>   
>   #define DRM_MODE_BLEND_PREMULTI		0
>   #define DRM_MODE_BLEND_COVERAGE		1
>   #define DRM_MODE_BLEND_PIXEL_NONE	2
>   
> -struct drm_atomic_state;
> +struct drm_atomic_commit;
>   struct drm_crtc;
>   struct drm_device;
>   struct drm_plane;
>   
>   static inline bool drm_rotation_90_or_270(unsigned int rotation)
> @@ -54,10 +54,10 @@ int drm_plane_create_zpos_property(struct drm_plane *plane,
>   				   unsigned int zpos,
>   				   unsigned int min, unsigned int max);
>   int drm_plane_create_zpos_immutable_property(struct drm_plane *plane,
>   					     unsigned int zpos);
>   int drm_atomic_normalize_zpos(struct drm_device *dev,
> -			      struct drm_atomic_state *state);
> +			      struct drm_atomic_commit *state);
>   int drm_plane_create_blend_mode_property(struct drm_plane *plane,
>   					 unsigned int supported_modes);
>   void drm_crtc_attach_background_color_property(struct drm_crtc *crtc);
>   #endif
> diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
> index a8d67bd9ee505fde4b3798f8ddcbde1c5b00ab0f..1ea13fa273c422ce7b323fd91c59a24a3e447985 100644
> --- a/include/drm/drm_bridge.h
> +++ b/include/drm/drm_bridge.h
> @@ -315,11 +315,11 @@ struct drm_bridge_funcs {
>   	 * there is one) when this callback is called.
>   	 *
>   	 * The @atomic_pre_enable callback is optional.
>   	 */
>   	void (*atomic_pre_enable)(struct drm_bridge *bridge,
> -				  struct drm_atomic_state *state);
> +				  struct drm_atomic_commit *state);
>   
>   	/**
>   	 * @atomic_enable:
>   	 *
>   	 * This callback should enable the bridge. It is called right after
> @@ -335,11 +335,11 @@ struct drm_bridge_funcs {
>   	 * chain if there is one.
>   	 *
>   	 * The @atomic_enable callback is optional.
>   	 */
>   	void (*atomic_enable)(struct drm_bridge *bridge,
> -			      struct drm_atomic_state *state);
> +			      struct drm_atomic_commit *state);
>   	/**
>   	 * @atomic_disable:
>   	 *
>   	 * This callback should disable the bridge. It is called right before
>   	 * the preceding element in the display pipe is disabled. If the
> @@ -352,11 +352,11 @@ struct drm_bridge_funcs {
>   	 * signals) feeding it is still running when this callback is called.
>   	 *
>   	 * The @atomic_disable callback is optional.
>   	 */
>   	void (*atomic_disable)(struct drm_bridge *bridge,
> -			       struct drm_atomic_state *state);
> +			       struct drm_atomic_commit *state);
>   
>   	/**
>   	 * @atomic_post_disable:
>   	 *
>   	 * This callback should disable the bridge. It is called right after the
> @@ -371,11 +371,11 @@ struct drm_bridge_funcs {
>   	 * called.
>   	 *
>   	 * The @atomic_post_disable callback is optional.
>   	 */
>   	void (*atomic_post_disable)(struct drm_bridge *bridge,
> -				    struct drm_atomic_state *state);
> +				    struct drm_atomic_commit *state);
>   
>   	/**
>   	 * @atomic_duplicate_state:
>   	 *
>   	 * Duplicate the current bridge state object (which is guaranteed to be
> @@ -1524,17 +1524,17 @@ void drm_bridge_chain_mode_set(struct drm_bridge *bridge,
>   
>   int drm_atomic_bridge_chain_check(struct drm_bridge *bridge,
>   				  struct drm_crtc_state *crtc_state,
>   				  struct drm_connector_state *conn_state);
>   void drm_atomic_bridge_chain_disable(struct drm_bridge *bridge,
> -				     struct drm_atomic_state *state);
> +				     struct drm_atomic_commit *state);
>   void drm_atomic_bridge_chain_post_disable(struct drm_bridge *bridge,
> -					  struct drm_atomic_state *state);
> +					  struct drm_atomic_commit *state);
>   void drm_atomic_bridge_chain_pre_enable(struct drm_bridge *bridge,
> -					struct drm_atomic_state *state);
> +					struct drm_atomic_commit *state);
>   void drm_atomic_bridge_chain_enable(struct drm_bridge *bridge,
> -				    struct drm_atomic_state *state);
> +				    struct drm_atomic_commit *state);
>   
>   u32 *
>   drm_atomic_helper_bridge_propagate_bus_fmt(struct drm_bridge *bridge,
>   					struct drm_bridge_state *bridge_state,
>   					struct drm_crtc_state *crtc_state,
> diff --git a/include/drm/drm_colorop.h b/include/drm/drm_colorop.h
> index bd082854ca74cac90b42020b09206a8516687666..c873199c60da9b9e3c17fcfc9de1a12ef94144a0 100644
> --- a/include/drm/drm_colorop.h
> +++ b/include/drm/drm_colorop.h
> @@ -181,12 +181,12 @@ struct drm_colorop_state {
>   	 * See the &drm_colorop_type documentation for how blob is laid
>   	 * out.
>   	 */
>   	struct drm_property_blob *data;
>   
> -	/** @state: backpointer to global drm_atomic_state */
> -	struct drm_atomic_state *state;
> +	/** @state: backpointer to global drm_atomic_commit */
> +	struct drm_atomic_commit *state;
>   };
>   
>   /**
>    * struct drm_colorop_funcs - driver colorop control functions
>    */
> diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
> index af8b92d2d5b7a4431b57f214cb54f0a3f8c4ba56..7e97dac96b671c5be9f43f67cee932bd89e8848a 100644
> --- a/include/drm/drm_connector.h
> +++ b/include/drm/drm_connector.h
> @@ -1058,12 +1058,12 @@ struct drm_connector_state {
>   	 * @link_status: Connector link_status to keep track of whether link is
>   	 * GOOD or BAD to notify userspace if retraining is necessary.
>   	 */
>   	enum drm_link_status link_status;
>   
> -	/** @state: backpointer to global drm_atomic_state */
> -	struct drm_atomic_state *state;
> +	/** @state: backpointer to global drm_atomic_commit */
> +	struct drm_atomic_commit *state;
>   
>   	/**
>   	 * @commit: Tracks the pending commit to prevent use-after-free conditions.
>   	 *
>   	 * Is only set when @crtc is NULL.
> @@ -2304,11 +2304,11 @@ struct drm_connector {
>   	 *
>   	 * Current atomic state for this connector.
>   	 *
>   	 * This is protected by &drm_mode_config.connection_mutex. Note that
>   	 * nonblocking atomic commits access the current connector state without
> -	 * taking locks. Either by going through the &struct drm_atomic_state
> +	 * taking locks. Either by going through the &struct drm_atomic_commit
>   	 * pointers, see for_each_oldnew_connector_in_state(),
>   	 * for_each_old_connector_in_state() and
>   	 * for_each_new_connector_in_state(). Or through careful ordering of
>   	 * atomic commit operations as implemented in the atomic helpers, see
>   	 * &struct drm_crtc_commit.
> diff --git a/include/drm/drm_crtc.h b/include/drm/drm_crtc.h
> index 312fc1e745d226adec787cd5f1b7c923fe629670..c6dbe8b7db9eeed943399128a52ba0a3d5adcdc9 100644
> --- a/include/drm/drm_crtc.h
> +++ b/include/drm/drm_crtc.h
> @@ -56,11 +56,11 @@ static inline uint64_t I642U64(int64_t val)
>   
>   struct drm_crtc;
>   struct drm_pending_vblank_event;
>   struct drm_plane;
>   struct drm_bridge;
> -struct drm_atomic_state;
> +struct drm_atomic_commit;
>   
>   struct drm_crtc_helper_funcs;
>   struct drm_plane_helper_funcs;
>   
>   /**
> @@ -404,12 +404,12 @@ struct drm_crtc_state {
>   	 * various phases. This is never cleared, except when we destroy the
>   	 * state, so that subsequent commits can synchronize with previous ones.
>   	 */
>   	struct drm_crtc_commit *commit;
>   
> -	/** @state: backpointer to global drm_atomic_state */
> -	struct drm_atomic_state *state;
> +	/** @state: backpointer to global drm_atomic_commit */
> +	struct drm_atomic_commit *state;
>   };
>   
>   /**
>    * struct drm_crtc_funcs - control CRTCs for a given device
>    *
> @@ -1122,11 +1122,11 @@ struct drm_crtc {
>   	 *
>   	 * Current atomic state for this CRTC.
>   	 *
>   	 * This is protected by @mutex. Note that nonblocking atomic commits
>   	 * access the current CRTC state without taking locks. Either by going
> -	 * through the &struct drm_atomic_state pointers, see
> +	 * through the &struct drm_atomic_commit pointers, see
>   	 * for_each_oldnew_crtc_in_state(), for_each_old_crtc_in_state() and
>   	 * for_each_new_crtc_in_state(). Or through careful ordering of atomic
>   	 * commit operations as implemented in the atomic helpers, see
>   	 * &struct drm_crtc_commit.
>   	 */
> @@ -1215,11 +1215,11 @@ struct drm_crtc {
>    * @y: position of this CRTC relative to @fb
>    * @connectors: array of connectors to drive with this CRTC if possible
>    * @num_connectors: size of @connectors array
>    *
>    * This represents a modeset configuration for the legacy SETCRTC ioctl and is
> - * also used internally. Atomic drivers instead use &drm_atomic_state.
> + * also used internally. Atomic drivers instead use &drm_atomic_commit.
>    */
>   struct drm_mode_set {
>   	struct drm_framebuffer *fb;
>   	struct drm_crtc *crtc;
>   	struct drm_display_mode *mode;
> diff --git a/include/drm/drm_crtc_helper.h b/include/drm/drm_crtc_helper.h
> index 8c886fc46ef229e59ef37b0df51a0da66618f5b0..855da5733c478052e71261aab5d34f60d8a8b645 100644
> --- a/include/drm/drm_crtc_helper.h
> +++ b/include/drm/drm_crtc_helper.h
> @@ -33,11 +33,11 @@
>   #ifndef __DRM_CRTC_HELPER_H__
>   #define __DRM_CRTC_HELPER_H__
>   
>   #include <linux/types.h>
>   
> -struct drm_atomic_state;
> +struct drm_atomic_commit;
>   struct drm_connector;
>   struct drm_crtc;
>   struct drm_device;
>   struct drm_display_mode;
>   struct drm_encoder;
> @@ -51,11 +51,11 @@ int drm_crtc_helper_set_config(struct drm_mode_set *set,
>   bool drm_crtc_helper_set_mode(struct drm_crtc *crtc,
>   			      struct drm_display_mode *mode,
>   			      int x, int y,
>   			      struct drm_framebuffer *old_fb);
>   int drm_crtc_helper_atomic_check(struct drm_crtc *crtc,
> -				 struct drm_atomic_state *state);
> +				 struct drm_atomic_commit *state);
>   bool drm_helper_crtc_in_use(struct drm_crtc *crtc);
>   bool drm_helper_encoder_in_use(struct drm_encoder *encoder);
>   
>   int drm_helper_connector_dpms(struct drm_connector *connector, int mode);
>   
> diff --git a/include/drm/drm_damage_helper.h b/include/drm/drm_damage_helper.h
> index a58cbcd1127695adcf881dc431ffd858e4b1ae34..3661aeab2cd3a93b670ba77a964ae559e844c105 100644
> --- a/include/drm/drm_damage_helper.h
> +++ b/include/drm/drm_damage_helper.h
> @@ -62,11 +62,11 @@ struct drm_atomic_helper_damage_iter {
>   	uint32_t curr_clip;
>   	/* private: Whether need full plane update. */
>   	bool full_update;
>   };
>   
> -void drm_atomic_helper_check_plane_damage(struct drm_atomic_state *state,
> +void drm_atomic_helper_check_plane_damage(struct drm_atomic_commit *state,
>   					  struct drm_plane_state *plane_state);
>   int drm_atomic_helper_dirtyfb(struct drm_framebuffer *fb,
>   			      struct drm_file *file_priv, unsigned int flags,
>   			      unsigned int color, struct drm_clip_rect *clips,
>   			      unsigned int num_clips);
> diff --git a/include/drm/drm_kunit_helpers.h b/include/drm/drm_kunit_helpers.h
> index 4948379237e96163dfda0d2f180c0c564e7d110e..e653bc7b1e40bc806d16e7d1564b9bd68f8264c1 100644
> --- a/include/drm/drm_kunit_helpers.h
> +++ b/include/drm/drm_kunit_helpers.h
> @@ -95,11 +95,11 @@ __drm_kunit_helper_alloc_drm_device(struct kunit *test,
>   	((_type *)__drm_kunit_helper_alloc_drm_device(_test, _dev,		\
>   						      sizeof(_type),		\
>   						      offsetof(_type, _member),	\
>   						      _feat))
>   
> -struct drm_atomic_state *
> +struct drm_atomic_commit *
>   drm_kunit_helper_atomic_state_alloc(struct kunit *test,
>   				    struct drm_device *drm,
>   				    struct drm_modeset_acquire_ctx *ctx);
>   
>   struct drm_plane *
> diff --git a/include/drm/drm_mode_config.h b/include/drm/drm_mode_config.h
> index 687c0ee163d25dfa7cf563e77209dd33e349800b..e584652ddf67670b05f58b042fb888785e105160 100644
> --- a/include/drm/drm_mode_config.h
> +++ b/include/drm/drm_mode_config.h
> @@ -31,11 +31,11 @@
>   
>   #include <drm/drm_modeset_lock.h>
>   
>   struct drm_file;
>   struct drm_device;
> -struct drm_atomic_state;
> +struct drm_atomic_commit;
>   struct drm_mode_fb_cmd2;
>   struct drm_format_info;
>   struct drm_display_mode;
>   
>   /**
> @@ -156,11 +156,11 @@ struct drm_mode_config_funcs {
>   	 *
>   	 * See the documentation of @atomic_commit for an exhaustive list of
>   	 * error conditions which don't have to be checked at the in this
>   	 * callback.
>   	 *
> -	 * See the documentation for &struct drm_atomic_state for how exactly
> +	 * See the documentation for &struct drm_atomic_commit for how exactly
>   	 * an atomic modeset update is described.
>   	 *
>   	 * Drivers using the atomic helpers can implement this hook using
>   	 * drm_atomic_helper_check(), or one of the exported sub-functions of
>   	 * it.
> @@ -182,21 +182,21 @@ struct drm_mode_config_funcs {
>   	 *    needs to completely bail out to recover from an exceptional
>   	 *    situation like a GPU hang. From a userspace point all errors are
>   	 *    treated equally.
>   	 */
>   	int (*atomic_check)(struct drm_device *dev,
> -			    struct drm_atomic_state *state);
> +			    struct drm_atomic_commit *state);
>   
>   	/**
>   	 * @atomic_commit:
>   	 *
>   	 * This is the only hook to commit an atomic modeset update. The core
>   	 * guarantees that @atomic_check has been called successfully before
>   	 * calling this function, and that nothing has been changed in the
>   	 * interim.
>   	 *
> -	 * See the documentation for &struct drm_atomic_state for how exactly
> +	 * See the documentation for &struct drm_atomic_commit for how exactly
>   	 * an atomic modeset update is described.
>   	 *
>   	 * Drivers using the atomic helpers can implement this hook using
>   	 * drm_atomic_helper_commit(), or one of the exported sub-functions of
>   	 * it.
> @@ -264,65 +264,65 @@ struct drm_mode_config_funcs {
>   	 * return -EINVAL (any invalid requests should be caught in
>   	 * @atomic_check) or -EDEADLK (this function must not acquire
>   	 * additional modeset locks).
>   	 */
>   	int (*atomic_commit)(struct drm_device *dev,
> -			     struct drm_atomic_state *state,
> +			     struct drm_atomic_commit *state,
>   			     bool nonblock);
>   
>   	/**
>   	 * @atomic_state_alloc:
>   	 *
>   	 * This optional hook can be used by drivers that want to subclass struct
> -	 * &drm_atomic_state to be able to track their own driver-private global
> +	 * &drm_atomic_commit to be able to track their own driver-private global
>   	 * state easily. If this hook is implemented, drivers must also
>   	 * implement @atomic_state_clear and @atomic_state_free.
>   	 *
> -	 * Subclassing of &drm_atomic_state is deprecated in favour of using
> +	 * Subclassing of &drm_atomic_commit is deprecated in favour of using
>   	 * &drm_private_state and &drm_private_obj.
>   	 *
>   	 * RETURNS:
>   	 *
> -	 * A new &drm_atomic_state on success or NULL on failure.
> +	 * A new &drm_atomic_commit on success or NULL on failure.
>   	 */
> -	struct drm_atomic_state *(*atomic_state_alloc)(struct drm_device *dev);
> +	struct drm_atomic_commit *(*atomic_state_alloc)(struct drm_device *dev);
>   
>   	/**
>   	 * @atomic_state_clear:
>   	 *
>   	 * This hook must clear any driver private state duplicated into the
> -	 * passed-in &drm_atomic_state. This hook is called when the caller
> +	 * passed-in &drm_atomic_commit. This hook is called when the caller
>   	 * encountered a &drm_modeset_lock deadlock and needs to drop all
>   	 * already acquired locks as part of the deadlock avoidance dance
>   	 * implemented in drm_modeset_backoff().
>   	 *
>   	 * Any duplicated state must be invalidated since a concurrent atomic
>   	 * update might change it, and the drm atomic interfaces always apply
>   	 * updates as relative changes to the current state.
>   	 *
> -	 * Drivers that implement this must call drm_atomic_state_default_clear()
> +	 * Drivers that implement this must call drm_atomic_commit_default_clear()
>   	 * to clear common state.
>   	 *
> -	 * Subclassing of &drm_atomic_state is deprecated in favour of using
> +	 * Subclassing of &drm_atomic_commit is deprecated in favour of using
>   	 * &drm_private_state and &drm_private_obj.
>   	 */
> -	void (*atomic_state_clear)(struct drm_atomic_state *state);
> +	void (*atomic_state_clear)(struct drm_atomic_commit *state);
>   
>   	/**
>   	 * @atomic_state_free:
>   	 *
> -	 * This hook needs driver private resources and the &drm_atomic_state
> -	 * itself. Note that the core first calls drm_atomic_state_clear() to
> +	 * This hook needs driver private resources and the &drm_atomic_commit
> +	 * itself. Note that the core first calls drm_atomic_commit_clear() to
>   	 * avoid code duplicate between the clear and free hooks.
>   	 *
>   	 * Drivers that implement this must call
> -	 * drm_atomic_state_default_release() to release common resources.
> +	 * drm_atomic_commit_default_release() to release common resources.
>   	 *
> -	 * Subclassing of &drm_atomic_state is deprecated in favour of using
> +	 * Subclassing of &drm_atomic_commit is deprecated in favour of using
>   	 * &drm_private_state and &drm_private_obj.
>   	 */
> -	void (*atomic_state_free)(struct drm_atomic_state *state);
> +	void (*atomic_state_free)(struct drm_atomic_commit *state);
>   };
>   
>   /**
>    * struct drm_mode_config - Mode configuration control structure
>    * @min_width: minimum fb pixel width on this device
> @@ -983,11 +983,11 @@ struct drm_mode_config {
>   	 *
>   	 * Atomic state when suspended.
>   	 * Set by drm_mode_config_helper_suspend() and cleared by
>   	 * drm_mode_config_helper_resume().
>   	 */
> -	struct drm_atomic_state *suspend_state;
> +	struct drm_atomic_commit *suspend_state;
>   
>   	const struct drm_mode_config_helper_funcs *helper_private;
>   };
>   
>   int __must_check drmm_mode_config_init(struct drm_device *dev);
> diff --git a/include/drm/drm_modeset_helper_vtables.h b/include/drm/drm_modeset_helper_vtables.h
> index 3e68213958dd836eb6547391e50a19c53b80b5b6..ca6268945c28d383b447d4b453ecca4f4af42ffb 100644
> --- a/include/drm/drm_modeset_helper_vtables.h
> +++ b/include/drm/drm_modeset_helper_vtables.h
> @@ -330,11 +330,11 @@ struct drm_crtc_helper_funcs {
>   	 * supported, -ENOMEM on memory allocation failure and -EDEADLK if an
>   	 * attempt to obtain another state object ran into a &drm_modeset_lock
>   	 * deadlock.
>   	 */
>   	int (*atomic_check)(struct drm_crtc *crtc,
> -			    struct drm_atomic_state *state);
> +			    struct drm_atomic_commit *state);
>   
>   	/**
>   	 * @atomic_begin:
>   	 *
>   	 * Drivers should prepare for an atomic update of multiple planes on
> @@ -351,11 +351,11 @@ struct drm_crtc_helper_funcs {
>   	 *
>   	 * This callback is used by the atomic modeset helpers, but it is
>   	 * optional.
>   	 */
>   	void (*atomic_begin)(struct drm_crtc *crtc,
> -			     struct drm_atomic_state *state);
> +			     struct drm_atomic_commit *state);
>   	/**
>   	 * @atomic_flush:
>   	 *
>   	 * Drivers should finalize an atomic update of multiple planes on
>   	 * a CRTC in this hook. Depending upon hardware this might include
> @@ -375,11 +375,11 @@ struct drm_crtc_helper_funcs {
>   	 *
>   	 * This callback is used by the atomic modeset helpers, but it is
>   	 * optional.
>   	 */
>   	void (*atomic_flush)(struct drm_crtc *crtc,
> -			     struct drm_atomic_state *state);
> +			     struct drm_atomic_commit *state);
>   
>   	/**
>   	 * @atomic_enable:
>   	 *
>   	 * This callback should be used to enable the CRTC. With the atomic
> @@ -397,11 +397,11 @@ struct drm_crtc_helper_funcs {
>   	 * drivers.
>   	 *
>   	 * This function is optional.
>   	 */
>   	void (*atomic_enable)(struct drm_crtc *crtc,
> -			      struct drm_atomic_state *state);
> +			      struct drm_atomic_commit *state);
>   
>   	/**
>   	 * @atomic_disable:
>   	 *
>   	 * This callback should be used to disable the CRTC. With the atomic
> @@ -417,11 +417,11 @@ struct drm_crtc_helper_funcs {
>   	 * CRTC level.
>   	 *
>   	 * This function is optional.
>   	 */
>   	void (*atomic_disable)(struct drm_crtc *crtc,
> -			       struct drm_atomic_state *state);
> +			       struct drm_atomic_commit *state);
>   
>   	/**
>   	 * @get_scanout_position:
>   	 *
>   	 * Called by vblank timestamping code.
> @@ -711,11 +711,11 @@ struct drm_encoder_helper_funcs {
>   	 * level. To ensure that runtime PM handling (using either DPMS or the
>   	 * new "ACTIVE" property) works @atomic_disable must be the inverse of
>   	 * @atomic_enable.
>   	 */
>   	void (*atomic_disable)(struct drm_encoder *encoder,
> -			       struct drm_atomic_state *state);
> +			       struct drm_atomic_commit *state);
>   
>   	/**
>   	 * @atomic_enable:
>   	 *
>   	 * This callback should be used to enable the encoder. It is called
> @@ -734,11 +734,11 @@ struct drm_encoder_helper_funcs {
>   	 * no need to enable anything at the encoder level. To ensure that
>   	 * runtime PM handling works @atomic_enable must be the inverse of
>   	 * @atomic_disable.
>   	 */
>   	void (*atomic_enable)(struct drm_encoder *encoder,
> -			      struct drm_atomic_state *state);
> +			      struct drm_atomic_commit *state);
>   
>   	/**
>   	 * @disable:
>   	 *
>   	 * This callback should be used to disable the encoder. With the atomic
> @@ -807,11 +807,11 @@ struct drm_encoder_helper_funcs {
>   	 *
>   	 * NOTE:
>   	 *
>   	 * This function is called in the check phase of an atomic update. The
>   	 * driver is not allowed to change anything outside of the free-standing
> -	 * state objects passed-in or assembled in the overall &drm_atomic_state
> +	 * state objects passed-in or assembled in the overall &drm_atomic_commit
>   	 * update tracking structure.
>   	 *
>   	 * Also beware that userspace can request its own custom modes, neither
>   	 * core nor helpers filter modes to the list of probe modes reported by
>   	 * the GETCONNECTOR IOCTL and stored in &drm_connector.modes. To ensure
> @@ -1042,21 +1042,21 @@ struct drm_connector_helper_funcs {
>   	 *
>   	 * NOTE:
>   	 *
>   	 * This function is called in the check phase of an atomic update. The
>   	 * driver is not allowed to change anything outside of the
> -	 * &drm_atomic_state update tracking structure passed in.
> +	 * &drm_atomic_commit update tracking structure passed in.
>   	 *
>   	 * RETURNS:
>   	 *
>   	 * Encoder that should be used for the given connector and connector
>   	 * state, or NULL if no suitable encoder exists. Note that the helpers
>   	 * will ensure that encoders aren't used twice, drivers should not check
>   	 * for this.
>   	 */
>   	struct drm_encoder *(*atomic_best_encoder)(struct drm_connector *connector,
> -						   struct drm_atomic_state *state);
> +						   struct drm_atomic_commit *state);
>   
>   	/**
>   	 * @atomic_check:
>   	 *
>   	 * This hook is used to validate connector state. This function is
> @@ -1075,22 +1075,22 @@ struct drm_connector_helper_funcs {
>   	 *
>   	 * NOTE:
>   	 *
>   	 * This function is called in the check phase of an atomic update. The
>   	 * driver is not allowed to change anything outside of the free-standing
> -	 * state objects passed-in or assembled in the overall &drm_atomic_state
> +	 * state objects passed-in or assembled in the overall &drm_atomic_commit
>   	 * update tracking structure.
>   	 *
>   	 * RETURNS:
>   	 *
>   	 * 0 on success, -EINVAL if the state or the transition can't be
>   	 * supported, -ENOMEM on memory allocation failure and -EDEADLK if an
>   	 * attempt to obtain another state object ran into a &drm_modeset_lock
>   	 * deadlock.
>   	 */
>   	int (*atomic_check)(struct drm_connector *connector,
> -			    struct drm_atomic_state *state);
> +			    struct drm_atomic_commit *state);
>   
>   	/**
>   	 * @atomic_commit:
>   	 *
>   	 * This hook is to be used by drivers implementing writeback connectors
> @@ -1101,11 +1101,11 @@ struct drm_connector_helper_funcs {
>   	 * This hook is optional.
>   	 *
>   	 * This callback is used by the atomic modeset helpers.
>   	 */
>   	void (*atomic_commit)(struct drm_connector *connector,
> -			      struct drm_atomic_state *state);
> +			      struct drm_atomic_commit *state);
>   
>   	/**
>   	 * @prepare_writeback_job:
>   	 *
>   	 * As writeback jobs contain a framebuffer, drivers may need to
> @@ -1297,21 +1297,21 @@ struct drm_plane_helper_funcs {
>   	 *
>   	 * NOTE:
>   	 *
>   	 * This function is called in the check phase of an atomic update. The
>   	 * driver is not allowed to change anything outside of the
> -	 * &drm_atomic_state update tracking structure.
> +	 * &drm_atomic_commit update tracking structure.
>   	 *
>   	 * RETURNS:
>   	 *
>   	 * 0 on success, -EINVAL if the state or the transition can't be
>   	 * supported, -ENOMEM on memory allocation failure and -EDEADLK if an
>   	 * attempt to obtain another state object ran into a &drm_modeset_lock
>   	 * deadlock.
>   	 */
>   	int (*atomic_check)(struct drm_plane *plane,
> -			    struct drm_atomic_state *state);
> +			    struct drm_atomic_commit *state);
>   
>   	/**
>   	 * @atomic_update:
>   	 *
>   	 * Drivers should use this function to update the plane state.  This
> @@ -1324,11 +1324,11 @@ struct drm_plane_helper_funcs {
>   	 * the tradeoffs and variants of plane commit helpers.
>   	 *
>   	 * This callback is used by the atomic modeset helpers, but it is optional.
>   	 */
>   	void (*atomic_update)(struct drm_plane *plane,
> -			      struct drm_atomic_state *state);
> +			      struct drm_atomic_commit *state);
>   
>   	/**
>   	 * @atomic_enable:
>   	 *
>   	 * Drivers should use this function to unconditionally enable a plane.
> @@ -1349,11 +1349,11 @@ struct drm_plane_helper_funcs {
>   	 * optional. If implemented, @atomic_enable should be the inverse of
>   	 * @atomic_disable. Drivers that don't want to use either can still
>   	 * implement the complete plane update in @atomic_update.
>   	 */
>   	void (*atomic_enable)(struct drm_plane *plane,
> -			      struct drm_atomic_state *state);
> +			      struct drm_atomic_commit *state);
>   
>   	/**
>   	 * @atomic_disable:
>   	 *
>   	 * Drivers should use this function to unconditionally disable a plane.
> @@ -1374,11 +1374,11 @@ struct drm_plane_helper_funcs {
>   	 *
>   	 * This callback is used by the atomic modeset helpers, but it is
>   	 * optional. It's intended to reverse the effects of @atomic_enable.
>   	 */
>   	void (*atomic_disable)(struct drm_plane *plane,
> -			       struct drm_atomic_state *state);
> +			       struct drm_atomic_commit *state);
>   
>   	/**
>   	 * @atomic_async_check:
>   	 *
>   	 * Drivers should set this function pointer to check if the plane's
> @@ -1398,11 +1398,11 @@ struct drm_plane_helper_funcs {
>   	 *
>   	 * Return 0 on success and any error returned indicates that the update
>   	 * can not be applied in asynchronous manner.
>   	 */
>   	int (*atomic_async_check)(struct drm_plane *plane,
> -				  struct drm_atomic_state *state, bool flip);
> +				  struct drm_atomic_commit *state, bool flip);
>   
>   	/**
>   	 * @atomic_async_update:
>   	 *
>   	 * Drivers should set this function pointer to perform asynchronous
> @@ -1435,11 +1435,11 @@ struct drm_plane_helper_funcs {
>   	 *    vblank, however we let go of the fb references as soon as
>   	 *    we run this hook. For now drivers must implement their own workers
>   	 *    for deferring if needed, until a common solution is created.
>   	 */
>   	void (*atomic_async_update)(struct drm_plane *plane,
> -				    struct drm_atomic_state *state);
> +				    struct drm_atomic_commit *state);
>   
>   	/**
>   	 * @get_scanout_buffer:
>   	 *
>   	 * Get the current scanout buffer, to display a message with drm_panic.
> @@ -1528,11 +1528,11 @@ struct drm_mode_config_helper_funcs {
>   	 * shut off the display pipeline completely.
>   	 *
>   	 * This hook is optional, the default implementation is
>   	 * drm_atomic_helper_commit_tail().
>   	 */
> -	void (*atomic_commit_tail)(struct drm_atomic_state *state);
> +	void (*atomic_commit_tail)(struct drm_atomic_commit *state);
>   
>   	/**
>   	 * @atomic_commit_setup:
>   	 *
>   	 * This hook is used by the default atomic_commit() hook implemented in
> @@ -1549,9 +1549,9 @@ struct drm_mode_config_helper_funcs {
>   	 * Note that the documentation of &drm_private_obj has more details on
>   	 * how one should implement this.
>   	 *
>   	 * This hook is optional.
>   	 */
> -	int (*atomic_commit_setup)(struct drm_atomic_state *state);
> +	int (*atomic_commit_setup)(struct drm_atomic_commit *state);
>   };
>   
>   #endif
> diff --git a/include/drm/drm_plane.h b/include/drm/drm_plane.h
> index 703ef4d1bbbcf084c43aa5e127d28691878061c4..419c88c873a6fde5039c91b415e6532bec57f2bb 100644
> --- a/include/drm/drm_plane.h
> +++ b/include/drm/drm_plane.h
> @@ -257,12 +257,12 @@ struct drm_plane_state {
>   	 *
>   	 * May be NULL.
>   	 */
>   	struct drm_crtc_commit *commit;
>   
> -	/** @state: backpointer to global drm_atomic_state */
> -	struct drm_atomic_state *state;
> +	/** @state: backpointer to global drm_atomic_commit */
> +	struct drm_atomic_commit *state;
>   
>   	/**
>   	 * @color_mgmt_changed: Color management properties have changed. Used
>   	 * by the atomic helpers and drivers to steer the atomic commit control
>   	 * flow.
> @@ -737,11 +737,11 @@ struct drm_plane {
>   	 *
>   	 * Current atomic state for this plane.
>   	 *
>   	 * This is protected by @mutex. Note that nonblocking atomic commits
>   	 * access the current plane state without taking locks. Either by going
> -	 * through the &struct drm_atomic_state pointers, see
> +	 * through the &struct drm_atomic_commit pointers, see
>   	 * for_each_oldnew_plane_in_state(), for_each_old_plane_in_state() and
>   	 * for_each_new_plane_in_state(). Or through careful ordering of atomic
>   	 * commit operations as implemented in the atomic helpers, see
>   	 * &struct drm_crtc_commit.
>   	 */
> diff --git a/include/drm/drm_self_refresh_helper.h b/include/drm/drm_self_refresh_helper.h
> index 520235c20708b5089b623caf9459dfd9351a72c8..95c190125b6044f4c56cbaec4dab353e8ce37f26 100644
> --- a/include/drm/drm_self_refresh_helper.h
> +++ b/include/drm/drm_self_refresh_helper.h
> @@ -6,15 +6,15 @@
>    * Sean Paul <seanpaul@chromium.org>
>    */
>   #ifndef DRM_SELF_REFRESH_HELPER_H_
>   #define DRM_SELF_REFRESH_HELPER_H_
>   
> -struct drm_atomic_state;
> +struct drm_atomic_commit;
>   struct drm_crtc;
>   
> -void drm_self_refresh_helper_alter_state(struct drm_atomic_state *state);
> -void drm_self_refresh_helper_update_avg_times(struct drm_atomic_state *state,
> +void drm_self_refresh_helper_alter_state(struct drm_atomic_commit *state);
> +void drm_self_refresh_helper_update_avg_times(struct drm_atomic_commit *state,
>   					unsigned int commit_time_ms,
>   					unsigned int new_self_refresh_mask);
>   
>   int drm_self_refresh_helper_init(struct drm_crtc *crtc);
>   void drm_self_refresh_helper_cleanup(struct drm_crtc *crtc);
> diff --git a/include/drm/drm_vblank_helper.h b/include/drm/drm_vblank_helper.h
> index fcd8a9b358463865b824d1b9fb79b41580c98363..28051f08d0f42274151fa8e019fb2ba037d3c10e 100644
> --- a/include/drm/drm_vblank_helper.h
> +++ b/include/drm/drm_vblank_helper.h
> @@ -4,23 +4,23 @@
>   #define _DRM_VBLANK_HELPER_H_
>   
>   #include <linux/hrtimer_types.h>
>   #include <linux/types.h>
>   
> -struct drm_atomic_state;
> +struct drm_atomic_commit;
>   struct drm_crtc;
>   
>   /*
>    * VBLANK helpers
>    */
>   
>   void drm_crtc_vblank_atomic_flush(struct drm_crtc *crtc,
> -				  struct drm_atomic_state *state);
> +				  struct drm_atomic_commit *state);
>   void drm_crtc_vblank_atomic_enable(struct drm_crtc *crtc,
> -				   struct drm_atomic_state *state);
> +				   struct drm_atomic_commit *state);
>   void drm_crtc_vblank_atomic_disable(struct drm_crtc *crtc,
> -				    struct drm_atomic_state *crtc_state);
> +				    struct drm_atomic_commit *crtc_state);
>   
>   /**
>    * DRM_CRTC_HELPER_VBLANK_FUNCS - Default implementation for VBLANK helpers
>    *
>    * This macro initializes struct &drm_crtc_helper_funcs to default helpers
>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG Nürnberg)


