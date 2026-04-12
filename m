Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BE65E937EE
	for <dri-devel@archiver.kernel.org>; Sun, 12 Apr 2026 17:32:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 861C410E0D9;
	Sun, 12 Apr 2026 17:32:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="m2YQq/Ig";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EmbneNL+";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0587510E0D9
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Apr 2026 17:32:34 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63CE4nfk2662246
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Apr 2026 17:32:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=ObY9dcBzdReWuRlU/Yfk1K
 5rEAWdMtpDanJl2sCOrF0=; b=m2YQq/IgwubkUrN+hKX/MkJoPX03SktU0smZBg
 dZ9uzIC5s/xObe4mftWGLzJdFduSzS6BtBJTSR+rgYHkemS2d7XysB7wNUz1c3bD
 /w2w0DynVa3todmdmg15I9e5JvDq8hZTEYGayGIzFx6EhSZujovVyJQiSU5lR9qS
 YFHKMb8ma4DTeOc+Qd9U65R+E7912C1q1nGaQpFdnkrMhOtmZnRuot0Dfl9wW5dZ
 1ZIM/kcIJu+gbzkmzNTkwH+wNmzEtl7DKdpmN2WfplhNV7za65iD4d5FZWBq+S2U
 QhJZOlh0ktSBdz8VKrRDb9WB7Lu4cmHI5mmcdADTcGstUf8A==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dfexctq90-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Apr 2026 17:32:33 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-8ac9609d3d6so34450546d6.0
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Apr 2026 10:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776015153; x=1776619953;
 darn=lists.freedesktop.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ObY9dcBzdReWuRlU/Yfk1K5rEAWdMtpDanJl2sCOrF0=;
 b=EmbneNL+5MseA+2rti0dc/0G1VnDXYVKSj5Xjrdw3/C/VATA34gbN0SVrmo5lSL1qk
 jyR0b/x9MoujoOVdFimZAebiwN5yeCsJtCLOTGtNDcoKoA7H9UCA9al9b58DGiJ0Ofy3
 dMlZSyPMZ5IObY2/eo4IJ9gto6XDbcvEbLcN3w09+Qz6dhQe7TRHiMliqBkP8QHpb1OS
 6IkTxLWYzPzvzKDRgID5y50Q9B1el60EjrSPK34mD2hNT8SfDXdGgqLI5SJj+4bfKXA+
 VK4uh8z9rpRaTNtYVKvD3/CwjaSqJU7TPxu/9lDbkl+TeOXffgzPUE1+O7SO9smNl9wc
 Ek2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776015153; x=1776619953;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ObY9dcBzdReWuRlU/Yfk1K5rEAWdMtpDanJl2sCOrF0=;
 b=VsKZCoIQDSlaCb+mH3iMSDCRbrFRNMmW82zoMk7y6CZo6XzJeN/AfwgJ4t5OzC0nDk
 OrxLBzoT1vuWBtLofoS6YZJrRnVFrnlC0ce+oOYx6cRD4xQEJn4Wdpv2Zwqm91Wv7QSB
 7Foo5GaN5DtNRa9WH8xbrnxc08cWHZv0YpGFK1nmMvvDnNBjkaqOZawQDlszBOSUfpDa
 dVxtFXOGf0nE0uaXbMbGA2qCr6MXfBsppAxcKUeLYD1gV+1aMb7TYra9+wMW4PLcXCEj
 Ul2vWVWfb8b0c1+pSys5OuxEIS2uqTP9ewWfs8BF/dGCLsHtNtFoj9LqyJYPlTvRnpKm
 yv/Q==
X-Gm-Message-State: AOJu0YwyZsLrvakY7uxcHDITgEIk8cMgWB4JUmqPUAjz5FmLg9bYebmB
 y7ghulm576kogj5b+1rqIsV5Kb+0UkvgOvPseAPqf01hxU3NpiwzhPArq3tDjJYkthTDDbARjT1
 C6gFiBjI+STwwMd9FfAnPUyuoACMGlJZhBOV4vuCcO5N28W7T8W/UFkuhYRsbW4jBrEW82geg/x
 NMTaw=
