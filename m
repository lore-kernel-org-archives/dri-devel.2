Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14341CD4F54
	for <dri-devel@archiver.kernel.org>; Thu, 28 May 2026 13:02:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C21810F148;
	Thu, 28 May 2026 13:02:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="nmxdgFaP";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cL0lYCOt";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2BF0710F148
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 13:02:21 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64S8vP3E1562676
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 13:02:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 QkLBgrFATghw43YvF1sCEhlToO5Oy4l+TSxs1/G9Cfc=; b=nmxdgFaP9ycgIT+W
 Vzcx5XQ7QsrfZOMUaQmCJCGhEhcrVUvKGs+gSyiZLIqgsDcFr+5sauDNp1AqyHYg
 m7+BdatKUt5tHUrMScyUrHSLdeeLXY7aMmHY5I8/SFtUBrIDMkTuSWaHetdOHnwu
 FE9/nALG8S41XVLuXRGEr4DIg2BiBd3YxbAw2RqAOuH3PDEfRcrobTGVeUePsWO2
 uhEUXYnjGLSxN8eCbNZrJCRPpGZzo87cLlwDcd/bNr7SOXOLzpi8hI/xkD3zV/pX
 E+sYPA003hqn+IGhuXpnT2aNWg2Gqe6xspy51PRmC6xMHIFH8RDflhcMGsm71nF0
 RYX0Ig==
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ee7y2tsfv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 13:02:20 +0000 (GMT)
Received: by mail-ot1-f71.google.com with SMTP id
 46e09a7af769-7e63575a87cso6280828a34.2
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 06:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779973340; x=1780578140;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=QkLBgrFATghw43YvF1sCEhlToO5Oy4l+TSxs1/G9Cfc=;
 b=cL0lYCOtrzNysTqCufgCI32+PNgc94Jp99RblRNDTDllTfi+olfLzvsBlFHZmCioQ1
 ACh1ZgW85oYr4B1FBQaQgUiKmg2RiRhVyskDRmsPnmn8E57AngUav3eMk22C74Q/p8Do
 1JmqdN0iVFh62EAixR1UreZi5+maM6HokB9bdQsI/yaSYjyCkE950wrD85reVrdfI2zj
 rMyHp3LYV8mn79qJXUAL6H+ewVfvjuqA4jf9BECpifMr4Ojd0/dm7h1HZzsBMVtAgnVu
 ryR2Rhq+qbzriOW8GlTCuNPnhu8zjWSqGwjCTamNzYN36PCJqwFvfddkw715638I0gn/
 rSPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779973340; x=1780578140;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QkLBgrFATghw43YvF1sCEhlToO5Oy4l+TSxs1/G9Cfc=;
 b=Goi3wMy63Gk1+LIzSPZnHis7/sjDpWJlETLay5yfscialtG9sucD5IuNgsH6kAUeAl
 deMvMeT2Dl2/J1MxyFhuvA0toplYd0eZqLgy/Dxhan6uhjpUy/Hi3/HKP3Gj0ylG2cjz
 L5rvl+5K+1hY9pYI4AY4zvzwQ6kNT7MaBLoOaX8xcAyyLoMLMOAHdF0w2XXAnstcoBTI
 m4Chv8pC/hETlF7VVOkuIkemAp2p5K4AMLKIEdd2KhyEBcXc6t3cUbzKoIqTP0xoZM0I
 ARaZU05b/jsc578cLALK0H0FN9OVmfPwwN2iRWJB5dwvx2WYo67v66XSRbHhSfLgAefm
 I+sQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8rTOgAiNRxC9OZOcnMHUO+ezOROgoi1GLIxPgGYxJsibtDHKCrmtnNvfCI3mvnHAnqt047mBvUvrQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxPzpeBUP5aEslpW8dacxYypM8B464wFoTuNRhwFFFM5w0aIRJp
 wby1wIiTLqWtLU4v4oRmws4GdRmCQRoYxzKedX4z/fmX1gkUCuG4P6BfmU+hdW6k0uSUsRvbtxI
 I9pv6hVh1JX4c5+gNh+49QOiWJLzFV7NBhyQE1JCbUaUbSqCwLbeB2TJ29lBXiu4a5LtkwUU=
