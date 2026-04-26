Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99DB7FF8850
	for <dri-devel@archiver.kernel.org>; Sun, 26 Apr 2026 07:52:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 64FE410E18C;
	Sun, 26 Apr 2026 07:52:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YWvSKg93";
	dkim-atps=neutral
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com
 [209.85.216.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6714810E18C
 for <dri-devel@lists.freedesktop.org>; Sun, 26 Apr 2026 07:52:39 +0000 (UTC)
Received: by mail-pj1-f44.google.com with SMTP id
 98e67ed59e1d1-35f9ab079bdso6102102a91.2
 for <dri-devel@lists.freedesktop.org>; Sun, 26 Apr 2026 00:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777189959; x=1777794759; darn=lists.freedesktop.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=8zTG+Dw6oqSR8kg/1RMP0Ayk7RcQFqZXb8XQS8VS+9A=;
 b=YWvSKg93XSIW8ozP2gQf/x9GdwjDYYk0UeKRk+mAzjMpNg2xjwf/+Zx42FYQYTFF6Z
 wcLBazXxI40rj6BagdO66ajF8REN2ULq6EmojgBrmBuOtG/Ub2gpoDBH5v/+FkSRDwaV
 AULE3mdqsmBRVYvCXl4tqo/DLXCRtfWgQzBIRmjwcgrY0GYr5p+o1doDt80/RTV8xQBk
 5kz7me71NxQu/f91gj6y3BPGm0MkkOIun8SsUZNE2CSM188hdWXL+WMMksbLgra4z3hp
 IRBWFPJ64xd649ZrSlTkyVIRpzUgu7RzpQbzPRNWpCtflOgQzYlvf2azr3EbbJ1zTfjF
 6tmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777189959; x=1777794759;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8zTG+Dw6oqSR8kg/1RMP0Ayk7RcQFqZXb8XQS8VS+9A=;
 b=reyUaC621UeQMF6nqlBuu4KT2hvYTAzzlBJs0nKWoPgybsmNPcKghvpA8PlyZBr4eV
 RwejjzP8IElTPpFkUv8x5c8ZLje7jTaNuvnUQrD9g8cVcdstBFlxClDk7OYlpzL23//o
 ekfEoZJR+wvIwWysBLN2zetItwar5tRVT5N5syzbVPueX0WT8xLhR/8VfXLRoEfDzkal
 pvmlUcIT6GILEvR8sUfl3uAXduihKQr7bZ4883ebGw3XuzXn9xyX0ihg5lU7NqGX1Pf0
 00ePAiAbGG6B9Tq5CHAGRk1QKSCDIgvDiMSXCOwPx6Q5Qb45HVdJfI3/OUVWerBGETSv
 lv+w==
X-Forwarded-Encrypted: i=1;
 AFNElJ+2Yk7bjljj3U1xX0QGDV5UPo89JUVp+hKKVlYkggQqI827hBK1AZX3Zhj1f9oaJLr3zvvzjIQTL0s=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzxNICbAC2kO4epOyU1EvOVsVbMJQECOM7jIknSzMchHsjmyuta
 aqYxQ3ZZ2X5NnjXT5h5p0L99pCt7AzMICU1Fc3AzdKfXHlMBhQWxQWlQ
X-Gm-Gg: AeBDiet5BzBRVEB6fRB8aBvAAlBllQyYZw+fh1sLI1V6SVewAXdA5RfMuWTh1yFcVQy
 6LeAdf3a3lZzOMRj5TJS6AmrPT32c853sA+U9q0a6qRpi9rsYV9XA1nJJ8qP/5MxhN0QG733kmE
 1DICJXzzo49EJz8UTbVz7kodqFI+s+4ZcGKX7GoXNtbcT03v8je8GQOuZYuByNw2+vNgXT2u7vF
 IO5Od4Z6uovaoGHmfCmd+bpWqBIGXz7y6AhMkl2yvmRnfLkeFBWzIUFbIc3J7zYf7plA8zoivxg
 w2DQApc3FN4MgEt2z/55E0NXZYZSLXXHNX1sDr8PC2VH0SVeE+WbaVPFmgOlyUaqUJDtSGs3PJV
 hqTpXWJekDVTL6PCJ4CMt24KldNoCObONbsq4YbclTG7x5yo8TCrkIgJYMA55xuKCQM5Z63vl6M
 8ss3hFiSghb+Jz606l28bxF7DeR+pjG5DGikNw+vaQKz+Hx8ezc6cD0BikBbZQ4WGhycMf3sOru
 jJNK2I9AQ==
X-Received: by 2002:a17:90b:52cf:b0:35e:577c:c9f with SMTP id
 98e67ed59e1d1-361403fb305mr37768192a91.9.1777189958672; 
 Sun, 26 Apr 2026 00:52:38 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com
 ([106.51.164.157]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3613fba1436sm10396034a91.11.2026.04.26.00.52.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Apr 2026 00:52:38 -0700 (PDT)
Date: Sun, 26 Apr 2026 13:22:24 +0530
From: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
To: Gary Guo <gary@garyguo.net>
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, 
 chleroy@kernel.org, peterz@infradead.org, jpoimboe@kernel.org,
 jbaron@akamai.com, 
 aliceryhl@google.com, rostedt@goodmis.org, ardb@kernel.org,
 sumit.semwal@linaro.org, 
 christian.koenig@amd.com, ojeda@kernel.org, boqun@kernel.org,
 bjorn3_gh@protonmail.com, 
 lossin@kernel.org, a.hindborg@kernel.org, tmgross@umich.edu, dakr@kernel.org, 
 nathan@kernel.org, nick.desaulniers+lkml@gmail.com, morbo@google.com, 
 justinstitt@google.com, tamird@kernel.org, arnd@arndb.de, nsc@kernel.org, 
 simona.vetter@ffwll.ch, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, 
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, 
 rust-for-linux@vger.kernel.org, llvm@lists.linux.dev,
 Link Mauve <linkmauve@linkmauve.fr>
Subject: Re: [PATCH V13 5/7] rust: Make __udivdi3() and __umoddi3() panic
Message-ID: <ae3C2gqzoVaovY-h@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <20260424054742.45832-1-mkchauras@gmail.com>
 <20260424054742.45832-6-mkchauras@gmail.com>
 <DI1E781QPU8F.1C28PL0089NP6@garyguo.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DI1E781QPU8F.1C28PL0089NP6@garyguo.net>
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

On Fri, Apr 24, 2026 at 01:43:43PM +0100, Gary Guo wrote:
> On Fri Apr 24, 2026 at 6:47 AM BST, Mukesh Kumar Chaurasiya (IBM) wrote:
> > From: Link Mauve <linkmauve@linkmauve.fr>
> >
> > The core crate currently depends on these two functions for i64/u64/
> > i128/u128/core::time::Duration formatting, but we shouldn’t use that in
> > the kernel so let’s panic if they are ever called.
> >
> > This doesn’t yet fix drm_panic_qr.rs, which also uses __udivdi3 when
> > CONFIG_CC_OPTIMIZE_FOR_SIZE=y, but at least makes the rest of the kernel
> > build on PPC32.
> 
> Can we always build libcore with `-C opt-level=2` even if
> `CONFIG_CC_OPTIMIZE_FOR_SIZE` is specified? It feels like a better fix than
> stubbing things out.
> 
> Best,
> Gary
> 
The issue is not coming from libcore itself. It's the driver that's
causing this.

Regards,
Mukesh
> >
> > Signed-off-by: Link Mauve <linkmauve@linkmauve.fr>
> > Signed-off-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
> > ---
> >  rust/Makefile             | 4 ++++
> >  rust/compiler_builtins.rs | 6 ++++++
> >  2 files changed, 10 insertions(+)
> >
> > diff --git a/rust/Makefile b/rust/Makefile
> > index 2a5428a5503d..ee11fba7a03d 100644
> > --- a/rust/Makefile
> > +++ b/rust/Makefile
> > @@ -616,6 +616,10 @@ ifneq ($(or $(CONFIG_ARM64),$(and $(CONFIG_RISCV),$(CONFIG_64BIT))),)
> >  		__ashrti3 \
> >  		__ashlti3 __lshrti3
> >  endif
> > +ifdef CONFIG_PPC32
> > +	redirect-intrinsics += \
> > +		__udivdi3 __umoddi3
> > +endif
> >  
> >  ifdef CONFIG_MODVERSIONS
> >  cmd_gendwarfksyms = $(if $(skip_gendwarfksyms),, \
> > diff --git a/rust/compiler_builtins.rs b/rust/compiler_builtins.rs
> > index dd16c1dc899c..fc6b54636dd5 100644
> > --- a/rust/compiler_builtins.rs
> > +++ b/rust/compiler_builtins.rs
> > @@ -97,5 +97,11 @@ pub extern "C" fn $ident() {
> >      __aeabi_uldivmod,
> >  });
> >  
> > +#[cfg(target_arch = "powerpc")]
> > +define_panicking_intrinsics!("`u64` division/modulo should not be used", {
> > +    __udivdi3,
> > +    __umoddi3,
> > +});
> > +
> >  // NOTE: if you are adding a new intrinsic here, you should also add it to
> >  // `redirect-intrinsics` in `rust/Makefile`.
> 
