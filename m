Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DB9ACD5BD1
	for <dri-devel@archiver.kernel.org>; Thu, 28 May 2026 07:20:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB6F210ECF6;
	Thu, 28 May 2026 07:20:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="QtaFnWQF";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="iHu8vGn4";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="QtaFnWQF";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="iHu8vGn4";
	dkim-atps=neutral
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C8DF010ECF6
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 07:20:18 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 7F4C6672DF;
 Thu, 28 May 2026 07:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1779952817; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=5aGcI9PPptELztrSCxzrX/AUy6F2vWs30qm/fc1s9Tw=;
 b=QtaFnWQFawYVNkUmrRSO0WLEV6rZioksyVJhIgoJrX5A5WydoctYNUEJEKtfmUJW81VH2V
 UxLRzyAF+9YiS+eBCjKVQHdteLTyi9pg3snxLVFkehOVelVDMG4lMjVlh+6+A1uFo8nBz8
 emKa+JfrJcS5seeb2a3olpPMBzPw/QA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1779952817;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=5aGcI9PPptELztrSCxzrX/AUy6F2vWs30qm/fc1s9Tw=;
 b=iHu8vGn4Q8GAd1qGjX/u0e2E5GA/M/cNqeFQKJGbMU8ZYqB/uoWpYINqQ0MQu4mTVpLWu0
 E9EkdtulJw3/5qBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1779952817; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=5aGcI9PPptELztrSCxzrX/AUy6F2vWs30qm/fc1s9Tw=;
 b=QtaFnWQFawYVNkUmrRSO0WLEV6rZioksyVJhIgoJrX5A5WydoctYNUEJEKtfmUJW81VH2V
 UxLRzyAF+9YiS+eBCjKVQHdteLTyi9pg3snxLVFkehOVelVDMG4lMjVlh+6+A1uFo8nBz8
 emKa+JfrJcS5seeb2a3olpPMBzPw/QA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1779952817;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=5aGcI9PPptELztrSCxzrX/AUy6F2vWs30qm/fc1s9Tw=;
 b=iHu8vGn4Q8GAd1qGjX/u0e2E5GA/M/cNqeFQKJGbMU8ZYqB/uoWpYINqQ0MQu4mTVpLWu0
 E9EkdtulJw3/5qBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 302F45AC77;
 Thu, 28 May 2026 07:20:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id uR2LCrHsF2qMRQAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Thu, 28 May 2026 07:20:17 +0000
Message-ID: <4a00d72c-9b87-4511-9da0-bcb40fae4d74@suse.de>
Date: Thu, 28 May 2026 09:20:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/6] drm/gem-shmem: Track folio accessed/dirty status
 in mmap
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: Igor Torrente <igor.torrente@collabora.com>, loic.molinari@collabora.com, 
 willy@infradead.org, frank.binns@imgtec.com, matt.coster@imgtec.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, airlied@gmail.com,
 simona@ffwll.ch, dri-devel@lists.freedesktop.org, linux-mm@kvack.org
References: <20260209133241.238813-1-tzimmermann@suse.de>
 <20260209133241.238813-6-tzimmermann@suse.de>
 <d89422f1-f00a-47b1-b68a-d949d6d6a974@collabora.com>
 <850e8355-7884-405c-a70a-986ce032c019@suse.de>
 <831c0943-c75f-4d42-aa5f-90ce34cf8530@collabora.com>
 <67855fcd-2afe-4a1d-a51a-210e45f56167@suse.de>
 <20260527121832.7264f0db@fedora>
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
In-Reply-To: <20260527121832.7264f0db@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 MIME_TRACE(0.00)[0:+]; RCPT_COUNT_TWELVE(0.00)[12];
 RCVD_TLS_ALL(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[collabora.com,infradead.org,imgtec.com,linux.intel.com,kernel.org,gmail.com,ffwll.ch,lists.freedesktop.org,kvack.org];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:url, imap1.dmz-prg2.suse.org:helo,
 suse.de:mid]
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

Am 27.05.26 um 12:18 schrieb Boris Brezillon:
[...]
>> -			return ret;
>> +			return vmf_insert_pfn_pmd(vmf, pfn,
>> +						  vmf->flags & FAULT_FLAG_WRITE);
> I believe we can go back to
>
> 			return vmf_insert_pfn_pmd(vmf, pfn, false);
>
> if the mappings are no longer adjusted to catch write accesses.

If we don't install it as writable now, won't the kernel not split it up 
into 4KiB pages when the actual write happens? If so, this might impact 
performance negatively.

Best regards
Thomas


>
>>   		}
>>   #endif
>>   	}
>> @@ -635,8 +613,15 @@ static vm_fault_t drm_gem_shmem_any_fault(struct vm_fault *vmf, unsigned int ord
>>   	pfn = page_to_pfn(page);
>>   
>>   	ret = try_insert_pfn(vmf, order, pfn);
>> -	if (ret == VM_FAULT_NOPAGE)
>> +	if (ret == VM_FAULT_NOPAGE) {
>>   		folio_mark_accessed(folio);
>> +		/*
>> +		 * Always record write access to the buffer. The natural
>> +		 * place would be pfn_mkwrite, but this breaks KVM.
>> +		 */
>> +		file_update_time(vma->vm_file);
>> +		folio_mark_dirty(folio);
> We can be a bit smarter here:
>
> 		/*
> 		 * Always record write access to the buffer if the
> 		 * mapping is writeable. The natural place would be
> 		 * pfn_mkwrite, but this breaks KVM.
> 		 */
> 		if (vma->vm_flags & VM_WRITE) {
> 			file_update_time(vma->vm_file);
> 			folio_mark_dirty(folio);
> 		}
>
>> +	}
> The rest looks good to me.
>
> Regards,
>
> Boris

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG Nürnberg)


