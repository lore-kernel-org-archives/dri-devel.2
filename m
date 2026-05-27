Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37CF4CD5BDE
	for <dri-devel@archiver.kernel.org>; Wed, 27 May 2026 06:56:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8687310E72F;
	Wed, 27 May 2026 06:56:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="VmPE7d5/";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="GA+npAAD";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="VmPE7d5/";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="GA+npAAD";
	dkim-atps=neutral
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 63A6710E72F
 for <dri-devel@lists.freedesktop.org>; Wed, 27 May 2026 06:56:35 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1A3C96AF0A;
 Wed, 27 May 2026 06:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1779864994; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=DKonJIChTBbTxvdrXGx+kKIgXH4hM3XFhBOENEhGEoQ=;
 b=VmPE7d5/b/nwm1Zm3Ineo+D1pdHLAPSqBKIP1nY+kWJHQDBpTmGTfcIXdg2O5eulL9vnQC
 A6DsSfkO6COZY9SRtb1F3Lb7jOl41qwHF4Rml+s4DhWrc7LYvnGfL6kIJVrM6Nye6cNV4Y
 Q2tnup25YiUQ/7KBHzNUt9k+vNxY0yM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1779864994;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=DKonJIChTBbTxvdrXGx+kKIgXH4hM3XFhBOENEhGEoQ=;
 b=GA+npAAD04tEiYWYwlRGKCYlrXgP0q6Srq8wgsCF4kmlZxSnD4tm9Vj5EXxhZJMSHIVQ7M
 y5pZ9LKY3fx9ViAg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="VmPE7d5/";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=GA+npAAD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1779864994; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=DKonJIChTBbTxvdrXGx+kKIgXH4hM3XFhBOENEhGEoQ=;
 b=VmPE7d5/b/nwm1Zm3Ineo+D1pdHLAPSqBKIP1nY+kWJHQDBpTmGTfcIXdg2O5eulL9vnQC
 A6DsSfkO6COZY9SRtb1F3Lb7jOl41qwHF4Rml+s4DhWrc7LYvnGfL6kIJVrM6Nye6cNV4Y
 Q2tnup25YiUQ/7KBHzNUt9k+vNxY0yM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1779864994;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=DKonJIChTBbTxvdrXGx+kKIgXH4hM3XFhBOENEhGEoQ=;
 b=GA+npAAD04tEiYWYwlRGKCYlrXgP0q6Srq8wgsCF4kmlZxSnD4tm9Vj5EXxhZJMSHIVQ7M
 y5pZ9LKY3fx9ViAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BE28A5A6CF;
 Wed, 27 May 2026 06:56:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id M3rvLKGVFmroFQAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Wed, 27 May 2026 06:56:33 +0000
Content-Type: multipart/mixed; boundary="------------qEORVyYFqwCDMYi1Vb0xhvqj"
Message-ID: <67855fcd-2afe-4a1d-a51a-210e45f56167@suse.de>
Date: Wed, 27 May 2026 08:56:33 +0200
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
 <850e8355-7884-405c-a70a-986ce032c019@suse.de>
 <831c0943-c75f-4d42-aa5f-90ce34cf8530@collabora.com>
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
In-Reply-To: <831c0943-c75f-4d42-aa5f-90ce34cf8530@collabora.com>
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 1A3C96AF0A
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.40 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MIME_BASE64_TEXT_BOGUS(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.19)[-0.968];
 MIME_GOOD(-0.10)[multipart/mixed,text/plain,text/x-patch];
 MIME_BASE64_TEXT(0.10)[]; MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FREEMAIL_TO(0.00)[collabora.com,infradead.org,imgtec.com,linux.intel.com,kernel.org,gmail.com,ffwll.ch];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 ARC_NA(0.00)[]; RCPT_COUNT_TWELVE(0.00)[12];
 MIME_TRACE(0.00)[0:+,1:+,2:+];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]; DKIM_TRACE(0.00)[suse.de:+];
 RCVD_VIA_SMTP_AUTH(0.00)[]; HAS_ATTACHMENT(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:url, imap1.dmz-prg2.suse.org:rdns,
 imap1.dmz-prg2.suse.org:helo, suse.de:email, suse.de:dkim, suse.de:mid]
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

