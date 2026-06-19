Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64F93CD98F8
	for <dri-devel@archiver.kernel.org>; Fri, 19 Jun 2026 17:05:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 15F4810E0D1;
	Fri, 19 Jun 2026 17:05:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Gv6xr8WK";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D2E910E0D0
 for <dri-devel@lists.freedesktop.org>; Fri, 19 Jun 2026 17:05:03 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1FCFE601F2;
 Fri, 19 Jun 2026 17:05:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 575281F00A3D;
 Fri, 19 Jun 2026 17:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781888702;
 bh=HkeFeRTWOk4VOrJCSpjbq1rbFgylJxEdA96UbntTN2g=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Gv6xr8WKeGiiMk41Fk3VCaPN3dOrA7zLo3G/xXjk68pQutAxbFmAWLnxgH5BAamU2
 W/BDK1ktqicPTxt5NCQuGnMq8ynderdyKlNnDoNCGnhFctTVOpQKcNE0A7fNkYikFK
 5ZVGuP1kmZP/eLCcQWe7maSnWxQWr3Ze70GizY3JU5iWChGZr9UP2oirBjRbrCu5Ud
 uxxDMLD0x06op4Ot8OcUek4x4PRLUdASbbqdSCTRnsrw2AsvBrfCeHjzoACa2Tjzd0
 1R+t+2UKf4hqL66vbnBVCg93aMG5SmXZ8k6MC+rQWNcIncgVBRUGCfB9i5IaYvYZ1R
 RpMghq5UDrXeA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 10/10] RFC: rust: driver: support map-like syntax for ID
 table
To: "Gary Guo" <gary@garyguo.net>
Cc: robh@kernel.org, dri-devel@lists.freedesktop.org, conor+dt@kernel.org,
 ojeda@kernel.org, linux-pci@vger.kernel.org, "Danilo
 Krummrich" <dakr@kernel.org>, "Alexandre Courbot" <acourbot@nvidia.com>,
 devicetree@vger.kernel.org
In-Reply-To: <20260618-id_info-v1-10-96af1e559ef9@garyguo.net>
References: <20260618-id_info-v1-0-96af1e559ef9@garyguo.net>
 <20260618-id_info-v1-10-96af1e559ef9@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 19 Jun 2026 17:05:01 +0000
Message-Id: <20260619170502.575281F00A3D@smtp.kernel.org>
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

> The device ID table and its associated info is really just a map. Add a
> syntax to `module_device_table` macro that reflects that.
>=20
> Signed-off-by: Gary Guo <gary@garyguo.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260618-id_info-v1=
-0-96af1e559ef9@garyguo.net?part=3D10

