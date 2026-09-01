Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84C42C624DD
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 07:33:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6DD6F10E96D;
	Thu,  3 Sep 2026 07:33:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=metarealtyinc-ca.20251104.gappssmtp.com header.i=@metarealtyinc-ca.20251104.gappssmtp.com header.b="jCZmRtUK";
	dkim-atps=neutral
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com
 [209.85.222.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DAB1110EF2B
 for <dri-devel@lists.freedesktop.org>; Tue,  1 Sep 2026 21:00:00 +0000 (UTC)
Received: by mail-qk1-f173.google.com with SMTP id
 af79cd13be357-9391252b5caso29328885a.3
 for <dri-devel@lists.freedesktop.org>; Tue, 01 Sep 2026 14:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=metarealtyinc-ca.20251104.gappssmtp.com; s=20251104; t=1788296400;
 x=1788901200; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YZD8NsGTxScfsyqxwjhq65/CKhM7Tjjz26PTc7lYLxg=;
 b=jCZmRtUKFTL00dPJ0x0K/ivKTaafbAkRiyAkKBpOftRV0ehXO/xAGVeTuxha75F2V7
 rdsA1IJrkMxDMNnabF6nI5bbB51eaeosCWyfhvpzwXBVifwNK/T9HRhfQk2BdEda/LJk
 smj6TP+TUxb05EjzKXBOHaOPVOUPJFUe8Vgv3F+IAgqzyUijI15qrK3Kx+Jz4eX+6WVI
 ETvOco4RnPVEAycL2EqyJaA2z4jVji2nmSqoEyVib62TRkfaqS96WQWCc2DEg1a0hZxo
 d/NO+kMj6yp2HzXKl5IYrHO3vUDnIFp4lx0XwxbM3xvWAUgG2Ra/tTTIZr3HRIKhY9Gw
 zn1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788296400; x=1788901200;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=YZD8NsGTxScfsyqxwjhq65/CKhM7Tjjz26PTc7lYLxg=;
 b=MNLMCt86G9cDBYEBkfI21xqw3OEZhKHNvCdCGbMDgDl8mLgogMNAH2L0CHMIj5UZQh
 Tmbxg0Rlkx7OK9oVGZrBhaFjThCtFQo3PKivn3ofIkpKRbiEoJg+zomqiGDx45wNPsUJ
 vrMtnvYXWabInCaBrc3uTqNXKbt9sHap/oMYPzFzW2EyNd54t4qX/Ai9q+yDRAzS6yQC
 R2Os6UuTarW1tMw3YyVEIacQy9obbSwggGFl2ku0axAM7LGMp3VPl+aSql6/60sRcFAF
 ABr57brNbV9WNd49GT9hvyjU+W00ArfoY8EoOQG/PQK1SmK2sqhSTdkPDk646WNm4sii
 EdaA==
X-Forwarded-Encrypted: i=1;
 AHgh+RpSLNj/gHDKEo6LqeoMtZ3Q3POEiAOqifXkbZ2kUOkfsm4do26T2Wp/rJx0XpoMsirmpYgi7T3iP0A=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lTMyEIld0UZekugAD3ql++z0ULIKlqpaSKg9autDnk8Ny8KESy
 0tlzdui6676CxxsvaW8Ts8jq/ano/8rODwkFfOlX86TLT2mf18kVZlF5E83Q8wv5Nu0=
X-Gm-Gg: AR+sD12PL6JHeIxOEp0BXBzb9IH0HPFDyGU5t3C5+vutz6A+MOkc2K6OFyuBC33IriM
 Z3TQLoHs0XhCQQniFMHQdN6PALzA1JYnvDUz7g+G0LExA7IiFNrkUggXRE1r9uZUG9IO/MML1DR
 Jg2naf0gH/b8gB3WQeg16b3d8VKY0EzAXXrqB7X9giohskU5lPQ5J5ruSWozTHv2wius+GdGiZS
 1OF+lwrs1lVk62Qzh/uVA6I4qic5c9Lb3x89jInvhZ6zjHjAxgvWUXSDRfV5+D0khHX+jL/apqj
 BCQGTF1SCKUPOPfqNShwj5E+0127uBix0WqqAgJrCWn8M4pmdLVaud+rqEFH8XivrJFbVaLE1gi
 6q0Pr8m9Ix4xHZd9nxcl7tmeLue562gUN5eF90/+KgUIw2pYlNLDMeKXOAAoL992cg6BEkyjL4h
 AMxLDTrMfdT+fRSC7zc8Cv0TbUEtP4G7BFgyeJS5YyPIMmf81hlCezMLmCbNMydUDjztsBpL4eK
 wTZTF7EDkQWXTHSfJEXDhv4jReGzvyBtFOcThGLsuveJ6m65KSkBAzDnpWdcjnYuXp0sM9tCZ67
 ezzsUiIZ1+MPwzMHo7PeetEUi+y2Sm2dSdhlU6EKJ2eLZye5A3i9Na2W7IqbPhwcsE5L
X-Received: by 2002:a05:620a:72c3:10b0:92e:bc28:5479 with SMTP id
 af79cd13be357-93960cafc51mr14525185a.2.1788296399612; 
 Tue, 01 Sep 2026 13:59:59 -0700 (PDT)
Received: from jake-laptop ([153.67.1.208]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9395f1aba80sm33533585a.20.2026.09.01.13.59.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 13:59:58 -0700 (PDT)
From: Jake Steinman <j@metarealtyinc.ca>
To: jani.nikula@linux.intel.com,
	rodrigo.vivi@intel.com
Cc: jouni.hogander@intel.com, mika.kahola@intel.com,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] drm/i915/psr: clear the Panel Replay error status register
Date: Tue,  1 Sep 2026 16:59:56 -0400
Message-ID: <20260901205956.130779-1-j@metarealtyinc.ca>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260901203633.92628-1-j@metarealtyinc.ca>
References: <20260901203633.92628-1-j@metarealtyinc.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 03 Sep 2026 07:33:13 +0000
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

psr_get_status_and_error_status() selects the DPCD offset to read the error
status from based on whether Panel Replay is enabled:

	offset = intel_dp->psr.panel_replay_enabled ?
		 DP_PANEL_REPLAY_ERROR_STATUS : DP_PSR_ERROR_STATUS;

but intel_psr_short_pulse() acknowledges it unconditionally to the PSR
register. Under Panel Replay the error is therefore read from
DP_PANEL_REPLAY_ERROR_STATUS (0x2020) and the acknowledgement written to
DP_PSR_ERROR_STATUS (0x2006). DP_PANEL_REPLAY_ERROR_STATUS is never written
anywhere in the tree; it appears only in the read above and in its own #define.

The sink's Panel Replay error latch can consequently never be cleared. Once it
latches, every subsequent short pulse re-reads the same errors, so PSR is
disabled with sink_not_reliable set permanently, and until a short pulse
arrives the driver keeps Panel Replay enabled while the sink is reporting
errors it cannot see.

Observed on a Dell XPS 16 DA16260 (Panther Lake, Arc B390, display version
30.00) with the eDP Panel Replay quirk from commit cb8d155b0806 removed
locally so the feature could be exercised. The sink reports a persistently
latched error:

	Sink PANEL-REPLAY status: 0x2 [active, display from RFB]
	Sink PANEL-REPLAY error status: 0x1:
		PANEL-REPLAY Link CRC error

which survives across reads indefinitely, while dmesg stays silent and Panel
Replay Selective Update remains enabled.

Use the same conditional offset when clearing. psr->panel_replay_enabled
cannot be used at that point because intel_psr_disable_locked() clears it
earlier in the same function whenever an error was detected, which is exactly
the case that needs the Panel Replay offset, so save it beforehand.

v2: use a copy of panel_replay_enabled taken before
    intel_psr_disable_locked() clears it. In v1 the condition was evaluated
    after the disable, so it selected DP_PSR_ERROR_STATUS in the error path
    and the patch was a no-op there. Caught by Sashiko AI review.

Signed-off-by: Jake Steinman <j@metarealtyinc.ca>
---
 drivers/gpu/drm/i915/display/intel_psr.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

--- a/drivers/gpu/drm/i915/display/intel_psr.c
+++ b/drivers/gpu/drm/i915/display/intel_psr.c
@@ -3840,6 +3840,7 @@
 	struct intel_display *display = to_intel_display(intel_dp);
 	struct intel_psr *psr = &intel_dp->psr;
 	u8 status, error_status;
+	bool panel_replay_enabled;
 	const u8 errors = DP_PSR_RFB_STORAGE_ERROR |
 			  DP_PSR_VSC_SDP_UNCORRECTABLE_ERROR |
 			  DP_PSR_LINK_CRC_ERROR;
@@ -3860,6 +3861,12 @@
 		goto exit;
 	}
 
+	/*
+	 * Save this before intel_psr_disable_locked() clears it; the error
+	 * status is acknowledged to a different DPCD address depending on it.
+	 */
+	panel_replay_enabled = psr->panel_replay_enabled;
+
 	if ((!psr->panel_replay_enabled && status == DP_PSR_SINK_INTERNAL_ERROR) ||
 	    (error_status & errors)) {
 		intel_psr_disable_locked(intel_dp);
@@ -3885,7 +3892,10 @@
 			"PSR_ERROR_STATUS unhandled errors %x\n",
 			error_status & ~errors);
 	/* clear status register */
-	drm_dp_dpcd_writeb(&intel_dp->aux, DP_PSR_ERROR_STATUS, error_status);
+	drm_dp_dpcd_writeb(&intel_dp->aux,
+			   panel_replay_enabled ?
+			   DP_PANEL_REPLAY_ERROR_STATUS : DP_PSR_ERROR_STATUS,
+			   error_status);
 
 	if (!psr->panel_replay_enabled) {
 		psr_alpm_check(intel_dp);
