Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD970FED9F8
	for <dri-devel@archiver.kernel.org>; Tue, 17 Mar 2026 17:34:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5222310E556;
	Tue, 17 Mar 2026 17:34:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="KzbvPn3/";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VcGwKELM";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E5BEF10E57D
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Mar 2026 17:34:33 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62HGXPaq908441
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Mar 2026 17:34:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=ZBJS1aektFIiTStuP3Gqvt8L
 WcVUItuSxfVJ8xAl4rM=; b=KzbvPn3/ULMvxghGUSNC42releSto922lkjjXdd5
 BQEz28XIQtB1Mcp9YFuhHggTfiKtzJcpHj/ivMMYWGvHSnLqq0LauXaW+Dmr+P8z
 pv0RdJpg6tmHQd41yeSCa91ddqoXcEaM5so/LwceYCZ6TiPENYhuAdN6YgBqVnGx
 9QFq7w+62GGtQSestY0jWCAvJlNw3OfDPszhVZXLWeyQPPGApHfTsKbRBbnSn1kP
 9Lzk2kpCveVF3Z7fcVQRsQc28UOTOze8cbLx2fGI1+S7KscQxc5eih/Wgn8Ejc2J
 B1kSdJV1p+G5mFANCURh03UszbpANfXNoqCbIGknA/n0FA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cyak3r8dv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Mar 2026 17:34:33 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-8cd827a356aso547421885a.3
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Mar 2026 10:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773768872; x=1774373672;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ZBJS1aektFIiTStuP3Gqvt8LWcVUItuSxfVJ8xAl4rM=;
 b=VcGwKELMH3iA6cLKJ+eJuqnpEkw9ElheQNnSFjHGa4IcLItTyKSIKijjjXv822oF7m
 Zwf46A011o9I5//3tVt4mzWurHIKdlSPMimDXR2UEZP6L5EqaRld9ldG8Ni4SzbsRLcD
 +lBuI64q1dXPed4X+UP8DhYnCoHnxynWlL/ul2WgDSEq3o5kDMUAo86V4zLSVtqbPF0c
 Jgu6nnL0YzZPfnpMlBWqaAPPkaOGG4eaKp2odKdL0l58ZSVLACMXrguFYtBnTqbEIQxD
 W0X2QuAu0qnJUdiGwzLYbKnd2szC6bBib/J0MiQpuhejEIzDwdWyIMQ7sX3jca4la2X9
 0iSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773768872; x=1774373672;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZBJS1aektFIiTStuP3Gqvt8LWcVUItuSxfVJ8xAl4rM=;
 b=Fpo2g02GTDGKf1gNhmjBtNEBpXMkPnDQ7UPGQJh/GVvud6ftj/VOqoK8d8bbKdwJDv
 c2TipbK2juyR4Z/PPY3HByzOcFU5e7uCB8fIqH7Xh69EnzV38BWYijaDz4NF4MYWyp6p
 FD9L6NCLih62lOcUU/uPy1J1Otb7BI+j1l1bIFAwj+ZOBB5YGup/5FOeQWXrQ2p1MFds
 ra/nHjfhBFLhNT446wkGkUKvs+c811l1OH0R5oCApoJFgd89tZhqYHu2PE9Oht5tfjWr
 wR9R3zQ9owbgSdUc8J/N1AIuuPTd+7JQfGbFHZcUJWenE0EompmDpclvAdxrW0r4yXmq
 O4Ag==
X-Forwarded-Encrypted: i=1;
 AJvYcCXLde99HW4KKWAEGLN0WSNCMNxGqhKRw/cNi7/ffKJbTWp5831fb7kEAczBhbJLFQOmOh7IQXXaGds=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yyw50J1m0x6x3cPCh+IUCzqqR43TXq02q0Mg5M321N/l9DbjAdK
 gVfPmDTZ0EXLbhZyvK1nKBqsf/zo+VaT+JyRd8ZgiiDmVrQ9WfEt40XOIi4Nze0Pgjmu9kVS81l
 BrgKj9R+kG1fS4E5WXZDJHq3IV0m+OOy8nSQZk3MPO7wypQ6bsTdhh440lZELl0mxZLdt1KU=
X-Gm-Gg: ATEYQzx3BLiArOUsUOCEGBxGEofaOo+sAW2y4YH9e2Gn+xMcQcX5GQxKxCq8nKsS75c
 QLTiiIacoU2WtlvgO1rQZiZ7f0++L11tCkkwChFxIDNKXBf9tZ1yTJSUQ8oKox7V5KOFp1H780+
 xNrM6Hidg4ANP+nnJADbaCH+RqDgGdttFVQFE5OJsZEl/1zw8JE4v19k4oimIQoJQf/PbCZ0YnH
 HygvsjJvUxyvjWZXGZ7+EaytRCnoVUytRVNX7/f+jroAnNxFb0lQaVfPYr13yIiYjZPn9ORYlt3
 Gy3iVpuvT8GQ5frjATLrU6O5dniiZuUcbd90kKa6Z9h9BgRcpkHscjwE9ahJNyzQ6OwzPxZFvsE
 LdPhV2oSCYKsLBTNUMElP/bxLEd101+6iGiYFPf9u7JatYzVj2OO/NWjcY74C9V9FR4tGU7tkKC
 vje/it/auM13GKEzJ1e4gjJH1bSFHkY8wOJi0=
