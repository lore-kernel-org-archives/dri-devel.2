Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 139C4CD4F21
	for <dri-devel@archiver.kernel.org>; Wed, 13 May 2026 18:19:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7195A10E33A;
	Wed, 13 May 2026 18:19:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="iMqN3oXu";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Npdvb8oW";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A3D810E33A
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 18:19:57 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64DGAvHW2524359
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 18:19:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=86WeCNAejDxittTf8pYHzI
 Nsa57NdHN4MSF3esmZSyQ=; b=iMqN3oXuWE+5ARgO/ivHL2Lr7d6ctJpGHOocoy
 kZgNlA+HYvQIUXPWwuk81Za2wzwZ98Mn7cvgAFg1wvV9nWQd4DG1sWc8GcrSS/qC
 aqDXpwGG7KETBHy79hf0+XpgEfgG8066NoSeURjwpaeYwDHvFoozhYtVqH7QAtov
 3RWFAvlInxV3he7gabP7BVI3AfA/71/9wQNrVlmtdwX+BUXEzTaVdfKjQjPq5J8p
 tDxtxl5qIOW9ThGxAhkxfk5/LLv8r7Um+jCvpwv1Me3UApow8Xqt1mZH207Egl1M
 YHahdBkDcjhKJMBUqGDaHsQdaxmpvV7LdPy8fo+wHkfVv/Ag==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e4vkjgh3a-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 18:19:56 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id
 ada2fe7eead31-631a49033bbso2464457137.1
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 11:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778696395; x=1779301195;
 darn=lists.freedesktop.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=86WeCNAejDxittTf8pYHzINsa57NdHN4MSF3esmZSyQ=;
 b=Npdvb8oWck9we2SbothRhA2SKtS4KgZM4jT9ksu4ihUG60qfo6lLVZpuCTMBBbBuwB
 MMvGKOnNVmIt/pcBgetoeyga9/2CYVY9dA96m5+kq2zRuwVGs5FxfbzJoZMArEA/63Jv
 dODJx+mIYz4AhG8fLJnUPv3ufBMsdD1SAHkIiu5nSGXw8rEcLdcH+fiqHFbgKm40UUz/
 HeLE97yGLRdpsQqEI3qdpTQ8JdN+b2ANlGhH1M/iefxucGVirO2bcwfW+8BKUlMYby6F
 DyBGytKOoCHz/IEEMFbDtay75mQz9CE82obgVg5Ll9Ink3mfKyIrhDCyKOGRuUqHwoXo
 1T0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778696395; x=1779301195;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=86WeCNAejDxittTf8pYHzINsa57NdHN4MSF3esmZSyQ=;
 b=NY8xaF+rOzrEm3iS6oFMY9JgzMTKLDDsD39M2HEOUdBfNWma3e0MIE/YqggKfSTmKw
 zgnULyrkf7LPMb4x5USXyjY2CTObA/Maaj6fAOsh5kI0NkTBbc0Bg2o420XESq6mu6Rn
 /YwhAX98EXBpevhepcLqCK9hqeT9DjxWXYDqSuQLFvYta6n6Qy4xAYGirQPbT3wHNKLb
 bWr/+wzvwKSFREq2spiVRljtqzQ0U+N8VvdAh9rhvFBWnT42XO36UCsQzmP1D+QElYM9
 1Jn8ZqC9CwcUqBR+awm4GogsEal0bfeh+c6Xe4oEGgWuu9sf70C8AVxAyvs9RR7327tx
 HJ8A==
X-Gm-Message-State: AOJu0YwpMbaO8sWydhpO0F2UzfbXj+RGBivbaNF5mKmwZMgYQyATWm5d
 T/gtTsnAMRwmZKKRSa1z8JtPs+Y4B+SZfN85CPg9Dukeb/PyPdTtsD+xHeNfN2nVfRY7ieUEGfM
 PBNq/l48MpymtEvzBnkG75alTIOQz7/BgPiqiBo9bRNYe+CSQZggXQUsTXUF9qTyIPvfgLR4=
X-Gm-Gg: Acq92OHE4hBWiNfj445InSBLN4uUU8oPL9sgcrX5O/wrj2lBwMg+1r7sqkK+zn4uAO2
 Wimf2G1VvAP86anBVuf9HvLHg2/DxDg1d6OYYzMPGfudKxjX17m0LvtW5LhzIcDohQZR86YSl5t
 7e5EUKDjKSp7yhdGcCirjXhtSGrC55AUT6tbXg+2MV4mDdBvVTNkW2T2bc2+8Zzt9y2jeVf57Dy
 Y6nAtRIZsmyZd1FnFt0nafBG8u2tEilBVnF+BespxHPs8pGMbeq19BsYa2B+qBGoCT8T4C0Lnyv
 wROSPfnWCXuX8xN+5xTKWLo3wyI8on9uHX9ab8JvR6RAiPiwVRcgCqbwiuS2K/BbX9X4KfrjWq8
 ueDINqGhj5AVDMSHH3I99pb1orNhMBy5Svsu/SBIZ6uQtVRwKRkbysJODg0+rQwyLr5c5iGc/bu
 JZqAm9Mbnb6zykV0Yj4EbqbHeij1OxDYEScgg=
X-Received: by 2002:a05:6102:5a95:b0:634:16ce:aa3b with SMTP id
 ada2fe7eead31-637742471fcmr2526473137.15.1778696395439; 
 Wed, 13 May 2026 11:19:55 -0700 (PDT)
