Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1D06CD343B
	for <dri-devel@archiver.kernel.org>; Thu,  7 May 2026 06:23:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 05A5410EF5B;
	Thu,  7 May 2026 06:23:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="cKSvLFDa";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hrfyaBdG";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E35310EF5B
 for <dri-devel@lists.freedesktop.org>; Thu,  7 May 2026 06:23:12 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6475Lewt1068278
 for <dri-devel@lists.freedesktop.org>; Thu, 7 May 2026 06:23:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=4b06huhDhBP
 LgQXsILfi1dnmLMKdgyO1zEklZp2Wyqc=; b=cKSvLFDaeHA5jl47fC2yTYhRLH9
 KVIgCApPKLnuPVk2LTHTfwNPPR7OSTgCILVDh1xSmjDXIX82biexdVdB6PikHYl/
 3TF7VytTY6WF0UwYWRIVIHD3Wd8w42tU6a8oVlooshzOeTw1ock67uders5SyfmQ
 gzPGsIWfXoLTQd+81mn5v79ZziADqbHw1Qzux1ldnvgcpQExUPClsegAiqED0T6p
 A+CKcuV3jJQRNqDQEqFHDKhXcY3czbi6aMNUMGoMLEB0oiBhkDjdHdX3YmZ6CFx8
 mEU4M80BEkNGRaCq3qEOjv6Pd9gkFOLMwPlrylPxbz+CegmcyBcO3BCyLHw==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e0mh186h5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 07 May 2026 06:23:11 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-82f9429f49cso553032b3a.3
 for <dri-devel@lists.freedesktop.org>; Wed, 06 May 2026 23:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778134991; x=1778739791;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4b06huhDhBPLgQXsILfi1dnmLMKdgyO1zEklZp2Wyqc=;
 b=hrfyaBdG7oimYQI55AfV974ojqK7y1/zqxulP+ilbJsVYjiTdUe31roiCu/jstdKp+
 8sCEesJ2ygS+oRUXXaq7/U8E6cAFCmecoNjl77PhioS4VhPw39qpz1KU7oHqR/7fpLfa
 6XztEw5umeEN7K0q+pyFwlfUgO4Ix71E5DSNKPSGD8rlQPTm53C7FT5+7hd3UEnJUqy+
 E0LUbWk0N9SvJc87DfQsnEWnppRYv5NMK34ZZcBzjWSX4eUAjyAPf2EoJ005iuNxT7jz
 bO7MRXYFNO4QcNwkTmXJaIj02UDnl6KODlxB2+g4ZNXpDPrWHRj0F/s92FeT3l08wTjn
 ylZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778134991; x=1778739791;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4b06huhDhBPLgQXsILfi1dnmLMKdgyO1zEklZp2Wyqc=;
 b=sRN44NR+5P7GNqRky9B/ZE4DKsiErs/CZ8DV4lgPsF4VgcKCR3+hQyvuqoat8527yp
 gbW3CULvNxyjr1VEL85UZitdG3mGohw7JOnuL9BCY2s+/FenjfKW3r6LaKwRP7O5bwul
 5W2ODmDC2hNYJjtY94PCWxEYp0tiP0QMqr8D5KZhp6xJo9bCh7LxNpsP6cJulT/7aZ4H
 JSfDocLEczdxnK5868dZoZ4WBjq1ms0YPKoOvqq76nrSis+ZAX7tlOCWttXetyMWyRXR
 3PYcu8ezyr6zNVSOpoFGivAD5KofHiIhZmf5YFtyUg21XAMqKYfQ1Gf55QILZyTpQNAO
 jD9A==
X-Forwarded-Encrypted: i=1;
 AFNElJ86BSIIlL3Uq4lTWa8qAB7SAKkP+wrLjznzGwfUJI9bePWeBIXfKQU2wGiqdUZLf+QS9Od2fu69gDw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyqMLQmnpkuH+HLY+sb5a03Il5M58/u2oZBmP9i+LieheczETCF
 B4Ah75BCHLVLt1ql5uxO0q3k7EbObRvA6phEioZBgOb3fThOpRgy3NneU8R144T84ep0NpjHGxQ
 wdifBADSWVNHudcL4fsvdajFYALaVtTAwdc32L+5VKQn8W0MZKEnI5zzeln0VPQ6wFTfvDUQ=
