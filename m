Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 573CCC982F1
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 05:35:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2293810EB78;
	Tue, 22 Sep 2026 05:35:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wIsvkYIv";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C92C010EB6D
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 05:35:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5114444A58;
 Tue, 22 Sep 2026 05:35:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACE741F00893;
 Tue, 22 Sep 2026 05:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
 s=korg; t=1790055322;
 bh=ZYB+hYGCWQEfwSVJqO8SUr9ROMxy5Ef20Zm5SUiNP9Y=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=wIsvkYIvlUY9UsSJ/aW+SnrQSjbGvHJ1ZN8sNav7y7N2VK528nQsLqMr+h10YEZrs
 NH36ZRYG/n9KpCvh4jXBG9N5lSf0tOC0JKcowQwkyDRU1L7+CzXCttCA5xeFDKPXAK
 VgF7FOX7Fi3Q7q37GHcSFqB1wMaHW3X1wlYUYZyg=
Date: Tue, 22 Sep 2026 07:35:19 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Inochi Amaoto <inochiama@gmail.com>
Cc: Hans de Goede <hansg@kernel.org>, Damien Le Moal <dlemoal@kernel.org>,
 Niklas Cassel <cassel@kernel.org>, Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Minas Harutyunyan <hminas@synopsys.com>,
 Thinh Nguyen <Thinh.Nguyen@synopsys.com>, Vinod Koul <vkoul@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>,
 Damon Ding <damon.ding@rock-chips.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Heiko Stuebner <heiko@sntech.de>, linux-ide@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-usb@vger.kernel.org, linux-phy@lists.infradead.org,
 Yixun Lan <dlan@gentoo.org>, Longbin Li <looong.bin@gmail.com>
Subject: Re: [RFC PATCH 1/5] phy: core: Use EOPNOTSUPP for disabled blob
 return value
Message-ID: <2026092256-shading-gratify-835a@gregkh>
References: <20260922024724.191412-1-inochiama@gmail.com>
 <20260922024724.191412-2-inochiama@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260922024724.191412-2-inochiama@gmail.com>
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

On Tue, Sep 22, 2026 at 10:47:16AM +0800, Inochi Amaoto wrote:
> Currently, the phy subsystem uses ENOSYS for dummy blob functions,
> it does not reflect the function state correctly. As kernel already
> has EOPNOTSUPP for disabled blob function, replace ENOSYS with
> EOPNOTSUPP for a clear return value.
> 
> Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> ---
>  include/linux/phy/phy.h | 52 ++++++++++++++++++++---------------------
>  1 file changed, 26 insertions(+), 26 deletions(-)

Based on the other patches in this series, this patch now breaks the
users, right?  Shouldn't this all happen at once?

thanks,

greg k-h
