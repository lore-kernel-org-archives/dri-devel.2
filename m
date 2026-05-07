Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 845A3CD3427
	for <dri-devel@archiver.kernel.org>; Thu,  7 May 2026 11:52:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E231810E042;
	Thu,  7 May 2026 11:52:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="HGNab578";
	dkim-atps=neutral
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E65810E042
 for <dri-devel@lists.freedesktop.org>; Thu,  7 May 2026 11:52:33 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-4891b4934ffso87765e9.0
 for <dri-devel@lists.freedesktop.org>; Thu, 07 May 2026 04:52:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778154752; cv=none;
 d=google.com; s=arc-20240605;
 b=VaF5xNK6v3vLkx60mU+P2JBVrJJ/2sZxXrniJWQKFKzc8Eer3FcvxrfxG7O8ydXAf1
 1o5x8gxvXqV8FTeE8rsEttuVyvZLphcebynclZ7w3qzDv2KCLuJtRElJ9jTZ5T3ZVTc3
 G0JhRsceD8CTCBrBy+9P3CfSG+i2nUvuV8nUhzl71Vjfq91SSFUpvg31ymQPYL8aTjG4
 z1QyjpZnnnR+UJ9jjuIjPq23pOCPkKy9BXx35vjWON2b3u2Ws6qqNAMfmvaDIs5EMrbq
 QQNp2yNaByrLh+xedDqLYazDcGMdYIjmzJKMk8/k3VQxLlOX9tU5YiT8E/PVYeD7nVvt
 NwQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=h2fMYnCYIrNFnwnb1qtbtb1UtOtqen5sV4Rb7709pMQ=;
 fh=mVhPbqivWzGuxxaeJeRFe+LsWul9Fm1hvqzmUBFt0io=;
 b=ZBQ0/05+jppRhuK3qKKoLKKD8kotnR5FeTF6PCVYmlpLdt8UoYuCIoxJclDxO9hHfM
 o1EpwXIS7/QSLCEwO0VylFyWedGOxYE58Igk7ZMzubMMKkHIzyxeUIuCdYWDzVmdcKON
 6C5fe4Rrz8PIlpdBzET7QEKhQVC0WfHP/NPSr4qFoOr0UqgspsW+dhSWkARFOsne5kix
 9nyhfsbxOjg9j9TNRDL+pMwD26ofbGZ+tG+3WCcg98SHURwKaxT71sSzCOmJzCEDJJ03
 FcKF9RkIOpRHp+WiCaMicq6Frt60x7VV/xRk/cKReCF5nr1IrTnnJ+tniDV8OLQt3umz
 Lekw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1778154752; x=1778759552;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h2fMYnCYIrNFnwnb1qtbtb1UtOtqen5sV4Rb7709pMQ=;
 b=HGNab578tZysBtIg2KPT/cKe/RSILIEVWvyKLHFw9046VhptcWSWWl0lWZ5Hgdi2nS
 +l4yNsDFDcd6tYnvXr21FOdiVwT/IveeNcDXsFdJwCLMbnb/T90N0o14r1IOCXTILzuL
 jjc/oWkcQ1DVy202a4/DHaBp/UyRxiJPKfnwQ5JGv2s9Hgg17zzWk+OIR0guHfxlaAK4
 yKZNiDPtovOZXXrbaMLoBlYPtUI97/N4t1qfyg+2f2CWVDiuqRe6o5QU7RobBxswOd8R
 ebIJtvnXKEhxu/DakVu/0QYD6xf45z4CC/cABlHIqBk2FBjB9AVZqp/Cj4iElS3fSSdq
 ilXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778154752; x=1778759552;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=h2fMYnCYIrNFnwnb1qtbtb1UtOtqen5sV4Rb7709pMQ=;
 b=QKkPkes7j2IfHnTPUaLukbylz0lX9eEXvYa07STghL0JJaII5KPTQKRaIMvZhnpQ7Y
 qnse/lRWR+OGPQ5yaMMb2oitCHCEu5FHb/sR5/hK2u/hYmmVwi6PIjca+SEwtNPpR+rS
 yyOidNbeNowz+WZmErge+Hk2iO47VT+fjNadgbCA24KtLN6UPxKJlRwKs5Lk8g43LdCS
 JLXjj955XGPHU4jSn2WbHj3CioyhQuEauKHCYTMo+R8W2sWcMGEJIO+u9qfbJ9WETvY2
 x7nXBY0oYF95OqPv/SvqV5sI7SofUvnMrC8PyufBkn6FBWDgCNO9wyIiKRWTBZn3TZVO
 CW/w==
