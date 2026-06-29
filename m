Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFA38C43327
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 09:14:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C306D10E7D2;
	Mon, 29 Jun 2026 09:14:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="jXRgvZnj";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cKsy7L+X";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 260B810E7CA
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 09:14:00 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65T8O7Io2348325
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 09:13:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 p1CXheUuAMODxr2cJ8/mrzTf3yj1wuZdPj+yzX83Vyc=; b=jXRgvZnjw5GcHWfE
 EdU7pqnfu1aWmT1Qn83DNUkYLXZwtGxZctz5Pk3eozOWBd2IJevGjeFy9d+S2RDI
 b3b72IXqCckD20juun7ZhHEfyVD5nJtyyHcSQOMo30hCVGZxHgHELkthlpER1Vz6
 0Eb5Qv15bCrjQT7N9QhM13gtQQB9/4AUtNto0lbiDQOJcoHuuSzbNTdq8XEOHe/G
 c2tEUTwdqe10fVkez/t5upUYrbnnxsM4T48AAdSfvA9y+NZG3EJ0istb+YJ+knp/
 bBGVlhKOwCxw3JF+ZskQRCKUV8AxFXwVEJSQu3IZqDJMPo9bQBuN3xDFCfueJBvB
 aptFDQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3n5s07hy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 09:13:59 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-92e55721a8cso64009185a.1
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 02:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782724439; x=1783329239;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=p1CXheUuAMODxr2cJ8/mrzTf3yj1wuZdPj+yzX83Vyc=;
 b=cKsy7L+X5z3ajlrvPdwOM0LoFerJq/sccWhwbk9Ty3p6nwHR5tzoQrkMTeD1L0o6+z
 rt+UTIqldwcGycAXLv2KdXRyS0iW3HYiSDswTUUY62d6Y2hUyjgCIYDnSF34WUXov5Ag
 FCd5RA/83chnOI8A3vJ9/+393powMT6ex/5AxbyfP9diPFI3BLBuogJPKAfkO2TGubwE
 7s+1bzBvc5JMypzZDnNxM3ZUGDDo8JrpT2vJXHAFERzjX9olyYkk8bERc5OCCxFFcwjQ
 I6aniX9Gbqz8rZW/wU4oY7TZIz9uNwGx8k/d4VIQjw7XSW24lFaDctiMQNJIXsgSrk8H
 jPHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782724439; x=1783329239;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=p1CXheUuAMODxr2cJ8/mrzTf3yj1wuZdPj+yzX83Vyc=;
 b=kkcUgNQ1PwKs322BcNLiZ3m/VItZb9+yrhni9bbWNEESYDuP8X1FoTeEAJUt33YNZp
 5+eeUiXgaHfBCH+wNXyb52WH4Dcp+oq71bnL2S8D6nq9Txwm9CFtIKtzG0sr0Rmtb0yy
 v91uy/MQXN/E+xd7VjUI8RCIJ1/7JCcYhnmSqS0JGallKhxW5Up59wh90G3N5LENKpXo
 gvCvjtkRg8eQ2x/4G9ZQdfC80U9RsjnKXOWwGRIKweGo41KTxEm3hC8ehC8Hd8rrgXYb
 vmJkELDMOkL/xy/t9nYfVyEBSuMdJFoxezBC6pztSPP3LzZ7dCySQ7XgPmvQ4Vz7D0A2
 fPHg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8Y/ynJfi+ssHodBhN//LlzYIm+ZGMNY1KLeoSVStldNmF71uBGOar1r1iEoGsjGemPBPDytFm8qdQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yym5+1PzlaZsFPOBfeQ+xWPWm4+L+AWdzynUA3uq4L5zTBv/qAR
 rRAUTRq8HnkyT2HBBrSU4sIc/rIhUbuedP2FX/Xid98Fnrixl2mX6qn40Qj7dHDenZ9U++/Wl0j
 dGcg+ZCluIlF9HSIjA4dMITLSfz19kEkikkl9ZVFEtlu62Hki4YsmuBv7UnKi7Env9QPXyVw=
X-Gm-Gg: AfdE7cnlT3mhe/igZx+COz0o6l6dDTkk1YkONymElCUuwjpwrZ1TLd9RDMqmex3f9po
 CWjLWzxXmuwX8uM5/69m1W5DSrSz137tRV08pZYM1LecyAfqn/LBq+O9l4vmN5zsT9ifovgqEhx
 2cP6rlw6Y4w2BsClr2ZNohNR78VyWMNaigolW/6l7NfnPDEL+ykosa10Mmpm0LyHVyb7h/4dyZP
 cTuHvCXWkNQchn8pet2F5tm7Y8XKpwu1UmaQR0bXPSJTIRUjV1eGpjHkJxhZdlg4ViMyRaVad0P
 iR40b924YvX/EFNTJ4VoS6VDWM9IbXackjFCcoqqPm2J3xzFBbnbw5NRtLOv7UBiLOVYJCtEn4F
 UIWGzg5guFYMVh9b02bj7WssubBsKRgdCCllW8fDi
X-Received: by 2002:a05:620a:6499:b0:915:9273:9239 with SMTP id
 af79cd13be357-92b3b6eeaf7mr1315075585a.13.1782724437351; 
 Mon, 29 Jun 2026 02:13:57 -0700 (PDT)
X-Received: by 2002:a05:620a:6499:b0:915:9273:9239 with SMTP id
 af79cd13be357-92b3b6eeaf7mr1315070685a.13.1782724436678; 
 Mon, 29 Jun 2026 02:13:56 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:4640:d76a:6126:9b65])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-470f55acda0sm20109240f8f.23.2026.06.29.02.13.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 02:13:55 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 29 Jun 2026 11:12:42 +0200
Subject: [PATCH v2 19/19] driver core: platform: count references to all
 kinds of firmware nodes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-pdev-fwnode-ref-v2-19-8abe2513f96e@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2549;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=VEyUxYLMr0/kZUc3hQzqiXRE39K4YPDPrI9dGBJJGzo=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqQjcV2ZO/mjVvS7fscrieifMk6bWNF2AN6BkT5
 4dxIfGu2nWJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCakI3FQAKCRAFnS7L/zaE
 w2YpEACbPZSAaWOfh+OuT1Zwlgz+BsRRZZy6cDhBoTiUeYqKdcPmZxipz2TsAMuIlfYPKLh5abm
 46zQkAaG1vtOnsxm9+NTs1QAQ6xkDAoZzhIZMDHqyOPOoG8Gr+0mG5poyrmzhIJ2gZetsvDhSUg
 9BI4HNO2Ya2KjeYG+sFBfGfeJBAYbg81BgstPscXYSUTtblGBlW3R8dYSpD0xb5mS8spl+VhdDC
 3Eyi1jA28rzmPeRic1GeilgXo2ivpXQ1UGz0YeY2OdeZ5bq39rMU95OrW8kxMNV7LqUcxiPdxrK
 +fmmam/m3oLoXNKVFHp0LsKRGjrxZAtCV1oUDuNsQJqoEgaj695Gpkmr0wyk53BDm+QyBQTKJ5a
 azgRvH9HAuBxKvtCV+7ZH9BC/fDFaMPQ1RHKQWg5aIVDBh6TePB9H7+5enD4z+jF2LEogBad/L2
 GCZHbciAEbPm7xr2qYxHLMIgDFckOP8wAQjTjPZzrk8O6H/L1KbIMZEro0kRYsSBj/ofkZho6tT
 2RFWYf+OCFS23k9vsQNHX6T08a2EQEIL7w6cyBp1iSio1pHhuMvlvnT1iKOkYXSPxDK1FPJmjOi
 NZ2QX1sApJPEihNT9LGA6nRo6KyHttwNCAeYh/bhtKB4gUErD3iL6L6N2RotJIEEZbbdzq5OQma
 y6IZyLYWBBndyZg==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDA3NCBTYWx0ZWRfX0ItyJ49/JCCh
 248v1IASAwS2pPofPexEP2WfQIO9/RiMIvQqggTZx9nY2Jx1tRj4aHaykUwxBCAan1cD13tpw/V
 slNeKZNpne+JeB2eN2LJfmFOTNObf0Q=
