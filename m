Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12561CD6E79
	for <dri-devel@archiver.kernel.org>; Tue,  9 Jun 2026 09:00:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4CABC10E1B8;
	Tue,  9 Jun 2026 09:00:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="N6weoz0q";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CFA0410E1B8
 for <dri-devel@lists.freedesktop.org>; Tue,  9 Jun 2026 08:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780995598;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:  in-reply-to:in-reply-to; 
 bh=+QgjNina6+iDumd0ZqzH0GRicPNFxNM+RIpD2R+Oo3E=;
 b=N6weoz0qOYWa5IlkouiUicpVAaMKXUSFS3SrafiTKHRGJh6XkVdehsH56m7JiNmBB8KxND
 AcdGXaQOLTXjcmjAQbOBrwPlunmOiOx7jqV/1heunqAdDk/o8G5c1A8bVsHrNQtfS7IjsV
 6hrgXQfbVtqcRXS3rIOBfCXZddW/4WE=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-NpJjPPadPQWk48LVSg2LfQ-1; Tue, 09 Jun 2026 04:59:57 -0400
X-MC-Unique: NpJjPPadPQWk48LVSg2LfQ-1
X-Mimecast-MFC-AGG-ID: NpJjPPadPQWk48LVSg2LfQ_1780995596
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-36bc5e97950so6075252a91.1
 for <dri-devel@lists.freedesktop.org>; Tue, 09 Jun 2026 01:59:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780995596; x=1781600396;
 h=content-transfer-encoding:date:message-id:subject:cc:in-reply-to:to
 :from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=QA3zW7XVHGpx2witYnUAq2WhOCFAbuZqYNTeCXGJ/sI=;
 b=iSpJyxQ6cWJexEFjfDeFR5hbXdpTQR252jWR+qcY1Hkk5gKANJxxDY0fxEWKqwy9PQ
 tXAco8eHQj29ScaLWe21pL+3FCCagWqluNtNuytZcs0kCYSk6oXnJhHCDqVemFSqINa4
 zt1NaRG9jHsVpupqkkkSiBAZUH3VV6iFsaZZUKrPA5LOtXAjWdGJfvadanmAeYTqx8iL
 5teJ6xsFeAsBOrufz33R3DOcL3IK/cO/P4Pm/f63ZDS4ibbzMhue/afABq8vwpmtOgpm
 5kBCPBEvWg5EaQ4nYWgL763hNIHFo6KiVTkTytZ9TcaZHaLum3ljVShYRZ2nZvlneX+U
 9Jsg==
X-Gm-Message-State: AOJu0Yz3x8xmpZlfRQ0PY3lk2DhGgx92ILyL3bSYUrB9SgUnFz58XhlH
 QWWfJGbOVxa1u3zEn2ug3M9h6LCZxfO3J1u7zBJa/WILN8dAZeY+WhdNKLPJ9bY11NAbMLsRTy5
 iEJwEmv8n4xiBoEKGEp38u2ZYAdPbMG4Oxsa2oHfwR1MwtQunVK+5y9CgzvAAfHhF6446Sz3kWk
 vq8GYq
X-Gm-Gg: Acq92OGaJl/Nv0h96IlVIlKU2rypx+kX3v58u16K9Z1Xb0VceUE3aL1AdrFBWcpg2Pz
 SwFhB0xSMHmWSuXLzFybmXhX2t6t2L/4F+M45rO7x3XGLy/+OtX4H6Ud+df38OzlOUzrgn8+KCp
 vlSZLuzbpmoUVlOF9u+picTYPtU3cWpdi3+S8jjw6nWbS8YspjWbg4S1/txBpbF/Rl9VjWYEQRP
 5NUjuXVR4un2anrRt9D3GsXt+FYY3lRvdkrBm+fE5CpWZWXZp/sfcWU0u+6szp1iatpi51x6hMo
 d62Bzqj3Gcp8fa7nVXFqceSMmWoO96GzkCz/6yPLlrZj5r0Ip0jF+xLDNbuGSNwQZF2hm876Fod
 I/GGroiG/HmZQojx2DOdEvEQjNkWgfcEDq7zu/2jUODjlNrayz00uHNMJ7bgsMGyqIJuBGQ==
