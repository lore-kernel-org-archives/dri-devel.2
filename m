Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BE03C98321
	for <dri-devel@archiver.kernel.org>; Fri, 25 Sep 2026 12:09:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5184A10E573;
	Fri, 25 Sep 2026 12:09:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="C78wY15I";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 826EE10E573
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 12:09:07 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8F38F60136;
 Fri, 25 Sep 2026 12:09:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8E511F00893;
 Fri, 25 Sep 2026 12:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790338146;
 bh=bpOatN8c0vzQ5XGVXFfSv8DKVf4rivauZnBt896FgHg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=C78wY15IWuSHyWzdqDDT7eq8MGBjMuC2MgBPRHiH1/Cib4Q2ycCR9Y6RbhvsAGU50
 q5tZw8/2wiDyQ3/+eWXed91+VVQsjjk8pieuow7Tol4MtXB0C2GYZuWaxYcTejPf/r
 BgpSuD1MCToqahOHEpPB2mqf/KtvibTXXAPcpePnJrDb73DGkMJxdLoV52jj7nSWco
 YiD0bljhRjRiAFGWJU3FETf2MnA1dAjxRQ/hrjNoKcaNRvnaO9s/0HeBAV7cylkb4U
 deUO03vah9aNSeDOHYNoFLZfuelQNQ8/QG1a2cUCs4WI2++L8iC4HqnbZfKARFrsd7
 Pcv4odfkCHIiQ==
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailfauth.ams.internal (Postfix) with ESMTP id F0D01198003A;
 Fri, 25 Sep 2026 08:08:52 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-03.internal (MEProxy); Fri, 25 Sep 2026 08:09:02 -0400
X-ME-Sender: <xms:VGS2apVl0oCJHXSAF-WnG03V0OTkE3GA3JKk6_2wku0RZ0iOk6I8VA>
 <xme:VGS2aiNFpi9BnkhFuuvFuFD70z2eBlFObIvPb29IzL5mI2ZX4ynwOvzRE_LNUXFwx
 MxB6eWOboCuVpa1CHShE3eBEdlpVGjuVpHowmad4m6Ezn7y_bAq>
X-ME-Received: <xmr:VGS2aqOosTEEs-ZdT05pxKviNpAWr3_xzRLG8_wFMp7Vw5A6xBNjESi0LMg>
X-ME-Proxy-Cause: dmFkZTEA00vB4wCEuGFPU26dSeuaRUC5A4v8eR3RjG3bBqa5h9xJ9DkJKF4RfcLFM9n52q
 3k8DUPXRt4S1MUQEQlgs/wFXZV95oQo4U601e3eSYJKZG4Nhmud24uk7molK+3EfFBEyfp
 uDB+bzuPtnSdm3cfhWN7C/cKeLr/l2x069NPMBtTxphXRLuvs4rl/Oop2SUxPOEiACBaC0
 gVKF5BVz0FD5pmDrDLCObajhGOWXVLPB4W5+pGabl+YCuxbxl1db9bA3z/zmlyf/1Y3+2L
 bVts6vygIEw+WpL0zBkMy806BQB0UOjN5unt97CMkqUmRwIhB3ZHFNBhyJmHTKmaY59xgy
 PaoQcuDGforIp2yh/OBDcAuLeHTf4NVgu/Q3MiIOv2TZopVH0lk4R8KuKyPCu2sh571uG9
 sQPWLWpLg+PoxuyoKvDnj3hE9HeDAhnW3hojgqd3K3wL+y5rD/qo4gklbsa8cpwL188kU/
 PkrFg7Z10iDPdvydF0UxXu1cXW3SDAD7DkoSjDdZk52r6lJ4VuFRP8XOiCC01t/9khS7+8
 80d3XVP2yWba/CGFqlEv9Y9vYYaHPUtop786W0VSRxh4hYXHm6ZkBsk1pUW3rlfEVHeLs+
 E+BuIgoOa3tDknUGmMSn2+zWK6DrKkUYj1McN22x/IP5Ssc3bWGg5eEzG1dQ
