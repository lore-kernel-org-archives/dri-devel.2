Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31C4910854C9
	for <dri-devel@archiver.kernel.org>; Wed, 18 Mar 2026 01:59:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 02F7D10E5D4;
	Wed, 18 Mar 2026 01:59:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=packett.cool header.i=@packett.cool header.b="stt9YDRu";
	dkim-atps=neutral
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com
 [95.215.58.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA44510E3B8
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 01:59:07 +0000 (UTC)
Message-ID: <aacb16c4-e9ad-4455-9636-740464c3273d@packett.cool>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=packett.cool;
 s=key1; t=1773799136;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g2SvxubjTMbqqciMbziqIiQ2xfH3+6n9bjV5XXagZwI=;
 b=stt9YDRu9sZ/tnpYW1DfoMeG0rtqzqyOh7Glq+7bYo7dHcEKNOOfHe2hB+AZ659O9dMIMI
 GDFRZCZ1eIaMB0bf1yRfJOpkUjRWcWehCwi968j28AfggeIIwwkBaomKvhw73++mHtEatY
 Xk0/XVSXGGOyE14pLb1e0+tU1fpghmpaV1IhXaN6nrrQ3GbmKH+doWf7desEoBMEw8CD4C
 RvFzJYeC9Vq/B/5KLPnoDwFwtBo2b7lY73/IjZnkEtKU3nK7uL1YJSgmPu+5OEd9MqSVSC
 7zDvJOyUa+89aTg9K9XZs2ze5B9jWUgvWyap4fKAqDtyR8R9r4djPXHLbB+IJw==
Date: Tue, 17 Mar 2026 22:58:44 -0300
MIME-Version: 1.0
Subject: Re: [PATCH v5 00/10] drm/msm/dp: Drop the HPD state machine
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>, Jessica Zhang <jesszhan0024@gmail.com>,
 Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Kuogee Hsieh <quic_khsieh@quicinc.com>,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260314-hpd-refactor-v5-0-0c8450737d64@oss.qualcomm.com>
 <9c4dad2c-25bd-47d2-bc40-9b551d023615@packett.cool>
 <a6190a6c-60ae-4d24-b396-089f3b42973f@packett.cool>
 <itszs6eu7l2zix4stdiokftgxjpqlfukbqbdg4u3sestln6pgl@yq3wud26vi25>
 <38e87937-194f-43ca-ab27-a3a9cf7267d4@packett.cool>
 <qr4anmqwa5imhx2gsftggqitasqdhr4bpqimn3e74zj5csgtvy@ozbsty6o33vg>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Val Packett <val@packett.cool>
In-Reply-To: <qr4anmqwa5imhx2gsftggqitasqdhr4bpqimn3e74zj5csgtvy@ozbsty6o33vg>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
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


On 3/17/26 10:03 PM, Dmitry Baryshkov wrote:
> On Tue, Mar 17, 2026 at 08:15:54PM -0300, Val Packett wrote:
>> On 3/16/26 12:23 AM, Dmitry Baryshkov wrote:
>>> On Sat, Mar 14, 2026 at 10:10:26PM -0300, Val Packett wrote:
>>>> On 3/14/26 9:51 PM, Val Packett wrote:
>>>>> On 3/13/26 10:09 PM, Dmitry Baryshkov wrote:
>>>>>> Currently, all HPD interrupt handling must go through the HPD state
>>>>>> machine.
>>>>>>
>>>>>> This has caused many issues where the DRM framework assumes that DP is
>>>>>> in one state while the state machine is stuck in another state.
>>>>>>
>>>>>> As discussed here [1], this series:
>>>>>>
>>>>>> - Removes the state machine
>>>>>> - Moves link training to atomic_enable()
>>>>>> - Changes the detect() behavior to return true if a display is
>>>>>> physically
>>>>>>      plugged in (as opposed to if the DP link is ready).
>>>>>> - Remove event queue and move internal HPD handling to hpd_notify()
>>>>>>
>>>>>> To correctly detect the displays which are plugged on boot on the boards
>>>>>> which use dp-connector devices, this series depends on [2]. USB-C and
>>>>>> eDP panels are handled natively.
>>>>>>
>>>>>> [1] https://patchwork.freedesktop.org/patch/656312/?series=142010&rev=2#comment_1201738
>>>>>> [2] https://lore.kernel.org/all/20260314-dp-connector-hpd-v1-0-786044cedc17@oss.qualcomm.com/
>>>>> Unfortunately this currently seems to mostly break link training with
>>>>> USB-C, on x1e80100-dell-latitude-7455:
>>>>>
>>>>> [  102.190083] [drm:msm_dp_ctrl_link_train_1_2 [msm]] *ERROR* link
>>>>> training #2 on phy 1 failed. ret=-110
>>>>> [  102.192846] [drm:msm_dp_ctrl_setup_main_link [msm]] *ERROR* link
>>>>> training of LTTPR(s) failed. ret=-110
>>>>> [  102.211095] [drm:msm_dp_bridge_atomic_enable [msm]] *ERROR* Failed
>>>>> link training (rc=-104)
>>>>> [  102.211164] [drm:msm_dp_aux_isr [msm]] *ERROR* Unexpected DP AUX IRQ
>>>>> 0x01000000 when not busy
>>>>> [  102.247168] [drm:msm_dp_ctrl_link_train_1_2 [msm]] *ERROR* link
>>>>> training #2 on phy 1 failed. ret=-110
>>>>> [  102.252859] [drm:msm_dp_ctrl_setup_main_link [msm]] *ERROR* link
>>>>> training of LTTPR(s) failed. ret=-110
>>>>>
>>>>> [..]
>>>> Actually looks like that might've been due to having applied the [2]
>>>> dp-connector series from above.
>>> Interesting. The series only affects dp-connector. It can't affect
>>> pmic-glink usecase.
>>>
>>>> Removed it and rebooted, now plugging and unplugging multiple times between
>>>> the 2 ports works fine.
>>>>
>>>> Except unplug is still not reliable, the "ghost" monitor often remains after
>>>> unplugging.
>>> Does the patch at [3] fix the issue?
>>>
>>> [3] https://lore.kernel.org/linux-arm-msm/177362655076.7429.3868048981197120360.b4-ty@kernel.org/
>> Yes!
>>
>> Overall works better than ever now, looks like I can unplug the cable with
>> the laptop closed and then open it and it's all fine, and even play with
>> dual-role / gadget mode USB and plug the alt-mode/dock cable back in and it
>> doesn't crash.
> Tested-by?

Yeah, since I guess the link training is kinda orthogonal to this, sure!

Tested-by: Val Packett <val@packett.cool> # x1e80100-dell-latitude-7455

>> Still, rare link training failures can happen, e.g.:
> Thanks!
>
> The link training is one of the items that I want to check next.
>
