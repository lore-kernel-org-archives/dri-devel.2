Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9333BC98302
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 13:42:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E685610E719;
	Tue, 22 Sep 2026 13:41:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="bpVhvuzn";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C507A10E719
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 13:41:54 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6388D402F9;
 Tue, 22 Sep 2026 13:41:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 040F81F00893;
 Tue, 22 Sep 2026 13:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790084514;
 bh=hpMH0dXH13wSZ/dUZfL4U5SUQ4JPJzBdDfkOAQBLy1w=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=bpVhvuzn2IL97ScTX66/rV0HWa8oDNhOcngJ3YkuGxs1S5BUC4UlqAu8FpM+0FoH7
 lkCjDok3zPlRN8FWed6YztNPfuK4sTH6+Hkmg4llQlX3sg0WoQ3jxhcxJR7XoKaRYM
 4TPEMwPrj8i1ZYggyHdz6TB/cTgGkylKhCFLLHvhPJf54Jt22hve8ffo9CikqBOJII
 0oqbYsS9l0pFxtA5kADENvAWXYvYpQfnodDwuF2NOFP6A7OIVyZmJjVEJ+TKUiFjmw
 /GyPSYxsgk6o+Madq03eRQZ9PNls0SxR1JjB0fqUDTPLelaIsJ2HVarmUYKaAUTfce
 zKOzu75Lt71wA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/3] watchdog: Replace __MODULE_STRING() with __stringify()
To: "Petr Pavlu" <petr.pavlu@suse.com>
Cc: linux-watchdog@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-serial@vger.kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>, linux-modules@vger.kernel.org,
 linux-hwmon@vger.kernel.org, linux-rtc@vger.kernel.org
In-Reply-To: <20260922-module-string-v1-1-c18766690185@suse.com>
References: <20260922-module-string-v1-0-c18766690185@suse.com>
 <20260922-module-string-v1-1-c18766690185@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 13:41:53 +0000
Message-Id: <20260922134154.040F81F00893@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922-module-str=
ing-v1-0-c18766690185@suse.com?part=3D1

