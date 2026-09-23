Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C102BC982EA
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 07:54:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C72710EF43;
	Wed, 23 Sep 2026 07:54:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.b="QLwiQBXr";
	dkim-atps=neutral
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E095910E7A3
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 02:31:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=vS
 VPHuHrUkL51UPG382mmuvFtW0RKjV7Xs34RRuVjd4=; b=QLwiQBXr0bluuCqXd/
 joxI1295RlePrkVqLaTPNbog2ZsogoWRYMbmNvNEzWPjj5g8zxdayYQrI2erMkHg
 lXA2i5AiKFNf7wctYCfmpZ4XxAywm2ze2W9MngrwZvCAq4HQoga4PQ5WmK2QCulg
 ssjK1LDmG1jfC0IHdzdUizmb0=
Received: from chaosheng-ASUS-TUF-Gaming-F16-FX607JV-FX607JV.lan (unknown [])
 by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id
 _____wD3v_XEObNqGdr1AA--.62171S2; 
 Wed, 23 Sep 2026 10:30:29 +0800 (CST)
From: Quchaosheng <quchaosheng000406@163.com>
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Andreas Kemnade <andreas@kemnade.info>,
 Kevin Hilman <khilman@baylibre.com>, Roger Quadros <rogerq@kernel.org>,
 Tony Lindgren <tony@atomide.com>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-omap@vger.kernel.org,
 quchaosheng000406@163.com
Subject: Re: [PATCH v3 1/2] dt-bindings: display: ti,
 tpd12s015: Convert to DT schema
Date: Wed, 23 Sep 2026 10:30:18 +0800
Message-ID: <20260923023018.352035-1-quchaosheng000406@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260916123210.107841-1-quchaosheng000406@163.com>
References: <20260916123210.107841-1-quchaosheng000406@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wD3v_XEObNqGdr1AA--.62171S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tw1xXrWruF4xtF47AF1rCrg_yoW8Gw18pa
 98tFWxCF1vqr1xC3y7Wr1jqw4rtwsxXF45GFyS9r15A3Z8G3yIkrsakw4qqrW2krZ7Zw4j
 qr1Yg3srtwn0qaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0JU_73gUUUUU=
X-CM-SenderInfo: xtxfxtprvkv0bjqqikiqw6il2tof0z/xtbC-wYHfGqzOcZSUAAA3m
X-Mailman-Approved-At: Wed, 23 Sep 2026 07:53:55 +0000
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

Hi Tomi,

v3 of this series went out on 09-16 and has not had a comment since. I do not
want to keep reposting it, so this is just a nudge in case it fell off the pile.

  1/2 dt-bindings: display: ti,tpd12s015: Convert to DT schema
      <20260916123210.107841-1-quchaosheng000406@163.com>
  2/2 ARM: dts: ti/omap: drop unit-address from tpd12s015 endpoints
      <20260916123210.107841-2-quchaosheng000406@163.com>

Where it stands:

 - 1/2 replaces ti,tpd12s015.txt with a schema. The one thing that changed
   after v2 is the gpios range. v2 capped it at three on the assumption that
   no board passes more, but omap5-igep0050.dts passes five, its DDC SCL and
   SDA lines following the three the driver uses. v3 allows three to five and
   says so in the description, so igep0050 keeps validating.

 - 2/2 drops a unit-address that has no matching reg property from four
   endpoint nodes on am5729-beagleboneai and am57xx-idk-common. That is the
   only reason the two are in one series; 1/2 does not depend on it and it
   can go in separately if you would rather.

dt_binding_check is clean on both.

I have left aaro.koskinen@iki.fi off this message. Mail to that address
bounces: the alias forwards to musicnaut@musicnaut.iki.fi, which discards it,
so he has not seen any of the three postings. If the igep0050 part needs his
input, someone else will have to supply it.

If neither patch is wanted, say so and I will drop them.

Thanks,
Quchaosheng

