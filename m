Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2FBCCD8CA4
	for <dri-devel@archiver.kernel.org>; Sun,  7 Jun 2026 21:33:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 413A510E334;
	Sun,  7 Jun 2026 21:33:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="L2LfIuzb";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HxTJusKw";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DFACA10E110
 for <dri-devel@lists.freedesktop.org>; Sun,  7 Jun 2026 21:33:11 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 657HPg5u759908
 for <dri-devel@lists.freedesktop.org>; Sun, 7 Jun 2026 21:33:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=jblTWUHfA/HboctDjWft8F
 Ef3F/d0UhRTWL81VYIHP8=; b=L2LfIuzbnOz501Gk+Rk8aeBP68DsRrjFU3/BHl
 4iwIYq7RaKcvKKSA30BslfGIzkS0M8xL/5FYT86z9dQyCZ+S8ap2iJAD2DDCjehp
 unoFu8KeNWmwpVa4TZwPfT8bapDBSF6UVaU/6ic8RiriVb0UC6pc/G7+sJvi0ifx
 4wkI2UwyiXgG++GschL1OPccAmz9/h0o/WJihafTyzREFXGT13PdGVO6rcB0G/j2
 FX8wr3VXJFzWwmgItRk6bgjmJEvvHn6rBm/0LAi+Dgv20YqDyTSpLWlk8TTIaId0
 +ccaDAjWL0anasc8mq7ULrQdAeRb/U63J+guhNizAJ5pfGXQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4embs1cpym-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 07 Jun 2026 21:33:11 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-5176cc5bf2aso49170551cf.1
 for <dri-devel@lists.freedesktop.org>; Sun, 07 Jun 2026 14:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780867990; x=1781472790;
 darn=lists.freedesktop.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=jblTWUHfA/HboctDjWft8FEf3F/d0UhRTWL81VYIHP8=;
 b=HxTJusKwhuf1pCBHxvUNOw7prrjG7NhV/bCWt3Ta7+4Z5io7bNq9yNnMhn0LetIlqg
 MFPqt2257m5NqPvRh2EUknCfGuBmF/Tpdwj6Zon6KDTwtHEyIP517qptAzasZfKWLFSB
 ZxyBweQWBbUpclEx+eg68b92McU4RjOwTE1eTYZ9S/U43SxArQWgtifCRgVp5egKLuhC
 w1uiwIkTSEsZ9QZM571AKi4x7o1wSAhquHfEa8Ac9Ulbza4NpS8dohaxEeEGi5QCzgWM
 6KnEmkwMEryilp8OR11mIMZ2F26IO/8Ir8/FLVC8yJ78QKXiqMUllZ6HYPn1u/wm/cPH
 /AsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780867990; x=1781472790;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jblTWUHfA/HboctDjWft8FEf3F/d0UhRTWL81VYIHP8=;
 b=hAm2H2e1K0WTes1SlMP70DVuAp12UILD7vADTnaQVTomWDbA27vd+jgpw2PVoZdrGP
 thB6fM2MZg/whsWtEZvfAcWQeqDqqRkiszKbEUGspi0EgVWmR++hGzb6Am38sQ0V4I79
 2aWutv6Tl/JO3e8lBaVDoqaInwYeOgu7J5bC8nOtQuD7BiBnjdXp0byU8vc1vExl5n1+
 4LxPp6xcbqKGtBZvqO/XTOZkyxz3FGCzakxmZIfyhsFqsKrJkCdvy74pKlaYHJKcCeYm
 nnXbBDGQ2z+UVIo1Do5nbKszRoVdWxP78qcWECc9T7qkuT3TAh4bP5QVCrGlfbjfe6HY
 5PTQ==
X-Gm-Message-State: AOJu0YyknS0FGgMuzXLYe9v81Lyx3Bt2dDehGlyRKMBoqoY0GXcIday6
 mjDQCEH5NqKZB0GybiMfPi0l7XXNf92iTDVcrre+8Tm/a/hWY/fGf5hdfsbiTlrBDdBazKJDnEU
 lClX72zEqTcN9jQ7DGeaFjwub39YdLkgqJRKq+viwsx2PBkmKZ7jYP+GBAlIc/O21df69SpM=
