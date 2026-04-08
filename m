Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87286FD5F8F
	for <dri-devel@archiver.kernel.org>; Wed,  8 Apr 2026 07:32:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE11810E55F;
	Wed,  8 Apr 2026 07:32:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="nW+T356e";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZmZRv8jp";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ABFD210E55F
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Apr 2026 07:32:45 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6385d3rX3362809
 for <dri-devel@lists.freedesktop.org>; Wed, 8 Apr 2026 07:32:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=xckB8PPJx6+/vCorN26HvLDM
 xAJX+r/dYxdwC1AmZgc=; b=nW+T356eFEiWlNV25OIPnYucbssv+TRN/QY2qRAf
 QPRvHVVopBSmj/fSXs0NgBVDsJ9QE8h2ok+x0hvLsG6TiUlkCg3wObmLBv3a7kyl
 m2nzw3uI4iNng+JA9e6cvv2Wr9/bVrWoP9AgCaOtYp8dKr0uxx8E/hlWlK1ZeVQ3
 WEMSL+o4zXWOunDSRMY8navjM9E6q9a8BQsXTSnLcqh6IrTx2LaLgYKULpd1TeUY
 /UDWZ7IRiI7V0ojXtEFPxFq2jCCBms5mBavoeF2GzEXNoWRAmbYzsK4rZpqtAOP2
 9hwyvyzYAsDYq9cz/CCF+9umhTFAznHxI/Lr5T7DlLXzWQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dd7tkj45j-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 08 Apr 2026 07:32:45 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-50d8e8c47a3so63112681cf.0
 for <dri-devel@lists.freedesktop.org>; Wed, 08 Apr 2026 00:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775633564; x=1776238364;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=xckB8PPJx6+/vCorN26HvLDMxAJX+r/dYxdwC1AmZgc=;
 b=ZmZRv8jpEym8Ulh2QtNK+vsSOY4ntenFHfPITfTm7+lWn9DunKXmCPyVlU4mc0f21s
 1IDrcBOYhEwfCnOLCVxez2wvTUB95J3heoOvl/6SMTPKWHZ4LIjj2mumryKyKewIvJEM
 rAN4a2qiqAzi++JLbxVFfr28tuELSV1SU3WV/I3NN66ZI0QmwqwEWyLw7ri7uumErJF5
 xY9C/0hlHAZuE1B8N4nKVIwBKKF/4qT3kw0Ozq4LABZNnzNzgCKKrIdnND37Ya4o0LSP
 ZL69YQm4IEWL9TQAykkzsOdHY3HUlwIeqzJ4+wvI4Mt1Q1WKDrXWFEdvnhc1koIqqiQe
 JYzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775633564; x=1776238364;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xckB8PPJx6+/vCorN26HvLDMxAJX+r/dYxdwC1AmZgc=;
 b=XvYkD49gqwf+BVxqulcg5XtRpIEz4I9UfWvX2Qqj5BYAXsMVqPeaY7bpV6kms9zdc2
 hz2GlayrjSQ1VaWhFQpHGor3iuzwv1NsiiMK8TLQG/Fom/OZaGYgA2EC9WG1lsgPywKm
 C5O3fPWNY2JqTzmDwwEqnaPEaFYF1pt8H2irdxiEp8csulGyJflvcvhuf9GElHeKxke/
 daS3BVTcH+PAdheFEyEO5Z2kk2ue/vbXn84LdVcekemLg0RhLhTVsRNUtzjxzD9RymzZ
 dSQlWqnsM4BXOswgva45ltXmfS6iplWF+C98i+0FlaPoAGuUIpQOHlGh3FyWptLmZSza
 D94Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUYhh5ynpyMbqRJ1C7AEiUnFuX/SUCon+aeLr+WivevE1P7xrB8Oy66+jVfpJ3A3Ifq5KxhcSvmitc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxuljEMRF03kous2OEFBpFwmyMeQc4bQ7jzpIUxfh7qZHb+8zJE
 O7gW66CrW376YLsoFz8qibaC8AsbMVk8Py3xSlgrz1IFl5yCW4MBVtsA5wntjCw1liVwZ/FmlAR
 bDP6ykoMtZjReIfjrUUTiT+cfe1ACWvb+M8kMiGHqXb4ZHFhE4xc3qxLjQM3tANOFDCKwPfQ=
