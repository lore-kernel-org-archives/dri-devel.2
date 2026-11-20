Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A158D60A3813
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 05:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=KSYwqOLx
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD6511124C8;
	Fri, 20 Nov 2026 05:58:25 +0000 (UTC)
X-Greylist: delayed 371 seconds by postgrey-1.36 at gabe;
 Fri, 20 Nov 2026 05:58:13 UTC
Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com
 [162.62.57.252])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CDBA2112390;
 Fri, 20 Nov 2026 05:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1795154289; bh=0rtxnAVS+SOBKIRpCdmqnwHa9xTD14tDigFoA1ZRnQU=;
 h=From:To:Cc:Subject:Date;
 b=KSYwqOLx1hCYclg8LxVozS6+YYjT5xZfx7OkXMn7mWSEH9F3nWhQbXz/dnrpaO2jB
 Q4uwx0WYfU6ao8wcJETvtznTXjrgJ+KrzTiiipw0jnw9IJOFVrUHks1Us3ArMm0G6a
 VYitolVZnQpXik1Q7kLkiBsliTV4ecBb4MmQedns=
Received: from ThinkPad-T14 ([42.80.121.23])
 by newxmesmtplogicsvrszb51-0.qq.com (NewEsmtp) with SMTP
 id CB0ABEE9; Fri, 20 Nov 2026 13:50:48 +0800
X-QQ-mid: xmsmtpt1795153848t93i8srsr
Message-ID: <tencent_083AD2514CBC235A9F55EE00BDF72D3B9209@qq.com>
X-QQ-XMAILINFO: Od8VqZhFMB3NNO1PLXEcYg4ZfwDmjVQctLIyn0F9iRifepTaMoCCGDxjRX/KPv
 /7bODnHJkbtkPyyt1+njaCSGLclpqk4NdVpUtYScZxlrAekwXF3tgUbHJ2QROliurFo0RF2mEiEz
 3ky56ajIt2WdpEWIhTeuDCh5hKhlAGi+ffeJpliXP8aYG42lZhxT27FeoklEfhcoIMiN9n3ETJk7
 DmEFBVR3Yb7jHbCBINbQXI3/O62MlDGVVxB0LZMe3sOcf8+2jjO5azJkCC3c0o4LAdakR9hnqMYU
 I47ryJYj+pLCqE8cnxtYqjemKY5xVZEWpufGjsNRh7YM30a4PaThMok5RkPRQUgUxFpkRjultzDY
 s2hRphpOX6FHDLZ0wALmfxd5SofbuPAibjrv/Gee/wWWUf0iX+GBDJkeHKZOmjWo1MbulTn4fxdk
 x+H9OrnLaB5UcPJJWDKw3OGbX8Of4ra8gPGo9EomD6R2qKHAbRZud+dacRRfFEH6vWmTtEWFRG+e
 EBCSMrLkgX/O7WwsHx4qAX523iad+cTiV5FH71qyt11DS53jn0L1fUTKBMY0+VuZlQtlz8pmOScN
 PSpDxOHlAus8wDcmsMT5td7rQZ1BClrcKVO/o6wPSKG/qgLgTQgS5i/qFffs+1qFxsKT/jp2iIzw
 JvhlH7lYbSqAOKzqNCj2XOt1dNqMeDJDKu4Ku1VuyqXwJxjLa/Q4V37pCvmkdtEqYUxzChnWxCQV
 Wg77lV7yM3Vi/Csjo0EcsmwdOmlEmP9hcMkzHUk+2V09NrteBtDUx1skhH73MjTif/HJRUFMnjnp
 OGorjHvQ14uMzFRcmaw5rfUo69G0LLuFhGEOefNVIdWYQDun2ZIyiWaikiVKVKNt2iUtPfZpNfib
 grJzHeZ5fgymKYW0o37ri5VqlmcwH4R35vTsMKDa41TwjuUZ3q/cCjCzR/bxLFUIfvkT7FgzCFKW
 qMjPKtErf9iyRMDhDD5Ao0fFIFTmbyJDKrgMgAydGOjg0elWAIBAcQ/7uv8KQ/KZHggj7TXEGbTn
 JwQYIfIFm87tmvBsXVgvYfZbWRE/c=
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
From: Yitian Shao <fighters390@qq.com>
To: intel-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, ville.syrjala@linux.intel.com,
 jani.nikula@intel.com, sebastian.wick@redhat.com, uma.shankar@intel.com,
 suraj.kandpal@intel.com
