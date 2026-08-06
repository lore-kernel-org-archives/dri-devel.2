Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5F71C56208
	for <dri-devel@archiver.kernel.org>; Thu,  6 Aug 2026 20:33:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E25310E3AD;
	Thu,  6 Aug 2026 20:33:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Z89gFMy6";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6082110E3AD
 for <dri-devel@lists.freedesktop.org>; Thu,  6 Aug 2026 20:33:41 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1581241FA9;
 Thu,  6 Aug 2026 20:33:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F22C1F000E9;
 Thu,  6 Aug 2026 20:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786048421;
 bh=4NG2UIBW6bwWmVbMIa1q6Az1uhycIM5CpibMhj4L1ys=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Z89gFMy6n7lnb6ys7MheTYZOsQi/XwyRNFwg+BDVctJJZNrg0hwkDetMhlcxn2LBq
 WyrvvFWVzsrWvdYeMD7rpsm3lDQOv4r/UYk2zJ+/c9C3zTHFkeNlcG444PuyhmOyK2
 vp3I2E04vYaMcTt9sY8fef74xfnvymBdGWb/KXUscLT/3liWp3EfjfIObyflqMuuK0
 y8dSyOC+SGlRjIOd93qf0cq5wr0sKycsW/zh6T3mAHK3pEZN6mo8+JUvgkv3tFG1dA
 YWoEk+GctUFxEF6IR6ldgML4v9d/NIyLLAykJqt+uYfNbSAnfKqrewo9s/wEkeY6Wj
 BTZdVVa0JinDA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: backlight: Add Orient Chip OCP8178
To: "Wim de With" <wf@dewith.io>
Cc: devicetree@vger.kernel.org, conor+dt@kernel.org, lee@kernel.org,
 linux-leds@vger.kernel.org, robh@kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260806201541.101304-2-wf@dewith.io>
References: <20260806201541.101304-1-wf@dewith.io>
 <20260806201541.101304-2-wf@dewith.io>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Aug 2026 20:33:39 +0000
Message-Id: <20260806203340.3F22C1F000E9@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260806201541.1013=
04-1-wf@dewith.io?part=3D1