X-Gm-Gg: AeBDieu7Z/QE1NpA7lpOTN0nP5a1GmhHCykOfGd927q+z40EO7JIdsq2hXcQisUpWMn
 j/uHIF7qIwy0W0WX9VoYgQrENvPYOYIzP/s5bvoXa5OvANJuTI92tLAVGH9kv5NGUSgsp59xl6J
 2KNXeHDZXSMLsm9mM9hfxsfDq2T/KT+BT8Ff18CIrJJnsc48XrAIEoPtAKALtMqpYGr/OONCEDH
 witdC3qHtF5dztGEuZhmY4i+aiseaAr0Z5ZHlr5EF/2eUW4fLRIM8W1LqO0aTHiQ5lSc4ORXr/t
 w/ysa0bLjgjb0X2kUkoyHLKlnx464LCY36WQ6EynEhEDR0b6YgJ9Eh3SwKhnuveNM91Uq2ogwgk
 MtNx+CI1VLAMVjMab6mYtr2AnP91JNoRhx9R5qKYewk1T4dc6mFbVF/tOlsKjIckd4yjvsguQC1
 mGTknKmRnQ5dbECKeSrV0Cn/HFG6aTiNSqvxg=
X-Received: by 2002:a05:622a:a916:b0:50d:7f66:dca with SMTP id
 d75a77b69052e-50dd5baab7amr132336591cf.33.1776015152944; 
 Sun, 12 Apr 2026 10:32:32 -0700 (PDT)
X-Received: by 2002:a05:622a:a916:b0:50d:7f66:dca with SMTP id
 d75a77b69052e-50dd5baab7amr132336171cf.33.1776015152423; 
 Sun, 12 Apr 2026 10:32:32 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-38e49a4a6f9sm17585231fa.31.2026.04.12.10.32.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Apr 2026 10:32:31 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: [PATCH v3 0/2] drm/panel: simple: add Waveshare LCD panels
Date: Sun, 12 Apr 2026 20:32:23 +0300
Message-Id: <20260412-ws-lcd-v3-0-db22c2631828@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACfX22kC/22NywrCMBREf6VkbUoebXys/A9xkZc20jaa20al9
 N9NKoigm4EDc2YmBDY4C2hXTCjY6MD5PgFfFUg3sj9b7ExixAgThHOC74BbbbAStSZc11LTNUr
 la7An91iGDsc3w6guVg/Zzo3GweDDc3mKNPd+RiPFBHOy3fBKVjwd7D1AeRtlq33XlSlQ3o7s2
 6YfmyVbUmmM4EpYJf7Y8zy/AFBPf0XzAAAA
