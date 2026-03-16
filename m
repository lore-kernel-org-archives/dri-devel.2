Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DEEAEFCBD4
	for <dri-devel@archiver.kernel.org>; Mon, 16 Mar 2026 08:13:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0688610E268;
	Mon, 16 Mar 2026 08:13:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="IlMIFwUj";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="xpifF6fe";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="lx5weScJ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ZwSM+o1R";
	dkim-atps=neutral
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5434810E268
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 08:13:30 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id CFE574D23C;
 Mon, 16 Mar 2026 08:13:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1773648809; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=tR76hhd8NlYMq2qEX6+mdC6G2TYttd21nlR58QsOPNQ=;
 b=IlMIFwUj9pUI0z9XOcWf7NEh7KCfWdbamSLlkBkQShOYDtyPx2ieNyVcyWre6/U+t4pZZW
 59eAZ6WvhYyMQFzNzfEBIxwTO/KS8D6XIt0uNrNnTS8SE4FLlI14qkstxfrLE4barlXUJ/
 gmEEqS0kiRZIO/oF8HP937WDnJ32oPU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1773648809;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=tR76hhd8NlYMq2qEX6+mdC6G2TYttd21nlR58QsOPNQ=;
 b=xpifF6fe/n5TgHfmngRE1k/vosW8FxRqlVgPFJuoDaXzCFRKaB63RhETNujV/kiiMGhj8k
 KnjQpyWh3NFaXyDw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=lx5weScJ;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=ZwSM+o1R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1773648808; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=tR76hhd8NlYMq2qEX6+mdC6G2TYttd21nlR58QsOPNQ=;
 b=lx5weScJ5sh1WWtMaOKPegGE+TSuBNMm5lIkRvoPT4LesXiAn/9mv0R7OeMWPaS+ZWLjor
 sVw9b4vyUJC+kIMpeelGQOnkmt+zbTokoBU+FaUOEuvdpgds6VkjJkP5S97jjQNpYD4TVD
 cMHO6eHUviZGZOWbXxDwAgs8Xl9WxqI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1773648808;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=tR76hhd8NlYMq2qEX6+mdC6G2TYttd21nlR58QsOPNQ=;
 b=ZwSM+o1RAtUiCdNjhkybogTH4iMIs3+P+xYmLJ7DGqA2K9mEux4yEe/XNCcEG4oSyD2LZg
 8iKKDOmDCwBqO5BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9199F4273B;
 Mon, 16 Mar 2026 08:13:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 4jghIqi7t2liSwAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Mon, 16 Mar 2026 08:13:28 +0000
Message-ID: <67c28da0-c635-4068-b985-bbe5e3d2b5bd@suse.de>
Date: Mon, 16 Mar 2026 09:13:28 +0100
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
 <4f06f63c-7ab6-42b7-9789-13c929c64db3@suse.de>
 <e9580f2e-19e2-4e82-b041-afe4cf9fb301@gmx.de>
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
In-Reply-To: <e9580f2e-19e2-4e82-b041-afe4cf9fb301@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 TO_DN_SOME(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 FREEMAIL_TO(0.00)[gmx.de,pm.me,drama.obuda.kando.hu];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmx.de];
 DKIM_TRACE(0.00)[suse.de:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 RCPT_COUNT_SEVEN(0.00)[9]; MID_RHS_MATCH_FROM(0.00)[];
 ASN(0.00)[asn:32098, ipnet:2800::/6, country:US];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:url, imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns, suse.de:dkim, suse.de:mid]
X-Rspamd-Queue-Id: CFE574D23C
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

Am 13.03.26 um 13:50 schrieb Helge Deller:
> Hi Thomas,
>
> On 3/13/26 09:05, Thomas Zimmermann wrote:
>> Am 12.03.26 um 20:47 schrieb Helge Deller:
>>> On 3/12/26 16:10, Thomas Zimmermann wrote:
>>>> Am 12.03.26 um 16:04 schrieb Hardik Phalet:
>>>>> On Tue Mar 10, 2026 at 6:38 PM IST, Thomas Zimmermann wrote:
>>>>>> Hi,
>>>>>>
>>>>>> thanks for the patch. Let's hope there are no conflicts with other
>>>>>> hardware.  IDK if anyone still uses this driver.
>>>>> Hi Thomas,
>>>>>
>>>>> Thanks for reviewing this.
>>>>>
>>>>> Since I currently do not have access to the hardware needed to 
>>>>> test the
>>>>> change properly, I will drop this patch for now. I may revisit it 
>>>>> once I
>>>>> can validate the behavior on real hardware.
>>>>
>>>> Good luck. That's the Hercules framebuffer driver. Finding such
>>>> ancient hardware that can run modern Linux is nigh impossible.
>>>>
>>>> But we can merge the patch. If it breaks anyone's setup, they will 
>>>> send a bug report.
>>>>
>>>> Helge will pick up the fix if he's ok with it.
>>>
>>> No, I don't want to merge such patches any longer without any testing
>>> on real hardware. There is no actual problem (else someone would 
>>> have reported),
>>> as such I don't see a benefit to apply it. Applying it just brings 
>>> the risk
>>> that we break it for someone.
>>> So, NAK.
>>>
>>> I believe I wrote about my opinion already in another patch?
>>
>> Sorry, I wasn't aware.
>>
>>> I think we should rephrase that specific TODO item (which mentions 
>>> the memory
>>> region allocation) that only patches which have been tested are 
>>> accepted.
>>
>> There will likely no one show up here for testing unless it breaks
>> there system. Which you won't know until you merge the patch.
>
> No-one likes to merge unnecessary patches which highly potentially
> introduce malfunctioning and haven't been tested at all.
>
>> If only pre-tested patches can go in,
>
> You misunderstand.
> I'm still happy to take *any* patches for fbdev.
> Even untested ones if they
> a) seem necessary (e.g. bugfix), or
> b) seem beneficial (code cleanup)
> as long as they don't break the driver. This patch may break the driver.

Any patch falling under a) or b) may break a driver. The patch at hand 
isn't even particularly fragile. People keep posting clean-up patches 
for some of the fbdev drivers and I doubt that most of them have seen 
any testing.

My point here is that if a patch breaks the driver then someone will 
show up and report the regression. If you operate under the (implicit) 
assumption that the driver breaks without anyone reporting the 
regression, the corollary is that the driver is unused.  And so should 
be removed. I suspect this is the case for a lot of fbdev drivers. Hence 
we should make a push to get drivers removed.

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


