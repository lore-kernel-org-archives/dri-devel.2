Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B10606A31E
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 23:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=PMxrgm8r;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=AjsSqJQw
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 99A5F10F8E0;
	Tue, 24 Nov 2026 23:13:49 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DCC5E10E5D4
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 23:13:27 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AOMaa9R3520031
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 23:13:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 KnYVmklcEKzX5HQD3rqpVe9Q75aZhNP7IaHm1JDGDZc=; b=PMxrgm8rijRevEe1
 hdxwShTzJF33m1F7TB4f2HS5e2h0kfu3Fk9Ng3/ubb/Lif6OUKy8m1LCVtz+sRb4
 CytfypEiYG738XfyHAO5X4I0p7nLd+LNG1BmJdqpBqSuhauyQlfogMlrPCvYorhP
 0VUOsWJZiXqi4DON2umfxspXGLzrUwc3zSd3EDokhCeoUHZJBkizPq1trarldAe7
 PmzkpC5ggZHD1epF8fXF7K9He32e375C07pXL2NnFGMkppbpI81FJttuQgFVVa4R
 6S7X7WTi3gnqdvYJK1+wo9NOLFcrZoY/HuoT+9LsMFfJjtqj5ftzLYil6A8mYzen
 5Xy0Jg==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j5f00h862-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 23:13:27 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-91256a7b7b3so76117666d6.2
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 15:13:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795562006; x=1796166806;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=KnYVmklcEKzX5HQD3rqpVe9Q75aZhNP7IaHm1JDGDZc=;
 b=AjsSqJQwtkXuR8k19r0mfZfdVF3aWa4sP4yrNpo2QyV8bijbVYbFtpUy0r98TKdfsP
 4ONU9wiNXuetKFFKVTMLNAX0aHU5ZD03cC4gKS1KN6Q0qwDEnUD4FcpQ7yLLZyr9yJM2
 QUYrmVgsljSPfqpvYUTBI5Znct7I+IZ5KwAmgz4rnqvBoQuw+TqJT1hoXjOkexLmGJQq
 jBuBMBU3L5lb6OuN0xGum5WTkZnPPwZdXWP6iun/9B1Db15YdK90DwKiOnZzviw0a2fi
 qJ95vY3FRTMO3TYdLcjSR0B+VH43YqL8nnbNI8iKEjBR3t8+PY3pow95Gjb+ELVXGaKf
 o6kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795562006; x=1796166806;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=KnYVmklcEKzX5HQD3rqpVe9Q75aZhNP7IaHm1JDGDZc=;
 b=aWUnKuMW720t/RqaAEF+Z1/0G+GdkbsvkubZ0gVEo1ZIjP6tiunS3GXvSrupm/gpPM
 wFpQwPxZpBp3GjXxBqsxu7edCK19INvzdrQHAA3yM6qrf/W5M7y/disrd0Cuh0R5F5pf
 E9atuK4TuFrhYfouA7QzMo5ypg/YDjgQYORYfyJsI8/QDDG8+LSYOSbrxNDhVZD9hnrF
 QU2ij93fkLELKNPP8YzF2rhMtVenL0eIhePsZVgfJ8kpLjPyR7SNRkxJhJir/+YGCfzJ
 XXXAbhx1TdVf3DL5Lz/CvK6BEfBGWFKQwiRf19Q+84fAP/EhN9DIoEAs+pDzHImkCtpl
 g3/Q==
X-Gm-Message-State: APuU4Z/C/VIA+bN82SeD9REs6DH+6rmmjzk67vCSo2aaQipj5RpY6pDO
 /c5Ey/gtccZgJ2j/Lz2e9tbgRS52ndDvujaZ5Q5ka+MwhbgoF4/lQ1bmLpD3bw1QBe4nyef93fg
 ljsjAKhfRprZD3yR1llQ06PWKyTdw6J1dnVJsTiwZp7sgd1PRnx0x2fWGnl69GZi1OeEM7Ew=
X-Gm-Gg: AZFdTZdt5ZvYtJEybPSTsvHQGabpBxVtNmm0na/bxrcrkbJvU6qzCgLT2v4QGBNiajb
 iQ3g2azefCtEH3gNkzCr3sptK04kwQgjjyKzzV4PndnIWD+Z9W1v7KgwpEy0pt7c7rBf4FCf7rN
 feOySjgBFs+xpohGS1SdS8hFXZ0aheohL6nkWX/MyJqoxZy0g3ihBjepyQ6CaFBjYOvr2d1IC7S
 fivDJnRdXSzIK5tKXt4f+8uQOjSMLRaZw8EuEi0JWsTOqkkXBwXh697RlUM4tlq7PnOONXCpKmA
 5477np9izaO2r+QP9e2QfBO+L7st5WCRTobIU9d132dAreaH92DQUgUQLFPQZ8s3mMB82XoRTdc
 3XoIFPhTNtI9vZIwHxPheAQIh6rx6WIYzWBtuySd3Wji/dbO3yLU9dovhz7iHspEtMU50BILN+1
 3RcO1LFlpfcGBkGP7jNYH+3DhqDOA7Oa7+60t5JPcEiaEB/vzEzAh/6T6G3ATCag==
X-Received: by 2002:a05:620a:4626:b0:93f:1936:b229 with SMTP id
 af79cd13be357-949bab30868mr2963549785a.77.1795562006180; 
 Tue, 24 Nov 2026 15:13:26 -0800 (PST)
