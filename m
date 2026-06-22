Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EF8CCDB46F
	for <dri-devel@archiver.kernel.org>; Mon, 22 Jun 2026 13:11:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B53710E6C3;
	Mon, 22 Jun 2026 13:11:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="L4Ln4Td0";
	dkim-atps=neutral
Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com
 [74.125.224.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D5EA410E6BE
 for <dri-devel@lists.freedesktop.org>; Mon, 22 Jun 2026 13:11:51 +0000 (UTC)
Received: by mail-yx1-f54.google.com with SMTP id
 956f58d0204a3-66310a69f65so2144936d50.2
 for <dri-devel@lists.freedesktop.org>; Mon, 22 Jun 2026 06:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782133911; x=1782738711; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=XkaEWxUJkCuHp/17+ud4oWXJ3qqAKnltzqopfMTtFIs=;
 b=L4Ln4Td0DqrkZ11ZqeVNt/ol8NpCrMCqcFC/LeGcMcFiR9EixxX3NaCdENAE8Etn0W
 YWI0lbByyf7l/qPwhn4HDOArsGH48BHvHp07egRuSEUBHTrNoaETNo6IXe3K8l08O3vC
 sqR+snu007I8yBncyjcLNwOKobuvJyaAqBJToslWJwrgrrQkpXZOwuqcMRzrOVhmwJFa
 jGuAsIyA9fMF1irlMKOVZpWje7rDcR+m6PCTl0URBFSdr3KG1inMN/Ntx33tb1+zqYXp
 0xnhXJZA2NmqhBXtFGG7eCJa9wioGz+gUZX71tDQEV/XLx3aYDWwjLsrb9R+riUw2Oeo
 P+aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782133911; x=1782738711;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XkaEWxUJkCuHp/17+ud4oWXJ3qqAKnltzqopfMTtFIs=;
 b=arPSarqXILBFr9TDjrNuCs6NojmuZcfoe+E/ziAstHHM2/1XnFlC5SR4Hs8umlzDCl
 kj2QdVER2oVasn+8+X9HRJuN9VouGuaYt70Ih5JMMC/kAsstf+BrvRPRJ/QmE87Sltrw
 LYl8pK3jPSCQn4ReaqdFwm+2G8HO99soQZ/hjfxNmLObL4Kdb/uHjcTCyHpMlbddbPqX
 yP96kj5WI/vO4W/1ToRGMlwO//B88GkLY4QFOCssqQ1ervlA0eBof67bK6JGUEvw63Gq
 4JLPB4xJ2vNETQ8pI59zZQO2+2VhNNckX7E0DFjCVkGLfUOmlvaglMDCibYIK7UtsUcU
 5kaA==
X-Forwarded-Encrypted: i=1;
 AHgh+RoSyyzaq/kpvwU3294uct8MckuYfb2MjjM0kVZK3OwUmfTnNL+cRQPGcANxmV6xxAi5ewSdcXA9X08=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwrHPPn3l4Y6e/kqqcTfPdrnO4Wws93gR6jI8Hiw+N/D5jqct76
 UGjmBKmU62yZPSPia8ivhjWSdh3rpAVLbx760d+RJBa+T1BqSuTkM67xiRH1Xw==
X-Gm-Gg: AfdE7ckw+jyYmztSmJOphl1TVZOvrQ0BFgI0SpfBlQ/73JhnS+W6GMXx9Zz8fEUhf1G
 FszfzvV0i7BOonQAjrlMFAKAmu5emMxoBwDm+vUhLyWMuv3zBArxn3dzxtIk7+OHxFoU7mcvqlK
 b9kXc6GECFqQDeKTPrMyro1jPRX9DZ8ePX2FRNCSTrgRSfw5uldjhdsi+sIp7onun8pU2jR6+rC
 jbYp6u3ohGFWFFKyP1YfKZ2JfLlgN70t3SPg2PC3og6ctviexJuUjTmXlgNb1oKsmHxsGJORuNJ
 qnTknU2tNQO3iWvL5RbppluXXnsGeDccXmUMmZVFKz9I9PVDmaypYG+adUzgjN6Xb7EOaF6azWv
 qSzo3ZzYLhLHh/yFrurosJz85HKn+gjBiLGlK4DflggaTRfFQ+/WgulmLOHEmn77Za0d6OVxV5m
 uLNdDYXsk=
X-Received: by 2002:a05:690e:120c:b0:660:54e4:5dd1 with SMTP id
 956f58d0204a3-6630333ac1bmr11505521d50.44.1782133910591; 
 Mon, 22 Jun 2026 06:11:50 -0700 (PDT)
Received: from localhost ([38.101.158.131]) by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-66314ac3f96sm3600882d50.1.2026.06.22.06.11.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 06:11:50 -0700 (PDT)
From: Yury Norov <yury.norov@gmail.com>
X-Google-Original-From: Yury Norov <ynorov@nvidia.com>
Date: Mon, 22 Jun 2026 09:11:49 -0400
To: Steven Rostedt <rostedt@kernel.org>
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 John Ogness <john.ogness@linutronix.de>, Thomas Gleixner <tglx@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Julia Lawall <julia.lawall@inria.fr>,
 Yury Norov <yury.norov@gmail.com>, linux-doc@vger.kernel.org,
 linux-kbuild@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 dri-devel@lists.freedesktop.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-rdma@vger.kernel.org,
 linux-usb@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-nfs@vger.kernel.org, kvm@vger.kernel.org,
 intel-gfx@lists.freedesktop.org
Subject: Re: [PATCH 0/2] tracing: Move trace_printk.h out of kernel.h
Message-ID: <ajk0lT9P0SeuD94j@yury>
References: <20260621093430.264983361@kernel.org>
 <dbb5915e-6587-4de9-87f3-76bea5024da8@kernel.org>
 <20260622090826.20efadb3@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260622090826.20efadb3@fedora>
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

On Mon, Jun 22, 2026 at 09:08:26AM -0400, Steven Rostedt wrote:
> On Mon, 22 Jun 2026 10:05:13 +0200
> "Christophe Leroy (CS GROUP)" <chleroy@kernel.org> wrote:
> 
> > > There's been complaints about trace_printk() being defined in kernel.h as it
> > > can increase the compilation time. As it is only used by some developers for
> > > debugging purposes, it should not be in kernel.h causing lots of wasted CPU
> > > cycles for those that do not ever care about it.  
> > 
> > Do we have a measurement of the increased compilation time ?
> 
> I believe Yury does.

I re-run compilation is a more strict environment, and the difference
is negligible.
