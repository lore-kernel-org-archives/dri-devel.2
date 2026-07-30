Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1588EC55162
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 14:40:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6EE5C10EF65;
	Thu, 30 Jul 2026 14:40:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="EP6t4vfZ";
	dkim-atps=neutral
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 843EB10EF65
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 14:40:52 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-49555a0e68bso11556385e9.2
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 07:40:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785422451; cv=none;
 d=google.com; s=arc-20260327;
 b=BQQBlLs1B8U0QYbDeajKzUz6I99CMAdm4sDeWR+x3m9jqSzDq7VGTmItFut5KKCUbL
 /bZeWpA+HDWyxn7S50HMWOTrAJzz9oMDzOZw7EjmuDU7HRo/MlRfOvO4nvUHTabxGsNh
 gZpvbUTyydr6Mr9tsNH72g6UmxhsTBPgPE+U2ZVqbFgt1aki+Hn+ojONkmCQDx263Ld6
 Loxj0Bt1qkWvz4zyepRuDMzb8DFweOXS9j0B7OMR5HSa+zXe0leKDfUQT5fRfCHoGm1C
 5bkW5gUQPH1lHl/6ks9l0PBk/0NRhZ2bgm/T8khJMVrgZWiY89cEsBdltaDj7hjCsWa9
 iCHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=0h4L6ZZlh4KX9plECryTj4sQK3uBKcjPF4+NlpXzhRY=;
 fh=j9YOWna2uWfVgP3p/b9mQnF6aKFbi2ip/Dr5x81ZsRI=;
 b=APSHC/kH6L8qG+MAxS02Gnew4DFS8g3T9PAHSZQwu/XVm/BU315zrCGsf3feIgsK5/
 cOJGAWZ6l1LM665F0OpyKx9LQGlgkRri2hbQCFBlS4PHYN7wvQFi6XvUeJwlQT6NqLQu
 x/P+p5DsolOB5kVZMy6HPkKTwtGLQGMK+rCgW2VmICf4n30P5ZPT1KsnygJmUlKzqO3V
 rvixBkWd7qGG+4oS1/FtFA1hiO2q1bAexjfH9Gsawhe0X45PbK+Hw8Hz6MWzLn+E/H4h
 15Rbyje2R6s1D56J7Nxn9bd3+WdE9lkgHQkGmW8att/BpY60bKAVXsdTfO3hBp7ccuOP
 3HwQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1785422451; x=1786027251;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=0h4L6ZZlh4KX9plECryTj4sQK3uBKcjPF4+NlpXzhRY=;
 b=EP6t4vfZvpcjXMSlcGsuBvwYv5m5IfanVLixJ0prQN7iLBx2loEPHAHac6O7Wzv6Gj
 r3t3HfL4M0CvaW/PTDJAdjr2zy8IamfupgrJzq1dIZkauhDN2faxPxH9zMuHtHPzYC0m
 ZjdFulmGPWd1jCmFO3pw03+Nj8/cy0RDRJImc0Gi3aaDwSJYeXHO/y9CDBY2oEo0GkXb
 41Csc+CB1ies4TxexQxM/8j7XIvKtrzwIiXTW9tGdUTP5V9I9kZpphP+S/8B2XzSXgUh
 PieMgyWux7O8YI7tkerRutSGcy9ex5Hxj2kS5tMkPut5p8h55T3qe2FUNYrERWq3KWYa
 vnuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785422451; x=1786027251;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=0h4L6ZZlh4KX9plECryTj4sQK3uBKcjPF4+NlpXzhRY=;
 b=jyIaM4Pq4yszALvSvpk3DF65GE219H6QJmoJMEaVexDexdw6vhgQ4bu1rM/yW8aNJE
 u3YbWhyI1L6/IiakXzNpweed82RYz76Jg2lZewhZbbJyKc2d3dIJ0xnKhzWO0AYPwt5Z
 unN4tr8XdG/jy+6tqus6GO68rLGEgwb1+OH5mldso8pId0tg+5m7SvX0wWvyqLzwvPyA
 16QGysCKvk426lzjB9bD32EvEjl++u00gvqEqOB4G2gma+oSkFx+OfbLGKceuLWXADW3
 p2xFw/Svsx7PSBZ8pCVBT63IzL0peRJ8EOC8fCOd9dcXV8fOStvZ5UhF9Rj5VAcl2nxp
 coIA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr7fIIOMJZWo4VJAQK4SKG6B8SILSXldLmbxQ7Ah4U5PWfHOb9tuPwW/DL13CfHNRVp9MlUrHN3BR8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz4YGBuBKbSZAkb8pNFmhsrANxG+XToUod27bq29GOIBDplOlly
 DVt8m7LyTSG5+EqIZnE3H41AM4bGE+nmw4UaBm6ZlOGQjCU7+jIGqsfzjRHA4KX3VCim22AJAY5
 +6QKS8FiJnKdyugU96nYQ49sLI2f5swnwefyT1B65
