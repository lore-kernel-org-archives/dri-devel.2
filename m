Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55F14CA5FA5
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 13:30:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9942210EEBD;
	Tue, 29 Sep 2026 13:30:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="RIuUtXQ7";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B66310EEBD
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 13:30:25 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A8AF3412E7;
 Tue, 29 Sep 2026 13:30:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67FB61F00893;
 Tue, 29 Sep 2026 13:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790688624;
 bh=YddyNBlBeMGDVbqSqWAWeupeImPN1+vt/HIPaYWlt0Y=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=RIuUtXQ7pN1ntHH5E9SHtFiVxk4VlC3Lx05nbDdqWgnrCoGrr5Kaw9EB3EurZOqnd
 ver7PIljjQDwRadvVv/c0J+hSkjXNlJWDffpZQLU4o93+0nCvAAl0Ux4SYrhGz087x
 /Em+ZWodHWV8OvgVNkTQErGD8adcsGYl1RKaedB7Hpt6DTY+b0QeVKsaMmFWtR0wIy
 1brTzz3b1fmLHV899/10+jQutIesNgOTsfOa5laHgSWmjnUC6CSWuXFwsRIMHGnLYv
 HGMSS19MSaUoKNmt7xqQq6t+vM1Gswc7Xht5EjiEDmf4hpi5r6Q6EcIVHkhsOwMVNz
 JNZ4Kdafpc/Lw==
Message-ID: <45963e29-f896-4e67-87ee-ac90131773e2@kernel.org>
Date: Tue, 29 Sep 2026 15:30:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] phy: core: Use EOPNOTSUPP for disabled blob return value
To: Inochi Amaoto <inochiama@gmail.com>, Hans de Goede <hansg@kernel.org>,
 Niklas Cassel <cassel@kernel.org>, Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Minas Harutyunyan <hminas@synopsys.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Thinh Nguyen <Thinh.Nguyen@synopsys.com>, Vinod Koul <vkoul@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>,
 Damon Ding <damon.ding@rock-chips.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Heiko Stuebner <heiko@sntech.de>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-usb@vger.kernel.org,
 linux-phy@lists.infradead.org, Yixun Lan <dlan@gentoo.org>,
 Longbin Li <looong.bin@gmail.com>
References: <20260929084739.467082-1-inochiama@gmail.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20260929084739.467082-1-inochiama@gmail.com>
Content-Type: text/plain; charset=UTF-8
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

On 2026/09/29 10:47, Inochi Amaoto wrote:
> Currently, the phy subsystem uses ENOSYS for dummy blob functions,
> it does not reflect the function state correctly. As kernel already

s/function state/hardware capability ?

s/As kernel/As the kernel

> has EOPNOTSUPP for disabled blob function, replace ENOSYS with

What is "blob function" ? Are you talking about all the phy_xxx() functions?

> EOPNOTSUPP for a clear return value. Also adapt the return value
> changed in the following affect file:

s/affect/affected

> - ata/libahci_platform.c
> - drm/bridge/analogix/analogix_dp_core.c
> - usb/dwc2/platform.c
> - usb/dwc3/core.c
> 
> Signed-off-by: Inochi Amaoto <inochiama@gmail.com>

The ata bits looks OK, but this still feels like a lot of churn for no
functional change since the error is an internal one that is not exposed to the
user, as far as I can tell. The code in many places also uses -ENODEV, so the
error returned does not seem to be consistent anyway.

-- 
Damien Le Moal
Western Digital Research
