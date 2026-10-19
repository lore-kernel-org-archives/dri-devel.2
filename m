Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 917FACCF2D6
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 10:49:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DCA5B10E0DC;
	Mon, 19 Oct 2026 10:49:08 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6AD7110E0DC
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 10:48:57 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69J8Opj72234252
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 10:48:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=mT9pGEhM9TkqrI8yQKVArxrG
 5zf0RJAxHkhCNo1DWs4=; b=P5dBz8xoR8WUxR52X9YxaQYtq++PKHRxlqwDK2Dy
 3vsR48sPuO1nAfhnx4qSWDNzmYyZU6diBohgUqxRgJjm6CcclvKyJinHGswJkFx3
 uKwgSve1CyXmCrRKrmH41ur9AJG7f5b0vIpvpXFE52uOU0VnbA8vchXkbust52kD
 OWpqrYBUUDhQKo9GrZa3XVMgrfskbRBiBpTYf/+HgoYdpf9WA4P9yQnoA/QPY6Yx
 GJchCZT9cVREOxiVxq12Rqdbrx36H2O149PnM7arxVJ+LsMnwYPx+WcT2/+Hz2HI
 xgMC9Re/CC95q4CwDraDyOkevfl6RMbnBs9ZKxWgMl2/VQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdf3x8py1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 10:48:56 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93ca9b53afaso700247085a.0
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 03:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792406936; x=1793011736;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=mT9pGEhM9TkqrI8yQKVArxrG5zf0RJAxHkhCNo1DWs4=;
 b=Qg3/yIp7InNb7xGpPyUHiWKlUvQEPsf2aF65hyjH7CY/Cy3i3v/SCk8sZaDl68LFbq
 v+Xw1ZxXINz3mLiercVQmDJHngCnf3gWV7SSVK0/CobhXRss6BR9nJmsD2hk2f1cGfgL
 kyvOJfysqvErMXwMsufutJ17HvQwcnW24HcSLCwwjHa571uNckppVoIr2X1gjDGHvWOL
 eqzhh53IUtHxYYyRsGAglLHvSMEeU9flKhIJl8qF6tUb9c9XqS78v2WMsGCI/wtERCKs
 c8//YQM+RAbmWfB336Vf2AVrkR6l00MdJa14FTlUHAZFOU9a2RfTqUpcS6GmYUy9RCrQ
 MRpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792406936; x=1793011736;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mT9pGEhM9TkqrI8yQKVArxrG5zf0RJAxHkhCNo1DWs4=;
 b=Pb1SPWOENh9gJPO0uGonIB884SHMcufYNsTggj1jFR4FNeu4jyjPuSVHu7ezmNPC0k
 /FAkIMyeLj3wvlxYlmw/m7DAFK8pjDgxccgmReqYMR4E5Jbk0DZXbjWEcsEdc4e/tpqm
 j4MnTfP2pv1vis9nWI8x4RHRbyBaroyHtmiW1MGek9FpuuvA5LdyxqbHSUqIRQxU55uU
 kowW9K8u5ku3fGUg0IqI0ehntM5P/ZGuJU4ZGvowZZifi5TBwT5i3J84qFBLWP/HfuJ/
 Fo/u8WtA4pjOYhqyBkusZiAtf57t5CXRwLtWiM7M2Ky8PvJQEha9L/5tT4Dqimpb6kSv
 HDTw==
X-Forwarded-Encrypted: i=1;
 AKwUvBweKfFjeuMuiuFG7S5L6/QFpS6T7tc4Anzrc1/bqNn7r0Vc3qdNM68IoEdQW0Slv+AdF2usm3uL/jc=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJRK5wQrItvMXVdJUuDgpQDL43jL+g+zja7Ww7G26eWoRYfPcxr
 JQdiB9aT+tykSYDqSEyNjtPrqtu/M8BprXpLBYqrn5uY7Hu0REGsMlZ0aUOCgRzrAY1xW4CZAK6
 H6y158z3dOIYn7aVz0RXSlWBoHd04coOLGo8AfUJU9dqvzuOOC01daHQ0tJI2c7D6OZHHT5o=
X-Gm-Gg: AYBFou2PtBqpIew9SKweJ0PLube+7n7i9KNFL8pubaMqeP0qtOPkOcAtbHWZ9+b53bN
 MGqULMvBBJXqTlrgPsvmw9tKKpz+b6kfSabXtiJWBGTEziwBXNBqXw6UnqPcXKWiOyW9yCstvpv
 LrJ0ZtApR6WpJKdavVD4fvVu1oEMRkRgaFNK8fWgyHLf22vWTSpAG9SLLSxZ+5BmfauLRh+9Zz+
 X8DsangYNm6rJTZLzvWyQxlRomGCinohPekZjQpc+E0Q4o+7ZVvsRpEf1SFxb2OOKor5zIWy2tj
 7tKt5jH/RHLa57KoF10oeYQ8Rx3Uj0d3FHQFoAAuc4YQCIdbLEs20MqrCkG0LpBsu2S6s9NN3mQ
 iYgUBaOtRvK388jw1cRjXAacr1awP8ro0ns1R0DS6mbPGHGoM0xiqQfT6G+xidJ0nTQrdK8maaP
 P0aTCY0gJF2Nt9
