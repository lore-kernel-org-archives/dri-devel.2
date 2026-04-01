Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FBFDD3514B
	for <dri-devel@archiver.kernel.org>; Wed,  1 Apr 2026 07:26:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6BBE810ED92;
	Wed,  1 Apr 2026 07:26:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Y4wX3cMy";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HOVRzqrT";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7884810ED92
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Apr 2026 07:26:50 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6316AWsP639150
 for <dri-devel@lists.freedesktop.org>; Wed, 1 Apr 2026 07:26:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Yu5MwmsD6H0oMm1hsBHM+snwkT5wJGW0nrEZxLfZo1A=; b=Y4wX3cMywAr79oQ3
 YD1uPEYEz9L7HbIRy2n8pFCr3M4vtc82encLhHN7MlyJpZ0rCk2sQ630SlT3Mnoj
 TVZEYJeBZbs2Ek1s8uCqwzam6rpK50aacQ7Mw8dzzDq1q5uKe2VhO7nXDweeDmKh
 67OFuKqhP9meBLM4NYGLk1Y4hmKM9K8F0hm7nHTGaWH9SbZs0VM/XVroj9F1A0JH
 fyoxyHz9Bn/c86xSbk8foIWuIKvmhah3JjmN3listc5l2T2zsfcVnoa8wXXHorxR
 zt/TeEjjPu/IUG+BCfFB8jvZWvf464hIAK6RcxFdvpKvXnnYU0PGzB0mJjJqu4/k
 SfOyUg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d8g2auxcv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 01 Apr 2026 07:26:49 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-5090cc6a7d2so214967951cf.2
 for <dri-devel@lists.freedesktop.org>; Wed, 01 Apr 2026 00:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775028408; x=1775633208;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Yu5MwmsD6H0oMm1hsBHM+snwkT5wJGW0nrEZxLfZo1A=;
 b=HOVRzqrTEbZGgBR5uAWzexHFkFhCNAVEJT9Hg6ebeLnyE9XMQMuKBR6Tizasr9qJl8
 TA8LIAy71qUU8mS2mtwpv9yF/zoBuiepjSb7iG9x98uRIS+cW1G7jeYkW8w8nvery7yJ
 3ApU9dA1kPLG7Sm+HP64XI5UEGTmIa7U2P0I2DWiwfv/yi8Ds7IYbznqnWFuLMPSQRDH
 g+NjmuoDQPhm5TxGGw+VjRsbSjz6CiI7WFJ2gD4CySAjsq61zaDauh3n0L7KE8bDk7/n
 JzEMDo6ZT3Go/pKKAjq6u/AFvzfRRVhNsK4F0Lb7+LISDcNtGI0M9PvKIg8kqlLmSchC
 OFqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775028408; x=1775633208;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Yu5MwmsD6H0oMm1hsBHM+snwkT5wJGW0nrEZxLfZo1A=;
 b=hEnMJ0iZzxG2HwP8dp6wi6cCV3t+7Kgy1Rw5fESJlmumv9MFrrds+oDSNw8znjIvDw
 FcsGlQcbzdXRDbdRtqaCTlc17iMzPHr3P03J91RVfs4ByowY3fG4Dx9WGGlNJYJacRUE
 2yzDnm3Kk3kUDpPrikyYoSM/kC+1bg7wRwwvvYXJJXXZAIIvIazt9cEwDiJ4JdIw9WbU
 8pLpIEWsjOLmWwhoYTmvuVkMiIkDe666F+o2I0dCkPmYh8rVHKgSLcE9MY3BE3WobcVH
 Pw5hNxij1032mkZrp9pP9HttzGHc4Keqjin+bHof/mSEu4Zje3JwiGQe2KAlqQQmrhbU
 mydw==
X-Gm-Message-State: AOJu0Yy+xc+T5G6U3aaUJQKK2OUh2+5dZannoFlS/4jwVnhnQ8hW/tVI
 9pceGGF9OVViAAK0Fd9T+3X2lE9F3GEkWn1Rh0Ssf+cwqu0ccTOv9OQ1UzMs/7KNNr7woTT/+Tq
 dJDfopfNZLj5zV0gamrgZa1508cRB/AAY5w6mndPiT0CPvVg+xRtrOVjJoq5DiPZ/4VzF6EY=
X-Gm-Gg: ATEYQzzdOUxqegCLDBtad8yiHpVVoSMXqnL7suFghV5j3NJ5D7wvnb8YqUKRIc4uCaL
 IoMER5FIEMSqshvVcSjnt0Jp9B33UZJfJcoOA6l3lwzoDCA+JuJMnDJnE5aymrXP3pNKvKpGuHY
 mlzlIKIh/huPfGKSvaeQdNlWJKlMYmoHTRvTyqKxgfvmrYhN6kq+iuW8/ECiWlm2O0lgzbmqeaD
 nyUrNgad97ZFoivTm49tcsLFti37JtGdPYijdSJLJu57MqrnRsY5UsfXADULc1meK7uGmCLXFMk
 z4Nhtx8eUk0T5K8zfHcXIduwfWLlevklcIdrLZ20wl+q7PSvuVQq14pK0Di7cvkETxyKuI6Ntj/
 tOOiU3qG4CJnAB73QFY4GakXd1YuQG+B+6CWNvGuqg8+bKdjSfqQdYtx1wKCxIWUC1Q+HPOByLn
 6PRvyA0P74++HqNoPMe8wcIEuVrabWcus4uPA=
