Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDA3ACD5BAA
	for <dri-devel@archiver.kernel.org>; Thu, 21 May 2026 08:37:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A007810F288;
	Thu, 21 May 2026 08:37:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="oRPupizu";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ncn95yfj";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3447B10F285
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 08:37:39 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64L81gED748668
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 08:37:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 v+4KHmmud2JbAIr0kznde3AKTH3HBGJUAAvtWZHpIWY=; b=oRPupizuUBUdYvM6
 C+TBRXWoDqeq04lMT5LC5gnHBmWkZFvkLch+YDhkUB+DEO4i2vSSrV1JDPGbqNxV
 t1PSwfXiomrcuy9ojdXSTxgyhkCwD2bRRvyT47pfH8NaYPZpchnAojnsmnyAb/+W
 A9AVuQTJ05rRYqB0I9TvxUhiIofA/ww3vBzm4nbKp/IcA2Do4b2fabK4nhXKfVMs
 d8YzfWA7c0utoGv21YBxZDEeqwtPVng42EXkDBjGOAQUrZBVJuMbbE24vFeuSdua
 kgqySIUA52PR235UhK2Ioc/mPp+u1RK/AYUpwZ3Do0aHFh3nUBh34KaaDeHFCVr4
 9JaSgA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9fb6kj8v-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 08:37:38 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-5162ee45a77so153548561cf.1
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 01:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779352658; x=1779957458;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=v+4KHmmud2JbAIr0kznde3AKTH3HBGJUAAvtWZHpIWY=;
 b=Ncn95yfjNwaupraOf3ltU9xTSS14VpEQ9EM3FCnyYlOHI0sdGtfkknPb84jwOYiAKP
 n1hChJLyagHBiN8l0sTXF8RY7fVgSvLGq6IoqtdmUS1vedeB/TVwZ1Xp49c36esnXQKA
 W+oiKHly7XHPhCWrxBeqM6KTtp4bY0gZ4g4qP2TCB2a5lpl1mpj1wGcQlpmBIpaEJZKL
 d359O5APmQ+zevWUtVbwY9Q1W6H6VkSDGtEHTKAs+XISHfmxXg4smmfsrTVP+Bxqu8+V
 WW1iHMq1x7XT8PtJ8tpaJ3JU/R+tCOytMEgqd1HktvEHfFDNRfy1dP2HSFBcZ/DQZPgI
 UJBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779352658; x=1779957458;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=v+4KHmmud2JbAIr0kznde3AKTH3HBGJUAAvtWZHpIWY=;
 b=UUs4OQORfAt4fcGcAWgjRuB9x4C+lchQJ1aQcqiD2eUzkYd93aVJtGaAsRdvfwn2vo
 sKtyOHYioV4y17wG3nV4aRsEzqy0oUidNm83SF+BYHAys081k84PA43ulwMmgDMPgz83
 728rZLRDl07mVMxnPUhAEtgkKrWGivpb41FyXKcVMKy8+hKfyi/J8Dc5EbmwYx7ZVpXL
 zYPFUDfwzXc/g+HeF+gnL5KIf/PvG4ht58bkP8uRwhwJjw6DC1N/VjoKBVMXXG2CIJw4
 pleEPC+FAMGPQFfjGDecLJaMqmLbVwaQURUgOPct0zrU3fNF8xbgTFAzt+BFJk1umuzJ
 Fsww==
X-Forwarded-Encrypted: i=1;
 AFNElJ/yVqQz/Fut0lVzpxx/v3fQLFIivSzxAONcupacTJOekRk5o2o0ss4ZxQXBSQbjB+JwPyPMPfZLY70=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwjFK8aCtbjK+GvyGTRTHXfY4GKXs8Zs2c38biRxI8Cx2hBf3pI
 eLfWMq0gcKE/AAfBQwmRnxPEoxxMq8pLoOohGbIXaIZ20Q/ZeO0Qx5vvGQgNhWPhj/WO1RRfBqc
 olfWRipApvXzXzHGtZqsRKqDFKptZMDpiiD6W6eD2DB6QZ9IrIJtBGCvXxs0Lf8U4LIFwEe0=
X-Gm-Gg: Acq92OEUqTrw3VitpYUTii7apcqcTyBU3EGx5yHEMpwKPosZI7c2YCnGTr6SpnXcdx2
 t/ZV7jQIQCu41a8hhNQlp6S19Q8RDUKUbdI9CBlmG/5zK3tVcZsCuriXSa4eM3VUJZr1gcnWBLW
 /2+iIIlspPjSz9hZMPZT6H3dmOGWooNPBAXVfqw4+AYSL4mGfG1P1oOeiaVziVGhN1Yhbeh22UG
 MQXeL2Ubxy0FDNTenOREVMY1er1UD3BPvVJKHwYpll6scUsG+WfnwnDDkKhqJsUc3fft3EN6uEJ
 2wJp80Ar/4MVtaTWyqjFh//txeK2w/BJLeVuRVzYHtiAB9Vik+ZtUnFLhP6dbI9lwvn4dHoP99V
 hssL+mmsikyvx5dF+ydxR80A5Tdg9uKETuZ2wFoUVVSdAB6Sn5X0=
