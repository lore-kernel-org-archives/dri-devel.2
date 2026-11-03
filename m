Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EBDE606A33E
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 13:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=MsiV/zLn;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Msw8cdF3
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B056910E7FD;
	Tue,  3 Nov 2026 13:34:27 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 05FA810E7FD
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 13:34:16 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A3ClCe33506761
 for <dri-devel@lists.freedesktop.org>; Tue, 3 Nov 2026 13:34:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 yIknrBZjHPY8Jt51beaEL0ty78CCW4k2vbkiC0Sj0zI=; b=MsiV/zLnv5StFd6p
 hWvIzjdpPt9IQDAnWLv0tTrBGhCXT6u4wo6edsawVRotPX9NAWrAfgVi5ddHdiaL
 /GkXynkW/wyyEYd90f/TZ5cMEQcY7/FilTG67WsbGrdsuFkJTIx6ZtxrjeOgAQRK
 SlyRxNJRt+IOgiRCUykisIH3nJmlVDP+XfdwOCYYAT8dKmhUmLvi3Jf64xb6+OwC
 gzOz/6jUAoRJn5sH0nIA9iCDR/IPID3189s7CrV1cOIyuKvr0H6OW5FfUlHp4cnh
 NOeXAFq9T+O4R0O02xxzXBBrEX5vW2xkGRZ5lErI6Yn1X6ZP0Hk+IjpfHlMOqQsB
 cnyeaQ==
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hq6m9af4e-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 03 Nov 2026 13:34:15 +0000 (GMT)
Received: by mail-ua1-f71.google.com with SMTP id
 a1e0cc1a2514c-99063f4065eso608733241.3
 for <dri-devel@lists.freedesktop.org>; Tue, 03 Nov 2026 05:34:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793712855; x=1794317655;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yIknrBZjHPY8Jt51beaEL0ty78CCW4k2vbkiC0Sj0zI=;
 b=Msw8cdF3MX+Ws71C4nFmViOCulbmdYlYoS2FFIsQ/p+84x4CZLhoUfCJijeCtrXyh4
 8AmMyXzDeELx2Z0UjusBJ023O382FGBq9TXCTmesp44V7I7HTLYerAQRNqrylbX7gTiZ
 Fv4UhpsGrtmHIOzd+PXx4+xeXuVLLkB8FQdhZW+wXArMNtMpJ7UJ2QYXyLkoZsPEr2Q4
 N0Gf9E+4++7fQyfGGEuZlsI/O88z8y7QhoCn86OVvWx5DXOBPDxpWGIx1qfx3zynPjkw
 7K8Ap4OOhu0Ppw5IN6SQ/ihZoQ4yNLwGAxwGHJmBQUN2axAJF5pBKMfpCeBVQe5/1bOy
 M6PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793712855; x=1794317655;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=yIknrBZjHPY8Jt51beaEL0ty78CCW4k2vbkiC0Sj0zI=;
 b=bq9LEmBz+0Ry6rUBTwzqD8yj614ekgTuzM/r6n2St6AcQGpQSlIJHL8iNfHb7LS+jS
 j6KuABw9z7cMzmbrTJps8Br4DmVPPSRVvfEnYi82fnZagL3Hv+YoTFszLssWkQ0DomNx
 SUkrjqnj93SPy8ZCAEdnjNQZ3NPODeIE7VbmBK5SH7X+vNdbC7isYl6xLPHFwwZ9gUl2
 wIz7VIJBAJ2qpFRrw22P+fHsD/Wo3D0foxcDMYMExgj8KZJngjE9KiK++QK8TG1Adj3i
 yQ2iZBXVf/si/zCqZWy2qKOPK3WY9HVk/VJwrvb74iR+P413v/7tSM1pMPuoATykRJvy
 Mzwg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxwFf6rsrBdVgbvXuP4ygVKBt5GuLL+kjvGVvWRirdyuElRKcCo1Thyl0mjKJa3hm8fnGEPEs6vHis=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9wk7X5tCHLhjKUd3d27s8cz0IoMTUtXLi6J/6lpugeNn0L6PlS
 y+j9hj10Jfwt1dpKVKWwkeh5F7r0XT185G4mh4nTQ0DZI0BmSklH5RjfztTpIVnE9u2/Tr+3uOV
 OjIXbHOd6BXAD6l/5/3sLlucS2/C4TP+3lSxCvQxWn6qIAfgenAhGN+OcXftln3nTfu8I+ys=
