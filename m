Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3299C43327
	for <dri-devel@archiver.kernel.org>; Sat, 27 Jun 2026 03:31:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 90C7710E424;
	Sat, 27 Jun 2026 03:31:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="yTmyt0dj";
	dkim-atps=neutral
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D398810E423
 for <dri-devel@lists.freedesktop.org>; Sat, 27 Jun 2026 03:31:08 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 73237C5CD7A;
 Sat, 27 Jun 2026 03:31:16 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 61EFC60233;
 Sat, 27 Jun 2026 03:31:07 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id C6B8C106F1170; 
 Sat, 27 Jun 2026 05:31:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1782531065; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=OZ8EM81DGMlJ9qEgvUE9Mt5KnFr4O4RtbirwspUTjRM=;
 b=yTmyt0djrIvDz5sia3dlyFo9K+o8tbbwin4Dc8R2c/IlQnUv5irrsKvGzTdiwXbAJ34wKH
 GM2McjpWG/y/nzI0XxZksRrgNBIO1CD4kQMRtHq2udX8Av0xJORWwQos+3c18aGqDNlzdW
 HDqZ0gGG40q5PRgEW/7arD3C9gDALolyWcq46HDyEB4DSbLVg8NV6aknl4Uu6uR1C5M9Xr
 AX3n3FIvM3+GKk1952j07Y3VlB0PLg2edZGqu5Jd0IYTi310d50O11t0biaUlGk7Io+6cf
 VPs8Daj3QLuno5jxybirPd7cICEKkoV/OyN4SGXGobQHCb+xZpZrzMEsZ5YWXQ==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Sat, 27 Jun 2026 05:30:24 +0200
Subject: [PATCH v5 07/38] Documentation: ABI: vkms: Add current VKMS ABI
 documentation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260627-vkms-all-config-v5-7-854aa0840926@bootlin.com>
References: <20260627-vkms-all-config-v5-0-854aa0840926@bootlin.com>
In-Reply-To: <20260627-vkms-all-config-v5-0-854aa0840926@bootlin.com>
To: Haneen Mohammed <hamohammed.sa@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Melissa Wen <melissa.srw@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, jose.exposito89@gmail.com, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Miguel Ojeda <ojeda@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>
Cc: Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Kory Maincent <kory.maincent@bootlin.com>, victoria@system76.com, 
 sebastian.wick@redhat.com, victoria@system76.com, airlied@gmail.com, 
 thomas.petazzoni@bootlin.com, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 Louis Chauvet <louis.chauvet@bootlin.com>, llvm@lists.linux.dev
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4411;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=M4IKg4jtN2coKi4h2W5OHuSx8L+kOjlkuI6yHVh2tSk=;
 b=owEBiQJ2/ZANAwAIASCtLsZbECziAcsmYgBqP0Pd17dPdykH+J1Rl+Mvy3D02QP1ls2Fn3X5O
 BB88oAgLUWJAk8EAAEIADkWIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCaj9D3RsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDIACgkQIK0uxlsQLOLgpxAA1RNVJv+/B95y7Ja7uG6EkQvSfoqGq+l
 OAI6TQXR1iIfG7eeDfeqpdDWWEXBNfU/L/C7GfIN8Y3Ibr7hrSdvn64cfwctxdnje2nZhUxSu8e
 ACpBsIm1vj+XzT4rl1gWRGgLilo1xCHedZLgX+24tOxbWaYt0pZht4tIX6fMvMAeEFVPw6qt2cG
 hrqmtLuQtLxLPlEOi5M3MUKh/y1KqECP1eppSeKAfzWrqvrljHC+RDnpT9+pVh6thVp0ANDq9cf
 W+sMiJYdBmGwBrOAJ7NagBU9ePlPerphlwJ2mExMELXj0tz+yOoEa4rJcODSRw17lwS4jYczqgG
 RrZuaEG/8e0nusUiZj1LqtKGQ8cZWZ78dM2vwbEGKKcoK1lIifcO9/HzSZIuH9RR3k4fa5j+e4x
 STXSwrFDYWbZX5zgvbw+s+sUgcFHkBQP9LwQQ3RU5CbPVGVUoenJm6d8ucR+HQCIA9orszGEE9f
 DKDByc4QnDEdPOZdZHXzY5nttS55MYyI/z6M6yq5w4+Pyp2BzJBXaMmIUlqtZBWKvhZLhxBYzBb
 E+xPzZMQzFFJpWNgGiJhOQMuRIwsoabohSsHxNc1nnLBQ4OAHylJpEkIxbzv01fzn9xbm+tio04
 xabB6LmUE/Gc7flSfjkuhuTZ0XtHVcrlCmw/KgPaIFkQNweAib1A=
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

VKMS recently introduced a ConfigFS API to configure new devices.
Add proper ABI documentation.

Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 Documentation/ABI/testing/configfs-vkms | 118 ++++++++++++++++++++++++++++++++
 1 file changed, 118 insertions(+)

