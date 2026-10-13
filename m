Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B496CC6B03
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 11:47:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B60910E793;
	Tue, 13 Oct 2026 11:47:38 +0000 (UTC)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com
 [209.85.218.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 816C110E793
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 11:47:32 +0000 (UTC)
Received: by mail-ej1-f49.google.com with SMTP id
 a640c23a62f3a-c2e6df2742cso430379666b.2
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 04:47:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791892051; cv=none;
 d=google.com; s=arc-20260327;
 b=V47TseirdgteGxUPtEcNwC+6E8D5hcav396uVt3vpdCw+kChF5G5F0rgBDnGOCdgp6
 JT4TBEPyp49RFK5HU7XqacsssVQuO4RK5TFpn/cKFwpAJ1wu5hnHj3UHLhgLF5EogzWt
 F6UVzPBUMDs4vUOp76F5KmKTIQREzFw8J0c47/muNHvhXdCQUB3QgfRe/Oc4p5u8nReI
 W6IXZRSlqNnKfvmEWqYyTiBdtz77tkw+TOU8wvbJhEHygabDUW0cU3Phvf5pfA8BGKz0
 TNywo5zesuk+N+mW3tzpeQsd5y92gZoYG0YutCFHSTlP+mn+idZ1anpF9FqKJIhgW7Ak
 rpmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=UVPalbzX9AcfhM4CYBHZVMiSFH0v9ilPOAw17VfnQiE=;
 fh=BMOdncCBIDv1u7h5Zb6OAFxXQ8/X20AY/I86rGEoUVk=;
 b=PbAn8rE0mjqLDzv8wvK77Q8Mg7ec2ZNvNN4dGr1yTLqIJ+1GfG3UkuBnqRVHBLKweo
 1kPxPnlU+Y7MnKoqTvWWaRGnd+UUZQ0Vrw8oTKR9ffUXxQZ1Tn8i5JAN4WzwDczJklhg
 1326xxZ78/DIneSQHOqYwofZ0b2kuvfBII9/2TEnpvpmjHeEJnlInGA6ECpXCIjyha3V
 Opua+MRwsEjv1tPpakMzXl5Oe9ObKF93m7XSdxBcCNoC3fvuuUM713jC7DvvNiun/lkk
 FnkxTqo4rdNH0bCkDyXqkyrZiqDwhTgRrrjZzY+rop/S1HU+Hcr7YptipNy6BhuoMuHQ
 c9Zw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791892051; x=1792496851; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=UVPalbzX9AcfhM4CYBHZVMiSFH0v9ilPOAw17VfnQiE=;
 b=JusDETOLLi08SlQIfVGxNf4EWBd8QszZYQ/UygEq8ZYNUcP/Kh92NiWdbNr3n0Q9Z1
 LFxc8vXWws3G3Il49cAI4lbxslOflXlCI9fwbGk6EC3fVuLkYVSIbw+NYYR9b2/7xvvt
 0HBCV2p+nrz3vNigPW0UXSdB8HQT/xSPugJZxhtxMsfQ15+BmKgY95TxFZPmOgDfK69c
 JiI7lBq5G6paiCG3kFUPEewIQIcq1vF63DvRrYrchdEiIDlkGm042IuoD+yX0g6Q+L24
 /cTVYfT1PKu4Q51JENPc0ayUJoajJMEoSSoeaxaOTrcKNJc0ow7MrbDiKbg/PnQC8jbJ
 TFdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791892051; x=1792496851;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=UVPalbzX9AcfhM4CYBHZVMiSFH0v9ilPOAw17VfnQiE=;
 b=YR2v06Ftr3HJnovDGkrwcxKurKDIYSP3HSOPtSgBYjXo+CrXAs/SC9PolXgYB0hIe0
 RRfQBtSHNWpqMdYqZBfepqfxZuNyXbs6jRtE3w8mnwTwp7v2XlnqU4D4j3DkWNEqPqBY
 JXxO5Ehpdpn9L0XCBoHGqo3o4AAkNG+WiJ5gGaDA9r0ZnI7RGQ52QQqH6K4QY1KILpfR
 hVv5xMFRBfDf59u0bZ2w8hzrlSVwqY551pGRB6WEEn839Wj2QEHTFl4cqLb2MQOEXI2x
 +31SyX2dX86/98gzpJ7EEKFpGqLYateYHB/D4lTcOLZI0xVx93UkXNFa+/L4lTvAt6c5
 PZGw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxznSwUeDx68TSp4ieEqjD9WT/kw8czhU0rhYisf4dH+Rj3bn2gFATgxdANZLaodvxfyHf3cf2MVBc=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLM253261Vq813c33eUoM0KOXz2cpzhTZZzZDcQSxlfYPYF+gry
 WFELJK0Gz/s113ZbiIdULl79tphlDsoQgvawaAgTI54mM2m9NEdhYjJe7eclSt6NpiyElmzqSXz
 4Sj0WCiAQEpVGZVVf6b0N33JhEWlA5Xt8jDMQnRWHtA==
X-Gm-Gg: AYBFou3z9JB27A3us2jaOqLRNYVg5K1JUrEHnDoWTgOYB7STi+QKzyxRjXLGotOv/bW
 M3GZtQN5i0AcVzuTNSsmfXr0m3hYaLu66dNKe+zP/iQFIZY4VhvMvO9weqhdIR27JDH32WV8j39
 bcIClLWwPKU9J5x4fpVXHWKqZJecltlhvkW048pqcJZU0+cL/t/RfbXpHG+zGCvgFMdRUCreJz6
 UK41At0DqRsR2+uTs6OxRaGQ7HpEG2ejGDLBxJu1nx2EnMGETzhfFCIsP26VjIb44G84NKRUUjU
 bORXXdoD6qV4EgjScrxR6s6+WAifNs/1Fk85N43jaoLv0aBUlW1Ef9bnPDDmVyCmj5PQDGlYfl6
 hJk7bndhdfu8=
X-Received: by 2002:a17:907:2d94:b0:c2e:8eb7:53e8 with SMTP id
 a640c23a62f3a-c31aa03cd11mr1218873666b.30.1791892050873; Tue, 13 Oct 2026
 04:47:30 -0700 (PDT)
MIME-Version: 1.0
References: <20261005064133.7305-1-kmehltretter@gmail.com>
 <d1ef135e-1b5d-4656-9229-348c7029efbb@leemhuis.info>
 <as0r7Q4dHt9gQm_8@gmail.com>
In-Reply-To: <as0r7Q4dHt9gQm_8@gmail.com>
From: Sumit Semwal <sumit.semwal@linaro.org>
Date: Tue, 13 Oct 2026 17:17:18 +0530
X-Gm-Features: AclHuK8GUgU4QVn-7UfvoCsxrActd9fPNLz2lL3vDlxfEa7E6_wScmOs8ibZgso
Message-ID: <CAO_48GEh1p52pA_-NE=rN=_NQ=oAXpeHgHGVZCH6uPnFq7G1gQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/3] dma-buf: warn-only mode for DMABUF_DEBUG
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: Thorsten Leemhuis <regressions@leemhuis.info>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Andrew Morton <akpm@linux-foundation.org>, Jason Gunthorpe <jgg@nvidia.com>, 
 Rob Clark <rob.clark@oss.qualcomm.com>,
 Jianfeng Liu <liujianfeng1994@gmail.com>, 
 Diederik de Haas <diederik@cknow-tech.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Vinod Koul <vkoul@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 "open list:DMA BUFFER SHARING FRAMEWORK" <linux-media@vger.kernel.org>, 
 DRI mailing list <dri-devel@lists.freedesktop.org>, 
 Linaro MM SIG Mailman List <linaro-mm-sig@lists.linaro.org>,
 LKML <linux-kernel@vger.kernel.org>, 
 Linux kernel regressions list <regressions@lists.linux.dev>
