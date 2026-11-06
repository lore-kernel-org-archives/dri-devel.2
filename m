Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5227606A334
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 11:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=yB7z6EpW;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=iHGBOYvp;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=yB7z6EpW;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=iHGBOYvp
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EFE5A10F2A9;
	Fri,  6 Nov 2026 11:58:52 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A95C710E3FC;
 Fri,  6 Nov 2026 11:58:40 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 38ABE2224F;
 Fri,  6 Nov 2026 11:58:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1793966319; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=MnP0dT6NT6NLQmi38k1V7n9O9C9IvAcE5LQAbe5tJHs=;
 b=yB7z6EpW6dlhbtG0t8LFMkJx1IAV82gRW+MiLLqOgIHJUu+7htLztaPiqc5r5BLgfIx8my
 /t21bknNbax29LAcIX/u6tfDN00K13C7BonAlLa2CHNeR1O1QEueroJB305kbEA7l4BKwd
 ZsCR4SEjgWc/gCdWtn4LZOO2T/DCi8A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1793966319;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=MnP0dT6NT6NLQmi38k1V7n9O9C9IvAcE5LQAbe5tJHs=;
 b=iHGBOYvpIWzqq4QIIYqPtHhWBQ4qUIVEqUCocIfCse7ZVnpcWU+OfmUOOMoPJn0mwOj8CJ
 9bvlvgCrWkIFbVBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1793966319; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=MnP0dT6NT6NLQmi38k1V7n9O9C9IvAcE5LQAbe5tJHs=;
 b=yB7z6EpW6dlhbtG0t8LFMkJx1IAV82gRW+MiLLqOgIHJUu+7htLztaPiqc5r5BLgfIx8my
 /t21bknNbax29LAcIX/u6tfDN00K13C7BonAlLa2CHNeR1O1QEueroJB305kbEA7l4BKwd
 ZsCR4SEjgWc/gCdWtn4LZOO2T/DCi8A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1793966319;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=MnP0dT6NT6NLQmi38k1V7n9O9C9IvAcE5LQAbe5tJHs=;
 b=iHGBOYvpIWzqq4QIIYqPtHhWBQ4qUIVEqUCocIfCse7ZVnpcWU+OfmUOOMoPJn0mwOj8CJ
 9bvlvgCrWkIFbVBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D5F20132C9;
 Fri,  6 Nov 2026 11:58:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id gMfiIe7A7WrFVAAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Fri, 06 Nov 2026 11:58:38 +0000
Message-ID: <c30bf478-381a-451c-bf7c-111df2b0190f@suse.de>
Date: Fri, 6 Nov 2026 12:58:38 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/client: Don't warn when a client's VBLANK wait times
 out
To: "Liang, Prike" <Prike.Liang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Cc: David Airlie <airlied@redhat.com>,
 "Wentland, Harry" <Harry.Wentland@amd.com>,
 "Li, Sun peng (Leo)" <Sunpeng.Li@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>
