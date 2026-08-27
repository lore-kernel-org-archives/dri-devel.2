Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA518C61DC6
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 23:34:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC25F10F1EB;
	Thu, 27 Aug 2026 23:34:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="hM69mr0i";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E0ED10F1E9;
 Thu, 27 Aug 2026 23:34:44 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1E6E54133B;
 Thu, 27 Aug 2026 23:34:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BE8A1F000E9;
 Thu, 27 Aug 2026 23:34:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787873684;
 bh=yV8tXKhYdCqfpWS1ASVchk+1ETm1/RoVJiM23bSsPYQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=hM69mr0iwLzz2dMoZGQNzNU5NcyWirwcLKUYGxE/mZc6teWIcVq5RrQnA9vzWLWB9
 uQY0nLcg28hqXN/1G7UHWV1okKhGS5oIxV4OwTBncgxEoMxKjqRzIJMUaj88bad1v+
 n3KiN05eL5ILDINhH9cNOT4EINOaDUpNjZKM+tY4qhIFI383Jao5U2p7s0rJIN5PWi
 ECJIZfiNKzB6K7xTSvG0W+JnIIGkyh3tzqAYJTQzL60TrYxGn/r30YFuNPBspFE//8
 QX/AgBEP10W2D2FheXwDWXsGZ60MQuCVjTZzwubWMm8BCDjpJgL0mVV4DX9ovnHYoT
 ZHLXSO/CtGmUw==
Date: Fri, 28 Aug 2026 01:34:41 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Krzysztof Karas <krzysztof.karas@intel.com>
Cc: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 Jani Nikula <jani.nikula@linux.intel.com>,
 Andi Shyti <andi.shyti@linux.intel.com>, 
 Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>,
 Sebastian Brzezinka <sebastian.brzezinka@intel.com>, 
 Krzysztof Niemiec <krzysztof.niemiec@intel.com>
Subject: Re: [PATCH v2 4/8] drm/i915/selftests: Use drm_* prints in selftest
 helpers
Message-ID: <apDJbf8V-HsGfXmN@zenone.zhora.eu>
References: <20260818095624.3254368-1-krzysztof.karas@intel.com>
 <20260818095624.3254368-5-krzysztof.karas@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260818095624.3254368-5-krzysztof.karas@intel.com>
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

On Tue, Aug 18, 2026 at 09:56:20AM +0000, Krzysztof Karas wrote:
> Move away from generic pr prints to device context aware drm
> versions.
> 
> Signed-off-by: Krzysztof Karas <krzysztof.karas@intel.com>

Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>

Thanks,
Andi
