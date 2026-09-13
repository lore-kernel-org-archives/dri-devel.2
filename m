Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52E7EC88E63
	for <dri-devel@archiver.kernel.org>; Sun, 13 Sep 2026 20:18:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A1E3610E450;
	Sun, 13 Sep 2026 20:18:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="LHfBJyxj";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iMWpMrVF";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 534D010E17B
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 20:18:49 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68DK03iB3217873
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 20:18:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=1QPVushJ6JeDYkDdFRtdAlcR9wpX8yx6bam
 U+HGQUsw=; b=LHfBJyxj7lCJ3xfHc9Y5znKfFxLG/iTbIh6TpbKJQZv0NFIcBo0
 La4SmCrHMksiBwImlJO5ZjnBsaAQom0JcVsWThYEUEWHb6Ojt+aXIHVDFmLNkyUU
 93CpoQa56PuCMyqcu1eMimvU87YtYGrPROt0/wb+JtXlnKafJ48wPURF2ikWh8bL
 lHKmG89cp8yHOLII8SNoJiiN/pqaOWtoB9EjQs3A7eHRmNKwEzDo0+p+GRrOz4lp
 iNAnBxnVwxIt1e3bWMlVbTfu8Lqi/LSnW9eA37at5bXtzN+mv6KTXoGWdeM67Wqf
 lCXXz/8US7dW832vMsUkg4JCLqoxh/GkBkg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gmy9dm2wg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 20:18:47 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93a0b66ecd9so140596085a.2
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 13:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789330727; x=1789935527;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=1QPVushJ6JeDYkDdFRtdAlcR9wpX8yx6bamU+HGQUsw=;
 b=iMWpMrVFdHWx0JckVbmowpr2cqscM+hjNyIr8yIYVjL4dq6tufqhF+31V2jwqV6/Bm
 g5uuoa7pB5ZySmYfSGbS9nP6QcoRHWEHxYfo0sLCLmesk8/9Pd5qBa0gBMZTIMuGD+KA
 r8RWFokoE3t/UTnL6Vy5QhUYfQao7PTiaCHYY0S9yxQm5eKLijUKC5EEm4G8BLarfqzh
 tGfVpTdfcouaHHeyHCO0nE04pySRBSLWi0SSkrbonxduIDUSn7rZRq+zo+R4TQXOOlkL
 k4dFtXF7fQekeZf3Drs8mP1e0MvEVmK/Bb0dPyLl54Lq8PNPtm6m0QKfzOTq1iz6AxT9
 1Xhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789330727; x=1789935527;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1QPVushJ6JeDYkDdFRtdAlcR9wpX8yx6bamU+HGQUsw=;
 b=iQ5JKswT+Ak4u9JZ8/3bgohoyGbmd8o01KTM8JyiwcAiNZry860MKb2z+MuEgff+2I
 MF61muJUo+aiCHq6AcA1iPHEgMpPFqjgJfiJ3QI+/+HJksw6EGNLTyzl2rnKvinmUNCQ
 PENddGoPoKfxQKKGKh2Hzr7mwMRRyPrw2We3/DQAnlhumX0zi4CWMDqXZOufni5DEg7r
 Yq/jh2cBrrUhso8+w0yVmHByL8jo34MwTPn0NIt7XbTRa8Hlj8OohcW5TjxneN5jCda0
 PKlfecEigNqroWp2Nyz3mYiuW/O5VJSTkJ89rc0pJ8r6AkcRaqJqHWCn1qy6YM5CbYws
 CUIQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByjToZVvuD/PSyNZf15AURsbEWuamyZtDItsOpcenfxM1GjJv35TXr8TTYX1JFqi8EnfwSlEfMDR8c=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kXSXzo/KeK8hjmafqzBliPcEp0+6ekJ2KP1rT2OM5UjrsaBRo7
 me5dSAxozIERRKGEfF43ZulQadHWS7NrtRRa5edUfAgibMH5yTzRbPUeqYBh4YDHfP4P/BQWAch
 5GQqrWaCpp2QfXC5DOYjZNooWvLKMeu336b+diQ2UZ8ERv4YTE90Zw1C0qY7rcjuLh2f7CvI=
X-Gm-Gg: AYBFou1nlGgCq31crdDroGtg1CzBxBkOoQR9m/OMthSNsbj4gzmVJwQc58pB6rHL57X
 20PkYlSLgh2kQZK/3lw8Vgcgpc+K8vEWUzh4tl6PSrP2PGxK6XREiE0qsc4mbEtOLpmUZAdYSf5
 APHM8EFjtkleEuDhk4YE0Ra//sypRW8qaNDMWdnuLoo3V+Bb4pqsnDMxOESbi1Kloim4ZrnFmMC
 iftcgxfxvjvowXxW8LgCJe//s1I8L//4i1Y3MX0+kv24+4qSb2EXgwLVW50AixkJUSZTV1k5b84
 N1PSpzP+7HJJu1EYpTJJCoOy7YoWfZiAfJdk3ASVEx3Cpv7Qr4QwpMeR+z1bc0kcWsrQlZA0CAC
 y8yArwDvJuTFrtQ==
X-Received: by 2002:a05:620a:472b:b0:92e:745c:6c5a with SMTP id
 af79cd13be357-939ea09214amr2042406285a.14.1789330727177; 
 Sun, 13 Sep 2026 13:18:47 -0700 (PDT)
