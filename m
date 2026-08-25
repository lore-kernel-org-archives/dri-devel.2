Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 944B1C61DBE
	for <dri-devel@archiver.kernel.org>; Tue, 25 Aug 2026 15:59:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EAB0410EACE;
	Tue, 25 Aug 2026 15:59:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="DyojAnEI";
	dkim-atps=neutral
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8807310E15B
 for <dri-devel@lists.freedesktop.org>; Tue, 25 Aug 2026 15:59:55 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 57B311A17DD;
 Tue, 25 Aug 2026 15:59:54 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 2C46E604C4;
 Tue, 25 Aug 2026 15:59:54 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 2909911C7A688; 
 Tue, 25 Aug 2026 17:59:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1787673589; h=from:subject:date:message-id:to:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=BMtEdXKhmr82i4nD5ph92KqaktDmTBMaqoE9IVxHuEc=;
 b=DyojAnEIVpTbzsamgWi5smsUV4YO3zNhzSP/nshWHa5mSURAo0Pf8p7TIVslkFvp7M1ptj
 QNF84tivJdthpygPdmMRpwhnzjKtXMxfE7gJJSW6XTuxB0kQvg4r9sehW5iVFxfQCOptiN
 Yd1rirBGRd8o5/4ZJEPk7ABoDfWtILTwhvCNJfQImZg3+tSOm8wTo6p8xy+6sTkgKtZlYP
 JSTV3SaA3kftgvxMx2fxp3l1hYMF/z0s5zCxmYJy7s/NWyK1dEd3W6go+i7gSyHtvBi3F7
 QBmZiKJ+ziax3TwxJN5+xVB6lKTACapJp8EkbCJbBL80ngguQXcLjGLIkrDMcg==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 25 Aug 2026 17:59:37 +0200
Message-Id: <DKY5E87LEDED.19Y9YVD1JATJU@bootlin.com>
Subject: Re: [PATCH v4 2/6] drm/panel: Use managed helpers in Samsung panels
To: "Osama Abdelkader" <osama.abdelkader@gmail.com>,
 <luca.ceresoli@bootlin.com>, "Neil Armstrong" <neil.armstrong@linaro.org>,
 "Jessica Zhang" <jesszhan0024@gmail.com>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Artur Weber"
 <aweber.kernel@gmail.com>, "David Heidelberg" <david@ixit.cz>, "Dzmitry
 Sankouski" <dsankouski@gmail.com>, "Yedaya Katsman" <yedaya.ka@gmail.com>,
 "Casey Connolly" <casey.connolly@linaro.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
X-Mailer: aerc 0.22.0
References: <20260812144426.62074-1-osama.abdelkader@gmail.com>
In-Reply-To: <20260812144426.62074-1-osama.abdelkader@gmail.com>
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

On Wed Aug 12, 2026 at 4:44 PM CEST, Osama Abdelkader wrote:
> Use the managed MIPI DSI attach and panel add helpers in Samsung panel
> drivers and drop the corresponding manual detach and panel remove calls
> from remove paths. Also, switch to devm_backlight_device_register in
> s6e3ha2 and s6e63j0x03.
>
> Suggested-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>

Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
