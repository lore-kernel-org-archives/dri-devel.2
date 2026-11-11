Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79B0606A321
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 19:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=BxXUwVTl
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 148B810FD55;
	Wed, 11 Nov 2026 19:54:31 +0000 (UTC)
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com
 [209.85.160.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA67510FD9D
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 19:54:24 +0000 (UTC)
Received: by mail-qt1-f175.google.com with SMTP id
 d75a77b69052e-533202fe429so38261cf.0
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 11:54:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794426864; cv=none;
 d=google.com; s=arc-20260327;
 b=k2zW9PpLCZwBLb2mK2kqEgXP2zO+zXCW384mTuH2b/YAlbA8Rx/62cP0EgAb0apQxL
 xhG102/LT6s4HJ04Gw+s9tT8JC4yW2MR/HqZ5bfQRuR880fewzh1aO8jkhM8Ya/2NSW4
 55DCL7D04Euf4QAd15ZBlf0lA8hcTXGU9UIuaYfsGqzlSgFQsreU2OcB56CAl5PKkGsA
 gLBzFQCxSHdl8kCQnHJ+0trGPSU2e3XgRrBEQw5jz3qg2hUqURCCiDb7qnrwxg7NRlbu
 WEjxfS+6AowpayVj5NGku+dbvXH79ZLD7Mg/9gM0g/35hI9jpL/++XLuoEXbZbDJddks
 VtwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=uz4m71nRD6f+qddgfa2gOOtoUGlSJn5F5ou4PIom6y8=;
 fh=gH/Tm9kCZQZqsPg6mtTjTxkoY27aOF9Cv+kYrnlykS0=;
 b=qjPG8L0LiKfG5XSeOsDenea5wvmwEyMNTOr99nHCned0UAVD3aHe+zriToKnOpuSZk
 +1E2NDxjSZd4T4hs7sCMG0pft+kH1zKUmnZK6L8YAsQ7D7fYLzkr2AypxRpZYgt4jmP0
 e6h33l1va/2crRtDDqzJvQu7JSTwJc1kMhVACmEIbhmpFxPWTFxYRSKS7Hiqr2lTYTJc
 0RNvgIi4DNWkPBAt+59xQpPNTRhbY7Q5H63dXxZwMQU0EzvHmjkoX+Gw5VVmHZTuFGXT
 pPlSBbV4Th3IMDS1OB5EOhJr0UzGMFWXHwBnjTe1eahOi+N+f2rs/hBBe9XVwBQ/i+Yu
 gHCw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1794426864; x=1795031664;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=uz4m71nRD6f+qddgfa2gOOtoUGlSJn5F5ou4PIom6y8=;
 b=BxXUwVTlSkXSya9uksemyaXRuVeYjCmJ/vb6Fqr2KNa1fmjkaMyuDaYjnAjEqxrP1T
 uI0gHW4bcfhMPo6NbvfQZsxJKnwNjBs6ZgGF3HBxjKBWxe0u9hv3oArt0m3TeAAVyGzt
 VUniI/g1DHAdjfR3nW0AG17DokVJwv1biZSluqmYrhoS6/nuS9joe4rSS3/B3FWiSfN/
 ilHQfHHy0mgm0rz7SWZ5z2JGaaZJq1kwd7hlXCasHTHMRUSlCguv2KxpPd8rGqpPWao0
 Ojw58aqUu17vd0C1bBuvmz0X2cmChgG9KkpZea3WZrkScuKPfrWDhVTv7z3GTkbIg9QL
 UyAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794426864; x=1795031664;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=uz4m71nRD6f+qddgfa2gOOtoUGlSJn5F5ou4PIom6y8=;
 b=qt80+Se0rrI6T9K8konCXoD9ILzbnqKk7tYrqfJ4cJUUzgChOTuK/xYVTQtkOD97Df
 cy4orUTMBalKBJzTUqYeUM/CbDyfPo2DKNa3wIaHhlhj5gQY0MoLxtzXPLLUwflvQwnd
 /cyA03mzE1YW5q8nBZ298pMW0Xoy+0N7sDV+ZehcnWcbgAtNW8WyEBGv0xrsv6P8Ah6Y
 BExDigr/Dp61eE1vlTn+SSrPAwIuQFTYl4g5z0e0YcroMdmuS10lEV0Zyumx1MQxPSSk
 Z0GqUkhxvu5fjM2tF76xSg61Cs0RsD5Prw9xmWgyZU0bH7tUOiz7fdWY6JCkX9IIwKaa
 0VNA==
X-Forwarded-Encrypted: i=1;
 AL+hErEEzlbheEHT1DvdzBcqRZcjQRf+HmjQPeAxjuM12XjK+8H4RcRyZbFI3kRxYdf1D15Lo2pWA1JcxS8=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9l+Yz0Fsr3IgKaWm1jl8hmSRupBYE+DMaG4E2uu9+9I+Y5jUK9
 HiiYoPDe52LVuFh+mClmTlI0Y52/8AZKKrM9j6hn7+S3mflOsa3JPfpZQ3MybNVjoSjXenFKDZg
 QEyfGuMMR9hgt0wQcRhx6b5DJxYuhav1/IGJmnm6+
X-Gm-Gg: AYBFou0eWv0GyCW1JD1wnoMkJO8FQPqP7kqV6EMw5ommxdlRG3nUpN3QyYAWcyBBQBG
 jxvf/KqqTxPKNN9/vGeIwtZu9IjDXRsxX+P4nxiAAFCm/uIak6tRV/kohmm4mqJC5z3lfCfxyXQ
 r0FPpdIL+HnQgY/FpZhTBrXbc/HB5QbTrWGiCQU5ewOEVpObJHxRlPMav1idtX3yf0l+2V82eZV
 Ae2H2DL63lcQaDog44U2VV9ACNAt3Eogs9b5yL7LrbIiOp5GrY5tcjomPDx6BsWKM+vXz+QFAQe
 3W8Ds31kDo7vMi9pLnLsw1IxYML0Kzy3yUa6IfrLXMH/eZQCWD1azS2hQV0zjc6mTu1lsl9Les8
 6IdoR5N9hnhGLQhyXgdgJRHGSv71hZtVRd2RbrDpeS8VsA6RwijAUPJ6AFRCpnhKcb8MZrFuOWs
 fRhDihv4uNnfxeBGbeCnUY8A==
X-Received: by 2002:ac8:610a:0:b0:536:6ea4:e6a0 with SMTP id
 d75a77b69052e-5596dcd0110mr2182331cf.11.1794426863094; Wed, 11 Nov 2026
 11:54:23 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261110125106.2935677-1-k.chen@smail.nju.edu.cn>
 <1e7fe0eb-2b06-4db0-98b1-3535218847b3@amd.com>
In-Reply-To: <1e7fe0eb-2b06-4db0-98b1-3535218847b3@amd.com>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Wed, 11 Nov 2026 11:54:09 -0800
X-Gm-Features: AclHuK842ds_mKapn9TcQRUw1syxLEFrhFQUvpEEkUm30hfHXep4Wlia77qvmLs
Message-ID: <CABdmKX2hLTrxmZCRRLKFd3GuYP7tr1TX0-JGuXiKAZ+ZV8U36A@mail.gmail.com>
Subject: Re: [PATCH] bpf: make dmabuf iterator stay drained after NULL
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Kang Chen <k.chen@smail.nju.edu.cn>,
 Yonghong Song <yonghong.song@linux.dev>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, 
 Sumit Semwal <sumit.semwal@linaro.org>, Philipp Stanner <phasta@kernel.org>,
 linux-media@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org
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

On Wed, Nov 11, 2026 at 12:18=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> Adding T.J. to comment.
>
> Regards,
> Christian.

Thanks I've had to aggressively filter emails, so for the most part I
only see stuff where I'm on To: (and I still can't read them all). I
would have expected get_maintainer.pl to add me here.



