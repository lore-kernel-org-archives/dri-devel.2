Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4110C5AC82
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 10:47:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D2E7610E79E;
	Mon, 10 Aug 2026 10:47:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gahingwoo.com header.i=@gahingwoo.com header.b="s+Pgc/rn";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="CDA9tNiy";
	dkim-atps=neutral
Received: from flow-b5-smtp.messagingengine.com
 (flow-b5-smtp.messagingengine.com [202.12.124.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 094EB10E79E
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 10:47:38 +0000 (UTC)
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailflow.stl.internal (Postfix) with ESMTP id 4C830130024E;
 Mon, 10 Aug 2026 06:47:37 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-06.internal (MEProxy); Mon, 10 Aug 2026 06:47:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1786358857; x=
 1786362457; bh=HThYlIkGwdQDjZCN1XChIZNPsZZt1lbJWIT/W+aHcAw=; b=s
 +Pgc/rn7Ikkf3sJP5wsXVgYu3LRM5jUWJoV83lCemtt/0YBS2dhKGgLI9+OjtztJ
 zK4lKctYHy7xWS40VZyH3aQXscsiLj9a8s0GcEU/EeLxRepx9/EDoXP0R+WCnoD/
 dqe8GupM7PVPSwxFG6LqvAJNX9GMPBN8enCsEcuqQqN5fU5EIPmTr1aoRCnRUvdJ
 Zf4plyi+HrpAF65NVD9+X6ozkFKg+BbFaeEg5Xo9Un6jKHskKW7O0/637qH5Ykit
 rSt86lb0VqCPKOqxx6KMAp9PcBsQxKfcsPVGpJ5q8ia4pM4HjAqhDliDhGcAXdb8
 mHm5xBocwims4BglJTEbg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1786358857; x=1786362457; bh=H
 ThYlIkGwdQDjZCN1XChIZNPsZZt1lbJWIT/W+aHcAw=; b=CDA9tNiyR9KGLen46
 e3MeOv5ADrw/LE98uXEu367EsYTIapxMuU/xcytk/WvwUVMWmIlhWjKXtTdh3qLh
 6Zq9m/Mp4zVE5N4HmXTJbYQ31iGV/KQLisZeAPWwugAgBcYbzxJGQPOIeuPifUVc
 bnYa0/LMUigF9W8B2pWsuVi9gzya1lJy5F/B2z5qbnBU7a0r+aP7nnqeQRmUtSjP
 FMy2u42GqBJOBY/X6ksHXZZ8kg59CofRtmN00aU+ZVdfX7T/KkKrM3vIW353UR3R
 svjEDUncYqY2FBHB807kTyddFV06c8cjydAIevyAywNsr5TlxMWZ+u90WlmUq+O8
 oqeog==
X-ME-Sender: <xms:Sax5auyBED-RbQwYglPhlzSUvaZf60sGHCwZPZyu_n7f7zWOjoIZHg>
 <xme:Sax5agrYu25jOR1Me3dV51nARmuNZrDgeHBx6M_8_XFxrCLGVtGItV0x-XyWP4-vi
 H2_vY2yD0rvyl9qiEbkWPMtjaxehf5qQQAxjLJua7Ux0W2JaoVMM5s>
X-ME-Received: <xmr:Sax5askZPDwd8tnu1waR5TKgx-1ax8Q6DwI11M7SgPAQZ_mJUc5YlVzUE1AwosGaOwDM12iIAg>
X-ME-Proxy-Cause: dmFkZTGo3YHa5UvIUA3KMVpnWV+rhRTws4uKbckz7pR5ikg2n5/c5eYVs9tatMTHrYm86X
 FSGuOd0UfKeCG5u8cS/0ATovadYV0dloHbVuKOWKSfZB88s4PYZGP9luXZM+jrb97oEJTt
 RjRxeBSdKRaUq1Cbf0AX2U2+s5aPebsu3iqtNBNadOPFf19HGL/wn0eF7sL6wksW58CMqX
 BLeBRAONs2p7XTfHF1hunFp6DfL3Jqtn+kA10ruhL1u9ahvxehz1XqMb+CmuMSFYCXSNVz
 GAkqdFh0yeYsHlymk60Q2nG1topr5bWJdMpOf6oG7iCk9bBIEsLY0ig7J/2u0JJQZKmOtc
 Em4dYjC/7GCMA2gZu1ND9atVNQ2ELgVarBLlzipaJecf8whQLYDAQsaasD5XDIICH0L1gs
 2ksjL01O7hDt6emZ9dI+RU9zYzG/R21LTTkWS/8LpoLcTJVAaGZMUc/v+JIga1v5WPshKH
 kwbAXSkdGppWCMger7aN4i8ZQxEE4T3i/k7AHE6VcYpTXKzbgw5zE1l5Rv8e8PafM0zWYY
 G+40w9UgCt7UTvSeX31fV1UypudgihgI3rSR7X0WK69PWKiZVGti0J1VnkH24NxmsUgi8+
 0/nEP+40BR1FhCaCVDOFWE4l3onHWuxtAFsK4pL/BICojn9sS23zWYyGCrog
X-ME-Proxy: <xmx:Sax5aiUwex3LRQr6_qgIYcaVyEdd4no3-TsaVJ0Sz0bTIaGOGSRSXQ>
 <xmx:Sax5aorIukvY8Y4Mzkcv69xz3_Ow8a4gIhzK86XqqiRrK57I4Z4q7Q>
 <xmx:Sax5arWqlaeryNOMJ7h_m4a3iOV2lEMnsbCrNg6WH7nCi6zMLIJjaw>
 <xmx:Sax5ahEw4qBapU8QdsRK-hIgmaTuaKF25tUKwlH6W4MfrDJYN8EkHQ>
 <xmx:Sax5agfmGMUW-_WXNE7_SQifw9oL2egGoz-uRPUOeLfx5wgqiLAR3Ey5>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Aug 2026 06:47:31 -0400 (EDT)
From: Jiaxing Hu <gahing@gahingwoo.com>
To: chaoyi.chen@rock-chips.com, royalnet026@gmail.com, heiko@sntech.de,
 tomeu@tomeuvizoso.net, robin.murphy@arm.com, diederik@cknow-tech.com
Cc: alchark@flipper.net, linux-rockchip@lists.infradead.org,
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Jiaxing Hu <gahing@gahingwoo.com>
Subject: Re: [RFC PATCH v6 7/9] accel/rocket: add RK3576 NPU (RKNN) support
Date: Mon, 10 Aug 2026 22:47:28 +1200
Message-ID: <20260810104728.1214233-1-gahing@gahingwoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260808123926.23903-1-royalnet026@gmail.com>
References: <20260806063413.350184-1-gahing@gahingwoo.com>
 <20260806063413.350184-8-gahing@gahingwoo.com>
 <20260807211629.1573228-1-gahing@gahingwoo.com>
 <20260808123926.23903-1-royalnet026@gmail.com>
MIME-Version: 1.0
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

> One item outlives it, because it is not part of the poll machinery. In
> rocket_core_init(), the new multi-power-domain attach returns without
> unwinding rocket_job_init():

You are right, and the path immediately above it is the model, as you
say. RK3576 still needs the attach in v7, so the shape does survive the
rewrite, and v7 unwinds rocket_job_init() on that return.

> the commit message says nothing changes for RK3588, but struct
> rocket_core's clks[] grows from 4 to 6 there while the two extra names
> only arrive in 7/9

Moved rather than explained: the array grows in the patch that adds the
two names, so the RK3588 patch really does change nothing for RK3588.

The poll is gone in v7 entirely, not reduced. With the TASK_CON fix the
interrupt retires every job, so there is nothing for a fallback to fall
back to, and a fallback that never runs is a fallback nobody tests. The
job_lock move goes out on its own with a Fixes tag rather than riding in
a feature series, so it can be picked up on its own timeline.

> I would rather send you results than a tag that covers less than it
> looks like it does.

So would I, and thank you for putting it that way. Probe, multi-task
jobs, all three cores in parallel, a forced timeout and reset, and
runtime-PM cycling against a bit-exact oracle is more coverage than any
tag I could ask you for. I will send v7 to you directly when it goes
out.

Jiaxing
