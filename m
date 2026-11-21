Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E09C1606A6A0
	for <dri-devel@archiver.kernel.org>; Sat, 21 Nov 2026 01:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=mj06pKDc
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 97B68112D9F;
	Sat, 21 Nov 2026 01:35:46 +0000 (UTC)
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EED2110E924;
 Sat, 21 Nov 2026 01:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1795224937; bh=cq5fvr/XhYoEty228aTIF8W++wbqTGZw0rCJWVYSFRc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=mj06pKDcrgJ2Cgi409m+XGMV7NjTgIsKgl2X6x5w+LlJZwwoun4SZmUSngxv2mFil
 bHJXRTw6KTY7ZxPscK6VbGIMh0SFF+l6CwFOIkrS3k4yfkeqFYgms74ljxA4YQMLKh
 mRJBhVQcg9vpI5PI8b7q7qyml0ohm+UIU3GZg2YU=
Received: from ThinkPad-T14 ([42.80.74.187])
 by newxmesmtplogicsvrszb51-0.qq.com (NewEsmtp) with SMTP
 id 8E0AE630; Sat, 21 Nov 2026 09:35:32 +0800
X-QQ-mid: xmsmtpt1795224934t8go8fzeo
Message-ID: <tencent_3496A349FCE9B826471144CFB37798DE7308@qq.com>
X-QQ-XMAILINFO: Nq6RUwyQu1GQzsAi+fqes7pOPaG+J0cKx1LA28cjTj1dppHA5QZ7wDaOQW2hTT
 M8ANiBj7dZ7+iUW1Jb+9NzXwwElznqF7dic8ehRSEYGbGQqSG0tr2VSXmIZClpXWcVIV6gUgjmp1
 9qKIO0UYuCd9x5ekaZlQKFDMqCTOxHwtFVIDYIiZpnueE2a4K/1W6WmSD89QzcHpW4j/z148MJXk
 wibr9Rj7v2y9RK+mFz7hN5boSoh2586LubiUZAeFwwgL69GU7hum28oeKylJEe6AMfdyW+R4ovEn
 +HKZL/6EZNS9wYeuPoCRFDmaxIvNaEH7nS+eZIWEgKpUvhaAtKNiyzaz9CqJFMNr9SjvfdMspqj5
 oiX3e+HYPJUVtbb/vLdO6w766+AoJhDTPgN2X5iIBPmB2C++QaXfoTxm8MHOp1bxn/B1LmzbIPlZ
 ivtehzOz03XnYLErnvppplIoF6VK5rLx2BupF6xguRtS2S7pxFkgjH/eyIPpoJNxOQb+r9Oo7fnm
 keeWoX4KU08hz3CbZV2ngmleltN4pxJQ26B6nwZr2EvOrVCpvQJI14QhBlOY8CSVMYY3Sk/BpstF
 EgFxvXYJnXjDBBEy+RqH2ikkbkU3OfjLwuOonUIY2piq3w5HsnaS8R1Ijwftow3wWoJIRh9cJfWR
 1L+UOimRQeEg2bpzOLw+KuRWVdXTEPC6SgDaND9mOnkQMF9l6lFv+1ok+m+BBFXYeyY1ufqvnjKr
 NnvldIFYn+8getxBvoLAT/KicopPYC4X2EYfPlFy7FkmDIcbn5v1AdN8crXZGO+u12DTa+847B+Z
 RJkxoxrBedF4vIc/DJvc2swCwIC6nwRLNFX470DAflUjwaTggI0c3A/E6Jne7F3DzPaq4zk6m6FV
 AyjQcVBE+7n66tWpIPc+TdSd1Oz58kjpFua9hzBd8RKZ3RwZtKCqZccbawGyZn0hQ5G5ssFt094O
 /6NS39ugCNgoxJYKf5r68TOf28ZhpVwWzCjTGu+WES2DhusIwgEDku+uQI5R6zMDs8lt+AaD9ziZ
 kdj8ZzJPiNHXTMo9b/gcO4zN10wxdRymhEjcpVTaOd5radWVZ4/g9Ub+QO4tzGj9Oc96aNq3/2mL
 ZISSmpFOJP+NVLeoEcolSLAWl9dyFM9sNkbXXf
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
From: Yitian Shao <fighters390@qq.com>
To: intel-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, ville.syrjala@linux.intel.com,
 jani.nikula@intel.com, sebastian.wick@redhat.com, uma.shankar@intel.com,
 suraj.kandpal@intel.com
Subject: [PATCH v4 1/4] drm/i915/dp: Drop LSPCON check from
 intel_dp_has_gamut_metadata_dip()
Date: Sat, 21 Nov 2026 09:35:29 +0800
X-OQ-MSGID: <20261121013532.21135-2-fighters390@qq.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261121013532.21135-1-fighters390@qq.com>
References: <20261121013532.21135-1-fighters390@qq.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

intel_dp_has_gamut_metadata_dip() returns false for LSPCON encoders, which
is not what the function is asking. The gamut metadata DIP exists regardless
of whether LSPCON is in use; LSPCON just writes it through
lspcon_write_infoframe().

The check only existed to keep intel_dp_add_properties() from attaching
HDR_OUTPUT_METADATA before intel_lspcon_detect_hdr_capability() has probed
the hardware. Move that check to intel_dp_add_properties() where the
attach decision is made.

Reviewed-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
Signed-off-by: Yitian Shao <fighters390@qq.com>
---
 drivers/gpu/drm/i915/display/intel_dp.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
index afd4169..2736a78 100644
--- a/drivers/gpu/drm/i915/display/intel_dp.c
+++ b/drivers/gpu/drm/i915/display/intel_dp.c
@@ -6672,9 +6672,6 @@ intel_dp_has_gamut_metadata_dip(struct intel_encoder *encoder)
 	struct intel_display *display = to_intel_display(encoder);
 	enum port port = encoder->port;
 
-	if (intel_bios_encoder_is_lspcon(encoder->devdata))
-		return false;
-
 	if (DISPLAY_VER(display) >= 11)
 		return true;
 
@@ -6715,7 +6712,9 @@ intel_dp_add_properties(struct intel_dp *intel_dp, struct drm_connector *_connec
 		intel_attach_dp_colorspace_property(&connector->base);
 	}
 
-	if (intel_dp_has_gamut_metadata_dip(&dp_to_dig_port(intel_dp)->base))
+	/* LSPCON attaches the property itself in intel_dp_connector_register() */
+	if (!intel_bios_encoder_is_lspcon(dp_to_dig_port(intel_dp)->base.devdata) &&
+	    intel_dp_has_gamut_metadata_dip(&dp_to_dig_port(intel_dp)->base))
 		drm_connector_attach_hdr_output_metadata_property(&connector->base);
 
 	if (HAS_VRR(display))
-- 
2.53.0

