Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 698FDCDB46B
	for <dri-devel@archiver.kernel.org>; Sun, 21 Jun 2026 13:49:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 99F0588A72;
	Sun, 21 Jun 2026 13:49:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="EdTUaj1c";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 497C888A72;
 Sun, 21 Jun 2026 13:49:36 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 81CB06008A;
 Sun, 21 Jun 2026 13:49:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 296191F000E9;
 Sun, 21 Jun 2026 13:49:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782049775;
 bh=jJY+uYtV9LlMGtbVVSrE/Xo4Zvi84Yvvd73ebE/AiUA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=EdTUaj1cOIwUaHKPso86x6R8FqGvVS09EquQqmrsryCKXUSBW5gyD+L6ptsFmWPK0
 pV7AWZdjcQ3hIEZQcvXkjHAXqbOcf+KL6cFCjPRMHS+fgY/COry4xqaCI9nEavSRUN
 QgPv8isaziL3PvyH+GPUxG9YlKF20dd8SaX/0iOOZ5IZ2D6D1WxBr8QEf3P/yzrW4e
 OPrTM2u4rVnm6lwDSgu+YTNkmcQ9FdyWaU4qNFkLXn+kHkCvH7lrOcK4YZyT4vSqMl
 /5RLw0v5FMFyRk71w36QTNB/f8cR5fIJYcQaZR0EyZYw1ttWGX+Mu2xyAqzDgjTfGy
 vkMvsMEMc2xog==
From: Danilo Krummrich <dakr@kernel.org>
To: Dave Airlie <airlied@gmail.com>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
 dakr@kernel.org
Subject: Re: [PATCH] nouveau/gem: reserve the bo in the info ioctl around the
 vma lookup
Date: Sun, 21 Jun 2026 15:49:26 +0200
Message-ID: <20260621134926.10271-1-dakr@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260612020658.3176270-1-airlied@gmail.com>
References: <20260612020658.3176270-1-airlied@gmail.com>
X-Patch-Reply: applied
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

On Fri, 12 Jun 2026 12:06:58 +1000, Dave Airlie wrote:
> [PATCH] nouveau/gem: reserve the bo in the info ioctl around the vma lookup

Applied, thanks!

  Branch: drm-misc-next
  Tree:   https://gitlab.freedesktop.org/drm/misc/kernel.git

[1/1] nouveau/gem: reserve the bo in the info ioctl around the vma lookup
      commit: 5e17160d41d9

The patch will appear in the next linux-next integration (typically within 24
hours on weekdays).

The patch is queued up for the upcoming merge window for the next major kernel
release.
