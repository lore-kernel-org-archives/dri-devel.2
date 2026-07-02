Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43A6CC43458
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 08:10:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A4B2710F1FC;
	Thu,  2 Jul 2026 08:10:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="psRVYPnd";
	dkim-atps=neutral
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA4C210F1FC
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Jul 2026 08:10:44 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-493b691cb44so10484005e9.0
 for <dri-devel@lists.freedesktop.org>; Thu, 02 Jul 2026 01:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782979843; x=1783584643; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BIcE6G+6TDMoCdkb5TNOONacJV25dJbtV9kWeZ6u/To=;
 b=psRVYPndauOcGWUaQnN5AgB+afKnt2CNMDXeVrgPGHhBJJSlWEeejOKXgsBKCyDxMH
 pI44nIlphCA2r+9FmIWw1UFN2DDscrILngdmndU/6jM8vyjNwqSww01hQQt1KbOFvuBA
 lm+AK3hUULFLXXFQzzHj3KqXyEsb7UpZjbk/ON6n2BgMloS8pnY36heNzHPF+m2Dt47n
 zm/eynY9S5udhwC3kIc6a3/g+l6yk/jYmSeKhQjnZhdm/nBR8j/dSNBkiRYbh4m4eLhB
 cNTFHkpzjCPzPe7KipmW7zvhE+Ky73fcbVvL0gUCn9MNM4YTju6JmN++7SjHcV/sh0St
 Iwjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782979843; x=1783584643;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BIcE6G+6TDMoCdkb5TNOONacJV25dJbtV9kWeZ6u/To=;
 b=VL/6jGXWAzFwQ5yTCI/GL6hxAC7j1zxld+CVyqH+LWMMIE1uBkP5EYkbwGkWSKhbnO
 7HS9oTiA0yRIU7z58qgJxZ5eh8V1iIIoQ5ufpa4UPtF8FZkob9SGSZoQEK1Boh0TCMQk
 mMXXxKEIac9OHPlS1DGOoOgQBgFNKACeFAwVBhTMSZ8AH5XkC7lw548q7thUWyvR5YCY
 PfmIyTHzp5TEDu5yLbX7Bvk6uuxKjlpeMLV5vue+XBsGtZgM+Qv4jrewBB9zgcPR0WXx
 FehrXKnmfqzICBOozXUWWcvRbHbLF8taovuw2Shx/0cTw1ammVHi4TeRvsJqfsUyNXP4
 WxMw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/nAdWZOz3xTcGSfG0kk5daLqF91Eu8AV6qlUw3j6dDppmfCNFiwU9lnw24C3tyddrshHeBPKVhJMs=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxrQNTKWF8Er7SiDozAClZskGWlbO/Fr9p1YpUUskHxG4+/G4r1
 NGRqvWiSXb/x8CfzBhQkb9Wc02vJlC7XgwR3zNp9zf7uE0ElW2ZjMVC3
X-Gm-Gg: AfdE7cnmICJWcibOl1kuOtC89LrZDlg/XNXX0N4NUeOEeX1eA8hdR5FSuR29nlvAmpO
 +c4PrIH8y9l70OZCtIRKjdsX4ZUJETCdyPUhKZT/YZfJaq6GHX8bHv/c6il/zg9aO2F1TxKvm4V
 a1xZDZnXKChOd8nDLYABdvI2lmMlBrMEmlE2UnvKC7kQNEClLnZh0PfaLSfEWSk15G7ggLgw6jX
 PGw46oc4gsbSpFaZ0VUordxVBrv9X1f8fFH+CEeEYMVtZyHGcY/kNS9w0L1Pgr+jjm3hJLoLASX
 TjPR6oKTeizC2Coo6gdMp1nw4nUF+VtDm1cZ0Lg6YXxZPmlJMLtfcQcAs25mEQbmKwPirMIskbF
 IiAra/yEu5kJVNmiQvb/Uk1nQmGCPa+T1LCSPgC6oNUfb1WeL2BqylV3/mQ1wuVhOpPVx2PtMts
 p+rTolJq70PStn48wew74jEd66xf0tYUFF4YITZScjACbqZOel/+UND5Gk
X-Received: by 2002:a05:600c:6c95:b0:493:bc4a:fb56 with SMTP id
 5b1f17b1804b1-493c2bbcb21mr53757575e9.39.1782979842538; 
 Thu, 02 Jul 2026 01:10:42 -0700 (PDT)
