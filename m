Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFDD1606A33E
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 13:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=P1CK6Ffo;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Uep9Gq+f
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B53A810E800;
	Tue,  3 Nov 2026 13:34:28 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E9D3110E800
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 13:34:17 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A3ClEOH2897062
 for <dri-devel@lists.freedesktop.org>; Tue, 3 Nov 2026 13:34:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=fSFNdJgGvwopHTFPREQKhg
 PmKSBKEGZI/r6GjlVmNlQ=; b=P1CK6FfoAAkGJNL40dyQMbJWqH1fCi3gQZd/8z
 Lou6/z0PloUEvicelSjeopBBgaVP7ptdK3DoIPq8HMk4bMEhGUQuadxsE++tMOTK
 MWMysaVloK09OijfNNLA7RIGKyc3C6Uh8w0S+jG84NsC/1tKHZMZ+uo+eo/J0oVX
 el+s8EVytA1aURLuFkYk2xt3EHyABEioJqpcwLyq3k151ne1Pei8ahFdeFDtNYN7
 ak1kBMTi8a4uUgZdV2hL5iGRsx08PxySTt/1Xp539W1ZjYegHY2C61z6CfBlrNzp
 vstikzjAOadT0/+ReQov7Ve0eVsGCKx11YGiKWe0AovtqQHQ==
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com
 [209.85.221.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hq0873wy8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 03 Nov 2026 13:34:13 +0000 (GMT)
Received: by mail-vk1-f200.google.com with SMTP id
 71dfb90a1353d-5eac1e41c2aso948986e0c.0
 for <dri-devel@lists.freedesktop.org>; Tue, 03 Nov 2026 05:34:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793712853; x=1794317653;
 darn=lists.freedesktop.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=fSFNdJgGvwopHTFPREQKhgPmKSBKEGZI/r6GjlVmNlQ=;
 b=Uep9Gq+fhkmJ9dLPdcpFEFmBFM8ufSNgETXAVRte3qpVnlI2tOdXz11H5vkCSpeX1m
 qkVskJnhg9IaK8W6+b5tcSeNhcsa9ec7Z+IEZsOUaiApbt3fsD8h0SMk8nLDTbnpDRmY
 FgUdghsQupBQ7JUIHmHBXtHb1Q/AT7NdBxbUDhljfDnc0Ty5i0s4BubhzYfWTeWtdPGc
 abaTW6nNZBxn+47G9VQZoV8T6C1b3qezYdn71fMqpGBD3Z1HZy42CW9uG56R5drbL54U
 21ZeCQwfwrkhzt+VgZkHg1l+05DUhiWrVoCNg7aW8Typq3/f+I4ZfvWRH6kFKSys4KQF
 cP1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793712853; x=1794317653;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=fSFNdJgGvwopHTFPREQKhgPmKSBKEGZI/r6GjlVmNlQ=;
 b=bq4aj9mHbumtk782R8cQCOWp40QJoXpw1J8/pBSo9CD4jgZ9ejTMVoOCtlDs/vqT5t
 KouiiWq+Gopt/UPET7OBwNjDSYfzkSTtBST9P8qCzWbzQFxVp0l3uyBzc94pUBxpSiCK
 luX6PpihRd9O22VmVUkkB0bZbgUwFd8OHGv7GeyJefNNsZfUMiNrBB6xNZKMvssVcYxl
 PCas4xmVbDERkUFHIyhBV5GgVSyFOJMURLDmlKz9JO8kyJ+kJcoL0tF+DWZq1xQr3w3d
 pIQtZdgE5ebiM31YDhUrw5EJe33hkfcggoEmJsqdhPrXzVFDWg3n1PexJKtSnuvHYMnZ
 PHXA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxYtUt/dU4prSCKdDNsUzW4A97CSeEBOmwmbmRQgi7Ev7eD6iAG1/Y0v2EdLkmmjSngzY65AkvWI+I=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9jT9MlQBtvkXapkemMjuj8dNUN2+LNOki2vFowKdYG8fHMcnkN
 oSQtHvTtHUmuXk0b3KqoYPNU8g5MMCvkA1Y6mIPrOJbfDmCL50gIm7BVvOG7OyFUe4VIxNTU3UH
 eOgB2KhnEUTeKC9yigJ2gGXHqqkk/KynVII+YSFFsQ3uXuGcd1E9ro6XX9R8RSS1swwuC4Wg=
X-Gm-Gg: AYBFou112mjDFF4qhY6QCe4ZtmQUk3pE+BdIlYnbmHz8cavK3MF7KvORhLdEEguAvLG
 mvK/f8Ss9ejUdh0GNyHtmAaSrmkfNQjztmaXMNK/hHtsMRxdZb4xK2XaU1hT6zOSMbtsDbVmYgx
 KjuPRr7DJNhA6Q2g0u8sUVD9Zltxnd8nELcOBCdZ4roOYx6UiBC0mF0L8RfLk857wjdbG20E3J5
 2mkzcreeNFcun2MAHCejQdpKfy8tZSu/gt0lJnzvpTUCgDrGNnYsC4xJGXtw9hZr6j3tprfi/Yl
 xTnE2KAIZUvpXKIf556pvi3fwbyc4h99bVp6qF9jDFXSh7JGRbrtU11E23K3UDSgu09ZwJcJvyL
 6OWdXxdhWQYMkY4kp4t94ihUAPuq/Ht4A8arENbriKe+eW94cVJHUW9SoKSNpq1HMIeJpnVfM6W
 MC2g==
X-Received: by 2002:a05:6102:3e84:b0:7cc:32ce:4c51 with SMTP id
 ada2fe7eead31-7d0725cefcamr4330607137.8.1793712852911; 
 Tue, 03 Nov 2026 05:34:12 -0800 (PST)
X-Received: by 2002:a05:6102:3e84:b0:7cc:32ce:4c51 with SMTP id
 ada2fe7eead31-7d0725cefcamr4330597137.8.1793712852429; 
 Tue, 03 Nov 2026 05:34:12 -0800 (PST)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:8916:7b9b:97a2:6c96])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71ba7168sm26866970f8f.55.2026.11.03.05.34.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 05:34:11 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: [PATCH 0/3] drm/panel-mipi-dbi: stop requesting GPIOs explicitly
 as non-exclusive
