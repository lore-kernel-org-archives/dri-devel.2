Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94C48CDB479
	for <dri-devel@archiver.kernel.org>; Wed, 24 Jun 2026 09:06:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B5E2010EE23;
	Wed, 24 Jun 2026 09:06:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="kaEPrygl";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="f4H96YXt";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D8DA10EE23
 for <dri-devel@lists.freedesktop.org>; Wed, 24 Jun 2026 09:06:54 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65O5u0ee1976594
 for <dri-devel@lists.freedesktop.org>; Wed, 24 Jun 2026 09:06:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 tLJS/xxGpmH5Sjk0T0ZHYJD59/fFQLlZcyrGkk9YUoA=; b=kaEPryglmab/KCyS
 HoY8Z8MpOOK4Zc6gUpmN7EnqUWCs/68flLO6QD5G8LiX6zwOF1Irp7g9E3WvvIdz
 aIY6uIOt+rS34uldnoQh18bI41L4AakU36T42N32aKbeTtmlUIgdNyeUHlbaIwxg
 FGUrCJ4GOUeesYLS4/OVOVCK6RwWuKQwZ+1vhCijS+EvpV4kOjKowouBCDxOF4Ay
 uMP1D3KVYH3eTYCZPbiHgW869gxb3k4dZ8yPLv8jHMd+AF3sO57nhJvc40xY0dYm
 1fmQu7XFnaBKUy0HZYHvMcaCK7SmPTEwaKG9mqaUAJIl5dqbZSBY/lktxIt+X8uo
 x+I8yQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f05aq9cyp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 24 Jun 2026 09:06:53 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-9157ae36434so104307185a.0
 for <dri-devel@lists.freedesktop.org>; Wed, 24 Jun 2026 02:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782292013; x=1782896813;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=tLJS/xxGpmH5Sjk0T0ZHYJD59/fFQLlZcyrGkk9YUoA=;
 b=f4H96YXtigngO/rXLmOCEboSDnaRcX8UTwnz0U5pQ86Z1CTc7wvYooRDbMWcygK3it
 mOWd936i42d3GWi9SYmVaWoZvdqVPopb/yqIrokFChT+dnyFOhnRuZLW7Sd53kuYl//7
 LD2LDpZD9ubBhB3ypgQpaVzMnDm2koHSAnVY7Fl3QyNoTrItcztanHb7QezI3jFem8B+
 tvoVBYSw6mbqlJMjw5vbuC1cvaUjxT5Gethap60BTNJqc3/z1lrPOLQ+Js3SC5kynL8W
 CD0AFFF4lmur+blQbXEQRh7EcHiml/Ra2OdXWz7j75N2z2DCgIqdg4LNuLElGdXB1Rp4
 /g7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782292013; x=1782896813;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tLJS/xxGpmH5Sjk0T0ZHYJD59/fFQLlZcyrGkk9YUoA=;
 b=Nbv3QE5H7F0yAv2ynnkzzzBSUiqrie/ZcT0ASTHyVSKygMnVqciUeleqvAuJ5RqWQu
 nadws+ikqXm0RnvndSLQoO/YRGSphxXkHFSmEBmrMVQOiVkGq1IengDPZPwc5FC+1CBI
 41u5aoC2UGIdJpbRPAyO8mCgMySYBmjYS9KzTRuP5oZ2TM6XzOcSR3RDWGQ49Bd6cfji
 RdHecchfaAhFqPeJ8B8priN3yoPv/otJqQsStWFZHyrCZP5bxJPSPw18fTwQiEOnevmX
 ztwCMd3bt9ZJqR70N8k8KfsipOGDRNftk7rUAgXbTmOMUYa5OcGmcgGIEq5oWOfwg9an
 T+VA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+YROHsrJ1sB2vOXf8yiC7SRAD5VTNj7YzPGRjDhtQdRcnFY5H+JSOU/VclWwEH9y9Jx8+6AJAgpEY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyLTruHMxiG6peyLKDrkUtTVZHyzGff+WtqXeq6JHxyXZNeB3kR
 x154tVwfBuKFopel394dREjn4ZvEa1P/GRfqimTz1JCYSXOjqN3/uQG6nN30phxkfCrMN26Y0aw
 CHNa2U8InH7W6ZXZZZ13ijx2ctqF3A3sAYvrVPmyxE+KUhq7668bNtxBjtkmApQQIKb3rTJs=
