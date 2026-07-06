Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8D58C43602
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 12:44:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A990010E93F;
	Mon,  6 Jul 2026 12:44:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="dx4jTolU";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MuQU5EGY";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 79B4C10E91C
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 12:44:55 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 666AxHMD395393
 for <dri-devel@lists.freedesktop.org>; Mon, 6 Jul 2026 12:44:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 UAsGd5ApODao7ya5c+v4THHQP6gUJNMav6AFOuVH/oU=; b=dx4jTolUOG0UpNFm
 MhBn5F9xncEGRrD1T/WbYOIOs3i3znC4K9HgDJ61gDB6xdRp65m00l5wnZldKlsq
 UGKJyHYuRgj2rx1yWFj98+JVTvIWD8D1tW2a7NNrmZD+Omhoi2ZzFx+iTqY3BhlR
 bQmeEoKzIflfUDGPi2qT41yIeKOQOyGQ69C+JZVj7HLmBDYemJKOwPFP4nMySxMW
 pNU+tFMx9q2xdwoKZI//juImwOVohKqTD7WpP3Iz5UKAc32CYWiU4tF5Z6Zs3Ifh
 Us2AaUOVjlI4TsxDMCWcZKl7cPWFLrvNrmcTpAowAidmXbdRF8YY19EhLdn7H4iX
 z+F4rA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f89qpgqhf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 06 Jul 2026 12:44:54 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-92d1cae5939so296048585a.0
 for <dri-devel@lists.freedesktop.org>; Mon, 06 Jul 2026 05:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783341894; x=1783946694;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=UAsGd5ApODao7ya5c+v4THHQP6gUJNMav6AFOuVH/oU=;
 b=MuQU5EGYafZwbkfUS4YFfMLgimcLqxdKVmix94alpSSbmgirDj8Og5D3TNxhu8VArg
 dk17nDHfjSqp8imL2pqTBKvdRCiOvvmdhPYy1IoEPpgoJwOUnVw9jZu/pgMiwhOUK0Wl
 CYrOuxLnyCP13ZlObfbgyTTJVXJ00lzP0xZ1UF45slrHfqXKzrufBt5mnKW+JZEr6kx1
 ZdgWNKSMCnxRi5VNCGPlrEbTm3cRf+OjQab0kUzett1YOwLdIH+TGZgSnlaW/1Le4wXg
 PBo1MgEhxwFhTVtQjm3nB54fsNV0q+Cb6morJIa7huXuxaZqDoKtM7gG36qPzP/ZJmmj
 01Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783341894; x=1783946694;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=UAsGd5ApODao7ya5c+v4THHQP6gUJNMav6AFOuVH/oU=;
 b=g8jb7X3ZsZYR0DDXqvyGJnMzeyZ/eaIx7lQG/5QKINVK2z4AUlI+z6X1nRHDr0IbMC
 lVXil5p1n1gEE73p9zX5Az8SKMlgatRItWNZWgaZ3UOMFLiuAhtrzZrLsgvSTuJVSoHp
 kBVwvjE9VVtl1FlCPzp4hrXIdWlBoF2W5DHnn/r/4v2qmKDT/ppj9nyMCs4hvt2oEpzW
 olcvLbVYvR5/YBNTi8nGtp6Z//hxeLe80O67rj4c1yt/hVsz+O6diKTPJxOxVdy591XK
 1QAEh5vh2k9Y/V7cPui2cbBm/sr+aG4Hh8I9k7MPj4UuL3X/GGrTuATYaBX/gN23CQHs
 7g3A==
X-Forwarded-Encrypted: i=1;
 AHgh+RqLqAjSH57yGVQqXO6JZ7ksS8kQm0v7SOEInl8JzN9nyxKo/d+wtiCOmY8ATaJedSDe27MAR62rlE8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyNPICVyeFoWTvIeUhugpx7mnw/CtdYIDTPet0b0DGWNDaMGgni
 0DUYVZLbtVTBEQqt7zKSrdEvl1zEYIpX91lVc13msvZSLcJHkqiIDR3GrKAxsC5LCNP59QN+grr
 q3utfOvzoxaOB51h2uN7967+aJSQdcPNPB8y97U0g6QsV3cJMUx99owWdpn8uo7Coal1U3vE=
