Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21E56CD4F54
	for <dri-devel@archiver.kernel.org>; Thu, 28 May 2026 14:54:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 67C5610F2D2;
	Thu, 28 May 2026 14:54:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="i9Az1yO3";
	dkim-atps=neutral
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com
 [209.85.208.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B76B10F2DF
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 14:54:09 +0000 (UTC)
Received: by mail-ed1-f43.google.com with SMTP id
 4fb4d7f45d1cf-6804e24803bso9628690a12.1
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 07:54:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779980048; cv=none;
 d=google.com; s=arc-20240605;
 b=NLC+4jKLeffpHG0DPkqGfGfpAAwTFJHY3bNw7rEG6FW47nAP/GIoXX+49ondpCYAgt
 CPQRG0XdrXl4TslP0O8C0mvGSracgnc7shlJulHx0rT6RkgWJ0beCKFGkwQ4fTjc7vhL
 M187L+W8r5SGJ/AU8e1v0eQG+FYF/tk0S0FKp9OklTq0cusEJn92L2ihduEx1JGoVNcW
 1cg6FvLBa/U9aubXW7q3klF1rspK1rtMVh2mCyezkO4yhO9/jTj8F3OuaD6yl5mJfm4v
 DjSWJuX7ls+emD7tR3P/g/rmIuow1k730c1924U3tbtrEbW9yWMDwYJAbHCIP6qyEZLc
 4fgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=9OXz/l5MhiOrtGyFdSgSY2UmTjKKZnnagh0u7LsCdfw=;
 fh=P0E+sN5cg43yb6/zc4TGEDl4gEzS6sh/7wsXAartqHQ=;
 b=P0nYU+x9FEdeCpoR3mDHiAgjANWi2y8ULfZiuMnIHsSobIHAhuOp1GNR5Mos+FPeUZ
 Scu6DI02SLgax5/amt2CJ/qSxU8Dfk3JcAtO6kT7b6JBblhbHfXJFBScFqhvX7PkkOOW
 RxtM9DrAJMydU50qLGfmlXTdjx9Y44Oc7jDJYbj6DgCEsf2gxg+CPndSMl3Bm/8MUu5i
 rP6UAFOV5d7JFjelvs/YHdiEZDNV2HgnO01/aW370OxZIfCoHemJuQYGVr5oVfch0Ipk
 pjV3g8NsJQjcgewxwPRqXwk2psHL0CUP1iYx6ADeFt2v1YRGYMQoSj8N3nwp9Td14enj
 Ylbg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779980048; x=1780584848; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9OXz/l5MhiOrtGyFdSgSY2UmTjKKZnnagh0u7LsCdfw=;
 b=i9Az1yO3kQX7Y/Vin5+2vQmI1xDFy0EqOUwh906PTiv/DTn0cGi3HrM5vlrZLI7P8c
 WeQEz8IEW+pCnpgquK7YwV0RtQWOd2rKjp1Fjzh9jXjtVAf1wrFDzXClvtyLdIkfKvyi
 oRPC14EWF9hh3cLwrCIPcqJA5FHnr+u11QC6HWuM4ag2wLmvISgUHU9C3gyxSqLKPvKK
 h9F3aU5IQR8FNzaczouVkRtMtSdxnQAX2j1VrFxj5UyDhlYDpAwYrvSt6JQrjpB9Uu+6
 1rmK+jXW8PmNWRJqozBoxEkj20HayYA+14MBeNEzHl9CKist7BpGEIXNRBUZEz/v+kbh
 gaGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779980048; x=1780584848;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9OXz/l5MhiOrtGyFdSgSY2UmTjKKZnnagh0u7LsCdfw=;
 b=D3XAKCkgHb6SZ1ROirhP7A5Kh9utW7bcBn+M9e3AdOEXzVF4rT8QNdLv1Hm6ur5iKA
 paBiHFvzd2n1fK+48FzA6jv32E1UIGGa/M6GPm8oShU9Xm9C8yp4Z6w6RCERzXOiTFb6
 5h1piIZpXqghh7Bw+bfPfJWqvk6WKk1OWPGGVd67rk2Ux7xa7pagG6vFBPSkaKrsnjD3
 VC0IEL0I/IFn8wLeSoxQUYs83SZzUVqBlWBnZE7oi7kw04X6gZK5PJWHSsssAbqLUDYU
 NV22TnRGQE9hX6n7DsOvmQ+ntAZz9vgtTHAiLvkwITW9ykW5ZelVB4pfI1tB3jZ8lnyr
 5egw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+m0tDpnanvbegSH2L4P/kt8cnFftyDBAUe68oy3CnMowyr4TBwZVD4W7dTqyingUzIcSWnj5ws4cY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzG9tkM1O1o4axgvViUSre83KXNtT6j9tsXBzG5M2iiPnVY6EJG
 0YUCmY2VknddIPrzbPlhJlufF2myt8YTccFwWP6ERnlAD6PBCR0YBjn3L5YWSDFstZTGNjR/Xbf
 G9DOQ67Q8PChSqh/Em/VXrGTBDnYm+171DooMCKlicQ==
X-Gm-Gg: Acq92OGzWSoDlFrBchEbR3wp6xH0FEG2IJdXCWv17kURmPFATeOu3ax663kixyySirx
 nmPErpjMqncWj5nzC2q2ZFv+AadM/my1UblLcp0LHssTO9yC7TYSNFWN1V30M1mnXW+xIxrQ5wT
 F8y0FPFMwnC6zZbLDX9fWvcvkJqpRkBl68vApeeGXk/Lk+s9ZOphfIvoKZQlDU6Tg1uogbcLHHk
 JlM+PXx9am1j2WvYYdJSRx9CQDW13FIVLphTzxJersbkxHh7hzMv7rrLY9+8I4x/femvDOLolSm
 H0YGDPrOwrSDJQfIXATiTbRJCzba/nSFU6IYZ3Vid0AAQgkZ
X-Received: by 2002:a17:907:75d9:b0:bbe:37ee:8a2b with SMTP id
 a640c23a62f3a-bdd279ce23fmr1206290366b.33.1779980047494; Thu, 28 May 2026
 07:54:07 -0700 (PDT)
MIME-Version: 1.0
References: <20260523181446.69525-1-devnexen@gmail.com>
 <ae16f5c2-c6d9-4274-9a27-f87bfe931b1f@amd.com>
In-Reply-To: <ae16f5c2-c6d9-4274-9a27-f87bfe931b1f@amd.com>
From: Sumit Semwal <sumit.semwal@linaro.org>
Date: Thu, 28 May 2026 20:23:52 +0530
X-Gm-Features: AVHnY4LutoQ-7Ka86XumSZSoxXa9nFy3SHyGiarPBSsSmWM-nR_geKS3HNuAjkA
Message-ID: <CAO_48GFOZESPnm5iLa0D+4itq7hjc9EyRUjMY4QwN5EsLn97SQ@mail.gmail.com>
Subject: Re: [PATCH] dma-buf: fix UAF in dma_buf_fd() tracepoint
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: David Carlier <devnexen@gmail.com>, gaoxiang17@xiaomi.com,
 linux-media@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
 linux-kernel@vger.kernel.org, 
 syzbot+7f4987d0afb97dd090cb@syzkaller.appspotmail.com, stable@vger.kernel.org
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

Hi David,

On Tue, 26 May 2026 at 00:25, Christian K=C3=B6nig <christian.koenig@amd.co=
m> wrote:
>
> On 5/23/26 20:14, David Carlier wrote:
> > Once FD_ADD() returns, the fd is live in the file descriptor table
> > and a thread sharing that table can close() it before DMA_BUF_TRACE()
> > runs. The close drops the last reference, __fput() frees the dma_buf,
> > and the tracepoint then dereferences dmabuf to take dmabuf->name_lock
> > -- slab-use-after-free.
> >
> > Split FD_ADD() back into get_unused_fd_flags() + fd_install() and
> > emit the tracepoint between them. While the fdtable slot is reserved
> > with a NULL file pointer, a racing close() returns -EBADF without
> > entering __fput(), so the dma_buf stays alive across the trace. Same
> > approach as commit 2d76319c4cbb ("dma-buf: fix UAF in dma_buf_put()
> > tracepoint").
> >
> > This undoes the FD_ADD() conversion done in commit 34dfce523c90
> > ("dma: convert dma_buf_fd() to FD_ADD()"); FD_ADD() has no place to
> > hook the tracepoint safely.
> >
> > Reported-by: syzbot+7f4987d0afb97dd090cb@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=3D7f4987d0afb97dd090cb
> > Fixes: 281a22631423 ("dma-buf: add some tracepoints to debug.")
> > Cc: stable@vger.kernel.org # 7.0.x
> > Signed-off-by: David Carlier <devnexen@gmail.com>
>
> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>

Thanks very much for the patch; applied to drm-misc-fixes.
>
> > ---
> >  drivers/dma-buf/dma-buf.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
> > index 71f37544a5c6..d504c636dc29 100644
> > --- a/drivers/dma-buf/dma-buf.c
> > +++ b/drivers/dma-buf/dma-buf.c
> > @@ -792,9 +792,13 @@ int dma_buf_fd(struct dma_buf *dmabuf, int flags)
> >         if (!dmabuf || !dmabuf->file)
> >                 return -EINVAL;
> >
> > -       fd =3D FD_ADD(flags, dmabuf->file);
> > +       fd =3D get_unused_fd_flags(flags);
> > +       if (fd < 0)
> > +               return fd;
> > +
> >         DMA_BUF_TRACE(trace_dma_buf_fd, dmabuf, fd);
> >
> > +       fd_install(fd, dmabuf->file);
> >         return fd;
> >  }
> >  EXPORT_SYMBOL_NS_GPL(dma_buf_fd, "DMA_BUF");
> > --
> > 2.53.0
> >
>

Best,
Sumit.
