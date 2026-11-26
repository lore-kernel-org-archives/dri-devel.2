Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E4FE606A31E
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 16:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=NBrMf/dm
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D1A6C112582;
	Thu, 26 Nov 2026 16:05:23 +0000 (UTC)
Received: from sender5-op-o11.zoho.com (sender5-op-o11.zoho.com
 [165.173.182.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DBFA2112582
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 16:05:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1795709083; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=dkJV7LWKL/rZZMifblFI3iCphtTkx+fEJC+IYutOU4ksPsVlF/CvwEgGGge5jW0L9BLXexsY8AYbv3A4y21/KuWx+4EEH+Wh5ywXjnxdY6lv1iphANFotiC1rEPRgVWOjf28qGJ6Z+/NoOkJ6c7lD+1WYLeuyvYJj18FxXV7Jhg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1795709083;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=Yyxvp9gohrAV1EarHFGlcgh89ssvG83TzXCqeBFpj4U=; 
 b=AMeh4Q/vGnEw1/zv6Al+LJMiYgPAQ4jQChp/aUy+ugDf2s1lV2r0S6uaWfL5130FdSG1liop+D366m45n7+TGttvOSxg/Ji4gLLMMpOX62BChi+MiewHU9hGyVkyaZ3Hnm+CM7yQeuCx+QFZLxVPSXyS+SF6CnPkKwdtBxrvKcE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
 dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: a=rsa-sha256;
 b=NBrMf/dmCTCdveLaejZVhlg9ZJ+EIoVWEWcG9jUkq4rGeduhUdLpVpYguOgHIeEN5bhzU0OpFK28lHJOELqdNon1Nb5MURF5whDZpwQtzC8JgTxyW0BxiRsqCFPnFGaKpGGIS+JYRuxff6XdLmh5umWCCasMM/gw+wSPPdrwc7g=;
 c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1;
 bh=Yyxvp9gohrAV1EarHFGlcgh89ssvG83TzXCqeBFpj4U=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1795709079389205.15445158410614; 
 Thu, 26 Nov 2026 08:04:39 -0800 (PST)
From: Daniel Almeida <daniel.almeida@collabora.com>
Subject: [PATCH 0/7] rust: reset: add reset control abstractions
Date: Thu, 26 Nov 2026 13:04:27 -0300
Message-Id: <20261126-b4-rust-reset-v1-0-9c4c3d029080@collabora.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMOw6DMBBF0a2gqTMS5uOCrSAKY17CUACaMVEkx
 N7jkPIU955kUIFRV5ykeIvJtma4R0FxDusLLFM2VWXlnXM1jw3rYYkVhsQxtBNi8ChrT7nZFU/
 53L9++NuOcUFMvwld1xfvTouCcQAAAA==
X-Change-ID: 20261113-b4-rust-reset-ca5deca6e036
To: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, 
 Detlev Casanova <detlev.casanova@collabora.com>, 
 Nicolas Dufresne <nicolas.dufresne@collabora.com>
X-Mailer: b4 0.15.2
X-ZohoMailClient: External
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
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series adds a Rust abstraction for the consumer side of the reset
controller API. A driver can get the reset lines of its device, as an
exclusive or a shared reset control, and assert and deassert them.

This will be used by the upcoming rkvenc driver that my colleagues
Detlev Casanova, Nicolas Dufresne and I are working on, to recover a
hung core of the encoder without stopping the other one. More details on
this driver can be found by watching Nicolas Dufresne's talk at LPC 2026
[0]. Samsung's Rust UFS RFC [1] also uses reset lines, through an
abstraction that it has not posted.

The abstraction follows the regulator abstraction and the clk series
[2], with the reset state as a type parameter.

Patch 1 adds the C helpers that patch 2 needs.

Patch 2 adds ExclusiveResetControl, with the Unknown, Asserted and
Deasserted states.

Patch 3 adds ExclusiveResetControl::get_array() and
get_array_optional(), which get all the reset lines of a device as one
control.

Patch 4 adds AssertedGuard, which asserts the line of an exclusive
control in the Unknown state and deasserts it when dropped, as a
convenience for drivers.

Patch 5 adds SharedResetControl, with the Unknown and Deasserted states
only, and patch 6 adds its array getters.

Patch 7 adds ExclusiveResetControl::devm_deassert() and
devm_deassert_optional(), for drivers that only need their line
deasserted while they are bound.

reset_control_reset(), the bulk API and the shared devm getters are not
covered, and there is no guard for a Deasserted control or for a shared
one. Nothing in the tree uses the abstraction yet.

Patches 1 and 2 add the two new files to the RESET CONTROLLER FRAMEWORK
entry of MAINTAINERS. Philipp, please let me know if you would rather
have them elsewhere.

This is based on v7.4-rc2.

[0]: https://www.youtube.com/watch?v=75E15eHY7ac
[1]: https://lore.kernel.org/r/20260912-rufs-private-v1-1-716db733e655@samsung.com
[2]: https://lore.kernel.org/r/20261013-clk-type-state-v6-0-a5e9977b3509@collabora.com

---
Daniel Almeida (7):
      rust: reset: add reset control helpers
      rust: reset: add ExclusiveResetControl
      rust: reset: add ExclusiveResetControl::get_array() and get_array_optional()
      rust: reset: add AssertedGuard
      rust: reset: add SharedResetControl
      rust: reset: add SharedResetControl::get_array() and get_array_optional()
      rust: reset: add devm_deassert() and devm_deassert_optional()

 MAINTAINERS                     |   2 +
 rust/bindings/bindings_helper.h |   1 +
 rust/helpers/helpers.c          |   1 +
 rust/helpers/reset.c            |  67 ++++
 rust/kernel/lib.rs              |   1 +
 rust/kernel/reset.rs            | 870 ++++++++++++++++++++++++++++++++++++++++
 6 files changed, 942 insertions(+)
---
base-commit: 7475ea8b58616b33c04afb976cf0fbaad9dd63fb
change-id: 20261113-b4-rust-reset-ca5deca6e036

Best regards,
--  
Daniel Almeida <daniel.almeida@collabora.com>

