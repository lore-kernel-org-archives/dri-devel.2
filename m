Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C10FACA5FC4
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 02:39:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D61D110E143;
	Thu,  1 Oct 2026 02:39:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ok4GVxs6";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Q2Ipj2CJ";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C60210E143
 for <dri-devel@lists.freedesktop.org>; Thu,  1 Oct 2026 02:39:56 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6910jX9V271291
 for <dri-devel@lists.freedesktop.org>; Thu, 1 Oct 2026 02:39:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=yV+S3P5jvvM8EKpEwldy3Siv
 yc4WzqDSMEhXoGR4RgQ=; b=Ok4GVxs68iJYunI5nhauD3cKd+DxWRTgTtM/HqOe
 /L8l7ACxHEdeJEzjwfMEc+yPFkbYf+W6N8jcm3hEEmBOd2c9yqloq9wjoRWebz+S
 Krcd/U4PCAJaKSsoobkOzLI/ZGti3m9A5BQw1u+vSE11DPebiB8CUCtrg/S5kkTs
 tdgjAEtvlQmJfY+awzNBtsO89oFC2gUUziMo/mHYoOqvN2ZOUBSxBgdD2bx70HD8
 fslJzdps4R+cX2PukniSVGmao/sj274pgDHLSDvn89Qy/TkEzyy1ebCWaii8YxDl
 wojPtJN2a+rZY3yUjRTUVXA6Avj/Wzm8XYlIEh1BZ3NCZQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h17mvsk4g-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 01 Oct 2026 02:39:55 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93c444b438aso1298109385a.2
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 19:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790822395; x=1791427195;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=yV+S3P5jvvM8EKpEwldy3Sivyc4WzqDSMEhXoGR4RgQ=;
 b=Q2Ipj2CJd6gv0XIEzhh2g9znoVBilJ19U46iOOgulI5VhCGVTO2k1Iip3YE4NjE/DY
 jBrBwS7U/hgvz4NunDb4CXwez3wJvqJobAJfPT0G2bFtSwT3otmI4GbGoLG3FqdAOMqC
 s6oYX9YJI+xib2VUKalqYYTrcOdrPRq59OymG4Tu4QOXeNtxHFju6imhUJUy/50aBGAd
 BVX9ftDt6Ud+Tc1S6gpVavVPLH/ZL4hnGcyAsx288qCvJ1wMyJcgyidDyoGVjIxDwchR
 C0Vfk83iPNRpulOVpBU3ZiXe+TOb+/h2+ngXYlvfNi42TdijoPdD4XhsyfcaXvBQ5RY5
 ab3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790822395; x=1791427195;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=yV+S3P5jvvM8EKpEwldy3Sivyc4WzqDSMEhXoGR4RgQ=;
 b=2fYm9Hg20oEDA3rv9c4PMerYTO+eSJfYoA0LV7UAIFMTt1RnCkEuOYjy3P0ZUrpC/A
 hZRknTPqNukv6BLY3fNuu8h9Nf4Ui14cJ6dV8F0wskJok1GeZIoghNsTy4AjEiG5MMKv
 2eFP0yePNDiqHrC8729hDiPN3lREoVrPDLyrf0bnxCNd4PLLOtHoaQdzR86GnyJOADDT
 2gGwDH+HiYGHRwmus/IDNqLoA9rhDt6L+8W5SsPOM4AVknpxVsRVPQHwOJQOaRggH/Lo
 LsCw0DK9rDlAYy5dNYA1R7748k6MxGSm1TDU5/LyRqVORCpDzN72vFmzwRcoUZEBWCwd
 FxFA==
X-Forwarded-Encrypted: i=1;
 AKwUvBy76MHZVQfmXb58uCxdwBY2ZrksD4jd/IV4TIpb8fPqujCSFkqVNQOcAkopCReKCFMlDLSesZ3BM4E=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kSZ80/Pb5RJjrbwhIoR4N3gx7CecLCZEnZdbodaKccW5onmd6d
 su62OpcsmPdDOf8wYEnVu3Ra9//tvmP/zmxrp2aBXTFm/icXquIpnfrG2MJqTMNJgiEaA/SxQtz
 LFvRAjouRmsMKIGDTjBSixjSYtjDyKM51DjtofVWZhFMXuNSc7jmVQ1Gafwvc0sOcytFfYH8=
