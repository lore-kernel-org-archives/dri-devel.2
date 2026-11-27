Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F26606A331
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 09:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j0q7vzQI
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D9429112937;
	Fri, 27 Nov 2026 09:55:28 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC3DE112927
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 09:54:42 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 178E06256D;
 Fri, 27 Nov 2026 09:54:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2282E1F00933;
 Fri, 27 Nov 2026 09:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795773281;
 bh=fFL/sP2xOT4iQkPTpLtUqq3hLDOkjyLNM1mitFrIZm4=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=j0q7vzQIE0qJ8Ijy7QXF8BZiM32+QPSCdfNDag+jQgOQYudy7PXt6JHdsmr1daRMM
 tx09dH/qqxg0vAzgdMQFSeZ6R+Ze6qTLb0BkvkwK/Rqtlr11KO685fL2JIf41P/ik+
 c0wC7QcdJtNZBCGTneBrh5YLX4FaP/iTb8kUnESwE60xohkKtVDqsBS9RIIAi6gShW
 ceffHqMT8CzW6Xgt2VpTpoTLfRRix20tjSZxAlZUWohY+IRnncF/sct55EGozrhdPe
 Y18LgAsC72zNaS1LsdBcVpNE0Oh0X2+kNv4Sm/3XfNP/e9BkNmu1QXdHnU+gyj9yw8
 kj2JggetWMEnA==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 27 Nov 2026 10:53:06 +0100
Subject: [PATCH v10 24/36] drm/atomic_sro: Provide helpers to find the
 refresh rate from a clock
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261127-drm-state-readout-v10-24-0259582d45a8@kernel.org>
References: <20261127-drm-state-readout-v10-0-0259582d45a8@kernel.org>
In-Reply-To: <20261127-drm-state-readout-v10-0-0259582d45a8@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Jyri Sarha <jyri.sarha@iki.fi>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Devarsh Thakkar <devarsht@ti.com>, dri-devel@lists.freedesktop.org, 
 Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=23147; i=mripard@kernel.org;
 h=from:subject:message-id; bh=LpzOfPPCNcDBj6/EQ0qnBIfaEsE6S9UwntdGtUFwUec=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDNmcwexV/3nU9Bfuf6gleWqzo8W/GyFzLtfu05ioHyWY1
 2l64czijqksDMKcDLJiiixPZMJOL29fXOVgv/IHzBxWJpAhDFycAjAR+yLGOrMVi5tKO7UmyUmo
 rhL8lSdYHW3te1fMRXlh4MrEz3Nf/Xun6vj6QOoDc3PvgE92omuPMzbcT2E7/N19xV+PVx8vZ61
 outJ7L4A7YO3vIIVL9b++edraLrU6JLDz89XZ6n5/cyrfnToHAA==
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

The timings a driver reads out of the hardware don't hold the refresh
rate, but a display mode needs one. It can be derived from the rate of
the pixel clock instead.

Provide drm_atomic_helper_sro_find_refresh_from_clk_with_tolerance() to
match the pixel clock rate against the ones of the 30, 50 and 60 Hz
standard refresh rates, with and without the 1000/1001 factor, for a
given mode size. The tolerance is a parameter, since the accuracy of a
clock depends on the hardware.

Add drm_atomic_helper_sro_find_refresh_from_clk(), using the 0.5%
tolerance VESA DMT defines for the pixel clock.

Add a KUnit suite for both, running on a mock clock. It needs the common
clock framework, so it has its own configuration option depending on it,
instead of making DRM_KUNIT_TEST depend on it, which would disable all
the other DRM tests where it isn't available.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/Kconfig.debug                      |  19 ++
 drivers/gpu/drm/drm_atomic_state_readout_helper.c  | 181 ++++++++++++
 drivers/gpu/drm/tests/.kunitconfig                 |   2 +
 drivers/gpu/drm/tests/Makefile                     |   3 +
 .../tests/drm_atomic_state_readout_refresh_test.c  | 323 +++++++++++++++++++++
 include/drm/drm_atomic_state_readout_helper.h      |  15 +
 6 files changed, 543 insertions(+)

