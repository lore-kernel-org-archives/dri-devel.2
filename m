Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66F81CD98CC
	for <dri-devel@archiver.kernel.org>; Thu, 11 Jun 2026 13:52:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD45D10E78D;
	Thu, 11 Jun 2026 13:52:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TQvUZiLt";
	dkim-atps=neutral
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com
 [209.85.222.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3580510EEF9
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 12:54:12 +0000 (UTC)
Received: by mail-qk1-f178.google.com with SMTP id
 af79cd13be357-915510525deso93733685a.3
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 05:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781182451; x=1781787251; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=pApUitxnpFLRw4B63hSdHQtKPDI/sltH6G53COwClfE=;
 b=TQvUZiLt93n3vxBfF/J+7PdBQoPZWevztBgcDIgUsm1Hu0gc7l8jUsOTAAKNQ89O7c
 jtGBdwnaz7kGnKYRJ+Vkpszwh6PqqneWtmF8QMIiwBtjT3l8zIZN8cvZwsNZDLigLrYj
 XFs21Drp1BoIkctyPn0JyldGSo9hadUcF3AVIpj3hibH04/jB6Q05yGNUCeMgAckUvQe
 RoEqz4vWH9PatWETIWitqRagWhTxSjUWwTp5udrzKjUjMMVPSF+HXCkO8J36L9N0tnWr
 isU+rPAu9YDQPDD7hJ9m1miwd5f6LC99UZxEyqJop4B5tS1XuVmzrt3SrsrJYc368P8q
 j+Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781182451; x=1781787251;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pApUitxnpFLRw4B63hSdHQtKPDI/sltH6G53COwClfE=;
 b=ik5Be2Em6Swjn3Ybjc89MdZd6gxXEh18gqJWHoMeVlKYeGVmfWYNobMOa3T27MjtJ/
 GZiKFw4TzjB2cPj2i/4/0z1cmn5qJE5KY8bZozIx4gUMVjeQUpAg4s0EJIBlTM4uh7y2
 Hz8USS9A39lvcu5tlYnDgJ3yrN2DxDj6Kc2os5MlfuAKUYT9puXQivuS1PgJ9riQQnaj
 sWoqkkOuQ7kRqsc88xiaRZzM8puaWXJpN+zqk8liJMy2e137IOlO6nroTAdTHvgEiZif
 Ff//uR3Q4XXhgL7uyPlPqcaIImQGSDNzdll8UtF2mYGmAm2ADseQlCxcWBsIlvPnVqyM
 BjVQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ86bBQ3W/qp47vJxu2T5Or2RnhFjr7ZxLhj+qK/bP04lPxDFDU9eouwt6UyxR5dG8qNBLcaSdDv/mU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy/TJk0RMFkU5jjYSDZiRZ7NmB2bZ+sYSsKO4um5DfNCzx5vvM/
 7Q43ARqDCLL3AENpAljS6OPG8tK81hIc+oUsSdPAxeeAB4X96Azkr3BX
X-Gm-Gg: Acq92OGrt5GYuS0U7tdLazoP4Bb9aQij0NhR08cSGBdqHoQGc8jn1jIE/DYog+hhQqx
 OYwN+AjvFTUohFsz8/eVS5Lo/dbItEoxB8gO6I3eS5f2G2lnAzk0tzBkpSC1Nc20am11umqnxom
 PTJPNC/GzEjFyPR7+18+PxK+qER8JjB+IR/fgRErRVN5c3GVI2aW5k5DN9887a+jYxrFg7SrhqY
 TbVULeJdxtuyQIBtr9OGAzjLo2bTFmaxVcZWs3BT4103AZLdXT0RC4DOD3ztmCoYPLgsfn8Cu7H
 fR2LXkMS5EStq+jkZKavpD1VE3nH2IRJNShxiyolsccGNg9isfqIfp4qdL6IJ0UwaoA0R5iOIsY
 RBgGAxVr50Ius1oKJQdGIS5WtAxYiHINWWwkV7XjxZUt6lsKKho3G2b/uzlfxqG2+z5i7aJTiq/
 +5smg78pXSVDb8YlSxqLynSDu86oyeQycWlen2o2cRxc27g5SMHxEcfkpYsZB9uoItCv9/FbxEJ
 s0IeejGMpT1DKT/UC8MmgAv7nL13HYV+aa2ETBf2nMHbSXwMj9y6yxTfFHognK1OQz921mtxaIs
 sA==
X-Received: by 2002:a05:620a:6486:b0:914:ea37:6f14 with SMTP id
 af79cd13be357-9160ab058bdmr226309185a.1.1781182451197; 
 Thu, 11 Jun 2026 05:54:11 -0700 (PDT)
Received: from debian-t14-gen1-fuhrysteve.fuhry.app
 (6.sub-75-230-138.myvzw.com. [75.230.138.6])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9160accaf7asm176311485a.19.2026.06.11.05.54.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2026 05:54:10 -0700 (PDT)
From: "Stephen J. Fuhry" <fuhrysteve@gmail.com>
To: intel-gfx@lists.freedesktop.org
Cc: Jani Nikula <jani.nikula@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 =?UTF-8?q?Jouni=20H=C3=B6gander?= <jouni.hogander@intel.com>,
 Animesh Manna <animesh.manna@intel.com>, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, "Stephen J . Fuhry" <fuhrysteve@gmail.com>
Subject: [PATCH] drm/i915/display: guard intel_alpm_get_error() against
 non-ALPM sinks
Date: Thu, 11 Jun 2026 08:54:08 -0400
Message-ID: <20260611125408.676626-1-fuhrysteve@gmail.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 11 Jun 2026 13:52:22 +0000
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

intel_alpm_get_error() unconditionally reads DP_RECEIVER_ALPM_STATUS via
AUX from any DP connection that receives a short-pulse interrupt.  However,
alpm_dpcd is only populated by intel_edp_init_dpcd(), so it is zero for
all external (non-eDP) DP and DP-MST connections.  On such connections the
AUX read fails, producing a spurious

  [drm] *ERROR* Error reading ALPM status

and setting sink_alpm_error = true, which is then visible in the ALPM
debug output even on hardware that never enabled ALPM.

intel_alpm_disable() already has the same guard (DISPLAY_VER check plus
!intel_dp->alpm_dpcd); extend the same logic to intel_alpm_get_error() so
it returns early without attempting the AUX transaction when ALPM is not
supported by the sink.

Reproducer: ThinkPad T14 Gen1 (Alder Lake-P / i915 DISPLAY_VER 12) docked
via Lenovo ThinkPad USB-C Dock Gen2 with external DP-MST monitors.  On
every DPMS wake the error fires once on the dock's upstream DP port.

Fixes: 2063174c22da ("drm/i915/lobf: Check for sink error and disable LOBF")
Signed-off-by: Stephen J. Fuhry <fuhrysteve@gmail.com>
---
 drivers/gpu/drm/i915/display/intel_alpm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/i915/display/intel_alpm.c b/drivers/gpu/drm/i915/display/intel_alpm.c
index a7350ce8e716..4bb0c00741c4 100644
--- a/drivers/gpu/drm/i915/display/intel_alpm.c
+++ b/drivers/gpu/drm/i915/display/intel_alpm.c
@@ -611,6 +611,9 @@ bool intel_alpm_get_error(struct intel_dp *intel_dp)
 	u8 val;
 	int r;

+	if (!intel_dp->alpm_dpcd)
+		return false;
+
 	r = drm_dp_dpcd_readb(aux, DP_RECEIVER_ALPM_STATUS, &val);
 	if (r != 1) {
 		drm_err(display->drm, "Error reading ALPM status\n");
--
2.39.5
