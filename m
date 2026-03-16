Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 559B1F46446
	for <dri-devel@archiver.kernel.org>; Mon, 16 Mar 2026 10:14:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B43758924B;
	Mon, 16 Mar 2026 10:14:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="w9OWF+sh";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="+VrQ6EZm";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="w9OWF+sh";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="+VrQ6EZm";
	dkim-atps=neutral
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ABECE8924B
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 10:14:42 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5A9064D202;
 Mon, 16 Mar 2026 10:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1773656081; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=AUsi/Wu1AdxmdLI7TKIRbRBBnJcJ1Q/Dx745pX2Eqso=;
 b=w9OWF+shYAlvSISPX96zr4WijehWI2EGj4VRbsPJoBMPIfkVGRKfeuHFRZ2BfYiEJ1lTcz
 d+G0omnYH+Pij44jOI830uWzh+bW4h18m420TVWygcC9sCl0uBW+UBJBwmmLY2FYzxXhzc
 Jk/rL3uTzi/fnUhRubRp90yLfa9rtHc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1773656081;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=AUsi/Wu1AdxmdLI7TKIRbRBBnJcJ1Q/Dx745pX2Eqso=;
 b=+VrQ6EZmQKcsbOO1TVK9udpmVaGmShQHEDuevL1oFB/A9to1Wmzwka4iEnq+IUeRED1ayH
 4uHA2J38O4hsy8Bg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=w9OWF+sh;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=+VrQ6EZm
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1773656081; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=AUsi/Wu1AdxmdLI7TKIRbRBBnJcJ1Q/Dx745pX2Eqso=;
 b=w9OWF+shYAlvSISPX96zr4WijehWI2EGj4VRbsPJoBMPIfkVGRKfeuHFRZ2BfYiEJ1lTcz
 d+G0omnYH+Pij44jOI830uWzh+bW4h18m420TVWygcC9sCl0uBW+UBJBwmmLY2FYzxXhzc
 Jk/rL3uTzi/fnUhRubRp90yLfa9rtHc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1773656081;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=AUsi/Wu1AdxmdLI7TKIRbRBBnJcJ1Q/Dx745pX2Eqso=;
 b=+VrQ6EZmQKcsbOO1TVK9udpmVaGmShQHEDuevL1oFB/A9to1Wmzwka4iEnq+IUeRED1ayH
 4uHA2J38O4hsy8Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 11B5D4273B;
 Mon, 16 Mar 2026 10:14:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 3x7kAhHYt2lnTQAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Mon, 16 Mar 2026 10:14:41 +0000
Message-ID: <08112162-7939-48b8-be57-790a8686bc46@suse.de>
Date: Mon, 16 Mar 2026 11:14:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/shmem-helper: Fix Map huge page mapping in fault
 handler
To: Boris Brezillon <boris.brezillon@collabora.com>,
 Pedro Demarchi Gomes <pedrodemargomes@gmail.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260316002649.211819-1-pedrodemargomes@gmail.com>
 <20260316105043.115ba8a3@fedora>
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
In-Reply-To: <20260316105043.115ba8a3@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 FREEMAIL_TO(0.00)[collabora.com,gmail.com];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 FREEMAIL_CC(0.00)[linux.intel.com,kernel.org,gmail.com,ffwll.ch,lists.freedesktop.org,vger.kernel.org];
 DKIM_TRACE(0.00)[suse.de:+]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_SEVEN(0.00)[8]; MID_RHS_MATCH_FROM(0.00)[];
 ASN(0.00)[asn:32098, ipnet:2800::/6, country:US];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.com:url]
X-Rspamd-Queue-Id: 5A9064D202
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

Am 16.03.26 um 10:50 schrieb Boris Brezillon:

>> Avoid this race by adding a huge_fault callback to drm_gem_shmem_vm_ops so that
>> PMD-sized mappings are handled through the appropriate huge page fault path.

This patch will conflict heavily with the folio-tracking patches that 
has been merged into upstream DRM. How do we deal with that?

Best regards
Thomas

