Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FEB4CA5FC4
	for <dri-devel@archiver.kernel.org>; Fri,  2 Oct 2026 09:14:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 79E3110F7F9;
	Fri,  2 Oct 2026 09:14:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="XpsmJPb0";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 914F010F7FA
 for <dri-devel@lists.freedesktop.org>; Fri,  2 Oct 2026 09:14:48 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7A2704127F;
 Fri,  2 Oct 2026 09:14:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB5ED1F000FF;
 Fri,  2 Oct 2026 09:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790932488;
 bh=//8fxdMsJh6/kGtDdgLOpr6PPslJ7sGIiQGx+p6a4P4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=XpsmJPb0sdEKeIq/UesdQfhLDQk6S9g+A2bIgzdI/7FdfJJvc81oavlWgIC+Qa6dm
 2o9HtMRYIQQ/lLZ+hmkUI9dYaMPIFiHwkovmCzfugbzp+0ltHoDsg6H9DTk3DeuEKE
 nSaaj5gx5Dai2z9yIUsrzcntO7Dxep0Jr1ol4AUknDlRvPQ797z0Adld5SjYA0WvDI
 6KMEeiWciWSZQzrHE15B+5qz+JX0WChssvTgiCd4lKrtE+TY1ToAl9I0PXc0ybKi+I
 ZuByXYnVxLI6+aqVGWbrhmtHPn/lhqLRFAg+Gsgd/SjbhG8RO3ODIxvfeNSxquYXDG
 ZAUTnGj9psfnw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/3] hwmon: Replace __MODULE_STRING() with __stringify()
To: "Petr Pavlu" <petr.pavlu@suse.com>
Cc: linux-serial@vger.kernel.org, linux-watchdog@vger.kernel.org,
 linux-hwmon@vger.kernel.org, linux-rtc@vger.kernel.org,
 dri-devel@lists.freedesktop.org, intel-wired-lan@lists.osuosl.org, "Petr
 Pavlu" <petr.pavlu@suse.com>,
 "Alexandre Belloni" <alexandre.belloni@bootlin.com>,
 linux-modules@vger.kernel.org
In-Reply-To: <20261002-module-string-v2-1-fc7438acaf4d@suse.com>
References: <20261002-module-string-v2-0-fc7438acaf4d@suse.com>
 <20261002-module-string-v2-1-fc7438acaf4d@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 02 Oct 2026 09:14:47 +0000
Message-Id: <20261002091447.DB5ED1F000FF@smtp.kernel.org>
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

> __MODULE_STRING() has been an alias for __stringify() since "[PATCH]
> MODULE_PARM support for older modules" [1] in 2002-12. That change also
> moved it to the graveyard section at the end of linux/module.h
>=20
> Replace the remaining uses of __MODULE_STRING() with __stringify() in
> preparation for its removal.
>=20
> Link: https://git.kernel.org/tglx/history/c/136839a1b4 [1]
> Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261002-module-str=
ing-v2-0-fc7438acaf4d@suse.com?part=3D1

