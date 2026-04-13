Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 651A2EBFD0F
	for <dri-devel@archiver.kernel.org>; Mon, 13 Apr 2026 08:11:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD72C10E0B9;
	Mon, 13 Apr 2026 08:11:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=canonical-com.20251104.gappssmtp.com header.i=@canonical-com.20251104.gappssmtp.com header.b="PIt/MoM7";
	dkim-atps=neutral
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com
 [209.85.218.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A7E810E0B9
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 08:11:09 +0000 (UTC)
Received: by mail-ej1-f52.google.com with SMTP id
 a640c23a62f3a-b9c745e18a0so472768266b.1
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 01:11:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776067868; cv=none;
 d=google.com; s=arc-20240605;
 b=jG7vi2fHKW0pAhxVx6zdFQinqz/5E7YDZbSZOz0J100309+GQ+dmL5noxI7U1ScfEt
 SpuO1ajGWc+2WJGn7VQVbUJad1sjJuJ+xWBkguAu3oiqHjdZ9ugRfXniLPRX3Q18VyBr
 5IA64oZVq0I/xGs2bvn1PeSCA4wBxidT2livkkVsptDAJPLkkrZ3nTYQarDHieQoImmr
 FRiIVuicr1LRAKSo8kE+d4cL/AaIBho7pwgr8alJ0V8YijOytGM2BIhV+ar+QjqBfdc1
 duc/9fSvspZD945236Ki7MCYkUNd14+FQTdQ4DjXGb45e4R1UQ3nLLzrW/+Esp0rLgKB
 mfzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Cm/2yTJZucI3GwBHuZBqSf0fctqmWzcYTDaRRhyvpf4=;
 fh=9X8Q++H/P/5+qeYBDWrQ+zvETlR8DS9p2OTHiIHP4G8=;
 b=GYY8tQ5afLUguhgLOXSwRj0oDjkp7hMP9GTeUappenHbv6XolSQIMSiA6epyhhL/Bm
 CdCzpkNSPuZkghqoi22+V5bAMJSXH5ZUBSJqVx4RQP6KneDSCkAsnbnSSEoXfLzA3IBH
 9w7Mf2sjU2PAPF6A+3am2nfu68ebBt1U1XXOjMe7E9evuOt0rUXcW24QUlc6dtCq+21D
 qjdhYXSfwEtUZ7JtEfvFb1BZvztHV3XvgJ1G67A3tMmGo+jF2aujs/0iqOaEngaup57J
 b6qGqZakI9aqZSnrcJd7SPUuHZyc69nSOMjpmxUfHM/XIa3mg2t2VJtWOVa27PbqSN2w
 kptw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=canonical-com.20251104.gappssmtp.com; s=20251104; t=1776067868; x=1776672668;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Cm/2yTJZucI3GwBHuZBqSf0fctqmWzcYTDaRRhyvpf4=;
 b=PIt/MoM7NHIyDR+imQiAKGQwPsBlKcpDT83TmLEL5uQeagsqk0JvQ3EXinbcSKI36h
 TM7oy1+b7CmHgWglKPlBAwRqX4jxDwjXebQO0rGtHD4NLme4hlic7mLXlPdmzMG1+zpl
 GMqkLpJSFaBe5pY4az1QJWD0VATPEXWRu6BgfGCQtBPt9c6hXMkxWPstwkBpICdfCWaU
 LmEoEmp/jPTUFNEp3bh2h0eBAtcyncvvZMBs8rWE4kDRW6ZvvNqNDd+Uu+CHQpK8ju0w
 0b/ZkdBdpkWrdBFNNnPjgOd9BcCpKz2w7zkuvqbVWP4JunvmhJyzQwSS90l3Ws60PpWs
 TV5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776067868; x=1776672668;
 h=content-transfer-encoding:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Cm/2yTJZucI3GwBHuZBqSf0fctqmWzcYTDaRRhyvpf4=;
 b=Pc5JgAwFCTwVnVxDgKp3AftaxU3afZ/QLykAwjQpFCaMLgkUsBkCXaW7tDuInjT5FD
 lwfkbKoYWI4coPquoBqmivmjeVXBkkNDRvdarP/cbXT0It4zm1nGDivfdaCnR+pwCGc/
 bTnujaP/zTdtqL3ekfTLUli6m+N0EgktiWBXUiJvLad94K+pbLE61hr0dvI/VBJLFemX
 VKhHYVRWjSbxvPg8s/7KjHj0wdXLP3dX2PclQ6CebMRZy1pBXkAo6baKcgKie/us5vkm
 ZN4CRuBAR5zbkfXsLKn7hcGsNAfoRy1+96aOAPkAePlsGyAu/HOvQ7iG+T2yf/zFy/gD
 5DeA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/Af9it9gqgrw+y9ZeKG3fnu+va8+SXm6GqgBTzSnKIi0CqrLGa0382i5dY7lAZqgHu7LoUhuX2hBo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxoH3fxA09zXDi/8G+sldOo+AKmfPYo6V40dq0UwOM27/fTHFiK
 CdMDbJdnPsCuDsk2NSVnAX01r1HQit3NZIHb9i7VCJR6FfsjAYyVlFnhurwsHWQdNumBz/DuKp4
 iivsHjnLz5xV9Ug1/rQRjtDzZzFM23RY=
X-Gm-Gg: AeBDieuCJ7cU5YDvWAR4mYqEVEwktk61qNSG6ETnDjEnzLqHckWugtPZFZqtkyDuzVJ
 kTmtPoMQouTVRC9SYtVkSrhjLy2DP/81rjSIkX7xaRjcPV1kdZdi5XH+fZ1GGeavcGKdaePgAYy
 ngkmXVWQliUQkspnWtNKuYH1YSFWIggc0uASxGpW68HmOp/yz+5tZEgVAL6AoQBhNVMAbCHoa+X
 ME73roLB0jtJWBO9dxx8s9BzkNKelhDZuwMosDCOj0tz7HWi8wiC5dA8xaXpRC3AS8baTWDP4e4
 VOZZty/omplc8TLufrM=
X-Received: by 2002:a17:907:1b22:b0:b97:fec5:eced with SMTP id
 a640c23a62f3a-b9d45b64482mr833752966b.0.1776067867411; Mon, 13 Apr 2026
 01:11:07 -0700 (PDT)
MIME-Version: 1.0
References: <20260114011917.241196-1-acelan.kao@canonical.com>
In-Reply-To: <20260114011917.241196-1-acelan.kao@canonical.com>
From: AceLan Kao <acelan.kao@canonical.com>
Date: Mon, 13 Apr 2026 16:10:54 +0800
X-Gm-Features: AQROBzAUM-FyVmyBMIfewJCZMi_4s_1U1SPVgwvrtxpwOIQt1R-Yr616qRFplZw
Message-ID: <CAMz9Wg_i5Sgewa2N7jfEoNJrp5jMp+O5m+kM=VN9rWKcGLzQXA@mail.gmail.com>
Subject: Re: [PATCH] dma-buf: set SB_I_NOEXEC and SB_I_NODEV on dmabuf
 filesystem
To: Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
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

Chia-Lin Kao (AceLan) <acelan.kao@canonical.com> =E6=96=BC 2026=E5=B9=B41=
=E6=9C=8814=E6=97=A5=E9=80=B1=E4=B8=89 =E4=B8=8A=E5=8D=889:19=E5=AF=AB=E9=
=81=93=EF=BC=9A
>
> The VFS now warns if an inode flagged with S_ANON_INODE is located on a
> filesystem that does not have SB_I_NOEXEC set. dmabuf inodes are
> created using alloc_anon_inode(), which sets S_ANON_INODE.
>
> This triggers a warning in path_noexec() when a dmabuf is mmapped, for
> example by GStreamer's v4l2src element.
>
> [   60.061328] WARNING: CPU: 2 PID: 2803 at fs/exec.c:125 path_noexec+0xa=
0/0xd0
> ...
> [   60.061637]  do_mmap+0x2b5/0x680
>
> The warning was introduced by commit 1e7ab6f67824 ("anon_inode: rework
> assertions") which added enforcement that anonymous inodes must be on
> filesystems with SB_I_NOEXEC set.
>
> Fix this by setting SB_I_NOEXEC and SB_I_NODEV on the dmabuf filesystem
> context, following the same pattern as commit ce7419b6cf23d ("anon_inode:
> raise SB_I_NODEV and SB_I_NOEXEC") and commit 98f99394a104c ("secretmem:
> use SB_I_NOEXEC").
>
> Signed-off-by: Chia-Lin Kao (AceLan) <acelan.kao@canonical.com>
> ---
>  drivers/dma-buf/dma-buf.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
> index a4d8f2ff94e46..dea79aaab10ce 100644
> --- a/drivers/dma-buf/dma-buf.c
> +++ b/drivers/dma-buf/dma-buf.c
> @@ -221,6 +221,8 @@ static int dma_buf_fs_init_context(struct fs_context =
*fc)
>         if (!ctx)
>                 return -ENOMEM;
>         ctx->dops =3D &dma_buf_dentry_ops;
> +       fc->s_iflags |=3D SB_I_NOEXEC;
> +       fc->s_iflags |=3D SB_I_NODEV;
>         return 0;
>  }
>
> --
> 2.51.0
>
Hi all,

Please help to review this patch.
It does the same thing as
   ce7419b6cf23d ("anon_inode: raise SB_I_NODEV and SB_I_NOEXEC")
and
   98f99394a104c ("secretmem: use SB_I_NOEXEC")
Thanks.
