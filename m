Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 010BBD3514B
	for <dri-devel@archiver.kernel.org>; Wed,  1 Apr 2026 07:27:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 432D510EF51;
	Wed,  1 Apr 2026 07:27:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ib2/N/vI";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GVwKZ/Ay";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 02AB410EF37
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Apr 2026 07:27:08 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6316NeTZ3104026
 for <dri-devel@lists.freedesktop.org>; Wed, 1 Apr 2026 07:27:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 jXKe+OsCdQHPE3k51l74ZUAGKqzcezMcZ3x+/awxYVE=; b=Ib2/N/vICySJHft6
 DPp4OLoOVWXGFAjYxdeQLs/Q1/n2rDeknq0CC8uM6e5TB0ExEPuPK6YDrg7NHO7w
 EtYPnN+Emkpw7tmSCXR2tlv1eLGYIzFYC4fXoOU5vy93A8+6TuZVAzspLyhU7P2S
 hKxevVoGyPnDI94N5y3pT+b5rSSgvhJh0AY9rdmrsru41lWZpTIIDKNwjLxNr+jD
 q+EWiRMP3XazH0zAOsIGmSn5AcnROBmTUCakdwh1q19FZjKLzjPDQI1Zj/+mvObI
 nLsff0vnNDqMRSJHcu1LmueUNyfiRCuO6Du+Petpgko1xwWLhMXP9Buqzelzd+ty
 QbM9xw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d8js233h3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 01 Apr 2026 07:27:08 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-50b274f94f8so18615781cf.1
 for <dri-devel@lists.freedesktop.org>; Wed, 01 Apr 2026 00:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775028427; x=1775633227;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=jXKe+OsCdQHPE3k51l74ZUAGKqzcezMcZ3x+/awxYVE=;
 b=GVwKZ/Ay8cDcdu1BAx/ZXFs3APyNbq4r4JU9/ToRp4USEb7sFqZX09Ue9wpeldi3dU
 mVrinjVSgCS/svLI4gKb8tW7ewNdNMy9oz5Hb61YCcFyhFntI/eWyNwQTaktLwMSrdaD
 9+ghKhVAf0CRrkk1+FJmsH8xWYLlYAdMdrWiEdZHO/xW1qT1uI/6W+ryqkETV1Jnphmo
 zUFj0C5Aq3rLNUtx7i4O02pwwxzluJAVaamnCjREkO0XHo/NTeVZfrxmy3R9uF72VtT1
 W59eSsz9vVFrMe7GHr/KzlS1JDugBncrGlt5Ab9FVOde1QWyuJ5mXh/KHW60ZAtEskuG
 hESA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775028427; x=1775633227;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=jXKe+OsCdQHPE3k51l74ZUAGKqzcezMcZ3x+/awxYVE=;
 b=IGEYCQqck9t75g0OtM3zCvh+mp7zghG0rvwQEY8uxK8quIWBE7f2ICyvdsCkIsV+WN
 F9vEQ5XE1L6KEWXxujc8ENNd6Y8SXSf+dxPupdkMeNvdTPUoX4xSB/Slq8122Em0R6U9
 njoQuBRWJ3kwf2w4/bNUrycYCLVBDiPSWCuOHqmVroiZE94sPdVyeQWWGxs73Bp5OR3U
 0OU1E1JOg8/aa5g7YVv+rgmpppzxqBQ3bZLUKpI4WlLHEIMpHDQ9Fn6a7RVG/4u7iexY
 CIKKajntH55FGggA1j5ttWHwCN6WTAvjGWn3QlnCcK7UR9SKOEvG7GyU52ebT0rDm70A
 zbZw==
X-Gm-Message-State: AOJu0YyBxPKUlHBgPFkbpD7+MwCBy4c7N3bdfdBvozbUoixIpv6G+AeY
 JV3a93YlXEVpp6oZg2pEEuxD3OJeaB41RQbBslIgGp2gjedCJYPPJ0TfTYaCAAkiCShxUCR3FO+
 jGJCwcuRxKBN+l+wy8JcTgtd0zAAXYfo6caX6QaZ+P+r8JYT+wDvZFazKCaQDWPMw5vj04dA=
X-Gm-Gg: ATEYQzzhcJYKQuHtWbaSVDYuvR1WCFzVIJHlTsWrK2ZvBucAMTaAYyLFvpoyGz8E/1C
 ImNsGe+qLtWW7mto2QnWqve7dAgzGbIGFOhMsK6V+wZSc44Uqoh6pAAwNKfG2bV2nUemotHjJzA
 SHyx7Tl4n8WRQNhlEmu+toP3QvpK91nnASsLThrHnTUdM5+SN5ADmMXcgxHwzkc+Pa12gWNbXWE
 Ub1W1v9/0Qq15mByjlDaDsHlzgySYBYvHvIr3VwyHq57gKuAi/fks01NRNbhvv6krEqiZ2zJheI
 PLtR/21tpROzHd7WpD5Lq4kqApIiMiOvv3yC1AfrfvhtGjEenks3ncu8yIZeX0/AvHxhQUg51QX
 eHk4mz2S2M1sFpumHu69VAfFewQTDBjUKZD4JyvfECxqaa5PjKSIex9uJieaMchSSQy99VqtaKf
 C64HWCKHWbUOB5ON1SGHxWVhg82N7KJI/psMg=
