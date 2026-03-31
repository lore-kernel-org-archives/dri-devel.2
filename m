Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CDF410F92E0
	for <dri-devel@archiver.kernel.org>; Tue, 31 Mar 2026 17:13:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B073B10EC8A;
	Tue, 31 Mar 2026 17:13:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fB3hpIOc";
	dkim-atps=neutral
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com
 [209.85.167.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5CAE010EC8A
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 17:13:04 +0000 (UTC)
Received: by mail-oi1-f176.google.com with SMTP id
 5614622812f47-46a9ae3f860so1452421b6e.1
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 10:13:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774977183; cv=none;
 d=google.com; s=arc-20240605;
 b=FlbZXAow4dhXJ7KEDE1HaR+pyu53txMgRoZDo7Wdg4MKP+ns6Q2sNcxDJAxjXD85ks
 qgXVgWkeDwGLa2X0fctrm9W+auQnK+h5k3ULzEfZrcxPIrn/FhGcRHCS/7mbBKatrHQx
 GBlKwRkT4uKk5wH/xTudZnuDJUp4IYs8FIvxS3VQQG2oO9stYZSSsk0dk9GCbVgCVmb7
 vK57huaq9cWKQ7AR+TqXUjC1VnAUlj4RoqS3rvMwbIz8CA1F7FhK3yuDy9aofEvH5dF8
 wEe2KFRnF0wS+ZPwxzBv0x/vm0gMou8y+gInrnHBO4djdMI5w8KdUjZCFdGYdpxwmYak
 IUvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=iFEKQ83y9bedeJoX/1IopbEkVlHg3BCGxN7/0fDF1QA=;
 fh=Jfl00APondPt6S1mtHaROKQRjav1PjIZjd5CYtf5poM=;
 b=Gw2qJtxCZCBvyIFOr3FDFNfto61ZYsh5VRbGFC/PVOBocyitxDHMRP7SIHKiY2Wm0m
 7lfMI3Pvh8jSUPKocSyaoJVb5h9xKz3VoxrIbHFvgE5iR6u1m1LvZ2tEZf+x7xq4Sz53
 kfBtULrDPMPQllxykt253fBtq2xbHRmIQqhxDo3Fk8K/IdJ3oSGZqd2BL4ur1MXz5MOw
 NdvogsVB0YsGrNmmajWBPlGZ5bv2zDSkwyxWfzSdefuyQTGxSmhLEUyIctDEKejPMUsZ
 qO6uVUlPMd8B1e0vvXw1+/8r6hohpgZF8QRB/CSk9b91dRkxlMZH2bWCUctOalL/CSOx
 OOMQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774977183; x=1775581983; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iFEKQ83y9bedeJoX/1IopbEkVlHg3BCGxN7/0fDF1QA=;
 b=fB3hpIOcuSM9qW8TT2TNSX4Evvtz8Tvt1gqER1FHs2hdV4IZQ2XIGpe9is7/xl8cYG
 K9XuGogubbtLZCrjPUQUXQtBYROr2VeRHbVBSEggifawsxUr2r55goEZniKj7g1q9c6h
 iD/V3Tf/leuut+SrOrYlJWhSpb6UGOZP7mo751w9TnfXQo8+odkBaGRFs7Pwu37nk/Ty
 KPJ6P+k14ORftil1VkjDw5eJ4qeUgTePHuCejOCPvoWmbZZUlxqHDtdXztyJY746qeVH
 Jmdkm4d3YZXH35RW8ONoAT9aUJ3WraG2FowWRaIobi4FC64BOiNxKv+0fxEA4NaHA6Vi
 EuYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774977183; x=1775581983;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iFEKQ83y9bedeJoX/1IopbEkVlHg3BCGxN7/0fDF1QA=;
 b=iw/tBf3cjnx2a9GylqB279lOaKPb4FoHhmTCGOK1DkTxGTLX3snRaAotkD7gou7CUo
 JRGZaE/9E0htWEUeeCcL4ge44oATfiRU5CmsXxbW5gKfG0St5YkWOvOIXa2uxgJvSRFL
 cSftK4FW6rz2l20YSH+wqPxNCllTnaz0pCb+lqWBtnaEWxSJnE32bmCPktdNYc657b1/
 dCzflGcNMmEZk7WyruFHk225DKo454nWsg4i24PgLRtaApGm5AGWlvHEIoCV18xYgvnz
 Q0H28nt55xB/Ne252cgKyBco16AebXnCN4bHzPh3ip8m+UDaS9KKLLdsNPMnF4jqkz6+
 NP0Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWtZU8tbpKZ4jBT7/s3hMQlydEoNCDY6dgFAq5blaj/Cc+O0FLhDcBDF9CKVZ5hn0TGScN4kz7PcqQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxCSPM7MkMS/skG2ZJCNP2Ch6mYkIEvR8jB84dMVlCv37LOmbxU
 BIUWM3cntGnzGfSeUI7xt4zngAEddfmPFYYF/cdA1g+lZPBZCwKz48c1vYiXcmgKDFQfgL8/kht
 kTS+IG80F7QDi9p3axNChdGs02I2aMT0=
X-Gm-Gg: ATEYQzyhwBefQLhMNRrN2N6/2C1zq/fQwNFvoK54nn+liw6bjrKt7ZPyghNhoeNXscz
 hqX1wT8MwqJXaSEZ009BRrrQ1KTU4L2MR5g/bvtlTO6lwUjVav4XOrFntjQa8as4/qZmN3u4eaT
 NzCMS3fQcLxYj/MegcQTL0TF0Isn3WaJM684ugbKYpy28zLnbaZj9nyjBMtaFd+xMowCBQhUcOH
 1DM7OAAMs/Cs1oor/TElsf4MVjrZGcOCw+LqYwakYMFFlYFFtu3XTRAzGfNtgwKPQtyBcJnLGqS
 GSOUpzNr1w==
X-Received: by 2002:a05:6808:c28a:b0:468:fad3:1303 with SMTP id
 5614622812f47-46ae0253498mr126746b6e.45.1774977183505; Tue, 31 Mar 2026
 10:13:03 -0700 (PDT)
MIME-Version: 1.0
References: <20260331142127.52796-1-mikhail.v.gavrilov@gmail.com>
 <845af7e1-3ca7-483b-a3b1-0840d9c98596@amd.com>
 <CADnq5_M-iwCHKJ+cnU1TQSc-aGJC465dwzWGQkhaZoSPz7Wu5g@mail.gmail.com>
In-Reply-To: <CADnq5_M-iwCHKJ+cnU1TQSc-aGJC465dwzWGQkhaZoSPz7Wu5g@mail.gmail.com>
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date: Tue, 31 Mar 2026 22:12:51 +0500
X-Gm-Features: AQROBzBzA9IUSBY7s1YWXyeLaMTcjuCvXtDiYrwavdp4mR0QqCiBggByPXI7qNU
Message-ID: <CABXGCsNcRQnQmsZJAhfJPsR71HXU5+CG4URJiX03xkPJD+f7SA@mail.gmail.com>
Subject: Re: [PATCH v7] drm/amdgpu: replace PASID IDR with XArray
To: Alex Deucher <alexdeucher@gmail.com>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, lijo.lazar@amd.com, 
 Eric Huang <jinhuieric.huang@amd.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org
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

On Tue, Mar 31, 2026 at 7:38=E2=80=AFPM Alex Deucher <alexdeucher@gmail.com=
> wrote:
>
> Applied.  Thanks!
>

Hi Christian, Alex,

While testing v7, I noticed that xa_erase() and xa_alloc_cyclic()
use plain xa_lock()/xa_unlock() regardless of XA_FLAGS_LOCK_IRQ =E2=80=94
the flag only affects lockdep annotations, not runtime locking.

The XArray API provides separate _irq variants for this:
xa_alloc_cyclic_irq() and xa_erase_irq(), both defined as inlines
in include/linux/xarray.h using xa_lock_irq/xa_unlock_irq.

I confirmed this by hitting the same lockdep WARNING with v6
(which has the same locking), and by reading lib/xarray.c:

  void *xa_erase(struct xarray *xa, unsigned long index)
  {
      xa_lock(xa);              // plain spin_lock, not _irq
      entry =3D __xa_erase(xa, index);
      xa_unlock(xa);
      return entry;
  }

Should I send a v8 using xa_alloc_cyclic_irq() and xa_erase_irq()?

Thanks,
Mikhail
