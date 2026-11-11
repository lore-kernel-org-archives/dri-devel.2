Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E93C0606A326
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 09:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=OLS1Kzv9;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=eLw2tp8q;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=OLS1Kzv9;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=eLw2tp8q
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4301610FA20;
	Wed, 11 Nov 2026 09:35:47 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B5DCE10FA1A;
 Wed, 11 Nov 2026 09:35:31 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 44E5D1F7BF;
 Wed, 11 Nov 2026 09:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1794389730; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=tatdaV5oo8zvvmhyDR1NT5m5W/wbsTmi+i9/rGo2mTA=;
 b=OLS1Kzv9Rv5l/i75knEotcq3+e9saIikdiabL/7FSVF2xIBpuxT3zOQ+MkQ5TGUof1bQih
 VW/Go1UbeI4GtsEYlv+VD7TGb6BChxV6Or0i0KdTxKR4LotCCmCvO7mGpRiauZhAUxN12h
 N+2YCgkSANJ4zFgNCJOgMtZyu49kaRs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1794389730;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=tatdaV5oo8zvvmhyDR1NT5m5W/wbsTmi+i9/rGo2mTA=;
 b=eLw2tp8q1G1XjDYyuBTLaJ4/z9KpsKdocZYGkUsVJSQf99k9E/Y3DF2Rb4jYzKYAxZ8XqI
 i03rm3viFCixYSDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1794389730; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=tatdaV5oo8zvvmhyDR1NT5m5W/wbsTmi+i9/rGo2mTA=;
 b=OLS1Kzv9Rv5l/i75knEotcq3+e9saIikdiabL/7FSVF2xIBpuxT3zOQ+MkQ5TGUof1bQih
 VW/Go1UbeI4GtsEYlv+VD7TGb6BChxV6Or0i0KdTxKR4LotCCmCvO7mGpRiauZhAUxN12h
 N+2YCgkSANJ4zFgNCJOgMtZyu49kaRs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1794389730;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=tatdaV5oo8zvvmhyDR1NT5m5W/wbsTmi+i9/rGo2mTA=;
 b=eLw2tp8q1G1XjDYyuBTLaJ4/z9KpsKdocZYGkUsVJSQf99k9E/Y3DF2Rb4jYzKYAxZ8XqI
 i03rm3viFCixYSDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CF7231339F;
 Wed, 11 Nov 2026 09:35:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id d7g4H+E29GphWwAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Wed, 11 Nov 2026 09:35:29 +0000
Message-ID: <cd49a9ea-a992-4b38-a5d7-d46d1647010f@suse.de>
Date: Wed, 11 Nov 2026 10:35:29 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] drm/amdgpu,radeon: Inline drm_crtc_init()
To: Alex Deucher <alexdeucher@gmail.com>
Cc: alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com,
 simona@ffwll.ch, maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 sashiko-reviews@lists.linux.dev
References: <20261110120326.538252-1-tzimmermann@suse.de>
 <CADnq5_NCF2J0Dzea5swubs+eEKBLq+8ontc5n=kihYZVA3A1aw@mail.gmail.com>
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
In-Reply-To: <CADnq5_NCF2J0Dzea5swubs+eEKBLq+8ontc5n=kihYZVA3A1aw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-13.29 / 50.00]; SUSE_INTERNAL_BYPASS(-9.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 XM_UA_NO_VERSION(0.01)[]; ARC_NA(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FREEMAIL_TO(0.00)[gmail.com];
 MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FREEMAIL_CC(0.00)[amd.com,gmail.com,ffwll.ch,linux.intel.com,kernel.org,lists.freedesktop.org,lists.linux.dev];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 RCPT_COUNT_SEVEN(0.00)[10]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.com:url,
 suse.de:email]
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
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi

Am 10.11.26 um 22:49 schrieb Alex Deucher:
> On Tue, Nov 10, 2026 at 7:11 AM Thomas Zimmermann <tzimmermann@suse.de> wrote:
>> The helper drm_crtc_init() sets up a CRTC with a primary plane for
>> non-atomic mode setting. Only drivers for some AMD hardware still
>> use it.
>>
>> Inline drm_crtc_init() into amdgpu and radeon and remove it from
>> DRM. All new code implements atomic mode setting, which does not
>> use drm_crtc_init().
>>
> I'd like to drop all of the old amdgpu non-DC code since DC is now the
> default, and we have an LTS kernel now.  I'm planning to send these
> out in the near future:
> https://gitlab.freedesktop.org/agd5f/linux/-/commits/remove-non-dc-display?ref_type=heads

That's even better. :) Do you have an ETA for this work? Resolving 
drm_crtc_init() is required for that series I referred to at [1].


> So that just leaves radeon.

I'll fix the Sashiko report and send this out in a separate patch.

Best regards
Thomas

>
> Alex
>
>> DRM support for kernel panic is only implemented in amdgpu. Take
>> the panic helpers from drm_crtc_init() in amdgpu, but clean it up
>> in radeon.
>>
>> With this series in place, DRM's helpers for drawing panic screens
>> can be further integrated with other drawing helpers, as outlined
>> in [1].
>>
>> Tested on radeon with a Radeon HD 6570.
>>
>> [1] https://lore.kernel.org/dri-devel/20261019154612.777074-1-tzimmermann@suse.de/
>>
>> Thomas Zimmermann (5):
>>    drm/amdgpu: dce_v6_0: Inline drm_crtc_init()
>>    drm/amdgpu: dce_v8_0: Inline drm_crtc_init()
>>    drm/amdgpu: dce_v10_0: Inline drm_crtc_init()
>>    drm/radeon: Inline drm_crtc_init()
>>    drm: Remove drm_crtc_init()
>>
>>   drivers/gpu/drm/amd/amdgpu/dce_v10_0.c  | 44 ++++++++++++++-
>>   drivers/gpu/drm/amd/amdgpu/dce_v6_0.c   | 44 ++++++++++++++-
>>   drivers/gpu/drm/amd/amdgpu/dce_v8_0.c   | 44 ++++++++++++++-
>>   drivers/gpu/drm/drm_crtc.c              | 26 +++------
>>   drivers/gpu/drm/drm_modeset_helper.c    | 74 -------------------------
>>   drivers/gpu/drm/radeon/radeon_display.c | 47 +++++++++++++---
>>   include/drm/drm_modeset_helper.h        |  3 -
>>   include/drm/drm_plane.h                 |  5 --
>>   8 files changed, 170 insertions(+), 117 deletions(-)
>>
>> --
>> 2.56.0
>>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Stefan Gaiser, Jochen Jaser, Abhinav Puri, (HRB 36809, AG Nürnberg)


