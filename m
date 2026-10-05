Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED3B4CA5FFF
	for <dri-devel@archiver.kernel.org>; Mon,  5 Oct 2026 12:22:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DBDBB10E255;
	Mon,  5 Oct 2026 12:22:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="Dk+P2gWs";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="wMNXPLPo";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="hLH2jarL";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="VzToTQEr";
	dkim-atps=neutral
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD2AF10E214;
 Mon,  5 Oct 2026 12:22:34 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7DEF921C82;
 Mon,  5 Oct 2026 12:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1791202948; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=1DfoM88+GeNeAzj4WsEuHFVheFhQrQ9ggax+D31QNAk=;
 b=Dk+P2gWsXXzPQY3Nf/3cxhLNv3G0MK8X0sCaw6roDfTmbBRWKtQj1leoizmdz3cSpFznON
 i7+4YpE6Yw8FidxM93oi7iMvzgMII1fkQRdQvSRhsZR6gu28h4N0Jkb6gwZ1WbvSn5TKDT
 J1OiS9G3NnPke471IgPsvJiVAy+A+1Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1791202948;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=1DfoM88+GeNeAzj4WsEuHFVheFhQrQ9ggax+D31QNAk=;
 b=wMNXPLPoXVqCyRGrtVVkha1PRpaqAr6c8TAblP+wLGFrxm4cd6ysyv4iqRKOq6r74EwlLG
 4A6hfZFmvnPhAxCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1791202944; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=1DfoM88+GeNeAzj4WsEuHFVheFhQrQ9ggax+D31QNAk=;
 b=hLH2jarLE9Ve6NyqnzszcIyyo9WDrbHk5wT/Y0kBE9qYgkpZb3UF9HxQoOrz89F/WUIpYk
 e3yKfVVauUfwjlKYMhveTuuf+EFBAffee2D6kb9p7AKP7rEos2LC6VXICJ2Mmwq4jfec96
 43pdnkNFCB4TaA5qZOcFG9NONrIYQ+Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1791202944;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=1DfoM88+GeNeAzj4WsEuHFVheFhQrQ9ggax+D31QNAk=;
 b=VzToTQEr6YpnWbCc8b9STFBY6PT0Wl7CXjjMMK99dE6YZbhm4fhNaFgl1IZapUlim+WO49
 N+9ya0jx9mYjGSAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C897C13A53;
 Mon,  5 Oct 2026 12:22:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id nMwDG3+Ww2ruJQAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Mon, 05 Oct 2026 12:22:23 +0000
Message-ID: <636a3dc2-fe17-463e-806a-056818656692@suse.de>
Date: Mon, 5 Oct 2026 14:22:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 1/7] drm: Define user readable error codes for atomic
 ioctl
To: Xaver Hugl <xaver.hugl@kde.org>
Cc: Arun R Murthy <arun.r.murthy@intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Jani Nikula <jani.nikula@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, harry.wentland@amd.com,
 uma.shankar@intel.com, louis.chauvet@bootlin.com, naveen1.kumar@intel.com,
 ramya.krishna.yella@intel.com, dri-devel@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 Suraj Kandpal <suraj.kandpal@intel.com>
References: <20260331-atomic-v11-0-6a1df7ec5af8@intel.com>
 <20260331-atomic-v11-1-6a1df7ec5af8@intel.com>
 <e9be1ef8-9884-4117-9eed-ba179248ffc6@suse.de>
 <CAFZQkGzSkUZTodjUudhLsYtset=EqviZeqrfv6gj6XmG+ZJOPQ@mail.gmail.com>
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
In-Reply-To: <CAFZQkGzSkUZTodjUudhLsYtset=EqviZeqrfv6gj6XmG+ZJOPQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_TWELVE(0.00)[19]; MID_RHS_MATCH_FROM(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[intel.com,linux.intel.com,kernel.org,gmail.com,ffwll.ch,ursulin.net,amd.com,bootlin.com,lists.freedesktop.org];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email, suse.de:mid,
 imap1.dmz-prg2.suse.org:helo, suse.com:url]
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

Am 05.10.26 um 13:39 schrieb Xaver Hugl:
> Am Mo., 5. Okt. 2026 um 11:08 Uhr schrieb Thomas Zimmermann
> <tzimmermann@suse.de>:
>> I have serious doubts about these failure codes. The core issue to me is
>> that when the kernel driver detects an impossible commit, it probably
>> knows best how to fix it.
> There's lots of different ways you could fix any specific error, with
> different tradeoffs and it all depends a lot on what the compositor is
> actually trying to do. The kernel can't make those kinds of policy
> decisions.

That's not a policy decision. User space is free to do what ever it 
wants.  What I have in mind is a hint from the kernel what to do next.


