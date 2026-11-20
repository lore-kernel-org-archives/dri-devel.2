Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 817E6606A320
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 13:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=1QzYhUIC;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=B3Xrhzwr;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=QAOfbLYZ;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=BvOCCZVO
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C040E10E83F;
	Fri, 20 Nov 2026 13:02:14 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C177510E83F
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 13:02:02 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E6FB4225DD;
 Fri, 20 Nov 2026 13:01:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1795179721; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=+hw76wFclWBOEuXW0RzjleonS2M6gylSsM4JkLN6iWc=;
 b=1QzYhUICkarqKoqaDK/CIARgmH/NGSf6UH+vlMNT3anQOGB8iDlNGNvFIBP+bkDmTX+Ay9
 kB3y0aElCCOln7HZIQx5TGnjv2K+L3rc9BuUouNxbFI4aESWziMPrzlpamHKaK127JoXcz
 3DhiRrYyvP3n12dQbSYuSIHS84Qg1Cc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1795179721;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=+hw76wFclWBOEuXW0RzjleonS2M6gylSsM4JkLN6iWc=;
 b=B3XrhzwrWKoEjdJKAqTBFNnbucsFB+Ou/YpWouTXhNX/B85WcKAD7gfuN4+jXLKrY6Xv4w
 xI0lisH4M2uqoOCA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=QAOfbLYZ;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=BvOCCZVO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1795179719; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=+hw76wFclWBOEuXW0RzjleonS2M6gylSsM4JkLN6iWc=;
 b=QAOfbLYZCgD3IQndtyVCMhHG/2ScVjrc1sVhOSpz2r/nL2EfNiD1Id6FeyoMu7ooGZV9Ow
 8YzICuwxOmaWNLNAatubiK1J2ORXiN931Xu5LTVQBJlvVHi6V34rbeV7q76/Q2Jz96c9/o
 dX8jumFcfu+sjoHrChAlrr3tM+OrBj8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1795179719;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=+hw76wFclWBOEuXW0RzjleonS2M6gylSsM4JkLN6iWc=;
 b=BvOCCZVOQQU/XiK61g51TI6SAI/mMx132js2F5A6bpIeIHQuNHnqJCa18vm70S09izPYcQ
 jf8YVHpARefoNQBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7C4F11342D;
 Fri, 20 Nov 2026 13:01:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 1fkkEcdEAGtBUwAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Fri, 20 Nov 2026 13:01:59 +0000
Message-ID: <6d9e93eb-594a-4e4c-be73-ab80c6436847@suse.de>
Date: Fri, 20 Nov 2026 14:01:58 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/11] drm/udl: Allocate URBs on demand
To: Jie Feng <hjf3108@gmail.com>
Cc: airlied@redhat.com, sean@poorly.run, tiwai@suse.com,
 patrik.r.jakobsson@gmail.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, airlied@gmail.com, simona@ffwll.ch,
 dri-devel@lists.freedesktop.org, sashiko-reviews@lists.linux.dev
