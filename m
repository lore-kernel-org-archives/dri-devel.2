Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62CD2CDE008
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 10:56:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C14F110E1D7;
	Thu, 25 Jun 2026 10:56:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="JZuHnXTB";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ECBA910E1D2
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 10:56:51 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id AA3D740C43;
 Thu, 25 Jun 2026 10:56:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 149181F000E9;
 Thu, 25 Jun 2026 10:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782385011;
 bh=haLRd/7iK2UAWm9b/wOf0VERYgLg/GM/K5+HuVZsoYw=;
 h=Date:From:To:Subject:In-Reply-To:References:Cc;
 b=JZuHnXTBT1wZc5a4CjAWJQMMrL1I4sqeC8gBNzp9at7SKRvdGHL7Nd1md2qEEoS2i
 JhJY/hTFlrloWmVdoB8MZ3DK4V/WYOdu+0U01wY78/nUFugTvZK8HNlJxUfAwHwCZE
 Vq4P4G1sAesSwELuQe6Vd5/UeB+ar5y+v3vhylTgU0/T7jLg4c/4xZp/LcR7vjSsdR
 4eLg80nEJwpNWTptj96LgXJ+GR5twqsLiDCM1qsfCfcXF7kWsBQvvNj646QCY+l3Dl
 a90oDqQ+xkjLTPJrUxY0E0yRRE1REPAvZPxB8vNUCQjFq0iZlpsx3gEX22T0xFEJcU
 qraEWBQmB5pWQ==
Message-ID: <bc7054cbee208f10518f50935602445f@kernel.org>
Date: Thu, 25 Jun 2026 10:56:48 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Thomas Zimmermann" <tzimmermann@suse.de>
Subject: Re: [PATCH v3 0/7] drm/sysfb: simpledrm: Various improvements
In-Reply-To: <20260625094509.157581-1-tzimmermann@suse.de>
References: <20260625094509.157581-1-tzimmermann@suse.de>
Cc: airlied@gmail.com, dri-devel@lists.freedesktop.org, javierm@redhat.com,
 jesszhan0024@gmail.com, maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 neil.armstrong@linaro.org, rayyan@ansari.sh, sashiko-reviews@lists.linux.dev,
 simona@ffwll.ch, treding@nvidia.com, "Maxime Ripard" <mripard@kernel.org>
Content-Transfer-Encoding: quoted-printable
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

On Thu, 25 Jun 2026 11:39:32 +0200, Thomas Zimmermann wrote:
> Patches 1 to 5 improve validation of the values provided by the
> device firmware.
>=20
> Patches 6 and 7 improve support for panel orientation. There's a rotation
> property in the DT panel node. Read the value and set the connector's
>=20
> [ ... ]

Reviewed-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime
