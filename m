Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D236CCC6B3A
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 16:18:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 328C91122D3;
	Thu, 15 Oct 2026 16:17:56 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7DC3B1123A2
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 16:17:49 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8BB60601EF;
 Thu, 15 Oct 2026 16:17:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95EFC1F000C4;
 Thu, 15 Oct 2026 16:17:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
 s=korg; t=1792081068;
 bh=c+imwRzy+TFjWbQ+yNo83g0lH0n4xVBCsI1vuUaGOns=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=YRFhddnOwD67BDUZz8e+5AHZfAUyqZTD22qHQFLAaw0mX2G1Td8dj64kQAcpTaBmB
 an3MHuPXbXjRjAAWTHrEfeCBQ23VfxijrwFYdpjokFn7IMZaO0aDLYDSllOGxzPnca
 j4f4TyUtOAEnSWlIctPI1smEokMCFZ50ju4VKrdM=
Date: Thu, 15 Oct 2026 18:17:52 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>,
 Alex Williamson <alex@shazbot.org>,
 Jason Gunthorpe <jgg@nvidia.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jean-Philippe Brucker <jpb@kernel.org>,
 Oded Gabbay <ogabbay@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.linux.dev, kvm@vger.kernel.org,
 devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-doc@vger.kernel.org
Subject: Re: [RFC PATCH v2 02/15] misc/arm-cla: Add launch operation helpers
Message-ID: <2026101542-briskness-most-a8ca@gregkh>
References: <20261015142552.4128028-1-ryan.roberts@arm.com>
 <20261015142552.4128028-3-ryan.roberts@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261015142552.4128028-3-ryan.roberts@arm.com>
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

On Thu, Oct 15, 2026 at 03:25:36PM +0100, Ryan Roberts wrote:
> From: Jean-Philippe Brucker <jpb@kernel.org>
> 
> CLA commands are issued by writing optional payload registers,
> programming the LAUNCH register and polling LRESP until the hardware
> accepts or rejects the operation.
> 
> Add a common launch helper that performs this sequence on the CLA's
> local CPU, waits for LRESP completion and translates launch response
> codes into Linux errors.
> 
> Build accelerator reset and register read and write support on top of
> it. The register read and write helpers split larger accesses into
> multiple launch operations when an access crosses an eight-register
> window.
> 
> Signed-off-by: Jean-Philippe Brucker <jpb@kernel.org>

You forgot to sign off on patches from others :(

