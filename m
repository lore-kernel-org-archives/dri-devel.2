Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66F2BC88E45
	for <dri-devel@archiver.kernel.org>; Fri, 11 Sep 2026 14:52:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B42E210F654;
	Fri, 11 Sep 2026 14:52:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="dCBwWXTu";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA65210E2C3
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 14:52:31 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id DDB5B6020C;
 Fri, 11 Sep 2026 14:52:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00AAB1F000FF;
 Fri, 11 Sep 2026 14:52:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789138350;
 bh=sVfwpVRyt/VC/mMjuLzN3CzfiY31hqAWvVtTiSgiWp4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=dCBwWXTu8eJXbblv1rr5FJS8lhcDAFXKt0sUgVA4dJx1CaUO3egUcL8XY3R5zTcoP
 F3ZpKHrybCbMBAo7x/cJuYTTZTGrt+ENZQQtaOiAYoBKWhOh1GyZE/gNNPWZGnYyrG
 gTEVJOfvC7GQT3oNelLAP8HRyWRyKkw79XlCDa1RBWPReUsReitE9Q25zBbXrWWI3Y
 vlAWrYqXj/sLRzmpyFLztcmx9TVEnRJLlRX/zeFdHsjWZj1HmaXOxUW1r1WiZ7EDcX
 fV6lHJFlo3yt50YSfHImFXMaWibOd6FJZCrL0ZTMeA96McWUEx5zmiswuHWXdnZE8v
 FeApGxMugkHbQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/3] time/jiffies: Include linux/sysctl.h for
 proc_int_u2k_conv_uop(), ...
To: "Petr Pavlu" <petr.pavlu@suse.com>
Cc: "Mark Fasheh" <mark@fasheh.com>, tj@kernel.org,
 "Anna Schumaker" <anna@kernel.org>, mkoutny@suse.com,
 dri-devel@lists.freedesktop.org, linux-modules@vger.kernel.org, "Jeff
 Layton" <jlayton@kernel.org>, hannes@cmpxchg.org,
 "Chuck Lever" <cel@kernel.org>, "Joseph
 Qi" <joseph.qi@linux.alibaba.com>, "Joel Becker" <jlbec@evilplan.org>
In-Reply-To: <20260911-module-include-kmod-v3-2-6ebccc3e0731@suse.com>
References: <20260911-module-include-kmod-v3-0-6ebccc3e0731@suse.com>
 <20260911-module-include-kmod-v3-2-6ebccc3e0731@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 14:52:29 +0000
Message-Id: <20260911145230.00AAB1F000FF@smtp.kernel.org>
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

> jiffies.c uses proc_int_u2k_conv_uop(), proc_int_k2u_conv_kop(),
> proc_int_conv(), proc_dointvec_conv() and proc_doulongvec_minmax_conv(),
> which are declared in linux/sysctl.h. It currently gets that header
> indirectly through linux/module.h -> linux/kmod.h, but the latter no long=
er
> needs to include linux/sysctl.h.
>=20
> Include linux/sysctl.h directly in jiffies.c ahead of removing the
> unnecessary include from linux/kmod.h.
>=20
> Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911-module-inc=
lude-kmod-v3-0-6ebccc3e0731@suse.com?part=3D2

