Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 690BFC43458
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 14:50:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F72B10E0AC;
	Fri,  3 Jul 2026 14:50:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="tIP7gwFx";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="vs674aI/";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="tIP7gwFx";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="vs674aI/";
	dkim-atps=neutral
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D3ED10E0AC
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 14:49:59 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 776AF75AB6;
 Fri,  3 Jul 2026 14:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1783090197; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=6pbz/3BbFRSpf2ccKNLEohPqnM0cobGCg4ixI0T1bVE=;
 b=tIP7gwFxRRl9WBJ0y4LlZtJAkG9Ky6cLGr48YYzLj16wdDXu9Ba4dmq6VW3Pz72cpe4FcW
 OEVxYq2zmNv32k7sYW+1UBayyTrY7XxDRh4tUA1CToWBUPFgLB3PG1tQLCmxOv2Mascwdy
 ptbUL2FG2cKq0Q/zwHoIFZnenCrqPSQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1783090197;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=6pbz/3BbFRSpf2ccKNLEohPqnM0cobGCg4ixI0T1bVE=;
 b=vs674aI/wUzuE/ZKzZ8C3Zp8WBSzSYRZICNI8fiL2eWGD/6gbk+k/74lyhLTfERxu0Yj4W
 BY8++xnI7boiXKAw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=tIP7gwFx;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="vs674aI/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1783090197; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=6pbz/3BbFRSpf2ccKNLEohPqnM0cobGCg4ixI0T1bVE=;
 b=tIP7gwFxRRl9WBJ0y4LlZtJAkG9Ky6cLGr48YYzLj16wdDXu9Ba4dmq6VW3Pz72cpe4FcW
 OEVxYq2zmNv32k7sYW+1UBayyTrY7XxDRh4tUA1CToWBUPFgLB3PG1tQLCmxOv2Mascwdy
 ptbUL2FG2cKq0Q/zwHoIFZnenCrqPSQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1783090197;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=6pbz/3BbFRSpf2ccKNLEohPqnM0cobGCg4ixI0T1bVE=;
 b=vs674aI/wUzuE/ZKzZ8C3Zp8WBSzSYRZICNI8fiL2eWGD/6gbk+k/74lyhLTfERxu0Yj4W
 BY8++xnI7boiXKAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2D7E3779AA;
 Fri,  3 Jul 2026 14:49:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id TGSnCRXMR2poLwAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Fri, 03 Jul 2026 14:49:57 +0000
Message-ID: <2468fcda-3935-449f-a5e1-9312360c3dd7@suse.de>
Date: Fri, 3 Jul 2026 16:49:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/tests: shmem: Set DMA mask to 64-bit in
 drm_gem_shmem
To: =?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>,
 dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, airlied@gmail.com, simona@ffwll.ch,
 boris.brezillon@collabora.com, kees@kernel.org,
 =?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito@redhat.com>
