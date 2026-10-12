Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF99BCA9ED2
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 10:59:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2CFAD10E58A;
	Mon, 12 Oct 2026 10:59:11 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E71E810E58A;
 Mon, 12 Oct 2026 10:59:04 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2EECC601FE;
 Mon, 12 Oct 2026 10:59:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF7071F0089B;
 Mon, 12 Oct 2026 10:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791802743;
 bh=NkmoP5u7AnAqy/t8juuFr1VNFXqOFK5xtTXiqUayykA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Bsc5lHepz18BTbj7fF5t7M9XcWJ6GOBQXJSL1EMmNcQuchtmco6u1IsmQgHSnuav0
 BI5yVoPszCSldLRzOh30vwwvbSQPT/mhxk6PlTBKNuF5rGt2Mq3Dpv1U5dlVqczWW9
 8CDtuLPwQylmSPbLbqfCf6YTLk/qt3bILuNIdx1V8Gj4LZCj/nZXH7/DFJu9l2U+pQ
 3HfnMVU2Kah5duT2f64L9dvLXjjR3k8+CFYSYHX5QZuJDGZ9i3iBfrSr+p0m1tGU9m
 ZHJeRWv1kZ+W6xkCcw2psDZtemqa5ww537w9uVbgbhk1dFWU4XJscfhf+BRDjUzDQV
 MmojuRieMhGng==
Message-ID: <sashiko-outbox-168001@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/xe/hwmon: refresh Battlemage thermal telemetry
 under force-wake
To: "Constantinos Chalkias" <cch@e-psn.eu>
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20261012104245.2108030-1-cch@e-psn.eu>
References: <20261012104245.2108030-1-cch@e-psn.eu>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 10:59:03 +0000
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
- [Medium] drm/xe: fan telemetry lacks Battlemage thermal force-wake workar=
ound
--

commit a9faaf30cbf789280ad52add1cf188270e8ccad9
Author: Constantinos Chalkias <cch@e-psn.eu>

drm/xe/hwmon: refresh Battlemage thermal telemetry under force-wake

This commit works around stale thermal telemetry on Battlemage by
acquiring the GT force-wake domain and waiting 500-1000 us before
reading temperature registers.

> drm/xe/hwmon: refresh Battlemage thermal telemetry under force-wake
>=20
> On Battlemage, thermal telemetry can remain stale after the GT returns
> to RC6 following sustained workloads.
>=20
> On an Intel Arc Pro B70, package and VRAM temperature telemetry may stop
> refreshing after a long inference workload. Fan telemetry can also
> become invalid while the physical blower remains elevated.

[Severity: Medium]
The commit message states that fan telemetry can become invalid, but the
patch only applies the force-wake and delay workaround to temperature and
VRAM channels via xe_hwmon_temp_mmio_read().

Does xe_hwmon_fan_input_read() also need this workaround? Currently, it
continues to read REG_FAN_SPEED directly via xe_mmio_read32() without
acquiring force-wake or delaying:

drivers/gpu/drm/xe/xe_hwmon.c:xe_hwmon_fan_input_read() {
    ...
	mutex_lock(&hwmon->hwmon_lock);

	reg_val =3D xe_mmio_read32(mmio, xe_hwmon_get_reg(hwmon, REG_FAN_SPEED, ch=
annel));
	time_now =3D get_jiffies_64();
    ...
}

Will fan telemetry still remain susceptible to staleness on Battlemage
without the workaround?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012104245.2108=
030-1-cch@e-psn.eu?part=3D1
