Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4FC3606A31C
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 06:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=L1y+eOu5;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=XxzTMxee
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 154AB10F03D;
	Mon,  9 Nov 2026 06:27:38 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 797C210F060
 for <dri-devel@lists.freedesktop.org>; Mon,  9 Nov 2026 06:27:26 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A96Agoe066512
 for <dri-devel@lists.freedesktop.org>; Mon, 9 Nov 2026 06:27:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=I6P/+/Ar1axx3nC1T+ZFo1
 xV01iG4tHc1syUNQX7w18=; b=L1y+eOu5LiT5vHGcvIarNbHENiE1K1qAEQcKbL
 A2Wr8B4tOdF0xKk3MG37atArNp2RdPOf9ceRjKXB+KXXFTsIEXVhQKEwRQItlaNj
 RjaaV2fa1TfvmZEUYcpUDIzoCTF0SG7xQxoeGYIHhlhLUDgPnFC9aHdwhLE0bSvs
 rsHOM/wat8SENxUIk6rjkygEvErJJxEZF7JUNev21mLpWi9BIHVSyYNEQMbAD3aW
 DQUZ6X4aHIKs2mCVdhZUfywzqcEltyMgQsutQEMmPVSzskoTHAD1MXGYDKRsS616
 +T36IJQq+gAO3ivArBEOfpn+9G7w707BnX+ehRqoHSoKQwCQ==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hsujxd3rw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 09 Nov 2026 06:27:25 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-341eff9e381so1504317eec.1
 for <dri-devel@lists.freedesktop.org>; Sun, 08 Nov 2026 22:27:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794205644; x=1794810444;
 darn=lists.freedesktop.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=I6P/+/Ar1axx3nC1T+ZFo1xV01iG4tHc1syUNQX7w18=;
 b=XxzTMxeemRWRNeBbzdq5pa64u23k8j50C22I9OUcOVdXNpY6t9qB9rsV4OCUPRSrWf
 AmZHuA4easUoHEOkHfBegs2X+q3bcjtpBaIw6R59iTecmx2Kqrd8vGuzqYG3NKnOUzgb
 5mvIQVbB7H9JxOfryFgtnPF9OICOdLCDJLfO7Bz7ppEqXWeueMuMqXoLk6TeTwH4X+w0
 Ap4yUmutEQs+vIzoTYH/nkLGPA4nIJC4QhALvHbx4OgyI4YQXFDkmmQAiwdy6doAX1KF
 s/I2g/fxvmzJl/mXIJWTcu7hLHDo4sFQXao2j2uWi+qmW5CYFkkeYoPPGSOlvqobWKyY
 HqhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794205644; x=1794810444;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=I6P/+/Ar1axx3nC1T+ZFo1xV01iG4tHc1syUNQX7w18=;
 b=gMc0HjJ2P1BWjO6M9yfasqV3jy0UMy1n4/HhvmliosDrTAczYEZ49j93xhbsGRdXCH
 8y/exPykRM3gb8ifJ/1JYlaiwLNpK61CknsPWfwPU69v7lODksM4SS1oyTh1L7pSe2Zm
 AaicqG56OgmIwemx/98LcCCWE0A5qdEUYvuUr3Zsy1oMjWvKHs7CUueqnkxTdMrSbwmA
 GcU5Zcikwv9/Q4366IhlodRiOs/ynlCagrtZBiSa2lQ5IZygQ8Fcj1HmCHXf3WdH6yg4
 zpXDR9eRxNT6u7aljmGOCm1lzhML8uC0sUoJgVMI88Zz41ibGxI6/YiLCd4jDr1e/QMb
 uVyw==
X-Gm-Message-State: APuU4Z+CmxFdSyU+UqHWjW4arrd0KqNSxCJwaVxRTdhO4w2qAnduf964
 fSec/GfKiT3aEnxWEjlypgiBIVCHo6KubZz9ONgQO/6WklwmYQKcAw0dGdscrB96eauiNyUXcQQ
 WiETT0erkfOsdzDz3IpPpcRAKXAjjGZi/nwKjaOoxhuYueDMinDfWadUjSJS6RN939Bt2LUg=
