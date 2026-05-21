Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD3EBCD5BAC
	for <dri-devel@archiver.kernel.org>; Thu, 21 May 2026 08:37:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 09BB610F27E;
	Thu, 21 May 2026 08:37:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Wx0mkrfh";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GQfL2Vqd";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4432310F284
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 08:37:36 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64L2Swxb3815917
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 08:37:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 5cAewiO2Q2GR7KlmQQdZOQuEhoEBjBTz5dtw0Vf2kkM=; b=Wx0mkrfhTR25R2CR
 P19rj34FWn9V7nFvEfRskX2RWdvrWsW1njjrnxOrV/EhPy3AZr/lBeiimxCLDs+u
 IvefMDwBXsucLiZrWeC3atAcK7tXPEKVXMmJ4Nu/9snsAU+7uZdGmON+ofOmgpK0
 WO1RCTJ11flpN+fzXzevrwr/Z3XDSRoOkYyINb6plIMdZqx3juYxIFE/7fD6O4KK
 r+8sRezB6kVXkXTd2sh7wG3GEfPxaiqpsX2h9VwexfrfY1lrJ2CU6NL6wHOIZbRd
 3u8kPyV7Qyk2R2UHNkvKTnwsaZCdUtQLADvT9TPpntLC8xoYJj9rguVoTpLjy3Ff
 Aza/Ug==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9saa19n9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 08:37:35 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-514ae0e3ad6so147005611cf.0
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 01:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779352655; x=1779957455;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=5cAewiO2Q2GR7KlmQQdZOQuEhoEBjBTz5dtw0Vf2kkM=;
 b=GQfL2Vqd9iK50waUaPMlXNO9/8HGxg3xqIMtnFDA9F3bCLEFtcG1Lc9OpWMP21hD3G
 tbF/0iVFOJTFT3uSYlhjuEgt3AGhA2pLYVXww4NNuLoHK0cXOnxE43eX2rvTBDBx+GwA
 ONH61INK2jMX4KgknKVtQRHbIkbUC+uJY+WqyVOSuMFbU5++60+2fRTpUPZ8Ks18dJy9
 kwihjcukhjg9nJ0/y9/vf1s2d0IGqvfnlqWWVHfBUKlP15OxlBowMMoKdDGHVfmCxS2i
 HZFtXcPjvUpQTAb/L1r1DfaIADPKB+OwZcB/uMU4jJdlm1BfEZCMAwXCiKUmhQKsqz8z
 ZwhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779352655; x=1779957455;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=5cAewiO2Q2GR7KlmQQdZOQuEhoEBjBTz5dtw0Vf2kkM=;
 b=exMohSLZ36B2m1itmEqtkzhi6f1+CIg0LRwQzSBq6FD0f1osNONvfQDdVOJKZV6KRM
 WhW4eIJbT76QsTf0dSRT1hQrlMKZn/FwBlPk5aNXiFVHrq79o27O63XiyuS2g+CBZWeT
 +UqlyD+DqtS4h7S4wHl6OCpXvDeh+TameSSrDOFlrkWSZdLJH5fjVQDDKNYTb2IDQ6JK
 dmkW0CsPIJY3BcCPxxSuAw8Hv67IxY8L/vABBLtcFsoBuDq8tyN/B1H9Yo3g+BD4U6AL
 0qvafJWcORlebjVOKSW80QPNEVVZHpaZaqPBUVUsz4EBfpXt2iAO1BQXqyOIBzb1jkSb
 kZPg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8H/2huJS3bwNm6Fh49KHTx94xIiLL6BV6pQYG9OVj6q8FXKYArXCVuN3McG8y8cJjyQL2dQGTURD8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyOvkK4vKy+8CqyhfupL+mW2SFxfDMi84NjqRJ2/uokk7H6ElZ7
 mRLpNrzI4IANSkkMY9V1V6ShPleTJ6Caq0b98P1WybmTFmbkbuyKPjKKr4wqIo6zMecThXlFjPp
 tN2qScn3qnROF7HqVKRe+j2gE51WDU89SeSP2xfm5QxYksQyhDVNCg6m7eVRweX5ioBlQaNc=
X-Gm-Gg: Acq92OHdVCYbyt43WpQtXOWZs73c82AGGrcQkZCKQxBVTUnan6QxWGpfAi2dQBRAFPA
 KegzNkxGDxfTyLy/aNTUn4KnswyWLY4+9bA59NT7LJUbLdb04Y5KjO4ckxIYt22RC7wS5q60UlK
 gdqN0oQ7U8kx27gRbgqOgpINHcQ9lc1v88IpJjpZa53rTc25Dd83rIQidmfb4ZdJJkH0csQ7uxI
 WS85x5WLsvGOqMB2uwhm1fUQ22epntNJw6tmZC4AxgKYOAIXtNvzJy1Y8+bJbyitZDH+YBBNFq4
 5t/yK272UrT/7FC6XrpZDkQSFuWxrvqihFQs9tb/rKkqMqYLHrsoppRakgX1bE1KeJR3EZjUnAw
 eOWxfOs/NtR1C0WPVruIV7aMu8CWt1G1EQ5ZNKcETFjxJdsqLh2Q=
