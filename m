Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A73DCD98CC
	for <dri-devel@archiver.kernel.org>; Thu, 11 Jun 2026 13:36:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 956C410E791;
	Thu, 11 Jun 2026 13:36:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=hugovil.com header.i=@hugovil.com header.b="nuKzse3C";
	dkim-atps=neutral
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 27B1E10E791
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 13:36:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
 ; s=default;
 h=Content-Transfer-Encoding:Mime-Version:Message-Id:Subject:Cc:
 To:From:Date:subject:date:message-id:reply-to;
 bh=fxfUrM2C5cSU/ZQ2peV7mA0YDwTurUP7o3lWO7jM/k4=; b=nuKzse3C6h8sLjkBdRJ2jY5Kyl
 5FSAvCnDp6hhjOsiYNBDoT+KHNLAl8ju6okPofvst2NtyiQu/eosRRMoKvywhWvV6JIJtin+kmbkQ
 b1Xl/BXvFUHdnwlm0ohbsEHGp18+37omxU/rGL9QWTPZhvnQ49ekfSmgHQxffgBw5pHw=;
Received: from modemcable061.19-161-184.mc.videotron.ca ([184.161.19.61]
 helo=pettiford.lan) by mail.hugovil.com with esmtpa (Exim 4.98.2)
 (envelope-from <hugo@hugovil.com>) id 1wXfZl-000000006dp-3Owy;
 Thu, 11 Jun 2026 09:36:06 -0400
Date: Thu, 11 Jun 2026 09:36:03 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
To: Frank.Li@oss.nxp.com
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org,
 Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
 jernej.skrabec@gmail.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, s.hauer@pengutronix.de, kernel@pengutronix.de,
 festevam@gmail.com, shawnguo@kernel.org,
 laurent.pinchart+renesas@ideasonboard.com, antonin.godard@bootlin.com,
 Frank Li <Frank.Li@nxp.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, Hugo Villeneuve
 <hvilleneuve@dimonoff.com>
Subject: Re: (subset) [PATCH v2 00/15] var-som-6ul: improve support for
 variants
Message-Id: <20260611093603.898cab77746853acac1e740c@hugovil.com>
In-Reply-To: <178111898079.1109057.8610962818602994576.b4-ty@b4>
References: <20260305180651.1827087-1-hugo@hugovil.com>
 <178111898079.1109057.8610962818602994576.b4-ty@b4>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam_score: -2.0
X-Spam_bar: --
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

On Wed, 10 Jun 2026 15:18:16 -0400
Frank.Li@oss.nxp.com wrote:

> From: Frank Li <Frank.Li@nxp.com>
> 
> 
> On Thu, 05 Mar 2026 13:06:15 -0500, Hugo Villeneuve wrote:
> > From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> >
> > Hello,
> > this patch series improves support for Variscite VAR-SOM-6UL based boards.
> >
> > The first two patches fix DT/dmesg warnings.
> >
> > [...]
> 
> Applied, thanks!
> 
> [14/15] dt-bindings: display/lvds-codec: add ti,sn65lvds93
>         commit: bd584193a91ef2e190a2cf19f9320387fda1a21d
> 
> Other dts part already picked by me. This binding have not picked by
> subsystem mainatiner by twice ping. I picked it to avoid CHECK_DTB warnings.

Thank you for that.
Hugo.

> 
> 
> Best regards,
> --
> Frank Li <Frank.Li@nxp.com>
