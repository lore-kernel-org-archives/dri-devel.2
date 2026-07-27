Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 151A8C531D0
	for <dri-devel@archiver.kernel.org>; Mon, 27 Jul 2026 17:33:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F90610E4B8;
	Mon, 27 Jul 2026 17:33:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="KQ9WT2WN";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZZPGxOwl";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9075010E4AD
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Jul 2026 17:33:34 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66RDldam4115129
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Jul 2026 17:33:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=pykGkpBHLHe
 z0gxAx6a95OD7i3/0FrTbzAT7IRtx0Tk=; b=KQ9WT2WNjLiLWwz6oJxi0OVWI6I
 66gYQ/s2pszSC/EYVJc1V6eee3499VNomRpvOjnl/4BSWq5jXC536histT0EGLjO
 seitOSEM5wLKGPWudlRsjjZYxFXERo74dRg+vKBuPgu6RBDFIgMw0KNireTaHrMc
 PbSkRHfDbZ5bqIP6xVBFUlo+3Np8dAUIWRXRXr6QPq4gaHrv2EKjnSWNU0uLs568
 UjZvkFCyZqbhlw7HHO9y1+YrItDWTC7KdMaSTY4dub0MwNU/GojFdLsZdb+u9nh4
 P+KXqQ03H9TSJcS4qaAIfU+fh5Y7x3NuNhrK2fK2wH+CES/RY0iK+Ksib8Q==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fp4mrt2vp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Jul 2026 17:33:33 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-51c1d137a68so61461781cf.3
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Jul 2026 10:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785173613; x=1785778413;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pykGkpBHLHez0gxAx6a95OD7i3/0FrTbzAT7IRtx0Tk=;
 b=ZZPGxOwlYH7Rg2RNsYOu29cFt9BdfymNpy/Tt4mhW/Ccj5Lif3iiyg8EgcM22l8+e2
 ho3W6VV3PvhA4X6LsIfXr/lQvsIiYDXaDQFn1cot77TgS4n8yD8nLUJm1vGx/AGlA/mH
 R8yBbohQT94uxYddfUcT0A0sHyuqIif0ExejFTq7w3wyXN8EsBaFmrRTMwDcZkjUeR9N
 MO+ejFLqEdG71dkKyj/y5Zu1F6z5bzhLQRqGAAeVPeCE0bZcj7SiB2uPuAw3uKP7SWue
 7Kxo0FAsDKP/rfATwwymDkk4i4F46HMWovKXXIVpXRlNsFyg7P8ucK4Fl5QcJD7Qn6I4
 B5NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785173613; x=1785778413;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=pykGkpBHLHez0gxAx6a95OD7i3/0FrTbzAT7IRtx0Tk=;
 b=guNR+1KwUvLZhpHaqMPfOXJ969DGLze2gesKJrts9q3/BVLXQuYZ1/0+ISQZZ442lt
 4zjCj0Jvk2RNcP5gGj3G8JJr8KTImNSMU55cyOJrEXn13k5etg/H4ZXcG4bT4aeztpc3
 5i+uKwZwFHeevkoKYHFnLt7eTNk4gGROIpxlAMwQmhkC8MzPErnA/XjUY6R3l7MdbHNX
 KraKRreNYAyY0dSbgf6LCvxaIEXKshj5Nef9aEP+OMg5GvjSPSAh0QNv3Eh/NhAQMWHt
 txRasylw87tSsbaXIVdc2BZXOOZnKWGjklHv+F43HB5tm0t/FatHlMM2J3k8jIh1jLb/
 nq8g==
X-Forwarded-Encrypted: i=1;
 AHgh+RpW3o1vSMXlr2J/X8aOb+PD1CpTtMgi1bQOayp5dGAAk48Bm34HxRNLsU3wN6db39yRiKlHw2miU6M=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxiWzKI03hOKhg6WvE/gfaMe8NT8tahU44pULNetAEoc8+Dk18U
 D19GMF53ldL1Or3lks7eZU+KlkLNhENidUP4PCeB/bU/JU1+HhNJx/GgQ0qV+VZMdfORuG+ZWbk
 aOrpp7HF24Bdj3bWT+H1l8ej6bAAlaTciUrcsNKACXdPDTLtWD9Uh5227/id51UfBugdbVoU=
X-Gm-Gg: AR+sD11ztazkYF8MEWBRP2UZrOkrnG/vyGo7/rErg7LAVUjT414vg/N3EmsQO/gCVEq
 Y0l034f4gVuJUtLQdQYODabPahm3ZUOjNpMQbnJzDzb6d4TpGXIPUwNmnK+o5HFrjtWPseQizpp
 U6sonO+7fbutXvD12nQBstRaC2ZKBxFdLxV4MGNz5M0MkneDbSL7my3vAzs2d9TYAG159nVZBwQ
 F+KOKeOWj/sEbVt9KLRreVxJdip9WeETS9Ey88rWNNPcOUAd4iMhP6hZfg25P7tNrFXCW+MolNC
 3haPApAXb8Suj2EyydkBFg4sub8Uw2TyCGPXgUUAiuYo3fyo2fw498V6tEqG4unkniLJTTeHSbC
 ZD3Dwf6hhx5eE0APWsRxlDZl4Ny5YvKYGlJeeuiDp
