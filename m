Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A130DF531E9
	for <dri-devel@archiver.kernel.org>; Wed, 15 Apr 2026 09:09:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D99A010E6AB;
	Wed, 15 Apr 2026 09:09:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="MvbVJdaB";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SWxr2J3L";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 797A310E6AB
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Apr 2026 09:09:49 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63F8NmEN2972580
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Apr 2026 09:09:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 c5CT1Jp/CdKTDY6Qft+lN/F8XFsY9d2RcRwPpRnUkDI=; b=MvbVJdaBirpNMH1H
 Qd0xP2cb43lG8iJF+zyx08lBmlrYDKZPCGOzhpQW+lSRlGYAfhb8BXiRBxTyYRyo
 VxCb1GvEN6Hw+8QORCoZidwGft76gjxYBFwtMZ+CSBDIPsH2zV62bhGFhZBQ3XCe
 /AV6se7FlW6PtEEbKzMJUGqCPXs1LFqYltFZEpaHxZw8tU8cJRBtf4PuTAif05Gj
 CMxekpgJIYHZ5JHkSIJDIBExAkziKqHK1tn3VKC0/XMyafI/epg0KUk/bfLI3ysX
 +wEHi3/R4LFeN/mZdVRth5pnWy1WY1wJfSPYJCeYa3boaeW9o+EaVTy9Hn/CaS7m
 nayFBQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dj74g857s-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Apr 2026 09:09:48 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-35da86144daso7572508a91.3
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Apr 2026 02:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776244187; x=1776848987;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=c5CT1Jp/CdKTDY6Qft+lN/F8XFsY9d2RcRwPpRnUkDI=;
 b=SWxr2J3L23XG4T114dKfTskthjMafjCsEGD/TahsJpOKt+0SwWWPTMzeS4uKT83ERu
 3z6DscBVjcmyEQ+xVkcm9QSp90F4U7kK/zWvGUzFBMlVBhiKtzgmfClm0QLkGfGOi3fm
 ZDKtt4hImXJPDQZv55PARoVUrCf7WO8Tj6knZDogOFIDGGD2ROALO63hFZ+iZLwb/SR3
 h/3igcYVKwyhHm97+2MwfPgLggdzVMws8x27HjOiqsiFZTzbaDOL5Xsesdf5WK+tO/dw
 cPDiCSMCp3oX0lGgCSjF8WzLnmE6pv3PE0d4YUtB4xaXDEByCR6iq9bfBZgK7Fywmrlk
 73qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776244187; x=1776848987;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=c5CT1Jp/CdKTDY6Qft+lN/F8XFsY9d2RcRwPpRnUkDI=;
 b=GILkgsENM+f+X9wUwrCXLbDSlEm1Fk8BgbOgpJ2BQmol3f2aJfL63e9n0gtrbLpSR1
 I6pgzdoCPwj2pbR6TOIiKcA3DH0Up9qKBoYhdYztXbHkh016oHdqiEI07Pk6yRa+TWzt
 T58BGcBnnkG0zi7VOzDDJye4Lmd+yik7hqRXS3mPSHmj5IUpvUwWKVY4hdSVelS4/U9O
 LwOgv5qtcIoUGRmmT1k7EXvV9uzMO0dXZBCAmXdupFT2+lRCgge7UP+HC3zqGoBVTALX
 Lsx3JfvMeJta2DVKaVyEOEMl+aQblZ4nFQEoQ6kMaf54aKeJq6c1ntlryBNeqBmhbNjT
 kDEw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9FIg86RLVbM2ILCML4dO0f73x7kviaoecBiz4P5XqycytQuK94kBFDjVR5prwzY+SzmKNtZs1GQUk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyrEfw68x19kOR4vbJ2+oUaA91qO8FvcQ0mNrYfjnEm/ty1QiNU
 LgCKxasosh0RwoyLqv+d8FjADois4twC3QaHXD9FbA9y4ctJtt1WABer4adWgfZqCQo9Yt9Cslj
 lvC3gOhNeMs0z0hejvYams2QoxLTZ8JrL45LuFfrrhdYi90zMfggoAbbmKPGQ6mEcRWm9kiU=