X-Received: by 2002:a05:620a:472b:b0:92e:745c:6c5a with SMTP id
 af79cd13be357-939ea09214amr2042400685a.14.1789330726641; 
 Sun, 13 Sep 2026 13:18:46 -0700 (PDT)
Received: from debian ([5.133.47.210]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-486eb32d3c7sm20143821f8f.10.2026.09.13.13.18.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2026 13:18:45 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Douglas Anderson <dianders@chromium.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 mpearson-lenovo@squebb.ca, abel.vesa@oss.qualcomm.com,
 sibi.sankar@oss.qualcomm.com,
 Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Subject: [PATCH 0/4] arm64: dts: qcom: Add Lenovo ThinkPad T14s Gen 7
Date: Sun, 13 Sep 2026 21:18:31 +0100
Message-ID: <20260913201835.250085-1-srinivas.kandagatla@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: ocAiSCgH2Hkrh-0Mh53Ie9Rgb7z5VIsA
X-Proofpoint-ORIG-GUID: ocAiSCgH2Hkrh-0Mh53Ie9Rgb7z5VIsA
X-Authority-Analysis: v=2.4 cv=NelzRGD4 c=1 sm=1 tr=0 ts=6aa70527 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=NEAV23lmAAAA:8
 a=8k6WQxmsAAAA:8 a=AzqT7FCsPe08lIGMPrUA:9 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEzMDI4OCBTYWx0ZWRfX5KfX27L5UOnV
 1BXGDXR5JtNiY80BTWAPfG9PVzGqonAIyO0iRE9iWQwd0Apig3AURs7FSDhvcmYf1bVrsQ+TKHi
 2VP6jCXRX+o1JP1LG5VJrgH7UZhw2Xs=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEzMDI4OCBTYWx0ZWRfX8ywr+cYcPfzE
 UWEGfJkNoP3jYpobgQsbnJi4xvE9J0+4vpuQfisnlCsXbOQ/e8QRWH5GeMaE/ii/jmcT7l2HtBO
 00sOI+C5oEN3Y6bPDJ3CLkO+jRdXPINk9j/74fX5wxuKPq9A88SOaAl8e+zNTcjY/qCM1Khc8y9
 RVnpTWGaB+AAh4+gmrIGtT9XTVNS7L6wD097v641pbmscjM1w1oimbPpoM3Q/W+Tr0illI9L1/R
 dp72L9csJWya9jDwhQz8T+CB6pQ7mRR8fyVDQkAvFfUYWkOt0Z3rnyBXuIsHvgaGG7GIWOgWKa1
 Zgz1JoAt7VwT6n7bA+NBnC0bYhS1vOZMin0IKzV1gUDI2NOw1P1gFkOv0HebUfEFAyTkXiekLNE
 etK/mS7mrbz5/E5ZFIivOUZ89Ng/JoiF7lQIojDJBJMQwMbEjB2EuOh/3JUVFyO45TOnB0YGzVo
 DkaqyOvi1FQf+I5TAaA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-13_07,2026-09-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 impostorscore=0 priorityscore=1501 clxscore=1015
 spamscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609130288
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

Add device tree support for the Lenovo ThinkPad T14s Gen 7 [1], a Mahua
(Snapdragon X2 Elite) laptop, together with the drm/panel-edp entry
for its internal panel and a QSEECOM allowlist entry.

Tested on the platform:
  - Display (internal eDP and external DP on both USB-C ports)
  - USB-C data + charging on both ports
  - Wi-Fi (WCN7850) and Bluetooth
  - NVMe on PCIe5
  - HID-I2C touchpad, keyboard, TrackPoint, lid switch
  - Audio playback (2x WSA8845 speakers) and capture (DMICs)
  - ADSP / CDSP / SoCCP

Not tested / out of scope:
  - WWAN (wiring included but no SKU with the modem to test)
  - GPU / GMU (kept out of scope for this bring-up)

my working tree is: https://github.com/Srinivas-Kandagatla/linux/tree/upstream/t14s-Gen7
alsa ucm is in : https://github.com/Srinivas-Kandagatla/alsa-ucm-conf/tree/t14s-gen7

I plan to enable DP audio and other things in parallel.

--srini

Depends on Bjorn's:
  - phy: qcom: edp: split power-on sequencing by PHY version
  - phy: qcom: edp: update v8 power-on programming sequence


[1]: https://psref.lenovo.com/syspool/Sys/PDF/ThinkPad/ThinkPad_T14s_Gen_7_Snapdragon/ThinkPad_T14s_Gen_7_Snapdragon_Spec.pdf
Srinivas Kandagatla (4):
  dt-bindings: arm: qcom: add Lenovo ThinkPad T14s Gen 7 (Mahua)
  drm/panel-edp: add CSOT MNE007QB1-1 entry
  arm64: dts: qcom: Add Lenovo ThinkPad T14s Gen 7
  firmware: qcom: scm: Allow QSEECOM on ThinkPad T14s Gen 7

 .../devicetree/bindings/arm/qcom.yaml         |    1 +
 arch/arm64/boot/dts/qcom/Makefile             |    1 +
 .../qcom/mahua-lenovo-thinkpad-t14s-gen7.dts  | 1184 +++++++++++++++++
 drivers/firmware/qcom/qcom_scm.c              |    1 +
 drivers/gpu/drm/panel/panel-edp.c             |    1 +
 5 files changed, 1188 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/mahua-lenovo-thinkpad-t14s-gen7.dts

--
2.53.0

