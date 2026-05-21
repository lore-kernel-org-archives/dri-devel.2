Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E77CBCD5BB0
	for <dri-devel@archiver.kernel.org>; Thu, 21 May 2026 08:38:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B3FA710F29F;
	Thu, 21 May 2026 08:38:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="IUO/2oAZ";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aoZuHkvg";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F2E8E10F296
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 08:38:13 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64L7cbjw963772
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 08:38:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 M7ED+C1Cny/90pO6gVbhNn3JfkifwjCs1jXkp7NDh1U=; b=IUO/2oAZBKLaByPc
 Pib/Wdi6Re7jbjDhT2DcJGfxksVhV1lG/C8PBaWeZSqZZuDFAF8uVjdTmBMcoTdo
 aqHFel1CfsAodTf2kMAAegJ+s3iSD7fS2wY48DFhw918ikDLyTnprifVwc6h+TOY
 LV4AYAPkRoMvyPJ7+0Dn3Md0beSEQl/oy1aXPhHSTq4Pv3FHP58MZXIF4b4ppphV
 JvVKXyv9r1BvTUDJgWCRPAelxHbwhdccQRUeOx57wI6xAr2WSOLp4CvmDtuwx6cr
 ln+iKZZo6t5N+ji5qB4TtPDZn0FSXPonYCJ7oBgqJKgmsLo0bVRPqsdSLnXcf8iq
 WhOJZQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9ejh3wgy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 08:38:13 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-50d812c898cso162950881cf.1
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 01:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779352692; x=1779957492;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=M7ED+C1Cny/90pO6gVbhNn3JfkifwjCs1jXkp7NDh1U=;
 b=aoZuHkvgiGYpZOs8QzJXHFk39QsFq3PHrgFC7YOrDStWcLyalkCNLFIWq/Fo/MpGGA
 6c7fFq5tPpZ+TE8HA/Ds/0tcw2/AAbuHAgAB/awdt7ICVYIGfKv8ZULtcqiUNvix6CjX
 O/bFk1Ks3xrqwglxvJKty+9OvbaLl5U9n9nKiftJM66uvguuq+uka6S+HWTDHlaT4vqb
 TXNaI0rpCwUKb9A+FYT23kCdIG+qRTLcR7yZx5A0QFugdN4j9pEeP4Q8ZEDu/AC7X9II
 2OojBZ+R0WOxLyezDuY/DlGpw9oYkidUU4EJ3Po8o6nfk852T86ZFjXcVp1a17CD0W77
 g27g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779352692; x=1779957492;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=M7ED+C1Cny/90pO6gVbhNn3JfkifwjCs1jXkp7NDh1U=;
 b=s9aQTnrY9Kr3CF+PplfupRpg/4Uy6Q10yn2OyO5HGh6ZkKFy1DPvn2xOH6021R7XNe
 eOC2VOiBuWAhKB03HOUHf5tgo+C4fO6rqR3wCowvcaQs17HQzowP7VXWfddgqfZOLeBU
 hG1yV5xrdUKF/RCQGsiguxYfIsTXm+bRjq1la3xmNZDsELrzBCDSqTjP0iT647+CSQgO
 i+r98QRvM/3xgIp00oKlL+TxSL9PSUGQA8ipc78G6iO5xYAq3MTQgVS80yMmktb+Qeiy
 tXZ00Y5GQ67I9D15O7sYtcMTX0YITBmU0jqHOGMweSN+whbL9kmKWXECRklAYdAWzhLy
 KNmA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/lWRMIawkKSFEa+dz0Cm6fwAGEe8zxkL5etF5+CWExgHoTnvof1RiKh00CyruyY6DVBm39fpXQ9yk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyO7IACB8dlQdFuL5bEseHdAB6Y+k9X/ptau4CJtzJ5AXM/KJ8d
 Rj3qRZZ9qaCT6Jhzm7TDZruZ+wI0I9CgcVJ5Gshw7JXO6tkWYROERr07RDTLmoqpQ1Nu8o/P6Ns
 Gp/PHAw+6CIo86Ne2Heaix5cWOAfBaa3jinx9jM1IJTMYvMRUttSocceRWkVeCeWsFd6xPfo=
X-Gm-Gg: Acq92OFDql9hhWUU429vhzat+zj+wQnungBHVXieT+xhfc4fKYCoggr0vqIJRp+SLRW
 YEwOcKBSX8yftbOgcayti7yAJgLg57JbY2+JPj5rAf8DOMwflgYKSzA0bA4Znz0VCSOG+qxD30I
 c7TMvjiGQIb7jZePNNHOpk+Dci49jii0cbSychMvew9U8Np9wQSHpk1Jl2bNISay3tI1kVAsNMW
 9QTcFxkP/j4FvAL6O4yv+9lUkh32un5topF7i4hZPuKoma2KHamXCS0qKompr/kRQ6t/Yzdkl7o
 9a9PmJQ9g9DqJAW+vVO819mCGjKmLERiehm7OnxyMI49blUesY+LDtQacjpgfepj4lEv/WFDbGx
 Spnm0a7nL2cDujP8UbWrDr89tX0DuzaLWT958hgkl0vuvJLj8hWg=
