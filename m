Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73D9FC88E75
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 10:39:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B33010F3FF;
	Tue, 15 Sep 2026 10:39:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="DsvJHjde";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B7BA110F3FF
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 10:39:36 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6747A4321D;
 Tue, 15 Sep 2026 10:39:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ED021F000FF;
 Tue, 15 Sep 2026 10:39:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789468776;
 bh=tTTo1b2FHnBApOFProxdU0vyMhrX5kO/AGRkhlVKgLE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=DsvJHjde5hRHbDp8UkbkUBf8VNrGZjHlbZQwjOtedLCOrq152tR3KVyn30JdNeswi
 zw0gh56h0HBNySyqrmF/AHyqo9tF8tBVhxY+fSmMNsQa40BViuy6bbZSUIaBxKtEPM
 tWM8fMZaxcR9++ZWx7dwYk3/sJIrW/M4AhCHIbE+lm3e7K3vfEZ3eaFg/ral1jy7nl
 KSiKtGzvTpCxqYD/5JlZKGt/F+7MQaLQeCiFxScmhYoyznEQvZO8UTa28sC3IuFVtV
 hzW5dLs4PDuv7W5MwPBhYkcm2heFTLyt/A6Gw2BcHpuv14396ySS5is+Gz6v905GRb
 ylGGoMtgsWhMA==
Date: Tue, 15 Sep 2026 12:39:32 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Ryan Brue <ryanbrue.dev@gmail.com>
Cc: Nickolay Goppen <setotau@mainlining.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Alexey Minnekhanov <alexeymin@minlexx.ru>, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v3 0/3] Novatek NT51021 DSI panel IC driver
Message-ID: <20260915-funky-hot-lobster-2eeee8@quoll>
References: <20260913-qcom-novatek-nt51021-panels-v3-0-266bc5d7e8c9@mainlining.org>
 <2ac704f5-40e5-4212-8b16-6b23912ef4b8@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2ac704f5-40e5-4212-8b16-6b23912ef4b8@gmail.com>
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

On Sun, Sep 13, 2026 at 12:23:46PM -0500, Ryan Brue wrote:
> Tested-by: Ryan Brue <ryanbrue.dev@gmail.com> # Amazon Fire HD 10 (2017),
> boe,tv101wum-nm0

This tag is applicable only to one patch out of tree, so just respond
there instead of causing scripts to get this tag to all patches.

Best regards,
Krzysztof

