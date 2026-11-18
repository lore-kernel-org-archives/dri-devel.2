Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80192606A320
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 07:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.com header.i=@yandex.com header.a=rsa-sha256 header.s=mail header.b=IoPwM4/+
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5457210FDB5;
	Thu, 19 Nov 2026 07:49:14 +0000 (UTC)
Received: from forward105d.mail.yandex.net (forward105d.mail.yandex.net
 [51.250.60.165])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 51AD610FE84;
 Wed, 18 Nov 2026 16:53:58 +0000 (UTC)
Received: from mail-nwsmtp-smtp-production-main-66
 (mail-nwsmtp-smtp-production-main-66.yp-c.yandex.net)
 by forward105d.mail.yandex.net (postfix) with ESMTPS id 37EBB100036;
 Wed, 18 Nov 2026 19:53:55 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-66 with ESMTPSA id
 YrdcVw0j54Y0-vlfv0vrV; Wed, 18 Nov 2026 19:53:54 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.com; s=mail;
 t=1795020834; bh=EOJ8Sv/YlC8vz0y+8TQ4TF7t2l9IIfJq2FXNg6WSXn8=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=IoPwM4/+G6iuBYnsqs6wPD1Mec6CqC38mgXduK3ckxC8/7q2aZJEurdTHiHuxi43S
 PpK2fLEqUxSU7yojJa8TJAlERPg8rM5Zt0ywQL9DBGpyB91anpM61xuQURfBl7gi0E
 bqJV+oqtUGAb4P1MSObTvsB9m3TPvvSRqJVfvJiM=
Authentication-Results: mail-nwsmtp-smtp-production-main-66;
 dkim=pass header.i=@yandex.com
From: Alex <xnderv@yandex.com>
To: Lyude Paul <lyude@redhat.com>,
	Danilo Krummrich <dakr@kernel.org>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, xnderv@yandex.com
Subject: Re: [PATCH v2] drm/nouveau: idle the channel before destroying an
 engine object via abi16
Date: Wed, 18 Nov 2026 19:53:28 +0300
Message-ID: <20261118165328.53341-1-xnderv@yandex.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261023152332.9420-2-xnderv@yandex.com>
References: <20261023152332.9420-2-xnderv@yandex.com>
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

Gentle ping on this one. v2 addresses the review comment on v1 (wait for
the scheduler job queue to drain before idling the channel). It still
applies cleanly to current mainline (checked today, 2026-11-18).

Is there anything else you would like me to change?

Thanks,
Alex
