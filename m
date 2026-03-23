Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88EA2F483C4
	for <dri-devel@archiver.kernel.org>; Mon, 23 Mar 2026 16:08:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F06F310E5CC;
	Mon, 23 Mar 2026 16:08:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="1GcQDW5C";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="8n1uhvD7";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="1GcQDW5C";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="8n1uhvD7";
	dkim-atps=neutral
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC85310E5CC
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 16:08:51 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 9A9E25BD57;
 Mon, 23 Mar 2026 16:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1774282130; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Wc9WisVzJKSNqw+vyVhAxKy95ySTj5oFs4OYzcpQYyg=;
 b=1GcQDW5CkwAsAcnDkhFz7Z4PvthfPWc0LTRwxG5pdzgHEsLwJ756K4QPB3zQZu+FI5aga7
 jxb8JTWjqNnmjYSuriojy4zcps+1D47+vY2mQ/ybgJYwxC/Z7db1tEZZFcYwCv1BWdOoef
 RPO6bp+4qPvsBVuw2PWOOypdfMe7DgM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1774282130;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Wc9WisVzJKSNqw+vyVhAxKy95ySTj5oFs4OYzcpQYyg=;
 b=8n1uhvD7CbjKye4yPi+rNtdLRtg99L+PLJvsvacnlK4amOdmWEBBwmLMYkusyp5my/fmIl
 q2oNKbnqXwcLEjAA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=1GcQDW5C;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=8n1uhvD7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1774282130; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Wc9WisVzJKSNqw+vyVhAxKy95ySTj5oFs4OYzcpQYyg=;
 b=1GcQDW5CkwAsAcnDkhFz7Z4PvthfPWc0LTRwxG5pdzgHEsLwJ756K4QPB3zQZu+FI5aga7
 jxb8JTWjqNnmjYSuriojy4zcps+1D47+vY2mQ/ybgJYwxC/Z7db1tEZZFcYwCv1BWdOoef
 RPO6bp+4qPvsBVuw2PWOOypdfMe7DgM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1774282130;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Wc9WisVzJKSNqw+vyVhAxKy95ySTj5oFs4OYzcpQYyg=;
 b=8n1uhvD7CbjKye4yPi+rNtdLRtg99L+PLJvsvacnlK4amOdmWEBBwmLMYkusyp5my/fmIl
 q2oNKbnqXwcLEjAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6842E4396D;
 Mon, 23 Mar 2026 16:08:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id gqsLGJJlwWk9CQAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Mon, 23 Mar 2026 16:08:50 +0000
Message-ID: <1dff4e1c-6c35-4cd6-a6e9-ce5dc6ae67b6@suse.de>
Date: Mon, 23 Mar 2026 17:08:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/15] drm/ast: Clean up access to MMIO registers
To: jfalempe@redhat.com, airlied@redhat.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, airlied@gmail.com,
 simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org
References: <20260323160407.245773-1-tzimmermann@suse.de>
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
In-Reply-To: <20260323160407.245773-1-tzimmermann@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:url,suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 FREEMAIL_TO(0.00)[redhat.com,linux.intel.com,kernel.org,gmail.com,ffwll.ch];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 RCPT_COUNT_SEVEN(0.00)[7]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 TO_DN_NONE(0.00)[];
 URIBL_BLOCKED(0.00)[suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:url];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 9A9E25BD57
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

The series title should say 'non-MMIO registers'. :( The rest of the 
series is not affected by the typo.

Am 23.03.26 um 16:56 schrieb Thomas Zimmermann:
> Aspeed devices up to Gen6 contain internal memory that is accessible
> from the host via the P2A bridge. The helpers ast_moutdwm() and
> ast_mindwm() pick a 64-KiB segment of the memory to expose to the
> host, which then has the content available. Content is either registers
> of the various IP blocks or on-board system memory.
>
> Clean up the driver code involved and provide macro constants for the
> registers used by the ast driver. Go through the driver and replace
> the magic values with the constants.
>
> The first patch of the series fixes a bug that has been found while
> working on these changes. The DP501 writes the content of register
> SCU2C to the wrong address. The fix is a separate patch to ease
> backporting.
>
> Smoke-tested on AST2100, AST2300, AST2500 and AST2600.
>
> Thomas Zimmermann (15):
>    drm/ast: dp501: Fix initialization of SCU2C
>    drm/ast: Move 32-bit register-access helpers to ast_drv.{c,h}
>    drm/ast: Use constants for AHBC registers
>    drm/ast: Use constants for MCR registers
>    drm/ast: Use constants for SCU registers
>    drm/ast: Use constants for A2P registers
>    drm/ast: Use constants for WDT registers
>    drm/ast: Use constants for SDRAM registers
>    drm/ast: Store register addresses in struct ast_dramstruct
>    drm/ast: Gen1: Fix open-coded register access
>    drm/ast: Gen2: Fix open-coded register access
>    drm/ast: Gen4: Fix open-coded register access
>    drm/ast: Gen6: Fix open-coded register access
>    drm/ast: dp501: Fix open-coded register access
>    drm/ast: Fix open-coded scu_rev access
>
>   drivers/gpu/drm/ast/ast_2000.c  |  61 +++--
>   drivers/gpu/drm/ast/ast_2100.c  | 292 +++++++++++------------
>   drivers/gpu/drm/ast/ast_2300.c  | 398 ++++++++++++++++----------------
>   drivers/gpu/drm/ast/ast_2500.c  | 319 ++++++++++++-------------
>   drivers/gpu/drm/ast/ast_dp501.c | 146 ++++++------
>   drivers/gpu/drm/ast/ast_drv.c   |  84 ++++++-
>   drivers/gpu/drm/ast/ast_drv.h   |  60 +++--
>   drivers/gpu/drm/ast/ast_post.c  |  48 +---
>   drivers/gpu/drm/ast/ast_post.h  |  20 +-
>   drivers/gpu/drm/ast/ast_reg.h   | 155 +++++++++++++
>   10 files changed, 886 insertions(+), 697 deletions(-)
>
>
> base-commit: 5cb7d14d9bd2061386a0192a4649626a3e3a5ec3

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG Nürnberg)


