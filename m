Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 002EECCA462
	for <dri-devel@archiver.kernel.org>; Fri, 16 Oct 2026 03:02:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 32AF810E293;
	Fri, 16 Oct 2026 03:02:30 +0000 (UTC)
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com
 [209.85.216.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3721410E293
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 03:02:24 +0000 (UTC)
Received: by mail-pj1-f54.google.com with SMTP id
 98e67ed59e1d1-3a813079a55so422652a91.0
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 20:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792119744; x=1792724544; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=WGUCMs28DpPSn+ppcL59RwrFtWtuthKTRyw8zNLj4Wg=;
 b=W6Tgvm9/qBG6BUZFpu+Oo1nWyJzyKAYP1CPBjwWDyUS1aCHfmkbbPBMcCtMGwsqK3C
 g9rlvGwS8uA1LuFS8Lv1MP2aS8oc4oiaxMMclEWCvAs5Q86TDnfMG50nHX9zexoQzaWG
 VzoP08vJZCSsCY21T3XXIk8ORUEIOclMLxjr5eOJDg3xlkgl4dH3evv8Fk8VXpF5uCY+
 VCHAwzF6VIAtUff/oMD5B/ozsth/IwYZMyYurRUcbhk3CrniZLWTp0sP6wO/sNMGccqi
 DI3l3mDVlxvhYqKR8WoiZQB+AAoF2Ss6pn1OScIl4j04L+Qck6uc7VjJ8kEqyMsxN54l
 enfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792119744; x=1792724544;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=WGUCMs28DpPSn+ppcL59RwrFtWtuthKTRyw8zNLj4Wg=;
 b=QbHAR9i4b+bxvprj/ogGyY36muOx9jPUI0SgRkznPg6ze2X57ys23LEouivFqLg0Pp
 h3d1pVuzEH9Bu/wKf0Jkw1juvBVsGnccaZrq3ZNAYKwCgC3CpQGAqVZ8SKDdo5S2tzYx
 Iz8qCftvpbe7Hk6K/NJ1PTMejPFbw7cLtEImKQN+XCBgmrZiL1WWTnGv2P9ONa2IZn1n
 SPPP+SgN+MZJIJm6wH6T7n/SMY6h3roa++N//PFRUIBsEwmG4ss8bp7M4wSxSri+0DBp
 Zz+1LueeD5QKY0qHnwnkTX8m4thaa7y/Om+qGgVFWvUMW3lT0e+VNMlKNl6MXex7EyEb
 kWlw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwzQMvcbub6asyyVEL/T1H8fJfwt0eQdPD1xnjePWET/dGLxAl0ejick6MPOBMPQ53MMiZeTiFnJIE=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIENHG3eo6r/9C1mi5+wwXT94LqNmdpmLmI5VDfbSx75V1zIPu+
 PTqLg9vPy4xk5Ou2W/2phUrt6E9mfw72fhqPsSQlpZk7j+SqlgFE6J3y
X-Gm-Gg: AYBFou1K8KM4t5ArduT/jSouuzQ7n7PlBAme8PWTSN+E6vmzNVO+sy6MKAui+zIG1Ew
 OZyIYi+rFZIVM0VGAM0ndqPlh9EE50VaP22aMBDFOE4R8bwGA+sObVwdtGmMcjpnb7g/qSMLRep
 TF3/q3juKbgkx7R3XBlbaRXdKAh6Q17MCyxcRK8Sf6wWqbWooLtcyWKwuu00u/gTDjb97Y7YDbF
 CyUI5VyTWqOQfeNkuY5Sguz44YPW22yzCK/4WpsDmQkx6AZBP8wtKyve+ivb5VK9P0vcKzeMlSh
 4Omi+urjF0FZNFxkuAfz2L2Th6Z2fMIoBJcQHYYqD/lKTtBpM98bhvHgSF0KwCfJM7QOyjVQe/d
 9SMWcobIG+wGgWZL0wXVAKi40btMx/+TKbNXYrfIuc0DYZhSMFQOcJQCdqFe83o0crrF1jiB/EJ
 /wYO46iQszN1DYhi+CBCkJP4tXxBLT8W+9wUn/Xb7B2FVwTKaJqhZ0wvO8huFRadIKDCqJB5GN4
 OzNAjKfteMLd0xnj4bLOXr4NK+fxIrWfrGQC2SXgLWH
X-Received: by 2002:a17:90b:4e8f:b0:3ac:9ad9:6afe with SMTP id
 98e67ed59e1d1-3acbb8d5b8amr1095002a91.39.1792119743425; 
 Thu, 15 Oct 2026 20:02:23 -0700 (PDT)
Received: from localhost (softbank126159121187.bbtec.net. [126.159.121.187])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3acc43a1e1esm1937126a91.1.2026.10.15.20.02.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 20:02:22 -0700 (PDT)
Date: Fri, 16 Oct 2026 12:02:20 +0900
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
Message-ID: <atGTvA2zocXGWmbp@dell-wzy>
References: <20261004212403.208681-1-oss.patchbox@gmail.com>
 <asm4DV84UitLCbve@dell-wzy>
 <CAGG=RgApzG=MeZ9xbpeBzqE0i0Q6RCPXtnyS-30JfEDPDKNN0Q@mail.gmail.com>
 <as4fKufR2O21NWk5@dell-wzy>
 <CAGG=RgDVsPHjLMTEgoqjh17hfnBUg3WUeca93VrDS7NTshHsOg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGG=RgDVsPHjLMTEgoqjh17hfnBUg3WUeca93VrDS7NTshHsOg@mail.gmail.com>
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

On Wed, Oct 14, 2026 at 03:25:33PM -0400, Yuho Choi wrote:
> On Tue, 13 Oct 2026 at 08:08, Zhenyu Wang <zhenyuw.linux@gmail.com> wrote:
> >
> > > You know this code much better than I do, and I can't test it without
> > > GVT-g hardware, so I may well be missing something.
> >
> > I can understand that but I think for any non-trivial change or
> > for sensitive part, testing is a must...
> 
> Understood. I'll hold this patch until I can test it on GVT-g hardware.
> 
> > > The case I had in mind is the guest mapping the same page at both sizes
> > > and keeping both, e.g. 2M in the PPGTT of one context and 4K in the GGTT
> > > or in another context's PPGTT. If the second request replaces the entry,
> > > the first shadow entry seems to keep the old DMA address, as
> > > shadow_ppgtt_mm() reuses a PPGTT that is already shadowed. Is that ruled
> > > out somewhere? Please let me know if so.
> >
> > Shadow ppgtt is created by a PV interface, so each context would have
> > separate shadow ppgtt or shadow mm. GVT handles guest page's dma
> > mapping per-vgpu as for per-VM. But GVT handles context submission in
> > order, shadow ppgtt is populated for each submission. I think even in
> > your example that possible one page mapped in different context as 4K
> > or 2M, it would be remapped as size doesn't match for each submission,
> > so no invalide dma address access.
> >
> > I doubt if i915 could possibly have such case in reality..
> 
> It does seem to happen: 7366aeb77cd8 was written after the same gfn was
> requested at both 4K and 2M during an OpenCL conformance test.

ok..so that was actually a fix to remap guest page when populate
shadow ppgtt, it's a little hacky but as for gvt procedure, it works.
Your change might also work but have a penalty to an extra 2M split
with extra dma mapping effort..
