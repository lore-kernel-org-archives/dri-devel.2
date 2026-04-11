Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70D9DF3ED4C
	for <dri-devel@archiver.kernel.org>; Sat, 11 Apr 2026 12:10:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B53A210E1CE;
	Sat, 11 Apr 2026 12:10:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="feTuxqXs";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="N+jIr4JI";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4967610E13B
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 12:10:53 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63B402ms3909329
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 12:10:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ETYWoaJyM9VmKmVawKGSIxoRtEFEsHcnX/Tz5qCocnY=; b=feTuxqXsGcTt9uq/
 6+2xm7UTQX8lQOiyqNWortvOz2yCLVQTs7BBZJ1ZnMLMjdqsAtQL/UiclIiiJ98J
 v6XJla6kY71vBQA7bfIKMK3SNOVYqEkSVgYCQCtbc3203EGPa0jPDpWk3WqH1HNR
 KAozu5PgpJsZvq3d35M7etgA4OQ7KCD1Yi51YFraLxADgDbMglU0sr0sGCrE5CYY
 S+hcQvV1/Rrh01qjSCbVOTLbltrd7EdOgXUVcgT4357hU3YNWS3cS9HboaYLcK2a
 GqcXni2mQXoDrvtCWWLIYXrUy2xEcDELvzcBPS6/CkBJu3QH5Rm0h1YBlmYi5akw
 +snIjQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dfew00na3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 12:10:52 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-50d831e8083so26145351cf.3
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 05:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775909452; x=1776514252;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ETYWoaJyM9VmKmVawKGSIxoRtEFEsHcnX/Tz5qCocnY=;
 b=N+jIr4JIHcvouVmZwOYEbdQssGT3UVddEDBcjwsBE3VTOQlFfOTc1OEQbcUIx7x2C/
 nBXVMRHRJaNFpnMz/E4H6ai6jCqePDxafkJan8X47JZGjaraM0DTyN7UJ6GH2Q7KwaQr
 VmhJHrDirScNE2dZCeKaZopWX1ibtVeEUFGUcgtam+wD3Vw8RUhbYn78cbes2iORSPfp
 jigF+B7gnw0IAbgYQkQRalN1dnS8olbotv8JJwn+wBfrQsfe19hp7vbLm5EN6MK7hrdx
 sDKSpeoylZIHch594o8/YFcoNk2Lc9RujBi+8lKU4VS8YEqvPg6cOxGyZw5K5yrNvlNu
 IbBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775909452; x=1776514252;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ETYWoaJyM9VmKmVawKGSIxoRtEFEsHcnX/Tz5qCocnY=;
 b=QbEnsINYUff+AfsDlHbi9dyON9wnxwuRggIFggqZkAXkz8ncgpEcVXvqmwJhG3nD9X
 Y+ksz2y4WSs12FnCPZHMDZ3J9BW/Oi9RPjDSgjxgd+WT4CXnu7bu03HYBV3VFfDMB3Fg
 lSbUnNeCIap2EGzi7mO0k7h0W2vKtBAHJQ8zrQ/hdG/egmfnMJMFUvYugWeOCRVItPy/
 bRzAttc31HQ8xI2fAopIS1RMFOfAxwTYWCDxXIFH4xc0OmRMH+JZ0C5RET6JeWvacbNU
 CtQz3EutlNvP2rNgxs8v16Gm3WD5fyTPK3F/2dr+En3a+8lh0O/+WVjhWW9g5Q01/wzi
 Ob7Q==
X-Gm-Message-State: AOJu0YxAM7JEgrxoAw5vgk765VeTjXp9VK8J9YI6I40p/4sjh30Rv3U9
 cc6gTvmBzHw9ZLOpP3c/SdYcen2aWxmWh8YcFMgbWr0/zioh81Uum8VpW2B6grd5T9tuDIFYiFw
 p8NTlT9J3NDZfcN86iO0wwvnddZyv/HM3BAiq9zVISMD1jy8mNGh+wzpsq75qBMieceXc5Bw=
X-Gm-Gg: AeBDievSfxXjNTY+k2z3RWOqqEVY7OlhbHyrnxDcp6WYZjM7Kra7frYjD0NnGNO7zxN
 /UYBVhIHJZ9tfO+UPBwGvbS2kQgrawS/KHhK5JBlV/+dhrD51mVXmEUU/Kk1UggNPEXdMh4Hxjf
 VStr1MCU6RK6yoE79C2HRARuSmJ5neelaSaQXygnMyqA01gDDqdDG2sKxrSdtaJKuPGTLEAGY4x
 ncZrsoAEsLLT+exHZorDDmVD5AgpHz7eVa+uWIUH0qWDIekLBNqWsAemRRd6ar857/h6cSjIfYC
 iLyjtVdn694YYdIok0pvpk2ZX/96c/o8dbHevFrm46CQYYEtz7UtHc6sECda7o6sWvePxXgqsTT
 GVOUmV1WZ0rJCVzkwXWmadDT0TAiii3IazlpUdu1VulQtlXpLUP6PSYn7Hf4VlBjMK5WUSVL4x7
 btdyMXlHe8ZmBr99j/2lDjrF8GvI/dQ+dHeOE=
