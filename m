Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7092BC43458
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 04:56:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C6C6410E438;
	Thu,  2 Jul 2026 04:56:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="rn3T1N+O";
	dkim-atps=neutral
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com
 [209.85.167.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 636CC10E438
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Jul 2026 04:56:55 +0000 (UTC)
Received: by mail-lf1-f54.google.com with SMTP id
 2adb3069b0e04-5aeb688ae83so19476e87.1
 for <dri-devel@lists.freedesktop.org>; Wed, 01 Jul 2026 21:56:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782968213; cv=none;
 d=google.com; s=arc-20260327;
 b=VLyPpE0tm2AJctvn2VeE0czX1xHWyaO/YykMtu565AqjUWHyHNtotegZAcIbCdslPg
 16+an7+C7aM27DBBkMbUJ5/Jlp1OpUM7kLh96SdLHEMDngBElVyoKBGDbkPZN/nVR1uI
 GFYPe8ix/I5glfKlZU1mRV4DqnKZulBcfHSrovWP7pcjoW9X/pWL6E4CxN7/IiIM0bmd
 3F/Uf3XU84DOJOoy6gEMpSCXSghKNnUz8Fps6XZKQqlhz5VbyNCpuv3VhVS5ycGI7bI5
 2I1cqYxM05L0nHXFJaDDucOR1imHkzWcBt9VgmTOBzXiXP32VMO2oZ3x8lZoEPM5/9SL
 6kXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=R/pb0b0doa3XFteGoKySEQfP8Mo6hx3U4+0voSqDAH0=;
 fh=e77c4EZoAU6Z7VRD9T4RU7PbLzNGzL+iO7RlESPVLGU=;
 b=EJ76kx+Sr2OcWe50/X+VnpPShwzjulwcGiDAYTpRYsY/p9T6rt5CuM6OJPi8tWXQ58
 AxKyXdF0nvdndZ0VGbJJ7MP19aq/heR+tVrFyRoS5Zkv96p+rt7+hGd5r0iPxTrzf4EP
 uiu67vTz9+9mWOVJ3UG1b/GZzjEcq41uZJ/oPrqk94Qicinos5COOz3INLOu6DtSjV4Y
 8NskSmK9QSAL7RV3CKiiJn69KDoWfYWfvqtFxq6GaSzNP/Q8WRYTqo8zRFmCsm0CPhaC
 AEh6agBi0zeBMOLM3BhFoOkazBIx0VXWyk5kzyctS8CdmhgelwfEuEkljPX3cGbbBEZ9
 0W5A==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1782968213; x=1783573013;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=R/pb0b0doa3XFteGoKySEQfP8Mo6hx3U4+0voSqDAH0=;
 b=rn3T1N+OTLl1uiZtLVx3IRvPCaQAKL9alYl9nhv8MJmHOY2iZ/4yYaajzm1eOt42lx
 LbsPzhlnwmXGm/g5x012yub54nh8dNZqzLumBAGsRm1lhPhcKRrXrLNHhcfkOtd/2KoU
 i+nQPDflZwrWOU0XQ/aMNEdOXdK1IdjFpRhlK9d3qG0QhhXdAS65Z+6LBYsljvrYztiB
 +pejYwR/NDyj7zQdoof+5UZE3LijfcvkEDBzM6DoJ4wCei1wmMhCHEQiyafKddz0uvty
 qlqWmn9r7ecxuAUyQWZjvtJBgfy0+4orNW+tGUoH6iZabUfPuEAun6qaYL4yH/ld+cOa
 sYfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782968213; x=1783573013;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=R/pb0b0doa3XFteGoKySEQfP8Mo6hx3U4+0voSqDAH0=;
 b=YkS0NKWxGh/bnDAAexq2kj858kpul6LPmGQw6ic0PbEx7DGGLg7ibla7EfzAZyPxmC
 ImpWZXQsFITCZDQI268kYtGYwfukcDTOMsuKnpHbb7CMNsCKQRG5MTjUfN7n3ArzAv8N
 pmG4SD3xVxCo/x2xpwD3HCGm+EJNaa9lCCdTpKHnuLjIJyuiEisC2/tb3JoddDP6QcLX
 hlM13Xag0c+J7IR+xvtib4DwKG+NvRMKjcpo2xslxvN4XU3Qnx2oofzgw076hLhXBS1s
 bXn2IU6ftggbw56KF3HogXjs7fcQZWDhmcm8YW7Tp6MR+a/ojhPT7zHIx1YJ8i86Nvwd
 Iztw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrKV8dyhjtJDX9widqLA4IlpxCj1L5rNfLSNlhsckJtxB7caMoA5LHwDK9aRsPO/Y3P1aIlh9/viq8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YynVWfgh84YA4EZgr0KYmuF13twz8Tq44013UWL+JIbBt9p9lyD
 jleYqkEX0G5kg5yzEvlk65UeKWMn/KAn2OG28ZHcX1tpiB7Uu+3hyMYQ309nIZmDO/vwT0GQCr8
 i0hKJ5f2IFj34NeHiRXlbZHvUK8w6in8XdRRKc7A=
X-Gm-Gg: AfdE7ckmTkQoN8Kq8o56rKyIhbOomXKgbe0yl6ynVHsi1jMZcW+r9Ji6CKTJEmddAru
 oQEV4+iozvhzVNZcClPuRtAB9WXaQjP7aUBMFWOCVR30pMBmzNzqh6040jkO29i0uTKZs51Ky0P
 n0fpLQsFZKn/4C+nlQZdZC95E7JFep1NN37WnUzmt6kYbX+KDYrKAz+3ivgOGUDE1qai+D3WBod
 fmddPA3vIjWzg3BFYQXcu2Vpjby1aYwk6vc4470YSzz+RRb+HBEnonfzUAhaiYOHNX1FoSo5C3E
 QnKvFmhAi/uFe/LkyBDAZf6PPmk/6g==
X-Received: by 2002:a05:6512:2243:b0:5ae:b843:9470 with SMTP id
 2adb3069b0e04-5aecc237a55mr33635e87.5.1782968212825; Wed, 01 Jul 2026
 21:56:52 -0700 (PDT)
MIME-Version: 1.0
References: <20260621222130.1667453-1-xuehaohu@google.com>
 <20260623015459.1153884-1-xuehaohu@google.com>
 <20260623094446.4a8fc2ed@pumpkin> <ajryxMaT5evDUxaq@google.com>
 <20260623235350.6540eaa2@pumpkin> <20260630124252.GD7525@ziepe.ca>
In-Reply-To: <20260630124252.GD7525@ziepe.ca>
From: David Hu <xuehaohu@google.com>
Date: Thu, 2 Jul 2026 00:56:40 -0400
X-Gm-Features: AVVi8CdtQ5k1Gu0I7l3KP5nC_hRlM4qrUkGZrb3FkW53eA2H-q-z2clu4KZkrHc
Message-ID: <CAPd9Lg9uY1RZvYUtcbKUg=VdWM61M2f3aqmS5veUg_8M_Ce80g@mail.gmail.com>
Subject: Re: [PATCH v2] dma-buf: Split sgl into page-aligned 2G chunks
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: David Laight <david.laight.linux@gmail.com>,
 Pranjal Shrivastava <praan@google.com>, 
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Nicolin Chen <nicolinc@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Kevin Tian <kevin.tian@intel.com>, 
 Ankit Agrawal <ankita@nvidia.com>, Alex Williamson <alex@shazbot.org>,
 linux-media@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev, jmoroni@google.com, 
 kpberry@google.com, chriscli@google.com, sashiko-bot@kernel.org, 
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

On Tue, Jun 30, 2026 at 8:42=E2=80=AFAM Jason Gunthorpe <jgg@ziepe.ca> wrot=
e:
>
> On Tue, Jun 23, 2026 at 11:53:50PM +0100, David Laight wrote:
>
> > > If we restrict incoming dmabuf transfers to fit within VFS-centric
> > > limits (2GB), we impose unnecessary overhead on the RDMA stack, forci=
ng
> > > it to manage a significantly higher number of memory registrations. B=
y
> > > cleanly splitting these massive contiguous device buffers into
> > > page-aligned SGL entries, we directly improve the efficiency of P2P
> > > transfers and memory registration.
> >
> > But a divide by '4G - PAGE_SIZE' is also non-trivial and (I think affec=
ts
> > a lot of io) when the quotient is always 1.
> > Splitting into 2G chunks is a lot cheaper.
>
> Doesn't matter this isn't fast path stuff. It is better to use fewer
> SGL entries, IHMO.
>
> > > Since this change doesn't seem to have a negative impact on standard =
file
> > > I/O or break existing VFS constraints, I'm curious why we shouldn't
> > > support splitting these >4GB P2P transfers? Am I missing something?
> >
> > I was only wondering whether it was needed...
> > It does bring up the question of why the >4GB transfers even need split=
ting.
> > But that is another question.
>
> SGL can only store an unsigned int size, so any large physical range
> has to be split down.
>
> rdma now a days has code to process the sgl and restore back the > 4G
> sizes since mode RDMA HW can accept that.
>
> commit 486055f5e09df959ad4e3aa4ee75b5c91ddeec2e
> Author: Michael Margolin <mrgolin@amazon.com>
> Date:   Mon Feb 17 14:16:23 2025 +0000
>
>     RDMA/core: Fix best page size finding when it can cross SG entries
>
> So whatever this produces needs to be compatible with that to undo it.

Thank you everyone. It looks like most open issues are sorted out.
I'll wait for maintainers to weigh in before sending out v3 (which
will remove the type cast for min() per David L.'s feedback, and
revert to ALIGN_DOWN(UINT_MAX, PAGE_SIZE) per Jason's feedback).

Hi Jason,

Thank you for your feedback. I took a closer look at the commit to
ensure compatibility. This patch is perfectly complementary, and
actually prevents a failure in an edge case for the latest
`ib_umem_find_best_pgsz` [1].

Regards,
David

[1] For dma-buf split with `0xFFFFFFFF`, in case of a discontinguity
in later buffers, we will hit this code path in
`ib_umem_find_best_pgsz`

```
if (i !=3D 0)
    mask |=3D va;
```
(*After `va` had been incremented by `0xFFFFFFFF`, due to `va +=3D
sg_dma_len(sg) - pgoff`)
(*Which will set the lowest bit of `mask` to 1)

Because `count_trailing_zeros(mask) returns 0`,
`ib_umem_find_best_pgsz()` will always return 0 in such cases.
