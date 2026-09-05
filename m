Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AB42C624DB
	for <dri-devel@archiver.kernel.org>; Sat,  5 Sep 2026 15:14:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F0BF710E64A;
	Sat,  5 Sep 2026 15:14:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NlLAstkr";
	dkim-atps=neutral
Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com
 [74.125.225.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D84F310E64A
 for <dri-devel@lists.freedesktop.org>; Sat,  5 Sep 2026 15:14:08 +0000 (UTC)
Received: by mail-wr2-f12.google.com with SMTP id
 ffacd0b85a97d-484399babcaso90705f8f.0
 for <dri-devel@lists.freedesktop.org>; Sat, 05 Sep 2026 08:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788621247; x=1789226047; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0NOVY4ecrwmijTIwofsEVU1GqxsGoGl/mrGh4bEdkTc=;
 b=NlLAstkr+Af8jsD8dNqMQBdq/hCIElPUgvOT+EHeJ9doajEe8mG8gSsIy7V4MqDtyE
 zv3ZjGu5f6CT9bSEXj2P7MuQhrryLLW4CekGIaQoJI8lCFYvU9FBzRbvEAV9UXIA3Yue
 xkFWzs6UKC8tAMD2hTrVauVljPd75B0jH6uk/cI+zIcDBy9Knd61dp3OZxaZzZomwaWV
 1c5QebuWrnvTtynBjSlnaIJnu86VQq5cSWOKPoWkA5vkzpDUahXWiqJ3X0x22yTjnxRQ
 mwKgQn9HarTqmRTAFuVQOQIymjeX1fuv52dS6HErzDsL9CpZYREMP+b1PaoDENkmDtFl
 IoNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788621247; x=1789226047;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=0NOVY4ecrwmijTIwofsEVU1GqxsGoGl/mrGh4bEdkTc=;
 b=YvR3vWHReFN2kp8eMc3GalUKGSPG+aV77e1x+gEZucWuKWtZC6Pyn2zEgKSy1sn47G
 sLraPSP6aPBkjyKcekpTSkO4yFoG8daZyT5JoEMZybuEA29Ee5By3lraRuF2ogCA7tLY
 0VOlpBV4/TUSU6uzjUHc9hEOhQCIsl/vRCUAmJseAgc8/APBLHVihoZ0ITMa0f6iXOiL
 kIFZcyGO4LAhaidv9L+2fnq79T6di4QYU6nKrUlYaSBq3TEYfdurzvUQc0lZIxZ0EJqu
 +IKTflnxcIaixygfeeKtkGmHEhDPCCc+/2e1tiZyvu3nsnInea11mSv7GRwtLIhXrWD9
 nQGQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwQwsegBnpojLBHcCL8PfaPRu4SaqowxxZRo55MA/n6x7ZNPLOURQh/BKVLGT3zgrS/Ke6MCmMxw/A=@lists.freedesktop.org
X-Gm-Message-State: AFuF++niKxjtDIf8JG0hw3lk+oAXCNMkw6kXDxXjx+dptiGvcBSXSfcM
 dzXMhOSaIT45B3pwb3gTalgdwFHCRWrouXlVltKVpg6qBEqGs07h0yDH
X-Gm-Gg: AYBFou1WanmnMMwXO2S+E9dK2MsFLzgb6CRXRlQ0cSmOPgWBq2GRsuMipnEJ8YBmnRc
 6KevzqBOkhhceJ5egazCHSykA9ThWtE+eVt4kVLqeJTakaq8tJHC+5wnq39CIEh9KpD8NC4rTUK
 P+aeVA98+1gFOYpmUwZxxYYPfl8nwxC4PrfLkNiMePA5mSgIIXUzZCBYrHUbnSYI4XsNx4PtYGt
 A/0mNKBXMJIPurR+P7aiYkQoPant5RdlTHTTCNosi3l3W+Y+++bJ+CnsnufYI/vcN7eo627iE5b
 YPCacwEAFKdjfj8KOhr1LQjA5ZD448YhVQWhiEvvGnYCpFIIYx/t7ohjYF1WMcouc1pycKQSnje
 tQbSCC7a6nYNFXt7uZzzmrfl/oXAqz+pAXIT3C/jI0O+XBhn8c1zeacp4hQJ5w2zhD7uuY5dJA2
 QBDDjbC8bLyIBEzDmDyBI1+uZUuVehXl3Va5PThKNsMbXwx5+Yjs977Rp4VIuRB3VRxu2ynP6oL
 YWlhQFU4pmQpGXcETTiPgh6WuJmec3zs1C2bhCFD7nfzYtRWgtH0/e1oB93uwUBtA==
X-Received: by 2002:a05:600c:a012:b0:49c:eac2:ddad with SMTP id
 5b1f17b1804b1-49d01dc0137mr47179335e9.1.1788621247204; 
 Sat, 05 Sep 2026 08:14:07 -0700 (PDT)
Received: from OrangePi5-Plus.BB-HOME
 (20014C4E1B950E0061C002CD703C2CBB.dsl.pool.telekom.hu.
 [2001:4c4e:1b95:e00:61c0:2cd:703c:2cbb])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49d08144037sm30395975e9.7.2026.09.05.08.14.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Sep 2026 08:14:06 -0700 (PDT)
From: Igor Paunovic <royalnet026@gmail.com>
To: Jiaxing Hu <gahing@gahingwoo.com>
Cc: Igor Paunovic <royalnet026@gmail.com>, tomeu@tomeuvizoso.net,
 linux-rockchip@lists.infradead.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] accel/rocket: search every core slot when a core is
 removed
