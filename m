Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2749ACCF2DB
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 09:18:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2462F10E917;
	Mon, 19 Oct 2026 09:18:37 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D043D10E8FD
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 09:18:22 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69J8OsTo723135
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 09:18:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 cK9XIjoJkCr9hVq/5NleYDwc98kzEkgjzgNbxN/oBho=; b=OVSly8hwaoQ6Usmk
 +W1+TmqWW2KtP2JewCKwM5qvVICbxi/S8etKxnivLsmdnTKs42fg5WmO8lkSCuyz
 4aLeZzfMoSrG826PCBYC5BDYHR5ddAU/ZAFIX6WPbXXyK8ataVsoYCu+G5DzMEIn
 ECnp7c0tXZszwfa6icOhnplbo6xgWxziAucBfo4wmif3Xb+l1mArJ7riFaDNzxIc
 pZTRNWwKshTBzRBLd5Fs1l/yhZ/mxVKCHZq4uwmPwMOlwlME5Oe4UC/wzPMth02S
 naxza1DTyvuk5ecb+U9AADl4t7BvM4fxjBLfRDpN1a0TzNDhHcqG3KSX97tAp1Jl
 CvGceg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdf65gaq0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 09:18:22 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93a3f673221so742299485a.0
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 02:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792401501; x=1793006301;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cK9XIjoJkCr9hVq/5NleYDwc98kzEkgjzgNbxN/oBho=;
 b=TbU2kLFtK6SXiM9DirROyFs31CTHlIzQEYW1jqMaysAEZGWpGGgBXOwtHTA9h4tfYm
 bTCK+88r16D1gR8orMegJbm2VcPcprpyx/4JG84/wza7/56jrGibCRNYxcPJIKmPtRp+
 UeruAB/VXq+s7xXc7sAVuzgF3Ui7fwio9/cRa0cg+MvhClH8t78mAWjhQ0MiJp6KWGMk
 GCPyiX9dBJMX2qzAUqn3x9Dt0cyLfwvcPR1a62bC8Ac4zKUUkq7TS8bvv9e913D+PU1D
 plquDZx8w/sAvAMESOq2Jml5cRdb8gZ29V/LYrp68i2d2+W4wcNBSi/E9d35L5NbeyrS
 f7qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792401501; x=1793006301;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=cK9XIjoJkCr9hVq/5NleYDwc98kzEkgjzgNbxN/oBho=;
 b=jV29l1rqcJkIhWYpKOL5clEjTZz18rqXFqWQrVHdV6VXebv398A7SJ/t84ci8qYtoU
 MMDXsB2PP/eAGSbee5DI3oxeFhgFFmT1F8AENglKcb4J9mU1ZZQRpUpAEA57MP49GRIe
 ya/0BfB3ZzDQxkgZ1h90PFEPAmi0eIr3NMjfpRCnykmqOU0eY3oJ1lhMqZbWp8amkjrH
 kFedURpKKkiRAOh5Ehd/iv8mBuEoD/lNE2qtEhiIhecnTbEXc8xb0/unbJOpQ+hDYzoM
 KzreO367YYnMZ/K/Ncw7qZdbhbEk6KD1MmQOCtuHDYyDX/qDlsk9cVm6OrUrZntB1/Mn
 IBVQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwL+QRcgar4T7z2T1c/KFsBLy+1n73cmhGi4uR283wlQhMh46xHQrF/xR2esAdAEM0aJCLbX2eR4E0=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKWcnlAZ/tnkOtbXGSG84fwKEtwJX8np8T+LDCGiid8+Dbqo2r/
 pvgwb2J6bqYgDw0XlgpncwQohGf+HwGXKOhXszgddmWfHJ9bKXc9TIsT5mn+lLs309yJTbuPEF9
 aNf6OyBChuHDpUYekupWHPgkNWd6YRLq7ZIhKDBOv/gK/WeIUK09OgQoss7ZzN/3dxJI9/Gs=
X-Gm-Gg: AYBFou20Da/gnQB5bVkZEyzUOls1IqLqfVE1IDFBDFDmx23qXkIUAQK8B7/OXdahbZr
 AHhHykhRsN9P4FZQwvytbksalLEoaEAz64/fyIDtlNqTtJSGFw8dZZEqAKMzcBV6Qr6QSCAI3XX
 +5cc6mb4n9MYixRRTqWpl8oDk/Nkqsl0REOVoc084NGqwkkEo8J3NSFN52V5+piZIU4A63GMQ/o
 yNH/L/iuIP0fXh6RSO8EPS8cslAFvXplzV9tetcye5Dam8Nkm2wWTKyPIQva/t2W9NnxuEAtv7x
 2CsAgg5GjvSab6QOXe4rrzWgZgDbUrSvicnUOi6t8wn+zKAVffnbz8NJGShBVeGrWkrwYdxjM9l
 yNgAeBE0zUBW0dInRotjJx2ZbrQIM7c6ciMuPSSItx4YuZaLaiIpSOEzVN2Oi0/X2bfQYT7P2NL
 ytrNDxo7CVln+C
