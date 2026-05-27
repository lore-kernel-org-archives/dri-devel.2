Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 697F4CD5BD0
	for <dri-devel@archiver.kernel.org>; Wed, 27 May 2026 12:21:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D66A710E26F;
	Wed, 27 May 2026 12:21:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="biGTOd8l";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Q/woFxpi";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D7CFB10E26F
 for <dri-devel@lists.freedesktop.org>; Wed, 27 May 2026 12:21:54 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64R8mThg3830775
 for <dri-devel@lists.freedesktop.org>; Wed, 27 May 2026 12:21:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 EoI6qesmj2SY+3aJfTjx7veZsHstbofPXkqKjrx/keI=; b=biGTOd8lQ0BCRYuj
 bXZT3DWA5ljzML+mVvIaDspGGxGdYYc02S1y9qjl6+yvbMCieK3F29esOHyM4Jsi
 EG91GemfQmtSAxFTI7TTwpg3o8Wt6OB0z3AxQdhHvhW53zCFwI4zsFKa9QS5tedZ
 KXYqASZAyVLI8+zMJCLwx9WzQEfegQW81hIuEXwjYoAQPtXWWZz5LGIResfPZBEY
 GGJuxftkU7156XgZEGBbjDrL+oIAOPpo5UGgWIlu7CdT1+55IAjJX+U9BNPn8cx+
 QBCF9QVCeZE/Juuq3rDAFdBCAcRa5sHjn7XvBkqdMk1uHoiTjVIeF2vSSNpEV/FW
 C7ih7A==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4edn17jfj1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 27 May 2026 12:21:53 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-516d4b3f3a1so118652981cf.1
 for <dri-devel@lists.freedesktop.org>; Wed, 27 May 2026 05:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779884513; x=1780489313;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=EoI6qesmj2SY+3aJfTjx7veZsHstbofPXkqKjrx/keI=;
 b=Q/woFxpiYUW/ji88t/af15cJNm7MhmnMrjQFEgx5974bzuNd7l16xsDDXlecJ7bNq9
 DzJqb1iMOLnY6rPrvVuUDbi/gJJ5xsW45SfXeqcBQdwEv4jgtW7jqHDXpqrif5f39azk
 c+BYTIRlTOBLx/hHh76uq1Oq/Vk1O+xZZ5oysqFtWwwwnLWNuTP7dBj3EBm3l8kRyNFP
 Ezdg8ZRpm+KkOcWdFI4EUdnqh11hnhhEgns3nsgn1NI5UHBponQATmhxV4PLJdAfJE70
 3m91U8FGLIvKY5JZaQQxjS+R43oHiW1H85xUPK/E3+jsXsnK5/7bKvR0Hq2WXvYwp9IW
 Z5Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779884513; x=1780489313;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EoI6qesmj2SY+3aJfTjx7veZsHstbofPXkqKjrx/keI=;
 b=hTwoZM5Znap3a7DD74iVdWHKKC8fR3LBYTrZEq6lntvgLXn9DkL4gfhb9b6TwkC/9h
 G7ZVB6tAyGM42t7Fka5n6FM/FdIuxkBRZkf9vEnvdrYpy+zvj8qcsmQ3TrppEFC6ClBE
 GAzuUPT4RplXyTzpoz6DLpzm0I0Tboktj4BXlu42mPNS+ZCQ5DTUQ5CnDUkro3La6lIs
 hDGwNXPwQfE7Yz/KRkEMeQdBzDaARDK2JUl95U1JFAwKJMP6nY6PAGoyLDSIuTdQRVKd
 3MwxIYLyKXgQ/l2OD9AkU2oZM+ey5hqtRcB5sdErIQUBYvG15CZibLvRyWjFeAUEFXm+
 5IjA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+NMr45ONRiA23w704Tp2n09MGadmpt0b9Z62GQpvg9vhC4QxS/GqiQLy/SprNR8gpGimoSt7ahwtI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy3M+81ERXqvKhd3jNuqy4xWL0/Z4/r0FvhSgBqmk8avhlVgPib
 YaXfg4/9fdxUBCVPP8W8Qe7wE3jzOwx3DlooZowwo7LVhe66Ik9hkPf1o/Cp4hdskF3aNjFZ3Cs
 pWhMLztrFRSYKKIEAgViJXMah3s26xHRr9Id9Hmi1fokRgnGIzLqr4WUt6DhN0dR6Pm0fABM=
