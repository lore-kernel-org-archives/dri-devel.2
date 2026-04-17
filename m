Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95414F99C6D
	for <dri-devel@archiver.kernel.org>; Fri, 17 Apr 2026 23:13:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC4E710EAD5;
	Fri, 17 Apr 2026 23:13:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="DUrVMkpp";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HfHgY7Nq";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A10BA10EAD5
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Apr 2026 23:13:08 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63HG4H984068739
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Apr 2026 23:13:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Ppg/BYocKMHGKMXDduQI/Ihg8vvo2kwlYswUyzAQZBE=; b=DUrVMkpp0MrrPyUt
 CLPOYilw3LlxFz46KCvynIAwRCUknoDkyr3QoIjiVqtzd5WuhU7BCG46Yd5OO+RF
 ziFJouRs8Xa+mBRtEuZ8vf6HIda5bjqZMrBja3VvHBK3R/3Nu0pW9oJKqCdvrJPH
 u4DkVX5bE90H923vJfwkBvLx7xXyJjqHqlyycTAy2ymlBbe4BuXcbRPa7Ft7luQs
 cJwb8NeoOq6HtgfURMjrWEbRjW+rsTPERYxT3KMj7oY47NfNI8jk+5dKcIgr90Na
 Sjbc4dqGXkObmxVdHLNUSprQCgWHozvNz9HvPsIH9GFlGAUxvSv3Xspv52sbAHES
 pmEUCA==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dkhpu2ka8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Apr 2026 23:13:07 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-8ac566014e0so35524506d6.2
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Apr 2026 16:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776467587; x=1777072387;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ppg/BYocKMHGKMXDduQI/Ihg8vvo2kwlYswUyzAQZBE=;
 b=HfHgY7NqIJPyObBmx26bVp9ZkDCzFz1sJJqzt6ixYcLGRLVjXHpSQIKk650C6FBpIb
 2LZZjR7Lb1xb9DfqgyQII7QTnwmhETAzHZL8oSF3M0fMU7p6JlTzBvPYwo85SPskOQbx
 ZCXiMUe9k6FwTzwmGOL1OXvvR7JJ3HqOhF8B8v8hGyyiAIBUmGSA1NxYKkKUyfSAcGUy
 aHbYCOuSIXRian7VPN4GNWoGdPe8pEehExLeH7SgCOBEqgogElL67hB5dFVOXMFoEh4Q
 re3rFT7IZcInA8X4WdI8XSgYKXdw2kVjN3kAUV0JaEojn2IxXSkBMsLYTkzMJ5R86xJM
 48hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776467587; x=1777072387;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ppg/BYocKMHGKMXDduQI/Ihg8vvo2kwlYswUyzAQZBE=;
 b=bM+bI5Zz3lSmpiFuc9k5sG487C9EqAUdzA6TWbB/Fj55i+sSDN6z5Q/6TO15qR9sKR
 nHUcv2d33L2WQvCa6DWqOyEoXO3FiLjNpEn3Oqc/3gkrZZT/bhJSwC2RgPYlaBISK8it
 1nU78UK0KzXkPllEfBXfmwLSLukWo8gL+9keApVF8qI0roXy6Ih/aSpHAllxPYmVElHc
 hhp5qDKiVl36AgmNu5dCar57cDHJykojoshBumPP2JosiiI3obKvOkdtejSTQCDzEqWt
 TcPAvxq4HaldlCK6X8LIdn+BL+bwzm9BzKI+T/M+pEi8TSu9ZHAkUoIswlmkiA+Jpki2
 eKzA==
X-Gm-Message-State: AOJu0YwqXtFW4QeownsJkBL+buhAhbi2WxeR1H99Lldj2bk6GZZtyZLD
 565xVWHtjuqxnzAbxo6RFgiyuFIid/Ob782J6ANZUBUfyi5AYAlU7aiZk9+laejQKWabfP57fDK
 pqGipZpOBOTmLz3jD9SC0D6QS3kLvWSpiMcoo1ALBnw5TLqokMP/FP4z8azHwzjqUEWNf7W0=
