Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97E7CC61DD3
	for <dri-devel@archiver.kernel.org>; Tue,  1 Sep 2026 08:51:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C2BD110EC00;
	Tue,  1 Sep 2026 08:51:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="RNn+8kA/";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D938F10EC00
 for <dri-devel@lists.freedesktop.org>; Tue,  1 Sep 2026 08:51:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 86975419B9;
 Tue,  1 Sep 2026 08:51:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F3D21F000E9;
 Tue,  1 Sep 2026 08:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788252673;
 bh=8bhpuPqrKNPd3wQ5ooSMsA2/3+t9JJjXowS6BSa84ww=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=RNn+8kA/7ecJjXOWiejGKHdCj57MhKcVd4C600zds6kZTj/iecghHWVVidMpLqc/7
 ggi6KjqUMjTsAPWDXDvzQD3WzusUyL6UTyOKWxezTuhsbN+MfNzOLVXkpcJVNHh3pi
 4Vm3zqL3n67LmOn4IKru8thcov4kZrYVnL6to+gruQoLUtGaCBd6AuW/GgtWC4vqIR
 nPu6zEtRK4PdbiQrV0xFGl4epnoBuoTVjJVDFqH9wPrCJf9d95gjDwXkUrvvzsL7PD
 RLIijuku8QCSf2PnN6jvPn5wEZfIzzlZtNosYv2pxQjsBVNAxfXOqQonafOlQOtnRw
 gGCcFChjuE0/Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/6] drm/bridge: simple: add Chrontel CH7218A
To: "Xilin Wu" <sophon@radxa.com>
Cc: dri-devel@lists.freedesktop.org, robh@kernel.org,
 devicetree@vger.kernel.org, linux-pci@vger.kernel.org, conor+dt@kernel.org
In-Reply-To: <20260901-q8b-dts-v1-3-7de0b6a73d08@radxa.com>
References: <20260901-q8b-dts-v1-0-7de0b6a73d08@radxa.com>
 <20260901-q8b-dts-v1-3-7de0b6a73d08@radxa.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 08:51:12 +0000
Message-Id: <20260901085113.0F3D21F000E9@smtp.kernel.org>
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

> The Chrontel CH7218A automatically boots its embedded firmware and
> operates without host-side configuration.
>=20
> Add the CH7218A to the simple bridge driver and expose its output as an
> HDMI Type-A connector.
>=20
> Signed-off-by: Xilin Wu <sophon@radxa.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901-q8b-dts-v1=
-0-7de0b6a73d08@radxa.com?part=3D3

