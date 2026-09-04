Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51445C624D3
	for <dri-devel@archiver.kernel.org>; Fri,  4 Sep 2026 13:36:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 932D610F977;
	Fri,  4 Sep 2026 13:36:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="bV9Z964k";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1AD8D10F977
 for <dri-devel@lists.freedesktop.org>; Fri,  4 Sep 2026 13:36:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 37080600C8;
 Fri,  4 Sep 2026 13:36:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 482171F00A3D;
 Fri,  4 Sep 2026 13:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788528979;
 bh=9OynDTj7/r9SMGiQ1vFJnjLdakrtzGm9dYHSB/gUz/I=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=bV9Z964kz/ZYdIPGrLirIaErZAviT2/XjlM7ccRaR/LBMfq3IVTZXvbfBx9xUYTlR
 MVCx135V/DYMwYHR1J4GXIsNe0/H+jcgcuGCUN7z0FxIiWcuqW/NYA/lX6kr8+Y+V0
 oIrDtcvK/tC7LYYMECHg/rTl7cUODWd4bh/vBijnqnkh7+ndPBllks5BdYZCjq/KhE
 0RmIMlzZd8ldfi6W+VToEqJwPZLuzPNbm1E34fjojdOdoBOSL0rMiH4JQLW7pnP7xu
 SEF/Cc/b583v/8jw8FUyai7KNnsDzCXzvVVo2W+iyoS6Adrr3BqGsEh+CQOo/t/bin
 UDZek+Pvs8V8g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 05/19] dt-bindings: soc: starfive: Add
 starfive,jh7110-vout-subsystem
To: "Michal Wilczynski" <m.wilczynski@samsung.com>
Cc: linux-clk@vger.kernel.org, linux-phy@lists.infradead.org,
 mfd@lists.linux.dev, dri-devel@lists.freedesktop.org, lee@kernel.org,
 devicetree@vger.kernel.org, neil.armstrong@linaro.org, robh@kernel.org,
 conor+dt@kernel.org, vkoul@kernel.org, olteanv@gmail.com
In-Reply-To: <20260904-jh7110-clean-send-v3-5-484f9ae72715@samsung.com>
References: <20260904-jh7110-clean-send-v3-0-484f9ae72715@samsung.com>
 <CGME20260904132718eucas1p1b25abe6cd0562e47dfeb75f8877e47b0@eucas1p1.samsung.com>
 <20260904-jh7110-clean-send-v3-5-484f9ae72715@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 13:36:18 +0000
Message-Id: <20260904133619.482171F00A3D@smtp.kernel.org>
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

> The JH7110 groups its display hardware into a video output subsystem,
> dom_vout_top, covering the DC8200, the HDMI transmitter, the video
> output clock generator and the video output system controller.
>=20
> They share one NoC port whose clock and reset gate access to every
> register in the region, and the region sits in the PD_VOUT power
> domain. Describe the subsystem as a bus node so those resources are
> owned by the block that shares them, rather than by whichever consumer
> happens to probe first.
>=20
> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904-jh7110-cle=
an-send-v3-0-484f9ae72715@samsung.com?part=3D5

