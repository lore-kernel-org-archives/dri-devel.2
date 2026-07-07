Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FA36C44500
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 13:25:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 477FF10ECF3;
	Tue,  7 Jul 2026 13:24:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ITM1C02I";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E026C10E4D0
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 13:24:52 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 647D1618D3;
 Tue,  7 Jul 2026 13:24:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 925621F000E9;
 Tue,  7 Jul 2026 13:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783430692;
 bh=oAxUk++V0ZyWYkuNlXsTvOnE7gFeTWviVdLyqwgBMmE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ITM1C02Ie2m9j9PcXj0slAOPXlvLPfm3YNz79/7TgJF1RaliRDq+nOJyQU9wpmLOy
 1PKfWr9KbMVc2K3y4+Mpk/I/nygk361+rCuNbnzRgUUZchqCjXdpeodhKypUOD41er
 ErkJ9kYwgJiqsQQNcWkRC6N3LvXNW3zxyjjk3JDHweTQQy6/p6jTiNMjb3RXT8n89a
 7Xt8mEm7PrTV4wJge32yiSL5Ma1uhcWokfUUNogRQK2YXXi8Uwufq4Mi7pXkMCoPS1
 ZrbtBscLvhKcOy8qtyFwln4GKJAmPSPjxI4aCZ4i72p2yJAYlCPsQiua1BFOfdklzz
 z/NG9n950HvIQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 05/20] driver core: update kerneldoc for
 platform_device_alloc()
To: "Bartosz Golaszewski" <bartosz.golaszewski@oss.qualcomm.com>
Cc: devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
 conor+dt@kernel.org, lee@kernel.org, mfd@lists.linux.dev, robh@kernel.org,
 imx@lists.linux.dev, Frank.Li@kernel.org
In-Reply-To: <20260706-pdev-fwnode-ref-v3-5-1ff028e33779@oss.qualcomm.com>
References: <20260706-pdev-fwnode-ref-v3-0-1ff028e33779@oss.qualcomm.com>
 <20260706-pdev-fwnode-ref-v3-5-1ff028e33779@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 13:24:51 +0000
Message-Id: <20260707132451.925621F000E9@smtp.kernel.org>
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

> Users of platform_device_alloc() + platform_device_add() must not modify
> certain fields of the dynamically created platform device object. Update
> the kernel doc to say which fields are affected and which functions to
> use.
>=20
> Suggested-by: Manuel Ebner <manuelebner@mailbox.org>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706-pdev-fwnod=
e-ref-v3-0-1ff028e33779@oss.qualcomm.com?part=3D5