>>
>> Fixes: 211b9a39f261 ("drm/shmem-helper: Map huge pages in fault handler")
>> Signed-off-by: Pedro Demarchi Gomes <pedrodemargomes@gmail.com>
>> ---
>>
>> Changes in v3:
>>   - Pass a try_pmd boolean parameter to drm_gem_shmem_any_fault
>>   - Compile drm_gem_shmem_huge_fault only if CONFIG_ARCH_SUPPORTS_PMD_PFNMAP
>> is defined to avoid a build warning
>>
>> Changes in v2: https://lore.kernel.org/dri-devel/20260313141719.3949700-1-pedrodemargomes@gmail.com/
>>   - Keep the #ifdef unindented
>>   - Create drm_gem_shmem_any_fault to handle faults of any order and use
>> drm_gem_shmem_[huge_]fault() as wrappers
>>
>> v1: https://lore.kernel.org/all/20260312155027.1682606-1-pedrodemargomes@gmail.com/
>>
>> ---
>>   drivers/gpu/drm/drm_gem_shmem_helper.c | 63 ++++++++++++++------------
>>   1 file changed, 35 insertions(+), 28 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
>> index 7b5a49935ae4..9428c3ab7283 100644
>> --- a/drivers/gpu/drm/drm_gem_shmem_helper.c
>> +++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
>> @@ -550,36 +550,18 @@ int drm_gem_shmem_dumb_create(struct drm_file *file, struct drm_device *dev,
>>   }
>>   EXPORT_SYMBOL_GPL(drm_gem_shmem_dumb_create);
>>
>> -static bool drm_gem_shmem_try_map_pmd(struct vm_fault *vmf, unsigned long addr,
>> -				      struct page *page)
>> -{
>> -#ifdef CONFIG_ARCH_SUPPORTS_PMD_PFNMAP
>> -	unsigned long pfn = page_to_pfn(page);
>> -	unsigned long paddr = pfn << PAGE_SHIFT;
>> -	bool aligned = (addr & ~PMD_MASK) == (paddr & ~PMD_MASK);
>> -
>> -	if (aligned &&
>> -	    pmd_none(*vmf->pmd) &&
>> -	    folio_test_pmd_mappable(page_folio(page))) {
>> -		pfn &= PMD_MASK >> PAGE_SHIFT;
>> -		if (vmf_insert_pfn_pmd(vmf, pfn, false) == VM_FAULT_NOPAGE)
>> -			return true;
>> -	}
>> -#endif
>> -
>> -	return false;
>> -}
>> -
>> -static vm_fault_t drm_gem_shmem_fault(struct vm_fault *vmf)
>> +static vm_fault_t drm_gem_shmem_any_fault(struct vm_fault *vmf, bool try_pmd)
>>   {
>>   	struct vm_area_struct *vma = vmf->vma;
>>   	struct drm_gem_object *obj = vma->vm_private_data;
>>   	struct drm_gem_shmem_object *shmem = to_drm_gem_shmem_obj(obj);
>>   	loff_t num_pages = obj->size >> PAGE_SHIFT;
>> -	vm_fault_t ret;
>> +	vm_fault_t ret = VM_FAULT_FALLBACK;
>>   	struct page **pages = shmem->pages;
>>   	pgoff_t page_offset;
>>   	unsigned long pfn;
>> +	unsigned long paddr;
>> +	bool aligned;
> Those two variables can be moved to the `if (try_pmd)` branch.
>
>>   	/* Offset to faulty address in the VMA. */
>>   	page_offset = vmf->pgoff - vma->vm_pgoff;
>> @@ -593,13 +575,19 @@ static vm_fault_t drm_gem_shmem_fault(struct vm_fault *vmf)
>>   		goto out;
>>   	}
>>
>> -	if (drm_gem_shmem_try_map_pmd(vmf, vmf->address, pages[page_offset])) {
>> -		ret = VM_FAULT_NOPAGE;
>> -		goto out;
>> -	}
>> -
>>   	pfn = page_to_pfn(pages[page_offset]);
>> -	ret = vmf_insert_pfn(vma, vmf->address, pfn);
>> +	if (try_pmd) {
>> +		paddr = pfn << PAGE_SHIFT;
>> +		aligned = (vmf->address & ~PMD_MASK) == (paddr & ~PMD_MASK);
>> +
>> +		if (aligned &&
>> +		    folio_test_pmd_mappable(page_folio(pages[page_offset]))) {
>> +			pfn &= PMD_MASK >> PAGE_SHIFT;
>> +			ret = vmf_insert_pfn_pmd(vmf, pfn, false);
>> +		}
>> +	} else {
>> +		ret = vmf_insert_pfn(vma, vmf->address, pfn);
>> +	}
> Hm, if we get rid of drm_gem_shmem_try_map_pmd(), we probably
> need something like
>
> 	if (!try_pmd) {
> 		ret = vmf_insert_pfn(vma, vmf->address, pfn);
> 	} else {
> #ifdef CONFIG_ARCH_SUPPORTS_PMD_PFNMAP
> 		unsigned long paddr = pfn << PAGE_SHIFT;
> 		bool aligned = (vmf->address & ~PMD_MASK) == (paddr & ~PMD_MASK);
>
> 		if (aligned &&
> 		    folio_test_pmd_mappable(page_folio(pages[page_offset]))) {
> 			pfn &= PMD_MASK >> PAGE_SHIFT;
> 			ret = vmf_insert_pfn_pmd(vmf, pfn, false);
> 		}
> #else
> 		ret = VM_FAULT_FALLBACK;
> #endif
> 	}
>
> to make sure we're not calling helpers that might not
> exist in some configs (the compile might optimize the
> try_pmd==true branch out already, but better safe than sorry).
>
>>    out:
>>   	dma_resv_unlock(shmem->base.resv);
>> @@ -607,6 +595,22 @@ static vm_fault_t drm_gem_shmem_fault(struct vm_fault *vmf)
>>   	return ret;
>>   }
>>
>> +#ifdef CONFIG_ARCH_SUPPORTS_PMD_PFNMAP
>> +static vm_fault_t drm_gem_shmem_huge_fault(struct vm_fault *vmf,
>> +					   unsigned int order)
>> +{
>> +	if (order != PMD_ORDER)
>> +		return VM_FAULT_FALLBACK;
>> +
>> +	return drm_gem_shmem_any_fault(vmf, true);
>> +}
>> +#endif
>> +
>> +static vm_fault_t drm_gem_shmem_fault(struct vm_fault *vmf)
>> +{
>> +	return drm_gem_shmem_any_fault(vmf, false);
>> +}
>> +
>>   static void drm_gem_shmem_vm_open(struct vm_area_struct *vma)
>>   {
>>   	struct drm_gem_object *obj = vma->vm_private_data;
>> @@ -643,6 +647,9 @@ static void drm_gem_shmem_vm_close(struct vm_area_struct *vma)
>>
>>   const struct vm_operations_struct drm_gem_shmem_vm_ops = {
>>   	.fault = drm_gem_shmem_fault,
>> +#ifdef CONFIG_ARCH_SUPPORTS_PMD_PFNMAP
>> +	.huge_fault = drm_gem_shmem_huge_fault,
>> +#endif
>>   	.open = drm_gem_shmem_vm_open,
>>   	.close = drm_gem_shmem_vm_close,
>>   };
>> --
>> 2.47.3
>>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG Nürnberg)


