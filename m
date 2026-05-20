Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15FA7CD4F3C
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 13:47:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 644AD10E433;
	Wed, 20 May 2026 13:47:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ir/IJhuK";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DcJXj8Wv";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 274DC10E12E
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 13:47:36 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64K9lfbx266975
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 13:47:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=
 qcppdkim1; bh=AEzwBHnh7dJ0KK/LA0YzrTOcEY0xRPMkPj2SAzGe+44=; b=ir
 /IJhuKDN+Now3D4qwWWFp8btkEtnv+wemcd0iV3tYc0v5PP8bGe5mctmzqGBuFZS
 WPShQ9xKaqIA/amgP1PHlPVKYYD8RzlMeV8jxTBE6uhniUQIb4sh5z4MRM9iV2JV
 5j18Yoi99ipYoiJfoFa8TAsV4XrZbSkj/+F5h/+XPfa9TykZiit4qrsXpsH24q2S
 V0HjcDBsBXDGftInozahGXqZdaSCq9KmHwGuB481pMLRQff+7M1qSpcn5d6U2QdD
 Yp46XmvY0pk9FNiimZXF6DGwLbqscqnF3aOqXo1IcaW5a4Kbjixg7/a5i50k59GA
 iaDMTE8SewsHkBAFi73Q==
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com
 [209.85.160.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9amxrubj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 13:47:35 +0000 (GMT)
Received: by mail-oa1-f70.google.com with SMTP id
 586e51a60fabf-439bb670a3cso4933110fac.2
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 06:47:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779284854; cv=none;
 d=google.com; s=arc-20240605;
 b=cd0L0fxnwPQr+XHOzj/7MjbKQ1vaOj00okFja9KDUGla16gcsSrHCujGeV4kuypbR4
 +Nlw6UAUlK5yfUt+GVB1XkxjSXAzm0Zfhsj5reraH8fXmmEQFcoJyP3vITX2rFU8T4Da
 XNpx56li67fvqdLRGxr+B0v96InDd4a6D2H3WYvcEcXwqf6LWtX9O6+hGFn9PFSEECNP
 7jVrSQCUAY9tMc+CiwqHK/76se0yi/B6ilto/aFTQCnXANCM6B+QWpgLRI3k3jqCrsyp
 e0L8xTHUwgNdsbtsqEBh4I86lJiPuhjCUG6uA1F6Se21X/aZSkPiLuohRYTM0fM11p3T
 M7Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=AEzwBHnh7dJ0KK/LA0YzrTOcEY0xRPMkPj2SAzGe+44=;
 fh=IhZBpqhs02T9C6tsEHw57E5t1cuw3Y4rox2QWdt5RVs=;
 b=LYdJfXuq7RSm8gaprfd5bIaKhgdqx093xfbBGGnkqrs9XFBFhP+ZDe6BR+umxll9G2
 gSdTHBwY6ckgkK02nhkW0HAb19oKgyfiHiw/c1CaRGs0se5UveRGhPBEatcOraHsCNqF
 LKt3QY2xL/rCLKMc/vMHCYCv8tZrtjNLWvZOCxmnYkF2Ee73UbPOKUz/XwCzjZm3KG/i
 4hoh8sW4VBzHBfQTqD/Wa7BKzWAkqEBMbYJhxdfiQ0DPb2jI3TR8m9qy03i6/vYWa459
 4HfEipjt8DUDkndLAlYdnvtBJSYpBUIzlHuWxvBglGgOoAT51083XyEYd3SOwm0Tk0Jr
 4Mtw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779284854; x=1779889654;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=AEzwBHnh7dJ0KK/LA0YzrTOcEY0xRPMkPj2SAzGe+44=;
 b=DcJXj8WvCBONkrEQVx8m7ZjGqyGpmMpbCebl4cVn2jqvJnszRIX5Qbl98D/jTwoNkL
 AslBoe4PJIfgeM88sxtlLyXRHMXmC7TjyilNGpYiVWcu34TwZH98AzuP9pnQCsliJf4K
 yDHIEFif8pPgxkdBwqoJ1ftVJ5CmpPdWUfVZdoKXlwMmk2vr5R/5iq8z/dGKkogFeHkQ
 7YZUbfTjlWwV5SQsH0nToo0DlW8TI0mAUSTOWbD5LQMenIuLxoIyqfArVeObFAIWeNKQ
 whvbFyawGzM3YrZsBuc+l0IBF4ben+ED2RHSSGnAGPnsD5CnxTFT6BsendhMFYV8zgNm
 1cpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779284854; x=1779889654;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AEzwBHnh7dJ0KK/LA0YzrTOcEY0xRPMkPj2SAzGe+44=;
 b=PQaV7Qy+kE7azmLLdamW+zqoUHc316ZAWIRjQdV3G1I3EYBJFK2yt7H7mlhtCycgbO
 G4aI94xJW8LD+vAqJufYyaXnfCiWjYzj4ZXsjWTy/GyngXNtt3Vk3dKy3ph+4YYCE2gD
 vr96qbAj3bcH2y4KVuqrXLRWnQ8GwGNh5thG2sUaGeCjfInWUYFj15uwsdbcLHyXBu+9
 E+kBdrENWXkjLQO28AGdjIem7YgY7bL/WZtclFdU0oaa6WO6h8cxZVNnLfexTQ07F4ht
 yEQAPIPQqj8/B3fkY0cATdYJHzkwxE/vUsICJNr8fZIOUpjnTwBPCrBsTbzdI/L9khYH
 eT3w==
X-Gm-Message-State: AOJu0YwKj8pilFcnYfPDVfl0oxRPnfLE2nboxYej2lLTauIsJJaV9P+j
 eDVBjVB4sVFnSDi8LWcKclqePG1kiyOUEu4FSRyeysC+D9ovlEIEsf02/SV2CjWLENsT0YNp3NZ
 x27tuBgI9NKja28OG8f1nUd1kKE7T0Wtbz9xt4ou6dRI54nsvZRmowCcxAgUq4DbeObajeUFYsn
 O9jQh6wklQLfkkdaGb4NIR2zDMb7NRgBOoQAGXFitqHwNPAg==
X-Gm-Gg: Acq92OES1EZmLj+FJYQ6fmymC+yHHigXDxktPD5eYBUb3bWV3KZK222RiZ6GfgYz79v
 kxFE+qyWm275oMZKQFdMek5VsAe1gI6hylSn1tvYIwdQYhD/ozft8Bu4IB6HDGxJNc1dyYCgfyb
 3ULgVgj7KO1QDvATpIZPnAmxryiXmHz85PpxsUflQUJGkEVjlF9zrvcOaHm1AYr7dGBH/amVjtW
 XO5e3yTTzLTpuyVZYMS1zlQd5EeVAE+UURacqaSHiWJ4oip
X-Received: by 2002:a05:6870:2c41:b0:439:f46f:c3e6 with SMTP id
 586e51a60fabf-43a2de0c518mr15920035fac.36.1779284854603; 
 Wed, 20 May 2026 06:47:34 -0700 (PDT)
X-Received: by 2002:a05:6870:2c41:b0:439:f46f:c3e6 with SMTP id
 586e51a60fabf-43a2de0c518mr15919994fac.36.1779284854130; Wed, 20 May 2026
 06:47:34 -0700 (PDT)
MIME-Version: 1.0
References: <20260518190735.16236-1-robin.clark@oss.qualcomm.com>
 <20260518190735.16236-6-robin.clark@oss.qualcomm.com>
 <b4787a2b-c1db-4c0c-8c58-fe60fed83cfb@oss.qualcomm.com>
 <CACSVV01srddm1569SStsdBg_L_JG79sPgORokNUw8odgyix=pA@mail.gmail.com>
In-Reply-To: <CACSVV01srddm1569SStsdBg_L_JG79sPgORokNUw8odgyix=pA@mail.gmail.com>
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Wed, 20 May 2026 06:47:22 -0700
X-Gm-Features: AVHnY4L2W2iyJl0xEtVcL3iOFbzIH1hsMF3IpZHMa3awxKpfgFecbH9ma0VO5qg
Message-ID: <CACSVV01UwdB+O6=h-3vVmeiyBFMYCT6HTrcF+Pc8CwSpTSFcaw@mail.gmail.com>
Subject: Re: [PATCH v7 05/16] drm/msm/registers: Add perfcntr json
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Anna Maniscalco <anna.maniscalco2000@gmail.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Konrad Dybcio <konradybcio@kernel.org>,
 open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: 2KaSqGyAfTZXA6EJwj3Nme5F4OvOJQPO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDEzNCBTYWx0ZWRfX5HKIfpc4k2NP
 45PCYfhXECXbSSkgr+Sb/Sm7L4aUGQm6ZSwBAXVe21XhBPt4q69ULIyxmneCqMyZYIrAgthuOXJ
 73tJJxw4eq6q8LtPvUdb4KN1l75VQz74w2tZ/m0CQ1rVHEBlnHoxZ9A8x2JskMjpFzrwxfZL1ll
 d/7XL13UH8OvvyTAt91S4/UH/as8IwNUqOLPsfnbkFj7wM1z5Q9VS9cZBLp1MYweiloMOFm+XJI
 2oI3L/F+X1LEX6xj8dmzyroITIzLj4SqX9+QpVou5ZqIX80s9yuLdNKfVcJZ/Kpg7deUzoZA2Ia
 2DKjg5eLNVYWejqXDL9Mec4Nd8d7VGgCDAddP1ZA2D01zslcZrWCCYOqZR7Skd1fRFiDa7Av/G6
 29EEggH+fCBoctL0KhewgaAyndDV4GhlJQWTkALpwUfzGQ7kXZrry9jblL2MADZg3gXXPycmRu6
 Z2yIDQ3tDlkYXUnvWqg==
X-Authority-Analysis: v=2.4 cv=TO11jVla c=1 sm=1 tr=0 ts=6a0dbb77 cx=c_pps
 a=nSjmGuzVYOmhOUYzIAhsAg==:117 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8
 a=BJRrLYK1mc_FFp4VC2gA:9 a=8f1wxSZkJpRnjI3K:21 a=QEXdDO2ut3YA:10
 a=1zu1i0D7hVQfj8NKfPKu:22
X-Proofpoint-ORIG-GUID: 2KaSqGyAfTZXA6EJwj3Nme5F4OvOJQPO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 clxscore=1015 lowpriorityscore=0
 impostorscore=0 suspectscore=0 spamscore=0 adultscore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605200134
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
Reply-To: rob.clark@oss.qualcomm.com
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On Wed, May 20, 2026 at 5:30=E2=80=AFAM Rob Clark <rob.clark@oss.qualcomm.c=
om> wrote:
>
> On Wed, May 20, 2026 at 1:36=E2=80=AFAM Akhil P Oommen <akhilpo@oss.qualc=
omm.com> wrote:
> >
> > On 5/19/2026 12:36 AM, Rob Clark wrote:
> > > Pull in perfcntr json and wire up generation of perfcntr tables.
> > >
> > > Sync from mesa commit d2c4653ee953 ("freedreno/registers: Add gen8 pe=
rfcntrs")
> > >
> > > Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
> > > Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> > > Reviewed-by: Anna Maniscalco <anna.maniscalco2000@gmail.com>
> > > ---
> > >  drivers/gpu/drm/msm/Makefile                  |  25 +-
> > >  drivers/gpu/drm/msm/msm_perfcntr.h            |  48 ++++
> > >  .../msm/registers/adreno/a2xx_perfcntrs.json  | 109 ++++++++
> > >  .../msm/registers/adreno/a5xx_perfcntrs.json  | 128 ++++++++++
> > >  .../msm/registers/adreno/a6xx_perfcntrs.json  | 105 ++++++++
> > >  .../msm/registers/adreno/a7xx_perfcntrs.json  | 228 ++++++++++++++++=
+
> > >  .../msm/registers/adreno/a8xx_perfcntrs.json  | 240 ++++++++++++++++=
++
> > >  7 files changed, 882 insertions(+), 1 deletion(-)
> > >  create mode 100644 drivers/gpu/drm/msm/msm_perfcntr.h
> > >  create mode 100644 drivers/gpu/drm/msm/registers/adreno/a2xx_perfcnt=
rs.json
> > >  create mode 100644 drivers/gpu/drm/msm/registers/adreno/a5xx_perfcnt=
rs.json
> > >  create mode 100644 drivers/gpu/drm/msm/registers/adreno/a6xx_perfcnt=
rs.json
> > >  create mode 100644 drivers/gpu/drm/msm/registers/adreno/a7xx_perfcnt=
rs.json
> > >  create mode 100644 drivers/gpu/drm/msm/registers/adreno/a8xx_perfcnt=
rs.json
> > >
> >
> > << snip >>
> >
> > > diff --git a/drivers/gpu/drm/msm/registers/adreno/a6xx_perfcntrs.json=
 b/drivers/gpu/drm/msm/registers/adreno/a6xx_perfcntrs.json
> > > new file mode 100644
> > > index 000000000000..8bb31820479e
> > > --- /dev/null
> > > +++ b/drivers/gpu/drm/msm/registers/adreno/a6xx_perfcntrs.json
> > > @@ -0,0 +1,105 @@
> > > +{
> >
> > RBBM and CMP groups are missing here.
>
> Yes, so far we only support the counters that mesa has been using.
> There are some missing.  Although RBBM and CMP look straightforward to
> add.

Oh, actually, it looks like we need to use RBBM_PERFCTR_LOAD_VALUE on
a6xx gen1/gen2.  So I'll leave out RBBM until we have a way of dealing
with mid-gen counter changes.  But adding CMP looks doable.

BR,
-R

>
> > > +    "chip": "A6XX",
> > > +    "groups": [
> > > +        {
> > > +            "name": "CP",
> > > +            "num": 14,
> > > +            "reserved": [ 0 ],
> > > +            "select": "CP_PERFCTR_CP_SEL",
> > > +            "counter": "RBBM_PERFCTR_CP",
> > > +            "countable_type": "a6xx_cp_perfcounter_select"
> >
> > << snip >>
> >
> > > diff --git a/drivers/gpu/drm/msm/registers/adreno/a7xx_perfcntrs.json=
 b/drivers/gpu/drm/msm/registers/adreno/a7xx_perfcntrs.json
> > > new file mode 100644
> > > index 000000000000..e60aab1862ec
> > > --- /dev/null
> > > +++ b/drivers/gpu/drm/msm/registers/adreno/a7xx_perfcntrs.json
> > > @@ -0,0 +1,228 @@
> > > +{
> > > +    "chip": "A7XX",
> > > +    "groups": [
> > > +        {
> > > +            "name": "CP",
> > > +            "num": 14,
> > > +            "reserved": [ 0 ],
> > > +            "select": "CP_PERFCTR_CP_SEL",
> > > +            "counter": "RBBM_PERFCTR_CP",
> > > +            "countable_type": "a7xx_cp_perfcounter_select"
> > > +        },
> > > +        {
> > > +            "name": "RBBM",
> > > +            "num": 4,
> > > +            "select": "RBBM_PERFCTR_RBBM_SEL",
> > > +            "counter": "RBBM_PERFCTR_RBBM",
> > > +            "countable_type": "a7xx_rbbm_perfcounter_select"
> > > +        },
> > > +        {
> > > +            "name": "PC",
> > > +            "pipe": "BR",
> > > +            "num": 8,
> > > +            "select": "PC_PERFCTR_PC_SEL",
> > > +            "counter": "RBBM_PERFCTR_PC",
> > > +            "countable_type": "a7xx_pc_perfcounter_select"
> > > +        },
> > > +        {
> > > +            "name": "VFD",
> > > +            "pipe": "BR",
> > > +            "num": 8,
> > > +            "select": "VFD_PERFCTR_VFD_SEL",
> > > +            "counter": "RBBM_PERFCTR_VFD",
> > > +            "countable_type": "a7xx_vfd_perfcounter_select"
> > > +        },
> > > +        {
> > > +            "name": "HLSQ",
> > > +            "pipe": "BR",
> > > +            "num": 6,
> > > +            "select": "SP_PERFCTR_HLSQ_SEL",
> > > +            "counter": "RBBM_PERFCTR_HLSQ",
> > > +            "countable_type": "a7xx_hlsq_perfcounter_select"
> > > +        },
> > > +        {
> > > +            "name": "VPC",
> > > +            "pipe": "BR",
> > > +            "num": 6,
> > > +            "select": "VPC_PERFCTR_VPC_SEL",
> > > +            "counter": "RBBM_PERFCTR_VPC",
> > > +            "countable_type": "a7xx_vpc_perfcounter_select"
> > > +        },
> > > +        {
> > > +            "name": "TSE",
> > > +            "pipe": "BR",
> > > +            "num": 4,
> > > +            "select": "GRAS_PERFCTR_TSE_SEL",
> > > +            "counter": "RBBM_PERFCTR_TSE",
> > > +            "countable_type": "a7xx_tse_perfcounter_select"
> > > +        },
> > > +        {
> > > +            "name": "RAS",
> > > +            "pipe": "BR",
> > > +            "num": 4,
> > > +            "select": "GRAS_PERFCTR_RAS_SEL",
> > > +            "counter": "RBBM_PERFCTR_RAS",
> > > +            "countable_type": "a7xx_ras_perfcounter_select"
> > > +        },
> > > +        {
> > > +            "name": "UCHE",
> > > +            "num": 12,
> >
> > A740 and newer has 24 counters
>
> We don't yet have a way of dealing with mid-gen changes like this..  I
> have some ideas, but nothing implemented yet.  The same situation
> comes up for a8xx, where some new counter groups are added.
>
> > > +            "select": "UCHE_PERFCTR_UCHE_SEL",
> > > +            "counter": "RBBM_PERFCTR_UCHE",
> > > +            "countable_type": "a7xx_uche_perfcounter_select"
> > > +        },
> >
> > << snip >>
> >
> > > diff --git a/drivers/gpu/drm/msm/registers/adreno/a8xx_perfcntrs.json=
 b/drivers/gpu/drm/msm/registers/adreno/a8xx_perfcntrs.json
> > > new file mode 100644
> > > index 000000000000..503b113df397
> > > --- /dev/null
> > > +++ b/drivers/gpu/drm/msm/registers/adreno/a8xx_perfcntrs.json
> > > @@ -0,0 +1,240 @@
> > > +{
> > > +    "chip": "A8XX",
> > > +    "groups": [
> > > +        {
> > > +            "name": "CP",
> > > +            "num": 14,
> > > +            "reserved": [ 0 ],
> > > +            "select": "CP_PERFCTR_CP_SEL",
> > > +            "counter": "RBBM_PERFCTR_CP",
> > > +            "countable_type": "a8xx_cp_perfcounter_select"
> > > +        },
> > > +        {
> > > +            "name": "RBBM",
> > > +            "num": 4,
> > > +            "select": "RBBM_PERFCTR_RBBM_SEL",
> > > +            "slice_select": [ "RBBM_SLICE_PERFCTR_RBBM_SEL" ],
> > > +            "counter": "RBBM_PERFCTR_RBBM",
> > > +            "countable_type": "a8xx_rbbm_perfcounter_select"
> > > +        },
> > > +        {
> > > +            "name": "PC",
> > > +            "pipe": "BR",
> > > +            "num": 8,
> > > +            "select": "PC_PERFCTR_PC_SEL",
> > > +            "slice_select": [ "PC_SLICE_PERFCTR_PC_SEL" ],
> > > +            "counter": "RBBM_PERFCTR_PC",
> > > +            "countable_type": "a8xx_pc_perfcounter_select"
> > > +        },
> > > +        {
> > > +            "name": "VFD",
> > > +            "pipe": "BR",
> > > +            "num": 8,
> > > +            "select": "VFD_PERFCTR_VFD_SEL",
> > > +            "counter": "RBBM_PERFCTR_VFD",
> > > +            "countable_type": "a8xx_vfd_perfcounter_select"
> > > +        },
> > > +        {
> > > +            "name": "HLSQ",
> > > +            "pipe": "BR",
> > > +            "num": 6,
> > > +            "select": "SP_PERFCTR_HLSQ_SEL",
> > > +            "slice_select": [ "SP_PERFCTR_HLSQ_SEL_2" ],
> > > +            "counter": "RBBM_PERFCTR_HLSQ",
> > > +            "countable_type": "a8xx_hlsq_perfcounter_select"
> > > +        },
> > > +        {
> > > +            "name": "VPC",
> > > +            "pipe": "BR",
> > > +            "num": 6,
> > > +            "select": "VPC_PERFCTR_VPC_SEL",
> > > +            "slice_select": [ "VPC_PERFCTR_VPC_SEL_1", "VPC_PERFCTR_=
VPC_SEL_2" ],
> > > +            "counter": "RBBM_PERFCTR_VPC",
> > > +            "countable_type": "a8xx_vpc_perfcounter_select"
> > > +        },
> > > +        {
> > > +            "name": "TSE",
> > > +            "pipe": "BR",
> > > +            "num": 4,
> > > +            "select": "GRAS_PERFCTR_TSE_SEL",
> > > +            "slice_select": [ "GRAS_PERFCTR_TSEFE_SEL" ],
> > > +            "counter": "RBBM_PERFCTR_TSE",
> > > +            "countable_type": "a8xx_tse_perfcounter_select"
> > > +        },
> > > +        {
> > > +            "name": "RAS",
> > > +            "pipe": "BR",
> > > +            "num": 4,
> > > +            "select": "GRAS_PERFCTR_RAS_SEL",
> > > +            "counter": "RBBM_PERFCTR_RAS",
> > > +            "countable_type": "a8xx_ras_perfcounter_select"
> > > +        },
> > > +        {
> > > +            "name": "UCHE",
> > > +            "num": 12,
> >
> > "num": 24,
>
> ack
>
> >
> > > +            "select": "UCHE_PERFCTR_UCHE_SEL",
> > > +            "counter": "RBBM_PERFCTR_UCHE",
> > > +            "countable_type": "a8xx_uche_perfcounter_select"
> > > +        },
> > > +        {
> > > +            "name": "TP",
> > > +            "pipe": "BR",
> > > +            "num": 12,
> > > +            "select": "TPL1_PERFCTR_TP_SEL",
> > > +            "counter": "RBBM_PERFCTR_TP",
> > > +            "countable_type": "a8xx_tp_perfcounter_select"
> > > +        },
> > > +        {
> > > +            "name": "SP",
> > > +            "pipe": "BR",
> > > +            "num": 24,
> > > +            "select": "SP_PERFCTR_SP_SEL",
> > > +            "counter": "RBBM_PERFCTR_SP",
> > > +            "countable_type": "a8xx_sp_perfcounter_select"
> > > +        },
> > > +        {
> > > +            "name": "RB",
> > > +            "pipe": "BR",
> > > +            "num": 8,
> > > +            "select": "RB_PERFCTR_RB_SEL",
> > > +            "counter": "RBBM_PERFCTR_RB",
> > > +            "countable_type": "a8xx_rb_perfcounter_select"
> > > +        },
> > > +        {
> > > +            "name": "VSC",
> > > +            "num": 2,
> > > +            "select": "VSC_PERFCTR_VSC_SEL",
> > > +            "counter": "RBBM_PERFCTR_VSC",
> > > +            "countable_type": "a8xx_vsc_perfcounter_select"
> > > +        },
> > > +        {
> > > +            "name": "CCU",
> > > +            "pipe": "BR",
> > > +            "num": 5,
> > > +            "select": "RB_PERFCTR_CCU_SEL",
> > > +            "counter": "RBBM_PERFCTR_CCU",
> > > +            "countable_type": "a8xx_ccu_perfcounter_select"
> > > +        },
> > > +        {
> > > +            "name": "LRZ",
> > > +            "pipe": "BR",
> > > +            "num": 4,
> > > +            "select": "GRAS_PERFCTR_LRZ_SEL",
> > > +            "counter": "RBBM_PERFCTR_LRZ",
> > > +            "countable_type": "a8xx_lrz_perfcounter_select"
> > > +        },
> > > +        {
> > > +            "name": "CMP",
> >
> > "pipe": "BR",
>
> ack
>
> BR,
> -R
