Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52993606E507
	for <dri-devel@archiver.kernel.org>; Sun,  1 Nov 2026 22:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Iq64/ikr;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=YaQXC9Ra
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 968C310E1A9;
	Sun,  1 Nov 2026 22:22:05 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE4B610E1A9
 for <dri-devel@lists.freedesktop.org>; Sun,  1 Nov 2026 22:21:54 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A1KK8VZ1808587
 for <dri-devel@lists.freedesktop.org>; Sun, 1 Nov 2026 22:21:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 +e+UbA44vcf8UTJECZJplFj0MSqoCWvpoDyTNmMPLK8=; b=Iq64/ikr5QdG0DtI
 lVnDGXMOMQKB3QueaQZ/OSdZ9mR0NvHzkcVmeCOZh7x6Ck2hw7/YrpPKU0aT3oLo
 9OSGtQeAaXDdHuMawLulxKVvOfJLwPGXAVEs6hFV/XDrLGT1vVYmIBLBrEXJJ7VC
 yi6dxvqZ+4jHdzNdf6rpU148onSRXTgT4YHRmTmXXepeXLv++GP2sFeKvhQknUlQ
 ze5MKZlkTpjTnsL/ZDXsr0BucrBt7tzdTCWRjvJhmKUO1HP64DBiOXRDpFP0h+kp
 CoE6or1OxXeoQhRLzEK47OlZ9IyeVTnXv/ET70m1KNiSXUPrFKybr7RrXkhR3Y9r
 mEn1jA==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hn5pkmpt4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 01 Nov 2026 22:21:53 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-139b62317d0so4537395c88.0
 for <dri-devel@lists.freedesktop.org>; Sun, 01 Nov 2026 14:21:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793571712; x=1794176512;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+e+UbA44vcf8UTJECZJplFj0MSqoCWvpoDyTNmMPLK8=;
 b=YaQXC9Rake98we7zqlJ6EudoDRm8NqXD6EL+H4htACtwfkDRpv3EZSBSo5anv21tPP
 Oxa64yYOW92xECv5324o7LmAisG8TdERLvWFSSMjU4dXNekbhIaadCWbLZy8KiJdgujD
 3bafxqAuo5tfERRBM7PWug3Glf5mLVdWs/SpFgARpgo4WDDatFv+UUg3rIcMMO8CUegA
 fm/wEyi76cn2DTYoYZO6NdAYcjwTqD3Ub+BMk+HhAnWcPb9RgeyqRG2AifXvbx4Z2DJG
 IfpgGC4fRlkada6Ezw0dQrPlsvEJZBwIg4BFYw/V36U/fDzd7LDW5MeEh2SuRDr791Gp
 m3ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793571712; x=1794176512;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+e+UbA44vcf8UTJECZJplFj0MSqoCWvpoDyTNmMPLK8=;
 b=akw0rWj/XLyYz1FaIb9yShmmGJ2DQH6OvYNU7fG5Sag9wFbFzy7xPudwe0KNUKDZLx
 jdyHlP8bqtZtoOFTF0fyUycLrqU4OA0MCTw/c9xtDpPzgsDUbcCKiV5/lv6N44F357Am
 TIH8cfGSZR0IrOqWMgC8bgAt2kVj9k6ipzZ5E++uZcZBzO0P+cgiM4z9lmTUcssIfIYk
 QGMgtRlkbCGbUn7JT4m9PzISdqjFy6cFK16yKrwHSx6PyBmTwI5S8jLPYGkhcoWefNof
 kcVR3QoMD/OmrklFXrFL22g58vBXqFLSieAHzOTQtHwUJCFGEZvPZntPYHR2waxWAT5Q
 kpsQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwUVVv4y+RjZhvAKlsmf12pNjNxQh28jvyMRjEZjWnuxnsptdk9v0gv1GDFj40hDftlyChDpzze+dQ=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIPxeHc4oo/Pt4dXznkY77+jUUY2qmXsp//w9lkmyfATonxWwyo
 1H9W8rbWb87hPrbpIWS1p5+IJXhcK/WqrisCubmhYmo8GHaMEdLcehLtmY3xa0Ro+fujcxJXQ+M
 nzU5cDDoZuSD6/Sh2A47quPnopV7i5tOs6EymHz6MSMhcPKNrd7ZqpFIdRU0NFhydqSWEj1c=
