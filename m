Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8262BCD4F54
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 12:37:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD04310E638;
	Wed, 20 May 2026 12:37:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="kfe8X8wx";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DZ8T3j37";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 38BFD10E638
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 12:37:03 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64K7AKwO1954028
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 12:37:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=MQWPQmhDmwD4oX8nyytXi5se
 S2wORlym9UiV776yap4=; b=kfe8X8wxMQwCDeDF4V3x2wu9wMTurEr14zaVPx+Q
 0ftHWOLcKGCJ84p3EAHT5SJsKwzY8B355txmx5RyIll0S7HxwSK9D/00CvVElqC6
 ZdP/rzEA22HO8ZegxmvCu3PMSHgumSHUGjmijCplHULpeDBm+JunmEUsh3lik2u5
 BMhwQxG2TY4qL+39HOGsuMPgcMGewlt53fxty+hQRvd+ICe/IY79e978xoArnNXY
 kuVbVAaUPqTLuoHtNHfa7xiAN41Vklq3OS+kUcszpcrWTndq1BZnp59tNifrPk6N
 SLk+8x8I9f8V3jSH5683JnfNVQ2A55q/BFSvpn0ptvtYxQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e8t3xvr7b-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 12:37:02 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-514cbe73d00so152318811cf.1
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 05:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779280621; x=1779885421;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=MQWPQmhDmwD4oX8nyytXi5seS2wORlym9UiV776yap4=;
 b=DZ8T3j37vij5Kx0DDh6gHq6sfkYzlprUQUu75n68SpZpWoBsgdBAaAy4UIZpAqCamo
 6/j7H/JvXl4fc8eJXS7eoce8ITjAhliRhgbegEE/UeggtgcdQr6n5740/u6bfeny3TzC
 OW1dkLTDsiJ76HPvsxMIksKffJDh8fb5odhSfEVlfvqzcDbhCYwwnXvCN1mReodx4yM9
 4D+gwAFZZEdmfa46tbS2p8DxYF/SHl4cl92fJbHRa+PZVdBnbsf/m8hPOs5qcOFwb1ow
 agHFPtd+4I/VduNlMjuijrBt3F+e/F8b6zBxGmeQha+PzdJNEDUOlNw7Xjo0Q02n4orK
 yCAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779280621; x=1779885421;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MQWPQmhDmwD4oX8nyytXi5seS2wORlym9UiV776yap4=;
 b=bTMOUr9CGQCxrF5iNPmSx14Ux4bdZh2lJSc3vnGfzbuGaCmbkmTfWMpv15wMfvsZUG
 0c4//2SCrBzVZM2Gj/YdeodVFLYNbQ9KxryHYCL5yUSQtdsXltaku8+VQHFfQfcPj2pI
 eaP8LtE4DUWUyBMrsbMM3oxuvIIhJkMbZ1mrPd+PtGINaGaV1px2hD2085kdzg2Vcwue
 asf+H7FnbunmQp+kDRMXC8+n/RZBGOAzCF24sC4hmF7hscyTVSL+/8l17T45L85IT9x3
 XgFhzFh3/sg0PMAS6N8xLku7x4S7+jIhEVtbIxBkQMdbTeTgwWWQBad+Yniqb83/mNhD
 OWdQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/YxQfwJqIwLFj/yjiXfgxO95wMLfF4OD/rs1i07F1H5PZeqCxFI6z6K1FzLjYuaJEfoZB+qC8MVSk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyxipzPKa+eIOc/oX/pXUa2gk8VaQgwHNy+IsgqlqtRfB/808LD
 5fT/zqH4y9IgvGnXebCmDeGni9dqELOASKsVyemC2TlBXaO9QX+ABXnd/URZd99UPsOx1E+KfiI
 y8VuuQY2qrKmUc5CV1lzXxWP5oZtsUPMI1PxMqHDKxBq0MUnnEBY+ZbT7+oiWqeqx+7RpoaQ=
X-Gm-Gg: Acq92OEJCOHcIYvGRRXx/1UhjWCxu3CV05cZuC+MUIQq00qOuFN+X7nyilV8bKmyVnl
 ylRKHmQu5DUOkpAMXt3nmIBFYo5qLh8GrrhZdLUe8Y+Jdywq6prA4IC6PbwhHy+exiHX0Sse+E1
 qHcygtThezIheBO78X7You9D/KiNbwbQNloszbBDMl3zReA2r6g6HTVLWbSXpdsg74IhuWJIGMw
 Bc9y5GwACfvzQHnE5fH63ldMCCDVf1gKDetQBwG0tA9GS1Fv8+mhZti6Ax9kGhb8zD34VtoCWO0
 sRjJM53gwpNy0hTaCcW7JL0jLtiSbKMV8jw0B0gQYtDT5R9O5b/UKuxjsyvycgckWZ6LmFvPdBy
 zENxyXY+JaiRPYqa36SytvZHraGg+NVwefwiMpJvl0v3HxzWLDVZ07JOT0QXLurVWbZ74V564qv
 Vr7ib7dOcWaQtnZHPj5pI3/hQByKQ4gzdzFqI=
X-Received: by 2002:ac8:5f08:0:b0:50b:577c:e259 with SMTP id
 d75a77b69052e-5165a0df411mr330232291cf.35.1779280621103; 
 Wed, 20 May 2026 05:37:01 -0700 (PDT)
X-Received: by 2002:ac8:5f08:0:b0:50b:577c:e259 with SMTP id
 d75a77b69052e-5165a0df411mr330231661cf.35.1779280620461; 
 Wed, 20 May 2026 05:37:00 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-395887b42f8sm30145641fa.36.2026.05.20.05.36.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 05:36:59 -0700 (PDT)
