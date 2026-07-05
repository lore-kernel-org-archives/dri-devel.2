Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C784C43458
	for <dri-devel@archiver.kernel.org>; Sun,  5 Jul 2026 19:41:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 10F5E10E4B2;
	Sun,  5 Jul 2026 19:41:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ct1DBvNs";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="K/Adr3Q5";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E93BA10E4AC
 for <dri-devel@lists.freedesktop.org>; Sun,  5 Jul 2026 19:41:12 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 665HhcN52189487
 for <dri-devel@lists.freedesktop.org>; Sun, 5 Jul 2026 19:41:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=SRfBxbqW9Wo
 vwhSYimxYWcInLCKkOQsnOkiyjjR+6kI=; b=Ct1DBvNsXtjXHhkOELxVhlpg6H2
 368Ld+75DkSj9KAbDdr+dccgJj5ELmVwXoWTwLRHuHRoMLG38NZA0i/dYf4N1Wwc
 GWDVGhaX3gkzJ/KUCjenkhf61SCvn7auxPGY1ifqGqoeJGMpHLM7TwdqAnd1zKxe
 XDmUTqO6867KN13WAC/hp1ycv49MufxZfENMTnh8m78LYIQT7d23L1S4XHIN449b
 smnhxYrxjaGQqsh6wd2AOVf/dnd9Fv/6+cSQqRdhbmEolxNJN1SJpi8Ey2Pa0lIw
 zunl7f6VOFaCAF/wwQuLKChNn1SjxkzDZMRnVULom/ITViFNtbylQf31vYA==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6uf83593-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 05 Jul 2026 19:41:12 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-c894c1c4aa9so3254670a12.0
 for <dri-devel@lists.freedesktop.org>; Sun, 05 Jul 2026 12:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783280472; x=1783885272;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SRfBxbqW9WovwhSYimxYWcInLCKkOQsnOkiyjjR+6kI=;
 b=K/Adr3Q5vmV7jxHupSzJmQjpnCYv0TqY0nVrLXiGa3Kbntdy95uUi6oHbzkz0veulw
 s3xhdRsSo08izG4A+niNiSnT16h8bHBe1Q6qDhMPQRYonnD7lOzoyn+hoNeL6gREdsFu
 iKOatY0Vgb1LkBr87Jjb+JteS2qTv1WC/KMrRJmE0H+t7FTK3xCuTLznuaGk/4jq52Ga
 zcQjn2HHkljD2Kgp47oE54Z9eHkTnEe4le6inKaH70xW8tQrDWIf/1EVvF2P3a3WOPoP
 FPIE6NkO+WHmnwCqyUSwYPUhTJ1lS16r8q9iN6xfo/AgyYXpESMZ8Mm1aXNODwP9k/Gz
 3fXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783280472; x=1783885272;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SRfBxbqW9WovwhSYimxYWcInLCKkOQsnOkiyjjR+6kI=;
 b=gqk8v5GpgOeojel1ROZJIxqF2CrvxTjfg2b66OLJHvp2MM4L1XvRYE9AB45rlriZCY
 VChY8+tFVGEt1jeM/OjEXIz1oYoSvEylX9pQ00e7oQRns5WoABMhQ+A7WUSRj8Ekoaob
 3u63959K132BuMZDkEBpnoWoFjTojJLdm1GdqYjKbfoKFaxi1/CUJn2lRJTD5gfSsDz1
 s/xTKnFe24ZPBcfeAyaPEE5tohxaYQf4fHFApoL+QfgoAANKiy9JMtSNPVWR8VWGSf8g
 ivPD+/hjzCEsKc0meWPKr+/WE/Sli4uZUeOzHqd7aE6rvVsm8Hf2ZfnByApwO0ps4JFH
 uhNQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqOm8HQb//pKc2WkQUgtKh9dlIn44f565favf8gxw6IwaDoaHTIKFBK6R30L7dPwJVdVd7wXY5AicQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz44Ihb+g5RVKnAacXr3pEpChG6SGhXWlZ5FdmflkDh0U2An0TJ
 +YvDAeTt/qvqscWhkJmEzliNG0C8rlB3r1q3xOGE5A09nETQbDzdesWx/n0VfbftkAzQNHR+HHB
 Re1lC2Xxhe+onVGN+I2jazFdMpeGUkhgbMm+Di/zqBfuvtUWBmHWZEwCzWw2ASC3a5Camoc4=
X-Gm-Gg: AfdE7clvlHAYR5TDUc7EZhZCcvfTdqfxq2dc9GwP9PpgiuO1SKHIT1cdQ586IRuzLCM
 dw8kXj1MdF9uW3mxqvXHHRf5ZXP4/8FmTWIjMZRtqps8l3cig1ZsJtqpWha5ixXj/xfOUIMIdwo
 MtPRKqeKsCoCQpPu1V0Jv0PR+jE0igHUYuqlUY8kCZ27sWf88igH7Aq5ZfmN4FYy0a/fF7dkt5S
 kKu33GJvj9CHS/wm2AHxabIkEXhubOtW9rGPKX87SQxHA6vXTWU6VvHjoxx3n/1R4GQFQ8f0d+U
 NCWLfAMJml9RRTzG6nDBq4BLE4DFT1nGFT3EDkBP2JpjX/q8ocbFkpiO/96XaX2DBxA/5W7Z5pN
 xpH5b7tDcT4ArG0JDJsrFnT8O8qxUVE5Zi9k7SA==
