Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CED7606A324
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 08:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=jahs-net.20260707.gappssmtp.com header.i=@jahs-net.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=Ej1F0YGy
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E3BF10F422;
	Tue,  3 Nov 2026 08:21:47 +0000 (UTC)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com
 [209.85.221.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7110310E72F
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 23:24:55 +0000 (UTC)
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-48e20ed3b9dso3167345f8f.2
 for <dri-devel@lists.freedesktop.org>; Mon, 02 Nov 2026 15:24:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=jahs-net.20260707.gappssmtp.com; s=20260707; t=1793661894; x=1794266694;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=BOJF5pQ3Y3qra0fVhUmJwEYQYKAdz/RQknbT5cdg1Y4=;
 b=Ej1F0YGyD4xUB2G4NttxbumzlHVqntpVyAcJaS9FyvS0S/BVFrIsf2E6yBnhlXj2vq
 Nui6I3p9Kb5wDmcujdrbaYd+voOiC/xZgZbATBrpX6gqPio9GNU76LGO/k7TBCfK1mN6
 /kfN59GONMY0ywp+VbHadByf/MnPW/NO3k9h26JL7k7vYBS5QJtkvTss4nVjGpp8X1fH
 AJLdEB7V8zDXrHJxE4ay7mUPHfgW600lOelr0tKYqCsERJ3Pje/W60N4FwOPYH6YBWNZ
 T5UymAk8NmUmtWAhpcZsYShIETTe2pCRS8lsj05toLUBfoz5geBa4j49FQMVbKZj0MiA
 BnBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793661894; x=1794266694;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=BOJF5pQ3Y3qra0fVhUmJwEYQYKAdz/RQknbT5cdg1Y4=;
 b=e9wVKSmxQs2TzxXvgJSBlxVIeQ9DHHy+veThSN3/1Ceg6No2uhf08crim6/w5qE18K
 Aes2+UlMPK5P8aLNbSrKwmM8kqlEtidYuE8bEc8H2jcqhy8U41M/kZuBIYek2j6nN/KD
 QChZZILW0Sx3MHBOGBGktL8lHQmeCA5czVj/VMYw3at78xU8qX8uaewS5rLljGARY6ts
 6FiJy2y2A738V4c3jbhYz0Sp3JlmwXKeCUl1LwXhSe1wMl+h+AMtXe6sPktNnKvu1nbL
 POvJAIDPKaJCsZMauiyQ0iduFD5l+2mnYN/En00HOaJtxiudpCIid9wKLcCTJwIs3JaU
 w7LQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxFek/yjdxysRvvjZ2++29KJAssbyDiy6ifOrKeKcQX29Cz/DNOc4eJQ1fJuo4CELYFlk8QKyiIr2w=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+MONvvvqyAmxESoemYfCE165blrAkbTC1XvOrA7kFN1lEod/Fh
 Jp+B7VfTnvsU0IeTYgYpxWjPupkjE8sqmK1RZsFgjmt2ep/22MbI5yH2jY2MbSdUdA==
X-Gm-Gg: AYBFou3MbFycHqnC5v0uzIBGYyGkscdugGM3+Aa3GSNOLwNkGydsVb8fAHB/wRq+iwd
 0ui7TNg4fG3cbvzYCew07JEXCk7UXDd7Ao9uchJFhumxbl0wGaQ/McP+jGBjF7otZ9+FzoHXIWU
 RiJrVLrPZucIGVJjD7T9AJzNtOLzI2vI+7YzktjX45zHQa0jOwSxhzc4APfCCTb1Hx1qYLcwxvp
 wqnogYo1k3Q+wB7OBu6M7bamGuFKrD7R/MYiEU/BmmLp/toBo2K1j1nkEVspwL0E7d2ZH4J/bY2
 MQyBLvKvNksDpK5WUo90VjSYasvJ9Pa6t5zIJzcXQEwD/1xKDrpx/6y9TVwJ1lilwndaby4ehHF
 jkskeKXApdcus1DS78nnwUqjJaHmX8Aw9jyOB+TGQ/ZSVp21xmiM14MeMIY7GBRuot1wtCBvRWs
 P35pQD7plrmKZApcH9//GKHPjsC2r8Kvrbc/9ZfunB+q8G9Re5R+Cjb6NnfdWEe0zmdXvlJrxNo
 Fqt5q1myZgPtujLsQh9yWlfPrhypAMOOjZY9rIwUKZ3rqojBOKoiwRc83Q4B/Jr6gGUsfZODE/G
 +VhpVe3QS6lRzqUxVQgi/K495A4gC5NSX5YYAcDFUNURcPNpamzWcAD/Wox9Bw==
X-Received: by 2002:adf:e19d:0:b0:48d:ffcb:28e1 with SMTP id
 ffacd0b85a97d-48e6e4f570dmr26032786f8f.11.1793661893544; 
 Mon, 02 Nov 2026 15:24:53 -0800 (PST)
Received: from mbp2019.tail53dac2.ts.net
 ([2a00:23cc:b5dc:701:a5b4:75a8:ede:9f7e])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71a4d4f9sm22522868f8f.2.2026.11.02.15.24.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 15:24:52 -0800 (PST)
From: James Skillen <jahs@jahs.net>
To: Andre Eikmeyer <dev@deq.rocks>
Cc: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 Kenneth Feng <kenneth.feng@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Jesse Zhang <Jesse.Zhang@amd.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] drm/amd/pm: use the VBIOS trained UCLK levels on the
 MacBookPro16, 1
