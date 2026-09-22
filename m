Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA175C982FF
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 08:01:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 320E110E62D;
	Tue, 22 Sep 2026 08:01:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OtxVLcMH";
	dkim-atps=neutral
Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com
 [74.125.225.141])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 27F4A10E61F
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 08:01:30 +0000 (UTC)
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-49d0726cdbcso2017805e9.0
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 01:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790064088; x=1790668888; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VxEjmrMLU3ArphO/8yrozyx0jV5tnXGHISJN2k9QOtM=;
 b=OtxVLcMHUBRabotdT7U2Y/0hwlBA1KTUe5TzQ47vQ7dWsK/W8+wd54WAJNf25wxx8t
 TMv9ZoGkZfPZE/QQ4nV6QP0S4mBmJRy/4DvVQrVtc9NdHTNtbq1wvfrBxR5+qsMXhKZ7
 vSV4Cxf0F4N+9tqOPsKycRzJVmjH5DK23a32V755yWzQjDu8yk0Cw3plcS6JwZ4+z5kj
 dIBQvsNeoKnswwivOBnivqtlhsjFhqjbmPlMb13Q2PMlBjrIxDNtIX1NnTJDHGbgkHkt
 i0QfqqSPkIhyq9OxftOmZpGF7kMeKVmuJadYyDvD+lxqXJJyoi4Mvr5BcLkNtNDQOANq
 jUBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790064088; x=1790668888;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=VxEjmrMLU3ArphO/8yrozyx0jV5tnXGHISJN2k9QOtM=;
 b=VC4MebDiiIELA2wBLMqpEV6D2a/j5jq4Qs0vapFIAy7ALPrArosaX8Y0zR/gpJd77l
 0/5FhCBN9NZz25BhZimH223iXgn7x3AuanmN5lFSg/Mf0jS8n0Za4qbAr7TvNDVMyxUs
 ZoJvtkJz04gDU8xBtoHnqoBKaSV7rrMOIPK5b22A5+L4j+6Pq1nkKZ8Yx19SRRDiYtRh
 gHyXwG/YpZj2VzmXAkhKqJnpYUfJ2epOgEjQf51s256mXmuVkDCOBNff8CtEYORQfmkp
 j/RAM8eeZCRN7HuGoE9xzOdbBipCC8VL0t7Bp3UDO62q8msFrfzE4o7b2mUjv+89fbma
 8xog==
X-Forwarded-Encrypted: i=1;
 AKwUvBzLt3FIpCDqcbOZ3gHRkq6CcLZzHfPaR2WB/PVOAQfN7cOkkrtZC2ffkO9vH0xWuVbo4QRMZF0IDYI=@lists.freedesktop.org
X-Gm-Message-State: AFuF++m8hIK0a5PQqF1ci75XubvYgOadZjSywc9epQ+WoXEKivGMfWoM
 m7sjBD4UyIUjdH8seUt1NpNud61xJXdYsSRDBVF9K2q3SL6YC+++lpQE
X-Gm-Gg: AYBFou2+/FAsVWOEZiUEwm+y4YIdpjrl2YetGCew6a/4Pv84SOijlBj+leglpHxdZXF
 DhPMGsbYuQacM2n6QtIyCQzldVX2i03fLmCMs2fCS5Thiq+FErT6gzs2NqUZMS8g3aAwrtHRGwd
 Mnfpb+F+wne5z6BLN/lyBq7ZAFX+ngCISvFckaO9ffEI4fBaenq6mlA/8SFgcOhisGlyYxec56v
 6QvmQh3fyBrALneoUIgqh2L3BsvHX8YuMlE2tICN+crOjGi060wXLG0o/W2TrsT6LeYLTreCtbW
 2dVoBSSXpwzOZWocoRgwTPlxKesr5b2W4EM/45kdUsLkdkw7FC9bVbLRapyjiPlJFTyMiiHF3rG
 OjzT3p+NTrNqZ62Cos7QtV6oc8aXwXcnCNLx+hysS5lIW+nzcBJKTTVwMGWWANo4snf7zn3mZTG
 54C9PhxgIiDGg+A/KLjzw42k4goWCfVFIuMrDUXxnPP0xXDDFag8Hz2k1kn10DRcvj/INkcuOg+
 nKPSmxo2DeovyXz8pi/cX8aMFFoMeiCsc/sdo79Y4zlHu/Ty0ZZKXSGDYHwnH9UIfNepg/aBSMB
 AOw=
X-Received: by 2002:a05:600c:1c13:b0:49e:7186:f36e with SMTP id
 5b1f17b1804b1-49fc7dc1e75mr208969905e9.1.1790064088073; 
 Tue, 22 Sep 2026 01:01:28 -0700 (PDT)
Received: from OrangePi5-Plus.BB-HOME
 (20014C4E1B80530056971C6280202175.dsl.pool.telekom.hu.
 [2001:4c4e:1b80:5300:5697:1c62:8020:2175])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fdaaf97e2sm18248625e9.2.2026.09.22.01.01.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Sep 2026 01:01:26 -0700 (PDT)
From: Igor Paunovic <royalnet026@gmail.com>
To: Tomeu Vizoso <tomeu@tomeuvizoso.net>, Oded Gabbay <ogabbay@kernel.org>,
 Heiko Stuebner <heiko@sntech.de>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
 Robert Foss <rfoss@kernel.org>, Sidong Yang <sidong.yang@furiosa.ai>,
 Diederik de Haas <diederik@cknow-tech.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Jiaxing Hu <gahing@gahingwoo.com>, Nicolas Dufresne <nicolas@ndufresne.ca>,
 Jonas Karlman <jonas@kwiboo.se>, Guangshuo Li <lgs201920130244@gmail.com>,
 =?UTF-8?q?H=C3=BCseyin=20BIYIK?= <boogiepop@gmx.com>,
 dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Igor Paunovic <royalnet026@gmail.com>