X-Received: by 2002:a05:622a:8d17:b0:516:ccbd:b65d with SMTP id
 d75a77b69052e-516ccbdbce7mr3051861cf.11.1779352657782; 
 Thu, 21 May 2026 01:37:37 -0700 (PDT)
X-Received: by 2002:a05:622a:8d17:b0:516:ccbd:b65d with SMTP id
 d75a77b69052e-516ccbdbce7mr3051531cf.11.1779352657364; 
 Thu, 21 May 2026 01:37:37 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:bb10:ae82:b7c3:d15a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4903caede9fsm10502405e9.14.2026.05.21.01.37.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 01:37:36 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Thu, 21 May 2026 10:36:33 +0200
Subject: [PATCH 10/23] powerpc/powermac: use platform_device_set_of_node()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260521-pdev-fwnode-ref-v1-10-88c324a1b8d2@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1043;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=Ig8bPnwIF/mjSMvpWWcGdfQJeYqm2NUWFW1h+WHRo94=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqDsQnEHwHhZxOm6og5sHfREaEn3pVgemHlMmE2
 Ln462RL3PWJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCag7EJwAKCRAFnS7L/zaE
 w4YED/4iHLiHraTFNT8eTjPSn8I3ryTe/Zd4SzuN5PRYsUIg9SHspeWL8niwLubp8yoGgz1/xIH
 mgqX+8k3YyBoruzZHfbfsU97pVxIqztUPt/J3U/ND/wGvVjm02llmMqEulqZ1EgJ6G+LANtbEYj
 rMysNF197bf7mmSPH2FODOw4W9Gsl4Yq3+ICTVsgy7RDyTu4l1hebLzYJhxDn4dgUR2z1NK9W4l
 qzPmq4YDWFZhPumNaH3HaXzTt9NFXDJPIvCe5d7YHkngQELPf6MIO4nn+c5XXG+DqsX+8iTJLP+
 dtYp3uSsjNalAli1B+mULXlt6uzCo8M59zrPN01SPKz8oFPkGUdu0+gTOlYw0tlfJKNfwExn7Ku
 XjHd1mfDAehACci7mB3Pi644ZwR6730q24pIE/1mY05HKUHjU1nOghP/dDxGjeFKkmE842FNzv2
 CZTZqE3yiWV3bEh7BKyGcskYnVOGJv0JhDMdj1CiXCtSPerZVQuw/tvG90ahwqlUQ6U3u8WR9zM
 0uJaaumx3vqqkKd8NOyBRhGEoPlNbxoAJyiegjzu17lKqTb+jCLA5EO98/dJq3EfI8lgxWpL9Bv
 MeOYehAQ7eitsh9mBaZwqpKU97dJTWkzP4HCc4KLZm1PFyGSdHodKBldbDujP9SsX5EnRFjTN4l
 fU+hp0jLFamhxfA==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Authority-Analysis: v=2.4 cv=do/rzVg4 c=1 sm=1 tr=0 ts=6a0ec452 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=kq0kPlqncbyAjjsh9XUA:9 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: 8JoQcN1JfEE8hgAjEK6LJQZKUqGnqcHr
X-Proofpoint-GUID: 8JoQcN1JfEE8hgAjEK6LJQZKUqGnqcHr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDA4MyBTYWx0ZWRfX1839w3By7/Kv
 FbburigBj3zMoWiKKDSg9XFDoAJmMDLz+sPWbYu0sR5/2waz2zcD768nTcy0k4pX/sEx4/+RFSN
 OcMMv6iOW7VRbVpG5CAOz2AM79zyvXunUBJPEh4v055UmTdz1GSDYEdxQNorfVO3L3KHbL0xmpo
 SI17vZGtIw/6Rzg0drgES9RqJtC52BQn/pKOEedXWuL+TuTNNOVjiIGUUuUJ7PwGjefGcqKEGxS
 Rmner3ParcUzZdGg147Hszp1ZqQMDXwvVSi5m6PijRxql9mlUX1XQHH2JJOoA3sRm9S2iCD+K9i
 +lYilF9wsY45LDoR2QKoOayZ7Ied+j8XFFNGzOgibybMmm71Qd+H5KzJjm22Esy+MLhN66K89bm
 TmjB01Z93OlQZBcT4eNYGJ2r6qqxcSf5BB4gwONjdaQyfwFehyLcaPVf/e/NN9NR9uf1wUqGrj4
 zzMjuSuhNPLsNcFBQag==
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

