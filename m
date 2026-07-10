Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDF77C43458
	for <dri-devel@archiver.kernel.org>; Fri, 10 Jul 2026 16:44:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 19A9B10EEA1;
	Fri, 10 Jul 2026 16:44:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.b="bBRztYXn";
	dkim-atps=neutral
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com
 [209.85.160.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5406810EEA1
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 16:44:30 +0000 (UTC)
Received: by mail-qt1-f178.google.com with SMTP id
 d75a77b69052e-51c22c61795so7682861cf.0
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 09:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ziepe.ca; s=google; t=1783701869; x=1784306669; darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=f7jwDOcuUIXFwEJ3t6jZRtuRC5qCtLyV1KSZwcqARY0=;
 b=bBRztYXnhgZn5YtgZ6yG55WVXbwDbgdpcGrzcFRtc0OZgnzEjXz8ubtQ7gkXODsXKR
 SYnmW2gdO6QQ3REQEo2O2V9Tz82tG8PYIIB58meOw4+67NnywYclnNqn3KRvitHT+BdN
 OUFq/SWZVGx5gdtmeF7stOrJ+Q2/tsaLx2HPey4u75om6eHcnKe0PTXT303zdPmN0SdG
 kpQmVJFmZQ4Nb/C5UWdXBh+QvhB75VzgoQZFxO57HLgqOY/pVIBX0YwmtiG49wnLlyjz
 yznrzd6BxvbI6SJtmALZ4vD8WyyhoGzC4MHBmgwo6tXWTqcSXyyaKUvDNNrniX9zueDF
 6JIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783701869; x=1784306669;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=f7jwDOcuUIXFwEJ3t6jZRtuRC5qCtLyV1KSZwcqARY0=;
 b=oENpGq+EaLYtKNiZbK7gYpDNXEK3I+wSGkaSiJJdU4/tc2IryZtNBDXrck5hX6oDMA
 0od2dN9jvY/29EZMFWyIzuS2BAMCsJ72pp+8dVKgH2oAzY3rMp4XSdsYfPxTsy7mCEO4
 JEIsV7gLlNTajpSWdZ3wRxRPg8TgAUtXe2YR/r7Q4gpF7WmxKZV+U0WiQ5PzFcHiuGRH
 a016a2alipNC0iNpcnMHPJeEMxXDDQ7nn/GUuToT75jY9pSG7be/OpFQOIkfcm3RPHOH
 63jpYf2uYoyz0pbOxhk0uV1SAsgHzi6drD35SZWVqdLuiUVhTn3fhtkmhpTBfg1/rNR6
 o4QA==
X-Forwarded-Encrypted: i=1;
 AHgh+RpBC3+U398pdWcypwJC2y8zvHmZrEt96wo/b2HWh5++yLZC4YP+CFb+dStQjofrZOf/n25dULutqiY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxLAqN4BCR6QrI/URiFA8a/YoWc81gFN7pq/auAszSSDS2sNUWt
 KEVSKHidVWesdi0eA//6IjL7+n3t72S4nazepFx3psT0yhuAlPUhsCdKaBCuZ/OKpJ0=
X-Gm-Gg: AfdE7ckQ1gAzz2zh09zSc2ZfA45ULprWEo/HyUdPRp1pMK3ssF5RUUbNe2lkVs8/LBa
 Uo96pdBNOEesPwhD4EBB5laOfwo5dPR4k8ANClQSxnyZrikqdhaUVAC7ZFeC2S1BF9mFnjRWMEc
 n4VVhKcUdpGv/IzhIW0SRpLtbDw8qaZ68Zx8narnXVQYnMaxzLRXXkY6jqor3uLJhtgi6fqMEP2
 7S6NvqakjEo49OQzrBbJJu9hMyOnRotT99ZysVrx/uXBmbJKNyiDu6F9pIopPvaaF7DwIO+HQRy
 1H3wjy31jyobqwbtokLGSbuL8q1CUSJ7BweR2walq+mZ/9KrDk1NRIAT+AuYIez2vQ/KF9sY0wG
 bkQVSysEEFpAQ6/S6dEYC6YYjgo2gUVI7XPiZU0vn5Bk/tw2Z6bT7xBr06tN2
X-Received: by 2002:a05:622a:96:b0:51c:7b12:5ff5 with SMTP id
 d75a77b69052e-51c8b43fec2mr132124531cf.81.1783701869227; 
 Fri, 10 Jul 2026 09:44:29 -0700 (PDT)
Received: from ziepe.ca ([159.2.72.92]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ffd56c4b91sm45168766d6.19.2026.07.10.09.44.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 09:44:28 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
 (envelope-from <jgg@ziepe.ca>) id 1wiEKx-00000007Yxj-3wpY;
 Fri, 10 Jul 2026 13:44:27 -0300
Date: Fri, 10 Jul 2026 13:44:27 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Stanislav Kinsburskii <skinsburskii@gmail.com>
Cc: airlied@gmail.com, akhilesh@ee.iitb.ac.in, akpm@linux-foundation.org,
 corbet@lwn.net, dakr@kernel.org, david@kernel.org,
 decui@microsoft.com, haiyangz@microsoft.com, kees@kernel.org,
 kys@microsoft.com, leon@kernel.org, liam@infradead.org,
 lizhi.hou@amd.com, ljs@kernel.org, longli@microsoft.com,
 lyude@redhat.com, maarten.lankhorst@linux.intel.com,
 mamin506@gmail.com, mhocko@suse.com, mripard@kernel.org,
 nouveau@lists.freedesktop.org, ogabbay@kernel.org, oleg@redhat.com,
 rppt@kernel.org, shuah@kernel.org, simona@ffwll.ch,
 skhan@linuxfoundation.org, surenb@google.com, tzimmermann@suse.de,
 vbabka@kernel.org, wei.liu@kernel.org,
 dri-devel@lists.freedesktop.org, linux-mm@kvack.org,
 linux-doc@vger.kernel.org, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-rdma@vger.kernel.org
Subject: Re: [PATCH v7 8/8] drm/gpusvm: Use
 hmm_range_fault_unlocked_timeout() for range faults
Message-ID: <20260710164427.GW118978@ziepe.ca>
References: <178345345668.660027.2952911919681614557.stgit@skinsburskii>
 <178345366389.660027.12986386801605494596.stgit@skinsburskii>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <178345366389.660027.12986386801605494596.stgit@skinsburskii>
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

On Tue, Jul 07, 2026 at 12:47:43PM -0700, Stanislav Kinsburskii wrote:
> Several GPU SVM paths take mmap_read_lock() only to call hmm_range_fault(),
> then retry -EBUSY until HMM_RANGE_DEFAULT_TIMEOUT expires. Those paths use
> MMU interval notifiers whose mm matches the mm that was locked for the HMM
> fault.
> 
> Use hmm_range_fault_unlocked_timeout() for those faults and pass the
> remaining retry budget to HMM. The helper owns mmap_lock acquisition and
> refreshes range->notifier_seq internally for each retry, while GPU SVM
> keeps its existing driver-lock validation with mmu_interval_read_retry()
> after a successful fault.
> 
> Leave drm_gpusvm_check_pages() on hmm_range_fault() because that path is
> called with the mmap lock already held by its caller.
> 
> Signed-off-by: Stanislav Kinsburskii <skinsburskii@gmail.com>
> ---
>  drivers/gpu/drm/drm_gpusvm.c |   52 ++++++------------------------------------
>  1 file changed, 7 insertions(+), 45 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

> -	mmap_read_unlock(range->gpusvm->mm);
> +	err = hmm_range_fault_unlocked_timeout(&hmm_range,
> +				max_t(long, timeout - jiffies, 1));

Same remark about max_t

Jason