Date: Wed, 20 May 2026 15:36:57 +0300
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
Subject: Re: [PATCH v4 08/39] drm/msm/dp: allow dp_ctrl stream APIs to use
 any panel passed to it
Message-ID: <nbrj2lyd6uhaiixyydlgk2t32n7mygdlqtkn4lq2d6qodjv2pd@2jfwwpdatw3b>
References: <20260410-msm-dp-mst-v4-0-b20518dea8de@oss.qualcomm.com>
 <20260410-msm-dp-mst-v4-8-b20518dea8de@oss.qualcomm.com>
 <oughavmmvruhnehdpa4e3ptigcb4wndugxazhoeg2yed7ubvgi@aa7wtrz5s6mx>
 <09c14a80-d981-4584-b4bb-8fb2430d7a0a@oss.qualcomm.com>
 <6b6uc5lk4tsxccwyyqlp4u6sqsv3x3uyu32qmgl63rgb2m4wuz@wjcroowka3zq>
 <272690cf-ca46-4b21-a979-3c89de15747c@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <272690cf-ca46-4b21-a979-3c89de15747c@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=WaY8rUhX c=1 sm=1 tr=0 ts=6a0daaee cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=COk6AnOGAAAA:8
 a=EUspDBNiAAAA:8 a=FOiHO5QgrhE6IhRZvyEA:9 a=CjuIK1q_8ugA:10
 a=uxP6HrT_eTzRwkO_Te1X:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: __vn27K2ChGe8jjj2Bu4sIGCEd8fvl83
X-Proofpoint-ORIG-GUID: __vn27K2ChGe8jjj2Bu4sIGCEd8fvl83
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDEyMiBTYWx0ZWRfXx7BtMwkSDrhO
 9qnnLaP/bbkDWts94asekf9dYr65/z6wYJrd2VDiCvWIUc7p8t3XDTjT9bkcQc2IE+inEPw3kLv
 cMXVAFEz9/+UnNeZMM5j9/+tdVlDbJVDOTlEjRXzFBmVXGi0lrPSoDLoObbtUcLOmNW9lPOXj8M
 eIXiBzRNl8Vqpx0pSURNK9syXJqxkV1lElnMHiiYskBfcvC3p1MQF+Sj1iFNWZwUfVQg/YL+27N
 qZXE2w85cdEUH9ZTvGnwpxA1R+TWnwkxq5U7DJQtXjlsmE0mjup3Kds2GPDPARZJWxaV/dyZVdr
 bCKhZeorUQ6PDtuooSpR5839ahN4XaNbqpeokdLXMGb9NX1Gmny8hjB6zkcihcMJAtB2xQTcUNl
 eNVyh/FzgWyQLqDojQb6bqtC27vKJCPPftxiit3aEpz5YZ8+v7aBoKU/8Lfq5nSty+xBIaP+gYa
 UFhXUAqc9dP/PUJmUPA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 clxscore=1015 impostorscore=0 spamscore=0
 suspectscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605200122
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

On Wed, May 20, 2026 at 06:31:24PM +0800, Yongxing Mou wrote:
> 
> 
> On 5/20/2026 5:24 PM, Dmitry Baryshkov wrote:
> > On Tue, May 19, 2026 at 03:52:35PM +0800, Yongxing Mou wrote:
> > > 
> > > 
> > > On 4/12/2026 1:38 AM, Dmitry Baryshkov wrote:
> > > > On Fri, Apr 10, 2026 at 05:33:43PM +0800, Yongxing Mou wrote:
> > > > > From: Abhinav Kumar <quic_abhinavk@quicinc.com>
> > > > > 
> > > > > Currently, the dp_ctrl stream APIs operate on their own dp_panel
> > > > > which is stored inside the dp_ctrl's private struct. However with MST,
> > > > > the stored panel represents the fixed link and not the sinks which
> > > > > are hotplugged. Allow the stream related APIs to work on the panel
> > > > > which is passed to them rather than the stored one. For SST cases,
> > > > > this shall continue to use the stored dp_panel.
> > > > 
> > > > Hmm. Why? Can't we get rid of it (in the followup patch)?
> > > > 
> > > In MST, the stream panel is bound to the connector, but in SST the panel is
> > > still stored in msm_dp_display_private and msm_dp_ctrl_private, so
> > >    dropping it does not seem necessary at this point. The purpose of these
> > > changes is to allow the functions to operate on the MST panel data passed in
> > > per stream.
> > 
> > I understand the panel being stored in msm_dp_display_private. Can we
> > drop it from msm_dp_ctrl_private?
> > 
> Dropping panel from msm_dp_ctrl_private would require adding a panel
> parameter to approximately 15 functions in dp_ctrl.c.  Would you like us to
> do that in this patch?

Either this or a separate patch. But it should be clear which panel gets
used. Otherwise we risk using a wrong panel in the MST case.

> > > > > 
> > > > > Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> > > > > Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> > > > > ---
> > > > >    drivers/gpu/drm/msm/dp/dp_ctrl.c    | 21 +++++++++++----------
> > > > >    drivers/gpu/drm/msm/dp/dp_ctrl.h    |  2 +-
> > > > >    drivers/gpu/drm/msm/dp/dp_display.c |  2 +-
> > > > >    3 files changed, 13 insertions(+), 12 deletions(-)
> > > > > 
> > 
> 

-- 
With best wishes
Dmitry
