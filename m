Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54893C43458
	for <dri-devel@archiver.kernel.org>; Wed,  8 Jul 2026 12:01:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A838D10E5BC;
	Wed,  8 Jul 2026 12:01:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="Q5D9mVHU";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="OqsWgIzR";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="MHVYe74O";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="3kIGPJOs";
	dkim-atps=neutral
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 596E010E5BC
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Jul 2026 12:01:44 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 91D5475D25;
 Wed,  8 Jul 2026 12:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1783512102; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=T9HPZH/sFZBprfRI2Wkxp5t+drj5WDOxKZsX+YGwpA0=;
 b=Q5D9mVHUsIVHYm6Wae8J+TWKr1rgA4ferRPy8uKOHpVwhbqhR8BAtIoJBevTVRBWDrBFIK
 fqv0h9EUSBeQyHGZaE9Dn9tx7dIWLW0ndvjCEjSrP/yqpOXHEvuPNwvL1p2gxZ+Y2YOk+x
 lzswJWfJ9VSG1SqA76zp8zu5l2iMeBs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1783512102;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=T9HPZH/sFZBprfRI2Wkxp5t+drj5WDOxKZsX+YGwpA0=;
 b=OqsWgIzR08V0WJPVfyemMFPRE1VR7o2531XTg3UXzDjXyuNGQR6VzXXcrUjHhu95eMlRzc
 +pbuEhIUEVouqRAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1783512101; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=T9HPZH/sFZBprfRI2Wkxp5t+drj5WDOxKZsX+YGwpA0=;
 b=MHVYe74O9BMGXIIqWIEOaCW2pRvN/so26ftcHCXDkPSANoTe+nph2QlUbOIRpkfKJvhWNw
 S1oH0UOKUKtGGQHQyBK0m04T0vYRr64PIFef26kqrm44enOaa0T+091I4xrIRMEIiEv2QC
 BLrhl9rpLmwcU/z9lTy/MKINz3E5ROs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1783512101;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=T9HPZH/sFZBprfRI2Wkxp5t+drj5WDOxKZsX+YGwpA0=;
 b=3kIGPJOsxuoTStjCJR921kjLCDgUqXzaJvSLtNRnQM9DLeuZd9gQ5OoTY9c1SpJHiL+R7v
 vtwO6TX+miKh2RDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 07F40779AE;
 Wed,  8 Jul 2026 12:01:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id iOV/ACU8Tmo6bQAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Wed, 08 Jul 2026 12:01:41 +0000
Message-ID: <54bc305f-4ebb-42b3-b3aa-63b84af5165d@suse.de>
Date: Wed, 8 Jul 2026 14:01:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/3] drm/panel,of,sysfb: Use OF panel-orientation
 helper in simpledrm
To: treding@nvidia.com, javierm@redhat.com, neil.armstrong@linaro.org,
 jesszhan0024@gmail.com, dianders@chromium.org, megi@xff.cz,
 igor@reznichenko.net, mwalle@kernel.org,
 dario.binacchi@amarulasolutions.com, jagan@edgeble.ai,
 laurent.pinchart@ideasonboard.com, lujianhua000@gmail.com, agx@sigxcpu.org,
 kernel@puri.sm, mripard@kernel.org, maarten.lankhorst@linux.intel.com,
 airlied@gmail.com, simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, sashiko-reviews@lists.linux.dev
References: <20260701121055.192475-1-tzimmermann@suse.de>
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
In-Reply-To: <20260701121055.192475-1-tzimmermann@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 FREEMAIL_TO(0.00)[nvidia.com,redhat.com,linaro.org,gmail.com,chromium.org,xff.cz,reznichenko.net,kernel.org,amarulasolutions.com,edgeble.ai,ideasonboard.com,sigxcpu.org,puri.sm,linux.intel.com,ffwll.ch];
 MID_RHS_MATCH_FROM(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_TWELVE(0.00)[20];
 RCVD_TLS_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.com:url,
 suse.de:mid]
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

