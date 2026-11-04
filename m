Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07749606A332
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 18:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FfOz0h8j
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5131E10E773;
	Wed,  4 Nov 2026 18:39:49 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F2A7610E773
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 18:39:42 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 27D8360609;
 Wed,  4 Nov 2026 18:39:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03F0A1F000C1;
 Wed,  4 Nov 2026 18:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793817581;
 bh=DvMLxBlki3uUbmQZYCI/NfK/V+8RiWix7z0CnkehUbs=;
 h=From:To:Cc:Subject:Date;
 b=FfOz0h8j7+c5jdDl0qlPLn+rjYEsk9YbPY12IrLApeLRDyhKKzxQUB2rOWoPur159
 FLvsw7SkILA1nxPAIFBTONB5wAb9UsX1Oeoqhdi2JRNs6E95GKe8NzfY1pyQoxFcZb
 suyRDGRXDfFlGE3SqjfMDygY8vlsGqzCc+w9MlVMAhpqyVAHYB7rTFWUXmcNi3Vnwk
 2RNv/hejcuroPRYs1+fRrb9hI1x6K0EjJF12WWBcRxX8FLBAxinh0ThAcxnZ/9Vf9U
 pyN4SuSPQvEZpmp3YB1sZA9+ef4TZg9hLfAUvPBebJh/uRA7o/38cM0QJkL8Qx+1e+
 ci07bbneOFDuQ==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Daniel Jeong <gshark.jeong@gmail.com>,
 Daniel Thompson <danielt@kernel.org>, David Heidelberg <david@ixit.cz>,
 dri-devel@lists.freedesktop.org, Helge Deller <deller@gmx.de>,
 Jingoo Han <jingoohan1@gmail.com>, Jin Park <jinyoungp@nvidia.com>,
 Kiran Gunda <quic_kgunda@quicinc.com>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 LDD MLP <ldd-mlp@list.ti.com>, linux-arm-msm@vger.kernel.org,
 linux-fbdev@vger.kernel.org, Samuel Ortiz <sameo@linux.intel.com>,
 Subbaraman Narayanamurthy <quic_subbaram@quicinc.com>
Subject: [PATCH 0/6] backlight: Fix Critical and High issues reported by
 Sashiko
Date: Wed,  4 Nov 2026 18:39:01 +0000
Message-ID: <20261104183935.1214630-1-lee@kernel.org>
X-Mailer: git-send-email 2.56.0.398.g882cbad275-goog
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

These issues were reported by Sashiko.

This series resolves the open Critical and High severity bug reports
identified by the Sashiko AI analysis tool (https://sashiko.dev) across
the Backlight subsystem:

  1. lm3630a_bl: Prevent a NULL pointer dereference in lm3630a_pwm_ctrl()
     when PWM mode is enabled by requesting the PWM device before
     registering the backlight device.
  2. aat2870_bl: Prevent a NULL pointer dereference on platform_get_drvdata()
     during devm_backlight_device_register() by populating driver data and
     scaling the initial brightness beforehand.
  3. qcom-wled: Cancel wled->ovp_work on probe failure via
     devm_delayed_work_autocancel() so a scheduled OVP work item cannot
     fire after devm_kzalloc() frees struct wled.
  4. qcom-wled: Manage wled->lock via devm_mutex_init() and remove
     wled_remove() so devres unwinds the backlight device, threaded IRQs,
     delayed work, and mutex in strict reverse registration order without
     calling disable_irq() on unconfigured negative or zero IRQ numbers.
  5. qcom-wled: Guard against calling a NULL
     wled->wled_auto_detection_required() callback on WLED3 hardware when
     an OVP fault interrupt fires.
  6. qcom-wled: Avoid an AB-BA deadlock between wled->lock and the
     threaded OVP IRQ handler by using disable_irq_nosync() in
     wled_module_enable() and verifying under wled->lock that the module
     remains enabled before running wled_auto_string_detection().

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Bjorn Andersson <andersson@kernel.org>
Cc: Daniel Jeong <gshark.jeong@gmail.com>
Cc: Daniel Thompson <danielt@kernel.org>
Cc: David Heidelberg <david@ixit.cz>
Cc: dri-devel@lists.freedesktop.org
Cc: Helge Deller <deller@gmx.de>
Cc: Jingoo Han <jingoohan1@gmail.com>
Cc: Jin Park <jinyoungp@nvidia.com>
Cc: Kiran Gunda <quic_kgunda@quicinc.com>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: LDD MLP <ldd-mlp@list.ti.com>
Cc: linux-arm-msm@vger.kernel.org
Cc: linux-fbdev@vger.kernel.org
Cc: Samuel Ortiz <sameo@linux.intel.com>
Cc: Subbaraman Narayanamurthy <quic_subbaram@quicinc.com>

Lee Jones (6):
  backlight: lm3630a: Request PWM device before registering backlight
  backlight: aat2870: Initialise driver data before registering
    backlight
  backlight: qcom-wled: Cancel delayed work on probe failure
  backlight: qcom-wled: Manage teardown via devres and remove
    wled_remove()
  backlight: qcom-wled: Check for auto-detection callback in
    wled_ovp_irq_handler()
  backlight: qcom-wled: Avoid AB-BA deadlock in wled_module_enable()

 drivers/video/backlight/aat2870_bl.c | 43 +++++++++++++------------
 drivers/video/backlight/lm3630a_bl.c | 12 +++----
 drivers/video/backlight/qcom-wled.c  | 47 +++++++++++++++-------------
 3 files changed, 52 insertions(+), 50 deletions(-)

-- 
2.56.0.385.gac671c819a-goog