Date: Mon,  2 Nov 2026 23:24:50 +0000
Message-ID: <20261102232450.61301-1-jahs@jahs.net>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261024162109.307247-1-dev@deq.rocks>
References: <20261024162109.307247-1-dev@deq.rocks>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 03 Nov 2026 08:21:45 +0000
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
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sat, 24 Oct 2026 18:21:09 +0200, Andre Eikmeyer wrote:
> The Radeon Pro 5300M and 5500M of the MacBookPro16,1 (Navi 14 boards
> 1002:7340/106b:0210 and 1002:7340/106b:020f) stop answering SMU messages
> as soon as UCLK switches into its third level.

This is the hang reported in drm/amd issue 6005, which has the
umc_info analysis and test results from both boards:

  https://gitlab.freedesktop.org/drm/amd/-/work_items/6005

Could v2 carry a Closes: tag for it?

I tested the patch on a MacBookPro16,1 with the Pro 5300M (1002:7340
rev 0x43, 106b:0210, VBIOS 113-D32207P1-019), on linux-t2 7.2.11 (Arch
v7.2.11-arch1 plus the t2linux patches) with this patch on top. The
userspace pp_table upload from the issue was disabled for these boots,
so the corrected levels came from the patch alone.

All at DPM auto unless noted:

 - both "UCLK level ..." lines at boot and again after every resume,
   pp_dpm_mclk 95/496/598/736
 - forced pp_dpm_mclk switches through every level transition, idle
   and under memtest_vulkan load (57 switches, every 3 s): all landed
 - UCLK pinned at level 2 (598 MHz): llama.cpp benchmark and 180 s of
   memtest_vulkan, no errors
 - 60 min soak of llama.cpp runs with idle gaps, and 30 min of normal
   desktop use with the soak running
 - 8 deep suspend/resume cycles (rtcwake, lid, systemctl suspend)

I ran these with the internal panel on the iGPU and again with the
Radeon driving it (apple-gmux force_igd=n). No "SMU: No response", GPU
reset, ring timeout or DC errors in any of them. With the stock driver,
level 2 hung within seconds.

For the runs with the Radeon on the panel I also had
amdgpu.dcdebugmask=0x1. That is for a separate DC issue (the MPC pipe
split on the 3072x1920 eDP plane makes DRAM clock change unsupported,
so UCLK stays at the top level). It is not related to this patch and
I will report it separately.

Tested-by: James Skillen <jahs@jahs.net> # MacBookPro16,1, Pro 5300M (106b:0210)

The testing above and this reply were prepared with help from
claude-opus-5-5; I have checked the results and the text.

Thanks,
James
