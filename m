Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 182FCCC6B19
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 04:38:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 473D010E589;
	Wed, 14 Oct 2026 04:38:42 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1158A10E589
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 04:38:30 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69DLRQjU1402935
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 04:38:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=zHsseOeWAElKEmE5r+P3cx
 LFa3K3+ikDKsntHOfjkm4=; b=hxkhrebQOy+hMKOK/I97zz8ceoDxPs3h8y4Mw2
 1XRw5RMvHQtn2jZ/cAKFi11jfegXNLYDXQ35u/S/n57J2Z63QaEk7ts0JCkgu3HJ
 GYK/odRTS2bn87wme9k26vG5ik8irCvorZzO8C2+1NNmsBkjECEunv49GXVqT8U8
 OWc324JBBppaMtegUNarCpO3j/JVI5Q0cgABa4Oaz54kv7RmQSnReZXtXK6UCofJ
 kyRfPlHm9UBdkhjEtr0BDOwIOLc3Yc/WFm1Yu7pGQO8onw2wIwW29aIXheyHAF8f
 kSwykt0f5ab/lxLEbUQZhZaqBrPBow75xqWTr3rXm2jNG+GA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h9psk3292-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 04:38:29 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-535213e3a7aso79728701cf.1
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 21:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791952709; x=1792557509;
 darn=lists.freedesktop.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=zHsseOeWAElKEmE5r+P3cxLFa3K3+ikDKsntHOfjkm4=;
 b=WJ30+/BYdwHIBm5GJu9mTR8xAAcuAKIvg+Jk69cT2oTgHrD/CULqeq2vW5WFteRkrB
 kNbiefzwK80YGSEzwpCCC2UHSz31Bq28ZLV/Pz9KxHO+PFRUeuuqSaXevEcTIGdwb9q1
 B0Bv8eM6JBwW2WuesgaQBAZCeaN5UPA5NKuK86/ZSKHPk92XegCSJx/kVI6WPN2o1Do5
 rjM2L/z+WGSS83i45HoG/s7GerqOi7/jS0DpM6FtyIREUur3fYhh56azZQ37AvUabtsA
 L7hCeMfcaKvLaWCAOU8OcNZfYuoS8xe169kQL2Y5eXkWTve+jY5/xuwZN6J1Ro9QACFb
 JeUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791952709; x=1792557509;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=zHsseOeWAElKEmE5r+P3cxLFa3K3+ikDKsntHOfjkm4=;
 b=v8sVsf4EWBqX+3sCgmekkKLxATrUBKQolnzHhpq6WUIUox/dtq2fZsazY9x9mpCPKw
 IKRuf+8N9hDDtKkak+7N/lggwYXkTYnuSzt4IgjzVpVrbk1NoBQCrKj+zpB9wVJU6u6P
 yBV+QDEgmX4Ge5cHpfMnx9xQTYGUeBufCo4xQv5ZtLFCwC6SzDp8SdAXrvpiFHdLQx2k
 f3ImANfiEUqsB0xSkE0CdCIh6rXysaoGlCjpbSK4qATfYl/gxHCYzY8DWoSDPY1ttYVK
 S63+suyZFQ6kGtbzeWZLolNPy5XSl7KxJjMaKskh1C0opDJS+bFpepv/MfzoHAevixFK
 D1yA==
X-Forwarded-Encrypted: i=1;
 AKwUvBx8q9ViZxLc1Urwzf2J1Uev4N7CGbegisitPnBThhLwjkAJSSOLDyj5+6lrvwEljJv89ST2jGIKOx0=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIm1w7stzmOJXc6CsHd3qyaTci8fmeAzJXTTWo2qAB3dGfpiWCs
 8D79Z5IYMkr+R5r9ihEfV5Al6rtaNGjNDXF8SJRO+FsUQOM6skhNoa9hXg1rHaPJwxzDc9Q60WS
 Ps1lJBl7HO0ZV5kHFcOJs7h5OLcnOuqMjEWAkgVRcRPiIZDrBASAdlqj5eO6bWCV83N5ClkE=
