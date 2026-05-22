Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BEB9CD5BB0
	for <dri-devel@archiver.kernel.org>; Fri, 22 May 2026 14:38:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D15BB10E22B;
	Fri, 22 May 2026 14:38:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="mjj5laBc";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Fei0LIra";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8069410E222
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 14:38:35 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64MB0VNO777157
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 14:38:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=9OhurB6asiJNpRraM3RP9SYn
 VtMyAnZUk8kyafxuTVI=; b=mjj5laBcx8tVqDQ8knKZYEaIbqdFy9Sra4mm0rsT
 CPlgYV88h/MJoVURU4awms/6It5tSVJC5A4BOGdxt4D7XXLOTwU4WGILC2NUB9hH
 dFP3dVlntQxiP4InzgpAVaexJF95w+n4iSl2x2L0o0vXyOmeNz3msZ7AnQJjgSte
 vrndW7hDIUCK3f/dflSIGPyfxbX/S7Ahm+onD+FZIj0yeAO9qj00XDuVaUsg3cs5
 AFEXYl5pW2XI6Ey4JsSmcr9EiT0YVtqmlX5Bq0Ftoo5lmJJo+3lMF6U4Tjm/NFRE
 gdkvB1jQ7qTkpvljIK1kwJS9Y+MtEnOwY6aZWoYVLJovMw==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ea94h3x6k-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 14:38:34 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id
 a1e0cc1a2514c-95ccfd9b58dso11085238241.2
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 07:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779460714; x=1780065514;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=9OhurB6asiJNpRraM3RP9SYnVtMyAnZUk8kyafxuTVI=;
 b=Fei0LIrakhBLzvwNHE5RMWYLvYl1WoiTCmAmPuQry3d8pyodTxS2cX5ELxMcQ3lPX6
 NPFf7XBouj/cNFRQb05L34RR8PHJWTztF1XH5qQd5lLkXGWdiHYwQJYsBu7kuxtZUD2H
 99zk5lbEOoa3b1ReKZRE8V9rKGd7QUegDvvkdWm+BIsPjywXSPiHd6CXvcqvFhd0Yhjv
 TxwGTy3/vef+t2lCnQO8jav/pj9anmUfTqBsYiU01QDinGAAFCoarctQ74d4FJDAAcLs
 yblj5iD4yoQCaPw5on6JydYVX6jWB/ID9hWhlJxrguj4BT/+xgLxNQD/qEynW4AvtMjM
 sqLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779460714; x=1780065514;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9OhurB6asiJNpRraM3RP9SYnVtMyAnZUk8kyafxuTVI=;
 b=qU27wZ6HLfMqLVtSbMGXL0McFDSiIfbs5LJyZN3ycmdgIFkYPGpOQav8b3KAECZQP2
 rxnQbGOW0mFWdfmndWMhG0DABn936HNmRaMPofNVTixAJl8FrkHGC9kn/N84ewUUM5Kq
 tQyb3SBVWsn/UK6k0cR1QCZ2wl5T9pDB0APEH9MfeVq7FIMMKf5wxINpORbgf8918acw
 azIhZhwXzD/nD896DjC1kqU/nJ/jfNsdIT3n4AjA9rq22aINsVx51J34WKWmGrNNKxXW
 6TdKeFvVFPUBJZ08M/V0LYHzRK1a0wAL8/WlK6I0+f9F5zsEwczo1semDdTmUnfUhIEQ
 gEWQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8O/yov5OvSdrpNB/evJQ7Yk8QCZlc/Gx/4LW130TU2c41AGgtVH/8OuMo7tmVPJWocYR9ENs3tvHU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxXDbZpC+LFVQVpcbpr2YqT6wr/dH1VjopvhDNZM0khe340lz33
 4t2wW2FbOv++dvw5ANRzbUcMnYTelvdryoFtDpqReFCgzz/7hU2JSpmImspL7u5KV5wZ6Q1/Exe
 xIg9mBhW6WfzSFzumDkqKmdq2dd1F77JFb+XMG0FtbS06C1lH64YkUZjWBDu1zGX5fpvE/Xs=