X-Gm-Gg: AfdE7ckN+VykIbXVOnnNtNdEpqCHIrlUbAE6IEJDtTQSQMRBW5OdDvdOK1LBmmn7xLx
 afgcjWMmSeMqX3Nte0xlcWEtqJvhCR14e4aEY8oqrdfC99D7tHGycimfPi4BokvntQK2d8gdMg+
 iagJZTzaWmwKEcFx9WTYmtKwgkzcK7jfa50kAAgeCpv1uZaW4vJEUUbqoGXO6ASsoe6vgQs3TwR
 BQAN1Py2tRy5hZsooNjO6XqNlpV/OFDHAwU2nwEC78X8ESVUdw7I6zVttfbiNiBzTgH1B2fbass
 mbPMcBC6SK1Pb3Np9yLSl6apPaOGZtgiFrszPdd/D1GSPWHPYGJxdgaaqRvCciDmoT6lO3bUzAg
 t+xkdvEeuAZ14OoEBOCtbr97eMMQRWTazU6g+lP5Y
X-Received: by 2002:a05:620a:2b90:b0:92b:67e6:8ab5 with SMTP id
 af79cd13be357-92ebb5a355cmr48466285a.63.1783341893749; 
 Mon, 06 Jul 2026 05:44:53 -0700 (PDT)
X-Received: by 2002:a05:620a:2b90:b0:92b:67e6:8ab5 with SMTP id
 af79cd13be357-92ebb5a355cmr48456285a.63.1783341892757; 
 Mon, 06 Jul 2026 05:44:52 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:86f0:c42b:ef4c:d3bb])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47aa0a55be4sm22126539f8f.31.2026.07.06.05.44.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 05:44:51 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 06 Jul 2026 14:44:13 +0200
Subject: [PATCH v3 01/20] powerpc/powermac: fix OF node refcount
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260706-pdev-fwnode-ref-v3-1-1ff028e33779@oss.qualcomm.com>
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
 stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1473;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=aDGbbnz+wzV3twb5feb+QvbOP0I73Nzbv6atplL3wzc=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqS6MtHvr7AjECn8mAtK9ST5QYxQLH8uISzpy7v
 3pFnQl8r+GJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCakujLQAKCRAFnS7L/zaE
 ww39EACYQC5v8jyh4RLJSmX9+Q2699EIwQw+LmnX2JTHZ37xaKZXSio5WtzBHutNcZGaaogpFoW
 WKEriZZ/dcQFmhZ/Q14nI9ShukRdTjBSVb6URMZkC1nyYuTj0FK0Sz2ESh9uqDHtN1HEUUv43ap
 cFmOY2eE+QXR8J6C5ZBAhBLzsJ9Ho77iM0WbapO+IFoLyWbJF/U41qJeW3ZaDdaFuDjoJdCbnNX
 gMHxWiSQ2aBucXdIz6hl4TU2MG7RWtc9WdKn3gzGFtuJESiaQzDHNAWeBjPRgvXNbcClk4qW2Rs
 FeY8+K5ONOw43nUF4+Tafg7FLvTlNoIHcbDtV7PSYq3pCNj+Z+hruIi8sXud/6W9vYKvPexKYG9
 5kWYO1Gd0GLkI5D4vudHVM74Gzan4Z0qMnQqPsUY3w57ZVVptL+DJDoOPoFTu9yy3tngTcrLrPK
 ZYgBxuAbV9NLePon1E9TCA8u0rQNn5//N6zpmGXBMEBeOBAU5yqkaPPANddk1al+fGPFzWtNGyk
 OP8WpDK8KBzFhXFC+cIDyJWlPptoS7D9Tcv3k6AoN1yq3qRx8ZSAQ6elAkAJ7Oed1RGDyMUTECX
 3wb+Lar7gwItQ0ahNLdLu95tpxenqJRi+oF6ATIp1WJ3NzZhbRCqA4YKV7ztDBsgCxH6Dpk8aa8
 Y07Wc/MmeOsDD3Q==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Authority-Analysis: v=2.4 cv=c6qbhx9l c=1 sm=1 tr=0 ts=6a4ba346 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=VwQbUJbxAAAA:8
 a=QyXUC8HyAAAA:8 a=EUspDBNiAAAA:8 a=lFaTzyIiLygvDfm8gxsA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: xICJJHuI7BI3IRZfOyB_I0R7z4uNGubD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDEyOSBTYWx0ZWRfXx5BZAOUTYkCx
 tOzL18U2WYXXqQWadVF9PRWHH5uH1iImYAwlfTc7onk5LOkWyEAQJ08PfzJ73ksKoIzmma9kWhK
 wr0N182f+qsTRM917tF4u4w1bclFXsyUKpl6Ao9pus0Kfi3+8FiSClwsas1U5ax8WsQ5cci1594
 dvAAkgI7r5iD0DOHoKjR6betWiS7FyRQtYfcyvQcCmmbs/rbCsIWHZpxb4lU+zpPdn3GS8uTfHf
 CsR4GPVV8YaMcNqrF54mfysUsz7negEJp78jOHVbLMKAR8yn9JeDkd6jCc+umnpH4aP0kGDHodr
 wb2qt6Gdch9m2Y8lCknCTeQ/PsnirV7G0O34XmHQqPbYlE7MycHr2S6AxXDc9VDC7JP2usv5Pay
 v6UyW6pOzYEtN7dPtkhWOw+rEZhcsKtl0mw76HUokMKDxERJ6NBfIeOnhUDaFBncJuYcBamMWPE
 STBY9CKlOZsHQeC7pKA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDEyOSBTYWx0ZWRfXz8nDALur4NpV
 aMnWjz1WF2QuYawnH0eT29UUYMLY7kQ544B7MeWE3WBR8gh6RZEVT+kO72K0i6NDTiOHgpwLkzV
 TniXyvT8a+XMpyV/gdF8/e+5WvikRE0=
X-Proofpoint-GUID: xICJJHuI7BI3IRZfOyB_I0R7z4uNGubD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_01,2026-07-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 impostorscore=0 phishscore=0 adultscore=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1015 spamscore=0
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

Platform devices created with platform_device_alloc() call
platform_device_release() when the last reference to the device's
kobject is dropped. This function calls of_node_put() unconditionally.
This works fine for devices created with platform_device_register_full()
but users of the split approach (platform_device_alloc() +
platform_device_add()) must bump the reference of the of_node they
assign manually. Add the missing call to of_node_get().

Cc: stable@vger.kernel.org
Fixes: 81e5d8646ff6 ("i2c/powermac: Register i2c devices from device-tree")
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 arch/powerpc/platforms/powermac/low_i2c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/powermac/low_i2c.c b/arch/powerpc/platforms/powermac/low_i2c.c
index da72a30ab8657e6dc7e6f3437af612155783d8f9..973f58771d9636605ed5d3e91b45008543b584d3 100644
--- a/arch/powerpc/platforms/powermac/low_i2c.c
+++ b/arch/powerpc/platforms/powermac/low_i2c.c
@@ -1471,7 +1471,7 @@ static int __init pmac_i2c_create_platform_devices(void)
 		if (bus->platform_dev == NULL)
 			return -ENOMEM;
 		bus->platform_dev->dev.platform_data = bus;
-		bus->platform_dev->dev.of_node = bus->busnode;
+		bus->platform_dev->dev.of_node = of_node_get(bus->busnode);
 		platform_device_add(bus->platform_dev);
 	}
 

-- 
2.47.3

