Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9E4FC624DE
	for <dri-devel@archiver.kernel.org>; Fri,  4 Sep 2026 09:10:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D799510F9BA;
	Fri,  4 Sep 2026 09:10:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="gKWahthA";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="guXWm3mU";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="dc5WYa2w";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="NSgxGS7M";
	dkim-atps=neutral
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C33A310F9BA
 for <dri-devel@lists.freedesktop.org>; Fri,  4 Sep 2026 09:10:56 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 160C322BDC;
 Fri,  4 Sep 2026 09:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788513051; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=S6jsTYpICTUf4u4QyZalLiQN/qK381mHNqNvyPemu3I=;
 b=gKWahthAe16LZQthoIJzc6yMzwOkvQioLYwTFuZIyetOP0HfhcI8Ds5MHyy13oaKp1aoJ5
 yYcHrh1qjr8b8xto7v4hiLuZBEakIcLI8txhJaREeuuhtPo6U3GWMENFUqX1aCWkNlFGed
 Suwie64h6zIPeLitsW2mjgqIwteTrEo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788513051;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=S6jsTYpICTUf4u4QyZalLiQN/qK381mHNqNvyPemu3I=;
 b=guXWm3mUQrItdrsnxQqpyEpWbYMjPXv/zAmiOTAme+RTYCaWjSX2HuJf7Ie0ZbNupddnEF
 gPlux1FAdntSSNBA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=dc5WYa2w;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=NSgxGS7M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788513047; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=S6jsTYpICTUf4u4QyZalLiQN/qK381mHNqNvyPemu3I=;
 b=dc5WYa2wF4aDRVxwgoEPxxPSr951QvaeJwOWNnXacoE3DLPk9IXncA83IAHB7YwSXrVEbA
 8PIesOVJNBQSMkXLS4Gwk6Nvb3FkM47eFZNnsa794NWNe71TQwNbtEgiv6KVnI63UTEdhb
 8jZGr+QSvQuh5qKW0n7T1Mc27ggLUE4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788513047;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=S6jsTYpICTUf4u4QyZalLiQN/qK381mHNqNvyPemu3I=;
 b=NSgxGS7MJTUpgiBocjQPgLbMIOyIKcg73BVrSkKZBhgTcuy5Y8Ihv+BWcAKZniYxKP33eL
 TYtZGPRW8qnfT7CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AF4B113738;
 Fri,  4 Sep 2026 09:10:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id hd5pKRWLmmqRdwAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Fri, 04 Sep 2026 09:10:45 +0000
Message-ID: <bccaf050-baee-4c16-97c4-1751ef3ecdb7@suse.de>
Date: Fri, 4 Sep 2026 11:10:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 3/5] drm/sysfb: Update coreboot framebuffer Kconfig
 symbol
To: Sean Rhodes <sean@starlabs.systems>, linux-kernel@vger.kernel.org
Cc: Hans de Goede <hansg@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Corentin Chary <corentin.chary@gmail.com>, "Luke D. Jones"
 <luke@ljones.dev>, Denis Benato <denis.benato@linux.dev>,
 Prasanth Ksr <prasanth.ksr@dell.com>, Jorge Lopez <jorge.lopez2@hp.com>,
 Mark Pearson <mpearson-lenovo@squebb.ca>,
 "Derek J. Clark" <derekjohn.clark@gmail.com>,
 Joshua Grisham <josh@joshuagrisham.com>, Will Deacon <will@kernel.org>,
 Douglas Anderson <dianders@chromium.org>,
 "Kiryl Shutsemau (Meta)" <kas@kernel.org>,
 Huacai Chen <chenhuacai@kernel.org>, Chen-Yu Tsai <wenst@chromium.org>,
 platform-driver-x86@vger.kernel.org, Dell.Client.Kernel@dell.com,
 Tzung-Bi Shih <tzungbi@kernel.org>, Brian Norris <briannorris@chromium.org>,
 Julius Werner <jwerner@chromium.org>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Danilo Krummrich <dakr@kernel.org>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig_=28The_Capable_Hub=29?=
 <u.kleine-koenig@baylibre.com>,
 Titouan Ameline de Cadeville <titouan.ameline@gmail.com>,
 Laxman Acharya Padhya <acharyalaxman8848@gmail.com>,
 Yidi Lin <yidilin@google.com>, Kees Cook <kees@kernel.org>,
 Takashi Sakamoto <o-takashi@sakamocchi.jp>, chrome-platform@lists.linux.dev,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Arnd Bergmann <arnd@arndb.de>,
 Eric Biggers <ebiggers@kernel.org>, Luca Weiss <luca.weiss@fairphone.com>,
 Michal Simek <michal.simek@amd.com>, Sven Peter <sven@kernel.org>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Linus Walleij <linusw@kernel.org>, Drew Fustini <fustini@kernel.org>,
 linux-arm-kernel@lists.infradead.org, soc@lists.linux.dev
References: <cover.1788284852.git.sean@starlabs.systems>
 <1748b8899ec772cc435dc57dc55f76c15da95f0a.1788284852.git.sean@starlabs.systems>
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
In-Reply-To: <1748b8899ec772cc435dc57dc55f76c15da95f0a.1788284852.git.sean@starlabs.systems>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 160C322BDC
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 FREEMAIL_CC(0.00)[kernel.org,linux.intel.com,gmail.com,ljones.dev,linux.dev,dell.com,hp.com,squebb.ca,joshuagrisham.com,chromium.org,vger.kernel.org,redhat.com,google.com,baylibre.com,sakamocchi.jp,lists.linux.dev,ffwll.ch,lists.freedesktop.org,oss.qualcomm.com,linux-m68k.org,arndb.de,fairphone.com,amd.com,bootlin.com,lists.infradead.org];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+];
 R_RATELIMIT(0.00)[to_ip_from(RL6ryso6x4fcxrmhyqqhqmnwey)];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_MATCH_ENVRCPT_SOME(0.00)[]; RCPT_COUNT_GT_50(0.00)[51];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TAGGED_RCPT(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim, suse.de:email, suse.de:mid,
 imap1.dmz-prg2.suse.org:helo, imap1.dmz-prg2.suse.org:rdns, suse.com:url]
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



Am 01.09.26 um 19:48 schrieb Sean Rhodes:
> The coreboot firmware directory rename introduces COREBOOT_FRAMEBUFFER as
> the user-facing symbol while retaining GOOGLE_FRAMEBUFFER_COREBOOT as a
> transitional compatibility symbol.
>
> Make DRM_COREBOOTDRM depend on the new symbol. This keeps the DRM
> dependency aligned with the renamed firmware option without changing
> runtime behavior.
>
> Signed-off-by: Sean Rhodes <sean@starlabs.systems>

Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>

> ---
>   drivers/gpu/drm/sysfb/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/sysfb/Kconfig b/drivers/gpu/drm/sysfb/Kconfig
> index f7e48178885e..2bfcd59bfe6d 100644
> --- a/drivers/gpu/drm/sysfb/Kconfig
> +++ b/drivers/gpu/drm/sysfb/Kconfig
> @@ -10,7 +10,7 @@ config DRM_SYSFB_HELPER
>   config DRM_COREBOOTDRM
>   	tristate "Coreboot framebuffer driver"
>   	depends on DRM && MMU
> -	depends on GOOGLE_FRAMEBUFFER_COREBOOT
> +	depends on COREBOOT_FRAMEBUFFER
>   	select APERTURE_HELPERS
>   	select DRM_CLIENT_SELECTION
>   	select DRM_GEM_SHMEM_HELPER

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, (HRB 36809, AG Nürnberg)


