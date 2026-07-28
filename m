Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BA3EC54F4C
	for <dri-devel@archiver.kernel.org>; Tue, 28 Jul 2026 14:42:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E281910E935;
	Tue, 28 Jul 2026 14:42:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="GMtlsPzQ";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 661C410E926;
 Tue, 28 Jul 2026 14:42:24 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 92D2460A5E;
 Tue, 28 Jul 2026 14:42:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E09B51F000E9;
 Tue, 28 Jul 2026 14:42:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785249743;
 bh=DFq1P2GXspIY/uUf473I92xb3+BXZvYdQ6tdZRmrmW0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=GMtlsPzQy5J8mAtWTLBMWkpqF3++U7zJadHpafD5LQpT2QqDt6MZwZofaXMJ1ar3o
 StUGgkG8CC9tknhFNhF9Po6nTcJgOI+5i+NXpXaXe4NeRsO92PECw2SeSZU14BJzaP
 8HUYS0pxhvbyykNJvFcVbaw63O1leZ4U7cR56NbU/qsiK23Wk04yrAzdvj0nubusU+
 IpHzOd3jlYjG01r7oY46ZwsiJ5zXJW0Y8KNXbvMJ4CBupix0s18e1Ure5PJmkKh+qM
 JjBY2zqguDaVvzFpKYR5wFpCBgiFOgNbOSyWp9rC+MElVNIGmVmYJbc7Zyh3IeaPmN
 nUn4G34AAI8Fg==
Date: Tue, 28 Jul 2026 09:42:20 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: linux-kernel@vger.kernel.org, Brian Masney <bmasney@redhat.com>,
 Stephen Boyd <sboyd@kernel.org>, David Airlie <airlied@gmail.com>,
 Luigi Santivetti <luigi.santivetti@imgtec.com>,
 linux-mediatek@lists.infradead.org, dri-devel@lists.freedesktop.org,
 imagination@lists.freedesktop.org, Thomas Zimmermann <tzimmermann@suse.de>,
 Conor Dooley <conor.dooley@microchip.com>,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Alessio Belle <alessio.belle@imgtec.com>,
 YoungJoon Lee <getfeus@gmail.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Maxime Ripard <mripard@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 devicetree@vger.kernel.org, Icenowy Zheng <zhengxingda@iscas.ac.cn>,
 Simona Vetter <simona@ffwll.ch>
Subject: Re: [PATCH v4 3/5] dt-bindings: gpu: powervr-rogue: Add MediaTek
 MT8173 GPU
Message-ID: <178524973916.2137541.17965482257032885131.robh@kernel.org>
References: <20260728091804.382753-1-wenst@chromium.org>
 <20260728091804.382753-4-wenst@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260728091804.382753-4-wenst@chromium.org>
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


On Tue, 28 Jul 2026 17:18:01 +0800, Chen-Yu Tsai wrote:
> The MediaTek MT8173 comes with a PowerVR Rogue GX6250, which is one
> of the Series6XT GPUs, another sub-family of the Rogue family.
> 
> This was part of the very first few versions of the PowerVR submission,
> but was later dropped.
> 
> [1] https://lore.kernel.org/dri-devel/6eeccb26e09aad67fb30ffcd523c793a43c79c2a.camel@imgtec.com/
> 
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> ---
>  Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Applied, thanks!

