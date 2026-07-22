Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B039C44536
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 14:28:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5945E10EE04;
	Wed, 22 Jul 2026 14:28:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="TAYABZjn";
	dkim-atps=neutral
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1BD5A10EE04
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 14:28:49 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-495635a85d2so26027515e9.0
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 07:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784730527; x=1785335327; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ePYWD2iTRHxJu1GtsXub1IW6UWPr8JBMi02BG2MjH5Y=;
 b=TAYABZjngWk2ZAPZdjqqkFqlOWR5Yvv5A4t3X3ddElnNOxCG4xn6acCF7OJObZL9eS
 wCRSrVkZmrGO+RrTjNHvq6wPSHMz/cOd2tbVznIonDvIgs9OT72mdNaGafZ4Jc4iy3fq
 xuDpVzOVvC3NwPaYvwVlBrEqqAFnRug1F7UROwI3kSrFpHzyPJRngi1shXaZHBU3KO9p
 HUkH9N0NAJBWAWHp7BCkYrnYU2BQNBUDxmkDfQlh2EuOxkXWhDIw03tEbfZRIG4FpUl5
 6OkKLg3a7AqYdsz+SHUOJ8Hog7HSZOz6OLA/Ac/w3RNZMU4adsauwotNv59CoIhv4mDW
 zqyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784730527; x=1785335327;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ePYWD2iTRHxJu1GtsXub1IW6UWPr8JBMi02BG2MjH5Y=;
 b=AEJcz3Yul1/COPzVnySUmRK2+zmJw4bwZ+dnYiJrqwQvcUS/i5sAdxIfUmk5oD8SoY
 LDmvdNjt2g+aW89AUEYdZi7fqPtCLDI8p/K4V8EV8VDFos3hWMJaN7fwuS6eJGDlZQ6I
 +YByHlCodjjkPdacKhB7HdOhWhh7FvzqeLZzSpocHPVTDHGhbAbb5zyIOyXivYEwRYbU
 4DrC+tVza5rtttVUdYBYkSQYp3m8U9ZsEtcXJ6j1nvsgp2bX2qWlxtKvgj8NX7VmK7wJ
 OaY3SzjIm95M1Q2pfBdOtlJsRwNbsVTWDNwH+Vej4HDCPEQLxo9tjgSHTKpxBRyY0w/v
 TmKA==
X-Forwarded-Encrypted: i=1;
 AHgh+RpKDzWgcDNcCFvhI2ynJViggtUelMH2/9UQCNWIJtoBcuNQEz3iGSY/IWKVZ8BZxxzQLr8YKi1mn30=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwV/oqpWlBFrk9HpE26eMmkkVGSGDpYuru5O6TSOstajXkTwkCN
 XYv+YYFk48LaKIzx1GVbDQ9FBXZsHysfIK8ej/NNsR79jeefMmY3ZSsaoPGtMAYBr+QVfxOYh++
 Tgb82
X-Gm-Gg: AR+sD12imu8j+3iOzf0pQ3XGpZ9X2MuM8w8olwHxqgqlnwiRU/oOquaIoBlq4YGSkwc
 O7DoxMA5hMWWNQJMonJ5SCHANIh6OjmpHYiDz9Y90IGP+VjUvTXqBgPXHQpAs+es7Prw2s/+uVW
 0KWumLH2DQNCYyTb2FZ2Ac6E9rYdvmH2O3vQG98Mkkg5WP3+HtehYZ+Rvz0Kz9oubo7txTz8o6g
 DFilMdxD6Ia3oJgxGzgl9SD0DIrgJdO8UMQbIQNyoN1nz4m48/o4dg9KyRUuKM76EVdtaWRrKSZ
 OGtYlrBTuNzh9Ek6KyzAn6RmaWEXZOsry0zZyk2oAM8yueyafSJ3iSqO4iR5iDn+z0HINX7u/yB
 s3rDFerxjAa6S2ykmphBUklPwN/nLez1vFXvh2aN2xP8oOIVYnDXG0lnx5+Q/pKA2/u8BkVXQ8U
 lppgd7147ihNh/xHi73TIivoc=
X-Received: by 2002:a05:600c:4755:b0:493:c2cc:aecb with SMTP id
 5b1f17b1804b1-4954a51590fmr286003695e9.38.1784730527209; 
 Wed, 22 Jul 2026 07:28:47 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4956537c7desm218995045e9.7.2026.07.22.07.28.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 07:28:46 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: laurent.pinchart@ideasonboard.com, jesszhan0024@gmail.com, 
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
 airlied@gmail.com, simona@ffwll.ch, robh@kernel.org, krzk+dt@kernel.org, 
 conor+dt@kernel.org, nm@ti.com, vigneshr@ti.com, kristo@kernel.org, 
 prabhakar.mahadev-lad.rj@bp.renesas.com, thierry.reding@gmail.com, 
 sam@ravnborg.org, Leonardo Costa <leoreis.costa@gmail.com>
Cc: leonardo.costa@toradex.com, dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org
In-Reply-To: <20260623195741.495734-1-leoreis.costa@gmail.com>
References: <20260623195741.495734-1-leoreis.costa@gmail.com>
Subject: Re: (subset) [PATCH 0/5] arm64: dts: ti: k3-am62-verdin: Add
 Toradex Capacitive Touch Display 10.1" LVDS
Message-Id: <178473052640.1949706.11360946998734187321.b4-ty@b4>
Date: Wed, 22 Jul 2026 16:28:46 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.1
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

On Tue, 23 Jun 2026 16:57:36 -0300, Leonardo Costa wrote:
> From: Leonardo Costa <leonardo.costa@toradex.com>
> 
> This series adds device tree overlays for Toradex Capacitive
> Touch Display 10.1" LVDS V2 on Verdin AM62.
> 
> The display addition covers two interface types:
> 
> [...]

Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-next)

[2/5] dt-bindings: display: panel-lvds: Add compatible for Opto Logic SCX1001511GGC49
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/6ce748682f746a0c1ae311191fb820b08151ddb6

-- 
Neil

