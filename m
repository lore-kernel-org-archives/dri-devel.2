Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DF6BCD6E57
	for <dri-devel@archiver.kernel.org>; Tue,  2 Jun 2026 06:51:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7BC8111386A;
	Tue,  2 Jun 2026 06:51:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Uz1ELxjZ";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KDtxsfcZ";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8347F11386B
 for <dri-devel@lists.freedesktop.org>; Tue,  2 Jun 2026 06:51:35 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 652452kU1937322
 for <dri-devel@lists.freedesktop.org>; Tue, 2 Jun 2026 06:51:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=GsTAm6yVAc9OEQ2D1Uqg1M
 9QdUAqEiPVaCqDuP9TshA=; b=Uz1ELxjZqczXD17wRd0wF56noCBTlv415ORYjG
 z2TZ9AxdfTddn91doK/LvPM6MrYhYhU+xEpqz3kXsYjqyVkW/9Y1HL4ZYOf08/Fg
 9yNPU3AHBxYC05yehFB9AecU9pN4s+hlFvGrGGmYBAHFjem+2PdpCTX12yOaNT+2
 BK+qT77mvPHPJrTNMRn5TgsYtrS6l3FCPeoVSF3LcyDOjR+rVdXwqRxYP4Tr+pKX
 an6Vf//qREggOn96B86ROKOdjgMhuOHlybExcv4QPS95rJRpxx2rInq7g6AS0NPH
 y2/rlT4ZrZYIM0tIYzEAQNegiKBMlJBNzVpUSKsgNnCSVnFw==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ehqubgk6c-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 02 Jun 2026 06:51:34 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-36b982ec27aso3803254a91.1
 for <dri-devel@lists.freedesktop.org>; Mon, 01 Jun 2026 23:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780383093; x=1780987893;
 darn=lists.freedesktop.org; 
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=GsTAm6yVAc9OEQ2D1Uqg1M9QdUAqEiPVaCqDuP9TshA=;
 b=KDtxsfcZEgB07iV8H58aRXJYNrB9UcS7iPKHKN/fDKeUix0wz5t+h3hnotkSP+bCpi
 32pbM1BuAH3bvVoYZc7fFl/WObBzscQwlg2txHokn7Bau9+sHPv1jshZJT0tqbAPoBmx
 uZq4Uwx0mYJLoaJAcWt87h3kFySbQCc+ffhBSZk5F/iK2CmiD+TMl6ZR/hIyaeqaMozQ
 jyf0Yr8cDaiGM6ezXlpXV8U39QJJoPtXKYHW7FlpzC0BV90QFmS6FO6bXwXkNCSxqf3V
 NcrapeIuf+EFuuW6IwE0IcHaEpf1Aqtwu170mUwc7RSUglzafmXZ80lasOTCRfypQOZ0
 m2Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780383093; x=1780987893;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GsTAm6yVAc9OEQ2D1Uqg1M9QdUAqEiPVaCqDuP9TshA=;
 b=orfm1J4tCTqEcFWkpA325lZabr5cbVw5Xe+X2Jd3Dyw8MdKrFOx1ZCq2HTDw+o4CfD
 crvjiFa9EpoP69zxAoylMotFj2oJ9/t7AfP5ZTV9Oiqp9ntH8WYyeB3qMgHu5RxDw2tA
 FtpHcJnmdDZ8MBlc+JfQ6aHB4zZLe2cYOajZKoSAWJo9GdRvWrXMqfIhIH8fh9tNQl6p
 +MpN7LpUBJiysyEfFNETjxcBYOz9j5PTJvbx6xYSoxbwexq99q7W2Fgf4qHBa9+N9+oF
 potztMIALeiKZ0aZQQdf6L+OT1K27c/HwHmQvo71EhwVlT/upf/+qYleMBTQmoczvv9l
 0B2A==
X-Forwarded-Encrypted: i=1;
 AFNElJ9EYDVuIDcTJh/u+UEku2SRfv6yAj8pATAEO+hzL+rIg0Sfhxzp3DgojvZVvfdToyh+/G1cuxcJwqc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyFRxvLeYMbW2vvoWUU0pg+n6hExlzxPsUza9dDS0J9/kiI0TWz
 lHIvHxDEac6PEiIZxA9cLShyt5W65M10FJep5bFqXwM1kiV0bTeGgyov2Y3KJUgOsHATHWWRTS1
 kpnWJRXK6uB2EBX1HhDlPzRRVPbvvjJTJz3KRZ5U9qXRArkBDPCcswb6L4knLGXygloKXsiU=
X-Gm-Gg: Acq92OHAJoZ4XNYy5vxsD3lIFwqwos8TWWHu5eymEQ+kKZoeHndSfRTWgSoonuzB0pa
 JfEEHot8OKAAnHcOYm7snqI/GKZQ152HR2K29Eplazeg+QnfrG2MlcW9k+5tYOLxLSa8CSlQbkM
 dPmeoNw/X9zfCn8xOgCXcUi33bjzYRbDZLSKiEb9OULd8F53n47FdwygQ8t4XXTSY09kys0EEE9
 kdoefsVH9+WONOMI8PKICxd8nzjd/U6A7GkRrAmMsfXB97I0V8nALD2KiaNYQ84VdsRmfDpxt0V
 0C/BM6XxPs2J0VlDPsX13U2MQbayX6kXhGpBOBuZ1gGdtHWknndWSD9FxnRx3NCRO7b3lg58ydY
 EDjs2pvYabxajbasUerpsa0jwALcQsPLWgikkKzxKRuZRcXJrONmn55eaE4PXQSevc9VBbmBk/Y
 A98UVmUQaL26VELiJAub5YMBth3g==
