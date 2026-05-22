Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5EEDCD5BB1
	for <dri-devel@archiver.kernel.org>; Fri, 22 May 2026 11:35:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A74810E155;
	Fri, 22 May 2026 11:35:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="laXkivSD";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AgxTaOHN";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 86B4210E155
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 11:35:11 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64MAIiN01800725
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 11:35:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 sACrtE6qtRhpt2JdQIi5CbPXs8tHHRt6ISGnQM29WhU=; b=laXkivSDvSaVyOlM
 3/Pzs64SNB+lrSASVuNZWJuraXj/YvBXWCf/MWOyxg89gvkoa00EHIUCUul9u4oY
 NFMNNGT+0+kR2zmthaofRhwQsJqvVLgW6oxqOFiSHgIHUYgU66xajSazK012xCpZ
 GjcSIU9o00ugx9ovs8QR949SE7/sHLra8VdO01YS1HSjcbThvDcmaTniUvyxGKVr
 8sWfgXNe047pPqlmJBQqR+UcEhF2kwvJNWLpT0f4xZZvhhv6a/6N8JoAoEDQsq9/
 mSVCZr2BfBX7Zc0jVI/W2LosOb/Y6xhRlV9PVfKy521IzHwP06oqCpYtxdZ+kOO1
 cAlagw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ean9g07s7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 11:35:11 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-50e62562b6aso21752081cf.2
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 04:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779449710; x=1780054510;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sACrtE6qtRhpt2JdQIi5CbPXs8tHHRt6ISGnQM29WhU=;
 b=AgxTaOHN3bs1/thrPU6eN8qfdUrnL/6zHLPfjkEZ9HeuFRpJw2/MZD1xrbUAK+h8kg
 eZz+4UZSSf2v1ZrxtMGZGXdzCIEU0LbXj4kDa1DDy7MXxHrLk9DwUVwkHqeSdlQIOyIq
 nvTqw4nP5u35USDWTqp+CNQQivbHxUQPPKBJR8RsBS18CQc8G9TLUkynYAkkqO+4VFe0
 ge11W4BAo/OdMzeN0mf4sf7z3FWgxkANmNA4/uKXLot5a8jTuxSmtcB8fmZ6043PgRgj
 N5PAr11oWnfhrwT/vR3TjKSFyu8+9Oeq/EuOPWKgsVtAwyfixzL/MOPTAmNb2WgKZpnI
 grcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779449710; x=1780054510;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sACrtE6qtRhpt2JdQIi5CbPXs8tHHRt6ISGnQM29WhU=;
 b=lfKDtMiDMHGlASIG3FmxhoAytHMoveC8MHIhR2VePUf15OFO/AKz/tJV3hvfhaYSOc
 oelF6LFcQHY3/6ZqY1tSX4r+79trrbFI2aqIpmSYh0i3yj5Z36CLs2NM4gw0YkAZSMQA
 HMRfLgXNHeRXhiHdmeBDAdgVGv82k8pO2xGnuPiClkd+GItwKrJW6b/0AQNtWBcoWLO0
 KLpxPQOXssd0eSj0Kql2twysPJmt54c1jStgFOIqjZKlOp3dPIXXkkqsKvTg1PlutxG0
 UV+2gMHOVxrosU2Xij2PTT62jIuixoKYlJE5KzA5lFi+jx4uZV5eRVHg1UpCAkRcmi3t
 VsZQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+2O/u24OXrFpTvQxKw3yyFhDjkdR90JJmsai2WDkZ01uIHaDR4f8R7ER8QliPyiw9dtD2WCnIxS7o=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzvwV2AT+wtayc0Mtk/kjquGQR8hU581O++ENWkcU/Yrv4J1nnd
 AYM+xcbWx459BptzaXOsE4wr6jkfARF5OMS2qeVj3p9yjiInVjw3pHvP0xPhL98Uc3NU2PWDoIi
 H9OKHjjz5dAWkD6FSfNs3ok4yoWVnHmLtEmM8p2jKfZ8/U3/QvwMLgxG92UPUZN5gfrvpE+E=
X-Gm-Gg: Acq92OFM6SWSe2iiEHd5PZhsB1gJwl6jVNJHoa4HtA/JcwUqVQ9+dgrB7tyKc6256Df
 W6LvZupDkbG2iA40l8+D4Q74JmmSIrdVYx2/ImwsAiOebykIygMCXPxuk4I0TXDSGC6lOEKsnbY
 W5Vv101i3M6OtSaEkztO+8nBjaKS8LhxpJIhTSP3uQxsPkFS/LEQwDmntchsRnuC0MUps9/iDTA
 UlYM1SX7DSW0XYLqpbwRk42zMnFWMQeqmQ/aWXbWDfbionWr7k8HzNDfZhCLOWhmZb+MnrCDFAv
 9zDbn2Rp09IyGzT2nSXhTYWoc/9wFjJ/ePUlMYKnj+CYRfgJqm4FItowZD7YOZcKsZvAjrShfzL
 OXP8wqlYcIekaHjshHzpgMh/DI55TVIoRfPFGrbKyrq0BZg==
X-Received: by 2002:a05:622a:4a07:b0:513:43ce:eaa3 with SMTP id
 d75a77b69052e-516d43cfdbemr33251031cf.6.1779449709965; 
 Fri, 22 May 2026 04:35:09 -0700 (PDT)
X-Received: by 2002:a05:622a:4a07:b0:513:43ce:eaa3 with SMTP id
 d75a77b69052e-516d43cfdbemr33250651cf.6.1779449709460; 
 Fri, 22 May 2026 04:35:09 -0700 (PDT)
Received: from [192.168.119.254] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-688b72cbbf3sm571364a12.0.2026.05.22.04.35.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 May 2026 04:35:08 -0700 (PDT)
Message-ID: <0093e285-e38e-4586-8dde-1fbb1ecd8425@oss.qualcomm.com>
Date: Fri, 22 May 2026 13:35:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 05/10] drm/msm/dp: Drop EV_USER_NOTIFICATION
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Kuogee Hsieh <quic_khsieh@quicinc.com>,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260314-hpd-refactor-v5-0-0c8450737d64@oss.qualcomm.com>
 <20260314-hpd-refactor-v5-5-0c8450737d64@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260314-hpd-refactor-v5-5-0c8450737d64@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: R1h09AOmU8ncJEqbwz1dRcyVt2nS6ryn
X-Authority-Analysis: v=2.4 cv=B/qJFutM c=1 sm=1 tr=0 ts=6a103f6f cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=ls25Rwon0kCaizU-UYAA:9
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-ORIG-GUID: R1h09AOmU8ncJEqbwz1dRcyVt2nS6ryn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDExNSBTYWx0ZWRfX5ICL2HU5wAMU
 oc6RDLlf2FC6EMoJg0kytau5i4rvfoFh3miYPQu7xh7ouyS0NmrdywupbgZvmMBPn/it/W9kkUX
 bZoPNPVCA87L36HTsfaQJtctRuY123OEy1uw1D9F+dCvIdZd/W7ylQoDSw6NlqrF9fqOyLiLB5L
 TNtuEUwImEOUZRwh0/X2XCB5bRj8qDsdqVkhpwTsv2iXeuTC3KNPNkyCwvjtkeEjIAwN0C2n5VL
 L+3rgOdrvjbXPLGw2eGN1fS/Z5dWDPYX5g6K3lqMmg4hUBqYSgsQ4WXMkF+GHiwlR7tOjemXPd6
 RzFGUJxlWPLFISmz/wGwN9aAGLA4HGKM/KrrNqXh8KO9snAvuMpgrFZ0b/QXQ8uNZJk0c2FYDQH
 bxoPFKp747CbieCW/enMNnycnaCZ8FC6dUUnvT0uQKh7XkMz3IQjUD6bCjRSekc//IdgCVKs8mz
 24zB9MRNDaYVGQLCfKg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 suspectscore=0 adultscore=0 priorityscore=1501 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605220115
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

On 3/14/26 2:09 AM, Dmitry Baryshkov wrote:
> From: Jessica Zhang <jesszhan0024@gmail.com>
> 
> Currently, we queue an event for signalling HPD connect/disconnect. This
> can mean a delay in plug/unplug handling and notifying DRM core when a
> hotplug happens.
> 
> Drop EV_USER_NOTIFICATION and signal the IRQ event as part of hotplug
> handling.
> 
> Signed-off-by: Jessica Zhang <jessica.zhang@oss.qualcomm.com>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---

This patch hasn't changed since v3, so you may want to carry Bjorn's
lost rb

https://lore.kernel.org/all/ztriduhwhimeztfdgijai2qeii2giaosb6qizhj4skxg6k5uq4@bi6vomgv3whj/

Acked-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
