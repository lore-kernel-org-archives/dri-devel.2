Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A62C0C88E65
	for <dri-devel@archiver.kernel.org>; Sun, 13 Sep 2026 20:18:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE5BE10E9A1;
	Sun, 13 Sep 2026 20:18:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="M2i6cSaB";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZL8BNOql";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D282410E17B
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 20:18:51 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68DK01bZ3216950
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 20:18:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=/pIRG6lOSOL
 +GZKPVs8yVLiClfTIIPVe6IufCgoLClc=; b=M2i6cSaBkZXs21bNWZoi7ORzYoj
 m6W73lcgoKMEbY2QChsfyTrci5O9eZFwXCDhGtfzaNI36yhj8zQK1X4yCRy5HkHC
 /9LYvq5IAvS7YvijXTkbCPgU2V4vEV29yE6poz9r6IL9gGDq+IdndN6tojzQ1P8h
 1l7Y2SFAciUy1p8/o0o1Oru0BFe+x3phA3I6oEdjAQrhj1YUAblkTUpmshKaeMKq
 ERVJZDPwI3b28pNCnIKhPP9qGCGq1P9bI2iu4kHCALwjaq8gwImhxCAKuFq11omv
 W4IS8AQRriKV/56wEU9IT6y+GyU8qKfBQnu5OBC5Go+Zg2GK/EZFWaxkKlA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gmy9dm2wq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 20:18:50 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93a1d44c437so65170685a.1
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 13:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789330730; x=1789935530;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/pIRG6lOSOL+GZKPVs8yVLiClfTIIPVe6IufCgoLClc=;
 b=ZL8BNOql1yYno/vKvVQz3SbgGY7UVCJOeNLZ+jxAMh9X/p1iAtCJKZcIApIY1KNGe0
 3ponryfZQU0bGoG/K6GdJIKk+d2kK7HrNI8EStuMZWCB4b2GCUr6BAnLuRYdboAiQ29N
 2jewZz6GRyrJ19ho36eVXsZa7sF7aS7FRDtoR55jEUoc0LsPdy+86A2aec3yqAsdOqj0
 MOcWdUfj91KwB+6uIvRzDKw9DIB6EL4sAJ0f3Qw7NxAk92fbQL4iQAT/71Xh3P/tw1r+
 rYjqH0E9BVd//9bncTJpqBnIl1V6FL0+z1mLGz3SLk6A2gq5beR/R+KFuH0tCquNo85j
 Q3GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789330730; x=1789935530;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=/pIRG6lOSOL+GZKPVs8yVLiClfTIIPVe6IufCgoLClc=;
 b=TWa1A6yewblOsIqcq0zpoiknqij8C90O96epMMAId2zdjCfKisc3zdFEzhStRqRrwc
 T0HXC59+6fTFgAd/PPgJZNmGfKiWAFXyJC/t+4AvjsQJrdQDjt5yKVwfo3jVoi8wk4u4
 IrsFDd5ie/Je4Lt8OcbCqAlMgax6c73E3H6qiGTg2QI+Ikb92Xu9UC5GcH/zHR4tPna/
 CoONv3RcjBQtoimwqOor9H0kv4QPNrY9GdYw2TRyvOdC5tcRPHSYT2bTyQYYxV4cmIDW
 7WXc7N1EDK3EtNAjJqvZIi9vWlUP2QLNpu7UnuXFJrD+DdCjuEH8yKoB7yDKTvEEPthp
 rCTw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwCMwHl/A3TY6YfsbHUrIHg8IffPvekJOz0H3Dh80yqmEqq1ukoX1tHdKvz57A4OjUiuvu9W0OSt6Q=@lists.freedesktop.org
X-Gm-Message-State: AFuF++ligAfSxlzUrFzfdeHZTU5rXEUD5Brw6DF9QRnMlWfMAMQs+edr
 EelSrCbSQVUWQK4PWpU+6ZlCsNGkFpjfjDl+2vxn8raOYpJg176vOwdIV9AT+GFbL45n1fH14u0
 +/Iwrbf4TS6iGb8dR/o3zNkwo20HZKgehODK1lhrIAM0bmBw3HLDlewNiI3QXjmUJY8Vv4hA=
X-Gm-Gg: AYBFou2FvquIuYXwpo1JVTI5GzMDMYr0hGq2hceN70RNt1L5LlR5MttXCIMVB+2Z1Xz
 PXQyD9lObFdBImc1GLeVrq56XmHzU0n74OPDNgIG594vxZhxQCgSEhFZWLn0GzuVaJzxWx8M4d7
 tp6GQGHFAz4uKMN0efRw8dICOb0ifshXcrvfP295ChesB2ar/Rqwz5hr4bKCCqrs1b9ciOUPxSw
 O47GofoK0A7h00/KFKg+YGHqveCNR3yvMeXbQLULAFPcPugGU6PUwQ5qYCZ5x4+/pYrtBB+wKMJ
 P6QgB+GDk/N1enABGt2WkW33A35jsrN3o44/rtPt7MGe3gz6qej7DbnxrF36Y67T/ztvEjeYyFs
 MdrABk+RvSlxzUw==
