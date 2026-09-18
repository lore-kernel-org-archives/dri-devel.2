Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68113C982E5
	for <dri-devel@archiver.kernel.org>; Fri, 18 Sep 2026 12:05:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 542C110F32A;
	Fri, 18 Sep 2026 12:05:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="DXM5dF/h";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ne59pI3J";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C13A210F32A
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 12:05:38 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68I9dVPL3916152
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 12:05:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=PPVi9Zw6kD0
 /7aVTfZRS8pZ7kqHzCb2nAl0SG1FLnUA=; b=DXM5dF/hKObvtEbd3gN/IjgjB/q
 03wp7Ww3S3HvzhYfSpM4SW9P7aGAZm2dYvRS63vtJiCvLgGxdq4Wnow0tvBFn57Y
 wsKvT4/oGgC/JJ9ctDe0oHzIwGJD0ExF9Gy4uDif65spp8GaZWcSIwAiRm/wnlcI
 /4vJH/hfbc6Bkbr8MnMseU7A6UloMOKNznjHlrYUcafI3aOXMzn+lMahCkoZRHu4
 vu95U4frlU5n09V6YdJuBAIvUuYCWJhxH7ojsMAUHT8/CGOQ+ZVfVfpBAqZMqlrb
 UCr7pNO2mzhkb1Dq/wDgzH8CS4X/r5OvYHe9XaJJWQG9NO+mooBvAuR+nBA==
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4grrjdu1ec-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 12:05:38 +0000 (GMT)
Received: by mail-vk1-f197.google.com with SMTP id
 71dfb90a1353d-5c7b0f8e40bso676444e0c.1
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 05:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789733137; x=1790337937;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PPVi9Zw6kD0/7aVTfZRS8pZ7kqHzCb2nAl0SG1FLnUA=;
 b=Ne59pI3JleGx9oW/EeWFLcgGfkjP4RVGRHSy9cw+mow0GRmVEldA8dmpdx1RLn9VWN
 IFGymx1uEmP3VJBDubWuGXyiUgmF3FmDw7GCsSI4ynOpnrZgbTQg+dPPPLoJcXqbmqYS
 IqliCnDo0tVAVkzDHgd9b6iq+A8/23TQGhiv9m8F3PxYZImyatDX4Ndp/FeSuvj/pEfm
 v1OpfuKcAJvbGbL+MVP2j+dnQhkUYVHuxuNcrQURLGpNPSgLe8F4MhxIS7XUAd70iOb+
 nn0tJBsdtHAx0tOLaXLb22y3dwblE/Dwd4wtwnnzE8S/+Q5ev/VzwO28x16Ocs89naqK
 ZcSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789733137; x=1790337937;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=PPVi9Zw6kD0/7aVTfZRS8pZ7kqHzCb2nAl0SG1FLnUA=;
 b=2ObrVRBxu10W2CKeOXzy/g4zE/tO0l76z01DfFPyisItLG50F5LgTg6O9sbuudRUav
 AEtCNbUil5AFdwHlciFN/4eQ5i7jWWuBw/hOPJtaqIAwpMitxeTLNlf8DC5yWIJxMqyg
 vDDXkm8fhD1+/esaP+giKa+bx79qJ3OXryK3qgUNs+TEzACWZI1hhOKjMCmafuVynK0l
 a84nbKzT20jQ/+g5I/SCdXRYS/xsJ+kdbMrf4hbaCE3ByMmrIN9le519pnKJdPcaw0sI
 TozbN4CVBqcE7joudMgbXqXVQ2MhIqV2fbl2Ue3KkJUfPg89ou0ecvudhyasKAiv8XIh
 25nw==
X-Forwarded-Encrypted: i=1;
 AKwUvByCd3yLsFMcxjelifb8LVhnyWM8AV/j35x/h58H7a/V8LaE/gKZGsdAT3FsDxhcGkXaZGDVPEq2VOA=@lists.freedesktop.org
