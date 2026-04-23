Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FE7CF99351
	for <dri-devel@archiver.kernel.org>; Thu, 23 Apr 2026 09:10:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC35C10E0C5;
	Thu, 23 Apr 2026 09:10:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="SqTMHQd5";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EDB7B10E0C5
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 09:10:00 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id BEEB160121;
 Thu, 23 Apr 2026 09:09:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9172C2BCAF;
 Thu, 23 Apr 2026 09:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1776935399;
 bh=LmEOVucW+Da6ZRyIF5c12slqN1lpENa4Yxr82bUq+sg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=SqTMHQd5JAnCugsjSK82RslXfQzaU71nkjNL9oITexV5FZci65YjnPt0hcpDVPVHT
 LlZwocrpev4joM4Z6gBcU/um31bHVP7TKS3LBGpEHaLyeGp2cCIBCI4RxlQ1JXlZwS
 txzKbKJ9SJ4m15z8w64BwXbvN/kIZCuwwlWE43CTSbx10uwHqddX5SVpQW2CDG2Oea
 QfWkEJ2H93hUV19C6PBmU+PJk5krFzAYuxcmuMJPqztJBge2sVdgFMaHn04Q1Am6h1
 SgDyknjPbD/pU7mQeM4jqyaTnOqcUQ1Y6bA6UMxQ3fo2+41akPgbI58AiFm0L06Hna
 tI7aKj9Z8glOQ==
Date: Thu, 23 Apr 2026 11:09:56 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Marek Vasut <marex@nabladev.com>
Cc: dri-devel@lists.freedesktop.org, Kael D'Alcamo <dev@kael-k.io>, 
 Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
 Conor Dooley <conor+dt@kernel.org>, 
 David Airlie <airlied@gmail.com>, Jessica Zhang <jesszhan0024@gmail.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Rob Herring <robh@kernel.org>,
 Sam Ravnborg <sam@ravnborg.org>, 
 Simona Vetter <simona@ffwll.ch>, Thierry Reding <thierry.reding@gmail.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: vendor-prefixes: Add Displaytech Ltd.
Message-ID: <20260423-cuddly-aardwolf-of-advertising-cc43ef@quoll>
References: <20260422210806.80948-1-marex@nabladev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260422210806.80948-1-marex@nabladev.com>
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

On Wed, Apr 22, 2026 at 11:07:23PM +0200, Marek Vasut wrote:
> Add "displaytech" vendor prefix for Displaytech Ltd. .
> 
> Signed-off-by: Marek Vasut <marex@nabladev.com>

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

