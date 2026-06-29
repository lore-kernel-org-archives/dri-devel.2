Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1702C43458
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 09:13:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F2F8C10E7B2;
	Mon, 29 Jun 2026 09:13:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="lka551JY";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KkR1FUhG";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BBBDC10E7A5
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 09:13:12 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65T8wjEr2391905
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 09:13:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 BmmK6vf3xg5kSs+g+NySw3CxCiN6R9NnyD/njOvPVjA=; b=lka551JY52AAQD0N
 E1nsTsclnKJB9amehHdeu7bzmvQhFFyH9jnIDHlkrxX+7hSdRvhB8oznWibv1n47
 TQJ93IOSM+SS3HBW6OhkTYu/8uBEGRh96wB+2s3baNMiaHwcod7+emf0GARrG4dG
 ujmpsZ/GRFx64Ut0bLqS/upYq5ytq9s48TVwl7RViMDdtwEFBTi3PdvLviVP2MFm
 YTUb+PFU9akJEbNi8hyUgnaCeAdALfzfFj3s7iFe38BNuMC+pavQ9JJtRHyTehT1
 FLI6q2M9RNjFVtvofU3cjlu0pDwZzcqZgMmAje0zblGjFrXVez6nANvsIq9pnj3H
 KnpFzw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3nnw821f-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 09:13:12 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-92229624a71so571577585a.3
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 02:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782724391; x=1783329191;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=BmmK6vf3xg5kSs+g+NySw3CxCiN6R9NnyD/njOvPVjA=;
 b=KkR1FUhGvJbX5tmIhvlAfk10eS1lo2R++jYrlq2ahQdMP2V85oAGnlhGqrroUPEL6p
 gGRsgFTZg7PYOPh5AxIopuq35DAdmorfQ+NZLBPcOiK3MBWlg2JPZ3EzeAhbRMDM/CWk
 nOcF8GKtQt+gSxQSPtvum6L4lOsKm+pNusG4qZpVck7cCjl4jPK7z0JTXymehNlwyFMI
 3iq/xdQcoLcoiWQe1XF+pz62fii3q7o16MR3eOFSMAXsnEJS0fryGfx1fnTjENij6bdm
 Hp9P2WXuN/7VDLVG0g95HwqKjX1rpHbynO/FMD6HTKWCqioAsnF1GjLCyIbuU5uxXjpL
 QQQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782724391; x=1783329191;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=BmmK6vf3xg5kSs+g+NySw3CxCiN6R9NnyD/njOvPVjA=;
 b=rTKRhdeb03w5BcQcqvZbNZnSXJfJnUMF+dKLORCz79qhA8icc1B8Jzq5hLzLcKJz3f
 VTUsWQy9is5KSUxg3p/Qzrtk1+KRvK7OzLj57YHqtYc5nCw7DLKkF0K586WD2AHShP60
 S9hW4zbn6fY1TDdyETE/KYMFaSfut+nluA+tV1bov5trp9ubxlAYveopDG4lPSs/Otxu
 P8FKJLHqo+EF3Tlgn/+BlzLAdlpQnYmYhTv5fo/XC4DF66YyCG2D8NMtuDCFiNBI4FPs
 APKdhpU0bWmMwe63sNi0NLBES54+bhKwV6WfrlbBOvWfzye3OCX0rjg/IQ8ldHweiJ6K
 jJpA==
X-Forwarded-Encrypted: i=1;
 AFNElJ++sXZ40d83iZNvrXYfofcSVvoXdi5kGTYi4nE0QGSCWPHoqti6guBP91jKalJIY5NejJlsSOrjpD4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwFkksJ0rJElgDt/H0vdFjSjl4jYFPHlXYwjudoMj52/jMgeKgs
 WrTy+gS15fDBx4HZA7qZX7L2g7PkvmaDd+86ZF5lueWIoF/itopUxzTf8wBDCHafYhW2E3FBJW4
 eymdh021gUtZAKE4WeHaAdYly0dVih/z77utpKjNM+5qK/b50iHivnqrmF6RXbzDU8StCFjQ=
