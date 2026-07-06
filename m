Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5517BC43602
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 12:45:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A982010E969;
	Mon,  6 Jul 2026 12:45:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="JFClRWJO";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JeSlwAWH";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0439010E969
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 12:45:49 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 666AxPKK174990
 for <dri-devel@lists.freedesktop.org>; Mon, 6 Jul 2026 12:45:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 yNrkEZw0kMBOjM8rF7wKaiZMIgE91+zaRIL+Y+aqlVA=; b=JFClRWJO/YlvKXxt
 EPTan7Bb2wCcvP3ljtvtZjzTtxn9X/oJo2TEJ/HAmb+pQSKwSEV/Z0gNUsAg+HGp
 w6HgyrZUxnRD3q+7IWfDH5X62RGexHSNLTGzOUeq2dL2LoPSNk6QlXIjpQSF+Md5
 flrFBt6s2fKpQdszOkYGsCYuJQ5ovRF9aZdMY9Ly4KS9iJsfekBq0woUOh8k3cMV
 /RkmkqR4WcSAqZVtsYNjEqAk0a4iS4q0boV4t8SF1Q5kKlnTaNhLXh+6stEhQhqA
 eEHt6s2fdNhYEpAikHChcGddJF0Bgf8WoJVvm1/XIKUhDGVcw0Vt2kksgIYSgQFG
 fOJZIQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f87rxs9c1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 06 Jul 2026 12:45:49 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-92e82060977so311805485a.1
 for <dri-devel@lists.freedesktop.org>; Mon, 06 Jul 2026 05:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783341948; x=1783946748;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=yNrkEZw0kMBOjM8rF7wKaiZMIgE91+zaRIL+Y+aqlVA=;
 b=JeSlwAWHbdeeuIcnb+4GU2GweNx+qH4RA6CZLIWCY9eEnHXmNil4AYnBHSJGLCUqNq
 OXdUAHC8MsAhZ+zXKwr1eK2x7H6DqsiyODef++GkEaLNVHrMXAQOVJ7dY86bb3YHSnAk
 Ix0bV/bltLO6i2EyjUfcbRHJo++F7CwATZ+8tivuvak+QwrT8DcCUId/BoGM0S5Jq4jI
 5MqexlyU203vbRzo/Jom+3Wa/oZufHvpu7OHJ+/rDN40hI5toBwKlM/oiV1YxDSE42X8
 GiXsFauMnAHwP3hfwu4as5DnsiwJBT/+5GpMOscXkwFm9NFdtiwB0hzXyVMC1IlsyfxG
 ixmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783341948; x=1783946748;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=yNrkEZw0kMBOjM8rF7wKaiZMIgE91+zaRIL+Y+aqlVA=;
 b=nKfaB59WOjVOhmdtWNsJVCA3MTe2ednlMLr2scM185yfhroYery3npWWWaPUdkjtbe
 iH9p4N7pLimqLl6fFXrcoe/9WiuE57HgtstnPHSxSm9alzNeJd+GJz56MRH1J5qRyMmn
 Ww3L1dAFtiv6vo+2zyq0bq8NNgS00n7Utvydj0S5ivTjr/GIfDgLOP2j3OeofSr9aNcY
 Q+LPkGgAQEOIrg6BxgYS2RLLrAFCqx7dFfU0WV2jrpbqrcKNowU3wEGD2iKB1lQD1D5m
 KOPnJzgUsZ16L9xTHnOriold0aNebaS6qkK/MzTXiXsbZaGJLl29mHHtLCIZKD0iYwsP
 p9lQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RoqMypRMErOWk9aS7stIAVwW5V46ptLXiBYLn/nANtHKZxv6MCX59aEqGpSe6zpJgFAVkGXJHXoWMQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyC34PqZ6QaHzoImBOzI3r9papsiBu8IgnGN0wQ8toixrUhAROP
 IzzYIW4amJzRa8C4e/9HJRqW4S6gkA3P9MNpDCg/bZE+II9Yafq3720Yok1o7TT2WjFZF0M1jVU
 cgiFja4DnuZ70UVSemmxSikacW3JFzJkjSkko2qZRZeDubhmWTP88Uhh0IjtolAUAGxP9uqk=
