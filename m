Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7E52C43458
	for <dri-devel@archiver.kernel.org>; Fri, 10 Jul 2026 20:21:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4AA7910E232;
	Fri, 10 Jul 2026 20:21:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="aZPyr+5O";
	dkim-atps=neutral
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0935D10E21D
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 20:21:00 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-493be0fbcc5so12915e9.0
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 13:20:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783714858; cv=none;
 d=google.com; s=arc-20260327;
 b=sd3KB+CQsMVgy5QqgNofE9B6f0ohAZC8Hvi8nUKnEH9ll3+/1bqHy496Xc3oRQE2W/
 5QluvazL6GAaKkRkFAtnhWseRdiywQigRUIHZ8eOkuzfredMKY8kT0UffAUKBrh7rFmB
 1Kw+5GSlNK39baG/deCxDnfZBphMLWrr6/ixQUlA6H6b8M60zPrl43A69liQv/GKQ4pX
 GqJE+q4Z3mBFJtD7RTRStcsNRPiQoGlkQXnuIvNJACtuDJsv/8CPt2XVOg83WFrC6ICJ
 GwLUBLFavCBcibhhkbYqf99uR1fi/u74l3V08Qgvgjjnb40Gm0qZZIst8+D6OU48AXsa
 5jJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=tkBhvVXb0hd5Otr/cjZP7Js0wsG7Wez2ww0OpDh742M=;
 fh=o+D1xV0wDIhhKyiQLFOvj4P7HNNbvCXcAuVddKm4LQg=;
 b=Alw5dQNIkY+NJy+ed5Zd+EOCa4OXxkthPCx64REf6xITo9Esy13PiyGv/IKP7mImBe
 Wsfg64naKx1Xj24M6KIomyKUsKVv+vckdDmE0sg942OVufTXBeB7cDzC6PclSmn0fnTq
 wNPo5uD9cTCgCb8BVgOAsAh500qltPZPZZEVOGPvIR1AXsZYSIvRo+3qGkIHEidrm6jL
 04Hv7HxitakW3lqCJ21S/N99ixmZ7uHrenWwbnP1Be7z/Maaa2c0kVhgRZYaQFZU/nsQ
 DSMmJVBjOoVPt8/fKwB65WCTQHsJSs+tph8yQLjseMIAGgOzgBVxPKV/BT7x7nO/3nyV
 shvw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1783714858; x=1784319658;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=tkBhvVXb0hd5Otr/cjZP7Js0wsG7Wez2ww0OpDh742M=;
 b=aZPyr+5ON+Qybtk1NeAhJ/kPxYhkwsX5Awj8+cxiekain5o4ELgbY+6UtJERTyN9iL
 eKw9mss8KwY5koJJcBU2q/k55HSCIpsB85NLCIYXYHtcpshbSLFVtyPGjQ3iWT7YCZ5p
 rQApczAoXg6SL/hPAxkEatHUgoYP4Qa5DxT74+3OtTB3CXOy1GMCwrd8S3hS+oe0Qlu1
 f5MVzQKBEJr8mxM2jxBbcmdga7XSNLApKAA41b8QcrxmxAjXGCZX4gm29GxGrAaVe8gW
 rgvC8itm25vMZtfUo1UU9v0C0XW6E6eUm0iqBfom8jLRBl/qhf/q4fszzxwm3G7npXRS
 2VgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783714858; x=1784319658;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=tkBhvVXb0hd5Otr/cjZP7Js0wsG7Wez2ww0OpDh742M=;
 b=psAYKZrVvQ5I4NVR+qzVAxT1OkbfiR8z0TeIj54IuRTsMpf6ax0vcdTvDsFNjUf/HS
 EZqBtX6Xppj9LoObHrJDmK21JZIuYP0AN3gPAcKNRgCsRpgW6OVRDJ3EximafECrxyNi
 bb+oDCT2dMQ8c5L5O+NyfSj377IaQJGzSg6dyorXX6RwHDHd4KBHWFQizRxz5CZx0glE
 rgrGb/y6cz21kPibwvdP1LmfvZLNEN3mpC1Lwq2L4sg/Bw9vlDfbEpMp3mIqKnH6n1MV
 B7vWmpAcVZ4CXOn1GWaZWdNsmJyQ+7TItaQPV7rUF5ylHl395kxDBGHZpIS9ih9vVDbn
 bUXw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr/kQt84WPgwcnWARm+uqFmd6oIN9gGfq2CvJ4LcjM+5+yHknZ6I/jQN32mRJAnn92J7U52gNsAmsU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx8xsmgSG/2a98iYQQwH5vtFD5ZsdOLIf3Iq2oP8Fg93Cr2/b2v
 os5FkGx0R3rKSjAvzK9FJWSuUUrfHVSg9mD4l/WYuQXNKSToiXVAtCDmexXH46AhzowL4MXZqqW
 uWpSxT1wS0D/V8nWUvQpvHwmKJJes3P6/r8a9rWwk
X-Gm-Gg: AfdE7cn2mTH+IuJW6Rl6iAYrKjm19uJcs8h4q/22P0b8nbskSF5O/4bBKAN9rdFWpzH
 ZJngIyTnHqp1fM0AYO5iHsTwvW3Gml/p2WOUuRMLEmLPfc1B/D5jErb8juGqioGOT/UpgWZy7wg
 qPVsiBLL+mET2vHts1gaJJSDrdVEP50eoYVCJR7BAwKSyuq8yl9xdVNYbkKMa/lZD+QLKsFLi9G
 CsK+j/vAUdvEBmTR94HL0qnnAcUegePsluawWuM9I+d2AvclygBn5Vbw90pbhPfifsydTyC2sCL
 eFr5TUYVkHdHsaosRf5ZHY6cDhM/JgXpqa294LD9+BJWxMQ8riysKCgPqhZReZR5eOs=
