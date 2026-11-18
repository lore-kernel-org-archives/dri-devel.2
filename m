Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67995606A325
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 23:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ko59BP5j
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9206C10EC10;
	Wed, 18 Nov 2026 23:38:22 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1236D10FDC3
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 23:38:09 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id ED8FD4388B;
 Wed, 18 Nov 2026 23:38:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4444D1F000C7;
 Wed, 18 Nov 2026 23:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795045088;
 bh=I9QM7AcXN+NGEFCpZazq539bp5laPCskln3LUMmzQl4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=ko59BP5jz/U6b9VEqglkh310lLLTn+q/iGtd8d+hM8z4tdHNR+vYAO2/IBF/AZ5Fs
 wnIjhs9ufGpyTZtqM6T3nTWaN5/G9+COOOSbS0i099SZcH8w12gu7nO5XQCuTfOwdL
 UJ43mN3vxxPY7kYtA5bij9zZ+6SNjvhQDSceO6WKnKmIl7yef0sStl9Y6Ab3wQhg8c
 vFRgXkDotWe+VS7lrAB05Xnh94K5EgNvmW2pcNn7CC04As+3JUZwmqSY7fNkNXEKN6
 d5/x7qj2u0BOVcIu2efgCuLWO8VVn2kgJKLCnfqdzRtB7isawJgU4LuiRHe+ncTHdc
 W2vLXBkArpdvA==
From: Danilo Krummrich <dakr@kernel.org>
To: dakr@kernel.org, aliceryhl@google.com, daniel.almeida@collabora.com,
 airlied@gmail.com, simona@ffwll.ch, lossin@kernel.org, gary@garyguo.net,
 ojeda@kernel.org, boqun@kernel.org, bjorn3_gh@protonmail.com,
 a.hindborg@kernel.org, tmgross@umich.edu, tamird@kernel.org,
 acourbot@nvidia.com, work@onurozkan.dev
Cc: dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] drm/tyr: use ScopeGuard for firmware loading cleanup
Date: Thu, 19 Nov 2026 00:37:05 +0100
Message-ID: <20261118233727.3147222-5-dakr@kernel.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261118233727.3147222-1-dakr@kernel.org>
References: <20261118233727.3147222-1-dakr@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Use ScopeGuard to call vm.kill() when firmware section loading fails.
Dismiss it on success, replacing the nested closure and explicit error
check.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 drivers/gpu/drm/tyr/fw.rs | 59 ++++++++++++++++++---------------------
 1 file changed, 27 insertions(+), 32 deletions(-)

diff --git a/drivers/gpu/drm/tyr/fw.rs b/drivers/gpu/drm/tyr/fw.rs
index bd377875778b..755112959ee2 100644
--- a/drivers/gpu/drm/tyr/fw.rs
+++ b/drivers/gpu/drm/tyr/fw.rs
@@ -29,7 +29,8 @@
     num::Bounded,
     prelude::*,
     str::CString,
-    time, //
+    time,
+    types::ScopeGuard, //
 };
 
 use crate::{
@@ -228,46 +229,40 @@ pub(crate) fn new<'a, 'res>(
             sections: {
                 let vm = vm.get_ref();
                 vm.activate()?;
+                let guard = ScopeGuard::new(|| vm.kill());
 
-                let result: Result<_> = (|| {
-                    let (fw, parsed_sections) = Self::load(dev, ddev, gpu_info)?;
-                    let mut sections = KVec::new();
-                    for parsed in parsed_sections {
-                        let size =
-                            u64::from(parsed.va.end.checked_sub(parsed.va.start).ok_or(EINVAL)?);
+                let (fw, parsed_sections) = Self::load(dev, ddev, gpu_info)?;
+                let mut sections = KVec::new();
+                for parsed in parsed_sections {
+                    let size =
+                        u64::from(parsed.va.end.checked_sub(parsed.va.start).ok_or(EINVAL)?);
 
-                        let va = u64::from(parsed.va.start);
+                    let va = u64::from(parsed.va.start);
 
-                        let mut mem = KernelBo::new(
-                            ddev,
-                            vm,
-                            size,
-                            KernelBoVaAlloc::Explicit(va),
-                            parsed.vm_map_flags,
-                        )?;
+                    let mut mem = KernelBo::new(
+                        ddev,
+                        vm,
+                        size,
+                        KernelBoVaAlloc::Explicit(va),
+                        parsed.vm_map_flags,
+                    )?;
 
-                        let section_start = parsed.data_range.start as usize;
-                        let section_end = parsed.data_range.end as usize;
-                        let mut data = KVec::new();
+                    let section_start = parsed.data_range.start as usize;
+                    let section_end = parsed.data_range.end as usize;
+                    let mut data = KVec::new();
 
-                        // Ensure that the firmware slice is not out of bounds.
-                        let fw_data = fw.data();
-                        let bytes = fw_data.get(section_start..section_end).ok_or(EINVAL)?;
-                        data.extend_from_slice(bytes, GFP_KERNEL)?;
+                    // Ensure that the firmware slice is not out of bounds.
+                    let fw_data = fw.data();
+                    let bytes = fw_data.get(section_start..section_end).ok_or(EINVAL)?;
+                    data.extend_from_slice(bytes, GFP_KERNEL)?;
 
-                        Self::init_section_mem(dev, &mut mem, &data)?;
+                    Self::init_section_mem(dev, &mut mem, &data)?;
 
-                        sections.push(Section { data, mem }, GFP_KERNEL)?;
-                    }
-
-                    Ok(sections)
-                })();
-
-                if result.is_err() {
-                    vm.kill();
+                    sections.push(Section { data, mem }, GFP_KERNEL)?;
                 }
 
-                result?
+                guard.dismiss();
+                sections
             },
         })
     }
-- 
2.56.1

