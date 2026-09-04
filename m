Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79A71C61DD6
	for <dri-devel@archiver.kernel.org>; Fri,  4 Sep 2026 11:09:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6CEBB10FABF;
	Fri,  4 Sep 2026 11:09:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gahingwoo.com header.i=@gahingwoo.com header.b="sDtgiyGz";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="q6c5W6K8";
	dkim-atps=neutral
Received: from fout-b2-smtp.messagingengine.com
 (fout-b2-smtp.messagingengine.com [202.12.124.145])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 521EF10FAA4
 for <dri-devel@lists.freedesktop.org>; Fri,  4 Sep 2026 11:08:58 +0000 (UTC)
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfout.stl.internal (Postfix) with ESMTP id 92BBC1D00140;
 Fri,  4 Sep 2026 07:08:57 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-01.internal (MEProxy); Fri, 04 Sep 2026 07:08:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm2;
 t=1788520137; x=1788606537; bh=cPCvXj5HZ74KNvDUYgsntjSUb4RTOmH2
 icqlWiSyLqE=; b=sDtgiyGzdp8OhYPZpLfw3/k3wVef/WlqPQZEIlpSlrvH5Bib
 APFq5yRSCnqBDodvtUlhwbxHnEivdqu+5Fk9rt/9buccmRc+VizQtIrqpuCjgiLf
 NuQMC10bCCUE4Ca+pIp9GRPOQo0Q7u7HSJBssayw+9tVIbzXbuo8keQFuN8fBzVA
 vsxt9vhc6yN2JUniYxtYrZdRMrLCAPBlVk3MVll8gQ1MxbQa4WxHkZzg8liyqtAx
 OiObTDG17LuYDCxV9sn6lfY5hdXe00NASLjm5ycP2ig8BUnSkTxObyfTvSRB5N97
 X5o8xug+YBwZ5u2MupbsoS9DtgB1XUnbMXYr6w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788520137; x=
 1788606537; bh=cPCvXj5HZ74KNvDUYgsntjSUb4RTOmH2icqlWiSyLqE=; b=q
 6c5W6K8KVyFRXknvTJT5RUg6ngyXgkfaT2dM+Bw2cHUIhgtmRt7+tKBWrC2jsM/t
 T90R+hgGN+9iA+D2TMgwAqVSZnYgILXAr1ML0rra5g+hj0GIHm0+G0CS5DMfpLEF
 0fBfy6eIRdGu4FxncMhy1Q6q64cBBxVHVwrGSokpJyOah6vA8i/OMWoY/DHNwUHV
 tbvDRHuXL3kqkfWrozleAD25qctEfryLpkat0Mp8IecVgc0YCTHfKcZvGYJcyeBL
 BaWphizBL0ei9ucbBHYv2bcOWUAyElY1vIgCKteZ4CUInOj17swZdeDwKhsVuWyJ
 3DbVVTqnQ0F2wIGw7/inw==
X-ME-Sender: <xms:yaaaal68HgmwuleYjdUo3fUu-ykzUBMeQi00Jy4iJ5KTr6L_DRdfhw>
 <xme:yaaaasMX6I3mgOpRz6WE5tlXVMcwQsmoEu-OjBursDmtriXP33pOD8pLhROQpsO1d
 AAnZccEUUQIkIcqHtDlMiqZvd8Cq0kXxSz9bEUzHhyDJXTzBrlDvB0R>
X-ME-Received: <xmr:yaaaajsfZVkPxGyNpUdslPYOfeIHiF-_LuiUw1kFlsGRdZVe0Mhy7N4EaEtBoiWdEgOMsdlZRA>
X-ME-Proxy-Cause: dmFkZTElXIzjLscUjtqSumcHig4M1D0jXKfOMAkEuTETqy3LOscYUfzx5r99r0rrNMKlhp
 KKPCXOd2v/OisO8Xilxfv4xa6MDrA5mZ082FIuxh0Ih4hwF84rA9FCeZ8+gb1Xtc+ChAp1
 0np7kaDey7TRKUa2G/J4o97NqpwFxixR/vMz7JrsOflFGyJZtFlSNz6dWRvB7SNQhmPyX2
 BHG65jD+e/YMtto4r0lK6Zhu6ExdBNJnrBuanggnSlWpsexK4C0B2Ph64PTuwcQ7q0XUfN
 n5pGh6VO+jFwIlSjp8URnOwrtfaWF42kX6mdSvGPeK/f5JiK/C7dmjVhOurOPnZJBRPFQq
 j00QxCG9N7XxQYOz8vtHbFDbJ6kpViOtW5O8VtU0yvTblTIpnr/LG2EX9AxoBh2zuX7Z4Z
 TMZp6wMjdvfpC2AJrJaf8eWSC92fflck3XTuc/k3HnysETr/ZyWqcD2jeb1wRjgB46645S
 3itunR7fETC1t3w0x0E0JKzHcvF8p/Xy5Y29q4c4RDkf1o1R82aYlf+U1KMI5GQL+Al8dU
 8dMPK0KjkHc9vwsTkBTbIegbNiV4yL171XCUJFBYlIJIiDvKRBwYkTIj0qujIeMTDmChyG
 eGOCAjBgxUoOSpU5GHDTHhYzImrmu2gqWLSMx5glUjPcdRV4hUsfdV6OeqxQ
