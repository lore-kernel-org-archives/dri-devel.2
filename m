Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C189AC44515
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 14:31:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A529610E386;
	Thu, 16 Jul 2026 14:31:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=tenstorrent.com header.i=@tenstorrent.com header.b="XnbGjLiE";
	dkim-atps=neutral
Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com
 [74.125.224.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F5F810F32A
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 14:31:34 +0000 (UTC)
Received: by mail-yx1-f47.google.com with SMTP id
 956f58d0204a3-66825848551so862864d50.0
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 07:31:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784212293; cv=none;
 d=google.com; s=arc-20260327;
 b=WtLGJ48H1WwpwgS/kP95S2eFXNTOMRh3W2zghDG3+BFrEfc5Jx+nnkysqcW6DDWWxG
 tMcz7YlihU916Q5S5L+HCHShgG2GMFrWlI+iebmqoSaAD4VgYypGCGxem0Tv9aAweztz
 D6WzOjb0fQ3QF0Lj/kuJINBHZlKGv8mOHOSfnB5aSRjX2vy2+IEbUEpX79cHrkfc2zW3
 etRpni1lCeQ1Extc4Rf0QTinkGlpyTdCZqxsI3Ql7HbmAxyMi6Xi+d1+AYmqxf83zn+7
 YncM7q05n1yVARosbld5otcfGJbHmqbnAZjxpuJ6iYHL1xq2I7yrqyzrfzGomnZgdyDo
 Mv4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Wqj04Prt89+XL3w3W35PC7mzlPEJ8JYObFKRACzAKlg=;
 fh=mHK2d3DHw5fzPHG0xw16Vg/0PeBu5aGA+RVbU8dT70U=;
 b=SqUQ8NkYRaKi85hPjopaOPPo9p41tO78hxlA/I+UVBpR1510HZ+TSfqe0OPKWlYHih
 2G+9sxQ0K89gXu7T/dNdUu6j5kbTknz6R27Muhfg/u8ZKuRNb4X8mR28u07/0pGyEW0b
 bEJ3c0jgk48bgiqpnIiQ8WR951QZ89sKRv+0Pbgc83fsVnxzyasnaGJuMbRIRZpk5wBa
 ZoExI/Hd7jc5lmxFRkKPoTGAPYJYvM8QVPZd3YGmLFfLrXNrRlDMMga2UWcPSsCPxvfu
 GfNhSgUShd/Sgceic0u7E6Z8sTpD9G0ZnKGBz6JWOCL6m6CJnMgTsAMVyZbIQg/LDlMY
 L4LQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tenstorrent.com; s=google; t=1784212293; x=1784817093;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Wqj04Prt89+XL3w3W35PC7mzlPEJ8JYObFKRACzAKlg=;
 b=XnbGjLiE/Lwky1LGagc3ZN2p6Fmw497abUja4TUs8ZGbAG6LnZ+DorW0RYk3yVSn4Y
 YYzA/50XKQPHUatXPT19qpN9DHKA4ah8ojDxWx3PuLgAfcvQzKp9z+zylsjveibD3Qy7
 okoRGGcS0pdilabtqVhXFpseXze+io0Uw7mri3RBMdc1sUErkGYFBIb0Rd0z6p5ToUjY
 hexLc2TTaufweOuvygjkNXqCcM7CDK/jLxnonpeazsq3zD9QnJy8LxY13xoDhBRVEm8v
 eYLzkObF5Ke4zE7wMJaPlrjd/r5Rpn6zfEMWtgYhbGy5hAftsDhqIv9/v45C+Aj0V6E+
 MEFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784212293; x=1784817093;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Wqj04Prt89+XL3w3W35PC7mzlPEJ8JYObFKRACzAKlg=;
 b=rypF2J7DnB8ogqL6O5iEMNnUF3nJtply8kB9WQc2BwHQbdt01DQK9mp50VMOIE4f7g
 llfLRyJo3x9D/rTWNO+ZWeXXeV3TcTqtSxxyFMivbqlJkj7Cz3BQ/vt9oygc9sBs4Nwx
 tB3f4hoDz3W2/ZZyZGTafB2g0r8yUkNx0WxzTp8wGv7PRd9GhiBtte4+wSPaMVxDMIat
 u6xQZlD8F0sUP6VgbLsmB4p0hDlUAmQC+sxhzqhFZxeNbCKc7L6w0byStd0Rg20/kHsr
 XkhLO0xGiVwi3d1lrZWcVDmqEg+0QobSJY6vv9cGP8NFFrQzKfODENIAFLLFfbVQZ4Cr
 LjPQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RquKM4bEDfDUcErBW4Zh+OlTqkGepcK3IYAMMHEK1rWyWwBZ47ajn7SNQoakvA+US9f67hF4kWt1Gc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yweeb7TEy1E+p3XSa5T/sLfkUlL2Gp08rDuOQASXtUYh4+uCwtQ
 GHgar/pQNqLNhXZUizkARgkTTBJnas2QgYPw6snhuLq1gxhVUDFtuA516drLxGYK9iEH2r3L2xk
 PXD3SXJXNNYgWEZW5n3gYCOnZze2lygaZXXcC2BoATw==
X-Gm-Gg: AfdE7clww388lpM5J/C5u33lhYi5FF+T53n9zgJdgKtp+jeLMXTogMLIoYCjU/IFrPP
 Et3tpNolBiD3ADBJek0YRUJ3SGaHny6wiAhScZ4Epgb+5/Wmf0d6JhVWQ4PoHxZ5Lz6/xHOTs3T
 cdvbYLFt6vB+HX+aKwndEUYwGET/P2Q/URkIyuNP0hYtQx/p4AshR3mi9xsRlP89NT9OQgqlNu5
 CvnBtVurANHJiNuLjxgy2EszbMllU/XJa5tLgIY10PYSWtahCyJVZFG4a9kDg8vIP2TIwv+Bc03
 H7/SDJpGMUwFsmGdz51AgLxctcM=
X-Received: by 2002:a05:690e:4148:b0:667:8b90:2e61 with SMTP id
 956f58d0204a3-668078f0fc3mr6932112d50.109.1784212293161; Thu, 16 Jul 2026
 07:31:33 -0700 (PDT)
MIME-Version: 1.0
References: <20260714-radeon_32bit_fix-v1-1-42a99945f6e0@oss.tenstorrent.com>
 <11218edd-ae58-4966-8172-27b2435eaa1f@amd.com>
 <CAEev2e_gnmhYw_mV8zt2AnkY6Hj_F165veoAPaXhA_ej-5RUUg@mail.gmail.com>
 <7619ffd0-a77b-4596-a9ab-8e5172c929e2@amd.com>
In-Reply-To: <7619ffd0-a77b-4596-a9ab-8e5172c929e2@amd.com>
From: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
Date: Thu, 16 Jul 2026 09:31:21 -0500
X-Gm-Features: AUfX_mxXtdf_YAxg6EpTMIC_TyPr-rMFNFvQdoKFSUcmpA1u--XFkjVi2YmTQuk
Message-ID: <CAEev2e8e4Q2zgQxkodBzNpXCDCFhE4femijQ_K8yQrKe7bXn=Q@mail.gmail.com>
Subject: Re: [PATCH] drm/radeon: allocate dummy_page without DMA32 on fail
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
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

Hi Christian,

On Thu, Jul 16, 2026 at 2:34=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> Hi Anirudh,
>
> On 7/16/26 04:08, Anirudh Srinivasan wrote:
> > Hi Christian,
> >
> > On Wed, Jul 15, 2026 at 4:15=E2=80=AFAM Christian K=C3=B6nig
> > <christian.koenig@amd.com> wrote:
> >>
> >> On 7/14/26 18:03, Anirudh Srinivasan wrote:
> >>> radeon fails to probe on platforms that have all their memory above t=
he
> >>> 32-bit range with an -ENOMEM because dummy_page_init calls
> >>> alloc_page(GFP_DMA32), which would fail.
> >>
> >> Unfortunately I clearly have to reject this.
> >>
> >> The DMA32 allocation is mandatory for radeon to work correctly on some=
 platforms.
> >>
> >>> Allow this driver to work on such platforms by falling back to
> >>> ZONE_NORMAL regions. dma_map_page called subsequently would catch any
> >>> issues with the device being unable to DMA into the mapped page.
> >>
> >> No, it doesn't.
> >>
> >> It's just your special case that dma_map_page() is able to use some IO=
MMU to remap the page below 32bits so that the driver can access it.
> >>
> >> The problem is that we have quite a bunch of cases where this doesn't =
work correctly and eventually result in all kinds of trouble, including ran=
dom memory corruptions.
> >>
> >> In those cases it's better to not load the driver at all than to later=
 deal with corrupted data.
> >
> > So this platform has an IOMMU, but it isn't enabled in the upstream
> > kernel at the moment. I am able to boot up to framebuffer console.
>
> That is not even remotely enough to actually test the driver.
>
> What happens is that you allocation succeeds, but you simply doesn't exer=
cise the functionality which would need the dummy page.
>
> > Is there anything that isn't expected to work in this setup? Is there
> > some test I can run to verify this?
>
> For the technical background, the dummy page is there to prevent buggy ap=
plications/driver code to crash the system.
>
> The general idea is that a reads/writes which otherwise would go into nir=
vana are redirected to the dummy page and so prevented from harming the sys=
tem as a whole.
>
> The problem is that while some HW generations can handle 40bit of PCI add=
resses the dummy page register is only 32bit wide in some cases (I would ne=
ed to double check your specific HW generation, maybe that would help).
>
> To actually make sure everything works as expected you need to enable som=
e desktop system and run OpenGL tests. If then an error occurs and IOMMU co=
nfirms that the right address is used for the dummy write then we could be =
save that this actually works.

Thanks for explaining what the dummy page is used for. I will try
running some OpenGL tests with/without the IOMMU and see what happens.
It'll probably be a while till I can test this since the IOMMU isn't
enabled in upstream kernels yet.

>
> > I should look into whether the IOMMU on this cihp can be enabled and
> > then try this out too.
>
> Well enabling IOMMU could eventually help, but the code in the current fo=
rm would still fail. You need to use something like dma_alloc_coherent() an=
d I think that this won't work because of the HW restrictions.
>
> >>
> >> What could be possible is to add a special quirk for your platform to =
not allocate the dummy page as DMA32 in the first place.
> >
> > So some kind of a whitelisted set of PCIE vendor/ID combos (with
> > working IOMMUS?) where we fallback to non DMA32 ranges?
>
> No, what you are testing here is basically that display is functional and=
 not anything else.

I think I understand this now. You're suggesting that we skip
allocating the dummy page in this specific case.

>
> Regards,
> Christian.
>
> >
> > Regards
> > Anirudh Srinivasan
>