Date: Tue, 03 Nov 2026 14:33:51 +0100
Message-Id: <20261103-panel-mipi-non-exclusive-gpios-v1-0-aa862c1d71e3@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAL/i6WoC/x3NywqDQAxG4VeRrA2YEVrsq5QuvPzagGaGCYogv
 nuHLr/NORc5ssLpVV2UcahrtAKpKxq/vS1gnYopNOEh0rScesPKmyZli8Y4x3V3PcBL0ug8DOG
 JTuZWIFQiKWPW8z94f+77BxCusO9wAAAA
X-Change-ID: 20261103-panel-mipi-non-exclusive-gpios-bb27e91f31e1
To: Russell King <linux@armlinux.org.uk>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Chen-Yu Tsai <wens@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, linux-kernel@vger.kernel.org,
 linux-sunxi@lists.linux.dev, dri-devel@lists.freedesktop.org,
 linux-gpio@vger.kernel.org,
 Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1025;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=Wi99EfjZrDJfc4ByH5DW5LiPzd+d5x4qqFh6JHJjz+U=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBq6eLRR4h1JzI3varWGQUzdBOuYb4wR3+FhGm1v
 VLnE9/MsbOJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCauni0QAKCRAFnS7L/zaE
 w5RvD/9+qgHJdqEE9cOISLwTNLZEAeePooJ21oZyBXVJ9HzRowzhSVXfRV+d5UWam7pnTBKb86f
 /hFhyRxBYWnnvLzwf5T9W+Dl43T0Fv9vC/BFKpyUBUSlpZaoeCMZ9Lbp6BpPbfbDrs2ZA2GJGBJ
 /4geiGmFb9smNEX1UDPbPh4GytbFkh1ndBf47pkzIDa/5MUN0EO+BOUEWP8R68mdfEa4HO5jkbm
 a9L3eOuYNmI2O5puHkDc0I4VNhzyPvoMZz1ple0PGXsN0ALd+SEQfQb5cfssWQHKRSKDLJJRTpS
 NHPi9eaZ8ArXRDdB78eq26D1KGyt4vnhDA3j6FaD1BEz3pm14WA6whjvELRpXacKqJhWtdkm6M8
 kSRoleVeXCGClALH1TchAdVob+seZx3wqHArsiC9TC0HcdW4fWbjIAo5LXojtBYpOC9Mo1QPDDw
 wncDeDCOSlHLwNIzG4iuCw7EnNPxeSoBam28DzBbje7//AwBqDJrG+ErlZgaIJJ3ansHeIANht7
 jppIqC1pn56IQW16s7z5xpW0u6juotyKmkIteyeDnT/KCxJ4QVV7JFwmwqanBXPN4XhA8LUzWC2
 f8xoCkYRCCBjq84iApk0xhY+vDBg60VIqjo2ylevGDYOaE3CJ9XSK1KmUmBBHy4HnorbOysgo6k
 8ZDVWN2t2ktuuow==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDA1MyBTYWx0ZWRfX2sx8bOoHEFRd
 cVwPVmce5nmydfi+Bqog18cpA4wl10C+sOH4Kuo8HsurdI1E/x/eCF3aZKHSKf1ImiZt50xagfP
 8sC6UpPTcP+9eAaXKbWvXeOd8DBX0Xc=
