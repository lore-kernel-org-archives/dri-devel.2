Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DF19CD6E64
	for <dri-devel@archiver.kernel.org>; Tue,  2 Jun 2026 12:07:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7CB6510F00F;
	Tue,  2 Jun 2026 12:07:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ACGTTxa8";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E2EC10F00F
 for <dri-devel@lists.freedesktop.org>; Tue,  2 Jun 2026 12:07:32 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0D51A4022C;
 Tue,  2 Jun 2026 12:07:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C2DF1F00893;
 Tue,  2 Jun 2026 12:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780402051;
 bh=yf9fztpSi4K+ljlndUdAbTgpH8FO9UBENIcySmefiuo=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date;
 b=ACGTTxa8FbXBbbfTxT10geybgu/iGCQ5gAPvgGW65pwToitHKMb7oXIvmJwag/Gl9
 7+Tz6MWHzmRjkbVhxq7H7CY1ekgHUKDFDvqts6yhC4KPN9pbt4W0DDnvGn2BeJEgE/
 NQ6TYrDN1EndBuecSRzsbbGV8VvQqGaRoDi/PLx1GzGNzPEZq8D7kWHmo5/Lan8Rcy
 6mGAQmbNWcZbrkR2CmvqVo2j+F2q79QB1IF38Pf6DeY2xyMYugYYxB7ILjPzTw0dGw
 4GY2pVtyDg41+ZprebAb0wvC1wAPMg23p0L3JL3wIZ2hjKhPe5o8c4PF9bQK3ZmZSq
 +PRLqakkNBakw==
From: Mark Brown <broonie@kernel.org>
To: Thierry Reding <thierry.reding@kernel.org>, 
 Jonathan Hunter <jonathanh@nvidia.com>, 
 Sowjanya Komatineni <skomatineni@nvidia.com>, 
 Laxman Dewangan <ldewangan@nvidia.com>, 
 Sumit Semwal <sumit.semwal@linaro.org>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Aaron Kling <webgeek1234@gmail.com>
Cc: linux-tegra@vger.kernel.org, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
 devicetree@vger.kernel.org, Thierry Reding <treding@nvidia.com>
In-Reply-To: <20260525-tegra194-qspi-iommu-v2-0-a11c53f804b2@gmail.com>
References: <20260525-tegra194-qspi-iommu-v2-0-a11c53f804b2@gmail.com>
Subject: Re: (subset) [PATCH v2 0/2] arm64: tegra: Enable DMA Support on
 Tegra194 QSPI
Message-Id: <178032313909.44654.17999841515127150550.b4-ty@b4>
Date: Mon, 01 Jun 2026 15:12:19 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1428; i=broonie@kernel.org;
 h=from:subject:message-id; bh=CXeJ9bvnJoexsr0ZqogM4Dl8ae1EzlAlaa7aCsJn7q8=;
 b=owGbwMvMwMWocq27KDak/QLjabUkhiy54/XyPcEnBT53/v2Y89Ssy7P91+LkqBPJnziq4yQyu
 iZ4yRp2MhqzMDByMciKKbKsfZaxKj1cYuv8R/NfwQxiZQKZwsDFKQATSWpg/ytzi/0SS/F8eY6S
 3m9uifbs2fVZW8VOv5hQMd9/DnuY1L/MNR71RQK+z3+nXEiPKnc+L1pikeIVnFhT4eOz8F/TksV
 87Admvej7Y/ch/mZrUChvkZaTUOe9tDs8zlKdhTt19YqZOcrkq9o8/6TL8Avu/HHn6/oTwS3KK6
 2+PqhP57GbesA2+bzLmnthiy/liPeqmp3/E3OCh++/85nFD7eeDNo/galh569m8z0LRFPvPXr/Q
 yOOR8np1tNvWyMtzWbbvlda2BZ12EHlYaVAwKFEvlV3+B89rF9/p9bpbMn1dRcNHD1kMtg0ypYu
 O71tRtGTxFJX1YiVSfvVH3qteJJuH8D8xUb46NN96v+LAA==
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
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

On Mon, 25 May 2026 01:47:43 -0500, Aaron Kling wrote:
> arm64: tegra: Enable DMA Support on Tegra194 QSPI
> 
> The reason for this is to properly support the spi nor chip on the
> Jetson Xavier NX module. Prior to this, it would time out on all
> transfers and sometimes even trigger a cbb fault, locking up the entire
> unit. With this, reading and writing to the flash memory works as
> expected.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.2

Thanks!

[1/2] spi: tegra210-quad: Allocate DMA memory for DMA engine
      https://git.kernel.org/broonie/spi/c/f469138a77ac

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

