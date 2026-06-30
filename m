Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 343A9C43458
	for <dri-devel@archiver.kernel.org>; Tue, 30 Jun 2026 12:40:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 52CD410EC6B;
	Tue, 30 Jun 2026 12:40:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="gf3ImPiv";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 03FCE10EC5C
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 12:40:18 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 7AFB3600FC;
 Tue, 30 Jun 2026 12:40:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB16A1F00A3A;
 Tue, 30 Jun 2026 12:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782823217;
 bh=9tEI3Mf9LgaO7NuUJ1Z1VC6cJGXWaPnICD69M0a8eG8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=gf3ImPivuT5OL9OMWSwitcdZotgW2kOQeBCdoJjKCz1cOgGJAPNW6E87nQ6/0yA8k
 y/mjumuJqOB7Pu3vCLWrbNlyQrECaoUSwbdREJ2FWpNtUCHcIIz9wI5JtvBtmBWwjJ
 O5xhvckdbu22aMB3FGkFlqZPEnn1S8Ij02hIl6OoILSUcq8fDd5ZJzTbKmrZDu346W
 8UmumK2eZvt86MXsay/p+KZdaNP90y0DSqQ07pVAB7gQh5vOsOvmZABZ2z136WGOzj
 toYnAx/hAoBgyZsOO432B24c/qB6HbXe6qq3+VQcpkayH3nosFlxzA3eJeJAYjqh9R
 opdL9O0pXBhlA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 06/11] rust: driver: centralize device ID handling
To: "Gary Guo" <gary@garyguo.net>
Cc: conor+dt@kernel.org, dri-devel@lists.freedesktop.org,
 linux-pci@vger.kernel.org, devicetree@vger.kernel.org, ojeda@kernel.org,
 "Danilo Krummrich" <dakr@kernel.org>, robh@kernel.org,
 "Alexandre Courbot" <acourbot@nvidia.com>
In-Reply-To: <20260629-id_info-v2-6-56fccbe9c5ef@garyguo.net>
References: <20260629-id_info-v2-0-56fccbe9c5ef@garyguo.net>
 <20260629-id_info-v2-6-56fccbe9c5ef@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 12:40:16 +0000
Message-Id: <20260630124016.AB16A1F00A3A@smtp.kernel.org>
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

> Move the `IdArray` creation from individual buses to be handled by shared
> code in `device_id.rs`.
>=20
> Signed-off-by: Gary Guo <gary@garyguo.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260629-id_info-v2=
-0-56fccbe9c5ef@garyguo.net?part=3D6

