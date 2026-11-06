Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A63DD606A334
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 13:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=R5TjOCec;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=QpJVgJBG
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 15A63112D81;
	Fri,  6 Nov 2026 13:39:50 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B128A112D81
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 13:39:38 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A6APLbR114725
 for <dri-devel@lists.freedesktop.org>; Fri, 6 Nov 2026 13:39:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 pjCkhgBdLsL0cjYhnAXlrwHE99yz9ZM1gMqesSt/VaI=; b=R5TjOCecc9muQl8R
 h26h/Le07HzjtoUp+wJVOCRFnN2h4FaExz8ijnLLxuDxS5fOilpDu9BBf0IHLAAj
 jQ9j3v+y0/blM8qgXtI1WF5Sd16R3NRpzCvFjDvdZYn+PDpB8am0hwZm5YP8Xnf0
 M6uxhfR/z9Y1s9qlj45CYGxV6ovnvXL5kmvqitK6mIzXoyl1sj8zUjicwl/AFUyS
 VW314nC3v9GHAtC3/2NLDf57x22ygKRhGWi4LzCoCpkLJZLGORxLghFNd/k04f+o
 44NN01JxIaeV9WMVS+tY2TNLCouWX31vX34aCL1h8zRGdrbqfqilLBZMH4nhokqT
 WN1Kkg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hs3patyd2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 06 Nov 2026 13:39:37 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93e92aad34aso174307385a.0
 for <dri-devel@lists.freedesktop.org>; Fri, 06 Nov 2026 05:39:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793972377; x=1794577177;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=pjCkhgBdLsL0cjYhnAXlrwHE99yz9ZM1gMqesSt/VaI=;
 b=QpJVgJBGaa3zSxaekL0HyBmUpCC966XTvfQjrgTGWPNNeYRR88nJYkfC/y6LHjoHrS
 OiljY5wdHLVkbV/Z1RmIEBIhAKp6XRAxLfZLUP0MlV9WBYGY6wHphM17kzpA+lBmjoCH
 l9+t/wApNf/5BvHHJchnlRNbWUuaR0oB3K/z3N9p3x4PFjEAwq7v8ahXxJeeWSu3zKjM
 WJjSKDZG2gw7Ziu6jpIM+tlob/XEv+ZrmA2w8qCljq5CnL0KzOFW1tkGh6BF7opqhv4N
 NBm6+RPd73QRhesulYvA2hW8VtZLiVLACwborCwbfyj2/+4uVB8EQK5MczAKNxBfelvv
 /5OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793972377; x=1794577177;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=pjCkhgBdLsL0cjYhnAXlrwHE99yz9ZM1gMqesSt/VaI=;
 b=R2kOGMWLDsgzOlxr8M3yRizVLeuaHZQnEl5CyeIbjq6FgpUwYFcfsrI+xy+HPQa9Gc
 RUksDmXgPAAbVy+Wgb05H1x8eLAcrlhSAqgX03epDTYey9ZgJ4P8wwggT+FoGizRS/ph
 SPnWTIdVE0+OnMHBon6HBxc7icSrq0VZfwcdyzIYVR8R3HgNhGMBK5vq+zPggXiYf+DE
 gojNVcEalWNcZzgBQpkM3v1LjhJ6gQwjcoYhpdctHw91oX45qDGdLOTspPdWj5iFhMUZ
 z64Vp0NIfRLkTtSwtQYbINzWwZ154Y/00VLp6zN/z9Ia4vQSlhRAtQLxO4H1PTP6S6sl
 5T1A==
X-Forwarded-Encrypted: i=1;
 AKwUvBzk+9JIAwumd4xmBsAHer0HhqTIAfScVNVW5Qw25xp60kAwr8d/R4QkgOZf8vqK+EboMK1annJbMwU=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9BYisfF0WduM6CykhI6PAIyOp6gdD775Xi1GcfrCTpGnA6VG6I
 CXgV9iwgqshuKvvhl3/8ZUvkxXQtpUWflzN9Lj8e+W7/cHp2Lqsm8dpWUI13QIasJh+cC8SBchc
 Eou5btZJZJoM+1pbbji998MMHz6px+KhOxHTZNKOCSgFFi4pUICQfMGW6liDmmhg3gpvTYs8=
