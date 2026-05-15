Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DF0CCD343F
	for <dri-devel@archiver.kernel.org>; Fri, 15 May 2026 12:42:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 939FF10F513;
	Fri, 15 May 2026 12:42:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZjKVFZCa";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QLp7CQ5V";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF32910F513
 for <dri-devel@lists.freedesktop.org>; Fri, 15 May 2026 12:42:48 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64FBKIkg3512727
 for <dri-devel@lists.freedesktop.org>; Fri, 15 May 2026 12:42:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=qJmRCeRB5pJ
 apgPzBhK677pMIluwek72W5Okvem7r3w=; b=ZjKVFZCaEbYxcZM25k+mYVMckN2
 Bth/8ulD3NxjowSMtDrBI2dYj9pgDoQd/qNPgzdwyhJcSfjXw6NhzPb+Ql8qELvi
 z/wKp855zMDcS8k8gzWlvEdStZkRfngISv6fwj3WGwFOJtyEG2rx3Br+XWFu+3To
 uoT0O83+7H4aXsL5O6Zi30MY++hgCS1uwjZx09Lxi0NXvM0eCF+POAvkLeP/ZKJ9
 Wn/Tj+F6jHaigH4Sue5aXkwJLynKsgsRpZcdK6PJmLYFX9SmBXwhV/MmQ2ULPKrF
 XuBK3FBVOxs4AkYxF26bwOTv6e3xbTflTsRJYmpz1YG2QwEp7MxyuvEs50w==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e5m1vb8vk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 15 May 2026 12:42:47 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2b4530a90fdso209699495ad.1
 for <dri-devel@lists.freedesktop.org>; Fri, 15 May 2026 05:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778848967; x=1779453767;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qJmRCeRB5pJapgPzBhK677pMIluwek72W5Okvem7r3w=;
 b=QLp7CQ5VYIj1TKYmWXQR6SEUwFfUOyOwl278ls7LOLHxKFUE3mDUWB6yD04WsyG19s
 OxV7l5PvnpfbSnKRnG+oorlM+t/JHIKEvX9KjaHYbpxiOnMZecbo/Kd9DxgmoH750nei
 D1hrFAjgifvWAaYEyicss4QpNeGVowxYftTRoFlzkOl9slRloAWA5POVsJtzLTM4Cmxw
 A5ec4/5tIFknUih4pHtch0BYKkV4AbiLnePz1VxAYlT8yPBOlUg0QCZDwzwRdOjYAnw+
 J1k08zQ2C0BPoPJm2i22kjQ/x65Qed/d9mIa24SxgQ6xpskYXZr4o5ccyrN5NZnHbCuw
 yhLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778848967; x=1779453767;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qJmRCeRB5pJapgPzBhK677pMIluwek72W5Okvem7r3w=;
 b=C27yxcO1VE+H8XQOOIPKM2LExl/TqK5sP2atblYPwEdG3tTXloRCTfJWg6y4JTu4Av
 eR/cBO1cymOvdsWYWiX4Fm0r4CzOGDWR3tsrYTYHgawSDW5+LuYz4osH8bNY/ziJLU28
 ugPcbnuQOsJOFFXdKFlEWZVuEJKqViTZCYBaeOSz9Cp7AP5vkLcY13kgX0sX3CD1xp9b
 Bqac5fpnidjq+w/L+EQMRu9MxYAs8+MbRfgnPBxNZZxiV26AgEuiFTljvW1ttgmecl+U
 JHlLcdlJ6aeq4U4sBgV/M8AFHUhCcW7HlIicUPcSyWTv4cRfa0odp3ywmp5vLBDKDlKF
 aWXA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9lEMo5r0O71fYjKr2ItpcfjePowBe7regfSEcb2SivUZbvUP0tA4xpezp5brGyiHtEUiowLYQ1R+M=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzoK+NkFZV4chjhLdjXMd4mLmYzIf9n8G1ID3KKB3XJDWmzL0uK
 ATUt/+oILKVwsiZre+6iuBE/MXBMcqmUEf4rq1cv62ZNjUNP+lJfrJUugLgY8MXZ2TqNsDewV80
 0I/1TRaCjeq9HA3jw8IEQRjbjmIwMEJCuigqIVY/JR7G2zPeEPTbQQeT0KnyjbrfaMOV7ZXM=
X-Gm-Gg: Acq92OG3YgjO/SEm4kM/s1kbMUYsbJtx1CWVQj23pY/rIDglji1Y/Piv33CgQaZ0BR+
 racuASTHat7FOaUmvzzmFHfwcPADGy7z6nUF5J7Vv38Coj+Dt4EROfJZxNSvjbC/B1EJandixHM
 lVL9SuxCelIoBwD0W8ZOsuGbQx4yEZ+Fuiby120cTP/WcOiPM1Sxd32u//aVEh7+AGUd//0KY60
 yllkLKhOKb9moXBN9TMP5vwjjRtUMcht1zPKiNzCxbxlNcXbDg78Tgx1KV3ZUamk2/5IgvR89Rl
 O3U38yDDsQ9BTWa9REBoRD1kqQIfZW2AB2wMLkjQakddTeelOtgAm8Ab90brBv/SsFjZlsZJL7B
 oM2KXCmfiyoAYLcoDSxbSSYppvtjsZHwaRibT8EdZhUo4xBqgmJ4Fwz5IrwWGrsD2e6idfDfNSK
 GUXGt+LvnM2Wm/RJDm0jk=
