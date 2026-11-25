Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E53D606A323
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 14:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dkMc/yII
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5215610FCBE;
	Wed, 25 Nov 2026 14:20:43 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 14F4F10FCD1;
 Wed, 25 Nov 2026 14:20:37 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1CFDB62C02;
 Wed, 25 Nov 2026 14:20:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D8AE1F000CA;
 Wed, 25 Nov 2026 14:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795616435;
 bh=90g/9eeIAx5tdpdjeagizAiKzs5hIKIRGMeBLcmqq1Q=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=dkMc/yIIz4MjORhp4KZMWXx7YgBNHptPv5GKlh6MO4W1Btn0YBJr9X9uTxXTrKZrI
 FT+PY8hqNS8Oy71RcECA5payL+0wWi6DPGdoP7PoLP4inYvdkxI1FN0scfoDzihqFu
 YjKOx4EJGQm1Fk+zkRhGDGr6rahdj5CihdWxY72fYDdkt6KA4TKFKTO0bVFahLZ2QC
 B2nQaUpNb4dqkjJTjVLkWHf7lLyGmhUXYjYgHohyAiKO9rCUPD6jMImuVVdY+9QGuW
 j0Q9C4NJJSlQlo8/alU/aqugTrW5jb/y7ODkIS7qOM2UYVpDYecdNTW0MeH4gzXZBE
 qoEUTIWn6xLgA==
Date: Wed, 25 Nov 2026 15:20:29 +0100
From: Andi Shyti <andi.shyti@kernel.org>
To: Krzysztof Karas <krzysztof.karas@intel.com>
Cc: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 Andi Shyti <andi.shyti@linux.intel.com>,
 =?utf-8?Q?Micha=C5=82?= Grzelak <michal.grzelak@intel.com>, 
 Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>,
 Sebastian Brzezinka <sebastian.brzezinka@intel.com>, 
 Krzysztof Niemiec <krzysztof.niemiec@intel.com>
Subject: Re: [PATCH v8 0/6] drivers: Improve memory management for large
 object allocations when i915/shmem is used with iommu
Message-ID: <awbrobg9qVWLmriy@zenone.zhora.eu>
References: <20261109113758.1491891-1-krzysztof.karas@intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261109113758.1491891-1-krzysztof.karas@intel.com>
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Krzysztof,

> Krzysztof Karas (6):
>   drm/i915/shmem: Validate max_segment
>   drm/i915/gem: Count mapped pages in a folio
>   drm/i915/gem: Free sg table on failure to acquire second folio
>   drm/i915/gem: Pull out size validation into a separate function
>   drm/i915/gem: Read and shrink memory in a separate function
>   drm/i915/gem: Remove iterator and use while loop

pushde to drm-intel-gt-next.

Thanks for following up through all the reviews.

Andi
