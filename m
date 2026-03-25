Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9845109C05D
	for <dri-devel@archiver.kernel.org>; Wed, 25 Mar 2026 21:34:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 02F2210E1F6;
	Wed, 25 Mar 2026 21:34:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="qPCbvz/U";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D61AB10E1F6
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 21:34:38 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 21EF54449B;
 Wed, 25 Mar 2026 21:34:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3182C4CEF7;
 Wed, 25 Mar 2026 21:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1774474478;
 bh=h5PQt8p/yxquAUwPbpbYrT2NXIJf9oAgbbhuwKf/o6Q=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=qPCbvz/UNypttFd6ULgtJFnr09wkA1QKODTctLZ5Qq6zHMBmJ4Pey0OIbHdbOduV+
 xcNsbR9Zff+menLwfg66rlbkF4X1LzdmsEFxgqnJvt5qkLFcVceKDf7ozkB4PXicpe
 5AH9SNkv7ffkK50HQc/yEbxVPDfix4nUvGdw2DltWLVWyHWVih9pe03TuKit6/6lNb
 b+jY8A7IvXEg78zj7xwSWw59VHMYolRLPdJgkvP2wzpNpAf8Jsmqcnyh05Xh725esv
 dKAeowEsr5qkweTrIvWTo65xmnZgQx+F4Dd6cIWYTuQ6OwAZ9wKybnnOqTCOWlxMrc
 RufHR23wqhAGg==
Date: Wed, 25 Mar 2026 16:34:36 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Venkata Gopi Nagaraju Botlagunta <venkata.botlagunta@oss.qualcomm.com>
Cc: Robert Foss <rfoss@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>,
 Marek Vasut <marex@denx.de>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
 Maxime Ripard <mripard@kernel.org>,
 David Airlie <airlied@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Nilesh Laad <nilesh.laad@oss.qualcomm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Simona Vetter <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>,
 jessica.zhang@oss.qualcomm.com, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 linux-kernel@vger.kernel.org, Thomas Zimmermann <tzimmermann@suse.de>,
 venkata.valluru@oss.qualcomm.com, Yi Zhang <zhanyi@qti.qualcomm.com>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v5 1/2] dt-bindings: display: bridge: lontium, lt9211: Add
 lt9211c support
Message-ID: <177447447542.4149755.9655940024257618231.robh@kernel.org>
References: <20260323-add-lt9211c-bridge-v5-0-9c63bb035c17@oss.qualcomm.com>
 <20260323-add-lt9211c-bridge-v5-1-9c63bb035c17@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260323-add-lt9211c-bridge-v5-1-9c63bb035c17@oss.qualcomm.com>
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


On Mon, 23 Mar 2026 12:38:52 +0530, Venkata Gopi Nagaraju Botlagunta wrote:
> From: Yi Zhang <zhanyi@qti.qualcomm.com>
> 
> Add binding for the Lontium LT9211C bridge chip.
> 
> Signed-off-by: Yi Zhang <zhanyi@qti.qualcomm.com>
> Signed-off-by: Nilesh Laad <nilesh.laad@oss.qualcomm.com>
> Signed-off-by: Gopi Botlagunta <venkata.botlagunta@oss.qualcomm.com>
> ---
>  Documentation/devicetree/bindings/display/bridge/lontium,lt9211.yaml | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

