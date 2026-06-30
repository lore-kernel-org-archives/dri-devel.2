Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA604C43458
	for <dri-devel@archiver.kernel.org>; Tue, 30 Jun 2026 12:40:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4CEED10EC5C;
	Tue, 30 Jun 2026 12:40:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="RRUvHqpP";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6080F10EC6A
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 12:40:16 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D4B83600BB;
 Tue, 30 Jun 2026 12:40:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 798A71F000E9;
 Tue, 30 Jun 2026 12:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782823215;
 bh=pkOfWleTAoRTBq+Oo5iJfbPZ0XHswf3coUym+OIUsVI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=RRUvHqpPkYvquyRFGM5LH0H2ZROJL43y+UX5njVPQzxeaL+ioroDnSCYFjHMkcnM/
 MuO24o0G9wcOWs9ymFIRBvMFTPWNfHUjtubUDjAMfCfnvpBRHOJ6KZxB2DGgzRJTke
 sVbaIP6rzKhPAI52BFJwmqYkIaf+XoTRXzd+hkGXpMTbvfezMTKCIvi7zQnDuj9qH5
 rTvsFkx7U9td6Cr93yG94YnBmDttlCsvl/znc5MSP9EdZhbJCeRCoqPF6NpaxVcubs
 +jHetG6MYpf9PwJwdKKTAeKEKeDnc/IeOTGQEqESujuNH0QBhqlxzsijX88OneeqLE
 TTMDl11xe20WA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 05/11] rust: net/phy: remove expansion from doc
To: "Gary Guo" <gary@garyguo.net>
Cc: "Alexandre Courbot" <acourbot@nvidia.com>, robh@kernel.org, "Danilo
 Krummrich" <dakr@kernel.org>, conor+dt@kernel.org,
 dri-devel@lists.freedesktop.org, linux-pci@vger.kernel.org,
 devicetree@vger.kernel.org, ojeda@kernel.org
In-Reply-To: <20260629-id_info-v2-5-56fccbe9c5ef@garyguo.net>
References: <20260629-id_info-v2-0-56fccbe9c5ef@garyguo.net>
 <20260629-id_info-v2-5-56fccbe9c5ef@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 12:40:13 +0000
Message-Id: <20260630124014.798A71F000E9@smtp.kernel.org>
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

> The expansion serves little purpose and it can easily diverge.
>=20
> Signed-off-by: Gary Guo <gary@garyguo.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260629-id_info-v2=
-0-56fccbe9c5ef@garyguo.net?part=3D5

