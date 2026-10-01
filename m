Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB58BCA5FA5
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 06:03:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B44B10E0D9;
	Thu,  1 Oct 2026 06:03:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=canonical-com.20251104.gappssmtp.com header.i=@canonical-com.20251104.gappssmtp.com header.b="UmDCLgwy";
	dkim-atps=neutral
Received: from mail-lr2-f34.google.com (mail-lr2-f34.google.com
 [74.125.230.98])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3FBF610E03D
 for <dri-devel@lists.freedesktop.org>; Thu,  1 Oct 2026 06:03:40 +0000 (UTC)
Received: by mail-lr2-f34.google.com with SMTP id
 38308e7fff4ca-3a772de44c5so13956981fa.1
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 23:03:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790834618; cv=none;
 d=google.com; s=arc-20260327;
 b=L8lBbVwcFbpHW5Nqxi3/6nKdXirwtyrmmccSWenrel5Lkc+hRif/FVW78Qqj1m1F/u
 6vEAtqNJNtlqOw5j1JiObBDK+tEIwk1BLuDeOCV1c1Y6kT3SBnEhGdvQhBIYY028qRMs
 ZlUJ1kP8ltINRIcFsrE0QAPe17tgXZKanlooqEPwNvX98pqO4aBHbBeTt/6MCpvLm/fs
 8PTo/IECDEvTyLLcJq7IZe5o8p4dd4RfEHCXYtclfCZdzSOJ67vZrryiIwCeCPUeIpa1
 N+njrAik1zRWkyZo9sPhy6Yay6ZZaN+/EKiSm08Iky+cWen1I64ghVQ8PiprP+C6196c
 r0fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Hgp1C/l5toz2Y4Urz7dWHnR34B0fNj/IjonzU3eqplI=;
 fh=msAaavPfRDJ5cwcMsHMnp2iLnXE3RvpJLcY7SS7yPaU=;
 b=Qb8SB5f/lJZqcxsqWxgFq6wrmmnnLjbE2xInFStoWN1XtJYEtW+CPHo2nRg4hIio6A
 Az0uiy3xCsz1/kyL6Kpmy/snOrn2sGVXebs1sIp0dBvYM16ZFoOtKG7K/8bTnYiRZ1mO
 DLeKvIn57/PLbzYuP8aiwMlXIJkUsQri6+hgDNo8rjTWVeB4kvNy7pxjud1sx1aBGMis
 oylPmpyC0loTtr3TR+GmPVQAiVeQ+TI3d/cU/h1VyfCez4tbGbEF9gEm01PTW+cfEOd7
 jlAhV8Sr9Jpw6//NMif2fxaWX166UA6EUaT0rSWQljVljcJg+hyhk01t/zXa4o0VYE0M
 Rr3A==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=canonical-com.20251104.gappssmtp.com; s=20251104; t=1790834618; x=1791439418;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:to:subject:message-id:date
 :from:in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Hgp1C/l5toz2Y4Urz7dWHnR34B0fNj/IjonzU3eqplI=;
 b=UmDCLgwyu2y0Bl7jt0nGhbCYhW71SSnmVQrlD4G/qfuCSI1mULoPqxJBnDYeBJZlpj
 sODBDPpEjtX9t/2/a73FmEQVqftYnb0fzHbBnZKaiHLeKb2FzoVV8dQK/MWjVj6FezUZ
 sSZKtZtU7Oxj/NnnvwRYIckmXM29AdHet3Lx9MGMLmBKkgvr+/WtDXSmbMxAgCOaiIMq
 JApw208jnsHG+B3gM63/KYD1Re4oFM7rcgHmJWhhDNcTla6tU9xTYA4p/GjQpzX0llKE
 mljwUov9YaT8p9vvhfOwsRH4jdOGCblSIniPrAX2iWNDuLHysFP8O06OWro+LaRBOOaM
 tZWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790834618; x=1791439418;
 h=content-transfer-encoding:content-type:to:subject:message-id:date
 :from:in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Hgp1C/l5toz2Y4Urz7dWHnR34B0fNj/IjonzU3eqplI=;
 b=RQvW8Ah2liavaAZj16TQQQlkMmjT+Huyq+jmw5MSAZBz4xCacdvudqNaNkE/JuKTKj
 Gbm6F0DIVJhP3puYjIf4STDMcBKpmBv0Xwt3Wy8yhV85oHX9EUxkpChVjEt0+UipaEqY
 YSamBzC+IGym9/HkIA556r50CdHDrh0lEVxVGgWdOVEpcMh2lkFBPAU0KA5Hre6vzUBB
 IKSV4BvbfpSd4P6FZWOdadAljyHXu63GkVG7zNPtAepP+75lWd37ePeJ9fbpHJ3qZe1d
 hu5iRgC44MXz+hJAzHTmqMduY9cJ4NfehqYx/e4d6Hdbd05yH0mf5n+dMmKHsRWuEBlL
 wzLA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxStpZG0ROdYz/vtBO9ZfPdrtmurKQxp5r1og9JLMNKnvYeyM+nn5ccltvOmojj4sf4xJskzygUBfU=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYI6VoIsO0mLDxX509E7M2GcCvKysFhOLTa3IKUfX4qRjvRddPri
 R+h6+biMhIiEv28F35eNTxtjsVVxmwYDvs09GDhzIP9rxev9E+o5D/oJ6xzgrYa7f3yiQE04MZb
 /muwqNovBlC+lcunkokmgl9jHT10ziaQ=
