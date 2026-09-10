Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1227C88E41
	for <dri-devel@archiver.kernel.org>; Thu, 10 Sep 2026 21:07:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 15E2810E3C0;
	Thu, 10 Sep 2026 21:07:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="WwPMq8/E";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 78C6910E39F;
 Thu, 10 Sep 2026 21:07:52 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 23C3841911;
 Thu, 10 Sep 2026 21:07:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 270D41F000FF;
 Thu, 10 Sep 2026 21:07:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789074472;
 bh=978hplHl+/cghS7QEZxpSQOUxYdhZSALQBlDT1eFv8g=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=WwPMq8/EbPqQCPQ2Dj6VPI1vQq6Fzkt489VAQi+GXonZ7KOi+D+u+G0cmYjQYXr3Y
 rFId3tmJDVgLmDc4kTfieNqLbGm/n+rQ1+jOj6hFMcEfB3X87LFYTSIZVlyBtImTbG
 L5bd3C0rH4rGC4ivMLoQ1p6OwrAIagjP++CsBNssqO39J6AbSk00p3r5KO/zFYhJOR
 ciZ2fuyN0++s63KtpXl5NyuPOmQn3YBPDAfm2MPbmbB7JbP7t9d+mTj/FBCyXTphjA
 BYqwqDc8xnIs4COar//xB6JOQy1qpWe2QJp5CTSd/QEWCsf6P+U5xtjV0B8buISvXh
 BH4gZ6kOIuBqQ==
Date: Thu, 10 Sep 2026 23:07:48 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
Cc: intel-gfx@lists.freedesktop.org, 
 Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Tvrtko Ursulin <tursulin@ursulin.net>, 
 Andi Shyti <andi.shyti@linux.intel.com>,
 Krzysztof Karas <krzysztof.karas@intel.com>, 
 Sebastian Brzezinka <sebastian.brzezinka@intel.com>,
 Krzysztof Niemiec <krzysztof.niemiec@intel.com>, 
 dri-devel@lists.freedesktop.org, igt-dev@lists.freedesktop.org
Subject: Re: [PATCH] drm/i915/selftests: Wait longer for request to start
Message-ID: <aqMb92YXA1jaYB8s@zenone.zhora.eu>
References: <20260831093510.3496388-2-janusz.krzysztofik@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260831093510.3496388-2-janusz.krzysztofik@linux.intel.com>
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

Hi Janusz,

On Mon, Aug 31, 2026 at 11:33:08AM +0200, Janusz Krzysztofik wrote:
> CI extreamly sporadically (five times over last six mohths) reported
> failures of igt@i915_selftest@live@hangcheck on ARL-S machines.  The
> selftest was timing out while waiting up to 1 second for a request
> supposed to trigger a GPU hang to be started.  It occurred possible to
> reproduce this issue manually by running the selftest in a loop for a
> few hours.
> 
> Among results from 5 occurrences reported by CI so far, and two manual
> reproductions, two of them contained messages that suggested a
> posssibility of the awaited request to actually start soon after
> timeout.  With the timeout extended from 1 to 2 seconds, it occurred no
> longer possible to trigger the failure, even when running the test in a
> loop for 10, then for 12 hours, on the same machine where it was failing
> before in 2-3 hours.
> 
> Assume the conditions that prevented the hang requests to start within 1
> second were always transient, and 2 seconds is sufficient for those
> requests to start effectively on machines in the CI environment.  Fix
> the issue by using that value as the timeout.
> 
> Closes: https://gitlab.freedesktop.org/drm/i915/kernel/-/work_items/16624
> Signed-off-by: Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>

reviewed and pushed to drm-intel-gt-next.

Thanks,
Andi
