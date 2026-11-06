Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F1E606EE9E
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 13:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=HCtlIrWk;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Mp8Hka0B
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D4A9A112DAA;
	Fri,  6 Nov 2026 13:45:09 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C84E3112D97
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 13:44:51 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A6AP57V2731831
 for <dri-devel@lists.freedesktop.org>; Fri, 6 Nov 2026 13:44:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Xz+HmzsfjxSeunL16Oc/hUW/Ypuwf1Y3ocKpalAiCdQ=; b=HCtlIrWkCwx7OWhM
 nrYCUiRxZaCAK6pjTBsdZwRjOiSvJliD6PnepH6C1lpYDTVgDIbWUGmZWg0bJew6
 wm5qVxLwUbK184Jx+6jm8QOpBoOeGDROD5k3W4E6x9KNdEaUE36nSsgsyRyMBklU
 ejygzOCvkH2Z917JRex4QUWGZHs5LnfE6ebSIni6JH7Mcr4jtzNWA8f6rq3IrxG5
 f4NJ03KtUhM9Nfd0BwW5S4wyXneEVPm2ebTbImrU4SSstTCHeceTmfJeOyNQEFrN
 rdmD+DzLHe+FPpoI2s8RPhBVbvF3HDwu9ZAe8GjM8H7Mn+ogi9LUjkEoGZYaSLEx
 BVQizw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hs3p9b27n-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 06 Nov 2026 13:44:51 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-944138ed63fso108947185a.3
 for <dri-devel@lists.freedesktop.org>; Fri, 06 Nov 2026 05:44:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793972690; x=1794577490;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Xz+HmzsfjxSeunL16Oc/hUW/Ypuwf1Y3ocKpalAiCdQ=;
 b=Mp8Hka0BtiqIDb8c5XPRY5FTDCge10BlVl5LPOAUYDSTrARm+hzkuy39/AaAJ3zPXA
 XxD0EGv4xH1Hd8LNdFWrY9gVFWu3EwatMOmnurGQULqMOwoD5flsUs/XRXLrGVJ8ITEQ
 P81wcno0kUoyN1i0y7y+4LCyzyVPKRvrrawzf7TGL4doqESzf3YXScJvn80N7SmOfPvO
 emApR8aCwKmzHyYzEdvXTJRQrfnj1HsNuflWBxkss70Rbur6XTIBwRK1ZS9bJnqVOt2x
 gRpYJPYzGdahjS5bAdCjUqKN+9P50CBb0UlEzhbFeAx2ZKyquLSXJFfBZZKOG35N2qSS
 3GHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793972690; x=1794577490;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Xz+HmzsfjxSeunL16Oc/hUW/Ypuwf1Y3ocKpalAiCdQ=;
 b=R64siFvg6lmVvBMiHZpTGVVHQo+KopQyvhFyFG11a3wVaXMlhl0iqrx3zRSS1C9Rso
 DnJvXwgZG4CJrnvTYmHVsgaKPYgGZoGuEyjGdeGKAUCmZePQceWV7+UESapym6CzklAs
 NT9iJLu+jHhQ6neKNmOa22Y2QO5AU/BZOzptMNfBLVo+6KHdEVRIAQudqpaWHK2/RQlG
 7uoDSAHi7wP+Jw35D1PXEPOI6ZTWZjiwSDS0hy4iS7GziI0b7XPqG6cWkWqt4HbUnH0o
 5ehasJwEeOi0WuLW1X0hdN4V4XvgRzGGv30csjO+foCWBc8UWMY1xx0L7Miv+PbsHPTM
 q2Rg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzrETn4MQ+aPQEs7neWvTVb0HniJ7kZ/Qyv3yC6JqdTq/IhvbczGdrIOeEuC4BevnSJPb/vWoyJECs=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8RPT0L/wJJgHcx6oQ6z3rpppwvQqZzodXklHxiJMvQiFO0YXex
 RT0PdGD/W51oAYp4PBYaLCyGGpN10Z2PiKcSmBPux/eIbxwQrHa1AL7Rkv7zyZNi+HlqOXTDppY
 H3XiQXOI3mv0NePNwl0m1Ih6C4Qw89aPFODGo//BZntzQ3d2Lj+LMRDTgqkAuzLufOV8fz+o=
