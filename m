Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A00DDC531D0
	for <dri-devel@archiver.kernel.org>; Fri, 24 Jul 2026 03:00:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0EE4310F27E;
	Fri, 24 Jul 2026 03:00:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=w_armin@gmx.de header.b="W2Thpkhq";
	dkim-atps=neutral
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ADF8410F27E;
 Fri, 24 Jul 2026 03:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1784862013; x=1785466813; i=w_armin@gmx.de;
 bh=1mJEEvm4FbiJHeJ6b+OnPJ/M4l9XDDZkezBn7mj51to=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
 References:MIME-Version:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=W2ThpkhqtxThz+XzTFv6CUQcVsaJnFtcSiY10W1pWLsrgS2bnErX5HQ05j+qAS8j
 Oa7dPQTPT95gaq8R8d4j5n8qABOjc9sfiqVg3KVQFOgAZ+lLpFFpski6SFScVvs77
 5xnu73LZhANysPADEFy7jnMyDkYbOgohgWsAAWiopLiy8WfQ+9UX8F2lMvtev9tKc
 Cy7uRwMlgtzcFjNGin1xwcrfeYkrx6EhyMvUp3B7qA4ss2rcqcBsSLgZtBueDmboP
 asxstc6KV/MhBmxam0ENPqK0lFzSDvOxjYV8iSTqRwKMJelGQGvQsAti9Y9J+i+sa
 PKLIEiVpVSv5SQ5oXw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MPXhA-1wZGW645QI-00RbLf; Fri, 24
 Jul 2026 05:00:13 +0200
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
Subject: [PATCH v3 1/3] platform/wmi: Remove dependency on CONFIG_X86
Date: Fri, 24 Jul 2026 04:59:57 +0200
Message-Id: <20260724025959.142826-2-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260724025959.142826-1-W_Armin@gmx.de>
References: <20260724025959.142826-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Z3MbxzPPYKQicaaumWy6P+M7JgBRPhBcbTCUf3GNzrYX7mY1aom
 hw+dk0kxUxRiHu+I+WgYGrn9PYkYHR8wOh6DiuddkRLgmcSfKfT5IazyWaQNW23ROsklUVU
 5q0J9ytlcv3V9PzcgQ1Ih0Dm31ItduBz5Kx6hYitY+Tlk9CNd0kbZXtymhX9zwuWMB2P+L/
 z28TS7VeDHeyYgeFxG/7A==
UI-OutboundReport: notjunk:1;M01:P0:HSY8VWzZRVA=;XjVMKAg8CMp+03cJIcxnFTCXPPc
 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
 vYNdasHA8=
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

