Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFE1EF99340
	for <dri-devel@archiver.kernel.org>; Thu, 23 Apr 2026 07:36:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 382B010E30D;
	Thu, 23 Apr 2026 07:36:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="uTcdnq+g";
	dkim-atps=neutral
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF1D810E30D
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 07:36:55 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 6D9D34E42AC4;
 Thu, 23 Apr 2026 07:36:54 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 3952E60495;
 Thu, 23 Apr 2026 07:36:54 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 295FD10460A48; 
 Thu, 23 Apr 2026 09:36:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1776929813; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=9zLDYhRLp1C8iB+7Bfnq0LeScArZDIWJVBYp32yM1Dg=;
 b=uTcdnq+ge9i2RDy9oDQv6wJ/M8feYwPQ29K7hsbM5kDheVgO6BiO6VEYiyjAauL6jJfWtk
 Hfi9QfR5S3D5z/UKNx8pQHoXScjXZpjQbPJQ3JIcvD+FWxwZjJpVDQYuZs/i9/pFJUYoJ8
 hJIfGUuF3pRg9XeelmQsVSDckaeRxLClVH7H/36Hmko+I/OCIgXIGcWBp2KKJomUK78N5+
 0hdK0BfmEjLbreJzG4/oO9JTYKpbL6CJufujryrjvoEwayzpxlrxZKwo+pTND8+o7/9U3H
 WH4/AlPOO1M/iMj+23p2yPmfUw4qWEtuvFSEICteBCheFn2WSMSoOKMYiVeqSg==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 23 Apr 2026 09:36:45 +0200
Message-Id: <DI0D1NGQHB48.2G6BECF52MA54@bootlin.com>
Subject: Re: [PATCH v3] drm/bridge: ti-sn65dsi83: two fixes + add test pattern
Cc: "Andrzej Hajda" <andrzej.hajda@intel.com>, "Neil Armstrong"
 <neil.armstrong@linaro.org>, "Robert Foss" <rfoss@kernel.org>, "Laurent
 Pinchart" <Laurent.pinchart@ideasonboard.com>, "Jonas Karlman"
 <jonas@kwiboo.se>, "Jernej Skrabec" <jernej.skrabec@gmail.com>, "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime Ripard"
 <mripard@kernel.org>, "Thomas Zimmermann" <tzimmermann@suse.de>, "David
 Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Frieder
 Schrempf" <frieder.schrempf@kontron.de>, "Marek Vasut" <marex@denx.de>,
 "Linus Walleij" <linusw@kernel.org>, "Louis Chauvet"
 <louis.chauvet@bootlin.com>, "Hui Pu" <Hui.Pu@gehealthcare.com>, "Ian Ray"
 <ian.ray@gehealthcare.com>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>
To: "Dmitry Baryshkov" <dmitry.baryshkov@oss.qualcomm.com>
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
X-Mailer: aerc 0.20.1
References: <20260416-ti-sn65dsi83-dual-lvds-fixes-and-test-pattern-v3-0-143886aebc6b@bootlin.com>
 <7igh3ptyadpztgxgl2pjbikeossz2trr3rowdjv3lbf6gatyb6@5bm3hon5b6mi>
In-Reply-To: <7igh3ptyadpztgxgl2pjbikeossz2trr3rowdjv3lbf6gatyb6@5bm3hon5b6mi>
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

Hi Dmitry,

On Wed Apr 22, 2026 at 9:40 PM CEST, Dmitry Baryshkov wrote:
> On Thu, Apr 16, 2026 at 03:59:54PM +0200, Luca Ceresoli wrote:
>> This series used to have two bug fixes, now applied to drm-misc-fixes, a=
nd
>> a patch adding support for enabling the test pattern output from userspa=
ce,
>> which is now at v3.
>
> We really need a generic interface for TPGs...

I agree on the general principle, but where could this interface be placed?
Bridges are not exposed to user space. They are somewhat visible in debugfs
but even there there's no per-bridge file or directory.

Luca

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
