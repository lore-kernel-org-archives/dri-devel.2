Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D479EC88E53
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 06:32:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4869410E23A;
	Tue, 15 Sep 2026 06:32:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TiGuyvcb";
	dkim-atps=neutral
Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com
 [74.125.227.141])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 111B810E25E
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 06:32:57 +0000 (UTC)
Received: by mail-pj2-f13.google.com with SMTP id
 98e67ed59e1d1-396ccb1a98fso2173085a91.1
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 23:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789453976; x=1790058776; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=QqArEvzGbVkfAltQ7Gy444plDqM6Su1k8Ceju0cJ61Q=;
 b=TiGuyvcbn0yt2akXVpN1Rz2lJdQNffV7W4hPiGvoxmATobo3LKvJySMW3gpivhNqyg
 99P7FbbBwlSC6Z4j/5QVKl4FEgJJrDNmk40cAtjNTxg6ggfQ85PCOTGKdRKNvlRAxki3
 cccumrC3X+yNlD59p3MSaVFN8kZ8oBpJ83KZ4kWa4uGb10NtlfXwZ4Z+KNxMiTKktbg2
 PxC0QWWb75cmDtrzdsTgm2ZQB38Gbz5mehVgoQWOWv2rt1wbRMkYndAAdkszAJOwD2e7
 eg6+9YsX0d1n9q0cooikRyarrocdayHDfgdHzbuRQYK/chnXDuPqXQ/Gma9Y8hoiQ866
 NbKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789453976; x=1790058776;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=QqArEvzGbVkfAltQ7Gy444plDqM6Su1k8Ceju0cJ61Q=;
 b=nrSDm9dDZ4rrc4tn3WQqknaw1CdZuq439VviUKx4hp3XTc/AHoPZ4KG8AUOE7Xty6A
 NrfnUhijKs8pDVngwmlK0Myn0wpdKwjIlHJCJkvsLduOFm9VlSO5r1qDJY3lir8A0X7N
 E2pV4rhkJktKe/765cPF9FDeWjeCgeIm5TTg1i/S2n8CJiCludeX38e6OQiEnr+d5XTN
 PXIgAOMaNQGIwv8pOXPeIZzUsyKpRMJGeLYVgjJKHjLE9mNvIScWJZTupX6187cq7Qn1
 bdoZFWq2+fXu18VQ94lZ5YrwnaoogDZpmpC4APNoXeY0fjiB20Br29De6nxsTvbeSh6o
 tYBw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzxMXd32qv2v1I3lVukPh0fan6KPpe0oIrK9jHsz+cZ/82kQLeirTO0pVy+0b6Y2R5foC+RnZ1bGIU=@lists.freedesktop.org
X-Gm-Message-State: AFuF++m2OkpT8hpCNh17v2WvLNToWBsi+Tw52McCwM5tr9J9Xvo9xbI5
 LGVu67/5/rp+7+4LHU9VvD7ddL1D+PBCd9gO15y+8C+W05fXovlMQkYV
X-Gm-Gg: AYBFou3AQIYxurr9DV1BDlaIJrnptuSSnLYlLdsy5AjzmLT7KSv9AVRanBHdgbj1Duv
 CBJifVlMBMsAqzW52gDMQNTKovY6cDSPgDqXmiNShGlqPkVaBu7sqo9T3QL1R4tJ1M8TuVLTMaJ
 Qtnu0spoe4qmbj1X9YCRMiRKkU9WHMCZGius5wG0sT3PxyCf2128+y/+V4gCWd+CaMYCqxjsdTT
 Yt7RXm+HlrMPJFSqm08DkZ5xy36oEtugE4X7W/8o/gjmxRRQ6oaTuzXCMTDND7dhfjqL9XB4NYa
 rIOIFOI18crBTl5DTkro+KVKGDJTiGOyd3eb3Al+bMa9noGlAJ2aItVLwU5x6z7DfP6JTTEwbrZ
 s0sqJtgTIMXB7XVbaasOFWsauhgrXHZtPYsh/KuqtayCZnUON5W1hAzn47IbIlPWG98enrAvIYH
 uXGnJ9nnUtsjuP/O56ueQ3mVH+4Yb0+GTmUR9oK4FeaN99qoWKKBsruW862+0yikVo3RbNxyaZQ
 iIuNvT7yyvs4Kfa3/JCrZ1Ia10Ub2SBzBYb9QteAfrJt5LdyuY+6kxW0NTHGjiPEb/pRWqed+I9
 2+5EM0Boz2rRnJ+fATzi2FAAhWUB4LXQ34nZnMezahyefY8bn/CvfpodJF/05bE=
X-Received: by 2002:a17:90b:4b10:b0:39d:e54c:a28a with SMTP id
 98e67ed59e1d1-39debf9b35dmr11228325a91.8.1789453976485; 
 Mon, 14 Sep 2026 23:32:56 -0700 (PDT)
Received: from spider.bream-herring.ts.net ([103.252.203.158])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39dfd9baad9sm3254695a91.4.2026.09.14.23.32.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 23:32:56 -0700 (PDT)
From: Matthias Goergens <matthias.goergens@gmail.com>
To: sashiko-reviews@lists.linux.dev
Cc: Matthias Goergens <matthias.goergens@gmail.com>,
 intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm/i915: unlock shmem folios after skipped writeback
Date: Tue, 15 Sep 2026 14:32:53 +0800
Message-ID: <20260915063253.2471499-1-matthias.goergens@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260914111511.648711F000FF@smtp.kernel.org>
References: <20260914105606.3997649-1-matthias.goergens@gmail.com>
 <20260914111511.648711F000FF@smtp.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Yes, the budget should use the supplied object size. The current limit
is a separate regression from
776a853a43c9 ("i915: Use writeback_iter()"). The old loop walked
size >> PAGE_SHIFT pages; the iterator now honours the pre-existing
SWAP_CLUSTER_MAX budget, leaving size unused.

The reclaim-accounting consequence needs some qualification, though.
Before optional writeback, i915 drops its references to the whole object's
pages and clears mapping unevictability. The remaining pages can be
reclaimed by the MM. The shrinker also counts the object when writeback
isn't requested, so that count doesn't mean every page reached swap.

I have sent a separate patch [1], "drm/i915: size shmem writeback budget
to the object", using an object-sized nr_to_write budget to restore the
previous writeback scope. It remains best-effort.
I have not measured the effect of the current limit on reclaim latency
or OOM.

[1] https://lore.kernel.org/all/20260915062924.2410550-1-matthias.goergens@gmail.com/
