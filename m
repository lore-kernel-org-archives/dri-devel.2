Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B5F606E1C9
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 17:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=SjjRqYZJ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 192351126E4;
	Fri, 13 Nov 2026 17:00:07 +0000 (UTC)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7DD7A1126E4
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 17:00:00 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-4a206f0b95bso127855e9.0
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 09:00:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794589199; cv=none;
 d=google.com; s=arc-20260327;
 b=JW+4KcoPVy7/NkvA0DUg8089EezXMDMqvahT6CW6hxbnKp/3MZIitis4Lx4cEfZpKY
 fJ1biEZeU5d8kM7yujQQ6+YCBycK9ocoqDiftTWZ5mjgzEELPkVYdvHR8KoBlWqKybxy
 k3tckS859GGOG8O0jIeUdMQsNXs1PcSU3b8mTUBdsqqtFLRaFXt6AY07vSC0UKwxqmCi
 JQK284lAmER4TmhdzqqBS9pH2mQemB0jWKwwKX9jgUDM1wZEP5KgcNhinBMWJCb5xGhQ
 sddb8tDK4H3YNdkoVH9hrK7T9V0Dqo1noD1XJGhhvYakhDZsDOaS6KGBu4HBNjjFfhvy
 8YWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ht73lIdKfLXzYIM4DvC0DDEzfXuL/I3GCKbyKODV+Yg=;
 fh=oTBo3pS64+Vy9cGIIeNQ5ndLT2D27G/WzGO8JVPjOao=;
 b=q93GzCLYgSYEG6dlh2zfFTaFt8DFipSqNCnAsjzNM2hF86F/ELcCQmbiWP5rbS0a6T
 C9RAjPo6IOXGQlxedy2E7BxGJJl2pFusTi8Fas1XHJAmRzfdTx9IXC5AWvoDSjFUxL9V
 Q7TXIFlio5Exd1IeJ1fUUbaQ0vSfbR6oGDddqZqajXD+XCsjAdNN+xi+t4odYqo6BnfI
 XK+ZUqC7eDc7a2eOAiCEY+WKzMrsi1FiFyT7aDfS8lDqcbP7iMQfgexu5iRwyDCRNAnu
 cbBlsRQIZqToUFjeIy1fCrxoLmUHy8x74YW1D695z1MSWAZr8rdZ6TdJr65GIAaROaAI
 i+vA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1794589199; x=1795193999;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ht73lIdKfLXzYIM4DvC0DDEzfXuL/I3GCKbyKODV+Yg=;
 b=SjjRqYZJSGqdyIDSBjbkYRpQjw4213Ea54VpN2x+a7ReJ6cpP4i8KjBW3dLt/UFTel
 GUx8BkYKoDgndOxYtaBtxzjzZNCQJO39ZqseC2OQlm+fYN5sdG0m9gyY1h/X3NNoTugG
 wpF0M8Q/ZYhCzt5cPEfot0SuIAaUmshmPpZ5aQpRp/1KtlVbV2euUtaxoEv561NEyrNI
 0M7OPyONZUpHZ3dZQl6jJVhaLgqGLi3dsBeSbXABFrItsMGvLN9i/Pj8TaIYV9BlDOYM
 ulAPYbPm/nWanvuIcd8Qi6M3SuyXNNahjSnI3divS35wnC4cK+UBQkQIBgOU/A+QNbya
 iEtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794589199; x=1795193999;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ht73lIdKfLXzYIM4DvC0DDEzfXuL/I3GCKbyKODV+Yg=;
 b=g1hQzQL8stkSZFrscILdxiaptVc8MwyvNpvwT7wVXKq+Z/7HXG1r30i8G4H6+7Naho
 qn6xRe1OLDfW0/hevcfO3ZaAAgv+g+7YyGd7lV5wLwZ0BkXo79c6OoMhq5hIdA1hOTF4
 92eEoEpd4ZcRdeJXzxSqmn+hHUo2jzouPEehQsUZZe2YnoI61JtawQKVy3YlnBXhsMj6
 n/mS9BO+GD9lVRpdG7g0bdBtYDb0MlIAcb7kpQnWO1SUg2jwGF8myu+TA8GYdnjj0NUV
 K2dCDAFyO+0Wvq2FcYlvbcesUD9kLSZJnMrTuZ2r+lzbNHwscDipxsp10NqP1OFeZ9CF
 Vj0Q==
X-Forwarded-Encrypted: i=1;
 AL+hErHNZJTNsKaDy2xH3UVQI4Y351+Gk8qx2ahQrgcHlNrt8a+R32OX/m8RipEq0kbG42LHGG9PJX6Fbco=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/D6Q/5F9X4+J9G65Gboza389jGcPHGxjCG6Z5f3zfjgTcgvPaR
 ZDBsef25LfudtNlYLkaDSZxwHjgZz6v/r39m7V34Fr15E1mqCup9DDJerL8ods0EsYEQNoRMlG+
 zR1/uGS4l0O+ICm8Rn31Gz0nQa6RvPewbFijwa+zt
