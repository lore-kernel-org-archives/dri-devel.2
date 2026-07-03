Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74943C43602
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 10:32:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D34ED10F78D;
	Fri,  3 Jul 2026 10:32:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="mEdXyLVA";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="l3yLMyzp";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="CiQyNNsR";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="O9+jyFjE";
	dkim-atps=neutral
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2CC8C10F78D
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 10:32:21 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C7D647483D;
 Fri,  3 Jul 2026 10:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1783074739; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=7+hBpqLHi6nac5VzhOiU+9zXG7wkQ+XGobxxoJZ3SSg=;
 b=mEdXyLVATFwrCM9PK20+8735aF8/95V5YiWgyTyaD89Ii9eDozPbDShNtcE6HRpX/oVar7
 drjuVyOQaiA++qTuFXs5Sk50XgHOzTgNwPAIE0Kcc1mifGbveKlptTGGaFVFi3ct4g2Y2t
 QYcdRra8lLYeMfbWjTW6N/wxStlD5lA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1783074739;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=7+hBpqLHi6nac5VzhOiU+9zXG7wkQ+XGobxxoJZ3SSg=;
 b=l3yLMyzp8h175fohB0AIKHDKK1+EWmJzrZXlKEiNOACsfsowU4RRox4WOAvlWsU7nkzDdi
 Fpxu7gAUTepcnLBA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=CiQyNNsR;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=O9+jyFjE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1783074738; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=7+hBpqLHi6nac5VzhOiU+9zXG7wkQ+XGobxxoJZ3SSg=;
 b=CiQyNNsRvc/eSDXb72xBlRcZ/+k6k2o+/ClVMAHRDpFNSHPs9OCQybM77vQzLy3LShk8x1
 ZnebnUyiX9JXa2cy+XZ8ZecShHLN3F2pu/BMGg0sNPuBk8nFhLtgcU+AaP/Gg8PzKnIZvj
 WoDpeUlgfwquI+knBsRlG0pb13rBISE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1783074738;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=7+hBpqLHi6nac5VzhOiU+9zXG7wkQ+XGobxxoJZ3SSg=;
 b=O9+jyFjEjWXTBf329LwO/CiQ4KTAs8cEqX/ctJKuokBEcuKJzWMDflYHO1VIr6qJN1lIaA
 tT+b0faVN4O9YlBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8A3B8779AC;
 Fri,  3 Jul 2026 10:32:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id K5KQILKPR2ocMQAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Fri, 03 Jul 2026 10:32:18 +0000
Message-ID: <285af006-f403-4c3d-8cd6-e0318c188b85@suse.de>
Date: Fri, 3 Jul 2026 12:32:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] drm/tests: shmem: Fix intermittent DMA overflow on
 ppc64le/s390x
To: =?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, airlied@gmail.com,
 simona@ffwll.ch, boris.brezillon@collabora.com, kees@kernel.org
References: <20260703063517.6346-1-jose.exposito89@gmail.com>
 <dcc6e658-210f-4cc9-a589-369d7983f170@suse.de> <akd6NQvMG6-4sWQQ@fedora>
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
In-Reply-To: <akd6NQvMG6-4sWQQ@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: C7D647483D
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 FREEMAIL_TO(0.00)[gmail.com];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FREEMAIL_CC(0.00)[lists.freedesktop.org,vger.kernel.org,linux.intel.com,kernel.org,gmail.com,ffwll.ch,collabora.com];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+];
 RCVD_COUNT_TWO(0.00)[2];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_SEVEN(0.00)[9]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TAGGED_RCPT(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:url, imap1.dmz-prg2.suse.org:rdns,
 imap1.dmz-prg2.suse.org:helo, suse.de:mid, suse.de:dkim, suse.com:url]
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

