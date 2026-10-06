Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C45D2CA5FF0
	for <dri-devel@archiver.kernel.org>; Tue,  6 Oct 2026 13:21:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 239A010E6E3;
	Tue,  6 Oct 2026 13:21:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="VdQe8ZD7";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7BCF410E6E3
 for <dri-devel@lists.freedesktop.org>; Tue,  6 Oct 2026 13:21:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id AC49C601E4;
 Tue,  6 Oct 2026 13:21:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEB3A1F000FF;
 Tue,  6 Oct 2026 13:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791292882;
 bh=ve6FyCySopgjKeMpIP/0QU8qxdOqPiBfDjjpOehpCoY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=VdQe8ZD7EPqTDHxtueMopqyaA1HhJuYlOfkK5y35AbXr7QAEUOVHdzh02IY0Ui1sS
 dTmdQ2Wqr/EJ9L500f7BIdOdngJN8ypO5dwzdm9U4V4xc1ZozSS/Z0+DJ1npqgwDWN
 CLLY3/r6Pe9nVzsx4VPzR1fcFViQfNV7ATamTawPejNpLVkCDAoVKHge+ujnFUTIoS
 o8oRA8gLvsrOM3JdZIy3gPrfNiNDr0IrGpRPZQZocUpVHpCa8s43/eNkWQZGUExh5G
 o11rGxaWa5eVuns9oAa9KUMbn3A9UkiiXgTdvDIXe69dUfMG7ktRxa1Dkao+9iTntX
 kckAQe/EUYfSg==
Date: Tue, 6 Oct 2026 15:21:18 +0200
From: Vinod Koul <vkoul@kernel.org>
To: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Cc: Linus Walleij <linusw@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
 Mark Brown <broonie@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Frank Li <Frank.Li@kernel.org>, Lee Jones <lee@kernel.org>,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-pm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 dmaengine@vger.kernel.org, Frank Li <Frank.li@oss.nxp.com>
Subject: Re: [PATCH v3 15/18] dmaengine: ste_dma40: Use power domain for LCLA
 SRAM
Message-ID: <asT1zuk9WNJU4p9M@parshuram>
References: <20260921-ux500-power-domains-v7-1-v3-0-9352be6b86b1@kernel.org>
 <20260921-ux500-power-domains-v7-1-v3-15-9352be6b86b1@kernel.org>
 <CAPx+jO_KJJ6ORKuw6VJmtZAOEnzVz0+bq3bEFupAK_4UROKBAA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPx+jO_KJJ6ORKuw6VJmtZAOEnzVz0+bq3bEFupAK_4UROKBAA@mail.gmail.com>
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

On 24-09-26, 15:26, Ulf Hansson wrote:
> On Mon, Sep 21, 2026 at 12:49 AM Linus Walleij <linusw@kernel.org> wrote:
> >
> > Replace the LCLA ESRAM regulator with runtime PM.
> >
> > Use the SRAM device that owns the ESRAM34 power domain.
> >
> > Hold that domain while DMA transfers are active. The DMA controller is
> > runtime PM IRQ-safe, so keep taking explicit LCLA runtime PM references
> > from the descriptor preparation path instead of relying on a runtime PM
> > device link from the atomic transfer path.
> 
> A bit of an orthogonal problem, but related to the above. The irqsafe
> thing have been discussed in the past for DMA controller drivers.
> 
> Would it possible to get rid of the irqsafe configuration for the dma
> controller device, altogether?
> 
> I don't recall exactly, but not the entire consumer DMA API is allowed
> to be called in atomic context, but perhaps that is not sufficient to
> allow us to drop the irqsafe configuration for the DMA controller
> device?
> 
> If not, I wonder if the consumer of the DMA (like an mmc controller)
> should be assigned as a consumer device (using device links and
> DL_FLAG_PM_RUNTIME) of the DMA controller device. In this way, the
> consumer (mmc) would be able to control the supplier (DMA) through the
> device link directly using runtime PM. This could potentially avoid
> the requirement of having to use irqsafe for the DMA controller
> device. Maybe someone already tried this?
> 
> If the irqsafe configuration can be dropped, in some way or the other,
> this patch could become less intrusive, as all that would be needed is
> to create a device link to sram device using DL_FLAG_PM_RUNTIME.

That is a consequence of dmaengine work running in tasklet and thus
softirq mode. The dmaengine tasks need to run with a higher priority to
enable higher dmaengine throughput. We have plans to move to WQ_BH [1], but
I think that runs in softirq mode as well...

[1]: cover.1786384168.git.allen.lkml@gmail.com
-- 
~Vinod