X-Gm-Gg: AYBFou20J1UP0x+ltFQ5+C5SitAR/kX6JSm8jUxtqLL2YAk4wjmaYQ7A0h9VzibOd7I
 PHutDJl66gKIb6zeFGJKvSmCIpOzWlsU83BEHhDSTEl65/NYh2CBNfWjVGzlajdME/NS7J0Hbst
 3XVvgx2mDNWDN/RdCs1NrpCBaj6NPL9FrInIiQkP02AKbR47Wfz+SBmmv5AfoS62lgHFcRAo2WP
 OnhRce9Zhb0cxThtlm4ot7T3dJ3uZmnxvVnb9soch7W0sHNIhbIOLcosBlAsXUWcwZjphNqTPuq
 4nu7GVwtcu2enAA+hbTYq6HB+/OU/nvVZe9FeSByLJQZob9rQ0/pJHDwnZS6ivTyJJoRcr+lbPv
 frJlLyKd67OrlULmIKzUuR/3eT4lHVCSl4Rm28OllU+EHEGgXPYLC1dE+QQZFDpzNBCML2swdOK
 72w9wlqRptPbTDvw3CZOYif03fBKfffhGP85VPeeRbNTSFuzEdr5indxdT0oTWtw==
X-Received: by 2002:a05:620a:4804:b0:93a:11a4:223c with SMTP id
 af79cd13be357-945f338ccddmr335874685a.9.1793972690044; 
 Fri, 06 Nov 2026 05:44:50 -0800 (PST)
X-Received: by 2002:a05:620a:4804:b0:93a:11a4:223c with SMTP id
 af79cd13be357-945f338ccddmr335867985a.9.1793972689409; 
 Fri, 06 Nov 2026 05:44:49 -0800 (PST)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5c003055a5csm382747e87.13.2026.11.06.05.44.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 05:44:48 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Fri, 06 Nov 2026 15:44:13 +0200
Subject: [PATCH v2 7/8] media: venus: report the QC10C data stride
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261106-ubwc-format-docs-v2-7-82949f88f030@oss.qualcomm.com>
References: <20261106-ubwc-format-docs-v2-0-82949f88f030@oss.qualcomm.com>
In-Reply-To: <20261106-ubwc-format-docs-v2-0-82949f88f030@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Bryan O'Donoghue <bod@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Jordan Crouse <jordan@cosmicpenguin.net>, linux-media@vger.kernel.org,
 Nicolas Dufresne <nicolas.dufresne@collabora.com>,
 Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
 Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
 Robert Mader <robert.mader@collabora.com>,
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1667;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=ut1xc1q+G9TMsg5s2WqSp3Sx8sHVKqPmNJ33tZpkuAQ=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBq7dm8KmXANae5Tj5iETqw10bNgCF735iCp58sY
 gxJ/9xUgnCJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCau3ZvAAKCRCLPIo+Aiko
 1VFICACKMLr2bozdG6xmGkQOVhrx3vYFq4ngn4q8vUWW1ZxoofkgGAikEKIPPuPSkb525LryrlC
 0XAenVx9i7WZcQtxwFHueXJUwPwuxXEhcIJfJMiPxfzNrmDZC/o3IzQleukID8s8sCwStuVsmbl
 kln32bNC8arP15mSXQ4bjB0Lf2zWr/thF9Hh5DHCJTlYXwAGTaYtA/PPxwzjxHBMsNEWI6CLsE1
 IKZDeh3LZPSlTxSxJdeqdLQG+CESLNB+fjo36WN3j2ndFNqfksBqNIC4GxLw8aLchs06icl9kCQ
 NUZTXEu4RKD/OW4uxQR9qSZcZYbK+DsozSi4aS79slcX/uiY
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: 9B2sJoFs9x9CjQmnR1SjlVQ5aqyP0UdW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA1NCBTYWx0ZWRfX11fYjUvTcLAP
 xm0rE1N70iwJfGcG9WjzLeRmC7fNF5T2Gzux3cUKWJBTB3AfNTA2gcBdOSfZH4iWyK94XM8DbyP
 PTr3Jy4ekkc/3gK7PkMPKGAKWgusCioBgYfmpMZXp48KHLqXdF+zYu4ghbLBsgcePDDOUOIr0xw
 AW1QUN8KygsdgeoD3JUyFLKi/xrn1mi9ZZ+Dm1653F0dyB+cnXp+TCl6OWlwOajxSxkTXs8aZ8C
 SmVYF8X/WbR6HODupdWp4YxsAE5QLF0WMgRaA3oUbpITvV6v8QeoN8l2YUStiAnyKjxINqxbrmT
 fIQ6S+frpj6MTZGWdHee/vycToLxtezOLP1gSQjznDKn9JAl8vCtDStEO7qXlXEWgBrmLK6Qeuw
 gJqBNsCO6E3Nhh8WvQ28wZnIyPdCZzrMIjzfTrHw/n9HVbCJB4S7kuVUHtvNxTagG/Ch0rrhDw7
 Dxjlp65JEGPQWMvH+kg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA1NCBTYWx0ZWRfX6BiiuSIj7IGR
 eZwCzZ4OiIaMqnwWViyf09bBKHNndNcy+l87lyE0q/JTT213UWikPGcPn6aHmGgvGZ1fscOblg2
 bj9Fw98CGM+cXKLu0yROuq9rqoNW7oQ=
