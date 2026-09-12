Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB701C88E53
	for <dri-devel@archiver.kernel.org>; Sat, 12 Sep 2026 22:48:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 09F5310E027;
	Sat, 12 Sep 2026 22:48:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gahingwoo.com header.i=@gahingwoo.com header.b="agLK272u";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="eEsWtaBy";
	dkim-atps=neutral
Received: from flow-b7-smtp.messagingengine.com
 (flow-b7-smtp.messagingengine.com [202.12.124.142])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED79310E027
 for <dri-devel@lists.freedesktop.org>; Sat, 12 Sep 2026 22:48:51 +0000 (UTC)
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailflow.stl.internal (Postfix) with ESMTP id 418E1130018E;
 Sat, 12 Sep 2026 18:48:51 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-06.internal (MEProxy); Sat, 12 Sep 2026 18:48:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm2;
 t=1789253331; x=1789260531; bh=u5dfeX5ow+93ybPmJekOrvP+a0/Wlwh9
 Ypost/1YCcY=; b=agLK272u15g39JFhQoLzVwxfh7hNTca2Jsf0SQH9DDi+2sDa
 A7GR1C9Yq7I5n5KcLQy+yeqVo7FLaqhZ+KWG/LTpCCKNJKPnqJ6HnO5HaVeguLBf
 fwXrtqp8HDRs2XkyAFWJczBwvQg6Cl286SLMJX2jNe5iEe0PNucby3nh+vQZQVfG
 0lAyFzIcaXCpeI6Fa+g+W051dEJsSXjfRBUsJvk5GwtDLtszZsK8fiMxhcmLPnQB
 /caMUoxiORz4rpd9WgcdAaisd8NzDvg9/X4Dok0Gcph+TyBSPGnffNyVRdFUZRDd
 I1Cq44+H3nzyvmsbElotDXyALW6wLilcgFfhkg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1789253331; x=
 1789260531; bh=u5dfeX5ow+93ybPmJekOrvP+a0/Wlwh9Ypost/1YCcY=; b=e
 EsWtaBywYtxbrjQSmAaK342Gxyd0APPuo++9TusNa2J6cO0lw2CcTvdZLwc7v8AN
 mH0okdV5ZvSAUk0jZVxkHhbOg19DZiab5rieUs+dckNepRmLXIjWoIuVsgYFfSva
 QiQp8rAeSpxg4/LgiqJWZH/kc0/yNvbRXf/iSKaaDQbpocnu6nOnZaIw1GKFonll
 5/NzyBwPfWXRa92e/4R4IsnPZscHtZoPSdq4L5F7tLhKPUywQ4E2TgXQFVD3K9bC
 XxU7BvEp/+NwPhCkohwJGSryanuyKtABZ+ut4kh9PvF2Mb+qlrW/ycyMobrFFuFI
 rRme0vLpL/cMspTCxWVaw==
X-ME-Sender: <xms:0talas4y0SNrVZWO6-a2AhqnnfIBHmGTAO6yjdNtbhxwcmhaMtibNw>
 <xme:0talavbfQDMOexWChY0alrGFh3u6zL8KvWOT4vQLfyc5NI0EeAkGkpJt01C1aDlTR
 nLOGeZ-ul6d9b0JUYNOWo-E8GTpMg6IC7sOf6ln8Z9ooUbUC1rz8g>
X-ME-Received: <xmr:0talargctBvFcM6LicM6Z6dBY9HlAG4u6Nd41eSqps7KGd1dB5kh0_cdvIvtw9uGS6PmXd8E2A>
X-ME-Proxy-Cause: dmFkZTGuEQ4GiepUBMpmZorBsrDrsMVPOCGJwSy8sC1qnSMiQmiw/q1wofBw1CfKly1PBi
 2GECeF44oC0yJEBJDzx1SeHpuKdA+L4Bf9sCHbBnMWN8EZ0SmTXFax4oDaau/Hg+1XsvA8
 rAmYQAG4FgvnvEjbQXvhKxV7fEV3M9rmo5xFybahW3pHuDWKlKXqDvpmpVxQmooTuh9i6k
 bCxU1Yaac5FMqrOPp/YZcT24w5CSoDOJ6gBcCHfZQxXtqj5bOcq+6CNWf5qmZxEkwWJF6f
 2wc5M28m1/yr3OU5i457h9Of/Mn+WrkpsEYlTMd5Prc4RWBUNeE+gkExSX6SO7f++x8iUw
 zANZthUsISzCoDnwWbs516OX7VjgqrlDJ4GZ9qWo3zjslybfaD3g1h92bJQhX/ylrU3QKH
 nOH8IFLvfxee8/9a3xA5PQvQB9ehSEj8hUR3RAdfel5bBdoAteKAZY5d4BeZVU6u6p5F5X
 waHX7VsVlX1PiiTilAr/eMv7xgBfvnj+LFfJE0C1h2xouD1K/OMPq3R4Bd/BU80q1M1X2P
 1hb6IfRHpPD60S2JSbQTMItQ2qN2oeLInOpCqmyHhhuULtM7Zav6Nyqe0YJRLGkVEQHcMe
 A97W3EVC0eb8hI6Bic1XV+RmnYtsQ5+N0Sb+JqRAD+DIqLJX4bWUAHZOt7ZA
