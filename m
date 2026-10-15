Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03D21CC6B33
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 09:56:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 278B411226E;
	Thu, 15 Oct 2026 09:55:54 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C307A11226E
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 09:55:42 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69F9kHGJ1507292
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 09:55:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 9ehR7tMmYRyLJIX3GU7vP2bshuwvUW0eepQwQOphNmY=; b=JKnjTZAa72F9yD+Q
 PBNqdAJPY/1uCm9y1ZPblv3ifvnV/GBPrvHdRbeA5Wnz/XT+BoOy9s6CKfZzC3jD
 agAeSgqUmqqkTuRBym6m71iP+rHjbUirc8v2iS9fxmWdyPQT5NX/heyTE9wMscv0
 522XFks68mKCQFBP04VPk3P5Hy+5lOdDyKFMFKEyeVj5XgoAWTSkwV8hK+XNDYW1
 d7MmBEmKQsr+6ae8DzpuEumZoeoe7kWtdYpfdC5CcJ7SUcV41bt0cXW7OjeDk1nU
 GVEHSDHgCrGnxa/1frIAeA0SAiLdL2Yx+uPKkFDkL+JoVMyQ5t2yXPKLcgOHtkGT
 VuIgeA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hadd7bpe2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 09:55:42 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-3abb4c24125so4588615a91.3
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 02:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792058142; x=1792662942;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9ehR7tMmYRyLJIX3GU7vP2bshuwvUW0eepQwQOphNmY=;
 b=LdsjS9kIJ8vR4d7i/9873Jvu41gaJXAUeXMqQmdlWFXeWGfzokxOq3DhLTOrpTHJ3H
 VGofvYyT3TmDvKDqZqK8KtvCdkgfXFP34lZ2ADU2wpK4d47PcWn55YiAQ2CF1otL6Iao
 gt8m+BmftZwlWNQokxd9CRxlVbS5BFgqs/47SHed+Tiz56KcDjPTRhayIOxNZ2u0anMD
 RPEZRntgkC16OgsaZ5mFnxxnxrB+Y5SIgL66bqz5+inhcpmQe2mV9xdnNtnOMcBpVXYI
 qpKEW5mVRv8xUZXes9MMXQm2NqYmPUFyRtxBQNtcD6vkUtULzadi9oWYSwIUQOVJhJGh
 1vvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792058142; x=1792662942;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=9ehR7tMmYRyLJIX3GU7vP2bshuwvUW0eepQwQOphNmY=;
 b=QN3bCprDM4s26TYKCMrrzXIVURjI9HNJ8ehx1+Om5EQ+K+yNGNslyEqVyn54a78w+Q
 ZD9r8gvMVPN2m6sTkJr5MSM/YUF7VPEys9B/B7EjGVL6bVPeqq/Ch5KXX/XkCI8Izayy
 VX7/WHGO0ucxI12sDNGPZOdsuHa9KJCTRCNYxJSorwaZ5mID7L3cM5+x3Fg7ZfFLf7aw
 kDDFVf7DHdjkjvyZzJ/Uq24MNrHCvk57HMSsXtD4AvSwhsimRel3+i8kRviYXXMmlcuf
 QszzK/YJEnFfZZ1UxoX1Ws0CGvsYxMwOZFwqu7TxhDSg7evNJfpimknPGMqiM6bu9VZ6
 UIYw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwT4c1FlovLZd3udHmlmpAX3XzYF05R3r1x1UtFXaRPHh7VkoJd+HJntb+0CR+ypP7Onj1rXzQZ1kA=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKFkhR35bKnFO8UGlunV8sjDuurbgy9kVmJ/OOEMoGNBpCCVOUs
 Aqngzvy0/bYVIU/OCBG6xbJ1f5MeDjV0Ru8YVmm2rNtBK0/GZLPnoqYt0k+TTd5oaVdZPB31KQQ
 9GEjG8USzKUzM6FK7E9ipz/DhmMheB8h6S11h/VFT4Ra4MF2UlOXWSNk08z/8w2OJRI8Wi/k=
