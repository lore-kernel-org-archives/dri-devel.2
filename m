Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD6DAF506D9
	for <dri-devel@archiver.kernel.org>; Mon, 16 Mar 2026 14:20:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 21D0210E07C;
	Mon, 16 Mar 2026 14:20:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="CWElH33/";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QuBi430f";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 79E7610E1B0
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 14:20:09 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62GCKHP33777631
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 14:20:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=TxUHkbY1+uD7pskAtrWbShEG
 9iLQurNswFCw0CeIiec=; b=CWElH33/WF/mCAwDr+5JvaVlolD9X04kd2dehi7b
 jklQymNq7ZTHMogdGT5GcbeEmqelah++bXAyUigLbdbf7iT46jbwJdxMZIRlTvJw
 Nng9hBhuX9oBPrEdykvD7a51IAzNm1TnctOxDKGJYKuVGYz8nMyJLkcg6YSaEmQR
 EskvCVaaCJnB52rkYOrDNJG6kH5TxfaJPs0A01JGhUl96NhMsYRmc4gG/dz3JCy9
 XkO4on1fzHAZt41MooqWoVGY4/yHOA8IFLvxXheMaUS3XIwBf7pmdNhasvF1du7l
 0PuA66cVPW1f4mNMYLiVDm1rv1YRkT8akSyKg0yThWnosw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cw0y7wynj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 14:20:08 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-8cd7de0e161so3264779685a.2
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 07:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773670808; x=1774275608;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=TxUHkbY1+uD7pskAtrWbShEG9iLQurNswFCw0CeIiec=;
 b=QuBi430fgVJ6kSzspjsuJmNuf9p374/rI9tLYp6Lj0FCdikffYU57NFNw8Zbghhac3
 R5pQ6+yJV83ejaGUf8MSt3HXDI4RQNHLTvGxqp5zCgoX6NgA7Be3nHI+YO1Ryjl74ajC
 UhoR+HpPk/rnaFXTv/qORPUBxKjhL7obQyi7CQ6BgWjX8fBKLkqN7wmjtLLeI5aGvEi0
 QSdEni62rIqa37KXCBIcSjLawPsGMwoNKshVZ8iDQ44S5GIEXfAPt6OSWIm6rpjuMYOh
 fhxSk+3MygC5JjirZzTKJZrBWDzF5PKZe20vIAjPtL8wUqnxnGbbbe7ISv8dWX1TRyfr
 Cx/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773670808; x=1774275608;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TxUHkbY1+uD7pskAtrWbShEG9iLQurNswFCw0CeIiec=;
 b=EoBq37kxisHHoPd/KZkw9cqVHv6GrezISb6j6wRCly/+/A8ZcBkkV2ngBMKGU5ETDK
 kDwNwXUqpRXH8Y4PrgB8sFUB+ufHDX2rKhHBeHkye9iTY25Jg3q5WSxOPs7T6ir5y8YM
 gk8R/OPwd5D037NpXL0S4FLm9VWtFIU2v+MSDAoCZKmWVDg5szA8QdR36Yg75HSodYK4
 tXXF7ClNcGeaQYnReSTAkXTqhFh0TK/z3f9MMHEpfB2hTpAYw5VEucumf49rdAwC6qyo
 LeFSj7Uk8OKH+0kmUNw1n8JSQBEqv0XrRWO0LMo55iW1Eh8m3g7Xdl7hVnWBUA+kw/TD
 DhzQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUa733pGMAcUDvAP/ym8R9f6C6W26LcwQIrS2erBD9uOaYBB878e/lHU287bnUozONSouPRLylD1Gg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwmoQ64VBeEBF1MugN5FX+9ezgihfwsUmj/7jTURj17zn2wtOVU
 uVA7zRjqphP5QxDq9r+oF6IpZI4o7Laqa1AOD2e2dRW0/FeXUcjLCq3Qoz99bJi7RUYHTCsJYI9
 5RGu/nhYwtiGm28yFT6hKEYnCTkt3VC2auP+TyKbuug4HlDeysf9SBrHTnKM3OOlclIt1YPs=
