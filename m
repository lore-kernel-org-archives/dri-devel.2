Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D482CD4F3D
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 13:41:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D6C0810E158;
	Wed, 20 May 2026 13:41:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="TyOcFmXu";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FRkkdYaW";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC36610F074
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 13:41:35 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64K7NfJP2065138
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 13:41:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 dVfCWmu9NnLwt3W1x+6m7XcP0Pmlw7T2tdZJKqO170Y=; b=TyOcFmXuYAaJKYq7
 Nc33wRmi0pLyZeGFKkhtc+r9Zjjy3XQf0DrYorpagNjGGAzWsxIePB3LUq+PO4nn
 g3TlvTkK9SCQC9sR9Ul21euyJs6Q6WP2+zV7j7rZL0Melw/v8bVG5QMIWsG8jwh2
 RAKIRfcoEaRvvz4LXASoaEuHnHAIck2xbYDKg9bpNi9LP2wg6KGVoZ73+LMnudxI
 fcRlg7XWwIYBqdVG0xmHy5Hhtnbmzv3g4x6+wIL0wogc3lRgWl8kKuqk0CpTLRi9
 XL/M8BhPSZwkcqssXvY5qeiym1W66nhpPgjlvVUaoFKxDOdVdNG+I0ZmBZT8EI89
 LTzldg==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e8t3t4w9y-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 13:41:34 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id
 a1e0cc1a2514c-956732444ffso9273000241.1
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 06:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779284494; x=1779889294;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dVfCWmu9NnLwt3W1x+6m7XcP0Pmlw7T2tdZJKqO170Y=;
 b=FRkkdYaW/JRNlzds9eYpgSjdGMc3uhk6jcEsaX9Q6cxZ0fJ8PONhqA1OKuClnrKw7u
 Gt1R4f4FQm+Jh99c/D7xARGG9lhDb5j/45q0O6Bdu+l1AG7kQhri1jeQKsslMP5Vr754
 paYGjniRhtMmAlEGUxEabfkT7yPkbu+rr831hi0wtwZ/5/uvL2xN4oM1XCV9rpTULg7V
 2b0xIwiKiOoF9t5poyhAdCVGmzDoSr6nyDwWv8YpmozCc07dZw8Y4hXUr8Gsn8S9ooF0
 l0Rcz0ADfcsH+eFhcOCqTR0nhD91TnQa0BtUu3puop1zoq2+/YfcvReG84WKFN8T4Awx
 cwAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779284494; x=1779889294;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dVfCWmu9NnLwt3W1x+6m7XcP0Pmlw7T2tdZJKqO170Y=;
 b=K2BeXpEEg/AXZsCsoknLKxPMFs8Qtw3c25tSkBjKpM6P1Emuu2d5flNBHHvM68LnPw
 qkDdOOQyuViGQW2kGi4lI+UsBrfpEd0xBt6EYHMuKmgfAsA2Tgpe7kPmUWjFSgsrmcNz
 d9ejC6CL2IxZSUvfo8O8itb0pi265XIkr8OusmHcpVORwhblQF7whBOZWf6lhDnRFV6F
 jvFQv810R+Vcz7wYiioIdRcHf5rGfuzn7VWh7jUED2EkFSfX7qepraZfsylWknoIOsJA
 0rKbo+RZZLiPuR3D9O/4An6PtiwvBmB2JU1wax0TwZdxMPLuovkVT8GXT9jy5ZUbv1BF
 MDVA==
X-Forwarded-Encrypted: i=1;
 AFNElJ97Cc0DrxmaPOy/4DfsxD7bdD+Pq172HTuoOlalcr+ZVfIAYFOZcbXCgiBAzJb8bhkveeNRTjRapXo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyFL0JUrz52s/ry2QC9gb+o2Sc95FT4fDQgtjlXjvoEjuMl1cd9
 FQ/T4MI4tYWm6JuPUFFHBizTjHLBVnJJGYczALHUGTlZJ1/wi5YBXXTEYyIDm8CgJYf8Sv2+pup
 UApVii6ZKevVUkOv7tjiui6At+4WQjGyz6ZzxiaZfJQ9Il3l7d52iuR2yJdrpUDNf9WjVvsQ=
X-Gm-Gg: Acq92OHBpu17FINKBLAeRM1gtgITAGEfiHa040VyMNTv0tbj+ibHCAxoyWZtNYy/U7G
 YwA21RULTAayJcj9cfRW6R0tiUnAiwNaocphipfBxhmX/wKMFUg+5rHEb++d70Phit3NkDOsbhG
 Ck0l8g6a3WFj3MUwlbV7lYpjiirleseIWzhkpHybKzr7tVFWJ19+/BNTvZBzsK263v8CBWHRulA
 z/GLTSuADif2Fr7C8n8UYRjTjRZMz77K+GjFg3AetoXcNJwSBPKiZ+CgxF9HLFeEQRbFiXWoTbT
 galIehCyQwwfu9pgBGv6iY4DXRAItlX+LJVS/UGB4DDV3Gfec2yE03XHJ7lv0bZSF/PMzZ09H3G
 8oQ5MONsekga70JHeba4QODTE+jcmffAa9fCaWFMkgU3d5AW9YUvQ+AGUrE2qEpaShLsxi2MB3D
 btZgh2NHyGn1LZJFXZOXC5C2qqeEyIZW8U16Q=