X-Authority-Analysis: v=2.4 cv=K9m3jCWI c=1 sm=1 tr=0 ts=6ae9e2d5 cx=c_pps
 a=wuOIiItHwq1biOnFUQQHKA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=2ktC1rJDgDHwaXYRQ2kA:9 a=QEXdDO2ut3YA:10 a=XD7yVLdPMpWraOa8Un9W:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDA1MyBTYWx0ZWRfX4oOGubCgnCFS
 MmvDl2EjMjb0ENB8oIhjJ98lvlG5V5a5VmvGC9nEQgjv5vXh+36M1riWRqWXnz7XjAawphKSBU3
 +KYswTDSfqZWF5vn7i7Ab97PooqAf4igPSFiMGwTk7lRGkiwP0442yhR3pGjZNnHFigd9znUGet
 wmv17QmO804zDhTSRZAU/hupwZ42tB91tSOi41TDSK7rbWoxVOEsYHyfAkfwqTtLerEQJNigy5o
 UcSRx8D8wYnr3ij4nJ859qEmQkPWhOeN8EG0+2xlAAVo+E4pPbdanlMxM3+yWJhJs3CJmSxrhBx
 8R/J+ufbk8i536tGMu2fn1VfMnTNK17txQJP1cTkRlXpHetQmz4pN4pbmoHm0fsNWEkG2KIaRqy
 xrqrErJ8W6DQgIfVw5pobpQq/Jy8Y/G9PDsEkyB8NKKSuuM96/ecudexTblGr+fcuLPPPvOCCUV
 d8MSv6jw3rELFof/x5g==
X-Proofpoint-ORIG-GUID: zLD8CadArqNboNtbbURrzbhzlXYVhxdm
X-Proofpoint-GUID: zLD8CadArqNboNtbbURrzbhzlXYVhxdm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_02,2026-11-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1011 malwarescore=0
 bulkscore=0 adultscore=0 spamscore=0 suspectscore=0 phishscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611030053
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

GPIOD_FLAGS_BIT_NONEXCLUSIVE is deprecated and I'm slowly working on
converting all users to using the shared GPIO proxy which automates the
sharing and allows drivers to not care about whether the pins are shared
(as they should). This series selects HAVE_SHARED_GPIOS for the two ARM
platforms that use this panel driver and then drops the non-exclusive
flag.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
Bartosz Golaszewski (3):
      ARM: stm32: select HAVE_SHARED_GPIOS
      ARM: sunxi: select HAVE_SHARED_GPIOS
      drm/panel-mipi-dbi: drop GPIOD_FLAGS_BIT_NONEXCLUSIVE

 arch/arm/mach-stm32/Kconfig           | 1 +
 arch/arm/mach-sunxi/Kconfig           | 1 +
 drivers/gpu/drm/tiny/panel-mipi-dbi.c | 3 +--
 3 files changed, 3 insertions(+), 2 deletions(-)
---
base-commit: 2637bdec0535a2044cd830eba9a79363651d9043
change-id: 20261103-panel-mipi-non-exclusive-gpios-bb27e91f31e1

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

