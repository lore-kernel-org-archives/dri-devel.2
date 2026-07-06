Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E315AC44501
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 12:45:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2120F10E947;
	Mon,  6 Jul 2026 12:45:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ebOZdHAw";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="d/o8xjAG";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 07D5C10E947
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 12:45:17 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 666AxOjd245846
 for <dri-devel@lists.freedesktop.org>; Mon, 6 Jul 2026 12:45:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 0bXtMmPvMuVC61lphaB+WyfPoNQ88yrVKYbnm8jwg/Y=; b=ebOZdHAw+6pvz8U5
 guxfBlryTpeglXytQIMDf3qb70gs8OqD+lwFTn+TG66rcgy2RCviTEWtn/ydL5zH
 0LGJgBOBodFF1ycxr4uJ9xW/IQPIkl/yCJQb2iZGsHVpG8AmRZ81E+/eHhWqc1OV
 1HwR4fjhtQkotKRlcShLfUG9IqvbsF/ryqc1sesHzvoZx/JZL/x5Gn/9mRbf5+29
 hitgZGkTaIO/Fvo6JuKOHb89bpnOvrPgF9j7YL6C8VxFb9Id0iA9jcsSgdLMlxVo
 bcDiq1L7xnn3E/Z7cJ3JFI9rteqpICWlCsAbGItPxIo0ZrHZcqb3kqSxbDlCgqHf
 4ZP8xA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8a98gjmp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 06 Jul 2026 12:45:16 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-92e55f0613cso231567685a.3
 for <dri-devel@lists.freedesktop.org>; Mon, 06 Jul 2026 05:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783341915; x=1783946715;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=0bXtMmPvMuVC61lphaB+WyfPoNQ88yrVKYbnm8jwg/Y=;
 b=d/o8xjAGcweApYc00cYEJKtzA5lmaBGWF5lTS3aAaITwetgzyTZiEE4IoY3J5449Nu
 vDuY6cg4PN+FnWSGDlLh9GpDPaLyVAwJF9hFTx1Gn5nQ8E2etESESRXn8nXUpYO7grRR
 p9k7kBQPY9Sf2lPzaxYcMw8PX0eWxO0qnZyHFUxtdiFSYTMxvDv4IjuOiPa3Xh2mmYfp
 XOXmmAfHLn8zszU6iAC4qaK513of0vTI4xwc3HaDw1mhFsuA5O0/u0O6Igr/8+ktuUrE
 jH78dyV35cuVpKX/HSqGrzIvRGJnUHUdPvV4rWNDMI7UE7uWbeFRHiYzRhNItL16redT
 eFiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783341915; x=1783946715;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=0bXtMmPvMuVC61lphaB+WyfPoNQ88yrVKYbnm8jwg/Y=;
 b=ZFXQ/gnn4YaFkTLCUqa/qgTWlvjgvWbSRG7aIV/hiQHVRogM0B0p17uB4r5NHKAC7S
 psLSNTt5L3ifVXKdY6gtETDYw1ABbsokkUwu4Y66mOhEkgKnHEwiGiL4RuApYo5NniDP
 d0e1CoYS+um0OQTVA0lIlrNua9z/u5zg2X5+TwkoaQbWaUQv0rBXcEeD3HTXVxz7LQ5l
 1AeICOttKKy+f3Jkupztma7L2YG1E37s8lSaDG3HWvizgBNr9yADpZifQXBQivRG6b+s
 gUcuN8wBXLOVomT0zKYYFN1aZSgYMwzG37BuZ8V62EuwN+5HftRRLVw2Y7jdtSNG+OfV
 cOBg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr3Xnz/U++j/TqvrLHPzT4Qnt4lL3EUDHkNtvMIkwIkDBGgd/514qrl3bVY5K0njKmZMKH4wML7yS0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwLukRgnPXYfdTLRyUWHfZNYXIwdWLFIWt9bmsf8bLr9TSN6yg3
 wbEw/c54bxa+gWunGmEaFDmJYa87GoI01nwmN/Vi4phffjFUCZmF1HsWNexkZ1J/3hHq/Er9mF4
 Xv7ZlvJXacO2rrNP/ahx4K1HDwBss3vgKkRuhlRabDSGgytfDW90cDwQUysmHtJW4vw7Nzck=
