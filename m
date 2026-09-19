Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A4CBC982D7
	for <dri-devel@archiver.kernel.org>; Sat, 19 Sep 2026 09:17:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6DF8510E12E;
	Sat, 19 Sep 2026 09:17:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gahingwoo.com header.i=@gahingwoo.com header.b="V7xYi6Vq";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="WllbAUC/";
	dkim-atps=neutral
Received: from flow-b7-smtp.messagingengine.com
 (flow-b7-smtp.messagingengine.com [202.12.124.142])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B31EF10E12E
 for <dri-devel@lists.freedesktop.org>; Sat, 19 Sep 2026 09:17:30 +0000 (UTC)
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
 by mailflow.stl.internal (Postfix) with ESMTP id 2E83A13000F1;
 Sat, 19 Sep 2026 05:17:30 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-07.internal (MEProxy); Sat, 19 Sep 2026 05:17:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm3;
 t=1789809450; x=1789816650; bh=xS6bBHLfuFT7HjgN2gMfBLJE1qglzlVT
 YcLwS6iUmP0=; b=V7xYi6VqcHvBAy0i6dCL8T7IeekInLDcwwjdDASoCz3J9jls
 MmPmx9ye0OLsuY+U7jxfx21RH6DUCKZURrcaHyptffUrXEwo6cQJpzYaXPZGCFK0
 XBBXcQEuUVVex7/hRwyj0PL7UFqdQdTsMSZzl30ttfiQRQ8eg5rrK/8UcTu3VuN0
 KF01gywEJFFZT7mih6x6iLO+1kT62x1YPskGQALoy3Gn4yoKGr78j0JM/9BFQH/C
 CohgHPWhrlMI4Yu1Y6BVxkK+pJELXyOHi7yFhqLHSeVLeYgFPjdC/b63VUf43f8M
 2pLFudkRMkjxHnewq0cDb2ZX9RciEBz8jykakw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1789809450; x=
 1789816650; bh=xS6bBHLfuFT7HjgN2gMfBLJE1qglzlVTYcLwS6iUmP0=; b=W
 llbAUC/OJO3h1RYyouRsVv64CfuglDbE260s+FRmBhJl6XtWmjc/m2KmjiUsBhzS
 59UsiolJLc9pNpGnGUXlOn/ij+AgVYtWzo+4K3lWJcIqL+TnkzLNlbaAoh34/q4V
 fWSYpxRMCvFDTRk5v9KqK423BrGPwxhhVXE4UIbhMNsEKIij4NUigJkXfyDVbvtC
 aGPxfkq5iJI/ZaEIkdjLv7LNYD6Oawwl1yVkPbjZVJ8Qw0wFL1w5YJ48rrliTAsa
 LVS9EIHkwewh7BgfiUzhp8jsE2Pj3RmYHzHeDxcE6C8Wd2r/U+tgVQDnrS3c9Kkt
 1xqupBaJ76JCS8p3w29dQ==
X-ME-Sender: <xms:KVOuaudKKZQIi6HaAPJkbT_li-nvKc6IhKHCKIbU99MqTdmSg7p8jw>
 <xme:KVOuapuYdROEhr979iTLTYyudfeh5paNtKh5gHeaKjeQcl85Q7mDr_8G46vzkwwjP
 lnoIfdqF73tl4OOpD3tXdaasUpxeMEm1UGeupGUg1M4mjbA9TfhDjEd>
X-ME-Received: <xmr:KVOuavn4Jj4J-hW1b7XZgXOf5uiTKeO3dpt6ot_97FwgjSSK8gdrs21YlUQiFImLJi2IUaRJaw>
X-ME-Proxy-Cause: dmFkZTF8AEmYTKduMtxQX2nHEusb4dOd0AV9J8+Ptz87VDRwjypJqe8EHK9LxaOYeNwpZ+
 q+zxyPi61z0mmDTdFF+9z4ujZ7EMA78y3Wjw0mWeoWJb86vQ1Z5vF4rcnz+Z3qIVxa6DkA
 iZA3M7PRfnQc9F+zccZ4pA1bjHcNeLew2O8/KnSnZ/fRkyJzg1wragssbAKXBSUmQgMd0E
 OVeHqSd6bfS2k5TVsy58Aq98PMvNu4agfrXT2ppZK2Aqlt8vGV5ODIBIHeUOZI/ZqFcxWa
 /jSTgCCLJu6CQySEaQYR5mY9jUMTOK9G9Rk7Gvqt0reEJnDJY+f+rMqnIHLKD3Y6e+bfLA
 81stsRG++DeqzZVrymWXB/3mugXKRkpaZQCSUqn6vph/4Bar6np1yzenAEDBvGi8eleaUa
 cgB0hCVy/t8APtl7F3E5H9lnwUVV2xtsRtDFO9P9XiXtMMmX8C7e+tKRvrI1zdvsq4EHdX
 ZyGU/d7AvHa/wCZnn3hWzCsuJ8Yk8f4lKa/TOJiTFtHZESzasVL923YMyDzzv/HlExtBFX
 nsHcES3LVDwJ3LfZlot9yoJ88boYTfFATmHh+TkCC2exYcwB5fmtU/ke50ug/8n73DnQwu
 933qrBqycT+Nb0ndZwdtxqUgH6GFyGG4vJ1WI1mAteNJpf0eat+FS/Dzri1g
