Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19DD1606A321
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 15:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=nLqdCNxD;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=ahjW6I8x;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=zvf3pe8L;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=ICBJKXbN
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B3AC10E1A0;
	Wed, 11 Nov 2026 15:21:10 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D046310E1A0
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 15:20:58 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 8C5D01F45A;
 Wed, 11 Nov 2026 15:20:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1794410457; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=0yrePd1h2oZTsQTE5AFVlbyn9kDGrCe98RPApi3KuVc=;
 b=nLqdCNxDlnL+chJx0EXc3bFpwSkJxI3TZteDBgzf4RkOYR33kAWwiK7RYQhTvwI+3MP0Lx
 GV1BbxlGNCQbEp2VyWkTCUG6jAuAQ7ZL7PDiv73akZIxjOTKSQ6oUM2p9Hn9cjYXbnQ8eV
 4BAgmRrPwkDXbBZnQbA09dcO3POhESA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1794410457;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=0yrePd1h2oZTsQTE5AFVlbyn9kDGrCe98RPApi3KuVc=;
 b=ahjW6I8xVKdYYb7CBTnR+gpjELsgpBw7B2tpMYquUUXFjXoIBi9xibhM3qlA1t3EmhL/FY
 WJPvv4X+F7u0BPAA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=zvf3pe8L;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=ICBJKXbN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1794410455; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=0yrePd1h2oZTsQTE5AFVlbyn9kDGrCe98RPApi3KuVc=;
 b=zvf3pe8LravfuMnc77SAEcXvk30ddQ7xgJyuFbIxgInu0ia5S1XcL8yf9GG8E49IX9pUCv
 0gO16pWW9CaHPg08dNu+waScNuRlr6qq97FFfq8GkHLMX7o8M07iQEUux9WFgJhL1taId1
 dH27WuXzfsUK38tDPhUEyUI7PXNvaqg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1794410455;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=0yrePd1h2oZTsQTE5AFVlbyn9kDGrCe98RPApi3KuVc=;
 b=ICBJKXbNApLZQ2T8kTDpdX65dTXSApMOpsDQf9MmnuxsfXbTEQcZfK3tjJYKxhDNGPQyq6
 LsdFS/gIVghH7hCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 626F91339F;
 Wed, 11 Nov 2026 15:20:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id awzlDdaH9GofRQAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Wed, 11 Nov 2026 15:20:54 +0000
