Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6671CC55ABA
	for <dri-devel@archiver.kernel.org>; Wed,  5 Aug 2026 15:51:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C19DB10E1B6;
	Wed,  5 Aug 2026 15:51:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DXosc+ss";
	dkim-atps=neutral
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5BF6610E1B6
 for <dri-devel@lists.freedesktop.org>; Wed,  5 Aug 2026 15:51:25 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-4957952e0f8so915285e9.2
 for <dri-devel@lists.freedesktop.org>; Wed, 05 Aug 2026 08:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785945084; x=1786549884; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=aqxi35qz8X0Jeybg10HKbsHNV5CZpS0quNYjwJCSOIM=;
 b=DXosc+ssdIMuhZAlMUUSESEMH6d1tFIV0ML4pukyRtJAj3PxnJkhAI+58gQ6qe3QHW
 Vyzeen3Cu2CNEyGVR42kfsVwspV+mbRYLuKNMdvYG4YDWr6d5gKhhM64aKM7GKKQ866F
 778RWab1hmu/KpWTxyC5TLV+Lvd+lOEB2VqWyTEeAzfSGP60ZYBNhgKIY9KJJ7r0c0Tz
 kZ9u06YFZ7ONFejNOc160BY9gIH7MQGBsFH8uH4ZoW+QpnLokaTAyeAd4EzOVqZDdQ4Q
 uWUfZ2RjYQqcDpz4+bZpv1araw7ofjXkEKb/aecs8z9stAJTpt8PgdQ64GK94fMtnsOi
 s7rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785945084; x=1786549884;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=aqxi35qz8X0Jeybg10HKbsHNV5CZpS0quNYjwJCSOIM=;
 b=jA0SaNa1vxdULCs1JrdooL2rHNeb5DMGhc57yANdm9ibohGTO6QXXQdLxcZJqUNrZK
 9hu64eIG/ayYpF2mPO6WCZhcjFPa51+tTFOe8uTgPfthvZ8uBQFE1Q3nkaShk6h9z26T
 JRgSxLFtk9+UFuZ7exayb2EnaFMJVSue7U3gC55wj+3GqDGUY51csyxw8wtnxyuMsDHT
 rlDyLW1cOrqvdgo0H3ryvpKXcrJqZMzEGsJI58ASp92jxeF+jnaaFqgQvRM2knWWd0D6
 H75aflCy3bMmUCDXP3BdxQBBHcUS/kWCtCrnKBX1UYVZp9yYuotOLR6OPVIdLWSc6wQh
 jCqg==
X-Gm-Message-State: AOJu0YzkLdjoc3IY9lk4nHlaSsgUm9GuzhSOa96aoxpUgwOUe/nxFYhL
 qcMWiEzV5u/DelGYxwFHDgvIMAg1yfa1lLwR9lGI0DWeD8ZwgG8uM3PpmA0/ampc
X-Gm-Gg: AR+sD11LiAAatjWwiDIxNp5dTEgV/ZBOt/MrwgIohi4pderWxNCroCAli4SBOCMURRG
 H4T8R1OIiox1oBDlT+iyF/wAW320NBccP2FnxV6wmSyqohFzpfXv9O6kUqr7Pgo0xrmbT7ozQGO
 Ufdi5ArxNv+HMXE7BE0y7H0prXrw+ESkkd3Q3276WbngV7m4YNt0QQunBer208NLz2iqWMHJtkR
 6JA0adDOTKxAmzetZM0WTqGXTdtFNyZ3oDOCUYuGmlXsbVUZcrpHwqp90tpex2GgsQ8FZQscXCd
 LtyMLtdGklw8qwBz4slApWr7thJHda+OQSdf5jg/1eb+uHHCFU25rERcY3Eby+iQQVIzJyPbFCo
 JmR5ohxPEPRbVVn+UhLtN1dldlZaIuVXc7RKXOnRgbd+QemPee9G3KuMK7weFdqQX7mhUJ2ZRhc
 K6oMuqxvJO5AAgVIQAbA6G06RCV+Jqg93WgA279yxHyoGF/8yqDtIjXmCrT2otKySl2yAq9a8k9
 6fHRXp7ZHyKYQ9fVFouAq+1Xlqaez8a+awaS7P1/p5fzcG4B7jW/7D7Jdsxr1RBvwj9
X-Received: by 2002:a05:600c:1550:b0:493:ad11:6d5c with SMTP id
 5b1f17b1804b1-4994e7cf0dcmr48652415e9.4.1785945079009; 
 Wed, 05 Aug 2026 08:51:19 -0700 (PDT)
Received: from OrangePi5-Plus.BB-HOME
 (20014C4E1B86F10001BE789C6EE938EE.dsl.pool.telekom.hu.
 [2001:4c4e:1b86:f100:1be:789c:6ee9:38ee])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4994e0356d4sm101820155e9.10.2026.08.05.08.51.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2026 08:51:18 -0700 (PDT)
From: Igor Paunovic <royalnet026@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: Sandy Huang <hjc@rock-chips.com>,
 =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
 Andy Yan <andy.yan@rock-chips.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, linux-rockchip@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Subject: Re: [PATCH v2] drm/rockchip: dw_hdmi_qp: attach the HDMI Colorspace
 connector property
Date: Wed,  5 Aug 2026 17:51:04 +0200
Message-ID: <20260805155107.11167-1-royalnet026@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260805154418.8133B1F00A3A@smtp.kernel.org>
References: <20260805154418.8133B1F00A3A@smtp.kernel.org>
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

Hi,

Thank you for the review.

The lifetime mismatch is real and worth spelling out precisely: hdmi is
allocated with drmm_kzalloc() against the DRM device, while the HPD
interrupt is registered with devm_request_threaded_irq() against the
component's platform device, with hdmi as the cookie and IRQF_SHARED
set. The bind error paths that follow the IRQ registration predate this
patch: encoder init, dw_hdmi_qp_bind() and drm_bridge_connector_init()
can all return with the handler still registered. This patch adds one
more such return, which can only trigger if the property allocation
fails under memory pressure.

So the issue is pre-existing, correctly flagged as such, and this change
does not alter the exposure in any practical way. The clean fix looks
orthogonal to this patch: register the IRQ with plain
request_threaded_irq() and tie its release to the DRM device with
drmm_add_action_or_reset(), so the handler cannot outlive the structure
it dereferences. Happy to send that as a separate follow-up if the
maintainers think it is worth doing.

Thanks,
Igor