X-Forwarded-Encrypted: i=1;
 AFNElJ+wH2AN8FU/oUE8mfS0Jz5VA+pfukQHk9uonCr1zzAsXFDg9xj8pPxDYDOkRb+n5jBjkmmGclfSt6g=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy0sbo3Vm15fhuAK0FIn5kb83ueaRIA3SJod+cBCjjJ62MY5x/G
 Ra13W84WC6RsABFzmpo/BLhwbAhIJRAR4oEaNrwNiSDYjqZxjf+Eyn0OcHyvGK7SFhGPLuEXVdZ
 VrTpJvbMgQJN3TlTtNtF2pga8r2nccSFUGcZcXDXL
X-Gm-Gg: AeBDietT28xiVpJGTBqbby2PVZ39iC8Dksw2BJm9LYLCUY96iLz2UT0lSUAbS53WXHY
 xo0z0tEFUKsqUvOjm15MneQTzsOUIcG+ZAuTqcYtsPlCgnlsW8xvFSNs7+Aas2hrV6ReADbfkSN
 m9Y3mZ6m6Cpo1AKYWLidLgQGQiMTOOECspHwUqkCQAzgLituxmnG73ZCa3h9GphHrg40JqfvV0b
 CC6cyHiP/AoSlTrXMIK6V/QxJEQ0CDnjdeynNDz0HQe60qzlnD2+lD6coIw90JKHJkJL5xfVkDI
 H5SIJrBvkz1DIvWZi/zn6zrJ2hXMKZiWDa2vJPtoSAfrg2c3Wv9ep1czitRU
X-Received: by 2002:a05:600d:6450:10b0:48a:55dc:9c1e with SMTP id
 5b1f17b1804b1-48e5d45d30dmr663245e9.10.1778154751362; Thu, 07 May 2026
 04:52:31 -0700 (PDT)
MIME-Version: 1.0
References: <CAHijbEXhuVRgkkPA2dAC=njGBU7vpAbxAbsSmxvvPznO-ckVRA@mail.gmail.com>
 <cf945dda-f526-4544-bc43-22f70acb28f5@amd.com>
 <CAHijbEXQfm4QDDfo1yiVBV9mVvogGqt_BAu2ipnhqa-EDOKteg@mail.gmail.com>
 <CABdmKX1pDc7wpLVQzM0ihH6AfW+=KWdyaZuorMqWCbC80Y7-Bw@mail.gmail.com>
 <b9c1b7a3-12a8-4104-b98f-a1e57b343046@amd.com>
In-Reply-To: <b9c1b7a3-12a8-4104-b98f-a1e57b343046@amd.com>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Thu, 7 May 2026 04:52:19 -0700
X-Gm-Features: AVHnY4LrtQD1vp6VlN2Vm6s4bEP0BXc-IojZFRNiMBPSNFKjm4nQmQFAY7f1gs8
Message-ID: <CABdmKX0KQqD=QtongicEBL5y-3xMvf94YC3wqH_FynLVTJaAew@mail.gmail.com>
Subject: Re: Regression due to /sys/kernel/dmabuf/buffers removal
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Julian Orth <ju.orth@gmail.com>, corbet@lwn.net,
 dri-devel@lists.freedesktop.org, 
 linaro-mm-sig@lists.linaro.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
 Sumit Semwal <sumit.semwal@linaro.org>
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