X-Received: by 2002:a17:90b:2747:b0:36b:9c70:3367 with SMTP id
 98e67ed59e1d1-36c501e8716mr14130958a91.17.1780383093343; 
 Mon, 01 Jun 2026 23:51:33 -0700 (PDT)
X-Received: by 2002:a17:90b:2747:b0:36b:9c70:3367 with SMTP id
 98e67ed59e1d1-36c501e8716mr14130931a91.17.1780383092889; 
 Mon, 01 Jun 2026 23:51:32 -0700 (PDT)
Received: from yijiyang-gv.ap.qualcomm.com
 (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36dd9751ea1sm1792408a91.12.2026.06.01.23.51.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2026 23:51:32 -0700 (PDT)
From: Yijie Yang <yijie.yang@oss.qualcomm.com>
Date: Tue, 02 Jun 2026 14:51:08 +0800
Subject: [PATCH v2] dt-bindings: misc: qcom,fastrpc: Add Maili FastRPC
 compatible
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260602-fastrpc-v2-1-67a55e22427b@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAF19HmoC/z2OSw7CIBRFt9IwFgNYEBy5D9PBKzwsif0ItdE03
 bu0NU5ucpNzPzNJGAMmcilmEnEKKfRdNuJQENtAd0caXPZEMKGY5IJ6SGMcLDX+VCvDvUbhSKa
 HiD68t6ZblX0NCWkdobPNmm9zDOMPjPh85aVxp3fU9m0bxkshJVOsdMqa2qC32jGlwXtTOntiX
 JkSzuAdIllHmpDGPn629xPfyvajQv6PTpxyCmjAOa25keLap3R8vuCxTh6zkGpZli+WSQOZCgE
 AAA==
X-Change-ID: 20260512-fastrpc-9f3b691f8e2d
To: Srinivas Kandagatla <srini@kernel.org>,
 Amol Maheshwari <amahesh@qti.qualcomm.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Yijie Yang <yijie.yang@oss.qualcomm.com>
X-Mailer: b4 0.16-dev-d5d98
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780383089; l=1182;
 i=yijie.yang@oss.qualcomm.com; s=20240408; h=from:subject:message-id;
 bh=dAJCJcvTZrg15xJ5E/ljL/FmMqY3NfRmZnPBFAjtMBM=;
 b=37zMi3xFZmk2qu17+LzEp1W80jW0ehZlgMHZ9l0kVyNf73S5OC9px39BJCNjdktyTCGHwJYiD
 wR3nRCgKDRaCLyxEZ6sHuoe46JHJGoPLd178b457v1pCh5QuFzamqBU
X-Developer-Key: i=yijie.yang@oss.qualcomm.com; a=ed25519;
 pk=XvMv0rxjrXLYFdBXoFjTdOdAwDT5SPbQ5uAKGESDihk=
X-Proofpoint-ORIG-GUID: CyzIEptQQNVGTtpZ7lLTjgwOJXwwjNj5
X-Proofpoint-GUID: CyzIEptQQNVGTtpZ7lLTjgwOJXwwjNj5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAyMDA2MSBTYWx0ZWRfXxqI51iBxhl0e
 oxdVm30I9bPSoewGcmDtFN5fdBENQqqpx0cywC0DsGsCRzqtM8qHnFAaTJ9vOBWsbY3x0+wIq3N
 CmzDNMV8QA0ZehmKtQji849c1mfenfsZAqy/vWWXZWLi9/gmORj5hqrkT8Iu3ry/tuprQPO553a
 u6MUmotkKfTFaYzsxJESLt2Lj18JRMl7ta/wcc2KEbmOs87MXtFXyVX6L6/kHqlh7zgV3hjxgDo
 APxikc+QJ5kSS4/yoMNKZK7LJWZgLOxhR6W5MimN504X3NVD6leGKYF2xsIrQxY75eetX7OzooE
 Kb8g7RNANbu661ap1/mpCqrad0FjAyNttxFgvSAiY3onVaqfxAeThoTzCmy8GZw2O/QblNxUQcY
 oRXG7Tl0948lUrEG+6yBQL3vEiXvS24fncuWFBsBLXBF17svmvIfnTpei7PfsHmid+CAr5VP3kL
 /d3Y7MUMYZQDG0p5PNg==
X-Authority-Analysis: v=2.4 cv=FcoHAp+6 c=1 sm=1 tr=0 ts=6a1e7d76 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=PmvgEI0Rx0sAJRWD59EA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_07,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 impostorscore=0 malwarescore=0
 suspectscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606020061
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

Document compatible string for the FastRPC interface on the Qualcomm Maili
SoC, which is compatible with the Qualcomm Kaanapali FastRPC and can
fallback to Kaanapali.

Signed-off-by: Yijie Yang <yijie.yang@oss.qualcomm.com>
---
Changes in v2:
- Drop Assisted-by tag; no functional change.
- Link to v1: https://patch.msgid.link/20260525-fastrpc-v1-1-ae9add881952@oss.qualcomm.com
---
 Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml b/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml
index 2876fdd7c6e6..afe52296bf1d 100644
--- a/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml
+++ b/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml
@@ -26,6 +26,7 @@ properties:
           - enum:
               - qcom,glymur-fastrpc
               - qcom,hawi-fastrpc
+              - qcom,maili-fastrpc
           - const: qcom,kaanapali-fastrpc
 
   label:

---
base-commit: 550604d6c9b9efc8d068aff94dc301694a7afdee
change-id: 20260512-fastrpc-9f3b691f8e2d

Best regards,
--  
Yijie Yang <yijie.yang@oss.qualcomm.com>

