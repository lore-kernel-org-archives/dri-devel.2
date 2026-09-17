Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2CA3C982D2
	for <dri-devel@archiver.kernel.org>; Fri, 18 Sep 2026 07:11:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D23DE10F1F9;
	Fri, 18 Sep 2026 07:11:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BdEeoGC1";
	dkim-atps=neutral
Received: from mail-vs2-f29.google.com (mail-vs2-f29.google.com
 [74.125.227.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A1B110E0AE
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 16:36:03 +0000 (UTC)
Received: by mail-vs2-f29.google.com with SMTP id
 71dfb90a1353d-5c67e5059f9so494203e0c.2
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 09:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789662962; x=1790267762; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=J0HrSFs1iyASxRb+VzpnZv3WQ9ucZZcUM1YgNRzctxU=;
 b=BdEeoGC1gNCnWYDOW/IyC49BW8YzNE22zzHe6RRqmouVkqiU1iEctJf6BOkUbxTXOm
 lWKCAzsLDQNwwHj5lKu5qwg9FomG0BQ6RIy10l0PBw+FrQQIOdaHuoN4JV+3q0W0z+4a
 jqHLDx+O49YOdYRUww4LOPc3ObEKrJ0pDbmEhjIXMsdgYDWci5svT5l+CYFCoil4DOBG
 hU3OEQxsfi3bSAr8C1qPMpSVhbySvXV1mWr/p3pTalM3lAfH8LNpdPbtiFpYkshnH2IN
 OBh7bnmHW17LnJllkPYpmSo0+CTPWyzUTE29iPM6PWhEDMCvjdDo4+4VbWkdH0ceU6cA
 hJog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789662962; x=1790267762;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=J0HrSFs1iyASxRb+VzpnZv3WQ9ucZZcUM1YgNRzctxU=;
 b=khiBttf8wZ5jG9DJbRXGQMoE3HJihCsH5+eC+sMcggPjBBq/Vqx21R7MuqYQGfnOjF
 Q3as7IMSOWmmAXYhSolLnCPkss4PThfLuspE05iEmgV3vzKFBkJbSNKnbOjSwrwWCyZz
 y2uqxZqy+gKTaAHRkgqIMldvlsbJXKYpYGfv99hcaiwJ4tU305y39BK03EaxN2HCxXwL
 XLOyrKduata47194dPBG3yCo8DgninL3TKZbt7wb6Dulv7mUt8Sm/qqaFMb1ytQ6Fj66
 rtUm739cJSpZmWoqyznAzufEwOegoA6P2dQ7a3UnJ74Yz2rB7PocMkF+5AeVXOuiSPcP
 LMvA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzvbUeJU9uGTqc9CW//rXkDOy/h5kL4kBRiX+t+EJ7vdGfHQoT9gMeSIVGya23lL7NSJPnHzZGSkVY=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kzjLJ9jS6aoeFMlQ+9FkWhGyS6ZLkQf/uvC1ouLyogvgWEFKVm
 Szg0cP8qSdG5bTCfj+dl0gl4XCajKVyBYgx0gT58t1bfsBEYMf1ZZB3/
X-Gm-Gg: AYBFou1fjhL7ys1FQeYcTV9+3AQuL3niQuQfsp/0iS3Wj2SHxCHcNLaApPWRgwziHzC
 jpE+kdc8iRw023toMYc+XUMoU/H5e5gssFz1CmVODr1FmBuyVm5/LyyxLDeno9eRxr1KwgF1rXj
 VcNG7qRTvp8xupLYDUhCQdX/gV/ZFQXLWE9rze5+bAu3DrbGxTGOGiKJabYvho6wBl675yEXYu9
 aXA4iE4Ni62ucS6waobxXSvQdUmJJHk0VMNGZnIX+m/T3Tfzft/Iqw4dpmFP76/18UeS9H481rO
 SnlP8NYPs9+tC2q3sDQm+t/4mYGGTxTjMdJ4WezgOopIOVyqw+newbWv4Hb9U43HXMwAVOntCvY
 ExzPTsHF6qFgkZQBtO+nz3Hoqt1udoh1/jGBrPLaK7yANDR3O5lUw8ERdXbqp4wKxZKgjzBcI3b
 PkyIAk8rd+60ttOojOR+lQLT0xW5JW3g6SpqKzXTR2AiG/ux8zhsuPR//5XXwWYzvjf1b4w2jjg
 VS+Moth9cmwAoQCcOHzAlCez3EmSOleWoQyxOVJtbKJ79I=
X-Received: by 2002:a05:6122:614a:b0:5c7:a814:b987 with SMTP id
 71dfb90a1353d-5c9a73a13cfmr1469841e0c.2.1789662961786; 
 Thu, 17 Sep 2026 09:36:01 -0700 (PDT)
Received: from lord ([170.246.209.50]) by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-5c9a53b2ba1sm3065363e0c.8.2026.09.17.09.35.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 09:36:01 -0700 (PDT)
From: =?UTF-8?q?Tales=20A=2E=20Mendon=C3=A7a?= <talesam@gmail.com>
To: intel-xe@lists.freedesktop.org
Cc: matthew.brost@intel.com, daniele.ceraolospurio@intel.com,
 stuart.summers@intel.com, julia.filipchuk@intel.com,
 thomas.hellstrom@linux.intel.com, rodrigo.vivi@intel.com,
 jani.nikula@intel.com, navonjohnlukose@gmail.com,
 dri-devel@lists.freedesktop.org,
 =?UTF-8?q?Tales=20A=2E=20Mendon=C3=A7a?= <talesam@gmail.com>
Subject: [PATCH v4 0/3] drm/xe: fix GuC TLB invalidation ack stalls on ARL
 (Wa_22016122933)
Date: Thu, 17 Sep 2026 13:35:50 -0300
Message-ID: <20260917163553.1742580-1-talesam@gmail.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 18 Sep 2026 07:09:59 +0000
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

v4 of the TLB invalidation ack stall fix for ARL, rebased on today's
drm-tip. Tracked in:

  https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/8678

Recap: on the standalone media GT of MTL/ARL the CPU reads stale cache
lines for data the GuC has already written. The visible symptom is TLB
invalidation acks appearing to stall for a near-constant ~2.3s. i915
works around this as Wa_22016122933; xe never inherited it. Patch 3
implements it, scoped like i915.

In v3 I asked two open questions in this cover letter. Since there was
no preference expressed, v4 makes the conservative choice in both cases
and documents the reasoning in the commit message, so the series is not
blocked on a decision:

 1. CPU mapping: keeping XE_BO_FLAG_NEEDS_UC (uncached on both sides).
    It is the tested configuration and no throughput difference against
    the CPU-WC variant was measurable. Matching i915's exact CPU-WC +
    GGTT-UC combination needs either a new BO flag or decoupling the
    GGTT cache-mode selection from XE_BO_FLAG_NEEDS_UC; happy to add
    that plumbing if parity is preferred.

 2. Scope: covering the GuC-shared allocations (CTBs, log, ADS, SLPC,
    engine activity), which is where the failures were observed. i915
    additionally covers media-GT LRC/ring state; that can be a
    follow-up if wanted.

Fixes:/Cc: stable are still left out, since MTL/ARL is require_force_probe
in xe. Also happy to add them.

Validation of patch 3 is now six weeks on two ARL machines (7d51 and
7dd1), across kernels 7.1.6, 7.1.8 and 7.2, with over 10M TLB
invalidations processed and zero ack stalls. Before the fix both
machines reproduced 20-60 stalls/day, every day, on two GuC firmware
versions. The 7dd1 machine, which could not survive a day of media
workloads on xe without a platform freeze, has been running xe full
time since 11 August with zero incidents.

Patches 1-2 are the diagnostics that made the investigation possible
and are unchanged since v3. checkpatch is clean on the series.

v3 -> v4:
- Rebased on drm-tip.
- Patch 3: resolved both open questions in the commit message instead
  of leaving them for discussion; refreshed validation data.

Thanks,
Tales

Tales A. Mendonça (3):
  drm/xe: Capture devcoredump on TLB invalidation timeout
  drm/xe: Log when a timed out TLB invalidation ack finally arrives
  drm/xe: Implement Wa_22016122933

 drivers/gpu/drm/xe/xe_devcoredump.c         | 46 +++++++++++----------
 drivers/gpu/drm/xe/xe_devcoredump.h         | 15 +++++--
 drivers/gpu/drm/xe/xe_guc.c                 | 16 +++++++
 drivers/gpu/drm/xe/xe_guc.h                 |  2 +
 drivers/gpu/drm/xe/xe_guc_ads.c             |  3 +-
 drivers/gpu/drm/xe/xe_guc_ct.c              |  6 ++-
 drivers/gpu/drm/xe/xe_guc_engine_activity.c |  6 ++-
 drivers/gpu/drm/xe/xe_guc_log.c             |  7 +++-
 drivers/gpu/drm/xe/xe_guc_pc.c              |  3 +-
 drivers/gpu/drm/xe/xe_tlb_inval.c           | 39 +++++++++++++++++
 drivers/gpu/drm/xe/xe_tlb_inval_types.h     | 17 ++++++++
 drivers/gpu/drm/xe/xe_wa_oob.rules          |  1 +
 12 files changed, 128 insertions(+), 33 deletions(-)

-- 
2.55.0

