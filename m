Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1C45FF8864
	for <dri-devel@archiver.kernel.org>; Wed, 29 Apr 2026 06:40:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B05010E115;
	Wed, 29 Apr 2026 06:40:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="PsUlJ7Zt";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="6Yl91jvq";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="PsUlJ7Zt";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="6Yl91jvq";
	dkim-atps=neutral
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F050D10E115
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Apr 2026 06:40:08 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B26925BD38;
 Wed, 29 Apr 2026 06:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1777444807; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=wb2CT0+vsQ+U0x7l8lO9NhjgtzBOwnqopQ6rEjw1ut8=;
 b=PsUlJ7ZtcGKHbZI/fA59FFPxFIrLPWKaA8WNe4jy5V0FwQu+Grp+QUTP1EPuklkmqajl0I
 TiXhIdRBT6AYuRKsU03f9bZ71gsU5ACqoLuxg5l9FJm8sdAhaZJBej4L4f/rtQWblqoaS+
 6uPjfPLEfQPiHdTiDaFfD5Mr/Dxwqa4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1777444807;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=wb2CT0+vsQ+U0x7l8lO9NhjgtzBOwnqopQ6rEjw1ut8=;
 b=6Yl91jvqDuVxXMS8+7MVCA7BDQCQ3PFd2twbX2R2uZYEWL1BmGpiWhHtooFmHMGMxk/XUD
 oAlBpzCfsBDiATCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1777444807; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=wb2CT0+vsQ+U0x7l8lO9NhjgtzBOwnqopQ6rEjw1ut8=;
 b=PsUlJ7ZtcGKHbZI/fA59FFPxFIrLPWKaA8WNe4jy5V0FwQu+Grp+QUTP1EPuklkmqajl0I
 TiXhIdRBT6AYuRKsU03f9bZ71gsU5ACqoLuxg5l9FJm8sdAhaZJBej4L4f/rtQWblqoaS+
 6uPjfPLEfQPiHdTiDaFfD5Mr/Dxwqa4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1777444807;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=wb2CT0+vsQ+U0x7l8lO9NhjgtzBOwnqopQ6rEjw1ut8=;
 b=6Yl91jvqDuVxXMS8+7MVCA7BDQCQ3PFd2twbX2R2uZYEWL1BmGpiWhHtooFmHMGMxk/XUD
 oAlBpzCfsBDiATCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 803A4593B0;
 Wed, 29 Apr 2026 06:40:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id pAzhHcen8WnhXwAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Wed, 29 Apr 2026 06:40:07 +0000
Message-ID: <be197b30-cade-4217-a641-783b659918b2@suse.de>
Date: Wed, 29 Apr 2026 08:40:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: further issues with MGA G200 graphics chipset
To: stuart hayes <stuart.w.hayes@gmail.com>,
 Jacob Keller <jacob.e.keller@intel.com>,
 Jocelyn Falempe <jfalempe@redhat.com>,
 "airlied@redhat.com" <airlied@redhat.com>
