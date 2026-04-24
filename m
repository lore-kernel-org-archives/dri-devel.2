Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB250FED3F5
	for <dri-devel@archiver.kernel.org>; Fri, 24 Apr 2026 17:30:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 198F710F67A;
	Fri, 24 Apr 2026 17:30:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eC+nGyRe";
	dkim-atps=neutral
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com
 [209.85.210.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9633F10F434
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 08:34:24 +0000 (UTC)
Received: by mail-pf1-f171.google.com with SMTP id
 d2e1a72fcca58-8318293f02bso360795b3a.0
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 01:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777019664; x=1777624464; darn=lists.freedesktop.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=/LSr35TcIMW6wVIpT4GYu71Od3lJHQ6iIOnrBrPvpf8=;
 b=eC+nGyReIlHod+gMrxexl6fl4rX/h7ZU+QCyPe1jq/RRMEZGHP+STixhiCvUqZCoi2
 a2nw86IyFz0xtpisiTNqzXbwLQxb0VeMNOCh7SKJXFUzgHLBMgXBiWwltgGEOFMlflUS
 O16gBu2yrEO3ZNerkqi+5MNJDkiQeEfSf6EMuO+gowc7s+3jnY6Xm7Lb+8mGUGqROkDS
 Rw/1fNEkXbn5fQJMQyz/dGuTAyhsyvr1kMU2KouKHe4X2LXcDgJw5fER8ICCsBZns8N1
 JTwZSP1GI7YJz3FJfW7e6YsPTLZKwh0XJZ6QrbY5p7O/0lzKCce63PT+RrDXqr2aG51I
 yp3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777019664; x=1777624464;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/LSr35TcIMW6wVIpT4GYu71Od3lJHQ6iIOnrBrPvpf8=;
 b=Z7uFR+lX8nowL1T+wFnIiqNbfabf2aHlHmfX/i3E+55vt8JIQSVPcsoOnNeFHOb5q0
 a6W3VVMrFQsnP5rLFbNuWa78F7lnyW0p4QwqYD6PYf9fK8G9DC2ytyFhlVPQNYofei62
 B/gB8gKUEfbBhza26WuXt6tsVfSz/6pMeJJubwDRAo7QWZifQPLBcod5f0UEqUsYSWZi
 MjfV4q6KMbY9nyNBV7xqEArwlUVJQOp4+mzqX7KoyxUDzGMQs+7WGcWGr0qS3fGRR9Kk
 xRNzABfYkxgWG/kivVOVKfcChUWRPGpihYoBohPflSPH8UrsVFaDGYaP5155EVDF909d
 +63g==
X-Forwarded-Encrypted: i=1;
 AFNElJ8YnDn+OL87S9D9myAU7YLCay3xbTqvV0QOez8vIPR2O/5mXF+4+GslokJHvH9P3VMgl4XBRg0PQFw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxFuoYYYLGZDlKXWoggfPiUrc7Yd5YaTdgfLE+0Bb+UJAmsydEx
 het+f0GWNeCUxynMwKlRCBtlOXy4EvYY7sch3TvhC9yAXEXlqqOM1L2g
X-Gm-Gg: AeBDietFlohqNWcx181UbLEtfYwyVAMeL8c+2LI8Ux1Yd3ErjJ3S7LoA+BvJHMmgJOe
 9shLdQ+WmauV0I1OQ1Q4QjLVIMkgxraUDOUJNQTjLEHKV6u94rNG0OQrt4gVPGw44NmFM3orkXx
 a31ee+y7ho7V06fdoPUzznFgpWRS2SnZttiq9ARBehHYOt+JE5wXToa8f8SKwhabssw6lE8uZ0u
 0ZG0u9Y5fPYKGq6fuHmRZ0Moa6rOScIReF9xxyu+igvh/pkqhet6Bbu2KvGXt1W7ehYk8zGt7ls
 NgqDBlv5D99fVP+i9yxO8mPHvU668v88mlZ2T7fsQKKO8CDZack1A4ZLtj1lB1vzT8Jflhy0XI6
 yxkNgTNXV/OyCtDwUNmjetGpGDBnNcBog1HmL7OCoC29jeZ+ceA0ErdTWvfatNhTfic365EUVgN
 PKZ4BK53A+w4brkWKw1yuawsvSqfWcO8Nx8XPSE65tWZ9GkNIP3S3nm4dLjQS4PI2ip9BAI+oUu
 a23fg==
X-Received: by 2002:a05:6a00:3e09:b0:82f:456c:29f1 with SMTP id
 d2e1a72fcca58-82f8b385c38mr26954369b3a.12.1777019663822; 
 Fri, 24 Apr 2026 01:34:23 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([129.41.58.4])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82f8ebe92desm22485595b3a.44.2026.04.24.01.34.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Apr 2026 01:34:23 -0700 (PDT)
Date: Fri, 24 Apr 2026 14:04:10 +0530
From: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
To: Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, 
 chleroy@kernel.org, peterz@infradead.org, jpoimboe@kernel.org,
 jbaron@akamai.com, 
 aliceryhl@google.com, rostedt@goodmis.org, ardb@kernel.org,
 sumit.semwal@linaro.org, 
 ojeda@kernel.org, boqun@kernel.org, gary@garyguo.net, bjorn3_gh@protonmail.com,
 lossin@kernel.org, a.hindborg@kernel.org, tmgross@umich.edu, dakr@kernel.org, 
 nathan@kernel.org, nick.desaulniers+lkml@gmail.com, morbo@google.com, 
 justinstitt@google.com, tamird@kernel.org, arnd@arndb.de, nsc@kernel.org, 
 simona.vetter@ffwll.ch, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, 
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, 
 rust-for-linux@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH V13 2/7] dma-resv: Fix undefined symbol when
 CONFIG_DMA_SHARED_BUFFER is disabled