X-Gm-Gg: AYBFou1VP65MRp3cVQppcdGgxpmPwU/u2qmUAH5upsohuJHBBgH0SF8Nb1Vi2PxGv2o
 Y8bP4WGegqKlFSS8C8e3fqZ8pM4eVitlY3C6SRKX1QXtica62nzLnhR1Xuqyo//jg27annswDAW
 UDGd9s506O9hT3pH/+8IuKGWFv2dzmO70WEAnLAqYGWKATuaq/FrC/NelcPpIGtl5jGAH5FTtWv
 7le/R72l52wmEgnEWK7qD6FH7spN8fqjeuiSUaS8jf7BhtlKLkql1xdDjPNYuRZe2yZdboagATm
 SnGTup0WTevVh0YhDoLd3raCRV2jblyUOpM3MAbm4VMU3gwcFwS5F2U7EElTTFZYONuvA2cVbTc
 n91jo28AXuMYL0J7CgG2P/qY3dSv76XDb5pWrfpCI2eHALeNZL8lLVxjeHx1RbTpXpqRvdhjQPr
 iQo8Y97lfU3vr5
X-Received: by 2002:a05:620a:4056:b0:93c:bdb4:2be7 with SMTP id
 af79cd13be357-93cbdb43333mr28832585a.60.1790822394865; 
 Wed, 30 Sep 2026 19:39:54 -0700 (PDT)
X-Received: by 2002:a05:620a:4056:b0:93c:bdb4:2be7 with SMTP id
 af79cd13be357-93cbdb43333mr28828085a.60.1790822394239; 
 Wed, 30 Sep 2026 19:39:54 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5ba42fb2970sm385438e87.41.2026.09.30.19.39.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 19:39:52 -0700 (PDT)
Date: Thu, 1 Oct 2026 05:39:50 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Joonhoe Kim <26rote@gmail.com>
Cc: robin.clark@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev,
 jesszhan0024@gmail.com, sean@poorly.run, marijn.suijten@somainline.org,
 airlied@gmail.com, simona@ffwll.ch, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/msm/dpu: stop all video interfaces before cleaning
 up a split encoder
Message-ID: <tcpvnconbaogukmtektdvzbmz623txosdpvlmcemmirekzc4pd@jf64s7vwfbvi>
References: <20260929130621.943-1-26rote@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260929130621.943-1-26rote@gmail.com>
X-Proofpoint-ORIG-GUID: SnIAf4-UVoSmGn78EkUqTvY13ExDqQCa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDAxMCBTYWx0ZWRfXy2AukvsKsptz
 xr7dsgYwWX6F1vV/U5NMnYK2x3NViwCRdUH3BUrHdvYKEmcONGmOtHZtxZCp1J+y4I/CTrGbu/5
 DvwEgX67Ta3MtLODeuHHrp/nx7pRQE5WNUjB+JFn/wxEk/1b4ZeGShkhKH8fitFYeG7dURo34ig
 G8AeHAfUExSOfVuQAkVUgJG+hxHKRb6MbuQeqGyepGNyhVkeP7eA30cA/DW/BCR9c+UBMgihC6x
 ozrG8hPDlGByRbjVreWUA5Pc0mIa1438t30P8JqhCU6GB1BB8BQv2ajSNg/c9jsPY4idXehAvBE
 3BFY/TL7ppKbq1FOiKF4nfVguxTlhw5Ug/oXDbcgXaLQUqHacAqDmiieD7N/IJqnpYTl/R7k4+u
 4Nnbx7O4NotpvokAeewexoLRL7sVNa5/yNwy7pmq/TXQWi4Luze2vMvlpRV7rEKqfJu53ptAqaw
 gtB778dqmnUrJpJoYsw==
X-Proofpoint-GUID: SnIAf4-UVoSmGn78EkUqTvY13ExDqQCa
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDAxMCBTYWx0ZWRfX+2Wwg6MOmTXL
 3HS5dQC6YhVsSGFwONsFs1iWtjSJgk8UU7e0j28CzQ7J9aptMDok1CtgHnpakbtnQV9arrke0AQ
 ebXB/XKol5dJjRrpGw4ekPXBaa9K2y8=
X-Authority-Analysis: v=2.4 cv=KuvYSmWN c=1 sm=1 tr=0 ts=6abdc7fb cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=oWT2rLAf9-omjay-2P0A:9 a=CjuIK1q_8ugA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_01,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 spamscore=0 phishscore=0 impostorscore=0
 adultscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610010010
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

