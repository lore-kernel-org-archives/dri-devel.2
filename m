Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57ECCC79FBB
	for <dri-devel@archiver.kernel.org>; Thu, 10 Sep 2026 22:25:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D5B5810EDF2;
	Thu, 10 Sep 2026 22:25:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="lw0lXS26";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 86BBC10ED32;
 Thu, 10 Sep 2026 22:25:50 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 29E7C43691;
 Thu, 10 Sep 2026 22:25:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECE481F000FF;
 Thu, 10 Sep 2026 22:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789079150;
 bh=zLCp76C7IaDd/3HXXZHhXNNmT8LOyuAL2jBPJFFL5bw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=lw0lXS26SmWr01PVgdMI2cSEuV2iWoftdhxuLIKwlnhwhjMMdbfrCwTDPx8MfDLuZ
 5Y7P5dq9CyeV1Z0RP5/wuYmY2ynE/PfZ3vsxSRxVFtHGmFu/TbgFKUP5rgg4PaBv/k
 +TP09/ZuUhlWvZn/Gtbtwmk9R+Zr1zFpK98KloILnL7Ly5PvneRlSKmZFdATH5FGvX
 RGDx3KX6jwSbUh1WhGhVoTILvLWNiPX1Dack/Lh7PtMfFpFPYfsP2lESsPSU6tausu
 VoDbIG8NiABNenMKm+OhrO+aaI39aXz8xhCYdUz8kkYr4G09yWilMUunGMr8mrUEj0
 RkIvXpWHIysPw==
Date: Fri, 11 Sep 2026 00:25:46 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Krzysztof Karas <krzysztof.karas@intel.com>
Cc: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 iommu@lists.linux.dev, Andi Shyti <andi.shyti@linux.intel.com>, 
 Robin Murphy <robin.murphy@arm.com>,
 =?utf-8?Q?Micha=C5=82?= Grzelak <michal.grzelak@intel.com>, 
 Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>,
 Sebastian Brzezinka <sebastian.brzezinka@intel.com>, 
 Krzysztof Niemiec <krzysztof.niemiec@intel.com>
Subject: Re: [PATCH v6 4/7] iommu/dma: Catch scatterlist length overflows
Message-ID: <aqMt2sldJO05k5O3@zenone.zhora.eu>
References: <20260902082525.1149367-1-krzysztof.karas@intel.com>
 <20260902082525.1149367-5-krzysztof.karas@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260902082525.1149367-5-krzysztof.karas@intel.com>
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

one more thing here.

>  drivers/iommu/dma-iommu.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)

Can we send this patch separately? It just complicates things
if added in this series. Besides, pleasee add iommy maintainers
in the Cc list. You can use get_maintainers.pl

Andi
