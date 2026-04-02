Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F927D39418
	for <dri-devel@archiver.kernel.org>; Thu,  2 Apr 2026 12:56:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F93910E04D;
	Thu,  2 Apr 2026 12:56:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="GETrP+06";
	dkim-atps=neutral
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E6B6310E04D
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Apr 2026 12:56:04 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-486b9675d36so7015255e9.0
 for <dri-devel@lists.freedesktop.org>; Thu, 02 Apr 2026 05:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1775134563; x=1775739363;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=sdBGEtOVUOrqsu+m2DU0Xpq65+UG7RkCtVPt0Shx5yg=;
 b=GETrP+06xP2PJLkwLl321aP3V2/GwR6rBkqu7d0eRi9mZVxTH87J+AHUSEeN9+j5Ph
 2IgC+jd+FR742nVIUymTZla9fhTx6tkoaXxKXHaeL7fLUkj58JWJm2NMhAU+4h5/Hw/q
 hZ2ifQVXngmT8Dt5qEQOsvdAG9YrdRmyBODOz5J4OiIJHVyNdneqjPP8JGvmewdCLZgg
 DP2Q7C4XqC6CIIHzIRcaaUkf8HX5ZFJ2tssp4GWUveAYw/+xjiOd0PwZFsTx5CwWCYb/
 F3QrVT70vYm/fe8Svc+z1is/7s4lXq/w9AAWyAS1hscQmVjniUWxC5304MW3tsKsDIex
 jKRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775134563; x=1775739363;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sdBGEtOVUOrqsu+m2DU0Xpq65+UG7RkCtVPt0Shx5yg=;
 b=oq8/WWC7aofB7ES/k0bTFj9NOft3NpomtrD3E5hiifEIA6HV+gEyzDmHWcE/zFrXXs
 9e0tXKJhzITo64d+Y7qv7CmN5d8Xk8tnxkFsykK2RW4O/PQljbU02d2J8QgHfkdxnAwk
 L+3R6Y+BAP7C6bt89AhHbyjW7tkID0ml1yW4sHYNyg+jnT6MkSowbhdd885wwN0DXKNi
 AECpsZHYgTt5+dpAf2fyRNxiWVSndgjA7qxP7U8vUs8gEtHb8w8QM6TyfoKj8Bws9rkN
 roHnu1z8dtKJOsaB2t41udjElUPXSVVIt0XmLzAfffBLUUJoRigU7sAZ9kaTsdw0Ec3Q
 nuTQ==
X-Gm-Message-State: AOJu0YxN/tVvpH1pZ0QqV4yde4M0Whb9yfVUBMHJRxJcL7W89k0542W9
 G0q1I9P90K3Q46bA82rbHV+SHnrF6Mo8iI9Mc6lGAbck1N6kKcHvYkgRW3QajRL9+5o=
X-Gm-Gg: ATEYQzwgV1vs6JtmJxZmpAgC959qXtErtXLKiPC66Uw1S4mkQIQmjmGe0FZ6vS+r25i
 42fxoMq7gjfaaj+Iy+/xkjcGt+eTGsl+ZUmvEU/wYu8QBjaRpYi7P98q/N5Mx0F9DkyQH6CXtQb
 tBTz+eX/944Bpg4T2fxd0FyhK7QWoIE8iUxSIUYT3gXMeLwwwcy5g91lHtLzWrmbvxZzM6YlfZV
 y2ugZQXUNPmPguF/D0sZoD5Dq6C7LCb7ge7u9/W98Rr6cmesvL9kT4f/L2e+69zENVswBpteYW+
 7CLA9AtU5ZtmZBIjCrMgf9U0mqtzVlo57eFDMXcFmqXb+vU0I9NELRxFWp2mei2tsBDC5wfTDcr
 yLonT3X/IA/VxAusm116BeEgVyMd/BzgvSezAuM7Zi7lQgb1DAZ4Dd84ii36KtLY0eh6rzSavZA
 q3Fm4ovEhFIJFJ2Y0k0xOlpkuF1So1uNA=
X-Received: by 2002:a05:600c:a31c:b0:487:338:b4eb with SMTP id
 5b1f17b1804b1-4888b7b89a1mr36557135e9.28.1775134563095; 
 Thu, 02 Apr 2026 05:56:03 -0700 (PDT)
