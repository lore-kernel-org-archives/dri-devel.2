Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E757B606A31E
	for <dri-devel@archiver.kernel.org>; Fri, 23 Oct 2026 18:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=yandex.com header.i=@yandex.com header.a=rsa-sha256 header.s=mail header.b=xggIpMTA
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3BA8910E4F1;
	Fri, 23 Oct 2026 18:17:03 +0000 (UTC)
X-Greylist: delayed 2460 seconds by postgrey-1.36 at gabe;
 Fri, 23 Oct 2026 15:24:25 UTC
Received: from forward105d.mail.yandex.net (forward105d.mail.yandex.net
 [51.250.60.165])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5EC3910E63D;
 Fri, 23 Oct 2026 15:24:25 +0000 (UTC)
Received: from mail-nwsmtp-smtp-production-main-12.yp-c.yandex.net
 (mail-nwsmtp-smtp-production-main-12.yp-c.yandex.net)
 by forward105d.mail.yandex.net (postfix) with ESMTPS id 0BAF1100072;
 Fri, 23 Oct 2026 18:24:23 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-12 with ESMTPSA id
 GOf0WQDdMGk0-GJ7eC45D; Fri, 23 Oct 2026 18:24:22 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.com; s=mail;
 t=1792769062; bh=npNmIRcmiTbe8TUN5oF9hqxjSAu4kad9SSf+fBhKItc=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=xggIpMTA+9QrK39kLs7DqFcL5iYULlATGWKi98PgdVpdYgPrmPLPir8A8G6pkJ8Un
 5M/QmsPEK0gy1ppY3dmt40uWJA8BlZTgkWbA0Sa8nCK5G2S6fL6q6HIeEkXpSSlrcS
 KJAU7XSU4cbsIPqsgLcHZfBty9I5cDoaeqY96kr0=
Authentication-Results: mail-nwsmtp-smtp-production-main-12;
 dkim=pass header.i=@yandex.com
From: Alex <xnderv@yandex.com>
To: Lyude Paul <lyude@redhat.com>,
	Danilo Krummrich <dakr@kernel.org>
Cc: Karol Herbst <kherbst@redhat.com>, nouveau@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 xnderv@yandex.com
Subject: Re: [PATCH] drm/nouveau: idle the channel before destroying an engine
 object via abi16
Date: Fri, 23 Oct 2026 18:23:31 +0300
Message-ID: <20261023152332.9420-1-xnderv@yandex.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261023144219.46478-1-xnderv@yandex.com>
References: <20261023144219.46478-1-xnderv@yandex.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 23 Oct 2026 18:17:02 +0000
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

On the Sashiko AI review of this patch:

> Can calling nouveau_channel_idle(obj->chan->chan) here race with jobs
> running on obj->chan->sched when VM_BIND is enabled?

Thanks, the race is real.

Legacy PUSHBUF submissions take cli->mutex (nouveau_abi16_get()), so they
are serialized with nouveau_abi16_ioctl_del(), which is why the Chromium
case was fixed by the plain nouveau_channel_idle().  With VM_BIND the
EXEC jobs are pushed from the scheduler workqueue without cli->mutex, so
emitting a fence from the ioctl could indeed race with
nouveau_exec_job_run(), and jobs still queued in the entity would not be
covered by the fence at all.

v2 (sent as a reply to this thread) waits for the channel's scheduler to
drain first -- the same job-list wait nouveau_sched_fini() already does,
factored out as nouveau_sched_wait_idle() -- and then idles the channel.
New EXEC submissions cannot sneak in meanwhile because the EXEC ioctl
also holds cli->mutex.

Alex
