Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA8C4C43602
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 12:45:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4778410E950;
	Mon,  6 Jul 2026 12:45:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="pEBEjvNw";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DKJsC641";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0802310E950
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 12:45:25 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 666AxVcM219069
 for <dri-devel@lists.freedesktop.org>; Mon, 6 Jul 2026 12:45:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 yRKVE6+HDuRkKaJoGIMm3hMcr4TYQvxtkFJAIQ65210=; b=pEBEjvNwhlEFv/FR
 75AE6ntaaDo+cjE9zeJPc0tRFg9z3KEvNn2sDMpG038HLDN/diaoXLolHmUP1hEr
 3arM67ahYMTcG3V8nXNhWAiEN4NmjXEWxxzVVBabo/tFT2+2AQ4tjpHlfTWYVAmY
 +xbmBYuR2n/bDtuDP2Mr3eQDXT5BrgiMeteyJiqv5mzdjEJH0yidapM91Hqnhlxd
 AtBHzIdyfOy0z3kt+e5tQOM38bwXAp9zivS0jvN/+DnccuD4uPZCewTvb/jSArUE
 W7auaRpL3A8EFHLyO5xFeWMBzjGySF8SF76ztXqsecNdCCpIbCGkhHcgmrSVL0kD
 MLSARg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f88hs93ea-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 06 Jul 2026 12:45:25 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-92e820609d9so217854585a.2
 for <dri-devel@lists.freedesktop.org>; Mon, 06 Jul 2026 05:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783341924; x=1783946724;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=yRKVE6+HDuRkKaJoGIMm3hMcr4TYQvxtkFJAIQ65210=;
 b=DKJsC641NFIOZez9kNCv953piG901wgiFsYEMcBP/j+oYapS5br1mklTuCp7PWzXf9
 jgrEkWncZVqMBPwJlGAN8BOBUseVHE2tByizLOwFm2Ku5rLX78j3r73Dk6e9i3RjqdXP
 T0/Hlk6adg81KmR2XNzoAgcGW1wwW/RGtMIRJ/emsN4egxBNTFt/rDREQgnIZ2+FNYBj
 hmz9NFJs2/eGo5BEUD/1Z4APeN4w/oj3AYYB6gi0yNpIdla+QJssI6h4vldSXCcThMgh
 ryz4WtDtf6tkucwTYJvZUz7Kef2CpdjrG0KLmyjwwfC0ze1QlIsoIoWz18tuDw0rVIV0
 KigA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783341924; x=1783946724;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=yRKVE6+HDuRkKaJoGIMm3hMcr4TYQvxtkFJAIQ65210=;
 b=Cbzr2r2W3HUQ+6ZEuEmz9YeJtxrJHsNdxYrcETPzyRzjfvGtsX6xkF5xhrbPgoIN49
 WbO+g3bxK9yElb5Ac5OoWhZu/Aju9by6B6jK8k54zvsmoHQLzHu+H4BxIKAHH7Nerl/3
 EKmvbasG2CuvSKhdbvyzKXGh0wdHRDbIF8WJ4P5Z5pYl1tyli4rD839HBh0iUh8DGhPX
 2yCUMFmBZMf+tgr4IiNBdK2011ykR1gWTrIxOO8OKT49LEKghioYjuR93uE5ppYnhigB
 W2u2IU6r9XJoHgt2+i0iJekMKGCaNWNNWDmXtJJGkYAZer0w0DG0S45x1ro50Wt8Gi1w
 ydAw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrtHA7ZyjSVEWDuGrMr/4hLGYh9+zrtIIuApJ22uUwPkK4RQYz+3eGEdneUp3teCiMHWuWZEyX+4g4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy6q03If/wOxmTIUvIXov9ZjphFVkZn1LcDw9a5xzft+CQ/346z
 aWp/3iy+jHvK859diEblUJfUfl0p0GwO8fUDIAU4iwxJ34uJax0s9vbQ0xeByY2gdepJkCkcVNL
 h98FdDu8kUjeZLGQcVSvVeKIJ13JGmrkDTwmIdL2DhGLopfJbGbH4/Bv9CnS/2I6No2j2oNA=
X-Gm-Gg: AfdE7cn7iJG86S9pYdC7xbr0pqHPQ+r2chQ3gJJUrWb/hTwTqclifZwOrk3EVWIz0SK
 O4fTUF3bcjTWWr60c3Op58UkSX/n3hcB0hazrS99LP6X18F0O10p8NxuyHPlwYWkdLChzbP+kTp
 wAtg0viCvJR/q+gLt3EHAzPQe6Zc0nEMzuyh+Hd3xor87ZF/YD+eaPadqnsVXWY4MkoSvB6ih43
 XFUijTafFPt42opai4/efGfRo+WFKKe3k0ZyAMK+MCDkbqwvfmNBSR6hmmjcacFnrAp2hZkoirF
 Azo67r1tQGZdfcE5rqAbb8oqu9DSLhFeTS+LBmo0af/Wgpr0T+iNraPI9d2QAvVBAODpKFX8HFw
 oEBnvZNYRiWjt9seF0D75+HDLZk37/4hI/apEHHUa
X-Received: by 2002:a05:620a:8803:b0:92e:9d63:a6f4 with SMTP id
 af79cd13be357-92ebb4e3acdmr52347585a.18.1783341924050; 
 Mon, 06 Jul 2026 05:45:24 -0700 (PDT)
