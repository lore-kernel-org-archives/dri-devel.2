Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B865AC43638
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 09:13:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E55C10E7C4;
	Mon, 29 Jun 2026 09:13:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZRkU2/i6";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ByvI6cdt";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC92110E7B9
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 09:13:25 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65T8xlts2432045
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 09:13:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Swniq0MBenDJhWYnVlOO2+dPpUehCeG1RuSAo0j0sss=; b=ZRkU2/i6fztwnJdk
 7IO5FhpTQ9uELV5xMf2kx5yhTQ4SiES76kt6TMus91P7INzavkTPnFtvNcYr9F+y
 hXChLcOUvW6s3m2DDZjW9UWjvy3K+ead5t9C6gutcbXfnTfI7W6oq7FVO2oBcLnr
 5gipdQMoxdrM8rezokLUep+IfzqoHQJQNG30X00ezlWzwZOCNKm0GIG1r6aas3GM
 tSG8pTBpPdKC4xp5euE1xjvwFwb9gx8rHOjds53y575heHceSydkD9S4WKEmji13
 vkYcHHPGXB215VYUTPnnFMxkxMRf6vqfGRZ1NyWvISeRKF3ehf7Ne+UvH9l8D82/
 Aq2mXw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3nper231-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 09:13:25 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-92e538afe65so97956485a.3
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 02:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782724404; x=1783329204;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Swniq0MBenDJhWYnVlOO2+dPpUehCeG1RuSAo0j0sss=;
 b=ByvI6cdtPWv6CjAHnvtOw9BG9z3lT/X6MUsw9AHHoEPhgUff2twtMGO0PGqb8pp1b9
 HPyslwOLEIErPvHKRfjcRZOzrpdOOMXhZsBvzzsVRvns334PdNQ1YOJqY0sPK2jGgL5j
 Ur5hMbf+pCNCDC4tarNhyuJrXgYpur5hpF/Mxo8XempRgh1Rn52WTfOF7C1MT8k4rkGk
 aU9YcKl0ZFJQYNMrJp/GaY19hdUfilrxcOhomBGpogNbaia+5Z39uXyTeGiTTOZISs6t
 CBQbjZyhBgViR77ZJIot1URnhiyt65pFLRnvOKen6U6YGIRZoFUV/oeYBv4As/owIvP+
 UsHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782724404; x=1783329204;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Swniq0MBenDJhWYnVlOO2+dPpUehCeG1RuSAo0j0sss=;
 b=kTL2ptZC2OWl10VZRrQTQ8IYhWHKipAU9EMIyql522SZLuv/CuNQE7AYZkcg9yHlQo
 0iM0DMRPWhJj6m1GBgD1J5nfuTE5B3PbRd2K0TiwZww1LbS+iClK4TLppzNV6iMOPv3J
 0oMoDMNPsMVlIsnH2iqqq1Kl6EHDs3HNnc/U4Js981BG1V+MaGPTSHUXzdHZRNbESwbA
 4cRegjzIFEmSah2OTtOVuEenSZCX7Gg1YCOSwEbs9VWYqGB84Ta14kBvbbjjgdi5jwcb
 5FD2QHlsaz/HtbmlDaXSCkArmxdp5QYo8OW4o1AgCxldFpFQtfaWw/JByp1kcHK3R1xV
 2uig==
X-Forwarded-Encrypted: i=1;
 AFNElJ8NBw+j9sg/Zb4BerYg1urSwBHNooZV6RdMmR6G9GaOcAbKplREGs8oEpmoWc1PNYi+5kXg0AJ7Msk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YximbWsJ8Emen0zbpb3vhoeAmoqeWA7A39UiC2KKmLo7fDX+WaV
 gPHzNPuHlkLVIJLWhUc7oYEc1ra8LIGXfHrfuP8UvYpGa9ww/vEVHmC8uRnxZVBj9cTRqFhpcA4
 wxdoAwrt5A/DqNFKBd7SUjH+REX2+bSosUylyGeCQ0LYshfoVZIHN96gkqFnqEc6+2PqAa6s=
X-Gm-Gg: AfdE7cnnrwRj9wTI2C3wXtvaMCRcahapKpu4gSeBrCfDmLn32mcrp39yoLjuw+ziY2V
 QPQdNqyGpvGIemuvtYBEwgmuxv5KED/cM5+/EXzqiOhCvXDG5ALR9LtN69TGXdSzJ91kZR5r7/t
 VsP8gjQ6StS8We9jOzUayEm+yiD+zQsYcAlBfO6kGSk9QQ842+oeRg5VKCwCOAZPtbLwP/u2Dtk
 ah3VDR6El8cJrrJtSlENP+XpT1MHmgn6wLmyNaVaXg0hF1fCcv3TcArzcPR3uJhM/Xn43qs7wqh
 y4F+QzZSp+nwnUuYoToB9CV/qzIk+r0NjlVs6Jz16iJWqtSAXN2tNO696+Fio4v+bCdBILrlNu7
 PkG9A6nkjj4ohunzq0BQfc16tRGv0h6oD6ePf2SqA
X-Received: by 2002:a05:620a:460e:b0:915:9531:f6cd with SMTP id
 af79cd13be357-9293a8a7a96mr2397204885a.13.1782724403845; 
 Mon, 29 Jun 2026 02:13:23 -0700 (PDT)
X-Received: by 2002:a05:620a:460e:b0:915:9531:f6cd with SMTP id
 af79cd13be357-9293a8a7a96mr2397196785a.13.1782724403205; 
 Mon, 29 Jun 2026 02:13:23 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:4640:d76a:6126:9b65])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-470f55acda0sm20109240f8f.23.2026.06.29.02.13.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 02:13:22 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 29 Jun 2026 11:12:31 +0200
Subject: [PATCH v2 08/19] iommu/fsl: use platform_device_set_of_node()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-pdev-fwnode-ref-v2-8-8abe2513f96e@oss.qualcomm.com>
References: <20260629-pdev-fwnode-ref-v2-0-8abe2513f96e@oss.qualcomm.com>
In-Reply-To: <20260629-pdev-fwnode-ref-v2-0-8abe2513f96e@oss.qualcomm.com>
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
 Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1161;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=5iHC62z666s2H9eOZNtsPvlVYHni/Q1SrUqHlSvR4Ww=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqQjcOXpcB2m04XoCsH72/+KXlLVT1Hrj1vwgy/
 IOc5Wf6f7OJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCakI3DgAKCRAFnS7L/zaE
 w43hD/wPlfZOsocHfKTUFsVJhcDF/ETQMNn/4hId9+RMm6T5ZHp69jSRbog5lNfYaqdEh1EET2S
 RDT2B/TdHfj1jeOim/f+DCxKuqp+akBTwoUGXVrN3GvF0ycylarCrN3P99JWiNywZlYYQrFzJmr
 KQnPasd8rXu4GeV0CQlnvJVSdFHEQnE2w91jOXC/OSoOzKyKLqx41JbtE1bQ7WizVboKLTgiMqP
 k1F32lmXmQz8z5OapVRLcm1pihRAim05SSxNWw2kP+6WrJp7yvr5HjtoqWqLAs0E+qHIF/fTusy
 77hz1jMmBNdYDVFcY+6HeGk5fS3LRhNUG55iglR9yJgJFWJLD4ztoxnXNFX2PkOUTi4D8wjerqO
 IvzdipUwAdISu3EM4lXnJV4ppWIHkoBn2hTjtscnm98Tub/1JL3eBhORloIqnIr+ij3hobQwQZA
 zwFmWokXMqXAIZROVuupPTypgGm5NHPS1mj01vVz/fwLKzkEv+25rmetZTox3yUMovtH/ylTNrU
 Us0ZPcuG26Lgh1w5uDYYCe58zBPBbDNehNRiOAwx17NTAOQMM5X5kt+Yk6xDEFU5rV2hlkpXNdG
 QBT4jo8Ybny2dJZvwR4MRhs/vr/nkp5lKNgLQ1QDzI5cFXGvKR8BhAi7jATxQ3PubomQVlgL0oP
 3SR64eGHBbnk/mA==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDA3NCBTYWx0ZWRfX1ZBN0zCVoFSW
 dN/hLDCVdNmGGAIg3jfYHH2tN/EpKAf+UZZ7yfnXcCyxMxjL9zWmV+nQWG7jv8BQb2Z6NYN5LHj
 5GaHgoM6NunETURplk8yah2TXDM5/L9RavMkALe0e3rHVbCuIbCNGpFryPHiJuGEp9CQUyLX7D+
 bIO5EaGoEIC3k5Qqf69yZYGPSymSaaUmjLtVXfTfybG1CS4sMy5xSn1JWOCWYNPHH77ea7SeUwh
 UuPvh/Lw/AiqVvR4WXJC/hEDBYzmsbwDULiTHd7VxhCOMyR59Z5PemvPpCzyiSn47iFXpAho6Fx
 A3jk0xUIWx7LNmY47PKJ8TVMglrZ/EaWJm61mSP9+EN/COx4SH9uODyOmqGT8R4yY5EouR/cL9I
 HbtBvZzQPm3jGPBX7ZTaiwGpaCLpyWWx+B6EwrZBAIQ6+jyiq6Wjo0mZrT7Y7h3mvpkUDxuUIQu
 Pm4UIcUKUEi8W3xnHCg==
