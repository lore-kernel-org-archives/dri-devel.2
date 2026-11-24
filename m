Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5ED0606A32A
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 11:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DwMSZdwi
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 309E010F49D;
	Tue, 24 Nov 2026 11:00:19 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 874DD10F48B;
 Tue, 24 Nov 2026 11:00:12 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id EBE6B62608;
 Tue, 24 Nov 2026 11:00:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EF571F000C0;
 Tue, 24 Nov 2026 11:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795518011;
 bh=9EzRMSZT/fmL8csMPuHkmJk8Kn0aGbP0j/sPfGb/gi4=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=DwMSZdwiKvUQkADv7Bt+qligxkp+MQ9UW3CLhFasJir7xXTHhTsAfYRY5OCgNfEGZ
 IpkT/kY4LQChij6nvI0VodaygZ+Rn82ZQnkzNOWnp4umRcG6+OeCcUCjs9gnukOsKj
 6NK9rLntIIpYp14tRObewcEatnR8C4G+nNxbnfGnDWv9NXf/M/mH6hZPah7cm04qbV
 y6xmIG+yuwbnxWX/YByI9VFuGM3DxHhnrYLQCY0Ejukkbuun4C7seHzDLAF18Iw4Nm
 HLt6MqOhKAIRwM0cBZgH7xePGjJlAEdKDdZnkB8h3Ds15hBQvvo2lCr1wmMBCQO8cI
 F4yuy2mhvgrsg==
From: Maxime Ripard <mripard@kernel.org>
Date: Tue, 24 Nov 2026 11:59:52 +0100
Subject: [PATCH 2/6] drm/i915: Use the STATE_CHECK_* macros in the pipe
 config comparison
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261124-drm-i915-conversion-state-readout-v1-2-b7132f72644d@kernel.org>
References: <20261124-drm-i915-conversion-state-readout-v1-0-b7132f72644d@kernel.org>
In-Reply-To: <20261124-drm-i915-conversion-state-readout-v1-0-b7132f72644d@kernel.org>
To: Maxime Ripard <mripard@kernel.org>, 
 Jani Nikula <jani.nikula@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: intel-xe@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=31969; i=mripard@kernel.org;
 h=from:subject:message-id; bh=MmA/bBVSaJqdtwJPdLdPGeDr5UCho00bfW25OjlI3hc=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDNmseTqqK+oqzEvOhP3mSOifXp7qVl4frBi8xqhYTOKS5
 U9tMb+OqSwMwpwMsmKKLE9kwk4vb19c5WC/8gfMHFYmkCEMXJwCMJEjXxlrZQzc5m3Mb9A1uWNf
 eXV2hZ3OIdO56kmLX285/DzqZP1kRe2guZI5bwS/Jf8U/TjR1egUY8Ndle7ISjY/t23MG7a5sln
 NXuuwfrF/jvflpHOS52Zqu67+dUjzumV//PzII9u0dqaquQEA
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The state readout framework provides the STATE_CHECK_* macros and
drm_atomic_helper_print_state_mismatch() to compare two state
instances field by field and report the mismatches through a drm
printer.

intel_pipe_config_compare() implements the very same thing with its
own set of PIPE_CONF_CHECK_* macros printing through the
pipe_config_mismatch() helper, duplicating the framework.

Rework the plain field checks on top of the STATE_CHECK_* macros,
sorting every PIPE_CONF_CHECK_I() and PIPE_CONF_CHECK_X() call site
onto the variant matching its field type: STATE_CHECK_BOOL(), _S32(),
_ENUM(), _U8(), _U16(), _U32(), _U64() and _PTR(), along with the
_U8_X(), _U16_X() and _U32_X() hexadecimal counterparts. The
static_assert() of each macro then checks the field type at compile
time, which the untyped PIPE_CONF_CHECK_I() and _X() macros couldn't
do, and PIPE_CONF_CHECK_LLI() becomes a STATE_CHECK_U64() based check
that also prints its u64 fields properly.

The checks without a framework counterpart, namely the masked, flags,
M/N, DPLL, timings, rectangle, infoframe, DP SDP, ELD buffer, color
LUT and CSC ones, along with the infoframe, SDP, buffer and PLL
mismatch reporters, print their header through
drm_atomic_helper_print_state_mismatch() instead.
pipe_config_mismatch() isn't needed anymore and gets removed.

The mismatch messages change format in the process, from

  [CRTC:31:pipe A] fastset requirement not met in hw.enable (expected yes, found no)

to

  pipe A configuration mismatch in hw.enable (expected yes, got no)

The fastset and state checker invocations are still told apart by
their printer, drm_dbg_kms() for the former and drm_err() for the
latter, and the infoframe, SDP, buffer and PLL reporters keep dumping
both instances. The CRTC id is dropped from the messages, but the
i915 CRTC names are unique on their own.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/i915/display/intel_display.c | 493 +++++++++++++--------------
 1 file changed, 241 insertions(+), 252 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_display.c b/drivers/gpu/drm/i915/display/intel_display.c
index f79caeb5a82e..1172e48daf23 100644
--- a/drivers/gpu/drm/i915/display/intel_display.c
+++ b/drivers/gpu/drm/i915/display/intel_display.c
@@ -34,10 +34,11 @@
 
 #include <drm/display/drm_dp_helper.h>
 #include <drm/display/drm_dp_tunnel.h>
 #include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
+#include <drm/drm_atomic_state_readout_helper.h>
 #include <drm/drm_atomic_uapi.h>
 #include <drm/drm_damage_helper.h>
 #include <drm/drm_edid.h>
 #include <drm/drm_fixed.h>
 #include <drm/drm_fourcc.h>
@@ -5038,32 +5039,10 @@ static bool
 intel_compare_buffer(const u8 *a, const u8 *b, size_t len)
 {
 	return memcmp(a, b, len) == 0;
 }
 