X-Gm-Gg: AYBFou1Bx81msmTGlWDknGJYnPbxHUMFJwc38RNWOi7y8ptN07rJfA5A0hLbT1HRQJp
 qV+SZfGWWquZ/bhYbp+7eeohSlpxaJkZ/j96Q7eNqKdoc/OEVJlveNIFoWxO9Qba0/Ls8E9/dFt
 XgYf8djQI6y0AitBYq+JSFjXAjucFZ0xLno8mk6yV/xVyb+N+n9X1Qqz0SsvaMYoqYr2qtz2AIm
 uzZVA4w6u/0uyuQjVNOfgfoPyFW2hRvsytX5cR6fWEQzYktPaxzBu3kxJQSk7EGZ//L8GUFLWe5
 s0FipilQO+jbHHfrbhvr2J8vfB2xGTwb7qCYC20wAXjyGHV/8Kkqi07wZp86RwbZcH14qIdrq8S
 IIm2ttfO6Cu2M0bSzwIv7E0EMPSi0DkXkpB444qMVYiMv5DlGqRXeE7BLPREfWl7FKfJddJQ4qu
 jH+u7Tuw==
X-Received: by 2002:a05:7022:ea46:20b0:143:5266:48ee with SMTP id
 a92af1059eb24-1ac5ecb4ad3mr14416695c88.42.1793571712276; 
 Sun, 01 Nov 2026 14:21:52 -0800 (PST)
X-Received: by 2002:a05:7022:ea46:20b0:143:5266:48ee with SMTP id
 a92af1059eb24-1ac5ecb4ad3mr14416636c88.42.1793571711559; 
 Sun, 01 Nov 2026 14:21:51 -0800 (PST)
Received: from hu-ekangupt-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1ac13ef1932sm27742653c88.2.2026.11.01.14.21.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Nov 2026 14:21:51 -0800 (PST)
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
Date: Mon, 02 Nov 2026 03:51:15 +0530
Subject: [PATCH v4 02/25] accel/qda: Add initial QDA DRM accelerator driver
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261102-v4-v4-2-88f2f24a5f0b@qti.qualcomm.com>
References: <20261102-v4-v4-0-88f2f24a5f0b@qti.qualcomm.com>
In-Reply-To: <20261102-v4-v4-0-88f2f24a5f0b@qti.qualcomm.com>
To: Oded Gabbay <ogabbay@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>,
 Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>,
 Srinivas Kandagatla <srini@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Philipp Stanner <phasta@kernel.org>, dmitry.baryshkov@oss.qualcomm.com,
 andersson@kernel.org, krzk@kernel.org, rob.clark@oss.qualcomm.com,
 jgg@ziepe.ca
Cc: lingtong@qti.qualcomm.com, cacar@qti.qualcomm.com,
 sandheep@qti.qualcomm.com, Bharath Kumar <bkumar@qti.qualcomm.com>,
 Chenna Kesava Raju <chennak@qti.qualcomm.com>,
 dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
 Bharath Kumar <quic_bkumar@quicinc.com>,
 Chenna Kesava Raju <quic_chennak@quicinc.com>,
 Ekansh Gupta <ekangupt@qti.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793571679; l=12898;
 i=ekangupt@qti.qualcomm.com; s=20260223; h=from:subject:message-id;
 bh=F1iB2txhAlMtDV5SE45Y5wVcBvdSVuSaauH/TqBkY44=;
 b=xEcvjWQxmKnXBu17rNu2cKJ3gHWFBVD3phell8y0BSa6WK9dNs+63D4oFjOlrGyQnfLY1Va2g
 VB6jkLfx6NcCd9VDQPS1/aYJvin851oS2m+MWAPiCd/LrDmXDvWilXb
X-Developer-Key: i=ekangupt@qti.qualcomm.com; a=ed25519;
 pk=n0SepARizye+pYjhjg1RA5J+Nq4+IJbyRcBybU+/ERQ=
