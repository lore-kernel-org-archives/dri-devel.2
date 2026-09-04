Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8878C624D3
	for <dri-devel@archiver.kernel.org>; Fri,  4 Sep 2026 13:30:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 381E910F938;
	Fri,  4 Sep 2026 13:30:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Imto6OsL";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A182D10F938
 for <dri-devel@lists.freedesktop.org>; Fri,  4 Sep 2026 13:30:49 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7AD5940851;
 Fri,  4 Sep 2026 13:30:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6D7F1F00A3D;
 Fri,  4 Sep 2026 13:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788528649;
 bh=IQ26GNFlKcl9SbfyYjBUWsK0WzvCiHztfchbZ3Xz8N8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Imto6OsLTI+gjfxw4DNmfbbwAhoooMnzWjRjQNIxXYSjS6WXX5xg4QSxinYrAu61z
 w8ErfeOCFFrKmk9zBSHKNYgKU7uV9RONFSZPuQysWk8P64GR4vTKafSE28kRG5P6QW
 7yHAJ6ZIiF/1PrcOSEIhtnk9k70Fyc6F1UgliOhsOccuLUKCLNgAz6LqAqkMOPXKID
 EnHqj6KCfz3UOfMvZMLr3Xf9qDndKamYZeZsxcBn4Umxp6rr3XMItXfYpnDvP9PyF4
 hxo4o+mt/lWx2WScxJhaLTcHr+X6LHKxVLwYkgUcC5IOCGQbuk2FiyV4Wp8WSOLxO7
 106FtoP/fbgKQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 04/19] dt-bindings: soc: starfive: Add
 starfive,jh7110-vout-syscon
To: "Michal Wilczynski" <m.wilczynski@samsung.com>
Cc: neil.armstrong@linaro.org, linux-phy@lists.infradead.org,
 mfd@lists.linux.dev, devicetree@vger.kernel.org, olteanv@gmail.com,
 lee@kernel.org, conor+dt@kernel.org, linux-clk@vger.kernel.org,
 dri-devel@lists.freedesktop.org, vkoul@kernel.org, robh@kernel.org
In-Reply-To: <20260904-jh7110-clean-send-v3-4-484f9ae72715@samsung.com>
References: <20260904-jh7110-clean-send-v3-0-484f9ae72715@samsung.com>
 <CGME20260904132716eucas1p2d093509db255e62e6bd546e734f04e63@eucas1p2.samsung.com>
 <20260904-jh7110-clean-send-v3-4-484f9ae72715@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 13:30:48 +0000
Message-Id: <20260904133048.B6D7F1F00A3D@smtp.kernel.org>
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

> The video output subsystem has its own system controller, documented as
> dom_vout_syscon. Among other things it holds the mux that selects which
> DC8200 output drives the HDMI transmitter, so the HDMI controller needs
> to reach it.
>=20
> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904-jh7110-cle=
an-send-v3-0-484f9ae72715@samsung.com?part=3D4

