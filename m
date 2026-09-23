Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6E83C98304
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 15:21:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 34E6410E100;
	Wed, 23 Sep 2026 15:21:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="KjUzL+i5";
	dkim-atps=neutral
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 322AF10E100
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 15:21:18 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-49ccf12bed0so51435e9.1
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 08:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1790176876; x=1790781676;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=EE5PAnd1Wf6p3SmBC2optXiNbJWsLePJtC5K69fq2H0=;
 b=KjUzL+i5gfXcWjMkL7v9GLMofUT282xi3o2H+9elbG0SaYRtKR30K6A7/dCXkS4dHr
 6ewJbdz1Phvhp2SG5wLiholCKixxma6cLl5MSHLhsHb5SsTsEwG/hZl1DmlhOxgW3R+Q
 dbE2HUSIHmbOP3yud8ETAl8vPxW3dKOMncON9RUpouK/rJU/3aPpQJLpyafDmlzVKU45
 Qk/LIuYFyigP980jrrcxxSd8XW7r8JDIl1BrUy7m1H/3Si79+IvUtBKWa48gljSzaULq
 qZkMF8pXLTi+M8q7EAYmoY7M4+aZPM8kLs0toBzQlTA8OYZKfqiFUjvD1fnImeaQK8OF
 rI0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790176876; x=1790781676;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=EE5PAnd1Wf6p3SmBC2optXiNbJWsLePJtC5K69fq2H0=;
 b=JPiT6MUaHhbiNs0KJuKW/AQv0LcrJYBqKVbGhTFKujA+kXVA3Yaaa2g452KTJ9APxv
 P0Rk9kYvq0gXTEse+ircpgLiTGnTYsDgcKZf4bpcro+W/GD7qdmdrt6VjHWgUDJOthSV
 6FQGI2KiYIcJULi6J3PMPWtPvzWr+MAmW4YJz87M3szWo7YG+Y6WxkJvVYsV1uXz85VR
 rjFEIEMxTU8dlLFbHc54s4sgaXDKyKA7mDJvypmpOOKC1uXL2KHh0yYNnVKuSdscQ37S
 s/tm/+kjuELfHRNYYZfvIBUFP33Riz4MVKPf+lsZJbV37lUa34E2wn4nb9xC5BEo18+K
 D1Tw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwpJrv3wCU26FjYIEU8sS9vDFVZGpDjlwMsmBcdw43ABvSBjm/GZmWBuKgt0bXyMJh7Tkp2DjyI5HY=@lists.freedesktop.org
X-Gm-Message-State: AFuF++naiKPlBtDUwVdPCkXoAEa0+aahdTWNliH0eWoglkuDObbmDUdN
 vNPLXOXT+wHWpqDQcsmCmRyBJTQU1+45d3W+9WJZvFylPqPvVkv5dJij6k38b/RVclKN7KTeCrQ
 d0iQKZg==
X-Gm-Gg: AYBFou3VrAmf2BoJV/m3F+9vJErRj8G5iDbRVWPySS0y1Yk4i2e8fU5vGI6TzcQnfWA
 bHjukb7T0ZnG6AVy4TMJKNwIpsiJdy92NSh0VJ7imjj5iCzMwAF+jlux/MBmSzfhDyCyILvOhnX
 zHM6qYyCcbijVqSVojnIhNZTjQAjX4yBX3C6hv3k6k7278EyX2K8R9lxVrzJo3Mkm/60Ll7pwON
 kcD9SlkAw8dWj8JMgAus8MYP6WEtdANm2rC31w4RInxKPzgcqLB39KE5t+JmHHZHE+uPjasYKar
 SPxv5N5kcy9fPRP72RA2iZZU5At/wyia6CsVuCh5StorqA1O3RoNUpxvENMsHDEhfv6aLiV0DJg
 D7qF3/lCYxvwlNQjXdHZV1TPamL+N3sUWZPQAlYhIf7L/y7pP3rTgjLZwLWtU2qE46IKJzNVvzG
 Uwo5b1Er7gO2umW5aOguTzqgXGkm8e/rqDnfgCdmuozcaSC2HGeIikMulOJpkmA2CtCyqBfwG+j
 79izx89moDnN3XJtBsSwSwc/lgl+V3GgLxrnKK/
