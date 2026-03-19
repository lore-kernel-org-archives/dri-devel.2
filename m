Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 148B4108E1F9
	for <dri-devel@archiver.kernel.org>; Thu, 19 Mar 2026 11:58:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E8E910E99F;
	Thu, 19 Mar 2026 11:58:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=pm.me header.i=@pm.me header.b="C29Cr/53";
	dkim-atps=neutral
Received: from mail-10628.protonmail.ch (mail-10628.protonmail.ch
 [79.135.106.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EBFFB10E9A4
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 11:57:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
 s=protonmail3; t=1773921477; x=1774180677;
 bh=ico9fmTabz68G+Eocm9YW0/Chfw5+TodJeMB9fAJtSo=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=C29Cr/535XN0PgjM03LuMD4k6Fk6ua0Bf2Rm+SWr+GWnHWbpR2zWw3CZ1ctNo963w
 bxnkzH9ToJJpImrg1mF6mwKnE+Hp8SmMSa0wqVrGjJVkonKFmb2s0/pTTglQjci6WW
 9JZKmXDkZDLew+Aton9F0W64kAWF3EvBTusA2ti7AH1u66PScwYbOL5YxfTHzrQuZ3
 VcNznwX3PhM556jdyqzcdsuiUzxv8fSoAfnzQdoieOgK3z++JJ62W01Y85qWXa0vI/
 Mo8ZU++SXF7Af3yvImEJivZuwRUfWkfWlg5N8h6bfaHzditKeJXGe03/G2IPM8Me0z
 opCxdapP0ooQQ==
Date: Thu, 19 Mar 2026 11:57:52 +0000
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
From: Alexander Koskovich <akoskovich@pm.me>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Alexander Koskovich <akoskovich@pm.me>
Subject: [PATCH v3 2/4] drm/msm/dsi: add DSI version >= comparison helper
Message-ID: <20260319-dsi-rgb101010-support-v3-2-85b99df2d090@pm.me>
In-Reply-To: <20260319-dsi-rgb101010-support-v3-0-85b99df2d090@pm.me>
References: <20260319-dsi-rgb101010-support-v3-0-85b99df2d090@pm.me>
Feedback-ID: 37836894:user:proton
X-Pm-Message-ID: 77a4d8c657b172cb5f3f3be2d412197045375a61
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

Add a helper for checking if the DSI hardware version is greater
than or equal to a given version, for use in a future change.

Signed-off-by: Alexander Koskovich <akoskovich@pm.me>
---
 drivers/gpu/drm/msm/dsi/dsi_host.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/dsi/d=
si_host.c
index db6da99375a1..6fad9a612d4d 100644
--- a/drivers/gpu/drm/msm/dsi/dsi_host.c
+++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
@@ -782,13 +782,20 @@ static void dsi_ctrl_disable(struct msm_dsi_host *msm=
_host)
 =09dsi_write(msm_host, REG_DSI_CTRL, 0);
 }
=20
+static bool msm_dsi_host_version_ge(struct msm_dsi_host *msm_host,
+=09=09=09=09    u32 major, u32 minor)
+{
+=09return msm_host->cfg_hnd->major =3D=3D major &&
+=09       msm_host->cfg_hnd->minor >=3D minor;
+}
+
 bool msm_dsi_host_is_wide_bus_enabled(struct mipi_dsi_host *host)
 {
 =09struct msm_dsi_host *msm_host =3D to_msm_dsi_host(host);
=20
 =09return msm_host->dsc &&
-=09=09(msm_host->cfg_hnd->major =3D=3D MSM_DSI_VER_MAJOR_6G &&
-=09=09 msm_host->cfg_hnd->minor >=3D MSM_DSI_6G_VER_MINOR_V2_5_0);
+=09=09msm_dsi_host_version_ge(msm_host, MSM_DSI_VER_MAJOR_6G,
+=09=09=09=09=09MSM_DSI_6G_VER_MINOR_V2_5_0);
 }
=20
 static void dsi_ctrl_enable(struct msm_dsi_host *msm_host,

--=20
2.53.0


