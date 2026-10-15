Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2981CC6B39
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 08:59:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC05610E848;
	Thu, 15 Oct 2026 08:59:18 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC15C11221B
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 08:59:00 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69F82pik842288
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 08:59:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 LN0Xc1GnQ+eoesbLJfJ1izlXw7BTBBPuCXZd6buDINk=; b=RGifCXtRCpX4F8XA
 ls0qBNylzApN/IOMej4NbtlqZIwB564QEKM9L62Lm+hEkjBplJA8aBEpBiJ8hVj5
 /LvJXWrPZE6q6QgzusbZ8WVYhBhpfrUmuX5HiuBYb/gyblPNst1XXhC29/OjnbwQ
 dIlhBXWyeVtHeFT0EFPVi259KbSFsBr5u7sOTYTXVPyS/Nqaikt72YijSSiRAIet
 VfuBB4db5E5RZBBpZpQHaoVVLjW9PabNIK32s4JAXcyaBbLQZFmFm2qKvZCo9Gex
 XVMRg2oG2RSjdGiayJ7x8v8jd/YinnFtvfUj1bYseyuK7kzTn+IvyFAlIh9FFFOW
 f9MKfg==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hae4wu4q8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 08:58:59 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-91b8c60c550so94898086d6.0
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 01:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792054739; x=1792659539;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LN0Xc1GnQ+eoesbLJfJ1izlXw7BTBBPuCXZd6buDINk=;
 b=UDJ7EIMp2Aqp3GfnH1PuWOpC33RMXSeSdYyrUCTBLOD41rOfRF6QzfUZOQ38/i7VaE
 QeLvR5BipKyCbbRmHxtRndruvU3HNptQrg1RqHaXw72skfXpZGaybtIXbiybrgypoCAH
 KT0upYvUvT9HueVZFMQqBiRyR995reBSUD2tO0KAws4c9Dr6gKf8aSoVusbsBH9ls6ec
 2khiYUzJl3xz7+1LiJk2+H3fr4diXjWx6O6Ze+L93U48p0Nb/bFlro/6X1bQDMNBlJsb
 Lzb0Ss+gdjB5YW9tE5cnZciwj5oH0HOm1KCq96KsRMvLBsj6ySwFvPsc+u4ikobPMRJG
 x6xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792054739; x=1792659539;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=LN0Xc1GnQ+eoesbLJfJ1izlXw7BTBBPuCXZd6buDINk=;
 b=X8KWxl0RpALBL6d8HJZNWlUmCtLGXo1SwKELD3rZAXpYMbOm0BVuNp+HMgh00eZYrk
 sXkkbf9bzgnYzpz2G4YcCNjfSUq25Wi0qCxIIybep/BodsyDPmqzwzAHbyzbArUUxrkJ
 ENNJo5MpuL6fXAbEUaCfkPaialjeVPrn7rhdBJj6+sWfp3UxFZlcPED+c5RzGYhHZ3gy
 i5MCIbquE36+pPNWVr+Ul0eHMb1IiiDq9eBKERnGOCHjlA5zCo4ZFaJR8dOB2v5CDKEn
 HfbEUf4ccY6zZVaVAw6+DOcD7e4jGmP31wM9hrZPjT6qrZTirqMyqXJkjxopYUGK8Of3
 66dw==
X-Forwarded-Encrypted: i=1;
 AKwUvBz2Ct+GL5G5FvnO1NRmkWRvB87VZCPXRVAt2SFXFO4TLF2Xr6PoSGW4EG/T1MQcMgOlbCdhWZNjewg=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYINReQxTizqqDP8T0gLhyApEMNZRZbcjXasKwD32+jlbiPKIrl3
 PSxqtTKjLyRbdwOjp6x8Z/sD/zMA9uMCeNdqbMizK/e8z0Wd9erPXrIRS6WYelREEIan/6n7NSN
 uDQH7YJOqMTpFZyBtJAiEwUIQVBTiZgRycWzAyuiTf4IwGGXllZ4QNGEUX0pZAhluFaqpkT4=
X-Gm-Gg: AYBFou3FqJtkxaUALMhOJYtyQJ8019nonVUnrd0IdoH+iIEhkkdCosgKClNxeBdYJ44
 SibqSBIBEDmG6F7dF82OI5ATIZOV1UpMf6G0hex2zGRnLvtneBp5ysL+Rar6od0Ywszgj99FSVw
 izUKUAS89coNN47aURz2CwZx2WplD+9YzFF6BYAnJbi6u5OMokY8M7MakpaGmRHdt6gbpZJ5/EB
 M4kmE2SCFLdAWMLJF3eY4PVoBUBtNUC+3z/dmqBdYadEZ/CqZLC/DcPaSHmePkHG+TyNtSDTLuW
 GBzR5vIwdwae8rPqlw9xpggqG7tpZDtz4XtydG4Ctp6BdkG/pt/TrL+8LHv4M3V2Xx7uxXL0G3u
 eP/m1AExIhtAfTxtPYrSfwbICFe0Zpl613VkUuIGK69eHAG75b8K9cZnOu6R/XG1Ft4z2PVKxOI
 w85n4lPhRVxM8d
X-Received: by 2002:a05:620a:4411:b0:93e:7ec5:2d65 with SMTP id
 af79cd13be357-93ebd20b8f0mr3005237985a.31.1792054739230; 
 Thu, 15 Oct 2026 01:58:59 -0700 (PDT)
X-Received: by 2002:a05:620a:4411:b0:93e:7ec5:2d65 with SMTP id
 af79cd13be357-93ebd20b8f0mr3005234985a.31.1792054738671; 
 Thu, 15 Oct 2026 01:58:58 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5be3b51fd1dsm371590e87.58.2026.10.15.01.58.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 01:58:57 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Thu, 15 Oct 2026 11:58:41 +0300
Subject: [PATCH 4/9] dt-bindings: mfd: qcom,spmi-pmic: add LCDB
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-sm8150-display-card-v1-4-5c14928cef29@oss.qualcomm.com>
References: <20261015-sm8150-display-card-v1-0-5c14928cef29@oss.qualcomm.com>
In-Reply-To: <20261015-sm8150-display-card-v1-0-5c14928cef29@oss.qualcomm.com>
To: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>,
 Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>,
 Kiran Gunda <quic_kgunda@quicinc.com>,
 Subbaraman Narayanamurthy <quic_subbaram@quicinc.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Abel Vesa <abelvesa@kernel.org>, Dmitry Baryshkov <lumag@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, mfd@lists.linux.dev
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=903;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=CinbcOsRrU+weX/x8DlHfWVx496vQyqNGyiZd765C8s=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBq0JXEzPl3ITzxisJqsyw4t0pMlSYPsdLWHMBT5
 voOcnO3kOiJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCatCVxAAKCRCLPIo+Aiko
 1eF5B/9YLyJIm841SYHHx7rwcbc4xMrNlKQYxSlfc3LF159sdBscm4twCToMomUy2BcBEVMFUtC
 mdoa1ukOkMfZz5w/HKjj1PmtFbnLx/D3Bu93+giW3zgS6l2EwH+qUkGwFJLvkq9SFQ38TlRm455
 0Y/gSXgT19PSELm2mrxTbo+uaxIfBzJyygKhU9NiJpiCAzWLItkY3dSyIgc/joHWGNyfQatevW0
 w7F9C7B5MM/1cl9cVnPq+OHUZA53YXzXZN0Hnut1G2pCe/7ffN+9sSQvhddiU3EJEp9EfiNxeu6
 jb30K+1QwSzPiVqd3KR10oY9QwWmyp9OaUlg5gsPtE1jqJl2
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDAzNSBTYWx0ZWRfXzMW8KscTa1LU
 KVTkLP7InkOZZBBYcixK0FclQqGs6bExuU7+E1bSDMluUbY7yzOm4dRCZmFE81ddbdiuJ5CN5HM
 DnsLL7Bwk2FvMGTLKxVcxDg7gyWEN/w=
X-Proofpoint-ORIG-GUID: 6DnRHSEtl9LKrldiAduJSzuzKD-fDZ71
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDAzNSBTYWx0ZWRfX5AUJ07aLQNDv
 9CDn5IIHPxoLlqaaPvm7P8ez4/nDokIspEOS9YMoxBE7Bl/2QJr7IFBsw5k/+S38UNazjizKSJz
 uSY+0Nmct9U7dAQRq/im+GFxr13JVM/B0QgYdes/WdCQJzyH34vuZ0jiQQzUDPF00AqoTRybdv/
 0dUrYkifzXcjvnizKEXOif1+7Vd8WcFgOLMMOvJ03UUbfmXO6K5n6VriVjctDeUOyUP3BbP008K
 4cxSkNFeOCBe0JNpGPtwKvBL5sXA9xbRvCFnjPHWvnajd0wkSqeNLcclONVBQCnEXWkoenP8MJg
 9a8SLh+Xp7du9TwxFUZkuHj3trS1UpT6wDBMtGacora8dkeI6B8aZAf56qBdz4qXtap0QZWbpUi
 m/6vkZ/rBndhVg33S8YckUsudxVnulMNNInbSiymWw7zx3PBBUJPXMUXW95gwCCOmxaqzdk9ZvH
 N+mEyTyLcYqTp5vWJjg==
X-Authority-Analysis: v=2.4 cv=E8BYNqdl c=1 sm=1 tr=0 ts=6ad095d3 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=l4xqpnzKx15mTiSKZogA:9 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-GUID: 6DnRHSEtl9LKrldiAduJSzuzKD-fDZ71
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 suspectscore=0 malwarescore=0 spamscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610150035
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

Allow the LCDB regulator block as a child of the SPMI PMIC node.

Assisted-by: LLM
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml b/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
index f6534e9e9912..1894fd82cbda 100644
--- a/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
+++ b/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
@@ -171,6 +171,10 @@ patternProperties:
     type: object
     $ref: /schemas/input/qcom,spmi-haptics.yaml#
 
+  "^lcdb@[0-9a-f]+$":
+    type: object
+    $ref: /schemas/regulator/qcom,pm8150l-lcdb.yaml#
+
   "^led-controller@[0-9a-f]+$":
     type: object
     $ref: /schemas/leds/qcom,spmi-flash-led.yaml#

-- 
2.47.3

