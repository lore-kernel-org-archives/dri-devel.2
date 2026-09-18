Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E0E3C982DC
	for <dri-devel@archiver.kernel.org>; Fri, 18 Sep 2026 12:05:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 58F8110F326;
	Fri, 18 Sep 2026 12:05:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="BUUmQwaW";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="d4iHvTNk";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7FBD810F305
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 12:05:35 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68I9dqXP705798
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 12:05:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=u157Y9EZ4rdCj82BSUWEmRUeIA7sKwxqgZZ
 dX73J1mw=; b=BUUmQwaWHcxeOPQjyd8UGMBGsgiR8EwAy2DYafwKyKMrlp8KhBm
 SsUtlRW5Kh7324DJho6rOPHMDgvhvpC5U3Q6pFy/lmt/epa2A+QbHQr91wu8m8Yi
 nQzFGw1CJzIH4WERgyHZLNm7L50Z2r5xCOtgV+ay3xbEeSWTCy6AaG32gqcYdyF3
 XPWpq2bcR/eSGEwjpLsRp/H2KgstILRkWRIQWCt2epCu0WbW6jKHzmzL9hvBbn2j
 dEkqGynrgU/o0hbVhbJoimh7aJ4CPoPU4+wAQ7AHLkbfn3V1Frsep5KhkbqzsAV7
 Vn3vvdmCEkOtr8kcm3q+F5IRJZuk/3Ero/Q==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4grxp2sn0m-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 12:05:34 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93a0050a554so156283185a.1
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 05:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789733133; x=1790337933;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=u157Y9EZ4rdCj82BSUWEmRUeIA7sKwxqgZZdX73J1mw=;
 b=d4iHvTNkPmslJlQr1yL4cxaxyLkuTMKOQwnFdXtbycLk/Az4yHAhlsZSbpbmNZ6WDm
 aUi/hCt3tAgjYf2kX4bDMCupI2JQOFskFJc3B/4akuODW8tGJoYkT4Y6FKMLdP1OV8mA
 +UG0vCwsQuBWkN/CmjRAb10bAqiP+bLLz1egpnYG9Wk8j63xQ4R2R1h37Z8bNEorgv4d
 aS4VSnDIeQuVt8fez6aX3zJtbuMs00dzZ9LMhpAyCCzmoRHQFvW972/YT3KemC4BRsRK
 0wp1XXoBwbni6scx7vLiEoaqSCUc/dhRrt6V3FjNpdPU4xUQ2w/eIGIsP2qoDXHoGXq1
 PmMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789733133; x=1790337933;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=u157Y9EZ4rdCj82BSUWEmRUeIA7sKwxqgZZdX73J1mw=;
 b=OxtvQ5czquk+lxfq0d3Pan7Y0wp2OKaYE2QY5oQyj8u058A0g7wwaumTnoNF1J9gaQ
 ZBmn+Y08GxwUNqEfvi2NGl36YryLe2RcB1c5Yh6qpMDNxKKDAicFOJeou9cklpC68fNm
 5grPZHs/RP5S1btZa41jXrBO3TwcjY9BPlR12XPo+F4tww96jeftE8HupiCLUij48lfZ
 gsteC7t7AlQbIn8pNGiOkRtqtvo0U05sZFd1fwV3DlpNIE1BDoyr5bfLqAF7iLK5XWdn
 22aKn1yCQiPC0mBm9zkBP/c/bJ4zSDFK2iregvXrFfA8fyp7eu3ES5P0+WG1xtWCqAJK
 0pIg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxbBquXfdU5PC+1ebr+RWvi1IGmXFrsb8ZdH6aM4pNBKh+LJ38MLHqsvM8ZeReg6u80HK1rA1gH0Ng=@lists.freedesktop.org