X-Authority-Analysis: v=2.4 cv=WMzqzXsR c=1 sm=1 tr=0 ts=6aedd9d3 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=lvl4w2d8MLr2OEpUskUA:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: 9B2sJoFs9x9CjQmnR1SjlVQ5aqyP0UdW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_03,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015 bulkscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611060054
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

For QC10C capture buffers the decoder reports bytesperline as the width
aligned to 128, as for 8-bit formats. QC10C packs three 10-bit samples
in 32 bits and pads each line to 256 bytes per 192 pixels, so the
reported value does not describe the buffer: a 1920 pixel line takes
2560 bytes, not 1920. Userspace passing the frame on to other devices
has to take the stride from bytesperline and gets it wrong.

Report the stride the buffer actually has, as computed for the
buffer size and as Iris already does. The downstream msm_vidc driver
reports VENUS_Y_STRIDE(), which for NV12_BPP10_UBWC is the same
ALIGN(ALIGN(width, 192) * 4 / 3, 256).

Fixes: cef92b14e653 ("media: venus: Add a handling of QC10C compressed format")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/media/platform/qcom/venus/vdec.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/qcom/venus/vdec.c b/drivers/media/platform/qcom/venus/vdec.c
index 6a43ea191da1..9de0c9bc2919 100644
--- a/drivers/media/platform/qcom/venus/vdec.c
+++ b/drivers/media/platform/qcom/venus/vdec.c
@@ -227,7 +227,10 @@ vdec_try_fmt_common(struct venus_inst *inst, struct v4l2_format *f)
 			stride *= 2;
 
 		pfmt[0].sizeimage = szimage;
-		pfmt[0].bytesperline = ALIGN(stride, 128);
+		if (pixmp->pixelformat == V4L2_PIX_FMT_QC10C)
+			pfmt[0].bytesperline = DIV_ROUND_UP(pixmp->width, 192) * 256;
+		else
+			pfmt[0].bytesperline = ALIGN(stride, 128);
 	} else {
 		pfmt[0].sizeimage = clamp_t(u32, pfmt[0].sizeimage, 0, SZ_8M);
 		pfmt[0].sizeimage = max(pfmt[0].sizeimage, szimage);

-- 
2.47.3