X-Received: by 2002:a05:6a21:6f14:b0:3b4:8cc7:c6fa with SMTP id
 adf61e73a8af0-3c03e189935mr7605438637.10.1783280471646; 
 Sun, 05 Jul 2026 12:41:11 -0700 (PDT)
X-Received: by 2002:a05:6a21:6f14:b0:3b4:8cc7:c6fa with SMTP id
 adf61e73a8af0-3c03e189935mr7605425637.10.1783280471121; 
 Sun, 05 Jul 2026 12:41:11 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b3c7fa566sm40573417c88.4.2026.07.05.12.41.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Jul 2026 12:41:10 -0700 (PDT)
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-arm-msm@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 linux-mediatek@lists.infradead.org, linux-mmc@vger.kernel.org,
 linux-remoteproc@vger.kernel.org, linux-sound@vger.kernel.org,
 linux-staging@lists.linux.dev, linux-sunxi@lists.linux.dev,
 linux-tegra@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 openbmc@lists.ozlabs.org, sound-open-firmware@alsa-project.org
Cc: Konrad Dybcio <konradybcio@kernel.org>,
 Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Subject: [PATCH 39/42] ASoC: SOF: mediatek: mt8195: Use
 devm_of_reserved_mem_device_init()
Date: Mon,  6 Jul 2026 01:10:15 +0530
Message-ID: <20260705194019.2565498-7-mukesh.ojha@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260703193855.110619-1-mukesh.ojha@oss.qualcomm.com>
References: <20260703193855.110619-1-mukesh.ojha@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: _6B7RTWujvedAUC8WgplC18Ndor3bKUZ
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA1MDIxMiBTYWx0ZWRfX4XJHiguRkI/z
 j9IF9FIL+mRbQByu9SOmxqNjeLgdfgnCCcyghZX7r3xEHG5yAxm3PpVp6KK9VeuGJLhh4SVrJi8
 sT0oWgWer6A770d2e0hDS5Yg0uZzn2s=
X-Authority-Analysis: v=2.4 cv=Z4Tc2nRA c=1 sm=1 tr=0 ts=6a4ab358 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=YxFYfaw6DuWYmsw8bRUA:9 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-GUID: _6B7RTWujvedAUC8WgplC18Ndor3bKUZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA1MDIxMiBTYWx0ZWRfX550pcTDIBLEX
 LDlys/AfNhOaAS7XdN1Iv0wAOU+73R0OeFm9lJQk9QhAe6+Bu11gUwuSH8SAWTHLUVMsHAT8PzV
 7B5NH2kYKhRLP1u39146V5zl7wVlWtVrHEgV1ap9hrfnp7erHVNso/+hgxKOoK1HiyOOiF8u368
 pHlklRo6KWAepGimmy4rWcd2NKtjba8JpB3qWrdsqZygl+BqleDkpIT73Xhof692Yyficdv/SjT
 IX60RY6ThGwy20iUgiem8kg+cyheAnC2Fb6c2I4aNq0pVPNF/vdofpZbxxkFz59WwbTkQbzW82k
 e+QVNIRtcj5XRWbp4G2ejkr9xUnYwIutgMlroXe0OlJB2eMAbNKL1QA8L6ShX7t4iG4jzU/aHUT
 6iRyX9oHDnOi3KUK/vgp1A+RxFyy3ORE+dUZiX0HRxIpWE1IyBkR0b8vQ0nQQ0mLp6XI987B8M2
 sb1rMFBXG75wjECsQwg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-05_01,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 spamscore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 phishscore=0 impostorscore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607050212
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

Use the devres-managed devm_of_reserved_mem_device_init() to ensure
the reserved memory region is released on device removal, fixing a
missing cleanup in the original code.

Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
 sound/soc/sof/mediatek/mt8195/mt8195.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sof/mediatek/mt8195/mt8195.c b/sound/soc/sof/mediatek/mt8195/mt8195.c
index 4d6e9300a9c0..e4b6b6c18e02 100644
--- a/sound/soc/sof/mediatek/mt8195/mt8195.c
+++ b/sound/soc/sof/mediatek/mt8195/mt8195.c
@@ -49,7 +49,7 @@ static int platform_parse_resource(struct platform_device *pdev, void *data)
 	struct mtk_adsp_chip_info *adsp = data;
 	int ret;
 
-	ret = of_reserved_mem_device_init(dev);
+	ret = devm_of_reserved_mem_device_init(dev);
 	if (ret) {
 		dev_err(dev, "of_reserved_mem_device_init failed\n");
 		return ret;
-- 
2.53.0

