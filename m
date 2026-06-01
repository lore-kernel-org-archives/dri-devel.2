Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 267A7CD6E5D
	for <dri-devel@archiver.kernel.org>; Mon,  1 Jun 2026 17:26:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6BA5C11364C;
	Mon,  1 Jun 2026 17:26:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="NHr9OoGy";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="/OKcSWlV";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="NHr9OoGy";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="/OKcSWlV";
	dkim-atps=neutral
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EAE9A113651
 for <dri-devel@lists.freedesktop.org>; Mon,  1 Jun 2026 17:26:55 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 90B7F67F99;
 Mon,  1 Jun 2026 17:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1780334814; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=HKy4O1kmGniKW8NxTOxqSnuJJYfE517bQyDcyVr/iX0=;
 b=NHr9OoGyuoqomWSSOnMgX64z0LUWNaIf9bsSghIigjNy1oFbliM23fmqTXgubc5mCGo/4t
 2OI1JGziNrkf3MHqyCSPO8B/l4oaEZTEU9zYNtizqYv2TdLwDrudbd4F8SeRfaThqexyCK
 eZvyaHTiFOAIlGiD+UtFHh5YKhs6mU0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1780334814;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=HKy4O1kmGniKW8NxTOxqSnuJJYfE517bQyDcyVr/iX0=;
 b=/OKcSWlVVYaCIYT9kBOnZZCn45iSrakNC3VIFJQ2OHP8w09hbSphc8X5UixLl3y409JY5V
 RzRUabuItI/cwMCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1780334814; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=HKy4O1kmGniKW8NxTOxqSnuJJYfE517bQyDcyVr/iX0=;
 b=NHr9OoGyuoqomWSSOnMgX64z0LUWNaIf9bsSghIigjNy1oFbliM23fmqTXgubc5mCGo/4t
 2OI1JGziNrkf3MHqyCSPO8B/l4oaEZTEU9zYNtizqYv2TdLwDrudbd4F8SeRfaThqexyCK
 eZvyaHTiFOAIlGiD+UtFHh5YKhs6mU0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1780334814;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=HKy4O1kmGniKW8NxTOxqSnuJJYfE517bQyDcyVr/iX0=;
 b=/OKcSWlVVYaCIYT9kBOnZZCn45iSrakNC3VIFJQ2OHP8w09hbSphc8X5UixLl3y409JY5V
 RzRUabuItI/cwMCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3741F779A7;
 Mon,  1 Jun 2026 17:26:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Hxm0C97AHWo3NgAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Mon, 01 Jun 2026 17:26:54 +0000
Message-ID: <24042986-6ef1-49a2-a060-aabf6e189473@suse.de>
Date: Mon, 1 Jun 2026 19:26:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL] drm-misc-fixes
To: Jani Nikula <jani.nikula@linux.intel.com>, Dave Airlie
 <airlied@gmail.com>, Simona Vetter <simona.vetter@ffwll.ch>
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, Rodrigo Vivi
 <rodrigo.vivi@intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Matthew Brost <matthew.brost@intel.com>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Oded Gabbay <ogabbay@kernel.org>, dri-devel@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dim-tools@lists.freedesktop.org
References: <20260529070009.GA313534@linux.fritz.box>
 <ddf0233e50044059c85279f928661563ef6a55bf@intel.com>
 <e1a2cc27fb04a88be23973d3cb7868f3d4471d0d@intel.com>
 <d479f1185cd1ae6eb52a7d44e944408c3447c8e4@intel.com>
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
In-Reply-To: <d479f1185cd1ae6eb52a7d44e944408c3447c8e4@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.984]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCPT_COUNT_TWELVE(0.00)[15];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_TRACE(0.00)[0:+];
 FREEMAIL_TO(0.00)[linux.intel.com,gmail.com,ffwll.ch];
 URIBL_BLOCKED(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo,suse.com:url,intel.com:email];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; RCVD_TLS_ALL(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email, suse.de:mid,
 imap1.dmz-prg2.suse.org:helo, suse.com:url, intel.com:email]
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

Am 01.06.26 um 17:49 schrieb Jani Nikula:
> On Mon, 01 Jun 2026, Jani Nikula <jani.nikula@linux.intel.com> wrote:
>> On Mon, 01 Jun 2026, Jani Nikula <jani.nikula@linux.intel.com> wrote:
>>> On Fri, 29 May 2026, Thomas Zimmermann <tzimmermann@suse.de> wrote:
>>>> Rajat Gupta (1):
>>>>        drm: prevent integer overflows in dumb buffer creation helpers
>>> Looks like this commit 5ab62dd3687b ("drm: prevent integer overflows in
>>> dumb buffer creation helpers") regressed in our CI, awaiting
>>> confirmation.

That CI report is where?

>> The IGT test kms_big_fb uses max width and height from GetResources, and
>> i915 and xe use max_width 16384 and max_height 16384 in mode config.
>>
>> The regressing commit adds random hard limits not based on anything:
>>
>> +       /* Reject unreasonable inputs early.  Dumb buffers are for software
>> +        * rendering; nothing legitimate needs more than 8192x8192 at 32bpp.
>> +        * This prevents overflows in downstream alignment helpers.
>> +        */
>> +       if (args->width >= 8192 || args->height >= 8192 || args->bpp > 32)
>> +               return -EINVAL;
>>
>> This is now in v7.1-rc6. Please revert ASAP.
> Ah, missed this clue in the pull request:
>
> On Fri, 29 May 2026, Thomas Zimmermann <tzimmermann@suse.de> wrote:
>> here is this week's PR from drm-misc-fixes. There's one cross-subsys
>> commit to the dma-buf code. Commit 5ab62dd3687b ("drm: prevent integer
>> overflows in dumb buffer creation helpers") has not Link tag because
>> it went through the security list.
> We have the whole review and CI processes in place to catch silly
> mistakes, and then we proceed to shoot ourselves in the foot and bypass
> all of that because "security", and expedite the regressions
> everywhere. I'll bet this will be in stable kernels in no time too. This
> is stupid.

Indeed. But that's how this fix got in.

It fixes a possible overflow elsewhere and using dumb buffers with 
higher values that given here is questionable. Instead of outright 
reverting this, let's first look what actually broke.

Best regards
Thomas

>
> Please also read [1] with its recent updates.
>
>
> BR,
> Jani.
>
>
> [1] https://docs.kernel.org/process/security-bugs.html#what-qualifies-as-a-security-bug
>
>
>>
>> BR,
>> Jani.
>>
>>
>>> No matter what, it's immediately suspect because AFAICT it was not
>>> posted on the lists, and the commit doesn't have a Link: trailer
>>> pointing at the patch.
>>>
>>> This is not how we're supposed to roll. What's going on?
>>>
>>>
>>> BR,
>>> Jani.

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG Nürnberg)