X-Gm-Gg: AYBFou33qCl36d9KYCkC4q6JYodIdbMdX4FrwySq1i5IkdaTR5vhLCqz3TwVmOEYa5g
 4kw9xvF/xsbfeuBzAcO51C5kRohsQcbSJWBNydRUtRC5lKqy5CszVKZZ/cy1+RKHPa7Du5UgrmY
 2dz4c8YROTYUaX6Cl14YxppnfHnQ7XjKOxlZKUYmZ059UCu/mZAyANONEgGoFy/Ly+XuiqtAXoD
 cniYNc8CdZu9mnfYPk5HgOLTWl9xcG9b9zKFtuz9DFTiHOg70uCOMw4vdXciONAQsF6MLSNTnCF
 ObGwZbm4aLsaSTPDwAVRXBe6wnkTd+H8J3hKXQLS9mTtuQvMJ96GWqrS9hEydpL9p8cW7vJvcSM
 VSXZTxeZySdrqOm0+mpC7G6PVd6C0Bdf3lJnZ
X-Received: by 2002:a17:90b:28c8:b0:3a7:a463:54bf with SMTP id
 98e67ed59e1d1-3ab3a99825cmr13431553a91.33.1792058141566; 
 Thu, 15 Oct 2026 02:55:41 -0700 (PDT)
X-Received: by 2002:a17:90b:28c8:b0:3a7:a463:54bf with SMTP id
 98e67ed59e1d1-3ab3a99825cmr13431524a91.33.1792058141021; 
 Thu, 15 Oct 2026 02:55:41 -0700 (PDT)
Received: from hu-bkalkond-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ac943e1a11sm3612322a91.7.2026.10.15.02.55.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 02:55:40 -0700 (PDT)
From: Balaji Kalkonda <balaji.kalkonda@oss.qualcomm.com>
Date: Thu, 15 Oct 2026 15:24:35 +0530
Subject: [PATCH v2 4/5] arm64: dts: qcom: kaanapali-mtp: Enable USB headset
 and Type-C accessory mode
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-kaanapali_dp-v2-4-c15cb83d9140@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792058098; l=2296;
 i=balaji.kalkonda@oss.qualcomm.com; s=20261001; h=from:subject:message-id;
 bh=WzodycgshZu1zmZaPE3luzfQaJD3tQB9g+hnXzzcEI8=;
 b=1aBWgmRf56b24dRFRqn4zodUhP6YjCr24OIDB+tfrz/IP/pbv5gM9xAnc9HodhxjfmBVjfd+k
 eRkjx6CNOojDmMNh1YOCmbddH9FYVHUFj1c3PhUlzb4QI/mblPo8LEQ
X-Developer-Key: i=balaji.kalkonda@oss.qualcomm.com; a=ed25519;
 pk=U+unGox551qPLS2mzIlN+b5cHksxTMGPnDwePd6KEnI=
X-Authority-Analysis: v=2.4 cv=BaVNQbt2 c=1 sm=1 tr=0 ts=6ad0a31e cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=XqinFhvkQ7oosSToCroA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-GUID: XJic6jYGAbVOnECKcfqsLa7AXut0qjoL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDAzOSBTYWx0ZWRfX8c2vRbHEyutt
 wbVFuILcb8XnLnJkKPpNCqhxAvoPeijSvt3+4QZm++wh/TjMbxPIFEqI2BAgYxFtmlyG1BEl2Px
 P3uOIGxSYzyon4bd79maNZU5OnRgs0IgO027AdWBCdWp6PZBsFSKlhswQIqWaLWVimujvfOSg4h
 2kC0ARLaiQFEHTJn5coIYqrGfoHGealJ0fjA9pYHaIBxM+a7pQx5xOc+elBX5IVgWPcvq9VB7LO
 z5tUuwpDSZkksxM/PYUVlldPPEKEJ7HIkYu1sfHtULBFgvorkNGnFCcmVy4rJ/ydL0g8GPsGqVh
 iXMRPEuTdh2xgsa4Wmalu/mKe2KW6yQAMa3oBwXQAku7aLubjDLbOHXJtxxNiF3ZIXiZ50of67g
 FwHIpID2pW1e0ErkPenCruONpxHs0mCWyNw2wiQx8BgCLqIKzvbjQ+iy1wIk6YNjx0HJvqW2fLb
 2/ZVSEzG18ES2d36XEw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDAzOSBTYWx0ZWRfX4CFTJhXejIUn
 9hkIWl1tTmLhMFM+mzp3sCS+ofR0Lns2+AK3bXBlLCEF02ggAxWhadbVBQNRyeaTOJTYz5YOEGZ
 7HvF/FsNA9RccYCSoDZ6jZpHEGxlhtA=
X-Proofpoint-ORIG-GUID: XJic6jYGAbVOnECKcfqsLa7AXut0qjoL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 impostorscore=0 malwarescore=0 adultscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
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

MTP does not have audio jack connected and relies on USB mux (WCD9395).
Add necessary nodes for proper audio headset support along with USB
Type-C accessory mode and orientation.

Set the I2C bus clock frequency to 100 kHz for the WCD9395 USBSS mux.

Signed-off-by: Balaji Kalkonda <balaji.kalkonda@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/kaanapali-mtp.dts | 53 ++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/kaanapali-mtp.dts b/arch/arm64/boot/dts/qcom/kaanapali-mtp.dts
index 9eb02fd09dab..22eeacd7aecd 100644
--- a/arch/arm64/boot/dts/qcom/kaanapali-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/kaanapali-mtp.dts
@@ -200,6 +200,7 @@ port@2 {
 					reg = <2>;
 
 					pmic_glink_sbu: endpoint {
+						remote-endpoint = <&wcd_usbss_sbu_mux>;
 					};
 				};
 			};
@@ -232,6 +233,15 @@ wcd939x: audio-codec {
 		vdd-px-supply = <&vreg_l1g_1p2>;
 
 		#sound-dai-cells = <1>;
+
+		mode-switch;
+		orientation-switch;
+
+		port {
+			wcd_codec_headset_in: endpoint {
+				remote-endpoint = <&wcd_usbss_headset_out>;
+			};
+		};
 	};
 
 	wcn7850-pmu {
@@ -916,6 +926,44 @@ &gpu_zap_shader {
 	firmware-name = "qcom/kaanapali/gen80200_zap.mbn";
 };
 
+&i2c3 {
+	clock-frequency = <100000>;
+
+	status = "okay";
+
+	wcd_usbss: typec-mux@e {
+		compatible = "qcom,wcd9395-usbss", "qcom,wcd9390-usbss";
+		reg = <0xe>;
+
+		vdd-supply = <&vreg_l15b_1p8>;
+		reset-gpios = <&tlmm 162 GPIO_ACTIVE_HIGH>;
+
+		mode-switch;
+		orientation-switch;
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+
+				wcd_usbss_sbu_mux: endpoint {
+					remote-endpoint = <&pmic_glink_sbu>;
+				};
+			};
+
+			port@1 {
+				reg = <1>;
+
+				wcd_usbss_headset_out: endpoint {
+					remote-endpoint = <&wcd_codec_headset_in>;
+				};
+			};
+		};
+	};
+};
+
 &lpass_vamacro {
 	pinctrl-0 = <&dmic01_default>, <&dmic23_default>;
 	pinctrl-names = "default";
@@ -1113,6 +1161,11 @@ &pon_resin {
 	status = "okay";
 };
 
+&qup_i2c3_data_clk {
+	/* Use internal I2C pull-up */
+	bias-pull-up = <2200>;
+};
+
 &remoteproc_adsp {
 	firmware-name = "qcom/kaanapali/adsp.mbn",
 			"qcom/kaanapali/adsp_dtb.mbn";

-- 
2.34.1

