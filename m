Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FEF9C43458
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 12:45:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA9C710E963;
	Mon,  6 Jul 2026 12:45:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="GUx5BzmG";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iSD7H0ql";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB28810E95F
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 12:45:34 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 666AxBBA238111
 for <dri-devel@lists.freedesktop.org>; Mon, 6 Jul 2026 12:45:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 POK9tIxGCiwp0V/tTMSRyw6r6KDPw5Ng8BAFX9Ifcc0=; b=GUx5BzmGdeI3Evy4
 TAdA/IjbYevjVSOOVEM/jHBANLO/MzvCLIDPyIiN9HGOV3lzrtsxDYh2CWy24aEK
 e5pwxDyUvASqAikj67tpYkJEHSqpVZx3/eXDlvj8KZ4YJmq04TuS4yBAg4Qm/eRM
 ZEODUiB8+by0n15kbnlqjOE9269w5Ym9DK32zJnFCj0bqmMBm70riK2KGmEZoCu8
 JkOkwNLn1fuC88jPUs0mvgPD+1NSV/SEeU+G8k2TrSp+bpuv33JoNGSTFOPm26k0
 myU/VmbL6eCNFjIuinle8aMsQaDP1VEBKYV0quH0XkvrWv1IekNPOEs/A387VrsR
 n2AyQg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f88t89017-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 06 Jul 2026 12:45:34 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-92e63df032bso328951585a.0
 for <dri-devel@lists.freedesktop.org>; Mon, 06 Jul 2026 05:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783341933; x=1783946733;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=POK9tIxGCiwp0V/tTMSRyw6r6KDPw5Ng8BAFX9Ifcc0=;
 b=iSD7H0qlHcG5Eo3lbyuxelVM5KvcYBFtGfRJm0XCJVAtgo/+njXhb95dqBfFhE1J39
 mZAXhAEvwYSArUb9hpLHDHeIVlQpWSc8k2/zW19gU+SxJ52agblFUAShnC29lBZWo8xV
 gWw1ZBSubfjKdAU4v2k5FSTWk1dL7wpsWNJ0q0wTX46K8wX7D7SKQXlTStMW5JFWG+9M
 YwCRrNA4wkEUumjkQaSWuxUQR5KTCjJ0CT7QUBvUfmoN4J3EqH4x9wiIIAke5/yIlOTy
 frr51bR469TA24yLyVMGZgz62DnLG0N8YBZkDh55qGaFlVii6ao36xxK4Vb17BdxzeZP
 IepQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783341933; x=1783946733;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=POK9tIxGCiwp0V/tTMSRyw6r6KDPw5Ng8BAFX9Ifcc0=;
 b=OBooaErsqWBftd7HKCY/4geSV5c06eOZVqjVuFxgnDssNuxIP/3FICd7pBsa6x1jTt
 1YZMGR2dVJOOWBArWwF8LAECGp5xzfuD5hLQMQnnvT5JsOIz/NdT8DNoZc315GNrxKDk
 R7AYn8E7Gribw1FvCv1SAhGRdpTjz30qdRmc90a+MPq+4lppTX70eyG0VbqOqRmgtunT
 qvqbvjZPeqXwcE/CK9VIorLK2UQ39QoxIUZ/oJZGSw3ofmiUGQnHSVicxeoSPxmkCqWS
 HKogiUe/cevzCX8WppiHSeRoz/oqbTzHMfNerhQVG8wL5tEySgJvLgi/WN5u/JCcv/WK
 Iv/g==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq/Ri3xT5W8krqpfzK3FWe5zxzMYokZ2pWFJaopHYe79CWCFmm2tRwGsE2Sj8kgqV8nUtpeWgqqeqA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwpFQD1Rislg9OZuh7aN7IkKm/OziSaVKB/1WxDDf/DqschWzmK
 6x2KH5VJoAhAF7nzER9PvHpKcoeMFcTprNvLrqZaLeCKq3V7RNv0/qRzYbJ+CjzwplVhWr9pD8e
 48rSk6Wzmmg3LxgBC3NjL3GpH1+DR0iakvBIZvq+RKEtdb9gsgGRF45kmBiP4ct/NU/yu1gA=
X-Gm-Gg: AfdE7cnDGatMkwxsBZW8JGi6fTP+xcbtpQsgc4LZF7psw23BoOdt1AZFHCptVeM7tCN
 b/USm321eOIr6z5tOyyOvY1OnR4+eqhpiaGbLZStAIo7wFsSN4W1LdRnOIjG5xXU4X2aVEmrbPm
 7Iz635JSGpCnKwWZN90AoMegfNGgVZ6y2nxMEZub1sOP0bBJmzZAmXioO21zCXgOHDC/+XXBIfh
 AVia4OJRsyaMUZn0Bun6GqLWe8+VR//Eq7pAuG1VIuY2cwy8MI7wYxtrt0SfufWcCAWdo8PfHkn
 40/H2uShaszf9fjtIysCUiyL52q0zlI/88V1O1870ROL8Mr/BKAh3HfHIvT7VLXmFXOUDnXQZDI
 JjxIRQE9Aq5/WTrBD/qHANi40Iwhvg0463jIVikxz
X-Received: by 2002:a05:620a:630a:20b0:915:9eb1:f08a with SMTP id
 af79cd13be357-92e9c9bae7bmr762472685a.18.1783341933202; 
 Mon, 06 Jul 2026 05:45:33 -0700 (PDT)
