Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A063C43602
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 09:14:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 041DC10E7D3;
	Mon, 29 Jun 2026 09:14:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="O3a63/+I";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FlLQ3ys7";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4252B10E7B6
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 09:13:56 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65T8xLST2447481
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 09:13:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 jsri2EPN9pY5QDvkjI4fd8dHK5CB1Dy3Xc4grAMl3dk=; b=O3a63/+IxA+EjaKg
 JhczbaptnwlswGKlVyWvfV79oZ0KgKi0bTGFNJk/kxCyF7mjkMbxf+IRd+r55AZi
 GXomEMUi1DqoikHCTXPAjdrqb5Ame8D8+M1BTcrlnoGZNfrToyafFbjNRPQ2zwaO
 4KfhKoM+KaWUEcpS8ywRhbLGES/ncPAMK0oyJZDgf5lyYxGU7SSiPqxveHceEdKx
 yJ3pc9q4r02Gw8jMiTN2QMkH6NuZHGf+hk/uKmGbuIXR8ABH+pgRX/a19EIS9WLM
 6fVCVyrgt9sr3cUfuSRwMDTtyQbTS2qrFv72TDwNRNFbPtkn46a3Ggi4Go1D0EVz
 NGg4Ow==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3np7g1y7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 09:13:55 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51a19f736a1so52410201cf.2
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 02:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782724434; x=1783329234;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=jsri2EPN9pY5QDvkjI4fd8dHK5CB1Dy3Xc4grAMl3dk=;
 b=FlLQ3ys7SKFfvJjNMaY/n4Wg+o3ePUIA4Y/Jy5pPIkVuCdDhvUN6gvvLYjEj1JTmuX
 a8j1uBNEX/0B8YLJTjvw/yCZMJG++OIHcTBhLqW8X2M5+Yd9e/fxYknli04TvBK+yieE
 3WtEUuo4aojp0OVNhlidOW64Ollbb/nt1lPtHeEGjG9AwMlx7pBSW1U7JYn7HharlzFg
 UQqABTv4H89qGjfMjS7G7OmO9jvgwfL5cGbGDQLYiqQpbM8dEXEolM7ISiRo2j5nACt5
 Lcazi7mXJf82A0XU6WZ1m77k2is9Jg/TCLBVnfZ9OJn4MHGEyETDZuVlN69iHdojfHIv
 UHxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782724434; x=1783329234;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=jsri2EPN9pY5QDvkjI4fd8dHK5CB1Dy3Xc4grAMl3dk=;
 b=rdiMx5pPMHgM6VsVA9IinkgC9y3idRlbkR1v7+mMj2Woc7oMfUulglZ8PlzDZqTJvo
 AJvVwBDL7ewAZUokp6CZkNPKhrxGTwEQIClA6w7TRfITevnrJfFAu/BO/V2cgCTh9zO5
 2Z8lgNntfZ5rcC5sN6Y4bQzxQlzobVqq16xv3V0s1DSU++5qxoA7o1VWpOXZv8RLDfvS
 LxoCSM6Kz6C3rzFLpjgTOGxQzl33wYtdbynijUds5208PaFRY3Z46UKzNkmGlKNGJsOe
 y12pMKIzFZdbaA7ySQMiQom0v1hbwX7QA/gjBTJZQNX00XpSFduFCFm3Hntn+kLqJ/+U
 xCzQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9wrw03tTFrbJxK+J4OeuhHNjuic9mrAJO5BNCbSWFas0KV/2C3IsQYQD7Yhlaqn+Ws+sYi0w8TA/4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwRuzb2gos5u3/lbs4U+TC8BoauBbMHcnjI0F2xCiF/+Bau9nod
 D+NHCLH/CZkG8sbeXl3xsWEaqfwlk2gcN2JbnZ2bb5dvQxicK1yN/06OWeq1Ixpz+K3i25/WPz+
 DtEdJo80F+0YlB2AOloxyUBbXV9SAX8HLW37LTzgX/isYk9t5hckJ6xzKcB7KcAPlnZ1PlPo=
X-Gm-Gg: AfdE7clT0tGkhJuF7GEEhKw8zE+s922c0xe3b03nzybl23dloiJ2GUaN0yvBJY1Fi8I
 9fTXDv19rDpsH8obUKl/5ww7+Y2ZEQSc55hJYEuHO9ECwM/QH1+ewF54VBWYWUnQpNs8lEuaW6l
 MC9rInzPz7htWTQi/oDXX/kqZasXNY7ErTaNTl4wcNZKWxtr+Fx+9YnNycLxjvuClAemcQOKRtZ
 KwH77yrEB8TG4mKlAtKlKpF4MLON4+VY8FiFMPn2vCSguKw6ATSb9Dv+beNFaBTvQuNQ8t2pltz
 Q384CRB4fSxVHQF7blF4QzLdU2SHzfaEHjODRig1N+OpoOiEnhGnNoVs6SzsosHepIiMROIsbz6
 /bZ/swWb56ClCpZasoegirG/HFz1lzf3aPI0Jscbq
