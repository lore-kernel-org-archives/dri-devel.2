Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFAA3C43458
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 14:35:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E5BE10E607;
	Mon, 13 Jul 2026 14:35:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="RwiSmt3s";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E831310E607
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 14:35:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1783953305; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=dtfwBb+KkqOk5LpS2l9XlY3Isr1cxSe4dyVL5LXR69Z6z6hzhLsQ+m6Y07qIuIS17sSwr/D1yxn8TWV+QxTy+IEpOglvePnj0u4uFfbxnFlGvGP47m7Zh8XlFdGD16tH+rePIikamDkj4VIfT8R2rq6qJTDeJR326ZA2cEPI4NY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1783953305;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=Vt1ZxcDLSY0cCHvqeRxZcHXVOfGIWEo70HQ03fVvYCk=; 
 b=AZGK5fCQYa6tk1H3Pvcm2xHvlkrhJVTPa6lPPkmtVxgW7BF3flDk03kkiXBIhXGeUtMRAEUQ31Ob3E6R+nWqHpSdHGCOOE78jDhBVuGdCgJCAYu95nz6y2JMJQGRUV6kyD/qc73/yGJZc1h/ZD6pvxUOUx/BlX8newOkg7nomNU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1783953305; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=Vt1ZxcDLSY0cCHvqeRxZcHXVOfGIWEo70HQ03fVvYCk=;
 b=RwiSmt3sorWaCVeer9aJuDH1LQXVyb8VzjGjVaZRnlvjljD7nuGEpWPmc0eghmr6
 lmq2S6EmbamoRtgkK5hOhDRw19S2OOCZ8KX/fO1/q7FhSxsBAvdb2IgxcxoxW67tRHD
 hNpOiW12cxCm3iFze3vOjlv1rxrFCwCsOx1ELd4g=
Received: by mx.zohomail.com with SMTPS id 1783953303349476.0443516936738;
 Mon, 13 Jul 2026 07:35:03 -0700 (PDT)
Message-ID: <17764937-21dc-4b4a-8def-e738b361bcd1@collabora.com>
Date: Mon, 13 Jul 2026 17:34:56 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] drm/virtio: honor blob_alignment requirements
To: Alyssa Ross <hi@alyssa.is>, Sergio Lopez <slp@redhat.com>,
 Yiwei Zhang <zzyiwei@chromium.org>, Sergi Blanch Torne
 <sergi@collabora.com>, Valentine Burley <valentine.burley@collabora.com>
Cc: Chia-I Wu <olvaffe@gmail.com>, Jason Wang <jasowang@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 linux-kernel@vger.kernel.org, Simona Vetter <simona@ffwll.ch>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@redhat.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>,
 Gerd Hoffmann <kraxel@redhat.com>, virtualization@lists.linux.dev,
 dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
References: <20260428194450.518296-1-slp@redhat.com>
 <20260428194450.518296-3-slp@redhat.com> <akT1XEW766c7Imst@mbp.qyliss.net>
 <c8bf0c19-316a-442e-a63e-1b52e7bb67c2@collabora.com>
 <87v7ajyw5j.fsf@alyssa.is>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <87v7ajyw5j.fsf@alyssa.is>
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

On 7/13/26 14:19, Alyssa Ross wrote:
> Dmitry Osipenko <dmitry.osipenko@collabora.com> writes:
> 
>> On 7/1/26 14:10, Alyssa Ross wrote:
>>> On Tue, Apr 28, 2026 at 09:44:49PM +0200, Sergio Lopez wrote:
>>>> If VIRTIO_GPU_F_BLOB_ALIGNMENT has been negotiated, blob size must be
>>>> aligned to blob_alignment. Validate this in verify_blob() so that
>>>> invalid requests are rejected early.
>>>>
>>>> Signed-off-by: Sergio Lopez <slp@redhat.com>
>>>
>>> FYI: this change breaks crosvm, which is squatting the 5 and 6 values
>>> of VIRTIO_GPU_F_* with different meanings.  I've reported it as a
>>> crosvm bug, so hopefully it can be taken care of there.
>>>
>>> https://issuetracker.google.com/issues/529852979
>>>
>>>> ---
>>>>  drivers/gpu/drm/virtio/virtgpu_ioctl.c | 5 +++++
>>>>  1 file changed, 5 insertions(+)
>>>>
>>>> diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
>>>> index c33c057365f8..d0c4edf1eaf4 100644
>>>> --- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
>>>> +++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
>>>> @@ -489,6 +489,11 @@ static int verify_blob(struct virtio_gpu_device *vgdev,
>>>>  	params->size = rc_blob->size;
>>>>  	params->blob = true;
>>>>  	params->blob_flags = rc_blob->blob_flags;
>>>> +
>>>> +	if (vgdev->has_blob_alignment &&
>>>> +	    !IS_ALIGNED(params->size, vgdev->blob_alignment))
>>>> +		return -EINVAL;
>>>> +
>>>>  	return 0;
>>>>  }
>>>>
>>>> --
>>>> 2.53.0
>>>>
>>
>> Thanks for the report. Indeed, crosvm will need to fix its experimental
>> caps. CI will likely run into this problem first once it will update
>> guest to 7.2+ kernel.
> 
> I sent
> https://chromium-review.googlesource.com/c/crosvm/crosvm/+/8064741 last
> week but still waiting to hear anything.  Do you have any insight into
> whether it's still used / being pursued?

The GUEST_HANDLE should be used by Android [1]. The FENCE_PASSING
shouldn't be used in production, though don't know for sure.

Crosvm should bump its experimental defines by +10 to prevent clash with
upstream in future.

[1]
https://github.com/google/gfxstream/blob/main/host/vulkan/vk_decoder_global_state.cpp#L107

-- 
Best regards,
Dmitry
