Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EBECC79FBB
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 21:26:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 07DF510F29F;
	Wed,  9 Sep 2026 21:26:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Cu/guhI+";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 910D610E213;
 Wed,  9 Sep 2026 21:25:58 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4139243687;
 Wed,  9 Sep 2026 21:25:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C53D1F000FF;
 Wed,  9 Sep 2026 21:25:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788989158;
 bh=HCnPKH2O3gJXCkNBm/0Ajq3OVemzYB1kaQ0a/Ac5AT4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=Cu/guhI+pDNGSUg7aOM71xpf4OPdgKz0npXWoat31tZSlBUWuSApepTcOgyxbqqay
 EthztU5d8brJ5r5wKXWa5Qp4uGQP1i6C2omltd72mZdNh63pDSHPC0jHo933gmhqza
 Csv8Cc9hAcjvaQTp3NuugcHS8Mo/w/n0J/UDf50uUpMZQWeE1k66kDKOvjsiJoe5XM
 Ob1aHU8gxa4LsfbuR0GlgKPGi3q7up5uT8zgg3sBLakk6oxEAy/+w73zWIj8T7KPVn
 VmdZVhR762DmDEjvQWOhYXyyw89EEouaSrf6CEVVbsXIyGdNp3ZNmSG9sF6LpPBkmL
 hKddK/JsUoMZg==
Date: Wed, 9 Sep 2026 23:25:55 +0200
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
Message-ID: <aqHOZatceKX5Gljr@zenone.zhora.eu>
References: <20260828100339.72304-1-krzysztof.karas@intel.com>
 <20260828100339.72304-5-krzysztof.karas@intel.com>
 <apGwueLe3rE7gPLj@zenone.zhora.eu>
 <dnxu2clblnzurzncqpvwztmcmgs6vygq2yd5w6zldcnjhtvtsc@shzi3wcxynvw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dnxu2clblnzurzncqpvwztmcmgs6vygq2yd5w6zldcnjhtvtsc@shzi3wcxynvw>
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

On Thu, Sep 03, 2026 at 12:39:10PM +0000, Krzysztof Karas wrote:
> Hi Andi,
> 
> On 2026-08-28 at 18:18:35 +0200, Andi Shyti wrote:
> > Hi Krzysztof,
> > 
> > On Fri, Aug 28, 2026 at 10:03:35AM +0000, Krzysztof Karas wrote:
> > > Move away from generic pr prints to device context aware drm
> > > versions.
> > > 
> > > Assisted-by: GitHub-Copilot:claude-opus-5
> > 
> > what a ride!
> > 
> > While reviewing everything I was thinking whether it would make
> > sense to add an i915_err() like xe and gt.
> The idea makes sense, the question is when to introduce this
> macro. I have the v4 pretty much ready to send, apart from a few
> minor issues I have to fix, but I am not against modifying it to
> accomodate i915_* family of prints.
> If we agreed on this, then we'd have this new macro ready when
> we'd be replacing pr_* prints in other parts of the driver.
> 
> I think it would be worth to keep the series in the oven for a
> few more days, especially when it is not that critical of a
> change. What do you think?

yes, i915_* can come later, of course, it's out of the scope of
this series.

Andi
