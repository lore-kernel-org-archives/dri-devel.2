Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BECA7CD5BA4
	for <dri-devel@archiver.kernel.org>; Thu, 21 May 2026 08:37:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE64710F287;
	Thu, 21 May 2026 08:37:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="YalB4pHJ";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="W2HccIh8";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8CAF810F283
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 08:37:45 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64L7M9KL118986
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 08:37:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 9A2tU7W24wHfGN4B/qiO8RCtMLc7lIw3uVlzGKe1klw=; b=YalB4pHJpzpglVnr
 oLK/FB8peejpgKNYZsuGUsLbEL1xet26NbmiQzQ3XGxYG3KZSEiPToDswLtDVh7L
 dqIL2nKHwSLQL1lI0DVaSn9+ydVafD6rhYBH85aCJ/mp35B7n2X/TU5IwkBpyX3/
 KvGBx9+m/E0c0+whgpeKAEQRUbtIx0bML1oVyUKC2K6cFQNlaXI/re5f75V4TLFC
 ZByXbME/5ecAxlTTbmJ2I1IXdf4eYWJuPTnIVogCarJLERm6Tab5cakGkdDHrDHs
 Ux/dePNZWMSBr95PyUVOSVSuUITkrs8nfXVqsH6t806tbVlX0YHFAHtVM2EkSyPc
 vcikaQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9ee8c1cb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 08:37:44 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-516cde13e8cso221611cf.1
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 01:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779352664; x=1779957464;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=9A2tU7W24wHfGN4B/qiO8RCtMLc7lIw3uVlzGKe1klw=;
 b=W2HccIh8Y7nfweq/I6dNsP5lwmp8CammZznGJWFp3akE2a/Xi2ZGkMpgVKcwB00nWA
 rX8UjKRuLJXgiiv8x/xS8JYuCdsJInKrEz7RFnOAqtJrgE3jGMOJDv+EWV2b5LKRhQhe
 OoRi+He3ab3lC6MQxh8deAVYsQ8wU6O0VIlZwt2Pf/2EfMLfAmtSxt22sasoGkGDMPFi
 NwLt61/8N84HC59bwtyUWpWC8UAxa8GAFbYDk9SXiZQM5fc08Gq+k8vZ0dC5xDuFr8LQ
 VWz+571YKjagMZdUca2uzXQMdBj22uCIIOFt6TROodSEdAuWT7nBjpZYSyiqf42ahg74
 ZJtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779352664; x=1779957464;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=9A2tU7W24wHfGN4B/qiO8RCtMLc7lIw3uVlzGKe1klw=;
 b=KABMpLa4bugNb/EDFl5j9iAT1W73S0sv9FjgPhrB40EUsK0F+3beVC0Eb5JkylOWVI
 czRg6Cw2hNIcNxdS7tNIHwQKdZe8unIfDNSOevhNzfhrGWInWxbuiQ76uSlNOPfnTyxH
 hAHr9uVq9uYUBphFSXEwhHVcGNya6sV3o6lpS2XvEgfrluzjBqT8MFTPcuozxMO0x8at
 uYjCBgs9Vaf1eZllwm4J2+j7xlLiwjLYZPKglSrmhpr/lEyQdTeCiwPrYSxiAyRP0h9S
 lyn9IFl12b07Vhy4GSSuN2YMlqosI+/p4Z6f7ihUs1J5GSYV/3nVSMlUZ4iTcsq+IiAu
 bqlg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+BZZdVF1JWmjBvHnvIbpoSqe0Qe+G6jpuUGVial3/ctLZzoBmP4T7/TEwDxP1wlqWEp78oILbNp9Y=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyY4LcFdJfI4zPWrv0GENqvxRYFQLDofYm8KhkOETUPZzU9XuFZ
 i920OFi9daj+Bf0MBLjJl1YWl6tUhVVqdJZMdwXF4CNXqjyqcZRXYBtDiGRsQZF4ARc/JQXrrJd
 xNN3nRyFPJPV9ZOW3rOMshd+6PZBn7RMoKar82hPkM3eMQMKsdC4qA7AwoUMIOL7yV16MGtY=
X-Gm-Gg: Acq92OF6i9A2mam1yCWFFqK+X/Xr0+75jYdYZ8hdJB7tadFBk3CNDHAwZx1uX1wMRSC
 GgIL3VyYf7rGAxgnHx0z6jq3bbho4jT+8wZqibfepsmwcJHkjuQehIV/wEQQt5zE1MRXMuxSx+A
 MQdD/enY2LraQGKBU7AFidZVQ+VYRkSb4cUYa0k6ZS6fBXrY6+bV14LGZHO9bL4BntZElTvPe57
 x20WZKMg+6KY2J8DytOMFu3i1dct7+RRjETdeUDSwb/bmqi4k6MzawAeYNLQQD2+zf4N0yuG1GP
 NHJEfpMy7LJnc2vhHFLzXqkvQYpQnoIiVknCtph+G76evNDO+CoRprszxQ8blwTI4jtaypwxZwC
 nlhm412ABEbwneW0yvVg58pRghLBUyoYdwQXhx+1Se4lUS0DvNXo=
