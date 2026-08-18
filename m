Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C06DAC5DF70
	for <dri-devel@archiver.kernel.org>; Tue, 18 Aug 2026 07:29:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2611A10E02F;
	Tue, 18 Aug 2026 07:29:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MPCjR7xa";
	dkim-atps=neutral
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B18410E02F
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 07:29:55 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4954a2dba6cso3587815e9.1
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 00:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787038194; x=1787642994; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3jTJ//eajjn4P7tJjJphCt0+k3XaL0BsSvnnhTQJhRM=;
 b=MPCjR7xa3t4oAzQSYSDMdbe0dK1kUXX7xv4I/TXr7bNTmHoWBx2m3eN6H9FTWgUhks
 gDz8i/nupJ/Uy9tC9kB0d3pHpHndE9C/iolil30h3flh+bPfClY8qEzjw6S7xyHyDYNQ
 gr93uVLfP/Y14xosDmlBYPWFhPUIzfJQCq3hgGHbbPmm9xRSQ4Aqf78uBdfOj34CGepa
 H/o585DmPTi4hiqdYoYK1S+hkd/YiGp3Hx335Ak3qCxRy5MZn6iEHxBYyz61wsFlOV2G
 GSrkb/cn3SUwaRBP0x7ckt91p/oo2f3P8DfY7SsBq1M6HGbCV5Uw9FCzxJJGM0kAtxz8
 8bNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787038194; x=1787642994;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=3jTJ//eajjn4P7tJjJphCt0+k3XaL0BsSvnnhTQJhRM=;
 b=ShvEXhJ/4VKz1VKGeG2MGTr1wpBUhLR3B71ndRP1vyhecu4yp2cAPEp29yt7ZhvwJx
 QrD4hH4vyyG0jgxRqvucBsYX7lKCiPhvU/TOIgXoYZPqatSx9NTXJ0oUKYhUyxzTo+KS
 fNXaAM6JxXZJHm3g4dTCfUuKGXsc8RhAFY/5XHjxOcgTQGKNmBKR0V/kp2jNBKG5wJ6S
 9nBW79alK3tLHWmAaQxXZYqoxbDw7TUYe3/86c9NrLqsdvxdWn04c6neCbNEnTT6cxDW
 eJmdR5v8M/DmLIGTKEphZpVd0jDFt30K6+JubYk4NHMdWzDMSny6Ka6U6OFqz6h8amr4
 MZ0Q==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq0AOsAmZWE60CqVKzsiJBkQFVZc/BrhIh+OcUzk/ENXrPs12YSMdJ86aivukQMZuAJjs19uaqgZno=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyOaby9En3uUyIlVc43Da4Nu/9zXcdUsRO4xD+dulkteVfThY+s
 NzEZa23vG0POX7b31IKwSRMtNGZ0IhNqf4EEXIR4SU7zfKqmnfoFKoRU
X-Gm-Gg: AR+sD13wFHPY09m1ige5qGS0dfOa9YKeuPQSJxaNjG1s2C+F3b7YKErVMM6UiXMIQ0N
 fUTCWdnaya4m4+OYTD4F/GBFT5gsmnD9j9VSUjlrwU+xQRa3DLjsEBVXxQ6nJ1+aujMjsoOpQ8B
 y9ou0SZnTDbsQeRMKC8lMklrI3cqwNuFP26S3iuyPyq689nQI9SNmcznsm4sfjWyzQN0Lw/7T6p
 Ce6AFxChRPktOdsCrDAXHkBfWnvEzFq6PhT7+BdRIxCx8LtgwfaW/2qFdApuWwzqaaCTbvi77Mh
 k2uj288Hov75xacpqR645GUrQL8gWnX0cVt9Dc3pHsgToTLjeXxSbE1aS1LIJeDY31/vYtlspxU
 BLO15rij9djRA4zsnrNTzlgNXkUfuD3s3Fp+mZ6gD9CcRxfXO6HhKIrzrx5+f1CedzzSnqci2vi
 Vpl5xEdrvSfIfAE6Cwf7lDpAyU7Sh2aWIV2lAbGnm7GptujmyTK0wOeKYT13DmW2oCwwfzPkQ0R
 PMSDpSPzpaWyDVikGhgHY0vk04WB6bj8Svu0MTrBX3ywbwoOFX0pcImFTBf2AMHOCbrp2/94c/7
 otse
