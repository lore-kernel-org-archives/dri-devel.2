Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5934FEA810
	for <dri-devel@archiver.kernel.org>; Wed, 25 Mar 2026 06:39:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 07A1410E779;
	Wed, 25 Mar 2026 06:39:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="SnEKLPbS";
	dkim-atps=neutral
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 45E5010E779
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 06:39:47 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 390F4C580A9;
 Wed, 25 Mar 2026 06:40:12 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 738E3601A1;
 Wed, 25 Mar 2026 06:39:44 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 9AB6A1045133B; Wed, 25 Mar 2026 07:39:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1774420783; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=9v+zUH5+6hT9ekX+/2AKVnTprP1sxA4Cyh6xCtkQnuE=;
 b=SnEKLPbS+hdKeMSaTZJOywBErRbN+PN1ZYM63zrVB7c5V+ptcLTTr7r0zGmRMTExWZjJ0z
 KdverCejpwo7KI9O1UHDqsSWLv8jSrqjuUS6Aq9ISzj9LRtcIXBbRBWGlm5ojO4bbIXLki
 Z1WARPbOrRc0DfveFd4NhdOu3FQoASV1U0n/f8fOOfNDCNla684i6r1dlr46sN/3kqeMbf
 HK8pG3YAuomrRbq2lxNIY0OR9py2QJXicnPwfWcX0uvNqM4D+k/IojFQQcAs5uCzmiE8Z5
 LBtHFLfDzANvgaco+SsVRenJpck4GDczd7ItI+FgnvfBJy9rqZeBH1dePjJWiQ==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 25 Mar 2026 07:39:37 +0100
Message-Id: <DHBNO3V2TQMX.1MR761QT9RZT9@bootlin.com>
Cc: <Laurent.pinchart@ideasonboard.com>, <jonas@kwiboo.se>,
 <jernej.skrabec@gmail.com>, <maarten.lankhorst@linux.intel.com>,
 <mripard@kernel.org>, <tzimmermann@suse.de>, <airlied@gmail.com>,
 <simona@ffwll.ch>, <dmitry.baryshkov@oss.qualcomm.com>,
 <dianders@chromium.org>, <m.szyprowski@samsung.com>,
 <andy.yan@rock-chips.com>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>
To: "Damon Ding" <damon.ding@rock-chips.com>, <andrzej.hajda@intel.com>,
 <neil.armstrong@linaro.org>, <rfoss@kernel.org>
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
Subject: Re: [PATCH v3 1/4] drm/bridge: analogix_dp: Apply DP helper API
 drm_dp_dpcd_read_link_status()
X-Mailer: aerc 0.20.1
References: <20251110085823.1197472-1-damon.ding@rock-chips.com>
 <20251110085823.1197472-2-damon.ding@rock-chips.com>
In-Reply-To: <20251110085823.1197472-2-damon.ding@rock-chips.com>
X-Last-TLS-Session-Version: TLSv1.3
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

On Mon Nov 10, 2025 at 9:58 AM CET, Damon Ding wrote:
> Use existing DP helper API to read link status related DPCDs.
>
> Signed-off-by: Damon Ding <damon.ding@rock-chips.com>
> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
