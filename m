Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7CD1C44501
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 12:45:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2237010E954;
	Mon,  6 Jul 2026 12:45:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="a/7z/rGb";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="F4zHC5ln";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E37910E968
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 12:45:44 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 666AxHS4174777
 for <dri-devel@lists.freedesktop.org>; Mon, 6 Jul 2026 12:45:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 EUfyESzsAY/c9b8SXvRccGqhLUlXVZyUqlQZtD72q5o=; b=a/7z/rGbeBcIvVDJ
 IFDIH+aKe+Rq6bW2ZZywPVfdOBkDjOYZybq/HmQbIxrR9rHxQNmH5uR7ev+okVyZ
 1vs2erWLxD1FRKaVG2EZvA6yZTo/XaVJG26Oi1+1UVqrye048RZy0jMEtXljlM3S
 3wc9rXhHpSBA6KYlGC+2SzdyFMxHjb/pofCugYeM2qC2HMkiWuECBOCv0QPoD4NT
 207QzNR00AGH0LzljPDd9/F4reQ2J9H63QtxytIL+40USJ5acX65rNwpzn/p0eo+
 5t6nrFJ0zECuws7bsV8rEXI0WrWCRZ2JxdrYduR7F8Eid0ozGj6ysP9QrkPsQc8D
 lfVu8w==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f87rxs9aw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 06 Jul 2026 12:45:43 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-92e62e3459fso253062085a.0
 for <dri-devel@lists.freedesktop.org>; Mon, 06 Jul 2026 05:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783341942; x=1783946742;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=EUfyESzsAY/c9b8SXvRccGqhLUlXVZyUqlQZtD72q5o=;
 b=F4zHC5lnLImlnRaT/Y+8iICk9zUC0eNX5rPbsjybxVTt4Hz1QZGJZ9dmgG4F63pMDK
 KVOhSzol+cSBa6T3plD8WDT/2G19sq1j8ogksRgmSwNvajXiCqz70yHlD/YF7Ob4IxLC
 +44iVx6/0M8ORoZZJMpCbQWCiBbP4FWZnZKefZKdSiQI69DI/I2/CqWhhL9o5034FllU
 2EAYkrHzsO3gon8csWMbHbjWQssKaAuYvGL+wmpBoU/Xbnye+KKU+267R+7/b7uq8mvT
 NPWb56yvxYmof+5atj+loqJaUeTAEZ761uSEMT7i5JUIAAci4RoiXRVY8uXbjWtUknKQ
 aZZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783341942; x=1783946742;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=EUfyESzsAY/c9b8SXvRccGqhLUlXVZyUqlQZtD72q5o=;
 b=gi11iGMcfOosjBMsdL2eiXmQZkw0ReSRx6OeO28TbVVc5976fItWetpDIp6YBt9nJg
 KV4JBYty0fvtPNWPKIhVHwRHA3wtfRR5U1Oflhz+AUC6VpTHQw+R70MAtXpvtvzjoHVC
 puR2PfcF47aAFB7eyQsnvfXF060Ekf/sM+viurNwMuSiNKcJ/jy7kwjg3VhvA2dJu1iT
 sD6amCSkxdXZti6cufzKAVYoaKecgeyS+3/DQDuQtyGGGOLLpjDFgqRuMuinJbO0lcfN
 AsgCjod9RThOHKbmwU8XRhvRuvUUuw+a20VSK3T/zbDe/NqKZW0RSpiVN7YElxipxiMs
 tOUw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrJkYEZIyanL/FT1hNf3hIPVzXZj6R0p7J83tyjanoI49nAKrCy5s4Obr4Tgsu7QbX1ZuEubXI+n9k=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz7XAr55JeNbXz1OhS7YLgRovuoSbXi3dGRqHx/vOwrkHRqVfnc
 PYJMxMa0QsZTILvGQGLP7PkiQVspzVRa1K+1uR3RDvYhKoGKQ4lZFUpPNEovLxtuFlVMO2+cE1+
 7tnoluuZIVRkIpGnDTzlIOyWoJbxO+ZKXSiqLHkfCMKeBG8+mxgO7zlWmPXDrfrFYuC8jDKg=
X-Gm-Gg: AfdE7cnnGTDAI3YWZtSTVnPrt9BhCVAt9Z3HvyIeExV+iczfeZu2lMS2f2ifwJOc1eH
 ABBqJ9CL7lM4HzgnnhdBSIyDNpzKxbEnUG5I2HheSXy23Wn3tu5wS0kzr56sawO9SKEe6W+ZsYf
 eNfoOraYhw7Tj9RvtnCO1reR+jW67H+XDP33uVX1q4M7xebOETblOvLePUWODIEW1m16q4u+29E
 sJ+9ZYc8Az5/5kb1M5GLkjkJ5np8hmhV5k4gyqUjqrCijGhfZ5UAkFp+YENWDDQ55k7JHYSUJbY
 /gXsiHQcxZWvjBXFYEL9xYkfFwjuNLJs9MsE5Wl5tteBo6p6bsa8Y9M+w2+kS4glkSM2oSF+5Wu
 yTRiVJg43/L/q+RWfcC1OeCaML1ZV1RLwYCQ43P2D
X-Received: by 2002:a05:620a:4709:b0:92e:520f:1631 with SMTP id
 af79cd13be357-92ebb528cb0mr55258385a.1.1783341942214; 
 Mon, 06 Jul 2026 05:45:42 -0700 (PDT)
