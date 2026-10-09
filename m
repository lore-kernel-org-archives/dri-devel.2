Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89FECCA9EBB
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 23:09:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E4166112316;
	Fri,  9 Oct 2026 23:09:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="X24Q1Fp3";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JTfqz2Hj";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 76554112316
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 23:09:09 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 699KhV4Y2857736
 for <dri-devel@lists.freedesktop.org>; Fri, 9 Oct 2026 23:09:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 xSGqqaD+HqzjVuxc27KH2WeAXhL0TG4E9SeBeSeo+MI=; b=X24Q1Fp3tHgtoz9o
 QU2y5YDvMjRhLtw64Xf3UHOYje2TYLNz9l8TIy92UMIhKIzxwopofVHIB2MRCBbI
 qfm/Zd0Vg4UQ9dT/yv/L6PInM0TMntIELb/SjUi/DQWsbkRAJ7X8SPC9Bzim6P/b
 k0dDyjsIpAwLDDH3mo5cnR1yiF8cogHk6he016tRiKxuTun3QkoaOELmk5ft9Fgk
 uISv6pNlqWSXMwTVeN3sCrxEY8f7c4D6r7kxhBrvWHE9zU5F1AMKqdQaC/IJwwAh
 PQfO2ph8iZv00hQMC2/dUuO65akws/cqi3+rneo32h1LNXr0yRzZL+ffR0ZQUEOX
 R9gRvg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h74t890yw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 09 Oct 2026 23:09:08 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93e46b4b700so33120985a.1
 for <dri-devel@lists.freedesktop.org>; Fri, 09 Oct 2026 16:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791587348; x=1792192148;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=xSGqqaD+HqzjVuxc27KH2WeAXhL0TG4E9SeBeSeo+MI=;
 b=JTfqz2Hj47lKkGp1rbesKgJN6XQ9akj3J1UqK/7CNF0I+2CIZ3nfE3U8JH7Gp6uWCO
 q5E7Fc+NNoRRfnrgaxBbskLqcpfQwvF7L/4P/+ma7Tpzvvv5yeCGnezoFtsevt7acY4B
 3KKoqlAPoqp8rzxwLzykA2aAdQTOqjczqoazlTwi6KrXmFDSnr9GVyJCyKUezqfi0Kut
 oMYdkNXefT3XhYmiFroDdz1VYUGZP/cWyccMkISYcmiMyOFdvVzfOKB9yFa89+kXACO6
 /mhBTh4JUB9aRVCPkaJXOwE/2YIqpXMBHkEvstj00q4dmCVQJhb/qaMXVb9cFdjwueQE
 g9og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791587348; x=1792192148;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=xSGqqaD+HqzjVuxc27KH2WeAXhL0TG4E9SeBeSeo+MI=;
 b=Eez4DtQlvXrwkJ8e7sma1vfUSRwM4QRinbWq0nq7wc+qUBnjB5y0iVqhKGewOuinpy
 N/jM1HHqL1olF6IS3QqbdOaUjdepy1dUCV+r19ZelSCb8YhEPi8PtzjmjSD0qdkhOHtj
 v4nIJ+3rrcSmEDrxvTSfvzArwllmf9dKnxKDk9ZjToCQkrY8hA33AQLmnxxp4m3W2+ii
 umzfolxNYZqftxBxE/IBMq9lSUTutPRi6rxVTHZ/J1yHqF08Ys7D9U3llsj8j/o4Jl70
 fjRMYs2OUQb5clmKP6V2IGEWMvKyrRCf3QB49351txwFzOWQxT2Sd60VgFl+TIJE50if
 iVBg==
X-Forwarded-Encrypted: i=1;
 AKwUvBz9LvnyZcCXUNB8FyOCrX/ge3wESNun8gYzJD5rdkd7/M+BWE9wBukyHNUImXfbsdbekIoAzqu6jf0=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYK/Tb+JLv450kbMYJMeqks/+Uy2qJaK8OiFzOTLmPjCODtO8+CV
 YRvjmVXZNn9fgc4duPJt34HWT4GMtytOr4AMqRqMdYCWlW/sIZzTfrTn/e/wv+VFFvH7atzfGYR
 OPKdkjgkfJ3bTaty0QKT9zsP5di+tYASA04wLSF5rR/dsck8xtKujA0bcho7f5UPJz/5iEOk=
X-Gm-Gg: AYBFou1cvpkwKQvC6h7DtWRfRvd0yxb2NbmC0F41MdLN9nYO55c8aLfziX5GbXO7ibb
 oDUWB7AficFjya8wbZVGrz3uhXtjv9jCjKRiwNhZjaDI4JThxqmt/qqi0Ut5h4IHG7pS7lbfHbG
 mBtm9LkZL/gx3V1AMEUj8P4ufBAJITRjH9czUMON/QrO695KiGy6Jrc9Tq+iKVzqhjFpuOmFZUf
 /9orazV1LhR4HvKzh3Iy4E7SJkjv4es83SzY4ua/hIBf4fcyeDgsj0mSmuUAdQIqrOFhBGIisEY
 v3rIgV8H56ILjT4Xtvk+Zf0qc+3sU9J9Qje0rJ/CtWa3eJCeLD8N3dgaIZxXjGXusk+8i3ePlIC
 okEmHJ8lWWv0d3xnYUh2li8aNpnNzvm7ZJZkCuf6L4XTENEnBiBs9apbrobYAjr1f+TxMwf/FAw
 xokACzORLgKC+s
