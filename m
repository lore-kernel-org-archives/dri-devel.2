Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD61606A339
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 18:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=em9RQ3XA
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE7C3112F77;
	Fri,  6 Nov 2026 18:42:24 +0000 (UTC)
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com
 [209.85.160.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F46A10E3C4
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 18:42:18 +0000 (UTC)
Received: by mail-qt1-f175.google.com with SMTP id
 d75a77b69052e-533202fe429so95091cf.0
 for <dri-devel@lists.freedesktop.org>; Fri, 06 Nov 2026 10:42:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793990537; cv=none;
 d=google.com; s=arc-20260327;
 b=Lw4PSV0ZgmZ3EFX0dD/8XUngqUyIp3qHOO/6XSz8+sXux0VzUyi7p9wBIUbyIkimeE
 PfBOTzm/HzWModcpKP3xpvHNZSB1xou61aj3ACsaDGKmRjuIsKYfLhca0VTt4OgdozA9
 Bt7sy++oTHCBiHmjaeQmyNSnhraEVP5T0MyKz6xFxvz38s/mNBTQ92u/xjaUUvNoizpd
 9Yl2CZW29oM0li73i43tMpulyHUo7s+La7DSMd/14v+KoP4SxDeZ6tfK1tTzYTlHxU34
 duTJ0+oNWDOHJluYqrBumo4EIekmdf697A4AUUIKuDI6wXmW+z6bGTqfllQtkPiKP5SQ
 Kweg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=9O0I1WlvitVAffqL6IMDmurKacq17pLSSS1ily/aCXQ=;
 fh=7MfP7+PduiKHwybBd8sjtj4cvDy2e/CR6209fhE8LrA=;
 b=QakV46DEAce105QK5HQzqsZsuykwtG4EzqDIuk86AP4vm+JRtzFxhKlgctksSp0O5v
 Jg29Ujwhj5QrC0yquJ12wiRHL8s5X3OJ9YfaME85krw4fGWJiJF4FTNN4+8WAEfIv7Gb
 1FvRW6UXwCGpDyQ9gs/V4B2Y9d4ZwbA9yS0C6VHTQ2rh1GEWZjEWu0NseAtpoL8nxi7F
 lpHDQ0Pe8VEp+vt8fVAYadNH4HKo9pUpns4I5DYTFCLo5bDh9r/fOkF8WcLTNvsHmLCB
 e/+1CzhvoLbHyz7VIP+o623aI98j8jVdWkFNeyZ0yivo1gG8zMnS8nHDqz71+Za14bcH
 m5lw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1793990537; x=1794595337;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=9O0I1WlvitVAffqL6IMDmurKacq17pLSSS1ily/aCXQ=;
 b=em9RQ3XAP0IB9itE3a3VA2HIXW0iYRkOcj8J3IEqkORKNnJ1zbjTRSch8pzNBoivO6
 XbGCBmpbvYluG6Cd4ly59sVnH7J6zEvBnVkimW/mMCIQp8jEo7I/qtC3zCBcpVkYQLZg
 sH0EZZgJsfZtO+CZifMlOk8T7c+QrffalVdYIrG/pz60MZFT8iQgQYb6qx35+Y1lNS9w
 CdWUVM5zWfeTUxYvyJwtGZXfFsEV/b2BYG5htkFbYOX9wt24J59IFxr36COhqPu10GFY
 RQYsSCx7B0Fxl5gLdhCe/P/1UljhNsmclHl+7P1G0XpACe38fXY/PRo4xRYjW6xxRZRd
 6Kvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793990537; x=1794595337;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=9O0I1WlvitVAffqL6IMDmurKacq17pLSSS1ily/aCXQ=;
 b=BYv6Fv/Yik8QnVVWPFCS5Os8+zis0OEwTIgYAjZZhKGLUwKPSFdkgw873BhdiPtBO9
 1AzVzYAadRIvMgjNhcOpFbU2GvvlVvSCB45Je/bUCdEoapi8sBh/1aAbiNrdl7/6baqC
 b7ZH1+lkLqyKSw8byb6FNjoQY2h99fYwADjGDowATM1Kez203F+j2GDnlOq+wpefn3/H
 YNpMjQX78bjOiRGKbPyyhQZdu6pTIk784OqUoo8gtrTBYUDmkWEgODx9DMlnWMx0JHMu
 vh/VuqORzsBungor/VEGFzibWpdMoXFeFC9vN20jxsUTp1+1tfN0Gqe1AZn9FcRVVqif
 vU8g==
X-Forwarded-Encrypted: i=1;
 AKwUvBwl8f+6o6yQQCfUM0fmXokVo1hJ5JF++MrTYAcmFp8t30YvTJsGiBXPy4SVCHPP32EvcJrDxIgqIoo=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z873TtqHES4/ET+yyKf9e6szqjqnbzXXQpHQ/9OHD7h+DNtrTf3
 C5EII8UNH6w0VsjScMRKRCtvVlYh71meGI8HN/YTQ+iheFXcOQ5D8gHMw4yMfYfNXC+LL6Vk+HK
 22FAhBo6vPZA72DrwqI5czpiatZmiPz13twGv7d+c
X-Gm-Gg: AYBFou3KW8xLcyGKNMW+uZ8CWibFR+v7rVlbYhiuLWfrg70o1lEV046UhiiIo7MfWjt
 ly9FEkJ/eIZjXq2r26K+NTaf7kX2vFtHX9Lu2V3qNHjtrj0yqpJWxm7+4/OKkxMyqxxzUrNsqlE
 7NHp4DxrGI8Ph21Q0xhieED2kC99xqWFMG+V51y7v2sI7mY9r0KvyiUsaDToAm5oMepKvqUyEJL
 HHTLG/Q64iDh9fcWT5ej2yL4k0OoOU8lORUl9aC+9HgDoF6B3SlQSc05GYDCk/IwkuMM8E/HMGK
 szTtJW4OheOp9bUD+8fss0UNdNw81Yu/ocSkUXGvtrU/Te/ivZrOdbwMbh/YNvja6/P5DhdBPb/
 AORumOrZrMVrbxdNM0lKU+Iwk7dyHCtWRUlJXqALFnhTpePwZT9Nekl5P52n4qePYEIM6YHS+Xn
 qW/CD1RrOgrW4uf/e9ot6aMoM=
X-Received: by 2002:a05:622a:90c:b0:533:9746:9a86 with SMTP id
 d75a77b69052e-54f5c235197mr3962781cf.5.1793990536696; Fri, 06 Nov 2026
 10:42:16 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20260811204123.3198370-1-tjmercier@google.com>
 <CAO_48GEUhpyeenX8Vu1NoDnvzib5FGv3rOBYNYwQEWu1-6cjaQ@mail.gmail.com>
 <CABdmKX0uiX=QKFAYgwwBPHW-X3vh-Rm7w-cNp9EsJzQarTzDpQ@mail.gmail.com>
In-Reply-To: <CABdmKX0uiX=QKFAYgwwBPHW-X3vh-Rm7w-cNp9EsJzQarTzDpQ@mail.gmail.com>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Fri, 6 Nov 2026 10:42:03 -0800
X-Gm-Features: AclHuK8a9YKRuRmcG8Sb2ftYE5SfU2l8w8O16-ruNv6bWd_JSLmgbTqw6Ki40U8
Message-ID: <CABdmKX3Ep0cAPakwKDYWnOkrFgfhsJAv9Mh1us+OfscyNeb2tw@mail.gmail.com>
Subject: Re: [PATCH] kselftests: dmabuf-heaps: Open heap device files O_RDONLY
To: Sumit Semwal <sumit.semwal@linaro.org>, christian.koenig@amd.com
Cc: benjamin.gaignard@collabora.com, Brian.Starkey@arm.com, jstultz@google.com,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linaro-mm-sig@lists.linaro.org, shuah@kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
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
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Aug 12, 2026 at 9:06=E2=80=AFAM T.J. Mercier <tjmercier@google.com>=
 wrote:
>
> On Wed, Aug 12, 2026 at 8:02=E2=80=AFAM Sumit Semwal <sumit.semwal@linaro=
.org> wrote:
> >
> > Hello T J,
> >
> > On Wed, 12 Aug 2026 at 02:11, T.J. Mercier <tjmercier@google.com> wrote=
:
> > >
> > > Write permissions on the /dev/dma_heap/* device files are not require=
d
> > > to issue ioctls and allocate dmabufs. Applications should be opening
> > > these file as O_RDONLY. The BPF dmabuf_iter selftest already does
> > > this. [1]
> > >
> > > Users are pointing to these selftests as examples of how use dmabuf,
> > > and encountering permission errors on systems where write permissions
> > > are not available on /dev/dma_heap/*. Apply the principle of least
> > > privilege to selftests which open dmabuf heaps by removing the write
> > > access mode and using O_RDONLY for the open() instead.
> >
> > Thanks for the patch.
> > >
> > > The same is true for the vgem test using /dev/dri/card.
> > >
> > > [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t/tree/tools/testing/selftests/bpf/prog_tests/dmabuf_iter.c?h=3Dv7.1#n49
> > >
> > > Signed-off-by: T.J. Mercier <tjmercier@google.com>
> > Acked-by: Sumit Semwal <sumit.semwal@linaro.org>
>
> Thanks for the quick revieews John, Christian, and Sumit!

Hi, I don't think this has made it into any tree. Can this get picked up pl=
ease?
