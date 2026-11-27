Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C4E606A31E
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 12:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=E+Wy2cEE;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=bHrcnmFG
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 20C1410E516;
	Fri, 27 Nov 2026 12:06:44 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6258510E59C
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 12:06:33 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ARAp0Sv1961809
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 12:06:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=FELi3FLt/Pi/OkzOMRJ8+hRR
 lAJ733i1PeWjERVJCog=; b=E+Wy2cEEGp8cp9ec8ULDVVwt6zaET6LAMFhORq3/
 yfd67peeBurtHEtZgo52TiKmrOvoe6BVCBInWBPoKwApmXdisvXsEXYYW6rq/jMd
 kx6KQKyWZnD02QTRElFZgRnP5ubMkMFDepJawLPNrPemza5H4qunjxIvs8J/59Y3
 bTftW9LSA4ftxYqXvm3c74OQ1dXzYWD+RX6Wn7Yje1lCIjZX3rSvdpkRArqYump4
 Q1qnk5H6VHzoVwyM79CYICdIpcoQRlH3QrSWDtEsRfqnV7qX+nAnvC6olcMMJyCN
 JNe/jbVgU7HxNAf1lB0u4HwNHavdJFz5g7BQF42HHSvS8g==
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j6u4htx3u-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 12:06:32 +0000 (GMT)
Received: by mail-vk1-f197.google.com with SMTP id
 71dfb90a1353d-5eab0467c89so8466434e0c.2
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 04:06:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795781191; x=1796385991;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=FELi3FLt/Pi/OkzOMRJ8+hRRlAJ733i1PeWjERVJCog=;
 b=bHrcnmFGN3m03CSXxGBQnvBUTUVfvzeErRMPZpi/TMc8273kXs251qdbvI8zyy/7NN
 gxu8GoMaa6CR9KN3vicTuSx+ra5MPIVbo/W3mId8RRaQcsiiE9BbsR4T0iLBMn1Xwjer
 zjEKfE0OFoLln5ZKMba4l2XG8fDJL4Hiu2j741qDttkXhrMBgf3Hk3bk9tpCbBy6afl8
 0+aMFRKn+c1FrLru+BHgkr1hpGq+AHiTmp7wgJMVfGxZTxAmJsqEXWPqp4rQJysZNHOq
 21L9kmP3+fKwYYgxf/Bfrpuz5tk5MzY/zIvrXTpu/gS4FbS/FNIFCgQk/eMV+eX9Xp/S
 0PUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795781191; x=1796385991;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FELi3FLt/Pi/OkzOMRJ8+hRRlAJ733i1PeWjERVJCog=;
 b=IG38MEfBwa6PYaICG9WGZZ5hmkM4nR82tXXdDhyEGccwc4sxevUeE52i2nVCm345T8
 42qsryK2ApX2P8ATg1tT0g1PrFOmgpW9Q72G2k/DTUHX0c5Bx4NISIjCmSuyhhXZhrfk
 Uv429glu7vQ/eed/1dEfIz74ZCUTQRqnQiuks7NSz/v6TbReKt6Ktr5tIVk5taMZz31g
 a16DoL+7vW+409BuMnLUFDLM3BaxdcY9tLBDVmeyYpfkSTGn7lZxcuJrWpnJ8rLZCts8
 m6tLU+3D1q2Vr7ADPCrsvBudVm6t2YGW1SQ1wg3oNIK6xEPqoe3Y+bnWB3e+guDiQzaD
 w0mw==
X-Forwarded-Encrypted: i=1;
 AL+hErHf538iABepHQ7KCI0md3LII1MCtdlHX5VVKQ590B5sF2qRiuFtY0vjT5wGGpOaGe+nuHzvlybZUF4=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8/Nao0udBqlRoEJowGWD0RlAh53NlfoztRawLeubvfSNT7QvbD
 UlfBKWccTlKCBYgnXDmR4VAtehSGp3dTAubXI6W3EwaO1AI7RFvrBlJWyGIjmzFki5peXTRL+3o
 LqWNII0eBZD0Qj1uyRnpLD0h+oioxB7vLNaEkMKBP39mejI2aB5MHU5YzNWCl4aYt/VRGJ4Y=
X-Gm-Gg: AZFdTZcjjhDUyGUUcJGxD8ieKdx+Uo6/RVR6HTwSQ8KxitW/6RPyNW3crSYUPrrpxka
 jDktrnnDgWG7rdFgrTIJ9AKky1JxGsfdZvUwLPEZoNqqEZ/R3K0yCTBJcL9FuzERhDOY+Cr9cT1
 wRdtzvtVTkD5K2fAF7dpk4WKGR9rCZ5f8CqMN0wkqofYdi6qpLXom77zzx5lZybdazyfORGIFQz
 xJSV0lLTdCwyzKsGdP5e7j3tmuKlUsg/F922ahEYa6RVQvI6PSxvn88x5lq1EqsA+KfyUaIJjpD
 wpPGL0qA0cc9EbC0vzvL5LutSleq/Oxw+YQmDlWYvi/3bgSx2pWAskWdF9DKKqW4L7T7tN3IBuN
 bIRgCdL+IIp37GhoDZP3XGtpIUwz/xfMVqB4OL6NPGggKCEftTIWe9Zxd/5ucQRvh/8oM5vZvHo
 bFrkw4CWKhJaKTap3yXVIgKgcL504lz31gk2U10nZOTJQICZmZ2WE+ZwbI6F6LSw==
