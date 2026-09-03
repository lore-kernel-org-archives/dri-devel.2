Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDA2FC624D3
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 03:34:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 662D510E089;
	Thu,  3 Sep 2026 03:34:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ogp7MkMr";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="c1wAhbaj";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 988F110E089
 for <dri-devel@lists.freedesktop.org>; Thu,  3 Sep 2026 03:34:34 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6832xtjI3275638
 for <dri-devel@lists.freedesktop.org>; Thu, 3 Sep 2026 03:34:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=QrJbejrVOsCHZAaABWltVD
 j2zdgifZ9sUL4/mxqszzA=; b=ogp7MkMrzaMxfduc9tejVvURCf1HrqHWH4T+Ra
 fRlQ7IE8AkTyq8Q746hfnV5IFzo67fum/EQI393n5Z5Ngx/TSIHuhTtXR2bdhl8w
 UDLprxhVRkyo0pwFOevSRy84mhwG03L+F+q7cY0OxBhwpY+x+bYG/6bShzcuXH3R
 2bkkVyaAwD536tl4wH6ncnl40Xg7DpM2jEIUvnpkHNVFBVjwEcNlDWDOv3twbYaE
 gxtlN8GUnBPHT/f5BGG2wpw6PqFoy1D7MNbbxvKb+kfo6E//d8JSDllrfqO01RY3
 7lNMPdpaOwOHwl2Fmtp4nRwTs2xdDlSaCy3bqMTz4SKpAkFg==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4genrdtwe4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 03 Sep 2026 03:34:33 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-3989b317c31so385651a91.0
 for <dri-devel@lists.freedesktop.org>; Wed, 02 Sep 2026 20:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788406472; x=1789011272;
 darn=lists.freedesktop.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=QrJbejrVOsCHZAaABWltVDj2zdgifZ9sUL4/mxqszzA=;
 b=c1wAhbajsUMBVXs3N61S7MlZLSkxPfi3O/lQ35A8MKt3XdhvL6/kBEiENxui9TPI9y
 IzeZdsXATEvOe+r2oj2IOi1nCqUH8BletSIdOmU6hcUrCIU7Y/ZMCLcJxT5oeO36XBfv
 LfOyzaSIcCdP+D91HOCfICUyGFmxbDEY2UADZtiJb7PjpmiLDiS3jDR6HPVg+2Z8+eoy
 Y9ntCSUMfAhQeeFvChGjMTPLRRXnsSnrXid5VoX+4yex60t7gznd5B7gkVz5BOOolHIw
 VVX8v2CvsgBtekCDTAxr8i4IGfYbgXeP3mYseDDu/is1uUFO25IFdsZtqzlDwFgag8Jz
 rxUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788406472; x=1789011272;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=QrJbejrVOsCHZAaABWltVDj2zdgifZ9sUL4/mxqszzA=;
 b=mbe1jIqNMaWct/oZHBEN6OcD7QlEMoPYG1J3ksmxZxtQ9To1bUadtXQH2pdyG2kOf4
 fLI9Dv5b0ha9NwSyrqbL4zmtYfFGK4HpjgQsytKcvOgoLFhJHHpRDHwqpPT3S6nXU4Lq
 q5UqUZwpL35kC3aFHtWyX0rQERTOa6RoQDNYB+rKvcTGNiVJ9uLz96+9K5d8BMhekL7R
 98/KBm5xaOfKxpYLq/pi+q2WxbmL6YQ2RXY540gVrWCkhytUjAz0OMXnH+S7l8AWReDz
 EMW5dZNZyRd0vsw/40ssycxIZDE8RiBJrvM+Vd0KutaRz60IJwefu1Vz+fh18UVSX3Pb
 KxfQ==
X-Gm-Message-State: AFuF++molqZS7JufIue63xbR924AeaQ7jCpoUJE+LbWQp+xpjQ6T/k5C
 NpSj0WGA03T0qtmuuOTNJTDiijh5pgVjY0sZzHbJwCP31xK6pgHkQYnbxKsYLEPQ+KnHb6YF0sh
 UydCwolD+moal+8/sgshl6HdisioBuNfV8YSHTZTjd7m61Jt5pBl6brZC0N32vHycS8tZOLwQBr
 oeC8E=
