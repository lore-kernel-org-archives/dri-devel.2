Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 612D8CA601F
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 11:04:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C23C4112061;
	Fri,  9 Oct 2026 11:04:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="BLuUpfUa";
	dkim-atps=neutral
Received: from sender5-op-o11.zoho.com (sender5-op-o11.zoho.com
 [165.173.182.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C3E7112059
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 11:04:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1791543825; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Lbu7mK3foQG91+/R97L5K3gl0S+EiTPMKu86RBiU0Erh8Tv0ql4kROEDY8JyOxTIILTM8kFcEeZyoqU0zpi1RPy3X5jc7vVbdZGAakDi9vAGEp0UaDC1QpPLxfCTR9pu383VjGB+H+LJxVYhI6o8QuSUwhymLLHMfLaZ3/R+HhY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1791543825;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=6VeP7OZP4fl2d+SeH1xW2SsZlw8sptiCYA73mXgU3+4=; 
 b=ltMAs8NoqJEdBg3T7a0XNhKkosbScEDNPOwv1Mw7jXibNkhyTAtDIG42XieJPHqdkScN3w6mBEBxVPqtvfQzPomUM2oUh1to8dKXhCzi6HfjPDzWKGs822rf1b0wRESu/dcJnBChtn8ZL51ETey9ABO/BGabRvXSm4p3SlhDacQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1791543825; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=6VeP7OZP4fl2d+SeH1xW2SsZlw8sptiCYA73mXgU3+4=;
 b=BLuUpfUa9jBAe949z8Z72+OF92L43TUHquroQh8Oo3SB2jPrRId9pMF9RI6AQM42
 zmY6UcREMFw9j0gTkjt/IEbMggXDyo6hqIdXEC/JBkkch9sZP2cDy+xBYUT6ugturCJ
 s9UXcjlAqMkifngnvB+67Jhr8dXkS8Obz5TAP+es=
Received: by smtp.zohomail.com with SMTPS id 1791543824599306.9382623529217;
 Fri, 9 Oct 2026 04:03:44 -0700 (PDT)
Message-ID: <8c0920fc-2f3f-425a-84d8-2aa701cb2388@collabora.com>
Date: Fri, 9 Oct 2026 14:03:39 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/virtio: do not enforce blob_alignment in
 cross-domain contexts
To: Val Packett <val@invisiblethingslab.com>,
 David Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu
 <olvaffe@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Simona Vetter <simona@ffwll.ch>, Sergio Lopez <slp@redhat.com>
Cc: dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20261006154913.2689067-2-val@invisiblethingslab.com>
 <8b0fbe1a-1410-42d7-8031-611795ae39d9@collabora.com>
 <4d86ec37-ce27-4556-966e-4b4e80ec0718@invisiblethingslab.com>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <4d86ec37-ce27-4556-966e-4b4e80ec0718@invisiblethingslab.com>
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

On 10/8/26 23:59, Val Packett wrote:
> 
> On 10/8/26 4:33 AM, Dmitry Osipenko wrote:
>> On 10/6/26 18:42, Val Packett wrote:
>>> VIRTIO_GPU_F_BLOB_ALIGNMENT is designed for GPU rendering context types,
>>> however VIRTIO_GPU_CAPSET_CROSS_DOMAIN is not one of those. Resources
>>> created under cross-domain contexts are arbitrary shared system memory
>>> files, which includes unusual things like Wayland keymaps received
>>> from the host compositor. Do not enforce alignment requirements there.
>>>
>>> Fixes: 47248e0d8264 ("drm/virtio: honor blob_alignment requirements")
>>> Signed-off-by: Val Packett <val@invisiblethingslab.com>
>>> ---
>>>
>>> v2: also check has_virgl_3d to prevent dereferencing NULL vfpriv
>>> v1: https://lore.kernel.org/all/20261006004044.2242154-1-
>>> val@invisiblethingslab.com/
>>>
>>> ~val
>>>
>>> ---
>>>   drivers/gpu/drm/virtio/virtgpu_ioctl.c | 4 +++-
>>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/
>>> drm/virtio/virtgpu_ioctl.c
>>> index 3ddd5481d6bc..4d5ae062834d 100644
>>> --- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
>>> +++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
>>> @@ -551,7 +551,9 @@ static int verify_blob(struct virtio_gpu_device
>>> *vgdev,
>>>       params->blob_flags = rc_blob->blob_flags;
>>>       params->blob_hints = rc_blob->blob_hints;
>>>   -    if (vgdev->has_blob_alignment &&
>>> +    if (vgdev->has_blob_alignment && vgdev->has_virgl_3d &&
>>> +        (vfpriv->context_init &
>>> VIRTIO_GPU_CONTEXT_INIT_CAPSET_ID_MASK) !=
>>> +        VIRTIO_GPU_CAPSET_CROSS_DOMAIN &&
>>>           !IS_ALIGNED(params->size, vgdev->blob_alignment))
>>>           return -EINVAL;
>>>   
>> What userspace has this problem and why it re-purposes virtio-gpu to act
>> as udmabuf for arbitrary data that never reaches host?
> 
> Sorry, what do you mean by that?
> 
> This is not related to data that "never reaches host" at all! The error
> I referred to in the patch message literally says "received *from* the
> host"…??
> 
> Guest userspace is any of the cross-domain proxies:
> 
> * https://codeberg.org/drakulix/wl-cross-domain-proxy
> * https://github.com/talex5/wayland-proxy-virtwl
> * https://github.com/google/sommelier-rs (or old C++ version)
> 
> VIRTIO_GPU_CAPSET_CROSS_DOMAIN "repurposes virtio-gpu" to act as a
> cross-VM UNIX socket transport that supports fd passing. By referring to
> virtio-gpu resources in the send command the guest can make the device
> send the resources' corresponding host fds to the host Wayland
> compositor. It can refer to resources from other contexts, in order to
> present drm/venus/etc rendered buffers on Wayland surfaces. (i.e. the
> host would send the actual dma-buf from virglrenderer) But the resources
> created on the cross-domain context itself are system memory buffers,
> generally used for software rendering and miscellaneous Wayland "stuff"
> like keymaps which are sent *from* the host, and exposed to Wayland
> clients in the guest. Socket receive handling in rutabaga-gfx stores
> incoming fds and returns their IDs to the guest, then the guest does a
> CREATE_BLOB with matching blob_id, which creates a virtio-gpu resource
> from the incoming buffer, so the guest can just MAP_BLOB it. These are
> the blobs that are not aligned to anything because they're just
> arbitrary memfds on the host.

Blob is a chunk of memory intended to be shared between host and guest.

The shared mappable buffer size must be aligned to a page size
granularity that satisfies both host and guest requirement.

If I'm now reading correctly, you're saying that here blob size is
arbitrary payload data size, even not the the aligned size of memory
blob that contains payload. And userspace code implicitly relies on
kernel to round-up payload size to a guest's page size.

We now have blob_alignment and verifying the unaligned params->size.
Given the userspace dependency on the kernel's implicit round-up, we
should be checking blob_alignment of the rounded-up params->size:

+	if (*guest_blob)
+		params->size = roundup(params->size, PAGE_SIZE);

	if (vgdev->has_blob_alignment &&
	    !IS_ALIGNED(params->size, vgdev->blob_alignment))
		return -EINVAL;

Does it work for you?

-- 
Best regards,
Dmitry
