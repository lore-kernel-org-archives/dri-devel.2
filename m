Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CF4AF44868
	for <dri-devel@archiver.kernel.org>; Fri, 10 Apr 2026 13:53:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D36EF10E96D;
	Fri, 10 Apr 2026 13:53:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZQmJ0Gr/";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HRZU9Aud";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D7D9610E96D
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 13:53:18 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63AA9iIO2047771
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 13:53:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 SA8q9XbWwSJxbasNk+eLkRvSS+p9snXeEXYx6lEckY4=; b=ZQmJ0Gr/lRPzANcL
 06F5yVa26sY/3EoM2qfyDEcYI9NR9fxYiZcbFj3S3sQXEnWdSaAHRIDAJcpucguX
 wZd4MFTazdqVjSk/DDGfGJUr8YhbSxn6rjquMNksIH0bugn5E6b+YCSbGieHVZFh
 ey1nRmmnTGBRhQnZT3TnX8KDqHt/gtS9oKGLKUg5NDietYpcF4pQE3i3K3xfiGVc
 K4ysRzVps27LQQkxERCgViLNVUgAMODwVMD1rgPE4/OFEFNc1RnPDKqpB63NddhJ
 aNfEWUyHYA2vRTNrhiT4RVCQNuAN+ZvYZS9on3Cro6JMM9dbYp5GAxwgve2cStLV
 6mPQsA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dey778nf7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 13:53:17 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-50b4661881eso23375141cf.0
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 06:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775829197; x=1776433997;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=SA8q9XbWwSJxbasNk+eLkRvSS+p9snXeEXYx6lEckY4=;
 b=HRZU9AudjZ+LQN7PgZQI35264L16h+LbVz2h5CunbSuI1XRz1MMgAJbuDPQVVoZfKX
 W+eqLsFGtBlD2L2PdnU2zY66GNEZn3yBRpOzx6TrhrUmNqX8GOCnZwrZRpJKzpelgmk/
 MZJo2SKuOFu8ecKmVkE7cidnFNV1VHCF6SyHCVNhEnMwtI8t5KaVmvXG3P1UNPwP5H3G
 OnKk7V97YYXUo5lh11Lrz0BOwW8Fq7Ylfq9Bmej5/LLGYcXGJPcFQb60UvqAFhbLBVZ0
 2nN4B5D2opaxniftr6BlEH5nvELUsIBpXc/z0KMjrP0MnbDZSAqWgj0pmVbCXc0Kg0o+
 ta4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775829197; x=1776433997;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SA8q9XbWwSJxbasNk+eLkRvSS+p9snXeEXYx6lEckY4=;
 b=apkdft5vBR5yN5632iXDaMMwIaID8Jgjt42nFm1RqtAe+T2jf2dCvT0RtmGTL1qLk/
 uN0bipNDi2V3fcw2Mt6vQVe3uueDwypDmWf2MIgqOFm9q6xIv2RD9FWDWflc1h4r9nQb
 0W68YkwfO2pcSvpKvHRwqCBAZRTfK7OMKsyKS4+7zq5tXSzqHltXXXda2zrKWt9AEzqb
 eUdmDaAs9XMHLu07Mj20MmuXA3vQr4O2lWv7DAoey8Su2+i6WLmXbCquHfAZsCbB73Ul
 y6rRFPBVhcv57ufpUy73/pv81VH4Edek1ngnps5h0ua7qXl1Bu0AlruPJOXQuDT75XDk
 2LPA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXNdK+L2xRlCsYTr3MYM5MopPy5ln/rtZI82QrtgIoYyGYbr//i1Z9otBLdpNbqVby0I5oi9LKwfGg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy5xVFLU7YvdDANZ/68tz8ImElb84DUPEJHJigNHpivqK75NgZL
 AlGxytEfuGe2wNlzSFeq0335wb93lmnbMB/roOAxaMgfesOHuachNIaGPZ3JQuj82J6LCIGp9Xp
 mnEuDfrc9AfoVxmuW0zN/ySElUeaUcRoICLSlle+R4hR7F9PRyD0QJMpC21ZtO+WWDoHS+5Y=
