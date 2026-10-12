Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55F96CA9EC5
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 07:33:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BFA1510E522;
	Mon, 12 Oct 2026 07:33:47 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B487310E522
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 07:33:41 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id BB03D60D9E;
 Mon, 12 Oct 2026 07:33:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDC681F0089B;
 Mon, 12 Oct 2026 07:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791790420;
 bh=UuVvjn0F3XfMBMMaA4amZeiXMWrBQDCC1HR9dxk+r2Y=;
 h=Date:From:To:Subject:In-Reply-To:References:Cc;
 b=MLNQu2cT8iBOo2NcWQQYmdNO+8+WKVNflfhrtBE3yBBJGSsYho/oTdEARRrfA0p6j
 PEYu2k7JYKJLnUP36gTMpRC/zPbE1wdu4PqvLxmSpWHyg745lPIa5mbdaX0T1BqPn3
 FqeOwFe6B3CR+A9LlpQ7H/SiTFVt8Dznnv6b5Kfp4eRQb/djdZbD2ckEF5C3niM+cU
 Jfj8cEeBmrhCAJhsgq8A9qWKwZTFEFl9xGMix3d/qNxJwJ+9gWeIB9UCoCYycov5+r
 jK7OPg57pU43cD0NG/iaTnoIHVQbj9SQr+5ayOyLizjy8QThf/uOPFfPWuX6P51Agj
 BJCdGlxIK+M7A==
Message-ID: <8469e2d49da7e9257f59925b69cc9d7d@kernel.org>
Date: Mon, 12 Oct 2026 07:33:37 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: =?utf-8?b?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>
Subject: Re: [PATCH 1/2] drm/vc4: hdmi: Move packet RAM enable to PM runtime
In-Reply-To: <20261002-vc4-hdmi-packet-ram-fix-v1-1-3d73148096c9@igalia.com>
References: <20261002-vc4-hdmi-packet-ram-fix-v1-1-3d73148096c9@igalia.com>
Cc: dri-devel@lists.freedesktop.org, kernel-dev@igalia.com,
 "Dave Stevenson" <dave.stevenson@raspberrypi.com>, "David
 Airlie" <airlied@gmail.com>, "Maxime Ripard" <mripard@kernel.org>, "Raspberry
 Pi Kernel Maintenance" <kernel-list@raspberrypi.com>,
 "Simona Vetter" <simona@ffwll.ch>
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

On Fri, 2 Oct 2026 10:36:43 -0300, Ma=C3=ADra Canal wrote:
> From: Dave Stevenson <dave.stevenson@raspberrypi.com>
>=20
> Audio can be triggered by the HPD handler and start up before video has
> been restored, calling vc4_hdmi_write_infoframe() for the audio infoframe.
> vc4_hdmi_write_infoframe() needs Packet RAM to be on to store the
>=20
> [ ... ]

Acked-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime
