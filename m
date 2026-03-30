Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6B501061B1B
	for <dri-devel@archiver.kernel.org>; Mon, 30 Mar 2026 18:39:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2CA3910E5D3;
	Mon, 30 Mar 2026 18:39:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZIfh/4pp";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Xlue+uO1";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 96E0010E5D3
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 18:39:36 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62UF2lJx3539773
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 18:39:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=i2E+GE09FmltyRsV3H2OSAIQ
 wNIh7dFlCvCCHrzV+aU=; b=ZIfh/4pp5HbF8TUPbT0rdz9Jwx6gDNi1ltR9pTcP
 Mgpxyoss277mPutIlk9V9lXE+zf1OKOf8CJk/0HUgdjmgYIptPhzHg7RT3sJzuRK
 mldUH6bjZx2rcmkeb4acl/ZX1K1k4dkwSxJAfCR3E8O9i1kWwpg9yjyC0YR4J+ey
 P7G+RY0J6EMo3YKhA9B1Y4ClHcEepmXRiO+Nnpok7mgYBuxk3Q+c8o881O6vQOOi
 GrPtnoUoeiRNA1ldVovOJt+WJs9Nm8O1IhkJxXGD3b0NKGb49MqqiVUlif7/kTJq
 k1RP8XBPoWJg6t/kSLWR4sZF6796pI7pkNO3TpUQqfX5Gw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d7q59t1xf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 18:39:36 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-50b3544bc7bso70338831cf.2
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 11:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774895975; x=1775500775;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=i2E+GE09FmltyRsV3H2OSAIQwNIh7dFlCvCCHrzV+aU=;
 b=Xlue+uO1R4MxZxPeCjRy0Fh+WGjA6fCWY30mrOUzQYSJ+aUMbYzblXf0nRF1ozxGRS
 2dOg9bM8dxgGpvy94dOKsGrPnpdKLSF/m71dUVix1zta2/DKPDmKvffWzzHUvB/WK3VO
 qvz75kDFAL+1wx5Hpz1+YpRAMs52DI17OsvNJVwfsyHgnoE+/mv4ptgLu/bttGRSZRSl
 hKacchmIZE1W+mQkClFIstj0lKn5LPSSSI4nKE4CSft+3Ric0xa/aEZwd+NbmIE3JwXR
 Qv7HaOykTjbGyxnFLZmE5/TEOz6FAk0pt+CrBxhzRaPG5UfQhPJq5AKxSXvt0USDXOm6
 jpmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774895975; x=1775500775;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=i2E+GE09FmltyRsV3H2OSAIQwNIh7dFlCvCCHrzV+aU=;
 b=Ncd//s0IqKouy+GQhWi+wshTZAfz//7zCwB3VUMMP100MztcFJV+JqYSrk2utGmkDK
 DNGSUkn20WebC3JOQ7f2alqITYeUqWJfr5q7sPNdfsuxo8Z7LUcEMGdk3RnqvpqCaTKZ
 wiMDRSYih1mB3+zzkZTyc1JqphHVNuQfvlZPTQ6/pGLIFbk0jBtTCnaRfKtixofXBiry
 1pYR8mu7HHIzeijRp1ulZpN2wM9lAoYMYX4/ziyktM7vC+SYcPUpgjeNsbMV1Ka0AVkO
 JzRTxy20M1SgOdNQutjP23GjGLHL3u4+DIPKMqaAkfgNqTOX9iEQH4xT3FYv7MJWdHp0
 6TxQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCULhgTK/1Jd5lc1Sib3rGgGvTX4h/0u1sez+z/MgPtKIEjfFqYqF3mAOjV3fftKDvSNR40lP+h6XVs=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw217fmGFnIh0TCu3gsNbP7I65u3zemzapT2k9ltDGwZd9B/H2v
 2Cfc9IrheJ4tM4UCBoZMZHTDdZiseAu0S55Qr4BxRG/HmaZekqjw1zInaNJiQMB1ANaDehaHmhi
 u5FrKTGaaYjXll/rd22kaSCgE61ZzX61VhvBV+N7llGCNzskHy58BHOVdrersuPR3fQh+dNQ=
X-Gm-Gg: ATEYQzwzRNKuEnyhVb6ym5GwV9LZAMT1AZmZFhdE3zkbCLaNW3slXvD35sv16OgSrqd
 hpb5YnkXpTKpZhllVNPieyB4WLp1puJlB6zDbFp+egiPBV589x03YfghetkEEUKIuuJoNkmrN69
 7UEbuSugZWuz78N+hFL3yWMBsf/EKmP0gW/WBHq5je1l7dhnQ+9lh6UuFKvFyhCvi/geFDas1WM
 0xWhMWt6iWC3kVjGpDfEAlmV0RmKHpTAk9u8qQjNs27+t9/Q1sbTONtiXffIKjKtk6/o6c/4d+9
 lZn/C0EzJiR8N87HGrxtPGW/FIH4zRVECrXl/xZWmzrBhxDR+l6kB/XpWdgyDlwcDtXDpe01Koq
 BZxk3+4FZAhDaOXHpPprGxcMYv/q2VdXkejIziOkG0elh0lGQN0QavD3gmmMA06G2gaTLgal1UK
 WR6qaREDh7rnW5zLRp5alhkGyRiYqveolIu8c=
