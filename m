Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23A67D58CDC
	for <dri-devel@archiver.kernel.org>; Mon, 23 Mar 2026 07:10:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 83C8310E278;
	Mon, 23 Mar 2026 07:10:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="oFqdWiQi";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="SBkocd4i";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="I1YtCDHG";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Lpl2koVI";
	dkim-atps=neutral
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 49E7410E278
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 07:10:11 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id EAA054D356;
 Mon, 23 Mar 2026 07:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1774249810; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=eUwWlNwu0kpdEz9AAj6qLEmtbbG3b98gGCJ/009iVr8=;
 b=oFqdWiQiBZnym9Wh6i61YLYUYGbcyAMiASqDLk0sqgW9+5Z7e8oLjukuVLhi/1H24H60oB
 azFiiPtObhGFlpLoGrKVbrAH8ppgudmXwl7NVkA+zxuTA1brLSXMmjwo7knzhQhIo/cqPS
 nqMtyt3NfLaz4C4NnArPcKH9IPifiVs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1774249810;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=eUwWlNwu0kpdEz9AAj6qLEmtbbG3b98gGCJ/009iVr8=;
 b=SBkocd4ilLp+eLeAn8y2UYeYaIoY99/lrEWMPc+jRSbmtSdVJksv29EvczzUipwOoWUWDv
 Mzi1x7s3i2OBs8BQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=I1YtCDHG;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Lpl2koVI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1774249808; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=eUwWlNwu0kpdEz9AAj6qLEmtbbG3b98gGCJ/009iVr8=;
 b=I1YtCDHGqj1cjh3AxRFEljLLoJRyvhqYT3a8HvA6hri72wxF29cr0cthoaXXvdciYmIIlc
 gvovVVgWw6325pbJhuwfb1sxqNIbz1oMQTi1DBQ7EhiApyc7QYtu8wlDKI9+omMprwG1i9
 wY1jVDZPEfeY4wGXc1Qryji2Jxkgl38=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1774249808;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=eUwWlNwu0kpdEz9AAj6qLEmtbbG3b98gGCJ/009iVr8=;
 b=Lpl2koVIZuwzyyKrjcmS6iUxPj/0Yrs1puAYNONeJRrXYzhWlTwpz5GDCpjMUgIeUi8C2K
 NE8mYBUkSf3opKAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9B87743753;
 Mon, 23 Mar 2026 07:10:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 2RChJFDnwGnkTgAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Mon, 23 Mar 2026 07:10:08 +0000
Message-ID: <0a2c69f8-f849-4cbd-95e2-e2bddb781451@suse.de>
Date: Mon, 23 Mar 2026 08:10:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/loongson: stop to set get_vblank_timestamp for
 LS7A1000 CRTC
To: Icenowy Zheng <zhengxingda@iscas.ac.cn>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Jianmin Lv <lvjianmin@loongson.cn>,
 Qianhai Wu <wuqianhai@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>,
 Mingcong Bai <jeffbai@aosc.io>, Xi Ruoyao <xry111@xry111.site>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260321092804.3519447-1-zhengxingda@iscas.ac.cn>
 <47337244ebd0ce4efd3e065183e863421925f99f.camel@iscas.ac.cn>
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
In-Reply-To: <47337244ebd0ce4efd3e065183e863421925f99f.camel@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 FREEMAIL_TO(0.00)[iscas.ac.cn,linux.intel.com,kernel.org,gmail.com,ffwll.ch,loongson.cn,aosc.io,xry111.site];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_TWELVE(0.00)[12];
 MIME_TRACE(0.00)[0:+]; MID_RHS_MATCH_FROM(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:url,iscas.ac.cn:email,suse.de:dkim,suse.de:mid,suse.de:email];
 URIBL_BLOCKED(0.00)[suse.de:dkim,suse.de:mid,suse.de:email,suse.com:url,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: EAA054D356
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

Am 21.03.26 um 10:29 schrieb Icenowy Zheng:
> 在 2026-03-21六的 17:28 +0800，Icenowy Zheng写道：
>> As there's no known hardware capability about querying vblank on the
>> LS7A1000 display controller, setting get_vblank_timestamp will
>> mislead the
>> kernel about the support of DC-backed high precision vblank query.
>>
>> Drop this function pointer in the CRTC function table for LS7A1000.
>>
>> This solves a kernel warning when booting Linux 7.0-rc3 on a
>> Loongson-3A4000+LS7A1000 Haier Boyue G51 laptop (with injected EDID
>> for
>> replicating the display timing set by the firmware).
>>
>> Signed-off-by: Icenowy Zheng <zhengxingda@iscas.ac.cn>
> Oh forgot to attach when crafting v2:
>
> ```
> Acked-by: Thomas Zimmermann <tzimmermann@suse.de>
> ```

I just want to add that the a-b was given wrt. the correctness of the 
source-code changes.  But now it seems that the hardware does support 
the vblank timestamp, (?) so removing the callback might not be the best 
thing.

Best regards
Thomas

>
>> ---
>> Changes in v2:
>> - Re-formatted Loongson product model numbers per request from
>> Huacai.
>>
>>   drivers/gpu/drm/loongson/lsdc_crtc.c | 1 -
>>   1 file changed, 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/loongson/lsdc_crtc.c
>> b/drivers/gpu/drm/loongson/lsdc_crtc.c
>> index 587fbe285e9ef..b3af8e0cdb15f 100644
>> --- a/drivers/gpu/drm/loongson/lsdc_crtc.c
>> +++ b/drivers/gpu/drm/loongson/lsdc_crtc.c
>> @@ -721,7 +721,6 @@ static const struct drm_crtc_funcs
>> ls7a1000_crtc_funcs = {
>>   	.late_register = lsdc_crtc_late_register,
>>   	.enable_vblank = lsdc_crtc_enable_vblank,
>>   	.disable_vblank = lsdc_crtc_disable_vblank,
>> -	.get_vblank_timestamp =
>> drm_crtc_vblank_helper_get_vblank_timestamp,
>>   	.atomic_print_state = lsdc_crtc_atomic_print_state,
>>   };
>>   

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG Nürnberg)


