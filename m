Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59648E9A74E
	for <dri-devel@archiver.kernel.org>; Tue, 24 Mar 2026 09:39:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA73D10E451;
	Tue, 24 Mar 2026 09:39:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="bFdClbMp";
	dkim-atps=neutral
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 689CB10E451
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 09:39:48 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 16AED1A2FC0;
 Tue, 24 Mar 2026 09:39:47 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id C5AB86011D;
 Tue, 24 Mar 2026 09:39:46 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id E872210450D32; Tue, 24 Mar 2026 10:39:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1774345185; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=nJpZfWii39Pl2CGVviW5wJECwhKEY7RXjU5Qjoc9wd4=;
 b=bFdClbMpP0gfSu09EHQpPe4c6GMbqI3IOBKukCVmCXixiIZJUsNqewJjVmalDaJm0wc6DZ
 kuseC3/48cPQJrKTyE7YkXMNWMaKDvhYHLLH8YGdRRtZSOikYnTfCgzrkx/OdtdREwZqZX
 Z8cRKBE9KJzrfzJZXrbgQFLNV/yEXbmREH7lWa1YYC4jN19zOGbpTr+TLp9KinrlYmIpD1
 CWKLER0zgVX2WSysrkvrCYXQtBvyCK8gcDzvaIK0+Q0RQO0CBkXwOP1fGBGRcRkRQaOSWm
 5QpuBvSUQ9OjTBZOsITKHQ7yCP0VGFnWK28DEP/2FGGuZdkQA7DqeBSdmksgNA==
Date: Tue, 24 Mar 2026 10:39:34 +0100
From: Kory Maincent <kory.maincent@bootlin.com>
To: Kevin Hilman <khilman@baylibre.com>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, Andreas Kemnade
 <andreas@kemnade.info>, Roger Quadros <rogerq@kernel.org>, Tony Lindgren
 <tony@atomide.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Russell King
 <linux@armlinux.org.uk>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 dri-devel@lists.freedesktop.org, Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Bajjuri Praneeth <praneeth@ti.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Louis Chauvet
 <louis.chauvet@bootlin.com>
Subject: Re: [PATCH v2 1/3] ARM: dts: ti: Enable overlays for am335x
 BeagleBoard devicetrees
Message-ID: <20260324103934.7d259008@kmaincent-XPS-13-7390>
In-Reply-To: <177275924369.1445909.1029086854461649971.b4-ty@baylibre.com>
References: <20260216-feature_bbge-v2-1-22805cfdbf62@bootlin.com>
 <177275924369.1445909.1029086854461649971.b4-ty@baylibre.com>
Organization: bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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

Hello Kevin,

On Thu, 05 Mar 2026 17:07:23 -0800
Kevin Hilman <khilman@baylibre.com> wrote:

> On Mon, 16 Feb 2026 17:55:52 +0100, Kory Maincent (TI) wrote:
> > Allow overlays to be applied to am335x BeagleBoard boards. This adds
> > around ~40% to the total size of the DTB files on average.
> >=20
> >  =20
>=20
> Applied, thanks!
>=20
> [1/3] ARM: dts: ti: Enable overlays for am335x BeagleBoard devicetrees
>       commit: 18161bb01ede109fed41c66efa2624a4c27377f7
>=20
> Best regards,

Thanks for merging it.
I see that you have merged patch 1 and 2 in your for-next branch.
Is there a reason to not merge the patch 3? Are you waiting for a dts
maintainer ack?

Maybe I can resend only the 3rd patch to ping the dts maintainers.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com
