Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D145EFED9ED
	for <dri-devel@archiver.kernel.org>; Tue, 17 Mar 2026 16:46:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F70D10E576;
	Tue, 17 Mar 2026 16:46:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SwRI3JSX";
	dkim-atps=neutral
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com
 [209.85.221.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F5AC10E6EB
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Mar 2026 16:46:28 +0000 (UTC)
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-439b6d9c981so48869f8f.1
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Mar 2026 09:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773765987; x=1774370787; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=++LJXc5vhHGA5o4goL+ihczkLTg8146WStrt9s5OCas=;
 b=SwRI3JSXZUxoEGFOU43jTcPqwQ9aJjRvI5ay/dXxPLM4j6wnbT8giEIUKimSXHOMUr
 V1DouIqzSWYTisMbaGnzt7KsRBIwUZYepeeGdZD3BB0AwhKOEh1nHXKT4alQRfzolmcT
 fUUQvu05b5sHo/flsvCH5902rxLD3y5l6knPPs3yw4EvqWThtD4fjS//B6QIYd0P/EG6
 gN8XfeMjVBRN4X5x5YVFbSxczMkKoGy4JcFK+J9v1srZJRw7F+Zi2CQZN2QyShJtZZOc
 bFIntEVtkQGu5H+QTrBVJi1+uxWGTb2WA+DAFj+7SXZ4NV4pQX55dDikx/S2g6UGWF1L
 XKlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773765987; x=1774370787;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=++LJXc5vhHGA5o4goL+ihczkLTg8146WStrt9s5OCas=;
 b=Z/zSUz56qoK3ToK1tYP7trsxYjX+KVtTBO9zpptkAJmnTn26F5KK/oh2QTLZI4d0gQ
 GgWnJBSkcSVbThrCT3ZZFOikta+gZFTKRYVu8L7p0xnhSlOktUtjZZyq1dympAcX1WWX
 OD6ZTnY+95b0f2MWJ7cSxqL1zHz+n5rr0CF5+Q/s1ADF3nlnYNUEtFfHr5zuTo2IONag
 ULLWe6yfSJeMvvc0BeCAXtQIxUyJAulU/vwvIXK489IfASWUtJ77RgXvdyQ66SV94EcM
 l4blFagZNrxWD9o00L0v3ky2ApeMScUYKH8Q37rtHaGw94ICXB3O208IB+wFNic6/5Bg
 xdtA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU5RgfJKn8wKIcTK3FJXpQlLuoieswu9TbzhKmEDBvKWdhEkj6aMGu+UPoo5IVh3Ob51tVdH+mlbQc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwKAjRkFgI6FTo76qC4trK+uZairf1ZDSH9RIOncSm6v6RT6m9D
 2pzXheVUd6Sc4PG5WRaJ361WGNZ1DuRrviB4zUkl3/6hDFbHTqiP//rx
X-Gm-Gg: ATEYQzxR/SPigQXdb/tBAPJQvMSHpvxA4jqoNBEirXdHY9Bf5QHzk50wIpH0a+T8nkw
 /v7w3dz4MGJG+yNEQ3tAYGPSX4mvQPbvvvyB6xxJW+Lq7j3IrgevcG3AhSpUux7G92rWhzNVHNQ
 5HqLo4/cSScAUv69ijFX6FH777/TAHFo5/IKIG1x06fJ/h0RyttCNn5/RL6ENSKZbKqgW6UQnm4
 jt1MGGKXZ5vraPpL993GPLaKegF6TIqoQ1HxHKWL5ynOAv4yrozZ4JRaTvPR53pLLRfXkkSuU3f
 72UQyyvTQaTLZX4IU+qUgSFm+NOF7y834HjmhVGFt+Ab2DhjzwtDHLDlvITlmTKXQD9o30wz5kv
 BErjhgJvh5AuG9+qlJzVN0X3dF5NDJ4EhkE3Ty+e+f/hzzeWQ/JM85PebUJL2CTWdACU649X2i6
 l94SOsyTYczTcunLE8L5wJRy+QWoWxHkyXDxOg0tdpio95g70lUU1BoaG54IK9P19l
X-Received: by 2002:a5d:5f82:0:b0:439:df59:abc5 with SMTP id
 ffacd0b85a97d-43b4981a167mr7391373f8f.12.1773765986492; 
 Tue, 17 Mar 2026 09:46:26 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b518a3e3csm566981f8f.35.2026.03.17.09.46.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2026 09:46:26 -0700 (PDT)
Date: Tue, 17 Mar 2026 16:46:24 +0000
From: David Laight <david.laight.linux@gmail.com>
To: "Arnd Bergmann" <arnd@arndb.de>
Cc: "Matt Roper" <matthew.d.roper@intel.com>, "Arnd Bergmann"
 <arnd@kernel.org>, "Matthew Brost" <matthew.brost@intel.com>, Thomas
 =?UTF-8?B?SGVsbHN0csO2bQ==?= <thomas.hellstrom@linux.intel.com>, "Rodrigo
 Vivi" <rodrigo.vivi@intel.com>, "Dave Airlie" <airlied@gmail.com>, "Simona
 Vetter" <simona@ffwll.ch>, "Dnyaneshwar Bhadane"
 <dnyaneshwar.bhadane@intel.com>, "Lucas De Marchi" <demarchi@kernel.org>,
 "Tvrtko Ursulin" <tvrtko.ursulin@igalia.com>, "Umesh Nerlige Ramappa"
 <umesh.nerlige.ramappa@intel.com>, "Raag Jadav" <raag.jadav@intel.com>,
 "Niranjana Vishwanathapura" <niranjana.vishwanathapura@intel.com>,
 intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/xe: use %z format string for ptrdiff_t
Message-ID: <20260317164624.79843d2a@pumpkin>
In-Reply-To: <20260317145647.0d5de2a1@pumpkin>
References: <20260316224357.658520-1-arnd@kernel.org>
 <20260316225118.GD2729713@mdroper-desk1.amr.corp.intel.com>
 <e46c3681-6f5f-4a41-b5bf-72627b4ec87a@app.fastmail.com>
 <20260317145647.0d5de2a1@pumpkin>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Tue, 17 Mar 2026 14:56:47 +0000
David Laight <david.laight.linux@gmail.com> wrote:

> On Tue, 17 Mar 2026 00:07:57 +0100
> "Arnd Bergmann" <arnd@arndb.de> wrote:
> 
> > On Mon, Mar 16, 2026, at 23:51, Matt Roper wrote:  
> > > On Mon, Mar 16, 2026 at 11:43:46PM +0100, Arnd Bergmann wrote:    
> > >> From: Arnd Bergmann <arnd@arndb.de>
> > >> 
> > >> ptrdiff_t, size_t and long are the same size on all supported architectures,
> > >> but gcc requires the use of the %zx modifier instead of %lx. On 32-bit    
> > >
> > > Nathan Chancellor just sent a fix here:
> > >
> > > https://lore.kernel.org/all/20260316-drm-xe-fix-32-bit-wformat-ptrdiff-v1-1-0108b10b2b6b@kernel.org/
> > >
> > > His solution uses %tx rather than %zx, which according to
> > > Documentation/core-api/printk-formats.rst sounds like it's probably the
> > > most accurate format string for this case?
> > >    
> > 
> > Right, Nathan's version is correct. I wasn't aware that size_t
> > and ptrdiff_t have different modifiers.  
> 
> Consider:
> void foo(size_t len)
> {
> 	char *p = malloc(len);
> 	char *end = p + len;
> 	ptrdiff_t diff = p - end;
> 	printf("len %zu, diff %td\n", len, diff);
> 	free(p);
> }
> Clearly foo(5) output "5 -5".
> But what about foo(5u << 29) on a 32bit system with a large unlimit and
> a big enough hole in the address space.
> More likely would be something running on an x86 in real mode.
> There malloc(65000) might be reasonable, so size_t would be unsigned int
> but ptrdiff_t would need to be a signed 32bit type.
> 
> Of course, in linux, they are all 'long'.

I should have said 'the same size as long'.

> 
> 	David
> 
> 
> > 
> >       Arnd
> >   
> 
> 