X-Gm-Gg: AeBDietUn+72uB/4oDUnmMb1hQEKrotnwO+hnpWvRO+Mt0eM7R1Zyjeff045NRERlat
 YJNnLtDeORvHek/1/EdXIV7x5tn3YRJ0NZJ/vqqXIaXWlimR+XaCf91IrqeUdfaaYBu+YtGmKEs
 c46NTalRcek3tBVcL0uE6QrXgu89voTj9T7yX9auXRS4KwzLkaaZoH3z/ArTo/QM4KQ22JVuRcW
 uid8ayMkIwwgnm1EwMjU3G3FEIpf1VkRcpdEXq0CGQ5eaUuhoFfZhLYUg0MkAPXD9AZRVMtWGOb
 0S3/Bu7UHKD+McdXYd3OQb1CfiqRZwIgFi+B2vzpxTJ5pVs1neXfCe3IyQ8WQT17kNqjYZxL6/C
 APQPI11ohK7lTqwKaKvLtMYcyUaqehRNCd30QnCYr+vj/9HrdghFJrGy5
X-Received: by 2002:a05:622a:124b:b0:50d:83de:4933 with SMTP id
 d75a77b69052e-50d83de50cfmr202934371cf.20.1775633564132; 
 Wed, 08 Apr 2026 00:32:44 -0700 (PDT)
X-Received: by 2002:a05:622a:124b:b0:50d:83de:4933 with SMTP id
 d75a77b69052e-50d83de50cfmr202933731cf.20.1775633563612; 
 Wed, 08 Apr 2026 00:32:43 -0700 (PDT)
