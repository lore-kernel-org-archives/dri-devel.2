Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15F77CD5BD0
	for <dri-devel@archiver.kernel.org>; Tue, 26 May 2026 14:44:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7FB9810E6B5;
	Tue, 26 May 2026 14:44:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="wErWFlsr";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="gXhoc9y1";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="wErWFlsr";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="gXhoc9y1";
	dkim-atps=neutral
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 90F5910E6B5
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 14:44:23 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 16DAC6A882;
 Tue, 26 May 2026 14:44:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1779806662; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=xSGN5MnauGYIiHQIRVAhWm2E3gq8TYxrC2C53w6vF5Y=;
 b=wErWFlsrUXXYAc0gDI1DDrJ+qPgznfE+4+qFot/TZvveLbdwDV6cC8umTVAps7oT3cno/J
 BxhK9OqU3BDLs5OdvJcHxvXXm+BP/788T3pw+UlRC7ogzm+a31wMvTMeVbP2NuAPr69uKM
 Vf9ST0lxGsQbkh7JIRUhXS2lO0TIps0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1779806662;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=xSGN5MnauGYIiHQIRVAhWm2E3gq8TYxrC2C53w6vF5Y=;
 b=gXhoc9y1WGbtKocceAjH/67WYJ0TUX3Sg3pt0JunysECvszYvwME5DZ8llgW0wnwrB1Kvg
 yLH+ZDXhBeoViLBA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=wErWFlsr;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=gXhoc9y1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1779806662; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=xSGN5MnauGYIiHQIRVAhWm2E3gq8TYxrC2C53w6vF5Y=;
 b=wErWFlsrUXXYAc0gDI1DDrJ+qPgznfE+4+qFot/TZvveLbdwDV6cC8umTVAps7oT3cno/J
 BxhK9OqU3BDLs5OdvJcHxvXXm+BP/788T3pw+UlRC7ogzm+a31wMvTMeVbP2NuAPr69uKM
 Vf9ST0lxGsQbkh7JIRUhXS2lO0TIps0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1779806662;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=xSGN5MnauGYIiHQIRVAhWm2E3gq8TYxrC2C53w6vF5Y=;
 b=gXhoc9y1WGbtKocceAjH/67WYJ0TUX3Sg3pt0JunysECvszYvwME5DZ8llgW0wnwrB1Kvg
 yLH+ZDXhBeoViLBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B77225A266;
 Tue, 26 May 2026 14:44:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id d0JVK8WxFWoWPgAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Tue, 26 May 2026 14:44:21 +0000
Message-ID: <850e8355-7884-405c-a70a-986ce032c019@suse.de>
Date: Tue, 26 May 2026 16:44:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/6] drm/gem-shmem: Track folio accessed/dirty status
 in mmap
To: Igor Torrente <igor.torrente@collabora.com>,
 boris.brezillon@collabora.com, loic.molinari@collabora.com,
 willy@infradead.org, frank.binns@imgtec.com, matt.coster@imgtec.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, airlied@gmail.com,
 simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, linux-mm@kvack.org
References: <20260209133241.238813-1-tzimmermann@suse.de>
 <20260209133241.238813-6-tzimmermann@suse.de>
 <d89422f1-f00a-47b1-b68a-d949d6d6a974@collabora.com>
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
In-Reply-To: <d89422f1-f00a-47b1-b68a-d949d6d6a974@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 16DAC6A882
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 FREEMAIL_TO(0.00)[collabora.com,infradead.org,imgtec.com,linux.intel.com,kernel.org,gmail.com,ffwll.ch];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_TWELVE(0.00)[12];
 MIME_TRACE(0.00)[0:+]; MID_RHS_MATCH_FROM(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,suse.com:url,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DKIM_TRACE(0.00)[suse.de:+]
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

Am 20.05.26 um 15:11 schrieb Igor Torrente:
[...]
>
> I'm not familiar with the drm_gem, code so I don't any more insightful 
> information
> to share.  But hopefully we can find a better fix for this.

Do you have huge pages enabled ?

Best regards
Thomas

>
> BR,
> Igor Torrente
>
>> ---
>>   drivers/gpu/drm/drm_gem_shmem_helper.c | 20 ++++++++++++++++++++
>>   1 file changed, 20 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c 
>> b/drivers/gpu/drm/drm_gem_shmem_helper.c
>> index c3a054899ba3..0c86ad40a049 100644
>> --- a/drivers/gpu/drm/drm_gem_shmem_helper.c
>> +++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
>> @@ -598,6 +598,9 @@ static vm_fault_t drm_gem_shmem_fault(struct 
>> vm_fault *vmf)
>>       if (ret != VM_FAULT_NOPAGE)
>>           ret = vmf_insert_pfn(vma, vmf->address, pfn);
>>   +    if (likely(!(ret & VM_FAULT_ERROR)))
>> +        folio_mark_accessed(folio);
>> +
>>   out:
>>       dma_resv_unlock(obj->resv);
>>   @@ -638,10 +641,27 @@ static void drm_gem_shmem_vm_close(struct 
>> vm_area_struct *vma)
>>       drm_gem_vm_close(vma);
>>   }
>>   +static vm_fault_t drm_gem_shmem_pfn_mkwrite(struct vm_fault *vmf)
>> +{
>> +    struct vm_area_struct *vma = vmf->vma;
>> +    struct drm_gem_object *obj = vma->vm_private_data;
>> +    struct drm_gem_shmem_object *shmem = to_drm_gem_shmem_obj(obj);
>> +    pgoff_t page_offset = vmf->pgoff - vma->vm_pgoff; /* page offset 
>> within VMA */
>> +    struct page *page = shmem->pages[page_offset];
>> +    struct folio *folio = page_folio(page);
>> +
>> +    file_update_time(vma->vm_file);
>> +
>> +    folio_mark_dirty(folio);
>> +
>> +    return 0;
>> +}
>> +
>>   const struct vm_operations_struct drm_gem_shmem_vm_ops = {
>>       .fault = drm_gem_shmem_fault,
>>       .open = drm_gem_shmem_vm_open,
>>       .close = drm_gem_shmem_vm_close,
>> +    .pfn_mkwrite = drm_gem_shmem_pfn_mkwrite,
>>   };
>>   EXPORT_SYMBOL_GPL(drm_gem_shmem_vm_ops);

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG Nürnberg)


