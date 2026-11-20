Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11402606A320
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 12:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=Npc5gcjm;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=joLw8WF6;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=Npc5gcjm;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=joLw8WF6
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5917A10E813;
	Fri, 20 Nov 2026 12:49:20 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8EAC410E8B4
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 12:49:09 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1BC2B21E02;
 Fri, 20 Nov 2026 12:49:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1795178948; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=61TOeQ+/NDEuVSWfaoA1fGoRW9OTG2WC5L48/FamscM=;
 b=Npc5gcjmN7Ap2sD/UtKCDoWzPHzf/IJnj0wcNbGyneSK/SW2Nwgq9x0qn8CMfOm8N4yUpT
 iol/3qE/FAn9IIAWzvzddze2vxsscH0q36YQxIe2HdBMVnPXgFFRaq6jhvj2DCp8VZL1bO
 ifok9NFq5MU+17K2mbAINm0H2H1LzgA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1795178948;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=61TOeQ+/NDEuVSWfaoA1fGoRW9OTG2WC5L48/FamscM=;
 b=joLw8WF6pQrF6ovz+ga9h3yhoJxlSFObb8qNzBgIVsB2he0pzOFfiqemI6G03rqyhDUZ50
 Keag7s/Oi36jEuAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1795178948; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=61TOeQ+/NDEuVSWfaoA1fGoRW9OTG2WC5L48/FamscM=;
 b=Npc5gcjmN7Ap2sD/UtKCDoWzPHzf/IJnj0wcNbGyneSK/SW2Nwgq9x0qn8CMfOm8N4yUpT
 iol/3qE/FAn9IIAWzvzddze2vxsscH0q36YQxIe2HdBMVnPXgFFRaq6jhvj2DCp8VZL1bO
 ifok9NFq5MU+17K2mbAINm0H2H1LzgA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1795178948;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=61TOeQ+/NDEuVSWfaoA1fGoRW9OTG2WC5L48/FamscM=;
 b=joLw8WF6pQrF6ovz+ga9h3yhoJxlSFObb8qNzBgIVsB2he0pzOFfiqemI6G03rqyhDUZ50
 Keag7s/Oi36jEuAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A48AF134F6;
 Fri, 20 Nov 2026 12:49:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id hEUPIMNBAGsSRgAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Fri, 20 Nov 2026 12:49:07 +0000
Message-ID: <9ba8634d-d714-4967-9a59-1e0ffcf2f8ca@suse.de>
Date: Fri, 20 Nov 2026 13:49:07 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/11] drm/udl: Allocate bulk URBs in helper functions
To: Jie Feng <hjf3108@gmail.com>
Cc: airlied@redhat.com, sean@poorly.run, tiwai@suse.com,
 patrik.r.jakobsson@gmail.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, airlied@gmail.com, simona@ffwll.ch,
 dri-devel@lists.freedesktop.org, sashiko-reviews@lists.linux.dev
References: <20261119142114.152052-1-tzimmermann@suse.de>
 <20261119142114.152052-5-tzimmermann@suse.de>
 <CABOQOSW8f2Dw7DATTB-c1jhOzyo4BBsKh4cNVnEA0VpRJ=5H8g@mail.gmail.com>
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
In-Reply-To: <CABOQOSW8f2Dw7DATTB-c1jhOzyo4BBsKh4cNVnEA0VpRJ=5H8g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-11.79 / 50.00]; SUSE_INTERNAL_BYPASS(-9.00)[];
 BAYES_HAM(-3.00)[100.00%]; SUSPICIOUS_RECIPS(1.50)[];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 XM_UA_NO_VERSION(0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 ARC_NA(0.00)[]; FREEMAIL_TO(0.00)[gmail.com];
 MIME_TRACE(0.00)[0:+];
 FREEMAIL_CC(0.00)[redhat.com,poorly.run,suse.com,gmail.com,linux.intel.com,kernel.org,ffwll.ch,lists.freedesktop.org,lists.linux.dev];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]; TAGGED_RCPT(0.00)[];
 RCPT_COUNT_SEVEN(0.00)[11]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:url, imap1.dmz-prg2.suse.org:helo,
 suse.de:email]
X-Spam-Score: -11.79
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi

Am 19.11.26 um 17:38 schrieb Jie Feng:
> On Fri, 20 Nov 2026 at 00:30, Thomas Zimmermann <tzimmermann@suse.de> wrote:
>> Move the code for allocating an URB into a separate helper function. Use
>> the helper for initializing the URB cache.
>>
>> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
>> ---
>>   drivers/gpu/drm/udl/udl_main.c | 74 +++++++++++++++++++++-------------
>>   1 file changed, 47 insertions(+), 27 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/udl/udl_main.c b/drivers/gpu/drm/udl/udl_main.c
>> index 67da676f0f94..a799d7710a7b 100644
>> --- a/drivers/gpu/drm/udl/udl_main.c
>> +++ b/drivers/gpu/drm/udl/udl_main.c
>> @@ -163,6 +163,47 @@ static void udl_urb_completion(struct urb *urb)
>>          udl_put_urb(urb);
>>   }
>>
>> +static struct urb *udl_alloc_bulk_urb(struct udl_device *udl, size_t size)
>> +{
>> +       struct usb_device *udev = udl_to_usb_device(udl);
>> +       struct urb_node *unode;
>> +       struct urb *urb;
>> +       char *buf;
>> +       int ret;
>> +
>> +       urb = usb_alloc_urb(0, GFP_KERNEL);
>> +       if (!urb)
>> +               return ERR_PTR(-ENOMEM);
>> +
>> +       unode = kzalloc_obj(struct urb_node);
>> +       if (!unode) {
>> +               ret = -ENOMEM;
>> +               goto err_usb_free_urb;
>> +       }
>> +       unode->dev = udl;
>> +       unode->urb = urb;
>> +
>> +       buf = usb_alloc_coherent(udev, size, GFP_KERNEL, &urb->transfer_dma);
> usb_alloc_coherent might map uncached memory on platforms such as ARM.
> This might be slow for moving large amounts of frame data.
> Would using kmalloc/usb_alloc_noncoherent be better?

It's worth a try, but i cannot say for sure. The advantage of _coherent 
is that is makes DMA easy. And we don't read from these buffers from the 
CPU, so caching them might not help much for performance. In any case, 
it's a separate patch series.

Best regards
Thomas

>> +       if (!buf) {
>> +               ret = -ENOBUFS;
>> +               goto err_kfree;
>> +       }
>> +       unode->alloc_size = size;
>> +
>> +       /* urb->transfer_buffer_length set to actual before submit */
>> +       usb_fill_bulk_urb(urb, udev, usb_sndbulkpipe(udev, 1), buf, unode->alloc_size,
>> +                         udl_urb_completion, unode);
>> +       urb->transfer_flags |= URB_NO_TRANSFER_DMA_MAP;
>> +
>> +       return urb;
>> +
>> +err_kfree:
>> +       kfree(unode);
>> +err_usb_free_urb:
>> +       usb_free_urb(urb);
>> +       return ERR_PTR(ret);
>> +}
>> +
>>   static void udl_free_urb_list(struct udl_device *udl)
>>   {
>>          struct urb_node *unode;
>> @@ -191,11 +232,7 @@ static void udl_free_urb_list(struct udl_device *udl)
>>
>>   static int udl_alloc_urb_list(struct udl_device *udl, int count, size_t size)
>>   {
>> -       struct urb *urb;
>> -       struct urb_node *unode;
>> -       char *buf;
>>          size_t wanted_size = count * size;
>> -       struct usb_device *udev = udl_to_usb_device(udl);
>>
>>          spin_lock_init(&udl->urbs.lock);
>>          INIT_LIST_HEAD(&udl->urbs.list);
>> @@ -205,36 +242,19 @@ static int udl_alloc_urb_list(struct udl_device *udl, int count, size_t size)
>>
>>   retry:
>>          while (udl->urbs.count * size < wanted_size) {
>> -               unode = kzalloc_obj(struct urb_node);
>> -               if (!unode)
>> -                       break;
>> -               unode->dev = udl;
>> +               struct urb *urb;
>> +               struct urb_node *unode;
>>
>> -               urb = usb_alloc_urb(0, GFP_KERNEL);
>> -               if (!urb) {
>> -                       kfree(unode);
>> -                       break;
>> -               }
>> -               unode->urb = urb;
>> -               unode->alloc_size = size;
>> -
>> -               buf = usb_alloc_coherent(udev, unode->alloc_size, GFP_KERNEL,
>> -                                        &urb->transfer_dma);
>> -               if (!buf) {
>> -                       kfree(unode);
>> -                       usb_free_urb(urb);
>> -                       if (size > PAGE_SIZE) {
>> +               urb = udl_alloc_bulk_urb(udl, size);
>> +               if (IS_ERR(urb)) {
>> +                       if (PTR_ERR(urb) == -ENOBUFS && size > PAGE_SIZE) {
>>                                  size /= 2;
>>                                  udl_free_urb_list(udl);
>>                                  goto retry;
>>                          }
>>                          break;
>>                  }
>> -
>> -               /* urb->transfer_buffer_length set to actual before submit */
>> -               usb_fill_bulk_urb(urb, udev, usb_sndbulkpipe(udev, 1),
>> -                                 buf, size, udl_urb_completion, unode);
>> -               urb->transfer_flags |= URB_NO_TRANSFER_DMA_MAP;
>> +               unode = urb->context;
>>
>>                  list_add_tail(&unode->entry, &udl->urbs.list);
>>
>> --
>> 2.56.0
>>
>>
> Best regards,
> Jie Feng

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Stefan Gaiser, Jochen Jaser, Abhinav Puri, (HRB 36809, AG Nürnberg)


