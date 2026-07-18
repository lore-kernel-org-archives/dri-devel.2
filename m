Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B195C4451C
	for <dri-devel@archiver.kernel.org>; Sat, 18 Jul 2026 05:33:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0739D10E52C;
	Sat, 18 Jul 2026 05:33:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="EOQtiaQ6";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B53D10E52C
 for <dri-devel@lists.freedesktop.org>; Sat, 18 Jul 2026 05:32:58 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D9D3C42B76;
 Sat, 18 Jul 2026 05:32:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DE4B1F00A3D;
 Sat, 18 Jul 2026 05:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784352777;
 bh=kwtjjGmmiAFcJH+349xh1RmY0+cdYF3UnpCgzEY++n8=;
 h=From:To:Cc:Subject:Date;
 b=EOQtiaQ6nmW/x59ilsYVxtoSgBJj5WvdLTR4F05KRrRUGLktimBgD1StbpObcFt9j
 XXufM0cGb+rn5QRPxtgxqQY15aRP/45qMqzQyw6QkQjqa5rca+CcZzjVyMeKlCRiId
 x5bRucQYnwbsSs/4Hg+YaXG2pgUtZ6Lh7dx22ychuQgQYZSOx+1OuWyS1OGo5B4Bu2
 lFvNRHXO6z8qWFhah47bqUJLHcZg6xCqmzmZqYwfQ/Si9Vk3yLsnUFLpMLBuXpgZpF
 doZRxoWSeEx3rpAojEeimuJheITG7jxc1bIQUhXoYexbO78A7aWODd8YWKWasi28cQ
 nbBt+xSIEQdwQ==
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfauth.phl.internal (Postfix) with ESMTP id 3E035F40067;
 Sat, 18 Jul 2026 01:32:55 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-05.internal (MEProxy); Sat, 18 Jul 2026 01:32:55 -0400
X-ME-Sender: <xms:BxBbauwHm1FcfFvmUjGng9huZPoSRclRePWS7b0VkA--cU2vHYh1YQ>
 <xme:BxBbakFCAEwq9URGxa9JfhOhiNojXbKwwaJnWSuQjPDp00hUmDsuvlLK-vxfdwnEx
 mxyIUtNaUa3_GZJKrz9srYzgVuUcrdzI3Ss0a04xMGZa13t7lWuvjo>
X-ME-Received: <xmr:BxBbaryYUd35u1l0--7nv1GBJZf6twciiFCv0x18wAdN42Kyi_Co-2FMGerL7BbIlwSgvKBaduMWlD47rFdT4yVFmfGL7wQr>
X-ME-Proxy-Cause: dmFkZTES8M4nCmmYKnGMqobh3TqhunEGFElLNM+viRad93RdmeJRGfaj0RUMOtFBg6bXs7
 ypRH2PFkw0ks3z7mx1ng3QrV7lhgf1fSoT2136oH2jbEe9eoM7ag0CsJVTgNRR31HEuUg7
 YaUSD28NyGPwedMfKZngj2o/+7VJZGW1f/u4fz7QhpD8PDjuuOxyPNmNaRuF+xecSzJNfh
 u9MwMO+JdQEtSmeM/ZgcfqHqOtf5Ik3jzWJgBntXvL1J2CS8mFHvJZhx+DzRmfWOr1Mv9d
 80lUu3lcp/F+8I7Vz6nFvx4UxoWaXhdO8e3rKesyTqFCQYvNgIDmw3KjYp8Kux0JHTJcjO
 2GnoBLq6JKO5fF5OKZWIUK2LOvJ1RSiQMRWG3PqZfJkboQ9IoWIS+2e3nPa9gLGjyzzrGO
 EctPrVXKnEzF2+RZf4WR7mkhGQNIUXxdvuwnETBLLwA6S9GK6qZWJGUIa3WILNk3JlS5zp
 GfF5RHdxNfuM3+2TIKaNimuf+8WUiwPv3ARjlQZm2ZkB6c/jTDDec7tgJ6EYeoNvXJt5ss
 Y0H0M4WKwFjhA0HRovQGmgCy4ykb6gLtsVkfaFoA5W2RvVDkaYwKbEhpMfVuI3S8zEkdqE
 ajC9oE7GWZt30rlTAIOg01uzdJ4dngOidGReT9RsKS/FhiJUbQXFFOw/seww