-static void __printf(5, 6)
-pipe_config_mismatch(struct drm_printer *p, bool fastset,
-		     const struct intel_crtc *crtc,
-		     const char *name, const char *format, ...)
-{
-	struct va_format vaf;
-	va_list args;
-
-	va_start(args, format);
-	vaf.fmt = format;
-	vaf.va = &args;
-
-	if (fastset)
-		drm_printf(p, "[CRTC:%d:%s] fastset requirement not met in %s %pV\n",
-			   crtc->base.base.id, crtc->base.name, name, &vaf);
-	else
-		drm_printf(p, "[CRTC:%d:%s] mismatch in %s %pV\n",
-			   crtc->base.base.id, crtc->base.name, name, &vaf);
-
-	va_end(args);
-}
-
 static void
 pipe_config_infoframe_mismatch(struct drm_printer *p, bool fastset,
 			       const struct intel_crtc *crtc,
 			       const char *name,
 			       const union hdmi_infoframe *a,
@@ -5079,41 +5058,44 @@ pipe_config_infoframe_mismatch(struct drm_printer *p, bool fastset,
 		loglevel = KERN_DEBUG;
 	} else {
 		loglevel = KERN_ERR;
 	}
 
-	pipe_config_mismatch(p, fastset, crtc, name, "infoframe");
+	drm_atomic_helper_print_state_mismatch(p, crtc->base.name,
+					       name, "infoframe");
 
 	drm_printf(p, "expected:\n");
 	hdmi_infoframe_log(loglevel, display->drm->dev, a);
 	drm_printf(p, "found:\n");
 	hdmi_infoframe_log(loglevel, display->drm->dev, b);
 }
 
 static void
