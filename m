Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582A6606A33C
	for <dri-devel@archiver.kernel.org>; Sat, 21 Nov 2026 13:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=jan.claussen10@web.de header.a=rsa-sha256 header.s=s29768273 header.b=lqMS1gF7
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA4E810E3FD;
	Sat, 21 Nov 2026 13:12:07 +0000 (UTC)
Received: from mout.web.de (mout.web.de [212.227.15.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DEF7A10E97B
 for <dri-devel@lists.freedesktop.org>; Sat, 21 Nov 2026 13:12:00 +0000 (UTC)
DKIM2-Signature: i=1; m=1; t=1795266719; mf=PGphbi5jbGF1c3NlbjEwQHdlYi5kZT4=;
 rt=PGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmc+; d=web.de;
 s=s29768273:rsa-sha256:I0hmxagn6Sdzs4L9MFSQC8WWYF1C
 jpNdm9cu/MO0KSALqy2y2sbRxHE3lFJuz2AMf/r/vy8EhxDd6aqv1AfBcbzedNp057Z2D1FB9Ku
 xATzg1wRk4HK34YdswWOV1ojEIAEewzX2KJvF7JV010r0mGzFd3LLZ05+yM8hN9p2wySo8F3TDl
 8LuioTykIq+lIWIXgk92tNAyjyJXiuRLtPahaUWWivgkxm3yqfA+gixNNp+WgIXQPYB5uQAL/Uw
 RYRQeiuh/QHFtX+AvnGo7gBhvYCQ7RLWLTKWbp0slCcVyvpzk5W+l6j9b+ITvQaBLhm4QQiMN+9
 2Lp+UJws3Wgy0g==;
Message-Instance: m=1; h=sha256: j77YWCt/vx+febTuUkIgulw59SMs5oEOU9wSZd2wjjk=:
 HiTtcdQ3+Ds0m4DX1z6pWYfQBN5jbny1N8mHXunV++8=, sha512:
 lTExn0ObkDteafKQfSlH/nQ9G/xu3E+Tnfxf0TzZnXuKmtS9h/gLPcBqo2d/7TqJp5dQKZlVLfRvV824ADPLWg==:
 ck7djbDvzNd24QZtwIjwXq/m35ph6EEX0/yW8aaitb2iQ8mzxv+SBLkuibsRUoXLkMSYG72SpaJg81h13BmPCA==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1795266708; x=1795871508; i=jan.claussen10@web.de;
 bh=+YwrntOyRknbggwrQKU1gw4YodNY/Moq08w7g8XJTR0=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=lqMS1gF7/4KSomDsTAvfdzjR2rO6XmxDi6kdbeH1fbpFOy5MertBDh7q5A3mXoLn
 nf28tCDOiG5vwykpsFXZW5zZ9s8vE1I85rXHnWTKY252u2max52NGvUFuMaQ0GI7K
 XKsAojsAQ3VwEGoIH63sTORLfhwSIuypCl1JaRYDYKq3g42XC87E857O0Xvxnu9Kq
 5f8PywMqRbSRBsc016WKU0FCjadiARdrHbNpglQ1ivGzNo+BDXs5vGCsj92E6341v
 dvjg0+LYGBUcNbqxTo6P8gdkqdHubvle8NoQ5SHYDpy/20rLoRYJbTYnSkO/yafOM
 94JZ89tOEcrdj/yA5A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1McZjd-1y6pvF07Uj-00cNmy; Sat, 21
 Nov 2026 14:11:48 +0100
From: =?UTF-8?q?Jan=20Clau=C3=9Fen?= <jan.claussen10@web.de>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: =?UTF-8?q?Jan=20Clau=C3=9Fen?= <jan.claussen10@web.de>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 1/8] drm/connector: Fix typo in colorspace error messages
Date: Sat, 21 Nov 2026 14:10:55 +0100
Message-ID: <20261121131126.3358-2-jan.claussen10@web.de>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261121131126.3358-1-jan.claussen10@web.de>
References: <20261121131126.3358-1-jan.claussen10@web.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:AeD/x8XLBmerMmeOrIa0KpNN1BZhIxgMeNsEosFlcgxDzsXkWc+
 bb1KNNzVJol31bWdrK5q45Y7iPmjM+hat3oSpELxPWJIxn+gyZdnJAT59TI1KPwGnx0w2l1
 pQU8tObFt5OyLCn690Fj9UwQkpA0nDpN+kShZOMRXPQ+SyD462jhMW6HwYNFKKgFtSbwoOj
 qrkMlsabPTZwsjr6vMU0A==
UI-OutboundReport: notjunk:1;M01:P0:obGl366Lg5w=;3RDWjpLYWNluPXcbSw9BQ99NJpb
 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
 Lyk90PMny0a/O14yGL0RVFshLM96kUo/jk
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Change provded to provided.

Signed-off-by: Jan Clau=C3=9Fen <jan.claussen10@web.de>
=2D--
 drivers/gpu/drm/drm_connector.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connect=
or.c
index 893716a9e489..66f53e155342 100644
=2D-- a/drivers/gpu/drm/drm_connector.c
+++ b/drivers/gpu/drm/drm_connector.c
@@ -2768,14 +2768,14 @@ static int drm_mode_create_colorspace_property(str=
uct drm_connector *connector,
 		return 0;
=20
 	if (!supported_colorspaces) {
-		drm_err(dev, "No supported colorspaces provded on [CONNECTOR:%d:%s]\n",
-			    connector->base.id, connector->name);
+		drm_err(dev, "No supported colorspaces provided on [CONNECTOR:%d:%s]\n"=
,
+			connector->base.id, connector->name);
 		return -EINVAL;
 	}
=20
 	if ((supported_colorspaces & -BIT(DRM_MODE_COLORIMETRY_COUNT)) !=3D 0) {
-		drm_err(dev, "Unknown colorspace provded on [CONNECTOR:%d:%s]\n",
-			    connector->base.id, connector->name);
+		drm_err(dev, "Unknown colorspace provided on [CONNECTOR:%d:%s]\n",
+			connector->base.id, connector->name);
 		return -EINVAL;
 	}
=20
=2D-=20
2.56.0

