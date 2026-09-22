Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5E38C98302
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 21:53:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D292610EE98;
	Tue, 22 Sep 2026 21:53:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=yahoo.com header.i=@yahoo.com header.b="Vhbb4vIM";
	dkim-atps=neutral
Received: from sonic.asd.mail.yahoo.com (sonic-usea1-0019.asd.mail.yahoo.com
 [34.2.64.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D3DE710EE8A
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 21:53:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1790114035; bh=rrweRpOHig/PA1QcZgQEw1tne5m2aZyTIn1UD9NuN/8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To;
 b=Vhbb4vIM7awKGRpDMmwr930OZf9xAjrSVPtpcLIJTnpNR68YU/2RT4OHaQtrcJuPp2MQ8DIPP+f1RZq5JFkLTNd3dy01iafoPhw/U+N3ZmEx5N53pjVP2+NH/wZXDXx71bdTHuxXdn+TVVgC32ivZNcvvPIfqzG4CdFVYpDuMEz5efI8ZRY3zSfK/Z+aW0DV4++kyUaw5oSB5SzXUsyDHL/eM1LP/xkI0R+OqC6MxOYybcy4nCA0Ii5sW1zp7/gj/qINPqZmBkUQ4mVQPhYca+lXCPzkxuZuU/jpBkIJLt+uK5+VWXDpzEUztMb0tpQtFZIorUEebf/YTRZ93LLxTg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1790114035; bh=nShwYg5ZHkphWT1QpMv8POs1srg2VhNtTnDaowPDaus=;
 h=X-Sonic-MF:From:To:Subject:Date:From:Subject;
 b=mQJhEzIIZEhhJ0bYYTa8yshv/kiJPNb5fL+QQVWq4Xz5/9HEjJPlEkzmDbJx2/jf3wNLH7R1154vMzZ3ILXUYKshZDRqVpoqbHwkxVqI7vdz1e1xpmuZ49FzT1b+rlNbggCW+30jr7Ki9LwaHv2IC7Xmr2oAkEaNFLrF3SkYr6P4IJaKlbYw2bk9moH7I+f8EUjC8U6fc7YDlF0SaCFQKXiMo8YLGzkBz/OxjGupoPtnDRtoqH3HmxXACVP/8wzqUbXAhT9zG3tv/w5+xZOOp/vwlqsmud16ihrpkephRl5d87Y1ZMKtG+x4j0IAoKWBgjB+c+opekscJ4nfRPTtGw==
X-YMail-OSG: NV06UE0VM1lsaB7YndzQJt_l7PI8P3SoQjWVDSf065y4yS6JjXsXtEsH9xb89lF
 e4aP5slMc8LIAkhBvf6WPwRZt77lOfTHi.fDR99LP8xBcguLD9d3PbDHJ5uXqf5_xo3ntenNbKL6
 9.dxK44U6NiJkm6E5HiEFxm.b96boKUtQYq3BaDskwHA3BpQGN9Nc9ZLFSxNY5MosfxP8RbWkEL7
 1SLlTxYMb6M_c_mPjEWg7j2vCXk_xw.apxAAJXt_9WehgHwfPaajLoyqxaG_1uVhguKzVdEkJ0S5
 7Fy4FFMxlmUrSoCMdwggLnSoY5Xi7BptKFbugIiCu6cUAdDJ_tRiSiCHhSYX3l8x23r8SABnC.Vg
 3mwdqN1exC9VEQAGl9cmrt8B8hU_9wF1Iu92wchE30BB8AICDmY15t30AzWKPBtYjNtpDSednwXl
 Vd036IUpicdvd59DaaXNFLPN0mKjlLMuTcPvNiaOa3W7BoEQMhtxGcDuyyxp6lGnkimVvpYko2Zt
 Lqx5BzpYnkgKWYx7V2Wzl3z1TsxXUGPE8ZZYfi99cAt7raPfGhfUDFzDAxyUa7ZzpN2eOfn6xDnj
 T95Eb3Nfa4UOZzDEqJ9G2T3sGdO2qT7lkPsLq.kAYmvnobHUwydCiLEgi5eL_h9opROK62gJcUiA
 fcwvxqzCw4EK2QPNBhniJYg2p4oiazCcmtGDBnatPG5bTKoIiA_UceQHFPgwmGJH6GpJnY1gxeIj
 KYJro81j3lk5_.YVgj6yA_FR6yyGNMi7DsZEKez21lUq0ijOAmr0bmrMx6KvUMhcdOUh2OFWWqFE
 gSgRMWsEwhChb1pZOO9_SpyF75Tp8yhqTVbPyii__MqWAVoLIo.otmy.BRl_oJYIo5idAJyj8kIf
 2Y6GNejjB06IjUE1MqHPQQqJIU4YrHCkDoX5Zk_717BS_G9KT70oYbBFXeUxYczC.ThNaAfDPBQN
 3xIvuEQluAz9IkgwTrDchfLhSSlgTxqvtkfSsJ4RJrME8pKe48livf0w6WuitfKZMausWKFHuHfd
 fICbZJ5VIIXbhYO9W_SFnNuBIXJ3ddlDHJLU5HJ34rkWRIAelgGe8VsykhWH5zrgBoJWhKYJnsUz
 MKOI8sKjwi_hCwI8Yc9wxw1kqetfQB4nIZ4xJXFjkhHRALUT1U.y7G1hNkocVhIZOfm5nKjVwL7K
 gyu2mG8vnwWqW1H_.DGDGsJSfnBLGaEaIsQ57P04UCfmwsSU3ncbz0d.zAh22PACJ0XdZtA7Msdo
 AZxe7Bv7LSrzuzZg9hjN6JRtJcU0kdhNHn_MVRNiPoI1CV16LCpMaOcOkiaOPW8KKqprBLmcHa6i
 Ko_INqNaCWJwaPAvr8P9OB3R_aANezt5jkZs55QzwYGAO_PjlRBTXyLWGA2wgc8PBKiQJ9WtDr5j
 mDuS5_5bTCOWtw0rnHLQkTQkm4dsss0aOZlfuXTVA_gi9aASi4ec9pFiNO1ycn.HQOi0krfj76qb
 ZMBI.v1QUhtyuYyRrJUDJOn8cgbT5CQ0GlEJwr30Fh3BofCaqLmiMT3pgYIlZtk3NxlCGU90tPss
 PKMuop6rjIE3GiVI1Jewo8vAC3UXrYsY5toURtGL.8etsDITvFZ8tBttQuqIyRz34vGH7v_4jBeo
 hTqZGmvrzAml_D2lJH1SUytxHxrPbs4FFjk3xBwxHMS1QNze8nY8Bm8TpSwfEeEXF4pfi3xJbaBc
 ATvG6hRDtidMQuz.frQWO8_MGhnu5Ifp4r.qFbO05NVKELcvShXRwPCJdWt8SQONcgt2D8Vtr00o
 0lxBaK.M16TOHQTzUvNQbRfGLMH61rRYfmCMYfgs0QQjHJIJYzvPHrISkjisgRVoNy4GxeMsVDWP
 8LFkKULeErXqMdCHKZ8XPVYYTAhLvoCX3phw5Isobqv1jen1msUqD5_yKuCW2TLAqBB.qhd9swi3
 VTCLeXGQNkCRLqVd9bAlV7yzeb.rCzMvZ_cXznOjr3Nd9poahVEdZ3h2sRUrEcw2rhfJCLhXmG5i
 1IJ6EZMZzkEpgWgy030lMlIApWDBt47KN
X-Sonic-MF: <Capitain_Jack@yahoo.com>
X-Sonic-ID: 1b937a8c-60c6-4df0-acfe-d1d9fb273539
Received: from sonic.gate.mail.ne1.yahoo.com by
 mail-asdoutdeli-p-cin-usea1-prod-sonicconsumer-svc-102 with HTTP;
 Tue, 22 Sep 2026 21:53:55 +0000
Received: from dip68.lsn.bf1.yahoo.com ([67.195.177.77])
 by hello (SMTP) with SMTP ID 98779d167a59bfbe653b3ebdee112417;
 Tue, 22 Sep 2026 21:53:54 +0000 (UTC)
From: Daniel Campos Ramos <Capitain_Jack@yahoo.com>
To: dri-devel@lists.freedesktop.org
Cc: nouveau@lists.freedesktop.org, lyude@redhat.com, dakr@kernel.org,
 Daniel Campos Ramos <Capitain_Jack@yahoo.com>,
 Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH 6/6] drm/nouveau: expose HDMI output properties on DVI
 connectors
Date: Tue, 22 Sep 2026 18:53:36 -0300
Message-ID: <20260922215336.612239-7-Capitain_Jack@yahoo.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260922215336.612239-1-Capitain_Jack@yahoo.com>
References: <20260922215336.612239-1-Capitain_Jack@yahoo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

DVI and HDMI share the TMDS link, and a DVI connector drives an HDMI
sink through a passive adapter.  Nouveau already decides HDMI operation
from the sink's EDID rather than the connector type, so InfoFrames, 3D
and the Deep Color GCP reach HDMI sinks on DVI connectors, but "max bpc",
"Broadcast RGB" and "color format" were only attached to HDMI-A
connectors, leaving those sinks at 8-bpc full-range RGB.

Attach the same properties to DVI-D and DVI-I connectors.  The selection
is unchanged: it still follows the sink's EDID, a DVI sink stays at
8-bpc RGB, and an explicit YCbCr request for a DVI sink is rejected, as
in drm_hdmi_state_helper.c.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/all/20260922193903.DE3BB1F000FF@smtp.kernel.org/

Signed-off-by: Daniel Campos Ramos <Capitain_Jack@yahoo.com>
---
 drivers/gpu/drm/nouveau/dispnv50/disp.c     | 7 ++++++-
 drivers/gpu/drm/nouveau/nouveau_connector.c | 7 ++++++-
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.c b/drivers/gpu/drm/nouveau/dispnv50/disp.c
index c52629eaf786..1ec33bb6ad50 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
+++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
@@ -530,8 +530,13 @@ nv50_outp_atomic_fix_depth(struct drm_encoder *encoder, struct drm_crtc_state *c
 		enum drm_output_color_format fmt = DRM_OUTPUT_COLOR_FORMAT_RGB444;
 		unsigned int bpc;
 
-		if (!info->is_hdmi)
+		if (!info->is_hdmi) {
+			/* DVI sinks take RGB only. */
+			if (drm_connector_get_color_format(conn_state) >
+			    DRM_CONNECTOR_COLOR_FORMAT_RGB444)
+				return -EINVAL;
 			break;
+		}
 
 		switch (drm_connector_get_color_format(conn_state)) {
 		case DRM_CONNECTOR_COLOR_FORMAT_YCBCR444:
diff --git a/drivers/gpu/drm/nouveau/nouveau_connector.c b/drivers/gpu/drm/nouveau/nouveau_connector.c
index e274251adbb2..fe4248dd39e3 100644
--- a/drivers/gpu/drm/nouveau/nouveau_connector.c
+++ b/drivers/gpu/drm/nouveau/nouveau_connector.c
@@ -298,7 +298,12 @@ nouveau_conn_attach_properties(struct drm_connector *connector)
 		drm_object_attach_property(&connector->base, dev->mode_config.
 					   dvi_i_subconnector_property, 0);
 
-	if (connector->connector_type == DRM_MODE_CONNECTOR_HDMIA) {
+	/* DVI connectors carry HDMI to HDMI sinks through passive adapters;
+	 * the output is selected from the sink's EDID, not the connector.
+	 */
+	if (connector->connector_type == DRM_MODE_CONNECTOR_HDMIA ||
+	    connector->connector_type == DRM_MODE_CONNECTOR_DVID ||
+	    connector->connector_type == DRM_MODE_CONNECTOR_DVII) {
 		drm_connector_attach_max_bpc_property(connector, 8, 16);
 
 		/* Only heads with an output CSC can emit limited range
-- 
2.53.0

