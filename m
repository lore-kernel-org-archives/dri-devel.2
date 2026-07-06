Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EC60C43602
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 12:45:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8AC4010E94A;
	Mon,  6 Jul 2026 12:45:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="jHERcCvS";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="K+K7Gud0";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 17FEA10E947
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 12:44:58 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 666AxVFD175070
 for <dri-devel@lists.freedesktop.org>; Mon, 6 Jul 2026 12:44:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 9qaZhnJqkpFuXNUQTMvf64DqKP1Gcowxx+UUDue+d/k=; b=jHERcCvSBjEX85+G
 wv+iLnRT6hHpxDdY0dS7R0g8NO+qYXJwcgWGOEQO7ZGvZOxy0Q7dy0Hba2un1PBx
 YmlYOgwY9VTQJpR7MOI1xAGU9FfZOlA+exUr6cSSSKOpYVYiMtNM2Oi81hDyX1lf
 rKokYFp+tnknPpil7j22bPQBqfzVNGQF+MkNqwFAcSDBWFQJvlTIgsN/6YOkjNfB
 2cVS3wfKyk97kCwPoRu+KpyRomaPWnLWCcagvpdzWONQt1gYmYfru2mmiQe7+FzH
 cpGKefaudU3KsN9qiar8tJGKvN6TLHIebow4FloHMH9JoqRDGUV9WltOTCKn9V5d
 TJqHog==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f87rxs95a-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 06 Jul 2026 12:44:57 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-92e632390d2so561958985a.3
 for <dri-devel@lists.freedesktop.org>; Mon, 06 Jul 2026 05:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783341896; x=1783946696;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9qaZhnJqkpFuXNUQTMvf64DqKP1Gcowxx+UUDue+d/k=;
 b=K+K7Gud06yFwMyP7y3JAp4lmTNajMJH06K/GE2H23XTofaValMCzq+VNyQuk76rcYz
 FzfWkl75+ZW7YpD8wNGg0zLiVmuTtEndegBSNecCgp5NIDoXiCP4M9zOwSPcvywLrM1M
 ltw8FABc2BvI5ORaJgGVsw0hs2cEwzZeXD4goqfgHWT97SnAjaz3N+KNU6rOzw7wH3TO
 vfVFn6Ewul9P0jB6NyA/4y61vX0J30FlD/lx5CRYWgOnQezN8Js1bwWj/ltprcwu488o
 8TTbf8Mv4sUWl6Smf9d/tku/GOjftnFyt5pT+Qyum1q4nwEJOTHp6IoDQHIVuMqvAHBv
 kStQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783341896; x=1783946696;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=9qaZhnJqkpFuXNUQTMvf64DqKP1Gcowxx+UUDue+d/k=;
 b=kOPLQ4V+XYCPix8f1rgZVK3WHuh3j8BIyKBlaKtg6JaOcxHc9Xs2IXMSp8VkB+Di6O
 P0PjJjB6bX/nr2jYbCv1/r9rD7KbNFDqhXohPrtrtHns+B/Vgavdv7LRlPtJbr7YGNzk
 v7OCx1PgpD8r2yLdv7W65qK1c3Nb63nSBKED2TXnGv8nUNUC1utg+hLoaZSY1uh1W6Ee
 penA/IL4nRocZQSBVxu13GkQ05vaWjdC1T7y85gGFdtOhD9jf6SDiyOIs9pEKrRdYynx
 BQbgg2VBj9KCJj+FjUMAfUGwkb2cn5PhD0TtU/2r1x4uLxchs6PIVw7s8DfgKbUyAeSz
 UaYQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqEinQf7VKiGkzc/tNiAZG1NuA76Bj929BpnxrAHkzWQXiMVa3F1sEQvI5LZbi/C6p7BC0KYr23Ih0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzMDiIuwveI0MZWhrsEJQelN4GBg5tHI1PsWgR3Fl4DauKc1YPu
 /O5RIx8+voT546KolbsIPsF9hBD2Z24jYiKrDvhhzA+U1I05fKCzHbCZ7kXVgsJSASN3bRRnGBg
 JHN09Y5/CdZD92zx2553kPPPGo5H3Q7+D3vSL8OhULLTr5ysx0Fh7XDbSniRkNMplNT2B8Co=
