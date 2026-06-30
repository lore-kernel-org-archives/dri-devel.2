Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76172C43602
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 07:03:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D5B710EDE3;
	Wed,  1 Jul 2026 07:03:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Rm4jN2x/";
	dkim-atps=neutral
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com
 [209.85.217.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C1AF210EBAA
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 08:49:39 +0000 (UTC)
Received: by mail-vs1-f45.google.com with SMTP id
 ada2fe7eead31-737de525d2eso1654032137.2
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 01:49:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782809378; cv=none;
 d=google.com; s=arc-20260327;
 b=oxpGddYCz/Qa1PFXf5j4ruXepFaQc6BDCpACrtQnNPDJjzxdEtR4dD7apwQxfz+cqb
 iKsk9aL3psulQkqefQWbtntjR/TUveltvCV7zfg4UdCSJGMoGTeEj/88VP7/CxDhze9o
 zHj6t/CP4aav3Q4YtSQoqyMc3rnVsfDAldW/zDK4bdnDNw6mHrytBGKvG04jmvC9TSeK
 /JedZtgKXFYidd6t3LkYoUmMcyrmcrD+vMCi9UL8rb+J940Tv4slzoyfG1lIIEwdVNYq
 nEZE4diuhLqQ7xvpuSPvd8RgwaYzNkscMc6SAh/xTwLOMVWW1pzRDMIeMaNbTKpilF4E
 JCXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=nkg1g9KfQaIMmyy3lOx7xNubgzPj1KDzA/VLYGyXcVg=;
 fh=M8Deg/koEEVtNQ54Xb3B/xCDWbXrQ69q9alGE04YPN8=;
 b=oFPw419nXka0BkIiqFTLYqB1AmXuSmbGd3UbuTspf9WXtQU9NwO4ADr9YVrC266EKb
 QFoKTwG1ezBMbsYHDDj7aJ87KcrE4h2pACeuPS/b2zyHxZlmlx+O9Nm37RMmr5Rad28i
 M+hco5747cgtjBtj1f0vg6Rll2j2trnDXs6oz2wV1SmZ8oS+YFP9kdNhLk26DhjdWHAG
 MUvjwHQzMd/BPhjM4VJG3ncEni++vbPCJriVg7WSBDgSkyoxK+3JXTnwUoJglrj+gZjO
 2cKJNGE1EvmU49cs2rYdCLBoOBpPwq30y5g0l62eV3GC7ET3Djaz/4YVJ0G2CtdzHqtO
 KfxA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782809378; x=1783414178; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=nkg1g9KfQaIMmyy3lOx7xNubgzPj1KDzA/VLYGyXcVg=;
 b=Rm4jN2x/NQPYAEIVODcjIdoCUMScBQW/vtLl2RRZzxHhqTZkpIZUV+S7EpngXQpY1n
 uBnarYlRcUp0crBBX9mauwDTSsiikEV63F9SWONzPQjFSrUyMSAFv17MQT6rskEKMOip
 jLgXPqtjE4J94o9RBylE/NwhuJWkJJ2MLCdM0zeLdeEc0ayzmR9uLDuaNqRv9n+ocAtN
 Ha61XjqqD6162TDjwreFHnPDxIhggsaa+D6BSZsK/HGxAfx+D63gCkQiKuxS5fjUKyPu
 KNRUKm+FQIzK5V0ascCdaSf2xkrIX390LDTqhl5sr4xkzthy+LxU+dpOtVJb52DbuW3k
 izWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782809378; x=1783414178;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nkg1g9KfQaIMmyy3lOx7xNubgzPj1KDzA/VLYGyXcVg=;
 b=L2PKkgOntI7/giw4g7v1zNlBRVaL59o9vh+qqsLY3S/nKR23p+Wl6gIQDctD7CGaPN
 Ez7GyJxnJDsduux/VOu/UrQNUIgOHPl97cmgSl5z3wX6xhtWrz0y88WSmED2SRVOrE7e
 dDkOx1szFl3WF5ySMAM6kpQPMYCof90bBLTIF6ezoz0W42xNoS+2O1vPnKt3y5LFL96e
 9dWUANQ+eNPgljwm0scto5xFhashLwJjMHxlSqLxhqqx8iw2fhFK8sq1YEvQ7yxYcl/J
 lKMc71Ud6Zz85xP3c2yrGSKxT2PmtuV7Z3X3WwG6aNsGSlXzU7+jZhjOzmNaQr5e2KBA
 kXew==
X-Forwarded-Encrypted: i=1;
 AHgh+RrYu65+2q9DSWF+/DBtcMMnIZncwns+8w7lfukrNIS0oLlRzDvsCZgBaPHNWWFUFQBtgGjhUZEre7E=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwvOvW2LPF1274vSgJ8Jnpujk+MK2yw98r5YQqXRg0uZQSbxtc/
 GOH+Qx98hyy3+zQiv3YycdM+X4tbBkArfjxSro0fCKMdkvzzsu6z8xIb3C6EITCFwFyqwrZFyM2
 Bjqx/KTihWWDRI60yOfguFrJh/YoJhfs=
X-Gm-Gg: AfdE7clVANDL6OqRJZ5SvfKEd1uNa2DrCol7/Go+DAYyp+r30mnnelwcEhaq5QQvq/0
 g2K9UzFjX4/v8vJufj2IckhNV5nAvXyhf4tlSCi3qjbU0gXQV9G/lmr3hQ6LcUpvb9WaLuVP5Nb
 VaZvRKdcPhxIXEwx1530nlExEbjCKjYC4Wbb1iXdcM1eZVDbGFi32p3rxCTYYr0BrluSZ/YDe0c
 9GKL+7BkYfYA5uz7ZTkCVs6sJQntjvkMUR7GC25TIuBEnrtSyRGInsp9wghw/AiilQRVcFXTVsc
 CJMMYA0=
X-Received: by 2002:a05:6102:e07:b0:739:d787:beb with SMTP id
 ada2fe7eead31-73a3841f1e2mr1545143137.14.1782809378511; Tue, 30 Jun 2026
 01:49:38 -0700 (PDT)
MIME-Version: 1.0
References: <20260630060436.1527498-1-shoubaineng@gmail.com>
 <0a02f85f-088c-4479-9e58-3b564931bfd6@amd.com>
In-Reply-To: <0a02f85f-088c-4479-9e58-3b564931bfd6@amd.com>
From: =?UTF-8?B?5a+/5p+P6IO9?= <shoubaineng@gmail.com>
Date: Tue, 30 Jun 2026 16:49:27 +0800
X-Gm-Features: AVVi8CeLetgT-SwP4GUoBph4oJYsKu-80xRLbFAW7TuNCs8tbUmCK1xBmOq6kQs
Message-ID: <CAGCp47wiEpG59KhaRRMs37RtPm5XvNy1x1sKc_TP94rS87rf5Q@mail.gmail.com>
Subject: Re: [PATCH] dma-buf/test: add KUnit case for dma_fence_dedup_array()
 empty input
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: sumit.semwal@linaro.org, linux-media@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
 linux-kernel@vger.kernel.org, phasta@kernel.org, tursulin@ursulin.net, 
 akash.goel@arm.com
Content-Type: multipart/alternative; boundary="000000000000b55ef4065574a789"
X-Mailman-Approved-At: Wed, 01 Jul 2026 07:03:11 +0000
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

--000000000000b55ef4065574a789
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks Christian! size_t is a nice fit.  It removes the negative-input
concern Philipp raised in one shot. Looking forward to seeing
the cleanup land.

Regards,
Baineng

Christian K=C3=B6nig <christian.koenig@amd.com> =E4=BA=8E2026=E5=B9=B46=E6=
=9C=8830=E6=97=A5=E5=91=A8=E4=BA=8C 16:29=E5=86=99=E9=81=93=EF=BC=9A

> On 6/30/26 08:04, Baineng Shou wrote:
> > Add a KUnit case verifying that dma_fence_dedup_array() returns 0,
> > not 1, when called with num_fences =3D=3D 0. This locks down the
> > contract documented in the kernel-doc and prevents a regression
> > of commit 77a9298741f8 ("dma-fence: Make dma_fence_dedup_array()
> > robust against 0-count input").
> >
> > Suggested-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> > Signed-off-by: Baineng Shou <shoubaineng@gmail.com>
>
> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
>
> Going to push this to drm-misc-next later today. I also pinged our intern
> to write a cleanup patch whic consistently use size_t for the number of
> array elements in the code.
>
> Thanks,
> Christian.
>
> > ---
> >  drivers/dma-buf/st-dma-fence-unwrap.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >
> > diff --git a/drivers/dma-buf/st-dma-fence-unwrap.c
> b/drivers/dma-buf/st-dma-fence-unwrap.c
> > index 4e7ee25372ba..72dea6091d58 100644
> > --- a/drivers/dma-buf/st-dma-fence-unwrap.c
> > +++ b/drivers/dma-buf/st-dma-fence-unwrap.c
> > @@ -370,6 +370,15 @@ static void test_unwrap_merge_seqno(struct kunit
> *test)
> >       dma_fence_put(f1);
> >  }
> >
> > +static void test_dedup_empty(struct kunit *test)
> > +{
> > +     struct dma_fence *fence[1] =3D { NULL };
> > +     int ret;
> > +
> > +     ret =3D dma_fence_dedup_array(fence, 0);
> > +     KUNIT_EXPECT_EQ(test, ret, 0);
> > +}
> > +
> >  static void test_unwrap_merge_order(struct kunit *test)
> >  {
> >       struct dma_fence *fence, *f1, *f2, *a1, *a2, *c1, *c2;
> > @@ -595,6 +604,7 @@ static struct kunit_case dma_fence_unwrap_cases[] =
=3D {
> >       KUNIT_CASE(test_unwrap_merge_order),
> >       KUNIT_CASE(test_unwrap_merge_complex),
> >       KUNIT_CASE(test_unwrap_merge_complex_seqno),
> > +     KUNIT_CASE(test_dedup_empty),
> >       {}
> >  };
> >
>
>

--000000000000b55ef4065574a789
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Thanks Christian! size_t is a nice fit.=C2=A0 It removes t=
he negative-input<br>concern Philipp raised in one shot. Looking forward to=
 seeing<br>the cleanup land.<br><br>Regards,<br>Baineng</div><br><div class=
=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr=
">Christian K=C3=B6nig &lt;<a href=3D"mailto:christian.koenig@amd.com">chri=
stian.koenig@amd.com</a>&gt; =E4=BA=8E2026=E5=B9=B46=E6=9C=8830=E6=97=A5=E5=
=91=A8=E4=BA=8C 16:29=E5=86=99=E9=81=93=EF=BC=9A<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">On 6/30/26 08:04, Baineng Shou wrote:<br>
&gt; Add a KUnit case verifying that dma_fence_dedup_array() returns 0,<br>
&gt; not 1, when called with num_fences =3D=3D 0. This locks down the<br>
&gt; contract documented in the kernel-doc and prevents a regression<br>
&gt; of commit 77a9298741f8 (&quot;dma-fence: Make dma_fence_dedup_array()<=
br>
&gt; robust against 0-count input&quot;).<br>
&gt; <br>
&gt; Suggested-by: Christian K=C3=B6nig &lt;<a href=3D"mailto:christian.koe=
nig@amd.com" target=3D"_blank">christian.koenig@amd.com</a>&gt;<br>
&gt; Signed-off-by: Baineng Shou &lt;<a href=3D"mailto:shoubaineng@gmail.co=
m" target=3D"_blank">shoubaineng@gmail.com</a>&gt;<br>
<br>
Reviewed-by: Christian K=C3=B6nig &lt;<a href=3D"mailto:christian.koenig@am=
d.com" target=3D"_blank">christian.koenig@amd.com</a>&gt;<br>
<br>
Going to push this to drm-misc-next later today. I also pinged our intern t=
o write a cleanup patch whic consistently use size_t for the number of arra=
y elements in the code.<br>
<br>
Thanks,<br>
Christian.<br>
<br>
&gt; ---<br>
&gt;=C2=A0 drivers/dma-buf/st-dma-fence-unwrap.c | 10 ++++++++++<br>
&gt;=C2=A0 1 file changed, 10 insertions(+)<br>
&gt; <br>
&gt; diff --git a/drivers/dma-buf/st-dma-fence-unwrap.c b/drivers/dma-buf/s=
t-dma-fence-unwrap.c<br>
&gt; index 4e7ee25372ba..72dea6091d58 100644<br>
&gt; --- a/drivers/dma-buf/st-dma-fence-unwrap.c<br>
&gt; +++ b/drivers/dma-buf/st-dma-fence-unwrap.c<br>
&gt; @@ -370,6 +370,15 @@ static void test_unwrap_merge_seqno(struct kunit =
*test)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0dma_fence_put(f1);<br>
&gt;=C2=A0 }<br>
&gt;=C2=A0 <br>
&gt; +static void test_dedup_empty(struct kunit *test)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct dma_fence *fence[1] =3D { NULL };<br>
&gt; +=C2=A0 =C2=A0 =C2=A0int ret;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0ret =3D dma_fence_dedup_array(fence, 0);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0KUNIT_EXPECT_EQ(test, ret, 0);<br>
&gt; +}<br>
&gt; +<br>
&gt;=C2=A0 static void test_unwrap_merge_order(struct kunit *test)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct dma_fence *fence, *f1, *f2, *a1, *a2,=
 *c1, *c2;<br>
&gt; @@ -595,6 +604,7 @@ static struct kunit_case dma_fence_unwrap_cases[] =
=3D {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0KUNIT_CASE(test_unwrap_merge_order),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0KUNIT_CASE(test_unwrap_merge_complex),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0KUNIT_CASE(test_unwrap_merge_complex_seqno),=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0KUNIT_CASE(test_dedup_empty),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0{}<br>
&gt;=C2=A0 };<br>
&gt;=C2=A0 <br>
<br>
</blockquote></div>

--000000000000b55ef4065574a789--
