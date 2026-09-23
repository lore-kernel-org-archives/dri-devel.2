Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BAD9C98304
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 15:21:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B47D310E105;
	Wed, 23 Sep 2026 15:21:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.b="GhbfPQyR";
	dkim-atps=neutral
Received: from mail-vs2-f12.google.com (mail-vs2-f12.google.com
 [74.125.227.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B4A5D10E105
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 15:21:26 +0000 (UTC)
Received: by mail-vs2-f12.google.com with SMTP id
 71dfb90a1353d-5c67e5292fdso442460e0c.3
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 08:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ziepe.ca; s=google; t=1790176885; x=1790781685; darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=SIwOLjI09a3UXj303jplkjBLREygxuyiG19PHUNbQ2o=;
 b=GhbfPQyRV5s1z3mviWxI7ZnC5jpl9TMj4DCqSA6C6eaN2Hqy1T9IPHD4+38QiDPz10
 O9myTvI8jO7KtotKVG6WL5gXdS/V6Z74gLKjQD64iQbmdl2DrmY+pCG+sOUlOHoxIJlC
 xK5bKqhjiqQ9UWonm6vqzgmBLJ5p943U5rba4QU+g9//wP6ZsViISxkEHof75F+TbBHM
 7tFMl7V73it2Jt4dWbynG4nneLzGtBz3MrxtP0Hsbv9I/2Jj6dzic9NiFaXkDOiLdEZW
 XUfGLaAK4+5ra3EDFGSiDqN0cZ/i0Sd35aVFufGj1W1fNmxVri03rzFFhobICmPRCsOk
 U9Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790176885; x=1790781685;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=SIwOLjI09a3UXj303jplkjBLREygxuyiG19PHUNbQ2o=;
 b=QC91IUx9+nLqKdGeHFCEbWO5aRTClp61OupEQL0dyFSKVs+ZGIwFLZjfyOCpHrZtxL
 KjAkTv6/09324Kqfpy73PCNodvft3uylAxhZSe5ArZaNlpxQEOisym7ZVIzpDgIJ5SjE
 vdqWmaf8I1BBg0pFZU4iL6C4PuIeLdoHTf69XAuIsLwf9QFOp/Nl0MXYALHzJ0wvp6Ms
 +PT7V8mYU/HBhHhUWdBhD6e92/pM/4f2/SS8dtBvMv4yKhY5upmMWN4gvjXxsmLrt5xB
 QbvJxaSmMLsWp5M8wFEyepfwIUOVPOKbpO0mlG7qmTDDJ8/PGwpYPbGWcHW85XAfd+6V
 JPhg==
X-Forwarded-Encrypted: i=1;
 AKwUvBz/sCvnOPouSHhPr5srgn3019340ER4MriPcL4xjW4EwkdSxSre0xc7JN9KxmrFuuAa7taI11vf7ew=@lists.freedesktop.org
X-Gm-Message-State: AFuF++ky1XoYFbJgJUBBouuOIMFFatvA/qHyp7eP1DwikmJS0KrcKch+
 L7wezhYNBaGfoAGfpNH7DqrxukWM0NJykM3EO+lI5m5G942/yofwnsLSGOqpEnpdT9Q=
X-Gm-Gg: AYBFou0u0aU8jj8xUy3/gTexP0S32m9tYOcThWQqb9fNI/urvKaD1PX+llRmD8stP1W
 bgamqjF5jSFAJeZIcOw8965buQuDiyxBnalYxlyDhmRddbRy0ETjKSJHDgLc8S3R4adXHE9l0Am
 JDxxF3WfvuPnZN5KCjv2fuOEs+jf/mN+MVCmLbk1pnMYS3rwBvP8ReJHw2IY1VkwUyh7+DwegcM
 /sjW+6+oMAIqvKIX876KSdgSx05w5MX4SJ/3bbhCNIgciLW/0qAq17n4yAghlNCfqLE8hgLfm6R
 dA65E7X9rMR2GHoJxpcL+Qn4ScIAtSfgrn56VDPuERAIP4qBLAghTB+eMvweMPbkMp/D51+T7J5
 e6hM+FJoTxLDqUcfuekgLUVqr9Eafe+Opm971KgcTqJpLBk4EgscAsqEQL5YXAtD/Oyk/XPBvO1
 K1BFTlobDXSmSyL6i1Q6cmvD+uKcOsnJss4u3ilyO0gqp7
X-Received: by 2002:a05:6122:4896:b0:5c9:a60d:22cc with SMTP id
 71dfb90a1353d-5c9f16b9729mr3999503e0c.21.1790176885467; 
 Wed, 23 Sep 2026 08:21:25 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93c277636e4sm181224485a.41.2026.09.23.08.21.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 08:21:25 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
 (envelope-from <jgg@ziepe.ca>) id 1x9Omi-0000000DrJM-1RIj;
 Wed, 23 Sep 2026 12:21:24 -0300
Date: Wed, 23 Sep 2026 12:21:24 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, linux-coco@lists.linux.dev,
 kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
 Andrew Morton <akpm@linux-foundation.org>, christian.koenig@amd.com,
 Joerg Roedel <joro@8bytes.org>, Marc Zyngier <maz@kernel.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Robin Murphy <robin.murphy@arm.com>, Steven Price <steven.price@arm.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 Thomas Gleixner <tglx@kernel.org>, Will Deacon <will@kernel.org>,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 linux-media@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC PATCH v7 02/13] mm: Add an allocator for CoCo shared memory
Message-ID: <20260923152124.GG1540250@ziepe.ca>
References: <20260921144847.501151-1-aneesh.kumar@kernel.org>
 <20260921144847.501151-3-aneesh.kumar@kernel.org>
 <arKsFofudnTYpXj1@arm.com> <yq5aik3w344o.fsf@kernel.org>
 <arOfD6syXOgQhZYA@arm.com> <yq5a5wzw2ree.fsf@kernel.org>
 <arOspFxWZ1DjgcAr@arm.com> <20260923130611.GF1540250@ziepe.ca>
 <yq5atsng10b2.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq5atsng10b2.fsf@kernel.org>
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

On Wed, Sep 23, 2026 at 08:28:57PM +0530, Aneesh Kumar K.V wrote:

> I'm also considering requiring the address passed to cc_make_shared() to
> be in the linear map. This is currently required by both TDX and CCA,
> while AMD SNP appears to support vmalloc addresses. The only user of
> that vmalloc support is Hyper-V VMBus GPADL setup
> (vmbus_establish_gpadl()). How should the generic CoCo shared-memory
> allocator handle this?

vmbus_establish_gpadl() is the the same wrong abstraction as the arch
code. Get rid of it and use vmbus_establish_gpadl_caller_decrypted():

		pdata->recv_buf = vzalloc(RECV_BUFFER_SIZE);
		if (!pdata->recv_buf) {
			ret = -ENOMEM;
			goto fail_free_ring;
		}

		ret = vmbus_establish_gpadl(channel, pdata->recv_buf,
					    RECV_BUFFER_SIZE, &pdata->recv_gpadl);


So you made an allocator that returns folios, now you just need to
use that allocator to implement a kvzalloc wrapper. ARM can call vmap
on decrypted memory with pgprot_decrypted(), right?

Or maybe this can use vmbus_alloc_buffer(), it already does it.

Jason