References: <20261104024106.3109873-1-Prike.Liang@amd.com>
 <bad6a4e6-bd1f-49de-aa86-a7d8e4eb64f5@suse.de>
 <PH7PR12MB6000215092E10B0C62D68733FB762@PH7PR12MB6000.namprd12.prod.outlook.com>
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
In-Reply-To: <PH7PR12MB6000215092E10B0C62D68733FB762@PH7PR12MB6000.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-13.29 / 50.00]; SUSE_INTERNAL_BYPASS(-9.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-0.999];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 XM_UA_NO_VERSION(0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_EQ_ADDR_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; RCPT_COUNT_SEVEN(0.00)[8];
 RCVD_TLS_ALL(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, amd.com:email,
 suse.de:email, bootlin.com:url, suse.com:url]
X-Spam-Score: -13.29
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

Am 06.11.26 um 09:28 schrieb Liang, Prike:
> AMD General
>
> Regards,
>        Prike
>
>> -----Original Message-----
>> From: Thomas Zimmermann <tzimmermann@suse.de>
>> Sent: Thursday, November 5, 2026 11:04 PM
>> To: Liang, Prike <Prike.Liang@amd.com>; amd-gfx@lists.freedesktop.org; dri-
>> devel@lists.freedesktop.org
>> Cc: David Airlie <airlied@redhat.com>; Wentland, Harry
>> <Harry.Wentland@amd.com>; Li, Sun peng (Leo) <Sunpeng.Li@amd.com>;
>> Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
>> <Christian.Koenig@amd.com>
>> Subject: Re: [PATCH] drm/client: Don't warn when a client's VBLANK wait times out
>>
>> Hi
>>
>> Am 04.11.26 um 03:41 schrieb Prike Liang:
>>> drm_client_modeset_wait_for_vblank() only rate-limits fbdev damage
>>> updates and serves FBIO_WAITFORVSYNC, but it waits with
>>> drm_crtc_wait_one_vblank(), which warns if no VBLANK arrives in time.
>>>
>>> VBLANK interrupts can stop while the fbdev client keeps running. Since
>>> commit ebc3351cc4a9 ("drm/amdgpu: remove suspend/resume DRM clients
>>> during GPU recovery"), amdgpu no longer suspends DRM clients for GPU
>>> recovery, as that made recovery wait for clientlist_mutex, the console
>> Isn't that rather a bug in amdgpu?
> Hi Thomas,
>
> Yes, it is a trade-off solution. While the vblank interrupt is disabled during
> GPU reset, suspending the DRM clients blocks on waits that cause
> lock-order problems with the reset. Not suspending them avoids those
> problems, but then the fbdev damage worker's vblank wait times out.
>
> I'll look into whether this can be fixed in amdgpu instead, by
> stopping vblank waits once the display core has disabled the vblank
> interrupts.

What does user space do in the case of a GPU reset?   Ideally, we'd do 
something similar for kernel clients.

We could make waiting for the vblank [1] interruptible in some way.

[1] 
https://elixir.bootlin.com/linux/v7.3.1/source/drivers/gpu/drm/drm_vblank.c#L1325

Best regards
Thomas

>
> Thanks,
>     Prike
>
>> Best regards
>> Thomas
>>
>>> lock and the damage worker, whose holders can depend on fences that
>>> only signal after the reset. The display is still shut down for the
>>> reset, so the damage worker now times out and warns:
>>>
>>>     amdgpu 0000:03:00.0: [drm] vblank wait timed out on crtc 0
>>>     WARNING: drivers/gpu/drm/drm_vblank.c:1320 at
>> drm_crtc_wait_one_vblank+0x194/0x200
>>>     Workqueue: events drm_fb_helper_damage_work
>>>     Call Trace:
>>>      drm_client_modeset_wait_for_vblank+0x63/0x80
>>>      drm_fb_helper_damage_work+0x89/0x1a0
>>>
>>> Userspace can trigger the same warning with FBIO_WAITFORVSYNC. Wait on
>>> the VBLANK queue with the same timeout, but log a debug message
>>> instead of warning when it expires; a missed VBLANK only means the
>>> update isn't synchronized.
>>>
>>> Fixes: d8c4bddcd8bc ("drm/fb-helper: Synchronize dirty worker with
>>> vblank")
>>> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
>>> Cc: David Airlie <airlied@redhat.com>
>>> Cc: dri-devel@lists.freedesktop.org
>>> Cc: Harry Wentland <harry.wentland@amd.com>
>>> Cc: Leo Li <sunpeng.li@amd.com>
>>> Cc: Thomas Zimmermann <tzimmermann@suse.de>
>>> Cc: Alex Deucher <alexander.deucher@amd.com>
>>> Cc: Christian König <christian.koenig@amd.com>
>>> ---
>>>    drivers/gpu/drm/drm_client_modeset.c | 12 ++++++++++--
>>>    1 file changed, 10 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/drm_client_modeset.c
>>> b/drivers/gpu/drm/drm_client_modeset.c
>>> index 0080a8e9556a..7b3193d73bbf 100644
>>> --- a/drivers/gpu/drm/drm_client_modeset.c
>>> +++ b/drivers/gpu/drm/drm_client_modeset.c
>>> @@ -1301,7 +1301,8 @@ EXPORT_SYMBOL(drm_client_modeset_dpms);
>>>     *
>>>     * Block the caller until the given CRTC has seen a VBLANK. Do nothing
>>>     * if the CRTC is disabled. If there's another DRM master present,
>>> fail
>>> - * with -EBUSY.
>>> + * with -EBUSY. Give up without a warning if no VBLANK arrives within
>>> + a
>>> + * second, e.g. while the driver resets the display hardware.
>>>     *
>>>     * Returns:
>>>     * 0 on success, or negative error code otherwise.
>>> @@ -1328,7 +1329,14 @@ int drm_client_modeset_wait_for_vblank(struct
>> drm_client_dev *client, unsigned i
>>>       */
>>>      ret = drm_crtc_vblank_get(crtc);
>>>      if (!ret) {
>>> -           drm_crtc_wait_one_vblank(crtc);
>>> +           u64 last = drm_crtc_vblank_count(crtc);
>>> +
>>> +           /* Unlike drm_crtc_wait_one_vblank(), don't warn if VBLANKs stop. */
>>> +           if (!wait_event_timeout(*drm_crtc_vblank_waitqueue(crtc),
>>> +                                   drm_crtc_vblank_count(crtc) != last,
>>> +                                   msecs_to_jiffies(1000)))
>>> +                   drm_dbg_vbl(dev, "[CRTC:%d:%s] vblank wait timed out\n",
>>> +                               crtc->base.id, crtc->name);
>>>              drm_crtc_vblank_put(crtc);
>>>      }
>>>
>> --
>> --
>> Thomas Zimmermann
>> Graphics Driver Developer
>> SUSE Software Solutions Germany GmbH
>> Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
>> GF: Stefan Gaiser, Jochen Jaser, Abhinav Puri, (HRB 36809, AG Nürnberg)
>>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Stefan Gaiser, Jochen Jaser, Abhinav Puri, (HRB 36809, AG Nürnberg)