X-Gm-Gg: AR+sD107n2/poVVvY6AtyDJyjxSVQiMhZLuaGveV5IqtUfKWdnLYifp+BaGVIKlSuv+
 EnenHPPnZei8x1B2G7isdzPgabIYlKOkGXWQT39ZyYc8XvPgf6Qu+CJaVmyx77Mhse/0cSX3KhE
 o9FsPe8tjzUs5FcHvKPs3anmbP5ba3KHWPSAueCz5yPeN4EK2RsDOd+3Pql4PYgBZ9jHbvMmttV
 FtRDYefkmvJkQ8oXGP3G0IGZom8nz8CqGOkjoOuiloGDFT4aOXckVP/VQvsZTKcWHiUyvYzlk+H
 5M6dTMhqCLdwylUcj6VjIUBipjXgnJfztRGIpQdtz8xyDRKEGEAwQrPlO+Ustr7D/kix7wzK58P
 2gVzSg2yS4SHUBV8D2LEehSqDk17aSYJL2Sz/9e1duQ==
X-Received: by 2002:a05:600c:1f90:b0:497:fecd:5b00 with SMTP id
 5b1f17b1804b1-49800e74e48mr38422095e9.9.1785422449384; Thu, 30 Jul 2026
 07:40:49 -0700 (PDT)
MIME-Version: 1.0
References: <20260728-fw-boot-b4-v10-0-9187aefa3f2f@collabora.com>
 <20260728-fw-boot-b4-v10-4-9187aefa3f2f@collabora.com>
In-Reply-To: <20260728-fw-boot-b4-v10-4-9187aefa3f2f@collabora.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 30 Jul 2026 16:40:36 +0200
X-Gm-Features: AUfX_mzyNLZGudhHOpdwT2kf52dlUa7XXgnvD89wbxfCaynMAVOKUqhjF20Pn20
Message-ID: <CAH5fLgjDoWT09Kdp0Jtg=XtmWVdnUM71yT_TsQG+TX1RJ6GqaQ@mail.gmail.com>
Subject: Re: [PATCH v10 4/7] drm/tyr: add GPU virtual memory (VM) support
To: Deborah Brouwer <deborah.brouwer@collabora.com>
Cc: Daniel Almeida <daniel.almeida@collabora.com>,
 Danilo Krummrich <dakr@kernel.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Benno Lossin <lossin@kernel.org>, 
 Gary Guo <gary@garyguo.net>, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>, 
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
 Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, 
 =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, laura.nao@collabora.com, 
 samitolvanen@google.com, lyude@redhat.com, beata.michalska@arm.com, 
 boris.brezillon@collabora.com, steven.price@arm.com, alvin.sun@linux.dev
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

On Tue, Jul 28, 2026 at 8:39=E2=80=AFPM Deborah Brouwer
<deborah.brouwer@collabora.com> wrote:
>
> From: Boris Brezillon <boris.brezillon@collabora.com>
>
> Add GPU virtual address space management using the DRM GPUVM framework.
> Each virtual memory (VM) space is backed by ARM64 LPAE Stage 1 page table=
s
> and can be mapped into hardware address space (AS) slots for GPU executio=
n.
>
> The implementation provides memory isolation and virtual address
> allocation. VMs support mapping GEM buffer objects with configurable
> protection flags (readonly, noexec, uncached) and handle both 4KB and 2MB
> page sizes. A new_dummy_object() helper is provided to create a dummy GEM
> object for use as a GPUVM root.
>
> The vm module integrates with the MMU for address space activation and
> provides map/unmap/remap operations with page table synchronization.
>
> Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
> Co-developed-by: Daniel Almeida <daniel.almeida@collabora.com>
> Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
> Co-developed-by: Deborah Brouwer <deborah.brouwer@collabora.com>
> Signed-off-by: Deborah Brouwer <deborah.brouwer@collabora.com>

There's a 32-bit build failure :(

error[E0308]: mismatched types
   --> /home/runner/work/linux/linux/linux/drivers/gpu/drm/tyr/vm.rs:873:17
    |
871 |             pt.map_pages(
    |                --------- arguments to this method are incorrect
872 |                 curr_iova,
873 |                 curr_paddr,
    |                 ^^^^^^^^^^ expected `u32`, found `u64`
    |
note: method defined here
   --> /home/runner/work/linux/linux/linux/rust/kernel/iommu/pgtable.rs:152=
:19
    |
152 |     pub unsafe fn map_pages(
    |                   ^^^^^^^^^
help: you can convert a `u64` to a `u32` and panic if the converted
value doesn't fit
    |
873 |                 curr_paddr.try_into().unwrap(),
    |                           ++++++++++++++++++++