X-Gm-Gg: AYBFou3V9oatslwbN7p/dwI02zLslRmzNX4nwd06j7g2pjK4T4snWvYtZoRif+asXGi
 Pl/Lh1L1KdT72BXS6rHuk/bOygzaQrpqyKfMUnJjYJkEfyJtnvNgkUaLyIEYLQY1lSyV8BDWZ67
 mIIte/HLyYvJ5E1gh3/7A++kE0Pvbw0kjyPgik/nXM/E1BuJRPkBjbOI0KGYaoy3nd8Gg+2zkPh
 kn8+a/YnTesHAq/ZeDAdv1AL5k4emiCKYA0jWOKrcpSYtyf0n1+IVVGeMZ+erTPH0QmCXH1FARt
 lRmwPnCEYiU99xUo9xirCgjNA2mSQPT/MipS9BjS+qK9yd8uEQRyhlhfWjWyU3kRMIq/lzQK8Vo
 UXWv9SnI5hWK5wxcItIe3QYCJmqPbN6MH5Sd5LPOGQ92gQRUyFHq9i9V+E8iKv14Nnmhv2PKoKu
 0q+UaHUE2bFJvQuCufINiR
X-Received: by 2002:a17:90b:39ae:b0:381:77cd:38ca with SMTP id
 98e67ed59e1d1-39aee1b3eebmr8240283a91.4.1788406472083; 
 Wed, 02 Sep 2026 20:34:32 -0700 (PDT)
X-Received: by 2002:a17:90b:39ae:b0:381:77cd:38ca with SMTP id
 98e67ed59e1d1-39aee1b3eebmr8240235a91.4.1788406471555; 
 Wed, 02 Sep 2026 20:34:31 -0700 (PDT)
Received: from hu-vishsain-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33253672941sm2375624eec.3.2026.09.02.20.34.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2026 20:34:30 -0700 (PDT)
From: Vishnu Saini <vishnu.saini@oss.qualcomm.com>
Subject: [PATCH v4 0/2] drm/panel: Add BOE DV215FHM-R01 LVDS panel support
Date: Thu, 03 Sep 2026 09:04:16 +0530
Message-Id: <20260903-b4-lvds-panel-doc-v4-0-861738a0d5de@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALnqmGoC/33NwQ6CMAyA4VcxO1uzdgPBk+9hPIyt6BJkynTRG
 N7d4UUP6KXJ36RfnyLy4DmKzeIpBk4++tDn0MuFsEfTHxi8yy1IUinXWEOjoUsuwtn03IELFmx
 TSGV1Y6hhke/OA7f+/jZ3+9xHH69heLxfJJy2/7SEgFAarCyhstSW2xDj6nIznQ2n0yoPMaGJP
 lCFcg4ikNBSJljJuq7qH5D6hvQcpDKExmFBRjvFdgYax/EF55Uw30sBAAA=
X-Change-ID: 20260719-b4-lvds-panel-doc-cb503c4ba2be
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Thierry Reding <thierry.reding@gmail.com>,
 Liu Ying <victor.liu@nxp.com>, Sam Ravnborg <sam@ravnborg.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Vishnu Saini <vishnu.saini@oss.qualcomm.com>,
 venkata.valluru@oss.qualcomm.com, Jessica Zhang <jesszhan0024@gmail.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788406464; l=1429;
 i=vishnu.saini@oss.qualcomm.com; s=20251113; h=from:subject:message-id;
 bh=999fk6SijFJaMb+FsqTZaZPYEBCkE+cV+0fvrZ0b3yc=;
 b=9R14RgT7yl+pdwHoe2npyooWtj27A9yHwUw82twMUFTNodT9eqx7UPDpMvDnKuKhm6HzOSIf8
 SaWP6eVZK/hCa0ygQJGHcMRy+31qOehC8rAbsl2ZxTXL43Pem/Yydll
