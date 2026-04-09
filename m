Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0762AE9DE41
	for <dri-devel@archiver.kernel.org>; Thu,  9 Apr 2026 07:01:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C8FA10E748;
	Thu,  9 Apr 2026 07:01:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="LTltWGjc";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Bhr/pHmA";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="pb5v5Ull";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="s1TO0Q0R";
	dkim-atps=neutral
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 56FA610E746
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Apr 2026 07:01:34 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 00CD75BCEB;
 Thu,  9 Apr 2026 07:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1775718090; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=lF1ak8a9AXMmboa+ffZ0xP4GimEiZhC5R5oeEyGt9LA=;
 b=LTltWGjcDyAHqoCnZh1CK0QU/q3w51mlsRiAeQhyfSz9EXqINWClBY2p+MkuE+ERAXOzaa
 zDet2LcmuAeWcyGJ3X01ktdjJc6m31ji1CrsrDfSEQwGoVl9SzhrakVok6p4aHEjLid40m
 LHYgVpiq+W4PaxduNfZzpwNulixbrc8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1775718090;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=lF1ak8a9AXMmboa+ffZ0xP4GimEiZhC5R5oeEyGt9LA=;
 b=Bhr/pHmAtkjPPX4vk2cit2uenKmpWyiaKez4+5jk3BZAclNukBFGjE/4VtA0WF8Ag8aKjx
 FoZ1CYpht7omy7AA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1775718086; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=lF1ak8a9AXMmboa+ffZ0xP4GimEiZhC5R5oeEyGt9LA=;
 b=pb5v5UllxEyuLSey0iSYyX/Uu3DVUaU2QqMCcsK4XYQpC77tHh+F1YsZCk8PUMIIF85u5V
 zWawCFwK1bVFE+Xgy++VtoYTxjFYkJW56XpQgEYYdVn2rd8LN/5peoOfrI4WNslWK0iU5d
 v6bAirymgLy7Kj0PAgUDgBxfZr9RQS8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1775718086;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=lF1ak8a9AXMmboa+ffZ0xP4GimEiZhC5R5oeEyGt9LA=;
 b=s1TO0Q0RSdRiGnFJRg4h6jhKc0jdb6nPO3fsmHEhxBz041M3x6I2k8s1iXldEgJ3F+b8P8
 KsQNo6+RuYYfoPCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A4EC74A0B3;
 Thu,  9 Apr 2026 07:01:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id GNKuJMVO12nCNgAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Thu, 09 Apr 2026 07:01:25 +0000
Message-ID: <c8ee1535-ca21-4370-ab32-d100a63f9397@suse.de>
Date: Thu, 9 Apr 2026 09:01:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/vram: remove DRM_VRAM_MM_FILE_OPERATIONS from docs
To: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 kernel-dev@igalia.com
References: <20260408-drm_gem_vram_helper_docs-v1-1-4d667a768f75@igalia.com>
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
In-Reply-To: <20260408-drm_gem_vram_helper_docs-v1-1-4d667a768f75@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 FREEMAIL_TO(0.00)[igalia.com,linux.intel.com,kernel.org,gmail.com,ffwll.ch];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_SEVEN(0.00)[8]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 MID_RHS_MATCH_FROM(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid, suse.de:email,
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



Am 08.04.26 um 21:31 schrieb Thadeu Lima de Souza Cascardo:
> Commit 02f64b2d8605 ("drm/vram: drop DRM_VRAM_MM_FILE_OPERATIONS") dropped
> DRM_VRAM_MM_FILE_OPERATIONS in preference for using DEFINE_DRM_GEM_OPS.
>
> However, it was not dropped from the kernel docs.
>
> Use DEFINE_DRM_GEM_OPS in the illustration on how to define a
> struct file_operations for such a DRM driver and remove any reference
> to DRM_VRAM_MM_FILE_OPERATIONS.
>
> Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>

Thanks for the patch.

Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>

Fixes: 02f64b2d8605 ("drm/vram: drop DRM_VRAM_MM_FILE_OPERATIONS")



> ---
>   drivers/gpu/drm/drm_gem_vram_helper.c | 7 ++-----
>   1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_gem_vram_helper.c b/drivers/gpu/drm/drm_gem_vram_helper.c
> index d7fcced75e797ce1b86313612a577775c9c26487..bca802ccddee792b8a8f643ecb02a41915f7ba18 100644
> --- a/drivers/gpu/drm/drm_gem_vram_helper.c
> +++ b/drivers/gpu/drm/drm_gem_vram_helper.c
> @@ -49,15 +49,12 @@ static const struct drm_gem_object_funcs drm_gem_vram_object_funcs;
>    * To initialize the VRAM helper library call drmm_vram_helper_init().
>    * The function allocates and initializes an instance of &struct drm_vram_mm
>    * in &struct drm_device.vram_mm . Use &DRM_GEM_VRAM_DRIVER to initialize
> - * &struct drm_driver and  &DRM_VRAM_MM_FILE_OPERATIONS to initialize
> + * &struct drm_driver and &DEFINE_DRM_GEM_FOPS to define
>    * &struct file_operations; as illustrated below.
>    *
>    * .. code-block:: c
>    *
> - *	struct file_operations fops ={
> - *		.owner = THIS_MODULE,
> - *		DRM_VRAM_MM_FILE_OPERATION
> - *	};
> + *	DEFINE_DRM_GEM_FOPS(fops);
>    *	struct drm_driver drv = {
>    *		.driver_feature = DRM_ ... ,
>    *		.fops = &fops,
>
> ---
> base-commit: 408df6213f56f467675dc0ecf156a8bd1984555e
> change-id: 20260408-drm_gem_vram_helper_docs-bc7f30f9c561
>
> Best regards,

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG Nürnberg)


