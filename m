Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64E0CC53209
	for <dri-devel@archiver.kernel.org>; Mon, 27 Jul 2026 17:34:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A696C10E696;
	Mon, 27 Jul 2026 17:34:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="pdVIoFAe";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aZjo5QaF";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A12FB10E4BD
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Jul 2026 17:33:41 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66RDlarE3905404
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Jul 2026 17:33:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=cF8c4q3C/Ch
 cYb2N5kbu5QRV+XcoHZMqcfbrFNapFxA=; b=pdVIoFAeOdYcXTrVdXPAj1blwyv
 +A17VSDPKhPLcdDW3w0NBJEbXSTaHvN1p3osEaROidbMY7Il3PtkRlMGyEtC2t4x
 kkcmY0RWqJPnnBTI/90uEPmdNoehFc0BV+x1kIGEfN0dBqjCUrQ1L7mgaS4YTROg
 6fHU8KOqU3O7RSPt8MaKXb+Co+bKYXzh6pg1bn7k+G/VqGTYTl3AKiGRYGa95d/M
 kUvH8zJj06XNaaqzWOqW1ooZQx02M/L8lytdVS1QCAEMk4fK3Nilg28l7gjPNfAk
 GP1f58yaVfXvzjHJXdsy/mNp3dLeENvM/tO/QDUqPDbkQJvHd0ioynz0Rhw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fp4ukt09v-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Jul 2026 17:33:40 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-51c21c01cf3so51108071cf.2
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Jul 2026 10:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785173620; x=1785778420;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cF8c4q3C/ChcYb2N5kbu5QRV+XcoHZMqcfbrFNapFxA=;
 b=aZjo5QaF7HMXqHs/gfo3bG72v0xTnL3OT39hvgjiyIzJPblUbJnnqyz+zy/TPD8ANH
 qZw6doAsEfGlNhkuaNBni/PCb1md6jbozuzyT/0/0LhsU58u4eWYbVxhtMuiuomLx9t4
 fxxa8tAdj7Uxq93yfe4iK6eDOJZMrdaZVzjrNFbYBIKVSDOXBOASR8dBY3bUwe5mTxRi
 XcriwFnDjcf5ocKOHMn3dZBlbVmwnDGblrsFVCI9aWqx+Q041LPkNrK/kxernS+Bw+Z/
 F/TJG7ZSX3J7GnyaXQMtuL8VK1ngxBAqqRMeA+vOoSwSzwpmDaii1aNwSG4zsgbCq6oc
 KHWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785173620; x=1785778420;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=cF8c4q3C/ChcYb2N5kbu5QRV+XcoHZMqcfbrFNapFxA=;
 b=tS7wJ8JbWnCzXrSRmCKSPd0VmCuUA3Ws/nQ6t6a16vumtureAEn5e9T6yaUk0B7m70
 9Fmo9BK8mlIq9/SV2LeZjzjRZYaB+Ht46LSM6e6ctssvCtORjVsFjEDElGwWNAFxZA6q
 5Cy3Tr1DKw86Bd9wk2BbO1bArVlH2++Re/xdHqrYxRkqZzEDiTvXv9PsU1IjjesACyzL
 oR/pjkJlThDfsJjMXvn1URdQodrzs9wsWY0FYv0VRsRxPBq/BfiDARAup/l2le1yDkiY
 niJx/u22kvI8Hc8Qrzz3ma3V25QF7pxTq2qQ7Wfi900TCkWXh+XRdP8hzsnxI7vQWHXt
 Nfiw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqzCXmLSUKaXWD0lEPht3w05TPsUppC81xSnekq+D6MSBneDy07mvp1ikDZ96G6XxV3j9g6V+wOjOM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy+IL4Jv6bbAHXYoyRf7/ut61o6xT6kwXDTz+sOunliCvksXXUT
 9+KyJ6S+exQbTvVAus+UESh3nvkqLTtccTrr9qmr0mfi1dKkd0sm1OEwUCCy9irR2jSzkUKwOaK
 aAdLFn7c5xlNpHLOVaqRKIn2syDp+6EgcUcC9pCZnPvrta8matN7vzExxPaQZ9JDGwRZhDtU=
X-Gm-Gg: AR+sD10IeTi9lBRBrG0VtO3a+U4ot6dQMCcRdLtgrRjBXrt/LlmqGx/nGXp5PaWWuAW
 aMvw5ETRcrwP3ekrPmCFhjoZwgi4zNTeQoT2hnn4e/x/rSwFAI6rBD9/i03L7LQHCYBL5NcLvAS
 QlvbcdR0IUdug/mTRhG2cWxIiWAAvml/nAChk/qF1+MQocOpnjus9FIKJL/MCnlV1JECoUhjipb
 4PbeejD73CQsemnkWxvudPjmjQ5B5k8+hUiuzC0sW9K4Y/2TaIu/LNkmxAtw/AE9uRqI7L1XsjX
 VGf4yvroejP9Uqxz2q2DgleVS/1QwWr6QhxF46KopYKAGAMvljvAaKCLkO2gS/I0Lpe9SRM/67+
 u6+tN4TiqFfl8nSyTKrjqTeHcPvvChoTPhoOfDEdG
