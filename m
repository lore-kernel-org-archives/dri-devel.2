Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFB05CD8CB9
	for <dri-devel@archiver.kernel.org>; Thu, 11 Jun 2026 07:35:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E59C10ED30;
	Thu, 11 Jun 2026 07:35:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Z01QBw/h";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D09B810ED30
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 07:35:20 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D79B56020A;
 Thu, 11 Jun 2026 07:35:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E3651F00893;
 Thu, 11 Jun 2026 07:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781163319;
 bh=mo/64/HPY/6XXdxYXG0j1Rf2IH961OLjSb7/zYXIAp0=;
 h=Date:From:To:Subject:In-Reply-To:References:Cc;
 b=Z01QBw/hVD0yzmyR9h/PeeyZ0iRCgAk+/aPcn16UqS3zZfuWeP7a6qWfdqmwQ64c7
 SUPKR2ROzkbXWRdLbWoisYB51wZF40L8vvw0MozUehUzOXbcsSsnQ0fbgMJJmCHGkW
 z+TuJ9RV3obUIo8CPP/tRZUPc5Hs7F5upTIG6t0fkoVPZxquwXwNgAinfjXUhvkvqU
 6YeQ2LjisVMoDUHycAma+Lu74RYAWxQFblvBsWwIvRFb7/kKDiutnbSyvdf+3vpuqS
 Dp2GHlTRm5vmXa5cb7jZrXcCPOVrqwZElTLvCkH94I9VrnrjiQ9+mME23BBp+rSEGk
 5s8EcKr+hihgQ==
Message-ID: <c52f5bc48973b580c8df41764acb73e4@kernel.org>
Date: Thu, 11 Jun 2026 07:35:17 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Sumit Semwal" <sumit.semwal@linaro.org>
Subject: Re: [PATCH] dma-buf: move system_cc_shared heap under separate Kconfig
In-Reply-To: <20260610142329.3836808-1-sumit.semwal@linaro.org>
References: <20260610142329.3836808-1-sumit.semwal@linaro.org>
Cc: Brian.Starkey@arm.com, afd@ti.com, agordeev@linux.ibm.com, arnd@linaro.org,
 benjamin.gaignard@collabora.com, chleroy@kernel.org, christian.koenig@amd.com,
 djbw@kernel.org, dri-devel@lists.freedesktop.org,
 gerald.schaefer@linux.ibm.com, hch@infradead.org, jgg@ziepe.ca,
 jiri@resnulli.us, jstultz@google.com, linaro-mm-sig@lists.linaro.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, lkp@intel.com,
 maddy@linux.ibm.com, mpe@ellerman.id.au, mripard@kernel.org, npiggin@gmail.com,
 sumit.semwal@linaro.org, thomas.lendacky@amd.com, tjmercier@google.com,
 x86@kernel.org, "Arnd
 Bergmann" <arnd@arndb.de>, "Maxime Ripard" <mripard@kernel.org>
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

On Wed, 10 Jun 2026 19:53:29 +0530, Sumit Semwal wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> While system heap and system_cc_shared heap share a lot of code
> and hence the same source file, their users have different needs.
> 
> 
> [ ... ]

Acked-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime
