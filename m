Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6C50FED3F6
	for <dri-devel@archiver.kernel.org>; Fri, 24 Apr 2026 17:29:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0197F10F665;
	Fri, 24 Apr 2026 17:29:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=permerror (0-bit key) header.d=eduardovasconcelos.com header.i=@eduardovasconcelos.com header.b="jyffZIM9";
	dkim=permerror (0-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZP2e39kb";
	dkim-atps=neutral
X-Greylist: delayed 308 seconds by postgrey-1.36 at gabe;
 Fri, 24 Apr 2026 14:11:37 UTC
Received: from flow-b7-smtp.messagingengine.com
 (flow-b7-smtp.messagingengine.com [202.12.124.142])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC99710E3B4
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 14:11:37 +0000 (UTC)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailflow.stl.internal (Postfix) with ESMTP id 287781300F6C;
 Fri, 24 Apr 2026 10:06:28 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-04.internal (MEProxy); Fri, 24 Apr 2026 10:06:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 eduardovasconcelos.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:from:from:in-reply-to:message-id
 :mime-version:reply-to:subject:subject:to:to; s=fm1; t=
 1777039587; x=1777043187; bh=oHuMOvtj1iezE1YeNuDLSCyrYSQUS/0Yz/m
 go3MwrYs=; b=jyffZIM9CAu7RLVGskBsOaknZ1Fb9Nj2OgVtx2v36VsXTKcrl+w
 oQRl7+Iq80V6drEjweeeI2MsCd3B6V148U6pBdj6xyBhEo8/RMRXz/mYSXS2kctQ
 V6Ikz+0Am9iiuLtNveDQ3iDzB5IS5PcNMLnlofz+9Xpm3EAgfrH0Y9fLJYJqVCbJ
 TN49CAiD2IcZgfyyuEYoPcT1o7enASVWuibrOg2mWxMcLX97ZG3QTRSD7WKhK35z
 QjioEaKc1+hf/2GmCeodL/voRzc6+PnJMkLU/BOMsBTBnY/C/4wEMle74eW0fc2K
 NW+07csFrW+Gume17Idji/7hLN23bkKusdw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
 1777039587; x=1777043187; bh=oHuMOvtj1iezE1YeNuDLSCyrYSQUS/0Yz/m
 go3MwrYs=; b=ZP2e39kbNb8sjWgt7gZLAqyvfkxjHPxs0c1j5qEKAoTpGATbWUP
 pCbuB2rvxegPdl3trSyAm+rUD7IEoRnMvnIUgIBvGijWvvREcQa25gZgFBW4nSh+
 GRavmn+i0BWZH+yqTWKv8jKLa5zgLqqqltN1sHteHh/KhE4v/L7CH+rcr0IGGsc2
 DJXWDE5UyDcUTQRVlZ4zKYFVFk6fAf8k5Mmr+nY3M8Mfhsl6x1TUbJXYCVVswf0I
 bLpwXYMYzusfdbugZEYbfwxdVEKNdI6xSGKo68ETruRM1TK1Kag6MFju6ysk9Llx
 tahEOkj6VTeZ670vVKJCJv9gg/Qa3gAhkFg==
X-ME-Sender: <xms:4njraQ4Xf8s23F1Yzd7x3ROe84cagSZv8-EJWot-BlQqeKzWmVhODg>
 <xme:4njraedLh7CMayWeGhfWPc1Tqfj62b67W0p-9EYjvagn6JbqDuF1u5OCpNoS7Q-Qx
 _cN_hIEHusqY6rI7s8LiAHpscinu4HQyVmC2O2dLGKW_vH3hWdOD-s>
X-ME-Received: <xmr:4njraT4UZ3ZrY-VP1dw9Uw7vG6o0tgaYYQtVsodw97P3o1puo5rE3ZANisLyRw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdejtddvfecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgggfestdekredtredttd
 enucfhrhhomhepgfguuhgrrhguohcugggrshgtohhntggvlhhoshcuoegvughurghrugho
 segvughurghrughovhgrshgtohhntggvlhhoshdrtghomheqnecuggftrfgrthhtvghrnh
 epuddtueffheevgeduudegfeffjeevveeugeegjeeuvdelhefgkeeujefggffhffeunecu
 vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepvgguuhgrrh
 guohesvgguuhgrrhguohhvrghstghonhgtvghlohhsrdgtohhmpdhnsggprhgtphhtthho
 peelpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmrggrrhhtvghnrdhlrghnkh
 hhohhrshhtsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohepmhhrihhprghr
 ugeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthiiihhmmhgvrhhmrghnnhesshhush
 gvrdguvgdprhgtphhtthhopegrihhrlhhivggusehgmhgrihhlrdgtohhmpdhrtghpthht
 ohepshhimhhonhgrsehffhiflhhlrdgthhdprhgtphhtthhopegvughurghrughosegvug
 hurghrughovhgrshgtohhntggvlhhoshdrtghomhdprhgtphhtthhopegurhhiqdguvghv
 vghlsehlihhsthhsrdhfrhgvvgguvghskhhtohhprdhorhhgpdhrtghpthhtoheplhhinh
 hugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgv
 rhhnvghlqdhjrghnihhtohhrshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:4njrab9TsKMSzAGnmzBQBBxi3efbelVccmxMKWoBDHpTgRWVoPyB_w>
 <xmx:4njraVEag09JlgTu5x-w57cAApIYMboxkW4WL3Ibhwv-j4DdesnJ1w>
 <xmx:4njraQVyJf7RO_1gcnoXNX2sCBoX8_g08zkNuPBH0N5zhpkInxOQnQ>
 <xmx:4njraR9zvuBFUb41bE4E48dA2HjRqxj1kAJxg_Y9FlW93exVTWcDBQ>
 <xmx:43jradE5gVON7dWaMvPYhbM9bnGjfUVmxbSpg-5NejEiLKmGAqhNV8nf>
Feedback-ID: iac1e4b6b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 24 Apr 2026 10:06:23 -0400 (EDT)
From: Eduardo Vasconcelos <eduardo@eduardovasconcelos.com>
To: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch
Cc: Eduardo Vasconcelos <eduardo@eduardovasconcelos.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
Subject: [PATCH] drm/crc: Fix typo in documentation for drm_crtc_crc
Date: Fri, 24 Apr 2026 11:05:13 -0300
Message-ID: <20260424140515.2019-1-eduardo@eduardovasconcelos.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 24 Apr 2026 17:29:28 +0000
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

There is a typo in the documentation for struct drm_crtc_crc ("occured." -> "occurred"). Fix it.

Signed-off-by: Eduardo Vasconcelos <eduardo@eduardovasconcelos.com>
---
 include/drm/drm_debugfs_crc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/drm/drm_debugfs_crc.h b/include/drm/drm_debugfs_crc.h
index 1b4c98c2f838..1cb71c03bf44 100644
--- a/include/drm/drm_debugfs_crc.h
+++ b/include/drm/drm_debugfs_crc.h
@@ -49,7 +49,7 @@ struct drm_crtc_crc_entry {
  * @lock: protects the fields in this struct
  * @source: name of the currently configured source of CRCs
  * @opened: whether userspace has opened the data file for reading
- * @overflow: whether an overflow occured.
+ * @overflow: whether an overflow occurred
  * @entries: array of entries, with size of %DRM_CRC_ENTRIES_NR
  * @head: head of circular queue
  * @tail: tail of circular queue
-- 
2.54.0

