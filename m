Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D534CCA490
	for <dri-devel@archiver.kernel.org>; Sun, 18 Oct 2026 12:37:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C93F10E617;
	Sun, 18 Oct 2026 12:37:28 +0000 (UTC)
X-Greylist: delayed 333 seconds by postgrey-1.36 at gabe;
 Sun, 18 Oct 2026 12:37:21 UTC
Received: from mout.web.de (mout.web.de [217.72.192.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7516310E614
 for <dri-devel@lists.freedesktop.org>; Sun, 18 Oct 2026 12:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1792327040; x=1792931840; i=jan.claussen10@web.de;
 bh=BF/1P4AvrIIFA9XMFtkI38tLivXVyi3Hsju2semGjjo=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=IzUXkWPIDTWg69oe0HHwoLPF8Vf8xW2NR/022ck4jkukcgpwMJGNhraDDrDiUEoU
 lcmyj9/h9FAO3UW74HenemWcnlc+PrytfJyzN4AVx4nGxCWpwoVg7wpaorToHu9PU
 spaopaqvFTXASoIDT30M63UUb/4isAqWQlx3sguQUfjUoOY+eOBPnFu3xXp+zUmkq
 wJCSDbHgrMFC/poGy/dcJs0Du7JTp9VERv06/oztzd4o2oa92CGFML9HuNjrJ3MMR
 9BpnVyARNzlk7GnkwXFPCsK2cWyDIuNLFGO/7MqOs6KZBQjbcpXKsooH8aLpTWE9Y
 FTzg00qoCpD6dZeBQA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mi53D-1wewZJ25Mv-00e0zh; Sun, 18
 Oct 2026 14:31:32 +0200
From: =?UTF-8?q?Jan=20Clau=C3=9Fen?= <jan.claussen10@web.de>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: =?UTF-8?q?Jan=20Clau=C3=9Fen?= <jan.claussen10@web.de>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/6] drm/connector: hdmi: Create the colorspace property
Date: Sun, 18 Oct 2026 14:30:13 +0200
Message-ID: <20261018123037.19560-4-jan.claussen10@web.de>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261018123037.19560-1-jan.claussen10@web.de>
References: <20261018123037.19560-1-jan.claussen10@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:OSU8NkmAUtGI+fmib6WS+aUVgukFrOY/L1r/UitymWnaSKcBy/n
 AJp6MaEfaoXCI0t/GpDwJ4NZDviQyKx0xIsz+594/GHw/gxlxaIAp4gbjB1UxaBzBx9Wdeq
 706PAyFiHgApNCfnFwtKf8wtKaRwcJPz4RivgxtTgh0t09Vj0rH97DJkmjQXFKTgL0wXTFE
 pgxF3FAT5FurTRvn1/29A==
UI-OutboundReport: notjunk:1;M01:P0:qgPsxsgqB4w=;NfutUfnjXTeX37ZOg7GNIBCBqI0
 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
 q5+QRjOGEmCip3wzCzw8SOj7n3s7OMXAkK3fOk=
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

HDMI connectors initialised through drmm_connector_hdmi_init() do not
expose the colorspace property, so userspace cannot signal colorimetry
such as BT.2020 for HDR output. KWin, for instance, does not offer HDR
without it.

Add a supported_colorspaces bitmask to struct drm_connector_hdmi_funcs.
If a driver sets it, create and attach the colorspace property with
the colorspaces it lists, next to the other HDMI properties.

Signed-off-by: Jan Clau=C3=9Fen <jan.claussen10@web.de>
=2D--
 drivers/gpu/drm/drm_connector.c | 9 +++++++++
 include/drm/drm_connector.h     | 7 +++++++
 2 files changed, 16 insertions(+)

diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connect=
or.c
index 66f53e155342..eea27bb6557c 100644
=2D-- a/drivers/gpu/drm/drm_connector.c
+++ b/drivers/gpu/drm/drm_connector.c
@@ -672,6 +672,15 @@ int drmm_connector_hdmi_init(struct drm_device *dev,
 	/* TODO: remove after conversion to new drmm_connector_hdmi_init() */
 	connector->max_bpc =3D hdmi_funcs->max_bpc;
=20
+	if (hdmi_funcs->supported_colorspaces) {
+		ret =3D drm_mode_create_hdmi_colorspace_property(connector,
+							       hdmi_funcs->supported_colorspaces);
+		if (ret)
+			return ret;
+
+		drm_connector_attach_colorspace_property(connector);
+	}
+
 	if (hdmi_funcs->max_bpc > 8)
 		drm_connector_attach_hdr_output_metadata_property(connector);
=20
diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
index 2ee7c59329aa..9d2d133463ba 100644
=2D-- a/include/drm/drm_connector.h
+++ b/include/drm/drm_connector.h
@@ -1521,6 +1521,13 @@ struct drm_connector_hdmi_funcs {
 	 */
 	unsigned long supported_formats;
=20
+	/**
+	 * @supported_colorspaces:
+	 *
+	 * Bitmask of &enum drm_colorspace listing supported color spaces.
+	 */
+	unsigned long supported_colorspaces;
+
 	/**
 	 * @max_bpc: Maximum bits per char the HDMI connector supports.
 	 */
=2D-=20
2.56.0

