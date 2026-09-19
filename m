Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEDD6C982D8
	for <dri-devel@archiver.kernel.org>; Sat, 19 Sep 2026 14:25:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A8A910E14D;
	Sat, 19 Sep 2026 14:25:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=tuxon.dev header.i=@tuxon.dev header.b="XhyLziy6";
	dkim-atps=neutral
Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com
 [74.125.225.141])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E17610E14D
 for <dri-devel@lists.freedesktop.org>; Sat, 19 Sep 2026 14:25:04 +0000 (UTC)
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-49b965f447cso13687285e9.3
 for <dri-devel@lists.freedesktop.org>; Sat, 19 Sep 2026 07:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tuxon.dev; s=google; t=1789827902; x=1790432702; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=VpdVAxuNOwmWu0WfirEONZSR+j3md2xsgnrcoSx6gSA=;
 b=XhyLziy69kn16r68tx4RupPh2AwkL5VyZG1FK8sBz5rT1bku8SMKQ/sVZ0eVpRYmws
 Oci7UJ0Qu/e4ZtduZnx7eEoVXtpJPfkfX04Ro8WdxYQckyJU8+9L1Z5kQmb+2z+Axoav
 6akmcadg7qworg+/THf0VU7k4gfFCXNWpFTtlY+CBGqGxiI9NAAAGuxH+DCO90nM6vBJ
 XGhiDMlv6cV3rw/4OreGbZmkzM1lnGrdfwiTZiQoJSMSaOB01cclZkzSWFYhjRwOHu8U
 ZqgXtsV6a52ZcjZHe3ND56mc9puEOfvKddFNykG6LnDLYboJIVwYOXLiK4zLYIV8YAR6
 yR3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789827902; x=1790432702;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VpdVAxuNOwmWu0WfirEONZSR+j3md2xsgnrcoSx6gSA=;
 b=jT2aNvBI6yI8GoyosIj/YhyYi5neJ/OD4X9u0JJX1Rp4RZyy7T/4spD5jEFbE2/2uW
 qker3goy4v1twwYXFcbuAZPSEO7lW2ZDDjmT2FkUIE7iU0DNEDU3chD6o55hGsr2BivX
 rz4LGtQi4DyB9ejWAC1MhwWQ67GRMVTXpgYZxITZf+iaDXejRAU1B5LSlYHAec0QrpMG
 CxkNsXw6eW9MJhb9WPE1+INGSlPS/bgL/7zclpZXF9OrKbmhNnVjXl4htO+/WxFQCbLk
 vPGQAOjtP4F7aobSeFbF/Y6s3tHmszAA+zMyAjUQdzEhDYpDkbdkxd5TF6a+CiLNvik0
 F2Dg==
X-Gm-Message-State: AFuF++ka+lqQnMZTUTAGVM5CLc7lY1sWdnC3qTwpmgPnKs4/Fm2kb6D6
 7EjoZ4WCERVfzY8obNMx1arjqroTL466EeTINuas/xnC6UmkfhKa4DyU9XvH7zAEy1E=
X-Gm-Gg: AYBFou1IO+jnm6oN+bXyMwakbCHNXKHWTDh+TcmEAuy8finX9H8sBDH3zZdV6nPa6iy
 nxcfQoxRB+ETb07XGPDUhcHI8kshb6Bx5PcwYCCkIrdI43EDXJBU3rYrJakZF0NEGAMBsjwtcRU
 1cifbIGYn3LHJyOavNvRoeRkBzBZv1ZEYqP+w83l56xCVBLtpd0sFcoT/4Hz2iwHDWywhS3K75f
 VDrcLJ73NlLE3XEgFXHfbbx7BPEgpPoYn87e13x4IqDs8THgNf6JkFTVRxzTRjH7I7CGzqsxHB6
 AbdMXbx8oj4NL2xItDEn3hJK3+20I8jXDoHSmPzFZJWgL8bp4aaUd50Rh0vrWmLyk+4DwakHiJi
 0JdNqIKBcHBCezbsM/Z/wVwDJUMHVAkdST1QwZNCAEuyLkQcQHB8X53XKQ/0+oWQ5q7SxD5T+X5
 OGYD2GV0Y80kGENyFHNj7vm/+R+yIbmXeJjdgTst7l93yZTpzpy3P6cTtRvrYH9i56oQ6xKw0Wq
 /5V0sMphlwAtL5ruOsBRAtdY/wRS8Wn6VGl8xQZlrpHd7eflae7C5I=
X-Received: by 2002:a05:600c:1d29:b0:49e:7c8c:361d with SMTP id
 5b1f17b1804b1-49fc572b7afmr84151565e9.22.1789827902455; 
 Sat, 19 Sep 2026 07:25:02 -0700 (PDT)
Received: from ?IPV6:2a02:2f05:1204:e000:2cf7:c250:64a9:ae77?
 ([2a02:2f05:1204:e000:2cf7:c250:64a9:ae77])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fcd090f0csm106948995e9.15.2026.09.19.07.25.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 19 Sep 2026 07:25:01 -0700 (PDT)
Message-ID: <111e4f31-1c2b-4e7b-ab8b-534544d2ae22@tuxon.dev>
Date: Sat, 19 Sep 2026 17:24:59 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 3/5] ARM: dts: microchip: sam9x60: Add GFX2D GPU
To: Cyrille Pitchen <cyrille.pitchen@microchip.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Russell King <linux@armlinux.org.uk>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Manikandan Muralidharan <manikandan.m@microchip.com>
References: <20260828-cpitchen-mainline_gfx2d-v8-0-378374559738@microchip.com>
 <20260828-cpitchen-mainline_gfx2d-v8-3-378374559738@microchip.com>
Content-Language: en-US
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20260828-cpitchen-mainline_gfx2d-v8-3-378374559738@microchip.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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



On 8/28/26 18:52, Cyrille Pitchen wrote:
> Add support for the GFX2D GPU.
> 
> Reviewed-by: Manikandan Muralidharan<manikandan.m@microchip.com>
> Signed-off-by: Cyrille Pitchen<cyrille.pitchen@microchip.com>

Reviewed-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
