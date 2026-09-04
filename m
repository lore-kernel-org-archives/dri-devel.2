Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60A39C624DE
	for <dri-devel@archiver.kernel.org>; Fri,  4 Sep 2026 12:47:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B4A810E54E;
	Fri,  4 Sep 2026 12:47:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PFMFSCK+";
	dkim-atps=neutral
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E7D6010E1C7
 for <dri-devel@lists.freedesktop.org>; Fri,  4 Sep 2026 12:47:27 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-4956d1d9fb2so906015e9.0
 for <dri-devel@lists.freedesktop.org>; Fri, 04 Sep 2026 05:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788526046; x=1789130846; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RkSNe1iKI6tZKILRaV1iEvBVwUEOpWWRfifGPFlO+mE=;
 b=PFMFSCK+a1cmTlCIEvc8UTY53vUFwEpEyld/48Ml8AMOjCsVteqlaI/sPSzAmj0xkU
 BD672xo/48yzlI4+PNk3XpjuwY/kiteHmK946MIFPD/90a0TbcIojL/Eu6FD62aBh0LD
 9gno8kx9JVTnzxF93Wpl5mfolMlzJil3tfmulVyuCSOdCgT015W1UhHyUOyjSdBVj0dk
 u7SS0ERjqGGv0PYaKt6AQZnTzDx1Oo3a1YVoSnQYRiiAMWTn9mwQtXUbuB9l5lFy8hB6
 Z9nZVezjldxPEdEOTqRE1oRd7D6TeSTlSPXK9LJSz7aC+dFFM+ifDxIaKrRRkhxOcwGF
 sn7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788526046; x=1789130846;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=RkSNe1iKI6tZKILRaV1iEvBVwUEOpWWRfifGPFlO+mE=;
 b=QK/6BBzSp4wMcQQl9SS504Y1Kr8MtidHy/51xMAsqZWkwzDl5JhfEaGr1OX2CSabeM
 jfFf7ZSBt97i9QuBVOJiNBloSicPbq6/qUoQnnv9OkJgGLdAAN/aTS6XUjQkaKJ9q+gP
 uEAwu0V9VrOkgy1rvnR+b+4p8KbpmCpkBrNloS+cN9QWRY+aFWrutqlOoRlKQhCAIyIN
 gyJ49B9seLtWBt78OekZsqsmIgzdwxH6KDj1eYvMTP/mSO24i8y0qfwZnktmYXR2nvWq
 Uh4NNSAOAmu79zub4rWNP5H0vGzJhDqAq56Qx7JaPmdspuGG7eSP/O9WM4upHujeeNLA
 lciQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBx4dVa9CluhL/UVnVdH6uj0Wcl601vwV2twmq+dXzPF7zHxivP4kzczqzszhwGuLv5E/9vphNDCW88=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mlvp9X+TCsUAueCtOiUOKCLGv7RZGllmy9JmYBDfF9KridytSy
 wOJaOV1v82p7wnpeTbhNMDnteGAHDhlBXvdieR1pEtTlQgThu85s7vp2yFydNQ==
X-Gm-Gg: AYBFou1Em+qZzbUJv5qcGJMbQLeJtSampgOQSZoB+93vOSFU0hxYITn4uhVVgx4G+Y+
 9ij5O0W1Bv3GeR5b3T/hxMmQPqAHm3fQC5OO5VeeYK7QOE9jnlo0WZcLIJ3ZnZzcWWjXRWLS3F9
 QzzM4s8y10vT77Sbq/GES2AOFRl4rwqZbv5/X21Ah8yrLCTP6B+CP0W2CvBn6wAuT55XNm0N7wk
 QS+1EVfDNWJskDe+6nYQv+XbR5boL1X3+fiKzrZCAifWAeZPRIdKbnymuoppE04YgyLtHJFCnTv
 Ym6Qhhc2ur6s9eE1ELNN4RlDxDrR4RvTL6VwjxtUSsx4Ev6jc/dSDOEzExCR3H2c+3rnT/X1g/W
 SMzP1/PsfNcfvZSpSZKmQ37jBvtfmhDCEqIUDP32Dacvwi3anRrTC1r+CCiYZTT6GwyG2jGGlXV
 xDevlVseHamBdPM/dTLIMLVqlG3/ySU96pZhfxSdo8iEANuUwJDX2pcZJyPBHrXdtNk2Y5OC3sR
 F1yzlHNqUn5QgeOXkwdNEYTO7BC7UldrqcD/auU1qhKpGXbMUMXcYjPww68tI6fxjk3+A==
X-Received: by 2002:a05:600c:a40e:b0:49c:f9b8:bae0 with SMTP id
 5b1f17b1804b1-49cf9b8baffmr32943645e9.2.1788526045880; 
 Fri, 04 Sep 2026 05:47:25 -0700 (PDT)