Message-ID: <aesqe2NKWhkT4kc2@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <20260424054742.45832-1-mkchauras@gmail.com>
 <20260424054742.45832-3-mkchauras@gmail.com>
 <b4dcb464-7784-47e2-a973-6d731ab9ccf8@amd.com>
 <aeskOeb9uBiPptEJ@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
 <a2241936-579f-4fa6-a9ec-49325d44413f@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a2241936-579f-4fa6-a9ec-49325d44413f@amd.com>
X-Mailman-Approved-At: Fri, 24 Apr 2026 17:30:16 +0000
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

On Fri, Apr 24, 2026 at 10:25:25AM +0200, Christian König wrote:
> On 4/24/26 10:06, Mukesh Kumar Chaurasiya wrote:
> > [Sie erhalten nicht häufig E-Mails von mkchauras@gmail.com. Weitere Informationen, warum dies wichtig ist, finden Sie unter https://aka.ms/LearnAboutSenderIdentification ]
> > 
> > On Fri, Apr 24, 2026 at 09:56:16AM +0200, Christian König wrote:
> >> On 4/24/26 07:47, Mukesh Kumar Chaurasiya (IBM) wrote:
> >>> When building with LLVM=1 for architectures like powerpc where
> >>> CONFIG_DMA_SHARED_BUFFER is not enabled, the build fails with:
> >>>
> >>>   ld.lld: error: undefined symbol: dma_resv_reset_max_fences
> >>>   >>> referenced by helpers.c
> >>>   >>>               rust/helpers/helpers.o:(rust_helper_dma_resv_unlock)
> >>>
> >>> The issue occurs because:
> >>> 1. CONFIG_DEBUG_MUTEXES=y is enabled
> >>> 2. CONFIG_DMA_SHARED_BUFFER is not enabled
> >>> 3. dma_resv_reset_max_fences() is declared in the header when
> >>>    CONFIG_DEBUG_MUTEXES is set
> >>> 4. But the function is only compiled in drivers/dma-buf/dma-resv.c,
> >>>    which is only built when CONFIG_DMA_SHARED_BUFFER is enabled
> >>> 5. Rust helpers call dma_resv_unlock() which calls
> >>>    dma_resv_reset_max_fences(), causing an undefined symbol
> >>>
> >>> Fix this by making the function declaration conditional on both
> >>> CONFIG_DEBUG_MUTEXES and CONFIG_DMA_SHARED_BUFFER. When either is
> >>> disabled, use a static inline stub instead.
> >>
> >> Well we are clearly missing something here, but of hand that doesn't looks like the right fix.
> >>
> >> When CONFIG_DMA_SHARED_BUFFER isn't enabled then the whole dma-resv.h header can't be used at all.
> >>
> >> So you also can't call dma_resv_unlock() from the Rust helpers. Which means that we need to make the Rust helpers somehow depend on CONFIG_DMA_SHARED_BUFFER.
> >>
> >> Alternative would be to provide dummies for the functions in dma-resv.h when CONFIG_DMA_SHARED_BUFFER isn't set, but that looks a bit like it just hides the issue.
> >>
> >> Regards,
> >> Christian.
> >>
> > What about something like this:
> > 
> > diff --git a/rust/helpers/dma-resv.c b/rust/helpers/dma-resv.c
> > index 71914d8241e2..53c119f1b144 100644
> > --- a/rust/helpers/dma-resv.c
> > +++ b/rust/helpers/dma-resv.c
> > @@ -2,6 +2,7 @@
> > 
> >  #include <linux/dma-resv.h>
> > 
> > +#ifdef CONFIG_DMA_SHARED_BUFFER
> >  __rust_helper
> >  int rust_helper_dma_resv_lock(struct dma_resv *obj, struct ww_acquire_ctx *ctx)
> >  {
> > @@ -12,3 +13,4 @@ __rust_helper void rust_helper_dma_resv_unlock(struct dma_resv *obj)
> >  {
> >         dma_resv_unlock(obj);
> >  }
> > +#endif
> > 
> > This seems to fix the issue and makes sense, whoever wants to use the
> > dma shared buffer will anyway enable the config
> 
> Yeah that directions makes sense.
> 
> I would maybe go a step further and don't even compile rust/helpers/dma-resv.c when CONFIG_DMA_SHARED_BUFFER isn't set.
> 
This makes sense.
> But if that is not possible for some reason then this solution is perfectly fine with me as well.
> 
> The general goal is to make the error messages when you haven't set CONFIG_DMA_SHARED_BUFFER and still try to use the DMA-buf functions easy to understand and not something cryptic.
> 
> Thanks,
> Christian.
>

What about this one?

diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
index 625921e27dfb..09ee5cac600d 100644
--- a/rust/helpers/helpers.c
+++ b/rust/helpers/helpers.c
@@ -57,7 +57,9 @@
 #include "cred.c"
 #include "device.c"
 #include "dma.c"
+#ifdef CONFIG_DMA_SHARED_BUFFER
 #include "dma-resv.c"
+#endif
 #include "drm.c"
 #include "err.c"
 #include "irq.c"

Regards,
Mukesh

> > 
> > Regards,
> > Mukesh
> >>>
> >>> Fixes: 0c6b522abc2a ("dma-buf: cleanup dma-resv shared fence debugging a bit v2")
> >>> Signed-off-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
> >>> ---
> >>>  include/linux/dma-resv.h | 2 +-
> >>>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>>
> >>> diff --git a/include/linux/dma-resv.h b/include/linux/dma-resv.h
> >>> index c5ab6fd9ebe8..23c8db0b5214 100644
> >>> --- a/include/linux/dma-resv.h
> >>> +++ b/include/linux/dma-resv.h
> >>> @@ -311,7 +311,7 @@ static inline bool dma_resv_iter_is_restarted(struct dma_resv_iter *cursor)
> >>>  #define dma_resv_held(obj) lockdep_is_held(&(obj)->lock.base)
> >>>  #define dma_resv_assert_held(obj) lockdep_assert_held(&(obj)->lock.base)
> >>>
> >>> -#ifdef CONFIG_DEBUG_MUTEXES
> >>> +#if IS_ENABLED(CONFIG_DEBUG_MUTEXES) && IS_ENABLED(CONFIG_DMA_SHARED_BUFFER)
> >>>  void dma_resv_reset_max_fences(struct dma_resv *obj);
> >>>  #else
> >>>  static inline void dma_resv_reset_max_fences(struct dma_resv *obj) {}
> >>> --
> >>> 2.53.0
> >>>
> >>
> 
