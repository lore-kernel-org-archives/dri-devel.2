Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFC84FF8868
	for <dri-devel@archiver.kernel.org>; Mon, 27 Apr 2026 14:29:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E980110E2B8;
	Mon, 27 Apr 2026 14:29:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=meta.com header.i=@meta.com header.b="EUDXK0UB";
	dkim-atps=neutral
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com
 [67.231.153.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A2D510E2B8
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 14:29:11 +0000 (UTC)
Received: from pps.filterd (m0528005.ppops.net [127.0.0.1])
 by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63R4gxBl1267896
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 07:29:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=s2048-2025-q2;
 bh=2UYvqcb6I1B7arRH3pzlLzPrPOKAEH8Y0SQKyqL2jag=; b=EUDXK0UBjzGK
 QKaoX5rIbqufWNaKZdxeAqfPQCkyeDJd2/wFJgapOGZ67xUUMlghtDbf4D/d1LxH
 5K8gn8+RpXX2sydNaWxkc5Fg5ZbqRGAsqwVsCp1OE3OWi5+yquLz/58V0qPoBIMB
 HhedRrHQtQxwKZTwXJUSL7FPjA3ZBGAKGlymgWIYr0yRV3XBk5s5Z4C1y8nt7KML
 jPg8exqznSgbfD7YbW/T/LWbR/ipKX7cSSMzAc4VFZlAkI+faif4DC/D2wB4c7UM
 RbXB1a99Y6RAwk67EGD4OMCuU6JKBc5xh1gQ4EhZCgV4Nyiw1GPLWPY/voT8hSRh
 Zbz3O5ycQA==
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70])
 by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4dsf6ndb6t-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 07:29:09 -0700 (PDT)
Received: by mail-ot1-f70.google.com with SMTP id
 46e09a7af769-7dcc9e6b772so16963471a34.0
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 07:29:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777300149; cv=none;
 d=google.com; s=arc-20240605;
 b=E3vi94iI+7jZN1HnClY/Dtqf8VOmxP2tbpm3DQeTrgKecLIs+/3OLAHBigzqTYjHgz
 Cg9DGfsCQwmIwdxduE04fCN8gWgPYb7S1OV4CbdJxUwm7DWb+oABko1HBw6HltQkWTBe
 ApPuyxyVDSbo1mjCpc3P4okPI75sf43OY3aM91kpyjqFqnJRA89L9WnUnlFb6qTBL06j
 dYl8nNV1P9/InIBOzAPn5j/IwluSo7uuNRKTmLmvy/yE+q40dASZfR7JLb6P3hH7xJza
 xAdG5XpagiSMlyaJjZ1vr/1R+6JKP30HHXSq6dyeAYR4MIEVpJ+2Yk/IH8aPgEkl9XCs
 gbxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version;
 bh=fc3CIGbC+cnKFtpvmB87XnJppPdvAQ5kyZjnAa4rMk0=;
 fh=k47xm2mFqQpQzRDQ32HJumuJWi7pGw3tyd5bXeagpo0=;
 b=CkxJ2JRzYG0TJfrai+jvo451BnUsxyL0klgCaYbyBOys/vSf9ooLpfEQI+0raRYMiu
 JwzBJK72vfLUdBbSoRHTXtVhf6Boj19eCyDAUSc7wPGCQ5el+1XSuCzN3sa+tHF8qJQ5
 1SHkT3sTKMaQ9INGsiMXrOIrCQ9dJ9H506SPvRD/UrzyLfUTDeNP7YhHhpx0yI/f5NRA
 jWrGfFZon4keQrMXGR6t2o5/rkdo543R2s2m/AqPmisrQspDaGi7IEZdya0/kiAt6Nyk
 poKfVTue84s4MkHR64AiZkiU9D7C++o1k1A5rG/7tJEuw82fFqoYPVZYmNWv2Vd2IuVI
 8c8g==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777300149; x=1777904949;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fc3CIGbC+cnKFtpvmB87XnJppPdvAQ5kyZjnAa4rMk0=;
 b=JkQYYn5f6bSMxfQ7D6x+Nu7KlvOthxGbB8d2eHKDAzAsj8JRacFrf7AWIY0YVq4rPg
 2RKhikknLE7AcOHYinh/5cvRgWakCK8A+Yj91Q95XZz6PWm3KoWKMTlNpCQqzcVK6lsY
 LgiBGm41m801yXIAW/THOD6dzh0CGm3ufnQNzLetC2bjAyUvfnt90mxPG1/FaziUQmg4
 ktmh/6oHXGxLtZrto7pGPUoUg6rD8jGAShjk3+IgYFpOIovnYvbmrDNLM8EybGxmX8mB
 M6UXmNjqXx8vB5KqT5jMjUbVXbEr5k7lHbOIfWYONRTpxf4AzjkmgERcKoDc/q2dwQBj
 W1zA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+LhpmNHCj2K+Kgr0kmcEMrHdiKoT4WGCT+eg0mcNPS4gvRdvGS2J0b/Jiw3TbbOQmjpWXYl20TkFY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyDKINyNctXmmIuJSZHgmPnUK72FIe2zS4qiSjsMRl/HFrXV7va
 2G+ut00pLjl2jsCokmkkuxz7Cpt9K8//BWVC2ekYAcyfoc0rMaljVcpETgdriIvYFfVyChLEr0a
 l5zymmgqWQ0ryxOb5Iqjyqc2VyYbF3/VM2bsrc+nJxlhGMmAJ+iAwjoPHNg5Tj77Fsnm8eP/6i9
 yhVbmecDHq1m25Y5wtCRtewflujbI0dVgjkescy9wCqIQ=
