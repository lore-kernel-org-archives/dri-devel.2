Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 604A6606A32D
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 16:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ms0Tcri/
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 66DE589CD3;
	Thu, 12 Nov 2026 16:27:35 +0000 (UTC)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 73EEB10E356
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 16:27:29 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4a206f0b95bso61445e9.0
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 08:27:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794500848; cv=none;
 d=google.com; s=arc-20260327;
 b=JpjtdircQzZCC3YYHn1eiBWWa0fsrjM4pYGG61ECgEKFgH6xiA9+4gn7YUyvqpsvvn
 YmTgHmHXAg/GpXfV5ID1xevkfApO8nZ+pK1GtmAMZO6Q/MV+XPhDqhZAj7j+TnMg/tFo
 YIlF0u4ncfnR2J3olO6IayYlG0+ztFWXsgYQmHCSB/rf0N03DoZCimLgAAJ9Wig3shJq
 4YdeCaIfBTbQ3WTaDfdYEQ76hWuBBHjxGe8j71925BZRErPNi+oaMJqa7RM5T0C0bRSH
 Lk60SD8Siecn2VaBHvmkJW7dfcQPpk+tb2zCVpDFHYQUxoPsnxrOn9oMI7M855yjfDTD
 7ECQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=4rfQtqmAIAvmt99DAIISM3k+R3AqubbosQEc8qLWnGI=;
 fh=lkp8nG80d+4f8poX9ktYnKS9mPVigm09HbvN5trO6ME=;
 b=Qo8TDOwD4XoN54Ud+pgaTPp3r7VkJOQ17cNsNOwhpvBu608qbTNzz/vCDiUDKRTvq0
 6YbCwc9UmRHFVwh4KHZ3zM+Pk5b9+AcA16y1bhDb9Dxb6fPScKfDV3FiFT8Ci7iSxnqH
 hujXMnvefTj2U7AvXtTxPcGrEiLyXWij6lmp42O0UAEXYar3dq1r1crO90Qpdm687oVd
 FRBXBeI+96LQIgOUuVftwgog7WHvs8ADMEkawhYsSLwGjY+FILyZzV6xkEmeAHjwIKGl
 yB+h/MjUL1VN6onKqnOo/2/73LmN1H21AXJb4ZU1gCN1Y6mxhYHj/Bs12k3eOqA/I9BG
 JbzA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1794500848; x=1795105648;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=4rfQtqmAIAvmt99DAIISM3k+R3AqubbosQEc8qLWnGI=;
 b=ms0Tcri/MkbKfVoE2QIuIoRVEPAHvmHPC/G+Ppg7H5sjRYPLhO/lj1EnhLvTxW1MbZ
 Wme5G0FrsR2TptWkOMRSsDH7CvcC7Rc4q0TwreqOmiLvkccMC6k537kWp4VGnbVgFoaI
 dA9MKSW16CEOQVybCZLMLdJJxxxFT1CfQILlHYx4eiGc1UP+NmWopu1FnM34qZ6YD1ea
 jgRnUnzVIivJvQHTDsXrwufr3CrWS5IYtnAuwXELY1FW/JKXfDR7R5GLFyIQsSeqjbB7
 pVnemQrcg5XDxb+VXrD+T2QFFZWjBKeslJhLv9J9skCIJ4figi4SSs0aodCi2gWe3wTT
 3Rrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794500848; x=1795105648;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4rfQtqmAIAvmt99DAIISM3k+R3AqubbosQEc8qLWnGI=;
 b=lF6ydpGBnu+ZVZNR03ALUjHAkVqKl2bPdYmXkdfVazwZQJoGiWNKpuIwxlkTPw/pus
 vci31iAQPr8CDixBLY/thZKeQw5iDBGc2siiflQdTBW81OnZe8hVywN0IRcoaVjRo3zd
 7C4lC+zIb3wKOBPJ2n0S86nKvsCubW9ZkBayToSJHch2Jfb9e9RtcNjGKPrurFgDv32n
 0wseiHHhiEmVRBEfrUOh+3Z3uYhFRu1orSNDjfv6XgyJv+ZlqCiGYndnL+D1Pbr8tHkQ
 4b/O+oxmCkJStnfo9PzB3uqnTYUtXUbmtncYmoBcL84waDFRuIpvwgVglzvyco0Z6/AP
 LG9g==
