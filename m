Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD208C982E6
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 07:00:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D37EA10E3BE;
	Mon, 21 Sep 2026 07:00:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lLsb2UH0";
	dkim-atps=neutral
Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com
 [74.125.227.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5690C10E08E
 for <dri-devel@lists.freedesktop.org>; Sun, 20 Sep 2026 19:19:26 +0000 (UTC)
Received: by mail-pj2-f12.google.com with SMTP id
 d9443c01a7336-2d90ba1d807so27929265ad.3
 for <dri-devel@lists.freedesktop.org>; Sun, 20 Sep 2026 12:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789931966; x=1790536766; darn=lists.freedesktop.org;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=bKLYZ5zYTzX26ZlJ/Ce6O9aFub3iX+B/pKfI968fj2Y=;
 b=lLsb2UH0x84KjrQ7TAFmFSI9UVw76El7UN5AhjQDPYHjnwe+a9FDfNOby0/lBc1UzF
 6fQoJudyze/9nEe45M7X5AYKkkjWV1qW5YKcu9DG9U7oox2ISpoUMYfObgpE0GkztRwB
 PaRhopxc8AKSSmIR3wYXbPVf2fcGOPKslHQiFKXS0x1EoBSvNeoiV0/FpNTDj3FGiYkq
 YQCC70Gi9OXhQi04jUNyfmR6HfElrqouVbhJojKcnEq1FSCTCahZSvidBOZKXWwuTO/8
 YTYVKTYAKqvVQGG4JyfuUnHNmjkWaLgOxtUsptk42a0FfOfmmBQxA+zdolYlOkj0dSJP
 PQLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789931966; x=1790536766;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=bKLYZ5zYTzX26ZlJ/Ce6O9aFub3iX+B/pKfI968fj2Y=;
 b=KKNhB+alAEu/mrZMdwJzoaZDSLU2JUtJ7uAkIm8lo75uA4+mvNBcOCmDCfo/Q5HcKw
 Z++BnipHn1VoLy2pwQ0hfPLSDISk/iEEKSD+hvm5vRHWhinWT4Fa1wXfVlDLGZDGe8Um
 XUHD7ChNAYjh8NNZr0G8+dPvvgZu2K+SzjT1YhlCRj2QLIoJDAQtzmBhHb908kxFYzB2
 b6ppAmGeiDP9CyQbQPVcK/Vy6OVDUIw6GopXpsVBXzBpdGHCtXIc1iIuQ//lEwBwRZ3E
 gQU/z4o3PiatKVCO9ej0feBZia/9P7EbDdhuUafVGA4jjrUezhcyiBWk91xNKQiG9fBa
 v7Gg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxnj7leBKjdARX9NeEROU9M1gDQnK+C6vTNnsDGokZe3Bd4zhu74rJKKDMqsv4OHu6fkk3x5w4Ocrs=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kE7Xw7p7c71r+6jdps9avDwCJLtKrbi/KDjMRfTAMGhQ5fi8SQ
 pKg1YOkc7PkT4ruOz8Y2vhcdXkEuTZIrE5c7xeCvyrRPRv4/z6Z+RimvtWB+sgAM
X-Gm-Gg: AYBFou3+HyzjRxKnUtuZ9dMnzhPkB+7vQB8malQhSGGKYXxWn+8dKUxpXmz3Ndw8+W5
 NoTCZXth0/HNVk4JnGStbL1fnAEpYBPVIUob/w7TCs+mK9iA4K2E8XRF5jaNmBXNbFgWYwPEdG6
 Iu2wlCFL3FhXoYJCTSKdfbStjsBlCJU/5uNtn7npCobMBhgn+DVDsAfBlC6zbtJkSXv1WWlh4zt
 tYwZJ/Ax3pH8wbMVSed4UcAa1beQXIQXVv00pMw3cQTV34MxBoIuMkgtXOPYX9Spk8W9q6we1nd
 SDZAEG9umIby4WUWC78zuYdw6Xh5/BTNXuYCQxNogDBdSQNLWTSVYr06sDq4RAO/7WjJp7kABos
 JnpXAyZoTYQVI4HwMQrY3L5TK1oH8Phx0GNdz/DqDjIJ6MllPTBoOkqdEanGtaYkFXry1ldN2im
 v078ylmUif/1gIPJt4api21bS4NRkgmbvvl6BQchWHwLXDmOs4xlQyvhKYAxl0yAgzcw85M2Amj
 wMY
X-Received: by 2002:a17:902:ce07:b0:2da:f1b1:56c4 with SMTP id
 d9443c01a7336-2ddb1ab3254mr141078815ad.3.1789931965693; 
 Sun, 20 Sep 2026 12:19:25 -0700 (PDT)
Received: from fedora.local ([2804:d57:4e62:f400:ee3b:9f08:f174:9cdc])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33c32f17dbdsm14445322eec.1.2026.09.20.12.19.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 20 Sep 2026 12:19:25 -0700 (PDT)
From: Filipe Xavier <felipeaggger@gmail.com>
Date: Sun, 20 Sep 2026 16:18:53 -0300
Subject: [PATCH v2] rust: impl_flags: add conversions for raw flag
 representations
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260920-add-from-raw-conversions-v2-1-cef8e6e23ae2@gmail.com>
X-B4-Tracking: v=1; b=H4sIAJwxsGoC/42NTQ7CIBBGr9LM2jGApD+uvIfpgsK0JbHFDAY1D
 XeX9gQu35e8920QiT1FuFYbMCUffVgLqFMFdjbrROhdYVBC1aKTCo1zOHJYkM0bbVgT8e5E1LV
 uXNuJYWgaKPqTafSfI33vC88+vgJ/j6ck9/WPaJIoUViii65b7ZS+TYvxj7MNC/Q55x+XryiRw
 AAAAA==
X-Change-ID: 20260912-add-from-raw-conversions-4647d890bb77
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
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Filipe Xavier <felipe_life@live.com>, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 Filipe Xavier <felipeaggger@gmail.com>
X-Mailer: b4 0.14.2
X-Mailman-Approved-At: Mon, 21 Sep 2026 07:00:14 +0000
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

Extend the impl_flags! macro to support conversions between generated flag
types and raw C/UAPI integers. Implement TryFrom<Repr> for individual flags
(exact variant match) and flag sets (rejecting unknown bits), along with an
unsafe from_raw() constructor for flag sets. Additionally, add BitOr and
BitOrAssign implementations between the raw representation and flag types.

Suggested-by: Daniel Almeida <daniel.almeida@collabora.com>
Suggested-by: Andreas Hindborg <a.hindborg@kernel.org>
Signed-off-by: Filipe Xavier <felipeaggger@gmail.com>
---
Changes in v2:
- New Error InvalidFlagValue for TryFrom implementations, mapping invalid flag values to EINVAL.
- Replace Tyr's local TryFrom implementation to use from the macro.
- Add raw BitOr<$flags> and BitOrAssign<$flags> support to complete operations.
- Link to v1: https://lore.kernel.org/r/20260912-add-from-raw-conversions-v1-1-0cee34684d24@gmail.com
---
 drivers/gpu/drm/tyr/vm.rs |  13 -----
 rust/kernel/error.rs      |  11 +++++
 rust/kernel/impl_flags.rs | 122 +++++++++++++++++++++++++++++++++++++++++-----
 3 files changed, 121 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/tyr/vm.rs b/drivers/gpu/drm/tyr/vm.rs
index c5e307b1e2416837c85f890c074f62bc74289178..446672b4bc6bfedab789e20c97c4b754d5c019c0 100644
--- a/drivers/gpu/drm/tyr/vm.rs
+++ b/drivers/gpu/drm/tyr/vm.rs
@@ -141,19 +141,6 @@ fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
     }
 }
 