X-Received: by 2002:a17:90b:1d89:b0:368:ea0c:1b75 with SMTP id
 98e67ed59e1d1-370ee82fe25mr20349275a91.6.1780995596320; 
 Tue, 09 Jun 2026 01:59:56 -0700 (PDT)
X-Received: by 2002:a17:90b:1d89:b0:368:ea0c:1b75 with SMTP id
 98e67ed59e1d1-370ee82fe25mr20349226a91.6.1780995595776; 
 Tue, 09 Jun 2026 01:59:55 -0700 (PDT)
Received: from ryasuoka-thinkpadx1carbongen9.tokyo.csb ([126.143.164.49])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36f6d1fec5asm18472645a91.10.2026.06.09.01.59.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 01:59:55 -0700 (PDT)
MIME-Version: 1.0
From: "Ryosuke Yasuoka" <ryasuoka@redhat.com>
To: "Dmitry Osipenko" <dmitry.osipenko@collabora.com>, 
 "David Airlie" <airlied@redhat.com>, "Gerd Hoffmann" <kraxel@redhat.com>, 
 "Gurchetan Singh" <gurchetansingh@chromium.org>, 
 "Chia-I Wu" <olvaffe@gmail.com>
In-Reply-To: <f3848234-4258-483f-bc27-cdd31f65e7aa@collabora.com>
Cc: <dri-devel@lists.freedesktop.org>, <virtualization@lists.linux.dev>, 
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] drm/virtio: Fix driver removal with disabled KMS
Message-ID: <18b75e0e21e52581.f1a5ca06374b8df6.21049e9ba3a0559d@ryasuoka-thinkpadx1carbongen9.tokyo.csb>
Date: Tue, 9 Jun 2026 08:59:52 +0000
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: G0Qim6TqNVzC5GYz9FZWFJWNkhd4fSbXKu-Vo52lEVg_1780995596
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Dmitry

On 08/06/2026 21:40, Dmitry Osipenko wrote:
> Hi,
>=20
> On 6/7/26 07:31, Ryosuke Yasuoka wrote:
>> Hi Dmitry
>>=20
>> On 04/06/2026 15:27, Dmitry Osipenko wrote:
>>> DRM atomic and modesetting aren't initialized if virtio-gpu driver buil=
t
>>> with disabled KMS, leading to access of uninitialized data on driver
>>> removal/unbinding and crashing kernel. Fix it by skipping shutting down
>>> atomic core with unavailable KMS.
>>>
>>> Fixes: 72122c69d717 ("drm/virtio: Add option to disable KMS support")
>>> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
>>> ---
>>>  drivers/gpu/drm/virtio/virtgpu_drv.c | 5 ++++-
>>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.c b/drivers/gpu/drm/vir=
tio/virtgpu_drv.c
>>> index f0fb784c0f6f..2aaa7cb08085 100644
>>> --- a/drivers/gpu/drm/virtio/virtgpu_drv.c
>>> +++ b/drivers/gpu/drm/virtio/virtgpu_drv.c
>>> @@ -138,7 +138,10 @@ static void virtio_gpu_remove(struct virtio_device=
 *vdev)
>>> =20
>>>  =09virtio_gpu_release_vqs(dev);
>>>  =09drm_dev_unplug(dev);
>>> -=09drm_atomic_helper_shutdown(dev);
>>> +
>>> +=09if (drm_core_check_feature(dev, DRIVER_ATOMIC))
>>> +=09=09drm_atomic_helper_shutdown(dev);
>>> +
>>>  =09virtio_gpu_deinit(dev);
>>>  =09drm_dev_put(dev);
>>>  }
>>=20
>> The patch looks good to me at a glance. I haven't done a full, deep code
>> review yet, but I've tested it on my lab and everything works as
>> expected.
>>=20
>> Tested-by: Ryosuke Yasuoka <ryasuoka@redhat.com>
>=20
> Thanks a lot for the testing. The review from you will be very welcomed
> too.

I reviewed your patch and this change looks good to me.

Reviewed-by: Ryosuke Yasuoka <ryasuoka@redhat.com>

Thank you!
Ryosuke