X-Gm-Gg: AYBFou1lZ24pIknE2sgMUDT+0Qyw6W9a462wxXHroongaqA38YT+4b+pat5HNgQ9YYK
 E231sow9dW9oWIQ++WsJ/pj5bMFzdkC0h79de0iwknx3fXaQpyabSOWv+SK6D9AtejOm90U3J5q
 aNQntw2owoa611qAXYEpvHuMYEsE+q+92i2NgF/F9ZBsRrppBbZUZyBA4IBngENZgeE/rcnaedZ
 03RAEREfush+ys5Ior+aeqfrPo8Zf1NUkAyBSjES+xJiTxgDX4xBU1OmrUN6sUt1xvhZgtnSYu2
 jYLMSdainR8j/P9n5+PNyQeu9ainF27+RoiK29RsuACHSyHpK4SirhcevngMZhaOgJ6qWdI9bDk
 sYuLFx6hFXQWDAKxKb0y0QjQI4XR9ScPkjl8HJfaApKNuCpWWgKeZOLRszvktl0DAEtMqWk6F9k
 ooTJMKjQ4=
X-Received: by 2002:a05:7301:618d:10b0:36a:3453:a356 with SMTP id
 5a478bee46e88-37276535d08mr5879261eec.36.1794205643901; 
 Sun, 08 Nov 2026 22:27:23 -0800 (PST)
X-Received: by 2002:a05:7301:618d:10b0:36a:3453:a356 with SMTP id
 5a478bee46e88-37276535d08mr5879232eec.36.1794205643383; 
 Sun, 08 Nov 2026 22:27:23 -0800 (PST)
Received: from hu-jshekhar-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-372660f444csm15812458eec.19.2026.11.08.22.27.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Nov 2026 22:27:22 -0800 (PST)
From: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
Subject: [PATCH v2 0/2] drm/panel: Add support for Novatek NT37802
Date: Mon, 09 Nov 2026 11:57:13 +0530
Message-Id: <20261109-jshekhar-nt37802-v2-0-a8e9efdcabd7@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMFn8WoC/32NQQ6CMBREr0L+2pK2UkBX3sOwKOVji0K1H4iGc
 HcL7t1M8pKZNwsQBocE52SBgLMj54cI8pCAsXq4IXNNZJBc5kLwjHVk8W51YMN4LEoumVaaFye
 TmcYgxNkzYOveu/Ja/ZimukMzbp6tYR2NPnz2z1lsvT/6WTDOVIkKi7aWSuUXT5S+Jv0wvu/TG
 FCt6/oFV6Kcd8kAAAA=
X-Change-ID: 20261104-jshekhar-nt37802-a5a079c4cdce
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Jayant Shekhar <jshekhar@oss.qualcomm.com>,
 Krzysztof Kozlowski <krzk@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794205638; l=1979;
 i=jayant.shekhar@oss.qualcomm.com; s=20260925; h=from:subject:message-id;
 bh=FkR9f1cRWmpPscVyf3yZZzodXrTf3YT8+24ASTDxW5s=;
 b=2ulozcueZqDqpHWeGJjX6hJAQs4SqUcC4nFygoleItg9+WBmpeZz3r9I6y3DzrlgISPkqWh+a
 2mf3SROcaNOAP8lyceUDkBHoiK0l8UsGnhphyFQkYwSioImOnpjDzLi
X-Developer-Key: i=jayant.shekhar@oss.qualcomm.com; a=ed25519;
 pk=saYTwtCCpug4b0Hz0jHFoATgDtdhFVicwMzDJo2z5ZE=