X-Proofpoint-GUID: a2wet2JCAFmVXXASfbAHAUytnlE9-v6V
X-Authority-Analysis: v=2.4 cv=Z4F5j3RA c=1 sm=1 tr=0 ts=6ae7bb81 cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=e5mUnYsNAAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=ZwOoXynyJOYGx0NfN0cA:9
 a=QEXdDO2ut3YA:10 a=vr4QvYf-bLy2KjpDp97w:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAxMDA4OSBTYWx0ZWRfX9EeED+v3vaJ3
 xU56GPjZYvC8JOKjG6TTvoReM/8bz65khDein6zldKMXd19xqYUs46wpR/wPLCxGviiy07CboHn
 z6MM3hkNkPAtEgT8ZoW9bi7/V8uirOw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAxMDA4OSBTYWx0ZWRfXwkO7fu4g3Tqy
 jp0lPAljjqiTi5NXnGzIO6Dy95/GTkcs/ZxQYiz0MubYiIhS/AuaZY2Xt9yN2jUOFRNgVwJe5QO
 Wrj9qA+2W/y5uvEA5MamTivZcmvVEPv47QDAgiz+YNUi+2L3GTLcLJOPAs0fyoXkjqbGlPaJOMH
 XTJcTdcRhX9MnCh0lbDb76GCsPt/3XCeo2WtSnt75xOUPZgEBIt7vzSvEHiYbzNWLkKZ09i/zUw
 G0JqMvDxgFcXVurQzLP1Yd16Yh8+fhhu7NuO8p+O5QkaVoi0WtohBAkKW3M0PrpkamxRLxSXrzm
 qVFDTOI7xZtLWX1Bjyl9KvH0wChmPoFRabn/BcF6ZpKSxA9Ex/4imOHMKE3fIFkZRsTHNXLsT42
 d3N5bna2mwC0asn3RKtUNHE9d3ZGKMfZ1xR2oFAeJXSTTu9TtrU6VkCR3Ngwirh47bWId0n7LdI
 ZStQ5dEHZhVAR7Qq6Vw==
X-Proofpoint-ORIG-GUID: a2wet2JCAFmVXXASfbAHAUytnlE9-v6V
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-01_07,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 phishscore=0 impostorscore=0 adultscore=0 spamscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611010089
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

Qualcomm SoCs offload work to Hexagon DSPs today through
drivers/misc/fastrpc.c, a misc character device driver written before
the DRM accel subsystem existed. QDA is a new driver for the same
hardware, built around GEM and DMA-BUF instead of the ad hoc buffer
tracking the legacy driver has to do on its own, and exposed through
/dev/accel/accelN like other compute accelerators.

This patch lays the skeleton: a drm_driver with DRIVER_COMPUTE_ACCEL,
per-session state that later patches share between the native UAPI and
the legacy compatibility shim, and an rpmsg binding that brings the
device up when the DSP's RPMsg channel appears. The DSP domain name
comes from the "label" property already used on this node, since that
is how the platform identifies which Hexagon instance a given channel
talks to.

Both compatibles the binding defines are matched, so the driver probes
on every platform the legacy driver supports. The glymur, hawi, maili
and nord nodes name "qcom,kaanapali-fastrpc" as their fallback
compatible and so are matched by that entry. The DSP parameters that
differ between these platforms - the stream ID position in a
DSP-visible address, the DMA address width, and whether the firmware
supports invoke completion polling - are added as match data together
with the code that uses them, since the values are only meaningful
next to it.

The rpmsg binding targets the same compatibles that
drivers/misc/fastrpc.c binds to, because both drivers talk to the same
physical DSP behind the same RPMsg channel. Two rpmsg_drivers cannot
share a device, and driver_register() refuses two drivers with the same
name on one bus, so drivers/misc/Kconfig now makes QCOM_FASTRPC depend
on !DRM_ACCEL_QDA: a given kernel build contains one or the other. The
dependency is expressed on the legacy symbol so that enabling QDA is
what turns fastrpc off, rather than the reverse.

Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
---
 MAINTAINERS                   |  1 +
 drivers/accel/Kconfig         |  1 +
 drivers/accel/Makefile        |  3 +-
 drivers/accel/qda/Kconfig     | 27 +++++++++++++
 drivers/accel/qda/Makefile    | 10 +++++
 drivers/accel/qda/qda_drv.c   | 84 +++++++++++++++++++++++++++++++++++++++
 drivers/accel/qda/qda_drv.h   | 65 +++++++++++++++++++++++++++++++
 drivers/accel/qda/qda_rpmsg.c | 91 +++++++++++++++++++++++++++++++++++++++++++
 drivers/misc/Kconfig          |  1 +
 9 files changed, 282 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6803c60cbc64..77687a35ac13 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22981,6 +22981,7 @@ L:	dri-devel@lists.freedesktop.org
 S:	Supported
 T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
 F:	Documentation/accel/qda/
