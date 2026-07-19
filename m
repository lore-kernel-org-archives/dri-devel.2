Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EA56C4451B
	for <dri-devel@archiver.kernel.org>; Sun, 19 Jul 2026 23:08:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 68B4F10E0C0;
	Sun, 19 Jul 2026 23:08:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="UZxmllpa";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E359410E05B;
 Sun, 19 Jul 2026 23:08:18 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id EFB2A60A77;
 Sun, 19 Jul 2026 23:08:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C77DA1F00A3D;
 Sun, 19 Jul 2026 23:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784502497;
 bh=K7NbXJhwT8cHjJAvRs9KohMqKpOUiXmG9r+4uV2sG9A=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=UZxmllpaRjoY7Ip+XRv0P2qsFYSXZPZXKdMT158b3st9dlVPCOhGXNQBOCKBp8NjX
 6Qe9MfkJZq+Vp35lcdaiDb9PqTPFsah4/j5FCQ9puy4z13V/kkDdI6dFF8iB371rFt
 dyNtM++LopNSjUfx21NNF7oTjFAtn/TRWULO2L1mmOnDqcL2RYoG217PqIYzB2BOlW
 K15JDBvkq0r3adaQgN2oTslZTIh5ifXvHWNB1gbKSWXC8U4eE3+7Ev6I0v4SLERIfw
 AGjNXQ2rCITFMgrmJQHTo8yrz1AgKNw/svwbanWzJY/zh57snvoZpjFlfk5bh7ONUY
 90iobzmeZEwCw==
From: Danilo Krummrich <dakr@kernel.org>
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Maximilian Luz <luzmaximilian@gmail.com>, Hans de Goede <hansg@kernel.org>,
 =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Matthew Brost <matthew.brost@intel.com>,
 =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 Danilo Krummrich <dakr@kernel.org>, brgl@kernel.org,
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
 intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 driver-core@lists.linux.dev,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH v8 0/5] driver core: unify the release path for
 dynamically allocated platform devices
Date: Mon, 20 Jul 2026 01:08:11 +0200
Message-ID: <20260719230811.812546-1-dakr@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260716-swnode-remove-on-dev-unreg-v8-0-5c2b8cc38c28@oss.qualcomm.com>
References: <20260716-swnode-remove-on-dev-unreg-v8-0-5c2b8cc38c28@oss.qualcomm.com>
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

On Thu, 16 Jul 2026 14:31:35 +0200, Bartosz Golaszewski wrote:
> [PATCH v8 0/5] driver core: unify the release path for dynamically allocated platform devices

Applied, thanks!

  Branch: driver-core-testing
  Tree:   git://git.kernel.org/pub/scm/linux/kernel/git/driver-core/driver-core.git

[1/5] driver core: platform: amend the API contract for fwnode setters
      commit: e6054f410c97
[2/5] platform/surface: gpe: use platform_device_register_full()
      commit: 1e0bd438b876
[3/5] drm/xe/i2c: use device_create_managed_software_node()
      commit: 0f485f88656a
[4/5] driver core: platform: unify release path
      commit: 7d80509ff0da
[5/5] driver core: platform: tests: add test cases for correct swnode removal
      commit: 397f0a3958c9

The patches will appear in the next linux-next integration (typically within 24
hours on weekdays).

The patches are in the driver-core-testing branch and will be promoted to
driver-core-next after validation.
