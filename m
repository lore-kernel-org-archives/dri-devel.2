Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A92B6082BFA
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 13:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=QmbkTUT9;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=TxTOwZ7B
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF7B210F5B3;
	Tue,  3 Nov 2026 13:34:30 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D14110E80C
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 13:34:19 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A3ClK6i2546928
 for <dri-devel@lists.freedesktop.org>; Tue, 3 Nov 2026 13:34:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 UlFfpd98ehBTyq3Xph9Fua8gi7fHWtJLIZGicsuw5ZM=; b=QmbkTUT9EgzLQBTd
 DwbS5LW8ukNsULr+oDxFwYnWgiBPXw3dEogpNru3TPt4l2RQMK/YbXTyxbgQvxtp
 25KeFLv4HAUw9jIoRRfOfgpUSJ+nSYeH8WZ3pVHJCKKmyG+gUkaxtcGaYwQtNu7z
 thD4iYNqoWWEbPZgu7X9/AoSyNOFB0aaMpEplshRjGOQFmgpBM5s88x0hhZAKiIP
 o8eRJeGjCCTksdklSC+cKahTNWalNlHkpw2s+C3R5MVlPOp85pgbZoLXzAaW4mXh
 U+OCFkQ+6qG6tvpY4rvZLH8gUlWChW8CuTVLkd5qqkWknKpEPpL0j/EYHbmGBM21
 K1RXeQ==
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hq07r3y1b-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 03 Nov 2026 13:34:17 +0000 (GMT)
Received: by mail-ua1-f71.google.com with SMTP id
 a1e0cc1a2514c-9987bffdecdso14907241.2
 for <dri-devel@lists.freedesktop.org>; Tue, 03 Nov 2026 05:34:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793712857; x=1794317657;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=UlFfpd98ehBTyq3Xph9Fua8gi7fHWtJLIZGicsuw5ZM=;
 b=TxTOwZ7BOcM/dzCy2hXzmtJ3rx9ghsr3DiHJvK01zfAWYtHiQWroRtZSu4BXvuxCuU
 D65knF3Yv2BTB3L06amY5lL+SQiTWrRd5GSrg5jWBL/QN3ToBXpbU7kuAJvHLY4gUNLE
 8uzql0EH6edL7AefdjLK1bxj8CiJQhcuLJ8hlRWlTgesKs37zm1oc0zXSiOGl08p1FWH
 nvP6vpXOlfBdZo3FC4V/cIsZ/4OSH417asbFqaMweKX6EMukYr76QEIl19AkmjF3+pzV
 KLK0OajqYk+mO8DgZdJIVp/FCs6I3rp//GVgbQzc3gBny7jDquT+47/d6+7S1TbV7HYb
 jwXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793712857; x=1794317657;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=UlFfpd98ehBTyq3Xph9Fua8gi7fHWtJLIZGicsuw5ZM=;
 b=cTC9ECsVK0zzKvdxxf38+WTBNbdqlkH/9Rsk2sMUY/5OpAMdWuR5dDhHXIXpwBo+MT
 tvJaXLyFkj/C/wXeU0qoFKfxrN0sS0LlBRmv8unBnZrixdHLEKm79zzWeBR+EgBWvdyz
 eIlM8BcsRvPf2tn6XSWCNA3FpvGirGTGcwpKHB3P0HnCPS1EuG5tfY2LLNeBSaxCIn8b
 9a5q5RpcNh/+I9L+9JNT/pWbEmmasfZ27EjRDfpcVh+gElEs4BHGeyqpJqfxFB7DIdn6
 Q9Y1hXJz2EM2lMP7D1zweZpXZ6JPsgMqYbicE9oaFqlZU58vColtpPq9h6j30FJImBxq
 LlPA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxlou4QPoiafdk7SYGpHerRi5vcP4I6oRIt8cV1RuZvwa3DhqrJwdUo7SVdpxNcMOxhEhEys1h2Okw=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/lSVu3IMr4tyzYdAyofdSobT20stMIUgxmOTY9Ym1itaFVF+iI
 c69Ba92ze6LbKieNMvhMB6KRtJ+wWiGR6brQ4d9yj5eEz08xHLVz2m7uEIiypxuEItIBrc6iz1a
 yDMkOXX7hou0sp+/P03dJ72UA78KN9w2gdd3LLJQLXOVdam26khkb7Boz2SVyCMTftJFKLXY=
X-Gm-Gg: AYBFou3WztpBIDs/JQiMsjsT5qQ7WFw5MpaHPYDBA0KUN4olRNr/o3yZ/cKPt8GNGqo
 a46P8xk1j0Y2ex+ldk6F/9aJA8wwAvE3IJVg+4U+uuAnigBFI/yJ9A+Ao7T109VPvw4l/RoK8j2
 vvuSqmkNNkFya3Hz9ZkFozf5qCFOK6lPPICnCw7vfcr/BGs3V76oPIYdCIz4shlZIQrOHrO9AAK
 4T3ULULG3Zig6S0JM+3+Jv/GhGIXmA/xe/DmIo1D6V/h42/71fzhMmVaVkYUAVKXgbFB1sXEoWB
 rAsnasSl4RW71FcLHYY5b0SDxg8T5LKtL3SdOP9C8O7mAZc4jrgkZ3EZFFgeRcGVEzZYVHSrdxQ
 SkYZIcHWdxoOtFkbH+/cO/h7lT9KwsosaCxeLi0DcLsckYJby4khB84MhDiVqNSnuCs6a6XOCwA
 iQBw==
X-Received: by 2002:a05:6102:370e:b0:7c3:2168:d603 with SMTP id
 ada2fe7eead31-7d071f40bc7mr5046272137.0.1793712857343; 
 Tue, 03 Nov 2026 05:34:17 -0800 (PST)
