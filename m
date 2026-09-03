Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B816CC61DD3
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 09:17:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D695C10E0DC;
	Thu,  3 Sep 2026 09:17:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nhR3FvmE";
	dkim-atps=neutral
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com
 [209.85.221.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1BFB110E0DC
 for <dri-devel@lists.freedesktop.org>; Thu,  3 Sep 2026 09:17:08 +0000 (UTC)
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-482e06fda73so274218f8f.1
 for <dri-devel@lists.freedesktop.org>; Thu, 03 Sep 2026 02:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788427026; x=1789031826; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MJ21EV3MQMwKYFKEIFBZIDEf60/In3kxMYYbf3aP7SA=;
 b=nhR3FvmEuraomEfofTK5MRexnXMZai4roVaaUUoSmgaIYdwVbXT6bO1orv2o2wRawk
 JlQ4rDBqFH6wbrRcAHFQTNjZmWof7goEreSWr+GLYzvScfy2bUTJboo9R54FvKxEHQki
 OqsATGFZFzIgWr4/nOMI+wxJFdJsubEy6a0HpNmXmlununvpWrp7c8uXXGnDUgdf6FRT
 9lsUKuc3d36L8vCZoQ+Qpe+AdOLzdfOm23gqBU7ymIdsiXBW+GRFtSl3TkW5RPgEma9m
 N/0v4dfO3QJOtIn6+dzW2jit7qYBgAQcBR5GxfPAmtHrg/SfIcAHLrveRe8sGn92cFKC
 85eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788427026; x=1789031826;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=MJ21EV3MQMwKYFKEIFBZIDEf60/In3kxMYYbf3aP7SA=;
 b=KriQ0zkdHJNcy7ToHPD+yjaAizC5x3A5L6my6FFMHh1v8h9Je4cAbs/TQAE5qTK3jk
 qIbPApJmw0661Ln2Om9w/YjsZwBAZVWF4cGbWbQW9w6hSy8IPpOdhohTvpl2UFlDxStN
 9BqON2j2cTtqGxEPHOXlPjt8Yy4sVAVygacao18tglCsm/OiJEpgWkkuvFs00RElZz+Y
 13hwNYyASlcTuDT+C8DIEpP/boeV7lxnVu8QMItQ05OZP0o2Eb/1p+jsbNWeibyIQ0H2
 sFhDP2Cq1cA6dRv+aHGLaKqZQi0SkZxZMQ9WU3fmvFVDDdimBBnyTUo7LQ3/M8gpkWw2
 POKw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxDCwkR/z/0MHa40vCcxOtZ1tPjs2E7R09R9fA8LXtxe2Fd1vRHcPOz9stEbkrHSGNRMLiP0+xp4NY=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kdvgfTaN8UfX7ifeXi7EI0S6CjfILtQ9xmJORLrRo9Je4JwvFk
 VQvzH6nNJ/5U05yrw7iFWthYG6ubipBxe3ZlEqPxkTEqThaL//vm2pzG
X-Gm-Gg: AYBFou2jy0qKOqNDsYgr3y//CjYoMODKvO/8126Kk7EYC3slRi0T2nnAEiz5V+LtysM
 R6ib6aWPFnt4KiuJc/22+CLcr7l6M8eKE00en7oXKzS5bpsR96DOotC3kaJDtj0W79nIt1v1JgI
 wnM+5xxzcJFUnSTgkzbB9VzvYsPnh8le1WD9XD0c0x1r9gR+iM5buARh1d0P9Mzfrrvy0EUcxhy
 /TSHavIbYftqmyLYsLS9B0CygEcYQJFfoo/C0swdgZvthO+cgDk2fTCTtTTvWIZDOBulCvfMpQ7
 ho2sQ3l3YgP9UB0bkHULZSm8VjVLoMJZKvPRaxplGFOng8fliRt7CGTG7iYCEhhME+wgTD8FJoI
 NaruuYgACzlrVhmCbyYXWHuxu0230zSkR9mB9KfGrc+Pk4C03x4UO4CA7HpnsfVEJPtBEkNnR/3
 wdirFBxZrN7j6JjP3Msbg3O7HuWzjfJCVmaoP9cbfWSK1yW/VcQHf/cdr8c0VmFznYiI+wHYxel
 o7ycXO5GH11Yjx0qu+tP9/IWfQIpMUH3Bm9G8KaPCo4MBcjlBErRCMdresoa19q+nAW7qrT79LW
 9Us=
X-Received: by 2002:a05:6000:3106:b0:482:ea38:6b80 with SMTP id
 ffacd0b85a97d-48488f0b107mr9295974f8f.1.1788427026169; 
 Thu, 03 Sep 2026 02:17:06 -0700 (PDT)
Received: from OrangePi5-Plus.BB-HOME
 (20014C4E1B8962003434AB95A407E573.dsl.pool.telekom.hu.
 [2001:4c4e:1b89:6200:3434:ab95:a407:e573])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48448ed3706sm12709656f8f.18.2026.09.03.02.17.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 02:17:05 -0700 (PDT)
From: Igor Paunovic <royalnet026@gmail.com>
To: Huseyin BIYIK <boogiepop@gmx.com>
Cc: Igor Paunovic <royalnet026@gmail.com>,
 Nicolas Dufresne <nicolas@ndufresne.ca>,
 Tomeu Vizoso <tomeu@tomeuvizoso.net>, Heiko Stuebner <heiko@sntech.de>,
 Jiaxing Hu <gahing@gahingwoo.com>, Oded Gabbay <ogabbay@kernel.org>,
 Jonas Karlman <jonas@kwiboo.se>, dri-devel@lists.freedesktop.org,
 linux-rockchip@lists.infradead.org
Subject: Re: [RFC] accel/rocket: DVFS on RK3588 - a hardware constraint,
 and some numbers
Date: Thu,  3 Sep 2026 11:16:37 +0200
Message-ID: <20260903091646.7183-1-royalnet026@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260902110432.22069-1-royalnet026@gmail.com>
References: <20260801131656.58450-1-royalnet026@gmail.com>
 <ad1e526e-a4cf-4c34-88ff-1884ef2f3dfe@kwiboo.se>
 <286e8418-fae6-4979-96d1-e13abb04b3a1@kwiboo.se>
 <3204a0d0-969d-4ac6-adfd-29c57f1c3e0a@kwiboo.se>
 <20260819125932.5853-1-royalnet026@gmail.com>
 <82c8b17e-7215-45ea-84d1-9991ba6fb541@kwiboo.se>
 <20260819184807.6665-1-royalnet026@gmail.com>
 <f5241666-9657-4f49-958f-476fd366e408@gmx.com>
 <20260902110432.22069-1-royalnet026@gmail.com>
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

Yesterday I wrote:

> My next step is to cherry-pick that commit into my BL31: if EL3
> also reads zero, the silicon answer wins.

Done this morning, and the answer is in: the firewall wins, and
Huseyin called it right.

Setup: d2d6928641ba cherry-picked onto the upstream TF-A v2.12 my
board runs (banner v2.12.0-10-g70d814213 verified over UART after
flashing). With that BL31, clk_get_rate() goes through EL3 reading
the PVTPLL status words directly.

NPU, from EL3: NPUGRF+0x24 reads a real value. clk_get_rate()
returns exactly 1000000000 at the 1 GHz OPP and exactly 700000000
at 700 MHz. At the same moment, the same register read from a
kernel module (EL1) still returns 0x00000000. Same register, same
instant: secure world sees the counter, non-secure gets zeros.
So the counter is alive in silicon, and yesterday's dead end was
the per-ip-core access restriction you suspected - not a missing
clock and not an unbonded counter.

GPU, from EL3, as cross-check under glmark2 load: five consecutive
reads gave 1048, 1053, 1047, 1054, 1049 MHz at the 1000 MHz OPP -
live jitter, matching the 1042 I measured from userspace mmap
yesterday. So EL3 reports raw measurements, which makes the NPU
result the more interesting one:

The NPU PVTPLL apparently LOCKS to its target (readback == nominal
to the MHz, at two operating points), while the GPU one free-runs
about 5% above nominal. Same register layout, same CON2 contents
as far as I can see - do you know what makes the two instances
behave differently?

Practical upshot for this series: with your TF-A commit in BL31,
plain clk_get_rate() gives the kernel measured rates with no GRF
access from the non-secure side at all. That is the clean
telemetry path for rocket DVFS, and one more reason your commit
earns its keep on RK3588.

One honest gap: I could not yet take the voltage-vs-frequency
curve (my devfreq module holds the NPU rail at 850 mV as a
regulator consumer, so undervolting from a second consumer is
refused). Future work.

Igor
