Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9227B606A334
	for <dri-devel@archiver.kernel.org>; Sat, 14 Nov 2026 16:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=R4g5YnZN
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D5D610E3D2;
	Sat, 14 Nov 2026 16:29:05 +0000 (UTC)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com
 [209.85.167.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E7A191127BD
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 20:25:58 +0000 (UTC)
Received: by mail-lf1-f47.google.com with SMTP id
 2adb3069b0e04-5c00c727a21so158046e87.1
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 12:25:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794601557; cv=none;
 d=google.com; s=arc-20260327;
 b=igXDRpuLk0DfjUJE862W4clYsMiu9UZpa6sPNHfMJYi6R8PtDwH+EtAvacypMbYgis
 d0j7x9WGynqZvktkpo5L0+5Eoc2VzToAODX0B2weh9iFLE9FrBmBiNvKhxGiLk5w1k4i
 fZAJv4rk1gHodDhgCdcvdoQ6b8FyzTpZ0GguFF53dC7QVMACZqM4D/Zn8tQ3RYiZ5eiN
 LIq1Q+Bx2wW0x3sK4L8aelaM5bmCk3bOz2a742X9WbdeDGLpaaQInMaHqRyiDmLfppe6
 E7URW/x36+wVImESL0iH2XpuunJ/qdbATWOLLl/i2jFGV3OI3qhIVC5I7myT/iTyGAdh
 xELQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=YavfHroeJbmr+VHcPmcN/QbM0vDy2kwirUjQA6La55g=;
 fh=vC7aa+XpCz7103AE2dt+8z1ikFOptaWubbxG2qwud0E=;
 b=httXPxritCPbTAZZ7uU3m435lVM6zg31nEicfzxgHeen9EOvSUy4Io1YyOR8Q109r2
 EA60YjQ6EWsbz+XUyvbgGgMT7FgD2pwYD2JOYWl9EAcic4M0dXmfgrDUkqc9YVfwLLwE
 ZRUqCjBw3MMAj7qzxNjoxhjabEPrkdHKeRqfJW2Yzro8Jj0MFfr/O2sNgZBRk0yGvQGf
 d0pGslsrWcb6c0ODQW2hlNW7nkIbzMLIab6nFZynjupTO7JDNucdvqlfRCZq3H5RwKA9
 P/Qgv952ew9gFz0i+QeE+grUt8t6T1wxP3p7yiUt0+21T6px1IdvVSnYb550GO22gV5r
 hUNw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794601557; x=1795206357; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=YavfHroeJbmr+VHcPmcN/QbM0vDy2kwirUjQA6La55g=;
 b=R4g5YnZN1RZ6DJzzOWfWDFR4D5EyV4u4wFy2Xxu97BfjF+j9mpeb1LDKvnrTb5i7TJ
 Hv8+bbGIpBIQ4G9WEzvn14d/WjJScRFhml1EAJQxyM5oGhz/POnDYpXSTlGZcp14XizY
 /VIUcuEOJ9fglK1++jS5XKaqI6O1M7zo5YQJJSk/pXlzg6afiJuxTI7vJQZfLDK2cpTH
 AFscUuvvnWheMnZ5EgNzaxubzYynr1SqX9Yn2wJVMBg4l/veoxOv5f9JUrMHOxeAUJrK
 O1j+RECk8tYLaYEpC1APEiZuMeVbtCYbr2M/3AyK8gpQ622/W0hDiFb+tHytpKSxLFm7
 JbCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794601557; x=1795206357;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=YavfHroeJbmr+VHcPmcN/QbM0vDy2kwirUjQA6La55g=;
 b=R0hjhZ0hdMz+Jg7VOYWsRqGUvkTBv545vJKQ8rdN2WEewRdpSdUWnQIXysIMua/LWe
 GFjRdv/0PPAXTOtid0h0kSj1ZV2Pa45SP45QXydNRrtj9pZMbCz+tc/IPUMebwJ3gXIz
 4FuNBiJ8qbCxfhKOIbTh3gzUPQe+JMvgcpl+yWpq0vrNwgvtZdRFVnVYlLKHd2Kc06iZ
 nU1N5eP0efB829MvSMo/EtRYHeJJsWNg1or8YvWCU0KRmVkZMYQQ+8JjN/Yaqr7X9nzk
 HUadWB9QaQmLb3b/k4YyE3/ZEKhZbULj8MaMMPzd8U4T5gW1fDHvpyIxnRZGRHrYH4YJ
 Op1Q==
X-Forwarded-Encrypted: i=1;
 AL+hErFNVsaaw0x47j4pPoRkzwoDrOArRdzbKYm7/5mquGVkBp2KWGhfWQJQUkV/dJbsC1Uatjwj81Dj0B8=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9ek8pjXNP/U9LaDD1mo+GG9KvovBxps6Y3KhLRG7G3t2siSKlQ
 OB74uXXt1IpG17C8YfN1kdglJ7rAQ6pDKRn77QzYfREg91K5Hk79Z9d+bSAFXC0tca1fQDpnpNM
 AXyF4cqLSLjYTVuNQCA3kLde0cW3s3Fw=
X-Gm-Gg: AYBFou24iXJtfmUZBKtnkHrQQf+bAcNClYBcfscRGqgKlWhzEblVJnO5/q5aJsAnpJG
 VBGEGuQkc+QDL/FupdKu2dC74DcHuFAsFbuJpQEJD+ATKJs5FPOHExyOujiOtZkGt0wGUSQE9gR
 pneweVLtUgv/FrJ+WQRhQoKPUa6PNocQJfSYUNiEsG9abMMX3LKoOp4GZp3dMuhiB6N2KQ4S3La
 JskUmIOLbneI4HNQ38vUnUw6wFjdVykRoZxSBqp2xSevQE151SsCBbJ8jMBbvYESrFWmy+BpyAW
 9rz65xb87aTxIqZpwR5iWbsekn6tb9cVZurge+PO4SnWXb7TxXPxactSUB6ILZAy+WPsSDnaf0j
 4hvQTDRCrt5+1t+1tTeZdwua73mUL3r+9kwH8GtN2MMDGX9NrRAGPmv3R4yWfW9iSzSc9+cSa
X-Received: by 2002:a05:6512:1326:b0:5bf:d00a:b6c0 with SMTP id
 2adb3069b0e04-5c17076e20cmr1778621e87.3.1794601556720; Fri, 13 Nov 2026
 12:25:56 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261112-vop2-fixes-v2-0-8218c1cf8ac8@gmail.com>
 <20261112-vop2-fixes-v2-4-8218c1cf8ac8@gmail.com>
 <380996af-b987-4854-8b52-a3a214b19e79@rock-chips.com>
In-Reply-To: <380996af-b987-4854-8b52-a3a214b19e79@rock-chips.com>
From: Arun Iyengar <aiyengar1990@gmail.com>
Date: Fri, 13 Nov 2026 12:25:44 -0800
X-Gm-Features: AclHuK9Z0XxZveIpcBwbR-1StXFvWIPfHqJtynCF1BYTTbRYTOBUF4wn1ddT13s
Message-ID: <CAEy9hNUnZkqyg95DsShdr7UF6CiQvKhpvJxrx0TSoq3do2nyEw@mail.gmail.com>
Subject: Re: [PATCH v2 4/9] drm/rockchip: vop2: Don't accept AFBC YTR for
 RGB565 on RK3588
To: Chaoyi Chen <chaoyi.chen@rock-chips.com>
Cc: Sandy Huang <hjc@rock-chips.com>,
 =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andyshrk@163.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Sascha Hauer <s.hauer@pengutronix.de>,
 Piotr Zalewski <pZ010001011111@proton.me>, 
 dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Sat, 14 Nov 2026 16:24:47 +0000
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
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Chaoyi,

> That' true. The TRM says RK3588 only support XRGB888/RGB888 AFBC YTR format.

v3 follows the TRM: YTR is only accepted for the 8 bit RGB formats, and
the comment is gone.

That also refuses XRGB2101010 with YTR, which displays correctly on my
board (AFBC 16x16 | SPARSE | YTR from the Mali-G610, HDMI and DP). May
the 10 bit formats keep YTR?

v3 5/8: https://lore.kernel.org/r/20261113-vop2-fixes-v3-5-08ae37e83b5c@gmail.com

Best regards,
Arun
