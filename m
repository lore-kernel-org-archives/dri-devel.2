Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1344AC561E6
	for <dri-devel@archiver.kernel.org>; Thu,  6 Aug 2026 08:27:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2179310E2B3;
	Thu,  6 Aug 2026 08:27:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="lQU3Ecy8";
	dkim-atps=neutral
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5631910E2D3
 for <dri-devel@lists.freedesktop.org>; Thu,  6 Aug 2026 08:27:17 +0000 (UTC)
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-495474a5fbcso16823235e9.1
 for <dri-devel@lists.freedesktop.org>; Thu, 06 Aug 2026 01:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1786004836; x=1786609636;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:from:subject
 :message-id:references:mime-version:in-reply-to:date:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=BAOIkOcqalO/o7wmswIlVoL44WUmFncYhIvpomELsHc=;
 b=lQU3Ecy8IzozwrH56iHF5qd8YMEf8B/NVrlublFoL46zUJzChucscpy2cLTyNHISBG
 PqwFYblrkMsOlQji73B+aA0Ji9iqYKuoyqOCVF1q1Xuomja9Kg3zCEoY9pkAo1OESMMF
 IuzNK/8EqzInUGxn6TKiWM8ooOVwFH/h1xXmFTUqONtcvk0up0Q/XSJpKGOg+1tWVyfD
 yBIKLRBmmV0ey+GKnkVzdtPdl45mac6IzY5ifb/M8Rvs82I6QyJggAnoLtrUMgOe4TGi
 JlmWLyAvNdw/6AgSz8/E0T+BHj0OyloRmecQyYtxetjANHo89KUQ/uEfBxDcM1ozAD8y
 7VGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786004836; x=1786609636;
 h=content-transfer-encoding:content-type:cc:to:from:subject
 :message-id:references:mime-version:in-reply-to:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=BAOIkOcqalO/o7wmswIlVoL44WUmFncYhIvpomELsHc=;
 b=EWCTMZot7/it/SSFzy24NTwvPfrRTLIzFqRLU/3MInDuFqYTMAIp9s5m5S+UJidzte
 Juq1/TboTcc4hMR5b+DyiDqAas10gVeTw94UeGrGtERKwN6dnyzMW2sB7JmQrayaJ/hT
 w3wWQYmz3uEYsIOJVFFckBCvAzGCxmc6i3lBeS43530XlQPS69CvLJL6WLSX7CyZ4Qhb
 /iWhDU7Qpf24qnWKSHgv1p8uk9X5jD4vTazsPQWsozXjZmi08dLFkXGuGVG89ixdBZ5A
 tHq3oqt2IcdKWGFsBmIS28FI64aiA4AwS/FbkLdt0RrpcxBsUQRL6zJrpzx/aK3lkdOH
 sFNQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rrb+EU8kQM37/0D36EipXP758UD1IFXDZ7Pi/4T3Ku+qHKjSqk1Qy8wm6OEkF8+wIlnaBUDwPCp2is=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwrdBwi7uizl1Qe/QhAnBMRcGDKt1iyee5MxdO83UKt1EZcqzTR
 NNL9svPPlsemqwiDkJwYhE1aGuz/LbBvHMerYDuSk5l+CR7v4epS3cWhJQ7QfI0x4RK5btswrDg
 8g4h/CaJMvbsyARNyeg==
X-Received: from wmix24-n2.prod.google.com
 ([2002:a05:600c:e558:20b0:497:ffd5:d12])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:a21b:b0:495:4e89:3f30 with SMTP id
 5b1f17b1804b1-4994e7c5e49mr131672365e9.15.1786004835498; 
 Thu, 06 Aug 2026 01:27:15 -0700 (PDT)
Date: Thu, 6 Aug 2026 08:27:14 +0000
In-Reply-To: <20260805104815.104154-1-laura.nao@collabora.com>
Mime-Version: 1.0
References: <anHZpHh_5CZhH5N3@desktop>
 <20260805104815.104154-1-laura.nao@collabora.com>
