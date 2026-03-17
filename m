Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B2D2F3381B
	for <dri-devel@archiver.kernel.org>; Tue, 17 Mar 2026 08:59:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D12910E448;
	Tue, 17 Mar 2026 08:59:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="BXzqdKsE";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YftzesPI";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C2A1610E212
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Mar 2026 08:59:34 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62H8n38s3103092
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Mar 2026 08:59:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 acx+HIKHCDqHg+j5iC+RJDEjPmw3fE5jWyOI6vQQqxQ=; b=BXzqdKsELrcqYKSw
 vPAPICHUX1gaB6p82PNKn1trHYYMTTipWxxUJ6z/ub/wgbtF3543JID+S1kfXBWO
 XsF2+IlJtbz9+iLRHLmMydm07q+5+k+jRQ1mBkT8LMxj9WCWZU0t3WV5NzzXkLgF
 54Nka4iorxlNqPIw2mG0djcmUC0xxxd6hhBOOy6wE/RyWnmtXSbrY3/++vE2QoTI
 KBUb0Z7pVFTSslu0jVCss5yG2r+s+/aOE5avOtNkyuJnyNF6p3Xs2P2k9s1vWbHo
 +HKdI924+ovcuzWJ7lhBrmrOYMPKjcS7pEMNglR1KTRtfPoJ7EH0HaWCql9OmV82
 4fjyhA==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cxnb7b0xq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Mar 2026 08:59:34 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-89c6717b74dso400476d6.0
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Mar 2026 01:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773737973; x=1774342773;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=acx+HIKHCDqHg+j5iC+RJDEjPmw3fE5jWyOI6vQQqxQ=;
 b=YftzesPIh3l3nxQgtnB4VDJ7UL1Dn/3hG/nFKatawPyhrJ3dWHshxnoiLvl8FpgRPW
 FdybEBHuPgPQXC0PPPLiaWl9yZvew1gHLgE7dAAL+hpcxylozIjOeWbJhuz0n8lIzSpK
 diufBwRg3r1AnXZ3GhxbPG57U/pSfdJsfQLLR/YHwTVHz07nxO0t6NR0zJcTUclPsWA/
 /Sei7RLDsFr6mSujWbWEeR1UvB0Tl4wWdPXyfdV09/tvOUeGbjHGJesGPE5SG6uufUSK
 GHOsP0vfHoQYPUEhndknYkcjw/zCP9qXB3vzIRz476k9YxIhergOSZMkOk0dVx1RRyZE
 +i8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773737973; x=1774342773;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=acx+HIKHCDqHg+j5iC+RJDEjPmw3fE5jWyOI6vQQqxQ=;
 b=V9MlOeZWdBmzP55/2LZGomFR7XBMHyOawJoDwgLqSuD5q4C78kE5EjwNF9DwwFwRkL
 dpMcDexTiHlhayNGqtB2Chwz93BEFmTM0Vjs62fDIW7JntioYunTd3OYd4gni5cGNNBe
 A1yTzyGxDcdlvMIBaIP7Ov6eh9q9Pmzaab5ThwXdHYFI4pzpJrH/xcQ1ghNjSgGlylDz
 Uxqq0r9WLV+REUaMqcy8TlL5PcotziyKB49z+l7IPys+ukDXh1XXWHT+Lh7iohOcc4Of
 XzEGQFVyzlxrKBFWm3zIYMAmfegmRqI/UEuv0DdoaGFtrsm5cUeh+DEftLQAK4YV4Hjn
 QJhQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUVm2YyMCqSbTEU2zX7dAi3xtPOl+BuKZgeXaucpWJNi4/myVLNApO+L4UO5XqIg1Oz9hAYe+m5wDA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy5m0LZOzLj1GGK2BPqf0QPdBPiXqJw8Go2JjqJUA/NTUF9SQ1n
 uu5n6ELTYtKqpsEl+7tN1M+Js0hlHNjQG3OzMoPypdXyzqDG5p5JY5LuoCPUzl+e4oRZSCWEZNM
 chRTEtEE+XjYZpzC2E7Ae4YP+L2X6VbKCBczSBKyAPFUBD/vTX3kZP11BMHGdnkXvHGb7Ef8=