X-Gm-Gg: AYBFou2L1UFyECYN7usirCyLgDFun6nlXlLAPgQvIi5DoPjmrV+COKJFZUHSicEpyJA
 W/K/MdZ7Zw70bDNoD00oRPouAJHTVQdZu7yHzPrRS6wMqzjdNR+qzUJG0GN+13TJBkB3DRnwN3P
 AsKYDLpHIKU6lzLqtsWhXSx8QLZlVbrBNoZ1TzW1tBf4bFWrJkfa2G+JoFq7KR+Bpsr+wgiWy8F
 xyNk3UFb0HhPZ2uOwyoH3LLwVyhAK4hpeCNdjbbgcl28NnGtYgzlFa8UFNHUf1PixpM5KcpToKk
 zswj/3sSAciNB/HUnW2izrtFhgNpEHTvcdVrrhCyiy08KOb0vqiX8jyhML8XtbMO1zACQuoCC/u
 O3+QnTaqc/FgkmatiPoTxu8T2Yr6ouSPJQ+eV/3ix6+h5Es/VXyOjSuT2KOLDfF2et64od3ENYK
 fQkye7o9IsOrT7nYGuQCLQEvtmtNW3kx8fn5i8lf8JjKLWdiZ6BD2A7t/bbQ7r
X-Received: by 2002:a05:620a:a91a:b0:945:fcd7:7823 with SMTP id
 af79cd13be357-945fcd77e03mr112040985a.63.1793972376426; 
 Fri, 06 Nov 2026 05:39:36 -0800 (PST)
X-Received: by 2002:a05:620a:a91a:b0:945:fcd7:7823 with SMTP id
 af79cd13be357-945fcd77e03mr112037185a.63.1793972375910; 
 Fri, 06 Nov 2026 05:39:35 -0800 (PST)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5c0030a3b50sm369070e87.79.2026.11.06.05.39.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 05:39:33 -0800 (PST)
Date: Fri, 6 Nov 2026 15:39:30 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Cc: Robert Mader <robert.mader@collabora.com>, rob.clark@oss.qualcomm.com,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Bryan O'Donoghue <bod@kernel.org>,
 Stanimir Varbanov <stanimir.varbanov@linaro.org>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Jordan Crouse <jordan@cosmicpenguin.net>, linux-media@vger.kernel.org,
 Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
 Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
 Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 7/7] media: qcom: iris: describe QC10C as TP10
Message-ID: <se7js4dwankc53n4jxmmi5qzcav6xbkrztrtdae3wcj537qtqd@syrjvxuv3apf>
References: <20261104-ubwc-format-docs-v1-0-389044012b4e@oss.qualcomm.com>
 <20261104-ubwc-format-docs-v1-7-389044012b4e@oss.qualcomm.com>
 <86b801ce-a56c-4ff8-8915-9be369fc0ce8@collabora.com>
 <CACSVV02t9=tm2qyG531f8Ne90ADAb1_ZDDGEg7PwDmoEvGxPrQ@mail.gmail.com>
 <7b4d3a85-6aea-4b96-a4d0-c2f16e488ad9@collabora.com>
 <7e8a6645f181c9e8d663eb97bb1f32e3e4fd8c67.camel@collabora.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7e8a6645f181c9e8d663eb97bb1f32e3e4fd8c67.camel@collabora.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA1NCBTYWx0ZWRfX7wiNp+HILYwt
 vXL4EHVkbZXyqkyXuRd6CW+hckOOcaGpi2QpV3Szzw806QTbiy5DRgda5nwxBkHzri/SJExNCMK
 JrDocBi847G/+RcCvk9FnTd2kwnyAvGGAbsM71b6+GchKRiO2KqR9g61iM5B4Yw9PgEt0xizXwd
 Hh2A0q6xIM2DQzmParTzqez9ILIjpR8wRfiUvxX584Rm2Hr8CaSdIDbG227VU63AXk4v+cHlUvl
 VXoDTEUkHA5hro1DA1fM+GCc/ON/IpYrIsSY9U9JDt6Bex59YU0XojONrWjLjE49sI4ejTgLXfz
 cxweVPUyB5Y5VpZoWm6YZ2BEvkgDafYsFsgfcBZzlssmTqrOqTsLKu5uAeIfEB2YUv9Zvcv9fjI
 57HuiZq0E32O7/minU7XYG7/uunxP4+Mnc3CfsS2ysCpoOsqFBC/NedI2OJrbXtV5Xu6bNkzBnP
 NG8rZgaFGuxDEtcJwxw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA1NCBTYWx0ZWRfX5W23Z7f1XAib
 88MPJYbqZa1plsCz262rQY66o7AGfk2X/HuagWQvkRAWv3B0m3k+YAWOawifTCOtJZ6AozlU5wZ
 BN+54cJvewKCJbne0xX2fjuVUX1XXYA=
