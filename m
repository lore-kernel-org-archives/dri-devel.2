Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87A6ACD3424
	for <dri-devel@archiver.kernel.org>; Sun,  3 May 2026 16:53:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 748B910E33A;
	Sun,  3 May 2026 16:53:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ghW9LrpC";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A27BF10E33A
 for <dri-devel@lists.freedesktop.org>; Sun,  3 May 2026 16:53:39 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 25C7C43D13;
 Sun,  3 May 2026 16:53:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61020C2BCB4;
 Sun,  3 May 2026 16:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777827219;
 bh=1Etpq6wnGwOr5oR0u0952ST5kV6ZQp1I+Y9KByQY0Vc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ghW9LrpCOgQpUpZ6bt35gv9JaxPFBItxyJkeSUdmr8HmMdSQ81CCNedzh4qF8kb2U
 xNtoEOXtZ2L+CCm/4a2hUqrGZ0BbqTTjSqKIQLVOsxTAlOEOumoxBmQcW6ZELL7okp
 Wbn7S7zmfJN05INga6GyQ3euRVkhtXVPm6dYGHp3quwMW5zVRCZGTAcLC8mKpNXIi0
 fI/Al4q2y9c+CjhZIh99gUltSQIq3yNK2HqDOrpmtMlJNN4B9Tn22fQbEty0fPLUGR
 fAHzLWtr1EN9cGIh2HW45tymrTpfP30G/+Ot9WyRXIIJJ9EeiC9j56VqTem5wkFdU6
 eIyrz1g5Rfu8A==
Date: Sun, 3 May 2026 22:23:34 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
Cc: Parshuram Thombare <pthombar@cadence.com>,
 Swapnil Jakhade <sjakhade@cadence.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-phy@lists.infradead.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux@ew.tq-group.com,
 Alexander Stein <alexander.stein@ew.tq-group.com>,
 Ying Liu <victor.liu@nxp.com>
Subject: Re: [PATCH v22 6/8] phy: freescale: Add DisplayPort/HDMI Combo-PHY
 driver for i.MX8MQ
Message-ID: <afd9juuQh8OB6SEw@vaman>
References: <20260424-dcss-hdmi-upstreaming-v22-0-30a28f89298d@oss.nxp.com>
 <20260424-dcss-hdmi-upstreaming-v22-6-30a28f89298d@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260424-dcss-hdmi-upstreaming-v22-6-30a28f89298d@oss.nxp.com>
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

On 24-04-26, 11:07, Laurentiu Palcu wrote:
> From: Sandor Yu <Sandor.yu@nxp.com>
> 
> Add Cadence HDP-TX DisplayPort and HDMI PHY driver for i.MX8MQ.
> 
> Cadence HDP-TX PHY could be put in either DP mode or
> HDMI mode base on the configuration chosen.
> DisplayPort or HDMI PHY mode is configured in the driver.

Hi,

Please consider if this can be split from rest of the series and posted
as phy driver

Also sasiko has flagged some issues, please take a look https://sashiko.dev/#/patchset/20260424-dcss-hdmi-upstreaming-v22-0-30a28f89298d%40oss.nxp.com

-- 
~Vinod