X-ME-Proxy: <xmx:0talag_kGavK7xtMwGnb-wWR9MiCWSgCBWyzr2OpPjlKc6Eegkzwjw>
 <xmx:0talamrc-LJjDCvuURq-GqEZtKiyoLLzEhiLPV_Nbmyrx5kYB_DqRg>
 <xmx:0talaoVWJt_4Cu9f2J_Rut7ACATIysoThhVVG2CpGew_2yeZ9Z2QKw>
 <xmx:0talalCvbdb0yERFPKesUSiOxZ5zUUFWnE2iEuMKvRLWgzkGp0N6vw>
 <xmx:09alaqRzQdFgGHNTnZVLGUsKEcF6NyfGz_wI-wbBZLgwTDwcBkg2ze42>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 12 Sep 2026 18:48:49 -0400 (EDT)
From: Jiaxing Hu <gahing@gahingwoo.com>
To: royalnet026@gmail.com
Cc: tomeu@tomeuvizoso.net, linux-rockchip@lists.infradead.org,
 dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v12 03/14] accel/rocket: wait for a running IRQ handler
 before resetting a core
Date: Sun, 13 Sep 2026 10:48:44 +1200
Message-ID: <20260912224844.1614558-1-gahing@gahingwoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260912113717.6819-1-royalnet026@gmail.com>
References: <20260912065053.1519165-1-gahing@gahingwoo.com>
 <20260912065053.1519165-4-gahing@gahingwoo.com>
 <20260912113717.6819-1-royalnet026@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
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

Hi Igor,

Taken. The two paragraphs go.

3/14 loses the one beginning "Igor also ran a differential on RK3588"
and the one beginning "His own bound on it is the right one". Your
summary replaces them, as you wrote it:

  45 induced resets on 19 August, 102 on 25 August and 74 today,
  every reset recovered, no MMU faults, no lockdep report from rocket
  or the scheduler in the runs where lockdep was still armed, and of
  the 420 inferences scored, 384 matched the CPU reference within 1
  on all 48 output channels while 36 returned the all-0x80 buffer of
  a job the reset had cancelled.

You list "bounds and does not prove" among what stands, so I keep that
one sentence out of the removed text. Say if you would rather it went
with the rest.

Both Link: lines stay, with your message as a third.

One thing in your text to settle before it goes in: "74 today" has no
referent in a commit message. I would write the date, unless you would
rather phrase it yourself.

The tags:

  2/14  # RK3588, three cores
     -> # RK3588, three cores, induced reset, JOB_TIMEOUT_MS=2
  3/14  # RK3588, three cores, induced reset, differential base,
        JOB_TIMEOUT_MS=2
     -> # RK3588, three cores, induced reset, JOB_TIMEOUT_MS=2
  4/14  unchanged

All three then read the same, which is your point.

None of this touches what 3/14 rests on. The argument is the code
path: the wait is on desc->wait_for_threads rather than on a lock, so
it would have hung with no lockdep report. Your runs bounded that;
they never established it.

The 0x80 signature holds on RK3576 too, for the reason you name. A
fresh shmem BO is zeroed and teflon's readback adds 0x80, so an output
buffer nobody wrote comes back a uniform 128 and cannot be told from a
computed constant at the tflite level. That trap already cost us one
retraction of our own. Your kprobe run is the part neither of us had
before: two cancellations, two 0x80 files, matched to 2 ms against a
280 ms round period.

The uAPI question is Tomeu's. What I can say from here is that the
blind spot is not yours. PREP_BO cannot tell a cancelled job from one
that ran, so your protocol, mine and the mesa one all read the same
buffer, and none of us can close it from userspace.

v13 with these changes, and nothing else to 2/14, 3/14 or 4/14.

Thanks for going back through twenty runs of your own data. It would
have stood unchallenged in the commit message.

Jiaxing
