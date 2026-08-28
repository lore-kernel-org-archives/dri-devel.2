Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D36C6C61DCB
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 13:54:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 46C1410F3B4;
	Fri, 28 Aug 2026 13:54:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ca3Y43Ch";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A028E10F3B4
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 13:54:06 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 896F342A2A;
 Fri, 28 Aug 2026 13:54:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFEEE1F00A3A;
 Fri, 28 Aug 2026 13:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787925246;
 bh=maQivNSpVB6XnV3+sMBf45xqEAzNIfoDtkLG4/jfn8c=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ca3Y43Chb02BOJL6TOm2FitB7BSMh0O48UZybds5F69yKQ9Zw+q7IHt9xIb7xndDF
 R4RLcUp5Z2GO4iWA+vsf+XrF3mOA8Yptv+L19DUD3cZHFWBvKeoetGVlEIn+JCO+Zk
 +Ef1ieO5BJI1jJg3q/P+2FNtQ3G+o1t8F5+yUSK1zLC6CQwgqjC3izyarMb9FbuddK
 l9TmFrftUE1bQMPhktQybucAr1cIUosw9ECGrr0vLnbhLQal1WjjzB0ZVspApyrIfJ
 tOhmvwrNtnhxAAR/dddL0E88TOvj+qVRFQ4bVmvWWDxCWBAYnRTJO7z1PZxTDusuv5
 Wva5yANyblIEA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 01/15] dt-bindings: phy: Add
 starfive,jh7110-inno-hdmi-phy
To: "Michal Wilczynski" <m.wilczynski@samsung.com>
Cc: devicetree@vger.kernel.org, lee@kernel.org, vkoul@kernel.org,
 conor+dt@kernel.org, linux-clk@vger.kernel.org, linux-phy@lists.infradead.org,
 mfd@lists.linux.dev, neil.armstrong@linaro.org, robh@kernel.org,
 dri-devel@lists.freedesktop.org, olteanv@gmail.com
In-Reply-To: <20260828-jh7110-clean-send-v2-1-331680c8b9d1@samsung.com>
References: <20260828-jh7110-clean-send-v2-0-331680c8b9d1@samsung.com>
 <CGME20260828134815eucas1p2b2aabc17e9cc6346e5a93bde5c650958@eucas1p2.samsung.com>
 <20260828-jh7110-clean-send-v2-1-331680c8b9d1@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 28 Aug 2026 13:54:04 +0000
Message-Id: <20260828135405.CFEEE1F00A3A@smtp.kernel.org>
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

> Add the dt-binding for the StarFive JH7110 Innosilicon HDMI PHY.
>=20
> This device is a child of the starfive,jh7110-hdmi-subsystem node. It
> functions as both a PHY provider for the controller and as a clock
> provider for the variable pixel clock (hdmi_pclk), which it generates
> from its refoclk.
>=20
> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260828-jh7110-cle=
an-send-v2-0-331680c8b9d1@samsung.com?part=3D1

