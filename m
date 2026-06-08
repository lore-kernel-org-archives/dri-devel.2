Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69EE7CD8CA4
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 18:40:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C22D610F888;
	Mon,  8 Jun 2026 18:40:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="CxtYaqve";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 631CD10F888
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 18:40:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1780944031; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=V+Q0Hlf+InbGgJsbB4Ca3LX/SlvPfkjXOXJ1N1aYCX4Fca+CDdK/cP8gSZzILVc2TuH2gMfsystClJzsnIF/qnhGTkV/OJeLvcypip128chGHqg+zI6S44b8stlpHArmuygRE3Hsq8oahQg9hEewYqHXP+H7nIMQmDBZzpyxn80=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1780944031;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=vDOv6K/z5q4R9/tHJ2kRUQ/ajocq4J9icfQx3EXym8s=; 
 b=LS+i9SsjkKU6wIsN25iBFsHXDhJ1h8OxyUTBOA3tJo5ZuHpy2fdAyoC4pdL6RjJr7uXxzJRvVwSYYeJf3umURhiP7kyHZqwaqGmOjq+sPsf7178DPshLzyzzGKOkRivE/CtKpYIHiOgW6+Hf+US2841oacwUDEX0RhDcJ8M/7zU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1780944031; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=vDOv6K/z5q4R9/tHJ2kRUQ/ajocq4J9icfQx3EXym8s=;
 b=CxtYaqveK6YN4L77uspBr/zRjmV5Fy6n1wByPBRLuwe0yGgfxhcs+b0ea4w3RRUN
 rIKjXN7QQhUFu9TDL+5caNC/IKdHWctK+kJuh5qgLIBhtCb/RFb+R6ABRBVjulJcxrM
 Lgs5KplSkQ7mmeoanVKQNxZJEDvsSnaa6s8/bp+s=
Received: by mx.zohomail.com with SMTPS id 1780944029758968.0992923301662;
 Mon, 8 Jun 2026 11:40:29 -0700 (PDT)
Message-ID: <f3848234-4258-483f-bc27-cdd31f65e7aa@collabora.com>
Date: Mon, 8 Jun 2026 21:40:25 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] drm/virtio: Fix driver removal with disabled KMS
To: Ryosuke Yasuoka <ryasuoka@redhat.com>, David Airlie <airlied@redhat.com>, 
 Gerd Hoffmann <kraxel@redhat.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu <olvaffe@gmail.com>
Cc: dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <18b6b23ae1412a71.6d9db1e7acbb9813.37ad12b07518c586@ryasuoka-thinkpadx1carbongen9.tokyo.csb>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <18b6b23ae1412a71.6d9db1e7acbb9813.37ad12b07518c586@ryasuoka-thinkpadx1carbongen9.tokyo.csb>
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

On 6/7/26 07:31, Ryosuke Yasuoka wrote:
> Hi Dmitry
> 
> On 04/06/2026 15:27, Dmitry Osipenko wrote:
>> DRM atomic and modesetting aren't initialized if virtio-gpu driver built
>> with disabled KMS, leading to access of uninitialized data on driver
>> removal/unbinding and crashing kernel. Fix it by skipping shutting down
>> atomic core with unavailable KMS.
>>
>> Fixes: 72122c69d717 ("drm/virtio: Add option to disable KMS support")
>> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
>> ---
>>  drivers/gpu/drm/virtio/virtgpu_drv.c | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.c b/drivers/gpu/drm/virtio/virtgpu_drv.c
>> index f0fb784c0f6f..2aaa7cb08085 100644
>> --- a/drivers/gpu/drm/virtio/virtgpu_drv.c
>> +++ b/drivers/gpu/drm/virtio/virtgpu_drv.c
>> @@ -138,7 +138,10 @@ static void virtio_gpu_remove(struct virtio_device *vdev)
>>  
>>  	virtio_gpu_release_vqs(dev);
>>  	drm_dev_unplug(dev);
>> -	drm_atomic_helper_shutdown(dev);
>> +
>> +	if (drm_core_check_feature(dev, DRIVER_ATOMIC))
>> +		drm_atomic_helper_shutdown(dev);
>> +
>>  	virtio_gpu_deinit(dev);
>>  	drm_dev_put(dev);
>>  }
> 
> The patch looks good to me at a glance. I haven't done a full, deep code
> review yet, but I've tested it on my lab and everything works as
> expected.
> 
> Tested-by: Ryosuke Yasuoka <ryasuoka@redhat.com>

Thanks a lot for the testing. The review from you will be very welcomed
too.

-- 
Best regards,
Dmitry
