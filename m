Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E9F5C79F99
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 07:11:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A10FB10E092;
	Tue,  8 Sep 2026 07:10:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="mALv5SUk";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iGtEo+ne";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 42B7210E0A1
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 07:10:58 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6886LiaH950275
 for <dri-devel@lists.freedesktop.org>; Tue, 8 Sep 2026 07:10:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=f8RLbWT86kAkeJotJylv89
 teUUDEjaGV6y6BRtUcATE=; b=mALv5SUkqnDUsl4GL3wX5hU0aPn/stRcTljTLU
 hfQltbgPBHIPrb0QIuvpBvSDFw8TKpaBkZiAVLeL0fdAsvW5JDuG8EHpIVnuvepK
 LyhWzMuvCmpjS64vhmRXkMwUr8eUDjEQ5Oqx4Cul2MY5+5YjQIpgoWVdQXXeoysH
 uMB6LO8W13ZzVS2Y9iZGcYtoiYGgR3ZfMshRBgkL+nzUO003Ol5xC3A7oHUYCt+V
 /PPwETnTLC2kGdffZ9v9IIQG1YHlimnQsktA2v0Sn+FPmxv3lpsksaLt9t6eqktf
 69iIdDoBQwsLMZlh3Vn10ODL9XKuy8LDL9yMO8XovG5SWnKQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gjcrp899q-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 08 Sep 2026 07:10:57 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-930b571432fso651749685a.0
 for <dri-devel@lists.freedesktop.org>; Tue, 08 Sep 2026 00:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788851456; x=1789456256;
 darn=lists.freedesktop.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=f8RLbWT86kAkeJotJylv89teUUDEjaGV6y6BRtUcATE=;
 b=iGtEo+ne8hIkPVnrkvgX1EZbnkMy/hMGSgd1zaksp9Bwlvr93wzk1zwu5fRtP4uQXa
 S4KIqUnZhcQJV8nwa5z5utj+dySP3vkETW9WTDnoUGE398HzIPjMoMwSfpahPe6nu7Dm
 z4ahK4+rrSMM6UKsTFpc9qcLuQcmqtMqILHAIDESerIvJRC/+jZDsgRLGhJdUtVepiqB
 XMXQXLdy5Ylb4ModyWbSRq/k4baLdA9DISTzZrhghzsUQ2lP6TYG6/e19D9QDtqgiwp8
 b9W+a+sFBPLj8KBoonfbzYjztqxmO/sIujtCj8e7hoEPnbP3q0z9RWOP7Rk+xtfYzDl8
 Unww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788851456; x=1789456256;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=f8RLbWT86kAkeJotJylv89teUUDEjaGV6y6BRtUcATE=;
 b=sedu3CTkdjyK4lJMfu282T37AQeX3ouElLTydApDcAqG9QoI6pSAKN7htClJ31BuQi
 jz8C5UIT9rCZOa2nGv0/agymxzEcGtanvZCXW3di8BYHyZ3ULTRpt9RAowW4yEwpM1X/
 IokyfDNfW8+PSl6BwMTIm7MyCo3QqAe+1snzEAb8OfdZnyo7OE1bSIAb2z01oeL7qTX7
 34MpftSuTg5OQlpXcIWeWxoj21eU7hoABEMxvHtN4ZQQ77SG93Zta9A1PlsA1aUmc23+
 GjbSlAB1thc0MvKH+xcQYNRk47auEMBLJ+ec6JVGFcRcIhvOMY4wPkXL7Y7w+4kBo3Ov
 FtFA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzL5Rb6scWx7SgXHucwRoHHn3WGI0lZW8E1mJpy7eNeEF7hvJnP2GyY0yirawJ3cF8E63dd//QaI9Q=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nZgR0LH6jxEDXasjUlKzterXrKTWSLnVgvM5RrDTRqNKQEdOzX
 fnzU3umHOMBiTxkEoOF4TUob4lMQMur7nhWyDIjtHHl0ZxjmCqnnglezQZqcnsQieO/FKneqDMk
 qxzYmHydDZqCnp3EFOdDr7wKyYunbVeSBzbOykzdtOYj1DRkjggAw585usdSZg5WHv/rMMLI=
