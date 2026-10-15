Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 184E9CC6B30
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 10:47:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D7351122BB;
	Thu, 15 Oct 2026 10:47:31 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB6D61122BA;
 Thu, 15 Oct 2026 10:47:24 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id F2E1860120;
 Thu, 15 Oct 2026 10:47:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A8F91F000C4;
 Thu, 15 Oct 2026 10:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792061243;
 bh=bn1RVhh00tR2vWhDxqlS04Kzhv5cg4PHb+mrabZlf2M=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=Qp9GsYQFpkwJFALLlWyLztGsBZGaiC8y9HyLf54K4ElVhjIsLpZFVXaaIsqRrb2SI
 BCzlrWoYyljSUUVVJb0M9DevB4bp+VkxEav2UluERBUpIh+DXw4wG9NBG4itegwGqC
 CINJalsZSHC0wjo/6i1HZDyke6vwB1UCYurjooRGZMJJsCw5XIWFmGzDkuAjW7qXIj
 gh+GLZWuMtBYcFkkOycW4/vdRjZEaWaXSIacmF0X17YK2aEi1RilGLXhTPMdb98I7d
 Bv6bbJqBOqlNiIe55UaNQr4w2qYsPFEkp3LNonL7d0mqH/b5Pd2ez2HShcNJb/Z+F5
 sfX19PQDxzIvg==
Date: Thu, 15 Oct 2026 12:47:16 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Baihui Liang <liangbaihui@linux.spacemit.com>
Cc: Alessio Belle <alessio.belle@imgtec.com>, 
 Luigi Santivetti <luigi.santivetti@imgtec.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@kernel.org>,
 imagination@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, 
 linux-riscv@lists.infradead.org, spacemit@lists.linux.dev
Subject: Re: [PATCH] dt-bindings: gpu: img, powervr-rogue: add spacemit, k1-gpu
 and spacemit,k3-gpu
Message-ID: <20261015-cordial-unstoppable-jaguarundi-bcf668@quoll>
References: <20261015-spacemit-gpu-binding-v1-1-a7a23c7e7788@linux.spacemit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261015-spacemit-gpu-binding-v1-1-a7a23c7e7788@linux.spacemit.com>
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

On Thu, Oct 15, 2026 at 03:00:48PM +0800, Baihui Liang wrote:
> Add compatible strings for the IMG GPUs in SpacemiT K1 and K3 SoCs:
> - K1: IMG BXE-2-32 (adds a dedicated entry for a single core
>   clock and power domain).
> - K3: IMG BXM-4-64 (shares the same configuration and entry as
>   the T-Head TH1520).
> 
> Both SoCs require a single power domain provided by the APMU driver
> (currently pending mainline):
> Link: https://lore.kernel.org/all/20261008-04-k3-pm-support-v2-0-6f778a53dd2d@kernel.org/

That's not relevant here, drop paragraph.

> 
> Signed-off-by: Baihui Liang <liangbaihui@linux.spacemit.com>
> ---
>  .../devicetree/bindings/gpu/img,powervr-rogue.yaml      | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