X-Gm-Message-State: AFuF++ke1A9thGbXYOuBLcpNyV0Q8OYyIPGu7XYXbjbeZCluY++6HVgd
 LRfihOYP4NZoO0vTCqyVxiUgY6B6VJe4E1AWOc5QZRS8Urgj2GgSl9WB/NNxx3HkKNvTlVSgnjl
 WwsZI6K8s7firWLn1ApSIzn5AQi/nAKjL2+FQfyZOACGyRpOX8SNwyb7E2Wm18t4gw99zUa4=
X-Gm-Gg: AYBFou2c5SZXiiiJ+WQbSsGzgRm+/KG1X0Nicnoy8t+w5eLvecTMwsUrnWU8wWkga6G
 eLUq/AGJ6Yr6DFkW6l+K5ziIBXtGZjNHBE7ni7BkL3A5EZKr1LUI2QPEkIKbCxjbkqe9To0wci1
 0OgWNghxHQ9PN45KHwtN8TBa0apM3OF/JGD7AWNixZBkAeclc6jJODucXB3V9Ll41DzIM8kD9QQ
 SDDGLQM96q5B95UfFLgtYeivU4x9t9H7wn4e8ZYGizK+meub8+N3Clug1Ly1qdUJvh76a9EKUsx
 nZWBjmwBZ9uOYb/lwOn9tt/E2DAprOVAPS5KfWamAo+zZLBnD19RugzFL5QdErOolQd+icI6RG7
 9l/aFubk4nUzQ2Q==
X-Received: by 2002:a05:6122:1d08:b0:5c9:a60b:e5ac with SMTP id
 71dfb90a1353d-5c9b59a397amr1048065e0c.14.1789733136216; 
 Fri, 18 Sep 2026 05:05:36 -0700 (PDT)
X-Received: by 2002:a05:6122:1d08:b0:5c9:a60b:e5ac with SMTP id
 71dfb90a1353d-5c9b59a397amr1048035e0c.14.1789733135738; 
 Fri, 18 Sep 2026 05:05:35 -0700 (PDT)