X-Gm-Gg: Acq92OGIuyKx9CyySpP8RrE7REIB7pgx+Y7PRPlRFZ03FcsbT3fRWLJZhz2lD7RVnny
 5Vo+lyMEi8LllDnrzePgjkcc5HPyC0JRq0jaf3/vMMGYgfKb5AOuMjXkvfwZC7k85s8sKrMoXcT
 KYAXmGwFa5BHxeS09hdpYAMNui5E8dw/1+rYv9WFSodFHN+m0y7RhnpnfIdi9RBI3DvQonjyzmH
 p+7tIsfqA18kwXlyc3iU003c6WYJM4jQ+0FYBCadxW4Wns2um9XTH36J9ZO/2RYQgKhR+5eLqL9
 cNbqMCmtmTy2Ho1u16ZWK0QBjDuLSMx42KoEzU6OlCSLYEYf3xLXIrwRcnW+JD8CiyrA8ILk5qq
 jagORTQHubBdvYWYbX7ocfRMJBMzZYFz7T3jfhESdJNmK5KxP+XXCp8hfUBZYv+R9r7wHRtRf9t
 x4D/HZyOmWBpSX7oT3a9ajBrCi+DBNB3g4mVo=
X-Received: by 2002:a05:6102:390f:b0:62f:31d9:7bf with SMTP id
 ada2fe7eead31-67c898c2df7mr1789512137.17.1779460713814; 
 Fri, 22 May 2026 07:38:33 -0700 (PDT)
X-Received: by 2002:a05:6102:390f:b0:62f:31d9:7bf with SMTP id
 ada2fe7eead31-67c898c2df7mr1789494137.17.1779460713399; 
 Fri, 22 May 2026 07:38:33 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-395dcc45f38sm3538921fa.42.2026.05.22.07.38.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2026 07:38:32 -0700 (PDT)
Date: Fri, 22 May 2026 17:38:30 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Kuogee Hsieh <quic_khsieh@quicinc.com>,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 03/10] drm/msm/dp: Read DPCD and sink count in bridge
 detect()
Message-ID: <q3wtsw3djk47izq7za5p425wuxoykfsejpm5hs72jtbytnrgpn@in2o4iza7svk>
References: <20260314-hpd-refactor-v5-0-0c8450737d64@oss.qualcomm.com>
 <20260314-hpd-refactor-v5-3-0c8450737d64@oss.qualcomm.com>
 <c67ee441-83d7-4b66-ab19-c2c282c1b354@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c67ee441-83d7-4b66-ab19-c2c282c1b354@oss.qualcomm.com>
X-Proofpoint-GUID: VTEsaunmBOhqZiLR3WARp7rmMSZSqXLU
X-Authority-Analysis: v=2.4 cv=QblWeMbv c=1 sm=1 tr=0 ts=6a106a6a cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=pGLkceISAAAA:8
 a=EUspDBNiAAAA:8 a=oLIU8-4u4Al-hQoLB0UA:9 a=CjuIK1q_8ugA:10
 a=1WsBpfsz9X-RYQiigVTh:22
X-Proofpoint-ORIG-GUID: VTEsaunmBOhqZiLR3WARp7rmMSZSqXLU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDE0NSBTYWx0ZWRfX4Me97TtQgiSf
 6o57DeAY8Xghv5naPZkpEz+y0S/5/9goNtuxIj3cxgWYkleJOdW+p+zniHuLjOQFlbahjyEYcRu
 JZGo+hZsxB87Gk7BVEoyFsYBy3Q2n5pdesBTwVfX4QPHIONTntYt9Uc+OK819IOo+hg8F1pMiDf
 o22YQ87qkf2eWZ2HLVKrlmXcEM2MnBWso0R2XzzWOIn63OFtKyZ1G+2fRhf6BRnNVYjkQJUBhK6
 bIrhDnVgBc6TSz0JcCIfgsmLvGetS+voqqnUtr5Ukul9voVWhT/kp2yOiaxC5MQP6uTJL10Rywa
 y7oRc6FJoPCvloYJDgRVmJGju59JBdahl6lpWgbRiQEPZfMVzjl524R2igLwDVlF3jeFJQ74tVF
 nMOAp2ejHHZk78ElRtTFmUst9+tcUKMzxk2h92QoL/OJKo/IJeZFdcY41LwYzcB8XASkst3Y7bj
 NqOezCeMvuzrKVKruvw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0
 suspectscore=0 adultscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605220145
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

On Fri, May 22, 2026 at 01:30:54PM +0200, Konrad Dybcio wrote:
> On 3/14/26 2:09 AM, Dmitry Baryshkov wrote:
> > From: Jessica Zhang <jesszhan0024@gmail.com>
> > 
> > Instead of relying on the link_ready flag to specify if DP is connected,
> > read the DPCD bits and get the sink count to accurately detect if DP is
> > connected.
> > 
> > Signed-off-by: Jessica Zhang <jessica.zhang@oss.qualcomm.com>
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> > ---
> 
> There's still some trailing style/documentation feedback here from v3

I'll correct most of the feedback from both you and Bjorn. I'll leave pm
calls as is, without using ACQUIRE macros. I will think about using them
for the whole driver rather than just a single function.

> 
> Konrad

-- 
With best wishes
Dmitry
