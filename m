Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA4ACC5DF81
	for <dri-devel@archiver.kernel.org>; Tue, 18 Aug 2026 19:10:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 166E810E047;
	Tue, 18 Aug 2026 19:10:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="FhoRbbHH";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 49A7710E047
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 19:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787080235;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1C21gLMhd/u+qmfcqS0pqk/SXD/LCoXj54HlBv66NyA=;
 b=FhoRbbHHplQxPysKKhaTY0CzxnwxJaMXnzc0wevDSi5byQevQx6kmBEaFdmCGowUNQdRYR
 qDP6ANznthyc6EiRNAPvhbp0cbIlyzMVUNcBf9VNFx9B09mX1tx2irwEVeZKTpuQZKXEEJ
 an5FcWIFG/vFANqrZiV+/ABMD3oQR8w=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-9Ph2Vv8UPYKwAs7I4udn-Q-1; Tue, 18 Aug 2026 15:10:34 -0400
X-MC-Unique: 9Ph2Vv8UPYKwAs7I4udn-Q-1
X-Mimecast-MFC-AGG-ID: 9Ph2Vv8UPYKwAs7I4udn-Q_1787080234
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-52b4f6ac06aso2666161cf.1
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 12:10:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787080233; x=1787685033;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=9kbwhzYfa9+JR+FXCNWXDj5upifP6ZSYoTxSiBsZODs=;
 b=XmcqObKTV0GdAFGO1wYkZLEzGZjCCIot5m3T/mf2sha226rvjwSvgonlDZEOZSnuFl
 aomfTophFVpK26wteC2OaIeelEYlq94Srl4gmISrdHFlF867lp7UVlm2m08MT9unwj/x
 jhvJ8O3hljC6gzCOO6d1a4t2nLVzxbOA5vOj7cMHdzwcpWd72osybvEfQwEIVE51oCQg
 Q1owhaPYeywAFj9XfA6yo+u/cyffnY+3l6kNZ2U1kokBFy3ccImm6WNOWqyLPQKOvi7U
 QUpz5i7WSPpmgi5qRwyieyLbevWwMf20IhhPCYMnPTmqRPa8Rmwxb4lmZKx/zBW3BxMR
 2fQw==
X-Gm-Message-State: AOJu0YwwaFG9JTZL03Xm0CDQAm9/O9g0iTqjxW8pDw+4sv/Wl6ErBcfx
 y2VrcBaYJMXsNic0Hvp4gVgbeBn/8i2vRm5mxVrnmOO9T0czJtM2ua4B0zT8rCGlCx5M0EIggWs
 u5t23XxzBYe1y6s7mnFg+EVmRGrTW5UnyjK0h2paH7sgBvpL6/ZmKQ26QdXDA44DG7H+YYA==
X-Gm-Gg: AR+sD10dbwB6OMRQFvVgsN/z6imlJOk5p+llOraeqLnckhcEts1xkTO/Gl60lVLYuuJ
 kmv+WpglTJOcxIZc7iWTbLkemBFnh3EV1VXWyOihkO7xrgS9X9+LrobdSstRXEyRl3ns54JfNJJ
 rJT/QfKm2c7hbMdMlkC6OBzkn0XgnCUQI6SKA1pRWJVvpTjVqMNdB1E0JEtFZWvBWxHsVyHZ7Vi
 CNCOc645bcNG9W4UHvK6fcaA95OI5XFCiZCfVzuHXcU7FfJ9nSLKc7ZGdoKpRIDMbnlzMUeCzMJ
 A/QB5F41wTzd9TewC1MidapX+s24KEc7pF9JECIdUHDAtrlOPWD9LZI7A+ieMrVWgmp+UuHF
X-Received: by 2002:ac8:5749:0:b0:52b:4e1f:941d with SMTP id
 d75a77b69052e-52dd30d0802mr3569301cf.6.1787080233479; 
 Tue, 18 Aug 2026 12:10:33 -0700 (PDT)
X-Received: by 2002:ac8:5749:0:b0:52b:4e1f:941d with SMTP id
 d75a77b69052e-52dd30d0802mr3568331cf.6.1787080232870; 
 Tue, 18 Aug 2026 12:10:32 -0700 (PDT)