Hi José
Am 03.07.26 um 11:00 schrieb José Expósito:
> Hi Thomas,
>
> Thanks for your review.
>
> On Fri, Jul 03, 2026 at 08:53:30AM +0200, Thomas Zimmermann wrote:
>> Hi
>>
>> Am 03.07.26 um 08:34 schrieb José Expósito:
>>> Two drm_gem_shmem KUnit tests, drm_gem_shmem_test_get_pages_sgt() and
>>> drm_gem_shmem_test_purge(), intermittently fail on ppc64le and s390x CI
>>> with a DMA address overflow warning followed by -EIO:
>>>
>>>     DMA addr 0x00000001130b0000+65536 overflow (mask ffffffff, bus limit 0).
>>>     Expected sgt is not error, but is: -5
>>>
>>> Both tests call `drm_gem_shmem_get_pages_sgt()`, which internally pins
>>> backing pages and DMA-maps them via `dma_map_sgtable()`. The DMA mapping
>>> path is:
>>>
>>>     drm_gem_shmem_test_purge()
>>>       drm_gem_shmem_get_pages_sgt()
>>>         drm_gem_shmem_get_pages_sgt_locked() [drm_gem_shmem_helper.c]
>>>           dma_map_sgtable()                  [mapping.c]
>>>             __dma_map_sg_attrs()
>>>               dma_direct_map_sg()            [direct.c]
>>>                 dma_direct_map_phys()        [kernel/dma/direct.h]
>>>                   dma_capable()              Checks addr against DMA mask
>>>                     -> FAILS: addr > 0xFFFFFFFF
>>>
>>> KUnit devices are initialized with a 32-bit DMA mask
>>> (`DMA_BIT_MASK(32)`) in `lib/kunit/device.c`. On systems where the kernel
>>> allocates backing pages at physical addresses above 4GB, `dma_capable()`
>>> returns false because the address exceeds the 32-bit mask. The `dma_set_mask()`
>>> function updates `*dev->dma_mask` to the given value; setting it to
>>> `DMA_BIT_MASK(64)` allows any physical address to pass the check.
>>>
>>> The failure is intermittent because pages may or may not be allocated
>>> above 4GB on any given run depend on memory pressure.
>>>
>>> A third test in the same suite, `drm_gem_shmem_test_obj_create_private`,
>>> already calls `dma_set_mask(drm_dev->dev, DMA_BIT_MASK(64))` before its
>>> DMA mapping. This series applies the same fix to the two remaining tests.
>> Instead of doing whack-a-mole, is it possible to move the existing fix from
>> drm_gem_shmem_test_obj_create_private() to _test_init at [1] ? The DMA mask
>> would then be the same on all tests. [1] https://elixir.bootlin.com/linux/v7.1.2/source/drivers/gpu/drm/tests/drm_gem_shmem_test.c#L359
> Yes, I think it is possible. However, this is an intermittent failure that
> I couldn't reproduce locally and I tried to reduce as much as possible the
> risk of regression limitting the change to the 2 affected tests.
>
> I'm afraid I don't have enough knoledge about GEM's internals to know if moving
> the fix to the init function could introduce unwanted side-effects in the other
> tests. If you think it'd be safe, I'll trust you and move it.

Please do. I don't see why it should not work, and it's an easy revert 
it doesn't.

Best regards
Thomas

>
> Jose
>
> PS - Next week I'll be away from keyboard, so any change would need to wait a bit
>
>> Best regards Thomas
>>> José Expósito (2):
>>>     drm/tests: shmem: Set DMA mask to 64-bit in
>>>       drm_gem_shmem_test_get_pages_sgt
>>>     drm/tests: shmem: Set DMA mask to 64-bit in drm_gem_shmem_test_purge
>>>
>>>    drivers/gpu/drm/tests/drm_gem_shmem_test.c | 9 ++++++++-
>>>    1 file changed, 8 insertions(+), 1 deletion(-)
>>>
>> -- 
>> --
>> Thomas Zimmermann
>> Graphics Driver Developer
>> SUSE Software Solutions Germany GmbH
>> Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
>> GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG Nürnberg)
>>
>>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG Nürnberg)


