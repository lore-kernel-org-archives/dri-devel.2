Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A4D606D80A
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 17:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=d/V3a4lj
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7AEC810F729;
	Tue,  3 Nov 2026 17:21:14 +0000 (UTC)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 646FA10F72D
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 17:21:08 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-4a35db1f202so46321955e9.3
 for <dri-devel@lists.freedesktop.org>; Tue, 03 Nov 2026 09:21:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793726467; x=1794331267; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HfoDPTXioBc1cw45nHPpU8QQl7Ua5gtA7+x/5ww4cF0=;
 b=d/V3a4ljNpySNRZq6KuBAjaBQJLZyulNAaPhyLLknOgTbzhuQ4Zv6hc1bBxHbnqcQR
 XBbfj67PG7kCUoUtcqWX2eMMajU5iPXaRfrXIfsR4Q4VCa7Otw+h03zaHTuA1bWh7cZT
 iUfKJvdAEk9uzJs3YuLELoytSQoiqdslRiBKuXSwBnHLwPVtQgE6TdPc10u98NrnB6SQ
 +lH2mjs1VPxcpqb7UqIQnSwEcV07l/PXPOaFgqM2pXjy0nCuISgCRZxL3vf8gwvHhJQB
 v15RKbfollZzuRx7rcjQFe89UCuoWP6PMVvErFPg8KI7HpxK2lqkX/JoIzSsBH9iidEu
 qVSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793726467; x=1794331267;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=HfoDPTXioBc1cw45nHPpU8QQl7Ua5gtA7+x/5ww4cF0=;
 b=Z4ki36d5cD7C36xPQeOD4IgAxjyWlotOxSbY6bB6UZ78lPT0KUxWDJhtqiR6uYMXs/
 XjFgvNO0h4hAZwed8n/21FNW6OC66o2OPlKauGeyRxCZjFZl0RJEinJ6RD+NJ4/zPnwe
 pCOj5gwQgUW7CrGBAByL5d+Bxo/IKL9Dl6OEujJViMW0sYtUJfNxQav6SeAi9/okDCtr
 RFYvJLHCdOumEpVfcB9K6Cf7+Lim7n2b462W/pbL25vXeRZ1GWTmJpn/a1whh7f8bVSM
 Jj/VIOoOPLi6brO7Kz/N96H3X8R3zyLnxLaT1XkJr8LsYf+d5Mrj0D11RgeOJfFpa2Ds
 1z9Q==
X-Forwarded-Encrypted: i=1;
 AKwUvByx0v0LuL+GtGfFpZSJIrKrpBzRZkyE29DI5XUdF01RtLoe6kHkopLMU/pOqd68FBUrFRUfdTseG+g=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+L1Q4vYir4fkFRgzZlyM4u1rmBqxS2YEsOb0OMSyDhDIHFobra
 AZhAOdwGV6Efc9NP9Ml31GTkdIQRGLsd3XtA/uc/WB8u8NdkMdojDO6S
X-Gm-Gg: AYBFou3judF0Hj8a2EaUDo5PfRws2+xWxVK9ox9T1zaTHvKfqniRp/OQYVJlCs8mzpw
 QZYAFD81o7sT2urg/HZKIYs9b5WuEaIMIRHWeGiX3r7RUjplMEPF+sztAGt748Jcw1vEVKLnCXB
 sd0OrSUDK+/be6O3k2KTK0UngZ8kX0wdL/yyR1Sg3boj+8rOHHMrbYboZK8kvw5qP4/LufHytxm
 Q7Gz6Q46XroQN4A5xWtIDu4v6BpUBFITdYkCj0+ziwd3bZD5pxJttje0nciqX9VdZbudrwn3OuY
 X7p/A2qAjywwlNfNG6zhpYcxfODQVfffiBijT6+9XPGkfYLrmRicQiM9VM+8gNXJNinheKE/vAS
 5nbcmDep2rw1tnlTc2aSZZm7FkR/XPj+nmgRLut0oIVTcD4W7jzIFPSZld1KkPCWqarOdk0QU+n
 X9ufycrDrhKpwS8EntFPVPLJ0obEoFtY109bEMIPkBd7p7z7OlfRxtSmP/Vr/WD2iFpxBSx+pXM
 g3K0QTqQaLLEFK8f2UCnrUth/imElaoi8nsfnJ60/rYEcs8W+hInWY6YWTdeiV9h6UcBgTrpGc2
 RjXb3pX5d1aPZzNh9W8TMJJ9P16YCe1ZOoMDC+SI+1ds/t1xAN+XTMkddXjcopw8Am4no7nQdQf
 dM1EgcZhxUJ/Xp+vkYucZdznXaUMtWZZVJyKMn6w=
X-Received: by 2002:a05:600c:5246:b0:4a1:d459:db4b with SMTP id
 5b1f17b1804b1-4ac1889c7bdmr316878005e9.24.1793726466560; 
 Tue, 03 Nov 2026 09:21:06 -0800 (PST)
