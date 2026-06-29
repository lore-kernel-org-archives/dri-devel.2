Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D75EAC43458
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 21:39:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F09D10EA63;
	Mon, 29 Jun 2026 21:39:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="imviU+FJ";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D26510EA63
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 21:39:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1782769140; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=DD/G1CVE2B7GRYG27hevrGTBCBUP1rcQjQvxFbuW/RfJ6BAdLNR38g1SsBl16uXFxv+wYk8FAJ5sVAdwrSSWKDQXQpLFvGRW1vd/NiVnko+G65ObN+CxGz9rZjtfMeJso9u/JeFjiiHGkHhXNLIAwRUEwaRQAlXyxOlm6ppSFzE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1782769140;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=V2dWuEpkhVjMLm2lL6us2OpMnJ/fy5SE2u+UJZd6w+A=; 
 b=RRlCaK/WngedPTBqZDaiRyn9RHPWfXwDvw7G+zK4WRKIxMPqy9dH1u6REDwFeEzMLfWY9bLj/MY7n3zIt0DzlcrqdRLeltMv0rA07APljGu+LWb6cYHLjcYjP9/JcJ8Ug9WlrJJa5UmPA3HNN4wfTnsLJN8ylcXifi+U0RfO/O0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1782769140; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=V2dWuEpkhVjMLm2lL6us2OpMnJ/fy5SE2u+UJZd6w+A=;
 b=imviU+FJpvekMZlnS7Pal/ELSKOzwENl6rbn16EmzQk4C/PmZvw3I/+JrF+k+mhr
 Z0F+4ZuT11T/VGsUQxJPh1UKNqXvXzfVfH4q81QhlT3UMejF9gl6KWVidFvfBYwD85e
 6dvbJiiHSohVPgq1p9vpdtETUIyBsa/5SPzAw1X8=
Received: by mx.zohomail.com with SMTPS id 1782769138029866.4526666587577;
 Mon, 29 Jun 2026 14:38:58 -0700 (PDT)
Message-ID: <7202d2dc-b6fe-440e-88b0-aefb26c38b86@collabora.com>
Date: Tue, 30 Jun 2026 00:38:54 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/virtio: Don't detach GEM from a non-created context
To: Jason Macnak <natsu@google.com>, David Airlie <airlied@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>
Cc: dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260625170828.3335431-1-natsu@google.com>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20260625170828.3335431-1-natsu@google.com>
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

On 6/25/26 20:08, Jason Macnak wrote:
> Applies the same treatment as commit 7cf6dd467e87 ("drm/virtio:
> Don't attach GEM to a non-created context in gem_object_open()")
> to virtio_gpu_gem_object_close() to avoid trying to detach
> a resource that was never attached due to a context
> never being created when context_init is supported.
> 
> Fixes: 086b9f27f0ab ("drm/virtio: Don't create a context with default param if context_init is supported")
> Cc: <stable@vger.kernel.org> # v6.14+
> Signed-off-by: Jason Macnak <natsu@google.com>
> ---
>  drivers/gpu/drm/virtio/virtgpu_gem.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/virtio/virtgpu_gem.c b/drivers/gpu/drm/virtio/virtgpu_gem.c
> index 435d37d36034..66c3f6f74e9c 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_gem.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_gem.c
> @@ -139,13 +139,15 @@ void virtio_gpu_gem_object_close(struct drm_gem_object *obj,
>  	if (!vgdev->has_virgl_3d)
>  		return;
>  
> -	objs = virtio_gpu_array_alloc(1);
> -	if (!objs)
> -		return;
> -	virtio_gpu_array_add_obj(objs, obj);
> +	if (vfpriv->context_created) {
> +		objs = virtio_gpu_array_alloc(1);
> +		if (!objs)
> +			return;
> +		virtio_gpu_array_add_obj(objs, obj);
>  
> -	virtio_gpu_cmd_context_detach_resource(vgdev, vfpriv->ctx_id,
> -					       objs);
> +		virtio_gpu_cmd_context_detach_resource(vgdev, vfpriv->ctx_id,
> +						       objs);
> +	}
>  	virtio_gpu_notify(vgdev);
>  }

The following scenario still will be troubling:

1. vgdev->has_context_init = true
2. virtio_gpu_gem_object_open() invoked, GEM created and not attached to ctx
3. virtio_gpu_context_init_ioctl() invoked, now vfpriv->context_created
= true
4. virtio_gpu_gem_object_close() will detach resource that wasn't attached

Add obj->ctx_attached member to struct virtio_gpu_object. See
virtio_gpu_object_attach() that uses obj->attached, do the same for
virtio_gpu_cmd_context_attach_resource().

-- 
Best regards,
Dmitry