diff --git a/drivers/gpu/drm/Kconfig.debug b/drivers/gpu/drm/Kconfig.debug
index b909cd0a619f..7d9d40258fd1 100644
--- a/drivers/gpu/drm/Kconfig.debug
+++ b/drivers/gpu/drm/Kconfig.debug
@@ -82,10 +82,29 @@ config DRM_KUNIT_TEST
 	  please refer to the KUnit documentation in
 	  Documentation/dev-tools/kunit/.
 
 	  If in doubt, say "N".
 
+config DRM_ATOMIC_SRO_REFRESH_KUNIT_TEST
+	tristate "KUnit tests for the DRM state readout refresh rate helpers" if !KUNIT_ALL_TESTS
+	depends on DRM && KUNIT && COMMON_CLK
+	select DRM_KUNIT_TEST_HELPERS
+	default KUNIT_ALL_TESTS
+	help
+	  This builds unit tests for the DRM helpers deriving a refresh
+	  rate from a pixel clock when reading out the hardware state.
+	  They run on a mock clock, and thus need the common clock
+	  framework. This option is not useful for distributions or
+	  general kernels, but only for kernel developers working on DRM
+	  and associated drivers.
+
+	  For more information on KUnit and unit tests in general,
+	  please refer to the KUnit documentation in
+	  Documentation/dev-tools/kunit/.
+
+	  If in doubt, say "N".
+
 config DRM_TTM_KUNIT_TEST
 	tristate "KUnit tests for TTM" if !KUNIT_ALL_TESTS
 	depends on DRM && KUNIT && MMU && (UML || COMPILE_TEST)
 	select DRM_TTM
 	select DRM_BUDDY
diff --git a/drivers/gpu/drm/drm_atomic_state_readout_helper.c b/drivers/gpu/drm/drm_atomic_state_readout_helper.c
index 0111cb4def43..9cd207781bf5 100644
--- a/drivers/gpu/drm/drm_atomic_state_readout_helper.c
+++ b/drivers/gpu/drm/drm_atomic_state_readout_helper.c
@@ -16,11 +16,15 @@
 #include <drm/drm_plane.h>
 #include <drm/drm_print.h>
 #include <drm/drm_rect.h>
 #include <drm/drm_vblank.h>
 
+#include <linux/clk.h>
 #include <linux/gfp.h>