X-Proofpoint-ORIG-GUID: 7LlDWCqJ4jSpFuRnvqoYeHYt13w90WeH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDA3NCBTYWx0ZWRfX9e3u8boOUJaq
 TL53G+u2cuaR2go25uvt43PRQMKqcf1NbI1HHNhWH06fIywKGz5neMgW5nhd5bAyl/YbvsRsAKB
 DA68WvlBs6zOB1clRcCEFOldlXv1vCUDcBQIWjhoL7IfyirqP7nDVJBUUxfpoL/eCRC/zOHq+kE
 J8fOS+HrFSgdW8Mh5NlM6QFKkwDVna4xe8dniGpx+2UOvHFwopNmvVWqCGDXOBkpiWv2bLl3qzg
 p4jqV+ZKrbaAnAX71EtEJV7XM3W86CpXKQf/McHqg+PhOAtdlfRWjLR9/GN66KYqDDilV0p9EFS
 ZqVwhcLQi2RcxmhiOIpzKOIjlv7nQIIHokrhLq88AHz+PbSnagVHAynQaFj42qfA0rKYHc7Ilzo
 XLRpk00pkcNsXh5mxucDTmQXJj62Lv7wye5OV7ZJDVWppt1Y4gvsQJZBqOcGC3M8/db4tcoCbh9
 i1vC+kUFtgO8a+l3i/w==
X-Authority-Analysis: v=2.4 cv=NZzWEWD4 c=1 sm=1 tr=0 ts=6a423757 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=2sGp0kyKjRk1obZUzdUA:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: 7LlDWCqJ4jSpFuRnvqoYeHYt13w90WeH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 spamscore=0 adultscore=0 suspectscore=0
 clxscore=1015 bulkscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606290074
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

When using platform_device_register_full(), we currently only increase
the reference count of the OF node associated with a platform device. We
symmetrically decrease it in platform_device_release(). With all users in
tree now converted to using provided platform device helpers for
assigning OF and firmware nodes, we can now switch to counting references
of all kinds of firmware nodes.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/base/platform.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index f24a5f406746b53ca9eaab9472f6dd1345e04ad6..bb5f5bddd047d4ec6f238e36dfe4f4ea36b92a76 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -599,7 +599,7 @@ static void platform_device_release(struct device *dev)
 	struct platform_object *pa = container_of(dev, struct platform_object,
 						  pdev.dev);
 
-	of_node_put(pa->pdev.dev.of_node);
+	fwnode_handle_put(pa->pdev.dev.fwnode);
 	kfree(pa->pdev.dev.platform_data);
 	kfree(pa->pdev.mfd_cell);
 	kfree(pa->pdev.resource);
@@ -705,9 +705,7 @@ EXPORT_SYMBOL_GPL(platform_device_add_data);
 void platform_device_set_of_node(struct platform_device *pdev,
 				 struct device_node *np)
 {
-	of_node_put(pdev->dev.of_node);
-	pdev->dev.of_node = of_node_get(np);
-	pdev->dev.fwnode = of_fwnode_handle(np);
+	platform_device_set_fwnode(pdev, of_fwnode_handle(np));
 }
 EXPORT_SYMBOL_GPL(platform_device_set_of_node);
 
@@ -723,10 +721,9 @@ EXPORT_SYMBOL_GPL(platform_device_set_of_node);
 void platform_device_set_fwnode(struct platform_device *pdev,
 				struct fwnode_handle *fwnode)
 {
-	if (is_of_node(fwnode))
-		platform_device_set_of_node(pdev, to_of_node(fwnode));
-	else
-		pdev->dev.fwnode = fwnode;
+	fwnode_handle_put(pdev->dev.fwnode);
+	pdev->dev.fwnode = fwnode_handle_get(fwnode);
+	pdev->dev.of_node = to_of_node(fwnode);
 }
 EXPORT_SYMBOL_GPL(platform_device_set_fwnode);
 
@@ -921,8 +918,8 @@ struct platform_device *platform_device_register_full(const struct platform_devi
 		return ERR_PTR(-ENOMEM);
 
 	pdev->dev.parent = pdevinfo->parent;
-	pdev->dev.fwnode = pdevinfo->fwnode;
-	pdev->dev.of_node = of_node_get(to_of_node(pdev->dev.fwnode));
+	pdev->dev.fwnode = fwnode_handle_get(pdevinfo->fwnode);
+	pdev->dev.of_node = to_of_node(pdev->dev.fwnode);
 	dev_assign_of_node_reused(&pdev->dev, pdevinfo->of_node_reused);
 
 	if (pdevinfo->dma_mask) {

-- 
2.47.3

