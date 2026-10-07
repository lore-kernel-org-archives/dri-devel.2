Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 874D6CA5FF1
	for <dri-devel@archiver.kernel.org>; Wed,  7 Oct 2026 08:41:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF0F410F4AF;
	Wed,  7 Oct 2026 08:41:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="VIlOSRzq";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="CEukVPWZ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="VIlOSRzq";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="CEukVPWZ";
	dkim-atps=neutral
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E7DCC10E408;
 Wed,  7 Oct 2026 08:41:18 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6D4031F449;
 Wed,  7 Oct 2026 08:41:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1791362473; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=awyWxK8ibHiOt8XwBKSmNiKJ1ZV9uh0ktTG3K5K9LNw=;
 b=VIlOSRzqQ8vWjcq4UaURY/rcr7w0PzPfR/pCXMUa4due3xcg01e5C533nWg3M4SHo52qPU
 /lcT7Podr16KOwQtySdUAuL7QWyL2ZOyMbHQjTb3jjuTj2RrDcEhFAmuSJabsztScgd8FU
 cmhPrlEhG6h4J4V3KXnBz+aB6KCkm+A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1791362473;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=awyWxK8ibHiOt8XwBKSmNiKJ1ZV9uh0ktTG3K5K9LNw=;
 b=CEukVPWZmfb6yU7ubE2c1iyGXWtY0d1pq5Dhr77+jJZXtWCIsEHYpkl/gJKi+2A/E1C39w
 zwziWysP7kPKFUDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1791362473; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=awyWxK8ibHiOt8XwBKSmNiKJ1ZV9uh0ktTG3K5K9LNw=;
 b=VIlOSRzqQ8vWjcq4UaURY/rcr7w0PzPfR/pCXMUa4due3xcg01e5C533nWg3M4SHo52qPU
 /lcT7Podr16KOwQtySdUAuL7QWyL2ZOyMbHQjTb3jjuTj2RrDcEhFAmuSJabsztScgd8FU
 cmhPrlEhG6h4J4V3KXnBz+aB6KCkm+A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1791362473;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=awyWxK8ibHiOt8XwBKSmNiKJ1ZV9uh0ktTG3K5K9LNw=;
 b=CEukVPWZmfb6yU7ubE2c1iyGXWtY0d1pq5Dhr77+jJZXtWCIsEHYpkl/gJKi+2A/E1C39w
 zwziWysP7kPKFUDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C862513354;
 Wed,  7 Oct 2026 08:41:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id EzYkGqgFxmokUQAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Wed, 07 Oct 2026 08:41:12 +0000
Message-ID: <ed5bfbcf-f1f5-4466-84c9-b6b7a1d53173@suse.de>
Date: Wed, 7 Oct 2026 10:41:12 +0200
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
 <636a3dc2-fe17-463e-806a-056818656692@suse.de>
 <CAFZQkGxYm_zBe69ecsOwhL7ftXVSPkTz5EUR_iXsAgLBVPd9NA@mail.gmail.com>
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
In-Reply-To: <CAFZQkGxYm_zBe69ecsOwhL7ftXVSPkTz5EUR_iXsAgLBVPd9NA@mail.gmail.com>
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:url, imap1.dmz-prg2.suse.org:helo,
 suse.de:mid]
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

Am 05.10.26 um 16:00 schrieb Xaver Hugl:
>> That's not a policy decision. User space is free to do what ever it
>> wants.  What I have in mind is a hint from the kernel what to do next.
> There's a lot of different ways a commit could be fixed, and telling
> the compositor things like "turn off this plane" wouldn't give the
> compositor any actionable choices except giving up or exactly
> following the hint.
>
> If you meant much higher level things like
> - reduce scanout bandwidth
> - reduce connector bandwidth on this connector
> - do a modeset
>
> that's exactly what the proposed API does.

That's only half of the error codes.

>
> I don't think there's a middle ground between the two, KMS is too
> complex for that.

You don't have to lecture me on the complexity of KMS.  It's actually 
not that complex; it's huge in size, but that's a different problem.