X-Gm-Message-State: AFuF++n+nBhg1XTyE8D0Ol3DgQ9xdDhf+gIa3TdXtSSwZmLTBn+vAIsD
 LNud7IAoWr65C6ck28Izz9z4BGmIvkkUwBUXoq09bbKt3UvoDKk1IZ4U+JMVlsbuoiFQ5tlvIzX
 XpCyx5YP536KCcXMsJtdMc20ImH6+DWUVhxEFS7RcdGwZkVx8vgs0iK4vsOPsUqu3KMW7N6M=
X-Gm-Gg: AYBFou3w9+o2Y/4a7sieMTVLQqDWajYjPvLDEvihqjPGwI/ChHxR76/8WW/dL/ueHzB
 x6EVqNEM342lnluWk50iCM8ZJfv9AQyIqXq3IZCeWsWfxKIp+RnoHph3+PZ9qxfEaq9hzV7zr+D
 yxcm77zJTwVlA8lnJBmyhUz8HlYK0uuyJYfJofq0E9/3k8saTztAeE+A0e52hrTkndfwzTURcVJ
 xI8YOmLuO0/wWBiYo7TTy8GvkyRg0e3QBXuSjMDiAaB8B1ihDZ2iU6frC3JiuloLwY7xh2jFsur
 G7b+hzL6z8Mxh9w2Y1+cAh2qdCwQSw7niGwbLBGdUI3xGRtcMu3LtWF4H3U4HFWuKLuAAGdEQuP
 dN+j3qMuYyNdDyg==
X-Received: by 2002:a05:620a:458a:b0:937:80a9:94b4 with SMTP id
 af79cd13be357-93bdc64f822mr298204885a.2.1789733133165; 
 Fri, 18 Sep 2026 05:05:33 -0700 (PDT)
X-Received: by 2002:a05:620a:458a:b0:937:80a9:94b4 with SMTP id
 af79cd13be357-93bdc64f822mr298196685a.2.1789733132563; 
 Fri, 18 Sep 2026 05:05:32 -0700 (PDT)