X-Gm-Gg: AeBDies4qn+ZMSZ7CxW/H8U5pFjnVPx4yY3vAPqbHjngLgIuZin/l9UarLKJBiJpHZV
 HWEII8OUGq0E6vF1K82dF47u9bbVN+DLViQh0zuOYOAafy+5yvtYgSMmJFh/BcwlJQ0JABIM3m0
 Xb3Cus40qoUrlxkRx37k8OGXup5MTahyszjmmQaWhGDZ9QMn92OxUtu4D9NUVG3zGPUVNx6k4r2
 WdSp8o4lT7LDtoCLeQH4XXXBY5Lp/AQVj4ODZnx6ZC1QhwhYIMI+CyLn3YKAwY6MnhBBSuQrf6p
 vAUUWcjP+Xb17ktuvHqwoKqXi5h2aynzV0OPxEw15BEZEDw4YQWjga+uNNAw0p7r/lpvnu2ImOs
 r/5CDplffbYwHdfS9NfmDRw/krTx+IYietH0JNOqVNf4FSib3bZZtaFNRTOhuw8Pul9aTPma4mP
 2RQPey80bdb7vGuDlySZb+6LqiJeTjlgWBHA7dcd+25sdazQ==
X-Received: by 2002:a05:6214:260f:b0:89c:5e33:2cc5 with SMTP id
 6a1803df08f44-8b02812918cmr85215696d6.20.1776467587210; 
 Fri, 17 Apr 2026 16:13:07 -0700 (PDT)
X-Received: by 2002:a05:6214:260f:b0:89c:5e33:2cc5 with SMTP id
 6a1803df08f44-8b02812918cmr85215146d6.20.1776467586818; 
 Fri, 17 Apr 2026 16:13:06 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a4185bc58fsm813306e87.30.2026.04.17.16.13.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Apr 2026 16:13:05 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Thierry Reding <thierry.reding@gmail.com>,
 Sam Ravnborg <sam@ravnborg.org>, Joseph Guo <qijian.guo@nxp.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Andrzej Hajda <andrzej.hajda@intel.com>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] drm/panel: simple: add Waveshare LCD panels
Date: Sat, 18 Apr 2026 02:13:02 +0300
Message-ID: <177646757854.2517306.15967451744879550584.b4-ty@b4>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260412-ws-lcd-v3-0-db22c2631828@oss.qualcomm.com>
References: <20260412-ws-lcd-v3-0-db22c2631828@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Kd7idwYD c=1 sm=1 tr=0 ts=69e2be83 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=XqiqF6kKystFwB6n1pwA:9
 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-GUID: vSfcuupO44uoiCBZqfc0POwAzg2VaU8A
X-Proofpoint-ORIG-GUID: vSfcuupO44uoiCBZqfc0POwAzg2VaU8A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE3MDIzMCBTYWx0ZWRfX+kC7q8CyzHMz
 IcwC4kbKgVhKjb9p4hGTtyQkv5kZwQRzrwVFEGuv8KFOS+ROtGHR9fZI4VyvKfexFoguol5O0ju
 tDz4nArzkGuuZBIY0IF9GzpOiuWWqU6PNhY+BVoPnWKkm5gyQ1j8Z8lM1TknE2zatGLUPdXGBJH
 Iyrek7GzyT5UaLJGzqNB56XmulmDnwlvU3NIw4RPDd8/P+Sq3iHpbhbo5vOwW6Udg1OuwD9CfO4
 AzWB8gYfxwY5YmQwZXCZp3QSI1VCceQr5j9Vo9L8MFd6d+xIad6GGVn9r1GsVkirbqvT8KRoOBL
 Qec+UBqVfAxZQjtQs3bLiTlfhwXJQYF0r3mzUni4tCtmDcUd8xvaDezJ2kBusMWgAHh+HO1E2Un
 PWoscX/zOs9qHAR7ulG5cF6+nvj7FlC8lSqFAnCGEM8SQdKkL6ofjq86wsP6kNsEfVWGXmJQXSk
 8wdlIBxH2jT9tre9BbQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-17_02,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 adultscore=0 spamscore=0 phishscore=0 suspectscore=0 malwarescore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604070000
 definitions=main-2604170230
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

On Sun, 12 Apr 2026 20:32:23 +0300, Dmitry Baryshkov wrote:
> Waveshare have a serie of DSI panel kits with the DPI or LVDS panel
> being attached to the DSI2DPI or DSI2LVDS bridge. Commit 80b0eb11f8e0
> ("dt-bindings: display: panel: Add waveshare DPI panel support")
> described two of them in the bindings and commit 46be11b678e0
> ("drm/panel: simple: Add Waveshare 13.3" panel support") added
> definitions for one of those panels. Add support for the rest of them.
> 
> [...]

Applied to drm-misc-next, thanks!

[1/2] dt-bindings: display: waveshare,dsp2dpi: describe DSI2LVDS setup
      commit: 7fd2875a932276926052652aaa44fd29a950b015
[2/2] drm/bridge: waveshare-dsi: support DSI LCD kits with LVDS panels
      commit: 17394e05b295e4936e0ed50d2f02ed7f08fd4f7d

Best regards,
-- 
With best wishes
Dmitry