X-Gm-Gg: AYBFou0j4/SulVYtoYVWiK3I9WLPo7+FYEaYhlDnb4GndWivhR+9uCMvMC86DY9uR3q
 xbGV9s2Tzz5ZNriTkbm1vOt9cX/NI4l1mHja+OfJLNOKwhtTlHKHdNWXjK9k/zg8KyMp6D+yWbX
 GNqUhM79idI91WHsHJ79c22N8mq+lu2PyDXHSAwVaZ4aJMczjajsnD6acurUpnrCYky2eOt/qvT
 ZOpi+ZEz+5lBYv4ohkreN4PvX6Bqs8HWbUmjDbsYXWuD68NZRyP4xmdIGzBMqZJyKcVk92HUcc4
 pjqSOlf+F6kHgRLLV7SGeKzhnP23uoiIdV2VoJ9JklA/6/+G23hVIDKJz3pe3ZiFdroRStgdCWD
 UHgRGkQSaVAy/59xpRW6pxJaHk61m40v6Bwl2sBPdvY6BGEWmH9rsJb6U1RiEK3UdRHRUMTm5CW
 VGrA==
X-Received: by 2002:a05:6102:6883:b0:7a7:5355:7fb6 with SMTP id
 ada2fe7eead31-7d07267f930mr4343529137.24.1793712855091; 
 Tue, 03 Nov 2026 05:34:15 -0800 (PST)
X-Received: by 2002:a05:6102:6883:b0:7a7:5355:7fb6 with SMTP id
 ada2fe7eead31-7d07267f930mr4343520137.24.1793712854700; 
 Tue, 03 Nov 2026 05:34:14 -0800 (PST)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:8916:7b9b:97a2:6c96])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71ba7168sm26866970f8f.55.2026.11.03.05.34.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 05:34:13 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Tue, 03 Nov 2026 14:33:52 +0100
