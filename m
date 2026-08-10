Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FD51C5AD4E
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 08:28:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F50210E708;
	Mon, 10 Aug 2026 08:28:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="TO+sSvTH";
	dkim-atps=neutral
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5526710E708;
 Mon, 10 Aug 2026 08:28:22 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4hJSZ56WRTzKnR3;
 Mon, 10 Aug 2026 10:28:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; 
 t=1786350499; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9yu6LEk2UcyjL9r965P8ZavzTzFAgQo0BfGlpvZT/OE=;
 b=TO+sSvTHYAlWYgEcUG/JQbXVlcu6tw7XIJZt+5rLQCLU39Iu2nwwzo0lAX2izkWGHYYgah
 35eD3EGGny2IRS1Ysy0c0rJe8psXiYt2WRoRl3SiLkLVWI2g3YL6/a23swDOkuJjLSQtW7
 ms3wADbqyooWyWXXalMEt9rrwn1BS7kfC3yjoY5bs2JhSHQhGkPwPPsrhNNBVxCj++R9Et
 0Kzx7Si4k1XGQCRQJwQV/6Ldyik/Q65mOiNxOL9/gfZHaHZXAA+sRFfKDXafKQUsQTa2po
 +9SbYoatX4JI51IqMIUOZKB44Qse6aPGJeF2PjN6A0o68NZhzH7R/79L2G4I0Q==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of phasta@mailbox.org designates
 2001:67c:2050:b231:465::2 as permitted sender)
 smtp.mailfrom=phasta@mailbox.org
Message-ID: <cef49cf329737e0af12ef5a90dd21f31e113d4c3.camel@mailbox.org>
Subject: Re: [REGRESSION] drm/sched: FAIR policy causes serious performance
 degradation at max GPU load on 9070XT
From: Philipp Stanner <phasta@mailbox.org>
To: Luke.Wildhardt@proton.me, "matthew.brost@intel.com"
 <matthew.brost@intel.com>, "dakr@kernel.org" <dakr@kernel.org>, 
 "phasta@kernel.org" <phasta@kernel.org>, "ckoenig.leichtzumerken@gmail.com"
 <ckoenig.leichtzumerken@gmail.com>, "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>
Cc: "regressions@lists.linux.dev" <regressions@lists.linux.dev>, 
 "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Date: Mon, 10 Aug 2026 10:28:04 +0200
In-Reply-To: <TfhgV1W0W5LI6RWUO6J35B3R8QIYH_FN3Eihzdo_9PH39hfn1AVByT-QBPHmWiAR-L0Kqi2sppM_EhFPKwZPGmb5pFgpF2MrzeFzkZDmpG8=@proton.me>
References: <TfhgV1W0W5LI6RWUO6J35B3R8QIYH_FN3Eihzdo_9PH39hfn1AVByT-QBPHmWiAR-L0Kqi2sppM_EhFPKwZPGmb5pFgpF2MrzeFzkZDmpG8=@proton.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MBO-RS-ID: 45f535531c94d2e02af
X-MBO-RS-META: tgkpc1exkfrzt6o87it7isjs8m6bthoo
X-Rspamd-Queue-Id: 4hJSZ56WRTzKnR3
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
Reply-To: phasta@kernel.org
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

+Cc Tvrtko

On Sat, 2026-08-08 at 23:33 +0000, Luke.Wildhardt@proton.me wrote:
> Since the DRM scheduler default policy was switched to FAIR in 7.2, susta=
ined 100% GPU load in-game on my RX 9070 XT causes severe performance degra=
dation. In the example title running through Proton, Project Silverfish, th=
e foreground application degrades to roughly 10 fps or freezes outright whi=
le audio continues, and the KDE Plasma Wayland session can lock up entirely=
, requiring a reboot or killing the compositor to recover. The problem is n=
ot limited to games. Running the game in the background + alt tabbing, then=
 playing a YouTube video can also cause the entire desktop to freeze.=20