On Tue, Sep 29, 2026 at 10:06:21PM +0900, Joonhoe Kim wrote:
> dpu_encoder_virt_atomic_disable() disables the physical encoders one by
> one. For a video-mode master, dpu_encoder_phys_vid_disable() stops its
> timing engine, waits for the frame to finish and then runs
> dpu_encoder_helper_phys_cleanup(), which resets the CTL. With a split
> display (two interfaces driven from one CTL, e.g. bonded DSI) that CTL
> is shared with the slave, whose timing engine is still running at that
> point: the source pipe starts fetching the slave's next frame and is
> left stalled half-way through it (on SM8850, SSPP_CMN_STATUS 0x10030
> with the fetch and unpack counters frozen, where an idle pipe shows
> 0x10003).
> 
> The stall is cleared by a power collapse of the MDSS core GDSC, which
> normally happens between a disable and the next enable, so it goes
> unnoticed. When MDSS stays powered across the disable -- a full modeset
> within one commit, or another runtime-active user of MDSS such as the
> DP controller -- the next enable of the bonded DSI panel scans out
> nothing: the DPU keeps committing frames, the layer mixers produce no
> output (CRC 0), and the panel shows black with the backlight on. A CTL
> reset at enable does not clear it.
> 
> Stop the timing engine of every video interface of the encoder before
> any of them is cleaned up. The master's existing wait for the frame to
> complete then covers both halves.
> 
> Seen on a Lenovo Legion Tab Y700 gen 5 (TB323FU, SM8850) with a bonded
> DSI video-mode panel (CSOT PP8807HB1-1). It reproduces without any
> external display by keeping MDSS runtime-active:
> 
>   echo on > /sys/bus/platform/devices/9800000.display-subsystem/power/control
> 
> then DPMS off and on from the compositor: black 3/3 before this change.
> Every full modeset (e.g. a refresh rate change) went black the same way.
> With this change: DPMS off/on 13/13 and full modesets 4/4 show the
> picture, and an attached DP display is unaffected. Only tested on this
> device.
> 
> Fixes: 22cb02bc96ff ("drm/msm/disp/dpu: reset the datapath after timing engine disable")
> Assisted-by: LLM
> Signed-off-by: Joonhoe Kim <26rote@gmail.com>
> ---
> Saim Shujah's "drm/msm/dpu: clear pending flush state before physical cleanup"
> (https://lore.kernel.org/all/20260826182459.1506522-1-saimzst@gmail.com/)
> alone does not help here: still black 3/3 with only that change.
> 
>  drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c | 32 +++++++++++++++++++++
>  1 file changed, 32 insertions(+)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> index 1f20695f81e3..a14156408126 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> @@ -1380,6 +1380,35 @@ static void dpu_encoder_virt_atomic_enable(struct drm_encoder *drm_enc,
>  	mutex_unlock(&dpu_enc->enc_lock);
>  }
>  
> +/*
> + * Stop the timing engine of every video-mode interface of the encoder before
> + * any of them is cleaned up. With a split display (two interfaces on one CTL,
> + * e.g. bonded DSI) the master's cleanup resets the shared CTL while the
> + * slave's timing engine would still be running; the source pipes then start
> + * fetching the slave's next frame and stall half-way through it. The stall
> + * survives until the MDSS core GDSC is power-collapsed, so when something else
> + * keeps MDSS powered (an active DP controller) the next enable scans out
> + * nothing.
> + */

Please instruct your AI to stop generating the narrative comments which
duplicate commit messages. Otherwise LGTM (please respond to Sashiko
though).

> +static void dpu_encoder_stop_video_timing(struct dpu_encoder_virt *dpu_enc)
> +{
> +	unsigned long lock_flags;
> +	int i;
> +
> +	for (i = 0; i < dpu_enc->num_phys_encs; i++) {
> +		struct dpu_encoder_phys *phys = dpu_enc->phys_encs[i];
> +
> +		if (phys->intf_mode != INTF_MODE_VIDEO || !phys->hw_intf ||
> +		    !phys->hw_intf->ops.enable_timing ||
> +		    phys->enable_state == DPU_ENC_DISABLED)
> +			continue;
> +
> +		spin_lock_irqsave(phys->enc_spinlock, lock_flags);
> +		phys->hw_intf->ops.enable_timing(phys->hw_intf, 0);
> +		spin_unlock_irqrestore(phys->enc_spinlock, lock_flags);
> +	}
> +}
> +
>  static void dpu_encoder_virt_atomic_disable(struct drm_encoder *drm_enc,
>  					struct drm_atomic_commit *state)
>  {

-- 
With best wishes
Dmitry
