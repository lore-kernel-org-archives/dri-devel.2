Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B13F606A334
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 17:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Fzh5bcl0
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7495610EC56;
	Wed, 18 Nov 2026 17:10:15 +0000 (UTC)
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1CDF910E110
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 17:10:04 +0000 (UTC)
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4ba01393800so8373685e9.1
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 09:10:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1795021802; x=1795626602;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:from:subject:message-id:mime-version:date:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=mBINZO8SI4MpYZqVki+lomnJt57kbnNhtrWtWttDyyg=;
 b=Fzh5bcl0BrzU93I85MVeoHOvmZuoDNyVBQtJ8osJzRkpXeFLTUxQdGjHE9ljsmLWJv
 V2shRKsIs7JkTblPSNEt6weFn6RWw5AhkwsiciKByElvdSaE7lrZoJn4JVh3leC8n2+I
 ffuOf56oX657YfHUAa02stXzf3OjU+MBZ6q1gIOoRAGuiGQLt7BgViR7Nu1dlXVaDN3v
 nYJF4kTr9AwjBP35GEzpfqD0dKMTbfg0sdpa6Rjry5rckEryV8X0D25W+PFprdU8S345
 nOSwAtjASoyoJVb3IzGI+rnH2RQhoOTOjBuQx/YRVNbQQz3S80pxmdoBRtZuY2bMx1M7
 P3kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795021802; x=1795626602;
 h=content-type:cc:to:from:subject:message-id:mime-version:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mBINZO8SI4MpYZqVki+lomnJt57kbnNhtrWtWttDyyg=;
 b=WRu3MGxsyhGvNhpI21qSrEghnFxymasO7OBpF5lhlh6hlM2FwoVgqjumsnt7mJndi7
 kRbjjlDHGFlPj5sMvpEWKHylQzLv1PmMFe/1HPKReX3SIGgg9Ie32YzTWWgc9N3m4tXn
 a+BscnR7cPSFWNrQnG25IxYMAz/lEQele+SrtDT5xD6lL4wcadWd7SuIn/vbB+RgoqCh
 hydNOPghxomW1NJ5Fdr8EqBNIjLpDULhimrNPNsthv6ZTfCYmxHzD4wOihBxnalsBJZz
 WO4EG9j7XMvf5dKeU1WOFhkWHNazfF5y0902RJDLj9bXbhApTcqyutishs3ZQiWUCOq5
 H/Gw==
X-Forwarded-Encrypted: i=1;
 AL+hErF6DnVANxMIy777DVbqAr4+6F9cRVXqC4tC8x2SvUaejeBB01riiCkFxMEvmDxoG4HPhNwCAxD6ugU=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/MKzitGbEMcZSit53YfslASMebuvmrr3s/MPQ8D6razvp90BYl
 kZWQtx4brlfyTn8tnHQuAdX22skfxAjwPKWz131GjLIAU+THB1wqJHSHeUy94DsVUR/vlFAIcIe
 I8AZeAiiLVGGca5wW0g==
X-Received: from wmdn7.prod.google.com ([2002:a05:600c:2947:b0:4a2:8ef:a5af])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4ecf:b0:4bb:7007:4a5a with SMTP id
 5b1f17b1804b1-4bb7da2eaa2mr68357745e9.23.1795021801887; 
 Wed, 18 Nov 2026 09:10:01 -0800 (PST)
Date: Wed, 18 Nov 2026 17:09:50 +0000
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAN/b/WoC/x3MQQqEMBAF0atIr21IosjgVcRFTL5Og0TtgAri3
 SfM8i2qHspQQaa+ekhxSpYtFdi6ovD1aQFLLCZnXGet/fCmEYrI18HBp4CVu2YyDmaGDy2Vblf
 Mcv+fw/i+P1fPKTRjAAAA
X-Change-Id: 20261118-ordered-wq-cancel-63b02e0feac4
X-Developer-Key: i=aliceryhl@google.com; a=openpgp;
 fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=733; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=2c+b7t2eSKRSZikSFPwO4mhMOW0PlzZoNYa5IB1loN4=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBq/dvjWZXjaqIG7+QNZMRPjUaudgg03nhqwuouf
 rjtcynuV8aJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCav3b4wAKCRAEWL7uWMY5
 RqEvD/4jQXgzC7AXJ3txLaMqfqDu96CDUPsiDmb2Os7FDvR8CQzsd+E4vkv8pqnLpUoVUbHTKxn
 2LWXPUTEOHgIv87yjdfM6ZAPpx7qtx6Tv4I8U84NucamP86rLQ6mMPLBua5EDNbRmvslVhFLomy
 +SxNbhkFbEBHwBbNfU7FLV1P2TCLuBnhqYAQ8uiAHXkWUtYcsnF0alwTgCbe6NV9wQqIiYY2VV3
 9a/6bCBumEP6JkrPczQHfL1ELRfX4M/A6CWQuChk4HiNMWIW3zL5YFlLMJQAHRFu53FWr1hpjwg
 Lx0jF3cHrOX1gTGF2y3XnaDi+6vo7n5etmR7Vtm1x07Is7Bb9S12OuZit9LmasPyB6ZHdY0LU/9
 9YoUtddS6nhAA01UysT7bPMBRhEpgNEI4FrQILcfCB5Fi9DqPto6wRHdJGYbsZVQa6rmWu0RtYm
 3s3UYTrJq5b6jPzkx+q/9SdB4Y2nwTaj22UrRHQ1ia+sox6qbd7JXg40xcmUcA+Aipul3211n0Z
 3lwyL8KPBHQjpButhNYkOP59y5KlQxPxpWRxM44d1bBEvIky2FvViYro4fWZhuvW7ZpTECXAvto
 CLULfePyLLxPbarsGy4z0VZr30J8rc62G1h1bCYvVQ6/3QrO/pHY77KqTrT8uNnvmNWUGbU3G+c
 FR2c8om07K578Ng==
X-Mailer: b4 0.14.3
Message-ID: <20261118-ordered-wq-cancel-v1-0-916e01f9affe@google.com>
Subject: [PATCH 0/2] workqueue: fix cancel_work_sync() on ordered workqueues
 and clarify docs
From: Alice Ryhl <aliceryhl@google.com>
To: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: Boqun Feng <boqun@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
 Danilo Krummrich <dakr@kernel.org>, Philipp Stanner <phasta@kernel.org>, 
 Matthew Brost <matthew.brost@intel.com>, 
 "=?utf-8?q?Christian_K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>, 
 "=?utf-8?q?Thomas_Hellstr=C3=B6m?=" <thomas.hellstrom@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 "=?utf-8?q?Onur_=C3=96zkan?=" <work@onurozkan.dev>, 
 dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org, 
 rust-for-linux@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"
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
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Please see the commit message of patch 1 for details.

This came up while figuring out what to do about this sashiko review:
https://sashiko.dev/#/patchset/20261020-rust-workqueue-v3-0-ea7c74d02068%40google.com

---
Alice Ryhl (2):
      workqueue: fix cancel_work_sync() on ordered workqueues
      workqueue: doc: clarify cancel_work_sync() cross-workqueue behavior

 Documentation/core-api/workqueue.rst |  7 ++++++-
 kernel/workqueue.c                   | 37 +++++++++++++++++++++++++++++-------
 2 files changed, 36 insertions(+), 8 deletions(-)
---
base-commit: aebb7274476403040d582c61478df8f4a7bf9cd3
change-id: 20261118-ordered-wq-cancel-63b02e0feac4

Best regards,
-- 
Alice Ryhl <aliceryhl@google.com>

