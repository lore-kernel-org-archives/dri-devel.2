Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CF57CD3436
	for <dri-devel@archiver.kernel.org>; Fri,  8 May 2026 06:34:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 27B8C10F342;
	Fri,  8 May 2026 06:34:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="yYuVes5k";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="F7jUEJpE";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="yYuVes5k";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="F7jUEJpE";
	dkim-atps=neutral
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6ACAB10F333
 for <dri-devel@lists.freedesktop.org>; Fri,  8 May 2026 06:34:12 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 128F65CC5E;
 Fri,  8 May 2026 06:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1778222051; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=zOsbIhlef44DTkGsoPWXHPBsl57WqM4Qt7XMbvRnzco=;
 b=yYuVes5kv4DMvt3PJUErhS4U2VMDuUxxPLdFXfP75wMvWW3kXNBfnXBY0R+K+zFiYHlDDj
 ScvCwui197BX8Sk5v81tWiuAo51Nqd5naCidAspjL1fOU7ZljO0sYx+oyioQv2tVu/u6Oq
 9E6Gc8lQP59DPttFSxkqQVVFj1NxRkM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1778222051;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=zOsbIhlef44DTkGsoPWXHPBsl57WqM4Qt7XMbvRnzco=;
 b=F7jUEJpEyQ6BHpqMBcGzBWQJCIrg8ZO8/W7GwcjyEV/IqkjSfesuR8zxePBHZltEjRF9FZ
 87lErDJPT+SpPtBg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=yYuVes5k;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=F7jUEJpE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1778222051; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=zOsbIhlef44DTkGsoPWXHPBsl57WqM4Qt7XMbvRnzco=;
 b=yYuVes5kv4DMvt3PJUErhS4U2VMDuUxxPLdFXfP75wMvWW3kXNBfnXBY0R+K+zFiYHlDDj
 ScvCwui197BX8Sk5v81tWiuAo51Nqd5naCidAspjL1fOU7ZljO0sYx+oyioQv2tVu/u6Oq
 9E6Gc8lQP59DPttFSxkqQVVFj1NxRkM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1778222051;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=zOsbIhlef44DTkGsoPWXHPBsl57WqM4Qt7XMbvRnzco=;
 b=F7jUEJpEyQ6BHpqMBcGzBWQJCIrg8ZO8/W7GwcjyEV/IqkjSfesuR8zxePBHZltEjRF9FZ
 87lErDJPT+SpPtBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C9930593A7;
 Fri,  8 May 2026 06:34:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id diPkL+KD/WkCZAAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Fri, 08 May 2026 06:34:10 +0000
Message-ID: <87ca272f-d202-4c08-b289-67fc953cde25@suse.de>
Date: Fri, 8 May 2026 08:34:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] drm/exynos: fbdev: Use client buffers
To: Marek Szyprowski <m.szyprowski@samsung.com>, inki.dae@samsung.com,
 sw0312.kim@samsung.com, kyungmin.park@samsung.com, airlied@gmail.com,
 simona@ffwll.ch, dri-devel@lists.freedesktop.org
Cc: linux-samsung-soc@vger.kernel.org
References: <CGME20260423095139eucas1p149a0e97f62e8bf353a65466ca26cbff9@eucas1p1.samsung.com>
 <20260423094452.32665-1-tzimmermann@suse.de>
 <b9765ddd-bb8a-458f-85d4-159d3cc5fe5b@samsung.com>
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
In-Reply-To: <b9765ddd-bb8a-458f-85d4-159d3cc5fe5b@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 DWL_DNSWL_LOW(-1.00)[suse.de:dkim];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 FREEMAIL_TO(0.00)[samsung.com,gmail.com,ffwll.ch,lists.freedesktop.org];
 RCPT_COUNT_SEVEN(0.00)[8]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:url,suse.de:mid,suse.de:dkim];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 128F65CC5E
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

Am 06.05.26 um 08:35 schrieb Marek Szyprowski:
> On 23.04.2026 11:37, Thomas Zimmermann wrote:
>> A client buffer holds the DRM framebuffer for an in-kernel DRM
>> client. Until now, exynos created an internal ad-hoc framebuffer for
>> its fbdev emulation, while by-passing the regular interfaces used by
>> user-space compositors.
>>
>> Convert exynos' fbdev emulation to use client buffers. Replacing the
>> existing code with a client buffer allows for stream-lining exynos code
>> and later also the fbdev helpers. The new framebuffer will be registered
>> against the client's file and will support handles for GEM objects. It
>> is then just another framebuffer within the DRM ecosystem.
>>
>> If all driver's fbdev-emulation helpers can be converted to use client
>> buffers, the emulation's framebuffer handling as a whole can possibly be
>> moved into shared helpers.
> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
>
> Acked-by: Marek Szyprowski <m.szyprowski@samsung.com>

Thanks a lot!

>
>
>> Patch 1 first fixes a long-standing bug.
>>
>> Patches 2 to 4 convert exynos' fbdev emulation to client buffers. It
>> still allocates a GEM object buffer tailored towards fbdev emulation,
>> but size calculations now use common DRM helpers.
>>
>> Patch 5 cleans up symbol visibility in exynos' fb code.
>>
>> Thomas Zimmermann (5):
>>    drm/exynos: fbdev: Remove offset into screen_buffer
>>    drm/exynos: fbdev: Inline exynos_drm_fbdev_update()
>>    drm/exynos: fbdev: Calculate buffer geometry with format helpers
>>    drm/exynos: fbdev: Use a DRM client buffer
>>    drm/exynos: Make exynos_drm_framebuffer_init() an internal interface
>>
>>   drivers/gpu/drm/exynos/exynos_drm_fb.c    |   2 +-
>>   drivers/gpu/drm/exynos/exynos_drm_fb.h    |   7 --
>>   drivers/gpu/drm/exynos/exynos_drm_fbdev.c | 100 ++++++++++------------
>>   3 files changed, 47 insertions(+), 62 deletions(-)
>>
> Best regards

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG Nürnberg)