X-Gm-Gg: AfdE7ckQz1gmejV6N+tbYsPdYQXeawDxseK4+oyuUTg9S7TJw7AxwRBKcEQFyufVKeZ
 bcdjA0C+R4MX4mAevd4v9c42V0IFaWUwy7N4pmIywFA4D+rX4LOSOWYwPFU+ukf7X/XfjAwayqT
 vkjaTMwJOheMO0Y6IcRevgAUoVmoSqwkc/jFLZ9ksigwaHdjxCcuY8U47hlG2ki5pdg+Xxxwm8N
 osTcINEmj8vYXEAb9+DYluMVIJWqCmRYv4S99ZDiFi1cBx2n50xi5mlnR2HNmDbMCoPYcKSycb6
 1JgG12ZLjMV2YlSTh8CLlADkwldMicxgmspHZyAk7D09DKLV+sEqyreVGB0eaFDrUcy1YgztKzD
 4zf1SPSkVoUsaklW0iLl73bHatE2yAe+bLsNdPL2e
X-Received: by 2002:a05:620a:2911:b0:92e:61f1:6b72 with SMTP id
 af79cd13be357-92ebb49ac6fmr50868085a.13.1783341915061; 
 Mon, 06 Jul 2026 05:45:15 -0700 (PDT)
X-Received: by 2002:a05:620a:2911:b0:92e:61f1:6b72 with SMTP id
 af79cd13be357-92ebb49ac6fmr50855685a.13.1783341914299; 
 Mon, 06 Jul 2026 05:45:14 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:86f0:c42b:ef4c:d3bb])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47aa0a55be4sm22126539f8f.31.2026.07.06.05.45.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 05:45:13 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 06 Jul 2026 14:44:20 +0200
