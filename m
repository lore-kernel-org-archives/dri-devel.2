Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E9EDCDB47F
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 08:34:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B15D510F1B2;
	Thu, 25 Jun 2026 08:34:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="mIpmk87a";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 605BB10F1B2
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 08:34:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9F0AC60218;
 Thu, 25 Jun 2026 08:34:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A9D11F000E9;
 Thu, 25 Jun 2026 08:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782376462;
 bh=jkHuq+aWcDX/8nA6BwwAfyDf2vD4pL0yEgIxFBKGs4M=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=mIpmk87a1O17ZA9QaCQ4gygtPORIjx/LUMWppLF46QEB/E92hIl9n9YoMQAGkiQTO
 MSIanUm5GcOG6+cjVln91x43uf38AWaelLpXm08dCRypqsY5rMywlzaM0VwL4H78aY
 rM5KwlB20YNllXLWoipxxXxaQQrDxkMqLxwSV63yDebROFUmPdFcrXvl5dR7p2Vgsn
 ugmrsEqOhmTBY9C+rrv71jgzJIE5EcOHbYyEGyEntlrVQVlMSDvrZSzODg1nZnggNq
 V6h9jbfWjIixxbc1103eQtnD1i1LXUjfXh6lfa2j4nVSn9Fg8APyDsPRAiLf1o0a6u
 d21pPb44bSRoQ==
Date: Thu, 25 Jun 2026 10:34:18 +0200
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
Subject: Re: [PATCH 1/4] dt-bindings: display: tegra: Make non-vm registers
 optional
Message-ID: <20260625-hospitable-antelope-of-diversity-f3456d@quoll>
References: <20260622-host1x-nohv-v1-0-65bc682a617f@nvidia.com>
 <20260622-host1x-nohv-v1-1-65bc682a617f@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260622-host1x-nohv-v1-1-65bc682a617f@nvidia.com>
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

On Mon, Jun 22, 2026 at 05:22:50PM +0900, Mikko Perttunen wrote:
> Host1x can be used without accessing the hypervisor or common
> registers. Adjust the bindings to make them optional.

You still have these registers in the hardware, so it is not optional,
not flexible. IOW, DTS represents the view of real hardware for the
software, and that hardware still has this address space regardless if
OS should use it or not.

Otherwise you need to provide better background here.

Best regards,
Krzysztof