X-Received: by 2002:a05:620a:630a:20b0:915:9eb1:f08a with SMTP id
 af79cd13be357-92e9c9bae7bmr762466885a.18.1783341932688; 
 Mon, 06 Jul 2026 05:45:32 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:86f0:c42b:ef4c:d3bb])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47aa0a55be4sm22126539f8f.31.2026.07.06.05.45.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 05:45:31 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 06 Jul 2026 14:44:26 +0200
Subject: [PATCH v3 14/20] net: mv643xx: use platform_device_set_of_node()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260706-pdev-fwnode-ref-v3-14-1ff028e33779@oss.qualcomm.com>
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
 bh=NdHbJPjvsu2u7F3hdYrPvFRlBpPy98KniXg8xIhSKCg=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqS6M6kp8yOiB9vvJ5zjdHbWe6Po7/EnS4ga+ev
 hCyTVpoxO+JAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCakujOgAKCRAFnS7L/zaE
 ww7dD/0amg46FTyYgYW8LYZgcSVagN2XNs/hYCpCDsj0WIQWByz3JPvcwF61FhdVtvUFuUYV+eg
 X7P9kb9yoTHoN1zMJCWDP0kdPaf12F5JdaMy+qsgjzl2P2MgGwuqQQML8cdGlCndeIvBfZzo7nO
 9qijrM7bVX71vT/EpqOJHbzX5gMZmLrDW9GuxO5m4CIjxHImLkOcRCikfjxnV8hepAxrK1AMx6R
 Mc6flJ2X5DdAi7Cru+Q+uLRr4o4JKNA7AxDT5X6V7Ns88ytfrTL5oV6D2eulc/QkqAYGEtknJw6
 chwScCFvjEXtvO9lO7ahl3qlNLbLc+YlVO1T4bKSi285G+axZpIEKet3oauOfTFCM/saAVEif4M
 KuvsN9jfwcJ0xXMRvreW//zyuhY8LNwY3Qn55M1FVhdMhR15xLP9t3gOyKyxu8id1cdmortkJpD
 qrpspj/OgEujquTmIu1nsViAjjB0bI1BWn7odOKePTyRWnujpCUPRgGD9GE6y5D1J3d2h2us/s3
 C+UML2ty3Ar0TmOdfF8nD81xCWgHBwz96BBI0ipfe0fz1VLXXim6Z24Z8Tpg6aFGf6ilHkampD5
 kfVoicCCwzU+89dyn7GdpnULRhUez+rKMA82vKy1zopgY/6h3TvBwUmDbFlk6k9PYM2h/XaSG9p
 jy0y60D4DWCJRkg==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDEyOSBTYWx0ZWRfX5ePkPMWR7cV8
 gRAjo12tMDYEil1qwWojmslEyOpODy9LoJKb+4r1oo6iFpIngg79LnbDy7IaG1102660a/UNmWe
 Db+lYGIbynmR0Yx1AT1AhwzIv94kkcE=
X-Proofpoint-GUID: x3UGd-cpSt9JmiEuCVzEaQZtTWQ_ltlp
X-Authority-Analysis: v=2.4 cv=C6zZDwP+ c=1 sm=1 tr=0 ts=6a4ba36e cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=VwQbUJbxAAAA:8
 a=QyXUC8HyAAAA:8 a=EUspDBNiAAAA:8 a=KA_NOx0aAURzDPfFvPsA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: x3UGd-cpSt9JmiEuCVzEaQZtTWQ_ltlp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDEyOSBTYWx0ZWRfX59TCNz8SZLFv
 iJnNh3QBWGcGGWJG8uxED5wJZhNhhy6isX9No0hGyu1s1Pmu1Cu+R3R2qQX4oI49nTr+LGjsA34
 0JwxAH/HNJj07qpjvfIxJS4FuIVVYE5hKyISmlON/zMQDAvJSTG6SHqsCE1BF+6f18NSkasQmsO
 OUEaIi4ZdAd7nGoCP+hbfC/aRdriN7VdtWtTDL/6nOSRbPna6Dqp+3xIa37RLkrQyN02dELHm/y
 5ESy6cLCADyA9NSx2Lun2+cgFPQak1Nyd+Ub0e1wjvDDYF9+KN10Z+REQx8Wsz/YQkbjCE3VnGS
 YSb0DD6szeff2u0mrODw1XGqZY/F8EOJNzEYCGnnK//U9A7hlp9SXtH8ZiRzdVuDvSXgT7Yet+U
 SbtbpkBSnUYdTMbG5x1ppG6V/LDaJvZK6ZR57eOH7ounP/nvO10D/Pvj/mYM7tp0g+dor/DB036
 Vh2Cn+ymJTBakCI4qQA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_01,2026-07-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 clxscore=1015 spamscore=0 adultscore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607060129
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

Acked-by: Jakub Kicinski <kuba@kernel.org>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/net/ethernet/marvell/mv643xx_eth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/mv643xx_eth.c b/drivers/net/ethernet/marvell/mv643xx_eth.c
index 1881583be5ce2e972fceb14c2b8348280c49ad1d..9caa1e47c174c9d7a161b7f2e2ee12a829b813d4 100644
--- a/drivers/net/ethernet/marvell/mv643xx_eth.c
+++ b/drivers/net/ethernet/marvell/mv643xx_eth.c
@@ -2780,7 +2780,7 @@ static int mv643xx_eth_shared_of_add_port(struct platform_device *pdev,
 		goto put_err;
 	}
 	ppdev->dev.coherent_dma_mask = DMA_BIT_MASK(32);
-	ppdev->dev.of_node = of_node_get(pnp);
+	platform_device_set_of_node(ppdev, pnp);
 
 	ret = platform_device_add_resources(ppdev, &res, 1);
 	if (ret)

-- 
2.47.3

