Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A71A7C43458
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 07:35:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E179E10E7C3;
	Mon,  6 Jul 2026 07:35:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="h152Xv1c";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6CED310E7C3
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 07:35:17 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4BB514156F;
 Mon,  6 Jul 2026 07:35:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE07E1F00A3A;
 Mon,  6 Jul 2026 07:35:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783323317;
 bh=1VKGll8VO7q01/u+rSZ+/ZBVXEteUob5QpHa0DFBAYE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=h152Xv1c9JnC7ZCYhL0We4s2tV2ZYo7OBn6zlfHoygP9aMXxe4XWzKsN7bMyys8r0
 30fI2b7aStcYWwjVLxrLJjNTB4zX2+0v9z+iFyD3mlTFm1HgsGXyJOGLDvaTbICtLP
 zwlu5xbbdU+oKaG2emZVYZGkst23hdq1wf6izMKItDk4+wdoCw/u3BvrK4jA4xgRHP
 hv3ZWcVp48dhhqLAb84vDJDAhl9JCBmFaBTU8XEDFgbeBx/SO/lNzAryiejLyAFDt9
 bYibfj9gWDd9lHiIYnB3glcUMdqEIJsUB/FIQXnjQUaXOTM/YY77h4fvSEYtKBVDql
 FaztXIHN+JDSA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] MAINTAINERS: update my email address for the AW99706
 backlight driver
To: "Junjie Cao" <junjie.cao@linux.dev>
Cc: devicetree@vger.kernel.org, conor+dt@kernel.org, lee@kernel.org,
 robh@kernel.org, linux-leds@vger.kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260706073307.1038430-1-junjie.cao@linux.dev>
References: <20260706073307.1038430-1-junjie.cao@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 07:35:16 +0000
Message-Id: <20260706073516.BE07E1F00A3A@smtp.kernel.org>
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

> Switch my maintainer entry for the Awinic AW99706 WLED backlight
> driver from my personal Gmail address to junjie.cao@linux.dev.
>=20
> Update both MAINTAINERS and the device-tree binding maintainers field.
>=20
> Signed-off-by: Junjie Cao <junjie.cao@linux.dev>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706073307.1038=
430-1-junjie.cao@linux.dev?part=3D1

