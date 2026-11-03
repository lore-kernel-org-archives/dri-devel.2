Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBFE9606A329
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 17:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=s3yIy6kc
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D25AF10F735;
	Tue,  3 Nov 2026 17:21:21 +0000 (UTC)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B2DF10F734
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 17:21:09 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-4a207b02a2cso29926035e9.1
 for <dri-devel@lists.freedesktop.org>; Tue, 03 Nov 2026 09:21:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793726467; x=1794331267; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YRJWMzSGYlnaqtlrj8LCuixaQN8tH2t79cuf24+aN+Y=;
 b=s3yIy6kcuAst84eyimFHDfxGMCL8Mdq3dwGiUF6/paRJFu7L2jiocTMbNQ/ynhPe9O
 W/AaLbq2nRU5AweHrZsSDAFuwXg/uWx4rfprJM3HzpdrZtkaUmy04yDL0h/eeF8HMidc
 EFBU6zPvhhcYI4Bm1KfoapwKuM0G86gosslfpaa1YsPtv9sNs04TKyV2M/abCbngAP8u
 AcZpPElox3Nr+Q4IbX3gp6+mcYxWiS66Wh/4hd6UOD0PLh3y5twKXZZAr1Rr1W0VHR8S
 fNNk3lQyP9jOKlLeIupPOuUB42UwmpkMAKmvWhF5pJau1sCuqiyXtaN43DXfRXpu8MtO
 KN2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793726468; x=1794331268;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=YRJWMzSGYlnaqtlrj8LCuixaQN8tH2t79cuf24+aN+Y=;
 b=pQ9SPSqRuk0zZWzedi7Rx3rkEpoBWy6/kp2Fe5bb5s29Pk3DzdWe2Zsman4iqxJjjf
 JfKlgoOy6DxxHrZnDhAMBlf2WmX/LkdC2hBFcZ3GvBFEpweLBEangeq5JrKTq5bnoPOK
 9hl8KXFps6VvZyxTy84LkBHMffH8a9tlGGVQBDYjP3ZKWPA25W2PhgrRiqVmn9fO+VAy
 z/qqwEljZC/rAvOGYOqnc9HVJPsfLU6uSJKUqHGrKlnBp5/r2t3yu7QtTGi4TrJE1G5s
 X51XZj+e+UPQQDl1cKhY6IQTTKj/WFzvE5bY40Ps1VYrxnVxgU8+I7+F2ILZmm6pbYCM
 /h7w==
X-Forwarded-Encrypted: i=1;
 AKwUvBzA+HQywIzS0B7XEGh8vAGtfxDtMP91PLZQv6uYVLOSfjFzpmIeJP2kt+6dW2Hlx+aT2866E2F92Q0=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+Yn0Iywcg3Q43oadZ8BO3qfcnTcccCSpZ8GYn+pS2RCH+bMHup
 3eDV/dy1i3+3Ayq7WmCUdfaxufLqJFy+UcLOuU09rYyPNWFKzzmmpxNd
X-Gm-Gg: AYBFou2d3A+tFdj7/XXb/vpyBRcbIMX+GA9g99bddSO8oLSt0fj7A/qzczUEbASBU2x
 5ZqTFZGHNJrXNgJI5S7/G/h8IYNfmdn9WuB/brrlUtYW+YHMaKxUCPibcjpmx68Tf4R4DHtk9z+
 NZT2w2bmat91ob4n/rvcCwsKZJOXebfuWc4oQMtCFdve8Zdd6C01ZPUMXgpj3YkRveRr+YUx/Su
 5cjeD0hxd/ollDLzK4K6mUZRxdFOvqsXjGk5baPgAC9lcrH4pK9je0zzcji/d/FEbRcADbWEHHd
 cBRDy34oeUeOTq2HUt/PAayqXqsDB2vbllXnx/+Ekof3cblmA5cdVIyHz98o4H9vtS6pxlrDJqY
 u9SUyY6LkHqrHjP8YJ2lhFxz0XFBsnWVMDhCrsZuFoipk/eRQK6mCozZZc9rd8fd56lXnXp2RTy
 4mLWqV8fyQJHi2c0aDg50RaVPo3J+EGcr9E2nlVEq1W7tm63FodSYVa16nTy45pZ+t4R8VZEmUp
 AU7lezxA5nQDLTprKMGc68R8grm1WzI+lrB3FeiKPtSEDF1MnhdkeX6DzEo8ZbJKr+o9rnb/QBz
 SSVVPrBUoFjVy7w51RpBobecQXb8t+ozlDaoQVVDy/Z0FQij9GUjwkeGgnL0v4Iffit9hNdhfK6
 7Hh5MtepOHxKdGiKBoM9k63RI+R10CtDgYJDETLDfsRMarxqSAqak4OWeNnYssA==
