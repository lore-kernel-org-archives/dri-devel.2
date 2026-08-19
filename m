Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CF4CC5DF86
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 10:03:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED26D10E556;
	Wed, 19 Aug 2026 10:03:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mOiqqwWw";
	dkim-atps=neutral
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com
 [209.85.221.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B0FE410E556
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 10:03:22 +0000 (UTC)
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-4816084e128so112224f8f.3
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 03:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787133801; x=1787738601; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Ww10+OJo0719/xus/YZCQo06xfKOWmvT6qT+Uurk6l4=;
 b=mOiqqwWwtTK1z6R46SSc/jMxgOYnCxiTa9l7n/36JKV+0rI9ggZv4ij3SvNEXcXqNO
 QuKg4i2PEyN4sxPztObRosDdpEJKhrp32cvnVEUk3b+0pwLl8n4il8z/9Unq6mmBvVrN
 MuFVUxXLKKxJVFMXTishLNmGWFUYQgaZm3JE/SdUq0XxR6PnHJWG53pScvB/Y0C949nX
 v03v819Q/hDk7QlagAfbFGPRPy+VvGz8QktWFVobLX6xNYNxaC4MdC+iyQ1HiOKWmNF6
 5R9+9UbLTEcmR+VIZ/BarULIo+2n/Tno9FxYZUlU67HlIIPjytwDCdJQBMiBatFncQ7P
 Tlcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787133801; x=1787738601;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Ww10+OJo0719/xus/YZCQo06xfKOWmvT6qT+Uurk6l4=;
 b=rsInhLRK+2XV2AEPs27976gYjP19keh3BJJ2ad8LxC49eaPTcntot9FBWHcyanOqXL
 Na0NZO7zmtGpkHTavS24r9mqLcmHRZ5h1gQ6GGYIFl4b8nDK5nC6qBfGolReIamGeC4a
 oDy1TtfMrb98XfxSSMZiacRcP+ozJvodGvCMP7HTwichsfYFqFDw1re0uzWFfd38pp7i
 c6Ltd/SZ4Ah4xFTSETdmCjXTlw04vEs6x8i3WIuHLZwWHEpMZX1/SEAIJVaqkpXwJab1
 Xbs2fuxWIXrB7QS47rbd+60VcPIj+4qELc5GSpKLfaB98WRy2kMztS3O0AYPi+XQ4PRQ
 bxgA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrMxX+BNfDbp+iZ+2idW3mbi0KW3WGe+4co74UWx5NXSiRgDkyoFVSQerLjKRIX0yMBpg1dV+pVge8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxC37reKIQkEPyv2zT5pZboNp0k23Fx00F3CLCAidBl6rccaB4d
 J5X4i8HxlEg6RVnGRDRIl8jsIOO72mIExKPdpt1oemqpLYon7Vb7rj7g
X-Gm-Gg: AR+sD139nDleVBvtiq+/5ZxrothITG+OfVDOOiM2K02Nd5ekoJBvX4INssODEpExWsd
 eBGuyP1vsHuswUo34uY9pF8xlmNCilaGEIDFqULoqvE6fMfmXTKlzpkYVX5UBSWAIbrqvRPUuwN
 uaI0hTlEeVKGlWc1BzGMIwxVCTWx7f6PC0+wCGASjOAkMyUtr7i1jg9ng9FZiBXqq/uR0D0iIy5
 JF9slYWgzY+RgG98AbQPvDxfJ7ztMoQhUx/a+FA5tZcTe8RTs6sZOBQ1TOsmkNGhAtNyfCoj++a
 Wwmt6+vpp/3/oO4e93pQys3A29YBf/0+6VsMQTnfHXJf2dqBRPAccXWNM5EbACK4FTlJiDGAW34
 xm5KO20PIe3OcBexAtpGqYmhbSJGHD58fuFRjcXIASp6yuAlagGwAJ9gX0EwtZILLwieExosli7
 UAdtdgh8bcW47JaxLYd49yQTDMytorcMcqK/kp0VDxi6fLqsVy0Tqt7gkXB2uS3AYdV1CJbS+fp
 0Ag2eBan+3NcVMHixIT8gpW11nTpMHtQFplWLGJ+QSjkPo1lR1AKJaBCwt+IeTWU2eygQ==
X-Received: by 2002:a05:6000:385:b0:482:a902:bfb5 with SMTP id
 ffacd0b85a97d-482b1e07e79mr2759906f8f.0.1787133800795; 
 Wed, 19 Aug 2026 03:03:20 -0700 (PDT)
Received: from OrangePi5-Plus.BB-HOME
 (20014C4E1B92960062A31D8DDD4EA0DC.dsl.pool.telekom.hu.
 [2001:4c4e:1b92:9600:62a3:1d8d:dd4e:a0dc])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482b1441748sm4935688f8f.8.2026.08.19.03.03.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 03:03:20 -0700 (PDT)
From: Igor Paunovic <royalnet026@gmail.com>
To: support <support@armdesigner.com>
Cc: Igor Paunovic <royalnet026@gmail.com>, Sandy Huang <hjc@rock-chips.com>,
 Heiko Stuebner <heiko@sntech.de>, Andy Yan <andy.yan@rock-chips.com>,
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Chaoyi Chen <chaoyi.chen@rock-chips.com>,
 Alexey Charkov <alchark@flipper.net>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 linux-rockchip <linux-rockchip@lists.infradead.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] drm/rockchip: vop2: Scale the AXI clock to the
 bandwidth the mode needs
Date: Wed, 19 Aug 2026 12:02:47 +0200
Message-ID: <20260819100249.7945-1-royalnet026@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026081916331211222713@armdesigner.com>
References: <20260813154501.21332-1-royalnet026@gmail.com>
 <2026081916331211222713@armdesigner.com>
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

Hi Owen,

Thank you - and thank you for bringing this to the list. A fanless
RK3588J chassis at 60C ambient running dual HDMI plus DP is a far
stronger argument for scaling this clock than my bench ever was, and
the +3-5C junction delta at 750 MHz is exactly the number the
power/thermal side of this discussion was missing.

On your question - both, sequenced, because they answer different
questions:

- The BSP 6.1 48h soak first. That is your production reality and it
  needs no bring-up; what it buys is the real-world deployment
  evidence, and with your permission I will cite it in the v3 cover
  letter alongside the multi-CRTC tearing observation.

- The mainline clean-room run when your DTS bring-up is ready. v3 will
  be against drm-misc-next, and that run is the one I would attach
  your Tested-by to, so the tag attests the tree the patch actually
  targets. No rush on this one - if it lands during the v3 review
  cycle rather than before it, that is still perfect timing.

I will CC you on v3. It will state the FRL/ACLK relationship
explicitly (on my board the HDMI FRL path holds the clock at 750 MHz
independently, which is why the DP path was the one that exposed the
scaling gap), and it will pick one direction for commit_setup vs
commit_tail and defend it in the cover letter - the question to the
maintainers about a rockchip-wide hook pair is still open, and v3
cannot wait on it forever.

Regards,
Igor
