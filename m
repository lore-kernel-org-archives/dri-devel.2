Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C63ECD5BBF
	for <dri-devel@archiver.kernel.org>; Mon, 25 May 2026 08:26:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E127410E5F3;
	Mon, 25 May 2026 08:26:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="DjYCOS8+";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WbJQhj6k";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D90BF10E5F4
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 08:26:25 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64P3H89A1381700
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 08:26:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=7rBXA3gJaShhZVzoaIiw/kiN
 lXbUmYwN5ampbliG8NQ=; b=DjYCOS8+soCUdDdDWw3eLkhGaXtO5FeKmyDYv4yX
 kh+1z3f6ZAXnsSCmq7RDVVw2Xxoey+hqdhaL3/hV4uQbTkhlzRalj/9ikZsm1sCb
 jT5I/jWyC5Nh2AKTI75RsHTcErc8XgCvD+33cjDP4DlqDPJjEECAKJ6K7byTQ15U
 A5fmFDSPViiJagRsruG9SdDOxNof9aOB59OWQXumxBxBhsa3+949/U2Ktg6tIgmU
 dOK6tVeSHuIAysH9TkFPb5vk3dkP+fHATrYRc1uew7P3Gy65rzP+bvbc2u6bM2Bk
 0H8nqz1qcPG0hZ8piJW8LG8o9FbGgdkwVY8j5swNpuEoBQ==
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com
 [209.85.221.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eb4f3dr5b-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 08:26:25 +0000 (GMT)
Received: by mail-vk1-f199.google.com with SMTP id
 71dfb90a1353d-56f73835016so7275280e0c.0
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 01:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779697584; x=1780302384;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=7rBXA3gJaShhZVzoaIiw/kiNlXbUmYwN5ampbliG8NQ=;
 b=WbJQhj6kBeZj4KdPYD1rm6Wsmsq7AmgZ6SfP7y6aUBPMKG4L6hQzUYLS+XLG26DVPF
 8X5/nQo1pIM7d5zlhkHJm2Obtr346UofVKtaR2RqkRe1wzaEs4rZIS16/YSlgHf7GobQ
 1oCLRJSA+QSdQPkm5ie8Okk33J4v6ql+RzdJMyNuA4pLK72vxIE1kNJFDv5eejIsB2Sy
 1KzknR38cHds6vwyKrjUaKg9pmxbpLKE4T2+iUA/HOTzvxUpaBWHO1Q7u9I6FYI3E0u5
 SremJTMVmNMNgKu0r/CaJC/KQaV0jt4MyjmPh963YAwrHufbUhUSUIhIwpaMG4Q3iaYL
 BYjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779697584; x=1780302384;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7rBXA3gJaShhZVzoaIiw/kiNlXbUmYwN5ampbliG8NQ=;
 b=PwsQHmAPk6kvPy8+hkM8jHmgZsxTMM7CxxKj2yOC285G4QT3FPyoxzsK041TjWpZwx
 UTmmZ23ME06CHDodpvG68gBZ7ZbIQL8JzhjZugkyhdyMuDWcdCxMG9kdu1jkmj8AwcUp
 cJ/CqIncZBbvtHUJKw2AlF3edbcbEYxboauXguZPrNpknudz6TydYHnsIkLKaUMi2eXL
 kAJqZORYjR6p3ZH5wXExQKImw9F43mQL4hKNB8EWDLQ3OwRZtXoxPnNqNMAvaeu+3OLx
 0v5yDPpUiMg4+qPKh8H0vo1bk5NKysagL1bYoKJqCWT6n8w+2IISMJKcfOyCEkKzzVLi
 jT7Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ9Kup0MibYJgDPAEs18sN6iZor5s85uBfTNfS2p9RyQQnZ4LelYwglek3OXQ/sFtXPOL5UnqQFZxV8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzhj5cAMbwvLhzY9MnFZ+Q/Mj27VvYKpPe7Z98HL8eEuqQ2uGcR
 e6cof0CIBI9MR37d/xtFgQEkuD85zLlvrB3uPuI3p38AO1NG9ZfEdYtxLV4KYzix4wydwbmiljL
 bwVmuZ3/dmtHtwhVXHgK0GkwgXPOxmv3TzIJMOhSc08/iTThLtLKHN66BIu4JoK3vdieL8cU=
X-Gm-Gg: Acq92OEoPFlF0NTmNs5HhTeIMD8dH6QVn5hzeBzNB8uTvEP6Pin9fzX8jljSZKyrymz
 AxC1ma+5Ws0EOFXc9UWSkic2gCwYoVoF7Vk1eNytI5WdevGDmhxYyQhSuYAPOE/zt55DiH/5QlX
 +Fo0mSJ2okksKN8PwOwNL6D1Q7IvshRChJbrjbURpjtpQ6vY1VjRmrbmU83s3XilQr5JL7JYaYH
 1JaH/lnCAYnRg3EQjLcAp41GAM/BMN0LqUXzpGwCNk618wD+Z147U9p5g1vrfkXlCIGvBDTUcTL
 uPcjhNrweXfYmY1onWUV1RpCcG5YP96Y8kFSVOpROidWcFvkXbqYQZOCYr/DKGjjookRSxCA8Pv
 auYe0f+aG67uRo3DnIXjdnU4USqg9VjIgqmVUVGfdgBn2f0FsZN8pDV50FXHR+eCDlXcnPLnaHr
 xjzuViPjtsNt7bFqOxaPabVH8eZc8/Kezgvzs=
X-Received: by 2002:a05:6102:3fa4:b0:607:4fe2:a644 with SMTP id
 ada2fe7eead31-67c7dc589f6mr5897455137.6.1779697584202; 
 Mon, 25 May 2026 01:26:24 -0700 (PDT)
X-Received: by 2002:a05:6102:3fa4:b0:607:4fe2:a644 with SMTP id
 ada2fe7eead31-67c7dc589f6mr5897450137.6.1779697583774; 
 Mon, 25 May 2026 01:26:23 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5aa32ceb258sm2511471e87.48.2026.05.25.01.26.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 May 2026 01:26:22 -0700 (PDT)
Date: Mon, 25 May 2026 11:26:20 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jessica Zhang <jesszhan0024@gmail.com>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Abhinav Kumar <quic_abhinavk@quicinc.com>
Subject: Re: [PATCH v4 00/39] drm/msm/dp: Add MST support for MSM chipsets
Message-ID: <mfskwrfyiaq3zzro4tv2vr6rauzovrzy6qxai4ydjkwoo5lu57@2z25w7xwqbxl>
References: <20260410-msm-dp-mst-v4-0-b20518dea8de@oss.qualcomm.com>
 <bmkdeyquoyvcwcgucijcxmgnip32fs4gyqe6gvponokwiu55cf@7ncsbggx23ar>
 <c5934946-d2d7-4bb3-86e7-9de11db5e85d@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c5934946-d2d7-4bb3-86e7-9de11db5e85d@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: 5UJQS-9ak8cj3n8Je7JPTyftn7wH0Owj
X-Authority-Analysis: v=2.4 cv=WvYb99fv c=1 sm=1 tr=0 ts=6a1407b1 cx=c_pps
 a=+D9SDfe9YZWTjADjLiQY5g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=e5mUnYsNAAAA:8
 a=EUspDBNiAAAA:8 a=2xXovNFYb3zsjleF0pEA:9 a=CjuIK1q_8ugA:10
 a=vmgOmaN-Xu0dpDh8OwbV:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI1MDA4NCBTYWx0ZWRfX4v/oNGT+o52U
 aXymoFWxQcaZNlqPxcKANMVOoAtW9JqgwOw+BIeTo0mU3i/6S/VmLilwI+q9DJUyeZ7wNRSQh0o
 d6d+1xxkTVgdbeUHZ+aug4arUwTcqQUldN6cWW/OPIcPipXkRifXqeEzsCHQOtVpD0031Od6CCJ
 s6W32KeCQ5Q3xdv8gKsf5goqc0eBcw4ig3mN/SPaFytTHzrkIZ+gkxpBioTWn3wBgOGSsazi9Vu
 3jbsACdaifPlOt0rbC6fiXrcCsWYCuF21fPLsj/VqNK2hIqodfG4VhI6jvVyhX8ieTeo9H+gSzu
 CMS3K8+WeAJ1kASgCGIURnhNzpCAjQodyhkg/cbFghRag9FJOTWUHb2uDidVnijNiqgkAbOQCWt
 6u7tskoSMWdpEGS6cjyThELTu/IIJ30e87sJN4akA/VcZPccgsUPm+mGUXv6bOM3f4IYGFwi+N6
 7olz1K4d7+FPhWQSBpA==
X-Proofpoint-GUID: 5UJQS-9ak8cj3n8Je7JPTyftn7wH0Owj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-25_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 clxscore=1015 phishscore=0 adultscore=0 suspectscore=0 impostorscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605250084
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

On Fri, May 22, 2026 at 04:07:52PM +0800, Yongxing Mou wrote:
> 
> 
> On 4/12/2026 8:34 AM, Dmitry Baryshkov wrote:
> > On Fri, Apr 10, 2026 at 05:33:35PM +0800, Yongxing Mou wrote:
> > > Add support for Multi-stream transport for MSM chipsets that allow
> > > a single instance of DP controller to send multiple streams.
> > > 
> > > This series has been validated on sa8775p ride platform using multiple
> > > MST dongles and also daisy chain method on both DP0 and DP1 upto 1080P.
> > > 
> > > With 4x4K monitors, due to lack of layer mixers that combination will not
> > > work but this can be supported as well after some rework on the DPU side.
> > > 
> > > In addition, SST was re-validated with all these changes to ensure there
> > > were no regressions.
> > > 
> > > This patch series was made on top of:
> > > 
> > > [1] : https://patchwork.freedesktop.org/series/151522/ (v5 to fix up HPD)
> > > 
> > > Overall, the patch series has been organized in the following way:
> > > 
> > > 1) First set are a couple of fixes made while debugging MST but applicable
> > > to SST as well so go ahead of everything else
> > > 2) Prepare the DP driver to get ready to handle multiple streams. This is the bulk
> > > of the work as current DP driver design had to be adjusted to make this happen.
> > > 3) Finally, new files to handle MST related operations
> > 
> > General suggestion. Please reorg the series into the more logical
> > chunks. If you are touching enable / disable path, then continue doing
> > that until its done (more or less). I'd really like to be able to merge
> > at least a part of the series in the next cycle, but there needs to be a
> > logical "halfway done" moment. Let's define it at the "all paths are
> > refactored, all booleans are in place, we are ready to get MST parts".
> > 
> > I've not found a use for separate bridges in the MST path. Please split
> > the functionality between the MST connector and, maybe, another private
> > object for generic state (like connector -> encoder mapping). Other
> > drivers don't have this issue because they have fixed CRTC -> encoder
> > mapping. MSM doesn't so we need a separate way to store that. It's sad
> > that we can't subclass MST topology manager (or its state). Maybe it
> > would be worth changing that and letting our topology manager handle the
> > assignment in it.
> > 
> > Also, I found a set of warnings while trying to build the code. Please
> > make sure that there are no warnings.
> > 
> Got it, thanks...
> Does this mean I can send a subset first (rebase on latest linux-next and ),
> for example the first twelve patches? They are mainly clean-up changes and
> do not touch the MST part yet.

Yes. Keep the version numbers increasing and document in the cover letter
that it's a spin-off of the MST series.

> > > Note:
> > > Validation for this series has so far been done on the latest linux-next
> > > on LeMans, covering both FB console and Weston.
> > 
> > It wasn't. I couldn't apply it to the latest linux-next. There were
> > fuzz-based rejections because of one of the patches merged some time
> > ago.
> > 
> Will rebase it.>>
> > > Broader validation, including additional Type-C DP use cases, is still
> > > in progress and may lead to some follow-up adjustments in the next
> > > revision. I wanted to post the current version first to collect early
> > > feedback on the overall approach.
> > 
> > It's nice, but please keep in mind that majority of users use Type-C
> > rather than native DP connectors. In some cases your lack of Type-C
> > testing affects the design (e.g. for the HPD handling).
> > 
> > > 
> > > Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> > 
> 

-- 
With best wishes
Dmitry
