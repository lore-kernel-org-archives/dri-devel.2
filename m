Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28A57C982CC
	for <dri-devel@archiver.kernel.org>; Sat, 19 Sep 2026 10:34:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED56110E0CF;
	Sat, 19 Sep 2026 10:34:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fWKBdkGp";
	dkim-atps=neutral
Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com
 [74.125.225.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB1D510E0CF
 for <dri-devel@lists.freedesktop.org>; Sat, 19 Sep 2026 10:34:46 +0000 (UTC)
Received: by mail-wr2-f12.google.com with SMTP id
 ffacd0b85a97d-482e1b55da9so161256f8f.2
 for <dri-devel@lists.freedesktop.org>; Sat, 19 Sep 2026 03:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789814085; x=1790418885; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Q4IqvQL/KqjQznpd6jaMZqdfn/Z26HNbimnHqtbc/0c=;
 b=fWKBdkGp/jM32CVYDXBNkxXiCJqa2C+v2wJz2otxMY0mQAqN9LunELMmA4p6Lfuv9b
 ufsgnZqbEV/IF2b2zYXW3EeuVNEs0n07nacgtM2BFaBwvvNjysQjB21VwKjeszM21hHH
 Lygp7MsttTi6PDimucCdni4A2eebus0qlDOst5QSjikgGMBCtmQpi8S4q0A8Wx2u3i7K
 2JCEpAlH6CZv8KMhrYBgjjTZ17PbYCsAzC3Wd0ca8KRUAAq+MY2aueDlb2hfKez12Xxb
 bxJ6BveNgwk6gxa72BPVmURmLD4zlmYatk7hgVmnPp/rIAr3ZnhIgueMcJ4SonNA+rjB
 D0Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789814085; x=1790418885;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Q4IqvQL/KqjQznpd6jaMZqdfn/Z26HNbimnHqtbc/0c=;
 b=bekvqt59xMzzjStrYL+8Gki4Qs7qUxgNNwWzZPPG/L/lumId11BzJkvK0NqheqQiWs
 6NSUl5fsvUxDkrS6NDAJ/NJzl1Ft+N55rRglraQAzyMuK6CWVxR4FwzkSjPePZ73dzqZ
 vnItbxv+FY+IGYaSvPQJ8wwTXbh1Ek3e4LRZsDe2k0KX7ZPJbb92tcV7JyLi08HWj4sU
 q4/iGEuRlHBmn7M97xD15oyYox/EyQreA7Uk6V1crYjE+3zcy1kqr9jSKIvnH6s0T9Ll
 V1uf4bZ2ca8jq4omxf1UAGxuALYwZN/l4sBLEvkar5fJEpV6DD93gGOY2W4c8cRbG8C3
 IxDQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxEXEA89OB/fRsyHMadeKi9DU4oJ/sy/6wGEj0vgKOLBxk90QEOfLM/997YitOT7KloFMdMDo+TUvI=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lFzvIxqSW/Z9enFjwhk+0oeutbp4Pxk0pFJaosRY817VG6WgVu
 Zn/LMaE1eH6RTmEt3dkYUFNcwDLlBq263kUzEPKN8+v6RwBjVg8gy0BN
X-Gm-Gg: AYBFou3iNerRBfvzhKhHAe7wO+8kDbHO67izEujfA6F9npvjJzg4VSU285Jb1rlHFhg
 4AC2MG256axYfjFkAGXgpsLKR6EDFMiXGa3kyPiQKlEhF/xNFgEThvRqI3e2CUFxxmDotj3hyzJ
 NkNWbNBe/HOjmeXuQ8ZTEgMhLGJoqkLMzYuXv8EhxsbSyY0Pnf3lrDI9XArtQsjAWTb3qckixJV
 KMTpb3dOYCMzd6GOsUpAdRLHeshUfWDV/Xyr4rGyaA1X50zaN9CXVzQ6zDONgnDihL+i0ER3gJf
 M32eAMlYtnDj78W/I+MCoFJN9AvYG5DSoG+1RzuSo+q2JbyGU5veT5kP0SgycOPf51z38t2S+hl
 A6pCWl9IK+4v3kuXvYVA+HaCTXYThrrkkxGmMi0w1I2Kex5f+Q5NnCOSluNpBkuVX3JDic1o+Y4
 BNl0L2+wEEFjHe/xMEuaZqpdSJngCKzfU+x1S4hqceUBsc0IX122Oqtp8ZD4eWlUsFXmWbedtGL
 ALGVA7vD8LT3FDVOOJlFi9TtCObMdpm/FH4pzOAYYyBTUSUaYgo08PkLwUV4hD1uQb8Os6vZbN9
 TZp0EfOIvycPxNg=
X-Received: by 2002:a05:600c:4708:b0:49e:745d:5768 with SMTP id
 5b1f17b1804b1-49fc7b9a4f8mr55647955e9.0.1789814084786; 
 Sat, 19 Sep 2026 03:34:44 -0700 (PDT)
Received: from OrangePi5-Plus.BB-HOME
 (20014C4E1B8FAC008BB5F187970BF937.dsl.pool.telekom.hu.
 [2001:4c4e:1b8f:ac00:8bb5:f187:970b:f937])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fcd03fe55sm77203745e9.2.2026.09.19.03.34.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Sep 2026 03:34:44 -0700 (PDT)
From: Igor Paunovic <royalnet026@gmail.com>
To: Jiaxing Hu <gahing@gahingwoo.com>
Cc: Igor Paunovic <royalnet026@gmail.com>,
 Tomeu Vizoso <tomeu@tomeuvizoso.net>, linux-rockchip@lists.infradead.org,
 dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v13 03/14] accel/rocket: wait for a running IRQ handler
 before resetting a core
