Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE581CD13D3
	for <dri-devel@archiver.kernel.org>; Thu, 30 Apr 2026 22:39:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B7C910F4DA;
	Thu, 30 Apr 2026 22:39:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="ODBzq1YO";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0497310F4D3
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Apr 2026 22:39:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1777588767; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=LtqXv6h+ZOFxK6Z5uVrsicftOQk7MykGE0iu8om7kx9fYjrdDJ2Rgg0W3rk7lwSzPF6AhBAI/coYQAL9JI8eBV3Pe6xAVHwbs0SR0pGS/AVKc689xUYdN45YphBdNrrv0dKlgrh/Uy2IFG33E0KFQPFMPl0NQOxpOuPUNS5RUMY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1777588767;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=C2YKcrkoxAPitHnAjL/XnUNVD7X1hN2l0oTv97swHYw=; 
 b=lCeCw386JspCTgPMTrloFU0vGcnGZBG5ZN6vddLDGdvneMJCFeUse92orsXDrqXAjT8oc9YXCWs7V4SdM/B/M7Flst3Ji/kQzDnaTWvjiyj9sNgHZPu39a7LW1tbu6c0Sokh3TYEx+E9W8Bc001gglLuC/H19nQafdmVceuru4g=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1777588767; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=C2YKcrkoxAPitHnAjL/XnUNVD7X1hN2l0oTv97swHYw=;
 b=ODBzq1YOUUE46hD5vO4BaLl8oKuc5TU3cL79baTMvANXD92lHzphFWKs2x4ykHOK
 OOoR1I4Mo60EyUF70JYQ6FjuprYJbcebc8cnAcVPtnqhvueB84SDelNHDI8cGc6hYGl
 7eOABSQeMAHKGKBNV7eraYLgQFzXLpFwCqaWEfDU=
Received: by mx.zohomail.com with SMTPS id 1777588763939550.9505787797806;
 Thu, 30 Apr 2026 15:39:23 -0700 (PDT)
Message-ID: <f418038b-cd6d-415c-917a-9f9e33e7e217@collabora.com>
Date: Fri, 1 May 2026 01:39:20 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 0/3] Virtio-GPU S4 support
To: "Kim, Dongwon" <dongwon.kim@intel.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "airlied@redhat.com" <airlied@redhat.com>,
 "kraxel@redhat.com" <kraxel@redhat.com>
Cc: "nirmoyd@nvidia.com" <nirmoyd@nvidia.com>,
 "Kasireddy, Vivek" <vivek.kasireddy@intel.com>
References: <20260107182745.229481-1-dongwon.kim@intel.com>
 <87fd9bc3-4516-4380-8a67-1d2c2365524e@collabora.com>
 <PH0PR11MB51127C2ED7FB044A4B98B136FA75A@PH0PR11MB5112.namprd11.prod.outlook.com>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <PH0PR11MB51127C2ED7FB044A4B98B136FA75A@PH0PR11MB5112.namprd11.prod.outlook.com>
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

