Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBC7BFCD0D9
	for <dri-devel@archiver.kernel.org>; Wed, 18 Mar 2026 08:28:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 990BF10E73D;
	Wed, 18 Mar 2026 08:28:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=pm.me header.i=@pm.me header.b="HgiwWgX+";
	dkim-atps=neutral
Received: from mail-24418.protonmail.ch (mail-24418.protonmail.ch
 [109.224.244.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D53510E2EB
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 07:33:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
 s=protonmail3; t=1773819178; x=1774078378;
 bh=EcoT+wDPxwC0iPC3au3eq0TlK6bZ7olp9+dxuMiE/9I=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=HgiwWgX+DZJ3WHv7GfAzEnXRRYn0OcPb1jfWw8Vwpa028r8ptwk2xX833+MvHQtxn
 jQPT9J2pClyME1jwdu33u/uehCvE/s58qgXhCWcBd7hzrXTOFjEXAaH8FRgmBG7rd+
 vvuxB7BgBEpTcNImppK+f2a6bdNAB6a+jgvKK9h0Ij4qUZGsKJcFk46+pL4cYiegr4
 RgINOp3fKTFjC9KDRovf+6ZEKcDQttUir2hYCVuSDThIyFa0t4WsV0TjmpUrgLVpQv
 u+fHZmgwy2nH9ajOodQSfZL4EPHoJOdCT4qvYEt5QSwfdedlS4M5UHBdcFbMqIINmW
 e1xWFqyKAW5pQ==
Date: Wed, 18 Mar 2026 07:32:53 +0000
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>
From: Alexander Koskovich <akoskovich@pm.me>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Alexander Koskovich <akoskovich@pm.me>
Subject: [PATCH 0/2] drm/msm/dsi: support multiple DSC slices per packet
Message-ID: <20260318-dsi-dsc-slice-per-pkt-v1-0-1bd66b7f9e0c@pm.me>
Feedback-ID: 37836894:user:proton
X-Pm-Message-ID: ed70d1298f966ef0eb2d50a0eee5f1f015a7e2ae
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Wed, 18 Mar 2026 08:28:25 +0000
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

This series adds support for sending multiple DSC slices in a single
DSI packet, which is required by some panels such as the JDI LPM026M648C.

The MSM DRM change was originally authored by Jonathan Marek [1], changed t=
o
use an 'all slices in packet' flag which derives slice_per_pkt from slice_c=
ount
instead of manually specifying the number of slices per packet.

Was also split into two patches so they can go through different trees.

[1]: https://lore.kernel.org/all/20231114174218.19765-3-jonathan@marek.ca

Signed-off-by: Alexander Koskovich <akoskovich@pm.me>
---
Alexander Koskovich (2):
      drm/mipi-dsi: add flag for sending all DSC slices in one packet
      drm/msm/dsi: support DSC configurations with slice_per_pkt > 1

 drivers/gpu/drm/msm/dsi/dsi_host.c | 25 ++++++++++---------------
 include/drm/drm_mipi_dsi.h         |  2 ++
 2 files changed, 12 insertions(+), 15 deletions(-)
---
base-commit: f338e77383789c0cae23ca3d48adcc5e9e137e3c
change-id: 20260318-dsi-dsc-slice-per-pkt-f828429fbf0a

Best regards,
--=20
Alexander Koskovich <akoskovich@pm.me>


