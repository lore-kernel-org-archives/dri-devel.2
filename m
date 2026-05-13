Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B027CD4851
	for <dri-devel@archiver.kernel.org>; Wed, 13 May 2026 07:50:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E81F10ECEF;
	Wed, 13 May 2026 07:50:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="Fw+lskyt";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="hm7Ky+j6";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Fw+lskyt";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="hm7Ky+j6";
	dkim-atps=neutral
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9544810ECEF
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 07:50:36 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 19DE9758C4;
 Wed, 13 May 2026 07:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1778658635; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=MOoKAVGB1Us0+yo5uycQhUVBUyhpEEMDfXbgoG1KYXQ=;
 b=Fw+lskyteajz3YE4Q7jJQsjsrS/X+j4LMTdPDHcWqDHGo/KncUFUzC74dDR3KwF8epaOvO
 IyFqmhNQ+B6Fzr2kK7+ByuN7Pk/gRzQaI9K8Aw92LBvU9XvZ2s1SZ/OxFan3YUQ1uXKtK0
 v0ysRoxIsX/BPgDfyqg6V2Y5S36xmsA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1778658635;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=MOoKAVGB1Us0+yo5uycQhUVBUyhpEEMDfXbgoG1KYXQ=;
 b=hm7Ky+j6atY5semWXViZ0IifGyFGiTAZNO1Pz/XJY37lHrcrBpDGI/nzOHZRY2FXLVf7eK
 HNErjV5uQ2GvkbAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1778658635; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=MOoKAVGB1Us0+yo5uycQhUVBUyhpEEMDfXbgoG1KYXQ=;
 b=Fw+lskyteajz3YE4Q7jJQsjsrS/X+j4LMTdPDHcWqDHGo/KncUFUzC74dDR3KwF8epaOvO
 IyFqmhNQ+B6Fzr2kK7+ByuN7Pk/gRzQaI9K8Aw92LBvU9XvZ2s1SZ/OxFan3YUQ1uXKtK0
 v0ysRoxIsX/BPgDfyqg6V2Y5S36xmsA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1778658635;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=MOoKAVGB1Us0+yo5uycQhUVBUyhpEEMDfXbgoG1KYXQ=;
 b=hm7Ky+j6atY5semWXViZ0IifGyFGiTAZNO1Pz/XJY37lHrcrBpDGI/nzOHZRY2FXLVf7eK
 HNErjV5uQ2GvkbAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2FE6B593A9;
 Wed, 13 May 2026 07:50:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id /fpZCUotBGrkBwAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Wed, 13 May 2026 07:50:34 +0000
Message-ID: <b98e1013-25ae-44e1-8905-88f104cc0608@suse.de>
Date: Wed, 13 May 2026 09:50:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: BUG: drm/ast: soft lockup due to missing timeout in hardware
 polling (ast_2500_patch_ahb)
To: w15303746062@163.com, Dave Airlie <airlied@redhat.com>,
 Jocelyn Falempe <jfalempe@redhat.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Mingyu Wang <25181214217@stu.xidian.edu.cn>
References: <20260513073649.352831-1-w15303746062@163.com>
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
In-Reply-To: <20260513073649.352831-1-w15303746062@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.80 / 50.00];
 SEM_URIBL(3.50)[xidian.edu.cn:email];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 URIBL_BLOCKED(0.00)[suse.com:url,imap1.dmz-prg2.suse.org:helo,suse.de:mid,xidian.edu.cn:email];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FREEMAIL_TO(0.00)[163.com,redhat.com];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; FREEMAIL_ENVRCPT(0.00)[163.com,gmail.com];
 RCVD_TLS_ALL(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[linux.intel.com,kernel.org,gmail.com,ffwll.ch,lists.freedesktop.org,vger.kernel.org,stu.xidian.edu.cn];
 RCVD_COUNT_TWO(0.00)[2]; RCPT_COUNT_SEVEN(0.00)[10];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[xidian.edu.cn:email,
 imap1.dmz-prg2.suse.org:helo, suse.com:url, suse.de:mid]
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

Am 13.05.26 um 09:36 schrieb w15303746062@163.com:
> From: Mingyu Wang <25181214217@stu.xidian.edu.cn>
>
> Hi all,
>
> While analyzing the AST driver's hardware interactions using our custom device emulation and fuzzing framework (DevGen), we observed a severe soft lockup in the DRM driver.
>
> Although the underlying trigger in our environment was an incomplete emulation of the ASPEED AHB bridge, this highlighted a critical defensive programming gap in the driver itself: a complete lack of timeout mechanisms in the hardware polling loops.
>
> This issue causes a complete system hang (CPU stuck for 143s+) and leads to subsequent I/O starvation and system paralysis (e.g., jbd2 and systemd-journald blocked).
>
> ### Crash Log Snippet
>
> watchdog: BUG: soft lockup - CPU#3 stuck for 143s! [systemd-udevd:162]
> RIP: 0010:ioread32+0x0/0xa0
> Call Trace:
>   <TASK>
>   __ast_read32
>   __ast_mindwm+0x4d/0x80 [ast]
>   ast_2500_patch_ahb+0x9d/0x120 [ast]
>   ast_detect_chip
>   ast_pci_probe+0xa1a/0xb70 [ast]
>   ...
>
> ### Vulnerability Analysis
>
> Even on bare-metal hardware, an unresponsive ASPEED chip, a PCIe bus fault, or unexpected hardware states can cause the kernel to hang forever in the following loops during initialization:
>
> 1. Inside `ast_2500_patch_ahb()`:
>      do {
>          __ast_moutdwm(regs, 0x1e6e2000, 0x1688A8A8);
>          data = __ast_mindwm(regs, 0x1e6e2000);
>      } while (data != 1); // <--- Infinite loop if hardware doesn't respond properly
>
> 2. Inside the underlying I/O accessors `__ast_mindwm()` and `__ast_moutdwm()`:
>      do {
>          data = __ast_read32(regs, 0xf004) & 0xffff0000;
>      } while (data != (r & 0xffff0000)); // <--- Infinite loop
>
> ### Proposed Fix Direction
>
> To prevent the kernel from hanging indefinitely and to gracefully abort the probe (`-ENODEV`) upon hardware failure, these loops must implement a timeout mechanism (e.g., using `readx_poll_timeout` or a loop counter with `udelay`).
>
> Interestingly, other functions in the same file (e.g., `mmc_test`) correctly implement a timeout counter (`if (++timeout > TIMEOUT) return false;`), but the initialization paths mentioned above blindly trust the hardware state.
>
> We are reporting this defect so that the maintainers can decide the appropriate timeout thresholds and implement a safe fallback mechanism across the `ast` driver.
>
> Please let us know if you need more information or the full dmesg log.

Thanks for reporting. Will you send a patch?

Best regards
Thomas

>
> Reported-by: Mingyu Wang <25181214217@stu.xidian.edu.cn>
>
> Best regards,
> Mingyu Wang
>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG Nürnberg)