X-Gm-Gg: AeBDieuj0sZbU8MgQxaPyiaByryT1R4m2U+2wfd7UJj2mw9NaedwMMdGWdzW6K6SKdc
 TPSxUaoCXoMU59vvbcZVpNZ4rylU2BSD7qJu2IevO0t21HMFeuBMbhYJrK3kji6J7NClsrUcpIu
 A3dYZGpBNHYlbJuad/2Xne6kCJ47yf7ihxTHzWjJAgAioMVv0BNG21Gk8P06wO9g++0Rhs/IB4m
 5rqTLzM40UrG83vaIoh8/Vu18L0GNIVMKOAaOHXMFpGwGPXnQeOFLqBwr1EPl/k7YizumKAyG7p
 ksYzRoYZItNV/JvZbRiLztS4zvEekME/vAp0EoQCEuPKX/bubqXjHIbV1YaL40ICFKSQ67kCyGU
 l16k0RgTNyoDK/whNFjWF/WC0Fj9JNbzi+wntXTVh3uExjMYtkycCC22vdh/Lo/XxMrZzVw8EEP
 w2FyvhT+mJw5CIexEvjj+1jqgYrj1NPdGm8LD8ACKsIM7UXbQ=
X-Received: by 2002:a05:6a00:12d2:b0:835:cc47:6fe7 with SMTP id
 d2e1a72fcca58-83a5dd5c9f0mr6280901b3a.30.1778134991253; 
 Wed, 06 May 2026 23:23:11 -0700 (PDT)
X-Received: by 2002:a05:6a00:12d2:b0:835:cc47:6fe7 with SMTP id
 d2e1a72fcca58-83a5dd5c9f0mr6280877b3a.30.1778134990795; 
 Wed, 06 May 2026 23:23:10 -0700 (PDT)
Received: from hu-sibis-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-83965945101sm7346557b3a.13.2026.05.06.23.23.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2026 23:23:10 -0700 (PDT)
From: Sibi Sankar <sibi.sankar@oss.qualcomm.com>
To: cristian.marussi@arm.com, sudeep.holla@kernel.org, cw00.choi@samsung.com, 
 kyungmin.park@samsung.com, myungjoo.ham@samsung.com,
 konradybcio@kernel.org, andersson@kernel.org
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 arm-scmi@vger.kernel.org, linux-tegra@vger.kernel.org,
 linux-pm@vger.kernel.org, dmitry.baryshkov@oss.qualcomm.com,
 jonathanh@nvidia.com, thierry.reding@kernel.org, digetx@gmail.com,
 conor+dt@kernel.org, krzk+dt@kernel.org, robh@kernel.org
Subject: [RFC V6 3/8] PM / devfreq: Add new target_freq attribute flag for
 governors
Date: Thu,  7 May 2026 11:52:32 +0530
Message-Id: <20260507062237.78051-4-sibi.sankar@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260507062237.78051-1-sibi.sankar@oss.qualcomm.com>
References: <20260507062237.78051-1-sibi.sankar@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: d_jewEmQ8BWEBs8TNrLBf8hDPwydDx23
X-Proofpoint-ORIG-GUID: d_jewEmQ8BWEBs8TNrLBf8hDPwydDx23
X-Authority-Analysis: v=2.4 cv=P9gKQCAu c=1 sm=1 tr=0 ts=69fc2fcf cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=K3uUPCIpGL4zgFOSzcMA:9 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDA2MCBTYWx0ZWRfXwQarlb5QigsV
 dlN09bBJbMa4ZGDvhGXrUoE2ad9DbhVWzZVLU8PAdb2VlTGmtHXxcJwNmb45hCNW1YY4ifqy/a0
 qbOmo7/DyPc3bKojUqoFBEI1XDlgHunB4d/rod/q9wYedqicxtXMFUiSHknMN6I/xTg0dkRqPKA
 qMy2lRqc+4xwFvAE4kVJ1ExQPzfG4gl91Cte04LO88uhPbqEGa+dO+HKc+hxikpPvidM/AEjlzN
 Pp4ouMk93OG7RWxaQ1QQcLFHEQ7w7n+O7SxUssW19A9HA6Rf/kyOW9H8Hy6XcySdPxVpa65qU2k
 wwsusQzw1IlKqFUCYT6e25jpDnnCXmH998UBAjbu9ePkTLNGrb/GPUIo/2Bh7Ff7Hxmf+fbidY9
 f+jf4tWCZaqmuLZ+Skd2mc1t3pzYPSOQSTQDbINQ1xI+UenLbjWv52+DTKqGc3k8Qy9F1Sn1IH7
 HY7zEHJ7nh5DBBPaInQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-06_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 spamscore=0 impostorscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605070060
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

