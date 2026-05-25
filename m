Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A078CD5BB1
	for <dri-devel@archiver.kernel.org>; Mon, 25 May 2026 13:35:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 48CFF10E33D;
	Mon, 25 May 2026 13:35:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="jpXEWTkt";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bZjVv6bV";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0401710E122
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 13:35:04 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64PD3kYl3604073
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 13:35:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Ci3NTfd62mXuPPJg67dMPpYqDLH0VqKpkgnmnkmbQ8o=; b=jpXEWTktXisZiWn8
 bQr6axdUkX/WFiPUZYf7ToQuXEISSqLFzNEQgSaWilrMBELJ0ucTPkavhahaGDhQ
 qsgcaGRxMirZANhMKnrBmRuBdvSsx8aALE4c8uMgYaClpqxTmQzzmFo8lf5w1RfM
 LUwKJm1k5Kb3U+LWK70M8n3NZlhBg2rIbNTwS5SqPi1roZmVcNRoeDJ2d/hKT2RV
 SzZJpENw5UmF3kdmaPpDsxAv8zRxd4dgLNz0U2RbQn5qVE2GOxjsaOl2OJmCe1PO
 klqlsUF57OYwcGkhkF1xWqM93KFhX8p0lAZ0lhO4HldRMYiHiVitNdS9xJYyTwqQ
 ZZRDuQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ecpyqg3wx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 13:35:04 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-914ae409b05so80842785a.1
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 06:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779716103; x=1780320903;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ci3NTfd62mXuPPJg67dMPpYqDLH0VqKpkgnmnkmbQ8o=;
 b=bZjVv6bVtffaGE1KdE6dKxaGSUw1Hh6klZsbgvsSzI7b32o8qavzp/zGaqb2Z7H15i
 6GsLM8fJ2SpAfMyJBdH0cRBaVZd4m+2EZvO/BYChfI6GENcs6fFmzZwKr+JoFkr4B8ae
 J82P4cduB/dxx3iyAbyPJTtDR18qz4RVUjd62kug6+lrM5DZRk4dZSGfmrqnHvb1d0PS
 zSJmlBKhlKdPs7ykNI+JW/hUfVSSU1pO+oMKxmeKkxkKwaS/TvOTTSWirQnpz4dg5d2S
 7iUvvLeqjE5QQT8t3XeDolJoAcMXHZA9+8gaI9lfi5wkzv1M0PsjGoCT5sN0zlSac17a
 1yuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779716103; x=1780320903;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ci3NTfd62mXuPPJg67dMPpYqDLH0VqKpkgnmnkmbQ8o=;
 b=mTYLvk3dkXdm42qjlXcMTOW1tiKAv4av7rKFjxGYmAU9HdVzhuiXSAn5tdXkWfwj/7
 WcglBu+gq+Qo6McTy09g7ZV8c/+tEn7cRiOUprNkMBjCM/4qPj7QjDb3My6FyTEpqGf+
 RDYF4y++g7QisP+nvG5Q3qfOZIQPpJWkxfNY1hoZAkq1B50Q2KOaYr79/nr4ZLKv09bk
 6GIl0AR8Q9kYXmqOsnZn378VEbSagYLBIUrKkPzOe65BSB306YvOz2uGpTKpXpV9UaaX
 ibrm7VNj8Su/aorxFgcHmykQ9lvQrSuLs8zjUn6o5NbfqlaPDNGgpGUPkilbSEZ3+662
 9oEQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+8SQsWLPn218RHH0hLWXa3pN7vwesuT1VR/9EHXS4y0LGvYQYDqgcZW9H82jhXhS96dRxW7f6Y4LU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwqjRAkpL/fcF+kDDQEZdbqjLgmZU68Jpo+teFVwfztbjYZ1BW9
 F31WV+sARp2iKkhmJySurva1LHV5uB7CGj4iuovzSo3UZo/Mx+X1hSXymP6RGoC+jX7Alatia4c
 JjAeQxqF36lS7G3v65AByStfcG2+2ffbev6N9zqw/lrwD8Rlk0cCxWI2H5fe74LapJ6Xl674=
X-Gm-Gg: Acq92OFSYqapKv3GR9lmqp0bZlukFUbELGHHE8aP+a1oGDL+zAnBK/SOhXzqSsnpiQV
 WOViKdQBoyWqkfOjFQwVKmatXPGrECeudrJ4pqiRhPrlcHvuRZ85zJc29xkBsRKA331BZUmp3H4
 sG+QmB5iWsW0e/vvhHNxT8qmQ/OcJIRLdJEodBAqlgSTqiqI33QN5171e4hwSZoyv0wG2qygEXK
 xBMSDZWdgljNNvcU+fNArfK6fbYL0x+hpqnkzttoHV1T35yo6YRpfaBf0vSLrRprC6r634ItT6D
 o5qxu0q11Bsk8Z4MUq5ZGS/vHahqwyjRkj8fbQzOIXufYPfvF/F/6ZomARb7ks8nN0jyRoQ8r1A
 7qM2L1SDbaasxch/apshINCpSWdC47PJSOtPfA8LDeqZMsg==
X-Received: by 2002:a05:620a:172a:b0:8eb:605f:6ccb with SMTP id
 af79cd13be357-914b46c19demr1384682885a.2.1779716103465; 
 Mon, 25 May 2026 06:35:03 -0700 (PDT)
X-Received: by 2002:a05:620a:172a:b0:8eb:605f:6ccb with SMTP id
 af79cd13be357-914b46c19demr1384678985a.2.1779716102952; 
 Mon, 25 May 2026 06:35:02 -0700 (PDT)
Received: from [192.168.119.254] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-688bb133f7fsm3958041a12.23.2026.05.25.06.34.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 May 2026 06:35:01 -0700 (PDT)
Message-ID: <be3f22a6-c0ef-4559-a576-722f684cc82f@oss.qualcomm.com>
Date: Mon, 25 May 2026 15:34:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 04/10] drm/msm/dp: Move link training to atomic_enable()
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Kuogee Hsieh <quic_khsieh@quicinc.com>,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
 Val Packett <val@packett.cool>
References: <20260524-hpd-refactor-v6-0-cf3ab488dd7b@oss.qualcomm.com>
 <20260524-hpd-refactor-v6-4-cf3ab488dd7b@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260524-hpd-refactor-v6-4-cf3ab488dd7b@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=dtfrzVg4 c=1 sm=1 tr=0 ts=6a145008 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=UhmnXqIqSmzi-CRdO7cA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: DAQjbYJ-SJnhZHLI7VG1XiV5lPpjeeSt
X-Proofpoint-ORIG-GUID: DAQjbYJ-SJnhZHLI7VG1XiV5lPpjeeSt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI1MDEzOCBTYWx0ZWRfX/Vq8sP5jB/Ha
 MIqSrzTgS45zYbmISoteA52tvqhZp7Rlgr6pBTps4Ck3AOPFUOiyd/tB0u0I29R2eHVfTCaJtyD
 vRcgeALzdTScYxa1vuT4SZNMvvRnGO15momZJqALMbNJ6u543lyqH7drDcBXZSmXiU9mjuTKObJ
 ClTHeF1qdITfEAT+UnLK9jDBpqq9P69hlRPwDWOY+Qja4i+c+YkwUBi1cHu6X5LNPfX7dLi09y2
 KePW8wEho93TSlUNP+Wfn7vIJAOHkMEJQ1o1QGUGwcg3Gh2kweoKKoAK1eYQZq43CMrqYQR+xan
 cO43ArBWmhOgfDzCbSqlz1Q5YU9HeFXsiixk07YJBI6dXpYffKTlUwBhSt42sbedtPweEHRDqd5
 bn+tH7f3JHgHnEweFIbEvpRbrML9GaZrQiCS7sBUTf04QlZ/fn41/D9Abfeg+ANBF2TuNcPCnty
 SCK0dTyPeyDz/959YVw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-25_04,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 suspectscore=0 bulkscore=0 phishscore=0
 adultscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605250138
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

On 5/24/26 12:33 PM, Dmitry Baryshkov wrote:
> From: Jessica Zhang <jessica.zhang@oss.qualcomm.com>
> 
> Currently, the DP link training is being done during HPD. Move
> link training to atomic_enable() in accordance with the atomic_enable()
> documentation.
> 
> Link disabling is already done in atomic_post_disable() (as part of the
> dp_ctrl_off_link_stream() helper).
> 
> Signed-off-by: Jessica Zhang <jessica.zhang@oss.qualcomm.com>
> Tested-by: Val Packett <val@packett.cool> # x1e80100-dell-latitude-7455
> Tested-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com> # Hamoa IOT EVK, QCS8300 Ride
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---

Acked-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
