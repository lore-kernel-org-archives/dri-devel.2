Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F06C9CCF2C4
	for <dri-devel@archiver.kernel.org>; Sun, 18 Oct 2026 14:32:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A0BF10E62F;
	Sun, 18 Oct 2026 14:32:31 +0000 (UTC)
Received: from mout.web.de (mout.web.de [212.227.17.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E2F8410E62D
 for <dri-devel@lists.freedesktop.org>; Sun, 18 Oct 2026 14:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1792333934; x=1792938734; i=jan.claussen10@web.de;
 bh=CCCBgC3t202EBUvzUuRYpuK9FpeOT8mgidQb08HiPmk=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=o/AdPbquqKSOzEk/GzE0OYBbwGXpjGvo14eAEWbmHufIagIrVgauaZ7tqgAUHZ7H
 3asmYIOCudGYJzHBcMJi39VIiX81KrDpZPsRzw9yToF28OMDNMc4WXcouQqNjryVE
 7D1uMHXDqS/jGeYoAcJ0uvlZ9mnBR3CuPX6ExU2WNAoTKcm+8y8VqVDsLzJYl9mu0
 /4Fh1/vHFq2bWUf82EKhSC08bvarvZbNdkTe14T0c8ERxz5ImRmvj1dwNJrSeAKAb
 ab5eCeYQIbAp++uRd13c3MWDctZrmaJUfNRr62fAemwFqQfPa/cFS+yTWZumDdCjk
 sXYEAtpOO1IzBs9ywQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MPrPV-1wxC1e3feN-00MtoQ; Sun, 18
 Oct 2026 16:32:14 +0200
From: =?UTF-8?q?Jan=20Clau=C3=9Fen?= <jan.claussen10@web.de>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Daniel Stone <daniels@collabora.com>,
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
 =?UTF-8?q?Jan=20Clau=C3=9Fen?= <jan.claussen10@web.de>
Cc: John Harrison <John.Harrison@Igalia.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/7] drm/display: hdmi-state-helper: Force modeset on
 colorspace change
Date: Sun, 18 Oct 2026 16:31:08 +0200
Message-ID: <20261018143135.5745-3-jan.claussen10@web.de>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261018143135.5745-1-jan.claussen10@web.de>
References: <20261018143135.5745-1-jan.claussen10@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rnoV9k6mQhqwtCYjmAbVRxizqFA0KIufM61bxII2JCW2Malc5Fa
 uRnmh4Ma3yceQyFQkgPykx88KnabvcjrRJQyzmeew6dF+K7qOwxubu2MnEsVNC7S6L4Stfl
 L/+gwNLRWAdxmTX0iy9ETLzsElhZ66aHAxcxOY/aC0bKYGjabSbz0Si4ouGKE19mJhVmzvO
 dYwtx84K3hZ/LOm315xvA==
UI-OutboundReport: notjunk:1;M01:P0:nYCeqgIiivQ=;4Y0a7UiJ3lxOK0NYeso+fMMoi1h
 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
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

The colorimetry signalled to the sink is part of the AVI infoframe,
which is only updated on a modeset. A change of the colorspace
property therefore never reaches the sink.

Treat a colorspace change like a change of the Broadcast RGB, output
bpc or output format, and force a modeset.

Signed-off-by: Jan Clau=C3=9Fen <jan.claussen10@web.de>
=2D--
 drivers/gpu/drm/display/drm_hdmi_state_helper.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/display/drm_hdmi_state_helper.c b/drivers/gpu=
/drm/display/drm_hdmi_state_helper.c
index 7cdb7ca3dc12..9368e53c5945 100644
=2D-- a/drivers/gpu/drm/display/drm_hdmi_state_helper.c
+++ b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
@@ -925,7 +925,8 @@ int drm_atomic_helper_connector_hdmi_check(struct drm_=
connector *connector,
=20
 	if (old_conn_state->hdmi.broadcast_rgb !=3D new_conn_state->hdmi.broadca=
st_rgb ||
 	    old_conn_state->hdmi.output_bpc !=3D new_conn_state->hdmi.output_bpc=
 ||
-	    old_conn_state->hdmi.output_format !=3D new_conn_state->hdmi.output_=
format) {
+	    old_conn_state->hdmi.output_format !=3D new_conn_state->hdmi.output_=
format ||
+	    old_conn_state->colorspace !=3D new_conn_state->colorspace) {
 		struct drm_crtc *crtc =3D new_conn_state->crtc;
 		struct drm_crtc_state *crtc_state;
=20
=2D-=20
2.56.0

