Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13E4910987AF
	for <dri-devel@archiver.kernel.org>; Fri, 20 Mar 2026 16:43:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 35D2710EBE1;
	Fri, 20 Mar 2026 16:43:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="QYozG0zg";
	dkim-atps=neutral
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D81B10EBDB;
 Fri, 20 Mar 2026 16:43:11 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 6EEA91A2F12;
 Fri, 20 Mar 2026 16:43:10 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 44AD6600E0;
 Fri, 20 Mar 2026 16:43:10 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 5D9AA10450CB2; Fri, 20 Mar 2026 17:43:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1774024988; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=M3FgCUEMluypg2hUM87s+WpQPhp08syHOF7yO9QQVkw=;
 b=QYozG0zgoLZwiW6GmAWTwfaLhUbV0Nfpq8+A7m1VU5rb1hCDTkr039xWxAuhtrjeqpyEui
 EXKdY3R37dy25BLoNqEA73wvser6I2RvGPPWbds/azO1pSDAb/lQ/vNSFt3oSrXvuHKLv0
 1NFQeEpxkie9R/Mg6wshR3tOlnRNPmePi+wtmezmLMaUMZYTf8+WL3NiEX+dwuAtNNwkM9
 aUddEDuYiBW4I3gxPDMo8ObhTMWaJrdZQMNt9eMHOLBU/OnbD++FdaXOeCkZJUkdXaQu5A
 1G8s21tD8A/GPskYRcbP2mwvyKB7pqRmKtDF0nrxrCD7BCbSfYj6YaA67DP9gQ==
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v11 51/65] drm-dyndbg: add DRM_CLASSMAP_USE to vmwgfx
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
In-Reply-To: <20260313132103.2529746-52-jim.cromie@gmail.com>
References: <20260313132103.2529746-1-jim.cromie@gmail.com>
 <20260313132103.2529746-52-jim.cromie@gmail.com>
Date: Fri, 20 Mar 2026 17:41:54 +0100
Message-Id: <177402491467.6181.8102074641959734273.b4-review@b4>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=350;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=eWqgMWhrD3FKZnBrU1ZvTHlKFrcuBk1hvU3k2C6gl+o=;
 b=owEBiQJ2/ZANAwAIASCtLsZbECziAcsmYgBpvXjamTJExJ3NaoOQEE5E5Zhj+pfcoQv+mRZuH
 wuioS1aiDSJAk8EAAEIADkWIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCab142hsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMSwyLDIACgkQIK0uxlsQLOLOsA/+K3eprPfblWsArA+Wzh6Ep3pU4H3dntL
 f5BwkH8Df1xdoho8BkPUn7eJQnzwdK0vRLHsXFvLuJzWvFo5DckN4Ao1ql+k779MX0gXDBzhfx8
 8rJn4tQ3Dtj959pYDUJHM7wB34Hi8C203+cbl3FGtpO6dadtK0x1Un5W+ndekbe2FwjepN9p96F
 GA+lZzRoFtmKnwKqGDZUWxjYNNwyvf5/fs5FdAiUEWdpnKEeRMxF7ODf4WL7VM0aV2rbtu5r3z2
 YQdp6vFNOVJ+HON55rgvoAWy56ewAmi796gp8sr710286s2hpgGrBUpsco+zfj6xzuFDY8XRCYy
 V7YzApOnc0Ake5PIJo36x57U3cZNVERTfucO6zVOv59NH43mgwEfgZMFayFWHHg3TzDV7aa4Md5
 JcL/yfzpgd/tWDOkkKTNlRnpiqRfQx0m/CaiIX0IYt7Ju9K9SPQDXi2oaRn+wmF3goRbhP4LH0S
 U3qsOE8as5mKYAXa6X2Ncxp+0mGaoC6IFnmGq15hDPi19dvUC5cRupNEVNLtaYDUVXPAJKnOirw
 ZyMPSmfll7zFBQj9Ys5swtHToDOE9IUs327YPxHMPBUJg1yak4BCAowoLGJ7qQMEbdm/T8g/+65
 KV9oVOCHwuyUrrzHR8ujhJAW3H33hywNUKsnMZe8FC05jU4T427Q=
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

On Fri, 13 Mar 2026 07:20:16 -0600, Jim Cromie <jim.cromie@gmail.com> wrote:
> The vmwgfx driver has a number of DRM_UT_* debugs, make them
> controllable when CONFIG_DRM_USE_DYNAMIC_DEBUG=y by telling dyndbg
> that the module uses them.

Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>

-- 
Louis Chauvet <louis.chauvet@bootlin.com>