diff --git a/Documentation/ABI/testing/configfs-vkms b/Documentation/ABI/testing/configfs-vkms
new file mode 100644
index 000000000000..a1a3e186e50a
--- /dev/null
+++ b/Documentation/ABI/testing/configfs-vkms
@@ -0,0 +1,118 @@
+What:		/sys/kernel/config/vkms/
+Date:		Nov 2025
+Contact:	dri-devel@lists.freedesktop.org
+Description:
+        This group contains sub-groups corresponding to created
+	VKMS devices.
+
+What:		/sys/kernel/config/vkms/<device>
+Date:		Nov 2025
+Contact:	dri-devel@lists.freedesktop.org
+Description:
+	This group contains sub-groups corresponding to the VKMS
+	device <device>.
+
+What:		/sys/kernel/config/vkms/<device>/connectors
+Date:		Nov 2025
+Contact:	dri-devel@lists.freedesktop.org
+Description:
+	This group contains sub-groups corresponding to the
+	connectors of the VKMS device <device>.
+
+What:		/sys/kernel/config/vkms/<device>/connectors/<connector>
+Date:		Nov 2025
+Contact:	dri-devel@lists.freedesktop.org
+Description:
+	This group contains attributes corresponding to the
+	connector <connector> of the VKMS device <device>.
+
+What:		/sys/kernel/config/vkms/<device>/connectors/<connector>/status
+Date:		Nov 2025
+Contact:	dri-devel@lists.freedesktop.org
+Description:
+	Connection status of the connector. Possible values:
+	1 - connected, 2 - disconnected, 3 - unknown.
+
+What:		/sys/kernel/config/vkms/<device>/connectors/<connector>/possible_encoders
+Date:		Nov 2025
+Contact:	dri-devel@lists.freedesktop.org
+Description:
+	This group contains symbolic links to possible encoders
+	for this connector.
+
+What:		/sys/kernel/config/vkms/<device>/crtcs
+Date:		Nov 2025
+Contact:	dri-devel@lists.freedesktop.org
+Description:
+	This group contains sub-groups corresponding to the
+	CRTCs of the VKMS device <device>.
+
+What:		/sys/kernel/config/vkms/<device>/crtcs/<crtc>
+Date:		Nov 2025
+Contact:	dri-devel@lists.freedesktop.org
+Description:
+	This group contains attributes corresponding to the
+	CRTC <crtc> of the VKMS device <device>.
+
+What:		/sys/kernel/config/vkms/<device>/crtcs/<crtc>/writeback
+Date:		Nov 2025
+Contact:	dri-devel@lists.freedesktop.org
+Description:
+	Enable or disable writeback connector support for this
+	CRTC. Value: 1 - enabled, 0 - disabled.
+
+What:		/sys/kernel/config/vkms/<device>/encoders
+Date:		Nov 2025
+Contact:	dri-devel@lists.freedesktop.org
+Description:
+	This group contains sub-groups corresponding to the
+	encoders of the VKMS device <device>.
+
+What:		/sys/kernel/config/vkms/<device>/encoders/<encoder>
+Date:		Nov 2025
+Contact:	dri-devel@lists.freedesktop.org
+Description:
+	This group contains attributes corresponding to the
+	encoder <encoder> of the VKMS device <device>.
+
+What:		/sys/kernel/config/vkms/<device>/encoders/<encoder>/possible_crtcs
+Date:		Nov 2025
+Contact:	dri-devel@lists.freedesktop.org
+Description:
+	This group contains symbolic links to possible CRTCs
+	for this encoder.
+
+What:		/sys/kernel/config/vkms/<device>/planes
+Date:		Nov 2025
+Contact:	dri-devel@lists.freedesktop.org
+Description:
+	This group contains sub-groups corresponding to the
+	planes of the VKMS device <device>.
+
+What:		/sys/kernel/config/vkms/<device>/planes/<plane>
+Date:		Nov 2025
+Contact:	dri-devel@lists.freedesktop.org
+Description:
+	This group contains attributes corresponding to the
+	plane <plane> of the VKMS device <device>.
+
+What:		/sys/kernel/config/vkms/<device>/planes/<plane>/type
+Date:		Nov 2025
+Contact:	dri-devel@lists.freedesktop.org
+Description:
+	Plane type. Possible values: 0 - overlay, 1 - primary,
+	2 - cursor.
+
+What:		/sys/kernel/config/vkms/<device>/planes/<plane>/possible_crtcs
+Date:		Nov 2025
+Contact:	dri-devel@lists.freedesktop.org
+Description:
+	This group contains symbolic links to possible CRTCs
+	for this plane.
+
+What:		/sys/kernel/config/vkms/<device>/enabled
+Date:		Nov 2025
+Contact:	dri-devel@lists.freedesktop.org
+Description:
+	Enable or disable the VKMS device. Value: 1 - enabled,
+	0 - disabled.

-- 
2.54.0

