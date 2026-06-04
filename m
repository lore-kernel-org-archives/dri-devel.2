Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5513FCD6E68
	for <dri-devel@archiver.kernel.org>; Thu,  4 Jun 2026 08:07:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A914610E3F4;
	Thu,  4 Jun 2026 08:07:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="T7Z/e2PJ";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="d9EYX1sj";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E453510E3F4
 for <dri-devel@lists.freedesktop.org>; Thu,  4 Jun 2026 08:07:34 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6546uuUk2477944
 for <dri-devel@lists.freedesktop.org>; Thu, 4 Jun 2026 08:07:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=rXN3B+siA/49uCHBK5RRq8
 e9JZOTCLwpVAP/DtvlG/A=; b=T7Z/e2PJ2KkysHRy7xkvTkA4WZjVQaOLyzy3Sm
 vLjXxvyZCv6H9JIOETeBsIlzVOnvQED4OVLjDh8yBBaBsPtFtZ1bHpMi1E8ohTMm
 yb30JDtR9/bswxyiDeXGxhx3QnoBzk+QJRl/uQ5vT9wxuslcTI0/bHVDWJ8ZXqG2
 L65QU+BxccOelVGgRnh4e/1vLvi+u1PZuj668U0U80DgkNU0z4tLnHwhfGCyDCvS
 xTje5duzXRLUqXr9LVo+8GHo+sTy1ASJnk11Nr8eEAEOz4MPlhXIcLp4v065/E9R
 3TCH82PsdsMWh9D4zA2lRbluAfEmUgvQaed0QH/w1JkuLhQA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ek4hvg8fb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 04 Jun 2026 08:07:34 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-91550e751bbso10342085a.1
 for <dri-devel@lists.freedesktop.org>; Thu, 04 Jun 2026 01:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780560453; x=1781165253;
 darn=lists.freedesktop.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=rXN3B+siA/49uCHBK5RRq8e9JZOTCLwpVAP/DtvlG/A=;
 b=d9EYX1sjF/arPAAGC/c6ecuZuJYkF+5tSOvffJSGKsmvf0eB/V99ou7AvaD3wTzNhD
 TbW4K7+Yu8KnNKiDjvUn7rY5Yx/DJsqCGKAukk/bNqftgm9ELma8K60PpvkJlH03oBxn
 9XIIGvTTdHQ6szJTluOTSLz70LbN5uspBwywabttN0L4fjWc8BNky7+vL0IrBAe7tXka
 4dkZsoPmuXR5iwArSe3dQQj4ndehkhcGQzRNS6JqwgnfwCa6LJPo/Psux2n/L9zgMfKu
 Q2DVTVhyK7FoL1A1ind1SqClR+TkVVxHOWUgNwPQBNKFajENifCX52Ym9ZGBkm5bisIF
 tULw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780560453; x=1781165253;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rXN3B+siA/49uCHBK5RRq8e9JZOTCLwpVAP/DtvlG/A=;
 b=c5jrkxLw6VKR/HHN/UQSOJCrvZOh9bAsjJlnFDA8WDK5xc3hmyrvCtvwkSU1BWuHmQ
 xU56mkGxby7yAHFOn0OKqw1Km3cJkrEAivVw5IA0K1sgCYHuCcF/MD3O46E84tatFmKP
 zxkCtwpiYEEX47Z+yaKDRJsR2M8IoehiPADX4gwgYAy72iUiPOs9Czklfbqs5W04BEE5
 Z6DCKTwHnO4vnshEeEsJUxiu7egIRd9T5b57LuGMdDKv53omhRQwuCZ+jh/1ZORypmwX
 3jaHQbN9BLGvsoRFV8Ja12GHatnA3NtbtvzQCQTHO3kqz9x1DTqtd+Le+lDRYMTioaG1
 o6BQ==
X-Gm-Message-State: AOJu0YxQVZaW+Rk2DahPWB3vCpkUe0cc9KypOn4xBfKCZXA9NMfJiAI/
 fpNPCat6tkDucBuG/cz/VGwbDwHzCORh+WeZv8Ze8eyBz/NffZvPo8wpCr0cOIWaz2m2mgjjqhy
 EikpT9sUH3hg5S5949cWK8dJW5rNU9piPyqyPLPSFZR2qQSU8uyxr8F6ZG4tGq09XaG/FPoA=
X-Gm-Gg: Acq92OEmfIvf1ewAdzI2/Mt0GtB0SoGxUif+DaBMwbKm1suizi48yQN+XgkAcj5Fowt
 WGXZF+2728TAHVlgXLn5YkX5bM+l6SHsNSMuS7xQI1ZyvG/YLBXtJOYz9fA17/KqU8G0Z9VEIjR
 WvUAtak3f82KKIcoN9uKy8VN97WkAiGdR1jTl0352HyMypGaedc2v1Feg836LTgPS0SqTpobAO8
 fLAgqh/zqQxpXjmQaqLQTaa/yu30QYmqzrXz/YOVgiLobKKFtnaimf2DOwcUStc83FMaUAw9pnU
 x3FOQhJIu+LzSyQfC7k6X770seOg12pstfUKtpRyH5ZX43RgbBST7LZIM1gs1ynt6LaXQ5z+syV
 RE7++danm/OPLopwJZcJ5zbvBblgl4QjisFachvlgZB8/cVTWHI1yDx2FzQivrmETsicOoXJmgK
 XBs4BX1uPz