X-Gm-Gg: AeBDietpkTJFwQBDbspo6QLJJarcj/6IsEmwtrsbTmfWcNTRrX+8ou5bIULwvxG55K+
 QUbhw8URoDR8526aUb3fZh85sy++5+8JtQtLHJq7jonT2X8KlGQ31oZY35tmFYDlKL9rVtbkQC1
 YnOCGLmhgP6TVIx7Tx2KRAfuQqe4h/cyVgG8m+6wSoJE+2mkccYlWRVJ9mEa5FEpc36GSJUftZq
 BOIvjY11AoSXBjQgj5pH475eOJDmQ==
X-Received: by 2002:a05:6830:82c6:b0:7d7:e3d7:e200 with SMTP id
 46e09a7af769-7dc95525104mr20499568a34.6.1777300149201; 
 Mon, 27 Apr 2026 07:29:09 -0700 (PDT)
X-Received: by 2002:a05:6830:82c6:b0:7d7:e3d7:e200 with SMTP id
 46e09a7af769-7dc95525104mr20499546a34.6.1777300148671; Mon, 27 Apr 2026
 07:29:08 -0700 (PDT)
MIME-Version: 1.0
References: <20260420183920.3626389-1-zhipingz@meta.com>
 <20260420183920.3626389-2-zhipingz@meta.com>
 <20260422092327.3f629ad6@shazbot.org> <20260427133746.GJ440345@unreal>
In-Reply-To: <20260427133746.GJ440345@unreal>
From: Zhiping Zhang <zhipingz@meta.com>
Date: Mon, 27 Apr 2026 07:28:57 -0700
X-Gm-Features: AVHnY4JY-sO0J_s7LFL2WwzvQxcK7s_leO-HiTQgItvSXPr8LTKeRFwdBSndRaI
Message-ID: <CAH3zFs2Sy0mv=QkK4VSV+MVR=ef_CdoxMhTFgzaqoZ+uSOpxoQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] vfio: add callback to get tph info for dma-buf
To: Leon Romanovsky <leon@kernel.org>
Cc: Alex Williamson <alex@shazbot.org>, Stanislav Fomichev <sdf@meta.com>,
 Keith Busch <kbusch@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 Bjorn Helgaas <helgaas@kernel.org>, linux-rdma@vger.kernel.org,
 linux-pci@vger.kernel.org, netdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Yochai Cohen <yochai@nvidia.com>,
 Yishai Hadas <yishaih@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI3MDE1NCBTYWx0ZWRfX7sANdQ7flQ9o
 gP71zRmBZSGeEID7HeqKVrSw+Bu/pfOoR6ccCyHp7G7sKeVFQkBf1uZpBWJMra5OFPGIgEIJdix
 cSi0Dhc/OETs7qwknS3gNn2CY8qFUyAscQjgq6y55b23V/9+bCuqPOHvSqmXMc/Qh5TEKWrH/Ov
 gehx/xanhwotXm6wmLgdYBrlRIRn5lWQG4N6wkgKO8GYGmOOpWrFiPhhYmlXBFO/3+tNIXO+Hnq
 BUXERPl4IptfDm8Ef7zJ4kG1iJOCS/B+ep3uMi9rL7cAcuIdELWnvl9NQ26qHNiF8bxbaABQTSt
 fOlc9I617q2yl3HZ7zBvtLihElhiOQWwEJrVdJDwWw9wbMNsM6w6RUSpBg9a2drFDtf5LjlyhkU
 BjQUFnvYr5d/V/zgpuvfB1QcLgU8hEaewnxM3EXXSwcf6QUGSjNAhLwQ3i5OWWCAPWEEtWwYpwB
 YlD89fkru2+s/DV1/cg==
