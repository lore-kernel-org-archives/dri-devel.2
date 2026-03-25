Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1D23106B52D
	for <dri-devel@archiver.kernel.org>; Wed, 25 Mar 2026 12:54:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 20F8B10E226;
	Wed, 25 Mar 2026 12:54:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="H8V9Vt4w";
	dkim-atps=neutral
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F56B10E226
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 12:54:22 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 5F71FC580A3;
 Wed, 25 Mar 2026 12:54:48 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 9F7B2601E2;
 Wed, 25 Mar 2026 12:54:20 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id E679C104510D9; Wed, 25 Mar 2026 13:54:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1774443259; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=1MQMKKuc6xZNYi8Uo9EHxd2QXLot9Kz0JdFiF9OwEwg=;
 b=H8V9Vt4wbPYGO+eKPTrp3OzHcNb8Eexv8NNjpQpREBBsp9sD3/HOvFPFQTCw5ISTCMZFVl
 0DM8Q82OAO79XMEstz2N56zhxKERSZE0ozH6wGp33kdOudgvowO+4zH7zogfPp4niu7e6r
 +NauV125Gb6xqKi6DUG3ue0D1lRHh5HsAr9fnoysnOqb6XKNiIg9A4jVJw1XD/3ERcRyaF
 WM9EPS0g3VO6Js3Nb/5yAy8nE10F7qGJ4D2OaMD5iin9rqjapf2VTP/iWnLPs1u3kNlCmC
 987sBo1AZeOP3+uVil1Hv+YOLOvFIfYnl9vDfCKSXQO+0p/YXVeD5v70FBXWTA==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 25 Mar 2026 13:54:15 +0100
Message-Id: <DHBVMY0WYWZH.24177GRH7WMBD@bootlin.com>
Subject: Re: [PATCH v3 4/4] drm/bridge: analogix_dp: Apply DP helper APIs to
 get adjusted voltages and pre-emphasises
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
 <20251110085823.1197472-5-damon.ding@rock-chips.com>
In-Reply-To: <20251110085823.1197472-5-damon.ding@rock-chips.com>
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
> Replace analogix_dp_get_adjust_request_voltage() and
> analogix_dp_get_adjust_request_pre_emphasis() with existing DP helper
> APIs with the same function.
>
> Signed-off-by: Damon Ding <damon.ding@rock-chips.com>
> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
