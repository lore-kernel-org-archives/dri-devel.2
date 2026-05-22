Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57F76CD4F3D
	for <dri-devel@archiver.kernel.org>; Fri, 22 May 2026 08:22:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 69D0710E167;
	Fri, 22 May 2026 08:22:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="F7/w8e4g";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="wyvR+ApV";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="F7/w8e4g";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="wyvR+ApV";
	dkim-atps=neutral
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4FB6210E167
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 08:22:37 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 940DD679FA;
 Fri, 22 May 2026 08:22:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1779438155; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=jIh7vg7zw+pG1bWETOwC4iWlYlnSnwji2gMAxHT8EZk=;
 b=F7/w8e4gL2lLdQHSyJ3kidj9UtzFaNMJxZmiqQ1d4r2UBRz+H6Y+KHmZa/rA46MNl80ajT
 AhbqLI/dLxz52ESUYNh7XTBbHnqLOriiM2dcEMq+Sygo028NVOn0wYkCRambtNUueFyqXl
 MLIf3j1XYaIGzjEIxFsqfEKw5ODF3cc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1779438155;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=jIh7vg7zw+pG1bWETOwC4iWlYlnSnwji2gMAxHT8EZk=;
 b=wyvR+ApV8VsjsaYRhneLdKUUelpW+HyDXlWvX9jcfljUiYq5gSefRMm9FqcUk3grnLyHkk
 PAFyNfrHtX7kVhBg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="F7/w8e4g";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=wyvR+ApV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1779438155; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=jIh7vg7zw+pG1bWETOwC4iWlYlnSnwji2gMAxHT8EZk=;
 b=F7/w8e4gL2lLdQHSyJ3kidj9UtzFaNMJxZmiqQ1d4r2UBRz+H6Y+KHmZa/rA46MNl80ajT
 AhbqLI/dLxz52ESUYNh7XTBbHnqLOriiM2dcEMq+Sygo028NVOn0wYkCRambtNUueFyqXl
 MLIf3j1XYaIGzjEIxFsqfEKw5ODF3cc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1779438155;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=jIh7vg7zw+pG1bWETOwC4iWlYlnSnwji2gMAxHT8EZk=;
 b=wyvR+ApV8VsjsaYRhneLdKUUelpW+HyDXlWvX9jcfljUiYq5gSefRMm9FqcUk3grnLyHkk
 PAFyNfrHtX7kVhBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4DB1D593A8;
 Fri, 22 May 2026 08:22:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id WaJ4EUsSEGomAgAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Fri, 22 May 2026 08:22:35 +0000
Message-ID: <fa91ccc0-7660-44fc-92a8-ab569ebe3a7c@suse.de>
Date: Fri, 22 May 2026 10:22:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/vmwgfx: Fix hrtimer interrupt storm due to 0-period
 vblank
To: w15303746062@163.com, zack.rusin@broadcom.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, airlied@gmail.com,
 simona@ffwll.ch
Cc: bcm-kernel-feedback-list@broadcom.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Mingyu Wang <25181214217@stu.xidian.edu.cn>
References: <20260518071741.441794-1-w15303746062@163.com>
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
In-Reply-To: <20260518071741.441794-1-w15303746062@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 940DD679FA
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[163.com,gmail.com];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 FREEMAIL_TO(0.00)[163.com,broadcom.com,linux.intel.com,kernel.org,gmail.com,ffwll.ch];
 ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 MID_RHS_MATCH_FROM(0.00)[];
 internal_greylist_whitelist(0.00)[2a07:de40:b281:104:10:150:64:97];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_SEVEN(0.00)[11];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid, suse.de:dkim, suse.com:url,
 imap1.dmz-prg2.suse.org:rdns, imap1.dmz-prg2.suse.org:helo]
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

Hi

Am 18.05.26 um 09:17 schrieb w15303746062@163.com:
> From: Mingyu Wang <25181214217@stu.xidian.edu.cn>
>
> When vmwgfx is configured to use VKMS for vblank simulation, it relies
> on drm_calc_timestamping_constants() to calculate the frame duration
> (vblank->framedur_ns).
>
> However, Fuzzers (like Syzkaller) can submit extremely malicious
> display modes through DRM_IOCTL_MODE_SETCRTC. If the user-space passes
> a mode with a massive pixel clock (crtc_clock) and small resolution
> (htotal/vtotal), the integer division in drm_calc_timestamping_constants()
> truncates the result to 0.
>
> Consequently, vmw_vkms_enable_vblank() blindly sets the hrtimer period
> to 0. When the timer is started, it fires instantly and continuously.
> Because hrtimer_forward_now() cannot advance time for a 0-period,
> the overrun value skyrockets, locking the CPU in an infinite hard-IRQ
> loop (vkms_vblank_simulate() -> HRTIMER_RESTART).
>
> This completely starves the CPU, leading to massive RCU stalls and
> blocking other essential tasks (like jbd2 and writeback workers)
> indefinitely:
>
>    [ C1] vkms_vblank_simulate: vblank timer overrun
>    ...
>    INFO: task kworker/u18:2:50 blocked for more than 143 seconds.
>    Workqueue: writeback wb_workfn (flush-8:0)
>    Call Trace:
>     <TASK>
>     __schedule+0x1044/0x5bb0
>     wbt_wait+0x1c8/0x3b0
>     blk_mq_submit_bio+0x29fa/0x31f0
>     submit_bio_noacct+0xca7/0x1f90
>     ext4_bio_write_folio+0x95a/0x1d10
>     ...
>
>    NMI backtrace for cpu 1
>    Call Trace:
>     <IRQ>
>     vkms_vblank_simulate+0x8f/0x390
>     __hrtimer_run_queues+0x1f5/0xb30
>     hrtimer_interrupt+0x39a/0x880
>
> Fix this DoS vulnerability by adding a defensive sanity check in
> vmw_vkms_enable_vblank() to reject a 0-ns frame duration, allowing
> DRM core to gracefully fallback/reject the mode without crashing.
>
> Fixes: cd2eb57df1b8 ("drm/vmwgfx: Implement virtual kms")
> Cc: stable@vger.kernel.org
> Signed-off-by: Mingyu Wang <25181214217@stu.xidian.edu.cn>
> ---
>   drivers/gpu/drm/vmwgfx/vmwgfx_vkms.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
>
> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_vkms.c b/drivers/gpu/drm/vmwgfx/vmwgfx_vkms.c
> index 5abd7f5ad2db..b3950ae424f3 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_vkms.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_vkms.c
> @@ -288,6 +288,16 @@ vmw_vkms_enable_vblank(struct drm_crtc *crtc)
>   
>   	drm_calc_timestamping_constants(crtc, &crtc->mode);
>   
> +	/*
> +	 * DEFENSIVE CHECK:
> +	 * drm_calc_timestamping_constants() can calculate a framedur_ns
> +	 * of 0 if user-space provides a malicious mode with a huge
> +	 * crtc_clock and small htotal/vtotal due to integer division
> +	 * truncation. Prevent hrtimer interrupt storms by refusing such modes.
> +	 */
> +	if (WARN_ON_ONCE(vblank->framedur_ns == 0))
> +		return -EINVAL;

This code does no longer exist in the development tree (i.e., drm-misc). 
Although the new implementation might have a similar issue.

Best regards
Thomas

> +
>   	hrtimer_setup(&du->vkms.timer, &vmw_vkms_vblank_simulate, CLOCK_MONOTONIC,
>   		      HRTIMER_MODE_REL);
>   	du->vkms.period_ns = ktime_set(0, vblank->framedur_ns);

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG Nürnberg)


