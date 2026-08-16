Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1296C5DF66
	for <dri-devel@archiver.kernel.org>; Sun, 16 Aug 2026 11:04:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B544F10E1D3;
	Sun, 16 Aug 2026 11:04:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="J4D4hN1D";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7AF9D10E1D3
 for <dri-devel@lists.freedesktop.org>; Sun, 16 Aug 2026 11:04:02 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3E6146001D;
 Sun, 16 Aug 2026 11:04:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 845E21F000E9;
 Sun, 16 Aug 2026 11:04:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786878241;
 bh=9dASDDZxU/aATZBFp2TVto24ZOzqm9T5n9Eh/VZgRf8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=J4D4hN1DuCdx0cRcO98WW4tzTPYX8kxiROKmOpPig7q4dMIs2ztzTkrDk/6H0uPe/
 no8eCt+Judgfq5NvXPSoy7OjGPoX5LZTDrZDZNXWHMvDnmdN7HfbSo+HtdqD2mQFo6
 z04mmrcb5mU+ZufkjCP7/VAKjP0y/4/bhqGTsyYPiFct8r1UK/m4CBdT2lb4HeDVLj
 0FhVDPxtFaTM4f9oSCu4nvQ2R476nhVWM7kw1UEob62k14Wg5LYKgOU5y+x1PPFNFy
 HjdNbo0o1dT9th9zmn4cRUcErcnqa4Iz+s0AO1QDw+nqI5ORhLi5CCVaTsL0oapJOG
 IvIuTDSUGncug==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: backlight: Add Orient Chip OCP8178
To: "Wim de With" <wf@dewith.io>
Cc: lee@kernel.org, robh@kernel.org, conor+dt@kernel.org,
 dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
 devicetree@vger.kernel.org
In-Reply-To: <20260816-ocp8178-backlight-v3-1-caf95c453c50@dewith.io>
References: <20260816-ocp8178-backlight-v3-0-caf95c453c50@dewith.io>
 <20260816-ocp8178-backlight-v3-1-caf95c453c50@dewith.io>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 16 Aug 2026 11:04:00 +0000
Message-Id: <20260816110400.845E21F000E9@smtp.kernel.org>
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

> Add device tree bindings for the Orient Chip OCP8178 LED backlight
> driver.
>=20
> Signed-off-by: Wim de With <wf@dewith.io>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260816-ocp8178-ba=
cklight-v3-0-caf95c453c50@dewith.io?part=3D1