X-ME-Proxy: <xmx:VGS2aoYZ7nFUadQ6kpGq7uDV0Tu20PSpPBisEuB6MM_0W2vrpxJVUQ>
 <xmx:VGS2atoj4JRTVSnU8vzq8ZHzfJromoy1OYGmojnz8W7_me2t_SvIuA>
 <xmx:VGS2ak9LMv9u5n_IwlQGG91twmRAsL4cPlt48wRftdAIxr4bG3jPgA>
 <xmx:VGS2alVS_NfEyFQwF6El4FGRt3qemk-R8MfkGXNZNCHv-aPFOPXyxw>
 <xmx:VGS2at8o0pQeT8R73VmmXOBI_CqD_RbB5258qJ3tDaj-yJiuehlpH8fX>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 25 Sep 2026 08:08:51 -0400 (EDT)
Date: Fri, 25 Sep 2026 13:08:50 +0100
From: Kiryl Shutsemau <kas@kernel.org>
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
Cc: linux-coco@lists.linux.dev, kvmarm@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev, 	Andrew Morton <akpm@linux-foundation.org>,
 Baoquan He <baoquan.he@linux.dev>, 	Mike Rapoport <rppt@kernel.org>,
 Pasha Tatashin <pasha.tatashin@soleen.com>,
 Pratyush Yadav <pratyush@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Joerg Roedel <joro@8bytes.org>,
 Marc Zyngier <maz@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>,
 Robin Murphy <robin.murphy@arm.com>, Steven Price <steven.price@arm.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 Thomas Gleixner <tglx@kernel.org>, Will Deacon <will@kernel.org>,
 Russell King <linux@armlinux.org.uk>,
 Benjamin Gaignard <benjamin.gaignard@collabora.com>,
 Brian Starkey <Brian.Starkey@arm.com>, John Stultz <jstultz@google.com>,
 Mark Rutland <mark.rutland@arm.com>, Radu Rendec <radu@rendec.net>,
 "T.J. Mercier" <tjmercier@google.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <chleroy@kernel.org>,
 Ritesh Harjani <ritesh.list@gmail.com>,
 Shrikanth Hegde <sshegde@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, 	Vasily Gorbik <gor@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H . Peter Anvin" <hpa@zytor.com>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 "K . Y . Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, 	Long Li <longli@microsoft.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Vitaly Kuznetsov <vkuznets@redhat.com>, Andy Lutomirski <luto@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, 	linux-media@vger.kernel.org,
 linux-mm@kvack.org
Subject: Re: [RFC PATCH v8 02/14] mm: Zero memory during shared memory
 transitions
Message-ID: <arZkEugXwCtKHH64@thinkstation>
References: <20260924100529.1398790-1-aneesh.kumar@kernel.org>
 <20260924100529.1398790-3-aneesh.kumar@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260924100529.1398790-3-aneesh.kumar@kernel.org>
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

On Thu, Sep 24, 2026 at 03:35:17PM +0530, Aneesh Kumar K.V (Arm) wrote:
> diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
> index f904a636d449..1f1f39082391 100644
> --- a/arch/x86/coco/tdx/tdx.c
> +++ b/arch/x86/coco/tdx/tdx.c
> @@ -978,6 +978,9 @@ static bool tdx_enc_status_changed(unsigned long vaddr, int numpages, bool enc)
>  static int tdx_enc_status_change_prepare(unsigned long vaddr, int numpages,
>  					 bool enc)
>  {
> +	if (!enc)
> +		memset((void *)vaddr, 0, (size_t)numpages << PAGE_SHIFT);
> +
>  	/*
>  	 * Only handle shared->private conversion here.
>  	 * See the comment in tdx_early_init().

This doesn't make sense to me.

On TDX the memset zeroes a page that is about to be dropped.
MapGPA(shared) makes the VMM back the GPA with different memory, and
what the guest reads afterwards through the shared mapping is whatever
the host has there.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