Received: from iku.lan ([2a00:23c8:254f:fd01:8b77:19e1:26f7:89f2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ac08b72579sm8800675e9.2.2026.11.03.09.21.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 09:21:06 -0800 (PST)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>,
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>,
 Jerome Brunet <jbrunet+clk@baylibre.com>,
 Biju Das <biju.das.jz@bp.renesas.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Prabhakar <prabhakar.csengg+renesas@gmail.com>,
 Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Subject: [PATCH 1/4] clk: renesas: rzv2h-cpg: Allow MIPI DSI to reuse PLL
 divider parameters
Date: Tue,  3 Nov 2026 17:20:54 +0000
Message-ID: <20261103172057.617203-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261103172057.617203-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20261103172057.617203-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

The CPG PLLDSI output feeds the PLLDSI inside the MIPI DSI block, so
the divider parameters selected by the CPG must also satisfy the DSI
PLL constraints. The DSI driver checks both sets of constraints during
mode validation, but the CPG's .determine_rate() callback performs its
own search and can select a different combination.

Allow the DSI driver to cache the selected divider parameters per DSI
PLL instance and reuse them in .determine_rate() when the requested
rate matches the cached frequency, including its error. Protect the
shared cache with a spinlock to avoid races between mode validation
and rate determination.

Move the maximum number of DSI PLL instances to the public header so
the CPG driver and library share the same limit.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/clk/renesas/rzv2h-cpg-lib.c | 48 +++++++++++++++++++++++++++++
 drivers/clk/renesas/rzv2h-cpg.c     | 15 ++++++---
 include/linux/clk/renesas.h         | 16 ++++++++++
 3 files changed, 75 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/renesas/rzv2h-cpg-lib.c b/drivers/clk/renesas/rzv2h-cpg-lib.c
index 124239c7327e..4b59bf60edb0 100644
--- a/drivers/clk/renesas/rzv2h-cpg-lib.c
+++ b/drivers/clk/renesas/rzv2h-cpg-lib.c
@@ -7,12 +7,60 @@
  *
  */
 
+#include <linux/bug.h>
+#include <linux/cleanup.h>
 #include <linux/clk/renesas.h>
 #include <linux/export.h>
 #include <linux/math.h>
+#include <linux/spinlock.h>
 #include <linux/types.h>
 #include <linux/units.h>
 
+/*
+ * Divider parameters handed over by the MIPI DSI driver, which evaluates both
+ * the CPG and the DSI PLL constraints before settling on a combination. They
+ * are indexed by DSI PLL instance, as the producer only knows the instance it
+ * targets, so they are shared by all CPG instances. The producer runs in the
+ * DSI mode validation path and the consumer in .determine_rate(), so the
+ * accesses are protected by a spinlock.
+ */
+static DEFINE_SPINLOCK(cache_pll_dsi_lock);
+static struct rzv2h_pll_div_pars cache_pll_dsi_pars[RZV2H_CPG_MAX_DSI_PLL];
+
+/**
+ * rzv2h_cpg_cache_pll_pars - Cache divider parameters for a PLLDSI instance
+ *
+ * @pars: PLL and divider parameters computed by the MIPI DSI driver
+ * @dsi_instance: PLLDSI instance the parameters are meant for
+ *
+ * Stores @pars so that the PLLDSI divider's .determine_rate() can use them
+ * instead of running its own search, when asked for the matching rate. The
+ * DSI driver needs this because the display clock is set before the DSI
+ * bridge is enabled, and the CPG alone does not know the DSI PLL constraints.
+ *
+ * A later call for the same @dsi_instance overwrites the previous entry.
+ * An out-of-range @dsi_instance is ignored with a warning.
+ */
+void rzv2h_cpg_cache_pll_pars(struct rzv2h_pll_div_pars pars,
+			      unsigned int dsi_instance)
+{
+	if (WARN_ON(dsi_instance >= RZV2H_CPG_MAX_DSI_PLL))
+		return;
+
+	guard(spinlock)(&cache_pll_dsi_lock);
+	cache_pll_dsi_pars[dsi_instance] = pars;
+}
+EXPORT_SYMBOL_NS_GPL(rzv2h_cpg_cache_pll_pars, "RZV2H_CPG");
+
+struct rzv2h_pll_div_pars rzv2h_cpg_get_cached_pll_pars(unsigned int dsi_instance)
+{
+	if (WARN_ON(dsi_instance >= RZV2H_CPG_MAX_DSI_PLL))
+		return (struct rzv2h_pll_div_pars){0};
+
+	guard(spinlock)(&cache_pll_dsi_lock);
+	return cache_pll_dsi_pars[dsi_instance];
+}
+
 /**
  * rzv2h_cpg_get_pll_pars - Finds the best combination of PLL parameters
  * for a given frequency.
diff --git a/drivers/clk/renesas/rzv2h-cpg.c b/drivers/clk/renesas/rzv2h-cpg.c
index 7ca2447fd811..e6f6a3fec449 100644
--- a/drivers/clk/renesas/rzv2h-cpg.c
+++ b/drivers/clk/renesas/rzv2h-cpg.c
@@ -12,6 +12,7 @@
  */
 
 #include <linux/bitfield.h>
+#include <linux/bug.h>
 #include <linux/clk.h>
 #include <linux/clk-provider.h>
 #include <linux/clk/renesas.h>
@@ -72,9 +73,6 @@
 
 #define CPG_CLKSTATUS0		(0x700)
 
-/* On RZ/G3E SoC we have two DSI PLLs */
-#define MAX_CPG_DSI_PLL		2
-
 /**
  * struct rzv2h_pll_dsi_info - PLL DSI information, holds the limits and parameters
  *
@@ -123,7 +121,7 @@ struct rzv2h_cpg_priv {
 
 	struct reset_controller_dev rcdev;
 
-	struct rzv2h_pll_dsi_info pll_dsi_info[MAX_CPG_DSI_PLL];
+	struct rzv2h_pll_dsi_info pll_dsi_info[RZV2H_CPG_MAX_DSI_PLL];
 };
 
 #define rcdev_to_priv(x)	container_of(x, struct rzv2h_cpg_priv, rcdev)
@@ -235,6 +233,7 @@ static int rzv2h_cpg_plldsi_div_determine_rate(struct clk_hw *hw,
 {
 	struct rzv2h_plldsi_div_clk *dsi_div = to_plldsi_div_clk(hw);
 	struct pll_clk *pll_clk = to_pll(clk_hw_get_parent(hw));
+	struct rzv2h_pll_div_pars cached_dsi_parameters;
 	struct rzv2h_cpg_priv *priv = dsi_div->priv;
 	u8 table[RZV2H_MAX_DIV_TABLES] = { 0 };
 	struct rzv2h_pll_div_pars *dsi_params;
@@ -247,6 +246,14 @@ static int rzv2h_cpg_plldsi_div_determine_rate(struct clk_hw *hw,
 	dsi_params = &dsi_info->pll_dsi_parameters;
 
 	rate_millihz = mul_u32_u32(req->rate, MILLI);
+
+	cached_dsi_parameters = rzv2h_cpg_get_cached_pll_pars(pll_clk->pll.instance);
+	if (rate_millihz == cached_dsi_parameters.div.error_millihz +
+			    cached_dsi_parameters.div.freq_millihz) {
+		*dsi_params = cached_dsi_parameters;
+		goto exit_determine_rate;
+	}
+
 	if (rate_millihz == dsi_params->div.error_millihz + dsi_params->div.freq_millihz)
 		goto exit_determine_rate;
 
diff --git a/include/linux/clk/renesas.h b/include/linux/clk/renesas.h
index c9495558cd5c..c1582ed9bf69 100644
--- a/include/linux/clk/renesas.h
+++ b/include/linux/clk/renesas.h
@@ -159,6 +159,9 @@ struct rzv2h_pll_div_pars {
 	} div;
 };
 
+/* On RZ/G3E SoC we have two DSI PLLs */
+#define RZV2H_CPG_MAX_DSI_PLL		2
+
 #define RZV2H_CPG_PLL_DSI_LIMITS(name)					\
 	static const struct rzv2h_pll_limits (name) = {			\
 		.fout = { .min = 25 * MEGA, .max = 375 * MEGA },	\
@@ -196,6 +199,9 @@ bool rzv2h_cpg_get_pll_pars(const struct rzv2h_pll_limits *limits,
 bool rzv2h_cpg_get_pll_divs_pars(const struct rzv2h_pll_limits *limits,
 				 struct rzv2h_pll_div_pars *pars,
 				 const u8 *table, u8 table_size, u64 freq_millihz);
+void rzv2h_cpg_cache_pll_pars(struct rzv2h_pll_div_pars pars,
+			      unsigned int dsi_instance);
+struct rzv2h_pll_div_pars rzv2h_cpg_get_cached_pll_pars(unsigned int dsi_instance);
 #else
 static inline bool rzv2h_cpg_get_pll_pars(const struct rzv2h_pll_limits *limits,
 					  struct rzv2h_pll_pars *pars,
@@ -211,6 +217,16 @@ static inline bool rzv2h_cpg_get_pll_divs_pars(const struct rzv2h_pll_limits *li
 {
 	return false;
 }
+
+static inline void rzv2h_cpg_cache_pll_pars(struct rzv2h_pll_div_pars pars,
+					    unsigned int dsi_instance)
+{
+}
+
+static inline struct rzv2h_pll_div_pars rzv2h_cpg_get_cached_pll_pars(unsigned int dsi_instance)
+{
+	return (struct rzv2h_pll_div_pars){0};
+}
 #endif
 
 #define rzv2h_get_pll_pars	rzv2h_cpg_get_pll_pars
-- 
2.56.0

