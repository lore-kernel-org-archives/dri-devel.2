Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7E4FC43602
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 12:45:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E05810E967;
	Mon,  6 Jul 2026 12:45:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="gJh35zU1";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MVOuf9az";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A6C3210E960
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 12:45:40 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 666Ax9t3391059
 for <dri-devel@lists.freedesktop.org>; Mon, 6 Jul 2026 12:45:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 p51jH23aSJ9P4hgPBVXfrJf6rqkVYzBZRhHms1xVt08=; b=gJh35zU1SYc059Mf
 kDmzOcoi8OfW6ne7PvGIDiA0fUt9s1YZpBnz5nVNLGXFepzjq+wO6cJlTtHczuDD
 ZGqYtYQUPKB+pVGNdLRTXkKNfZAAbm4v0ug8pX8PFkIaNGBY01+7NSHsN/u2HN5Y
 tbm72Yl/fWB/aTmvseGlpzcobggBnxVRm4q0Gog3CtksosQwpxEDcARFFDPfPkpg
 ChwullFaVKNGGJR6F92cq9S6BLPebAuiOUtq4Iz38rx+/oWMW8Ott0xZJiW+0YVd
 2dbOKMC0L9HHcKIfxWOq/UqBsRV7quCnrptznzywqiW0Xb9yNcRzTdtOklJNiczb
 qZigqw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f89kgrrjd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 06 Jul 2026 12:45:40 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-92ac0a54110so334700185a.2
 for <dri-devel@lists.freedesktop.org>; Mon, 06 Jul 2026 05:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783341939; x=1783946739;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=p51jH23aSJ9P4hgPBVXfrJf6rqkVYzBZRhHms1xVt08=;
 b=MVOuf9azuvSiBRlhE6qS7F2zy/9/oXJ6vdtOSUiiJ+E2bxgKskpI8qIZ6sxAKDmg2M
 z2YnWqIkvissRDKb+Uu/l0iKCrJCiuwNWpHfbsAIfOPPu2jtmGwYWs40ZLqpAJHCqume
 km4LkqJM1+SE01pXPW1SzNj16nrHiLoy38gapFNGeeZYRwnUh1tg6xiD23sUtCpEU4SX
 iDOjEx9A+VO3FO5taCyCpH4Z68+9IVbuNZWo8HEJBGMEkLCf32vKhXrImMOLS+RVPSJa
 445f+CYtlQhZ09FSxEqRNagkj1VM6NCRBpb66Y03dX0+g4JG9m0yKW9haKHqKCN//kyP
 8Ncw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783341939; x=1783946739;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=p51jH23aSJ9P4hgPBVXfrJf6rqkVYzBZRhHms1xVt08=;
 b=KFi0PdSuDxhPyRrsIZKxTah/HBwDjKl3JiPa5kr5QX3Tu0mqvQfiACwOeNl5W01ui5
 LDaQOhOrzlA2x9wY8LawoxBrZzixr18swCr+mZkTMGcwYdGIUltOZos2JhyTkctQbx/I
 v38RQ8mpCqlceDt7CExN1Ore8eK8lt5qmem5Ci0nB3rALYpimt3LxnMiBKAcUSBiP+l7
 BdQ4ZCZu5ULad5iWEueZlB0iDZhI9jTeC8kzTfJ4fZqdlOk1XxhkVfQp3UyxZoWuJJkd
 +Wi0aRz5Yg//gs2F0NpROd+tRd9cpg/Zj22SuJ9Pi0rKwtOpA9VBTvCXJvnE44HPU2AH
 TX0A==
X-Forwarded-Encrypted: i=1;
 AHgh+RqQTIRAm90KRmTiZePHcDQ4rj8QZSMSw1PoMuX0eP4woIBmdf4kKSV1i503EPwQR78nvsdNu4Ny0rM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyTw2Mrz8UwBPm5RAeOdI//IcuJEA7J2qFRbJ/m+2dB2lUACLfP
 t9YnhcGn4OcJuGiit/6ptpvGDczBe38xWxIRDVnUSTXdJiK+MdHZU97QWo1WXoEg8T5qVpNm92X
 4EXpPAicmVOc+ySmwz8HE0EVaCgHf5tM6TGMl47tdCdmZKGCPAJ8arip+aPnpynpCP1f8dfY=
X-Gm-Gg: AfdE7cljOQ1mmFncpx/yHsuo5klLm74yJVyav6cU+jVJK6jhMb5oEX8oxgshFMI0Hg2
 icTGjTBl/5zl0+q8ZteL9Ku95g9KUw/BWMlVU6f+loo42sjdDLUOkM5yDCOTWduEmxJMqRTIit0
 BeNlYIDHiGaXtGRybr4cfQHuaz+ybJj8iT2IjcZ6cL4wXPglqglVGRmH6TU+N8LQTj14UI/GTN1
 exOGZWE2VtxoiiXSAjGS1IoRPhrJn6FiTvFtK47SAj4bIO4nA328J5gS+3i/xt1Cw/vTa/Hk+Z3
 OAmpRg7ktX1a+YYYYF29oejoiq7LO3nkzGQUbw3rkiCqgPzBoQnBqARFX/7wT+/NGO2uX0RCLaR
 9GnND9gmLFWXvdiaT9RPCgshDd1CMj5NPQ+imGM/t
X-Received: by 2002:a05:620a:1a20:b0:92e:4b7b:b509 with SMTP id
 af79cd13be357-92ebb71dd15mr45115685a.70.1783341938831; 
 Mon, 06 Jul 2026 05:45:38 -0700 (PDT)