X-Gm-Gg: AfdE7cm8AbAkzcWcth33anjb5XdvzsSjU0M6pstaooMGdtnRA0ODfI9xowdGU9iHLI2
 aVWBRDV6mEH7vnfBTbvNLjtIMvYRH5RgmZxevxFf8MxleqPkmUq/PyiehbNsDObhp1QghbzI4UX
 6FBcHzvlXDAxJ3v0gTPSJArOZibO2IfQSWejl/9fDO9Cj+pQSUY1RULK3FMbotE+OTeeDMupLiR
 IC5d8wN9DiFRzoVldX4N2jHuAV4XC24BL6br/YARGmljXDqLsADXKanKRzJ3Y+Cmssdxjk19hRm
 j6zpveHb48HoL5756DHldd9XgJ5pCNX9/Us+2aOOTnz3/e1LDQApI0Wcw5r8Iel2AZDVIrOJPvG
 RfhYEEu2JPbd5tIsXphwHS1L/mHwFvZaFGYnSErlQ
X-Received: by 2002:a05:620a:4554:b0:92a:f74f:904 with SMTP id
 af79cd13be357-92e8b25f4aemr1773314285a.1.1783341948380; 
 Mon, 06 Jul 2026 05:45:48 -0700 (PDT)
X-Received: by 2002:a05:620a:4554:b0:92a:f74f:904 with SMTP id
 af79cd13be357-92e8b25f4aemr1773301685a.1.1783341947497; 
 Mon, 06 Jul 2026 05:45:47 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:86f0:c42b:ef4c:d3bb])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47aa0a55be4sm22126539f8f.31.2026.07.06.05.45.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 05:45:46 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 06 Jul 2026 14:44:31 +0200
Subject: [PATCH v3 19/20] reset: rzg2l: use
 platform_device_set_of_node_from_dev()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260706-pdev-fwnode-ref-v3-19-1ff028e33779@oss.qualcomm.com>
References: <20260706-pdev-fwnode-ref-v3-0-1ff028e33779@oss.qualcomm.com>
In-Reply-To: <20260706-pdev-fwnode-ref-v3-0-1ff028e33779@oss.qualcomm.com>
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
 mfd@lists.linux.dev,
 Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1119;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=HEn5owEzeJIUYkdvn4DQSoUKQdn9M8eLHqPgfVbyGMo=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqS6M9kHSk63/qP+xgNz2Y9PQyDSmFph3tQ8AC4
 5AtD4YK+kuJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCakujPQAKCRAFnS7L/zaE
 w8S6D/wMyo30+5v8CLZilNJ79Z7wMDPBUG9sj14/UZP5eZoRp91qLsVzwolPCsq5U/qTKR3y/WF
 pZFakCrbpsJGqVqsKttIhxt2XpF4S1KfN1qC8pASBve+FNz8ZyKWhKOa9yoA01qpm32vrU5UPS/
 6u2lJxL4o4/rLQx8CT4xqgdtrSqHYMAonkNf5DACLGhTdz4ZNLZuCIo8GsF2zwWIH+cAxzjYd3E
 qqZHOI8wr8R2KnXC7H+MD0fJGcu5uQ+1j45nmYvg5cX3ElUN9riw6pLBLgO57aJVoCo/ucH6xOK
 GI4rJ/08Hr3PNBYdbcQEJMNE9yYMkjxiudHvOq8R4g0BwEVtdO1A8jbTcho0IUz53pA59iFnjyM
 ttMlMjXQhKSGu1dFNK6/elGJLMXC6E4nbUKvbby/LEHyHwLU0algPpHe9UPUYh3l/DrQAUt0udl
 +zNN2SMUOdAze/pIW2+l5sftft9+laItqGcD5M5bJTp7tPjVFcDskDf/PioUl0vtokzCPuP1F3s
 zP1G38H9ILdgjRhYpMdqqolRWhSDfehH//GwZSZfc6zSynuMNLzcAlJbgXUXpTthmlBlksAjYqr
 pTM9O9ZbxdBxzavLzPTTt8/695EpXxnwsMZ87oi6uApZGTqb0upieRcXVikiyju4bpSHudD6VYO
 /G0MaTqKJntCfNg==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-ORIG-GUID: _BydWa_e5ct63aX6ZYvqHs12MbZh54bL