X-Received: by 2002:a05:622a:1985:b0:50b:2eee:4b38 with SMTP id
 d75a77b69052e-50dd5ad15e5mr93537431cf.8.1775909451847; 
 Sat, 11 Apr 2026 05:10:51 -0700 (PDT)
X-Received: by 2002:a05:622a:1985:b0:50b:2eee:4b38 with SMTP id
 d75a77b69052e-50dd5ad15e5mr93536911cf.8.1775909451378; 
 Sat, 11 Apr 2026 05:10:51 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-38e495b4e73sm11906291fa.41.2026.04.11.05.10.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Apr 2026 05:10:50 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sat, 11 Apr 2026 15:10:21 +0300
Subject: [PATCH v2 01/21] dt-bindings: display/panel: himax,hx83102:
 describe Waveshare panel
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260411-waveshare-dsi-touch-v2-1-75cdbeac5156@oss.qualcomm.com>
References: <20260411-waveshare-dsi-touch-v2-0-75cdbeac5156@oss.qualcomm.com>
In-Reply-To: <20260411-waveshare-dsi-touch-v2-0-75cdbeac5156@oss.qualcomm.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Cong Yang <yangcong5@huaqin.corp-partner.google.com>,
 Ondrej Jirman <megi@xff.cz>, Javier Martinez Canillas <javierm@redhat.com>,
 Jagan Teki <jagan@edgeble.ai>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Linus Walleij <linusw@kernel.org>,
 Bartosz Golaszewski <brgl@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1011;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=USkwXBfci9sIWJW06UXbOmxrqKMlrITA2EN65WJiKAk=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBp2jpEO9zdh8EzzHxiRDkHCUG+msrq/SXCklYuc
 pmmv0HX3+GJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCado6RAAKCRCLPIo+Aiko
 1SH1B/9Cr49LTloTdRXJKJpX7BeidSo8YeqxqZ6HSt8IrpYuMOtkxtPJdf/mPsN6S6m5+af4Cy8
 j/ekpWPhZ+dRaXSfhADqSWB+6zFsmKx9n861kfdOryJgk6HAw2v7ttzUmqt9WPApaaXPSyG5Yqo
 Kq5mASdK+J3ZVqM9lpohHF7rLcxfBMiFbKgMBCDxkgDHLmbg2twHcQunTswlhKdJu+PUCDPoPIa
 iQE+/Bcx2tfokUjYUZCtDtS9Vgsm1rZ01+AAgUuhRJ1yMPImb21SgwNmjFmM2p04wP1kH5QI3Xy
 KlooENrA0RQHmqxPTuObwWxhGPTG4l88HVnE4yFiiedUPzoX
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDExMDEwMiBTYWx0ZWRfXyrRV8XEYyLPO
 KBfi5xhiyu4qf9WzADFtVU5jnLya6949YdgkGjJcgx+VASNQt8z8v3ppO32OypWGgwvt5e3XA/t
 PyRLI28h1aDJfaRs3Hl2h4hVAMCh3a5DsWhnk5gVdShmlgAYKHZuwsBEZFjJO8crmMq5gdnE6z3
 sgvOaquPNypczqrpx+SelfZhxVrkwr1ZPzMMfdFHb5I8nIA9IqQ1MlsnnKXy4QjnlHUgMjeZ/bJ
 TxNjB88OOidhu+DX57TnJMGG5N7oJx2cftiLNDZVTktmlkFZ8ZJgbnOe6w/RnAgzUH6Cy522i3x
 cTjmGdz772fWMn9QysQCazYXuMX3GFY/Qvq+IsNy0pwUqngHvpjgD98AgRM60BLBl+lALrKZLgt
 bIIx+MdLJDZa/nhYun7T4Dff5c9e6VK7jsEUf83GW+dmRbftgg5CLyB83Erp3cru57EriklOnLT
 0XA+l6AFp7nQAyloQ+Q==
X-Proofpoint-GUID: VBlkK_ZKtPhPcJ_ikxiNOemsWjg29Lrk
X-Authority-Analysis: v=2.4 cv=AofeGu9P c=1 sm=1 tr=0 ts=69da3a4c cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=dDwtKCuX-g0vR4_aJEQA:9 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: VBlkK_ZKtPhPcJ_ikxiNOemsWjg29Lrk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-11_03,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 phishscore=0 priorityscore=1501
 clxscore=1015 impostorscore=0 suspectscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604110102
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

Describe Waveshare 12.3-DSI-TOUCH-A panel which allegedly uses HX83102
as a panel controller.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/display/panel/himax,hx83102.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/himax,hx83102.yaml b/Documentation/devicetree/bindings/display/panel/himax,hx83102.yaml
index 66404b425af3..7667428bf9a8 100644
--- a/Documentation/devicetree/bindings/display/panel/himax,hx83102.yaml
+++ b/Documentation/devicetree/bindings/display/panel/himax,hx83102.yaml
@@ -30,6 +30,8 @@ properties:
           - starry,2082109qfh040022-50e
           # STARRY himax83102-j02 10.51" WUXGA TFT LCD panel
           - starry,himax83102-j02
+          # Waveshare 12.3-DSI-TOUCH-A panel
+          - waveshare,12.3-dsi-touch-a
       - const: himax,hx83102
 
   reg:

-- 
2.47.3

