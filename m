Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEE39FF8855
	for <dri-devel@archiver.kernel.org>; Tue,  5 May 2026 14:33:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 94B8710EB05;
	Tue,  5 May 2026 14:33:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="GWYXIDk5";
	dkim-atps=neutral
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B81410EB0E
 for <dri-devel@lists.freedesktop.org>; Tue,  5 May 2026 14:33:05 +0000 (UTC)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-48d1c670255so50645e9.0
 for <dri-devel@lists.freedesktop.org>; Tue, 05 May 2026 07:33:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777991584; cv=none;
 d=google.com; s=arc-20240605;
 b=PeKZkgTLLWN/sEp8oXrRtznqEBxIF954LL4nAThch/3+ii5M3FdREiv9lMC+5CGhL7
 ZdSMY8qQdngDN2JouLuPN4nNqJTJ/zrBGRTdcrQqnR7b+HVSwZKVfMyeTAL3qkP4Wc7D
 zvMjvz67175qaRYWyGdbkOZSVjhOAaF9L66DMErHlhAiBQA2TFabgi9lF+jnAXUsN3tO
 AbcurzhCSMFxuzMrxPNQuKNGhHwY/52Thq/nrfaW9561L+UyvcjONduX5HADhc1YJgR5
 SEBjNYUUpmesnd/Zrj2w3qzO7sajJ2WeixZurJkHGGf9xjGCz001gIO2xQFxPqLRudt9
 VA9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=5h+jyKMMIPTXybgbDkdR5LLDHZaQlqwfa7Kw+QHGnoc=;
 fh=JWy0uOcrriGjmmorojDJJPQHFiOjxeyFmke3DLnOYJY=;
 b=ga++NaG20JVWdNX3aNS4XSZJFT/8pnPHCQZAIwciOTiuC7htXZ1XIgSZLO99ydUTV7
 hYkdwNaQR0jARIdWR9bEHmugwohhYKjBchVVPs2eA2qjG+thcdB8PiczgrzO8YyEBUPE
 S5kEgXvmRGGcVbMDi7lOXm2KyWWvzL4JmTM4PBSwg/gVXAAe46FaQ501tX/xoSsYFtYy
 c7XTQnnroJQXxyvjrBXXlOCLlTnrPxpiliqFvkhjhT/kgpHSeKftuCHZ0SJWkpI6y2H9
 WN63tK5ZWRxAlaqB8ir55UKGi3xBoCu+SDK1w+MPSWGGN0EZAz+X2Ynvw8w+VSlon3rC
 whCw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1777991584; x=1778596384;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5h+jyKMMIPTXybgbDkdR5LLDHZaQlqwfa7Kw+QHGnoc=;
 b=GWYXIDk5407KTvyVSDuLz9jnQkTywa/jLnPDWpIhAcOKQrDJxUtnr+MiasZv8xDquH
 PZn2fhC5f4qNDYg2Ah+xnlbjQz1hZeqkmCvbU7TctlWObVWWt57jv0WnYNRznTcT5Zl+
 4CUR0lpOzHO2WufTlkApGkmuMaN1zCXURtwDQbkVWKDA2wGAQ6QDV0nnl7X8GBCA8Tlu
 YeGddhj2l/UeczvajrJyIx2zpgOpYijNiGHRJ2OS+kfPm8nyR8kwbqjpgaO4TClPk9IZ
 vbLUCWgObaiBwD7xvNWDRiEPYyyluFNIUe5B4voMTkwv5RyF55k9tz8JKJSZyJe2MabK
 miuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777991584; x=1778596384;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5h+jyKMMIPTXybgbDkdR5LLDHZaQlqwfa7Kw+QHGnoc=;
 b=V+RQJBjK16e60aN1XdIXXV1FKkMLJaJP3m4fNAjHtYogQsFU3GV316vjeQYSYN8CP7
 1RWdNzyIldVICFiCMwP0Unic1Ip1RBWG/yuYTzE0UTINluLu8+lWs6NIFU4PBKqiwDGq
 UrwJB6KCcr2alu0bycOnnB7PaZVSYlK169t0/KicAXPAfQR+2VkOTJhmmOxyXnPONsiv
 55CBrU/r1J+0fK2LVboDXs4zYrENtmzJSUdWEVuXKJQ2jOrdVKmF5x7oYiTl1MdUTWxk
 zK+apcSYSF+0+7LqyxD9iClP80f3ibaK8F8KlTLkTuFOHNXbgnhScQwAhRfshn5/V4F9
 imwA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+daZ2HeOl9kmYFG8zadUqOx9V7a6sSTV83uTbtRAnH9Cdp4OQ4GX8Gd/TrI5l7+KSBM3Ot9evRkhw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzp8cf1qNmSr95QuAph1Lc5f2UH2G4s6f7tAsBw2a3g+T4yiIPA
 w+kTYZUkdH06ULvUBIS5aqn+/mSusHfL8Ge+eUOw/q8WUbd8OHNp2+noP5+qdMVWNVDYTjbbUlN
 I6nFTOBSc54TFdtT2qLLVodjUG0uPUpa5IowbDNpA