X-Received: by 2002:a05:620a:1a20:b0:92e:4b7b:b509 with SMTP id
 af79cd13be357-92ebb71dd15mr45109985a.70.1783341938396; 
 Mon, 06 Jul 2026 05:45:38 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:86f0:c42b:ef4c:d3bb])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47aa0a55be4sm22126539f8f.31.2026.07.06.05.45.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 05:45:37 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 06 Jul 2026 14:44:28 +0200
Subject: [PATCH v3 16/20] platform/surface: gpe: use
 platform_device_set_fwnode()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260706-pdev-fwnode-ref-v3-16-1ff028e33779@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1014;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=dJOOLkzsh6Wqn9Xl+Q2MUEX+fF/xdnyRuGBTZrS3poA=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqS6M7vyboAnx1GXm4N71aps9kZIgDjWS536X7B
 R0DvjC/PLmJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCakujOwAKCRAFnS7L/zaE
 wxGND/97BgjATyNhjWpgHVy2n/eBlvyk9m1ACiooUS3Aa21bdFHgaiofDxBxF2cMiA2c0EhNy/t
 yCcK3JPuDx80ppfSjGwmjnCJdeW76uOUgrIR9fEkRhfl5uXDdZ1UuNvgSgWqWLPpP7FiX6sQISU
 ekCOzOUytlF/cDiDZmOMYv1swMV7subHOQoxVfhIDmwL/RnlsR3WOql3VY6yXb48yLv1lXH+B1J
 yrWVkN8KdzQRCrBmBxI6FV2+Slzy1n9it28F0VGGE9eLn7HC+steWu0qWnNh3Df6XBggoSSSgD4
 EV4WaMWdLM/lWmxcqjsEOYh7A1HPAhrpPOfeelnV7dj7Q7t3fD3dF5G9ToZyjI1W/NybHHU2lum
 LT58xttRQ4UNCfwia5kKUaz6cTYDVIucBYOQyaiGnyC6BMlWkY4JjkrMp2YuEdsSxfG0+btmhsX
 lpyOd277A8TCDmgWDOzZ/8tOKvnV2sKttsOGgUMIWaihJYfQ/aS2xnC1dEAChFukUZlIWWWm3Qp
 JHwEuPx13B2be7HKRm6PQil7pRAJHYi9tAmAp/de98huRMq7OQpOJeR3s6aJtjpd+yrRyoD71Q9
 7X8ByYmBR/0kT9aixxj5YiEcTcNcX1dbwkXRGocTR+zDiXrImgKkI99Z5SjhG1gaRZAbVFTqEAX
 XDRBrIltqvBZ+0w==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-GUID: NYVbMerByHKx0Z1AKOf3_EWrcjGwJf8b
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDEyOSBTYWx0ZWRfX99SWa7oErN37
 3GwXR24nJNeUEr37smlPTYPOlwrhpXQeD4RGaTb2MFDpWI2/groy7QBqtKKx+sDZ0KnIEyPWZ2c
 5lY/nKEda5jkWiMtyQblM6wdCr4JEv6be797d17cLeWIK4aiGX+D0mAxgQbXxe4uYsAqEmwQYTG
 KUh5CI4fZsqFF5kQiN+IUEIMB8AQkkISWlkinOIlEyp3w3eTswGJEGo/tMU+L/p7tBGcJD1aO49
 xe5jrZwex7i7z1ryPsxACOzMyL84yz7icyhYDL94vLAftXdAaXLP5IJ2LuA9mDg+mMpBB6LXeY9
 J9GT0cLxkUdI9YwVsNtnrrBEUIZWHJNf+HopnIa52YuLzYhkpUrKIy7iSIq/5WtLyfCAMT0NJ6r
 y0z9mmB9Z5zgAylwSgG2y3kUl6EofAdE4GJcJJtKOo6F4o4IGK3oChLNDnFTvdFx50rq+HobcHZ
 +zPA5EAN0yKNF2pyvmA==
X-Proofpoint-ORIG-GUID: NYVbMerByHKx0Z1AKOf3_EWrcjGwJf8b
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDEyOSBTYWx0ZWRfX0E8LkJ+NKmJX
 8oGVupbhpDZ4XimUlBkJLg30S+Ir3580Do+IxrZo6tXxDs97dxtQjZ3NQIAFPCoMNpP2CmjVvyK
 rbyfs91iK7b0ZPyOtl6gykRwoimRhJc=
X-Authority-Analysis: v=2.4 cv=c6Sbhx9l c=1 sm=1 tr=0 ts=6a4ba374 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=QyXUC8HyAAAA:8
 a=EUspDBNiAAAA:8 a=PjYnKYjuuXkzxcC25kYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_01,2026-07-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 clxscore=1015
 adultscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
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
encapsulate the assignment of the firmware node for dynamically allocated
platform devices with the provided helper.

Acked-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/platform/surface/surface_gpe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/surface/surface_gpe.c b/drivers/platform/surface/surface_gpe.c
index b359413903b13c4f8e8b284ef7ae6f6db3f47d72..40896a8544b0a4da4261ea881b1eaed62d93b32b 100644
--- a/drivers/platform/surface/surface_gpe.c
+++ b/drivers/platform/surface/surface_gpe.c
@@ -317,7 +317,7 @@ static int __init surface_gpe_init(void)
 		goto err_alloc;
 	}
 
-	pdev->dev.fwnode = fwnode;
+	platform_device_set_fwnode(pdev, fwnode);
 
 	status = platform_device_add(pdev);
 	if (status)

-- 
2.47.3

