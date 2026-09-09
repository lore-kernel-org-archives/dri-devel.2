Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84DD3C79FAA
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 07:53:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9FCE710E125;
	Wed,  9 Sep 2026 07:53:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="awEjX0iD";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JBbXRfz0";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D5CA410E125
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 07:53:49 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6896qwiC336657
 for <dri-devel@lists.freedesktop.org>; Wed, 9 Sep 2026 07:53:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 fTXYHOV3KBPJQ32Zh91Zlf5yN7Iu2qtX163LKYkR9as=; b=awEjX0iD51BjJkE8
 LwNHHPSHht3oE1KO7F9cPjyuUZ/ZZ3WfSUWKrd3Zueupcsj3uUeQydE5y2DJ+y55
 KJUggAzPHNiQU8Qjenkh1pO8F09rxk/riqCs8XLOXT46iowckp7LijOmp6m2gqu+
 BB/aoXDDfd2OPM5zhwv6juBu2zBS5OC4kVGE7LMzPz0o6Hit791NO2SkI5WnnhsX
 NZj3c+gT+PqNxh75knGC0+0yKyq5vba/qmsWUdSy3Bi3hlmVZzluIpR7qzIdf8Ci
 Z0L7C7CkubJVGNqD4V3kNVSjvQLGCq/cdH8B9ZundNT6skwxpTgizWrVsByKW1k3
 fIBT4Q==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gjqe7jtbj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 09 Sep 2026 07:53:48 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-39b90cc0d5cso2809279a91.0
 for <dri-devel@lists.freedesktop.org>; Wed, 09 Sep 2026 00:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788940427; x=1789545227;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=fTXYHOV3KBPJQ32Zh91Zlf5yN7Iu2qtX163LKYkR9as=;
 b=JBbXRfz0xFDJ00lgETnLoiq4IFGhfuUc/78VjFASMRcODFGm5B//HmCvtJo8fsVlrh
 qhBnX7LBF7whLU0AujiQUJ5Hy3lFKBhIq3mRTO7ES5CBCo9BW4BQMTcsIVRNZj5voNjm
 eK7PbqKn7+pYWrBgb+U3F2Tx8HywB93C4pix6aK1eNQIxypGW3+R0bGxiZtcTzh1ldww
 bE153u66PB0RENb/1cM1H67GS8Dbm7DkENf1fRww/YnHUPFDybNoREZXAsbh+rWOVk4d
 g09zIqn+2GjEI4NEfIKNTNlNhF682avOVizcWAAEFakbi6OjlhgH7jk+mHOri+MM7jxm
 ym6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788940427; x=1789545227;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fTXYHOV3KBPJQ32Zh91Zlf5yN7Iu2qtX163LKYkR9as=;
 b=h8647QQYXZRYCwIAmcjv2tFnAsyc5vdky8yOf7ZEFjputegEm2fxkhiehzj8rCwLZk
 nbYeXwSFG6+UldVnyuC51euAdvG5M1qjxLrf2WMzedBpF+rPs0qIg5wJsIwkS9sP7fo3
 KIsW5IJ/otLDo/NKo0XENXnFab82wU9o1OzrVMRuTJjojRz4W5VhF5cZe85NHtjQELnU
 FaFaDnvjY8pB5ZpKffRzexMrWDnexvZ9hBhBntRUuheOBjbIs6TgcBKGpw0/zJWj8mhR
 LYQtKGjC9Bd9dTdTrr+4LbVyTFMjeIYvoTuXT6yHglUSrmEfHShWpkiD+Ab58Z4sJsEd
 1qXA==
X-Forwarded-Encrypted: i=1;
 AKwUvBy9J/B6lz9ctlvj5nSPXGwzHQu1SF12k5nm9YH8FqpvuRbgzdnBe2runKDHHBLwPd4jlu1OBQsvB/I=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mFun9xOs6H7T75H17Tic3IdL4gOeLneE1hJuHv3xBdJDfzh4lQ
 Egw4UjMQmzanmt5eGatinYAMJU3ehd3cB0TITKYB9ZwN0FqQGHWHMBDItuR5eP/by+KOOLw1kBE
 sJWB8GEfcJlm9APJ2xkEZ4HPx+cVhuxhPPp6IO5jj55RHfNxgvYZnxowK/WqrX4s0/7cq2YI=
