Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5B48CD4F4A
	for <dri-devel@archiver.kernel.org>; Sun, 17 May 2026 18:01:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F18FE10E290;
	Sun, 17 May 2026 18:01:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="Ry0nYh++";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3705210E290
 for <dri-devel@lists.freedesktop.org>; Sun, 17 May 2026 18:01:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1779040905; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=OsaOiVSZ6VyWXz6L1MTN2vXJn6sCAlus+x1A7J9VoPnvDGpw5j9gW/Mn9lrNycDr5WfGdoSgHFbSGEAeA+Cr4RdynJgYJqa/5DVvfUSrJj+xFAzjLyDbfuco7ERJdWcqwRiomF5SNWjHxEK+gChkX0U6GInRM1dYs03DOH9qvc4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1779040905;
 h=Content-Type:Content-Transfer-Encoding:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To:Cc;
 bh=urJYc+mF2gumcIthWJvFROCqZ9AHz74N2Cx57n3nPIg=; 
 b=RDTrsBpG5Af8Dg1VVdHoFEVHujZ1LtoNsFZkHmEJtfO7714jjyzjbtAutqtZzyEQdXwu07TxVawt+EBLfT6wm7R+ZErjXOHcqGmiw0uKAHvOKrVJ6HjBtNdVtGambs7EJjO45rpTc7Np3mczyg1q1QPA2ZHyts1J0eHmkl48NqQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1779040904; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
 bh=urJYc+mF2gumcIthWJvFROCqZ9AHz74N2Cx57n3nPIg=;
 b=Ry0nYh++QNI+wCrPNSyZ6AoznhNbsaZDAQ7cGSxmaLuechnEHTCjEY9c2m7iX2lV
 3Vj+ktg9zOFhuB4sRlRNK0H77Wh1StItUmo7Wy2RTTp+xIzpYSLqS7ejp3uxecQP4Lt
 eg2E4iOxwpkrupQyQL2SQu3gxZk3lDD6AF69uLWY=
Received: by mx.zohomail.com with SMTPS id 1779040903816462.6349930490022;
 Sun, 17 May 2026 11:01:43 -0700 (PDT)
Message-ID: <857ac110-a9b0-4b9e-b42b-94b9665bc31b@collabora.com>
Date: Sun, 17 May 2026 21:01:41 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 2/3] drm/virtio: Add support for saving and restoring
 virtio_gpu_objects
To: dongwon.kim@intel.com, dri-devel@lists.freedesktop.org,
 airlied@redhat.com, kraxel@redhat.com
References: <20260429204729.993669-1-dongwon.kim@intel.com>
 <20260429204729.993669-3-dongwon.kim@intel.com>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20260429204729.993669-3-dongwon.kim@intel.com>
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

29.04.2026 23:47, dongwon.kim@intel.com пишет:
> From: Dongwon Kim <dongwon.kim@intel.com>
> 
> When the host KVM/QEMU resumes from hibernation, it loses all graphics
> resources previously submitted by the guest OS, as the QEMU process is
> terminated during the suspend-resume cycle. This leads to invalid resource
> errors when the guest OS attempts to interact with the host using those
> resources after resumption.
> 
> To resolve this, the virtio-gpu driver now tracks all active virtio_gpu_objects
> and provides a mechanism to restore them by re-submitting the objects to QEMU
> when needed (e.g., during resume from hibernation).
> 
> v2: - Attach backing is done if bo->attached was set before
> 
> v3: - Restoration is no longer triggered via .restore; instead, it is handled
>       by a PM notifier only during hibernation.
> 
> v4: - Remove virtio_gpu_object from the restore list before freeing the object
>       to prevent a use-after-free situation.
>       (Nirmoy Das)
> 
>     - Protect restore list operations with a spinlock
>       (Nirmoy Das)
> 
>     - Initialize ret with 0 in virtio_gpu_object_restore_all
>       (Nirmoy Das)
> 
>     - Move restore list node into virtio_gpu_bo struct to reduce memory usage
>       (Dmitry Osipenko)
> 
> v5: - Include object backed by imported dmabuf
>       (Dmitry Osipenko)
> 
>     - Not storing virgl objects in the restore_list as virgl 3D objects are not
>       recoverable.
>       (Dmitry Osipenko)
> 
>     - Change the name 'list',a node in restore_list to 'restore_node'
>       (Nirmoy Das)
> 
>     - Use mutex instead of spinlock when updating restore_list
>       (Nirmoy Das)
> 
>     - Initialize restore_node when virtio_gpu_object is created - this is to
>       determine whether the object should be removed from the restore_list with
>       'list_empty' function when it is time to free the object as not all objects
>       will be added to the list.
> 
> v6: - Add a helper, virtio_gpu_add_object_to_restore_list
>       (Dmitry Osipenko)
> 
> v7: - Add drm_print.h
> 
> v8: - Introduce virtio_gpu_remove_from_restore_list helper and ensure its call in
>       all object destruction paths (General, Prime, and VRAM) to prevent
>       use-after-free.
>       (Dmitry Osipenko)
> 
>     - Relocate the restore list removal logic from the final cleanup stage
>       to the initial free stage for better synchronization.
>       (Dmitry Osipenko)
> 
> Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>
> Cc: Nirmoy Das <nirmoyd@nvidia.com>
> Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>
> ---

Nit: change log is preferred to put under '--' to not have it in a
commit message

-- 
Best regards,
Dmitry
