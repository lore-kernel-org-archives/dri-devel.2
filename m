Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F536606A32F
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 11:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=jannau.net header.i=@jannau.net header.a=rsa-sha256 header.s=fm1 header.b=evLfp9jz;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=QxHLfqly
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D00F310EE5E;
	Mon, 26 Oct 2026 11:22:06 +0000 (UTC)
Received: from fout-a2-smtp.messagingengine.com
 (fout-a2-smtp.messagingengine.com [103.168.172.145])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B0CD510EDAB
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 11:21:54 +0000 (UTC)
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfout.phl.internal (Postfix) with ESMTP id 9C485EC0387
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 07:14:26 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-01.internal (MEProxy); Mon, 26 Oct 2026 07:14:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
 :cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1793013266;
 x=1793099666; bh=DXYVe7CNLIz7yJ9VzKjWYgPWAbLU1uMBEbXYftb1oMU=; b=
 evLfp9jzLV4IDOdyesGVYhsJiwSxzDYhlsMG9KOlbI4/BIyeF0XOtn/jq+k4XtWC
 KQeSBG/Y7yjxcQawhLcrvuQ9y0vIQzvsj6KB2zuqRQ6qpaSFbJN86+cukPmimp1H
 LCETV/F+XRO+lcNiz+MiNJmn8NjFRX80faveqjWoaCSus+q68xbtWSkhTeEo4hoo
 L2QNh2Q7Qh0zVCeOc3d6b4fdCmhONHbVILTbjZu33fOCckzM33z4UKyx4CjDgdJJ
 dCgeohdZ8qvLhLtAgVLsXw/k5JzUsu804GnTWg/TTPc1TM31OwHWeIIaNsA9ZdnM
 ZQrfq5y0XXNbaQO4XihK8w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1793013266; x=
 1793099666; bh=DXYVe7CNLIz7yJ9VzKjWYgPWAbLU1uMBEbXYftb1oMU=; b=Q
 xHLfqlyOW61irSWhdgOeP4B5TzzEJEANY31WjFuzhTLXZz8GHFJ0iSJ4J/Pvyx8K
 Nt2CP9lCKMtEcf0UlMKFtl9UkDtnY63bGxmUOmcnMOyQuo/z5ovjEpI2MBGN4T4D
 JOtu94e7sezy9jXYbbzVa64ffItxNEEJIxxZOvyBRsl7WuSNYjMki1FQHrm8Mld0
 xbHTst51FdeIFYlg0pBXMdlHEqMxy2OYgP4dS4YZeCKlQ0VIlnl2ycffXIJEgo6d
 YpD4eNmq172FxOacFZvXFRRs6qRRW0Xm38+OjQuFsKN6lzWJXH3RNVYcwDDIDMk/
 Kus+leByN13WB8ZY/Pcvg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
 repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
 action=sign d=jannau.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793013266; d=jannau.net; mf=PGpAamFubmF1Lm5ldD4=;
 rt=PGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmc+;
 s=fm1:rsa-sha256:t2zTA0YQ2sqkPymH1pd5wQjBR+wBFeexA7wubQ5Lgh9RRgu
 QFd9qRlTtDNyG8tHqN/PlLSUhJshtxJn2FXYwWQE7+cyJuINuodpcRbI8zbTIk89
 qEQ+7eqWmd4795Oi8elNFi13XQatthj8LyPxUyX+WcWDOc5QUjXIA1Bh4WmKHkBE
 si0pIRs/H5YJlUDpdU9D6LyVAHuqKwHJl8hbbxCqYRPiPIHVb1ZjZfnf5pOfrPga
 ZKjcpdtFcCr4gt/jgIAVfZZFvgQnNCeqS6LkZ3WaOyKRv4FmpNRzl5Uy1n7mflFT
 LPiIxMyQldlS7ermj9dWLZ4ud1ML4P6fcIcVNgQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
 repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:RYSLW73I78j0EtqWI3hr1NOeLZj2Zc7tUlgixISG9Z4=:xGEkm1UVWNmD/CcCSf5Ky60m67kbjzi3LJ1BFgNgNPQ=;
X-ME-Sender: <xms:EjbfamEcMROzPCt7DV5Z7KBa16LLySd-vtW-upGe6RTfEs-iCAVf2g>
 <xme:Ejbfai7i5VhoWhQl54JGpM-ajuqMfRsuGnOTd81SUoi-MCN6iNOLuXdpNnpPisNHK
 ebBu5q1H3g0KcUjFfC2jt7WJkPneVoBgmSfgGBJa8WN1mS8Bw8D9ddX>
