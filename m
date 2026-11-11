Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4726B606A31C
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 05:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X22D++bp
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D7F2210E0BC;
	Wed, 11 Nov 2026 05:23:39 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE77110E05F
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 05:23:33 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id BE9CC61D7A;
 Wed, 11 Nov 2026 05:23:32 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1794374612;
 b=eCv2ps7OFAl7TdTvswqQAuZxUkvS6E5njbLAfp8B7r10qF3wDjrXht165VVWBL3d80an
 CIyoANFtArhM8YRPV1Wvih8JzYSOxbdenJmkn1TI3vMTGho0ZqSNkJafjW3PMLbo7RDCE
 skfDa7UhZRx/VHiGD857RlXH0XN4C8kXlsS2ojWQUr79nuBSBEvPGTGYETDd1PgPytmOR
 neJKjvCPeQX/lf0S8+d8NY7kQ/dcCNKL3ILRgb/Qttp4szzV3EEpXWz7gofctvB4xaLaK
 wh18c6uYr+h+0NzBaozEjeiFu2g9WdxS0log58EeMMOP2JRwe5vz2YwD7+ztzWXTKxw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1794374612;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=9RACgfXqxEW7DMRyULabdQj6O5k8oCjNhfEx8/b7070=;
 b=wv2WHvKmoVYYEC6ZhyZgIKxvt+LgmZEFWYiskppTNoVymdxd0SDpBlfM4mIt7N7/HROy
 mOtBq0Gyb7e38e0UUerI0ie7jY3JmphMIa9F+MJsWMyr+6laDmlXTrroHj1eKlM8QcrtW
 ygaeEzVTnuBL09pK7C+QtCfGeLUFCZOzzH60o4F7Wtu+iHFN5BsBefAOg0chTWJilGT+r
 hDfSVVQsmOTprDIGJLN8oKl8UaiEAkyEkBgqAe3K5BsCXbv39EynLsDFFQeN1LJkKHY2n
 q9r4bMM/XnN6ofRa08Uk1lPdHaz/nhNg/x/7C4valpuaawVJkPi3C9dIHXY9JWQ2gMQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id D5E6F1F0089F;
 Wed, 11 Nov 2026 05:23:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794374612;
 bh=9RACgfXqxEW7DMRyULabdQj6O5k8oCjNhfEx8/b7070=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=X22D++bpy+Lf5Kyl5ZE1zoCMXZjUbIeRo+ANtMVw3MI4680vsotnQXL50Dble4Uhj
 lrokGddMaM/THcztUxaOPrzjk5wbnHolPVvBvi5PbY2odougPoMDXClDV++onisOI+
 QF3mbZ3etiOb915raDoUZEm3e+BocUVKM5jJWl/90c6oOJOxoU8mO/KceSj907eiIq
 HZxxFXn1/YpJejGiJ9gvaK3d8fU8imHPcPU2dlfJ+gmx0pLSV8qhsnHK/vro27IULn
 Zo2LvkYwJ7RrNuo18Y4/s0tXEaaZ3/CEAMNbdglDh7QbFN7KC/NecuIDvYs6UjPF2C
 BQAa78XAwwBfA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 550AA48DBD;
 Wed, 11 Nov 2026 05:23:31 +0000 (UTC)
From: Dave Airlie via B4 Relay <devnull+airlied.redhat.com@kernel.org>
Date: Wed, 11 Nov 2026 15:23:24 +1000
Subject: [PATCH v7 1/2] rust: time: expose as_nanos for clock sources.
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261111-nova-timer-v7-1-3031c2476551@redhat.com>
References: <20261111-nova-timer-v7-0-3031c2476551@redhat.com>
In-Reply-To: <20261111-nova-timer-v7-0-3031c2476551@redhat.com>
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
 b=owEBbQKS/ZANAwAKAQx081l5xIa+AcsmYgBq8/vSkG3bdpelMCxucgoWBPx4cJxEDlRmt/Azw
 hHaVrTnRwWJAjMEAAEKAB0WIQQQptkdobBb0p9t66wMdPNZecSGvgUCavP70gAKCRAMdPNZecSG
 vqwAD/4xYad2O1hVWkteur7JpWt4xlI5qAJ5V0++0k1no4GDrZ5XEUbsoRvT1rWf9HhP4re/rug
 FsPKhwXTbgi2krQpPdGGi2Lfi7IpL2mhC4f4jbK+1GUQPIQzECj4rd3pBsrdpMBUyWEGhfFMK0o
 /GY2MkJuHBBIQ00tTIn3Hp3Dc6QXl78l5BtSsN3pj9JFQhSTbLAr5GaFbz6yp94Swm1G5Ffg9Pi
 K07QvYKn+ewLB/bgXM5DhhwaSIUYq/GfxJ23m9cEQ2NUWZ3mP1shr14QXq4xzUgpBv/WiOKlr6f
 AYUJ6Ksr6UXRuQdvAq5J2o0LC9G324tnaZIW6PtpqFcO5xkxUaH5kE7pzcWpX84xsMT3kZqfRNw
 EmF6T9E7uqA18CVdLOicxqKFpYlX5GL7Ye4FW1N89Tqx3h1f6UUleaoDGRqXZd7UvaRB+zz/MEt
 3cnpNxAYtJGakK7lLxEg4oe4Rv9a0ImX95IgpHdtKwXcIDk7qTpGU1LdbPPvUjQiwQLheM1KNF5
 UXhfrmTz6Qa+sFjZgApS54LOh27TwKqn/KKFLLkVzXVSdudM56L1ocfQDWBwqtzp/tw+LO/hBkx
 vQr3zOuy2B1VfyfZBPjPjF5tcb8b/YQ6xoS5dTUV9YGHhV3d5YjYs5pOYMBtA+GHPNQi+ErKwNq
 JP0DDTa/pmUZegQ==
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
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
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