X-Gm-Gg: ATEYQzwU21UaOx0TRYZEXdW7ZQ7eXpoY81KUJUopV8vouMEFWdOkkAY/e/nJU+rJn9e
 cns7n0SCSRziJ41dERtcN1qRcGu6V33Q8+ZEZHOuECRa/bB3kMZ+L8XKMIV/JV8nhOm1IiKTI66
 YvzPXj+Mr6yFzA+6wXOfg/sxrTLWQY98JBDzOtz5ls8Du7LCgec1bgQPnozsmrN8wJPZVBdwYbW
 aWM47eLE+u9ykaSVXtaT/mMmLyw6n9QX8xuO/ScranPyFIqlTq2zGUtZ9/FnSe5e8I3CRqgAj9f
 nLl1flFBhpvCTnCGpcENB7WyTHXefxDaiQD8k4wcBA8u20E2wlIKSJmiiQ/zkKypnd3uQlxgFCa
 Z0mkrHGwGP/sbyvaBz21174V3ZCDOsbBR8X4X9yYDrsYKDVAHq2v8YFXaUGi3DCROI5n7Eek67+
 74phs=
X-Received: by 2002:a05:6214:6014:b0:89c:58fd:41 with SMTP id
 6a1803df08f44-89c58fd062bmr41988536d6.8.1773737973037; 
 Tue, 17 Mar 2026 01:59:33 -0700 (PDT)
X-Received: by 2002:a05:6214:6014:b0:89c:58fd:41 with SMTP id
 6a1803df08f44-89c58fd062bmr41988346d6.8.1773737972562; 
 Tue, 17 Mar 2026 01:59:32 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl.
 [78.88.45.245]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b976cba6eacsm720678066b.14.2026.03.17.01.59.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Mar 2026 01:59:31 -0700 (PDT)
Message-ID: <3e5f80a6-d9bc-46ee-89ca-b1b2ba744493@oss.qualcomm.com>
Date: Tue, 17 Mar 2026 09:59:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/msm/dpu: fix mismatch between power and frequency
To: Luca Weiss <luca.weiss@fairphone.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: yuanjiey <yuanjie.yang@oss.qualcomm.com>, robin.clark@oss.qualcomm.com,
 lumag@kernel.org, abhinav.kumar@linux.dev, jesszhan0024@gmail.com,
 sean@poorly.run, marijn.suijten@somainline.org, airlied@gmail.com,
 simona@ffwll.ch, krzysztof.kozlowski@linaro.org,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 tingwei.zhang@oss.qualcomm.com, aiqun.yu@oss.qualcomm.com,
 yongxing.mou@oss.qualcomm.com
