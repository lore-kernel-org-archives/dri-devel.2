Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D308606A31E
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 18:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=IMeccm7S
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B6F4112CB1;
	Fri, 27 Nov 2026 18:31:10 +0000 (UTC)
Received: from sender6-op-o11.zoho.com (sender6-op-o11.zoho.com
 [165.173.180.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 272A1112CB1
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 18:31:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1795804251; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=GcMqO73PEdVaLiJBu5duohgpHn3k4/qNb5TYimDlaV7tEq8HCBTBrLkBwDrFjHZVYvw5q1VMjaK0WEu0wbXWZG50wFJRbxGsfwci766tf7Dx7hcBVfOQWlDo9xxUE/3oI8a4TKSXY48VzD+4G/n8s1ybxPk2VRCHJnNS/TS7jv8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1795804251;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=u0bfrnFDiXtdQaXbtRRFrG1L6zn8mx0JhpG3f4x8zTk=; 
 b=eOC3d2C58YVoUypwyQbfyw0Xogzt/MEb7FB3Cg64fBb0pOgbR0HQXaEznSrDhWCnMk11XRiHrhuhmkhiwMerA/kLAkr7nr4ybSumscDiJc8W2y91FPWCAJAfBcEX4TSCrAYl2LVgk1CMerJeVPkglbk2h3v6XeuBqb0X06URSH0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
 dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: a=rsa-sha256;
 b=IMeccm7SE7CGdiT7iDATyEoRNrVcxDsaK4EX+P0Qn2XLbAN59Ozz1WTZnmFYnP+mxBtNXseY7i8gAw6sRfUu6cSDwH6CPNVa2oP7fNUCtt+Y9iGUVO6eBHZu2D5w5CTjq2zd+KgxJ1KupcHhtQE0PvRqo91/+BsVAGPMtcGA6Io=;
 c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1;
 bh=u0bfrnFDiXtdQaXbtRRFrG1L6zn8mx0JhpG3f4x8zTk=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1795804248352169.23768707491956; 
 Fri, 27 Nov 2026 10:30:48 -0800 (PST)
From: Daniel Almeida <daniel.almeida@collabora.com>
Subject: [PATCH 0/2] rust: dma_buf: add dma-fence signalling sections
Date: Fri, 27 Nov 2026 15:30:36 -0300
Message-Id: <20261127-dma-fence-signalling-v1-0-c44e8f4910ca@collabora.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/y2NWw6CMBQFt0Lut02gLVDYiuGjj1u8Boq2YEwIe
 7eKn5PMmbNDwkiYoC92iPiiREvIUF0KsDcdRmTkMgMveVNVvGVu1sxjsMgSjUFPE4WRWY3Coe+
 07lrI00dET+9f9jqcnDZzR7t+W38j4nPLf+upgdEJmV3mmda+0MabRpaGi1Yibxwq71XlpFJWd
 E7xWjpTC4UwHMcHskWnM8QAAAA=
X-Change-ID: 20261127-dma-fence-signalling-cae3def9aa97
To: Sumit Semwal <sumit.semwal@linaro.org>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Philipp Stanner <phasta@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>
Cc: linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linaro-mm-sig@lists.linaro.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org
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

dma_fence_begin_signalling() and dma_fence_end_signalling() mark the
code that the completion of a dma-fence depends on, so that lockdep can
check it against the dma-fence rules. However, up until now, it was not
possible to use the signalling tokens from Rust. Thus, add support for
it.

Patch 1 adds SignallingSection, a guard that begins a section when it
is created and ends it when it is dropped. Patch 2 makes
DriverFence::signal() take a &SignallingSection, so that its callers
have to be in one.

Patch 5 of the JobQueue series [1] changes the same signature to
signal(&self, res). I will rebase on top of it once it lands and add
the section to its callers then.

A follow-up series adds a workqueue whose work items run in a
signalling section. Tyr will use both.

This is based on drm-rust-next.

[1] https://lore.kernel.org/r/20261124122951.878199-2-phasta@kernel.org

---
Daniel Almeida (2):
      rust: dma_buf: dma_fence: add SignallingSection
      rust: dma_buf: dma_fence: require a SignallingSection in signal()

 rust/kernel/dma_buf/dma_fence.rs | 77 ++++++++++++++++++++++++++++++++++++++--
 rust/kernel/dma_buf/mod.rs       |  3 +-
 2 files changed, 76 insertions(+), 4 deletions(-)
---
base-commit: abfb640b2374e26de8ff81d488c39d8254db538e
change-id: 20261127-dma-fence-signalling-cae3def9aa97

Best regards,
--  
Daniel Almeida <daniel.almeida@collabora.com>