X-Received: by 2002:a05:6102:370e:b0:7c3:2168:d603 with SMTP id
 ada2fe7eead31-7d071f40bc7mr5046256137.0.1793712856891; 
 Tue, 03 Nov 2026 05:34:16 -0800 (PST)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:8916:7b9b:97a2:6c96])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71ba7168sm26866970f8f.55.2026.11.03.05.34.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 05:34:16 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Tue, 03 Nov 2026 14:33:53 +0100
Subject: [PATCH 2/3] ARM: sunxi: select HAVE_SHARED_GPIOS
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261103-panel-mipi-non-exclusive-gpios-v1-2-aa862c1d71e3@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=715;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=/AFcbMcZblHubDxf794SVqjhIpAl11By9m4gfG7n6zY=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBq6eLSrAQvg5vxhqBArsuQUFlydgNSbeoyY/b4+
 Dy4eH/ORcmJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCauni0gAKCRAFnS7L/zaE
 wwCqD/904Uu5wvPIs2SDwjL5QN91sAwhgbcm1t+Qgn/BiD2d4ab61Ev+vE81zGYobw9S9j/z8Or
 Vy/17jrUknJfanVDqVnL+RRNJm/WgqmaiWcjSjSFY3quypJPXqbFyriwzSEmhskOF4u+2lY+Ro1
 Nx2IqrKHi0xwY8ljDETtM7qA1uDQ4mIpNSvol4gysTa9PdFmLjEy3dVjNOYhWWIFfvQ3NPV37tr
 LxD+wjUN4QZRs4uYJLbaGbg46Dy8/mH5a9ZAUNoY/RPsvLC3zSCV0My0pxNRYi/xwYz+yvneaNA
 ozana2AyAeMNKlUAU0HDlpo3KYaLiuB6WHlM4x8b+k7eW18qu6kshYVv1nRhq+uU0mRPzuFKJaE
 10rqsKleMVnr+Z02+Ab/eEiGud09h+JpV8mMTTbExeL+TPMOhoULvd9d32r6boIjouqA7LD8DQ9
 oZsa9h4ytzL/jDdISTbVqxB8xPiPug/S7MDj2lJp6Y080Ze55l8q72oAooI2vS2XiFq90z8OL/6
 TUrcCKy5ypAjg8UMr9ipDDdMB9J5qU85VqhQadmJ3PRDPXtGCOqqm4C+L4xgUXzjy3MwiVflOIS
 Y2gXpDTZzMsb1qBfeHIGzzMDXn5ewPKLVavffLJok/ZIsKxZ8Ao43gXvd5YjX7cyCUs67vt8NQp
 fttVjqjLLdb+t6g==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-ORIG-GUID: kzKJcGv5y3X4F9EltRr28sJU6vJoibzI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDA1MyBTYWx0ZWRfXy/g03hNk+yEp
 hBGvqw0QcCyQse6vynoxeD0OMid9B2VWSA3zrrOeP+aJvOpRpK+WxQmI6ajqneItO3Xkv2VpWX3
 FfrrlSL5LlGGySzKXisAiv+4tOgO1nOGIhHrn8Jk3jCe1BGIQGmkdhtRNjbcwKfbSkAZ0xcXBAj
 WsIblG+R/5iI3sEAJivdEXge/3SJliDOiBE7LeH853v0lyP3GupVHdOkXI8xwYc2Szsy+/wFLTB
 z2B5/3WcpmpsecXGjeobaGL9ksK1ofPbK0UfdaJfJGzqf1ojxas2kZb5iOAGD+3FB/yH6mdB0kn
 sGgaihB4pWKdpPHz/Y5oV3SP54lFBCAweOhC2oeCtHUvs83CzUtiDY8+b2KVuLdoTmaJUAQWa9t
 W8tOKz/RXDcqSKGsrZ/CzE3UTmuTSft5nhY1ToYUc+l2p+XhwomFI+SKlcu6P/QdXhdlE3dnKPO
 lT+QELA9Nwrn++KzFQQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDA1MyBTYWx0ZWRfX4rj30L2JwsDa
 KsjUElT7bhVn2PQMbgFGha0SLOdrEFojqQRKJmOR395mBpUf5SKTGjitl6EoI44TZ4UeGTkXCn5
 eOafj3WNlXrdAdq1QCP2c7z0Udaimsk=
X-Proofpoint-GUID: kzKJcGv5y3X4F9EltRr28sJU6vJoibzI
X-Authority-Analysis: v=2.4 cv=NZlzRGD4 c=1 sm=1 tr=0 ts=6ae9e2da cx=c_pps
 a=KB4UBwrhAZV1kjiGHFQexw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=eCt6F14imeMwFY3J13AA:9 a=QEXdDO2ut3YA:10 a=o1xkdb1NAhiiM49bd1HK:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_02,2026-11-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 phishscore=0 priorityscore=1501 suspectscore=0
 clxscore=1011 adultscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0
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
proxy module for sunxi platforms.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 arch/arm/mach-sunxi/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
index e015f2497111a42133ddd4e7ddd172eda06d90ba..b62e8518e270459444e7d4ee382ef753c368dd51 100644
--- a/arch/arm/mach-sunxi/Kconfig
+++ b/arch/arm/mach-sunxi/Kconfig
@@ -5,6 +5,7 @@ menuconfig ARCH_SUNXI
 	select ARCH_HAS_RESET_CONTROLLER
 	select CLKSRC_MMIO
 	select GPIOLIB
+	select HAVE_SHARED_GPIOS
 	select PINCTRL
 	select PM_OPP
 	select SUN4I_TIMER

-- 
2.47.3

