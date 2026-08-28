Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E35A3C61DBD
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 14:24:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E76B10F3E4;
	Fri, 28 Aug 2026 14:24:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="KYTANUpx";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9DA1610E242;
 Fri, 28 Aug 2026 14:24:50 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6E4A4405B4;
 Fri, 28 Aug 2026 14:24:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 274271F000E9;
 Fri, 28 Aug 2026 14:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787927090;
 bh=kS5E6UORIh1dAxYt27wnf3ad3fJs598T4QG4S2iB8VQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=KYTANUpxs3kob3dLPXEwsLSUfRgLF/NZlULEhXqmRSKsWhFSHactNuS2LMx13P7V7
 j7m0XDlPpl/LQx4XJSs9mvtd5oiTdJ26O3UlQH6Fa/HBYOa1C2h9tu3uLBjkXZCRYl
 TN7yYfzS9rSLx36Q5X5/hJz6SmETnYbKojdP9YENJLUoRGJJQJPt3w4kJV3AS1sZlA
 htQAXDhJg85ddyOWBtsz/uxSL14lVGD6S135/WVFzXeyEWO43rg8sONyXkk0poEZWO
 m5zkp6rvM64vtA6obvXhm3u0sNTSgg0QhxFS2Vy8aneCUJ8XBMgfHF4Y3p7ZxJwQYd
 v0QTOPMaqs/nQ==
Date: Fri, 28 Aug 2026 16:24:45 +0200
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
Message-ID: <apGZ4hj-107gie9j@zenone.zhora.eu>
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

You forgot to add my

Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>

Please, don't forget next time.

Andi