X-Gm-Gg: AYBFou0/ub6xADkTG/N5ONXFDmPU03ygET7n2sRfxS1xSIsouuKIiuuYLbHNFkJdl85
 DmkKyEAhZFjwjwArCOPfSADRH86DqHymhAJdDDPGFhtjiXqtxoxlFFG+BDYscUSIHTNFLdQayPp
 w1CjoV1VJP2NNXd1x/56vwqrCXBVdsJUfZWB8ypC6mhQWfeMuildQbW91CpkQ2BOm6mBwECumPI
 MsxwTAiC48VUUwC7OagAEmaZcsibH2QizTMzbyZLwvnG+ICa4LPnLF/eSwZyeJuXw4ccZtIUVOO
 y/r1UBWmiImq2VMOdrT8yQTR8UP57+2ZRkjO6yHONNIpQYXVNXR44o0=
X-Received: by 2002:a2e:be07:0:b0:3a6:568f:40eb with SMTP id
 38308e7fff4ca-3a7792077a2mr11432771fa.27.1790834617800; Wed, 30 Sep 2026
 23:03:37 -0700 (PDT)
MIME-Version: 1.0
References: <20260114011917.241196-1-acelan.kao@canonical.com>
 <CAMz9Wg_i5Sgewa2N7jfEoNJrp5jMp+O5m+kM=VN9rWKcGLzQXA@mail.gmail.com>
In-Reply-To: <CAMz9Wg_i5Sgewa2N7jfEoNJrp5jMp+O5m+kM=VN9rWKcGLzQXA@mail.gmail.com>
From: AceLan Kao <acelan.kao@canonical.com>
Date: Thu, 1 Oct 2026 14:03:26 +0800
X-Gm-Features: AclHuK8bG-XKFgjsQDqse9lVQ8q5WyIRi7oBeYeYkMJTSBRhJ-JWaOzReixkG5Y
Message-ID: <CAMz9Wg_E686NQe5XigWX6s2mbWE4t2DoTvW+GmtMzN6bP0tQ4Q@mail.gmail.com>
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

AceLan Kao <acelan.kao@canonical.com> =E6=96=BC 2026=E5=B9=B44=E6=9C=8813=
=E6=97=A5=E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=884:10=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> Chia-Lin Kao (AceLan) <acelan.kao@canonical.com> =E6=96=BC 2026=E5=B9=B41=
=E6=9C=8814=E6=97=A5=E9=80=B1=E4=B8=89 =E4=B8=8A=E5=8D=889:19=E5=AF=AB=E9=
=81=93=EF=BC=9A
> >
> > The VFS now warns if an inode flagged with S_ANON_INODE is located on a
> > filesystem that does not have SB_I_NOEXEC set. dmabuf inodes are
> > created using alloc_anon_inode(), which sets S_ANON_INODE.
> >
> > This triggers a warning in path_noexec() when a dmabuf is mmapped, for
> > example by GStreamer's v4l2src element.
> >
> > [   60.061328] WARNING: CPU: 2 PID: 2803 at fs/exec.c:125 path_noexec+0=
xa0/0xd0
> > ...
> > [   60.061637]  do_mmap+0x2b5/0x680
> >
> > The warning was introduced by commit 1e7ab6f67824 ("anon_inode: rework
> > assertions") which added enforcement that anonymous inodes must be on
> > filesystems with SB_I_NOEXEC set.
> >
> > Fix this by setting SB_I_NOEXEC and SB_I_NODEV on the dmabuf filesystem
> > context, following the same pattern as commit ce7419b6cf23d ("anon_inod=
e:
> > raise SB_I_NODEV and SB_I_NOEXEC") and commit 98f99394a104c ("secretmem=
:
> > use SB_I_NOEXEC").
> >
> > Signed-off-by: Chia-Lin Kao (AceLan) <acelan.kao@canonical.com>
> > ---
> >  drivers/dma-buf/dma-buf.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
> > index a4d8f2ff94e46..dea79aaab10ce 100644
> > --- a/drivers/dma-buf/dma-buf.c
> > +++ b/drivers/dma-buf/dma-buf.c
> > @@ -221,6 +221,8 @@ static int dma_buf_fs_init_context(struct fs_contex=
t *fc)
> >         if (!ctx)
> >                 return -ENOMEM;
> >         ctx->dops =3D &dma_buf_dentry_ops;
> > +       fc->s_iflags |=3D SB_I_NOEXEC;
> > +       fc->s_iflags |=3D SB_I_NODEV;
> >         return 0;
> >  }
> >
> > --
> > 2.51.0
> >
> Hi all,
>
> Please help to review this patch.
> It does the same thing as
>    ce7419b6cf23d ("anon_inode: raise SB_I_NODEV and SB_I_NOEXEC")
> and
>    98f99394a104c ("secretmem: use SB_I_NOEXEC")
> Thanks.

A gentle ping

--=20
Chia-Lin Kao(AceLan)
http://blog.acelan.idv.tw/
E-Mail: acelan.kaoATcanonical.com (s/AT/@/)
