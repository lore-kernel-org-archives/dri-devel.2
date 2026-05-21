Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD93ECD5BA4
	for <dri-devel@archiver.kernel.org>; Thu, 21 May 2026 08:37:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 05FF110F279;
	Thu, 21 May 2026 08:37:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="L/eaP3Me";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NkVa4L8n";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF6D910F279
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 08:37:17 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64L6Umwh2157481
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 08:37:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 GQi/2Sa2Ao4Qw8qIIsWmCidg4bHYCZ9URvi5VDdy2s0=; b=L/eaP3MeOWaUpNy6
 L81FH4QqV7eTsVlLcALgYeu3AEzESKyGvBjdCNPdLjd1PyF2SZVs3J5kZTQA76LG
 QAa47beiYQc9Iaw6z68RT6nfHwSlw1VWGCNvodnNl5e5mx98F/WQXUOooyAvfe41
 b3H9PAmUsIdKxVaoqWwTX+LLGAOwmbUEcGTU99iXRSUjA6qlWiUdnfQgGXUXA0/H
 Vwt3MFFN9p8ZoaDcqYEwJO0s1wJqUyu79HJCUM/WGg2ypLhk/ox6shunIfuY3U7q
 oQa3n9rDYxnEdqImbmWMSdsWdtVcy9xeO8cS+TWKP0DDwYt/liF/85jDISbCqOhP
 bmenKw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9ma428v2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 08:37:17 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-5162ee45a77so153543291cf.1
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 01:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779352636; x=1779957436;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=GQi/2Sa2Ao4Qw8qIIsWmCidg4bHYCZ9URvi5VDdy2s0=;
 b=NkVa4L8nfo/q4TmCao7ve+Alswp881m++zCOZfKtRyh2cK61JrNWNb0bX3kwzKnf4M
 UEIH9EAmxFF1JC742ebJM2NZbcmo6597gWGOcBpyNMfWDgGvgK3Qy/r/8rum4Zf2kL0z
 ePIfKI75LW6oP/mcPjd88bkxI559nBuWaNvZNpYo5KIH+PqpnoA2t1LWZMbEPLRbyyE1
 S1b0iowLAMTGsZ7/JiS7pucB2Cr+VgMUPio5NeAYupD4QCaSRgheF/luElkbkF11sHob
 fup7k8XIKHOm9+rXIRUFhRMfdBlX4hacflmH2M2jsckUuW18cA7J8nSHEaE88R4Jp/Tq
 x56Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779352636; x=1779957436;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=GQi/2Sa2Ao4Qw8qIIsWmCidg4bHYCZ9URvi5VDdy2s0=;
 b=jwQlVn/Ngh43haEDBBFIYFHfEPf+FC+m78ZnQc9rlEu6UTXKaICaOXBiRQBduCNWMb
 6l9hOE5/4smzQLHHc3CllQkJZ3wJIRsX2WMcvzzllg4fOD0X20PkiwG2da3xWb8VDU1V
 oE0J3N/hiUQd3RA3wjS1F/apwblPlMlH9kX+pCcxODfMIoBmnELWLbYMVgdvFlBDYPW8
 u5etbejDmzbhTTnxLYjvgY8bXD2g8PuthJIfNRTzn6UcfJSy/0V0dJoevQELgx04SFvc
 liMDWFy/xMgFTpTDltCZk1RylW516ojy2TKLwNynmAEEGstAv9XC9MkpJD2v6/kW62lG
 lB3w==
X-Forwarded-Encrypted: i=1;
 AFNElJ9yh6IGpef6LPTSfpq+Ikc5VsgraluLu3o+v+Nho8H+YiWpVQMSkDlcltxP2DgjeEhxx4tzHFL7qks=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzjxe3ZkFQj1KFrj6gSSYep9GIq/1TDOIe8IDzyZYKe5QPuyriD
 kpgBPl4QeeX1F1fHZc0F/G1U7+VAbWBKwUj7jjbOVo1kgTabu8GUdyU2/W/SDcgh4jER5Y3LEZt
 qJ7nJ+tAkoGvgapWoW2XBeqDszAq4Lk+MJxzSoIGzbS5CmiWT7pOjQFn57dM8476woRUeNi0=
X-Gm-Gg: Acq92OE/KDoqi1+T1QsaOS5A8oI8k/DD2w5QGs+RvOc5DgoE7+3sTpiP6rXaREAUfcM
 0QX0c0uBXWqB1+DEWbvU9o4BLw+ydXRcGor5yOoLatUyjc/th3qIdM4qDdpz1JDuAINTEWcYaw1
 THII6U569uIKLRz12ZXP2g96SgOxxwTe3Y+sooBW0vbUAX75EaZHAp38Geyu+0PiU7hS5juNmUz
 UNi86GPd8aQjej9lY2WIf2sXVsBqWxgnEKlgP9rbHN8QIQRlOsoDbFoiyRE/P3rGLu3WFa1K7tb
 uUrDH7tbmKI5uIgGTqBDHN/QQ+b/tOgNOIBSn4poLAJI+lRsjZipJ5IneN4w5Qd/8BtLBFUkJsZ
 etF1sEeVCPpenaOWD1P8+I8br/sBvUQBVKoNeHKogKdVKYH+SUvo=
X-Received: by 2002:a05:622a:130c:b0:50f:c109:b78 with SMTP id
 d75a77b69052e-516c56114c7mr25055671cf.60.1779352636302; 
 Thu, 21 May 2026 01:37:16 -0700 (PDT)
X-Received: by 2002:a05:622a:130c:b0:50f:c109:b78 with SMTP id
 d75a77b69052e-516c56114c7mr25055161cf.60.1779352635782; 
 Thu, 21 May 2026 01:37:15 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:bb10:ae82:b7c3:d15a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4903caede9fsm10502405e9.14.2026.05.21.01.37.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 01:37:15 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Thu, 21 May 2026 10:36:26 +0200
