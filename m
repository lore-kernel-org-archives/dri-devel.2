Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E0A1FF8875
	for <dri-devel@archiver.kernel.org>; Thu, 30 Apr 2026 12:47:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1EFDB10E349;
	Thu, 30 Apr 2026 12:47:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="GDxd1AZx";
	dkim-atps=neutral
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 81A6A10E349
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Apr 2026 12:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=ONGR1P2sejPwseI1U48nJ6Sn9Q1O9l+eOpPQC/6BOKQ=; b=GDxd1AZxCnVt3bGh86E2xy02FF
 zD1YjTRphX9Wx+vRvEYcC2Bp/M+DJphjoDQr/LGJozmZ2YMKHeZQBzVpQzO9m6eDgct9qvvxWxcsc
 o7eRgeivb+MvqVr1UPdmTr3gfrjQi+JYG8QN8yjvC95Xaz8yspeiX9phBRs+4u9W9pO4b7cmmiRkd
 bf+9cTekx1kB/uJgozCHPDabIgck2MoipIjTezVRioi3g74uyWxNNsndFblVYF2UhnhsBKX9Spsip
 b1vhwwPIMsSP6nPf6D+WoZG9vU5+khFElS03T84ODUAiL0DJvaycS3tWIqQJWkVhBGTcFOjEXbydo
 1LyYCQ0Q==;
Received: from sslproxy04.your-server.de ([78.46.152.42])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <alexander.stein@ew.tq-group.com>)
 id 1wIQnh-000A3k-0Y; Thu, 30 Apr 2026 14:47:29 +0200
Received: from localhost ([127.0.0.1])
 by sslproxy04.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <alexander.stein@ew.tq-group.com>)
 id 1wIQng-000HY2-06; Thu, 30 Apr 2026 14:47:28 +0200
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
Cc: Parshuram Thombare <pthombar@cadence.com>,
 Swapnil Jakhade <sjakhade@cadence.com>, Dmitry Baryshkov <lumag@kernel.org>,
 Nikhil Devshatwar <nikhil.nd@ti.com>, Jayesh Choudhary <j-choudhary@ti.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux@ew.tq-group.com, Ying Liu <victor.liu@nxp.com>
Subject: Re: [PATCH v22 4/8] drm: bridge: Cadence: Add MHDP8501 DP/HDMI driver
Date: Thu, 30 Apr 2026 14:47:27 +0200
Message-ID: <15228814.O9o76ZdvQC@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <q7rze73ohtylj4jgtxun3cg6ih42crfs2u6tioby6yfqciemem@udrdm2g32fgn>
References: <20260424-dcss-hdmi-upstreaming-v22-0-30a28f89298d@oss.nxp.com>
 <DI3YF7J7ZW0P.3OKMUXAM7GW5C@bootlin.com>
 <q7rze73ohtylj4jgtxun3cg6ih42crfs2u6tioby6yfqciemem@udrdm2g32fgn>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Virus-Scanned: Clear (ClamAV 1.4.3/27987/Thu Apr 30 08:25:46 2026)
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

Hi,

Am Montag, 27. April 2026, 16:35:55 CEST schrieb Laurentiu Palcu:
> Hi Luca,
>
> [snip]
> >=20
> > Another question is whether this driver should have two compatible stri=
ngs,
> > one for hdmi and one for dp, and set the bridge_type based on that. This
> > would make it a lot simpler and remove the need for this function.
>=20
> I think this is a good idea. I see no reason why having 2 different
> compatibles wouldn't work. I'll give it a try.

IIRC the original implementation of Sandor had two compatibles, essentially
duplicating lots of code for DP and HDMI. Maybe meanwhile with the rework t=
he
duplication is gone and the different compatibles are feasible again.

Best regards,
Alexander
=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/


