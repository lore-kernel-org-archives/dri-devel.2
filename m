Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D48286082BD2
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 09:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=jahs-net.20260707.gappssmtp.com header.i=@jahs-net.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=EsPShtvr
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 45F3710E87D;
	Mon,  9 Nov 2026 09:31:15 +0000 (UTC)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 236D010E16B
 for <dri-devel@lists.freedesktop.org>; Sun,  8 Nov 2026 22:15:44 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4a5177d78c7so2159945e9.2
 for <dri-devel@lists.freedesktop.org>; Sun, 08 Nov 2026 14:15:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=jahs-net.20260707.gappssmtp.com; s=20260707; t=1794176142; x=1794780942;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Uvr+F/2JK1AaGLCznMP5hvSKtAyjP1MI/tlzlJAmTmQ=;
 b=EsPShtvrddRy4MozG9bxhIGQvspAT9/aY6Uyni0mAGtrDBvE8aSMbZhb3/C4MZ30Vq
 IIe87UbEloT+pecaweaW3Dw2zr6V5Shv6nW5Yl5Ggwq9+oU32kS9RrrUIpuz4jnL7xOK
 aswkvH+v9Y/uL0p1at5wCc43/JSprK781fy6AozS58EVHaZCQLtPqHZGCgCGigslrlND
 MU+EZnuVsdyIEdD6M1t4UJl0gm7lXS+R4j9ZL1p7XaPz4PffgfDsBmP3yWS2O7gVKdz0
 TLGgk/5TAkGUzfHk9LYhw23oDkof7brq9x9dna3g82BCZVR0qdwGAKYDhZ/odPkzYSmr
 u9gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794176142; x=1794780942;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Uvr+F/2JK1AaGLCznMP5hvSKtAyjP1MI/tlzlJAmTmQ=;
 b=fc6zpeAiqvDKbcWOUFQXtUH1yPY06rJnBCdDfkMvoRBQGFJ1Qa9w5TZb/V4qBidAGK
 Ab62KjPHVfDbzTNcEcWxLRjnbEyp+NzGnQqNiuqCJOBw/KqaZMzCoEt1EPoBIVW+KXB7
 8SdF7HMX73Dwr+lz/1m2wKVongfERJfpqgO/ajMz49uYnwywz4lzi7wQ8Lvth1DiEHOW
 4yQjkCsa5CoozyHSEdSr6m4JifIvL0kp7DXtXU7wnDzVi+2NW2A+y9YeTAmlqFxFJsDj
 KdvIJFGjfVXi1V6XhiKICml47aKV21mfPADhqQSqRLlEyxyJRxOtUjBBorgG6KF/398b
 YbpQ==
X-Forwarded-Encrypted: i=1;
 AL+hErFKv6qlsN2vs42UrdYV/BOso7oipoqRJNPBnsAuh+9mcHF5fN+tCIKpy3WzUTqCcMV5Z6rGJRuYzaA=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8eEUO5mwnLluezE1I/2hmlUaI8OgJ00HuY61eTUMP0RCFy9mGU
 +I7UtdUWf7KPTQfizlWKJFgB/UkTrfcaSIBK+smLQ0O9roXyt47zygJfnr40cvutdg==
X-Gm-Gg: AYBFou0GdwfoqWT6yBuSw8ob3+TLcqNF5GSVa2PK7cmHHWr9yD5gAQQ23hrtJoPnqWQ
 JI0GRmi89E8NoBcEFu+yLa4elRyVWYT8WI3l021WnayK4BLL8IVMAa0YdUvr1xHpmTzqZLPFG2V
 aXXnIJXJObh2lxR7zHTpR3nxIe7tju+Nxa/1BybI6dIWCDQ6g141nZHKVp5BjC43Mm32Lzvo01b
 lLnRg0Ifpm/yC3KhNVZWX7LKjEXA4m7smyESjXelrbVmYEYdN2rMRDWYMUQm3/+1I1OPubDD3KT
 SZcxgZUN43E+Q900VBTvvNpEDz3CPKr4Kz+e2WK99IwiBG4Im9GbyqBn9A3aM/lFpoVXhwnWHOY
 fswpRudn86ex0MLFM93EVjfvFmAPVwhdOZFzU26ZPHWq45uHOy66FHGSn63WNEGJoSfH2gbgt49
 QeaN1hdnSzy9kvmHYBuPXwrv4IxcPIr3+yZFur4F02DXgGbhDe8Ax1bjssEjV8pF/AY/Pbk4MXe
 RqZ+eXnfbHdjC8ZoVH5rpL4ZOlcSAWhZ/UMhQ35O6KdkcHEaY5OjBpJlRT1l8oz3SGqjF2jmeOn
 v4Ma4BTRjgMVzidOEvfXd1LnBMYKRas7YhX1sZIy