X-Gm-Gg: AYBFou1LofYW4u2+KvalocjYDmOQaHQq5k3kcJQMTvPRLwzlTzuckAwO8CrQAbZ44QO
 9ZckKwUwWdOdPh3t/d77jnaYW8eETyLN6py7JAdcKtnn1J3ItqiRNyNGlKnWCkL4uiagvkKPUGU
 CfA4v0gN6JfUwL7V8FZK/ymU0xWwvzXme9VHck3BCJX/ZhBaOViWxHTmi3e34iHqYsmt3HmKMv1
 6U1VCqKd1hEfQbAg2mSGCFZx6lDlVnUv3pXwJ3q1dkHZ2CrJKiaCY6Oztm0qMr5xY6hdS//1jNh
 RmjktEODuio73V1Ec4ZlUEDh62Zc7/hMCRxOb+iv4NqpoKZfZH3JDeSAiHWNt7eHTQdM6BnUxEn
 kq0oN3rL8Ri9tuGt4BN/neEs=
X-Received: by 2002:a05:620a:8894:b0:937:6f98:c68f with SMTP id
 af79cd13be357-9396deac481mr1835658485a.1.1788851456341; 
 Tue, 08 Sep 2026 00:10:56 -0700 (PDT)
X-Received: by 2002:a05:620a:8894:b0:937:6f98:c68f with SMTP id
 af79cd13be357-9396deac481mr1835656885a.1.1788851455920; 
 Tue, 08 Sep 2026 00:10:55 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.214])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49ce5927b68sm453173805e9.1.2026.09.08.00.10.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2026 00:10:55 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v3 0/7] drm/msm/hdmi: Fixes/Cleanups before Eliza
Date: Tue, 08 Sep 2026 09:10:40 +0200
Message-Id: <20260908-drm-msm-hdmi-fixes-before-eliza-v3-0-dcf8956878ca@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/42OTQ6CMBBGr0K6dkipPwVX3sOw6M8gNZRqB4hKu
 LsFL+Bmkpe8vG9mRhgdEjtnM4s4OXKhT7DfZcy0qr8hOJuYCS5OvOISbPTgyUNrvYPGvZBAYxM
 iAnbuo8BU2siiPNryYFiqPCJuVopc6x/TqO9ohjW7Gq2jIcT39sIkVu//tUkAB80raZoClZHyE
 ojy56g6E7zP02H1sixfK7NdUucAAAA=
X-Change-ID: 20260907-drm-msm-hdmi-fixes-before-eliza-c9bc7185d84c
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Archit Taneja <architt@codeaurora.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, stable@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Abel Vesa <abel.vesa@oss.qualcomm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1927;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=zpq5mCKUOT/wUAOeHfp/xfgg0ZRiJ3FqfBhoFrs/1jQ=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBqn7TzbhTLLrihthOjdQaXbEX7ard2KTMOpshYK
 dG2hWcKYVKJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCap+08wAKCRDBN2bmhouD
 18MID/9CapUwvmX25INfBr39Gll9U/8pN03nzwdBZlCLFVy6itzrlfHBldIARd1vuBwuXhWZ5Rf
 nhoOZqMah7Iqx931BoVqwC1grAVL2E84/sRNENNAo3tChayo5x0AzNQHnDojBB6w6ZWbk9h0Sak
 8tYiFRBVobHfBF6r+Og/sSM0w7d62hae9OfuwqyNyqVIofCDE05u7Vpfg0aWoDQLv5ojw3yjEfD
 trIvac1gB/TdPBtcEDkB5fMFlOWWR+T12lsFerzwmumLJzLyqdX9S+dXmWb/Ka/pgpOZlqh8gJT
 qLBSEyns7q/N5RxqZCTYP+pcoyr6LrVbqQKNA+dgAjFMc2GP9nSgeYGbSy195NpWe+EqDqwJZfI
 pzl6GiQL56KZKX7HdFAKNKh7AS0oKOHhicMVxv9iF47/RANiw2JnJVbQJOAkT3CPna1pm2VE1Ic
 Dlv0HUYYR9a+Eh0cO0uaWgLrRmvoOPB4SmcyCSuVY7BgglBnkheo3nzkwQLy50hIdITR358IgUH
 vMGCLme10caSNWives336h/8ecrCm1H3u213zbY9I/ArVnqNT1tlL+iI2A+6nkahQetMTxwXvr0
 eOP1eV5WSo8rd1Rp+Rt2SxfF4tQJP5vtjchjBG3NHCMdLX1aiXE5P1ircKto5hgHdegOT4IUOzS
 4rQWQeiwEncs8CQ==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Authority-Analysis: v=2.4 cv=UfRhjqSN c=1 sm=1 tr=0 ts=6a9fb501 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=+bKQE0WJfmhK2875HamI0Q==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=zNiOfXrd8CByh7D4QjQA:9
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-ORIG-GUID: lDjGy45qE84UNM8OyLaYpzLweVu9fQz4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDA3MiBTYWx0ZWRfX9EU9I05fbVK/
 U5NTa3IU6dBjww42TNWBHHq/1/1Ydj981U6ySBEs+m1f2PG82QpMoBIkmpqqtuFoq8Kpkl+IrHo
 QS9IDam8TBkUevqmbkmt5KjmyPr/HdquK0y9q1/uKDDTriF6bnjUZFz+VeitATPd57+un/Qd5Uv
 0il1WlDVr0NAtHJ7cEn3YdVSPMWNeuEAdstGsaYxMQDDlcIHfG4b0/6Q0AOonYd+XxCdq1NsoNN
 iQ5D9ulwiJeCmc3XeVV3+cVTUoyVSznMDjHPrzMoAwlspm4eUl/pYDBNw8qvBYgcSy5xe1/LfQg
 2XQUdklCIS4WcEJ3aSRS0LUHRDdYkOM6m8XBBlflHc4aLUnxQuGkYDUCCGL1DzMTMfOcnO3fVQm
 Hx3xj3ORRKh4AomuEdGBctfABPnnUozDQEmqJhQC4vtVvvIAm6UP1pHuI4DOW0Ox/2wPWCM+Kok
 Xv9ign2FnEv/Uf4SpZA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDA3MiBTYWx0ZWRfX8DRtbi0d+7pQ
 wgRbzsHcRd9dxUF+MANpvJGT2pvjSqIgBQ9IMduFknbgoznZDKl1EctDR7nupClj053GXlfYRAF
 DfEU5sMDcw4Q81b73lWg3TewF9oNK7M=