X-Received: by 2002:a05:600c:a418:b0:499:a660:f4ae with SMTP id
 5b1f17b1804b1-499a660f7f5mr1504845e9.1.1787038193769; 
 Tue, 18 Aug 2026 00:29:53 -0700 (PDT)
Received: from OrangePi5-Plus.BB-HOME
 (20014C4E1B90C200E824DF014B0EC292.dsl.pool.telekom.hu.
 [2001:4c4e:1b90:c200:e824:df01:4b0e:c292])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49987b50869sm174877235e9.0.2026.08.18.00.29.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 00:29:53 -0700 (PDT)
From: Igor Paunovic <royalnet026@gmail.com>
To: Nicolas Dufresne <nicolas@ndufresne.ca>,
 Tomeu Vizoso <tomeu@tomeuvizoso.net>
Cc: Igor Paunovic <royalnet026@gmail.com>, Heiko Stuebner <heiko@sntech.de>,
 Jiaxing Hu <gahing@gahingwoo.com>, Oded Gabbay <ogabbay@kernel.org>,
 dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org
Subject: Re: [RFC] accel/rocket: DVFS on RK3588 - a hardware constraint,
 and some numbers
Date: Tue, 18 Aug 2026 09:27:43 +0200
Message-ID: <20260818072936.41844-1-royalnet026@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <c495dae1976dab842d77f4a4a142217eb77b6fb7.camel@ndufresne.ca>
References: <20260801131656.58450-1-royalnet026@gmail.com>
 <c495dae1976dab842d77f4a4a142217eb77b6fb7.camel@ndufresne.ca>
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

Hi Nicolas,

> I'm only looking at the RK3588, I suppose all the issues below
> related to RK3576 ?

No - everything in the RFC is RK3588 (Orange Pi 5 Plus, all three
cores). RK3576 is Jiaxing's enablement series and has its own set of
problems; nothing I reported came from there.

I went through the four commits on rock5b-npu-poc-4 today. We
converged on the same shape independently, which is encouraging:
200 MHz kept as the suspend rate, a single devfreq instance modelled
on panfrost with busy time aggregated across the three cores, and a
cooling device on top. Your ~2.5x on the SSD pipeline also matches
the 2.58x I measured here with simple_ondemand against the 200 MHz
pin.

The TF-A pointer (rk3588_clk.c, PVTPLL vs normal path) is the most
valuable part for me - it names the mechanism behind the power-on
ack failure I could only demonstrate empirically. I will reference
it in the cover letter once I have checked the firmware source
myself.

Status here: after Tomeu's go-ahead I am preparing the series -
bindings, a full-range OPP table in the DT (300-1000 MHz plus the
200 MHz suspend point, so essentially the table you ended up with),
a safe-rate-on-suspend guard, the devfreq itself, and a hold-all
guard that resumes all cores around any rate change. The guard is
ordered before the devfreq patch so no bisect point has scaling
without it. The one hard dependency is my "request the core clocks
by name" v2, still waiting for pickup.

Agreed on OPP staying optional - the plan in my series is that the
driver keeps working with no OPP table in the DT, which I saw you
intend to fix on your side as well.

One path worth checking in your PoC, because it is the one that
made me write the hold-all guard: a sysfs min_freq/max_freq write
while all three cores are runtime-suspended goes straight to
clk_set_rate, which can select the PVTPLL path while the domain is
off - exactly the case your TF-A reference explains. With the guard
in place I measured that write waking the cores and completing
cleanly.

One difference in test conditions worth keeping in mind: my numbers
are with the vendor bl31 that EDK2 bundles, yours is upstream TF-A.
Comparing SCMI behaviour on both seems wise before either of us
claims anything firmware-specific.

Thank you for the "take whatever you like" - anything I lift will
carry credit, and I will Cc you on the series.

Regards,
Igor
