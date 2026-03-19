Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77F021075284
	for <dri-devel@archiver.kernel.org>; Thu, 19 Mar 2026 09:24:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DBCE510E932;
	Thu, 19 Mar 2026 09:24:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="HzXlmTWc";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Mk1pPsn+";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E9B1410E93D
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 09:24:38 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62J744Ji1998880
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 09:24:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 TckbxMyJi7AhkdcEUyt8X0pVJFCrYNyjJm/tTCzLAwo=; b=HzXlmTWc1wDkOb5/
 pkuFMz9+J40TgGDM/f58I4EfyeKayoD8ImOTEiyGFcD4774Owcrfvdfu4IcdlYaF
 9xnfhXTnhcpFNF64Fm8wfIdEikCP34A07rkHXhgJgNXe4QB5FCwd/L4YUAgiFQRv
 Mpl8qTblT4u1kRAIXqIyTNNXvOw11udGgBecU6ok6E8b6NSGVjolJseQysTRx/Mq
 2eO44CSBXmHwS0OF2psSt2bgm7A6IOc6bl3jDofZSgQMhiaY1gYcbeRGC7wfsS1C
 bECX0PVTwNwX+sTme3MPhxR1fuh/CxPg9S7IjeL5cJEATIndxgoeluCWHcRLoq6R
 /F5OpA==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cyscb4e2x-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 09:24:38 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-89c4f6c45a7so5412546d6.1
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 02:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773912277; x=1774517077;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TckbxMyJi7AhkdcEUyt8X0pVJFCrYNyjJm/tTCzLAwo=;
 b=Mk1pPsn+0SdUg7kD64lgRZOYicVbROuOuWRl255Fk9iRnUTs6Zc/tVpPCpvtEWO4jJ
 dKIJTC6XGTjt6pKTy/wO4SNU9j8N5MnHljzqUvsgwMzVN2xYyaCrcHN1gLpzJ8G2cehl
 IkbpLHEcC5DuIup6PWv+GJG8bBIE0CUwOMN2wYXcEp7FSmHqeZqN6lkqKn+a8ipJ/Nli
 g5nlomzi/sWRDx7dhEdjcryX32ivK5rMc5A2ET/7CEcz1LYQa0TV+4XHGfInN+flbsge
 0LrwoT6ywZa5Yt1w4eGihxH3LGeynYfc0IpteZhY/h5uWLAx8n1vnAa0q1g5eropRDiV
 zIBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773912277; x=1774517077;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TckbxMyJi7AhkdcEUyt8X0pVJFCrYNyjJm/tTCzLAwo=;
 b=aGrMCIrMTN/sT3YPZZG7TLeK/07TBq6khzyY7+vivGnA0PY6p75k14lagJEQdUckOR
 XFsaoq979TZHn7gXF/bijArgrMJxnkUgozmOPIXswY4uBSCY5rDWhG7+KrN83VMKT1Hy
 CQ99YyFfJT8yNNZ0++UXkI2pcIG2TnGEBFG2AlUcKDYx//9Qn4K3nYUI1W6nK8ykEpwC
 3Zjk4/078kPbEDvpPqrJcNGVeQXtOyLysGSsI1omrRS1WvlXPK0pQ5oqOA3vWENWXLzh
 rWzfQ20fonfY6U08OmMj30XhP4mP056HvUMak9JZriztWCulzMgiLDYSRM5TtyiYoXcd
 vNRg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX3NfnVabjdLiZ0AzOGj7aDOUaVjGk+w7+dpP5dMGV2exxhqb3bDFKQqi9pxMTNwX493wLVkk+Qpjs=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz875VNiVvMZJzqVfQoxamK4A8pKB2dDiQYRK1OPcI60boJEV3A
 RbY6ef62YEWT9b7RZjOpOK6HE4xYz3SdlmUEEIRMWIRZzcO41XyDLfq4xq19wnzYOOBoyhslAHC
 dAc8gLMsV85CY0uNBT6DdeFF59/tFYDEGvPJMV+NdnmBLSkYPIa56DIsoMeckwmTp9gNzQxE=
X-Gm-Gg: ATEYQzwxkkNr0XlQHs6+vSVbTMPWWkSb1vY6OoWxfB7vqnD9BgbCgt+5lghP5jlGxHh
 HDFnprNIG+T6LCvaUyLJeXN7ELfM3zzyMUV7vkeF65rtn9WsdCzDq8B3uA0CdCXfU7bjpE41HMt
 z8pmSgrFznl15hvKD78ebSSnD8Z5WNArB1zMGLBroE12rizCYMea8Qv1g+eQv6s8DFvX8sgdluv
 jgDsHF1RIg4HjR9YQ65myQgBF1bfA938rh32ToJwf3yMZMfWr7Trowd3W57EupIU9c4feEMdl6W
 vwSDwB7BlY8N98dJYu2hLEvGVQosehUvMurE2LDRYVyC+B3wXY+dAs2jRoN0RvR/28jlHp5au24
 3cM1UikMMPHuJzRp4zkWSNj8nfCDhhOPowd5sJ7PZ4ybLCQuINJJH9onUMaNFh6t6fj8GAy5Ix/
 pHqlk=
X-Received: by 2002:ad4:5e8d:0:b0:89a:4741:2147 with SMTP id
 6a1803df08f44-89c6b728303mr74824396d6.8.1773912277423; 
 Thu, 19 Mar 2026 02:24:37 -0700 (PDT)
X-Received: by 2002:ad4:5e8d:0:b0:89a:4741:2147 with SMTP id
 6a1803df08f44-89c6b728303mr74824206d6.8.1773912276858; 
 Thu, 19 Mar 2026 02:24:36 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl.
 [78.88.45.245]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b97f13ed066sm410962166b.4.2026.03.19.02.24.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Mar 2026 02:24:36 -0700 (PDT)
Message-ID: <5b9ce996-5cdd-40da-9851-2e7c8a40abae@oss.qualcomm.com>
Date: Thu, 19 Mar 2026 10:24:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/4] phy: qualcomm: add MSM8974 HDMI PHY support
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-phy@lists.infradead.org,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
References: <20260314-fd-hdmi-phy-v5-0-58122ae96d3b@oss.qualcomm.com>
 <20260314-fd-hdmi-phy-v5-4-58122ae96d3b@oss.qualcomm.com>
 <5a464fca-7be5-44a6-b124-7b80ea859a9e@oss.qualcomm.com>
 <dpzq6o4qdttbmgtpgit2atjghu2kwrcj36ko3rnvwaehbkvjrk@lr4ms7mi6aiz>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <dpzq6o4qdttbmgtpgit2atjghu2kwrcj36ko3rnvwaehbkvjrk@lr4ms7mi6aiz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: RjMHir6tINc0awBp4QgG1E2KCu9KUL6v
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE5MDA3NCBTYWx0ZWRfXyqyaeUjUMebT
 iX8oR4guRVJ6MNGAKE5ZtnTt0BAvmWMwLCNibTNNwYGblppLXeImzwfVv78ZBraBKKCRrkH+QQk
 RGbfxB0WB6ifvQN8+QGw4S9iJpjX00tWy1YCW2+lFeSOC5jedzaqCDsWbR6WFvf6Lj37T62+/x+
 qQxUao8coU85T9gSWjbUHBKcKn9EfWX8rfdv5s3w2ZyKWJKTKqjSQ0SRKVBrPy7we8FNweKsel6
 3/GhlQzMJGN34oF9baT/AwUqbR/Jkzp/+esRGnH0+uNfj9sM+PJ4cfB7qQZClsIO3sCXhAk6dPa
 hF8iP3ZSCJNrWYj4Oo2GtQ7lgbCYV28TJH7JaTTgvyumLhtCVUMHOESeMmyNvNW+Gl21We/GFZh
 jVUMZXdGe+01U8X5lV3K3r8F3cL/16JdmRtsfiktyushHlRks+tKaD1gTlEHd1Xn0g/uHdW5S2b
 CkqLiPnWqQIl4JhgvMg==
X-Proofpoint-GUID: RjMHir6tINc0awBp4QgG1E2KCu9KUL6v
X-Authority-Analysis: v=2.4 cv=PtCergM3 c=1 sm=1 tr=0 ts=69bbc0d6 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=NujWGTqPcDVEmWsEH4UA:9 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-19_01,2026-03-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 malwarescore=0 spamscore=0 adultscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603190074
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

On 3/18/26 6:15 PM, Dmitry Baryshkov wrote:
> On Wed, Mar 18, 2026 at 10:22:08AM +0100, Konrad Dybcio wrote:
>> On 3/14/26 6:06 AM, Dmitry Baryshkov wrote:
>>> From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>>>
>>> Add support for HDMI PHY on Qualcomm MSM8974 / APQ8074 platforms.
>>>
>>> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>>> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
>>> ---

[...]

>> I don't know if it's a good direction, but maybe:
>>
>> const unsigned long max_rate = HDMI_8974_VCO_MAX_FREQ / HDMI_8974_COMMON_DIV;
>>
>> clamp(req->rate, max_rate / 6, max_rate)
> 
> Note, it is clamp (min_rate / 6, max_rate)

see, indeed confusing ;)

But I suppose we don't have a better way of specifying that so whatevs

Konrad