Subject: [PATCH] drm/i915/dp: Attach HDR_OUTPUT_METADATA on eDP when TCON
 supports HDR
Date: Fri, 20 Nov 2026 13:50:48 +0800
X-OQ-MSGID: <20261120055048.47945-1-fighters390@qq.com>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

intel_dp_has_gamut_metadata_dip() returns false for port A on pre-ICL
platforms. intel_dp_add_properties() uses that helper to decide whether
to attach the HDR_OUTPUT_METADATA connector property, so eDP panels on
those platforms never expose it even when the panel advertises HDR in
its EDID.

On such panels the HDR metadata is not sent as a gamut metadata SDP, but
programmed through the Intel AUX HDR interface instead. The TCON is
already probed during intel_edp_backlight_setup(), which runs before
intel_dp_add_properties(), so the capability is known at that point.

Attach the property when the panel's TCON advertises PQ (ST2084) decode
support, so that userspace can enable HDR on these panels.

Since no SDP is transmitted in that case, also bail out early from
intel_dp_compute_hdr_metadata_infoframe_sdp() when the encoder cannot
send gamut metadata. Otherwise the computed infoframe state would be
inconsistent with what is actually programmed, and the state checker
would complain.

Closes: https://gitlab.freedesktop.org/drm/i915/kernel/-/work_items/10415
Signed-off-by: Yitian Shao <fighters390@qq.com>
---
Reviewer notes, not part of the commit message:

Tested on a CometLake-U (Gen9.5) laptop with a 3840x2160 10bpc eDP panel that
advertises BT2020 + ST2084 in its EDID. With this change the connector gains
the HDR_OUTPUT_METADATA property, GNOME 50 exposes the HDR switch, and the
panel enters PQ/BT2020 mode (the DP Colorspace property switches to
BT2020_RGB). The Intel TCON HDR backlight interface was already in use before
this change, so the hardware path existed and only the property was missing.

Two things I am not sure about:

1. intel_dp_aux_write_content_luminance() also returns early when
   !intel_dp_has_gamut_metadata_dip(), which is exactly the PORT_A case where
   the AUX path is used. max_cll/max_fall therefore never reach the TCON. In
   my testing Mutter sends all-zero mastering metadata anyway, so I could not
   tell whether this shows up in practice. Should this check be relaxed too,
   or is it intentional?

2. panel->backlight.edp.intel_cap shares a union with the VESA backlight
   info, so supports_2084_decode would read unrelated bits if the VESA
   interface had been selected instead of the Intel one. Would you prefer an
   explicit "Intel HDR backlight is in use" check here?

 drivers/gpu/drm/i915/display/intel_dp.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
index afd4169..49142f4 100644
--- a/drivers/gpu/drm/i915/display/intel_dp.c
+++ b/drivers/gpu/drm/i915/display/intel_dp.c
@@ -3088,6 +3088,9 @@ intel_dp_compute_hdr_metadata_infoframe_sdp(struct intel_dp *intel_dp,
 	int ret;
 	struct hdmi_drm_infoframe *drm_infoframe = &crtc_state->infoframes.drm.drm;
 
+	if (!intel_dp_has_gamut_metadata_dip(&dp_to_dig_port(intel_dp)->base))
+		return;
+
 	if (!conn_state->hdr_output_metadata)
 		return;
 
@@ -6715,7 +6718,9 @@ intel_dp_add_properties(struct intel_dp *intel_dp, struct drm_connector *_connec
 		intel_attach_dp_colorspace_property(&connector->base);
 	}
 
-	if (intel_dp_has_gamut_metadata_dip(&dp_to_dig_port(intel_dp)->base))
+	if (intel_dp_has_gamut_metadata_dip(&dp_to_dig_port(intel_dp)->base) ||
+	    (intel_dp_is_edp(intel_dp) &&
+	     connector->panel.backlight.edp.intel_cap.supports_2084_decode))
 		drm_connector_attach_hdr_output_metadata_property(&connector->base);
 
 	if (HAS_VRR(display))
-- 
2.53.0

