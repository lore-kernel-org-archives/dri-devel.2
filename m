Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6317ACD8CA4
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 15:27:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6062B10F5D6;
	Mon,  8 Jun 2026 15:27:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="sekmpcM0";
	dkim-atps=neutral
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com
 [209.85.210.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B8EB10F404
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 13:55:48 +0000 (UTC)
Received: by mail-ot1-f48.google.com with SMTP id
 46e09a7af769-7e71b2d527dso949317a34.1
 for <dri-devel@lists.freedesktop.org>; Mon, 08 Jun 2026 06:55:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780926948; cv=none;
 d=google.com; s=arc-20240605;
 b=RA2QobNpPqKMKjKggvyZfKUaXWNsmsOw01GpdxxWHjdA1ESC9vT8iIF9R18YOJhLzj
 JSen5YfdxIpwSNlqhvADcA29sne7qfraz9f3FZ2xWYJ6ElP3+DAEIKD8rzUL+iCmhL2z
 msQXA8d1ey+6Rx17A43+EowmKcbPwFQGrb0X2e5ClOmLLJBEqgqz8kkCclNMCBam3eQx
 FDEoereUnek0lwwpRk++GoSg29WkGnf3YdrxvK9ruQk3wXcQZXd0cNM9fr3pgMDPgHJZ
 d+cKvxSPE/072MUIyLxzJ7dFhziTVc0/EPZVRDxgy7YzcNEwGrkBAbqU0HYendzaCIPW
 hpkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=kUL9dbW3zc3Xi3+/vcg9ikmrLca85ynlSpRuCnmgz6k=;
 fh=IwiA4yLxLNHOngE3mxog3pxbs+k8jQXRhFDj9ouCjHs=;
 b=V3rdfIzlbNEwp4Kww2X84SBue5DlsGfQzxXhDuZf72s7vDLhkn8V9oDDhbyQl15ZS2
 9qY8wkCLouiPt534JpGVH10iDgLCAs+KhCcVjEm4rcJW4I5pnw98M3GcVtQGd8muxU2I
 dfsGb1a5D7BKsRRtQBud0eUgQh6bAB+8Ks/CQJCJC6ogVzD5irXcsYtrHB0ebFH+0mDD
 KHe08VWQL5UGsJhLavKriiCf5fFmvlkeHtrUd4Q+wmw6ARnQOPelcEOhGtO+dWT3RHM2
 3tLDjWwZeU6sg4jIhfCr4KK25YvtpTEvdkcrIc0r2pnrYTu8gF/0Niai3sSdoDo96Ltx
 bsLA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780926948; x=1781531748; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=kUL9dbW3zc3Xi3+/vcg9ikmrLca85ynlSpRuCnmgz6k=;
 b=sekmpcM0DS9kfBlA/zlZbSRv9dlXwl6Mte/b5LOYeRys78so/TEjdfQzqVrYt2KLp/
 b1iIVTTGD4TxwVp4omAmqUPqsn+6q4x3hYGeriyoY+Zs8KbTcT/pU+5gV2X0ksbn3bXM
 IBwwXlG4hZLvEYPUJPERV0ZCnBPj9iUlKtg7v+g1Jb7RbZIHanwetOvbnHLYoIGKq34u
 QWjBq8UozFVmFXjCH3Koy/ramo+3xQ8QTYF9oeRoOUsIWamKZUTn15xDvcndeUmtEccI
 laLlNebGv5OMhdRi9FDcO8Hs429Br2VGhZH5DX2e3GNhPUYv4NzjEvmKxVFdg2UqyaXi
 t/Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780926948; x=1781531748;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kUL9dbW3zc3Xi3+/vcg9ikmrLca85ynlSpRuCnmgz6k=;
 b=VAKvRDyCOMfjtcyauV24EclQt8o1HcAeZumKKhIZBMPYaAlqVYDXc8c5PtPwgx77Px
 0lM1ACPvEcUiq9xnLo68xdUcRYGan69izLcbdcWd0Q6ER8Gr1X/BY/13ij5tLRpWivZW
 rMSngaCUZPjpXwXBFH6d4ODqtdG4Fr/CrEgwXzNETVJAKM6xAX0ODpoER5xHS/V6HEHs
 pEumAk9+UUPhiC3TZudRRzD3np72mdQPiaWUwxeSoqUOLHg68Rvgnu03TTemfQ8ffvBL
 E2OjZtdudubsSDlcRcCehjalzvYZt7Zj2AJkpPcbpaEeZgl/pAgA3w1aIZNFRRRdRKfz
 cBwg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+flb+N4mHkbBu5TWSJuPKAnuTBgW4RO+oWXffJvCOv4EBC0Ty7yg5iLehIm1idL9JYawRFmEQLRoM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxWWH5Q1HqqbW+8mXnRhDKtu4s1RwXzF42pN0Jqqf9uR7kRRT9j
 My3OR+BlPzIE2M5HfeRU5YY3ov5e0N+ZuuH1V3OLoXvlq9059EYiQbbbE7Ffj7TAnp/ctIgKoqb
 lBHFCnafp/xUr/SaSMyDGQr+e0g8LHQI=
X-Gm-Gg: Acq92OE3FDFQrpA33nngtqbbP+5JSVf45PKzgmdTLNVhDORc+ZnQ1P4gc2XTsWJ2wYD
 GOcj17OXXre1aM5JJ1nyXtqerKTjGws1h1iLVI3paVSG2Z1T+S1ubcZ6VSoRWV9oWcCp/wWs7qr
 Qr0CsJhusiLWzVXO0DKsws+snapzqqxAweYxo9WXXcg2pa/GSqY7syGi7LKGLNUceBhc0QPtCyR
 sLRIOusIErqtZZmSheNtGUS+kQOg0x8L/1QS8MatYlTInBXzcmUkimqWbgjLZOAt+3YN6bIIxs+
 DmLroy16RrqNQUkT/A==
X-Received: by 2002:a05:6830:6a96:b0:7d7:fb03:f6ba with SMTP id
 46e09a7af769-7e70ca51cc9mr9845013a34.21.1780926947408; Mon, 08 Jun 2026
 06:55:47 -0700 (PDT)
MIME-Version: 1.0
References: <20260603-tcpdm-large-niovs-v1-0-f37a4ac6726c@meta.com>
 <20260603-tcpdm-large-niovs-v1-2-f37a4ac6726c@meta.com>
 <bdce2488-fe77-4f36-9ed6-dd2c785fa7c1@amd.com>
 <aiMY8CpckM8Jav0g@devvm29614.prn0.facebook.com>
 <0c86f5d3-b5e9-4cac-aa9d-30c5c8ecca66@amd.com>
In-Reply-To: <0c86f5d3-b5e9-4cac-aa9d-30c5c8ecca66@amd.com>
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Mon, 8 Jun 2026 06:55:36 -0700
X-Gm-Features: AVVi8CfreY7W3cGrHvbSozZ57SJwnE9qM8Mfsdb2X2IWGStP7CJ3YP7SRhnUHfU
Message-ID: <CAKB00G3opAoAYswsq2uz0Q6jgku8u4NthKOzCbSumZ0qK7QxcQ@mail.gmail.com>
Subject: Re: [PATCH net-next 2/4] udmabuf: emit one sg entry per pinned folio
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Donald Hunter <donald.hunter@gmail.com>, Jakub Kicinski <kuba@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, Gerd Hoffmann <kraxel@redhat.com>, 
 Vivek Kasireddy <vivek.kasireddy@intel.com>,
 Sumit Semwal <sumit.semwal@linaro.org>, 
 Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org, 
 linaro-mm-sig@lists.linaro.org, linux-kselftest@vger.kernel.org, 
 sdf@fomichev.me, razor@blackwall.org, daniel@iogearbox.net, 
 almasrymina@google.com, matttbe@kernel.org, skhawaja@google.com, 
 dw@davidwei.uk, Bobby Eshleman <bobbyeshleman@meta.com>
Content-Type: multipart/alternative; boundary="000000000000123d790653be5ef3"
X-Mailman-Approved-At: Mon, 08 Jun 2026 15:27:17 +0000
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

--000000000000123d790653be5ef3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 7, 2026 at 11:42=E2=80=AFPM Christian K=C3=B6nig <christian.koe=
nig@amd.com>
wrote:

> On 6/5/26 20:44, Bobby Eshleman wrote:
> > On Fri, Jun 05, 2026 at 11:30:07AM +0200, Christian K=C3=B6nig wrote:
> >> On 6/4/26 02:42, Bobby Eshleman wrote:
> >>> From: Bobby Eshleman <bobbyeshleman@meta.com>
> >>>
> >>> get_sg_table() emitted one PAGE_SIZE sg entry per page even when the
> >>> underlying folio was larger.
> >>>
> >>> Instead, walk folios[] and emit one sg entry per folio. When folios
> >>> represent large pages (as is for MFD_HUGETLB), each sg entry is a lar=
ge
> >>> page. Normal PAGE_SIZE sg tables are unchanged.
> >>>
> >>> Required by net/core/devmem to support rx-buf-size > PAGE_SIZE with
> >>> udmabuf.
> >>
> >> That doesn't explain why this is required.
> >
> > Sure, can definitely add. Devmem currently requires dmabuf sg entries t=
o
> > be length and size aligned when it allocates niovs for NIC page pools.
> > Though udmabuf is not violating any dmabuf contract by emitting
> > PAGE_SIZE entries and the above restriction is probably more a
> > shortfalling of devmem, by emitting a single entry per folio this patch
> > allows udmabuf to be used by devmem for large pages.
> >
> >>
> >> Please note that accessing the pages/folio of an sg-table returned by
> DMA-buf is illegal and strictly forbidden!
> >>
> >> Regards,
> >> Christian.
> >
> > It seems both devmem and io_uring zcrx at least introspect through to
> > the sg-table to build NIC page pools (not accessing the memory itself,
> > however). Is there a better way?
>
> That's an absolute NO-GO! We need to stop that immediately.
>
> Touching the underlying struct page of an DMA-buf exported sg-table is
> strictly forbidden.
>
> We even have code to wrap the sg_table and hide the struct pages on debug
> builds to catch those issues, see function dma_buf_wrap_sg_table().
>
> My last status is that the NIC page pools are build directly from the DMA
> addresses exposed by the sg_table.
>
> Was there any change I'm not aware of?
>
> Regards,
> Christian.


Oh no change, your mental model is still current.
They just go through each sg and use sg_dma_address() on each.

Best,
Bobby


> >
> > Best,
> > Bobby
> >
> >>
> >>> Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
> >>> ---
> >>>  drivers/dma-buf/udmabuf.c | 47
> ++++++++++++++++++++++++++++++++++++++++++-----
> >>>  1 file changed, 42 insertions(+), 5 deletions(-)
> >>>
> >>> diff --git a/drivers/dma-buf/udmabuf.c b/drivers/dma-buf/udmabuf.c
> >>> index 94b8ecb892bb..f28dd3788ada 100644
> >>> --- a/drivers/dma-buf/udmabuf.c
> >>> +++ b/drivers/dma-buf/udmabuf.c
> >>> @@ -141,26 +141,63 @@ static void vunmap_udmabuf(struct dma_buf *buf,
> struct iosys_map *map)
> >>>         vm_unmap_ram(map->vaddr, ubuf->pagecount);
> >>>  }
> >>>
> >>> +/* Return the number of contiguous pages backed by the folio at @i.
> >>> + * A udmabuf may map only part of a folio, or reference the same fol=
io
> >>> + * in multiple non-contiguous runs, so folio_nr_pages() can't be use=
d.
> >>> + */
> >>> +static pgoff_t udmabuf_folio_nr_pages(struct udmabuf *ubuf, pgoff_t =
i)
> >>> +{
> >>> +       struct folio *f =3D ubuf->folios[i];
> >>> +       pgoff_t j;
> >>> +
> >>> +       for (j =3D 1; i + j < ubuf->pagecount; j++) {
> >>> +               if (ubuf->folios[i + j] !=3D f)
> >>> +                       break;
> >>> +               /* Same folio, but not a sequential offset within it.
> */
> >>> +               if (ubuf->offsets[i + j] !=3D ubuf->offsets[i] + j *
> PAGE_SIZE)
> >>> +                       break;
> >>> +       }
> >>> +       return j;
> >>> +}
> >>> +
> >>> +/* Count the contiguous folio runs in @ubuf, one sg entry per run. *=
/
> >>> +static unsigned int udmabuf_sg_nents(struct udmabuf *ubuf)
> >>> +{
> >>> +       unsigned int nents =3D 0;
> >>> +       pgoff_t i;
> >>> +
> >>> +       for (i =3D 0; i < ubuf->pagecount; i +=3D
> udmabuf_folio_nr_pages(ubuf, i))
> >>> +               nents++;
> >>> +       return nents;
> >>> +}
> >>> +
> >>>  static struct sg_table *get_sg_table(struct device *dev, struct
> dma_buf *buf,
> >>>                                      enum dma_data_direction directio=
n)
> >>>  {
> >>>         struct udmabuf *ubuf =3D buf->priv;
> >>> -       struct sg_table *sg;
> >>>         struct scatterlist *sgl;
> >>> -       unsigned int i =3D 0;
> >>> +       struct sg_table *sg;
> >>> +       pgoff_t i, run;
> >>> +       unsigned int nents;
> >>>         int ret;
> >>>
> >>> +       nents =3D udmabuf_sg_nents(ubuf);
> >>> +
> >>>         sg =3D kzalloc_obj(*sg);
> >>>         if (!sg)
> >>>                 return ERR_PTR(-ENOMEM);
> >>>
> >>> -       ret =3D sg_alloc_table(sg, ubuf->pagecount, GFP_KERNEL);
> >>> +       ret =3D sg_alloc_table(sg, nents, GFP_KERNEL);
> >>>         if (ret < 0)
> >>>                 goto err_alloc;
> >>>
> >>> -       for_each_sg(sg->sgl, sgl, ubuf->pagecount, i)
> >>> -               sg_set_folio(sgl, ubuf->folios[i], PAGE_SIZE,
> >>> +       sgl =3D sg->sgl;
> >>> +       for (i =3D 0; i < ubuf->pagecount; i +=3D run) {
> >>> +               run =3D udmabuf_folio_nr_pages(ubuf, i);
> >>> +               sg_set_folio(sgl, ubuf->folios[i], run << PAGE_SHIFT,
> >>>                              ubuf->offsets[i]);
> >>> +               sgl =3D sg_next(sgl);
> >>> +       }
> >>>
> >>>         ret =3D dma_map_sgtable(dev, sg, direction, 0);
> >>>         if (ret < 0)
> >>>
> >>> --
> >>> 2.53.0-Meta
> >>>
> >>
>
>

--000000000000123d790653be5ef3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div><br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" =
class=3D"gmail_attr">On Sun, Jun 7, 2026 at 11:42=E2=80=AFPM Christian K=C3=
=B6nig &lt;<a href=3D"mailto:christian.koenig@amd.com">christian.koenig@amd=
.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1=
ex" dir=3D"auto">On 6/5/26 20:44, Bobby Eshleman wrote:<br>
&gt; On Fri, Jun 05, 2026 at 11:30:07AM +0200, Christian K=C3=B6nig wrote:<=
br>
&gt;&gt; On 6/4/26 02:42, Bobby Eshleman wrote:<br>
&gt;&gt;&gt; From: Bobby Eshleman &lt;<a href=3D"mailto:bobbyeshleman@meta.=
com" target=3D"_blank">bobbyeshleman@meta.com</a>&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; get_sg_table() emitted one PAGE_SIZE sg entry per page even wh=
en the<br>
&gt;&gt;&gt; underlying folio was larger.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Instead, walk folios[] and emit one sg entry per folio. When f=
olios<br>
&gt;&gt;&gt; represent large pages (as is for MFD_HUGETLB), each sg entry i=
s a large<br>
&gt;&gt;&gt; page. Normal PAGE_SIZE sg tables are unchanged.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Required by net/core/devmem to support rx-buf-size &gt; PAGE_S=
IZE with<br>
&gt;&gt;&gt; udmabuf.<br>
&gt;&gt;<br>
&gt;&gt; That doesn&#39;t explain why this is required.<br>
&gt; <br>
&gt; Sure, can definitely add. Devmem currently requires dmabuf sg entries =
to<br>
&gt; be length and size aligned when it allocates niovs for NIC page pools.=
<br>
&gt; Though udmabuf is not violating any dmabuf contract by emitting<br>
&gt; PAGE_SIZE entries and the above restriction is probably more a<br>
&gt; shortfalling of devmem, by emitting a single entry per folio this patc=
h<br>
&gt; allows udmabuf to be used by devmem for large pages.<br>
&gt; <br>
&gt;&gt;<br>
&gt;&gt; Please note that accessing the pages/folio of an sg-table returned=
 by DMA-buf is illegal and strictly forbidden!<br>
&gt;&gt;<br>
&gt;&gt; Regards,<br>
&gt;&gt; Christian.<br>
&gt; <br>
&gt; It seems both devmem and io_uring zcrx at least introspect through to<=
br>
&gt; the sg-table to build NIC page pools (not accessing the memory itself,=
<br>
&gt; however). Is there a better way?<br>
<br>
That&#39;s an absolute NO-GO! We need to stop that immediately.<br>
<br>
Touching the underlying struct page of an DMA-buf exported sg-table is stri=
ctly forbidden.<br>
<br>
We even have code to wrap the sg_table and hide the struct pages on debug b=
uilds to catch those issues, see function dma_buf_wrap_sg_table().<br>
<br>
My last status is that the NIC page pools are build directly from the DMA a=
ddresses exposed by the sg_table.<br>
<br>
Was there any change I&#39;m not aware of?<br>
<br>
Regards,<br>
Christian.</blockquote><div dir=3D"auto"><br></div><div dir=3D"auto">Oh no =
change, your mental model is still current.</div><div dir=3D"auto">They jus=
t go through each sg and use sg_dma_address() on each.</div><div dir=3D"aut=
o"><br></div><div dir=3D"auto">Best,</div><div dir=3D"auto">Bobby</div><div=
 dir=3D"auto"><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><=
br>
&gt; <br>
&gt; Best,<br>
&gt; Bobby<br>
&gt; <br>
&gt;&gt;<br>
&gt;&gt;&gt; Signed-off-by: Bobby Eshleman &lt;<a href=3D"mailto:bobbyeshle=
man@meta.com" target=3D"_blank">bobbyeshleman@meta.com</a>&gt;<br>
&gt;&gt;&gt; ---<br>
&gt;&gt;&gt;=C2=A0 drivers/dma-buf/udmabuf.c | 47 +++++++++++++++++++++++++=
+++++++++++++++++-----<br>
&gt;&gt;&gt;=C2=A0 1 file changed, 42 insertions(+), 5 deletions(-)<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; diff --git a/drivers/dma-buf/udmabuf.c b/drivers/dma-buf/udmab=
uf.c<br>
&gt;&gt;&gt; index 94b8ecb892bb..f28dd3788ada 100644<br>
&gt;&gt;&gt; --- a/drivers/dma-buf/udmabuf.c<br>
&gt;&gt;&gt; +++ b/drivers/dma-buf/udmabuf.c<br>
&gt;&gt;&gt; @@ -141,26 +141,63 @@ static void vunmap_udmabuf(struct dma_bu=
f *buf, struct iosys_map *map)<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vm_unmap_ram(map-&gt;vaddr, u=
buf-&gt;pagecount);<br>
&gt;&gt;&gt;=C2=A0 }<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; +/* Return the number of contiguous pages backed by the folio =
at @i.<br>
&gt;&gt;&gt; + * A udmabuf may map only part of a folio, or reference the s=
ame folio<br>
&gt;&gt;&gt; + * in multiple non-contiguous runs, so folio_nr_pages() can&#=
39;t be used.<br>
&gt;&gt;&gt; + */<br>
&gt;&gt;&gt; +static pgoff_t udmabuf_folio_nr_pages(struct udmabuf *ubuf, p=
goff_t i)<br>
&gt;&gt;&gt; +{<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0struct folio *f =3D ubuf-&gt;folio=
s[i];<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0pgoff_t j;<br>
&gt;&gt;&gt; +<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0for (j =3D 1; i + j &lt; ubuf-&gt;=
pagecount; j++) {<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ub=
uf-&gt;folios[i + j] !=3D f)<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Sam=
e folio, but not a sequential offset within it. */<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ub=
uf-&gt;offsets[i + j] !=3D ubuf-&gt;offsets[i] + j * PAGE_SIZE)<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0return j;<br>
&gt;&gt;&gt; +}<br>
&gt;&gt;&gt; +<br>
&gt;&gt;&gt; +/* Count the contiguous folio runs in @ubuf, one sg entry per=
 run. */<br>
