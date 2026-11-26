Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 576DF606A31E
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 22:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=icoJSpSB
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE3B510E20C;
	Thu, 26 Nov 2026 22:41:09 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A440F10E20C
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 22:41:03 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5BDFD42CB9;
 Thu, 26 Nov 2026 22:41:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC4871F00896;
 Thu, 26 Nov 2026 22:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795732863;
 bh=TNtqi5O4nLzvfHhnFH9DEQT5sHkW4Kx4CS3oVdX8k7k=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=icoJSpSByMLM/bYlvB+6OF7hYB6Pl63TD1Id7GaGvLBgzm168zP4Q/mvICPEr1Nzw
 nTKz5j4j+pH+tZTclOqk/8F4yfbg0MbcxII+B4rReuquOZ/Atw5mYfhSzzJK2+hVn5
 EI5Diqbhnvwt+LawUVp1t3Dzu+XO+Us93KwJNIK22z2jq6K+p56pBPMh3z7MBRgB/r
 qed8tIlatoH6BfgGwG5QMN81EmgyBuNnHkcnk79miRJEwAPJLNChzFAiuQXdYcNwNz
 5kvVYHl/0/x4abA1Xf2056UegGzu9sBNOHLi9TzS8K5aYCFWOhraU+cg0adEchA5CA
 UcdAa2aPZJeyw==
From: Danilo Krummrich <dakr@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: acourbot@nvidia.com, nova-gpu@lists.linux.dev,
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] gpu: nova-core: use Init for firmware initialization
Date: Thu, 26 Nov 2026 23:40:59 +0100
Message-ID: <20261126224059.3856051-1-dakr@kernel.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261122171353.963020-1-dakr@kernel.org>
References: <20261122171353.963020-1-dakr@kernel.org>
X-Patch-Reply: applied
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sun, 22 Nov 2026 18:13:50 +0100, Danilo Krummrich wrote:
> [PATCH v2] gpu: nova-core: use Init for firmware initialization

Applied, thanks!

  Branch: driver-core-next
  Tree:   git://git.kernel.org/pub/scm/linux/kernel/git/driver-core/driver-core.git

[1/1] gpu: nova-core: use Init for firmware initialization
      commit: a3c13b902f14

The patch will appear in the next linux-next integration (typically within 24
hours on weekdays).

The patch is queued up for the upcoming merge window for the next major kernel
release.