X-Gm-Gg: Acq92OEzvRDZBWcZ4lgqCys2UOW/s6pRNzzbZ15kpZn5ducD3plPOj9W35qWfar3zJV
 XA/hfNJAN2Ru+QD8qBVcIzPW5lKEzhXxocJhcAiEpYklDYGW3nqNjZtS2jci2XpMMfTH43XPlDb
 uCV/y+hcygbs2z2X33Hqj044cIHV1gMSIvRAKiVmn4aPTLFGd/rBdHua3C7vY8rvPVhIhWct7ri
 938sQFwNEC8K8fCPYm1G/VTw0yQBf6NjuYP7URuVJY/+kRvnJ/UNAbQKPmnd69QBOSdgdZya+HL
 t7jkgSqG5Qk+DZ4pcIVE5xc0iBqF0AXr2EJz+NusSDjTPVOvsdR2z6AucyX7V6+7Ub9Tax4Q0LW
 MRlqEtJU6rk9jicniXyi70iJoEv5zvB494FRd5gQ6tjvWopbomaZYKEJ2BTnuXPx2/2/lSmJv+i
 rB0QGIW02m2AEHwbZtBj5J9rwHruHexuRewst16OAiYoc7iqvQ55Wgker0EAOpLJkZCjDyLgWg9
 m97to1OqagESIKMSwR90e52ILs=
X-Received: by 2002:a05:622a:5915:b0:50b:4337:179a with SMTP id
 d75a77b69052e-516d42ec329mr301524721cf.3.1779884513025; 
 Wed, 27 May 2026 05:21:53 -0700 (PDT)
