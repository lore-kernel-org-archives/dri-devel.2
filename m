Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 090FBCD4851
	for <dri-devel@archiver.kernel.org>; Wed, 13 May 2026 09:10:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 48D4410E2F3;
	Wed, 13 May 2026 09:10:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="Jf8V2eOO";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ECFD010E2F3
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 09:10:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1778663410; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=fKPVwADO8NoII5QZA/9nW44lDanjOSOPhHM423Zx+9+6zesDGOnMff+bl6Rvh35UgZazW4f6pUAJvbXAvKHqhZZYFdnmRXBF06iR1kPcV68F6IKn45f8ugIZ8e4PJ7XblV87S1FasZpuW7NarX5/YHkLXMUQ3iWeg5UVpuMhmHg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1778663410;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=J+PeEpwgMGG+eT1L4WzFjaLfRNxviLWx3M2E/85kEME=; 
 b=LWW9GtphE/fmKFD55IBBhxIMs4RggAQDNovGJ63G4XWnycQHO5zTbncfVhvn8bBHggKZZUhjQBOziPDbusIDx0usWV5F4GoxPV1yeIwUdB2LfIsVfiVpUaDZZ/xiaJLbZ2XE1NyxxM9w+i2ohLfDSfrQe3cfbQ6JjUt4B1rCsRQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1778663410; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=J+PeEpwgMGG+eT1L4WzFjaLfRNxviLWx3M2E/85kEME=;
 b=Jf8V2eOOgD0CHQN4V+0lESC/eA0s1LNDholC2vph3WSKS4d0gSXu+TJW0UbFGg89
 A/7jUvEcwwmIPXG2OJJQZoQi/h3CGidnrHf3CfQCPBsxoautZJNHcFBo8FbSwEEvaZW
 E4WUHbJwdUDYlCgS0OJ9jhB9OvEW+ZhL6xqB/ifM=
Received: by mx.zohomail.com with SMTPS id 177866340828668.99618190513445;
 Wed, 13 May 2026 02:10:08 -0700 (PDT)
Message-ID: <65da2ce9-a2ab-4800-a73e-1a26082d0605@collabora.com>
Date: Wed, 13 May 2026 12:10:02 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/virtio: move cursor resv lock acquisition to
 prepare_fb
To: Deepanshu Kartikey <kartikey406@gmail.com>
Cc: airlied@redhat.com, kraxel@redhat.com, gurchetansingh@chromium.org,
 olvaffe@gmail.com, maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, simona@ffwll.ch, sumit.semwal@linaro.org,
 christian.koenig@amd.com, dri-devel@lists.freedesktop.org,
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
 syzbot+72bd3dd3a5d5f39a0271@syzkaller.appspotmail.com, stable@vger.kernel.org
References: <20260512020718.108044-1-kartikey406@gmail.com>
 <d1bc8d7d-3a4f-4ede-8266-81cc66bf11b5@collabora.com>
 <CADhLXY7N0eLpA30eV4Rb=F4vzCf9XYtDjMpxBSJtGeMWNi6Cwg@mail.gmail.com>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <CADhLXY7N0eLpA30eV4Rb=F4vzCf9XYtDjMpxBSJtGeMWNi6Cwg@mail.gmail.com>
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

On 5/13/26 04:55, Deepanshu Kartikey wrote:
> On Tue, May 12, 2026 at 12:04 PM Dmitry Osipenko
> <dmitry.osipenko@collabora.com> wrote:
>>
>> I'm getting lockup with this patch applied and now see that
>> virtio_gpu_resource_flush() also locks BO.
>>
>> Easiest option might be to add uninterruptible variant of
>> virtio_gpu_array_lock_resv(). Could you please try it for v3?
>>
>> --
>> Best regards,
>> Dmitry
> 
> Hi Dmitry,
> 
> Thanks for testing and catching the lockup. Before I send v3, want
> to confirm the approach:
> 
>   1. Revert v2's prepare_fb / cleanup_fb / plane_state changes;
>      keep the lock acquisition inside cursor_plane_update like
>      the original code.
> 
>   2. Add virtio_gpu_array_lock_resv_uninterruptible() in
>      virtgpu_gem.c, mirroring the existing helper but using
>      dma_resv_lock() instead of dma_resv_lock_interruptible() on
>      the nents==1 path. Declare it in virtgpu_drv.h.
> 
>   3. In cursor_plane_update, call the new helper and check its
>      return. The signal path is closed; -ENOMEM from
>      dma_resv_reserve_fences() remains and is handled by freeing
>      objs and skipping the cursor update for that frame.
> 
> A skipped cursor frame on ENOMEM is the remaining failure mode in
> .atomic_update; this avoids the lockup with virtio_gpu_resource_flush()
> that v2's broader lock scope caused.
> 
> Does that match what you had in mind?

Sounds good. The virtio_gpu_resource_flush() also should be updated to
use uninterruptible() variant.

-- 
Best regards,
Dmitry