References: <20260109083808.1047-2-yuanjie.yang@oss.qualcomm.com>
 <kusxzlezvsuwcwwdtm7yqwnqea6gdeolkepxpx3estabaiqymo@edj7pgccli3y>
 <aWSTcI6H6+7AXkEN@yuanjiey.ap.qualcomm.com>
 <CAO9ioeVrQ_TfU5-auxNHG=dL8VmeWtBaC_NE09UECodkYrFv-w@mail.gmail.com>
 <aWSv+kVV3G18I/NJ@yuanjiey.ap.qualcomm.com>
 <e5ebc660-e30e-4fcd-ace6-5a6c889e9a8a@oss.qualcomm.com>
 <4g6fyehdc3fejx3pzeysmghigazfei3jz2vmnvxrnqkkbtbxdb@bdlcddxlvbhl>
 <cb22367a-678c-431f-9f52-33663f4af9d7@oss.qualcomm.com>
 <jr4h4sx42dbxpknm5nkgj7ydpkivm4nglfz7ui4bjpom7wf6ub@spqb27d3ov2z>
 <DGSDE0ID17DQ.XQZNKZH5UKPO@fairphone.com>
 <g3dclilgoee6a2dyfqdvk67asjb4ptur5nc52iqqeqpiiourpv@46xstae5zsy3>
 <DH4WJ5KZ39MS.AHLMLFB8E0JW@fairphone.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <DH4WJ5KZ39MS.AHLMLFB8E0JW@fairphone.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE3MDA3OCBTYWx0ZWRfX6CezhGgcKGbc
 smMPi8bKdD6oCHhWzGTQequC8OV8t080o0xSA1letss8T7EzfXHFQAkA/bm8+y64lhyAP2eCzpJ
 BGeQl2diQbxL27rlEZaI9BusgUZ28wZOpBv3o0KDQqp2eSZ5Bg5kwYUgoUxpTFF9QjuxlzKvsza
 iugWZ4bFq9sLV9DTwo7m/7fup3IaT9BvxXfr32wFWSvrpoiRToR2S9UwgDYZQeG/cSWSAwAA6wl
 jTUXYORx4jqblNSQYpHwAdtguoaNIKNYy8sAYPxNJWdiofYlxKXrTexuPz6jHd4IZfkQEbKUnP2
 D6YBNHFNCWxYVUizS/n6wTG1lC0uHBNjHuomONQ8gWOmf8CWB5NBRW+8x2nIRky/PuIfe4inwVh
 IEj/kq9h/c2zGEJjd6AVNGxL4I117gdj/tiiugV21qoE9v6ZvArDVjP4SBA/+QAKri/iYrHHfo9
 t4PnHDsFOkwsFRv1+Cg==
X-Authority-Analysis: v=2.4 cv=D7pK6/Rj c=1 sm=1 tr=0 ts=69b917f6 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=m4NBtHgnOE4RoSRSD-cA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-ORIG-GUID: 5bJhQyCXSH-QZLqvpkXUtyulV5xKjhSU
X-Proofpoint-GUID: 5bJhQyCXSH-QZLqvpkXUtyulV5xKjhSU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-17_01,2026-03-16_06,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 clxscore=1015 suspectscore=0 spamscore=0
 malwarescore=0 lowpriorityscore=0 phishscore=0 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603170078
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