Message-ID: <5dbac304-65a4-45c6-8c9f-01416951c293@suse.de>
Date: Wed, 11 Nov 2026 16:20:53 +0100
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
In-Reply-To: <CABOQOSWGUmaR2wSso37rYgg0QoJL3K1qoDPqsp8OzOk_ifpgCw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-13.50 / 50.00]; SUSE_INTERNAL_BYPASS(-9.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 XM_UA_NO_VERSION(0.01)[]; MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 URIBL_BLOCKED(0.00)[bootlin.com:url,suse.de:email,suse.de:dkim,suse.com:url,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,
 imap1.dmz-prg2.suse.org:helo, suse.com:url, suse.de:email, suse.de:dkim,
 bootlin.com:url]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -13.50
X-Spam-Level: 
X-Rspamd-Queue-Id: 8C5D01F45A
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
X-Spam-Status: No, score=-22.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi

Am 10.11.26 um 16:49 schrieb Jie Feng:
> On Tue, 10 Nov 2026 at 22:23, Thomas Zimmermann <tzimmermann@suse.de> wrote:
>> Hi,
>>
>> sorry for letting you wait for so long. You'll find a review below.
> Thanks for the review! Since this driver shares many similarities
> with the ms91xx driver I am submitting too, I will be making
> the changes in that driver too.

I've briefly seen that other driver. Let's focus on one of them first. 
The other will then be easier, I guess.


>
>> The driver looks quite good already. Details below.  To give one advice,
>> I'd recommend to do away with the complicated transfer-worker logic and
>> simply send everything as part of the plane update, if possible.
> More details about this below.
>
>> Am 26.10.26 um 12:28 schrieb Ho Jie Feng:
>>> Add a DRM driver for MCT Trigger 5 USB display adapters.
>>> This supports USB 3 to HDMI/VGA displays adapters with
>>> trigger5 chipsets from j5create, StarTech and various others.
>>>
>>> The driver implements modesetting and USB framebuffer updates,
>>> connector detection, and EDID retrieval.
>>>
>>> The protocol is based on reverse-engineering work by Forest Crossman
>>> (cyrozap) at: https://github.com/cyrozap/mct-usb-display-adapter-re
>>> and usb packet captures between the Windows driver and the device.
>>>
>>> Only the HDMI path has been tested. VGA selection is inferred from the
>>> absence of USB audio interfaces.
>>>
>>> Tested on JUA355. The list of USB device IDs are taken from the
>>> Windows driver INF.
>>>
>>> Signed-off-by: Ho Jie Feng <hjf3108@gmail.com>
>>> ---
>>> Changes in v5:
>>> - Fix warnings found by kernel test robot
>>>
>>> Changes in v4:
>>> - Move the driver to drm/tiny
>>> - Remove the buffer resizing to reduce size of file
>>>
>>> Changes in v3:
>>> - Flush the vmalloc buffer before submitting the USB transfer.
>>> - Support display panning by using the source offset
>>>
>>> Changes in v2:
>>> - Move the buffer resizing to crtc_* functions so that we can report
>>>     out of memory errors to userspace
>>> - Change the PLL search function so that it is faster and doesn't
>>>     produce checkpatch warnings
>>> - Update drm functions: crtc reset becomes create_state
>>> - Fix warnings reported by kernel test robot
>>>
>>> sashiko review false positives in v1-4:
>>> - atomic in these function names mean that the changes should go through
>>>     through at once or not at all, nothing to do with atomic context.
>>>     Furthermore other drivers also have similar patterns
>> Exactly. Somehow Sashiko doesn't get this. It thinks atomic means
>> "atomic context".
> It's the old sashiko using the older gemini 3.5 model, the newer one
> using gemimi-4-argon
> doesn't seem to make the same mistake, so that's great.
>
>>> - drm_gem_fb_begin_cpu_access is also required
>>>
>>>    MAINTAINERS                     |    7 +
>>>    drivers/gpu/drm/tiny/Kconfig    |   14 +
>>>    drivers/gpu/drm/tiny/Makefile   |    1 +
>>>    drivers/gpu/drm/tiny/trigger5.c | 1115 +++++++++++++++++++++++++++++++
>>>    4 files changed, 1137 insertions(+)
>>>    create mode 100644 drivers/gpu/drm/tiny/trigger5.c
>>> ...
>>> +struct trigger5_device {
>>> +     struct drm_device drm;
>>> +     struct usb_interface *intf;
>>> +     unsigned int bulk_pipe;
>>> +
>>> +     struct drm_connector connector;
>>> +     struct drm_plane plane;
>>> +     struct drm_crtc crtc;
>>> +     struct drm_encoder encoder;
>>> +
>>> +     u16 frame_counter;
>>> +
>>> +     int current_transfer;
>>> +     struct drm_rect pending_rect;
>>> +     struct workqueue_struct *transfer_wq;
>> Do you really need your own queue?
>>
>> I'd recommend to push work on one of the system work queues.
> Most of the time in the usb transfer is spent on waiting, I didn't feel like
> blocking a system work queue on a mostly waiting task. Also, the failure path
> can wait up to 5s, so I want the failure impact to be small on the rest
> of the system.
>
>>> +     bool display_enabled;
>> This field only seems to control the dependency between transfer and
>> keepalive.
> It signals the keepalive worker to stop immediately if display is not enabled.
> The keepalive is only launched with queue_delayed_work after a transfer.
>
>>> ...
>>> +#define to_trigger5(x) container_of(x, struct trigger5_device, drm)
>> container_of_const() is nowadays the preferred macro.
>>> ...
>>> +     drm_dbg_kms(&trigger5->drm,
>> Drivers should use drm_dbg()
>>
>>> ...
>>> +     drm_err(&trigger5->drm, "failed to configure display mode: %d\n", ret);
>> No error messages in the display-update code paths please.  Maybe use
>> drm_err_once().  Otherwise you might spam the kernel logs with endless
>> error messages or give malicious user space a way to do that. Here and
>> in other functions.
>>
>>
>>> +     new_crtc_state = drm_atomic_get_new_crtc_state(state, crtc);
>> The pointer crtc can be NULL!  Then you cannot use it here. The pattern
>> for this code is
>>
>>     new_crtc_state = NULL;
>>
>>     if (crtc)
>>       new_crtc_state = drm_atomic_get_new_crtc_state(state, crtc)
>>
>> The call to _check_plane_state() will then work correctly and make the
>> plane as !visible.
> The above changes will be made in v6 (and the ms91xx patch)
>
>>> +static void trigger5_plane_atomic_update(struct drm_plane *plane,
>>> +                                      struct drm_atomic_commit *atomic_state)
>>> +{
>>> +     struct drm_plane_state *old_state =
>>> +             drm_atomic_get_old_plane_state(atomic_state, plane);
>>> +     struct drm_plane_state *state =
>>> +             drm_atomic_get_new_plane_state(atomic_state, plane);
>>> +     struct drm_shadow_plane_state *shadow_plane_state =
>>> +             to_drm_shadow_plane_state(state);
>>> +     struct trigger5_device *trigger5 = to_trigger5(plane->dev);
>>> +     struct trigger5_transfer *current_transfer, *previous_transfer;
>>> +     struct trigger5_bulk_header *header;
>>> +     struct drm_rect current_rect, src_rect;
>>> +     struct iosys_map data_map;
>>> +     size_t frame_len, payload_len;
>>> +     int width, height;
>>> +     int idx, ret;
>>> +
>>> +     if (!drm_atomic_helper_damage_merged(old_state, state, &current_rect))
>>> +             return;
>>> +
>>> +     if (!drm_dev_enter(plane->dev, &idx))
>>> +             return;
>>> +
>>> +     current_transfer =
>>> +             &trigger5->transfers[trigger5->current_transfer];
>>> +     previous_transfer = &trigger5->transfers[1 - trigger5->current_transfer];
>>> +
>>> +     src_rect = drm_plane_state_src(state);
>>> +
>>> +     /* Match drm_atomic_helper_damage_iter_init() rounding. */
>>> +     src_rect.x1 >>= 16;
>>> +     src_rect.y1 >>= 16;
>>> +     src_rect.x2 = (src_rect.x2 >> 16) + !!(src_rect.x2 & 0xffff);
>>> +     src_rect.y2 = (src_rect.y2 >> 16) + !!(src_rect.y2 & 0xffff);
>>> +
>>> +     /* Latency reduction: requeue with the latest frame data. */
>>> +     if (cancel_work(&previous_transfer->transfer_work)) {
>>> +             complete(&previous_transfer->frame_complete);
>> I would not recommend this logic.  For rapid successive updates, your
>> driver might end up canceling transfers and not sending any data for
>> extended periods.  Better take each frame on its own.
> The only small window when that could happen is that it might keep
> cancelling after the first frame finishing and before the next frame
> queued work item runs.
>
> It could be solved with triple-buffering, but the additional memory
> footprint might be worth considering.
>>> +
>>> +             trigger5_merge_rect(&current_rect, &previous_transfer->transfer_rect);
>>> +
>>> +             current_transfer = previous_transfer;
>>> +             trigger5->current_transfer = !trigger5->current_transfer;
>>> +     }
>>> +
>>> +     /* Damage deferred by an earlier failed update. */
>>> +     trigger5_merge_rect(&current_rect, &trigger5->pending_rect);
>>> +     trigger5_clear_rect(&trigger5->pending_rect);
>>> +
>>> +     /* Clip merged damage to the new resolution. */
>>> +     if (!drm_rect_intersect(&current_rect, &src_rect))
>>> +             goto exit;
>>> +
>>> +     width = drm_rect_width(&current_rect);
>>> +     height = drm_rect_height(&current_rect);
>>> +     payload_len = array3_size(width, height, 3);
>>> +     frame_len = size_add(payload_len, sizeof(*header));
>>> +
>>> +     if (drm_WARN_ON_ONCE(plane->dev, frame_len > current_transfer->buf.len))
>>> +             goto exit;
>>> +
>>> +     /*
>>> +      * This should almost never wait because we have should have a
>>> +      * pending transfer ready to be de-queued above in case the transfer
>>> +      * hasn't finished, but do a bounded wait just in case it gets stuck
>>> +      */
>>> +     if (!wait_for_completion_timeout(&current_transfer->frame_complete,
>>> +                                      msecs_to_jiffies(20)))
>>> +             goto exit_save_pending;
>>> +
>>> +     current_transfer->transfer_rect = current_rect;
>>> +
>>> +     current_transfer->frame_len = frame_len;
>>> +     header = current_transfer->buf.data;
>>> +     header->magic = 0xfb;
>>> +     header->length = 0x14;
>>> +     /* flags 0: uncompressed 24-bit RGB888. */
>>> +     header->counter =
>>> +             cpu_to_le16((trigger5->frame_counter++) & 0xfff);
>>> +     header->horizontal_offset = cpu_to_le16(current_rect.x1 - src_rect.x1);
>>> +     header->vertical_offset = cpu_to_le16(current_rect.y1 - src_rect.y1);
>>> +     header->width = cpu_to_le16(width);
>>> +     header->height = cpu_to_le16(height);
>>> +     header->payload_length = cpu_to_le32((u32)payload_len);
>>> +     header->flags = 0x1;
>>> +     header->unknown1 = 0;
>>> +     header->unknown2 = 0;
>>> +     header->checksum = trigger5_bulk_header_checksum(header);
>>> +
>>> +     iosys_map_set_vaddr(&data_map,
>>> +                         current_transfer->buf.data + sizeof(*header));
>>> +
>>> +     ret = drm_gem_fb_begin_cpu_access(state->fb, DMA_FROM_DEVICE);
>>> +     if (ret < 0) {
>>> +             complete(&current_transfer->frame_complete);
>>> +             goto exit_save_pending;
>>> +     }
>>> +
>>> +     drm_fb_xrgb8888_to_rgb888(&data_map, NULL,
>>> +                               &shadow_plane_state->data[0],
>>> +                               state->fb, &current_rect,
>>> +                               &shadow_plane_state->fmtcnv_state);
>>> +
>>> +     drm_gem_fb_end_cpu_access(state->fb, DMA_FROM_DEVICE);
>>> +
>>> +     flush_kernel_vmap_range(current_transfer->buf.data, frame_len);
>>> +
>>> +     queue_work(trigger5->transfer_wq, &current_transfer->transfer_work);
>>> +     trigger5->current_transfer = !trigger5->current_transfer;
>> Why do you need a separate work item for the transfer. Can't you just
>> send from here?  We do this in udl.
> I want to make the send async, so drm_fb_xrgb8888_to_rgb888 can run
> in parallel with the usb transfer. This is done since drm_fb_*_to_*
> functions are slow when copying on write-combined memory due to
> dma-buf sharing between the main GPU and this device.

We do this in other drivers as well. Neither is supposed to be fast. 
There's always this memcpy from the imported buffer.


>
> udl does usb_submit_urb, which is async, but the usb_sg_wait has no async
> counterpart, so I opted for putting it in a worker.

Why do you use usb_sg_wait() in the first place? It appears to be a loop 
around usb_submit_urb() plus the waiting. (The comment at [1] is 
actually quite funny.)

[1] 
https://elixir.bootlin.com/linux/v7.3.1/source/drivers/usb/core/message.c#L761

>
> I saw there's a TODO within the format helpers for io memory, so
> maybe in a future patch I could change it to use drm_memcpy_from_wc
> to speed it up. Currently it couldn't run at full 1080p at 60fps on bare-metal,
> but on a VM it is fine due to not copying from WC memory.
>
> There's also the other issue of some compositors calling _update
> in the render loop or something that causes visible stutter when a device's
> _update callback is slow.
>
> The ideal way to solve this, with both low latency and low memory footprint
> is to take inspiration from gm12u320 and store the fb and update rect in
> the device struct, and let a worker obtain the latest one from the struct.

It's not. None of our USB-based drivers are well optimized. You can take 
some inspiration from them, but don't take them as they are.

At the end of each page flip, DRM sends out a FLIP_COMPLETE event, [2] 
telling the compositor that it's done with the display update. This 
gives the compositor an idea about the performance of the device.  It 
can adapt to that and end out less updates. By moving out the actual 
work into a separate thread, you break that feedback. The compositor 
will see an early complete from the page flip and queue up the next 
frame immediately. The driver will pile up updates for the worker to 
send out. Hence, leave the copying and sending operations in the regular 
update code.  If you build this with usb_submit_urb(), there's no 
waiting necessary.

[2] 
https://elixir.bootlin.com/linux/v7.3.1/source/include/uapi/drm/drm.h#L1395

What I have in mind for udl is this logic:

1. send the current frame's updates as usual using usb_submit_urb()
   - transfer runs in parallel to current display update
   - count the number of submitted urbs
2. in each complete handler, decrement the urb count.
3. in the next frame's atomic_begin, wait until the urb counter reaches zero
   - most parallelism
   - max out USB
   - maintains correct transfer statistics and events
4. if the second frame takes longer than expected, the FLIP_COMPLETE 
event wil be late; the compositor can throttle the page-flip rate

I made a nicely working prototype from this.

Best regards
Thomas


> The transfer is then sent in blocks, while overlapping the drm copy
> and usb transfer in parallel. I think this is a bit too much complexity
> for a drm/tiny driver though.




>
>>> +     goto exit;
>>> +
>>> +     /* Retry the dropped damage on the next update. */
>>> +exit_save_pending:
>>> +     trigger5->pending_rect = current_rect;
>>> +exit:
>>> +     drm_dev_exit(idx);
>>> +}
>>> +
>>> +static const struct drm_mode_config_helper_funcs
>>> +trigger5_mode_config_helper_funcs = {
>>> +     .atomic_commit_tail = drm_atomic_helper_commit_tail_rpm,
>> This helper will first switch on the CRTC and then update the plane.
>> But there's a comment somewhere that says "Keepalive must only be sent
>> after a frame has been sent". The keepalive message is started in CRTC
>> enable before sending the frame, (right?)  Isn't that a contradiction?
> CRTC enable only sets display_enabled, but the first keepalive will
> only be launched in the transfer worker after the usb transfer finished.
>
>>> +
>>> +static const struct drm_plane_funcs trigger5_plane_funcs = {
>>> +     .update_plane = drm_atomic_helper_update_plane,
>>> +     .disable_plane = drm_atomic_helper_disable_plane,
>>> +     .destroy = drm_plane_cleanup,
>>> +     DRM_GEM_SHADOW_PLANE_FUNCS,
>>> +};
>> I suggest to put the plane code and _funcs before the CRTC code and _funcs.
>>> ...
>>> +static int trigger5_connector_get_modes(struct drm_connector *connector)
>>> +{
>>> +     struct trigger5_device *trigger5 = to_trigger5(connector->dev);
>>> +     const struct drm_edid *edid;
>>> +     int count;
>>> +
>>> +     edid = drm_edid_read_custom(connector, trigger5_read_edid, trigger5);
>>> +     drm_edid_connector_update(connector, edid);
>>> +     count = drm_edid_connector_add_modes(connector);
>>> +     if (!count)
>>> +             count = drm_add_modes_noedid(connector, 1920, 1200);
>> Please don't call drm_add_modes_noedid().  DRM helpers will set up safe
>> modes if no EDID could be found.  In you driver simply return he value
>> of count and let the helpers do their job.
>>> ...
>>> +static const struct usb_device_id id_table[] = {
>>> +     /* From Windows driver INF file */
>> Please remove that comment.  It's likely to bit rot quickly.  Maybe
>> mention it in the commit description, if you think it is important.
> Will be implemented in v6.
>
>> Best regards
>> Thomas
>>
>>> +     { USB_DEVICE_INTERFACE_NUMBER(0x0711, 0x5800, 0) }, /* HDMI */
>>> +     { USB_DEVICE_INTERFACE_NUMBER(0x0711, 0x5801, 0) },
>>> +     { USB_DEVICE_INTERFACE_NUMBER(0x0711, 0x5802, 0) },
>>> +     { USB_DEVICE_INTERFACE_NUMBER(0x0711, 0x5803, 0) },
>>> +     { USB_DEVICE(0x0711, 0x5804) }, /* VGA */
>>> +     { USB_DEVICE(0x0711, 0x5805) },
>>> +     { USB_DEVICE(0x0711, 0x5806) },
>>> +     { USB_DEVICE(0x0711, 0x5807) },
>>> +     { USB_DEVICE(0x0711, 0x5808) },
>>> +     { USB_DEVICE(0x0711, 0x5809) },
>>> +     { USB_DEVICE(0x0711, 0x580A) },
>>> +     { USB_DEVICE_INTERFACE_NUMBER(0x0711, 0x580B, 0) },
>>> +     { USB_DEVICE_INTERFACE_NUMBER(0x0711, 0x580C, 0) },
>>> +     { USB_DEVICE_INTERFACE_NUMBER(0x0711, 0x580D, 0) },
>>> +     { USB_DEVICE_INTERFACE_NUMBER(0x0711, 0x580E, 0) },
>>> +     { USB_DEVICE_INTERFACE_NUMBER(0x0711, 0x580F, 0) },
>>> +     { USB_DEVICE_INTERFACE_NUMBER(0x0711, 0x5810, 0) },
>>> +     { USB_DEVICE_INTERFACE_NUMBER(0x0711, 0x5811, 0) },
>>> +     { USB_DEVICE_INTERFACE_NUMBER(0x0711, 0x5812, 0) },
>>> +     { USB_DEVICE_INTERFACE_NUMBER(0x0711, 0x5813, 0) },
>>> +     { USB_DEVICE_INTERFACE_NUMBER(0x0711, 0x5814, 0) },
>>> +     { USB_DEVICE_INTERFACE_NUMBER(0x0711, 0x5815, 0) },
>>> +     { USB_DEVICE_INTERFACE_NUMBER(0x0711, 0x5816, 0) },
>>> +     { USB_DEVICE_INTERFACE_NUMBER(0x0711, 0x5817, 0) },
>>> +     { USB_DEVICE_INTERFACE_NUMBER(0x0711, 0x5818, 0) },
>>> +     { USB_DEVICE_INTERFACE_NUMBER(0x0711, 0x5819, 0) },
>>> +     { USB_DEVICE_INTERFACE_NUMBER(0x0711, 0x581A, 0) },
>>> +     { USB_DEVICE_INTERFACE_NUMBER(0x0711, 0x581B, 0) },
>>> +     { USB_DEVICE_INTERFACE_NUMBER(0x0711, 0x581C, 0) },
>>> +     { USB_DEVICE_INTERFACE_NUMBER(0x0711, 0x581D, 0) },
>>> +     { USB_DEVICE_INTERFACE_NUMBER(0x0711, 0x581E, 0) },
>>> +     { USB_DEVICE_INTERFACE_NUMBER(0x0711, 0x581F, 0) },
>>> +     { USB_DEVICE_INTERFACE_NUMBER(0x0711, 0x5820, 0) },
>>> +     { USB_DEVICE_INTERFACE_NUMBER(0x0711, 0x5821, 0) },
>>> +     { USB_DEVICE_INTERFACE_NUMBER(0x0711, 0x5822, 0) },
>>> +     { USB_DEVICE_INTERFACE_NUMBER(0x0711, 0x5823, 0) },
>>> +     { USB_DEVICE(0x0711, 0x5824) },
>>> +     { USB_DEVICE(0x0711, 0x5825) },
>>> +     { USB_DEVICE(0x0711, 0x5826) },
>>> +     { USB_DEVICE(0x0711, 0x5827) },
>>> +     { USB_DEVICE(0x0711, 0x5828) },
>>> +     { USB_DEVICE(0x0711, 0x5829) },
>>> +     { USB_DEVICE(0x0711, 0x582A) },
>>> +     { USB_DEVICE_INTERFACE_NUMBER(0x0711, 0x582B, 0) },
>>> +     { USB_DEVICE_INTERFACE_NUMBER(0x0711, 0x582C, 0) },
>>> +     { USB_DEVICE_INTERFACE_NUMBER(0x0711, 0x582D, 0) },
>>> +     { USB_DEVICE_INTERFACE_NUMBER(0x0711, 0x582E, 0) },
>>> +     { USB_DEVICE_INTERFACE_NUMBER(0x0711, 0x582F, 0) },
>>> +     { USB_DEVICE_INTERFACE_NUMBER(0x0711, 0x5830, 0) },
>>> +     { USB_DEVICE_INTERFACE_NUMBER(0x0711, 0x5831, 0) },
>>> +     { USB_DEVICE_INTERFACE_NUMBER(0x0711, 0x5832, 0) },
>>> +     { USB_DEVICE_INTERFACE_NUMBER(0x0711, 0x5833, 0) },
>>> +     { USB_DEVICE(0x0711, 0x5834) },
>>> +     { USB_DEVICE(0x0711, 0x5835) },
>>> +     { USB_DEVICE(0x0711, 0x5836) },
>>> +     { USB_DEVICE(0x0711, 0x5837) },
>>> +     { USB_DEVICE(0x0711, 0x5838) },
>>> +     { USB_DEVICE(0x0711, 0x5839) },
>>> +     { USB_DEVICE(0x0711, 0x583A) },
>>> +     { USB_DEVICE_INTERFACE_NUMBER(0x0711, 0x583B, 0) },
>>> +     { USB_DEVICE_INTERFACE_NUMBER(0x0711, 0x583C, 0) },
>>> +     { USB_DEVICE_INTERFACE_NUMBER(0x0711, 0x583D, 0) },
>>> +     { USB_DEVICE_INTERFACE_NUMBER(0x0711, 0x583E, 0) },
>>> +     { USB_DEVICE_INTERFACE_NUMBER(0x0711, 0x583F, 0) },
>>> +     {},
>>> +};
>>> +MODULE_DEVICE_TABLE(usb, id_table);
>>> +
>>> +static struct usb_driver trigger5_driver = {
>>> +     .name = DRIVER_NAME,
>>> +     .probe = trigger5_usb_probe,
>>> +     .disconnect = trigger5_usb_disconnect,
>>> +     .suspend = trigger5_usb_suspend,
>>> +     .resume = trigger5_usb_resume,
>>> +     .reset_resume = trigger5_usb_resume,
>>> +     .id_table = id_table,
>>> +};
>>> +module_usb_driver(trigger5_driver);
>>> +MODULE_AUTHOR("Ho Jie Feng <hjf3108@gmail.com>");
>>> +MODULE_DESCRIPTION(DRIVER_DESC);
>>> +MODULE_LICENSE("GPL");
>>>
>>> base-commit: cf61bef3801c3c9d0d8c39026b7b2fb242898a3a
>> --
>> --
>> Thomas Zimmermann
>> Graphics Driver Developer
>> SUSE Software Solutions Germany GmbH
>> Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
>> GF: Stefan Gaiser, Jochen Jaser, Abhinav Puri, (HRB 36809, AG Nürnberg)
>>
>>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Stefan Gaiser, Jochen Jaser, Abhinav Puri, (HRB 36809, AG Nürnberg)


