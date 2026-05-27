Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7732DCD5BD5
	for <dri-devel@archiver.kernel.org>; Wed, 27 May 2026 15:09:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C653C10E202;
	Wed, 27 May 2026 15:09:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="VU0HqmB+";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cRxbac95";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9920F10E202
 for <dri-devel@lists.freedesktop.org>; Wed, 27 May 2026 15:09:45 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64RF7B8e879263
 for <dri-devel@lists.freedesktop.org>; Wed, 27 May 2026 15:09:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ufMpfNyxnplHu867LBcoTwXEhS7HS0xoMB7D0cXK4Ko=; b=VU0HqmB+22HdnLmS
 aG0oxzVe+S0LRW8Bn5GH/DecXErIcy5Kgza6RStdgEaSh0fe6u/9F0fuppObKRPy
 jX6TOxh+yciQeXCp43Q3EHCxqH9Kzn7amzXbaRJN5OSd1hEY9k1KYrqxCXZ2i8Wh
 jV4iJdj5UI/QKqF513y5Ax4Br3N10SMpdfvv6IWFousNnyD2W7e9lR4bKm1d+ki1
 SPtoJmz1DQaoOV7+dtbbf5HHxYHdgkGBFAq7gczOV4CbcEraEAKVGCJqWVcE5XpM
 GZTyHfHnL+RSR1c0/+uj0IFcnq1yfR/i9qxkuTtnM4TK/LAglfaj3KMYoc0GEosR
 HjMsTA==
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com
 [209.85.221.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4edvvqskyn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 27 May 2026 15:09:44 +0000 (GMT)
Received: by mail-vk1-f199.google.com with SMTP id
 71dfb90a1353d-5954c5fbcc7so268207e0c.0
 for <dri-devel@lists.freedesktop.org>; Wed, 27 May 2026 08:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779894584; x=1780499384;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ufMpfNyxnplHu867LBcoTwXEhS7HS0xoMB7D0cXK4Ko=;
 b=cRxbac95r0bL41THGWWcD7435nW14MNAzgxcZqpdZrino2u/Pxcf+UvO6vsjjt0W66
 voe85NIKLpfUeqZTQZBwQNA/8//JMfj9dWvv9M8ZeOA6icNyBravEpYfqJm4DXy+tb1u
 bg2iDvs6OMgn+kJHg7vPOAQnfCE0lvBs5jd7QPHRJWqaj3Z6DDCxyjxpHxEcQ6cN40km
 Cra62C8MGTib8RwI2DpKCdJCK/FiP8wcYcyeozRwjkSlOKy1TwbkT28zAYAmT4TaEHW9
 2KPhNndJnsbw46qPumIHqo5lUg2UuX7VzaHtMzahO9H+qALAENUfSFvuGMjxO72vTnjX
 g9eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779894584; x=1780499384;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ufMpfNyxnplHu867LBcoTwXEhS7HS0xoMB7D0cXK4Ko=;
 b=Sk+MVQNnOxx7ihZgM3okuy2CsMeRrucYg9EeQHadQ82NKezHURmJUxK2PhTCaPyluo
 3IU2tbMwWeXlQivFfSQW8zrkZevuf+Gz7SrNVTo4IHyP+K8TXC56Qq1b0C6fbQuWunmP
 0dQyV4HafcKoiZIBqr5AOLVECy844ZAtl2ASWGStkYAcd7nZQCAAWSNBmMhLmCqOikJp
 QfL9QRHcU3kgs6x+Xf7L5GcXlvvPZU202cQm/w29KeEdUaVtucIRU/BDPFIRiQIT9akb
 1NRAfrwPXC612PonnMU0QGaqOEaEn42nVlKBhPQ/AJfJ8/HW1PcuUmxkwWfQzk88lTlB
 yMaQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+OA5lylSDpnShbXdsJiFVIcVUEjqJjDZ8fPfVFdN9yJF3gqKH+wwVlIgefwMigdenPVU39CEcls+Q=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyLwrQgOvFZ02OIHvodsTd7U6PZDUQU7B/QGpmvllRwWm9v0Mx1
 h/I0YssRC1+WhAML+7ArTOBxk5fGFybISchjCOfnykJ7DEVQUZhUvwukO4OUK1dBQo+fIXoNUMG
 akftLobeQIMlFoNAIePB8ul6KvE5kC+pVceUrGRwUS8RwX5wcmITjT2CvIZfkyAgEZswT9g8=
X-Gm-Gg: Acq92OFmfkISqndMMyev5qp/xW+29Ia5pvfa7Z5kCx0eSGRn0sx4mdbT2/TbHHnjO7k
 cKel//5Ggkmyk8M2HmSW2AodouymsAmCJrKeF10XaT9T58Gk/XamGfKf8a6k/7nov5F5XcRv6SM
 7U6/JYhOYBNLDwVrjKf9Lc2c+cCpGf3xSy/ZEfYoI0YYHOWBjLAINPvbu0je/Vf68lCX4RJeZ0X
 3X+/SuRvxTlukNuyTp+QqIGwpb2mh1EFlnJKuCBgY7yu3XPry2PaKugOdkKSnU3tjzAOBulx+0C
 DojlFwJBCqmNSTytZ0fh22z2f5dao+5ActwXGrP1oAllYaUuZUUdDbYwc24qF9zpq5q+Ncd5tEU
 m6NlBsTnGtfu1XI6rwR1NPsugL8s69SEzERlgnphDIR2iGRQ29iQFO7W7Gb6g7kPgxPKbjQM4nE
 V25Dq/jfIIz9M0jDNqD8pdM2diJUjUHwU49FZMEnlX6mvMZHAomtH5d2pz3fYAFDnErQfEtcXFK
 FuwOEiFoY5h3V3ZxTyHl3cqIVA=
X-Received: by 2002:a05:6122:a0b:b0:56f:2aaa:450c with SMTP id
 71dfb90a1353d-5865e4a60f4mr11772644e0c.1.1779894583857; 
 Wed, 27 May 2026 08:09:43 -0700 (PDT)
X-Received: by 2002:a05:6122:a0b:b0:56f:2aaa:450c with SMTP id
 71dfb90a1353d-5865e4a60f4mr11772589e0c.1.1779894583407; 
 Wed, 27 May 2026 08:09:43 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec?
 (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl.
 [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-68a6faadb8fsm893905a12.6.2026.05.27.08.09.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 May 2026 08:09:41 -0700 (PDT)
Message-ID: <4f34c957-817d-45fe-ac13-02b98e77f010@oss.qualcomm.com>
Date: Wed, 27 May 2026 17:09:39 +0200
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
 <496facc4-60bc-4646-b426-30e7ac545d9f@oss.qualcomm.com>
 <20260527-armored-spiked-jacamar-0bb19e@houat>
Content-Language: en-US, nl
In-Reply-To: <20260527-armored-spiked-jacamar-0bb19e@houat>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI3MDE1MCBTYWx0ZWRfX4M6uHpkYRFMy
 40VtYuJYWA57JJIECh3QFtI9UY7I9/eRHJmR0+q8jtQePsg3xEIf8Jme9unLVtRMWaZ/jebj/Kd
 0VLH9qPkBansP3dEnRr9n/JtGw4vVLjNmwedjeLPLcng+gTpJz2VIpqg4e6nQUh1W875qSr0pDX
 5OOOusCTf0YUEPRdjnnVoIwzMrYRLzwA1WnK2p9WeP1VD9yBjmsRIHRyWWURscbqJ8I1+oRls8B
 +dXENHdQ9W3j2i6WMc/Pm2MgSoAeUB8LyNe7HxzZaHrcUnskXQQojDWmSsI+n9vMV50sDLqWz5B
 FSuEwsV6jhMjHtXehQxwocl9V8ZX8be0Hdzt4QSKNGq0G7R8g4DecWvr4KEX5gQKbvLNQjdVhMG
 hpUfvKnbC76Rovr0IvzhVx1YA0JP9R8mWZQZWbxvNhePAZRPdX8+KVSlfxN4wqbHsimNXEUVqeM
 eenErNdQPH7Z3NAy3iw==
X-Proofpoint-GUID: t_V2lcPmeez_tBByRHHxcjXBQuykYr_U
X-Proofpoint-ORIG-GUID: t_V2lcPmeez_tBByRHHxcjXBQuykYr_U
X-Authority-Analysis: v=2.4 cv=fLMJG5ae c=1 sm=1 tr=0 ts=6a170938 cx=c_pps
 a=+D9SDfe9YZWTjADjLiQY5g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=VwQbUJbxAAAA:8
 a=vTr9H3xdAAAA:8 a=eS7AplsvlCe1A2W4UzQA:9 a=QEXdDO2ut3YA:10
 a=vmgOmaN-Xu0dpDh8OwbV:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-27_02,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 suspectscore=0 spamscore=0 impostorscore=0
 clxscore=1015 adultscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605270150
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

Hi Maxime,

On 27-May-26 14:48, Maxime Ripard wrote:
> On Wed, May 27, 2026 at 02:21:50PM +0200, Hans de Goede wrote:
>>>> clk_prepare_enable() is fine, the clocks are already on so no
>>>> ordering worries and it ensures that the clocks and their parents cannot
>>>> get turned off by incrementing their enable, prepare and protect counts.
>>>>
>>>> clk_disable_unprepare() is a problem though since it actually turns the
>>>> clocks off. Instead something is needed which only decrements those counts.
>>>>
>>>> This series introduces a new clk-core function called
>>>> __clk_disable_unprepare_counts_only() (1) which does just that. Prefixed
>>>> with '__' to indicate that normally drivers should not use this.
>>>>
>>>> Michael, Stephen sorry for needing to add a new clk-core function for this,
>>>> but I see no other way of solving this (2)(3). The changes are not that
>>>> big / not too bad.
>>>>
>>>> I've also considered making __clk_disable_unprepare_counts_only() implement
>>>> all the logic itself instead of adding the extra parameter to
>>>> clk_core_unprepare() and clk_core_disable() but that leads in duplicating
>>>> quite a bit of logic (4) so this seems better.
>>>>
>>>> The other 2 patches just replace the clk_disable_unprepare() calls in
>>>> the simple[fb|drm] driver with the new helper.
>>>>
>>>> This series fixes the display not coming up after switching to the msm
>>>> driver when a simple-framebuffer node with clocks listed is used.
>>>>
>>>> 1) I'm open to changing the name, this is the best I could come up with.
>>>>
>>>> 2) One option considered was detaching the simple-framebuffer driver later,
>>>>    after the real display driver has had a chance to claim the clocks. But
>>>>    this won't work in cases where the real display driver picks different
>>>>    parent clocks then the boot firmware did and needs to reparent clocks.
>>>>
>>>>    Basically the goal is for things to behave as if the simple-framebuffer
>>>>    driver was not there at all, because that leaves the hw in the state
>>>>    the real display driver expects.
>>>
>>> So I know it's not really what you had in mind, but if you are only
>>> concerned about the transition from the bootloader to the DRM driver,
>>> then I think supporting the following work would help:
>>>
>>> https://lore.kernel.org/r/20260423-drm-state-readout-v2-0-8549f87cb978@kernel.org
>>>
>>> With that series, we can build the initial KMS state from the hardware
>>> state, which means that if you were to change the resolution at boot, it
>>> would be executed just like any mode change in KMS.
>>
>> Hmm, so your suggestion would be to have the initial KMS driver probe()
>> only do a read back without touching anything. Then claim clks matching
>> the read back config and then only release the simple* driver and thus
>> the clocks after this?
> 
> Almost. Part of the call to drm_mode_config_create_initial_state() if
> needed to make it grab its resources. See atomic_install_state in that
> series. So probe wouldn't have anything more to do.
> 
>> That is certainly an interesting proposal but IMHO almost orthogonal
>> to this one (1).
> 
> Why do you think it's orthogonal?
> It would completely fix your problem.

AFAICT in its current version it does not contain a mechanism to
delay the remove conflicting framebuffer call, so no it does not
fix my problem.

>> Even if it may fix the issue in the end, it seems that that work is
>> still quite a way from going upstream
> 
> It's likely to be merged in the next few weeks.
> 
>> and even then initially it only potentially fixes this for the TIDSS
>> driver since that solution needs a lot of per driver work.
> 
> I mean, yeah, but the good thing is that you only have one driver to
> care about, right?

I would prefer my proposed KISS solution, which works everywhere, over
your quite complex solution which requires complex per driver changes.

When I was still working on:

https://fedoraproject.org/wiki/Changes/FlickerFreeBoot

I needed to constantly fix i915 fastset support and when I stopped
fixing it due to -ENOTIME it pretty much was broken most of the time.

Last time I check modern (Alderlake +) laptops never had working
fastset support and there always is a visible most set on newer
laptop models because of this.

This state-readback stuff is quite complicated, as the list of
known issues in your cover-letter shows. I wish you all the best
with it, but I really do not see this as a good alternative for
fixing the issues *this* series tries to address given the huge
disparity in complexity between the 2 fixes.

I'm also worried that the readback stuff is likely going to be fragile
so might end up being disabled or automatically detect some issue and
disable itself at which point we're back to having the original
problem this series tries to fix.

Also atm AFAIK there are no plans to add state readback support to
msm and there are a lot of other higher priority items to work on.

###

Anyways since your patch-series will not work for msm in its
current state, I would still very much like to hear from the clock
maintainers what they think of the approach suggested here.

Regards,

Hans