X-Received: by 2002:a05:620a:a0d8:10b0:93f:2ab9:7294 with SMTP id
 af79cd13be357-93f2ab978a0mr752275285a.29.1792401501063; 
 Mon, 19 Oct 2026 02:18:21 -0700 (PDT)
X-Received: by 2002:a05:620a:a0d8:10b0:93f:2ab9:7294 with SMTP id
 af79cd13be357-93f2ab978a0mr752272085a.29.1792401500588; 
 Mon, 19 Oct 2026 02:18:20 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3ab2e4e05c2sm15893441fa.25.2026.10.19.02.18.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 02:18:18 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Mon, 19 Oct 2026 12:18:05 +0300
Subject: [PATCH v5 3/5] dt-bindings: arm: qcom: add Qualcomm SDM845 HDK
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261019-sdm845-hdk-v5-3-4aa7e22cd0ed@oss.qualcomm.com>
References: <20261019-sdm845-hdk-v5-0-4aa7e22cd0ed@oss.qualcomm.com>
In-Reply-To: <20261019-sdm845-hdk-v5-0-4aa7e22cd0ed@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Abel Vesa <abelvesa@kernel.org>, Ulf Hansson <ulfh@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=843;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=BF6415btVpAVudmuKDsPZH7SQiNfH+6JB5g0CaPUoN0=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBq1eBQFMOLG9PQ36ITEssszgQVT12P+KtvGzFFK
 NbVV244DieJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCatXgUAAKCRCLPIo+Aiko
 1bQtB/4l4qocq2Fo6r7FjoNyp/oDBsptgFXXkJhqJQwPL1HbgxdeG9aUp3rqEcod2MAB8EW/mV1
 tqlZ/YJULnMcyyIXxoyBQwNQo9BKHVh/1iQlBqhau5BwFUam5j6ynUdo1HUeVm8hOUhpQq0XYIu
 Gckeqp+LLXJAUa8WoVTXNKjFkvJCB7ZD8//mvvyTmcoCpD5Yv+ugd/Ja6JzKRaxBBE9tBZPVBYm
 wQoi3W6CG9lKpoXm/m8kyjvct2N39YhIF3qajF6m+rSK6imLKP6goxozOvVOwfARfUSpKe7X8XD
 xN6CIS/jxKiQ/gQerGFRFGgtHBJnh9dHnbbvvBt0q+kww5oX
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDAzNiBTYWx0ZWRfX4oFdcQvo//Q7
 nZP2W/GBuO1aVFQuY0AOm4UUozQrhuhGLNKJyI9FPM3BPDotoO+cdVtAZW/Ff/lhTjxIHhAlmmb
 kx+DO/UdrXF294rgwl/rFhVfU2n6mCo=
X-Proofpoint-ORIG-GUID: s-3XLdBIcXGqnj-gs_9kkOpQYQihoC_q
X-Authority-Analysis: v=2.4 cv=Y5ptIReN c=1 sm=1 tr=0 ts=6ad5e05e cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=9nMZPvWkDyzw5AdY2PIA:9 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDAzNiBTYWx0ZWRfX1xAFhQBogBPl
 8988ZjGnLXzdRV808yE1dp/8N261xyIVM5WGPmLb4Zd6xi/4/+WjrJHtLtdqBLJiwOwyAiIJvyL
 q6vrIMKvKdtGjgrAPfeUAuhoW78uh9hpfIvExDuT90Vq1U2Xbb7yRyuY9482YelIgp3Ac5rKUr2
 ljfXzi/MjUz649wji2WjK0SddDc3QaIq0kMPSmCuJSzmt/NF9qCH+PVvah3GKycH5m1QNNEiGRf
 wuZQUvHqQxnIIgeupwLeFgwa7SzTK9VThiqtI6EFJHoyUGUbfK/IOTUs3rAtIxa4T62GWh7aykw
 Gg7bYB/72RTtKrxA9TITtRPzDhmwQ+ykXhh3lX9zB13cK3ro6bj1BFcSP5tbzymQYZ/kAjj9XeZ
 SKe9hdXKfk2Bs6EY/xOtWQgOhd/R6rFLLMYaMFXAs/rCS2evaSfqRz8xO5gQJPGEAcCzTUhNXT8
 kdyzul7W6BEyS0DfdJA==
X-Proofpoint-GUID: s-3XLdBIcXGqnj-gs_9kkOpQYQihoC_q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_03,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 phishscore=0 bulkscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610190036
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

Document the mobile HDK for the Qualcomm SDM845 platform.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 121ca557ce1e..dec58f8818df 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -1003,6 +1003,7 @@ properties:
               - lg,judyp
               - oneplus,enchilada
               - oneplus,fajita
+              - qcom,sdm845-hdk
               - qcom,sdm845-mtp
               - shift,axolotl
               - samsung,starqltechn

-- 
2.47.3

