Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78E57C88E64
	for <dri-devel@archiver.kernel.org>; Sun, 13 Sep 2026 22:35:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A6D6D10EA4C;
	Sun, 13 Sep 2026 22:35:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="obnVHUOW";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DRjS4I+x";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E161410EA4D
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 22:35:23 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68DK04WK1986787
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 22:35:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 0gGjBGJoSmsokLmdBE5jqddhDUHQavMfrQ56wMdXWYc=; b=obnVHUOWDNizpRcg
 30MDH1Ua9xMoqv2y+sPLzo3kfeLMjoSuNVBxaSxoCeUr7ux7I7WN9mkPDpzBd5+h
 A8CThln6KoJwSLsokbEHOUXmYY3eAHamM+kW3zzF0Z33L8v10Zw7DKmrUAbH9rl0
 RGrTIsAFbNhru6PwUjFuaNI30Uyq859BtyJT5DtXzdz7Bn39zkZTuRP4XJXh9M6M
 4jmtKpIJqueX8G1jsuVSbnGBT2yIaRt6iapo52DjsCvIniVKL1M5yG80Z0udAv/V
 PMEsPcSEyeiRoD8aC1GA+f/cZkUQASnBRPFe+xBTXv3Fcvb1Ryz1x3YtOHFuScpH
 pQr/cg==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gmy9cc7wd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 22:35:22 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id
 a1e0cc1a2514c-982a948acf8so1222875241.2
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 15:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789338922; x=1789943722;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=0gGjBGJoSmsokLmdBE5jqddhDUHQavMfrQ56wMdXWYc=;
 b=DRjS4I+xS3mL3dhoDeavHd0ahHrEa+AxLU2qf1HZUt/zgnaQesfXo76JHK5cqIZpJJ
 bDRv4x0ojSPFQg8rNxuAKDYME2JlsjnSCMa9zCUdQZiVCxDOLfs7Q6joKE/mZ65hvyZV
 eKAtA2fNCEgRDeR4gkZDxrDdMfcPnZofFTxjQpNlTPibNVzakXbAqSZqCPgW/MD8KLxN
 DGqnwvCNZFMNEkOJDsxaYedT728KeD8vLEEjRIObSm0xACrJVHr8c+Hcp4jOhd/97lft
 inaWMLleatDS/xrfp4l0nkiEFpOhATP1D0YRp4VQFhKtEeVh1utvtQ8nczWC42uE2YKr
 y26w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789338922; x=1789943722;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=0gGjBGJoSmsokLmdBE5jqddhDUHQavMfrQ56wMdXWYc=;
 b=Dd+BHbaUrL3MD2pvlTH7GNOSL+EM5teOi3WGuTXsHaFJ/dqP14f+jIK/1NJ8kzOPO/
 0OSGzhDCyxI7XbhDGPhxz07bWgFEFkXW4wHFXfz2X/lWKizwxWjwUnOcqh+5CQV1H5b6
 TkrmWJXEL9BpLB+nKmOva4sz31vw2dJutyRHbcVMTUq71Bo/rBi8X2WxVKu2x/RtSk0i
 YWcSWXBi2tzIwR96cs5TC72Smj93PAzN7oZaZnLMa4kfkr2uqIpq7Pn4yigD69zeyjvS
 u4QPhvsQkeIpoIjN2ucBay+0VvNBOWqhNGGg/953ugFtzVvRVwen3HACJqN9iIAOim3O
 1yWA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxEtH2fPwaro0B/4bnRYf3LTsGJzdrdYeHTMh42GFxC0jc9qwfhrlDMaGyVvyZ+FuxUvXxkepU918o=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nNNVY+M2N2eDas8mjZHBATvdrmD/duki7sPfsjHsVSWP+pb7bh
 n34gyVLG1SdHfLqrs/u5P6hrsza/9lAnqT+d3pu3s3jmZwFnFUZ6V6ABv8LwzvS9SVubrUB/DzK
 wmVn5OBJlR9FY9VqEj4hBIJSzVurvPIFLix/B9CuZMEazK0BVsUZviOfqyv87uzGWGUzr+hU=
X-Gm-Gg: AYBFou0vdClWvaMDBMJt0mEFnGrKmjV4/x1lCLqUZXVRiygE2wVulSMLpUIbLltNqY7
 yRRIoQsMI1QK+xSTJFmRYKfieJIKKq9UOc+Tmm1IudYWdJ7TjGgAd2wU/MpUL6a+HwwSAPL8JCa
 nCe03C1xfq1jEk2apiM/fj/aq0RGnjbb9bptrqbZcfxdORIgOxo2O6y/5YR6BLRRN1mU5lQLl35
 hLClZ7fqchW4v6K8UgPgmObzD6kCXYZTjJFJ5kFFsQsG6Ld2rqzY87w0oWloMOYtZAq9l0NY3E+
 QahASzTxjyyhWxaWA89SMIcwWf4dz83tAiYUgmpsJ6FEhMX8YLKq+moU5uAwxZPnY9is3KFerec
 7M7qOLVTtiLCdpVA66sq5sfg5y9kJuXrJPAPIx8uJXpeLIXuBl/3xMnMldBLh5Nv/i7PFfKfOOv
 ArR02rzv4mdy44
X-Received: by 2002:a05:6102:3e85:b0:785:1a50:3f56 with SMTP id
 ada2fe7eead31-792aced9446mr13843916137.12.1789338921843; 
 Sun, 13 Sep 2026 15:35:21 -0700 (PDT)
