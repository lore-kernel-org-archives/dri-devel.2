Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AC62C9830B
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 13:00:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D852610F003;
	Wed, 23 Sep 2026 13:00:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.b="HEVnf4po";
	dkim-atps=neutral
Received: from mail-dy2-f43.google.com (mail-dy2-f43.google.com
 [74.125.229.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B5A010F003
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 13:00:35 +0000 (UTC)
Received: by mail-dy2-f43.google.com with SMTP id
 5a478bee46e88-328664d3421so544081eec.3
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 06:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ziepe.ca; s=google; t=1790168434; x=1790773234; darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=3lvjhy1fcuALXtgW37aXB9csFPun7VRHCuWT7ETMTgM=;
 b=HEVnf4powZ+3FdK1L42O31zMKtmjvmqlJDBsHYs5BLXnedpparC+wBkktkNeu6YOLq
 SMLPglWBeBrMavNbE1wxWTV8iBHbC4M5cBgPbkUNBZcTQ5zStDeasShGqZdtA8wI41tM
 i61YVY34xDJsUjtj9WOB5CAqysq2DEmewxcV4GbiksDjcqr6RgMckeK/IZhG2pdw/M2x
 EYNmIPj3w5XNSZJdG+OAx4NL4He8UapFIHcfWEjtJusQ99Ck5VRs8GHTbe+/HhqB0QDj
 IY8EpwbjBIt2uT9dm7Vf/IHvx6aYjHnznRmobQhLrCcxF1oej21L2Z5Io+dCFRB4z5V7
 3gRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790168434; x=1790773234;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3lvjhy1fcuALXtgW37aXB9csFPun7VRHCuWT7ETMTgM=;
 b=eqzRLNUUJQpkfCwH4Vf/O5ikkUEh2XMPlWC4qZQCrQNi/XzlF1lfjDctdtRMLmbT3Q
 R5oYg6ciptDhwbGZmcDr6BNAAj+vW5WLNKW2qgI/6J2cighFz8LxBphtAOtKKwWR6srX
 aNWT++Cx7c7t2KuyyvRJQz7sgU9hXyhICgZCGEeEuNJdT3+AqWWfPSxIP4rtkFlVGukA
 AUOQlFEr4F/ICWcFWXzCO2uz5LLLbm78zlq78lqw31onQ0ooFLteBaeI+MA+J9ZZYcku
 4RCMJv82KbMJ26e1xBmXgt3Gt6nUswwJGoB+mf8gPuazhNHS2kFdhjKbBiSBH6wETMr1
 UxEg==
X-Forwarded-Encrypted: i=1;
 AKwUvBykrnLmI8T6CY+qy/D2UCYc8/6UMAB6BqDzf5xHu9UKR5yWiV46d04Lxx8bMDplm6oxm0USZsQjlAc=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nLgRJdVRjTuvHfzJc/zMwnRT2wB2uAs4LGD5r7xDLXSUSDrgCE
 oUaDNdqkfJRpA4ysFr235L322jx2eEQRps0zGw+nSTmctIhqZgWXbOFRHid6S0vv7SUTtS+h7qF
 ZwzX8
X-Gm-Gg: AYBFou34M7BMEV7BAgy6uNgRjAnDtaUFX+YZTRSlOkAcxNUaDxNxb7scKKLwIudiNOH
 HgiNMv323v/38VDQv3DZNXDDCbOt+ICb9hMS8s5H9tRjO9k4rJo4yfecV9lIrJLbl9Lm/WNx6Ql
 LLSZXBiXKkrdgJdd9swni8+Pgv5vP02Xao8tevgXUjfWuBDJDtVVfvwmNPSpqpjz1zdCA25VnAL
 Twu74Jwtb4fgvtnnLxQawlIRxeq27H7BeOLro2QyGMmBonQYpwgwDiLTwvLFR3Sw/DGtOM4OOn5
 ns9e8Um8u7iHhmDVKkZ1vADNcQZgX913V4sRYjOFa2mV6jg74vOpYgdKSQ8Q475rWL+wwu4s2aX
 0Kcm231v208rLCaG6WtHeG3a4KartWxkCqZE0rjODaoa8QR8Qi0wWtlwaNs+Gqw4J75vuuafSDH
 JSx4qqW3saTrKG4qUteoROX62blIuatozjfcuyBTw10VTy5VkK7y6fQEE=
X-Received: by 2002:a05:7300:7949:b0:31e:b832:be with SMTP id
 5a478bee46e88-33e8c24a34bmr2627336eec.10.1790168434062; 
 Wed, 23 Sep 2026 06:00:34 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33e96358e2bsm6859478eec.16.2026.09.23.06.00.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 06:00:33 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
 (envelope-from <jgg@ziepe.ca>) id 1x9MaO-0000000DYPQ-01dr;
 Wed, 23 Sep 2026 10:00:32 -0300
Date: Wed, 23 Sep 2026 10:00:31 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
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
Message-ID: <20260923130031.GE1540250@ziepe.ca>
References: <20260921144847.501151-1-aneesh.kumar@kernel.org>
 <20260921144847.501151-3-aneesh.kumar@kernel.org>
 <arKsFofudnTYpXj1@arm.com> <yq5aik3w344o.fsf@kernel.org>
 <arOfD6syXOgQhZYA@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <arOfD6syXOgQhZYA@arm.com>
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

On Wed, Sep 23, 2026 at 10:42:39AM +0100, Catalin Marinas wrote:

> On pKVM, we want set_memory_decrypted() to zero the buffer
> before the host can access it (I guess currently relying on __GFP_ZERO
> allocations). Since no cryptographic encryption takes place, there's not
> much point in memset'ing again after the operation as the content was
> already zeroed.

It sounds like this a pkvm unique thing, since RMM always makes the
memory hidden, pkvm flow should do it too. Either inside its guest
set_memory_decrypted() or inside the hypervisor like RMM.

Hypervisor doing it is the right place, hypervisor always needs to
ensure guest memory is cleansed whenever the guest gives it up. Either
via a private to shared, unmap or just exiting.

> I don't think cc_make_shared() has the right information on how to
> safely and efficiently do the zeroing. That's only known to the
> set_memory_* backend. So you'd have to propagate the flag down.

+1

Jason
