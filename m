Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58CAD60A380B
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 13:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=y7AjL9VH
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5BED810EE55;
	Mon,  2 Nov 2026 13:41:02 +0000 (UTC)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 464CC10EE75
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 13:40:54 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-4a1b07c3c5fso25045485e9.1
 for <dri-devel@lists.freedesktop.org>; Mon, 02 Nov 2026 05:40:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793626853; x=1794231653; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=up8MQ9r1m3V+JH2R7D4OF66kNdk3l8gmYgfzB1Td7Q0=;
 b=y7AjL9VHQh8dYlFFtqKdGSbQCIkveKss+pA/9y1q9UjfMSX2tj+9XAZ0G9BaKzfIaF
 UWslGKG9qVyWsGzuBJDenK4MHDtcQ/ghvU1OdLyxdJ7t7Fk7WH+bhOQgJAXxgBvJzdDU
 /n5oeRfO95I21j22l6bCwNiN8gW7wnsL8Ms8XmVcYq3hWf0y35gpOQQZV2XfCysY8ey1
 vfa/x+Wfsb5N2HpXQiMvPiESDyuzT4L0LS518861VXNOSSt1mZr7GyL3LOq9uMV4xrRU
 aDN3Dtgw8e676Rh+H8vXxnGeLrHo5WyoLBDqjnaK+5sbOCDjB5SX6SsMh6WmQJZ2y2pN
 NKew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793626853; x=1794231653;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=up8MQ9r1m3V+JH2R7D4OF66kNdk3l8gmYgfzB1Td7Q0=;
 b=urYl23ZL26+X+4bCZkVmOiUgxufz6oLjayYfL0DzQYjvaDP1zw+1PmpNMK/qXEnzAz
 3S4RYVLIpOaUg2MVLxbdprJJezYBm7R/Mj6QosR1h4hDxF21m3zXO8VTqmwwy5OMmCb2
 EDrEXz/uKJd+/RTuFmBT60ZQyU9kUo9YVPTpnbqkjKLDCHIXyDS8/fq4nsNgFi2gV42S
 h9dovmVTvrX4c+PegKLpHD2vpogrVq4mdG7+HohybbkO/6TBzrBS7oDO26XV+ydO00vr
 Mbo7hNS3tc7809uoRZBnNzWamGxutvoFpIHUlWg28eDVU+X4hAVmb/4xzc72HUqtVhpd
 URbA==
X-Forwarded-Encrypted: i=1;
 AKwUvBznaWCq6GEQ19ZGP2IkPtI7rLthp7hpdp7nIC2X58ZQH2CByPOOgRNxN2QTnTFeqGCbBTJ90P69SfM=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIwADJVeRyokFMS0AGGi0IgSYgl1Hx70cbsEpHwI2h/qctZSEJT
 McJ3u/Q1qYsdhGqO1U66fE0OSBkXHaBcTUEVGVfXEFl8ktfPkH14pVFIXZB1ofDIWfE=
X-Gm-Gg: AYBFou1rloWIVGOOQp10BmPcEbT0yayTSdE3E09FlQDLXvXLSPdFDZBqpbwA4GLIjCW
 0mzAmR0BGpr14vV/jP4D5SFZwZ1AFUrqKC/9A9dJbtOaCECKQaduidCbr45G4ctnRSXzUezu38h
 bahzh0uGmXxcoXRxrU9yLqD3wpm7v/LiCQeo5n3cwUeXAqXPD2SbRJbDGzck1/P9v3G4IJ+lkO9
 PNxDtZO6uGHa5BXAig7jpj75l/zYRhetylqeG5PtMszYQDwR5JVdsdkEt/WxRY2wXWuo7RZl/ZX
 36c8Ih+DGoZXH5EMBGR9JLz5vHB/2v+WoerhFfinJpKGdRqjkcIJL4jyukpVRApZXKGs81Bogi7
 ZCTuIH/w+ykeOkRUGbf/N1my2AZUBiQ9NBN2c8eC3gRzR09oNk6R+D+phe37be42O3b1rDId1yB
 uWkb6uGx+6tkfAMc+rKpaJPmflz26sM9kvTKPNtJiwOE4zUG0CY7jRIV+mH7Ffm5kCmTGRX37f5
 nCtT9cp525V0VGi5FY3M5beEswZrq361ZszXQH19jDEPByHW8P6t/VlRbXeyavI1/FSL+t2glrJ
 OW5+7wMfdl03KZHCrfOK1s10yGh3+ohNzbvvHg6XDicV5BsMg/lMJLJtmfUT6U6Wfl3/ZvY=
X-Received: by 2002:a05:600c:8b01:b0:4a2:74f:46c1 with SMTP id
 5b1f17b1804b1-4ac1737c682mr237096875e9.8.1793626852420; 
 Mon, 02 Nov 2026 05:40:52 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4abea533a1esm189194605e9.1.2026.11.02.05.40.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 05:40:50 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Icenowy Zheng <zhengxingda@iscas.ac.cn>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, Icenowy Zheng <uwu@icenowy.me>, 
 Han Gao <gaohan@iscas.ac.cn>
In-Reply-To: <20261030-mj070bi30ia2-v1-0-a0f65b65c290@iscas.ac.cn>
References: <20261030-mj070bi30ia2-v1-0-a0f65b65c290@iscas.ac.cn>
Subject: Re: [PATCH 0/4] drm/panel: ili9881c: add support for Mingjun
 MJ070BI30IA2
Message-Id: <179362684913.3310106.12917918779608270334.b4-ty@b4>
Date: Mon, 02 Nov 2026 14:40:49 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2
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
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

On Fri, 30 Oct 2026 13:44:11 +0800, Icenowy Zheng wrote:
> Mingjun MJ070BI30IA2 is a LCD panel used by the Lichee Console 4A
> device, with a initialization sequence matching other ILI9881C
> sequences.
> 
> In addition to the normal binding + sequence panel adding part, this
> patchset contains one extra patch trying to address a hardware quirk of
> Lichee Console 4A -- the panel could never be really powered off /
> reseted in hardware (the reset pin isn't wired to the mainboard, and the
> panel is powered with a always-on regulator).
> 
> [...]

Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-next)

[1/4] dt-bindings: vendor-prefixes: add Shenzhen Mingjun Optoelectronics
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/f423a211f99ca820c2c99a84a3418aa505d6dd02
[2/4] dt-bindings: ili9881c: add compatible string for Mingjun MJ070BI30IA2
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/ea74b623855291e60835c0f7fa7a29673332ad41
[3/4] drm/panel: ilitek-ili9881c: add Mingjun MJ070BI30IA2
      (no commit info)
[4/4] drm/panel: ilitek-ili9881c: do a soft reset in unprepare callback
      (no commit info)

-- 
Neil

