Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95A9CCC6B03
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 12:08:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E911210E7D9;
	Tue, 13 Oct 2026 12:08:19 +0000 (UTC)
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com
 [209.85.216.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 66F8410F7C5
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 12:08:13 +0000 (UTC)
Received: by mail-pj1-f54.google.com with SMTP id
 98e67ed59e1d1-3a7cfe8f761so2925045a91.1
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 05:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791893293; x=1792498093; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=SL2wq6QLb6u6b9Wwd0Sv7tNMSJxrgLs/vOJ5VBrZl6o=;
 b=nPeDezwxt2qTRW3OVrobNSRYMf1pKtQ+bgz1JFnUZjNx1tjI9Htehh1sU+Ko+3OaI9
 e3WRghgAN9QGXO9MgRLQ4HsfaJsOZu0y0CoYGeSngE0YnU0MvNQbhOltaU42cX10E20f
 6zqhKHMM7AlxJLuPAfW682Ame6tLxCLocI6yMuvE2HD2BLX9rrZ3XpyuCrtFa5X6B2ca
 cPIQ10Lzrr+8Lli7sSWR5jk7CNnD/cso+HMnJTSzDmFAzfv/+NjUMd0sUVt5ecaDh9Qv
 KlsIhpzTXxj6aE4lQqslNWwrOuKIYE+62X6QX2uXI79tnwpOJ69AYwf5FbSDnLWJ6+nO
 Exhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791893293; x=1792498093;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=SL2wq6QLb6u6b9Wwd0Sv7tNMSJxrgLs/vOJ5VBrZl6o=;
 b=Ytw2vwKgJoVwxyuwLSX6SRdhcSxzmaAa5v06bZjHtRMFTfADkUDctCKC9P0fnG0Av+
 y3NluRzQauA4BpJx4d/WjcvPd4W84KmO9HVZ9Bebfil+6dz8WtYdda+iwGC+eiwqQw2Q
 6u6gZmrnDpjdlfwhSYusEtkE8N5A1Ko22f9S4zSbtOrfHS159zskAj4kqiWB2e2gzrDR
 qXCGmSWjtO2ZutsF1a9ZlD5xPJYt1Svf/SEY4sDLegENRmxm/UCcYrG6P/zr+rNiKwU9
 GPfVNWl0DJDv5Foe835RZrdoEhVYbr4x3luZizmvlmlzcM1N7LXG4N8ZVdmp5RWH/i3h
 T/wQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByR31M+KuTstz7pC+rtTatLTryzxuqsR27O5r1Z38kniGfYt8+yrGB6rZBLGQ3IMZizlpvQl4eACt0=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJi8R5192EAp8IJ30kP5dLgPff3jylVrf1bQZdzaw7aWILRCU77
 nkAbb2GxdwRxS8ufN7DjDxYcY36cXPTSrbV3Zsshcst5YrSmRTGfUqJF
X-Gm-Gg: AYBFou1JTHCd7hnNB58s5Xojpq+gKvS6rBr+mJBIhKAKqq85FdYVL+QrxLrnKyf+L8d
 +VUZTALpMD4LBetaobEU8fV1IcSBFQhHrcBWru35hUD+Hndb59i2o2i0Jyojd2u2DTmzS0snjDL
 BCt0Slp6/cqaTpoiwhExQTPiywb9ySRDYY8dQ256EhQjabc4ORmVpXGEiP/xV0lYElhSTfBP4GR
 TgCO04au7AlY8cnthYbd+DTLOuq31ASx+5CzaK7Lg8uPWaFLGvLi9a7wVXoemP60rx4IjQfagdq
 9vtTqogZFqV1YdwcxNUKtVYSUMEU+PTIanuz78bdMs5VS268SfyH/GPiyAp6+a1+Ln9mBLtyV/u
 VpLxaY6j5ZPcbgxP8GuJzPzl9Z4udPpgrOTHt7sgvqic2Oa2/k0KHiCqXZVRJ8JGHz253ep3xJ6
 6iFAh/f77VyXgMQKQpigNFL4k0ZubT1xHxeIIK50jgf6eimh5+oBudz9TUphVDmXXkFbMUrGBYf
 +PIfGHcxHPnycN26mw7jMt3FszyE1Jdhg==
X-Received: by 2002:a17:90b:384b:b0:3a0:295e:6e61 with SMTP id
 98e67ed59e1d1-3ab3a953717mr6170484a91.12.1791893292679; 
 Tue, 13 Oct 2026 05:08:12 -0700 (PDT)
Received: from localhost (softbank126159121187.bbtec.net. [126.159.121.187])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ab37817414sm21827776a91.2.2026.10.13.05.08.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 05:08:12 -0700 (PDT)
Date: Tue, 13 Oct 2026 21:08:10 +0900
From: Zhenyu Wang <zhenyuw.linux@gmail.com>
To: Yuho Choi <oss.patchbox@gmail.com>
Cc: Zhi Wang <zhi.wang.linux@gmail.com>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>,
 Xiaolin Zhang <xiaolin.zhang@intel.com>,
 intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, zhiw@nvidia.com
Subject: Re: [PATCH v1] drm/i915/gvt: Don't replace a DMA mapping that is
 still in use
Message-ID: <as4fKufR2O21NWk5@dell-wzy>
References: <20261004212403.208681-1-oss.patchbox@gmail.com>
 <asm4DV84UitLCbve@dell-wzy>
 <CAGG=RgApzG=MeZ9xbpeBzqE0i0Q6RCPXtnyS-30JfEDPDKNN0Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGG=RgApzG=MeZ9xbpeBzqE0i0Q6RCPXtnyS-30JfEDPDKNN0Q@mail.gmail.com>
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

On Mon, Oct 12, 2026 at 12:01:31AM -0400, Yuho Choi wrote:
> Thanks for the review!
> 
> On Fri, 9 Oct 2026 at 23:59, Zhenyu Wang <zhenyuw.linux@gmail.com> wrote:
> >
> > I don't think this is *real*, as code would simply destroy entry in
> > that case, and there won't be on-the-fly dma operation on that, as
> > guest mem setup is totally before execlist submission, if guest driver
> > changed mapping by ignoring gvt emulated execlist status, that's just bad...
> 
> You know this code much better than I do, and I can't test it without
> GVT-g hardware, so I may well be missing something.

I can understand that but I think for any non-trivial change or
for sensitive part, testing is a must...

> 
> The case I had in mind is the guest mapping the same page at both sizes
> and keeping both, e.g. 2M in the PPGTT of one context and 4K in the GGTT
> or in another context's PPGTT. If the second request replaces the entry,
> the first shadow entry seems to keep the old DMA address, as
> shadow_ppgtt_mm() reuses a PPGTT that is already shadowed. Is that ruled
> out somewhere? Please let me know if so.

Shadow ppgtt is created by a PV interface, so each context would have
separate shadow ppgtt or shadow mm. GVT handles guest page's dma
mapping per-vgpu as for per-VM. But GVT handles context submission in
order, shadow ppgtt is populated for each submission. I think even in
your example that possible one page mapped in different context as 4K
or 2M, it would be remapped as size doesn't match for each submission,
so no invalide dma address access.

I doubt if i915 could possibly have such case in reality..

> 
> > So this change would always force 2M to split into 4K? why?
> 
> No, only when a 4K entry for the same gfn is cached at the time of the
> 2M request. With no entry or a 2M entry nothing changes, and a 4K
> request now reuses an existing 2M entry instead of replacing it.
