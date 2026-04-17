Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9300F99C63
	for <dri-devel@archiver.kernel.org>; Fri, 17 Apr 2026 23:11:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0015B10EAD1;
	Fri, 17 Apr 2026 23:11:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="hZ+3eMvM";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HDqmWx3j";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF5C810EAD1
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Apr 2026 23:11:31 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63HG4H934068739
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Apr 2026 23:11:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 r9vlvT/yQ2K62b6JOQlgrZNorBhm2dAWPSxZZK/89x0=; b=hZ+3eMvMMiqhWS74
 cfSj9dpGME3VJfgYr/j7TmvyToM4KcvIXMnMta/yfylNcsZqbDR++RNBqSu8DhP+
 21KpqcWO3aM8rZ56Ej6dIb+bOInmjA7mTrS3uxdZ8IgU3itHTRTGgW9yJ1/IQAG1
 LqyBj4JVhT2QhSlxPlh+oOBazZJ8XbgPnw3YNHfCalhqawViNf5j/QmvCZsM0Sjf
 6aBfgirDAfLnoB6XNod/rlUuc3CpNUTWi2HEWhgwUNg33dy2D1JsJ53n+PEKd3q4
 WmQAd1TnjXcGw/r+NY24k12A9HHYPkknTy/mj2BQeLoZ98BJMWHWa4YfEP4NRiIZ
 I9YDYQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dkhpu2k7m-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Apr 2026 23:11:30 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-50b4b81c632so29738601cf.1
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Apr 2026 16:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776467490; x=1777072290;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r9vlvT/yQ2K62b6JOQlgrZNorBhm2dAWPSxZZK/89x0=;
 b=HDqmWx3jJru1+Fq6CnJuhPKE+6+85FPddWPhlNbiO+j7RJdxMGonii6WsSTm4QFhj6
 2EJsgnHOKpv79l1WlMNYGKBCofGQk7ZFvrUtKeoLEOUoRjfpuZL7v6T/fi3i/WdGbCJ8
 a0WrgF7YPqXlMPGsGOjhmIWn7+G0HVLPzCceuGbXofRpIoKETb6Ezwps//aN2hQgId10
 FDe/Whc+iKk6Mtzsakk74ZhqeHh730y0IGkU0aR4zvJJBNCBhDI336SCIyl8sTmFNSBC
 rvHHsJ59sBUZXHljnpXPyMml+EWt+I30Jd6icDehIbFJNCMdzfpgIIS7z9tmBaerNgEg
 89ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776467490; x=1777072290;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=r9vlvT/yQ2K62b6JOQlgrZNorBhm2dAWPSxZZK/89x0=;
 b=dxnsEhFHW/QOAuyGnx9K2g8hFqHp9BBvmZq5vJazWuKUR44TVKK7KYNc80kw+kkarp
 jx8ISLZgOoDWjedr/KELi8bob4aZj1WEO6eJmFoh551I512RtjdFvLPOufsT9guefXri
 m0szducD5kuRTF4iLz++Wo75fp+jW+bF8k0711E6xj1za6q+2JBOSjwDrAzDGROHQ7tU
 v7PLsI3lwZKag03m9a87kYvXG2QJ2XEHkoUXhoQ46ffuXSymhzJ42LZTK3niwnJLwNij
 D2rMIsmAjwAHvk7TpB8UnwT6+IgZoz2AGmfJ/KHQvlmaQVHr6koMqC4BoCj18SATI1xp
 k3Qg==
X-Gm-Message-State: AOJu0YzvvT2c2tdmfdHh5FETA8vp79UmL0sjdlsxciRzwCYDaRFwf5kK
 SiBz51oRjrwmqMONDwNLgFsh5/+Dp9Hb+T9dTrZlNPIXXCKrIshP7G+ZZpaLYr7xEMs/aqOQWmz
 BxSJSGk9LLZiFZY/hPNwI9ica+8rLCQd1GI8yC31TizDmst/gpUR4UqNZKQciyo2CDqtW/1w=