X-Change-ID: 20260330-ws-lcd-b65c03c5ac17
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
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1473;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=Soqo5q+LEfVr+3Noi1uaWeIlz7pyLr4dy0IKkD7AqHE=;
 b=owGbwMvMwMXYbdNlx6SpcZXxtFoSQ+bt6zq7/UTqzgV2/J6iFlnbKq5kUbN0ddLSH0XR7S9O7
 1wd9NSmk9GYhYGRi0FWTJHFp6Blasym5LAPO6bWwwxiZQKZwsDFKQATWR/H/j+H415CY6kKg7rZ
 rMRV667stnqlHp0pGuTlW1Rqzam6ONQvuyb2zXXX2mkXXllvvHeqX8lEa+vOiis/Ns58yFgV4ST
 PmcS6RHZNnMPDE69uyTDYdhw6piTgZnvV+9uvd3k7l3FsKFWZ8Nlg10qm+Unr2J+ezdG6WCbu/d
 eLdceB+XVhMbyRLjFdoolfdhWkRRV3c08zKmRn+77F5TWfik1wxL5nXA7nhPo3TNwiKT9LIvZaY
 clvC6UF8uG9y81+TuphcpqY5zbZYlmW1sOC3sb8RUwrdH8qqQuXlIU3uU1Rkf9oNsdB+dTBLbe6
 E2ttMudsYrZbeq07iIehxOmCQfpB4c8TdBX2X2rftN4aAA==
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEyMDE3MSBTYWx0ZWRfX74g8CC++8Ai1
 rPgZtrh/q+XmmuNd4i6xs7pD9g4musZovNN7p7S9qLIWDFPKrDBOpjlmRKIBoQ4w6PpAFx8AHU0
 by8KdRDiibwoDfxhLj14/uGVuvw76z9Sf/uU6SndFhPlFDUjMi1OF69WPQXinGqIJfxtlDpvjIB
 LrZNF6X+u3aQZhJWdO7C1A7H4TN7djNkqSOvpZzd2a7lGASlH865g6re/hfln3oUcLhuSQr7l0M
 MRd+5tzs5Q67VusATn4rxbL7HtRsuCn0FCEMab+BhlH+drkSexXXY4jX2Ejb/7mMhlVPs8MrmA6
 V9tCicJMqn6kx30oLqKOxw6ooBx92+CKSdVf50dK4nb6VS2i0G1TVhcwBBnqQb4U2/1alw78nSi
 zjRWDWX3ilzKdtciltGZxH7L8ylF8za54jAJEs4mwRAW8pO65Wc/wWe1OwNpalFJUA1R2xMbjC3
 7VgZpl7AHpA5jz1eNBA==
X-Proofpoint-GUID: zMDqUc-qBSkvj1T5UVlotNCRRTGz1eBd
X-Authority-Analysis: v=2.4 cv=MqliLWae c=1 sm=1 tr=0 ts=69dbd731 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=bC-a23v3AAAA:8
 a=EUspDBNiAAAA:8 a=i7sjGvRSvCxcs841hgwA:9 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-ORIG-GUID: zMDqUc-qBSkvj1T5UVlotNCRRTGz1eBd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-12_04,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0
 impostorscore=0 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604120171
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

Waveshare have a serie of DSI panel kits with the DPI or LVDS panel
being attached to the DSI2DPI or DSI2LVDS bridge. Commit 80b0eb11f8e0
("dt-bindings: display: panel: Add waveshare DPI panel support")
described two of them in the bindings and commit 46be11b678e0
("drm/panel: simple: Add Waveshare 13.3" panel support") added
definitions for one of those panels. Add support for the rest of them.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
Changes in v3:
- Rebased on drm-misc-next, dropping applied patches
- Link to v2: https://patch.msgid.link/20260331-ws-lcd-v2-0-a1add63b6eb6@oss.qualcomm.com

Changes in v2:
- Updated waveshare,dsi2dpi schema to implicitly mention LVDS
  (Krzysztof)
- Updated commit message to explain why the ICN6202 / ICN6211 bridges
  are not a part of the DT bindings.
- Link to v1: https://patch.msgid.link/20260330-ws-lcd-v1-0-309834a435c0@oss.qualcomm.com

---
Dmitry Baryshkov (2):
      dt-bindings: display: waveshare,dsp2dpi: describe DSI2LVDS setup
      drm/bridge: waveshare-dsi: support DSI LCD kits with LVDS panels

 .../devicetree/bindings/display/bridge/waveshare,dsi2dpi.yaml    | 9 ++++++---
 drivers/gpu/drm/bridge/waveshare-dsi.c                           | 5 +++--
 2 files changed, 9 insertions(+), 5 deletions(-)
---
base-commit: efcd474ed273ae7da614b30e798651c6d57d3109
change-id: 20260330-ws-lcd-b65c03c5ac17

Best regards,
--  
With best wishes
Dmitry