X-Received: by 2002:a05:620a:800f:b0:93e:c12c:9b70 with SMTP id
 af79cd13be357-93ec12c9f31mr442671685a.75.1791587347530; 
 Fri, 09 Oct 2026 16:09:07 -0700 (PDT)
X-Received: by 2002:a05:620a:800f:b0:93e:c12c:9b70 with SMTP id
 af79cd13be357-93ec12c9f31mr442667985a.75.1791587347039; 
 Fri, 09 Oct 2026 16:09:07 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3a9c3cf5903sm11083321fa.42.2026.10.09.16.09.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Oct 2026 16:09:04 -0700 (PDT)
Date: Sat, 10 Oct 2026 02:09:02 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Rob Clark <rob.clark@oss.qualcomm.com>
Cc: Akhil P Oommen <akhilpo@oss.qualcomm.com>, dri-devel@lists.freedesktop.org,
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Konrad Dybcio <konradybcio@kernel.org>,
 open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] drm/msm/a6xx: Split out a7xx/a8xx device tables
Message-ID: <zsewft5gviv45ks3xvrxoso2vhxa7eeyrxznwhgnnpjjyyngbn@czuyvv2wwdzn>
References: <20261009131927.551319-1-robin.clark@oss.qualcomm.com>
 <20261009131927.551319-3-robin.clark@oss.qualcomm.com>
 <7c9149f5-b1fc-43f1-9f4f-299767c32a90@oss.qualcomm.com>
 <CACSVV01j14Ew6BQbW47vzy6OBDcUdODBT+J7DqBsB2geJRnC-Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACSVV01j14Ew6BQbW47vzy6OBDcUdODBT+J7DqBsB2geJRnC-Q@mail.gmail.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDA5MiBTYWx0ZWRfX0Io6xu5kcSPP
 B19NWTuBJuvkcQnbkOmaN3kxKGIVnyCLHGVnGuK8PP44C1mkNlyNbOkAbLTRIgaqPmgnWY2rtrP
 iWX9CG1+fa8gyv1RbyyrU31XL+1m3RE=
X-Proofpoint-ORIG-GUID: 40v2-G1Xe5-9tplYzNpyZ3xqATjwsb4f
X-Authority-Analysis: v=2.4 cv=D9jSufRj c=1 sm=1 tr=0 ts=6ac97414 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=3T64X_j-PjA9zNe75B4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: 40v2-G1Xe5-9tplYzNpyZ3xqATjwsb4f
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDA5MiBTYWx0ZWRfX2SIBQJdRW7Mg
 WLNNqpUVdl4bkOAIcAd3/s2HHw0jxMFGPMVpdSxZIpl8WcL+wABLo9wotV/A59oVVbcMx4MP0K6
 88pXpia6+1vckwc+ErJIO6Ee4oTzWkkKp9OyQCCOz8RIrP8og7tap4fpv2h5Jr2UhF2zkXefQT8
 Bn6HgehLbYw+jGwGrCa0W49BUEc6UqAYJ9qhbvNN1zrEYRV5sFohmdddybqNyCCSagfVcGMSvF+
 hB6Wt0yTiHHua6I96kG+w0FcUJ2HrxB354gqlyUhXRTzSrvnJUiYQHpVq/YQEM8yLpEvzrLEt3G
 a3TofD8TkowfcsyTx/JnMG2i3xBEtN4KIDO/rJPdhKmwXY6PX7es/Sl7ltrOueZMVCwwO1mHhf3
 x/pUPbpSzh1vfPqV/GqQ/zIUDOT8u08K/CG8pX0oLeyOBQkk9X53qUJwzdn+XPsYsU7YSmgIBgX
 y8vBJc23yCbvZAgJajQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_06,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 phishscore=0 impostorscore=0 bulkscore=0
 suspectscore=0 clxscore=1015 priorityscore=1501 adultscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610090092
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

On Fri, Oct 09, 2026 at 01:38:19PM -0700, Rob Clark wrote:
> On Fri, Oct 9, 2026 at 11:55 AM Akhil P Oommen <akhilpo@oss.qualcomm.com> wrote:
> > On 10/9/2026 6:49 PM, Rob Clark wrote:
> > > This way we can start including generated tables for a8xx GPU snapshot
> > > in the device table (without having conflicts with earlier gens if we
> > > eventually try to retrofit this approach, or later gens in the future).
> > >
> > > Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
> > > ---
> > > diff --git a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
> > > index b44b0fd916aa..66c44cbc4d55 100644
> > > --- a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
> > > +++ b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
> > > @@ -670,7 +670,7 @@ static const u32 a690_protect_regs[] = {
> > >  };
> > >  DECLARE_ADRENO_PROTECT(a690_protect, 48);
> > >
> > > -static const struct adreno_reglist a640_gbif[] = {
> > > +const struct adreno_reglist a640_gbif[] = {
> >
> > Is the removal of 'static' intentional here? I think some static checkers will
> > complain.
> 
> Yes, but alternatively we could just have a 2nd copy in
> a7xx_catalog.c, since it isn't that big of a table.  It was the one
> awkward aspect of the split.

I think it might be a better option.


-- 
With best wishes
Dmitry