X-Received: by 2002:a05:622a:a50e:b0:51c:868:899d with SMTP id
 d75a77b69052e-51c08688d46mr5705401cf.15.1782724434234; 
 Mon, 29 Jun 2026 02:13:54 -0700 (PDT)
X-Received: by 2002:a05:622a:a50e:b0:51c:868:899d with SMTP id
 d75a77b69052e-51c08688d46mr5704721cf.15.1782724433603; 
 Mon, 29 Jun 2026 02:13:53 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:4640:d76a:6126:9b65])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-470f55acda0sm20109240f8f.23.2026.06.29.02.13.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 02:13:52 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 29 Jun 2026 11:12:41 +0200
Subject: [PATCH v2 18/19] reset: rzg2l: use
 platform_device_set_of_node_from_dev()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-pdev-fwnode-ref-v2-18-8abe2513f96e@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1053;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=uU1Fr9CywAvFxzuC6Bl5zMISX54D90vnS0rD7BYCHEo=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqQjcVVV4ntsBNkEfJYpWCbBlNwGjTzWXksVf6a
 B7aYJ8a6BWJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCakI3FQAKCRAFnS7L/zaE
 w4lZD/9Z00RoirT9cBP1O1TRPSZsV/i898PwA1y+V390LSkU0nBecvgm7et96y3iAHLoAbhwMId
 fCniVeDmYthH6LI2ZiS9IIqGiBvDjXeEAhdyEvMhzBuiPGFdp8mFz108HQYBgy2lUI7+XDx7Af1
 rMkRf1MMt6X27j78EZPbKvJxROug2ur0kEKUiFIfs/I/zk7D2EvBDMygGK4m2zrcyre6SfLQxaK
 8I4dqrMScYY8SOluQf/60QUYHV/hnhOpo04JNaLAyIvaMYd2Qe7n9BJjsaHXDQbL4S6iWyJMT0w
 BqfC+KJWDZDMP4dmiJ4zbtlsbfN5GUKj8+ZiDylkn/8gD9sz81zDrsSjahp6yn5UQoBGWd42Ndm
 pt7oPQmw6Vk69Bw55koR2LRDdmote7WmzKfDN7d9l415NKsy5TKIx+djbJyZOmNCVzd0UgtIB82
 zeZHJ5d3OfaC/hM/UMDugPFDzimkz8aB3O73Y5VGjZhxNSsYmkmWn1HMPcgS9UEtb2YcsJk2gWk
 m6fAyae3Lps827xqLL5DFo/eAY61/9bJ2bKTNQyB9JP9FCqUoc1quDYM7MzqjaYJPn4AIr3mbvN
 SJ+j1qcgCh78X6wsSW5E7LlwrU8gDhIQbjdeGn1HzcP8Z7PDSraWAf2hXpcezPNeVEgjZ+BHkGk
 q8nixFMcHJHjozw==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDA3NCBTYWx0ZWRfX1rMr7ZtEM4+U
 bM6IErPYzeX6FOpnO7BhztGMPZal8YrmrU7UNL78LmYEXAw5OOaWMUeO2HHhlLoWOfEaMNCwFaw
 Y9J90ORz7i5v7TYdKpCmuXzQETZ0/TE3KbDbeitUgWh3ftH3boLyM+mW8ZVHgZU+84hc6wb2ndO
 /dEFivO5fvH1FiqVodClwUoirHamJ47sQZVCg1RtnPCcthmN18Siiq7r0oLsz4FhsyE9IXIO46w
 DiwXYUsYbvxVFDsCuIfv/DkfYMB5Je+BvPpudllglf0M5kcLSLKCazpHaxVwJAZxoHOZth/4fuh
 ylpr+HKTBvkckhQMreocLE57zuJ7es4q3gVuev7Bp8lHuBWSUb5FIoDjuOcyobGWHD7rzxgG/Sd
 CyiNpD8wkYnRuOucuIM1Tf8AnrDKyDAhnRw30tkzNu7X/VjWUzBTGVtj/z+awU0+NAkq+h/gcxh
 Z2xP3s/a3yFBH0HWn+A==
X-Proofpoint-GUID: kRg_R-KdmDW1uzALJyZAdD1Ylhof0dhx
X-Proofpoint-ORIG-GUID: kRg_R-KdmDW1uzALJyZAdD1Ylhof0dhx
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDA3NCBTYWx0ZWRfX0UtsznsZ9j8i
 Mgb7tADS6SrQpE5DH9QAZoU8F0zSaUebNTdtP/rELyYVE03H6OGfKMpdnuaxFYSu+ObtT6BT+zn
 +yKgMa6PajD4N5c6/1m80rwMxRr/Djg=
X-Authority-Analysis: v=2.4 cv=OcWoyBTY c=1 sm=1 tr=0 ts=6a423753 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=kq0kPlqncbyAjjsh9XUA:9 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 spamscore=0 clxscore=1015 phishscore=0
 bulkscore=0 suspectscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
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
encapsulate the assignment of the OF node from another device for
dynamically allocated platform devices with the provided helper.

Acked-by: Philipp Zabel <p.zabel@pengutronix.de>
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