-pipe_config_dp_vsc_sdp_mismatch(struct drm_printer *p, bool fastset,
+pipe_config_dp_vsc_sdp_mismatch(struct drm_printer *p,
 				const struct intel_crtc *crtc,
 				const char *name,
 				const struct drm_dp_vsc_sdp *a,
 				const struct drm_dp_vsc_sdp *b)
 {
-	pipe_config_mismatch(p, fastset, crtc, name, "dp vsc sdp");
+	drm_atomic_helper_print_state_mismatch(p, crtc->base.name,
+					       name, "dp vsc sdp");
 
 	drm_printf(p, "expected:\n");
 	drm_dp_vsc_sdp_log(p, a);
 	drm_printf(p, "found:\n");
 	drm_dp_vsc_sdp_log(p, b);
 }
 
 static void
-pipe_config_dp_as_sdp_mismatch(struct drm_printer *p, bool fastset,
+pipe_config_dp_as_sdp_mismatch(struct drm_printer *p,
 			       const struct intel_crtc *crtc,
 			       const char *name,
 			       const struct drm_dp_as_sdp *a,
 			       const struct drm_dp_as_sdp *b)
 {
-	pipe_config_mismatch(p, fastset, crtc, name, "dp as sdp");
+	drm_atomic_helper_print_state_mismatch(p, crtc->base.name,
+					       name, "dp as sdp");
 
 	drm_printf(p, "expected:\n");
 	drm_dp_as_sdp_log(p, a);
 	drm_printf(p, "found:\n");
 	drm_dp_as_sdp_log(p, b);
@@ -5132,34 +5114,36 @@ memcmp_diff_len(const u8 *a, const u8 *b, size_t len)
 
 	return 0;
 }
 
 static void
-pipe_config_buffer_mismatch(struct drm_printer *p, bool fastset,
+pipe_config_buffer_mismatch(struct drm_printer *p,
 			    const struct intel_crtc *crtc,
 			    const char *name,
 			    const u8 *a, const u8 *b, size_t len)
 {
-	pipe_config_mismatch(p, fastset, crtc, name, "buffer");
+	drm_atomic_helper_print_state_mismatch(p, crtc->base.name,
+					       name, "buffer");
 
 	/* only dump up to the last difference */
 	len = memcmp_diff_len(a, b, len);
 
 	drm_print_hex_dump(p, "expected: ", a, len);
 	drm_print_hex_dump(p, "found:    ", b, len);
 }
 
 static void
-pipe_config_pll_mismatch(struct drm_printer *p, bool fastset,
+pipe_config_pll_mismatch(struct drm_printer *p,
 			 const struct intel_crtc *crtc,
 			 const char *name,
 			 const struct intel_dpll_hw_state *a,
 			 const struct intel_dpll_hw_state *b)
 {
 	struct intel_display *display = to_intel_display(crtc);
 
-	pipe_config_mismatch(p, fastset, crtc, name, " "); /* stupid -Werror=format-zero-length */
+	/* stupid -Werror=format-zero-length */
+	drm_atomic_helper_print_state_mismatch(p, crtc->base.name, name, " ");
 
 	drm_printf(p, "expected:\n");
 	intel_dpll_dump_hw_state(display, p, a);
 	drm_printf(p, "found:\n");
 	intel_dpll_dump_hw_state(display, p, b);
@@ -5198,179 +5182,169 @@ intel_pipe_config_compare(const struct intel_crtc_state *current_config,
 	if (fastset)
 		p = drm_dbg_printer(display->drm, DRM_UT_KMS, NULL);
 	else
 		p = drm_err_printer(display->drm, NULL);
 
-#define PIPE_CONF_CHECK_X(name) do { \
-	if (current_config->name != pipe_config->name) { \
-		BUILD_BUG_ON_MSG(__same_type(current_config->name, bool), \
-				 __stringify(name) " is bool");	\
-		pipe_config_mismatch(&p, fastset, crtc, __stringify(name), \
-				     "(expected 0x%08x, found 0x%08x)", \
-				     current_config->name, \
-				     pipe_config->name); \
+#define PIPE_CONF_CHECK_BOOL(field) \
+	STATE_CHECK_BOOL(ret, &p, crtc->base.name, \
+			 current_config, pipe_config, field)
+
+#define PIPE_CONF_CHECK_S32(field) \
+	STATE_CHECK_S32(ret, &p, crtc->base.name, \
+			current_config, pipe_config, field)
+
+#define PIPE_CONF_CHECK_ENUM(field) \
+	STATE_CHECK_ENUM(ret, &p, crtc->base.name, \
+			 current_config, pipe_config, field)
+
+#define PIPE_CONF_CHECK_U8(field) \
+	STATE_CHECK_U8(ret, &p, crtc->base.name, \
+		       current_config, pipe_config, field)
+
+#define PIPE_CONF_CHECK_U16(field) \
+	STATE_CHECK_U16(ret, &p, crtc->base.name, \
+			current_config, pipe_config, field)
+
+#define PIPE_CONF_CHECK_U32(field) \
+	STATE_CHECK_U32(ret, &p, crtc->base.name, \
+			current_config, pipe_config, field)
+
+#define PIPE_CONF_CHECK_U64(field) \
+	STATE_CHECK_U64(ret, &p, crtc->base.name, \
+			current_config, pipe_config, field)
+
+#define PIPE_CONF_CHECK_P(field) \
+	STATE_CHECK_PTR(ret, &p, crtc->base.name, \
+			current_config, pipe_config, field)
+
+#define PIPE_CONF_CHECK_U8_X(field) \
+	STATE_CHECK_U8_X(ret, &p, crtc->base.name, \
+			 current_config, pipe_config, field)
+
+#define PIPE_CONF_CHECK_U16_X(field) \
+	STATE_CHECK_U16_X(ret, &p, crtc->base.name, \
+			  current_config, pipe_config, field)
+
+#define PIPE_CONF_CHECK_U32_X(field) \
+	STATE_CHECK_U32_X(ret, &p, crtc->base.name, \
+			  current_config, pipe_config, field)
+
+#define PIPE_CONF_CHECK_X_WITH_MASK(field, mask) do { \
+	if ((current_config->field & (mask)) != (pipe_config->field & (mask))) { \
+		drm_atomic_helper_print_state_mismatch(&p, crtc->base.name, \
+						       __stringify(field), \
+						       "expected %x, got %x", \
+						       current_config->field & (mask), \
+						       pipe_config->field & (mask)); \
 		ret = false; \
 	} \
 } while (0)
 
-#define PIPE_CONF_CHECK_X_WITH_MASK(name, mask) do { \
-	if ((current_config->name & (mask)) != (pipe_config->name & (mask))) { \
-		BUILD_BUG_ON_MSG(__same_type(current_config->name, bool), \
-				 __stringify(name) " is bool");	\
-		pipe_config_mismatch(&p, fastset, crtc, __stringify(name), \
-				     "(expected 0x%08x, found 0x%08x)", \
-				     current_config->name & (mask), \
-				     pipe_config->name & (mask)); \
+#define PIPE_CONF_CHECK_M_N(field) do { \
+	if (!intel_compare_link_m_n(&current_config->field, \
+				    &pipe_config->field)) { \
+		drm_atomic_helper_print_state_mismatch(&p, crtc->base.name, \
+						       __stringify(field), \
+						       "expected tu %i data %i/%i link %i/%i, " \
+						       "got tu %i data %i/%i link %i/%i", \
+						       current_config->field.tu, \
+						       current_config->field.data_m, \
+						       current_config->field.data_n, \
+						       current_config->field.link_m, \
+						       current_config->field.link_n, \
+						       pipe_config->field.tu, \
+						       pipe_config->field.data_m, \
+						       pipe_config->field.data_n, \
+						       pipe_config->field.link_m, \
+						       pipe_config->field.link_n); \
 		ret = false; \
 	} \
 } while (0)
 
-#define PIPE_CONF_CHECK_I(name) do { \
-	if (current_config->name != pipe_config->name) { \
-		BUILD_BUG_ON_MSG(__same_type(current_config->name, bool), \
-				 __stringify(name) " is bool");	\
-		pipe_config_mismatch(&p, fastset, crtc, __stringify(name), \
-				     "(expected %i, found %i)", \
-				     current_config->name, \
-				     pipe_config->name); \
-		ret = false; \
-	} \
-} while (0)
-
-#define PIPE_CONF_CHECK_LLI(name) do { \
-	if (current_config->name != pipe_config->name) { \
-		pipe_config_mismatch(&p, fastset, crtc, __stringify(name), \
-				     "(expected %lli, found %lli)", \
-				     current_config->name, \
-				     pipe_config->name); \
-		ret = false; \
-	} \
-} while (0)
-
-#define PIPE_CONF_CHECK_BOOL(name) do { \
-	if (current_config->name != pipe_config->name) { \
-		BUILD_BUG_ON_MSG(!__same_type(current_config->name, bool), \
-				 __stringify(name) " is not bool");	\
-		pipe_config_mismatch(&p, fastset, crtc, __stringify(name), \
-				     "(expected %s, found %s)", \
-				     str_yes_no(current_config->name), \
-				     str_yes_no(pipe_config->name)); \
-		ret = false; \
-	} \
-} while (0)
-
-#define PIPE_CONF_CHECK_P(name) do { \
-	if (current_config->name != pipe_config->name) { \
-		pipe_config_mismatch(&p, fastset, crtc, __stringify(name), \
-				     "(expected %p, found %p)", \
-				     current_config->name, \
-				     pipe_config->name); \
-		ret = false; \
-	} \
-} while (0)
-
-#define PIPE_CONF_CHECK_M_N(name) do { \
-	if (!intel_compare_link_m_n(&current_config->name, \
-				    &pipe_config->name)) { \
-		pipe_config_mismatch(&p, fastset, crtc, __stringify(name), \
-				     "(expected tu %i data %i/%i link %i/%i, " \
-				     "found tu %i, data %i/%i link %i/%i)", \
-				     current_config->name.tu, \
-				     current_config->name.data_m, \
-				     current_config->name.data_n, \
-				     current_config->name.link_m, \
-				     current_config->name.link_n, \
-				     pipe_config->name.tu, \
-				     pipe_config->name.data_m, \
-				     pipe_config->name.data_n, \
-				     pipe_config->name.link_m, \
-				     pipe_config->name.link_n); \
-		ret = false; \
-	} \
-} while (0)
-
-#define PIPE_CONF_CHECK_PLL(name) do { \
-	if (!intel_dpll_compare_hw_state(display, &current_config->name, \
-					 &pipe_config->name)) { \
-		pipe_config_pll_mismatch(&p, fastset, crtc, __stringify(name), \
-					 &current_config->name, \
-					 &pipe_config->name); \
+#define PIPE_CONF_CHECK_PLL(field) do { \
+	if (!intel_dpll_compare_hw_state(display, &current_config->field, \
+					 &pipe_config->field)) { \
+		pipe_config_pll_mismatch(&p, crtc, __stringify(field), \
+					 &current_config->field, \
+					 &pipe_config->field); \
 		ret = false; \
 	} \
 } while (0)
 
 #define PIPE_CONF_CHECK_TIMINGS(name) do {     \
-	PIPE_CONF_CHECK_I(name.crtc_hdisplay); \
-	PIPE_CONF_CHECK_I(name.crtc_htotal); \
-	PIPE_CONF_CHECK_I(name.crtc_hblank_start); \
-	PIPE_CONF_CHECK_I(name.crtc_hblank_end); \
-	PIPE_CONF_CHECK_I(name.crtc_hsync_start); \
-	PIPE_CONF_CHECK_I(name.crtc_hsync_end); \
-	PIPE_CONF_CHECK_I(name.crtc_vdisplay); \
+	PIPE_CONF_CHECK_U16(name.crtc_hdisplay); \
+	PIPE_CONF_CHECK_U16(name.crtc_htotal); \
+	PIPE_CONF_CHECK_U16(name.crtc_hblank_start); \
+	PIPE_CONF_CHECK_U16(name.crtc_hblank_end); \
+	PIPE_CONF_CHECK_U16(name.crtc_hsync_start); \
+	PIPE_CONF_CHECK_U16(name.crtc_hsync_end); \
+	PIPE_CONF_CHECK_U16(name.crtc_vdisplay); \
 	if (!fastset || !allow_vblank_delay_fastset(current_config)) \
-		PIPE_CONF_CHECK_I(name.crtc_vblank_start); \
+		PIPE_CONF_CHECK_U16(name.crtc_vblank_start); \
 	if (!fastset || !pipe_config->update_lrr) { \
-		PIPE_CONF_CHECK_I(name.crtc_vsync_start); \
-		PIPE_CONF_CHECK_I(name.crtc_vsync_end); \
-		PIPE_CONF_CHECK_I(name.crtc_vtotal); \
-		PIPE_CONF_CHECK_I(name.crtc_vblank_end); \
+		PIPE_CONF_CHECK_U16(name.crtc_vsync_start); \
+		PIPE_CONF_CHECK_U16(name.crtc_vsync_end); \
+		PIPE_CONF_CHECK_U16(name.crtc_vtotal); \
+		PIPE_CONF_CHECK_U16(name.crtc_vblank_end); \
 	} \
 } while (0)
 
 #define PIPE_CONF_CHECK_RECT(name) do { \