X-Received: by 2002:a05:600c:4e8f:b0:49f:e1d3:fe03 with SMTP id
 5b1f17b1804b1-49fe586ff32mr27765e9.3.1790176875531; 
 Wed, 23 Sep 2026 08:21:15 -0700 (PDT)
Received: from google.com (250.192.189.35.bc.googleusercontent.com.
 [35.189.192.250]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fe0c3ed96sm1697075e9.2.2026.09.23.08.21.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 08:21:13 -0700 (PDT)
Date: Wed, 23 Sep 2026 15:20:43 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
 linux-coco@lists.linux.dev, kvmarm@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev, Andrew Morton <akpm@linux-foundation.org>,
 christian.koenig@amd.com, Joerg Roedel <joro@8bytes.org>,
 Marc Zyngier <maz@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>,
 Robin Murphy <robin.murphy@arm.com>, Steven Price <steven.price@arm.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 Thomas Gleixner <tglx@kernel.org>, Will Deacon <will@kernel.org>,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 linux-media@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC PATCH v7 02/13] mm: Add an allocator for CoCo shared memory
Message-ID: <arPuS9FXrkYJhbiA@google.com>
References: <20260921144847.501151-1-aneesh.kumar@kernel.org>
 <20260921144847.501151-3-aneesh.kumar@kernel.org>
 <arKsFofudnTYpXj1@arm.com> <yq5aik3w344o.fsf@kernel.org>
 <arOfD6syXOgQhZYA@arm.com> <20260923130031.GE1540250@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260923130031.GE1540250@ziepe.ca>
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

On Wed, Sep 23, 2026 at 10:00:31AM -0300, Jason Gunthorpe wrote:
> On Wed, Sep 23, 2026 at 10:42:39AM +0100, Catalin Marinas wrote:
> 
> > On pKVM, we want set_memory_decrypted() to zero the buffer
> > before the host can access it (I guess currently relying on __GFP_ZERO
> > allocations). Since no cryptographic encryption takes place, there's not
> > much point in memset'ing again after the operation as the content was
> > already zeroed.
> 
> It sounds like this a pkvm unique thing, since RMM always makes the
> memory hidden, pkvm flow should do it too. Either inside its guest
> set_memory_decrypted() or inside the hypervisor like RMM.
> 

pKVM doesn't clear memory on sharing (see __pkvm_guest_share_host()),
and that is not a documented behaviour for ARM_SMCCC_KVM_FUNC_MEM_SHARE
(see Documentation/virt/kvm/arm/hypercalls.rst) which implements
set_memory_decrypted().

The guest is definitely the one knowing what is inside the pages and
whether it can be shared or not.
For example, a while ago I was experimenting with inline decryption
to avoid bouncing, and I imagine it might be used to build on in the
future.
Also as these hypercalls are ABI, I'd argue we shouldn't change their
semantics.


> Hypervisor doing it is the right place, hypervisor always needs to
> ensure guest memory is cleansed whenever the guest gives it up. Either
> via a private to shared, unmap or just exiting.
> 

"gives it up" is different than sharing, for example:
- When the guest dies pKVM will zero the memory before returning it
  back to the host.
- At the moment the guest can not relinquish memory (ballooning) but
  that is supported in Android which can zero the page.

Thanks,
Mostafa

> > I don't think cc_make_shared() has the right information on how to
> > safely and efficiently do the zeroing. That's only known to the
> > set_memory_* backend. So you'd have to propagate the flag down.
> 
> +1
> 
> Jason
> 
