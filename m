Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2CC8606A324
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 00:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EcyZqooR
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5ACE010E76E;
	Tue,  3 Nov 2026 00:34:01 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA65210E76E
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 00:33:54 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 529AC40A6A;
 Tue,  3 Nov 2026 00:33:54 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1793666034;
 b=ERKh/OdWBYnDY3EU7MxLPPHU3Q/7QpDMdMXIiHeAK3SIKhoakx38KYn59osVUugdHtso
 TDsn4uo1k0E4VWg/2zvrIWlbPleACpPYiQ0faLYJgYCZ7/ZBBnuzSRpmdHLHK5v4TOiGL
 G2Gi4zFtFGVcRG/XeROLBgVAD7p7jr8M1kMyttYbkW5ZXnhhKy1OyX3rOwQB0WX4tk/2S
 ShrDxwHpEWCdCuQfsyarzTS9VxHsn6LfaD6A5jfLuEx1g/bICZh0tEn+QwmorvToksi89
 bvK2c5He5zOoy/9QiTMOmhT2PRRIFZCiWOIf7VHJtak4VKazGltCE8uc1/Igip7c5Wg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1793666034;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=CIZwBicKTVVZGS9q/v6H0FbAbpUFwd+2SA14hRFFKAg=;
 b=IKGY00XBmDWtFtOOswGUTaTIISx9kD8/+YJEE51EDNirl1UfeKL6oRvYqaAQT4Tqhnn3
 e1AAsLHso4PAsPrrn7yqtq91J3DUtEftgiL1hRYnHYpv9pwrgTFZ+maY2tiSoAnMY4iS4
 XhDkKQeaUPE84aUeNyv+SealhP+HUMgUGbEKC+D0wY768t5kOhUmlcmE3ZyPf82hhhlwl
 7G59J+0P1aKS4pRijPHn1QRylv4Tu/5h34gnceXibBECPoYzgNXc4xsWL39W/2TVySEqb
 ORQWyMO/aQwLcp+J4vUSpmx+qy1kLpLbHzQkwiHA0arvwQ10aPxAafcv28VBlP2yiyw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 9F5001F0093A;
 Tue,  3 Nov 2026 00:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793666034;
 bh=CIZwBicKTVVZGS9q/v6H0FbAbpUFwd+2SA14hRFFKAg=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=EcyZqooREmzrOkJab6wQdcpsgSdBnAR0laDrNKyCxWl9NxB8bBA6UF60xnTr9Azm7
 1SS1WRtPvx/jGFUb561svhvgvKd2ppB8Re68i7TKElvDJ9xTuEpGEhwr83gx/HhFXj
 S79mS1XNGUqz8KVNoGuJSTQroFlsvyH17x3R3OJkNybxKqz8fmD5mkr59XEAv9l9Zn
 J3abAmGV7pzauvBdFVJtIeiDgHzhUTrGEhrqyafr+Xpn7ehU3CrZPe50uDZnm1Io0I
 5nVGQfjV2MgY+mNTd/OS3v6JZDgl/X06AhTIO4zHU944FQaWwEWvZilpzCdR4W4tdA
 Akia4r2g3ILsw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 10CC94670F;
 Tue,  3 Nov 2026 00:33:53 +0000 (UTC)
From: Dave Airlie via B4 Relay <devnull+airlied.redhat.com@kernel.org>
Date: Tue, 03 Nov 2026 10:33:38 +1000
Subject: [PATCH v3 1/2] rust: time: expose as_nanos for clock sources.
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261103-nova-timer-v3-1-0cf9bbae8fd9@redhat.com>
References: <20261103-nova-timer-v3-0-0cf9bbae8fd9@redhat.com>
In-Reply-To: <20261103-nova-timer-v3-0-0cf9bbae8fd9@redhat.com>
To: Andreas Hindborg <a.hindborg@kernel.org>, 
 FUJITA Tomonori <fujita.tomonori@gmail.com>, Gary Guo <gary@garyguo.net>, 
 Alice Ryhl <aliceryhl@google.com>, Danilo Krummrich <dakr@kernel.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Alexandre Courbot <acourbot@nvidia.com>
