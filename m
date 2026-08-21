Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0C0EC5DF8C
	for <dri-devel@archiver.kernel.org>; Fri, 21 Aug 2026 20:14:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED67310F3CC;
	Fri, 21 Aug 2026 20:14:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="hhplyznA";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F29810F3CC
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 20:14:53 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0C36761126;
 Fri, 21 Aug 2026 20:14:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89B621F000E9;
 Fri, 21 Aug 2026 20:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787343284;
 bh=GHeiAM/QKcU2aBrnp0t9lNI4f3+ZwJ9mz+89nspuk+I=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=hhplyznA3UDpf5jdid7g6Hkj9s4t7mNPF2WDMZjfm44r6KFLfMEvswcN0He+zpalC
 rUPYy1FYH9oY+xtYyYfPOaFffAopfDnrl0+5Z9cMuq8r2nOfgPUYClAG2L+E/LZESQ
 oSNFtcrRAlT45657ma1P0pwt/+JidVTxiDZCI7Vr38VBkjsh6WEBbT/ftE7UthbY3d
 J1hakqaw8j1GWG1edd8NdayHUlevEDFG0rH4gH7myJ16PoZUbwVknAkEskld1mRMfl
 7q1OgRNFLriN6SydpN1e1iy+HSmBmuSk1Iap0IdyLzOMqXh+tMV8zT3xWq6Wa4jpH0
 mNlVmtKYcbMdg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] pci: Add broken-GPE quirk for Lenovo Legion 16APH8
 and 16AHP9 Nvidia GPUs
To: "Lyude Paul" <lyude@redhat.com>
Cc: linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260821200607.621341-1-lyude@redhat.com>
References: <20260821200607.621341-1-lyude@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 20:14:44 +0000
Message-Id: <20260821201444.89B621F000E9@smtp.kernel.org>
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

> On the Lenovo Legion Slim 5 16APH8 and 16AHP9, the firmware appears to en=
joy
> firing a GPE on the parent PCIe port of the nvidia GPU very shortly after=
 the
> GPU enters D3Cold. This means that every time the GPU is runtime suspende=
d,
> ACPI firmware immediately wakes up its parent PCIe port, which then wakes=
 up
> the GPU. Once it falls asleep again, the cycle repeats.
>=20
> See: https://github.com/NVIDIA/open-gpu-kernel-modules/issues/905
>=20
> Note, this bug doesn't require Nvidia's driver. It happens on nouveau and
> nova as well, and it even seems possible for this to happen without any
> driver loaded.
>=20
> This seems to simply be a bug. Luckily, there is nothing that we actually
> need ACPI wakeup events for on the GPU. Events such as display connector
> hotplug events in D3Cold come through as ACPI_VIDEO events which aren't
> affected by this quirk.
>=20
> Reported-by: Ryan Brue <ryanbrue.dev@gmail.com>
> Co-authored-by: Ryan Brue <ryanbrue.dev@gmail.com>
> Signed-off-by: Lyude Paul <lyude@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260821200607.6213=
41-1-lyude@redhat.com?part=3D1

