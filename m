Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A9AAC44507
	for <dri-devel@archiver.kernel.org>; Tue, 14 Jul 2026 20:27:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8070C10E0C8;
	Tue, 14 Jul 2026 20:27:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="b/gsEeto";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2463310E096
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Jul 2026 20:27:09 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D154D43962;
 Tue, 14 Jul 2026 20:27:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 942241F00A3A;
 Tue, 14 Jul 2026 20:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784060828;
 bh=ZwetuVAOsNI5iXtnhWONllCRufW52bqjWMCknfoR9r4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=b/gsEeto9GcCaSuNC4r1vn4/Fl3VBH96W/DnIEGuSWUa/fQvlk/t5zXBz/3WG+tfU
 lNQifEnVsaiFwtaAMe9JH5PBhFcc6CvVpbQTCuktkN95H4dwoIz7XxEwqG3rMSrXcn
 Vx1SGkjZ9nncN1DcbkKmXUuMvpaMgMwtH05w5a0YqgKC+IQtZDLz48nxrZt1Y1MqPd
 mP5QT/fyUOoeSOnH/wgHeY4YnL/zReLJQ0NEwwO8kSIm8xTeSEqtcDGkceULwHX06S
 YRAq5fI3NYTQ2cofo0ZAD+R9rJVPgCKeT0cL+Oos+XIzS/hmwjLXP/f/9YIPq35y4W
 1NEC5/xfvLrDA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/4] fixup! accel/amdxdna: use
 hmm_range_fault_unlocked_timeout() for range population
To: "Stanislav Kinsburskii" <skinsburskii@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <178406002613.1082778.11295976907808029605.stgit@skinsburskii>
References: <178405975214.1082778.5193079941156341151.stgit@skinsburskii>
 <178406002613.1082778.11295976907808029605.stgit@skinsburskii>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 20:27:08 +0000
Message-Id: <20260714202708.942241F00A3A@smtp.kernel.org>
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
- [Medium] The commit message describes changes to the nouveau driver, but =
the patch modifies the amdxdna driver.
--

--- Patch [3]: [PATCH 3/4] fixup! accel/amdxdna: use hmm_range_fault_unlock=
ed_timeout() for range population ---
commit b015bb79070e6f1c36006ca6ff7e7e113d7ecbd7
Author: Stanislav Kinsburskii <skinsburskii@gmail.com>

fixup! accel/amdxdna: use hmm_range_fault_unlocked_timeout() for range popu=
lation

This commit updates the hmm_range_fault_unlocked_timeout() usage to pass
the full timeout value on each retry attempt. It also removes the open-coded
absolute deadline and remaining-time calculation from the range population =
path.

> nouveau_range_fault() now uses hmm_range_fault_unlocked_timeout() for
> the HMM fault path. The timeout passed to that helper is meant to bound
> HMM's internal mmu-notifier retry loop, not the whole nouveau retry loop
> around mmu_interval_read_retry().
>=20
> Pass the full relative HMM_RANGE_DEFAULT_TIMEOUT value to
> hmm_range_fault_unlocked_timeout() on each attempt, and retry from the
> nouveau-side mmu_interval_read_retry() check with a fresh HMM retry
> budget. This lets HMM continue when it has made progress, while still
> preserving a timeout for repeated notifier invalidation retries inside
> one HMM fault attempt.
>=20
> This also removes the open-coded absolute deadline and remaining-time
> calculation from nouveau_range_fault().

[Severity: Medium]
Is this description meant for a different patch? The commit message describ=
es
changes to nouveau_range_fault() and the nouveau driver, but the actual pat=
ch
modifies aie2_populate_range() in the amdxdna driver.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/178405975214.108277=
8.5193079941156341151.stgit@skinsburskii?part=3D3