>
>>>>> + * @DRM_MODE_ATOMIC_INVALID_API_USAGE: invallid API usage(DRM_ATOMIC not
>>>>> + *                                  enabled, invalid falg, page_flip event
>>>>> + *                                  with test-only, etc)
>>>> I've seen this being used in the i915 patch for a async flip.  Could
>>>> mean anything there (format, driver specifics).
>>> Its purpose is to catch anything that the compositor is supposed to
>>> know it can't do - using unsupported formats, invalid combinations of
>>> properties (crtc active=1 without a connector), that sort of thing. It
>>> should never be anything driver specific though.
>> I don't see how this could be useful except for the prototype that come
>> with this series.  It's so broad in meaning that it's almost meaningless.
> It's useful because it tells the compositor that the failure is caused
> by an implementation error in the compositor, instead of some driver
> or hardware limitation. It doesn't need to be meaningful outside of
> that, a developer later debugging what went wrong can use the error
> string to figure it out.

The XDC presentation made it sound as if the goal was to improve 
compositor quality of service.  With this series, it sounds more like 
it's for debugging purposes.  Those are distinct problems and I ind it 
confusing. I'd like to suggest to focus on one problem first.


>
>> And error codes don't have to be driver specific to be meaningful. I
>> already brought up DRM's mode-status code as example. They are not
>> specific to any mode, display or hardware. Yet they clearly state what
>> went wrong with the mode.
> I think that only works because the mode isn't specific to any display
> or hardware. Atomic commit failures are often specific to some
> combination of driver, GPU and display.

The display-mode error codes are almost all related to hardware and 
display limitations. They are not related to any specific hardware 
device.  The goal for KMS error reporting should be to to build 
something similar one a wider scope.   Additional details about driver, 
GPU and display are available today. There's no need for more interfaces 
there.


>
>> You could to this with detailed and precise error codes plus the object
>> on which it failed.
> They can never be detailed enough to exactly pinpoint specific edge
> cases, unless you give literally every single return path in every

No. We give every error condition an individual error code; not every 
return path. These are distinct things.

Some examples:

- For planes, the given format and sizes might be unsupported. Those 
would be error codes.

- For the CRTC, most driver's atomic checks tests the mode against the 
hardware limits. Existing display-mode constants tell us what to expect 
there.

- Encoders and connectors often mirror these properties on a lower 
level, such as bus formats, bus transfer rates, etc. They could likely 
reuse some of the error codes.

- Then there are cases where pipeline stages cannot be connected with 
each other. That's another distinct error code.

Apart from these plain atomic states, DRM exposes many settings as typed 
property. These can likely be subsumed under a number of generic error 
codes. For example

- Most properties can have an invalid-value error

- Numeric properties can have additional value-too-low and 
value-too-high errors.

If you have properties that conflict with each other; return a list of 
their ids with a conflicting-values error code.

With all this, user-space compositors have plenty of information to 
create bug reports or try to resolve the problem automatically.

> driver an individual error code. I don't think that is feasible (and
> then that error code would be uAPI).

Yes, the codes will be uAPI. There are already plenty of defines and 
constants everywhere in the kernel's uAPI. There are already >130 errno 
code in the uAPI. If we need another 100 or 200 error codes for KMS, I'd 
be fine with that.


>
>> Filename + line is even worse.  None of this is even close to stable.
>> I'll nak this as much as possible.
> That's the point? It's supposed to be not stable, so it doesn't become uAPI.

You must be new here. Anything that goes through the uAPI channels is 
de-facto uAPI. If a program in user space might rely on it, it cannot be 
changed.

IF you want to get filenames or lines or any other volatile information, 
you can get them via debugfs. It's designated to be unstable.


>
>> I also don't buy the argument about diving through kernel sources. Not
>> doing that should be the goal here because it is what we currently do.
> I don't think that's something you can ever fully get around. Just the
> very hardware specific error cases alone make it impossible.

With KMS, we have been able to build a hardware-neutral interface for 
programming the display pipeline. I don't believe that error codes are a 
special exception from that.

Best regards
Thomas


>
> - Xaver

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Stefan Gaiser, Jochen Jaser, Abhinav Puri, (HRB 36809, AG Nürnberg)


