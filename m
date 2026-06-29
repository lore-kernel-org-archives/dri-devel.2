Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F653C43458
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 09:13:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC87910E7C2;
	Mon, 29 Jun 2026 09:13:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="jwWIPkqU";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="E+bxsEXZ";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0946F10E7AC
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 09:13:38 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65T6qwf32076271
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 09:13:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 NuAGmXhaYagKEsijNwanCl2DU/uS1mMyuthIapbtuKU=; b=jwWIPkqUfbIHUw4h
 qxXbw5MdhJ7tU5kAgvYT1xcyQD+B+MVZHIunycRmvl0cEsDfMzPPmmnNY48Ad3xm
 ZGBZEropJlIWYP5tX45jciHeyvSG9KJhhJdCEzNBBRNprWleIidgiUf2qq8ff8dM
 kvhFKuGq3RtjOnh643ig1kYJscniNaflHGpGwVuYOmU3POpqQ/6Tt9D9I0x/rHPE
 0CsoOG4YAVao7+vBDic3flhV9alXhJDUWz42OITy2PJgaGwlbFEXuC64Z7AFr701
 XmoIgFjrtmInhE93fUYcHj8QA6C6b4fqRcgqtRc1TCgMdtpu+5eZns7NlOENWCZQ
 MzmyZA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3kp7gkpf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 09:13:37 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-92b2ccd78a4so205985985a.3
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 02:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782724416; x=1783329216;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=NuAGmXhaYagKEsijNwanCl2DU/uS1mMyuthIapbtuKU=;
 b=E+bxsEXZs4jHBGzvmhhEjKxJSWKbb0Cf5fAy1Q/xnRkUBJlC92jTJ+Y0H8NsWlmfLx
 qNaRjLt7afEOFJmvRWtQ4haDQYPhN6l3ugKywlhIKA4WvYgGNYtIiyLuyDSHE3J4OyZa
 oQ+7azgcxK/p63eTkJl4JT+VbYaYtW4kToNbDkGYUWijjedgZVYHFE1KOX1xcmU62Hlt
 Mptqpd5eZeRp7EMdsFiwif81kCuEWZxfOG4+Rzke2+Q4kRiVTrJzIJpLZuEZX/k7rlKn
 Fa15wz8EnBqMQBZ0XwDLR+zsH5OPk99Aal6xAblKRtIv0EP7vOlsOaezKBfRrZgetD8Z
 dIZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782724416; x=1783329216;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=NuAGmXhaYagKEsijNwanCl2DU/uS1mMyuthIapbtuKU=;
 b=LnXCc/e2/hj1vOugEOcb0M/HBwOilOvGEbcm6Ra68ju+I1lhGEfMin+x4J0w2Tf7T2
 CEZDh/gaYVUBONZqImOX5OFh/eR0eXFa8CzUhetPbK0zjFsHM7HfomFtNt/oO3ilsnOU
 WcP7tD1b4Y1cakExDwnnVXzHRS5ELjkGDNErQhuBBYaXRO/skzUJw7K+H2L+jF03Z9+R
 aoB/MqBU5UKjFeKKs7KYXjNJa8831LLAObZklV14ofyTUgEUC+d+XQL3/HjWQi7aGLgF
 ISsoZW+RPxCB+RmcYRqRIP64Ync/PLIDlvU1GamchLiiRF9EMlv0EEgXp8cUVmrgN0g0
 n6hQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/SqOXCO59rvT7qAS8ZEK2GMVzphrNb++AvzuoEITCLDdA2jhODud6C/fGjOZgugd1AzeG7lsjIU6M=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx/l51kySg4rzbJ/Tdq/OiNuMX/YmqPRYo5RF5nYQ5BedmpJ/MV
 nr/+4ephClbqWfmgOBjxHUwD5UcpXZ4MnmZ/n3tyQ0RXCxOpIXlRQcdyQZTrs+W7BvuBw+GNpqO
 uEIsXufoNRV53WJ8NqoaKf9tnQ8oKizXIfOnRJDfnUjW3gNTps8/ISGKBIirk1Jr67T/QD9s=
X-Gm-Gg: AfdE7cn34UPWTwLxFZ1x9ZhNtknlE3OqkcYcqrRguG+QMpbh55MzIBTTAhwp4rTR5ks
 PzGKowb/d8X60oFkc43hhq7MNfwD34TaPSzz+eJKITb7RTpAWZ4tm+vyBYfpd4lY9Ku5g/1fXv/
 Ov1BWxP0i/yAb2yU/QMPoDhzoaluI38UJ77+fPqTP88qPLyb4HPlFqCf/SwwZ4sDhvXuFTnl1eY
 BroLJuX8jdefZnRR3137I53YDDHmJboRqFqJaSyKKInCa6Eo366oUAD6LNTwqo3UxH2Ik+T/jr6
 XEUXBSSENKaQb+x3ys9mIzIHfcftG3hOqvNcsA6DX4YmKHRkUw8PE7SPf72ey3/cg6gAn9IpSwK
 dsNXiCbV7JKK6Xe+PjcdOHHnaseKw4adj/g15NxzD
X-Received: by 2002:a05:620a:414c:b0:92e:51ee:7945 with SMTP id
 af79cd13be357-92e51ee8ae6mr323651085a.30.1782724415963; 
 Mon, 29 Jun 2026 02:13:35 -0700 (PDT)
