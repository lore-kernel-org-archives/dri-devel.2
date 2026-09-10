Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B617BC79FBB
	for <dri-devel@archiver.kernel.org>; Thu, 10 Sep 2026 22:08:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9636D10EAED;
	Thu, 10 Sep 2026 22:08:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="O7WP1p6t";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7BDD110EAED;
 Thu, 10 Sep 2026 22:08:37 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1F0EC42AF8;
 Thu, 10 Sep 2026 22:08:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6176E1F00893;
 Thu, 10 Sep 2026 22:08:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789078117;
 bh=9y9YUZsrVpPc7jJgMR4kWBBon5l+dalyTe1ql4Bs5Z0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=O7WP1p6tzqylWK95AMS3JLqhdDsevUV9QHEMugV/8r4TuHKVJ6WiH+h+gHOMorMeX
 A7aIk10TZTjUO4Hy2KeCtqkys2qb4jirprr6F0kFqzdHVvUU5eMEO2rliJIZgZX0G8
 8TW2joUgdxkx/xoUwvCzMzj2XI7KuX+TN1P6SMASS8iI/RTtRj/IodqledOU53wd8A
 zwTR5paOw71waAJFKao8kaZzjpHjMwmqiS/n3Y87RFShM0uZpz+wEQpirM8qmLAXyf
 yOA+NA6ivPArCM6yHzGSl5mHVeBPBIct2Qa8VbbL9Zb+fQlIBtHESWVm8VoTjeYPc4
 8janHRGoEgxvg==
Date: Fri, 11 Sep 2026 00:08:33 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Krzysztof Karas <krzysztof.karas@intel.com>
Cc: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 iommu@lists.linux.dev, Andi Shyti <andi.shyti@linux.intel.com>, 
 Robin Murphy <robin.murphy@arm.com>,
 =?utf-8?Q?Micha=C5=82?= Grzelak <michal.grzelak@intel.com>, 
 Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>,
 Sebastian Brzezinka <sebastian.brzezinka@intel.com>, 
 Krzysztof Niemiec <krzysztof.niemiec@intel.com>
Subject: Re: [PATCH v6 2/7] drm/i915/gem: Count mapped pages in a folio
Message-ID: <aqMpIkMBmnZWsckc@zenone.zhora.eu>
References: <20260902082525.1149367-1-krzysztof.karas@intel.com>
 <20260902082525.1149367-3-krzysztof.karas@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260902082525.1149367-3-krzysztof.karas@intel.com>
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

> -		next_pfn = folio_pfn(folio) + nr_pages;
> +
> +		/*
> +		 * We assume folios are placed one after the other in memory
> +		 * and predict where the next folio begins.
> +		 */
> +		next_pfn = folio_pfn(folio) + folio_page_index + nr_pages;

referring to the comment, we are not really "assuming" anything
here; we are storing the next PFN so that continguous physcal
pages can be merged into the same SG entry.

Thanks,
Andi
