Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34715CD37AC
	for <dri-devel@archiver.kernel.org>; Wed, 13 May 2026 18:23:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E84F10EFEC;
	Wed, 13 May 2026 18:23:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="mxb4eT35";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NICz40TK";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E76B310E339
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 18:23:52 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64DH5xue1393026
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 18:23:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=/8lnfbEOX7ej5tjeRNuBsa
 gcrk13r/0jAm1jfC+Xj3w=; b=mxb4eT351HYUVNlaFmZ0YbQdmIqO58P1ttDhsi
 LZ62cFmcw4jzMfy5sq7dc9VPZVpJ03HTiRQZxoOyvywpTsL8tUb0NvneP2g75+0c
 AJYFN0IkImN4tdEAR53mJY8D7NQMwAS24bgVMFzTC55s8cfgtOmKOmiIFMH9dbZ7
 G1BpMZ734vtj9Q4wXel4ZBn/sed0rmZQqLn/gZp7T87xxUpRadk/9H2XA51IXhD6
 +/p57z4p3ajZwI15QX4ktjBUUnvPvvp9FJ6hqHQTIvNopxrw2tpEH8DG1Tsmiesr
 ZDbcduU/D2tAtc4NCTUgz+eiI0U688wmj+nj3MV4sscwxGCQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e4k26328t-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 18:23:52 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-514ae0e3ad6so108334051cf.0
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 11:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778696631; x=1779301431;
 darn=lists.freedesktop.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=/8lnfbEOX7ej5tjeRNuBsagcrk13r/0jAm1jfC+Xj3w=;
 b=NICz40TKrrSxfa/MvriYP0i9hgxn6uVgmMAhcPxuTlN6STOHp5DOum/bArrD4HVTa+
 p2dc/grViqqiBSBluxDxG6loTJ8z2DEFp+6egwWs0c8X03nV6epSqmqYJxhjllcLf2vt
 fMIupS1c3SNoNa8T4sy0kFJ8KCibCxzDAmm7FZzIjQXk9iU2NV61zdSkCc0Y7+dmEvaF
 8oQMGQug5y2TrquwYEnJMwmoqL5A0ecnwjtbYh2QO6K55RV6tRCZx72YVWGoftjB25gO
 94zS+HEroMVINzrRp3knPmkFvh5nUK1OOXCng9DSUDpNjsQEQu4riKGRovAeEbsrcxDe
 vCgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778696631; x=1779301431;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/8lnfbEOX7ej5tjeRNuBsagcrk13r/0jAm1jfC+Xj3w=;
 b=NnsqJxoyZi5/n5y7QysCOEgu25oS2S4KzzZ1+NbV2bncJZ5mktYcJluxsVBD/lXclo
 HRj/FskjXBL+9qrLFnYn+mwxBRyrzNHXTe1WHhvXpoD0zjSQiDY4DntOGXJhf3sOQZMq
 nAgmfASenl5pF5ZvlFChJjBtxmvoBgduXNMQm9V5OW9h3mDzGcyWzIFJGQyTqsMVVtl0
 DgcxezDCVanXMJfwBt8UeUJmBqh0zV8bGJ9cAS/IvmYboEHLphzAKbnAeOESUWzA0C8Z
 T4GBIfOxugZaisekfrS443+n2ENDhL8QXcrUPQ1Jlvklyq8E0IYg18BzgMa/epvnczWW
 famA==
X-Gm-Message-State: AOJu0YxtzoVIEfkWq3nkoLpv6o7rqjuA41XCL/JwvekrFq+8Gl40V4IX
 w3gxoiQOxWSk6HHreVMYEM6emw6DrpC2QFswGGP4I4mATPyrM/5IAMIMD0ylXev+cMB7+/LOkxp
 MvOB3uxnQZ8wxaVFyd5P/d9CuP43MYXHjpTvcWj/HBaaVSvMjnhXzynTg8AjXLdeb9qLkYpI=
