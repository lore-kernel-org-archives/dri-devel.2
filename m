Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F0F606A31A
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 08:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=yandex.com header.i=@yandex.com header.a=rsa-sha256 header.s=mail header.b=egosjMlG
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 564B910EC4E;
	Mon, 26 Oct 2026 08:36:46 +0000 (UTC)
Received: from forward101d.mail.yandex.net (forward101d.mail.yandex.net
 [51.250.60.161])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E78910E042;
 Sun, 25 Oct 2026 10:24:28 +0000 (UTC)
Received: from mail-nwsmtp-smtp-production-main-63.yp-c.yandex.net
 (mail-nwsmtp-smtp-production-main-63.yp-c.yandex.net)
 by forward101d.mail.yandex.net (postfix) with ESMTPS id EC19EC0031;
 Sun, 25 Oct 2026 13:24:26 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-63 with ESMTPSA id
 GOcbPNXdW8c0-FgVCqyJ5; Sun, 25 Oct 2026 13:24:26 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.com; s=mail;
 t=1792923866; bh=HOQH/UzmoIGTnx1h57ThuzE++YZYHn+wnPmoRVPN7rQ=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=egosjMlGlkadXOkgB1h4WlCwWAucMXZNqV/3WX9ti+N9PCuyer4YRlqvF61AiGKcZ
 bS5rPjOrxftr+UNmi+5M/f/ETvrRJRr8p4buyRuvSyjz978AnWNiR2T+fZqIwlsk0W
 4gHvG70uf/rRir7t6fUJy9k1wTtMzA7oQf51vWkg=
Authentication-Results: mail-nwsmtp-smtp-production-main-63;
 dkim=pass header.i=@yandex.com
From: Alex <xnderv@yandex.com>
To: Lyude Paul <lyude@redhat.com>,
	Danilo Krummrich <dakr@kernel.org>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, xnderv@yandex.com
Subject: Re: [PATCH] drm/nouveau/therm: mask the update bit when reading back
 the fan PWM duty
Date: Sun, 25 Oct 2026 13:24:13 +0300
Message-ID: <20261025102413.51786-1-xnderv@yandex.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261025101640.49779-1-xnderv@yandex.com>
References: <20261025101640.49779-1-xnderv@yandex.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 26 Oct 2026 08:36:44 +0000
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
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

I forgot to add my sign-off to this patch, sorry about that:

Signed-off-by: Alex <xnderv@yandex.com>
