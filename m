Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9128FCD4F47
	for <dri-devel@archiver.kernel.org>; Sun, 17 May 2026 18:09:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A492E10E294;
	Sun, 17 May 2026 18:09:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="WVHH6+Nz";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0FA2910E294
 for <dri-devel@lists.freedesktop.org>; Sun, 17 May 2026 18:09:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1779041351; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=F4j+XoqUsZwV/4Qfl2cjZk8No9J5olSiVg7Vm89UKzhGLiNTUUMLs2qVfMc4tGWsHdEZSrXAVAMz+Cp0sEgUm9gD6ovw1DgNvHS0hHS8aDuQC9PdWmmcvrWqW0SxItr973kVYhfFiYlwKvD04gC4q3whREAFRuaKG5/UJQItxSE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1779041351;
 h=Content-Type:Content-Transfer-Encoding:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To:Cc;
 bh=1wY9f50YzZ39bYBHg3wuOVoqi8z8Qii7FkIArIE9uYk=; 
 b=L7MPLXp+szg0jpdS0i+kZqU9vgXMovFd6XRd3z/sjIssjLE6m1gasjF0LB6OkeLZ9nwYGspbKcVAh/F3gKM5/zIOC2sI4Nsl5MwHdKCifi2s49+5uQMnkFbV44dY238npgbfHRwyxBAT7XYGDb0Ol2BqppGDvGzX1AtHutBXka8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1779041351; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
 bh=1wY9f50YzZ39bYBHg3wuOVoqi8z8Qii7FkIArIE9uYk=;
 b=WVHH6+NzwCFpOaTTBYOypa3AGB4HE/s0w5HOS7UkL5d6vFsVFR51lbcy6W7o7CMZ
 hjizCdHH76msPdYx/kjKkteLijkb4i2qkQ7ARD31HLgaRk1OXNvuQy07Fy99RkEatGt
 MSOBd8qyvAroZ+zQg75fJJkZIkfVFtvYbTVBOEYc=
Received: by mx.zohomail.com with SMTPS id 1779041349653464.52307848321493;
 Sun, 17 May 2026 11:09:09 -0700 (PDT)
Message-ID: <10895864-b440-4ed9-b9d9-a6f63f1ba10b@collabora.com>
Date: Sun, 17 May 2026 21:09:07 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 0/3] Virtio-GPU S4 (hibernation) support
To: dongwon.kim@intel.com, dri-devel@lists.freedesktop.org,
 airlied@redhat.com, kraxel@redhat.com
References: <20260429204729.993669-1-dongwon.kim@intel.com>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20260429204729.993669-1-dongwon.kim@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

Hi,

29.04.2026 23:47, dongwon.kim@intel.com пишет:
> From: Dongwon Kim <dongwon.kim@intel.com>
> 
> This patch series implements the .freeze and .restore hooks for the virtio-gpu 
> driver, alongside a PM notifier to manage object restoration during S4 
> (hibernation) cycles.
> 
> The series is structured as follows:
> 
> 1. The first patch introduces `virtgpu_freeze` and `virtgpu_restore`. These
>    functions handle the teardown of virtio queues before suspension and their
>    subsequent recreation during the resume process.
> 
> 2. The second patch implements a tracking and restoration mechanism for
>    `virtio_gpu_object` instances. This is essential because the host (e.g., QEMU)
>    destroys all associated graphics resources during the virtio-gpu reset
>    triggered by the hibernation/resume cycle.
> 
> 3. The third patch adds a PM notifier to handle the resubmission of these
>    tracked virtio-gpu objects to the host once the guest restores its
>    virtqueues.
> 
> Together, these changes ensure that the virtio-gpu driver can survive 
> hibernation without resource loss or invalid resource errors.
> 
> v2: - Added 10ms sleep in virtgpu_freeze to prevent lockups during resumption.
> 
> v3: - Replaced the fixed 10ms delay with wait calls that trigger once the 
>       virtio queue is empty.
>       (Dmitry Osipenko)
> 
> v4: - Limited the scope to S4 (hibernation). S3 resource loss can be avoided 
>       via QEMU configurations (e.g., x-pcie-pm-no-soft-reset=true).
> 
> v5: - Implemented removal of objects from the restore list before freeing to 
>       prevent a use-after-free situation.
>       (Nirmoy Das)
> 
>     - Protected restore list operations with a spinlock.
>       (Nirmoy Das)
> 
>     - Moved the restore list node into the virtio_gpu_bo struct to optimize 
>       memory usage.
>       (Dmitry Osipenko)
> 
>     - Removed unused header: drm_atomic_helper.h.
>       (Dmitry Osipenko)
> 
> v6: - Added support for objects backed by imported dma-bufs.
>       (Dmitry Osipenko)
> 
>     - Excluded virgl 3D objects from the restore list as they are currently 
>       non-recoverable.
>       (Dmitry Osipenko)
> 
>     - Renamed the list node to 'restore_node'.
>       (Nirmoy Das)
> 
>     - Switched from spinlock to mutex for restore list updates.
>       (Nirmoy Das)
> 
>     - Initialized restore_node at creation to allow safe 'list_empty' checks.
> 
>     - Introduced a 'hibernation' flag in the PM notifier to trigger restoration 
>       at the correct stage in `virtgpu_restore`.
> 
> v7: - Added helper: virtio_gpu_add_object_to_restore_list.
>       (Dmitry Osipenko)
> 
>     - Implemented unreferencing of all host-side objects before hibernation 
>       to ensure a clean state upon resume.
>       (Dmitry Osipenko)
> 
> v8: - Introduced virtio_gpu_remove_from_restore_list helper and ensured it is 
>       called across all object destruction paths (General, Prime, and VRAM) 
>       to prevent use-after-free.
>       (Dmitry Osipenko)
> 
>     - Relocated restore list removal logic from the final cleanup stage to 
>       the initial free stage for improved synchronization.
>       (Dmitry Osipenko)
> 
>     - Added missing drm_print.h header.
> 
> Dongwon Kim (3):
>   drm/virtio: Freeze and restore hooks to support suspend and resume
>   drm/virtio: Add support for saving and restoring virtio_gpu_objects
>   drm/virtio: Add PM notifier to restore objects after hibernation
> 
>  drivers/gpu/drm/virtio/virtgpu_drv.c    | 74 ++++++++++++++++++++-
>  drivers/gpu/drm/virtio/virtgpu_drv.h    | 24 ++++++-
>  drivers/gpu/drm/virtio/virtgpu_kms.c    | 54 +++++++++++++--
>  drivers/gpu/drm/virtio/virtgpu_object.c | 88 ++++++++++++++++++++++++-
>  drivers/gpu/drm/virtio/virtgpu_prime.c  | 45 ++++++++++++-
>  drivers/gpu/drm/virtio/virtgpu_vq.c     | 13 +++-
>  drivers/gpu/drm/virtio/virtgpu_vram.c   |  5 +-
>  7 files changed, 289 insertions(+), 14 deletions(-)
> 

v8 works well, left couple minor comments

-- 
Best regards,
Dmitry
