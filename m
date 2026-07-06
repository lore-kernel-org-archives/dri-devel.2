Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C716C43458
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 12:45:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8598710E957;
	Mon,  6 Jul 2026 12:45:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="egnQ2Z5J";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Q59JICJ4";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 34CD310E953
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 12:45:13 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 666AxHRm174798
 for <dri-devel@lists.freedesktop.org>; Mon, 6 Jul 2026 12:45:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 yWy7bcZQwuuzEGhH6M9TUt1rOdo2WvLdyjbDuBMlhdA=; b=egnQ2Z5JIsW8dx+C
 u8ZNxCzHX4SWRQVEeSTnCHtfHzI5Za8qAqUcnBs0+107yrfXKqqJaDIB2u0a4qdw
 3zvy6xZX56ger6pSWmDNx0if3RgxUWVCuPQOG2+g/F9nEtFuGRsOmnRbKVr88MkS
 QSvdU3dPEIYIlYTXhyVQuNRHqB5ujD6vqW+QbMsBpzX3WcLcnYIbSjQvoktVZbD8
 Pi0uIkls8WltwBDbJpRvrcC4O8WtLNRfHnt9R+cYIaXaiaMzJ607KZFb7di2KNpu
 tNlEGchhAMcCdeMNTtF9JIqQJtABet4hsX+i4NX9vmypJl2Tmh87vfFUDwvwWGum
 tjodUg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f87rxs979-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 06 Jul 2026 12:45:12 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-92e8004d60eso478170585a.1
 for <dri-devel@lists.freedesktop.org>; Mon, 06 Jul 2026 05:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783341912; x=1783946712;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yWy7bcZQwuuzEGhH6M9TUt1rOdo2WvLdyjbDuBMlhdA=;
 b=Q59JICJ4Ph1xo81S7yEgGye3EazHxW1v+AqgbwDgNGKQbydHg2Aw9pNzaJyyrmYBpO
 9bySJd3+oWz/ARD/tMHIiDtDfVKvYVVDQGLpzEVxQHeFVppm5Y1aFK8mutGUNfZyN/is
 pG+94ayBJqnJvtqituP+L1BLv81DaUiY7qgxu+Jux81rsvdgyPfxdpp/D+2KXr3D4uJ+
 FRu2osPW0P/1Pn4Bk4rtjUeRji6tnDWRvMZYkeWj1hSYe4RS6wRkgvmAa+STd7OpyKUu
 CvaxqsZ2YMbilguT+g3QLQQE48fIRK/KhOAnM9oU7S0ZdECafZrz03js1tv1qU4mexQz
 vNDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783341912; x=1783946712;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=yWy7bcZQwuuzEGhH6M9TUt1rOdo2WvLdyjbDuBMlhdA=;
 b=emWJs01Ks3jAH/N8cXIvQpEFkXiRxLtbLfHm/epbxF/K5jt3wPgwNKRLjesBOynnj8
 htj7FgkfTEdJS+EkyZKMIsIbgE3l0H/omZPyK7dVizCJWKIOYyxg6OrzsSLEhKjsAR3Y
 3B+4ZENxYXCZi+2Sa5I1jOOtUwI8B3QFxili09tV0L7V5mvLeXxrlIhkiT/7ZyO/Sgpy
 ooY8kWmbDT9D1sm+3qxggZP5iyBeDbEct7WgFnLIMVSYnH8OHzNFBWc2J++HBMl8hHph
 hGkguCtgrmnyBx8hoEs5W2JFdtL61aR3m4BU2oAE9FO3qpVxYt2uG1Ja7poykaBvCUcY
 yoJA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr7YRrIV9oMhuBBoT76haK3K1cWYFTHZnGRxE0ufmBrOVi2XAdC0EJBwk/yvcdjUnS4IGJo5YyUNFE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxt4u250VyQkl80GAbjtf8W8Tcynqt4B3hOSeSna8cPEQNBJRtU
 oToqkrlXN0Ea1vIZUQdThSM8KsZKtXL6VI9DEA0G0o//m1QWvpzTq90OrM9EBHKi4D3mKoIdty/
 7qFTmhJQtUY1dZ4oP90EP5tVEdTH4R1AgE7eqzkgPj7KCEckF8oSkPZGEhzflqpJvBXpMfHs=
X-Gm-Gg: AfdE7cm2Oj76ULpDvsunQ0gT6PWQtMPM7gnc99fsUWFxsatw12gf9kxYBmXAPbyLrF/
 rwk//Cvul6bbKov0bN7q0YVtUDgyXIOkVbAs/OCNSIpY1agWPBDyUoWUd3wpH4hV9BPXkBSiY7/
 2xN2ykA04ExOfP2VCCsWfpn8Sdn82zIseYVEHIqTGAzr1G6UnKJdWh19aG7l6Zuz5cNOUzQZlPB
 2Mgpe5tuFyTuc9UNynX6CPXuAGhA/1zXtPfmaDxqQycsZyz99kwqQvz2RT/TuRxXakm9ehc2JOi
 ZZyJkh7aQ5J5GKWpVY9PObWmV1c3O77ciYLUEGt9tOOIkUivWhpvrw8Y7F4fi+Pyodemf+K6gXP
 CgExPk7+AhICMy7bI75VDH5YS4tq1hUSuD5+1V44s
X-Received: by 2002:a05:620a:43a8:b0:92b:6805:917e with SMTP id
 af79cd13be357-92ebb72bf7emr41508385a.70.1783341911538; 
 Mon, 06 Jul 2026 05:45:11 -0700 (PDT)