X-Received: by 2002:a05:6122:32c8:b0:5eb:7686:48f5 with SMTP id
 71dfb90a1353d-5ee8af0af4bmr14128024e0c.8.1795781190779; 
 Fri, 27 Nov 2026 04:06:30 -0800 (PST)
X-Received: by 2002:a05:6122:32c8:b0:5eb:7686:48f5 with SMTP id
 71dfb90a1353d-5ee8af0af4bmr14127954e0c.8.1795781190044; 
 Fri, 27 Nov 2026 04:06:30 -0800 (PST)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5c1bd04451csm5860852e87.59.2026.11.27.04.06.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 04:06:28 -0800 (PST)
Date: Fri, 27 Nov 2026 14:06:27 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Michael Burch <me@michaelburch.net>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jun Nie <jun.nie@linaro.org>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] drm/msm/dpu: count the pending frame before kicking
 it off
Message-ID: <kcjghu2lpoijzanqtdvd3zid6g4onyesvsouqnehepo6q7liws@af36abycxzzh>
References: <20261013172703.12273-1-me@michaelburch.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261013172703.12273-1-me@michaelburch.net>
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDA0OCBTYWx0ZWRfX90Dx6pGofdW0
 Sd9zJrQ2e0Tp0/VUvVEJC/0pZEmZPezP8+lZiS20bvwnS08xf+YUzNqcfPAC0n8yxmlG677oC6W
 tJowgMLq2ToIgkLlSnQBgiYaN/c/TAg=
X-Proofpoint-GUID: aEPdOuyE1qCvTXZAnxjTwFZGz1ZAIL4l
X-Proofpoint-ORIG-GUID: aEPdOuyE1qCvTXZAnxjTwFZGz1ZAIL4l
X-Authority-Analysis: v=2.4 cv=M9fYuCws c=1 sm=1 tr=0 ts=6b097248 cx=c_pps
 a=JIY1xp/sjQ9K5JH4t62bdg==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=VwQbUJbxAAAA:8
 a=OZ7Xlw-yAAAA:8 a=EUspDBNiAAAA:8 a=o7I13pbtrd0snOxpb2YA:9 a=CjuIK1q_8ugA:10
 a=tNoRWFLymzeba-QzToBc:22 a=qwMvOfr3u-Fs83Rmfh-C:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDA0OCBTYWx0ZWRfX8a1vabJT2B2K
 42+2ICaIHg3HHm1Wm9qnTBBU7y9BuIsL+gWZg+mVPg2iBpL2/91Sa4CredElonScAyDTYthLEPh
 JYCszWRCfuHQTwupjsll5piD4vUEjNEbCIweltbYUfFEtnvvp9rDxzYhk+g61C8mX1yQ/tPKy40
 x5FbtH+/2ytBe8mI+4FdnyZGsiifXgbwJ57wzAiI5/eqtzfDwPOSi6AzoUZKMCx3o80aXIxPNWw
 TlPVj8PFXeD3/peJl9EqzS0aNnCsc2y/K9x5TzuOTecKS5CbbWuPrQNDysr/k9qzrwmM3FDasZS
 LfHrV5gvAQO3W3woWSJKF2r8emKXXM0NVvTfhwa7+lQPVn0wxs5TjDDaNQTcKuvOTiAqI/roZE7
 m31PN9HecxaF0D4P/jkjfRz0J/l5qIZZVfHpMbEhdZ0B1uOrIOhNnahNPxAcX9kDZ0Wv2KePGxx
 /gvs3ZJyZceSgGTGzSg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_02,2026-11-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 impostorscore=0 suspectscore=0 malwarescore=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611270048
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Oct 13, 2026 at 12:27:00PM -0500, Michael Burch wrote:
> dpu_crtc_commit_kickoff() increments frame_pending only after
> dpu_encoder_kickoff() has sent the frame to the hardware. If the frame
> completes before the increment, dpu_crtc_frame_event_work() sees
> frame_pending == 0 and ignores the frame-done event. The increment that
> follows is never matched, so the count stays one too high until
> dpu_crtc_disable() resets it.
> 
> With frame_pending stuck at 1 or more:
> 
> - dpu_encoder_resource_control(FRAME_DONE) sees a pending count above 1
>   on every frame and never queues delayed_off_work. A video-mode encoder
>   therefore never reaches ENTER_IDLE and keeps its vsync interrupt
>   registered for as long as the display is on.
> - dpu_crtc_frame_event_work() never sees the count drop to zero, so
>   dpu_core_perf_crtc_release_bw() is never called.
> 
> On an X1E80100 laptop with a 120 Hz eDP panel this left the vsync
> interrupt firing 120 times a second on an idle desktop: 14,407 vblank
> callbacks against 21 commits in 120 s, with no vblank events requested
> by userspace. Every frame-done took the frame_event_more_pending path
> (591 of 591 in one trace) and the encoder never entered idle. After a
> suspend cycle reset the count, the same desktop showed 3 commits, 3
> frame_event_done, 3 encoder idle transitions and 25 MDSS interrupts in
> 60 s.
> 
> Until commit ad06972d5365 ("drm/msm/dpu: Reorder encoder kickoff for
> CWB") the increment came before the kickoff. Move it back: count the
> frame in each kickoff path just before its encoders are kicked off. A
> clone-mode commit that fails its encoder lookup is then never counted.
> 
> Fixes: ad06972d5365 ("drm/msm/dpu: Reorder encoder kickoff for CWB")
> Cc: stable@vger.kernel.org
> Assisted-by: Copilot:claude-opus-5.5
> Signed-off-by: Michael Burch <me@michaelburch.net>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
