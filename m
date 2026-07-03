Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 924BAC43458
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 07:09:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E21C010F692;
	Fri,  3 Jul 2026 07:09:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="CeP4x5xk";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 174C010F692
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 07:09:10 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D4B9A404CC;
 Fri,  3 Jul 2026 07:09:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89E661F000E9;
 Fri,  3 Jul 2026 07:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783062549;
 bh=xA4tp0AYCPRAwSPcdD763FW0RlPsGKuoE+okmKkXUHg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=CeP4x5xkzXbGC++vIZQtQ21RqEDAAgQ/VnnJOyOvs7Qk9dT276p/aQ7YkVa5xtxF5
 +rPSB5Jb3GqjoASBp4Dcnp04Qk8lrBFoOAQw1T8Wvx7s4c2420a3hMrpVJ4hXddTMx
 8M6m3ea62qFVFH87ev8/hPvA123M+ccxiUhaBSycbFMaDSIjvekjlSqL6BEEVWLprn
 qRq5RrKW58b98uQt5wkEP84UXbXUqgLWcqbgMv/1UIKEWfGbtFWn9Ga0bPfwkjImyR
 KOUzJiGsSxmLX4BR2u4cwqCvieTpLOe5/N7fuoEQHiCU+eMkhxhTd+iAGzHyKatzpt
 v+2p2YiLeAo4A==
Date: Fri, 3 Jul 2026 09:09:05 +0200
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
Subject: Re: [PATCH v2 2/4] dt-bindings: display: tegra: Add
 channel/syncpoint range properties
Message-ID: <20260703-traditional-beige-flamingo-d5003c@quoll>
References: <20260702-host1x-nohv-v2-0-e6d88bac0af6@nvidia.com>
 <20260702-host1x-nohv-v2-2-e6d88bac0af6@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260702-host1x-nohv-v2-2-e6d88bac0af6@nvidia.com>
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

On Thu, Jul 02, 2026 at 01:10:27PM +0900, Mikko Perttunen wrote:
> All of the resources implemented by Host1x hardware may not be available
> to the software in cases where those resources are assigned to other vm
> partitions through the hypervisor register region.
> 
> Add properties nvidia,channels and nvidia,syncpoints to specify the
> range of resources that are accessible by this partition / virtual
> machine.
> 
> The hypervisor or bootloader that configures the partitioning in the
> hypervisor register region is responsible for updating the values of
> these properties in accordance to the configuration.
> 
> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
> ---
>  .../bindings/display/tegra/nvidia,tegra20-host1x.yaml        | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-host1x.yaml b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-host1x.yaml
> index ffd0ed857d28..a6bef28e8559 100644
> --- a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-host1x.yaml
> +++ b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-host1x.yaml
> @@ -96,6 +96,18 @@ properties:
>      items:
>        - description: phandle to the HEG or core power domain
>  
> +  nvidia,channels:
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    minItems: 2
> +    maxItems: 2
> +    description: Describes range of usable Host1x channels as a <base count> tuple.

Pasting my reply just now from v1:

Property has only one meaning in DT schema, so basically you are now
fixing nvidia,channels to uint32-array for all possible use cases and
nvidia devices. Well, you have been warned.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

