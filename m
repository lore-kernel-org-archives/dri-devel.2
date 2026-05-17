Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDA9ECD4F47
	for <dri-devel@archiver.kernel.org>; Sun, 17 May 2026 17:58:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EDBBD10E0F9;
	Sun, 17 May 2026 17:58:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="kFMB9b0r";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA4E910E0F9
 for <dri-devel@lists.freedesktop.org>; Sun, 17 May 2026 17:58:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1779040721; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=WmfY19OKFKnkWyJW49PKrDGRayA5/Z9UssCuIxe2vntvM0FDMDa7y4tIecx8yADOUvT/I97cERvbP04iNEYWPM01h6/0n3J+O6uDYtAl8kbJgPMQLCJ793D3+CvLyvfrG4yvp9IvldkHWFYE3FtYbab+CTPI0239YGvIPRo75ek=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1779040721;
 h=Content-Type:Content-Transfer-Encoding:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To:Cc;
 bh=VeevrAQiCsQUxOzHl4izVJTD529JtlfihkTekpvzD/Q=; 
 b=LeDcYhPTFU5s+Sjfqesl14sg/H+sJBRntL92E6zT8bfgI6HB/unKHtnPXYdU8A9YG8hCpAR4XNzLHOASdfYgg70m0tSm5JSXWm+LosgUph3EDZdz+7s9Ec175fjStWgssT9q+mK0r5ZQR3XqFlL8wqdj/eVUYxyFzQ+sZgLQ6ns=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1779040720; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
 bh=VeevrAQiCsQUxOzHl4izVJTD529JtlfihkTekpvzD/Q=;
 b=kFMB9b0rTNzu8GgHyvO74n1nDy7k93/Qmqv7K3jv4CtO0UJFGbfX4Y1Rhkvkk6O8
 mR/DfyZe/O0J0reu5g/NsabuZx0bGDP2pMO3WY0YXss4YtArETGzd+Q4SrMRELGnv1Z
 0bsJfVjJOu16X5eNpqm/ZePytwegcLlNAljOJfT8=
Received: by mx.zohomail.com with SMTPS id 1779040719433684.9088233288549;
 Sun, 17 May 2026 10:58:39 -0700 (PDT)
Message-ID: <39c2d048-8b29-4893-8fbb-12adb0697fd6@collabora.com>
Date: Sun, 17 May 2026 20:58:36 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 1/3] drm/virtio: Freeze and restore hooks to support
 suspend and resume
To: dongwon.kim@intel.com, dri-devel@lists.freedesktop.org,
 airlied@redhat.com, kraxel@redhat.com
References: <20260429204729.993669-1-dongwon.kim@intel.com>
 <20260429204729.993669-2-dongwon.kim@intel.com>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20260429204729.993669-2-dongwon.kim@intel.com>
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
> +static int virtgpu_freeze(struct virtio_device *vdev)
> +{
> +	struct drm_device *dev = vdev->priv;
> +	struct virtio_gpu_device *vgdev = dev->dev_private;
> +	int error;
> +
> +	error = drm_mode_config_helper_suspend(dev);
> +	if (error) {
> +		DRM_ERROR("suspend error %d\n", error);
> +		return error;
> +	}
> +
> +	flush_work(&vgdev->obj_free_work);
> +	flush_work(&vgdev->ctrlq.dequeue_work);
> +	flush_work(&vgdev->cursorq.dequeue_work);
> +	flush_work(&vgdev->config_changed_work);
> +
> +	wait_event_timeout(vgdev->ctrlq.ack_queue,
> +		vgdev->ctrlq.vq->num_free == vgdev->ctrlq.vq->num_max,
> +		5 * HZ);
> +
> +	wait_event_timeout(vgdev->cursorq.ack_queue,
> +		vgdev->cursorq.vq->num_free == vgdev->cursorq.vq->num_max,
> +		5 * HZ);

Return error on timeout or better wait indefinitely. On [1] I suggested
to print warning messages on event timeout, could be a common
virtio_gpu_wait_queue_event() helper.

[1]
https://lore.kernel.org/dri-devel/8a986c52-964f-42a5-b063-fbe2b242ca36@collabora.com/

-- 
Best regards,
Dmitry
