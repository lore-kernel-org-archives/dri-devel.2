Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 691EDC61DCD
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 12:49:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 25A6510F001;
	Thu, 27 Aug 2026 12:49:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Krot9wre";
	dkim-atps=neutral
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
 [209.85.221.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F255810F004
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 12:49:15 +0000 (UTC)
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-47db714766aso706821f8f.0
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 05:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787834954; x=1788439754; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ko9Jj2K+jgJ0qKx5UvXg5fzM+bHwcM2e1OfD7QYdNG8=;
 b=Krot9wreMilnYHi0HEkaifbA2F1WqhiKcb8e4IgFlWPGhoLUuKhsG/68mvZAA9OFLr
 MFJ4/FGCIxljufSIeUyHxiG9Wkxhcw7lqJGGH0jrodF4mBWBPsmRvFH0WW8ESUn5ZyVT
 PGDHe42ILhBoP6NlX4LKaT357AeccVSOBAgsXRZzZa19JQOjBhOrpGKhpIm5qFezACjl
 jS/oTkqr46jrQNRMC51PnpliZlycMJPkDsLGyfiVksHM6pHHbZpPMViczmK3PoNT4EXK
 816tpkQkMy+yp44sgAaPYyfJw7ttDGxi3yKkjUDtZB23pkdTgMkvR2OgZYAtN4cY5naD
 U8Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787834954; x=1788439754;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ko9Jj2K+jgJ0qKx5UvXg5fzM+bHwcM2e1OfD7QYdNG8=;
 b=KaKqtfaHe0ed2/aca3xl2JtTgDDmI8hlUFR8R6TkpqhaP6GmnQQFeGTYi/C8/a0/T2
 2U8Ub1s2BxyKFgqRcVxelZvQj94rRtklEw/hYs3UfnD0V8ML7vCjBDF/19fmPE4ipcO4
 dLOlpZG2coQfXVrSKnBDQmCAZd7Z05NYd5bewTB2cS7VXLBxqJ4LN4Rlx9/5+gTFDERG
 df0ttLSEgsbYE/JcqUdlyVDJ0ZKXgFUjZkw1mH0bYBPEKMoCsXoG5iT9wj79jOs9wXk1
 WZUGw33pMolgrZTsdjWbIY2qyzkNMF9qZCNby9xiLh/NTDuJMZiRSw1L2DRk9AijG79m
 G5dw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rpcq01DC937/tJC4rUa2BO63+P4kCKVlKWQ6cKyMIbsEGh6GNng0CIqTKmKIeErxAYkSH1NY8tt6uo=@lists.freedesktop.org
X-Gm-Message-State: AFuF++l6vMlY6YRkkdqYqtH68VcSPqfYq5PO+rDpVvK0KIhGooXr1YJq
 UIB12mYgVM83MsJQlLufoI7VXfhAolm1iIa6jbRCQZvySvsRvNRtkUt8
X-Gm-Gg: AR+sD10nnpyz+RIAPo1sx2ZyJu4ZCcGtUj9L7vmydvC1Dphrj7LS7px7Mw7upptck2x
 9kbGLP/AbHwhxto8QEQmzpwTC31Rq54Hn/TTr+H57758NWU8WlZ0+Em6k8AuZ4RONufGcJ8dbMd
 2X8Po+wuwLjQ1aX2fKmoLLU2pwNLiFsE+Fh8BAczLkod9Ti8fqlYqjCv96km06PmRlDx+fh4PXn
 F45RLWOb6yM8fiLwyzc4p0sTVAKzG/5YcsFfzotC6bX4wd11a7uvRksOPwqC9aAtKC4jA4lMD1O
 lO7RuN8roFmhToe9lR9kbRuAYm+7oMJZwHTmCzVLucoL66+Nl1K1otgjbaAySHUevEz5Saw2+eZ
 zG/nTIiwy9bFF6rRc04hHLJHF14Fz8Q95e8OqEFTF7CMxF+FNooAndjic0TJjhoPIyL4o6sXNgh
 rvxSEeMcfHEL1jTfMCnoGO/DjfDhiPVkPynYkGvIny3W0CR82gUfwpI3kl1dlq3mYtXRf315+sB
 g==
X-Received: by 2002:a05:600d:8653:20b0:49b:e22:4ee4 with SMTP id
 5b1f17b1804b1-49b0e22505bmr57356065e9.4.1787834953901; 
 Thu, 27 Aug 2026 05:49:13 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:1524:4300:a4b8:720e:f64f:4778])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49b465226d8sm52089985e9.0.2026.08.27.05.49.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 05:49:13 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: thomas.hellstrom@linux.intel.com, dakr@kernel.org, ecourtney@nvidia.com,
 matthew.brost@intel.com, nat@pixelcluster.dev,
 dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Subject: Refcounting dma_resv v2
Date: Thu, 27 Aug 2026 14:38:48 +0200
Message-ID: <20260827124910.2245-1-christian.koenig@amd.com>
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

Hi everybody,

The idea of ref-counting dma_resv or ww_mutex came up multiple times from
different people, but so far at least I have abandoned that as to
complicated to implement considering how widely used that object is.

Thanks to AI I gave the task to refcount dma_resv to Claude Sonet 4 just
to check how horrible it would look like.

Well turns out that this is actually a cleanup we should most likely aim
for and I'm really wondering why we haven't done it like this in the
first place.

Not only resolves it a bunch of issues with dma_resv instances shared by
multiple GEM objects (we just recently had a bunch of patches for that on
the mailing list), but also allows TTM to implement it's delayed delete
handling without any zombie resurrection or similar hacks and DMA-buf to
have better contention handling on map/pin in the future.

This patch set here is now the idea full flashed out. I smoke tested it
with amdgpu, self tests and checked everything with kmemleak and of hand
it seems to work.

Patch #1 introduces an interim allocated flag to allow switching users
over to the new interface one by one. Patch #10 then removes that flag
again after everything is done.

While AI is an automated tool I distrust it to always generate the same
code. So better using a defensive approach on changing things.

Please review and comment.

Cheers,
Christian.