X-Gm-Gg: AYBFou0FsRnc1e+SEo+2g4bWCjkN+TLdPObCNnJ4TpDTMv0Vruz/NNS3aE2AYKEwjy9
 a+fkvVXUVWegOGt1hKA3TBrY0K4By0zGdqs71qiBN8XgfiuDUtoZX+4O4O/Jl/c17psc+Q1pu8x
 vQU90hZL0amKZ+v9gFtUoFFlFtDKgnb51KS5wcSrQ45bz5LH2Mkh/0vzUh5bhxZ3H+1HkoDHSTL
 KCrXgEGclbcRwtr9NGa3m25zCRXQF9hYEpGbW1hUcxk+c1RlTGiVbbjDdFvSLrMNvtyRtZGNzjf
 vgidKa0F39L9UaPjkrAwpMIl3O1ffKiY0x4sodW/ofY9wbwkc+EqRpHYDc9gkqPckDzMfWO4OHZ
 ieLKYSC8f+2vN5brlMCj8qsTEjL5gf74kkKe4CGAwhIhKhNDvcOXuFBtT9GSzt7hFTxhYYwkyfU
 7AjLw2zpZF6HW/AnKvfzzd0vY=
X-Received: by 2002:a05:600c:ac1:b0:4b8:b175:c5a3 with SMTP id
 5b1f17b1804b1-4bb56e4edcbmr658015e9.9.1794589198370; Fri, 13 Nov 2026
 08:59:58 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261113024447.922683-1-k.chen@smail.nju.edu.cn>
 <20261113035640.948458-1-k.chen@smail.nju.edu.cn>
In-Reply-To: <20261113035640.948458-1-k.chen@smail.nju.edu.cn>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Fri, 13 Nov 2026 08:59:42 -0800
X-Gm-Features: AclHuK-LFbMT3CtNvV1OqgqhSoIHpLJtutAfAmKAD9TN_Xuh-nAE2mDUwuHSl-g
Message-ID: <CABdmKX39KyeRFLwiJKpt0ZVjWkNcL62ajYNUjHfN4VXAqbHJrQ@mail.gmail.com>
Subject: Re: [PATCH bpf v3 1/2] bpf: make dmabuf iterator stay drained after
 NULL
To: Kang Chen <k.chen@smail.nju.edu.cn>
Cc: Yonghong Song <yonghong.song@linux.dev>,
 Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Sumit Semwal <sumit.semwal@linaro.org>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Philipp Stanner <phasta@kernel.org>, linux-media@vger.kernel.org, 
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

On Thu, Nov 12, 2026 at 7:57=E2=80=AFPM Kang Chen <k.chen@smail.nju.edu.cn>=
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
> NULL now means drained.  Initialize the state to DMABUF_ITER_START and
> translate it to dma_buf_iter_begin() on the first next().  The iterator
> state is BPF-visible ABI (one pointer wide), so use an invalid pointer
> sentinel instead of growing it.
>
> Fixes: 6eab7ac7c5ee ("bpf: Add open coded dmabuf iterator")
> Signed-off-by: Kang Chen <k.chen@smail.nju.edu.cn>

Reviewed-by: T.J. Mercier <tjmercier@google.com>

> ---
> v3:
> - No change from v2; reposted with the updated 2/2 attribution.
>
>  kernel/bpf/dmabuf_iter.c | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)
>
> diff --git a/kernel/bpf/dmabuf_iter.c b/kernel/bpf/dmabuf_iter.c
> index cd500248abd9..390f6d730a67 100644
> --- a/kernel/bpf/dmabuf_iter.c
> +++ b/kernel/bpf/dmabuf_iter.c
> @@ -156,6 +156,9 @@ struct bpf_iter_dmabuf_kern {
>         struct dma_buf *dmabuf;
>  } __aligned(8);
>
> +/* NULL means drained; START means "not started yet". */
> +#define DMABUF_ITER_START      ((struct dma_buf *)1L)
> +
>  __bpf_kfunc_start_defs();
>
>  __bpf_kfunc int bpf_iter_dmabuf_new(struct bpf_iter_dmabuf *it)
> @@ -165,7 +168,7 @@ __bpf_kfunc int bpf_iter_dmabuf_new(struct bpf_iter_d=
mabuf *it)
>         BUILD_BUG_ON(sizeof(*kit) > sizeof(*it));
>         BUILD_BUG_ON(__alignof__(*kit) !=3D __alignof__(*it));
>
> -       kit->dmabuf =3D NULL;
> +       kit->dmabuf =3D DMABUF_ITER_START;
>         return 0;
>  }
>
> @@ -173,10 +176,14 @@ __bpf_kfunc struct dma_buf *bpf_iter_dmabuf_next(st=
ruct bpf_iter_dmabuf *it)
>  {
>         struct bpf_iter_dmabuf_kern *kit =3D (void *)it;
>
> -       if (kit->dmabuf)
> -               kit->dmabuf =3D dma_buf_iter_next(kit->dmabuf);
> -       else
> +       /* Once NULL is returned, next() has to keep returning NULL. */
> +       if (!kit->dmabuf)
> +               return NULL;
> +
> +       if (kit->dmabuf =3D=3D DMABUF_ITER_START)
>                 kit->dmabuf =3D dma_buf_iter_begin();
> +       else
> +               kit->dmabuf =3D dma_buf_iter_next(kit->dmabuf);
>
>         return kit->dmabuf;
>  }
> @@ -185,7 +192,7 @@ __bpf_kfunc void bpf_iter_dmabuf_destroy(struct bpf_i=
ter_dmabuf *it)
>  {
>         struct bpf_iter_dmabuf_kern *kit =3D (void *)it;
>
> -       if (kit->dmabuf)
> +       if (kit->dmabuf && kit->dmabuf !=3D DMABUF_ITER_START)
>                 dma_buf_put(kit->dmabuf);
>  }
>
> --
> 2.34.1
>
