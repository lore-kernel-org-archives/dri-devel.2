Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23F4EC61DCB
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 13:52:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B52810E029;
	Fri, 28 Aug 2026 13:52:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="DpkrMTyk";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 561C410E029
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 13:52:34 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 90E35601FD;
 Fri, 28 Aug 2026 13:52:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A50281F000E9;
 Fri, 28 Aug 2026 13:52:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787925153;
 bh=v5B/fiOqedgCBxcCieptb7KGyc9EvkPc2fTNjN6aglI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=DpkrMTykW2r8Pzk9IvIE3hcAJtoRhIwOvD96MRnYZI1pTXm4WfTbyGmvO4D74VcVt
 58gtXRg5zdJoh4b/oiUT3kaVb3W93Pn4lg9HLCkiXFgUIA7TRdSHta4nUXE6SeeU23
 ZM6xkOa64XUL3Zrn39v1QkfuTqvOF6gzWQHpZE64XcEv0nZLOHCY+E/z/0xBq8ydOj
 QnabfkHLd5h7nVmKpB3zcC/E7tPVjXxokrQjtUXBhD5T2/CQUK5pGCpJZ640qubwoE
 3wDQV141E9M+D3gjvWKlXOtv3Ga1SEral+cn9hw4CSpKKsNv2qRN950Ya6sz6uiRMp
 d/wBlFPEmxpcw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 07/15] drm/bridge: inno-hdmi: Add .mode_valid
 platform operation
To: "Michal Wilczynski" <m.wilczynski@samsung.com>
Cc: robh@kernel.org, conor+dt@kernel.org, lee@kernel.org, mfd@lists.linux.dev,
 devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-clk@vger.kernel.org, olteanv@gmail.com, vkoul@kernel.org,
 linux-phy@lists.infradead.org, neil.armstrong@linaro.org
In-Reply-To: <20260828-jh7110-clean-send-v2-7-331680c8b9d1@samsung.com>
References: <20260828-jh7110-clean-send-v2-0-331680c8b9d1@samsung.com>
 <CGME20260828134826eucas1p1ed3a0c4a3207dc01d1ccb33e45ae462e@eucas1p1.samsung.com>
 <20260828-jh7110-clean-send-v2-7-331680c8b9d1@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 28 Aug 2026 13:52:32 +0000
Message-Id: <20260828135232.A50281F000E9@smtp.kernel.org>
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

> inno_hdmi_bridge_mode_valid() validates the pixel clock against
> hdmi->refclk, but that clock is optional and is only present on
> platforms that describe a "ref" clock. Platforms where the pixel clock
> is produced by a separate device - such as the StarFive JH7110, whose
> PHY is both the clock and the PHY provider - have no "ref" clock, so
> the check is skipped entirely and every mode is reported as valid.
>=20
> A mode the platform cannot generate is then advertised to userspace.
> The subsequent modeset appears to succeed, since the atomic enable path
> cannot fail, and the display silently stays blank.
>=20
> Add a .mode_valid platform operation so platforms can reject modes they
> are unable to drive. Platforms that do not implement it are unaffected.
>=20
> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260828-jh7110-cle=
an-send-v2-0-331680c8b9d1@samsung.com?part=3D7

