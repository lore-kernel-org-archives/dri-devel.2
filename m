Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 641EF606A31B
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 09:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ursulin.net header.i=@ursulin.net header.a=rsa-sha256 header.s=google header.b=nASi+dUV
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 913CF10E10D;
	Thu,  5 Nov 2026 09:12:55 +0000 (UTC)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 84D6A10E10D
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 09:12:49 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-4a210470b49so11672725e9.2
 for <dri-devel@lists.freedesktop.org>; Thu, 05 Nov 2026 01:12:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ursulin.net; s=google; t=1793869968; x=1794474768; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=MSpuKsAi67Z9mDW+vV5cUezACEgkCzamTDE9W9vtWQk=;
 b=nASi+dUV2rBGSN6ixOr5RNeCRyrtiXAL9HIaMYC9+Skq7Cw6+0sCrMIjybOqi6HUw4
 lK0OVGYWf3/54iGNwAVIKJ1fCw6xb/h//Zg4EN48nN892WAHrJUuSaaxKRHLbxg9TSJf
 0GDdSnFc6F4RQXNT8/UElPlxhDQqtxlYTw7GYliYI55+OngM3pPy30UAH1FzIURH78sF
 H70747qgybSI2kjLI9XQnwiK5jZAED5Yi+IZ5f/UI7dtimnKumsb6CaVA4LO//ZxChES
 biIDU62jXyurb0q8f37jVdiiCnjdIbjsPf6o32/vDTn9BuAjeqz5pTFHaB1fReujJAIs
 TH7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793869968; x=1794474768;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MSpuKsAi67Z9mDW+vV5cUezACEgkCzamTDE9W9vtWQk=;
 b=AJAQmLDjh47GqMFKGp+ojRsk2DBKS0LHCzfnn2QTYSAxFrRbJDu1q3skwGAlDEVfDv
 sBJkHO3KtskAnicUe2lIfQ9c8LA1fYHnAzlIM0g+jUjkpeWYjbbm1oBspmD/amIMqxev
 eLZbX20pJcvT8w28PYHOJuffTw3H4nKcXGA8z4FH0IQQu9edrxwV5/YZ06fNSlCSwIKS
 KzHsVLD0BAIz3XWitr35sgFPOE6QunHdZU5DG7z8PU256HFKyUL67kX7d1cc/z1AUY/c
 F96H3nmxX2DZXXRvZY3jFzHtS2DjVP2aOsjLU3vZsgyfz+Hfv3tc7E5+kH5jf9NmkuFT
 qaxQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwd64TtCE0mEFj74zHDVtv6Y64yI+4+AaQqF7I3vG51CzAaPvE9Mnfco/BEWtvMoNRnrp8x8d66IeA=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+u0pY7oVWIk6LYvUvHo5S9TVnedJPprFeXQY9GfTjcLAkKt0Cz
 Wjqgqfbn1FuTuIVWHMRktvIGIlQY9pGt2DUeEbl6QDwVqJqI/lbx6uZ27NUdmcgVKh0=
X-Gm-Gg: AYBFou3G3p+yd2Vgcnj+izG0PiwAHs6DM6G2E+5Jlg6RAxPTMxgUJRSt4wugK1dEjqU
 6MulDbd6Q05+m4aYlZAPMrdwVekS7uTV0x07bjmXkK7cgl5MxHj/bHp+6Yl2kk4GhXq8ep1lswM
 Jr/vAAthdqs+RaGnxUKtzclWRWgwI/2/ydXq3Jv4LKv3YdY/mgAOydt0/5r4skIDmZHIiXtA5pq
 FkpMO9+8kum3I69KCpfuKJprr8u2HAGIswK9+6Ri2wqA2rO6Owz0qmwM00IrxwurhN4tst7ZafA
 kd7eQwV6NpgxtDSVXXxyvgc7+84eTqCktNNtwjASLUEBM45SkUxDvTPDaOobEQtG0U7gsXB/D/S
 Bt93YNUA/HFgFfp4q1zO74DzR8aaWO7KgxKxcvpeOghuCL6ZsFCalKKYu3U6xddSzq91eFsh30c
 +Wc9r893acbNx/J58vKgD+60EXwzSTtitZyHL7cBPdLPW8UuxaHJrOD6XlQBYvggSD6hhaLuFLH
 ymp8J1yBwY5QnXxLkjWNsBAAiXWjKx3kUEinrlOxZ79KAjNvqRud8Ee1kyf/Bho1qsZWhfjfGCl
 5lWX0BLlSkyAIUFTjqwv5JxHXN9LGWPTRGtEWnX+cDJrwJYNfUM0mEp1Nk37yP0NqA==
