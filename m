Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E667CA5FE0
	for <dri-devel@archiver.kernel.org>; Fri,  2 Oct 2026 09:14:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A2DC810F801;
	Fri,  2 Oct 2026 09:14:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="EEahz5Nj";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 31D6F10F7F9
 for <dri-devel@lists.freedesktop.org>; Fri,  2 Oct 2026 09:14:50 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A8AF860A6A;
 Fri,  2 Oct 2026 09:14:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB0911F00893;
 Fri,  2 Oct 2026 09:14:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790932489;
 bh=n9XPVzmamJ9SFi/utHDiLl0mrcfA1+JtJQXHpWb3o4U=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=EEahz5Nj+zMjRDGaJzTrt/4iq1bOhqMLFzGVZ2+IoN2ODPjnT6Xy6zevlL0xTh3AM
 9kabDeQMi+jheU1Wea8uAdqJAe5K/LUZPY8m4c0FkaXSbXL1KTKlhfMN+Wjq4zB4TY
 /9yP9sRUvvD5kp7e87XPaB00IHYmhwynS3mYNpRB6zIm7N5oCdqAGD3os7Nm0AKF2p
 HM2KSFJKNwmfQwgwSvXn0CIVOqUtmomEmKVBvrJ1DKoRFrncm3hwVn6XJNzG7YJhdg
 eO+BVwFtIgf7khY7KfXLP8xiF+iPWZcy1syRdICbVWG/00rsjQTtQG3VQgg82EYQGT
 oHW2J9d/Y/D6g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/3] module: Remove obsolete __MODULE_STRING()
To: "Petr Pavlu" <petr.pavlu@suse.com>
Cc: "Petr Pavlu" <petr.pavlu@suse.com>,
 "Alexandre Belloni" <alexandre.belloni@bootlin.com>, linux-rtc@vger.kernel.org,
 linux-serial@vger.kernel.org, linux-hwmon@vger.kernel.org,
 dri-devel@lists.freedesktop.org, intel-wired-lan@lists.osuosl.org,
 linux-modules@vger.kernel.org, linux-watchdog@vger.kernel.org
In-Reply-To: <20261002-module-string-v2-3-fc7438acaf4d@suse.com>
References: <20261002-module-string-v2-0-fc7438acaf4d@suse.com>
 <20261002-module-string-v2-3-fc7438acaf4d@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 02 Oct 2026 09:14:48 +0000
Message-Id: <20261002091448.DB0911F00893@smtp.kernel.org>
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
> Remove __MODULE_STRING() now that all remaining uses have been replaced
> directly with __stringify().
>=20
> Link: https://git.kernel.org/tglx/history/c/136839a1b4 [1]
> Reviewed-by: Aaron Tomlin <atomlin@atomlin.com>
> Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261002-module-str=
ing-v2-0-fc7438acaf4d@suse.com?part=3D3

