Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58AF7C61DD3
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 15:11:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF8C410F66B;
	Thu,  3 Sep 2026 15:11:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="Y9Q66J5e";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Hxf2BAKR";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="hJmW0UJ7";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="EONIRqUp";
	dkim-atps=neutral
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 054A010F66B;
 Thu,  3 Sep 2026 15:11:55 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5C4AC21F07;
 Thu,  3 Sep 2026 15:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788448309; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=/j/GbaUADvIG+J91qi0EsMYXhXgy+W9e4jS9RD1moM8=;
 b=Y9Q66J5e6FhMXfcTd5SZi3bqZVYXy3gTdms6LNIiqgAgI7TEOycgu1Yji9bJXYvJCubit/
 hCit37wzrMTzbS0Nu2CL4UvKdgS6+XzOmAbtM+FHtAOcnf0cLYlDFCZX7Sb9V41D50LQxj
 TCin05WKpFx7MkkEtR2M7MuOaIr6LKo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788448309;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=/j/GbaUADvIG+J91qi0EsMYXhXgy+W9e4jS9RD1moM8=;
 b=Hxf2BAKRvrUKxHxkTL/mvJIFEzjcmohq7RzHhe+LnQmzJRx5VrWPxkTL8Ozfvw9vDCDrqj
 JOhDj0ckxfYqONBg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=hJmW0UJ7;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=EONIRqUp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788448305; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=/j/GbaUADvIG+J91qi0EsMYXhXgy+W9e4jS9RD1moM8=;
 b=hJmW0UJ7wWKbEl3lad6r2VbpuFMtXw99gGTmsABY2O2tq+7yyIc0+5YGUPMgwd6V+qdfcX
 So2a2oXF43KP5mteZys9OrueoY/5qoRgAapOKiXaCVe1LMBoKPr7YsXrKbR6XZZzS/7k/i
 5i8YKHNmRhQG9dVwwIYlMl7W8bbrfTE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788448305;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=/j/GbaUADvIG+J91qi0EsMYXhXgy+W9e4jS9RD1moM8=;
 b=EONIRqUpeVa6lNRJ+MP/lGa8nKIoEM6QYsgizol8mPFh5sWFg8PKZuUxio2cfeXOtMyoLB
 WrEQ38DcT9hbkFDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BCF55136D9;
 Thu,  3 Sep 2026 15:11:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id u4zOLDCOmWoAQAAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Thu, 03 Sep 2026 15:11:44 +0000
Message-ID: <9e61d418-f8a6-4261-82e5-3b47df87e8fa@suse.de>
Date: Thu, 3 Sep 2026 17:11:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/gem: Drop ticket arg to lru_scan()
To: rob.clark@oss.qualcomm.com
Cc: dri-devel@lists.freedesktop.org,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Steven Price <steven.price@arm.com>, open list
 <linux-kernel@vger.kernel.org>,
 "open list:DRM DRIVER for Qualcomm display hardware"
 <linux-arm-msm@vger.kernel.org>,
 "open list:DRM DRIVER for Qualcomm display hardware"
 <freedreno@lists.freedesktop.org>
