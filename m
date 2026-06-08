Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6B0BCD8C9D
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 15:32:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B58410F5F2;
	Mon,  8 Jun 2026 15:32:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="i1XMuUyM";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ZXjXdDas";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="uvRw5qMQ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="fv2zgPyj";
	dkim-atps=neutral
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5212F10F5F2
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 15:32:19 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7736A6AABF;
 Mon,  8 Jun 2026 15:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1780932737; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=wB4daXEjEltgdYoO/xkBKxbeEzUsqocZbuQWiZKjTkw=;
 b=i1XMuUyMowhgqtYQ1L+6heuu2SpzLS6CwdTFQ2VQ/3J0NX1v0zQ6SQYWc8Bamsl3hEspoC
 A1NEAvIoon+dfh/5TWugH+M6xMOkmkFiK0bVv54d7C6ixNFr3GSp57TNj0bRBQNpnvp47f
 KNg8So8fenLu1armRuKL0GOrfPhyB0Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1780932737;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=wB4daXEjEltgdYoO/xkBKxbeEzUsqocZbuQWiZKjTkw=;
 b=ZXjXdDashzq5+cf5iMZzPLiIblyCHjoQPFbqOCGcXUw1+yEd5pkfyd4CM6sV1PNTlqSpbb
 vZMEvzCnE2dVAZCQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=uvRw5qMQ;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=fv2zgPyj
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1780932736; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=wB4daXEjEltgdYoO/xkBKxbeEzUsqocZbuQWiZKjTkw=;
 b=uvRw5qMQo44jKdz+UZDr4FHzUUC7GU7YOlso18jAkqzXs4vu1QbtiQSY1+jaLfFBfhXtbY
 G64WpEGzzUuyU/3xYMF3K9mh2ph+WkmLxA4My7vkLZ9WToulO9FE2oRj6JDPMDs9r9w3nA
 atf47e02vj7mdviCg8nYpS8c2QlGvpI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1780932736;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=wB4daXEjEltgdYoO/xkBKxbeEzUsqocZbuQWiZKjTkw=;
 b=fv2zgPyjTrgGWqJIx9mwKAtxgaQcUtaVmwKt3lupUDRR4GP6diRnZwMtf+vhxRghvkDfNa
 YBN/j0R/rERcLOAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5A614779A7;
 Mon,  8 Jun 2026 15:32:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id /9zsFIDgJmqSfQAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Mon, 08 Jun 2026 15:32:16 +0000
Message-ID: <316cb710-536a-4d9b-9cd9-f8ed9315660d@suse.de>
Date: Mon, 8 Jun 2026 17:32:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: No display initialisation when using DRM_CLIENT_LOG instead of
 DRM_FBDEV_EMULATION
To: Guilherme Bember Duarte <guilhermebemberduarte@gmail.com>,
 Jocelyn Falempe <jfalempe@redhat.com>,
 dri-devel <dri-devel@lists.freedesktop.org>
References: <82F211E7-560D-473D-8C1E-061AE85ADBD6@gmail.com>
 <f5cd4747-f19c-405d-aa24-3055531f03c0@suse.de>
 <DBAFACDB-9149-483A-8F98-B74F9E0C2C44@gmail.com>
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
In-Reply-To: <DBAFACDB-9149-483A-8F98-B74F9E0C2C44@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_ALL(0.00)[];
 FREEMAIL_TO(0.00)[gmail.com,redhat.com,lists.freedesktop.org];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_THREE(0.00)[3];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns, suse.de:email, suse.de:dkim, suse.de:mid,
 suse.com:url]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 7736A6AABF
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

(cc Jocelyn, dri-devel)