X-Gm-Gg: AeBDietYz0QUlNKuJU4l3RJla5df6cOKALuAnutVCYrqX/Xx/iJkniW4h4C6fZhMOzM
 Ix26BQsDue4dqXo99I4AkUMWy3GRwNYA7IoH421xsqIlBXoedpAyD+S8PAIZw+1TWfelex0ypdC
 SLt6BxmeCVTedX/h0mPsL983fBehDbBHRxr45lW1ydUb1jGKlknLLDhS+qupnFlqJs2hEgt8xdz
 8y52MTyl4QUwGFi6ZHOXulq0YdXoe27UMlOGQEt/BvAJ7cBqECYDRlcb7i89TwMRoOgwtj3R993
 /yUor0q7MFNRn9UGHt8urQp1y14N/Z0JR/WZmwX+stbe0qQtXdmmGkyoYeo7k6GprJ3bhVa7G1g
 LaiaKbL5FSoIXL/OoXCsq6Xx1C/3DcZdTfLo27jhqHr0iyFVSKFnUnsYdNdDGy5iw4LGju/dzQE
 YMtXLxdx+CpnH597YnxbATKaeZMFsigVCsk9s=
X-Received: by 2002:ac8:5993:0:b0:50d:a56f:6085 with SMTP id
 d75a77b69052e-50dd5bd65edmr48352131cf.43.1775829196777; 
 Fri, 10 Apr 2026 06:53:16 -0700 (PDT)
X-Received: by 2002:ac8:5993:0:b0:50d:a56f:6085 with SMTP id
 d75a77b69052e-50dd5bd65edmr48351341cf.43.1775829196016; 
 Fri, 10 Apr 2026 06:53:16 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a3eeef3232sm749709e87.56.2026.04.10.06.53.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Apr 2026 06:53:14 -0700 (PDT)
Date: Fri, 10 Apr 2026 16:53:12 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jessica Zhang <jesszhan0024@gmail.com>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Abhinav Kumar <quic_abhinavk@quicinc.com>
Subject: Re: [PATCH v4 00/39] drm/msm/dp: Add MST support for MSM chipsets
Message-ID: <dmqbrh4fvxla6zpabf7qbamgl5lp6watpu6hcdixr7gc5kfn7t@czoyh2shgatr>
References: <20260410-msm-dp-mst-v4-0-b20518dea8de@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260410-msm-dp-mst-v4-0-b20518dea8de@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: Iww_CNySFKitDtF_aMjszIh8fuXd7XRD
X-Proofpoint-GUID: Iww_CNySFKitDtF_aMjszIh8fuXd7XRD
X-Authority-Analysis: v=2.4 cv=VN/tWdPX c=1 sm=1 tr=0 ts=69d900cd cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=e5mUnYsNAAAA:8
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8 a=KEXGhDVU-QvyDDvNTLIA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
 a=Vxmtnl_E_bksehYqCbjh:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEwMDEzMCBTYWx0ZWRfX5P99YLfxInwJ
 ZV64P2z5pVTmZ80gLXSZjUTsLthvufHhGHZKrlIJuE2xZ2TXelP/y7vP1Uux/TXWze8LruanNZE
 dFxt0UrlQFpCN3KdAOcVVzdTm/2n7QUR/qE09ZEWjdGOdGJm0dBq8fC9YicfoWD33hhVCToqdJA
 DFXViwB3ze8GcUSCvdx3kD9ovqIzvIp1YKpr/rbaI6COp1NjgtockzmSKEjMlC66cM9jykn8JTY
 5F37YgKUbXhwwgv2Tqz+ZO0vy9LZ2s47s7IlnnCYldgQqzJlH1oXGeDaqcimycgQ6ngoDV8vqYG
 D9G9rLS9v6f56zWjjF3WRtI8jDgQkTLCCY8gj9g9GIre/cuBz2DAhFde1Zi3UKU0p/IvN76D0tV
 9THiyyxKslDtlhwVp6EBbgAqgGp5/uc7egJwyj7o/x5UjZcCEl//GDBcfT7Sbh9NiKgNOLYuDwC
 WLcgduPMLxRr5gZy6CA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-10_04,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015
 impostorscore=0 phishscore=0 adultscore=0 suspectscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604100130
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