X-Received: by 2002:a05:600c:acd:b0:493:aed4:8d03 with SMTP id
 5b1f17b1804b1-493f8cc96d9mr46995e9.9.1783714857850; Fri, 10 Jul 2026 13:20:57
 -0700 (PDT)
MIME-Version: 1.0
References: <20260703080922.1838362-1-shoubaineng@gmail.com>
 <20260710105740.3080070-1-shoubaineng@gmail.com>
 <20260710110645.079DC1F000E9@smtp.kernel.org>
In-Reply-To: <20260710110645.079DC1F000E9@smtp.kernel.org>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Fri, 10 Jul 2026 13:20:45 -0700
X-Gm-Features: AUfX_mypyPGgExDDJXAywI8JQ2oLCreBAwcnKgV8wHGRnZ462d4mBALgKCvqqyQ
Message-ID: <CABdmKX2xt6diYwCs32E7HNL8ULepDfrDQ20iB+HVw5o-pCd0xg@mail.gmail.com>
Subject: Re: [PATCH v2] dma-buf: dma-heap: don't publish fd before
 copy_to_user() succeeds
To: gaoxiang17@xiaomi.com
Cc: Baineng Shou <shoubaineng@gmail.com>, dri-devel@lists.freedesktop.org, 
 sashiko-reviews@lists.linux.dev, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Sumit Semwal <sumit.semwal@linaro.org>, 
 Benjamin Gaignard <benjamin.gaignard@collabora.com>,
 Brian Starkey <Brian.Starkey@arm.com>, 
 John Stultz <jstultz@google.com>, "T . J . Mercier" <tjmercier@google.com>, 
 Sandeep Patil <sspatil@android.com>, "Andrew F . Davis" <afd@ti.com>
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

On Fri, Jul 10, 2026 at 4:06=E2=80=AFAM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Medium] Bypassing the standard dma_buf_fd() API skips the emission of =
the trace_dma_buf_fd tracepoint.
> --
>
> --- Patch [1]: [PATCH v2] dma-buf: dma-heap: don't publish fd before copy=
_to_user() succeeds ---
> commit 869904722955c74d0c6e8c974d3c64c6befabac6
> Author: Baineng Shou <shoubaineng@gmail.com>
>
> dma-buf: dma-heap: don't publish fd before copy_to_user() succeeds
>
> This commit restructures DMA_HEAP_IOCTL_ALLOC to delay publishing the
> file descriptor until after copy_to_user() succeeds. It open-codes the
> fd allocation and installation steps instead of using dma_buf_fd() to
> prevent an fd leak on copy_to_user() failure.
>
> Link: https://lore.kernel.org/dri-devel/175e98de-f414-47d7-81c1-c0fe0a8f7=
f62@amd.com/
>
> > diff --git a/drivers/dma-buf/dma-heap.c b/drivers/dma-buf/dma-heap.c
> > index 3937dd41bb0f6..983dee947c851 100644
> > --- a/drivers/dma-buf/dma-heap.c
> > +++ b/drivers/dma-buf/dma-heap.c
> [ ... ]
> > @@ -175,15 +162,28 @@ static long dma_heap_ioctl(struct file *file, uns=
igned int ucmd,
> >
> >       switch (kcmd) {
> >       case DMA_HEAP_IOCTL_ALLOC:
> > -             ret =3D dma_heap_ioctl_allocate(file, kdata);
> > +             dmabuf =3D dma_heap_ioctl_allocate(file, kdata);
> > +
> > +             if (IS_ERR(dmabuf)) {
> > +                     ret =3D PTR_ERR(dmabuf);
> > +                     break;
> > +             }
> > +
> > +             fd =3D ((struct dma_heap_allocation_data *)kdata)->fd;
> > +             if (copy_to_user((void __user *)arg, kdata, out_size) !=
=3D 0) {
> > +                     put_unused_fd(fd);
> > +                     dma_buf_put(dmabuf);
> > +                     ret =3D -EFAULT;
> > +             } else {
> > +                     fd_install(fd, dmabuf->file);
>
> [Severity: Medium]
> By open-coding the fd reservation and installation here instead of using
> dma_buf_fd(), does this skip the emission of the trace_dma_buf_fd tracepo=
int?
>
> If so, observability tools, BPF scripts, and perf tracing relying on
> trace_dma_buf_fd to map dmabufs to file descriptors will silently miss al=
l
> allocations originating from the dma-heap subsystem.

Hi Xiang Gao,

It looks like this change in its current form breaks the export
tracing that you introduced. It looks fixable by adding a call to
DMA_BUF_TRACE in after copy_to_user in dma_heap_ioctl. However I'm
wondering if you're aware of the dmabuf iterator that traverses the
dmabuf_list? I've backported it to 5.10, so it's available on all our
kernels: https://r.android.com/q/Iaeda328f7693acc1506269c12cac5e7955e5c091
Someone else from Xiaomi even helped with the 6.12 backport. So I
guess I'm wondering if the dmabuf iterator would work for you instead
of the tracepoints.

Thanks,
T.J.

> > +             }
> > +
> >               break;
> >       default:
> >               ret =3D -ENOTTY;
> >               goto err;
> >       }
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260710105740.30=
80070-1-shoubaineng@gmail.com?part=3D1