+F:	drivers/accel/qda/
 
 QUALCOMM EMAC GIGABIT ETHERNET DRIVER
 M:	Timur Tabi <timur@kernel.org>
diff --git a/drivers/accel/Kconfig b/drivers/accel/Kconfig
index bdf48ccafcf2..74ac0f71bc9d 100644
--- a/drivers/accel/Kconfig
+++ b/drivers/accel/Kconfig
@@ -29,6 +29,7 @@ source "drivers/accel/ethosu/Kconfig"
 source "drivers/accel/habanalabs/Kconfig"
 source "drivers/accel/ivpu/Kconfig"
 source "drivers/accel/qaic/Kconfig"
+source "drivers/accel/qda/Kconfig"
 source "drivers/accel/rocket/Kconfig"
 
 endif
diff --git a/drivers/accel/Makefile b/drivers/accel/Makefile
index 1d3a7251b950..17686a592900 100644
--- a/drivers/accel/Makefile
+++ b/drivers/accel/Makefile
@@ -5,4 +5,5 @@ obj-$(CONFIG_DRM_ACCEL_ARM_ETHOSU)	+= ethosu/
 obj-$(CONFIG_DRM_ACCEL_HABANALABS)	+= habanalabs/
 obj-$(CONFIG_DRM_ACCEL_IVPU)		+= ivpu/
 obj-$(CONFIG_DRM_ACCEL_QAIC)		+= qaic/
