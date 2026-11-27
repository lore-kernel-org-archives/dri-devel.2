Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9531B606A31E
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 13:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=fjbmhK+G
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D1DF3112AC9;
	Fri, 27 Nov 2026 13:19:29 +0000 (UTC)
Received: from sender5-op-o11.zoho.com (sender5-op-o11.zoho.com
 [165.173.182.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 459B7112AE5
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 13:19:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1795785553; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=ExGPjq9IDnRlB6hWxXSGQX7ogKjPd23U9QB0EvvQKYI2wamK7QK8W7uDMaTyWkBaiBSvsUC0Rg25zqIklTzuCRmhy666D5dZHgfJDBw+T8K2eKtwg8tUsp2RYvKmuFnNbY5r3swJ5p2iq7nNgNaB1p3yFnrOAARLSQDeJCdF1Y4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1795785553;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=SY2tTRtiqzTHvXGQ5QTsdsPt0UxHnzMGtbeuKwj2TvA=; 
 b=N9pMmMqyqGSbC11VrwobCh0Ufuih+GCofny6P2f+NB29EO70v3+ZCkdif7phU75wi067sBAUJGaA+5bjYE2EFG63S15S6imY0OzavzhQp8/glPs/eyzNXC2N1TyYXqPZfcYgpIdhwXHy0eLMRmlWyn03qvGaEdJX//oxxk1nESw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: a=rsa-sha256;
 b=fjbmhK+GqS73MX/08cVjaAwQ7iL3tx9bfClgvoIpt47AfwApP5c9hSD79eOQULd+Wuamcm31HrgzZ6Nx2dIG6Yb5LvYIJxjENVRmCc6sBxvT9gX78UGb4NSuGSnMOf42U+co0QeWMIaBR2x59x5DJ8JmOGF7cdlt0Z44kvBVLZc=;
 c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1;
 bh=SY2tTRtiqzTHvXGQ5QTsdsPt0UxHnzMGtbeuKwj2TvA=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1795785550255124.78204008607634; 
 Fri, 27 Nov 2026 05:19:10 -0800 (PST)
Message-ID: <f90f752c-d9f8-4280-bed1-1059c075e42d@collabora.com>
Date: Fri, 27 Nov 2026 16:19:05 +0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v10 1/4] drm/virtio: add VIRTIO_GPU_CAPSET_ROCM
 capability
To: Honglei Huang <honghuan@amd.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 David Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Cc: Gurchetan Singh <gurchetansingh@chromium.org>,
 Chia-I Wu <olvaffe@gmail.com>, Ray Huang <Ray.Huang@amd.com>,
 dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20261106082625.812860-1-honghuan@amd.com>
 <20261106082625.812860-2-honghuan@amd.com>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20261106082625.812860-2-honghuan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/6/26 11:26, Honglei Huang wrote:
> Add a new GPU capability set VIRTIO_GPU_CAPSET_ROCM to support ROCm
> compute workloads in virtualized environments.
> 
> ROCm (Radeon Open Compute) is AMD's open-source software platform for
> GPU compute and HPC workloads.
> 
> ID 7 is already used by the OpenCL capset (VIRCL), and gfxstream's
> rutabaga_gfx has already claimed IDs 7-9 ahead of any spec or kernel
> header update, so ROCm uses ID 10 to avoid a further collision. A
> matching virtio-gpu specification change is in progress to register this
> assignment.
> 
> Also add the matching VIRTGPU_DRM_CAPSET_ROCM alias in virtgpu_drm.h for
> consistency with the other capability sets exposed through
> DRM_IOCTL_VIRTGPU_GET_CAPS.
> 
> Signed-off-by: Honglei Huang <honghuan@amd.com>
> ---
>   include/uapi/drm/virtgpu_drm.h  | 1 +
>   include/uapi/linux/virtio_gpu.h | 1 +
>   2 files changed, 2 insertions(+)
> 
> diff --git a/include/uapi/drm/virtgpu_drm.h b/include/uapi/drm/virtgpu_drm.h
> index 95587e12ae..9b886e9772 100644
> --- a/include/uapi/drm/virtgpu_drm.h
> +++ b/include/uapi/drm/virtgpu_drm.h
> @@ -170,6 +170,7 @@ struct drm_virtgpu_3d_wait {
>   #define VIRTGPU_DRM_CAPSET_VENUS 4
>   #define VIRTGPU_DRM_CAPSET_CROSS_DOMAIN 5
>   #define VIRTGPU_DRM_CAPSET_DRM 6
> +#define VIRTGPU_DRM_CAPSET_ROCM 10
>   struct drm_virtgpu_get_caps {
>   	__u32 cap_set_id;
>   	__u32 cap_set_ver;
> diff --git a/include/uapi/linux/virtio_gpu.h b/include/uapi/linux/virtio_gpu.h
> index 4f530d9005..e22049835e 100644
> --- a/include/uapi/linux/virtio_gpu.h
> +++ b/include/uapi/linux/virtio_gpu.h
> @@ -321,6 +321,7 @@ struct virtio_gpu_cmd_submit {
>   #define VIRTIO_GPU_CAPSET_VENUS 4
>   #define VIRTIO_GPU_CAPSET_CROSS_DOMAIN 5
>   #define VIRTIO_GPU_CAPSET_DRM 6
> +#define VIRTIO_GPU_CAPSET_ROCM 10
>   
>   /* VIRTIO_GPU_CMD_GET_CAPSET_INFO */
>   struct virtio_gpu_get_capset_info {

Could you please give a link to the spec change discussion? Please send 
it to virtio-comment ML if haven't been done yet.

-- 
Best regards,
Dmitry
