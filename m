Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CAF7C43458
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 06:56:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9377710E58A;
	Fri,  3 Jul 2026 06:56:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Ho6F8U8R";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A2A610E58A
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 06:56:57 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A5F7E40B92;
 Fri,  3 Jul 2026 06:56:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C18001F000E9;
 Fri,  3 Jul 2026 06:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783061816;
 bh=8faICAmC21GgbYq0rQFfkuCIrtptkFcUCzeneJOMRt4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=Ho6F8U8RS19eb9osi3eZZg4erE8Ya7LQbf44Ie1EnFjkL9jI8jlj48X1ryrOxk3ow
 xoWBTa3GZetolR1L88jWafOzFFJiKf8fIhZujRk56I95xAqBUjXn0YKMt16hANmGpw
 /nYyv8EqMM4LU4TaO3BfiQcZ1fvl7pITKNaLz5JUF4QTJcGgddZWtEqyRA4SCxWdVB
 iyKsmIh2LcjZ7pThF8p9uwIltAaUiDErjdbhfw51Rb/Ib19mBrRCCjsOviz/Agl6s8
 x8iqLgWqDbzj6GtUzMZ96IH53SQJeNd4QkoGIiFEeLSN/bOpxtfavfBmBTrA77IW3V
 jb72a3W9C17bg==
Date: Fri, 3 Jul 2026 08:56:52 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Mikko Perttunen <mperttunen@nvidia.com>
Cc: Thierry Reding <thierry.reding@kernel.org>, 
 Jonathan Hunter <jonathanh@nvidia.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, linux-tegra@vger.kernel.org,
 dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] dt-bindings: display: tegra: Make non-vm
 registers optional
Message-ID: <20260703-hysterical-umber-cricket-3080da@quoll>
References: <20260702-host1x-nohv-v2-0-e6d88bac0af6@nvidia.com>
 <20260702-host1x-nohv-v2-1-e6d88bac0af6@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260702-host1x-nohv-v2-1-e6d88bac0af6@nvidia.com>
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

On Thu, Jul 02, 2026 at 01:10:26PM +0900, Mikko Perttunen wrote:
> The hypervisor and common register regions are not always available to
> the software -- usually when a separate hypervisor keeps ownership of
> them and only passes through the vm register region to a virtual
> machine.
> 
> Adjust the bindings to make these regions optional to allow describing
> the situation in device trees for such virtual machines et cetera.
> 
> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
> ---
>  .../display/tegra/nvidia,tegra20-host1x.yaml       | 40 ++++++++++++++--------
>  1 file changed, 26 insertions(+), 14 deletions(-)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

