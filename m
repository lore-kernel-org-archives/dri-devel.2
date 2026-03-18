Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D77B410775FB
	for <dri-devel@archiver.kernel.org>; Wed, 18 Mar 2026 17:30:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3920110E231;
	Wed, 18 Mar 2026 17:30:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ej7I1v6m";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gwJczwkl";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7881D10E048
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 17:30:32 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62IGNWCn004821
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 17:30:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 jsdUjT6QXWGlY4sg5HjzvLmam34NpmSGVzMoRHEEyJs=; b=Ej7I1v6mQDpfU1RP
 waImumB5aDTkym3zLDGgpNoG1h+qN92Ky8LkPVPWTAqYdNjvdDNJxKY6fKygfj9P
 cfjHufbQz4W7+jEwtFVwxQ1dtOJZSNJTCrTC8EulOSDa1xGonv2A+3ToDKGqIFbv
 LG8/9pgIgHYjWpp6pQC1/qmlUT2WvaGNdBMg0qhPJnO67hC1I3Hg7WdpIOL8jXTR
 I+1cdFbkKUjXHeTL63N1ReVqoN2J5INqLyzeuDQu7zynHYLKMCx645fon02qgoZS
 VXFTeiG5wqc08EBkMx0sQ1e2TQHsnYDW9G+uuIL1Zfh1u5et14CHIHS4Grcavh9r
 inyCsw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cyyhg88vd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 17:30:31 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-5091ee9f1d8so3069861cf.0
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 10:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773855031; x=1774459831;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=jsdUjT6QXWGlY4sg5HjzvLmam34NpmSGVzMoRHEEyJs=;
 b=gwJczwklYQvNvlb4NKStgtOQoDDGotXPEa0Jt+rTB/06WF9EHUB8nxHvkeNdgJvP8Q
 ta4wwanvEjqTkKuZXTM49Mb019XpBJrDv3pSahQZsgYwzPfwElaqamPlGwEIAGBYcgpO
 1Z7jl/nEQT85QT3+fcQUwcz7Gyt8dllWgYFHYvcmNgLh9HrC5RBC78awTsYlbQX6jWJW
 34ulFYzwGdmNK/oNQkhIGCe7ghukp1/GSO+d9xhsFZSVORztF/fSv416yTF9uMBmXNiO
 Gav1052kPTHwkJuvDnLt1zfMmIw5Ltuowc+Ttyukft9gktH4pUm1J3gJ85hMsoFxLRne
 vvOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773855031; x=1774459831;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jsdUjT6QXWGlY4sg5HjzvLmam34NpmSGVzMoRHEEyJs=;
 b=VDAbt8WUfQMsB7PHyqaNc8YsWvJXp8g/H39jMYR5DmLTy+EvYCv3i44pDijuVlX2TQ
 jQfp7l0bf70NrrQm7Qx5wXjjRv9vC5OYPzNenEtmSQB3/K0rXPHlPkmbKjXp89Pp3Y4A
 WPRkWUn6WIlW08njGeNOTqj2dHjGDB3efUTRtfYCmeK4sf0QDvbqcCYxZu9bRlQSNfny
 vD2qmWFiZ7YhWOj4tJNK1LS3/pp/t6GHPwY/0SP4a7a1DZUDIAJIOaXe3YTJrmJa1RZK
 PA38Jd+XKY2bsHrJqnYohDmpsBNCXXy34hULF+6barn+/cRHET/neucuyDXs2Zr+bx2m
 HVVA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV+wWXttoso544Usz8sYZycLY7MmCOoOd2855dywRcorb7Q/IqJ+Nz/ttvlqloEQV608L+dHJ23L0Y=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzMtC5tKTUvcvFp9dUfiVDOVQF8qTaBIRAC4gqR3/Y2k29L+Sxh
 mhjG80HTOnj27TwDRvvDfd65zesfsAWx0SEU0O66Ogr7fkF4NfjkzeuW8/7Zy98bvScQNA6JO45
 jUCEMkxlYhbW4pqecMWe8/ISXZkwnVbhRwQA2LbUuMFjU8FfuttgrIGeHNV0+oS9mHRI2l5E=
X-Gm-Gg: ATEYQzw/w30IpDl1MnKQhLn7BxE8KwSI6NUlPEZMeMSCCyXGRjOH4QDFb0ella0c8yU
 yzW2A5W+7Ss/5awYrqQMfNZN3h43hs6xY4BPvFmBcbT8YVx7qhAEk1jPy1KFzhiLqLbIVxi2rKN
 RX6YvuANS10H0iaTMXijTJh5t5GOsjy2X5UnyddPuT1o4eo/dy/XQ1QSvzOZLKVhPE35NW+8U+E
 3D9sCTahDY0PWKnwY5tu59hx/tA8zIjWsPW5ZA+x32GTtz07bGFmNI0ebu347dSV11odPKeISMp
 qgqqfHA/M9Vu1XED7Yh/JX6xSQ7Y8MN/xESZW26ujmyfEm6x4JNWEk3BX+4fQSxtT4e3V+HzOqB
 LwtcXLBv3ycdOAZglljnKTTKQy+9Mqv7D75xSou5jlErZP8IexTBehsByj931+p2rexfCQ+Fnfn
 1mpIFiesX9Os/B/BARNHuMWqe4HFb0a7TRiVA=
