Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F209CA5FA7
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 19:12:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A0B2C10F05D;
	Tue, 29 Sep 2026 19:12:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Bm3E8JKY";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 348EC10F075
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 19:12:49 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 025DB40847;
 Tue, 29 Sep 2026 19:12:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59D501F000FF;
 Tue, 29 Sep 2026 19:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790709168;
 bh=D9cu68nbOlK5TZxLRlMSm5RYXYKueBBru+xFJ2T1S88=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Bm3E8JKYuYccahbjIrtY94dbQo+10kdBk0rOO/CFcey2w09VHVVbEK5ejTZRxDf5f
 XEvTJclrUqTFnXbYmXwhPyHIsBco1+ClaaOk0sEKbBCsi7TZdwn3roFeKhqg4TkgoJ
 kgiTyDnep/qMIxky0bSWMQ1Oc8270cSwun+hCAk/81IApB8bya5JOmQAntIYdHfaCj
 Pr52UUqZcXdubwQ0JVMAQaLZlZbDnuBm8xtSRIew+7RxQ31doyLSDIbjqToTu1Y0IG
 JEvxZQuriQvstGPCpAGoZGOPeyhobYmpw6fkVbK4za7uWqjQXKo7WkuCgnprusLXaY
 +GxXw6HJewbPg==
From: Danilo Krummrich <dakr@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: acourbot@nvidia.com, aliceryhl@google.com, gary@garyguo.net,
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] gpu: nova-core: use a single try_pin_init!() block in
 probe()
Date: Tue, 29 Sep 2026 21:12:45 +0200
Message-ID: <20260929191245.2259598-1-dakr@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260927144417.1280385-1-dakr@kernel.org>
References: <20260927144417.1280385-1-dakr@kernel.org>
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

On Sun, 27 Sep 2026 16:44:03 +0200, Danilo Krummrich wrote:
> [PATCH] gpu: nova-core: use a single try_pin_init!() block in probe()

Applied, thanks!

  Branch: drm-rust-next
  Tree:   https://gitlab.freedesktop.org/drm/rust/kernel.git

[1/1] gpu: nova-core: use a single try_pin_init!() block in probe()
      commit: 658c5f0042e6

      [ Drop useless dev_dbg!() in probe(). - Danilo ]

The patch will appear in the next linux-next integration (typically within 24
hours on weekdays).

The patch is queued up for the upcoming merge window for the next major kernel
release.