-	PIPE_CONF_CHECK_I(name.x1); \
-	PIPE_CONF_CHECK_I(name.x2); \
-	PIPE_CONF_CHECK_I(name.y1); \
-	PIPE_CONF_CHECK_I(name.y2); \
+	PIPE_CONF_CHECK_S32(name.x1); \
+	PIPE_CONF_CHECK_S32(name.x2); \
+	PIPE_CONF_CHECK_S32(name.y1); \
+	PIPE_CONF_CHECK_S32(name.y2); \
 } while (0)
 
-#define PIPE_CONF_CHECK_FLAGS(name, mask) do { \
-	if ((current_config->name ^ pipe_config->name) & (mask)) { \
-		pipe_config_mismatch(&p, fastset, crtc, __stringify(name), \
-				     "(%x) (expected %i, found %i)", \
-				     (mask), \
-				     current_config->name & (mask), \
-				     pipe_config->name & (mask)); \
+#define PIPE_CONF_CHECK_FLAGS(field, mask) do { \
+	if ((current_config->field ^ pipe_config->field) & (mask)) { \
+		drm_atomic_helper_print_state_mismatch(&p, crtc->base.name, \
+						       __stringify(field), \
+						       "(%x) expected %i, got %i", \
+						       (mask), \
+						       current_config->field & (mask), \
+						       pipe_config->field & (mask)); \
 		ret = false; \
 	} \
 } while (0)
 
 #define PIPE_CONF_CHECK_INFOFRAME(name) do { \
 	if (!intel_compare_infoframe(&current_config->infoframes.name, \
 				     &pipe_config->infoframes.name)) { \
-		pipe_config_infoframe_mismatch(&p, fastset, crtc, __stringify(name), \
+		pipe_config_infoframe_mismatch(&p, fastset, crtc, \
+					       __stringify(name), \
 					       &current_config->infoframes.name, \
 					       &pipe_config->infoframes.name); \
 		ret = false; \
 	} \
 } while (0)
 
 #define PIPE_CONF_CHECK_DP_VSC_SDP(name) do { \
 	if (!intel_compare_dp_vsc_sdp(&current_config->infoframes.name, \
 				      &pipe_config->infoframes.name)) { \
-		pipe_config_dp_vsc_sdp_mismatch(&p, fastset, crtc, __stringify(name), \
+		pipe_config_dp_vsc_sdp_mismatch(&p, crtc, __stringify(name), \
 						&current_config->infoframes.name, \
 						&pipe_config->infoframes.name); \
 		ret = false; \
 	} \
 } while (0)
 
 #define PIPE_CONF_CHECK_DP_AS_SDP(name) do { \
 	if (!intel_compare_dp_as_sdp(&current_config->infoframes.name, \
 				      &pipe_config->infoframes.name)) { \
-		pipe_config_dp_as_sdp_mismatch(&p, fastset, crtc, __stringify(name), \
+		pipe_config_dp_as_sdp_mismatch(&p, crtc, __stringify(name), \
 						&current_config->infoframes.name, \
 						&pipe_config->infoframes.name); \
 		ret = false; \
 	} \
 } while (0)
 
 #define PIPE_CONF_CHECK_BUFFER(name, len) do { \
 	BUILD_BUG_ON(sizeof(current_config->name) != (len)); \
 	BUILD_BUG_ON(sizeof(pipe_config->name) != (len)); \
 	if (!intel_compare_buffer(current_config->name, pipe_config->name, (len))) { \
-		pipe_config_buffer_mismatch(&p, fastset, crtc, __stringify(name), \
+		pipe_config_buffer_mismatch(&p, crtc, __stringify(name), \
 					    current_config->name, \
 					    pipe_config->name, \
 					    (len)); \
 		ret = false; \
 	} \
@@ -5379,69 +5353,70 @@ intel_pipe_config_compare(const struct intel_crtc_state *current_config,
 #define PIPE_CONF_CHECK_COLOR_LUT(lut, is_pre_csc_lut) do { \
 	if (current_config->gamma_mode == pipe_config->gamma_mode && \
 	    !intel_color_lut_equal(current_config, \
 				   current_config->lut, pipe_config->lut, \
 				   is_pre_csc_lut)) {	\
-		pipe_config_mismatch(&p, fastset, crtc, __stringify(lut), \
-				     "hw_state doesn't match sw_state"); \
+		drm_atomic_helper_print_state_mismatch(&p, crtc->base.name, \
+						       __stringify(lut), \
+						       "hw_state doesn't match sw_state"); \
 		ret = false; \
 	} \
 } while (0)
 
-#define PIPE_CONF_CHECK_CSC(name) do { \
-	PIPE_CONF_CHECK_X(name.preoff[0]); \
-	PIPE_CONF_CHECK_X(name.preoff[1]); \
-	PIPE_CONF_CHECK_X(name.preoff[2]); \
-	PIPE_CONF_CHECK_X(name.coeff[0]); \
-	PIPE_CONF_CHECK_X(name.coeff[1]); \
-	PIPE_CONF_CHECK_X(name.coeff[2]); \
-	PIPE_CONF_CHECK_X(name.coeff[3]); \
-	PIPE_CONF_CHECK_X(name.coeff[4]); \
-	PIPE_CONF_CHECK_X(name.coeff[5]); \
-	PIPE_CONF_CHECK_X(name.coeff[6]); \
-	PIPE_CONF_CHECK_X(name.coeff[7]); \
-	PIPE_CONF_CHECK_X(name.coeff[8]); \
-	PIPE_CONF_CHECK_X(name.postoff[0]); \
-	PIPE_CONF_CHECK_X(name.postoff[1]); \
-	PIPE_CONF_CHECK_X(name.postoff[2]); \
+#define PIPE_CONF_CHECK_CSC(field) do { \
+	PIPE_CONF_CHECK_U16_X(field.preoff[0]); \
+	PIPE_CONF_CHECK_U16_X(field.preoff[1]); \
+	PIPE_CONF_CHECK_U16_X(field.preoff[2]); \
+	PIPE_CONF_CHECK_U16_X(field.coeff[0]); \
+	PIPE_CONF_CHECK_U16_X(field.coeff[1]); \
+	PIPE_CONF_CHECK_U16_X(field.coeff[2]); \
+	PIPE_CONF_CHECK_U16_X(field.coeff[3]); \
+	PIPE_CONF_CHECK_U16_X(field.coeff[4]); \
+	PIPE_CONF_CHECK_U16_X(field.coeff[5]); \
+	PIPE_CONF_CHECK_U16_X(field.coeff[6]); \
+	PIPE_CONF_CHECK_U16_X(field.coeff[7]); \
+	PIPE_CONF_CHECK_U16_X(field.coeff[8]); \
+	PIPE_CONF_CHECK_U16_X(field.postoff[0]); \
+	PIPE_CONF_CHECK_U16_X(field.postoff[1]); \
+	PIPE_CONF_CHECK_U16_X(field.postoff[2]); \
 } while (0)
 
 #define PIPE_CONF_QUIRK(quirk) \
 	((current_config->quirks | pipe_config->quirks) & (quirk))
 
 	PIPE_CONF_CHECK_BOOL(hw.enable);
 	PIPE_CONF_CHECK_BOOL(hw.active);
 
