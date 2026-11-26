Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E15D606A31E
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 08:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.a=rsa-sha256 header.s=default header.b=i/Zb7N+f
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A43210E234;
	Thu, 26 Nov 2026 08:07:03 +0000 (UTC)
Received: from mail-m1035.netease.com (mail-m1035.netease.com [154.81.10.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 285A810E344
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 08:06:55 +0000 (UTC)
Received: from [172.16.12.74] (unknown [61.154.14.86])
 by smtp.qiye.163.com (Hmail) with ESMTP id 56166db4a;
 Thu, 26 Nov 2026 16:06:52 +0800 (GMT+08:00)
Message-ID: <53afffed-4229-4414-91d2-e75e35ac94f9@rock-chips.com>
Date: Thu, 26 Nov 2026 16:06:52 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 19/20] drm/bridge: analogix_dp: Handle HPD notification
 from downstream bridge
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org, =?UTF-8?Q?Heiko_St=C3=BCbner?=
 <heiko@sntech.de>
References: <20261125112141.1434903-1-damon.ding@rock-chips.com>
 <20261125112141.1434903-20-damon.ding@rock-chips.com>
 <sashiko-outbox-233284@kernel.org>
Content-Language: en-US
From: Damon Ding <damon.ding@rock-chips.com>
In-Reply-To: <sashiko-outbox-233284@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0aa216e4a30303a8kunmf83a8f877f83b9
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaTxgYVktMSRoeTBhKGkwdSVYVFA
 kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUJCSU
 5KVUpLS1VKQktCWQY+
DKIM-Signature: a=rsa-sha256;
 b=i/Zb7N+f/N79FNjRePQWt4oeqpo6bnBzgfo8cbwetlcqxcGzGzQHJPiSPUJClFa9+QqWveZODbFjSon2xAPavUZzjoSmOgr2k5/xTaTlt+FkMk+B5uXXR0MXL2DmK0WJfRr11HrSRGD2arZnLy1cJFsR2lR+w//5We/adXN3uhE=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=dZpNjkTiwffgyKVa2xxgH8TcimyQVQdtjc9YVg0y/FU=;
 h=date:mime-version:subject:message-id:from;
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/25/2026 7:48 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 4 potential
> issues to consider:
> - [High] drm/bridge: analogix_dp: redundant AUX probes in detect and
>    analogix_dp_bridge_notify()
> - [Medium] drm/bridge: analogix_dp: bypassed HPD check and static poll
>    in analogix_dp_get_plug_in_status()
> - [Medium] drm/bridge: analogix_dp: unsynchronized concurrent updates to
>    dp->connection_notified
> - [Medium] drm/bridge: analogix_dp: late hpd_notify_mode init leaves HPD
>    IRQ enabled on suspend
> --
> 
> commit 2e833b8add367c84281267efb779f7ba405e5a0d
> Author: Damon Ding <damon.ding@rock-chips.com>
> 
> drm/bridge: analogix_dp: Handle HPD notification from downstream bridge
> 
> This commit adds an hpd_notify_mode for pipelines where a downstream bridge
> provides HPD notifications without detection, muting native HPD interrupts
> and probing the sink over AUX to cache and report connection status.
> 
> Link: https://lore.kernel.org/all/5609825.iZASKD2KPV@diego/
> 
On using the DPCD probe in v7 instead of trusting the reported status:
this follows other drivers using this notify mechanism, e.g. msm_dp
reads the AUX link status in .hpd_notify rather than the passed
status, and the real sink state is what the controller needs.

Finding 1: will be fixed in v8. analogix_dp_bridge_detect() will
return the cached dp->connection_notified instead of probing the
sink, so the probe only happens once in analogix_dp_bridge_notify().

Finding 2: will be fixed in v8. analogix_dp_probe_sink() will be
used in analogix_dpaux_wait_hpd_asserted() to make sure the sink
state.

Finding 3: will be fixed in v8. The detect path will not call
analogix_dp_probe_sink() anymore and will use the cached result
instead, so there is no concurrent update.

Finding 4: will be fixed in v8 by the "Manage pm runtime and IRQ for
native HPD pin detection" patch, which drops all the IRQ operations
from analogix_dp_suspend() and analogix_dp_resume().

The v8 will come soon.

Best regards,
Damon