X-Gm-Gg: Acq92OFBRIHyZNaHHlZtrL3qFNo1HevHZ5F38VjXzhp+Zaez8Tsa28LESfitmuF+CGI
 jmqpY4xzbXYWBc8ErpL4+99thUfkN8hqeRUvdvDtQVzM8tcgcHtOPQychM60fOZpsNmoLxcawdc
 1TLVFNjxC9e5xwL+2XfM8XrLJm1TQK7nmTXfjHJOd6+PDRKpmbN06IKN3bgoIzHsjDTY/r1BKc6
 Lw7USTXnMMcGzmpIpjmMV+WZGR4WPBbsXJeqQxmkx0YbulX0WgjfUsX5w/3dvi6b6w8OEHD2k39
 f21XOso/gcLOKrj7+1VABnn3y7uICFRjlR/9cTJOnTPCTU/FRq7xEg20ovhQzDHQtR+gzcE/A5R
 9pT4CPt9MPngKpRo244t9cfABmBwRKJMfgnD0F7aC5B3svrlNbMqs/iOWrCbk4NxPdwCDPxzj7F
 Q7ChQHePXTBPc5tfx5P211T4AYVmDYOeQ9mY3wGXuIYbxjCYXmAryyVpLB5j3sxQtdYQuvldP2Z
 lilMy3cGxhujj8W+A7IPBQyKq0=
X-Received: by 2002:a05:6830:660c:b0:7dc:d0cc:91b with SMTP id
 46e09a7af769-7e5fefcb86bmr17464108a34.26.1779973338300; 
 Thu, 28 May 2026 06:02:18 -0700 (PDT)
X-Received: by 2002:a05:6830:660c:b0:7dc:d0cc:91b with SMTP id
 46e09a7af769-7e5fefcb86bmr17463543a34.26.1779973333375; 
 Thu, 28 May 2026 06:02:13 -0700 (PDT)
Received: from ?IPV6:2001:1c00:2a07:3a01:8e96:3679:b9c:de47?
 (2001-1c00-2a07-3a01-8e96-3679-0b9c-de47.cable.dynamic.v6.ziggo.nl.
 [2001:1c00:2a07:3a01:8e96:3679:b9c:de47])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-68b9d51a60csm115745a12.11.2026.05.28.06.02.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 May 2026 06:02:12 -0700 (PDT)
Message-ID: <4b09bd91-9a08-407a-9b01-216dd4d7aae0@oss.qualcomm.com>
Date: Thu, 28 May 2026 15:02:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Hans de Goede <johannes.goede@oss.qualcomm.com>
Subject: Re: [PATCH 0/3] clk: Add __clk_disable_unprepare_counts_only() and
 use this in simple[fb|drm]
To: Maxime Ripard <mripard@kernel.org>
Cc: Brian Masney <bmasney@redhat.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Helge Deller <deller@gmx.de>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>, linux-clk@vger.kernel.org,
 dri-devel@lists.freedesktop.org, ~postmarketos/upstreaming@lists.sr.ht
References: <20260527094811.116977-1-johannes.goede@oss.qualcomm.com>
 <ahd4XgTo3KZqGS9M@redhat.com>
 <66a76d9f-fe04-4a72-b6fe-42c2922fe9d9@oss.qualcomm.com>
 <20260528-sloth-of-delightful-chaos-1f02dc@houat>
Content-Language: en-US, nl
In-Reply-To: <20260528-sloth-of-delightful-chaos-1f02dc@houat>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=VeXH+lp9 c=1 sm=1 tr=0 ts=6a183cdc cx=c_pps
 a=OI0sxtj7PyCX9F1bxD/puw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=jBUPtkGcZuGRmuA17X4A:9
 a=QEXdDO2ut3YA:10 a=Z1Yy7GAxqfX1iEi80vsk:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI4MDEzMiBTYWx0ZWRfX70CXMz5KzAhX
 jxgHjcI0vCXaNPSZXFramTEDsKrElPhL+LB6e7lMWY01zVcBU7jgu0JGcUdaMTo6L9mfHuxpGDB
 EVqF+B+m2DHOGsh6i+QeTSAlJfN72UGmL8H8mXjnF03tVE5qOHK4sqr5kFr9ZXsaHeZAgax9wSw
 P5VY8MmWzJ++6bffzKOSkFxvHKd/hf315oILqf8Qs8bPvgxA5xHtrBis8CYobP3OLbX1BPnk219
 DHBo/LOscYxZnqe95A0sSrNUVBKEVlWH8B8j4wXAe7H3F5VvaOIbCUM13MCv5ricTWJq/JxGG5U
 270zUJ1GOnfD3AyyN64q4Y4G5DDT49OV9/wkmnfswyQftdKyCC/42e+GeOBZe8zS2LHG6uxtxSx
 Vr34pAokQ3hzpM5SuWp9in6ziJWPoelGERwChrf222nVYLtdZlZM+6tugXzstW8q8lEimhA+FIi
 mYsIFUiIpHL5C1oV+Gw==