-	PIPE_CONF_CHECK_I(cpu_transcoder);
-	PIPE_CONF_CHECK_I(mst_master_transcoder);
+	PIPE_CONF_CHECK_ENUM(cpu_transcoder);
+	PIPE_CONF_CHECK_ENUM(mst_master_transcoder);
 
 	PIPE_CONF_CHECK_BOOL(has_pch_encoder);
-	PIPE_CONF_CHECK_I(fdi_lanes);
+	PIPE_CONF_CHECK_S32(fdi_lanes);
 	PIPE_CONF_CHECK_M_N(fdi_m_n);
 
-	PIPE_CONF_CHECK_I(lane_count);
-	PIPE_CONF_CHECK_X(lane_lat_optim_mask);
+	PIPE_CONF_CHECK_U8(lane_count);
+	PIPE_CONF_CHECK_U8_X(lane_lat_optim_mask);
 
-	PIPE_CONF_CHECK_I(min_hblank);
+	PIPE_CONF_CHECK_S32(min_hblank);
 
 	if (HAS_DOUBLE_BUFFERED_M_N(display)) {
 		if (!fastset || !pipe_config->update_m_n)
 			PIPE_CONF_CHECK_M_N(dp_m_n);
 	} else {
 		PIPE_CONF_CHECK_M_N(dp_m_n);
 		PIPE_CONF_CHECK_M_N(dp_m2_n2);
 	}
 
-	PIPE_CONF_CHECK_X(output_types);
+	PIPE_CONF_CHECK_U32_X(output_types);
 
-	PIPE_CONF_CHECK_I(framestart_delay);
-	PIPE_CONF_CHECK_I(msa_timing_delay);
+	PIPE_CONF_CHECK_U8(framestart_delay);
+	PIPE_CONF_CHECK_U8(msa_timing_delay);
 
 	PIPE_CONF_CHECK_TIMINGS(hw.pipe_mode);
 	PIPE_CONF_CHECK_TIMINGS(hw.adjusted_mode);
 
-	PIPE_CONF_CHECK_I(pixel_multiplier);
+	PIPE_CONF_CHECK_U32(pixel_multiplier);
 
 	PIPE_CONF_CHECK_FLAGS(hw.adjusted_mode.flags,
 			      DRM_MODE_FLAG_INTERLACE);
 
 	if (!PIPE_CONF_QUIRK(PIPE_CONFIG_QUIRK_MODE_SYNC_FLAGS)) {
@@ -5453,11 +5428,11 @@ intel_pipe_config_compare(const struct intel_crtc_state *current_config,
 				      DRM_MODE_FLAG_PVSYNC);
 		PIPE_CONF_CHECK_FLAGS(hw.adjusted_mode.flags,
 				      DRM_MODE_FLAG_NVSYNC);
 	}
 
