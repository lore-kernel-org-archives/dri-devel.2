Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B49EDCD5BAC
	for <dri-devel@archiver.kernel.org>; Thu, 21 May 2026 19:58:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2DEE810E648;
	Thu, 21 May 2026 19:58:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="RbA+9FpP";
	dkim-atps=neutral
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C926510E648
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 19:57:52 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id EB211C2C651;
 Thu, 21 May 2026 19:58:44 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 86FC96002C;
 Thu, 21 May 2026 19:57:50 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id D8E0F107E8C45; 
 Thu, 21 May 2026 21:57:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1779393469; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=AqCwkI/dpMbNl+kiiunF6ar0+CJqc/elqrs+Uj3cTxw=;
 b=RbA+9FpPvCQE6wB7yaimuqIyh4k2DPuIlD+sULLAYxlAnBhEm0TCtVlOwUVxKB/F3rb2v0
 c5jkwZBpHoaYKEmkld9kuGwwu+WYpFFSCjX0qswYqtM531GHtP8MQGkphtbrga0LRzgKOS
 DZPqEZECcEtgNItdzvo8h6uX1nYOXEfTxpK2k9/SnsxHX3nuWCzGk6Ojn3cNzNAC42bQrs
 cQDufOoerY0udYbS9o/hhU8Ckmp0EeVZilFHlp+RNa4x7jI77wVqRixYWaycNDxGuvGLUX
 bl1EAEYeACZr/JvjEsL8pF1xEqlBBHlBVqmMnQjGN3IVxJRj746Nu4JlQ17U3w==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 21 May 2026 21:57:40 +0200
Message-Id: <DIOMC6QES1LP.3V3BEPSZI9C7T@bootlin.com>
Cc: <Laurent.pinchart@ideasonboard.com>, <jonas@kwiboo.se>,
 <jernej.skrabec@gmail.com>, <luca.ceresoli@bootlin.com>,
 <dmitry.baryshkov@oss.qualcomm.com>, <heiko@sntech.de>,
 <m.szyprowski@samsung.com>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>
To: "Damon Ding" <damon.ding@rock-chips.com>, <andrzej.hajda@intel.com>,
 <neil.armstrong@linaro.org>, <rfoss@kernel.org>,
 <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
 <tzimmermann@suse.de>, <airlied@gmail.com>, <simona@ffwll.ch>
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
Subject: Re: [PATCH v1] drm/bridge: analogix_dp: Convert status check
 functions to bool
X-Mailer: aerc 0.21.0
References: <20260521102716.1373519-1-damon.ding@rock-chips.com>
In-Reply-To: <20260521102716.1373519-1-damon.ding@rock-chips.com>
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

On Thu May 21, 2026 at 12:27 PM CEST, Damon Ding wrote:
> Convert analogix_dp_is_slave_video_stream_clock_on() and
> analogix_dp_is_video_stream_on() from int to bool return type.
>
> This makes the code more readable and aligns with kernel best
> practices for boolean status checks, while simplifying the
> callers by removing unnecessary "=3D=3D 0" comparisons.
>
> Signed-off-by: Damon Ding <damon.ding@rock-chips.com>

Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
