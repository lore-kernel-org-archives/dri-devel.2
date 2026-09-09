Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC627C79F8C
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 09:19:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4493710F03F;
	Wed,  9 Sep 2026 09:19:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZLjZJ7to";
	dkim-atps=neutral
Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com
 [74.125.225.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6FA1310F03F
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 09:19:10 +0000 (UTC)
Received: by mail-wr2-f12.google.com with SMTP id
 ffacd0b85a97d-48435ae9ca4so618622f8f.3
 for <dri-devel@lists.freedesktop.org>; Wed, 09 Sep 2026 02:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788945549; x=1789550349; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PL9pcPV+bgLn+N8hsfR6afv5u/5q3iwl14xc1NE3dOQ=;
 b=ZLjZJ7tolpRZruPn92/zhR354E7ceV3efUAwFgMRJB/yb4nuJ8s/xiSML2VntS/ind
 V2PMDrlzHC+0r9m56JZboR3kO++Gi5gkbp+kpF9SpcIJUDpZlIEWYXDYWhRo3E31iBeW
 6YMMK8JnDH2O5sl3sYQA1vsplvRUfUI+NBVPB/PI/0kAw0InMMnbW7uBEDHIapgOgSz/
 8Qs0PFt5T+hcZoslFd2KkJ0MWTsd6KZ03joSrFbInKS7cQH7uWnIEPc1hUcvj03kiJyY
 TazRzrPTfUhjdVLThwdKdsPzo0/XimxeXpbnmW1OClSWAKcDoCDXD5iJaG0YG+jEKs6b
 DRQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788945549; x=1789550349;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=PL9pcPV+bgLn+N8hsfR6afv5u/5q3iwl14xc1NE3dOQ=;
 b=M7bSt6lUOmTNcWvdg/LMcwotqnDqz2efVStBRdJxvzgSx4eILWMFW4YkB3deB+FyIc
 q6gm/cc4I2uf/tHzq1I3CF4Qdb7npHp48jA2Axd+YF+3xQAI4fbDnaU8Cdq/x30gO+hy
 6pY+7oAfDK5Ng02gsU4O8s3ZAlTjOlmb6/F1x8w1sCq8tf9HlMtu51GHh+q1qw6OhfRg
 zd1ftlz+hSJoFQRfQXlnG9ZK9tKwkC+YhQ3wXBES2PBGzojT/7JWOY1RDbZv81SxC9/f
 UHXnpgHSAIIjHiiwVYUm9sT9Rvum58iohz7NwTscut8iLlNkZxlp43GUfkYYzLdq+X/T
 m8gA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwoexMrxKJ/Q4hZzApntSPHw9W9pj2WKRiMFQzpX9JvWwRz2OTcObSqtyV3TPXn8PQO6hKqlotHKx8=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kZzBV8dd0SXQjNZlDteMwHFHfIl2KQalTaHnjk5xbACGfGplnG
 Ign4n8hIXP4ILG7y+6ShU3GoWBPhgYCLQUh5rm3z/hQZR0pAaOOKEe+e
X-Gm-Gg: AYBFou0imyEIbqR3RpFgSp4Lsac5O2bjZaWZu3CK++wlyESvWezyebF9mI5TqB20NOE
 zf+uw4ArviIu+5oZQUQ8BdeZsMXed0Me9E4QvKR0Uz7c4l+PKryVE+cz1AOw4RF96Ax0cWs64D2
 DcBE0N4HH5nVFbHuel9oc/Mv+Zwn7x8nzlodjdg6IHW66wWfHtPJNBTGWP8UyqkGtktqKYc9oh0
 etdvTwIWEuT3R5tP7H3Pmc5QUiF5xPCOIlxOyVCrZ+Lqq/dMrK0yTyEAawbDlzO36AM9wL5cB4i
 dbjGf0IY8/rT1qfv5x4O+ZN1DELqLHYeXnkImwI6D03D/IHqWRQt6pGAbOyYnJkrk++h2tnzx2j
 Re1ALIOHWTAuVU4BNZ0fWFhc9pErq8+ZieaJylIiiw21WJYyEdTKCH390l2VsyNkjfS1TnRVvDj
 9JGj+BdUirsa/vWa/SW0cYL+MpVepRE8E2sE4yfjv8T8G+cWy0J18daKlLD2fjMJIfEMDt1y8C3
 aqbCRUdLKHnHcgXbDUT36n6vIFSNKJuz6y40z5SEVsdCJXr1A27+3l4IxEnkCZ8HsHSih7t0dtd
 T4lE
X-Received: by 2002:a05:6000:25ed:b0:485:82f7:9053 with SMTP id
 ffacd0b85a97d-48589246177mr34007529f8f.1.1788945548438; 
 Wed, 09 Sep 2026 02:19:08 -0700 (PDT)
Received: from OrangePi5-Plus.BB-HOME
 (20014C4E1B8369007971AC9F7C06630F.dsl.pool.telekom.hu.
 [2001:4c4e:1b83:6900:7971:ac9f:7c06:630f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4858d2693e8sm41822588f8f.3.2026.09.09.02.19.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2026 02:19:07 -0700 (PDT)
From: Igor Paunovic <royalnet026@gmail.com>
To: Nicolas Dufresne <nicolas@ndufresne.ca>,
 Tomeu Vizoso <tomeu@tomeuvizoso.net>, Oded Gabbay <ogabbay@kernel.org>,
 Heiko Stuebner <heiko@sntech.de>
Cc: Igor Paunovic <royalnet026@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Sidong Yang <sidong.yang@furiosa.ai>,
 Diederik de Haas <diederik@cknow-tech.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Jiaxing Hu <gahing@gahingwoo.com>, Jonas Karlman <jonas@kwiboo.se>,
 dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/7] arm64: dts: rockchip: rk3588: add an OPP table for
 the NPU
Date: Wed,  9 Sep 2026 11:18:24 +0200
Message-ID: <20260909091825.10838-1-royalnet026@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <c58d711ff5c9a01cfd69c2ddf86bfd969b36cc63.camel@ndufresne.ca>
References: <c58d711ff5c9a01cfd69c2ddf86bfd969b36cc63.camel@ndufresne.ca>
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

On Mon, 2026-09-08 at 15:44 -0400, Nicolas Dufresne wrote:

Thank you for taking the time on this - and no worries about the PoC not
being posted; the credit in the commit message was deliberate, the rates
and voltages really were arrived at twice independently.

> My impression, and I was to study this properly is that having the same
> table on every core and adding the opp-shared set on it was actually
> probably the proper way to describe this "single clock for all"
> relationship.
> [...]
> I'm curious what's the right approach, and what is the real meaning of
> opp-shared if I got that wrong.

You got it right, and I got it wrong. The binding says (opp-v2-base.yaml):

  opp-shared: Indicates that device nodes using this OPP Table Node's
  phandle switch their DVFS state together, i.e. they share
  clock/voltage/current lines. Missing property means devices have
  independent clock/voltage/current lines, but they share OPP tables.

That is exactly the hardware here: one compute clock and one supply for
all three cores. And it is not only documentation for non-CPU devices
either: in drivers/opp/of.c, _managed_opp() only lets several devices
share a single opp_table instance when the table node carries opp-shared;
without it each device that points at the same node gets its own table.

So the accurate description is the one you had: the same phandle on
rknn_core_0/1/2 plus opp-shared on the table. Putting the table on core 0
alone describes core 0 and says nothing about the other two, which is a
worse description of the same hardware. I will change this in v2 unless a
DT maintainer disagrees.

One consequence is mine to fix on the driver side, not yours to work
around in DT: the driver currently picks the core that carries the table
by taking the first core whose node has operating-points-v2. With three
carriers that choice - and with it the name under /sys/class/devfreq -
would follow whichever core bound first. That is a driver bug the moment
the DT stops being lopsided, so it gets fixed in the same v2.

> We must not justify our DTS choices based on driver behaviours (or miss-
> behaviour). We must justify it based on how accurate the hardware
> description is.
> [...]
> It should probably be fine to not use opp-suspend, if transition back to
> 200Mhz works. It not fine if its to avoid a driver deadlock (argually due
> to a bug).

Accepted, and it is a fair hit. The paragraph as written justifies a DT
choice with a driver limitation, and that is backwards regardless of
whether the limitation is real. It comes out in v2.

On the meaning: your interpretation matches mine, and it is stronger than
"descriptive". The binding says opp-suspend "marks the OPP to be used
during device suspend", and the devfreq core acts on it directly -
devfreq_add_device() reads it into devfreq->suspend_freq, and
devfreq_suspend_device() then sets that rate.

Which leaves the question you actually asked, so I measured it rather than
argued it. On an Orange Pi 5 Plus with this series applied, in-tree rocket,
the OPP table of 3/7 read out of DT, simple_ondemand with min_freq/max_freq
left alone: 25 s of inference, then 60 s idle.

  - The governor takes it back down on its own. trans_stat records six
    transitions for the run - 200->1000, 1000->800, 800->1000, 1000->900,
    900->500, 500->200 - and then 60129 ms at 200 MHz with zero
    milliseconds at any other level for the rest of the window. The step
    down happened within one 250 ms sample of the load ending.

  - The transition completed, it was not merely requested. vdd_npu_s0 goes
    700 -> 850 mV under load and sits flat at 700 mV for the whole idle
    window. In _set_opp(), when scaling down, config_regulators() runs only
    after config_clks() has returned success, so the supply could not have
    come back down to the 200 MHz voltage if the SCMI clock set had failed.
    All four voltages of the table were exercised: 700, 750, 800 and 850 mV.

  - The clock summary in debugfs agrees, reading 200000000 for scmi_clk_npu
    after the load. I only sampled it after the load, so I am offering it as
    consistent rather than as an independent check.

So the transition back works here, and by your own criterion it is fine not
to use opp-suspend. This is one board and one part, so I would not call it
more than that.

Two things I want to keep apart rather than join with a "therefore", because
joining them is what made the original paragraph wrong:

  - What guarantees the rate across suspend is the driver, not the governor
    and not the DT. rocket_devfreq_suspend() in 5/7 sets the recorded boot
    rate itself on the system suspend path, and 4/7 restores it before the
    last core goes down and on .shutdown. That is the answer to "is it safe
    without opp-suspend".

  - Whether the governor walks back down to 200 MHz when the NPU goes idle
    is a separate fact, and it is the one you asked me to check. It does.

opp-suspend acts on the first of those. Since the driver already puts the
device back at its boot rate on that path, the property has nothing left to
do here - and that, rather than any deadlock, is the argument v2 will make.

Worth saying plainly: every number in the cover was taken with the limits
pinned by hand, so this is the first time the governor was left to decide
anything on this board. Your question is what exposed that.

> This is irrelevant, I think you can drop this paragraph.

Agreed, dropped in v2.

> Ack, this is safe thing to do.

Thanks.

Regards,
Igor
