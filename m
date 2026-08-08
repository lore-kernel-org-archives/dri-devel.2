Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47118C5AD2C
	for <dri-devel@archiver.kernel.org>; Sat,  8 Aug 2026 08:14:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 795B010E02C;
	Sat,  8 Aug 2026 08:14:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="VvUKKb/p";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 29CE010E02C
 for <dri-devel@lists.freedesktop.org>; Sat,  8 Aug 2026 08:14:03 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3890C600B1;
 Sat,  8 Aug 2026 08:14:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C0841F000E9;
 Sat,  8 Aug 2026 08:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786176841;
 bh=jxl10uy4NJVNxI9UzhYrVJzWT2OXGFU8sa1A+23EP0w=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=VvUKKb/poMllu3PiXNbmMYvZW4TW/lyoXj7C8s5V3R9kPvDzdw9QiHDPsWNgxzhj5
 092/H3eUNBrjG4CCS1Fc/KLZtzG6VmNDRkzc4RK5kN6SkW5mLl0vywHHAd/bKqCb2o
 mP+mK4T2GqVPqzZPnWcuyVH1BO/GyLG7DXvT8qE0jUzJHO+QX9UScrreA3ukxmq1mW
 MQ/wwS+6/AsrJzGZmtMvi4gFPTt1IMkeDCBX2o7Yrj7nZOnPXg55mZEI86WpQB2Rdx
 ToBCU6sySZ+dtVOyMgKM6Eiv/bgUUQQEBGPs/J9CtulY+2FEsJM8ntS/15qWc6DJ9+
 M4nQneuE7hAng==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 1/2] dt-bindings: bridge: Add Lontium
 LT9611C(EX/UXD) MIPI DSI to HDMI driver
To: mohit.dsor@oss.qualcomm.com
Cc: robh@kernel.org, conor+dt@kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org
In-Reply-To: <20260808-lt9611c-v7-v10-1-ee90a136d82a@oss.qualcomm.com>
References: <20260808-lt9611c-v7-v10-0-ee90a136d82a@oss.qualcomm.com>
 <20260808-lt9611c-v7-v10-1-ee90a136d82a@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 08 Aug 2026 08:14:00 +0000
Message-Id: <20260808081401.3C0841F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Low] The binding title inaccurately describes all variants as '2 Port', =
despite the newly added LT9611C being a 1-port device.
- [Low] The commit message contains a typo that changes the meaning and mak=
es the sentence difficult to understand: 'Receiver signal/dual port' instea=
d of 'receives single/dual port'.
--

--- Patch [1]: [PATCH v10 1/2] dt-bindings: bridge: Add Lontium LT9611C(EX/=
UXD) MIPI DSI to HDMI driver ---
commit 289235c0c9457d9357c713f43f18d3182cc0f7d7
Author: Sunyun Yang <syyang@lontium.com>

dt-bindings: bridge: Add Lontium LT9611C(EX/UXD) MIPI DSI to HDMI driver

This commit updates the Lontium LT9611 bridge bindings to add support for
the LT9611C, LT9611EX, and LT9611UXD variants. It adds the new compatible
strings and enforces a single-port configuration specifically for the LT961=
1C.

> LT9611C(EX/UXD) is an I2C-controlled chip that Receiver signal/dual port
> mipi dsi and output hdmi, differences in hardware features:

[Severity: Low]
This isn't a bug, but there appear to be a few typos in this description.
Would it be clearer to rephrase "Receiver signal/dual port" to "receives
single/dual port"?

> diff --git a/Documentation/devicetree/bindings/display/bridge/lontium,lt9=
611.yaml b/Documentation/devicetree/bindings/display/bridge/lontium,lt9611.=
yaml
> index 429a06057ae85..194aeaac601f3 100644
> --- a/Documentation/devicetree/bindings/display/bridge/lontium,lt9611.yaml
> +++ b/Documentation/devicetree/bindings/display/bridge/lontium,lt9611.yaml
> @@ -4,19 +4,23 @@
>  $id: http://devicetree.org/schemas/display/bridge/lontium,lt9611.yaml#
>  $schema: http://devicetree.org/meta-schemas/core.yaml#
> =20
> -title: Lontium LT9611(UXC) 2 Port MIPI to HDMI Bridge
> +title: Lontium LT9611(UXC/C/EX/UXD) 2 Port MIPI DSI to HDMI Bridge

[Severity: Low]
This isn't a bug, but does the "2 Port" descriptor still apply to all the
variants listed here?=20

Since the LT9611C is described in the commit message as a 1-port device and
its second port is correctly disabled later in this schema, retaining "2 Po=
rt"
in the overall title might cause some confusion.

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260808-lt9611c-v7=
-v10-0-ee90a136d82a@oss.qualcomm.com?part=3D1
