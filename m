Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F0DEC79FB9
	for <dri-devel@archiver.kernel.org>; Thu, 10 Sep 2026 13:36:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 80C0E10EB79;
	Thu, 10 Sep 2026 13:36:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="J1gbMyQI";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 20B4510EDE0
 for <dri-devel@lists.freedesktop.org>; Thu, 10 Sep 2026 13:36:32 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 252D66020C;
 Thu, 10 Sep 2026 13:36:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F0511F00893;
 Thu, 10 Sep 2026 13:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789047390;
 bh=1FasGscCL7I3HUlFNc/jhfPhcO3uqS8otOMSF6iJ0cQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=J1gbMyQIqy7WHnPONiqJhdXWzakR8VWh10XD2TY3C6aINKudQJvsIuN9dBYq8ikoI
 OOX3OFnOoriZXyD+imhQ5t3+SNrgz5SwXRgyJuRzDLyDHk4WhK1yfDIVpWH+X8Vgrb
 2xcTH7wn5hUMJ9T7Let1scnyI/FOFMEj6qxXYU/A5aTKUHIJfVGRCF6BphFEboAadN
 Rp9bCg5TOthzErUosaj/drsSKj2zalqlBRz7pvb/GC0pz2l6SkjACKrHS9nSJ69o9v
 3BKceOeRU/f5pEdJxY8reA2ZHVqsrmkqO0nkmnCRWrbAwSF97JXPmVzgq3t5Imr+7r
 Rq0aGAiDVr0dQ==
From: Danilo Krummrich <dakr@kernel.org>
To: Edwin Peer <epeer@nvidia.com>
Cc: dakr@kernel.org, aliceryhl@google.com, phasta@kernel.org,
 sumit.semwal@linaro.org, christian.koenig@amd.com, jhubbard@nvidia.com,
 rust-for-linux@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH drm-rust-next] rust: dma_fence: gate abstractions on
 CONFIG_DMA_SHARED_BUFFER
Date: Thu, 10 Sep 2026 15:36:23 +0200
Message-ID: <20260910133623.344658-1-dakr@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260909202327.33285-1-epeer@nvidia.com>
References: <20260909202327.33285-1-epeer@nvidia.com>
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

On Wed,  9 Sep 2026 13:23:27 -0700, Edwin Peer wrote:
> [PATCH drm-rust-next] rust: dma_fence: gate abstractions on CONFIG_DMA_SHARED_BUFFER

Applied, thanks!

  Branch: drm-rust-next
  Tree:   https://gitlab.freedesktop.org/drm/rust/kernel.git

[1/1] rust: dma_fence: gate abstractions on CONFIG_DMA_SHARED_BUFFER
      commit: 73e5616f3d19

The patch will appear in the next linux-next integration (typically within 24
hours on weekdays).

The patch is queued up for the upcoming merge window for the next major kernel
release.
