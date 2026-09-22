Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68046C982FF
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 13:41:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B17C310E647;
	Tue, 22 Sep 2026 13:41:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="bZx2iSUM";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C4E6D10E647
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 13:41:54 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D6C916024D;
 Tue, 22 Sep 2026 13:41:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 225A91F000FF;
 Tue, 22 Sep 2026 13:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790084513;
 bh=lVl0fgKjqVy/vhthxNUYL8fKrxtcMfANmo0SEydbDh0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=bZx2iSUMlwCFCcanq+6EXP6q5cVqrAKJfT92rukW0mgOrDt2bv+Mbv/F0FPGHdXK9
 6CP44UZJ8oIol+CEgSy8wrlJ9DwZfszk309ymt8+sKBdn9NASzOdaG2XH0zrUtXjYu
 xShwcLk2iUI88ojOQy5tAEO84BvOCvZgC47mBslwRTpizysRe+AH1jieiS7x6ckK38
 yYorKnZ5iyhXEtBhD9vuYFQ6zEC4lEUKq0FhW3/FwkMYd5HK1hbLIhGBEIgHclLxGS
 6REqITFDFxvHgqX7r/VslBp5tYqmFRQfTiQgTQziqZj5Q1weuA2eC1iBjlRk4yUCgz
 WVI09un0B+e/Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/3] module: Remove obsolete __MODULE_STRING()
To: "Petr Pavlu" <petr.pavlu@suse.com>
Cc: linux-watchdog@vger.kernel.org, linux-serial@vger.kernel.org,
 linux-hwmon@vger.kernel.org, linux-rtc@vger.kernel.org,
 linux-modules@vger.kernel.org, dri-devel@lists.freedesktop.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20260922-module-string-v1-3-c18766690185@suse.com>
References: <20260922-module-string-v1-0-c18766690185@suse.com>
 <20260922-module-string-v1-3-c18766690185@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 13:41:52 +0000
Message-Id: <20260922134153.225A91F000FF@smtp.kernel.org>
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
> Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922-module-str=
ing-v1-0-c18766690185@suse.com?part=3D3