X-Received: by 2002:a17:903:11d2:b0:2ba:6ffa:bde0 with SMTP id
 d9443c01a7336-2bd7e8c0530mr41111165ad.19.1778848966801; 
 Fri, 15 May 2026 05:42:46 -0700 (PDT)
X-Received: by 2002:a17:903:11d2:b0:2ba:6ffa:bde0 with SMTP id
 d9443c01a7336-2bd7e8c0530mr41110815ad.19.1778848966259; 
 Fri, 15 May 2026 05:42:46 -0700 (PDT)
Received: from QCOM-SocCW5bzXR.qualcomm.com
 (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2bd5c05f27csm56119395ad.25.2026.05.15.05.42.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 05:42:45 -0700 (PDT)
From: Jianping Li <jianping.li@oss.qualcomm.com>
To: srini@kernel.org, amahesh@qti.qualcomm.com, arnd@arndb.de,
 gregkh@linuxfoundation.org, abelvesa@kernel.org,
 jorge.ramirez-ortiz@linaro.org
Cc: Jianping Li <jianping.li@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 ekansh.gupta@oss.qualcomm.com, quic_chennak@quicinc.com, stable@kernel.org
Subject: [PATCH v5 3/5] misc: fastrpc: Fail Audio PD init when reserved memory
 is missing
Date: Fri, 15 May 2026 20:42:15 +0800
Message-Id: <20260515124217.20723-4-jianping.li@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260515124217.20723-1-jianping.li@oss.qualcomm.com>
References: <20260515124217.20723-1-jianping.li@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE1MDEyOSBTYWx0ZWRfX2KhlDFbeCjNf
 ZeqwmMIg/MH2lM67cHjmTXh/qzgU/R9muzc8BYVq3jEa4mSgexEBks1EbS/9Xjxd2j6sP1NQzMH
 SESyO3Y2G41jxQxEkS4p3Ax7C/qCvCwV/wtb02pGc4bh+f3EXKXL/6q1iRTBLOZGoL3gy86cgO+
 ugnUYtjOVRK7vSdU++39fSR3IdtRYmiYqjzIQWkD8/+LnaLtHGtkP5R2TwOXn+tB4x39JWE6I8U
 mh3FS12alNgC/7QyXzEyNOcGYfD5azFGZJoknJ/XNfUbb/WOGO/Oga1AGJBl1PrcogsYBP02c/o
 F3NUtad9vzxPzTrCasQ+I19oMnl40EoE2A0VIqPlVsiES9Zmsxi3ueVZcGQsuntGXiegCCNTlfo
 pTI9udKlsQD0rtDuqDT7CBqjDoQYhXkpgFgr/6eg48CffB9ps1bWET6HT5K2OF7ZEzjn0DRis7g
 s9H9MxGmqvFHXvfbOHQ==
X-Proofpoint-GUID: e2Jv6AqE_-xDFAguuFsJ0OaMmfJd7X9r
X-Proofpoint-ORIG-GUID: e2Jv6AqE_-xDFAguuFsJ0OaMmfJd7X9r
X-Authority-Analysis: v=2.4 cv=BvqtB4X5 c=1 sm=1 tr=0 ts=6a0714c8 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=ESjX33bb3rDV4MXBDX0A:9 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-15_03,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 spamscore=0 malwarescore=0 bulkscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605150129
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

Audio PD static process creation assumes that a reserved-memory
region is defined in DT and exposed via cctx->remote_heap.

If reserved-memory is missing or incomplete, the driver may pass
invalid address/size information to the DSP, leading to undefined
behavior or crashes.

Add explicit validation for remote_heap presence and size before
sending the memory to DSP, and fail early if the configuration is
invalid.

Fixes: 0871561055e66 ("misc: fastrpc: Add support for audiopd")
Cc: stable@kernel.org
Signed-off-by: Jianping Li <jianping.li@oss.qualcomm.com>
---
 drivers/misc/fastrpc.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 3c7c3b410d7d..a0337cce77f3 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -1363,6 +1363,12 @@ static int fastrpc_init_create_static_process(struct fastrpc_user *fl,
 	args[1].length = inbuf.namelen;
 	args[1].fd = -1;
 
+	if (!fl->cctx->remote_heap ||
+	    !fl->cctx->remote_heap->dma_addr ||
+	    !fl->cctx->remote_heap->size) {
+		err = -ENOMEM;
+		goto err;
+	}
 	pages[0].addr = fl->cctx->remote_heap->dma_addr;
 	pages[0].size = fl->cctx->remote_heap->size;
 
-- 
2.43.0