+#include <linux/limits.h>
+#include <linux/math.h>
+#include <linux/math64.h>
 #include <linux/sched/mm.h>
 #include <linux/slab.h>
 
 static void drm_atomic_helper_sro_gem_dma_free(struct drm_gem_object *gem_obj)
 {
@@ -133,10 +137,187 @@ drm_atomic_helper_sro_create_gem_dma_object(struct drm_device *dev,
 
 	return dma_obj;
 }
 EXPORT_SYMBOL(drm_atomic_helper_sro_create_gem_dma_object);
 
+static unsigned long calc_pixel_clock_hz(unsigned int htotal,
+					 unsigned int vtotal,
+					 unsigned int refresh,
+					 unsigned int freq_div)
+{
+	u64 rate = (u64)htotal * vtotal * refresh;
+
+	return div_u64(rate * 1000, freq_div);
+}
+
+static bool pixel_clock_within_tolerance(unsigned long expected,
+					 unsigned long actual,
+					 unsigned int tolerance)
+{
+	unsigned long long lowest = (unsigned long long)expected * (1000 - tolerance);
+	unsigned long long highest = (unsigned long long)expected * (1000 + tolerance);
+
+	do_div(lowest, 1000);
+	do_div(highest, 1000);
+
+	return actual >= lowest && actual <= highest;
+}
+
+static const unsigned int refresh_tries[] = {30, 50, 60};
+static const unsigned int refresh_factors_tries[] = {1000, 1001};
+
+/**
+ * drm_atomic_helper_sro_find_refresh_from_clk_with_tolerance - match a clock to a refresh rate
+ * @dev: DRM device
+ * @clk: pixel clock driving the display
+ * @htotal: total horizontal size of the mode, blanking included
+ * @vtotal: total vertical size of the mode, blanking included
+ * @tolerance: maximum difference between the rate of @clk and the pixel
+ *             clock of a standard mode, in per mille. Must be lower
+ *             than 1000.
+ * @pixel_clock_hz: optional location to store the pixel clock rate of
+ *                  the matching standard mode, in Hz
+ *
+ * The timings a driver reads out of the hardware don't hold the refresh
+ * rate, which a &struct drm_display_mode needs. The driver can derive it
+ * from the rate of the pixel clock instead, assuming that the mode uses
+ * one of the 30, 50 and 60 Hz standard refresh rates, with or without
+ * the 1000/1001 factor of the NTSC compatible ones (29.97 and 59.94 Hz,
+ * for example).
+ *
+ * This function computes the pixel clock rate each of those refresh
+ * rates would require for @htotal and @vtotal, and picks the one
+ * closest to the rate of @clk.
+ *
+ * The refresh rate it returns is the nominal one, 60 for 59.94 Hz. The
+ * 1000/1001 factor is only visible in @pixel_clock_hz, which is set to
+ * the pixel clock rate of the standard mode, not to the actual rate of
+ * @clk. It is left untouched if no standard mode matches.
+ *
+ * Returns:
+ * The refresh rate in Hz, which is either 30, 50 or 60, or 0 if the
+ * rate of @clk is further than @tolerance from the pixel clock of every
+ * standard mode, or if @tolerance is invalid.
+ */
+unsigned int
+drm_atomic_helper_sro_find_refresh_from_clk_with_tolerance(struct drm_device *dev,
+							   struct clk *clk,
+							   unsigned int htotal,
+							   unsigned int vtotal,
+							   unsigned int tolerance,
+							   unsigned long *pixel_clock_hz)
+{
+	unsigned long actual_clk_rate = clk_get_rate(clk);
+	unsigned long best_clk_rate = 0;
+	unsigned long best_rate_diff = ULONG_MAX;
+	unsigned int best_refresh = 0;
+	unsigned int i, j;
+
+	if (tolerance >= 1000)
+		return 0;
+
+	drm_dbg(dev, "Actual clock rate is %lu\n", actual_clk_rate);
+
+	for (i = 0; i < ARRAY_SIZE(refresh_tries); i++) {
+		for (j = 0; j < ARRAY_SIZE(refresh_factors_tries); j++) {
+			unsigned int try_refresh = refresh_tries[i];
+			unsigned int try_factor = refresh_factors_tries[j];
+			unsigned long try_clk_rate = calc_pixel_clock_hz(htotal,
+									 vtotal,
+									 try_refresh,
+									 try_factor);
+			unsigned long diff;
+
+			drm_dbg(dev, "Evaluating refresh %u, factor %u, rate %lu\n",
+				try_refresh, try_factor, try_clk_rate);
+
+			if (try_clk_rate == actual_clk_rate) {
+				drm_dbg(dev, "Found exact match. Stopping.\n");
+				best_refresh = try_refresh;
+				best_clk_rate = try_clk_rate;
+				goto out;
+			}
+
+			diff = abs_diff(actual_clk_rate, try_clk_rate);
+			if (diff < best_rate_diff) {
+				drm_dbg(dev, "Found new candidate. Difference is %lu\n", diff);
+				best_refresh = try_refresh;
+				best_clk_rate = try_clk_rate;
+				best_rate_diff = diff;
+			}
+		}
+	}
+
+	/*
+	 * The clock rate doesn't exactly match any standard refresh
+	 * rate, but the clock driver might not be able to produce the
+	 * exact rate and round it instead. Accept the closest standard
+	 * rate if the clock is within the tolerance of its pixel clock.
+	 *
+	 * Otherwise, the mode we would report would be plain wrong.
+	 * Report the configuration as unsupported by returning 0, so
+	 * that the caller falls back on the regular initialization
+	 * path.
+	 */
+	if (!pixel_clock_within_tolerance(best_clk_rate, actual_clk_rate, tolerance)) {
+		drm_dbg_kms(dev,
+			    "Clock rate %lu doesn't match any standard refresh rate\n",
+			    actual_clk_rate);
+		return 0;
+	}
+
+out:
+	drm_dbg_kms(dev, "Best candidate is %u Hz, pixel clock rate %lu Hz",
+		    best_refresh, best_clk_rate);
+
+	if (pixel_clock_hz)
+		*pixel_clock_hz = best_clk_rate;
+
+	return best_refresh;
+}
+EXPORT_SYMBOL(drm_atomic_helper_sro_find_refresh_from_clk_with_tolerance);
+
+/**
+ * drm_atomic_helper_sro_find_refresh_from_clk - match a clock to a refresh rate
+ * @dev: DRM device
+ * @clk: pixel clock driving the display
+ * @htotal: total horizontal size of the mode, blanking included
+ * @vtotal: total vertical size of the mode, blanking included
+ * @pixel_clock_hz: optional location to store the pixel clock rate of
+ *                  the matching standard mode, in Hz
+ *
+ * Same as drm_atomic_helper_sro_find_refresh_from_clk_with_tolerance(),
+ * with a tolerance of 0.5%, which is the one VESA DMT defines for the
+ * pixel clock.
+ *
+ * Returns:
+ * The refresh rate in Hz, which is either 30, 50 or 60, or 0 if the
+ * rate of @clk is further than 0.5% from the pixel clock of every
+ * standard mode.
+ */
+unsigned int
+drm_atomic_helper_sro_find_refresh_from_clk(struct drm_device *dev,
+					    struct clk *clk,
+					    unsigned int htotal,
+					    unsigned int vtotal,
+					    unsigned long *pixel_clock_hz)
+{
+	/*
+	 * VESA DMT defines a tolerance of 0.5% on the pixel clock,
+	 * while the CVT spec reuses that tolerance in its examples, so
+	 * it looks to be a good default tolerance. Define it to 5 per
+	 * mille to avoid floating point operations.
+	 */
+	return drm_atomic_helper_sro_find_refresh_from_clk_with_tolerance(dev,
+									  clk,
+									  htotal,
+									  vtotal,
+									  5,
+									  pixel_clock_hz);
+}
+EXPORT_SYMBOL(drm_atomic_helper_sro_find_refresh_from_clk);
+
 static int
 drm_atomic_helper_sro_readout_plane_state(struct drm_device *dev,
 					  struct drm_atomic_sro_state *state,
 					  struct drm_plane *plane)
 {
diff --git a/drivers/gpu/drm/tests/.kunitconfig b/drivers/gpu/drm/tests/.kunitconfig
index 5be8e71f45d5..0710a9f4c927 100644
--- a/drivers/gpu/drm/tests/.kunitconfig
+++ b/drivers/gpu/drm/tests/.kunitconfig
@@ -1,5 +1,7 @@
 CONFIG_KUNIT=y
+CONFIG_COMMON_CLK=y
 CONFIG_DRM=y
 CONFIG_DRM_VKMS=y
 CONFIG_DRM_FBDEV_EMULATION=y
 CONFIG_DRM_KUNIT_TEST=y
+CONFIG_DRM_ATOMIC_SRO_REFRESH_KUNIT_TEST=y
diff --git a/drivers/gpu/drm/tests/Makefile b/drivers/gpu/drm/tests/Makefile
index b11a07094b32..79125515bd0e 100644
--- a/drivers/gpu/drm/tests/Makefile
+++ b/drivers/gpu/drm/tests/Makefile
@@ -27,6 +27,9 @@ obj-$(CONFIG_DRM_KUNIT_TEST) += \
 	drm_rect_test.o \
 	drm_sysfb_modeset_test.o \
 	drm_fixp_test.o \
 	drm_kunit_edid.o
 
+obj-$(CONFIG_DRM_ATOMIC_SRO_REFRESH_KUNIT_TEST) += \
+	drm_atomic_state_readout_refresh_test.o
+
 CFLAGS_drm_mm_test.o := $(DISABLE_STRUCTLEAK_PLUGIN)
diff --git a/drivers/gpu/drm/tests/drm_atomic_state_readout_refresh_test.c b/drivers/gpu/drm/tests/drm_atomic_state_readout_refresh_test.c
new file mode 100644
index 000000000000..ef5298eb806d
--- /dev/null
+++ b/drivers/gpu/drm/tests/drm_atomic_state_readout_refresh_test.c
@@ -0,0 +1,323 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Kunit test for the DRM atomic state readout refresh rate helpers
+ */
+
+#include <drm/drm_atomic_state_readout_helper.h>
+#include <drm/drm_device.h>
+#include <drm/drm_drv.h>
+#include <drm/drm_kunit_helpers.h>
+
+#include <kunit/clk.h>
+#include <kunit/test.h>
+
+#include <linux/clk.h>
+#include <linux/clk-provider.h>
+
+/*
+ * The helpers only read the rate of the clock, so the tests drive them
+ * with a mock clock that reports whatever rate it was created with.
+ */
+
+struct sro_refresh_test_clk {
+	struct clk_hw hw;
+	unsigned long rate;
+};
+
+static unsigned long
+sro_refresh_test_clk_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
+{
+	struct sro_refresh_test_clk *tclk =
+		container_of(hw, struct sro_refresh_test_clk, hw);
+
+	return tclk->rate;
+}
+
+static const struct clk_ops sro_refresh_test_clk_ops = {
+	.recalc_rate = sro_refresh_test_clk_recalc_rate,
+};
+
+static struct clk *sro_refresh_test_clk_create(struct kunit *test,
+					       unsigned long rate)
+{
+	struct clk_init_data init = {
+		.name = "sro-refresh-test-clk",
+		.ops = &sro_refresh_test_clk_ops,
+	};
+	struct sro_refresh_test_clk *tclk;
+	struct clk *clk;
+	int ret;
+
+	tclk = kunit_kzalloc(test, sizeof(*tclk), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, tclk);
+
+	tclk->rate = rate;
+	tclk->hw.init = &init;
+
+	ret = clk_hw_register_kunit(test, NULL, &tclk->hw);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	clk = clk_hw_get_clk_kunit(test, &tclk->hw, NULL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, clk);
+
+	return clk;
+}
+
+struct sro_refresh_test_priv {
+	struct drm_device drm;
+};
+
+static struct drm_device *sro_refresh_test_drm_create(struct kunit *test)
+{
+	struct sro_refresh_test_priv *priv;
+	struct device *dev;
+
+	dev = drm_kunit_helper_alloc_device(test);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dev);
+
+	priv = drm_kunit_helper_alloc_drm_device(test, dev,
+						 struct sro_refresh_test_priv,
+						 drm, DRIVER_MODESET);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, priv);
+
+	return &priv->drm;
+}
+
+/* Value of the pixel clock the helpers must leave untouched on failure */
+#define SRO_REFRESH_TEST_UNSET	-1UL
+
+/* Use drm_atomic_helper_sro_find_refresh_from_clk() and its tolerance */
+#define SRO_REFRESH_TEST_DEFAULT_TOLERANCE	-1
+
+struct sro_refresh_test_case {
+	const char *desc;
+	unsigned int htotal;
+	unsigned int vtotal;
+	unsigned long clk_rate;
+	int tolerance;
+	unsigned int refresh;
+	unsigned long pixel_clock;
+};
+
+/*
+ * The tolerance of the default helper is 5 per mille, so the bounds are
+ * 99.5% and 100.5% of the pixel clock of the standard mode. The
+ * 1920x1080 mode, 2200x1125 once blanking is included, runs at
+ * 148.5 MHz at 60 Hz, and 74.175824 MHz at 29.97 Hz.
+ */
+static const struct sro_refresh_test_case sro_refresh_test_cases[] = {
+	{
+		.desc = "1080p60",
+		.htotal = 2200, .vtotal = 1125, .clk_rate = 148500000,
+		.tolerance = SRO_REFRESH_TEST_DEFAULT_TOLERANCE,
+		.refresh = 60, .pixel_clock = 148500000,
+	},
+	{
+		.desc = "1080p59.94",
+		.htotal = 2200, .vtotal = 1125, .clk_rate = 148351648,
+		.tolerance = SRO_REFRESH_TEST_DEFAULT_TOLERANCE,
+		.refresh = 60, .pixel_clock = 148351648,
+	},
+	{
+		.desc = "1080p50",
+		.htotal = 2640, .vtotal = 1125, .clk_rate = 148500000,
+		.tolerance = SRO_REFRESH_TEST_DEFAULT_TOLERANCE,
+		.refresh = 50, .pixel_clock = 148500000,
+	},
+	{
+		.desc = "1080p30",
+		.htotal = 2200, .vtotal = 1125, .clk_rate = 74250000,
+		.tolerance = SRO_REFRESH_TEST_DEFAULT_TOLERANCE,
+		.refresh = 30, .pixel_clock = 74250000,
+	},
+	{
+		.desc = "1080p29.97",
+		.htotal = 2200, .vtotal = 1125, .clk_rate = 74175824,
+		.tolerance = SRO_REFRESH_TEST_DEFAULT_TOLERANCE,
+		.refresh = 30, .pixel_clock = 74175824,
+	},
+	{
+		.desc = "720p50",
+		.htotal = 1980, .vtotal = 750, .clk_rate = 74250000,
+		.tolerance = SRO_REFRESH_TEST_DEFAULT_TOLERANCE,
+		.refresh = 50, .pixel_clock = 74250000,
+	},
+	{
+		.desc = "VGA at 25.175 MHz reports the 59.94 Hz pixel clock",
+		.htotal = 800, .vtotal = 525, .clk_rate = 25175000,
+		.tolerance = SRO_REFRESH_TEST_DEFAULT_TOLERANCE,
+		.refresh = 60, .pixel_clock = 25174825,
+	},
+	{
+		.desc = "clock 0.4% above the standard rate",
+		.htotal = 2200, .vtotal = 1125, .clk_rate = 149094000,
+		.tolerance = SRO_REFRESH_TEST_DEFAULT_TOLERANCE,
+		.refresh = 60, .pixel_clock = 148500000,
+	},
+	{
+		.desc = "clock on the upper bound",
+		.htotal = 2200, .vtotal = 1125, .clk_rate = 149242500,
+		.tolerance = SRO_REFRESH_TEST_DEFAULT_TOLERANCE,
+		.refresh = 60, .pixel_clock = 148500000,
+	},
+	{
+		.desc = "clock above the upper bound",
+		.htotal = 2200, .vtotal = 1125, .clk_rate = 149242501,
+		.tolerance = SRO_REFRESH_TEST_DEFAULT_TOLERANCE,
+		.refresh = 0, .pixel_clock = SRO_REFRESH_TEST_UNSET,
+	},
+	{
+		.desc = "clock on the lower bound",
+		.htotal = 2200, .vtotal = 1125, .clk_rate = 73804944,
+		.tolerance = SRO_REFRESH_TEST_DEFAULT_TOLERANCE,
+		.refresh = 30, .pixel_clock = 74175824,
+	},
+	{
+		.desc = "clock below the lower bound",
+		.htotal = 2200, .vtotal = 1125, .clk_rate = 73804943,
+		.tolerance = SRO_REFRESH_TEST_DEFAULT_TOLERANCE,
+		.refresh = 0, .pixel_clock = SRO_REFRESH_TEST_UNSET,
+	},
+	{
+		.desc = "clock 0.6% above the standard rate",
+		.htotal = 2200, .vtotal = 1125, .clk_rate = 149391000,
+		.tolerance = SRO_REFRESH_TEST_DEFAULT_TOLERANCE,
+		.refresh = 0, .pixel_clock = SRO_REFRESH_TEST_UNSET,
+	},
+	{
+		.desc = "clock 0.6% above the standard rate, 1% tolerance",
+		.htotal = 2200, .vtotal = 1125, .clk_rate = 149391000,
+		.tolerance = 10,
+		.refresh = 60, .pixel_clock = 148500000,
+	},
+	{
+		.desc = "exact clock, no tolerance",
+		.htotal = 2200, .vtotal = 1125, .clk_rate = 148500000,
+		.tolerance = 0,
+		.refresh = 60, .pixel_clock = 148500000,
+	},
+	{
+		.desc = "clock 1 Hz off, no tolerance",
+		.htotal = 2200, .vtotal = 1125, .clk_rate = 148500001,
+		.tolerance = 0,
+		.refresh = 0, .pixel_clock = SRO_REFRESH_TEST_UNSET,
+	},
+	{
+		.desc = "clock matching no standard rate",
+		.htotal = 2200, .vtotal = 1125, .clk_rate = 100000000,
+		.tolerance = SRO_REFRESH_TEST_DEFAULT_TOLERANCE,
+		.refresh = 0, .pixel_clock = SRO_REFRESH_TEST_UNSET,
+	},
+	{
+		.desc = "stopped clock",
+		.htotal = 2200, .vtotal = 1125, .clk_rate = 0,
+		.tolerance = SRO_REFRESH_TEST_DEFAULT_TOLERANCE,
+		.refresh = 0, .pixel_clock = SRO_REFRESH_TEST_UNSET,
+	},
+};
+
+static void sro_refresh_test_desc(const struct sro_refresh_test_case *c,
+				  char *desc)
+{
+	strscpy(desc, c->desc, KUNIT_PARAM_DESC_SIZE);
+}
+
+KUNIT_ARRAY_PARAM(sro_refresh, sro_refresh_test_cases, sro_refresh_test_desc);
+
+/*
+ * Test that drm_atomic_helper_sro_find_refresh_from_clk() and its
+ * tolerance variant return the nominal refresh rate, 30, 50 or 60 Hz,
+ * and the pixel clock rate of the standard mode, whose pixel clock is
+ * the closest to the rate of the clock, as long as it is within the
+ * tolerance, boundaries included. Otherwise, they return 0 and leave
+ * the pixel clock rate untouched.
+ */
+static void drm_test_sro_refresh_from_clk(struct kunit *test)
+{
+	const struct sro_refresh_test_case *c = test->param_value;
+	unsigned long pixel_clock = SRO_REFRESH_TEST_UNSET;
+	struct drm_device *drm;
+	unsigned int refresh;
+	struct clk *clk;
+
+	drm = sro_refresh_test_drm_create(test);
+	clk = sro_refresh_test_clk_create(test, c->clk_rate);
+
+	if (c->tolerance == SRO_REFRESH_TEST_DEFAULT_TOLERANCE)
+		refresh = drm_atomic_helper_sro_find_refresh_from_clk(drm, clk,
+								      c->htotal,
+								      c->vtotal,
+								      &pixel_clock);
+	else
+		refresh = drm_atomic_helper_sro_find_refresh_from_clk_with_tolerance(drm,
+										     clk,
+										     c->htotal,
+										     c->vtotal,
+										     c->tolerance,
+										     &pixel_clock);
+
+	KUNIT_EXPECT_EQ(test, refresh, c->refresh);
+	KUNIT_EXPECT_EQ(test, pixel_clock, c->pixel_clock);
+}
+
+/*
+ * Test that drm_atomic_helper_sro_find_refresh_from_clk() accepts a
+ * NULL pixel clock pointer, for the callers that only need the refresh
+ * rate.
+ */
+static void drm_test_sro_refresh_from_clk_no_pixel_clock(struct kunit *test)
+{
+	struct drm_device *drm;
+	unsigned int refresh;
+	struct clk *clk;
+
+	drm = sro_refresh_test_drm_create(test);
+	clk = sro_refresh_test_clk_create(test, 148500000);
+
+	refresh = drm_atomic_helper_sro_find_refresh_from_clk(drm, clk, 2200,
+							      1125, NULL);
+	KUNIT_EXPECT_EQ(test, refresh, 60);
+}
+
+/*
+ * Test that drm_atomic_helper_sro_find_refresh_from_clk_with_tolerance()
+ * rejects a tolerance of 1000 per mille or more, since it would accept
+ * any rate, and returns 0 without touching the pixel clock rate.
+ */
+static void drm_test_sro_refresh_from_clk_invalid_tolerance(struct kunit *test)
+{
+	unsigned long pixel_clock = SRO_REFRESH_TEST_UNSET;
+	struct drm_device *drm;
+	unsigned int refresh;
+	struct clk *clk;
+
+	drm = sro_refresh_test_drm_create(test);
+	clk = sro_refresh_test_clk_create(test, 148500000);
+
+	refresh = drm_atomic_helper_sro_find_refresh_from_clk_with_tolerance(drm,
+									     clk,
+									     2200,
+									     1125,
+									     1000,
+									     &pixel_clock);
+	KUNIT_EXPECT_EQ(test, refresh, 0);
+	KUNIT_EXPECT_EQ(test, pixel_clock, SRO_REFRESH_TEST_UNSET);
+}
+
+static struct kunit_case drm_atomic_sro_refresh_tests[] = {
+	KUNIT_CASE_PARAM(drm_test_sro_refresh_from_clk, sro_refresh_gen_params),
+	KUNIT_CASE(drm_test_sro_refresh_from_clk_no_pixel_clock),
+	KUNIT_CASE(drm_test_sro_refresh_from_clk_invalid_tolerance),
+	{}
+};
+
+static struct kunit_suite drm_atomic_sro_refresh_test_suite = {
+	.name = "drm_atomic_sro_refresh",
+	.test_cases = drm_atomic_sro_refresh_tests,
+};
+
+kunit_test_suite(drm_atomic_sro_refresh_test_suite);
+
+MODULE_AUTHOR("Maxime Ripard <mripard@kernel.org>");
+MODULE_DESCRIPTION("Kunit test for the DRM atomic state readout refresh rate helpers");
+MODULE_LICENSE("GPL");
diff --git a/include/drm/drm_atomic_state_readout_helper.h b/include/drm/drm_atomic_state_readout_helper.h
index 882866e1cb04..05a444dc8224 100644
--- a/include/drm/drm_atomic_state_readout_helper.h
+++ b/include/drm/drm_atomic_state_readout_helper.h
@@ -3,10 +3,11 @@
 #ifndef DRM_ATOMIC_SRO_HELPER_H_
 #define DRM_ATOMIC_SRO_HELPER_H_
 
 #include <linux/string_choices.h>
 
+struct clk;
 struct drm_atomic_commit;
 struct drm_atomic_sro_state;
 struct drm_bridge;
 struct drm_bridge_state;
 struct drm_connector;
@@ -21,10 +22,24 @@ struct drm_printer;
 
 struct drm_gem_dma_object *
 drm_atomic_helper_sro_create_gem_dma_object(struct drm_device *dev,
 					    dma_addr_t dma_addr, size_t size);
 
+unsigned int
+drm_atomic_helper_sro_find_refresh_from_clk_with_tolerance(struct drm_device *dev,
+							   struct clk *clk,
+							   unsigned int htotal,
+							   unsigned int vtotal,
+							   unsigned int tolerance,
+							   unsigned long *pixel_clock_hz);
+unsigned int
+drm_atomic_helper_sro_find_refresh_from_clk(struct drm_device *dev,
+					    struct clk *clk,
+					    unsigned int htotal,
+					    unsigned int vtotal,
+					    unsigned long *pixel_clock_hz);
+
 int
 drm_atomic_helper_sro_readout_planes_state(struct drm_device *dev,
 					   struct drm_atomic_sro_state *state,
 					   struct drm_atomic_commit *commit);
 int

-- 
2.56.1