Cc: dri-devel@lists.freedesktop.org,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Pasi Vaananen <pvaanane@redhat.com>
References: <76aba88d-ec23-4b3c-ad91-83face0c3e94@intel.com>
 <a9d176ec-d19b-4f41-af16-cdc4e475a8cc@suse.de>
 <6ec01703-31e0-4998-9508-a5a115ae7bc9@intel.com>
 <14aa4840-29c4-46df-b60d-8e1b92494ad2@redhat.com>
 <e9cca01c-960d-495c-aaba-327eac43cad6@intel.com>
 <a23413a4-f939-4a23-996f-4ba5c8294c59@suse.de>
 <5155f29b-bc4d-4e60-9a26-22d568c43e46@redhat.com>
 <0be82b55-0f78-4ef9-8b50-f068ec36ec4f@suse.de>
 <df849883-f61d-484a-bd4c-32da52473ad3@intel.com>
 <3def4337-4297-45fa-8825-4147abda49f4@suse.de>
 <be1f1005-a7ed-4a5b-904b-35541b19658a@gmail.com>
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
In-Reply-To: <be1f1005-a7ed-4a5b-904b-35541b19658a@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 TO_DN_EQ_ADDR_SOME(0.00)[]; TAGGED_RCPT(0.00)[];
 MIME_TRACE(0.00)[0:+];
 FREEMAIL_TO(0.00)[gmail.com,intel.com,redhat.com];
 MID_RHS_MATCH_FROM(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_SEVEN(0.00)[7]; RCVD_TLS_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid, imap1.dmz-prg2.suse.org:helo,
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

Am 28.04.26 um 21:12 schrieb stuart hayes:
> On 4/27/2026 7:14 AM, Thomas Zimmermann wrote:
>> Hi
>>
>> Am 25.04.26 um 01:29 schrieb Jacob Keller:
>> [...]
>>>>
>>>> So I suggest to pick Manufacturer, Product, Version as key. I'd be
>>>> surprised if we find more than a hand full of systems with the 
>>>> issue. If
>>>> we see a trend or common pattern, we can generalize later on.
>>>>
>>> I think this is the best solution. Keep it focused for now. I believe
>>> Intel has two major platforms that we care about with respect to this
>>> issue. I'll see if I can dig up the data. The systems install the MGA
>>> G200 for BMC use but don't seem to expose the VGA connection.
>>>
>>> For the specific system I have that was faulty, we have the following:
>>>
>>> $ for t in system-manufacturer system-product-name system-version ; \
>>>      do dmidecode -s ${t}; \
>>> done
>>> Dell Inc.
>>> PowerEdge XR8720t
>>> Not Specified
>>>
>>>
>>>
>>> I believe there was also some concern about HP systems which similarly
>>> use this chipset, but I don't have the DMI data for that one off hand.
>>> I've asked some colleagues to confirm the situation and obtain that
>>> data. I'll get back early next week if we think there are any other
>>> systems possibly affected.
>>>
>>> In the mean time, I'm happy to have our team test any patch to confirm
>>> that it behaves as expected and resolves the service interruptions.
>>
>> For now, I've modified the two places that have BMC support in the 
>> driver. Could you please also tell me your system's exact Matrox 
>> chipset or its PCI id?
>>
>> The patch is attached for your testing. It would work against drm-tip 
>> or v7.1-rc1.
>>
>> I've also found the page at [1], which claims that there's a Mini-DP 
>> port at the front. If so, I'd assume that there's also an extra 
>> encoder chip to replace the VGA. If we ever get specs for that, we 
>> could implement real support in the driver.
>>
>> In the meantime, the current fix should work. In the worst case, that 
>> Mini-DP port would give a lower default resolution.
>>
>> [1] https://www.dell.com/en-us/shop/ipovw/poweredge-xr8720t? 
>> hve=shop+now#techspecs_section
>>
>> Best regards
>> Thomas
>>
>>
>
> So this patch disables DDC polling if the dmi_check_system() matches. 
> If this was to happen on systems that _do_ have a physical VGA 
> connector, will that port still be active, just with a resolution that 
> may not be compatible with the monitor that's plugged in?

The DMI test is supposed to only match on affected systems. If there's a 
matched system with a VGA port, or possibly that Mini-DP port, users 
will get a number of bogus display modes at the worst. But the default 
mode is 1024x768, which should work on any display.

>
> I don't see anyone say that the DDC polling doesn't cause too much 
> latency for real time kernels on other systems that do have a VGA 
> connector... did I miss that, or is there a chance that a lot of other 
> systems that use this driver might also have issues with a real time 
> kernel?
That missing VGA port is a problem on any workload. So we fix it as far 
as possible. Where the connector polling interferes with RT, it can also 
be disabled with drm_kms_helper.poll=0. Best regards Thomas
>
>
>>
>>
>>>
>>> Appreciate all the feedback on this thread.
>>>
>>> Thanks,
>>> Jake
>>
>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG Nürnberg)


