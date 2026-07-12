Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71567C43458
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 07:12:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6FCBE10E817;
	Mon, 13 Jul 2026 07:12:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CYwxQdeA";
	dkim-atps=neutral
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com
 [209.85.221.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4891310E473
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Jul 2026 12:37:43 +0000 (UTC)
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-47df6a5202bso1298370f8f.0
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Jul 2026 05:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783859862; x=1784464662; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hNARwloA3rbnFq4jTz32GunvMhdlXc/eq0tF3XfoMbU=;
 b=CYwxQdeAggOpWcxPa2TRVDSn8pzqQPd0hZJPOUqaM7MAMWe5aNqH9Qn75pkzYjB7O2
 U6W/JLVQRcPomdIIU5p+H3jYVdvDDGE893bYRU+3Au/fcjY1E9nfeB2abXBBNsPS6r+G
 Ks7J9KwKq+1VaB3GVdPu4ZcW/e1vIGQ+PAVljbez1/bmTCqq+UmyKW0H9JWb8B2vwNAH
 BClj/i+aE5QGrG3UdouyE/LmaF6CKkZtpJXFkCwJ3N/DBZroc2MBnwkVg7HIbzBLw4gx
 n7Asc66NpncDPzyQ4DsM04VfvbdBuheI/3VJilqjYtwAkJuJ7z8tjL8dvYx9HoOX9VCG
 hUHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783859862; x=1784464662;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=hNARwloA3rbnFq4jTz32GunvMhdlXc/eq0tF3XfoMbU=;
 b=HQhuXDCErB/K1JPdodykIVoxiuAac6o87qoPYKhyiHp9x4nwSFRU6Yema4Prv6Kzqz
 alYbZt/2xKpvgckHubnOAUD+lE/5vRiEAtnt/VRvT2MD5eDuhAa3rNQcIlwd7LBpDb/h
 kPuePTpx2h9wcYJJwKNifnYg3b20QUdL8VBrNY6+eHDoENwruwsJ1vLgVRSTV5wdiWrd
 758Klbo6o0tjovn4IxDCI/4mr4XW1HWk+OL9tyjHtH8gRHBc7omUmyrTdCqEuzcgpDAO
 dQvX0+t4Few73WMLr7zSmQrJItn/HcmlKLEaiVT8Q1XjC5XcWewR0EF/y5MdHRzUZpid
 jd8w==
X-Gm-Message-State: AOJu0YyX0vMA+GmVWEMEZ3MPZAzxkC4g7ra75mcJphK+L8dLLDFiMwmJ
 +xpHu2C4HTumY1avrU6p/BYT1LanDus0gn3AOG7MRxZFC12o0BQowbSlb8NCpOduy4E=
X-Gm-Gg: AfdE7clywJy5Vpck4X0JO/q+DA70j6k2/2pANBRQDR8E6+7eXdRBiAo3J+b3BOLlgY/
 rVGEI10Q77WQJInqZJXfZy4sV0TTwVPUR5Bevov6RbJ0sn5OIqMdXb3FdiI1cQReeGMGnR3cGXu
 JxBrfdYBu6Z1FqUYjr6Xbm1qib32I4HANfQw9TtJ0yQTESUF8j/Qyo8oclvIIiJWL3JP8IY07Hn
 OJOG07Nay0q29KrIjhBJGnbCJPpn3cNJ/TGlLSQZ/a5XCb6I5gVJwvVqGz3ATo1VSO6VcsqxsHg
 Yei0sY5yFwxQo8OKgy9UIhJhtUd8k4dtcoP+ndrLexqHUxtzNhet9HV0rYrNgKuQn0hlBW7aaja
 HnffJjBvQ4ur/ZuvehSFLH5XJJ/4rBF/BLadO2tHTnsiXWi0/hQ7lwq8xBXrZfQS9sUeVg5xXXW
 UjGh5a3o17PG6Xyh6wYYxzQ4mFKg==
X-Received: by 2002:a05:600c:45d4:b0:493:a966:d5b5 with SMTP id
 5b1f17b1804b1-493f87dc5d3mr55586175e9.2.1783859861600; 
 Sun, 12 Jul 2026 05:37:41 -0700 (PDT)
Received: from fra-x8664 ([2a01:e11:8000:43b0:96d6:566b:35c:7b8c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493eb6f3c42sm280280485e9.1.2026.07.12.05.37.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Jul 2026 05:37:41 -0700 (PDT)
From: Francesco Magazzu <postadelmaga@gmail.com>
To: Lyude Paul <lyude@redhat.com>,
	Danilo Krummrich <dakr@kernel.org>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Dan Carpenter <dan.carpenter@linaro.org>,
 Karol Herbst <kherbst@redhat.com>
Subject: [PATCH v2 4/4] drm/nouveau/clk: don't clobber reclock status when
 restoring volt/fan
Date: Sun, 12 Jul 2026 14:36:16 +0200
Message-ID: <20260712123616.1180830-5-postadelmaga@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260712123616.1180830-1-postadelmaga@gmail.com>
References: <20260712123616.1180830-1-postadelmaga@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 13 Jul 2026 07:11:31 +0000
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

nvkm_cstate_prog() reuses 'ret' for the voltage and fan-speed restore
calls it makes after reprogramming the clocks.  Those calls almost always
succeed, so the status of the reclock itself is overwritten and the
function reports success even when clk->func->calc() or clk->func->prog()
failed.  The converse is also true: a successful reclock is reported as an
error if the final restore call fails, even though that failure is only
logged and otherwise ignored.

The only consumer of the return value is the error message in
nvkm_pstate_work(), so in practice a failing reclock is simply never
reported.  Nothing else changes, but a function that returns success on
failure is a trap for the next caller.

Keep the calc/prog status in 'ret' and use a separate local for the
restore calls.

Fixes: 3eca809b3c05 ("drm/nouveau/clk: cosmetic changes")
Signed-off-by: Francesco Magazzu <postadelmaga@gmail.com>
---
 drivers/gpu/drm/nouveau/nvkm/subdev/clk/base.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/clk/base.c b/drivers/gpu/drm/nouveau/nvkm/subdev/clk/base.c
index 4d546b07f..05336fc7d 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/clk/base.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/clk/base.c
@@ -199,16 +199,18 @@ nvkm_cstate_prog(struct nvkm_clk *clk, struct nvkm_pstate *pstate, int cstatei)
 	}
 
 	if (volt) {
-		ret = nvkm_volt_set_id(volt, cstate->voltage,
-				       pstate->base.voltage, clk->temp, -1);
-		if (ret && ret != -ENODEV)
-			nvkm_error(subdev, "failed to lower voltage: %d\n", ret);
+		int err = nvkm_volt_set_id(volt, cstate->voltage,
+					   pstate->base.voltage, clk->temp, -1);
+
+		if (err && err != -ENODEV)
+			nvkm_error(subdev, "failed to lower voltage: %d\n", err);
 	}
 
 	if (therm) {
-		ret = nvkm_therm_cstate(therm, pstate->fanspeed, -1);
-		if (ret && ret != -ENODEV)
-			nvkm_error(subdev, "failed to lower fan speed: %d\n", ret);
+		int err = nvkm_therm_cstate(therm, pstate->fanspeed, -1);
+
+		if (err && err != -ENODEV)
+			nvkm_error(subdev, "failed to lower fan speed: %d\n", err);
 	}
 
 	return ret;
-- 
2.55.0