X-Gm-Gg: AeBDiev2qzL56O2pOF2ZGaylTfOSAiYPqsig1W7cgTM8fyKaof7UXxYrUIzfEn1cVbl
 Bb4P5vvAa59uXbJ2CQ1ZqeIc/uy8SQs6SRS9GYYDiGPgaCsg/BBkwZ5L88TKE+rOG60Pv51ap1+
 EBXVOh1X9vqDgw2tcq4MXgm7NatLeFulyg4CMZd2Ti//ox/y48dmoVnLabJmfpuenG5/zCpFd+5
 ABWHOiiSliWygZQu/P/Qbx7KhJUzSxBFrwwb/eGEw0Y5ghrn5POfsUp4xy2mOO7OdnqX5Epy4I+
 n9Hewo0PjZ9sw6UKUhsnhVLiuIVOsGvPrfYdq1tqUodbc3LTyrejt9nU2lWIIUw0c0fCRXFwq18
 2/xFd3xLyUKxDBRXsFlhvNqx06BitGvF2PumiEZU2HW02wvRcUChdh8YCvKAAm6VvJNXwjogaJX
 Bx/F++yJZIovNH52SmbUZc5dmkl3k+9kMz5ciEhxLnnIwN/A==
X-Received: by 2002:ac8:5fd1:0:b0:50d:a6e3:ae1 with SMTP id
 d75a77b69052e-50e3693d3d6mr79033131cf.17.1776467490304; 
 Fri, 17 Apr 2026 16:11:30 -0700 (PDT)
X-Received: by 2002:ac8:5fd1:0:b0:50d:a6e3:ae1 with SMTP id
 d75a77b69052e-50e3693d3d6mr79032601cf.17.1776467489817; 
 Fri, 17 Apr 2026 16:11:29 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a41ab29ae4sm496283e87.4.2026.04.17.16.11.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Apr 2026 16:11:28 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Cong Yang <yangcong5@huaqin.corp-partner.google.com>,
 Ondrej Jirman <megi@xff.cz>, Javier Martinez Canillas <javierm@redhat.com>,
 Jagan Teki <jagan@edgeble.ai>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Linus Walleij <linusw@kernel.org>,
 Bartosz Golaszewski <brgl@kernel.org>, Jie Gan <jie.gan@oss.qualcomm.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
 Riccardo Mereu <r.mereu@arduino.cc>
In-Reply-To: <20260413-waveshare-dsi-touch-v3-0-3aeb53022c32@oss.qualcomm.com>
References: <20260413-waveshare-dsi-touch-v3-0-3aeb53022c32@oss.qualcomm.com>
Subject: Re: (subset) [PATCH v3 00/21] drm/panel: support Waveshare DSI
 TOUCH kits
Message-Id: <177646748816.2514455.14063972983042934626.b4-ty@b4>
Date: Sat, 18 Apr 2026 02:11:28 +0300
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.1
X-Authority-Analysis: v=2.4 cv=Kd7idwYD c=1 sm=1 tr=0 ts=69e2be22 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=dsQwgn-brIFo03Fd59kA:9
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: hazwViBS95MEqCNjjjEpJJlK4Ty2b-8x
X-Proofpoint-ORIG-GUID: hazwViBS95MEqCNjjjEpJJlK4Ty2b-8x
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE3MDIzMCBTYWx0ZWRfX4s2eg+34RScv
 tk635eKgdf4z9uNWBsczSPFhzZomWBdaisjaMfGZcLFPnbHaMW1x8q+sIc4pokDZxuuS0qEuQe4
 oHmWI66UyYDJhmXvReGX/Y9G4sULFrqDtWNLIG2Kzi8fbKUsfjI3Igtu/b5Kw1P0tceR/iImIgX
 nYyXWPIiiEW9feyjRAG4nyO2z/iRair6/qxta4gjal0PsfyeWN/UmvTwMHC/xEniLxZaBwQP05B
 n8BlnSpR6teCEyAdSfXBldIeU+aO+CSqRcgcoC51c5ppkKwH3bFm7iAt518DA8MLuyWOPkp1/a7
 nZgvCXyuZinMH+gUzJlEUX+iX0HJMczfPkOmEBInitwnKANSlvWjwFTwkU2jcOkdCe3QmLNz9bL
 gHzmulY5tg0jCPC1xO5byiznHCNoAKHOPpTUe0KZDeT0zbOZneV3V+0hZ1n4U3onAm+lO8D5UxT
 2jbYGvBW+uU9+/lKazQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-17_02,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 adultscore=0 spamscore=0 phishscore=0 suspectscore=0 malwarescore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604070000
 definitions=main-2604170230
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

