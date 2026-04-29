Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FC15FF8867
	for <dri-devel@archiver.kernel.org>; Wed, 29 Apr 2026 11:43:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE4B510EFB8;
	Wed, 29 Apr 2026 11:43:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="cvcX78xV";
	dkim-atps=neutral
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B714310EFBB
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Apr 2026 11:43:46 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 9C8EB4E42AF1;
 Wed, 29 Apr 2026 11:43:45 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 67BF6601DF;
 Wed, 29 Apr 2026 11:43:45 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 338701072818D; 
 Wed, 29 Apr 2026 13:43:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1777463024; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=5C5WjMDCk4kbiTHj64gwZ34T6TJ7DSCuppc2MhbBVao=;
 b=cvcX78xVFs+rZdgta+uYUEgQ/SAm/sIgoeTFarUqiBRML5ZY/9UiWUx7+q+JQeBF8vWK+P
 Wdgz8vkjIaJCxLrbMnVNSC5QEcjF9CPznrQytjqO+77z5lRXw+3zTar8BcBL+nV0oa3JqN
 QxK20Tuix558dogywl6fJlAAfr099sNplQZMsVeDE8dj17uY/vSXvbe+TtGl0Nsz7Qsgqs
 PE8WgLi0UXWMVC5q2p6MuSu/2U6DuAQs2g8cftVQU5Oohwqg9jFZD1FSi1e9nAREZ0TuHl
 TjkLJMZcZTF+Sh/huni6gXY3usH9ZYfg+K9VsxZt4NzDZLY0eF7/WnYKcODcjw==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 29 Apr 2026 13:43:38 +0200
Message-Id: <DI5M1Y2NCMPO.1YJOI1CRHENOC@bootlin.com>
To: "Osama Abdelkader" <osama.abdelkader@gmail.com>, "Inki Dae"
 <inki.dae@samsung.com>, "Seung-Woo Kim" <sw0312.kim@samsung.com>, "Kyungmin
 Park" <kyungmin.park@samsung.com>, "David Airlie" <airlied@gmail.com>,
 "Simona Vetter" <simona@ffwll.ch>, "Krzysztof Kozlowski" <krzk@kernel.org>,
 "Alim Akhtar" <alim.akhtar@samsung.com>, "Andrzej Hajda"
 <andrzej.hajda@intel.com>, "Hoegeun Kwon" <hoegeun.kwon@samsung.com>,
 <dri-devel@lists.freedesktop.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-samsung-soc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
Subject: Re: [PATCH v3 2/3] drm/exynos: remove bridge when component_add fails
Cc: <stable@vger.kernel.org>
X-Mailer: aerc 0.20.1
References: <20260423200622.325076-1-osama.abdelkader@gmail.com>
 <20260423200622.325076-2-osama.abdelkader@gmail.com>
In-Reply-To: <20260423200622.325076-2-osama.abdelkader@gmail.com>
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

On Thu Apr 23, 2026 at 10:06 PM CEST, Osama Abdelkader wrote:
> Use devm_drm_bridge_add() so the bridge is released if probe fails after
> registration, and drop the manual drm_bridge_remove() in remove().
>
> Check the return value of devm_drm_bridge_add().
>
> Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
> Fixes: 576d72fbfb45 ("drm/exynos: mic: add a bridge at probe")
> Cc: stable@vger.kernel.org

Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