X-Received: by 2002:a05:622a:558f:b0:516:cd8d:c7fa with SMTP id
 d75a77b69052e-516cd8dcb16mr1393381cf.39.1779352654891; 
 Thu, 21 May 2026 01:37:34 -0700 (PDT)
X-Received: by 2002:a05:622a:558f:b0:516:cd8d:c7fa with SMTP id
 d75a77b69052e-516cd8dcb16mr1392831cf.39.1779352654276; 
 Thu, 21 May 2026 01:37:34 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:bb10:ae82:b7c3:d15a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4903caede9fsm10502405e9.14.2026.05.21.01.37.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 01:37:33 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Thu, 21 May 2026 10:36:32 +0200
Subject: [PATCH 09/23] of: platform: use platform_device_set_of_node()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260521-pdev-fwnode-ref-v1-9-88c324a1b8d2@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=877;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=62Oz1SbeAMwV4fv895oAqyFh69nhboZTNIz+xPLsUyA=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqDsQmchZFDFTztRU29nkcmIf2nW/nwlzDTpQz8
 +2keRMrA/6JAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCag7EJgAKCRAFnS7L/zaE
 wxw/EACn8eHQOwjd+Dgeolnl1EcseWe/xGk5I4KpBP1p2m+G11f9vLsOUXBOPZGZSyzUPO47NAC
 iyozeeVO+OH2RpEvb/3X3MbeIb+N7xCFhIXoBy9dHt8TFTc2eZb0zdOcQaQ7HwDPqPAsbDyDPAa
 tScifI1XmoBcqV9V1S5KHZLhhWr1TPVqyUBvQJBVFTDr9Dgc4IxSYyYTSp4oxZAseFDlwBM3oMv
 trGKhh+xWYBpqycF8F3nEAvyJKUpMT1WskDUb1hehpfJpEVsb7kEOzTj7zGh9PP3osTLQB1dDAu
 k93V0oRYboHvSnoLrZOA0OfqTfGPC94giWuIlDQxQBJ1QYipOf/9/bJ8EwDeKu9NiKwsunEwdwv
 ZDsejl4PufjMEpJ7PptHLqO1X/ktVBTcRplnmlTo53Vs9em3L/5kSW//1XptpJg5MHQKstiGNhT
 JwXkhQKxsEWHTU8bBlJ/KnCl5YeVz4bAiwE5K3LMZGTXxaPrKNPQE2a7OgCcqKI7GJZN+MbaSR5
 iRRE4GsITdqUI+V0a9GmZFcR/ACxIhFigTivLDROyYp52uEEBqs41OjLaek/Tn/8+GAbu/+LBlq
 9u9KFLbmZmj68Q+6ZlZNIN+DZ4GjJ1qCQlnSFJk++NQiAZCIzxiS7FBUV7Sc4R1rjga7Eoru04k
 30fJtzl/FkuS5GA==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDA4MyBTYWx0ZWRfX5WLMFxcI5WCe
 OBv8sUot1UFbIDIt1nsu+Y9gANVVVLiD6l5ErsCy3LJ+XPVJsJXILecCy4tQaWIB6A50brt5sjh
 3hwcYaPTKTAADrG0HbdBdHraSG0C3fgpemB+6Y2pHXwGFkVzyCHtW5H25iza/0ump9gCa3e4aeT
 6C3qXJv4cIXKOhgaptvb+dd8EjrLPVnWliHEV2QPbZGo6n/oyyoR3/3laXTpSj/j4GNoI0WOsdG
 DJgEMsQqNC1f6XjXq6xCX4zuT2w3Yx27lwvLU/VRhf3YZO8X+ztS87QoDGbRVmRbswcbSkChNt+
 lClwBrRjOUBxRX70TCLwwJ6SjPuiSZAvnS7GpP96KBkvrToqx1Yh1HsMQ6mSo2lWKQNO2dm8Akd
 3YXZz1XlbDNUTQ5mOd/2QAt1TaEgYEKqpTbqPv3NzgnGFVMSyjVFFveyJm1+jjpEygytar23GjR
 X9TdelAixd/wnfvFMsw==
X-Authority-Analysis: v=2.4 cv=Qe9WeMbv c=1 sm=1 tr=0 ts=6a0ec44f cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=Jb7EFCjKRuSTjX4XlnwA:9 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: 6PZEGMrw8ycgn3057ryORCcFkiZC-VQM
X-Proofpoint-GUID: 6PZEGMrw8ycgn3057ryORCcFkiZC-VQM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_01,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 phishscore=0
 suspectscore=0 clxscore=1015 impostorscore=0 bulkscore=0 malwarescore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605210083
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
 drivers/of/platform.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index a42224f9d1a888a6e6cad7534cd2c5f110e995da..db45d1e99bf9b027548aac3a15bf754b3c023161 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -126,7 +126,7 @@ struct platform_device *of_device_alloc(struct device_node *np,
 	}
 
 	/* setup generic device info */
-	device_set_node(&dev->dev, of_fwnode_handle(of_node_get(np)));
+	platform_device_set_of_node(dev, np);
 	dev->dev.parent = parent ? : &platform_bus;
 
 	if (bus_id)

-- 
2.47.3

