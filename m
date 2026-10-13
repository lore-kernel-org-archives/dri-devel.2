Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E555CC6B0E
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 07:18:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A364610F506;
	Tue, 13 Oct 2026 07:18:08 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E59ED10F501;
 Tue, 13 Oct 2026 07:17:56 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 736BB1F788;
 Tue, 13 Oct 2026 07:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1791875875; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=6LdaKbJxHh3w5tco5BvI0wrfqbELlAgnB3Y/NNN7uaE=;
 b=dCNEVs8yZxb1mZVU7tJnIPzX6mSKMIM7l7FoGpdb2IGDyVENYqy4MkkoDMzje3329Z7GbE
 cWpQaHFiQHXij/PPcsOO1nN+GEPafkYZ90tpfVtc7jokcbrbzTr08lmrpJ1C6zSZYWxy7N
 u5ujPv6jsXHFOtdF3bLDPWel4G/Rwlg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1791875875;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=6LdaKbJxHh3w5tco5BvI0wrfqbELlAgnB3Y/NNN7uaE=;
 b=oAznGZNrG9Vk3NQfpJ3SkQTBTc45HvrtByiJOaCT7sYfOAD41/EZJOl8Kt0hsYB/cBRxbP
 llOztH+cOk17MrBA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ww3QvrcE;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=77iwrg96
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1791875874; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=6LdaKbJxHh3w5tco5BvI0wrfqbELlAgnB3Y/NNN7uaE=;
 b=ww3QvrcECt0DHg23zB+7Zq0OpnyHlmm9QJZitaJZEOgIOL9guo3f4+nT7xcLDSPqBtmO/a
 Agwd6zQoyKVVEa09D12lqmM8VhOGqwwOR0wEUd7clQt8jsu/99J4MHkXlVEJ+C6ciL/l64
 zk+FGsr5xFjCWm2qwNovQYUYX76UhAg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1791875874;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=6LdaKbJxHh3w5tco5BvI0wrfqbELlAgnB3Y/NNN7uaE=;
 b=77iwrg96yZhi/5tCD/5pWK+/e8SOnzyomnxVY8DsuUy3Kib9BeO7iiS3+sASP03uVgUWNK
 CH0Z3ie4oDXuw9DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 304EC1349D;
 Tue, 13 Oct 2026 07:17:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id pOcYASLbzWpXVQAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Tue, 13 Oct 2026 07:17:54 +0000
Message-ID: <ff266a33-2729-47b4-8a1e-ff96bb456782@suse.de>
Date: Tue, 13 Oct 2026 09:17:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/6] drm/gem: add drm_gem_prime_dma_buf_to_gem()
 self-import helper
To: Matthew Brost <matthew.brost@intel.com>,
 Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>
Cc: dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org
References: <20261013010614.1516799-8-niranjana.vishwanathapura@intel.com>
 <20261013010614.1516799-11-niranjana.vishwanathapura@intel.com>
 <as2LL7IIs6EcL6Pj@gsse-cloud1.jf.intel.com>
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
In-Reply-To: <as2LL7IIs6EcL6Pj@gsse-cloud1.jf.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 736BB1F788
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 XM_UA_NO_VERSION(0.01)[]; MX_GOOD(-0.01)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:url,suse.de:dkim,intel.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
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

Am 13.10.26 um 03:36 schrieb Matthew Brost:
> On Mon, Oct 12, 2026 at 06:06:15PM -0700, Niranjana Vishwanathapura wrote:
>> drm_gem_is_prime_exported_dma_buf() is a bool predicate that open-codes
>> the core PRIME self-import check. Its only caller, the shmem importer,
>> then repeats the dma_buf->priv lookup and the reference get.
>>
>> Replace it with drm_gem_prime_dma_buf_to_gem(), a thin wrapper around
>> drm_gem_prime_self_import() that returns the backing GEM object -- with
>> a reference taken -- for a core-PRIME self-export, or NULL otherwise.
>> This consolidates self-import handling onto drm_gem_prime_self_import()
>> and lets drm_gem_shmem_prime_import_no_map() reuse the object directly.
>>
>> Unlike the removed predicate, the helper takes a reference on the
>> returned object; the sole caller already wanted the referenced object.
>>
>> Assisted-by: GitHub-Copilot:claude-opus-4.8
> Assisted-by: LLM
>
> I was going to suggest this last rev too as I noticed
> drm_gem_shmem_prime_import_no_map called
> drm_gem_is_prime_exported_dma_buf which should prefer the new helper but
> shmem couldn't look at drm_gem_prime_dmabuf_ops.
>
> This is a good cleanup:

No it's not. Please see my reply to the cover letter.

Best regards
Thomas

