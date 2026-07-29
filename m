Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85F0AC54F51
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 12:40:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C6EFE10EBE3;
	Wed, 29 Jul 2026 12:40:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=imgtec.com header.i=@imgtec.com header.b="TBhq5BiN";
	dkim-atps=neutral
Received: from mx07-00376f01.pphosted.com (mx07-00376f01.pphosted.com
 [185.132.180.163])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5306710EBE3;
 Wed, 29 Jul 2026 12:40:45 +0000 (UTC)
Received: from pps.filterd (m0168889.ppops.net [127.0.0.1])
 by mx07-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66TBpbT6743517; Wed, 29 Jul 2026 13:40:35 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=dk201812; bh=oAwlRS4pHecL1ar/eXa7ql8
 x9v/qIqY/7b2YG8Z2+h8=; b=TBhq5BiN//4918O1l9YFoy72N62qxc9mZWcojMm
 g8tXihg/zHcS+0HMM/aPv0WCpFQrIXLbzSUMI4KqHph+M/5Tv9ovnM0p29E5D5Sm
 uuZXMe/6BE+Ig9gR9Oe+V36TpVBtrxjdKiVILcP2FYnZVW9ltjqwJlR8CQxciOfO
 Mkl60TtF+9VkjqdlTP5vymMSHIMnbyPqla+dlYIvwUDwFv9ppqby5K1iOetWvTPV
 wRctoous7Fb3sLUFXKieI8URmZAbBejQ9pYkw7ocHPgDC/OWqNMT4XOTg2klhWQv
 +bk4AvhzxKabSylZ/mhwfedejxPmSFWy5KNqWonRtvFqDhg==
