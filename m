Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43E04C43458
	for <dri-devel@archiver.kernel.org>; Wed,  8 Jul 2026 07:41:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6DAA410E581;
	Wed,  8 Jul 2026 07:41:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="oOe6OcwF";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="6HkEwgII";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="qCiZ9wer";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="DT00Fsrk";
	dkim-atps=neutral
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 890BC10E581
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Jul 2026 07:41:28 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B572D75F09;
 Wed,  8 Jul 2026 07:41:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1783496486; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=AbwgLESvPk2zg6RArzPfKLLg1LGNQAO1iwubJX1cfcw=;
 b=oOe6OcwFB2eKI3FBvOTw7EbUunzopvNtMNPuAc54/J65LmNusICbbhdjR8YtWqGwTJsvgx
 OLIqTRRN/8TULthPZpj6/4DD7OXp2BPHuIsO6YHfFXP87ATuhC/AEhtv6nAtaiSXofyOUo
 rmpWKcoBYs2lEMhqfPeGCBNDBCJ4pzM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1783496486;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=AbwgLESvPk2zg6RArzPfKLLg1LGNQAO1iwubJX1cfcw=;
 b=6HkEwgIITv6+QWhiIaBD0bgLmnqltJjRHgfkVAa525ouAp1PbKOSpA/rC4yMhfKSBGm/Fc
 QuO98PaW87UZPiDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1783496485; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=AbwgLESvPk2zg6RArzPfKLLg1LGNQAO1iwubJX1cfcw=;
 b=qCiZ9werPUkdlUux9tvDzmFtxIUn3A9LDkt37NmkOA5AC+udNwVVW3T4snSRhS4TKbhWSk
 HxU8+y57/ckfxUorJPc0odjyKEZX8j4lZqquMxJjbVaxUmpUqwB8M9K4rctvZyvXcfQ0Ls
 YRG32ZSL47ltJHlkU+DLkrUyZCxxlxo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1783496485;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=AbwgLESvPk2zg6RArzPfKLLg1LGNQAO1iwubJX1cfcw=;
 b=DT00FsrklVwmwiJeSIiwUsmcVs+Oq4NLh1SF9dz0iAOHqxTk0AUF7R0QPMRLyMZy6OaSem
 oDj+yzEwvDB60PBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9F6A8779AE;
 Wed,  8 Jul 2026 07:41:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id +ta3JSX/TWrjPwAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Wed, 08 Jul 2026 07:41:25 +0000
Message-ID: <eec61015-46cc-4ae8-8b82-106a98306741@suse.de>
Date: Wed, 8 Jul 2026 09:41:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/10] drm/nouveau: Implement
 vga_switcheroo_client_ops.pre_switch
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org
References: <20260707135724.247562-1-tzimmermann@suse.de>
 <20260707135724.247562-8-tzimmermann@suse.de>
 <20260707141844.866F91F00A3D@smtp.kernel.org>
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
In-Reply-To: <20260707141844.866F91F00A3D@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.993]; MIME_GOOD(-0.10)[text/plain];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2]; ARC_NA(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCVD_TLS_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_COUNT_TWO(0.00)[2]; MID_RHS_MATCH_FROM(0.00)[];
 TO_DN_NONE(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email, suse.de:mid,
 imap1.dmz-prg2.suse.org:helo, suse.com:url]
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



Am 07.07.26 um 16:18 schrieb sashiko-bot@kernel.org:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
>
> New issues:
> - [High] New AB-BA deadlock introduced between vgasr_mutex and clientlist_mutex.
>
> Pre-existing issues:
> - [High] Preexisting AB-BA deadlock between vgasr_mutex and console_lock.
> --
>
> --- Patch [7]: [PATCH 07/10] drm/nouveau: Implement vga_switcheroo_client_ops.pre_switch ---
> commit a0ca13a7165f71c977582a84acf58b2f2681a805
> Author: Thomas Zimmermann <tzimmermann@suse.de>
>
> drm/nouveau: Implement vga_switcheroo_client_ops.pre_switch
>
> This patch implements the vga_switcheroo_client_ops.pre_switch callback in
> the nouveau driver. It calls drm_client_dev_acquire_outputs() from the
> pre_switch callback to push fbcon updates from vga_switcheroo into DRM's
> fbdev emulation.
>
>> diff --git a/drivers/gpu/drm/nouveau/nouveau_vga.c b/drivers/gpu/drm/nouveau/nouveau_vga.c
>> index a6c375a241542..2d2d08be8fbe2 100644
>> --- a/drivers/gpu/drm/nouveau/nouveau_vga.c
>> +++ b/drivers/gpu/drm/nouveau/nouveau_vga.c
>> @@ -76,11 +76,20 @@ nouveau_switcheroo_can_switch(struct pci_dev *pdev)
>>   	return atomic_read(&drm->dev->open_count) == 0;
>>   }
>>   
>> +static void
>> +nouveau_switcheroo_pre_switch(struct pci_dev *pdev)
>> +{
>> +	struct nouveau_drm *drm = pci_get_drvdata(pdev);
>> +
>> +	drm_client_dev_acquire_outputs(drm->dev);
>          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>
> [Severity: High]
> Does this introduce an AB-BA deadlock between vgasr_mutex and
> clientlist_mutex?
>
> When drm_client_dev_hotplug() is called, it acquires dev->clientlist_mutex
> and eventually calls register_framebuffer(). This takes the console_lock()
> and then calls vga_switcheroo_client_fb_set(), taking vgasr_mutex. This
> establishes the lock order:
> clientlist_mutex -> console_lock -> vgasr_mutex
>
> However, vga_switcheroo_debugfs_write() acquires vgasr_mutex and calls
> vga_switchto_stage2(), which invokes this new pre_switch callback.
> Calling drm_client_dev_acquire_outputs() here attempts to acquire
> dev->clientlist_mutex, establishing the reverse lock order:
> vgasr_mutex -> clientlist_mutex

Patch 10 removes calls to vga_switcheroo_client_fb_set() entirely. I 
could try to reorganize the series to avoid the vulnerable intermediate 
states.

>
> [Severity: High]
> This is a pre-existing issue, but does this path also trigger a deadlock
> between vgasr_mutex and console_lock?
>
> When register_framebuffer() is called (e.g., during driver probe or
> hotplug), it calls fbcon_fb_registered(), which acquires console_lock()
> and then calls vga_switcheroo_client_fb_set(), taking vgasr_mutex.
>
> Conversely, vga_switcheroo_debugfs_write() acquires vgasr_mutex and calls
> vga_switchto_stage2(). This invokes pre_switch(), which leads to
> drm_client_dev_acquire_outputs() and then fb_switch_outputs(), attempting
> to acquire console_lock(). This creates an exact inversion:
> vgasr_mutex -> console_lock

This would also be resolved by the early removal of 
vga_switcheroo_client_fb_set().

>
>> +}
>> +
>>   static const struct vga_switcheroo_client_ops
>>   nouveau_switcheroo_ops = {
>>   	.set_gpu_state = nouveau_switcheroo_set_state,
>>   	.reprobe = nouveau_switcheroo_reprobe,
>>   	.can_switch = nouveau_switcheroo_can_switch,
>> +	.pre_switch = nouveau_switcheroo_pre_switch,
>>   };
>>   
>>   void

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, (HRB 36809, AG Nürnberg)