Received: from OrangePi5-Plus.BB-HOME
 (20014C4E1B871500CB6EF488A18F9C42.dsl.pool.telekom.hu.
 [2001:4c4e:1b87:1500:cb6e:f488:a18f:9c42])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cfd3f815bsm21924425e9.4.2026.09.04.05.47.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 05:47:25 -0700 (PDT)
From: Igor Paunovic <royalnet026@gmail.com>
To: Jiaxing Hu <gahing@gahingwoo.com>
Cc: Igor Paunovic <royalnet026@gmail.com>, tomeu@tomeuvizoso.net,
 boogiepop@gmx.com, nicolas@ndufresne.ca,
 linux-rockchip@lists.infradead.org, dri-devel@lists.freedesktop.org
Subject: Re: [RFC] accel/rocket: DVFS on RK3588 - a hardware constraint,
 and some numbers
Date: Fri,  4 Sep 2026 14:46:55 +0200
Message-ID: <20260904124659.25971-1-royalnet026@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260904110853.85150-1-gahing@gahingwoo.com>
References: <20260801131656.58450-1-royalnet026@gmail.com>
 <20260903091646.7183-1-royalnet026@gmail.com>
 <20260904110853.85150-1-gahing@gahingwoo.com>
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

Hi Jiaxing,

> Your rows are one inference thread with a bit-exact oracle, so they
> cannot see this class at all. Before the OPP table is settled, run
> the oracle with all three cores loaded at 900 and 1000 MHz on 850 mV.

You were right, and it stopped me sending. The series was packed and
checked and I was an hour from the send command. Every number I have
posted, including the ones in this thread, came from a single inference
thread. Not one of them could have seen what you found.

So I built the test I did not have. Three concurrent clients, each
checking its own output bit-exact, on the two top rates of the table:

  900 MHz, rail 800 mV    3 x 199 inf/s, 598 total, all bit-exact
  1000 MHz, rail 850 mV   3 x 204 inf/s, 611 total, all bit-exact

Single-client control on the same rates: 232 and 240 inf/s. So the
aggregate is 2.57x and 2.55x of one client, which is the part that
makes the bit-exact result worth anything - the three cores really were
computing at the same time, not queueing behind one. Kernel log clean
through all four passes. Voltages read back from vdd_npu_s0 during the
run, put there by the OPP core, not by me.

One honest note on how I proved the overlap, because I got it wrong
first. I had the test sample runtime_status of the three cores and
report how many were active. It said three of three, one hundred per
cent - and it said that with a single client too, because this series
holds every core resumed while the clock is raised. It measures power
state, not work. The aggregate throughput is the real evidence; the
sampler was telling me what I wanted to hear.

So: on RK3588 the answer to your question is that it holds, at the
voltages the table names. What I cannot tell you is where the edge is.
I have not run 1000 MHz at 800 mV to find out how much margin 850 is
buying, and I would rather not guess in a commit message.

> whatever the table ends up as, it needs the voltage column with the
> rate: a rate without its rail is what mainline has today, and it is
> what corrupts.

The table carries it: 200 to 700 MHz at 700 mV, 800 at 750, 900 at 800,
1000 at 850, which is Rockchip's own table for this part. Your four
days are now a paragraph in my cover letter with your name on it, since
that measurement is the reason the test exists.

> On RK3576 an assigned-clock-rates on the SCMI clock in the NPU node
> hangs the board before the console comes up

That is worth more than the question I was going to ask about it. I
have kept assigned-clock-rates on all three RK3588 nodes and listed it
as an open question, on the grounds that of_clk_set_defaults() runs on
every probe over the shared clock and could quietly lower a raised
rate - which I have not managed to make happen. Your board says the
property can do considerably worse than that. I will say so in the
cover and let the maintainers decide whether it goes.

Two other things while I have you.

I am sending a fix ahead of the series: rocket_remove() decrements
num_cores while find_core_for_dev() searches only that far, so the last
core is never found on unbind, num_cores never reaches zero, and a
rebind writes rdev->cores[3] on a three-element array. Silent in
mainline today; UBSAN caught it once devfreq started walking the array
from a worker. It has a Fixes: tag and Cc: stable. You may want it on
RK3576 too, where the same code runs with two cores.

And the small one I have been sitting on. My series carries the
clocks-by-name patch as 1/7 so it applies on its own, and that copy
still has your Signed-off-by from v11. You are not in the delivery path
of my series, so by submitting-patches.rst it does not belong on that
copy and I would drop it there - your Reviewed-by is the credit that
matters and it stays, on both copies. On the v11 copy your sign-off is
correct and I would not touch it. It is your name, so I would rather
ask than decide.

Igor
