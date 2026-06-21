Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CC6ACD98F0
	for <dri-devel@archiver.kernel.org>; Sun, 21 Jun 2026 13:35:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BAA5110E39B;
	Sun, 21 Jun 2026 13:35:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Bu2rVS70";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C549310E39B;
 Sun, 21 Jun 2026 13:35:46 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 09F1F60051;
 Sun, 21 Jun 2026 13:35:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1BA21F000E9;
 Sun, 21 Jun 2026 13:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782048945;
 bh=a4xYOjXUmeXKiNZBk3/FakjN1MIv8fVkL9//J3Rm4VQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Bu2rVS70AE7q0539unYUHl8ifOUfopApEuWITF2YFKX/a5/N4RVtP8oWqL7eYPmYw
 TqdGOGPfZBNulrQ1ib7GFqcsrsGUWsbG75npEstvkHMakn511zcy6TD011HDsw3vJb
 dDs+wdBeBv9OEjTeb467IMmtMraySDY/xJde7APVgFS/u9D9wL//WJ3vD5Pke1nI6o
 B6ppi5lZQZpDdKiJE2gnU/114gmX+wIgh4nzbjFKtvX3FeSAkSOvFo5V7kDPeOsStv
 rivSYD3yw0MfpUq0aMV3Ma7guyFGC5owFXfgsSQv1o0Wp/QhDXiEGTq0uzTB4Ufpil
 +8R8q8AQVt8Gg==
From: Danilo Krummrich <dakr@kernel.org>
To: Junrui Luo <moonafterrain@outlook.com>
Cc: Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Dave Airlie <airlied@redhat.com>,
 dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Yuhao Jiang <danisjiang@gmail.com>,
 stable@vger.kernel.org
Subject: Re: [PATCH] drm/nouveau: fix reversed error cleanup order in ucopy
 functions
Date: Sun, 21 Jun 2026 15:35:35 +0200
Message-ID: <20260621133535.5892-1-dakr@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <SYBPR01MB7881484D91A6F80271415F71AF1A2@SYBPR01MB7881.ausprd01.prod.outlook.com>
References: <SYBPR01MB7881484D91A6F80271415F71AF1A2@SYBPR01MB7881.ausprd01.prod.outlook.com>
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

On Wed, 10 Jun 2026 18:01:28 +0800, Junrui Luo wrote:
> [PATCH] drm/nouveau: fix reversed error cleanup order in ucopy functions

Applied, thanks!

  Branch: drm-misc-fixes
  Tree:   https://gitlab.freedesktop.org/drm/misc/kernel.git

[1/1] drm/nouveau: fix reversed error cleanup order in ucopy functions
      commit: ab99ead646b1

The patch will appear in the next linux-next integration (typically within 24
hours on weekdays).

The patch is queued up for Linus's tree and should land in the next -rc release.
