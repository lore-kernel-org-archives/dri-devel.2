Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE035CD8C8E
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 07:44:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D6B9D10EE6C;
	Mon,  8 Jun 2026 07:44:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="bxyPT2Qv";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="USrwVTcr";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C92FC10EE5C
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 07:44:00 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6586Ot8o2384454
 for <dri-devel@lists.freedesktop.org>; Mon, 8 Jun 2026 07:44:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Ll9jicp1T8nD2iVAfwGQTwpackBft8jmAmcVwn6yJEI=; b=bxyPT2Qvf1aF34RR
 7mgHLg0xLIrXsp3fDymEKgTA+DE/vVP+Sf7AP+9vN84HHYI5p0A1YZe7g8FT9PD8
 RGWPFecrMcevs7Hi6Re3huKV4QX+KV9LXihysgGu67JEeq7nzgRC+3CtgtPq8QcI
 pi1YOy5YfxZ5mCXSFLm634EG0O+/VUadBkO+3Jcpleu8F2OVdbeaQW8y0z5StCo1
 nbv3V/S4Lv/Qcfky3aZwQjBnlkL1k3LdjYUMKRl7Xr4s7tXMdMy5y2M7yrkKX4L/
 0STpFPRmeHwJxNKNvjHvrvTTPv/aOZ+4d0XVFdFS294I2FWwBQBa+/CrQBdDFwnx
 VAPS5w==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4embs1efyg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 08 Jun 2026 07:44:00 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-9156dc90fdaso116572185a.0
 for <dri-devel@lists.freedesktop.org>; Mon, 08 Jun 2026 00:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780904639; x=1781509439;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ll9jicp1T8nD2iVAfwGQTwpackBft8jmAmcVwn6yJEI=;
 b=USrwVTcrCwDKn+r1lCgbb1VQGc74K3QCNJ2uyIShSBzKsJmWiEHulw9TddkvEvkah1
 8dCndKOUSN+azx/s1LAe/de8z3WaRZxTGyEinznceptluLqsWcKB86f+el3oJ7oo0K6r
 M8CwrIzDNaCQLbLm0rGj7ezNkL0Q8+Fd43pSr25pnlbt1RDkOPL7D2mhZsVvZSuVWt79
 iwBMqIPq3ZKc0Po5R/9xI29/s4cCSEyWw0GgY1braMVHtY2n6J+e61wAvYi+yrIx20KO
 fHjvypK2TcVW6goJAMCB8d1tNp4T4GnVlN+fy8+0bLEz0JiXN9HtuiWcJYnqueUCv3Jc
 lxfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780904639; x=1781509439;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ll9jicp1T8nD2iVAfwGQTwpackBft8jmAmcVwn6yJEI=;
 b=j1oiDW27FmNvoYRMy7p8h0zZ+ALEi/IR/XTBV+wZSJcJ8qBHRzzQoQJf24tJCC6dP3
 LXW+FHsLf2ytpb7NsdJwIdMw0tOa5eJ78qgO+aOxI9mLj+N+Zvc+ebahPn2VRMCnCyQv
 2avQxH2SXbuERdAdbPl82wYwxtTdgv/zsbY3b0VOqrPBBUIeknktoO6ixGMD9/9tgBGo
 +YfvtHI2g7T7o1uQ4CLxNCPScM00FeM2hjIn4mIjwGNWoi2oE3/TC5Ws7dZeWnkM6N4t
 lQtxBe9TSiV9NXY27qX3MmDXV4FzCIWkJt3k9LgFcPlMsO9DSbiP2prULPWz9jeZzYaK
 qAoA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+DKxujl3o1Ad0ji/ReMU24EwDcYmrKiUK5L53vg0gO6pZih9C21kjp7CpTqZxDQAldejk0oiZDkH0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzvFtTcMhxz4JMFPhb69Fsi1iV5kSPXIdC7XmpR+4mFw7kiE9Sf
 504Fb7pLvMxbu9SpasQcrLKvpoZ6Ma8RrpiEOp+nry6lxdF8KqotoyxV5aRyGSFVXXKseKO8ux+
 XozerG102uZe2n72+sXBZxNK2yzo4rU6MWMmsP4ufmQ9Iyd+QPa229fe8hYTJzx5cY0w+uyk=
X-Gm-Gg: Acq92OGPBx/xyog4Nj2Jgfeus0IIG0z3PdKW5nNAYoCaC2NV6tFhvlakUnL3rH/lwzV
 MQQTwuY04GinHlGr4iQu7kuPBYbhytv+2iw+ZR0s07x386fO7qFbyIHnqdssAXAy7EMDjAscXVt
 HG7X5FomAKgdXY0MtKcdipxui5CcM81HaJSMiDL4G66qRE+2KliGwUrQ873AmpdhNqDaL65+56r
 piionnV6TLnHkKwgxaBbqV0HdtN+VXSzX6seAw2U8TkKbATEuxNX00pcYdjgbHy1hYYkta5CPlo
 e3v6SfPoXHgx9AfchWBCOpgajASDfbbL++uWQSg+UE3SZF3jhXOE6aBglimaPgUYt3CqloTOZHt
 0iZqgn0FEF81a0SvzCmRpZIvqQXgnVuPqlFZwWG1VL9x7dsCZXffl5yyI