X-Developer-Key: i=vishnu.saini@oss.qualcomm.com; a=ed25519;
 pk=8hlXlF8j/3GeOaDK3w2LYhkv9FanCQru0c7kRH/It7k=
X-Authority-Analysis: v=2.4 cv=H4/rBeYi c=1 sm=1 tr=0 ts=6a98eac9 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=dmYVuBIMaTYquxi6TZ4A:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-GUID: LZJlKaUYw1q-NRLUGEOp0yw3I4eSJzIz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDAyNyBTYWx0ZWRfX8yURw6qwgRF+
 pazkuEIPAcksOLH68vPhAU5lJgoEIvp9rl+UWdEkBdIC0Ucemc42lMNsUxwv9irHmtYCwjhJJIs
 55v5tceXV3/ieuvNwNyLZHaUI/gdp5Qhsh6Hqi+Bqm5zs0AewTvW7CGO0eJuwe/46DTjLEfPYib
 pWpBWtiQZlorGyhSEQpjOl9Wrn6j6t2bjOxIz/gUQqBF2NRKUU1p3ZMWf0c68egl76xVDEOoz/R
 aFUEoQCNcx1AZ1ixC2dIM32nP7iufSEE97UKzQommuOitF32Tv9B8XNGQWMRfz2SX6tB/uB2iI6
 LWwRFUmmy+MJNS94Wjr5mtn7bz4Eycht1aCqdGz2kfA6tls1dlBhHThnZef2Y35acUUvLAqWAIR
 VQEknV+WXktZRJU8hfOO4GaHEBOTy5Ikonyuobddcfcztev86dxIUC8BwnQOyUrDXfR92vWvmvi
 +dH3ZQQfZ/QYDcrNlbQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDAyNyBTYWx0ZWRfX7oQSuMxGpoc3
 rsV0fXcte9tUjb6grNav5G+KMwEap7WMk6s9ZsAsX40eFb5s1MAgrlJGuXCjrkzI8MBa4IlPTDW
 ieJ2i9dDO8DTr72OZX7fBmiynrpdS08=
X-Proofpoint-ORIG-GUID: LZJlKaUYw1q-NRLUGEOp0yw3I4eSJzIz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_01,2026-09-02_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 spamscore=0 phishscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609030027
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

This series adds support for the BOE DV215FHM-R01 21.5" FHD
(1920x1080) dual-channel LVDS panel.

Signed-off-by: Vishnu Saini <vishnu.saini@oss.qualcomm.com>
---
Changes in v4:
- Rebase onto drm-misc-next
- Pick up Acked-by from Liu Ying and Reviewed-by from Neil Armstrong
- Link to v3: https://lore.kernel.org/r/20260814-b4-lvds-panel-doc-v3-0-1ad152a4d3ec@oss.qualcomm.com

Changes in v3:
- Reordered commits, keeping the compatible documentation first [Krzysztof]
- Link to v2: https://lore.kernel.org/r/20260810-b4-lvds-panel-doc-v2-0-f2c2fe309989@oss.qualcomm.com

Changes in v2:
- Move panel support into panel-simple-lvds-dual-ports.yaml [Rob]
- Add  panel timings which were previously added in DT:
  [https://lore.kernel.org/all/20260719-lvds-support-v1-0-1f1aca3213ba@oss.qualcomm.com/]  
- Link to v1: https://lore.kernel.org/r/20260719-b4-lvds-panel-doc-v1-1-6a18c213c2f6@oss.qualcomm.com

---
Vishnu Saini (2):
      dt-bindings: display: simple: Add boe,dv215fhm-r01 compatible
      drm/panel: simple: Add BOE DV215FHM-R01 panel

 .../panel/panel-simple-lvds-dual-ports.yaml        |  2 ++
 drivers/gpu/drm/panel/panel-simple.c               | 28 ++++++++++++++++++++++
 2 files changed, 30 insertions(+)
---
base-commit: 97c594f71fa71dc30a0583a76d8b6ef5c5ea10b1
change-id: 20260719-b4-lvds-panel-doc-cb503c4ba2be

Best regards,
-- 
Vishnu Saini <vishnu.saini@oss.qualcomm.com>

