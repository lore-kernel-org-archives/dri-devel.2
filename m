Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D24C606A33B
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 08:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=CX/yVm9P;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=VuDV4jfq;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=CX/yVm9P;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=VuDV4jfq
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C51110E867;
	Fri, 30 Oct 2026 08:17:19 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 18F53112689
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 08:17:08 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6BBB11F78A;
 Fri, 30 Oct 2026 08:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1793348226; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=+DeEUUoF+rg3YA+i+k4q5r6wcEuBfW48tSNHH8+jgyM=;
 b=CX/yVm9P95JBcYFNbJuMkdA6pXgDhey9Eh5MH90Gfj80KEw6njrEcBZOeeHnSx6gq9zkSW
 qaJPoJSXw5s0yN6Gu0bikOPxT82TpYXcdyhLAxSWOBgdK2Z3mGhl6ipbZ48K6j1bN99m3n
 jSWeqHOVYMYUq1BuIgAg6uHYpBB1jwI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1793348226;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=+DeEUUoF+rg3YA+i+k4q5r6wcEuBfW48tSNHH8+jgyM=;
 b=VuDV4jfqdkeqPvQ4yfRQsCz+FL92NqQp7lwcBmRzXLcRby8ukAVJrljN4M6G53gQrpbPom
 3Wi4P/5ZUvoTaMBA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="CX/yVm9P";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=VuDV4jfq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1793348226; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=+DeEUUoF+rg3YA+i+k4q5r6wcEuBfW48tSNHH8+jgyM=;
 b=CX/yVm9P95JBcYFNbJuMkdA6pXgDhey9Eh5MH90Gfj80KEw6njrEcBZOeeHnSx6gq9zkSW
 qaJPoJSXw5s0yN6Gu0bikOPxT82TpYXcdyhLAxSWOBgdK2Z3mGhl6ipbZ48K6j1bN99m3n
 jSWeqHOVYMYUq1BuIgAg6uHYpBB1jwI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1793348226;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=+DeEUUoF+rg3YA+i+k4q5r6wcEuBfW48tSNHH8+jgyM=;
 b=VuDV4jfqdkeqPvQ4yfRQsCz+FL92NqQp7lwcBmRzXLcRby8ukAVJrljN4M6G53gQrpbPom
 3Wi4P/5ZUvoTaMBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0B45D13419;
 Fri, 30 Oct 2026 08:17:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id FdXSNIFS5GoTEwAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Fri, 30 Oct 2026 08:17:06 +0000
Message-ID: <2790b59c-9b8f-43f9-a4a8-53106906bf98@suse.de>
Date: Fri, 30 Oct 2026 09:17:05 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vga-switcheroo: Allow VGA_SWITCHEROO to be enabled on
 LoongArch
To: zhaotianrui <zhaotianrui@loongson.cn>, David Airlie <airlied@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Simona Vetter <simona@ffwll.ch>,
 chenhuacai@loongson.cn
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 wuqianhai@loongson.cn
References: <20261029013618.3558115-1-zhaotianrui@loongson.cn>
 <5e547172-ac10-4a28-a584-9a385dbe2b80@suse.de>
 <5141c98f-4595-c29e-14b0-8bd324bf8949@loongson.cn>
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
In-Reply-To: <5141c98f-4595-c29e-14b0-8bd324bf8949@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6BBB11F78A
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-13.50 / 50.00]; SUSE_INTERNAL_BYPASS(-9.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 XM_UA_NO_VERSION(0.01)[]; MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FREEMAIL_TO(0.00)[loongson.cn,gmail.com,linux.intel.com,kernel.org,ffwll.ch]; 
 MIME_TRACE(0.00)[0:+]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; DKIM_TRACE(0.00)[suse.de:+];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCVD_TLS_ALL(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_SEVEN(0.00)[9]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,
 imap1.dmz-prg2.suse.org:helo, suse.com:url, suse.de:dkim]
X-Spam-Score: -13.50
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
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi

Am 30.10.26 um 08:04 schrieb zhaotianrui:
>
> 在 2026/10/29 下午4:16, Thomas Zimmermann 写道:
>> Hi
>>
>> Am 29.10.26 um 02:36 schrieb Tianrui Zhao:
>>> LoongArch systems with hybrid graphics (integrated +
>>> discrete GPU) can benefit from the same GPU switching
>>> mechanism that x86 laptops use. Relax the dependency
>>> to allow VGA_SWITCHEROO to be built on LoongArch,
>>> consistent with the existing dependencies on ACPI,
>>> PCI, and FB=y.
>>>
>>> Change-Id: I84d38fdfe5e1591495fb3681474a7f1f64281fa8
>>
>> Internal change ids should be remove before submitting patches.
>>
> Thanks for your review, I will fix this.
>
>
> Best regards
>
> Tianrui Zhao
>
>>> Signed-off-by: Tianrui Zhao <zhaotianrui@loongson.cn>
>>> ---
>>>   drivers/gpu/vga/Kconfig | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/vga/Kconfig b/drivers/gpu/vga/Kconfig
>>> index bad4bcee313..89edd1211aa 100644
>>> --- a/drivers/gpu/vga/Kconfig
>>> +++ b/drivers/gpu/vga/Kconfig
>>> @@ -1,7 +1,7 @@
>>>   # SPDX-License-Identifier: GPL-2.0-only
>>>   config VGA_SWITCHEROO
>>>       bool "Laptop Hybrid Graphics - GPU switching support"
>>> -    depends on X86
>>> +    depends on X86 || LOONGARCH
>>
>> I'm a bit skeptical if that's all there is to do.  Does loongarch 
>> really work with the existing handlers in the graphics drivers 
>> as-is?  See [1] for the interface that implements the actual switching.
>>
>> [1] 
>> https://elixir.bootlin.com/linux/v7.3/source/include/linux/vga_switcheroo.h#L93
>>
>> Best regards
>> Thomas
>>
> Thanks,  I will carefully check whether all these 
> vga_switcheroo_handler callbacks are supported on the LoongArch platform.

Switcheroo used to be required for x86 notebooks from ~2010. Those 
systems had two graphics cards, but only one set of output connectors. 
That design is become rare, I think.

So I'm a bit surprised to see it come back. Which loongarch systems are 
there?

Best regards
Thomas


>
>
> Best regards
>
> Tianrui Zhao
>
>>>       depends on ACPI
>>>       depends on PCI
>>>       depends on FB=y
>>
>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Stefan Gaiser, Jochen Jaser, Abhinav Puri, (HRB 36809, AG Nürnberg)