X-Received: by 2002:a05:620a:4709:b0:92e:520f:1631 with SMTP id
 af79cd13be357-92ebb528cb0mr55248485a.1.1783341941714; 
 Mon, 06 Jul 2026 05:45:41 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:86f0:c42b:ef4c:d3bb])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47aa0a55be4sm22126539f8f.31.2026.07.06.05.45.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 05:45:40 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 06 Jul 2026 14:44:29 +0200
Subject: [PATCH v3 17/20] usb: chipidea: use
 platform_device_set_of_node_from_dev()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260706-pdev-fwnode-ref-v3-17-1ff028e33779@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1105;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=JInI6IaLUgntKCu+uREg9rT+W4Ko13o9vFl7bGYELR8=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqS6M7wT/WHgW6r/IRJ084xmgiF5frbzCzZ+Ysd
 KzpdXXnNqGJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCakujOwAKCRAFnS7L/zaE
 w9ZRD/4qx0uZLuhxJ51kkTfx6+/ADFF5GoEfFNlEUJaWIKNche6TlU9gsv8TAwWOVwjbJrU7/xk
 sOhCAgEztM2nKlx6ujhRKxl+2TjXk2Nj2Bw4ErxTPNWcqaXZ1D3EOtzXJ3LEIh6TWcNXJCdwsGP
 svhpNoB7rI/uxv81g0JAGCh/QKubVkGYKQ/A+iC6UlkliVEVpj6p1u1gu2ULARKemU2hsn6iUFA
 1oRljszB9ML08rf3vVWm48Sov56fj0qlhwFlNhsJc4Fh5RjWbTDkVRumhciCbBeIO9G9C/i7/ln
 WxpGscgFQ1NqoWp3/aek1bpZ7Scu9xsMTp8jTu27iLrG2C81p3vja43xg1htjZOB5gZQOfpcwi5
 EetLn2abLuSiU1vPkjPCFip/qUHPoi+jb9okhj6gHUX6yyIsoLN5g9ifxmgS6NS5OJyVqPs7QyK
 OigCeHoGtjy1bCMPG4Ze2LA711uVJ/GHLSCxqSL2dHGOUpJsWXjreBLn6ahYXEuiyhvPA9QJPto
 Erpf5q8bz8AMXTE3CMDngaXoe5hPQ2YBtHJ+JMsuwTzK96EQrncN+e7YeNhqCC781jl3KUvObTa
 xxNIMne5snlFpSJr4q7dnJofBuyZU8anvtn71Llv/YtoY1RbDUwojYoG/zLeVQfPZRWRgelgizR
 S6rTgyuGX0mjiBA==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-ORIG-GUID: jbaNkBIokY7GviUIvEVNAqe_nLxoXX8u
X-Authority-Analysis: v=2.4 cv=Hv1G3UTS c=1 sm=1 tr=0 ts=6a4ba377 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=VwQbUJbxAAAA:8
 a=QyXUC8HyAAAA:8 a=EUspDBNiAAAA:8 a=kq0kPlqncbyAjjsh9XUA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDEyOSBTYWx0ZWRfXwmEqTwssQKNd
 381uT6whI6VFCRImrcMW4uBbwbYo53MT+WboOXFBHY2pP/4eXCnQQiO1sSuhu23t3SySdooDzlM
 5E/pQ4eiIz1Sj6OFIrDClEse5eHRY94=
X-Proofpoint-GUID: jbaNkBIokY7GviUIvEVNAqe_nLxoXX8u
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDEyOSBTYWx0ZWRfXx0oOlEuIByr2
 9YkPqLez38EsZlQiswIj0nL+W7RqeHrjPrpNuo9USGagOgEH3HU38G1H64YbJ4KApyD8oTqBtIt
 kUWVTlLiclbHVvMxO+dKXnhknW80jNG0cYNULr47gtAspyB23Fql3njVKHEh8qpcLIVZEuBlnSs
 npB3F8rFV+ikMLIEVO+kizkrrkzblSzdNhf4AnCYKPm10Fd8nlEwVfqaynOgmNxwXEIBnPTEJhO
 2sWutUtrV1AsjpqdF0XGaZQE9LHHEjj8F/0E1kevRF4Fb+ehvQ6wxCzmKLG91znEceXy+qrcqRR
 1eKPm+MjH6D2MvPbr53xSCEkX04aP5DpfpUFUEdkAaB5BY4SAF6eafu+Mupv+OeveN5XeJIC7A/
 YFn5Qd4aBz/nVD5MsydMWvTymZJhEZEYHdS1i1l/vl8VlUA8oQ9XyV84IdEo76rbeVfWrIG5rcf
 63xTqJFAFau9K2rIrzQ==
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

Ahead of reworking the reference counting logic for platform devices,
encapsulate the assignment of the OF node from another device for
dynamically allocated platform devices with the provided helper.

Acked-by: Peter Chen <peter.chen@kernel.org>
Link: https://lore.kernel.org/r/20211215225646.1997946-1-robh@kernel.org
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/usb/chipidea/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/chipidea/core.c b/drivers/usb/chipidea/core.c
index 07563be0013f4d28ed6318a0751670ccef01d0a5..7edc512cc37dc24551efe5fca172777a0a4b0766 100644
--- a/drivers/usb/chipidea/core.c
+++ b/drivers/usb/chipidea/core.c
@@ -879,7 +879,7 @@ struct platform_device *ci_hdrc_add_device(struct device *dev,
 	}
 
 	pdev->dev.parent = dev;
-	device_set_of_node_from_dev(&pdev->dev, dev);
+	platform_device_set_of_node_from_dev(pdev, dev);
 
 	ret = platform_device_add_resources(pdev, res, nres);
 	if (ret)

-- 
2.47.3

