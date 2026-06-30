Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F665C43458
	for <dri-devel@archiver.kernel.org>; Tue, 30 Jun 2026 09:54:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D6DB10EBED;
	Tue, 30 Jun 2026 09:54:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="b9jRyp0F";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4530010EBF0
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 09:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782813292; x=1814349292;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=yFdNZwVFhbbRd/mn/WFs5v2ropeqaVxom/v/MdhKyJ0=;
 b=b9jRyp0FvKLiUwvqF0klS3sZ02dI6OCC3TxkAYkBll5ww/iHjwwjft7X
 cDETrjSAwcLpe74AedeEaOYWt/4bnkW8Pge44enh6gSjQ1yKj41E7GhlO
 hD0JKYOG8Fjrh5sQ0fE9yUXLSbsDLMIb10kX0xwLPqHYuXGSd0+1rgAv2
 KvQGcJqQ9ieCR14LXTtCKr6+OpFgVaT+nxnmuymp/vDeEFgyNwrSdAwou
 bU9ugaQZ8Uzdit1RcP89DLjX1lTFKVPsIPbBV7J8zXya28sgQtN8zna81
 PHEae/EAE5AB8BRxZuVcP6HJhUG8uP80Ye2yY9z79EpEgKUcUNwv9tZlS g==;
X-CSE-ConnectionGUID: X4C0joX5SGmRik6MSHXWrw==
X-CSE-MsgGUID: 3VIsjMdQSqmKX88pR+933w==
X-IronPort-AV: E=McAfee;i="6800,10657,11832"; a="94121333"
X-IronPort-AV: E=Sophos;i="6.24,233,1774335600"; d="scan'208";a="94121333"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jun 2026 02:54:52 -0700
X-CSE-ConnectionGUID: 0hz0Ybo9T4ahdiG68gNfsA==
X-CSE-MsgGUID: wmd5dzvtSaeoUTNv7c+DrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,233,1774335600"; d="scan'208";a="254135822"
Received: from black.igk.intel.com ([10.91.253.5])
 by fmviesa004.fm.intel.com with ESMTP; 30 Jun 2026 02:54:44 -0700
Received: by black.igk.intel.com (Postfix, from userid 1008)
 id 6175195; Tue, 30 Jun 2026 11:54:43 +0200 (CEST)
Date: Tue, 30 Jun 2026 12:54:41 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Chaoyi Chen <chaoyi.chen@rock-chips.com>
Cc: Xu Yang <xu.yang_2@oss.nxp.com>, Chaoyi Chen <kernel@airkyi.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Peter Chen <hzpeterchen@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>,
 Heiko Stuebner <heiko@sntech.de>, Sandy Huang <hjc@rock-chips.com>,
 Andy Yan <andy.yan@rock-chips.com>,
 Yubing Zhang <yubing.zhang@rock-chips.com>,
 Frank Wang <frank.wang@rock-chips.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Amit Sunil Dhamne <amitsd@google.com>,
 Dragan Simic <dsimic@manjaro.org>, Johan Jonker <jbx6244@gmail.com>,
 Diederik de Haas <didi.debian@cknow.org>,
 Peter Robinson <pbrobinson@gmail.com>,
 Hugh Cole-Baker <sigmaris@gmail.com>, linux-usb@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-phy@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v15 1/9] drm/bridge: Implement generic USB Type-C DP HPD
 bridge
Message-ID: <akOSYXV7zRY4inSo@kuha>
References: <20260304094152.92-1-kernel@airkyi.com>
 <20260304094152.92-2-kernel@airkyi.com>
 <erx73m2ueuvbzjteadjli6aki5by4pr3hyertkkqqoqwhaa4v3@5cstmshcercx>
 <56c6abb8-c127-449f-9368-12f94620c2bc@rock-chips.com>
 <k53t2soc3nxhwugncatksektig6agxfgdkogkdwbhrhu2fn2g7@auvsfrv76wxy>
 <b2633b22-da30-4778-8e23-7b5bed9ead07@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b2633b22-da30-4778-8e23-7b5bed9ead07@rock-chips.com>
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

> @Heikki, what do you think of the following change?
> Should we add a new patch for this? Thanks.
> 
> diff --git a/drivers/usb/typec/altmodes/Kconfig b/drivers/usb/typec/altmodes/Kconfig
> index 7867fa7c405d..f89cdf3c949b 100644
> --- a/drivers/usb/typec/altmodes/Kconfig
> +++ b/drivers/usb/typec/altmodes/Kconfig
> @@ -5,6 +5,7 @@ menu "USB Type-C Alternate Mode drivers"
>  config TYPEC_DP_ALTMODE
>         tristate "DisplayPort Alternate Mode driver"
>         depends on DRM
> +       select DRM_AUX_HPD_BRIDGE 
>         help
>           DisplayPort USB Type-C Alternate Mode allows DisplayPort
>           displays and adapters to be attached to the USB Type-C

This look good to me. Please do add the patch for this.

thanks,

-- 
heikki