X-Proofpoint-GUID: Mw_-vUGRaA9Ls_OyyVqETMtqF6G2ldWI
X-Proofpoint-ORIG-GUID: Mw_-vUGRaA9Ls_OyyVqETMtqF6G2ldWI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-28_03,2026-05-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0 malwarescore=0
 impostorscore=0 bulkscore=0 suspectscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605280132
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

On 28-May-26 2:08 PM, Maxime Ripard wrote:
> On Thu, May 28, 2026 at 12:12:10PM +0200, Hans de Goede wrote:
>> Hi Brian,
>>
>> On 28-May-26 1:03 AM, Brian Masney wrote:
>>> Hi Hans,
>>>
>>> On Wed, May 27, 2026 at 11:48:08AM +0200, Hans de Goede wrote:
>>>> 2) One option considered was detaching the simple-framebuffer driver later,
>>>>    after the real display driver has had a chance to claim the clocks. But
>>>>    this won't work in cases where the real display driver picks different
>>>>    parent clocks then the boot firmware did and needs to reparent clocks.
>>>
>>> Why won't that work in the case where different parent clocks are selected?
>>> I'll describe a scenario below.
>>>
>>>>
>>>>    Basically the goal is for things to behave as if the simple-framebuffer
>>>>    driver was not there at all, because that leaves the hw in the state
>>>>    the real display driver expects.
>>>
>>> I think the deferred unbinding could have some potential here where
>>> there is some kind of notification mechanism between simple-framebuffer
>>> and the real drm driver. So:
>>>
>>> - simple-framebuffer driver takes reference(s) to the clk(s).
>>>
>>> - real drm driver eventually loads, takes reference(s) to the necessary
>>>   clk(s).
>>>
>>> - real drm driver sends a notification to simple-framebuffer that it's
>>>   done, and has control.
>>>
>>> - simple-framebuffer can unbind and release its references to the clks.
>>>
>>> No clks will be shutdown prematurely in this scenario.
>>>
>>> If the real drm driver needs a different parent, then presumably things
>>> should be setup correctly, and simple-framebuffer can have the clocks
>>> shut down when it calls clk_disable_unprepare().
>>
>> If the real drm driver needs a different parent, then how does it
>> do the reparenting while the simple-framebuffer driver is holding
>> a reference to the clock ?  In that case the clock might have
>> a protected_count of non 0 (depends on the core-clk flags) and
>> reparenting won't work.
> 
> The only case where it should reparent you listed was that you might
> need to pick up a different resolution. However, that can only be
> enforced by an ioctl or a client.
> 
> simplefb/drm is removed in msm_drm_kms_init. The device is published
> drm_dev_register called right after msm_drm_kms_init, and the clients
> are registered in msm_drm_kms_post_init, called after drm_dev_register.
> 
> There's no way in the current msm architecture to have a modeset happen
> while the simpledrm driver is still active.

Ok, new plan, please let me know what you think about this:

1. Add a new "disable" callback argument to
devm_aperture_acquire_for_platform_device() and store this in
struct aperture_range

2. Add a new aperture_disable_conflicting_devices() which
calls the disable callback for matching devices.

3. Have the simple[fd|drm] drivers implement a disable callback
which unregisters the drm dev and releases any claims on the
aperture mem-region, while keeping clks, regulators, etc.
enabled. And have them check if disable was called on remove()
and if not do the disable() things on remove(0

4. Have msm call aperture_disable_conflicting_devices() where it
now call aperture_remove_conflicting_devices() and call
aperture_remove_conflicting_devices() at the point where it has
claimed any clks it needs.

Does this sound like something which would be acceptable ?

Regards,

Hans


