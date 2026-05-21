Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71D6CCD5BB2
	for <dri-devel@archiver.kernel.org>; Thu, 21 May 2026 08:37:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B797410F286;
	Thu, 21 May 2026 08:37:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="i8AqoLjg";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="edT871f0";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DDBB810F286
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 08:37:48 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64L8MEA5748388
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 08:37:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 RXAOBdXd+1ffOftB4RMKqDkV2t2QAsqWzgaXmcfa9Sc=; b=i8AqoLjgiIkq7GcJ
 lsjiR0I4WtIojYGqtVtwF52fR6iHWOrGT+oCUty/GufZbKg1DhFJDfWVn0vJe+k2
 ofk30wp/PmTLE2YxNMSy+M499peRN3Ix32hLCyKX2PqL54mJ4UQ4B7BapeUCkf3u
 oQWGLbTVnQaQhCzmq+IXJuEIC+nlDoW9US9uoJvmozj3/boYnXNd83U+R7S/w8eu
 SKRCBNmW1k206+0pxOW21bjP2ZUCfreImjrKLvY1IEZhxLn+IDe+EL44FFAr/BDX
 Q/yvzzbeIQnIWmRf5SYA6WD8oIjvbPeAEmAhwYIQBtz5Y+zD0dr4ThCpzw+Msqui
 9un7Tg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9fb6kjb5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 08:37:48 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-516cde13e8cso222701cf.1
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 01:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779352667; x=1779957467;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=RXAOBdXd+1ffOftB4RMKqDkV2t2QAsqWzgaXmcfa9Sc=;
 b=edT871f0e+HJiDa9HDPBaek4+4IOAfh2+ZdlmU6WH2UgM0qTuHokp6I0RVpFP6olZN
 czZZ4SzIsaMaJbrrafNyVb345+PLKxR9fF+mPLz/vr2kX72+yhTInXlk9iph3AjVzPgx
 xxzesL+1w/3ChTVWVeeO5RKSEC4mcMTZs1nyk+fB23leLveAcyG+bwbwYin+7yNVQ3DB
 t/3/BeuiTuw0dUoDB3gluHW4lzHdIllCgu8stthZdulBStfLF6Orw5ffZgrSURA6/Qp5
 7MhR5Q8dhb3f74g4UN7J5VqVeHP0tQVU6775TIgdbqU/w4uq2/OvorpJiFP79KsZZMs5
 5QIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779352667; x=1779957467;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=RXAOBdXd+1ffOftB4RMKqDkV2t2QAsqWzgaXmcfa9Sc=;
 b=Gu9qwRaJbgJLSi0peW4qHBKz8BzkBd+eZehWjU+IE22x3JSAuAAUPoXLrJ+l9vMeYr
 2eqt1rHmFnHoiN7X6UUEKsUc85zmqGRqEffRX7tcV7pWhdGOJqw5BbIi166UY7JwUrd9
 ZqaSjo57I++kWQTpjGD/5jFmOWK3OJgx2xeDkrdtKvcAXzyGTe35OWcoUHTPe2Jwtrv8
 9QIpFX/RURkbbPACrISzdhjaaL3pFPXtc0ZRejmSUFbsTOVAi8Vb1GbAJi8lJmNqy70m
 z0+KsCqaCAV/JG3/UR3ttj7ORwbm9fBb1rBGXL0OYdpaM3Gx9vhvIzMcBxdB5JRPztv7
 S+IA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+HG5qafH64s2gR/gv5lGwbilnMdgXXKJSAdgxgndPr7DzWHE0oqL5on6MlBYfyfBHrwaQT5nYJypQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxfzSP9Ry1bG+DtRe6sWH9yuuk1XPV55lt2mR/zdZtchCwV7FfR
 pJJbz1D5YhwnOKCTVy8CvoAleXERAekRBqFJhD/i09CezMu8NAaEQYOpe8yrbel5TE1aEjLrr6z
 upqhXh27lqNtlAQUn1DnpqRyWXc5NAJjW0A8HHpPotNG1+Gy3YWnHGNIq5wbqVwdD9rteyKI=
X-Gm-Gg: Acq92OFQ756OOzAqJvdmKUXzO14Ah6ZT5Ba/6u3szAvb/zU5X+gaQU497Mf/lGZbZHA
 /KKzZZfpwxajaubjl6dRrlokdKwQaHiljLj5cLHf+jshMgn5u6PvpBxc7tiyfaP1sDWqc5FHEtt
 OEMuFC3IX8UrTuoBSgzWgidWh+hT59czjOyj9bkhpx8vB+v+ZkfjYGSXjJUc8P4We25suIi8HXW
 3UqIXFvi3lEyiPeja9U3yPsGCx5Q6kz6f1CFkkgumH3KRpdeqSvH3b+4Ze2eEvkqMkCGaIWelt4
 XuLwp/OqMZhEL0HSvw7mNh7h0XVObRef219zc3wOVUWRKutDK/ymhLUJJQE1sy3Hr5PeBC0HKXf
 0t/7uTW/i4zU2rp25y1AwQe3kTTZhA2UI9gEM5LQC+Xs2VXblz+w=
X-Received: by 2002:ac8:5a95:0:b0:50b:4b3c:7554 with SMTP id
 d75a77b69052e-516c5489cadmr25663981cf.10.1779352667111; 
 Thu, 21 May 2026 01:37:47 -0700 (PDT)