&gt;&gt;&gt; +static unsigned int udmabuf_sg_nents(struct udmabuf *ubuf)<br=
>
&gt;&gt;&gt; +{<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int nents =3D 0;<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0pgoff_t i;<br>
&gt;&gt;&gt; +<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; ubuf-&gt;page=
count; i +=3D udmabuf_folio_nr_pages(ubuf, i))<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0nents+=
+;<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0return nents;<br>
&gt;&gt;&gt; +}<br>
&gt;&gt;&gt; +<br>
&gt;&gt;&gt;=C2=A0 static struct sg_table *get_sg_table(struct device *dev,=
 struct dma_buf *buf,<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 enum =
dma_data_direction direction)<br>
&gt;&gt;&gt;=C2=A0 {<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct udmabuf *ubuf =3D buf-=
&gt;priv;<br>
&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0struct sg_table *sg;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct scatterlist *sgl;<br>
&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int i =3D 0;<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0struct sg_table *sg;<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0pgoff_t i, run;<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int nents;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int ret;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0nents =3D udmabuf_sg_nents(ubuf);<=
br>
&gt;&gt;&gt; +<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sg =3D kzalloc_obj(*sg);<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!sg)<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0r=
eturn ERR_PTR(-ENOMEM);<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D sg_alloc_table(sg, ubuf-&g=
t;pagecount, GFP_KERNEL);<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D sg_alloc_table(sg, nents, =
GFP_KERNEL);<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret &lt; 0)<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0g=
oto err_alloc;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0for_each_sg(sg-&gt;sgl, sgl, ubuf-=
&gt;pagecount, i)<br>
&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sg_set=
_folio(sgl, ubuf-&gt;folios[i], PAGE_SIZE,<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0sgl =3D sg-&gt;sgl;<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; ubuf-&gt;page=
count; i +=3D run) {<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0run =
=3D udmabuf_folio_nr_pages(ubuf, i);<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sg_set=
_folio(sgl, ubuf-&gt;folios[i], run &lt;&lt; PAGE_SHIFT,<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ubuf-&gt;offsets[i]);<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sgl =
=3D sg_next(sgl);<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D dma_map_sgtable(dev, =
sg, direction, 0);<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret &lt; 0)<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; --<br>
&gt;&gt;&gt; 2.53.0-Meta<br>
&gt;&gt;&gt;<br>
&gt;&gt;<br>
<br>
</blockquote></div></div>

--000000000000123d790653be5ef3--