X-Received: by 2002:a05:600c:4e87:b0:4a1:e69d:90e8 with SMTP id
 5b1f17b1804b1-4b963c8e6e7mr40922425e9.22.1794176141294; 
 Sun, 08 Nov 2026 14:15:41 -0800 (PST)
Received: from mbp2019.tail53dac2.ts.net
 ([2a00:23cc:b5dc:701:a5b4:75a8:ede:9f7e])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b7bb101537sm76735525e9.0.2026.11.08.14.15.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Nov 2026 14:15:40 -0800 (PST)
From: James Skillen <jahs@jahs.net>
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Andre Eikmeyer <dev@deq.rocks>,
 Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>,
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 Kenneth Feng <kenneth.feng@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Jesse Zhang <Jesse.Zhang@amd.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] drm/amd/pm: use the VBIOS trained UCLK levels on the
 MacBookPro16, 1
Date: Sun,  8 Nov 2026 22:15:38 +0000
Message-ID: <20261108221538.32132-1-jahs@jahs.net>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <CADnq5_P5Ly4Pb8WqPaN28yDHG8jSjoEHAfDKAqSgTrSj14Pr1Q@mail.gmail.com>
References: <20261024162109.307247-1-dev@deq.rocks>
 <20261102232450.61301-1-jahs@jahs.net>
 <CADnq5_P5Ly4Pb8WqPaN28yDHG8jSjoEHAfDKAqSgTrSj14Pr1Q@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 09 Nov 2026 09:31:09 +0000
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
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Alex,

On Tue, 3 Nov 2026 09:35:29 -0500, Alex Deucher wrote:
> Can you try this patch instead:
> https://patchwork.freedesktop.org/patch/765668/?series=174386&rev=2

Many thanks for following this up, and for checking with the Windows
team.

I tested v5 ("drm/amd/pm: defer UCLK DPM on selected Apple Navi
GPUs") on the same MacBookPro16,1 (Pro 5300M, 1002:7340 rev 0x43,
106b:0210, VBIOS 113-D32207P1-019). Kernel 7.3.3 plus the t2linux
patches, v5 applied unmodified. Its navi10_ppt.c differs from
amd-staging-drm-next 178d00b only in the error returns of
navi10_force_clk_levels ("return 0" vs "return ret"); none of these
tests took an error path there. Panel on the Radeon, dcdebugmask=0x1
as before, and SMU messages logged with
amdgpu.dyndbg="file smu_cmn.c +p".

v5 works as described: UCLK is left out of the allowed mask at init
(SetAllowedFeaturesMaskLow 0xa7dfbfb3, stock 0xa7dfbfbb) and enabled
with EnableSmuFeaturesLow(0x8) about 1.2 s after DC init. It boots
cleanly, as stock does on this board. It does not change the UCLK
levels, and the hang is in level 2:

                     UCLK levels       UCLK level 2 pinned at idle,
                     (MHz)             ~5 min after boot
  stock 7.3.3        95/496/736/750    SMU no response after 3.4 s,
                                       GPU reset fails, machine hangs
  v5                 95/496/736/750    SMU no response after 3.5 s,
                                       same
  v5 + trained       95/496/598/736    ok, also under load (below)
  levels

"Machine hangs": a heartbeat sent over the network every 5 s stopped
within ~10 s of the failed GPU reset in both runs, so it was the whole
machine, not only the display.

v5, SMU messages around the pin:

  [311.750451] smu send message: SetSoftMaxByFreq(27), resp: 0x00000001
               in params:000202e0
  [311.750635] smu send message: SetSoftMinByFreq(26), resp: 0x00000001
               in params:000202e0
  [315.231058] SMU: No response msg_reg: 12 resp_reg: 0

For the last row the levels came from a pp_table upload with the
umc_info training points, the values Andre's patch sets in the
driver. v5's late enable ran again after the SMU restart. Forced
switches through every level transition at idle, level 2 pinned under
llama.cpp and memtest_vulkan, memtest_vulkan with forced switches
every 3 s, and a load run at DPM auto all passed, with no SMU or ring
errors. So on this board v5 and the corrected levels work together.

The root cause is in the board's VBIOS: its pptable UCLK levels
(736/750 MHz) don't match the umc_info training points (598/736 MHz).
A corrected VBIOS would be the clean fix; failing that, a driver check
that uses umc_info when the two disagree (a no-op on a correct VBIOS)
seems the practical one.

The testing above and this reply were prepared with help from
claude-opus-5-5; I have checked the results and the text.

Kind regards,
James
