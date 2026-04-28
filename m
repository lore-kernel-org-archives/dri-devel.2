Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F731FF885A
	for <dri-devel@archiver.kernel.org>; Tue, 28 Apr 2026 07:39:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BBB4810EA39;
	Tue, 28 Apr 2026 07:39:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="bShYofMU";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3607910EA39
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 07:39:32 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 5AAB760180;
 Tue, 28 Apr 2026 07:39:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7F0AC2BCAF;
 Tue, 28 Apr 2026 07:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777361971;
 bh=UFT+K+PDKPQSW0ONxvQCutLaWbCpyvSTzbi8Whq8mPE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=bShYofMUEgHChAVhaCcjQFFVgyZWdN4ny9wml6VJ9NagtD2bvpBe6gwZRX3YZ1vU0
 jB3gm1MxC0UOYCYWEGk6DZb20/dT5oRqt1qbwsGvPRFbQlsepg5Xk82F3SfSSLs6Mf
 nfcW2yY2SFs5Iix37V5C+sdPzlaS+4UldHy2nLPa7MaaPM2LrTV5G6VrWyqA7GNSsh
 GRLT0NN3j0qktHbDy2n1QhCE3SYVgfqt3dvQv1wN+UZqlUBbUXe/YdKaT1WoTKDraD
 RgIDpI5jJRepIYLHZlj74asvqeWQg4d9haEZdx56mjcHYHuWUeqi78CSZ5sQ5+YmD/
 b3c+B4zRd0TxQ==
Date: Tue, 28 Apr 2026 09:39:28 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: William Bright <william.bright@imd-tec.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: display: panel: Add TSD TST070WSBE-196C
 panel
Message-ID: <20260428-misty-tuatara-of-downpour-0ad6eb@quoll>
References: <20260427-imdt-dsi-display-v1-0-bb2768de120b@imd-tec.com>
 <20260427-imdt-dsi-display-v1-1-bb2768de120b@imd-tec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260427-imdt-dsi-display-v1-1-bb2768de120b@imd-tec.com>
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

On Mon, Apr 27, 2026 at 04:21:09PM +0100, William Bright wrote:
> +---
> +$id: http://devicetree.org/schemas/display/panel/tsd,tst070wsbe-196c.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: TSD TST070WSBE-196C 7" 1024x600 MIPI-DSI TFT LCD panel
> +
> +maintainers:
> +  - William Bright <william.bright@imd-tec.com>
> +
> +description: |

Do not need '|' unless you need to preserve formatting.

No need to resend just for that.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