>
>>> + * @DRM_MODE_ATOMIC_UNSPECIFIED_ERROR: this is the default/unspecified error.
>> This one does not give a hint to what happens. Should userspace abort or
>> fall back to TEST_ONLY?
> That's up to userspace. It's the same as ret=-EINVAL today.

IMHO most of these errors are fancy variants of EINVAL; except for 
NEED_FULL_MODESET.


>
>>> + * @DRM_MODE_ATOMIC_INVALID_API_USAGE: invallid API usage(DRM_ATOMIC not
>>> + *                                  enabled, invalid falg, page_flip event
>>> + *                                  with test-only, etc)
>> I've seen this being used in the i915 patch for a async flip.  Could
>> mean anything there (format, driver specifics).
> Its purpose is to catch anything that the compositor is supposed to
> know it can't do - using unsupported formats, invalid combinations of
> properties (crtc active=1 without a connector), that sort of thing. It
> should never be anything driver specific though.

I don't see how this could be useful except for the prototype that come 
with this series.  It's so broad in meaning that it's almost meaningless.

And error codes don't have to be driver specific to be meaningful. I 
already brought up DRM's mode-status code as example. They are not 
specific to any mode, display or hardware. Yet they clearly state what 
went wrong with the mode.


>
>>> + * @DRM_MODE_ATOMIC_ASYNC_PROP_CHANGED: Property changed in async flip
>>> + * @DRM_MODE_ATOMIC_SCANOUT_BW: For a given resolution, refresh rate and the
>>> + *                              color depth cannot be accomodated. Resolution
>>> + *                              is to lower the refresh rate or color depth.
>>> + * @DRM_MODE_ATOMIC_CONNECTOR_BW: Refers to the limitation on the link rate on
>>> + *                                a given connector.
>>> + * @DRM_MODE_ATOMIC_PIPE_BW: Limitation on the pipe, either pipe not available
>>> + *                           or the pipe scaling factor limitation.
>>> + * @DRM_MODE_ATOMIC_MEMORY_DOMAIN: Any other memory/bandwidth related limitation
>>> + *                                 other then the ones specified above.
>>> + * @DRM_MODE_ATOMIC_SPEC_VIOLOATION: Limitation of a particular feature on that
>>> + *                                   hardware. To get to know the feature, the
>>> + *                                   property/object causing this is being sent
>>> + *                                   back to user @failure_objs_ptr in the
>>> + *                                   struct drm_mode_atomic_err_code
>> There codes don't seem actionable to me.
> Scanout and connector bandwidth are very directly actionable. I agree

Fair point.


> about the others though, adding these error codes should wait until
> there's a compositor actually using them for something.
>
>>> +     char failure_string[DRM_MODE_ATOMIC_FAILURE_STRING_LEN];
>> I'd don't think we should return error strings from the kernel. If we
>> do, these strings will become uAPI. And I guarantee that someone will
>> start parsing them for information. We'll be in a situation where we
>> cannot ever change the strings.
>>
>> For error logging, we can put messages directly in the kernel log
> The error string is half the reason we need the API: When things fail
> on an end user system, we need to be able to find out what happened
> after the fact, without the user needing to have drm debug logging
> enabled and without them having to trigger the bug again (which can be
> very difficult to do).

You could to this with detailed and precise error codes plus the object 
on which it failed.

If the error cannot be expressed in abstract terms then users will begin 
parsing the error string, which is a no-go IMHO.


>
> I think making the error string something more abstract like the file
> + line number of the failure would also be okay, if that solves the
> concerns about uAPI. We just need some way to figure out what happened
> after something goes wrong, which would usually involve diving through
> kernel sources anyways.

Filename + line is even worse.  None of this is even close to stable. 
I'll nak this as much as possible.

I also don't buy the argument about diving through kernel sources. Not 
doing that should be the goal here because it is what we currently do.


I don't want to leave it at this for this series, so here's my suggestion.

Pick 5 common mode-setting failures and go through all of the kernel 
drivers and report them as detailed as possible. This will give a good 
understanding of the characteristics of the errors involved and what 
could be done in the kernel. The simple i915 patch doesn't seem to grasp 
the effects of this change.

You may also want to play with an in-kernel interface that does the 
actual testing. Something like this.

   int drm_check_crtc_max_pixel_bandwidth(...)
   {
       // do the test and encode the error if any
   }

   if (!drm_check_crtc_max_pixel_(crtc, 
SOME_EXTRA_HINT_WHAT_WE_RE_DOING, (value < max_value))
       return -EINVAL.

do the same for other DRM objects and try to find a good API. Because if 
we're not careful, we'll end up with different kernel drivers 
implementing the failure reporting in different ways. It wouldn't be the 
first time.

Best regards
Thomas


>
>> or you can build them in user space from within libdrm.
> libdrm doesn't have any of the information returned in the error string.
>
> - Xaver

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Stefan Gaiser, Jochen Jaser, Abhinav Puri, (HRB 36809, AG Nürnberg)