Subject: [PATCH 03/23] slimbus: qcom-ngd-ctrl: fix OF node refcount
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260521-pdev-fwnode-ref-v1-3-88c324a1b8d2@oss.qualcomm.com>
References: <20260521-pdev-fwnode-ref-v1-0-88c324a1b8d2@oss.qualcomm.com>
In-Reply-To: <20260521-pdev-fwnode-ref-v1-0-88c324a1b8d2@oss.qualcomm.com>
To: Lee Jones <lee@kernel.org>,
 Mark Brown <broonie@opensource.wolfsonmicro.com>,
 Thierry Reding <thierry.reding@avionic-design.de>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Srinivas Kandagatla <srini@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Vinod Koul <vkoul@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Danilo Krummrich <dakr@kernel.org>, Rob Herring <robh@kernel.org>,
 Saravana Kannan <saravanak@kernel.org>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 Andi Shyti <andi.shyti@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Doug Berger <opendmb@gmail.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Ulf Hansson <ulfh@kernel.org>, Frank Li <Frank.Li@nxp.com>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>,
 Matthew Brost <matthew.brost@intel.com>,
 =?utf-8?q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Peter Chen <peter.chen@kernel.org>,
 Paul Cercueil <paul@crapouillou.net>, Bin Liu <b-liu@ti.com>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Maximilian Luz <luzmaximilian@gmail.com>, Hans de Goede <hansg@kernel.org>,
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: brgl@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org,
 driver-core@lists.linux.dev, devicetree@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-i2c@vger.kernel.org,
 iommu@lists.linux.dev, linux-pm@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-usb@vger.kernel.org,
 linux-mips@vger.kernel.org, platform-driver-x86@vger.kernel.org,
 Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
 stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1268;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=kTQKbm6eRN9ag0Un2nZCXzTW7BV3akk7azahbn/UzJ4=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqDsQgIMxfR+Vbirqz0SdcKiFdhrIvHLFQpLiZ1
 CS8+oZRD2CJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCag7EIAAKCRAFnS7L/zaE
 w+/+D/0bfM9BBNs3PkNDjV3H97Mjk+BxEtuO3ngB9aYBqCWAj5QNlt01IhjpA6JnwDFP8fqCIyv
 vjkgxJM6sX4hv38HQ37w3/3e9w9nT1pEO8Z+vJO4ioacKerKf2Q0pDqYaIvMKRt/6v7PZ5F/8Qk
 F0oK3T58PSr3/oja0fGdyamleQyFBi3nxqx0i5pFUhtKOPDLB2JFMiF/Bc8z1Ao7b5/iH3mCRqw
 t4xceOWbqkCGcjrQwrwQuaQSwOFDgpuuNyxmj1LqEJaU/nDLivdr0K2cDU/9sLO5YhX1oEhG2nW
 XOO37zyMEA5NZH4QY0XDY91U+LIW+AczElBXOp5HW0hZ93FukF2Jykzc3pqr+4YnbKGcomK+0Yf
 q9nt12I/oL8N6u17VckldD5ZK4oqD6w1sf2nwZHj8W0dw1+L7YHzf9FRkrLonMvjMF8CzU8u+sy
 Jy0nFN5sFXOEVUkaOM7w5NUOXxfk7efn4VYU+BlGan6tS+++PJdEI8/oFCt6Y92Le98zlLOeLaN
 4okZNZe0VbOfsGZ7C8aYV/L5BdKwVRPIyxpJ3u3CgaMyWDH4U+OfUQIYpUzUcMflrUDECYMZMEr
 P5YYEoi2xgk/wmO4H3kPlxxCpOwXpXqfE9cRHoxk6WbFV0NB/WCqRqm8xGakOeDDaQ4wKiLTEBG
 Ah+8HIb4q9OvlZQ==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Authority-Analysis: v=2.4 cv=K9kS2SWI c=1 sm=1 tr=0 ts=6a0ec43d cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=lFaTzyIiLygvDfm8gxsA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: wa31PFSqiren9s-DGn5gnqLKakHNe45M
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDA4MyBTYWx0ZWRfX7KdoNjB2H9wm
 QZMQG6qbLyluXk0MRNU/KM1pdJwmLM0RMT1qVSZ3FJHRdpcBB0LadH73n2jHwnzfdpdg179UITy
 DSWKcq5a5I0s+I93Argnr8mZbBPI5qGa4IzKqvjQBvv37kGS/qRE8mRu3LjuI7gmz/f2zY8qtD8
 s4hG4QyF5cLbT4Bbofw+2dcYWVAwEI2B1rX/Unz0qzoF+sFJzEBPAHesprM2lbwl+XE6mmhLJax
 1nh69kIsfQvaMkDyLYHOKSndkXH7U+ygHGxH7zckdUq8FVWWTOPUuUOb0KxXhtPwOPfltTxF0Pe
 Y1F5KVT3lBqx3yTXzo65UejwIqfyH12S+d5Hfn9dtzd7AXApVksWjBMSnRcV/oaDPqeX2qvmbK7
 wKElM4XyiqFQZv1ifgAKakURCqW6T+Ul8SPsq8BhOOTNNlDssqmd/yG6/zHyhH6fuGwNbjKlgjU
 +dMd1A+eikDVtCVW7kA==
X-Proofpoint-ORIG-GUID: wa31PFSqiren9s-DGn5gnqLKakHNe45M
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_01,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 bulkscore=0 adultscore=0 priorityscore=1501
 impostorscore=0 malwarescore=0 spamscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605210083
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

Platform devices created with platform_device_alloc() call
platform_device_release() when the last reference to the device's
kobject is dropped. This function calls of_node_put() unconditionally.
This works fine for devices created with platform_device_register_full()
but users of the split approach (platform_device_alloc() +
platform_device_add()) must bump the reference of the of_node they
assign manually. Add the missing call to of_node_get().

Cc: stable@vger.kernel.org
Fixes: 917809e2280b ("slimbus: ngd: Add qcom SLIMBus NGD driver")
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/slimbus/qcom-ngd-ctrl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/slimbus/qcom-ngd-ctrl.c b/drivers/slimbus/qcom-ngd-ctrl.c
index 1ed6be6e85d2cfc0a2b65a5ae24f666de922c89d..428266949fdd07ac13c5553bded891225c6e1a16 100644
--- a/drivers/slimbus/qcom-ngd-ctrl.c
+++ b/drivers/slimbus/qcom-ngd-ctrl.c
@@ -1542,7 +1542,7 @@ static int of_qcom_slim_ngd_register(struct device *parent,
 			kfree(ngd);
 			return ret;
 		}
-		ngd->pdev->dev.of_node = node;
+		ngd->pdev->dev.of_node = of_node_get(node);
 		ctrl->ngd = ngd;
 
 		ret = platform_device_add(ngd->pdev);

-- 
2.47.3

