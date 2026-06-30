Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E77E9C43458
	for <dri-devel@archiver.kernel.org>; Tue, 30 Jun 2026 13:36:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3438110E1F3;
	Tue, 30 Jun 2026 13:36:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="jQeUkXaX";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C818910E1F3
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 13:36:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1782826576; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=iV4WbuHYbx4El2QN61U4+XCdM6ADLZUd9cw93wbPW/MwutofO4DghizvGbdQ3n0l4tUoyE67v4DPZZ1/8NbuMSTTuX7chFtKzArCmfEoG5qdUJ1AySrskCWiB/uLgWLSGP2gZJdqisA8piVts2fLEWzsUb+t6GUMWJUIfomDyhA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1782826576;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=4IDuFu2HV5TP+YThiZHAtkhhu5xuMhrAYpBnN8AraGU=; 
 b=Vy58HD8wZr7ETdX96G9l/PDSus4RTwNyAfi17/n/QPkEU1h8pYBFa/6wM36kmCqth9n3FUGdVgQEybCYTOQh+qgIwhAQjC4Ka5f5ySyxNZayq+iwt5pYbGlsvVaPNVba19jfTCVdvLTduJvRMRE3Cf29EnyDoVqi6W7ZWcgEKIE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1782826576; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=4IDuFu2HV5TP+YThiZHAtkhhu5xuMhrAYpBnN8AraGU=;
 b=jQeUkXaXl/Ox+TWruew3PgdhLj+v3vgR73ov0x5CZnTZ3MRzVRA5T/HezOU6Qb6o
 MxM+e8MwF/K2Qc8bIu8eeTCKCjwcy57T0J8B0xvn2FFzmaaTAsyQGR9IhOhZ+v/Iweo
 WC+aRN0Fgh2vbfmDbyzczMt2m0/DkQ95tWvfV8Mo=
Received: by mx.zohomail.com with SMTPS id 1782826573752150.0126917208695;
 Tue, 30 Jun 2026 06:36:13 -0700 (PDT)
Message-ID: <f5c5fc6c-3c6e-4068-80d7-f1acebff7168@collabora.com>
Date: Tue, 30 Jun 2026 16:36:08 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/virtio: fail init on display-info timeout
To: Pengpeng Hou <pengpeng@iscas.ac.cn>, David Airlie <airlied@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Cc: Gurchetan Singh <gurchetansingh@chromium.org>,
 Chia-I Wu <olvaffe@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20260625030202.82590-1-pengpeng@iscas.ac.cn>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20260625030202.82590-1-pengpeng@iscas.ac.cn>
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

On 6/25/26 06:02, Pengpeng Hou wrote:
> virtio_gpu_init() sends GET_DISPLAY_INFO when scanouts are present and
> waits for display_info_pending to clear. If the response never arrives,
> the wait result is ignored and probe still succeeds.
> 
> Return -ETIMEDOUT on display-info timeout. Because this happens after
> virtio_device_ready(), reset the device and tear down modesetting before
> using the existing vbuf and virtqueue cleanup path.
> 
> Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
> ---
>  drivers/gpu/drm/virtio/virtgpu_kms.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/virtio/virtgpu_kms.c b/drivers/gpu/drm/virtio/virtgpu_kms.c
> index cfde9f573df6..31209bea97ae 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_kms.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_kms.c
> @@ -262,11 +262,19 @@ int virtio_gpu_init(struct virtio_device *vdev, struct drm_device *dev)
>  			virtio_gpu_cmd_get_edids(vgdev);
>  		virtio_gpu_cmd_get_display_info(vgdev);
>  		virtio_gpu_notify(vgdev);
> -		wait_event_timeout(vgdev->resp_wq, !vgdev->display_info_pending,
> -				   5 * HZ);
> +		if (!wait_event_timeout(vgdev->resp_wq,
> +					!vgdev->display_info_pending,
> +					5 * HZ)) {
> +			DRM_ERROR("timed out waiting for display info\n");
> +			ret = -ETIMEDOUT;
> +			goto err_ready;
> +		}
>  	}
>  	return 0;
>  
> +err_ready:
> +	virtio_reset_device(vgdev->vdev);
> +	virtio_gpu_modeset_fini(vgdev);
>  err_scanouts:
>  	virtio_gpu_free_vbufs(vgdev);
>  err_vbufs:

Rebased and applied to misc-next, thanks!

-- 
Best regards,
Dmitry
