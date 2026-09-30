Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DABFDCA5FC5
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 10:05:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3BFBF10E5C3;
	Wed, 30 Sep 2026 10:05:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="eplUNUE2";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ABF5210E3F8;
 Wed, 30 Sep 2026 10:05:47 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 508A342B7C;
 Wed, 30 Sep 2026 10:05:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EBBF1F00898;
 Wed, 30 Sep 2026 10:05:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790762747;
 bh=y5Lpd04r3tgXtpe7CHXoHU6OHLclByMFGFrC/wpfOfU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=eplUNUE2xCdVDqrPusUC6ZkjyuTysSnPBoRDXqpcVH8xvZ/idXusAwdyAAZzUqqf6
 CpenX89H6BAt6oBz4UkrSLjksytTzcVS1ZcU0qz7HPp9+9GCIvb/9+iICIrHILQJr4
 8CNWHH7asgaB/jb+2zf+EQ88EpmulBcGFdD+x3N1A3PJkSaQz6QIyUSxPP0CmiHmdC
 p90cPsLJ6ylULXIr4l6yWkAgUJq1bU3rQfdTyaAT5iYhUaMEJVN7VWJL9lpJCysODR
 wbJipOfxQCJkekUr7SfUeglKf3KAIcwg7xw60vZ+udlQy2O/NlQuc/SIR0X7xlI8R/
 KfdhpMdMqvr1Q==
Date: Wed, 30 Sep 2026 12:05:42 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Krzysztof Karas <krzysztof.karas@intel.com>
Cc: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 Andi Shyti <andi.shyti@linux.intel.com>,
 Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>, 
 Sebastian Brzezinka <sebastian.brzezinka@intel.com>,
 Krzysztof Niemiec <krzysztof.niemiec@intel.com>
Subject: Re: [PATCH] drm/i915/gt: Unmask interrupts only when ACTIVE is true
Message-ID: <arzes94mwQ6t61n2@zenone.zhora.eu>
References: <20260910081329.3300417-1-krzysztof.karas@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260910081329.3300417-1-krzysztof.karas@intel.com>
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

On Thu, Sep 10, 2026 at 08:13:29AM +0000, Krzysztof Karas wrote:
> There is a small race window between intel_rps_boost() reading
> a stale ACTIVE state and queuing rps->work, where ACTIVE may be
> changed via asynchronous calls triggered by wakeref drop.
> This means that rps_work() could be triggered after the GT has
> been parked, so unmasking RPS PM interrupts would happen without
> holding PM wakelock. This sequence of events may be observed
> during live_rc6_ctx_wa() selftest:

...

> Fixes: 3e7abf814193 ("drm/i915: Extract GT render power state management")
> Closes: https://gitlab.freedesktop.org/drm/i915/kernel/-/issues/16562
> Cc: <stable@vger.kernel.org> # v5.5+
> Assisted-by: GitHub-Copilot:claude-opus-5
> Assisted-by: GitHub-Copilot:gpt-6-astra
> Signed-off-by: Krzysztof Karas <krzysztof.karas@intel.com>

reviewed and pushed to drm-intel-gt-next.

Thanks,
Andi