X-Received: by 2002:ac8:5a95:0:b0:50b:4b3c:7554 with SMTP id
 d75a77b69052e-516c5489cadmr25663371cf.10.1779352666534; 
 Thu, 21 May 2026 01:37:46 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:bb10:ae82:b7c3:d15a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4903caede9fsm10502405e9.14.2026.05.21.01.37.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 01:37:45 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Thu, 21 May 2026 10:36:36 +0200
Subject: [PATCH 13/23] net: bcmgenet: use platform_device_set_of_node()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260521-pdev-fwnode-ref-v1-13-88c324a1b8d2@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1245;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=6OXt4TN+oyzNJeMucuDRbXfo0ddns7kCLrcZYoYbhVE=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqDsQptve0VPcHpfn+e8CyDZ9KcfXURx6hUsS4v
 XFGh941uXeJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCag7EKQAKCRAFnS7L/zaE
 wyw5D/42tCVAUl2uN4fynwbhyfyAyJgpscqW776mT+6TzShiQ1UGxlOeIgCoWTORPdoxwAORBgi
 PPFLgP8bYFnocTq4h5weZ5vNP/hv2g/J9Lmb/zt927UW8vXxtOottjnSBfTm0u0U/GJ8rgc88T9
 mpUOe+BfoixY7hzEMo1fIyF3WIaT+57oPDmyTNSED0/c4zBG0NtfjvfR+gbfyw+PuIfqaYcqeJk
 tuNS1ok36qM3GOUcpctRgzg3Gcj1c+Iom9FxP0Bxk1yxox6RfTH4YztKKst7Mak64vyUiHCbs8M
 cE6y1P6VvOYN9ijA/4JECYo7OgRJXtVQi1bQi2sofdLn4SkbV9PZe5fLALG3ChG2z+5CM6DLxnM
 ZTA0eltoOvmsMrE2KZKeX1cvWCqDNo1HP2xCCVBojp0pJ8mz7D3yTBHU0hPu6gxae8kQbUK/6PH
 xu98r6TPU4z+Rqt99oM/SiN9eDH0DJrtNLwXfnG3TvI60P81jYDEL0d3DAeVHomaowjoVNIef+L
 drTrKdaF+coQ6GqegTUdvOp7QizyZZfUuFufo6Io50ykK1jKebxa6rHDPedMyGM5//lsygsV7ZP
 qrz3VtMmHLMLX+azIV7Z/k3f6O6HZOx+2rpYF+AVt8E7wZbqRkNX3nvyQt+iEqoBKw3npAZOhCa
 vgpklhyoZwDkrzw==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Authority-Analysis: v=2.4 cv=do/rzVg4 c=1 sm=1 tr=0 ts=6a0ec45c cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=_l4veLwUkFW-k-pZneUA:9 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: UcEiWJfGi1Fb2NAMdrYjji_Gxr-IYeP_
X-Proofpoint-GUID: UcEiWJfGi1Fb2NAMdrYjji_Gxr-IYeP_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDA4MyBTYWx0ZWRfX+lX71+dg2gEE
 Oc7/IxhC2IANVBh0XD0ntCRuGa//npo8fYDfreW8PLBVKxa9jMALdrCTSTv+eiB2WRXvjSw0uSi
 GoHvAx/gcN9ViL/xXNy8qdZzk9ZTB0OaNBR+MxRnLZ7UpcW8qs7dPJERWRJjTC0TmQlBRwR8jFV
 4bcJGeiP+z+dZ9E+1jGgNKs8EcY/AlV4aRM3uNsS5yt0R2BPlNS8HalTbC8cfcfguFBztmuY+Kd
 WMWomj8Y/w7EiMnKoNC/isOU0AN+GyKXwvikpHnsNtPM1nKUa7OqxQ+IDCgBKj2UxqoELD52IGG
 C2cFldKIincKVCPlupJ/Y63EsqLjuBY9sZUdSgd860YjDOEvllDy984jx/B8/XN57lgDx0QocGR
 3vLIErCeGLiU7IqIF3QhtQ1inEL78kptFMOYX5XqrQYwLvGpJ/kDr/x0THmCAprBcI40yp0n1PT
 mAgDJEzbuoSPPp9yghg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_01,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 clxscore=1015
 spamscore=0 malwarescore=0 phishscore=0 priorityscore=1501 impostorscore=0
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
 drivers/net/ethernet/broadcom/genet/bcmmii.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/genet/bcmmii.c b/drivers/net/ethernet/broadcom/genet/bcmmii.c
index a4e0d5a682687533a1b034ccf56cdb363d6b7786..451b23a039cebb777f356f64924838230052dc45 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmmii.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmmii.c
@@ -490,10 +490,14 @@ static int bcmgenet_mii_register(struct bcmgenet_priv *priv)
 	/* Retain this platform_device pointer for later cleanup */
 	priv->mii_pdev = ppdev;
 	ppdev->dev.parent = &pdev->dev;
-	if (dn)
-		ppdev->dev.of_node = bcmgenet_mii_of_find_mdio(priv);
-	else
+
+	if (dn) {
+		struct device_node *np __free(device_node) = bcmgenet_mii_of_find_mdio(priv);
+
+		platform_device_set_of_node(ppdev, np);
+	} else {
 		ppd.phy_mask = ~0;
+	}
 
 	ret = platform_device_add_resources(ppdev, &res, 1);
 	if (ret)

-- 
2.47.3