X-Received: by 2002:a05:6102:3e85:b0:785:1a50:3f56 with SMTP id
 ada2fe7eead31-792aced9446mr13843905137.12.1789338921470; 
 Sun, 13 Sep 2026 15:35:21 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b8a0461ee3sm1974410e87.40.2026.09.13.15.35.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2026 15:35:20 -0700 (PDT)
Date: Mon, 14 Sep 2026 01:35:18 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Jun Nie <jun.nie@linaro.org>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Abel Vesa <abel.vesa@oss.qualcomm.com>,
 Maxime Ripard <mripard@kernel.org>, Teguh Sobirin <teguh@sobir.in>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/msm/dpu: delete timeout timer when encoder is not busy
Message-ID: <cijlihrrros443ff3pivdlzxwpu2hhhsfpieb3f3vy675zi2vd@qnol7ixz2oee>
References: <20260903143004.1026181-1-jun.nie@linaro.org>
 <CABymUCPzN89G6pSH7hG44hRupeMoyA+54BRW+mW6tT_Y21mXCw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABymUCPzN89G6pSH7hG44hRupeMoyA+54BRW+mW6tT_Y21mXCw@mail.gmail.com>
X-Proofpoint-GUID: SU2htQmgF7tU4bK8kycNs8REFp18EUdo
X-Authority-Analysis: v=2.4 cv=Pv4G/AM3 c=1 sm=1 tr=0 ts=6aa7252a cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=KKAkSRfTAAAA:8
 a=Er_q02hE0Yr3fhQkg_EA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=1WsBpfsz9X-RYQiigVTh:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEzMDMyMyBTYWx0ZWRfX8Znx8dQCzc6A
 xaXxFE/oM14Q/e0xQy4TaK1/UpWYDdXfBqxETo950eV2QhLYk6U/k94jZjU6ts1iBqYnWwPyFV+
 E7esQc2XYNckk2WZLTB32GynBAoyZBc=
X-Proofpoint-ORIG-GUID: SU2htQmgF7tU4bK8kycNs8REFp18EUdo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEzMDMyMyBTYWx0ZWRfX6/t+gtooN2Zc
 WYcVLrY/88QXXdNF7fduUhVpAVXmhm7RySyp0BmICLQgRxuGDfpUBR7rddoM3QASpFqCWj5oiNc
 gwfVdqFcdYUmVFGeA8r7DdjjFZND1lLN6F8xPToUqZBuDel5DJr9cFEOg4m+2MkGnKkbzAlrDM3
 +opajUTu9mwYUybTfcXehoXWgcVlZ0kzvakI7i/PbEIbPsdrJjpxjh0XNcRrDuA1CCZnid/zs8a
 KLIdTnGunMlCYzk/wGHdCjr/KWOPH6GSqdcX1XKY7hLahnbl/ofejw1TAuYrVasPFiHxmD60vUx
 5fHQ7IDkGFGjUBXLjD3+n7kQfN9tTg30Fxog63+oPpGl2A0pTdHwXwZE8KzJMvMBm+qwhXe8+4I
 MPtxh+KsWa2RaCrKJ1RM+RCgGZVo9FfmrEI0hjkDr8hJDvzUX32Q4MFt1UQjoLpbFF44drz3H76
 AlJNRX4+K05xkmOm52w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-13_07,2026-09-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 adultscore=0 suspectscore=0 malwarescore=0
 priorityscore=1501 spamscore=0 clxscore=1015 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609130323
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

On Thu, Sep 03, 2026 at 10:39:22PM +0800, Jun Nie wrote:
> Jun Nie <jun.nie@linaro.org> 于2026年9月3日周四 22:30写道：
> >
> > There is a spurious timeout error message under the following reproduction
> > steps:
> > 1. Run "modetest -M msm -r" and press CTRL+Z to pause it.
> > 2. Run "while true; do rtcwake -m mem -s 3 -v; sleep 2; done"
> >
> > Resulting error message:
> > [  124.018206] [drm:dpu_encoder_virt_atomic_disable:1425] [dpu error]enc35 timeout pending
> >
> > dpu_crtc_commit_kickoff() calls dpu_encoder_kickoff() to set frame busy
> > bits, and then arms the frame done timer. If the frame done IRQ fires
> > between these two steps, the IRQ handler clears the busy bits before the
> > timer is armed. As a result, the timer runs with busy bits already cleared
> > and is never cancelled by subsequent IRQ handlers, leading to a false
> > timeout warning.
> >
> > Delete the pending timer when all busy bits are cleared in the frame done
> > callback to prevent false timeouts.
> >
> 
> Another option is to wrap the enc_spinlock lock/unlock pair in dpu_encoder.c
> and expose it to dpu_crtc.c to make the sequence of dpu_encoder_kickoff()
> and dpu_encoder_start_frame_done_timer() atomic against the IRQ handler.
> However, this breaks encoder self-containment to some extent. Furthermore,
> initial testing revealed a deadlock involving additional locks beyond
> dpu_enc->enc_spinlock.

The patch you posted has an issue of the atomic value being updated in a
non-atomic way. However I think it's not a correct solution. I'd just
delete the if from dpu_encoder_virt_atomic_disable() and always delete
the timer. This also would allow us to delete frame_done_timeout_ms,
simplifying the code.

> 
> - Jun

-- 
With best wishes
Dmitry