X-Gm-Gg: Acq92OEFbsiGwqhrzhza7IZyIvIWQqputfE0bkY0iHsRlhLhCz4rc1hQ5nF7Ta6gPKa
 Zip3ZaqAk7j0Fdm6UCl6/dBx/fPMCxBp0IyDHcHvhYkVQy2e/w0tJmcPZxLepUE78tnhc/hnKIE
 gWrVlBO81oqxs9BNrmR/do4qqjUy474TFTEB8ct8adSC6irBOJYs1j0/wfsy60AMY4nz+e1IlHk
 aXnPxs79LwojEVFk27xyYBIlUhj+lJd2ajaPHsrpSu4VP0zJZqmwHwLO98aOfLdHG70Vxsc8MUi
 8LdWaerO7LrkatDT7zxHCLZ1KV2beS31cg9RuXW+deF/BFnL697Qu+J5g4aXph/gpMR5qLioHoD
 UYsSlzGyHVe//Zsgtrp25q0ScTeBEnnLb2pCq0BQmeYwB+XLXArAk7Z39gEg9TdpoBh60+NvqCx
 WV2vg33tWhQPNONMJ3Y3bLvCi83HKHZYexK6sF1uK4Xi3LPA==
X-Received: by 2002:a05:622a:5b9b:b0:517:8011:3a4b with SMTP id
 d75a77b69052e-51795afce80mr169961101cf.21.1780867989989; 
 Sun, 07 Jun 2026 14:33:09 -0700 (PDT)
X-Received: by 2002:a05:622a:5b9b:b0:517:8011:3a4b with SMTP id
 d75a77b69052e-51795afce80mr169960641cf.21.1780867989510; 
 Sun, 07 Jun 2026 14:33:09 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-396ac2d5ea9sm40374041fa.32.2026.06.07.14.33.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 07 Jun 2026 14:33:06 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: [PATCH v4 0/8] drm: handle IRQ_HPD events correctly
Date: Mon, 08 Jun 2026 00:33:01 +0300
Message-Id: <20260608-hpd-irq-events-v4-0-30b62b335487@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAI3jJWoC/3XOywrCMBAF0F+RrE1JxtiiK/9DXOQxsRFta9IGp
 fTfTSqC+NgMXLhzZkYS0DsMZLsYicfogmubFMRyQXQtmyNSZ1ImwKBkggtad4Y6f6UYsekDxQq
 UZlUp15aTtNR5tO42g/vDM4dBnVD3WcmN2oW+9ff5YuS598LLTzxyyiiXiluurQIFuzaE4jrIs
 24vlyINkm9EeFOAfSmQFMHAWoQKN7j5o6zeFf6lrLIiDCgrmLH61y/TND0AV+Iri1EBAAA=
X-Change-ID: 20260414-hpd-irq-events-e72bc076a5f1
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Adrien Grassein <adrien.grassein@gmail.com>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, Kevin Hilman <khilman@baylibre.com>,
 Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Pengyu Luo <mitltlatltl@gmail.com>, Nikita Travkin <nikita@trvn.ru>,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Francesco Dolcini <francesco@dolcini.it>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-usb@vger.kernel.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5359;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=j+CeXz78taySpKFMgaVaZqhcJr+l+n1DMDxWadehxu8=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqJeOPB+d8F5P2SnIo0A5TZpKhUphLa8Cf8JZks
 hO1jgGRu36JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaiXjjwAKCRCLPIo+Aiko
 1RZXB/wM5Cz36duGVcpFpTg+7AChBnPfRCnS3e35NCwMw9V387AvmW80xExOATKDWQTOqT2RkHP
 FucdJGus1gNVFo6zeGGfrMkBw4QdH39zFlJur4zEvOohIq1q8lILqnD2IZIkk+n8BuweDqcvdIk
 bOpJgB4TQIng0KRTMbmFhEv19wfYDufGVnyATZfRUxJxSYCEI836vRuLGaC3x304UI68T+ZGf39
 FWT0yfI2wKDWeYX1XWZx2XOGrJkmh+MawQeR2r7Ot6rsGUph5B6vl4NPo9C7n8ahkRaixUrpBiI
 9j/i/VYwNLYSnamL2KE0gQlOPviFkgkRwVzWh7lXn/04XAcc
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA3MDIxNyBTYWx0ZWRfX5PMTjgDrqHQa
 xAoapUU4hF6r6APt/nm3szB4i9SXileYs/x+Jn73tUcKQ+GhpDRoXxxK4vuR9+MUIPOpwMiJpNE
 Y7wnYn4M6fIBbQbAfyzo8ciHI1kX22WI871WZXBKzIR7/FREZU5qqWczYzjMwVarNiewbvfvfXz
 00HqeE6FlLEZuhmPH2pwKnoK6K8gl6GlgHR9fvVL+yM5o6smU4pmhsAVrluMkC8skE0lATIdl0p
 OO4wWL9I2iGZwnXbWCwcKdgkq843XVNipWgETrKWwlP3FkTYBkrWbS3x+HpzS4Il9Uk+tWO3vhx
 JtpjVw0lvsXmCYgogseXEYbgcavPOgCH7YFWJn+GNuAXG2/umgmAqh9jgkb9XuZU/uGVDBFsdvq
 8hleDoCz9aQf0Xzxc8q9bW+nqgt9iGn90FPxoNXkNNokh7V61+7TRm/2KEZGI6Z8wj7E9+vQAln
 MimolJA3QrbybRQBdLg==
