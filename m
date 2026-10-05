Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17910CA5FFC
	for <dri-devel@archiver.kernel.org>; Tue,  6 Oct 2026 07:24:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2BA3D10E0DA;
	Tue,  6 Oct 2026 07:24:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EyHVC/RK";
	dkim-atps=neutral
Received: from mail-ej2-f43.google.com (mail-ej2-f43.google.com
 [74.125.228.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7493510EA1D
 for <dri-devel@lists.freedesktop.org>; Mon,  5 Oct 2026 13:20:50 +0000 (UTC)
Received: by mail-ej2-f43.google.com with SMTP id
 a640c23a62f3a-c2a4fbc5586so307255966b.2
 for <dri-devel@lists.freedesktop.org>; Mon, 05 Oct 2026 06:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791206449; x=1791811249; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=h5zNn+04D/ADxwDdeMfBIdi2B0cMu31zTvDOOv1nE7U=;
 b=EyHVC/RKFMRfguOqzSCPeI5hheug16MVhhUlgw9H0UVXQosest2Xu7RqF2/VR+zxFH
 U3wmdmsqUflH8O1r/DTTgU2Tnxu6ZXcPVln1HKER1lMZN6TVOHEx6H6mM6cFj8GcBTHj
 dRY8OMxn+E3vUkFRfNWcvjEnFfMY5eVOvbREydF1KV4eYu5UgbOK7CeqogRDhnWVz084
 HyG0QDY181Z7p59BkBY74ST3D1dhyVvVwNipeq6lEXVQ2k0nqeZNR5ZugA4+MZVXx2vg
 hhxvhulAV7TyBjN9/UjkHUlxHEo7FukaeLX50PcTl4TbxQsYjCPSml0ku6DzO8l5+Qzv
 ifJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791206449; x=1791811249;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=h5zNn+04D/ADxwDdeMfBIdi2B0cMu31zTvDOOv1nE7U=;
 b=kldhYSgoOdDqjTr+kajGOT297XFeRmj9YZAc7aV9NZq2Wr6p2cka/Lpj7VFt9pPa2Q
 A7hMARovQYtU0kQv/kFyu3410Ny/cjuTomFjIqbqk+FtgEUAYi+VPz97vXi1+fWCnW3F
 vo10vEb0CJ5bvb2YqGz7E5QYkj6ITvJ5CPhb6j2SB6+rmPu/iM6VrVec8xfvMJ4BQN/Q
 XGewoqZPe7U93xR6vLO6XlLuLQTzDeJJSXnmJs6F7kzUsTyWnXxY/iSkv8Cj1HHsQUby
 jueyEeeP+ilAdqdap96zcyjRdUQ2Oq+qWBU2tv7FeRs5iMIWiGMprwKVRgnyw7HrX25r
 roQg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzBtmHM5hE186iC/l6qEY95POTe6VMj19bLcuRz12Dv1asEYUEWDZgg05zwITbtlf0DJvMCXxVJ758=@lists.freedesktop.org
X-Gm-Message-State: AFuF++l9gjO7CDKYiu/+r6ptFBrTiP2unQqd/lWm2mOuazOoliJGDIpi
 PRnHKXzRsfl4B9VGtNgVnq5wHo1poImMEDWoaDaUtJ+D8jdc4xVcjIha
X-Gm-Gg: AYBFou0KGAyZwyA8CbpP4I76dupCsmaUBLCTClWM6BhregOlaxVi3teL1qSPk8i8f84
 3QVcHzOuxzu9cmrTR92yIrefQauwqZWmH8qquR27HUdAo/AkfO/zyptor6WZMgP4i7jXvmKxztM
 rYl7hHpa6bsSqFDafmyicvZMufq2R2IZl7Y3d7RJ/1T55VWZtOf5lW1E+f5ZBTxND6TU19TK/BG
 VkIcFYffu/3+wL7k2iNg1bGNUtrE/sV98MlEUav8gTVg0HlmFjHrCV1qyXzg6hqnOTDfAYaqk6/
 LF89aYKVAvB4ywsaatGQVxCcAQMtXaKduvYl9HNIq8SUAXhOHECztU5o0yoQswDNiMOz4iyls+/
 q5KRzDC1faN0EBpdmW7JS2G+ylPdJnGkvEbru/6UaAqNWYBNEBMAFWxF3oMh6Pn6axVmnmgP9oa
 +37rJhdjCl1KKZN/h8PHR2aK0IkjEzvaFvFUru6GB0WtzGfuUB/6Ot862tW6SYsvv5k8IRMFyCM
 9rHOgQmw5qXXQjY9If2AJ5Q2xTlZAu7KdAAnOalJOhHC9p2mYCaZmQpvDCeDwVwAJ5elrB3am9U
 G/0CKIMX30pCUhd+2WPE9/FwH1LglX9voMQ=
X-Received: by 2002:a17:907:9614:b0:c25:8eb7:f388 with SMTP id
 a640c23a62f3a-c2e4ad13957mr911322366b.17.1791206448599; 
 Mon, 05 Oct 2026 06:20:48 -0700 (PDT)
Received: from dev-dsk-fgriffo-1c-93421965.eu-west-1.amazon.com
 (54-240-197-234.amazon.com. [54.240.197.234])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c3156333a04sm79392466b.60.2026.10.05.06.20.46
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 05 Oct 2026 06:20:48 -0700 (PDT)
From: Fred Griffoul <griffoul@gmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Sean Christopherson <seanjc@google.com>, Marc Zyngier <maz@kernel.org>,
 Oliver Upton <oupton@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>
Cc: David Woodhouse <dwmw2@infradead.org>,
 Ackerley Tng <ackerleytng@google.com>, Joey Gouly <joey.gouly@arm.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 Zenghui Yu <yuzenghui@huawei.com>, Steffen Eiden <seiden@linux.ibm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H . Peter Anvin" <hpa@zytor.com>, Joerg Roedel <joro@8bytes.org>,
 Robin Murphy <robin.murphy@arm.com>, Alex Williamson <alex@shazbot.org>,
 Shuah Khan <shuah@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org, kvmarm@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, linux-kselftest@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [RFC PATCH 2/6] dma-buf: Add get_phys() to describe a physical run
Date: Mon,  5 Oct 2026 13:20:46 +0000
Message-ID: <20261005132046.30025-1-griffoul@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <a04f17cc-f59a-4240-81c8-29776eee3a2e@amd.com>
References: <a04f17cc-f59a-4240-81c8-29776eee3a2e@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 06 Oct 2026 07:24:11 +0000
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

On 10/5/26 Christian König wrote:
> Well filling page tables by the importer is an absolutely clear NO-GO
> for the DMA-buf design, we have gotten down that path already and it
> took us years to remove this functionality again.

Understood, thanks for the quick and clear answers on this patch and on
patch 3.

> The problem you are facing here is that dma_buf_mmap() doesn't work
> because you don't have a VMA.

Right: the memory has no struct page and is deliberately not mapped in
the host, so there is no VMA to hand to KVM.

I'll post a new version of this series. It drops get_phys(), the ranged
invalidation and the guest_memfd dma-buf import (patches 2-5), and it
does not touch drivers/dma-buf, as you suggested in the PAL discussion:

  https://lore.kernel.org/all/c413710b-4c28-4ed8-88ec-aeb8c4482011@amd.com/

KVM gets its frames through the KVM-private guest_memfd provider
interface from David's series. iommufd gets them through a private
interface with the exporter, as it already does for vfio-pci. The new
version adds a small registry in iommufd for that, which replaces the
symbol_get() of the sample in David's series. The dma-buf is then only
the handle and the existing revoke.

Thanks,
Fred