X-Authority-Analysis: v=2.4 cv=Cfo4Irrl c=1 sm=1 tr=0 ts=69ef72b5 cx=c_pps
 a=7uPEO8VhqeOX8vTJ3z8K6Q==:117 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=jCddH8ec0KUNCymVuxII:22
 a=VwQbUJbxAAAA:8 a=VabnemYjAAAA:8 a=jaC9V5GCrIjCCUt1bV4A:9 a=QEXdDO2ut3YA:10
 a=EXS-LbY8YePsIyqnH6vw:22 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-ORIG-GUID: nlz_fx2_6o2rKRhPy6Mix7p9Fub7F4N-
X-Proofpoint-GUID: nlz_fx2_6o2rKRhPy6Mix7p9Fub7F4N-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-27_04,2026-04-21_02,2025-10-01_01
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

On Mon, Apr 27, 2026 at 6:37=E2=80=AFAM Leon Romanovsky <leon@kernel.org> w=
rote:
>
> >
> On Wed, Apr 22, 2026 at 09:23:27AM -0600, Alex Williamson wrote:
> > On Mon, 20 Apr 2026 11:39:15 -0700
> > Zhiping Zhang <zhipingz@meta.com> wrote:
> >
> > > Add a dma-buf callback that returns raw TPH metadata from the exporter
> > > so peer devices can reuse the steering tag and processing hint
> > > associated with a VFIO-exported buffer.
> > >
> > > Keep the existing VFIO_DEVICE_FEATURE_DMA_BUF uAPI layout intact by
> > > using a flag plus one extra trailing entries[] object for the optional
> > > TPH metadata. Rename the uAPI field dma_ranges to entries. The
> > > nr_ranges field remains the DMA range count; when VFIO_DMABUF_FLAG_TPH
> > > is set the kernel reads one extra entry beyond nr_ranges for the TPH
> > > metadata.
> > >
> > > Add an st_width parameter to get_tph() so the exporter can reject
> > > steering tags that exceed the consumer's supported width (8 vs 16 bit=
).
> > > When no TPH metadata was supplied, make get_tph() return -EOPNOTSUPP.
> > >
> > > Signed-off-by: Zhiping Zhang <zhipingz@meta.com>
> > > ---
> > >  drivers/vfio/pci/vfio_pci_dmabuf.c | 62 +++++++++++++++++++++++-----=
--
> > >  include/linux/dma-buf.h            | 17 ++++++++
> > >  include/uapi/linux/vfio.h          | 28 ++++++++++++--
> > >  3 files changed, 89 insertions(+), 18 deletions(-)
>
> <...>
>
> > > diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> > > index bb7b89330d35..a0bd24623c52 100644
> > > --- a/include/uapi/linux/vfio.h
> > > +++ b/include/uapi/linux/vfio.h
> > > @@ -1490,16 +1490,36 @@ struct vfio_device_feature_bus_master {
> > >   * open_flags are the typical flags passed to open(2), eg O_RDWR, O_=
CLOEXEC,
> > >   * etc. offset/length specify a slice of the region to create the dm=
abuf from.
> > >   * nr_ranges is the total number of (P2P DMA) ranges that comprise t=
he dmabuf.
> > > + * When VFIO_DMABUF_FLAG_TPH is set, entries[] contains one extra tr=
ailing
> > > + * object after the nr_ranges DMA ranges carrying the TPH steering t=
ag and
> > > + * processing hint.
> >
> > I really don't think we want to design an API where entries is
> > implicitly one-off from what's actually there.  This feeds back into
> > the below removal of the __counted by attribute, which is a red flag
> > that this is the wrong approach.
>
> I believe removing `__counted` is a mistake. In my proposal, the intent
> was to adjust the meaning of the storage object based on the flag bit.
> The size of the array should still be represented correctly.
>
> Thanks

Thanks Leon =E2=80=94 you're right that __counted_by should be preserved. In
your approach, when the flag is set, the last entry in the array
carries the TPH data, so the effective DMA range count is nr_ranges -
1.

That said, after discussing internally, we're leaning toward
introducing a new VFIO device feature with dedicated TPH fields (as
Alex suggested too), to avoid overloading vfio_region_dma_range with a
union that changes semantics based on position.

Would you have concerns with that direction? I'll post a v3 with the
new approach.
