Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FF26C531F9
	for <dri-devel@archiver.kernel.org>; Fri, 24 Jul 2026 02:25:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 50E2B10E62F;
	Fri, 24 Jul 2026 02:25:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=w_armin@gmx.de header.b="DusLLOf9";
	dkim-atps=neutral
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CFCC410E62F;
 Fri, 24 Jul 2026 02:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1784859953; x=1785464753; i=w_armin@gmx.de;
 bh=1mJEEvm4FbiJHeJ6b+OnPJ/M4l9XDDZkezBn7mj51to=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
 References:MIME-Version:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=DusLLOf9K2rAvt/qeROYwQCVwKP94XQy6iUudrPTJ+wVX9E1xO6Vcoe+/IQKMzlj
 nVFAajpmycU5pPOuUtvm1rd67KRF0z6CjWrJ+Aqzf6RZekTtjYvqQbcvm60+3jXqN
 Fgn++rdHUkgG5N8VuhgLk1ons3KVlq/gMWpEr/xk6KacfGH3BjZf2n4YgPNVS4mFN
 m9BcWJxn4avdybKdqTknR/YdjCgnvXKjnVfYuol/zWEYt9Ld7Yc+DCSiU3q+ZdSa5
 O59KkM3qgXWfuVj3BP4f9nriFfM8QQJ5FwO8ox7MGt52L151Pi6uo5/UrbFoevQ4b
 NVJygm9rRd6AONcnAA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M42jQ-1wn5bk3Z2G-003Kl7; Fri, 24
 Jul 2026 04:25:52 +0200
From: Armin Wolf <W_Armin@gmx.de>
To: hansg@kernel.org,
	ilpo.jarvinen@linux.intel.com
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux@weissschuh.net, rafael@kernel.org, lenb@kernel.org,
 linux-acpi@vger.kernel.org, alexander.deucher@amd.com,
 christian.koenig@amd.com, airlied@gmail.com, simona@ffwll.ch,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 patrik.r.jakobsson@gmail.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, jani.nikula@linux.intel.com,
 joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com,
 tursulin@ursulin.net, intel-gfx@lists.freedesktop.org,
 matthew.brost@intel.com, thomas.hellstrom@linux.intel.com,
 intel-xe@lists.freedesktop.org
Subject: [PATCH v2 1/3] platform/wmi: Remove dependency on CONFIG_X86
Date: Fri, 24 Jul 2026 04:25:24 +0200
Message-Id: <20260724022526.139370-2-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260724022526.139370-1-W_Armin@gmx.de>
References: <20260724022526.139370-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:CgCmZPyCuD2qT4pvEFdV7Fsj6O0PWstypQimAc+UY5sfxdGtyjy
 iyUEZDc9wbsg+521FjneUH5gr36U4FdTkxYlKBWJDlTu8d3ZdD2D/+fETrjkXoy3YWfVj9R
 +xdR/x63DacSfxjr9qWzlhz6QpnQ8OxLouYZUdfp7UJb1AxMzCoZqTjMzKzb937w5h/i48j
 qBlBcMPzxoUOtaufeqtmQ==
UI-OutboundReport: notjunk:1;M01:P0:Frwjl7mWmPU=;8dSL3+sTGeXEoY+PeKQjw9p6gJP
 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
 pYsPwTAfgHACUUxqZSjtcgsuCRV9lY
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

The aarch64-laptops project found out that some Windows-on-Arm
notebooks contain WMI-ACPI mapping devices (PNP0C14) that work
exactly like on x86. Remove the dependency on CONFIG_X86 to
make it possible to build the ACPI-WMI driver on arm64.

Link: https://lists.linaro.org/archives/list/aarch64-laptops@lists.linaro.=
org/thread/U2IZENSIOOHZHGXVN7GM5HX5O3FD5KCF/
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/platform/wmi/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/wmi/Kconfig b/drivers/platform/wmi/Kconfig
index d62f51ff3b7f..36934b5f0194 100644
=2D-- a/drivers/platform/wmi/Kconfig
+++ b/drivers/platform/wmi/Kconfig
@@ -5,7 +5,7 @@
=20
 menuconfig ACPI_WMI
 	tristate "ACPI-WMI support"
-	depends on ACPI && X86
+	depends on ACPI
 	select NLS
 	help
 	  This option enables support for the ACPI-WMI driver core.
=2D-=20
2.39.5

