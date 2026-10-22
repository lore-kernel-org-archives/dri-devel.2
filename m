Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E185D606A319
	for <dri-devel@archiver.kernel.org>; Thu, 22 Oct 2026 09:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=HTT41qsh;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=WcSd3qNW
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 40EE4112478;
	Thu, 22 Oct 2026 09:50:59 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 89640112482
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 09:50:48 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69M8p0JE3271389
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 09:50:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 jIyl06xvEjbmEgUN6wCq6Gvrcm2kmVA6lr/5VlMLNgI=; b=HTT41qshpAamlNKp
 XkhAwr/7w2gIL+xH6mvR0Lv3CPG9e8dadkJfJTj69HK1GTHzuNPyxu2xUoWlSSfZ
 Aer1ZhsCH7GsK0iQ5FDa9iZhjVIgBjmz925qrTZOKREBiPrdw9O/ZPLd0Zv3uyG8
 eB5+lrJ9VepwQPapibS4LvoJjVHpy0P+Up3mPrkd4mkw3STfJlv8XNDt5z88qqdV
 nzeJ8Q7KSnYkrQl3Emuulhb4scTyy6wXMy+dfeycRqtP3vF1Wi2njdLwaSd9Z9pA
 O8ta8o+UcUQE3ZYsrr1QGUqcZvVjc4vkRnjYntl79M2cCgKQgJNolB5QWJy58JW7
 3WfCaQ==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hf93asquf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 09:50:47 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-30bcb065bfdso2769854eec.0
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 02:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792662646; x=1793267446;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jIyl06xvEjbmEgUN6wCq6Gvrcm2kmVA6lr/5VlMLNgI=;
 b=WcSd3qNWhDfyqU75TcpnYKx1VEuvCqtv1g+s3TjSJ3Z2v0jB2v2XglBeufvxUFKM5j
 dgNONULsXPJgdFbG0aaS647E7QXYwsRyneLaqXv5ufx5kpkJunceIC8E2vKKvt7MBL0I
 3EaPSM1En0EDuJsYNtameyh1cw6FrV6/vKZ8wtkMwLbwj3aScy05Ng88Or+OZhU4R7MM
 3WxKw6htsTIoeal2cx1hnMH9ninehYLKvNquNOAQOLqc3LOudBlBYA/DISq9aFYjflN8
 XYCjWPIIXhsFymtdyGmx7bxq3VFnQxxedxu1u09DG1Ah3wtclE3C/k6bmv/y44cFtVEk
 B0HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792662646; x=1793267446;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=jIyl06xvEjbmEgUN6wCq6Gvrcm2kmVA6lr/5VlMLNgI=;
 b=rAJpSDhj7KkBTbweKEJFElWfZtdrQYE8eJmeyQnrZjPZGrZgm/Y38OWsSrhl0hr6EO
 ZgdMLR8mOaEcQ8vTJII76yQNCa0cINAddpOZAP28e46o7Yl2V42QWZHun1YCrjSd69H/
 2dmXNSdAL+3i1fw/gZ1xcxHcFSkXrMqKvH6sxXD2scPyGWy/xtyQ7vxQAE0XGZq+O4kk
 JUe6OyRtdj6XnSGMDZA3BRxXfh4sXtN57+W0r9kbhFBHyxARmTd+0ll6f95MHzWOqOE0
 J0zxX9rOWzhqypPS7NX6djvEUuhHvXsmeCeI7zC3GFoLY6RhCHihIMNyio6wNRjTqroK
 ejQw==
X-Forwarded-Encrypted: i=1;
 AKwUvBz1Tp5NA92Zxj4dM03ReItu0RW6JyuM+r6tm9rtsK50XH1RcS+6fvsvDUIsM+huTpSOQgoeXbyCqIg=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJhG93YCUeN+mwtVDGkWJR7R9sBX9C2PVAq9YC+Iyo1k7g2ys0o
 tZJ98Vllso4SKNBSnsIkfs+pk9rlcl5OKJjnF3NhD5mEb+d1EMtqwJmuHQI0pwrFVTNBxewFx5F
 uopNo5MY3R4rQx8PAuo4LkR+HU79C+ZBhZE1yBAdTDDRngrmsryV7uqRWSaGwCGcJ2M9La3g=
X-Gm-Gg: AYBFou0st2kijmHoT+beXGfp4W2Cc79j8VAO+efzeJ755PsGOivc7F7WpdFk9ier8i9
 jWInL6nNbvoBJ9rn25nLyPhVSEAyM5F4FPdAzOC4ZkiE21DCp0F6jZNUAYD9wUCqw7TB+lFRRtt
 VgHSXg6I9LSY1nswAF5/Eb0dvo8/0Fn8VnwZH/tv5xewT5k4cbJANPnzNQNJXaPb2I0cUIo3jO8
 4//s0SnyW9Zk8Y+Gh5EZbfxQAcEkFW7HMBEwRG3Tsar+jKxeiqf9b7FckI8J2h4qiXMsPLf/6Sx
 xluv2+HZYI4Jwsqm/vwsXr1XobCpYDVWuKnCfZymvaxajM4md63awVl3cG1tq3St/CFvSly4NdV
 OrjndIIAg5Bm66EFlHCriyoYl7/Y7UmQGnIo=
X-Received: by 2002:a05:7300:ce09:b0:360:b8b4:840a with SMTP id
 5a478bee46e88-3674f11d98amr6099368eec.39.1792662646485; 
 Thu, 22 Oct 2026 02:50:46 -0700 (PDT)
X-Received: by 2002:a05:7300:ce09:b0:360:b8b4:840a with SMTP id
 5a478bee46e88-3674f11d98amr6099342eec.39.1792662645949; 
 Thu, 22 Oct 2026 02:50:45 -0700 (PDT)
Received: from hu-bkalkond-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-367417a2fadsm14418035eec.21.2026.10.22.02.50.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 02:50:45 -0700 (PDT)
From: Balaji Kalkonda <balaji.kalkonda@oss.qualcomm.com>
Date: Thu, 22 Oct 2026 15:19:46 +0530
Subject: [PATCH v3 5/5] arm64: dts: qcom: kaanapali-mtp: Enable DisplayPort
 over USB
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261022-kaanapali_dp-v3-5-b5ae8e6083c3@oss.qualcomm.com>
References: <20261022-kaanapali_dp-v3-0-b5ae8e6083c3@oss.qualcomm.com>
In-Reply-To: <20261022-kaanapali_dp-v3-0-b5ae8e6083c3@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792662591; l=751;
 i=balaji.kalkonda@oss.qualcomm.com; s=20261001; h=from:subject:message-id;
 bh=Tc936ZVNQW6mLGok/m6D1h1BrwXL3txIdA0BfJ6MmDE=;
 b=1GX4UVZNZHB9/gF9/n5KSTlC09POzm0NxrliBtqGTowzVdhcXY/VFZU0aheyhoGUqqeHZyzda
 a+/S5i3EghQBBHopSjP5F3CPKPw0q1SJq0X34AvkUNV9NbMsgxJSAyn
X-Developer-Key: i=balaji.kalkonda@oss.qualcomm.com; a=ed25519;
 pk=U+unGox551qPLS2mzIlN+b5cHksxTMGPnDwePd6KEnI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDAzOSBTYWx0ZWRfX9fYMfvoxiiTc
 pNxJ9iZhlwF+giKPoT/vUFADrRIctKmVieEh+oBSlT7Ueumzp+3syXsyMdkxbibn3qUDLDjwJDD
 hqd1CyEaJP1at6D2bEdhgORDKAnKyB7IZ/N3gnBfLXtNrzNW1BfiYbu5PSmFHcSVBLwXCLuUZPq
 sBnNUI7vc1lGX009DYTGvVoZ4CEfm8PWKNOtPPk0jusdnTJaJmAIZbZRzNBkjd06RcR1OWDcqwJ
 YxpngAcH4bU15BMF6PUrIrzV5Fg6m+8JIupukfiZ2rJ+ZGeXCoZ/GIOGG+hWYoRdNR5WUTlcd+x
 GT/0a8pO7DJP/kqSnA1ysO0EgOq6jFVkERDROR+tnvfAEDhpCXerCXrL4OvPeV9iyzc4aH6emui
 9t++nhsaBXLNs+2toTbX+p1o2cFyPfUjVaD2Tbn1TXmYH6GklVBYRaN3KCfl40r20B3B03XfCop
 J3yjje6YcPVmEKmRZrA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDAzOSBTYWx0ZWRfX8uT0Hyyi8OEX
 ktNPmGDw+S2QyK68Y06f7ie2AHl5bfsM8XC4qO5ZCBVXHZApWBfVxog3g3pcTeVPk8E3PgLRyhx
 3avgB9Vlqi2HBYUnCakWchaeiMf1v9c=
X-Authority-Analysis: v=2.4 cv=QPn91QLL c=1 sm=1 tr=0 ts=6ad9dc77 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=5UEAqLcyi3SyoXtcnFMA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-GUID: NstijefuMWKu-eQzX4VVl-Jjxwl29aMh
X-Proofpoint-ORIG-GUID: NstijefuMWKu-eQzX4VVl-Jjxwl29aMh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1015 bulkscore=0 impostorscore=0
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610220039
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

Hook up DisplayPort parts over Type-C USB on MTP.

Signed-off-by: Balaji Kalkonda <balaji.kalkonda@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/kaanapali-mtp.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/kaanapali-mtp.dts b/arch/arm64/boot/dts/qcom/kaanapali-mtp.dts
index 22eeacd7aecd..bcfd9e942eaa 100644
--- a/arch/arm64/boot/dts/qcom/kaanapali-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/kaanapali-mtp.dts
@@ -976,6 +976,14 @@ &mdss {
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
 &mdss_dsi0 {
 	vdda-supply = <&vreg_l1d_1p2>;
 	status = "okay";

-- 
2.34.1