X-Gm-Gg: AfdE7ckFu+I35FHssZIrSWC3a28sNzS4rHpdS0DNz2NSECbDMtwnwyqf0MYA/XzHWGf
 STTHrwMya5Yv1xNjR3VR28TNf/CCl12tjmu8fR06kSSUQ0coup8te3X0yMx7lPUQPlgAHdDCDq7
 ajDLAh1zrNrfbXnQGzkoGj6lJk94FhA3UhNOU5KinrlVfVkReSHoE+uo6zBw6wzWbqGzhPdzr5O
 SaP6nl+4ydVjK3zy+5JxIGixkhn9CZAyktXrNt2034LjvaUaJVwOLO5l8wpFYWPMgD4vND8P3Mi
 tMCnd28aD+SNnpelaE7Ls/qPzApjyvjM+RMpjVDcSrBbYydPoKvtFpMZZOmVsiz9tVnemZog26z
 Z0hvqh6ZRlAxXEUp8q/tqEQCMm7CN6vTAKuiwTQON
X-Received: by 2002:a05:620a:a195:20b0:92b:4ce5:6390 with SMTP id
 af79cd13be357-92b4ce57573mr1026440585a.25.1782724390869; 
 Mon, 29 Jun 2026 02:13:10 -0700 (PDT)
X-Received: by 2002:a05:620a:a195:20b0:92b:4ce5:6390 with SMTP id
 af79cd13be357-92b4ce57573mr1026435185a.25.1782724390191; 
 Mon, 29 Jun 2026 02:13:10 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:4640:d76a:6126:9b65])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-470f55acda0sm20109240f8f.23.2026.06.29.02.13.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 02:13:08 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 29 Jun 2026 11:12:27 +0200
Subject: [PATCH v2 04/19] driver core: platform: provide
 platform_device_set_of_node_from_dev()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-pdev-fwnode-ref-v2-4-8abe2513f96e@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2284;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=4Xem2fZJuhLkEpQ8AuCHhmO9dgYwD7FFiD2wwhhVUBk=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqQjcKKhTwBlGLPKN++MiZnFDb7ToqrUhpCsLFF
 bslLR74S6qJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCakI3CgAKCRAFnS7L/zaE
 w/b0D/9hlzF+MuyoI63nIic0Ze6VbI7qxNCbhn6uZeyniPLgZtbwhc69m2JUdgrAsHuQj0IpgJ5
 RCEa24lCvBE2SclclefxC17v1wor7uj4mUrvqJAsmjgFueZdPPr1N600723ruBzPxuJumeQzssh
 jlRIYTX7/407wi5FmqwD448VpGUlB7Pa8NNjN4IxiVGs5XNbGOoj/im/ZWZEqGnDlSu01mcNJ6H
 iCfItNYSQATbNs8tXytgXjr2lFulGi9myKKDBQTaxbB5YtuL+8nWjUC+8o8kzBnw0EB5rK2I3RZ
 xOnAwjeUNAsnoHP1h5Zu3bola+8Dt77547fO6ziravWksfKzGMhGBTDYqtHYdVBNiSbOu01mOhj
 wW2esT/uXcCEuSBCz5c6WMXwwp5oY07WTlwLR5FKetn3Nr8g0u7Jct0e9Ae0Mt7+sOKVLeVMy6H
 VRRwZ02oyzNv6rvb2wurGxqaqfrcXzQuJCOYNJ3jXfPXjuhBl0/jsf/Mh+jygRzqUCoxEpt2gB4
 VgJ1DsNmgpFosrKXs4a3l3flS+45sPbHJm3BdJMiIo/xXOgRhIEL8CNJjywDB0OugyemEEIs2ih
 rS4p2TSq2yTzG7YADPWUwWt9NpbmH36Qfqd4amAhIgP0uFrRnLP+2T42NgZ8X9f7xOLG6mDeruO
 VLhlU915iOWWEBQ==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDA3NCBTYWx0ZWRfX0oxfWQ4qPhIY
 CdRC66vEmrk1T5NtJAhziwTCD8pQnXbWfU1gvNo04X2bTWkwYf/v0h403QCBhEXNljiT2lQ6u+T
 l9+kRF21zo537nA7u/g1kwwGjHrKBTA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDA3NCBTYWx0ZWRfX7XayopOWEiKs
 JplmOEjsdjl7ONCUvhZNQJQbAznwuq8bMGAoLP6/EST/txEiN0UE3+ppEMs0Y8/TUccphrSaKXO
 mtSFDWG+ZIjjAiktSxn+yUTdpzbxj3J2MoIm6NK1GW9Zsz1v4FqoQ3zrCmojTklgBNKxwl40OXx
 IOBjrPAsMlaCvcokcR3+1jW76E5DS3SpNHvV821axBbbeC871haDcbdZ1rt/SvVlCkDngBopgUn
 5WGvpr9LM/vhASG5bk5sHgwVsYHGytMAbDsSZA7ON3qcltlhdP4P3uhe+WIAJt0CuJnAF3VQEKM
 lzNRlrXWL42+EVy+8f5vx7pO04clduYb5SMoxAwX/nuoA7PBmfnFzIw7yahOoBrLbFndKbLI4Y/
 LgN1AUiLsOrFlh5HmFnU+paYqRR8bucG7ATJBPCjjvS/9WSpHzWd6LvVmMDGMwtEluzppGnfTp0
 +f7WHHuAqN3fLRfl4pQ==
