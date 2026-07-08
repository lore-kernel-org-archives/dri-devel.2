Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 195A7C43602
	for <dri-devel@archiver.kernel.org>; Wed,  8 Jul 2026 12:42:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 18F2810F115;
	Wed,  8 Jul 2026 12:42:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="dUEBh06f";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="liIbm3A1";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="UK6WQbby";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Kz3KMMhw";
	dkim-atps=neutral
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A3D1610F073
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Jul 2026 12:42:19 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0871876077;
 Wed,  8 Jul 2026 12:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1783514538; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=X5dzTTCatZZvkmE8q15IV7Lpko/hPbN5TdQoKiurduA=;
 b=dUEBh06fNWTd2m8I8EOJluGoLByyD9XOlJ3przweVPZbhz6VZ7S1zsjn7DFg7zULfjPWm2
 QnUpa1SkvgpZNH8hINzV8CAg1WtIfcJ1K0UzREvU38I4qdLzy/5uxYICxq1/MxFMLt48u7
 cd3RpJS8rOX114IaN/X9ePsGlBoy+9U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1783514538;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=X5dzTTCatZZvkmE8q15IV7Lpko/hPbN5TdQoKiurduA=;
 b=liIbm3A1PHJAFrQqgluRDTsuHQKsA2UoHIJFH7AOynoG8lo5e9afqxGlIUN3trUGQ0IuTo
 0/NfJkRIeI7DY6AQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=UK6WQbby;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Kz3KMMhw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1783514537; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=X5dzTTCatZZvkmE8q15IV7Lpko/hPbN5TdQoKiurduA=;
 b=UK6WQbby0uEoeFln5BDlhQtliE8Q+fOlMQaTPyWNztP1ofk9W69/pu9fLxccGUy43ajOcY
 sFExOrJ7vDTzkIXuhRFtmdEVPT0e0E70KiR4kZ6gA9uXvWtg5nI8Ag9nSKiW97SUuXd9DE
 y5QBxIf27c42uswsjGAUK9oMjo2v2I4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1783514537;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=X5dzTTCatZZvkmE8q15IV7Lpko/hPbN5TdQoKiurduA=;
 b=Kz3KMMhwjoyhH/AzT1OYB8kEQJge7Pt0/4KgWomD22Kc2swil+/M3DLVAh4str1zTv5f0F
 9UNXwy3W8vz0V9BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 79341779AE;
 Wed,  8 Jul 2026 12:42:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id m8AlHKhFTmqiFgAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Wed, 08 Jul 2026 12:42:16 +0000
Message-ID: <3abfae37-770c-49bf-ba1c-98bd6b0b52bc@suse.de>
Date: Wed, 8 Jul 2026 14:42:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/9] drm: replace simple display pipe users with atomic
 helpers
To: Ze Huang <ze.huang@oss.qualcomm.com>,
 Alexey Brodkin <abrodkin@synopsys.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Joel Stanley <joel@jms.id.au>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Frank Li <Frank.Li@nxp.com>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Linus Walleij <linusw@kernel.org>,
 Hans de Goede <hansg@kernel.org>, Alex Lanzano <lanzano.alex@gmail.com>,
 Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-aspeed@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 imx@lists.linux.dev, xen-devel@lists.xenproject.org
References: <20260705-drm-simple-kms-removal-v1-0-b4e1ca053623@oss.qualcomm.com>
 <9612bb41-db52-4169-a7fa-e57268d69e24@suse.de>
 <DJRCCWQOT4TA.1OPAZI88KOWLW@oss.qualcomm.com>
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
In-Reply-To: <DJRCCWQOT4TA.1OPAZI88KOWLW@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 0871876077
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCPT_COUNT_TWELVE(0.00)[22];
 FREEMAIL_TO(0.00)[oss.qualcomm.com,synopsys.com,linux.intel.com,kernel.org,gmail.com,ffwll.ch,jms.id.au,codeconstruct.com.au,nxp.com,pengutronix.de,epam.com];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TAGGED_RCPT(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:url, imap1.dmz-prg2.suse.org:rdns,
 imap1.dmz-prg2.suse.org:helo, suse.de:mid, suse.de:dkim]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
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

Am 06.07.26 um 10:22 schrieb Ze Huang:
> On Mon Jul 6, 2026 at 3:27 PM CST, Thomas Zimmermann wrote:
>> Hi
>>
>> Am 04.07.26 um 20:31 schrieb Ze Huang:
>>> struct drm_simple_display_pipe was meant to simplify simple DRM
>>> drivers, but instead adds an extra wrapper around normal DRM atomic
>>> helper setup. As noted in Documentation/gpu/todo.rst, remaining users
>>> should be converted to regular atomic helpers and stop depending on the
>>> simple-KMS interfaces.
>>>
>>> This series converts the following drivers:
>>>
>>>     - arcpgu
>>>     - aspeed
>>>     - imx lcdc
>>>     - mcde
>>>     - pl111
>>>     - gm12u320
>>>     - repaper
>>>     - tve200
>>>     - xen frontend
>>>
>>> Each patch replaces drm_simple_display_pipe_init() with explicit
>>> primary plane, CRTC and encoder setup, and moves the old simple-pipe
>>> callbacks into regular plane and CRTC helper callbacks named according
>>> to local driver conventions.
>>>
>>> The conversions preserve helper behavior that used to be implicit in
>>> drm_simple_kms_helper.c, including plane-state validation, CRTC
>>> primary-plane checks, affected-plane propagation, framebuffer prepare
>>> handling, and existing event/vblank flow where applicable.
>>>
>>> Result is less helper indirection and more explicit driver-side atomic
>>> wiring, with no remaining simple-KMS dependency in these drivers.
>>>
>>> These changes are build-tested only. No hardware testing has been
>>> performed on the affected devices.
>> Thanks a lot for the series. That's quite a nice cleanup.  Did you use
>> any AI to create these patches?
>>
> Hi Thomas,
>
> Yes, I did. I wrote the first two conversion patches (arcpgu and
> aspeed) myself to understand the migration pattern. For the remaining
> drivers, I used GPT-5.5 to help with the repetitive boilerplate
> conversion.
>
> I should have reviewed the generated code more carefully before sending
> the series. The sashiko-bot feedback shows that I missed several important
> details, including commit-local state handling, the implicit NULL fb /
> visibility checks from simple-KMS, and vblank/pageflip event ordering.
> I am now going through these issues more carefully and working out the
> correct fixes before sending a v2.

Great, thanks.

The drivers you've picked are somewhat under-maintained, but I'll take a 
look at your submissions.


>
> Do you expect AI assistance to be mentioned in the cover letter or commit
> messages in some specific form? If there is a preferred tag or wording
> for this, I will use it in v2.

See Documentation/process/coding-assistents.rst for how to mark AI-made 
patches.  Although not everyone agrees that it's a good idea.  IMHO you 
should mention AI usage in the cover letter.


>
> For issues that appear to be pre-existing but are exposed or carried over
> by the migration, which is better?

It's probably better to not bother about pre-existing issues for now.  
Those are a rabbit hole.  If you're looking for follow-up patches to do. 
You're welcome to address them.


>
> 1. Include them as separate prep/fix patches at the beginning of the v2
> series, before the corresponding conversion patches; or
> 2. address those pre-existing issues in a separate follow-up series?
>
> Thanks for your time and review. :)
>
>> Best regards
>> Thomas
>>
> Best regards,
> Ze

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, (HRB 36809, AG Nürnberg)


