Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9635E606A324
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 10:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Pq9hQLOW
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 043A310E042;
	Tue, 20 Oct 2026 10:01:41 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2502A8825B;
 Tue, 20 Oct 2026 10:01:34 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 352FE60098;
 Tue, 20 Oct 2026 10:01:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC6561F000C4;
 Tue, 20 Oct 2026 10:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792490492;
 bh=iDwPNZXHP2ft0AeFTj8+hn8P00lcqADwZLzRkEGkySs=;
 h=From:To:Cc:Subject:Date;
 b=Pq9hQLOWZ259lge3iauPDMSDeTMUwfmTj012JrRHR/uKmX0HzQJbT5cHELD3vF8C2
 bDpywxg6qBnd7zsylzNHxwijDDhDgKM9hj49qPUDsNh2n70XIWDj1arRzHKZ9V2ste
 d3a9DKNmVyZ/+F/0CmPe8Yc8KBxynCwE/7T5eX3nkilqp1fmt8bdWBAi5vj3ozpyT8
 ZnSLcsffFw229HLD0zqSrPPjAIGxMOOXt0Z+dLoFim68govthxWFgDEC58AmVQdBR5
 3KIbmRjghVfH+MGkvLfjj7QbbXF+PEMpKIpFNcJJLbIhLkUh/oikaa4oIrFSofR/7w
 zjnamrMGoG3Ew==
From: Philipp Stanner <phasta@kernel.org>
To: Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>,
 =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Tamir Duberstein <tamird@kernel.org>,
 Alexandre Courbot <acourbot@nvidia.com>,
 =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Alex Deucher <alexdeucher@gmail.com>
Cc: linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
 linux-trace-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
 Philipp Stanner <phasta@kernel.org>
Subject: [RFC PATCH v2 0/3] Solve dma_fence's problems by locking
Date: Tue, 20 Oct 2026 12:00:31 +0200
Message-ID: <20261020100034.759183-2-phasta@kernel.org>
X-Mailer: git-send-email 2.56.0
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
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

In our Rust code bases, I'm currently experiencing what we also
experience in C at many places: that the dma_fence contract's RCU
requirements make the API more fragile and put an unnecessary burden on
the API user. Most notably, in C the API behaving correctly now depends
on the API *user* waiting before free()s, waiting before unloads – all
because dma_fence is not properly synchronized.

The patches commit messages give more details about where I want to go
with this particular RFC.

My rough "vision" for dma_fence, where I think it should develop to, can
be described like this:

1. All users should use inline-lock.
2. The fence-signaled state should be our decoupling point.
3. The fence state must be consistently locked.
4. This means all callbacks are only invoked for unsignaled fences, and
   the fence cannot signal while a callback runs.
5. All fence API functions should be "atomically correct": they can
   always be called without any manual RCU guards in their proximity.
6. The fence lock should, in the long-term, become inaccessible for
   users.

Point №6 means that this:

dma_fence_lock_irqsave(…);
dma_fence_set_error(f, err);
dma_fence_signal_locked(f);
dma_fence_unlock_irqrestore(…);
synchronize_rcu();
kfree(driver_foo);

should simply become this:

dma_fence_signal(f, err);
kfree(driver_foo);

So we would end up with a simpler, more robust and more maintainable
API.

I gave this basic testing on a Nouveau desktop and it runs fine.
dma-buf-tests also run fine. I can do more tests on Xe and amdgpu, maybe
on Mali, too.

Since the series is mostly about locking the callbacks, all of which
except for set_deadline() are *already* locked, I am confident that this
can be done.

Feedback welcome

P.

Philipp Stanner (3):
  dma-fence: Remove RCU protection for fence->ops
  dma-fence: use lock to protect against module-unload
  dma-fence: Support unload for ops->get_XXX_name()

 drivers/dma-buf/dma-fence.c                 | 144 +++++++-------------
 drivers/dma-buf/sync_file.c                 |  29 ++--
 drivers/gpu/drm/i915/gt/intel_gt_requests.c |  16 +--
 drivers/gpu/drm/i915/i915_request.c         |   9 +-
 drivers/gpu/drm/i915/i915_sw_fence.c        |  15 +-
 include/linux/dma-fence.h                   |  63 ++++-----
 include/trace/events/dma_fence.h            |  12 +-
 7 files changed, 113 insertions(+), 175 deletions(-)

-- 
2.56.0

