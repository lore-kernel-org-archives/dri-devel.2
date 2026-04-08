Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1394FD5F8C
	for <dri-devel@archiver.kernel.org>; Wed,  8 Apr 2026 07:10:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE05F10E55E;
	Wed,  8 Apr 2026 07:10:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="tTe/Gtjd";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0717910E541
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Apr 2026 07:10:02 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id A760F434B9;
 Wed,  8 Apr 2026 07:10:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06597C19425;
 Wed,  8 Apr 2026 07:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1775632201;
 bh=kWXdgEcmDAqUENv/9Py+CnG+l3u8cKbufZMywSmhyWg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=tTe/GtjdU7gh3w/jVqaYAKJC4Pe4nGjiN5KUYWWdwOUkUN2pCfVqZP3x+CCA2bXjN
 VQ8VP16LXoeTiplkBZ7JGQ61OqYUFuyjlz9fEZdxO49rJi7GL2G/0f1krxABrtv3XR
 Ebg1ucRL33eAfQJxbkGSApEO7mSlxpQ0OnHRLnDqbfMqIttX/aQRrzIzrdyhZzE8qa
 3w+kYDOG6kmLeFYfkXVMIXdE9SJGhgzsjLjMOp3B5mlyMl4C+pV8cN4NTbCwv8pAb0
 bd2GHIKSj46G0kkgaVy2oFE1ImESCLxxEzGbUZuK3/ST4NiHs+n6U9YDXNbh5ascOm
 J4UQsr4dmdq5g==
Date: Wed, 8 Apr 2026 09:09:59 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Aaron Kling <webgeek1234@gmail.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Teguh Sobirin <teguh@sobir.in>
Subject: Re: [PATCH v4 1/2] dt-bindings: display: panel: Add ChipWealth
 CH13726A AMOLED driver
Message-ID: <20260408-skilled-wine-bloodhound-a6e71e@quoll>
References: <20260408-ch13726a-v4-0-9bb1a9b8f329@gmail.com>
 <20260408-ch13726a-v4-1-9bb1a9b8f329@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260408-ch13726a-v4-1-9bb1a9b8f329@gmail.com>
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

On Wed, Apr 08, 2026 at 12:32:39AM -0500, Aaron Kling wrote:
> The Chip Wealth Technology CH13726A AMOLED driver is a single chip
> solution for MIPI-DSI. This is used for the AYN Thor bottom panel.
> 
> Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
> ---
>  .../display/panel/chipwealth,ch13726a.yaml         | 67 ++++++++++++++++++++++
>  1 file changed, 67 insertions(+)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