X-Received: by 2002:a05:620a:2609:b0:93f:2938:48ba with SMTP id
 af79cd13be357-93f29d9616dmr1189024785a.55.1792406935911; 
 Mon, 19 Oct 2026 03:48:55 -0700 (PDT)
X-Received: by 2002:a05:620a:2609:b0:93f:2938:48ba with SMTP id
 af79cd13be357-93f29d9616dmr1189020585a.55.1792406935510; 
 Mon, 19 Oct 2026 03:48:55 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5be4a434a7esm1888152e87.37.2026.10.19.03.48.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 03:48:54 -0700 (PDT)
Date: Mon, 19 Oct 2026 13:48:52 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>,
 Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>,
 Kiran Gunda <quic_kgunda@quicinc.com>,
 Subbaraman Narayanamurthy <quic_subbaram@quicinc.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Abel Vesa <abelvesa@kernel.org>, Dmitry Baryshkov <lumag@kernel.org>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, mfd@lists.linux.dev
Subject: Re: [PATCH 8/9] arm64: dts: qcom: sm8150-hdk: fix FSA4480 address
Message-ID: <cteiu5owhinqz53oxcfywioew3kh62c2jbcej2etobfx7awabp@regtmdoqc34b>
References: <20261015-sm8150-display-card-v1-0-5c14928cef29@oss.qualcomm.com>
 <20261015-sm8150-display-card-v1-8-5c14928cef29@oss.qualcomm.com>
 <ddbb547a-f59f-4ad2-8c99-4436bdae84c7@oss.qualcomm.com>
 <36e8a372-3a4b-4466-831a-2445313dae51@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <36e8a372-3a4b-4466-831a-2445313dae51@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: 9h120ByOLhQrtq1gsqnZw34tVCSCA0RZ
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA0MiBTYWx0ZWRfX4ixLdP3ZHlk9
 dDbm7dbwhFU5o1v5ZqGf3hf8JGifTx2dmRgRrpMCfss1xMxv6D7qGMpR4ddbY+QvRuuOWUxBw+q
 sm5A1Gg/Q7SaoxwYRdPq4FsDC4GSp/U=
X-Authority-Analysis: v=2.4 cv=XPOl2ghE c=1 sm=1 tr=0 ts=6ad5f598 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=ciNfSeS1p6VPI-OA_NsA:9 a=CjuIK1q_8ugA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: 9h120ByOLhQrtq1gsqnZw34tVCSCA0RZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA0MiBTYWx0ZWRfX8c5Fl8jGv5nW
 EabHQIVHe2UhXAlTtQ0+BHVopYaWkTSfZS3Jdz9TGQFrFEEdSgj5AncS3vF9KJNjEcknThQ/vFI
 4ML32Bg/pDSy1FywRVb3FmnpseyT2C7YtMT9jKyt7o5UnZ3sz038QPbfhvRxlF8oWd/qduQ282t
 Gu3OMeE3APqerJIoVZvE3+bkp8MUON9p9XiyNu9sYv8ZHmL5+X+NSTTOJjY6MOlb6FQzF9k+l1T
 16zy2VyRFcsmKN2s3u2im0uH895flerIevqq4C5hT2RjR1QGOijRfsKD3EGFK3L3581nTGzIRjG
 g/wzYdGqpvYRm1PFEMuqtwX9L6aAZgGKJ3m/HXxgr90jL8JybwSdCgdTac1y8tpBOO3I4xx6/XH
 Yq1VXeJypxS9rSye/1ctOpzohnsXXYEyEXYw1cIwaFHcRcfS6nrbwxVFxH4OPN6sUtbun4w8elZ
 7gTsJdMmo91pSH3a8Dw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_03,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 adultscore=0 phishscore=0 suspectscore=0
 clxscore=1015 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610190042
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

On Thu, Oct 15, 2026 at 11:11:08AM +0200, Konrad Dybcio wrote:
> On 10/15/26 11:10 AM, Konrad Dybcio wrote:
> > On 10/15/26 10:58 AM, Dmitry Baryshkov wrote:
> >> The FSA4480 on the SM8150 HDK responds at 0x43 rather than 0x42. With
> >> the wrong address the mux driver fails to probe, the Type-C controller
> >> and the DisplayPort controller keep waiting for it and the display
> >> subsystem never binds.
> >>
> >> Fixes: ba712fd55c7b ("arm64: dts: qcom: sm8150-hdk: enable DisplayPort and USB-C altmode")
> >> Assisted-by: LLM
> >> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> >> ---
> > 
> > Hm, there's an ADDR pin on the FSA. I wonder if the previous guy had
> > an earlier revision of the board which routed that differently or
> > something.
> > 
> > Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> 
> oh wait.. the previous guy (author of the Fixes commit is you.. :D

Yes...

-- 
With best wishes
Dmitry