X-Authority-Analysis: v=2.4 cv=CeY4Irrl c=1 sm=1 tr=0 ts=6a25e397 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=bC-a23v3AAAA:8
 a=EUspDBNiAAAA:8 a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
 a=ag1SF4gXAAAA:8 a=KKAkSRfTAAAA:8 a=P1BnusSwAAAA:8 a=P-IC7800AAAA:8
 a=GFqr32JmAAAA:8 a=IpJZQVW2AAAA:8 a=mK_AVkanAAAA:8 a=tVI0ZWmoAAAA:8
 a=e5mUnYsNAAAA:8 a=JfrnYn6hAAAA:8 a=eKQTCwoLd85be8zhlTQA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22 a=FO4_E8m0qiDe52t0p3_H:22 a=Yupwre4RP9_Eg_Bd0iYG:22
 a=cvBusfyB2V15izCimMoJ:22 a=D0XLA9XvdZm18NrgonBM:22 a=d3PnA9EDa4IxuAV0gXij:22
 a=f02Ha7HRcztGgdyUxOxW:22 a=IawgGOuG5U0WyFbmm1f5:22 a=3gWm3jAn84ENXaBijsEo:22
 a=-BPWgnxRz2uhmvdm1NTO:22 a=Vxmtnl_E_bksehYqCbjh:22 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-ORIG-GUID: 6pGQgvYKgI84uzs6w-eNedQeGPYEC7Bk
X-Proofpoint-GUID: 6pGQgvYKgI84uzs6w-eNedQeGPYEC7Bk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-07_04,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 spamscore=0 malwarescore=0 phishscore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606070217
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

Both DisplayPort and HDMI standards define a way for the Sink / display
to notify the Source / host about some kinds of events. In case of HDMI
it's as simple as singnalling changes to the EDID. In case of
DisplayPort it's more complicated and requires actual checking of the
DPCD registers.

Currently USB-C drivers don't have a way to deliver the IRQ_HPD
notifications, leading to missing MST notifications. Provide necessary
plumbing to let IRQ_HPD events be passed to the DisplayPort drivers.

Note: the Yoga C630 UCSI driver and Acer Aspire1 EC driver are not yet
enabled to send the IRQ_HPD events. Both of them would need some more
reverse engineering to find out how the event is being reported by the
EC.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
Changes in v4:
- Renamed drm_connector_oob_hotplug_event() to
  drm_connector_dp_oob_status() (Maxime)
- Reworked commit messages, explaining what it is about (Bjorn)
- Rearranged commits, making them a bit more logical.
- Link to v3: https://patch.msgid.link/20260421-hpd-irq-events-v3-0-44d2bf40dfc2@oss.qualcomm.com

Changes in v3:
- Fixed build error if aux bridges are disabled (Intel GFX CI)
- Link to v2: https://patch.msgid.link/20260420-hpd-irq-events-v2-0-402ffe27e9e9@oss.qualcomm.com

Changes in v2:
- Change irq_hpd arg to be an enum, possibly desribing other uses (Toni)
- Account for that, chaning the API accordingly (with_irq -> extra,
  etc.)
