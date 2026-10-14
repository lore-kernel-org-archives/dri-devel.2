Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79426CC6B3A
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 07:57:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3250E112192;
	Thu, 15 Oct 2026 07:57:19 +0000 (UTC)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com
 [209.85.208.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8349210EABD
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 19:25:47 +0000 (UTC)
Received: by mail-lj1-f174.google.com with SMTP id
 38308e7fff4ca-3a777d4f321so38869781fa.0
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 12:25:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792005945; cv=none;
 d=google.com; s=arc-20260327;
 b=R0a05L+HgFEwwBa12xdp+X6a6lqyMLdjn9vs5XLWYMEUZkpOl54D5abBr6lr8I3lsl
 f1b5fLD/BOg6Sv3Yblv5fdxrVJjXxac2kEpxbBt2lsAficQIyLXxtJA2JAC9cz6sZyXF
 RcdahRbB751neeSEpibj2bYhxM2Khhj3eIHDb5q2mgC6EH7ZWJ9FPZYvRX2l7vXuOTMO
 qX8Js5oWi6EvVUQ5kzn7Rvsvubonuv64LbsC11ZToBSu3A5PNk5QxTnn52raCZfxGXuD
 5yTu6W9aKsW7LXYE+GDfNwxdTbwN35oBd2aIghLzYlpMUR3PaySQIKJ6HwBwDwTzRbuq
 XbnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=582l4UN9d8ZpIIQBKyvfoe2ud1OuHObN9VtOBwz13Bg=;
 fh=npddJpSPRUKKA48kYlldySnhtDIJKkWR7iiEZ1ehQqE=;
 b=L/1D9x4OPI9SOJb7CygfErZiIYF1V9NYw0rcIp88YDwoRWjcAFBtyZo6IJR0PucoWL
 Ovy3/N8heKIloNfrPDcSYB38ct9/qRC6FWTo8vjUx+ZZm/f0u1GEIOpyJE2TJPsfAD3Z
 DzpztT5A0MW517/7mXmDmp24o0sI6qudeqCmyeHXvuSmLW5xEVktfu5EDkXrRPkoZea6
 tPRhzKTzTIA5eXIXWS6QVMJzSfsYiAj+oT95qU9UmI01IXxOFGpqAMcYEwEYIPk/MsMz
 jom2XZyoswfCPBmQYSvRDHBxtUnk+kM5Q/vVAZkky4qmZOzdJqC6behBVVkwAn7bd52h
 YrRQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792005945; x=1792610745; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=582l4UN9d8ZpIIQBKyvfoe2ud1OuHObN9VtOBwz13Bg=;
 b=rdhIPjal3xwf5B/fHe2FJrDB0SOqRCRRMc5x8T/yHgYm6BTikN0bMlOKP/i2RJ+tao
 owsDpw9E7mx3hjheFVVjIF9r22BRTCtr9Pb0qKrvZp7dum/Iu22aR8G3VPhQFf+BvEDK
 MxCuku7JFrXPb71umQk77M4wewsiSgNUhPj3qMAFCKTFz46EmGIwetcfICWkcHoQgHGi
 IMDqtWf/UGi7gXhNpqASxyDLMR08+F00DhJAtDAofsTQbrdQvHlHzFq9MLZCczsA7cgc
 gNrR2QBqwlEdCDHc2cZrtlKt5WEXHaSraUpf+IIqXRl9mwJzRpkbiCrtafze3h1nltmr
 Hvbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792005945; x=1792610745;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=582l4UN9d8ZpIIQBKyvfoe2ud1OuHObN9VtOBwz13Bg=;
 b=ILQJ+oT6S3XMNUk8HFAl4Q8eYpVwJrtSCF0r1yxv/+vjYU/dcNef5qIuF0teBmcjbN
 sdZheX4IvhRBg/XTHqeni5wYupt6rDXOcQUfjxtPKgu5lsAKQqN0Hu+/62GzUTVo08an
 5M0sSfvynrg+OqlUvWezXMhdIBTLE/2+cMhr0IJPp6QsDvegS9PBVt1gfFlbyk8f1hZ+
 oDhnodANybpGtkhDVD2y16jwuoVZVWhYci3hKhyxOx1hqd4TCIjkzvLXmRlGjjlWg/Ic
 HPmeG3KDKP1qNb4Ey0nE04mOvIvBtdxq5cjCyzpMcR4ZdRTJQMY3zW0Y22pH0uC/CI46
 Z8/A==
X-Forwarded-Encrypted: i=1;
 AKwUvByxR7mK9e+k84Ef6ZvNx9rhApjTytkV9VkTmVXo52y3HgTmafS2bP9gZvLYTN+qILjsSCBzuoD+ILo=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIcbUmmvjnDmDUF0tWglox0J9/aT26+x8AQDsN2NryEPKO2r7NM
 CLMrBr81g3kkb22WGtkLKU0bjOq764nq9NX7I/3dA34WTY85xG2JiYC6bTm04nH9EutxE+HtYuG
 ZBHHwjXHf33G//lqlZlJrTFylSPoAzZk=
X-Gm-Gg: AYBFou26slcLF68yxa5scEJ9COHH3u/xAIDVDfl2jcbdk3Ga5NUhvun0zs4vZmOp83b
 s5oGsHbLuLmZZtcl1uPp+H8BWtsv+wXT40jaZrxSkKGX2ZNChcu9FsUgXUjUac4RRFecLvIEBEx
 5/sGJX0pT6+ZHNsqt+59IgDK9PuRxBtEXVNn8P87PI5MfXApIkM7baXeoyPnDV/22mKfg94qt/3
 vTMvOf1t48dIWTdBVueDvXj2lxWOFSkfHhIS50Cqmu1lFemZHALDF6c++LN4oXcDACDv6I0hpsV
 I33CojWWlHa/py8wMF90tGavufDcTJ+oX9mrThjvAPoHKvoP73WO3KuM
X-Received: by 2002:a05:651c:b28:b0:3a9:9b0b:e0e9 with SMTP id
 38308e7fff4ca-3a9c539ad00mr43922551fa.6.1792005945250; Wed, 14 Oct 2026
 12:25:45 -0700 (PDT)
MIME-Version: 1.0
References: <20261004212403.208681-1-oss.patchbox@gmail.com>
 <asm4DV84UitLCbve@dell-wzy>
 <CAGG=RgApzG=MeZ9xbpeBzqE0i0Q6RCPXtnyS-30JfEDPDKNN0Q@mail.gmail.com>
 <as4fKufR2O21NWk5@dell-wzy>
In-Reply-To: <as4fKufR2O21NWk5@dell-wzy>
From: Yuho Choi <oss.patchbox@gmail.com>
Date: Wed, 14 Oct 2026 15:25:33 -0400
X-Gm-Features: AclHuK8bWEAIT_jes9eLRLNmTdyx38C_iJwbW3y3L5STgV7Y6fOZaRlXyp6RKPU
Message-ID: <CAGG=RgDVsPHjLMTEgoqjh17hfnBUg3WUeca93VrDS7NTshHsOg@mail.gmail.com>
Subject: Re: [PATCH v1] drm/i915/gvt: Don't replace a DMA mapping that is
 still in use
To: Zhenyu Wang <zhenyuw.linux@gmail.com>
Cc: Zhi Wang <zhi.wang.linux@gmail.com>,
 Jani Nikula <jani.nikula@linux.intel.com>, 
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 Tvrtko Ursulin <tursulin@ursulin.net>, Xiaolin Zhang <xiaolin.zhang@intel.com>,
 intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, zhiw@nvidia.com
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Thu, 15 Oct 2026 07:56:36 +0000
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

On Tue, 13 Oct 2026 at 08:08, Zhenyu Wang <zhenyuw.linux@gmail.com> wrote:
>
> > You know this code much better than I do, and I can't test it without
> > GVT-g hardware, so I may well be missing something.
>
> I can understand that but I think for any non-trivial change or
> for sensitive part, testing is a must...

Understood. I'll hold this patch until I can test it on GVT-g hardware.

> > The case I had in mind is the guest mapping the same page at both sizes
> > and keeping both, e.g. 2M in the PPGTT of one context and 4K in the GGTT
> > or in another context's PPGTT. If the second request replaces the entry,
> > the first shadow entry seems to keep the old DMA address, as
> > shadow_ppgtt_mm() reuses a PPGTT that is already shadowed. Is that ruled
> > out somewhere? Please let me know if so.
>
> Shadow ppgtt is created by a PV interface, so each context would have
> separate shadow ppgtt or shadow mm. GVT handles guest page's dma
> mapping per-vgpu as for per-VM. But GVT handles context submission in
> order, shadow ppgtt is populated for each submission. I think even in
> your example that possible one page mapped in different context as 4K
> or 2M, it would be remapped as size doesn't match for each submission,
> so no invalide dma address access.
>
> I doubt if i915 could possibly have such case in reality..

It does seem to happen: 7366aeb77cd8 was written after the same gfn was
requested at both 4K and 2M during an OpenCL conformance test.