X-Received: by 2002:a05:622a:5408:b0:509:1949:7b36 with SMTP id
 d75a77b69052e-50ba386e266mr188295861cf.30.1774895974908; 
 Mon, 30 Mar 2026 11:39:34 -0700 (PDT)
X-Received: by 2002:a05:622a:5408:b0:509:1949:7b36 with SMTP id
 d75a77b69052e-50ba386e266mr188295461cf.30.1774895974338; 
 Mon, 30 Mar 2026 11:39:34 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a2b13f41e7sm1842309e87.5.2026.03.30.11.39.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Mar 2026 11:39:32 -0700 (PDT)
Date: Mon, 30 Mar 2026 21:39:31 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Vishnu Saini <vishnu.saini@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 prahlad.valluru@oss.qualcomm.com
Subject: Re: [PATCH] drm/msm/disp/dpu: consider SSPP line width during mode
 valid
Message-ID: <c7xvoopmujdmdar4lr5oghcc4olc72fpfrpe6yq7wrmtqaytjg@iweixftggvbg>
References: <20260328-msm-next-v1-1-12ac4e27c670@oss.qualcomm.com>
 <v37m6z5le4rk56b7pinr5wbi7l7s2bbgkggglx4eog6w7ja77f@lvyxc5tks2bs>
 <acrBL4fF4aiAw8m9@hu-vishsain-blr.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acrBL4fF4aiAw8m9@hu-vishsain-blr.qualcomm.com>
X-Proofpoint-ORIG-GUID: JTz9AIa3plgCMoLtAb-ShXQ0qZM7YRoX
X-Proofpoint-GUID: JTz9AIa3plgCMoLtAb-ShXQ0qZM7YRoX
X-Authority-Analysis: v=2.4 cv=EcXFgfmC c=1 sm=1 tr=0 ts=69cac368 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=-cc8BWXbKmujejAm6N4A:9 a=CjuIK1q_8ugA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMwMDE1NCBTYWx0ZWRfX83f5hRsNWYhu
 SU2/dZWzBR23TVWYAMeYo2tSGFeNyUjKKnhjKLHyMXW+0WqpAsu1GvnOKIcGMEcHCWHy9F83oAS
 9QmifMUUIHlNJ1RxZYZHsbmM2xQTqklijbtgJgXzLK9Ywsw9I1xhh8K+ryRZd49p/7lXcbCi11N
 p/TEWa0ymEw86ahxT0DBPtARdqY3ILiOC1bfjLU+3v9WpDzD63ihSInjnliYoI+qPGdIVTnRWgj
 1gnAJvZqfoDMvYUGBK0YIM7ytkMmjIKpNxXkDUTJVzEL7+3oVh70awW9iaSf4wj4rRqGSl66pcg
 BmBMOZy5rZvf7/XGFxuUafk1m+0OLVa5yY5T89R35BMV5Emj9rGCLtIQzv6OpImIpFG3x3oXU8k
 hZ5P/jDjNIsLZbLp46X7BqBQLifDR1VT03NVVYIXywGajSahiCz47HOJ4eLpv3iD9VsarsOaCxg
 eh4AlK5a9p5C5559gEw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-30_01,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 priorityscore=1501 clxscore=1015 bulkscore=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603300154
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

On Tue, Mar 31, 2026 at 12:00:07AM +0530, Vishnu Saini wrote:
> On Sun, Mar 29, 2026 at 02:24:53AM +0200, Dmitry Baryshkov wrote:
> > On Sat, Mar 28, 2026 at 10:45:35PM +0530, Vishnu Saini wrote:
> > > Few targets have lesser SSPP line width compared to mixer width,
> > > SSPP line width also needs to be considered during mode valid
> > > to avoid failures during atomic_check.
> > 
> > Technically this is not correct. There is no requirement for the
> > planes to cover the whole CRTC. Nor is there a requirement to use only 2
> > rectangles to cover the screen. As such, it is perfectly fine in
> > mode_valid, if CRTC is wider than 2x max_linewidth. It would be an error
> > if the user tries to stretch 2 rectangles in such a case.
> 
> This is to fix an issue with 5k monitor on rb3gen2, since SSPP maxlinewidth is 2400
> it can't cover the whole 5k buffer in left right split mode.
> Do we need to fix it from drm backend by dividing 5k buffer into 2 planes and 
> use 2 pipes in split mode.

Quad pipe is pending for 7.2, most likely. However, I think, instead you
should teach compositor that if the commit fails, it should retry with
the lower resolution (it might require somethi g like -E2BIG from te
commit).

> 4 SSPP rects --> 2 LMs --> 3d_mux --> DP
>  
> > > 
> > > Signed-off-by: Vishnu Saini <vishnu.saini@oss.qualcomm.com>
> > > ---
> > >  drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c | 12 ++++++++----
> > >  1 file changed, 8 insertions(+), 4 deletions(-)
> > > 
> > 
> > -- 
> > With best wishes
> > Dmitry

-- 
With best wishes
Dmitry
