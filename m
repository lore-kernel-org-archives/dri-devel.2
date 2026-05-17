Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8813DCD4F4A
	for <dri-devel@archiver.kernel.org>; Sun, 17 May 2026 18:10:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EDCE710E295;
	Sun, 17 May 2026 18:10:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="Q8ge9c6g";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1EE2D10E295
 for <dri-devel@lists.freedesktop.org>; Sun, 17 May 2026 18:10:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1779041413; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=cmWM2kCcNCsaE/kiSevmhsfoUuveIWs+zx2oqw8wmtJN3lycxLdqjK/TQXfer+u/kzykGbJte8bpRlBqrEGAQYL2p/TKIvEQ8YUu8Og/JqoCxDIRPBHIHlqmOXXovWQGrgsD01SNiN0QQmbvyYWWE6dHZIniJT6qWdcitoKMU40=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1779041413;
 h=Content-Type:Content-Transfer-Encoding:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To:Cc;
 bh=65TShgUK6OrnwNT49dqyIr1UrM5+ORK9pqnBRIhywf8=; 
 b=VjKgWYmjA5OfPO6XSgzftZ4WoyRv3cZJBixMdBxpJ9yEILcdFWZDsBU+HRcv6wLRvheoQXOdATUeQW9z6IgbLmMXT0SfP1dgxhOY/AqiMr5FgetOqklQzp2PMdfDg9GpaGQML3iK/TpPxn2J6ciJUOIi/Bad82FneJiN/R1/0zI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1779041413; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
 bh=65TShgUK6OrnwNT49dqyIr1UrM5+ORK9pqnBRIhywf8=;
 b=Q8ge9c6gO0yJr90K++8tbO4Xdv6HAf96Pbq0bY/pnedCkAN+aZBq/R+8KDc3iktn
 SNG8PhTEDV83KaxoNbiA4ksQPyihlIToqEqY4STlNTPxX0XK0x/vaVk08dBIPxSAtNC
 17vby48/WFEpU989AZ3DP8xxYOJ238qTWazZ9o4o=
Received: by mx.zohomail.com with SMTPS id 1779041411717366.9956114288773;
 Sun, 17 May 2026 11:10:11 -0700 (PDT)
Message-ID: <cacec80a-9545-476a-a538-ba646a8473c6@collabora.com>
Date: Sun, 17 May 2026 21:10:09 +0300
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
>  void virtio_gpu_cleanup_object(struct virtio_gpu_object *bo)
>  {
>  	struct virtio_gpu_device *vgdev = bo->base.base.dev->dev_private;
> @@ -94,6 +103,7 @@ static void virtio_gpu_free_object(struct drm_gem_object *obj)
>  	struct virtio_gpu_device *vgdev = bo->base.base.dev->dev_private;
>  
>  	if (bo->created) {
> +		virtio_gpu_remove_from_restore_list(bo);
>  		virtio_gpu_cmd_unref_resource(vgdev, bo);

Can virtio_gpu_remove_from_restore_list() be moved to
virtio_gpu_cmd_unref_resource()?

-- 
Best regards,
Dmitry