On Mon, 13 Apr 2026 17:05:23 +0300, Dmitry Baryshkov wrote:
> The Waveshare DSI TOUCH family of DSI panel kits feature different DSI
> video-mode panels, bundled with the separate controlling circuit,
> produing necessary voltages from the 3.3V and 5V supplies. Extend panel
> drivers to support those Waveshare panels and also add GPIO driver for
> the onboard control circuitry.
> 
> 
> [...]

Applied to drm-misc-next, thanks!

[01/21] dt-bindings: display/panel: himax,hx83102: describe Waveshare panel
        commit: 0eb86d3622d20679a4c64606df4e8cd6af5398e6
[02/21] dt-bindings: display/panel: himax,hx8394: describe Waveshare panel
        commit: 4a70ba67ee5f8ba3a563611eed6ff41eac2b41ed
[03/21] dt-bindings: display/panel: jadard,jd9365da-h3: describe Waveshare panel
        commit: d13d9306acac0a71c567154a4e1b3ca9d5c58cc0
[04/21] dt-bindings: display/panel: ilitek,ili9881c: describe Waveshare panel
        (no commit info)
[05/21] dt-bindings: dipslay/panel: describe panels using Focaltech OTA7290B
        commit: 17b2ab777384d04cae0e5c1e19287d16369e745d
[06/21] drm/of: add helper to count data-lanes on a remote endpoint
        commit: a8c56e00c608d5c70eb89464676ea0b3cdcb1ce6
[07/21] drm/panel: himax-hx83102: support Waveshare 12.3" DSI panel
        commit: 1af0feaca130e7fef016184f85f803385de13ba0
[08/21] drm/panel: himax-hx8394: set prepare_prev_first
        commit: dd0d0a487172bbe9626efc59a43d5dfbea64cdd4
[09/21] drm/panel: himax-hx8394: simplify hx8394_enable()
        commit: 917e888d38fa1e81781da39daceffad41e9d2109
[10/21] drm/panel: himax-hx8394: support Waveshare DSI panels
        commit: c3b595b16cd2830bf755b4385b19db41f2c238a8
[11/21] drm/panel: jadard-jd9365da-h3: use drm_connector_helper_get_modes_fixed
        commit: 0a26b74898a5d385fa9226475d7d2d3afef1716b
[12/21] drm/panel: jadard-jd9365da-h3: support variable DSI configuration
        commit: eb019688f2a97bb95384853072de3a88b981f1f3
[13/21] drm/panel: jadard-jd9365da-h3: set prepare_prev_first
        commit: b55a4b5d4769a650f52ea3f1ae680610169d125e
[14/21] drm/panel: jadard-jd9365da-h3: support Waveshare round DSI panels
        commit: ba362fb2e7fe5676b388da4fd976c993046e3611
[15/21] drm/panel: jadard-jd9365da-h3: support Waveshare WXGA DSI panels
        commit: 5a7770a06f38152e50e3fa8d1acd77d0ef259c3d
[16/21] drm/panel: jadard-jd9365da-h3: support Waveshare 720p DSI panels
        commit: 13414cfd4839804b924ad9cdf0337d3c335a1943
[17/21] drm/panel: ilitek-ili9881c: support Waveshare 7.0" DSI panel
        (no commit info)
[18/21] drm/panel: add devm_drm_panel_add() helper
        commit: e43a8e3ad8fa3c2c2220a06fa46545c7ff82a9b7
[19/21] drm/panel: add driver for Waveshare 8.8" DSI TOUCH-A panel
        commit: 07853e95424869059d7ce1cd25c800f88ee03e95

Best regards,
-- 
With best wishes
Dmitry


