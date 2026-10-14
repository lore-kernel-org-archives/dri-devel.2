Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39AF3CC6B1A
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 07:22:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5172310E74D;
	Wed, 14 Oct 2026 07:22:29 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C05210E74D;
 Wed, 14 Oct 2026 07:22:17 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id BD06322185;
 Wed, 14 Oct 2026 07:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1791962535; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=kMb2PUq7ja7EUiS+Q08ZX7s6AL5bu9ht7JoEhjzDB/Y=;
 b=OsZFwrhyCGP2CK9sIweImaTQVBlFQLjWJ2zDoS35N5fFD3RNZ/Hb74Mm/v0MRZmb3Sam/H
 ruFn6TMVGnvfqgDpqMRLqZCsNLrGGmgqqKWlCg6vhcqctaR3MZhmBaaYmtinrR0aPzTcZQ
 6L6JOQzTHXM1G3BtgyLu9OkFWWpBZhk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1791962535;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=kMb2PUq7ja7EUiS+Q08ZX7s6AL5bu9ht7JoEhjzDB/Y=;
 b=DyivhN+l9TnVcDQJxLmGjHCiUEuoFAwmDGz7BNINi3WzCmyc3mQeIAI2KIyDQfCKKwAFQY
 20MpBTXdFt90e5CQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=bSOT9hPB;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=S7dMPvNW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1791962534; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=kMb2PUq7ja7EUiS+Q08ZX7s6AL5bu9ht7JoEhjzDB/Y=;
 b=bSOT9hPBWuS8oOM79pgTMvYI/6N3QzcsDHQvc0e3YU0R+4fXlap/nw/kJS9S5QvJnidrXu
 yzG0qBqSxPVHcWX6rjT3zvoLR9CBe1+60hlNbwZOYsYxLEfcbmlq+6rC24Ka+XLgMax0Gb
 iS1/laF14DHmohyoQMjMlnkT254bKgI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1791962534;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=kMb2PUq7ja7EUiS+Q08ZX7s6AL5bu9ht7JoEhjzDB/Y=;
 b=S7dMPvNWeUge/CdyZT6sOdkHqSPaDSXLD1M/9oUBQRbl4utXt+iclO8RWkzkBU9m5mSbrv
 foseAulltNNZmQDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7909413726;
 Wed, 14 Oct 2026 07:22:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Mr4wFKYtz2p/cwAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Wed, 14 Oct 2026 07:22:14 +0000
Message-ID: <d39bd8f3-0fe0-4537-bba5-8eba5bb36704@suse.de>
Date: Wed, 14 Oct 2026 09:22:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/6] drm/gem: add drm_gem_prime_dma_buf_to_gem()
 self-import helper
To: Matthew Brost <matthew.brost@intel.com>
Cc: Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>,
 dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org
References: <20261013010614.1516799-8-niranjana.vishwanathapura@intel.com>
 <20261013010614.1516799-11-niranjana.vishwanathapura@intel.com>
 <as2LL7IIs6EcL6Pj@gsse-cloud1.jf.intel.com>
 <ff266a33-2729-47b4-8a1e-ff96bb456782@suse.de>
 <as56X/w+CLUE2kQI@gsse-cloud1.jf.intel.com>
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
In-Reply-To: <as56X/w+CLUE2kQI@gsse-cloud1.jf.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 XM_UA_NO_VERSION(0.01)[]; MX_GOOD(-0.01)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_DN_SOME(0.00)[]; ARC_NA(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:url,intel.com:email,suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: BD06322185
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
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

Am 13.10.26 um 20:37 schrieb Matthew Brost:
> On Tue, Oct 13, 2026 at 09:17:53AM +0200, Thomas Zimmermann wrote:
>> Hi
>>
>> Am 13.10.26 um 03:36 schrieb Matthew Brost:
>>> On Mon, Oct 12, 2026 at 06:06:15PM -0700, Niranjana Vishwanathapura wrote:
>>>> drm_gem_is_prime_exported_dma_buf() is a bool predicate that open-codes
>>>> the core PRIME self-import check. Its only caller, the shmem importer,
>>>> then repeats the dma_buf->priv lookup and the reference get.
>>>>
>>>> Replace it with drm_gem_prime_dma_buf_to_gem(), a thin wrapper around
>>>> drm_gem_prime_self_import() that returns the backing GEM object -- with
>>>> a reference taken -- for a core-PRIME self-export, or NULL otherwise.
>>>> This consolidates self-import handling onto drm_gem_prime_self_import()
>>>> and lets drm_gem_shmem_prime_import_no_map() reuse the object directly.
>>>>
>>>> Unlike the removed predicate, the helper takes a reference on the
>>>> returned object; the sole caller already wanted the referenced object.
>>>>
>>>> Assisted-by: GitHub-Copilot:claude-opus-4.8
>>> Assisted-by: LLM
>>>
>>> I was going to suggest this last rev too as I noticed
>>> drm_gem_shmem_prime_import_no_map called
>>> drm_gem_is_prime_exported_dma_buf which should prefer the new helper but
>>> shmem couldn't look at drm_gem_prime_dmabuf_ops.
>>>
>>> This is a good cleanup:
>> No it's not. Please see my reply to the cover letter.
>>
> Ok, I can't say I agree, but I'm not going to die on this hill. Still,
> here's my two cents.
>
> I'm not sure I agree that comparing a vfunc is a hack, but let's assume
> it is. Is it better to have four drivers plus two cases in DRM core all
> open-coding this logic, or to consolidate it in a single place so that
> if we find a better approach later, we have a central point where it can
> be changed?

The helper leaks the prime implementation to the outside world. That 
alone is a problem. In practice there's no real guarantee that it works 
with drivers that do not fully use prime, such as amdgpu.

The importer whats to know if it has exported the dma_buf, but there's 
no clear unique identifier. So it checks the device pointer stored in 
priv. Because it cannot know if priv contains a device pointer, it first 
compares the vtable.  All of that really is a hack. A driver could use 
different vtables for the exported dma-bufs, or also have multiple 
memory managers that share the same vtable for exported dma-bufs.  
Neither would work with the current workarounds.

What the importer needs a  unique identifier for each dma-buf allocator. 
That workaround is just the next best thing.

Best regards
Thomas


>
> To me, the answer is obvious, but again, I'm fine with ignoring this.
>
> Matt
>
>> Best regards
>> Thomas
>>
>>> Reviewed-by: Matthew Brost <matthew.brost@intel.com>
>>>
>>>> Signed-off-by: Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>
>>>> ---
>>>>    drivers/gpu/drm/drm_gem_shmem_helper.c | 14 ++++++--------
>>>>    drivers/gpu/drm/drm_prime.c            | 26 +++++++++++++++-----------
>>>>    include/drm/drm_prime.h                |  4 ++--
>>>>    3 files changed, 23 insertions(+), 21 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
>>>> index d654a22a30de..a0e161f2333e 100644
>>>> --- a/drivers/gpu/drm/drm_gem_shmem_helper.c
>>>> +++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
>>>> @@ -954,15 +954,13 @@ struct drm_gem_object *drm_gem_shmem_prime_import_no_map(struct drm_device *dev,
>>>>    	size_t size;
>>>>    	int ret;
>>>> -	if (drm_gem_is_prime_exported_dma_buf(dev, dma_buf)) {
>>>> -		/*
>>>> -		 * Importing dmabuf exported from our own gem increases
>>>> -		 * refcount on gem itself instead of f_count of dmabuf.
>>>> -		 */
>>>> -		obj = dma_buf->priv;
>>>> -		drm_gem_object_get(obj);
>>>> +	/*
>>>> +	 * Importing a dmabuf exported from our own gem increases the refcount
>>>> +	 * on the gem itself instead of the f_count of the dmabuf.
>>>> +	 */
>>>> +	obj = drm_gem_prime_dma_buf_to_gem(dev, dma_buf);
>>>> +	if (obj)
>>>>    		return obj;
>>>> -	}
>>>>    	attach = dma_buf_attach(dma_buf, dev->dev);
>>>>    	if (IS_ERR(attach))
>>>> diff --git a/drivers/gpu/drm/drm_prime.c b/drivers/gpu/drm/drm_prime.c
>>>> index 588910c250b8..275c5661528d 100644
>>>> --- a/drivers/gpu/drm/drm_prime.c
>>>> +++ b/drivers/gpu/drm/drm_prime.c
>>>> @@ -933,23 +933,27 @@ EXPORT_SYMBOL(drm_gem_prime_export);
>>>>    /**
>>>> - * drm_gem_is_prime_exported_dma_buf -
>>>> - * checks if the DMA-BUF was exported from a GEM object belonging to @dev.
>>>> + * drm_gem_prime_dma_buf_to_gem - GEM object backing a self-exported PRIME dma-buf
>>>>     * @dev: drm_device to check against
>>>>     * @dma_buf: dma-buf object to import
>>>>     *
>>>> - * Return: true if the DMA-BUF was exported from a GEM object belonging
>>>> - * to @dev, false otherwise.
>>>> + * If @dma_buf is a PRIME export of a GEM object that belongs to @dev and uses
>>>> + * the core PRIME dma-buf ops, return that GEM object with an extra reference
>>>> + * taken, so a self-import reuses the GEM object instead of referencing the
>>>> + * dma-buf file. Returns NULL for a foreign dma-buf or one using driver-private
>>>> + * ops; such drivers call drm_gem_prime_self_import() with their own ops.
>>>> + *
>>>> + * The returned object carries a reference the caller must drop with
>>>> + * drm_gem_object_put().
>>>> + *
>>>> + * Return: the referenced GEM object on self-import, or NULL otherwise.
>>>>     */
>>>> -
>>>> -bool drm_gem_is_prime_exported_dma_buf(struct drm_device *dev,
>>>> -				       struct dma_buf *dma_buf)
>>>> +struct drm_gem_object *drm_gem_prime_dma_buf_to_gem(struct drm_device *dev,
>>>> +						    struct dma_buf *dma_buf)
>>>>    {
>>>> -	struct drm_gem_object *obj = dma_buf->priv;
>>>> -
>>>> -	return (dma_buf->ops == &drm_gem_prime_dmabuf_ops) && (obj->dev == dev);
>>>> +	return drm_gem_prime_self_import(dev, dma_buf, &drm_gem_prime_dmabuf_ops);
>>>>    }
>>>> -EXPORT_SYMBOL(drm_gem_is_prime_exported_dma_buf);
>>>> +EXPORT_SYMBOL(drm_gem_prime_dma_buf_to_gem);
>>>>    /**
>>>>     * drm_gem_prime_import_dev - core implementation of the import callback
>>>> diff --git a/include/drm/drm_prime.h b/include/drm/drm_prime.h
>>>> index d378404f8ab4..02665205aed1 100644
>>>> --- a/include/drm/drm_prime.h
>>>> +++ b/include/drm/drm_prime.h
>>>> @@ -101,8 +101,8 @@ struct dma_buf *drm_gem_prime_export(struct drm_gem_object *obj,
>>>>    unsigned long drm_prime_get_contiguous_size(struct sg_table *sgt);
>>>>    /* helper functions for importing */
>>>> -bool drm_gem_is_prime_exported_dma_buf(struct drm_device *dev,
>>>> -				       struct dma_buf *dma_buf);
>>>> +struct drm_gem_object *drm_gem_prime_dma_buf_to_gem(struct drm_device *dev,
>>>> +						    struct dma_buf *dma_buf);
>>>>    struct drm_gem_object *drm_gem_prime_import_dev(struct drm_device *dev,
>>>>    						struct dma_buf *dma_buf,
>>>> -- 
>>>> 2.43.0
>>>>
>> -- 
>> --
>> Thomas Zimmermann
>> Graphics Driver Developer
>> SUSE Software Solutions Germany GmbH
>> Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
>> GF: Stefan Gaiser, Jochen Jaser, Abhinav Puri, (HRB 36809, AG Nürnberg)
>>
>>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Stefan Gaiser, Jochen Jaser, Abhinav Puri, (HRB 36809, AG Nürnberg)