X-Received: by 2002:a05:620a:4626:b0:93f:1936:b229 with SMTP id
 af79cd13be357-949bab30868mr2963544785a.77.1795562005689; 
 Tue, 24 Nov 2026 15:13:25 -0800 (PST)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3ae8056b207sm43708401fa.37.2026.11.24.15.13.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 15:13:24 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Wed, 25 Nov 2026 01:13:15 +0200
Subject: [PATCH 1/2] drm/bridge: lt9611uxc: read the flash back in read
 mode
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261125-b4-lt9611uxc-fw-verify-v1-1-7aed8dec8018@oss.qualcomm.com>
References: <20261125-b4-lt9611uxc-fw-verify-v1-0-7aed8dec8018@oss.qualcomm.com>
In-Reply-To: <20261125-b4-lt9611uxc-fw-verify-v1-0-7aed8dec8018@oss.qualcomm.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sam Ravnborg <sam@ravnborg.org>, Dmitry Baryshkov <lumag@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1307;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=gr54EZil4PL/PPKq1UdQmO2RRJWRmBbBqf4s1gcyU28=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBrBhoR4tY+PNCLgfQblSdEZWQlmIFmhzM2RdTei
 xnywX3ZJgyJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCawYaEQAKCRCLPIo+Aiko
 1WiGB/9arMxG9H8EbVzFJnlAWzxI15/nLYEPyzSI6grUL89OvJDROKm/mLvhlQchuzv6qz4W+X1
 ABWg9Xr8F1I8qIrPMJvFuaF2MB6wr/gJ59YTXVrORKThiVnkozuBLnhW1vFll0cuOzP+OFZzmGS
 BkucvBaWYkQgQTOh+DoHoqovb9VfpTiB+YTRTwGCGdInuHOG3LMrnZYoHC/Nxwv+jOwjSHNreS0
 PXhKJ0JOfY6m4VZwtmlOirY8uAHfenBRiJ9EibY5wDzkC25x+17lP3lzjR6OFMSlpB4YhKaqRZg
 Tw6qdVcltVKPpE/Z+EXXHTXoA2yu9j3N3BHnbTv9vC0TJm/Y
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: 4PkVTH4sjxbOYOCM01XiZcNfucBvJa0n
X-Proofpoint-GUID: 4PkVTH4sjxbOYOCM01XiZcNfucBvJa0n
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDA5MSBTYWx0ZWRfX7P+wXCy+PT5V
 yvkICcRBXqGtoyrf/hwZzCAzoJndkDD5ItEzHLBlBgG6pCIuCvGSbKUtIR5wCD7G7zy+EN0fMTC
 UJGv2PkYiyb0jalmFceasTlHfcHibSE=
X-Authority-Analysis: v=2.4 cv=JqtkP84C c=1 sm=1 tr=0 ts=6b061a17 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=U2cYV8cVrZmoYxG8c0kA:9 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDA5MSBTYWx0ZWRfX0kx7gHtIye1e
 7574psDqUNbb7buPVJyQr9N1r/8SBQ7jfzLg4Y3tHoqAybyj4t3ecPOHJM5hBz68nmwpriv4Uhx
 VlShg2D9hD7FBAmQPPN/5myEzByPtX+NFSfMroArID1MyPP3bMmIXdD7fbIPCSpSzpLH4tJ8hNn
 9XsUf6JIUDiSaOFKBc+5iODN/f/vsuHgtwyEhrfO8HcMt6qTPSxp34jHUdZ7SJKVkVcZUE3m1Ns
 c2UBT92C7v1r82oBNMhlu1XCxDeLh0MnLSJzgClAthUX8NBkY33Eb0loFE/Zh+TQK+FA0INBcJn
 1rCTa5JVrG7OxuW2c+4FBw+wrRjMHKuGi9YzaCoNUHsd+2r6jtxw65FCu4OZ4aBJI8qi+RrC5tv
 q8aSRttlBu857RAEnWhVMhQJRzDB+cGRAbea9jW2nmJPyVQEagsZuBRSkjd6G9B1LxIUdV85g6P
 iZFzjH7VfCopuMA2elQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_06,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 impostorscore=0 spamscore=0
 priorityscore=1501 malwarescore=0 adultscore=0 clxscore=1015 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611240091
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

After flashing the firmware the driver reads the flash back to verify
it, but the read-back never switches the flash controller from the
write setup (0x5e = 0xdf) to reading (0x5e = 0x5f), so the data it
gets does not match what is in the flash. On an SM8350-HDK the
read-back differed from the image although the bridge came up with
the new firmware afterwards.

Set 0x5e to 0x5f before each page read, as the vendor driver does.

Fixes: 0cbbd5b1a012 ("drm: bridge: add support for lontium LT9611UXC bridge")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/bridge/lontium-lt9611uxc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/bridge/lontium-lt9611uxc.c b/drivers/gpu/drm/bridge/lontium-lt9611uxc.c
index b3bb7f2cebb3..6a7d479e86f6 100644
--- a/drivers/gpu/drm/bridge/lontium-lt9611uxc.c
+++ b/drivers/gpu/drm/bridge/lontium-lt9611uxc.c
@@ -587,6 +587,7 @@ static void lt9611uxc_firmware_write_page(struct lt9611uxc *lt9611uxc, u16 addr,
 static void lt9611uxc_firmware_read_page(struct lt9611uxc *lt9611uxc, u16 addr, char *buf)
 {
 	struct reg_sequence seq_read_page[] = {
+		REG_SEQ0(0x805e, 0x5f),
 		REG_SEQ0(0x805a, 0xa0),
 		REG_SEQ0(0x805a, 0x80),
 		REG_SEQ0(0x805b, (addr >> 16) & 0xff),

-- 
2.47.3