X-Gm-Gg: AYBFou0cFEcAjj1A5dGEPsGb8qmBmuM6RNbEZUa/bFxALLQu47qMnfdXYOrSigD3Onu
 sHwqU32fhYXFMze2tMuiciVpN7bAhlf7Y8ttBz6t7ieclk3zawKOtmCXm+gKzXSD8ImXYwWXA7J
 b/3T4GrbfzTLnLyZ9d4qreoxKYYoUgl1MbW3/R/8Dxuvg2MaRgoXq+8lXYLMawKCvjNkwhIjdTU
 vaZHUnapfXVaFAnqHcXffD9s/sZbnMtG25PAsC4dSkGINNIDRBWWoNoIeAt0B+o2uTwiYgfcO6C
 rbUbPlwphtrlUGqgnyA6yvps/QgxGuT7niA/Deyvt/J6PyS1q4QM1/aGfvWTV8kOmXA98xm+1W9
 OEQrtubjJf8EHtMyAtyehKYd9p0HrIA==
X-Received: by 2002:a17:90b:5807:b0:398:9be9:ab8c with SMTP id
 98e67ed59e1d1-39b26229bd7mr52084945a91.17.1788940426980; 
 Wed, 09 Sep 2026 00:53:46 -0700 (PDT)
X-Received: by 2002:a17:90b:5807:b0:398:9be9:ab8c with SMTP id
 98e67ed59e1d1-39b26229bd7mr52084889a91.17.1788940426365; 
 Wed, 09 Sep 2026 00:53:46 -0700 (PDT)
