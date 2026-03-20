Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D312D10987A5
	for <dri-devel@archiver.kernel.org>; Fri, 20 Mar 2026 16:43:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 35D9E10EBF1;
	Fri, 20 Mar 2026 16:43:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="RaVDsqxt";
	dkim-atps=neutral
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 00CE410EBED;
 Fri, 20 Mar 2026 16:43:29 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 07E24C56690;
 Fri, 20 Mar 2026 16:43:54 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 8314D600E0;
 Fri, 20 Mar 2026 16:43:28 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id E9AE710450CB4; Fri, 20 Mar 2026 17:43:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1774025007; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=u2irWJj0gSwo/hD+sJSAqBIW49XR+qilqH6rOzV9ckw=;
 b=RaVDsqxtLIOTib2L37VOLAxHyIiSoO/XNfNVWPmk0atNj7Opa5FznPSuT2xXzGO+9IXzQw
 9hV89SA8Mw15WPtNFTgqQnXezbQGmqNTtASCdrTfquWKhO/FMUUuskAchIasLMyREPr2T7
 n2EwT3DKwrbbfkd+RE64tbjte/E8fpah8JVJGaRRyq4u89g8ezSI6lVtkHB0aVFf+gIgRi
 tDFEbpvglLwO1bYxcU2N6g7BFg0YCpwP5m501j6jzHOiq44F3SI+Oplrq/v3OUjdKmTv51
 VGjx/lwaTuojOFOY6KlH7ZctDRshovsk1bZUL4hL1m/h0Pg5ohRLTYnB3sAhMQ==
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v11 56/65] drm-dyndbg: add DRM_CLASSMAP_USE to the qxl
 driver
From: Louis Chauvet <louis.chauvet@bootlin.com>
To: airlied@gmail.com, simona@ffwll.ch, jbaron@akamai.com, 
 gregkh@linuxfoundation.org
Cc: Jim Cromie <jim.cromie@gmail.com>, mripard@kernel.org, 
 tzimmermann@suse.de, maarten.lankhorst@linux.intel.com, 
 jani.nikula@intel.com, ville.syrjala@linux.intel.com, 
 christian.koenig@amd.com, matthew.auld@intel.com, 
 arunpravin.paneerselvam@amd.com, louis.chauvet@bootlin.com, 
 skhan@linuxfoundation.org, pmladek@suse.com, ukaszb@chromium.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 intel-gfx@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
In-Reply-To: <20260313132103.2529746-57-jim.cromie@gmail.com>
References: <20260313132103.2529746-1-jim.cromie@gmail.com>
 <20260313132103.2529746-57-jim.cromie@gmail.com>
Date: Fri, 20 Mar 2026 17:41:54 +0100
Message-Id: <177402491472.6181.11420545166040585097.b4-review@b4>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=347;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=Wln1btqiOdoJL+aZuONw53NtRihFFb3e7pL78OtbwU4=;
 b=owEBiQJ2/ZANAwAIASCtLsZbECziAcsmYgBpvXjb/S0Cb1DqZD01fiQm1l5B3flibTP4bl3Ew
 HbN1JQK0BaJAk8EAAEIADkWIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCab142xsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMSwyLDIACgkQIK0uxlsQLOI5ag/+KfYnSUH8Gi6lXGx5/guVM+nwH7SWzzd
 PdjdDfK7BT5YUNOaP+cmvCNAzWkH4B5d1p1j0ZaMvaJsE5wpv8oqXze4x95X014lWQ1I0Hyx8tS
 0DdgkR7cBX15jhs0Vk2D/6uNseyavP5WJ4dUJCea+f6LrIWkoReg5ckmUotgvjLyftAadmD9JKa
 HKtDJ6THU2ethb0jK6ZxCEsGRSwJsxW7StL2qcEOFej+kzkt8iCSQ8kCGQBMegVLUPNnJmytFuL
 ELuLy2hl/KukA2G9oEtrtdI8xgAwJNQiyY9tR9oC3mocyCwGcr5JuNWKwsq8ccqPIj2cUKBJest
 AKv4cf6alhlnaIj7wzL+DxLMQAh16MGgwNEBOvRIWzysujDoQPROYsvzv9jQijk+dvLn4uO9G3e
 cCmBkDNvJr13aymyi4gfvHYrIhVkRnIMIVJ4XoAbwgcLvNZxuDf8cH/KtWAb2X08GsdK1pIoiFe
 vjicEPD0CL8ddFYnDjmp/BDRxyFs7L5pkuWa1muxdnMTDF1AcMXSiwmt0/rKHAa0MNNs1UWv81w
 uRgBMa6wTdqcZOk4fWhbwn0mlEfiAoI0HSaDsSoIqAdx1RnwuUQ02l2y3+am2iY8RPtV2meC2iZ
 keYqGV2XV9rj6EGjAKBllWOYRoVk/aUKTnl92yC42hraZV7se+Gk=
X-Developer-Key: i=louis.chauvet@bootlin.com; a=openpgp;
 fpr=8B7104AE9A272D6693F527F2EC1883F55E0B40A5
X-Last-TLS-Session-Version: TLSv1.3
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

On Fri, 13 Mar 2026 07:20:21 -0600, Jim Cromie <jim.cromie@gmail.com> wrote:
> The qxl driver has a number of DRM_UT_* debugs, make them
> controllable when CONFIG_DRM_USE_DYNAMIC_DEBUG=y by telling dyndbg
> that the module uses them.

Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>

-- 
Louis Chauvet <louis.chauvet@bootlin.com>
