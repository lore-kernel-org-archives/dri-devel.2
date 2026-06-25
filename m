Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE30FCDE012
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 07:54:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D071D10F483;
	Fri, 26 Jun 2026 07:53:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XBlp8QIB";
	dkim-atps=neutral
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com
 [209.85.128.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6BD7D10E1B7
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 09:07:14 +0000 (UTC)
Received: by mail-yw1-f180.google.com with SMTP id
 00721157ae682-806c225f4d3so20068827b3.2
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 02:07:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782378433; cv=none;
 d=google.com; s=arc-20260327;
 b=ffQmknVPMHGSo/CiYTMwxvaBovfqwxrANEW7pmLXIphVa7ABUUoPK60c0n7CdGSI9q
 mj3mV8uBVrz+yNImFHK36ONlTZDOi490zoPKS8yFvZigeKwuKwnWGQjcHCLxMfHBKn0R
 3ZtQTAF/hluR+EYtsaqtrPH4RAjWoj6O7TV65xV3l3I2yYdnP1yOLpebmKc5SsrKKOGX
 +26YxSbzUdmvEs6PnB9fchkDBA+UYVIcLyEzh4xAzv2OZNsnu6S9RcHlgcUABNHitvgV
 jd+Wj07bVht5BaQUPV7W45nLsz5hI0lgdB/qZTwwx8yAuyctLm7JKqW+Kaw9nIGYNsPP
 GvPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :mime-version:references:in-reply-to:dkim-signature;
 bh=NxMnKEtRmutvBESglMehXusUK7HyhLRrYQtbmHJavXY=;
 fh=4ush0x4Y2skUEtEPptCogoj49o2dn2mASsMg+BiqTlQ=;
 b=DehuGLDoY6iUhjYJrjSBraQbm4n12C3sWQhHEqyhnH+Y7z0z4x6UCBrhPMZmQW85RX
 lStEdSkSl9/cAtAZORE6K33WrBItpbjcFNiiUnm1/2y42+5nhkYw2x0OhJSphzh+P2SJ
 wWI/reYreaID6m1sFzAZLgbk0spwIhW4gMoumJTDj6OsYWv578lAOlPzuPc8ObSXlrIF
 Tz4pH+u7c9jO+7FCNwLQ1I9zalRE3ZRrTSPsORE5u/IfOJRK6nklbfOv8TsVPqOABJES
 mQahNrku3uvzMGsqDrve/q1Bqiul5ddscEtZEDwNHis3e+mwjN9qZ+hU0YY0mJpzXx17
 +g3A==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782378433; x=1782983233; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :mime-version:references:in-reply-to:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NxMnKEtRmutvBESglMehXusUK7HyhLRrYQtbmHJavXY=;
 b=XBlp8QIBFd9WCyngEqVSRmhG3DmGnJjRgifpAJdo93HEcSo5A/4AXrOVuakBje2bbq
 YuGBazp2NNewhRSqYlOxPAcKE/e94ONX35Fnp63gBvRc0DE0uoHwNBZSNCV4zeXPp27o
 H+F4YuoDsjKG8Xet5BPNiaxQIZM+8n6AJr1K8p/mTytBf4ay8+0yZPDQgGMQ4EQEuQFW
 6gMc136ZbZ8fHPYpcQykeAco41FvcRyPC1yQ0nEAKujEMrQLDMFu55MNxaNMGzk/Kw2Z
 Ki7lX1K2MXukizaNj+a2QPndBOK55i/X2+7suUhkXdtPF6C3SzbIuSWM3MybHYgrnseC
 9PcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782378433; x=1782983233;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :mime-version:references:in-reply-to:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NxMnKEtRmutvBESglMehXusUK7HyhLRrYQtbmHJavXY=;
 b=hSI11H/4N+TDYkb930LCppdkj7nmUr242ql02rSUrTLxqjncG/2vXFu9THTppiwgua
 1VsyJzfWh3lXkKdDRncK8tyotFBcE4PsOKS+6pY5j8utDk//kNjyHmn4mRUNysvtWu/h
 s4J33lvK9XuKvcHpgvEQ16n68N/ECGDOHNNPE4kcWtPqLNO9mKsVphxQTcUKh1eMhhbm
 EySW3nJ4ya8l9HpmUYiFE0aziriOJkFBjaKKIDRRVitf4pQ91vOJRONY2E2cSoSykiNt
 nRnl74aqvcU63ZV7YG8KTOrOcl83yYE5SCNtT67+h29EW1D9kOue2PrXiTbcf9HifH4/
 Ixqg==
X-Gm-Message-State: AOJu0YzvaVxvgEoFptcwFTkDBOBsaKSoQGjCVKwGinOJZithm7h1qU0p
 GIrYpBBcH5e31SldiwUC6gebLs6eMfBChFBnHlonSzWi+dZ/IG+jvU+ApT+Rpdl4tULoXBL+/Of
 jWPoknEWbvR2VoCnLGTFyoEM7JUFnO7p5aOLzh5A=
X-Gm-Gg: AfdE7cmdsFpH6r2MatO9j+qenfAv9gZ6YaJ3P+K1KVuGlNwD/u+rWF8kj/Anzj6o37e
 Frm6uIELJ+gnhSInZbJTpQ+/DbwMetoo1yh5se3ryp6IDzSwXj+FgTmXigW+cFZ3N3Ak7eQX/8h
 Ta+QxrB0t99dxkuqC8mNKz75PMZpOrPMFMD7jD7r/EKgzryhZiMN5KKoHNfz3PikbLzu1tOdKW1
 FIa8cdRUVeAYPp1fCb7P2ip+cP8vvKxc+42tN7UzeB2T3q9I3feVgJTHi9TjL+QsCOiJRebzw==
X-Received: by 2002:a05:690c:6d01:b0:7f6:bed8:5420 with SMTP id
 00721157ae682-80a688ddd42mr17613747b3.16.1782378433216; Thu, 25 Jun 2026
 02:07:13 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST; 
 Thu, 25 Jun 2026 02:07:10 -0700
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST; 
 Thu, 25 Jun 2026 02:07:10 -0700
In-Reply-To: <06bddfca-d868-4043-ac6f-28ca103fff02@amd.com>
References: <20260624125242.11232-1-alhouseenyousef@gmail.com>
 <06bddfca-d868-4043-ac6f-28ca103fff02@amd.com>
MIME-Version: 1.0
From: Yousef Alhouseen <alhouseenyousef@gmail.com>
Date: Thu, 25 Jun 2026 02:07:10 -0700
X-Gm-Features: AVVi8CezeCOLduwTJPystmNQMhzBFoDmS1Ku5dFQnx-yRqXL5wq6-ysBxSe0GV0
Message-ID: <CAMuQ4bUdL+7OujEf6f-OUPeDgVK4FHXbL32vk3cPBN9DbGOkmA@mail.gmail.com>
Subject: Re: [PATCH] dma-buf: udmabuf: avoid list copy size overflow
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Gerd Hoffmann <kraxel@redhat.com>, Vivek Kasireddy <vivek.kasireddy@intel.com>,
 Sumit Semwal <sumit.semwal@linaro.org>
Cc: dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org, 
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Fri, 26 Jun 2026 07:53:42 +0000
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

Hi Christian,

Agreed. I sent a follow-up that makes list_limit unsigned and keeps
the checked array copy path.

Thanks,
Yousef

On Wed, 24 Jun 2026 14:58:58 +0200, "Christian K=C3=B6nig"
<christian.koenig@amd.com> wrote:
> On 6/24/26 14:52, Yousef Alhouseen wrote:
> > UDMABUF_CREATE_LIST copies an array whose element count comes from
> > userspace. The count is compared against list_limit, but list_limit is =
a
> > signed module parameter while the count is u32.
>
> We should probably just drop the sign from the module parameter instead.
>
> I don't see an use case for negative values here.
>
> Regards,
> Christian.
>
> >
> > If the limit is raised too far or made negative, that comparison no
> > longer bounds the count to a range where sizeof(*list) * count fits in
> > the u32 temporary used for the copy length. A wrapped copy length lets
> > memdup_user() copy fewer entries than udmabuf_create() subsequently
> > walks, leading to out-of-bounds reads from the copied list.
> >
> > Take a positive snapshot of the module limit and use memdup_array_user(=
)
> > so the multiplication is checked before copying.
> >
> > Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>
> > ---
> > drivers/dma-buf/udmabuf.c | 9 +++++----
> > 1 file changed, 5 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/dma-buf/udmabuf.c b/drivers/dma-buf/udmabuf.c
> > index bced421c0..b4078ec84 100644
> > --- a/drivers/dma-buf/udmabuf.c
> > +++ b/drivers/dma-buf/udmabuf.c
> > @@ -469,14 +469,15 @@ static long udmabuf_ioctl_create_list(struct file=
 *filp, unsigned long arg)
> > struct udmabuf_create_list head;
> > struct udmabuf_create_item *list;
> > int ret =3D -EINVAL;
> > - u32 lsize;
> > + int limit;
> >
> > if (copy_from_user(&head, (void __user *)arg, sizeof(head)))
> > return -EFAULT;
> > - if (head.count > list_limit)
> > + limit =3D READ_ONCE(list_limit);
> > + if (!head.count || limit <=3D 0 || head.count > limit)
> > return -EINVAL;
> > - lsize =3D sizeof(struct udmabuf_create_item) * head.count;
> > - list =3D memdup_user((void __user *)(arg + sizeof(head)), lsize);
> > + list =3D memdup_array_user((void __user *)(arg + sizeof(head)),
> > + head.count, sizeof(*list));
> > if (IS_ERR(list))
> > return PTR_ERR(list);
> >
> > --
> > 2.54.0
> >
