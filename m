Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CC40C79FA1
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 22:44:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 410DF10EDD8;
	Tue,  8 Sep 2026 22:44:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="QAh3jSaG";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B288810EDD8
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 22:44:15 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A46DF60213;
 Tue,  8 Sep 2026 22:44:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 318A01F00A3A;
 Tue,  8 Sep 2026 22:44:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788907454;
 bh=1ZnYa73NqlHvx0NBeklkPLHckc4CqlArTF1KYVVsrjI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=QAh3jSaGlsGc3Fayn5XHnyXj4mBXkPfEEtBja09rGhxffJ28vDMcMuS4JLz5xE0di
 yPWz64mObi0YhHANOZ0uZGGmyNYvnLv/YG4QiXX0h8IRkaktrgSZiK+pACQt4/rSHR
 OqIjN7Ij5ZYkA2VLYTd/wkpqKt2pt+MVJjrrOrJbLaVvMK3RRQhtS13Yc+fpvN7stJ
 4oWbgpvB3lfi7YbjpsX0TbgdMRkiUomrr07LJgsP2Knx6PCXMHSMswat18fbg6/o+h
 SCSmpTcc9BkN8QVIbZqxthpFyBqMT+elACJHuS3a6XSuO+9S+361SMrCH3FNRuqH3Q
 PDrH30/JDB/aQ==
Date: Tue, 8 Sep 2026 17:44:10 -0500
From: Bjorn Andersson <andersson@kernel.org>
To: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
Cc: rob.clark@oss.qualcomm.com, Krzysztof Kozlowski <krzk@kernel.org>, 
 Oded Gabbay <ogabbay@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Sumit Semwal <sumit.semwal@linaro.org>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>, 
 Bharath Kumar <quic_bkumar@quicinc.com>,
 Chenna Kesava Raju <quic_chennak@quicinc.com>, 
 srinivas.kandagatla@oss.qualcomm.com, dmitry.baryshkov@oss.qualcomm.com,
 linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, 
 llvm@lists.linux.dev, iommu@lists.linux.dev, linux-media@vger.kernel.org, 
 linaro-mm-sig@lists.linaro.org, Anandu Krishnan E <anandu.e@oss.qualcomm.com>
Subject: Re: [PATCH v2 00/15] accel/qda: Qualcomm DSP Accelerator driver
Message-ID: <aqCKgM1yCbWjFdgO@baldur>
References: <CACSVV01eYr6FyA6XBG0xw0yv2dydvTEhcY-WUy07mxM8WwkZcg@mail.gmail.com>
 <318f14c2-0e87-4e07-8173-1511dca67d78@kernel.org>
 <CACSVV01T=ytVJKM7NRoBTAJm7vH+JPJNT9Tftu5X9YskGXerwg@mail.gmail.com>
 <e7b4eceb-cb3a-49ea-bed9-728c958594b0@kernel.org>
 <CACSVV03ypjBYkhRpt=TyDwOKhejKKke3x=Fi_TvxXN-5U_rCsw@mail.gmail.com>
 <fb834ae5-7113-4a86-bb84-ca5115c8d7ff@kernel.org>
 <CACSVV018jB4WRRJ_CUHQmkHXZcqauWJXWGgrzY_HA6cFQ+Q3Xw@mail.gmail.com>
 <dd3da35b-1db6-43a4-ae1f-35620692f51f@kernel.org>
 <CACSVV01o_XYuSzaYGbo9pY=459qiA_fgL_KRHVJH+LH4RYcMzQ@mail.gmail.com>
 <23e31249-cce2-421e-88f7-1a2af66e34b6@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <23e31249-cce2-421e-88f7-1a2af66e34b6@oss.qualcomm.com>
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

