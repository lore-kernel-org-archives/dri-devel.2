Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C34EEBFD05
	for <dri-devel@archiver.kernel.org>; Mon, 13 Apr 2026 06:59:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8059910E323;
	Mon, 13 Apr 2026 06:59:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="N/7K7luW";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="qT6KZOnS";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="qLqGB1RT";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="JK8ZUUPL";
	dkim-atps=neutral
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8582710E323
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 06:59:24 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E82F36A83A;
 Mon, 13 Apr 2026 06:59:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1776063563; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=bL3Vo15HEvCfhTQ/xDYWG9e0yFLeDsIe2Hwfc4O3WLA=;
 b=N/7K7luW3PnQpn9af/kue21IKT4UcwDFalLL4pUlZwLuAr/tfP4iAj1WAQB8qBBI3ulI1A
 ltG3lSuRLLfGsaaSY7F+KL4Xt4CXdu078/vstL3DmsQjCLioWWVUL1UIWs/6vWeytBd9yn
 HhW57NoIQ1qTARDr1omz+bMtAQ8OXkg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1776063563;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=bL3Vo15HEvCfhTQ/xDYWG9e0yFLeDsIe2Hwfc4O3WLA=;
 b=qT6KZOnSuavLsTJW59zo08MdIA7Ev/iRWdlT5r/NgjG3OT5BsBrksLgeQbOJcoIkgoieTS
 3NwdJYh7OZ83mKDA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=qLqGB1RT;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=JK8ZUUPL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1776063562; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=bL3Vo15HEvCfhTQ/xDYWG9e0yFLeDsIe2Hwfc4O3WLA=;
 b=qLqGB1RTpRT+nGmQrNB/f/5K0Sx1zWrCqbFBkPYE5WIdLyRGXIQEWLWaY5AwAN7eP637l9
 jh6GR8krwWQS3VVXiRFN9i3a1eEbqMXOzDtbH3fi+RGShfAUVJZHzEID3I3Hz4MSWNFiey
 Ufcc67u39AKSbCXPYvorLoIVynbsQhI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1776063562;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=bL3Vo15HEvCfhTQ/xDYWG9e0yFLeDsIe2Hwfc4O3WLA=;
 b=JK8ZUUPLlgX5gDmFTBhjNK8i9ZdzpIAtgo6HkW6+itBLyLMRV9JcdKBrTDeIxUtHz5z7di
 VG8k3en3kBdiANAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9FC9A4AD60;
 Mon, 13 Apr 2026 06:59:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id IyDXJUqU3Gm5MgAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Mon, 13 Apr 2026 06:59:22 +0000
Message-ID: <5ce643a9-59ec-480a-985e-764bf23e2485@suse.de>
Date: Mon, 13 Apr 2026 08:59:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arch: sh: Include <linux/io.h> in dac.h
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 ysato@users.sourceforge.jp, dalias@libc.org, lee@kernel.org,
 danielt@kernel.org, simona.vetter@ffwll.ch
Cc: linux-sh@vger.kernel.org, dri-devel@lists.freedesktop.org,
 kernel test robot <lkp@intel.com>, Jingoo Han <jingoohan1@gmail.com>
References: <20251028170913.16711-1-tzimmermann@suse.de>
 <e2c0c4686908f38858716a1dcf67df7de488fd33.camel@physik.fu-berlin.de>
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
In-Reply-To: <e2c0c4686908f38858716a1dcf67df7de488fd33.camel@physik.fu-berlin.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 FREEMAIL_CC(0.00)[vger.kernel.org,lists.freedesktop.org,intel.com,gmail.com]; 
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 RCPT_COUNT_SEVEN(0.00)[10]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns, suse.de:dkim, suse.de:mid, suse.de:email,
 suse.com:url, intel.com:email]
X-Rspamd-Queue-Id: E82F36A83A
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

Am 12.04.26 um 09:35 schrieb John Paul Adrian Glaubitz:
> Hi Thomas,
>
> On Tue, 2025-10-28 at 18:07 +0100, Thomas Zimmermann wrote:
>> Include <linux/io.h> to avoid depending on <linux/backlight.h> for
>> including it. Declares __raw_readb() and __raw_writeb().
>>
>> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
>> Reported-by: kernel test robot <lkp@intel.com>
>> Closes: https://lore.kernel.org/oe-kbuild-all/202510282206.wI0HrqcK-lkp@intel.com/
>> Fixes: 243ce64b2b37 ("backlight: Do not include <linux/fb.h> in header file")
>> Cc: Thomas Zimmermann <tzimmermann@suse.de>
>> Cc: Daniel Thompson (RISCstar) <danielt@kernel.org>
>> Cc: Simona Vetter <simona.vetter@ffwll.ch>
>> Cc: Lee Jones <lee@kernel.org>
>> Cc: Daniel Thompson <danielt@kernel.org>
>> Cc: Jingoo Han <jingoohan1@gmail.com>
>> Cc: dri-devel@lists.freedesktop.org
>> ---
>> This is fallout from a recent cleanup of the backlight header file. I don't
>> have the option of building or testing this change, though.
>> ---
>>   arch/sh/include/cpu-sh3/cpu/dac.h | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/arch/sh/include/cpu-sh3/cpu/dac.h b/arch/sh/include/cpu-sh3/cpu/dac.h
>> index fd02331608a8..323ec8570bcd 100644
>> --- a/arch/sh/include/cpu-sh3/cpu/dac.h
>> +++ b/arch/sh/include/cpu-sh3/cpu/dac.h
>> @@ -2,6 +2,8 @@
>>   #ifndef __ASM_CPU_SH3_DAC_H
>>   #define __ASM_CPU_SH3_DAC_H
>>   
>> +#include <linux/io.h>
>> +
>>   /*
>>    * Copyright (C) 2003  Andriy Skulysh
>>    */
> I'm just looking at this patch again and was wondering where <linux/backlight.h> is
> actually being pulled in on SH3. I assume this is somewhere on the driver side, no?

Oh well, it's been ages...

I've been cleaning up the plenty of places that include <linux/fb.h> and 
<linux/backlight.h> unnecessarily. Besides the Fixes tag, presumably 
commit df1445598758 ("backlight: hp680_bl: Do not include <linux/fb.h>") 
is involved as well. The hp680_bl backlight driver got <linux/io.h> via 
<linux/fb.h> via <linux/backlight.h> before including <cpu/dac.h>. With 
fb.h gone from backlight.h gone,  dac.h should best include its 
dependencies. Hence the patch here.

Best regards
Thomas



>
> Adrian
>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG Nürnberg)