>
> Reviewed-by: Matthew Brost <matthew.brost@intel.com>
>
>> Signed-off-by: Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>
>> ---
>>   drivers/gpu/drm/drm_gem_shmem_helper.c | 14 ++++++--------
>>   drivers/gpu/drm/drm_prime.c            | 26 +++++++++++++++-----------
>>   include/drm/drm_prime.h                |  4 ++--
>>   3 files changed, 23 insertions(+), 21 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
>> index d654a22a30de..a0e161f2333e 100644
>> --- a/drivers/gpu/drm/drm_gem_shmem_helper.c
>> +++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
>> @@ -954,15 +954,13 @@ struct drm_gem_object *drm_gem_shmem_prime_import_no_map(struct drm_device *dev,
>>   	size_t size;
>>   	int ret;
>>   
>> -	if (drm_gem_is_prime_exported_dma_buf(dev, dma_buf)) {
>> -		/*
>> -		 * Importing dmabuf exported from our own gem increases
>> -		 * refcount on gem itself instead of f_count of dmabuf.
>> -		 */
>> -		obj = dma_buf->priv;
>> -		drm_gem_object_get(obj);
>> +	/*
>> +	 * Importing a dmabuf exported from our own gem increases the refcount
>> +	 * on the gem itself instead of the f_count of the dmabuf.
>> +	 */
>> +	obj = drm_gem_prime_dma_buf_to_gem(dev, dma_buf);
>> +	if (obj)
>>   		return obj;
>> -	}
>>   
>>   	attach = dma_buf_attach(dma_buf, dev->dev);
>>   	if (IS_ERR(attach))
>> diff --git a/drivers/gpu/drm/drm_prime.c b/drivers/gpu/drm/drm_prime.c
>> index 588910c250b8..275c5661528d 100644
>> --- a/drivers/gpu/drm/drm_prime.c
>> +++ b/drivers/gpu/drm/drm_prime.c
>> @@ -933,23 +933,27 @@ EXPORT_SYMBOL(drm_gem_prime_export);
>>   
>>   
>>   /**
>> - * drm_gem_is_prime_exported_dma_buf -
>> - * checks if the DMA-BUF was exported from a GEM object belonging to @dev.
>> + * drm_gem_prime_dma_buf_to_gem - GEM object backing a self-exported PRIME dma-buf
>>    * @dev: drm_device to check against
>>    * @dma_buf: dma-buf object to import
>>    *
>> - * Return: true if the DMA-BUF was exported from a GEM object belonging
>> - * to @dev, false otherwise.
>> + * If @dma_buf is a PRIME export of a GEM object that belongs to @dev and uses
>> + * the core PRIME dma-buf ops, return that GEM object with an extra reference
>> + * taken, so a self-import reuses the GEM object instead of referencing the
>> + * dma-buf file. Returns NULL for a foreign dma-buf or one using driver-private
>> + * ops; such drivers call drm_gem_prime_self_import() with their own ops.
>> + *
>> + * The returned object carries a reference the caller must drop with
>> + * drm_gem_object_put().
>> + *
>> + * Return: the referenced GEM object on self-import, or NULL otherwise.
>>    */
>> -
>> -bool drm_gem_is_prime_exported_dma_buf(struct drm_device *dev,
>> -				       struct dma_buf *dma_buf)
>> +struct drm_gem_object *drm_gem_prime_dma_buf_to_gem(struct drm_device *dev,
>> +						    struct dma_buf *dma_buf)
>>   {
>> -	struct drm_gem_object *obj = dma_buf->priv;
>> -
>> -	return (dma_buf->ops == &drm_gem_prime_dmabuf_ops) && (obj->dev == dev);
>> +	return drm_gem_prime_self_import(dev, dma_buf, &drm_gem_prime_dmabuf_ops);
>>   }
>> -EXPORT_SYMBOL(drm_gem_is_prime_exported_dma_buf);
>> +EXPORT_SYMBOL(drm_gem_prime_dma_buf_to_gem);
>>   
>>   /**
>>    * drm_gem_prime_import_dev - core implementation of the import callback
>> diff --git a/include/drm/drm_prime.h b/include/drm/drm_prime.h
>> index d378404f8ab4..02665205aed1 100644
>> --- a/include/drm/drm_prime.h
>> +++ b/include/drm/drm_prime.h
>> @@ -101,8 +101,8 @@ struct dma_buf *drm_gem_prime_export(struct drm_gem_object *obj,
>>   unsigned long drm_prime_get_contiguous_size(struct sg_table *sgt);
>>   
>>   /* helper functions for importing */
>> -bool drm_gem_is_prime_exported_dma_buf(struct drm_device *dev,
>> -				       struct dma_buf *dma_buf);
>> +struct drm_gem_object *drm_gem_prime_dma_buf_to_gem(struct drm_device *dev,
>> +						    struct dma_buf *dma_buf);
>>   
>>   struct drm_gem_object *drm_gem_prime_import_dev(struct drm_device *dev,
>>   						struct dma_buf *dma_buf,
>> -- 
>> 2.43.0
>>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Stefan Gaiser, Jochen Jaser, Abhinav Puri, (HRB 36809, AG Nürnberg)