X-Proofpoint-GUID: lDjGy45qE84UNM8OyLaYpzLweVu9fQz4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_01,2026-09-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 phishscore=0 suspectscore=0
 spamscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609080072
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

Changes in v3:
- Add missing regulator_bulk_disable() in msm_hdmi_phy_resource_enable()
- Set hdmi->power_off=false before calling msm_hdmi_audio_update()
- Link to v2: https://patch.msgid.link/20260907-drm-msm-hdmi-fixes-before-eliza-v2-0-b097cf1eac77@oss.qualcomm.com

Split from Eliza patchset, thus `b4 diff` won't exactly work.
v1:
https://lore.kernel.org/all/20260828-drm-msm-hdmi-eliza-v1-0-67843277de17@oss.qualcomm.com/

Changes since v1:
1. New patches:
   drm/msm/hdmi_phy: Cleanup after msm_hdmi_phy_resource_enable() failure
   drm/msm/hdmi: Handle msm_hdmi_power_on() errors during .atomic_pre_enable()
   drm/msm/hdmi_bridge: Correct poweroff/audio cleanup order in post_disable

2. Patch #5: use simpler ?:

3. Add tags.

---
Krzysztof Kozlowski (7):
      drm/msm/hdmi_phy: Cleanup after msm_hdmi_phy_resource_enable() failure
      drm/msm/hdmi: Handle msm_hdmi_power_on() errors during .atomic_pre_enable()
      drm/msm/hdmi_bridge: Correct poweroff/audio cleanup order in post_disable
      drm/msm/hdmi_bridge: Drop redundant initialization in msm_hdmi_bridge_init()
      drm/msm: Properly handle msm_ioremap() without name
      drm/msm/dsi: Fix indentation of if block in dsi_mgr_bridge_mode_valid()
      dt-bindings: display/msm: hdmi: Correct name of disallowed supplies

 .../devicetree/bindings/display/msm/hdmi.yaml      |  4 +--
 drivers/gpu/drm/msm/dsi/dsi_manager.c              |  2 +-
 drivers/gpu/drm/msm/hdmi/hdmi_bridge.c             | 34 +++++++++++++++-------
 drivers/gpu/drm/msm/hdmi/hdmi_phy.c                | 16 ++++++++--
 drivers/gpu/drm/msm/msm_io_utils.c                 |  6 ++--
 5 files changed, 44 insertions(+), 18 deletions(-)
---
base-commit: 6e95d4043b2c59f1887fd72d1620b7fd3d3138a5
change-id: 20260907-drm-msm-hdmi-fixes-before-eliza-c9bc7185d84c

Best regards,
--  
Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

