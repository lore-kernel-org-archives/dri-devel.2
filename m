Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49CB8C79F9E
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 04:51:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 85CD610E990;
	Tue,  8 Sep 2026 04:51:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="eqYzs+mm";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7ED0D10E990;
 Tue,  8 Sep 2026 04:51:12 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6B911601DE;
 Tue,  8 Sep 2026 04:51:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0DA71F00A3A;
 Tue,  8 Sep 2026 04:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788843071;
 bh=iAgBP3D2g/kfXp3Z25Xb9Jra1CLvs6SMXwHRHYG0A+Y=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=eqYzs+mmQqU+BgRpBoQ839JaZaC80LkeujX5W4sdOp/pJKo/awrBUKahjMJ0HsM6U
 /22fMUhkQyPiBF3L9aHwktfcfEM3x2N+iJ8N1iBJea61oCEEY+e3iHnoeyo/uQ1+Yo
 Ij4nDkH0DENxvz2sZY6wVDLkZCFtUmzG+Rxl6TdINPbYfD0pxkd3yBc7R5a6d+0AWL
 uRVW+bnJyjKnmeCQh0agp+jyPG9TPyUtQEqJ2184OxrnE2KvwS4k+/bfpVvL9M9c9G
 mnZTXENJjx1LPnm2V3aU8qw6rDzVFZopkZ+8GGyZfgiQNgecvwtUr5jcQciNYqjjMW
 eGhLpPU725npQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 01/14] Revert "backlight: Remove notifier"
To: "Mario Limonciello" <mario.limonciello@amd.com>
Cc: dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org
In-Reply-To: <20260908044035.62093-2-mario.limonciello@amd.com>
References: <20260908044035.62093-1-mario.limonciello@amd.com>
 <20260908044035.62093-2-mario.limonciello@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 04:51:10 +0000
Message-Id: <20260908045110.E0DA71F00A3A@smtp.kernel.org>
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
- [High] Uninitialized `backlight_notifier` rwsem leads to kernel panic on =
registration if `backlight_class_init()` fails.
--

commit d337f12d53eda5facdddbe940d5c74c91750178b
Author: Mario Limonciello <mario.limonciello@amd.com>

Revert "backlight: Remove notifier"

This commit reverts the removal of the backlight notifier support, as it
is needed to add backlight control support into DRM connectors.

> diff --git a/drivers/video/backlight/backlight.c b/drivers/video/backligh=
t/backlight.c
> index fc9bb303e8c5f..4401f6294ccc8 100644
> --- a/drivers/video/backlight/backlight.c
> +++ b/drivers/video/backlight/backlight.c
> @@ -65,6 +65,7 @@
> =20
>  static struct list_head backlight_dev_list;
>  static struct mutex backlight_dev_list_mutex;
> +static struct blocking_notifier_head backlight_notifier;

[Severity: High]
Does this zero-initialized notifier head lead to a kernel panic if
backlight_class_init() in drivers/video/backlight/backlight.c fails?

If class_register() fails in backlight_class_init() due to memory pressure
or sysfs issues, the function will return early and skip the dynamic
initialization via BLOCKING_INIT_NOTIFIER_HEAD().

When a subsequent caller calls backlight_register_notifier(), it will pass
this zero-initialized notifier to blocking_notifier_chain_register(), which
will attempt to lock the uninitialized rw_semaphore and cause an oops.

Could this be prevented by using the static initialization macro instead?

static BLOCKING_NOTIFIER_HEAD(backlight_notifier);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908044035.6209=
3-1-mario.limonciello@amd.com?part=3D1
