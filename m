Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 818AFC88E50
	for <dri-devel@archiver.kernel.org>; Fri, 11 Sep 2026 08:53:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B478310E029;
	Fri, 11 Sep 2026 08:53:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="NcLYSn0p";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 98A7F10E029
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 08:53:35 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6B41543B46;
 Fri, 11 Sep 2026 08:53:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE7BB1F000FF;
 Fri, 11 Sep 2026 08:53:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789116815;
 bh=UPAd5pd/ujZq6oZPZ0EtGkW6xgwZq/lTZtHLSrATxpo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=NcLYSn0pIoj6uEfqc5/wYdxWOu5hKkAG9b3zfDTNxOl37m9QJN0+tfKc8Nojn9pVB
 2vxMlA9d4m7ax7aQqvzjvOq6OyienTAajENihoe5RMRyq+Nd/UjLatQGD7O0v/wznj
 NpleGNOCbzmAl+lm8do/kdKB+dhjuCv64mvMshpoCJI4vVpSaXvJBVvdybs7YX0WyO
 upi0ZYuMslvyHhYhholGMcEPWSWzM77G05X1TOuQ3Uea0h2HHx6yj8c6GrPtZGy4Bu
 3wUHqZKnfTS5/4pBABAsm9mXoo+NXOvgBcgpI1aJmBQ4UB0Ty1jWG6nIUCTvPzN4tl
 cYEY+kMsfso5w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 03/10] dt-bindings: display: panel:
 novatek,nt36672a: add Tianma FHD+ video mode variant
To: =?utf-8?b?WcSwxJ7EsFRDQU4gS0FWQUtMSQ==?= <kavakliyigitcan@gmail.com>
Cc: dmitry.torokhov@gmail.com, devicetree@vger.kernel.org, lee@kernel.org,
 conor+dt@kernel.org, linux-leds@vger.kernel.org, linux-input@vger.kernel.org,
 dri-devel@lists.freedesktop.org, robh@kernel.org
In-Reply-To: <20260911-ginkgo-submission-final-v1-3-0e68e63a18d4@gmail.com>
References: <20260911-ginkgo-submission-final-v1-0-0e68e63a18d4@gmail.com>
 <20260911-ginkgo-submission-final-v1-3-0e68e63a18d4@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 08:53:32 +0000
Message-Id: <20260911085334.CE7BB1F000FF@smtp.kernel.org>
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

> From: Y=C4=B0=C4=9E=C4=B0TCAN KAVAKLI <kavakliyigitcan@gmail.com>
>=20
> Add compatible string "tianma,fhd-video-ginkgo" for the 1080x2340 Tianma
> video mode panel found on the Xiaomi Redmi Note 8 (ginkgo / SM6125).
>=20
> The downstream vendor DT identifies the panel as "nt36672a video mode
> dsi tianma panel" without documenting a glass model number. Following
> the established convention of "tianma,fhd-video" for Poco F1, this
> variant is added under the existing NT36672A binding schema.
>=20
> Signed-off-by: Y=C4=B0=C4=9E=C4=B0TCAN KAVAKLI <kavakliyigitcan@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911-ginkgo-sub=
mission-final-v1-0-0e68e63a18d4@gmail.com?part=3D3

