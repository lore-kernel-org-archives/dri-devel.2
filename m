Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5204A60A260A
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 17:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lR8F7y1w
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 941DB10F084;
	Thu, 19 Nov 2026 17:54:49 +0000 (UTC)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF9E6112690
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 17:54:43 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-4bb70074ab2so27696985e9.0
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 09:54:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795110882; x=1795715682; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=0nkkB75c4xO0BDbMTd+oRdUsHv55miDUR/T7l+kfobY=;
 b=lR8F7y1wzf8AbOI3au1ziMkqgPOURwBinKYjOlffQGftEYxXb02smmLzIRUVoPca5q
 Pf+cPAOU2HSmSgs/dxSz5lJmyf9Gzwl6i+Gn39qQmI3cl/sZfcJ6rTTzpIljr6SIi5RK
 0gpSiPpiq3NSGc/io7f3lrf0iQa7i5IWEOQyNGa1MxU7jaOYTr0l60G497YFFCmxdV+I
 RQm98lYmEJ1EBK1TKzB5Xtw76UHPYW7kpqYxF/vk7Vb0bgqcfmMsmaDt/FCzfk2ec7FM
 TPMhq8QIvUI6sN7GOpNL9pZFyJNf4Oi2OFUQkwkxNFpP9mCB1c4cut/DXaXhGKZ6605k
 i30Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795110882; x=1795715682;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0nkkB75c4xO0BDbMTd+oRdUsHv55miDUR/T7l+kfobY=;
 b=UhoTlNyl9V94xiHgsbi/u1iCI7O1oH/x/yxE9tnYvKJvifVP5VYwYol3qy5anurWQb
 +Hob5teC1l9vX6IqsQ743vXCaoQbsr1wlu1n/fPdlvFb+J9AT1UZp3DednuB0sKw1azY
 yyxxJvpI+3wkobLkklQ0JZCbAnAK0MfOz5m+xfIg8MSB8mz194udHqNze8v8wEOmr1Ij
 kfc2677mIAkadaBjsEuvRBvUUFnYMfn9goUkX5ib+TQkay74PbWKcv6mYSM49xBq+i8r
 gO1auSJ7fQszxLUzTuu2AEEBIQ+i0qnvgVD2CCs808kByDLneARUXw/7LrWtojf7kYQa
 ZyIw==
X-Forwarded-Encrypted: i=1;
 AL+hErGnabHkhusJV1KRTz2IfCe2k8sqCtwal4c8DHDtx4rHRieUomdu2DRf/4ekaNWjdvW7R5/wXtrz66c=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/vC1+vxAra/Fs44ZvKVBBARMv6nYTdUfoULe+9QqqCBcRF4uDO
 t+Prs56RiL5S1UHtY838aTNEJttRsZnBf8TBHbjl06dAQgsnYYs0jgCs
X-Gm-Gg: AYBFou13ekm67uK1aLrNZCTE8YKbedvwKVvHn96pFf/s+hkBpTalgtwJx4+gOop6/de
 DuuF+1ctjOaYmGfoLeDAB+jGEIagQv0k+imfZQEiR77PqaI3f8R+cEKwZxwr9VauHT5wMAs+4zp
 2xnHprv22fb7LJ0Ziva8OlrEqYM8b+cECTlKr9cxNWqmBTc5bYpi0s63e6w3xdyGJUXLBY3Z8PV
 vxixA6sVcA+kOz5y6KHT0ehblA8bbcsCX8lpqcY6Q675yxt0VXYUvRbQxcog7a+NA+2NgDWwz6T
 UgdRAWLvEBP6ilMg8Ak0Pht1W9LZx68jvpqsirEBHswPQAUe2zYapdQNZReDdwzuoA1Zn0xGTt2
 EB4+B4admwCwhAj21fUjUhBkTWGOivpEjov2vzh64MhBB8lygakvV8ID9LNLGRUEdrJEQVTrtdz
 gtLUkVnqT5n7WKAXRkCCIh0eGShnPcb9xZCZKOt7byTZQFmPxF/6oO8Yp1WoboXF+Prma7HdNg1
 J1jPgTAAeeVPtlayWfWj+Tg9vK/hr1bVTqFi93bR9PIJj03WWJRcQRhBTUiNhkrPsXY4OFkBqHR
 7Aw8LaMulmpFShGGvmc4onxlstkUV3Bf8S0BhFQLViZhAUmJJu3+5UIecBlBCh0tTnHPExdPpGp
 Q1q/LSyIBcE8hVp6K3AJfJydLUAJqEps83D3MddHMoyqEC0+ikkr7aW7KsKWg6S0HSuFlToY6s8
 1IfBkWJqIca6+gmbpvy6bV1oTOt/q36r5ArWYBJ7bAa51Fw0cVNd8bG8X8SbKulmlayx7NoMkwd
 BbmHTstPDdTyTr09Gubx/rRRE3CZyzVoihK13Zl4c6IANiLUfO4QIgl