Am 08.06.26 um 17:30 schrieb Guilherme Bember Duarte:
> I don't know what exactly happened but the update to 7.0.11 might have 
> something to do with it (or possibly some stupid mistake on my part).
>
> Now I can switch to other TTYs where kmscon spawns fine (before that 
> there's still no display initialisation, verifiable by checking 
> "/sys/class/drm/card0-*/status", all return unknown), but with or 
> without that boot argument, TTY 1 stays dead instead of the usual logger.
>
> Switching to TTY 1 again makes the screen hang until i switch back and 
> on boot I get no signal on the display until I switch over to another TTY.
>
>
> On 8 June 2026 07:52:59 GMT-03:00, Thomas Zimmermann 
> <tzimmermann@suse.de> wrote:
>
>     Hi, Am 06.06.26 um 16:49 schrieb Guilherme Bember Duarte:
>
>         Hi! I replaced DRM_FBDEV_EMULATION with DRM_CLIENT_LOG
>         (DRM_CLIENT_DEFAULT="log") on a kernel with DRM_PANIC enabled,
>         using kmscon as the userspace terminal. Nothing initialises
>         the display after the native driver loads. The result is a
>         blank screen, no output at all from boot. DRM_CLIENT_LOG (boot
>         logs don't show up at all) and DRM_PANIC (forced a panic to
>         try this out) also don't work, since neither can render
>         without an initialised display. This can be verified by
>         checking "/sys/class/drm/card0-*/status" (all outputs show
>         "unknown") and "/sys/class/drm/card0-*/modes" (empty) after
>         boot. Writing "detect" to
>         "/sys/class/drm/card0-HDMI-A-1/status" (or any output for that
>         matter) resolves the issue, the connector is probed, modes are
>         populated, and kmscon can be started correctly. This suggests
>         DRM_FBDEV_EMULATION previously triggered some display
>         initialisation/probing during boot that is not happening with
>         DRM_CLIENT_LOG. I can't say if SIMPLEDRM (and SIMPLEFB) are
>         affected, the result in my system is a immediate blank screen
>         and no signal, I don't know if its because the main graphics
>         driver initialise very quickly during boot or if SIMPLEDRM is
>         also affected. 
>
>     Did you boot with "console=drm_log" at the kernel command line?
>     Best regards Thomas
>
>         Hardware: AMD RX 6600 XT (Navi23/AMDGPU), although I believe
>         this affects any driver. Kernel version: 7.0.11-gentoo Config
>         diff: 2849a2850
>
>             # CONFIG_VGA_SWITCHEROO is not set 
>
>         2874,2879c2875,2878 < CONFIG_DRM_FBDEV_EMULATION=y <
>         CONFIG_DRM_FBDEV_OVERALLOC=100 < #
>         CONFIG_DRM_FBDEV_LEAK_PHYS_SMEM is not set < #
>         CONFIG_DRM_CLIENT_LOG is not set <
>         CONFIG_DRM_CLIENT_DEFAULT_FBDEV=y <
>         CONFIG_DRM_CLIENT_DEFAULT="fbdev"
>         ------------------------------------------------------------------------
>
>             # CONFIG_DRM_FBDEV_EMULATION is not set
>             CONFIG_DRM_CLIENT_LOG=y CONFIG_DRM_CLIENT_DEFAULT_LOG=y
>             CONFIG_DRM_CLIENT_DEFAULT="log" 
>
>         2978,2986d2976 < CONFIG_FB_CORE=y < # CONFIG_FB_DEVICE is not
>         set < CONFIG_FB_SYS_FILLRECT=y < CONFIG_FB_SYS_COPYAREA=y <
>         CONFIG_FB_SYS_IMAGEBLIT=y < CONFIG_FB_SYSMEM_FOPS=y <
>         CONFIG_FB_DEFERRED_IO=y < CONFIG_FB_SYSMEM_HELPERS=y <
>         CONFIG_FB_SYSMEM_HELPERS_DEFERRED=y 3021,3024d3010 <
>         CONFIG_FRAMEBUFFER_CONSOLE=y < #
>         CONFIG_FRAMEBUFFER_CONSOLE_LEGACY_ACCELERATION is not set <
>         CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=y < #
>         CONFIG_FRAMEBUFFER_CONSOLE_ROTATION is not set 3027d3012 < #
>         CONFIG_LOGO is not set 4473d4457 < # CONFIG_FONT_SUN8x16 is
>         not set Guilherme B. 
>
> Guilherme B.

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG Nürnberg)


