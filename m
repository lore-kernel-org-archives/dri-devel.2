Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BB67C5CFC1
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 08:22:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C694A10E6CC;
	Mon, 17 Aug 2026 08:21:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="HhYY6moW";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E5AA10E6C3
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 08:21:58 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1B406600AE;
 Mon, 17 Aug 2026 08:21:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ED421F000E9;
 Mon, 17 Aug 2026 08:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786954916;
 bh=Ef0ua4Ttfoj+asp7ypW4wkTI0YANY/GvBEggsgUakx4=;
 h=Date:From:To:Subject:In-Reply-To:References:Cc;
 b=HhYY6moWpOOtjBnpTs18KKJW/nf4ROvXVN5+6wQjPzWzyjgeoo3TSqvDsbscsXRYd
 RUaXwbkkkG3iFIJX1ZqZktJDixHSvVNs5pGc1veNoQW7AfW0pVp3EMBoWQPud9xz9a
 8aWksD7r5eRvOyf44m1RZfrK/ZXx+F0ysJGv6WC3V1ondaAyJ7kk40vO0uq5fyJdn1
 Q8KR6CSloHuFdPhLhQ45OJrfuN/yJvUKuBV+eyafulRg0AmK8zXMquqprFOoGklZoZ
 EQ5m0+0UvJFacwvsmwaTrG0CGDWpBr2wm3hTS9bfOoYfPPw1I0JV5x/06ihiw87gN4
 Xkfd048D4Znwg==
Message-ID: <7fb00bfaa9eceb30eda8c0ad37f4a9e4@kernel.org>
Date: Mon, 17 Aug 2026 08:21:54 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
Subject: Re: [PATCH 01/11] drm: of: drm_of_find_panel_or_bridge: simplify
 freeing the remote node pointer
In-Reply-To: <20260814-drm-bridge-every-panel-v1-1-19cd5277cc8d@bootlin.com>
References: <20260814-drm-bridge-every-panel-v1-1-19cd5277cc8d@bootlin.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, "Andrzej
 Hajda" <andrzej.hajda@intel.com>, "David Airlie" <airlied@gmail.com>, "Dmitry
 Baryshkov" <dmitry.baryshkov@oss.qualcomm.com>,
 "Hui Pu" <Hui.Pu@gehealthcare.com>, "Ian
 Ray" <ian.ray@gehealthcare.com>, "Inki Dae" <inki.dae@samsung.com>, "Jagan
 Teki" <jagan@amarulasolutions.com>, "Jernej Skrabec" <jernej.skrabec@gmail.com>,
 "Jessica
 Zhang" <jesszhan0024@gmail.com>, "Jonas Karlman" <jonas@kwiboo.se>, "Laurent
 Pinchart" <Laurent.pinchart@ideasonboard.com>,
 "Linus Walleij" <linusw@kernel.org>, "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>,
 "Marek Szyprowski" <m.szyprowski@samsung.com>, "Maxime
 Ripard" <mripard@kernel.org>, "Neil Armstrong" <neil.armstrong@linaro.org>,
 "Robert
 Foss" <rfoss@kernel.org>, "Simona Vetter" <simona@ffwll.ch>, "Thomas
 Petazzoni" <thomas.petazzoni@bootlin.com>,
 "Thomas Zimmermann" <tzimmermann@suse.de>
Content-Transfer-Encoding: 7bit
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

On Fri, 14 Aug 2026 16:05:49 +0200, Luca Ceresoli wrote:
> In prepataion to further modify the logic of this function, simplify
> putting the struct device_node pointer by using a cleanup action.
> 
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

Reviewed-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime
