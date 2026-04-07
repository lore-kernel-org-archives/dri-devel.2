Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45B75FEEF24
	for <dri-devel@archiver.kernel.org>; Tue,  7 Apr 2026 11:26:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A10BC10E036;
	Tue,  7 Apr 2026 11:26:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Qk9SYJLP";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="apruxENG";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BFA5910E360
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Apr 2026 11:26:08 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6376p3kq1407046
 for <dri-devel@lists.freedesktop.org>; Tue, 7 Apr 2026 11:26:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 4aXd8HT5b40tGbD461q6/FXJuEZ6/7PBRmqsBkcdEEY=; b=Qk9SYJLPmcSiobdx
 DDdpEomgeGQBmOYkdDskTWYut20jMe+eqh/qNYcj+pTIC5UneXAFr0sPG7HCzJRS
 fwRTUueOrhZDTq/96dNT0cUYQfYtI1qCnyeKPysuuj7qH/Znyy/J6KiuZk3pvSD/
 B0iwKlvIHB+tQWGKJFBxAn8TUJ/8RMWT5v7Bm7F84xyS4p86AMbIdol7WNPQ1SEN
 QqCzEKA6nb3lcPlo/JcgYxKIYtQmIo5cg+7WYd5sc8d6q8zqFnSOV4xnSJh3e5Ce
 2ammEG1tXFAd9wKJqTR+n6yxnnGVduTRaDR6QhDsjtLu1+yXPyRa+PXQsdust7nx
 M9Mx5A==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dcmratfc5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 07 Apr 2026 11:26:08 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-89f48d009c8so19849906d6.2
 for <dri-devel@lists.freedesktop.org>; Tue, 07 Apr 2026 04:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775561167; x=1776165967;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4aXd8HT5b40tGbD461q6/FXJuEZ6/7PBRmqsBkcdEEY=;
 b=apruxENGCvUu9SFVwWq3VG8b1z+6nOR99x0bByUQapGP8BYYM3gKlHMyEhSeVXySAn
 AtED7jfGTgSla+r0uKMPsMjHu9qjpPJLrxEbQbdMYeh32HXFoMpOz6J7h5zgKrjvXcQX
 62WQAeOh6bFYlfboudmha/bApdzUmbqsjFsXzkAft/WZYGsH6JW1SnZA7uegrUCbnk6Q
 JFR/jAFLHMPnBAV582Nb/oUvZXo4HXPRvZnge0pkzFRfaXKDiCwtqReuCSpo7TPCL9x6
 9yHOPIx5IAVXEcW/oU4Uxk8uKmrS53eRKRDuHWFYySy7erdRh92lyIGVtME7YCBKkTnU
 Yn8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775561167; x=1776165967;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4aXd8HT5b40tGbD461q6/FXJuEZ6/7PBRmqsBkcdEEY=;
 b=CHl74PZfq76VlZ7b2VSijVVWKNpzP0YeCa3ED7p/Pmclco6WzIUGLoILhRezi4wiul
 gfJjHcCBEHbAfh700BJrhSo3wlotDBGzmWlcWfkF1L53KM6K4YAJ6e/60K+8Yv39QLrJ
 fgtL+3G2/viPpiggNtySB7Zix7eGlJhKHFeGfEooFVYoK6I96rTpUJgzmlp+G82+lIoI
 w7cpgxqy91MC+kBz4xzkmS6Ma4yDZghQDX9PLAz3GTHsSNlDyUsyZXl5ewync4I/xZ66
 tWiAA40sagE7cYcYXx5sRXL/5uJwwPXnBzsvO2vofmbrGMEnnm3es/pkP7DOtSuMwz9i
 JRjw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUKl8YbeErcPRzNYvL0QdmFJPQBxxZCxRvWVnLgeQcOA9HLbfQdYW8PWUWO69Z6sZUNPYBfC9hr6nI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxebHdWVeTEFepagu7quyXhYNdNdnvp2EWnqAX/e6ztY3KLQ1oQ
 fPvPhP+3Q5YZ1VtJIw6jiMs+gTIiBsiAczirsxdXqPF8AA6eXZWaE0m+5ROVSo3qWN8mJ4UG+S6
 lUZ6zJH+WCWPsfy9PAM8Jis0tl21v9bdjCJyO6I4XFxM+kCBxsdvO9uAQ4f8cjuvRcs4XLKo=
X-Gm-Gg: AeBDietoiv2/UZCl+bl0OKDyo+ABCORKWJWZ4OBp4YruKMSzVeQBkBn5/AS7apN/GNE
 HD6UkmxTQF4G4tqSvUeZQfyd+Es7HDVE+eog/a2LapZvuIO8Xh8arNyr6vG4BxRBpklqUda8AHo
 ng0NrZE+XeiqfT+eO9trAvldes75MPaXnADNgdF0zkH4DU+5jdaqH5R70E9FTIpfqz5h7cccXiK
 2gKSX3l02MOATDsEKOrtsWXg/2iUmMFdrCUasNaJ6FPV/7fdUZK5glOsCPAaUmv0aaY394ZzXdY
 0EGgXDKU6uBuQmG2rskxvbcffaNcnQqCGX6gcgvqCPZozVm8WEYHd4WruI71Y8h+AITgQJ2fIEK
 uHoelQRWvaEFBKVbhhmOLy+woePoJXtuxprhmQkwhykugBFzJY8gGrfz+Y5XRsNisJY9lVjiJTh
 JkD60=
X-Received: by 2002:a05:6214:20ac:b0:89a:575e:ec01 with SMTP id
 6a1803df08f44-8a701aeb01fmr190561096d6.1.1775561167335; 
 Tue, 07 Apr 2026 04:26:07 -0700 (PDT)
X-Received: by 2002:a05:6214:20ac:b0:89a:575e:ec01 with SMTP id
 6a1803df08f44-8a701aeb01fmr190560776d6.1.1775561166945; 
 Tue, 07 Apr 2026 04:26:06 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl.
 [78.88.45.245]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b9c3cec6c11sm558375166b.30.2026.04.07.04.26.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Apr 2026 04:26:06 -0700 (PDT)
Message-ID: <11b683e6-aca6-42d2-8993-b9aae39ae44b@oss.qualcomm.com>
Date: Tue, 7 Apr 2026 13:26:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/3] arm64: dts: qcom: lemans-evk-ifp-mezzanine: Enable
 mdss1 display Port
To: Mani Chandana Ballary Kuntumalla <quic_mkuntuma@quicinc.com>,
 dmitry.baryshkov@oss.qualcomm.com, marijn.suijten@somainline.org,
 swboyd@chromium.org, mripard@kernel.org, abel.vesa@linaro.org,
 andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, robin.clark@oss.qualcomm.com,
 jessica.zhang@oss.qualcomm.com, abhinav.kumar@linux.dev,
 sean@poorly.run, airlied@gmail.com, simona@ffwll.ch,
 alex.vinarskis@gmail.com
Cc: Vishnu Saini <vishnu.saini@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 freedreno@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 quic_rajeevny@quicinc.com, quic_vproddut@quicinc.com,
 quic_riteshk@quicinc.com
References: <20260402095003.3758176-1-quic_mkuntuma@quicinc.com>
 <20260402095003.3758176-4-quic_mkuntuma@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260402095003.3758176-4-quic_mkuntuma@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: TyRgYeFuN3PlhyjeGw__fSCXSh_4Y7Kt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDEwNyBTYWx0ZWRfXwqn25c42C+bc
 HgPQw4YacGfbMlN2pW3WJ/AphY2B73gAu1+v9Dkw2/qwAWY+rMhMeZf7TTV2sr17MXDCNaLtkir
 HuUYUFILp7Le4XXzyV4IVdm41aKqv/02csFagj6STsoez0hhOo5M4nYlpeFxSjP+vsryljJ4s7D
 6qcKJ9eNmS0rpNkhvAle4VY2InUPu0D1xOBcwpU1nZ+kDUbiWhVYRYDrq26bDFEBku3GpsXFM3s
 jgcKEOYJdiQ+qEVE1xK3PJzIzpGKPMdWpKj6uxOj1LPt5bhs5xd+RFfiBX0VVWkGZF8etzBF5Hg
 Isrn7/prbSoqmFixtRFm/zaogT8aSae32tkWsMwP3YypDwMBT61kKxq4wMSWN7J73/JBhkeeHC9
 tj6sWjaPArosOz1gq3kJQfEaIVgd4Zhv2w7zqCJ/OVzHIxUeZ9tARj7Syp9fNvuORR0mWiAxhRR
 8vbXOlPh61qVv96/+FQ==
X-Proofpoint-GUID: TyRgYeFuN3PlhyjeGw__fSCXSh_4Y7Kt
X-Authority-Analysis: v=2.4 cv=D/d37PRj c=1 sm=1 tr=0 ts=69d4e9d0 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8 a=fOsgxGAhkaL6H6YktGQA:9 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_02,2026-04-07_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604070107
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

On 4/2/26 11:50 AM, Mani Chandana Ballary Kuntumalla wrote:
> From: Vishnu Saini <vishnu.saini@oss.qualcomm.com>
> 
> Enable DP controllers, DPTX0 and DPTX1 alongside
> their corresponding PHYs of mdss1 which corresponds to eDP2
> and eDP3.
> 
> Signed-off-by: Vishnu Saini <vishnu.saini@oss.qualcomm.com>
> Signed-off-by: Mani Chandana Ballary Kuntumalla <quic_mkuntuma@quicinc.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