Subject: [PATCH 1/3] ARM: stm32: select HAVE_SHARED_GPIOS
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261103-panel-mipi-non-exclusive-gpios-v1-1-aa862c1d71e3@oss.qualcomm.com>
References: <20261103-panel-mipi-non-exclusive-gpios-v1-0-aa862c1d71e3@oss.qualcomm.com>
In-Reply-To: <20261103-panel-mipi-non-exclusive-gpios-v1-0-aa862c1d71e3@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=747;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=+xwhEIq1Kfy5I5NBWcOLNXVJMoR1QHxqiMRtC7afj20=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBq6eLSGfA1l9T+A4p0kHk24QWFBtFJJJT4XTpef
 LL7mrxNOM2JAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCauni0gAKCRAFnS7L/zaE
 w3MtD/9uudBQVkBxiiyISXvd0Y8Wm8gryDzgKaUNm4uEeMoX6xWUdYiho8KqcFnTr2vQp4EHnl3
 V0ky3XWFAJp0xs5mWtYBVxfPRZRr8cnxjlXKA8ij1iB/xGYMX9c36/H6dvhJMcv0J5TVL479Ho1
 Us0zp0l9KFSw9Wb7NAJYRFMMmmycip9ccbIS5alE2M4qiJmOoP+brHSvRaXMTZcIfAPXSlDn72R
 e+KKlEt3o6mq5kvmkf1IqPQPvfB/e/Ge4s4s76EVwK/1qjlPqRuRLjDkBuwi4db9tshI2O9hd4/
 enqe4FeuCfB7VRHCRYiBS9m+Ic/QKQaDynxnHy8un+GYvrJ7tUuoXIL2n7bU3ArxHq4feXatqZU
 7QD+4rD4k4y0Wpu4IX6wbtG2W46DJ+782W3LOnAbWo+QL53D4Re/Um+LJ5mYVG04dNybyezoMDM
 b16yKM6XXF+aWYlc9lVXiHYH/S4Qv0AKH3gbG6oH7Bs0aRloOJoTG7tF+k6SGgKz6DdorIl7gq+
 B2jzN5nJ7CW8Ir2RG9+9/iWLT/uwfmCqrpUIYb4rNPgFRBhkawf0a0XJ7SC6ofdLHCFkD2Zf06O
 UXxh6oLDnuX6xMBcFK3qaQYYVC1zi0uFcU5ITlheV7DslAZ06/VqIMwIjTDugUu9CzVnemUyQbq
 j0MTBEPlGcNcfIw==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-GUID: QdcA8-wH2RRz4cwcwdgwPVhX2HugSWjR
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDA1MyBTYWx0ZWRfXx78R6FdMW1W1
 Rmr9b/pRr7g+OiDsQqlsP44SmNMqQPhmER+QVtOyXOS2D/sWLKm6Y+boQX4WQq/nBsLAE68X9k6
 wWEgZhRtutellf92wjJ0Z3xCzJZqBNg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDA1MyBTYWx0ZWRfX3DdBd6B6aiSJ
 JwblzCxGronKNGSiMsit4lg0gLRv3S61zjM5XL5d7EuyTR+ntNTxFLjM13WGfC2MnCZ3rL5+Ggn
 es9JKaWiHXHDZvxleZInvnsr6pVZdsNPqaeF3qH/iHfTyfdt4PqsbThzFMupQ90RrGASAsdHP9o
 6psDTjng2mA/yT/S4+kdDBCGOWbK8s9JS/2fV8GSyhMsSSJhjGrmoLBJI387lTa4elKaHUZFZMx
 fHpAKKisQYXwRIQw124pFw803X35lyUYa5M+lIW2MRmRfdlgiuhZB/m19abKez7lVU7nsg/ALhs
 nUM1CaVNadGgtNcAbEQcE740ci9X6Wnl4N6jjZ0u6791ntS59Jpvir5iH4xPsjHLphmOSHGeK9C
 K3BtDEDOSTopyKdpJo+p0c8+Giq66L1w2CMxQQDUdU4OxR/K9+O9+uS+IByy0Bkuv/JvmS9scRb
 unACywrJO5t6LQSDkLA==
X-Authority-Analysis: v=2.4 cv=C7B8WgP+ c=1 sm=1 tr=0 ts=6ae9e2d7 cx=c_pps
 a=KB4UBwrhAZV1kjiGHFQexw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=b5q88MxlnkSnrj9B7awA:9 a=QEXdDO2ut3YA:10 a=o1xkdb1NAhiiM49bd1HK:22
X-Proofpoint-ORIG-GUID: QdcA8-wH2RRz4cwcwdgwPVhX2HugSWjR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_02,2026-11-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015
 impostorscore=0 phishscore=0 priorityscore=1501 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611030053
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

Enable automated management of shared GPIOs provided by the GPIO shared
proxy module for stm32 platforms.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 arch/arm/mach-stm32/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-stm32/Kconfig b/arch/arm/mach-stm32/Kconfig
index 4ac3384e397aabd86e4843d6a6326cd22a2dd66e..ecb6b35610f4988b4fca3fa10defc260a149f7c1 100644
--- a/arch/arm/mach-stm32/Kconfig
+++ b/arch/arm/mach-stm32/Kconfig
@@ -9,6 +9,7 @@ menuconfig ARCH_STM32
 	select ARM_AMBA
 	select ARCH_HAS_RESET_CONTROLLER
 	select CLKSRC_STM32
+	select HAVE_SHARED_GPIOS
 	select PINCTRL
 	select RESET_CONTROLLER
 	select STM32_EXTI if ARM_SINGLE_ARMV7M

-- 
2.47.3

