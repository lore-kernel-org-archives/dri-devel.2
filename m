Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A4BCD35153
	for <dri-devel@archiver.kernel.org>; Wed,  1 Apr 2026 07:40:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 98CBA10EF81;
	Wed,  1 Apr 2026 07:40:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="RbRLgtYF";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F68310EF99
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Apr 2026 07:40:23 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 0AA2140571;
 Wed,  1 Apr 2026 07:40:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C1B8C4CEF7;
 Wed,  1 Apr 2026 07:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1775029222;
 bh=CaHe2VUsZZDWm6ErzNKL9G35yXKCVCCCSuUqA9E9iog=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=RbRLgtYFvPHl043mICoGZscSr/N7MotX+SGIZUfXePNNzlfCYjC1vieeJmjL13L1v
 XHTOIE+lSdhB2HULMm42hT+KYQuRvNBuavSIW9yPgf8EX2zaU1zxC/XHxr/YVLAduK
 L+Xp14uT7oOuS0CV8sSwdR1auQq40uHaUs7QEFGmKlrUa9MNfwOxXOVNbbvHEgw+DR
 0ja7heziqQtqnoLP04qTWrQEr+BrbzQK7kzcj1aIz85GJK1EqHSkpEuoHwyRM+TiA7
 2OU+9/G77nACau3rxtBHs8T4UIMvZ/Ve9pIvYV0XynYU8MxrCWUd7S0cTVm08M3aCT
 jpU0c0LKOk8/w==
Date: Wed, 1 Apr 2026 09:40:20 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Guangliu Ding <guangliu.ding@nxp.com>
Cc: Daniel Almeida <daniel.almeida@collabora.com>, 
 Alice Ryhl <aliceryhl@google.com>,
 Boris Brezillon <boris.brezillon@collabora.com>, 
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, Jiyu Yang <jiyu.yang@nxp.com>
Subject: Re: [PATCH 1/2] dt-bindings: gpu: mali-valhall-csf: Document i.MX952
 support
Message-ID: <20260401-weightless-mule-of-opportunity-57f45e@quoll>
References: <20260331-master-v1-0-65c8e318d462@nxp.com>
 <20260331-master-v1-1-65c8e318d462@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260331-master-v1-1-65c8e318d462@nxp.com>
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

On Tue, Mar 31, 2026 at 06:12:38PM +0800, Guangliu Ding wrote:
> Add compatible string of Mali G310 GPU on i.MX952 board.

We see this from the diff. Say something useful.

> 
> Signed-off-by: Guangliu Ding <guangliu.ding@nxp.com>
> Reviewed-by: Jiyu Yang <jiyu.yang@nxp.com>

And the review should tell you that. Did that review even happen? That's
a v1 and a single liner patch, so how basics could be missed?

Best regards,
Krzysztof

