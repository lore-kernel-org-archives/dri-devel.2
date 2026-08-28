Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D859C61DBD
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 16:54:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 07D5B10E048;
	Fri, 28 Aug 2026 16:54:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="CDEY0Oqm";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 013A410E048;
 Fri, 28 Aug 2026 16:54:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A11C543E0F;
 Fri, 28 Aug 2026 16:54:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC4341F000E9;
 Fri, 28 Aug 2026 16:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787936052;
 bh=6VhfdBYTs4Xx0b0sXvbmUVve6vniEmZaIBbjXQn+eeI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=CDEY0OqmYXzVZVlIPFqdfu3ZrZoL9dlXa+GTDMYn/UT6lR9lTRNxtJuACkKBG5fcW
 ogyPXT+AMNQnFI4QoYZTn7NTRTTtMYrMtffVOIiAR1+fNDeGosyG99WoeS5/nfX4hv
 /ae3tZf29SlFkmZ75AGPaPRG89sjB+fnz8y5J/KR5zVtFbBFpho7gfUZXsScjqH2u4
 gB2WEvUsyaevMGTRPjnxVJ74kTmg5QOEvgCq4jM41nIv2736IohWZxq6fmUw9++XuF
 0TWXigB2ma65ZSM4RXi6WYB6geBM+0Uxxinh4rQUduK+snOj0HtRw+XMMOaoRyG5Bl
 zezPkERDVeP2Q==
Date: Fri, 28 Aug 2026 18:54:09 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Krzysztof Karas <krzysztof.karas@intel.com>
Cc: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 Jani Nikula <jani.nikula@linux.intel.com>,
 Andi Shyti <andi.shyti@linux.intel.com>, 
 Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>,
 Sebastian Brzezinka <sebastian.brzezinka@intel.com>, 
 Krzysztof Niemiec <krzysztof.niemiec@intel.com>
Subject: Re: [PATCH v3 1/8] drm/i915/selftest: Fix a typo in alloc_workqueue
 call
Message-ID: <apG9FOeVEBjInq7o@zenone.zhora.eu>
References: <20260828100339.72304-1-krzysztof.karas@intel.com>
 <20260828100339.72304-2-krzysztof.karas@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260828100339.72304-2-krzysztof.karas@intel.com>
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

On Fri, Aug 28, 2026 at 10:03:32AM +0000, Krzysztof Karas wrote:
> The workqueue created by test_ipc() was named "i1915-selftest"
> instead of "i915-selftest". Correct the driver name in the
> workqueue name.
> 
> Signed-off-by: Krzysztof Karas <krzysztof.karas@intel.com>
> Reviewed-by: Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>

just this patch: pushed to drm-intel-gt-next.

Thanks,
Andi
