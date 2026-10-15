Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED00CCC6B34
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 09:56:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B0C311228D;
	Thu, 15 Oct 2026 09:56:03 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA477112286
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 09:55:51 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69F9jhu71956076
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 09:55:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 3908TNGS/Fbid8O9aG8W/Z9neo+p4WxNDs4awgMTsZY=; b=NtvpRQRV3zMD1Wnj
 MQ1jNi0+qyrJ4B+5UiyBkgCXckrV7gwDSIQwWtBww4L7c2BXDaHxTStxqY4DuPl6
 QTljd/lpVul9jptk7w/CAjieNNoQNLkY6+qH9bSe8lEjr0Z2yflHiKUAp4xMV1zu
 jJ2Y/V3MTNMFSFesI9dbs7s5rah+iHOqlZ08fybU5ylotR41al3kKzXnn5eLO15y
 KwsLj/nmQTIdTX2p9sRqiZRD5XfYHnmRWsrDY7hSvmhU3TkU3s9GjEWbYldZHZaX
 zM40DC5droPw5uF+2HctocBzADwSRTOaXSOMeSHZQ7pZhIw+hvoTyZsWCYbPQFMP
 CAz/Vg==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hakdet83k-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 09:55:50 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-cc1a439db36so1429592a12.2
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 02:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792058150; x=1792662950;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3908TNGS/Fbid8O9aG8W/Z9neo+p4WxNDs4awgMTsZY=;
 b=Ff3bRApwHkFzACKHpGZmKSeJRRlHLCnMOi8R6oaMvf0GSQf6Uolw2XSoYJC3QePGha
 fJ2CKGrYym+Ep+irVLQgyPqUHBO6TUVespo8dP7sGMOoXKLZhJlYBXPvqxhIduslxHwc
 8Xz+SsEM9TM1GIotRmzrbQHsFF5g2Vu8pWpwHKjv1B5JeVNMTZjbb+TyTazKEIv7NK4t
 2PFU3Aq7kno7G8H10rkzJs0xSrNteuHdUIyRz6dNDtUcNjyOGLsv2v5+1jn5GmeaHp5Y
 iZea5dxQtGjfEEaiPjKfbl4QGoIDtpdtJXzSVmSWhkActB2UwqXdBXR7RMKpmrSXbbbd
 uZSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792058150; x=1792662950;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3908TNGS/Fbid8O9aG8W/Z9neo+p4WxNDs4awgMTsZY=;
 b=boY/N0Prpcgb8LI2WuneWcTT09ypOMDCJ5yFh/i2kIJLXBGbB2rWFzhKNvPyuw4osy
 g/PT6JmeQggq3xy59Hf0t8AqrIR5AHmxnhXV17ZPemKX+VyhcKGNUvdvlnn7GSNPn6J+
 2ukryUYjgFNOs5WrW3q9+F47untX8DuTm5WuLykN8XF0q/R5r0n8bLFI1ORw6DrcKoMw
 Od6aginGh+0NSz7/rcWaUUnOyvvmlFDsUlVKxuRWN4J4w4R+AEFeD8oMghgbFOuCPWpv
 aK7Hk2eTYdWYIdtcyvkvgRoaGjPJQmVsWKIgKegt5PjS5mu1r5FUAp/rDjubahaHrDlt
 3zzA==
X-Forwarded-Encrypted: i=1;
 AKwUvByL7WnWmVtqogg1vl6i35DX+yimjz6UQbLyXJfW7UmG7A6yapQK3Sx3TTKO8prkJNqnusX4RxfeXsc=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKzzxRqE3/znM+6+NHHfNaT8e04kGso2beeF9gA3f8NkJzEMo2A
 ndSIyhbOijEjgLFZ5eKbLuXyRWWga8Rubh7X86eZ46rfXc02QgCRyo6rTkQZC2/9BZhF+fZEAfr
 pCBVRIhs4vHtH8IhI/kRnu4kxSu83akVWLWtVyvWyAkociYyKPrHBQi8cFix6G2OgXQyV6g8=
X-Gm-Gg: AYBFou03XHvKM0evzZR6mFtzCC8TCC9lT5BoewWxudOHAfVD+z/6akM6yYGX2RTg+t0
 s2v+wr3f2XLm2ZNUUvyyyzehlHpQyEph3y9eH+OIIs+1OXUEAFhaeF86JOG3uGYiZNMU5zLRpcE
 T0bPo/9Q2RJCbF99f4GrtXaNrc9/muaG6nIg/v/xMtKQLQgfBFsWResadMRGxT3vTC/4MUqdnij
 b7THAD11bD4mxYrTwAp4Ci0nu7WXQu3mktYqp20ffrFr2Qw9gqDdXudTNTsGnDXO/OokROWP5l+
 0xeL8HKFwR6l5+ZsrwK/DHB0tCjLNxk5/kdV2zPjxprbsDj6MwKoGSizMoig6qosXdX64gyljaf
 H+GYLDhDDMgliK34V65bLyLg8d77bwcRF0M/i
X-Received: by 2002:a17:90b:224e:b0:3ab:1323:1012 with SMTP id
 98e67ed59e1d1-3ab3a32ff26mr15341689a91.1.1792058149948; 
 Thu, 15 Oct 2026 02:55:49 -0700 (PDT)
X-Received: by 2002:a17:90b:224e:b0:3ab:1323:1012 with SMTP id
 98e67ed59e1d1-3ab3a32ff26mr15341678a91.1.1792058149496; 
 Thu, 15 Oct 2026 02:55:49 -0700 (PDT)
Received: from hu-bkalkond-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ac943e1a11sm3612322a91.7.2026.10.15.02.55.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 02:55:49 -0700 (PDT)
From: Balaji Kalkonda <balaji.kalkonda@oss.qualcomm.com>
Date: Thu, 15 Oct 2026 15:24:36 +0530
Subject: [PATCH v2 5/5] arm64: dts: qcom: kaanapali-mtp: Enable DisplayPort
 over USB
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-kaanapali_dp-v2-5-c15cb83d9140@oss.qualcomm.com>
References: <20261015-kaanapali_dp-v2-0-c15cb83d9140@oss.qualcomm.com>
In-Reply-To: <20261015-kaanapali_dp-v2-0-c15cb83d9140@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Kuogee Hsieh <quic_khsieh@quicinc.com>,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
 Yuanjie Yang <yuanjie.yang@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
 Mahadevan P <mahadevan.p@oss.qualcomm.com>,
 Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Balaji Kalkonda <balaji.kalkonda@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792058098; l=773;
 i=balaji.kalkonda@oss.qualcomm.com; s=20261001; h=from:subject:message-id;
 bh=nYlBV17a7zQ2gNkqaJ9HZTgoGYakOVEI5vUxNQl7BmU=;
 b=xKwEhtw640KnplPAh4JHoBl6zznJSNbgZXyWUctSaqIaqoH9diG5TctCAoJ5z1lqXBRcUdnNX
 Y8jduOCXNW5C0/vvpyERB+FJbM/hk0rWkKAxEZ+k+NfL9kUrfac8DKR
X-Developer-Key: i=balaji.kalkonda@oss.qualcomm.com; a=ed25519;
 pk=U+unGox551qPLS2mzIlN+b5cHksxTMGPnDwePd6KEnI=
X-Authority-Analysis: v=2.4 cv=OdENnRTY c=1 sm=1 tr=0 ts=6ad0a326 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=5UEAqLcyi3SyoXtcnFMA:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-ORIG-GUID: 7OdhoL93-yzWnRXC_xgBh_i9vnu3T6Ks
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDAzOSBTYWx0ZWRfX2Fsvsm4Wa21q
 3Z/77Vv56lmRZer/oQVhMWpWtYtrX3W3LyNAJWLVCfxIX4QKy5qKacC+uxQ5JUn0ZsxUfSgtxvX
 CupmYfEReTm/YA/1+obZqZfATSv0DRAr8As+soFpWbygbKhCwH5vzC1tiHBw3bsQuYcvlVuudVk
 JYwhc1+fi+LhYfa2iUAy0LrVzhqdD1+hNcm332T1JnVg/fv7Az1s9WDF/GlSOsjrsN290SMbXwU
 0tIlB24L2+JcvE4GdkAAlXekXhhcvPzaKRVK14upCNyS/kSOWdIcthU46IRS6R+lTHdiStm9W9/
 TVGJ5QBUV8c+bz6mta4jugZeumFf07Efje4XQyTS20gm1rLYp8Fm2iYvWUS5Jpf5IGxpz1wAKM7
 RUduZqW4Fq5ikwHl5uqxhesum7TBk4QLtFVE32f01I46C+ynD3SSzPph+eQU0sN8yoQCEWg26SV
 YFGE++VAMB6ZOLMhN/Q==
X-Proofpoint-GUID: 7OdhoL93-yzWnRXC_xgBh_i9vnu3T6Ks
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDAzOSBTYWx0ZWRfX9oK/PwTD5Nmp
 Jmvr5FG6uKZJK/emjR4Eyt1I1eywg5wP0TkO0UL5KGT6dUBSjlw7qjqtwEUJabNiBp6whJBMHJo
 Y/CuLpSJolA6LmNlKlP+e+3qj85UV3w=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 impostorscore=0 phishscore=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 adultscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610150039
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

Hook up DisplayPort parts over Type-C USB on MTP.

Signed-off-by: Balaji Kalkonda <balaji.kalkonda@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/kaanapali-mtp.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/kaanapali-mtp.dts b/arch/arm64/boot/dts/qcom/kaanapali-mtp.dts
index 22eeacd7aecd..3bf7baa2bc82 100644
--- a/arch/arm64/boot/dts/qcom/kaanapali-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/kaanapali-mtp.dts
@@ -1017,6 +1017,14 @@ &mdss_dsi0_phy {
 	status = "okay";
 };
 
+&mdss_dp0 {
+	status = "okay";
+};
+
+&mdss_dp0_out {
+	link-frequencies = /bits/ 64 <1620000000 2700000000 5400000000 8100000000>;
+};
+
 &pcie0 {
 	pinctrl-0 = <&pcie0_default_state>;
 	pinctrl-names = "default";

-- 
2.34.1

