Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C55A1606A88C
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 08:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=charmerstraining.com header.i=@charmerstraining.com header.a=rsa-sha256 header.s=google header.b=Fs8MCu7D
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 644B310ED21;
	Mon, 16 Nov 2026 08:58:54 +0000 (UTC)
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com
 [209.85.216.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C767F10E047
 for <dri-devel@lists.freedesktop.org>; Sun, 15 Nov 2026 03:08:58 +0000 (UTC)
Received: by mail-pj1-f53.google.com with SMTP id
 98e67ed59e1d1-3b37951a397so438447a91.0
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 19:08:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=charmerstraining.com; s=google; t=1794712138; x=1795316938;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XYng5pWI4USr1KWNzMKOzbrap54zZqn6X9wIRG9MW9w=;
 b=Fs8MCu7D0gjMuj1sHIyiGeB+yo4NT8BwVelozmKk+CVi044Hzbo8qo9BxZtgYwDtii
 gp9ks5GY8JfXBNo9Y74xQQFiYHYBksbIZbxwqGSG7dfac57Xqzu6BWqatwPFvFNor9ga
 SGpG87RhvqHZ7hkoHa7nnG+i/IpoMddeJppr2U6Z6ZGub6qE2bAoFPfxOUOTDRhMEYmU
 tH8LgyJYLEY5HBhE+4YUZjinbBwAqndhk1UkNYpmx4F0a9XXZ4H7FdPG8BuzfX5FgJSS
 BzqaLfuDGURRSlW7s7gDOdJk1/YVbccfYXig6kEQffk2Nj5C5yZnBMrYFCAxKk1SMqIQ
 EIgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794712138; x=1795316938;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=XYng5pWI4USr1KWNzMKOzbrap54zZqn6X9wIRG9MW9w=;
 b=h0VKIr7irK0n695OVtcPSYWSHCSUuY+pDAJ79TRy/2c4J9M4bBDCUndFlddHaZvnsL
 AeQ5WB3XWFC9YjHYcmldEmES8oma7uXmQcKRmWD5v9aUX+hfFqZsMmtYmxdEAhu252d6
 cail/hqmqC0l7F72Uoeggf8sqT+Ciq4syUQzKnEzM3qosxrNb4EXnKN22xvrKpNJGgEh
 WeAao6p9AKg1ad573Ul5IFj9wL3G5Xt50UcwC2imXp8Xtxac/cnCZFm1DR5J8LbpJRCu
 iOysC6liqIJRpf2junGwTjSXw2m8k7HsaQXFtXNmdFu8+xz0Q9AwG0MYTVUcjtt3hvbt
 XSCA==
X-Forwarded-Encrypted: i=1;
 AL+hErE2O3a5krV3SLPk5trpTh4wSLODyzyzH14le95OGygofJJPYpcjkD+DTPk+dE59vOj7kfRqO0YJ4Mo=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8F8O0DM+Nz3WXjjVRkfR/4y3OSzwBy9/Zg+2cRZ9lIlrxcyOU+
 EUzW3oo0s0noUsr1yzhfi7+fcc8JnldSEfLQzL9lijdXSCX3LvHhGW6CJpq05s3VaLs=
X-Gm-Gg: AYBFou2NRrIAT2dLJX42qr+TdpBdBh+GzFIsyUbxGyh5IeijOk0u9rcrH2wIQkyGFes
 LHJAyvFu4jh04xQKIM9JnnpqvCpG7j0PVkBZ0PX3WMv6ym3Yr5J4nl00/RqpQUEM4MgMQ42O1mX
 tbzWkbNWdPXQftU6JBuKc/zt/Ba5au7m6fa68AzmpNJ5RItKAhDixK8g7rwd2qe1G0eylU5jnWD
 vKO3pLygQeSlpTvJZft/r4wf8kD/1vrhcMF5ypOrm7hdC4ITZJZh8eUBpbcdeUBQA4BcSPpB7s+
 MumIfC27e1ompvF2lPGGR7JhcR/Zki7y1kb5v2x/F9feTut2AuHqxlIX+dl/UjnfdIdDCh8T4Lq
 nGg9aBsXQnbRcXIUzdGUlqZerIJWlYl6S/9sE77ksobGDGJRPZWLw3pC4E+4Nn1CFLv86AhxemL
 t0wGYa8oc9GW9po1frjaGrm2MGfrmC7Dy6EdzrSkCrcutYYYOEU+S6QfZnH8k29OfRdVr7aTuiO
 O9qYw9vzPttHpjDefX7/f/GoCKGMVauZgrfr6tvl9p3f86p7JDRXQPS5HwCSWd8l2Ir9IBcTCFo
 nmYhmvUEbp4GMxtVGS0cHNp1xKfOdV8a+zrD3M8SXgs+db+LwFECug88krMRp8NKEYa8GglQcqg
 +TXyRpi1ea4X0ZgPj4efqjL70/4y6ACrzYwye2oUDggmne0eeLYMJ9N6DBjgxIffCZLNSshtDG8
 Q97F8GCfpmu4diUW3SLmWcyBcXwdOczJ8425Y03+cZJMYO0J4MBH/obQ==
X-Received: by 2002:a17:90b:4c49:b0:3ab:4f1:4f7e with SMTP id
 98e67ed59e1d1-3b1b0b8ef0fmr6902713a91.28.1794712138264; 
 Sat, 14 Nov 2026 19:08:58 -0800 (PST)
Received: from ip-192-168-20-3.ap-southeast-2.compute.internal
 (2403-5803-1750-0-d1fd-685c-f50c-5901.ip6.aussiebb.net.
 [2403:5803:1750:0:d1fd:685c:f50c:5901])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b197d32ea0sm15422530a91.15.2026.11.14.19.08.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 14 Nov 2026 19:08:57 -0800 (PST)
From: Ed Schofield <ed@charmerstraining.com>
To: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
Cc: Doitall <diainquiries@protonmail.com>, Andre Eikmeyer <dev@deq.rocks>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drm/amd/amdgpu: Add 5K Support for iMac20, 1 and iMac20,
 2
Date: Sun, 15 Nov 2026 14:08:48 +1100
Message-ID: <20261115030848.17705-1-ed@charmerstraining.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261113214721.9382-1-atharvatiwarilinuxdev@gmail.com>
References: <20261113214721.9382-1-atharvatiwarilinuxdev@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 16 Nov 2026 08:58:46 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Atharva,

Thanks for posting this. I've built v2 unchanged and tested it on my
iMac20,1 over the weekend (on 7.3 plus the t2linux patches).

It works well in normal use. I ran automated tests over 32 boots, 55
display off/on cycles and about 40 suspend/resume cycles, and both
halves of the panel came back at 2560x2880 and 10 bpc every time,
including from scaled modes.

However, your v2 hangs the GPU when the two halves are set to different
modes. This happened 3 times out of 3, just as with my very similar "r2"
variant that I described in [1].

To reproduce this, leave the left half (eDP) at 2560x2880, set the right
half (DP-1) to 2048x2304, which its EDID advertises, then start a
second program that uses the GPU. Each time the log showed:

  amdgpu: SMU: No response msg_reg: 2a resp_reg: 0
  amdgpu: Failed to disable gfxoff!
  (repeated four times, about 4 s apart)
  amdgpu: ring sdma1 timeout, signaled seq=17, emitted seq=19
  amdgpu: Ring sdma1 reset failed
  amdgpu: GPU reset begin!

The reset never finishes and the machine has to be rebooted. Since the
halves are separate connectors, anything that sets modes per connector
can trigger this.

I think the cause is the early "return true" in
resource_are_streams_timing_synchronizable(), which tells DC the two
streams are synchronized even when their timings differ. Taking the
shortcut only when the timings really match avoids the hang:

        if (stream1->ctx->dc->config.imac5K_support &&
            stream1->timing.h_total == stream2->timing.h_total &&
            stream1->timing.v_total == stream2->timing.v_total &&
            stream1->timing.pix_clk_100hz == stream2->timing.pix_clk_100hz &&
            ((stream1->signal == SIGNAL_TYPE_EDP && ...

With that check, the same test passed 9 times out of 9 on a kernel
("r3" [2]) that is otherwise very close to your v2, and the normal 5K
case still takes the shortcut. Without the check it failed 7 times out
of 7 before v2, so the result is consistent. Dropping the shortcut
altogether also passed (8 of 8, "r1" [3]).

Could you add that check in v3? I'm happy to retest quickly.

One note: my Tested-by and Signed-off-by tags were added before
I had seen or tested this version. I'm glad to give both for a version
with the check above. Please use ed@charmerstraining.com.

Thanks again for all your work on this!

Ed

[1] https://github.com/t2linux/wiki/issues/743#issuecomment-6588960822
[2] https://github.com/edschofield/linux-t2-patches/blob/7273823e425200e9f371e9272e02ebf9abb6f1c2/7003-amdgpu-add-support-for-5K.patch
[3] https://github.com/edschofield/linux-t2-patches/blob/5d3775923bf481c487ff96efc8fb3e24ecf8c9cd/7003-amdgpu-add-support-for-5K.patch