On Thu, May 7, 2026 at 4:35=E2=80=AFAM Christian K=C3=B6nig <christian.koen=
ig@amd.com> wrote:
>
> On 5/5/26 16:32, T.J. Mercier wrote:
> > On Tue, May 5, 2026 at 6:00=E2=80=AFAM Julian Orth <ju.orth@gmail.com> =
wrote:
> >>
> >> On Tue, May 5, 2026 at 2:41=E2=80=AFPM Christian K=C3=B6nig <christian=
.koenig@amd.com> wrote:
> >>>
> >>> Hi Julian,
> >>>
> >>> On 5/5/26 14:25, Julian Orth wrote:
> >>>> In ab4c3dcf9a71582503b4fb25aeab884c696cab25 ("dma-buf: Remove DMA-BU=
F
> >>>> sysfs stats") the /sys/kernel/dmabuf/buffer directory was removed.
> >>>>
> >>>> I've been using this interface, specifically the exporter_name file,
> >>>> to detect dmabufs created via udmabuf. Such dmabufs show "udmabuf" i=
n
> >>>> exporter_name. I've been doing this for two reasons: 1) to detect th=
at
> >>>> mmap on such buffers will be fast and 2) to detect that GPU access t=
o
> >>>> such buffers will be slow.
> >>>
> >>> Crap, I really hoped that Android was the only user of that sysfs int=
erface since that approach turned out to be quite broken.
> >>>
> >>> It's number one rule on Linux that we don't break userspace. So I hop=
e that you don't insist on bringing that interface back, but if you do I wi=
ll just revert the removal until we found a better solution.
> >>
> >> Bringing it back shouldn't be necessary.
> >>
> >>>
> >>>> With the removal of that file, that detection mechanism no longer wo=
rks.
> >>>>
> >>>> I'm not particularly fond of that mechanism but it was the only one
> >>>> providing that functionality that I could find at the time. If there
> >>>> is another one, ideally an ioctl on the dmabuf, please let me know.
> >>>
> >>> The virtual fdinfo file you can find under /proc/$pid/fdinfo/$fd also=
 contains the exporter name for the DMA-buf.
> >>>
> >>> You can find the full documentation here: https://docs.kernel.org/fil=
esystems/proc.html#dma-buffer-files
> >>>
> >>> Is that sufficient?
> >>
> >> I think that is sufficient. I probably didn't use fdinfo initially
> >> because 1) it's a lot more work to parse and 2) I wasn't sure if it
> >> was intended to be machine-readable or if there could sometimes be
> >> newlines in the values and such.
> >>
> >>>
> >>> Additional to that the debugfs for DMA-buf also contains that informa=
tion and I'm open to the suggestion with the IOCTL.
> >>
> >> My application runs as a regular user so it cannot access /sys/kernel/=
debug.
> >>
> >> Having an IOCTL would be ideal if it is not too much work. I'll fall
> >> back to fdinfo for now.
> >>
> >> Thanks, Julian
> >
> > Phew, I'm glad fdinfo suits your needs.
>
> Yeah, exactly my thinking as well :)
>
> A college questioned me this week how to find DMA-buf stats for debugging=
 and it turned out that Google points to the outdated DMA-buf sysfs documen=
tation instead of the debugfs one.
>
> No idea why, maybe we need to improve the documentation here a bit.

Ah, this? https://source.android.com/docs/core/graphics/implement-dma-buf-g=
pu-mem

I will update it to mark it as deprecated, and only applicable to
kernels < 6.18 where CONFIG_DMABUF_SYSFS_STATS was first disabled.

source.android.com updates are usually released with the platform,
which is very soon for Android 17.

> > Adding an ioctl would introduce new UAPI so I think we'd want to avoid
> > that unless absolutely necessary.
>
> CRIU has some similar requirements, e.g. they need to know the exporting =
driver of a DMA-buf.
>
> Not sure if the fdinfo file will be sufficient for that case or not. But =
yeah I agree that we only need this if actually necessary.
>
> Regards,
> Christian.
>
> >
> > Thanks,
> > T.J.
> >
> >>>
> >>> Regards,
> >>> Christian.
> >>>
> >>>>
> >>>> Shipping an entire BPF compiler in my application, which the origina=
l
> >>>> patch suggests as the replacement, is not an option when the removed
> >>>> alternative was simply reading a file.
> >>>>
> >>>> Thanks, Julian
> >>>
>