X-Gm-Gg: AYBFou1PWImghNerGR2JzsLPVTureC80X/GPpCc6ypxujSJmFR8b0GcggjiiNmtZYyC
 +cQs/nS14gE7tZWltBYxt2L/OH7SCSPUXs3lfCIie8HLxfk0rZ1v0IOTeyV+v1xctS7IP26+7Us
 /yvbr/31uwYozU0zJVMRS95jzTbetPPxAEmmp6oLU19WtmYqK+/yN8ZtOs9f3SgSw+35l7NM8rj
 LBgcXenfsgLQpEChtqdNzoGcVZgfb62NU6W7aJu8UhBLp/Zvf/0VGPfuAxraDMC6Wl0CP7g6T8T
 nytomAm/WAAGdGlPOp2/R2yk0sHA+DxQ3U3IUtw13cAPQ+Nzr6C5qHtLKkNdVR2b0gHIBFV9Dmf
 uUd2SK+X1Kjxox05yClMZWcxTflhfcFb6V2OBr7dl05e+FmSWr/q0613E31/74A==
X-Received: by 2002:a05:622a:2512:b0:535:70b4:3f7e with SMTP id
 d75a77b69052e-5359fe43389mr211290151cf.68.1791952708959; 
 Tue, 13 Oct 2026 21:38:28 -0700 (PDT)
X-Received: by 2002:a05:622a:2512:b0:535:70b4:3f7e with SMTP id
 d75a77b69052e-5359fe43389mr211289881cf.68.1791952708446; 
 Tue, 13 Oct 2026 21:38:28 -0700 (PDT)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-5359b755c35sm116809651cf.15.2026.10.13.21.38.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 21:38:27 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Subject: [PATCH v3 0/3] drm/msm/dpu: Add INT2 GDSC power domain support for
 Kaanapali
Date: Wed, 14 Oct 2026 12:38:15 +0800
Message-Id: <20261014-msm_gdsc2-v3-0-f1ed69014416@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIADcHz2oC/23Oz27CMAwG8Fepcl6Q47RJ4bT3mKYpfxyItNIRl
 2oI9d0J5QAHLpY+y/r5uwqmkonFrrmKQnPmPB5r0B+NCAd33JPMsWaBgAYsghx4+NlHDiiD36I
 GQOswinr/Vyjl/9X6+n7kQqdzJafHUnjHJMM4DHnaNSqlRMkDhAAeolMJHWFLOmqtTdtpIGc61
 Ym7dcg8jeWy1pzVir1pNCsJsjW97Y2JJnj4HJk3p7P7vT/d1LFiMz6BrepeAaxAXVnU1ve6xzf
 Asiw3AQQZsDYBAAA=
X-Change-ID: 20260720-msm_gdsc2-cb9230027a2d
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Krishna Manikandan <quic_mkrishn@quicinc.com>,
 Abel Vesa <abelvesa@kernel.org>,
 Yuanjie Yang <yuanjie.yang@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Abel Vesa <abel.vesa@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791952700; l=2167;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=72aggRx/HIDl9GZSD801svHQoj+lJnCOeW96djJTqv4=;
 b=hBTTjNxxhpIoKhphaH22oTQuYklHQFYwl9Xaz45Ey165pOfxzWpsrD58EmQJmZqT9GKtgukJi
 D9H2ILC0jXbBzggzX12Bh2rb+ttre3dt+XUJw4qfc2L73QlTlG/MA1g
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-ORIG-GUID: xUABI9haWvLDruMm0NpyYQtv6Balaq_7
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDAxOCBTYWx0ZWRfX9XP5zAWMjuBo
 UTmIX9L+LTKqTMV9qWwfybIzMsuRQ+oUCXl43Twz6dzBXA9X6pxaSXxz4OMXeuuNioaszjiJ7x7
 9bKXwemngmc2bQMrQd5UrYNtPV9ADN0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDAxOCBTYWx0ZWRfXwKx5mH40L8cd
 rgHMJ5qu54OSXak8A+nXmB4BuD0jjz5CunBLv5NRdyOQKHqJjnNAMzm7A3vhzRUrV0kbMY+OeyR
 HVaBteX7TM55eeYU9qdIZ4EWz4q7s++CguYuuobV8uHHf+BXZlDY9EQnUfseP/7eN0lHn9GgoaV
 0abNoFo2mYTvXwYzERy6ciNZYllzk5Pjmem+B0I+LxZynoqdNz/qFAm6qqe9Q0glYN4wJP7dHyp
 LfPORB2IKLNfW9iphV/Xrk2wSFrz4jIugThrbg24P0b/sj+hgzRd/R9yJEUkr8kuOpJfOCXhNT5
 DVi++rCV3MCp6j6DPc7YeG4gN3l14hzO1CHujXi9r+B7nuLIG5gPMwvER79wMld3YNSY+HWtZ7C
 DHTJUxGFyN8Vt4CrEv6VHmPf+50vgq+loqLMIRSe7UAbAFh2Q3wx6KNniOxnvFAUb95Aja6j2Zw
 /wcjmSleH5v/D9npIHg==
