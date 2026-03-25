Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE048106B50C
	for <dri-devel@archiver.kernel.org>; Wed, 25 Mar 2026 12:20:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 237B310E551;
	Wed, 25 Mar 2026 12:20:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="ZyMuWh95";
	dkim-atps=neutral
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA05310E551
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 12:20:29 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 646EC4E427BA;
 Wed, 25 Mar 2026 12:20:25 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 16246601E2;
 Wed, 25 Mar 2026 12:20:25 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 1AE2A10451319; Wed, 25 Mar 2026 13:20:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1774441224; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=g+jmFeA6jzlNGtF0WXjqDu9dIuu0/sgxhpz0DmhaSe8=;
 b=ZyMuWh951X2FL5ShARtCitPlnGr39QwxtrIMp3rTfAS3mIslGWIoD+LUJEPbR24PPjDO7k
 kRRVNkPDCIf1ckBQuoo4EnjkB5JEKlXnUxIQm/l7XB/q/Vt/1Im6lEXbpoJJk7urEM2g6m
 HCVWNrBFa9MRifRBIp2UpWJtR6d8kkLM9uJpI7TF/EubnpOMyfbQokPeYh+zSgn4nXBFal
 STra8cHbHWcE4gcAaMOs/EoUsnLO1K3OG1iKHmx0S6PaFm6WCsV/e4lc9OF1yuyW+GC8q8
 EYuWHTHd+OpyY7gi4y/M8bqBlqYNxlGixYLLm6pjcQGde0IdeRzalCaQOCRIJA==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 25 Mar 2026 13:20:15 +0100
Message-Id: <DHBUWX3J06TQ.1FRN7L0920OTH@bootlin.com>
Subject: Re: [PATCH v3 2/4] drm/bridge: analogix_dp: Apply DP helper API
 drm_dp_clock_recovery_ok()
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
 <20251110085823.1197472-3-damon.ding@rock-chips.com>
In-Reply-To: <20251110085823.1197472-3-damon.ding@rock-chips.com>
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
> Use existing DP helper API instead of analogix_dp_clock_recovery_ok()
> with the same function.
>
> Signed-off-by: Damon Ding <damon.ding@rock-chips.com>
> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

> @@ -398,7 +385,7 @@ static int analogix_dp_process_clock_recovery(struct =
analogix_dp_device *dp)
>  	if (retval < 0)
>  		return retval;
>
> -	if (analogix_dp_clock_recovery_ok(link_status, lane_count) =3D=3D 0) {
> +	if (drm_dp_clock_recovery_ok(link_status, lane_count)) {

It took a while to realize that drm_dp_clock_recovery_ok() really does the
same thing as analogix_dp_clock_recovery_ok(), but it looks fine.

Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