X-Proofpoint-ORIG-GUID: LIOg4xN0pm0vKYpnq5729xDWSA3L_kdx
X-Authority-Analysis: v=2.4 cv=T6q8ifKQ c=1 sm=1 tr=0 ts=6a423735 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=7CQSdrXTAAAA:8
 a=EUspDBNiAAAA:8 a=3F0hfycR0bi-GMcrnTkA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDA3NCBTYWx0ZWRfX9+WFEISTUbnC
 Ir4gK6Wl97kT1fL6Gdr34TrZizZ52+7pFAgtcFQ3xyJglAhy3BEKp68j3Anh4w1Dqhvj2CjCCC7
 g7jqIB/vZzhWydmwAaeOEixI3YvhuRU=
X-Proofpoint-GUID: LIOg4xN0pm0vKYpnq5729xDWSA3L_kdx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 suspectscore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 malwarescore=0 impostorscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290074
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

Ahead of reworking the reference counting logic for platform devices,
encapsulate the assignment of the OF node for dynamically allocated
platform devices with the provided helper.

Acked-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/iommu/fsl_pamu.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/fsl_pamu.c b/drivers/iommu/fsl_pamu.c
index 25aa477a95a95cb4fa4e132727cde0a936750ee2..012839fa0d8a27cafc6a441373f4f6da794388c1 100644
--- a/drivers/iommu/fsl_pamu.c
+++ b/drivers/iommu/fsl_pamu.c
@@ -973,7 +973,8 @@ static __init int fsl_pamu_init(void)
 		ret = -ENOMEM;
 		goto error_device_alloc;
 	}
-	pdev->dev.of_node = of_node_get(np);
+
+	platform_device_set_of_node(pdev, np);
 
 	ret = pamu_domain_init();
 	if (ret)
@@ -985,12 +986,10 @@ static __init int fsl_pamu_init(void)
 		goto error_device_add;
 	}
 
+	of_node_put(np);
 	return 0;
 
 error_device_add:
-	of_node_put(pdev->dev.of_node);
-	pdev->dev.of_node = NULL;
-
 	platform_device_put(pdev);
 
 error_device_alloc:

-- 
2.47.3