X-Gm-Gg: AfdE7clNG1kWcuTgq9Yka2wubZDAB4wK4j2yQ89fTs6uqd825EyUxjWudlamA/cnVL5
 HUTwfEccRCWT2XdyJg4uo4F3k1snEwIcKVlLNbOw9oznJQzvxrSCMEg8yooF+UObgXftVu2Uejf
 gpiDx2xiJ6mrcPS10sM+mBpuqgjzBFsBP6S9YyOSe00WmgCkhxwWEYvW5wvfYCWEPjhPpZHALxC
 /XOrSdCLWOzOJ6Cu9pK3oB2Pof9unz4Uuck4SMVcvHvtgwpk1BXkThMx3ezOhsZQWoNVmS22DYp
 iUPfXCgxgZixStqqBB1q12epiwxVhhaC1NNlYmZ47Dl/2cLnrx9K3TWWHVXinpRFnPaA6eBtETk
 zFTxtT2iXDPKTgvtt/myOGMKXqzOAjSpef/g5l4T8ShEkcKrMR1HlNiAfui9HIdx1essc/OOzbS
 LaVHjEtEmskZRKuj9K34JXddazV0QT8DvlIiIdQNFKjhEC6C78tQgIeNMqlXs4Di/yTdMY1Xwzz
 Htvsw==
X-Received: by 2002:a05:620a:3724:b0:915:351b:3ae5 with SMTP id
 af79cd13be357-9278086ef99mr383542185a.41.1782292012624; 
 Wed, 24 Jun 2026 02:06:52 -0700 (PDT)
