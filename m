Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6BEDC5DF81
	for <dri-devel@archiver.kernel.org>; Tue, 18 Aug 2026 19:13:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 26F3310E9C6;
	Tue, 18 Aug 2026 19:13:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="NAlS4YWw";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A9D2310E9C6
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 19:13:46 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 65104416B7;
 Tue, 18 Aug 2026 19:13:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58E6E1F000E9;
 Tue, 18 Aug 2026 19:13:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787080426;
 bh=pXcr84aXo4kr8My6Q2F1QdEnSfWywea9g/Or9K6khCg=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=NAlS4YWwF+E+SqHVETCJNOdKZzHrPgdXlxeuiLb6szxKpPwREn93pw09c7+sP8X99
 EipeoIeOhwLr7ng1n3qZ3OVZbM5teWbbvpg+/Nh68y4mtD4UNPolEKmxvkODY8oj9K
 LQ2sGpIAI7OkRnI5l91pUf7bTHGwyEvJq0w24leoU4vDcMAh2vBYt0ho763WcN1yoK
 Q+wHaRB66IVDXvx4cs0sG8kAtNrnYxFOONapcavIr2b06kGjYnpE1va+bRDhTJTUqT
 +/0QDx9xjdgwEiy3/dbDgOu/zETRlenlU9egNcv1CtefGCQ8ugfjsRwOY14MWAJ/fN
 X6Wng/pHsOqsA==
Message-ID: <3322b42b-3755-45ec-ad55-345125f0d488@kernel.org>
Date: Tue, 18 Aug 2026 21:13:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/15] accel/qda: Qualcomm DSP Accelerator driver
To: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>,
 Oded Gabbay <ogabbay@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap
 <rdunlap@infradead.org>, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Bharath Kumar <quic_bkumar@quicinc.com>,
 Chenna Kesava Raju <quic_chennak@quicinc.com>,
 srinivas.kandagatla@oss.qualcomm.com, dmitry.baryshkov@oss.qualcomm.com,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-doc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 llvm@lists.linux.dev, iommu@lists.linux.dev, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org
References: <20260817-qda-v2-v2-0-69a02e9090d4@oss.qualcomm.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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
In-Reply-To: <20260817-qda-v2-v2-0-69a02e9090d4@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
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

On 17/08/2026 06:47, Ekansh Gupta wrote:
> This patch series introduces the Qualcomm DSP Accelerator (QDA) driver,
> a DRM-based accelerator driver for Qualcomm DSPs. The driver provides a
> standardized interface for offloading computational tasks to DSPs found
> on Qualcomm SoCs, supporting all DSP domains.
> 
> The QDA driver implements the FastRPC protocol over the DRM accel
> subsystem. It uses the same device-tree node structure as the existing
> fastrpc driver in drivers/misc/. The approach for binding the QDA driver
> to device-tree nodes while coexisting with the fastrpc driver is an open
> item described below.

No. Grow/replace/improve existing driver instead of coming with a duplicate.

That's a standard upstream requirement, basically given on every
upstreaming guide.

Please watch old talk from Greg - "I Don’t Want Your Code!".

