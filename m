Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D2ABEC01BE
	for <dri-devel@archiver.kernel.org>; Mon, 23 Mar 2026 10:31:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 788AA10E4C2;
	Mon, 23 Mar 2026 10:31:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="bJSZgVDd";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Vw5N9Pna";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="RTloiZkP";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="GZa1RC0t";
	dkim-atps=neutral
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F2EC10E4C2
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 10:31:30 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id ECFF94D2BA;
 Mon, 23 Mar 2026 10:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1774261889; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=D8OFoIu8D2/SWGVd/MWU9po7l08YDH5G/UDUB3ecxo0=;
 b=bJSZgVDd1qcShAfkBZez6IoqTpGM7ED2fP8fMtgOeSh7VPO5nN4DzQ4GH3Zk9LXyGFBIKa
 9KDR1AF44xqo6y9q5lj00Tjpf3U6fcT5XmC1JrwJkD8dBpoxxY69JiowhRyhEUZqwz8sy9
 Uc2lg4U3aFhPivKzlsqkrs1TUT83Pp4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1774261889;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=D8OFoIu8D2/SWGVd/MWU9po7l08YDH5G/UDUB3ecxo0=;
 b=Vw5N9PnafCmcsaKOPAgw9zYk3FOLD4AmzaKSjaCfM0IHsCgUvxXqlqjR8uNQl2ORs1Cjde
 ADrxdTkT9DsdYzAQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=RTloiZkP;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=GZa1RC0t
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1774261888; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=D8OFoIu8D2/SWGVd/MWU9po7l08YDH5G/UDUB3ecxo0=;
 b=RTloiZkPNe2KC7/XWXX9B5+R0J0GK4U0gmS4JGzv95QhDB3L/zr/pf3r+qMy1mqiEVPtzh
 S0+fgRh2F4iKPh7rYqvvWau4Q/JCqX+sUmGuSUpoXO8RGF5abTccxcMxZLB0l3Qt3dEcst
 S3MPoyV6RxkaMYC99A6kNE0McmDrf0E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1774261888;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=D8OFoIu8D2/SWGVd/MWU9po7l08YDH5G/UDUB3ecxo0=;
 b=GZa1RC0tcGSm7Fva2jz0opZWSP1+1kT+RylWwy3Vm6GxKI/CwVYo/UGnDtAAl0acF+dcQo
 U5EGOZS3G6YC8yCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 93B814381A;
 Mon, 23 Mar 2026 10:31:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id rqjeIoAWwWnlIwAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Mon, 23 Mar 2026 10:31:28 +0000
Message-ID: <681588dc-b4d9-4af4-b6c0-c117024593df@suse.de>
Date: Mon, 23 Mar 2026 11:31:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/loongson: stop to set get_vblank_timestamp for
 LS7A1000 CRTC
