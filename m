Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D61BF013D5
	for <dri-devel@archiver.kernel.org>; Mon, 16 Mar 2026 08:45:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4154A10E344;
	Mon, 16 Mar 2026 08:45:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="RKnM5v0i";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="bh7FO9X1";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="RKnM5v0i";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="bh7FO9X1";
	dkim-atps=neutral
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 58D4610E36B
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 08:45:51 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0438D4D1C7;
 Mon, 16 Mar 2026 08:45:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1773650750; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=UcK0mCj2Jo8AI0kfTvelbnqRTyW2MZtbydy4WExAfks=;
 b=RKnM5v0iKaypRbV+xk8QYDgskUYIsvLndYi1j/JP8u9VZm6G9nQOEX41GheDP8TXTIONOO
 tvEAYh2rdn93ub8L8YJSOzyhT8RWrEEn2yiwdYuVanXap/ScmKn/Mdsi3KSbP5ttD7pMay
 vBBgzYeHGAJPAej5MoN0+CC0Eup+Ma8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1773650750;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=UcK0mCj2Jo8AI0kfTvelbnqRTyW2MZtbydy4WExAfks=;
 b=bh7FO9X12wVVbZW3DBYdD2VW0HVn01MPJI5/g6y3nFrehfRxQINgYmyBsSS9j5evGnEsTX
 SwIg8GZZx7P7/gDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1773650750; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=UcK0mCj2Jo8AI0kfTvelbnqRTyW2MZtbydy4WExAfks=;
 b=RKnM5v0iKaypRbV+xk8QYDgskUYIsvLndYi1j/JP8u9VZm6G9nQOEX41GheDP8TXTIONOO
 tvEAYh2rdn93ub8L8YJSOzyhT8RWrEEn2yiwdYuVanXap/ScmKn/Mdsi3KSbP5ttD7pMay
 vBBgzYeHGAJPAej5MoN0+CC0Eup+Ma8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1773650750;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=UcK0mCj2Jo8AI0kfTvelbnqRTyW2MZtbydy4WExAfks=;
 b=bh7FO9X12wVVbZW3DBYdD2VW0HVn01MPJI5/g6y3nFrehfRxQINgYmyBsSS9j5evGnEsTX
 SwIg8GZZx7P7/gDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9963D4273B;
 Mon, 16 Mar 2026 08:45:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 9UkHJD3Dt2nrbgAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Mon, 16 Mar 2026 08:45:49 +0000
Message-ID: <53f11658-5466-49a3-816a-ff6fd2e1da6f@suse.de>
Date: Mon, 16 Mar 2026 09:45:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/6] drm/gem-shmem: Track folio accessed/dirty status
 in mmap
To: Boris Brezillon <boris.brezillon@collabora.com>,
 Biju Das <biju.das.jz@bp.renesas.com>
Cc: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>,
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
 <TY3PR01MB113461ACB668738E1952EC8898645A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <20260313111851.4c1f89f3@fedora>
 <f3384342-cdc5-4260-b670-4ffde76a2802@suse.de>
 <20260313125644.65131b27@fedora>
 <TY3PR01MB1134662A395AA0A048CEE152E8645A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <20260313131835.52c5c935@fedora> <20260313134328.3166c4d0@fedora>
 <20260313135521.07823792@fedora> <20260313184549.08656eed@fedora>
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
In-Reply-To: <20260313184549.08656eed@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 TO_DN_EQ_ADDR_SOME(0.00)[]; RCPT_COUNT_TWELVE(0.00)[13];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_TRACE(0.00)[0:+]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; ARC_NA(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 FREEMAIL_CC(0.00)[bp.renesas.com,collabora.com,infradead.org,imgtec.com,linux.intel.com,kernel.org,gmail.com,ffwll.ch,kvack.org,lists.freedesktop.org];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:url,suse.de:mid,suse.de:email]
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

Hi Boris,

thanks for investigating this problem.