X-Gm-Gg: AeBDieuOzVPHODL2eUuAxWHVOyDL7UzhXZxAqK0+7eMco0xE7bsZhHeGWm6iL20QzhG
 BCHBsD5T3mdhy9nyzB7gstlnsYiocozqW2a5RS7/51klMTPIBySL02iclMFOouI0HNcYrKXf/So
 MepnwR8phaDm3eWJzYleb+XY3dNdlN/cJLdoQBHGgW7w/pU+BfKW4Y8CJwgQbWQhfhGWFcqQXo4
 DEHJA4Z0GNOEdwyT8CzC7Nuz7Ud9xng4qa4NuQOveL+C27SvZNHBbr/lfAjNnjPYLiieq45fCHV
 S+/Q5b8WFVpfvics9KeFVUVwsCTiD6qApG55T8uB6Dlz6x9fzfYvRRa4qRGB9NNx9c0n8uPz0HR
 lqNjcfnc4uRjbAAsvwwRu737nFBqmSgtmOBB6vjGlrCQgWpxr8L8g4QtKAfoF
X-Received: by 2002:a17:90b:33ca:b0:35f:b4c7:b626 with SMTP id
 98e67ed59e1d1-35fb4c7bb12mr11763266a91.18.1776244187380; 
 Wed, 15 Apr 2026 02:09:47 -0700 (PDT)
X-Received: by 2002:a17:90b:33ca:b0:35f:b4c7:b626 with SMTP id
 98e67ed59e1d1-35fb4c7bb12mr11763219a91.18.1776244186933; 
 Wed, 15 Apr 2026 02:09:46 -0700 (PDT)
Received: from [10.217.217.166] ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35fd2010246sm2343736a91.6.2026.04.15.02.09.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Apr 2026 02:09:46 -0700 (PDT)
Message-ID: <bf8a56f6-d7f7-428f-ad95-801eb16f1cc5@oss.qualcomm.com>
Date: Wed, 15 Apr 2026 14:39:38 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] clk: qcom: common: ensure runtime PM suspend
 completes on probe
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Abel Vesa <abel.vesa@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>, Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Ajit Pandey <ajit.pandey@oss.qualcomm.com>,
 Imran Shaik <imran.shaik@oss.qualcomm.com>,
 Jagadeesh Kona <jagadeesh.kona@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org
References: <20260407-gfx-clk-fixes-v1-0-4bb5583a5054@oss.qualcomm.com>
 <20260407-gfx-clk-fixes-v1-3-4bb5583a5054@oss.qualcomm.com>
 <c72e02c7-57d8-4353-a6d8-9dbf4f7a7e37@oss.qualcomm.com>
 <38aa8c0b-fb29-44c9-a346-363220264c7c@oss.qualcomm.com>
 <8d7baebc-db38-403e-b724-d4b214b5a51a@oss.qualcomm.com>
Content-Language: en-US
From: Taniya Das <taniya.das@oss.qualcomm.com>
In-Reply-To: <8d7baebc-db38-403e-b724-d4b214b5a51a@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE1MDA4MiBTYWx0ZWRfXwQH+QISu2ZQb
 yAEbuNgQIU0ZjyO33aWcU96sGcPlAomYZrm7PqkQ14EpH7uI0Coel7tHiL8mNY1cXK3t868wCuK
 iyZ2w3I4zAAtIxihO+LAralYyZkdm/gOLEcUO8E+gPtSeLy+SeAZaUZfh15Pi2vy9W+aysU8o2A
 YvnyuGUzSN7h/aoknUkqIjJqSQRjTC3xlBDE2PaacNLFiQCLSeO8V22UT5ikQtl731pex7mnX1+
 lwZ24fqU+zM+vex8FlnxSQQZSXUjz/HQXzwWPJPXAcfy8H7yPR1wVB3iX5JNJ9tik2N9ygu5sP9
 VupSeFXazTOuyxK/o7qN/LSnsb+TkbnMD5mBCf9Bgdj/2MVbScNbNKOgatV4CNWlGKaQ2UkpVMU
 m0G2DDIYqtnqETKwQbrNLX3Sl7MlhHGmj9bw64oVWJ+OFDtWD6ZMPx3bm2PLiRtbdMhzKdSFRvP
 HPSUrL9doXCt9YLH98Q==
X-Proofpoint-ORIG-GUID: JP6S9kIxUmrtYGC38UpaR6jThiVi-akA
X-Authority-Analysis: v=2.4 cv=ZIfnX37b c=1 sm=1 tr=0 ts=69df55dc cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=rYsFMFq4sQQjBG46XAoA:9 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: JP6S9kIxUmrtYGC38UpaR6jThiVi-akA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-14_04,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0
 phishscore=0 clxscore=1015 malwarescore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604150082
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



On 4/14/2026 8:12 PM, Konrad Dybcio wrote:
> Please mention that you want to do it on a clock controller device
> registered through this function, because currently it doesn't seem
> to have a functional impact on the existing paths

Sure, Konrad. I will update this in the next patch.

-- 
Thanks,
Taniya Das