X-Received: by 2002:a05:622a:4247:b0:50e:6183:beea with SMTP id
 d75a77b69052e-516c5541ae1mr24110241cf.23.1779352664080; 
 Thu, 21 May 2026 01:37:44 -0700 (PDT)
X-Received: by 2002:a05:622a:4247:b0:50e:6183:beea with SMTP id
 d75a77b69052e-516c5541ae1mr24109441cf.23.1779352663505; 
 Thu, 21 May 2026 01:37:43 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:bb10:ae82:b7c3:d15a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4903caede9fsm10502405e9.14.2026.05.21.01.37.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 01:37:42 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Thu, 21 May 2026 10:36:35 +0200
Subject: [PATCH 12/23] iommu/fsl: use platform_device_set_of_node()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260521-pdev-fwnode-ref-v1-12-88c324a1b8d2@oss.qualcomm.com>
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
 Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1114;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=/a+MERyMSqDcoSUK0YpUrISA2FCHwIZDi0YPUao6yb8=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqDsQotZe8en0K64gdcDUDXtpmS6GOzkP9zhLUG
 wQiRdRvUuaJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCag7EKAAKCRAFnS7L/zaE
 wzJ0D/9ki6yMyfxj5IPA4WZXhvSRCjYfEyyzohJM1lkxI7225RU8N7R6I5vmcI0nALd2JoVBrQN
 dHQk38PS2J9r6YDUA0tfaqeE/XdOejp83w/mESILl91sCQ+Y2/ym4ncSQjVS1DKHZuHnT6P6iXZ
 ngP3JB4d3UEL+S9YdiXguejpCjLrxQsTwHwn56GS1T7T0E7Xdns4Y3LjqruF1DGdNXeXBnVhQic
 GkSLBbtCLNlnUMra+NfdQWune2cIBiRRhyajsiCetgjQh14UcVIkPcU2z4+4AQ/WJni0G2eKV0V
 8HxvZyJD2whJttOY1Nl9QcLB2z9x6HP8vHf1nq70L6FjX65o2V2l6upCy+ec8TamrRkKgieELkz
 EvNScrepAodJqwPZUTI/aFC4S63UkYyLS1CNtTzUcUFoK5RmT/Pls9eTFXp4FmOrkqOcQoTIhHy
 8tP9ZXTyJNRwr8yug/J1oB6n8a6D0xiOWEuiQhmCOSJRuBdlNMd/1KJ9yeSy08IaJYTF3DgCCOT
 Ql/Y9OBEipMJ9mdR35+DyMyacdNCH3ebjNi2LLXJKBvC7ZMIBN6mNrq+QJnTcmxshM7BmJ+Es8+
 XPoBDTV+KR0B8MFgJBV+Fl+7yZjHHn1yUlWKnChu6berFk+8LBbqEc4im1ktnXzJxODw+7QkWJN
 it2vrdcf7zOeI7g==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-ORIG-GUID: YruZSj7aY22hAqeOALPz6XNpeIbw0ApL
X-Authority-Analysis: v=2.4 cv=e5k2j6p/ c=1 sm=1 tr=0 ts=6a0ec459 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=lY9XkqB3srsPruLtBu8A:9 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDA4MyBTYWx0ZWRfX9I04DFpPc0/m
 ix9ZfmC7eh6YEkGy4K4usH+1luh3lU4/9Vx6Q5xLwd5YyeqFSDQTyiyzskav76m1nGQE7s7aI5f
 eop8a7FMekxxKYsjCCmFZhgKSKz0rxOzVJmZiS4ZPRQ87S3b6RzOTjqxb8YXT4rKSNcAWMRiEIc
 Uy1S9fw9OB42CyzOQjQ+JVz8H39C9LbZM4OHmiJuprDLI4bqv0uhTxDXg5oDp0r+8TQfyCGdzha
 mewAzYI3GN803OvSWjUuv0CSz5Yy4rE5vrQr6df40A6zy0uHo827Qi+TcyzBN95CB2uoMxBAmL0
 9vqovtSwn9yzi21lUGpFU19jgU10hAh3cPt34XoR/7YJjCnKYM57em+boS01yNod6eXhzlVqSKi
 75wMcCtyuOHmXaYSwWCTMFs28ZW6zDOE5ICR9/aLvAqjO6jPCftrWNQRp6gPAMGXUI4Zl6HIGcf
 8uDIYT5i/UitkoBaJsQ==
X-Proofpoint-GUID: YruZSj7aY22hAqeOALPz6XNpeIbw0ApL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_01,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0
 adultscore=0 suspectscore=0 priorityscore=1501 clxscore=1015 impostorscore=0
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

Ahead of reworking the reference counting logic for platform devices,
encapsulate the assignment of the OF node for dynamically allocated
platform devices with the provided helper.

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