X-Received: by 2002:a05:620a:17a7:b0:915:4ca0:1210 with SMTP id
 af79cd13be357-9159e1cc1b4mr150367985a.3.1780560453244; 
 Thu, 04 Jun 2026 01:07:33 -0700 (PDT)
X-Received: by 2002:a05:620a:17a7:b0:915:4ca0:1210 with SMTP id
 af79cd13be357-9159e1cc1b4mr150365285a.3.1780560452726; 
 Thu, 04 Jun 2026 01:07:32 -0700 (PDT)
Received: from KDYBCIO.eu.qualcomm.com (public.toolboxoffice.it.
 [213.215.163.27]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bf052097992sm272304366b.26.2026.06.04.01.07.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2026 01:07:32 -0700 (PDT)
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: [PATCH 0/4] X2 Elite Lenovo Yoga Slim 7x Gen11 support
Date: Thu, 04 Jun 2026 10:06:53 +0200
Message-Id: <20260604-topic-yoga_submission-v1-0-57c70c23d0d6@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACcyIWoC/4WPXUvDMBSG/8rItack2RLXgbCy6oXi0DndUMZI0
 7SL/VzTFOfYf7frdiEoenPghfd9Hs4eGVVpZdCot0eVarTRRd4GctFDciPyWIEO24wophxz3Ie
 6KLWEXRGLtbFBps1xAVHAQ4kvuaLDALXbslKR/ui4b6tTbtvvStZH2LlRqa1thfWphjJljOiEo
 97Eu31lDdaza3oTErt4WnjSf6iWE+PPh8umdpN8Lj+nxI+86d3VjM4Tb5wJnTpxd2WRHR3fid0
 DjLiQ5CWYQsoSGg4YZMRCrIg7CFg0Loxxtlak7T77DSJCdxc/+tzl9H79XL6MNxZELnLZQNr8u
 TzpaR8PGSPEoaxPOXdhAEYH2jEiT0T1r/4MoRCnu8xWEJcWwhoa1v7BOJUDzANKsPwJWh0OX4I
 j7e/rAQAA
X-Change-ID: 20260603-topic-yoga_submission-fb6dc076e28b
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Douglas Anderson <dianders@chromium.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>,
 Abel Vesa <abel.vesa@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780560429; l=3568;
 i=konrad.dybcio@oss.qualcomm.com; s=20260604; h=from:subject:message-id;
 bh=wNqocs9HiwlRYOUBv788dwD9FXWwqryHgiMM0wn5LKo=;
 b=dGIkjowM2M09oxEXfRw0hzDa5SpDlUk/YIp7OwAunY8FNPyANjNtGeGnWZbB1QDEpgTaP6QwC
 zFjt9BpnYMDDgRTpZWhMDEkWqpoG2dpKqEWiYozvGWGbsSYI43jyszM
X-Developer-Key: i=konrad.dybcio@oss.qualcomm.com; a=ed25519;
 pk=SGRRMmlLTuP/lGKdQ0f4KPvxn8VVsXtXaTpdGc8i82c=
X-Proofpoint-GUID: MLyMM8hMnuBoIfVPVPeoxUg5gyji2fk6
X-Proofpoint-ORIG-GUID: MLyMM8hMnuBoIfVPVPeoxUg5gyji2fk6
X-Authority-Analysis: v=2.4 cv=Zp/d7d7G c=1 sm=1 tr=0 ts=6a213246 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=aBIYUfOEhgoR9egqXYNcqA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=0kKuASbsWRo6JP1RYPsA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA0MDA3OCBTYWx0ZWRfX3aKtXskVDc+3
 wMh7qvkXMIisKOslWHStj9ssPaijH5E0SOLnSNxsBPADe4NQTYoVjJ5poM81pIYIj+czOsDvwZ7
 gQTB77b5E5ZdZqauYBJs4Q43Y2ah04xAzM+x00W3UoYpSwVoftqhlFZNeFdpdHMEr91TmeEyQhA
 G2vB2ShRxMrpU86lFpvL0c6nG9z+KyZ4e9bq0gn00gY6xAusyea3xQbW0uVgrR7F4UbnZ882Yvv
 4iXFoXgA8w+mTWyQpI42cQe3ret9yBGlLbqESfeRCXpsfENmo+Bt2uQ2SqGGoXnBiPANCUXJvQm
 hWgYXqREnaoHqRzCjANa9GptzfR0dgCMnDce8KDzARZKy5phDhuVHbL2roxp9uWIRHMWR566WzD
 xUj/8RduLly+0fserBAfzqy+PSWUfz0qZB+R4A1W4ZUAleMRg4Ag3KtVbrVoUXjghEpRK/a1jPc
 T1TRigpOn/23t0x+NEA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-04_02,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0
 bulkscore=0 adultscore=0 suspectscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606040078
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

This series brings the bits necessary to support the Lenovo Yoga Slim 7x
Gen11 laptop, based on the Qualcomm Snapdragon X2 Elite (Glymur) SoC.

The DT allows for a decent UX. Among the features working are:
 - Audio playback and capture
 - GPU, Display
 - Keyboard, touchpad, touchscreen, lid switch
 - Privacy LED
 - Charging, Type-C
 - Wi-Fi, Bluetooth
 - Modem should work on the SKUs that have it, but it remains untested
   due to lack of access to such a device (it's just a PCIe device)

Most notably, the camera support is missing today and there is no EC
driver (the one used seems to not implement the same interface as the
"Qualcomm Hamoa CRD" driver services), making the OS unaware of e.g.
the keyboard backlight state (although the backlight itself still
works).

These patches are a result of a collaboration between a couple of
Qualcomm engineers taking part in an internal sprint and were created
over 3 days.

There's a number of dependencies (audio, GPU, SoCCP series), but those
all seem to be in a fairly good place, so this submission can be
reviewed in parallel. As a result of that, this v1 submission is
almost expected to trigger some dt-bindings warnings..

Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
---
Konrad Dybcio (4):
      dt-bindings: display: panel: samsung,atna33xc20: Add ATNA40HQ08-0
      dt-bindings: arm: qcom: Add Lenovo Yoga Slim 7x Gen11
      arm64: dts: qcom: Add Glymur-based Lenovo Yoga Slim 7x Gen11
      firmware: qcom: scm: Allow QSEECOM on Yoga Slim 7x Gen11

 Documentation/devicetree/bindings/arm/qcom.yaml    |    1 +
 .../bindings/display/panel/samsung,atna33xc20.yaml |    2 +
 arch/arm64/boot/dts/qcom/Makefile                  |    1 +
 .../boot/dts/qcom/glymur-lenovo-yoga-slim7x.dts    | 1237 ++++++++++++++++++++
 drivers/firmware/qcom/qcom_scm.c                   |    1 +
 5 files changed, 1242 insertions(+)
---
base-commit: b7bee4ca5688e30ca50fbc87b1b8f7eed7006c17
change-id: 20260603-topic-yoga_submission-fb6dc076e28b
prerequisite-message-id: CAJZ5v0iRE2Fd1uWSWAcDPrXCsDT8Xvt9knTczN1DfANK=R2TkA@mail.gmail.com
prerequisite-patch-id: e5bba0850a9f380c1d369dd56076a7ffbf7e57a5
prerequisite-message-id: 20260519-knp-soccp-v6-0-cf5d0e194b5f@oss.qualcomm.com
prerequisite-patch-id: 8459bcae98ac156f6576657fe9233badcd385218
prerequisite-patch-id: 9ab2b37c0a11c3a9590be921fefc8709ebebf6a3
prerequisite-patch-id: 21440dddcc340d35558010fe88bad9265e43c6ac
prerequisite-patch-id: 162f8b373ead5344ae0f29c92432db57a0d75f39
prerequisite-patch-id: bf5532cd5c8b66127e20be0677adbbbb3bd9578f
prerequisite-patch-id: fa7954f6fd2d27a6f0e805c9643b70e7e201c503
prerequisite-message-id: ad9ygQD6962M_UpV@hu-anancv-lv.qualcomm.com
prerequisite-patch-id: 48c26c428cbeaa674a615704d1abeb87e4e965c8
prerequisite-message-id: 20260523085511.2532669-4-sibi.sankar@oss.qualcomm.com
prerequisite-patch-id: 43e96d8a5063f51e2b5ee75fc8c9e10682e5670c
prerequisite-patch-id: 2e71d345f84a821d89da2a6064954409fdb1277d
prerequisite-patch-id: 0b9f5995044bb3d3ffda227ac986b755fa118c63
prerequisite-message-id: 20260522-glymur-gpu-dt-v5-0-562c406b210c@oss.qualcomm.com
prerequisite-patch-id: 9175e9ae77ac032c2f0502e2c63bb7b7d1ae4ead
prerequisite-patch-id: 916e96859119985c09aa265f45f69e0800d56988
prerequisite-patch-id: 36f4bb7740fd65d808fa6685bce4b03798a547ff
prerequisite-patch-id: 054631082c45d3ab3117f541f0d4d90b660dac73
prerequisite-patch-id: af18aef027c45213c11b436746fa31b3b6ebe46b

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