X-ME-Proxy: <xmx:BxBbag57_HwhpOYMVPGkzpr6q6_JGmFSzKcxr2VuqzGR4aOHtHe2rg>
 <xmx:BxBbaq6-bfpiViAkVZVMbLud7Pb12b70zxBfx-5uUn5WlKXHT9q7fQ>
 <xmx:BxBbapKXT52eXSePdRzpL6iW-nlhuCSaRF3ok0KtMGYtQdbuywxUZA>
 <xmx:BxBbasEE9fe6KiG8C753GKmWtFz8EZAcPaDz08KImbAiXjQn-LHf8g>
 <xmx:BxBbam2ISzee3hCoD0_v6Px5DeOx0mMncavCQ3yd-e1qXTntz5AqTcOU>
Feedback-ID: i8dbe485b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 18 Jul 2026 01:32:53 -0400 (EDT)
From: Boqun Feng <boqun@kernel.org>
To: rust-for-linux@vger.kernel.org,
	rcu@vger.kernel.org
Cc: Miguel Ojeda <ojeda@kernel.org>,	Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>,
 =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>,	Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Tamir Duberstein <tamird@kernel.org>,
 Alexandre Courbot <acourbot@nvidia.com>,
 =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>,
 "Liam R. Howlett" <liam@infradead.org>,
 Andrew Ballance <andrewjballance@gmail.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,	Jan Kara <jack@suse.cz>,
 Lyude Paul <lyude@redhat.com>,	"Paul E. McKenney" <paulmck@kernel.org>,
 Frederic Weisbecker <frederic@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 Joel Fernandes <joelagnelf@nvidia.com>,
 Josh Triplett <josh@joshtriplett.org>, Uladzislau Rezki <urezki@gmail.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>,	Zqiang <qiang.zhang@linux.dev>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Yury Norov (NVIDIA)" <yury.norov@gmail.com>,
 Asahi Lina <lina+kernel@asahilina.net>,
 Matthew Maurer <mmaurer@google.com>,	Lorenzo Stoakes <ljs@kernel.org>,
 linux-kernel@vger.kernel.org,	maple-tree@lists.infradead.org,
 linux-mm@kvack.org,	linux-fsdevel@vger.kernel.org,
 linux-media@vger.kernel.org,	dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org
Subject: [RFC PATCH v2 0/4] rust: sync: Introduce Rcu*Box
Date: Fri, 17 Jul 2026 22:32:43 -0700
Message-ID: <20260718053247.25154-1-boqun@kernel.org>
X-Mailer: git-send-email 2.50.1
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

v1: https://lore.kernel.org/rust-for-linux/20260605133541.22569-1-boqun@kernel.org/

Changes since v1:

* Rebased on 7.2-rc1
* As Alice pointed out [5], RcuFreeBox::with_rcu() should return a type
  that disallows extending the RCU read-side critical section to
  outlive the guard. As for now, no user needs with_rcu(), hence remove
  it.

* Includes a not-for-merge example based on Alice's patch.

v1's cover letter
-----------------

(this series is based on Alice's RFC [1] and discussion around Philipp's
patches [2], [3])

As an easy way to provide RCU-protected allocation, two major types are
provided:

- `RcuBox<T, A>`, inner T will be dropped and after a grace period.
  Users: binder with maple_tree and dma_fence.
- `RcuFreeBox<T, A>`, inner T will be cleaned up immmediately and freed
  after a grace period. (Name suggestion is welcome). This is an attempt
  to consolidate Alice's `PollCondVarBox` [4] into a generic
  implementation, InPlaceInit support is still missing, but I want to
  get some feedback on the trait `RcuFreeSafe`.

[1]: https://lore.kernel.org/rust-for-linux/20260116-rcu-box-v1-0-38ebfbcd53f0@google.com/
[2]: https://lore.kernel.org/rust-for-linux/20260530143541.229628-2-phasta@kernel.org/
[3]: https://lore.kernel.org/rust-for-linux/20260520131725.266014-2-phasta@kernel.org/
[4]: https://lore.kernel.org/rust-for-linux/20260523-upgrade-poll-v4-0-f5b4c747eac2@google.com/
[5]: https://lore.kernel.org/rust-for-linux/aiLXWHg22P6OTb7O@google.com/

-- 
2.50.1 (Apple Git-155)

