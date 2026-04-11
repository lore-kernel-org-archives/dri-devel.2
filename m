Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AB31F3ED4C
	for <dri-devel@archiver.kernel.org>; Sat, 11 Apr 2026 12:11:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8827710E1E4;
	Sat, 11 Apr 2026 12:11:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="XkJdHlqy";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PQVtw4GF";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8EEAD10E1E4
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 12:11:18 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63B41Mk33377139
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 12:11:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 RKa6xeChRoaH9uw0NWPjegEQauJVOAFpyTvUBF7c83g=; b=XkJdHlqyqNNNVJ0T
 JjR2ex2NYnd8z67RD/PBTYWlKq7fTF4gQvBIchCi2R5y4HILTn/+PVPKSI9+8YI/
 N6jHuKaxydlsG4+vMcLwyYKAGt7aB0C/yHWs+nOySWnD+lS03xr8vX937RjJkdbm
 LX7k2QxbGmIFJrMr78lMoCWM5/wzTcXx1KYWN1/4gl/q9p19fy6wgq82u9D+mBAB
 HD7sT5CyRawMil5ynPmjAkx4ynxInHCYEiR9zUkxhYOtg/GgxyKytYKa/srkhW6X
 Srvxi2Vxe2VXzMosqtfCa3Apq2h2GLmR219tv8Mczj/a9BbiwvoSJsT1L97unfip
 H2gDFw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dfewkrngr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 12:11:17 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-8d3bb33c8b8so603127885a.0
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 05:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775909477; x=1776514277;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=RKa6xeChRoaH9uw0NWPjegEQauJVOAFpyTvUBF7c83g=;
 b=PQVtw4GF3CqWp7n6tCp9yKeMSHMj0gPgO5l34YIc8vBoeF8er9WBinZ1EuHxRF3mKN
 OiIk/PlZuEaoz0q8gd483Klm7ty6HUAtWLXU1KCacodahXho5v61Yvl0yp7DQSl4dUxt
 d93Nks5wZXETD1hmvdv8ZnRUD1tJxJOmaIIKgeF2b90RF5rf0NHv51vP/b4H3R+UtUVl
 PxjVe109Ak+RhQDVbbTYy+W97USw8oTwBAfT7DIQpwUoZvZijGZbLOeOk9AurEAomIOd
 VSfREtzJ1ZSKd3ksP3rHhl0Rt9+nWQoxDMEPbmiC4Wlwda6kFpLT74pDld+xvFI2s2jw
 xBUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775909477; x=1776514277;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=RKa6xeChRoaH9uw0NWPjegEQauJVOAFpyTvUBF7c83g=;
 b=Q78HyXahWxxqd2sULI8ItH7y63OumGLOdvkgq5eULFCztfBZm3AtgGncseInoOc76q
 NyWpItLQpRB/w2eiMyInGR+EWLdH3lAtYLLnCUM7dBw0JpKxor2YNMz/hVoDlGdKeN5u
 JOOC8m4OVe6ejaqqmoh6kRopSi8Kiad1+ViAnnvgMBtQPn6SNmbqRE5aOYIwzGCtVWD5
 zy+zHDx5G7/sU7xhVNKbS+HauedTbIcnH5sT9iOmXYjNgZgqQAaa7BquIQ1bo8++0xyr
 +muVqYjBWbvsmjIpffXCO16RCVYt2zo2045oCj9p0wDhunYFp7I4kIaPWrqK/HGzjcyi
 UnSg==
X-Gm-Message-State: AOJu0Yx+9OilykFM0146H7LxUbDLEqQ626g6CZtJmdSFlwbTieFw6MxC
 bnuiqK2RKr+MIqASAJ8kRmOmHaXOCBtej4BoMxr+CXzV/cdvZF/tqjpDx8ir2Za+1wa92RvYC7l
 6/xqlGXi3oRxJpnbXq6KmynzXT/duGb20yBeJcLU8185LQMd7707/NXK+uvFSSxLMymeHeHM=
X-Gm-Gg: AeBDieue7HpAn8+YT2qqcVyast7gvFOdfdsVy2+53RLQ3w7+evWVpaKjkffLaUc7oiy
 AHG7zY+O4gZYNkOFDy8PBpEKHSmGqIL2icufyAt7fxHnWqC9az2V0fF7vIspKbY745baoZNDflC
 2fpQGk30fmgAF/kUHYoa2fS/0HKE+qCShQSr2TfqQxPxHKnDVaywv74tnDD8yb7rqMVMBG6n6oX
 4pzIjHrBMEIE2qUV46ildZI2Z5atT91CqIXb5rGhkypCtUX6cvlnq2YFdN2HjhIm/ve762U7NVg
 U24om18wAaK4nD8IhlXnfWH1ekT6f/b8e/NGZ5goSsOR5Wzc3beVDGWLF2VV19AKe4z/VzsJl5h
 V/617U7/C9U4J2hYWRM2zHb5kSHpjIAIbv0vm6N07TDLKUe3uhhWvxe3Xm5CRSHEgAeU8eg7vOo
 ZfVGtP/ULQYhpE/wMjN200/meStryio+EY4A8=