Merged into drm-misc-next now.

Due to bit rot, I had to adapt panel-renesas-r63419.c to the new 
interface. No functional changes there.

Am 01.07.26 um 14:03 schrieb Thomas Zimmermann:
> Improve support for panel orientation in simpledrm. There's a rotation
> property in the DT panel node. Read the value and set the connector's
> orientation property accordingly.
>
> Patch 1 moves the existing code for parsing the rotation to drm_of.c.
> This makes it available to simpledrm without introducing a dependency on
> DRM_PANEL.
>
> Patch 2 updates simpledrm and patch 3 updates all DRM panel drivers to
> use the new helper function.
>
> These patches have previously been part of another series that improved
> simpledrm in general. So we start with v4 instead of v1. Keep existing
> R-b tags.
>
> v4:
> - integrate Thierry's panel-update patch
> - update anbernic, chipone, ili9488 panels that were merged recently
> v3:
> - see https://lore.kernel.org/dri-devel/20260625094509.157581-1-tzimmermann@suse.de/
>
> Thierry Reding (1):
>    drm/panel: Use drm_of_get_panel_orientation()
>
> Thomas Zimmermann (2):
>    drm/of: Implement drm_of_get_panel_orientation()
>    drm/sysfb: simpledrm: Read panel orientation from DT node
>
>   drivers/gpu/drm/drm_of.c                      | 44 +++++++++++++++++++
>   drivers/gpu/drm/drm_panel.c                   | 44 +------------------
>   drivers/gpu/drm/panel/panel-anbernic-td4310.c |  3 +-
>   .../drm/panel/panel-boe-th101mb31ig002-28a.c  |  3 +-
>   .../gpu/drm/panel/panel-boe-tv101wum-nl6.c    |  3 +-
>   .../gpu/drm/panel/panel-chipone-icna35xx.c    |  3 +-
>   .../gpu/drm/panel/panel-chipwealth-ch13726a.c |  3 +-
>   drivers/gpu/drm/panel/panel-edp.c             |  3 +-
>   drivers/gpu/drm/panel/panel-elida-kd35t133.c  |  3 +-
>   .../gpu/drm/panel/panel-focaltech-ota7290b.c  |  3 +-
>   drivers/gpu/drm/panel/panel-himax-hx83102.c   |  3 +-
>   drivers/gpu/drm/panel/panel-himax-hx8394.c    |  3 +-
>   drivers/gpu/drm/panel/panel-ilitek-ili9488.c  |  3 +-
>   .../gpu/drm/panel/panel-ilitek-ili9806e-dsi.c |  3 +-
>   drivers/gpu/drm/panel/panel-ilitek-ili9881c.c |  3 +-
>   drivers/gpu/drm/panel/panel-ilitek-ili9882t.c |  3 +-
>   .../gpu/drm/panel/panel-jadard-jd9365da-h3.c  |  2 +-
>   drivers/gpu/drm/panel/panel-lvds.c            |  2 +-
>   drivers/gpu/drm/panel/panel-novatek-nt36523.c |  3 +-
>   drivers/gpu/drm/panel/panel-simple.c          |  2 +-
>   drivers/gpu/drm/panel/panel-sitronix-st7701.c |  3 +-
>   drivers/gpu/drm/panel/panel-sitronix-st7703.c |  3 +-
>   .../gpu/drm/panel/panel-sitronix-st7789v.c    |  3 +-
>   drivers/gpu/drm/sysfb/simpledrm.c             | 11 ++++-
>   include/drm/drm_of.h                          | 11 +++++
>   include/drm/drm_panel.h                       |  8 ----
>   26 files changed, 104 insertions(+), 74 deletions(-)
>
>
> base-commit: a2d82f27ac35c691c1c65b40c72b13d8b2a7f91f

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, (HRB 36809, AG Nürnberg)