Message-ID: <anRFYgjaEswOCB2L@google.com>
Subject: Re: [PATCH v3] drm/tyr: add Job IRQ handling
From: Alice Ryhl <aliceryhl@google.com>
To: Laura Nao <laura.nao@collabora.com>
Cc: linkmauve@linkmauve.fr, a.hindborg@kernel.org, acourbot@nvidia.com, 
 airlied@gmail.com, bjorn3_gh@protonmail.com, boqun@kernel.org, 
 dakr@kernel.org, daniel.almeida@collabora.com, deborah.brouwer@collabora.com, 
 dri-devel@lists.freedesktop.org, gary@garyguo.net, kernel@collabora.com, 
 linux-kernel@vger.kernel.org, lossin@kernel.org, ojeda@kernel.org, 
 rust-for-linux@vger.kernel.org, simona@ffwll.ch, tamird@kernel.org, 
 tmgross@umich.edu, work@onurozkan.dev
Content-Type: text/plain; charset="utf-8"
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

On Wed, Aug 05, 2026 at 12:48:15PM +0200, Laura Nao wrote:
> Hello,
>=20
> On 8/4/26 14:23, Link Mauve wrote:
> > Hi,
> >
> > On Mon, Aug 03, 2026 at 03:34:37PM +0200, Laura Nao wrote:
> >> Add a threaded IRQ wrapper for Tyr interrupt sources and use it to
> >> handle the firmware Job IRQ.
> >>
> >> The Job IRQ reports requests from the CSF firmware, including global
> >> interface requests and CSG attention bits. Only the GLB bit is current=
ly
> >> handled, as it will be used to check firmware readiness. CSG bits
> >> handling will be added at a later stage. Add a Job IRQ handler that
> >> masks the interrupt in the primary IRQ handler, processes pending raw
> >> status in the threaded handler, clears the handled bit, and reenables
> >> the mask before returning.
> >> Add a wait queue and a bool flag so the handler can signal firmware
> >> readiness when the GLB bit is set.
> > [=E2=80=A6]
> >> diff --git a/drivers/gpu/drm/tyr/fw/irq.rs b/drivers/gpu/drm/tyr/fw/ir=
q.rs
> >> new file mode 100644
> >> index 000000000000..6eeb1399a7b3
> >> --- /dev/null
> >> +++ b/drivers/gpu/drm/tyr/fw/irq.rs
> >> @@ -0,0 +1,105 @@
> > [=E2=80=A6]
> >> +/// Requests a threaded IRQ registration for the Job IRQ.
> >> +///
> >> +/// # Safety
> >> +///
> >> +/// Callers must not `mem::forget()` the resulting registration or ot=
herwise prevent its
> >> +/// [`Drop`] implementation from running.
> >> +pub(crate) unsafe fn job_irq_init<'a>(
> >> +    pdev: &'a platform::Device<Bound>,
> >> +    iomem: Arc<IoMem<'a>>,
> >> +    fw_ready: Arc<AtomicBool>,
> >> +    job_irq_wait: Arc<WaitQueue>,
> >> +) -> Result<impl PinInit<ThreadedRegistration<'a, TyrIrq<JobIrq<'a>>>=
, Error> + 'a> {
> >> +    iomem.write_reg(JOB_IRQ_MASK::zeroed().with_glb(true));
> >> +    let job_irq =3D JobIrq {
> >> +        iomem: iomem.clone(),
> >> +        fw_ready,
> >> +        job_irq_wait,
> >> +    };
> >> +    // SAFETY: The caller guarantees the resulting registration will =
not be leaked.
> >> +    unsafe { TyrIrq::request(pdev, c_str!("job"), job_irq) }
> >
> > Nowadays we use the shorter c"job" way of creating a &CStr, and I think
> > the macro will even generate warnings in some configurations (perhaps
> > CLIPPY=3D1?).
> >
>=20
> Got it, I didn't get the warning with CLIPPY=3D1, I'll double check my
> configuration.=20

There's not any warning for using it, because macros still need it
sometimes.

Alice
