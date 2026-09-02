Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20246C624D0
	for <dri-devel@archiver.kernel.org>; Wed,  2 Sep 2026 10:20:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0441B10E204;
	Wed,  2 Sep 2026 10:20:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ursulin.net header.i=@ursulin.net header.b="HRdFwjqP";
	dkim-atps=neutral
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com
 [209.85.218.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1AD5F10E204
 for <dri-devel@lists.freedesktop.org>; Wed,  2 Sep 2026 10:20:47 +0000 (UTC)
Received: by mail-ej1-f52.google.com with SMTP id
 a640c23a62f3a-c1712a04ddaso129988966b.2
 for <dri-devel@lists.freedesktop.org>; Wed, 02 Sep 2026 03:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ursulin.net; s=google; t=1788344445; x=1788949245; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Oi/NDwcA0J3U+bwSn6NVnqyGm5srlRNDTSewq/eZdK0=;
 b=HRdFwjqPP4CqdkwCKtPlH9HIOwz/iXAQhfJlOcEp2RgD/ADZiBGFA7SKVtLixAu0GA
 u1qhj9d6aMLNOxjT5+nUIG87De4bSIz3AJDq4R3s1aUaYOTQV1mjU534g8qhPgXE5PrJ
 pWHpx9FXQ6DlbELsCOzItYjfkAPHtxLpmHolmGzletVGNw1h343+E/obs7HxFlVkQJ/E
 cYSf6tvUHPBn+wTY4BA20/m62v/N7baHrLCElueniKXJ3fT2PidP2J25gfXG0QrC4laU
 SpxNvkynEOPqWIlgiH5R6gmAtprGyQqcRmvrn/1zCPcMYo66TpYdCgRCVcF+Nf5EQf21
 xvfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788344445; x=1788949245;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Oi/NDwcA0J3U+bwSn6NVnqyGm5srlRNDTSewq/eZdK0=;
 b=plGN4eNHgl5SNqUiWyiyDEnusWxGogNe+qAt/lLCNewfMNUAEGxbPsWnUIlHDdInTH
 d3sMEP9vPAzurVrTfhkjRxkvSpi3+bAt5POXCKurblu973QlajL93hVt4OZRco2iljgC
 sLz1ksZH6Vla9meXi29ugQ+GqYgFVAWiIe1e4crn/PuG+iRj/wnFLHR96pE3AIsuhlRH
 5ng336ssR6t9idpcsLMdigUPbD9/TStfCgKsdSdsI3/dpzEyw0K++Ht7Cv5Zi9jIq4to
 +lamiiz87qQdEr7IufvLijpaqihVJCjqQWBUwPC/NeJlzU/23NkFJiyLYyaAeatQ3lES
 P59A==
X-Forwarded-Encrypted: i=1;
 AKwUvBwsquoWw9SokhY1sDEqDRdKQgvxlVbAHN0Wc3gmrEWCFr4UzeADct8/XfxALgd3NtKelx2bKjGFHgM=@lists.freedesktop.org
X-Gm-Message-State: AFuF++m+t1oRF0kNqNXmh/URHc5eQ1P5u2FCrXZh/TeP5wO1HUeNdQpK
 De78wfLa3Qpit4Ho6n+A5veP4eCMDrzJLsDfYBObbQbjEq7vyy8eRrBoZStg/Fcvsc0=
X-Gm-Gg: AR+sD13eAWkh0uZ9slAvHa4rC88WDuOCHCy5CkhvZ1u6zmUzwXEqv84y3S6dEhu6eJ6
 G+TQPLh4qS6aCkHpfYf2+3A3WQj5PoRPThVhJWWzIhGgRDTDCeQwM3w1C7H1aeMsecKsKNEFKFD
 AGdz3/iNNyL47G0VWm9oxkBNT1FvOQPIZbNh5fa5F8lWgct2NMWwsqdjAhgWjxT1gIserfaqi8I
 PYf6e44+CXU4XYG0yIfwRRZoZvZtC/3Kw2lBNQT8pcWEc5gMdiRAIdXFDW1n46MdYw4ABh5YUud
 hgq5o6EjZOY+uH+DEFMMkf+qCbeb6/o89XbkPp3iX3eBfhFFGhyEepmQLosGROM4DQO5DS2QdgR
 cO9F7/+DCXWVy6y7J8Q0CDDeiSJqxMSZDW6JI2BaDKbLBF+klTjffBfSIVmYxVKsDuSVvEgKKXH
 2n0HF5BoASWlS5t4a9cbPEhYXjA0aS9mVsCJmR5hWQN0CxL6BiM/9UmsolUPLGR+05xyo6/urQG
 6US
X-Received: by 2002:a17:907:7b84:b0:c20:d90b:2cb1 with SMTP id
 a640c23a62f3a-c25d4c90186mr231285366b.0.1788344445336; 
 Wed, 02 Sep 2026 03:20:45 -0700 (PDT)
Received: from [192.168.0.116] ([81.79.79.1]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c25cffc68a2sm107135566b.11.2026.09.02.03.20.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Sep 2026 03:20:44 -0700 (PDT)
Message-ID: <619669b6-69ea-4aa5-b91e-b29cc788e335@ursulin.net>
Date: Wed, 2 Sep 2026 11:20:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] drm/sched: cache the timeline name to fix a
 use-after-free
To: phasta@kernel.org, =?UTF-8?B?6rmA7KKF7ZiB?= <malhyuk97@gmail.com>,
 matthew.brost@intel.com, dakr@kernel.org
Cc: christian.koenig@amd.com, ckoenig.leichtzumerken@gmail.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <8c2a4df5-37a4-414e-81e2-cd97218e5355@ursulin.net>
 <CADQRuqtjBu7wR4kKVDcS42KLKQTr+7SBtRn24mgZ+ApettMr1A@mail.gmail.com>
 <b8f98b9e04c9999008bcdec270b14247e3cd18d0.camel@mailbox.org>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <b8f98b9e04c9999008bcdec270b14247e3cd18d0.camel@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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


To collate two replies in one:

On 02/09/2026 11:07, Philipp Stanner wrote:
> On Wed, 2026-09-02 at 02:57 -0700, 김종혁 wrote:
>> On 02/09/2026 10:46, Tvrtko Ursulin wrote:
>>> It is not guaranteed in the documented contract that the name passed to
>>> drm_sched_init has to outlive the scheduler.
>>
>> Right. Caching the bare pointer only works because every in-tree driver
>> passes a string literal today - xe's q->name (freed with the exec queue,
>> hence 299bc6d50b1b) is the counter-example where v1 would still dangle.
>>
>>> Hm, that might be overkill.. how about we just keep a copy of the name
>>> in the scheduler object?
>>
>> The catch is the scheduler object is itself freed on context teardown, so
>> a copy that lives there dangles for the exported fence just the same. To
>> actually stop dereferencing ->sched the copy has to live in the fence -
>> kstrdup in drm_sched_fence_init(), freed from the fence release. That's an
>> alloc per fence on the submit path though.
>>
>> If that overhead isn't wanted, the lighter option is to keep the pointer
>> and document in gpu_scheduler.h that the drm_sched_init() name must follow
>> the dma-fence safe access rules (outlive any exported fence). That matches
>> what the already-fixed drivers do and leaves the submit path untouched.

Yes, thank you, it would have to be this then. We definitely do not want 
more allocation at fence init for basically a debug only / logging feature.

>> Either one fixes amdxdna/nouveau/msm in the core. I'd lean to the
>> documented-pointer version unless you'd rather pay the kstrdup - let me know
>> which and I'll respin as a core-only series (fix + the kunit test).
>>
>> Thanks for the 6bd90e700b42/299bc6d50b1b context, that clears up what the
>> half-fix missed.
> 
> 
> The issue here IMO is that we are discussing working around an issue
> that actually stems from dma_fence not being consistently synchronized,
> notably because of the ops->release callback being implemented.
> 
> ops->release is de facto deprecated, precisely for reasons like these.
> 
> If we could get rid of it for sched_fence, dma_fence would take care of
> the decoupling of the name callbacks.
> 
> So that appears worth investigating from my POV.

I completely agree here but I am just not sure how feasible that would 
be. We may accept to live with the cross-documentation workaround at 
least as a start since even if feasible it could be a lot of work to 
change sched_fence like that.

Regards,

Tvrtko

