Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72DE6C61DBE
	for <dri-devel@archiver.kernel.org>; Tue, 25 Aug 2026 14:44:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A927B10EAAC;
	Tue, 25 Aug 2026 14:44:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="TO4/SCfe";
	dkim-atps=neutral
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8533A10EAAC
 for <dri-devel@lists.freedesktop.org>; Tue, 25 Aug 2026 14:44:52 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id B5DCB1A17E9;
 Tue, 25 Aug 2026 14:44:50 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 87666604C4;
 Tue, 25 Aug 2026 14:44:50 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 5333C11C7A5B2; 
 Tue, 25 Aug 2026 16:44:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1787669085; h=from:subject:date:message-id:to:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=qFUKUt7CVKcVU9i8FCokkSuKt0b48/aHr3wU0dX85r8=;
 b=TO4/SCfefSptEykVnnXOwdB1XceV+CcsqOgyDIvm3PDJ/wGmoTsfT5EsZst1psjRqq71t/
 fiDamNRBAkHJqBInZgtYlXmGIY6DRxriGJiIA/mi0LCY6RK74ErDFXRLPGgMpmjomu2fOV
 rP7PDYgQqWpTTlFf4QuaEFTsLVIej6WmAu2Xg9dMtlCmJ3uekwVF576cO3YXB3kwz2KPeh
 QLCbIqkObC/kkt0UEoK8dy9ZjH+WKAiGalw0HvwpBOa2LmmlRMQYX7t0bXLaPfbjm8pXih
 0bJGWvt7uCtD31ct+aUFpZRW8UYWkKNn+1OMu9zwIiMyKbmt6KDei0zGRNPXiA==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 25 Aug 2026 16:44:32 +0200
Message-Id: <DKY3SQM0TNN8.3R0ATAX3TYNR3@bootlin.com>
To: "Krzysztof Kozlowski" <krzysztof.kozlowski@oss.qualcomm.com>, "Andrzej
 Hajda" <andrzej.hajda@intel.com>, "Neil Armstrong"
 <neil.armstrong@linaro.org>, "Robert Foss" <rfoss@kernel.org>, "Laurent
 Pinchart" <Laurent.pinchart@ideasonboard.com>, "Jonas Karlman"
 <jonas@kwiboo.se>, "Jernej Skrabec" <jernej.skrabec@gmail.com>, "Luca
 Ceresoli" <luca.ceresoli@bootlin.com>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
Subject: Re: [PATCH] drm/bridge: lontium: Drop redundant vendor prefix from
 I2C device name
X-Mailer: aerc 0.22.0
References: <20260825143921.512966-2-krzysztof.kozlowski@oss.qualcomm.com>
In-Reply-To: <20260825143921.512966-2-krzysztof.kozlowski@oss.qualcomm.com>
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

On Tue Aug 25, 2026 at 4:39 PM CEST, Krzysztof Kozlowski wrote:
> Device names for i2c_device_id are not OF compatibles and have a meaning
> only for in-tree users (which there are no except the driver itself),
> thus vendor prefix in this name is completely redundant.
>
> It is actually a discouraged pattern because for OF platforms it allows
> matching driver by I2C bus, instead of OF, thus hiding incomplete
> way of obtaining driver match data (lack of i2c_get_match_data() usage).
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