X-Gm-Gg: Acq92OGfdCyQ1OMRpzQgzr9r7VYk63dScoyixsMQ5IUhCyqXqfMJFI2rf822f1k8W2m
 hn+xmRiZwX51HeoTW+b2iZakas5aDvy+PZMyxr5VVjPK8byRgg1djff5kiBui89oiwAcp2A1gQu
 p7gQUl4PGVKiS6NAQfvUZZaS+uiwVOX8VwxfWPj5iuW5ebm/tsPGuNrJSVn4gGYhDpTIxgh/z81
 WMYPSMW1HpOQzlYDJwSiGfdlQZwrcy4+4HsLicAZNpD/7MG/FHiHlsmXMVDfH1UzN2rLVPAXupd
 D6fQOcMs3MqjWs6krKjhMiUCE5fidXglWwoUHGK/ByeMx4zcDTkZ+kg6yiGIUrETjwtkPnWPlqv
 ldVQ1L9ATXhoufHlVumBwUdrJ+I0NW5wK3k/DJikaCrHzfyXiPdAZ5IL+QWZkfwc9WvulAtzz/P
 VVVrs3ly9rovSCTHjqH1CazQaBUT3dMH2MG9c=
X-Received: by 2002:a05:622a:8d09:b0:514:cf96:7638 with SMTP id
 d75a77b69052e-516415a239cmr8446031cf.15.1778696631216; 
 Wed, 13 May 2026 11:23:51 -0700 (PDT)
X-Received: by 2002:a05:622a:8d09:b0:514:cf96:7638 with SMTP id
 d75a77b69052e-516415a239cmr8445451cf.15.1778696630558; 
 Wed, 13 May 2026 11:23:50 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a8a951d1f6sm4212851e87.23.2026.05.13.11.23.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 May 2026 11:23:49 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: [PATCH RESEND v3 0/6] drm: handle IRQ_HPD events correctly
Date: Wed, 13 May 2026 21:23:20 +0300
Message-Id: <20260513-hpd-irq-events-v3-0-086857017f16@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
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
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-usb@vger.kernel.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=3154;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=CP/Usd5SOY/V4EM+27lYpiqg54wFGw4ZjWsp+w6ne5I=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqBMGzqxLK1D79sW3iq4HpOWxquvyKBFjpVcB34
 h7vCOrJ4kmJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCagTBswAKCRCLPIo+Aiko
 1XrACACZbqw9UPGnc0Rq1LLAPf/snNnVdTZVsXFY41YM+aZS+S0oinCBEk2sFDi6DoOvzVrXO4f
 lZkJKpaBOfQOOmh/eVRIl26g1+GDmKlBT8Wt+DTKHGPFZBELRDHOxm2htwzcF6vWOt0NMqOgYnL
 KgXpWk1I6X5nYD6PVbvE7LO37A8PZZqnrIzMeZjE0SiiJvP6x4poYkeeQp+iJ6tSO4ifjQnsjq6
 6DfAK+vsWVwkacAZjGeYCM74uqTOs0Sj+5EgbpmRcyvFZ+k7YC4lcoQHZSF8SE6h/IpU7aL9nlN
 4WIucg9m4eEPgQevK++Tmqs5JqKyrxqXDLUu4aSLWOCxV60V
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=M/l97Sws c=1 sm=1 tr=0 ts=6a04c1b8 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=bC-a23v3AAAA:8
 a=EUspDBNiAAAA:8 a=52TPwIQhNpV4Ze06EwUA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDE4MyBTYWx0ZWRfX+vnMF6Uja00U
 fv0YRBMQI7SVhTciWuXtze+1v3ap9J/fumWKIghgi1kQuYN2oUjN70s2CEVJWdthvD0aDAAuytG
 NQKrThG6Sl30JqHAEmR0+AhFOZgaGEKCaAaEbIQ6uvJ49bL09i/NBNFNgFRgvwttrR2s5ezMczh
 AYE6Z8Y4dVqBxRpbQewVSViuqiFGiVHcNVT/vWAqQLZZnRoM80ZBszKWAJjPftN027rDU1TG7bS
 OFOimwcbYtbugQLpxixVgceChkAd3Oc3jenK1OatHWnyKnTNZmCLFVBSKJkBE6wJApkPEKHwU5k
 zJsLgm4MAYSCq9+4xcUSZcemjHw7b9oWiDd2DUi/fT6/ZGsdZHayhrPR+0mLu50EBtU10QqBAWr
 Nal7pf5pP+ku/RZhsZ1a3uF1HHZmSLYaJiNeSTMnaap35zvV5jDnMSvgC4UaC3nFqA/GIGZlGpm
 Hbz5MU5jdvBy2TdGoUA==
