Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4632C982F1
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 08:56:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2746710EC01;
	Tue, 22 Sep 2026 08:56:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jTdpSV2F";
	dkim-atps=neutral
Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com
 [74.125.225.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D416A10EC01
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 08:56:04 +0000 (UTC)
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49cfbdac7a1so1799075e9.1
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 01:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790067363; x=1790672163; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jHvRFtQyx9UQ53om8i4AUQfufcwc3sWn9Gux2Mdm/VQ=;
 b=jTdpSV2F3QAQfqtiYsbZXHKvB3LU2G6he4G03Hu6+/WwNlt9nd2qrThFvP9GtYDzIe
 fTR4ScXPvSrWe6ctkwjDs4YRo5JKZNeXJ1ux93V3ftcnyM90JbxsIc2vPf5vlE1ba+t1
 0URpyd8GYClDtyp83Iq9jDKbOPlZuFzwhYBT509yJkmyIMACuneDTH1X+3r2y+mgxwYO
 RclYPnC9qwbhsUWYEf2D/3bvOgRUVKhNlVukJCnl26AGoGO1xyd+u6f+e6H4Kpd4X+VB
 t+QsW//GEtdIsvA3h5ogM7PNelTBJ/CQtRj+dPe+5nTwHtcE2pz5TYtMe6K8zl6SZAqI
 GsiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790067363; x=1790672163;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=jHvRFtQyx9UQ53om8i4AUQfufcwc3sWn9Gux2Mdm/VQ=;
 b=lkQ8fE5eyDvqd9CsoqIkXMcAerWHwADcSsjLcelnjZIh/m7klWAGnIIHqlw8UcE1WD
 /Tn8H8DqC9/Nf6qLgHw1l+t/hFkFsNa2L1oLMfSQ6i0ZTzpD4l5Mkb6GWtHbJMTPICcI
 nCKN5jORFQe0a+igf8eM+kyUwxSiNKoMDmbexN10XTopL4MZWfQeTs+TkhMIOPHlzwcT
 Fjda4HwMejJXtk5/jrh1l8QrwsvE+i+0ZNuac1fV+oZUgyMl42DTk4/mqCmlRielXiyp
 5+xXnFSTzPOVDMdNYLeKPBiIXzaffIYSNF3jUy8KoWRZtS4nb+m+dqY+tC4W3Ku5E7Wb
 uQ7g==
X-Forwarded-Encrypted: i=1;
 AKwUvBzUJu+EDM+6gZmxZE7Q/FW8CgShrBb7sCZG7llT3o8zR+bNpPQrQi2bzNY4XSl7nrhTE2BR/9tuRkc=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mvj+ISYUfaopSz7jFgnhTFVzVnYZ1cauAX2tAtLzu3MzHEtmjt
 FKPIN/O+fOG2hhuB2fEjvY9prqsfKwCGLy2W39XhQHH7NXN5AD3wQeeV
X-Gm-Gg: AYBFou3zjQ2Pt/HRGw6447irKmntn6hxf6En5j1OKQPAgewQ5f6IHtBowf4AFZpy7tT
 v8fu6+c+lds+YoM46Tr+2qCMvqvi1QPG4q0qcwbcNEfdRZNdBMJ/IKStp6IVI7z4Y02OI9Q4m+Z
 y7deUJbTVEBy5w1Gnqc5iaycahcy4PhyV6chVd/v/v2xdnVIGetJcgpXcz0Dg2HjutHpgVyIJ5N
 6XaViCtooHR+Ath1HKNwMcFBs6azrObag6HWDUu2EuXsz3V0nFncej5NnVvO9jOrzygj4rB/uhT
 meDxuhP+mrOCU5GofJ3GiMz9pR1etSp33vkccKbSsgIlUsXbd7Xr8OiJMwz6+SU7eukvBNxbOP3
 zx148AjBSZCCNnV3urfbdZjZTLCO2MWVsTnkWq24wCk4iWSJCuD7ARwMtaCiWxwuCuNZgrDqN2Z
 f+f5FCKR37AWIXJ3SDbZ8Z5xfT2NKG1xV34927gVZwA70UlsItQkYXh1OhbbtG3thKFQ/d5MyMy
 q1LRVsQYuR/3pq4YUnXmb8ygPPXaNie8il34bVKfirbj9miIb88oOLSLLI37lgQpfUuZh/5gSmo
 iV0=
X-Received: by 2002:a05:600c:1c13:b0:49e:7186:f36e with SMTP id
 5b1f17b1804b1-49fc7dc1e75mr211705895e9.1.1790067363190; 
 Tue, 22 Sep 2026 01:56:03 -0700 (PDT)
Received: from OrangePi5-Plus.BB-HOME
 (20014C4E1B80530056971C6280202175.dsl.pool.telekom.hu.
 [2001:4c4e:1b80:5300:5697:1c62:8020:2175])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4886277e611sm3538781f8f.18.2026.09.22.01.56.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Sep 2026 01:56:02 -0700 (PDT)
From: Igor Paunovic <royalnet026@gmail.com>
To: Tomeu Vizoso <tomeu@tomeuvizoso.net>, Oded Gabbay <ogabbay@kernel.org>,
 Heiko Stuebner <heiko@sntech.de>
Cc: Igor Paunovic <royalnet026@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
 Robert Foss <rfoss@kernel.org>, Sidong Yang <sidong.yang@furiosa.ai>,
 Diederik de Haas <diederik@cknow-tech.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Jiaxing Hu <gahing@gahingwoo.com>, Nicolas Dufresne <nicolas@ndufresne.ca>,
 Jonas Karlman <jonas@kwiboo.se>, Guangshuo Li <lgs201920130244@gmail.com>,
 =?UTF-8?q?H=C3=BCseyin=20BIYIK?= <boogiepop@gmx.com>,
 dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 08/11] accel/rocket: restore the NPU clock boot rate
 before powering the cores down
Date: Tue, 22 Sep 2026 10:55:37 +0200
Message-ID: <20260922085537.53363-1-royalnet026@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260922081326.B46651F000FF@smtp.kernel.org>
References: <20260922080114.44662-1-royalnet026@gmail.com>
 <20260922080114.44662-9-royalnet026@gmail.com>
 <20260922081326.B46651F000FF@smtp.kernel.org>
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

On the shutdown question from the Sashiko review of this patch:

The gap is real, but it predates this patch. The driver in drm-misc-next
has no .shutdown callback at all, so a reboot or kexec with a job in
flight already leaves the cores running today. The callback added here
takes the devfreq device down and puts the clock back to its boot rate;
it does not stop, drain or reset the cores.

Quiescing the cores on shutdown (stopping the schedulers and resetting
the cores through rocket_core_reset()) is part of the same teardown work
as the use-after-free under "Not done" in the cover letter, where a core
is unbound while clients submit: both need the driver to stop its
schedulers and cores while files are still open. I would rather fix
both in one follow-up, once Tomeu has said which way he wants the
teardown to go.

Igor
