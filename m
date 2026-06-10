Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D94DCD98CC
	for <dri-devel@archiver.kernel.org>; Wed, 10 Jun 2026 18:36:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 97EB310EB47;
	Wed, 10 Jun 2026 18:35:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=web.de header.i=markus.elfring@web.de header.b="YTpXBmws";
	dkim-atps=neutral
Received: from mout.web.de (mout.web.de [212.227.15.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E5B010EB47
 for <dri-devel@lists.freedesktop.org>; Wed, 10 Jun 2026 18:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1781116549; x=1781721349; i=markus.elfring@web.de;
 bh=plE0UdqA8T/i5w8JapD/SVOvXKNeqcif1kMIwm0T8Ss=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
 Subject:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=YTpXBmwsvSO9Dm+Li4J3EAgWZw+KylRymaXSEzbMAHCew2c/nLJbI3wC//r793eh
 5vjCaInZGpO3ZcmTusYJJxiy4LN5KSz7826pucRmy/II0mR8OSEL1YpwO8Jq+5/Y3
 /yqQKGvo2l24MqjMDwHnH93YX34zfCSaPCdHiBPlYHeNKr2qoqwzrP8rQPhA4NTMz
 DzqLznzm2PTJQrR5n7OreNllcXUybTsqPaXcQylj6mSedBcuU9xNTl3PArzER2hB9
 R5aB3HJ3ojTNsc7L5cCkcnohP7W/mpYWa82NUUpbA0GBXKjIArAhpw3bNfhUPhhu2
 L5ZdRGgTHeyadQJ7IA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Ml4B6-1wwUnZ21BE-00o70c; Wed, 10
 Jun 2026 20:35:49 +0200
Message-ID: <c40e9f00-ac4d-4eb5-bbc4-a6c37bf630b8@web.de>
Date: Wed, 10 Jun 2026 20:35:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: dri-devel@lists.freedesktop.org, Kees Cook <kees@kernel.org>,
 Koby Elbaz <koby.elbaz@intel.com>,
 Konstantin Sinyuk <konstantin.sinyuk@intel.com>,
 Oded Gabbay <ogabbay@kernel.org>
Content-Language: en-GB, de-DE
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] accel/habanalabs: Use common error handling code in
 hl_cb_alloc()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7LE9+oqbYtOs1sSJVojx+ynnPfbsMAcqxf0siZZEoB+nMCommme
 Z8kvVU5DFRPL+Ib0fUsNwkXqGC6PEkshSz71Wa+2001qLT2F1bX8YCebSm8ol2mg+9mISJq
 tcPFAZHampVF1uMgfnOoJqF9hFk8tl97SlMtaWxEKuYyWbWw1NbHeJf+wlBi46vgJAjSrrz
 Tvtmsc1DMBx/aciADoRZw==
UI-OutboundReport: notjunk:1;M01:P0:P4GBGsiCATs=;C5YkqJ7+XtVGRKad0HSkChvP4pY
 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
 Kv5Lig+N+jqzIzV2R4qzh6A9Zzo=
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
Date: Wed, 10 Jun 2026 20:30:23 +0200

Use an additional label so that a bit of exception handling can be better
reused at the end of this function implementation.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/accel/habanalabs/common/command_buffer.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/accel/habanalabs/common/command_buffer.c b/drivers/ac=
cel/habanalabs/common/command_buffer.c
index e929db8bc023..980c9e4f96c6 100644
=2D-- a/drivers/accel/habanalabs/common/command_buffer.c
+++ b/drivers/accel/habanalabs/common/command_buffer.c
@@ -126,10 +126,8 @@ static struct hl_cb *hl_cb_alloc(struct hl_device *hd=
ev, u32 cb_size,
=20
 	if (internal_cb) {
 		p =3D (void *) gen_pool_alloc(hdev->internal_cb_pool, cb_size);
-		if (!p) {
-			kfree(cb);
-			return NULL;
-		}
+		if (!p)
+			goto free_cb;
=20
 		cb_offset =3D p - hdev->internal_cb_pool_virt_addr;
 		cb->is_internal =3D true;
@@ -147,14 +145,17 @@ static struct hl_cb *hl_cb_alloc(struct hl_device *h=
dev, u32 cb_size,
 		dev_err(hdev->dev,
 			"failed to allocate %d of dma memory for CB\n",
 			cb_size);
-		kfree(cb);
-		return NULL;
+		goto free_cb;
 	}
=20
 	cb->kernel_address =3D p;
 	cb->size =3D cb_size;
=20
 	return cb;
+
+free_cb:
+	kfree(cb);
+	return NULL;
 }
=20
 struct hl_cb_mmap_mem_alloc_args {
=2D-=20
2.54.0

