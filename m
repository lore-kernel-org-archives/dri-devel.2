Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C6A1C44507
	for <dri-devel@archiver.kernel.org>; Wed, 15 Jul 2026 10:22:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5DBA510EF8A;
	Wed, 15 Jul 2026 10:21:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="VoFozs/j";
	dkim-atps=neutral
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9DBD610EF8A
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Jul 2026 10:21:58 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 348FC4E40DC9;
 Wed, 15 Jul 2026 10:21:57 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id ED1F56035C;
 Wed, 15 Jul 2026 10:21:56 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id EACE611BD3BA2; 
 Wed, 15 Jul 2026 12:21:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1784110916; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=507ibyS8Z3GKmWQ7RpXtj6AHZPLDMJzsl3fDfFbCD7o=;
 b=VoFozs/j8aKIYiqgFhmpvH3JN2l61UG+xa2lWzy+okrXr745yGOpiNc4bj5o6wFYAhW1lQ
 1ZDuIQZ/LvFRxphK1fj2XR7k2Io3TePna0kOVYuwX81sNJgvPRng1aJt9kXOj8dqQbEFzf
 K+gN6AX/jaH+K0884g5WDXkMYOZqH/x8QW0OE9wjLQHw1dnLHCxiltnQrFnCFCxHvRMosD
 oqvClaRo2h+ngBdCNI7N0ok1lPybGXblFrn4/UJFZR2UsejduPI2clf5gttPwXUX4hG7+W
 5lHPbWuiGseiylz69uwnX1pCN/84Ax6lF+bV3VE9AFZgzScb7NBEEQf3yLs2dg==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 15 Jul 2026 12:21:48 +0200
Message-Id: <DJZ2J8Q1RQ5V.1QE5NKGZC9NQF@bootlin.com>
To: "Colin Ian King" <colin.i.king@gmail.com>, "Francesco Dolcini"
 <francesco@dolcini.it>, "Andrzej Hajda" <andrzej.hajda@intel.com>, "Neil
 Armstrong" <neil.armstrong@linaro.org>, "Robert Foss" <rfoss@kernel.org>,
 "Laurent Pinchart" <Laurent.pinchart@ideasonboard.com>, "Jonas Karlman"
 <jonas@kwiboo.se>, "Jernej Skrabec" <jernej.skrabec@gmail.com>, "Luca
 Ceresoli" <luca.ceresoli@bootlin.com>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>,
 <dri-devel@lists.freedesktop.org>
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
Subject: Re: [PATCH][next] drm/bridge: lontium-lt8912b: make read-only const
 array supply_names static
Cc: <kernel-janitors@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20260714190400.194605-1-colin.i.king@gmail.com>
In-Reply-To: <20260714190400.194605-1-colin.i.king@gmail.com>
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

On Tue Jul 14, 2026 at 9:03 PM CEST, Colin Ian King wrote:
> Don't populate the read-only const array supply_names on the stack
> at run time, instead make it static
>
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