X-Forwarded-Encrypted: i=1;
 AL+hErGas8NzYjhBnt6KYXcuwhy3y9KbC5EipKolx2dHt4JTgeRGOWU+jBAu7lNzLKL4FdDjG8G4MoPzPCA=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/T0AqgLyNC6803E6FLaSuBlDq+4ADyE4CueM0s4YAFMsiOMjxO
 dnOLLEWVkdnMeTJyPIP15hi3YFNeZD4nNV+wOJ8zm9aQtbQi/dH1arlk9R6ky3SC7yUk0VA/YT8
 RVJWq3H27prQpYnDPiMEiLbyamr/Q8AmZd6Upr8o9
X-Gm-Gg: AYBFou0v+j2sgJ+B9muau+39hNXGZYJMHk6J2fYHLWS2650v63+4B8VITFFRJJGxjc6
 +Ce5n3MRiTKB/Dy7FGibPp7nSDx4cyflBb8iJY7ASaGXdUppDBwv6in8BO6ju9XgIFR6r+3dnoO
 YpUIh4URC5rVXK50SNHWF4oTSWdMNXifwMGu9YXGQ8qtiD7UYqgY2/PyO7EWgIgVUUz49MLNmoe
 lJcNYATA8oRQn52JMJVrYjCxXLBai/o8reEqxToJaJB5H/TeTDjlrmWTyteDP6151fitTLgEJ+3
 rtwI1QokESa+SKmXxjh0pqb5AADyah3thShW1G6Kq2eGw9llHMk5bHtrrM12nWOuktn37XVaRYU
 wW00Ds7I2X5V+vur3ZTYP/AeVU+iYKJHqJb5Km96gGegoms6Kyk+Eng8/NvdWNiYN+w1OXkixiu
 M3Qz79ISzQNxdA9uMifkBV
X-Received: by 2002:a05:600c:3484:b0:4a1:d7fa:ae36 with SMTP id
 5b1f17b1804b1-4bb4f596156mr1132755e9.4.1794500847262; Thu, 12 Nov 2026
 08:27:27 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261110125106.2935677-1-k.chen@smail.nju.edu.cn>
 <20261111195942.1283060-1-tjmercier@google.com>
 <70c7192e-b9e7-4b06-9d78-38e9de85f486@amd.com>
In-Reply-To: <70c7192e-b9e7-4b06-9d78-38e9de85f486@amd.com>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Thu, 12 Nov 2026 08:27:15 -0800
X-Gm-Features: AclHuK-uQbQFbW5RNXEONirv5hUwyDZLZazYVkX411MRAANXcv3dooeKp4V1qsc
Message-ID: <CABdmKX3rqcf-U7W7E+d79dM9H3VnwUjAH3Hv92MczMSmQauC3w@mail.gmail.com>
Subject: Re: [PATCH bpf] selftests/bpf: Test that a drained dmabuf iterator
 keeps returning NULL
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: k.chen@smail.nju.edu.cn, ast@kernel.org, daniel@iogearbox.net, 
 andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com, shuah@kernel.org, 
 martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev, 
 jolsa@kernel.org, emil@etsalapatis.com, ihor.solodrai@linux.dev, 
 sumit.semwal@linaro.org, phasta@kernel.org, tj@kernel.org, 
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linaro-mm-sig@lists.linaro.org, linux-kselftest@vger.kernel.org
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

On Thu, Nov 12, 2026 at 1:35=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> On 11/11/26 20:59, T.J. Mercier wrote:
> > The BPF iterator docs in bpf_iterators.rst specify that the next
> > function of an open-coded iterator should keep returning NULL after it
> > has been returned once.
> >
> > Add a subtest that checks this for the dmabuf iterator. It drains an
> > iterator, calls bpf_iter_dmabuf_next() once more and checks that the
> > result is NULL. The dma-bufs the test creates keep the list from being
> > empty, so an iterator that starts over would return one of them.
> >
> > The existing open_coded subtest uses bpf_for_each(), which stops at the
> > first NULL and never calls next() on a drained iterator.
> >
> > Signed-off-by: T.J. Mercier <tjmercier@google.com>
>
> Acked-by: Christian K=C3=B6nig <christian.koenig@amd.com>
>
> Let me know if you already have drm-misc commit rights.
>
> Regards,
> Christian.

