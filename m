Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 317BCC982FA
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 07:25:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 598B610E86A;
	Tue, 22 Sep 2026 07:25:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ORSV9Y1F";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 17DE010E86A
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 07:25:29 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D74524035A;
 Tue, 22 Sep 2026 07:25:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7537E1F000FF;
 Tue, 22 Sep 2026 07:25:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790061928;
 bh=msjq3/uC2tZisaq/QqmtboH2Q9stbsyIN2TWlCTVY1E=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ORSV9Y1Fmd0RXr+G1OCzXKuHlEVpmJDJB4PewZo8iH0GpOh3JDWaxSYrBG2nTXdRK
 yMUrHfCOdn4Z1ZC7Jr9NORgn2Z716I+Q75/lpDQ/o8lrOZ7hRq6V3rbTwWMkhTyFyx
 fOL5WQXfqgJUEzyLtsVz4nI8lTswTQOuyzK/qSzwfpN6hUS1WqvR2b598MVOccblVu
 +JULsh4wCLaOpoSudAcUh3q1pZuOPHiwk4jCFMlgpgYkF3FdnrXtTunwcGDBeRP1+I
 OIv0TY5VixJ0FKbZo7iGjckXPikmS2nk5a0v6mjcp5lOLrJox7QChV9M3eemuvTHFZ
 oeHqzUJaRDdFw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] pci/vgaarb: pass a data pointer to be used in the
 decode callback (v2)
To: "Dave Airlie" <airlied@gmail.com>
Cc: dri-devel@lists.freedesktop.org, kvm@vger.kernel.org,
 linux-pci@vger.kernel.org
In-Reply-To: <20260922071807.2533884-1-airlied@gmail.com>
References: <20260922071807.2533884-1-airlied@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 07:25:27 +0000
Message-Id: <20260922072528.7537E1F000FF@smtp.kernel.org>
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

> From: Dave Airlie <airlied@redhat.com>
>=20
> This changes the vgaarb client API so that the user can pass a
> private data pointer into the register that will get used in
> the decode callback.
>=20
> This allows a bunch of pdev conversions in the drivers, and lets
> some future vfio cleanups be nicer.
>=20
> I'd like to merge this via the drm next tree but also fine with
> it going via pci.
>=20
> Signed-off-by: Dave Airlie <airlied@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922071807.2533=
884-1-airlied@gmail.com?part=3D1