X-Received: by 2002:a05:620a:8803:b0:92e:9d63:a6f4 with SMTP id
 af79cd13be357-92ebb4e3acdmr52336785a.18.1783341923456; 
 Mon, 06 Jul 2026 05:45:23 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:86f0:c42b:ef4c:d3bb])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47aa0a55be4sm22126539f8f.31.2026.07.06.05.45.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 05:45:22 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 06 Jul 2026 14:44:23 +0200
Subject: [PATCH v3 11/20] pmdomain: imx: use platform_device_set_of_node()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260706-pdev-fwnode-ref-v3-11-1ff028e33779@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1073;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=RlYbNp2S/NZv47ECKrSIoSYkiYKDbdmiYZZE8XOQPr0=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqS6M4dqtScPW3ltfTa349WlyF4Im8UV3+gbDjf
 +ziQYf21tGJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCakujOAAKCRAFnS7L/zaE
 w6cvD/44iwh0bO9U8phWJF64dOWOUQmSK2XBLJBtOsastnOKG3frrhIUgQnJ6slnJp9/qK9Sctm
 /VnPVLzutrQEPYTnyYTwegxzfw7z65c+lpG66v6oMVhuEL5dLy/ICU2X+YiF50ymdi27qbZl9Ru
 N7s8Em7rQs4VT53ze/irqmQe+MI5duU6f4NajzV1rW2r+kWg5CJMcrHSndCLLP8wwPdl5R7y8JS
 kYnh2IA3ZdI52TAByyucQlrH1mIQAaAOuanxZRDHGxuaXM8YUtSVvXsoetlgqxw3DCNvaY+wc/J
 DdF30T9KS3cwqlGuzq+vdBBLwJR7LQwXow3VvpGPl2rWjOtJgoygngawJ04/2ndETxEAoD860kW
 RbjA/OtAOe90uYdXCO3LJPTU480tw6BXD/kUFLl2WJUNf03mQBP7TTJDtk+NK7++D4AKFcce/3D
 v6HyypGAdrulGTOBiI09UNzWl7ckMWOWTPo5tgWmIyqOX+keqQXN4SVa8pc/aXcw1oYzaJYvmIE
 1oSNBqM5iMtUohuyDC+ESCLz/kypyOfkI/75EzoaMoOfyuD3s3GW/kC2KQT/Tc0sVNfrEewGFs8
 YrDIoeAOIWV7FEygNZEpjcznlFCcN2Ex1WrAiElKYvzaqDhVa99OdUeAEwGgNXIU+kynK2Czoqa
 wT5QHhsSQJm0POQ==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-ORIG-GUID: ST_2xOTVKi9F2BS0va-9Wesb9TEmTyAi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDEyOSBTYWx0ZWRfX3+zln//3cuEh
 BYmwgZUfCE8xJlJWZ5WzmNcb3TuDaWb9E4nYcALgrPCITuOP013zK1YJacfGaX2eRNKE7yXNFe1
 8ajgbrweCgvgn0wTPu+Ttu+cBcqnm4fJxwvwzjqFuJCwaaZ3UopCeYSRGr4WhzODVLJ3Fxg08ly
 q6RJXkfdgzSZ9u7FBMOnTcQ8/Z2tXB1PZiceJSDdvlZ8d/RxQKFpiw+HKNNGKfG+Jx4gTWl9scF
 WtzA/I3XxC3Sni4lE0INpHGvSboixTeg4uILQyjOXixz30kroA8Eb47SaHJ46pq8gN4tAXMVBlU
 6AG7gI2Y9udQ4XP04QC4yu7OL8/ni5Mj3TgJ4W7yShb4QOqJMNXU22u0s/t/V/rXIw29cYtjuw5
 ySBZmu5j7Bhd1gMGICu/HJP6Ef1kXCHKihGtmvpeu2qf7w7qW1dex6glXS/sSv/N5CMQTKXlK5Z
 SDfC1CnsvP5zxWP6neQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDEyOSBTYWx0ZWRfXwOE0CuJwZXlA
 lSRwqJkGHuCGY7CD9WPJc+nvGL2ODfBqEzDzPsmtEEBJzXDIYJ6CLQYfe5avFVDu2MP0eJKDdfW
 lEHrtWIj3gUJE27SCh8kMMkZLg/kPXM=
X-Authority-Analysis: v=2.4 cv=XIwAjwhE c=1 sm=1 tr=0 ts=6a4ba365 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=8AirrxEcAAAA:8
 a=QyXUC8HyAAAA:8 a=EUspDBNiAAAA:8 a=vTWqO7tZ479lFkmzGCgA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=ST-jHhOKWsTCqRlWije3:22
X-Proofpoint-GUID: ST_2xOTVKi9F2BS0va-9Wesb9TEmTyAi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_01,2026-07-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 bulkscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 lowpriorityscore=0 spamscore=0 phishscore=0 suspectscore=0
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

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/pmdomain/imx/gpc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pmdomain/imx/gpc.c b/drivers/pmdomain/imx/gpc.c
index 42e50c9b4fb9ffb96a20a462d4eb5168942a893c..abca5f449a226fbae4213926e1395c413160c950 100644
--- a/drivers/pmdomain/imx/gpc.c
+++ b/drivers/pmdomain/imx/gpc.c
@@ -487,8 +487,7 @@ static int imx_gpc_probe(struct platform_device *pdev)
 			domain->ipg_rate_mhz = ipg_rate_mhz;
 
 			pd_pdev->dev.parent = &pdev->dev;
-			pd_pdev->dev.of_node = of_node_get(np);
-			pd_pdev->dev.fwnode = of_fwnode_handle(np);
+			platform_device_set_of_node(pd_pdev, np);
 
 			ret = platform_device_add(pd_pdev);
 			if (ret) {

-- 
2.47.3