This is a multi-part message in MIME format.
--------------qEORVyYFqwCDMYi1Vb0xhvqj
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi

Am 26.05.26 um 16:56 schrieb Igor Torrente:
> Hi Thomas,
>
> On 5/26/26 11:44, Thomas Zimmermann wrote:
>> Hi
>>
>> Am 20.05.26 um 15:11 schrieb Igor Torrente:
>> [...]
>>>
>>> I'm not familiar with the drm_gem, code so I don't any more 
>>> insightful information
>>> to share.  But hopefully we can find a better fix for this.
>>
>> Do you have huge pages enabled ?
>
> No, I didn't even compile my kernel with huge pages. I've already been 
> burned by that before

I see.

The attached patch is a cleaned up version of Boris' fix. Please test 
and report back on the results.

Best regards
Thomas

>
>
> BR,
> Igor Torrente
>
>>
>> Best regards
>> Thomas
>>
>>>
>>> BR,
>>> Igor Torrente
>>>
>>>> ---
>>>>   drivers/gpu/drm/drm_gem_shmem_helper.c | 20 ++++++++++++++++++++
>>>>   1 file changed, 20 insertions(+)
>>>>
>>>> diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c 
>>>> b/drivers/gpu/drm/drm_gem_shmem_helper.c
>>>> index c3a054899ba3..0c86ad40a049 100644
>>>> --- a/drivers/gpu/drm/drm_gem_shmem_helper.c
>>>> +++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
>>>> @@ -598,6 +598,9 @@ static vm_fault_t drm_gem_shmem_fault(struct 
>>>> vm_fault *vmf)
>>>>       if (ret != VM_FAULT_NOPAGE)
>>>>           ret = vmf_insert_pfn(vma, vmf->address, pfn);
>>>>   +    if (likely(!(ret & VM_FAULT_ERROR)))
>>>> +        folio_mark_accessed(folio);
>>>> +
>>>>   out:
>>>>       dma_resv_unlock(obj->resv);
>>>>   @@ -638,10 +641,27 @@ static void drm_gem_shmem_vm_close(struct 
>>>> vm_area_struct *vma)
>>>>       drm_gem_vm_close(vma);
>>>>   }
>>>>   +static vm_fault_t drm_gem_shmem_pfn_mkwrite(struct vm_fault *vmf)
>>>> +{
>>>> +    struct vm_area_struct *vma = vmf->vma;
>>>> +    struct drm_gem_object *obj = vma->vm_private_data;
>>>> +    struct drm_gem_shmem_object *shmem = to_drm_gem_shmem_obj(obj);
>>>> +    pgoff_t page_offset = vmf->pgoff - vma->vm_pgoff; /* page 
>>>> offset within VMA */
>>>> +    struct page *page = shmem->pages[page_offset];
>>>> +    struct folio *folio = page_folio(page);
>>>> +
>>>> +    file_update_time(vma->vm_file);
>>>> +
>>>> +    folio_mark_dirty(folio);
>>>> +
>>>> +    return 0;
>>>> +}
>>>> +
>>>>   const struct vm_operations_struct drm_gem_shmem_vm_ops = {
>>>>       .fault = drm_gem_shmem_fault,
>>>>       .open = drm_gem_shmem_vm_open,
>>>>       .close = drm_gem_shmem_vm_close,
>>>> +    .pfn_mkwrite = drm_gem_shmem_pfn_mkwrite,
>>>>   };
>>>>   EXPORT_SYMBOL_GPL(drm_gem_shmem_vm_ops);
>>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG Nürnberg)


