Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4B0D109C04D
	for <dri-devel@archiver.kernel.org>; Wed, 25 Mar 2026 18:12:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B3FB10E8E0;
	Wed, 25 Mar 2026 18:12:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="AZRGGGjB";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="CjFFBLhE";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="qy3VrHY/";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="VJwnAzuT";
	dkim-atps=neutral
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 54BF410E8E0
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 18:12:13 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id EA1814D26E;
 Wed, 25 Mar 2026 18:12:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1774462332; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=opQ+HU2+Lj+mjTSpUh79mph5xhuPaJJBS3gcPzghQLE=;
 b=AZRGGGjBQeIhTBsux5gT+zlnYzU6pMqv1YHCuZMCwAx28JLupRIV9Wdg4AuhnzyP+f0f+r
 BRe1wxTDzSH0iU3i4uSAM6kBmhchOQ2FH8Ah7Av7vR0G6YxjVSLHh/VbWIS0yrKlRVyPCP
 xWCiJ4hDe5xSYvqg4WKN/UzZgq4IPcs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1774462332;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=opQ+HU2+Lj+mjTSpUh79mph5xhuPaJJBS3gcPzghQLE=;
 b=CjFFBLhEwJ55/W79H+mH5XuTCDJmFrWv3T80XzUmSuNP2kbMAeHjNscyQGUhfuZUcjzROs
 hiXy4i9JOMcBHxDg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="qy3VrHY/";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=VJwnAzuT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1774462331; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=opQ+HU2+Lj+mjTSpUh79mph5xhuPaJJBS3gcPzghQLE=;
 b=qy3VrHY/LSM61s7zwmnTkZBEuukK8LlaSYQ5RLz0zJnKf4I2zUysf0/AJ5iqPCqDXPdC28
 Mwx5fZInNN75ZNzgXQgrXz1FkKDvKSIdY+vpFldB00QiHErAl2gRTXtLeVn8oRCfkGuErv
 IdaFta63sUt+QhVrFtlfXNwmLsMBlHg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1774462331;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=opQ+HU2+Lj+mjTSpUh79mph5xhuPaJJBS3gcPzghQLE=;
 b=VJwnAzuTmjIldDgksQVgoFxgXXntO348YSwA+TvuKp0KLkAOYWqlNK53q2rTWQZpLy3ETb
 TmgLL185NO1W/NBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A9E0544527;
 Wed, 25 Mar 2026 18:12:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id +kK/J3slxGlgMAAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Wed, 25 Mar 2026 18:12:11 +0000
Message-ID: <a71cc09f-8eb8-4fa1-8b0b-d0a10ad1aa38@suse.de>
Date: Wed, 25 Mar 2026 19:12:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/15] drm/ast: Use constants for AHBC registers
To: Jocelyn Falempe <jfalempe@redhat.com>, airlied@redhat.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, airlied@gmail.com,
 simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org
References: <20260323160407.245773-1-tzimmermann@suse.de>
 <20260323160407.245773-4-tzimmermann@suse.de>
 <a5b1cc89-8d52-4f4b-93f6-a3429e49d281@redhat.com>
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
In-Reply-To: <a5b1cc89-8d52-4f4b-93f6-a3429e49d281@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCPT_COUNT_SEVEN(0.00)[7];
 MIME_TRACE(0.00)[0:+]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 FREEMAIL_TO(0.00)[redhat.com,linux.intel.com,kernel.org,gmail.com,ffwll.ch];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:mid,suse.de:email,suse.com:url];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: EA1814D26E
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

Am 25.03.26 um 17:03 schrieb Jocelyn Falempe:
> On 23/03/2026 16:56, Thomas Zimmermann wrote:
>> AHBC is the Advanced High-Speed Bus Controller. AHBC registers are
>> located in the memory range within [0x1e600000, 0x1e61ffff]. Refer
>> to them with constants named AST_REG_AHBC<n>, where <n> is the byte
>> offset into the range.
>
> I think adding a macro AST_REG_AHBC84 doesn't provide more information 
> over using directly AST_REG_AHBC(0x84).

I thought about using the latter only. But then I choose the constants, 
such as AHBC84, as they are directly grep-able in the documentation. 
They also seem a bit safer against typos, such as AHBC84 vs AHBC48.

Best regards
Thomas



>
> Reviewed-by: Jocelyn Falempe <jfalempe@redhat.com>
>
>>
>> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
>> ---
>>   drivers/gpu/drm/ast/ast_2500.c |  6 +++---
>>   drivers/gpu/drm/ast/ast_reg.h  | 11 +++++++++++
>>   2 files changed, 14 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/ast/ast_2500.c 
>> b/drivers/gpu/drm/ast/ast_2500.c
>> index 2a52af0ded56..f751a27e7eb3 100644
>> --- a/drivers/gpu/drm/ast/ast_2500.c
>> +++ b/drivers/gpu/drm/ast/ast_2500.c
>> @@ -109,9 +109,9 @@ void ast_2500_patch_ahb(void __iomem *regs)
>>       u32 data;
>>         /* Clear bus lock condition */
>> -    __ast_moutdwm(regs, 0x1e600000, 0xAEED1A03);
>> -    __ast_moutdwm(regs, 0x1e600084, 0x00010000);
>> -    __ast_moutdwm(regs, 0x1e600088, 0x00000000);
>> +    __ast_moutdwm(regs, AST_REG_AHBC00, AST_REG_AHBC00_PROTECT_KEY);
>> +    __ast_moutdwm(regs, AST_REG_AHBC84, 0x00010000);
>> +    __ast_moutdwm(regs, AST_REG_AHBC88, 0x00000000);
>>       __ast_moutdwm(regs, 0x1e6e2000, 0x1688A8A8);
>>         data = __ast_mindwm(regs, 0x1e6e2070);
>> diff --git a/drivers/gpu/drm/ast/ast_reg.h 
>> b/drivers/gpu/drm/ast/ast_reg.h
>> index ca9403efc7f9..0bc033dbac55 100644
>> --- a/drivers/gpu/drm/ast/ast_reg.h
>> +++ b/drivers/gpu/drm/ast/ast_reg.h
>> @@ -87,4 +87,15 @@
>>   #define AST_REG_P2A04                AST_REG_P2A(0xf004)
>>   #define AST_REG_P2A04_BASE_MASK            GENMASK(31, 16)
>>   +/*
>> + * AHB Controller (0x1e600000 - 0x1e61ffff)
>> + */
>> +
>> +#define AST_REG_AHBC_BASE            (0x1e600000)
>> +#define AST_REG_AHBC(__offset)            (AST_REG_AHBC_BASE + 
>> (__offset))
>> +#define AST_REG_AHBC00                AST_REG_AHBC(0x00)
>> +#define AST_REG_AHBC00_PROTECT_KEY        (0xaeed1a03)
>> +#define AST_REG_AHBC84                AST_REG_AHBC(0x84)
>> +#define AST_REG_AHBC88                AST_REG_AHBC(0x88)
>> +
>>   #endif
>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG Nürnberg)


