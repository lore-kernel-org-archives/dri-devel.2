Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07DC1C5DF87
	for <dri-devel@archiver.kernel.org>; Thu, 20 Aug 2026 22:53:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E013E10F1D0;
	Thu, 20 Aug 2026 22:53:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ferrisoft-com.20251104.gappssmtp.com header.i=@ferrisoft-com.20251104.gappssmtp.com header.b="po2OV0+t";
	dkim-atps=neutral
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com
 [209.85.208.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 45AF910E116
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 13:44:32 +0000 (UTC)
Received: by mail-ed1-f45.google.com with SMTP id
 4fb4d7f45d1cf-698ae09e356so3779485a12.2
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 06:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ferrisoft-com.20251104.gappssmtp.com; s=20251104; t=1787233471; x=1787838271;
 darn=lists.freedesktop.org; 
 h=content-type:mime-version:date:message-id:subject:cc:to:from:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=gpygo29h7AxRRVUfGlZ5f0maeaHqpMwX6cqMH9s1eBE=;
 b=po2OV0+taONX5UQ4xAK5sQBhg5piticEK5Dr7zVazfD3w96yTX8oy1OmUC4ycUy3Z8
 GF4UopPmcQNrZCDyy5xuSbiJEj9TXLK9d+A9mcJ4TffhqafYCErbSG5n7OBYhkyUaYdX
 f1RIOOJA0pLA/j3P0ThRBVdu1P8aUictNtY0sFe02Txt3PnyYqw7SLit2Ozmo3xLAMQU
 Zoz1D65dYpfTsNaDN4Q3Wh4t4NGrF5HBygvgIyaKXLiN167bbSXKlkkAjJwwvpMwGg5A
 wDOoCdZj8dEHtjC8e4fAid29gPJOTr82r7igsQO0MscJkpTmEZ3uf3QTESgAYnYa/4/G
 UMLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787233471; x=1787838271;
 h=content-type:mime-version:date:message-id:subject:cc:to:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=gpygo29h7AxRRVUfGlZ5f0maeaHqpMwX6cqMH9s1eBE=;
 b=bGSoNyl6YG5CI3OpirH/aylY0oqWajHtOxLxWs1A+o14uRa9FKS0ddZLauQPfH69v/
 GE1lqYuF0OGP8Eq1YK+BNbPxGQIzi6DXGG7l/9ZvbvANBW03JfEp+Wkflie+dVBvXQ7J
 D+eZRdqZ9vXZdwEtvYgTVwGilvri0XKNGEYuM3O1pNJ3kFF7CWKhzsH98OW51nfqQ6cQ
 F9xh4X4h92wPGNXr67yw+lb+iRvZZEf3JUb99RAe8WMeFahZWGBt45Kp254eUSZcWau9
 nrybs535C5o++dk4a0tC8SL+ih+AbPnE6wLWc/vznG0vJUWFgvSZJsPzPTyAUkNSbk1D
 9eZw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqN/l4og6OIZhYtyhjmhoWfP0ZpUJRRQQxb+7cx4FZSx/dohXlMzDvpd9UHncRoB5pdCrP268glneY=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lSo9Vc1KsUto+ro26GId98i4elr/GyaT4xEKfrcKvR/R87F/l2
 TqItxoey03HGawN3xSaaXvu9CTehhgaG5iUhKVZltml3cUcUVTtWMA0FMGOnbxK7tce/
X-Gm-Gg: AR+sD13X9yQO/0f1RQMzeZBkcooQMjGC216EgW/6rcX5UUjkQUzshLbQTSdz7Eix2jk
 Lhcy2f/KaBfBcwLm3nmreR37Kqps7TyZP1IXHQNT/8S8fXITw7yE2kxBf5TxsvJRWEoMMJR0QDL
 9tc88YyXCxiIVFezUUx6GSPZP+AKv+eE0tmiWTZiZPnHwT7zLhBZlItis9/JL5bLJEf4MAsudM6
 mokiGbCvX0+OvHxi5X5atH8/0PNlvUrKiO2/qToyorEukT+RcT9/lk5o22rPcLEio5v5yNVnWTL
 Cq30GOE5hNOrXW15y7SbK3sFjh/7seOC2z2Jc9+NMyvrFAHwS4abKCxvI0FDhP6hCKzgye09Mdw
 6YTxNUO3OkB3kHEtnAz3pT4AEVfzFK3xdBLjq9yzujYqSvBsOVtwwyV0wnkkiL/HMAvML1zICij
 +8Zlf8EFFCJ7TThgnmptMv7plaCdreuThHN37jaJNaMAcEE3K3Aq8bKmV9mzVxg6NL1veQBsAcU
 y8SnTJRXeQG7Q==
X-Received: by 2002:a05:6402:2403:b0:6a3:e813:8457 with SMTP id
 4fb4d7f45d1cf-6a4032f9c61mr9541576a12.12.1787233470427; 
 Thu, 20 Aug 2026 06:44:30 -0700 (PDT)
Received: from mail-0004.txt (45-11-61-69.ip4.greenlan.pl. [45.11.61.69])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a3ff0c3491sm2182899a12.10.2026.08.20.06.44.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 06:44:29 -0700 (PDT)
From: Greg Ociepka <greg@ferrisoft.com>
To: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org
Cc: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>
Subject: drm/msm: unrecoverable a8xx hang-recovery loop on Glymur ("cx gdsc
 didn't collapse"); killing the offending client does not stop the loop
Message-ID: <20260820154428.1278@ferrisoft.com>
Date: Thu, 20 Aug 2026 15:44:28 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailman-Approved-At: Thu, 20 Aug 2026 22:53:16 +0000
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

Hi,

On an ASUS Zenbook A16 (UX3607OA, Snapdragon X2 Elite Extreme "Glymur", Adreno GPU, chip id 0x44070041) we are hitting an unrecoverable GPU recovery loop that, once triggered, can only be cleared by a full reboot.

Environment:
- kernel: linux-next next-20260730, plus a handful of local patches for this laptop (USB wakeup-source/dma-coherent DTS, CPU thermal trips, an eDP link-training retry tweak and a DP debug-print ratelimit); none of them touch the GPU, GMU, GDSC or GPU clock paths
- Mesa 26.1.5 (freedreno, a8xx)
- GMU firmware v5.2.38 (qcom/gen80100_gmu.bin) and gen80100_sqe.fw from linux-firmware
- niri (smithay-based Wayland compositor), ordinary desktop clients

Symptom: a regular client (rotating across sessions: chromium, firefox, Xwayland, thunderbird) eventually triggers a GPU fault. From that point recovery loops at roughly 1 Hz; every iteration logs:

  adreno 3d00000.gpu: [drm:a8xx_irq [msm]] *ERROR* gpu fault ring 2 fence 28f9c status 00880005 gfx_status 00880004
  adreno 3d00000.gpu: [drm:a8xx_irq [msm]] *ERROR* BR: status 00880004 rb 0002/0078 ib1 0000000000000000/0000 ib2 0000000000000000/0000 ib3 0000000000000000/0000
  adreno 3d00000.gpu: [drm:a8xx_irq [msm]] *ERROR* BV: status 00880004 rb 0000/0078 ib1 0000000000000000/0000 ib2 0000000000000000/0000 ib3 0000000000000000/0000
  msm_dpu ae01000.display-controller: [drm:recover_worker [msm]] *ERROR* 44070041: hangcheck recover!
  msm_dpu ae01000.display-controller: [drm:recover_worker [msm]] *ERROR* 44070041: offending task: <client>
  adreno 3d00000.gpu: [drm:a8xx_recover [msm]] *ERROR* cx gdsc didn't collapse

Observations across four separate incidents (2026-08-09 to 2026-08-20; longest 60+ minutes; worst measured rate 161 recover cycles in 5 minutes):

1. The reported offending client differs between incidents and can change within a single incident.
2. Killing the offending client does not stop the loop. We verified this explicitly: after SIGTERM-ing the reported victim the loop continued at an unchanged rate within seconds, and the next client that submitted work became the new "offending task". The corrupted state evidently survives in hardware/firmware rather than in the client.
3. The loop never converges on its own; only a full reboot restores the GPU. While it runs, the victim's surface stays black and the whole desktop degrades, since every recovery stalls the GPU.
4. Onset correlates with many clients creating GPU contexts in parallel, e.g. right after a session restore spawns half a dozen applications at once.

Since every iteration reports "cx gdsc didn't collapse", the recovery path apparently never succeeds in power-cycling the GPU, which would explain why the fault state persists across recovery attempts. Two questions this raises:

- Is the CX GDSC on Glymur shared with, or kept up by, other consumers (the display path, for instance) so that it cannot collapse while the panel is active - which would make this recovery flow structurally ineffective on this SoC?
- Or does gen8/GMU require a different stop/reset sequence before the collapse is attempted?

We are happy to test patches, run instrumented builds, and provide full journals or devcoredumps - the machine reproduces this every couple of days under normal desktop use.

Thanks,
Greg Ociepka

