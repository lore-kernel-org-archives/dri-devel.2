Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37862606A321
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 05:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Xql2aFgh
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 06EE510E67F;
	Mon,  9 Nov 2026 05:55:08 +0000 (UTC)
Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com
 [74.125.224.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5575010E66A
 for <dri-devel@lists.freedesktop.org>; Mon,  9 Nov 2026 05:55:01 +0000 (UTC)
Received: by mail-yx1-f52.google.com with SMTP id
 956f58d0204a3-67be6030c9fso315450d50.3
 for <dri-devel@lists.freedesktop.org>; Sun, 08 Nov 2026 21:55:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794203700; x=1794808500; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WuEkyJlGmaVmS+cJe0Zg9gFqtsrOZkdKM+2bmPOdgzA=;
 b=Xql2aFgh/oI94LtAfy+Yci7PZay/ePAE3A7/tttIfRq4kglpfw72G6iOw5mnYkdVrs
 oqPIlT0m8pru9wVGxhP1W1+gXcZCXsM5YSk9O0AdOGPJvfhq6sDw0wlsrWpdefPRPNsm
 aeEW9g4W3HnobQn4VD+F8bd65fvd1LwzC+3J/5imW7Dygcgonwxvp8xaj7b8pOvamMQ1
 BlYoWZ36+7IvaPnoT5ox+8t6VIpNYVDwLgLd6RMorO1IwMZBgzCCis50DCOUJUE7rmoR
 EnzfCZW1XjDErZzlkr2p6xV9rKPpOibXc/71jf7nbbJMnqt2KzM2oYsAtTOYIEbJ/Sap
 Dt2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794203700; x=1794808500;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=WuEkyJlGmaVmS+cJe0Zg9gFqtsrOZkdKM+2bmPOdgzA=;
 b=ay2VlIJ6XeXmksq8szyEn7TcBAlwY9WznvJ0rRVkF8mozAFwCNDnP1fdE/2E4mYmHR
 S85xR2h8JgxMeXs807QX++HZvupXEnch5Dkp5ELbNcv5hOSWhDIoF2TmsdlEYDGXccZi
 tZeXy2VwlnpBn/IUfLAmXpAbmzr5Zkyrcbe5/CZ5klo4/v6e21zJFW7YaYJHfT1C5C5E
 Qu6bHlZYOF53WSwODYpQdf0tH8ENKc8/iBc+IKzeFEl77FiPBo1PxgePQZOLzuIHeIGT
 Okeiav6zbZXjJ+g6tqyLafNzrhYVVYivJB7qFzZiq57HO49Sw568X6UG9FlzkF8HN/SI
 a85A==
X-Gm-Message-State: APuU4Z+n53k9OsaDuJFwKDWbDk4MzGWvtxRcpmGNC+Qsx/fX8eBmI1De
 BvRdZb7Yoi0K6P0x6SCFOEFoGLUA7hrna9iSmCyQzlpjqFN0nRtjGTffxSM3ntrL
X-Gm-Gg: AYBFou2mZ80WhZfMQZcbc0gqzU9o8W2YIbzf/0vu0bTEoVoW4pGN+WkNzmD1SYGSYet
 mSNeAb6gPtrMTBM1FWE3OwcFfshJH+wZUJrlrNeSbcrQ4WGVmqawQgSMQiKB6FISZymvaPMALvb
 WqxklBagCKq6b+Qlppsa5chs/ZZl14aCHNPirssnVb63lajDEpU/OaMXR6gWX22gf0k0+Qu9MHM
 ZPyzH7f+e7yALh4NNIS1iZOJu1UNf52LfGmhRylpAQ1grYlqh8wv5Df1iisFl0gsMTTrPaED3+u
 oNZlo54EjSbeEt2bVuwvehjXdI0PjzLHhVGNMnuODNTVDiUs0cVfBqQ9GoT2/a+ZYkcFyXinIRg
 UvO+3oNqLID98xUJUH19AXKidj83mHefwFdefJ6r2t0xJxesBpieOetrNqhciUsTe475jXQU0Q/
 pQkRsDgySXR4s6pS1nKdS4FCzqrBqUO0M3fvRzJnP4AbTyAef6Qkow7KbErmhSmQdVmFaKdRA6x
 Kj2oysClVDrmvRraV1okh+ec5o8V0iyrqL5WzB/eB5IEfnde9GY3QYKn1mCjr2QFUHjMPD2D3Xk
 KSIVCJeXwym8u3RWXLsu65H6Tn6oreRE6MqZcc56llaqIMzVgi8oPWnes/EzTVho1w0=
X-Received: by 2002:a05:690e:43d0:b0:67c:1ad6:5c6 with SMTP id
 956f58d0204a3-67c3da5d35emr1212215d50.81.1794203700304; 
 Sun, 08 Nov 2026 21:55:00 -0800 (PST)
Received: from localhost.localdomain
 ([2804:1254:81a4:f900:8485:f8a0:b2aa:dee6])
 by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-67c3b83e8bdsm3312398d50.1.2026.11.08.21.54.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Nov 2026 21:55:00 -0800 (PST)
From: Gabriel Gama <operatingsystemsdepression@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: patrik.r.jakobsson@gmail.com,
 Gabriel Gama <operatingsystemsdepression@gmail.com>
Subject: [RFC PATCH 2/6] drm/gma500: do not underflow an unpinned GEM object
Date: Mon,  9 Nov 2026 02:54:46 -0300
Message-ID: <20261109055451.17458-3-operatingsystemsdepression@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261109055451.17458-1-operatingsystemsdepression@gmail.com>
References: <20261109055451.17458-1-operatingsystemsdepression@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Return after warning if psb_gem_unpin() is called without a pin.
Decrementing zero makes in_gart negative, so later pins incorrectly skip
backing-page and mapping setup. Release the reservation lock normally.

Signed-off-by: Gabriel Gama <operatingsystemsdepression@gmail.com>

---
 drivers/gpu/drm/gma500/gem.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/gma500/gem.c b/drivers/gpu/drm/gma500/gem.c
index 7250bf660..fa5d3f137 100644
--- a/drivers/gpu/drm/gma500/gem.c
+++ b/drivers/gpu/drm/gma500/gem.c
@@ -85,7 +85,8 @@ void psb_gem_unpin(struct psb_gem_object *pobj)
 	if (drm_WARN_ONCE(dev, ret, "dma_resv_lock() failed, ret=%d\n", ret))
 		return;
 
-	WARN_ON(!pobj->in_gart);
+	if (WARN_ON(!pobj->in_gart))
+		goto out;
 
 	--pobj->in_gart;
 
