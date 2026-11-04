Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F0C606A332
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 10:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ursulin.net header.i=@ursulin.net header.a=rsa-sha256 header.s=google header.b=RvnmR8A0
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D5C5710E870;
	Wed,  4 Nov 2026 10:27:48 +0000 (UTC)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com
 [209.85.221.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6564510E870
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 10:27:43 +0000 (UTC)
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-48df4e9d2d4so323171f8f.3
 for <dri-devel@lists.freedesktop.org>; Wed, 04 Nov 2026 02:27:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ursulin.net; s=google; t=1793788062; x=1794392862; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=vx0F8Ooosw/mJ+ey/EwtNuiTXbCoWfLlzJMEU9ZwgM4=;
 b=RvnmR8A0VZYqyA9o+RSslF1rc3eiulf4EkZe1RKadDjieMAalFWLdZXtt61sqP/9nt
 bR6aJLctB77TvZ24Cf2HzGw41PwTa8Z++lLnFp/m4HGEGsogGQjXacQY7gSYZiRaRLoM
 6R4BB59eyrvjhPqoq9IsVoPjCZKMk/qMKjLu5FgOKoxHSB/LlbIhL/c5Cyt9+iHbtllr
 sKThbrp5EQZI6Y1ODTzz2LQjAZgJGpL/6jytJp3OEO0521Qz2D3bmWm+Z3I/jZb2EbVq
 qolabkMaAmUOxNTdANuaYTVD5hmmVV/29T7eZAmkFwazffjLXJjHd7iHMXUBOhuTLBLx
 WU9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793788062; x=1794392862;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vx0F8Ooosw/mJ+ey/EwtNuiTXbCoWfLlzJMEU9ZwgM4=;
 b=z+tdaX0aGGLNhy+v7vsxpTBSZREbLf9VPl9HGuoGtvIfZLpCatR5znH6nQAZLhHzjV
 30c3xNKjJFp/6m41carqOm/q0id7GWnoyngbEWPGVEnXVBz3Y4adrFKx1HQcMwSyPR7n
 eZ6I9h6Pdry5ipy0aIU5G5n4Ld4Hdqfb7Gb4oHdRWHIFk73/61L2ymWj2qIaE4FOOQVU
 OMfQ8S17XnSlaQcZC1FR6HxvGhTacALWEa1bIpt4FvFJwqEH7rtw3nJASsGh5GdFqwmn
 Kp533PvD5qb833WqBNAFBHpZMOwHVSYk9Uf6pWDNDhsD6OPnvptECO4RGE15b/6IRz4A
 NUEw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxhyfcu191HVOmN8tE52RncnkOHKOxG7S5RhNQ0y8qrkeg42kTgrKYw6F/gAUHsrspF82XqsMIvOVY=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9ITO9pZYdOKZe2KzKmu2w6ttT8HrJOK6tsGZ7m2zTbIYtvNfEJ
 fWcmjnEvI8AF74M7rL7YjIC7L/qbgFkIP4PgPWtkLkLSO0F6nJ31MKXR5aMU9wcWsA4=
X-Gm-Gg: AYBFou0p9SaTSXhfRLEOmAoVWA/JASQbgg2aJweo5Cr3AyB3KT/MIckYYx8c8QddNdO
 CuvdngQKyK+5PAT1bY1xdjx/DmVju+WTxe0VV7cCeLNrm4ras6yGXbNHOJ3J9EJIjfEerpYTy7S
 iJcBw8TBQ77NIk54jMfEi9rnmYim1a/unlk0ygx+WBixNoj6hEtkC4v6o4XpuvyKIo3PVQFNjzy
 6OzmTuz9/CCDwdI6Id0oCaToZ3taJigwg+e81DpO5focXWGVZ2igvJA0PRg2bFjUZLyQNFq6h8R
 WScHxM0Tw7ZziXHuN8DKO9DTN0NGPBoFj1bW0XAZQY76bgofsfa9kW1CxsEu/2LagwH6lKumfn5
 LjrK1xpIEy5Ct6zKGiIxuDQXSb9LqbIbQH0W3tl91SQ5vEDI9npvKfW6xBaiYFTB5re+m8Ew7Pv
 dAv6STcT8JknbnxsB8XNKYOhR5PeRSTflxRMHjc/sSOG3Etvgid1BCv1rgpM64r7bxak5OjLFeN
 wGOXucBMMjsHoC9rmi/Joh19iyH8ZIKv54ye1D8gZ3XmbJi7sW6dhyTs1gMvTBZFGq3lX82r+tF
 cCLkJPzy3WA74dES6iNLRH4WUg7MyQclrc9Oj99ot8U1
X-Received: by 2002:a05:6000:4559:b0:488:79d6:a4a6 with SMTP id
 ffacd0b85a97d-48e6e2bc780mr22710961f8f.8.1793788061116; 
 Wed, 04 Nov 2026 02:27:41 -0800 (PST)
Received: from [192.168.0.116] ([81.79.79.1]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48fed45d2bbsm3299891f8f.33.2026.11.04.02.27.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Nov 2026 02:27:38 -0800 (PST)
Message-ID: <39be711e-cd56-4a04-87ee-6aa2a0b69779@ursulin.net>
Date: Wed, 4 Nov 2026 10:27:36 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/syncobj: Limit the number of handles and use
 kvmalloc for user-sized arrays
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 "Yu, Fei" <fei.yu@intel.com>, dri-devel@lists.freedesktop.org
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org,
 syzbot+95416f957d84e858b377@syzkaller.appspotmail.com,
 Madhur Kumar <madhurkumar004@gmail.com>
References: <20261104030930.3852781-1-fei.yu@intel.com>
 <1d8aeaae-7c89-4a99-975b-5467c33554b9@amd.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <1d8aeaae-7c89-4a99-975b-5467c33554b9@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 04/11/2026 09:44, Christian König wrote:
> On 11/4/26 04:09, Yu, Fei wrote:
>> From: Fei Yu <fei.yu@intel.com>
>>
>> The syncobj ioctls allocate several temporary arrays whose size is taken
>> directly from the u32 count_handles provided by userspace:
>>
>>   - handles and syncobjs in drm_syncobj_array_find()
>>   - points and entries in drm_syncobj_array_wait_timeout()
>>   - points and chains in drm_syncobj_timeline_signal_ioctl()
>>
>> These are kmalloc() allocations, so a count above KMALLOC_MAX_SIZE /
>> element size trips the WARN_ON_ONCE_GFP() in ___kmalloc_large_node():
>>
>>    WARNING: mm/slub.c:5459 at ___kmalloc_large_node+0x10c/0x170 mm/slub.c:5459
>>    Call Trace:
>>     __kmalloc_large_node_noprof+0x18/0x90 mm/slub.c:5502
>>     __do_kmalloc_node mm/slub.c:5519 [inline]
>>     __kmalloc_noprof+0x3f6/0x710 mm/slub.c:5556
>>     _kmalloc_noprof include/linux/slab.h:995 [inline]
>>     _kmalloc_array_noprof include/linux/slab.h:1211 [inline]
>>     drm_syncobj_array_find+0x3a/0x440 drivers/gpu/drm/drm_syncobj.c:1241
>>     drm_syncobj_timeline_wait_ioctl+0x18a/0x640 drivers/gpu/drm/drm_syncobj.c:1356
>>     drm_ioctl_kernel+0x2df/0x3b0 drivers/gpu/drm/drm_ioctl.c:817
>>     drm_ioctl+0x70e/0xba0 drivers/gpu/drm/drm_ioctl.c:914
>>
>> The wait entries are 64 bytes each on 64-bit, so with a 4 MiB
>> KMALLOC_MAX_SIZE a wait on more than about 64K handles already fails
>> today, with a warning.
>>
>> Fix this in two parts:
>>
>>   - Reject more than DRM_SYNCOBJ_MAX_HANDLES handles with -EINVAL in
>>     drm_syncobj_array_find(), which every ioctl taking a handle array goes
>>     through. The limit is derived from the largest per-handle allocation
>>     (the wait entries) and the INT_MAX size limit of kvmalloc(), so none
>>     of the allocations above can exceed it. That is about 33M handles on
>>     64-bit.
>>
>>   - Switch the six allocations to kvmalloc(), so that large but valid
>>     handle counts no longer depend on physically contiguous memory.
>>
>> Using kvmalloc() alone is not enough: the reproducer asks for more than
>> INT_MAX bytes, which hits the WARN_ON_ONCE() in __kvmalloc_node_noprof()
>> instead.
>>
>> Fixes: 3e6fb72d6cef ("drm/syncobj: Add a syncobj_array_find helper")
>> Reported-by: syzbot+95416f957d84e858b377@syzkaller.appspotmail.com
>> Closes: https://syzkaller.appspot.com/bug?extid=95416f957d84e858b377
>> Suggested-by: Christian König <christian.koenig@amd.com>
>> Signed-off-by: Fei Yu <fei.yu@intel.com>
>> ---
>> v2:
>>   - Drop __GFP_NOWARN (Christian).
>>   - Add DRM_SYNCOBJ_MAX_HANDLES, return -EINVAL above it, and switch all six
>>     arrays to kvmalloc() (Christian).
>>   - v1: https://lore.kernel.org/all/20261103085002.3100723-1-fei.yu@intel.com/
>>
>> About the limit: INT_MAX / sizeof(struct syncobj_wait_entry) is about 33M
>> handles on 64-bit. It is the largest count for which every allocation stays
>> below the kvmalloc() INT_MAX size limit, so it does not add a new policy
>> number. Today the real limit is much lower: a wait on more than ~64K
>> handles already fails with -ENOMEM (plus the warning), because the wait
>> entries are a kmalloc() allocation larger than 4 MiB. If you prefer a lower,
>> fixed limit (e.g. SZ_1M) or GFP_KERNEL_ACCOUNT for these arrays, I can
>> change it.
>>
>> Testing on v7.4-rc1 (x86_64, KASAN, virtio-gpu in QEMU):
>>   - syzbot C reproducer: base warns in ___kmalloc_large_node() (size
>>     0x100000920), patched is clean, ioctl returns -EINVAL.
>>   - wait / timeline_wait / timeline_signal / reset / signal on 200000
>>     signaled syncobjs: base fails wait and timeline_wait with -ENOMEM and
>>     the same warning; patched all succeed.
>>   - count == DRM_SYNCOBJ_MAX_HANDLES gets past the check (-EFAULT from the
>>     short user buffer), count == DRM_SYNCOBJ_MAX_HANDLES + 1 returns -EINVAL
>>     for wait, reset and timeline_signal.
>>   - kmemleak clean, checkpatch --strict clean, W=1 clean,
>>     DRM KUnit 667/667 passed.
>>   - IGT syncobj_basic, syncobj_wait, syncobj_timeline on virtio-gpu:
>>     202/202 subtests pass, same as base.
>>
>>   drivers/gpu/drm/drm_syncobj.c | 40 ++++++++++++++++++++++-------------
>>   1 file changed, 25 insertions(+), 15 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/drm_syncobj.c b/drivers/gpu/drm/drm_syncobj.c
>> index f1d4da1685457..c01cf164a4f9e 100644
>> --- a/drivers/gpu/drm/drm_syncobj.c
>> +++ b/drivers/gpu/drm/drm_syncobj.c
>> @@ -220,6 +220,13 @@ struct syncobj_wait_entry {
>>          u64    point;
>>   };
>>
>> +/*
>> + * Upper limit for the number of handles passed to a single ioctl. The
>> + * largest per-handle allocation is the wait entry array, keep it below the
>> + * INT_MAX size limit of kvmalloc().
>> + */
>> +#define DRM_SYNCOBJ_MAX_HANDLES        (INT_MAX / sizeof(struct syncobj_wait_entry))
> 
> I really wonder if we should put that into the uAPI files?
> 
> Not that userspace is potentially using it, but this is part of the uAPI and makes sense for documentation purposes.
> 
>> +
>>   static void syncobj_wait_syncobj_func(struct drm_syncobj *syncobj,
>>                                        struct syncobj_wait_entry *wait);
>>
>> @@ -1051,7 +1058,7 @@ static signed long drm_syncobj_array_wait_timeout(struct drm_syncobj **syncobjs,
>>                  lockdep_assert_none_held_once();
>>          }
>>
>> -       points = kmalloc_array(count, sizeof(*points), GFP_KERNEL);
>> +       points = kvmalloc_array(count, sizeof(*points), GFP_KERNEL);
>>          if (points == NULL)
>>                  return -ENOMEM;
>>
>> @@ -1064,7 +1071,7 @@ static signed long drm_syncobj_array_wait_timeout(struct drm_syncobj **syncobjs,
>>                  goto err_free_points;
>>          }
>>
>> -       entries = kzalloc_objs(*entries, count);
>> +       entries = kvzalloc_objs(*entries, count);
>>          if (!entries) {
>>                  timeout = -ENOMEM;
>>                  goto err_free_points;
>> @@ -1185,10 +1192,10 @@ static signed long drm_syncobj_array_wait_timeout(struct drm_syncobj **syncobjs,
>>                                                    &entries[i].fence_cb);
>>                  dma_fence_put(entries[i].fence);
>>          }
>> -       kfree(entries);
>> +       kvfree(entries);
>>
>>   err_free_points:
>> -       kfree(points);
>> +       kvfree(points);
>>
>>          return timeout;
>>   }
>> @@ -1238,7 +1245,10 @@ static int drm_syncobj_array_find(struct drm_file *file_private,
>>          struct drm_syncobj **syncobjs;
>>          int ret;
>>
>> -       handles = kmalloc_array(count_handles, sizeof(*handles), GFP_KERNEL);
>> +       if (count_handles > DRM_SYNCOBJ_MAX_HANDLES)
>> +               return -EINVAL;
>> +
>> +       handles = kvmalloc_array(count_handles, sizeof(*handles), GFP_KERNEL);
> 
> That kvmalloc_array() + the following copy_from_user should probably be replaced by using vmemdup_array_user(). But that should of course be a separate patch.

Btw I tried to do that some time ago:

https://lore.kernel.org/dri-devel/20251106132645.28208-1-tvrtko.ursulin@igalia.com/#t

I have as local, more recent version which applies, but apparently never 
sent it.

Interesting part should also be the other patches from the above linked 
series which avoid allocations altogether for the vast majority of cases.

If there is interest I can re-base and re-send after this is merged.

>>          if (handles == NULL)
>>                  return -ENOMEM;
>>
>> @@ -1248,7 +1258,7 @@ static int drm_syncobj_array_find(struct drm_file *file_private,
>>                  goto err_free_handles;
>>          }
>>
>> -       syncobjs = kmalloc_objs(*syncobjs, count_handles);
>> +       syncobjs = kvmalloc_objs(*syncobjs, count_handles);
>>          if (syncobjs == NULL) {
>>                  ret = -ENOMEM;
>>                  goto err_free_handles;
>> @@ -1262,16 +1272,16 @@ static int drm_syncobj_array_find(struct drm_file *file_private,
>>                  }
>>          }
>>
>> -       kfree(handles);
>> +       kvfree(handles);
>>          *syncobjs_out = syncobjs;
>>          return 0;
>>
>>   err_put_syncobjs:
>>          while (i-- > 0)
>>                  drm_syncobj_put(syncobjs[i]);
>> -       kfree(syncobjs);
>> +       kvfree(syncobjs);
>>   err_free_handles:
>> -       kfree(handles);
>> +       kvfree(handles);
>>
>>          return ret;
>>   }
>> @@ -1283,7 +1293,7 @@ static void drm_syncobj_array_free(struct drm_syncobj **syncobjs,
>>
>>          for (i = 0; i < count; i++)
>>                  drm_syncobj_put(syncobjs[i]);
>> -       kfree(syncobjs);
>> +       kvfree(syncobjs);
>>   }
>>
>>   int
>> @@ -1572,8 +1582,8 @@ drm_syncobj_timeline_signal_ioctl(struct drm_device *dev, void *data,
>>          if (ret < 0)
>>                  return ret;
>>
>> -       points = kmalloc_array(args->count_handles, sizeof(*points),
>> -                              GFP_KERNEL);
>> +       points = kvmalloc_array(args->count_handles, sizeof(*points),
>> +                               GFP_KERNEL);
> 
> Looking at the code the handling of allocating the array and the just memset()ing it to zero when it is not used is really sub-optimal.

AFAIR I tried to improve this ages ago by converting to get_user but it 
was foiled by arm32 (IIRC) cannot do 64-bit get_user. Otherwise it would 
have been possible to avoid the allocation and just read as we go.

Regards,

Tvrtko

> 
> But that is just a side comment and should probably be changed in a separate patch as well.
> 
> Apart from those minor comments the patch looks good to me.
> 
> Regards,
> Christian.
> 
>>          if (!points) {
>>                  ret = -ENOMEM;
>>                  goto out;
>> @@ -1586,7 +1596,7 @@ drm_syncobj_timeline_signal_ioctl(struct drm_device *dev, void *data,
>>                  goto err_points;
>>          }
>>
>> -       chains = kmalloc_objs(*chains, args->count_handles);
>> +       chains = kvmalloc_objs(*chains, args->count_handles);
>>          if (!chains) {
>>                  ret = -ENOMEM;
>>                  goto err_points;
>> @@ -1609,9 +1619,9 @@ drm_syncobj_timeline_signal_ioctl(struct drm_device *dev, void *data,
>>                  dma_fence_put(fence);
>>          }
>>   err_chains:
>> -       kfree(chains);
>> +       kvfree(chains);
>>   err_points:
>> -       kfree(points);
>> +       kvfree(points);
>>   out:
>>          drm_syncobj_array_free(syncobjs, args->count_handles);
>>
>>
>> base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
>> --
>> 2.43.0
>>
> 

