Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A71B2CD4851
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 06:25:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0466710EA8E;
	Tue, 19 May 2026 06:25:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="am5CuE50";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fFaq32GO";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0487910EA8A
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 06:25:38 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64J1RTC81146378
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 06:25:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 LW3SV5TX2I28SkWzxB7Q6UbE9TthcyK/njTvAfatWVs=; b=am5CuE50d1omwcLw
 FdhxXsilVpCxgnkyF/LOeXtKi6so7YzWs7VZFwpuM5LYOck4NcGoQcIvIVI3mvPW
 gbfusC8Pyo3BA6fHBkIZwNQFCGqsIC9DHzfP44Iuk5g8EswAi36xXxJy7q4/GDN0
 s8G04G/cT2t/3h35Cx39dNT8Qyeq8tw0zz+IyssZAVdEkVVbzUzYevMgv7bGq3dM
 7zkm1ZEkv/idOgHWhdMR1Vgjv9sZ546MVtci2fgml8ytr1jJ5yHacx/RGOUu5lBB
 e0EsOrb9KoERvabKhwgoj7tLi/4xDHvaSYlnsTRz2Zdsss67zmUC4g+haIbZQcax
 LQ+4iA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e8e7egy82-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 06:25:38 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-36865d109dcso2844733a91.1
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 23:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779171938; x=1779776738;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LW3SV5TX2I28SkWzxB7Q6UbE9TthcyK/njTvAfatWVs=;
 b=fFaq32GO7veIxu4IUVll6ouMAOdeggdqE8jjp1FqPZ4IOw83k2WMd5mgiPKRC5Yn5z
 Cwmqbp0QbNMUvZfxLVBwGkZUnAMu5sRnSFLg0vxWsrW1yU465N7rVEH6PL1MS4UzL5bK
 l158/ZkNRxHR1AhxcPPRmPWnxwRnn435LnJ5F7+SdHocozhcvp/W0ZZYQAQief+vP7RJ
 cM3HoqKKkoPEtssL1KGMEoGx5Lv7Ys71yoL5tHrKHH3BgtPTfcc0qOJs+rabOpj25QBY
 UXZrhIaWEXvc2TXIMxL3/o4765faQRBqogeDiZV78eET4UiG0lgOWcyg5Nhra/Dv9NPi
 lAAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779171938; x=1779776738;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LW3SV5TX2I28SkWzxB7Q6UbE9TthcyK/njTvAfatWVs=;
 b=h+Fj+d0tHOwCSLajVPWI6peka3CLixeYhxDcelu4n9H1TfUrEM5vwmq3zhAyhqhUX2
 TCAkbDhLc+Ao3yEz4EG6D8slwd+vlDIg2xmtUHQSTG3odcYI1QEhlNGdSgNZVv2ZXfp+
 i27MU6mlWEDxFGfjMIbBGmXFK9gEoQCPV+FO4RKLOpvXWDUQbcdlfpaD0ov3Y8jmBWO7
 yzdBh4WJsqhIH1XsG7HGshqAOBtrbOgpiN4b0KhDNaFPkSxM6lbvbeeF6Ihfl0KrpbGQ
 blb8kWkdd3sIGjG4Uno+Mx2WPTWQWK5RciLOa40HBP8qGzroc3yrYtBL4lg0LAiKjXSx
 7boA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9jLzDsBSBtXC3Wr1ISzhM6Bj582EFC3NqtP/8PWJTyx1B0b0g3Tk8HrFfCEoQOjWL+Pz6HM5kUlHU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxEkuSsyT1JVKti19igPhN4Dt52g+A7PX7qGHb69fEvXj3QgAn2
 NsEmpi1vyRlKcY/KzNZxGZVCsNZPIecPFxsmrkLlYateUyz3uu4wGsar/554fCT2Gw10FosYs2y
 QcY6y4OOmjzvaAcJ94Rg3VSWPyQCk2/1h0WSHgSnWB6uiA/SXT3Bex/A6ylAbOMLFGctcXx0=
