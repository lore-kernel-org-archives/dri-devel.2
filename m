Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28CD1606A320
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 18:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=bM8xLYWq;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=KnnQkiw/;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=bM8xLYWq;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=KnnQkiw/
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 53CC710E687;
	Thu, 19 Nov 2026 18:05:55 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0FBED1126AC
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 18:05:44 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 8A5831F851;
 Thu, 19 Nov 2026 18:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1795111542; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=L6iBAL/Cp7ijORXvrkf1YLKI4PmA/jJA/rnBcUHXNKQ=;
 b=bM8xLYWq6yreR3tc3bH+aOF3PCNeU1yuMXcAr6UdcRarW8aDUhoB+fwh4tvtW21+fLLXwp
 GLGXsZDA7fFb/9yik1uf+tdJt9JdBrYfrNXYoYYoUZAbTzHVsw6a4awfZUXD3WQbJ3AgZY
 YZJLc/5q3sRNqqVwMOrxic9Ba1B9i3Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1795111542;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=L6iBAL/Cp7ijORXvrkf1YLKI4PmA/jJA/rnBcUHXNKQ=;
 b=KnnQkiw/gwAoVeWJRwPBCW3Pql7C8K9DqEdaY62yWUK7O4b2ovoBZ0uny7UtbDv8htrEQI
 EGC8xAuJLq2P6gBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1795111542; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=L6iBAL/Cp7ijORXvrkf1YLKI4PmA/jJA/rnBcUHXNKQ=;
 b=bM8xLYWq6yreR3tc3bH+aOF3PCNeU1yuMXcAr6UdcRarW8aDUhoB+fwh4tvtW21+fLLXwp
 GLGXsZDA7fFb/9yik1uf+tdJt9JdBrYfrNXYoYYoUZAbTzHVsw6a4awfZUXD3WQbJ3AgZY
 YZJLc/5q3sRNqqVwMOrxic9Ba1B9i3Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1795111542;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=L6iBAL/Cp7ijORXvrkf1YLKI4PmA/jJA/rnBcUHXNKQ=;
 b=KnnQkiw/gwAoVeWJRwPBCW3Pql7C8K9DqEdaY62yWUK7O4b2ovoBZ0uny7UtbDv8htrEQI
 EGC8xAuJLq2P6gBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 53BCB1334C;
 Thu, 19 Nov 2026 18:05:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id zZ5eAXY6/2qxYwAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Thu, 19 Nov 2026 18:05:42 +0000