--------------qEORVyYFqwCDMYi1Vb0xhvqj
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-drm-gem-shmem-Always-assume-writable-mmap-drop-pfn_m.patch"
Content-Disposition: attachment;
 filename*0="0001-drm-gem-shmem-Always-assume-writable-mmap-drop-pfn_m.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSA0NDc4YjNlMDc1MTUxOTQ4MTI4MDZjNWJmYzNiNzQzMmQ4Zjg0MDZhIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBUaG9tYXMgWmltbWVybWFubiA8dHppbW1lcm1hbm5A
c3VzZS5kZT4KRGF0ZTogV2VkLCAyNyBNYXkgMjAyNiAwODowNzoxOSArMDIwMApTdWJqZWN0
OiBbUEFUQ0hdIGRybS9nZW0tc2htZW06IEFsd2F5cyBhc3N1bWUgd3JpdGFibGUgbW1hcDsg
ZHJvcCBwZm5fbWt3cml0ZQoKVXNpbmcgcGZuX21rd3JpdGUgYnJlYWtzIEtWTSB3aXRoICJl
cnJvcjoga3ZtIHJ1biBmYWlsZWQgQmFkIGFkZHJlc3MiLgpTZWVuIG9uIGEgTWFsaS1HNjEw
IEdQVS4gRml4IHRoaXMgYnkgYWx3YXlzIG1hcmtpbmcgdGhlIG1hcHBlZCBwYWdlcwphcyB3
cml0dGVuLgotLS0KIGRyaXZlcnMvZ3B1L2RybS9kcm1fZ2VtX3NobWVtX2hlbHBlci5jIHwg
NDYgKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCAxMiBpbnNl
cnRpb25zKCspLCAzNCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9k
cm0vZHJtX2dlbV9zaG1lbV9oZWxwZXIuYyBiL2RyaXZlcnMvZ3B1L2RybS9kcm1fZ2VtX3No
bWVtX2hlbHBlci5jCmluZGV4IDU0NTkzM2M3ZjcxMi4uMDdlMTE3NjczMTI0IDEwMDY0NAot
LS0gYS9kcml2ZXJzL2dwdS9kcm0vZHJtX2dlbV9zaG1lbV9oZWxwZXIuYworKysgYi9kcml2
ZXJzL2dwdS9kcm0vZHJtX2dlbV9zaG1lbV9oZWxwZXIuYwpAQCAtNTU0LDIxICs1NTQsNiBA
QCBpbnQgZHJtX2dlbV9zaG1lbV9kdW1iX2NyZWF0ZShzdHJ1Y3QgZHJtX2ZpbGUgKmZpbGUs
IHN0cnVjdCBkcm1fZGV2aWNlICpkZXYsCiB9CiBFWFBPUlRfU1lNQk9MX0dQTChkcm1fZ2Vt
X3NobWVtX2R1bWJfY3JlYXRlKTsKIAotc3RhdGljIHZvaWQgZHJtX2dlbV9zaG1lbV9yZWNv
cmRfbWt3cml0ZShzdHJ1Y3Qgdm1fZmF1bHQgKnZtZikKLXsKLQlzdHJ1Y3Qgdm1fYXJlYV9z
dHJ1Y3QgKnZtYSA9IHZtZi0+dm1hOwotCXN0cnVjdCBkcm1fZ2VtX29iamVjdCAqb2JqID0g
dm1hLT52bV9wcml2YXRlX2RhdGE7Ci0Jc3RydWN0IGRybV9nZW1fc2htZW1fb2JqZWN0ICpz
aG1lbSA9IHRvX2RybV9nZW1fc2htZW1fb2JqKG9iaik7Ci0JbG9mZl90IG51bV9wYWdlcyA9
IG9iai0+c2l6ZSA+PiBQQUdFX1NISUZUOwotCXBnb2ZmX3QgcGFnZV9vZmZzZXQgPSB2bWYt
PnBnb2ZmIC0gdm1hLT52bV9wZ29mZjsgLyogcGFnZSBvZmZzZXQgd2l0aGluIFZNQSAqLwot
Ci0JaWYgKGRybV9XQVJOX09OKG9iai0+ZGV2LCAhc2htZW0tPnBhZ2VzIHx8IHBhZ2Vfb2Zm
c2V0ID49IG51bV9wYWdlcykpCi0JCXJldHVybjsKLQotCWZpbGVfdXBkYXRlX3RpbWUodm1h
LT52bV9maWxlKTsKLQlmb2xpb19tYXJrX2RpcnR5KHBhZ2VfZm9saW8oc2htZW0tPnBhZ2Vz
W3BhZ2Vfb2Zmc2V0XSkpOwotfQotCiBzdGF0aWMgdm1fZmF1bHRfdCB0cnlfaW5zZXJ0X3Bm
bihzdHJ1Y3Qgdm1fZmF1bHQgKnZtZiwgdW5zaWduZWQgaW50IG9yZGVyLAogCQkJCSB1bnNp
Z25lZCBsb25nIHBmbikKIHsKQEAgLTU4MSwyMyArNTY2LDE2IEBAIHN0YXRpYyB2bV9mYXVs
dF90IHRyeV9pbnNlcnRfcGZuKHN0cnVjdCB2bV9mYXVsdCAqdm1mLCB1bnNpZ25lZCBpbnQg
b3JkZXIsCiAKIAkJaWYgKGFsaWduZWQgJiYKIAkJICAgIGZvbGlvX3Rlc3RfcG1kX21hcHBh
YmxlKHBhZ2VfZm9saW8ocGZuX3RvX3BhZ2UocGZuKSkpKSB7Ci0JCQl2bV9mYXVsdF90IHJl
dDsKLQogCQkJcGZuICY9IFBNRF9NQVNLID4+IFBBR0VfU0hJRlQ7CiAKLQkJCS8qIFVubGlr
ZSBQVEVzIHdoaWNoIGFyZSBhdXRvbWF0aWNhbGx5IHVwZ3JhZGVkIHRvCisJCQkvKgorCQkJ
ICogVW5saWtlIFBURXMgd2hpY2ggYXJlIGF1dG9tYXRpY2FsbHkgdXBncmFkZWQgdG8KIAkJ
CSAqIHdyaXRlYWJsZSBlbnRyaWVzLCB0aGUgUE1EIHVwZ3JhZGVzIGdvIHRocm91Z2gKIAkJ
CSAqIC5odWdlX2ZhdWx0KCkuIE1ha2Ugc3VyZSB3ZSBwYXNzIHRoZSAid3JpdGUiIGluZm8K
IAkJCSAqIGFsb25nIGluIHRoYXQgY2FzZS4KLQkJCSAqIFRoaXMgYWxzbyBtZWFucyB3ZSBo
YXZlIHRvIHJlY29yZCB0aGUgd3JpdGUgZmF1bHQKLQkJCSAqIGhlcmUsIGluc3RlYWQgb2Yg
aW4gLnBmbl9ta3dyaXRlKCkuCiAJCQkgKi8KLQkJCXJldCA9IHZtZl9pbnNlcnRfcGZuX3Bt
ZCh2bWYsIHBmbiwKLQkJCQkJCSB2bWYtPmZsYWdzICYgRkFVTFRfRkxBR19XUklURSk7Ci0J
CQlpZiAocmV0ID09IFZNX0ZBVUxUX05PUEFHRSAmJiAodm1mLT5mbGFncyAmIEZBVUxUX0ZM
QUdfV1JJVEUpKQotCQkJCWRybV9nZW1fc2htZW1fcmVjb3JkX21rd3JpdGUodm1mKTsKLQot
CQkJcmV0dXJuIHJldDsKKwkJCXJldHVybiB2bWZfaW5zZXJ0X3Bmbl9wbWQodm1mLCBwZm4s
CisJCQkJCQkgIHZtZi0+ZmxhZ3MgJiBGQVVMVF9GTEFHX1dSSVRFKTsKIAkJfQogI2VuZGlm
CiAJfQpAQCAtNjM1LDggKzYxMywxNSBAQCBzdGF0aWMgdm1fZmF1bHRfdCBkcm1fZ2VtX3No
bWVtX2FueV9mYXVsdChzdHJ1Y3Qgdm1fZmF1bHQgKnZtZiwgdW5zaWduZWQgaW50IG9yZAog
CXBmbiA9IHBhZ2VfdG9fcGZuKHBhZ2UpOwogCiAJcmV0ID0gdHJ5X2luc2VydF9wZm4odm1m
LCBvcmRlciwgcGZuKTsKLQlpZiAocmV0ID09IFZNX0ZBVUxUX05PUEFHRSkKKwlpZiAocmV0
ID09IFZNX0ZBVUxUX05PUEFHRSkgewogCQlmb2xpb19tYXJrX2FjY2Vzc2VkKGZvbGlvKTsK
KwkJLyoKKwkJICogQWx3YXlzIHJlY29yZCB3cml0ZSBhY2Nlc3MgdG8gdGhlIGJ1ZmZlci4g
VGhlIG5hdHVyYWwKKwkJICogcGxhY2Ugd291bGQgYmUgcGZuX21rd3JpdGUsIGJ1dCB0aGlz
IGJyZWFrcyBLVk0uCisJCSAqLworCQlmaWxlX3VwZGF0ZV90aW1lKHZtYS0+dm1fZmlsZSk7
CisJCWZvbGlvX21hcmtfZGlydHkoZm9saW8pOworCX0KIAogb3V0OgogCWRtYV9yZXN2X3Vu
bG9jayhvYmotPnJlc3YpOwpAQCAtNjgzLDEyICs2NjgsNiBAQCBzdGF0aWMgdm9pZCBkcm1f
Z2VtX3NobWVtX3ZtX2Nsb3NlKHN0cnVjdCB2bV9hcmVhX3N0cnVjdCAqdm1hKQogCWRybV9n
ZW1fdm1fY2xvc2Uodm1hKTsKIH0KIAotc3RhdGljIHZtX2ZhdWx0X3QgZHJtX2dlbV9zaG1l
bV9wZm5fbWt3cml0ZShzdHJ1Y3Qgdm1fZmF1bHQgKnZtZikKLXsKLQlkcm1fZ2VtX3NobWVt
X3JlY29yZF9ta3dyaXRlKHZtZik7Ci0JcmV0dXJuIDA7Ci19Ci0KIGNvbnN0IHN0cnVjdCB2
bV9vcGVyYXRpb25zX3N0cnVjdCBkcm1fZ2VtX3NobWVtX3ZtX29wcyA9IHsKIAkuZmF1bHQg
PSBkcm1fZ2VtX3NobWVtX2ZhdWx0LAogI2lmZGVmIENPTkZJR19BUkNIX1NVUFBPUlRTX1BN
RF9QRk5NQVAKQEAgLTY5Niw3ICs2NzUsNiBAQCBjb25zdCBzdHJ1Y3Qgdm1fb3BlcmF0aW9u
c19zdHJ1Y3QgZHJtX2dlbV9zaG1lbV92bV9vcHMgPSB7CiAjZW5kaWYKIAkub3BlbiA9IGRy
bV9nZW1fc2htZW1fdm1fb3BlbiwKIAkuY2xvc2UgPSBkcm1fZ2VtX3NobWVtX3ZtX2Nsb3Nl
LAotCS5wZm5fbWt3cml0ZSA9IGRybV9nZW1fc2htZW1fcGZuX21rd3JpdGUsCiB9OwogRVhQ
T1JUX1NZTUJPTF9HUEwoZHJtX2dlbV9zaG1lbV92bV9vcHMpOwogCi0tIAoyLjU0LjAKCg==


--------------qEORVyYFqwCDMYi1Vb0xhvqj--