X-Received: by 2002:a05:6102:568d:b0:631:44d9:2ca2 with SMTP id
 ada2fe7eead31-63a3ffa2650mr14672523137.30.1779284494163; 
 Wed, 20 May 2026 06:41:34 -0700 (PDT)
X-Received: by 2002:a05:6102:568d:b0:631:44d9:2ca2 with SMTP id
 ada2fe7eead31-63a3ffa2650mr14672480137.30.1779284493670; 
 Wed, 20 May 2026 06:41:33 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a9164bc3fcsm4997008e87.48.2026.05.20.06.41.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 06:41:32 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Jonathan Marek <jonathan@marek.ca>,
 Krishna Manikandan <quic_mkrishn@quicinc.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Alexander Koskovich <akoskovich@pm.me>,
 Luca Weiss <luca.weiss@fairphone.com>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 devicetree@vger.kernel.org, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v3 0/9] MDSS / DPU bringup for Milos
Date: Wed, 20 May 2026 16:41:30 +0300
Message-ID: <177928444229.2567181.2193286518117779172.b4-ty@b4>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260501-milos-mdss-v3-0-58bfc58c0e13@fairphone.com>
References: <20260501-milos-mdss-v3-0-58bfc58c0e13@fairphone.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: UqgFFP0BfwhUTyiaNbhiMgnHMZvj4Zps
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDEzMyBTYWx0ZWRfX7nGIrWZoT23n
 VbJGTew65quvIK1qki+IXQRryvn7o7Mnrh8/81PSBeMB35idGXcWyMiKnmVvhhH4vWays8kS+f/
 /bxZ02N5sFblSpbtwBcOP1RtUk6dQGiwtowJongYlA/F+/LkNoWKPiqIZmOUD06f8KxuP83dPVJ
 VDFv4FgLAyZrDNGWImvdgg9zVeeVPu3rfJ8cCvZ8zPx8FW6uVftqVnWduv6/Mx3kYqVfx1/O96k
 0/MLRfreFHCMu30tXQ+yfvKjz4poF2HvPL/Chda6yeEiQVZcXLQ6Bexop5RjUwRCYhmL1MoCevI
 RVYCFNt1nF5/PsmPTiJDFAkVsatpVAfcrsDZIg6sz15ElpoDiwk1bdaSbZdxh2YaPDxhoH4Jy5v
 RPNwxrr+3KUAFW90C2zmxZqrun8V8estOoqhhOsF6e3Vdd5PaVWFjTfO77P3ZfUsUrpqNwxVcdL
 PwdJXRWENSA3RevECRA==
X-Proofpoint-ORIG-GUID: UqgFFP0BfwhUTyiaNbhiMgnHMZvj4Zps
X-Authority-Analysis: v=2.4 cv=C4LZDwP+ c=1 sm=1 tr=0 ts=6a0dba0e cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=e5mUnYsNAAAA:8
 a=dydZwlHECne5IGhmaagA:9 a=QEXdDO2ut3YA:10 a=1WsBpfsz9X-RYQiigVTh:22
 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 spamscore=0 phishscore=0 priorityscore=1501
 adultscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605200133
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

On Fri, 01 May 2026 09:14:42 +0200, Luca Weiss wrote:
> This series adds display support for the Milos SoC.
> 
> This is tested on the Fairphone (Gen. 6) using the SM7635 SoC (8bit DSC
> cmd mode), and the Nothing Phone (3a) has also been reported to work by
> Alexander Koskovich.
> 
> The panel driver for Fairphone (Gen. 6) and devicetree enablement will
> be sent later.
> 
> [...]

Applied to msm-next, thanks!

[1/9] dt-bindings: display: msm-dsi-phy-7nm: document the Milos DSI PHY
      https://gitlab.freedesktop.org/lumag/msm/-/commit/6a64e18774bc
[2/9] dt-bindings: display: msm-dsi-controller-main: document the Milos DSI Controller
      https://gitlab.freedesktop.org/lumag/msm/-/commit/fd2ce4931c78
[3/9] dt-bindings: display: msm: document the Milos DPU
      https://gitlab.freedesktop.org/lumag/msm/-/commit/5354032dc203
[4/9] dt-bindings: display: msm: document the Milos Mobile Display Subsystem
      https://gitlab.freedesktop.org/lumag/msm/-/commit/f5d66543884f
[5/9] soc: qcom: ubwc: Add config for Milos
      (no commit info)
[6/9] drm/msm/dsi: add support for DSI-PHY on Milos
      https://gitlab.freedesktop.org/lumag/msm/-/commit/bdb927095689
[7/9] drm/msm: mdss: Add Milos support
      https://gitlab.freedesktop.org/lumag/msm/-/commit/88210726c65e
[8/9] drm/msm/dpu: Add Milos support
      https://gitlab.freedesktop.org/lumag/msm/-/commit/a48fe7aa0a2d
[9/9] arm64: dts: qcom: milos: Add display (MDSS)
      (no commit info)

Best regards,
-- 
With best wishes
Dmitry