Received: from [192.168.8.4] ([100.0.180.93]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-52db623bfb0sm44781051cf.24.2026.08.18.12.10.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 12:10:31 -0700 (PDT)
Message-ID: <7ba5804dccefb1fde985f19242f6bad94aaefcc8.camel@redhat.com>
Subject: Re: [PATCH] drm/nouveau: reject zero-size notifier object allocation
From: lyude@redhat.com
To: Zhenhao Wan <whi4ed0g@gmail.com>, Danilo Krummrich <dakr@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann	 <tzimmermann@suse.de>, David
 Airlie <airlied@gmail.com>, Simona Vetter	 <simona@ffwll.ch>, Ben Skeggs
 <bskeggs@redhat.com>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Yuhao Jiang <danisjiang@gmail.com>, 
 stable@vger.kernel.org
Date: Tue, 18 Aug 2026 15:10:30 -0400
In-Reply-To: <20260813-nouveau-abi16-notifierobj-zero-size-v1-1-20dee38077cb@gmail.com>
References: <20260813-nouveau-abi16-notifierobj-zero-size-v1-1-20dee38077cb@gmail.com>
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: wRzXyfqYf3wrN8pMSZAj_io-qxE3Q9mlWIVxUci5t_4_1787080234
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
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

Reviewed-by: Lyude Paul <lyude@redhat.com>

Will push to drm-misc-fixes in a moment

On Thu, 2026-08-13 at 21:14 +0800, Zhenhao Wan wrote:
> nouveau_abi16_ioctl_notifierobj_alloc() passes the userspace-
> controlled
> info->size to nvkm_mm_head() as both size_max and size_min without a
> lower
> bound.=C2=A0 A zero size satisfies the allocator's "e - s < size_min" gat=
e
> (size_min =3D=3D 0 makes the unsigned comparison inert) and yields a
> zero-length node, after which
>=20
> =09args.limit =3D ntfy->node->offset + ntfy->node->length - 1;
>=20
> underflows (offset 0, length 0 -> 0xffffffff) into an oversized ~4
> GiB DMA
> window.=C2=A0 The dma object constructor only rejects start > limit, so
> the
> validly ordered [base, base + 0xffffffff] range passes and is
> programmed
> into the GPU DMA context.=C2=A0 The ioctl is DRM_RENDER_ALLOW, so any
> render
> node client can trigger this on pre-Fermi hardware.
>=20
> Reject a zero-size request before allocating anything.
>=20
> Fixes: ebb945a94bba ("drm/nouveau: port all engines to new engine
> module format")
> Reported-by: Yuhao Jiang <danisjiang@gmail.com>
> Assisted-by: Claude:claude-opus-5
> Cc: stable@vger.kernel.org
> Signed-off-by: Zhenhao Wan <whi4ed0g@gmail.com>
> ---
> =C2=A0drivers/gpu/drm/nouveau/nouveau_abi16.c | 4 ++++
> =C2=A01 file changed, 4 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/nouveau/nouveau_abi16.c
> b/drivers/gpu/drm/nouveau/nouveau_abi16.c
> index 291203121f0c..8d139bbb2934 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_abi16.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_abi16.c
> @@ -660,6 +660,10 @@
> nouveau_abi16_ioctl_notifierobj_alloc(ABI16_IOCTL_ARGS)
> =C2=A0=09if (unlikely(device->info.family >=3D
> NV_DEVICE_INFO_V0_FERMI))
> =C2=A0=09=09return nouveau_abi16_put(abi16, -EINVAL);
> =C2=A0
> +=09/* zero size yields a zero-length node, underflowing
> args.limit */
> +=09if (unlikely(!info->size))
> +=09=09return nouveau_abi16_put(abi16, -EINVAL);
> +
> =C2=A0=09chan =3D nouveau_abi16_chan(abi16, info->channel);
> =C2=A0=09if (!chan)
> =C2=A0=09=09return nouveau_abi16_put(abi16, -ENOENT);
>=20
> ---
> base-commit: db2ddb87143519e20a95aa36c60b36107b736a58
> change-id: 20260813-nouveau-abi16-notifierobj-zero-size-5d3888d36b57
>=20
> Best regards,
> --=C2=A0=20
> Zhenhao Wan <whi4ed0g@gmail.com>