Received: from debian ([5.133.47.210]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4871ff3ae49sm3917584f8f.10.2026.09.18.05.05.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2026 05:05:31 -0700 (PDT)
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
Subject: [PATCH v2 0/3] arm64: dts: qcom: Lenovo ThinkPad T14s Gen 7 (Mahua)
 support
Date: Fri, 18 Sep 2026 13:05:12 +0100
Message-ID: <20260918120515.595782-1-srinivas.kandagatla@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE4MDE3MCBTYWx0ZWRfXyW+WlFJ3dnPq
 cP056knmg/tqDHvbn+/W01wHP+ZAFXWxEXB22EWG/bwsIcZdr4TMTUO2ZcBTseqKNktIjZTqVfG
 uS2R+nEAwnJ/imkIzkj68cObTX6f9k8=
X-Proofpoint-GUID: 6_01_hKqH1VCirIRCcDRHiTHsUKRJNmW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE4MDE3MCBTYWx0ZWRfX4Nel2UTL7D7F
 pJtwtiAwszr7dIwvuGGmicznggkFo4L1opDmXE3TJluuMeJ2kQcPkr4rkzXvCCCcRt0N2AhVjC7
 tJnuIlA/vBlsIwav6If5lRhwcX/t2+2PUGP1COPD05NGCkm9sz7u2dd2Kt+vG0IBji4UPISa48K
 sEspizpKTyLYTert5wrViK25i0yRhIpoLBLiTykrdREv3vnwyNV8/qE7+NkZxkb13ciPOuuN57C
 rXGknE8Tww9CocW5A9OXifARuVTDL1PX8MAw5NhsptlIO1aFYdz3aARGho64yoMcEJqlWnuoC5+
 cE5zkwlKXbiUR15pLDhgmcRGkdOSrUZN0LUm/QOxXOMn1V71vHehbdbmUaWuFwlxSX3+TXHZkpU
 nIMRbgpgTym661zUyGkjylRkvWgQ85FBDTY8k2uMmTM0b1dFCp2ykuo1vbO/RB3ezZqym/B8vCY
 Dp3/drkaG1ggoCgRNcg==
X-Proofpoint-ORIG-GUID: 6_01_hKqH1VCirIRCcDRHiTHsUKRJNmW
X-Authority-Analysis: v=2.4 cv=cNF1IVeN c=1 sm=1 tr=0 ts=6aad290e cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=J05Q59ynWE-0mZ9N3MUA:9 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-18_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 impostorscore=0 spamscore=0 phishscore=0
 bulkscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0 malwarescore=0
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

Add support for the Lenovo ThinkPad T14s Gen 7 (Mahua), a Snapdragon X2
Elite laptop.  Patch 1 adds the board compatible under qcom,mahua and
follows the Gen 6 T14s pattern with distinct -lcd / -oled variants.
Patch 2 adds an edp_panels[] entry for the CSOT MNE007QB1-1 (CSW
0x1465), the 1920x1200 IPS panel shipped on the LCD SKU.  Patch 3 is
the T14s Gen 7 (LCD) device tree itself; it follows the Qualcomm Glymur
reference design used by mahua-crd.

Currently working on the board: internal eDP display, WSA8845 speaker
playback and DMIC capture, DisplayPort audio on the two USB-C DP
outputs (DP0/DP1), USB-C (host + charging on both ports), WCN7850
Wi-Fi and Bluetooth, NVMe, HID-over-I2C touchpad / keyboard /
TrackPoint, lid switch.  WWAN wiring is included but untested (no
such SKU on hand).

Changes since v1 [1]:
 - Split board compatible into lenovo,thinkpad-t14s-gen7-{lcd,oled}
   with lenovo,thinkpad-t14s-gen7 as the base, matching the Gen 6 T14s
   pattern; renamed the .dts to mahua-lenovo-thinkpad-t14s-gen7-lcd.dts
   (Krzysztof)
 - Drop the on-board HDMI-A / RTD2171A bring-up; DP-side link training
   succeeded but the bridge did not produce an HDMI signal downstream.
   Will be re-worked and re-submitted alongside the headset audio patch
   in a follow-up
 - Wire misc_3p3_reg_en pinctrl to the vreg_misc_3p3 regulator so the
   PMIC GPIO pad gets its documented drive-push-pull / power-source
   settings applied instead of relying on defaults (Sashiko AI)
 - Drop the unused wcd_default pinctrl state; T14s uses WSA8845 + DMICs
   and has no WCD codec (Sashiko AI)
 - Sort regulator nodes alphabetically (Konrad)
 - Drop the redundant &remoteproc_soccp { status = "okay"; } override;
   soccp is enabled by default in mahua/glymur (Konrad)
 - Rename WSA speaker labels left_spk/right_spk -> left_spkr/right_spkr
 - Include the raw EDID + decoded identifier fields in the panel-edp
   commit message (Doug); the CSOT datasheet was not available so
   timings remain the conservative delay_200_500_e50 preset shared
   with the sibling MNE007QB/QS entries
 - Picked up Reviewed-by: Abel Vesa on the DTS patch

[1] https://lore.kernel.org/all/20260913201835.250085-1-srinivas.kandagatla@oss.qualcomm.com/

Srinivas Kandagatla (3):
  dt-bindings: arm: qcom: add Lenovo ThinkPad T14s Gen 7 (Mahua)
  drm/panel-edp: add CSOT MNE007QB1-1 entry
  arm64: dts: qcom: Add Lenovo ThinkPad T14s Gen 7

 .../devicetree/bindings/arm/qcom.yaml         |    7 +
 arch/arm64/boot/dts/qcom/Makefile             |    1 +
 .../mahua-lenovo-thinkpad-t14s-gen7-lcd.dts   | 1213 +++++++++++++++++
 drivers/gpu/drm/panel/panel-edp.c             |    1 +
 4 files changed, 1222 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/mahua-lenovo-thinkpad-t14s-gen7-lcd.dts

-- 
2.53.0