X-Received: by 2002:a05:600c:a41:b0:4a0:1c0e:b057 with SMTP id
 5b1f17b1804b1-4ac150b2136mr386865075e9.4.1793869967465; 
 Thu, 05 Nov 2026 01:12:47 -0800 (PST)
Received: from [192.168.0.116] ([81.79.79.1]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48fece99d67sm9014875f8f.24.2026.11.05.01.12.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Nov 2026 01:12:46 -0800 (PST)
Message-ID: <9c1805b5-06ae-426f-b286-9bbd43538afb@ursulin.net>
Date: Thu, 5 Nov 2026 09:12:46 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/syncobj: Limit the number of handles and use
 kvmalloc for user-sized arrays
To: "Yu, Fei" <fei.yu@intel.com>
Cc: christian.koenig@amd.com, airlied@gmail.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 maarten.lankhorst@linux.intel.com, madhurkumar004@gmail.com,
 mripard@kernel.org, simona@ffwll.ch,
 syzbot+95416f957d84e858b377@syzkaller.appspotmail.com, tzimmermann@suse.de
References: <39be711e-cd56-4a04-87ee-6aa2a0b69779@ursulin.net>
 <20261105081845.1230910-1-fei.yu@intel.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <20261105081845.1230910-1-fei.yu@intel.com>
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
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 05/11/2026 08:18, Yu, Fei wrote:
> From: Fei Yu <fei.yu@intel.com>
> 
> On 04/11/2026 10:27, Tvrtko Ursulin wrote:
>> On 04/11/2026 09:44, Christian König wrote:
>>> On 11/4/26 04:09, Yu, Fei wrote:
>>>> +#define DRM_SYNCOBJ_MAX_HANDLES        (INT_MAX / sizeof(struct syncobj_wait_entry))
>>>
>>> I really wonder if we should put that into the uAPI files?
>>>
>>> Not that userspace is potentially using it, but this is part of the uAPI
>>> and makes sense for documentation purposes.
> 
> I thought about that, but I'd prefer to keep it kernel internal, at
> least for this fix:
> 
>   - The value is derived from the size of a kernel internal struct and
>     from the kvmalloc() size limit, so it is not the same on 32-bit and
>     64-bit. To put it in drm.h I would have to replace it with a fixed
>     number, and that number becomes ABI. We could not easily raise or
>     lower it later.
> 
>   - Tvrtko's series below avoids most of these allocations. Once that
>     lands, the right limit may be different, and an internal define is
>     easier to change.
> 
>   - The patch has a Fixes tag, and keeping it out of the uAPI header
>     keeps the stable backport small.
> 
> For documentation, I could send a follow-up that adds a sentence to the
> uAPI struct comments, saying that count_handles above an implementation
> defined limit is rejected with -EINVAL. That documents the behavior
> without fixing a number. Would that work for you?
> 
>>> That kvmalloc_array() + the following copy_from_user should probably be
>>> replaced by using vmemdup_array_user(). But that should of course be a
>>> separate patch.
>>
>> Btw I tried to do that some time ago:
>>
>> https://lore.kernel.org/dri-devel/20251106132645.28208-1-tvrtko.ursulin@igalia.com/#t
>>
>> I have as local, more recent version which applies, but apparently never
>> sent it.
>>
>> Interesting part should also be the other patches from the above linked
>> series which avoid allocations altogether for the vast majority of cases.
>>
>> If there is interest I can re-base and re-send after this is merged.
> 
> Thanks, I wasn't aware of that series. I'll leave the
> vmemdup_array_user() and points array cleanups to it, so we don't
> duplicate work. Happy to test it once this fix is in.

Thanks - just to clarify though - I understand I wait for your patch to 
land and then rebase my series, right?

Regards,

Tvrtko