X-Received: by 2002:a05:620a:4145:b0:8f1:9e59:2208 with SMTP id
 af79cd13be357-915a9d5af7fmr1387110385a.4.1780904639208; 
 Mon, 08 Jun 2026 00:43:59 -0700 (PDT)
X-Received: by 2002:a05:620a:4145:b0:8f1:9e59:2208 with SMTP id
 af79cd13be357-915a9d5af7fmr1387108385a.4.1780904638766; 
 Mon, 08 Jun 2026 00:43:58 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-68e64c2f1bbsm6686090a12.2.2026.06.08.00.43.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Jun 2026 00:43:58 -0700 (PDT)
Message-ID: <d494a62a-2d4b-4406-99f8-cf8775ea4706@oss.qualcomm.com>
Date: Mon, 8 Jun 2026 09:43:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 07/15] drm/msm/dp: move the pixel clock control to its
 own API
To: Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Abhinav Kumar <quic_abhinavk@quicinc.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
References: <20260602-dp_mstclean-v6-0-2c17ff40a9b2@oss.qualcomm.com>
 <20260602-dp_mstclean-v6-7-2c17ff40a9b2@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260602-dp_mstclean-v6-7-2c17ff40a9b2@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDA3MCBTYWx0ZWRfX9jXYBXb0IfJC
 V4SwAVMevTtJWEYKcyQDuPep1F8UgTPBuvWnALGZZtSLNsKjiR9CXvkmwQd5vB9Ll8dNic97kLf
 1pzSR9kxbqew9FdLsxyqBk4nwDszI1r5Xom/rMomZxgX6mcdHtd2ptVSEDVikxUP9JkH3lnc89F
 SMA7KjuDYciY23sqyxsIbAyzlJ1KmqWR+zo2BKHiQAGBCjJ7U1mQ97+dEIkzMkm6Q+zXnVcHYaF
 VwMzPsefoyDdW4kmVDS+T93tq6IhB1ZCPMCFZQ8B2EK+Wr6/+CFxvWv0uH7JUJYNWuKFcUU153q
 AdUfzzGFMYDhl1kmea7VVJyCBolY8GT+IL7w9lyBT8a89qn7jduTjpr/5mcPTC2BMozn7bMfibg
 kqEvcDE4GxrvXzLEtOJZXOqdiU+H8NZ88D/GgVUx17ALVb/gjGEJ4nDTWLGCx0PcL14J9vX/lxX
 Xy0WtYUt99UjO8q45ig==
X-Authority-Analysis: v=2.4 cv=CeY4Irrl c=1 sm=1 tr=0 ts=6a2672c0 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=YadZbbKFZxuD_lQ-BoMA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: g_wrW9RLzzo5lk5VM1TqcVF7DV4EIij7
X-Proofpoint-GUID: g_wrW9RLzzo5lk5VM1TqcVF7DV4EIij7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_02,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 spamscore=0 malwarescore=0 phishscore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606080070
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

On 6/2/26 11:11 AM, Yongxing Mou wrote:
> Enable/Disable of DP pixel clock happens in multiple code paths
> leading to code duplication. Move it into individual helpers so that
> the helpers can be called wherever necessary.
> 
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_ctrl.c | 81 +++++++++++++++++++++-------------------
>  1 file changed, 42 insertions(+), 39 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
> index 1c2eccec6ec6..ac0a2c387f03 100644
> --- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
> +++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
> @@ -2171,6 +2171,42 @@ static bool msm_dp_ctrl_send_phy_test_pattern(struct msm_dp_ctrl_private *ctrl)
>  	return success;
>  }
>  
> +static int msm_dp_ctrl_on_pixel_clk(struct msm_dp_ctrl_private *ctrl, unsigned long pixel_rate)
> +{
> +	int ret;
> +
> +	ret = clk_set_rate(ctrl->pixel_clk, pixel_rate * 1000);
> +	if (ret) {
> +		DRM_ERROR("Failed to set pixel clock rate. ret=%d\n", ret);
> +		return ret;
> +	}
> +
> +	if (ctrl->stream_clks_on) {
> +		drm_dbg_dp(ctrl->drm_dev, "pixel clks already enabled\n");

if (WARN_ON_ONCE(ctrl->stream_clks_on))
	return 0;

?

Konrad
