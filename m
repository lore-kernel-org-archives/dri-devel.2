Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15E53CD343B
	for <dri-devel@archiver.kernel.org>; Wed,  6 May 2026 13:54:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A37E10EDAC;
	Wed,  6 May 2026 13:54:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="EztVb4Ma";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6590B10EDAC;
 Wed,  6 May 2026 13:54:08 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 3421C436D6;
 Wed,  6 May 2026 13:54:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 134EFC2BCB2;
 Wed,  6 May 2026 13:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778075648;
 bh=NoI8j3F1YW25tR0zL0cDFy/lvZ5oPDxPYyIFiIeRMtE=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=EztVb4MarZed7S8kuN33gAfdyd2gdT1d8RmOJSSFKQBihDeycyARB7Zhi+PL+C9yq
 R/+vcTzXRksxQ4zwZpvTD6wqftzB10Ga7gpdTM7GQ4zQrRzw55F+U/Nk3g+BS7rxAe
 yJCHf5Cgg2KVl/CRkbJt8CbMzRcsR7MngJkPDmLw+woqflg8wXWdWsAFF/dbk7Qj8z
 UAQfxxezNET+jbe/+3m39trZkzCd7adVhIZWKuPKj14mUbK2McYqK0Hc7M8eFXdL36
 HmN2psbcmeCn0x/fBlXNQFIMyKyq79uNEbKjV+Z+dYpIXcyygxbfPThvTvfgp9jFDM
 +nsbDI3QOR8xw==
Message-ID: <758ab729-dc5a-4837-b255-9462aaa6b0a3@kernel.org>
Date: Wed, 6 May 2026 15:54:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/9] ata: ahci_tegra: Explicitly specify PMC instance to
 use
To: Thierry Reding <thierry.reding@kernel.org>,
 Niklas Cassel <cassel@kernel.org>, Jonathan Hunter <jonathanh@nvidia.com>,
 Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Mikko Perttunen <mperttunen@nvidia.com>, Dmitry Osipenko <digetx@gmail.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Mathias Nyman
 <mathias.nyman@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-ide@vger.kernel.org, linux-tegra@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 nouveau@lists.freedesktop.org, linux-media@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-usb@vger.kernel.org,
 Thierry Reding <treding@nvidia.com>
References: <20260506-pmc-v1-0-a6de5da7216b@nvidia.com>
 <20260506-pmc-v1-1-a6de5da7216b@nvidia.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260506-pmc-v1-1-a6de5da7216b@nvidia.com>
Content-Type: text/plain; charset=UTF-8
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

On 2026/05/06 15:41, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> Currently the kernel relies on a global variable to reference the PMC
> context. Use an explicit lookup for the PMC and pass that to the public
> PMC APIs.
> 
> Signed-off-by: Thierry Reding <treding@nvidia.com>

Acked-by: Damien Le Moal <dlemoal@kernel.org>

Applying this through the Tegra tree is fine with me.


-- 
Damien Le Moal
Western Digital Research