X-Proofpoint-GUID: 57JjP1nTh-34jJ-aTSHVzqBkM7Ea-jdR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDAyNSBTYWx0ZWRfXwhmvJuFymnk2
 X/XwkHTjDpfNApfx8extwHtKUmzZdK6D3lMG22FEp6I7+bo2fxVdiYXEy5KKpOKxU1+59z4ypU+
 IUFKiOb8lSl+Vz/VCazFRp21sZ2/m5QWbVmCxf4dfuSq1mKMICbTVNwW8RJ60TjE+U9+LpM2vVJ
 Wch6eIOjXI0FADeEKdcBqo+8ZSjJAMbase6ivpIZPKOK42jkP1AE4lMAWjTsPPpnrVgBuYUpxA6
 k3KZ1jQXThGzN0MB4/pUzJDJM2BmEgeDl8cIvxI/1EpgD1K6X5ZwV5Wwr3/SvmpadDdsStnZocg
 babu571XL+TozlQ0+5zTCXjlThZrubksCtV5xpex/LSAjezl7tizpZ7bEBAAai5yiSJQv/E+ta5
 mmov8tJI40WVlapv9yBoafqLNAUV0nr5ks/RYDBMNieuAEa1Au6QHU8GHiyk5kLvhh2Zo8UsWIe
 8kbUG55H6/FpIl9JNWw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDAyNSBTYWx0ZWRfX1j3/5cR5PjdE
 JUSSHnN4hEHry1aSe77edpt31jCykW0Od26GeHC764Cxx4dWYt93YUvw0B1gxMWJ8i9ddMIB4WP
 dQ8KWPftS0vojvcJX0GxcVOWC/CaP8s=
X-Authority-Analysis: v=2.4 cv=TeIDJhQh c=1 sm=1 tr=0 ts=6af167cd cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8
 a=pGLkceISAAAA:8 a=QyXUC8HyAAAA:8 a=e5mUnYsNAAAA:8 a=0fWOHazxJtL7KIpFMY4A:9
 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22 a=FO4_E8m0qiDe52t0p3_H:22
 a=cvBusfyB2V15izCimMoJ:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-ORIG-GUID: 57JjP1nTh-34jJ-aTSHVzqBkM7Ea-jdR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_03,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 phishscore=0 bulkscore=0 adultscore=0
 spamscore=0 priorityscore=1501 clxscore=1015 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611090025
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

Add support for the Novatek NT37802 AMOLED DSI command-mode panel.

This series first documents the panel's Devicetree binding, then adds a
DRM panel driver. The driver provides
the 1440x3200@120Hz mode with DSC 1.2 over four DSI lanes, sequences
the panel supplies and reset GPIO, and exposes DCS brightness control.

Signed-off-by: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
---
Changes in v2: (Krzysztof Kozlowski)
  - Extend the existing NT37801 binding to cover NT37802, including its
    required EXVDD supply and an example; drop the separate schema file.
  - Drop the arm64 defconfig change from the panel driver patch.
  - Remove unexplained Maili/Pebble platform references.

- Link to v1: https://patch.msgid.link/20261104-jshekhar-nt37802-v1-0-58e5e7fb2556@oss.qualcomm.com

To: Krzysztof Kozlowski <krzk@kernel.org>
To: Neil Armstrong <neil.armstrong@linaro.org>
To: Jessica Zhang <jesszhan0024@gmail.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
To: Maxime Ripard <mripard@kernel.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
To: David Airlie <airlied@gmail.com>
To: Simona Vetter <simona@ffwll.ch>
To: Rob Herring <robh@kernel.org>
To: Conor Dooley <conor+dt@kernel.org>
Cc: dri-devel@lists.freedesktop.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

---
Jayant Shekhar (2):
      dt-bindings: display: panel: Add Novatek NT37802
      drm/panel: Add driver for Novatek NT37802

 .../bindings/display/panel/novatek,nt37801.yaml    |  49 +-
 drivers/gpu/drm/panel/Kconfig                      |  15 +
 drivers/gpu/drm/panel/Makefile                     |   1 +
 drivers/gpu/drm/panel/panel-novatek-nt37802.c      | 544 +++++++++++++++++++++
 4 files changed, 605 insertions(+), 4 deletions(-)
---
base-commit: d6bcfc94eb4da6e089c5473970cd96727292fd97
change-id: 20261104-jshekhar-nt37802-a5a079c4cdce

Best regards,
--  
Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>