X-Received: by 2002:ac8:5f8d:0:b0:51a:8eca:78e3 with SMTP id
 d75a77b69052e-529a836b9c7mr90956721cf.5.1785173612527; 
 Mon, 27 Jul 2026 10:33:32 -0700 (PDT)
X-Received: by 2002:ac8:5f8d:0:b0:51a:8eca:78e3 with SMTP id
 d75a77b69052e-529a836b9c7mr90956371cf.5.1785173612061; 
 Mon, 27 Jul 2026 10:33:32 -0700 (PDT)
Received: from hu-yabdulra-ams.qualcomm.com ([212.136.9.4])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-69fb5543370sm2945391a12.15.2026.07.27.10.33.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 10:33:30 -0700 (PDT)
From: Youssef Samir <youssef.abdulrahman@oss.qualcomm.com>
To: jeff.hugo@oss.qualcomm.com, carl.vanderlip@oss.qualcomm.com,
 troy.hanson@oss.qualcomm.com, zachary.mckevitt@oss.qualcomm.com
Cc: ogabbay@kernel.org, lizhi.hou@amd.com, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org
Subject: [PATCH 1/5] accel/qaic: Add missing <linux/device-id/mhi.h> to sahara
 and timesync
Date: Mon, 27 Jul 2026 19:33:22 +0200
Message-ID: <20260727173326.2219191-2-youssef.abdulrahman@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260727173326.2219191-1-youssef.abdulrahman@oss.qualcomm.com>
References: <20260727173326.2219191-1-youssef.abdulrahman@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDE2MiBTYWx0ZWRfX5nkxnn+3VzrO
 SSDIw8XDtU42X/2o82BuOeo/9wtA+y/sEhhtQnA125zsktPvRqpY6TLz+TbwPhu1d6rZ7e/5iNq
 aqXt35t1OrKKKfzUxpgVZkVhq88NVog=
X-Authority-Analysis: v=2.4 cv=UYBhjqSN c=1 sm=1 tr=0 ts=6a67966d cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=dNlqnMcrdpbb+gQrTujlOQ==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=ReSfefp3vd-I0XYAfNQA:9 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: xhBxu5KjZgECrAX1YRcHOK7ADLiCvTqa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDE2MiBTYWx0ZWRfX1K3c3ufW9Vrh
 3sln/rusUs4KstHxBMzCZ3snhZLLmNXbyOMJBwehNV3JFfLPNn7Iz9O4aY3hY3Bz5ognaXyRFNp
 IvguQwm05jiQHR0aa3jmRKTrORjrVZ5fciAI/g/Y8BA/zZ/c8dOGyeqa2hMGbq0b67a90ymjB5w
 53sRNl41JwyZev1qokRcjuz/+j8OALsX/NwGA8lpFWWCRWEkv8tTXQKUjppKfjhChxk4VwWzDsW
 d51ZwYbXJJoL5pxynIFVKRuCyRqZ7t5106ttwyyYegl79ynRy+LSF+4/HU53D5eN78UMFQAFSgd
 UfJNMPXJjbzsMiMaDYnAPcbW1lD1X8A/9bYTHREGOAMenljRNmFt12tC8AML7Og0WxCd5NQ4ghA
 GVpTi1wpdOqCPyOGKGguAxrUDyFI75JKsmMTGBZyIc8DHx1qtSUi93XIsql/zwGHYR1EtgFTag1
 IVxUoqfYwmeoPB1jC3g==
X-Proofpoint-ORIG-GUID: xhBxu5KjZgECrAX1YRcHOK7ADLiCvTqa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_04,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0 clxscore=1011
 priorityscore=1501 phishscore=0 adultscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607270162
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

qaic_timesync.c and sahara.c use struct mhi_device_id implicitly since
commit 995832b2cebe ("Replace <linux/mod_devicetable.h> by more specific
<linux/device-id/*.h> (c files)") removed <linux/mod_devicetable.h>.

Explicitly include <linux/device-id/mhi.h> in qaic_timesync.c and sahara.c.

Fixes: 995832b2cebe ("Replace <linux/mod_devicetable.h> by more specific <linux/device-id/*.h> (c files)")
Signed-off-by: Youssef Samir <youssef.abdulrahman@oss.qualcomm.com>
---
 drivers/accel/qaic/qaic_timesync.c | 1 +
 drivers/accel/qaic/sahara.c        | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/accel/qaic/qaic_timesync.c b/drivers/accel/qaic/qaic_timesync.c
index 45e5f0728ebe..b5162677ccc4 100644
--- a/drivers/accel/qaic/qaic_timesync.c
+++ b/drivers/accel/qaic/qaic_timesync.c
@@ -2,6 +2,7 @@
 
 /* Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries. */
 
+#include <linux/device-id/mhi.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/math64.h>
diff --git a/drivers/accel/qaic/sahara.c b/drivers/accel/qaic/sahara.c
index c7c0b3eb4b65..8476be9b9148 100644
--- a/drivers/accel/qaic/sahara.c
+++ b/drivers/accel/qaic/sahara.c
@@ -3,6 +3,7 @@
 /* Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries. */
 
 #include <linux/devcoredump.h>
+#include <linux/device-id/mhi.h>
 #include <linux/firmware.h>
 #include <linux/limits.h>
 #include <linux/mhi.h>
-- 
2.43.0

