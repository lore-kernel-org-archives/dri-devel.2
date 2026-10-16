Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58A8FCCA46D
	for <dri-devel@archiver.kernel.org>; Fri, 16 Oct 2026 07:46:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B4E7B10E030;
	Fri, 16 Oct 2026 07:46:16 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B20911261C;
 Fri, 16 Oct 2026 07:46:05 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0139E21E7B;
 Fri, 16 Oct 2026 07:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1792136764; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=4YoQB+4dU/oZ0jy/n1gqli4ew0QejbgzT8OJuj0XrpI=;
 b=Yqzlhq7DQKPIsYxPbyyuCVijHj5azovINMcKghrZFF1EM9kKCe9clCiL1fO6Bh3U5jFkRJ
 Jq484aPAn5zJDMF37+h1LiN0RdLFzpPAQkEsr28+hlW1WqvZDMMu2aJGiSMX8Yuh4okR3R
 9cI5hn3oRy+r9qzjTKgtN5d3JXuB5Xs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1792136764;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=4YoQB+4dU/oZ0jy/n1gqli4ew0QejbgzT8OJuj0XrpI=;
 b=YRlpewzAGgpf/XwT+rFFX/MVa750q6JYeDug29cOrQhqjlMEVPU8RvyunBQagCU3gxGcQp
 cCvJOufBt4wqfNAA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Yqzlhq7D;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=YRlpewzA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1792136764; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=4YoQB+4dU/oZ0jy/n1gqli4ew0QejbgzT8OJuj0XrpI=;
 b=Yqzlhq7DQKPIsYxPbyyuCVijHj5azovINMcKghrZFF1EM9kKCe9clCiL1fO6Bh3U5jFkRJ
 Jq484aPAn5zJDMF37+h1LiN0RdLFzpPAQkEsr28+hlW1WqvZDMMu2aJGiSMX8Yuh4okR3R
 9cI5hn3oRy+r9qzjTKgtN5d3JXuB5Xs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1792136764;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=4YoQB+4dU/oZ0jy/n1gqli4ew0QejbgzT8OJuj0XrpI=;
 b=YRlpewzAGgpf/XwT+rFFX/MVa750q6JYeDug29cOrQhqjlMEVPU8RvyunBQagCU3gxGcQp
 cCvJOufBt4wqfNAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B76471378C;
 Fri, 16 Oct 2026 07:46:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id hYchGDvW0WqeLwAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Fri, 16 Oct 2026 07:46:03 +0000
Message-ID: <660f7cf6-fd37-4c91-b802-767a11a8dc7a@suse.de>
Date: Fri, 16 Oct 2026 09:46:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/6] drm/gem: add helper to detect self-imported PRIME
 dma-bufs
