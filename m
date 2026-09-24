Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3F1EC98318
	for <dri-devel@archiver.kernel.org>; Thu, 24 Sep 2026 21:47:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 10A2A10E760;
	Thu, 24 Sep 2026 21:47:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ax/mFyBv";
	dkim-atps=neutral
Received: from mail-dy2-f12.google.com (mail-dy2-f12.google.com
 [74.125.229.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D72D110E760
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 21:47:04 +0000 (UTC)
Received: by mail-dy2-f12.google.com with SMTP id
 5a478bee46e88-32dbbe82e13so188270eec.0
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 14:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790286424; x=1790891224; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=vmbHwdbLykki4BBoXNNKdYpZGlaAV7d37IywwLOJY5w=;
 b=ax/mFyBvWAe1l91HcNNHd3lFr66g/p5tlhVCbMqMx0lFN1LCHGq6rpsQDPQq1LYlbM
 Kf1WDSHRhxMUNM7ryLCoT9N1aKtq3RWpGv55OJcsyGcYaZIOjXWfh5fkj8IDdIpA7El+
 XzWzdtgN3NM/lHv4uGJEXPw951Yqhc5xiTxadNh4Y0GgzHRU7OUkR9B31IWYWbDRDVpT
 6Lat9ADO8o8x3VeypFKUqBCP9ITFXaVIeIQXPXj2IgO4Fn8SQf03acojyd3LwSjgBS15
 JZ2FQC35CyBvrtzktvGvTVvFrg0DyT/Fh0oHFz70YoM6DwqiO3iiS0wO8euLGHaNYhEr
 L+HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790286424; x=1790891224;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vmbHwdbLykki4BBoXNNKdYpZGlaAV7d37IywwLOJY5w=;
 b=JMKNFuXvVL1gz43nIPu6JAyjWE+5CDQ9DZfK4HMyc45Gs8Aobf4FFERxxgFxJIPKzP
 UQBtFcBPZ98vXEy42skiL1QkwutvITw/5l13xOX0UBVLemUniEVpuQdysKCnrVYldNTB
 l00/dumv3+0cF9HZhClAqf8OaKJzs5iR1QJ4YZ67x6h1eC+fDoQW2/daIa5r8ShZZ9iR
 bCtfE+Iy3ij9lnJcOPVutjBKehhGy0TTR2ZIX4W/h2GoB9rPEPeI7q1Eh0447jLw9DYE
 hCGLHps8YJg0QHQ4s7TVpvCUhBSCSSdAcYTDv8pVvNrxDvmygGH+hkLVx6yl7Ma9Svzr
 l7yA==
X-Forwarded-Encrypted: i=1;
 AKwUvBy+VsIIEmt5yEdah2aVZKc93Dxlup/8pVJSMkchwky8jg3dl0hK72anj2ujeSXQPEVSPm80o3rvvaU=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kzNbwyzisFKSn41nU4gV0bMaU1YaE0lWq3L/xkYw9uIiYPV0j+
 OjBuM6KhGvGtvJi/NGViBew826PXTCu1DjSocD6iFBhZhRlL2dtt4Ig=
X-Gm-Gg: AYBFou00RUQc+bJLoW8cdz2Kro+PgrhmQa/HeZgEBTudgTR9IWbeOrOCjA48Iw1brIE
 5UZvVr46T/ucRtPJlir48eNxNE57eIW4XmP+WP0eoEHpPxzoqdZmnseXp9wdMaFDEYrYng0EIPE
 jKVkLwWtcaCKfMaldvVZSAbPwhPzxV/uWnFRtaen/j6Kpxg9CF7RuNcQSSFWl2GIIJtVdQYM9V2
 zvExeVwbE3Nh3OEFDK1rKixu1isCyAbzJgG1jVWH2SmtyHzr2uIV8HyG0Zg1eEsquHi+UrqVcGY
 1GivPNcc915MTKw6emu6ivhnKMAyZ+URRmR3NKle54KHwQHn/L4riIwhUIGcKUOXesVEpIoS3Ih
 R8id92sBH6yBTqdskcQFwD3Wbufv9QiePVz84HxPwOsSRpiP2Rdi17WhzfYj4NXEOVTft/E5OL4
 +nejFnHnH9Joov8VMbFpfVXQa2G8RKMRHCublnhouMkxf+KlsJAU3AcRBv2KJvaMiUN26RvOCFP
 hLMceo5NY5d89QqPw1F8UhTt9McpZzBRS5SmtoD/12DJc18pg==
X-Received: by 2002:a05:7022:3b0c:b0:143:761a:863e with SMTP id
 a92af1059eb24-145040d406amr4150298c88.44.1790286423822; 
 Thu, 24 Sep 2026 14:47:03 -0700 (PDT)
Received: from localhost.localdomain ([186.158.238.108])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-145acc45f03sm1171577c88.7.2026.09.24.14.47.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2026 14:47:03 -0700 (PDT)
From: =?UTF-8?q?Nicol=C3=A1s=20Antinori?= <nico.antinori.7@gmail.com>
To: nico.antinori.7@gmail.com,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: christophe.jaillet@wanadoo.fr, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, jkoolstra@xs4all.nl,
 linux-kernel-mentees@lists.linux.dev, linux-kernel@vger.kernel.org,
 me@brighamcampbell.com, skhan@linuxfoundation.org
Subject: [PATCH] fixup: remove uninitialized variable bl
Date: Thu, 24 Sep 2026 18:45:57 -0300
Message-ID: <20260924214640.6149-1-nico.antinori.7@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <29b7f9786f08989c8f941ab85a76c62d1f5ee43b.1790200427.git.nico.antinori.7@gmail.com>
References: <29b7f9786f08989c8f941ab85a76c62d1f5ee43b.1790200427.git.nico.antinori.7@gmail.com>
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

Remove the uninitialized variable bl and fix the IS_ERR check.

Signed-off-by: Nicolás Antinori <nico.antinori.7@gmail.com>
---
Small follow-up patch that fixes usage of unintialized variable.

Apologies for this oversight!

 drivers/gpu/drm/tiny/ch1115-i2c.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/tiny/ch1115-i2c.c b/drivers/gpu/drm/tiny/ch1115-i2c.c
index cb6198a8e55b..631dd25e7dcc 100644
--- a/drivers/gpu/drm/tiny/ch1115-i2c.c
+++ b/drivers/gpu/drm/tiny/ch1115-i2c.c
@@ -751,7 +751,6 @@ static int ch1115_probe(struct i2c_client *client)
 {
 	struct ch1115_device *ch1115;
 	struct device *dev;
-	struct backlight_device *bl;
 	int ret;

 	dev = &client->dev;
@@ -802,8 +801,8 @@ static int ch1115_probe(struct i2c_client *client)

 	ch1115->bl_dev = devm_backlight_device_register(dev, dev_name(dev), dev, ch1115,
 							&ch1115_bl_ops, &bl_props);
-	if (IS_ERR(bl))
-		return dev_err_probe(dev, PTR_ERR(bl),
+	if (IS_ERR(ch1115->bl_dev))
+		return dev_err_probe(dev, PTR_ERR(ch1115->bl_dev),
 				     "Unable to register backlight device\n");

 	// DRM
--
2.47.3

