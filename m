Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8B71C43458
	for <dri-devel@archiver.kernel.org>; Wed,  8 Jul 2026 07:39:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA4F410E583;
	Wed,  8 Jul 2026 07:39:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="G/4v+TrM";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="PFBRV/mz";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="G/4v+TrM";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="PFBRV/mz";
	dkim-atps=neutral
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E8C9610F003
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Jul 2026 07:39:17 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1C8EA75AF8;
 Wed,  8 Jul 2026 07:39:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1783496356; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=MvKR42VnUIkZWKjlG/zkI9oKRhvO8mvndmhuJE5cLy4=;
 b=G/4v+TrM3fdn9l/51QviDe+IQvr/hekfaFjKqJSRbDlOrG51L9NTOK0ttWy/FLFrMUh7Co
 WeQylIXO7Td4N0+RNt0k3pAj30/QfFNeDoUC/cI1dQgiDV1yyykwH6LH2ZvhVt2hogasBc
 JJM9ETeH34CooHYRvSyzx2rw5IYNspM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1783496356;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=MvKR42VnUIkZWKjlG/zkI9oKRhvO8mvndmhuJE5cLy4=;
 b=PFBRV/mzdm3yzW+yiAe0VynbgbMNM8/Yw7XYTiAfAYg2B9pglQdrxiQH7XDS49YItfMNmP
 /ByI3+yWZ1VFVVAg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="G/4v+TrM";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="PFBRV/mz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1783496356; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=MvKR42VnUIkZWKjlG/zkI9oKRhvO8mvndmhuJE5cLy4=;
 b=G/4v+TrM3fdn9l/51QviDe+IQvr/hekfaFjKqJSRbDlOrG51L9NTOK0ttWy/FLFrMUh7Co
 WeQylIXO7Td4N0+RNt0k3pAj30/QfFNeDoUC/cI1dQgiDV1yyykwH6LH2ZvhVt2hogasBc
 JJM9ETeH34CooHYRvSyzx2rw5IYNspM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1783496356;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=MvKR42VnUIkZWKjlG/zkI9oKRhvO8mvndmhuJE5cLy4=;
 b=PFBRV/mzdm3yzW+yiAe0VynbgbMNM8/Yw7XYTiAfAYg2B9pglQdrxiQH7XDS49YItfMNmP
 /ByI3+yWZ1VFVVAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0771A779AE;
 Wed,  8 Jul 2026 07:39:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id DAqjAKT+TWqjPQAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Wed, 08 Jul 2026 07:39:16 +0000
Message-ID: <3e174563-e2c3-4fca-8a7c-3adf548e01f6@suse.de>
Date: Wed, 8 Jul 2026 09:39:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/10] drm/i915: Implement
 vga_switcheroo_client_ops.pre_switch
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org
References: <20260707135724.247562-1-tzimmermann@suse.de>
 <20260707135724.247562-7-tzimmermann@suse.de>
 <20260707141722.A6A0F1F00A3E@smtp.kernel.org>
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
In-Reply-To: <20260707141722.A6A0F1F00A3E@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 1C8EA75AF8
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_TLS_ALL(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:url];
 RCPT_COUNT_TWO(0.00)[2]; MIME_TRACE(0.00)[0:+];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 TO_DN_NONE(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
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



Am 07.07.26 um 16:17 schrieb sashiko-bot@kernel.org:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] AB-BA deadlock between `vgasr_mutex` and `dev->clientlist_mutex` during VGA switcheroo and DRM client hotplug/registration.
> --
>
> --- Patch [6]: [PATCH 06/10] drm/i915: Implement vga_switcheroo_client_ops.pre_switch ---
> commit ca43d8e034e1ee27918b22e1b7a19b8f6a5b4a67
> Author: Thomas Zimmermann <tzimmermann@suse.de>
>
> drm/i915: Implement vga_switcheroo_client_ops.pre_switch
>
> This commit implements the pre_switch callback for vga_switcheroo in the
> i915 driver. It calls drm_client_dev_acquire_outputs() to push fbcon
> updates from vga_switcheroo into DRM's fbdev emulation.
>
>> diff --git a/drivers/gpu/drm/i915/i915_switcheroo.c b/drivers/gpu/drm/i915/i915_switcheroo.c
>> index 7e0791024282e..6b306ece0556a 100644
>> --- a/drivers/gpu/drm/i915/i915_switcheroo.c
>> +++ b/drivers/gpu/drm/i915/i915_switcheroo.c
> [ ... ]
>> @@ -58,10 +59,19 @@ static bool i915_switcheroo_can_switch(struct pci_dev *pdev)
>>   		atomic_read(&i915->drm.open_count) == 0;
>>   }
>>   
>> +static void i915_switcheroo_pre_switch(struct pci_dev *pdev)
>> +{
>> +	struct drm_i915_private *i915 = pdev_to_i915(pdev);
>> +
>> +	if (i915 && intel_display_device_present(i915->display))
>> +		drm_client_dev_acquire_outputs(&i915->drm);
>                  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>
> [Severity: High]
> Does this code introduce an AB-BA deadlock between vgasr_mutex and
> dev->clientlist_mutex?
>
> A GPU switch triggered via userspace will acquire vgasr_mutex and eventually
> call this pre_switch callback:
>
> vga_switcheroo_debugfs_write()  [acquires vgasr_mutex]
>    vga_switchto_stage2()
>      i915_switcheroo_pre_switch()
>        drm_client_dev_acquire_outputs()  [acquires dev->clientlist_mutex]
>
> However, a DRM client hotplug event can acquire these locks in the reverse
> order:
>
> drm_client_dev_hotplug()  [acquires dev->clientlist_mutex]
>    drm_fbdev_client_hotplug()
>      register_framebuffer()
>        fbcon_fb_registered()
>          do_fb_registered()
>            vga_switcheroo_client_fb_set()  [acquires vgasr_mutex]
>
> Could this lead to a system hang when a GPU switch races with a display
> hotplug event?

Patch 10 removes calls to vga_switcheroo_client_fb_set() entirely. I 
could try to reorganize the series to avoid the vulnerable intermediate 
states.

>
>> +}
>> +
>>   static const struct vga_switcheroo_client_ops i915_switcheroo_ops = {
>>   	.set_gpu_state = i915_switcheroo_set_state,
>>   	.reprobe = NULL,

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, (HRB 36809, AG Nürnberg)


