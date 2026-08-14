Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A924C5CFCF
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 05:25:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5145F10E069;
	Fri, 14 Aug 2026 05:25:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="WCUe+Rku";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="errnEtDG";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 64C3010E069
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 05:25:23 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67E4QPbx1741429
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 05:25:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=Fz5pkkhdikAZTkxO1lt5kY
 qS67cDWlTdJePeYXwFoTg=; b=WCUe+Rkuxl23iy3fGdMOBbiIklKoeA2KgQ0Uf4
 XLDGmotp4tSEn4s2PjV4yAIzXM5HK59JSfScXostCur/tIKQfGDYJ8cGJ4vxWX9C
 29OykXvYt69Q7zOJK0iO7OVYHYrm2gMxmbDqAVSNCLnnJxoP4kcVK1YF3saTedVa
 vBNtVQdXc6gXOKmijLcMITX/YR6ZSIMwnBwi/S+cUHK+FWTk/2KWZadtoJIikdGP
 EIzMaBV5QDd0+PMzow5oBZc6RmZbLUuogHM8Siq0yhIZmHYJCQB1AppsHVD06R1U
 DkqetoXHGbpt4bly+j46HQ815g1w/tkFBE2I/Z8wV1atItBg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g1j2nje5f-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 05:25:22 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2cc4c126cf0so1177005ad.1
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 22:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786685122; x=1787289922;
 darn=lists.freedesktop.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Fz5pkkhdikAZTkxO1lt5kYqS67cDWlTdJePeYXwFoTg=;
 b=errnEtDGmndznQ37+WIUSLtrwQg/v+B+5DmsO5/mC5QYoBpOEDW8MiKuF25KViXeAx
 J8ZEYxl5HSJYYm53tlFUN4pGMPdF9suEczRGIjwMrw3Ochew1CrpOLG4ZMTlthCHn7La
 U2aCTCUJ9igyh6zFtfm1H2aFLgYgHPj+WODsdEUx078SZggOfYeMZ4BY03zKd5TsoII4
 tUkLm8h2R4hOEqgUXjVX9j+6RVXmxdfEEjGwH4GC2C12ZY0IXLaymvvkpubXplEAtxzj
 ByB3Zm3A0dAKgkRTMV06qj3jlhhy87oElinZ2TzC/FH2n57MNHDMV7LiHkpvsaSRc9+S
 nrYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786685122; x=1787289922;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Fz5pkkhdikAZTkxO1lt5kYqS67cDWlTdJePeYXwFoTg=;
 b=Nlf7LnDPjX5lmF3XXTDpXU1xsaFkQGgATPoQ1adcpVscdkQ9ctFw554VV9AFvJXtGi
 iVrL6FX4SpYdR2IKkB0WUGS7a4QW36GSAbZzGc8eSQS3CcjeOUr1n7/W5Ya1NNtk717g
 3UU5dHQSB7a+ROY+OCgN3PY2bul6SaGG9PhM6iwSjSd5oNvbotMUIue6tOLjXXGZQx6V
 BZk0KUYvFz+wz+ujp8v8zjzy76aqgL4OICYngOPCKr9lBmpwyXlha7AmOZZf1WyzkCGD
 vyxW0FQP+2BqrKoi2qZOXuyJ4tENoDoBMtLEyACuV5mSVIB9uY6bBG3pxDWmFeVyVoEQ
 HuIA==
X-Gm-Message-State: AOJu0YzgsTb4hhD8OKxklD2wOfLC3upF0IM1h2GvD+e+Bymz2pet21TQ
 /1+uHkC/dCvrecVREIO1XNl2BtYbvoAciQGvR9fWlua2NImcR/4GLV8XIMN530aGje9vy1Ze2r9
 f/IaGEpeQNILkDcggGaOKcicsNlbDgFHQZYWYKqkiWPTg69wns2jfmywdS0C3nGmotcMg+1k=
X-Gm-Gg: AR+sD10aODz82t29psWsUBBvFi+h7qFTrVDDSVDQDCmxJporBeUnUChQ4U+9FpcCnvg
 hgrzp1vMsCJPWXfMhzchTZnQuDOp9DbLVXkh7E9PfVS60HPR6rZBGB94CV4+sMjbW+18G+BO7MD
 EeaBL10XWzgeEkPihc3skLndcWubZDZ/1kHUH7QoUy0BkcZQgOCXoAwREgaGEVFfZMt8AJ79sLQ
 aovOUNZ3Wc3GMUALz/S0bcgQwTiIe1APi2ibZo7ahJsm/2azcLjNNqRTEEbIB/Kh6ufjFsbQVCo
 i1GQjDrYxPJF/HldBZszgbsACiTVstTI9ZyA9Fxa+1RKETklqXWovNWNYQci0p4iiR8FRisONOL
 q0qkWjX1IjKdSvdYf1x8EjNi4Hjzijf5pXv9FoEfVqsag6C+Q9KlWhR4Ey9pDUR5Yevjt7MQ/t3
 ab52Hvr8nOrG724Xm68p1q