Date: Sat,  5 Sep 2026 17:13:53 +0200
Message-ID: <20260905151358.8997-1-royalnet026@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260905090134.239404-1-gahing@gahingwoo.com>
References: <20260904125936.26234-1-royalnet026@gmail.com>
 <20260905090134.239404-1-gahing@gahingwoo.com>
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

> Moved here from the DVFS thread so that b4 can collect it.
>
> Tested-by: Jiaxing Hu <gahing@gahingwoo.com> # RK3576, two cores

Thank you, and it works: b4 picks it up with the comment attached and
the DKIM check passes. Two cores on a different SoC is worth more to
this patch than anything I can produce on my own board.

Your test also found the edge of something else, and I would rather
tell you before you spend more rounds on it.

You wrote that the cores came back "numbered 0 and 1 both times". That
is the case that works. I rebound the three cores here in all six
orders and only the devicetree order ran clean:

  bind order (slot 0 first)   NPU job timed out         inference
  fdab fdac fdad (devicetree) none                      129.4 inf/s, oracle ok
  fdab fdad fdac              27 fdad                   1.95 inf/s, oracle ok
  fdac fdab fdad              135 fdac, 5 fdab, 1 fdad  oracle rejected output
  fdac fdad fdab              135 fdac, 5 fdad          oracle rejected output
  fdad fdab fdac              136 fdad, 5 fdab          oracle rejected output
  fdad fdac fdab              135 fdad, 1 fdab          oracle rejected output

Counted from the journal since each bind, one six-second inference per
row. The single fdad timeout in row three is on a correctly numbered
core and I cannot account for it; the most likely explanation is a job
still draining from the previous row, since the count starts before the
unbind. Everything else lands on a core whose slot is not its hardware
number, in proportion to the tasks the scheduler gave it, and in both
directions of the mismatch: 5 timeouts on the core in slot 1 whether its
hardware number is above it (row four) or below it (row five).

The cause is in rocket_job_hw_submit():

  extra_bit = 0x10000000 * core->index;

core->index is the slot the core takes in rdev->cores[], which is bind
order. The vendor driver computes that same bit from the hardware
number of the core (rknpu_job.c: REG_WRITE((0xe + 0x10000000 * i), ...)
with i indexing rknpu_dev->base[]). On a normal boot the two agree and
nothing shows. Bind out of that order and every task submitted to a
core whose slot is not its hardware number times out after 500 ms, the
reset does not help, and the inference finishes with wrong output. No
error, no warning, no regulator or clock message - the rail sat at
700000 uV in the runs that passed and in the runs that failed. Only the
bit-exact oracle and the UART log showed it.

The second row is the one I would have missed. The oracle passed there,
because the tensors it checks are computed by the core in slot 0, which
happened to be correct. Throughput was 66 times lower and 27 jobs had
timed out. A single assertion does not catch this.

Two cores make it cheaper to test than three. If you bind the second
core before the first on your ROCK 4D, on your current kernel, I expect
the jobs that land on slot 0 to time out and your nine models to stop
decoding identically. If they do, that is the bug reproduced on a second
SoC by someone who is not me, which is worth more than my six rows.
If they do not, I have the cause wrong and I would like to know that -
please say so on the patch thread rather than here, so it lands where
b4 will pick it up.

The fix is on the list now:

  https://lore.kernel.org/dri-devel/20260905135612.7324-1-royalnet026@gmail.com/

It numbers the cores by their position among the core nodes in the
devicetree. It resolves that through dev->driver->of_match_table
rather than a compatible string, so it works both before and after your
12/14, which moves that enumeration to for_each_matching_node() and
renames the table. All six orders pass afterwards, 124 to 136 inf/s,
zero timeouts. It is a separate patch with Fixes: and Cc: stable, and
it goes out before v2 of the DVFS series.

One more thing your report is useful for: it is the same class as what
you found on RK3576 last week. Wrong result, no complaint from the
hardware. I am starting to think this driver needs a bit-exact check in
whatever test people run against it, because throughput alone will
happily report a healthy number while the output is garbage.

Igor