X-Gm-Gg: Acq92OGLSQ/BHOILnJhtPTesQHBBjwzaYhp4nPF680rpK5guEvPEY8zJbHK8BcuLcRo
 OC3JRubPLAptVOt+IBiq8aBYrw8ZBg8c1V7pJELoT8/SiwrKNH24mm/KWmRQqSNebbJdX7y0FCt
 D+tPER7iwx1OhhFufL3wzG8RhH4q9BEzUPv+PZoDSELgyHOtJ11uSLdWehV8rP+GCYgMC2jcgiE
 MevMeVcnDj8NyXkS9s1ZJFsNjW7yqNANA/Vq3r1pIiRVRH6z6ONIHwxWc5k3bJ+6UMUEE2bc0DV
 UrN9WebbqWIxZPjb8BpPcukF2w9kdP+rA9I/+CcbUQK/oUJCd1V18x6LlZlmr9non/U7pTkUfI6
 OOta4ISo++h3BYTW7lykSBa/BVzecYs4hkAvTN/wYV1TSfmcpXrQk9THj5kzV5kuBkHlUNb5MZu
 ojhE+lxMLcgRzIanzg
X-Received: by 2002:a17:90b:38ce:b0:365:fd4b:24f5 with SMTP id
 98e67ed59e1d1-369519c513bmr16698594a91.8.1779171937652; 
 Mon, 18 May 2026 23:25:37 -0700 (PDT)
X-Received: by 2002:a17:90b:38ce:b0:365:fd4b:24f5 with SMTP id
 98e67ed59e1d1-369519c513bmr16698573a91.8.1779171937096; 
 Mon, 18 May 2026 23:25:37 -0700 (PDT)
Received: from [10.133.33.99] (tpe-colo-wan-fw-bordernet.qualcomm.com.
 [103.229.16.4]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c82bb116860sm15517090a12.25.2026.05.18.23.25.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 May 2026 23:25:36 -0700 (PDT)
Message-ID: <8c763b81-5796-48fe-a8d0-53ccde6afcbc@oss.qualcomm.com>
Date: Tue, 19 May 2026 14:25:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 00/10] drm/msm/dp: Drop the HPD state machine
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Kuogee Hsieh <quic_khsieh@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260314-hpd-refactor-v5-0-0c8450737d64@oss.qualcomm.com>
Content-Language: en-US
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
In-Reply-To: <20260314-hpd-refactor-v5-0-0c8450737d64@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Rt316imK c=1 sm=1 tr=0 ts=6a0c0262 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=e5mUnYsNAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=ew1LNfEtQ1-U9-51NiEA:9
 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-ORIG-GUID: jWj0SXXRpw8Tbp3TEFVoIz-wV6SlmmGZ
X-Proofpoint-GUID: jWj0SXXRpw8Tbp3TEFVoIz-wV6SlmmGZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE5MDA2MCBTYWx0ZWRfX3NcIewWwN+QP
 t2qGsvUrB9gZ4uZxUMaE3vjZqI/7wA32Jh5BiIAwNgVq/2RhZmeHrXJqPjKqRNh9evLNBMj6n8T
 BfmBaBe8R7NXSnWwtK8nLZrU/1hKkDdzEyRSCEBtsA6oRGipW+hBT/uJuyaZM+x7Vkyxh/jvsFw
 +Y6UByEjIlKL+vZZSVNvw4MgEnYRBq6LQlpHDVjDl9LH9cxBvtVkkfXGQYsUHNAatdaSAeIHR75
 gjROvD1PPk7XyTsyi/rYeSTlPQyy0/khmegx0ay8z+DOshwieabYwTPJNwWQcJUMkgWdFmH+JtX
 uKQa+Ja/jYtm85Neg2U13u4e9NWA67rZ/ZuTRIkykCQEkKRrTQxjJKasK7aKHObbec+B4COCUfH
 CnXmMbf1bYLMLTw00lGPy/i76slX0fpXn8iLNza3mEF4uVpm8tSZtd4DNoewDc8mE3vNtDuntZh
 HDc9toQKRtoVGf5BQeQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-19_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 phishscore=0 spamscore=0 impostorscore=0
 lowpriorityscore=0 clxscore=1015 suspectscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605190060
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



