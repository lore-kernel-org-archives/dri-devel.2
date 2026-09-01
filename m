Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F851C61DD3
	for <dri-devel@archiver.kernel.org>; Tue,  1 Sep 2026 08:53:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6611C10EC06;
	Tue,  1 Sep 2026 08:53:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="hkPW4V2B";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB8E710EC06
 for <dri-devel@lists.freedesktop.org>; Tue,  1 Sep 2026 08:53:01 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C37E360202;
 Tue,  1 Sep 2026 08:53:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E16ED1F000E9;
 Tue,  1 Sep 2026 08:52:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788252780;
 bh=wo1uoSKcAfYycb95U7W59yKIhWzIPZ1x10kTnHmt6xs=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=hkPW4V2Bhpnval62c+/s61M7a7pVQq4gmqgOh7cwLCWNn4Tt49tkaQqhYXEhnrzWt
 qm+tsL9ldNlCE3J2ocO6AXg68TAIMPrfjLxlEr4G5V+4yfNfYvGy3JzudsbzV2u4gd
 +wlrWTb6cNgzfAmuL2rc/GxareQuH65z8rtlyy+kyHmeYkXXdCM2n3gwIT58Zb0zBr
 QM5YdQqgz/3koxHLD15u3pPQ5KMf8jTsJKpiFbONFNR8aDC3OWHBaiFMhcOjvUN4W1
 H9tkpxJn3+Rj4DLxLIXfG5L/fFzknPzHDrhcQzv8i7q1EwfTPA2S+zSunzwYyAsC5f
 uk1t6Ti/gjOow==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/6] dt-bindings: arm: qcom: document Radxa Dragon Q8B
To: "Xilin Wu" <sophon@radxa.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-pci@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20260901-q8b-dts-v1-4-7de0b6a73d08@radxa.com>
References: <20260901-q8b-dts-v1-0-7de0b6a73d08@radxa.com>
 <20260901-q8b-dts-v1-4-7de0b6a73d08@radxa.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 08:52:59 +0000
Message-Id: <20260901085259.E16ED1F000E9@smtp.kernel.org>
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

> The Radxa Dragon Q8B is a single-board computer based on the Qualcomm
> SC8280XP platform.
>=20
> Document its radxa,dragon-q8b compatible.
>=20
> Signed-off-by: Xilin Wu <sophon@radxa.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901-q8b-dts-v1=
-0-7de0b6a73d08@radxa.com?part=3D4