Received: from trex (187.red-79-144-197.dynamicip.rima-tde.net.
 [79.144.197.187]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4889cb46adcsm383692655e9.4.2026.04.08.00.32.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Apr 2026 00:32:42 -0700 (PDT)
From: Jorge Ramirez <jorge.ramirez@oss.qualcomm.com>
X-Google-Original-From: Jorge Ramirez <JorgeRamirez-Ortiz>
Date: Wed, 8 Apr 2026 09:32:39 +0200
To: Trilok Soni <trilokkumar.soni@oss.qualcomm.com>
Cc: Sumit Garg <sumit.garg@kernel.org>,
 Jorge Ramirez <jorge.ramirez@oss.qualcomm.com>,
 vikash.garodia@oss.qualcomm.com, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-media@vger.kernel.org,
 netdev@vger.kernel.org, linux-wireless@vger.kernel.org,
 ath12k@lists.infradead.org, linux-remoteproc@vger.kernel.org,
 andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, robin.clark@oss.qualcomm.com,
 sean@poorly.run, akhilpo@oss.qualcomm.com, lumag@kernel.org,
 abhinav.kumar@linux.dev, jesszhan0024@gmail.com,
 marijn.suijten@somainline.org, airlied@gmail.com, simona@ffwll.ch,
 dikshita.agarwal@oss.qualcomm.com, bod@kernel.org, mchehab@kernel.org,
 elder@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 jjohnson@kernel.org, mathieu.poirier@linaro.org,
 mukesh.ojha@oss.qualcomm.com, pavan.kondeti@oss.qualcomm.com,
 tonyh@qti.qualcomm.com, vignesh.viswanathan@oss.qualcomm.com,
 srinivas.kandagatla@oss.qualcomm.com,
 amirreza.zarrabi@oss.qualcomm.com, jens.wiklander@linaro.org,
 op-tee@lists.trustedfirmware.org, apurupa@qti.qualcomm.com,
 skare@qti.qualcomm.com, harshal.dev@oss.qualcomm.com,
 linux-kernel@vger.kernel.org, Sumit Garg <sumit.garg@oss.qualcomm.com>
Subject: Re: [PATCH v3 11/15] media: qcom: Switch to generic PAS TZ APIs
Message-ID: <adYElwM6eT5T8hZM@trex>
References: <20260327131043.627120-1-sumit.garg@kernel.org>
 <20260327131043.627120-12-sumit.garg@kernel.org>
 <ac-KQ7e8-syph1Zl@trex> <adOcMsk8a_Clb4WZ@sumit-xelite>
 <439f9bbf-1ba1-465f-b5af-01ba0ebb86d4@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <439f9bbf-1ba1-465f-b5af-01ba0ebb86d4@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=drPrzVg4 c=1 sm=1 tr=0 ts=69d6049d cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=VPdg2FrOqWfiVCzsz0q0YA==:17
 a=kj9zAlcOel0A:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=YTLieAA4xaQwPRX2avwA:9 a=CjuIK1q_8ugA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: DVjxu3KvGnfaeoPYouEQNwgoRsZRdfPo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA4MDA2NyBTYWx0ZWRfX32ErM/G2udiX
 SCAMIZfTHm8qQG1gjSwtfqvraDm6axAPkJp1T3BPNcpcPFuMvqLI932kdL6j2ymAgzFQW1l0WSf
 uJIf2ozPBCCPcwRnWjj4FNN4sGTzuU6H9OP1KqbdtZHOqxuqQDz3XyrnjudlLCLu4Oq6c8yiLz3
 cfuzPaeg/E9UFwCo+TweDj84xwcxU1XD6o+pfINIhdajaB2Of4cIyIl1H+zQoPbhlDoC5u2M5fr
 5xa1rd+vHxRm4MbevgL4Cs+3CtUyLBIFBTkYTBJxlVXcqaS3earFKt9JsNvenwqhgCu+qHVPpY2
 c30SfzdWoHLPDWAXJz7eGm8inAlf2FLGXJVlAcufaWEqHXBeKp1sdaCoB4YldDKwMsQCQI0zGM3
 37RulroDfjuJaUbT7a7m8ggE8S/+rKtpXasBfR/133X11m3mLcyNQNScWaTv6o91H+V8C3d6paz
 Z2ZXNqcb0YA7hpERLFA==
X-Proofpoint-GUID: DVjxu3KvGnfaeoPYouEQNwgoRsZRdfPo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-08_03,2026-04-07_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015 malwarescore=0
 bulkscore=0 impostorscore=0 phishscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604080067
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

On 07/04/26 15:14:22, Trilok Soni wrote:
> On 4/6/2026 4:42 AM, Sumit Garg wrote:
> > Hi Jorge,
> > 
> > On Fri, Apr 03, 2026 at 11:37:07AM +0200, Jorge Ramirez wrote:
> >> On 27/03/26 18:40:39, Sumit Garg wrote:
> >>> From: Sumit Garg <sumit.garg@oss.qualcomm.com>
> >>>
> >>> Switch qcom media client drivers over to generic PAS TZ APIs. Generic PAS
> >>> TZ service allows to support multiple TZ implementation backends like QTEE
> >>> based SCM PAS service, OP-TEE based PAS service and any further future TZ
> >>> backend service.
> >>
> >> OP-TEE based PAS service relies on the linux driver to configure the
> >> iommu (just as it is done on the no_tz case). This generic patch does
> >> not cover that requirement.
> > 
> > That's exactly the reason why the kodiak EL2 dtso disables venus by
> > default in patch #1 due to missing IOMMU configuration.
> > 
> >>
> >> Because of that, it is probably better if the commit message doesnt
> >> mention OP-TEE and instead maybe indicate that PAS wll support TEEs that
> >> implement the same restrictions that QTEE (ie, iommu configuration).
> > 
> > The scope for this patch is to just adopt the generic PAS layer without
> > affecting the client functionality.

the patchset cover letter + the commit message + the OP-TEE pull request
being referenced gives the ilusion to users that with the current set
they will get something functional (they will get a broken video
platform instead if they try to use OP-TEE).

That was the point I was making: IMO the commit message walks on a thin
line of "completeness"

QTEE and OP-TEE at this time implement different use cases (Venus with
QTEE runs with Linux on EL1 , OP-TEE runs with Linux on EL2). So maybe
worth mentioning this divergence.

> > 
> >>
> >> I can send an RFC for OP-TEE support based on the integration work being
> >> carried out here [1]
> > 
> > @Vikash may know better details about support for IOMMU configuration
> > for venus since it's a generic functionality missing when Linux runs in
> > EL2 whether it's with QTEE or OP-TEE.
> > 
> > However, feel free to propose your work to initiate discussions again.
> 
> Vikas and team depends on some of the IOMMU patches to get accepted 
> before they enable the EL2 venus support. Please reach out to him
> and Prakash Gupta at Qualcomm.

isn't Vikash in this thread, he can ping me too no :) ? but sure, we'll
synch later 