Received: from hhmail01.hh.imgtec.org
 (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
 by mx07-00376f01.pphosted.com (PPS) with ESMTPS id 4fq8kr0de7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 29 Jul 2026 13:40:35 +0100 (BST)
Received: from [127.0.1.1] (172.25.7.19) by HHMAIL01.hh.imgtec.org
 (10.100.10.19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Wed, 29 Jul
 2026 13:40:34 +0100
From: Alexandru Dadu <alexandru.dadu@imgtec.com>
Date: Wed, 29 Jul 2026 15:40:25 +0300
Subject: [PATCH] drm/imagination: Reorder some fields in struct
 pvr_device_features
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260729-b4-pvr-device-features-members-reorder-v1-1-d2e18ed8cd5f@imgtec.com>
X-B4-Tracking: v=1; b=H4sIALj0aWoC/x2NSwqDQBAFryK9tmGcxIheRbKYzzP2wg/diQTEu
 2fIsqCoOsmgAqOhOklxiMm2FmjqitIc1hdYcmHyzj9c53uOd94P5VzcBJ4Q3h+F8YIlQo0Vm2Y
 o97cutTm2jQuOSmxXTPL9j8bndf0Aa5eWY3gAAAA=
To: Alessio Belle <alessio.belle@imgtec.com>, Luigi Santivetti
 <luigi.santivetti@imgtec.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
CC: <imagination@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, Alexandru Dadu <alexandru.dadu@imgtec.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785328834; l=1276;
 i=alexandru.dadu@imgtec.com; s=20260304; h=from:subject:message-id;
 bh=6QU/mWsO6BiJP7wEiMz2aG0XYGF3VNUzWndntR42uwQ=;
 b=NLMOasQ2czgAe5MV3RDA1kqPaZq8wAW9Hev9nqLTwZ5A5Bxk3z8yUFsENHbwUMPre3/wlmAyG
 3bpe6KFw+a5BlRZVxnxCrm/PlJ+TeZvfb7HVTCD2xYQTiv30vzilCRT
X-Developer-Key: i=alexandru.dadu@imgtec.com; a=ed25519;
 pk=FU07SyNrYGwhahqSxbWEuzyXlUh47xBXvLvOR7UA6+U=
X-Originating-IP: [172.25.7.19]
X-Proofpoint-GUID: HRSkF0V1LnwrHUdkzlhavVFLg-6zEHIx
X-Authority-Analysis: v=2.4 cv=It4utr/g c=1 sm=1 tr=0 ts=6a69f4c3 cx=c_pps
 a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17
 a=9dUdviUst4EA:10 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=kQ-hrUj2-E3RCbRHssb7:22 a=7RYWX5rxfSByPNLylY2M:22
 a=r_1tXGB3AAAA:8 a=umyOztjLaurY7fQvVAYA:9 a=QEXdDO2ut3YA:10
 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDEwNCBTYWx0ZWRfX2pemDSzjg4Ix
 LwrlgUbUb6BYGdBGCneBV+pmSrzICLYqueLUNcy+4slMR/qltfwRjvrFozwzb6KaUWn4AUUeS6B
 Gtv1lEdTNKGbjvJXtZHlRuM+OipJ6yojQEERuT4XPLIxyGwmV95seyxjnMNH8Cx+RHVD46FdSCd
 vWW74rdmvrZ8VUkxePHZucu65X692DEU7oXmitKjE7tY4HxJpO8zsjOdaESJgZ8dObXVZdASgJE
 hMxUC1NK3lx4aQH0YZhr+PbdSVHBeRMtL+RB2lj5HyEPIimfOVf+jEERrv1XWRlb4++FxiJbn5J
 a7WsQFve8Hch7vizD25rDZqgTK+feMznDhDlPbi5g8WDuRc1yqRxNpANRenpY5/7Bp8BRwDzUAM
 zhpbNkg7nEotgo9zOQHRXBPp3nvkEu4Um08YUVIdIZgcasF4biucNHlvATJpTjpkSFa3R3Zc+y5
 TguWCrtnbw5r2+mBhFQ==
X-Proofpoint-ORIG-GUID: HRSkF0V1LnwrHUdkzlhavVFLg-6zEHIx
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDEwNCBTYWx0ZWRfX/l9rsd2f4nI+
 ggfFV/tAefxWokv1kYzkYGkn0ZuL+fh/0f3YWj94hgiTBenMa5I9immHWgDeB51WW4fV6kUHLhl
 M3H2nSxrRalW7BGZ4e8I+A+8zDsO30o=
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

Reorder the fields of struct pvr_device_features so they match the order
in device info enum found in pvr_rogue_fwif_dev_info.h.

Signed-off-by: Alexandru Dadu <alexandru.dadu@imgtec.com>
---
 drivers/gpu/drm/imagination/pvr_device_info.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/imagination/pvr_device_info.h b/drivers/gpu/drm/imagination/pvr_device_info.h
index f61fb988b553..f6c2845530da 100644
--- a/drivers/gpu/drm/imagination/pvr_device_info.h
+++ b/drivers/gpu/drm/imagination/pvr_device_info.h
@@ -22,12 +22,12 @@ struct pvr_device_features {
 	bool has_coreid_per_os;
 	bool has_dynamic_dust_power;
 	bool has_ecc_rams;
-	bool has_fb_cdc_v4;
-	bool has_fbc_max_default_descriptors;
-	bool has_fbc_max_large_descriptors;
 	bool has_fbcdc;
 	bool has_fbcdc_algorithm;
 	bool has_fbcdc_architecture;
+	bool has_fbc_max_default_descriptors;
+	bool has_fbc_max_large_descriptors;
+	bool has_fb_cdc_v4;
 	bool has_gpu_multicore_support;
 	bool has_gpu_virtualisation;
 	bool has_gs_rta_support;

---
base-commit: e55fead22ff9ee047ab9f1903860c4b43043514e
change-id: 20260729-b4-pvr-device-features-members-reorder-937c5db510a0

Best regards,
-- 
Alexandru Dadu <alexandru.dadu@imgtec.com>

