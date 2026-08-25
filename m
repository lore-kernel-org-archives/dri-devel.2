Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E67D0C61DBC
	for <dri-devel@archiver.kernel.org>; Tue, 25 Aug 2026 08:30:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0788910E5BA;
	Tue, 25 Aug 2026 08:30:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="IKvjAPf+";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gaetiZdU";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C64FD10E180
 for <dri-devel@lists.freedesktop.org>; Tue, 25 Aug 2026 08:30:31 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67P88Rpn196278
 for <dri-devel@lists.freedesktop.org>; Tue, 25 Aug 2026 08:30:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 snUCad4MSlI6CTjQKRUKgLOV4nb44hzzXkl5AybhC/k=; b=IKvjAPf+TMmj9Iqv
 E49fkXNvWA9Jw/RHW/U+2JBXDxyS+Tz2rqEO9v0DAc+/ga33Ka1CCWE62a9VODgA
 IUsYBhJG6oEWsw0EpjCFhF3CTgLsAfvAs0oimfwm4x62TVn4uUsifS0AiX8TYZIf
 gnZfVqV+gZC/B1LQlW3AAjD6t+ebHU/Nps20mXSeG/hAz1CGnyLqK1IxFcQ7dnPP
 RiXYJEIXDCRNMQOhGAL8DffdzSAMeFescWxBaHSdxzaAFE7cUSp9ffdiXcNGuNBS
 h8ltWQ5/aytFeoFAi4MiFK80o2HXg6wQIF7A2QLc7hkFzvPyY0zKhzaOqaYS7xtv
 vaWkvw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g93pvgx66-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 25 Aug 2026 08:30:30 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-51c9d953b71so7934081cf.0
 for <dri-devel@lists.freedesktop.org>; Tue, 25 Aug 2026 01:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787646630; x=1788251430;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=snUCad4MSlI6CTjQKRUKgLOV4nb44hzzXkl5AybhC/k=;
 b=gaetiZdUHEiFFYt9NGsugBxM6AxB2YdplnHpm1o5LWkN9Nc3IDuQPiD1TJHNtlnyAz
 Sf+IknhHkGMhVZJ+iZ2SQbfB/pgCrjbYIwpQf2bbtOjTlCmU0J/bHZ6C2KvCKYQ8bMzk
 ov6mbbDRywtSQd92b5oTNBcT/mX2IloO5rbjxl0kritUtg6baBpwdAaLPbkatoZhvDeG
 T2eAvR3KZg5i6BP7o6Rmyx+CxqF7AyjoTFD+K0cpIvSfoSDFyOWxEVANp1Bz4GMuYHOT
 7d6zcNttN99Gh/v5aZ7LxxupY46I+AyYxb2iAtwva9eQZlvw8iHQSc8lkBZGgDTUnvjB
 9+ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787646630; x=1788251430;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=snUCad4MSlI6CTjQKRUKgLOV4nb44hzzXkl5AybhC/k=;
 b=nbMtwJKV56AOLPxi0huuJeXfosOwoiiJAINfKZBzqYcS5n/J9umpv0w+Og7tgwUDzm
 IdKIOY4m/+CRUqYsTYcBljNqi6vbwnjhK4ne4NeGUoRbhJ6AR+yHNmzc6+5Fo2Qtms/D
 qjryAAbCMrYByWsYfN6e21u/816SoFixBpVRkXPY6tChmV7plRENQnKruTnC2wXAn28s
 OM4LgKOKm2CecRN3AslmgkAKF7t+E7fMxr0BfSCcXyO3/J048sfPS386TjQzVZHHSmQE
 bBg/GSjZU5J3QG7JpUjlCS2B/q1ia7RkM2QGDdbBEEsvKR3NluvwSndWhWgekbpjE+sN
 VOIA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrIb5Te/YWTnuCwxFRZFb9GS6nEyfbdL+/4Q3nzkwzn4AvNFWT0vLkK9yLOo5Fvo1g0+M/m6ga2UY0=@lists.freedesktop.org
X-Gm-Message-State: AFuF++l7k9IwXE3eKh06urkvu2QIZUcfeCnP+ul7LKkn3g9NeJldGZ8B
 paM0raMSlZDyVvqNU9WM9UMGf00rFird9oONCSmojCSUJ5/45w8QxFHEpweHZsrOAoO9wRwe/Yd
 jAPUSV0Is8p+iHE1/6jqM85/taYDEJ2VKC3aBO1aRVvT3Y6grzJVnNE/VCcIGoAWpflzzT/A=
X-Gm-Gg: AR+sD125k5BpHkI9BRWd47Neb8rroC2F9g3+9bw/pnSrg/3TXkjjOVq5ym0SnIHKhF4
 LZ+HdKjvbbed4jNn7Ykx19aXUFdfB1IT40oqyHUoukrBWxVamu/wARdX6UVD+eCLtyW8UIDahuc
 EgkK7PGzfqZYnVGORKMjgwu1uPvF6wCcr0Ump4hW/EeTkdJvi+86UVnQnX6kRlFHf2zcPDF+C+u
 wOXOVZaA9tqsR28swd905odmIDgAvIxDXTFl/kh7CUPMZjn5Bmak1WN0VNpyPclxtMGFByHTlI2
 eP+8J9j+XwtCvUtSNPmUQB5fnem5ToiB+jWGlfOV4TO+YnocQ4VOBZOpLe/yjwoMroNJUoyoX+0
 7H/L13HrJOCtCY903YwuW3Fsd
X-Received: by 2002:a05:622a:1102:b0:51c:10e9:ec47 with SMTP id
 d75a77b69052e-52df5a21154mr240432501cf.5.1787646629684; 
 Tue, 25 Aug 2026 01:30:29 -0700 (PDT)
X-Received: by 2002:a05:622a:1102:b0:51c:10e9:ec47 with SMTP id
 d75a77b69052e-52df5a21154mr240431961cf.5.1787646629105; 
 Tue, 25 Aug 2026 01:30:29 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c24966f809bsm1827029066b.41.2026.08.25.01.30.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Aug 2026 01:30:28 -0700 (PDT)
Message-ID: <b6d6b627-a38b-427a-9e62-ee883505b2ad@oss.qualcomm.com>
Date: Tue, 25 Aug 2026 10:30:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dt-bindings: display: msm: Allow two MDSS power
 domains
To: Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Krishna Manikandan <quic_mkrishn@quicinc.com>,
 Abel Vesa <abelvesa@kernel.org>, Yuanjie Yang
 <yuanjie.yang@oss.qualcomm.com>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260720-msm_gdsc2-v1-0-4687866d6cb0@oss.qualcomm.com>
 <20260720-msm_gdsc2-v1-1-4687866d6cb0@oss.qualcomm.com>
 <b36691d3-e996-4fc0-8955-25beeeecc385@oss.qualcomm.com>
 <ccab8aae-d980-423a-b39e-3ce2a7c82542@oss.qualcomm.com>
 <5341e732-0deb-4d00-9a7c-595e317bf1e8@oss.qualcomm.com>
 <db2a18aa-f5fb-4ee8-8747-05fcf740749f@oss.qualcomm.com>
 <f344a913-cc95-4fef-880b-f1fee200c108@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <f344a913-cc95-4fef-880b-f1fee200c108@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI1MDA3MSBTYWx0ZWRfXwBnOZ0sC8bob
 67urk9+4pjc7RpueggwHeyO+LPpBg0QAR4coMGEGG6232DHHrZgDaKSPSjZ3j8hoGSm5W+Wp73V
 4RIX8bGBoWqJB+5wIio6Vq1fZitCXV8=
X-Proofpoint-GUID: rKeQFvOVuD8Xz7YdTl_K6UqAqcYoeH1T
X-Proofpoint-ORIG-GUID: rKeQFvOVuD8Xz7YdTl_K6UqAqcYoeH1T
X-Authority-Analysis: v=2.4 cv=Ru716imK c=1 sm=1 tr=0 ts=6a8d52a6 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=-6rRdagTYtbFvggOUc8A:9 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI1MDA3MSBTYWx0ZWRfX4aXvKazJq9AS
 67+SLCwQeOboWLm2f4yWcu6i2dIUnmfMLkc5I+gN2jaAzzOiQw2+t+GHpyJAcEMzLvW/kgyezU8
 ZCKAUaAnIRF1Jt7549yN7jUKC85z5lDL5FAdoDG1pBT2cxOIAfB6LcP35/UE1C81otNc7mSWRKt
 G1qtkQNJecvXWVASePuD6Ld75WEzwh1RFaBY54G6GmngzDTXR5+XnnVmuVgOB92R/PGyJ3Tz84a
 /f4wLy086lcmYwErepZTCOi2Q2QacEpHzkRJ7JCK675ZjKHjlfULnOhrhc8FB69cMCe25rS78fj
 gedAh6qQSj2tuyQ+gMhftJlnReVmKR1q6QFkQHyGray9weljWSpWl3MlIZlE/nUFYfGyfH335KS
 eEJ7PB4OPTCysWSBhsB4bJy6pCaK8b1GcWrKU0o/IC53AZrK8Q8f5/zXZuUB8oJMAlYUaZJ3+xf
 mWDgZFcYjl5SRzILFIQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-25_02,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 suspectscore=0 adultscore=0 lowpriorityscore=0
 phishscore=0 malwarescore=0 impostorscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608250071
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

On 8/25/26 8:28 AM, Yongxing Mou wrote:
> 
> 
> On 8/17/2026 10:14 PM, Konrad Dybcio wrote:
>> On 8/17/26 4:13 PM, Konrad Dybcio wrote:
>>> On 8/13/26 9:44 AM, Yongxing Mou wrote:
>>>>
>>>>
>>>> On 7/20/2026 4:49 PM, Konrad Dybcio wrote:
>>>>> On 7/20/26 10:43 AM, Yongxing Mou wrote:
>>>>>> Kaanapali (SM8750) and Glymur use two display power domains.
>>>>>> CORE_GDSC powers the main display hardware while INT2_GDSC
>>>>>> powers a subset of SSPP blocks.
>>>>>
>>>>> Can they operate independently? Does INT2_GDSC need to be
>>>>> powered on after CORE_GDSC?
>>>>>
>>>> On Kaanapali, my understanding is that CORE_GDSC and INT2_GDSC should generally track the same state, except that INT2_GDSC may be powered down when SSPP1 (VIG2/VIG3/DMA5) is unused.
>>>
>>> Is the MDSS any useful if *only* INT2_GDSC is enabled? Can the INT2_GDSC
>>> be enabled itself if CORE_GDSC is off?
>>
>> (I didn't quite know how to parse the list of states you provided in your
>> reply so I asked again)
>>
>> Konrad
> Hi, Konard. Would you recommend adding the parent clock in the clock driver, or handling 2 GDSC in the display driver? I'm preparing the next revision and would appreciate your feedback.

Does disabling INT2 provide us with any power benefits and will the
display driver do the accounting for what resources need the INT2
GDSC specifically?

Konrad
