Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36709C4451B
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 15:03:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5AE5B10F5A2;
	Fri, 17 Jul 2026 15:03:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ZaccoDxo";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9773F10F5A2
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 15:03:53 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id AD2F560204;
 Fri, 17 Jul 2026 15:03:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D8801F000E9;
 Fri, 17 Jul 2026 15:03:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784300632;
 bh=yksjHE8eEsyu5iTXNXXdmShnpRuHBDVAl4ajHQZo3CA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=ZaccoDxoOH2lcgSvu8LXxFsftHKUMQrkC0nmExHOdwO5j8SdzihKbS4RobczbJ4JZ
 uvhEPXaHr5uaQtI+xDgID3j5Z3hMwMSu6CHIE+eqP5j9SZOrxR0vp36y79n7cr02fe
 2Qr+8MsdMNhTPSMEa4LAZjuuPx2aN8bpCFfs42t+KQjuSM9KryVpc9IkxeqAHP6ww6
 EmPRYPD8nn9N5i6F1MSRMBcZsMDvZeRuLrtBMJnlPp6sSPR+wZwXMfHvfMzfLJ+gFY
 2YIg6dsjszqc+x/e98s+liB8gUlW4LmMCxXI1F0xOOW4+l2l6apPts9MowDGpizFCt
 YoQ/ScN7NGLfw==
Received: from johan by xi.lan with local (Exim 4.99.4)
 (envelope-from <johan@kernel.org>) id 1wkk6P-00000007cuh-3tow;
 Fri, 17 Jul 2026 17:03:49 +0200
Date: Fri, 17 Jul 2026 17:03:49 +0200
From: Johan Hovold <johan@kernel.org>
To: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 Thuan Nguyen <thuan.nguyen-hong@banvien.com.vn>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Robert Foss <rfoss@kernel.org>, Jonas Karlman <jonas@kwiboo.se>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 linux-renesas-soc@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 2/4] drm/bridge: display-connector: Fix I2C adapter
 resource leak
Message-ID: <alpEVeVmH5oiqmaj@hovoldconsulting.com>
References: <20260705213542.28987-1-laurent.pinchart+renesas@ideasonboard.com>
 <20260705213542.28987-3-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260705213542.28987-3-laurent.pinchart+renesas@ideasonboard.com>
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

On Mon, Jul 06, 2026 at 12:35:40AM +0300, Laurent Pinchart wrote:
> If the probe function returns an error after getting the I2C adapter for
> DDC, the reference to the adapter is never released. Fix it by releasing
> it in the bridge .destroy() handler.
> 
> There is no need to test the ddc pointer with !IS_ERR(), as
> of_get_i2c_adapter_by_node() returns NULL on error.

I stumbled over this this morning as well and posted a fix here (which
releases the adapter on driver unbind as is currently done):

	https://lore.kernel.org/lkml/20260717085716.1619275-1-johan@kernel.org/

> Fixes: 6de79dd3a920 ("drm/bridge: display-connector: add ddc-en gpio support")

I believe this issue was first introduced by commit 2e2bf3a5584d
("drm/bridge: display-connector: add DP support") a few releases
earlier.

> Cc: stable@vger.kernel.org
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Reviewed-by: Johan Hovold <johan@kernel.org>

Johan
