Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE57606A319
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 17:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=G+I843v4;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=CYj406wj
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD55F10E2F1;
	Wed, 21 Oct 2026 17:02:33 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D18D10E331
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 17:02:23 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69LG4CFi2149280
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 17:02:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=JO67+OIcXeQPf/uwJoTBgKLw
 E1a0IHP5ujFdDtZzXDw=; b=G+I843v43+HBH4lmw/pome1OWWsLsu7SuBeUV0K7
 bE49B0CfEACYI0pGiwkDiOWIWiDss/UrloBVPIF+lhBI4IRM6wQ9senMfVLkdFeY
 8l2aYNLzJy0uC4ScWL7UX5j92QbL5cMVXrsrR/xcN/akyrvP4nRbPIaYdbvODqtY
 8TQgDnMreOPJGzC2lgKh6CTwrg7ePWrFyQloBLNcPe9nKgb6kVU9VxHzMCmqCYuW
 12EjWCprv9qTU2vDwcBCKvqNjIsQytC6ExckhyxBskv3zmCKqq6OuNb0n2AdgS2V
 tibC+v5z8Ar6OCgq3vVvdJbpE9N+j9KkbT95DlnXhmacaA==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hf0ke0979-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 17:02:22 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id
 ada2fe7eead31-7c15deb3794so114091137.1
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 10:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792602141; x=1793206941;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=JO67+OIcXeQPf/uwJoTBgKLwE1a0IHP5ujFdDtZzXDw=;
 b=CYj406wjDyB+DkZC3eyADx6u8JasxPbhqPqKwa47+9MQu1awQcq8Hy9B3MZGAcUHUg
 YH/Lac45UKsjnKjhWJ/YTnKkh2DDfh0ywfAM2l7ci282Op0lAkCcXlG4GIjo817GX7Sk
 DdqByaEDARwPQFmxEHnGxiN/JIudgm0TlVHgbrueBTuGCh4hJsmM1orehh8Ga4wBbi2Y
 JTLDKuwDxNQKfKIJh5qWHlqcr/PsVyGu8/GRtGmB8HwNgbS7ZbEppaxiAfygfNvWiJw3
 yeFggNNVuESErZNMub2YcTZXZ7q5NQ5Ck3F0nQqrg6Avx7doY1omlImHWHJnfc/biUtN
 KiNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792602141; x=1793206941;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=JO67+OIcXeQPf/uwJoTBgKLwE1a0IHP5ujFdDtZzXDw=;
 b=MS9274RguHCFXL1Eu1C4kIFGVEftSA+Q/OPRyuey2Pl8AorHL8u4pYswoLJ8i+dxkV
 GsI0+YiaSz/aGEJQhjWSc4HMNU4mUqhhKPFc2w/4vv/yPp+TIofJH1YbzQ9ILbQRq/in
 EDgyVfnQmj3Qi4F3G0kf6eoBhdoPU6HgKUMq52c8f8bWXAPTz96mt1FvOnpaSwv75kzi
 fm7aAVN45WNEZAko/Wo6Jq5XUF1SRBDFU65Pli7JhGdGdqcgZ/qx6fVPjyIQOdWR+n55
 cMSHWiiR658rrB8tYboN+uu84Zh0q1pFglW6b09df/AvT37oxllMflN16qIAhDW2Bawh
 udQw==
X-Forwarded-Encrypted: i=1;
 AKwUvBz5oyVnKrDPzYqnNgQEvzL/RY97E8SgoBt7hwhoNrJ3ZCuCuC/r3UkwYxsHhY7OjCnRHbZDK1QIEoU=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKo/8JV8eTxogsllAooLTF7UWGw4+VTGuUo4RVzQrIdwwSjfuZS
 SJ1jQfBOI1bzmkVM38IIeVZsvO1XFDziFJ+QCrGBTQfQK29ge/EM8oMAN7UJQtodSSdvyF2fwl1
 1A1OLT300e8UTthd1z/ypwQB0snMW5LKyuY3PlOg8t0ro9kOP/1r67qeIB7/brNFPeUkrJFc=
X-Gm-Gg: AYBFou0IUggaapPfung+QnXdib+4u5or8cGhmse1+5e/TMaj1dvHMeicmrfaVEcI/U1
 LYni7ViG2YgG8PygETDZnNmAlyVkXmmNxlzF+2jv4N1+AwK0o1OZdoJq1VN3CddQly3j3WtO+ii
 +DL9SlSdEfHpNeyjfJW7n954Cv3b2gptxFeV4VDGSfmWiKc8TX5oaKLnBpXToLT0be1VJkoCBfS
 Kn9HKL0eFath1pO5OFJcQJ++Eh0pZtJhx9ad7pH9KFQuYLGwBEQ8nbugYRtoGwH9BeQLOcE2Lta
 9gTp9IOIdOk1Fa1kjN/CQM2lAYzjewey+O9gJp1prcw7MVpM5UnCcJ+oqtKmXi1AcnwFk0UT2a/
 VvDtlM8vZKvdZNJOOvyUBgOn9acVwjbxNQpia++RF4t9ldLb/1XD6ILcv+tEC7nfg+E1lnTKh+k
 UrRPq6Q9X1dVwV
X-Received: by 2002:a05:6102:3fa2:b0:7cc:56a:58e0 with SMTP id
 ada2fe7eead31-7cc926b3be7mr876296137.21.1792602141437; 
 Wed, 21 Oct 2026 10:02:21 -0700 (PDT)