Introduce the target_freq attribute flag as a pre-cursor to adding support
for devfreq governors who do not explicitly allow for a method to get/set
target frequency.

Signed-off-by: Sibi Sankar <sibi.sankar@oss.qualcomm.com>
---
 drivers/devfreq/devfreq.c                 | 4 ++++
 drivers/devfreq/governor_passive.c        | 1 +
 drivers/devfreq/governor_performance.c    | 1 +
 drivers/devfreq/governor_powersave.c      | 1 +
 drivers/devfreq/governor_simpleondemand.c | 1 +
 drivers/devfreq/governor_userspace.c      | 1 +
 drivers/devfreq/hisi_uncore_freq.c        | 1 +
 drivers/devfreq/tegra30-devfreq.c         | 3 ++-
 include/linux/devfreq-governor.h          | 3 +++
 9 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index e5d3f9cf94dc..85e937e321e8 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -1526,6 +1526,10 @@ static ssize_t target_freq_show(struct device *dev,
 {
 	struct devfreq *df = to_devfreq(dev);
 
+	if (!df->profile || !df->governor ||
+	    !IS_SUPPORTED_ATTR(df->governor->attrs, TARGET_FREQ))
+		return -EINVAL;
+
 	return sprintf(buf, "%lu\n", df->previous_freq);
 }
 static DEVICE_ATTR_RO(target_freq);
diff --git a/drivers/devfreq/governor_passive.c b/drivers/devfreq/governor_passive.c
index d7feecd900f1..b75e4bbee4b1 100644
--- a/drivers/devfreq/governor_passive.c
+++ b/drivers/devfreq/governor_passive.c
@@ -448,6 +448,7 @@ static int devfreq_passive_event_handler(struct devfreq *devfreq,
 
 static struct devfreq_governor devfreq_passive = {
 	.name = DEVFREQ_GOV_PASSIVE,
+	.attrs = DEVFREQ_GOV_ATTR_TARGET_FREQ,
 	.flags = DEVFREQ_GOV_FLAG_IMMUTABLE,
 	.get_target_freq = devfreq_passive_get_target_freq,
 	.event_handler = devfreq_passive_event_handler,
diff --git a/drivers/devfreq/governor_performance.c b/drivers/devfreq/governor_performance.c
index fdb22bf512cf..b9ec587f582c 100644
--- a/drivers/devfreq/governor_performance.c
+++ b/drivers/devfreq/governor_performance.c
@@ -37,6 +37,7 @@ static int devfreq_performance_handler(struct devfreq *devfreq,
 
 static struct devfreq_governor devfreq_performance = {
 	.name = DEVFREQ_GOV_PERFORMANCE,
+	.attrs = DEVFREQ_GOV_ATTR_TARGET_FREQ,
 	.get_target_freq = devfreq_performance_func,
 	.event_handler = devfreq_performance_handler,
 };
diff --git a/drivers/devfreq/governor_powersave.c b/drivers/devfreq/governor_powersave.c
index ee2d6ec8a512..69eab1d0a7fc 100644
--- a/drivers/devfreq/governor_powersave.c
+++ b/drivers/devfreq/governor_powersave.c
@@ -37,6 +37,7 @@ static int devfreq_powersave_handler(struct devfreq *devfreq,
 
 static struct devfreq_governor devfreq_powersave = {
 	.name = DEVFREQ_GOV_POWERSAVE,
+	.attrs = DEVFREQ_GOV_ATTR_TARGET_FREQ,
 	.get_target_freq = devfreq_powersave_func,
 	.event_handler = devfreq_powersave_handler,
 };
diff --git a/drivers/devfreq/governor_simpleondemand.c b/drivers/devfreq/governor_simpleondemand.c
index ac9c5e9e51a4..65ff9d912ef9 100644
--- a/drivers/devfreq/governor_simpleondemand.c
+++ b/drivers/devfreq/governor_simpleondemand.c
@@ -118,6 +118,7 @@ static int devfreq_simple_ondemand_handler(struct devfreq *devfreq,
 static struct devfreq_governor devfreq_simple_ondemand = {
 	.name = DEVFREQ_GOV_SIMPLE_ONDEMAND,
 	.attrs = DEVFREQ_GOV_ATTR_POLLING_INTERVAL
+		| DEVFREQ_GOV_ATTR_TARGET_FREQ
 		| DEVFREQ_GOV_ATTR_TIMER,
 	.get_target_freq = devfreq_simple_ondemand_func,
 	.event_handler = devfreq_simple_ondemand_handler,
diff --git a/drivers/devfreq/governor_userspace.c b/drivers/devfreq/governor_userspace.c
index 3906ebedbae8..d1b765a7b8e5 100644
--- a/drivers/devfreq/governor_userspace.c
+++ b/drivers/devfreq/governor_userspace.c
@@ -135,6 +135,7 @@ static int devfreq_userspace_handler(struct devfreq *devfreq,
 
 static struct devfreq_governor devfreq_userspace = {
 	.name = DEVFREQ_GOV_USERSPACE,
+	.attrs = DEVFREQ_GOV_ATTR_TARGET_FREQ,
 	.get_target_freq = devfreq_userspace_func,
 	.event_handler = devfreq_userspace_handler,
 };
diff --git a/drivers/devfreq/hisi_uncore_freq.c b/drivers/devfreq/hisi_uncore_freq.c
index 4d00d813c8ac..0800116e3334 100644
--- a/drivers/devfreq/hisi_uncore_freq.c
+++ b/drivers/devfreq/hisi_uncore_freq.c
@@ -399,6 +399,7 @@ static struct devfreq_governor hisi_platform_governor = {
 	 * Set interrupt_driven to skip the devfreq monitor mechanism, though
 	 * this governor is not interrupt-driven.
 	 */
+	.attrs = DEVFREQ_GOV_ATTR_TARGET_FREQ,
 	.flags = DEVFREQ_GOV_FLAG_IRQ_DRIVEN,
 	.get_target_freq = hisi_platform_gov_func,
 	.event_handler = hisi_platform_gov_handler,
diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
index 401aac6a9f07..fcb278c4a74c 100644
--- a/drivers/devfreq/tegra30-devfreq.c
+++ b/drivers/devfreq/tegra30-devfreq.c
@@ -776,7 +776,8 @@ static int tegra_governor_event_handler(struct devfreq *devfreq,
 
 static struct devfreq_governor tegra_devfreq_governor = {
 	.name = "tegra_actmon",
-	.attrs = DEVFREQ_GOV_ATTR_POLLING_INTERVAL,
+	.attrs = DEVFREQ_GOV_ATTR_POLLING_INTERVAL
+		| DEVFREQ_GOV_ATTR_TARGET_FREQ,
 	.flags = DEVFREQ_GOV_FLAG_IMMUTABLE
 		| DEVFREQ_GOV_FLAG_IRQ_DRIVEN,
 	.get_target_freq = tegra_governor_get_target,
diff --git a/include/linux/devfreq-governor.h b/include/linux/devfreq-governor.h
index dfdd0160a29f..2853f571dfdf 100644
--- a/include/linux/devfreq-governor.h
+++ b/include/linux/devfreq-governor.h
@@ -43,9 +43,12 @@
  *   : Indicate polling_interval sysfs attribute
  * - DEVFREQ_GOV_ATTR_TIMER
  *   : Indicate timer sysfs attribute
+ * - DEVFREQ_GOV_ATTR_TARGET_FREQ
+ *   : Indicate the target freq sysfs attribute
  */
 #define DEVFREQ_GOV_ATTR_POLLING_INTERVAL		BIT(0)
 #define DEVFREQ_GOV_ATTR_TIMER				BIT(1)
+#define DEVFREQ_GOV_ATTR_TARGET_FREQ			BIT(2)
 
 /**
  * struct devfreq_governor - Devfreq policy governor
-- 
2.34.1