-	PIPE_CONF_CHECK_I(output_format);
+	PIPE_CONF_CHECK_ENUM(output_format);
 	PIPE_CONF_CHECK_BOOL(has_hdmi_sink);
 	if ((DISPLAY_VER(display) < 8 && !display->platform.haswell) ||
 	    display->platform.valleyview || display->platform.cherryview)
 		PIPE_CONF_CHECK_BOOL(limited_color_range);
 
@@ -5470,15 +5445,15 @@ intel_pipe_config_compare(const struct intel_crtc_state *current_config,
 	if (!fastset) {
 		PIPE_CONF_CHECK_BOOL(has_audio);
 		PIPE_CONF_CHECK_BUFFER(eld, MAX_ELD_BYTES);
 	}
 
-	PIPE_CONF_CHECK_X(gmch_pfit.control);
+	PIPE_CONF_CHECK_U32_X(gmch_pfit.control);
 	/* pfit ratios are autocomputed by the hw on gen4+ */
 	if (DISPLAY_VER(display) < 4)
-		PIPE_CONF_CHECK_X(gmch_pfit.pgm_ratios);
-	PIPE_CONF_CHECK_X(gmch_pfit.lvds_border_bits);
+		PIPE_CONF_CHECK_U32_X(gmch_pfit.pgm_ratios);
+	PIPE_CONF_CHECK_U32_X(gmch_pfit.lvds_border_bits);
 
 	/*
 	 * Changing the EDP transcoder input mux
 	 * (A_ONOFF vs. A_ON) requires a full modeset.
 	 */
@@ -5488,30 +5463,30 @@ intel_pipe_config_compare(const struct intel_crtc_state *current_config,
 		PIPE_CONF_CHECK_RECT(pipe_src);
 
 		PIPE_CONF_CHECK_BOOL(pch_pfit.enabled);
 		PIPE_CONF_CHECK_RECT(pch_pfit.dst);
 		PIPE_CONF_CHECK_BOOL(pch_pfit.casf.enable);
-		PIPE_CONF_CHECK_I(pch_pfit.casf.win_size);
-		PIPE_CONF_CHECK_I(pch_pfit.casf.strength);
+		PIPE_CONF_CHECK_U8(pch_pfit.casf.win_size);
+		PIPE_CONF_CHECK_U8(pch_pfit.casf.strength);
 
-		PIPE_CONF_CHECK_I(scaler_state.scaler_id);
-		PIPE_CONF_CHECK_I(pixel_rate_cdclk);
-		PIPE_CONF_CHECK_I(pixel_rate);
+		PIPE_CONF_CHECK_S32(scaler_state.scaler_id);
+		PIPE_CONF_CHECK_U32(pixel_rate_cdclk);
+		PIPE_CONF_CHECK_U32(pixel_rate);
 
-		PIPE_CONF_CHECK_X(gamma_mode);
+		PIPE_CONF_CHECK_U32_X(gamma_mode);
 		if (display->platform.cherryview)
-			PIPE_CONF_CHECK_X(cgm_mode);
+			PIPE_CONF_CHECK_U32_X(cgm_mode);
 		else
-			PIPE_CONF_CHECK_X(csc_mode);
+			PIPE_CONF_CHECK_U32_X(csc_mode);
 		PIPE_CONF_CHECK_BOOL(gamma_enable);
 
-		PIPE_CONF_CHECK_X(hw.background_color);
+		PIPE_CONF_CHECK_U32_X(hw.background_color);
 		PIPE_CONF_CHECK_BOOL(csc_enable);
 		PIPE_CONF_CHECK_BOOL(wgc_enable);
 
-		PIPE_CONF_CHECK_I(linetime);
-		PIPE_CONF_CHECK_I(ips_linetime);
+		PIPE_CONF_CHECK_U16(linetime);
+		PIPE_CONF_CHECK_U16(ips_linetime);
 
 		PIPE_CONF_CHECK_COLOR_LUT(pre_csc_lut, true);
 		PIPE_CONF_CHECK_COLOR_LUT(post_csc_lut, false);
 
 		PIPE_CONF_CHECK_CSC(csc);
@@ -5525,123 +5500,137 @@ intel_pipe_config_compare(const struct intel_crtc_state *current_config,
 
 	/* FIXME convert everything over the dpll_mgr */
 	if (display->dpll.mgr || HAS_GMCH(display))
 		PIPE_CONF_CHECK_PLL(dpll_hw_state);
 
-	PIPE_CONF_CHECK_X(dsi_pll.ctrl);
-	PIPE_CONF_CHECK_X(dsi_pll.div);
+	PIPE_CONF_CHECK_U32_X(dsi_pll.ctrl);
+	PIPE_CONF_CHECK_U32_X(dsi_pll.div);
 
 	if (display->platform.g4x || DISPLAY_VER(display) >= 5)
-		PIPE_CONF_CHECK_I(pipe_bpp);
+		PIPE_CONF_CHECK_S32(pipe_bpp);
 
 	if (!fastset || !pipe_config->update_m_n) {
-		PIPE_CONF_CHECK_I(hw.pipe_mode.crtc_clock);
-		PIPE_CONF_CHECK_I(hw.adjusted_mode.crtc_clock);
+		PIPE_CONF_CHECK_S32(hw.pipe_mode.crtc_clock);
+		PIPE_CONF_CHECK_S32(hw.adjusted_mode.crtc_clock);
 	}
-	PIPE_CONF_CHECK_I(port_clock);
+	PIPE_CONF_CHECK_S32(port_clock);
 
-	PIPE_CONF_CHECK_I(min_voltage_level);
+	PIPE_CONF_CHECK_U8(min_voltage_level);
 
 	if (current_config->has_psr || pipe_config->has_psr)
 		exclude_infoframes |= intel_hdmi_infoframe_enable(DP_SDP_VSC);
 
 	if (current_config->vrr.enable || pipe_config->vrr.enable)
 		exclude_infoframes |= intel_hdmi_infoframe_enable(DP_SDP_ADAPTIVE_SYNC);
 
 	PIPE_CONF_CHECK_X_WITH_MASK(infoframes.enable, ~exclude_infoframes);
-	PIPE_CONF_CHECK_X(infoframes.gcp);
+	PIPE_CONF_CHECK_U32_X(infoframes.gcp);
 	PIPE_CONF_CHECK_INFOFRAME(avi);
 	PIPE_CONF_CHECK_INFOFRAME(spd);
 	PIPE_CONF_CHECK_INFOFRAME(hdmi);
 	if (!fastset) {
 		PIPE_CONF_CHECK_INFOFRAME(drm);
 		PIPE_CONF_CHECK_DP_AS_SDP(as_sdp);
 	}
 	PIPE_CONF_CHECK_DP_VSC_SDP(vsc);
 
-	PIPE_CONF_CHECK_X(sync_mode_slaves_mask);
-	PIPE_CONF_CHECK_I(master_transcoder);
-	PIPE_CONF_CHECK_X(joiner_pipes);
+	PIPE_CONF_CHECK_U16_X(sync_mode_slaves_mask);
+	PIPE_CONF_CHECK_ENUM(master_transcoder);
+	PIPE_CONF_CHECK_U8_X(joiner_pipes);
 
 	PIPE_CONF_CHECK_BOOL(dsc.config.block_pred_enable);
 	PIPE_CONF_CHECK_BOOL(dsc.config.convert_rgb);
 	PIPE_CONF_CHECK_BOOL(dsc.config.simple_422);
 	PIPE_CONF_CHECK_BOOL(dsc.config.native_422);
 	PIPE_CONF_CHECK_BOOL(dsc.config.native_420);
 	PIPE_CONF_CHECK_BOOL(dsc.config.vbr_enable);
-	PIPE_CONF_CHECK_I(dsc.config.line_buf_depth);
-	PIPE_CONF_CHECK_I(dsc.config.bits_per_component);
-	PIPE_CONF_CHECK_I(dsc.config.pic_width);
-	PIPE_CONF_CHECK_I(dsc.config.pic_height);
-	PIPE_CONF_CHECK_I(dsc.config.slice_width);
-	PIPE_CONF_CHECK_I(dsc.config.slice_height);
-	PIPE_CONF_CHECK_I(dsc.config.initial_dec_delay);
-	PIPE_CONF_CHECK_I(dsc.config.initial_xmit_delay);
-	PIPE_CONF_CHECK_I(dsc.config.scale_decrement_interval);
-	PIPE_CONF_CHECK_I(dsc.config.scale_increment_interval);
-	PIPE_CONF_CHECK_I(dsc.config.initial_scale_value);
-	PIPE_CONF_CHECK_I(dsc.config.first_line_bpg_offset);
-	PIPE_CONF_CHECK_I(dsc.config.flatness_min_qp);
-	PIPE_CONF_CHECK_I(dsc.config.flatness_max_qp);
-	PIPE_CONF_CHECK_I(dsc.config.slice_bpg_offset);
-	PIPE_CONF_CHECK_I(dsc.config.nfl_bpg_offset);
-	PIPE_CONF_CHECK_I(dsc.config.initial_offset);
-	PIPE_CONF_CHECK_I(dsc.config.final_offset);
-	PIPE_CONF_CHECK_I(dsc.config.rc_model_size);
-	PIPE_CONF_CHECK_I(dsc.config.rc_quant_incr_limit0);
-	PIPE_CONF_CHECK_I(dsc.config.rc_quant_incr_limit1);
-	PIPE_CONF_CHECK_I(dsc.config.slice_chunk_size);
-	PIPE_CONF_CHECK_I(dsc.config.second_line_bpg_offset);
-	PIPE_CONF_CHECK_I(dsc.config.nsl_bpg_offset);
+	PIPE_CONF_CHECK_U8(dsc.config.line_buf_depth);
+	PIPE_CONF_CHECK_U8(dsc.config.bits_per_component);
+	PIPE_CONF_CHECK_U16(dsc.config.pic_width);
+	PIPE_CONF_CHECK_U16(dsc.config.pic_height);
+	PIPE_CONF_CHECK_U16(dsc.config.slice_width);
+	PIPE_CONF_CHECK_U16(dsc.config.slice_height);
+	PIPE_CONF_CHECK_U16(dsc.config.initial_dec_delay);
+	PIPE_CONF_CHECK_U16(dsc.config.initial_xmit_delay);
+	PIPE_CONF_CHECK_U16(dsc.config.scale_decrement_interval);
+	PIPE_CONF_CHECK_U16(dsc.config.scale_increment_interval);
+	PIPE_CONF_CHECK_U8(dsc.config.initial_scale_value);
+	PIPE_CONF_CHECK_U8(dsc.config.first_line_bpg_offset);
+	PIPE_CONF_CHECK_U8(dsc.config.flatness_min_qp);
+	PIPE_CONF_CHECK_U8(dsc.config.flatness_max_qp);
+	PIPE_CONF_CHECK_U16(dsc.config.slice_bpg_offset);
+	PIPE_CONF_CHECK_U16(dsc.config.nfl_bpg_offset);
+	PIPE_CONF_CHECK_U16(dsc.config.initial_offset);
+	PIPE_CONF_CHECK_U16(dsc.config.final_offset);
+	PIPE_CONF_CHECK_U16(dsc.config.rc_model_size);
+	PIPE_CONF_CHECK_U8(dsc.config.rc_quant_incr_limit0);
+	PIPE_CONF_CHECK_U8(dsc.config.rc_quant_incr_limit1);
+	PIPE_CONF_CHECK_U16(dsc.config.slice_chunk_size);
+	PIPE_CONF_CHECK_U8(dsc.config.second_line_bpg_offset);
+	PIPE_CONF_CHECK_U16(dsc.config.nsl_bpg_offset);
 
 	PIPE_CONF_CHECK_BOOL(dsc.compression_enable);
-	PIPE_CONF_CHECK_I(dsc.slice_config.streams_per_pipe);
-	PIPE_CONF_CHECK_I(dsc.compressed_bpp_x16);
+	PIPE_CONF_CHECK_S32(dsc.slice_config.streams_per_pipe);
+	PIPE_CONF_CHECK_U16(dsc.compressed_bpp_x16);
 
 	PIPE_CONF_CHECK_BOOL(splitter.enable);
-	PIPE_CONF_CHECK_I(splitter.link_count);
-	PIPE_CONF_CHECK_I(splitter.pixel_overlap);
+	PIPE_CONF_CHECK_U8(splitter.link_count);
+	PIPE_CONF_CHECK_U8(splitter.pixel_overlap);
 
 	if (!fastset) {
 		PIPE_CONF_CHECK_BOOL(vrr.enable);
-		PIPE_CONF_CHECK_I(vrr.vmin);
-		PIPE_CONF_CHECK_I(vrr.vmax);
-		PIPE_CONF_CHECK_I(vrr.flipline);
-		PIPE_CONF_CHECK_I(vrr.vsync_start);
-		PIPE_CONF_CHECK_I(vrr.vsync_end);
-		PIPE_CONF_CHECK_LLI(vrr.cmrr.cmrr_m);
-		PIPE_CONF_CHECK_LLI(vrr.cmrr.cmrr_n);
+		PIPE_CONF_CHECK_U16(vrr.vmin);
+		PIPE_CONF_CHECK_U16(vrr.vmax);
+		PIPE_CONF_CHECK_U16(vrr.flipline);
+		PIPE_CONF_CHECK_U32(vrr.vsync_start);
+		PIPE_CONF_CHECK_U32(vrr.vsync_end);
+		PIPE_CONF_CHECK_U64(vrr.cmrr.cmrr_m);
+		PIPE_CONF_CHECK_U64(vrr.cmrr.cmrr_n);
 		PIPE_CONF_CHECK_BOOL(vrr.cmrr.enable);
-		PIPE_CONF_CHECK_I(vrr.dc_balance.vmin);
-		PIPE_CONF_CHECK_I(vrr.dc_balance.vmax);
-		PIPE_CONF_CHECK_I(vrr.dc_balance.guardband);
-		PIPE_CONF_CHECK_I(vrr.dc_balance.slope);
-		PIPE_CONF_CHECK_I(vrr.dc_balance.max_increase);
-		PIPE_CONF_CHECK_I(vrr.dc_balance.max_decrease);
-		PIPE_CONF_CHECK_I(vrr.dc_balance.vblank_target);
-		PIPE_CONF_CHECK_I(dip.emp_as_sdp_tl);
-		PIPE_CONF_CHECK_I(dip.gmp_sdp_tl);
-		PIPE_CONF_CHECK_I(dip.pps_sdp_tl);
-		PIPE_CONF_CHECK_I(dip.vsc_sdp_tl);
-		PIPE_CONF_CHECK_I(dip.vsc_ext_sdp_tl);
-		PIPE_CONF_CHECK_I(dip.cmn_sdp_tl);
+		PIPE_CONF_CHECK_U16(vrr.dc_balance.vmin);
+		PIPE_CONF_CHECK_U16(vrr.dc_balance.vmax);
+		PIPE_CONF_CHECK_U16(vrr.dc_balance.guardband);
+		PIPE_CONF_CHECK_U16(vrr.dc_balance.slope);
+		PIPE_CONF_CHECK_U16(vrr.dc_balance.max_increase);
+		PIPE_CONF_CHECK_U16(vrr.dc_balance.max_decrease);
+		PIPE_CONF_CHECK_U16(vrr.dc_balance.vblank_target);
+		PIPE_CONF_CHECK_U16(dip.emp_as_sdp_tl);
+		PIPE_CONF_CHECK_U16(dip.gmp_sdp_tl);
+		PIPE_CONF_CHECK_U16(dip.pps_sdp_tl);
+		PIPE_CONF_CHECK_U16(dip.vsc_sdp_tl);
+		PIPE_CONF_CHECK_U16(dip.vsc_ext_sdp_tl);
+		PIPE_CONF_CHECK_U16(dip.cmn_sdp_tl);
 	}
 
 	if (!fastset || intel_vrr_always_use_vrr_tg(display)) {
-		PIPE_CONF_CHECK_I(vrr.pipeline_full);
-		PIPE_CONF_CHECK_I(vrr.guardband);
+		PIPE_CONF_CHECK_U8(vrr.pipeline_full);
+		PIPE_CONF_CHECK_U16(vrr.guardband);
 	}
 
-	PIPE_CONF_CHECK_I(set_context_latency);
+	PIPE_CONF_CHECK_U16(set_context_latency);
 
-#undef PIPE_CONF_CHECK_X
-#undef PIPE_CONF_CHECK_I
-#undef PIPE_CONF_CHECK_LLI
 #undef PIPE_CONF_CHECK_BOOL
+#undef PIPE_CONF_CHECK_S32
+#undef PIPE_CONF_CHECK_ENUM
+#undef PIPE_CONF_CHECK_U8
+#undef PIPE_CONF_CHECK_U16
+#undef PIPE_CONF_CHECK_U32
+#undef PIPE_CONF_CHECK_U64
 #undef PIPE_CONF_CHECK_P
+#undef PIPE_CONF_CHECK_U8_X
+#undef PIPE_CONF_CHECK_U16_X
+#undef PIPE_CONF_CHECK_U32_X
+#undef PIPE_CONF_CHECK_X_WITH_MASK
+#undef PIPE_CONF_CHECK_M_N
+#undef PIPE_CONF_CHECK_PLL
 #undef PIPE_CONF_CHECK_FLAGS
+#undef PIPE_CONF_CHECK_INFOFRAME
+#undef PIPE_CONF_CHECK_DP_VSC_SDP
+#undef PIPE_CONF_CHECK_DP_AS_SDP
+#undef PIPE_CONF_CHECK_BUFFER
 #undef PIPE_CONF_CHECK_COLOR_LUT
+#undef PIPE_CONF_CHECK_CSC
 #undef PIPE_CONF_CHECK_TIMINGS
 #undef PIPE_CONF_CHECK_RECT
 #undef PIPE_CONF_QUIRK
 
 	return ret;

-- 
2.56.1

