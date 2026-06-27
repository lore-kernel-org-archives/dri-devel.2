Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 053D0C43458
	for <dri-devel@archiver.kernel.org>; Sat, 27 Jun 2026 11:11:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 607EB10E4AD;
	Sat, 27 Jun 2026 11:11:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gzgczH+Y";
	dkim-atps=neutral
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com
 [209.85.161.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B4D7B10E4AD
 for <dri-devel@lists.freedesktop.org>; Sat, 27 Jun 2026 11:11:32 +0000 (UTC)
Received: by mail-oo1-f53.google.com with SMTP id
 006d021491bc7-6a0a38a013eso1529566eaf.0
 for <dri-devel@lists.freedesktop.org>; Sat, 27 Jun 2026 04:11:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782558692; cv=none;
 d=google.com; s=arc-20260327;
 b=TTBKuCOaDSuQe6diemalqOhdd4pK02qjVyrgJGM0mC+UbxFHQQSgnVKbhZpqULdGM/
 dpOeomE7KmJ4t0wpLjNNqZ0bDlHoO2US1cTMoRu+pCYtM1Zs95MLVSxjHxjpJWyyjpD9
 B0nXV3TDNaQzK3/EyiHSElEB27HZ9x1vQmimZQ2N+UdgAXHjPaODTYsq0PP5VOWEEZu4
 F9kp1VLcH6RbQ1jpM/qHNyFjabSlG6B78MN0cG8qZQy02LXXt9C1eyykwC6ltgO/wVII
 IRIUGCKokRtcQi+LfXk/0KPZNAlg66UOWTwb6DqFdKd6rFVtQ8LlYpTTr9j1m70dgF2o
 2fFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=hM3qEvAQP+4N+WfxsG5wuceUCXkUQm4NPkDxKSERvqc=;
 fh=0zT7GfEyMYJLDg2YCoqx3t5BBlQcQ+H/4m4nr/HLz0w=;
 b=mhMFzjZeczhdCFjFB0nVNge5popVDgeHtpb5ICYyGPpi9a5eNSQiu4QxwwTICATkg8
 N4NsCrdU6lYW80V5g7SAhVYhJPCFegpjZPn0ZPAJYEGf7J5y4IfWeZhq2QbDtByFyNUt
 +/ndNQ20DrSDDRne7p57Y05A6J35EQb6V6nNwHAd/2palUf1gEb6hs5+g50hN7AaOO0+
 RYqNVz3ENbH4Gae8cbOkwPy6wo+iUSb2rhzrDX/I1bD3b6HaTg3GpBRsq2uxQOasTsSZ
 l2FadLRt1dU6C+sedr7AjOl9tbqaycNwrKDX3zB/LcmEC9S/fp2Z8Ml1e3iJGLXje3bu
 YUKQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782558692; x=1783163492; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hM3qEvAQP+4N+WfxsG5wuceUCXkUQm4NPkDxKSERvqc=;
 b=gzgczH+YQfJ6n3AbabFova2eVcbrzWlg93c/zK4s2wdm8IErjGyvBeGhE9XLqQDm79
 Wh5VoGQR+b94UVjDPFXZt8H5UCkGBhy/k5NuHXsjrUhuIYnKDEimdAclECeVkE4VXJoi
 f5iIct9VMxMwRgee3WjOerqqWfkpfE+XuMDTkIMvFTG+vAk8btnGPTEXpogFQitNY7Pn
 vL0+u6HmQmdh2mexKYz0s9zHb9KO3bRrC9t0hwJYORRXv5jULmRYAvWxcOgshLvztoeu
 n9yAHAPY0hufFU+8mxgacUMTumHjFiHO7UJvXo2fccxbefBl+hdXD9rwIzYgtiv6XJMg
 i+rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782558692; x=1783163492;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hM3qEvAQP+4N+WfxsG5wuceUCXkUQm4NPkDxKSERvqc=;
 b=dBOpeZ4l0Z3d70GnckGUzcPxhtbJKXO9sINw8XdYYEgwgAoTdI+ovsciZgvZYpj5Ev
 pkGQv7JSMr/zvBMjamw0q3FwjfrK5xJeBgUCsLicqtIVoodYpG/AtGNPAnPXDnzN29tr
 jUJ01yRXFL9+gF9w5sS5jJz4CxlpCYSCl/q3+pOOFenfxgjOLagcnUk69mbxTabM8ucH
 1TEex3g+f1I6sUU3CkbSSqijMFFz/dS40F8c4OQ81+I/QQRHIZo5U97AnRAamltaRKJQ
 scvd2yBObNzAyEXAxcbUcBHA+UyDTnwYpGohrzR7rV/Dtn9AS4POso+Nq1rndc3BH4zQ
 SpGg==
X-Forwarded-Encrypted: i=1;
 AFNElJ99yS1pJg9HBVmtGdbQl38UlH4YowHgiwvcpEnxTccGqk/UrcSWhng5g0GQF8jeKnlKi6lXnQl/BPg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyZBN44G2B1YDVMM6ZLroiq1tRlGW1l4AOmLyoAKpxUg8fz/J6/
 GLYQLH+aO/S5jefrjWGoRVbOWm/ZOMrNQ2Mfs37LAEGLchTap7vgwtKpPbkxIGwicIfzKKHtfkB
 iqY/vdv47YWNhtS1t2Cvf3sx8sajc3ME=
X-Gm-Gg: AfdE7cmWLMuXAuMRcVMd4qCxbXJesVdLTyFNr5V+icG7xBI6EtNtqhWA34E15zwrk/Z
 nWs1a6zY9wa9JILKHyhXPFeOa2IKeik+L+xw1PTTAr+eukR4hLjKfO4xmWU+V3b+i0mXLtjYCYt
 cI60PFvuuohNcNsk2mlwuQkNlAQ+nYu/mKHK7fA/D7z5BNCTnfyqaBcg9s7GhHLPwncHedfFUhp
 RcYBQrXckqyVnRAOD0YHNT9KGotKq4zQLn9NHqS37h3y4qYPR+LWcDuPeyP1YTEVpT0OXmsPYPy
 hEVM8G/j9g==
X-Received: by 2002:a05:6820:190c:b0:6a0:c657:1648 with SMTP id
 006d021491bc7-6a134417395mr6253038eaf.26.1782558691713; Sat, 27 Jun 2026
 04:11:31 -0700 (PDT)
MIME-Version: 1.0
References: <20260627105725.9083-1-robert.mader@collabora.com>
In-Reply-To: <20260627105725.9083-1-robert.mader@collabora.com>
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date: Sat, 27 Jun 2026 16:11:20 +0500
X-Gm-Features: AVVi8CcQg8HE-YlQ3EE2-S8HdLohGCCEZBPKwGztjRak5S1gKFBZyUAO90eXmNo
Message-ID: <CABXGCsPHdi3=Tpg2uZhZMuLNmg8r9Bg=OgD39eyMc=pv8gc_TQ@mail.gmail.com>
Subject: Re: [PATCH v1] udmabuf: Ensure to perform cache synchronisation in
 begin_cpu_udmabuf()
To: Robert Mader <robert.mader@collabora.com>
Cc: vivek.kasireddy@intel.com, dri-devel@lists.freedesktop.org, 
 linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Sat, Jun 27, 2026 at 3:58=E2=80=AFPM Robert Mader <robert.mader@collabor=
a.com> wrote:
>
> The message of commit 504e2b4ab97a ("dma-buf/udmabuf: skip redundant cpu =
sync to
> fix cacheline EEXIST warning") says:
>
> > The CPU sync at map/unmap time is also redundant for udmabuf:
> > begin_cpu_udmabuf() and end_cpu_udmabuf() already perform explicit
> > cache synchronization via dma_sync_sgtable_for_cpu/device() when CPU
> > access is requested through the dma-buf interface.
>
> This, however, does not apply to the first time begin_cpu_udmabuf() is
> called on an udmabuf, in which case the implementation previously relied =
on
> get_sg_table() to perform the cache synchronisation.
>
> Ensure to call dma_sync_sgtable_for_cpu() in that case as well.
>
> Fixes: 504e2b4ab97a ("dma-buf/udmabuf: skip redundant cpu sync to fix cac=
heline EEXIST warning")
> Signed-off-by: Robert Mader <robert.mader@collabora.com>
> ---
>  drivers/dma-buf/udmabuf.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/dma-buf/udmabuf.c b/drivers/dma-buf/udmabuf.c
> index bced421c0d65..08f57bc1294d 100644
> --- a/drivers/dma-buf/udmabuf.c
> +++ b/drivers/dma-buf/udmabuf.c
> @@ -224,21 +224,22 @@ static int begin_cpu_udmabuf(struct dma_buf *buf,
>  {
>         struct udmabuf *ubuf =3D buf->priv;
>         struct device *dev =3D ubuf->device->this_device;
> -       int ret =3D 0;
>
>         if (!ubuf->sg) {
>                 ubuf->sg =3D get_sg_table(dev, buf, direction);
>                 if (IS_ERR(ubuf->sg)) {
> +                       int ret;
> +
>                         ret =3D PTR_ERR(ubuf->sg);
>                         ubuf->sg =3D NULL;
> +                       return ret;
>                 } else {
>                         ubuf->sg_dir =3D direction;
>                 }
> -       } else {
> -               dma_sync_sgtable_for_cpu(dev, ubuf->sg, direction);
>         }
>
> -       return ret;
> +       dma_sync_sgtable_for_cpu(dev, ubuf->sg, direction);
> +       return 0;
>  }
>
>  static int end_cpu_udmabuf(struct dma_buf *buf,
> --
> 2.54.0
>

Hi Robert,

Thanks for catching this. You're right -- with DMA_ATTR_SKIP_CPU_SYNC
in get_sg_table(), the first begin_cpu_udmabuf() call no longer gets
the implicit CPU sync that the dma_map path used to provide, and the
explicit sync in the old else-branch only ran when ubuf->sg already
existed.

The fix correctly moves dma_sync_sgtable_for_cpu() so it runs in both
cases. The logic looks right to me.

This wouldn't reproduce on x86 since DMA is cache-coherent there
(dma_sync_* is a no-op), which is why I missed it -- it only matters
on non-coherent architectures. My apologies for the regression.

Reviewed-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>

--=20
Thanks,
Mikhail
