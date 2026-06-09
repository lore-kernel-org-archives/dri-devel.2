Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DA39CD8CB9
	for <dri-devel@archiver.kernel.org>; Tue,  9 Jun 2026 06:53:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7669310E0F9;
	Tue,  9 Jun 2026 06:53:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="KrCLI2KA";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE3D910E0F9
 for <dri-devel@lists.freedesktop.org>; Tue,  9 Jun 2026 06:53:34 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1FE7B601E1;
 Tue,  9 Jun 2026 06:53:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FA4D1F00893;
 Tue,  9 Jun 2026 06:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780988013;
 bh=Ha02l9tKjKZvZzs0+Bg3GbO/Rqh+PK5W63qrRV3OXss=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=KrCLI2KAvAdgrs5d4E3VA5KnKt5MYUJ7WIkxyOdyBR5nyYDqLe7F7YYZLCd0nz3P3
 s5hlBW2GiXQnb++zBXmnrQRqwP+3KTm71xvyfCbFdfoA+v2P7OJchUbsVe9DTD39Vm
 aD5DPkjgjY7VUkyWTCx3at7Y1Uk+ysCeHqQLlD56+3nASQg4DyHIaZWweFSCvucJIn
 eNsvQOSRZ7O3YSB1+Gcf3RBNZBNORr9O0doOrJcYTbYN4LGoW+l+WBHwMYfo5f+pfN
 EHOc0qA4BubAlTKrToRkU8g+w5rVj1fqyn1ECg3sG0V4bYf7APy0mvlA9kvqKbmdi3
 BgJ1stEuamGTA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 02/14] firewire: core: Open-code topology list walk
To: "Kaitao Cheng" <kaitao.cheng@linux.dev>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260609061347.93688-3-kaitao.cheng@linux.dev>
References: <20260609061347.93688-3-kaitao.cheng@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 06:53:33 +0000
Message-Id: <20260609065333.9FA4D1F00893@smtp.kernel.org>
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Memory leak in `build_tree()` where dynamically allocated `fw_node=
` subtrees on the local `stack` list are leaked when returning `NULL` on er=
ror paths.
- [High] Unconditional dereference of `card->root_node` in `fw_core_handle_=
bus_reset()` leading to a kernel panic if `build_tree()` fails on the first=
 bus reset.
--

commit 814723ea200ca545cf7dcf5b3f733df13cc3c3f2
Author: Kaitao Cheng <chengkaitao@kylinos.cn>

firewire: core: Open-code topology list walk

This commit open-codes the topology list walk in for_each_fw_node() to
defer looking up the next node until after children are appended. It
preserves breadth-first traversal semantics while preparing the code
for a future list iterator update.

> diff --git a/drivers/firewire/core-topology.c b/drivers/firewire/core-top=
ology.c
> index bb2d2db30795e..df2ac0dab1060 100644
> --- a/drivers/firewire/core-topology.c
> +++ b/drivers/firewire/core-topology.c

[ ... ]

drivers/firewire/core-topology.c:build_tree() {
    ...
		if (child_port_count > stack_depth) {
			fw_err(card, "topology stack underflow\n");
			return NULL;
		}
    ...
}

[Severity: High]
This is a pre-existing issue, but does this code leak the dynamically
allocated fw_node subtrees on the local stack list when returning NULL?
Since the stack list goes out of scope on this error path, it seems the
attached nodes are abandoned without being freed.

drivers/firewire/core-topology.c:fw_core_handle_bus_reset() {
    ...
	scoped_guard(spinlock, &card->topology_map.lock) {
		update_topology_map(card->topology_map.buffer, sizeof(card->topology_map.=
buffer),
				    card->root_node->node_id, self_ids, self_id_count);
	}
    ...
}

[Severity: High]
This is a pre-existing issue, but can this sequence cause a panic?

If build_tree() fails and returns NULL during the first bus reset,
card->root_node would be left as NULL. Would passing
card->root_node->node_id unconditionally to update_topology_map() then
result in a NULL pointer dereference?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260609064122.9582=
5-1-kaitao.cheng@linux.dev?part=3D2
