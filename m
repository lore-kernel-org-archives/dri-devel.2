Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EED7FC61DB9
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 23:28:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C53A10E35E;
	Thu, 27 Aug 2026 23:28:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="QBkfZFzX";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F0EB10E35E;
 Thu, 27 Aug 2026 23:28:50 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id EB40341171;
 Thu, 27 Aug 2026 23:28:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 286221F000E9;
 Thu, 27 Aug 2026 23:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787873329;
 bh=YdS2Sw5IsjHSkFPY05s+h4I817e/CbHGagdiPZ1jlsc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=QBkfZFzXyf/sbl95tfywYfjqqeQSL50mOwZFkydPFQ+mSDgq2552MajTUBdTlkOLh
 GPT11tsmYKmKA3rTyh+LmHOBffF/6QMEgNEzXDUqoHG60SyFkAGaDKR5Nt13nJeCAF
 d65XBWlkptQdcdNL046bK3FQL9VtDlsSThnkxDsr97UUGCH3ntmuVJitqU/ZGeGom0
 K1tcCjXFfjoq489Otgzy+fjPviqxne+51Kw1GvG1lhJ251qW4uQJ56CaLemt3St3oU
 7Fvh0mnUiWpxRiuU44Y6C3MBvk0rSOELdVW1G5SHthT4vfXMSS1T8NSpG/+N6AmdAJ
 XA9sgB42kt56A==
Date: Fri, 28 Aug 2026 01:28:46 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Krzysztof Karas <krzysztof.karas@intel.com>
Cc: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 Jani Nikula <jani.nikula@linux.intel.com>,
 Andi Shyti <andi.shyti@linux.intel.com>, 
 Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>,
 Sebastian Brzezinka <sebastian.brzezinka@intel.com>, 
 Krzysztof Niemiec <krzysztof.niemiec@intel.com>
Subject: Re: [PATCH v2 2/8] drm/i915/selftest: Fix a typo in alloc_workqueue
 call
Message-ID: <apDH6S6JaMQAKzZM@zenone.zhora.eu>
References: <20260818095624.3254368-1-krzysztof.karas@intel.com>
 <20260818095624.3254368-3-krzysztof.karas@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260818095624.3254368-3-krzysztof.karas@intel.com>
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

On Tue, Aug 18, 2026 at 09:56:18AM +0000, Krzysztof Karas wrote:
> Replace "i1915-selftest" with "i915-selftest".
> 
> Signed-off-by: Krzysztof Karas <krzysztof.karas@intel.com>

Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>

This typo fix is out of the scope of the series. It's OK to send
it separately.

Thanks,
Andi
