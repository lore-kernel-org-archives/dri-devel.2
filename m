Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF292106FD9E
	for <dri-devel@archiver.kernel.org>; Fri, 13 Mar 2026 08:33:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5CA6E10EB30;
	Fri, 13 Mar 2026 08:33:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="Xtt7juVZ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="AR1jn7Xj";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Xtt7juVZ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="AR1jn7Xj";
	dkim-atps=neutral
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ABA7C10EB30
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 08:33:42 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 5405D5CFD9;
 Fri, 13 Mar 2026 08:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1773390821; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=By/5ukn2mwKOcgj/f+9D00tvg2cfhX8HhLGnGYQXqis=;
 b=Xtt7juVZnOR+TX/3aKQVKYH4jA5lwyX1gJfyddLaPoit4EXLrx7beuoZPoIUr/7pa7+c++
 JezHlC2b8MjF+kVD7zlO7lV6VIVkgptp1gfb3VTDqFRGI1ARiJX/rcomq/4a91jUpdpg+W
 rOT3g1BvlXkgAvdRS2duRmyv6Rbgk4w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1773390821;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=By/5ukn2mwKOcgj/f+9D00tvg2cfhX8HhLGnGYQXqis=;
 b=AR1jn7XjRExFQnH6CLbctLjz9P5lTakrIJzXfuc52EULHxZxVqswY0YIftY+7neJOogX5f
 2jXtr3HjtV6cbfDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1773390821; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=By/5ukn2mwKOcgj/f+9D00tvg2cfhX8HhLGnGYQXqis=;
 b=Xtt7juVZnOR+TX/3aKQVKYH4jA5lwyX1gJfyddLaPoit4EXLrx7beuoZPoIUr/7pa7+c++
 JezHlC2b8MjF+kVD7zlO7lV6VIVkgptp1gfb3VTDqFRGI1ARiJX/rcomq/4a91jUpdpg+W
 rOT3g1BvlXkgAvdRS2duRmyv6Rbgk4w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1773390821;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=By/5ukn2mwKOcgj/f+9D00tvg2cfhX8HhLGnGYQXqis=;
 b=AR1jn7XjRExFQnH6CLbctLjz9P5lTakrIJzXfuc52EULHxZxVqswY0YIftY+7neJOogX5f
 2jXtr3HjtV6cbfDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 02E3B40423;
 Fri, 13 Mar 2026 08:33:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id +8fqOuTLs2lVSAAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Fri, 13 Mar 2026 08:33:40 +0000
Content-Type: multipart/mixed; boundary="------------7ZdkRrZrk9ysaFnV0R6IQqxK"
Message-ID: <d3818663-2673-4de4-b483-557602f6e8b9@suse.de>
Date: Fri, 13 Mar 2026 09:33:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/6] drm/gem-shmem: Track folio accessed/dirty status
 in mmap
To: Biju Das <biju.das.jz@bp.renesas.com>,
 Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Cc: "boris.brezillon@collabora.com" <boris.brezillon@collabora.com>,
 "loic.molinari@collabora.com" <loic.molinari@collabora.com>,
 "willy@infradead.org" <willy@infradead.org>,
 "frank.binns@imgtec.com" <frank.binns@imgtec.com>,
 "matt.coster@imgtec.com" <matt.coster@imgtec.com>,
 "maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
 "mripard@kernel.org" <mripard@kernel.org>,
 "airlied@gmail.com" <airlied@gmail.com>, "simona@ffwll.ch"
 <simona@ffwll.ch>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