X-Received: by 2002:a05:622a:a045:b0:509:144a:43bd with SMTP id
 d75a77b69052e-50d2c5b718bmr62318791cf.3.1775028427588; 
 Wed, 01 Apr 2026 00:27:07 -0700 (PDT)
X-Received: by 2002:a05:622a:a045:b0:509:144a:43bd with SMTP id
 d75a77b69052e-50d2c5b718bmr62318551cf.3.1775028427210; 
 Wed, 01 Apr 2026 00:27:07 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-38cb9f31972sm8638421fa.12.2026.04.01.00.27.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Apr 2026 00:27:05 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Wed, 01 Apr 2026 10:26:32 +0300
Subject: [PATCH 13/19] drm/panel: jadard-jd9365da-h3: set
 prepare_prev_first
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260401-waveshare-dsi-touch-v1-13-5e9119b5a014@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=978;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=Jb08fm0uAjy2z0dtmhiX4xlViALafz8SI/Bl5/q0t+Q=;
 b=owGbwMvMwMXYbdNlx6SpcZXxtFoSQ+aZE2v3XClYbuEo9EL3Uo3ljZ9ilmsXctuum+ySvvOWt
 3t3drhAJ6MxCwMjF4OsmCKLT0HL1JhNyWEfdkythxnEygQyhYGLUwAm8oeB/Q9/5TS9k4oHQ30M
 0x9lH5nk0sioV1018Zy9Z8YaaYaHLPNcmxlW9Nmcf9TZe7MoLOWoWp6Ewp/MFQahfax/rxcJKba
 ccDNx7V7McCEtymDZ937RqJ/V0/SFP178kcrCtjjj7BQu3cZHPHlB68/9TtSXZgtYbLKgylFbrW
 rVnh3NxrV8vK77J115zL7+Y6Pep11WLkwzI4MzL0px9bekC283++tzYItDduiTPv7vu5KYzpWmv
 1pr/mzdPl99thK2lC/tuTJP7hd7PduYWuTHm8MoXFdVpbK2i9Fg3Z7wgB9KL2ROOmcFzdhfaxJ3
 Y+e6DUaWv6K9mTpF69gDY37euvzq8Z+zmfEWrVX8U8sA
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: W_AUb2xBoP5n5Kf-pr3Wqzynwcmwszyf
X-Authority-Analysis: v=2.4 cv=XfqEDY55 c=1 sm=1 tr=0 ts=69ccc8cc cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=cd2vOsepvhAVWqutC0UA:9 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAxMDA2NCBTYWx0ZWRfX8o3YWZ+m5JLg
 wW7MmnelY0mmS3bRy3ihfzyueRYmETL98AHDBJoqVHY7w3n8PKYDCMhWDh5583jtgTFy7KAIfWo
 eciKoBsowiXsQt1G5+nh4gxJNYt917PEmcIefrzCmxSNkqGZCwziLy3rbiWwAfZINHgkwIWeH+k
 TJ8X3LaUMdERjAKilfPMDs1irFXVVBEcLVvQVxBFAJDXDkl+y9e6TfGk39TZoJKH/7AsY2nLMcC
 zfsyT+wYJRg6SzNsyONYNNg55m5Td6lKVsjhjfPErqNPCO+kJAOL7sds3tuhRBTaeZkCMW2F2Z+
 20Bys+M4IwrnYCt+L9BKlr5DL069hsTXQW2BJOeXO6sJGv6wpLUyNRMfkX2F4Qmbo/V8ccHeCw3
 vXj0uRjd4PGaEgTJ2oVIESDPxrvV2oN+8/TmforRGFyhDySJ7ngspfCQ2LKDq4/kF+ryHdgUva/
 RHALw6YtNjloEFmSEsw==
X-Proofpoint-GUID: W_AUb2xBoP5n5Kf-pr3Wqzynwcmwszyf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-01_02,2026-04-01_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 clxscore=1015 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
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

Sending DSI commands from the prepare() callback requires DSI link to be
up at that point. For DSI hosts is guaranteed only if the panel driver
sets the .prepare_prev_first flag. Set it to let these panels work with
the DSI hosts which don't power on the link in their .mode_set callback.

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

