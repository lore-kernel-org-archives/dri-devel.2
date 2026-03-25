Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D75B106B52D
	for <dri-devel@archiver.kernel.org>; Wed, 25 Mar 2026 12:54:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3052E10E829;
	Wed, 25 Mar 2026 12:54:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="CAwh0RzS";
	dkim-atps=neutral
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A2DD110E226
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 12:54:21 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 3329F4E4270B;
 Wed, 25 Mar 2026 12:54:20 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id E9066601E2;
 Wed, 25 Mar 2026 12:54:19 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id E513A1045106E; Wed, 25 Mar 2026 13:54:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1774443258; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=l+eM+d/DLHNNcKAK6EYaxLQcXa8BHmHMsx/e0may25c=;
 b=CAwh0RzSnwvcWYzlYQQCOBZi8Qr4g98uK7iTfxJZVDdj3hnat5Rpks/VwQsUyW8ztw2Dqw
 XXT/PQLPa0pCjIouKEdlY/uJV4YiA7LESPCgnKOOCB9iNy4IkUvXDizBaNzBbcQEqShBF/
 ilIA/M0nB3NH0x79KDx7hoMNXjgeBgXlGWK/DjqAxocAtQ3/D6ycWodJqUWWwUuajQSe1x
 Ix8PtmoEwVz6lwOh6vyF1H4ljTN9S1ExTMng/Gkfav5sqAlIwUhNCo6BqSpmN9bSJ9y0QC
 mK4ESFVLT9HEU/hKIxpjf/h590z+IWhjqApk8hVkLMFGSDWnRjoMuUYPimcD3Q==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 25 Mar 2026 13:54:08 +0100
Message-Id: <DHBVMUZW62YV.KEH345A07A66@bootlin.com>
Subject: Re: [PATCH v3 3/4] drm/bridge: analogix_dp: Apply DP helper API
 drm_dp_channel_eq_ok()
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
X-Mailer: aerc 0.20.1
References: <20251110085823.1197472-1-damon.ding@rock-chips.com>
 <20251110085823.1197472-4-damon.ding@rock-chips.com>
In-Reply-To: <20251110085823.1197472-4-damon.ding@rock-chips.com>
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
> Use existing DP helper API instead of analogix_dp_channel_eq_ok()
> with the same function.
>
> In addtion, remove unused function analogix_dp_get_lane_status()
>
> Signed-off-by: Damon Ding <damon.ding@rock-chips.com>
> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