X-Received: by 2002:a05:620a:414c:b0:92e:51ee:7945 with SMTP id
 af79cd13be357-92e51ee8ae6mr323643585a.30.1782724415437; 
 Mon, 29 Jun 2026 02:13:35 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:4640:d76a:6126:9b65])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-470f55acda0sm20109240f8f.23.2026.06.29.02.13.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 02:13:34 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 29 Jun 2026 11:12:35 +0200
Subject: [PATCH v2 12/19] slimbus: qcom-ngd-ctrl: use
 platform_device_set_of_node()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-pdev-fwnode-ref-v2-12-8abe2513f96e@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=914;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=LAw6TP+//tnDWpTcxlgUU+E8OF1oyUbi54CbVTPa5rk=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqQjcRvVGm0XjHzeekMWgCSmedmQdOuB32YFAod
 HQ6XNyVL0OJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCakI3EQAKCRAFnS7L/zaE
 wxVHEACqOwp3yO7AptcceX8k/naLnlKxs+wmgitoHHSTRNa8FE8HkJ7lYPPwAwc8lovQLX9q05Q
 6hcHOe4n4CZQbTxN15/qEZ87njRex4lLYPQZ0AuWZzlrx6rr4WQIRBarM875qSv95m5BL7AR3Du
 ENPTAKbTTX+n+C25UiY+ayBKtWsSGo+kpsjN3X3Z05TthGI8MH1cQqBtpCXwLDDDxk5ZJE+28wk
 Nxr04r/bKCTmFTKcAOLeZwe+n7OBQJiULX5aNGFND2NKf6gYXCLrX9uSvrOFKGgahmbtYUFZVrS
 aMQrMchr3DV0mRgFYqENcBrCgGeMZt6rZXDuQ2/lDEmpFrJ3JHsNtYzXygqcuHVQ31BjA2JQ+DH
 nrcD2BYjuGhGKUV7Wzayp9U1n/q6PJkAxKuVsOJx/jGmJeJsjfbNnyBY2f6dS7cDV583Hw7Z/tx
 6SzHZBOe8r5iHFsTvsP/CvjXUetP8B08c9s0WkwKNh5vrqHQt9jegjzDY6LZM8GsreGmq/SMB3e
 eED8xB8DcdpxLmveQkgTC7u5QBiF4N77Q3Uk9jZ9zLfJLSJF9y0iwK1d98Kp26FrAvtSsukjHkf
 /3kIw6Q5xTb/Yzc7/yv3Ccc1iUgJCOfnZ0rWZVZ+0ggxeXJ0kK2eg4UsUY7GtJTRNPzxT/PdftH
 otsBKzVctyCmwZQ==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDA3NCBTYWx0ZWRfX4kJYieCLS7y4
 imCcG9z8ksY/2uLLH6auWtF4vTRUjPBlZaufJRTuRrrOP7Thf9ZeuPYI4cN++KCGt7lDu14Cowb
 xdGz6RMy1vbi7uOLNNqvZkWCsRkfARA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDA3NCBTYWx0ZWRfXzgRgmQ6WqUJG
 3aOmZxWc7vF34pUjSUmbwFZjoyZXY5T6WT1Gex3UfpDecECRTkevLvp0/nz9j0R3wuyhkKQuuq7
 L9KjcCMdrg38Wn9r4JvefY6IARwu3hkrJ5J/5ika1V2wt2xN94QaDnoJg5Rv/buKywTqPICRr4P
 J5lKDGHMbZ/h6Qno+kDYefXGUUjKv4a1afxq0urXJ3CclGmIq94Ko38CPlocDtdn1Eg29RU5SIf
 78Icy/L1KTwkya3cDtcZAXOqliEi38caXAESOGKACHxHLgVHGHkfFieEpAFN8oDAnpNNjz4ygLs
 pxMfT7+BS+UgItXFc6gKnhuWBBtTExmLShK/8xXmjjxo9Ls54AKVx5uTiq7R8gUTHWy8d6zD9sE
 3zUfnbIjerSnReigGcL3vgxDTNx1hGIIrX2l8RQMDj6EQkIj56Eij8BQu7lgPCvLedUcY9iSB3L
 YTMJqen3LZue7i/z8oA==
X-Proofpoint-ORIG-GUID: PKSIs0Zv7CSnj73uHfY4Vyv_BsuYkCns
X-Authority-Analysis: v=2.4 cv=MZJcfZ/f c=1 sm=1 tr=0 ts=6a423741 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=gD7B2NV2fXQl33RD-VUA:9 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: PKSIs0Zv7CSnj73uHfY4Vyv_BsuYkCns
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 clxscore=1015 phishscore=0
 bulkscore=0 impostorscore=0 spamscore=0 suspectscore=0 malwarescore=0
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

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/slimbus/qcom-ngd-ctrl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/slimbus/qcom-ngd-ctrl.c b/drivers/slimbus/qcom-ngd-ctrl.c
index 3071e46d03beaaae2321e858c564b512c22e820e..6e89415712ce1a7a7781af6bd0eaf0d6879da52b 100644
--- a/drivers/slimbus/qcom-ngd-ctrl.c
+++ b/drivers/slimbus/qcom-ngd-ctrl.c
@@ -1539,7 +1539,7 @@ static int of_qcom_slim_ngd_register(struct device *parent,
 			kfree(ngd);
 			return ret;
 		}
-		ngd->pdev->dev.of_node = of_node_get(node);
+		platform_device_set_of_node(ngd->pdev, node);
 		ctrl->ngd = ngd;
 
 		ret = platform_device_add(ngd->pdev);

-- 
2.47.3