X-ME-Received: <xmr:EjbfagI-eZcsIT6KZsrAWASPSiUxgjOJiVnPxjp3OYpQcnrAVjkrKkNc7do0rtBCXqtU5Z6AKum0ncAX9RwhcHMEP1ynpzD92-4>
X-ME-Proxy-Cause: dmFkZTFmWKNzxilsosn2AiOSTQBzQCKqijXuWDtuYcyNU5PT2LnXjQH9TggnkIPYYOofzf
 5x1dpL92mqjacmPimklyXzPWwipYY6x+66VZu8Tv2NIJi/xjXE/dGg+P6gmCFOEPnAANMa
 GWbcVZCeOd+6glMcPbe9sptsseTQLY/yMD/T8XDQ6zPyiAetAAobPNHg+7Fo1kWYVo3y4/
 tJY7yjWdLCspccv2sVZ5tHGBaie7ZnUdej3ckQvzSCkHM28HfPYg1x/4QXp7MPPyN/oD0f
 GXJxq3QMGIawVafsXBanxMlWFrsqrdL5PuIhs/OPluzLTCG5ZaD+HgOPfzieAHmkSzApDG
 dUS7W9fWwNttwaIA1dA+pImrkBR/3h4GGIlu4fp4mQdzTZzodD69aDUoqGprDAjqE92Umm
 HIXnO7yzSB9zvumuLffk1bR13Pcw2PylOdS3v2xKhZ0/hQfEFOTh69EaHkVzqaGKK66LRB
 AqYAhO6JzyCfpuWnXGU+eE0ijYqpGIJ1cXWlvAYNxA6a1Moks0oaZ72SeTKyoJRYc+1dXT
 vpkwdYn/YimgwbB3z72QU3OVGsaS+xCdyQsL5SKOmHGQJLYoYaGkrD144teXYlMcVTIkjG
 AZ7E0WgasHyrpjfN+ZfjQM8wrVcvy8B+DQNi/N51eH6ydkjEihp6zDzuPJVQ
X-ME-Proxy: <xmx:EjbfalAmflRK5VMw3HSlqyi-oge-d5cz46RcIbmPab_RgHFim6LTnQ>
 <xmx:EjbfauRADlpgarBtCPtVcBu1D5NHlr7tv5mT2L2glbkZyLI3lyTt_A>
 <xmx:EjbfavdIMb1swThSv9OECX9ncitpCOPHmJsy_ciFJ7WGRISDIpDKpQ>
 <xmx:EjbfamhUhuduAZ-SeNLxpHgPdOQmiOwPFuhnOdBr6Rzy8rShrZmQlg>
 <xmx:EjbfasDJ1osCpQeIa4Rh372S8YxD2aD_wpSu-hEnZcQSIdDEbubOewXu>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Oct 2026 07:14:25 -0400 (EDT)
From: Janne Grunau <j@jannau.net>
Date: Mon, 26 Oct 2026 12:14:09 +0100
Subject: [PATCH 2/3] rust: drm: gem: add an is_imported() accessor
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261026-rust-drm-gem-shmem-imported-sgt-v1-2-36f15ace04b1@jannau.net>
References: <20261026-rust-drm-gem-shmem-imported-sgt-v1-0-36f15ace04b1@jannau.net>
In-Reply-To: <20261026-rust-drm-gem-shmem-imported-sgt-v1-0-36f15ace04b1@jannau.net>
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
 Janne Grunau <j@jananu.net>, Sami Tolvanen <samitolvanen@google.com>, 
 Lyude Paul <lyude@redhat.com>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, nova-gpu@lists.linux.dev, 
 Janne Grunau <j@jannau.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1695; i=j@jannau.net;
 s=yk2025; h=from:subject:message-id;
 bh=QM7q0FfDYp8A00L/ZX7AriznaohL6TlI/fH0ot/ZaOc=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhqz7Zlwz0hhaH+Qc7y/ffjXG6ffajVZHHjs+Srway7NuX
 uWLplaZjlIWBjEuBlkxRZYk7ZcdDKtrFGNqH4TBzGFlAhnCwMUpABM5oc/IcLy+T0Sh5N7u3/6a
 kSzppx9xrNU8UbHnzbEQ1XM7boszv2D47200qe8dm3DNvjCFmvr/fxKVixZJXEjJfNKnf+aatLE
 +EwA=
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

From: Sami Tolvanen <samitolvanen@google.com>

Drivers need to check whether a GEM object is PRIME-imported.

Add BaseObject::is_imported(), wrapping drm_gem_is_imported() through a
C helper shim.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Signed-off-by: Janne Grunau <j@jannau.net>
---
 rust/helpers/drm.c         | 6 ++++++
 rust/kernel/drm/gem/mod.rs | 7 +++++++
 2 files changed, 13 insertions(+)

diff --git a/rust/helpers/drm.c b/rust/helpers/drm.c
index 65f3f22b0e1d..8cf3ca7aeeb2 100644
--- a/rust/helpers/drm.c
+++ b/rust/helpers/drm.c
@@ -16,6 +16,12 @@ __rust_helper void rust_helper_drm_gem_object_put(struct drm_gem_object *obj)
 	drm_gem_object_put(obj);
 }
 
+__rust_helper bool
+rust_helper_drm_gem_is_imported(const struct drm_gem_object *obj)
+{
+	return drm_gem_is_imported(obj);
+}
+
 __rust_helper __u64
 rust_helper_drm_vma_node_offset_addr(struct drm_vma_offset_node *node)
 {
diff --git a/rust/kernel/drm/gem/mod.rs b/rust/kernel/drm/gem/mod.rs
index e01b8311dd89..5da8627275a2 100644
--- a/rust/kernel/drm/gem/mod.rs
+++ b/rust/kernel/drm/gem/mod.rs
@@ -187,6 +187,13 @@ fn size(&self) -> usize {
         unsafe { (*self.as_raw()).size }
     }
 
+    /// Returns whether the object's backing buffer is imported from another
+    /// driver.
+    fn is_imported(&self) -> bool {
+        // SAFETY: `self.as_raw()` is guaranteed to be a pointer to a valid `struct drm_gem_object`.
+        unsafe { bindings::drm_gem_is_imported(self.as_raw()) }
+    }
+
     /// Creates a new handle for the object associated with a given `File`
     /// (or returns an existing one).
     fn create_handle<D, F>(&self, file: &drm::File<F>) -> Result<u32>

-- 
2.56.0

