Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F4E0CD8C92
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 08:04:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E049810EEA9;
	Mon,  8 Jun 2026 08:04:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="FnxDpAJ/";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 758F610EEA9
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 08:04:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5E75B44235;
 Mon,  8 Jun 2026 08:04:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4772C1F00893;
 Mon,  8 Jun 2026 08:04:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780905862;
 bh=KQutdxs5ADBqnbY26X9NSt2Xu29A9zHjMopO7CrzVvs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=FnxDpAJ/fzH3vBmTSSmFSZW4zYebelDfI+A4HSSarhGjZYymI7KdNH1XWzoNx56zT
 JC9bcRIe/E6AVk9vnGZLq7jzpBRAGgAW3e1UL3B2mpeKpdr8Nwl9mflyfm7KXpIV36
 ZGe4IJubvicboOcu74Z71TzKOB6LA3wWjkvF30YP7Npzqn9jJdICkvLQseOb4qQpud
 9RNakVBmWJqPF6kntd4nfXIF4o+eAhnu+K+qEF4W3JU4wdSsMF/HtDa2OXztfxWyyd
 ZzQahvsdnp/IdTPiOI2WIFV/yXeu5FT4FYbyBajnwjHcffFKX2BK0Tq3R1HpYFosc/
 pOetpQz/LZFKg==
Date: Mon, 8 Jun 2026 10:04:18 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Yijie Yang <yijie.yang@oss.qualcomm.com>
Cc: Srinivas Kandagatla <srini@kernel.org>, 
 Amol Maheshwari <amahesh@qti.qualcomm.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: misc: qcom,fastrpc: Add Maili FastRPC
 compatible
Message-ID: <20260608-elite-dandelion-goshawk-bd5acc@quoll>
References: <20260602-fastrpc-v2-1-67a55e22427b@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260602-fastrpc-v2-1-67a55e22427b@oss.qualcomm.com>
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

On Tue, Jun 02, 2026 at 02:51:08PM +0800, Yijie Yang wrote:
> Document compatible string for the FastRPC interface on the Qualcomm Maili
> SoC, which is compatible with the Qualcomm Kaanapali FastRPC and can
> fallback to Kaanapali.
> 
> Signed-off-by: Yijie Yang <yijie.yang@oss.qualcomm.com>

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