X-Authority-Analysis: v=2.4 cv=Hv1G3UTS c=1 sm=1 tr=0 ts=6a4ba37d cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=QyXUC8HyAAAA:8
 a=EUspDBNiAAAA:8 a=kq0kPlqncbyAjjsh9XUA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDEyOSBTYWx0ZWRfX7SYy/E2V3eWv
 y0Ob6nGcIr0xStMRQjC6eIU6+edAUex6LqT8hyPBIGgHT8yip5e5z77/Z3dvfGjAo4P34o7/yZu
 3Fg1uI4JqOwdRqQR5b6pAPZGTR/GaGc=
X-Proofpoint-GUID: _BydWa_e5ct63aX6ZYvqHs12MbZh54bL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDEyOSBTYWx0ZWRfXw6J8iVY+LKVd
 FQmleDtRTTmiOLYM14t/UO63xcpG2oQM+oyuiEDvWsbm2dIT9xdrWXDlQf+V2z80zom943AhMo9
 wLZbTOWfGnYRYyBhfaL3tacVJlWlb+r8HWEO2Pp1MQCyQvx1lfSBnKUCRSWOOm4OW5C+cU4XAFV
 du9nmukjOn2FUKi0hP6JyJNjqI6FlubTPJ//atOpslu75t7sC7MoJGQR7AB2JfhelJZamaDf0xH
 Tt810/c0Xs5ZBCGx4SazCMcdSFnI2aXPGsXO4wlPfm+NT00VAi1NFUsTVGLFapnQ6cv5CmO+EAV
 WHiUzIEKQUj2P6jK3xgnTd7hwMjOXBwojyi4D3kd84DeuCeyDhqaplYzJHpUEZomOgo76EJGHaS
 uzdR40RlJYKzlPjAo4xA6ABcD/ajqMPWVKnAsX61T1JEksPCbKSTnTlUcQ4Lv/Qj+X856ZCzAhQ
 ItfoU6WlfMSrZjBcL3g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_01,2026-07-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 spamscore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060129
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
encapsulate the assignment of the OF node from another device for
dynamically allocated platform devices with the provided helper.

Acked-by: Philipp Zabel <p.zabel@pengutronix.de>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/reset/reset-rzg2l-usbphy-ctrl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/reset/reset-rzg2l-usbphy-ctrl.c b/drivers/reset/reset-rzg2l-usbphy-ctrl.c
index fd75d9601a3bfde7b7e3f6db287ec8c5c45a20ab..f003b360629c90bb37ed0ade7a675b5b0f28fa7e 100644
--- a/drivers/reset/reset-rzg2l-usbphy-ctrl.c
+++ b/drivers/reset/reset-rzg2l-usbphy-ctrl.c
@@ -249,7 +249,7 @@ static int rzg2l_usbphy_ctrl_probe(struct platform_device *pdev)
 	vdev->dev.parent = dev;
 	priv->vdev = vdev;
 
-	device_set_of_node_from_dev(&vdev->dev, dev);
+	platform_device_set_of_node_from_dev(vdev, dev);
 	error = platform_device_add(vdev);
 	if (error)
 		goto err_device_put;

-- 
2.47.3