X-Received: by 2002:a05:600c:871a:b0:4a7:d9b1:b684 with SMTP id
 5b1f17b1804b1-4ac14ec7947mr322064755e9.2.1793726467464; 
 Tue, 03 Nov 2026 09:21:07 -0800 (PST)
Received: from iku.lan ([2a00:23c8:254f:fd01:8b77:19e1:26f7:89f2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ac08b72579sm8800675e9.2.2026.11.03.09.21.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 09:21:07 -0800 (PST)
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
Subject: [PATCH 2/4] clk: renesas: rzv2h-cpg: Add validation hook to PLL
 parameter search
Date: Tue,  3 Nov 2026 17:20:55 +0000
Message-ID: <20261103172057.617203-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

rzv2h_get_pll_pars() returns the candidate with the smallest frequency
error, which can be unusable for callers whose constraints come from
downstream PLLs, such as the MIPI DSI driver.

Add rzv2h_cpg_get_pll_pars_validate(), which takes a callback and its
context. The callback is invoked for every candidate in search order and
the first one it accepts is returned, which is not necessarily the one
with the smallest error. Rejected candidates are never returned, so
false means none was accepted. rzv2h_get_pll_pars() becomes a wrapper
passing a NULL validator, so its behaviour is unchanged.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/clk/renesas/rzv2h-cpg-lib.c | 61 +++++++++++++++++++++++++----
 include/linux/clk/renesas.h         | 22 +++++++++++
 2 files changed, 75 insertions(+), 8 deletions(-)

diff --git a/drivers/clk/renesas/rzv2h-cpg-lib.c b/drivers/clk/renesas/rzv2h-cpg-lib.c
index 4b59bf60edb0..a49add2f2fc3 100644
--- a/drivers/clk/renesas/rzv2h-cpg-lib.c
+++ b/drivers/clk/renesas/rzv2h-cpg-lib.c
@@ -62,31 +62,47 @@ struct rzv2h_pll_div_pars rzv2h_cpg_get_cached_pll_pars(unsigned int dsi_instanc
 }
 
 /**
- * rzv2h_cpg_get_pll_pars - Finds the best combination of PLL parameters
- * for a given frequency.
+ * rzv2h_cpg_get_pll_pars_validate - Finds a combination of PLL parameters
+ * for a given frequency, optionally accepted by a validation callback.
  *
  * @limits: Pointer to the structure containing the limits for the PLL parameters
- * @pars: Pointer to the structure where the best calculated PLL parameters values
+ * @pars: Pointer to the structure where the calculated PLL parameters values
  * will be stored
  * @freq_millihz: Target output frequency in millihertz
+ * @validator: Pointer to a structure containing a validation callback and
+ * context, or NULL
  *
- * This function calculates the best set of PLL parameters (M, K, P, S) to achieve
+ * This function calculates a set of PLL parameters (M, K, P, S) to achieve
  * the desired frequency.
  * There is no direct formula to calculate the PLL parameters, as it's an open
  * system of equations, therefore this function uses an iterative approach to
- * determine the best solution. The best solution is one that minimizes the error
- * (desired frequency - actual frequency).
+ * determine the solution.
+ *
+ * When validator is NULL, the function searches for the solution that minimizes
+ * the error (desired frequency - actual frequency) and returns the best match.
+ *
+ * When validator is provided, the callback is invoked for every candidate in
+ * search order and the first one it accepts is returned, even if it is not the
+ * one with the smallest error. Candidates the callback rejects are never
+ * returned, so false is returned when none is accepted. This allows additional
+ * constraints beyond frequency matching to be satisfied (e.g., derived PLL
+ * parameters must also meet certain criteria). The callback runs once per
+ * candidate, so it must be cheap and must not sleep.
  *
  * Return: true if a valid set of parameters values is found, false otherwise.
  */
-bool rzv2h_cpg_get_pll_pars(const struct rzv2h_pll_limits *limits,
-			    struct rzv2h_pll_pars *pars, u64 freq_millihz)
+bool rzv2h_cpg_get_pll_pars_validate(const struct rzv2h_pll_limits *limits,
+				     struct rzv2h_pll_pars *pars, u64 freq_millihz,
+				     const struct rzv2h_pll_validator *validator)
 {
 	unsigned long input_fref = limits->input_fref ?: (24 * MEGA);
 	u64 fout_min_millihz = mul_u32_u32(limits->fout.min, MILLI);
 	u64 fout_max_millihz = mul_u32_u32(limits->fout.max, MILLI);
 	struct rzv2h_pll_pars p, best;
 
+	if (WARN_ON(validator && !validator->validate))
+		return false;
+
 	if (freq_millihz > fout_max_millihz ||
 	    freq_millihz < fout_min_millihz)
 		return false;
@@ -191,6 +207,15 @@ bool rzv2h_cpg_get_pll_pars(const struct rzv2h_pll_limits *limits,
 				p.error_millihz = freq_millihz - output;
 				p.freq_millihz = output;
 
+				/* Take the first set the caller accepts */
+				if (validator) {
+					if (validator->validate(&p, validator->context)) {
+						*pars = p;
+						return true;
+					}
+					continue;
+				}
+
 				/* If an exact match is found, return immediately */
 				if (p.error_millihz == 0) {
 					*pars = p;
@@ -211,6 +236,26 @@ bool rzv2h_cpg_get_pll_pars(const struct rzv2h_pll_limits *limits,
 	*pars = best;
 	return true;
 }
+EXPORT_SYMBOL_NS_GPL(rzv2h_cpg_get_pll_pars_validate, "RZV2H_CPG");
+
+/**
+ * rzv2h_cpg_get_pll_pars - Finds the best combination of PLL parameters
+ * for a given frequency.
+ *
+ * @limits: Pointer to the structure containing the limits for the PLL parameters
+ * @pars: Pointer to the structure where the best calculated PLL parameters values
+ * will be stored
+ * @freq_millihz: Target output frequency in millihertz
+ *
+ * See rzv2h_cpg_get_pll_pars_validate() for more details.
+ *
+ * Return: true if a valid set of parameters values is found, false otherwise.
+ */
+bool rzv2h_cpg_get_pll_pars(const struct rzv2h_pll_limits *limits,
+			    struct rzv2h_pll_pars *pars, u64 freq_millihz)
+{
+	return rzv2h_cpg_get_pll_pars_validate(limits, pars, freq_millihz, NULL);
+}
 EXPORT_SYMBOL_NS_GPL(rzv2h_cpg_get_pll_pars, "RZV2H_CPG");
 
 /*
diff --git a/include/linux/clk/renesas.h b/include/linux/clk/renesas.h
index c1582ed9bf69..c846d926020c 100644
--- a/include/linux/clk/renesas.h
+++ b/include/linux/clk/renesas.h
@@ -192,10 +192,25 @@ struct rzv2h_pll_div_pars {
 		.k = { .min = -32768, .max = 32767 },			\
 	}								\
 
+/**
+ * struct rzv2h_pll_validator - Callback structure for custom PLL parameter validation
+ *
+ * @validate: Validation function that checks if the computed PLL parameters are acceptable
+ * @context: Opaque pointer to any data needed by the validation function
+ */
+struct rzv2h_pll_validator {
+	bool (*validate)(const struct rzv2h_pll_pars *pars, void *context);
+	void *context;
+};
+
 #ifdef CONFIG_CLK_RZV2H_CPG_LIB
 bool rzv2h_cpg_get_pll_pars(const struct rzv2h_pll_limits *limits,
 			    struct rzv2h_pll_pars *pars, u64 freq_millihz);
 
+bool rzv2h_cpg_get_pll_pars_validate(const struct rzv2h_pll_limits *limits,
+				     struct rzv2h_pll_pars *pars, u64 freq_millihz,
+				     const struct rzv2h_pll_validator *validator);
+
 bool rzv2h_cpg_get_pll_divs_pars(const struct rzv2h_pll_limits *limits,
 				 struct rzv2h_pll_div_pars *pars,
 				 const u8 *table, u8 table_size, u64 freq_millihz);
@@ -210,6 +225,13 @@ static inline bool rzv2h_cpg_get_pll_pars(const struct rzv2h_pll_limits *limits,
 	return false;
 }
 
+static inline bool rzv2h_cpg_get_pll_pars_validate(const struct rzv2h_pll_limits *limits,
+						   struct rzv2h_pll_pars *pars, u64 freq_millihz,
+						   const struct rzv2h_pll_validator *validator)
+{
+	return false;
+}
+
 static inline bool rzv2h_cpg_get_pll_divs_pars(const struct rzv2h_pll_limits *limits,
 					       struct rzv2h_pll_div_pars *pars,
 					       const u8 *table, u8 table_size,
-- 
2.56.0