-obj-$(CONFIG_DRM_ACCEL_ROCKET)		+= rocket/
\ No newline at end of file
+obj-$(CONFIG_DRM_ACCEL_QDA)		+= qda/
+obj-$(CONFIG_DRM_ACCEL_ROCKET)		+= rocket/
diff --git a/drivers/accel/qda/Kconfig b/drivers/accel/qda/Kconfig
new file mode 100644
index 000000000000..e2f3f01016c6
--- /dev/null
+++ b/drivers/accel/qda/Kconfig
@@ -0,0 +1,27 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Qualcomm DSP accelerator driver
+#
+
+config DRM_ACCEL_QDA
+	tristate "Qualcomm DSP accelerator"
+	depends on DRM_ACCEL
+	depends on ARCH_QCOM || COMPILE_TEST
+	depends on RPMSG
+	help
+	  Enables the DRM-based accelerator driver for Qualcomm's Hexagon DSPs.
+	  This driver provides a standardized interface for offloading computational
+	  tasks to the DSP, including audio processing, sensor offload, computer
+	  vision, and AI inference workloads.
+
+	  The driver supports all DSP domains (ADSP, CDSP, SDSP, GDSP) and
+	  implements the FastRPC protocol for communication between the application
+	  processor and DSP. It integrates with the Linux kernel's Compute
+	  Accelerators subsystem (drivers/accel/) and is intended to replace the
+	  FastRPC driver in drivers/misc/. Both drivers bind the same device tree
+	  nodes, so only one of them can be built.
+
+	  If unsure, say N.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called qda.
diff --git a/drivers/accel/qda/Makefile b/drivers/accel/qda/Makefile
new file mode 100644
index 000000000000..dbe809067a8b
--- /dev/null
+++ b/drivers/accel/qda/Makefile
@@ -0,0 +1,10 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Makefile for Qualcomm DSP accelerator driver
+#
+
+obj-$(CONFIG_DRM_ACCEL_QDA)	:= qda.o
+
+qda-y := \
+	qda_drv.o \
+	qda_rpmsg.o
diff --git a/drivers/accel/qda/qda_drv.c b/drivers/accel/qda/qda_drv.c
new file mode 100644
index 000000000000..f4430332ff6e
--- /dev/null
+++ b/drivers/accel/qda/qda_drv.c
@@ -0,0 +1,84 @@
+// SPDX-License-Identifier: GPL-2.0-only
+// Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <drm/drm_accel.h>
+#include <drm/drm_drv.h>
+#include <drm/drm_file.h>
+#include <drm/drm_gem.h>
+#include <drm/drm_ioctl.h>
+#include <drm/drm_print.h>
+
+#include "qda_drv.h"
+
+static struct qda_session *qda_session_alloc(struct qda_dev *qdev)
+{
+	struct qda_session *session;
+
+	session = kzalloc_obj(*session);
+	if (!session)
+		return ERR_PTR(-ENOMEM);
+
+	session->qda_dev = qdev;
+
+	return session;
+}
+
+static int qda_open(struct drm_device *dev, struct drm_file *file)
+{
+	struct qda_dev *qdev = qda_dev_from_drm(dev);
+	struct qda_session *session;
+
+	session = qda_session_alloc(qdev);
+	if (IS_ERR(session))
+		return PTR_ERR(session);
+
+	session->file = file;
+	file->driver_priv = session;
+
+	return 0;
+}
+
+static void qda_postclose(struct drm_device *dev, struct drm_file *file)
+{
+	struct qda_session *session = file->driver_priv;
+
+	kfree(session);
+}
+
+DEFINE_DRM_ACCEL_FOPS(qda_accel_fops);
+
+static const struct drm_driver qda_drm_driver = {
+	.driver_features = DRIVER_COMPUTE_ACCEL,
+	.fops = &qda_accel_fops,
+	.open = qda_open,
+	.postclose = qda_postclose,
+	.name = QDA_DRIVER_NAME,
+	.desc = "Qualcomm DSP Accelerator Driver",
+};
+
+struct qda_dev *qda_alloc_device(struct device *dev)
+{
+	struct qda_dev *qdev;
+
+	qdev = devm_drm_dev_alloc(dev, &qda_drm_driver, struct qda_dev, drm_dev);
+	if (IS_ERR(qdev))
+		return ERR_CAST(qdev);
+
+	return qdev;
+}
+
+int qda_register_device(struct qda_dev *qdev)
+{
+	int ret;
+
+	ret = drm_dev_register(&qdev->drm_dev, 0);
+	if (ret)
+		drm_err(&qdev->drm_dev, "Failed to register DRM device: %d\n", ret);
+
+	return ret;
+}
+
+MODULE_AUTHOR("Qualcomm AI Infra Team");
+MODULE_DESCRIPTION("Qualcomm DSP Accelerator Driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/accel/qda/qda_drv.h b/drivers/accel/qda/qda_drv.h
new file mode 100644
index 000000000000..dd3345b6a5ad
--- /dev/null
+++ b/drivers/accel/qda/qda_drv.h
@@ -0,0 +1,65 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#ifndef __QDA_DRV_H__
+#define __QDA_DRV_H__
+
+#include <linux/device.h>
+#include <linux/rpmsg.h>
+#include <linux/types.h>
+#include <drm/drm_device.h>
+#include <drm/drm_drv.h>
+#include <drm/drm_file.h>
+
+/* Driver identification */
+#define QDA_DRIVER_NAME "qda"
+
+/**
+ * struct qda_session - Per-open-file private data
+ *
+ * Allocated in qda_open() and stored in drm_file::driver_priv.
+ */
+struct qda_session {
+	/** @qda_dev: Back-pointer to device structure */
+	struct qda_dev *qda_dev;
+	/** @file: The drm_file this session belongs to */
+	struct drm_file *file;
+};
+
+/**
+ * struct qda_dev - Main device structure for QDA driver
+ *
+ * The DRM device is embedded as the first member so that container_of()
+ * can recover the qda_dev from any drm_device pointer.
+ */
+struct qda_dev {
+	/** @drm_dev: Embedded DRM device; recover via qda_dev_from_drm() */
+	struct drm_device drm_dev;
+	/** @rpdev: RPMsg device for communication with the remote processor */
+	struct rpmsg_device *rpdev;
+	/** @dev: Underlying Linux device */
+	struct device *dev;
+	/** @dsp_name: Name of the DSP domain (e.g. "cdsp", "adsp") */
+	const char *dsp_name;
+};
+
+/**
+ * qda_dev_from_drm - Recover qda_dev from an embedded drm_device pointer
+ * @dev: Pointer to the embedded drm_device
+ *
+ * Return: Pointer to the enclosing qda_dev.
+ */
+static inline struct qda_dev *qda_dev_from_drm(struct drm_device *dev)
+{
+	return container_of(dev, struct qda_dev, drm_dev);
+}
+
+/* Device allocation (uses devm_drm_dev_alloc internally) */
+struct qda_dev *qda_alloc_device(struct device *dev);
+
+/* Core device lifecycle */
+int qda_register_device(struct qda_dev *qdev);
+
+#endif /* __QDA_DRV_H__ */
diff --git a/drivers/accel/qda/qda_rpmsg.c b/drivers/accel/qda/qda_rpmsg.c
new file mode 100644
index 000000000000..6bd977e8d68a
--- /dev/null
+++ b/drivers/accel/qda/qda_rpmsg.c
@@ -0,0 +1,91 @@
+// SPDX-License-Identifier: GPL-2.0-only
+// Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/rpmsg.h>
+#include <drm/drm_print.h>
+
+#include "qda_drv.h"
+
+/*
+ * Both compatibles the binding defines are matched here. The glymur, hawi,
+ * maili and nord nodes name "qcom,kaanapali-fastrpc" as their fallback
+ * compatible and so are matched by that entry. Per-SoC DSP parameters are
+ * attached as match data by a later patch, once there is something that
+ * consumes them.
+ */
+static const struct of_device_id qda_rpmsg_of_match[] = {
+	{ .compatible = "qcom,kaanapali-fastrpc" },
+	{ .compatible = "qcom,fastrpc" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, qda_rpmsg_of_match);
+
+static struct qda_dev *qda_rpmsg_alloc_and_init_qdev(struct rpmsg_device *rpdev)
+{
+	struct qda_dev *qdev;
+
+	qdev = qda_alloc_device(&rpdev->dev);
+	if (IS_ERR(qdev))
+		return qdev;
+
+	qdev->dev = &rpdev->dev;
+	qdev->rpdev = rpdev;
+	dev_set_drvdata(&rpdev->dev, qdev);
+
+	return qdev;
+}
+
+/*
+ * The rpmsg core requires a callback, so one is registered from the start.
+ * Responses are dispatched here once there are invocations to answer.
+ */
+static int qda_rpmsg_cb(struct rpmsg_device *rpdev, void *data, int len,
+			void *priv, u32 src)
+{
+	return 0;
+}
+
+static void qda_rpmsg_remove(struct rpmsg_device *rpdev)
+{
+	struct qda_dev *qdev = dev_get_drvdata(&rpdev->dev);
+
+	/*
+	 * Unplug before clearing @rpdev: once there are ioctls that reach the
+	 * DSP, this is what stops a new one from starting and waits for the
+	 * ones already running, so that none of them sees a transport that has
+	 * gone away.
+	 */
+	drm_dev_unplug(&qdev->drm_dev);
+	qdev->rpdev = NULL;
+}
+
+static int qda_rpmsg_probe(struct rpmsg_device *rpdev)
+{
+	struct qda_dev *qdev;
+	int ret;
+
+	qdev = qda_rpmsg_alloc_and_init_qdev(rpdev);
+	if (IS_ERR(qdev))
+		return PTR_ERR(qdev);
+
+	ret = of_property_read_string(rpdev->dev.of_node, "label", &qdev->dsp_name);
+	if (ret) {
+		dev_err(&rpdev->dev, "Missing 'label' property in DT node: %d\n", ret);
+		return ret;
+	}
+
+	return qda_register_device(qdev);
+}
+
+static struct rpmsg_driver qda_rpmsg_driver = {
+	.probe = qda_rpmsg_probe,
+	.remove = qda_rpmsg_remove,
+	.callback = qda_rpmsg_cb,
+	.drv = {
+		.name = QDA_DRIVER_NAME,
+		.of_match_table = qda_rpmsg_of_match,
+	},
+};
+
+module_rpmsg_driver(qda_rpmsg_driver);
diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index c40e89cc5724..14b7bbaadcaa 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -269,6 +269,7 @@ config QCOM_FASTRPC
 	tristate "Qualcomm FastRPC"
 	depends on ARCH_QCOM || COMPILE_TEST
 	depends on RPMSG
+	depends on !DRM_ACCEL_QDA
 	select DMA_SHARED_BUFFER
 	select QCOM_SCM
 	help

-- 
2.34.1

