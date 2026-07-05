Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58BEDC43458
	for <dri-devel@archiver.kernel.org>; Sun,  5 Jul 2026 21:37:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C4B710E260;
	Sun,  5 Jul 2026 21:37:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="JOzzwJ5I";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1AC5F10E260
 for <dri-devel@lists.freedesktop.org>; Sun,  5 Jul 2026 21:37:42 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9F870439CB;
 Sun,  5 Jul 2026 21:37:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 334241F000E9;
 Sun,  5 Jul 2026 21:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783287461;
 bh=igQyiJtGhKUi7hNnr0lNeoVcRSQz4YGkDdDqAW+Zo4M=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=JOzzwJ5IbEdKaH+NraZtMrJ+AkQaOQVJtpDHkYcrpZakwk/Fl/e3BnMXP9h9EVJax
 T1+we7kqUHo8/9O8UM4pALfcCR0Xj7a55KTOKXHRzRmKfh3Cq5gQNHIa1so5gpiRMd
 qdKCPyonWh1NfsTsnYgxSQQCGxCxaFF5K/wQGSpSAz1cLiQFzgCMihkHxBJ8rVTRk8
 aSfnXlX8C8vEh/lL3Nf4tJ0sHrfZwTEBiYS/I+0PlFFGAvL+EFUcinP0O6gIVlHteh
 8p5UWuL3ovxf7DaIrXi5i6fQRqFTjVq/A9Hb3b70v8XnUngOpMSICyuoNzeD8C8iIk
 FflsDJVbCIkeg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/4] [DNI] arm64: dts: renesas: salvator: Add overlay
 for Dell P1911 VGA display
To: "Laurent Pinchart" <laurent.pinchart+renesas@ideasonboard.com>
Cc: devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
 robh@kernel.org, conor+dt@kernel.org, wsa+renesas@sang-engineering.com
In-Reply-To: <20260705213542.28987-5-laurent.pinchart+renesas@ideasonboard.com>
References: <20260705213542.28987-1-laurent.pinchart+renesas@ideasonboard.com>
 <20260705213542.28987-5-laurent.pinchart+renesas@ideasonboard.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 05 Jul 2026 21:37:40 +0000
Message-Id: <20260705213741.334241F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The patch is explicitly marked as test-only and should not be me=
rged.
--

commit ec00db7021fbc2f550a150a0512dfc7596a53df2
Author: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

arm64: dts: renesas: salvator: Add overlay for Dell P1911 VGA display

This patch adds an overlay to hardcode the EDID of a Dell P1911 VGA display
connector to the VGA port of the Salvator board.=20

> Add an overlay that hardcodes the EDID of the Dell P1911 VGA display
> connector to the VGA port of the Salvator board. This is meant to test
> EDID hardcoding and should not be merged upstream.

[Severity: Medium]
The commit message explicitly states this is meant to test EDID hardcoding=
=20
and should not be merged upstream.

Was this patch accidentally included in this series, or is it intended to be
dropped by the maintainer before final merging?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260705213542.2898=
7-1-laurent.pinchart+renesas@ideasonboard.com?part=3D4
