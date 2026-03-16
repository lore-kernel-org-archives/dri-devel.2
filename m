Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0926F4644B
	for <dri-devel@archiver.kernel.org>; Mon, 16 Mar 2026 10:55:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B99610E20D;
	Mon, 16 Mar 2026 10:55:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="GdLrEzSS";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 513C010E20D
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 10:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773658507;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j/4AllVOKh8z4TecylNv9BZB3czFOIQzZj3H/I9GZN8=;
 b=GdLrEzSSNs4zDJwLukIgMK1kC6mtyWHjsvKXxW/rYky0O77Yl+Nf9HFKIf3p9DT2s2dhI/
 O7I4LNh1FCAugXuUj0j0HzrFVk4yK63lp068iz1YoPku5N2uIVdb5iCDxcubBZOEJPuuk4
 CjcGpuBpjtO7u2SwLYyFkUT794c4YeA=
Received: from mail-yx1-f72.google.com (mail-yx1-f72.google.com
 [74.125.224.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-iapK80R5NOmjJcr0Ak0MGA-1; Mon, 16 Mar 2026 06:55:04 -0400
X-MC-Unique: iapK80R5NOmjJcr0Ak0MGA-1
X-Mimecast-MFC-AGG-ID: iapK80R5NOmjJcr0Ak0MGA_1773658503
Received: by mail-yx1-f72.google.com with SMTP id
 956f58d0204a3-64ad18e7ffaso6942139d50.2
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 03:55:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773658503; x=1774263303;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=j/4AllVOKh8z4TecylNv9BZB3czFOIQzZj3H/I9GZN8=;
 b=S7EGN9PfnrMA2GU8q6IM+Du6cWUNUnJC850vz0EaruIvI1OdvpZWOoX0mx+ZvLDnNu
 Yie+A956IhN8cnriydcQbzckHb0MJZCnOGLmuam1MwIj5msHR8hfo5902RWDgZGKfrlj
 JfrdQRVrnJLndRGnYaGfw022o+c/VY3JVKTz8f3z1CagKV/6CTeCNjCz9GXvluLLJFlY
 6SCmhLTUJPmRgL5NWR6CN8huQ7xXC7NwnZBIWwExOsIMLCXONmxjuqmpi2rP5Rp1kAuJ
 0JfOhHbUI0/z040CnoC8vdURCb1jOa2+dNKCUNk3ybqB2YkCFB7uNMcVkm2EmxE8GvBZ
 Anhg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUVh9FWNiu3wwicfGPZlvmrJ0Y8vkbJWIyKkPEK5E5L93EVvKPnjtHCbb/S9FSvRBD7elxkHeVUGKo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwSO+FoCfWoiv1G+8GQy7B5DS269vBBrJv5byvSK/74mH8zQBzM
 DY1PA8J1YpsrSa5hMqqOztTnEfvYpRMf++bsPoB3ClEuMRxk2Xf5gV/mKfIYMSVrF7I4eati9nr
 kQH3hJkgIoRZCc1C+0AUwN1LsHDKheawspIQJ7zh4XmRt0al155TEpiJcgD1ovY/+oGNnhPZYaB
 QWbpgflh6yXoRs6vUt5sJKWA8B/j7ZECRt5lRbHdPK9mNw
X-Gm-Gg: ATEYQzyGaohvDyxpbbNjVqt89TEjwuCSapA0ZwabTchkZqZ+KSRpgOr6Kf5EIG0Mhyv
 r5Ggi57phLGN9/BkeB98SylvPsCBJ+8Pa8IujjcnuDY/SP0YOFbIQl6lrdLDyvNCd1JX/IuQiY6
 h87bBlssy2TL6xvmXMSgr8WW4y0dIODN3c3YsjmvFgi1SXEmNM7iVN9ICnNHRoIdKAgy3sPrqjq
 w==
X-Received: by 2002:a05:690e:449a:b0:64a:db50:fab2 with SMTP id
 956f58d0204a3-64e630d964emr9195133d50.80.1773658503327; 
 Mon, 16 Mar 2026 03:55:03 -0700 (PDT)
X-Received: by 2002:a05:690e:449a:b0:64a:db50:fab2 with SMTP id
 956f58d0204a3-64e630d964emr9195107d50.80.1773658502956; Mon, 16 Mar 2026
 03:55:02 -0700 (PDT)
MIME-Version: 1.0
References: <20260306-b4-dmabuf-heap-coherent-rmem-v3-0-3d00d36c9bc4@redhat.com>
 <20260306-b4-dmabuf-heap-coherent-rmem-v3-3-3d00d36c9bc4@redhat.com>
 <20260313230629.GA3603067-robh@kernel.org>
In-Reply-To: <20260313230629.GA3603067-robh@kernel.org>
From: Albert Esteve <aesteve@redhat.com>
Date: Mon, 16 Mar 2026 11:54:51 +0100
X-Gm-Features: AaiRm51o4lEgIIRwy7J8EQU-dh_zU9bcODR7YayBvstmpxh8vjYCQuobudoxI8I
Message-ID: <CADSE00JymMjob5J02bh+YSw+2zyjx8OWxks5aEhuM2GX8ZB7=A@mail.gmail.com>
Subject: Re: [PATCH v3 3/6] of_reserved_mem: add a helper for rmem device_init
 op
To: Rob Herring <robh@kernel.org>
Cc: Sumit Semwal <sumit.semwal@linaro.org>, 
 Benjamin Gaignard <benjamin.gaignard@collabora.com>,
 Brian Starkey <Brian.Starkey@arm.com>, 
 John Stultz <jstultz@google.com>, "T.J. Mercier" <tjmercier@google.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Robin Murphy <robin.murphy@arm.com>, 
 Saravana Kannan <saravanak@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linaro-mm-sig@lists.linaro.org, iommu@lists.linux.dev, 
 devicetree@vger.kernel.org, mripard@redhat.com, echanude@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Bhbd3tet9z8X5hk89UdwAvJwCh3ct-1uPp1klVVcXT4_1773658503
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

On Sat, Mar 14, 2026 at 12:06=E2=80=AFAM Rob Herring <robh@kernel.org> wrot=
e:
>
> On Fri, Mar 06, 2026 at 11:36:34AM +0100, Albert Esteve wrote:
> > Add a helper function wrapping internal reserved memory
> > device_init call and expose it externally.
>
> Why?
>
> The diff tells us what. The commit msg needs to tell us why. Maybe the
> rest of the series explains it, but this commit needs to stand on its
> own.

ACK.

This patch prepares for the heap implementation in patch #4, which
uses the new helper function. I will add the information to the commit
body.

>
> >
> > Use the new helper function within of_reserved_mem_device_init_by_idx()=
.
> >
> > Signed-off-by: Albert Esteve <aesteve@redhat.com>
> > ---
>
> Version history?

You mean track it in the commit body? History is already detailed in
the cover letter.

>
> >  drivers/of/of_reserved_mem.c    | 68 ++++++++++++++++++++++++++-------=
--------
> >  include/linux/of_reserved_mem.h |  8 +++++
> >  2 files changed, 52 insertions(+), 24 deletions(-)
>