X-Authority-Analysis: v=2.4 cv=cbJHPXDM c=1 sm=1 tr=0 ts=6acf0745 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=cXFZYRxNi65dCB_EMakA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: xUABI9haWvLDruMm0NpyYQtv6Balaq_7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 phishscore=0 adultscore=0 impostorscore=0
 suspectscore=0 spamscore=0 malwarescore=0 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610140018
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

Kaanapali (SM8850) has an additional INT2 GDSC that powers a
subset of DPU source pipes (VIG2/VIG3/DMA5). Without enabling
it, those pipes remain inaccessible.

This series describes CORE and INT2 as the DPU power domains,
updates the DT bindings accordingly, and explicitly attaches both
domains in the DPU driver. DPU performance-state votes on CORE
are propagated through the genpd hierarchy to MMCX.

Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
---
Changes in v3:
- Replaced MMCX with CORE as the DPU power domain, keeping INT2 as the second domain
  (Dmitry)
- Used generic "core" and "int2" power-domain names (Dmitry)
- Propagated DPU OPP votes from CORE to its parent MMCX domain
- Updated the Kaanapali MDSS example and fixed issues reported by dt_binding_check
- Link to v2: https://lore.kernel.org/r/20260915-msm_gdsc2-v2-0-9157237b8382@oss.qualcomm.com

Changes in v2:
- Moved INT2 GDSC from MDSS to DPU, as it only powers DPU-local source pipes (Dmitry)
- Dropped Glymur — only Kaanapali actually needs INT2 GDSC
- Used if/then in DT binding to restrict second power domain to Kaanapali compatible only (Dmitry, Krzysztof)
- Dropped PD_FLAG_NO_DEV_LINK, let device link auto-attach handle INT2 as runtime-PM supplier (Dmitry)
- Link to v1: https://lore.kernel.org/r/20260720-msm_gdsc2-v1-0-4687866d6cb0@oss.qualcomm.com

---
Yongxing Mou (3):
      dt-bindings: display: msm: Add INT2 GDSC to Kaanapali DPU
      drm/msm/dpu: Attach CORE and INT2 power domains on Kaanapali
      arm64: dts: qcom: Add INT2 GDSC to Kaanapali DPU

 .../bindings/display/msm/dpu-common.yaml           | 19 +++++++++++--
 .../bindings/display/msm/qcom,kaanapali-mdss.yaml  |  4 ++-
 .../bindings/display/msm/qcom,sm8650-dpu.yaml      | 21 ++++++++++++++
 arch/arm64/boot/dts/qcom/kaanapali.dtsi            |  4 ++-
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c            | 32 ++++++++++++++++++++++
 5 files changed, 76 insertions(+), 4 deletions(-)
---
base-commit: 1fffefb00cc0b0da1f2ae24e3d33364530ea6515
change-id: 20260720-msm_gdsc2-cb9230027a2d

Best regards,
-- 
Yongxing Mou <yongxing.mou@oss.qualcomm.com>