X-Proofpoint-ORIG-GUID: b723SqlWJkYAquRKYqvMciqrp3sVtHPR
X-Proofpoint-GUID: b723SqlWJkYAquRKYqvMciqrp3sVtHPR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-13_02,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 impostorscore=0 malwarescore=0 suspectscore=0
 spamscore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605130183
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
Changes in v3:
- Fixed build error if aux bridges are disabled (Intel GFX CI)
- Link to v2: https://patch.msgid.link/20260420-hpd-irq-events-v2-0-402ffe27e9e9@oss.qualcomm.com

Changes in v2:
- Change irq_hpd arg to be an enum, possibly desribing other uses (Toni)
- Account for that, chaning the API accordingly (with_irq -> extra,
  etc.)
- Wire up AUX bridge notifications
- Link to v1: https://patch.msgid.link/20260416-hpd-irq-events-v1-0-1ab1f1cfb2b2@oss.qualcomm.com

---
Dmitry Baryshkov (6):
      drm/connector: report IRQ_HPD events to drm_connector_oob_hotplug_event()
      drm/bridge: pass down IRQ_HPD to the drivers
      drm/bridge: aux-hpd: let drivers pass IRQ_HPD events
      drm/msm: dp: handle the IRQ_HPD events reported by USB-C
      soc: qcom: pmic-glink-altmode: pass down HPD_IRQ events
      usb: typec: ucsi: huawei-gaokun: pass down HPD_IRQ events

 drivers/gpu/drm/bridge/aux-hpd-bridge.c        | 11 +++++----
 drivers/gpu/drm/bridge/chrontel-ch7033.c       |  3 ++-
 drivers/gpu/drm/bridge/lontium-lt8912b.c       |  3 ++-
 drivers/gpu/drm/bridge/lontium-lt9611uxc.c     |  3 ++-
 drivers/gpu/drm/bridge/ti-tfp410.c             |  4 ++--
 drivers/gpu/drm/display/drm_bridge_connector.c | 22 ++++++++++--------
 drivers/gpu/drm/drm_bridge.c                   | 20 ++++++++++-------
 drivers/gpu/drm/drm_connector.c                |  7 ++++--
 drivers/gpu/drm/i915/display/intel_dp.c        |  3 ++-
 drivers/gpu/drm/meson/meson_encoder_hdmi.c     |  3 ++-
 drivers/gpu/drm/msm/dp/dp_display.c            |  6 ++++-
 drivers/gpu/drm/msm/dp/dp_drm.h                |  3 ++-
 drivers/gpu/drm/omapdrm/dss/hdmi4.c            |  3 ++-
 drivers/soc/qcom/pmic_glink_altmode.c          |  6 ++++-
 drivers/usb/typec/altmodes/displayport.c       | 15 +++++++++----
 drivers/usb/typec/ucsi/ucsi_huawei_gaokun.c    | 11 +++++----
 include/drm/bridge/aux-bridge.h                | 13 +++++++++--
 include/drm/drm_bridge.h                       | 31 +++++++++++++++++++++-----
 include/drm/drm_connector.h                    | 22 ++++++++++++++++--
 19 files changed, 138 insertions(+), 51 deletions(-)
---
base-commit: c7275b05bc428c7373d97aa2da02d3a7fa6b9f66
change-id: 20260414-hpd-irq-events-e72bc076a5f1

Best regards,
--
With best wishes
Dmitry
-- 
With best wishes
Dmitry

