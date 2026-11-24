Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75354606A31E
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 11:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=jannau.net header.i=@jannau.net header.a=rsa-sha256 header.s=fm2 header.b=UtjZgM6t;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=sSGjM3jL
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B46C610F4AF;
	Tue, 24 Nov 2026 11:38:30 +0000 (UTC)
Received: from fhigh-a8-smtp.messagingengine.com
 (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 339EC10E82D
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 11:38:06 +0000 (UTC)
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 5E043140028F
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 06:38:05 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-03.internal (MEProxy); Tue, 24 Nov 2026 06:38:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
 :cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1795520285;
 x=1795606685; bh=4pnRx9tbKf4Th+8RC2mcYdqOKcIE+uZxqRRIKitgEd8=; b=
 UtjZgM6tjaqYgwghyymP15g/H8hdopwSVwBSx8IDBTeAApQQLj6kb9O/XY3X/hqS
 mD+Q6rc3bE7hWu58EpkrXI/essPYtt333edwkntE7/fiivv/Yp8iE2p9DUWQ3dBw
 871wpF8MzQ0migYgrVcsCNJtDP3uEF1SJGhlcWwESs6OiIAYTbrYnVGWdb2GiQl0
 2tQudtzb8vAGDp58WL4hthqfoyLVpzEHaPZkwD9hxlNqwVxCCyqGtp7TUd2ZIB4b
 drzU/TEd2RnktIwnj4P0WWbImYYNwBrje/xr4M9cOSegTQbu4zBgXYSuoaKP18bf
 NKyVuj2bjwGiNVOIfipP7A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1795520285; x=
 1795606685; bh=4pnRx9tbKf4Th+8RC2mcYdqOKcIE+uZxqRRIKitgEd8=; b=s
 SGjM3jL7pcts6Qv6gra6sI7ImBqOVGz4avmW/z+Fx1F6LsrdbFfMY8NrdIiykcIF
 3ul3CFsO7Tmrnf7T2XwnszW2/L9y+to0JclFIerGOcCOcR1vx63bXakmUn04w/Mn
 dQ5QaG5w9qKoGx+R5kCeA7+z0x9bvXaz2bKc7QOyTU1ibfuuD0Te+Qe3C8P/b8ZI
 QlIJpdAqcJoVPYfUmPR8ZFoJDxHzbik8zT57J0vKljFxilP6v0f3ShorhGFQVsoa
 5vo2W84Ih3oo4QKBEVyIRYpZKy8Of/j7b1rIuL9TjxR4I81nELYFQoYgz15bo260
 v2+eSYPLE6M3xv2g4cXTw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=sign d=jannau.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795520285; d=jannau.net; mf=PGpAamFubmF1Lm5ldD4=;
 rt=PGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmc+;
 s=fm2:rsa-sha256:umF+vZm4h/8Pb+D70/XqSmWMQGQ9tcbztR7OET59yrgh+Pa
 w4dAdUBLVvZZFYTbA34wR8bTPcaqj5/hVF8hqK3RciZOETLlVZxHh2meCNFOzMYI
 IYLUatOWIi9XBrxkRVpXl8fZRnOk6htn5yFiDhlxa+6wccVmsVDC/yybHmf2WvmX
 68ESay+Hp5f1j3AO1leRANDZb639szPrFoEx/et5Xc6jlzL40/gC4dyBTuvFUY4H
 nVR7sSnEVw3b3plroP/NuadTAOSaLd153rWXj6MuO9d4J2oGpfa92KF/6/Wa182D
 TmwMBIstmmTGJjvn2GV/GsoErTZYg8KoIXA4+pQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:4BHTc55Eg5Ed5bet6zPH7BQAZtVD9ox8IUdB1UVPSeE=:+rTwIp812E3TQ2SXEFrxp2l3Xc56tLTc3GxmKfSW4CU=;
X-ME-Sender: <xms:HHcFa7F8XSMwnu74NSAW-OmHKGas7R_VDCwuWx1_wOvR9F3u1PcoNw>
 <xme:HHcFa1xj29DU_MHfs7GzTrEQv0F4-obbtTknI51Go2SnNmOxcga_OhN0PSD_1Mv35
 WOotXCrtLodKBqJg-j6Xlo6c7ZN52A0hLETlU91s8ggFuzdX19TT1J9>
X-ME-Received: <xmr:HHcFa9GxzoeW8DIlA3aYKE7WPscTw0qA83GQE4XeVig9v00_oDCFP8Tfz_hkLlGFN6bIKgD7UWreb82KgB5nstW0A8z1wtFiheFWKw>
X-ME-Proxy-Cause: dmFkZTFNViHC4iUIzeyK+SrJDhuFfMbwh5mlEWk7nAojISomFsBr8pxctFRgoX8aYqaMe/
 OHDt7dpmLWHJHRUIFC0d1UqGhDJJJS+Sr9UOtJAwPuIMq5GebmXT7ExiCDpUThT+zI9OB+
 xofoRAa1/NS86xvue5n6Yk4yy2lPuHYzplm1oYvQM7L0RPD1IW1cJw50mkAOYCOCJMTO6P
 lRzxf3Li3IuV318xHubZ0p0zxjhlXDQ3r4jBCPMEywoAsTuDjaVMJpMOFDV5ytSEwLqShh
 5WeDA092CNevX2tyArpKFo1DUVm5UEpRpGaLXX/D84hpZm5/RUClqbrQl9fQfOS1IUNEG9
 X51voZCGf6/FOt1T7OOGjxlJXGRv+XA0q7EtYOQX+XNZHaTaIBIiruOp2ae5Y8O2mYQYoF
 KPkvb8jK1i+ELDs8zVWuxbbV6Mn8iU0q0G+sKdzKCbBBSYqeYpTIr00MwphdJyPPs6wrf9
 Px9aSoEQ4ywJS687Oe/yl2xy0cUq2RcR6kwbTAd+6nD53TwmmGbZZbh+lJbIEsHFYhrMaz
 Og5ttSRNm/cQXJxfC3CB+HNc5c+LSiR6QS7F9wyMbTpSNn/xhgAD0QhYK7DulHoG8wmxof
 RaYVINCx2dN92UB9D5NSNgYzYMfN1cK82cYOEefv905t10loZTmM7EQvp/5w
X-ME-Proxy: <xmx:HXcFa6sUtBsx00i1HSanhF3ToZViGc3gfw7ZcMY0b1wil4V5j3ZuAQ>
 <xmx:HXcFaxXHphiHC8tdZpzX2wVDKP1bZcN7ti1hOxk6fo39zZzAo9X7fw>
 <xmx:HXcFa67TmQSBJWzzYAKGxDoA3j8p_fEhLGL5C376Pc7YOmjKahEkpQ>
 <xmx:HXcFa1be5nuArNCzH2wiPK5mUK9dwGqZOWPeyrNZsWtH-7KG2CofpQ>
 <xmx:HXcFazciMZCk6MiJ88ISIT3Ssr2KdzIRlgDtlUHBniEEBLH3eKDEww_C>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Nov 2026 06:38:04 -0500 (EST)
From: Janne Grunau <j@jannau.net>
Date: Tue, 24 Nov 2026 12:37:43 +0100
Subject: [PATCH v2 1/5] rust: drm: gem: shmem: Do not use
 drm_gem_shmem_dumb_create()
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261124-rust-drm-gem-shmem-imported-sgt-v2-1-000f7a9ccb8d@jannau.net>
References: <20261124-rust-drm-gem-shmem-imported-sgt-v2-0-000f7a9ccb8d@jannau.net>
In-Reply-To: <20261124-rust-drm-gem-shmem-imported-sgt-v2-0-000f7a9ccb8d@jannau.net>
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
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Sami Tolvanen <samitolvanen@google.com>, Lyude Paul <lyude@redhat.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, nova-gpu@lists.linux.dev, 
 Janne Grunau <j@jannau.net>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1498; i=j@jannau.net;
 s=yk2025; h=from:subject:message-id;
 bh=+rTwIp812E3TQ2SXEFrxp2l3Xc56tLTc3GxmKfSW4CU=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhmzWcrHQb8csQ1as8lD9sP3K3Lcvpt7i2/ZbwsZFbtu1E
 KUbM0M5O0pZGMS4GGTFFFmStF92MKyuUYypfRAGM4eVCWQIAxenAExkyypGhiavEx/NJi2SuuR7
 6Mp+B+OpZ7Z6FPpuNTj+4/GVFdKLTgkzMnxa7q9adk7HmSesePaa3jj7bP0PW+WWXw+OLEqPuXA
 +lxcA
X-Developer-Key: i=j@jannau.net; a=openpgp;
 fpr=8B336A6BE4E5695E89B8532B81E806F586338419
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The existing gem::shmem using Rust GPU drivers (Ashi and Tyr) are render
only devices which should not set the dumb_create callback. When a
driver with KMS functionality is added it probably will not be able to use
drm_gem_shmem_dumb_create().
The Rust gem::shmem::Object<T> wrapper should be allocated and destroyed
from Rust code. DRM drivers have a `gem_create_object` callback which
could be used to allocate objects from Rust. The C code will "destroy"
objects with `kfree(object)` on error paths which is unsound if the Rust
object's DriverObject contains fields with a non-trivial `Drop`
implementation.

Suggested-by: Alice Ryhl <aliceryhl@google.com>
Fixes: 80df573af9ef ("rust: drm: gem: shmem: Add DRM shmem helper abstraction")
Cc: stable@vger.kernel.org
Signed-off-by: Janne Grunau <j@jannau.net>
---
 rust/kernel/drm/gem/shmem.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/kernel/drm/gem/shmem.rs b/rust/kernel/drm/gem/shmem.rs
index a687d46d170d..78a152f0f30c 100644
--- a/rust/kernel/drm/gem/shmem.rs
+++ b/rust/kernel/drm/gem/shmem.rs
@@ -394,7 +394,7 @@ impl<T: DriverObject> driver::AllocImpl for Object<T> {
         prime_fd_to_handle: None,
         gem_prime_import: None,
         gem_prime_import_sg_table: Some(bindings::drm_gem_shmem_prime_import_sg_table),
-        dumb_create: Some(bindings::drm_gem_shmem_dumb_create),
+        dumb_create: None,
         dumb_map_offset: None,
     };
 }

-- 
2.56.1

