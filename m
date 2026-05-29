Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10F6FCD6E50
	for <dri-devel@archiver.kernel.org>; Fri, 29 May 2026 15:18:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 707811120C6;
	Fri, 29 May 2026 15:18:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="hgKzm/J0";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id B24B91120C6;
 Fri, 29 May 2026 15:18:50 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E040533EA;
 Fri, 29 May 2026 08:18:44 -0700 (PDT)
Received: from [10.57.26.238] (unknown [10.57.26.238])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 344383FAF5;
 Fri, 29 May 2026 08:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1780067929; bh=ivH/tOTm/MtMLHtuPvnKIKXI+O+0zuzXiqnxkcFsMmE=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=hgKzm/J08GPu32rvNURHQPhQwqlHMLKWK4g2wPk8wMNuhs71nZMwvNEJyknB3aS2H
 RDly5a1sZ0p9v8fYAphU9hEH69x6Yv9Y5lB3vnOvnFJKqUL70mcwOzn3FaKAE9NLJY
 6x9k9XotjJ05gFG+GuGAGAWkFy4+jAXBKaAYFRYY=
Message-ID: <1f0527d4-1dfb-432b-8d0e-06e99a94f638@arm.com>
Date: Fri, 29 May 2026 16:18:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 07/10] thermal/of: Add cooling device ID support
To: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>, rafael@kernel.org,
 daniel.lezcano@kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Lucas Stach <l.stach@pengutronix.de>,
 Russell King <linux+etnaviv@armlinux.org.uk>,
 Christian Gmeiner <christian.gmeiner@gmail.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Guenter Roeck <linux@roeck-us.net>, Joel Stanley <joel@jms.id.au>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 Benson Leung <bleung@chromium.org>, =?UTF-8?Q?Pali_Roh=C3=A1r?=
 <pali@kernel.org>, Avi Fishman <avifishman70@gmail.com>,
 Tomer Maimon <tmaimon77@gmail.com>, Tali Perry <tali.perry1@gmail.com>,
 Patrick Venture <venture@google.com>, Nancy Yuen <yuenn@google.com>,
 Benjamin Fair <benjaminfair@google.com>, Heiko Stuebner <heiko@sntech.de>,
 Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Amit Daniel Kachhap <amit.kachhap@gmail.com>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Amit Kucheria
 <amitk@kernel.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hwmon@vger.kernel.org,
 "moderated list:DRM DRIVERS FOR VIVANTE GPU IP"
 <etnaviv@lists.freedesktop.org>,
 "open list:DRM DRIVERS FOR VIVANTE GPU IP" <dri-devel@lists.freedesktop.org>
References: <20260526140802.1059293-12-daniel.lezcano@oss.qualcomm.com>
 <20260526140802.1059293-19-daniel.lezcano@oss.qualcomm.com>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20260526140802.1059293-19-daniel.lezcano@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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



On 5/26/26 15:08, Daniel Lezcano wrote:
> Introduce an identifier (cdev_id) for cooling devices registered from
> device tree.
> 
> This prepares support for a new DT binding where cooling devices are
> identified by a tuple (device node, ID), instead of relying on child
> nodes.
> 
> Existing users are updated to pass a default ID of 0, preserving the
> current behavior.
> 
> Future changes will extend the cooling map parsing to match cooling
> devices based on both the device node and the ID.
> 
> No functional change intended.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
> ---
>   drivers/gpu/drm/etnaviv/etnaviv_gpu.c |  5 +++--
>   drivers/thermal/cpufreq_cooling.c     |  2 +-
>   drivers/thermal/cpuidle_cooling.c     |  2 +-
>   drivers/thermal/devfreq_cooling.c     |  2 +-
>   drivers/thermal/thermal_of.c          | 14 ++++++++------
>   include/linux/thermal.h               |  6 ++++--
>   6 files changed, 18 insertions(+), 13 deletions(-)
> 

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