X-ME-Proxy: <xmx:yaaaavZssW1SQZFs6pHJAb7zPsbjDRWoxnlUq3zfd-SRhzApEO5c6A>
 <xmx:yaaaalzfQPFApx4oOrCCFS14lMCx3Ctg_A2Xq6PsGY__JcjNELfT7Q>
 <xmx:yaaaanjG6bCE1Rxc98qhrGtaYIsj7CqAyuOWjQJAGHZMe7rK2pg60w>
 <xmx:yaaaahktvU31lFH9Oo2Kljbh_p93cs-5W597fBXHDX6qiD3qpSK5vg>
 <xmx:yaaaam4tkB3mW52LN0nc9ugFjb6tfYrjrawNyXhnMReoeJkpY1gXBWKd>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 4 Sep 2026 07:08:55 -0400 (EDT)
From: Jiaxing Hu <gahing@gahingwoo.com>
To: royalnet026@gmail.com
Cc: tomeu@tomeuvizoso.net, boogiepop@gmx.com,
 linux-rockchip@lists.infradead.org, dri-devel@lists.freedesktop.org
Subject: Re: [RFC] accel/rocket: DVFS on RK3588 - a hardware constraint,
 and some numbers
Date: Fri,  4 Sep 2026 23:08:53 +1200
Message-ID: <20260904110853.85150-1-gahing@gahingwoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260903091646.7183-1-royalnet026@gmail.com>
References: <20260801131656.58450-1-royalnet026@gmail.com>
 <20260903091646.7183-1-royalnet026@gmail.com>
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

> One honest gap: I could not yet take the voltage-vs-frequency
> curve [...] Future work.

I took one on RK3576 this week, from the correctness side, and it
turned out to be the answer to a fault I had been chasing for four
days. Short version: solved, and the fix is a voltage.

The fault. Two NPU cores with jobs in flight at the same time, and the
second one writes single words of its output wrong: the right value
plus a bit of the accumulator. Of 64 wrong words I took apart, 63 are
an integer away from the right one and 25 of those by exactly 1024,
and re-reading the same word after invalidating the CPU's cache of the
buffer gave the same wrong value 48 times out of 48, so it is what the
hardware wrote. One core is always exact. It took four days because it
is invisible to a single threaded harness.

The cause. Mainline sets no rate for CLK_RKNN_DSU0 and no board sets
vdd_npu_s0, so my ROCK 4D runs the NPU at 786.432 MHz on 750 mV, while
Rockchip's own table for this NPU asks 800 mV of its 800 MHz step at
the worst leakage bin. Same wall as yours on the rail, so the curve is
one device tree per point. A pass below is 5400 rows of a batched
matrix multiply, each row against the same multiply done one row at a
time:

  786 MHz, 750 mV    11 to 25 wrong rows a pass
  594 MHz, 750 mV    0, 0, 0, 0
  786 MHz, 800 mV    0, 0, 0, 0
  786 MHz, 850 mV    0, 0, 0, 0

The fix, two of them, both measured. Give the rail 800 mV and keep
786 MHz: both cores run, nine models come out identical, and my time
to first token drops about 20%. Or leave the rail alone and clock the
NPU at 594: also exact, and still ahead of one core at 786, because
what 786 MHz costs is the second core. My v12 takes 594 in the SoC
dtsi, since a board that describes no NPU rail has to be correct too,
and my runtime now reads the rail and the clock out of sysfs and only
runs the two cores together inside the vendor's envelope.

What I would do on RK3588. Your rows are one inference thread with a
bit-exact oracle, so they cannot see this class at all. Before the OPP
table is settled, run the oracle with all three cores loaded at 900
and 1000 MHz on 850 mV. And whatever the table ends up as, it needs
the voltage column with the rate: a rate without its rail is what
mainline has today, and it is what corrupts.

One SCMI note, since you are reading rates through it now. On RK3576
an assigned-clock-rates on the SCMI clock in the NPU node hangs the
board before the console comes up, with no kernel output at all. I
have not proven why, but the vendor's driver never sets that rate from
DT either: rockchip_opp_config_clks() returns early when the clock is
an SCMI clock and the device is not runtime active, so the rate is
only ever written from the runtime resume path with the domains
already on. Your EL3 path is a read, so none of this touches it.

Cheers,
Jiaxing