X-Gm-Gg: AfdE7clHsAJgmPnzRehCvxIV5C8cca7WZPk9t33d8voCHHUtEOhkWMOOa8TZy8erS/A
 xJzCqqvG7xPlifV26dBPlijaJENK89CZlJkRV6fZZzx8MdApRKXVjL/b+l9vyf2grxXf1tok2bQ
 QGmKbsAEK32E4GBFxPq6rTTOhbQSF3LHUjthAMaWAl9Xn3xOBO6Lt3K4S19fHoDZ8F4XA+RMGsu
 IEyr/Nx0qfTuXtOv7vg4alt0b+i9Km6jABonyOouLzDq0y6DxBvM8ASQI9fkg3Q9F7X1EU8noq4
 bDybe1p7CvT7oNuaUBUcoLQonBToOFj3347+PUYWHZ5iKIl6VEKT5igx+OpdDnyKjWk9BJJInMf
 A8x7HmbxGhMKa4jMXO35vLUERhvSJg/oPUBsHWST8
X-Received: by 2002:a05:620a:3710:b0:92e:8f7f:e51c with SMTP id
 af79cd13be357-92ebb60a590mr47342685a.53.1783341896226; 
 Mon, 06 Jul 2026 05:44:56 -0700 (PDT)
X-Received: by 2002:a05:620a:3710:b0:92e:8f7f:e51c with SMTP id
 af79cd13be357-92ebb60a590mr47336285a.53.1783341895726; 
 Mon, 06 Jul 2026 05:44:55 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:86f0:c42b:ef4c:d3bb])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47aa0a55be4sm22126539f8f.31.2026.07.06.05.44.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 05:44:54 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 06 Jul 2026 14:44:14 +0200
Subject: [PATCH v3 02/20] driver core: platform: provide
 platform_device_set_of_node()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260706-pdev-fwnode-ref-v3-2-1ff028e33779@oss.qualcomm.com>
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
 Manuel Ebner <manuelebner@mailbox.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2837;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=ZvC54swIjtoLdWic7mjkHUk98Z7cygXvR6WiVNV09vM=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqS6MvV2oOwm8I6DyBnozXcyFSk9osOc4e2GH4g
 DJh76eJhECJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCakujLwAKCRAFnS7L/zaE
 w74pD/0f7wh768Ib4M3VSkBLYD7YQhvFxC2RY+MGZZP+VR1ZlemRCg9DeXdDdSnJSRDL3pft627
 DEvgLCBHwMElpwNSxsMWzEZhXl4R8IEAepNXoxVDXBTaHg3jl8EynFQEcWOeyg6HkMutGn3PMWF
 Wjlt68/Dol/bNnDNzQXKwG4dWAGXaKNln2ReAlzp6+08tymfFK0JoWQ+H+6GPkgzlbEX9CcVawD
 DKACpO8oiyAfEvlpIepcdNMc5lgfc3jv8gQ89TMoB5ERvz+ga96oVvwZQ3Q4ZPthgfz3wAkwDaB
 t8HLs9zAF3hupQ1CpfEox0RQEZDOa40SZwCBoEBN13BQBJ6AroiSGotGwZQQQ9aTWFrgZST4gJD
 SjTeZvyidzE87MxKKYkvxt8NanEKGvWihHCfVtXKt9yMdwr+hSGI96PqwLkOZqj3lOfEjy9zaLz
 Hj7GbbORQ7C6CvDBp8MHQJkkDKHKAE76uGcslbyA89nnGeDQPZQs8bXxFe5imODg7O3XpEA4Bee
 zhvO48lmfv/maHlAUdlg9HdHPPrS7lvHqXMB59rQYQQvr9aCZVoPUC/9+l0ig00xy3Q3MYp2FoT
 xOnkjupxjTDlvOP3c50tvOaWQ5NBcYARj08DrQz6gxBMoL8/9250lNxRls8cpxKP9h/3z02yi9F
 7ilBwmbOytfDmMw==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-ORIG-GUID: weNr_kSvJ4aS1WxmVlnzUzoaLZALIx-x
X-Authority-Analysis: v=2.4 cv=Hv1G3UTS c=1 sm=1 tr=0 ts=6a4ba349 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=b3CbU_ItAAAA:8
 a=QyXUC8HyAAAA:8 a=EUspDBNiAAAA:8 a=Q8RKEeUEMY9O-VPP2I0A:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22 a=Rv2g8BkzVjQTVhhssdqe:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDEyOSBTYWx0ZWRfX+gRalVmOetgS
 rpeG19IHxX2KYiJtCgryM5D8Z9S3+WXi4CaLARWCizAeVh1SLsbaSFBdDRIos7pY9kfu/MkTAOb
 qoBN4hLpeGdzQ+QfWyWzcBh4aT01YUE=
