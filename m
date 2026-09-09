Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68C9FC79FAA
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 06:56:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4575D10EF5A;
	Wed,  9 Sep 2026 06:55:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="miE6dfwr";
	dkim-atps=neutral
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com
 [209.85.216.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E9F5C10E198
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 00:38:02 +0000 (UTC)
Received: by mail-pj1-f53.google.com with SMTP id
 98e67ed59e1d1-38dfe7eb825so4356798a91.0
 for <dri-devel@lists.freedesktop.org>; Tue, 08 Sep 2026 17:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788914282; x=1789519082; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:content-type:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=+N42okI1Wy1E3qltvnDBLmtHk/vIG4wL9iomvsmoyUg=;
 b=miE6dfwrGLGBp8ArJRZrIDzuI6x3yw3vSHLaxg/89ifzD/MowjvO2APz6BUyGfIPnl
 5+r/nInGRGr5PUwvOAUVHghdb7gABScYWcLzYhsV5qwSsAEh//mRFZXLQBNMaQp1jUO+
 q8G4Qls9J36GsC5IPaoXFf2I5FZot6dwK3yHdOcnfj0fj4wUJYEB/V6FsKjuhBlzXa8e
 5a83iNWZ6Ot++oRFayaya6qnwO5JYCvIz00YftKzpG6ugeaeH0VUQNGyjWzLSbs36P4H
 3vjGHxJ/GDQlXd7aBzLtedqYTBsPVmqNkQrJVzVHTfQknXmS8TbWWnoixX2xAEQ+Uvg5
 uTdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788914282; x=1789519082;
 h=content-transfer-encoding:mime-version:content-type:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+N42okI1Wy1E3qltvnDBLmtHk/vIG4wL9iomvsmoyUg=;
 b=UMfqBZUYYpLks+YiJfZEUxmLZGeGjqwMhubz7ukj6kbrm2JFWWQfsfMvSePr/3xNW2
 vkFFU3xIc9ADIx7zAwbfX79xp1fWkSG2HFSU1aJJiPR8KTd9yVFRvLe0k6qxHfhPdxwx
 76Y9Eg2gR0eizmzUrgZASpJoFL+PnlwLZfW1gGlZPGP+54uFykRqFX65oqv1Iem4m0G8
 x8fH/A5QQqSSOgUZxWFWM8d9okZ6027jRm5xxE9Z2fubjLWLyRXCPl7+5bIq6565+fqs
 JyzvAeRpfo3HmctxyyA3ZARHTM8dy/aTAYGyOagIfadc15pHONGkRKPA8g97BedvZYC9
 +iqQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwpJDhohG1EhZtbB8ay4bQkeaDku8pE8brkaJnwkEZXWb62gpryyWPjfisfr+t7AABiJHFk5IBbvGw=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nOZr+l/a81ZDxxgB7I/HGaNTUUMUoZaBT40D0K2JZiQzZ14ok6
 HiAcDv7PdP+0GbQXVS9p6+LguTIPr33onKkelV0B0sYLEfMiiOj1DRQjyD+8NOdVyA==
X-Gm-Gg: AYBFou30vD0JfcZ33Vgoz0VnDuAUxaC35+qFVLhtreWgbYI3AuolfwKWF11uQrXxMoh
 b1KWdHA2c6oQFKk5DeRneCql1ToNoTTAKthPbAe1CVRRzKZCJOZ58X+LQTl2PngMSDa2Vto4uOK
 boSB4PCN/sFY2Ppeh/KHxqTwOvJZ5dnZlvqzanMn6IXZbOn/K2xVOAyZs1Kmdpl0WaNFRb+p+pT
 v/L/1GpRbsDgLjO3XZ1Sn9kM8bwwIDC3qIy/V+SOeEJ6v9TNU4qNoIo1LtDtaFErOoLck60QgqT
 YpmjUtnLhdbruKHXR1Dg2zTW0i3Rl1ZWk+jQ5iCIFEwCvjP69/DEGT/umdQcKrdLbjOhNJatby5
 XLbGyXs7gHtzMyHf2Y/6I56N9ReqAKA4zsmP9O+XlOzHA6KsDPljGvvWUqbcR/oNoLzHtAvmsCd
 mrBjvEM2WRtHhuvqLmNehJM90RrWtgDo1M3kWqgJ4QYkMhb210TJ+Wpqe63+9MoZ81YBaAMGc69
 wfUx2ClC0NqjVRgQNIaZJj8JTL0xtOxOCtoug==
X-Received: by 2002:a17:90b:2e52:b0:38d:ddc2:7ccb with SMTP id
 98e67ed59e1d1-39b260dd3efmr42715158a91.1.1788914282283; 
 Tue, 08 Sep 2026 17:38:02 -0700 (PDT)
Received: from MalHyuk.localdomain ([211.201.32.99])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39b08c39451sm34606398a91.7.2026.09.08.17.37.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2026 17:38:01 -0700 (PDT)
From: "Jonghyuk Kim(MalHyuk)" <malhyuk97@gmail.com>
To: phasta@kernel.org, christian.koenig@amd.com, tursulin@ursulin.net,
 matthew.brost@intel.com, dakr@kernel.org
Cc: Jonghyuk Kim <malhyuk97@gmail.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, mdaenzer@redhat.com,
 alessio.belle@imgtec.com, luigi.santivetti@imgtec.com,
 stable@vger.kernel.org
Subject: Re: [PATCH v4 1/3] drm/sched: cache the timeline name to fix a
 use-after-free
Date: Wed,  9 Sep 2026 09:37:54 +0900
Message-ID: <20260909003754.1128738-1-malhyuk97@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <909f7ed1b2688fb2f727afb879642cda5cad9e5e.camel@mailbox.org>
References: <20260904080618.2098450-1-malhyuk97@gmail.com>
 <20260904080618.2098450-2-malhyuk97@gmail.com>
 <825c1f02-b9ad-4160-8e4b-53f2393a7bff@amd.com>
 <20260908104910.183638-1-malhyuk97@gmail.com>
 <909f7ed1b2688fb2f727afb879642cda5cad9e5e.camel@mailbox.org>
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 09 Sep 2026 06:54:46 +0000
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

On 08/09/2026 13:07, Philipp Stanner wrote:
> Is this an issue? A fence can only be exported if the scheduler exists.
> The hard rule with dma_fence is that all drivers must signal all of
> them before they tear down the scheduler

Agreed for the bug at hand - that fence is signaled, so 0001 covers it.

My point was narrower: nothing enforces the rule. drm_sched_fini() only does

  if (!list_empty(&sched->pending_list))
          dev_warn(sched->dev, "Tearing down scheduler while jobs are pending!\n");

and the one path that would drain the list, drm_sched_cancel_remaining_jobs(),
needs ops->cancel_job, which no driver in current mainline implements -
the only user is the mock scheduler in the KUnit tests. So a driver that
gets it wrong gets a warning, not a stopped teardown. Not an argument
against the hot-fix.

Thanks,
Jonghyuk
