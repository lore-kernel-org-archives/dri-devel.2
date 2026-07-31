Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E08A1C55173
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 20:12:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4524810F3C0;
	Fri, 31 Jul 2026 20:12:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Lkjq4uTd";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D3CB10F3C0
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 20:12:10 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C707642E89;
 Fri, 31 Jul 2026 20:12:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AF121F00ACA;
 Fri, 31 Jul 2026 20:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785528729;
 bh=Vo5k4SZJPu0c5kG1Rz06ghvzCkV+zWupokB5JZhLLcw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Lkjq4uTditw7rnxEAFgzjIexEjqQFpGUi5SzfJmHPRXemF7nAkR1QB1PrU/9Qv8OW
 FifChjXFdjgAGOI/V5iDpRpjZL48s/bY+ogKEG6IjHy1E6cvFHPB8fGZHgrYzQa/Pk
 ndU0OnKlt83hlfw9k/+n3zcXbO5HrheeGZpPVUGs+nCug8gYjrMvSy0dlMAlLjqhRQ
 wjfxFe83hN6sbLII6YGW/4cYxrIpP0eQjOvT+QRb0C0ekODwh/Wdbd8q+hwoFIGYm1
 5CpBz4fNV23PKoMtMKa5DnoN+GXAQBpv85mwqYSHMhpYs64yi837yJ4jvhCRAZO6M6
 I3oRyn8WT4gzA==
From: sashiko-bot@kernel.org
Subject: Re: [RESEND PATCH 1/6] Drivers: hv: Remove support for
 WS2012/2012R2 & Win8/8.1 version of Hyper-V
To: "Michael Kelley" <mhkelley58@gmail.com>
Cc: linux-scsi@vger.kernel.org, linux-hyperv@vger.kernel.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260730201123.1767-2-mhklinux@outlook.com>
References: <20260730201123.1767-1-mhklinux@outlook.com>
 <20260730201123.1767-2-mhklinux@outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 20:12:09 +0000
Message-Id: <20260731201209.6AF121F00ACA@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Removing the VMBus protocol version check in `vmbus_initiate_unl=
oad` exposes a 100-second delay during kernel panics if the crash occurs wh=
ile VMBus is connecting.
- [Low] The removal of version fallback logic leaves unreachable dead code =
in `version_resp()` and renders the `next_version` field functionally obsol=
ete.
--

--- Patch [1]: [RESEND PATCH 1/6] Drivers: hv: Remove support for WS2012/20=
12R2 & Win8/8.1 version of Hyper-V ---
Note: The format of this review report has been altered to avoid quoting the
original patch code directly due to recitation restrictions. Instead of inl=
ine
comments, the findings are presented as a free-form summary below.

commit 4b263fe58a4438fc239eb817b339fbf77aa1ea23
Author: Michael Kelley <mhkelley58@gmail.com>

Drivers: hv: Remove support for WS2012/2012R2 & Win8/8.1 version of Hyper-V

This commit removes the legacy VMBus protocol negotiation and special cases
for Windows Server 2012/2012R2 and Windows 8/8.1, as these older versions of
Hyper-V are no longer officially supported. The balloon and snapshot drivers
are also updated to drop related version fallbacks.

[Severity: Low]
In drivers/hv/hv_balloon.c, the patch removes the version fallback logic but
appears to leave behind unreachable code in version_resp(). Since
balloon_probe() now initializes dm_device.next_version to 0, if the host
rejects the version, the check for (dm->next_version =3D=3D 0) in version_r=
esp()
will always evaluate to true.=20

Does this unconditionally jump to the version_error label, making the
subsequent code that prepares and sends a fallback request completely
unreachable?

Additionally, does this change render the next_version field in struct
hv_dynmem_device functionally obsolete, since it is now only ever assigned =
0?

[Severity: Medium]
In drivers/hv/channel_mgmt.c, the removal of the VMBus protocol version che=
ck
in vmbus_initiate_unload() seems to expose a potential issue during kernel
panics.

Previously, the check for vmbus_proto_version < VERSION_WIN8_1 would shield
unnegotiated connections (where vmbus_proto_version is still 0) from enteri=
ng
the unload wait loop. If a kernel panic occurs while vmbus_connect() is
executing, and the state is CONNECTING or CONNECTED but VMBus isn't fully
initialized, does removing this check expose the panic path to a 100-second
spin-loop delay?

Could this delay cause hardware watchdogs to reset the system before kexec
or kdump can successfully collect a crash dump?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260730201123.1767=
-1-mhklinux@outlook.com?part=3D1
