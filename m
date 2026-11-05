Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B58CB606A326
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 09:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=w2GycIF3
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D7C2112C43;
	Fri,  6 Nov 2026 09:18:48 +0000 (UTC)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7252E10E13E
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 20:07:14 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-4a2000d5fb1so14373785e9.1
 for <dri-devel@lists.freedesktop.org>; Thu, 05 Nov 2026 12:07:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793909233; x=1794514033; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=dCmDJGQnLkybuK/FNJb9oTUo/DUbc0oZdDzO8vpbYhI=;
 b=w2GycIF3YyAHvLk043FX7yVpFUzoddYqkrQuQedrirIzluTEGPsVI+yjmpX55ilt0u
 867DMCHWoF7W5a2GF1EgqeW6aJDCIG5n/846WWWk70kq5UnlR3pHjNGo2kegPpTlt73z
 7/7i2sFhFpyUmck+2+VIWYJDwNcFbGS3ZtJs57Pkn3/KztdqxMhV32nJhSrZkeOIjqaf
 SdxQ5ZiZkt7k23sj5cI9PczgjmCOJ0TSWexdsZR6/DtrqJm6w/qQVzk2UAH0/hb4zgYW
 myIa6K8n4wC3jGHEpXFwusHqKIR8/z+w901/xVXe3gFu4nhgcLd/AeYK+CAvdQn1SLi8
 8sww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793909233; x=1794514033;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dCmDJGQnLkybuK/FNJb9oTUo/DUbc0oZdDzO8vpbYhI=;
 b=Eiugk9kgaUFxS9LPl+AP8tqNNQmjtJahqrIUP7Jewpy4jD6uQbQN8sFtq8ZyDJVl5N
 8RuHrotydO1A9hA76mMWszJejEPltyAbjeoaPWYVrtsqTHdNgsYOkAii4Ow5dVPUVBDT
 zpMZVv4LBGiCHbNZTDtrWVUQ9fG21sSV0wXS2SaTlO3QKuUKWcTKnch+YV/995nt54uc
 IUFQ2m6KrIGiuPJQ/9S4eD+YKLct+9xsBb1h+YcxBvrJugRh657TySUFSz8HuJ+IqYz4
 tUnsYHZwFsQWayY8rOJFfRrX4RYp5D2A93TaHRiAadzovB+Djgdi3BzG0az70zmZfIaF
 GUaA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzrOwfXyK0hU1wqM0mpALEz/03bitkAZggTIg8CjwTkNof1fhn0zLOA6ERQtNu9y77HIvK8N5eUDPA=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z96TkiN7ZO55iigl9ox7Pqexdlp3anJms9fRnE1A1ERz/pA267l
 F0C0mOSL/0sT4tTL6tILftSbHk11mE5zrFhG26tJXN128kES8fxrbH5Q
X-Gm-Gg: AYBFou3ogBRWZo4ZFrHAKdv0XEIJ6UhPnzMJlVrCLixBdf4nK3r9uI7uz8qI6sUOiku
 xPBEo4px36d8XtNngUn9MypZSkVLfRkqKaPFJJxMdHJCRhlqnuwtVZx7PYWVaA2U7cLSzwW+whJ
 xidaNCvAPvoRm47gJC6j1eD7J36gwre8Fqx63IO3/Ul5q6NeybToHqkhg5Z5JLznlpkP1Oa+rWp
 01XN+LSnL2LE/1aTAy7nxZx32fPF/OWtpi0mqI7C/Z+/FQyxvR0msUooSuXAclYQnMrD2diIe+R
 3Xx8yiuyTKweScCe8eQ01cRK9QT9Bzgydbx1vMcIYibb3WRZYtt4piZ8C/xJBbahETmNBIXJ5Qx
 tYGW3b1zx8aO/LfFIVR/5MJc7f4yQKCBBlwCCMv15Zu1dVrtmlwCz5UfcGJC5g327VruTto3Hug
 kC3dyCfQw0Y1cJV8DsenTiHiojaSdxyChWxtwSXgE75soRoWzyh29PWL0hW41ndovKE2pmMV2Rm
 wzk67w7Koeif0KeyWno56vMnB2nX3Hr5dEEWb2LYhTCi7GqPIoGDee9xgERUZJoRWaARP8794Cp
 2+QkX9JFJ02KSm5AV7mjx3iaIRzJsWgk2Q/EsYCbM0QsSLKIjdRFWW6sDmI=
X-Received: by 2002:a05:600c:1d26:b0:49f:fd40:80fa with SMTP id
 5b1f17b1804b1-4b6dff86444mr3062505e9.34.1793909232668; 
 Thu, 05 Nov 2026 12:07:12 -0800 (PST)
Received: from antoniarch (78-212-29-45.subs.proxad.net. [78.212.29.45])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b433ebd278sm131671835e9.3.2026.11.05.12.07.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 12:07:12 -0800 (PST)
From: Antoni Pokusinski <apokusinski01@gmail.com>
To: vigneshr@ti.com, andi.shyti@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, aaro.koskinen@iki.fi,
 andreas@kemnade.info, khilman@baylibre.com, rogerq@kernel.org,
 tony@atomide.com, jmkrzyszt@gmail.com, sumit.semwal@linaro.org,
 christian.koenig@amd.com, phasta@kernel.org
Cc: linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, Antoni Pokusinski <apokusinski01@gmail.com>
Subject: [PATCH 0/3] i2c: omap: add support for DMA
Date: Thu,  5 Nov 2026 21:05:51 +0100
Message-ID: <20261105200556.34240-2-apokusinski01@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 06 Nov 2026 09:18:40 +0000
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hello,
This patchset introduces support for the TX & RX DMA transfers in the
am335x/omap I2C controller. I tested this implementation on AM335x 
(Beaglebone Black) and things seem to work fine.

Kind regards,
Antoni Pokusinski

Antoni Pokusinski (3):
  dt-bindings: i2c: ti,omap4-i2c: Add DMA properties
  ARM: dts: am33xx-l4: Add missing DMAs for I2C controllers
  i2c: omap: add DMA support

 .../devicetree/bindings/i2c/ti,omap4-i2c.yaml |  12 +
 arch/arm/boot/dts/ti/omap/am33xx-l4.dtsi      |   4 +
 drivers/i2c/busses/i2c-omap.c                 | 291 +++++++++++++++++-
 3 files changed, 303 insertions(+), 4 deletions(-)


base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
-- 
2.56.0

