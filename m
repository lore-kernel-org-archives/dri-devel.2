Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 634F5CD37AC
	for <dri-devel@archiver.kernel.org>; Thu, 14 May 2026 00:24:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 71A4410E031;
	Thu, 14 May 2026 00:24:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="D9vSb8xJ";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 083F710E031;
 Thu, 14 May 2026 00:24:11 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 425BB60052;
 Thu, 14 May 2026 00:24:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF790C19425;
 Thu, 14 May 2026 00:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778718250;
 bh=NqTvVIlot6Nb0r8ZPjLmjRZqNKYxl16s8XgEe0ozoIk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=D9vSb8xJYf/Q/rPGAK1bR24UGmaQuaeMybhf4c50GuGLwAjx1Bdwwhn6BaNYxtyKR
 eDTgB6YidzWwVdFy9rEPztW3/lhOWERBvdt0k6iDUtW9nDr/SNuVLLBURBGEkepKnZ
 tEdGdi0vKyS+eHBom5htZm6wyeALz5mH5SLn3+kg08iRN4DcpfgaswEnbl6zFsSCl8
 51FJF5pnPw0bOPUHBlZcZSXYTmSI0XJsHXkHEbSXv9vHi+C81NcmZCsekvko1/Rb2s
 ec8YT4QahQHzV4VBH244ZwmeaRZEVcy6l9qEigbb/CG9WsHwb7eoN1/qIfozLQzCM6
 V4fu7qaetErUg==
From: Danilo Krummrich <dakr@kernel.org>
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 Danilo Krummrich <dakr@kernel.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Brendan Higgins <brendan.higgins@linux.dev>,
 David Gow <david@davidgow.net>, Rae Moar <raemoar63@gmail.com>,
 Andy Shevchenko <andy@kernel.org>,
 Maximilian Luz <luzmaximilian@gmail.com>, Hans de Goede <hansg@kernel.org>,
 =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Matthew Brost <matthew.brost@intel.com>,
 =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, brgl@kernel.org,
 driver-core@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
 platform-driver-x86@vger.kernel.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Subject: Re: (subset) [PATCH v6 0/6] driver core: remove software node from
 platform devices on device release
Date: Thu, 14 May 2026 02:24:00 +0200
Message-ID: <20260514002400.869648-1-dakr@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260513-swnode-remove-on-dev-unreg-v6-0-f9c58939df27@oss.qualcomm.com>
References: <20260513-swnode-remove-on-dev-unreg-v6-0-f9c58939df27@oss.qualcomm.com>
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

On Wed, 13 May 2026 17:04:47 +0200, Bartosz Golaszewski wrote:
> [PATCH v6 0/6] driver core: remove software node from platform devices on device release

Applied, thanks!

  Branch: driver-core-linus
  Tree:   git://git.kernel.org/pub/scm/linux/kernel/git/driver-core/driver-core.git

[1/6] driver core: platform: remove software node on release()
      commit: 50030d63b4d3

The patch will appear in the next linux-next integration (typically within 24
hours on weekdays).

The patch is queued up for Linus's tree and should land in the next -rc release.
