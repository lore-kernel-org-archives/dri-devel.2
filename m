Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CFD6CD4F39
	for <dri-devel@archiver.kernel.org>; Thu, 14 May 2026 12:01:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD08C10E3E5;
	Thu, 14 May 2026 12:01:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ZNH/P0/1";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D4C8410E3E5
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 12:01:32 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 80FA34079A;
 Thu, 14 May 2026 12:01:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFB5AC2BCB8;
 Thu, 14 May 2026 12:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778760092;
 bh=cDzJLSWXKBK3yhL4X7j9TNlyzu5oMWNYXLARIumVm8I=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ZNH/P0/19SdLtkSwljWdUbMme9P0vOAw3gNrcNjaElXtMfzOz1pQI694D/GiWheci
 Xm1pjHJmcpzLkNEUXDU7DeZK3/Pf9Y62hQwMOkwXzLZNxK15wjN847tQdEkTLtN4wu
 q9j9nWYvq3pXNCXvtHGGFj0YQn9tFlKadIiLSk4Le7om1qBqR6mQ6dQSHIFgnPA91x
 d8TypGmXEM86cKBSLyxsCj8Q7gej+U4Ga0aRayWEh99W1HsMlYKkUDHVW1Y1+k7MZe
 MKcp6nwllEzefUtDk9BhTUcfrZ0KZjHBVRCHRYYHG1DkC4NzmWsD5Tf+XSkeWBVGG8
 5WfDe7s3Ez36w==
Date: Thu, 14 May 2026 14:01:29 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: wens@csie.org, samuel@sholland.org, mripard@kernel.org, 
 maarten.lankhorst@linux.intel.com, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 mturquette@baylibre.com, 
 sboyd@kernel.org, dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH v2 5/8] dt-bindings: display: allwinner: Add DE33 planes
Message-ID: <20260514-impetuous-solemn-sambar-acca3c@quoll>
References: <20260509190015.79086-1-jernej.skrabec@siol.net>
 <20260509190015.79086-6-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260509190015.79086-6-jernej.skrabec@siol.net>
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

On Sat, May 09, 2026 at 09:00:12PM +0200, Jernej Skrabec wrote:
> From: Jernej Skrabec <jernej.skrabec@gmail.com>
> 
> Allwinner Display Engine 3.3 contains planes, which are shared resources
> between all mixers present in SoC. They can be assigned to specific
> mixer by using registers which reside in display clocks MMIO.
> 
> Add a binding for them.
> 
> Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
> ---
> Changes from v1:
> - dropped | for description
> - better description for allwinner,plane-mapping

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

