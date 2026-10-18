Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DE9FCCF2C4
	for <dri-devel@archiver.kernel.org>; Sun, 18 Oct 2026 14:32:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 69E9410E62D;
	Sun, 18 Oct 2026 14:32:46 +0000 (UTC)
Received: from mout.web.de (mout.web.de [212.227.15.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A4E5010E635
 for <dri-devel@lists.freedesktop.org>; Sun, 18 Oct 2026 14:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1792333946; x=1792938746; i=jan.claussen10@web.de;
 bh=BF/1P4AvrIIFA9XMFtkI38tLivXVyi3Hsju2semGjjo=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=QCDkCAmD9TGN65nu9dvswkZDYKUnW/VaokEIWuKElDfymUIiUQaP9XzDgLOEWSrh
 pxxrMN6ai9HFYgbzF1VBoIspBkul0rlHgh2aW2PldAjWovTORoGduHAGzJdN273I4
 ZTFSwoY41mxP6gHhm2dvacmnbJmIkhpFzNjRBKat/Z5uTJbIdqc7BdGwWbDe2Gb/k
 ZfDMidFzV/ow1WtQWCP5xTpflchBpqHeF5VncmxidSeAMTij5xTBv/liD5BT2jiQV
 e6/e3hJw8VFQZZah/kl9xxh/iwnZB49mmkbqcToFRy8qJRpWEnhWq2BFrJPG4sXnn
 ESVLyanyijWxwFN9ZA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MeUbo-1wi1Fu041s-00pK4h; Sun, 18
 Oct 2026 16:32:26 +0200
From: =?UTF-8?q?Jan=20Clau=C3=9Fen?= <jan.claussen10@web.de>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: =?UTF-8?q?Jan=20Clau=C3=9Fen?= <jan.claussen10@web.de>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/7] drm/connector: hdmi: Create the colorspace property
Date: Sun, 18 Oct 2026 16:31:09 +0200
Message-ID: <20261018143135.5745-4-jan.claussen10@web.de>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261018143135.5745-1-jan.claussen10@web.de>
References: <20261018143135.5745-1-jan.claussen10@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:MDo4pCISQZA70n+i0rtAfbWSnws4DuzLXd+f9w+mPTp4R36G4Ju
 4QmS2EF6XYLwSWopaZKeDm2CFYKoui1/NMHxm3Jw9ue7jcA/l+w+q9SStxVEiFKfJE5ACYx
 iByKKfMYZY8ZdT6WkzQoMmCIl6VPSEqeJPABMBpCX6GBn4SqpYQ0wyMsxJ9UI6Mk5FxrNfA
 Pc4v+EhVVvcD1QTi7y4Dg==
UI-OutboundReport: notjunk:1;M01:P0:IG8STSxpLW4=;7QXhcRRHEmAno/u76itknQtOz3K
 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
 oQtoi3rw==
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

