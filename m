Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9687BC5DF7D
	for <dri-devel@archiver.kernel.org>; Fri, 21 Aug 2026 11:43:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E331810E27D;
	Fri, 21 Aug 2026 11:43:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=lankhorst.se header.i=@lankhorst.se header.b="mxjRbnLD";
	dkim-atps=neutral
Received: from lankhorst.se (unknown [141.105.120.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BAACD10E27D;
 Fri, 21 Aug 2026 11:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lankhorst.se;
 s=default; t=1787312634;
 bh=pJ3uhZIwhggqR1rzQH6qwkPm4XEWfufi/qpDSzwX1IU=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=mxjRbnLDPYWWS13LQEEGyZcdyDbzjqFb4Hltaa6OdQQu9H9S256KfOSPWbsvztcuJ
 +oPA+5BRduEpF7hMeOhRrHd9bH6PQaufVhHa9ImMu3I3a8EN2+Nk7fSf0gkUxp1Rln
 B2hcWbfmGeZURXP492MCCdOmfHMrqCkYUJ3x4FFaG9rv3XXTkEnYbYLyJw2K3jFooW
 BzQzdZyrEKeqQTqLM8AINVxJYOwBgIxGYeq76h3fTTfenGK4NCSFHYnGoZPbigSL2b
 f1PacbgCcKEnGAUGIPe87Qi/u98jYZTPtAjZbpF1jK/dj8vQQ4tzjCRiPCMrhm4o+3
 tmg7r/nQ6TNaw==
Message-ID: <5c4b9949-506b-4a01-b390-a83ec5d63fd5@lankhorst.se>
Date: Fri, 21 Aug 2026 13:45:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 7/7] drm/i915/gt: Use signalers_lock to prevent
 starvation of irq_work.
To: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
Cc: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 bigeasy@linutronix.de
References: <20260706114823.752313-1-dev@lankhorst.se>
 <20260706114823.752313-8-dev@lankhorst.se>
 <20260821022530.2503120-1-shuangpeng.kernel@gmail.com>
Content-Language: en-US
From: Maarten Lankhorst <dev@lankhorst.se>
In-Reply-To: <20260821022530.2503120-1-shuangpeng.kernel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Hello,

On 8/21/26 04:25, Shuangpeng Bai wrote:
> Hi Maarten,
> 
> While reviewing this series, I noticed an additional request lifetime
> issue in signal_irq_work().
> 
> The existing RCU loop removes rq from ce->signals and may then call
> i915_request_put(rq). If that is the final reference, the request can be
> released and its SLAB_TYPESAFE_BY_RCU slot reused before
> list_for_each_entry_rcu() advances and reads rq->signal_link.next. The
> RCU read-side critical section does not provide a stable reference to the
> same request object in this cache.
> 
> The v4 conversion to signalers_lock/ce->signal_lock and the
> list_first_entry_or_null() loop removes this post-put dereference, so it
> also covers this UAF path.
> 
> This is independent of the PREEMPT_RT irq_work starvation trigger. I can
> reach the sequence in a diagnostic run, although KASAN does not reliably
> report it because i915_request uses a SLAB_TYPESAFE_BY_RCU cache.
> 
> Since this also removes a request lifetime UAF from the common signaling
> path, it may be worth considering the relevant fix for stable kernels once
> the series is accepted.

The original patch for the conversion actually had this bug. There were some
failures reported by CI, pointing to a use-after-free after the changes.

Originally I thought it was due to the conversion itself, that the lifetime
was previously sufficiently by RCU. It makes sense that RCU itself couldn't
properly protect that, and that relying on it was a bug to begin with.

Thanks, I'll send this patch again separately and attach a stable tag!
Since you reported the issue, would you want to put your reviewed by
on the patch as well?

Kind regards,
~Maarten Lankhorst
