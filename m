Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D37DCD5BAC
	for <dri-devel@archiver.kernel.org>; Sat, 23 May 2026 15:46:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A83F10E309;
	Sat, 23 May 2026 15:46:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="XtGo7vjv";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B0B3910E309
 for <dri-devel@lists.freedesktop.org>; Sat, 23 May 2026 15:46:55 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id AEECC60055;
 Sat, 23 May 2026 15:46:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EF321F000E9;
 Sat, 23 May 2026 15:46:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1779551214;
 bh=o01mZIap77JdV7lnWDWkCgBFoE4EHf5jWItgL7KxWEQ=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To;
 b=XtGo7vjv/u2jBKRoLHA3oC9OmfZu2mVOGV/5v91LFo3aenQIJ3Cybr0FFjI67nVMk
 rsOKWs1mXpXve5q7T/hfXdkKBYgWVqT1s9evRpWtpIRO/d3Zltm68xofkt3Wt1bVLO
 7jJavYWoDXZxu8XNR30oIIFFxdR2KkchADzY/WPMvjqNlfN/M2a7heUiyegIGuuEDZ
 0xFLspwBB4sdqtVmDAwEwrZr/JcayDEPbyHrjLY5NnXGo9x902lQgoa6YqcXzCVGGt
 KRFJt1o421jQFFp3Lh9B9DfEag4cUfKMND6Kt4a3SRvOVNHtRbb3Wha0CnuBfBGbKX
 RnfmInEnTQ2zg==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 23 May 2026 17:46:46 +0200
Message-Id: <DIQ696JK4WV0.2HOQ57L342S77@kernel.org>
Subject: Re: [PATCH v4 21/27] rust: types: add `ForLt` trait for
 higher-ranked lifetime support
Cc: <driver-core@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-pm@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
To: <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
 <acourbot@nvidia.com>, <aliceryhl@google.com>, <david.m.ertman@intel.com>,
 <ira.weiny@intel.com>, <leon@kernel.org>, <viresh.kumar@linaro.org>,
 <m.wilczynski@samsung.com>, <ukleinek@kernel.org>, <bhelgaas@google.com>,
 <kwilczynski@kernel.org>, <abdiel.janulgue@gmail.com>,
 <robin.murphy@arm.com>, <markus.probst@posteo.de>, <ojeda@kernel.org>,
 <boqun@kernel.org>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
 <lossin@kernel.org>, <a.hindborg@kernel.org>, <tmgross@umich.edu>,
 <igor.korotin@linux.dev>, <daniel.almeida@collabora.com>,
 <pcolberg@redhat.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260521233501.1191842-1-dakr@kernel.org>
 <20260521233501.1191842-22-dakr@kernel.org>
In-Reply-To: <20260521233501.1191842-22-dakr@kernel.org>
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

On Fri May 22, 2026 at 1:34 AM CEST, Danilo Krummrich wrote:
> [ Handle macro_rules! invocations in the ForLt! proc macro's covariance
>   and WF checks.
>
>   Proc macros cannot expand macro_rules! invocations, so the
>   syn::Visit-based has_lifetime() and replace_lifetime() helpers cannot
>   inspect types hidden behind macro calls. This caused the covariance
>   proof to be silently skipped and lifetime substitution to fail for
>   such types.
>
>   Add an explicit Type::Macro arm to Prover::prove to conservatively
>   require a compiler-assisted covariance proof. Detect macro-containing
>   types with has_macro() and use a WithLt trait projection for lifetime
>   substitution instead of AST-level replacement. - Danilo ]

I was made aware by Gary that WFness is not actually being checked, which i=
s why
the static expansion was needed in the first place.

Thus macros will remain unsupported (even covariant macros are rejected), y=
et we
can improve the error message by adding the following diff on top of the
previous v3 patch.

diff --git a/rust/macros/for_lt.rs b/rust/macros/for_lt.rs
index df2027789713..75d0ce450bf0 100644
--- a/rust/macros/for_lt.rs
+++ b/rust/macros/for_lt.rs
@@ -107,6 +107,12 @@ fn visit_lifetime(&mut self, lifetime: &Lifetime) {
                     self.1 =3D true;
                 }
             }
+
+            // Macro invocations are opaque; conservatively assume they ma=
y
+            // reference the lifetime.
+            fn visit_macro(&mut self, _: &syn::Macro) {
+                self.1 =3D true;
+            }
         }

         let mut visitor =3D HasLifetime(lt, false);

