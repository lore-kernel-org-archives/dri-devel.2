Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 946CD606A326
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 20:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=iKXYin1P
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C7FC310FDC8;
	Wed, 11 Nov 2026 20:01:11 +0000 (UTC)
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com
 [209.85.160.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 746D810FD9D
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 20:01:05 +0000 (UTC)
Received: by mail-qt1-f170.google.com with SMTP id
 d75a77b69052e-5383c97c8cfso30651cf.1
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 12:01:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794427264; cv=none;
 d=google.com; s=arc-20260327;
 b=j/YGdlUPzImDtqHQZuM0Q6oR3V5CmuansYkl7dJOU9+5+krc+EA/M/QE6CqTU8GjiH
 ffRJ2eedYZR5zI4Ubou5CITNm5szaKw8o1Xls/fjQOgjHWeBsBccrncujeRjBeV/MPdl
 nUIdwxUTk1YslHV9v8kW5WCeOg0aFo8KwEV1+w+0AegT8GjgyIEG5+V4dkxM8NsTl7c3
 CmBd1Ei8JWd4eOvoWBoDkEE+4Vv3wUhvbcss2nopYTRXUErIjtZk3LrdxEe4jPEU8Wi/
 0cCuhC/JV+fkeA09z3SPznckv1tUKd+X9ShuACrOth5nOStfP5mncYLar2cQroq9QU46
 6E0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=oLVXFVt29dYBkYQT6UIOPSuTbBUgUXoB7bt0qWYFj0Y=;
 fh=1mt0Zew4OAR+Ygdgapy5M8eOArKXMwPLhAbagaVWwEw=;
 b=OnonURMunDfMDpZZF7eGTOeC6FmNdLXLhGQj1Km4Xu16gWWvgNuNcJyBs1rseqHvDf
 G/IiWgOG8Rwx/yKeTJ6z0tqGZiAhhEHkNrVu2P70EOa5d+I4pnh1AWEvy9fGCXsooI3s
 HkDx3IJ1eBOwbSVP1T5nxB92+cEdoqutwdLPDua/YUm5kHln60B31p1s1Gp+5K9tcjyq
 nsS1DOLfk2E/AP8kdSQC4iofZcuaFNJw9RTVelCSMtwuirpe6ljshi7RnD/rEFSzr9a/
 Ggaqxb3rFzy+SnsLfk64aYsy86Xl+f/DjaNRZjuBIVh6/ik3S8wrlGmHjsEwNlsxbQHe
 u/Zw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1794427264; x=1795032064;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=oLVXFVt29dYBkYQT6UIOPSuTbBUgUXoB7bt0qWYFj0Y=;
 b=iKXYin1PpqTyEUGxGjQ4vIfnNaYKF/W3Q6IwJ3AVyq8iT2bxCBbaBYBSwqSTRGP1iG
 WamGQBA5GMv2sB8nJDQsS3120xcqedHifsBJ9W6nnFukdQhhNiESzXGi172XO0Qr7qd5
 XspofFOkwnQrfgFzqL2cgWPachNknrY3NounXvO+Zu4JTvViaGPvLU+HmFxaNKlLhXSm
 YghVvFiwu/npn/R6Ytzedge6aqjdm7rzeppGHZfFl5+aClIYCf3NjZqnfDspimWigFty
 LqCkPtnzNoagspouydQLdkMuxK5V0g/K+GenN3LIuHwDXAzG4cR9YK/UnhmXCRfdEvUh
 JDGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794427264; x=1795032064;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=oLVXFVt29dYBkYQT6UIOPSuTbBUgUXoB7bt0qWYFj0Y=;
 b=AbRvokGkVWcosMoi5qzxGsBlR+qC+UKJ377gg3g9RC8wn4qt6xiHvVApXYxuZ21Xrg
 m310M2iJCa+oSGAEOPquz2V1U5GPP1rvn6fKNce/AkAB09z1AKlFtXHP5MzfKGghoabr
 gtFFUPxcjTEBtY7goZgYHRWUtt1BA2a9h72Eq+yVwas/7o2rSy9RkdT7QxZDhCE5Sx9F
 bwZlPomiyQwhnsjFuAxkk3Nv6Rnp5RVor/Xklo0TYGKFCAsqsD/CRLJC9qxKBI3CoaFH
 U3SGCdGHJkIU/5qk6OdUjyqhkcd8TtRr+lROCvEcNzfaK6L/rEfh7t8QJxdwCg5XNWej
 9n1g==
X-Forwarded-Encrypted: i=1;
 AL+hErGmwCx9bGuf7s/ht5VXrczR7KM7UzqogUPBNv/IJz7bvOHPyi7FFFW7ORIp7ZDvV2FcVUedsVZXYu0=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+aalUUo73+4kdk75YfXZic5OKlgogO/OEAln8FVaxOZKgFuIkl
 hvKK0GFnPEcLv4Jq67NKbsGsnrtXDeTXVJogmt+oM0igWoIsfisr4jH2RP7SAuPsWg44nOF+eps
 pRXHsscAWszH+PP8pb/3fl+6hb3fPM8RoAQuC0oj8
X-Gm-Gg: AYBFou28bL5Av5VRnxc+xWzEC7gNwdSWouC+f2j/DMrVu5qyV1wEZ+BWn2NMpPP7KRB
 kATxZ4PgKxWxp2GnUa1yId1YXxN4NrH+ixtPaLph4tFenWR+686IVTsCT9ODEN2V++3nY9ispgq
 erkZWau2WIUkeNRRFNoMMCADLkVfuwDD85heUf8tZdybeuhU1uBiMoTl7JC1r0TRq2+HIwgiJUO
 z+cGj2WHnGJGj5/M2ql/NZlNPxPq9JCrgwzP081Uum2R0OysXhL1sKdrEh6XtgkQgt1Hv8rBWX/
 DPkXUJJOe82OowWgk7nFqah8ALtrWkEXGs2AWXktfBY9XnTwRaYCmeOgvovw3cO8FE5hYFvyTzL
 B0Id+Yn6XgOuNGjhQZf4bJHCVBaAgJeyMHaU0oCOmsx8mDqdOTarqwRlWbOzSsIrkS9yJHPdXx4
 GnZ8Ax7B1kQzxItNGk2VIKxA==
X-Received: by 2002:a05:622a:2b4b:b0:535:ce3:ee07 with SMTP id
 d75a77b69052e-559710b30e1mr1999241cf.13.1794427263429; Wed, 11 Nov 2026
 12:01:03 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261110125106.2935677-1-k.chen@smail.nju.edu.cn>
In-Reply-To: <20261110125106.2935677-1-k.chen@smail.nju.edu.cn>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Wed, 11 Nov 2026 12:00:49 -0800
X-Gm-Features: AclHuK81JcIQVOh-tqCQX9JsRqdWOHCGs7dqRFvbpp7CrwexNznx4vXc5gM5Rp0
Message-ID: <CABdmKX09vLG4U-7FwF-vm_iTy1AjGUPXka08KhWE+qJ0J=XGMA@mail.gmail.com>
Subject: Re: [PATCH] bpf: make dmabuf iterator stay drained after NULL
To: Kang Chen <k.chen@smail.nju.edu.cn>
Cc: Yonghong Song <yonghong.song@linux.dev>,
 Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Sumit Semwal <sumit.semwal@linaro.org>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Philipp Stanner <phasta@kernel.org>, linux-media@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
 Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-23.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 10, 2026 at 4:57=E2=80=AFAM Kang Chen <k.chen@smail.nju.edu.cn>=
 wrote:
>
> bpf_iter_dmabuf_next() uses kit->dmabuf =3D=3D NULL to mean "iteration ha=
s
> not started".  dma_buf_iter_next() also returns NULL at the end of the
> list, so a next() call after exhaustion restarts from the list head.
>
> The verifier relies on the iterator contract that once next() returns
> NULL it keeps returning NULL: process_iter_next_call() marks the
> iterator DRAINED and treats the result of later next() calls as the
> constant zero.  A restarted dmabuf iteration therefore hands the BPF
> program a kernel pointer while the verifier believes R0 =3D=3D 0.
>
> Use an invalid pointer value as the drained sentinel so the iterator
> state keeps its one-pointer ABI, and skip dma_buf_put() for it.
>
> Fixes: 6eab7ac7c5ee ("bpf: Add open coded dmabuf iterator")
> Signed-off-by: Kang Chen <k.chen@smail.nju.edu.cn>

Thanks for this fix. The cgroup (bpf_iter_css_next) and scx_dsq
(bpf_iter_scx_dsq_next) iterators look like they also have this
problem.

> ---
>  kernel/bpf/dmabuf_iter.c | 23 ++++++++++++++++++++++-
>  1 file changed, 22 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/bpf/dmabuf_iter.c b/kernel/bpf/dmabuf_iter.c
> index cd500248abd9..a2b7c38f9ae6 100644
> --- a/kernel/bpf/dmabuf_iter.c
> +++ b/kernel/bpf/dmabuf_iter.c
> @@ -156,6 +156,13 @@ struct bpf_iter_dmabuf_kern {
>         struct dma_buf *dmabuf;
>  } __aligned(8);
>
> +/*
> + * The iterator state is one pointer wide because struct bpf_iter_dmabuf=
 is
> + * part of the generated vmlinux.h ABI.  Use an invalid pointer value as=
 the
> + * "drained" sentinel instead of growing the state.
> + */

This comment explains why this patch uses a sentinel instead of
growing the state, but that doesn't help anyone reading this code in
the future. This belongs in the commit message, not a code comment.
The real constraint is that the size of bpf_iter_dmabuf is
user-visible API, so it can't grow without breaking backwards
compatibility.

> +#define DMABUF_ITER_DONE       ((struct dma_buf *)1L)

I would prefer this to be DMABUF_ITER_START to mirror the kmem_cache
iterator. Then the second if (!kit->dmabuf) block in
bpf_iter_dmabuf_next() below could also be removed.

> +
>  __bpf_kfunc_start_defs();
>
>  __bpf_kfunc int bpf_iter_dmabuf_new(struct bpf_iter_dmabuf *it)
> @@ -173,11 +180,25 @@ __bpf_kfunc struct dma_buf *bpf_iter_dmabuf_next(st=
ruct bpf_iter_dmabuf *it)
>  {
>         struct bpf_iter_dmabuf_kern *kit =3D (void *)it;
>
> +       /*
> +        * The verifier assumes that an iterator which returned NULL keep=
s
> +        * returning NULL (see process_iter_next_call()).  Without this c=
heck
> +        * the NULL left by the last dma_buf_iter_next() would be interpr=
eted
> +        * as "not started" and the iteration would restart from the list=
 head.
> +        */

Same here, this is commit message material. If you want to add a code
comment, referencing the rule from bpf_iterators.rst should be enough:

/* Once NULL is returned, subsequent next calls should keep returning NULL.=
 */

> +       if (kit->dmabuf =3D=3D DMABUF_ITER_DONE)
> +               return NULL;
> +
>         if (kit->dmabuf)
>                 kit->dmabuf =3D dma_buf_iter_next(kit->dmabuf);
>         else
>                 kit->dmabuf =3D dma_buf_iter_begin();
>
> +       if (!kit->dmabuf) {
> +               kit->dmabuf =3D DMABUF_ITER_DONE;
> +               return NULL;
> +       }
> +
>         return kit->dmabuf;
>  }
>
> @@ -185,7 +206,7 @@ __bpf_kfunc void bpf_iter_dmabuf_destroy(struct bpf_i=
ter_dmabuf *it)
>  {
>         struct bpf_iter_dmabuf_kern *kit =3D (void *)it;
>
> -       if (kit->dmabuf)
> +       if (kit->dmabuf && kit->dmabuf !=3D DMABUF_ITER_DONE)
>                 dma_buf_put(kit->dmabuf);
>  }
>
> --
> 2.34.1

I think we should also add a test for this. I've sent one as a reply
to this thread. It fails without your fix and passes with it. Feel
free to add it as 2/2 in v2.
