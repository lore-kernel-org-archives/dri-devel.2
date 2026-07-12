Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD203C43458
	for <dri-devel@archiver.kernel.org>; Sun, 12 Jul 2026 14:56:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B0C0589EAE;
	Sun, 12 Jul 2026 14:56:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=web.de header.i=markus.elfring@web.de header.b="KpHPsacf";
	dkim-atps=neutral
Received: from mout.web.de (mout.web.de [212.227.15.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F6EF89EAE
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Jul 2026 14:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1783868192; x=1784472992; i=markus.elfring@web.de;
 bh=E1uiV2f4RsNo/41cyAPXkgAal6adVNEDi9CnAHPXqyQ=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
 Subject:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=KpHPsacfyqFOmYkBfbbEKTQ9igRvTy0jpxYDEQPh+6/50uaGHkxIZdCd3YA/5mgp
 9UDfgjaS3pN25X+wm+hWDcnc9wa1zZUOTbFP9r1y/OWNmP14RyLPLsiIGt4VHcw76
 wr5LmE1EQ+oJA+Z+eLfZ4aABDXtlASFs97CfhxibZZ4A5HBqIxZtSrQDEWV4aSazd
 Yrpnq81P6bh1WWq9iVfeYUv4c6uLOk7V/SZbKxK2R+bG3PHOqPtgFVcaMH3MYujtn
 11X8D4pNpgvHQR0ff26ebBVWkYNoD5EBrS5EouxTXAxfh2tUtruS4aKXlmNaHrG3T
 +jBeWSlnH+ChRTYEHg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mw9x2-1x1Yz548qi-0106q2; Sun, 12
 Jul 2026 16:56:32 +0200
Message-ID: <b9486c31-d8ea-4e93-bc5f-5a6da842af59@web.de>
Date: Sun, 12 Jul 2026 16:56:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: dri-devel@lists.freedesktop.org,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Nirmoy Das <nirmoy.das@amd.com>,
 Simona Vetter <simona@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>
Content-Language: en-GB, de-DE
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] drm/mm: Move a variable assignment behind a condition check
 in DECLARE_NEXT_HOLE_ADDR()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:kNUyiOsi+kMN3P6KMNs9JP4Ek/t1q3kDvL8VaPOJmD0X3CVa9TC
 pmi6vRGmVeuyd85JMVzOfkJmD1uBjXlnlYQ4M6rSwsaqRimZk2gh+/rJs/3Q/iUqtt3HkvY
 6v7JcAoChiaG2QllUAGNgN04+KjkdB/hzekI7QOGvNhyzn4bVI8tfsoPNqrTiq/Gznv6JyO
 HslBYE6aCTlImbZbnnl8A==
UI-OutboundReport: notjunk:1;M01:P0:uHaQRHrsMOM=;IeYfxMNS9YspUcCeHt6te5zORd1
 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
 =
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

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 12 Jul 2026 16:48:41 +0200

The address of a data structure member was determined before
a corresponding null pointer check in the implementation of
the macro =E2=80=9CDECLARE_NEXT_HOLE_ADDR=E2=80=9D.

Thus avoid the risk for undefined behaviour by moving the assignment
for the variable =E2=80=9Cnode=E2=80=9D behind a condition check.

This issue was detected by using the Coccinelle software.

Fixes: 5fad79fd66ff90b8c0a95319dad0b099008f8347 ("drm/mm: cleanup and impr=
ove next_hole_*_addr()")
Cc: stable@vger.kernel.org
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/gpu/drm/drm_mm.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_mm.c b/drivers/gpu/drm/drm_mm.c
index 6692abe564d3..9b9bece8da7d 100644
=2D-- a/drivers/gpu/drm/drm_mm.c
+++ b/drivers/gpu/drm/drm_mm.c
@@ -390,9 +390,13 @@ first_hole(struct drm_mm *mm,
 #define DECLARE_NEXT_HOLE_ADDR(name, first, last)			\
 static struct drm_mm_node *name(struct drm_mm_node *entry, u64 size)	\
 {									\
-	struct rb_node *parent, *node =3D &entry->rb_hole_addr;		\
+	struct rb_node *parent, *node;					\
 									\
-	if (!entry || RB_EMPTY_NODE(node))				\
+	if (!entry)							\
+		return NULL;						\
+									\
+	node =3D &entry->rb_hole_addr;					\
+	if (RB_EMPTY_NODE(node))					\
 		return NULL;						\
 									\
 	if (usable_hole_addr(node->first, size)) {			\
=2D-=20
2.55.0