Received: from pumpkin (host-92-21-50-228.as13285.net. [92.21.50.228])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-477db3db964sm6530093f8f.8.2026.07.02.01.10.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 01:10:42 -0700 (PDT)
Date: Thu, 2 Jul 2026 09:10:40 +0100
From: David Laight <david.laight.linux@gmail.com>
To: David Hu <xuehaohu@google.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Pranjal Shrivastava <praan@google.com>,
 Sumit Semwal <sumit.semwal@linaro.org>, Christian =?UTF-8?B?S8O2bmln?=
 <christian.koenig@amd.com>, Nicolin Chen <nicolinc@nvidia.com>, Leon
 Romanovsky <leon@kernel.org>, Kevin Tian <kevin.tian@intel.com>, Ankit
 Agrawal <ankita@nvidia.com>, Alex Williamson <alex@shazbot.org>,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev, jmoroni@google.com, kpberry@google.com,
 chriscli@google.com, sashiko-bot@kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] dma-buf: Split sgl into page-aligned 2G chunks
Message-ID: <20260702091040.35eff00c@pumpkin>
In-Reply-To: <CAPd9Lg9uY1RZvYUtcbKUg=VdWM61M2f3aqmS5veUg_8M_Ce80g@mail.gmail.com>
References: <20260621222130.1667453-1-xuehaohu@google.com>
 <20260623015459.1153884-1-xuehaohu@google.com>
 <20260623094446.4a8fc2ed@pumpkin> <ajryxMaT5evDUxaq@google.com>
 <20260623235350.6540eaa2@pumpkin> <20260630124252.GD7525@ziepe.ca>
 <CAPd9Lg9uY1RZvYUtcbKUg=VdWM61M2f3aqmS5veUg_8M_Ce80g@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

On Thu, 2 Jul 2026 00:56:40 -0400
David Hu <xuehaohu@google.com> wrote:

> On Tue, Jun 30, 2026 at 8:42=E2=80=AFAM Jason Gunthorpe <jgg@ziepe.ca> wr=
ote:
> >
> > On Tue, Jun 23, 2026 at 11:53:50PM +0100, David Laight wrote:
> > =20
> > > > If we restrict incoming dmabuf transfers to fit within VFS-centric
> > > > limits (2GB), we impose unnecessary overhead on the RDMA stack, for=
cing
> > > > it to manage a significantly higher number of memory registrations.=
 By
> > > > cleanly splitting these massive contiguous device buffers into
> > > > page-aligned SGL entries, we directly improve the efficiency of P2P
> > > > transfers and memory registration. =20
> > >
> > > But a divide by '4G - PAGE_SIZE' is also non-trivial and (I think aff=
ects
> > > a lot of io) when the quotient is always 1.
> > > Splitting into 2G chunks is a lot cheaper. =20
> >
> > Doesn't matter this isn't fast path stuff. It is better to use fewer
> > SGL entries, IHMO.
> > =20
> > > > Since this change doesn't seem to have a negative impact on standar=
d file
> > > > I/O or break existing VFS constraints, I'm curious why we shouldn't
> > > > support splitting these >4GB P2P transfers? Am I missing something?=
 =20
> > >
> > > I was only wondering whether it was needed...
> > > It does bring up the question of why the >4GB transfers even need spl=
itting.
> > > But that is another question. =20
> >
> > SGL can only store an unsigned int size, so any large physical range
> > has to be split down.
> >
> > rdma now a days has code to process the sgl and restore back the > 4G
> > sizes since mode RDMA HW can accept that.
> >
> > commit 486055f5e09df959ad4e3aa4ee75b5c91ddeec2e
> > Author: Michael Margolin <mrgolin@amazon.com>
> > Date:   Mon Feb 17 14:16:23 2025 +0000
> >
> >     RDMA/core: Fix best page size finding when it can cross SG entries
> >
> > So whatever this produces needs to be compatible with that to undo it. =
=20
>=20
> Thank you everyone. It looks like most open issues are sorted out.
> I'll wait for maintainers to weigh in before sending out v3 (which
> will remove the type cast for min() per David L.'s feedback, and
> revert to ALIGN_DOWN(UINT_MAX, PAGE_SIZE) per Jason's feedback).

Does this code get used a lot for 'normal' transfers?
I'm away from my normal systems and can't check.
But if pretty much all of the fragments are small (< 4G) then
it is probably worth adding a check for 'size < limit' before
anything else and optimising that case.

	David

>=20
> Hi Jason,
>=20
> Thank you for your feedback. I took a closer look at the commit to
> ensure compatibility. This patch is perfectly complementary, and
> actually prevents a failure in an edge case for the latest
> `ib_umem_find_best_pgsz` [1].
>=20
> Regards,
> David
>=20
> [1] For dma-buf split with `0xFFFFFFFF`, in case of a discontinguity
> in later buffers, we will hit this code path in
> `ib_umem_find_best_pgsz`
>=20
> ```
> if (i !=3D 0)
>     mask |=3D va;
> ```
> (*After `va` had been incremented by `0xFFFFFFFF`, due to `va +=3D
> sg_dma_len(sg) - pgoff`)
> (*Which will set the lowest bit of `mask` to 1)
>=20
> Because `count_trailing_zeros(mask) returns 0`,
> `ib_umem_find_best_pgsz()` will always return 0 in such cases.