References: <20260227114509.165572-1-tzimmermann@suse.de>
 <20260227114509.165572-6-tzimmermann@suse.de> <abL5rcYIaFFO3GW2@tom-desktop>
 <TY3PR01MB113460CA616D3576DA0C3FC698644A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
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
In-Reply-To: <TY3PR01MB113460CA616D3576DA0C3FC698644A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
X-Spamd-Result: default: False [-3.20 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MIME_BASE64_TEXT_BOGUS(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_BASE64_TEXT(0.10)[];
 MIME_GOOD(-0.10)[multipart/mixed,text/plain,text/x-patch];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; TO_DN_EQ_ADDR_SOME(0.00)[];
 ARC_NA(0.00)[]; RCPT_COUNT_TWELVE(0.00)[13];
 MIME_TRACE(0.00)[0:+,1:+,2:+]; RCVD_TLS_ALL(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[collabora.com,infradead.org,imgtec.com,linux.intel.com,kernel.org,gmail.com,ffwll.ch,kvack.org,lists.freedesktop.org];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email,collabora.com:email,suse.com:url,renesas.com:email];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 HAS_ATTACHMENT(0.00)[]
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
--------------7ZdkRrZrk9ysaFnV0R6IQqxK
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi

Am 12.03.26 um 18:46 schrieb Biju Das:
> Hi Tommaso,
>
>> -----Original Message-----
>> From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
>> Sent: 12 March 2026 17:37
>> Subject: Re: [PATCH v4 5/6] drm/gem-shmem: Track folio accessed/dirty status in mmap
>>
>> Hi Thomas,
>> Thanks for your patch.
>>
>> I'm working on DSI support for RZ/G3E from this morning rebasing on top of next-20260311 I'm seeing
>> that weston hang on my side:
>>
>> Reverting this patch fix the issue.
>> (git revert 28e3918179aa)

Just a guess, but maybe vm_file is NULL. The attached patch should 
handle this. Could either of you please test?

Best regards
Thomas


>>
>> I'm wondering if anyone encountered this issue?
>> Thanks in advance.
>
> I am also seeing same issue on RZ/G3L with weston.
>
> Cheers,
> Biju
>
>
>
>> Kind Regards,
>> Tommaso
>>
>> On Fri, Feb 27, 2026 at 12:42:10PM +0100, Thomas Zimmermann wrote:
>>> Invoke folio_mark_accessed() in mmap page faults to add the folio to
>>> the memory manager's LRU list. Userspace invokes mmap to get the
>>> memory for software rendering. Compositors do the same when creating
>>> the final on-screen image, so keeping the pages in LRU makes sense.
>>> Avoids paging out graphics buffers when under memory pressure.
>>>
>>> In pfn_mkwrite, further invoke the folio_mark_dirty() to add the folio
>>> for writeback should the underlying file be paged out from system memory.
>>> This rarely happens in practice, yet it would corrupt the buffer content.
>>>
>>> This has little effect on a system's hardware-accelerated rendering,
>>> which only mmaps for an initial setup of textures, meshes, shaders, etc.
>>>
>>> v4:
>>> - test for VM_FAULT_NOPAGE before marking folio as accessed (Boris)
>>> - test page-array bounds in mkwrite handler (Boris)
>>> v3:
>>> - rewrite for VM_PFNMAP
>>> v2:
>>> - adapt to changes in drm_gem_shmem_try_mmap_pmd()
>>>
>>> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
>>> Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
>>> ---
>>>   drivers/gpu/drm/drm_gem_shmem_helper.c | 22 ++++++++++++++++++++++
>>>   1 file changed, 22 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c
>>> b/drivers/gpu/drm/drm_gem_shmem_helper.c
>>> index cefa50eaf7a4..1ab2bbd3860c 100644
>>> --- a/drivers/gpu/drm/drm_gem_shmem_helper.c
>>> +++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
>>> @@ -598,6 +598,9 @@ static vm_fault_t drm_gem_shmem_fault(struct vm_fault *vmf)
>>>   	if (ret != VM_FAULT_NOPAGE)
>>>   		ret = vmf_insert_pfn(vma, vmf->address, pfn);
>>>
>>> +	if (ret == VM_FAULT_NOPAGE)
>>> +		folio_mark_accessed(folio);
>>> +
>>>   out:
>>>   	dma_resv_unlock(obj->resv);
>>>
>>> @@ -638,10 +641,29 @@ static void drm_gem_shmem_vm_close(struct vm_area_struct *vma)
>>>   	drm_gem_vm_close(vma);
>>>   }
>>>
>>> +static vm_fault_t drm_gem_shmem_pfn_mkwrite(struct vm_fault *vmf) {
>>> +	struct vm_area_struct *vma = vmf->vma;
>>> +	struct drm_gem_object *obj = vma->vm_private_data;
>>> +	struct drm_gem_shmem_object *shmem = to_drm_gem_shmem_obj(obj);
>>> +	loff_t num_pages = obj->size >> PAGE_SHIFT;
>>> +	pgoff_t page_offset = vmf->pgoff - vma->vm_pgoff; /* page offset
>>> +within VMA */
>>> +
>>> +	if (drm_WARN_ON(obj->dev, !shmem->pages || page_offset >= num_pages))
>>> +		return VM_FAULT_SIGBUS;
>>> +
>>> +	file_update_time(vma->vm_file);
>>> +
>>> +	folio_mark_dirty(page_folio(shmem->pages[page_offset]));
>>> +
>>> +	return 0;
>>> +}
>>> +
>>>   const struct vm_operations_struct drm_gem_shmem_vm_ops = {
>>>   	.fault = drm_gem_shmem_fault,
>>>   	.open = drm_gem_shmem_vm_open,
>>>   	.close = drm_gem_shmem_vm_close,
>>> +	.pfn_mkwrite = drm_gem_shmem_pfn_mkwrite,
>>>   };
>>>   EXPORT_SYMBOL_GPL(drm_gem_shmem_vm_ops);
>>>
>>> --
>>> 2.52.0
>>>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG Nürnberg)


