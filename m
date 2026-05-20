Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23F5DCD5BA4
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 12:30:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8ACA110E441;
	Wed, 20 May 2026 12:30:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Red52nK/";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JB5CK7Va";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ADD2810E442
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 12:30:39 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64K8uah54115174
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 12:30:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=
 qcppdkim1; bh=cRAlnpjqr6bgUfKkNAu3ISqsa9AjttBO7qAkv5Wdtl8=; b=Re
 d52nK/3A0saI9eAg8ShXQyCcd6UfbWKoKbDAPtuLpXkFtLsnc1xms7kU1Jhsj8T0
 2NaTLk5bHm+AJOlkMAS06jSWL/mBqBsMf8WgREy4Rts3vplU+jGxr4LFYMrm6irA
 I7QdyKL9asWuKNP6anWMEOM50eMLpiB8oJVqhnh4fw6jL+NJepaPnID8sRT0s/Kz
 +50ZYCc9RWkk48X130TfSdQgeDLB7K+3TAdaQk4GQQ1oQ4efQ4+yM6jLqRKYSyRr
 ismdfrr+YhAjaIkHUReCWBVlSIG0tgzbKUTgectRvggPttaalmJAf/LNWT80TSMm
 xTutpvKlN8ca5RCw5+Kg==
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e99w0gsfr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 12:30:38 +0000 (GMT)
Received: by mail-oo1-f71.google.com with SMTP id
 006d021491bc7-69b3a3c798dso5572160eaf.1
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 05:30:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779280238; cv=none;
 d=google.com; s=arc-20240605;
 b=RB/y76mDazLkZosjc6xeXYizv+eCLbe0Rd8ZhBtx5wHfV8gy6qnqGbpeQTCIk1XsIs
 Lh8M0ciVgKTAk8M2CS21Pnj2G7fv1j25G0xBw8CLp98K3RQo8T4odJrYQyDBNoB2iP9N
 ghtIH2CI2em4bDu5OEkQs4A7bJD4CqYqX5EvhxRqJcQUuAPHqi39Rs+mmnzYh7Np3Df4
 GerwNXYj9XXM6ZspK/l3AFLhGjktk4en4AnJZroWq4Czw5dr3uZPX/qNmjjt9d2CagST
 i7F73qmcJjWrS3gBdPHV/7yl9bFT4LeCmmJppqehYjKSojYp8jpHrUOX1LYTYVVCN14o
 gbqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=cRAlnpjqr6bgUfKkNAu3ISqsa9AjttBO7qAkv5Wdtl8=;
 fh=IhZBpqhs02T9C6tsEHw57E5t1cuw3Y4rox2QWdt5RVs=;
 b=IhwtrrrTzb31iEyZuGDrIdFQLTr1T5WJD60bcK7PKAW/rbxbdkd0iPr3jtKe2zhSAr
 NpSA8yYyp/mKYmgsSHhmTNU6q1HSDr7wLojB/0ePQGL/42Ung85xqMCOhJxwd/lAH75c
 iMNAx3vJTQ/gGgwBqgxL+0sObdB0l3N2IHIl7daf8wX203GnYkh6eWI6Zgdi4Jg8H7NO
 9VzksBLAaxMS1SErvj/zSw/LX6Y0yVwzKe4Qkbiyd19ofUXfikUfCc84DZN3eZRwlXPv
 mi05cmPKZ3M1G1+vAdf93nbLZQ1AdjQplyGcB78phRACmRG5S6syPx0NQsO1XtacoiFV
 q27A==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779280238; x=1779885038;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=cRAlnpjqr6bgUfKkNAu3ISqsa9AjttBO7qAkv5Wdtl8=;
 b=JB5CK7VapWEF8gVuG6rl6Zo6Y4WcR3o7quSMI/VDyE/+ZacmNW0PeadD1HkKDySv5E
 U654qtRVQ+QmPj0Ngqh+GvuzWIXqoDOxZqATcPTM85RVnWrYUL/+CQt4YwBisn67iAzl
 F9JJk/8gpd3PcKcDTgNtSVh6Gi8clWBomBS6PskDNseYlWeq9z67cacXnxs52wXEbrXL
 d72y8dpN+vldthyUfE4rJh11u/89LI+6jvij44qYx8EaAlnJsOoNhshdW4a6mHguZ5Lj
 uTnCwz4TSnrC+l/mwvG63J59iHdgB0hDLPJ+HUZbc8Te5L9amN2iqRjXIfVv7+dDmUVs
 u9NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779280238; x=1779885038;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cRAlnpjqr6bgUfKkNAu3ISqsa9AjttBO7qAkv5Wdtl8=;
 b=rDq9An75I7X9UI48nRi+RtTRrhOaANjaD4WRs2VnysB8YxgePlv0/mr746tPi7uU6p
 rRXS1RCOEj6Ddmh4Cm+mTGhqLZ1JbNMCJUetSwuxth83b5LVy4DpEtx5M/gOX9hwE1ub
 N2xmnVi/fEo64H/UXa/gF9xTO5pfCkG3duDRj/33suQJtNA6Ou0S+aed+TB+gqb0GNeT
 3SbKlAtXgCRfc30KcgVtYbJx09uuZqK6OQzaMn8tYdaopQF3x5yauuXFWwY8I0QSK0oL
 7f4ijcts/4UJ4W1Q1PGw168NBxIS8mFlVF+BX3mq1sL9Qqxrxh9/ugY7IRM1YYFXG2YO
 fO9w==