On Wed, Aug 26, 2026 at 06:37:00PM +0530, Ekansh Gupta wrote:
> On 20-08-2026 20:17, Rob Clark wrote:
> > On Wed, Aug 19, 2026 at 11:15 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> >>
> >> On 19/08/2026 17:48, Rob Clark wrote:
> >>> On Wed, Aug 19, 2026 at 8:27 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> >>>> The rule of usptream development is that we do not accept duplicated
> >>>> code, just because a vendor wants to write something new. This is
> >>>> basically the concept applied all over the drivers tree, where we pushed
> >>>> back against all sorts of duplications all over the vendors.
> >>>>
> >>>> What I miss in this thread is why would there be any exception here. We
> >>>> do not grant exceptions from standard practices on "I want" reasons.
> >>>
> >>> I agree that we should not have duplicated drivers just for vendor
> >>> lolz.  But when it comes to adopting common frameworks and integrating
> >>> better into the ecosystem, this doesn't seem like something we should
> >>> actively discourage.  I don't think this is a case of vendor lolz, but
> >>
> >> No one discourages it. Following standard Linux kernel practices and
> >> requirements is not discouraging, do not twist the narrative here.
> >> Again, it is standard upstream review telling that we do not duplicate
> >> drivers. Ever, unless there is serious exception needed.
> > 
> > I wasn't trying to twist the narrative, just trying to come up with a
> > path forward that isn't "no" or "improve existing driver", since
> > neither of those gets us towards a future using common frameworks.
> > 
> >> I asked why there should be an exception granted? Is the reason for
> >> exception following:
> >> "We want to adopt common framework"
> >> ?
> > 
> > Possibly?  But I don't think we want two drivers to be any sort of
> > long term solution.  (Ie. as long as venus/iris have co-exist.)
> > 
> >>
> >>> rather reacting to drm/accel emerging as the standard framework for
> >>> this sort of driver.
> >>>
> >>> So how do we get from here to there?
> >>
> >> What is wrong with my proposal?
> > 
> > Maybe I missed something, my understanding was your proposal was
> > "Grow/replace/improve existing driver instead of coming with a
> > duplicate"..  grow or improve doesn't move us toward common
> > frameworks.  Maybe "replace" is a valid option.  If there is something
> > I missed, then I apologize.
> > 
> > Options I can think of are:
> > 
> > 1. Hardware cutoff.. new hw gets new driver, existing hw gets existing
> >    driver
> > 2. Backwards compat chardev registered by new driver, providing existing
> >    UABI.  I'm not 100% sure about the feasibility/drawbacks of this..
> >    AFAIU the fastrpc folks where planning a backwards compat layer in
> >    userspace, so maybe it is possible.
> > 3. exception?
> > 
> > I'd like to know what the feasibility of #2 is, since at a high level
> > that sounds like the best option.  Possibly limit exposure of legacy
> > UABI to existing hw so we don't get into a place of needing to extend
> > the legacy UABI for new hw?
> > 
> > But #1 sounds like a non-controversial place to start regardless.
> > Possibly with #2 coming as followup and necessary step before eventual
> > migration to new driver for existing hw?
> > 
> > Even if we start with #2, how do we handle first-merge-window
> > bugs/regressions without reverting addition of new driver and removal
> > of old?  It seems like we'd need a window of a couple release cycles
> > where both drivers exist?
> > 
> > Maybe others have other/better options in mind?
> To all, I'm seeking on the approach I should follow to go ahead here. I
> can work on implementing #1(as per Rob's list) with hw specific
> compatible for v4 if it's acceptable.
> 

I don't see any reason for you to define a "hw specific compatible",
because as you have shown in this series (and as Rob point out), there's
no difference in the "hardware".

The only reason for your "hw specific compatible" is to make a software
selection in Linux - and that's not what DeviceTree is for.


As such, I don't see that you have a DeviceTree problem at all, because
this is a Linux-internal problem.

> #2(compat driver) is something that we are still exploring as we
> couldn't find any standard way to achieve it. We might start a separate
> discussion for that once we have few possible designs with us.
> 

This is the actual problem!

We have existing user space that depends on the ioctl interface exposed
by the current misc driver. You must not break these.

Hardware cutoff is not a viable solution, because that's just a
declaration that we'll let the old platforms rotten - or alternatively
you commit to maintain two drivers to the very same feature and quality
level.

So the only reasonable solution is #2; from there it's a valid question
if you reach that point my stepwise migrating the current misc driver
that solution, or if you present a new driver with the fully backwards
compatible interface, alongside the new ABI.


But this does bring to a question which the cover letter should explain
- but doesn't: what problem does this patch series actually solve?

Regards,
Bjorn

> Happy to take any other suggestion also.>
> > BR,
> > -R
> 
> 