X-Proofpoint-GUID: v9vXJafoUHk_PIC2VjPK3MmHM_ev-SCc
X-Authority-Analysis: v=2.4 cv=cefiaHDM c=1 sm=1 tr=0 ts=6a423728 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=hkCPowqfBUTF6yk2FrcA:9 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: v9vXJafoUHk_PIC2VjPK3MmHM_ev-SCc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 clxscore=1015 priorityscore=1501 adultscore=0 phishscore=0
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

Provide a platform-specific variant of device_set_of_node_from_dev(). In
addition to bumping the reference count of the OF node being assigned,
it also assigns the fwnode of the platform device.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/base/platform.c         | 16 ++++++++++++++++
 include/linux/platform_device.h |  2 ++
 2 files changed, 18 insertions(+)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 6520b70cf3052d683a2ecb1a0dd7227575546ba0..f24a5f406746b53ca9eaab9472f6dd1345e04ad6 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -730,6 +730,22 @@ void platform_device_set_fwnode(struct platform_device *pdev,
 }
 EXPORT_SYMBOL_GPL(platform_device_set_fwnode);
 
+/**
+ * platform_device_set_of_node_from_dev - reuse OF node of another device
+ * @pdev: platform device to set the node for
+ * @dev2: device whose OF node to reuse
+ *
+ * Reuses the OF node of another device in this platform device while
+ * internally keeping track of reference counting.
+ */
+void platform_device_set_of_node_from_dev(struct platform_device *pdev,
+					  const struct device *dev2)
+{
+	device_set_of_node_from_dev(&pdev->dev, dev2);
+	pdev->dev.fwnode = of_fwnode_handle(pdev->dev.of_node);
+}
+EXPORT_SYMBOL_GPL(platform_device_set_of_node_from_dev);
+
 /**
  * platform_device_add - add a platform device to device hierarchy
  * @pdev: platform device we're adding
diff --git a/include/linux/platform_device.h b/include/linux/platform_device.h
index c463d46b7b9ab6b891df1ca9f0c98608d2bb140f..94b8d2b46e913ebcdbdaa3710f008f478b59d7b4 100644
--- a/include/linux/platform_device.h
+++ b/include/linux/platform_device.h
@@ -268,6 +268,8 @@ void platform_device_set_of_node(struct platform_device *pdev,
 				 struct device_node *np);
 void platform_device_set_fwnode(struct platform_device *pdev,
 				struct fwnode_handle *fwnode);
+void platform_device_set_of_node_from_dev(struct platform_device *pdev,
+					  const struct device *dev2);
 extern int platform_device_add(struct platform_device *pdev);
 extern void platform_device_del(struct platform_device *pdev);
 extern void platform_device_put(struct platform_device *pdev);

-- 
2.47.3

