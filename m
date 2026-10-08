Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D8B6CA600E
	for <dri-devel@archiver.kernel.org>; Thu,  8 Oct 2026 09:40:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 040F510E77D;
	Thu,  8 Oct 2026 09:40:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="Xj/4BLss";
	dkim-atps=neutral
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com
 [210.118.77.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A24A710E77D
 for <dri-devel@lists.freedesktop.org>; Thu,  8 Oct 2026 09:40:20 +0000 (UTC)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20261008094019euoutp02741ba07d2166dd0621d4925aab4fa932~chHvMATr52290122901euoutp02q
 for <dri-devel@lists.freedesktop.org>; Thu,  8 Oct 2026 09:40:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20261008094019euoutp02741ba07d2166dd0621d4925aab4fa932~chHvMATr52290122901euoutp02q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1791452419;
 bh=WhxT/iYEf+0IDdqAC+j4Mz33sgpEH4FLr8IpDqOPvHM=;
 h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
 b=Xj/4BLsstGZmeWUwb6NBvnlQo/AKu5++jt+G4Hx9BEvaGZSsa4hKAdMuJvMa1tZ0R
 2MSNHUNKDRCtcRZ/tahQx62vBHZSEdLkJvZ0o8zCEy1FbJ3Ucqsnncd8tgGawaKBOh
 e39Lk7J/Gb5tWs8wpIQFsa+8xOidSA0J71GZW3B8=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20261008094018eucas1p2a59fec3fd358519ec23caaf4c8520660~chHunjtZg1919819198eucas1p2V;
 Thu,  8 Oct 2026 09:40:18 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
 eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20261008094018eusmtip23e01038e25862720727ab89e88db890c~chHuQeYBt1109211092eusmtip2O;
 Thu,  8 Oct 2026 09:40:17 +0000 (GMT)
Message-ID: <64f7ea95-516f-4b95-a42e-14fd606879f9@samsung.com>
Date: Thu, 8 Oct 2026 11:40:17 +0200
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH v1] Revert
 "drm/virtio: Add pixel blend mode property to cursor plane"
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>, David Airlie
 <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Gurchetan Singh
 <gurchetansingh@chromium.org>, Chia-I Wu <olvaffe@gmail.com>
Cc: dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <dae2c4c1-0b60-4975-83d6-924d5255db94@collabora.com>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20261008094018eucas1p2a59fec3fd358519ec23caaf4c8520660
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20261008093604eucas1p1857ec36ab7da379e75cb5f8bb993b1b6
X-EPHeader: CA
X-CMS-RootMailID: 20261008093604eucas1p1857ec36ab7da379e75cb5f8bb993b1b6
References: <20261007222244.295186-1-dmitry.osipenko@collabora.com>
 <CGME20261008093604eucas1p1857ec36ab7da379e75cb5f8bb993b1b6@eucas1p1.samsung.com>
 <dae2c4c1-0b60-4975-83d6-924d5255db94@collabora.com>
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

On 08.10.2026 11:35, Dmitry Osipenko wrote:
> On 10/8/26 01:22, Dmitry Osipenko wrote:
>> The cursor blending mode was added twice because the same change was
>> applied by accident from different patches. Revert the second patch.
>>
>> Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
>> Link: https://lore.kernel.org/dri-devel/ce84d3d2-e78b-4939-aecf-9ef7267bd42a@samsung.com/
>> Fixes: 6947b78df4d2 ("drm/virtio: Add pixel blend mode property to cursor plane")
>> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
>> ---
>>  drivers/gpu/drm/virtio/virtgpu_plane.c | 13 -------------
>>  1 file changed, 13 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/virtio/virtgpu_plane.c b/drivers/gpu/drm/virtio/virtgpu_plane.c
>> index b422eba42a5f..640815af4098 100644
>> --- a/drivers/gpu/drm/virtio/virtgpu_plane.c
>> +++ b/drivers/gpu/drm/virtio/virtgpu_plane.c
>> @@ -589,7 +589,6 @@ struct drm_plane *virtio_gpu_plane_init(struct virtio_gpu_device *vgdev,
>>  	struct drm_plane *plane;
>>  	const uint32_t *formats;
>>  	int nformats;
>> -	int ret;
>>  
>>  	if (type == DRM_PLANE_TYPE_CURSOR) {
>>  		formats = virtio_gpu_cursor_formats;
>> @@ -615,17 +614,5 @@ struct drm_plane *virtio_gpu_plane_init(struct virtio_gpu_device *vgdev,
>>  		drm_plane_create_blend_mode_property(plane,
>>  						     BIT(DRM_MODE_BLEND_PREMULTI));
>>  
>> -	if (type == DRM_PLANE_TYPE_CURSOR) {
>> -		/*
>> -		 * The cursor plane exposes a format with an alpha channel,
>> -		 * which requires a blend mode property. The host blends
>> -		 * premultiplied alpha, matching the property's default.
>> -		 */
>> -		ret = drm_plane_create_blend_mode_property(plane,
>> -							   BIT(DRM_MODE_BLEND_PREMULTI));
>> -		if (ret)
>> -			return ERR_PTR(ret);
>> -	}
>> -
>>  	return plane;
>>  }
> Marek, could you please give your r-b?

Reviewed-by: Marek Szyprowski <m.szyprowski@samsung.com>

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

