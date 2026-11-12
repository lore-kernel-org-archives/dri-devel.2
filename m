Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81206606A333
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 08:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=fLUdzG/y;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=gonMpmBN;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=EKe/3eQ4;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=nbUuX9Qn
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E375B10FF07;
	Thu, 12 Nov 2026 08:55:30 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9869910FF07
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 08:55:19 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id EEB1F1F78D;
 Thu, 12 Nov 2026 08:55:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1794473718; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=8aZXza4kFatiur1PtdGFpFTbERe/xM90d2MkFZAyC70=;
 b=fLUdzG/yeUH4Vwr3CHM4IaFVSN23poWLXDJ+oZhSh+Jh5ltsXxazaGBJAT1paD66oGj1Co
 f3ndJ5aAVIdTQN19c3U4tnvQA0JAdxXKzw8O0LR5kP8nYAk9rmWHCSHlkfKDAvQoAPFG12
 xDWZHnsXz3+0sWpxNxIZ+CmBINpAzZA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1794473718;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=8aZXza4kFatiur1PtdGFpFTbERe/xM90d2MkFZAyC70=;
 b=gonMpmBNakzpjEQEzMtukOzPYDN18qeUY0ikxlT+L9UGwZoZkBfh9SozDwj1QohISMCuoh
 GD4PkaUx9udBbwAQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="EKe/3eQ4";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=nbUuX9Qn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1794473717; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=8aZXza4kFatiur1PtdGFpFTbERe/xM90d2MkFZAyC70=;
 b=EKe/3eQ45zDEEpCKyMY4VWpGBk6a+yG6w99lDiTL1nZPs2THzFtoHA1dXFax4UiwSWvCZ8
 Mp/SEvqTifnarvqxumlJ8chFIMNfB5yZkh+GgGYV4MQ4tcOXRxmB8JRgn0SJZgHtFHLMWZ
 eOvN0qDgFnhWQPTjZS6AMuvxnCmeLqc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1794473717;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=8aZXza4kFatiur1PtdGFpFTbERe/xM90d2MkFZAyC70=;
 b=nbUuX9QnPoDIJI7fJAopjdnsJqm93VaJQEDxxNBsv//4WjWgE7xV9VZKIVW31nHvOI9RrJ
 Vx2a6EKG3vFMy3Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 73A8113432;
 Thu, 12 Nov 2026 08:55:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 0T0zCPV+9WrrYQAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Thu, 12 Nov 2026 08:55:17 +0000
Message-ID: <01e0b058-88ae-4d1d-80c6-027c89b06cdc@suse.de>
Date: Thu, 12 Nov 2026 09:55:16 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] drm/tiny: trigger5: Add MCT Trigger 5 USB display
 driver