X-Received: by 2002:a05:6102:3fa2:b0:7cc:56a:58e0 with SMTP id
 ada2fe7eead31-7cc926b3be7mr876172137.21.1792602140671; 
 Wed, 21 Oct 2026 10:02:20 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5bfa28347b8sm471519e87.9.2026.10.21.10.02.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 10:02:17 -0700 (PDT)
Date: Wed, 21 Oct 2026 20:02:15 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Fabricio Akio <fabricioakio@gmail.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Paul Sajna <sajattack@postmarketos.org>
Subject: Re: [PATCH v2 1/3] drm/msm/a5xx: Reset the GPU when resuming it
Message-ID: <qasf66vyv2t56x3o7bipzdvgrlglartfxqxm5ezstnwmlczfur@yi7cdxxqvwut>
References: <20261019-a5xx-gpu-pm-v2-0-457aafbb28da@gmail.com>
 <20261019-a5xx-gpu-pm-v2-1-457aafbb28da@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261019-a5xx-gpu-pm-v2-1-457aafbb28da@gmail.com>
X-Proofpoint-GUID: ZuldEskK9INSCBsRF3oFX0memTt3snil
X-Proofpoint-ORIG-GUID: ZuldEskK9INSCBsRF3oFX0memTt3snil
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA2NyBTYWx0ZWRfX1g5zkLO3ngtv
 SXmzxWdnCwftrOYPoFr+WZLMbbkzUOx+PRGh2mq//iqdzhDiz1tppH+KO620ZH1mK6GgfEddU87
 OIJJ5XDrZsyrCxWgyNYn9v6nlxhAacg=
X-Authority-Analysis: v=2.4 cv=KOzPn1Fo c=1 sm=1 tr=0 ts=6ad8f01e cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=VwQbUJbxAAAA:8
 a=Gbw9aFdXAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=0XkAg80coZZ_RUxBgWAA:9
 a=CjuIK1q_8ugA:10 a=-aSRE8QhW-JAV6biHavz:22 a=9vIz8raoGPyDa4jBFAYH:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA2NyBTYWx0ZWRfXzxqQy/YxMOwf
 fra7PPrPADSns9m81TlouL0Y/bvW8//C0v3rHsFQvjSIOICXWEiyU3DlBk+csgT97PV537zAFfq
 fAGiFmulpQho66YJ12tF524nen/q1cedaKMTEwBCWeZ2/EkRyWQtsoJh8fltq83oRzw7AiT9LKQ
 Abz1By5C64QnFcJDG4ptSaFn7SLay9J7JIYPFTu3fTRIJX2oUD4ZfXhLSNUIQcgIP+5XeQUNgpF
 BxfRIhXxnGOwKP/hcjimDPik1aWPN1h8vUvrNhtvxgIrysdtNAAgJhxKXDeJyyzPmKXXqi82xlV
 R/srT3jzkEQ9MTSKQ+p5bzax6UsGr85Ldqst3VEtj8kTzM0zrrxW4zboHNOpJod8jF+WiHUlrEC
 ObIC+dfgalDa4qJEOB+9/ephMofEPFqQM3TdLX5h6LiqIbuDJtmFzav7mSVcHktj2PlHukCqZY/
 9yLbEra5NPrGnO7i90w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-21_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 impostorscore=0 suspectscore=0 bulkscore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 malwarescore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610210067
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Oct 19, 2026 at 11:05:08PM -0300, Fabricio Akio wrote:
> On SDM630, SDM660 and MSM8998 the GPU's GX power domain belongs to its
> SMMU, not to the GPU, so GX switches off only once the SMMU suspends as
> well. A GPU resumed with GX still on keeps its state, and the CP keeps
> its ringbuffer read pointer. a5xx_hw_init() then rewinds the ringbuffer
> and writes CP_ME_INIT at its start, while the CP goes on from its old
> position, executes stale ringbuffer contents and hangs:
> 
>   timeout waiting to drain ringbuffer 0 rptr/wptr = 23/C
> 
> Soft reset the GPU in a5xx_pm_resume() once it is powered, so that
> every resume starts from the reset state. The downstream driver resets
> only when it finds the GPU's power left on; resetting a GPU that was
> powered off changes nothing, and on A508 the reset takes about 2 us of
> a resume of about 1.5 ms, so do it every time.
> 
> The reset also clears the busy counter, which msm_gpu_pm_resume() has
> just sampled as devfreq's baseline. Take the baseline again after the
> reset, or the next devfreq poll subtracts the old count from the new
> one, wraps, and sets the GPU to its top frequency.
> 
> Signed-off-by: Fabricio Akio <fabricioakio@gmail.com>
> ---
> Changes in v2:
> - Take devfreq's busy-cycle baseline again after the reset, which
>   clears the busy counter (Sashiko)
> 
> Tested on A508 only; the reset runs on every A5xx.
> 
> A stall with the same signature, the CP's read pointer past the write
> pointer just after CP_ME_INIT, was reported on an A509:
> https://lore.kernel.org/linux-arm-msm/20260308-adreno-ringbuffer-drain-timeout-recovery-v1-1-985a33faf108@postmarketos.org/
> This may be the root cause of the A509 stall Paul Sajna reported there.
> ---
>  drivers/gpu/drm/msm/adreno/a5xx_gpu.c | 15 +++++++++++++++
>  drivers/gpu/drm/msm/msm_gpu.h         |  1 +
>  drivers/gpu/drm/msm/msm_gpu_devfreq.c | 17 +++++++++++++++++
>  3 files changed, 33 insertions(+)
> 

Tested-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
