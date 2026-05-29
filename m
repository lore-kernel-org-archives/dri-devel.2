Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D6ECCD5BD2
	for <dri-devel@archiver.kernel.org>; Fri, 29 May 2026 08:51:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4AE7910FB26;
	Fri, 29 May 2026 08:51:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=emersion.fr header.i=@emersion.fr header.b="g6te5prD";
	dkim-atps=neutral
Received: from mail-4397.protonmail.ch (mail-4397.protonmail.ch [185.70.43.97])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1112710FB26
 for <dri-devel@lists.freedesktop.org>; Fri, 29 May 2026 08:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
 s=protonmail; t=1780044708; x=1780303908;
 bh=rctSTzIDqa8aqPc1OQh6LHkpfPpFqz50AihaSvSTuQs=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=g6te5prDJGg6dQ/EYdcjVaFC9uCKTAvAzZdUEc2j4IuF7Gnqo9id9FPjciGujfu9H
 ELeJ0V82CCy+9HTwNxNhjg2hC9Audim0ecsBIc0y95FXJb8aMYfAYyO2W4WWpr5gXP
 UhiRtQbkO2A3JINDtCmxvjersaoueFA9Hb+YnaegzcgutdKLmNuryfksrCfdH2+Tjr
 NT2T+Gzqt5qsiqLa8Ec+AyDd1G5G5XzJHu6zxMq5ysQP4rHLurRyFWv0pb+hwHl1lb
 6etbNOsdX7AdZuBDRYFclMP/TCzJKB7v48G+hYx3hnsG2httAXlaV8KDF1ZmEFyUEM
 5LMDbJKBmPdkg==
Date: Fri, 29 May 2026 08:51:42 +0000
To: "xorg-announce@lists.x.org" <xorg-announce@lists.x.org>
From: Simon Ser <contact@emersion.fr>
Cc: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Subject: [ANNOUNCE] libdrm 2.4.134
Message-ID: <Lf440GQtiWgoREFjkYc-WzM8TVEYtpODpfCb0w9neU5Dd_iYSgT98goFxMYHRpoxPqFo2mrI5QOaXYpdpKbKg7_Xklv07yI9NVQczuchV7c=@emersion.fr>
Feedback-ID: 1358184:user:proton
X-Pm-Message-ID: 1e553db82db36901ba9e93c46db57160e91cd5bf
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Eric Engestrom (2):
      ci: fix indentation
      ci: bump debian from bookworm to trixie

Rudi Heitbaum (2):
      amdgpu: fix discards 'const' qualifier from pointer target type
      modetest: fix discards 'const' qualifier from pointer target type

Samuel Pitoiset (4):
      add missing include to util_math.h
      build: bump version to 2.4.133
      omap: stop including linux/types.h
      meson: do not mark exynos/omap/tegra as disabled features

Simon Ser (2):
      Sync drm_fourcc.h with drm-next
      build: bump version to 2.4.134

git tag: libdrm-2.4.134

https://dri.freedesktop.org/libdrm/libdrm-2.4.134.tar.xz
SHA256: ac5e74d157830eb8bee44c6a6bf3ad49774ef0dd2a72bdad74a8f20308b52a95  l=
ibdrm-2.4.134.tar.xz
SHA512: ef2abddea59d1e93c83a48de920431b839ab50d6071ef4da3cf126e7d64ba7b235f=
2e34e1169d49ad9de2937a0a18acd66bb8d324b067239b1136e0ddbe792a1  libdrm-2.4.1=
34.tar.xz
PGP:  https://dri.freedesktop.org/libdrm/libdrm-2.4.134.tar.xz.sig