On 2/25/26 20:06, Kim, Dongwon wrote:
> Hi Dmitry,
> 
>> -----Original Message-----
>> From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
>> Sent: Wednesday, February 25, 2026 8:06 AM
>> To: Kim, Dongwon <dongwon.kim@intel.com>; dri-devel@lists.freedesktop.org;
>> airlied@redhat.com; kraxel@redhat.com
>> Cc: nirmoyd@nvidia.com; Kasireddy, Vivek <vivek.kasireddy@intel.com>
>> Subject: Re: [PATCH v7 0/3] Virtio-GPU S4 support
>>
>> On 1/7/26 21:27, dongwon.kim@intel.com wrote:
>>> From: Dongwon Kim <dongwon.kim@intel.com>
>>>
>>> This patch series implements functions for .freeze and .restore hooks
>>> for virtio-gpu driver as well as pm-notifier to handle object
>>> restoration in
>>> S4(hiberation) case.
>>>
>>> First patch adds `virtgpu_freeze` and `virtgpu_restore` functions.
>>> These functions handle the deletion of virtio queues before suspension
>>> and their recreation during the restoration process.
>>>
>>> Second patch implements a mechanism for restoring `virtio_gpu_object`
>> instances.
>>> This is necessary because the host (QEMU) deletes all associated
>>> resources during the virtio-gpu reset, which occurs as part of
>> hiberation/resume process.
>>>
>>> Third patch adds pm-notifier to the driver that handles resubmission
>>> of virtio-gpu objects to the QEMU once the guest resumes from hibenation.
>>>
>>> These changes ensure that the virtio-gpu driver can properly handle
>>> hibernation scenarios without resource loss.
>>>
>>> v2: 10ms sleep is added in virtgpu_freeze to avoid the situation
>>>     the driver is locked up during resumption.
>>>
>>> v3: Plain 10ms delay (v2) is replaced with wait calls which wait until
>>>     the virtio queue is empty.
>>>     (Dmitry Osipenko)
>>>
>>> v4: New version of patchset only covers S4 case because loss of resources in
>> S3
>>>     case can be avoided by skipping virtio-gpu-reset in QEMU
>> (hw/display/virtio-gpu.c).
>>>     To skip virtio-gpu-reset (soft-reset), virtio-gpu-pci device should be
>> attached to
>>>     PCIE bus AND a PCIE option, 'x-pcie-pm-no-soft-reset' should added and set
>> to 'true'.
>>>     (e.g. -device
>>> virtio-gpu-pci,bus=port,x-pcie-pm-no-soft-reset=true)
>>>
>>> v5: Remove virtio_gpu_object from the restore list before freeing the object
>>>     to prevent an use-after-free situation.
>>>     (Nirmoy Das)
>>>
>>>     Protect restore list operations with a spinlock
>>>     (Nirmoy Das)
>>>
>>>     Move restore list node into virtio_gpu_bo struct to reduce memory usage
>>>     (Dmitry Osipenko)
>>>
>>>     Remove unused header - drm_atomic_helper.h
>>>     (Dmitry Osipenko)
>>>
>>> v6: Include object backed by imported dmabuf
>>>     (Dmitry Osipenko)
>>>
>>>     Not storing virgl objects in the restore_list as virgl 3D objects are not
>>>     recoverable.
>>>     (Dmitry Osipenko)
>>>
>>>     Change the name 'list',a node in restore_list to 'restore_node'
>>>     (Nirmoy Das)
>>>
>>>     Use mutex instead of spinlock when updating restore_list
>>>     (Nirmoy Das)
>>>
>>>     Initialize restore_node when virtio_gpu_object is created - this is to
>>>     check if the node is in the list with 'list_empty' before removing it.
>>>
>>>     Restoring objects in the PM notifier is too late, as virtio-gpu
>>>     message communication begins in virtgpu_restore once virtqueues
>>>     are re-established. To address this, a 'hibernation' flag is set
>>>     during the PM_HIBERNATION_PREPARE phase in the notifier. This flag
>>>     is then used in virtgpu_restore to detect if the system is resuming
>>>     from S4, allowing objects to be recovered immediately after virtqueues
>>>     are reconfigured.
>>>
>>> v7: Add a helper, virtio_gpu_add_object_to_restore_list
>>>     (Dmitry Osipenko)
>>>
>>>     Unreference all objects before hibernation so they can be removed
>>>     on the host side, since they will be fully restored anyway. This
>>>     prevents the situation where host-side hibernation fails (leaving
>>>     all associated resources still alive) while the virtio-gpu driver
>>>     still attempts to restore those objects.
>>>     (Dmitry Osipenko)
>>>
>>> Dongwon Kim (3):
>>>   drm/virtio: Freeze and restore hooks to support suspend and resume
>>>   drm/virtio: Add support for saving and restoring virtio_gpu_objects
>>>   drm/virtio: Add PM notifier to restore objects after hibernation
>>>
>>>  drivers/gpu/drm/virtio/virtgpu_drv.c    | 74 +++++++++++++++++++++-
>>>  drivers/gpu/drm/virtio/virtgpu_drv.h    | 23 ++++++-
>>>  drivers/gpu/drm/virtio/virtgpu_kms.c    | 54 ++++++++++++++--
>>>  drivers/gpu/drm/virtio/virtgpu_object.c | 83
>>> ++++++++++++++++++++++++-  drivers/gpu/drm/virtio/virtgpu_prime.c  | 43
>> ++++++++++++-
>>>  drivers/gpu/drm/virtio/virtgpu_vq.c     | 13 +++-
>>>  drivers/gpu/drm/virtio/virtgpu_vram.c   |  4 +-
>>>  7 files changed, 280 insertions(+), 14 deletions(-)
>>>
>>
>> Hello Kim,
>>
>> Want let you know that I've seen the patches, but didn't have enough time to
>> review and test them. Will try to do it sooner. Will leave couple comments for
>> now.
>>
>> Meanwhile there is a kernel bot bug report.
> 
> Thanks for the comment. No problem. I will wait for your test results then create V8 based on
> your feedback including what you just left for individual patches (function/variable
> names..etc.)
> 
> I thought I got an error report for the previous version but I will double check.

Thanks for your patience and sending v8, will test it. There other
patches in my queue, hopefully it will get untangled sooner.

-- 
Best regards,
Dmitry