--------------7ZdkRrZrk9ysaFnV0R6IQqxK
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-test-for-vm_file-before-updating-file-access-time.patch"
Content-Disposition: attachment;
 filename*0="0001-test-for-vm_file-before-updating-file-access-time.patch"
Content-Transfer-Encoding: base64

RnJvbSBlNjQzNDZjNmIzZDk0NmU0NDI0MDY2ZDg4OGNiNDFmZTYwZWI5ZDg4IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBUaG9tYXMgWmltbWVybWFubiA8dHppbW1lcm1hbm5A
c3VzZS5kZT4KRGF0ZTogRnJpLCAxMyBNYXIgMjAyNiAwOToyOToyNiArMDEwMApTdWJqZWN0
OiBbUEFUQ0hdIHRlc3QgZm9yIHZtX2ZpbGUgYmVmb3JlIHVwZGF0aW5nIGZpbGUgYWNjZXNz
IHRpbWUKCi0tLQogZHJpdmVycy9ncHUvZHJtL2RybV9nZW1fc2htZW1faGVscGVyLmMgfCAz
ICsrLQogMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQoK
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9kcm1fZ2VtX3NobWVtX2hlbHBlci5jIGIv
ZHJpdmVycy9ncHUvZHJtL2RybV9nZW1fc2htZW1faGVscGVyLmMKaW5kZXggNDUwMGRlZWY0
MTI3Li43ZmFkNzJjYzAxZGMgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9kcm1fZ2Vt
X3NobWVtX2hlbHBlci5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9kcm1fZ2VtX3NobWVtX2hl
bHBlci5jCkBAIC02NTYsNyArNjU2LDggQEAgc3RhdGljIHZtX2ZhdWx0X3QgZHJtX2dlbV9z
aG1lbV9wZm5fbWt3cml0ZShzdHJ1Y3Qgdm1fZmF1bHQgKnZtZikKIAlpZiAoZHJtX1dBUk5f
T04ob2JqLT5kZXYsICFzaG1lbS0+cGFnZXMgfHwgcGFnZV9vZmZzZXQgPj0gbnVtX3BhZ2Vz
KSkKIAkJcmV0dXJuIFZNX0ZBVUxUX1NJR0JVUzsKIAotCWZpbGVfdXBkYXRlX3RpbWUodm1h
LT52bV9maWxlKTsKKwlpZiAodm1hLT52bV9maWxlKQorCQlmaWxlX3VwZGF0ZV90aW1lKHZt
YS0+dm1fZmlsZSk7CiAKIAlmb2xpb19tYXJrX2RpcnR5KHBhZ2VfZm9saW8oc2htZW0tPnBh
Z2VzW3BhZ2Vfb2Zmc2V0XSkpOwogCi0tIAoyLjUzLjAKCg==

--------------7ZdkRrZrk9ysaFnV0R6IQqxK--