X-Received: by 2002:a17:903:2451:b0:2c9:d298:6c0a with SMTP id
 d9443c01a7336-2d3b0d7af99mr24251395ad.2.1786685122176; 
 Thu, 13 Aug 2026 22:25:22 -0700 (PDT)
X-Received: by 2002:a17:903:2451:b0:2c9:d298:6c0a with SMTP id
 d9443c01a7336-2d3b0d7af99mr24251045ad.2.1786685121769; 
 Thu, 13 Aug 2026 22:25:21 -0700 (PDT)
Received: from hu-vishsain-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d3aeb2a0b4sm4545835ad.53.2026.08.13.22.25.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2026 22:25:21 -0700 (PDT)
From: Vishnu Saini <vishnu.saini@oss.qualcomm.com>
Subject: [PATCH v3 0/2] drm/panel: Add BOE DV215FHM-R01 LVDS panel support
Date: Fri, 14 Aug 2026 10:55:12 +0530
Message-Id: <20260814-b4-lvds-panel-doc-v3-0-1ad152a4d3ec@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALimfmoC/33NwQ6CMAyA4VchO1uydYjgyfcwHrZRZAkw3HTRE
 N7dwcUL8dLkb9KvMwvkLQV2zmbmKdpg3ZhCHjJmOjXeCWyTmiHHkp9EDbqAPjYBJjVSD40zYPS
 RS1NohZpYups8tfa9mddb6s6Gp/Of7UUU6/afFgUIKJWoDAppsC0vLoT88VK9ccOQp8FWNOIPq
 gTfgxA4tJgIkryuq3oHWpblC4k8ZN8CAQAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786685115; l=1209;
 i=vishnu.saini@oss.qualcomm.com; s=20251113; h=from:subject:message-id;
 bh=aNzOFX7p1TZcfpEqI6Fk40hS4UWZP3pk3nIWGwaP5Mc=;
 b=hKUUIMJ7zhbPb+rvehXtpQTXg3IfsIJKDUmlgS6y1bWF6HOEYzCmTmN8XQYUgI1/l0E3eNZwe
 DYygSGK9Nl+A73N7+mvKwSyfy4K/sfWfmCMZnVTHFmA9PnCaPZ+c9t/
X-Developer-Key: i=vishnu.saini@oss.qualcomm.com; a=ed25519;
 pk=8hlXlF8j/3GeOaDK3w2LYhkv9FanCQru0c7kRH/It7k=
X-Authority-Analysis: v=2.4 cv=ApXeGu9P c=1 sm=1 tr=0 ts=6a7ea6c2 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=dmYVuBIMaTYquxi6TZ4A:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: aJd1wCv0rqpa8cwZQP1c4PZka4HYGZUm
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE0MDAzOSBTYWx0ZWRfX5A+mjpGoSSzw
 Vl9tUPfrZvs3hzBJG07IA8r2/fcFIvFkCvl4NA+RgFiCjTAmW7lzwkbwmBuGGfQKX0IjTVwv05c
 4D/Ogdxd10DWYBEYCz2oSjBeg863+b8=
X-Proofpoint-GUID: aJd1wCv0rqpa8cwZQP1c4PZka4HYGZUm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE0MDAzOSBTYWx0ZWRfX+sIb3jMuUgeN
 sh8YR9AaFN3Nyc6r1GxK0S0dxMhT7mmqa6epXm3jeSWUPHhSHuqOcghmIZ7FMa6ali1zsiYpBOR
 MzB6ikorOrA6DC7or/yn7M/BtpPQlm8pyi4aDCsodtBZtNyRgTrJiJJtrQ+UrRcgPxvhS7awTAl
 NGTs8RDYbRPTtHBXgrpz1lL4VHBgiG3CGC2Cjg1FWwIHZJadAZEQkzyWJjYEpaBKm+esZfiHhCs
 sdZAwlWIzwVaNr+og4JuS5D4N7sGc8mJtZC3pJlwUhUPS5GHyy/iermv106OTMb4RENTjMRnDvv
 +xR6r483xw2sXKk4a/TxSNASn//gXHXfdDV1Up1dBDCXDrJDRZRzKM6S3CrXBg2u9reblFGsx5B
 BN7E2CObK05hTuwxAeNxzhlSr/4NTRaO1WT3jcTrFjiqFOzgYiHHyaPoWOUa0ZKP7D2xIw8NOCM
 im5SJf/ulW/XBJsWOvw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-14_02,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 clxscore=1015 adultscore=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608140039
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
base-commit: 104c00917264c5b9571072471e3a8689cd1a2c4d
change-id: 20260719-b4-lvds-panel-doc-cb503c4ba2be

Best regards,
-- 
Vishnu Saini <vishnu.saini@oss.qualcomm.com>

