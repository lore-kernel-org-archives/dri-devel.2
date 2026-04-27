Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76846FF8850
	for <dri-devel@archiver.kernel.org>; Mon, 27 Apr 2026 06:39:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C0D3E10E588;
	Mon, 27 Apr 2026 06:39:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="dgR8RwP9";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="a5RBHdL1";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B37AB10E57B
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 06:39:16 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63R64Pje2583538
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 06:39:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 vjxepcNfcMFp0kM4FwikjtT6M4X71nel3jc1Rp4eDPk=; b=dgR8RwP9qtCg4A6a
 DZGZ9pucnCSCHA2gmipBUsmnY5zoWFR5Qjrk6oFj8bxAHag0i+z7sqlflL4Uu6nP
 hPPZ2vjj8TvRXmcXVQijP4JnNn7cbHamunNP9sYd8TNEAcMg8CSyj4t8IJZmVPyG
 2JDE8KeFuscoxeF8JGA4g07yrX73kWmpq/5Q9cl+yvLojMnd4oZc16pZN92+p7T9
 B814gmK+FAe0ozK9TcOrNBjCrzeceqmFg771t6NYUI6Ysw0BOCEWdkMHh8ytq01p
 MN20r4hGlSKAyr1vlJSlzMz6GUx3i+fYd5ZA9RRCxRFqSooAJNs+GyenP1bHKF1U
 kMqb+A==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dt26xg3v9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 06:39:15 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-35dacc40f92so9810478a91.2
 for <dri-devel@lists.freedesktop.org>; Sun, 26 Apr 2026 23:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777271954; x=1777876754;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=vjxepcNfcMFp0kM4FwikjtT6M4X71nel3jc1Rp4eDPk=;
 b=a5RBHdL1uVOyZJf//rC6JKcZvlAkOq38F/tM2gSojH0IcnzHKKhm3WeycJzH2mSPNm
 i/8euEc2TUXB9kz+++xwcI9xH1qS8bIGdcIEoenPiBmsygx2N6eBwRzi5sUU3fMEaU6d
 XO/Fvo8ROh44sZ5XvFp3MymYtCqH7xitbJIk+d9tFpyphmAUdAar4N6EXm9kpn0Qe0aA
 nBHXf9BKtgqDsYkh1f4MHQNbz+s7Sx4OmEpH1TEhSYF+vD8eQzzOf2erzJs27wJDD2Z+
 AQK9DCOHnVpOYzHz3/FKndmxb1GZAsmlq989cJ9AOSEAc4En5e3WtuPodb0Lryoe9O7b
 kgMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777271954; x=1777876754;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=vjxepcNfcMFp0kM4FwikjtT6M4X71nel3jc1Rp4eDPk=;
 b=fwHczZSfJa0F/6pS8S/v82Rstg5FTo5sa7KfUGTKiVcMpz/UCoPfnjjwLO/FrYHfmg
 GjDAJVNHdYGvjvi6xky6x+y8gby8fHzUaHbpDILhxuuucI+2XE93FzSrSqvKtXYD2cmZ
 CjlN627IQuU+XH4/eeCxeaAgjbTkBu3vyFvqL39C6LWhcu+dyUkRmyckP09bJMKfCh6/
 zGGhJn0rPjOpEW7h/K/VfCjtNYWOBDDtbhRMw0uP50vJak0RX5QQgXKOiVrFijofclG+
 AaA6XhemwTDJ+XgbMooaxepqEH+gzia9RYBjPmamQK1tXP8hE914arY089Kh9CcJZLTx
 Axpg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+qoVZHYJNYqIc85padf3B5QsUKFW7yGIiIvFMgBpTHUjx4PuObig73AdPZrVoV6h7ZWY05VYZ/DNA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyxsLL0ha50Wre2QspVh6zIm/t5sQFvtclB1Vl8GpS124DpiGEf
 T5G8ud51wSOvBOvad9IpSIlzalc8VNJet4rsCsoy7ojySRT7SwvL01ykbq0BobruaCDVpRaakJN
 KnXGINHLKNqE9B0VI+Vn4hjnJRtucFGEowWo6jRZ/Y3EnmzXtoOVAn3GOvRtnXBZ1vwKpJF0=
