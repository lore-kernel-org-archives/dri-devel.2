Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28AD8CD3426
	for <dri-devel@archiver.kernel.org>; Sun,  3 May 2026 12:07:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2AC6310E287;
	Sun,  3 May 2026 12:07:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="bmLof78T";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4DF3210E287
 for <dri-devel@lists.freedesktop.org>; Sun,  3 May 2026 12:07:42 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 6C84160120;
 Sun,  3 May 2026 12:07:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E19DC2BCB4;
 Sun,  3 May 2026 12:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777810061;
 bh=S1ZDXwLMdOnrl1x1Iy1fhJkLXM0JoajWaEYKLKB7tXg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=bmLof78TqsmBJvQmFkeFMCn2WoMY3grYESBFq/kvT55NNgIb8750IuZDnuz+P9k8+
 OV8Qqi/KpwDq57W13bQv3TIz5Nknonca0odvP0rpad6FRAKfDKBh9976OCHuAamiGf
 9bFhRnLoYA6WLcpdI2myYNYmTl8F6dNddSuh9TPcCisFa3huFzilQxCDj08kjxj2zj
 lY9/nCY6nwlC6BG45stedbCdRg1k8cHQfHqZ+fARUEgw+p6DWPwQNwHWRM7XERNG/Y
 QXNyQFghGFAcVRP4OThnAw64f9dCbPNW2WF+xOg7LAe6gVp0uoYYOnEUN6BTGEMHYt
 aXcBMfE+AmVEQ==
Date: Sun, 3 May 2026 14:07:38 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: syyang@lontium.com
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
 andrzej.hajda@intel.com, neil.armstrong@linaro.org,
 dmitry.baryshkov@oss.qualcomm.com, 
 maarten.lankhorst@linux.intel.com, rfoss@kernel.org, mripard@kernel.org, 
 Laurent.pinchart@ideasonboard.com, tzimmermann@suse.de, jonas@kwiboo.se,
 jernej.skrabec@gmail.com, 
 devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, 
 yangsunyun1993@gmail.com, xmzhu@lontium.corp-partner.google.com,
 xmzhu@lontium.com, rlyu@lontium.com, xbpeng@lontium.com
Subject: Re: [PATCH v4 1/2] dt-bindings: bridge: Add Lontium LT7911EXC eDP to
 MIPI DSI bridge
Message-ID: <20260503-pristine-ibex-of-assurance-0c27e0@quoll>
References: <20260430094612.3408174-1-syyang@lontium.com>
 <20260430094612.3408174-2-syyang@lontium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260430094612.3408174-2-syyang@lontium.com>
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

On Thu, Apr 30, 2026 at 05:46:11PM +0800, syyang@lontium.com wrote:
> From: Sunyun Yang <syyang@lontium.com>
> 
> The LT7911EXC is an I2C-controlled bridge that Receiver eDP1.4
> and output signal/dual port mipi.
> 
> Signed-off-by: Sunyun Yang <syyang@lontium.com>
> ---
>  .../display/bridge/lontium,lt7911exc.yaml     | 89 +++++++++++++++++++
>  1 file changed, 89 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/bridge/lontium,lt7911exc.yaml

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

