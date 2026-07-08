Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23D44C43602
	for <dri-devel@archiver.kernel.org>; Wed,  8 Jul 2026 07:38:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8977410E58A;
	Wed,  8 Jul 2026 07:38:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="JiR1QUyq";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="kXoyDzIp";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="JiR1QUyq";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="kXoyDzIp";
	dkim-atps=neutral
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2EAD710E58A
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Jul 2026 07:38:36 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 72D6D758C8;
 Wed,  8 Jul 2026 07:38:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1783496314; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=jRhjJXGJSV/UTUMT/I/bS6mD/kjb9dWw1Ld6Me9X+FI=;
 b=JiR1QUyqal9EuIIp9mWP3p7vyuDhbwuxV16f7YOaybMvp5QSwP0XwpadpuBVtXBdf+4ysU
 Sp3VEDO3cy00eRj/udowy3cxgCdf/aZLraHNPJBdPmczL6yTf8KGR4wupVte0EO/g7OPkt
 iDvZCX0Q16dMEvZ8T0IU/dmMMD57DPo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1783496314;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=jRhjJXGJSV/UTUMT/I/bS6mD/kjb9dWw1Ld6Me9X+FI=;
 b=kXoyDzIpz8+UPV+zYAEGrOR6w4Hr+DI3L7y3caZtp6nmw5WSBbvWQ9LzKpkt4IxeGgjVZF
 PEMdv6jABUFAgMBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1783496314; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=jRhjJXGJSV/UTUMT/I/bS6mD/kjb9dWw1Ld6Me9X+FI=;
 b=JiR1QUyqal9EuIIp9mWP3p7vyuDhbwuxV16f7YOaybMvp5QSwP0XwpadpuBVtXBdf+4ysU
 Sp3VEDO3cy00eRj/udowy3cxgCdf/aZLraHNPJBdPmczL6yTf8KGR4wupVte0EO/g7OPkt
 iDvZCX0Q16dMEvZ8T0IU/dmMMD57DPo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1783496314;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=jRhjJXGJSV/UTUMT/I/bS6mD/kjb9dWw1Ld6Me9X+FI=;
 b=kXoyDzIpz8+UPV+zYAEGrOR6w4Hr+DI3L7y3caZtp6nmw5WSBbvWQ9LzKpkt4IxeGgjVZF
 PEMdv6jABUFAgMBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 41EDC779AE;
 Wed,  8 Jul 2026 07:38:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id iRewDnr+TWrlPAAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Wed, 08 Jul 2026 07:38:34 +0000
Message-ID: <1908bf53-3ce2-4dc3-9b39-3c0e2288e615@suse.de>
Date: Wed, 8 Jul 2026 09:38:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/10] drm/amdgpu: Implement struct
 vga_switcheroo_client_ops.pre_switch
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org
References: <20260707135724.247562-1-tzimmermann@suse.de>
 <20260707135724.247562-6-tzimmermann@suse.de>
 <20260707142238.8B9FE1F000E9@smtp.kernel.org>
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
In-Reply-To: <20260707142238.8B9FE1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.993]; MIME_GOOD(-0.10)[text/plain];
 MID_RHS_MATCH_FROM(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; FROM_EQ_ENVFROM(0.00)[];
 TO_DN_NONE(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.de:email,
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



Am 07.07.26 um 16:22 schrieb sashiko-bot@kernel.org:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] An AB-BA lock inversion is introduced between `vgasr_mutex` and `dev->clientlist_mutex`, leading to a potential deadlock.
> --
>
> --- Patch [5]: [PATCH 05/10] drm/amdgpu: Implement struct vga_switcheroo_client_ops.pre_switch ---
> commit 31dd42c0f56cf03f20324c5c0e3557fa630afd13
> Author: Thomas Zimmermann <tzimmermann@suse.de>
>
> drm/amdgpu: Implement struct vga_switcheroo_client_ops.pre_switch
>
> This commit implements the pre_switch callback for vga_switcheroo_client_ops
> in the amdgpu driver. It calls drm_client_dev_acquire_outputs() to push fbcon
> updates from vga_switcheroo into DRM's fbdev emulation.
>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> index 211d30f03d25f..6c80c6f4b07ca 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -1698,10 +1698,18 @@ static bool amdgpu_switcheroo_can_switch(struct pci_dev *pdev)
>>   	return atomic_read(&dev->open_count) == 0;
>>   }
>>   
>> +static void amdgpu_switcheroo_pre_switch(struct pci_dev *pdev)
>> +{
>> +	struct drm_device *dev = pci_get_drvdata(pdev);
>> +
>> +	drm_client_dev_acquire_outputs(dev);
> [Severity: High]
> Can this introduce an AB-BA lock inversion between vgasr_mutex and
> dev->clientlist_mutex?
>
> This callback is invoked by vga_switcheroo while vgasr_mutex is held, and
> drm_client_dev_acquire_outputs() then acquires dev->clientlist_mutex.
>
> Meanwhile, the hotplug path acquires clientlist_mutex first:
>
> drm_client_dev_hotplug()
>    mutex_lock(&dev->clientlist_mutex);
>
> and then eventually takes console_lock and vgasr_mutex (via
> vga_switcheroo_client_fb_set() called from register_framebuffer()) deeper in
> the call stack.

Patch 10 removes calls to vga_switcheroo_client_fb_set() entirely. I 
could try to reorganize the series to avoid the vulnerable intermediate 
states.

>
> If a hotplug event and a VGA switcheroo switch execute concurrently, could this
> lead to a deadlock?
>
>> +}
>> +
>>   static const struct vga_switcheroo_client_ops amdgpu_switcheroo_ops = {
>>   	.set_gpu_state = amdgpu_switcheroo_set_state,
>>   	.reprobe = NULL,
>>   	.can_switch = amdgpu_switcheroo_can_switch,
>> +	.pre_switch = amdgpu_switcheroo_pre_switch,
>>   };

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, (HRB 36809, AG Nürnberg)


