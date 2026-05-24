Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F11A3CD5BB1
	for <dri-devel@archiver.kernel.org>; Sun, 24 May 2026 21:32:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5170310E337;
	Sun, 24 May 2026 21:32:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=packett.cool header.i=@packett.cool header.b="aHUkg6Qj";
	dkim-atps=neutral
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com
 [91.218.175.183])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 944C710E337
 for <dri-devel@lists.freedesktop.org>; Sun, 24 May 2026 21:32:40 +0000 (UTC)
Message-ID: <ab26ea90-5f28-4582-8f82-3925471d917f@packett.cool>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=packett.cool;
 s=key1; t=1779658348;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Zt5RINp/uhenX2tIAWFcoDiZdc5YR75o2ZI4vamwopM=;
 b=aHUkg6QjBBpY4qCrK6aP1U4dLQHIYBJXCQNXfRDk51+Oa635VMYkA/Jd+kEm+xvm5vXhjn
 sZMBPzLPVrEdwF+VQ6g/tzt4elO+h7Tdz3TQtP+QJVH5/O4jaQu/5l3r3VQZCzAPGgR/Is
 +j520yplIVv/Fkp9Z/Dp0uwIW06yHCTHpc/K1nVJ8wHHzVzTk78u/GoaEeNsqb8OWpK5ZW
 nZ2h6g5e+meRSy9/hfeg+QCqOqQTG1C9mTrpUDukNHq/9poMA1twK/ZQUrtxQl1cIEOQfL
 xpg61jZ0Lm7WrjasBzFL3bifVY26kfQLjDpz/sqi1lddC/xtivo8Vpe6b9qxzA==
Date: Sun, 24 May 2026 18:32:18 -0300
MIME-Version: 1.0
Subject: Re: [PATCH v6 00/10] drm/msm/dp: Drop the HPD state machine
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Kuogee Hsieh <quic_khsieh@quicinc.com>,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>
References: <20260524-hpd-refactor-v6-0-cf3ab488dd7b@oss.qualcomm.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Val Packett <val@packett.cool>
In-Reply-To: <20260524-hpd-refactor-v6-0-cf3ab488dd7b@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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


On 5/24/26 7:33 AM, Dmitry Baryshkov wrote:
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
>
> ---
> Changes in v6:
> - Corrected mismatch between Jessica's From and SoB emails
> - Corrected documentation and fixed style comments for
>    msm_dp_bridge_detect() (Bjorn, Konrad)
> - Changed msm_dp_bridge_atomic_enable() to bail out earlier in case of
>    link training failure (Konrad)
> - Corrected commit message for the link training commit to stop
>    mentioning event-related changes (Konrad)
> - Added kerneldoc to msm_dp_display_host_phy_init(), describing return
>    value (Konrad)
> - Switched to guard() instead of raw mutex_lock() (Konrad)
> - Link to v5: https://lore.kernel.org/r/20260314-hpd-refactor-v5-0-0c8450737d64@oss.qualcomm.com

Looks like v5 is already in linux-next.. merged in:

https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=4d28d7f4c69895437aeb0337d5e8d3dc2a5395cf

~val