References: <20260901164544.642985-1-robin.clark@oss.qualcomm.com>
 <69a37b53-82e1-40bb-8266-206c3bff6af2@suse.de>
 <CACSVV03XSo8U+8XR3Z=mQtD_kvHU_G22ne+Mb9yL1VHLc9SLTw@mail.gmail.com>
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
In-Reply-To: <CACSVV03XSo8U+8XR3Z=mQtD_kvHU_G22ne+Mb9yL1VHLc9SLTw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 5C4AC21F07
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_TLS_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; RCPT_COUNT_TWELVE(0.00)[17];
 MID_RHS_MATCH_FROM(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[lists.freedesktop.org,collabora.com,arm.com,linux.intel.com,kernel.org,gmail.com,ffwll.ch,linux.dev,poorly.run,somainline.org,vger.kernel.org];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[collabora.com:email,suse.de:dkim,suse.de:email,suse.de:mid,suse.com:url,arm.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
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

Am 03.09.26 um 16:09 schrieb Rob Clark:
> On Tue, Sep 1, 2026 at 11:57 PM Thomas Zimmermann <tzimmermann@suse.de> wrote:
>>
>>
>> Am 01.09.26 um 18:45 schrieb Rob Clark:
>>> Commit 3392291fc509 ("drm/msm: Fix shrinker deadlock") dropped the only
>>> use of the ticket arg, but at the time left drm_gem_lru_scan() unchanged
>>> to avoid conflicts with in-flight panthor shrinker support.  This commit
>>> is the followup to remove the unused arg.
>>>
>>> Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
>>> Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
>>> Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>
>> Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
> Could someone take this via drm-misc?

Merged into drm-misc-next.

Best regards
Thomas

>
> BR,
> -R
>
>>> ---
>>>
>>> v2: Drop left over kerneldoc param description, fix panthor spelling
>>>
>>>    drivers/gpu/drm/drm_gem.c              | 14 +++-----------
>>>    drivers/gpu/drm/msm/msm_gem_shrinker.c | 22 ++++++++++------------
>>>    drivers/gpu/drm/panthor/panthor_gem.c  | 14 ++++++--------
>>>    drivers/gpu/drm/panthor/panthor_mmu.c  |  5 ++---
>>>    drivers/gpu/drm/panthor/panthor_mmu.h  |  3 +--
>>>    include/drm/drm_gem.h                  |  3 +--
>>>    6 files changed, 23 insertions(+), 38 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
>>> index e3ed684ddcf2..3113b4a53b99 100644
>>> --- a/drivers/gpu/drm/drm_gem.c
>>> +++ b/drivers/gpu/drm/drm_gem.c
>>> @@ -1649,15 +1649,13 @@ EXPORT_SYMBOL(drm_gem_lru_move_tail);
>>>     * @nr_to_scan: The number of pages to try to reclaim
>>>     * @remaining: The number of pages left to reclaim, should be initialized by caller
>>>     * @shrink: Callback to try to shrink/reclaim the object.
>>> - * @ticket: Optional ww_acquire_ctx context to use for locking
>>>     */
>>>    unsigned long
>>>    drm_gem_lru_scan(struct drm_device *dev,
>>>                 struct drm_gem_lru *lru,
>>>                 unsigned int nr_to_scan,
>>>                 unsigned long *remaining,
>>> -              bool (*shrink)(struct drm_gem_object *obj, struct ww_acquire_ctx *ticket),
>>> -              struct ww_acquire_ctx *ticket)
>>> +              bool (*shrink)(struct drm_gem_object *obj))
>>>    {
>>>        struct drm_gem_lru still_in_lru;
>>>        struct drm_gem_object *obj;
>>> @@ -1690,20 +1688,17 @@ drm_gem_lru_scan(struct drm_device *dev,
>>>                 */
>>>                mutex_unlock(&dev->gem_lru_mutex);
>>>
>>> -             if (ticket)
>>> -                     ww_acquire_init(ticket, &reservation_ww_class);
>>> -
>>>                /*
>>>                 * Note that this still needs to be trylock, since we can
>>>                 * hit shrinker in response to trying to get backing pages
>>>                 * for this obj (ie. while it's lock is already held)
>>>                 */
>>> -             if (!ww_mutex_trylock(&obj->resv->lock, ticket)) {
>>> +             if (!ww_mutex_trylock(&obj->resv->lock, NULL)) {
>>>                        *remaining += obj->size >> PAGE_SHIFT;
>>>                        goto tail;
>>>                }
>>>
>>> -             if (shrink(obj, ticket)) {
>>> +             if (shrink(obj)) {
>>>                        freed += obj->size >> PAGE_SHIFT;
>>>
>>>                        /*
>>> @@ -1727,9 +1722,6 @@ drm_gem_lru_scan(struct drm_device *dev,
>>>
>>>                dma_resv_unlock(obj->resv);
>>>
>>> -             if (ticket)
>>> -                     ww_acquire_fini(ticket);
>>> -
>>>    tail:
>>>                drm_gem_object_put(obj);
>>>                mutex_lock(&dev->gem_lru_mutex);
>>> diff --git a/drivers/gpu/drm/msm/msm_gem_shrinker.c b/drivers/gpu/drm/msm/msm_gem_shrinker.c
>>> index 9d2788f79ace..3514d5c84989 100644
>>> --- a/drivers/gpu/drm/msm/msm_gem_shrinker.c
>>> +++ b/drivers/gpu/drm/msm/msm_gem_shrinker.c
>>> @@ -102,7 +102,7 @@ with_vm_locks(void (*fn)(struct drm_gem_object *obj),
>>>    }
>>>
>>>    static bool
>>> -purge(struct drm_gem_object *obj, struct ww_acquire_ctx *unused)
>>> +purge(struct drm_gem_object *obj)
>>>    {
>>>        if (!is_purgeable(to_msm_bo(obj)))
>>>                return false;
>>> @@ -114,7 +114,7 @@ purge(struct drm_gem_object *obj, struct ww_acquire_ctx *unused)
>>>    }
>>>
>>>    static bool
>>> -evict(struct drm_gem_object *obj, struct ww_acquire_ctx *unused)
>>> +evict(struct drm_gem_object *obj)
>>>    {
>>>        if (is_unevictable(to_msm_bo(obj)))
>>>                return false;
>>> @@ -133,21 +133,21 @@ wait_for_idle(struct drm_gem_object *obj)
>>>    }
>>>
>>>    static bool
>>> -active_purge(struct drm_gem_object *obj, struct ww_acquire_ctx *ticket)
>>> +active_purge(struct drm_gem_object *obj)
>>>    {
>>>        if (!wait_for_idle(obj))
>>>                return false;
>>>
>>> -     return purge(obj, ticket);
>>> +     return purge(obj);
>>>    }
>>>
>>>    static bool
>>> -active_evict(struct drm_gem_object *obj, struct ww_acquire_ctx *ticket)
>>> +active_evict(struct drm_gem_object *obj)
>>>    {
>>>        if (!wait_for_idle(obj))
>>>                return false;
>>>
>>> -     return evict(obj, ticket);
>>> +     return evict(obj);
>>>    }
>>>
>>>    static unsigned long
>>> @@ -156,7 +156,7 @@ msm_gem_shrinker_scan(struct shrinker *shrinker, struct shrink_control *sc)
>>>        struct msm_drm_private *priv = shrinker->private_data;
>>>        struct {
>>>                struct drm_gem_lru *lru;
>>> -             bool (*shrink)(struct drm_gem_object *obj, struct ww_acquire_ctx *ticket);
>>> +             bool (*shrink)(struct drm_gem_object *obj);
>>>                bool cond;
>>>                unsigned long freed;
>>>                unsigned long remaining;
>>> @@ -180,8 +180,7 @@ msm_gem_shrinker_scan(struct shrinker *shrinker, struct shrink_control *sc)
>>>                stages[i].freed =
>>>                        drm_gem_lru_scan(priv->dev, stages[i].lru, nr,
>>>                                         &stages[i].remaining,
>>> -                                      stages[i].shrink,
>>> -                                      NULL);
>>> +                                      stages[i].shrink);
>>>                nr -= stages[i].freed;
>>>                freed += stages[i].freed;
>>>                remaining += stages[i].remaining;
>>> @@ -222,7 +221,7 @@ msm_gem_shrinker_shrink(struct drm_device *dev, unsigned long nr_to_scan)
>>>    static const int vmap_shrink_limit = 15;
>>>
>>>    static bool
>>> -vmap_shrink(struct drm_gem_object *obj, struct ww_acquire_ctx *ticket)
>>> +vmap_shrink(struct drm_gem_object *obj)
>>>    {
>>>        if (!is_vunmapable(to_msm_bo(obj)))
>>>                return false;
>>> @@ -250,8 +249,7 @@ msm_gem_shrinker_vmap(struct notifier_block *nb, unsigned long event, void *ptr)
>>>                unmapped += drm_gem_lru_scan(priv->dev, lrus[idx],
>>>                                             vmap_shrink_limit - unmapped,
>>>                                             &remaining,
>>> -                                          vmap_shrink,
>>> -                                          NULL);
>>> +                                          vmap_shrink);
>>>        }
>>>
>>>        *(unsigned long *)ptr += unmapped;
>>> diff --git a/drivers/gpu/drm/panthor/panthor_gem.c b/drivers/gpu/drm/panthor/panthor_gem.c
>>> index 54535bae2b0c..17408f832af3 100644
>>> --- a/drivers/gpu/drm/panthor/panthor_gem.c
>>> +++ b/drivers/gpu/drm/panthor/panthor_gem.c
>>> @@ -1392,8 +1392,7 @@ panthor_gem_shrinker_count(struct shrinker *shrinker, struct shrink_control *sc)
>>>        return count ? count : SHRINK_EMPTY;
>>>    }
>>>
>>> -static bool panthor_gem_try_evict_no_resv_wait(struct drm_gem_object *obj,
>>> -                                            struct ww_acquire_ctx *ticket)
>>> +static bool panthor_gem_try_evict_no_resv_wait(struct drm_gem_object *obj)
>>>    {
>>>        /*
>>>         * Track last locked entry for unwinding locks in error and
>>> @@ -1479,8 +1478,7 @@ static bool panthor_gem_try_evict_no_resv_wait(struct drm_gem_object *obj,
>>>        return ret == 0;
>>>    }
>>>
>>> -static bool panthor_gem_try_evict(struct drm_gem_object *obj,
>>> -                               struct ww_acquire_ctx *ticket)
>>> +static bool panthor_gem_try_evict(struct drm_gem_object *obj)
>>>    {
>>>        struct panthor_gem_object *bo = to_panthor_bo(obj);
>>>
>>> @@ -1488,7 +1486,7 @@ static bool panthor_gem_try_evict(struct drm_gem_object *obj,
>>>        if (dma_resv_wait_timeout(obj->resv, DMA_RESV_USAGE_BOOKKEEP, false, 10) <= 0)
>>>                return false;
>>>
>>> -     return panthor_gem_try_evict_no_resv_wait(&bo->base, ticket);
>>> +     return panthor_gem_try_evict_no_resv_wait(&bo->base);
>>>    }
>>>
>>>    static unsigned long
>>> @@ -1503,13 +1501,13 @@ panthor_gem_shrinker_scan(struct shrinker *shrinker, struct shrink_control *sc)
>>>
>>>        freed += drm_gem_lru_scan(&ptdev->base, &ptdev->reclaim.unused,
>>>                                  sc->nr_to_scan - freed, &remaining,
>>> -                               panthor_gem_try_evict_no_resv_wait, NULL);
>>> +                               panthor_gem_try_evict_no_resv_wait);
>>>        if (freed >= sc->nr_to_scan)
>>>                goto out;
>>>
>>>        freed += drm_gem_lru_scan(&ptdev->base, &ptdev->reclaim.mmapped,
>>>                                  sc->nr_to_scan - freed, &remaining,
>>> -                               panthor_gem_try_evict_no_resv_wait, NULL);
>>> +                               panthor_gem_try_evict_no_resv_wait);
>>>        if (freed >= sc->nr_to_scan)
>>>                goto out;
>>>
>>> @@ -1523,7 +1521,7 @@ panthor_gem_shrinker_scan(struct shrinker *shrinker, struct shrink_control *sc)
>>>
>>>        freed += drm_gem_lru_scan(&ptdev->base, &ptdev->reclaim.gpu_mapped_shared,
>>>                                  sc->nr_to_scan - freed, &remaining,
>>> -                               panthor_gem_try_evict, NULL);
>>> +                               panthor_gem_try_evict);
>>>
>>>    out:
>>>    #ifdef CONFIG_DEBUG_FS
>>> diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
>>> index e10dbd18d8cf..ab070bc74857 100644
>>> --- a/drivers/gpu/drm/panthor/panthor_mmu.c
>>> +++ b/drivers/gpu/drm/panthor/panthor_mmu.c
>>> @@ -3133,8 +3133,7 @@ int panthor_vm_prepare_mapped_bos_resvs(struct drm_exec *exec, struct panthor_vm
>>>    unsigned long
>>>    panthor_mmu_reclaim_priv_bos(struct panthor_device *ptdev,
>>>                             unsigned int nr_to_scan, unsigned long *remaining,
>>> -                          bool (*shrink)(struct drm_gem_object *,
>>> -                                         struct ww_acquire_ctx *))
>>> +                          bool (*shrink)(struct drm_gem_object *))
>>>    {
>>>        unsigned long freed = 0;
>>>        LIST_HEAD(remaining_vms);
>>> @@ -3160,7 +3159,7 @@ panthor_mmu_reclaim_priv_bos(struct panthor_device *ptdev,
>>>
>>>                freed += drm_gem_lru_scan(&ptdev->base, &vm->reclaim.lru,
>>>                                          nr_to_scan - freed,
>>> -                                       remaining, shrink, NULL);
>>> +                                       remaining, shrink);
>>>
>>>                mutex_lock(&ptdev->base.gem_lru_mutex);
>>>
>>> diff --git a/drivers/gpu/drm/panthor/panthor_mmu.h b/drivers/gpu/drm/panthor/panthor_mmu.h
>>> index 3522fbbce369..abc36e7204be 100644
>>> --- a/drivers/gpu/drm/panthor/panthor_mmu.h
>>> +++ b/drivers/gpu/drm/panthor/panthor_mmu.h
>>> @@ -52,8 +52,7 @@ int panthor_vm_evict_bo_mappings_locked(struct panthor_gem_object *bo);
>>>    unsigned long
>>>    panthor_mmu_reclaim_priv_bos(struct panthor_device *ptdev,
>>>                             unsigned int nr_to_scan, unsigned long *remaining,
>>> -                          bool (*shrink)(struct drm_gem_object *,
>>> -                                         struct ww_acquire_ctx *));
>>> +                          bool (*shrink)(struct drm_gem_object *));
>>>    int panthor_vm_prepare_mapped_bos_resvs(struct drm_exec *exec,
>>>                                        struct panthor_vm *vm,
>>>                                        u32 slot_count);
>>> diff --git a/include/drm/drm_gem.h b/include/drm/drm_gem.h
>>> index 8a704f6a65c1..ffa607c91aa2 100644
>>> --- a/include/drm/drm_gem.h
>>> +++ b/include/drm/drm_gem.h
>>> @@ -616,8 +616,7 @@ drm_gem_lru_scan(struct drm_device *dev,
>>>                 struct drm_gem_lru *lru,
>>>                 unsigned int nr_to_scan,
>>>                 unsigned long *remaining,
>>> -              bool (*shrink)(struct drm_gem_object *obj, struct ww_acquire_ctx *ticket),
>>> -              struct ww_acquire_ctx *ticket);
>>> +              bool (*shrink)(struct drm_gem_object *obj));
>>>
>>>    int drm_gem_evict_locked(struct drm_gem_object *obj);
>>>
>> --
>> --
>> Thomas Zimmermann
>> Graphics Driver Developer
>> SUSE Software Solutions Germany GmbH
>> Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
>> GF: Jochen Jaser, Andrew McDonald, (HRB 36809, AG Nürnberg)
>>
>>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, (HRB 36809, AG Nürnberg)