Subject: [PATCH v3 08/20] i2c: pxa-pci: use platform_device_set_of_node()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260706-pdev-fwnode-ref-v3-8-1ff028e33779@oss.qualcomm.com>
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
 Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1123;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=zNlCSBzaa8h9eLrFPJ4Rsk88by0DY6qHl2V8PSoqi0Y=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqS6M26fTgmFzEcwV6TgLmONhrXHSg1JSo5rARQ
 cIEm8brQ2iJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCakujNgAKCRAFnS7L/zaE
 w4FQD/4xlrZKVrDsxMxMDylskkXcnlp/TO8AFqhtcIAfJPLix//8WtkgYU8BoNMp1g9Xn0gqxcf
 Mqf4MoSZUM/9N4F6rrhsUS/fyZ8JjetftBgldbi42hSBBzlfigoXf7c7XsBd9RGYeEc6bF6Tvuk
 BeJBj7nTA7F/4P00u7JX8G1/EeAtOw+bRQp/bw49wlB2BMUcu7ymW7ZraPoAKhBLVQ3rfni2ggd
 v7fQ91AkgPqnXxlC03UumTZYRoodacvcu3K2/OHWjJ0tNZDijDmUhbLuEo5YxD2+r6fe9V7u6S0
 1AIHBEWJKLNycrCiocP2fSza0iVf1XHu6s3E0WBNJBpHEngK+P+XhEETCzEVV5hM/s+NO28XuUL
 BwdgBkheFv01xR0OIIv2htjsf/BOvFDkVUAE4mRwAAeBbUIlO3d1Gc/xIBw3P5sIyC/K1IP6Mpa
 29UAXyfBBm/QY0Eka/LOQnWf1rHBt/qWrcr+P5wHlLfPBPVvN7hFRXyJSSRrT3ZERQqDvupO8Qj
 ptCFfm9nvHLamnlGUxzUrLNpAP0Oxg4KP9I1Ee5OxwE6+tf7mtUlBPB89eKW+UNWpBN9GIYK0ZA
 yeTbyImJwaYxdcjvOhmsd7QN3u8NfTNp2Q6n3JTwHbo5apELLjJoObnNQc0x01jWKh0+xRyswe/
 xFrtfFeb09kS2tg==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Authority-Analysis: v=2.4 cv=SpigLvO0 c=1 sm=1 tr=0 ts=6a4ba35c cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=VwQbUJbxAAAA:8
 a=LDBv8-xUAAAA:8 a=QyXUC8HyAAAA:8 a=EUspDBNiAAAA:8 a=OZ2e4d8rXakbCkRG61MA:9
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22 a=DZeXCJrVpAJBw65Qk4Ds:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDEyOSBTYWx0ZWRfX8RQ6ToStmqLX
 OgDsZSOpRlBBrYvXY2/Ob7WjHAOBS+cFmKjEfIf5SujSik1EZJCoa2D9Gro2OSl9bVYSqc36bQ0
 iP1s9AWjyifWcj+LwAuhjkL8ZXOMvdigYrXN922ievniXmDikDQudx/Va12mzkYAEfxPJd+LACf
 +SR+93tCbIjZQrkkyhbnjbwfKHgZS2b5+oRW5oJa3SFqhiQV9a3L5tgaNgyAdGcMpsooy0eRHQH
 fFX6lT6esP2Mqh7zpNLqDk0V0+2eZzm4fSPEaM93kMsvwHmRPVppVcCftIHnYX5ehk0QhzSJXP4
 x1F5K4m/qdMGE2AyVuGJ4subWzg1AIrccoYDjrER0M63dL2zlb853QjqMpDCJoJzAHO5Z6YI2Gw
 O57OymqnaebHVCZiR6eYPVcBYTdgBk17dW/OVWgwlUL4YWShcj6QitLJ3yS5SBXGknFE5JkvSMn
 VrFpqY7TeTJHDp+83aA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDEyOSBTYWx0ZWRfXxKNBFTcS2BAv
 UcUesWG8pfcqvNb00rBWmSw9IHMiJNRMs5HIBRCqcZMSVsd7p7l8WwYrOwoDlf8m44JVortHMwZ
 aYrp2JLAn/RnYg87rLGKzHF9M3WnukY=
X-Proofpoint-GUID: nt-cT2Exj7dMu-40Tep-cBQD5rz0X_Wg
X-Proofpoint-ORIG-GUID: nt-cT2Exj7dMu-40Tep-cBQD5rz0X_Wg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_01,2026-07-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 spamscore=0 clxscore=1015 phishscore=0
 bulkscore=0 adultscore=0 suspectscore=0 impostorscore=0 lowpriorityscore=0
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
encapsulate the assignment of the OF node for dynamically allocated
platform devices with the provided helper.

Acked-by: Andi Shyti <andi.shyti@kernel.org>
Acked-by: Wolfram Sang <wsa+renesas@sang-engineering.com> # for I2C
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/i2c/busses/i2c-pxa-pci.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-pxa-pci.c b/drivers/i2c/busses/i2c-pxa-pci.c
index dbd542300f80043c6bc65a69fa27ca7b3d5fe787..92a0647f08c69f841ca99caca757c1728b3f6fce 100644
--- a/drivers/i2c/busses/i2c-pxa-pci.c
+++ b/drivers/i2c/busses/i2c-pxa-pci.c
@@ -76,7 +76,8 @@ static struct platform_device *add_i2c_device(struct pci_dev *dev, int bar)
 		goto out;
 	}
 	pdev->dev.parent = &dev->dev;
-	pdev->dev.of_node = child;
+
+	platform_device_set_of_node(pdev, child);
 
 	ret = platform_device_add_resources(pdev, res, ARRAY_SIZE(res));
 	if (ret)

-- 
2.47.3