X-Received: by 2002:a05:622a:1dc5:b0:519:5680:1b5 with SMTP id
 d75a77b69052e-529a83a1c35mr97301031cf.21.1785173619708; 
 Mon, 27 Jul 2026 10:33:39 -0700 (PDT)
X-Received: by 2002:a05:622a:1dc5:b0:519:5680:1b5 with SMTP id
 d75a77b69052e-529a83a1c35mr97300671cf.21.1785173619206; 
 Mon, 27 Jul 2026 10:33:39 -0700 (PDT)
Received: from hu-yabdulra-ams.qualcomm.com ([212.136.9.4])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-69fb5543370sm2945391a12.15.2026.07.27.10.33.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 10:33:37 -0700 (PDT)
From: Youssef Samir <youssef.abdulrahman@oss.qualcomm.com>
To: jeff.hugo@oss.qualcomm.com, carl.vanderlip@oss.qualcomm.com,
 troy.hanson@oss.qualcomm.com, zachary.mckevitt@oss.qualcomm.com
Cc: ogabbay@kernel.org, lizhi.hou@amd.com, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org
Subject: [PATCH 4/5] accel/qaic: Add <linux/device-id/mhi.h> to qaic_ras.c
Date: Mon, 27 Jul 2026 19:33:25 +0200
Message-ID: <20260727173326.2219191-5-youssef.abdulrahman@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260727173326.2219191-1-youssef.abdulrahman@oss.qualcomm.com>
References: <20260727173326.2219191-1-youssef.abdulrahman@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: sBdvOOQKtND7b0lP3iiUq3VyNtwiV-mI
X-Proofpoint-ORIG-GUID: sBdvOOQKtND7b0lP3iiUq3VyNtwiV-mI
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDE2MiBTYWx0ZWRfX8EaX4gMKEA8z
 oxipoEZZmoWPkQGhl6lNVDNqQNSImFm7qq+7iAUi7GcVDTnLzjQBU/Zu06u5f5uoPAs0d/P60Pk
 fUoo+q40DveQVf17TyFCNal2YVN+mac=
X-Authority-Analysis: v=2.4 cv=PeHPQChd c=1 sm=1 tr=0 ts=6a679674 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=dNlqnMcrdpbb+gQrTujlOQ==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=k-DYV1Y2ufZ2VE7ThZYA:9 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDE2MiBTYWx0ZWRfX1t3kJ3UIgWp7
 2z7ERUmSnxPe4PwnejuqDP8fItpGjrT4Sw8KKeVg7xJDyfGVZZ75MYH3UdlrdJyFen35wPzjOEl
 Ffm7ExOBo4oKOWSWYgUPD6D2QdeY15f2T6hAjx4xOYLDd+OoffOK26nElSCVCU3KF24RhKhrTxU
 DvZKVMvr++mirXa0Dgc4lXAgbY8M0yn72qGyInevMWlqzoR9NGDLkEnzYuWAKecUEkwEE2wP8NN
 vnWv802OviMT6SjypMSPKOcUg0Fv43hdT0QE3QzMtj7xMkgFYPDhdf9DFyUNZbOLteWhbYTC24o
 vC5/+BJ2eEZiR/4j8fn1yn1yGLWMG1CtMl4CPYLYLTcBCPTrQa8sPXJxOzNXVsRUaGfiCfJWsR5
 GJBW4Gm/RStuAXWQBbzqW0MBiQqXe0A6xrzxP7Zq4gi9xzMoyy+Ux6JTY38eOcy5chHZ+AmSTT+
 ese7u87iVQDGxIHgG+g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_04,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 clxscore=1011 adultscore=0 spamscore=0
 phishscore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501 suspectscore=0
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

qaic_ras.c uses mhi_device_id implicitly. Include <linux/device-id/mhi.h>.

Fixes: c11a50b170e7 ("accel/qaic: Add Reliability, Accessibility, Serviceability (RAS)")
Signed-off-by: Youssef Samir <youssef.abdulrahman@oss.qualcomm.com>
---
 drivers/accel/qaic/qaic_ras.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/accel/qaic/qaic_ras.c b/drivers/accel/qaic/qaic_ras.c
index e0205c2cda3d..236e520f708f 100644
--- a/drivers/accel/qaic/qaic_ras.c
+++ b/drivers/accel/qaic/qaic_ras.c
@@ -5,6 +5,7 @@
 
 #include <asm/byteorder.h>
 #include <linux/device.h>
+#include <linux/device-id/mhi.h>
 #include <linux/kernel.h>
 #include <linux/mhi.h>
 
-- 
2.43.0