To: Icenowy Zheng <zhengxingda@iscas.ac.cn>,
 Jianmin Lv <lvjianmin@loongson.cn>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Qianhai Wu <wuqianhai@loongson.cn>,
 Huacai Chen <chenhuacai@kernel.org>, Mingcong Bai <jeffbai@aosc.io>,
 Xi Ruoyao <xry111@xry111.site>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260321092804.3519447-1-zhengxingda@iscas.ac.cn>
 <47337244ebd0ce4efd3e065183e863421925f99f.camel@iscas.ac.cn>
 <e11078cb-7536-b5d2-b753-16d25093a403@loongson.cn>
 <4141b0a640f4d703053dad2c1dd257835881f0e2.camel@iscas.ac.cn>
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
In-Reply-To: <4141b0a640f4d703053dad2c1dd257835881f0e2.camel@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 URIBL_BLOCKED(0.00)[suse.de:mid,suse.de:dkim,suse.de:email,suse.com:url,iscas.ac.cn:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,bootlin.com:url];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FREEMAIL_TO(0.00)[iscas.ac.cn,loongson.cn,linux.intel.com,kernel.org,gmail.com,ffwll.ch,aosc.io,xry111.site];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCPT_COUNT_TWELVE(0.00)[12];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 MID_RHS_MATCH_FROM(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:url, suse.de:mid, suse.de:dkim,
 suse.de:email, iscas.ac.cn:email, imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: ECFF94D2BA
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

Am 23.03.26 um 10:40 schrieb Icenowy Zheng:
> 在 2026-03-23一的 11:40 +0800，Jianmin Lv写道：
>>
>> On 2026/3/21 下午5:29, Icenowy Zheng wrote:
>>> 在 2026-03-21六的 17:28 +0800，Icenowy Zheng写道：
>>>> As there's no known hardware capability about querying vblank on
>>>> the
>>>> LS7A1000 display controller, setting get_vblank_timestamp will
>>>> mislead the
>>>> kernel about the support of DC-backed high precision vblank
>>>> query.
>>>>
>>>> Drop this function pointer in the CRTC function table for
>>>> LS7A1000.
>>>>
>>>> This solves a kernel warning when booting Linux 7.0-rc3 on a
>>>> Loongson-3A4000+LS7A1000 Haier Boyue G51 laptop (with injected
>>>> EDID
>>>> for
>>>> replicating the display timing set by the firmware).
>>>>
>> The drm_crtc_vblank_helper_get_vblank_timestamp will call
>> get_scanout_position hook to caculate timestamp, and the driver has
>> get_scanout_position to support it (LS7A1000 has related register).
>> So
>> the get_vblank_timestamp hook is ok for LS7A1000, and we'd better
>> look
>> into the warning information.
> The warning information is copied here:
> ```
> [    0.334960] ------------[ cut here ]------------
> [    0.334960] WARNING: drivers/gpu/drm/drm_vblank.c:747 at
> drm_crtc_vblank_helper_get_vblank_timestamp_internal+0x3c8/0x438,
> CPU#0: kworker/0:1/11
> [    0.334960] loongson 0000:00:06.1: [drm]
> drm_WARN_ON_ONCE(drm_drv_uses_atomic_modeset(dev))

This is what you should investigate. mode->crtc_clock seems invalid. [1]

[1] 
https://elixir.bootlin.com/linux/v6.19.9/source/drivers/gpu/drm/drm_vblank.c#L743

Best regards
Thomas

> [    0.334960] Modules linked in:
> [    0.334960] CPU: 0 UID: 0 PID: 11 Comm: kworker/0:1 Not tainted
> 7.0.0-rc4-3a4000-laptop-test+ #31 PREEMPT
> [    0.334960] Hardware name: Haier Boyue G51/Boyue G51, BIOS
> K3L3A4000.HR10.200909.T 09/09/2020
> [    0.334960] Workqueue: events drm_fb_helper_damage_work
> [    0.334960] Stack : ffffffff819dec03 0000000000000000
> 0000000000000018 9800000100223938
> [    0.334960]         9800000100223938 9800000100223a68
> 0000000000000000 0000000000000000
> [    0.334960]         b8e8b3f2ec6b8200 98000000092bffa8
> 9800000100223768 0000000000000000
> [    0.334960]         ffffffff81632b08 0000000000000030
> ffffffff813c9530 0000000000200b20
> [    0.334960]         fffffffffffffffc 0000000000000000
> 0000000000000000 ffffffff816c1d50
> [    0.334960]         ffffffff81890000 00000000000002eb
> 0000000000000000 ffffffff80c1b180
> [    0.334960]         9800000100ff8500 0000000000000000
> 9800000005c965a8 0000000000000000
> [    0.334960]         ffffffff81a70000 9800000100220000
> 9800000100223930 0000000000000000
> [    0.334960]         ffffffff802274dc 0000000000000000
> 0000000000000000 0000000000000000
> [    0.334960]         0000000000000000 0000000000000000
> ffffffff802274fc b8e8b3f2ec6b8200
> [    0.334960]         ...
> [    0.334960] Call Trace:
> [    0.334960] [<ffffffff802274fc>] show_stack+0x64/0x158
> [    0.334960] [<ffffffff8021bac4>] dump_stack_lvl+0x70/0xb0
> [    0.334960] [<ffffffff8026a988>] __warn+0xa8/0x120
> [    0.334960] [<ffffffff8026ab60>] warn_slowpath_fmt+0x160/0x1f8
> [    0.334960] [<ffffffff80be5668>]
> drm_crtc_vblank_helper_get_vblank_timestamp_internal+0x3c8/0x438
> [    0.334960] [<ffffffff80be48d8>]
> drm_crtc_get_last_vbltimestamp+0x68/0xb0
> [    0.334960] [<ffffffff80be5e14>] drm_update_vblank_count+0xac/0x418
> [    0.334960] [<ffffffff80be6270>] drm_vblank_enable+0xf0/0x288
> [    0.334960] [<ffffffff80be7010>] drm_vblank_get+0xf8/0x160
> [    0.334960] [<ffffffff80beb2e0>]
> drm_client_modeset_wait_for_vblank+0x50/0xa0
> [    0.334960] [<ffffffff80c0a144>]
> drm_fb_helper_damage_work+0x8c/0x1d8
> [    0.334960] [<ffffffff8028fac8>] process_one_work+0x198/0x348
> [    0.334960] [<ffffffff802906c0>] worker_thread+0x238/0x390
> [    0.334960] [<ffffffff8029c0d8>] kthread+0x160/0x198
> [    0.334960] [<ffffffff8021fd8c>] ret_from_kernel_thread+0x14/0x1c
>
> [    0.334960] ---[ end trace 0000000000000000 ]---
> ```
>
>>>> Signed-off-by: Icenowy Zheng <zhengxingda@iscas.ac.cn>
>>> Oh forgot to attach when crafting v2:
>>>
>>> ```
>>> Acked-by: Thomas Zimmermann <tzimmermann@suse.de>
>>> ```
>>>
>>>> ---
>>>> Changes in v2:
>>>> - Re-formatted Loongson product model numbers per request from
>>>> Huacai.
>>>>
>>>>    drivers/gpu/drm/loongson/lsdc_crtc.c | 1 -
>>>>    1 file changed, 1 deletion(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/loongson/lsdc_crtc.c
>>>> b/drivers/gpu/drm/loongson/lsdc_crtc.c
>>>> index 587fbe285e9ef..b3af8e0cdb15f 100644
>>>> --- a/drivers/gpu/drm/loongson/lsdc_crtc.c
>>>> +++ b/drivers/gpu/drm/loongson/lsdc_crtc.c
>>>> @@ -721,7 +721,6 @@ static const struct drm_crtc_funcs
>>>> ls7a1000_crtc_funcs = {
>>>>    	.late_register = lsdc_crtc_late_register,
>>>>    	.enable_vblank = lsdc_crtc_enable_vblank,
>>>>    	.disable_vblank = lsdc_crtc_disable_vblank,
>>>> -	.get_vblank_timestamp =
>>>> drm_crtc_vblank_helper_get_vblank_timestamp,
>>>>    	.atomic_print_state = lsdc_crtc_atomic_print_state,
>>>>    };
>>>>    

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG Nürnberg)


