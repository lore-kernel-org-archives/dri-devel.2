Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4021DC982E1
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 07:00:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 345E010E1E6;
	Mon, 21 Sep 2026 07:00:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=rsg.ci.i.u-tokyo.ac.jp header.i=@rsg.ci.i.u-tokyo.ac.jp header.b="BJ9UTxO7";
	dkim-atps=neutral
Received: from www3579.sakura.ne.jp (www3579.sakura.ne.jp [49.212.243.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D82810E083
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 11:27:35 +0000 (UTC)
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 68IBRSKC032121
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Fri, 18 Sep 2026 20:27:29 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=GKwtw9XaAg0KCgc5gwZGgqhmhkqEKy9SW8tYh8z2dSU=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1789730849; v=1;
 b=BJ9UTxO7gcJ4+1NQyuRiHNgiuMiuP2cK/63+qtaQcJnokO5QiUzExsscux3CCZhK
 5r0Z/C0SAsw69EumqeTWpATA3c5wpdXWYmEQPs0MpTuan1FO4FfG+A2fdwo5DaTy
 k0p48PaLphcB/8BlUbVlQYpbdwYxaU9h6G7a1LpeLAmxwqDqMmZEvOXnBOBgfpat
 REO/kmgCpLRnqUzvIbV4NvN9QKOgznOeqG7DuGpgc1t0htipn4BHOtwPKQiCto9k
 wyOaYeH7lXsQlWU/bTCZYV5PLbaEfueYUwaZXJECR0gER2kRejYp021aysqQHXx0
 HhKyGYHRExBg7fh1VPzOig==
Message-ID: <0e644466-8b4e-48bb-9322-e47c59c5c77c@rsg.ci.i.u-tokyo.ac.jp>
Date: Fri, 18 Sep 2026 20:27:28 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 1/4] drm/virtio-gpu: Add VIRTIO_GPU_CAPSET_ROCM
 capability
To: "Huang, Honglei" <honghuan@amd.com>, sashiko-reviews@lists.linux.dev
Cc: "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux.dev,
 Eugenio Perez <eperezma@redhat.com>, dri-devel@lists.freedesktop.org
References: <20260918095940.2253018-1-honghuan@amd.com>
 <20260918095940.2253018-2-honghuan@amd.com>
 <20260918100746.2BB741F000FF@smtp.kernel.org>
 <9fcb3203-63f4-4332-a47e-916774e11eb3@amd.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <9fcb3203-63f4-4332-a47e-916774e11eb3@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 21 Sep 2026 07:00:14 +0000
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

On 2026/09/18 19:13, Huang, Honglei wrote:
> 
> 
> This patch is for adding ROCm capset only, can be spited into another 
> thread if it is needed.
> 
> Regards,
> Honglei
> 
> On 9/18/2026 6:07 PM, sashiko-bot@kernel.org wrote:
>> Thank you for your contribution! Sashiko AI review found 2 potential 
>> issue(s) to consider:
>> - [Medium] virtio-gpu: premature UAPI exposure of unfinalized 
>> capability ID
>> - [Low] virtio-gpu: missing DRM UAPI alias for ROCM capability set
>> -- 
>>
>> commit a394228d77eeafc9f1dcc36150380f8561f1ee49
>> Author: Honglei Huang <honghuan@amd.com>
>>
>> drm/virtio-gpu: Add VIRTIO_GPU_CAPSET_ROCM capability
>>
>> This commit adds a new GPU capability set VIRTIO_GPU_CAPSET_ROCM with 
>> ID 8
>> to support ROCm compute workloads. The commit message notes that the
>> matching virtio-gpu specification change is currently in progress.
>>
>>> diff --git a/include/uapi/linux/virtio_gpu.h b/include/uapi/linux/ 
>>> virtio_gpu.h
>>> index 4f530d90058c7..3d4dfadc9d789 100644
>>> --- a/include/uapi/linux/virtio_gpu.h
>>> +++ b/include/uapi/linux/virtio_gpu.h
>>> @@ -321,6 +321,7 @@ struct virtio_gpu_cmd_submit {
>>>   #define VIRTIO_GPU_CAPSET_VENUS 4
>>>   #define VIRTIO_GPU_CAPSET_CROSS_DOMAIN 5
>>>   #define VIRTIO_GPU_CAPSET_DRM 6
>>> +#define VIRTIO_GPU_CAPSET_ROCM 8
>>
>> [Severity: Medium]
>> Is it safe to expose this speculative capability ID to userspace 
>> before the
>> virtio-gpu specification is finalized?
>>
>> The commit message states the specification change for ID 8 is in 
>> progress.
>> Because the Linux UAPI is frozen once released, exposing this ID now 
>> could
>> permanently commit the kernel to ID 8 for ROCm. If the OASIS virtio
>> technical committee assigns a different ID or rejects the proposal, would
>> this leave the Linux UAPI permanently incompatible with the standard?

It is actually somewhat common to introduce a capset before updating the 
virtio specification, as capsets remain opaque to both the spec and the 
kernel without strict interface stability enforcement (for example, 
VIRTIO_GPU_CAPSET_DRM is still not in the spec). However, we must at 
least wait until the virglrenderer developers agree to implement it.

An unfortunate complication is that gfxstream has already claimed 
capsets 7–9 prior to updating the spec or kernel headers:

https://github.com/magma-gpu/rutabaga_gfx/blob/v0.1.85/ffi/src/include/rutabaga_gfx_ffi.h#L41-L43

You could target capset 10 instead, but I advise coordinating with the 
VCL developers first to avoid further collisions.

Additionally, "[PATCH v8 2/4] drm/virtgpu api: add blob userptr 
resource" poses a more critical issue: it adds 
VIRTIO_GPU_F_BLOB_READONLY and VIRTIO_GPU_BLOB_FLAG_USE_READONLY, 
directly altering semantics explicitly defined in the spec. We should 
see at least a draft spec patch posted before moving forward, so this 
series should remain an RFC until then.

>>
>> [Severity: Low]
>> Also, should there be a corresponding DRM UAPI alias added for this 
>> capability
>> set?
>>
>> Previous capability sets have matching definitions in virtgpu_drm.h, 
>> such as
>> VIRTGPU_DRM_CAPSET_VENUS and VIRTGPU_DRM_CAPSET_DRM. Without adding a 
>> similar
>> VIRTGPU_DRM_CAPSET_ROCM alias, userspace DRM clients relying on 
>> virtgpu_drm.h
>> for the DRM_IOCTL_VIRTGPU_GET_CAPS ioctl will lack the necessary 
>> constant to
>> query ROCm capabilities natively.

As for Sashiko's suggestion regarding DRM UAPI aliases, while I am 
unsure why those aliases were introduced initially, adding one here 
makes sense for internal consistency.

Regards,
Akihiko Odaki

>>
>>>   /* VIRTIO_GPU_CMD_GET_CAPSET_INFO */
>>>   struct virtio_gpu_get_capset_info {
>>
> 

