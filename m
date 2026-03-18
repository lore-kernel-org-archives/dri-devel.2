Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ACCAFCD0DA
	for <dri-devel@archiver.kernel.org>; Wed, 18 Mar 2026 08:29:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 81F6F10E73B;
	Wed, 18 Mar 2026 08:29:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=pm.me header.i=@pm.me header.b="dkqfPUl3";
	dkim-atps=neutral
Received: from mail-43101.protonmail.ch (mail-43101.protonmail.ch
 [185.70.43.101])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B97010E441
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 07:33:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
 s=protonmail3; t=1773819186; x=1774078386;
 bh=HEEHya28D9AzgK7IMREp/bxt0n4mna9PaQwrUvZ8aHg=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=dkqfPUl3ZNRqI4GJi21Sqga9kiHiY2bb89QmGr9t+4t3A9lWc0F4Z12X6tuRYTr7F
 j3E74ff2LTOGuGuRY95XcBUAsgo+KkGIxyFdfV83PKSe11sOFq266YVWc+7x7XBRbw
 DiJnOu/0uaepLD34uvEeSuqwLeIaBF6OZNJhV9iIIaeFDuq8wuT0NWwG4bq97fHkIf
 cqLTEReBFlLVf7L8xawBwEWcypH1U6qT4smtPHkKIa6OvIb61SymXumm5Qkh6jZuYi
 Btw+SSN33mJOvu04W3xXcmGmpTds5HZoIuSZSl+iiTF2QREUZ0M51ZbHCXiUfD49uW
 qF9fjeRhq0BFw==
Date: Wed, 18 Mar 2026 07:33:03 +0000
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
Subject: [PATCH 2/2] drm/msm/dsi: support DSC configurations with
 slice_per_pkt > 1
Message-ID: <20260318-dsi-dsc-slice-per-pkt-v1-2-1bd66b7f9e0c@pm.me>
In-Reply-To: <20260318-dsi-dsc-slice-per-pkt-v1-0-1bd66b7f9e0c@pm.me>
References: <20260318-dsi-dsc-slice-per-pkt-v1-0-1bd66b7f9e0c@pm.me>
Feedback-ID: 37836894:user:proton
X-Pm-Message-ID: da70dc4b6326ffeb32679cd1fe636db6e5a0f639
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

Some panels support multiple slice to be sent in a single DSC packet and
this feature is a must for specific panels, such as the JDI LPM026M648C.

Use the MIPI_DSI_MODE_DSC_ALL_SLICES_IN_PKT flag to derive slice_per_pkt
from slice_count, note that most panels are expected to just work with
just one slice per packet.

This change was originally authored by Jonathan Marek:
https://lore.kernel.org/all/20231114174218.19765-3-jonathan@marek.ca

Signed-off-by: Alexander Koskovich <akoskovich@pm.me>
---
 drivers/gpu/drm/msm/dsi/dsi_host.c | 25 ++++++++++---------------
 1 file changed, 10 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/dsi/d=
si_host.c
index db6da99375a1..758b076ee4bf 100644
--- a/drivers/gpu/drm/msm/dsi/dsi_host.c
+++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
@@ -166,6 +166,7 @@ struct msm_dsi_host {
=20
 =09struct drm_display_mode *mode;
 =09struct drm_dsc_config *dsc;
+=09unsigned int dsc_slice_per_pkt;
=20
 =09/* connected device info */
 =09unsigned int channel;
@@ -927,17 +928,10 @@ static void dsi_update_dsc_timing(struct msm_dsi_host=
 *msm_host, bool is_cmd_mod
 =09slice_per_intf =3D dsc->slice_count;
=20
 =09total_bytes_per_intf =3D dsc->slice_chunk_size * slice_per_intf;
-=09bytes_per_pkt =3D dsc->slice_chunk_size; /* * slice_per_pkt; */
+=09bytes_per_pkt =3D dsc->slice_chunk_size * msm_host->dsc_slice_per_pkt;
=20
 =09eol_byte_num =3D total_bytes_per_intf % 3;
-
-=09/*
-=09 * Typically, pkt_per_line =3D slice_per_intf * slice_per_pkt.
-=09 *
-=09 * Since the current driver only supports slice_per_pkt =3D 1,
-=09 * pkt_per_line will be equal to slice per intf for now.
-=09 */
-=09pkt_per_line =3D slice_per_intf;
+=09pkt_per_line =3D slice_per_intf / msm_host->dsc_slice_per_pkt;
=20
 =09if (is_cmd_mode) /* packet data type */
 =09=09reg =3D DSI_COMMAND_COMPRESSION_MODE_CTRL_STREAM0_DATATYPE(MIPI_DSI_=
DCS_LONG_WRITE);
@@ -1088,12 +1082,8 @@ static void dsi_timing_setup(struct msm_dsi_host *ms=
m_host, bool is_bonded_dsi)
 =09=09else
 =09=09=09/*
 =09=09=09 * When DSC is enabled, WC =3D slice_chunk_size * slice_per_pkt +=
 1.
-=09=09=09 * Currently, the driver only supports default value of slice_per=
_pkt =3D 1
-=09=09=09 *
-=09=09=09 * TODO: Expand mipi_dsi_device struct to hold slice_per_pkt info
-=09=09=09 *       and adjust DSC math to account for slice_per_pkt.
 =09=09=09 */
-=09=09=09wc =3D msm_host->dsc->slice_chunk_size + 1;
+=09=09=09wc =3D msm_host->dsc->slice_chunk_size * msm_host->dsc_slice_per_=
pkt + 1;
=20
 =09=09dsi_write(msm_host, REG_DSI_CMD_MDP_STREAM0_CTRL,
 =09=09=09DSI_CMD_MDP_STREAM0_CTRL_WORD_COUNT(wc) |
@@ -1702,8 +1692,13 @@ static int dsi_host_attach(struct mipi_dsi_host *hos=
t,
 =09msm_host->lanes =3D dsi->lanes;
 =09msm_host->format =3D dsi->format;
 =09msm_host->mode_flags =3D dsi->mode_flags;
-=09if (dsi->dsc)
+=09if (dsi->dsc) {
 =09=09msm_host->dsc =3D dsi->dsc;
+=09=09if (dsi->mode_flags & MIPI_DSI_MODE_DSC_ALL_SLICES_IN_PKT)
+=09=09=09msm_host->dsc_slice_per_pkt =3D dsi->dsc->slice_count;
+=09=09else
+=09=09=09msm_host->dsc_slice_per_pkt =3D 1;
+=09}
=20
 =09ret =3D dsi_dev_attach(msm_host->pdev);
 =09if (ret)

--=20
2.53.0


