Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E078C106B50D
	for <dri-devel@archiver.kernel.org>; Wed, 25 Mar 2026 12:17:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2275510E8A9;
	Wed, 25 Mar 2026 12:17:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="XPDNDY2d";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iI8WDXd0";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 14E1010E8A8
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 12:17:05 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62PBGHS2241603
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 12:17:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 s/EytBvPv5krLcE3pGnumr6rWcvd414N87RjUetZm0M=; b=XPDNDY2dWpDUBfOO
 CTJZ443m4DJBldJ9cqSdcPppx2b/MYe1HBYfNb5fZQDkX7vuqxcdr0zkc90U64ZB
 kYjh85kHdEE3QCGPj2bUT+ZdSXcwhSkDZz41MqDNOccTg79nm0muMGnsYTyfLIYc
 nyzOUtv8AqpwVC7g2j/sqF1mNKNT9D1Z/+vDz4yA4LeSRFc92dxXOV5x/pb7nxrV
 rBf8ox+jpN+lgA1ggUfk8YxfeayX8O8uKcCmczvqp44jZJamghOC/i1VkVv3QzJu
 PiUbWm5Y1kPNhWgyxGoZ6DRpJxNcH0kQjj90Z+WFpnkQ3yiOc7Hk8F4CLFW8jCp4
 8EJNYg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d4cvp0n9e-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 12:17:03 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-50b3544bc7bso24383481cf.2
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 05:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774441023; x=1775045823;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=s/EytBvPv5krLcE3pGnumr6rWcvd414N87RjUetZm0M=;
 b=iI8WDXd0nLDXUkOnjxpRUXjaFaLSYHtZpfBQpUdnLC/jpta0MiVCmfTwguCRByKEd5
 5Lex9iIoVovoYvAt6yUMaR43cBWUM1VZA9GZgEsub/LZ35uli8dYJ+8u78ug7E0iqhQY
 MECIueYujfUQBJjUXC6PJuQbc+CYWIgLMOWVsBeKN3xy1e6Xhv8SqOEKxwW65C++EfuP
 AJdkV/9JJIXO1WZO02fe0pFImBRJ/yRkQ/UIlbG5E494ph3heGvHSylN1ShMALilCja+
 AyuUpu9uayV4V+QCo47njXPPheam586WKZOA8WINw0olNGs0JzrjMoKdCKpURETPU5GW
 X7xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774441023; x=1775045823;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=s/EytBvPv5krLcE3pGnumr6rWcvd414N87RjUetZm0M=;
 b=iEBCl0lBZWr/nOd9jTuNfVPfC8fj+vq9EpukZDaoVWXL/TaXvQHXUelKlwPzCo0nhY
 wSDsYwBTbTS29F7boP7imdbzAzzDfs9nYdK8NVSknjB2rsBR4EP1PFDQ0YrlyA/kdMk6
 Z++ofZYMrS24Bc8tjlS28ba340gVwGKLfvxhtvjgJBhHubLLInq67thUlLdgXa1heUKz
 4cqoEjixmF82FkasUUMNvKCrGv8dVMBDQMCJqD2crj66udBn7L5Bmt1ZUUq70DcEN412
 E5rlyvWzn21F9M0scuDhkc8my6+F9o6IWEMQ7yhRGdiUngPFWQ80dlSP+3cw/7PQZsSk
 bpfA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUjj7/8aDaGb+Vvmw1flE8lvcf/nz5H22Gz4Hauafgccv2Cm9t0iwZjUSoczUfP29E3WELnXqF7yyI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzxs8j02z13RMBye6iqEfjgtg3lAAyyjB3e6SfOL7jT3ya/5nUG
 fpXCpAaKu262i4aN92xst3cBnDDSVTMZlGzwbhRJifkzaIgFBgKrOcYguYIadNI/8RIzWRawPwr
 FNx3VYvbXzKDgY+arueiVsCMUp7V38GG8BOG9C2rdgCwhNdnAjBtyp+YffQ9pk+dQDd8mIpE=
X-Gm-Gg: ATEYQzxgEq+8RVrYVu5pxLi6261cqBA6mXDUg0Krzd3garU+4WjnUcnprgpJ7urC5sq
 7p0XYQQrHNrlZ20EpOY5tIOiyFJeZ9ivoXuWQ+ytS/T9FlxPoSfgwWEWg/I+9QYKsNOFKAv0h2E
 OIKTq2xg0pF7LvJE0flGJx6a2ydwwiXSWNJdt40QoGFkLJtZORaHRKFfkcVyOgyabAOZN+LpIu2
 Nibg2fg4zhVQ4MAn5/t9j71bpI6DXfsxcgZic7VCEHVgSV2Gus7+cAiccq41f89iT/C6ukbtu7/
 pc+A//P0iCF1qK+gzp2435jnvZMnIcQuCq2GGQYeQ5FYqGs/fBNK39TwYLdq0fGeCBBujSVi/Wu
 1irCC5K2gKANkCXT6EkJ/pSoqd3Zzy7uY7DJSsaWc/tmJ
X-Received: by 2002:a05:622a:1899:b0:50b:3e4d:7feb with SMTP id
 d75a77b69052e-50b80e8e3ccmr44316631cf.53.1774441023322; 
 Wed, 25 Mar 2026 05:17:03 -0700 (PDT)
X-Received: by 2002:a05:622a:1899:b0:50b:3e4d:7feb with SMTP id
 d75a77b69052e-50b80e8e3ccmr44315921cf.53.1774441022655; 
 Wed, 25 Mar 2026 05:17:02 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.94]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b8a106339sm6480356f8f.36.2026.03.25.05.17.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2026 05:17:01 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Date: Wed, 25 Mar 2026 13:16:43 +0100
Subject: [PATCH v3 2/8] dt-bindings: display/msm: dsi-phy-7nm: Add Eliza
 SoC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260325-drm-display-eliza-v3-2-dc2b2f0c74a2@oss.qualcomm.com>
References: <20260325-drm-display-eliza-v3-0-dc2b2f0c74a2@oss.qualcomm.com>
In-Reply-To: <20260325-drm-display-eliza-v3-0-dc2b2f0c74a2@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Kuogee Hsieh <quic_khsieh@quicinc.com>,
 Jonathan Marek <jonathan@marek.ca>,
 Krishna Manikandan <quic_mkrishn@quicinc.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.15.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1172;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=T8zgB8+aRfT+5AeJiTxBNx19VfBz7bFS9oT00XLMGD8=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpw9IwWzQn35Ru2xnyoNqStmOhgmM+uhRnVQTkA
 3UTeAn5Ox+JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCacPSMAAKCRDBN2bmhouD
 156ND/4tKyi0MMARxBprR3Uf6toY6PWWBWH6Sj2kk3iFW89xaIZt8YdR9c4Ko3gq3QyT1FiLEqA
 LKLOC0a91JCp05gplmeRCcTFDbpwFA2qAZJCgke37C+LRT9EK0meJtYyPJT9wmcEs6I71/mgY8z
 dYB11FB4W7H3GKCpjeoecYVqMOI8n4zD+Fl8a+JKPQNi85ZfuAlBU0GZsH97TGorRoLpd3y3PX8
 YxajvWUWL32WBDr3pgBoB+bf2OpCgNABajMhssAmYErh9JNQ+gNxxMw5cdfavXqGfFyHuidBnrz
 67tk45g4bh+hzP5XYwLLEqmzuXiQA6WbCAZsDBzLTxQYp9r9qUdrdElbcxK43QQ4HBPEXbJYr2d
 +6WHX78xHGWQK2tGoi4Ws+7RYMoZ4K9aidAKRquZ7zohLGqJmuAfafk9dUMh1ERutMJdAM8pkGD
 taBq4lfsdjxrhbNa8KrJ1iFnle9AitNLcjUeTxW5pR8+zX6VgTCvuto0C1RvSVTKXS16NF6R2oa
 O9tL2+yOWgJr3BDxD/jmUSCYySW7LE8IGDKHEb5lMu5sEgacMQJgGea+eX8MZ+NwE8gk8qOGQuZ
 9Qr8f3aE/A87CK/n8SHy+CpFvgBo6iGgJQNpGzI6tSFpJCelItUZGcuuP9dymWfjMJTcvqIULWD
 s5kQkZz+d7zK/Iw==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Proofpoint-ORIG-GUID: TDfvvYnnkJxLgagqCWIYseDAdaOq3Vuj
X-Proofpoint-GUID: TDfvvYnnkJxLgagqCWIYseDAdaOq3Vuj
X-Authority-Analysis: v=2.4 cv=Q73fIo2a c=1 sm=1 tr=0 ts=69c3d240 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=gOEeR9iKwsj33Yj5oN/cWg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=ghL60u8iUD4uIiEFN3gA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI1MDA4NyBTYWx0ZWRfX3i7kXs2bc7r9
 sSm+OcRkRuz5EiniNRSlj1VqCJe+z4GSX4+Md8PXiIfPTLVtIVyrjjQjD73kPz9HTBPbgBozMMj
 MS5+B+DJW0e2pQTpfV4cJNMffQc9DiYld6SOB3jhoqIO+ydV8bTWHOojc+EGcGR+o9nUg8/5Q+Z
 utxFE2r7LTIcNXzPXBt8wq+W4IE1q2NbKjmSeqSnWQE/L+gzswOTiuTLmm7AH1lb8EN2TMNzYkM
 CAUkx16LV3qFDNilhj2c1umY3h85zeVVaizlH8bRboqT2WfaHl18yJ2u/DmEskGrKC7Dku9eJTA
 /iRGuF9XBjK7LNatj2XSKxHphFrroMBOceDXSYKoJ/ZsyQAi0DcjTUexwh0HgioUOCtqP2X+LtA
 TxUTxkVwpASDEgEr3Q9JnSRnVXyJK01Ze6h5mK6M67Gomm4AgFFfb/ipjnBY57S7QK8IPiH7Gg4
 BLE5OQbbQBX18CzZp8w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-25_04,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 malwarescore=0 bulkscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603250087
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

Add DSI PHY 4nm v5.2.4 for the Qualcomm Eliza SoC, fully compatible with
SM8650.  Note that this DSI PHY, unlike the Eliza MDSS DSI, is not
compatible with SM8750.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/display/msm/dsi-phy-7nm.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/msm/dsi-phy-7nm.yaml b/Documentation/devicetree/bindings/display/msm/dsi-phy-7nm.yaml
index 9a9a6c4abf43..3ce8a9ff4555 100644
--- a/Documentation/devicetree/bindings/display/msm/dsi-phy-7nm.yaml
+++ b/Documentation/devicetree/bindings/display/msm/dsi-phy-7nm.yaml
@@ -29,6 +29,10 @@ properties:
               - qcom,sm8550-dsi-phy-4nm
               - qcom,sm8650-dsi-phy-4nm
               - qcom,sm8750-dsi-phy-3nm
+      - items:
+          - enum:
+              - qcom,eliza-dsi-phy-4nm
+          - const: qcom,sm8650-dsi-phy-4nm
       - items:
           - enum:
               - qcom,qcs8300-dsi-phy-5nm

-- 
2.51.0

