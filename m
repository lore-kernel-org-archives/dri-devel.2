Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 192BC107760C
	for <dri-devel@archiver.kernel.org>; Wed, 18 Mar 2026 19:50:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D883F10E7AA;
	Wed, 18 Mar 2026 19:50:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=pm.me header.i=@pm.me header.b="irDfAeLS";
	dkim-atps=neutral
Received: from mail-24418.protonmail.ch (mail-24418.protonmail.ch
 [109.224.244.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F62110E0C7
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 09:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
 s=protonmail3; t=1773827643; x=1774086843;
 bh=/DBPVzSeb4VrhNH0lorsdARa7M8CrP0iWr42p6FQ8QU=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=irDfAeLSbw86DSbeb6ZtDKukJp738/Mrp89f8XDkMsor19uIBlpX3+H/cWv+NpKSR
 agigRpz69o9jsbQlN/ab7ubdSX5SRRh8beKOfifEVuHS1CQVegWgcwoC2hp+2LesOd
 KuIKd8n7XdTeVtLl+PDLXO8BmASl6UjgeAhm5ptxgOiXYy7pgFxILDljG1mNeeNqdF
 Mxby1/cjkWYo8YvK4srwjgoEakuz4JsyIJEm4i03E1O9RCfrfSQ7bg/F4OqxNviKpF
 FBWG3eerRn7QiNJMR1svhvIV/99Bm992DDUKoUYwsDii6HD2fZF86orbilLgHF0DFz
 R1zmhnUkJNT2g==
Date: Wed, 18 Mar 2026 09:53:59 +0000
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
 Alexander Koskovich <akoskovich@pm.me>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Jonathan Marek <jonathan@marek.ca>
Subject: [PATCH v2 0/2] drm/msm/dsi: support multiple DSC slices per packet
Message-ID: <20260318-dsi-dsc-slice-per-pkt-v2-0-0a1b316f8250@pm.me>
Feedback-ID: 37836894:user:proton
X-Pm-Message-ID: e9bfe26bd574d27c262a3401e5d2c43704de793e
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Wed, 18 Mar 2026 19:50:21 +0000
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
Changes in v2:
- Fix attribution to Jonathan Marek
- Link to v1: https://lore.kernel.org/r/20260318-dsi-dsc-slice-per-pkt-v1-0=
-1bd66b7f9e0c@pm.me

---
Alexander Koskovich (1):
      drm/mipi-dsi: add flag for sending all DSC slices in one packet

Jonathan Marek (1):
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


