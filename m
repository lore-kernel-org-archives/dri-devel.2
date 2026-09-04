Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79195C79F80
	for <dri-devel@archiver.kernel.org>; Fri,  4 Sep 2026 09:07:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CCEDA10F989;
	Fri,  4 Sep 2026 09:07:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ursulin.net header.i=@ursulin.net header.b="jztT4twN";
	dkim-atps=neutral
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com
 [209.85.218.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B0BC10F989
 for <dri-devel@lists.freedesktop.org>; Fri,  4 Sep 2026 09:07:27 +0000 (UTC)
Received: by mail-ej1-f53.google.com with SMTP id
 a640c23a62f3a-c20ce3c118aso161285166b.0
 for <dri-devel@lists.freedesktop.org>; Fri, 04 Sep 2026 02:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ursulin.net; s=google; t=1788512846; x=1789117646; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=m7wdy2Og9YO6nxxlPkfUyoT4MUWUNJ9x4RWvdbL0oNU=;
 b=jztT4twNTYbA4IzfJDRrxE33Cqm0aE6f4ejfyzUew5DNXBzXNftY2YVNOq9CMM4EqA
 jv8PDueVAQzYhO8sIkXtjcKHpEO1OD2dbVUYDMdPmVigR0wnT+OB0g1pQr9RCIiDOYPG
 kDbxoWy/IbQwbLFfYvuPEd7THiibDym5Jd3tIk2PoSjqR71d4aKifRKzqhIuILlbIPi2
 uTX868x2ZLNY8MJ8ukdcQCZMMI4PvAysZ190UhxuMPlHGDi6tTLNCzvh3ovDUSE7VZe7
 aemEkDIW9C5BAtyU3RJ/91DkXogEdDalFo4tpJQGERiDTG7d5aNIrKBUgqBIUakkixRb
 4Img==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788512846; x=1789117646;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=m7wdy2Og9YO6nxxlPkfUyoT4MUWUNJ9x4RWvdbL0oNU=;
 b=iowWNyhlPJs4YGvoMJSu/upcmxwqVIP1nMmIBMfizp0cFGu4RFbY6Ax+YHz0B7eDXT
 TLH53rY5azLzbhX0LHdpLBWm5PXl9/7mKpm1hWlOF7UUcB57vjNpZFXCVhBBGSlUj3it
 NMXZWOiLjr0+OI7+ag4zrZrmJb3KRM+xb0R7VEomyf5mEmbJrcZWnCaVO9rW8SAdhxnw
 QR85hRLnOBwvzrR3m60Dzkfkwel3YGtMidphF1H9Vm8F/SmUYdBPZOKwP2N9OZUbPJqA
 qspZKNCoyM6jOh0k7xKCO4ykxzq/ticyrNDHf76y7q24wUjHRiIWaK67DrQoSkK8LzFr
 0AeA==
X-Gm-Message-State: AFuF++n3wDjFzpL6EgIhzCEXrscBdHFt+HZA+XsSynI93cQ+YdWbPtvz
 yIUc3WZHR+7IKYcU+n6jIw1XuzNpLLYZ+3ShEUgoZLL6UA4nVD7GQszSAk4EQbBBgEU=
X-Gm-Gg: AYBFou1GQzVvY0flftHkmrXZgCwXYYVOzwBhx+3YydZcOgsbAhfCIKT0bKQf86wU1cj
 /QKJ6EjjOmW+6fEIOA3tMPfLHA8DWV/j8JfXNTR4rL5O2BOHAFDu+XDkk23uguWLJ9F4IMMXRNm
 wH2XIN8x+NMPn6yanDSQQ8ZUX63BcPeQ9IUmI4NcDIT3/SaRdThESmeomv+1MBe62w52Iv1YDbj
 rNOhVSbw0f/GvXqCdgH6OYRCurQ2gljpJxTEW/acd9GU3yYK8PJfz3rb+PtLesrZTXe0Z/DKTpP
 UrivcpEOu/CY8ZOjSfKn6Qwda5cbYDdnVfnZInP6pQFXbWiQhdNDpxdaofA0rQTlEWz9sG+LpyH
 z5BM7yGmIZ8LLDuwbw7h5dZ0Ixm0fCOkbEJ25m9esxTvuvxTy4cDGrKBUwceigrD6jBxKBqV7V9
 EeJ7KOJfiDMMWSvdlYAHiCSkL7TM674cue3FYmENjaRlSwNA/u8nXoBVCoI3x7GHscLDEK/fAuE
 Qmu
X-Received: by 2002:a17:907:c011:b0:c25:f7dc:2d3 with SMTP id
 a640c23a62f3a-c25f7dc08eemr348191166b.20.1788512845236; 
 Fri, 04 Sep 2026 02:07:25 -0700 (PDT)
Received: from [192.168.0.116] ([81.79.79.1]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c260d4a8b89sm77245566b.10.2026.09.04.02.07.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Sep 2026 02:07:24 -0700 (PDT)
Message-ID: <161c4e19-bff5-4dd9-ab24-10c5893047d6@ursulin.net>
Date: Fri, 4 Sep 2026 10:07:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3] drm/sched: cache the timeline name to fix a
 use-after-free
To: "Jonghyuk Kim(MalHyuk)" <malhyuk97@gmail.com>, christian.koenig@amd.com,
 phasta@kernel.org, matthew.brost@intel.com, dakr@kernel.org
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 mdaenzer@redhat.com, alessio.belle@imgtec.com, luigi.santivetti@imgtec.com
References: <20260904080618.2098450-1-malhyuk97@gmail.com>
 <20260904080618.2098450-2-malhyuk97@gmail.com>
 <f25f2a91-b72e-4392-ab53-c11ef60e0fe0@amd.com>
 <20260904083138.2135429-1-malhyuk97@gmail.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <20260904083138.2135429-1-malhyuk97@gmail.com>
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


To address only one narrow point quickly, I haven't had the time to 
catch up with the thread yet:

On 04/09/2026 09:31, Jonghyuk Kim(MalHyuk) wrote:

8><

> One thing I noticed while checking the callers: the tracepoints in
> include/trace/events/dma_fence.h and drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
> call fence->ops->get_driver_name() / get_timeline_name() directly instead of
> going through the helpers, so they are not covered by the above. That looks
> like a pre-existing and much narrower exposure (tracing only), but let me know
> if you want it addressed in the same series or separately.

For the dma_fence.h see the comment:

/*
  * Safe only for call sites which are guaranteed to not race with fence
  * signaling, holding the fence->lock and having checked for not 
signaled, or
  * the signaling path itself.
  *
  * TODO: Remove the need for this event class when drivers switch to 
independent
  *       fences.
  */


These tracepoints call the name vfuncs directly: dma_fence_init, 
dma_fence_enable_signal, dma_fence_signaled. So those are supposed to be 
safe as per comment and changing them to use the helper would create a 
different issue (can't remember from the top of my head which one - but 
the thread is moving fast so I wanted to reply quickly).

amdgpu_trace.h also look safe on a quick look because they are called 
before the job which can signal the fence is submitted.

Regards,

Tvrtko