-impl TryFrom<u32> for VmMapFlags {
-    type Error = Error;
-
-    fn try_from(value: u32) -> Result<Self, Self::Error> {
-        let valid = VmFlag::Readonly as u32 | VmFlag::Noexec as u32 | VmFlag::Uncached as u32;
-
-        if value & !valid != 0 {
-            return Err(EINVAL);
-        }
-        Ok(Self(value))
-    }
-}
-
 /// Arguments for a virtual memory map operation.
 struct VmMapArgs<'drm> {
     /// Access permissions and caching behavior for the mapping.
diff --git a/rust/kernel/error.rs b/rust/kernel/error.rs
index e52793f771966f20258c7d021826f7b63f8cf35e..8d2c4300262743b504d82bcc041076e78636cda5 100644
--- a/rust/kernel/error.rs
+++ b/rust/kernel/error.rs
@@ -201,6 +201,10 @@ macro_rules! declare_err {
 #[derive(Clone, Copy, PartialEq, Eq)]
 pub struct Error(NonZeroI32);
 
+/// Represents an invalid value for a flag type.
+#[derive(Clone, Copy, PartialEq, Eq, Debug)]
+pub struct InvalidFlagValue;
+
 impl Error {
     /// Creates an [`Error`] from a kernel error code.
     ///
@@ -323,6 +327,13 @@ fn from(_: AllocError) -> Error {
     }
 }
 
+impl From<InvalidFlagValue> for Error {
+    #[inline]
+    fn from(_: InvalidFlagValue) -> Error {
+        code::EINVAL
+    }
+}
+
 impl From<TryFromIntError> for Error {
     #[inline]
     fn from(_: TryFromIntError) -> Error {
diff --git a/rust/kernel/impl_flags.rs b/rust/kernel/impl_flags.rs
index fdf44d5eea9cb907f6d8d209792a1d9b74b55be6..493cd7f51dcc5f4926e39c4e79c7d4ed7157233d 100644
--- a/rust/kernel/impl_flags.rs
+++ b/rust/kernel/impl_flags.rs
@@ -14,6 +14,8 @@
 /// - The struct and enum types with appropriate `#[repr]` attributes.
 /// - Implementations of common bitflag operators
 ///   ([`::core::ops::BitOr`], [`::core::ops::BitAnd`], etc.).
+/// - Conversions between the Rust-native types and their raw representation.
+/// - Validation when converting raw values back into Rust-native types.
 /// - Utility methods such as `.contains()` to check flags.
 ///
 /// # Examples
@@ -68,6 +70,25 @@
 /// let negated = !read_only;
 /// assert!(negated.contains(Permission::Write));
 /// assert!(!negated.contains(Permission::Read));
+///
+/// // Convert individual flags and flag sets to their raw representation.
+/// let raw: u32 = Permission::Read.into();
+/// assert_eq!(raw, 1);
+/// let raw: u32 = read_write.into();
+///
+/// // Raw values can be validated before entering the Rust-native API.
+/// assert_eq!(Permission::try_from(1), Ok(Permission::Read));
+/// assert!(Permission::try_from(3).is_err());
+/// assert!(Permissions::try_from(3).is_ok());
+///
+/// // Raw C/UAPI fields can be updated without an intermediate conversion.
+/// let mut raw = 0u32;
+/// raw |= Permission::Read;
+/// raw |= Permission::Write;
+/// assert_eq!(raw, 3);
+/// let read_write = Permission::Read | Permission::Write;
+/// raw |= read_write;
+/// assert_eq!(raw | read_write, 3);
 /// ```
 #[macro_export]
 macro_rules! impl_flags {
@@ -103,6 +124,13 @@ fn from(value: $flag) -> Self {
             }
         }
 
+        impl ::core::convert::From<$flag> for $ty {
+            #[inline]
+            fn from(value: $flag) -> Self {
+                value as $ty
+            }
+        }
+
         impl ::core::convert::From<$flags> for $ty {
             #[inline]
             fn from(value: $flags) -> Self {
@@ -110,32 +138,45 @@ fn from(value: $flags) -> Self {
             }
         }
 
-        impl ::core::ops::BitOr for $flags {
-            type Output = Self;
+        impl ::core::convert::TryFrom<$ty> for $flag {
+            type Error = ::kernel::error::InvalidFlagValue;
+
             #[inline]
-            fn bitor(self, rhs: Self) -> Self::Output {
-                Self(self.0 | rhs.0)
+            fn try_from(value: $ty) -> Result<Self, Self::Error> {
+                match value {
+                    $(
+                        v if v == ($value as $ty) => Ok($flag::$name),
+                    )+
+                    _ => Err(::kernel::error::InvalidFlagValue),
+                }
             }
         }
 
-        impl ::core::ops::BitOrAssign for $flags {
+        impl ::core::convert::TryFrom<$ty> for $flags {
+            type Error = ::kernel::error::InvalidFlagValue;
+
             #[inline]
-            fn bitor_assign(&mut self, rhs: Self) {
-                *self = *self | rhs;
+            fn try_from(value: $ty) -> Result<Self, Self::Error> {
+                if value & !Self::all_bits() != 0 {
+                    return Err(::kernel::error::InvalidFlagValue);
+                }
+
+                // SAFETY: All bits set in `value` are valid flag bits.
+                Ok(unsafe { Self::from_raw(value) })
             }
         }
 
-        impl ::core::ops::BitOr<$flag> for $flags {
+        impl ::core::ops::BitOr for $flags {
             type Output = Self;
             #[inline]
-            fn bitor(self, rhs: $flag) -> Self::Output {
-                self | Self::from(rhs)
+            fn bitor(self, rhs: Self) -> Self::Output {
+                Self(self.0 | rhs.0)
             }
         }
 
-        impl ::core::ops::BitOrAssign<$flag> for $flags {
+        impl ::core::ops::BitOrAssign for $flags {
             #[inline]
-            fn bitor_assign(&mut self, rhs: $flag) {
+            fn bitor_assign(&mut self, rhs: Self) {
                 *self = *self | rhs;
             }
         }
@@ -155,6 +196,21 @@ fn bitand_assign(&mut self, rhs: Self) {
             }
         }
 
+        impl ::core::ops::BitOr<$flag> for $flags {
+            type Output = Self;
+            #[inline]
+            fn bitor(self, rhs: $flag) -> Self::Output {
+                self | Self::from(rhs)
+            }
+        }
+
+        impl ::core::ops::BitOrAssign<$flag> for $flags {
+            #[inline]
+            fn bitor_assign(&mut self, rhs: $flag) {
+                *self = *self | rhs;
+            }
+        }
+
         impl ::core::ops::BitAnd<$flag> for $flags {
             type Output = Self;
             #[inline]
@@ -240,6 +296,38 @@ fn not(self) -> Self::Output {
             }
         }
 
+        impl ::core::ops::BitOr<$flag> for $ty {
+            type Output = Self;
+
+            #[inline]
+            fn bitor(self, rhs: $flag) -> Self::Output {
+                self | (rhs as $ty)
+            }
+        }
+
+        impl ::core::ops::BitOrAssign<$flag> for $ty {
+            #[inline]
+            fn bitor_assign(&mut self, rhs: $flag) {
+                *self |= rhs as $ty;
+            }
+        }
+
+        impl ::core::ops::BitOr<$flags> for $ty {
+            type Output = Self;
+
+            #[inline]
+            fn bitor(self, rhs: $flags) -> Self::Output {
+                self | rhs.0
+            }
+        }
+
+        impl ::core::ops::BitOrAssign<$flags> for $ty {
+            #[inline]
+            fn bitor_assign(&mut self, rhs: $flags) {
+                *self |= rhs.0;
+            }
+        }
+
         impl $flags {
             /// Returns an empty instance where no flags are set.
             #[inline]
@@ -253,6 +341,16 @@ pub const fn all_bits() -> $ty {
                 0 $( | $value )+
             }
 
+            /// Creates a flag set from its raw representation without validation.
+            ///
+            /// # Safety
+            ///
+            /// All bits set in `value` must correspond to valid flags.
+            #[inline]
+            pub const unsafe fn from_raw(value: $ty) -> Self {
+                Self(value)
+            }
+
             /// Checks if a specific flag is set.
             #[inline]
             pub fn contains(self, flag: $flag) -> bool {

---
base-commit: 08df884136f1c1197bab2a27814404fd329d9aac
change-id: 20260912-add-from-raw-conversions-4647d890bb77

Best regards,
-- 
Filipe Xavier <felipeaggger@gmail.com>

