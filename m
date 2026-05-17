Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41F3CCD4F4A
	for <dri-devel@archiver.kernel.org>; Sun, 17 May 2026 17:59:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C5A410E288;
	Sun, 17 May 2026 17:59:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="aJrXWscN";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 163D910E288
 for <dri-devel@lists.freedesktop.org>; Sun, 17 May 2026 17:59:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1779040784; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=a40RagTkxwPcCFYDtCMupIoOlPCqNm2VrjYiI1h13n8w8v2OkO+8bOlioczIUUCUkQBQ2n7x3F+VZ59kIXVsDG1XngRw/q6frdqCWfgZDNNrXb2RP9cI4hFmrlYMpL4f4tWHgWvDsTdur3HfAedChH9CyADD7EIvmeQKKds+0Nk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1779040784;
 h=Content-Type:Content-Transfer-Encoding:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To:Cc;
 bh=65TShgUK6OrnwNT49dqyIr1UrM5+ORK9pqnBRIhywf8=; 
 b=Td24tJakKKhH6ZBxLnJpufUUcHpr4QirYGa7Eqsb6DITR25TEcc732tevhmUsnGBITUo/1ooElDS4MY0DhqwSNvfjl6Ca0dW0hCl8x7gcdvrBgcu9tuQnTC9GtVTou6of7tPYvSUoPUbCMVgkrbPy/mR9fNO8yRaloEzTfGtnhw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1779040784; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
 bh=65TShgUK6OrnwNT49dqyIr1UrM5+ORK9pqnBRIhywf8=;
 b=aJrXWscNYFUbwGF8FgZiAGwGCtYD4iVBUTtBUyOpiFr21SVmT3OTLA62/f0lSkXV
 I0irFi1XO2ndRa7cA3Oq+l0TwTqvK63IwUzCH23p9C1iCVUo6BYS5kXB8x8ZimB1aTw
 izKgESXk8jYPz4VGRSpfRHjVJpgBhrfNosiVSc4k=
Received: by mx.zohomail.com with SMTPS id 1779040781804580.954325613122;
 Sun, 17 May 2026 10:59:41 -0700 (PDT)
Message-ID: <4ec04daf-9665-4b15-9e62-b83eb9aaa7c9@collabora.com>
Date: Sun, 17 May 2026 20:59:38 +0300
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
