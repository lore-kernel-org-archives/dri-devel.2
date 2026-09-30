Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89E8BCA5FCB
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 17:10:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 04BEA10E5F7;
	Wed, 30 Sep 2026 17:10:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="m5wiJxag";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 70C8E10E5F7;
 Wed, 30 Sep 2026 17:10:45 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4154D411C9;
 Wed, 30 Sep 2026 17:10:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50B9D1F00898;
 Wed, 30 Sep 2026 17:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790788245;
 bh=cU6PJclq71Jgp1tR8r0LOkFVswLo6WSFupQMh4OLjwo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=m5wiJxagPse0ss7IjQ7cOufShFp0I6jmUPONo2nF6HWDcFsCXMLaJgvTLEe7bP66O
 dZeKVTEc46oJWsbW2im/aDf984OZzKZ2+nugoCpKhgrfLvyHxW7kkJNZqc5jnWT8wp
 kEZ3IP7fMcbeESWVzB7dUxzZmVxX5Mxu/oQC7xy1xYWUVArEP/0zLHW1/MRpjv2xUi
 iHG+ixRZCG68yR4ATLLk2lAuLU6QnYBskbSPFY4VB7kyhjXBLwaZDFVm9XuqSi7w3s
 SN6qDZT2PBCjfZm8vw0D1mwmVcobTluHoXeHbFa2CbvKYuKa3zC0beqEt4yhPEBi3D
 YvSlf14a+xCHA==
Date: Wed, 30 Sep 2026 19:10:41 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Krzysztof Karas <krzysztof.karas@intel.com>
Cc: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 Jani Nikula <jani.nikula@linux.intel.com>,
 Andi Shyti <andi.shyti@linux.intel.com>, 
 Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>,
 Sebastian Brzezinka <sebastian.brzezinka@intel.com>, 
 Krzysztof Niemiec <krzysztof.niemiec@intel.com>
Subject: Re: [PATCH v3 4/8] drm/i915/gt/selftests: Use drm_* prints in
 aggregated gt selftests
Message-ID: <ar1Cc3FDo-2RCsja@zenone.zhora.eu>
References: <20260828100339.72304-1-krzysztof.karas@intel.com>
 <20260828100339.72304-5-krzysztof.karas@intel.com>
 <apGwueLe3rE7gPLj@zenone.zhora.eu>
 <dnxu2clblnzurzncqpvwztmcmgs6vygq2yd5w6zldcnjhtvtsc@shzi3wcxynvw>
 <aqHOZatceKX5Gljr@zenone.zhora.eu>
 <d6n6pdqhf62m33vvawh2b2ayzsratsoae6n6v57kyjbbrvyius@zs3wyc6jszov>
 <arws71LttyyKPINu@zenone.zhora.eu>
 <vhogge4e7tr5qv2zeiocmmainjykmk6llxrxgwmqfzoioect4c@hr7y4usgrgid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <vhogge4e7tr5qv2zeiocmmainjykmk6llxrxgwmqfzoioect4c@hr7y4usgrgid>
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

Hi Krzysztof,

> > > > > > While reviewing everything I was thinking whether it would make
> > > > > > sense to add an i915_err() like xe and gt.
> > > > > The idea makes sense, the question is when to introduce this
> > > > > macro. I have the v4 pretty much ready to send, apart from a few
> > > > > minor issues I have to fix, but I am not against modifying it to
> > > > > accomodate i915_* family of prints.
> > > > > If we agreed on this, then we'd have this new macro ready when
> > > > > we'd be replacing pr_* prints in other parts of the driver.
> > > > > 
> > > > > I think it would be worth to keep the series in the oven for a
> > > > > few more days, especially when it is not that critical of a
> > > > > change. What do you think?
> > > > 
> > > > yes, i915_* can come later, of course, it's out of the scope of
> > > > this series.
> > > > 
> > > > Andi
> > > 
> > > I checked again and again these past two weeks for your reply
> > > and none came into my inbox, only for me to notice today that it
> > > was finally pulled by my mailer client recently. I posted
> > > another version of this series, because I was under the
> > > impression that silence meant I should introduce the i915_*
> > > prints. That version was met with disapproval from Jani as well,
> > > so please just ignore v4.
> > > Sorry for the spam.
> > 
> > it's also true that I haven't been very active in reviews lately.
> > 
> > Are you now preparing a v5?
> Truth be told, I prepared two versions simultaneously while
> waiting for reviews on v3: one with and one without i915_*
> prints, both addressing earlier reviews. I updated the local
> version without i915_*, so it is pretty much ready to send, just
> need to run final checks.

cool! I'll wait for the v5, then :-)

Andi
