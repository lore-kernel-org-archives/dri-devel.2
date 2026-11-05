Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB2FE606A331
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 03:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=amQ8pcpZ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 744CA10FFDC;
	Thu,  5 Nov 2026 03:07:26 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1373510FFE4
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 03:07:19 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4AE81605F4;
 Thu,  5 Nov 2026 03:07:18 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1793848038;
 b=NNI5yDlro8zCJshptqz/AtUabHWxRj/PmoojtEB6JA45MWhAfzWGC8Da8Bww89hdkpF4
 yWcC/8mkaiyZDIUy9kABu/jSv2h6QwULShWeZ58+P6PtV+AzBVycROW4KpgUz5cKhg9kb
 zsBAxd4gRKdJFIWqG6RmQMhuUXGCK96SCWA8bmCxFfQbT46q/lkmMnX2IqmssOV1xTNqy
 QESmUEDgcwen7T3ej6M/rvnmPbZzgAS2Wrg0FIGD9/8XoBn5sT/ewBmfWVymQU7sluAvx
 r675WF6Gs4T5Gh7CCA9XJvm3UWrvuNWR8Llg5JhGbVTrayLEgpOR5ECJZzDj64FARHg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1793848038;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=CIZwBicKTVVZGS9q/v6H0FbAbpUFwd+2SA14hRFFKAg=;
 b=OTRI76F9TAM/KbblszoNrGFde9XzI0yUqSOgVD9S6Dxhyv8wO7YtdlUlMqmx5lJxrt6M
 KwtT+qNHBNkRylTo03Eclz2088llPZNzqlHs8HgQ2RPZcpHkxm/jkb1aF+TI+c/Rc93PK
 5/+eeg091tjv0bH9v/kFUl1sZg4TsgZlF1tYoXTOz+evoXaigFUFjHD4oi35NiJHU2UUr
 YcDAwnECkP2QyrjISgueeQLW94TSavdFZVjWtcqSh+eLQOHe0CpIcSIK4Ac0s20JhCRTD
 ReK7wQzhEqD6++1OFPWnAM3xESGpiCjofx5BJUXG0GBaaXia4yptZ5RJIe0x+c/fmtA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 54D711F00A25;
 Thu,  5 Nov 2026 03:07:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793848038;
 bh=CIZwBicKTVVZGS9q/v6H0FbAbpUFwd+2SA14hRFFKAg=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=amQ8pcpZJBhtUkNT71aAijVJ7AJBi5tvRbIyKxzN4sr6b1fi0FWL2N6Jj//GYi00k
 I5HiEPa0d2s3EbPOwWAUH074WW0wRUzem/6XpXTt625oiPKEaFOkZvbZtlxG4NGoZr
 +eNW5j5qxhexqMasvzKyr2Hf9eUkufc+jdNd4yWRG8jSNsInwh8RVTubbLTHkNaQ/d
 Q02hbWRqt836+2Uf+1lGdlYpe1W5R6mqDln7SCIDt8DHXwiat7l/3dhCZlidj7To2L
 ACq1iJLfsOyJ7NZ0ZBKyEZXMKKU2RdpLfjQGjEWFo4oHxh7PnmdmLecM9p+FMNHDu8
 7YsUrMWNljFOw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id B78A647061;
 Thu,  5 Nov 2026 03:07:15 +0000 (UTC)
From: Dave Airlie via B4 Relay <devnull+airlied.redhat.com@kernel.org>
Date: Thu, 05 Nov 2026 13:07:01 +1000
Subject: [PATCH v4 1/2] rust: time: expose as_nanos for clock sources.
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261105-nova-timer-v4-1-45a7c121d4de@redhat.com>
References: <20261105-nova-timer-v4-0-45a7c121d4de@redhat.com>
In-Reply-To: <20261105-nova-timer-v4-0-45a7c121d4de@redhat.com>
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
 b=owEBbQKS/ZANAwAKAQx081l5xIa+AcsmYgBq6/LinQrRIgnADixMz/1LLvcnvKze93v1m29UU
 9BSMfoqMfeJAjMEAAEKAB0WIQQQptkdobBb0p9t66wMdPNZecSGvgUCauvy4gAKCRAMdPNZecSG
 voJWD/9iI9cHbRPA2S7bph6eVyjExg8j3Ez7Gt40uUXd0VSd9I7SYYQFGAJ6xmgQaupBnTrsHk0
 5C7FN9rJ9+ywLimVIK6nIwltSkMpWt5rJUGETgIdrulR+V4oaSkyjCpwFQyV/hxzD2hiy3Hj8oW
 /E5QWRrGb+ipQhrWN3qNRHRu/VnAlxIwY/v9+0+feDGIixcS6Ao1jU1vmA1cvt0n4A/ff+8NcvI
 CAkSX/HTLXlctRMXhrYrQBG224bJhc8Ngt1hoA3BvdBZEpEPQtKOkR4gLaQu1FK3v9/wD/vdPmZ
 6PF4OL9yHyl5rbyHeWV3shW4DsLngS5bzXbQNQpHaVgbm9RPipJ7x31eGzSMrJCUJuD4eJWgvgF
 k4MVDGZmS5yDY3Dl/VjB/8DJhhIdQIMLuDzIxtbznhZ+/6nXbcvyDhnvJjP8UjbEiOdDZoMoi6W
 WRO5VUQxjTCmO4xz0jswRt4q7HPiGUu05z1+p1ObJ0vk34bRvmv9DdCYnDywjclcBGjERcwtkHs
 umONmwpSX20FnsbPfG5fjrh3rwOytgvQrWoKjxdQyB5ElKDD38R7XFCXqqtYncBpeYERl9VSFjT
 EuB+x5p5xBLEl2SwuYKDWZGIrOc4UOAXOqrA9zc+kPnvrg0YTb9e9yAOixIHBU7EaDo6II2vfFM
 bAQJFlwBhVuSCCw==
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