X-Received: by 2002:a05:620a:701b:b0:939:a9d4:7022 with SMTP id
 af79cd13be357-939ea0e36f5mr1901696785a.8.1789330730006; 
 Sun, 13 Sep 2026 13:18:50 -0700 (PDT)
X-Received: by 2002:a05:620a:701b:b0:939:a9d4:7022 with SMTP id
 af79cd13be357-939ea0e36f5mr1901694685a.8.1789330729614; 
 Sun, 13 Sep 2026 13:18:49 -0700 (PDT)
Received: from debian ([5.133.47.210]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-486eb32d3c7sm20143821f8f.10.2026.09.13.13.18.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2026 13:18:48 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Douglas Anderson <dianders@chromium.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 mpearson-lenovo@squebb.ca, abel.vesa@oss.qualcomm.com,
 sibi.sankar@oss.qualcomm.com,
 Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Subject: [PATCH 2/4] drm/panel-edp: add CSOT MNE007QB1-1 entry
Date: Sun, 13 Sep 2026 21:18:33 +0100
Message-ID: <20260913201835.250085-3-srinivas.kandagatla@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260913201835.250085-1-srinivas.kandagatla@oss.qualcomm.com>
References: <20260913201835.250085-1-srinivas.kandagatla@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: o5-FDYmGqYX3PbNYtg0sWJgr7fj7n8fe
X-Proofpoint-ORIG-GUID: o5-FDYmGqYX3PbNYtg0sWJgr7fj7n8fe
X-Authority-Analysis: v=2.4 cv=NelzRGD4 c=1 sm=1 tr=0 ts=6aa7052a cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=OHByPvKFZqPdRaoOVeMA:9 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEzMDI4OCBTYWx0ZWRfXwUupSn1Iq+yC
 +3PNwF/Yg7Qkud4s1WaosKCEeA8VHxmW+49F7gkoUWYOx3hnZWJIgHn/vvgAZZtoHU6tzsjCs/9
 fuKqNZvlVnbJsUXso/OBeahi3JTgUYU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEzMDI4OCBTYWx0ZWRfX2HtgRoio2VeM
 VL+8OkxePdqiYoIVOXQ+tRskdHqm+srxbECD5U8MF8ZJi9clcJm+etuFT486a4W/DLJUSVZZtRV
 PkP6YHTbcGNdn7FGHBI3IXVgLmOi4S4hmmPNxhx66cIRfvTi73DMC5m0+MDtZwtIQOM/sk+Pi/y
 LWrXFMKrx1R2dtqX1MBE6d1XhHQ1/CoOXGWwmBsxuVpv6yLsNXR1qAatvsHSlYdiYf12NqiP8Le
 MdUyWZxP8kjvUuY6Zv1dL59ak3wJ7Ahpu9btHr7fO++aHeBTCGVcoEe6OklvAKYJHMrBHO2DQdZ
 Oq2yjtLCkH6CfPUyUomOJiilt0pbZTQT3tllHbXflFW1hL1RuIyEe//6Y+0Ce7HFi3PG1dNkRwV
 09x6DS/d8oSzhtO5mHq3nKSJxk0qYNgbyWUwLaM0KjUty9bbaeyTlAkWhVvt7rIgC0OF2whAM5A
 ZjpunOcBdto7WC12i6A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-13_07,2026-09-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 impostorscore=0 priorityscore=1501 clxscore=1015
 spamscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609130288
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

14" 1920x1200 IPS panel used on Lenovo ThinkPad T14s Gen 7 (Mahua).
Panel identifies as CSW 0x1465 over eDP AUX; uses conservative
delay_200_500_e50 preset in line with sibling MNE007QB/QS panels.

Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
---
 drivers/gpu/drm/panel/panel-edp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
index bfb49b647b96..15ca62c88901 100644
--- a/drivers/gpu/drm/panel/panel-edp.c
+++ b/drivers/gpu/drm/panel/panel-edp.c
@@ -2140,6 +2140,7 @@ static const struct edp_panel_entry edp_panels[] = {
 	EDP_PANEL_ENTRY('C', 'S', 'W', 0x144b, &delay_200_500_e80, "MNE001BS1-4"),
 	EDP_PANEL_ENTRY('C', 'S', 'W', 0x1457, &delay_80_500_e80_p2e200, "MNE007QS3-8"),
 	EDP_PANEL_ENTRY('C', 'S', 'W', 0x1462, &delay_200_500_e50, "MNE007QS5-2"),
+	EDP_PANEL_ENTRY('C', 'S', 'W', 0x1465, &delay_200_500_e50, "MNE007QB1-1"),
 	EDP_PANEL_ENTRY('C', 'S', 'W', 0x1468, &delay_200_500_e50, "MNE007QB2-2"),
 	EDP_PANEL_ENTRY('C', 'S', 'W', 0x146e, &delay_80_500_e50_d50, "MNE007QB3-1"),
 	EDP_PANEL_ENTRY('C', 'S', 'W', 0x147c, &delay_200_500_e50_d100, "MNE007QB3-1"),
-- 
2.53.0