X-ME-Proxy: <xmx:KVOuarwR0PEU2U-IKMQhHaReHoVHAlc4EWBlURXyCOzAXwD7uIftkg>
 <xmx:KVOuahO9D53i2jhHe9YdIxMBcHBHCSCNlQIkAzLqusJaD4uczH4LCA>
 <xmx:KVOuanrUh8KDtbZgSIwsMEH69jd1p6sdRHagclExjihcafCtELWZ5w>
 <xmx:KVOuaqFu9tHqIdswip8FM-zLNtLpPYMGlRE-Ubv9vQwLxJsn0xV5VA>
 <xmx:KlOuav3Fka1H79c5R0WAP1_bz-eQt3F4yb1_gJ05LxEr1If1TZQutH2B>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 19 Sep 2026 05:17:28 -0400 (EDT)
From: Jiaxing Hu <gahing@gahingwoo.com>
To: royalnet026@gmail.com
Cc: tomeu@tomeuvizoso.net, linux-rockchip@lists.infradead.org,
 dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v13 03/14] accel/rocket: wait for a running IRQ handler
 before resetting a core
Date: Sat, 19 Sep 2026 21:17:25 +1200
Message-ID: <20260919091725.8981-1-gahing@gahingwoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260916132824.13527-1-royalnet026@gmail.com>
References: <20260915104328.45901-1-gahing@gahingwoo.com>
 <20260915104328.45901-4-gahing@gahingwoo.com>
 <20260916132824.13527-1-royalnet026@gmail.com>
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

Thank you for re-running it on the changed form. The tag carries to v14
with your comment unchanged.

The limit you put on it is sharper than the one the cover put on it, and
v14 will say yours instead of mine. A single 1x1 convolution is a
one-task job, so hw_submit() never runs from the IRQ thread and
drm_sched_stop() always fences it. That is the path the race needs. So
what your runs establish is that the lock scope adds no lockdep report,
no MMU fault and no hang on the path they do reach, and not that it
closes anything. The cover said the fix was an argument from the code;
your sentence says which part of the code the test never visited, which
is the useful half.

So that I am quoting you correctly: I read the tally as 8 of the 126
scored inferences missing on all 48 channels across the three runs, and
5 of those, in the two runs you traced, sitting on the 5 -ECANCELED
completions. Correct me if the 8 and the 5 are not nested that way.

If you ever want to reach the other path, it needs a job with more than
one task. On the Mesa side that is a graph whose weights do not fit the
CBUF: rkt_ml_subgraph_invoke() then submits one job per task rather than
one per operation, and MobileNet comes out as 34 tasks here. A 1x1
convolution will be one task whatever else changes.

And the mirror of that, from this end, since it is the reason your runs
are the only ones there are. JOB_TIMEOUT_MS=2 does not survive on this
RK3576. Running rocket_reset() at that rate takes the board's PMIC down
through its I2C:

  rk3x-i2c 2ac40000.i2c: irq in STATE_IDLE

a big-core voltage transition then fails with -ETIMEDOUT and two CPUs
stop answering an NMI. I bisected it across four boots against a clean
next-20260914 and against the rail change on its own: it is the timeout
constant, not this series and not the fourteen patches. Whether that is
an RK3576 property or this board's PMIC I cannot say from one board. It
is why the RK3576 side of 2/14, 3/14 and 4/14 has no induced-reset
evidence at all.

4/14 may well change shape in v14, since the asynchronous put has a
[High] on it again and the fix would move the put out from under
job_lock. I will say so in the cover if it does, and take you up on the
re-run.

Regards,
Jiaxing
