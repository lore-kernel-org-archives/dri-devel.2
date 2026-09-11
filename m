Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B994C88E58
	for <dri-devel@archiver.kernel.org>; Fri, 11 Sep 2026 14:48:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BEAC410F63C;
	Fri, 11 Sep 2026 14:48:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="e8NBZ1f8";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9DCFE10F63C
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 14:48:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1789138062; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=POe0m7d4cWCiT03WhfoKBkO4K/pcxpMIErYSKCTMMkshbAkDvudwxGxz8zUkcIk8hNhzyNN72pJGlLLYe4PCQFiUadnowlSrI614yQI1j56endTUdom1LKx34LZjG6nCA2Rqpywm4Ex2mobtjtYiW6tvAOvlpnfg8THnHvrBmrY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1789138062;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=XDUuN6FRh6Lu+K5r5tPMrhat8mAWhPBxs1WD3laJcM0=; 
 b=UgkcqzI9FfSX4DvxnK4myK+KEMIlBfOEHZBC53k7rNoajxyTI5FWfvXEbJqhnLj4Z1VpFyWxPnWG6BqUgfjyG5/QBPLM5txnAA7/5V1h00tg85mWcpsXV5Itymx5ANuKFx0UNeIk+qDC1xc9vmyh6K3Ov2nQqVImIYNmSHc5isA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1789138062; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=XDUuN6FRh6Lu+K5r5tPMrhat8mAWhPBxs1WD3laJcM0=;
 b=e8NBZ1f8C8FWVnmvLu6MzHjI4dZZyCNAnOsz4/WI5jOmA8QzIUkfWtzxJFikBddj
 Bcu0VbjAO8bCKXoR313lxAohoOWn6goZ2aUf1oaWm7IVw3TqRE92OHOzK0MuQKTCjPt
 tCpp/rQDm9p3O4Fm7lw/o+wS5S0R91t4zJJ4NQOk=
Received: by mx.zohomail.com with SMTPS id 1789138060386322.0119231572652;
 Fri, 11 Sep 2026 07:47:40 -0700 (PDT)
Message-ID: <b624e1a8-e957-48bb-9ae3-93215d764e53@collabora.com>
Date: Fri, 11 Sep 2026 17:47:35 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/5] virtio-gpu: Add userptr support for compute
 workloads
To: Honglei Huang <honglei1.huang@amd.com>, David Airlie
 <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Simona Vetter <simona@ffwll.ch>, Ray.Huang@amd.com
Cc: Gurchetan Singh <gurchetansingh@chromium.org>,
 odaki@rsg.ci.i.u-tokyo.ac.jp, Chia-I Wu <olvaffe@gmail.com>,
 dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, Honglei Huang <honghuan@amd.com>
References: <20260115075851.173318-1-honglei1.huang@amd.com>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20260115075851.173318-1-honglei1.huang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
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

On 1/15/26 10:58, Honglei Huang wrote:
> From: Honglei Huang <honghuan@amd.com>
> 
> Hello,
> 
> This series adds virtio-gpu userptr support to enable ROCm native
> context for compute workloads. The userptr feature allows the host to
> directly access guest userspace memory without memcpy overhead, which is
> essential for GPU compute performance.
> 
> The userptr implementation provides buffer-based zero-copy memory access. 
> This approach pins guest userspace pages and exposes them to the host
> via scatter-gather tables, enabling efficient compute operations.
> 
> Key features:
> - Zero-copy memory access between guest userspace and host GPU
> - Read-only and read-write userptr support
> - Runtime feature detection via VIRTGPU_PARAM_RESOURCE_USERPTR
> - ROCm capset support for ROCm stack integration
> - Proper page lifecycle management with FOLL_LONGTERM pinning
> 
> Patches overview:
> 1. Add VIRTIO_GPU_CAPSET_ROCM capability for compute workloads
> 2. Add virtio-gpu API definitions for userptr blob resources
> 3. Extend DRM UAPI with comprehensive userptr support
> 4. Implement core userptr functionality with page management
> 5. Integrate userptr into blob resource creation and advertise to userspace
> 
> Performance: In popular compute benchmarks, this implementation achieves
> approximately 70% efficiency compared to bare metal OpenCL performance on
> AMD V2000 hardware, achieves 92% efficiency on AMD W7900 hardware.
> 
> Testing: Verified with ROCm stack and OpenCL applications in VIRTIO virtualized
> environments.
> - Full OPENCL CTS tests passed on ROCm 5.7.0 in V2000 platform.
> - Near 70% percentage of OPENCL CTS tests passed on ROCm 7.0 W7900 platform.
> - most HIP catch tests passed on ROCm 7.0 W7900 platform.
> - Some AI applications enabled on ROCm 7.0 W7900 platform.
> 
> V4 changes:
>     - Renamed VIRTIO_GPU_CAPSET_HSAKMT to VIRTIO_GPU_CAPSET_ROCM
>     - Remove userptr feature probing cause it can reuse the guest 
>       blob resource code path, reduce patch count from 6 to 5
>     - Updated corresponding commit messages
>     - Consolidated userptr feature detection in final patch
>     - Update corresponding cover letter content
> 
> V3 changes:
>     - Split into focused patches for easier review
>     - Removed complex interval tree userptr management 
>     - Simplified resource creation without deduplication
>     - Added VIRTGPU_PARAM_RESOURCE_USERPTR for feature detection
>     - Improved UAPI documentation and error handling
>     - Enhanced code quality with proper cleanup paths
>     - Removed MMU notifier dependencies for simplicity
>     - Fixed resource lifecycle management issues
> 
> V2: - Split add HSAKMT context and blob userptr resource to two patches.
>     - Remove MMU notifier related patches, cause use not moveable user space
>       memory with MMU notifier is not a good idea.
>     - Remove HSAKMT context check when create context, let all the context
>       support the userptr feature.
>     - Remove MMU notifier related content in cover letter.
>     - Add more comments  for patch 6 in cover letter.
> 
> Honglei Huang (5):
>   drm/virtio-gpu: Add VIRTIO_GPU_CAPSET_ROCM capability
>   virtio-gpu api: add blob userptr resource
>   drm/virtgpu api: add blob userptr resource
>   drm/virtio: implement userptr support for zero-copy memory access
>   drm/virtio: advertise base userptr feature to userspace
> 
>  drivers/gpu/drm/virtio/Makefile          |   3 +-
>  drivers/gpu/drm/virtio/virtgpu_drv.h     |  33 ++++
>  drivers/gpu/drm/virtio/virtgpu_ioctl.c   |   9 +-
>  drivers/gpu/drm/virtio/virtgpu_object.c  |   6 +
>  drivers/gpu/drm/virtio/virtgpu_userptr.c | 231 +++++++++++++++++++++++
>  include/uapi/drm/virtgpu_drm.h           |   9 +
>  include/uapi/linux/virtio_gpu.h          |   7 +
>  7 files changed, 295 insertions(+), 3 deletions(-)
>  create mode 100644 drivers/gpu/drm/virtio/virtgpu_userptr.c
> 

Hi, could you please send rebased patches?

-- 
Best regards,
Dmitry