X-Gm-Gg: ATEYQzzPwAirsOZEkczNyQlTHcXRQZSRFUMEz2KES0+nzPXTgb5z4R8BJQkGXhMZlAQ
 9qUizFhfBJKROcJzBiP6OUlanG77fwekHo9WeqZyDxT9QUInV/3giEdnBi/f2RmuRnlNx0V+v21
 HNRElp1K74ElSbPrgSc27DvKi410OaCWIUYu8tBRLyirIBzujbW4xwMTwP7KGcPU8qFaUFyTKl5
 6oKjkPOcnter2rcCeGJ4iWQ7m9bCjyRtNedqTOGAzJak4UitXD/yugtEOwjR0iRD/XbSuZmCe98
 azr8/C0qr5OPTK4ifZWJ75uAlX25nZRfna975fwOUhgmLxfTSithsUcwzQTxDMFYbgKHaf77mWr
 WqXezX/nWicIFE5iB6a4cLo3kQKnv1adohpXW7YKWHu93pEZc0bHkSnwVYTrKVqCvPvsBqS7ZuI
 prhepOvwKHqIE7KEsT8IR60KYVA9X9CoM1Sd8=
X-Received: by 2002:a05:620a:470c:b0:8cd:9a1d:4fb with SMTP id
 af79cd13be357-8cdb5a1c9a3mr1597400585a.10.1773670807581; 
 Mon, 16 Mar 2026 07:20:07 -0700 (PDT)
X-Received: by 2002:a05:620a:470c:b0:8cd:9a1d:4fb with SMTP id
 af79cd13be357-8cdb5a1c9a3mr1597390885a.10.1773670806935; 
 Mon, 16 Mar 2026 07:20:06 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a15602e18fsm3431479e87.22.2026.03.16.07.20.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2026 07:20:05 -0700 (PDT)
Date: Mon, 16 Mar 2026 16:20:04 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 17/27] drm/msm/mdss: use new helper to set amsbc
Message-ID: <igwmdjbd43xdhab7vgqn2oaxh6yddbp5qe4zmh3xjyq7ix6hlo@itpftzhxkxtm>
References: <20260312-ubwc-rework-v3-0-b7e8f800176a@oss.qualcomm.com>
 <20260312-ubwc-rework-v3-17-b7e8f800176a@oss.qualcomm.com>
 <19b36a86-12c7-4710-8f80-5e27c9c00e3c@oss.qualcomm.com>
 <uahvm7kvu2vi6o6mwznn5eqzqqscxmfetl4c3q3xa2eryg6ode@ltxfpjmqbrrt>
 <fe151ffe-aea2-429d-a725-4697381c4a93@oss.qualcomm.com>
 <hmamyk4lzo6ekswqvjlen6hc5stny2ucj5fxy5g2tvl3fqpbq2@ux7l4j4drm6z>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <hmamyk4lzo6ekswqvjlen6hc5stny2ucj5fxy5g2tvl3fqpbq2@ux7l4j4drm6z>
X-Proofpoint-GUID: EhqA18J20aBBHuowpdUykJo9BcwARcqh
X-Proofpoint-ORIG-GUID: EhqA18J20aBBHuowpdUykJo9BcwARcqh
X-Authority-Analysis: v=2.4 cv=D9xK6/Rj c=1 sm=1 tr=0 ts=69b81198 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=DwMc8GUcov4CxI8nvuUA:9 a=CjuIK1q_8ugA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDEwNyBTYWx0ZWRfX7Orc1UhqBHIF
 Ar2F+uF5bgw5S2kBs6T4MrTSdH70HR9f4xgaxxszE2DtVjoJ3cq2ORImjXHelgaJsVsX3N9fxGK
 mVn+teBMl4uOu4jTdGA891LJFvjs5P7ZyC3pNa6qH5ITiVq2AzNJYeeN0uFAPijfJOF+gox6ak4
 8L4hPEGl68OTlS0nPVKUPLM7d56m/vtB81qaowVDAlhPCb87jmeMkioamKU3GeE4B/nxs2uCEPS
 lRjrsQBnDC5bPulV0TWMDLFXNKjBHJHHixLmLi46kgDMkXT94wU/lTHbd93nhD5ZgDIoWl9jvaV
 G80ivO+OdFKUWLd8IdGiFQSPI3G9vUVoRR9YtL4uCBc8P5GPezVM36xFb33JD2mG2KTgsFC3g9o
 7HQDzNfJt5ZECxP2Ducp7yuYYkwlo+flO5YB7fVxz6Is6iMmABcHYmfeaOahDKLhP/+Uh5uIG1B
 wAGrdozBPxzPgUouwtQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_04,2026-03-16_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 lowpriorityscore=0 spamscore=0 suspectscore=0
 clxscore=1015 bulkscore=0 priorityscore=1501 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603160107
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

