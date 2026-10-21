Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21303606A319
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 22:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZdZyj23M
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6CEE010E167;
	Wed, 21 Oct 2026 22:24:30 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 964DD10E0DD;
 Wed, 21 Oct 2026 22:24:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8CA9F60052;
 Wed, 21 Oct 2026 22:24:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CCD51F000C1;
 Wed, 21 Oct 2026 22:24:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792621462;
 bh=REdUktNxGCJihQQBGRX8qc8uWVVEZHhwYkOf8/hakqI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=ZdZyj23Mdfgzs5j1strCtJ/YGmVEDFxDg1M3OA/FFBbZjW9O8IguNr0La8HHoggBn
 Hvkl1z3dx65bdJecuH/d7VQF5uyObcwLmOf7xPLlLdO0CbaQ2KjMX5OkgEOr4+TmKb
 BSbd+gMAAnNV4n0QpXyypDHGnQFPX+7R/vGJrY/X/fvMc7bhYfVlG/b/oB2ITHXCsB
 3NHi9u8p5995Vi5y+hcX2HQ+/ETErrsaRtTvpfPWvwMEPFSNPjcSSTKKGYdS5V1pfI
 JdEnPJT/KX4G4W65iHTEmXifs8BBiOvLz1Ip99tpgFAqitaldd/5qVfdjQPJZID7W/
 vCxKqTTZLXEmg==
Date: Thu, 22 Oct 2026 00:24:19 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Krzysztof Karas <krzysztof.karas@intel.com>
Cc: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 Andi Shyti <andi.shyti@linux.intel.com>,
 =?utf-8?Q?Micha=C5=82?= Grzelak <michal.grzelak@intel.com>, 
 Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>,
 Sebastian Brzezinka <sebastian.brzezinka@intel.com>, 
 Krzysztof Niemiec <krzysztof.niemiec@intel.com>
Subject: Re: [PATCH v7 1/6] drm/i915/shmem: Validate max_segment
Message-ID: <atk7ePepinRXb7HO@zenone.zhora.eu>
References: <20261006095845.451212-1-krzysztof.karas@intel.com>
 <20261006095845.451212-2-krzysztof.karas@intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261006095845.451212-2-krzysztof.karas@intel.com>
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Krzysztof,

On Tue, Oct 06, 2026 at 09:58:40AM +0000, Krzysztof Karas wrote:
> There is nothing preventing user of shmem_sg_alloc_table() from
> passing max_segment smaller than PAGE_SIZE, which would result
> in nr_pages = max_segment / PAGE_SIZE == 0 and cause a
> non-terminating loop.
> Also, ensure that this value io page-aligned.
> 
> Suggested-by: Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
> Suggested-by: Andi Shyti <andi.shyti@kernel.org>
> Assisted-by: LLM
> Signed-off-by: Krzysztof Karas <krzysztof.karas@intel.com>

Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>

Thanks,
Andi