>=20
> Then, if the game starts to stutter, either alt-tabbing, or opening up a =
menu in game (which reduced the load on the GPU) immediately stops the stut=
tering.=20
>=20
> The issue is reliably reproducible under sustained GPU saturation, althou=
gh the time-to-failure varies. Increasing shadow load (which decreases in-g=
ame frame rate) substantially shortens the time-to-failure.
>=20
> In game, MangoHud does not reveal any frametime discrepancy.=20
>=20
> Bisection / test matrix
>=20
> Reproducer: Project Silverfish (Proton) at settings that saturate the GPU=
, with a second GPU client active (browser video). Other titles show the sa=
me symptom under sustained load; I have not yet re-tested those specific ti=
tles against the fix.
>=20
> Kernel	Result
> torvalds/master stock	FAIR (default)	FAIL
> same as above + reverts below	gpu_sched.sched_policy=3D2 (FAIR)	FAIL
> same as above + reverts below	gpu_sched.sched_policy=3D1 (FIFO)	PASS
> 7.1.5 release	PASS
> drm-next	FAIR (default)	FAIL
>=20
> Reverted Commits:
>=20
> d09339388b77 drm/sched: Remove drm_sched_init_args->num_rqs
> 2833a0512b4c drm/sched: Remove drm_sched_init_args->num_rqs usage
> 16e7698bc04d drm/sched: Embed run queue singleton into the scheduler
> 77a6809f1dc3 drm/sched: Remove FIFO and RR and simplify to a single run q=
ueue
> 45c211ddf92a drm/sched: Switch default policy to fair
> 2462a0ce23b0 drm/amdgpu: Remove drm_sched_init_args->num_rqs usage
>=20
>=20
>=20
> Kernel (failing):=C2=A0 7.2.0-rc6 (stock), also current drm-next
> Kernel (working):=C2=A0 7.2.0-rc6-default-revert-00006-g7e5de9b07e3d with=
 sched_policy=3D1
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 7.1 release
> Distro:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 Arch Linux
> Session:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 KDE =
Plasma 6.7.4 / Wayland (KWin), Qt 6.11.1, KF 6.28.0
> CPU:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 AMD Ryzen 9 9950X3D
> RAM:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 64 GiB
> GPU:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 Sapphire Pulse Radeon RX 9070 XT
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 03:00.0 [1002:7550] rev c0, subsys Sap=
phire 1478
> Motherboard:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ASUS (AM5 / 800-series c=
hipset)
> Mesa:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 26.1.6-arch1.1 (RADV, driverVersion 26.1.6)
> Vulkan:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 instance 1.4.357 / device 1.4.354
>=20
>=20
>=20
>=20
> On the same reverted kernel build, changing only gpu_sched.sched_policy f=
rom 2 (FAIR) to 1 (FIFO) changes the result from reliably failing to passin=
g extended stress testing.
>=20
>=20
>=20
> Possible mitigation options
>=20
> Given that 7.2 is late in the release cycle and 77a6809f1dc3 removes FIFO=
/RR as selectable policies, there is currently no runtime workaround for af=
fected systems.
>=20
>=20
> Revert 45c211ddf92a so FIFO remains the default while FAIR remains availa=
ble for further testing.

That might be the wisest thing to do; but let's hear if Tvrtko has an
idea for a hotfix first.


>=20
> If necessary, also revert 77a6809f1dc3 and dependent changes to restore r=
untime policy selection.
>=20
> Alternatively, fix the underlying FAIR regression if a suitable fix can b=
e identified in time for 7.2.
>=20
>=20
> I mention the revert options because the justification for removing FIFO/=
RR included the absence of known regressions relative to those policies. Th=
is report appears to provide at least one counterexample.
>=20
>=20
> I am willing to test patches responsively and collect data if necessary.=
=C2=A0=20


Thanks for your effort and help. I had dared to hope that we could get
this one through without a regression, but reality always catches up..

P.