X-Received: by 2002:a05:620a:3724:b0:915:351b:3ae5 with SMTP id
 af79cd13be357-9278086ef99mr383536285a.41.1782292012117; 
 Wed, 24 Jun 2026 02:06:52 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec?
 (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl.
 [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-697f3ac5df0sm840035a12.1.2026.06.24.02.06.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Jun 2026 02:06:51 -0700 (PDT)
Message-ID: <7c91795c-f8bf-429b-b588-f7e96d97b1a1@oss.qualcomm.com>
Date: Wed, 24 Jun 2026 11:06:49 +0200
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
 <4b09bd91-9a08-407a-9b01-216dd4d7aae0@oss.qualcomm.com>
 <20260624-ultramarine-beetle-of-vastness-acd51e@houat>
Content-Language: en-US, nl
In-Reply-To: <20260624-ultramarine-beetle-of-vastness-acd51e@houat>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI0MDA3NCBTYWx0ZWRfX28pd0hi7Qwkk
 m7i0RW97ZNQwavcBDjj47LM8GKx5a6aaiXQphE9SLm1ldE4xdvit42DypnVNyaCrdxlDhoSVV+J
 0dagudT8wG6KF0Dpde5YDIQlVST2acSB6QCZRt/ylmH+rpTRHnMBwIbUZ2VAtwY7eQWLNTkT4DG
 wcmkdoXLH5yqZ+UPlczvKwoVyZR/CHHNE8RZpnDg+iWbisuninV5eoMJQEDS2qgKPtYrTdgR1At
 IY8in+f+sQxI6qp8k9FPUZxuYhoYws10BehK6qGRHT3gAry85sbvRAZafm1zmVYqHIi8fDAI9Vu
 IchTigKhYMdbraXY8HCwmW/8VA7vwrX7PXfZO31rkNFyL133PmCxxnjVIVzNQlK0l5YuWjn1f/g
 vU1VK6zNhdlecD8vvkxFQswLRmphZDzEe+VGngDC3KvTERZgOoCeFwIEbyZuFuI1o7yFOArV68n
 C5dc6UVMWwePrha3fRQ==
X-Proofpoint-GUID: 667InqOKFuaYUei64zJHvIdt3Kbs1hYP
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI0MDA3NCBTYWx0ZWRfXy2EpMoZpWPJa
 UIwHCRuSLXcP8t2lURFzXsRty9ZHOpMwn4ZaxQFHdkGykfzb0Vk9vj3vzTfTyH84NpJ1kIKOd8v
 djy+pykyhkTmo1tjPL46BUR+PMRBAq4=
X-Proofpoint-ORIG-GUID: 667InqOKFuaYUei64zJHvIdt3Kbs1hYP
X-Authority-Analysis: v=2.4 cv=UphT8ewB c=1 sm=1 tr=0 ts=6a3b9e2d cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=NEAV23lmAAAA:8
 a=Wpe-4Z9t6Aeetc6M1akA:9 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-24_02,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 adultscore=0
 impostorscore=0 phishscore=0 spamscore=0 suspectscore=0 malwarescore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606240074
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

On 24-Jun-26 10:53, Maxime Ripard wrote:
> On Thu, May 28, 2026 at 03:02:09PM +0200, Hans de Goede wrote:
>> On 28-May-26 2:08 PM, Maxime Ripard wrote:
>>> On Thu, May 28, 2026 at 12:12:10PM +0200, Hans de Goede wrote:
>>>> Hi Brian,
>>>>
>>>> On 28-May-26 1:03 AM, Brian Masney wrote:
>>>>> Hi Hans,
>>>>>
>>>>> On Wed, May 27, 2026 at 11:48:08AM +0200, Hans de Goede wrote:
>>>>>> 2) One option considered was detaching the simple-framebuffer driver later,
>>>>>>    after the real display driver has had a chance to claim the clocks. But
>>>>>>    this won't work in cases where the real display driver picks different
>>>>>>    parent clocks then the boot firmware did and needs to reparent clocks.
>>>>>
>>>>> Why won't that work in the case where different parent clocks are selected?
>>>>> I'll describe a scenario below.
>>>>>
>>>>>>
>>>>>>    Basically the goal is for things to behave as if the simple-framebuffer
>>>>>>    driver was not there at all, because that leaves the hw in the state
>>>>>>    the real display driver expects.
>>>>>
>>>>> I think the deferred unbinding could have some potential here where
>>>>> there is some kind of notification mechanism between simple-framebuffer
>>>>> and the real drm driver. So:
>>>>>
>>>>> - simple-framebuffer driver takes reference(s) to the clk(s).
>>>>>
>>>>> - real drm driver eventually loads, takes reference(s) to the necessary
>>>>>   clk(s).
>>>>>
>>>>> - real drm driver sends a notification to simple-framebuffer that it's
>>>>>   done, and has control.
>>>>>
>>>>> - simple-framebuffer can unbind and release its references to the clks.
>>>>>
>>>>> No clks will be shutdown prematurely in this scenario.
>>>>>
>>>>> If the real drm driver needs a different parent, then presumably things
>>>>> should be setup correctly, and simple-framebuffer can have the clocks
>>>>> shut down when it calls clk_disable_unprepare().
>>>>
>>>> If the real drm driver needs a different parent, then how does it
>>>> do the reparenting while the simple-framebuffer driver is holding
>>>> a reference to the clock ?  In that case the clock might have
>>>> a protected_count of non 0 (depends on the core-clk flags) and
>>>> reparenting won't work.
>>>
>>> The only case where it should reparent you listed was that you might
>>> need to pick up a different resolution. However, that can only be
>>> enforced by an ioctl or a client.
>>>
>>> simplefb/drm is removed in msm_drm_kms_init. The device is published
>>> drm_dev_register called right after msm_drm_kms_init, and the clients
>>> are registered in msm_drm_kms_post_init, called after drm_dev_register.
>>>
>>> There's no way in the current msm architecture to have a modeset happen
>>> while the simpledrm driver is still active.
>>
>> Ok, new plan, please let me know what you think about this:
>>
>> 1. Add a new "disable" callback argument to
>> devm_aperture_acquire_for_platform_device() and store this in
>> struct aperture_range
>>
>> 2. Add a new aperture_disable_conflicting_devices() which
>> calls the disable callback for matching devices.
>>
>> 3. Have the simple[fd|drm] drivers implement a disable callback
>> which unregisters the drm dev and releases any claims on the
>> aperture mem-region, while keeping clks, regulators, etc.
>> enabled. And have them check if disable was called on remove()
>> and if not do the disable() things on remove(0
>>
>> 4. Have msm call aperture_disable_conflicting_devices() where it
>> now call aperture_remove_conflicting_devices() and call
>> aperture_remove_conflicting_devices() at the point where it has
>> claimed any clks it needs.
>>
>> Does this sound like something which would be acceptable ?
> 
> Generally speaking, yes, but I'd also like to understand what you're
> trying to fix exactly, because I don't see how it can be what you hinted
> at before.

The basic problem is that on handover from simpledrm -> msm
the clocks get turned off, without fully shutting down the
display pipeline first (since simpledrm does not know how).

Then when msm later tries to re-enable things, the hw is
in a confused state and we hit this error:

[    2.980181] disp_cc_mdss_dptx3_pixel0_clk_src: rcg didn't update its configuration.
[    2.980272] WARNING: drivers/clk/qcom/clk-rcg2.c:136 at update_config+0xdc/0x100

So we need a way to handover things to the msm driver
without anything getting disabled by simpledrm in an
uncontrolled (not following proper pwr-down seq) manner.

The idea behind the 2 step simpledrm removal process is
that on the first step drm_dev_unplug() gets called for
the simpledrm device and any struct resource claim on
the aperture gets released. While keeping all the clocks,
regulators, etc. claims.

Then msm can take things over and call the second step
when it has taken everything over. On the second step
simpeldrm will release its enable count ref on the clocks,
etc. in question.

In the mean time I've actually already prototyped this, see:

https://github.com/jwrdegoede/linux-sunxi/commits/main

Note this is my main wip branch with all kinda stuff
in there and this gets forced pushes regularly.

Regards,

Hans


p.s.

I've not posted this upstream yet because unlike
the __clk_disable_unprepare_counts_only() approach this
does not work atm, because it seems the msm driver only
claims some DP related clocks on the first modeset
from userspace rather then during probe().

This msm issue is something which we need to fix regardless,
also for when the clock framework gets moved to using
sync-state handling for turning off unused clocks, since
any clocks consumed by the msm dt-node will then also get
turned off directly after probe().


