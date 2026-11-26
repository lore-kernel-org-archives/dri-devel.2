Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34612606A321
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 20:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=j8Yf1LiZ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4292A10E42C;
	Thu, 26 Nov 2026 20:11:07 +0000 (UTC)
Received: from sender6-op-o11.zoho.com (sender6-op-o11.zoho.com
 [165.173.180.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F9E910E42C
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 20:11:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1795723854; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=neMfuKQL3DjukqrxNCXz1oEjTjE2Fkj5y/US10Vm+MiNQ9/A1YVkSw62AtxrGFPOHIvCcoH13tXxB25pjGgpfDZC3/3XYeD89uajnP0XmiMQ+lYvVA8QVGgAWAz/i/WKu/+04B9H9TCbE90T5W4IiOf2eUy8HCnoKBmQr6dDnRw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1795723854;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=jjH2UYzmhPzgLkuBv62Qf/P7bzdvFKQUVBGEtPzWtUM=; 
 b=gamMzD5auQUdlK7sn32/BjzATeiMNfj9PvEAprZjGG5Kj9/i1DZdVEh+Jat0F80hMrWfgQv2STojHc26NHi3a66ZIgsJFCaqZFKzLg7ghLyOITB2IikfT3BuPG3GrEG8IFtj62h4wpHbGcbKHZt+yAkHfz9asSo94fqz770QCY8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
 dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: a=rsa-sha256;
 b=j8Yf1LiZGpKo1qDXhUa1kWVzGs9KbjfcGRLm1wszxkDzSYh0l8f6azRO4vD2EUXvOqOFMnx6jSifO2G0TzSAJcow3A9+ehaO/aNo+BgD1hjnkK0ytKxOziyoTix3wDxcBov2jkllBZ9+3o3VS1iuAI7DcpEZKstVIkcvlUaPeMs=;
 c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1;
 bh=jjH2UYzmhPzgLkuBv62Qf/P7bzdvFKQUVBGEtPzWtUM=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1795723851199853.6085617662809;
 Thu, 26 Nov 2026 12:10:51 -0800 (PST)
From: Daniel Almeida <daniel.almeida@collabora.com>
Subject: [PATCH 0/4] drm/tyr: use the conversion derives for the enums
Date: Thu, 26 Nov 2026 17:10:42 -0300
Message-Id: <20261126-tyr-enum-derives-v1-0-a487b0e1bee3@collabora.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/12RS25bMQxFt2K8cV8hkRQlBUXRfRQZUPy0LuK49
 XOCFkH2XtnJxBlekOdefl6WzU9735a73cty8uf9tj8+TpE/7Rb9KY8/fN3b1Ask4JyB1/O/0+q
 PT4fVJvjs26ojKnRL2YsuE/t98tj/vVp+v3/T29P45Xq++Lx3nPzP08w6v7UtB982uWbd7b68R
 5V10DVNZoZs5219zmtaYUAUzEzW+JseHx5kHE/yWY+Hr1dvOevPq4+Sj6ZSagqPWspgtpHtQlf
 QURhmObt+oHqvDM3Jc5GeJdtoVC9AB2m1WQoGUr+lrICjWdgA81qwYHMtWpPM63SPElAZU76lK
 KVkHUApQ20+R8sWSahV7AQG2VGpa7qluKTErtHEUVCEDAh7sKURgN2IKwSkdksVLtx5IGLpThy
 hQ5BxoM/dsjeLUhoNuaWQw5K31J2zk1IkQ0pQLVSGEU2BqTW8pbzNpTu3otiSsCogQOGROXHvs
 5bnVVqGD3upSjKPrD0Xn+shKeSe0d0ZeT4ygkX4Qg3ZfJ0vP+zPd7s6JzIDTEHUay80iEumIvO
 yEVXKvGhj6Mv96+t/y2a7t/ACAAA=
X-Change-ID: 20261126-tyr-enum-derives-cbf729d01e5c
To: Daniel Almeida <daniel.almeida@collabora.com>, 
 Alice Ryhl <aliceryhl@google.com>, Danilo Krummrich <dakr@kernel.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Kaiqi Guo <chaoji_xinren@163.com>, 
 Alexandre Courbot <acourbot@nvidia.com>, dri-devel@lists.freedesktop.org, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
X-ZohoMailClient: External
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
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The `as` cast series [1] leaves 19 casts that convert an enum to its
integer value, each inside a hand-written conversion between the enum
and `Bounded`. This series derives these conversions with the `TryFrom`,
`From` and `Into` derives of Kaiqi's series "rust: add conversion
derives and exhaustive From support" [2], which removes the 19 casts.
Patch 4 also converts `EntryType`, the last enum with a hand-written
conversion, which had no cast.

This is based on drm-rust-next and depends on [1] and on patches 1 to 9
of [2]. I will follow up with a review of [2] soon.

[1] https://lore.kernel.org/all/20261125-b4-tyr-as-casts-v1-0-2b2f53164d86@collabora.com/
[2] https://lore.kernel.org/all/20260930002436.21395-1-chaoji_xinren@163.com/

---
Daniel Almeida (4):
      drm/tyr: use the conversion derives for the GPU_CONTROL enums
      drm/tyr: use the conversion derives for the MMU_AS_CONTROL enums
      drm/tyr: use the conversion derives for `CacheMode`
      drm/tyr: use the `TryFrom` derive for `EntryType`

 drivers/gpu/drm/tyr/fw.rs        |  30 +--
 drivers/gpu/drm/tyr/fw/parser.rs |  25 +-
 drivers/gpu/drm/tyr/regs.rs      | 486 ++++-----------------------------------
 3 files changed, 56 insertions(+), 485 deletions(-)
---
base-commit: 7402dd230f4497954b465145a22cff7a5a488629
change-id: 20261126-tyr-enum-derives-cbf729d01e5c
prerequisite-message-id: <20261125-b4-tyr-as-casts-v1-0-2b2f53164d86@collabora.com>
prerequisite-patch-id: 1d54819d2dac9c113331baef19e763cedb0ca517
prerequisite-patch-id: 016e94c56c10e511f6ac4c045f620207211b9f02
prerequisite-patch-id: 1899e0445dbd58f2a72b6f9bdcffba70b7e65ac4
prerequisite-patch-id: 4da30d4ec1abd60c6cbc5f5f108437abb4d5e3f3
prerequisite-patch-id: 04ac471e820674330ff6ed854c7691be3f4c7cef
prerequisite-patch-id: b62e387da808817a10df1a2977da60ecc630aeef
prerequisite-patch-id: 17733676a0b8814fabdec83ab20b749729149c4f
prerequisite-patch-id: 7a6862e6c23c43bdf11dff1f84032cd4209afc33
prerequisite-patch-id: f10354893c358db15456a84dc6113d24f03af0c0
prerequisite-patch-id: faee0bac4883bd31a407fb7fc66a40d5c2400c49
prerequisite-patch-id: 8c67c4dd9fc45169d882a349d0b27cf056197c6f
prerequisite-patch-id: b6ddee237c4a24b5c0242097aace0102820ac1db
prerequisite-patch-id: d1a6ccba37c85b7f62a7a06d73ce09813a5c6530
prerequisite-patch-id: c4eb8ca570fef755b66db1d2f5372cb562b8c1ec
prerequisite-patch-id: c997628e4e15a91a1db84772cb92a878d0f624ce
prerequisite-patch-id: d52e3ddfdb2de753538ec5c70acbf9ef5f276301
prerequisite-patch-id: 4000d922c41278ed2f1df0a4873942d21e3c49c0
prerequisite-patch-id: 65006ecf8ae3a3aa4d2439f6d0bf239d4672f208
prerequisite-patch-id: 565696b33359e46ffcba363b3e72c1e8df5584ba
prerequisite-patch-id: 36fd0e809e61e4c4f0d34027dfcabd4434030883
prerequisite-patch-id: e8bf99685c380a6cc232256b160699bf91cbf812
prerequisite-patch-id: 6cca0def1c915ef8a34c21913eee636a57ff6aa6

Best regards,
--  
Daniel Almeida <daniel.almeida@collabora.com>