X-Proofpoint-GUID: guZVd7fcQuxfx8zZRtC9RSCOS781c0e4
X-Authority-Analysis: v=2.4 cv=P4ivFSAu c=1 sm=1 tr=0 ts=6aedd899 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=e5mUnYsNAAAA:8
 a=QX4gbG5DAAAA:8 a=EUspDBNiAAAA:8 a=g_Gk0hPVKUWBytyV-9IA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22 a=Vxmtnl_E_bksehYqCbjh:22
 a=AbAUZ8qAyYyZVLSsDulk:22
X-Proofpoint-ORIG-GUID: guZVd7fcQuxfx8zZRtC9RSCOS781c0e4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_03,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 spamscore=0 phishscore=0 suspectscore=0
 bulkscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611060054
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

On Thu, Nov 05, 2026 at 03:34:55PM -0500, Nicolas Dufresne wrote:
> Le jeudi 05 novembre 2026 à 13:35 +0100, Robert Mader a écrit :
> > On 04.11.26 23:11, Rob Clark wrote:
> > > On Wed, Nov 4, 2026 at 11:00 AM Robert Mader <robert.mader@collabora.com> wrote:
> > > > Nice, very happy to see the series!
> > > > 
> > > > On 04.11.26 17:36, Dmitry Baryshkov wrote:
> > > > > The comment describing the QC10C buffer layout calls it a compressed
> > > > > P010. It is not:
> > > > If I'm not mistaken the display engine / the DRM side (including Mesa)
> > > > describes it as P010+QCOM_COMPRESSED as well, and so does my pending
> > > > Gstreamer MR [1] . So if we can't pretend that QC10C ==
> > > > P010+QCOM_COMPRESSED, then we probably need a DRM_FORMAT_TP10, wire that
> > > > up everywhere etc. OTOH if we want to keep the DRM side as is, then the
> > > > comment should reflect that, IMO.
> > > IMHO we need DRM_FORMAT_TP10.. on the GPU side, we have TP10 and P010
> > > as distinct formats, both with and without UBWC.  I'm not sure if the
> > > same is true on video side but P010+UBWC was never exposed, or if it
> > > truely only supports linear P010 and UBWC TP10.
> > 
> > Oh, do I understand you correctly that the P010+UBWC implementation is 
> > not compatible with QC10C, meaning on the GPU side (Mesa and display) we 
> > don't yet have any support for QC10C exposed to userspace? If that's so 
> > then we don't have a choice but to introduce DRM_FORMAT_TP10 I guess?

Yes.

> > 
> > On the plus side - this would allow us to make the format single plane, 
> > matching what we get on the V4L2 side.
> 
> Since its single plane, we should aim for a variation of
> DRM_FORMAT_YUV420_10BIT. Similar to YUV420_10BIT, there is no obvious linear
> single plane packing for that, it would only be there to support the
> compression. Or maybe this one is abstract enough to be used anyway?

We have DRM_FORMAT_P030, describing this semi-planar packing. I will
describe P030 + QCOM_COMPRESSED for v2. P010 + QCOM_COMPRESSED will be
repurposed for the actual P010 compressed by the GPU.

> 
> Nicolas
> 
> > 
> > > 
> > > BR,
> > > -R
> > > 
> > > > Best regards,
> > > > 
> > > > Robert
> > > > 
> > > > 1: https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/8195
> > > > 
> > > > > P010 stores each sample in 16 bits, QC10C packs three
> > > > > 10-bit samples in each 32-bit word, which is what the stride computed
> > > > > below (width * 4 / 3) assumes. Name the format correctly.
> > > > > 
> > > > > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> > > > > ---
> > > > >    drivers/media/platform/qcom/iris/iris_buffer.c | 2 +-
> > > > >    1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > 
> > > > > diff --git a/drivers/media/platform/qcom/iris/iris_buffer.c b/drivers/media/platform/qcom/iris/iris_buffer.c
> > > > > index eb8de60c1177..ec2bf2a2d953 100644
> > > > > --- a/drivers/media/platform/qcom/iris/iris_buffer.c
> > > > > +++ b/drivers/media/platform/qcom/iris/iris_buffer.c
> > > > > @@ -266,7 +266,7 @@ static u32 iris_yuv_buffer_size_qc08c(struct iris_inst *inst)
> > > > > 
> > > > >    /*
> > > > >     * QC10C:
> > > > > - * UBWC-compressed format for P010.
> > > > > + * UBWC-compressed TP10, YUV 4:2:0 with three 10 bit samples packed in 32 bits.
> > > > >     * Contains 4 planes in the following order -
> > > > >     * (A) Y_Meta_Plane
> > > > >     * (B) Y_UBWC_Plane
> > > > > 



-- 
With best wishes
Dmitry