Content-Type: multipart/alternative; boundary="0000000000002b1ff2065db76131"
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

--0000000000002b1ff2065db76131
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Karl,



On Tue, 13 Oct, 2026, 12:21=E2=80=AFam Karl Mehltretter, <kmehltretter@gmai=
l.com>
wrote:

> On Mon, Oct 12, 2026 at 10:12:02AM +0100, Thorsten Leemhuis wrote:
> >
> > What's the status here given that 7.3 will likely be released in a few
> > days? Note, I can see from the discussion that this is a complex proble=
m
> > that can't be quickly solved. That's how it is sometimes. But I wonder
> > if the current state of things is the best compromise for now or if
> > Rob's revert or some other option would be better.
> >
>
> I think reverting my commit 143755bdabaa ("dma-buf: Make DMABUF_DEBUG
> default to y on DEBUG_KERNEL kernels") is the best interim solution for
> v7.3.
>
> Christian, Sumit, could one of you apply Jianfeng's revert before the
> final release?
>
> https://lore.kernel.org/r/20260926022026.10539-1-liujianfeng1994@gmail.co=
m/
>
>


Ok, I'll try and revert it for 7.3. We may need to reapply it for the next
cycle along with the solution Rob and folks are working on.

Thanks,
> Karl
>

Best,
Sumit.

>

--0000000000002b1ff2065db76131
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><div>Hi Karl,</div><div><br></div><div data-smartmai=
l=3D"gmail_signature"><div dir=3D"ltr"><br></div></div><br><div class=3D"gm=
ail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On T=
ue, 13 Oct, 2026, 12:21=E2=80=AFam Karl Mehltretter, &lt;<a href=3D"mailto:=
kmehltretter@gmail.com">kmehltretter@gmail.com</a>&gt; wrote:<br></div><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left=
:1px solid rgb(204,204,204);padding-left:1ex">On Mon, Oct 12, 2026 at 10:12=
:02AM +0100, Thorsten Leemhuis wrote:<br>
&gt; <br>
&gt; What&#39;s the status here given that 7.3 will likely be released in a=
 few<br>
&gt; days? Note, I can see from the discussion that this is a complex probl=
em<br>
&gt; that can&#39;t be quickly solved. That&#39;s how it is sometimes. But =
I wonder<br>
&gt; if the current state of things is the best compromise for now or if<br=
>
&gt; Rob&#39;s revert or some other option would be better.<br>
&gt; <br>
<br>
I think reverting my commit 143755bdabaa (&quot;dma-buf: Make DMABUF_DEBUG<=
br>
default to y on DEBUG_KERNEL kernels&quot;) is the best interim solution fo=
r<br>
v7.3.<br>
<br>
Christian, Sumit, could one of you apply Jianfeng&#39;s revert before the<b=
r>
final release?<br>
<br>
<a href=3D"https://lore.kernel.org/r/20260926022026.10539-1-liujianfeng1994=
@gmail.com/" rel=3D"noreferrer noreferrer" target=3D"_blank">https://lore.k=
ernel.org/r/20260926022026.10539-1-liujianfeng1994@gmail.com/</a><br>
<br>=C2=A0</blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"=
auto">Ok, I&#39;ll try and revert it for 7.3. We may need to reapply it for=
 the next cycle along with the solution Rob and folks are working on.</div>=
<div dir=3D"auto"></div><div dir=3D"auto"><br></div><div dir=3D"auto"><div =
class=3D"gmail_quote gmail_quote_container"><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex">
Thanks,<br>
Karl=C2=A0<br></blockquote></div></div><div dir=3D"auto"><br></div><div dir=
=3D"auto"><div class=3D"gmail_quote gmail_quote_container"><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid r=
gb(204,204,204);padding-left:1ex"></blockquote></div></div><div dir=3D"auto=
">Best,</div><div dir=3D"auto">Sumit.</div><div dir=3D"auto"><div class=3D"=
gmail_quote gmail_quote_container"><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">
</blockquote></div></div></div>

--0000000000002b1ff2065db76131--
