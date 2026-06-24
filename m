Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D12E6CDB47F
	for <dri-devel@archiver.kernel.org>; Wed, 24 Jun 2026 12:29:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 40C0A10EA50;
	Wed, 24 Jun 2026 12:29:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Z20W21WU";
	dkim-atps=neutral
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com
 [209.85.221.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E688010EA50
 for <dri-devel@lists.freedesktop.org>; Wed, 24 Jun 2026 12:29:21 +0000 (UTC)
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-45ef56d9b67so834910f8f.2
 for <dri-devel@lists.freedesktop.org>; Wed, 24 Jun 2026 05:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782304160; x=1782908960; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=pFbStoNOnxZ8EusijrnYkbV2hWnyICFUOIVa9+YJMwM=;
 b=Z20W21WUEnsWS6+KgHMw2/O6rUnl30yGlGm+mFZJl1QTcW0j4ZTNG+o2KwH/HTqpQu
 N3uf2MDtEWykZO8E/mTkPo/HN2ZZBloGR8qtdCqd1zRNkq6jTYMdZVXJAK+Wgfyc/IMj
 snArs0xLO57xM4NIWBIfzYqWE/9MoWUQPz+/rXrmHsuJaR2bSCwd7y4wkZSbKbYZ7YWd
 PI6nmcZe7Jx0WZ7UeMU1R6unL8GHAe7OnVShrkUyF/PvcPuwKWWTRAS/nsNGjn8zcW+S
 BkxDYw6E/VNJNRDAjMOUfLyTbTMClTYuiGFwqOGvx1WRk0p1AgscYtyxdT60yv6P3177
 dmbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782304160; x=1782908960;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pFbStoNOnxZ8EusijrnYkbV2hWnyICFUOIVa9+YJMwM=;
 b=JSSFKc/O8XNxmNdqUYYtwxFDfa5B/htW6NNR/w0E0Ivq7i/L/ElYgVHeOaQiMcOtN+
 Tj3y92bkaGmW3Ag6rlWis4MxU8/CZqdz3j6riIx72EY5GNfNr7uSnafcHjfTAKS1WhJn
 0OpQHeYAX6VBkflhkgLakNZoGbJZtDLw0/v1iTfk2jtz9jSYumn0SuRTxl4HPQB3dPYA
 f0TbfF8fX2T5yF0t4+UtC9XRuND4OvRztGjhRD69vK20ESHqBEax7RMaRp6Qk8HDijgk
 4/teY7opflpgV0fcP0zS2Sn8j4Jo7EkG71VJRKTR7sOFrLDFZPAkWXJnEZ+s22jPrWYa
 9eCA==
X-Gm-Message-State: AOJu0YzJNsf6Sa4voXJjyxiyP7rQostOnwJyR2H1aT7RlhTz+wHm/ZMq
 bMTMJnm/BdH0GS8deq8Q29cm1303LOKFte8Hlic3gtkgZl8IAk4nLMpV
X-Gm-Gg: AfdE7cl1yuoaZylyLzetSx3h6qjpc7nq1lWekbmOqGq8UJb7PH0BOga9K6X7VzbpD9v
 vc/+lNCZQUDCUhm0x93gLUQyerA+n7cV+hPKupZ+JLg96AAAdYbpb9XU8EfKnURXGBOnWAPTwMT
 13OiPbXCPGtDEjpNicngFVBbjBYDwtsN6fhuuoNUAqAUmlXpCX6MyZnifbf6QndmnLq04WYT2Zg
 rJUYKFSEeAhajrYtJHiWPwz4fcMNR333Dd7AiO3qWAT9ZvEoZTlzs2+pWxa9wWQH87YNSRA2mUV
 xavzTCym2kXtQOXSwz7gIbP+aqzXPlbjnKDtDhDmzhNyw754alauAcJZFLPkBfEwruizKsGv5yu
 xU1J6FmrKDrUu4JWoQ00Cnp5t5FI8YA6pZxeyBIz5/sO83Zzk16FP/oftDENBuHaZ/klOHsTrp5
 8rAlsF2TkMhfFuFVjvY7VCaBZ7Dg==
X-Received: by 2002:a05:6000:26d0:b0:45e:e44b:312b with SMTP id
 ffacd0b85a97d-46c09427c74mr5404079f8f.18.1782304159998; 
 Wed, 24 Jun 2026 05:29:19 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:157e:3500:2be7:1a89:41c5:9239])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46c9787dddbsm3896530f8f.3.2026.06.24.05.29.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jun 2026 05:29:19 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: phasta@kernel.org, simona@ffwll.ch, sumit.semwal@linaro.org,
 tvrtko.ursulin@igalia.com, dakr@kernel.org
Cc: dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org
Subject: dma_fence cleanup/rework
Date: Wed, 24 Jun 2026 13:13:24 +0200
Message-ID: <20260624122917.2483-1-christian.koenig@amd.com>
X-Mailer: git-send-email 2.43.0
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

In a recent discussion with Philip and Danilo the question came up what
was already tried and never finished to cleanup the dma_fence framework.

So here are the different ideas I came with but never fully finished,
with the patches itself modernized and rebased on top of drm-misc-next.

The main goal of those changes is to make it easier to implement dma_fence
backends and don't enforce unnecessary constrains on implementations.

As first step the locking around the dma_fence_ops.signaled callback is
made consistent by removing the dma_fence_is_signaled_locked() function.

This was mostly used by backends itself, but if polling the HW is desired
the backends can call their own functions for this directly without going
through the dma-fence layer.

XE actually seems to be the only driver which make use of that for a bit
more handling. For all other cases testing the signaled flag should be enough.

Then forcefully calling dma_fence_signaled() is removed from the dma-fence
layer and moved into the backend implementations.

This allows the backend implementations to cleanup after they have
signaled the fence. Such cleanup can include removing now signaled fences
from lists, dropping references, starting work etc....

Especially nouveau seems to have some really messy workaround because of
that involving the DMA_FENCE_FLAG_USER_BITS and installing callbacks
because the reference to the context couldn't be dropped directly after
signaling. This can now be cleaned up as far as I can see.

In the long term this should also allow reworking the error handling, e.g.
removing dma_fence_set_error() and instead giving the error as mandatory
parameter to dma_fence_signal().

Then the last piece is dropping calling enable_signaling callback with the
dma_fence lock held. This makes it possible for backends to acquire locks
which are semantically ordered outside of the dma_fence lock.

This is necessary to allows using the dma_fence inline lock in more cases,
previously backends used some common external lock for their dma_fences to
for example make it possible remove fences from linked lists.

Please comment and review,
Christian.