To: Jie Feng <hjf3108@gmail.com>
Cc: dri-devel@lists.freedesktop.org, cyrozap@gmail.com,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, open list <linux-kernel@vger.kernel.org>
References: <20261026112843.69795-1-hjf3108@gmail.com>
 <1b25256b-5fb5-4b4a-bc05-7a2bfc309128@suse.de>
 <CABOQOSWGUmaR2wSso37rYgg0QoJL3K1qoDPqsp8OzOk_ifpgCw@mail.gmail.com>
 <5dbac304-65a4-45c6-8c9f-01416951c293@suse.de>
 <CABOQOSXQvHG_7-S1UxErfF3crhAMPHjtcpPzS_zim9VVHHEecQ@mail.gmail.com>
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
In-Reply-To: <CABOQOSXQvHG_7-S1UxErfF3crhAMPHjtcpPzS_zim9VVHHEecQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: EEB1F1F78D
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-13.50 / 50.00]; SUSE_INTERNAL_BYPASS(-9.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 XM_UA_NO_VERSION(0.01)[]; MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FREEMAIL_TO(0.00)[gmail.com]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; RCVD_TLS_ALL(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[lists.freedesktop.org,gmail.com,linux.intel.com,kernel.org,ffwll.ch,vger.kernel.org];
 MID_RHS_MATCH_FROM(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_SEVEN(0.00)[8]; DKIM_TRACE(0.00)[suse.de:+];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:url, imap1.dmz-prg2.suse.org:rdns,
 imap1.dmz-prg2.suse.org:helo, suse.de:dkim, suse.de:email]
X-Spam-Score: -13.50
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
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi

Am 11.11.26 um 18:07 schrieb Jie Feng:
> On Wed, 11 Nov 2026 at 23:21, Thomas Zimmermann <tzimmermann@suse.de> wrote:
>> Hi
>>
>> Am 10.11.26 um 16:49 schrieb Jie Feng:
>>> On Tue, 10 Nov 2026 at 22:23, Thomas Zimmermann <tzimmermann@suse.de> wrote:
>>>> Hi,
>>>>
>>>> sorry for letting you wait for so long. You'll find a review below.
>>> Thanks for the review! Since this driver shares many similarities
>>> with the ms91xx driver I am submitting too, I will be making
>>> the changes in that driver too.
>> I've briefly seen that other driver. Let's focus on one of them first.
>> The other will then be easier, I guess.
> Sure, let's focus on the review here, this is a much smaller driver.
>>>>> +     ret = drm_gem_fb_begin_cpu_access(state->fb, DMA_FROM_DEVICE);
>>>>> +     if (ret < 0) {
>>>>> +             complete(&current_transfer->frame_complete);
>>>>> +             goto exit_save_pending;
>>>>> +     }
>>>>> +
>>>>> +     drm_fb_xrgb8888_to_rgb888(&data_map, NULL,
>>>>> +                               &shadow_plane_state->data[0],
>>>>> +                               state->fb, &current_rect,
>>>>> +                               &shadow_plane_state->fmtcnv_state);
>>>>> +
>>>>> +     drm_gem_fb_end_cpu_access(state->fb, DMA_FROM_DEVICE);
>>>>> +
>>>>> +     flush_kernel_vmap_range(current_transfer->buf.data, frame_len);
>>>>> +
>>>>> +     queue_work(trigger5->transfer_wq, &current_transfer->transfer_work);
>>>>> +     trigger5->current_transfer = !trigger5->current_transfer;
>>>> Why do you need a separate work item for the transfer. Can't you just
>>>> send from here?  We do this in udl.
>>> I want to make the send async, so drm_fb_xrgb8888_to_rgb888 can run
>>> in parallel with the usb transfer. This is done since drm_fb_*_to_*
>>> functions are slow when copying on write-combined memory due to
>>> dma-buf sharing between the main GPU and this device.
>> We do this in other drivers as well. Neither is supposed to be fast.
>> There's always this memcpy from the imported buffer.
>>
>>
>>> udl does usb_submit_urb, which is async, but the usb_sg_wait has no async
>>> counterpart, so I opted for putting it in a worker.
>> Why do you use usb_sg_wait() in the first place? It appears to be a loop
> This part is referenced from gud. I thought it makes sense since I need a large

Gud isn't really up to date and needs maintenance.  IIRC pushing the 
transfer out of the regular display pipeline worked around limitations 
in user space, which couldn't handle the long transfer times over USB.  
But that problem has been fixed long ago.


> vmalloc buffer, so using usb_sg_* looked like the right approach instead of
> asking for kmalloc(8MB).
>
> Alternative I considered are:
> - usb_alloc_noncoherent: but that requires implementing a fallback if a
>    controller doesn't support scatter gather DMA, while usb_sg_* does
>    handle all of these cases.
> - pool of fixed kmalloc buffers: 64K seems too small, too many URBs
>    for a 1080p frame, and tuning the number so that kmalloc will likely
>    to succeed on a fragmented system while keeping the number
>    of URBs per 1080p frame small doesn't seem like the right
>    approach to me.
>
> Are there other possible approaches to this?

Most updates are small. Optimizing or full-screen redraws might not be 
worth the effort. Apart from that, set a reasonable size limit for the 
send buffer, and put in as many scan lines as possible. Then do this for 
the next until the damage rectangle has been covered.


>
>> around usb_submit_urb() plus the waiting. (The comment at [1] is
>> actually quite funny.
>>
>> [1]
>> https://elixir.bootlin.com/linux/v7.3.1/source/drivers/usb/core/message.c#L761
> Indeed!
>>> I saw there's a TODO within the format helpers for io memory, so
>>> maybe in a future patch I could change it to use drm_memcpy_from_wc
>>> to speed it up. Currently it couldn't run at full 1080p at 60fps on bare-metal,
>>> but on a VM it is fine due to not copying from WC memory.
>>>
>>> There's also the other issue of some compositors calling _update
>>> in the render loop or something that causes visible stutter when a device's
>>> _update callback is slow.
>>>
>>> The ideal way to solve this, with both low latency and low memory footprint
>>> is to take inspiration from gm12u320 and store the fb and update rect in
>>> the device struct, and let a worker obtain the latest one from the struct.
>> It's not. None of our USB-based drivers are well optimized. You can take
>> some inspiration from them, but don't take them as they are.
>>
>> At the end of each page flip, DRM sends out a FLIP_COMPLETE event, [2]
>> telling the compositor that it's done with the display update. This
>> gives the compositor an idea about the performance of the device.  It
>> can adapt to that and end out less updates. By moving out the actual
>> work into a separate thread, you break that feedback. The compositor
>> will see an early complete from the page flip and queue up the next
>> frame immediately. The driver will pile up updates for the worker to
>> send out. Hence, leave the copying and sending operations in the regular
>> update code.  If you build this with usb_submit_urb(), there's no
>> waiting necessary.
> In that case, assuming I keep the usb_sg_wait, doing something like
> wait_for_completion(previous_transfer) would be more correct.

Please do away with the worker and the USB waiting.

>
>> [2]
>> https://elixir.bootlin.com/linux/v7.3.1/source/include/uapi/drm/drm.h#L1395
>>
>> What I have in mind for udl is this logic:
>>
>> 1. send the current frame's updates as usual using usb_submit_urb()
>>     - transfer runs in parallel to current display update
>>     - count the number of submitted urbs
>> 2. in each complete handler, decrement the urb count.
>> 3. in the next frame's atomic_begin, wait until the urb counter reaches zero
>>     - most parallelism
>>     - max out USB
>>     - maintains correct transfer statistics and events
>> 4. if the second frame takes longer than expected, the FLIP_COMPLETE
>> event wil be late; the compositor can throttle the page-flip rate
> For this one, wait_for_completion(previous_transfer) looks to be
> similar in behaviour.

That's not in your current patch AFAICT. And it makes the worker pointless.

Another issue is that your driver might want to add wait timeouts at 
some point, so that stuck devices can dealt with. Having the worker in 
the loop make it only harder.

Best regards
Thomas


>
>> I made a nicely working prototype from this.
>>
>> Best regards
>> Thomas
>>
>>
>>> The transfer is then sent in blocks, while overlapping the drm copy
>>> and usb transfer in parallel. I think this is a bit too much complexity
>>> for a drm/tiny driver though.
>>
>>
>>
>>> ...

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Stefan Gaiser, Jochen Jaser, Abhinav Puri, (HRB 36809, AG Nürnberg)


