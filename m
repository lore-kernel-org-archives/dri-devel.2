Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F4B3CD3436
	for <dri-devel@archiver.kernel.org>; Mon,  4 May 2026 13:31:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9079610E233;
	Mon,  4 May 2026 13:31:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="s8a7Y7vc";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ABSPJnkY";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="s8a7Y7vc";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ABSPJnkY";
	dkim-atps=neutral
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D9C0E10E233
 for <dri-devel@lists.freedesktop.org>; Mon,  4 May 2026 13:31:06 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 712EC5C0C4;
 Mon,  4 May 2026 13:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1777901465; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=KHV8994yAmNydnDkiGnOuBlCF8Q8IBucfZszijArCjM=;
 b=s8a7Y7vcvj5y6M9B78MM0I8Uukx3KaPHqnG+jJv5S1C2yDqqqTihBnD9c0BxJZg3AGnGuH
 Xr35DZDQKXvKM7GGeGdRLfA5M96C/KMZZgRhPzRgXNX/gmqg8lFs8HI+l34WeVgPfx8syV
 bzJ7emfbzEmgBO1MFOQB8rh30zRxS00=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1777901465;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=KHV8994yAmNydnDkiGnOuBlCF8Q8IBucfZszijArCjM=;
 b=ABSPJnkYQbOaeZAv2q/SRZmcl2Hz07pd0BjJaO7WoanCRcNdKIHBZ+9UcPS9kaa9nOXFOq
 qCW9ow7bo6PSB8Bg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1777901465; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=KHV8994yAmNydnDkiGnOuBlCF8Q8IBucfZszijArCjM=;
 b=s8a7Y7vcvj5y6M9B78MM0I8Uukx3KaPHqnG+jJv5S1C2yDqqqTihBnD9c0BxJZg3AGnGuH
 Xr35DZDQKXvKM7GGeGdRLfA5M96C/KMZZgRhPzRgXNX/gmqg8lFs8HI+l34WeVgPfx8syV
 bzJ7emfbzEmgBO1MFOQB8rh30zRxS00=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1777901465;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=KHV8994yAmNydnDkiGnOuBlCF8Q8IBucfZszijArCjM=;
 b=ABSPJnkYQbOaeZAv2q/SRZmcl2Hz07pd0BjJaO7WoanCRcNdKIHBZ+9UcPS9kaa9nOXFOq
 qCW9ow7bo6PSB8Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 17882593A3;
 Mon,  4 May 2026 13:31:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 4JNRBJmf+GkgHAAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Mon, 04 May 2026 13:31:05 +0000
Message-ID: <cf95498a-4ca7-4bbd-a1c6-3c4c0c6dda23@suse.de>
Date: Mon, 4 May 2026 15:31:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] drm/gm12u320: Replace system_long_wq with
 system_dfl_long_wq
To: Marco Crivellari <marco.crivellari@suse.com>,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
 Frederic Weisbecker <frederic@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Michal Hocko <mhocko@suse.com>, Hans de Goede <hansg@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
References: <20260430091532.115846-1-marco.crivellari@suse.com>
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
In-Reply-To: <20260430091532.115846-1-marco.crivellari@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCPT_COUNT_TWELVE(0.00)[13];
 MIME_TRACE(0.00)[0:+]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_TLS_ALL(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[kernel.org,gmail.com,linutronix.de,suse.com,linux.intel.com,ffwll.ch];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 URIBL_BLOCKED(0.00)[suse.com:url,suse.com:email,imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.de:mid,
 suse.de:email, suse.com:url, suse.com:email]
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



Am 30.04.26 um 11:15 schrieb Marco Crivellari:
> Currently the code enqueue work items using {queue|mod}_delayed_work(),
> using system_long_wq. This workqueue should be used when long works are
> expected, but it is a per-cpu workqueue.
>
> This is important because queue_delayed_work() queue the work using:
>
>     queue_delayed_work_on(WORK_CPU_UNBOUND, ...);
>
> Note that WORK_CPU_UNBOUND = NR_CPUS.
>
> This would end up calling __queue_delayed_work() that does:
>
>      if (housekeeping_enabled(HK_TYPE_TIMER)) {
>      //      [....]
>      } else {
>              if (likely(cpu == WORK_CPU_UNBOUND))
>                      add_timer_global(timer);
>              else
>                      add_timer_on(timer, cpu);
>      }
>
> So when cpu == WORK_CPU_UNBOUND the timer is global and is
> not using a specific CPU. Later, when __queue_work() is called:
>
>      if (req_cpu == WORK_CPU_UNBOUND) {
>              if (wq->flags & WQ_UNBOUND)
>                      cpu = wq_select_unbound_cpu(raw_smp_processor_id());
>              else
>                      cpu = raw_smp_processor_id();
>      }
>
> Because the wq is not unbound, it takes the CPU where the timer
> fired and enqueue the work on that CPU.
> The consequence of all of this is that the work can run anywhere,
> depending on where the timer fired.
>
> Recently, a new unbound workqueue specific for long running work has
> been added:
>
>      c116737e972e ("workqueue: Add system_dfl_long_wq for long unbound works")
>
> So change system_long_wq with system_dfl_long_wq so that the work may
> benefit from scheduler task placement.
>
> Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>

Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>

> ---
>   drivers/gpu/drm/tiny/gm12u320.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/tiny/gm12u320.c b/drivers/gpu/drm/tiny/gm12u320.c
> index d73dfebb4353..4ad074337af0 100644
> --- a/drivers/gpu/drm/tiny/gm12u320.c
> +++ b/drivers/gpu/drm/tiny/gm12u320.c
> @@ -388,7 +388,7 @@ static void gm12u320_fb_update_work(struct work_struct *work)
>   	 * We must draw a frame every 2s otherwise the projector
>   	 * switches back to showing its logo.
>   	 */
> -	queue_delayed_work(system_long_wq, &gm12u320->fb_update.work,
> +	queue_delayed_work(system_dfl_long_wq, &gm12u320->fb_update.work,
>   			   msecs_to_jiffies(IDLE_TIMEOUT));
>   
>   	return;
> @@ -427,7 +427,8 @@ static void gm12u320_fb_mark_dirty(struct drm_framebuffer *fb,
>   	mutex_unlock(&gm12u320->fb_update.lock);
>   
>   	if (wakeup)
> -		mod_delayed_work(system_long_wq, &gm12u320->fb_update.work, 0);
> +		mod_delayed_work(system_dfl_long_wq,
> +				 &gm12u320->fb_update.work, 0);
>   
>   	if (old_fb)
>   		drm_framebuffer_put(old_fb);

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG Nürnberg)


