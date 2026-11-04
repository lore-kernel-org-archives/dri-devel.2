Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B36606A326
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 09:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=hys0TX5T;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=KOhWnD64
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 099DF10E89D;
	Wed,  4 Nov 2026 09:12:01 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0614310E857
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 09:11:48 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A48Kf0a175208
 for <dri-devel@lists.freedesktop.org>; Wed, 4 Nov 2026 09:11:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=H2B5SGJlFgy21hJZry/Cqu
 PSo2DWZ1AoJ09UdiQ0LRo=; b=hys0TX5TBZYlzyDg42eQBNIgnHgwauEItfK7UG
 396IvuvL/C3oXqDXI9oQknLGifomiwibAuomRz92eqGThtWw2+zYdu7fIHS6TWA9
 2wFy4DBL5AkcQRiQqpqNjIgs8xIA/UA75Lrcua8uBUcIEmnNBX34ePCJgDMtZTR4
 cwhPuE31+CGXuIM4dsw7Kj0pMgz3c8kEbr6jczg5wsNpvbYuFmK20CmE+DVaDMc8
 SqysNxZEPj/riPjKukVCnhEvQHPvUdeFcQ5yWF399R9UPMOqrWGyCIn3ZDsFW+6R
 WrGYlTIHr4aY82EAORpaVKii9aXdxXe9uJYA3NYgodQgCNcw==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hqmjbu7mq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 04 Nov 2026 09:11:47 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-3abfcf726dcso777571a91.2
 for <dri-devel@lists.freedesktop.org>; Wed, 04 Nov 2026 01:11:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793783507; x=1794388307;
 darn=lists.freedesktop.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=H2B5SGJlFgy21hJZry/CquPSo2DWZ1AoJ09UdiQ0LRo=;
 b=KOhWnD64j3Mz/vcpuGwloNp55KBS960IAWjqqWgTMywUtXWu0P5+RdEM7jorpLdPde
 gD3sCAuAUemOIU8u9swezJOBfY1WOQlKb96ddJYeEu+gHf6N/IaJboGSZfAuRwkjtIfo
 nbmzSHpvs+FGN6/wbTPCMwb6uXzbeHUEdKx+HVIHIDc3QrzRP923ofmEvmfFlqUYdUGw
 W6asVdUgBkcHzKqwp6PKr2Eom8EGnXApF6P4x+hfgtm3AsfaVl+dAALNwsXpSOyyI1B3
 b4jUukhNcL7nx0zY7V41dhhVAHL8hllz8CvUHUSpSZhkBFusrePO/qeXV3DQnvixFG74
 s/8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793783507; x=1794388307;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=H2B5SGJlFgy21hJZry/CquPSo2DWZ1AoJ09UdiQ0LRo=;
 b=HI5cEP9AFrQMbcAcNn4K8xDrgWLVV456Fl+0dUasgbV4X5oiB7o/TlNv/AhScSBeJ+
 wqrFP/MbHMpS3JQh1m0JHeIxyoRv708zuqiXEY+61nXSJuX5i033yPNRkR1j3faibPPQ
 L0nEg2+l6CPyYGYDqyHStb3iFq0+3AHmblk5Q2joB7i7AN5ipeGB49HxPhkB49+us847
 SOEBvmcgtcSTyPbrzamvFm2yMO6/E2SjSqCzsSL73imZI1Kj5n8+JBt86DfV1xRZmR4N
 Z7nMOtEeQR7y97kMUmkj1VMoZR1V01sAieAP6dMscBuUSksjgnpurmsSFxEItlo6LDyB
 jPHw==
X-Gm-Message-State: APuU4Z8PgnUXymV9HxocZ2tGUUyX/6rLTvosiobtTReuMOPi2tJkxv95
 nWaoxB3IeYE2Y6xE6bUx8Q6wLnAuRCFiY/RsqfwjMunrEcKFC5ynuwvfew1D79lKQDgKTzKqxok
 hfs5mvQw5D6JzW9wJH7ifcyUutBE+IRgYtqCGn3F+LMd7K2+oOe407EU7I+vYErtUvldYa08=
X-Gm-Gg: AYBFou15Wp5LVloMZPuVQbWVa5j1a0tVQq9a3mrTNgGXCB2K2en+/c2XjCftHTXqfhZ
 Fsijie3o0XYgNmjAmujCMpJvMu/6G+r9sFfZSGYXIAGgdP0PG5QcAhmj+5kOO28QxG+n2wCs6pY
 7cWWNkm2eLQ5/4u5rbS2CTa5n6qI6xj/OuL80cuvjfNQNLWNzR3H273PeGjADySH6QNwlZZqWq0
 AoIcesb5sKhq+cxMDL5scJxY2rC1NOMWpwm6cQwv/GkKA1FQSV0la1llG+LOKaQ0N0G5ZlC2uaa
 2CaEzudtgjRZ1DvrbO5QfmQbvKUm3sUVCxSYkpc72m6ME5zInmadHKh6HdisgqtIbM6x0d3XB9B
 jngaOLjTFf6kSIreTu6U/iWhQwIj/AtYmgH63NzSW0l2UdUQP+r2pTwakSEthXPaMSrivdzx55S
 jnTENyEhA1
X-Received: by 2002:a17:90b:2882:b0:3ac:8897:7b9d with SMTP id
 98e67ed59e1d1-3ae89574cd6mr13912248a91.1.1793783506799; 
 Wed, 04 Nov 2026 01:11:46 -0800 (PST)