X-Gm-Gg: AeBDietlRSPqCseIKBgeJi85eyxBMIBkbn1/5CxP5S2rMlX9T39KFQZJXzKs/zBzZsN
 /hputgdExHQqCzwJxlx9DgaYQuWlmwcRjHvKR7o2of9o7y9MtPk8ZYDXMsjBHMEOde+aGtmuV06
 kj25m8QeKn0qrC7vfSgsTO0CIsyn88IG777fqAcs1qg3VVgtVFG05DhNACY4aFKum9W8pc6lLRX
 RvNeAn0cyFxkjKDy84v1Je4WjQwPGXv7JSb6mRfJVC02dArFjNtjoUKbC4gtcYDRnC4UfQ1vcRZ
 ZzXk+CEKmY6TUOBhS9uhoYkBcYJ3Nef2muiilnpvVxylmYdnZmfnzKRUbGfuEY54A9WnGx/9GtH
 eP8AYFPS7weX7p2xtmL5L0KswMj2xbHPnZcEvwriKFgykioQEF0LmVvXQ
X-Received: by 2002:a17:90b:384e:b0:35b:952c:43b9 with SMTP id
 98e67ed59e1d1-3614040b2c7mr44429961a91.10.1777271954508; 
 Sun, 26 Apr 2026 23:39:14 -0700 (PDT)
X-Received: by 2002:a17:90b:384e:b0:35b:952c:43b9 with SMTP id
 98e67ed59e1d1-3614040b2c7mr44429904a91.10.1777271953943; 
 Sun, 26 Apr 2026 23:39:13 -0700 (PDT)
Received: from hu-tdas-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-361410a7ab7sm38628234a91.10.2026.04.26.23.39.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Apr 2026 23:39:13 -0700 (PDT)
From: Taniya Das <taniya.das@oss.qualcomm.com>
Date: Mon, 27 Apr 2026 12:08:55 +0530
Subject: [PATCH v2 1/6] clk: qcom: gdsc: Add custom disable callback for GX
 GDSC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260427-gfx-clk-fixes-v2-1-797e54b3d464@oss.qualcomm.com>
References: <20260427-gfx-clk-fixes-v2-0-797e54b3d464@oss.qualcomm.com>
In-Reply-To: <20260427-gfx-clk-fixes-v2-0-797e54b3d464@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Abel Vesa <abel.vesa@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Ajit Pandey <ajit.pandey@oss.qualcomm.com>,
 Imran Shaik <imran.shaik@oss.qualcomm.com>,
 Jagadeesh Kona <jagadeesh.kona@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, Taniya Das <taniya.das@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-aa3f6
X-Proofpoint-GUID: avsssFeBHpNTpbQC2UgjdqlxXD_vXDcE
X-Proofpoint-ORIG-GUID: avsssFeBHpNTpbQC2UgjdqlxXD_vXDcE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI3MDA2OCBTYWx0ZWRfXymmPm5Sn4bIx
 iO/B9IWvXQYn2Gwvmh1rDysrtfSEjwPl1cZl0w8UTxSiNY3CaBGCrOk9CoAJp3laOYqC9VoGc19
 B63nZFprxJ5b1AvtHHjxOfrPD4JFMHoBU6EIJYpdPKOxcytxmhBKd5hIc92VMo1aMYPHUVpHAdf
 9hfFoWsx9sIpzrGSF4CFl1j2zMLaR4kQt8Y1EUWBvYxsbuyO+pvjv61Cdg4nMX0d0BqxfS3Wmqz
 lONg1fpMb0/kachxngrK2ANQOoEgyPmaphnP45m+29yFXwjJf3E1yn2NNZQVjUDHIRsHmGPLNpr
 eiFqz5q9icnzzm1cN/QdIBiKzTiGdrpkMOp/2AoawqZG1XgdFQCcLssXIEcOQrOzL6HMAkepB4N
 KIWXQY8NFDcMfIBH7inpWX2OtsIYUL/FUO7/mp65FooL62MrAoEtekT5n/Cu37HvqTgjrHcxDa5
 kgPOG1sUiNyiFu5vfxw==
