Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F65EC982FA
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 13:42:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 72ABB10ECB6;
	Tue, 22 Sep 2026 13:42:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="MVbyo82C";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2EE5110E647
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 13:41:55 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 17D0A4133F;
 Tue, 22 Sep 2026 13:41:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACC0B1F00898;
 Tue, 22 Sep 2026 13:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790084515;
 bh=ILA5v9L32uI+8ck5fK7HD/3c37VVSiX06f80Px9fkH8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=MVbyo82ClgfUhwSMC+AelL7s2H8ljc7ku5Hb5xJXGqvfJjrCbXz+ZvnOkpCxBjWPi
 ryLMt3NyKZY0sOY2KG1Dn+3olv760W4cC8/nqGaCYmBUQYQY30Aa/a5s0+7htLGDUF
 RrYZxIpKyiAJDaYSUfXPFmFvp2S10lOXJpR197QIIW5R42t45IyBnAWXqTTg8lR10V
 wJuKXktgbUYo98SuNNI3HE+Pf0Y11V/aI4FaFlhtXoQzfJrw7+w6/Z9jS88GPMjVfN
 dVy0OrrgxDxYjdRrA/3wInfpkxlZNhBK56GhJY63bfcMMZRdmdOx5Ag5pNvKiPEO/G
 0ux8JQs3vExcQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/3] drivers: Replace __MODULE_STRING() with __stringify()
To: "Petr Pavlu" <petr.pavlu@suse.com>
Cc: linux-modules@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-hwmon@vger.kernel.org, linux-watchdog@vger.kernel.org,
 linux-serial@vger.kernel.org, linux-rtc@vger.kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20260922-module-string-v1-2-c18766690185@suse.com>
References: <20260922-module-string-v1-0-c18766690185@suse.com>
 <20260922-module-string-v1-2-c18766690185@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 13:41:54 +0000
Message-Id: <20260922134154.ACC0B1F00898@smtp.kernel.org>
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
ing-v1-0-c18766690185@suse.com?part=3D2

