Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E39F606A333
	for <dri-devel@archiver.kernel.org>; Sat, 21 Nov 2026 00:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=H3tMaz3X
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 95FE510E3A3;
	Sat, 21 Nov 2026 00:54:22 +0000 (UTC)
Received: from out203-205-221-247.mail.qq.com (out203-205-221-247.mail.qq.com
 [203.205.221.247])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C900610E10E;
 Sat, 21 Nov 2026 00:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1795222454; bh=JxiFJjKpVM0R5XOhRu2Ngfm7sYmXcHQfOgQmlFA8A1w=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=H3tMaz3XfPrfhO7u7xzpTgSaN7/i/yWQBZFEPPfIaifPYi/aGqFOUKcVoa7pOJ1qR
 7+XuS9GTJVOpStf75tHLb3KlWOK5XOndVTYJAfTFr5N8nsJJUrB66r/SY8RHtAuqYo
 cqEFM1+PTjoHlzqT/xvk5b97QONtFxJMywE1O8fc=
Received: from ThinkPad-T14 ([42.80.74.187])
 by newxmesmtplogicsvrsza73-0.qq.com (NewEsmtp) with SMTP
 id D8985C1C; Sat, 21 Nov 2026 08:54:09 +0800
X-QQ-mid: xmsmtpt1795222451twpi4a1wu
Message-ID: <tencent_B90E2647114BCF037778DE0C967949C0E908@qq.com>
X-QQ-XMAILINFO: Nq6RUwyQu1GQzsAi+fqes7o3Hbn82aB5dsXY4/RISNFhSV6h4LdD4+VFFyIloY
 yWxRh68P/mp9pI43YXDQTWYjQF3U3q/zmom1Y9yzsPQdlW8d58ICqOCRm88ZQvvWb6txXfxwS7jR
 sfDok1jbo6sTjChssG5LcGp/uD8dTgOAyNzh3xaxzyO411Adp4l+n2FI8+ySY2a0c74zgqJtrz60
 olRq6eU/RIQ4mjZ/OvGJmxA7V2fQE9jNw4VVGBB06oQBRer7Hu6RSmCi43Jd9BIYWRdGoNJ15GqN
 Wn8WQlFeVqh78HpO1R4pZo/BES4Dis/PtKIdp3rjrzf14Avtr+q1Ejvnr+45IZN//cknxMaU6Y6a
 hk7/gxMM7LVUQZgljyUMcEC+fH6FdxmeVBLcX1giS34DpfHlBHMFnhb6rVLeYBh1qbiVAFgcyp52
 +zPBSiGBzIIFZ5o1vfx/3BF6eBJWwClRnUZz2vqikFV4JryeaTj+rnFtpVx9FCt3MSj4ICvewH23
 IaYhNUXy8s68jK4UNF+8+b812am7fGr4aOVCWXy4w4bjkhc1MGafAhR+LsnCgnlwAsPyrWZP/ocR
 +YmQMW0UF+6xQrF95ITHfMQ+QIblz/XufDLesS10n/OlMXW6KW5ZBY0WD3cXu3yH/L5oaZgZHEaj
 gUlGb2r3X7cV1WhEDCM7PGkM9jvPytYqSrGXQOkOs8ZLIe8ZljBz0PFYdHlH2vvfxPrqIN1/TF4H
 BTMYHYDxR5garuAnVpkcfx2GRR+mL2X7BJlMcgc6vnibkZFZZ5Mb+AiO3X6El+HZBGLoFofDQ0W5
 DZAQAdzq9rWMjzCl/P4kaqk0Cc5kEoI9UBuj7SsLOwdl0ycmYFL5NqgVxiNBpJY4aGcfwon1JMPc
 ngfsyPsXGdBjFcDpNFrUeVlSE+MIYvWAYxJUn8Lrh8f3Q776C+8+7Cc1uBol91zxThFzC34d30er
 luTJYhjrbQV8lic6QpgKwCB1jEvcR51/x7C4yFZYj9rvxphTDZxqHfmZgrnFNQqAi7JE6OE1pTMI
 JdM6KzN7/yhXsGxE6TT7iaRXMo6tk=
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
From: Yitian Shao <fighters390@qq.com>
To: intel-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, ville.syrjala@linux.intel.com,
 jani.nikula@intel.com, sebastian.wick@redhat.com, uma.shankar@intel.com,
 suraj.kandpal@intel.com
Subject: [PATCH v3 1/4] drm/i915/dp: Drop LSPCON check from
 intel_dp_has_gamut_metadata_dip()
Date: Sat, 21 Nov 2026 08:54:06 +0800
X-OQ-MSGID: <20261121005409.17626-2-fighters390@qq.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261121005409.17626-1-fighters390@qq.com>
References: <20261121005409.17626-1-fighters390@qq.com>
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

intel_dp_has_gamut_metadata_dip() returns false for LSPCON encoders, which
is not what the function is asking. LSPCON does send the HDR metadata
infoframe, only through lspcon_write_infoframe() instead of the transcoder
DIP.

The check only existed to keep intel_dp_add_properties() from attaching
HDR_OUTPUT_METADATA before intel_lspcon_detect_hdr_capability() has probed
the hardware. Move that check to intel_dp_add_properties() where the
attach decision is made.

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