Cc: nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 Dave Airlie <airlied@redhat.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=792; i=airlied@redhat.com;
 h=from:subject:message-id;
 bh=pY3ItZTyRBqrXe1s0swCsV4mLrXTPTHBAc2wQUfEkfs=;
 b=owEBbQKS/ZANAwAKAQx081l5xIa+AcsmYgBq6SvvuMdC0YZcKfwwRh5+Chrb8yGgeHkwOrhnn
 qssdm91hpWJAjMEAAEKAB0WIQQQptkdobBb0p9t66wMdPNZecSGvgUCaukr7wAKCRAMdPNZecSG
 vniPD/9aSMYxOBOjmA7A223lAdd7J2iJcfUjUEoueoZHWD9q6o+1eROV5AcWcnwbGU372ou77j9
 Q6Pyh2mUB8wzJpqZMSHKCbwp8u5oXcdNGHCRb3LwpDmm3NOU9D9rQ66d8sNlLwdw6fiEaS7rTao
 h8NR2MU4/l6m57od5jN7+eJeKT4QhpiiHxDOyu9n3NZTVNTrHx0nowBcLGjeIc03EaTS2bcg5MV
 N+PiMoEFxCZ4zEc+Sky/xoqiFne8YUPVeWvSVxOoNjs2YWaoQaunnFFqbgoktm/+kqV95tufY+D
 3+iwPVDSH7vzuyeN5V15mMcjk0lWUFFk4FYVu4WOBsPvHzBIAwFm2e/NvmEKqYHDIuQ9RcZkiu+
 O3OLFXPH6AEVxR881tR4pTQiUkl5eQBZS3QWrK8i6TpAroQpALKkx1H8luSa096zYmr1WDNFCfp
 5ema1ki0ky5o0eIriRQYeZV+2Wp0F8T/DOSsutHuHUh5HsCb+OKnWbEKd3eLFsUKJW/HAkit7zX
 k21+uPPOq0NF7mQb2c5G+gXB/bv2IO9UAXyNyDISNQgZwpjyHuU0KZwQ1KwWiKBErBYVdiI7b2X
 3H3nxd8/3QoPtq77CbS/QvfVoiUfTpt4x93+L8f0hyZiBrSXgU+ipb8NEl/YnnjHqGPIDy0kJvR
 WqNwrvbBcn8sLqQ==
X-Developer-Key: i=airlied@redhat.com; a=openpgp;
 fpr=10A6D91DA1B05BD29F6DEBAC0C74F35979C486BE
X-Endpoint-Received: by B4 Relay for airlied@redhat.com/default with
 auth_id=1321
X-Original-From: Dave Airlie <airlied@redhat.com>
Content-Transfer-Encoding: 7bit
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
Reply-To: airlied@redhat.com
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Dave Airlie <airlied@redhat.com>

The nouveau C driver does ktime_to_ns(ktime_get()) to program
the cpu ns into some hw/fw, so allow this method for rust drivers.

Reviewed-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
Signed-off-by: Dave Airlie <airlied@redhat.com>
---
 rust/kernel/time.rs | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/time.rs b/rust/kernel/time.rs
index 6c0a5e8090d0..a91ddf04785b 100644
--- a/rust/kernel/time.rs
+++ b/rust/kernel/time.rs
@@ -211,8 +211,9 @@ pub fn elapsed(&self) -> Delta {
         Self::now() - *self
     }
 
+    /// Return the raw nanoseconds values since the epoch of clock `C`.
     #[inline]
-    pub(crate) fn as_nanos(&self) -> i64 {
+    pub fn as_nanos(&self) -> i64 {
         self.inner
     }
 

-- 
2.56.0


