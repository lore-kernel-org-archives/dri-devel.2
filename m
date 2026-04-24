Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52A96FED3F2
	for <dri-devel@archiver.kernel.org>; Fri, 24 Apr 2026 17:30:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A817110F679;
	Fri, 24 Apr 2026 17:30:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lwKYe7c6";
	dkim-atps=neutral
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com
 [209.85.216.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 370C510F3D2
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 08:06:34 +0000 (UTC)
Received: by mail-pj1-f52.google.com with SMTP id
 98e67ed59e1d1-35e576110adso5257633a91.0
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 01:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777017994; x=1777622794; darn=lists.freedesktop.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=/RCpdNlcyc5wjzZkBzWIIC1nFpk179iwlYkDekoHWOw=;
 b=lwKYe7c6nw0kDK2mAVFw4HYOvherfmt1tWvYu2WGaS6XhgzD+mepnht0RyDxKm6Gfc
 AtA+f7k4o0hkov+rGIoreTe7pQMTQJbT2Ilipb7Ptuo9RoAL2cYzv6C2VW1eZTfgqSGF
 l2Auy0yjJVN54OzOv3Jr03ZR+cAxWEyjSdYfoBZGmhiBbXEEVtuwAVzYXz1qTOMLeGF5
 4tD6pFexqg6f1yUF4FKetfbccUgDgpkVZf8+1vVSHhI9+jJElkFlM8rs+ksSj1SwRvHx
 zRQnSjsX4odTBaQMZulnxhjGQXylQsRnmePoQLEFqALIFC5aQBu5GHJSqDO0VB+7fRID
 1WZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777017994; x=1777622794;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/RCpdNlcyc5wjzZkBzWIIC1nFpk179iwlYkDekoHWOw=;
 b=UaGexcLokX0LMzFD3vMyhn4adk17Jgr48FozLZ+fKd8NiHbfXSpqjN0nTxIjdWdi+B
 fDwa+GZUYFXMOgRkZvIJlUDaIWnAssqCS6D+p0V7XbaQb0OluRVpHU6Z+KF4B6uvnMoj
 5zDgIs0z7Pl6xRb8DZYArAGK5/NHsIk9OwBedfc3UUOTyJXWwx+uWiehjVkJ21T2L9Rb
 1mJD9Wnji8Oy3eY0+6za8u2gyTRkYg9squccGESt1dCayRDj92OWrix4dTim5etNqatL
 jd4IMIsznr58pAO6dDB7lmUZZo8DQ2h0oqg6cZB1j+44c1hhMLK1HeEEjPpmw2ZM+7vI
 KHMw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+I5qgWKhdw4x7haLzpdrnmbTX53eThEceg1pmQ3XHYfI0rEaL4dAOIfI3YLitVINXndKvzFZchHC4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyRGTOyHQlLLkHKEMiUqpVEdOxziIvv6NOjidjFQEb6YfBEon1K
 aiIy7WWjvfrMpyaJs7E+rKba6aesxzPEol9SPkxiFa25F8hsBUOX83gf
X-Gm-Gg: AeBDieuwajXZp2XCjOGc9VeYiyImUCyU1XDoq9NyZDzmOtOhzPouXpCuOZKxtI4SNRk
 As2EJZDJMt0NDNGbjz7vfvD0bTHui0hcIuic7ylmxkk7mP6dOHBfogRRMa+6V/A1eN0Knj9I23Q
 jN+Zay+czbXD53aX2DEeD3jnGdaKkIedmjgLBG6sTnKkgv81+sw0JK51Gw+qonEOsyPwWXUz2B2
 S8EEVkg28HfFNuzV4qFtbq3Zvt01IgMTIl/+s9Lb3PZkP6pZDDu+6oKb2ppfD5Q/1keq7OzRA1J
 hbDxhFqbZi3fr+7vgsqtGpnhV9fqTBryttnti7q0SkAHkvH29TIkqJHab0RBfOepp4s5zM9Pf/c
 TCmMbFa/2h5QIkUUz0op8z0mg+wPbHpLiBiVd8+jpxTYXYQERci3ig+Ot8MMh6NyqvTSiO+uaiV
 IB+c8R2OPg9+Q7zFqO69Tl1FRCJVE5NbHDEHK6Gne6sGhNqesjMi9GjUhv6xQe+ZoH7xtzVMktl
 MIAmA==
X-Received: by 2002:a17:90b:3ec5:b0:35f:b4c1:91ea with SMTP id
 98e67ed59e1d1-361402ee818mr23969038a91.13.1777017993532; 
 Fri, 24 Apr 2026 01:06:33 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([129.41.58.4])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-361419739dfsm23565688a91.13.2026.04.24.01.06.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Apr 2026 01:06:32 -0700 (PDT)
Date: Fri, 24 Apr 2026 13:36:18 +0530
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
Message-ID: <aeskOeb9uBiPptEJ@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <20260424054742.45832-1-mkchauras@gmail.com>
 <20260424054742.45832-3-mkchauras@gmail.com>
 <b4dcb464-7784-47e2-a973-6d731ab9ccf8@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b4dcb464-7784-47e2-a973-6d731ab9ccf8@amd.com>
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

On Fri, Apr 24, 2026 at 09:56:16AM +0200, Christian König wrote:
> On 4/24/26 07:47, Mukesh Kumar Chaurasiya (IBM) wrote:
> > When building with LLVM=1 for architectures like powerpc where
> > CONFIG_DMA_SHARED_BUFFER is not enabled, the build fails with:
> > 
> >   ld.lld: error: undefined symbol: dma_resv_reset_max_fences
> >   >>> referenced by helpers.c
> >   >>>               rust/helpers/helpers.o:(rust_helper_dma_resv_unlock)
> > 
> > The issue occurs because:
> > 1. CONFIG_DEBUG_MUTEXES=y is enabled
> > 2. CONFIG_DMA_SHARED_BUFFER is not enabled
> > 3. dma_resv_reset_max_fences() is declared in the header when
> >    CONFIG_DEBUG_MUTEXES is set
> > 4. But the function is only compiled in drivers/dma-buf/dma-resv.c,
> >    which is only built when CONFIG_DMA_SHARED_BUFFER is enabled
> > 5. Rust helpers call dma_resv_unlock() which calls
> >    dma_resv_reset_max_fences(), causing an undefined symbol
> > 
> > Fix this by making the function declaration conditional on both
> > CONFIG_DEBUG_MUTEXES and CONFIG_DMA_SHARED_BUFFER. When either is
> > disabled, use a static inline stub instead.
> 
> Well we are clearly missing something here, but of hand that doesn't looks like the right fix.
> 
> When CONFIG_DMA_SHARED_BUFFER isn't enabled then the whole dma-resv.h header can't be used at all.
> 
> So you also can't call dma_resv_unlock() from the Rust helpers. Which means that we need to make the Rust helpers somehow depend on CONFIG_DMA_SHARED_BUFFER.
> 
> Alternative would be to provide dummies for the functions in dma-resv.h when CONFIG_DMA_SHARED_BUFFER isn't set, but that looks a bit like it just hides the issue.
> 
> Regards,
> Christian.
> 
What about something like this:

diff --git a/rust/helpers/dma-resv.c b/rust/helpers/dma-resv.c
index 71914d8241e2..53c119f1b144 100644
--- a/rust/helpers/dma-resv.c
+++ b/rust/helpers/dma-resv.c
@@ -2,6 +2,7 @@
 
 #include <linux/dma-resv.h>
 
+#ifdef CONFIG_DMA_SHARED_BUFFER
 __rust_helper
 int rust_helper_dma_resv_lock(struct dma_resv *obj, struct ww_acquire_ctx *ctx)
 {
@@ -12,3 +13,4 @@ __rust_helper void rust_helper_dma_resv_unlock(struct dma_resv *obj)
 {
        dma_resv_unlock(obj);
 }
+#endif

This seems to fix the issue and makes sense, whoever wants to use the
dma shared buffer will anyway enable the config

Regards,
Mukesh
> > 
> > Fixes: 0c6b522abc2a ("dma-buf: cleanup dma-resv shared fence debugging a bit v2")
> > Signed-off-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
> > ---
> >  include/linux/dma-resv.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/include/linux/dma-resv.h b/include/linux/dma-resv.h
> > index c5ab6fd9ebe8..23c8db0b5214 100644
> > --- a/include/linux/dma-resv.h
> > +++ b/include/linux/dma-resv.h
> > @@ -311,7 +311,7 @@ static inline bool dma_resv_iter_is_restarted(struct dma_resv_iter *cursor)
> >  #define dma_resv_held(obj) lockdep_is_held(&(obj)->lock.base)
> >  #define dma_resv_assert_held(obj) lockdep_assert_held(&(obj)->lock.base)
> > 
> > -#ifdef CONFIG_DEBUG_MUTEXES
> > +#if IS_ENABLED(CONFIG_DEBUG_MUTEXES) && IS_ENABLED(CONFIG_DMA_SHARED_BUFFER)
> >  void dma_resv_reset_max_fences(struct dma_resv *obj);
> >  #else
> >  static inline void dma_resv_reset_max_fences(struct dma_resv *obj) {}
> > --
> > 2.53.0
> > 
> 
