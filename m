Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D7F606A326
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 05:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QILvpvdB
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9CA4810E960;
	Fri,  6 Nov 2026 05:34:23 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9FF0110E960
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 05:34:12 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 7538660215;
 Fri,  6 Nov 2026 05:34:11 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1793943251;
 b=q+ovkLcjYFWwh+Yrp9fwXWoarGgo/42K0AtWh8qvNgVMJkeGNQ12SwMbwwJ58D1kQZ5V
 DJlVSMcJ/Ft7FvjBKMMGE5g0VA9TcGItb8BW8U3f2zf5dyzndnBpfdbxaL0s8AIMr1GUw
 u3VXW+ALshpF7m2rmvpfMm2pNwQWIOgcN58Qq9ab2pWQPrrHnAaJsbg0rdcAEScEyPr+c
 VUF9qIcv3WLxYUm/5UxCo+8f+pxVtk4AFQKNglb3zhdLv53vIvceQbJB/RDgAISgfFz6E
 qqy26HRU/Rsd1mn7qP5T1ElLlTSo8HxBjQfmgYGWmc2fwZwFLOA/4Q1TfbicEYbCpJA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1793943251;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=9RACgfXqxEW7DMRyULabdQj6O5k8oCjNhfEx8/b7070=;
 b=c91RuIcq0vZZg7t3xX2sRcrGVrr+k3aThcwKWBvCHqgnrLJ4IIdy68seY0L0PBObdbK7
 WqoGFLbq3GKWJBqFYoM9r/k3i7Wp3Y62l2vFpml7zbEoxxeZBvMqDhiFAk7dET2S5dJ8i
 lXKkcxzIpeu7m6rl69ivkdPJRGzgLLuJ6fd8pz2MqWsgNjMzBQ02er9UDhRhvCECcECGy
 Y4K2UlCwYFoAWb/624qSDYT0Qa34Yuxie9k0t/GSN+eiH44gXrstIIgWB8xriMjkfnI4T
 uwBVvxm42pSIMdwmgQr7qR2UQEq04dtXUpFgOCWGq7dmxGQO/VNcy+Owb3xxHBscsGA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id A95201F008A2;
 Fri,  6 Nov 2026 05:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793943251;
 bh=9RACgfXqxEW7DMRyULabdQj6O5k8oCjNhfEx8/b7070=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=QILvpvdB0LeFG4O++pOlv4vBYMuMxylHPicIXMUwH4ROP7clCuv+hZZFX0A/q8lZT
 OEVwFu45QN3AlEAARbr34Iqf9zRxbWtbz6/NTebWlGmv25Gh1JpfZBU/n5nN7qrI52
 l/Tua8ctRmdO0mG43gwks1xQLPGSYZNJHWh37kBGp+mZiiUohx4FObGp7KE9oNMH81
 hA+EK37i/8facOk07NJAPVX12zBdxTXIYh99HbLsuNAIXHcHeUG2PvL6J+B8QAcT9j
 y4lbL4zyVZhcCgjb7FY6YWlpjortCT00lQImyeMsqdHWiWVNtzkrd6y5KVVYbZzi5O
 kHJLtedMbJqfA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 1A4F245BE0;
 Fri,  6 Nov 2026 05:34:10 +0000 (UTC)
From: Dave Airlie via B4 Relay <devnull+airlied.redhat.com@kernel.org>
Date: Fri, 06 Nov 2026 15:34:02 +1000
Subject: [PATCH v5 1/2] rust: time: expose as_nanos for clock sources.
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261106-nova-timer-v5-1-a0cd25f3ee18@redhat.com>
References: <20261106-nova-timer-v5-0-a0cd25f3ee18@redhat.com>
In-Reply-To: <20261106-nova-timer-v5-0-a0cd25f3ee18@redhat.com>
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
 b=owEBbQKS/ZANAwAKAQx081l5xIa+AcsmYgBq7WbQKS4Byme7iSfrmcFJBVcSx/qvq/fFrwEdw
 R4AKKwkXRSJAjMEAAEKAB0WIQQQptkdobBb0p9t66wMdPNZecSGvgUCau1m0AAKCRAMdPNZecSG
 vpUEEAChtkOLcH2fwPeHNgCHf25MY9QXYKZHB4rkgMxJHcRcoom0bUrHX5wRbdTSXPrD92jQ53u
 xlHIDe5kE8MhPADu9T05lira3CJyGnr3ofGVVHEzM+LIMYViXV07xEQAjwPBrgDhpa+qDdG94sa
 /DQnUeSxu3ohXZeEvOVuxR09SWRdrth95sxxX0OkRSY09x4iUHIbrdxW5QEFr8jIuszBeLGwYpr
 sG6YI3602ztC/UKGpgsiD6L5XT4phrLgp7ZWjSfZNGjNrrtGOEauGcMgDp8a74f6ILcatmK5cyb
 Fx1zvNSjL8dvH+uOKIqhLxZf/0Qs3y5luxiOCspkzM4kE4vC3iYvVU9rvcKiiYEElfLZbWCImbZ
 GiLH7Eg+ygPxb1qpcfqOBy70tLVdnwfhPvYbCR4/hKFEcg1AZvbu0O+rH8tqQmZM8aLfWR8CNiz
 m2LYTZM1VE5L7+0gTM4OblzZJscKU+0QxEfNbXBoa7BV1lEXvDLmXCB+ufrp1MrtnqzrjHfHGzx
 HmWxHtNg2LzLAgyBjTay92dQhkAMtW892f/0pe3b4oVQ4rGxfrj2DysT42eIvUthP6VMDgKlJkp
 iQoqcHrVgwS1Oh8QxrDXPvfFNbgtrSHT9sfiuUv30XJrmpHSwNbwVC+CSQj3/5fYpv7VEVc8cgA
 nYlgJjvzH6ol7DQ==
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


