Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C588CC55182
	for <dri-devel@archiver.kernel.org>; Mon,  3 Aug 2026 20:46:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C058D10E091;
	Mon,  3 Aug 2026 20:46:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="HLIrXYCi";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 23B4B10E091
 for <dri-devel@lists.freedesktop.org>; Mon,  3 Aug 2026 20:46:27 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D05DF437D5;
 Mon,  3 Aug 2026 20:46:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70EC51F000E9;
 Mon,  3 Aug 2026 20:46:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785789986;
 bh=CKukr0kKtwGlYBu1PNlJeaKZSMwsaeEvONoBJmI2Ijs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=HLIrXYCidf5yZItQJ7euKmQldxLQCaXhOLLk7+CqYVwi1Yk5S5RH9J2C3YA2PLMUt
 bSPkfUEm5gPFbkguhIFVPIu9XZCmm7FgK2ktiuDnu0xOxMJXp0yHuB4d1fbVJk3JNB
 xeASrv82DkF5BK8tcWVFhhVeCAgpDBPNHQm39c7kcJ4A0bQs0FETb32ojwjyh8P0lO
 IWHCRw9xiOobhkmWXvCBveItkzH++Fc4n2ytv58jN3AarfZTFZ7Il5tgYuEkwrSI96
 xqm80uo3hD4JZTN9Xj3LIQhylOJeblmZjTvJk6ogpHbSMTAVFR7FpYrYyxDvIGJHT9
 Gw0ke0VgmqAXA==
From: Danilo Krummrich <dakr@kernel.org>
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>,
 =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>, Tamir Duberstein <tamird@kernel.org>,
 =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>,
 John Hubbard <jhubbard@nvidia.com>, Alistair Popple <apopple@nvidia.com>,
 Timur Tabi <ttabi@nvidia.com>, Eliot Courtney <ecourtney@nvidia.com>,
 Zhi Wang <zhiw@nvidia.com>, driver-core@lists.linux.dev,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2 0/3] rust: io: register: a few fixups
Date: Mon,  3 Aug 2026 22:46:19 +0200
Message-ID: <20260803204619.3606521-1-dakr@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260724-registers_fix-v2-0-a0fb58b02185@nvidia.com>
References: <20260724-registers_fix-v2-0-a0fb58b02185@nvidia.com>
X-Patch-Reply: applied
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

On Fri, 24 Jul 2026 20:37:03 +0900, Alexandre Courbot wrote:
> [PATCH v2 0/3] rust: io: register: a few fixups

Applied, thanks!

  Branch: driver-core-testing
  Tree:   git://git.kernel.org/pub/scm/linux/kernel/git/driver-core/driver-core.git

[1/3] rust: io: register: dispatch shortcut rules internally
      commit: ebb314763f97
[2/3] rust: io: register: remove unused rule arguments
      commit: 78e9b4389231
[3/3] rust: io: register: use path fragment for alias destination
      commit: 2230d3882850

The patches will appear in the next linux-next integration (typically within 24
hours on weekdays).

The patches are in the driver-core-testing branch and will be promoted to
driver-core-next after validation.
