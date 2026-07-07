Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BC1EC44501
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 07:27:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2BF6C10F43E;
	Thu,  9 Jul 2026 07:26:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=qq.com header.i=@qq.com header.b="Erq1+XwJ";
	dkim-atps=neutral
X-Greylist: delayed 484 seconds by postgrey-1.36 at gabe;
 Tue, 07 Jul 2026 16:17:46 UTC
Received: from out162-62-57-210.mail.qq.com (out162-62-57-210.mail.qq.com
 [162.62.57.210])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 60F9910EE56
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 16:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1783441062; bh=ZJlYGquIV8wKaCWsETdoz4HoiPJMF0YxXf1C73RyCJQ=;
 h=From:To:Cc:Subject:Date;
 b=Erq1+XwJcTOyOFm/38yIbWrpkuH3szkrD61UR5N+5FVtK5oHnn7pDagzoTVu+fi6I
 Y1KIBAQi895NBzrQfxTWCdFIvR0RRmzlvbzadHSnKtraBAPXCfCwrOHKC3O7TR/PC4
 so7t1rT1AoKA7SClICrR1n5poYJK7UBo2id4sexE=
Received: from localhost.localdomain ([202.120.234.146])
 by newxmesmtplogicsvrszb51-1.qq.com (NewEsmtp) with SMTP
 id 8B8960D; Wed, 08 Jul 2026 00:02:11 +0800
X-QQ-mid: xmsmtpt1783440131tivx7ad3b
Message-ID: <tencent_37A376A02B95E3DBE7E5C64882B7A4F90807@qq.com>
X-QQ-XMAILINFO: NT7uTz3cNku28jb5ZATyyL3reZyKwZFufFApNxo8yktzmLSkEpNs1l86pE426y
 ovYm168aLmqPnhNU6TyYMj7XAkx0ey0RU+/eVborQLtNJBDHEt8VBh4IcNS0nxW/ZND9+sA58oat
 jT9Xbtw0TnCDKLIlKhGroldgX+QAiET0SfbpyeKAgKlsZ+b/K9i6tufPbvxqBJb9oUoH3O82pFLR
 2ou4/XvC7TzthMC5PTzOCj49YpEWVY476FJwPGbGaZqt34CHI/XUZJEDwhadWKDz5ztL7K1VgzMB
 +8sDSFGK2EBhYixtwMR6T7d5by4o8EyTtlO3Pi/LTFxHPY8FN/zTfqmLnAGT5jigvTjIKWrr4pPn
 B0rqJC02kAKwoigPRaGuqXBHykzkgYXrMUIIdctbWYd/jc2943Wo1DlOeeTE6hR79aR1rbxAyp6S
 GqRCMDABUvTj+nBT7T0u/E9LLn1yU1TzjMHfq6hLIR13dKnRoMpojv9jt9cO1webbxut397BzcrS
 7mj4q81JL/3Bmz6/Ilm+HNJEjJH/H+48cd+iGG2NiLcj2OfOXvgM00eXgsOr57kDSIi48NxpCF1e
 GYs8qezpiHYJGA5UYG5CnUG8htOJfvaG/8PeFuqpsPys5fTrZLMknIYf8+PrhLhgPlGr6SqX//Yb
 I3/vH3G5VBzawUnj584pkYyKHmL0IXrm/CdEttqibyPAn68gdNKnI0zXcHbD28p/mf0woWynoh53
 PwdGgW/DjnmK4b/v3l3dwesfHoABZfCTcBjHYlt6ga7gTlj0laRkWUmMid20fegmUBNWs2QjLwQW
 MBgiOJ0SQ0EhZo9Q4STWTo1aKB5mnbn9U0rK5Ut+GzeMyoRUCnHM8ExhvBGu9MN+PC8ggjU82Czm
 9hpwFavcqL8nEz/rf+uXU2sd/7Pk4a7bbSFd7+gBle6Mz1n6XzNBbZ92AszB5UdRge0H8omIVT3o
 ZzO3o5zCHXkrRYiSGyrnEJuAie+hSCHDLhG4ls7Fr2TaztsWS/sDOn8KK8Rv15qPR5FbhFh+z2oT
 doMCtRxZPY+oDkAzUEs6NgkxpW/+JsWOV3BgRMneHda5zZqXaowTVOpJ0/M5+Jlem4AbItK5pyS1
 QVxrHkVNVi1OsyE3w=
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
From: Yilin Chen <1479826151@qq.com>
To: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org
Cc: Miguel Ojeda <ojeda@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 linux-kernel@vger.kernel.org, Yilin Chen <1479826151@qq.com>
Subject: [PATCH] rust: drm: fix GEM object pointer safety docs
Date: Tue,  7 Jul 2026 16:02:00 +0000
X-OQ-MSGID: <20260707160200.2798072-1-1479826151@qq.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 09 Jul 2026 07:25:19 +0000
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

IntoGEMObject::from_raw() takes a drm_gem_object pointer.

Its Safety docs described the argument as a pointer to Self, which does
not match the function signature. Update the docs to point to the actual 
pointer type accepted by the API.

Assisted-by: Codex:GPT-5
Signed-off-by: Yilin Chen <1479826151@qq.com>
---
 rust/kernel/drm/gem/mod.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/kernel/drm/gem/mod.rs b/rust/kernel/drm/gem/mod.rs
index c8b66d816..90b256093 100644
--- a/rust/kernel/drm/gem/mod.rs
+++ b/rust/kernel/drm/gem/mod.rs
@@ -118,7 +118,7 @@ pub trait IntoGEMObject: Sized + super::private::Sealed + AlwaysRefCounted {
     ///
     /// # Safety
     ///
-    /// - `self_ptr` must be a valid pointer to `Self`.
+    /// - `self_ptr` must be a valid pointer to `struct drm_gem_object`.
     /// - The caller promises that holding the immutable reference returned by this function does
     ///   not violate rust's data aliasing rules and remains valid throughout the lifetime of `'a`.
     unsafe fn from_raw<'a>(self_ptr: *mut bindings::drm_gem_object) -> &'a Self;
-- 
2.25.1

