Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58342CD98F2
	for <dri-devel@archiver.kernel.org>; Sun, 21 Jun 2026 15:30:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 63A7010E1DD;
	Sun, 21 Jun 2026 15:29:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="h9vcKzhd";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 17DF210E1DD;
 Sun, 21 Jun 2026 15:29:58 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9408F40506;
 Sun, 21 Jun 2026 15:29:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C50691F00A3A;
 Sun, 21 Jun 2026 15:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782055797;
 bh=0OA99dPOafjtnvEev4FM9wP6RjHQtmTJvuMsHZRF3Tc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=h9vcKzhd5h5xXKTIN+rscZ2S/TT1DLe9qqGZDIVz+LNj4GcDBWS+uB1uvuzp5EVax
 KbDxcE+Q/7CQx6PQDsid65nnnDwZG/v6JPAHXNV7PnCN9WNa1a2/NZMKjo4mUDlmpE
 dAeiCKqin8Ks/pXteOC+eHuvUVoywvLmx0QwwIdPI/4QofP3GaSKlP1ONULSeiWT+G
 cHjgyq4DKLrbDQj8G3uWqf3NTDme4gH+ypTot1jiCgX8ZMNkfQnKfa0SoEA1t/Qvoz
 X7F/ZZF/+fP7Zts0Khmys+/tRuCuE3Sgq+bGhPYRnb1jVHbrt8MHHnemCpNi4hccbW
 n3NAnCeV+NBAA==
From: Danilo Krummrich <dakr@kernel.org>
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: dri-devel@lists.freedesktop.org, kernel-dev@igalia.com,
 Philipp Stanner <phasta@kernel.org>, Lyude Paul <lyude@redhat.com>,
 Danilo Krummrich <dakr@kernel.org>, nouveau@lists.freedesktop.org
Subject: Re: [PATCH v3] drm/nouveau: Simplify nouveau_cli_work
Date: Sun, 21 Jun 2026 17:29:48 +0200
Message-ID: <20260621152948.27237-1-dakr@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260615092607.80917-1-tvrtko.ursulin@igalia.com>
References: <20260615092607.80917-1-tvrtko.ursulin@igalia.com>
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

On Mon, 15 Jun 2026 10:26:07 +0100, Tvrtko Ursulin wrote:
> [PATCH v3] drm/nouveau: Simplify nouveau_cli_work

Applied, thanks!

  Branch: drm-misc-next
  Tree:   https://gitlab.freedesktop.org/drm/misc/kernel.git

[1/1] drm/nouveau: Simplify nouveau_cli_work
      commit: a80d12eafad1

The patch will appear in the next linux-next integration (typically within 24
hours on weekdays).

The patch is queued up for the upcoming merge window for the next major kernel
release.