Date: Sat, 19 Sep 2026 12:34:22 +0200
Message-ID: <20260919103422.148834-1-royalnet026@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260919091725.8981-1-gahing@gahingwoo.com>
References: <20260915104328.45901-1-gahing@gahingwoo.com>
 <20260915104328.45901-4-gahing@gahingwoo.com>
 <20260916132824.13527-1-royalnet026@gmail.com>
 <20260919091725.8981-1-gahing@gahingwoo.com>
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

On Sat, Sep 19, 2026 at 09:17:25PM +1200, Jiaxing Hu wrote:
> I read the tally as 8 of the 126 scored inferences missing on all 48
> channels across the three runs, and 5 of those, in the two runs you
> traced, sitting on the 5 -ECANCELED completions.

Nested that way, yes. One correction: six runs, three per arm. Five
of the eight zeros are on 2+3 and three on 2+3+4. In the two traced
runs the -ECANCELED completions sit on exactly the inferences that
scored 0/48 there: rounds 1, 4, 8 and the one after suspend/resume
on 2+3, round 7 on 2+3+4. The other three zeros are in runs without
the kprobe.

After that mail, on the evening of 16 September, I reached the other
path. A 1x1 convolution gets there when the input, not the weights,
overflows the CBUF: 80x80x64 in, 48 out, so rkt_split_tasks() splits
on input rows and rkt_ml_subgraph_invoke() submits one job with
task_count 2 (rows 0-63 and 64-79). A graph whose weights do not fit
goes the other way: reuse_weights_cbuf is false and each task becomes
its own one-task job, back on the scheduler thread.

Same board and config (JOB_TIMEOUT_MS=2, PROVE_LOCKING,
DEBUG_ATOMIC_SLEEP), the induced-reset protocol at 60 inferences a
run. On 2+3: five runs, 310 inferences, 180 timeouts, one of the runs
with a 32-output variant that splits the same way. On 2+3+4: three
runs, 186 inferences, 181 timeouts. In the three traced runs on 2+3,
24 of 110 timeouts cut into a job after the IRQ thread had submitted
its next task (9, 9 and 6); in the one traced run on 2+3+4, 11 of
61. No lockdep report, warning or MMU fault in either boot, and
debug_locks 1 at the end of every run.

So the lock scope ran with the IRQ thread submitting tasks, but this
does not show the race is closed: the window in hw_submit() is
microseconds, one reset began while the IRQ thread was in it (in the
32-output run), and waiting on job_lock itself was not instrumented.

One result bears on 4/14. Without it the core stayed active after
every cancelled job (113 of 113) and no cancelled job was followed by
another (0 of 109). With it the core suspended after each (122 of
122) and 84 of 120 cancelled jobs were followed by another, the next
job waiting for resume against the same 2 ms. That is the timeout
feeding itself, not a defect, and it is why 181 of 186 inferences
timed out on that arm against 180 of 310. Core 0, one client. If
4/14 changes shape in v14 I will re-run that arm, with the two-task
job in it.

Scripts, counting and this draft were prepared with an LLM assistant;
I ran the tests, and every number came from the raw files of each run.

Regards,
Igor
