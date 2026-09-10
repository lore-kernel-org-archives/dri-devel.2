Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9997C88E41
	for <dri-devel@archiver.kernel.org>; Thu, 10 Sep 2026 21:55:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C3D1510E2DC;
	Thu, 10 Sep 2026 21:55:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="WBTpxRtk";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B25B310E2DC;
 Thu, 10 Sep 2026 21:55:39 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A265A60200;
 Thu, 10 Sep 2026 21:55:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 159721F000FF;
 Thu, 10 Sep 2026 21:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789077338;
 bh=EBcVPm8Ia66oMJBe0Ug4tIUTXe7c6Tm13It7QGHGULo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=WBTpxRtkv2QSdS8yesHeKOJERsWP3nFWyvXzoThcm7vLFsfMMqOO6j86gTSz+dS7Y
 4MYwrgMfOebMjwY65FnK55sOOQu2jLj8OTz+9FbCBG+CAlPTuwyS4rGFiASN/it1HI
 9BIo81xXqUXCzRZj+4bZs0ANhONHwF7jgVh/J53YCtYBdt545SVHjvWFKgeYyAuNJ7
 oATUzpCqN9XmVZI4m6EAi1U22DGJuIrYmax5Ci9YP5fLXD/ZP+stRYIJWjLoX5Jxli
 clsUr95YMWvUCA4UXUCBnXWu+fJR7IrX11tOaOVCJU4crdJMN60MMb6uAJPCnpFJUA
 LUc1ZawZYiSkw==
Date: Thu, 10 Sep 2026 23:55:34 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Krzysztof Karas <krzysztof.karas@intel.com>
Cc: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 iommu@lists.linux.dev, Andi Shyti <andi.shyti@linux.intel.com>, 
 Robin Murphy <robin.murphy@arm.com>,
 =?utf-8?Q?Micha=C5=82?= Grzelak <michal.grzelak@intel.com>, 
 Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>,
 Sebastian Brzezinka <sebastian.brzezinka@intel.com>, 
 Krzysztof Niemiec <krzysztof.niemiec@intel.com>
Subject: Re: [PATCH v6 1/7] drm/i915/shmem: Validate max_segment
Message-ID: <aqMmx08W0SHX8C1N@zenone.zhora.eu>
References: <20260902082525.1149367-1-krzysztof.karas@intel.com>
 <20260902082525.1149367-2-krzysztof.karas@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260902082525.1149367-2-krzysztof.karas@intel.com>
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

> +	if (max_segment < PAGE_SIZE)
> +		return -EINVAL;

should we also check here whether max_segment is page-aligned? I
think the loop coming later assumes that. If max_segment is not
aligned nr_pages can be == 0, right?

Andi
