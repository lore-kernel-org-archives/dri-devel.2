Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0A1310854B6
	for <dri-devel@archiver.kernel.org>; Sun, 15 Mar 2026 00:51:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 297FA10E157;
	Sun, 15 Mar 2026 00:51:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=packett.cool header.i=@packett.cool header.b="DRvR4QUU";
	dkim-atps=neutral
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com
 [95.215.58.189])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 940DC10E157
 for <dri-devel@lists.freedesktop.org>; Sun, 15 Mar 2026 00:51:17 +0000 (UTC)
Message-ID: <9c4dad2c-25bd-47d2-bc40-9b551d023615@packett.cool>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=packett.cool;
 s=key1; t=1773535875;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pZtyxbHkiRBLwkPVgVeFtZ6s5sbnrf0HLktsBRDQ70o=;
 b=DRvR4QUUdqxmEinGhXNRb4gRM7g8mkFIpCHdTiH6PJE7H5JhibRgd4pS88h+hZv59j7Ex9
 76KhGcl5ZJR+X8ifbpSeb7q7+4mP+da/nIYk3R5rhRn1y1v9Xm8FJXmrMNQ2TzW2PcbkO6
 8XzVMUvK1nur0gdbg5XHAtwD8Qbzelbc0vIGw70deJxpjaQTE1Oal9Ehz3HBy+XlyedRcf
 nRVzZs8RN+56vj4D7Unllkyts2uMchL+tYWHYqCvpgaXXtvjih1K5x87r6Qt1KyIVN59R/
 kK/WxLHJssPmgb4vtvzRJQoPl7p5VZcUmtcAReEfU3E6Roa4mxem0VJoRZ1Xag==
Date: Sat, 14 Mar 2026 21:51:02 -0300
MIME-Version: 1.0
Subject: Re: [PATCH v5 00/10] drm/msm/dp: Drop the HPD state machine
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
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Val Packett <val@packett.cool>
In-Reply-To: <20260314-hpd-refactor-v5-0-0c8450737d64@oss.qualcomm.com>
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


On 3/13/26 10:09 PM, Dmitry Baryshkov wrote:
> Currently, all HPD interrupt handling must go through the HPD state
> machine.
>
> This has caused many issues where the DRM framework assumes that DP is
> in one state while the state machine is stuck in another state.
>
> As discussed here [1], this series:
>
> - Removes the state machine
> - Moves link training to atomic_enable()
> - Changes the detect() behavior to return true if a display is physically
>    plugged in (as opposed to if the DP link is ready).
> - Remove event queue and move internal HPD handling to hpd_notify()
>
> To correctly detect the displays which are plugged on boot on the boards
> which use dp-connector devices, this series depends on [2]. USB-C and
> eDP panels are handled natively.
>
> [1] https://patchwork.freedesktop.org/patch/656312/?series=142010&rev=2#comment_1201738
> [2] https://lore.kernel.org/all/20260314-dp-connector-hpd-v1-0-786044cedc17@oss.qualcomm.com/

Unfortunately this currently seems to mostly break link training with 
USB-C, on x1e80100-dell-latitude-7455:

[  102.190083] [drm:msm_dp_ctrl_link_train_1_2 [msm]] *ERROR* link 
training #2 on phy 1 failed. ret=-110
[  102.192846] [drm:msm_dp_ctrl_setup_main_link [msm]] *ERROR* link 
training of LTTPR(s) failed. ret=-110
[  102.211095] [drm:msm_dp_bridge_atomic_enable [msm]] *ERROR* Failed 
link training (rc=-104)
[  102.211164] [drm:msm_dp_aux_isr [msm]] *ERROR* Unexpected DP AUX IRQ 
0x01000000 when not busy
[  102.247168] [drm:msm_dp_ctrl_link_train_1_2 [msm]] *ERROR* link 
training #2 on phy 1 failed. ret=-110
[  102.252859] [drm:msm_dp_ctrl_setup_main_link [msm]] *ERROR* link 
training of LTTPR(s) failed. ret=-110


Once I did get it to connect on one of the ports, but then on unplug it 
didn't detect the unplug properly and continued trying to use the link:

[ 1418.418954] disp_cc_mdss_dptx1_link_clk status stuck at 'off'
<trace cut>
[ 1418.420950] Failed to enable clk 'ctrl_link': -16
[ 1418.420959] [drm:msm_dp_ctrl_enable_mainlink_clocks [msm]] *ERROR* 
Unable to start link clocks. ret=-16
[ 1418.421058] [drm:msm_dp_bridge_atomic_enable [msm]] *ERROR* Failed 
link training (rc=-16)
<trace cut>
[ 1418.423228] Failed to enable clk 'ctrl_link': -16
[ 1418.423234] [drm:msm_dp_ctrl_enable_mainlink_clocks [msm]] *ERROR* 
Unable to start link clocks. ret=-16
[ 1418.423325] [drm:msm_dp_ctrl_on_stream [msm]] *ERROR* Failed to start 
link clocks. ret=-16
[ 1418.476234] [drm:dpu_encoder_phys_vid_wait_for_commit_done:543] [dpu 
error]vblank timeout: 808208c0
[ 1418.476272] [drm:dpu_kms_wait_for_commit_done:527] [dpu error]wait 
for commit done returned -110
[ 1418.509204] [drm:dpu_encoder_frame_done_timeout:2731] [dpu 
error]enc37 frame done timeout
[ 1419.163337] [drm:dpu_encoder_phys_vid_wait_for_commit_done:543] [dpu 
error]vblank timeout: 808208c0
[ 1419.163365] [drm:dpu_kms_wait_for_commit_done:527] [dpu error]wait 
for commit done returned -110

But after reboot, link training was failing on both ports..


Thanks,
~val