On 3/17/26 9:07 AM, Luca Weiss wrote:
> On Mon Mar 2, 2026 at 4:17 PM CET, Dmitry Baryshkov wrote:
>> On Mon, Mar 02, 2026 at 03:35:36PM +0100, Luca Weiss wrote:
>>> On Fri Feb 27, 2026 at 8:05 PM CET, Dmitry Baryshkov wrote:
>>>> On Fri, Feb 27, 2026 at 12:34:04PM +0100, Konrad Dybcio wrote:
>>>>> On 2/27/26 4:48 AM, Dmitry Baryshkov wrote:
>>>>>> On Thu, Feb 26, 2026 at 02:35:52PM +0100, Konrad Dybcio wrote:
>>>>>>> On 1/12/26 9:25 AM, yuanjiey wrote:
>>>>>>>> On Mon, Jan 12, 2026 at 09:38:41AM +0200, Dmitry Baryshkov wrote:
>>>>>>>>> On Mon, 12 Jan 2026 at 08:23, yuanjiey <yuanjie.yang@oss.qualcomm.com> wrote:
>>>>>>>>>>
>>>>>>>>>> On Fri, Jan 09, 2026 at 05:22:37PM +0200, Dmitry Baryshkov wrote:
>>>>>>>>>>> On Fri, Jan 09, 2026 at 04:38:07PM +0800, yuanjie yang wrote:
>>>>>>>>>>>> From: Yuanjie Yang <yuanjie.yang@oss.qualcomm.com>
>>>>>
>>>>> [...]
>>>>>
>>>>>> Please correct me if I'm wrong, if we drop dev_pm_opp_set() from
>>>>>> dpu_runtime_suspend, then we should be able to also skip setting OPP
>>>>>> corner in dpu_runtime_resume(), because the previously set corner should
>>>>>> be viable until drm/msm driver commits new state / new modes.
>>>>>
>>>>> That matches my understanding.
>>>>>
>>>>>> The only important issue is to set the corner before starting up the
>>>>>> DPU, where we already have code to set MDP_CLK to the max frequency.
>>>>>>
>>>>>> Which means, we only need to drop the dev_pm_set_rate call from the
>>>>>> dpu_runtime_suspend().
>>>>>
>>>>> I concur.
>>>>>
>>>>>>> For MDSS, we're currently generally describing the MDSS_AHB clock, the
>>>>>>> GCC_AHB clock and the MDP clock (sounds wrong?) - there's not even an OPP
>>>>>>
>>>>>> No. As far as I remember, MDP_CLK is necessary to access MDSS registers
>>>>>> (see commit d2570ee67a47 ("drm/msm/mdss: generate MDSS data for MDP5
>>>>>> platforms")), I don't remember if accessing HW_REV without MDP_CLK
>>>>>> resulted in a zero reads or in a crash. At the same time it needs to be
>>>>>> enabled to any rate, which means that for most of the operations
>>>>>> msm_mdss.c can rely on DPU keeping the clock up and running.
>>>>>>
>>>>>>> table.. The GCC clock is sourced from (and scaled by) the NoC, but the
>>>>>>> MDSS_AHB one seems to have 3 actually configurable performance points
>>>>>>> that neither we nor seemingly the downstream driver seem to really care
>>>>>>> about (i.e. both just treat it as on/off). If we need to scale it, we
>>>>>>> should add an OPP table, if we don't, we should at least add required-opps.
>>>>>>
>>>>>> I think, dispcc already has a minimal vote on the MMCX, which fulfill
>>>>>> these needs.
>>>>>
>>>>> I have slightly mixed feelings, but I suppose that as we accepted Commit
>>>>> e3e56c050ab6 ("soc: qcom: rpmhpd: Make power_on actually enable the domain"),
>>>>> we can generally agree that it makes sense that calling genpd->on() actually
>>>>> turns on the power indeed
>>>>>
>>>>> What I'm worried about is if the clock is pre-configured to run at a high
>>>>> frequency from the bootloader (prepare_enable only sets the EN bit in the RCG,
>>>>> and doesn't impact the state of M/N/D at a glance), we may get a brownout
>>>>>
>>>>> This rings the "downstream really did it better with putting clock dvfs states
>>>>> into the clk driver" bell, but I suppose the way to fight this would be to
>>>>> simply set_rate(fmax) there too..
>>>>>
>>>>> I attempted an experiment with pulling out the plug. MMCX enabled with the
>>>>> AHB clock off results in a read-as-zero. I tried really hard to disable the
>>>>> mdp clock, but it seems like the "shared_ops" reflect some sort of "you
>>>>> *really* can't just disable it" type behavior (verified with debugcc)
>>>>
>>>> I think, in 8996 it was possible to disable it. Not sure about
>>>> 8998/630/660.
>>>>
>>>>>
>>>>>
>>>>> There's a possible race condition if we don't do it:
>>>>>
>>>>> ------- bootloader --------
>>>>> configure display, mdp_clk=turbo
>>>>> ------- linux -------------
>>>>> load rpmhpd     |
>>>>> load venus      |
>>>>> set mmcx=lowsvs | mdp_clk is @ turbo
>>>>>                 | brownout
>>>>>                 | 
>>>>>                 | <mdss would only probe here>
>>>>>
>>>>> *but* that should be made impossible because of .sync_state().
>>>>
>>>> Yep, sync_state should prevent MMCX or CX from dropping under the boot
>>>> level.
>>>>
>>>>>
>>>>> This may impact hacky setups like simplefb, but as the name implies,
>>>>> that's hacky.
>>>>>
>>>>> Relying on .sync_state() however will not cover the case if the mdss
>>>>> module is removed and re-inserted later, possibly with mmcx disabled
>>>>> entirely but the clock not parked at a sufficiently low rate.
>>>>>
>>>>>
>>>>> TLDR: reassess whether MDSS needs the MDP clock, if so, we should just
>>>>> plug the MDP opp table into it and set_rate(fmax) during mdss init
>>>>
>>>> And what will drop it afterwards? MDSS will still vote on the MMCX / CX
>>>> level even though DPU will change the clock freq.
>>>>
>>>>>
>>>>>>> The MDP4/MDP5 drivers are probably wrong too in this regard, but many
>>>>>>> targets supported by these may not even have OPP tables and are generally
>>>>>>> not super high priority for spending time on.. that can, I'd kick down the
>>>>>>> road unless someone really wants to step up
>>>>>>
>>>>>> I'd really not bother with those two drivers, unless we start seing
>>>>>> crashes. For MDP4 platforms we don't implement power domains at all, no
>>>>>> interconnects, etc., which means that the system will never go to a
>>>>>> lower power state.
>>>>>
>>>>> Right. Might be that 2030-something arrives and armv7 is gone before someone
>>>>> randomly decides to work on that!
>>>>>
>>>>>> MDP5 platforms mostly don't have OPP tables. (I'm not counting MSM8998 /
>>>>>> SDM630 / SDM660 here). MSM8917 / MSM8937 have only DSI tables, MSM8976
>>>>>> has both MDP and DSI tables (my favourite MSM8996 has none). Probably we
>>>>>> should start there by adding missing bits adding corresponding
>>>>>> dev_pm_set_rate() calls as required (as demostrated by the DPU driver).
>>>>>
>>>>> A bit off-topic, but:
>>>>>
>>>>> drivers/gpu/drm/msm/disp/mdp5/mdp5_cfg.c
>>>>>
>>>>> 96 is in DPU. any other candidates that should be moved over?
>>>>
>>>> Let's go through them.
>>>>
>>>> All SoC except those currently supported in DPU require SMP (shared
>>>> memory pool) support to be ported from the MDP5 driver.
>>>>
>>>> Most of the remaining platforms (except MSM8994/92) also had HW cursor
>>>> implemented in a fancy way, in the LM rather than in a separate pipe.
>>>> I'd really like to postpone those, possibly first completing migration
>>>> of the other platforms and dropping support for them from MDP5.
>>>>
>>>> 1.0  - old MSM8974
>>>>        I'd rather not touch it, it had bugs and I don't have HW
>>>> 1.1  - MSM8x26
>>>>        Probably Luca can better comment on it. Should be doable, but I
>>>>        don't see upstream devices using display on it.
>>>
>>> I have at least two MSM8x26 (1x APQ8026 lg-lenok & 1x MSM8926 htc-memul)
>>> devices working with MDP5 fine. I should've probably upstreamed panel
>>> driver & dts but they haven't been high priority..
>>
>> I think I have been saying this: having a panel & dsi enabled in DT is
>> the only way for me to know that the display is working on this
>> platform. I'd really kindly ask you and other activists to get at least
>> some panel drivers and corresponding DT bits upstream. It is really an
>> important flag for me.
>>
>> I can propose some kind of bounty for those getting MDSS+panel supported
>> in Qcom DT. (Beer at the next conf we meet? Some stickers for the
>> laptops and phones? Mämmi?)
> 
> Hm I realized yesterday (through trying it), that also MDSS is broken
> since the no-IOMMU codepath was removed from drm/msm. I thought this was
> only affecting GPU but it's also affecting MDSS/MDP5 :(
> 
> So I guess no panel enablement anytime soon until the IOMMU situation is
> sorted out, for both 8226 and 8974...

If you're sure the panel drivers are good (e.g. they worked on 6.whatever
prior to drm/msm saying sayonara to carveout), I think no one would object
to have them merged separately, so that you don't have to wait until
who-knows-when and keep rebasing them by hand

Konrad