Thanks! Still waiting but no rush.

> > ---
> > This depends on Kang Chen's fix and fails without it:
> > https://lore.kernel.org/bpf/20261110125106.2935677-1-k.chen@smail.nju.e=
du.cn/
> > Kang, feel free to carry it as 2/2 in your v2.
> >
> >  .../selftests/bpf/prog_tests/dmabuf_iter.c    | 19 +++++++++++++++++++
> >  .../testing/selftests/bpf/progs/dmabuf_iter.c | 19 +++++++++++++++++++
> >  2 files changed, 38 insertions(+)
> >
> > diff --git a/tools/testing/selftests/bpf/prog_tests/dmabuf_iter.c b/too=
ls/testing/selftests/bpf/prog_tests/dmabuf_iter.c
> > index 1a5dc1adae73..c1f81b5dccdc 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/dmabuf_iter.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/dmabuf_iter.c
> > @@ -265,6 +265,23 @@ static void subtest_dmabuf_iter_check_open_coded(s=
truct dmabuf_iter *skel, int m
> >       } while (bpf_map_get_next_key(map_fd, key, key));
> >  }
> >
> > +static void subtest_dmabuf_iter_check_next_after_drain(struct dmabuf_i=
ter *skel)
> > +{
> > +     LIBBPF_OPTS(bpf_test_run_opts, topts);
> > +     int err, fd;
> > +
> > +     fd =3D bpf_program__fd(skel->progs.iter_dmabuf_next_after_drain);
> > +
> > +     err =3D bpf_prog_test_run_opts(fd, &topts);
> > +     if (!ASSERT_OK(err, "test_run_opts err"))
> > +             return;
> > +     if (!ASSERT_OK(topts.retval, "test_run_opts retval"))
> > +             return;
> > +
> > +     /* The test buffers exist, so a restarted iteration would find on=
e */
> > +     ASSERT_EQ(skel->data->next_after_drain, 0, "next_after_drain");
> > +}
> > +
> >  void test_dmabuf_iter(void)
> >  {
> >       struct dmabuf_iter *skel =3D NULL;
> > @@ -315,6 +332,8 @@ void test_dmabuf_iter(void)
> >       }
> >       if (test__start_subtest("open_coded"))
> >               subtest_dmabuf_iter_check_open_coded(skel, map_fd);
> > +     if (test__start_subtest("next_after_drain"))
> > +             subtest_dmabuf_iter_check_next_after_drain(skel);
> >
> >  destroy:
> >       destroy_test_buffers();
> > diff --git a/tools/testing/selftests/bpf/progs/dmabuf_iter.c b/tools/te=
sting/selftests/bpf/progs/dmabuf_iter.c
> > index 9cbb7442646e..d5421b75c39c 100644
> > --- a/tools/testing/selftests/bpf/progs/dmabuf_iter.c
> > +++ b/tools/testing/selftests/bpf/progs/dmabuf_iter.c
> > @@ -99,3 +99,22 @@ int iter_dmabuf_for_each(const void *ctx)
> >
> >       return 0;
> >  }
> > +
> > +/* Result of a bpf_iter_dmabuf_next() call after the iterator was drai=
ned */
> > +__u64 next_after_drain =3D -1;
> > +
> > +SEC("syscall")
> > +int iter_dmabuf_next_after_drain(const void *ctx)
> > +{
> > +     struct bpf_iter_dmabuf it;
> > +
> > +     bpf_iter_dmabuf_new(&it);
> > +     while (bpf_iter_dmabuf_next(&it))
> > +             ;
> > +
> > +     /* Store the raw value; the verifier would remove a branch on it =
*/
> > +     next_after_drain =3D (__u64)bpf_iter_dmabuf_next(&it);
> > +     bpf_iter_dmabuf_destroy(&it);
> > +
> > +     return 0;
> > +}
>
