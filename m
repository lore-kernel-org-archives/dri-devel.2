Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D284910854B8
	for <dri-devel@archiver.kernel.org>; Sun, 15 Mar 2026 01:10:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B44910E46E;
	Sun, 15 Mar 2026 01:10:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=packett.cool header.i=@packett.cool header.b="Yhg6erNA";
	dkim-atps=neutral
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com
 [95.215.58.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 109A610E46E
 for <dri-devel@lists.freedesktop.org>; Sun, 15 Mar 2026 01:10:55 +0000 (UTC)
Message-ID: <a6190a6c-60ae-4d24-b396-089f3b42973f@packett.cool>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=packett.cool;
 s=key1; t=1773537043;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+M2XqJARgeruA5d7QVU8YedDhdC+J9lANvOsOGmSaa8=;
 b=Yhg6erNAzKMdqlQPS1Nb0IKtxcaawk5s6Sk5aNdYCAb9qp240eoN0ifGv/odNOgnbs1K0n
 kvjFuDRAP399aafLtSjZwNfx5Qy6ld/1uaGC6hfQrWYolhSKkPWnrnKgNnTuq/+hpAISx5
 OKIq0f4UFQzX3VU+EMBiCWuI67r0vXiGu6XPstSgsJ8Lv5XirrtGxxt4su4EiIuVgTnzTO
 BkGvmmWcZPNhFd+6g/aRSjmccBOZwdWNHK8YiTSyUPhgNnJgkHsROBzHyo3dWzW8JOXEdP
 f51Ni8RZToT0AAcGzsP2c9EX0efujnjKFckPv5lgmLW36KtEk5NQkb+zScKC5Q==
Date: Sat, 14 Mar 2026 22:10:26 -0300
MIME-Version: 1.0
Subject: Re: [PATCH v5 00/10] drm/msm/dp: Drop the HPD state machine
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Val Packett <val@packett.cool>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Kuogee Hsieh <quic_khsieh@quicinc.com>,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260314-hpd-refactor-v5-0-0c8450737d64@oss.qualcomm.com>
 <9c4dad2c-25bd-47d2-bc40-9b551d023615@packett.cool>
Content-Language: en-US
In-Reply-To: <9c4dad2c-25bd-47d2-bc40-9b551d023615@packett.cool>
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


On 3/14/26 9:51 PM, Val Packett wrote:
>
> On 3/13/26 10:09 PM, Dmitry Baryshkov wrote:
>> Currently, all HPD interrupt handling must go through the HPD state
>> machine.
>>
>> This has caused many issues where the DRM framework assumes that DP is
>> in one state while the state machine is stuck in another state.
>>
>> As discussed here [1], this series:
>>
>> - Removes the state machine
>> - Moves link training to atomic_enable()
>> - Changes the detect() behavior to return true if a display is 
>> physically
>>    plugged in (as opposed to if the DP link is ready).
>> - Remove event queue and move internal HPD handling to hpd_notify()
>>
>> To correctly detect the displays which are plugged on boot on the boards
>> which use dp-connector devices, this series depends on [2]. USB-C and
>> eDP panels are handled natively.
>>
>> [1] 
>> https://patchwork.freedesktop.org/patch/656312/?series=142010&rev=2#comment_1201738
>> [2] 
>> https://lore.kernel.org/all/20260314-dp-connector-hpd-v1-0-786044cedc17@oss.qualcomm.com/
>
> Unfortunately this currently seems to mostly break link training with 
> USB-C, on x1e80100-dell-latitude-7455:
>
> [  102.190083] [drm:msm_dp_ctrl_link_train_1_2 [msm]] *ERROR* link 
> training #2 on phy 1 failed. ret=-110
> [  102.192846] [drm:msm_dp_ctrl_setup_main_link [msm]] *ERROR* link 
> training of LTTPR(s) failed. ret=-110
> [  102.211095] [drm:msm_dp_bridge_atomic_enable [msm]] *ERROR* Failed 
> link training (rc=-104)
> [  102.211164] [drm:msm_dp_aux_isr [msm]] *ERROR* Unexpected DP AUX 
> IRQ 0x01000000 when not busy
> [  102.247168] [drm:msm_dp_ctrl_link_train_1_2 [msm]] *ERROR* link 
> training #2 on phy 1 failed. ret=-110
> [  102.252859] [drm:msm_dp_ctrl_setup_main_link [msm]] *ERROR* link 
> training of LTTPR(s) failed. ret=-110
>
> [..]

Actually looks like that might've been due to having applied the [2] 
dp-connector series from above.

Removed it and rebooted, now plugging and unplugging multiple times 
between the 2 ports works fine.

Except unplug is still not reliable, the "ghost" monitor often remains 
after unplugging.

Almost nothing is logged to dmesg, literally I've only seen this line once:
[drm:msm_dp_panel_read_sink_caps [msm]] *ERROR* panel edid read failed

But I have unplugged the monitor now and I still see:

crtc[108]: crtc-1
         enable=1
         active=1
         self_refresh_active=0
         planes_changed=1
         mode_changed=0
         active_changed=0
         connectors_changed=0
         color_mgmt_changed=0
         plane_mask=2
         connector_mask=2
         encoder_mask=2
         mode: "3840x2560": 60 631750 3840 3888 3920 4000 2560 2563 2573 
2633 0x48 0x9
         lm[0]=2
         ctl[0]=1
         lm[1]=3
         ctl[1]=1
connector[38]: DP-2
         crtc=crtc-1
         [..]

and the compositor thinks it's still present, I can move the mouse to 
where the screen was etc.


~val