X-Received: by 2002:a05:620a:4709:b0:8ca:2baa:6656 with SMTP id
 af79cd13be357-8cfad2eab27mr54297885a.55.1773768872261; 
 Tue, 17 Mar 2026 10:34:32 -0700 (PDT)
X-Received: by 2002:a05:620a:4709:b0:8ca:2baa:6656 with SMTP id
 af79cd13be357-8cfad2eab27mr54293185a.55.1773768871770; 
 Tue, 17 Mar 2026 10:34:31 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a279c743b1sm11354e87.58.2026.03.17.10.34.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2026 10:34:30 -0700 (PDT)
Date: Tue, 17 Mar 2026 19:34:28 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Luca Weiss <luca.weiss@fairphone.com>
Subject: Re: [PATCH] drm/msm/dpu: don't try using 2 LMs if only one DSC is
 available
Message-ID: <i2ev64yvef3la7codj7hfscuv7ag2d7p5lplfqav6ktkm3d3vo@x5hnmpggevip>
References: <20260317-fix-3d-dsc-v1-1-88b54f62f659@oss.qualcomm.com>
 <df44b8d4-98fa-4a9e-9c24-b408f406b124@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <df44b8d4-98fa-4a9e-9c24-b408f406b124@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=A7Zh/qWG c=1 sm=1 tr=0 ts=69b990a9 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=LbxHV1oPoWewQDzF:21 a=xqWC_Br6kY4A:10
 a=kj9zAlcOel0A:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=xNf9USuDAAAA:8 a=VwQbUJbxAAAA:8 a=6H0WHjuAAAAA:8 a=EUspDBNiAAAA:8
 a=ZoEw9hnT7ZuqxarybVIA:9 a=CjuIK1q_8ugA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
 a=Soq9LBFxuPC4vsCAQt-j:22
X-Proofpoint-GUID: k_JDA5YwcgJiRd4X7s_BNhKW47-CaVAw
X-Proofpoint-ORIG-GUID: k_JDA5YwcgJiRd4X7s_BNhKW47-CaVAw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE3MDE1NCBTYWx0ZWRfX3FF1qQ+QhZ96
 4GtmUekYBW5A8mXC8I5m+ZtTb4aRmqf26md/2/XicIKfHnyKGrgLA2XLpxFrgMM+UJr1Dkqdode
 NDGaQ2DTIc2dAytrcId8d4lyO9XPSYVmWZp/fFmB9pvMqy/cZBd7ELPUykLXJyB2lw+ETT2L3qE
 cKaYEg9Iwdw0RazIKjpSoNptzo56tt50RlHl2L8MeP0OrL8mjnq2yM9l9y6qwAX9NUqf7pGz4Kt
 bBoPYEky73sPCvHe9kltY3yv7J757lYkTOKQ5Qk56N3FV0KKgPXKnLOcZirPuTaDeJJA3BZK6YP
 4eyUAF0yRwzEG7mzPHF/LoPE0Rl/mwk5jq2MqWJzuYneXXHcGCqaSP+9HsvlbP40+eGi5KF03pJ
 PWGieteZAExT5g5zntcvdj1BIDJGGBHSMEty06cD4iIfXRiy0WagIYZXxprLQNX/QDs/mobG8aQ
 FTRncogMw1XHpb9LUvQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-17_03,2026-03-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 malwarescore=0 phishscore=0 spamscore=0
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 clxscore=1015
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603170154
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

On Tue, Mar 17, 2026 at 05:48:59PM +0100, Konrad Dybcio wrote:
> On 3/17/26 4:30 PM, Dmitry Baryshkov wrote:
> > Current topology code will try using 2 LMs with just one DSC, which
> > breaks cases like SC7280 / Fairphone5.
> 
> (why/how?)

See https://salsa.debian.org/Mobian-team/devices/kernels/qcom-linux/-/issues/41

Using 2 LM/2PP + 3D + 1DSC is a separate topology. I'm checking what
would be required to fix it. For now this is the easiest fix to forbid
using it (it wasn't supported beforehand anyway and got enabled by the
encoder / CRTC refactoring).

> 
> Konrad
> 
> >  Forbid using 2 LMs split in such
> > a case.
> > 
> > Fixes: 1ce69c265a53 ("drm/msm/dpu: move resource allocation to CRTC")
> > Reported-by: Luca Weiss <luca.weiss@fairphone.com>
> > Closes: https://lore.kernel.org/r/DH1IKLU0YZYU.2SW4WYO7H3H4R@fairphone.com/
> > Tested-by: Luca Weiss <luca.weiss@fairphone.com> # qcm6490-fairphone-fp5
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> > ---
> >  drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
> > index 6bf7c46379ae..96b67ea3fb4c 100644
> > --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
> > +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
> > @@ -1410,7 +1410,8 @@ static struct msm_display_topology dpu_crtc_get_topology(
> >  		topology.num_lm = 2;
> >  	else if (topology.num_dsc == 2)
> >  		topology.num_lm = 2;
> > -	else if (dpu_kms->catalog->caps->has_3d_merge)
> > +	else if (dpu_kms->catalog->caps->has_3d_merge &&
> > +		 topology.num_dsc == 0)
> >  		topology.num_lm = (mode->hdisplay > MAX_HDISPLAY_SPLIT) ? 2 : 1;
> >  	else
> >  		topology.num_lm = 1;
> > 
> > ---
> > base-commit: 50c4a49f7292b33b454ea1a16c4f77d6965405dc
> > change-id: 20260317-fix-3d-dsc-4b073977ea19
> > 
> > Best regards,

-- 
With best wishes
Dmitry