References: <20260703142749.4099-1-jose.exposito89@gmail.com>
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
In-Reply-To: <20260703142749.4099-1-jose.exposito89@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FREEMAIL_TO(0.00)[gmail.com,lists.freedesktop.org];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; RCVD_TLS_ALL(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 MID_RHS_MATCH_FROM(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[vger.kernel.org,linux.intel.com,kernel.org,gmail.com,ffwll.ch,collabora.com,redhat.com];
 RCPT_COUNT_SEVEN(0.00)[10]; TAGGED_RCPT(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DKIM_TRACE(0.00)[suse.de:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns, cki-project.org:url, amazonaws.com:url,
 suse.de:email, suse.de:dkim, suse.de:mid, suse.com:url]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 776AF75AB6
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



Am 03.07.26 um 16:27 schrieb José Expósito:
> From: José Expósito <jose.exposito@redhat.com>
>
> drm_gem_shmem_test_purge [1] and drm_gem_shmem_test_get_pages_sgt [2]
> intermittently fail on ppc64le and s390x CI systems with a DMA address
> overflow:
>
>    DMA addr 0x0000000100307000+4096 overflow (mask ffffffff, bus limit 0)
>    WARNING: kernel/dma/direct.h:114 dma_direct_map_sg+0x778/0x920
>
>    drm_gem_shmem_test_purge: ASSERTION FAILED at
>      drivers/gpu/drm/tests/drm_gem_shmem_test.c:330
>      Expected sgt is not error, but is: -5
>
> The call chain leading to the failure is:
>
>    drm_gem_shmem_test_purge() / drm_gem_shmem_test_get_pages_sgt()
>      drm_gem_shmem_get_pages_sgt()
>        drm_gem_shmem_get_pages_sgt_locked() [drm_gem_shmem_helper.c]
>          dma_map_sgtable()                  [mapping.c]
>            __dma_map_sg_attrs()
>              dma_direct_map_sg()            [direct.c]
>                dma_direct_map_phys()        [kernel/dma/direct.h]
>                  dma_capable()              Checks addr against DMA mask
>                    -> FAILS: addr > 0xFFFFFFFF
>
> The root cause is that KUnit devices are initialized with a 32-bit DMA
> mask (DMA_BIT_MASK(32)) in lib/kunit/device.c. On ppc64le and s390x
> systems with physical memory above 4GB, page allocations can land at
> addresses that exceed this mask. When drm_gem_shmem_get_pages_sgt()
> attempts to DMA-map these pages via dma_map_sgtable(), the DMA layer
> rejects the mapping because the physical address overflows the 32-bit
> mask.
>
> The failure is intermittent because pages may or may not be allocated
> above 4GB on any given run depend on memory pressure.
>
> Fix by setting a 64-bit DMA mask on the device before calling
> drm_gem_shmem_get_pages_sgt() for all tests, following the same pattern
> already used in drm_gem_shmem_test_obj_create_private().
>
> [1] https://s3.amazonaws.com/arr-cki-prod-trusted-artifacts/trusted-artifacts/2643976103/test_s390x/15128551935/artifacts/jobwatch/logs/recipes/21561049/tasks/220716793/results/1014626315/logs/dmesg.log
> [2] https://s3.amazonaws.com/arr-cki-prod-trusted-artifacts/trusted-artifacts/2643976103/test_ppc64le/15128551933/artifacts/jobwatch/logs/recipes/21561041/tasks/220716705/results/1014628163/logs/dmesg.log
>
> Fixes: 93032ae634d4 ("drm/test: add a test suite for GEM objects backed by shmem")
> Closes: https://datawarehouse.cki-project.org/issue/5345
> Closes: https://datawarehouse.cki-project.org/issue/3184
> Assisted-by: Claude:claude-4.6-opus
> Signed-off-by: José Expósito <jose.exposito@redhat.com>
>
> ---
>
> v2:
>
>    - Move fix to drm_gem_shmem_test_init() (Thomas Zimmermann)
>    - Link to v1: https://lore.kernel.org/dri-devel/20260703063517.6346-1-jose.exposito89@gmail.com/
> ---
>   drivers/gpu/drm/tests/drm_gem_shmem_test.c | 17 +++++++++--------
>   1 file changed, 9 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/tests/drm_gem_shmem_test.c b/drivers/gpu/drm/tests/drm_gem_shmem_test.c
> index 44a190109249..6e6b4f4902c2 100644
> --- a/drivers/gpu/drm/tests/drm_gem_shmem_test.c
> +++ b/drivers/gpu/drm/tests/drm_gem_shmem_test.c
> @@ -94,14 +94,6 @@ static void drm_gem_shmem_test_obj_create_private(struct kunit *test)
>   
>   	sg_init_one(sgt->sgl, buf, TEST_SIZE);
>   
> -	/*
> -	 * Set the DMA mask to 64-bits and map the sgtables
> -	 * otherwise drm_gem_shmem_free will cause a warning
> -	 * on debug kernels.
> -	 */
> -	ret = dma_set_mask(drm_dev->dev, DMA_BIT_MASK(64));
> -	KUNIT_ASSERT_EQ(test, ret, 0);
> -
>   	ret = dma_map_sgtable(drm_dev->dev, sgt, DMA_BIDIRECTIONAL, 0);
>   	KUNIT_ASSERT_EQ(test, ret, 0);
>   
> @@ -352,11 +344,20 @@ static int drm_gem_shmem_test_init(struct kunit *test)
>   {
>   	struct device *dev;
>   	struct drm_device *drm_dev;
> +	int ret;
>   
>   	/* Allocate a parent device */
>   	dev = drm_kunit_helper_alloc_device(test);
>   	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dev);
>   
> +	/*
> +	 * Set the DMA mask to 64-bits and map the sgtables
> +	 * otherwise drm_gem_shmem_free will cause a warning
> +	 * on debug kernels.
> +	 */
> +	ret = dma_set_mask(dev, DMA_BIT_MASK(64));
> +	KUNIT_ASSERT_EQ(test, ret, 0);
> +

The comment sounds a bit off, but still

Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>

>   	/*
>   	 * The DRM core will automatically initialize the GEM core and create
>   	 * a DRM Memory Manager object which provides an address space pool

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG Nürnberg)