> On 11/10/26 13:51, Kang Chen wrote:
> > bpf_iter_dmabuf_next() uses kit->dmabuf =3D=3D NULL to mean "iteration =
has
> > not started".  dma_buf_iter_next() also returns NULL at the end of the
> > list, so a next() call after exhaustion restarts from the list head.
> >
> > The verifier relies on the iterator contract that once next() returns
> > NULL it keeps returning NULL: process_iter_next_call() marks the
> > iterator DRAINED and treats the result of later next() calls as the
> > constant zero.  A restarted dmabuf iteration therefore hands the BPF
> > program a kernel pointer while the verifier believes R0 =3D=3D 0.
> >
> > Use an invalid pointer value as the drained sentinel so the iterator
> > state keeps its one-pointer ABI, and skip dma_buf_put() for it.
> >
> > Fixes: 6eab7ac7c5ee ("bpf: Add open coded dmabuf iterator")
> > Signed-off-by: Kang Chen <k.chen@smail.nju.edu.cn>
> > ---
> >  kernel/bpf/dmabuf_iter.c | 23 ++++++++++++++++++++++-
> >  1 file changed, 22 insertions(+), 1 deletion(-)
> >
> > diff --git a/kernel/bpf/dmabuf_iter.c b/kernel/bpf/dmabuf_iter.c
> > index cd500248abd9..a2b7c38f9ae6 100644
> > --- a/kernel/bpf/dmabuf_iter.c
> > +++ b/kernel/bpf/dmabuf_iter.c
> > @@ -156,6 +156,13 @@ struct bpf_iter_dmabuf_kern {
> >         struct dma_buf *dmabuf;
> >  } __aligned(8);
> >
> > +/*
> > + * The iterator state is one pointer wide because struct bpf_iter_dmab=
uf is
> > + * part of the generated vmlinux.h ABI.  Use an invalid pointer value =
as the
> > + * "drained" sentinel instead of growing the state.
> > + */
> > +#define DMABUF_ITER_DONE       ((struct dma_buf *)1L)
> > +
> >  __bpf_kfunc_start_defs();
> >
> >  __bpf_kfunc int bpf_iter_dmabuf_new(struct bpf_iter_dmabuf *it)
> > @@ -173,11 +180,25 @@ __bpf_kfunc struct dma_buf *bpf_iter_dmabuf_next(=
struct bpf_iter_dmabuf *it)
> >  {
> >         struct bpf_iter_dmabuf_kern *kit =3D (void *)it;
> >
> > +       /*
> > +        * The verifier assumes that an iterator which returned NULL ke=
eps
> > +        * returning NULL (see process_iter_next_call()).  Without this=
 check
> > +        * the NULL left by the last dma_buf_iter_next() would be inter=
preted
> > +        * as "not started" and the iteration would restart from the li=
st head.
> > +        */
> > +       if (kit->dmabuf =3D=3D DMABUF_ITER_DONE)
> > +               return NULL;
> > +
> >         if (kit->dmabuf)
> >                 kit->dmabuf =3D dma_buf_iter_next(kit->dmabuf);
> >         else
> >                 kit->dmabuf =3D dma_buf_iter_begin();
> >
> > +       if (!kit->dmabuf) {
> > +               kit->dmabuf =3D DMABUF_ITER_DONE;
> > +               return NULL;
> > +       }
> > +
> >         return kit->dmabuf;
> >  }
> >
> > @@ -185,7 +206,7 @@ __bpf_kfunc void bpf_iter_dmabuf_destroy(struct bpf=
_iter_dmabuf *it)
> >  {
> >         struct bpf_iter_dmabuf_kern *kit =3D (void *)it;
> >
> > -       if (kit->dmabuf)
> > +       if (kit->dmabuf && kit->dmabuf !=3D DMABUF_ITER_DONE)
> >                 dma_buf_put(kit->dmabuf);
> >  }
> >
> > --
> > 2.34.1
> >
>
