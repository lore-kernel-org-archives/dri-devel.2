Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D8A7D3515E
	for <dri-devel@archiver.kernel.org>; Wed,  1 Apr 2026 08:54:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 88E3F10ECA8;
	Wed,  1 Apr 2026 08:54:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="C0fVeUsO";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="P4ROMt1Q";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="C0fVeUsO";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="P4ROMt1Q";
	dkim-atps=neutral
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C270310ECA8
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Apr 2026 08:54:02 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5852B4D2B5;
 Wed,  1 Apr 2026 08:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1775033641; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=o+IX56azF29oXQElIrJw3ZKbvTu0puqydV8fgZCzB8M=;
 b=C0fVeUsOls72Cimzhdvb/rksNEjnmlgZ6zCy+3ll2Dz2Ga7q4KkHyKd4yEmALSmnbqtKOD
 u3jU9RKhXWuW+UQbHgF3NdA3p/3CkkicD+iYrNMYk7rmTp4HLW4rrwolRIVitNdHI5KtAL
 U+AyiMYHiH2GDeC8+HJN4lyFEtePkqE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1775033641;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=o+IX56azF29oXQElIrJw3ZKbvTu0puqydV8fgZCzB8M=;
 b=P4ROMt1QjVMqvm3jyjdx9InzdHPYy+66uqWaNRLECKmO6S0skWI6AaYnQSJrdHP40le+sH
 +GTO/z/YQiwuNZDg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=C0fVeUsO;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=P4ROMt1Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1775033641; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=o+IX56azF29oXQElIrJw3ZKbvTu0puqydV8fgZCzB8M=;
 b=C0fVeUsOls72Cimzhdvb/rksNEjnmlgZ6zCy+3ll2Dz2Ga7q4KkHyKd4yEmALSmnbqtKOD
 u3jU9RKhXWuW+UQbHgF3NdA3p/3CkkicD+iYrNMYk7rmTp4HLW4rrwolRIVitNdHI5KtAL
 U+AyiMYHiH2GDeC8+HJN4lyFEtePkqE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1775033641;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=o+IX56azF29oXQElIrJw3ZKbvTu0puqydV8fgZCzB8M=;
 b=P4ROMt1QjVMqvm3jyjdx9InzdHPYy+66uqWaNRLECKmO6S0skWI6AaYnQSJrdHP40le+sH
 +GTO/z/YQiwuNZDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C5E954A0B0;
 Wed,  1 Apr 2026 08:54:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id y+rkLijdzGlRIQAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Wed, 01 Apr 2026 08:54:00 +0000
Message-ID: <808dcd39-ed04-4288-9b21-55b47354de17@suse.de>
Date: Wed, 1 Apr 2026 10:53:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arch/sh: Drop CONFIG_FIRMWARE_EDID from defconfig files
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 ysato@users.sourceforge.jp, dalias@libc.org, arnd@arndb.de
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org
References: <20260401083242.214492-1-tzimmermann@suse.de>
 <b7c978f9728c1a1197e90a98bcec5e8e4dc7e7ec.camel@physik.fu-berlin.de>
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
In-Reply-To: <b7c978f9728c1a1197e90a98bcec5e8e4dc7e7ec.camel@physik.fu-berlin.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_TLS_ALL(0.00)[]; ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MID_RHS_MATCH_FROM(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_SEVEN(0.00)[7];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:url];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 5852B4D2B5
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