X-Gm-Message-State: AOJu0Yz5FOrf2OSaSYY/AVKpZ59B7hplwms3ab6iLu0GO33WCGU1zqNW
 znt8+h3qVQeodlieRz8rZUbNi6LIqcfTeHqiIAsQjvzHEMcYqE30EXXBAici3s7C6FBh7Tvv9Ew
 9n54zAR2t1o+puIk/YFq1IYy3N4DpzyH5RnURfoBXp0r3K+9NlRrKGXrhqSHHJWlZiA5zW0GTqJ
 oN0RZ/hASx6kRvTHHn6x1XQH8v/Mt66Tc5ri4i5t7pwZtsZQ==
X-Gm-Gg: Acq92OFrVEkQjUtRjWwNxcVbQ0P20rWd5JM3LBXTs9kOGnIIK317QfSsIB866AKITj7
 B75QlfF5L9GzhwhCWXrlZ8elvpqq5u0Ogvwme1Owkjqu8Kgv24gc/SQhvN3SGOj4ktKE9rieFgV
 pyGbKm/kpeDzvfrXofIreIn8gocKRBpE949Bapp3KpT5LwR1DHBAzwz8Q5bJhloKxB6HUPD/wao
 SVS5sRCbuKLG4IwV9vdUTMqo27SeTrz6wPBZQ==
X-Received: by 2002:a05:6820:3103:b0:696:6440:9e2a with SMTP id
 006d021491bc7-69c9437a8fdmr13632131eaf.29.1779280237941; 
 Wed, 20 May 2026 05:30:37 -0700 (PDT)
X-Received: by 2002:a05:6820:3103:b0:696:6440:9e2a with SMTP id
 006d021491bc7-69c9437a8fdmr13632098eaf.29.1779280237088; Wed, 20 May 2026
 05:30:37 -0700 (PDT)
MIME-Version: 1.0
References: <20260518190735.16236-1-robin.clark@oss.qualcomm.com>
 <20260518190735.16236-6-robin.clark@oss.qualcomm.com>
 <b4787a2b-c1db-4c0c-8c58-fe60fed83cfb@oss.qualcomm.com>
In-Reply-To: <b4787a2b-c1db-4c0c-8c58-fe60fed83cfb@oss.qualcomm.com>
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Wed, 20 May 2026 05:30:25 -0700
X-Gm-Features: AVHnY4LzoFxkUnfiW8o2N4ZWSii52hKyNHpJEIfWcWyaWJPx5X2ycU2_KrwUkLo
Message-ID: <CACSVV01srddm1569SStsdBg_L_JG79sPgORokNUw8odgyix=pA@mail.gmail.com>
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
X-Proofpoint-ORIG-GUID: cTIDmWsxYQlaLMZwk5e4nDdprN4GS1bl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDEyMCBTYWx0ZWRfX5eTodCfPJouP
 sc6Pz1QhXHpyLxIHx8ohzxNY4lLycxHWDLem7e/VC3CsBcfOuYWvOm53c7QuS1/XLPrn1+ofHgu
 x+9RE/oVDr5es4ZzEviONyGJwx0yJ00uK8kNJtgrrCmmYl3XJA9Owf5Iv1t0d3dlZwPNk2uexla
 bU81HjX6XppIYOyV697ouEfSMgHxxU9IbbN63HN4PKRMHvHNI1t337ROuoNmU2UakmX5AYMmpXM
 0ZnfT2RsgaDVzJMSs9LESJugPfS+ShgUqU6p8/eCwZ6bvNMZNNwZSWmlnoRZiR7BNknBGfKOtIQ
 CaPZHdBar2OnHn3reSTpqaO3ct7F6MHs72FNxUQOtyyZ9toalBMT9CbMUzZcFOCLlFoUtycFgCv
 f83R/plxBrRam8RhfSaTtfwgF93527c06d0olUtbugyVx6/+wixUdSQDTd9t3h6YfB24G+JVY1J
 PqLbiZXu9ikgzwj2Lkg==
