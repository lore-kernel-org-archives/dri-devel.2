Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EDF6C5DF87
	for <dri-devel@archiver.kernel.org>; Thu, 20 Aug 2026 12:20:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7860310E1DC;
	Thu, 20 Aug 2026 12:20:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.b="Q54PkPqW";
	dkim-atps=neutral
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com
 [209.85.219.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 043D610F010
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 12:20:51 +0000 (UTC)
Received: by mail-qv1-f54.google.com with SMTP id
 6a1803df08f44-8f23e851626so14573576d6.3
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 05:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ziepe.ca; s=google; t=1787228450; x=1787833250; darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=CFAD3PPmyEYBnRQoyhozco7Gx3OsZl5eV5ORNG74mm8=;
 b=Q54PkPqW2HEzp1KQlr+JX3owrVCnFkn6uLwbUU9USkl2S/eH1f1b+FLJ57oGEjW/3H
 6BOBQkMrIPa5lBLoPGcfOhpSuqfBXKTdr70LFKmNLd1N1O8O80WcP7QWLFpLkzqqb5Vn
 xDqUOuljuLgmx70bIQYrPbib/dPpjkHETlrFl+z4QKZf7FKwsqZ0XQaTr2yuuwCpKIAJ
 Ayh/pyZfNpdy3qOv1n8EjBY+eMpTpL04PvY5ppYLRWj0zl6+Oe+pTIMSScWuB5D82vgY
 yh565ULI//82FPJo0dlYKKJdFpB8rC+NPfuGkkbaUnAPsScVw0xlDNXVSvkBDDZ0XT/J
 i6TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787228450; x=1787833250;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=CFAD3PPmyEYBnRQoyhozco7Gx3OsZl5eV5ORNG74mm8=;
 b=JgDYz14U+FVOm21mSMWesM7dumFuU90OAVEFl6cNJF20NFHCUlJj5Axdq4sDXyFw0R
 TY7gdjg8GRnYLGFh3t+seswN5JfxikfdH5QGT0InPb8TyoRLXzf/A0ohlukkLXtMOU2z
 +YHsbAqZq+ToTMEBdXu9saWF+xXXxQO9g8fvtHumq232IUBSPS9dDu8WBXLcdGG8MzLi
 8UAkQyTZ5DQaZj2z6zrHPgLluKQgZewuFjjl+W42NzWbur/BgALDMJP2xaKQsgm9Xjyn
 ZeTWrhGBHSct0mitjtLfyXFeXOjfuZ8++381WqdzHjxGhrAOCvJ+b8LvgnP9dznaTRpA
 r5iA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrAGFvezn02y+SwGIBO78DDM5LmGyZoOXxslsnCNGvpn8eoVzWjvwN9tOszwIrtsHb4qGDwpNG4LY8=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kyS0tY4bBlgM0yrjHIOyqYr/AuKXKqZfG4vK+Lg/1iJutjyNA3
 LjrsR8GmbY+LC/rUdIR8gPdRq1SnIJtIPNdrtkiQ1psYHz8ZGvH5L0a2jfUuZ/SSC64=
X-Gm-Gg: AR+sD12bnBy1fB5U8aNnmL3QA1gULwO/Kh/mDcClO663MBjpVGwDCZdcFvcKS1k980y
 f3h6KdTRErl9MtycdnlTEY2dazWvaA/P3vjRXoDoUZjfn64xJgaxhwF05OB4v+veKxLvmirX0mH
 H2UbwQkPJUWrm4ACj3kjVEizauj2gD/uaSOwRNQMXQE2ivMR4ryK+FrsaL3HGnsWPQmeNpUfwfi
 BZm4L0fpLfs9AKVn7M/E02Zdduy/vGsPaeOL7NaSWGLq4A/x8Oe6Qf+1C046AkLvDB8jZ72mUY3
 mI9LeHQNOPWEleUXF98c/fFkfBTKSWDkPWZJyIytuRdEHPzhI1GwRoFkKQBnigt1ZP2+mQyDCrW
 Gw8THlcMCAxnnp/2dlkcCrevO5lsbJfELhzP5KhpXYtthdHyranAEeetrJ+nKuR/48ci1/19fon
 ZIALN6PM27zobhSh+fMcONo/JJ1aK/rvEKicFpf18ZbQjo9hiYZ6Yl9ZaY+ng5g06v5aZ7xRnOm
 i6VxNWrlwWywPSHL2indwIkaG+KzHKCDZYw31lgyPwJAw==
X-Received: by 2002:a05:6214:124a:b0:908:92e3:a37 with SMTP id
 6a1803df08f44-90c5eaf245amr114579506d6.32.1787228450436; 
 Thu, 20 Aug 2026 05:20:50 -0700 (PDT)
Received: from ziepe.ca
 (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net.
 [159.2.239.150]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-90c5f2b1f39sm36591756d6.41.2026.08.20.05.20.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 05:20:49 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
 (envelope-from <jgg@ziepe.ca>) id 1wx1lI-00000003bNC-36dR;
 Thu, 20 Aug 2026 09:20:48 -0300
Date: Thu, 20 Aug 2026 09:20:48 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Steven Price <steven.price@arm.com>
Cc: Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Marc Zyngier <maz@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 Thomas Gleixner <tglx@kernel.org>, "T.J. Mercier" <tjmercier@google.com>,
 Benjamin Gaignard <benjamin.gaignard@collabora.com>,
 Brian Starkey <Brian.Starkey@arm.com>,
 John Stultz <jstultz@google.com>, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: Re: [PATCH 0/2] Clear shared pages after private-to-shared conversion
Message-ID: <20260820122048.GB18100@ziepe.ca>
References: <20260820105026.53208-1-steven.price@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260820105026.53208-1-steven.price@arm.com>
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

On Thu, Aug 20, 2026 at 11:50:23AM +0100, Steven Price wrote:
> Arm CCA includes "Memory Encryption Contexts" (MEC) which allows the
> private and shared data accessible to a guest to have different memory
> encryption keys. Consequently when converting memory to shared, the
> memory encryption key used to access the physical page will change.
> 
> Both the GICv3 ITS driver and the system_cc_shared dma-buf heap
> currently allocate memory with __GFP_ZERO and then decrypt it. With MEC
> the zeroing is done with the wrong encryption key and the data visible
> after decryption may be ciphertext. The RMM is required to scrub the
> data, but may perform this scrub with a different encryption key to the
> eventual key that will be used for shared access.
> 
> Fix these two sites by avoiding the __GFP_ZERO during the allocation and
> performing a clear_pages() call after the decryption.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

This whole set_memory_decrypted() API is awful. It really should be improved.

alloc_pages_decrypted() ?

Jason