X-Received: by 2002:a05:622a:5915:b0:50b:4337:179a with SMTP id
 d75a77b69052e-516d42ec329mr301524121cf.3.1779884512438; 
 Wed, 27 May 2026 05:21:52 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec?
 (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl.
 [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bddc3051337sm616016166b.19.2026.05.27.05.21.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 May 2026 05:21:51 -0700 (PDT)
Message-ID: <496facc4-60bc-4646-b426-30e7ac545d9f@oss.qualcomm.com>
Date: Wed, 27 May 2026 14:21:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Hans de Goede <johannes.goede@oss.qualcomm.com>
Subject: Re: [PATCH 0/3] clk: Add __clk_disable_unprepare_counts_only() and
 use this in simple[fb|drm]
To: Maxime Ripard <mripard@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Helge Deller <deller@gmx.de>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>, linux-clk@vger.kernel.org,
 dri-devel@lists.freedesktop.org, ~postmarketos/upstreaming@lists.sr.ht
References: <20260527094811.116977-1-johannes.goede@oss.qualcomm.com>
 <20260527-flawless-chowchow-of-fruition-edbe8a@houat>
Content-Language: en-US, nl
In-Reply-To: <20260527-flawless-chowchow-of-fruition-edbe8a@houat>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI3MDEyMCBTYWx0ZWRfX00MdN3k+QEYy
 YkK2V6rJw4k9jcxgyCJFc7YbAy0xH0mBQp2biCfvpSjxY1CzQKE0XMLb0gejH0OfiM3xrDMMqTt
 K/EW1/MkdOD7m1j/nmtsrqcHkSe8ddlxvhZeemnEMdF0Ucvk+hV983wbdXbxUL/PZ3rEabz7gm4
 flU9pamV8RpRm1MTZ2j5ho1dQByWcMDnwemtX9qDA1mUbMoOrW7wHNxJDuocpsCdxzMp/MEFsMS
 fHaA1OkDTJd6rD2yxs1MCBbuFgILXsxMrCBbxf6trSESAYHCaf+egWMj5sUL1PbKOwZNXUsNLzJ
 DYQxxSHk16dA6bywtwq4kGRe3MKmJCFCAG7RgOPQsNogWNJka5WZxBFPCuhwL0FvH/BhiRnUTLv
 B2BDcfs0ia8fjCZsgfhqo57BZOQIkkg8lBWkEnMuLMBE9mGFGWBYepsO1e2fTOqXa+oDwt9xDo3
 ArlOfhl2o5wFId8Pupw==
X-Authority-Analysis: v=2.4 cv=R6Uz39RX c=1 sm=1 tr=0 ts=6a16e1e1 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=VwQbUJbxAAAA:8
 a=WkAwBIMq4Wj_tXgkhSkA:9 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: kDXcu71VGfHuPEUJ1uK62GOeJzzGeA2D
X-Proofpoint-ORIG-GUID: kDXcu71VGfHuPEUJ1uK62GOeJzzGeA2D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-27_01,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 adultscore=0 impostorscore=0 clxscore=1015
 suspectscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605270120
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

Hi,

On 27-May-26 14:04, Maxime Ripard wrote:
> Hi Hans,
> 
> On Wed, May 27, 2026 at 11:48:08AM +0200, Hans de Goede wrote:
>> Hi Michael, Stephen, et al.,
>>
>> The device-tree simple-framebuffer device is special in that it does not
>> describe actual hardware, but it allows firmware (e.g. u-boot) to pass a
>> firmware initialized framebuffer to the OS to use as display during boot.
>>
>> To avoid clocks used by the firmware framebuffer getting touched while in
>> use, the DT node contains a list of clocks which should not be touched
>> while the simple-framebuffer is in use.
>>
>> Conceptually this is fine, in practice the *do not touch* is implemented as
>> a clk_prepare_enable() + clk_disable_unprepare() pair, with the disabling
>> happening when the simple-framebuffer driver gets replaced by the real
>> display-engine driver.
> 
> Which is also pretty fragile because it doesn't lock the rate either.

That depends on how the clks are configured / setup by the clk driver
if the CLK_SET_RATE_GATE is set in clk_core.flags then protect_count
will get incremented and from then on the rate will be locked.

We could even have the simpledrm / simplefb code call 
clk_rate_exclusive_get() to lock the rate.

So there are multiple ways to lock the rate if necessary but so far
in the real world there has been no need for this AFAICT.

So IMHO this is something to worry about if / when we hit this
actually happening in a real world scenario.

>> The simple-framebuffer concept assumes that the order in which resources
>> are acquired does not matter since they are already on, so power-sequencing
>> is not an issue. But clk_disable_unprepare() actually turns the clock off,
>> messing with the hardware state before the real display driver loads,
>> without any knowledge of the proper power-off sequence for the display.
>>
>> The turning off of the clocks outside of a proper power-off sequence causes
>> the following error when the msm display driver tries to re-enable them:
>>
>> [    2.980181] disp_cc_mdss_dptx3_pixel0_clk_src: rcg didn't update its configuration.
>> [    2.980272] WARNING: drivers/clk/qcom/clk-rcg2.c:136 at update_config+0xdc/0x100
>>
>> Resulting in a non working display.
>>
>> To fix this, we need a way to properly implement the "do not touch" concept
>> for clocks.
> 
> I'm not sure it's something we can enforce, really. The firmware can
> modify clocks behind our back.

Generally speaking there is a contract with the firmware that either
the clock is firmware controlled and the OS can maybe make firmware calls
to request changes; or the OS is in control. Both trying to control
the same clk at the same time is a bug and IMHO unrelated to the issue
at hand which is about clks which are under OS control only.

> Other clocks might change this one as a
> side-effect of a rate change or reparenting, etc. It's just not
> something we can commit to.

See above, this is exactly what the protect_count in the clk-core
is for.

> 
>> clk_prepare_enable() is fine, the clocks are already on so no
>> ordering worries and it ensures that the clocks and their parents cannot
>> get turned off by incrementing their enable, prepare and protect counts.
>>
>> clk_disable_unprepare() is a problem though since it actually turns the
>> clocks off. Instead something is needed which only decrements those counts.
>>
>> This series introduces a new clk-core function called
>> __clk_disable_unprepare_counts_only() (1) which does just that. Prefixed
>> with '__' to indicate that normally drivers should not use this.
>>
>> Michael, Stephen sorry for needing to add a new clk-core function for this,
>> but I see no other way of solving this (2)(3). The changes are not that
>> big / not too bad.
>>
>> I've also considered making __clk_disable_unprepare_counts_only() implement
>> all the logic itself instead of adding the extra parameter to
>> clk_core_unprepare() and clk_core_disable() but that leads in duplicating
>> quite a bit of logic (4) so this seems better.
>>
>> The other 2 patches just replace the clk_disable_unprepare() calls in
>> the simple[fb|drm] driver with the new helper.
>>
>> This series fixes the display not coming up after switching to the msm
>> driver when a simple-framebuffer node with clocks listed is used.
>>
>> 1) I'm open to changing the name, this is the best I could come up with.
>>
>> 2) One option considered was detaching the simple-framebuffer driver later,
>>    after the real display driver has had a chance to claim the clocks. But
>>    this won't work in cases where the real display driver picks different
>>    parent clocks then the boot firmware did and needs to reparent clocks.
>>
>>    Basically the goal is for things to behave as if the simple-framebuffer
>>    driver was not there at all, because that leaves the hw in the state
>>    the real display driver expects.
> 
> So I know it's not really what you had in mind, but if you are only
> concerned about the transition from the bootloader to the DRM driver,
> then I think supporting the following work would help:
> 
> https://lore.kernel.org/r/20260423-drm-state-readout-v2-0-8549f87cb978@kernel.org
> 
> With that series, we can build the initial KMS state from the hardware
> state, which means that if you were to change the resolution at boot, it
> would be executed just like any mode change in KMS.

Hmm, so your suggestion would be to have the initial KMS driver probe()
only do a read back without touching anything. Then claim clks matching
the read back config and then only release the simple* driver and thus
the clocks after this?

That is certainly an interesting proposal but IMHO almost orthogonal
to this one (1). Even if it may fix the issue in the end, it seems
that that work is still quite a way from going upstream and even then
initially it only potentially fixes this for the TIDSS driver since
that solution needs a lot of per driver work.

Where as my proposed fix here is much simpler and fixes the issue
for all drivers in one go.

So I would still like to move forward with the fix proposed here.

Regards,

Hans


1) As you write yourself:

> This should help mitigate your initial problem, even though it's a
> widely different solution.