X-Received: by 2002:a05:622a:612:b0:509:2231:977a with SMTP id
 d75a77b69052e-50b247666c6mr5308831cf.30.1773855030548; 
 Wed, 18 Mar 2026 10:30:30 -0700 (PDT)
X-Received: by 2002:a05:622a:612:b0:509:2231:977a with SMTP id
 d75a77b69052e-50b247666c6mr5308061cf.30.1773855029880; 
 Wed, 18 Mar 2026 10:30:29 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a279c2c11dsm687273e87.22.2026.03.18.10.30.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Mar 2026 10:30:28 -0700 (PDT)
Date: Wed, 18 Mar 2026 19:30:27 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: =?utf-8?Q?C=C3=A9dric?= Bellegarde <cedric.bellegarde@adishatz.org>
Cc: robin.clark@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev,
 jessica.zhang@oss.qualcomm.com, sean@poorly.run,
 marijn.suijten@somainline.org, airlied@gmail.com, simona@ffwll.ch,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 phone-devel@vger.kernel.org
Subject: Re: [PATCH] drm/msm/dpu: fix vblank IRQ registration before
 atomic_mode_set
Message-ID: <rydbi6teluxhmilj4bn47ds27i7uqsjtv4bd22s6cxpxcnt5fw@c6b5e6r7cxm2>
References: <ubxvfyx4tugfliwffrrlbe2oliep6nhp5dbpjry4vmamldz2ow@qncsubi7heex>
 <20260318171700.394945-1-cedric.bellegarde@adishatz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260318171700.394945-1-cedric.bellegarde@adishatz.org>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE4MDE1MCBTYWx0ZWRfX5r26mgwvjMU0
 BW0FS0aEuAq/ZIm7nNF9fvFBfv6xtuOiM0yHv+0ulw56L5HbrviPl4wXgKKqMxYK8Mqw7R4zPM9
 Nim6s82NfHN9nFQxSuUrhltB/shCPwq0AJJkXEU4hDcqpmkzU5QMdwdprPGf+1hNQoFzBPkQOD0
 auBBwjPKmq+RJ9H3MP1V3hewRT+anYtzWB/sdp/i+Qxw72CS6CaJeji4csrGiFqiZPcIQ3mEKUi
 5TXHfHRYKQ7bsDlnuBYXTzUyMKer34jSv7HdyXApPolApRwZxMMkP6FSkgQr3LIFHgioeGfwD1A
 Ix9ZHisPavnjfJ2emmM4ewEQWfMT6Qx5j8Y4PN3v2r31tafArU9+svfccyR3K3lNKxwSauBm+Qk
 0HNCYG2EnPTxq2zJ79HEJDv0T5N7zbyZHSHH+a0fGb4vv5iEWP1+mD0zGThMuJ95bmP6N5G+Kq6
 2F0Jw2aQ2iUwnP8NEdQ==
X-Proofpoint-ORIG-GUID: YTnOEqVJDgOiZNf_cB1t_H6O5UY4WNvp
X-Authority-Analysis: v=2.4 cv=IbSKmGqa c=1 sm=1 tr=0 ts=69bae137 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=LCWlJkpBAAAA:8
 a=EUspDBNiAAAA:8 a=h7vFti6rFQqOaJsGGxgA:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
 a=dawVfQjAaf238kedN5IG:22 a=z1lahxahPt366DkPXCx7:22
X-Proofpoint-GUID: YTnOEqVJDgOiZNf_cB1t_H6O5UY4WNvp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-18_01,2026-03-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0 impostorscore=0
 clxscore=1015 adultscore=0 malwarescore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603180150
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

On Wed, Mar 18, 2026 at 06:17:00PM +0100, Cédric Bellegarde wrote:
> dpu_encoder_toggle_vblank_for_crtc() can call control_vblank_irq()
> at any time in response to a userspace vblank request, independently
> of the atomic commit sequence. If this happens before the encoder's
> first atomic_mode_set(), irq[INTR_IDX_RDPTR] is still zero.
> 
> Passing irq_idx=0 to dpu_core_irq_register_callback() is treated as
> invalid, and DPU_IRQ_REG(0) and DPU_IRQ_BIT(0) produce misleading
> values of 134217727 and 31 respectively due to unsigned wraparound
> in the (irq_idx - 1) macros, resulting in the confusing error:
> 
>   [dpu error]invalid IRQ=[134217727, 31]
> 
> Since irq[INTR_IDX_RDPTR] will be properly populated by
> atomic_mode_set() and registered by irq_enable() as part of the
> normal modeset sequence, silently skip the vblank IRQ registration
> when the index has not yet been initialized. This matches the
> existing pattern of the master encoder check above it.
> 
> Signed-off-by: Cédric Bellegarde <cedric.bellegarde@adishatz.org>
> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

In future, please, don't post new iterations as replies to the previous
one. See Documentation/process/submitting-patches.rst

-- 
With best wishes
Dmitry