Am 13.03.26 um 18:45 schrieb Boris Brezillon:
> On Fri, 13 Mar 2026 13:55:21 +0100
> Boris Brezillon <boris.brezillon@collabora.com> wrote:
>
>> On Fri, 13 Mar 2026 13:43:28 +0100
>> Boris Brezillon <boris.brezillon@collabora.com> wrote:
>>
>>> On Fri, 13 Mar 2026 13:18:35 +0100
>>> Boris Brezillon <boris.brezillon@collabora.com> wrote:
>>>    
>>>> On Fri, 13 Mar 2026 12:04:25 +0000
>>>> Biju Das <biju.das.jz@bp.renesas.com> wrote:
>>>>      
>>>>>> -----Original Message-----
>>>>>> From: dri-devel <dri-devel-bounces@lists.freedesktop.org> On Behalf Of Boris Brezillon
>>>>>> Sent: 13 March 2026 11:57
>>>>>> Subject: Re: [PATCH v4 5/6] drm/gem-shmem: Track folio accessed/dirty status in mmap
>>>>>>
>>>>>> On Fri, 13 Mar 2026 11:29:47 +0100
>>>>>> Thomas Zimmermann <tzimmermann@suse.de> wrote:
>>>>>>          
>>>>>>> Hi
>>>>>>>
>>>>>>> Am 13.03.26 um 11:18 schrieb Boris Brezillon:
>>>>>>> [...]
>>>>>>>>>>>> +	if (drm_WARN_ON(obj->dev, !shmem->pages || page_offset >= num_pages))
>>>>>>>>>>>> +		return VM_FAULT_SIGBUS;
>>>>>>>>>>>> +
>>>>>>>>>>>> +	file_update_time(vma->vm_file);
>>>>>>>>>>>> +
>>>>>>>>>>>> +	folio_mark_dirty(page_folio(shmem->pages[page_offset]));
>>>>>>>> Do we need a folio_mark_dirty_lock() here?
>>>>>>> There is a helper for that with some documentation. [1]
>>>>>> This [1] seems to solve the problem for me. Still unsure about the folio_mark_dirty_lock vs
>>>>>> folio_mark_dirty though.
>>>>>>
>>>>>> [1]https://yhbt.net/lore/dri-devel/20260312155027.1682606-1-pedrodemargomes@gmail.com/
>>>>> FYI, I used folio_mark_dirty_lock() still it does not solve the issue with weston hang.
>>>> The patch I pointed to has nothing to do with folio_mark_dirty_lock(),
>>>> It's a bug caused by huge page mapping changes.
>>> Scratch that. I had a bunch of other changes on top, and it hangs again
>>> now that I dropped those.
>> Seems like it's the combination of huge pages and mkwrite that's
>> causing issues, if I disable huge pages, it doesn't hang...
> I managed to have it working with the following diff. I still need to
> check why the "map-RO-split+RW-on-demand" approach doesn't work (races
> between huge_fault and pfn_mkwrite?), but I think it's okay to map the
> real thing writable on the first attempt anyway (we're not trying to do
> CoW here, since we're always pointing to the same page, it's just the
> permissions that change). Note that there's still the race fixed by
> https://yhbt.net/lore/dri-devel/20260312155027.1682606-1-pedrodemargomes@gmail.com/
> in this diff, I just tried to keep the diffstat minimal.
>
> --->8---
> diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
> index 4500deef4127..4efdce5a60f0 100644
> --- a/drivers/gpu/drm/drm_gem_shmem_helper.c
> +++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
> @@ -561,9 +561,8 @@ static vm_fault_t drm_gem_shmem_try_insert_pfn_pmd(struct vm_fault *vmf, unsigne
>          bool aligned = (vmf->address & ~PMD_MASK) == (paddr & ~PMD_MASK);
>   
>          if (aligned && pmd_none(*vmf->pmd)) {
> -               /* Read-only mapping; split upon write fault */
>                  pfn &= PMD_MASK >> PAGE_SHIFT;
> -               return vmf_insert_pfn_pmd(vmf, pfn, false);
> +               return vmf_insert_pfn_pmd(vmf, pfn, vmf->flags & FAULT_FLAG_WRITE);
>          }
>   #endif
>   
> @@ -597,8 +596,12 @@ static vm_fault_t drm_gem_shmem_fault(struct vm_fault *vmf)
>   
>          pfn = page_to_pfn(page);
>   
> -       if (folio_test_pmd_mappable(folio))
> +       if (folio_test_pmd_mappable(folio)) {
>                  ret = drm_gem_shmem_try_insert_pfn_pmd(vmf, pfn);
> +               if (ret == VM_FAULT_NOPAGE && vmf->flags & FAULT_FLAG_WRITE)
> +                       folio_mark_dirty(folio);
> +       }
> +
>          if (ret != VM_FAULT_NOPAGE)
>                  ret = vmf_insert_pfn(vma, vmf->address, pfn);

All these branches with NOPAGE seem confusing. Can we change the overall 
logic here? Something like:

if (folio_test_pmd_mappable()) {
     ret = try_insert_pfn_pmd()
     if (ret == VM_FAULT_NOPAGE) {
         folio_mark_accessed()
         if (flags & FLAG_WRITE)
             folio_mark_dirty()
         goto out;
     }
}

ret = vmf_insert_pfn()
if (ret == NOPAGE)
     folio_mark_accesed()

out:
   ...


This would keep the huge-page code within the first branch. And if it 
fails, it still does the regular page fault.

Best regards
Thomas

>   

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG Nürnberg)