X-Received: by 2002:a05:622a:550d:b0:50b:2876:586 with SMTP id
 d75a77b69052e-50dd5ad112emr103796281cf.5.1775909477106; 
 Sat, 11 Apr 2026 05:11:17 -0700 (PDT)
X-Received: by 2002:a05:622a:550d:b0:50b:2876:586 with SMTP id
 d75a77b69052e-50dd5ad112emr103795881cf.5.1775909476721; 
 Sat, 11 Apr 2026 05:11:16 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-38e495b4e73sm11906291fa.41.2026.04.11.05.11.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Apr 2026 05:11:14 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sat, 11 Apr 2026 15:10:33 +0300
Subject: [PATCH v2 13/21] drm/panel: jadard-jd9365da-h3: set prepare_prev_first
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260411-waveshare-dsi-touch-v2-13-75cdbeac5156@oss.qualcomm.com>
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
 Riccardo Mereu <r.mereu@arduino.cc>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1074;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=ItKhX2Lojt9KIazo72U3GJYoHblfjFW2x10W7iSKuEo=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBp2jpGwlOUdLdYTrG2qMsikq5j9EIHjvVUbb/Zc
 qntYLYJwhSJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCado6RgAKCRCLPIo+Aiko
 1fm2B/kBk92iEqPsVJKR2/4lISThQL19zM68HkY3kSGFyWIo5pCnoRR2gmnIWYWgNjpV6lysCFI
 3gsLs2S2qhux43Cn2EoLEJp05js6ZYHqmGWXqnzpW04Y7GKfFhy8UHLsV4LTwxqdCCvxCjywl5S
 ha8NsuuYsDO3oDDIhXiQnKzEGPeTi1qThFHMG+9Bkzp21X0SaFvwkOwpIAWa0d3RMdZFTMUqm5k
 cV4a7v7eV74HJpLF/tSQGvKwl89sSemOm3tvkMP0in1PalkmpFC29Xarx8mNq9JUK72YuFGEsvQ
 PCWfmPdMRKH7dShTRjzuE3I4GN7mjMh9hRsHsStPodxzWa1k
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=bcFbluPB c=1 sm=1 tr=0 ts=69da3a65 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=ic6V0yA_i5s2A4o5CdYA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDExMDEwMiBTYWx0ZWRfX3pC5o6WC//Hz
 dlIsh9gxTsuqrvRV4v/VMF+r0woNeHPRnQ6mHwcONl56vTtv35YE2IYr/0Tzkliaji4s/sgGeLN
 s1xfnUMIqsulovrpZblcTHo0OtaG/ldF4v+YwPzs861qxfCa092Ez3bGMLwEZe5XWF+zf21aIJ9
 sKR7RBgOsWHZd8vFa839PD/q/XrEJWTI3pD5oowrXayUvJH7+7t1aDBynhP3UkO/snZOYnPRz+i
 apPYszsHSSgSkRLp4i1VN7rrdna4jYwgOqwL42T9XLHermZ2E7xDNZsl9N8W5YUtiYmS0V4Uizu
 lAGq+PkJVs6PZgEPgemH2Y1ywUdz+HCJTofMarKvXg6hBhS11P9v47yzDhofBMRcw4uLAH587tz
 FcseIIcW8VD7SfzwV9gPlKJ0LgZNkkNJsCJbHmvcpqvHupKWGy1aSHxjhMij4UpXrThDoh+aC4L
 VV75spQ5FpYqipP3UAA==
X-Proofpoint-ORIG-GUID: yTDRjhQYl5MWRrSaUsRdgg7HDCPHbPSv
X-Proofpoint-GUID: yTDRjhQYl5MWRrSaUsRdgg7HDCPHbPSv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-11_03,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 suspectscore=0 adultscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604110102
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

Sending DSI commands from the prepare() callback requires DSI link to be
up at that point. For DSI hosts is guaranteed only if the panel driver
sets the .prepare_prev_first flag. Set it to let these panels work with
the DSI hosts which don't power on the link in their .mode_set callback.

Reviewed-by: Linus Walleij <linusw@kernel.org>
Tested-by: Riccardo Mereu <r.mereu@arduino.cc>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c b/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c
index 5d9db2e1f28f..11b7e07c1af8 100644
--- a/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c
+++ b/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c
@@ -1652,6 +1652,8 @@ static int jadard_dsi_probe(struct mipi_dsi_device *dsi)
 	if (ret)
 		return ret;
 
+	jadard->panel.prepare_prev_first = true;
+
 	drm_panel_add(&jadard->panel);
 
 	mipi_dsi_set_drvdata(dsi, jadard);

-- 
2.47.3