X-Received: by 2002:a05:622a:134e:b0:506:a289:fd3c with SMTP id
 d75a77b69052e-50d3bba7d2cmr33948901cf.17.1775028408426; 
 Wed, 01 Apr 2026 00:26:48 -0700 (PDT)
X-Received: by 2002:a05:622a:134e:b0:506:a289:fd3c with SMTP id
 d75a77b69052e-50d3bba7d2cmr33948751cf.17.1775028407985; 
 Wed, 01 Apr 2026 00:26:47 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-38cb9f31972sm8638421fa.12.2026.04.01.00.26.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Apr 2026 00:26:46 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Wed, 01 Apr 2026 10:26:23 +0300
Subject: [PATCH 04/19] dt-bindings: display/panel: ilitek,ili9881c:
 describe Waveshare panel
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260401-waveshare-dsi-touch-v1-4-5e9119b5a014@oss.qualcomm.com>
References: <20260401-waveshare-dsi-touch-v1-0-5e9119b5a014@oss.qualcomm.com>
In-Reply-To: <20260401-waveshare-dsi-touch-v1-0-5e9119b5a014@oss.qualcomm.com>
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
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1138;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=9BUAPXzA40V6xuiE1cTes3j3rjDbHWpL9QzXZmTLuNE=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBpzMirrOKHHguZib7Qm6juGjzf7VRKFXqhi5BrR
 yH99FUuX+CJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaczIqwAKCRCLPIo+Aiko
 1VJhB/9fEHyhsyKNE61PLHs/8O6b8870lRBQbab7Zn44gpywX00gsld6suPRXxIzjBh6XGUgcLH
 S9PQYyKrqzMfXQQmXjvvtAvWfj5om40XojxzHA2mcuvDWMJSmTeZ1sstCDrQiuVXsr3RlMNSW53
 3civh+M5nEGRvSqmJUhQOalaEHJ7DhqhQNZLKMIqTk0uqe55hMOOFpDu6QGBw3WuiAw6ewqroS2
 TyC9iVpjbPQZiPd4a9/uqsj/Xutp4Q1yAVxjRk9cgPqjaM9lukv2gdvqxAoA/d3cqm/O2wG+OYI
 5UX6Wn36VdacrouZsDcqRjhKllFNhsTPLu87X4MKg5BiVtax
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAxMDA2NCBTYWx0ZWRfX8pwKyafQYhuc
 LHq4Rlo+HzbKf6JLV7t0BFzrhJU2aRGVwh6ccIx8ty0o6vqYbk13ZKJiqa5xirbqajpPNU8P+Yt
 M8CcP331Hl5b5pVhM6yQLeDaz3v/yi+HwNtDHvwd4aOegZdaqlYhAGqZwNxADBWY1PpA4XhJD87
 ch2zapXDKcnQmENq/F/w9bE8U+cgLF5nD1fwG36odXt8Z5v7XRN3hIhIJL8GSggpPXsu5NhoJET
 nkPOPY1/5pDH5DqCTd6y2DZ6ri0OmRAfFRj2zSPPiB1OGzAQ8YjsNyC9YuCGvfhuyWPIwOaZVqj
 hwxW4ErDwo+ySw7kRiBe/Ti9xPkz2yIswwfjIumzHovSLkI4QNvdD1NZ30WCA51p9T2ywvV/NVh
 M1npznKMJ/2/djb0vIItkCExfkvZmsYECeKz63chluSRVDJe5stcXle4NfA8vN934g1Var4zARL
 BlgjoESYZ7nTz/hJZgg==
X-Authority-Analysis: v=2.4 cv=G4ER0tk5 c=1 sm=1 tr=0 ts=69ccc8b9 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=sGmTDZJufn-iKI-mlscA:9 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: 7YxjHGPkRUO7q9mFfG5ztlTFEUaqDhsR
X-Proofpoint-ORIG-GUID: 7YxjHGPkRUO7q9mFfG5ztlTFEUaqDhsR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-01_02,2026-04-01_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 malwarescore=0 adultscore=0 impostorscore=0 spamscore=0 phishscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2604010064
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

Describe Waveshare 7" DSI panel which uses ILI9881 as a panel
controller. This panel requires two voltags supplies, so add separate
iovcc supply.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/display/panel/ilitek,ili9881c.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/ilitek,ili9881c.yaml b/Documentation/devicetree/bindings/display/panel/ilitek,ili9881c.yaml
index d979701a00a8..42e35986fbf6 100644
--- a/Documentation/devicetree/bindings/display/panel/ilitek,ili9881c.yaml
+++ b/Documentation/devicetree/bindings/display/panel/ilitek,ili9881c.yaml
@@ -24,6 +24,7 @@ properties:
           - raspberrypi,dsi-7inch
           - startek,kd050hdfia020
           - tdo,tl050hdv35
+          - waveshare,7.0-dsi-touch-a
           - wanchanglong,w552946aaa
           - wanchanglong,w552946aba
       - const: ilitek,ili9881c
@@ -34,6 +35,7 @@ properties:
   backlight: true
   port: true
   power-supply: true
+  iovcc-supply: true
   reset-gpios: true
   rotation: true
 

-- 
2.47.3