Am 01.04.26 um 10:46 schrieb John Paul Adrian Glaubitz:
> Hi Thomas,
>
> On Wed, 2026-04-01 at 10:32 +0200, Thomas Zimmermann wrote:
>> CONFIG_FIRMWARE_EDID=y depends on X86 or EFI_GENERIC_STUB. Neither is
>> true here, so drop the lines from the defconfig files.
>>
>> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
>> ---
>>   arch/sh/configs/dreamcast_defconfig | 1 -
>>   arch/sh/configs/hp6xx_defconfig     | 1 -
>>   arch/sh/configs/se7343_defconfig    | 1 -
>>   arch/sh/configs/se7780_defconfig    | 1 -
>>   4 files changed, 4 deletions(-)
>>
>> diff --git a/arch/sh/configs/dreamcast_defconfig b/arch/sh/configs/dreamcast_defconfig
>> index dd58797e8298..b31bf17fe112 100644
>> --- a/arch/sh/configs/dreamcast_defconfig
>> +++ b/arch/sh/configs/dreamcast_defconfig
>> @@ -50,7 +50,6 @@ CONFIG_HW_RANDOM=y
>>   CONFIG_WATCHDOG=y
>>   CONFIG_SH_WDT=y
>>   CONFIG_FB=y
>> -CONFIG_FIRMWARE_EDID=y
>>   CONFIG_FB_PVR2=y
>>   CONFIG_FRAMEBUFFER_CONSOLE=y
>>   CONFIG_FONTS=y
>> diff --git a/arch/sh/configs/hp6xx_defconfig b/arch/sh/configs/hp6xx_defconfig
>> index 04a9fcb4342a..b6116a203a27 100644
>> --- a/arch/sh/configs/hp6xx_defconfig
>> +++ b/arch/sh/configs/hp6xx_defconfig
>> @@ -35,7 +35,6 @@ CONFIG_SERIAL_SH_SCI_CONSOLE=y
>>   CONFIG_LEGACY_PTY_COUNT=64
>>   # CONFIG_HWMON is not set
>>   CONFIG_FB=y
>> -CONFIG_FIRMWARE_EDID=y
>>   CONFIG_FB_HIT=y
>>   CONFIG_FB_SH_MOBILE_LCDC=y
>>   CONFIG_FRAMEBUFFER_CONSOLE=y
>> diff --git a/arch/sh/configs/se7343_defconfig b/arch/sh/configs/se7343_defconfig
>> index 2d4d1f974f14..b3ce8a502787 100644
>> --- a/arch/sh/configs/se7343_defconfig
>> +++ b/arch/sh/configs/se7343_defconfig
>> @@ -57,7 +57,6 @@ CONFIG_I2C=y
>>   CONFIG_I2C_SH_MOBILE=y
>>   # CONFIG_HWMON is not set
>>   CONFIG_FB=y
>> -CONFIG_FIRMWARE_EDID=y
>>   CONFIG_FB_SH_MOBILE_LCDC=m
>>   CONFIG_SOUND=y
>>   CONFIG_SND=y
>> diff --git a/arch/sh/configs/se7780_defconfig b/arch/sh/configs/se7780_defconfig
>> index 13fa6a59b8f1..9e96b000cb99 100644
>> --- a/arch/sh/configs/se7780_defconfig
>> +++ b/arch/sh/configs/se7780_defconfig
>> @@ -60,7 +60,6 @@ CONFIG_SERIAL_SH_SCI_CONSOLE=y
>>   # CONFIG_HW_RANDOM is not set
>>   CONFIG_THERMAL=y
>>   CONFIG_FB=y
>> -CONFIG_FIRMWARE_EDID=y
>>   CONFIG_FB_SH_MOBILE_LCDC=m
>>   CONFIG_FRAMEBUFFER_CONSOLE=y
>>   CONFIG_LOGO=y
> Thanks for catching this! I wonder where this configuration entry comes from though.
>
> My SH7785LCR board does have a DVI output as well as a Silicon Motion SM-501 video
> chip though, so I think it should be able to perform EDID in general. Or is the
> protocol actually tied to the x86 architecture? What about monitors on a PowerPC
> workstation, for example? Does EDID not work there at all?

Yes, your system can fetch the EDID via the Linux driver. But 
FIRMWARE_EDID is a special feature where the EDID gets delivered by the 
boot loader. This has always only been possible on x86 or with EFI.

Best regards
Thomas

>
> Thanks,
> Adrian
>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG Nürnberg)


