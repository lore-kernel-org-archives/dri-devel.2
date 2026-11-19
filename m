Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C12B606A333
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 11:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tMkFmLys
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C039A10E863;
	Thu, 19 Nov 2026 11:54:13 +0000 (UTC)
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com
 [74.125.82.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 34FA810E85A
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 11:54:07 +0000 (UTC)
Received: by mail-dy1-f174.google.com with SMTP id
 5a478bee46e88-38431138772so1007851eec.1
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 03:54:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795089246; x=1795694046; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=bLOCauCwZS8/D6IGzsWIvkfLxH3srbuFeiLhXgqvy6U=;
 b=tMkFmLysV3hH9UtenCfMZarcLR6doH+a03qQeUQKPoUMpBeQtywX4xh/YZ19YnRic4
 7mH/GaGInSnydWAh1b+IcOeu5ZAotphGAVKOLlby0plXkAqChodLfYJPVvhnRwOXOfHJ
 eA/1qUZ0FsyeSM0d4ok1xF5QcioxV/G5PCkjYWOpDMpJeXTTv6cUYXQI80P/3Ub21mO0
 qi/4vzm/E+w2aNXEtL9RhM/RT1Q71HbTbScl+o1wVMD0zAyryJrmLr8C5bkEKgQduGC9
 bnusXnE8uqhpUu4A5xv3fwaUdIsG/whZ4XCZiiGXD1/6iQqGzQD5XXVLeu5mii1eoUgB
 Pm2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795089246; x=1795694046;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=bLOCauCwZS8/D6IGzsWIvkfLxH3srbuFeiLhXgqvy6U=;
 b=gxsIOTx9Uo9uxyco1ltMARc0HcKY5ak42ai+JMLM76eaS5ncLf4DMLltkA8HycS/6v
 z2wZWAKWO384F16EGgVHe+BdHje6ewTiUng//BDe22B1OYk3wTMyNztFaReikGTfpCSM
 MzLTKoC7eYPFYgSYOmlIhhH+7U+hB1W6sUx9lxU3ZbhbFubc86rryJupWE26TCZiPSKH
 TI2KhdsFLKIW5ZLow7gTx7ZUAfa70aRXEIDmnn5ifXS4Txs98FynIeilUnuHcJ0LU/4k
 8K/7Eiljt3NaIayQgFkaiyrbPLbAWQGqBnes9IGXy573DKsLrVXYZEXMjWGQHoBHJpuE
 kD7A==
X-Forwarded-Encrypted: i=1;
 AL+hErEUkf/S5se00z5TX4PQVK/sGOqHhvQKILD+codn1ozBCJ218kl2OSVuNVow6tsYIJ/138VjyEJebl0=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8NZR47MuTLuEnwR71+Klj3xFD/gHL+CjQIJXekZ5QklYbasjD/
 w7dkXz+C4SXfvXYqd7jkk+IEvwj6wsLeM0TraIkuTJGGnhRM6QqsMhxt
X-Gm-Gg: AZFdTZfDrggJmRdr+za8ETSP0bHPbqWAeY9FlMOpET0oJHPJs73nlvaOW4ioeZ8VToV
 kyC5RWDSHc267GcgjAw1pI/Npf6tGroNWGPz6IOi85E9TPssUZGoh0e31knGD+2uKn2vSJ66B48
 efcuA9ePVc3pB2ptiF7nJaTkbbVyKDpcdRDztSI/fnO23N5xZwGs7ibhOUDfQfWh9yyzkxjFEOU
 h7nqME9zF1HHfvr6cSHMsPNZbUwkOYe9Rah/EjdhU5/5lWvA6oZgbMsq2lJ/jEZn+kAWZNip87E
 Y4HtQ8krwWVy4eS3qGpKgPRCpbQySorT+z3J1jsDKyMmOxGBShjhoNTkabz2zqaqVCiWT9pMLoQ
 jFtw4kT5amGzdUcxx1ktg2Zzd2E5rDdycjEhA0cb2B5RwLpdOmQYiLQl8FHs87V1zYbbI7fte8J
 9s9bzqR7eq3B8l9LzSKnq5tSPuowAk8IldqcREjVal9UsFLdtObZ2mUSz0tTEEJ9/G59YuWHZ+M
 Xb65O24lnMB0IrhU912LPO7QrIJe9Il+9xnnYlXRmrPJnf7G56SHeSQVsr362SgrmjWMs9OSwlL
 PtaoiDwwWkGwXPPDJgszQ97nbiX/+K37mGA=
X-Received: by 2002:a05:7300:d117:b0:372:32a1:b384 with SMTP id
 5a478bee46e88-38281a0669amr5299111eec.33.1795089246055; 
 Thu, 19 Nov 2026 03:54:06 -0800 (PST)
Received: from DESKTOP-NM9EKIA ([2001:e60:8509:ba6c:11e:f696:8454:757])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-382a6304ff2sm17199286eec.6.2026.11.19.03.54.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 03:54:05 -0800 (PST)
From: Joonhoe Kim <26rote@gmail.com>
To: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jessica Zhang <jesszhan0024@gmail.com>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Abel Vesa <abel.vesa@oss.qualcomm.com>
Subject: Re: [PATCH v9 00/29] drm/msm/dp: Add MST support for MSM chipsets
Date: Thu, 19 Nov 2026 20:54:05 +0900
Message-ID: <20261119115405.162-1-26rote@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.5
In-Reply-To: <20261119-msm-dp-mst-v9-0-ca61be4edfc3@oss.qualcomm.com>
References: <20261119-msm-dp-mst-v9-0-ca61be4edfc3@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 19 Nov 2026, Yongxing Mou wrote:
> Add support for Multi-stream transport for MSM chipsets that allow
> a single instance of DP controller to send multiple streams.

Hi Yongxing,

On v7 I reported that s2idle hangs on resume with MST active, and you
said I could send the fix. I will not have time to follow it up as a
separate patch, so here it is for you to take into the series if it is
useful.

The series never calls drm_dp_mst_topology_mgr_suspend() or
drm_dp_mst_topology_mgr_resume(). While MST is active the link is kept
up after the last stream is disabled, so system suspend powers the
controller down with link_ready still set; on resume the first stream
enable skips link training, and the payload table write hangs retrying
AUX over a link that is down.

The fix suspends the topology manager and takes the link down before the
controller is suspended, and on resume initializes the PHY again and
resumes the topology manager (turning MST off with a hotplug event if
the branch device is gone). The version on top of v7 of this series is
here:

https://github.com/joonhoekim/tb323fu-linux/blob/0e73bc96d65386bee31cc003f2e76a2e9623f631/kernel/patches/0202-drm-msm-dp-suspend-and-resume-the-MST-topology-acros.patch

With it, a Lenovo Y700 Gen 5 (TB323FU, Kaanapali) with two displays on
an MST hub resumed from s2idle 3 times out of 3. On v9,
msm_dp_display_unprepare() should move into the patch's
msm_dp_mst_suspend() and run under mst_lock, as
msm_dp_mst_stream_post_disable() holds that lock when it calls it. If
post_disable starts taking the link down after the last stream
(Sashiko's comment on 18/29), only the topology manager suspend/resume
part is still needed. Feel free to take it under your own name or keep
my authorship.

Thanks,
Joonhoe Kim