X-Authority-Analysis: v=2.4 cv=FM8rAeos c=1 sm=1 tr=0 ts=69ef0493 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=6udHJU8j9nUP921WRPkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-27_01,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 bulkscore=0 phishscore=0
 spamscore=0 malwarescore=0 priorityscore=1501 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604270068
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

From: Jagadeesh Kona <jagadeesh.kona@oss.qualcomm.com>

The GX GDSC is a special power domain that should only be disabled
by OS during GMU recovery. In all other scenarios, the GMU firmware
is responsible for handling its disable sequence, and OS must not
interfere.

During the resume_noirq() phase of system resume, the GenPD framework
enables all power domains and later disables them in the complete()
phase if there are no active votes from OS. This behavior can
incorrectly disable the GX GDSC while the GMU firmware is still using
it.

To prevent this, implement a custom disable callback for GX GDSC that
relies on GenPD’s synced_poweroff flag. The GMU driver sets this flag
only during recovery, allowing OS to explicitly disable GX GDSC in
hardware in that case. In all other situations, the disable callback
will avoid touching GX GDSC hardware.

Signed-off-by: Jagadeesh Kona <jagadeesh.kona@oss.qualcomm.com>
Signed-off-by: Taniya Das <taniya.das@oss.qualcomm.com>
---
 drivers/clk/qcom/gdsc.c | 22 ++++++++++++++++++++++
 drivers/clk/qcom/gdsc.h |  1 +
 2 files changed, 23 insertions(+)

diff --git a/drivers/clk/qcom/gdsc.c b/drivers/clk/qcom/gdsc.c
index 95aa071202455421d818171d04f95d15e2b581fa..ab5d741a2e2351bfac06a6814c5a8ba7355bc8bc 100644
--- a/drivers/clk/qcom/gdsc.c
+++ b/drivers/clk/qcom/gdsc.c
@@ -675,3 +675,25 @@ int gdsc_gx_do_nothing_enable(struct generic_pm_domain *domain)
 	return ret;
 }
 EXPORT_SYMBOL_GPL(gdsc_gx_do_nothing_enable);
+
+/*
+ * GX GDSC is a special power domain. Normally, its disable sequence
+ * is managed by the GMU firmware, and high level OS must not attempt
+ * to disable it. The only exception is during GMU recovery, where the
+ * GMU driver can set GenPD’s synced_poweroff flag to allow explicitly
+ * disable GX GDSC in hardware.
+ */
+int gdsc_gx_disable(struct generic_pm_domain *domain)
+{
+	struct gdsc *sc = domain_to_gdsc(domain);
+
+	if (domain->synced_poweroff)
+		return gdsc_disable(domain);
+
+	/* Remove parent-supply placed in enable */
+	if (sc->rsupply)
+		return regulator_disable(sc->rsupply);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(gdsc_gx_disable);
diff --git a/drivers/clk/qcom/gdsc.h b/drivers/clk/qcom/gdsc.h
index dd843e86c05b2f30e6d9e978681580016333839d..495daebaf99519ba0571070b41d133ee867c4fd3 100644
--- a/drivers/clk/qcom/gdsc.h
+++ b/drivers/clk/qcom/gdsc.h
@@ -88,6 +88,7 @@ int gdsc_register(struct gdsc_desc *desc, struct reset_controller_dev *,
 		  struct regmap *);
 void gdsc_unregister(struct gdsc_desc *desc);
 int gdsc_gx_do_nothing_enable(struct generic_pm_domain *domain);
+int gdsc_gx_disable(struct generic_pm_domain *domain);
 #else
 static inline int gdsc_register(struct gdsc_desc *desc,
 				struct reset_controller_dev *rcdev,

-- 
2.34.1

