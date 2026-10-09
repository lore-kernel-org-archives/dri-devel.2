Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66CDBCA5FED
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 08:52:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A9EA910FFB0;
	Fri,  9 Oct 2026 08:52:42 +0000 (UTC)
X-Greylist: delayed 350 seconds by postgrey-1.36 at gabe;
 Fri, 09 Oct 2026 08:52:41 UTC
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
 by gabe.freedesktop.org (Postfix) with ESMTP id 6DE9E10FDD2;
 Fri,  9 Oct 2026 08:52:41 +0000 (UTC)
Received: from 8bytes.org
 (p200300f6af404a00448550d0471e54ea.dip0.t-ipconnect.de
 [IPv6:2003:f6:af40:4a00:4485:50d0:471e:54ea])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits)
 server-digest SHA256) (No client certificate requested)
 by mail.8bytes.org (Postfix) with ESMTPSA id 7770A1C77A3;
 Fri,  9 Oct 2026 10:46:49 +0200 (CEST)
Date: Fri, 9 Oct 2026 10:46:48 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Krzysztof Karas <krzysztof.karas@intel.com>
Cc: intel-gfx@lists.freedesktop.org, iommu@lists.linux.dev, 
 dri-devel@lists.freedesktop.org, Robin Murphy <robin.murphy@arm.com>, 
 Will Deacon <will@kernel.org>, Andi Shyti <andi.shyti@linux.intel.com>, 
 =?utf-8?Q?Micha=C5=82?= Grzelak <michal.grzelak@intel.com>,
 Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>, 
 Sebastian Brzezinka <sebastian.brzezinka@intel.com>,
 Krzysztof Niemiec <krzysztof.niemiec@intel.com>, stable@vger.kernel.org
Subject: Re: [PATCH] iommu/dma: Catch scatterlist length overflows
Message-ID: <asip2Nv2rCRE4mPH@8bytes.org>
References: <20261002053320.3145901-1-krzysztof.karas@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261002053320.3145901-1-krzysztof.karas@intel.com>
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

On Fri, Oct 02, 2026 at 05:33:20AM +0000, Krzysztof Karas wrote:
>  drivers/iommu/dma-iommu.c | 20 +++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)

Applied, thanks.
