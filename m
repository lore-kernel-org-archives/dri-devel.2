Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BC7AC79F9E
	for <dri-devel@archiver.kernel.org>; Mon,  7 Sep 2026 09:15:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7263310E710;
	Mon,  7 Sep 2026 09:15:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ursulin.net header.i=@ursulin.net header.b="nOXv+GlE";
	dkim-atps=neutral
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com
 [209.85.218.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 26EE410E710
 for <dri-devel@lists.freedesktop.org>; Mon,  7 Sep 2026 09:15:33 +0000 (UTC)
Received: by mail-ej1-f53.google.com with SMTP id
 a640c23a62f3a-c25b661d37dso446855066b.0
 for <dri-devel@lists.freedesktop.org>; Mon, 07 Sep 2026 02:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ursulin.net; s=google; t=1788772531; x=1789377331; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=xBgijUTK0RaiV4bs4COhasChcigDnWDkUPfx1dw6myY=;
 b=nOXv+GlE4eOe5xlIcvm4QHuQhGj+8GIEs9aGAn1tQgbkS8yVv/tinyiPWfjiOzMz7Z
 98SsujSbB/h1PaIBLfUXPejKlwgtNtCINLLN3wuedsv57mIvhAy7hE7SBKxqlmgCCDJN
 ZV5+9mMi+yTDQdmEvATvsACik8ZsNbUJ6g7yu8vIRs06HpbbVTq+9rKKF2wRHyRoYwPG
 +HK6HyxkYb+7aSRtZUNB/rpjUt4zZciRtAjuhXR211eXRoEwxuMFl4HvQY73OjOw4mAd
 B9Nr1qEnDGR5ZF+u4fVie1WzPWEebRFwoJTymNQeAbtWmE92MG98vWdD6aXz5QhybXCO
 MRiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788772531; x=1789377331;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xBgijUTK0RaiV4bs4COhasChcigDnWDkUPfx1dw6myY=;
 b=Ft5fS8d3AqzJZNZhfCNjU0dBMHggAQMnnVoVvQtf6DYO3fbwgLxLFyGCaAAkHS1GA/
 GLKVkPTm3YQb0iHtBAZgYIYKBgTEkYJ5J9IBkWj4SuCnvfjtQzMzztiD0HAJa+bVLXyk
 RBGyNC/Uz5kuvkJ/9z1JKCd2gG5Es/iipcLKW+Fzg3pP2HK7sfY5bmawpmNDyd9MAU0F
 Ua7YIGPpphu/HUKHwXMUg1apI9i/aCyRDFLjmiy1dKp3Kz6mV9wSdlNf881ccewlgwvr
 +xcFBoNKREu2e5iGD9qvRnboO9cQTLVDLEtfK9xzlMAZRg1rlTIVOMW1TmEHQpwX6WaG
 255w==
X-Gm-Message-State: AFuF++mN/zW5yaLZBZ81aFL3uT9LcF5OK/j3XISekfKu5z27WQhC/QYa
 GDhWtUnjGkHpFQEfTUVJNKuuypxvYEq1DEoc+0F+hvhOZDVVUxeS5k7MecKaTJlA9O4=
X-Gm-Gg: AYBFou1heyIPh5rI+U565uLsT+8y81MPZchdAjGlCtg+hJ9QI6NtmwM4OuKWiSXydCG
 x6XQlQRKF1Pgcmfz1smR5iIso60VVeNByHMBBDq1kyzXS1gPamlPnawB7IRt1HMYgbFaKBhMZgp
 Liu5wOD2j8ePj3VVxguN9Eqq6KBLfDljoC4oLa3Waa6j5MLb7LXRORYFC6OqCz8J4cCVwemFA/n
 DSUXz9AWgKAaEz+jU4K8TBAfvZ+rxx2pshNZ+ovjqceoCe4jLa+wE6Xn/yF7pEwZodzHIvUM5+j
 BXfqHfBZfKRsG7b85c8bxnS1nQDH3g1Tw9KML/JMQto7arR1LxGQCs1paCW+r24MJbB3wd0iBvf
 R1EN4Hq/pibmOaVbqEKOkKwyFDWyqwkrwgCKyWrw658aK1/MqibMVpImp+7zGy5oqlRbFOihSsb
 ZWCczQZXhqUN23hYntAhmqhYgfJxHk+i/DRjZ/MRiTkruyFuy7I3Mwp1vVA0AovuVxEo+c2s2b8
 gdk
X-Received: by 2002:a17:907:d18:b0:c26:19e3:e98c with SMTP id
 a640c23a62f3a-c2619e3f016mr677971266b.44.1788772531387; 
 Mon, 07 Sep 2026 02:15:31 -0700 (PDT)
Received: from [192.168.0.116] ([81.79.79.1]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c260d5b371esm443215066b.54.2026.09.07.02.15.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Sep 2026 02:15:30 -0700 (PDT)
Message-ID: <81e51d72-d608-46d0-a986-390ecd6f468a@ursulin.net>
Date: Mon, 7 Sep 2026 10:15:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3] drm/sched: cache the timeline name to fix a
 use-after-free
To: phasta@kernel.org, =?UTF-8?Q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>, "Jonghyuk Kim(MalHyuk)" <malhyuk97@gmail.com>,
 matthew.brost@intel.com, dakr@kernel.org
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 mdaenzer@redhat.com, alessio.belle@imgtec.com, luigi.santivetti@imgtec.com,
 stable@vger.kernel.org
References: <20260904080618.2098450-1-malhyuk97@gmail.com>
 <20260904080618.2098450-2-malhyuk97@gmail.com>
 <f25f2a91-b72e-4392-ab53-c11ef60e0fe0@amd.com>
 <ee27d37269f609192cdfd7a217d9731d7dca04c8.camel@mailbox.org>
 <a41a35b8-c78b-4c18-af11-26374918f222@amd.com>
 <7e4497506bb051fd1c25ed54f88a8036084e779c.camel@mailbox.org>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <7e4497506bb051fd1c25ed54f88a8036084e779c.camel@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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



On 04/09/2026 20:06, Philipp Stanner wrote:

8><

> If you can think of a stupid and simple solution, shoot. The only thing
> I can think of is moving the string into the dma_fence, as a hard copy
> :)
> 
> 
> In the mean time, my proposal is to keep aiming for removing
> sched_fence->ops->release and fixing pvr and amdgpu.

Fixing the drivers sounds like an obvious thing to try indeed. Along the 
same lines as it was done for xe and panthor. It is an already 
established and well understood approach so shouldn't be controversial. 
After that we can discuss in leisurely pace if something better is 
possible in the scheduler core.

I understand its amdxdna, nouveau, and msm. Was it attempted so far? Is 
it significantly more complicated than it was for panthor and xe?

As for regarding the 035219a760ed ("dma-buf: dma-fence: Fix potential 
NULL pointer dereference") sub-thread - I did not manage to penetrate 
the consensus there - whether it was established that it needs adding 
the is signaled check back (with additional memory barriers, like v1 of 
that patch) or not? Regardless of fixing the drivers or what?

Regards,

Tvrtko