On Fri, Apr 10, 2026 at 05:33:35PM +0800, Yongxing Mou wrote:
> Add support for Multi-stream transport for MSM chipsets that allow
> a single instance of DP controller to send multiple streams.
> 
> This series has been validated on sa8775p ride platform using multiple
> MST dongles and also daisy chain method on both DP0 and DP1 upto 1080P.
> 
> With 4x4K monitors, due to lack of layer mixers that combination will not
> work but this can be supported as well after some rework on the DPU side.
> 
> In addition, SST was re-validated with all these changes to ensure there
> were no regressions.
> 
> This patch series was made on top of:
> 
> [1] : https://patchwork.freedesktop.org/series/151522/ (v5 to fix up HPD)
> 
> Overall, the patch series has been organized in the following way:
> 
> 1) First set are a couple of fixes made while debugging MST but applicable
> to SST as well so go ahead of everything else
> 2) Prepare the DP driver to get ready to handle multiple streams. This is the bulk
> of the work as current DP driver design had to be adjusted to make this happen.
> 3) Finally, new files to handle MST related operations
> 
> Note:
> Validation for this series has so far been done on the latest linux-next
> on LeMans, covering both FB console and Weston.
> 
> Broader validation, including additional Type-C DP use cases, is still
> in progress and may lead to some follow-up adjustments in the next
> revision. I wanted to post the current version first to collect early
> feedback on the overall approach.

It's fine to post the current state, thank you. But I'd definitely want
it to be regularly tested with the USB-C attachment.

> 
> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> ---
> Changes in v4:
> - Fixed most comments from V3.
> - Rebase onto HPD refactor V5.
> - Fixed casing/formatting issues, for example: “mst”.
> - Drop .mode_set() and set_mode in .atomic_enable().
> - Rewrite commit messages that are unclear.
> - Use the same API for MST link and SST link writes.
> - Use the new drm_dp_dpcd_read_byte() / drm_dp_dpcd_write_byte() interfaces.
> - Remove some unnecessary payload fields from the MST bridge.
> - Remove some defensive NULL pointer checks.
> - Reworked the patch order to make the series easier to follow.
> - Add support for more platforms.
> - Link to v3: https://lore.kernel.org/r/20250825-msm-dp-mst-v3-0-01faacfcdedd@oss.qualcomm.com
> 
> Changes in v3: Fixed review comments from Dmitry
> - Fixed lots of comments from series V1/V2.
> - Rebased onto next-20250808.
> - Rebased onto Jessica's HPD-refactor branch.
> - Fixed formatting issues in commit messages under changes.
> - Removed unnecessary one-line wrappers.
> - Relocated MST-related .atomic_check() calls to their appropriate positions.
> - Removed the logic related to slot checking in .mode_valid().
> - Link to v2: https://lore.kernel.org/r/20250609-msm-dp-mst-v2-0-a54d8902a23d@quicinc.com
> 
> Changes in v2: Fixed review comments from Dmitry
> - Rebase on top of next-20250606
> - Add all 4 streams pixel clks support and MST2/MST3 Link clk support
> - Address the formatting issues mentioned in the review comments
> - Drop the cache of msm_dp_panel->drm_edid cached
> - Remove the one-line wrapper funtion and redundant conditional check
> - Fixed the commit messgae descriptions of some patches
> - Reordered the patches and renamed some functions and variables
> - Link to v1: https://lore.kernel.org/all/20241205-dp_mst-v1-0-f
> 8618d42a99a@quicinc.com/
> 
> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> 
> ---
> Abhinav Kumar (26):
>       drm/msm/dp: break up dp_display_enable into two parts
>       drm/msm/dp: re-arrange dp_display_disable() into functional parts
>       drm/msm/dp: allow dp_ctrl stream APIs to use any panel passed to it
>       drm/msm/dp: split dp_ctrl_off() into stream and link parts
>       drm/msm/dp: make bridge helpers use dp_display to allow re-use
>       drm/msm/dp: separate dp_display_prepare() into its own API
>       drm/msm/dp: introduce stream_id for each DP panel
>       drm/msm/dp: introduce max_streams for DP controller MST support
>       drm/msm/dp: Add support for programming p1/p2/p3 register blocks
>       drm/msm/dp: use stream_id to change offsets in dp_catalog
>       drm/msm/dp: add support to send ACT packets for MST
>       drm/msm/dp: Add support to enable MST in mainlink control
>       drm/msm/dp: no need to update tu calculation for mst
>       drm/msm/dp: Add support for MST channel slot allocation
>       drm/msm/dp: Add support for sending VCPF packets in DP controller
>       drm/msm/dp: Always program MST_FIFO_CONSTANT_FILL for MST use cases
>       drm/msm/dp: abstract out the dp_display stream helpers to accept a panel
>       drm/msm/dp: replace power_on with active_stream_cnt for dp_display
>       drm/msm/dp: Mark the SST bridge disconnected when mst is active
>       drm/msm/dp: add an API to initialize MST on sink side
>       drm/msm/dp: add dp_display_get_panel() to initialize DP panel
>       drm/msm/dp: initialize dp_mst module for each DP MST controller
>       drm/msm/dp: add dp_mst_drm to manage DP MST bridge operations
>       drm/msm/dp: add connector abstraction for DP MST
>       drm/msm/dp: add HPD callback for dp MST
>       drm/msm/dpu: use msm_dp_get_mst_intf_id() to get the intf id
> 
> Yongxing Mou (13):
>       drm/msm/dp: remove cached drm_edid from panel
>       drm/msm/dp: drop deprecated .mode_set() and use .atomic_enable
>       drm/msm/dp: splite msm_dp_ctrl_config_ctrl() into link parts and stream parts
>       drm/msm/dp: extract MISC1_MISC0 configuration into a separate function
>       drm/msm/dp: split link setup from source params
>       drm/msm/dp: move the pixel clock control to its own API
>       drm/msm/dp: Add catalog support for 3rd/4th stream MST
>       drm/msm/dp: simplify link and clock disable sequence
>       drm/msm/dp: pass panel to display enable/disable helpers
>       drm/msm/dp: add prepared to manage link-level operations
>       drm/msm/dpu: initialize encoders per stream for DP MST
>       drm/msm/dp: wire MST helpers into atomic check and commit paths
>       drm/msm/dp: Add MST stream support for supported DP controllers
> 
>  drivers/gpu/drm/msm/Makefile                |   3 +-
>  drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c |  20 +-
>  drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h |   2 +
>  drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c     |  30 +-
>  drivers/gpu/drm/msm/dp/dp_audio.c           |   2 +-
>  drivers/gpu/drm/msm/dp/dp_ctrl.c            | 822 +++++++++++++++++++++-------
>  drivers/gpu/drm/msm/dp/dp_ctrl.h            |  24 +-
>  drivers/gpu/drm/msm/dp/dp_display.c         | 598 ++++++++++++++------
>  drivers/gpu/drm/msm/dp/dp_display.h         |  31 +-
>  drivers/gpu/drm/msm/dp/dp_drm.c             |  43 +-
>  drivers/gpu/drm/msm/dp/dp_drm.h             |  12 -
>  drivers/gpu/drm/msm/dp/dp_mst_drm.c         | 795 +++++++++++++++++++++++++++
>  drivers/gpu/drm/msm/dp/dp_mst_drm.h         |  14 +
>  drivers/gpu/drm/msm/dp/dp_panel.c           | 315 +++++++----
>  drivers/gpu/drm/msm/dp/dp_panel.h           |  32 +-
>  drivers/gpu/drm/msm/dp/dp_reg.h             |  48 +-
>  drivers/gpu/drm/msm/msm_atomic.c            |   9 +-
>  drivers/gpu/drm/msm/msm_drv.h               |  18 +
>  drivers/gpu/drm/msm/msm_kms.c               |   2 +
>  19 files changed, 2300 insertions(+), 520 deletions(-)
> ---
> base-commit: 3ef088b0c5772a6f75634e54aa34f5fc0a2c041c
> change-id: 20260410-msm-dp-mst-35130b6e8b84
> prerequisite-message-id: <20260305-mdss_catalog-v5-0-06678ac39ac7@oss.qualcomm.com>
> prerequisite-patch-id: 8b3f7f40025e7a10c4646435e9cfec4f9e275871
> prerequisite-patch-id: 547db98962f20218380e966b976aede824ff8433
> prerequisite-message-id: <20260314-hpd-refactor-v5-0-0c8450737d64@oss.qualcomm.com>
> prerequisite-patch-id: 1867c344ef6ead1034523ba65d2640f9ad0606cd
> prerequisite-patch-id: a58ebaf429385c622869c83e83ce7ffdfe9ea27e
> prerequisite-patch-id: d0f570e57559248ba6ca733f96fdb02af29f3055
> prerequisite-patch-id: 44d390f5319068ad534c4be698dd8dba99c0bfd1
> prerequisite-patch-id: 85438690573583cf62065f43531dbb4e221e9dd0
> prerequisite-patch-id: b37db0f0b10f16ed45ab056aa87f2275bb02df94
> prerequisite-patch-id: dcccd204ee8a979328719d41334453474bcfdf98
> prerequisite-patch-id: db07c3aa80a597c91ae2329bc677bfd72b63716a
> prerequisite-patch-id: 9778cc1ab60a0870a74d58ff220bb01011fdf1c0
> prerequisite-patch-id: 95692a605647e51bdaf8d5b2e61635a6978121f0
> 
> Best regards,
> -- 
> Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> 

-- 
With best wishes
Dmitry