X-Gm-Gg: AeBDieu2+McPQjR0fG4P6fZ8VwQRxMFbrC2c0QA/0tlBFmlaM5zSYKel0vVWV4tLz2+
 yyLOepj3NhDsESOlnpXfJZo9XcWyKk8MEFtebOqa2chUJOCHd2LTD5jMNgy8IrMuPhwt8tVnTMR
 HYJ59wyKTZYs46T5Yh/8anbuohJsdenZhjijQm8i8ACaemORjS8PldagisHGrNmxcHahvkYNWRB
 +pC7GEwG7AyupNbTKtJy3k95Z+Qxxbz2JbnSme6RAY9/95zRH+fnpcurokykXyUcH6fq7qe6eRj
 TbCIXfnU1+Ok3F4YIzRq3E6bR+LIeSWmX0PcHvr5JeDwQQORBXUj8z9ZjIFrnGDYnPO7iuA=
X-Received: by 2002:a05:600d:8498:20b0:48a:5f32:62d0 with SMTP id
 5b1f17b1804b1-48d1474eebdmr937275e9.12.1777991583578; Tue, 05 May 2026
 07:33:03 -0700 (PDT)
MIME-Version: 1.0
References: <CAHijbEXhuVRgkkPA2dAC=njGBU7vpAbxAbsSmxvvPznO-ckVRA@mail.gmail.com>
 <cf945dda-f526-4544-bc43-22f70acb28f5@amd.com>
 <CAHijbEXQfm4QDDfo1yiVBV9mVvogGqt_BAu2ipnhqa-EDOKteg@mail.gmail.com>
In-Reply-To: <CAHijbEXQfm4QDDfo1yiVBV9mVvogGqt_BAu2ipnhqa-EDOKteg@mail.gmail.com>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Tue, 5 May 2026 07:32:51 -0700
X-Gm-Features: AVHnY4L-CqRCk9K_YM_TIPhfxSGrpHWAX4Wk2aGhZey2Xo5NNg91bzKueU3NeaU
Message-ID: <CABdmKX1pDc7wpLVQzM0ihH6AfW+=KWdyaZuorMqWCbC80Y7-Bw@mail.gmail.com>
Subject: Re: Regression due to /sys/kernel/dmabuf/buffers removal
To: Julian Orth <ju.orth@gmail.com>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 corbet@lwn.net, dri-devel@lists.freedesktop.org, 
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

On Tue, May 5, 2026 at 6:00=E2=80=AFAM Julian Orth <ju.orth@gmail.com> wrot=
e:
>
> On Tue, May 5, 2026 at 2:41=E2=80=AFPM Christian K=C3=B6nig <christian.ko=
enig@amd.com> wrote:
> >
> > Hi Julian,
> >
> > On 5/5/26 14:25, Julian Orth wrote:
> > > In ab4c3dcf9a71582503b4fb25aeab884c696cab25 ("dma-buf: Remove DMA-BUF
> > > sysfs stats") the /sys/kernel/dmabuf/buffer directory was removed.
> > >
> > > I've been using this interface, specifically the exporter_name file,
> > > to detect dmabufs created via udmabuf. Such dmabufs show "udmabuf" in
> > > exporter_name. I've been doing this for two reasons: 1) to detect tha=
t
> > > mmap on such buffers will be fast and 2) to detect that GPU access to
> > > such buffers will be slow.
> >
> > Crap, I really hoped that Android was the only user of that sysfs inter=
face since that approach turned out to be quite broken.
> >
> > It's number one rule on Linux that we don't break userspace. So I hope =
that you don't insist on bringing that interface back, but if you do I will=
 just revert the removal until we found a better solution.
>
> Bringing it back shouldn't be necessary.
>
> >
> > > With the removal of that file, that detection mechanism no longer wor=
ks.
> > >
> > > I'm not particularly fond of that mechanism but it was the only one
> > > providing that functionality that I could find at the time. If there
> > > is another one, ideally an ioctl on the dmabuf, please let me know.
> >
> > The virtual fdinfo file you can find under /proc/$pid/fdinfo/$fd also c=
ontains the exporter name for the DMA-buf.
> >
> > You can find the full documentation here: https://docs.kernel.org/files=
ystems/proc.html#dma-buffer-files
> >
> > Is that sufficient?
>
> I think that is sufficient. I probably didn't use fdinfo initially
> because 1) it's a lot more work to parse and 2) I wasn't sure if it
> was intended to be machine-readable or if there could sometimes be
> newlines in the values and such.
>
> >
> > Additional to that the debugfs for DMA-buf also contains that informati=
on and I'm open to the suggestion with the IOCTL.
>
> My application runs as a regular user so it cannot access /sys/kernel/deb=
ug.
>
> Having an IOCTL would be ideal if it is not too much work. I'll fall
> back to fdinfo for now.
>
> Thanks, Julian

Phew, I'm glad fdinfo suits your needs.

Adding an ioctl would introduce new UAPI so I think we'd want to avoid
that unless absolutely necessary.

Thanks,
T.J.

> >
> > Regards,
> > Christian.
> >
> > >
> > > Shipping an entire BPF compiler in my application, which the original
> > > patch suggests as the replacement, is not an option when the removed
> > > alternative was simply reading a file.
> > >
> > > Thanks, Julian
> >
