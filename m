Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D41EC98328
	for <dri-devel@archiver.kernel.org>; Fri, 25 Sep 2026 07:31:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 496A410F90A;
	Fri, 25 Sep 2026 07:30:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FrTEqPjb";
	dkim-atps=neutral
Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com
 [74.125.225.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D452210F7AF
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 21:19:30 +0000 (UTC)
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49ce364488dso859585e9.0
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 14:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790284769; x=1790889569; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3b2nna4xnlk7YBC6uF1VaaYbEm9ppYIUbn/RXDv0QcY=;
 b=FrTEqPjblL1/z7NXBMMi29ZkNGTKIcpBeUe/VrJMpOMrbaUW3mmNTvPgkVMBBYy6yJ
 qiAr0+sd1ZGSWivH7m5aMJztJGHRZjwMBBb1pycPb4irzL9EaUqwB1qKgOdv11rKR2Sy
 R8/A6MN1l094otNpAmi+R58Wh1QxOHpg9wHItREqPB228GyNLv2XMsQsOotiBTGvZt7u
 EqA8dwCwdEcyfKGFdG5gXQFkJ5JUrWFAQjN/4uhBJI4UNCF057Qs8rExQt0j1iNbg4xM
 dbXjPYpNbm00tbO93S7mLEUjYLgDzbGzlmzMozBgqEGJlLMTexSNgqZ1ssGRwkwRqonq
 ZBoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790284769; x=1790889569;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=3b2nna4xnlk7YBC6uF1VaaYbEm9ppYIUbn/RXDv0QcY=;
 b=zIjFhcoTGzjIzjwKll5ASCk975R6qcI0CbNsRWEZFVuJt+ldQeetWGPIXgMC6mPiN7
 iOuRCTP9A+kfXPcYxZuGgUFsVeOCtrtmZmWmYSpIwxbv+GM1Gw88wqOlEjnBks03DHhr
 ElibOnKFDS0i1Jqh0Po1+XMSpj8ZnXd2gPOv+F3YkkMltrpkjen3aRiZShEbHOuLEVX+
 dV+vgpshCX6bYHSfS2UdD2TiV7SuwVum8xwHVs1hT9/3tI3g/3y2y7/gMNCviuB8uvgn
 7a7iEawwHUArbTyWHe8g9BWzoHM9HliWCmCX9R9+lBVtO/YRoArrWs+Tw3fHO04CQsub
 STRQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwcTf0EC+mpOvDcRDDBs8HhBhYmYbfwMN6xblSCACG30D+aryQ+NyynwLOl66HeMSpGZob4vXqOzmo=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mDAgWF3+BMo4oJg1te2rpYmiNh6QzaWbb90BNhk8LlE+fDmtk/
 DOkv9k0XvIES+9ORK/HM6lxiS9yVXlHxxAYOj88tnwYGamInx3oN1tgc
X-Gm-Gg: AYBFou1iriauFhP8cxTevbjEneoXffp1k8BL1UCCkyaCpPwbpdYZMtT3xH/qtoX3jJp
 1BcBSFBjrRr1yS/NAxgf/n3NKypsY8c2LbA1tl6X16WBMA1IJk7zyJbgaFEEUr+PvlnwrSJRJVJ
 Og7YoXaHoo81pp5zYvV4uwaPFRihH2OjD8ch/a1C5Lqu/ZH3dYegrVvRBVbn9u4IAW2mhCg5XBv
 IkJVWA/KLuGsz3EpuPNf3W7kPwTS2E9ErlhBLxM/JLV1RtkTMzBJkTVIV7pCDnwa+A//y44kpjz
 Vzn6XDUP4pl9vstJqqx/pN4SBZm2hidBbETE/sVvHXQiW12PrIhmc3xscbO0tZp+kjD2Xz1zj5b
 3qwWEGQtOtEgmoatfludm9UODqEgbw5yuAGyam35YXCnWJylNox32eND79j+zCA/ilYn7tg51+P
 9f4sijq44D+Iso62VM4Hfwgw4w9Uhed2D2lZz6aKJuFtuHlqnWjtNLZmLOYIjXvvXWZCguuF5be
 lk4UAumhI6TazV6zSxFuzGiAnvWCtiEWfzhESzw4BBioH5URJAW/4BOHnZb+8oLm2YL9oACLYST
 9B0+LGKSf3WldIXP4f/HpPUMMppWrHscg2LBFaewOppvRuc=
X-Received: by 2002:a05:600c:c096:b0:49f:f099:6f92 with SMTP id
 5b1f17b1804b1-49ff0997108mr2146345e9.9.1790284768860; 
 Thu, 24 Sep 2026 14:19:28 -0700 (PDT)
Received: from tulkas.localdomain (95f12971.skybroadband.com. [149.241.41.113])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fef5f876esm6403155e9.2.2026.09.24.14.19.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2026 14:19:28 -0700 (PDT)
From: Conor Svensson <conor10@gmail.com>
To: intel-gfx@lists.freedesktop.org
Cc: Conor Svensson <conor10@gmail.com>, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, jani.nikula@linux.intel.com,
 rodrigo.vivi@intel.com, joonas.lahtinen@linux.intel.com,
 tursulin@ursulin.net, airlied@gmail.com, simona@ffwll.ch,
 linux-kernel@vger.kernel.org
Subject: [PATCH] drm/i915/dp: Configure protocol converter only for TMDS
 outputs
Date: Thu, 24 Sep 2026 22:18:09 +0100
Message-ID: <20260924211852.436787-1-conor10@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <5893371ab206c97d5d2f1d72eb149d5ace4250e2@intel.com>
References: <5893371ab206c97d5d2f1d72eb149d5ace4250e2@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 25 Sep 2026 07:30:44 +0000
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

intel_dp_configure_protocol_converter() currently writes the HDMI/DVI
output-selection control for every DP 1.3+ branch. The write is only
meaningful for a TMDS downstream output; a native DisplayPort output should
not be switched to the HDMI/DVI protocol-converter mode.

An Anker 565 branch (Synaptics OUI 90:cc:24) changes its downstream port
descriptor from DisplayPort to DVI immediately after this write. i915 then
derives a 165 MHz TMDS limit on the next hotplug probe and drops the
monitor's native modes. Skipping the write for non-TMDS outputs prevents
the transition.

The existing dfp.min_tmds_clock classification is nonzero for HDMI/DVI
outputs and zero for native DisplayPort outputs, so retain the write for
the protocol-converter cases that need it. Colour-conversion controls are
unchanged.

Tested on a ThinkPad L14 Gen 4 with an Anker 565 A8388 hub and a Dell
S3422DWG:

- native 3440x1440@59.973 after DP recovery
- three USB-C reconnects on the first USB-C port
- one test on the second USB-C port
- suspend/resume on the second port
- HDMI through the hub at 3440x1440@59.973, with HDMI-specific modes
  present

On the unpatched control kernel, the live descriptor changed from
08 f0 01 1e 00 00 00 00 to 0a 42 00 00 00 00 00 00 across the 0x3050 write.

Link: https://gitlab.freedesktop.org/drm/i915/kernel/-/work_items/17180

Root-cause findings and validation details were added to the linked issue.

Assisted-by: LLM Codex GPT-6

Signed-off-by: Conor Svensson <conor10@gmail.com>
---
 drivers/gpu/drm/i915/display/intel_dp.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
index ffddf4b33..cdc3d7786 100644
--- a/drivers/gpu/drm/i915/display/intel_dp.c
+++ b/drivers/gpu/drm/i915/display/intel_dp.c
@@ -4422,14 +4422,17 @@ void intel_dp_configure_protocol_converter(struct intel_dp *intel_dp,
 	if (!drm_dp_is_branch(intel_dp->dpcd))
 		return;
 
-	tmp = intel_dp_has_hdmi_sink(intel_dp) ? DP_HDMI_DVI_OUTPUT_CONFIG : 0;
+	/* HDMI/DVI output selection only applies to TMDS downstream ports. */
+	if (intel_dp->dfp.min_tmds_clock) {
+		tmp = intel_dp_has_hdmi_sink(intel_dp) ? DP_HDMI_DVI_OUTPUT_CONFIG : 0;
 
-	ret = drm_dp_dpcd_write_byte(&intel_dp->aux,
-				     DP_PROTOCOL_CONVERTER_CONTROL_0, tmp);
-	if (ret < 0)
-		drm_dbg_kms(display->drm,
-			    "Failed to %s protocol converter HDMI mode\n",
-			    str_enable_disable(intel_dp_has_hdmi_sink(intel_dp)));
+		ret = drm_dp_dpcd_write_byte(&intel_dp->aux,
+					     DP_PROTOCOL_CONVERTER_CONTROL_0, tmp);
+		if (ret < 0)
+			drm_dbg_kms(display->drm,
+				    "Failed to %s protocol converter HDMI mode\n",
+				    str_enable_disable(intel_dp_has_hdmi_sink(intel_dp)));
+	}
 
 	if (crtc_state->sink_format == INTEL_OUTPUT_FORMAT_YCBCR420) {
 		switch (crtc_state->output_format) {

base-commit: 703cd271db3a35088460ab3fec0a96bd48e7fe04
-- 
2.55.0

