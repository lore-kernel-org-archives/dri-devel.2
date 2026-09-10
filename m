Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2122C88E41
	for <dri-devel@archiver.kernel.org>; Thu, 10 Sep 2026 22:31:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 10E8210EFE6;
	Thu, 10 Sep 2026 22:31:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Eg22BBJV";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9846F10EFE6;
 Thu, 10 Sep 2026 22:31:02 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4765F4181D;
 Thu, 10 Sep 2026 22:31:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE9241F000FF;
 Thu, 10 Sep 2026 22:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789079462;
 bh=OAQJSPmYprdtbC9hOVYl5/rHCM95Iwt9YPvE5BwPOtg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=Eg22BBJVC+8UgAnCtyjXDTrnST6+CjXSQZUj6nlzhY9wiePzV49esI4YQVWSN1e6o
 ir49Gflm0UKoghuY9bWEKEc9s7XCEL0Xo2cUG6CV0GWDK0AYHIv8YsdKqiF3Xkx7Bq
 DeTt13EI6e0siS761wHy8Ejd05KrLVA8GN05IFm2UrX6VevHPSkUbS/Kl4j/7OrGer
 7rOYPvDWitdSa50uvkgonm0HIx56wagF16+WiUnT1SgqQt4p7sL7uEj5u7xQfNPD77
 qL0pUmO55j34fvtczPhZxmFjrsaeKHZe5PTk5H/ugIgq409NqNBwfMph481mVOBBlu
 /ixAnGJbrz4aA==
Date: Fri, 11 Sep 2026 00:30:58 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Krzysztof Karas <krzysztof.karas@intel.com>
Cc: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 iommu@lists.linux.dev, Andi Shyti <andi.shyti@linux.intel.com>, 
 Robin Murphy <robin.murphy@arm.com>,
 =?utf-8?Q?Micha=C5=82?= Grzelak <michal.grzelak@intel.com>, 
 Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>,
 Sebastian Brzezinka <sebastian.brzezinka@intel.com>, 
 Krzysztof Niemiec <krzysztof.niemiec@intel.com>
Subject: Re: [PATCH v6 6/7] drm/i915/gem: Read and shrink memory in a
 separate function
Message-ID: <aqMvCTIzLcshkVCA@zenone.zhora.eu>
References: <20260902082525.1149367-1-krzysztof.karas@intel.com>
 <20260902082525.1149367-7-krzysztof.karas@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260902082525.1149367-7-krzysztof.karas@intel.com>
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

On Wed, Sep 02, 2026 at 08:25:24AM +0000, Krzysztof Karas wrote:
> Continue unloading shmem_sg_alloc_table by placing reading
> folios and shrink call into a new helper.
> Make the code a bit more reader-friendly by removing moving

"by removing moving"?

> over structure elements and replacing it with a sequence of
> instructions.
> 
> Assisted-by: GitHub Copilot:claude-opus-5
> Signed-off-by: Krzysztof Karas <krzysztof.karas@intel.com>

Looks correct to me:

Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>

Thanks,
Andi