To: Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>
Cc: dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 matthew.brost@intel.com
References: <20261014190200.1700470-8-niranjana.vishwanathapura@intel.com>
 <20261014190200.1700470-9-niranjana.vishwanathapura@intel.com>
 <af32a6f6-ccee-4265-96bf-d8508d0127b7@suse.de>
 <atHDszh1A9Eqsukh@nvishwa1-desk>
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
In-Reply-To: <atHDszh1A9Eqsukh@nvishwa1-desk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 0139E21E7B
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; XM_UA_NO_VERSION(0.01)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; FROM_HAS_DN(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; TO_DN_SOME(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_THREE(0.00)[4];
 DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email, suse.com:url,
 imap1.dmz-prg2.suse.org:helo, imap1.dmz-prg2.suse.org:rdns, suse.de:dkim]
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

Am 16.10.26 um 08:26 schrieb Niranjana Vishwanathapura:
> On Thu, Oct 15, 2026 at 09:27:08AM +0200, Thomas Zimmermann wrote:
>> Hi
>>
>> Am 14.10.26 um 21:02 schrieb Niranjana Vishwanathapura:
>>> From: Farah Kassabri <farah.kassabri@intel.com>
>>>
>>> Add drm_gem_prime_self_import() to detect and handle the case where a
>>> PRIME dma-buf being imported was exported by the same DRM device.
>>>
>>> When the dma-buf originates from the importing device and uses the
>>> expected dma-buf ops, the helper returns the associated GEM object and
>>> takes an extra reference on it. This allows drivers to bypass the
>>> generic PRIME import path and avoid taking an additional reference on
>>> the dma-buf file.
>>>
>>> The helper simplifies self-import handling and avoids duplication of
>>> this pattern across DRM drivers.
>>>
>>> v2: Move drm_gem_prime_self_import() to drm_gem.h as a static inline
>>>     helper routine
>>
>> Why even bother submitting this? It is the same series that I already 
>> declined with a few cosmetic changes.
>>
>> The abstract entry point for importing is 
>> drm_driver.gem_prime_import. The implementation is driver specific. 
>> No need to over abstract. Keeping drm_gem_object_get() separate from 
>> the test is a feature, not a bug BTW.
>>
>> If you want to improve the status quo, change dma-buf such that prime 
>> works without relying on the vtable and ->priv. I outlined this in my 
>> earlier replies.
>>
>
> Hi Thomas,
>
> As mentioned in other thread, your earlier suggesion of
> '__drm_gem_is_exported_dma_buf(dev, ops, dma_buf)' is not fully helpful
> as it would require drivers to still take object reference. Besides,
> this also depends on 'ops'.

This is a feature. These are two distinct operations. Taking the object 
ref is another of those implementation detail where drivers might want 
to do something else.

>
> To me the 'dma_buf_ops as export identifer' seems to be well accepted
> idiom, though we may say it shouldn't be in stricter sense.
>
> But if we were not to relay on vtable and ->priv, then it looks like
> the best alternative will be to have DRM subsystem maintain a list of
> exported dma-buf objects per drm device. Then during import, parse this
> list to determine if the import is self-import or not.
>
> I am not sure if it is worth to add this list just for this simple helper
> routine. If using dma_buf ops is no go, then yah, let us drop this 
> series,
> keep current code and may be look into this alternative later through 
> an RFC.

As I mention before, the abstraction is drm_driver.gem_prime_import. 
Anything behind that is driver-specific. A real improvement should 
provide a driver-generic implementation of gem_prime_import. This needs 
changes to dma_buf and to the prime helpers. OTOH gem_prime_import is 
already fairly abstract. There are no low-hanging fruits here IMHO.

Best regards
Thomas


>
> Thanks,
> Niranjana
>
>> Best regards
>> Thomas
>>
>>
>>
>>>
>>> Signed-off-by: Farah Kassabri <farah.kassabri@intel.com>
>>> Signed-off-by: Niranjana Vishwanathapura 
>>> <niranjana.vishwanathapura@intel.com>
>>> Reviewed-by: Matthew Brost <matthew.brost@intel.com>
>>> ---
>>>  drivers/gpu/drm/drm_prime.c | 10 ++-------
>>>  include/drm/drm_gem.h       | 42 +++++++++++++++++++++++++++++++++++++
>>>  2 files changed, 44 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/drm_prime.c b/drivers/gpu/drm/drm_prime.c
>>> index 9b44c78cd77f..7a15c29052eb 100644
>>> --- a/drivers/gpu/drm/drm_prime.c
>>> +++ b/drivers/gpu/drm/drm_prime.c
>>> @@ -974,15 +974,9 @@ struct drm_gem_object 
>>> *drm_gem_prime_import_dev(struct drm_device *dev,
>>>      struct drm_gem_object *obj;
>>>      int ret;
>>> -    if (drm_gem_is_prime_exported_dma_buf(dev, dma_buf)) {
>>> -        /*
>>> -         * Importing dmabuf exported from our own gem increases
>>> -         * refcount on gem itself instead of f_count of dmabuf.
>>> -         */
>>> -        obj = dma_buf->priv;
>>> -        drm_gem_object_get(obj);
>>> +    obj = drm_gem_prime_self_import(dev, dma_buf, 
>>> &drm_gem_prime_dmabuf_ops);
>>> +    if (obj)
>>>          return obj;
>>> -    }
>>>      if (!dev->driver->gem_prime_import_sg_table)
>>>          return ERR_PTR(-EINVAL);
>>> diff --git a/include/drm/drm_gem.h b/include/drm/drm_gem.h
>>> index 885244e375d3..238ec08f0d81 100644
>>> --- a/include/drm/drm_gem.h
>>> +++ b/include/drm/drm_gem.h
>>> @@ -646,6 +646,48 @@ static inline bool drm_gem_is_imported(const 
>>> struct drm_gem_object *obj)
>>>      return !!obj->import_attach;
>>>  }
>>> +/**
>>> + * drm_gem_prime_self_import - Attempt to import a dma-buf exported 
>>> by this DRM device
>>> + * @dev: DRM device performing the import
>>> + * @dma_buf: dma-buf to import
>>> + * @expected_ops: dma-buf ops used by this driver
>>> + *
>>> + * If @dma_buf was exported by this DRM device using @expected_ops, 
>>> return the
>>> + * corresponding GEM object and take an extra reference on it. In 
>>> this case,
>>> + * the import avoids taking a reference on the dma-buf file and 
>>> instead bumps
>>> + * the GEM object's refcount directly.
>>> + *
>>> + * Comparing @dma_buf->ops against @expected_ops is plumbing: 
>>> dma-buf has no
>>> + * first-class exporter identifier, so the ops pointer is used as a 
>>> stand-in to
>>> + * recognise a buffer this driver exported. A dedicated exporter 
>>> identity would
>>> + * let this be done without reaching into @dma_buf->ops.
>>> + *
>>> + * Returns:
>>> + * A referenced GEM object on success, or %NULL if the dma-buf was 
>>> not exported
>>> + * by this device or does not match @expected_ops.
>>> + */
>>> +static inline struct drm_gem_object *
>>> +drm_gem_prime_self_import(struct drm_device *dev, struct dma_buf 
>>> *dma_buf,
>>> +              const struct dma_buf_ops *expected_ops)
>>> +{
>>> +    struct drm_gem_object *obj;
>>> +
>>> +    if (dma_buf->ops != expected_ops)
>>> +        return NULL;
>>> +
>>> +    obj = dma_buf->priv;
>>> +    if (obj->dev != dev)
>>> +        return NULL;
>>> +
>>> +    /*
>>> +     * Importing dmabuf exported from the driver's own gem increases
>>> +     * refcount on gem itself instead of f_count of dmabuf.
>>> +     */
>>> +    drm_gem_object_get(obj);
>>> +
>>> +    return obj;
>>> +}
>>> +
>>>  #ifdef CONFIG_LOCKDEP
>>>  #define drm_gem_gpuva_assert_lock_held(gpuvm, obj) \
>>>      lockdep_assert(drm_gpuvm_immediate_mode(gpuvm) ? \
>>
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