X-Authority-Analysis: v=2.4 cv=RZigzVtv c=1 sm=1 tr=0 ts=6a0da96e cx=c_pps
 a=V4L7fE8DliODT/OoDI2WOg==:117 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8
 a=AqeHwav0Fnr3ArOU010A:9 a=8f1wxSZkJpRnjI3K:21 a=QEXdDO2ut3YA:10
 a=WZGXeFmKUf7gPmL3hEjn:22
X-Proofpoint-GUID: cTIDmWsxYQlaLMZwk5e4nDdprN4GS1bl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015
 priorityscore=1501 malwarescore=0 impostorscore=0 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605200120
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

On Wed, May 20, 2026 at 1:36=E2=80=AFAM Akhil P Oommen <akhilpo@oss.qualcom=
m.com> wrote:
>
> On 5/19/2026 12:36 AM, Rob Clark wrote:
> > Pull in perfcntr json and wire up generation of perfcntr tables.
> >
> > Sync from mesa commit d2c4653ee953 ("freedreno/registers: Add gen8 perf=
cntrs")
> >
> > Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
> > Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> > Reviewed-by: Anna Maniscalco <anna.maniscalco2000@gmail.com>
> > ---
> >  drivers/gpu/drm/msm/Makefile                  |  25 +-
> >  drivers/gpu/drm/msm/msm_perfcntr.h            |  48 ++++
> >  .../msm/registers/adreno/a2xx_perfcntrs.json  | 109 ++++++++
> >  .../msm/registers/adreno/a5xx_perfcntrs.json  | 128 ++++++++++
> >  .../msm/registers/adreno/a6xx_perfcntrs.json  | 105 ++++++++
> >  .../msm/registers/adreno/a7xx_perfcntrs.json  | 228 +++++++++++++++++
> >  .../msm/registers/adreno/a8xx_perfcntrs.json  | 240 ++++++++++++++++++
> >  7 files changed, 882 insertions(+), 1 deletion(-)
> >  create mode 100644 drivers/gpu/drm/msm/msm_perfcntr.h
> >  create mode 100644 drivers/gpu/drm/msm/registers/adreno/a2xx_perfcntrs=
.json
> >  create mode 100644 drivers/gpu/drm/msm/registers/adreno/a5xx_perfcntrs=
.json
> >  create mode 100644 drivers/gpu/drm/msm/registers/adreno/a6xx_perfcntrs=
.json
> >  create mode 100644 drivers/gpu/drm/msm/registers/adreno/a7xx_perfcntrs=
.json
> >  create mode 100644 drivers/gpu/drm/msm/registers/adreno/a8xx_perfcntrs=
.json
> >
>
> << snip >>
>
> > diff --git a/drivers/gpu/drm/msm/registers/adreno/a6xx_perfcntrs.json b=
/drivers/gpu/drm/msm/registers/adreno/a6xx_perfcntrs.json
> > new file mode 100644
> > index 000000000000..8bb31820479e
> > --- /dev/null
> > +++ b/drivers/gpu/drm/msm/registers/adreno/a6xx_perfcntrs.json
> > @@ -0,0 +1,105 @@
> > +{
>
> RBBM and CMP groups are missing here.

Yes, so far we only support the counters that mesa has been using.
There are some missing.  Although RBBM and CMP look straightforward to
add.

> > +    "chip": "A6XX",
> > +    "groups": [
> > +        {
> > +            "name": "CP",
> > +            "num": 14,
> > +            "reserved": [ 0 ],
> > +            "select": "CP_PERFCTR_CP_SEL",
> > +            "counter": "RBBM_PERFCTR_CP",
> > +            "countable_type": "a6xx_cp_perfcounter_select"
>
> << snip >>
>
> > diff --git a/drivers/gpu/drm/msm/registers/adreno/a7xx_perfcntrs.json b=
/drivers/gpu/drm/msm/registers/adreno/a7xx_perfcntrs.json
> > new file mode 100644
> > index 000000000000..e60aab1862ec
> > --- /dev/null
> > +++ b/drivers/gpu/drm/msm/registers/adreno/a7xx_perfcntrs.json
> > @@ -0,0 +1,228 @@
> > +{
> > +    "chip": "A7XX",
> > +    "groups": [
> > +        {
> > +            "name": "CP",
> > +            "num": 14,
> > +            "reserved": [ 0 ],
> > +            "select": "CP_PERFCTR_CP_SEL",
> > +            "counter": "RBBM_PERFCTR_CP",
> > +            "countable_type": "a7xx_cp_perfcounter_select"
> > +        },
> > +        {
> > +            "name": "RBBM",
> > +            "num": 4,
> > +            "select": "RBBM_PERFCTR_RBBM_SEL",
> > +            "counter": "RBBM_PERFCTR_RBBM",
> > +            "countable_type": "a7xx_rbbm_perfcounter_select"
> > +        },
> > +        {
> > +            "name": "PC",
> > +            "pipe": "BR",
> > +            "num": 8,
> > +            "select": "PC_PERFCTR_PC_SEL",
> > +            "counter": "RBBM_PERFCTR_PC",
> > +            "countable_type": "a7xx_pc_perfcounter_select"
> > +        },
> > +        {
> > +            "name": "VFD",
> > +            "pipe": "BR",
> > +            "num": 8,
> > +            "select": "VFD_PERFCTR_VFD_SEL",
> > +            "counter": "RBBM_PERFCTR_VFD",
> > +            "countable_type": "a7xx_vfd_perfcounter_select"
> > +        },
> > +        {
> > +            "name": "HLSQ",
> > +            "pipe": "BR",
> > +            "num": 6,
> > +            "select": "SP_PERFCTR_HLSQ_SEL",
> > +            "counter": "RBBM_PERFCTR_HLSQ",
> > +            "countable_type": "a7xx_hlsq_perfcounter_select"
> > +        },
> > +        {
> > +            "name": "VPC",
> > +            "pipe": "BR",
> > +            "num": 6,
> > +            "select": "VPC_PERFCTR_VPC_SEL",
> > +            "counter": "RBBM_PERFCTR_VPC",
> > +            "countable_type": "a7xx_vpc_perfcounter_select"
> > +        },
> > +        {
> > +            "name": "TSE",
> > +            "pipe": "BR",
> > +            "num": 4,
> > +            "select": "GRAS_PERFCTR_TSE_SEL",
> > +            "counter": "RBBM_PERFCTR_TSE",
> > +            "countable_type": "a7xx_tse_perfcounter_select"
> > +        },
> > +        {
> > +            "name": "RAS",
> > +            "pipe": "BR",
> > +            "num": 4,
> > +            "select": "GRAS_PERFCTR_RAS_SEL",
> > +            "counter": "RBBM_PERFCTR_RAS",
> > +            "countable_type": "a7xx_ras_perfcounter_select"
> > +        },
> > +        {
> > +            "name": "UCHE",
> > +            "num": 12,
>
> A740 and newer has 24 counters

We don't yet have a way of dealing with mid-gen changes like this..  I
have some ideas, but nothing implemented yet.  The same situation
comes up for a8xx, where some new counter groups are added.

> > +            "select": "UCHE_PERFCTR_UCHE_SEL",
> > +            "counter": "RBBM_PERFCTR_UCHE",
> > +            "countable_type": "a7xx_uche_perfcounter_select"
> > +        },
>
> << snip >>
>
> > diff --git a/drivers/gpu/drm/msm/registers/adreno/a8xx_perfcntrs.json b=
/drivers/gpu/drm/msm/registers/adreno/a8xx_perfcntrs.json
> > new file mode 100644
> > index 000000000000..503b113df397
> > --- /dev/null
> > +++ b/drivers/gpu/drm/msm/registers/adreno/a8xx_perfcntrs.json
> > @@ -0,0 +1,240 @@
> > +{
> > +    "chip": "A8XX",
> > +    "groups": [
> > +        {
> > +            "name": "CP",
> > +            "num": 14,
> > +            "reserved": [ 0 ],
> > +            "select": "CP_PERFCTR_CP_SEL",
> > +            "counter": "RBBM_PERFCTR_CP",
> > +            "countable_type": "a8xx_cp_perfcounter_select"
> > +        },
> > +        {
> > +            "name": "RBBM",
> > +            "num": 4,
> > +            "select": "RBBM_PERFCTR_RBBM_SEL",
> > +            "slice_select": [ "RBBM_SLICE_PERFCTR_RBBM_SEL" ],
> > +            "counter": "RBBM_PERFCTR_RBBM",
> > +            "countable_type": "a8xx_rbbm_perfcounter_select"
> > +        },
> > +        {
> > +            "name": "PC",
> > +            "pipe": "BR",
> > +            "num": 8,
> > +            "select": "PC_PERFCTR_PC_SEL",
> > +            "slice_select": [ "PC_SLICE_PERFCTR_PC_SEL" ],
> > +            "counter": "RBBM_PERFCTR_PC",
> > +            "countable_type": "a8xx_pc_perfcounter_select"
> > +        },
> > +        {
> > +            "name": "VFD",
> > +            "pipe": "BR",
> > +            "num": 8,
> > +            "select": "VFD_PERFCTR_VFD_SEL",
> > +            "counter": "RBBM_PERFCTR_VFD",
> > +            "countable_type": "a8xx_vfd_perfcounter_select"
> > +        },
> > +        {
> > +            "name": "HLSQ",
> > +            "pipe": "BR",
> > +            "num": 6,
> > +            "select": "SP_PERFCTR_HLSQ_SEL",
> > +            "slice_select": [ "SP_PERFCTR_HLSQ_SEL_2" ],
> > +            "counter": "RBBM_PERFCTR_HLSQ",
> > +            "countable_type": "a8xx_hlsq_perfcounter_select"
> > +        },
> > +        {
> > +            "name": "VPC",
> > +            "pipe": "BR",
> > +            "num": 6,
> > +            "select": "VPC_PERFCTR_VPC_SEL",
> > +            "slice_select": [ "VPC_PERFCTR_VPC_SEL_1", "VPC_PERFCTR_VP=
C_SEL_2" ],
> > +            "counter": "RBBM_PERFCTR_VPC",
> > +            "countable_type": "a8xx_vpc_perfcounter_select"
> > +        },
> > +        {
> > +            "name": "TSE",
> > +            "pipe": "BR",
> > +            "num": 4,
> > +            "select": "GRAS_PERFCTR_TSE_SEL",
> > +            "slice_select": [ "GRAS_PERFCTR_TSEFE_SEL" ],
> > +            "counter": "RBBM_PERFCTR_TSE",
> > +            "countable_type": "a8xx_tse_perfcounter_select"
> > +        },
> > +        {
> > +            "name": "RAS",
> > +            "pipe": "BR",
> > +            "num": 4,
> > +            "select": "GRAS_PERFCTR_RAS_SEL",
> > +            "counter": "RBBM_PERFCTR_RAS",
> > +            "countable_type": "a8xx_ras_perfcounter_select"
> > +        },
> > +        {
> > +            "name": "UCHE",
> > +            "num": 12,
>
> "num": 24,

ack

>
> > +            "select": "UCHE_PERFCTR_UCHE_SEL",
> > +            "counter": "RBBM_PERFCTR_UCHE",
> > +            "countable_type": "a8xx_uche_perfcounter_select"
> > +        },
> > +        {
> > +            "name": "TP",
> > +            "pipe": "BR",
> > +            "num": 12,
> > +            "select": "TPL1_PERFCTR_TP_SEL",
> > +            "counter": "RBBM_PERFCTR_TP",
> > +            "countable_type": "a8xx_tp_perfcounter_select"
> > +        },
> > +        {
> > +            "name": "SP",
> > +            "pipe": "BR",
> > +            "num": 24,
> > +            "select": "SP_PERFCTR_SP_SEL",
> > +            "counter": "RBBM_PERFCTR_SP",
> > +            "countable_type": "a8xx_sp_perfcounter_select"
> > +        },
> > +        {
> > +            "name": "RB",
> > +            "pipe": "BR",
> > +            "num": 8,
> > +            "select": "RB_PERFCTR_RB_SEL",
> > +            "counter": "RBBM_PERFCTR_RB",
> > +            "countable_type": "a8xx_rb_perfcounter_select"
> > +        },
> > +        {
> > +            "name": "VSC",
> > +            "num": 2,
> > +            "select": "VSC_PERFCTR_VSC_SEL",
> > +            "counter": "RBBM_PERFCTR_VSC",
> > +            "countable_type": "a8xx_vsc_perfcounter_select"
> > +        },
> > +        {
> > +            "name": "CCU",
> > +            "pipe": "BR",
> > +            "num": 5,
> > +            "select": "RB_PERFCTR_CCU_SEL",
> > +            "counter": "RBBM_PERFCTR_CCU",
> > +            "countable_type": "a8xx_ccu_perfcounter_select"
> > +        },
> > +        {
> > +            "name": "LRZ",
> > +            "pipe": "BR",
> > +            "num": 4,
> > +            "select": "GRAS_PERFCTR_LRZ_SEL",
> > +            "counter": "RBBM_PERFCTR_LRZ",
> > +            "countable_type": "a8xx_lrz_perfcounter_select"
> > +        },
> > +        {
> > +            "name": "CMP",
>
> "pipe": "BR",

ack

BR,
-R
