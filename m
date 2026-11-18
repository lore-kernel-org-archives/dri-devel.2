Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3275606A320
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 07:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=yandex.com header.i=@yandex.com header.a=rsa-sha256 header.s=mail header.b=BadVSQLR
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 121E810FD3B;
	Thu, 19 Nov 2026 07:49:00 +0000 (UTC)
Received: from forward102d.mail.yandex.net (forward102d.mail.yandex.net
 [51.250.60.162])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 499BF10FEA7;
 Wed, 18 Nov 2026 16:54:14 +0000 (UTC)
Received: from mail-nwsmtp-smtp-production-main-94
 (mail-nwsmtp-smtp-production-main-94.yp-c.yandex.net)
 by forward102d.mail.yandex.net (postfix) with ESMTPS id C9819C00C6;
 Wed, 18 Nov 2026 19:54:11 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-94 with ESMTPSA id
 6sdtri0d1Ko0-vPZdlYXj; Wed, 18 Nov 2026 19:54:11 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.com; s=mail;
 t=1795020851; bh=yD1/OR6ajdIF7WPOaJ7OQK9lcxiyH/vK4kcEYe1fozU=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=BadVSQLR+kBn5498Kt1JFpF1P9/hCWn312ACxj1yA1JxmYjRVTBPBOe9cuZqQAuHy
 yHX048ViUFKo72m+HcxA+EUoyExYlmEyhScZc0Naj5D0ZQEy85Ty85BpJEI/yWIv0s
 oVrViHJ0AEgbHEpoEbQ5FpENkKkaLvc/6KAAeiBI=
Authentication-Results: mail-nwsmtp-smtp-production-main-94;
 dkim=pass header.i=@yandex.com
From: Alex <xnderv@yandex.com>
To: Lyude Paul <lyude@redhat.com>,
	Danilo Krummrich <dakr@kernel.org>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Martin Roukala <martin.roukala@mupuf.org>,
 stable@vger.kernel.org, xnderv@yandex.com
Subject: Re: [PATCH v2] drm/nouveau/therm: mask the update bit when reading
 back the fan PWM duty
Date: Wed, 18 Nov 2026 19:54:02 +0300
Message-ID: <20261118165402.53610-1-xnderv@yandex.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261029130012.21738-1-xnderv@yandex.com>
References: <20261029130012.21738-1-xnderv@yandex.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 19 Nov 2026 07:48:39 +0000
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
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

Gentle ping on this one. v2 trims the commit message as Martin asked
and carries his Acked-by. It still applies cleanly to current mainline
(checked today, 2026-11-18).

Thanks,
Alex