X-Received: by 2002:a05:622a:5e0f:b0:509:35d1:ca3c with SMTP id
 d75a77b69052e-516c5473bb5mr23806221cf.5.1779352692496; 
 Thu, 21 May 2026 01:38:12 -0700 (PDT)
X-Received: by 2002:a05:622a:5e0f:b0:509:35d1:ca3c with SMTP id
 d75a77b69052e-516c5473bb5mr23805721cf.5.1779352691987; 
 Thu, 21 May 2026 01:38:11 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:bb10:ae82:b7c3:d15a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4903caede9fsm10502405e9.14.2026.05.21.01.38.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 01:38:11 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Thu, 21 May 2026 10:36:45 +0200
Subject: [PATCH 22/23] reset: rzg2l: use platform_device_set_of_node_from_dev()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260521-pdev-fwnode-ref-v1-22-88c324a1b8d2@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1003;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=cf9shCmrClBGUTh7dllsxEAWSRdwClRtpyvDEjdTEWU=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqDsQul5EJOx0VeXQl+rdgf1QZA4hwOrkTVMgH6
 yr7/2L10RyJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCag7ELgAKCRAFnS7L/zaE
 w1fqD/9lXR/uJB0CDw8VfjayM1LHzrTL1T8ynf3Gvgcw2Wtn9tGB8ig72R3fTjK6WO33qSEx/Ys
 +DCcJwVRX5FpmyL+09qHtp+CXL2UW4YC16WWYephi3sCxLJYuFoyb0JH/qN0+ptGq2NeUfc5gKD
 c87044Xi5XQfAFUNj+hjqpnGkVuOk+BHO11vfS6Q8Qp9dMc+im+ZIHnNojx+MQuPpl+XYxViSi5
 m7Rj2JVyScch+ae1y1O1HDXqmgEtRjEFQ8a1sD1VvWz2dr99kOYf+zY/IVl/glBQAVwK5z39J6Y
 qgkwghvhKu3mh1nMh9qGm874qbqYvrxoyWXEu8eTHpc/Ee4EkBGbZPg4Re1IF4mxzF091bMDQMo
 /Na9rNRS6DIcjYW25qVbWTQ8cWto2C+ane9qzP+6H2FwuWKGXf7zxfdfDM3TPaXbkiuSREUX0DL
 06JFNxIHD9jqtIQPTE5wqBpn3JpyYNrvD3NT7bAO6xxMF64VHPng/cenB8YeEULz+TKMLm2WP6I
 3qbyN8Y0E19QrIzjS9oym6wbxatwoBWsv5FhinU3N1knXnOpdbjk1GBPGrQJmqiKJ2BbqWBZQbj
 szuqipQoXHQzf2mDXj1TB1k0Y2uddMXfhNG+eK8UlmCeTMGG9uCgSfFKfoJlsE4UUsheZ3FN/M4
 W3hz6QKvE8P0Q9g==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Authority-Analysis: v=2.4 cv=QptuG1yd c=1 sm=1 tr=0 ts=6a0ec475 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=Jb7EFCjKRuSTjX4XlnwA:9 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDA4MyBTYWx0ZWRfX755VTIykGa+8
 oSht5KS00OFUye82tsaZ94WEt5oqWSsO4O3sowKojjajE7Kqf4UXV84wiFTf7CuSVeT8aO9CjMj
 dX9LEmDrvLiD5yKHMrpIms8bjZX539czez0Lsg7NS3kabc3+vLwKIC2HBKUSlVdQbnxh+dreFWM
 XGcFjkM0Km+CFbZIBLJefI7ZffY+uVotkBYrwq1lWswY3xRsRU7R/YyTfGs3hl7XrAh8zw1LaSu
 AK1VpNy5nGq0kHCTI+CE7xqpGIMtxVk8TMRo3tB/HC26ADZmRhEYmAShrun2uyh5phuWlZDM4G4
 E9FT3M8cq2v3DQboAKfqbOKV0CFXE9kliuDdjnYS9BSqSnisyjNnyYobdlsUkwFHJrf5a7UkxCH
 96NzZOKAf6OFHb/lcJxY+pAAyoEWahkX8JxY5Mjr2ndTC7bo9GcYhsDdWGLZnRQ9lTx3hH8qMsZ
 TFzgi0z4PLy5vmtVJqQ==
X-Proofpoint-GUID: -NjtNnItyT4oFoUMgjNP5VvSs-B0_kU2
X-Proofpoint-ORIG-GUID: -NjtNnItyT4oFoUMgjNP5VvSs-B0_kU2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_01,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 clxscore=1015 impostorscore=0 phishscore=0 malwarescore=0 suspectscore=0
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
encapsulate the assignment of the OF node from another device for
dynamically allocated platform devices with the provided helper.

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

