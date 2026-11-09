Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EBBD606A321
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 01:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nk1AtBOJ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D51910ED11;
	Mon,  9 Nov 2026 01:56:15 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE20910ED11
 for <dri-devel@lists.freedesktop.org>; Mon,  9 Nov 2026 01:56:09 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8C304609D0;
 Mon,  9 Nov 2026 01:56:08 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1794189368;
 b=sBShR0MhVXeBgiq9TRHgTf/V3WcFfhgvVU98GtMV7ZQuHemmnKTFR6Nj4+Il/tgpgz0O
 uJcng9myFLiv0KsUYsKVaqrcex09rwxczP3ZjfxuKg1BvA0thuGQ2N5cV+k3R6i3cxq/d
 BB/VeAgNSoVy/nAOQMpykZFx5zXXvnhsqJDYlsURty/LbZ3kp8X1kcGjChAvGPM8drOiD
 7OZiZCT8zIxQHW22yI28Ffp2mXPOMJmGp5CbDqb2qKXn1IzS9TcFkLUhkg2WCoQk9odi0
 atKIshNR0o8i/7Opd5j6IDb30pdhVIrZLpWIX5+DxDbyUgFiOerMuJU9XRalYYqeaMw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1794189368;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=9RACgfXqxEW7DMRyULabdQj6O5k8oCjNhfEx8/b7070=;
 b=I3YdTeIeoNhI6Yvm8jC2dODWg5TaijIQRlKQMkV259BVI55pPtqfe5FdjYGQp9Yo3dOy
 bgviEds8YxN/ULt2g8qnxMtogjrvw7+W6mlVP2FYABJmcuiNPMxmBwY28ndPg/dC+3RPt
 NBakk7IWEvFvSVSrISOwCvf38yvZ5Ni08lgx0qt9dit4GdnTrNCqX+BRJDJGp8onqW3mU
 FFoeqqGsQyVbYls9Z6BjR0b2nW0UcyZ7lOqpy9dKWGthg/1aOOlh7dzC675SyvylftJoO
 WeBHC2vLFT3FEqLOgdzOh23SjiFIoQt1XQeMrzimEh1aLCPfxf3Wnf/hp+VP5oaeU1Q==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id A9D0F1F008A1;
 Mon,  9 Nov 2026 01:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794189368;
 bh=9RACgfXqxEW7DMRyULabdQj6O5k8oCjNhfEx8/b7070=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=nk1AtBOJetZet0r20FUBC9vFgPPZj38D9D5oymI+Tfm6YK5oDTumL3so+DU7maOIx
 OgG/+eEJbCMgSksar3rN43/jaC8nRLxTQkw0y4o2TEgJWMBzlbdqIei6locmyKLXTY
 KFwBjNVnoS0uYZKjPIGmv3y7NkHqEzMGWTiIUZyOWfvuA4I6+bTk6s1cPnr7o+qNgU
 /LKVrbbqcU87OzqaEJHffctu1p5YGPEvaetAKhJfGHHAz7X7r7HU/kTsYmVqk2WkTa
 4obn5rOFgA3qe6bvM/nK2K0MOpSYBN55CSk/aUGFkxQ20Z3go/YgplCCW91VYBSArU
 itEOYdKLGmM0w==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 2738648201;
 Mon,  9 Nov 2026 01:56:07 +0000 (UTC)
From: Dave Airlie via B4 Relay <devnull+airlied.redhat.com@kernel.org>
Date: Mon, 09 Nov 2026 11:55:58 +1000
Subject: [PATCH v6 1/2] rust: time: expose as_nanos for clock sources.
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261109-nova-timer-v6-1-5544a3bd8b28@redhat.com>
References: <20261109-nova-timer-v6-0-5544a3bd8b28@redhat.com>
In-Reply-To: <20261109-nova-timer-v6-0-5544a3bd8b28@redhat.com>
To: Andreas Hindborg <a.hindborg@kernel.org>, 
 FUJITA Tomonori <fujita.tomonori@gmail.com>, Gary Guo <gary@garyguo.net>, 
 Alice Ryhl <aliceryhl@google.com>, Danilo Krummrich <dakr@kernel.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Alexandre Courbot <acourbot@nvidia.com>
Cc: nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 Dave Airlie <airlied@redhat.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=890; i=airlied@redhat.com;
 h=from:subject:message-id;
 bh=3VDfb37tDtN07HLm+c2mhReutHmj5DLfx9YKQGaiDDc=;
 b=owEBbQKS/ZANAwAKAQx081l5xIa+AcsmYgBq8Sg1nwJDFD0BwL7AahvaGXI2t3glOckQwM+Jd
 G7L6eePEQ6JAjMEAAEKAB0WIQQQptkdobBb0p9t66wMdPNZecSGvgUCavEoNQAKCRAMdPNZecSG
 vomnD/41GUlSU79VunLNAVJgpObH6rSqjWEgOpIxgSFJtqoBJEWGBmLaqEDPlYupjFw1SNEltI/
 fyg+E9C/6utZrkXPB2jjePzMho8oGfCnMvVCrGWD+RTjmHirYAxlBTh6DFUo4vC3Bjv/oU+Djo5
 XnvZg90gjOlNNW3ClRJpzbDmxFRz5HXSP7Iqto1DjoGL0csuczfu9ny5VynOakrIbQKWsxPeIAK
 OT/Vbq/dGpvuMbtn1IE/QifvxCmAVSZPdHWUtxSy3AlVbgC8Dj+DoSCCdq6BHT/LnNgg7cTdENQ
 62pjE5dExCwU2N05PQWyb4r14hNvsaL+q82z+jwkBdEKXvMwvUZitX8JMbACc84gXiT41J7Os9l
 MLxG22bYcjiohEJy1EPj+WET+GyH7JYJarfBLwtXVFJAjGXFFRhqAX6dYPhKHPk01hylEnM1nGM
 7nmNyYJelB0ywy6iUhP2YNEIav4483TzHHW0hTUOBexWtPCoXdkvbAJkDI5hnU7NkNzn6bmxccU
 6VpVsRwse2jrg1ORoiCJ7b0sOda7Aww2pJNccrFWfdVI/aZVeI4eaeJGMkG6Q8hk71kmLPFxt7Q
 YG98iY+fcYve4rjU2CojT6c4bgZVZAK+QRhWeZiohmNzLEKHo/pPi1CMS5orDbzlGhZm7j6mV6M
 beRiS+SReIrcZFw==
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

This is needed for following nova patch.

Reviewed-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
Signed-off-by: Dave Airlie <airlied@redhat.com>
---
 rust/kernel/time.rs | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/time.rs b/rust/kernel/time.rs
index b6a2aab12a50..4409291f3ffa 100644
--- a/rust/kernel/time.rs
+++ b/rust/kernel/time.rs
@@ -215,8 +215,9 @@ pub fn elapsed(&self) -> Delta {
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


