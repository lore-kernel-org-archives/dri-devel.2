Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0117C43458
	for <dri-devel@archiver.kernel.org>; Sat, 11 Jul 2026 06:13:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 598A610E735;
	Sat, 11 Jul 2026 06:13:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="oTnxTwgf";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4658210E742
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Jul 2026 06:13:14 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E779A4121A;
 Sat, 11 Jul 2026 06:13:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66D941F000E9;
 Sat, 11 Jul 2026 06:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783750393;
 bh=it+oYZ5v0yCTmLV9Pvin6MNvwGCKJHsdbn7h5XwmXu8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=oTnxTwgfhkvjT7YP7ausmO+U4DunkS/96yD982GkHx1109Yu2BU1g+JzGNwBVlyR8
 CQ8803CP10jvRZDqCEJvgqPnlj7Q9NtrupIhRfoqQkoqAvj60FWS0WV8gC8kXTIPKh
 HRiP4x0FTmMMil4PLqRlFjVa1pPjWLCUFME30Knhq5NmfPi8cv2hqVj7axedLyruu1
 8lzCJqf3AC4fZ8CLCFiHkDa5qmG2lMiIxKQGHqZeQPCoKjaowyoqvClIVhJm2t7qTG
 oeAwNRZYVEtZ9bX42C3EBLNz7Ei+EZAp3E2LV3duGkjDnbMSLfiiahVUexvQbDVXfS
 YJqJE4rIcOvKg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 16/16] arm: omap2: remove remaining pdata-quirks for
 pandora legacy devices
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: robh@kernel.org, dri-devel@lists.freedesktop.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org, mfd@lists.linux.dev, lee@kernel.org
In-Reply-To: <d380941287c655a3d205ee8b08516d364c0ddec9.1783749722.git.hns@goldelico.com>
References: <cover.1783749722.git.hns@goldelico.com>
 <d380941287c655a3d205ee8b08516d364c0ddec9.1783749722.git.hns@goldelico.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 11 Jul 2026 06:13:12 +0000
Message-Id: <20260711061313.66D941F000E9@smtp.kernel.org>
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

> After updating the pandora-backligt setup and removing the omap3pandora
> sound system and defining related gpios by device tree, we can remove
> omap3_pandora_legacy_init() and the related legacy devices completely.
>=20
> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1783749722.gi=
t.hns@goldelico.com?part=3D16

