Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 756B21073CAB
	for <dri-devel@archiver.kernel.org>; Wed,  8 Apr 2026 12:59:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B640410E643;
	Wed,  8 Apr 2026 12:59:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="HV7ych6j";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C93A510E643
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Apr 2026 12:59:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1775653151; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=hB4RBWl0XNUxhfNwxM5GkOaAUpfqOOOgj8PQNaGstdUDeiD6E/ua0f81Bf/Vi9bHZg3M+GzZdZeMO0t9sTtgP/fJBuB/zaj7ucnZFigXURhZgoXQOBjCKW3ogiwzvaP6ven7FQCxqNYWPQlR3mMH4Fiqi1lHRQh3PUBh/Q2oigM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1775653151;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=IrRNgQuD6NypyIwHQrUwBWBAE3AdmG59dnEW531MBz4=; 
 b=aniAjb19zLc8QuBnJDGKQzWafjzi1yKMwzemrPkIDm4l9vd7eg74P2LyTOPzIV0Rcj/E2rhGLsOhRFaES86AjpVUdoymNPaq0k9DygLOjzeRVU4M07fkvyGlKhSWi3+CIwmmuPFDyQ7IRu0gFYOKMJ7MkjWXbgY/RlSLEgbYGkQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1775653151; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=IrRNgQuD6NypyIwHQrUwBWBAE3AdmG59dnEW531MBz4=;
 b=HV7ych6jOCV/fpFQCNMiIeF3lgKkKp/9IgLZpojBBDpuyxtloZkt2Za1Tv2VEXGW
 4Mjn0IZmQMMsNHrySVvf7Rk4oKJFCjKsnoaVYHiqjcdV4jVYPos4w5RVNw/lazHTuzt
 MLUHYO2D2JJCg3fAqv0JDV/m0fr/OHU84AL6gvVY=
Received: by mx.zohomail.com with SMTPS id 177565314977182.60491801498722;
 Wed, 8 Apr 2026 05:59:09 -0700 (PDT)
Message-ID: <2175a05a-d83f-4252-bbf8-581ae652a6b8@collabora.com>
Date: Wed, 8 Apr 2026 15:59:05 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/virtgpu: Add PM support for suspend/resume
To: Morris Pan <morris.pan@mediatek.com>, airlied@redhat.com, kraxel@redhat.com
Cc: srv_heupstream@mediatek.com, gurchetansingh@chromium.org,
 olvaffe@gmail.com, maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, simona@ffwll.ch, dri-devel@lists.freedesktop.org,
 virtualization@lists.linux.dev
References: <20260401061050.1035881-1-morris.pan@mediatek.com>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20260401061050.1035881-1-morris.pan@mediatek.com>
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

Hi,

On 4/1/26 09:10, Morris Pan wrote:
> diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.c b/drivers/gpu/drm/virtio/virtgpu_drv.c
> index a5ce96fb8a1d..fbca0a82958c 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_drv.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_drv.c
> @@ -145,6 +145,40 @@ static void virtio_gpu_config_changed(struct virtio_device *vdev)
>  	schedule_work(&vgdev->config_changed_work);
>  }
>  
> +#ifdef CONFIG_PM_SLEEP
> +static int virtgpu_freeze(struct virtio_device *vdev)
> +{
> +	vdev->config->del_vqs(vdev);
> +	virtio_reset_device(vdev);
> +
> +	return 0;
> +}

VirtIO-GPU shouldn't be reset freely. See [1] and follow previous
hibernation-support discussions on the ML.

[1[
https://lore.kernel.org/dri-devel/20260107182745.229481-1-dongwon.kim@intel.com/

-- 
Best regards,
Dmitry