Message-ID: <68da11ef-02b7-4fef-b2b2-ad5a6c719d56@suse.de>
Date: Thu, 19 Nov 2026 19:05:41 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/11] drm/udl: Allocate URBs on demand
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org
References: <20261119142114.152052-1-tzimmermann@suse.de>
 <20261119142114.152052-11-tzimmermann@suse.de>
 <sashiko-outbox-223315@kernel.org>
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
In-Reply-To: <sashiko-outbox-223315@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-13.28 / 50.00]; SUSE_INTERNAL_BYPASS(-9.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-0.99)[-0.993];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 XM_UA_NO_VERSION(0.01)[]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; FROM_EQ_ENVFROM(0.00)[];
 TO_DN_NONE(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:url,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -13.28
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



Am 19.11.26 um 15:47 schrieb sashiko-bot@kernel.org:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [Medium] drm/udl: missing size fallback and in-flight wait in
>    udl_get_urb()
> --
>
> commit 2b67449c9bc54fc48767cd1733efcaed21d924b2
> Author: Thomas Zimmermann <tzimmermann@suse.de>
>
> drm/udl: Allocate URBs on demand
>
> This commit removes the fixed upfront allocation of URBs and instead
> allocates URBs on demand in udl_get_urb(), caching them for reuse across
> frames.
>
>> diff --git a/drivers/gpu/drm/udl/udl_main.c b/drivers/gpu/drm/udl/udl_main.c
>> index d0195bd4213df..adddcf4b34518 100644
>> --- a/drivers/gpu/drm/udl/udl_main.c
>> +++ b/drivers/gpu/drm/udl/udl_main.c
> [ ... ]
>> @@ -244,71 +257,16 @@ static void udl_urb_list_release(void *data)
>>   	udl_free_urb_list(udl);
>>   }
>>   
>> -static int udl_alloc_urb_list(struct udl_device *udl, int count, size_t size)
>> +static int udl_init_urb_list(struct udl_device *udl)
>>   {
>>   	struct drm_device *drm = &udl->drm;
>> -	size_t wanted_size = count * size;
>> -	int ret;
>>   
>>   	spin_lock_init(&udl->urbs.lock);
>>   	INIT_LIST_HEAD(&udl->urbs.list);
>>   	init_waitqueue_head(&udl->urbs.sleep);
>> -	udl->urbs.count = 0;
>>   	udl->urbs.in_flight = 0;
>>   
>> -retry:
>> -	while (udl->urbs.count * size < wanted_size) {
>> -		struct urb *urb;
>> -		struct urb_node *unode;
>> -
>> -		urb = udl_alloc_bulk_urb(udl, size);
>> -		if (IS_ERR(urb)) {
>> -			if (PTR_ERR(urb) == -ENOBUFS && size > PAGE_SIZE) {
>> -				size /= 2;
>> -				udl_free_urb_list(udl);
>> -				goto retry;
>> -			}
>> -			break;
>> -		}
>> -		unode = urb->context;
>> -
>> -		list_add_tail(&unode->entry, &udl->urbs.list);
>> -
>> -		udl->urbs.count++;
>> -	}
> [ ... ]
>> @@ -321,9 +279,18 @@ struct urb *udl_get_urb(struct udl_device *udl)
>>   			return NULL;
>>   		++udl->urbs.in_flight;
>>   
>> -		urb = udl_get_urb_locked(udl, HZ * 2);
>> -		if (!urb)
>> -			--udl->urbs.in_flight;
>> +		urb = __udl_get_cached_urb_locked(udl);
>> +	}
>> +
>> +	if (!urb) {
>> +		urb = udl_alloc_bulk_urb(udl, MAX_TRANSFER);
>> +		if (IS_ERR(urb)) {
>> +			scoped_guard(spinlock_irqsave, &udl->urbs.lock) {
>> +				if (udl->urbs.in_flight)
>> +					--udl->urbs.in_flight;
>> +			}
>> +			return NULL;
>> +		}
>>   	}
>>   
>>   	return urb;
> [Severity: Medium]
> Should udl_get_urb() fall back to smaller allocation sizes or wait for an
> in-flight URB when udl_alloc_bulk_urb(udl, MAX_TRANSFER) fails?

The was deliberate to reduce complexity. I assume that we shouldn't run 
that display driver if these allocations fail.   But if the removal 
turns out to be a problem, the logic can also remain.

>
> MAX_TRANSFER is PAGE_SIZE * 16 - BULK_SIZE, which requires an order-4
> contiguous coherent DMA allocation via usb_alloc_coherent().  Previously,
> udl_alloc_urb_list() handled -ENOBUFS by halving the buffer size down to
> PAGE_SIZE (added in 542bb9788a1f ("udl-kms: handle allocation failure")),
> and udl_alloc_bulk_urb() still records unode->alloc_size and returns
> -ENOBUFS for this purpose.
>
> Because URBs are now allocated on demand during modesets and frame updates
> when memory may be fragmented, a single order-4 allocation failure causes
> udl_get_urb() to return NULL immediately (even when other URBs are already
> in flight), aborting udl_crtc_helper_atomic_enable() or udl_handle_damage()
> and leaving the display blank or partially updated.
>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Stefan Gaiser, Jochen Jaser, Abhinav Puri, (HRB 36809, AG Nürnberg)