X-Received: by 2002:a05:620a:43a8:b0:92b:6805:917e with SMTP id
 af79cd13be357-92ebb72bf7emr41498585a.70.1783341911066; 
 Mon, 06 Jul 2026 05:45:11 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:86f0:c42b:ef4c:d3bb])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47aa0a55be4sm22126539f8f.31.2026.07.06.05.45.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 05:45:10 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 06 Jul 2026 14:44:19 +0200
Subject: [PATCH v3 07/20] powerpc/powermac: use platform_device_set_of_node()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260706-pdev-fwnode-ref-v3-7-1ff028e33779@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1109;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=+1w/ZPBEKC35lIaC+2VlK0kcwhdpXj4b1de+Kko1D9g=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqS6M0U6BWsLnbNRlpQxwDdS83jcJMNhZ/7eCG3
 cBpgbJrCuOJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCakujNAAKCRAFnS7L/zaE
 w0wcD/9CEDRN/JtI/f1e/XC0nTt6drS5plkhZNCFHV5EZKxpgDTo06KnuPFGExy9v7E5rUTrZSd
 K/RONRwRA8d86X+ZL6U04BJU8VydBvO31cpLKQ7gRAfVYJD8MI8qYoyhV8tSTFdr3MFnuiVWS16
 pxw9ameDANBtKmCmhztyXe47aHDEdi2zHnyugwrFNK4tnqbvzbpFWtZ6YMbolsTe0FhEMZkl/5J
 SlB4vdmD9tlCmDWLoojLW8uyavDrafJdotxvQPFEB1CAWVRUhHIbiWa87lvPrbmr3N4HnPiuEWS
 0jo88f1RRjKnf/ACMLY0bQDKyXMMI50bdSuf6AghGyhRbrgRByN1waRkNW8IxiXsx48wXV8nXRk
 OlvTfMrQR0rKTTc5stHBEJWjR/fVz2s6r6FxRQ6HJ8zbXbHJAPN1DnPLRNF7AmNGG4tzQXHazSc
 yrKtXi8cE8BipFRwuXuZEeUxLEixu7ewIGIJos93NzNRnwxizNpfEReVReEUaaZnubo2cBtEglw
 FF7f3QsGJyjtfTTtc1oqYEi0sK+dx4JQdqknNzcF2DVrQ28taO90Ta2l4zSabwMV+1CiOm8wwpE
 EXhc0GB7kYUkAT2sJt5KM2eqKKsmBm4FeIgeO26w+V/+g0Sp7NVuoHW1Za7xkWCgbeqCH7VoWSu
 bX6IXrHrjAbXvrA==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-ORIG-GUID: jM8TO8wHbsG_jtCFrhHAkEQ7akgc1x3D
X-Authority-Analysis: v=2.4 cv=Hv1G3UTS c=1 sm=1 tr=0 ts=6a4ba358 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=QyXUC8HyAAAA:8
 a=EUspDBNiAAAA:8 a=kq0kPlqncbyAjjsh9XUA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDEyOSBTYWx0ZWRfXzO07KxiTZXgF
 1kqQGgifdqyG/2bvOEYNQEDqlYsG1BQVooUFu6Ct2eofAY6hBmj6dc6vI00v/0bqI3asWh+FB8u
 /P/kDwiHLwF4GFgOqfbHw+uhvwsESeE=
X-Proofpoint-GUID: jM8TO8wHbsG_jtCFrhHAkEQ7akgc1x3D
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDEyOSBTYWx0ZWRfX9om4KATWndgc
 N4vPNyUtMCGiJU0UxYv2tH+n3f9ZMcrAYDaUsUzdrSbUQtHZuTAmjYlXxvki1WOYJ9iOv/PxP/X
 5VZef5ioqnJzm45J3A/abo7/vPARZlEcfS70hSKGlehvStyBtmIahBpClb98oSDqYVPVf5ivTu3
 fBhzuZVBm//joICgR3BDMTf/kMYr1ijygrSJaF3RPXtkq0M5ox19bQFPVobSaRNJ1HQ0eGGd80y
 lKFcUCVOSyRxodM5it3ytjuZfQc1r3yi5kxlAsISFpUFmym8rJwQ61M/JmFkfdyRhk01IInHk/N
 WK/y8lc4TNUnEjyhLKFsZk3+iQWu9ymXo5B9TzEZjxI6wZLw9cWb9yY/vVOgwE/S+2lBVTSNNuC
 Bk83+F2EapGAWKDPA5IxQcRn3HDK/14xP89AcFLp6LCGY/U1SEsPEP8M510qOuzMviuE7vX3+mz
 s9i8OrFd0F4qXHIs5bw==
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
encapsulate the assignment of the OF node for dynamically allocated
platform devices with the provided helper.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 arch/powerpc/platforms/powermac/low_i2c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/powermac/low_i2c.c b/arch/powerpc/platforms/powermac/low_i2c.c
index 973f58771d9636605ed5d3e91b45008543b584d3..a175a32a222bab4cc7400f6ab6071f5630db2cb8 100644
--- a/arch/powerpc/platforms/powermac/low_i2c.c
+++ b/arch/powerpc/platforms/powermac/low_i2c.c
@@ -1471,7 +1471,7 @@ static int __init pmac_i2c_create_platform_devices(void)
 		if (bus->platform_dev == NULL)
 			return -ENOMEM;
 		bus->platform_dev->dev.platform_data = bus;
-		bus->platform_dev->dev.of_node = of_node_get(bus->busnode);
+		platform_device_set_of_node(bus->platform_dev, bus->busnode);
 		platform_device_add(bus->platform_dev);
 	}
 

-- 
2.47.3

