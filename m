Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3690606A320
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 15:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=cTZzMcRF;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=PLcYMHfL;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=cTZzMcRF;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=PLcYMHfL
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 44B5D10E8F9;
	Fri, 20 Nov 2026 15:34:26 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 10B9310E1AB
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 15:34:15 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 4EA162242E;
 Fri, 20 Nov 2026 15:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1795188853; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=z3K5ryV7ikhNBVmvjW84RMP6hfG7ArI+KX4vGUM0+tw=;
 b=cTZzMcRF3HVSh8PsR4SB+nBNdE/2C8ati1TTGhtnO4IGcXxmv8lHHqpwtSa1D+YMLIaknj
 Ew3guMf5N0s1IrAZJ2jZIb4rwxzy/w4rVbzfFjEqB3IEg5we9+ekkGuKKwFB5BTVHyY4jJ
 HbUQYYDwpPrpi5MnC3n07uFkaZ0QgDY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1795188853;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=z3K5ryV7ikhNBVmvjW84RMP6hfG7ArI+KX4vGUM0+tw=;
 b=PLcYMHfLZ2XeiqdVYa3RGPW/8lAfPcjKCenqfQOity0rP+CDWMh1nNXpzKFBw1LL57qpto
 tdQLiOT0vrSdeGBg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=cTZzMcRF;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=PLcYMHfL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1795188853; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=z3K5ryV7ikhNBVmvjW84RMP6hfG7ArI+KX4vGUM0+tw=;
 b=cTZzMcRF3HVSh8PsR4SB+nBNdE/2C8ati1TTGhtnO4IGcXxmv8lHHqpwtSa1D+YMLIaknj
 Ew3guMf5N0s1IrAZJ2jZIb4rwxzy/w4rVbzfFjEqB3IEg5we9+ekkGuKKwFB5BTVHyY4jJ
 HbUQYYDwpPrpi5MnC3n07uFkaZ0QgDY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1795188853;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=z3K5ryV7ikhNBVmvjW84RMP6hfG7ArI+KX4vGUM0+tw=;
 b=PLcYMHfLZ2XeiqdVYa3RGPW/8lAfPcjKCenqfQOity0rP+CDWMh1nNXpzKFBw1LL57qpto
 tdQLiOT0vrSdeGBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E264E1348F;
 Fri, 20 Nov 2026 15:34:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id sOZyJHRoAGvdbwAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Fri, 20 Nov 2026 15:34:12 +0000
Message-ID: <c93a89cd-2af3-485f-9549-c288fe327c42@suse.de>
Date: Fri, 20 Nov 2026 16:34:12 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/ast: Get VRAM size from PCI BAR0
To: Jammy Huang <jammy_huang@aspeedtech.com>, Dave Airlie
 <airlied@redhat.com>, Jocelyn Falempe <jfalempe@redhat.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20261111-ast-vram-size-from-bar0-v1-1-dff97e2f8ccd@aspeedtech.com>
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
In-Reply-To: <20261111-ast-vram-size-from-bar0-v1-1-dff97e2f8ccd@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4EA162242E
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-13.50 / 50.00]; SUSE_INTERNAL_BYPASS(-9.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 XM_UA_NO_VERSION(0.01)[]; MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FREEMAIL_TO(0.00)[aspeedtech.com,redhat.com,linux.intel.com,kernel.org,gmail.com,ffwll.ch];
 MIME_TRACE(0.00)[0:+]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; DKIM_TRACE(0.00)[suse.de:+];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCVD_TLS_ALL(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_SEVEN(0.00)[9]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:url, imap1.dmz-prg2.suse.org:rdns,
 imap1.dmz-prg2.suse.org:helo, suse.de:dkim, suse.de:email]
X-Spam-Score: -13.50
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



Am 11.11.26 um 07:16 schrieb Jammy Huang:
> ast_get_vram_size() decodes the VRAM size from VGACRAA[1:0]. The size
> of PCI BAR0, the framebuffer aperture, already reflects the VGA memory
> size configured in hardware, so the separate register lookup is
> redundant. Using the BAR size also guarantees that the VRAM mapping
> never extends beyond the aperture that the device decodes.
>
> Take the VRAM size from BAR0 and keep subtracting the reserved region
> given by VGACR99[1:0].
>
> Signed-off-by: Jammy Huang <jammy_huang@aspeedtech.com>

Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>

> ---
> The ast driver currently determines the VRAM size by decoding
> VGACRAA[1:0]. Since the size of PCI BAR0 already reflects the VGA
> memory size configured in hardware, use it directly and drop the
> register lookup. The reserved region reported in VGACR99[1:0] is still
> subtracted from the result.
> ---
>   drivers/gpu/drm/ast/ast_mm.c | 27 +++++----------------------
>   1 file changed, 5 insertions(+), 22 deletions(-)
>
> diff --git a/drivers/gpu/drm/ast/ast_mm.c b/drivers/gpu/drm/ast/ast_mm.c
> index 0bc14031946..6ef686cca5b 100644
> --- a/drivers/gpu/drm/ast/ast_mm.c
> +++ b/drivers/gpu/drm/ast/ast_mm.c
> @@ -33,26 +33,10 @@
>   
>   #include "ast_drv.h"
>   
> -static u32 ast_get_vram_size(struct ast_device *ast)
> +static resource_size_t ast_get_vram_size(struct ast_device *ast, resource_size_t bar_size)
>   {
> -	u32 vram_size;
> -	u8 vgacr99, vgacraa;
> -
> -	vgacraa = ast_get_index_reg(ast, AST_IO_VGACRI, 0xaa);
> -	switch (vgacraa & AST_IO_VGACRAA_VGAMEM_SIZE_MASK) {
> -	case 0:
> -		vram_size = SZ_8M;
> -		break;
> -	case 1:
> -		vram_size = SZ_16M;
> -		break;
> -	case 2:
> -		vram_size = SZ_32M;
> -		break;
> -	case 3:
> -		vram_size = SZ_64M;
> -		break;
> -	}
> +	resource_size_t vram_size = bar_size;
> +	u8 vgacr99;
>   
>   	vgacr99 = ast_get_index_reg(ast, AST_IO_VGACRI, 0x99);
>   	switch (vgacr99 & AST_IO_VGACR99_VGAMEM_RSRV_MASK) {
> @@ -74,8 +58,7 @@ int ast_mm_init(struct ast_device *ast)
>   {
>   	struct drm_device *dev = &ast->base;
>   	struct pci_dev *pdev = to_pci_dev(dev->dev);
> -	resource_size_t base, size;
> -	u32 vram_size;
> +	resource_size_t base, size, vram_size;
>   
>   	base = pci_resource_start(pdev, 0);
>   	size = pci_resource_len(pdev, 0);
> @@ -84,7 +67,7 @@ int ast_mm_init(struct ast_device *ast)
>   	devm_arch_io_reserve_memtype_wc(dev->dev, base, size);
>   	devm_arch_phys_wc_add(dev->dev, base, size);
>   
> -	vram_size = ast_get_vram_size(ast);
> +	vram_size = ast_get_vram_size(ast, size);
>   
>   	ast->vram = devm_ioremap_wc(dev->dev, base, vram_size);
>   	if (!ast->vram)
>
> ---
> base-commit: 067c5c24cef23d913b67eaaf71ae67e7169a6620
> change-id: 20261111-ast-vram-size-from-bar0-13819df1df24
>
> Best regards,

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Stefan Gaiser, Jochen Jaser, Abhinav Puri, (HRB 36809, AG Nürnberg)


