Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE47ECD4851
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 06:15:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D33F410EA6A;
	Tue, 19 May 2026 06:15:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="L8E9UP6J";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6143C10EA64
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 06:15:56 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id A23E660212;
 Tue, 19 May 2026 06:15:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4AFF5C2BCC6;
 Tue, 19 May 2026 06:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1779171355;
 bh=oPFAYDbcOdaONkTK3t8RuJ4HZ+KQnAEEZ3J8LUUbMv8=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=L8E9UP6JDabt600TvsCR9slzoGhC8Jwuiv7ar8SzlmQIT/5k4Ap/fBmT2Sp4/mBGi
 GkRCVI8vKNMEDIjQo5e+HBThyfqZOLIB3g42MxaA4VfW8vXPGelxTQ00XHskUqpVjR
 71f6xwdeuUhqEJ/qY6tV90GvdI+XxlwKEls7aL8AXm27Mfu7z3U5rvNxJ0W7C56GM2
 8+VC4dtJ1yrnvzCLcnl76SyXDtZfozios3ijPACRDedJ0gBECnQx6CkyrzhWae6605
 lZSIVwBRORUJjwkgZhb7RGt1Ek1/lcp9UhNfq6V1yNS4Nr+zSA/ijtNS/cVtPSvEl5
 5ypjvcl6TZGIA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 37596CD4F3C;
 Tue, 19 May 2026 06:15:55 +0000 (UTC)
From: Ekansh Gupta via B4 Relay
 <devnull+ekansh.gupta.oss.qualcomm.com@kernel.org>
Date: Tue, 19 May 2026 11:45:51 +0530
Subject: [PATCH 01/15] MAINTAINERS: Add entry for Qualcomm DSP Accelerator
 (QDA) driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260519-qda-series-v1-1-b2d984c297f8@oss.qualcomm.com>
References: <20260519-qda-series-v1-0-b2d984c297f8@oss.qualcomm.com>
In-Reply-To: <20260519-qda-series-v1-0-b2d984c297f8@oss.qualcomm.com>
To: Oded Gabbay <ogabbay@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, Joerg Roedel <joro@8bytes.org>, 
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Sumit Semwal <sumit.semwal@linaro.org>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Bharath Kumar <quic_bkumar@quicinc.com>, 
 Chenna Kesava Raju <quic_chennak@quicinc.com>, srini@kernel.org, 
 dmitry.baryshkov@oss.qualcomm.com, andersson@kernel.org, 
 konradybcio@kernel.org, robin.clark@oss.qualcomm.com, 
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-doc@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 iommu@lists.linux.dev, linux-media@vger.kernel.org, 
 linaro-mm-sig@lists.linaro.org, 
 Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779171352; l=1114;
 i=ekansh.gupta@oss.qualcomm.com; s=20260223; h=from:subject:message-id;
 bh=AcTCOc39xB2eWZrt+ASexMe8l7bzMXO4brOtNDdJpLc=;
 b=XwNsf2StpfGEc03MIN5ksLv66Pg0T/usYVgQPmqfzw5MxB6jXvhJsbXX7bTYyLF5Fy7wEzC3K
 d5yJ5e27faWDfrCTzW5xSeogxKwAaQNBtjHjh56ZsIQNBZP6cslu86G
X-Developer-Key: i=ekansh.gupta@oss.qualcomm.com; a=ed25519;
 pk=n0SepARizye+pYjhjg1RA5J+Nq4+IJbyRcBybU+/ERQ=
X-Endpoint-Received: by B4 Relay for ekansh.gupta@oss.qualcomm.com/20260223
 with auth_id=647
X-Original-From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
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
Reply-To: ekansh.gupta@oss.qualcomm.com
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>

Add a MAINTAINERS entry for the Qualcomm DSP Accelerator (QDA) driver,
covering the driver source under drivers/accel/qda, documentation under
Documentation/accel/qda, and the UAPI header
include/uapi/drm/qda_accel.h. The linux-arm-msm and dri-devel mailing
lists are listed as the relevant review lists.

Assisted-by: Claude:claude-4-6-sonnet
Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3dd58a16f06a..c5c13ad1e6fe 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22083,6 +22083,15 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/crypto/qcom-qce.yaml
 F:	drivers/crypto/qce/
 
+QUALCOMM DSP ACCELERATOR (QDA) DRIVER
+M:	Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
+L:	linux-arm-msm@vger.kernel.org
+L:	dri-devel@lists.freedesktop.org
+S:	Supported
+F:	Documentation/accel/qda/
+F:	drivers/accel/qda/
+F:	include/uapi/drm/qda_accel.h
+
 QUALCOMM EMAC GIGABIT ETHERNET DRIVER
 M:	Timur Tabi <timur@kernel.org>
 L:	netdev@vger.kernel.org

-- 
2.34.1


