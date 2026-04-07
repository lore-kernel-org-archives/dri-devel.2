Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92893FF510D
	for <dri-devel@archiver.kernel.org>; Tue,  7 Apr 2026 15:58:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EAFDE10E488;
	Tue,  7 Apr 2026 15:58:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="P/A0GQAE";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A77610E488
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Apr 2026 15:58:56 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 0259543E00;
 Tue,  7 Apr 2026 15:58:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAFADC116C6;
 Tue,  7 Apr 2026 15:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1775577535;
 bh=TEBmDXZxfoylzayLoImD9f83TDN7UFj5PT/ooCHo/pE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=P/A0GQAER99pMshKDfI4+lG7NIrvoLgx5VQKDXq6M9ZrBD6cKJBjrEaP3sw5kLTxw
 WBmtHfqfzGliltFcQSEF2Gh6MhRCC58UE6Pi8rpsijqVzVriZOICTd7JZ0hTyr+j0n
 CKU0LbtsQrrbSSQzhotHWtDDqAIkPFGWVhd7BKmxyH/wRdkozoNOSvyOBhhOdqUwLP
 KqBN+Ax2LVX9gSumBPioB44snz+6aYh+b0gBgY0zlh6eZ3GZBGNMBrVB54/1DHeqsP
 Ut7WfdZy+4HL88aD1vcO56n+Kde5QMR+JphkFX6rj7PWyksqFbaBHCibP1n+yLG1wx
 3eauoVfg0o4FA==
Date: Tue, 7 Apr 2026 10:58:54 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 Neil Armstrong <neil.armstrong@linaro.org>,
 David Airlie <airlied@gmail.com>, Robert Foss <rfoss@kernel.org>,
 Adrien Grassein <adrien.grassein@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Conor Dooley <conor+dt@kernel.org>, dri-devel@lists.freedesktop.org,
 Jonas Karlman <jonas@kwiboo.se>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>
Subject: Re: [PATCH] dt-bindings: display: lt8912b: Drop redundant endpoint
 properties
Message-ID: <177557753204.2632125.5233948727561913335.robh@kernel.org>
References: <20260316134606.57070-2-krzysztof.kozlowski@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260316134606.57070-2-krzysztof.kozlowski@oss.qualcomm.com>
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


On Mon, 16 Mar 2026 14:46:07 +0100, Krzysztof Kozlowski wrote:
> The "endpoint" node references video-interfaces.yaml schema with
> "unevaluatedProperties: false" which means that all properties from
> referenced schema apply.  Listing some of them with ": true" is simply
> redundant and does not make this code easier to read.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> ---
>  .../devicetree/bindings/display/bridge/lontium,lt8912b.yaml    | 3 ---
>  1 file changed, 3 deletions(-)
> 

Applied, thanks!

