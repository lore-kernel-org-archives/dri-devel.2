Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A710106FD9B
	for <dri-devel@archiver.kernel.org>; Fri, 13 Mar 2026 08:05:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6578010EB04;
	Fri, 13 Mar 2026 08:05:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="k0/U7qPr";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="WHNl+i3L";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="k0/U7qPr";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="WHNl+i3L";
	dkim-atps=neutral
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5014110EB0D
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 08:05:51 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 04A1D5CF67;
 Fri, 13 Mar 2026 08:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1773389150; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=AHSzBx8Sp2CA1ylTiV1aSxbK83Xw7Yg23wR0cTZ/wEo=;
 b=k0/U7qPr4o4hWNFTtCtUwcCwqbSEhAtbukaHEnmUEy0XlRSOC97rtFqUoP/cCfQV+Kx+Ew
 PlAo7/0zZ7Ew9pDbXLVWby2mI6zQ8bGqntgiMe0ExEmHXum5reMcYhpWWvkCAiUY4F6jZJ
 JsKGQmqg961vK43Ph4sGApovK08cDRY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1773389150;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=AHSzBx8Sp2CA1ylTiV1aSxbK83Xw7Yg23wR0cTZ/wEo=;
 b=WHNl+i3LlqWXPVOLeeASYlU43EhVcJc3WKtCCatxP8y9Ah5YtOlu6+oIqHaTZKSyYZc8ok
 qgaCn6XuzvGbOfCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1773389150; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=AHSzBx8Sp2CA1ylTiV1aSxbK83Xw7Yg23wR0cTZ/wEo=;
 b=k0/U7qPr4o4hWNFTtCtUwcCwqbSEhAtbukaHEnmUEy0XlRSOC97rtFqUoP/cCfQV+Kx+Ew
 PlAo7/0zZ7Ew9pDbXLVWby2mI6zQ8bGqntgiMe0ExEmHXum5reMcYhpWWvkCAiUY4F6jZJ
 JsKGQmqg961vK43Ph4sGApovK08cDRY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1773389150;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=AHSzBx8Sp2CA1ylTiV1aSxbK83Xw7Yg23wR0cTZ/wEo=;
 b=WHNl+i3LlqWXPVOLeeASYlU43EhVcJc3WKtCCatxP8y9Ah5YtOlu6+oIqHaTZKSyYZc8ok
 qgaCn6XuzvGbOfCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B893940408;
 Fri, 13 Mar 2026 08:05:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id HnqcK13Fs2mcKgAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Fri, 13 Mar 2026 08:05:49 +0000
Message-ID: <4f06f63c-7ab6-42b7-9789-13c929c64db3@suse.de>
Date: Fri, 13 Mar 2026 09:05:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] fbdev/hga: Request memory region before ioremap
To: Helge Deller <deller@gmx.de>, Hardik Phalet <hardik.phalet@pm.me>,
 Ferenc Bakonyi <fero@drama.obuda.kando.hu>
Cc: Shuah Khan <skhan@linuxfoundation.org>,
 Brigham Campbell <me@brighamcampbell.com>, linux-nvidia@lists.surfsouth.com,
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260310123004.888132-1-hardik.phalet@pm.me>
 <3d58e520-0308-44c7-a43a-e438548e9c40@suse.de>
 <DH0W99FBZJEX.30MPSPJVGV4ZF@pm.me>
 <afd8b00d-42fa-4eb7-b18e-302d3f7cadf7@suse.de>
 <100ea3bc-d7a2-45c5-982f-5dc5fd27163b@gmx.de>
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
In-Reply-To: <100ea3bc-d7a2-45c5-982f-5dc5fd27163b@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.993]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_TRACE(0.00)[0:+];
 FREEMAIL_TO(0.00)[gmx.de,pm.me,drama.obuda.kando.hu];
 RCVD_TLS_ALL(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmx.de];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; RCPT_COUNT_SEVEN(0.00)[9];
 MID_RHS_MATCH_FROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.de:mid,
 suse.com:url]
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

Am 12.03.26 um 20:47 schrieb Helge Deller:
> On 3/12/26 16:10, Thomas Zimmermann wrote:
>> Am 12.03.26 um 16:04 schrieb Hardik Phalet:
>>> On Tue Mar 10, 2026 at 6:38 PM IST, Thomas Zimmermann wrote:
>>>> Hi,
>>>>
>>>> thanks for the patch. Let's hope there are no conflicts with other
>>>> hardware.  IDK if anyone still uses this driver.
>>> Hi Thomas,
>>>
>>> Thanks for reviewing this.
>>>
>>> Since I currently do not have access to the hardware needed to test the
>>> change properly, I will drop this patch for now. I may revisit it 
>>> once I
>>> can validate the behavior on real hardware.
>>
>> Good luck. That's the Hercules framebuffer driver. Finding such
>> ancient hardware that can run modern Linux is nigh impossible.
>>
>> But we can merge the patch. If it breaks anyone's setup, they will 
>> send a bug report.
>>
>> Helge will pick up the fix if he's ok with it.
>
> No, I don't want to merge such patches any longer without any testing
> on real hardware. There is no actual problem (else someone would have 
> reported),
> as such I don't see a benefit to apply it. Applying it just brings the 
> risk
> that we break it for someone.
> So, NAK.
>
> I believe I wrote about my opinion already in another patch?

Sorry, I wasn't aware.

> I think we should rephrase that specific TODO item (which mentions the 
> memory
> region allocation) that only patches which have been tested are accepted.

There will likely no one show up here for testing unless it breaks there 
system. Which you won't know until you merge the patch.

If only pre-tested patches can go in, we should make a serious effort to 
remove drivers from fbdev. Because otherwise the driver code just sits 
around as liability.

Aggressively moving fbdev drivers into staging would be a good start IMHO.

Best regards
Thomas

>
> Helge

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG Nürnberg)


