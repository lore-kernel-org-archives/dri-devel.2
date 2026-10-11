Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C958CA9EC7
	for <dri-devel@archiver.kernel.org>; Sun, 11 Oct 2026 04:24:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F43110E2C4;
	Sun, 11 Oct 2026 04:24:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hBX/cW6h";
	dkim-atps=neutral
Received: from mail-lr2-f10.google.com (mail-lr2-f10.google.com
 [74.125.230.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9480210E2A2
 for <dri-devel@lists.freedesktop.org>; Sun, 11 Oct 2026 04:24:21 +0000 (UTC)
Received: by mail-lr2-f10.google.com with SMTP id
 38308e7fff4ca-3a7f674d148so7788101fa.1
 for <dri-devel@lists.freedesktop.org>; Sat, 10 Oct 2026 21:24:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791692660; cv=none;
 d=google.com; s=arc-20260327;
 b=X4tja6QR+QT+CbGMP6LnkDyk7H+03liiF8rSa6YL+Nj/DE3aiyIUEGsItPn6LoFKgt
 U2V639Xnc13sU9ojpSIh2ymbObshmdb4Q7/nm8VjP6iiRt1X2L+ygIVuQahRMKIQJmzp
 1OnvpQ8V7NeXXgXJRei/X/Yvf8Ek2NSlN6RK+wumBj/3z8lnVccpsCyUZa2rbnRHJ7SO
 Pjpe6NROA32nCiUQpuuOYkvhmsgIue4X5uepAur+RI4/4cvuL6Vm5Z5dveObIZWmmKPW
 cvJnbOSfSxTA7z/ay+vWd3vVpr/8v0w9SIdrdt0JvNvyMLxpyUWdAXjVdNthekcpSmrJ
 7/UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=VhZc0ul596MdstjFona8ML1ytD+B6YUHJy1OvUi+4LI=;
 fh=vxTpDn6kAMjt/zGFUZovke2YEywiljOLwHVIFSSslT4=;
 b=HFIsya7JJOOJMZQSbT24xI/fS7wFKA7080GcnAeAnTciiY37826PZha9QY/TTWC2zs
 u5T3dh0ubJ9Hz8+RnfLHxYWwm3OeAAL4BGjrOEbdpf5e8OHjEMa7ON/a9rhMbwjIjQxr
 hWKJMYcsvLxt7Y+24tj85Wt7VIr5nfqp6sZjHwW51iOxiCsc2ZSq9+Q9jEI65HHFU07n
 pFREpJEJYY4eYmIPuqzGM4uuTgAcWJ6xgm/pwJA99XxA7VJ9DYwNcCPq4wEgNspEb9nb
 p2xrFmxUCwDzJlbWCibu4ICTp/2HRfqRapvKX79R3khg+a5mRcJfHnMVQVToghCTUeS4
 dLZw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791692660; x=1792297460; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=VhZc0ul596MdstjFona8ML1ytD+B6YUHJy1OvUi+4LI=;
 b=hBX/cW6h1NIRv4fyNOR2eUWoN0d3/JFsDSVQZX7IrBPsOLSEpY81IL5I/ufJk5zsuR
 /tCEt5RMLit+WbN28F1BqHSLnsKuZThiDoI8WEWo82UqnIWiGUim6cr6c0w56G5C5REr
 5uFnRAkOhXvDZupKcSrMw4ROfYEbp5TP9JSt0azofqez0BwtjvPJ8FlZiKrEryZpbXoO
 LVV5meJ8AHQer30QFtz6Nze0NGzMi6inAUFbhpeKTQaq4+QQ7mABfGbCqlrZrWAiofM3
 o7b+BTA2PmYpanCjXblCLUfyLK4QwMJNqXbccVmQxsK/7LgkrnHUZs2PBvF1jFouO9KN
 go7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791692660; x=1792297460;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=VhZc0ul596MdstjFona8ML1ytD+B6YUHJy1OvUi+4LI=;
 b=u2SB5rzNeAOfSA4UDLTodQKWFUlnnBhfj4kY3j6vP6PiN0unV22XM6Q82ioO0h+T7K
 zVKgH+crePTDB/7tqM3AodHT2DkIXSvwJ/nUcODQCnbuleM5eC6BLQB0B4BRECQF0OMA
 YdOGNIT9OzQ2fjyG3mwfIqQYWFFJwrpIjgRf/qiox9fArEZ90WomLwxZSaaARXBpyUD6
 0IPzZNiVguMYHSDcwVAgikfogmlH5mvuyD0axfnLd5XCpYD1q0zPe2ON1I9L6F+gXJ2z
 KGkzMXIMEfiC6WZn+AJ3S6ux8WA0MTYwLP8fiRf70x+a2VXXCkFpW8Wb5/cBD25pZhpw
 UZ/Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBzzr8IGN9ZCCajb2J/i/Ob4SzAnwCJxM+ldhVT1bpRqZjHwQw7IfF9ZArV4C5FaaOfnxxKzxHVCPIs=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJhN/nTjVRpF5p54kodirYpjobtzz2/ptssnFZIQ3ZSF8BD/ynY
 FOtcTUQ93rOOhWGvfuFqdrj3dZV8F/JE/Ot1Fjb4DNtalmfc8kG2huHKakiqZGRBES3PAdk8gv+
 qs9SNJtvUosSER4JLc3J4R0xA/Vi9IBQ=
X-Gm-Gg: AYBFou1/UBnCH1Amx+GAMao4k+xrTuzGV7Ydfb1hlGzQPeHflahHr2iiuM7j3aNIFqA
 BK3VG8RrhiEIfyfDNEkiB9RFY7D7PsY/Ixiq7cuORt8jVsE/ZPQmExXCg2RIRNZ0gMOgHQ6mfkU
 2yKNFvGZHRX+8mZaW3LuOMjOOU234hHur9fJdkcgc86XnFWpRJMo9SI/G/rxhsBwTXoLHCqaepr
 SBaYGdMol38ZLI324xCkQ9uZuj1qrUS8B3GpbTEFNxgUUDi/QbQqA/tseWAE8qrbYbm9K31JQXq
 P8xG9hYjs8BlCS69OeE0B9xxHE7NGGUtQi93J2PVZQ0xqbKlu2+4KuCN
X-Received: by 2002:a05:651c:b27:b0:3a9:9b0b:b789 with SMTP id
 38308e7fff4ca-3a9c4ebac3bmr15900241fa.3.1791692659381; Sat, 10 Oct 2026
 21:24:19 -0700 (PDT)
MIME-Version: 1.0
References: <20261010081059.3096312-1-bsdhenrymartin@gmail.com>
 <8393a8a2-2ed5-4d63-b937-5d837c1bb1aa@collabora.com>
In-Reply-To: <8393a8a2-2ed5-4d63-b937-5d837c1bb1aa@collabora.com>
From: henry martin <bsdhenrymartin@gmail.com>
Date: Sun, 11 Oct 2026 12:24:10 +0800
X-Gm-Features: AclHuK-BTl_lG-VGVrLo4m7etjeQVOp6O1v4a1N4RBOkp9wdRCffIEeVjuhsxU0
Message-ID: <CAEnQdOovxVfYAyiEZ8nJM-DXe=r6apYkfmpJJUNx6CJbg61_-w@mail.gmail.com>
Subject: Re: [PATCH] drm/virtio: reject mappable HOST3D blobs without
 host-visible memory
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: David Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Chia-I Wu <olvaffe@gmail.com>, 
 Gurchetan Singh <gurchetansingh@chromium.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, Simona Vetter <simona@ffwll.ch>, 
 Junrui Luo <moonafterrain@outlook.com>, dri-devel@lists.freedesktop.org, 
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
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

Hi Dmitry,

You're right, thanks for catching this.  bo->created is set
synchronously in virtio_gpu_cmd_resource_create_blob(), so the
unmap/unref completion chain (cmd_unref_cb -> cleanup_object)
releases everything once the host acks.  The leak I described does
not exist - please drop the patch.

Sorry for the noise.

Regards,
Henry

Dmitry Osipenko <dmitry.osipenko@collabora.com> =E4=BA=8E2026=E5=B9=B410=E6=
=9C=8811=E6=97=A5=E5=91=A8=E6=97=A5 04:19=E5=86=99=E9=81=93=EF=BC=9A
>
> On 10/10/26 11:10, Henry Martin wrote:
> > virtio_gpu_resource_create_blob_ioctl() -> verify_blob() validates
> > blob flags, memory type, context and alignment, but never checks
> > VIRTGPU_BLOB_FLAG_USE_MAPPABLE against vgdev->has_host_visible.
> >
> > For blob_mem =3D=3D VIRTGPU_BLOB_MEM_HOST3D the blob is created via
> > virtio_gpu_vram_create(), and on a device without host-visible
> > memory (plain virtio-gpu-pci,blob=3Don with no hostmem) the failure
> > comes too late: the GEM object has been allocated, a host resource
> > id taken and the create_blob command issued when
> > virtio_gpu_vram_map() returns -EINVAL, and the cleanup calls
> > virtio_gpu_vram_free(), which is a no-op while bo->created is still
> > false (the host response has not been processed yet).  Every such
>
> virtio_gpu_cmd_resource_create_blob() is invoked before
> virtio_gpu_vram_map() in virtio_gpu_vram_create(), hence bo->created is
> always true, how come it's false?
>
> --
> Best regards,
> Dmitry