Received: from [10.219.57.226] ([202.46.23.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14324356931sm65319126c88.4.2026.09.09.00.53.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Sep 2026 00:53:45 -0700 (PDT)
Message-ID: <09f62d84-18ad-4d7a-ad18-9abccfd5e508@oss.qualcomm.com>
Date: Wed, 9 Sep 2026 13:23:34 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/15] accel/qda: Qualcomm DSP Accelerator driver
To: Bjorn Andersson <andersson@kernel.org>
Cc: rob.clark@oss.qualcomm.com, Krzysztof Kozlowski <krzk@kernel.org>,
 Oded Gabbay <ogabbay@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap
 <rdunlap@infradead.org>, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Bharath Kumar <quic_bkumar@quicinc.com>,
 Chenna Kesava Raju <quic_chennak@quicinc.com>,
 srinivas.kandagatla@oss.qualcomm.com,
 dmitry.baryshkov@oss.qualcomm.com, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, llvm@lists.linux.dev,
 iommu@lists.linux.dev, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org,
 Anandu Krishnan E <anandu.e@oss.qualcomm.com>
References: <CACSVV01eYr6FyA6XBG0xw0yv2dydvTEhcY-WUy07mxM8WwkZcg@mail.gmail.com>
 <318f14c2-0e87-4e07-8173-1511dca67d78@kernel.org>
 <CACSVV01T=ytVJKM7NRoBTAJm7vH+JPJNT9Tftu5X9YskGXerwg@mail.gmail.com>
 <e7b4eceb-cb3a-49ea-bed9-728c958594b0@kernel.org>
 <CACSVV03ypjBYkhRpt=TyDwOKhejKKke3x=Fi_TvxXN-5U_rCsw@mail.gmail.com>
 <fb834ae5-7113-4a86-bb84-ca5115c8d7ff@kernel.org>
 <CACSVV018jB4WRRJ_CUHQmkHXZcqauWJXWGgrzY_HA6cFQ+Q3Xw@mail.gmail.com>
 <dd3da35b-1db6-43a4-ae1f-35620692f51f@kernel.org>
 <CACSVV01o_XYuSzaYGbo9pY=459qiA_fgL_KRHVJH+LH4RYcMzQ@mail.gmail.com>
 <23e31249-cce2-421e-88f7-1a2af66e34b6@oss.qualcomm.com>
 <aqCKgM1yCbWjFdgO@baldur>
Content-Language: en-US
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
In-Reply-To: <aqCKgM1yCbWjFdgO@baldur>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDA4NiBTYWx0ZWRfX4+1opixLMop5
 PyGAUzjzsURkzHfGzofNi4/HaqZeuXbvV51cwUCUMO/EskCuCoWOhErrhsgc7Y60Dg8Lgkmwe7H
 M2LJZN1h3i92JGVscdcqcKsedHHhibI=
X-Proofpoint-ORIG-GUID: j4K8xay5Hmuu9scltHc69elXurRqs2f4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDA4NiBTYWx0ZWRfX9EHL+cyQdo+W
 CqGxDzG/UVBBlNOKovQxOPDPvdFtAdUwUWALrcEwPXEM37Daj+dVJSstMfdXhDbCrUlvjXnbqtN
 STFhv78NKMREvfRulXt5POov8NMX88UeDjODdjnpafonoUOaPfa/IPSW88DmQFShZFrr1X1GVpb
 HUHUG4NaJStCXmSs6VgoWmVeBfAFsKclBRUgioay5p5FGYoIQeb9/kM3DUe6MCHFbJdxegmlE7M
 p3hMXFrKCZIXSpYBour42SvOAJkDpb/b4VPIEX7LqwFhEY4+BrZ/2GAoLYHfmJRUzl8cq8T0vWL
 d0o3xwm6MqfY6bMw2SH56mtyvfGv8ovMH+A0q1L6cru4H5/T1WKWo5XXQoMqDlmNdPCZgJPWLql
 dF64Yq/2vnuwtvmMcsdP7yHrWwhWo20hvZ5TgejL6CubBeXh7DXenHGo2k8/pzKNbp+F0LtYKoE
 dmvGNE5hOC71VQosSfw==
X-Authority-Analysis: v=2.4 cv=Xey5Co55 c=1 sm=1 tr=0 ts=6aa1108c cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=ZGy5um1dRlDb5ydww_EA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-GUID: j4K8xay5Hmuu9scltHc69elXurRqs2f4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-08_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 phishscore=0 priorityscore=1501 impostorscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609090086
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

On 09-09-2026 04:14, Bjorn Andersson wrote:
> On Wed, Aug 26, 2026 at 06:37:00PM +0530, Ekansh Gupta wrote:
>> On 20-08-2026 20:17, Rob Clark wrote:
>>> On Wed, Aug 19, 2026 at 11:15 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>>>>
>>>> On 19/08/2026 17:48, Rob Clark wrote:
>>>>> On Wed, Aug 19, 2026 at 8:27 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>>>>>> The rule of usptream development is that we do not accept duplicated
>>>>>> code, just because a vendor wants to write something new. This is
>>>>>> basically the concept applied all over the drivers tree, where we pushed
>>>>>> back against all sorts of duplications all over the vendors.
>>>>>>
>>>>>> What I miss in this thread is why would there be any exception here. We
>>>>>> do not grant exceptions from standard practices on "I want" reasons.
>>>>>
>>>>> I agree that we should not have duplicated drivers just for vendor
>>>>> lolz.  But when it comes to adopting common frameworks and integrating
>>>>> better into the ecosystem, this doesn't seem like something we should
>>>>> actively discourage.  I don't think this is a case of vendor lolz, but
>>>>
>>>> No one discourages it. Following standard Linux kernel practices and
>>>> requirements is not discouraging, do not twist the narrative here.
>>>> Again, it is standard upstream review telling that we do not duplicate
>>>> drivers. Ever, unless there is serious exception needed.
>>>
>>> I wasn't trying to twist the narrative, just trying to come up with a
>>> path forward that isn't "no" or "improve existing driver", since
>>> neither of those gets us towards a future using common frameworks.
>>>
>>>> I asked why there should be an exception granted? Is the reason for
>>>> exception following:
>>>> "We want to adopt common framework"
>>>> ?
>>>
>>> Possibly?  But I don't think we want two drivers to be any sort of
>>> long term solution.  (Ie. as long as venus/iris have co-exist.)
>>>
>>>>
>>>>> rather reacting to drm/accel emerging as the standard framework for
>>>>> this sort of driver.
>>>>>
>>>>> So how do we get from here to there?
>>>>
>>>> What is wrong with my proposal?
>>>
>>> Maybe I missed something, my understanding was your proposal was
>>> "Grow/replace/improve existing driver instead of coming with a
>>> duplicate"..  grow or improve doesn't move us toward common
>>> frameworks.  Maybe "replace" is a valid option.  If there is something
>>> I missed, then I apologize.
>>>
>>> Options I can think of are:
>>>
>>> 1. Hardware cutoff.. new hw gets new driver, existing hw gets existing
>>>    driver
>>> 2. Backwards compat chardev registered by new driver, providing existing
>>>    UABI.  I'm not 100% sure about the feasibility/drawbacks of this..
>>>    AFAIU the fastrpc folks where planning a backwards compat layer in
>>>    userspace, so maybe it is possible.
>>> 3. exception?
>>>
>>> I'd like to know what the feasibility of #2 is, since at a high level
>>> that sounds like the best option.  Possibly limit exposure of legacy
>>> UABI to existing hw so we don't get into a place of needing to extend
>>> the legacy UABI for new hw?
>>>
>>> But #1 sounds like a non-controversial place to start regardless.
>>> Possibly with #2 coming as followup and necessary step before eventual
>>> migration to new driver for existing hw?
>>>
>>> Even if we start with #2, how do we handle first-merge-window
>>> bugs/regressions without reverting addition of new driver and removal
>>> of old?  It seems like we'd need a window of a couple release cycles
>>> where both drivers exist?
>>>
>>> Maybe others have other/better options in mind?
>> To all, I'm seeking on the approach I should follow to go ahead here. I
>> can work on implementing #1(as per Rob's list) with hw specific
>> compatible for v4 if it's acceptable.
>>
> 
> I don't see any reason for you to define a "hw specific compatible",
> because as you have shown in this series (and as Rob point out), there's
> no difference in the "hardware".
> 
> The only reason for your "hw specific compatible" is to make a software
> selection in Linux - and that's not what DeviceTree is for.
> 
> 
> As such, I don't see that you have a DeviceTree problem at all, because
> this is a Linux-internal problem.

Agreed.

> 
>> #2(compat driver) is something that we are still exploring as we
>> couldn't find any standard way to achieve it. We might start a separate
>> discussion for that once we have few possible designs with us.
>>
> 
> This is the actual problem!
> 
> We have existing user space that depends on the ioctl interface exposed
> by the current misc driver. You must not break these.
> 
> Hardware cutoff is not a viable solution, because that's just a
> declaration that we'll let the old platforms rotten - or alternatively
> you commit to maintain two drivers to the very same feature and quality
> level.
> 
> So the only reasonable solution is #2; from there it's a valid question
> if you reach that point my stepwise migrating the current misc driver
> that solution, or if you present a new driver with the fully backwards
> compatible interface, alongside the new ABI.
> 
> 
> But this does bring to a question which the cover letter should explain
> - but doesn't: what problem does this patch series actually solve?
> 
> Regards,
> Bjorn

Agreed. I'll target #2: QDA implementing the existing fastrpc UABI
alongside the new one, rather than a driver split by platform.

On how to get there: the blocker we hit in v1 was that legacy fastrpc
buffer semantics appeared to need a drm_file, and there's no exported
way to construct one outside the DRM core. I want to re-examine that
constraint rather than treat it as final, since the legacy interface's
own buffer model (a dma_buf fd as the buffer identity, no GEM
involved) is not inherently tied to drm_file, that's how the existing
misc driver implements it today. I don't have a concrete design yet
and would rather work through it here than commit to one prematurely.
If anyone has thoughts on how the legacy UABI could be served without
requiring a drm_file per session or if I can somehow bind drm_file with
chardev by exposing some APIs from DRM core, I'd welcome them.

On the cover letter: fair point, and I'll fix it. The problem this
series solves is that a miscdevice interface requires us to hand-roll
what the accel/DRM subsystem already provides as common
infrastructure: GEM for buffer lifecycle and reference counting,
PRIME for cross-driver import/export, per-file (per-open) context and
handle-namespace isolation, and the existing debug and lifecycle
tooling the DRM core already ships. Every accelerator driver added to
drivers/accel (habanalabs, ivpu, qaic, rocket) has taken this path for
the same reason, rather than each maintaining its own equivalent
inside drivers/misc. Building QDA directly on this shared
infrastructure, instead of extending fastrpc's own ad hoc buffer and
session tracking to cover the same ground, avoids that duplication
going forward.

I'll put this plainly in the cover letter rather than leaving it
implicit.

/Ekansh

> 
>> Happy to take any other suggestion also.>
>>> BR,
>>> -R
>>
>>

