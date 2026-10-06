Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADCFCCA5FF0
	for <dri-devel@archiver.kernel.org>; Tue,  6 Oct 2026 08:34:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 083DF10E03E;
	Tue,  6 Oct 2026 08:34:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="qVIoSlzl";
	dkim-atps=neutral
Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com
 [74.125.224.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C56C310E03E
 for <dri-devel@lists.freedesktop.org>; Tue,  6 Oct 2026 08:34:37 +0000 (UTC)
Received: by mail-yx1-f43.google.com with SMTP id
 956f58d0204a3-67718201466so297713d50.3
 for <dri-devel@lists.freedesktop.org>; Tue, 06 Oct 2026 01:34:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791275677; cv=none;
 d=google.com; s=arc-20260327;
 b=P4FJXGAguM1IPqonV6lVZD8nAD5cucwafIUcCF72ZqEB+fXLfKhAvs6T7ZjRoyh2SP
 WwZ0n6tBSZ0K433G00iNNl/AktlBBxhoUiyOURwkga1W9E5vWVXF9IkfOwjoHsO1hZ56
 PYQ8aPx7nbZu2ii/R09JTSNw9RAbzAssV4n6HXWD2Ujtc6OTIXzARH8CUCQSLDYYG+nF
 dEUKy60JbglFMDG5c5Ap2tg0ORZOsrvWvxhZcU0Y0L7F+prIqhkbSRR3eRN7PMuf3Xmo
 jtspIOCgeq7QnJ13QDcmRIYabzCoH4GXD4v/m5pYuKkUTI0hPd/hsVGsrCPcYDCgSNS2
 zisw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=I7c5sfwP6lrMix9foJyNvCb4liHbxtX5TCdV95ozbDY=;
 fh=Z+gwi0v9ylYWM8QMbHA9tGVg/CmEoIsAESX8SsJy12g=;
 b=kLS3kFioveK35lh+uYQUAia7M6A8ah4Cn5TAO/YFE3/Ysg3C7s/GvLusdI8tyeyQ/a
 e+OGn4pHAI6c5kHi7QiKlasbDm4EICIkto6S/p7gAlLHUy/0xLvUsZuT5LcGloj95oZN
 hWM+QItBGB0vTXC1ydFrCgvORTBzdGO10xQwWyNIb/ZCxMqFY1vinEdVfSRJLvbJYH+n
 dKNQcWlCzEYIRa9UdlgL+4lJ9MzihSfcQGOKAMkmVy0Myo2QZSVyjooeSX+FEVgK3DVs
 pZ+jNJV254S5II+qwYNzY70ozl9pSluBMZcpQU7Bp7RPNrubHR9NJiLggvUTDI4+sKeC
 OZnw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791275677; x=1791880477; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=I7c5sfwP6lrMix9foJyNvCb4liHbxtX5TCdV95ozbDY=;
 b=qVIoSlzl6qxCPzCGYpBQr1cAxomSWGGSUmQtRUwXXEUf1Hnyd/NfJvdy8eKmthETGq
 9meBhxkBFo03uLUjKqB5QP/3XtGNGWl6w1g0UVH5SsB2P497zN4ryIY7K9XHif7Tyfj1
 avqY1q0jhJ6PwqDIfqnjgnAo1sKnsHHyqpP81LIzPowUINBFXBJFdmCmbQS8anooTLu4
 +ilEvzbH0qq4rAhEx5x1Vn/E1+zcGOB7xfkQFiSGJVI83k2I37RsHGtKWCpeXL/lYVsO
 ihc/rrOThuZVMlaTFQh4G03cF7y4IBfoSuHfgBPjhmJhCfCXz7be06cTSNmnCXXMeCRN
 Sqtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791275677; x=1791880477;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=I7c5sfwP6lrMix9foJyNvCb4liHbxtX5TCdV95ozbDY=;
 b=JNO4Rw0ps2WPeCFvMCilDWvT33xzz5xksCR2Imm/kuStzG+AueVvYrh8Z+nMaeCoLO
 m1GVC3qz5bONRl8s9Z807Br5QsW8UkqfR8mSaVWe8PTB2l4CN+WcHe4QFe+VpG3iszlA
 ffzPsD76TnVV+PahKbweQjwM51npy9K7LuRp6UFoZcvJbrZzq+yPLhj1s1G/lr6QmfVQ
 gWz8aUb3+6oPeqTsY9bchjFLXbBl3EvSSTWAn6T8XnJVJ4z7GAddKYhg75fh31+4LPCq
 mWbAAtvynIx0Yo8EWkS4J7GrLf4JPFaOcqJGARga4HuXlvsShQf/LgjYhFkcRkaANe/I
 IjYA==
X-Forwarded-Encrypted: i=1;
 AKwUvByIN7BP7kPXwuy0WKOGVwuhFuHP8DXo37utedWYX9OCPscU8wz4s+x4tbuJrpGPp78bJz0MmDWIOrQ=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLxn7cFmsbYtyRpyjXt4zYnaJOa/43XrGdUvmgzVPxbY44zCAm8
 63BC7KbopAAq2Wm0nJJndP5lJJvo9qoNCg1barm94tupHjUsqcgW2hakD+sY39z0/PIJ7feehER
 mv+7NlmpkWyzWAhJAPP1QGwBc7u4RAVWdSCkS
X-Gm-Gg: AYBFou1wScRIceA5ThBuyvlS7LW6IndMi2WK9KltOFmxssCpH8KEpYy+pLE+7NL2RE/
 RIbtA7sGrzBOKxDH8mKn26ra68+nJ4y4dCOG4tmWg86WzY/ovQcdk2pDWQz80+wsrt4yuhdPPrS
 z4MUTpekBXzoVPpNEDhAjeUxOGiAKmSM4I7zxnU77r/qIpJzZhoh9u3ZJOipXxnt0HTRiNG1ax7
 DmiGFQEdcwH9SVBNUZt26E0CvLSu9/qssGixiw8TRmyiVjuq04clG/uLH9JUiONZbWQlZkhaOOO
 QJHmrCOGhlyEP8wSWBFngSE+8XyZEqSejJOldgA0RCeeRNhFOF4dncOP
X-Received: by 2002:a05:690e:4090:b0:66d:1131:b81d with SMTP id
 956f58d0204a3-678fcdb41f0mr360405d50.29.1791275676777; Tue, 06 Oct 2026
 01:34:36 -0700 (PDT)
MIME-Version: 1.0
References: <20260930-b4-include-mmu-defines-only-in-mmu-code-v1-0-291eadfde23b@imgtec.com>
 <20260930-b4-include-mmu-defines-only-in-mmu-code-v1-1-291eadfde23b@imgtec.com>
 <CAKbEznsnKevHokY-ip6g7+TG+NQLJcKxaYEbqsKa47dM26s6QA@mail.gmail.com>
 <e392fbc385bf5db80287c1a82892648cbd57978b.camel@imgtec.com>
In-Reply-To: <e392fbc385bf5db80287c1a82892648cbd57978b.camel@imgtec.com>
From: Gyeyoung Baek <gye976@gmail.com>
Date: Tue, 6 Oct 2026 17:34:25 +0900
X-Gm-Features: AclHuK_f0DG7bI4umeIoFlnWV1m25NTWgedKPXlkb7bnDLSz6GBT4yhKqIaa5r8
Message-ID: <CAKbEznsMihNKYUDPYCMLB9RK8tQ+yvK356Uat6Fezo+Ge6JXcw@mail.gmail.com>
Subject: Re: [EXTERNAL] Re: [PATCH 1/2] drm/imagination: Switch to
 kernel-style MMU defines and access
To: Alexandru Dadu <Alexandru.Dadu@imgtec.com>
Cc: Luigi Santivetti <Luigi.Santivetti@imgtec.com>, 
 "imagination@lists.freedesktop.org" <imagination@lists.freedesktop.org>,
 "simona@ffwll.ch" <simona@ffwll.ch>, 
 "tzimmermann@suse.de" <tzimmermann@suse.de>, 
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "airlied@gmail.com" <airlied@gmail.com>, 
 Alessio Belle <Alessio.Belle@imgtec.com>, 
 "maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>, 
 "mripard@kernel.org" <mripard@kernel.org>, 
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
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

Hi Alexandru,

> > >
> > >  /**
> > > @@ -442,18 +424,18 @@ pvr_page_table_l2_entry_raw_is_valid(struct
> > > pvr_page_table_l2_entry_raw entry)
> > >   *                        associated with @entry.
> > >   *
> > >   * When calling this function, @child_table_dma_addr must be a
> > > valid DMA
> > > - * address and a multiple of
> > > %ROGUE_MMUCTRL_PC_DATA_PD_BASE_ALIGNSIZE.
> > > + * address and a multiple of %ROGUE_MMUCTRL_PC_DATA_PD_BASE_ALIGN.
> > >   */
> >
> > nit: ALIGN is now a shift, so "a multiple of" in this comment no
> > longer fits.
>
> Hi Gyeyoung,
>
> Thank you for the review!
> Regarding the nit remark, ALIGNSIZE was also a shift before changing it
> to ALIGN.
>

I think ALIGNSIZE was the size rather than the shift:

  -#define ROGUE_MMUCTRL_PC_DATA_PD_BASE_ALIGNSHIFT (12U)
  -#define ROGUE_MMUCTRL_PC_DATA_PD_BASE_ALIGNSIZE (4096U)
  +#define ROGUE_MMUCTRL_PC_DATA_PD_BASE_ALIGN 12

so the comment now reads as "a multiple of 12" (Only a nit though).

-- 
Thanks,
Gyeyoung