References: <20261119142114.152052-1-tzimmermann@suse.de>
 <20261119142114.152052-11-tzimmermann@suse.de>
 <CABOQOSVdsELGDEiJu95e5RQ1uRiWLkcwz4TB9xfbQe9qbD7WrA@mail.gmail.com>
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
In-Reply-To: <CABOQOSVdsELGDEiJu95e5RQ1uRiWLkcwz4TB9xfbQe9qbD7WrA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-12.00 / 50.00]; SUSE_INTERNAL_BYPASS(-9.00)[];
 BAYES_HAM(-3.00)[100.00%]; SUSPICIOUS_RECIPS(1.50)[];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; XM_UA_NO_VERSION(0.01)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 FREEMAIL_TO(0.00)[gmail.com]; MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FREEMAIL_CC(0.00)[redhat.com,poorly.run,suse.com,gmail.com,linux.intel.com,kernel.org,ffwll.ch,lists.freedesktop.org,lists.linux.dev];
 DKIM_TRACE(0.00)[suse.de:+]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCVD_TLS_ALL(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_SEVEN(0.00)[11]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TAGGED_RCPT(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email, suse.de:dkim, rate.so:url,
 suse.com:url, imap1.dmz-prg2.suse.org:rdns, imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -12.00
X-Spam-Level: 
X-Rspamd-Queue-Id: E6FB4225DD
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

Am 20.11.26 um 07:54 schrieb Jie Feng:
> On Fri, 20 Nov 2026 at 14:45, Thomas Zimmermann <tzimmermann@suse.de> wrote:
>> Remove the limit on the number of URBs in flight. Allocate URBs as
>> needed. Keep once-allocated URBs in a list for reuse at later frames.
>> Also remove some bogus debug output from the affected code.
>>
>> The existing synchronization in atomic_begin() guarantees that udl
>> does not send a frame over the USB before the previous frame has been
>> transferred. This avoids overloading the USB. If the USB is saturated,
>> page flips delay and the compositor reduces the update frequency.
>>
>> The allocated URBs remain in the cache until the driver is being removed
>> from the device. In a later update, a regular worker or a shrinker could
>> free the URB cache when needed.
>>
>> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
>> ---
>>   drivers/gpu/drm/udl/udl_drv.h  |   1 -
>>   drivers/gpu/drm/udl/udl_main.c | 123 ++++++++++++---------------------
>>   2 files changed, 44 insertions(+), 80 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/udl/udl_drv.h b/drivers/gpu/drm/udl/udl_drv.h
>> index 420166bdc4bc..68bcf0222764 100644
>> --- a/drivers/gpu/drm/udl/udl_drv.h
>> +++ b/drivers/gpu/drm/udl/udl_drv.h
>> @@ -45,7 +45,6 @@ struct urb_list {
>>          spinlock_t lock;
>>          wait_queue_head_t sleep;
>>          unsigned int in_flight;
>> -       int count;
>>   };
>>
>>   struct udl_device {
>> diff --git a/drivers/gpu/drm/udl/udl_main.c b/drivers/gpu/drm/udl/udl_main.c
>> index d0195bd4213d..adddcf4b3451 100644
>> --- a/drivers/gpu/drm/udl/udl_main.c
>> +++ b/drivers/gpu/drm/udl/udl_main.c
>> @@ -25,13 +25,10 @@
>>   #define NR_USB_REQUEST_CHANNEL 0x12
>>
>>   #define MAX_TRANSFER (PAGE_SIZE*16 - BULK_SIZE)
>> -#define WRITES_IN_FLIGHT (20)
>>   #define MAX_VENDOR_DESCRIPTOR_SIZE 256
>>
>>   #define UDL_SKU_PIXEL_LIMIT_DEFAULT    2080000
>>
>> -static struct urb *udl_get_urb_locked(struct udl_device *udl, long timeout);
>> -
>>   /*
>>    * Try to make sense of whatever we parse. Therefore return @end on
>>    * errors, but don't fail hard.
>> @@ -216,25 +213,41 @@ static struct urb *udl_alloc_bulk_urb(struct udl_device *udl, size_t size)
>>          return ERR_PTR(ret);
>>   }
>>
>> +static struct urb *__udl_get_cached_urb_locked(struct udl_device *udl)
>> +{
>> +       struct urb_node *unode;
>> +
>> +       assert_spin_locked(&udl->urbs.lock);
>> +
>> +       if (list_empty(&udl->urbs.list))
>> +               return NULL;
>> +
>> +       unode = list_first_entry(&udl->urbs.list, struct urb_node, entry);
>> +       list_del_init(&unode->entry);
>> +
>> +       return unode->urb;
>> +}
>> +
>>   static void udl_free_urb_list(struct udl_device *udl)
>>   {
>> +       struct drm_device *drm = &udl->drm;
>>          struct urb *urb;
>>
>> -       DRM_DEBUG("Waiting for completes and freeing all render urbs\n");
>> +       drm_dbg(drm, "Waiting for completes and freeing all render URBs\n");
>>
>> -       /* keep waiting and freeing, until we've got 'em all */
>> -       while (udl->urbs.count) {
>> -               spin_lock_irq(&udl->urbs.lock);
>> -               urb = udl_get_urb_locked(udl, MAX_SCHEDULE_TIMEOUT);
>> -               udl->urbs.count--;
>> -               spin_unlock_irq(&udl->urbs.lock);
>> -               if (WARN_ON(!urb))
>> -                       break;
>> -               /* Free each separately allocated piece */
>> -               udl_free_bulk_urb(urb);
>> +       /* keep waiting until we've got 'em all */
>> +       scoped_guard(spinlock_irq, &udl->urbs.lock) {
>> +               wait_event_lock_irq(udl->urbs.sleep, !udl->urbs.in_flight, udl->urbs.lock);
>> +
>> +               urb = __udl_get_cached_urb_locked(udl);
>>          }
>>
>> -       wake_up_all(&udl->urbs.sleep);
>> +       while (urb) {
>> +               udl_free_bulk_urb(urb);
>> +
>> +               scoped_guard(spinlock_irq, &udl->urbs.lock)
>> +                       urb = __udl_get_cached_urb_locked(udl);
>> +       }
>>   }
>>
>>   static void udl_urb_list_release(void *data)
>> @@ -244,71 +257,16 @@ static void udl_urb_list_release(void *data)
>>          udl_free_urb_list(udl);
>>   }
>>
>> -static int udl_alloc_urb_list(struct udl_device *udl, int count, size_t size)
>> +static int udl_init_urb_list(struct udl_device *udl)
>>   {
>>          struct drm_device *drm = &udl->drm;
>> -       size_t wanted_size = count * size;
>> -       int ret;
>>
>>          spin_lock_init(&udl->urbs.lock);
>>          INIT_LIST_HEAD(&udl->urbs.list);
>>          init_waitqueue_head(&udl->urbs.sleep);
>> -       udl->urbs.count = 0;
>>          udl->urbs.in_flight = 0;
>>
>> -retry:
>> -       while (udl->urbs.count * size < wanted_size) {
>> -               struct urb *urb;
>> -               struct urb_node *unode;
>> -
>> -               urb = udl_alloc_bulk_urb(udl, size);
>> -               if (IS_ERR(urb)) {
>> -                       if (PTR_ERR(urb) == -ENOBUFS && size > PAGE_SIZE) {
>> -                               size /= 2;
>> -                               udl_free_urb_list(udl);
>> -                               goto retry;
>> -                       }
>> -                       break;
>> -               }
>> -               unode = urb->context;
>> -
>> -               list_add_tail(&unode->entry, &udl->urbs.list);
>> -
>> -               udl->urbs.count++;
>> -       }
>> -
>> -       if (!udl->urbs.count)
>> -               return -ENOMEM;
>> -
>> -       ret = devm_add_action_or_reset(drm->dev, udl_urb_list_release, udl);
>> -       if (ret < 0)
>> -               return ret;
>> -
>> -       DRM_DEBUG("allocated %d %d byte urbs\n", udl->urbs.count, (int) size);
>> -
>> -       return udl->urbs.count;
>> -}
>> -
>> -static struct urb *udl_get_urb_locked(struct udl_device *udl, long timeout)
>> -{
>> -       struct urb_node *unode;
>> -
>> -       assert_spin_locked(&udl->urbs.lock);
>> -
>> -       /* Wait for an in-flight buffer to complete and get re-queued */
>> -       if (!wait_event_lock_irq_timeout(udl->urbs.sleep,
>> -                                        !udl->urbs.count ||
>> -                                        !list_empty(&udl->urbs.list),
>> -                                        udl->urbs.lock, timeout))
>> -               return NULL;
>> -
>> -       if (!udl->urbs.count)
>> -               return NULL;
>> -
>> -       unode = list_first_entry(&udl->urbs.list, struct urb_node, entry);
>> -       list_del_init(&unode->entry);
>> -
>> -       return unode->urb;
>> +       return devm_add_action_or_reset(drm->dev, udl_urb_list_release, udl);
>>   }
>>
>>   struct urb *udl_get_urb(struct udl_device *udl)
>> @@ -321,9 +279,18 @@ struct urb *udl_get_urb(struct udl_device *udl)
>>                          return NULL;
>>                  ++udl->urbs.in_flight;
>>
>> -               urb = udl_get_urb_locked(udl, HZ * 2);
>> -               if (!urb)
>> -                       --udl->urbs.in_flight;
>> +               urb = __udl_get_cached_urb_locked(udl);
>> +       }
>> +
>> +       if (!urb) {
>> +               urb = udl_alloc_bulk_urb(udl, MAX_TRANSFER);
>> +               if (IS_ERR(urb)) {
>> +                       scoped_guard(spinlock_irqsave, &udl->urbs.lock) {
>> +                               if (udl->urbs.in_flight)
>> +                                       --udl->urbs.in_flight;
>> +                       }
>> +                       return NULL;
>> +               }
> On a usb contention or stalled device, this might allocate memory unboundedly
> if the udl_sync_pending_urbs keeps timing out.
> The number of URBs could be limited based on the size of the worst-case
> full frame update. The entire urb cache can be cleared on a modeset,
> so that maximum memory usage scales with the frame size.

I wouldn't worry about this problem. Only compositors can send page 
flips. If the sync times out, the compositor should throttle down the 
page-flip rate.So it's unlikely to happen in practice. And a malicious 
compositor can already bring down the system today.

For the cleaning up unused allocations, I think a shrinker would be 
best. It's the kernel's data structure for clearing such caches when 
needed. It runs when needed and can also be tested via debugfs. That 
would be another patch on top, I think.

Best regards
Thomas

>
>>          }
>>
>>          return urb;
>> @@ -395,8 +362,6 @@ int udl_init(struct udl_device *udl)
>>          int ret = -ENOMEM;
>>          struct device *dma_dev;
>>
>> -       DRM_DEBUG("\n");
>> -
>>          dma_dev = usb_intf_get_dma_device(to_usb_interface(dev->dev));
>>          if (dma_dev) {
>>                  drm_dev_set_dma_dev(dev, dma_dev);
>> @@ -419,8 +384,8 @@ int udl_init(struct udl_device *udl)
>>          if (udl_select_std_channel(udl))
>>                  DRM_ERROR("Selecting channel failed\n");
>>
>> -       ret = udl_alloc_urb_list(udl, WRITES_IN_FLIGHT, MAX_TRANSFER);
>> -       if (ret < 0)
>> +       ret = udl_init_urb_list(udl);
>> +       if (ret)
>>                  return ret;
>>
>>          ret = udl_modeset_init(udl);
>> --
>> 2.56.0
>>
>>
>
> Best regards,
> Jie Feng

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Stefan Gaiser, Jochen Jaser, Abhinav Puri, (HRB 36809, AG Nürnberg)