X-Received: by 2002:a05:6102:5a95:b0:634:16ce:aa3b with SMTP id
 ada2fe7eead31-637742471fcmr2526452137.15.1778696395052; 
 Wed, 13 May 2026 11:19:55 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a8c6f78bd7sm2685271e87.74.2026.05.13.11.19.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 May 2026 11:19:53 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: [PATCH v2 0/2] drm/bridge: display-connector: detect DP state if
 cable is plugged on boot
Date: Wed, 13 May 2026 21:19:50 +0300
Message-Id: <20260513-dp-connector-hpd-v2-0-42f757bfcbf9@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMfABGoC/32NTQ7CIBCFr9LM2mkAG6quvIfpog5TIbGAoETT9
 O5iD+DmJd/L+1kgc3Kc4dQskLi47IKvoHYNkB39jdGZyqCE0mIvOzQRKXjP9AwJbTQ4CX1kra+
 kxwlqLSae3HubvAyVrcs1+tkeivy5f8aKRIH9QYuuIzYk+3PIuX28xjuFeW6rwLCu6xeEr9kPt
 wAAAA==
X-Change-ID: 20260314-dp-connector-hpd-f069e66bc6af
To: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Tomi Valkeinen <tomi.valkeinen@ti.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Sam Ravnborg <sam@ravnborg.org>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1288;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=T6gl1G8mNBxC6GUjnrGXd/VItsLOY+FnUvQS8uwd8EM=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqBMDJrMh0MomyKdTl1ouygmX851e5TsaMUl0Kr
 c5898jLimOJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCagTAyQAKCRCLPIo+Aiko
 1c6oB/9szTn3Z5mMkOtET/qFbcjx71B9IW1iLm1TSBMXlMAbTeFxk2Sn6b56Py+RD1nFQqwP+Dx
 2dggpi4B7GLVgZSku/rTOE5Av/WNWxP8+edZNGlIIvPzB2VP7fdyNelezF/X+qluaY4ce33oebM
 jg6dJmojTvP5WDPypN1KGL5rjZi3AYfeSsIXNxFRQ0DFux5tizn/agbJ1muWJPSBH6pktyXzGxn
 udy7ryhg/WzlL7lHfXNvv3KqX5AGaTg03U1rUH6w+/JnmiFd2QGxr59WZmB4ZmNuVQZ9MvIWQwo
 Pk54nWdx9ce4UHUC4zIv2OsOWdOZCjQlA6hht6woIn6bnJab
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-GUID: _1CVrj8EGIlJo8kP-kX1kljzMdFMQm5e
X-Proofpoint-ORIG-GUID: _1CVrj8EGIlJo8kP-kX1kljzMdFMQm5e
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDE4MiBTYWx0ZWRfX4FozHjX2DUkN
 zQtPK5DBlbVQZogCzqrw+r2CXW1BwZFbfsk5JX+bzdeP9TYS5iLJxWPtIQz20JCadqkrrS2yefb
 ukdTEUxnHQPJZh0jIFtTUdwAfluR9YEL5+UNfgkZtdj/GNSnKrb9q3lfC3efplsjiVFtTYvAvAg
 WxVV2BroKsW+RJKFkr1a4TAcspSWOG0QvM31EaKmpkQP/aoXi7UTw43sMyqnYNUIhMHoleDdtVV
 I5s1VTbGo5D5nGcI+AZJ0fMbKFXHqlZbIxsmY7LgUq5leRpdeKK5o6rgRCmgY8di7e3ZsI8usWr
 Bo0dFapSHcysON9ZQ+ysqozyfe1DdGTFHaHHFlCHqntpwtgYyIOBVgBkC5MVlxt3cY8x85IiWYV
 adSiSU37FHiCpZ8FpPgbnfaCsvarug6ZCbBf4cqJAeK6PxPTrCtaXICvznEV0e3irON3nY41/H3
 /SE/0RjbzUEQom+o2bA==
X-Authority-Analysis: v=2.4 cv=PbDPQChd c=1 sm=1 tr=0 ts=6a04c0cc cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=QdDM1--rjLhOk84JmKIA:9 a=QEXdDO2ut3YA:10
 a=crWF4MFLhNY0qMRaF8an:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-13_02,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 phishscore=0 malwarescore=0 spamscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605050000
 definitions=main-2605130182
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

Unlike the USB-C AltMode handling and unlike the DP controller handling
the HPD on its own, if the display-connector is being used to handle the
HPD pin, DP controller might not be able to get either the HPD
notification nor detect the cable state if the cable is plugged in
before the system has booted.

Make the display-connector send the HPD notifications during system
startup for DisplayPort connectors.

It's typically not a problem for other types of display connectors since
there is no special procedure to detect if the monitor is actually
plugged in or not.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
Changes in v2:
- Expanded commit message, explaining difference from HDMI (Laurent)
- Link to v1: https://lore.kernel.org/r/20260314-dp-connector-hpd-v1-0-786044cedc17@oss.qualcomm.com

---
Dmitry Baryshkov (2):
      drm/bridge: display-connector: don't autoenable HPD IRQ
      drm/bridge: display-connector: trigger initial HPD event for DP

 drivers/gpu/drm/bridge/display-connector.c | 36 ++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)
---
base-commit: e98d21c170b01ddef366f023bbfcf6b31509fa83
change-id: 20260314-dp-connector-hpd-f069e66bc6af

Best regards,
--  
With best wishes
Dmitry