X-Proofpoint-GUID: weNr_kSvJ4aS1WxmVlnzUzoaLZALIx-x
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDEyOSBTYWx0ZWRfXx5kRVgtuJoaP
 jXFZLAwhT1vhZnFuiWWlwLb6aG3+vjaPiLlQd589X7PT16ZxiwdS/J1cT+Ej5M5hwQt3cqSqXLj
 /Coja/M8gYlqbZ2T1h6gmCPotZUhmlig5uxofPbrfP1+M8+LBxeiXIYFbLwQQo7swodhPmqUprh
 hVmQ5Pz0U966hdELdDize8XcCvrndHVn36vk4JcHlfwxDJmANPiW9R62s+s/ZqD4JbLnFHEIIHx
 lNEunr+zC1Ex1PrCVyU56Uq0sRQqMxReN71/DPa9zLhgzMCgqQq+0dl0eGPxfbFTXp3zKu3b+j6
 PHF2k0LNR0phF8Kwm57GFXeO+JSMQpwcm1Glj9v24H7aV1cXqXh1vThlsV5a4ISMxg3dz7zM4ja
 ZjTKMgY8nFhFZDC3nyoz34DpN2McV2byFPJ3mhapJ0LnI17UGYVT85Zc8+SCpiqVzYwkWlZwvmS
 WNPfq77Xbtq1dQO/5kw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_01,2026-07-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 spamscore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
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

Encapsulate the reference counting logic for OF nodes assigned to
platform devices created with platform_device_alloc() in a helper
function. Make the kerneldoc state that this is the proper interface for
assigning OF nodes to dynamically allocated platform devices. This will
allow us to switch to counting the references of the device's firmware
nodes, not only the OF nodes.

Reviewed-by: Manuel Ebner <manuelebner@mailbox.org>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/base/platform.c         | 18 ++++++++++++++++++
 include/linux/platform_device.h |  4 ++++
 2 files changed, 22 insertions(+)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index fb9120b0bcfe0e7dd9dfc0d29b91e0ad40a01440..3188d5aba5f90622f821c695049cacda030204fb 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -693,6 +693,24 @@ int platform_device_add_data(struct platform_device *pdev, const void *data,
 }
 EXPORT_SYMBOL_GPL(platform_device_add_data);
 
+/**
+ * platform_device_set_of_node - assign an OF node to device
+ * @pdev: platform device to add the node for
+ * @np: new device node
+ *
+ * Assign an OF node to this platform device. Internally keep track of the
+ * reference count. Devices created with platform_device_alloc() must use this
+ * function instead of assigning the node manually.
+ */
+void platform_device_set_of_node(struct platform_device *pdev,
+				 struct device_node *np)
+{
+	of_node_put(pdev->dev.of_node);
+	pdev->dev.of_node = of_node_get(np);
+	pdev->dev.fwnode = of_fwnode_handle(np);
+}
+EXPORT_SYMBOL_GPL(platform_device_set_of_node);
+
 /**
  * platform_device_add - add a platform device to device hierarchy
  * @pdev: platform device we're adding
diff --git a/include/linux/platform_device.h b/include/linux/platform_device.h
index 8c566f09d04efe420d85ffa046f92c44c6d08526..e9f7baceeb4c8269dbc0143c4d8fc9d73ba024ca 100644
--- a/include/linux/platform_device.h
+++ b/include/linux/platform_device.h
@@ -19,6 +19,8 @@
 struct irq_affinity;
 struct mfd_cell;
 struct property_entry;
+struct platform_device_id;
+struct device_node;
 
 struct platform_device {
 	const char	*name;
@@ -262,6 +264,8 @@ extern int platform_device_add_resources(struct platform_device *pdev,
 					 unsigned int num);
 extern int platform_device_add_data(struct platform_device *pdev,
 				    const void *data, size_t size);
+void platform_device_set_of_node(struct platform_device *pdev,
+				 struct device_node *np);
 extern int platform_device_add(struct platform_device *pdev);
 extern void platform_device_del(struct platform_device *pdev);
 extern void platform_device_put(struct platform_device *pdev);

-- 
2.47.3