On 3/14/2026 9:09 AM, Dmitry Baryshkov wrote:
> Currently, all HPD interrupt handling must go through the HPD state
> machine.
> 
> This has caused many issues where the DRM framework assumes that DP is
> in one state while the state machine is stuck in another state.
> 
> As discussed here [1], this series:
> 
> - Removes the state machine
> - Moves link training to atomic_enable()
> - Changes the detect() behavior to return true if a display is physically
>    plugged in (as opposed to if the DP link is ready).
> - Remove event queue and move internal HPD handling to hpd_notify()
> 
> To correctly detect the displays which are plugged on boot on the boards
> which use dp-connector devices, this series depends on [2]. USB-C and
> eDP panels are handled natively.
> 
> [1] https://patchwork.freedesktop.org/patch/656312/?series=142010&rev=2#comment_1201738
> [2] https://lore.kernel.org/all/20260314-dp-connector-hpd-v1-0-786044cedc17@oss.qualcomm.com/
> 
> ---
> Changes in v5:
> - Fixed the EDID clearing on display unplug
> - Fixed the initial HPD issue via the external series
> - Tested on eDP devices
> - Link to v4: https://lore.kernel.org/r/20260305-hpd-refactor-v4-0-39c9d1fef321@oss.qualcomm.com
> 
> Changes in v4:
> - Fixed PM runtime handling
> - Fixed several cases where the HPD machine would loose its state
> - Fixed the case where detection was ignoring the plugging in display.
> - Link to v3: https://lore.kernel.org/r/20260115-hpd-refactor-v3-0-08e2f3bcd2e0@oss.qualcomm.com
> 
> Changes in v3:
> - Take over the series (thanks, Jessica, for the previous work!)
> - Major rework of the series, squashed the set of patches touching the
>    HPD states and handling, it is easier to do it this way rather than
>    pulling the strings one by one.
> - Link to v2: https://lore.kernel.org/r/20250808-hpd-refactor-v2-0-7f4e1e741aa3@oss.qualcomm.com
> 
> Changes in v2:
> - Dropped event queue (Dmitry)
> - Moved internal HPD handling to use hpd_notify() (Dmitry)
> - Reworked bridge detect() to read DPCP and sink count (Dmitry)
> - Moved setting of link_trained to plug/unplugged handling
> - Dropped msm_dp::connected (Dmitry)
> - Squashed all hpd state related patches (Dmitry)
> - Link to v1: https://lore.kernel.org/r/20250711-hpd-refactor-v1-0-33cbac823f34@oss.qualcomm.com
> 
> ---
> Dmitry Baryshkov (3):
>        drm/msm/dp: drop event data
>        drm/msm/dp: turn link_ready into plugged
>        drm/msm/dp: clear EDID on display unplug
> 
> Jessica Zhang (7):
>        drm/msm/dp: fix HPD state status bit shift value
>        drm/msm/dp: Fix the ISR_* enum values
>        drm/msm/dp: Read DPCD and sink count in bridge detect()
>        drm/msm/dp: Move link training to atomic_enable()
>        drm/msm/dp: Drop EV_USER_NOTIFICATION
>        drm/msm/dp: rework HPD handling
>        drm/msm/dp: Add sink_count to debug logs
> 
>   drivers/gpu/drm/msm/dp/dp_ctrl.c    |  22 --
>   drivers/gpu/drm/msm/dp/dp_ctrl.h    |   1 -
>   drivers/gpu/drm/msm/dp/dp_display.c | 714 ++++++++++++------------------------
>   drivers/gpu/drm/msm/dp/dp_display.h |   3 +-
>   drivers/gpu/drm/msm/dp/dp_drm.c     |  63 +---
>   drivers/gpu/drm/msm/dp/dp_drm.h     |   2 +
>   drivers/gpu/drm/msm/dp/dp_panel.c   |   8 +
>   drivers/gpu/drm/msm/dp/dp_panel.h   |   2 +
>   drivers/gpu/drm/msm/dp/dp_reg.h     |   4 +-
>   9 files changed, 249 insertions(+), 570 deletions(-)
> ---
> base-commit: 5c9e55fecf9365890c64f14761a80f9413a3b1d1
> change-id: 20250523-hpd-refactor-74e25b55620a
> prerequisite-change-id: 20260314-dp-connector-hpd-f069e66bc6af:v1
> prerequisite-patch-id: 90db75e3fb8bc9c81c67547db7bbd4eefd5d6c40
> prerequisite-patch-id: 1c4d030b93a8cc6c98b3447a8685da24eb1f24d5
> 
> Best regards,
Tested-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com> # Hamoa IOT EVK, 
QCS8300 Ride
