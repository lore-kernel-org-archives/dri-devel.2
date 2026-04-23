Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01411F99344
	for <dri-devel@archiver.kernel.org>; Thu, 23 Apr 2026 08:23:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5207310E302;
	Thu, 23 Apr 2026 08:23:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="nbB5Ef3S";
	dkim-atps=neutral
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2DFF010E319
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 08:22:59 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id B21881A33B7;
 Thu, 23 Apr 2026 08:22:57 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 7DB0A60495;
 Thu, 23 Apr 2026 08:22:57 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id E58F410460A92; 
 Thu, 23 Apr 2026 10:22:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1776932576; h=from:subject:date:message-id:to:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=G7O5AvxGLP6qGymQpmmVVz/li/wRMZf57WOc0KQTqS0=;
 b=nbB5Ef3SEyh3kUcJbSydTDSW+UPOEW920UZMBoLcY2dEw9ACRoxh+rbKzMwq9uCOK7Off9
 c1javShiRuCTIDdW+biL5D+YYUrALjMwAi/s9hjGT7mQTo646YzvwYwwU21/N5FFdYWn39
 xNqtAAs5AdlCbG7UVDWHmWwOAg4x3KmKgbD27pDmekW4ZAl0GyD6DD3DgTENpPCJia7X1j
 aSTeKAF4VWSk9e6ZRq7HKaIk5wymaAdPpaQXoh/fGzg12GZN2doiaFcDMbry7Ge3BxF4nU
 VqoQKrgcv1jRKfn9rHtOGxjeJJuEs0PkMoVXTK+m0qBeF8+8FDeAzGHttp8kew==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 23 Apr 2026 10:22:52 +0200
Message-Id: <DI0E0YLZCSMB.31RKF71K1MBPG@bootlin.com>
Subject: Re: [PATCH v2 1/3] drm/sti: remove bridge when sti_hda
 component_add fails
To: "Osama Abdelkader" <osama.abdelkader@gmail.com>, "Alain Volmat"
 <alain.volmat@foss.st.com>, "Raphael Gallais-Pou" <rgallaispou@gmail.com>,
 "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime Ripard"
 <mripard@kernel.org>, "Thomas Zimmermann" <tzimmermann@suse.de>, "David
 Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
X-Mailer: aerc 0.20.1
References: <20260414175417.144625-1-osama.abdelkader@gmail.com>
 <20260414175417.144625-2-osama.abdelkader@gmail.com>
In-Reply-To: <20260414175417.144625-2-osama.abdelkader@gmail.com>
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

On Tue Apr 14, 2026 at 7:54 PM CEST, Osama Abdelkader wrote:
> Use devm_drm_bridge_add() so the bridge is released if probe fails after
> registration, and drop the manual drm_bridge_remove() in remove().
>
> Check the return value of devm_drm_bridge_add().
>
> v2: devm_drm_bridge_add instead of drm_bridge_add + goto remove_bridge
>
> Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>

Looks like a bigfix, right? So it should have a Fixes tag.

Luca

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