> 
> v1: https://lore.kernel.org/all/20260519-qda-series-v1-0-b2d984c297f8@oss.qualcomm.com/
> RFC: https://lore.kernel.org/dri-devel/20260224-qda-firstpost-v1-0-fe46a9c1a046@oss.qualcomm.com/T/
> 
> Changes since v1
> ================
> 
> The v1 review raised two architectural objections and one correctness
> issue; all three are resolved in v2:
> 
> * Christian König (dma-buf maintainer) pointed out that the imported-
>   buffer path silently assumed the IOMMU maps every buffer as a single
>   contiguous range, which is not guaranteed. v2 walks the scatterlist
>   and cleanly rejects non-contiguous imports; contiguous imports (e.g.
>   CMA DMA-buf heap) are accepted. (patch 11)
> 
> * Dmitry Baryshkov objected to three different buffer-passing formats
>   in the invoke IOCTL (DMA-BUF fd, direct/inline, DMA handle). v2
>   passes only GEM handles; userspace imports any fd to a GEM handle
>   with DRM_IOCTL_PRIME_FD_TO_HANDLE before invoking. Packing and
>   overlap handling are left to userspace. (patch 12)
> 
> * The memory manager (patch 07) used a fixed 16-entry array without
>   justification and leaked the device descriptor on teardown. v2
>   allocates the array from the DT context-bank count (as Dmitry
>   suggested) and frees it correctly.
> 
> User-space staging branch
> =========================
> https://github.com/qualcomm/fastrpc/tree/accel/staging
> 
> Key Features
> ============
> 
> * Standard DRM accelerator interface via /dev/accel/accelN
> * GEM-based buffer management with DMA-BUF import (PRIME)
> * IOMMU-based memory isolation using per-process context banks
> * FastRPC protocol implementation for DSP communication
> * RPMsg transport layer for reliable message passing
> * Support for all DSP domains (ADSP, CDSP, SDSP, GDSP)
> * DRM IOCTL interface for DSP session management, buffer allocation,
>   and remote procedure invocation
> 
> Architecture
> ============
> 
> 1. DRM Accelerator Framework Integration
>    The driver registers as a DRM accel device, exposing a standard
>    /dev/accel/accelN character device node. This provides established
>    DRM infrastructure for device management, file operations, and
>    IOCTL dispatch.
> 
> 2. Memory Management
>    Buffers are managed as GEM objects with PRIME support for DMA-BUF
>    import. This enables buffer sharing with other DRM drivers (GPU,
>    camera, video) using standard kernel mechanisms. Only contiguous
>    imports are accepted; the driver verifies contiguity at import time
>    rather than assuming it.
> 
> 3. IOMMU Context Bank Management
>    IOMMU context banks (CBs) are represented as proper struct device
>    instances on a custom virtual bus (qda-compute-cb). Each CB device
>    is registered with the IOMMU subsystem and receives its own IOMMU
>    domain, enabling per-session address space isolation. The custom
>    bus was introduced because IOMMU context banks are synthetic
>    constructs — not real platform devices — and to ensure CB device
>    lifetime is strictly subordinate to the parent QDA device.
>    See also: https://lore.kernel.org/all/245d602f-3037-4ae3-9af9-d98f37258aae@oss.qualcomm.com/
> 
> 4. Memory Manager Architecture
>    The memory manager maintains a registry of IOMMU devices in an
>    array sized to the number of context banks described in the device
>    tree, and coordinates per-process device assignment with reference-
>    counted lifetime management. The DMA-coherent backend allocates
>    buffers with SID-prefixed DMA addresses for DSP firmware
>    compatibility.
> 
> 5. Transport Layer
>    RPMsg communication is handled in a dedicated transport layer
>    (qda_rpmsg.c), separate from the core DRM driver logic.
> 
> 6. Code Organization
>    The driver is organized across multiple files (~4800 lines total):
>    * qda_drv.c:            Core driver and DRM integration
>    * qda_rpmsg.c:          RPMsg transport layer
>    * qda_cb.c:             Context bank device management
>    * qda_compute_bus.c:    Custom virtual bus for CB devices
>    * qda_gem.c:            GEM object management
>    * qda_prime.c:          DMA-BUF import (PRIME)
>    * qda_memory_manager.c: IOMMU device registry and allocation
>    * qda_memory_dma.c:     DMA-coherent allocation backend
>    * qda_fastrpc.c:        FastRPC protocol implementation
>    * qda_ioctl.c:          IOCTL dispatch
> 
> 7. UAPI Design
>    The driver exposes DRM-style IOCTLs defined in
>    include/uapi/drm/qda_accel.h, following DRM UAPI conventions
>    (__u32/__u64 types, C++ guard, GPL-2.0-only WITH Linux-syscall-note).
>    Buffer arguments are identified by GEM handles; the driver never
>    accepts DMA-BUF fds directly in any IOCTL.
> 
> Patch Series Organization
> ==========================
> 
> Patch 01:      MAINTAINERS entry
> Patch 02:      Driver documentation (Documentation/accel/qda/)
> Patches 03-04: Core driver skeleton and compute bus
> Patch 05:      iommu: Register qda-compute-cb bus with IOMMU subsystem
> Patches 06-07: CB device enumeration and memory manager
> Patch 08:      QUERY IOCTL and UAPI header
> Patches 09-11: GEM buffer management and PRIME import
> Patches 12-15: FastRPC protocol (invoke, session create/release,
>                map/unmap)
> 
> Open Items
> ===========
> 
> 1. Device-Tree Compatible String
>    The QDA driver uses the same device-tree node structure and
>    properties as the existing fastrpc driver in drivers/misc/. A
>    mechanism is needed to allow the QDA driver to bind to its device
>    node independently of the fastrpc driver.
> 
>    The intended coexistence model is: platforms that require the
>    complete fastrpc feature set continue to use "qcom,fastrpc"; new
>    platforms where QDA's feature set is sufficient use a QDA-specific
>    compatible string. New feature development is directed toward QDA.
> 
>    The options under consideration are:
> 
>    a) Add a new "qcom,qda" compatible string to the existing
>       qcom,fastrpc.yaml binding, since the DT node structure and
>       properties are identical.
No

> 
>    b) Introduce a separate qcom,qda.yaml binding that references or
>       inherits the fastrpc binding properties.

No

> 
>    Seeking guidance from DT binding maintainers on the preferred
>    approach.

Grow existing driver. You do not get new driver, you do not get new
bindings.


Best regards,
Krzysztof