On Mon, Mar 16, 2026 at 04:04:46PM +0200, Dmitry Baryshkov wrote:
> On Mon, Mar 16, 2026 at 11:08:00AM +0100, Konrad Dybcio wrote:
> > On 3/13/26 3:26 PM, Dmitry Baryshkov wrote:
> > > On Fri, Mar 13, 2026 at 11:19:59AM +0100, Konrad Dybcio wrote:
> > >> On 3/12/26 2:29 PM, Dmitry Baryshkov wrote:
> > >>> Use freshly defined helper instead of checking the UBWC version
> > >>> directly.
> > >>>
> > >>> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> > >>> ---
> > >>>  drivers/gpu/drm/msm/msm_mdss.c | 2 +-
> > >>>  1 file changed, 1 insertion(+), 1 deletion(-)
> > >>>
> > >>> diff --git a/drivers/gpu/drm/msm/msm_mdss.c b/drivers/gpu/drm/msm/msm_mdss.c
> > >>> index ca59bcdde7b2..04efc29f38cd 100644
> > >>> --- a/drivers/gpu/drm/msm/msm_mdss.c
> > >>> +++ b/drivers/gpu/drm/msm/msm_mdss.c
> > >>> @@ -188,7 +188,7 @@ static void msm_mdss_5x_setup_ubwc(struct msm_mdss *msm_mdss)
> > >>>  	if (qcom_ubwc_macrotile_mode(data))
> > >>>  		value |= MDSS_UBWC_STATIC_MACROTILE_MODE;
> > >>>  
> > >>> -	if (data->ubwc_enc_version == UBWC_3_0)
> > >>> +	if (qcom_ubwc_enable_amsbc(data))
> > >>>  		value |= MDSS_UBWC_STATIC_UBWC_AMSBC;
> > >>
> > >> I know it's already there, but fwiw downstream doesn't seem to be
> > >> concerned with toggling AMSBC in MDSS (perhaps incorrectly?)
> > > 
> > > Downstream enables it only for the cases where encoder and decoder
> > > use exactly UBWC 3.0. This is not completely correct as the bit doesn't
> > > exist for MDSS 6.x+. For 5.x this is equivalent to the code from the
> > > patch: enable AMSBC if targeting UBWC >= 3.0 (because MDSS 5.x don't
> > > support UBWC 4.0 or higher).
> > 
> > Right, this seems to indeed be the case
> > 
> > While trying to confirm that, I noticed that some lower-end MDSS 5.x
> > chips (like Talos) report UBWC3 in the register, but the MDSS docs say
> > they're UBWC2 - any idea?
> 
> I don't see a complete pixel format document for Talos, but my guess is
> that one of the blocks (GPU, Venus or Camera) doesn't support UBWC 3.0
> pixel formats. MDSS is just one piece of picture and unfortunately we
> need to use format which is supported by all the blocks.

And after cross-checking the docs, it is really interesting. It really
looks like for those chips we have used the older core for UBWC, but the
registeres were not updated. One more reason not to trust those and to
use the database instead.

-- 
With best wishes
Dmitry
