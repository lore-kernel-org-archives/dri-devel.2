Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FF3BCD4F54
	for <dri-devel@archiver.kernel.org>; Sat, 30 May 2026 01:13:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B1D1E112684;
	Sat, 30 May 2026 01:13:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="bev7/HEH";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 187A1112687
 for <dri-devel@lists.freedesktop.org>; Sat, 30 May 2026 01:13:54 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id CB6AC44674;
 Sat, 30 May 2026 01:13:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9C2CAC4AF09;
 Sat, 30 May 2026 01:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1780103633;
 bh=0ud1QnU6DSZTrgik1DuQ8GzbwSpCgKyutvxo4R3s3/Y=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=bev7/HEHgvD5ODGAAPDH4NLT8ZoG85HIiOyTU8eVjhjl8dF+GTP9SNItnayyWxCBd
 KPsieC5Rvq1vZ961HMAeAuXC1DRtCvIkydjPRQd+IiGAEb79gIrc5Yu9ZBYWPzNUvb
 ZEqhGIFIH47ngOQEquOabjIa4iYth9UXfUTwmOwgExM7ox5auNNAlmPAoRkBylqi45
 Xb3gilT5GuIpo2HFfTkZAnur/oAb/ujtvr/PdU1WTy14wDv8CS49Sk33Kky/Ta8J6z
 0ijBDGynlaDiaPBSIpT86cyrctic2b5Y25IA47l432g/0QY3UV1UMX/ZkXoAhFRUIl
 PEoN3/wwg/y6g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 8CEB9CD6E53;
 Sat, 30 May 2026 01:13:53 +0000 (UTC)
From: Markus Probst via B4 Relay <devnull+markus.probst.posteo.de@kernel.org>
Date: Sat, 30 May 2026 03:13:50 +0200
Subject: [PATCH v8 2/5] serdev: add rust private data to serdev_device
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260530-rust_serdev-v8-2-2a95f1da22a7@posteo.de>
References: <20260530-rust_serdev-v8-0-2a95f1da22a7@posteo.de>
In-Reply-To: <20260530-rust_serdev-v8-0-2a95f1da22a7@posteo.de>
To: Rob Herring <robh@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, 
 Kari Argillander <kari.argillander@gmail.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, Boqun Feng <boqun@kernel.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Boqun Feng <boqun@kernel.org>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, linux-pm@vger.kernel.org, 
 driver-core@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 Markus Probst <markus.probst@posteo.de>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1683;
 i=markus.probst@posteo.de; h=from:subject:message-id;
 bh=Lci9sJZ/Hd89WrWg8pDQ/wKU3djKPRT47wh61HUUHxo=;
 b=owEBiQJ2/ZANAwAIATR2H/jnrUPSAcsmYgBqGjnPHOTEhfqnhbwmmGCBFLn1wOiKsWKQOa3Sj
 kHB2JgOI4WJAk8EAAEIADkWIQSCdBjE9KxY53IwxHM0dh/4561D0gUCaho5zxsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDIACgkQNHYf+OetQ9LvBw/8DEH1sCnx1FyuswKn4avKv4ZzqA70FFn
 n9D2QN0m7Fm+3amdoXrUwEGTD+TARN3zMV+52cl1/OXK5qOHuxhPaZKvR7TmriwGkhNyYzkAcZ5
 Rbds3vnyFKF0mT78MgmeL8HKkSYawt/s+u+HOu4IiaVmO38uv1nrzZuSH3TkHdALy8cdiXMczdj
 TmWYE4s2pG30yijY+GF08s68ncu3+uWIsaBJyV2MgHKuYKhEtvtSWpgILfgUe35GtCKQw/zrc7a
 qHdzbgpn2/vgahiufKVawAP6GavvtVT/kN5LxFjEAJ7Yxui5vlmuMM7JxqZUcyvToQpHHER4u8h
 7g++96xJrtGBggPkwjAXTyuVxscke2sLpjOBwWYxvqMOUrdxMBT/DARM6rakngR3xrvbNP4UV3U
 CHQp2q3RrOaJs1ObUBGT6G/TJPO9TNy98sCgCjP/qQcXnH/73vg8OzfMEALQYI+HClQys0IztLO
 mZVmF2YQfMCX0GtklLIikareIim2XCs4v/RePtI/MOBQgAc3+DIN9nCFnuv9DneBCQTmPStZyC0
 qo7mxgLjvmLhMwYtMsBsgzxzlaK7s8kavOkWnD+/EdB3qo/YPjT5TIQX5U97SH1CZSl7vcq23ra
 Yl4bf2qGOUs4zILBtrQzKgq6pv2x807b8NVTqCraNNSiKc3ToMJs=
X-Developer-Key: i=markus.probst@posteo.de; a=openpgp;
 fpr=827418C4F4AC58E77230C47334761FF8E7AD43D2
X-Endpoint-Received: by B4 Relay for markus.probst@posteo.de/default with
 auth_id=680
X-Original-From: Markus Probst <markus.probst@posteo.de>
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
Reply-To: markus.probst@posteo.de
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

From: Markus Probst <markus.probst@posteo.de>

Add rust private data to `struct serdev_device`, as it is required by the
rust abstraction added in the following commit
(rust: add basic serial device bus abstractions).

Signed-off-by: Markus Probst <markus.probst@posteo.de>
---
 include/linux/serdev.h | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/include/linux/serdev.h b/include/linux/serdev.h
index b6c3d957ec15..048ef5857786 100644
--- a/include/linux/serdev.h
+++ b/include/linux/serdev.h
@@ -33,12 +33,14 @@ struct serdev_device_ops {
 
 /**
  * struct serdev_device - Basic representation of an serdev device
- * @dev:	Driver model representation of the device.
- * @nr:		Device number on serdev bus.
- * @ctrl:	serdev controller managing this device.
- * @ops:	Device operations.
- * @write_comp:	Completion used by serdev_device_write() internally
- * @write_lock:	Lock to serialize access when writing data
+ * @dev:		Driver model representation of the device.
+ * @nr:			Device number on serdev bus.
+ * @ctrl:		serdev controller managing this device.
+ * @ops:		Device operations.
+ * @write_comp:		Completion used by serdev_device_write() internally
+ * @write_lock:		Lock to serialize access when writing data
+ * @rust_private_data:	Private data for the rust abstraction. This should
+ *			not be used by the C drivers.
  */
 struct serdev_device {
 	struct device dev;
@@ -47,6 +49,7 @@ struct serdev_device {
 	const struct serdev_device_ops *ops;
 	struct completion write_comp;
 	struct mutex write_lock;
+	void *rust_private_data;
 };
 
 #define to_serdev_device(d) container_of_const(d, struct serdev_device, dev)

-- 
2.53.0


