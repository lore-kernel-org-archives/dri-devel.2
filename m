Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0B07C43458
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 10:18:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0778F10E8D4;
	Mon, 13 Jul 2026 10:18:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=web.de header.i=markus.elfring@web.de header.b="QU1hSfS9";
	dkim-atps=neutral
Received: from mout.web.de (mout.web.de [212.227.17.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D89A210E8D4
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 10:18:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1783937892; x=1784542692; i=markus.elfring@web.de;
 bh=bCFTcLrIfbS67Q8Dxj6lfchLKQ7pfKN0vMLQi3APqeY=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
 Subject:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=QU1hSfS9Q+XwXRSZATJ50WwDaeiCjWLKSXzzzf2tSrqQrnpVjblHH2J9u2kJh1Zc
 DiQW88B+BdjnqCptxcGjxpV6776DuEI0bXTjEUQv2G3VOWQn3crGxZ/UTuOVBWM5W
 U/p9X3lVNn+/1NH7xpyxvKtpLa0SWSOa5yT81/ciBkLiTeXRRxVaLn257Rf0euJRa
 bvZqM3gtZs8Dj9myW7VnNkEN5ANvgkZpAYcWGCvonKNWtCWJYkrTWM56qKF06GDMT
 Akq66ev2pZA2TJjsyFuBgsLxGwnsBZXcKwII4ccK7SEPJT2q17Jr0KeLJfqTdgJn3
 7Q3zFfuOHl+KcXrPBw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MNOQy-1wQ0pq1Pzu-00Q09L; Mon, 13
 Jul 2026 12:18:12 +0200
Message-ID: <36d0eba7-e78d-4a06-95bc-c97d9b91f8f0@web.de>
Date: Mon, 13 Jul 2026 12:18:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Helge Deller <deller@gmx.de>, Kees Cook <kees@kernel.org>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Content-Language: en-GB, de-DE
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] fbdev: arkfb: Move a variable assignment behind a condition
 check in ics5342_init()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4VBd3fn+X2oA7NYVn4bnuoMq/q3dM9IlcWBnxAeRnBsEFp89iZP
 h+5qhXgFJ8IpR/EorSXFdn4uBrJlG0gKwLjpWtyRRDryKza/yoE1pC3CohWYh4j99uV+ql4
 I8g60hH4CNYDt13paPZbXqrGBsgVjy9x6o8waI/OFq5tgJfeoQPQgq0yY6L5tSsZMCzu8aM
 YIA0G7SUc1BHC9Hk/k/eQ==
UI-OutboundReport: notjunk:1;M01:P0:IgK3AsApLzA=;y2FLiTygFYjUEKtTlUnZM213f+q
 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
 7WrvkNgjNKBgp7VjQtjn+
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
Date: Mon, 13 Jul 2026 12:12:52 +0200

The address of a data structure member was determined before
a corresponding null pointer check in the implementation of
the function =E2=80=9Cics5342_init=E2=80=9D.

Thus avoid the risk for undefined behaviour by moving the assignment
for the variable =E2=80=9Cinfo=E2=80=9D behind a condition check.

This issue was detected by using the Coccinelle software.

Fixes: ede481f6dad47d40b7e561cfbc6c04286a9faf1a ("fbdev: arkfb: Cast ics53=
42_init() allocation type")
Cc: stable@vger.kernel.org
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/video/fbdev/arkfb.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/arkfb.c b/drivers/video/fbdev/arkfb.c
index 195dbf4a5142..9658f407b79a 100644
=2D-- a/drivers/video/fbdev/arkfb.c
+++ b/drivers/video/fbdev/arkfb.c
@@ -432,11 +432,12 @@ static struct dac_ops ics5342_ops =3D {
 static struct dac_info * ics5342_init(dac_read_regs_t drr, dac_write_regs=
_t dwr, void *data)
 {
 	struct ics5342_info *ics_info =3D kzalloc_obj(struct ics5342_info);
-	struct dac_info *info =3D &ics_info->dac;
+	struct dac_info *info;
=20
 	if (!ics_info)
 		return NULL;
=20
+	info =3D &ics_info->dac;
 	info->dacops =3D &ics5342_ops;
 	info->dac_read_regs =3D drr;
 	info->dac_write_regs =3D dwr;
=2D-=20
2.55.0