Received: from FV6GYCPJ69 ([208.127.45.21]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43d1e4e56fesm7943310f8f.27.2026.04.02.05.56.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Apr 2026 05:56:02 -0700 (PDT)
Date: Thu, 2 Apr 2026 14:56:00 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Maxime Ripard <mripard@redhat.com>
Cc: dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
 iommu@lists.linux.dev, linux-media@vger.kernel.org, sumit.semwal@linaro.org, 
 benjamin.gaignard@collabora.com, Brian.Starkey@arm.com, jstultz@google.com,
 tjmercier@google.com, 
 christian.koenig@amd.com, m.szyprowski@samsung.com, robin.murphy@arm.com,
 jgg@ziepe.ca, 
 leon@kernel.org, sean.anderson@linux.dev, ptesarik@suse.com, 
 catalin.marinas@arm.com, aneesh.kumar@kernel.org, suzuki.poulose@arm.com, 
 steven.price@arm.com, thomas.lendacky@amd.com, john.allen@amd.com, 
 ashish.kalra@amd.com, suravee.suthikulpanit@amd.com, linux-coco@lists.linux.dev
Subject: Re: [PATCH v5 2/2] dma-buf: heaps: system: add system_cc_shared heap
 for explicitly shared memory
Message-ID: <qvp2zepvwnlgcw36bcx47xouskuqk3tzjuomnhnwwg5ahiswt3@zbseau5arjho>
References: <20260325192352.437608-1-jiri@resnulli.us>
 <20260325192352.437608-3-jiri@resnulli.us>
 <20260402-discreet-glossy-perch-bda4f9@houat>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260402-discreet-glossy-perch-bda4f9@houat>
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

Thu, Apr 02, 2026 at 02:23:12PM +0200, mripard@redhat.com wrote:
>Hi Jiri,
>
>On Wed, Mar 25, 2026 at 08:23:52PM +0100, Jiri Pirko wrote:
>> From: Jiri Pirko <jiri@nvidia.com>
>> 
>> Add a new "system_cc_shared" dma-buf heap to allow userspace to
>> allocate shared (decrypted) memory for confidential computing (CoCo)
>> VMs.
>> 
>> On CoCo VMs, guest memory is private by default. The hardware uses an
>> encryption bit in page table entries (C-bit on AMD SEV, "shared" bit on
>> Intel TDX) to control whether a given memory access is private or
>> shared. The kernel's direct map is set up as private,
>> so pages returned by alloc_pages() are private in the direct map
>> by default. To make this memory usable for devices that do not support
>> DMA to private memory (no TDISP support), it has to be explicitly
>> shared. A couple of things are needed to properly handle
>> shared memory for the dma-buf use case:
>> 
>> - set_memory_decrypted() on the direct map after allocation:
>>   Besides clearing the encryption bit in the direct map PTEs, this
>>   also notifies the hypervisor about the page state change. On free,
>>   the inverse set_memory_encrypted() must be called before returning
>>   pages to the allocator. If re-encryption fails, pages
>>   are intentionally leaked to prevent shared memory from being
>>   reused as private.
>> 
>> - pgprot_decrypted() for userspace and kernel virtual mappings:
>>   Any new mapping of the shared pages, be it to userspace via
>>   mmap or to kernel vmalloc space via vmap, creates PTEs independent
>>   of the direct map. These must also have the encryption bit cleared,
>>   otherwise accesses through them would see encrypted (garbage) data.
>> 
>> - DMA_ATTR_CC_SHARED for DMA mapping:
>>   Since the pages are already shared, the DMA API needs to be
>>   informed via DMA_ATTR_CC_SHARED so it can map them correctly
>>   as unencrypted for device access.
>> 
>> On non-CoCo VMs, the system_cc_shared heap is not registered
>> to prevent misuse by userspace that does not understand
>> the security implications of explicitly shared memory.
>> 
>> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
>
>I'm a bit late to the party, sorry.
>
>This new heap must be documented in
>Documentation/userspace-api/dma-buf-heaps.rst, but (and especially since
>it seems like it was merged already) it can be done as a follow-up
>patch.

Okay, will send a follow-up. Thanks!

>
>Maxime