Subject: [PATCH v2 02/11] accel/rocket: number the cores by devicetree
 position, not bind order
Date: Tue, 22 Sep 2026 10:01:05 +0200
Message-ID: <20260922080114.44662-3-royalnet026@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260922080114.44662-1-royalnet026@gmail.com>
References: <20260922080114.44662-1-royalnet026@gmail.com>
MIME-Version: 1.0
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

rocket_job_hw_submit() programs the S_POINTER registers of a core with an
extra bit derived from core->index, the way the vendor driver derives it
from the hardware number of the core. rocket_probe() sets core->index to
the slot the core takes in rdev->cores[], which is the order the cores
bind in.

The two agree only while the cores that bind are a prefix of the core
nodes in the devicetree, in devicetree order. Unbind them and bind them
back with a different core first, have one core's probe deferred behind a
sibling's, or disable a core other than the last one, and every task
submitted to a core whose slot is not its hardware number times out after
500 ms. The reset that follows does not help, and the inference finishes
with wrong output.

Observed on an Orange Pi 5 Plus with a KASAN build, over all six bind
orders of the three cores: only the devicetree order ran clean. The other
five produced 27 to 141 "NPU job timed out". In four of them no output
tensor changed with the input, and the harness gave up before its first
measured round; the fifth got through a six-second run with 27 timeouts
and a wrong top-1 class. All but one of the timeouts land on the cores
whose slot is not their hardware number, in proportion to the tasks the
scheduler hands them, and in both directions of the mismatch.

Number the cores by their position among the core nodes in the devicetree
instead, which is what the hardware number is.

The wrong value has been assigned since the driver was added, but it only
reached the hardware once the extra bit was introduced, hence the Fixes
tag below.

Fixes: 0810d5ad88a1 ("accel/rocket: Add job submission IOCTL")
Cc: stable@vger.kernel.org
Assisted-by: LLM sparse checkpatch
Signed-off-by: Igor Paunovic <royalnet026@gmail.com>
---
Supersedes the standalone posting:
https://lore.kernel.org/r/20260905135612.7324-1-royalnet026@gmail.com
Same diff. The message now says the numbers come from a KASAN build,
corrects the timeout range to 27-141 against the raw log (it said 140),
says what the four failed orders showed (the output did not change with
the input; it said an oracle rejected the output), notes the one timeout
that landed on a matching core, and drops the throughput figure, which
was measured under KASAN.

 drivers/accel/rocket/rocket_core.h |  5 +++++
 drivers/accel/rocket/rocket_drv.c  | 31 +++++++++++++++++++++++++++++-
 2 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/drivers/accel/rocket/rocket_core.h b/drivers/accel/rocket/rocket_core.h
index f6d7382854ca9..46ed8352a79d2 100644
--- a/drivers/accel/rocket/rocket_core.h
+++ b/drivers/accel/rocket/rocket_core.h
@@ -30,6 +30,11 @@
 struct rocket_core {
 	struct device *dev;
 	struct rocket_device *rdev;
+	/*
+	 * Hardware number of the core: its position among the core nodes in
+	 * the devicetree. Not an index into rdev->cores[] - that slot is what
+	 * find_core_for_dev() returns.
+	 */
 	unsigned int index;
 
 	int irq;
diff --git a/drivers/accel/rocket/rocket_drv.c b/drivers/accel/rocket/rocket_drv.c
index 2bcfe4ab3c68f..7d927bb6b322d 100644
--- a/drivers/accel/rocket/rocket_drv.c
+++ b/drivers/accel/rocket/rocket_drv.c
@@ -157,10 +157,39 @@ static const struct drm_driver rocket_drm_driver = {
 	.desc			= "rocket DRM",
 };
 
+/*
+ * The extra bit that rocket_job_hw_submit() sets in the S_POINTER registers
+ * is the hardware number of the core, which is its position among the core
+ * nodes in the devicetree: a disabled core keeps its number. The slot a core
+ * takes in rdev->cores[] is the order the cores happened to bind in, and the
+ * two only agree while the cores that bind are a prefix of those nodes, in
+ * devicetree order. Every task submitted to a core whose slot is not its
+ * hardware number then times out.
+ */
+static int rocket_core_hw_index(struct device *dev)
+{
+	struct device_node *np;
+	int index = 0;
+
+	for_each_matching_node(np, dev->driver->of_match_table) {
+		if (np == dev->of_node) {
+			of_node_put(np);
+			return index;
+		}
+		index++;
+	}
+
+	return -ENODEV;
+}
+
 static int rocket_probe(struct platform_device *pdev)
 {
+	int index = rocket_core_hw_index(&pdev->dev);
 	int ret;
 
+	if (index < 0)
+		return index;
+
 	if (rdev == NULL) {
 		/* First core probing, initialize DRM device. */
 		rdev = rocket_device_init(drm_dev, &rocket_drm_driver);
@@ -176,7 +205,7 @@ static int rocket_probe(struct platform_device *pdev)
 
 	rdev->cores[core].rdev = rdev;
 	rdev->cores[core].dev = &pdev->dev;
-	rdev->cores[core].index = core;
+	rdev->cores[core].index = index;
 
 	rdev->num_cores++;
 
-- 
2.43.0

