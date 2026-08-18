Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6C15C5DF70
	for <dri-devel@archiver.kernel.org>; Tue, 18 Aug 2026 07:43:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0CC7410EA1C;
	Tue, 18 Aug 2026 07:43:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="0rhN8dZz";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ZjTTRbl6";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="gNjDo7Ie";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="/WYXEIAM";
	dkim-atps=neutral
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3BA3D10EA1C
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 07:43:05 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0BC588442B;
 Tue, 18 Aug 2026 07:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787038979; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ZxxIhFr0+WjLfYi/Q+3gBwEfA37+0iFMMgEoqEfjA2A=;
 b=0rhN8dZznl03LwJ7NYf5pVYvyZu5jPGFRftTu22VFVvAcAY3ulf3Q7ihT/P1uXpaYAc6nU
 +YwRZCwssR85oZhGSVWOcfvqwPVq3FguplApgXDaR9pCuIXJXek4lH4VY59e3tBJnmlwKW
 Q8nSVQWMj/b2VuRqE68wrAhmM8zgK/4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787038979;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ZxxIhFr0+WjLfYi/Q+3gBwEfA37+0iFMMgEoqEfjA2A=;
 b=ZjTTRbl6/X521ThlFNCL+Zy49EUI16/VAf6++f1jipEWziugZkzkNbevs0Cck4e4Di0f+U
 bLpcD6utaIHMuuDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787038975; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ZxxIhFr0+WjLfYi/Q+3gBwEfA37+0iFMMgEoqEfjA2A=;
 b=gNjDo7IenqJLLOP9BKr4gT/Wr/GqAMIfyTg3DyO6xwhGZfiiFTF5Rpu5HpAptIivJPo/By
 TnrGnzilDSV2QgcDczztdoArjn6fgRCYXDKKWGO1jn8E3OHsMk315wH/Rkx/fzi0gfO7Es
 KIvLZhiWiYi743519Tl+gHxU7POI+vA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787038975;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ZxxIhFr0+WjLfYi/Q+3gBwEfA37+0iFMMgEoqEfjA2A=;
 b=/WYXEIAMwdrx1Fo/NJ84GgRix3t5Sf5clx+pRUuf3ULmLWTTsOVcbAdOorewlcR0oLxb1W
 VUaILZtmCggqTuAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B948522BA;
 Tue, 18 Aug 2026 07:42:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id AFskLP4MhGrNaAAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Tue, 18 Aug 2026 07:42:54 +0000
Message-ID: <35bf3f76-c1fc-41a8-9b88-1b773f337e32@suse.de>
Date: Tue, 18 Aug 2026 09:42:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/ast: DisplayPort edid supports 256 bytes
To: Jammy Huang <jammy_huang@aspeedtech.com>,
 Jani Nikula <jani.nikula@linux.intel.com>, Dave Airlie <airlied@redhat.com>,
 Jocelyn Falempe <jfalempe@redhat.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20260317-upstream_ast_dp_edid-v2-1-31166703c491@aspeedtech.com>
 <2efefedd-a36a-4b3c-a2cd-89db3499ebdb@suse.de>
 <TYZPR06MB6568D830FCFB93A9776333ECF1C22@TYZPR06MB6568.apcprd06.prod.outlook.com>
 <b601f8842b959f6d8a2bd22bf6743dabad6d980c@intel.com>
 <TYZPR06MB65681FB22E654846896F81A4F1C92@TYZPR06MB6568.apcprd06.prod.outlook.com>
 <SI6PR06MB7590EB0C73CC9229B3A867D9F1A62@SI6PR06MB7590.apcprd06.prod.outlook.com>
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
In-Reply-To: <SI6PR06MB7590EB0C73CC9229B3A867D9F1A62@SI6PR06MB7590.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.996]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[];
 FREEMAIL_TO(0.00)[aspeedtech.com,linux.intel.com,redhat.com,kernel.org,gmail.com,ffwll.ch];
 TO_DN_EQ_ADDR_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_SEVEN(0.00)[11]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
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

Hi Jammy

Am 18.08.26 um 08:43 schrieb Jammy Huang:
> Hi Thomas,
>
> I'd like to get your thoughts on Jani's point that the kernel should avoid modifying EDID and instead expose the data as-is to userspace.

I agree with Jani that the EDID should best be unmodified. But I've 
found that returning unprocessed EDID makes other components fail. In 
some cases, such as ast, at least the checksum needs to be corrected.

>
> In practice, most monitors I have encountered only contain two EDID blocks, so simply returning block 0 and block 1 already works for the majority of cases.
>
> Given that, would you agree that it may be acceptable to stop modifying the EDID in the driver and only support the blocks the hardware can actually read now?

AFAIK there's currently no clear way to signal an EOF to the EDID 
parser.  Returning any errno code will make it fail hard.   IMHO that 
next best thing is to zero-out the EDID buffer, so that the parser stops 
silently. (Your v3, I think.) That's also easy enough to revert if/when 
the EDID parser gets a real EOF state.

Best regards
Thomas


>
> Best regards,
> Jammy
>
>> Hi Jani,
>>
>> Thanks for your input. So, your suggestion is go back to return -EIO for block >
>> 1, and stop trying to modify the EDID.
>> In this way, we can handle EDID whose blocks is less than 2.
>>
>> BR,
>> Jammy
>>
>>>> Hi Thomas,
>>>>
>>>> Good catch - returning 0 without writing to buf wasn't safe. But I
>>>> also found that returning -EIO isn't right either:
>>>> _drm_do_get_edid() treats EDID_BLOCK_READ_FAIL as fatal for any
>>>> block index, not just block 0, so that would have discarded the
>>>> whole EDID for any monitor reporting more than one extension.
>>>>
>>>> In v3, for block > 1 I now zero the buffer explicitly and return 0.
>>>> That makes drm_edid's block checker classify it as EDID_BLOCK_ZERO
>>>> instead, which is non-fatal - it gets trimmed via
>>>> edid_filter_invalid_blocks() (extensions count reduced, checksum
>>>> recomputed), and blocks 0 and 1 still come through fine. This also
>>>> directly addresses your point about the buffer not being guaranteed
>>>> zeroed, since we zero it ourselves now.
>>> There's a long-term goal to *not* modify the EDID in kernel, but
>>> rather return even the broken EDID extensions to userspace, if that's what
>> the display has.
>>> There are probably a bunch of hurdles in making that happen, but
>>> intentionally returning zeroed out EDID blocks is just adding another
>> unnecessary hurdle.
>>>
>>> BR,
>>> Jani.
>>>
>>>
>>> --
>>> Jani Nikula, Intel

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, (HRB 36809, AG Nürnberg)