X-Received: by 2002:a05:600c:1548:b0:4bb:7347:d5df with SMTP id
 5b1f17b1804b1-4bb88814405mr6842365e9.13.1795110881961; 
 Thu, 19 Nov 2026 09:54:41 -0800 (PST)
Received: from jernej-laptop (95-143-148-21.dynamic.telemach.net.
 [95.143.148.21]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb84e50512sm29390035e9.3.2026.11.19.09.54.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 09:54:40 -0800 (PST)
From: Jernej Skrabec <jernej.skrabec@gmail.com>
To: Chen-Yu Tsai <wens@kernel.org>,
	Samuel Holland <samuel@sholland.org>
Cc: mripard@kernel.org, maarten.lankhorst@linux.intel.com, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, Andre Przywara <andre.przywara@arm.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/5] drm/sun4i: update DE33 support
Date: Thu, 19 Nov 2026 18:54:32 +0100
Message-ID: <20261119175437.2520400-1-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.56.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This is second series out of three which aims at properly introducing
support for H616 Display Engine 3.3. Previous series [1] reorganized
driver so proper DE33 support can be easily implemented.

H616 DE33 support was actually introduced a while back, but it was done
without fully understanding hardware design. Issue with existing binding
is that it considers planes as resource which is hardwired to each mixer
as it was done on older Display Engine generations (DE3 and lower). That
is not the case anymore. This series introduces new driver for planes
management, which allows doing proper plane assignments.

Note that this series intentionally breaks existing H616 DE33 mixer
binding, which was released in v6.17. Old binding can't describe shared
planes, so second mixer can't be supported with it, and it never had any
user - there is no H616 Display Engine node in upstream DT, rest of H616
display pipeline is not upstream yet and no other known DT consumer
implements it. Reasons are documented in patch 4 and driver prints error
asking to update DT if old binding is detected (patch 5).

Patches 1-4 from v3 were already applied (clk patches to sunxi
clk-for-7.5, CSC and VI format patches to drm-misc-next). Plane driver
depends at runtime on commit 63a29fbb4ecd ("clk: sunxi-ng: de2: Export
register regmap for DE33") from sunxi tree, otherwise it defers probe.

Remaining patches, which introduce all the missing bits to fully support
display pipeline on H616 SoC, will be sent once this series is merged.
WIP patches, which can be used for testing purposes, can be found at [2].

Please take a look.

Best regards,
Jernej

Changes since v3:
- dropped already applied patches 1-4
- new patch 1: reject fractional source coordinates on channels
  without scaler (suggested by Chen-Yu)
- patch 3: mention in commit message that driver is hooked up only in
  last patch, update copyright year, drop unused of_graph.h include,
  use dev_err_probe() and MAX_DISP bound, collected Chen-Yu's R-b
- patch 4: collected Chen-Yu's and Rob's R-b
- patch 5: fix include order, use device_is_bound() under device lock,
  guard put_device() in error path, drop stale @map kernel-doc, rename
  planes platform device variable, mention missing scaling in commit
  message, collected Chen-Yu's R-b

Link to v3: https://lore.kernel.org/linux-sunxi/20261115061102.229680-1-jernej.skrabec@gmail.com/
Link to v2: https://lore.kernel.org/linux-sunxi/20260509190015.79086-1-jernej.skrabec@siol.net/
Link to v1: https://lore.kernel.org/linux-sunxi/20251115141347.13087-1-jernej.skrabec@gmail.com/

[1] https://lore.kernel.org/linux-sunxi/20251104180942.61538-1-jernej.skrabec@gmail.com/T/#t
[2] https://github.com/jernejsk/linux-1/commits/sun4i-drm-refactor/

Jernej Skrabec (5):
  drm/sun4i: Reject fractional source coordinates without scaler
  dt-bindings: display: allwinner: Add DE33 planes
  drm/sun4i: Add DE33 shared plane driver
  dt-bindings: display: allwinner: Split H616 DE33 layer reg space
  drm/sun4i: Switch DE33 to split plane bindings

 .../allwinner,sun50i-h616-de33-planes.yaml    |  46 ++++
 .../allwinner,sun8i-a83t-de2-mixer.yaml       |  16 +-
 drivers/gpu/drm/sun4i/Makefile                |   3 +-
 drivers/gpu/drm/sun4i/sun50i_planes.c         | 209 ++++++++++++++++++
 drivers/gpu/drm/sun4i/sun50i_planes.h         |  43 ++++
 drivers/gpu/drm/sun4i/sun8i_mixer.c           | 191 +++++++++++-----
 drivers/gpu/drm/sun4i/sun8i_mixer.h           |  11 +-
 drivers/gpu/drm/sun4i/sun8i_ui_layer.c        |  24 +-
 drivers/gpu/drm/sun4i/sun8i_vi_layer.c        |  24 +-
 9 files changed, 486 insertions(+), 81 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/allwinner,sun50i-h616-de33-planes.yaml
 create mode 100644 drivers/gpu/drm/sun4i/sun50i_planes.c
 create mode 100644 drivers/gpu/drm/sun4i/sun50i_planes.h


base-commit: 8e2afcd2b57990465f132367fd8fdc2e55c1adad
-- 
2.43.0