Received: from debian ([5.133.47.210]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4871ff3ae49sm3917584f8f.10.2026.09.18.05.05.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2026 05:05:34 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Douglas Anderson <dianders@chromium.org>,
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: Abel Vesa <abelvesa@kernel.org>, Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Subject: [PATCH v2 2/3] drm/panel-edp: add CSOT MNE007QB1-1 entry
Date: Fri, 18 Sep 2026 13:05:14 +0100
Message-ID: <20260918120515.595782-3-srinivas.kandagatla@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260918120515.595782-1-srinivas.kandagatla@oss.qualcomm.com>
References: <20260918120515.595782-1-srinivas.kandagatla@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE4MDE3MCBTYWx0ZWRfXy7/uOdPnnjEa
 FDJ6sDJpwmq60W9HVklqiLLtIPsCboS3JTKkQCloH0uDotpOsc3tj3eFi01l9ObgtJuvgymjyFg
 YPZyRG9FzN/HMBD9ZdXcp6rZKsepH5241E8PIAt/YrnV+wfckNEwzoXHLwLbrvVAyvuXL0ihik1
 E4g2KC0bGgO+f6wnnlRwn6CtKgXk2frM8Vt3yCWLA10AXI84ORmMygpnwAeCT+UOFpH7hEVDLGZ
 Cuyk2bLSGwXHPwBd4jTI/m7YEs8Dj912/ao07QekHdCI6zNpKUpXN4tpmKCXm10MtStzQMnQUG4
 3T4o9iQObnv9lANQ9WG7SxU/C42NZSb4OjCMk7sBmaJlLqe4XMTXaGWGx1evwDg/3aHcx02jyPQ
 eDi0pO4wGaMDxWh0YYPwMPXCRzDrsqA8S79p1FMHqVua47TY/MVTi4wXa3pAPZqfhZ1f8jefmvM
 gFByzD81eFzNrp4Akaw==
X-Proofpoint-ORIG-GUID: wAi6I9uiDFoZ44bu3pjkzZmuzOPgj8yw
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE4MDE3MCBTYWx0ZWRfX4MPzXTzb8Pb0
 OKo57JcmWzRY7bV+fl8VHDcVS04n2W03cLT+4XLVbkF1LkqrAd/dlIvQIF1rnYUYjxcrO7VUZf6
 hfD4ujANkx7v49nRYgPrnYvFEs3FEH8=
X-Authority-Analysis: v=2.4 cv=J9Q/fwnS c=1 sm=1 tr=0 ts=6aad2912 cx=c_pps
 a=JIY1xp/sjQ9K5JH4t62bdg==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=z2L8r4mWo7kigEPKVCUA:9 a=tNoRWFLymzeba-QzToBc:22
X-Proofpoint-GUID: wAi6I9uiDFoZ44bu3pjkzZmuzOPgj8yw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-18_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 impostorscore=0 clxscore=1015 suspectscore=0
 phishscore=0 priorityscore=1501 bulkscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609180170
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
The panel identifies as CSW 0x1465 over eDP AUX and is not in
edp_panels[] today, so probe falls back to conservative timings.

EDID, read over the panel's DP AUX DDC bus:

  00 ff ff ff ff ff ff 00 0e 77 65 14 00 00 00 00
  00 23 01 04 a5 1e 13 78 07 37 3a a3 55 4d 9c 25
  0c 50 55 00 00 00 01 01 01 01 01 01 01 01 01 01
  01 01 01 01 01 01 35 3c 80 a0 70 b0 23 40 30 20
  66 00 2d bc 10 00 00 18 00 00 00 fd 00 1e 3c 4a
  4a 10 01 0a 20 20 20 20 20 20 00 00 00 fe 00 43
  53 4f 54 20 54 33 0a 20 20 20 20 20 00 00 00 fc
  00 4d 4e 45 30 30 37 51 42 31 2d 31 0a 20 01 6a

  70 20 79 02 00 20 00 0c 40 8b f6 65 14 00 00 00
  00 00 19 00 21 00 1d c8 0b 5d 07 80 07 b0 04 00
  3d 7a 54 cc 94 99 66 52 0f 02 35 54 00 80 00 80
  00 80 12 78 26 00 09 02 00 00 00 00 00 01 00 00
  22 00 14 0f 5a 02 05 7f 07 9f 00 2f 00 1f 00 af
  04 22 00 05 00 05 00 81 00 15 74 1a 00 00 03 51
  1e 3c 00 00 00 00 00 00 3c 00 00 00 00 8d 00 00
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 11 90

  Manufacturer: CSW
  Model: 0x1465
  Made in: 2025
  Display Product Name: 'MNE007QB1-1'
  ASCII String: 'CSOT T3'
  DTD 1: 1920x1200 60.006199 Hz 16:10 (302 mm x 189 mm)

Datasheet was not available, so timings are not datasheet-derived.
The delay_200_500_e50 preset matches the sibling CSOT MNE007QB/QS
entries already in the file.

Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
---
 drivers/gpu/drm/panel/panel-edp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
index b66751df502c..29f250e6e64d 100644
--- a/drivers/gpu/drm/panel/panel-edp.c
+++ b/drivers/gpu/drm/panel/panel-edp.c
@@ -2141,6 +2141,7 @@ static const struct edp_panel_entry edp_panels[] = {
 	EDP_PANEL_ENTRY('C', 'S', 'W', 0x144b, &delay_200_500_e80, "MNE001BS1-4"),
 	EDP_PANEL_ENTRY('C', 'S', 'W', 0x1457, &delay_80_500_e80_p2e200, "MNE007QS3-8"),
 	EDP_PANEL_ENTRY('C', 'S', 'W', 0x1462, &delay_200_500_e50, "MNE007QS5-2"),
+	EDP_PANEL_ENTRY('C', 'S', 'W', 0x1465, &delay_200_500_e50, "MNE007QB1-1"),
 	EDP_PANEL_ENTRY('C', 'S', 'W', 0x1468, &delay_200_500_e50, "MNE007QB2-2"),
 	EDP_PANEL_ENTRY('C', 'S', 'W', 0x146e, &delay_80_500_e50_d50, "MNE007QB3-1"),
 	EDP_PANEL_ENTRY('C', 'S', 'W', 0x147c, &delay_200_500_e50_d100, "MNE007QB3-1"),
-- 
2.53.0