X-Received: by 2002:a17:90b:2882:b0:3ac:8897:7b9d with SMTP id
 98e67ed59e1d1-3ae89574cd6mr13912209a91.1.1793783506302; 
 Wed, 04 Nov 2026 01:11:46 -0800 (PST)
Received: from hu-jshekhar-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b07c896cc6sm8253877a91.9.2026.11.04.01.11.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 01:11:45 -0800 (PST)
From: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
Subject: [PATCH 0/2] drm/panel: Add support for Novatek NT37802
Date: Wed, 04 Nov 2026 14:41:35 +0530
Message-Id: <20261104-jshekhar-nt37802-v1-0-58e5e7fb2556@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMf26moC/yXMQQqDMBBA0avIrA0k0VbrVcRFOo7NKETJqAji3
 ZvW5Vv8f4JQZBJoshMi7Sw8hwSTZ4DehQ8p7pPBavs0RpdqFE+Td1GFtahqbZV7OF29sMQeCVK
 2RBr4+C/b7rZs75Fw/X3gur7pRRu/dAAAAA==
X-Change-ID: 20261104-jshekhar-nt37802-a5a079c4cdce
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Jayant Shekhar <jshekhar@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793783500; l=1143;
 i=jayant.shekhar@oss.qualcomm.com; s=20260925; h=from:subject:message-id;
 bh=z3uvju1pN5NHrCsshehfOyEGWd/5HX3WCZMbJ6sj91w=;
 b=X9Tx0Q3lQhYYdNB1elLXJJf+WfAbrOm018IM2ixlNdww4xKtt8J45R3/2Wo53DObcQkC2bOU2
 WxpOiETXiEpAAEu/cnsw6fE8WuOgmCXUvjK5hfOcDi9qj16FdFI/EDa
X-Developer-Key: i=jayant.shekhar@oss.qualcomm.com; a=ed25519;
 pk=saYTwtCCpug4b0Hz0jHFoATgDtdhFVicwMzDJo2z5ZE=
X-Proofpoint-GUID: KzdgQYtoXN7Yi73k5z06UhRPjINxGtho
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDAzNiBTYWx0ZWRfX72SvvtDYD/2r
 bVTg/onej1EEi3HKbKYarIdiPogdA6g2Hv/7d/sN8ecVJPSiZWR3Eo6tMeyjSKg/D0FyW6y4ZxA
 2xOu7QHJZpzB+YQBUxpBounWRr+SVxQypDjsRFWHnHP0nSe5WcPw+6Mo+PmvXFfGfCD45KxMNrX
 pkt4kepcshk0vtcNCBCsiMuwhwePvIobks2M60a2tKZtNW74GmRFgFDi3GInxNh068ANguuNu0O
 umbi9l+qmg3VHaqX07VAAugjEIILzyycjPqYLPs7j3EyoYpj+Lzsvy0U+CyBd6Xd39vob99X9LY
 CrFr7u4p/Eug0QEuQBQL4zFmrxMQR/vypj6/aP27BIB3zTBfn189ma44AajWcoBPf1z5ImFfFP9
 phnnhKTjNzhTiYnyEdNCMArKzeDsTg6aATv5fra7qDoc0YlWHinBr3e4064f50Eq7fKOsu2wROg
 Bms+FtC3xi8aIqzXNog==
X-Proofpoint-ORIG-GUID: KzdgQYtoXN7Yi73k5z06UhRPjINxGtho
X-Authority-Analysis: v=2.4 cv=NMhAaE6g c=1 sm=1 tr=0 ts=6aeaf6d3 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=QthHNoVtvuTdp5M_hsQA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDAzNiBTYWx0ZWRfX/RNFG/t+5A2W
 9PjukFDsEDK/b/x/f609oQoQGDAjSuQWhIAdgi4FinEf1nWAVH36boStuc7MHK2ViUgkM1VFQa4
 PM+sr2EgOeudWkemkbhl97XABRCTh7o=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_02,2026-11-03_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 clxscore=1015
 impostorscore=0 suspectscore=0 phishscore=0 adultscore=0 malwarescore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611040036
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

Add support for the Novatek NT37802 AMOLED DSI command-mode panel used
with the Maili/Pebble platform.

This series first documents the panel's Devicetree binding, then adds a
DRM panel driver and enables it in arm64 defconfig. The driver provides
the 1440x3200@120Hz mode with DSC 1.2 over four DSI lanes, sequences
the panel supplies and reset GPIO, and exposes DCS brightness control.

Signed-off-by: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
---
Jayant Shekhar (2):
      dt-bindings: display: panel: Add Novatek NT37802
      drm/panel: Add driver for Novatek NT37802

 .../bindings/display/panel/novatek,nt37802.yaml    |  69 +++
 arch/arm64/configs/defconfig                       |   1 +
 drivers/gpu/drm/panel/Kconfig                      |  16 +
 drivers/gpu/drm/panel/Makefile                     |   1 +
 drivers/gpu/drm/panel/panel-novatek-nt37802.c      | 544 +++++++++++++++++++++
 5 files changed, 631 insertions(+)
---
base-commit: d6bcfc94eb4da6e089c5473970cd96727292fd97
change-id: 20261104-jshekhar-nt37802-a5a079c4cdce

Best regards,
--  
Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>