- Wire up AUX bridge notifications
- Link to v1: https://patch.msgid.link/20260416-hpd-irq-events-v1-0-1ab1f1cfb2b2@oss.qualcomm.com

To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
To: Maxime Ripard <mripard@kernel.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
To: David Airlie <airlied@gmail.com>
To: Simona Vetter <simona@ffwll.ch>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Andrzej Hajda <andrzej.hajda@intel.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
To: Robert Foss <rfoss@kernel.org>
To: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
To: Jonas Karlman <jonas@kwiboo.se>
To: Jernej Skrabec <jernej.skrabec@gmail.com>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Jani Nikula <jani.nikula@linux.intel.com>
To: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
To: Tvrtko Ursulin <tursulin@ursulin.net>
To: Francesco Dolcini <francesco@dolcini.it>
To: Kevin Hilman <khilman@baylibre.com>
To: Jerome Brunet <jbrunet@baylibre.com>
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>
To: Dmitry Baryshkov <lumag@kernel.org>
To: Abhinav Kumar <abhinav.kumar@linux.dev>
To: Jessica Zhang <jesszhan0024@gmail.com>
To: Sean Paul <sean@poorly.run>
To: Marijn Suijten <marijn.suijten@somainline.org>
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
To: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konradybcio@kernel.org>
To: Pengyu Luo <mitltlatltl@gmail.com>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-usb@vger.kernel.org
Cc: intel-gfx@lists.freedesktop.org
Cc: intel-xe@lists.freedesktop.org
Cc: linux-amlogic@lists.infradead.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-arm-msm@vger.kernel.org
Cc: freedreno@lists.freedesktop.org

---
Dmitry Baryshkov (8):
      drm/connector: report out-of-band IRQ_HPD events
      drm/connector: pass down IRQ_HPD to the drivers
      drm/bridge: aux-hpd: let drivers pass IRQ_HPD events
      drm/bridge: pass extra events to the HPD callback
      drm/bridge: pass down IRQ_HPD to the drivers
      drm/msm: dp: handle the IRQ_HPD events reported by USB-C
      soc: qcom: pmic-glink-altmode: pass down HPD_IRQ events
      usb: typec: ucsi: huawei-gaokun: pass down HPD_IRQ events

 drivers/gpu/drm/bridge/aux-hpd-bridge.c        | 11 +++++----
 drivers/gpu/drm/bridge/chrontel-ch7033.c       |  3 ++-
 drivers/gpu/drm/bridge/lontium-lt8912b.c       |  3 ++-
 drivers/gpu/drm/bridge/lontium-lt9611uxc.c     |  3 ++-
 drivers/gpu/drm/bridge/ti-tfp410.c             |  3 ++-
 drivers/gpu/drm/display/drm_bridge_connector.c | 22 ++++++++++--------
 drivers/gpu/drm/drm_bridge.c                   | 20 ++++++++++-------
 drivers/gpu/drm/drm_connector.c                | 22 ++++++++++--------
 drivers/gpu/drm/i915/display/intel_dp.c        |  3 ++-
 drivers/gpu/drm/meson/meson_encoder_hdmi.c     |  3 ++-
 drivers/gpu/drm/msm/dp/dp_display.c            | 10 +++++----
 drivers/gpu/drm/msm/dp/dp_drm.h                |  3 ++-
 drivers/gpu/drm/omapdrm/dss/hdmi4.c            |  3 ++-
 drivers/soc/qcom/pmic_glink_altmode.c          |  6 ++++-
 drivers/usb/typec/altmodes/displayport.c       | 23 ++++++++++++-------
 drivers/usb/typec/ucsi/ucsi_huawei_gaokun.c    | 11 +++++----
 include/drm/bridge/aux-bridge.h                | 13 +++++++++--
 include/drm/drm_bridge.h                       | 31 +++++++++++++++++++++-----
 include/drm/drm_connector.h                    | 24 +++++++++++++++++---
 19 files changed, 152 insertions(+), 65 deletions(-)
---
base-commit: 6e845bcb78c95af935094040bd4edc3c2b6dd784
change-id: 20260414-hpd-irq-events-e72bc076a5f1

Best regards,
--  
With best wishes
Dmitry

